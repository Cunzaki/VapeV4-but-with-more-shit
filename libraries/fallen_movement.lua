--[[ Fallen Survival movement — ported from Iridescent source.lua ]]
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

local directionTable = {
	Forward = false, Backward = false, Left = false, Right = false,
	Sprint = false, Crouch = false,
	ForwardLeft = false, ForwardRight = false, BackwardLeft = false, BackwardRight = false,
}

run(function()
	local Movement = vape.Categories.Blatant:CreateModule({
		Name = 'Fallen Movement',
		Function = function(callback)
			flags.FallenMovement = callback
		end,
		Tooltip = 'Fly, bunnyhop, omnisprint, no fall — Iridescent logic',
	})

	local FlyToggle = Movement:CreateToggle({
		Name = 'Fly',
		Function = function(v) flags.Fly = v end,
	})

	Movement:CreateSlider({
		Name = 'Fly Speed',
		Min = 1,
		Max = 10,
		Default = 3,
		Decimal = 10,
		Function = function(v) flags.FlySpeed = v end,
	})
	flags.FlySpeed = 3

	Movement:CreateToggle({
		Name = 'Infinite Fly',
		Function = function(v) flags.InfiniteFly = v end,
	})
	Movement:CreateToggle({
		Name = 'Bunnyhop',
		Function = function(v) flags.Bunnyhop = v end,
	})
	Movement:CreateToggle({
		Name = 'Omnisprint',
		Function = function(v) flags.Omnisprint = v end,
	})
	Movement:CreateToggle({
		Name = 'No Fall',
		Function = function(v) flags.NoFall = v end,
	})
	Movement:CreateToggle({
		Name = 'Silent Step',
		Function = function(v) flags.SilentStep = v end,
	})

	-- Silent step hooks (SoundModule footstep)
	task.defer(function()
		local modules = game:GetService('ReplicatedStorage'):FindFirstChild('Modules')
		if not modules then return end
		local ok, soundMod = pcall(require, modules:WaitForChild('SoundModule', 5))
		if not ok or not soundMod or not hookfunction then return end
		if soundMod.ToggleFootstep and not FS.SilentStepFootHooked then
			FS.SilentStepFootHooked = true
			local oldFoot = soundMod.ToggleFootstep
			hookfunction(oldFoot, function(self, ...)
				local args = { ... }
				if flags.SilentStep and args[3] then
					return soundMod:StopSound(args[3])
				end
				return oldFoot(self, ...)
			end)
		end
		if soundMod.PlaySound and not FS.SilentStepPlayHooked then
			FS.SilentStepPlayHooked = true
			local oldPlay = soundMod.PlaySound
			hookfunction(oldPlay, function(self, ...)
				local args = { ... }
				if flags.SilentStep and args[2] and args[2].Name == 'WalkWater' then
					return soundMod:StopSound(args[2])
				end
				return oldPlay(self, ...)
			end)
		end
	end)

	vape:Clean(runService.Heartbeat:Connect(function(delta)
		if not flags.FallenMovement then return end
		local char = FS.ClientCharacter or lplr.Character
		local root = char and char:FindFirstChild('HumanoidRootPart')
		local hum = char and char:FindFirstChildOfClass('Humanoid')
		if not (hum and root) or hum.Health <= 0 then return end

		rayParams.FilterDescendantsInstances = { char, camera }

		if flags.Bunnyhop then
			if tostring(hum.FloorMaterial) ~= 'Air' and userInputService:IsKeyDown(Enum.KeyCode.Space) then
				hum.Jump = true
			end
		end

		if flags.Omnisprint and userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			for k in directionTable do directionTable[k] = false end
			directionTable.Forward = true
			directionTable.Sprint = true
			hum.WalkSpeed = 19
			local sc = char:FindFirstChild('StateController')
			if sc then
				sc:SetAttribute('IsSprint', true)
				sc:SetAttribute('Direction', 'Forward')
			end
		end

		local isFlying = flags.Fly and Movement.Enabled
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

		if flags.InfiniteFly and isFlying then
			local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams)
			if result and result.Distance > 4 then
				local oldVel = root.Velocity
				for _, part in char:GetChildren() do
					if part:IsA('BasePart') then part.Velocity = Vector3.new(0, -9999, 0) end
				end
				runService.RenderStepped:Wait()
				for _, part in char:GetChildren() do
					if part:IsA('BasePart') then part.Velocity = oldVel end
				end
			end
		end

		if flags.NoFall and not isFlying then
			local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams)
			if result and result.Distance > 10 then
				local oldVel = root.Velocity
				for _, part in char:GetChildren() do
					if part:IsA('BasePart') then part.Velocity = Vector3.new(0, 9999, 0) end
				end
				runService.RenderStepped:Wait()
				for _, part in char:GetChildren() do
					if part:IsA('BasePart') then part.Velocity = oldVel end
				end
			end
		end
	end))
end)
