--[[
	Ugc place 5315066937 — custom surf/bhop engine.

	Movement cap is StyleInfo.mv on the live Simulation's GameMechanics instance
	(Module_67 strafe code). PlaybackContext.StyleInfo is a separate table.

	Do NOT use Timer:SetScale / timescale for speed — SimulationSynchronization
	compares client vs server timelines and aborts resync ("Impossible case").
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

local RESOLVE_INTERVAL = 2
local APPLY_INTERVAL = 0.03

local speedState = {
	mechanics = {},
	mechBaselines = {},
	lastStyleInfo = {},
	contextManager = nil,
	view = nil,
	lastResolveAt = 0,
	lastApplyAt = 0,
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

local function looksLikeGameMechanics(obj)
	return type(obj) == 'table'
		and type(obj.SetStyle) == 'function'
		and type(obj.PropagateControls) == 'function'
		and type(obj.StyleInfo) == 'table'
		and type(obj.StyleInfo.mv) == 'number'
end

local function looksLikeSimSync(obj)
	return type(obj) == 'table'
		and type(obj.SynchronizeState) == 'function'
		and type(obj.Run) == 'function'
		and type(obj.BindSimulation) == 'function'
		and obj.Simulation ~= nil
end

local function addMechanics(list, seen, mech)
	if not looksLikeGameMechanics(mech) or seen[mech] then
		return
	end
	seen[mech] = true
	table.insert(list, mech)
end

local function collectFromSimulation(list, seen, sim)
	if type(sim) ~= 'table' then
		return
	end
	addMechanics(list, seen, sim.GameMechanics)
end

local function collectFromRealtimeContext(list, seen, ctx)
	if type(ctx) ~= 'table' then
		return
	end
	collectFromSimulation(list, seen, ctx.Simulation)
	collectFromSimulation(list, seen, ctx)
end

local function resolveSpeedTargets(force)
	local now = tick()
	if not force and now - speedState.lastResolveAt < RESOLVE_INTERVAL and #speedState.mechanics > 0 then
		return true
	end
	speedState.lastResolveAt = now
	speedState.mechanics = {}

	if not getgc then
		return false
	end
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return false
	end

	speedState.contextManager = nil
	speedState.view = nil
	local simSync = nil

	for _, obj in gc do
		if type(obj) ~= 'table' then
			continue
		end
		if not speedState.contextManager and looksLikeContextManager(obj) then
			speedState.contextManager = obj
		elseif not speedState.view and looksLikeView(obj) then
			speedState.view = obj
		elseif not simSync and looksLikeSimSync(obj) then
			simSync = obj
		end
	end

	local seen = {}
	local mechanics = {}

	local playback
	if speedState.contextManager then
		local ok, result = pcall(function()
			return speedState.contextManager.GetContext('Local') or speedState.contextManager.GetContext(lplr)
		end)
		if ok and type(result) == 'table' then
			playback = result
		end
	end
	if not playback and speedState.view then
		playback = speedState.view.PlaybackContext
	end

	if playback and playback.Context then
		collectFromRealtimeContext(mechanics, seen, playback.Context)
	end

	if simSync then
		collectFromSimulation(mechanics, seen, simSync.Simulation)
		collectFromSimulation(mechanics, seen, simSync.KetchupSimulation)
	end

	speedState.mechanics = mechanics
	return #mechanics > 0
end

local function ensureBaseline(mech, multiplier)
	local si = mech.StyleInfo
	if not si then
		return false
	end
	local lastSi = speedState.lastStyleInfo[mech]
	if speedState.mechBaselines[mech] and lastSi == si then
		return true
	end
	local baseMv = si.mv
	if speedState.mechBaselines[mech] and lastSi ~= si and multiplier > 1 then
		baseMv = si.mv / multiplier
	end
	speedState.mechBaselines[mech] = {
		mv = baseMv,
		air_accel = si.air_accel,
	}
	speedState.lastStyleInfo[mech] = si
	return true
end

local function applyStyleMultiplier(multiplier)
	if multiplier <= 1 then
		return false
	end
	local applied = false
	for _, mech in speedState.mechanics do
		if not ensureBaseline(mech, multiplier) then
			continue
		end
		local si = mech.StyleInfo
		local base = speedState.mechBaselines[mech]
		if not si or not base then
			continue
		end
		si.mv = base.mv * multiplier
		if base.air_accel then
			si.air_accel = base.air_accel * multiplier
		end
		applied = true
	end
	return applied
end

local function restoreSpeedBoost()
	for mech, base in speedState.mechBaselines do
		local si = mech.StyleInfo
		if si and base.mv then
			si.mv = base.mv
		end
		if si and base.air_accel then
			si.air_accel = base.air_accel
		end
	end
	speedState.mechBaselines = {}
	speedState.lastStyleInfo = {}
end

local function resetSpeedCache()
	speedState.mechanics = {}
	speedState.mechBaselines = {}
	speedState.lastStyleInfo = {}
	speedState.contextManager = nil
	speedState.view = nil
	speedState.lastResolveAt = 0
	speedState.lastApplyAt = 0
end

run(function()
	local speedActive = false
	local speedMultiplier = 1.5
	local resolveFailStreak = 0

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
				if not resolveSpeedTargets(true) then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Waiting for map simulation…', 4)
					end)
				else
					applyStyleMultiplier(speedMultiplier)
				end
				local tickEvent = runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not speedActive then
						return
					end
					local now = tick()
					if now - speedState.lastApplyAt < APPLY_INTERVAL then
						return
					end
					speedState.lastApplyAt = now

					if #speedState.mechanics == 0 then
						if resolveSpeedTargets(false) then
							resolveFailStreak = 0
						else
							resolveFailStreak += 1
							if resolveFailStreak >= 60 then
								resolveFailStreak = 0
								resolveSpeedTargets(true)
							end
						end
					end

					if #speedState.mechanics > 0 then
						applyStyleMultiplier(speedMultiplier)
						resolveFailStreak = 0
					end
				end))
			else
				restoreSpeedBoost()
				resetSpeedCache()
			end
		end,
		Tooltip = 'Raises StyleInfo.mv on your live simulation GameMechanics (ground/air accel cap). Does not touch timers — timer scaling desyncs SimulationSynchronization.',
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
