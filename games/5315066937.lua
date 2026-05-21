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

local function obtain(name)
	return _G.obtain(name)
end

run(function()
	local SpeedHack
	local FlyHack
	local NoclipHack
	local TeleportHack
	local BhopHack

	local speedCoeff = 1
	local flyEnabled = false
	local noclipEnabled = false

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

	local function setCharacterCFrame(pos)
		local posChar = obtain("PositionCharacter")
		if posChar and posChar.SetCharacterCFrameFromPlayer then
			posChar.SetCharacterCFrameFromPlayer("Local", pos)
		end
	end

	local function pressSpace()
		virtualInputManager:SendKeyDown(Enum.KeyCode.Space)
		task.delay(0.01, function()
			virtualInputManager:SendKeyUp(Enum.KeyCode.Space)
		end)
	end

	SpeedHack = vape.Categories.Blatant:CreateModule({
		Name = 'SpeedHack',
		Function = function(callback)
			if callback then
				speedCoeff = SpeedHack.SpeedValue.Value
				local visMgr = obtain("VisibilityManager")
				if visMgr and visMgr.SetSpeedCoeff then
					visMgr.SetSpeedCoeff(speedCoeff)
				end
				SpeedHack:Clean(runService.Heartbeat:Connect(function()
					speedCoeff = SpeedHack.SpeedValue.Value
					if visMgr and visMgr.SetSpeedCoeff then
						visMgr.SetSpeedCoeff(speedCoeff)
					end
				end))
			else
				local visMgr = obtain("VisibilityManager")
				if visMgr and visMgr.SetSpeedCoeff then
					visMgr.SetSpeedCoeff(1)
				end
			end
		end,
		Tooltip = 'Modify game speed coefficient'
	})
	SpeedHack.SpeedValue = SpeedHack:CreateSlider({
		Name = 'Speed',
		Min = 1,
		Max = 10,
		Default = 2,
		Function = function(val)
			speedCoeff = val
			local visMgr = obtain("VisibilityManager")
			if visMgr and visMgr.SetSpeedCoeff then
				visMgr.SetSpeedCoeff(val)
			end
		end
	})

	BhopHack = vape.Categories.Blatant:CreateModule({
		Name = 'BhopHack',
		Function = function(callback)
			if callback then
				local lastJump = 0
				BhopHack:Clean(runService.Heartbeat:Connect(function()
					local rootPart = getRootPart()
					if not rootPart then return end
					local now = tick()
					local delay = BhopHack.Delay.Value
					if now - lastJump < delay then return end
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
	BhopHack.Delay = BhopHack:CreateSlider({
		Name = 'Jump Delay',
		Min = 0,
		Max = 0.2,
		Default = 0.03,
		Function = function() end
	})

	FlyHack = vape.Categories.Blatant:CreateModule({
		Name = 'FlyHack',
		Function = function(callback)
			if callback then
				flyEnabled = true
				local flySpeed = FlyHack.SpeedValue.Value
				FlyHack:Clean(runService.Heartbeat:Connect(function()
					flySpeed = FlyHack.SpeedValue.Value
					local rootPart = getRootPart()
					if not rootPart then return end
					local vel = Vector3.zero
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
						if inputService:IsKeyDown(Enum.KeyCode.Space) then
							vel = vel + Vector3.new(0, flySpeed, 0)
						end
						if inputService:IsKeyDown(Enum.KeyCode.LeftControl) then
							vel = vel - Vector3.new(0, flySpeed, 0)
						end
					end
					rootPart.AssemblyLinearVelocity = vel
				end))
			else
				flyEnabled = false
			end
		end,
		Tooltip = 'Fly with WASD + Space/Ctrl'
	})
	FlyHack.SpeedValue = FlyHack:CreateSlider({
		Name = 'Speed',
		Min = 10,
		Max = 200,
		Default = 50,
		Function = function() end
	})

	NoclipHack = vape.Categories.Blatant:CreateModule({
		Name = 'NoclipHack',
		Function = function(callback)
			if callback then
				noclipEnabled = true
				NoclipHack:Clean(runService.Heartbeat:Connect(function()
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
				noclipEnabled = false
			end
		end,
		Tooltip = 'No collision'
	})

	TeleportHack = vape.Categories.Utility:CreateModule({
		Name = 'TeleportHack',
		Function = function(callback)
		end,
		Tooltip = 'Teleport to position or player'
	})
	TeleportHack:CreateDropdown({
		Name = 'Mode',
		List = {'Position', 'Player'},
		Function = function() end
	})
	TeleportHack:CreateTextBox({
		Name = 'Value',
		Default = '0, 5, 0',
		Function = function(val)
			local parts = {}
			for p in val:gmatch('[^,]+') do
				table.insert(parts, tonumber(p:gsub(' ', '')))
			end
			if #parts >= 3 and parts[1] and parts[2] and parts[3] then
				local pos = Vector3.new(parts[1], parts[2], parts[3])
				setCharacterCFrame(pos)
			end
		end
	})
end)

return '5315066937'
