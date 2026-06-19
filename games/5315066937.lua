--[[
	Ugc place 5315066937 — custom surf/bhop engine (Load.ModuleScript DI).

	After bootstrap, ReplicatedStorage Client/Shared modules are destroyed and
	_G.obtain is nilled. Hooks resolve singletons from getgc() / ContextManager.

	Movement speed is driven by StyleInfo.mv (not MaxSpeed). Timer rate uses
	Simulation.Timer:SetScale(rootTime, scale) — see Timers module + SimulationWiring.
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

local speedState = {
	playback = nil,
	liveSim = nil,
	rootTimer = nil,
	styleInfos = {},
	styleBaselines = {},
	timerBaseline = nil,
	lastResolveAt = 0,
}

local function looksLikeContextManager(obj)
	return type(obj) == 'table'
		and type(obj.GetContext) == 'function'
		and type(obj.Contexts) == 'table'
end

local function looksLikeView(obj)
	if type(obj) ~= 'table' or type(obj.PlaybackContext) ~= 'table' then
		return false
	end
	local player = obj.Player
	return player == 'Local' or player == lplr or player == lplr.Name
end

local function looksLikeStyleInfo(obj)
	return type(obj) == 'table'
		and type(obj.mv) == 'number'
		and type(obj.tickrate) == 'number'
end

local function looksLikeGameMechanics(obj)
	return type(obj) == 'table' and looksLikeStyleInfo(obj.StyleInfo)
end

local function looksLikeTimer(obj)
	return type(obj) == 'table'
		and type(obj.Time) == 'function'
		and type(obj.SetScale) == 'function'
		and type(obj.GetGlobalScale) == 'function'
end

local function looksLikeSimulation(obj)
	return type(obj) == 'table'
		and looksLikeTimer(obj.Timer)
		and looksLikeGameMechanics(obj.GameMechanics)
		and obj.Phys ~= nil
end

local function looksLikePlaybackContext(obj)
	return type(obj) == 'table'
		and looksLikeTimer(obj.Timer)
		and type(obj.Context) == 'table'
		and (looksLikeStyleInfo(obj.StyleInfo) or looksLikeSimulation(obj.Context.Simulation))
end

local function looksLikeRootTimer(obj)
	return looksLikeTimer(obj) and obj.Parent == nil
end

local function addStyleInfo(targets, seen, styleInfo)
	if not looksLikeStyleInfo(styleInfo) or seen[styleInfo] then
		return
	end
	seen[styleInfo] = true
	table.insert(targets, styleInfo)
end

local function collectStyleInfos(playback, sim)
	local list = {}
	local seen = {}
	if playback then
		addStyleInfo(list, seen, playback.StyleInfo)
	end
	if sim and sim.GameMechanics then
		addStyleInfo(list, seen, sim.GameMechanics.StyleInfo)
	end
	return list
end

local function resolveSpeedTargets(force)
	local now = tick()
	if not force and speedState.playback and now - speedState.lastResolveAt < 0.5 then
		return speedState
	end
	speedState.lastResolveAt = now
	speedState.playback = nil
	speedState.liveSim = nil
	speedState.rootTimer = nil
	speedState.styleInfos = {}

	if not getgc then
		return speedState
	end
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return speedState
	end

	local contextManager, view
	for _, obj in gc do
		if type(obj) ~= 'table' then
			continue
		end
		if not contextManager and looksLikeContextManager(obj) then
			contextManager = obj
		elseif not view and looksLikeView(obj) then
			view = obj
		elseif not speedState.rootTimer and looksLikeRootTimer(obj) then
			speedState.rootTimer = obj
		end
	end

	local playback
	if contextManager then
		local ok, result = pcall(function()
			return contextManager.GetContext('Local') or contextManager.GetContext(lplr)
		end)
		if ok and looksLikePlaybackContext(result) then
			playback = result
		end
	end
	if not playback and view and looksLikePlaybackContext(view.PlaybackContext) then
		playback = view.PlaybackContext
	end
	speedState.playback = playback

	local sim
	if playback and playback.Context then
		local ctx = playback.Context
		if looksLikeSimulation(ctx.Simulation) then
			sim = ctx.Simulation
		elseif looksLikeSimulation(ctx) then
			sim = ctx
		end
	end
	speedState.liveSim = sim

	if sim and looksLikeTimer(sim.Timer) then
		if sim.Timer.Parent and looksLikeTimer(sim.Timer.Parent) then
			speedState.rootTimer = sim.Timer.Parent
		end
	elseif playback and playback.Timer and playback.Timer.Parent and looksLikeTimer(playback.Timer.Parent) then
		speedState.rootTimer = playback.Timer.Parent
	end

	speedState.styleInfos = collectStyleInfos(playback, sim)
	return speedState
end

local function captureBaselines()
	for _, styleInfo in speedState.styleInfos do
		if not speedState.styleBaselines[styleInfo] then
			speedState.styleBaselines[styleInfo] = {
				mv = styleInfo.mv,
				timescale = styleInfo.timescale,
				tickrate = styleInfo.tickrate,
			}
		end
	end
	if speedState.liveSim and speedState.liveSim.Timer and speedState.timerBaseline == nil then
		local timer = speedState.liveSim.Timer
		local scale = timer.GetScale and timer:GetScale() or timer.Scale
		if type(scale) == 'number' and scale > 0 then
			speedState.timerBaseline = scale
		elseif speedState.rootTimer then
			speedState.timerBaseline = speedState.rootTimer.GetScale
				and speedState.rootTimer:GetScale()
				or speedState.rootTimer.Scale
				or 1
		else
			speedState.timerBaseline = 1
		end
	end
end

local function restoreSpeedBoost()
	for styleInfo, base in speedState.styleBaselines do
		if base.mv then
			styleInfo.mv = base.mv
		end
		if base.timescale then
			styleInfo.timescale = base.timescale
		end
		if base.tickrate then
			styleInfo.tickrate = base.tickrate
		end
	end
	if speedState.liveSim and speedState.liveSim.Timer and speedState.timerBaseline then
		local timer = speedState.liveSim.Timer
		local rootTime = speedState.rootTimer and speedState.rootTimer:Time() or tick()
		pcall(function()
			timer:SetScale(rootTime, speedState.timerBaseline)
		end)
	end
	speedState.styleBaselines = {}
	speedState.timerBaseline = nil
end

local function resetSpeedCache()
	speedState.playback = nil
	speedState.liveSim = nil
	speedState.rootTimer = nil
	speedState.styleInfos = {}
	speedState.styleBaselines = {}
	speedState.timerBaseline = nil
	speedState.lastResolveAt = 0
end

local function applyStyleMultiplier(multiplier)
	for _, styleInfo in speedState.styleInfos do
		local base = speedState.styleBaselines[styleInfo]
		if base and base.mv then
			styleInfo.mv = base.mv * multiplier
		end
		if base and base.timescale then
			styleInfo.timescale = base.timescale * multiplier
		end
	end
	return #speedState.styleInfos > 0
end

local function applyTimerMultiplier(multiplier)
	if not speedState.liveSim or not speedState.liveSim.Timer then
		return false
	end
	local timer = speedState.liveSim.Timer
	local rootTime = speedState.rootTimer and speedState.rootTimer:Time() or tick()
	local base = speedState.timerBaseline or 1
	local ok = pcall(function()
		timer:SetScale(rootTime, base * multiplier)
	end)
	return ok
end

local function applySpeedMultiplier(multiplier, useStyle, useTimer)
	resolveSpeedTargets(false)
	if #speedState.styleInfos == 0 and not speedState.liveSim then
		return false
	end
	captureBaselines()
	local ok = false
	if useStyle then
		ok = applyStyleMultiplier(multiplier) or ok
	end
	if useTimer then
		ok = applyTimerMultiplier(multiplier) or ok
	end
	return ok
end

run(function()
	local speedActive = false
	local speedMultiplier = 1.5
	local speedMode = 'Both'
	local resolveFailStreak = 0

	local function modeUsesStyle()
		return speedMode == 'Style' or speedMode == 'Both'
	end

	local function modeUsesTimer()
		return speedMode == 'Timer' or speedMode == 'Both'
	end

	lplr.CharacterAdded:Connect(function()
		resetSpeedCache()
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			speedActive = callback
			if callback then
				resetSpeedCache()
				resolveSpeedTargets(true)
				if not applySpeedMultiplier(speedMultiplier, modeUsesStyle(), modeUsesTimer()) then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Waiting for map simulation…', 4)
					end)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					if applySpeedMultiplier(speedMultiplier, modeUsesStyle(), modeUsesTimer()) then
						resolveFailStreak = 0
						return
					end
					resolveFailStreak += 1
					if resolveFailStreak >= 120 then
						resolveFailStreak = 0
						resetSpeedCache()
						resolveSpeedTargets(true)
					end
				end))
			else
				restoreSpeedBoost()
				resetSpeedCache()
			end
		end,
		Tooltip = 'Boosts StyleInfo.mv / timescale and simulation Timer:SetScale on the local playback sim. Style mode changes ground speed; Timer mode speeds sim ticks.',
	})

	Speed:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 5,
		Decimal = 10,
		Default = 1.5,
		Function = function(val)
			speedMultiplier = val
		end,
		Suffix = function(val)
			return val .. 'x'
		end,
	})

	Speed:CreateDropdown({
		Name = 'Mode',
		List = { 'Both', 'Style', 'Timer' },
		Default = 1,
		Function = function(val)
			speedMode = val
		end,
	})
end)

return '5315066937'
