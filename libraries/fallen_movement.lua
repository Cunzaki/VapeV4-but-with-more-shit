--[[ Fallen Survival movement modules — Iridescent source.lua ]]
local vape = shared.vape
local FS = vape.Libraries.fallenState
if not FS then return end

local run = function(f)
	local ok, err = pcall(f)
	if not ok then warn('[Fallen Movement]', err) end
end

local cloneref = cloneref or function(o) return o end
local players = cloneref(game:GetService('Players'))
local runService = cloneref(game:GetService('RunService'))
local userInputService = cloneref(game:GetService('UserInputService'))
local workspace = cloneref(game:GetService('Workspace'))

local lplr = players.LocalPlayer
local camera = workspace.CurrentCamera
local flags = FS.flags or {}

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local flyMod, infiniteFlyToggle
local bunnyMod, omniMod, noFallMod, silentMod

local function getCharParts()
	local char = FS.ClientCharacter or lplr.Character
	local root = char and char:FindFirstChild('HumanoidRootPart')
	local hum = char and char:FindFirstChildOfClass('Humanoid')
	return char, root, hum
end

local function velocityPulse(char, root, yVel)
	local oldVel = root.Velocity
	for _, part in char:GetChildren() do
		if part:IsA('BasePart') then
			part.Velocity = Vector3.new(0, yVel, 0)
		end
	end
	runService.RenderStepped:Wait()
	for _, part in char:GetChildren() do
		if part:IsA('BasePart') then
			part.Velocity = oldVel
		end
	end
end

run(function()
	flyMod = vape.Categories.Blatant:CreateModule({
		Name = 'Fly',
		Function = function(callback)
			flags.Fly = callback
		end,
		Tooltip = 'Camera-aligned fly (E up, Ctrl down, W/S pitch)',
	})

	local flySpeed = flyMod:CreateSlider({
		Name = 'Speed',
		Min = 1,
		Max = 10,
		Default = 3,
		Decimal = 10,
		Function = function(v) flags.FlySpeed = v end,
	})
	flags.FlySpeed = flySpeed.Value

	infiniteFlyToggle = flyMod:CreateToggle({
		Name = 'Infinite Fly',
		Darker = true,
		Function = function(v) flags.InfiniteFly = v end,
	})
end)

run(function()
	bunnyMod = vape.Categories.Blatant:CreateModule({
		Name = 'Bunnyhop',
		Function = function(callback)
			flags.Bunnyhop = callback
		end,
		Tooltip = 'Auto-jump while holding space on ground',
	})
end)

run(function()
	omniMod = vape.Categories.Blatant:CreateModule({
		Name = 'Omnisprint',
		Function = function(callback)
			flags.Omnisprint = callback
		end,
		Tooltip = 'Sprint forward in any direction while holding shift',
	})
end)

run(function()
	noFallMod = vape.Categories.Blatant:CreateModule({
		Name = 'NoFall',
		Function = function(callback)
			flags.NoFall = callback
		end,
		Tooltip = 'Cancel fall damage velocity pulse',
	})
end)

run(function()
	silentMod = vape.Categories.Blatant:CreateModule({
		Name = 'Silent Step',
		Function = function(callback)
			flags.SilentStep = callback
		end,
		Tooltip = 'Mute footstep sounds',
	})

	task.defer(function()
		if not hookfunction then return end
		local modules = game:GetService('ReplicatedStorage'):FindFirstChild('Modules')
		if not modules then return end
		local ok, soundMod = pcall(require, modules:WaitForChild('SoundModule', 8))
		if not ok or not soundMod then return end

		if soundMod.ToggleFootstep and not FS.SilentStepFootHooked then
			FS.SilentStepFootHooked = true
			local oldToggleFootstep
			oldToggleFootstep = hookfunction(soundMod.ToggleFootstep, function(self, ...)
				local args = { ... }
				if flags.SilentStep and args[3] then
					return soundMod:StopSound(args[3])
				end
				return oldToggleFootstep(self, ...)
			end)
		end

		if soundMod.PlaySound and not FS.SilentStepPlayHooked then
			FS.SilentStepPlayHooked = true
			local oldPlaySound
			oldPlaySound = hookfunction(soundMod.PlaySound, function(self, ...)
				local args = { ... }
				if flags.SilentStep and args[2] and args[2].Name == 'WalkWater' then
					return soundMod:StopSound(args[2])
				end
				return oldPlaySound(self, ...)
			end)
		end
	end)
end)

vape:Clean(runService.Heartbeat:Connect(function(delta)
	local char, root, hum = getCharParts()
	if not (char and root and hum) or hum.Health <= 0 then return end

	rayParams.FilterDescendantsInstances = { char, camera }

	if bunnyMod and bunnyMod.Enabled and flags.Bunnyhop then
		if tostring(hum.FloorMaterial) ~= 'Air' and userInputService:IsKeyDown(Enum.KeyCode.Space) then
			hum.Jump = true
		end
	end

	if omniMod and omniMod.Enabled and flags.Omnisprint and userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		hum.WalkSpeed = 19
		local sc = char:FindFirstChild('StateController')
		if sc then
			sc:SetAttribute('IsSprint', true)
			sc:SetAttribute('Direction', 'Forward')
		end
	end

	local isFlying = flyMod and flyMod.Enabled and flags.Fly
	if isFlying then
		local moveDelta = delta * (flags.FlySpeed or 3) * 3
		local move = hum.MoveDirection
		if userInputService:IsKeyDown(Enum.KeyCode.E) then move += Vector3.new(0, 1, 0) end
		if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move += Vector3.new(0, -1, 0) end
		if userInputService:IsKeyDown(Enum.KeyCode.W) then move += Vector3.new(0, camera.CFrame.LookVector.Y, 0) end
		if userInputService:IsKeyDown(Enum.KeyCode.S) then move += Vector3.new(0, -camera.CFrame.LookVector.Y, 0) end
		local pos = root.CFrame.Position + move * moveDelta
		hum.PlatformStand = false
		root.Velocity = Vector3.zero
		root.CFrame = CFrame.new(pos, pos + Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z))
	end

	if isFlying and flags.InfiniteFly then
		local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams)
		if result and result.Distance > 4 then
			velocityPulse(char, root, -9999)
		end
	end

	if noFallMod and noFallMod.Enabled and flags.NoFall and not isFlying then
		local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams)
		if result and result.Distance > 10 then
			velocityPulse(char, root, 9999)
		end
	end
end))
