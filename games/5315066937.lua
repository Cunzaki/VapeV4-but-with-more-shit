local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end
local vapeEvents = setmetatable({}, {
	__index = function(self, index)
		self[index] = Instance.new('BindableEvent')
		return self[index]
	end
})

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))
local inputService = cloneref(game:GetService('UserInputService'))
local virtualInputManager = cloneref(game:GetService('VirtualInputManager'))
local workspaceService = cloneref(game:GetService('Workspace'))

local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local vape = shared.vape

local function obtain(name)
	return _G.obtain and _G.obtain(name) or nil
end

run(function()
	local SpeedHack
	local VelocityHack
	local FlyHack
	local NoclipHack
	local TeleportHack
	local BhopHack

	SpeedHack = vape.Categories.Blatant:CreateModule({
		Name = 'SpeedHack',
		Function = function(callback)
			if callback then
				SpeedHack:Clean(runService.Heartbeat:Connect(function()
					local timerSys = obtain("RealtimeTimerSystem")
					if timerSys and timerSys.RootTimer then
						timerSys.RootTimer.Scale = SpeedHack.SpeedValue.Value
					end
				end))
			else
				local timerSys = obtain("RealtimeTimerSystem")
				if timerSys and timerSys.RootTimer then
					timerSys.RootTimer.Scale = 1
				end
			end
		end,
		Tooltip = 'Speed up game simulation ticks (Timer Scale)'
	})
	SpeedHack.SpeedValue = SpeedHack:CreateSlider({
		Name = 'Speed',
		Min = 1,
		Max = 10,
		Default = 2,
		Function = function() end
	})

	VelocityHack = vape.Categories.Blatant:CreateModule({
		Name = 'VelocityHack',
		Function = function(callback)
			if callback then
				VelocityHack:Clean(runService.Heartbeat:Connect(function()
					local ctxMgr = obtain("ContextManager")
					if not ctxMgr then return end
					local localCtx = ctxMgr.GetContext("Local")
					if localCtx and localCtx.Context and localCtx.Context.Simulation then
						local mechanics = localCtx.Context.Simulation.GameMechanics
						if mechanics then
							mechanics.MaxSpeed = VelocityHack.SpeedValue.Value * 100
							mechanics.Accelerate = VelocityHack.SpeedValue.Value * 10
							mechanics.AirAccelerate = VelocityHack.SpeedValue.Value * 10
						end
					end
				end))
			end
		end,
		Tooltip = 'Modify internal GameMechanics physics limits'
	})
	VelocityHack.SpeedValue = VelocityHack:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 100,
		Default = 5,
		Function = function() end
	})

	BhopHack = vape.Categories.Blatant:CreateModule({
		Name = 'BhopHack',
		Function = function(callback)
			if callback then
				local lastJump = 0
				BhopHack:Clean(runService.Heartbeat:Connect(function()
					local CustomEnums = obtain("CustomEnums")
					local TICKINFO_BIT_TOUCHING = CustomEnums and CustomEnums.TICKINFO_BIT_TOUCHING or 8
					local ctxMgr = obtain("ContextManager")
					if not ctxMgr then return end
					
					local localCtx = ctxMgr.GetContext("Local")
					if localCtx and localCtx.Context and localCtx.Context.GetOutput then
						local _, tickInfo = localCtx.Context:GetOutput()
						if tickInfo and bit32.band(tickInfo, TICKINFO_BIT_TOUCHING) ~= 0 then
							local now = tick()
							if now - lastJump > 0.05 then
								lastJump = now
								virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
								task.delay(0.01, function()
									virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
								end)
							end
						end
					end
				end))
			end
		end,
		Tooltip = 'Perfect auto bunny hop using game tick data'
	})

	local cachedGravity = nil
	FlyHack = vape.Categories.Blatant:CreateModule({
		Name = 'FlyHack',
		Function = function(callback)
			local ctxMgr = obtain("ContextManager")
			if callback then
				FlyHack:Clean(runService.Heartbeat:Connect(function()
					if not ctxMgr then return end
					local localCtx = ctxMgr.GetContext("Local")
					if localCtx and localCtx.Context and localCtx.Context.Simulation then
						local mechanics = localCtx.Context.Simulation.GameMechanics
						if mechanics then
							if cachedGravity == nil then
								cachedGravity = mechanics.Gravity
							end
							mechanics.Gravity = 0
						end
					end
				end))
			else
				if ctxMgr and cachedGravity ~= nil then
					local localCtx = ctxMgr.GetContext("Local")
					if localCtx and localCtx.Context and localCtx.Context.Simulation then
						local mechanics = localCtx.Context.Simulation.GameMechanics
						if mechanics then
							mechanics.Gravity = cachedGravity
						end
					end
				end
			end
		end,
		Tooltip = 'Zero gravity fly using GameMechanics'
	})

	NoclipHack = vape.Categories.Blatant:CreateModule({
		Name = 'NoclipHack',
		Function = function(callback)
			if callback then
				NoclipHack:Clean(runService.Heartbeat:Connect(function()
					local mapMgr = obtain("MapManager")
					if mapMgr and mapMgr.MapInfo and mapMgr.MapInfo.RobloxModel then
						for _, part in mapMgr.MapInfo.RobloxModel:GetDescendants() do
							if part:IsA("BasePart") and part.CanCollide then
								part.CanCollide = false
							end
						end
					end
				end))
			else
				local mapMgr = obtain("MapManager")
				if mapMgr and mapMgr.MapInfo and mapMgr.MapInfo.RobloxModel then
					for _, part in mapMgr.MapInfo.RobloxModel:GetDescendants() do
						if part:IsA("BasePart") then
							part.CanCollide = true
						end
					end
				end
			end
		end,
		Tooltip = 'Disable collision on map parts'
	})

	TeleportHack = vape.Categories.Utility:CreateModule({
		Name = 'TeleportHack',
		Function = function(callback) end,
		Tooltip = 'Teleport to position'
	})
	TeleportHack:CreateTextBox({
		Name = 'Value',
		Default = '0, 5, 0',
		Function = function(val)
			if type(val) ~= "string" then return end
			local parts = {}
			for p in val:gmatch('[^,]+') do
				table.insert(parts, tonumber(p:gsub(' ', '')))
			end
			if #parts >= 3 and parts[1] and parts[2] and parts[3] then
				local pos = Vector3.new(parts[1], parts[2], parts[3])
				local posChar = obtain("PositionCharacter")
				if posChar and posChar.SetCharacterCFrame then
					posChar.SetCharacterCFrame("Local", CFrame.new(pos), 1)
				end
			end
		end
	})
end)

return '5315066937'
