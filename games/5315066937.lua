--[[
	Ugc place 5315066937 — custom surf/bhop engine (Load.ModuleScript DI).

	After bootstrap, ReplicatedStorage Client/Shared modules are destroyed and
	_G.obtain is nilled. Cheat hooks must resolve singletons from getgc().

	Local playback:
		ContextManager.GetContext("Local") -> PlaybackContext
		PlaybackContext.Context            -> RealtimeContext (GetPV, Timer, SmoothingSimulation)
		Main Simulation                    -> table where .Timer == RealtimeContext.Timer
		RootTimer.Scale                    -> sim tick rate (old SpeedHack path)
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

local gameApi = {
	contextManager = nil,
	view = nil,
	playbackContext = nil,
	realtimeContext = nil,
	rootTimer = nil,
	liveSimulations = {},
	mechanicsTargets = {},
	timerBaseline = nil,
	mechanicsBaselines = {},
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

local function looksLikeRootTimer(obj)
	return type(obj) == 'table'
		and type(obj.Time) == 'function'
		and type(obj.Scale) == 'number'
end

local function looksLikeRealtimeContext(obj)
	return type(obj) == 'table'
		and type(obj.GetPV) == 'function'
		and type(obj.GetOutput) == 'function'
		and looksLikeRootTimer(obj.Timer)
end

local function looksLikeGameMechanics(obj)
	return type(obj) == 'table'
		and type(obj.MaxSpeed) == 'number'
		and (type(obj.Accelerate) == 'number' or type(obj.SetStyle) == 'function')
end

local function looksLikeSimulation(obj)
	return type(obj) == 'table'
		and looksLikeGameMechanics(obj.GameMechanics)
		and obj.Phys ~= nil
		and obj.Timer ~= nil
end

local function resolveGameApi(force)
	local now = tick()
	if not force and gameApi.contextManager and now - gameApi.lastResolveAt < 1 then
		return gameApi
	end
	gameApi.lastResolveAt = now
	gameApi.playbackContext = nil
	gameApi.realtimeContext = nil
	gameApi.rootTimer = nil
	gameApi.liveSimulations = {}
	gameApi.mechanicsTargets = {}

	if not getgc then
		return gameApi
	end
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return gameApi
	end

	for _, obj in gc do
		if type(obj) ~= 'table' then
			continue
		end
		if not gameApi.contextManager and looksLikeContextManager(obj) then
			gameApi.contextManager = obj
		elseif not gameApi.view and looksLikeView(obj) then
			gameApi.view = obj
		end
	end

	local playback
	if gameApi.contextManager then
		playback = gameApi.contextManager.GetContext('Local')
			or gameApi.contextManager.GetContext(lplr)
	end
	if not playback and gameApi.view then
		playback = gameApi.view.PlaybackContext
	end
	gameApi.playbackContext = playback

	local context = playback and playback.Context
	if looksLikeRealtimeContext(context) then
		gameApi.realtimeContext = context
		gameApi.rootTimer = context.Timer
	elseif gameApi.view and gameApi.view.PlaybackContext and looksLikeRealtimeContext(gameApi.view.PlaybackContext.Context) then
		gameApi.realtimeContext = gameApi.view.PlaybackContext.Context
		gameApi.rootTimer = gameApi.realtimeContext.Timer
	end

	if not gameApi.rootTimer then
		for _, obj in gc do
			if looksLikeRootTimer(obj) and type(obj.GetScale) == 'function' then
				gameApi.rootTimer = obj
				break
			end
		end
	end

	if gameApi.rootTimer then
		local live = {}
		for _, obj in gc do
			if looksLikeSimulation(obj) and obj.Timer == gameApi.rootTimer then
				table.insert(live, obj)
			end
		end
		gameApi.liveSimulations = live

		local smoothing = gameApi.realtimeContext and gameApi.realtimeContext.SmoothingSimulation
		if looksLikeSimulation(smoothing) then
			local seen = false
			for _, sim in live do
				if sim == smoothing then
					seen = true
					break
				end
			end
			if not seen then
				table.insert(gameApi.liveSimulations, smoothing)
			end
		end

		local seenMech = {}
		for _, sim in gameApi.liveSimulations do
			local mech = sim.GameMechanics
			if looksLikeGameMechanics(mech) and not seenMech[mech] then
				seenMech[mech] = true
				table.insert(gameApi.mechanicsTargets, mech)
			end
		end
	end

	return gameApi
end

local function captureBaselines()
	if gameApi.rootTimer and not gameApi.timerBaseline then
		gameApi.timerBaseline = gameApi.rootTimer.Scale
	end
	for _, mech in gameApi.mechanicsTargets do
		if not gameApi.mechanicsBaselines[mech] then
			gameApi.mechanicsBaselines[mech] = {
				MaxSpeed = mech.MaxSpeed,
				Accelerate = mech.Accelerate,
				AirAccelerate = mech.AirAccelerate,
			}
		end
	end
end

local function restoreSpeedBoost()
	if gameApi.rootTimer and gameApi.timerBaseline then
		gameApi.rootTimer.Scale = gameApi.timerBaseline
	end
	for mech, base in gameApi.mechanicsBaselines do
		if base.MaxSpeed then
			mech.MaxSpeed = base.MaxSpeed
		end
		if base.Accelerate then
			mech.Accelerate = base.Accelerate
		end
		if base.AirAccelerate then
			mech.AirAccelerate = base.AirAccelerate
		end
	end
	gameApi.timerBaseline = nil
	table.clear(gameApi.mechanicsBaselines)
end

local function resetSpeedCache()
	gameApi.playbackContext = nil
	gameApi.realtimeContext = nil
	gameApi.rootTimer = nil
	gameApi.liveSimulations = {}
	gameApi.mechanicsTargets = {}
	gameApi.timerBaseline = nil
	table.clear(gameApi.mechanicsBaselines)
end

local function applySpeedMultiplier(multiplier, useTimer, usePhysics)
	resolveGameApi(false)
	if not gameApi.rootTimer and #gameApi.mechanicsTargets == 0 then
		return false
	end
	captureBaselines()
	if useTimer and gameApi.rootTimer and gameApi.timerBaseline then
		gameApi.rootTimer.Scale = gameApi.timerBaseline * multiplier
	end
	if usePhysics then
		for _, mech in gameApi.mechanicsTargets do
			local base = gameApi.mechanicsBaselines[mech]
			if base then
				if base.MaxSpeed then
					mech.MaxSpeed = base.MaxSpeed * multiplier
				end
				if base.Accelerate then
					mech.Accelerate = base.Accelerate * multiplier
				end
				if base.AirAccelerate then
					mech.AirAccelerate = base.AirAccelerate * multiplier
				end
			end
		end
	end
	return gameApi.rootTimer ~= nil or #gameApi.mechanicsTargets > 0
end

run(function()
	local speedActive = false
	local speedMultiplier = 1.5
	local speedMode = 'Both'
	local resolveFailStreak = 0

	local function modeUsesTimer()
		return speedMode == 'Timer' or speedMode == 'Both'
	end

	local function modeUsesPhysics()
		return speedMode == 'Physics' or speedMode == 'Both'
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
				resolveGameApi(true)
				if not applySpeedMultiplier(speedMultiplier, modeUsesTimer(), modeUsesPhysics()) then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Waiting for simulation to load…', 4)
					end)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					if applySpeedMultiplier(speedMultiplier, modeUsesTimer(), modeUsesPhysics()) then
						resolveFailStreak = 0
						return
					end
					resolveFailStreak += 1
					if resolveFailStreak >= 120 then
						resolveFailStreak = 0
						resetSpeedCache()
						resolveGameApi(true)
					end
				end))
			else
				restoreSpeedBoost()
				resetSpeedCache()
			end
		end,
		Tooltip = 'Boosts local sim tick rate (RootTimer.Scale) and/or GameMechanics on the live player simulation. Timer mode matches the old SpeedHack. High values may desync validated runs.',
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
		List = { 'Both', 'Timer', 'Physics' },
		Default = 1,
		Function = function(val)
			speedMode = val
		end,
	})
end)

return '5315066937'
