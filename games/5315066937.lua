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
local assetfunction = getcustomasset

local vape = shared.vape
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo
local sessioninfo = vape.Libraries.sessioninfo
local uipallet = vape.Libraries.uipallet
local tween = vape.Libraries.tween
local color = vape.Libraries.color
local whitelist = vape.Libraries.whitelist
local prediction = vape.Libraries.prediction
local getfontsize = vape.Libraries.getfontsize
local getcustomasset = vape.Libraries.getcustomasset

local function getobtain(name)
	local rs = replicatedStorage
	local client = rs:FindFirstChild('Client')
	if client then
		local mod = client:FindFirstChild(name)
		if mod and mod:IsA('ModuleScript') then
			return require(mod)
		end
	end
	local shared = rs:FindFirstChild('Shared')
	if shared then
		local mod = shared:FindFirstChild(name)
		if mod and mod:IsA('ModuleScript') then
			return require(mod)
		end
	end
	return nil
end

run(function()
	local Speed
	local BHop
	local Teleport
	local Fly
	local Noclip

	local function getCharacter()
		return lplr.Character or lplr.CharacterAdded:Wait()
	end

	local function getHRP()
		local char = getCharacter()
		return char and char:FindFirstChild('HumanoidRootPart')
	end

	local function getVelocity()
		local hrp = getHRP()
		return hrp and hrp.AssemblyLinearVelocity or Vector3.zero
	end

	local function setVelocity(vec3)
		local hrp = getHRP()
		if hrp then
			hrp.AssemblyLinearVelocity = vec3
		end
	end

	local function getHorizontalSpeed()
		local vel = getVelocity()
		return math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
	end

	local function isGrounded()
		local hrp = getHRP()
		if not hrp then return false end
		local rayOrigin = hrp.Position
		local rayDir = Vector3.new(0, -3.5, 0)
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {getCharacter()}
		params.FilterType = Enum.RaycastFilterType.Exclude
		local result = workspaceService:Raycast(rayOrigin, rayDir, params)
		return result ~= nil
	end

	local function pressSpace()
		virtualInputManager:SendKeyDown(Enum.KeyCode.Space)
		task.delay(0.01, function()
			virtualInputManager:SendKeyUp(Enum.KeyCode.Space)
		end)
	end

	local function pressKey(key)
		virtualInputManager:SendKeyDown(key)
		task.delay(0.01, function()
			virtualInputManager:SendKeyUp(key)
		end)
	end

	Speed = vape.Categories.Blatant:CreateModule({
		Name = 'Speed',
		Function = function(callback)
			if callback then
				Speed:Clean(runService.Heartbeat:Connect(function()
					local hrp = getHRP()
					if not hrp then return end
					local currentVel = getVelocity()
					local horizontalSpeed = math.sqrt(currentVel.X * currentVel.X + currentVel.Z * currentVel.Z)
					if horizontalSpeed > 0.5 then
						local multiplier = Speed.Multiplier.Value
						local moveDir = currentVel
						if horizontalSpeed > 0.1 then
							moveDir = Vector3.new(currentVel.X / horizontalSpeed, 0, currentVel.Z / horizontalSpeed)
						end
						local newSpeed = horizontalSpeed * multiplier
						local newVel = Vector3.new(
							moveDir.X * newSpeed,
							currentVel.Y,
							moveDir.Z * newSpeed
						)
						setVelocity(newVel)
					end
				end))
			end
		end,
		Tooltip = 'Multiply your horizontal velocity'
	})
	Speed.Multiplier = Speed:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 5,
		Default = 2,
		Function = function() end
	})

	BHop = vape.Categories.Blatant:CreateModule({
		Name = 'BHop',
		Function = function(callback)
			if callback then
				local lastJumpTime = 0
				BHop:Clean(runService.Heartbeat:Connect(function()
					local hrp = getHRP()
					if not hrp then return end
					local now = tick()
					local jumpDelay = BHop.JumpDelay.Value
					if now - lastJumpTime < jumpDelay then return end
					local grounded = isGrounded()
					if grounded then
						local vel = getVelocity()
						local speed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
						if speed > 2 then
							lastJumpTime = now
							if BHop.AutoJump.Value then
								pressSpace()
							end
						end
					end
				end))
			end
		end,
		Tooltip = 'Auto bunny hop'
	})
	BHop.AutoJump = BHop:CreateToggle({
		Name = 'Auto Jump',
		Default = true,
		Function = function() end
	})
	BHop.JumpDelay = BHop:CreateSlider({
		Name = 'Jump Delay',
		Min = 0,
		Max = 0.2,
		Default = 0.03,
		Function = function() end
	})

	Fly = vape.Categories.Blatant:CreateModule({
		Name = 'Fly',
		Function = function(callback)
			if callback then
				local verticalVel = 0
				Fly:Clean(runService.Heartbeat:Connect(function(dt)
					local hrp = getHRP()
					if not hrp then return end
					local speed = Fly.Speed.Value
					local upKey = inputService:IsKeyDown(Enum.KeyCode.Space)
					local downKey = inputService:IsKeyDown(Enum.KeyCode.LeftControl) or inputService:IsKeyDown(Enum.KeyCode.LeftShift)
					if upKey then
						verticalVel = speed
					elseif downKey then
						verticalVel = -speed
					else
						verticalVel = 0
					end
					local currentVel = getVelocity()
					local cam = gameCamera
					if cam then
						local lookCFrame = CFrame.new(hrp.Position, cam.CFrame.Position)
						local forward = lookCFrame.LookVector
						local right = lookCFrame.RightVector
						local moveDir = Vector3.zero
						if inputService:IsKeyDown(Enum.KeyCode.W) then
							moveDir = moveDir + forward
						end
						if inputService:IsKeyDown(Enum.KeyCode.S) then
							moveDir = moveDir - forward
						end
						if inputService:IsKeyDown(Enum.KeyCode.A) then
							moveDir = moveDir - right
						end
						if inputService:IsKeyDown(Enum.KeyCode.D) then
							moveDir = moveDir + right
						end
						if moveDir.Magnitude > 0.1 then
							moveDir = moveDir.Unit
						end
						local newVel = Vector3.new(moveDir.X * speed, verticalVel, moveDir.Z * speed)
						setVelocity(newVel)
					end
				end))
			end
		end,
		Tooltip = 'Fly around freely'
	})
	Fly.Speed = Fly:CreateSlider({
		Name = 'Speed',
		Min = 10,
		Max = 200,
		Default = 50,
		Function = function() end
	})

	Noclip = vape.Categories.Blatant:CreateModule({
		Name = 'Noclip',
		Function = function(callback)
			if callback then
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
			end
		end,
		Tooltip = 'Pass through walls'
	})

	Teleport = vape.Categories.Utility:CreateModule({
		Name = 'Teleport',
		Function = function(callback)
			if callback then
			end
		end,
		Tooltip = 'Teleport to positions and players'
	})
	Teleport:CreateDropdown({
		Name = 'Teleport Mode',
		List = {'To Position', 'To Player'},
		Function = function(val)
			Teleport.PositionInput.Visible = (val == 'To Position')
			Teleport.PlayerInput.Visible = (val == 'To Player')
		end
	})
	Teleport.PositionInput = Teleport:CreateTextBox({
		Name = 'Position (x, y, z)',
		Default = '0, 5, 0',
		Function = function(val)
			local hrp = getHRP()
			if not hrp then return end
			local parts = {}
			for part in val:gmatch('[^,]+') do
				table.insert(parts, tonumber(part:gsub(' ', '')))
			end
			if #parts >= 3 and parts[1] and parts[2] and parts[3] then
				hrp.CFrame = CFrame.new(Vector3.new(parts[1], parts[2], parts[3]))
			end
		end
	})
	Teleport.PlayerInput = Teleport:CreateTextBox({
		Name = 'Player Name',
		Default = '',
		Function = function(val)
			if val == '' then return end
			local targetPlayer = nil
			for _, player in playersService:GetPlayers() do
				if player.Name:lower():find(val:lower(), 1, true) then
					targetPlayer = player
					break
				end
			end
			if targetPlayer and targetPlayer.Character then
				local hrp2 = targetPlayer.Character:FindFirstChild('HumanoidRootPart')
				local myHRP = getHRP()
				if hrp2 and myHRP then
					myHRP.CFrame = CFrame.new(hrp2.Position)
				end
			end
		end
	})
	Teleport.SmoothTeleport = Teleport:CreateToggle({
		Name = 'Smooth Teleport',
		Default = false,
		Function = function() end
	})
end)

return '5315066937'
