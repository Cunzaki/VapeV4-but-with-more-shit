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
local tweenService = cloneref(game:GetService('TweenService'))
local httpService = cloneref(game:GetService('HttpService'))
local virtualInputManager = cloneref(game:GetService('VirtualInputManager'))
local teleportService = cloneref(game:GetService('TeleportService'))
local lightingService = cloneref(game:GetService('Lighting'))
local workspaceService = cloneref(game:GetService('Workspace'))

local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local vape = shared.vape

run(function()
	local AutoBhop
	local Fly
	local Noclip
	local Teleport
	local SpeedMult

	local speedMult = 1
	local bhopDelay = 0.03
	local flySpeed = 50
	local noclipActive = false

	local function getCharacter()
		return lplr.Character or lplr.CharacterAdded:Wait()
	end

	local function getRootPart()
		local char = getCharacter()
		if not char then return nil end
		for _, part in char:GetDescendants() do
			if part:IsA('BasePart') and part.Name == 'HumanoidRootPart' then
				return part
			end
		end
		return char:FindFirstChild('RootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	end

	local function pressSpace()
		virtualInputManager:SendKeyDown(Enum.KeyCode.Space)
		task.delay(0.01, function()
			virtualInputManager:SendKeyUp(Enum.KeyCode.Space)
		end)
	end

	AutoBhop = vape.Categories.Blatant:CreateModule({
		Name = 'AutoBhop',
		Function = function(callback)
			if callback then
				local lastJump = 0
				AutoBhop:Clean(runService.Heartbeat:Connect(function()
					local rootPart = getRootPart()
					if not rootPart then return end
					local now = tick()
					if now - lastJump < bhopDelay then return end
					local rayOrigin = rootPart.Position
					local rayDir = Vector3.new(0, -3.5, 0)
					local params = RaycastParams.new()
					params.FilterDescendantsInstances = {getCharacter()}
					params.FilterType = Enum.RaycastFilterType.Exclude
					local result = workspaceService:Raycast(rayOrigin, rayDir, params)
					if result then
						local vel = rootPart.AssemblyLinearVelocity
						local speed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
						if speed > 2 then
							lastJump = now
							pressSpace()
						end
					end
				end))
			end
		end,
		Tooltip = 'Auto bunny hop'
	})
	AutoBhop.Delay = AutoBhop:CreateSlider({
		Name = 'Jump Delay',
		Min = 0,
		Max = 0.2,
		Default = 0.03,
		Function = function(val)
			bhopDelay = val
		end
	})

	Fly = vape.Categories.Blatant:CreateModule({
		Name = 'Fly',
		Function = function(callback)
			if callback then
				Fly:Clean(runService.Heartbeat:Connect(function()
					local rootPart = getRootPart()
					if not rootPart then return end
					local vel = Vector3.zero
					if inputService:IsKeyDown(Enum.KeyCode.Space) then
						vel = vel + Vector3.new(0, flySpeed, 0)
					end
					if inputService:IsKeyDown(Enum.KeyCode.LeftControl) then
						vel = vel + Vector3.new(0, -flySpeed, 0)
					end
					local cam = gameCamera
					if cam then
						local lookCFrame = CFrame.new(rootPart.Position, cam.CFrame.Position)
						local forward = lookCFrame.LookVector
						local right = lookCFrame.RightVector
						if inputService:IsKeyDown(Enum.KeyCode.W) then
							vel = vel + forward * flySpeed
						end
						if inputService:IsKeyDown(Enum.KeyCode.S) then
							vel = vel - forward * flySpeed
						end
						if inputService:IsKeyDown(Enum.KeyCode.A) then
							vel = vel - right * flySpeed
						end
						if inputService:IsKeyDown(Enum.KeyCode.D) then
							vel = vel + right * flySpeed
						end
					end
					rootPart.AssemblyLinearVelocity = vel
				end))
			end
		end,
		Tooltip = 'Fly with WASD + Space/Ctrl'
	})
	Fly.Speed = Fly:CreateSlider({
		Name = 'Speed',
		Min = 10,
		Max = 200,
		Default = 50,
		Function = function(val)
			flySpeed = val
		end
	})

	Noclip = vape.Categories.Blatant:CreateModule({
		Name = 'Noclip',
		Function = function(callback)
			if callback then
				noclipActive = true
				Noclip:Clean(runService.Heartbeat:Connect(function()
					local char = getCharacter()
					if char then
						for _, part in char:GetDescendants() do
							if part:IsA('BasePart') then
								part.CanCollide = false
							end
						end
					end
				end))
			else
				noclipActive = false
			end
		end,
		Tooltip = 'No collision'
	})

	SpeedMult = vape.Categories.Blatant:CreateModule({
		Name = 'SpeedMult',
		Function = function(callback)
			if callback then
				SpeedMult:Clean(runService.Heartbeat:Connect(function()
					local rootPart = getRootPart()
					if not rootPart then return end
					local vel = rootPart.AssemblyLinearVelocity
					local hSpeed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
					if hSpeed > 0.5 then
						local dir = Vector3.new(vel.X / hSpeed, 0, vel.Z / hSpeed)
						rootPart.AssemblyLinearVelocity = Vector3.new(dir.X * hSpeed * speedMult, vel.Y, dir.Z * hSpeed * speedMult)
					end
				end))
			end
		end,
		Tooltip = 'Speed multiplier (works with movement)'
	})
	SpeedMult.Value = SpeedMult:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 10,
		Default = 2,
		Function = function(val)
			speedMult = val
		end
	})

	Teleport = vape.Categories.Utility:CreateModule({
		Name = 'Teleport',
		Function = function(callback)
		end,
		Tooltip = 'Teleport'
	})
	Teleport:CreateTextBox({
		Name = 'Position (x, y, z)',
		Default = '0, 5, 0',
		Function = function(val)
			local rootPart = getRootPart()
			if not rootPart then return end
			local parts = {}
			for p in val:gmatch('[^,]+') do
				table.insert(parts, tonumber(p:gsub(' ', '')))
			end
			if #parts >= 3 and parts[1] and parts[2] and parts[3] then
				rootPart.CFrame = CFrame.new(parts[1], parts[2], parts[3])
			end
		end
	})
end)

return '5315066937'
