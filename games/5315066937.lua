--[[
	Ugc 5315066937 — surf/bhop engine (server-authoritative).

	RE (Module_81 / Module_52 / Module_99):
	  Client sends inputs via ReplicateTimelineEvents(RootTimer:Time(), ...).
	  Writing RootTimer.Scale directly desyncs timelines → kick
	  "Invalid ReplicateTimelineEvents networking data".

	  Legitimate speed: SimulationControl OutputMulticall → Input →
	  EVENT_INPUT_TIMESCALE (304) → Simulation.Timer:SetScale (max 2x).
	  Same path as the in-game /timescale command.

	  StyleInfo.mv only affects air strafe (Module_67 u252), not surf ramps.
	  Phys.SetVelocity hooks are overwritten by SimulationSynchronization.
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

local EVENT_INPUT_TIMESCALE = 304
local MAX_TIMESCALE = 2
local RESOLVE_INTERVAL = 1.5

local speedState = {
	simControl = nil,
	rootTimer = nil,
	mechanics = nil,
	mechBaselines = {},
	lastResolveAt = 0,
	lastTimescale = 1,
}

local function looksLikeContextManager(obj)
	return type(obj) == 'table'
		and type(obj.GetContext) == 'function'
		and type(obj.RegisterContext) == 'function'
end

local function looksLikeView(obj)
	if type(obj) ~= 'table' then
		return false
	end
	local player = obj.Player
	if player ~= 'Local' and player ~= lplr and player ~= lplr.Name then
		return false
	end
	return type(obj.PlaybackContext) == 'table'
end

local function looksLikeSimulationControl(obj)
	return type(obj) == 'table'
		and type(obj.OutputMulticall) == 'table'
		and type(obj.SetStyle) == 'function'
		and type(obj.Init) == 'function'
end

local function looksLikeTimerSystem(obj)
	return type(obj) == 'table'
		and type(obj.Run) == 'function'
		and type(obj.RootTimer) == 'table'
		and type(obj.RootTimer.Time) == 'function'
		and type(obj.RootTimer.SetScale) == 'function'
end

local function looksLikeGameMechanics(obj)
	if type(obj) ~= 'table' or type(obj.SetStyle) ~= 'function' then
		return false
	end
	local si = obj.StyleInfo
	if type(si) ~= 'table' or type(si.mv) ~= 'number' then
		return false
	end
	return type(obj.Simulation) == 'table' and obj.Simulation.Phys ~= nil
end

local function simScore(sim)
	if type(sim) ~= 'table' or not sim.Phys then
		return -1
	end
	local score = 0
	if type(sim.Phys.Time) == 'number' then
		score += sim.Phys.Time * 1000
	end
	local vel = sim.Phys.Velocity
	if typeof(vel) == 'Vector3' then
		score += vel.Magnitude
	end
	if sim.MovingPartsEnabled == true then
		score += 1e9
	end
	return score
end

local function pickLiveMechanics(playback)
	if type(playback) ~= 'table' or type(playback.Context) ~= 'table' then
		return nil
	end
	local ctx = playback.Context
	local bestSim, bestScore
	local function consider(sim)
		if type(sim) ~= 'table' then
			return
		end
		local score = simScore(sim)
		if score > (bestScore or -1) then
			bestSim = sim
			bestScore = score
		end
	end
	consider(ctx.Simulation)
	consider(ctx.SmoothingSimulation)
	return bestSim and bestSim.GameMechanics or nil
end

local function resolveTargets(force)
	local now = tick()
	if not force and speedState.simControl and speedState.rootTimer and now - speedState.lastResolveAt < RESOLVE_INTERVAL then
		return speedState.simControl ~= nil and speedState.rootTimer ~= nil
	end
	speedState.lastResolveAt = now

	if not getgc then
		return false
	end
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return false
	end

	local view, contextManager, simControl, timerSystem
	local bestMech, bestMechScore

	for _, obj in gc do
		if type(obj) ~= 'table' then
			continue
		end
		if not view and looksLikeView(obj) then
			view = obj
		end
		if not contextManager and looksLikeContextManager(obj) then
			contextManager = obj
		end
		if not simControl and looksLikeSimulationControl(obj) then
			simControl = obj
		end
		if not timerSystem and looksLikeTimerSystem(obj) then
			timerSystem = obj
		end
		if looksLikeGameMechanics(obj) then
			local score = simScore(obj.Simulation)
			if score > (bestMechScore or -1) then
				bestMech = obj
				bestMechScore = score
			end
		end
	end

	local mechanics
	local playback
	if view and type(view.PlaybackContext) == 'table' then
		playback = view.PlaybackContext
		mechanics = pickLiveMechanics(playback)
	end
	if not playback and contextManager then
		local ok, result = pcall(function()
			return contextManager.GetContext('Local') or contextManager.GetContext(lplr)
		end)
		if ok and type(result) == 'table' then
			playback = result
			mechanics = pickLiveMechanics(playback)
		end
	end
	if not mechanics and bestMech and bestMechScore and bestMechScore > 0 then
		mechanics = bestMech
	end

	local rootTimer = timerSystem and timerSystem.RootTimer or nil
	if not rootTimer and playback and type(playback.Context) == 'table' then
		local ctxTimer = playback.Context.Timer
		if type(ctxTimer) == 'table' and type(ctxTimer.Parent) == 'table' and type(ctxTimer.Parent.Time) == 'function' then
			rootTimer = ctxTimer.Parent
		end
	end

	speedState.simControl = simControl
	speedState.rootTimer = rootTimer
	speedState.mechanics = mechanics
	return simControl ~= nil and rootTimer ~= nil
end

local function sendTimescale(scale)
	scale = math.clamp(scale, 0.01, MAX_TIMESCALE)
	if math.abs(scale - speedState.lastTimescale) < 0.001 then
		return true
	end
	if not speedState.simControl or not speedState.rootTimer then
		return false
	end
	local ok = pcall(function()
		speedState.simControl.OutputMulticall:Call(
			'Input',
			speedState.rootTimer:Time(),
			EVENT_INPUT_TIMESCALE,
			scale
		)
	end)
	if ok then
		speedState.lastTimescale = scale
	end
	return ok
end

local function refreshStyleBaseline(mechanics, multiplier)
	local si = mechanics and mechanics.StyleInfo
	if not si then
		return
	end
	local base = speedState.mechBaselines[mechanics]
	if base and base.styleInfo == si then
		return
	end
	local mv = si.mv
	local air = si.air_accel
	if multiplier > 1 and mv > 3.5 then
		mv = mv / multiplier
		if type(air) == 'number' then
			air = air / multiplier
		end
	end
	speedState.mechBaselines[mechanics] = {
		styleInfo = si,
		mv = mv,
		air_accel = air,
	}
end

local function applyStrafeBoost(mechanics, multiplier)
	if multiplier <= 1 or not mechanics then
		return
	end
	refreshStyleBaseline(mechanics, multiplier)
	local si = mechanics.StyleInfo
	local base = speedState.mechBaselines[mechanics]
	if not si or not base or base.styleInfo ~= si then
		return
	end
	si.mv = base.mv * multiplier
	if type(base.air_accel) == 'number' then
		si.air_accel = base.air_accel * multiplier
	end
end

local function restoreStrafeBoost()
	for _, base in speedState.mechBaselines do
		local si = base.styleInfo
		if si and base.mv then
			si.mv = base.mv
		end
		if si and type(base.air_accel) == 'number' then
			si.air_accel = base.air_accel
		end
	end
	speedState.mechBaselines = {}
end

local function resetSpeedState()
	if speedState.simControl and speedState.rootTimer then
		sendTimescale(1)
	end
	restoreStrafeBoost()
	speedState.simControl = nil
	speedState.rootTimer = nil
	speedState.mechanics = nil
	speedState.lastResolveAt = 0
	speedState.lastTimescale = 1
end

local speedActive = false

run(function()
	local speedMultiplier = 1.5
	local strafeBoost = true
	local resolveFailStreak = 0
	local lastNotifyAt = 0

	lplr.CharacterAdded:Connect(function()
		resetSpeedState()
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			speedActive = callback
			if callback then
				resolveTargets(true)
				if not speedState.simControl then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Load a map first — waiting for simulation…', 4)
					end)
				else
					sendTimescale(speedMultiplier)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					if not speedState.simControl or not speedState.rootTimer then
						if resolveTargets(false) then
							resolveFailStreak = 0
							sendTimescale(speedMultiplier)
						else
							resolveFailStreak += 1
							if resolveFailStreak == 120 and tick() - lastNotifyAt > 10 then
								lastNotifyAt = tick()
								pcall(function()
									vape:CreateNotification('Speed Boost', 'No simulation yet — join a map first', 3)
								end)
							end
							if resolveFailStreak >= 240 then
								resolveFailStreak = 0
								resolveTargets(true)
							end
						end
					end
					if speedState.simControl and speedState.rootTimer then
						sendTimescale(speedMultiplier)
					end
					if strafeBoost and speedState.mechanics then
						applyStrafeBoost(speedState.mechanics, speedMultiplier)
					end
				end))
			else
				resetSpeedState()
			end
		end,
		Tooltip = 'Uses the game\'s /timescale input path (1–2x, surf + bhop). Does not touch RootTimer — avoids replication kicks.',
	})

	Speed:CreateSlider({
		Name = 'Timescale',
		Min = 1,
		Max = MAX_TIMESCALE,
		Decimal = 10,
		Default = 1.5,
		Function = function(val)
			speedMultiplier = val
			if speedActive then
				sendTimescale(speedMultiplier)
			end
		end,
		Suffix = function(val)
			return val .. 'x'
		end,
	})

	Speed:CreateToggle({
		Name = 'Strafe Boost',
		Default = true,
		Function = function(val)
			strafeBoost = val
			if not val then
				restoreStrafeBoost()
			end
		end,
		Tooltip = 'Also raises StyleInfo.mv for air strafe. Surf speed comes from timescale.',
	})
end)

return '5315066937'
