--[[
	Ugc 5315066937 — surf/bhop speed boost (safe).

	Broken approaches (removed):
	  - Blocking SimulationSynchronization → NaN sim times, broken camera
	  - sim:HandleControl SetTimescale with wrong clock → timer offset NaN
	  - RootTimer.Scale → replication kick

	Safe approach:
	  - Patch StyleInfo.mv (+ air_accel) on live GameMechanics (strafe cap, Module_67)
	  - Hook Phys.SetVelocity on live sim (horizontal delta scale — surf + strafe)
	  - After SyncState, re-apply horizontal velocity boost (server sync won't zero it out instantly)
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

local RESOLVE_INTERVAL = 1.5

local speedState = {
	sim = nil,
	mechanics = nil,
	phys = nil,
	baselines = {},
	physHooked = nil,
	physOrigSetVel = nil,
	syncStateOrig = nil,
	syncStateSim = nil,
	lastResolveAt = 0,
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
	return obj.ModeCount ~= nil or type(obj.PlaybackContext) == 'table'
end

local function looksLikeContextManager(obj)
	return type(obj) == 'table'
		and type(obj.GetContext) == 'function'
		and type(obj.RegisterContext) == 'function'
end

local function looksLikeGameMechanics(obj)
	if type(obj) ~= 'table' or type(obj.SetStyle) ~= 'function' then
		return false
	end
	local si = obj.StyleInfo
	return type(si) == 'table' and type(si.mv) == 'number' and type(obj.Simulation) == 'table'
end

local function simScore(sim)
	if type(sim) ~= 'table' or not sim.Phys then
		return -1
	end
	local score = sim.MovingPartsEnabled == true and 1e12 or 0
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

local function resolveLive(force)
	local now = tick()
	if not force and speedState.sim and now - speedState.lastResolveAt < RESOLVE_INTERVAL then
		return speedState.sim ~= nil
	end
	speedState.lastResolveAt = now

	if not getgc then
		return false
	end

	local view, contextManager, bestMech, bestMechScore

	local function scan(includeTables)
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
			if not contextManager and looksLikeContextManager(obj) then
				contextManager = obj
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

	scan(true)
	if not view then
		scan(false)
	end

	local playback = view and view.PlaybackContext
	if not playback and contextManager then
		local ok, result = pcall(function()
			return contextManager.GetContext('Local') or contextManager.GetContext(lplr)
		end)
		if ok and type(result) == 'table' then
			playback = result
		end
	end

	local sim = playback and pickLiveSim(playback.Context)
	local mechanics = sim and sim.GameMechanics

	if not sim and bestMech and bestMechScore and bestMechScore > 0 then
		mechanics = bestMech
		sim = bestMech.Simulation
	end

	speedState.sim = sim
	speedState.mechanics = mechanics
	speedState.phys = sim and sim.Phys or nil
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

local function boostHorizontalVelocity(phys, mult)
	if not phys or mult <= 1 then
		return
	end
	local vel = phys.Velocity
	if typeof(vel) ~= 'Vector3' then
		return
	end
	local horiz = Vector3.new(vel.X, 0, vel.Z)
	local mag = horiz.Magnitude
	if mag < 1 then
		return
	end
	local boosted = horiz * mult
	phys.Velocity = Vector3.new(boosted.X, vel.Y, boosted.Z)
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

local function unhookSyncState()
	if speedState.syncStateSim and speedState.syncStateOrig then
		speedState.syncStateSim.SyncState = speedState.syncStateOrig
	end
	speedState.syncStateSim = nil
	speedState.syncStateOrig = nil
end

local function hookSyncState(sim)
	if not sim or speedState.syncStateSim == sim then
		return
	end
	unhookSyncState()
	local orig = sim.SyncState
	if type(orig) ~= 'function' then
		return
	end
	speedState.syncStateOrig = orig
	speedState.syncStateSim = sim
	sim.SyncState = function(self, source)
		orig(self, source)
		if speedActive and speedMultiplier > 1 then
			boostHorizontalVelocity(self.Phys, speedMultiplier)
		end
	end
end

local function refreshBaseline(mech, si)
	local base = speedState.baselines[mech]
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
	speedState.baselines[mech] = {
		styleInfo = si,
		mv = mv,
		air_accel = air,
	}
end

local function applyMechanicsBoost(mech)
	if not mech or speedMultiplier <= 1 then
		return
	end
	local si = mech.StyleInfo
	if not si then
		return
	end
	refreshBaseline(mech, si)
	local base = speedState.baselines[mech]
	if not base or base.styleInfo ~= si then
		return
	end
	si.mv = base.mv * speedMultiplier
	if type(base.air_accel) == 'number' then
		si.air_accel = base.air_accel * speedMultiplier
	end
end

local function restoreBaselines()
	for _, base in speedState.baselines do
		local si = base.styleInfo
		if si and base.mv then
			si.mv = base.mv
		end
		if si and type(base.air_accel) == 'number' then
			si.air_accel = base.air_accel
		end
	end
	speedState.baselines = {}
end

local function installHooks()
	local sim = speedState.sim
	if not sim then
		return false
	end
	if speedState.phys ~= sim.Phys then
		speedState.phys = sim.Phys
	end
	hookPhys(speedState.phys)
	hookSyncState(sim)
	applyMechanicsBoost(speedState.mechanics)
	return true
end

local function teardown()
	restoreBaselines()
	unhookPhys()
	unhookSyncState()
	speedState.sim = nil
	speedState.mechanics = nil
	speedState.phys = nil
	speedState.lastResolveAt = 0
end

run(function()
	local resolveFail = 0

	lplr.CharacterAdded:Connect(function()
		if speedActive then
			teardown()
		end
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			speedActive = callback
			if callback then
				teardown()
				resolveFail = 0
				if not resolveLive(true) or not installHooks() then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Load a map first — waiting for simulation…', 4)
					end)
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					pcall(function()
						if not speedState.sim then
							if resolveLive(false) then
								resolveFail = 0
								installHooks()
							else
								resolveFail += 1
								if resolveFail >= 180 then
									resolveFail = 0
									resolveLive(true)
								end
							end
						else
							installHooks()
						end
					end)
				end))
			else
				teardown()
			end
		end,
		Tooltip = 'Raises mv + horizontal velocity on the live simulation. Does not touch timers or sync blocking.',
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
end)

return '5315066937'
