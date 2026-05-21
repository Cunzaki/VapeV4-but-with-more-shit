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

run(function()
	local Speed
	local VelocityExploit
	local BHop
	local Teleport

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

	local function getMoveDirection()
		local hrp = getHRP()
		if not hrp then return Vector3.zero end
		local vel = getVelocity()
		local horizontalSpeed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
		if horizontalSpeed > 0.5 then
			return Vector3.new(vel.X / horizontalSpeed, 0, vel.Z / horizontalSpeed)
		end
		local cam = workspaceService.CurrentCamera
		if cam then
			local lookVector = cam.CFrame.LookVector
			return Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		end
		return Vector3.zero
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
					if horizontalSpeed > 1 then
						local multiplier = Speed.Multiplier.Value
						local verticalBoost = Speed.VerticalBoost.Value
						local moveDir = getMoveDirection()
						local newSpeed = horizontalSpeed * multiplier
						local newVel = Vector3.new(
							moveDir.X * newSpeed,
							currentVel.Y + verticalBoost,
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
	Speed.VerticalBoost = Speed:CreateSlider({
		Name = 'Vertical Boost',
		Min = 0,
		Max = 50,
		Default = 0,
		Function = function() end
	})

	VelocityExploit = vape.Categories.Blatant:CreateModule({
		Name = 'VelocityExploit',
		Function = function(callback)
			if callback then
				VelocityExploit:Clean(runService.Heartbeat:Connect(function(dt)
					local hrp = getHRP()
					if not hrp then return end
					local currentVel = getVelocity()
					local isOnGround = isGrounded()
					local tickRate = VelocityExploit.TickRate.Value
					local dtAdjusted = math.min(dt, 1/tickRate)
					local friction = isOnGround and VelocityExploit.GroundFriction.Value or VelocityExploit.AirFriction.Value
					local frictionForce = currentVel * friction * dtAdjusted * tickRate * 0.1
					local newVel = currentVel - frictionForce
					if VelocityExploit.GravityReduce.Value > 0 and not isOnGround then
						local gravMult = 1 - (VelocityExploit.GravityReduce.Value / 100)
						newVel = Vector3.new(newVel.X, newVel.Y * gravMult, newVel.Z)
					end
					local horizontalSpeed = math.sqrt(newVel.X * newVel.X + newVel.Z * newVel.Z)
					local baseSpeed = VelocityExploit.BaseSpeed.Value
					local boostMult = VelocityExploit.BoostMultiplier.Value
					if horizontalSpeed < baseSpeed then
						local scale = (baseSpeed * boostMult) / math.max(horizontalSpeed, 0.1)
						newVel = Vector3.new(newVel.X * scale * 0.1, newVel.Y, newVel.Z * scale * 0.1)
					end
					setVelocity(newVel)
				end))
			end
		end,
		Tooltip = 'Custom physics velocity manipulation'
	})
	VelocityExploit.BaseSpeed = VelocityExploit:CreateSlider({
		Name = 'Base Speed',
		Min = 10,
		Max = 200,
		Default = 50,
		Function = function() end
	})
	VelocityExploit.BoostMultiplier = VelocityExploit:CreateSlider({
		Name = 'Boost Multiplier',
		Min = 1,
		Max = 3,
		Default = 1.2,
		Function = function() end
	})
	VelocityExploit.GravityReduce = VelocityExploit:CreateSlider({
		Name = 'Gravity Reduce %',
		Min = 0,
		Max = 90,
		Default = 0,
		Function = function() end
	})
	VelocityExploit.GroundFriction = VelocityExploit:CreateSlider({
		Name = 'Ground Friction',
		Min = 0,
		Max = 2,
		Default = 0.1,
		Function = function() end
	})
	VelocityExploit.AirFriction = VelocityExploit:CreateSlider({
		Name = 'Air Friction',
		Min = 0,
		Max = 1,
		Default = 0.01,
		Function = function() end
	})
	VelocityExploit.TickRate = VelocityExploit:CreateSlider({
		Name = 'Tick Rate',
		Min = 30,
		Max = 120,
		Default = 60,
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
					if isGrounded() then
						local vel = getVelocity()
						local speed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
						if speed > 3 then
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
		Default = 0,
		Function = function() end
	})
	BHop.JumpPower = BHop:CreateSlider({
		Name = 'Jump Power',
		Min = 0,
		Max = 100,
		Default = 50,
		Function = function() end
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
