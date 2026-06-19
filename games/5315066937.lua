--[[
	Ugc place 5315066937 — custom surf/bhop engine.

	Live path (from runtime/view.txt):
		View.PlaybackContext.Context.Simulation  -> RealtimeContext.Simulation
		Context.Simulation.GameMechanics.StyleInfo.mv  -> air strafe cap only
		Context.Simulation.Phys.SetVelocity            -> all movement (surf ramps)

	RootTimer.Scale speeds ticks but can desync SimulationSynchronization on online runs.
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

local RESOLVE_INTERVAL = 1

local speedState = {
	sim = nil,
	mechanics = nil,
	phys = nil,
	rootTimer = nil,
	mechBaselines = {},
	physHooks = {},
	lastResolveAt = 0,
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

local function looksLikeRootTimer(obj)
	return type(obj) == 'table'
		and type(obj.Pt) == 'number'
		and type(obj.Scale) == 'number'
		and type(obj.Time) == 'function'
		and type(obj.SetScale) == 'function'
end

local function looksLikeTimerSystem(obj)
	return type(obj) == 'table'
		and type(obj.Run) == 'function'
		and looksLikeRootTimer(obj.RootTimer)
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
	return score
end

local function pickBestSimulation(ctx)
	if type(ctx) ~= 'table' then
		return nil
	end
	local best, bestScore
	local function consider(sim)
		if type(sim) ~= 'table' or not sim.Phys then
			return
		end
		local score = simScore(sim)
		if sim.MovingPartsEnabled == true then
			score += 1e6
		end
		if score > (bestScore or -1) then
			best = sim
			bestScore = score
		end
	end
	if type(ctx.Simulation) == 'table' then
		consider(ctx.Simulation)
	end
	if type(ctx.SmoothingSimulation) == 'table' then
		consider(ctx.SmoothingSimulation)
	end
	return best
end

local function resolveFromView(view)
	if not view or type(view.PlaybackContext) ~= 'table' then
		return nil
	end
	local playback = view.PlaybackContext
	local ctx = playback.Context
	if type(ctx) ~= 'table' then
		return nil
	end
	local sim = pickBestSimulation(ctx)
	if not sim or not sim.GameMechanics or not sim.Phys then
		return nil
	end
	local rootTimer
	if type(ctx.Timer) == 'table' and looksLikeRootTimer(ctx.Timer.Parent) then
		rootTimer = ctx.Timer.Parent
	end
	return {
		sim = sim,
		mechanics = sim.GameMechanics,
		phys = sim.Phys,
		rootTimer = rootTimer,
	}
end

local function resolveFromContextManager(contextManager)
	if not contextManager then
		return nil
	end
	local ok, playback = pcall(function()
		return contextManager.GetContext('Local') or contextManager.GetContext(lplr)
	end)
	if not ok or type(playback) ~= 'table' then
		return nil
	end
	return resolveFromView({ PlaybackContext = playback })
end

local function resolveFromGcFallback()
	if not getgc then
		return nil
	end
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return nil
	end

	local view, contextManager, timerSystem
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

	local resolved = resolveFromView(view) or resolveFromContextManager(contextManager)
	if resolved then
		if not resolved.rootTimer and timerSystem then
			resolved.rootTimer = timerSystem.RootTimer
		end
		return resolved
	end

	if bestMech and bestMechScore and bestMechScore > 0 then
		return {
			sim = bestMech.Simulation,
			mechanics = bestMech,
			phys = bestMech.Simulation.Phys,
			rootTimer = timerSystem and timerSystem.RootTimer or nil,
		}
	end

	return nil
end

local function resolveLiveTargets(force)
	local now = tick()
	if not force and speedState.sim and now - speedState.lastResolveAt < RESOLVE_INTERVAL then
		return speedState.sim ~= nil
	end
	speedState.lastResolveAt = now

	local resolved = resolveFromGcFallback()
	if not resolved then
		speedState.sim = nil
		speedState.mechanics = nil
		speedState.phys = nil
		speedState.rootTimer = nil
		return false
	end

	speedState.sim = resolved.sim
	speedState.mechanics = resolved.mechanics
	speedState.phys = resolved.phys
	speedState.rootTimer = resolved.rootTimer
	return true
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
	if multiplier > 1 then
		mv = si.mv / multiplier
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

local function applyStyleBoost(mechanics, multiplier)
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

local function restoreStyleBoost()
	for mechanics, base in speedState.mechBaselines do
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

local function scaleVelocityDelta(oldVel, newVel, multiplier)
	if multiplier <= 1 or typeof(oldVel) ~= 'Vector3' or typeof(newVel) ~= 'Vector3' then
		return newVel
	end
	local delta = newVel - oldVel
	local horizDelta = Vector3.new(delta.X, 0, delta.Z)
	if horizDelta.Magnitude > 1e-6 then
		local horiz = Vector3.new(oldVel.X, 0, oldVel.Z) + horizDelta * multiplier
		return Vector3.new(horiz.X, newVel.Y, horiz.Z)
	end
	local horizNew = Vector3.new(newVel.X, 0, newVel.Z)
	local horizOld = Vector3.new(oldVel.X, 0, oldVel.Z)
	if horizNew.Magnitude > horizOld.Magnitude + 1e-6 then
		local boosted = horizOld + (horizNew - horizOld) * multiplier
		return Vector3.new(boosted.X, newVel.Y, boosted.Z)
	end
	return newVel
end

local function installPhysHook(phys, getMultiplier)
	if not phys or speedState.physHooks[phys] then
		return
	end
	local orig = phys.SetVelocity
	if type(orig) ~= 'function' then
		return
	end
	speedState.physHooks[phys] = orig
	phys.SetVelocity = function(self, newVel)
		if speedActive and getMultiplier() > 1 then
			newVel = scaleVelocityDelta(self.Velocity, newVel, getMultiplier())
		end
		return orig(self, newVel)
	end
end

local function removePhysHooks()
	for phys, orig in speedState.physHooks do
		if phys and type(orig) == 'function' then
			phys.SetVelocity = orig
		end
	end
	table.clear(speedState.physHooks)
end

local function applyTimerBoost(rootTimer, multiplier, enabled)
	if not rootTimer or not enabled then
		return
	end
	if multiplier <= 1 then
		rootTimer.Scale = 1
	else
		rootTimer.Scale = multiplier
	end
end

local function resetSpeedState()
	restoreStyleBoost()
	removePhysHooks()
	if speedState.rootTimer then
		pcall(function()
			speedState.rootTimer.Scale = 1
		end)
	end
	speedState.sim = nil
	speedState.mechanics = nil
	speedState.phys = nil
	speedState.rootTimer = nil
	speedState.lastResolveAt = 0
end

local speedActive = false
local speedMode = 'Physics'

run(function()
	local speedMultiplier = 1.5
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
				resetSpeedState()
				resolveLiveTargets(true)
				if speedMode ~= 'Timer' and speedState.phys then
					installPhysHook(speedState.phys, function()
						return speedMultiplier
					end)
				end
				if speedMode ~= 'Physics' then
					applyTimerBoost(speedState.rootTimer, speedMultiplier, true)
				end
				if not speedState.sim then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Load a map and move — waiting for simulation…', 4)
					end)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					if not speedState.sim then
						if resolveLiveTargets(false) then
							resolveFailStreak = 0
							if speedMode ~= 'Timer' and speedState.phys then
								installPhysHook(speedState.phys, function()
									return speedMultiplier
								end)
							end
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
								resolveLiveTargets(true)
							end
						end
					end
					if speedState.mechanics and speedMode ~= 'Timer' then
						applyStyleBoost(speedState.mechanics, speedMultiplier)
					end
					if speedMode ~= 'Physics' then
						applyTimerBoost(speedState.rootTimer, speedMultiplier, true)
					end
				end))
			else
				resetSpeedState()
			end
		end,
		Tooltip = 'Hooks live Phys.SetVelocity + StyleInfo.mv. Optional timer mode (may desync online).',
	})

	Speed:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 3,
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
		List = { 'Physics', 'Timer', 'Both' },
		Default = 'Physics',
		Function = function(val)
			speedMode = val
			if not speedActive then
				return
			end
			if speedMode == 'Physics' and speedState.rootTimer then
				pcall(function()
					speedState.rootTimer.Scale = 1
				end)
			end
			if speedMode == 'Timer' then
				removePhysHooks()
				restoreStyleBoost()
			elseif speedState.phys and not speedState.physHooks[speedState.phys] then
				installPhysHook(speedState.phys, function()
					return speedMultiplier
				end)
			end
		end,
		Tooltip = 'Physics = velocity hook (safe). Timer = old RootTimer.Scale (fast, may desync).',
	})
end)

return '5315066937'
