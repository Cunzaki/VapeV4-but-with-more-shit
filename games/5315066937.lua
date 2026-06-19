--[[
	Ugc 5315066937 — MV gain boost (modernized _G.Wtf / 2.7 constant patch).

	RE: GameMechanics default mv = 2.7 (Styles u4). Air strafe cap reads StyleInfo.mv
	(Module_67 u252). SetStyle → CreateStyleInfo on every sync, so patching StyleInfo
	alone or Phys velocity does not stick / causes rescues.

	Old exploit: debug.setconstant on a closure whose constant[1] == 2.7 (nups == 1).
	That targeted the default-mv path inside style creation. We replicate via:
	  1) Hook Styles.CreateStyleInfo (primary — survives SetStyle / SyncState)
	  2) Expanded debug.setconstant scan (legacy bytecode path)
	  3) Re-apply on all live GameMechanics + View StyleInfo each tick
]]

local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[UGC531]', err)
	end
end

local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local runService = cloneref(game:GetService('RunService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local extras = vape.Categories.Extras

local DEFAULT_MV = 2.7

local boostActive = false
local boostMultiplier = 1.3

local state = {
	styleBaselines = {},
	defaultTemplate = nil,
	defaultTemplateMv = nil,
	createStyleHooked = false,
	createStyleOrig = nil,
	constantPatches = {},
	constantScanDone = false,
}

local function obtain(name)
	return _G.obtain and _G.obtain(name) or nil
end

local function looksLikeDefaultStyle(t)
	return type(t) == 'table'
		and t.mv == DEFAULT_MV
		and t.tickrate == 100
		and t.autohop == true
		and t.allow_timescale == false
end

local function looksLikeGameMechanics(t)
	return type(t) == 'table'
		and type(t.SetStyle) == 'function'
		and type(t.StyleInfo) == 'table'
		and type(t.Simulation) == 'table'
end

local function styleKey(styleId, gameId)
	return tostring(styleId) .. '|' .. tostring(gameId or '')
end

local function rememberBaseline(styleId, gameId, mv)
	if type(mv) ~= 'number' then
		return
	end
	local key = styleKey(styleId or 1, gameId)
	if state.styleBaselines[key] then
		return state.styleBaselines[key]
	end
	state.styleBaselines[key] = mv
	return mv
end

local function applyMvToStyleInfo(si, styleId, gameId)
	if not si or type(si.mv) ~= 'number' then
		return
	end
	local id = styleId or si.id
	local key = styleKey(id, gameId)
	if not state.styleBaselines[key] then
		local raw = si.mv
		if boostActive and boostMultiplier > 1 and raw > DEFAULT_MV * 0.99 then
			local guess = raw / boostMultiplier
			if guess >= DEFAULT_MV * 0.85 and guess <= DEFAULT_MV * 1.15 then
				raw = guess
			end
		end
		state.styleBaselines[key] = raw
	end
	if boostActive and boostMultiplier > 1 then
		si.mv = state.styleBaselines[key] * boostMultiplier
	else
		si.mv = state.styleBaselines[key]
	end
end

local function hookCreateStyleInfo()
	if state.createStyleHooked then
		return true
	end
	local styles = obtain('Styles')
	if (not styles or type(styles.CreateStyleInfo) ~= 'function') then
		styles = obtain('GameMechanics')
	end
	if not styles or type(styles.CreateStyleInfo) ~= 'function' then
		return false
	end
	state.createStyleOrig = styles.CreateStyleInfo
	styles.CreateStyleInfo = function(styleId, gameId)
		local info = state.createStyleOrig(styleId, gameId)
		if info and type(info.mv) == 'number' then
			rememberBaseline(styleId, gameId, info.mv)
			applyMvToStyleInfo(info, styleId, gameId)
		end
		return info
	end
	state.createStyleHooked = true
	return true
end

local function unhookCreateStyleInfo()
	local styles = obtain('Styles') or obtain('GameMechanics')
	if styles and state.createStyleOrig then
		styles.CreateStyleInfo = state.createStyleOrig
	end
	state.createStyleHooked = false
	state.createStyleOrig = nil
end

local function restoreConstantPatches()
	if not debug or not debug.setconstant then
		return
	end
	for func, entries in state.constantPatches do
		for idx, original in entries do
			pcall(function()
				debug.setconstant(func, idx, original)
			end)
		end
	end
	state.constantPatches = {}
	state.constantScanDone = false
end

local function patchConstantAt(func, idx, originalValue)
	if not debug or not debug.setconstant then
		return false
	end
	if not state.constantPatches[func] then
		state.constantPatches[func] = {}
	end
	if state.constantPatches[func][idx] == nil then
		state.constantPatches[func][idx] = originalValue
	end
	local target = originalValue * boostMultiplier
	pcall(function()
		debug.setconstant(func, idx, target)
	end)
	return true
end

local function scanMvConstantFunctions(force)
	if not getgc or not debug or not debug.getconstants or not debug.getinfo then
		return 0
	end
	if state.constantScanDone and not force then
		return 0
	end

	local patched = 0

	local function tryPatchFunction(v)
		local ok, info = pcall(debug.getinfo, v)
		if not ok or type(info) ~= 'table' then
			return
		end
		local okC, constants = pcall(debug.getconstants, v)
		if not okC or type(constants) ~= 'table' then
			return
		end

		-- Exact signature from the old working script
		if constants[1] == DEFAULT_MV and info.nups == 1 then
			if patchConstantAt(v, 1, DEFAULT_MV) then
				patched += 1
			end
			return
		end

		-- Game update fallback: small closures still carrying default mv
		if info.nups and info.nups <= 2 then
			for idx, val in constants do
				if val == DEFAULT_MV and type(idx) == 'number' then
					if patchConstantAt(v, idx, DEFAULT_MV) then
						patched += 1
					end
				end
			end
		end
	end

	for _, v in getgc() do
		if type(v) == 'function' then
			pcall(tryPatchFunction, v)
		end
	end

	if patched > 0 then
		state.constantScanDone = true
	end
	return patched
end

local function refreshConstantPatches()
	if not boostActive or boostMultiplier <= 1 then
		return
	end
	for func, entries in state.constantPatches do
		for idx, original in entries do
			pcall(function()
				debug.setconstant(func, idx, original * boostMultiplier)
			end)
		end
	end
end

local function patchDefaultTemplate()
	if not getgc then
		return
	end
	for _, obj in getgc(true) do
		if looksLikeDefaultStyle(obj) then
			if not state.defaultTemplate then
				state.defaultTemplate = obj
				state.defaultTemplateMv = obj.mv
			end
			if boostActive and boostMultiplier > 1 then
				obj.mv = (state.defaultTemplateMv or DEFAULT_MV) * boostMultiplier
			elseif state.defaultTemplateMv then
				obj.mv = state.defaultTemplateMv
			end
		end
	end
end

local function patchAllLiveStyleInfo()
	if not getgc then
		return 0
	end
	local count = 0
	for _, obj in getgc(true) do
		if type(obj) == 'table' and type(obj.mv) == 'number' and type(obj.id) == 'number' then
			if obj.tickrate == 100 or obj.autohop ~= nil or obj.allow_strafe ~= nil then
				if boostActive and boostMultiplier > 1 then
					applyMvToStyleInfo(obj, obj.id, nil)
					count += 1
				end
			end
		end
		if looksLikeGameMechanics(obj) then
			local si = obj.StyleInfo
			local mapInfo = obj.MapInfo
			local gameId = mapInfo and mapInfo.GameID
			if boostActive and boostMultiplier > 1 then
				applyMvToStyleInfo(si, obj.Style, gameId)
				count += 1
			end
		end
		if type(obj) == 'table' and (obj.Player == 'Local' or obj.Player == lplr) and type(obj.StyleInfo) == 'table' then
			if boostActive and boostMultiplier > 1 then
				applyMvToStyleInfo(obj.StyleInfo, obj.StyleInfo.id, nil)
				count += 1
			end
		end
	end
	return count
end

local function reapplyStyleOnMechanics()
	if not getgc then
		return
	end
	for _, obj in getgc(true) do
		if looksLikeGameMechanics(obj) and type(obj.Style) == 'number' then
			pcall(function()
				obj:SetStyle(obj.Style)
			end)
		end
	end
end

local function installBoost()
	hookCreateStyleInfo()
	patchDefaultTemplate()
	scanMvConstantFunctions(true)
	patchAllLiveStyleInfo()
end

local function teardown()
	boostActive = false
	unhookCreateStyleInfo()
	restoreConstantPatches()
	if state.defaultTemplate and state.defaultTemplateMv then
		state.defaultTemplate.mv = state.defaultTemplateMv
	end
	reapplyStyleOnMechanics()
end

run(function()
	local scanAttempts = 0

	lplr.CharacterAdded:Connect(function()
		if boostActive then
			state.constantScanDone = false
			task.defer(installBoost)
		end
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			if callback then
				boostActive = true
				scanAttempts = 0
				state.constantScanDone = false
				installBoost()
				if not state.createStyleHooked then
					pcall(function()
						vape:CreateNotification(
							'Speed Boost',
							'Waiting for Styles module — enter a map if mv boost has no effect.',
							4
						)
					end)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not boostActive then
						return
					end
					pcall(function()
						if not state.createStyleHooked then
							hookCreateStyleInfo()
						end
						if not state.constantScanDone and scanAttempts < 120 then
							scanAttempts += 1
							if scanAttempts % 10 == 0 then
								scanMvConstantFunctions(true)
							end
						end
						patchDefaultTemplate()
						patchAllLiveStyleInfo()
						refreshConstantPatches()
					end)
				end))
			else
				teardown()
			end
		end,
		Tooltip = 'Raises mv (default 2.7 strafe cap) via CreateStyleInfo + legacy 2.7 constant patch. Use 1.1–1.4 on ranked runs.',
	})

	Speed:CreateSlider({
		Name = 'Gain',
		Min = 1,
		Max = 3,
		Decimal = 10,
		Default = 1.3,
		Function = function(val)
			boostMultiplier = val
			if boostActive then
				installBoost()
				reapplyStyleOnMechanics()
				refreshConstantPatches()
			end
		end,
		Suffix = function(val)
			return val .. 'x'
		end,
	})
end)

return '5315066937'
