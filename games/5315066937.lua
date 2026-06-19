--[[
	Ugc 5315066937 — surf/bhop (server-replicated inputs, client sim display).

	RE findings:
	  - /timescale & EVENT_INPUT_TIMESCALE are NO-OP on autohop (allow_timescale=false, Module_52:215).
	  - RootTimer.Scale corrupts ReplicateTimelineEvents → kick.
	  - StyleInfo.mv = air strafe cap (Module_67 u252). Surf uses sim tick rate + collision.
	  - SimulationSynchronization pulls client sim back to server state when they diverge.

	Working approach for autohop real runs:
	  1. Resolve live sim via View → PlaybackContext.Context.Simulation
	  2. Patch StyleInfo.mv (+ air_accel) on live GameMechanics every tick
	  3. sim:HandleControl("Timer", rootTime, "SetTimescale", scale) on live Simulation.Timer
	  4. Hook Phys.SetVelocity on live sim (delta scale horizontal changes)
	  5. Pause SimulationSynchronization resync while boost is active (client sim keeps boost)
	  6. Hook Styles.CreateStyleInfo so SetStyle refreshes keep boosted mv
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

local MAX_SCALE = 2
local RESOLVE_INTERVAL = 1

local speedState = {
	view = nil,
	playback = nil,
	sim = nil,
	mechanics = nil,
	phys = nil,
	rootTimer = nil,
	director = nil,
	simSync = nil,
	styles = nil,
	mechBaselines = {},
	physHooked = nil,
	physOrigSetVel = nil,
	syncRunOrig = nil,
	createStyleOrig = nil,
	lastResolveAt = 0,
	lastSimTimescale = 1,
}

local speedActive = false
local speedMultiplier = 1.5

local function looksLikeView(obj)
	if type(obj) ~= 'table' then
		return false
	end
	local player = obj.Player
	if player ~= 'Local' and player ~= lplr and player ~= lplr.Name then
		return false
	end
	return type(obj.PlaybackContext) == 'table' or obj.ModeCount ~= nil
end

local function looksLikeStyles(obj)
	return type(obj) == 'table'
		and type(obj.CreateStyleInfo) == 'function'
		and type(obj.DefaultStyle) == 'number'
end

local function looksLikeSimulationDirector(obj)
	return type(obj) == 'table'
		and type(obj.TickRate) == 'number'
		and type(obj.HandleInput) == 'function'
		and type(obj.OutputMulticall) == 'table'
		and type(obj.ControlMulticall) == 'table'
		and type(obj.StyleInfo) == 'table'
end

local function looksLikeSimSync(obj)
	return type(obj) == 'table'
		and type(obj.SynchronizeState) == 'function'
		and type(obj.Run) == 'function'
		and type(obj.BindSimulation) == 'function'
		and obj.KetchupSimulation ~= nil
		and obj.Simulation ~= nil
end

local function looksLikeGameMechanics(obj)
	if type(obj) ~= 'table' or type(obj.SetStyle) ~= 'function' then
		return false
	end
	local si = obj.StyleInfo
	return type(si) == 'table' and type(si.mv) == 'number' and obj.Simulation ~= nil
end

local function looksLikeTimerSystem(obj)
	return type(obj) == 'table'
		and type(obj.Run) == 'function'
		and looksLikeRootTimer(obj.RootTimer)
end

local function looksLikeRootTimer(obj)
	return type(obj) == 'table'
		and type(obj.Time) == 'function'
		and type(obj.SetScale) == 'function'
		and type(obj.Pt) == 'number'
end

local function simScore(sim)
	if type(sim) ~= 'table' or not sim.Phys then
		return -1
	end
	local score = 0
	if sim.MovingPartsEnabled == true then
		score += 1e12
	end
	if type(sim.Phys.Time) == 'number' then
		score += sim.Phys.Time * 1000
	end
	local vel = sim.Phys.Velocity
	if typeof(vel) == 'Vector3' then
		score += vel.Magnitude
	end
	return score
end

local function pickLiveSim(ctx)
	if type(ctx) ~= 'table' then
		return nil
	end
	local best, bestScore
	local function consider(sim)
		if type(sim) ~= 'table' then
			return
		end
		local score = simScore(sim)
		if score > (bestScore or -1) then
			best = sim
			bestScore = score
		end
	end
	consider(ctx.Simulation)
	consider(ctx.SmoothingSimulation)
	return best
end

local function resolveTargets(force)
	local now = tick()
	if not force and speedState.sim and now - speedState.lastResolveAt < RESOLVE_INTERVAL then
		return speedState.sim ~= nil
	end
	speedState.lastResolveAt = now

	if not getgc then
		return false
	end

	local view, styles, director, simSync, rootTimer, timerSystem
	local bestMech, bestMechScore

	local function scanGc(includeTables)
		local gcOk, gc = pcall(getgc, includeTables)
		if not gcOk or type(gc) ~= 'table' then
			return
		end
		for _, obj in gc do
			if type(obj) ~= 'table' then
				continue
			end
			if not view and looksLikeView(obj) then
				view = obj
			end
			if not styles and looksLikeStyles(obj) then
				styles = obj
			end
			if not director and looksLikeSimulationDirector(obj) then
				director = obj
			end
			if not simSync and looksLikeSimSync(obj) then
				simSync = obj
			end
			if not timerSystem and looksLikeTimerSystem(obj) then
				timerSystem = obj
			end
			if not rootTimer and looksLikeRootTimer(obj) and type(obj.Scale) == 'number' and obj.Scale == 1 then
				rootTimer = obj
			end
			if looksLikeGameMechanics(obj) then
				local score = simScore(obj.Simulation)
				if score > (bestMechScore or -1) then
					bestMech = obj
					bestMechScore = score
				end
			end
		end
	end

	scanGc(true)
	if not view or not simSync then
		scanGc(false)
	end

	local playback = view and view.PlaybackContext
	local ctx = playback and playback.Context
	local sim = pickLiveSim(ctx)
	local mechanics = sim and sim.GameMechanics

	if not sim and bestMech and bestMechScore and bestMechScore > 0 then
		mechanics = bestMech
		sim = bestMech.Simulation
	end

	if not rootTimer and timerSystem then
		rootTimer = timerSystem.RootTimer
	end
	if not rootTimer and ctx and type(ctx.Timer) == 'table' and looksLikeRootTimer(ctx.Timer.Parent) then
		rootTimer = ctx.Timer.Parent
	end

	if simSync and not sim and simSync.Simulation then
		sim = simSync.Simulation
		mechanics = sim.GameMechanics
	end

	speedState.view = view
	speedState.playback = playback
	speedState.sim = sim
	speedState.mechanics = mechanics
	speedState.phys = sim and sim.Phys or nil
	speedState.rootTimer = rootTimer
	speedState.director = director
	speedState.simSync = simSync
	speedState.styles = styles

	return sim ~= nil and mechanics ~= nil
end

local function scaleVelocityDelta(oldVel, newVel, mult)
	if mult <= 1 or typeof(oldVel) ~= 'Vector3' or typeof(newVel) ~= 'Vector3' then
		return newVel
	end
	local delta = newVel - oldVel
	local horizDelta = Vector3.new(delta.X, 0, delta.Z)
	if horizDelta.Magnitude > 1e-6 then
		local horiz = Vector3.new(oldVel.X, 0, oldVel.Z) + horizDelta * mult
		return Vector3.new(horiz.X, newVel.Y, horiz.Z)
	end
	local horizNew = Vector3.new(newVel.X, 0, newVel.Z)
	local horizOld = Vector3.new(oldVel.X, 0, oldVel.Z)
	if horizNew.Magnitude > horizOld.Magnitude + 1e-6 then
		local boosted = horizOld + (horizNew - horizOld) * mult
		return Vector3.new(boosted.X, newVel.Y, boosted.Z)
	end
	return newVel
end

local function unhookPhys()
	if speedState.phys and speedState.physOrigSetVel then
		speedState.phys.SetVelocity = speedState.physOrigSetVel
	end
	speedState.physHooked = nil
	speedState.physOrigSetVel = nil
end

local function hookPhys(phys)
	if not phys or speedState.physHooked == phys then
		return
	end
	unhookPhys()
	local orig = phys.SetVelocity
	if type(orig) ~= 'function' then
		return
	end
	speedState.physOrigSetVel = orig
	speedState.physHooked = phys
	phys.SetVelocity = function(self, newVel)
		if speedActive and speedMultiplier > 1 then
			newVel = scaleVelocityDelta(self.Velocity, newVel, speedMultiplier)
		end
		return orig(self, newVel)
	end
end

local function installSyncBlock()
	local sync = speedState.simSync
	if not sync or speedState.syncRunOrig then
		return
	end
	speedState.syncRunOrig = sync.Run
	sync.Run = function(self)
		if speedActive then
			return
		end
		return speedState.syncRunOrig(self)
	end
end

local function restoreSyncBlock()
	local sync = speedState.simSync
	if sync and speedState.syncRunOrig then
		sync.Run = speedState.syncRunOrig
	end
	speedState.syncRunOrig = nil
end

local function installCreateStyleHook()
	local styles = speedState.styles
	if not styles or speedState.createStyleOrig then
		return
	end
	speedState.createStyleOrig = styles.CreateStyleInfo
	styles.CreateStyleInfo = function(styleId, gameId)
		local info = speedState.createStyleOrig(styleId, gameId)
		if speedActive and info and speedMultiplier > 1 then
			local baseMv = info.mv or 2.7
			info.mv = baseMv * speedMultiplier
			if type(info.air_accel) == 'number' then
				info.air_accel = info.air_accel * speedMultiplier
			end
		end
		return info
	end
end

local function restoreCreateStyleHook()
	if speedState.styles and speedState.createStyleOrig then
		speedState.styles.CreateStyleInfo = speedState.createStyleOrig
	end
	speedState.createStyleOrig = nil
end

local function refreshBaseline(owner, si)
	if not si then
		return
	end
	local base = speedState.mechBaselines[owner]
	if base and base.styleInfo == si then
		return
	end
	local mv = si.mv
	local air = si.air_accel
	if speedMultiplier > 1 and mv > 3.5 then
		mv = mv / speedMultiplier
		if type(air) == 'number' then
			air = air / speedMultiplier
		end
	end
	speedState.mechBaselines[owner] = {
		styleInfo = si,
		mv = mv,
		air_accel = air,
	}
end

local function applyStyleBoostFor(owner, si)
	if not si or speedMultiplier <= 1 then
		return
	end
	refreshBaseline(owner, si)
	local base = speedState.mechBaselines[owner]
	if not base or base.styleInfo ~= si then
		return
	end
	si.mv = base.mv * speedMultiplier
	if type(base.air_accel) == 'number' then
		si.air_accel = base.air_accel * speedMultiplier
	end
end

local function applyMechanicsBoost(mechanics)
	if not mechanics then
		return
	end
	applyStyleBoostFor(mechanics, mechanics.StyleInfo)
end

local function restoreMechanicsBoost()
	for owner, base in speedState.mechBaselines do
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

local function applySimTimescale(sim, rootTimer, scale)
	if not sim or not rootTimer or type(sim.HandleControl) ~= 'function' then
		return
	end
	scale = math.clamp(scale, 1, MAX_SCALE)
	if math.abs(scale - speedState.lastSimTimescale) < 0.001 then
		return
	end
	local ok = pcall(function()
		local t = rootTimer:Time()
		sim:HandleControl('Timer', t, 'SetTimescale', scale)
	end)
	if ok then
		speedState.lastSimTimescale = scale
	end
end

local function restoreSimTimescale(sim, rootTimer)
	if sim and rootTimer and type(sim.HandleControl) == 'function' then
		pcall(function()
			sim:HandleControl('Timer', rootTimer:Time(), 'SetTimescale', 1)
		end)
	end
	speedState.lastSimTimescale = 1
end

local function applyAllBoosts()
	if not speedState.sim or not speedState.mechanics then
		return false
	end
	if speedState.phys ~= speedState.sim.Phys then
		speedState.phys = speedState.sim.Phys
		hookPhys(speedState.phys)
	end
	applyMechanicsBoost(speedState.mechanics)
	if speedState.director then
		applyStyleBoostFor(speedState.director, speedState.director.StyleInfo)
	end
	if speedState.simSync and speedState.simSync.KetchupSimulation then
		local km = speedState.simSync.KetchupSimulation.GameMechanics
		if km then
			applyMechanicsBoost(km)
		end
	end
	applySimTimescale(speedState.sim, speedState.rootTimer, speedMultiplier)
	return true
end

local function teardownBoost()
	restoreMechanicsBoost()
	restoreSimTimescale(speedState.sim, speedState.rootTimer)
	unhookPhys()
	restoreSyncBlock()
	restoreCreateStyleHook()
	speedState.view = nil
	speedState.playback = nil
	speedState.sim = nil
	speedState.mechanics = nil
	speedState.phys = nil
	speedState.rootTimer = nil
	speedState.director = nil
	speedState.simSync = nil
	speedState.styles = nil
	speedState.lastResolveAt = 0
end

run(function()
	local resolveFailStreak = 0
	local hookedOnce = false
	local lastNotifyAt = 0

	lplr.CharacterAdded:Connect(function()
		if speedActive then
			teardownBoost()
			hookedOnce = false
		end
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			speedActive = callback
			if callback then
				teardownBoost()
				hookedOnce = false
				resolveFailStreak = 0
				if resolveTargets(true) then
					installSyncBlock()
					installCreateStyleHook()
					hookPhys(speedState.phys)
					applyAllBoosts()
					hookedOnce = true
				else
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Join a map and start moving…', 4)
					end)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					if not speedState.sim then
						if resolveTargets(false) then
							resolveFailStreak = 0
							if not hookedOnce then
								installSyncBlock()
								installCreateStyleHook()
								hookedOnce = true
							end
							hookPhys(speedState.phys)
							applyAllBoosts()
						else
							resolveFailStreak += 1
							if resolveFailStreak == 90 and tick() - lastNotifyAt > 12 then
								lastNotifyAt = tick()
								pcall(function()
									vape:CreateNotification('Speed Boost', 'Waiting for live simulation…', 3)
								end)
							end
							if resolveFailStreak >= 180 then
								resolveFailStreak = 0
								resolveTargets(true)
							end
						end
					else
						applyAllBoosts()
					end
				end))
			else
				teardownBoost()
				hookedOnce = false
			end
		end,
		Tooltip = 'Boosts live sim mv + tick rate on autohop. Blocks server resync rollback while enabled.',
	})

	Speed:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = MAX_SCALE,
		Decimal = 10,
		Default = 1.5,
		Function = function(val)
			speedMultiplier = val
			speedState.lastSimTimescale = 0
			if speedActive then
				applyAllBoosts()
			end
		end,
		Suffix = function(val)
			return val .. 'x'
		end,
	})
end)

return '5315066937'
