--[[
	Ugc place 5315066937 — custom surf/bhop engine (Load.ModuleScript DI).

	After bootstrap, ReplicatedStorage Client/Shared modules are destroyed and
	_G.obtain is nilled. Cheat hooks must resolve singletons from getgc().

	Local simulation path:
		ContextManager.GetContext("Local").Context.Simulation.GameMechanics
		View.PlaybackContext.Context:GetPV()  -> position, velocity (HUD speed)
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
	mechanics = nil,
	mechanicsBaseline = nil,
	lastResolveAt = 0,
}

local function looksLikeContextManager(obj)
	return type(obj) == 'table'
		and type(rawget(obj, 'GetContext')) == 'function'
		and type(rawget(obj, 'Contexts')) == 'table'
end

local function looksLikeView(obj)
	return type(obj) == 'table'
		and type(rawget(obj, 'Player')) == 'string'
		and rawget(obj, 'PlaybackContext') ~= nil
end

local function looksLikeGameMechanics(obj)
	return type(obj) == 'table'
		and type(rawget(obj, 'MaxSpeed')) == 'number'
		and (type(rawget(obj, 'Accelerate')) == 'number' or type(rawget(obj, 'SetStyle')) == 'function')
end

local function resolveGameApi(force)
	local now = tick()
	if not force and gameApi.contextManager and now - gameApi.lastResolveAt < 2 then
		return gameApi
	end
	gameApi.lastResolveAt = now
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
	return gameApi
end

local function getMechanicsFromContext(contextManager)
	if not contextManager then
		return nil
	end
	local playback = contextManager.GetContext('Local')
	if not playback or not playback.Context then
		return nil
	end
	local simulation = playback.Context.Simulation
	if not simulation then
		return nil
	end
	local mechanics = simulation.GameMechanics
	if looksLikeGameMechanics(mechanics) then
		return mechanics
	end
	return nil
end

local function getMechanicsFromView(view)
	if not view or not view.PlaybackContext or not view.PlaybackContext.Context then
		return nil
	end
	local simulation = view.PlaybackContext.Context.Simulation
	if not simulation then
		return nil
	end
	local mechanics = simulation.GameMechanics
	if looksLikeGameMechanics(mechanics) then
		return mechanics
	end
	return nil
end

local function scanGcForMechanics()
	if not getgc then
		return nil
	end
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return nil
	end
	for _, obj in gc do
		if looksLikeGameMechanics(obj) then
			return obj
		end
	end
	return nil
end

local function getLocalGameMechanics(force)
	if not force and gameApi.mechanics and looksLikeGameMechanics(gameApi.mechanics) then
		return gameApi.mechanics
	end
	resolveGameApi(force)
	local mechanics = getMechanicsFromContext(gameApi.contextManager)
		or getMechanicsFromView(gameApi.view)
		or scanGcForMechanics()
	gameApi.mechanics = mechanics
	return mechanics
end

local function captureMechanicsBaseline(mech)
	if not mech or gameApi.mechanicsBaseline then
		return
	end
	gameApi.mechanicsBaseline = {
		MaxSpeed = mech.MaxSpeed,
		Accelerate = mech.Accelerate,
		AirAccelerate = mech.AirAccelerate,
	}
end

local function restoreMechanics()
	local mech = gameApi.mechanics
	local base = gameApi.mechanicsBaseline
	if mech and base then
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
	gameApi.mechanicsBaseline = nil
end

local function applySpeedMultiplier(multiplier)
	local mech = getLocalGameMechanics(false)
	if not mech then
		return false
	end
	captureMechanicsBaseline(mech)
	local base = gameApi.mechanicsBaseline
	if not base then
		return false
	end
	if base.MaxSpeed then
		mech.MaxSpeed = base.MaxSpeed * multiplier
	end
	if base.Accelerate then
		mech.Accelerate = base.Accelerate * multiplier
	end
	if base.AirAccelerate then
		mech.AirAccelerate = base.AirAccelerate * multiplier
	end
	return true
end

local function resetMechanicsCache()
	gameApi.mechanics = nil
	gameApi.mechanicsBaseline = nil
end

run(function()
	local speedActive = false
	local speedMultiplier = 1.5
	local resolveFailStreak = 0

	lplr.CharacterAdded:Connect(function()
		resetMechanicsCache()
	end)

	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			speedActive = callback
			if callback then
				resetMechanicsCache()
				resolveGameApi(true)
				if not applySpeedMultiplier(speedMultiplier) then
					pcall(function()
						vape:CreateNotification('Speed Boost', 'Waiting for simulation to load…', 4)
					end)
				end
				Speed:Clean(runService.Heartbeat:Connect(function()
					if not speedActive then
						return
					end
					if applySpeedMultiplier(speedMultiplier) then
						resolveFailStreak = 0
						return
					end
					resolveFailStreak += 1
					if resolveFailStreak >= 60 then
						resolveFailStreak = 0
						resetMechanicsCache()
						resolveGameApi(true)
					end
				end))
			else
				restoreMechanics()
				resetMechanicsCache()
			end
		end,
		Tooltip = 'Multiplies local GameMechanics MaxSpeed/Accelerate/AirAccelerate. Uses the custom surf sim (not Humanoid.WalkSpeed). High values may desync validated runs.',
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
end)

return '5315066937'
