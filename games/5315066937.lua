--[[
	Ugc 5315066937 — MV gain (2.7 strafe cap).

	Lagback cause: client mv above server-authoritative sim → Module_97 keeps
	resyncing velocity. Keep Gain ~1.1–1.25 on ranked runs.

	Implementation: hook Styles.CreateStyleInfo only (no per-frame getgc, no
	velocity hooks, no SetStyle spam). Optional one-shot legacy constant scan.
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
local MAINTAIN_INTERVAL = 2.5

local boostActive = false
local boostMultiplier = 1.15

local state = {
	styleBaselines = {},
	createStyleHooked = false,
	createStyleOrig = nil,
	constantPatches = {},
	lastMaintainAt = 0,
}

local function obtain(name)
	return _G.obtain and _G.obtain(name) or nil
end

local function styleKey(styleId, gameId)
	return tostring(styleId) .. '|' .. tostring(gameId or '')
end

local function rememberBaseline(styleId, gameId, mv)
	if type(mv) ~= 'number' then
		return
	end
	local key = styleKey(styleId or 1, gameId)
	if not state.styleBaselines[key] then
		state.styleBaselines[key] = mv
	end
end

local function applyMvToStyleInfo(si, styleId, gameId)
	if not si or type(si.mv) ~= 'number' then
		return
	end
	local id = styleId or si.id
	local key = styleKey(id, gameId)
	if not state.styleBaselines[key] then
		state.styleBaselines[key] = si.mv
	end
	if boostActive and boostMultiplier > 1 then
		si.mv = state.styleBaselines[key] * boostMultiplier
	else
		si.mv = state.styleBaselines[key]
	end
end

local function getLiveMechanics()
	local view = obtain('View')
	if not view or not view.PlaybackContext then
		return nil, nil, nil
	end
	local ctx = view.PlaybackContext.Context
	if not ctx then
		return nil, nil, view.StyleInfo
	end
	local simMech = ctx.Simulation and ctx.Simulation.GameMechanics
	local smoothMech = ctx.SmoothingSimulation and ctx.SmoothingSimulation.GameMechanics
	return simMech, smoothMech, view.StyleInfo
end

local function refreshLiveStyleInfo()
	local simMech, smoothMech, viewSi = getLiveMechanics()
	for _, mech in { simMech, smoothMech } do
		if mech and mech.StyleInfo then
			local gameId = mech.MapInfo and mech.MapInfo.GameID
			applyMvToStyleInfo(mech.StyleInfo, mech.Style, gameId)
		end
	end
	if viewSi then
		applyMvToStyleInfo(viewSi, viewSi.id, nil)
	end
end

local function hookCreateStyleInfo()
	if state.createStyleHooked then
		return true
	end
	local styles = obtain('Styles')
	if not styles or type(styles.CreateStyleInfo) ~= 'function' then
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
end

local function scanLegacyConstantOnce()
	if not getgc or not debug or not debug.getconstants or not debug.getinfo then
		return
	end
	if next(state.constantPatches) then
		return
	end
	for _, v in getgc() do
		if type(v) ~= 'function' then
			continue
		end
		pcall(function()
			local info = debug.getinfo(v)
			local constants = debug.getconstants(v)
			if constants[1] == DEFAULT_MV and info.nups == 1 then
				if not state.constantPatches[v] then
					state.constantPatches[v] = { [1] = DEFAULT_MV }
				end
				debug.setconstant(v, 1, DEFAULT_MV * boostMultiplier)
			end
		end)
	end
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

local function restoreLiveStylesOnce()
	local simMech, smoothMech = getLiveMechanics()
	for _, mech in { simMech, smoothMech } do
		if mech and type(mech.Style) == 'number' then
			pcall(function()
				mech:SetStyle(mech.Style)
			end)
		end
	end
end

local function installBoost()
	hookCreateStyleInfo()
	scanLegacyConstantOnce()
	refreshLiveStyleInfo()
	refreshConstantPatches()
	state.lastMaintainAt = tick()
end

local function maintainBoost()
	local now = tick()
	if now - state.lastMaintainAt < MAINTAIN_INTERVAL then
		return
	end
	state.lastMaintainAt = now
	if not state.createStyleHooked then
		hookCreateStyleInfo()
	end
	refreshLiveStyleInfo()
end

local function teardown()
	boostActive = false
	unhookCreateStyleInfo()
	restoreConstantPatches()
	restoreLiveStylesOnce()
	state.lastMaintainAt = 0
end

run(function()
	lplr.CharacterAdded:Connect(function()
		if boostActive then
			task.defer(installBoost)
		end
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			if callback then
				boostActive = true
				installBoost()
				if not state.createStyleHooked then
					pcall(function()
						vape:CreateNotification(
							'Speed Boost',
							'Load a map first. Use Gain 1.1–1.25 to reduce lagback.',
							4
						)
					end)
				end
				local tickEvent = runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if boostActive then
						pcall(maintainBoost)
					end
				end))
			else
				teardown()
			end
		end,
		Tooltip = 'Raises mv strafe cap via CreateStyleInfo. Lower gain = less server lagback.',
	})

	Speed:CreateSlider({
		Name = 'Gain',
		Min = 1,
		Max = 1.5,
		Decimal = 100,
		Default = 1.15,
		Function = function(val)
			boostMultiplier = val
			if boostActive then
				refreshLiveStyleInfo()
				refreshConstantPatches()
			end
		end,
		Suffix = function(val)
			return val .. 'x'
		end,
	})
end)

return '5315066937'
