local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local collectionService = cloneref(game:GetService('CollectionService'))
local runService = cloneref(game:GetService('RunService'))
local httpService = cloneref(game:GetService('HttpService'))
local tweenService = cloneref(game:GetService('TweenService'))
local gameCamera = cloneref(workspace.CurrentCamera)
local lplr = playersService.LocalPlayer

local vape = shared.vape
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo
local sessioninfo = vape.Libraries.sessioninfo
local whitelist = vape.Libraries.whitelist
local prediction = vape.Libraries.prediction

local surf = {
	remotes = {},
	store = {
		speed = 0,
		time = 0,
		map = '',
		finished = false,
		checkpoint = 0
	}
}

local function notif(...)
	return vape:CreateNotification(...)
end

run(function()
	local RemoteCall = nil
	local RemoteFetch = nil

	for _, v in replicatedStorage:GetChildren() do
		if v.Name == 'RemoteCall' and v.ClassName == 'RemoteEvent' then
			RemoteCall = v
		end
		if v.Name == 'RemoteFetch' and v.ClassName == 'RemoteFunction' then
			RemoteFetch = v
		end
	end

	if not RemoteCall or not RemoteFetch then
		return
	end

	local handlers = {}
	local callQueue = {}
	local callQueueTick = 0

	local function fireRemote(name, ...)
		local args = {...}
		local queueEntry = {name, 2 + select('#', ...), ...}
		table.insert(callQueue, queueEntry)
	end

	local function queueCall(name, ...)
		local args = {...}
		local queueEntry = {name, 2 + select('#', ...), ...}
		table.insert(callQueue, queueEntry)
	end

	runService.Stepped:Connect(function()
		local now = tick()
		if now - callQueueTick > 0.05 and #callQueue > 0 then
			if now - callQueueTick > 0.1 then
				callQueueTick = now
			else
				callQueueTick = callQueueTick + 0.05
			end
			local serialized = httpService:JSONEncode(callQueue)
			RemoteCall:FireServer(serialized, #callQueue)
			table.clear(callQueue)
		end
	end)

	RemoteCall.OnClientEvent:Connect(function(serialized)
		local success, data = pcall(function()
			return httpService:JSONDecode(serialized)
		end)
		if not success or not data then return end

		for i = 1, #data do
			local entry = data[i]
			local name = entry[1]
			local argc = entry[2]
			local args = {}
			for j = 3, 2 + argc do
				table.insert(args, entry[j])
			end
			local handler = handlers[name]
			if handler then
				task.spawn(function()
					handler(unpack(args, 1, argc))
				end)
			end
		end
	end)

	RemoteFetch.OnClientInvoke = function(serialized)
		local success, data = pcall(function()
			return httpService:JSONDecode(serialized)
		end)
		if not success or not data then return end

		local name = data[1]
		local argc = data[2]
		local args = {}
		for j = 3, 2 + argc do
			table.insert(args, data[j])
		end
		local handler = handlers[name]
		if handler then
			return handler(unpack(args, 1, argc))
		end
	end

	surf.remotes.Add = function(name, func)
		handlers[name] = func
	end
	surf.remotes.Call = queueCall
	surf.remotes.Fire = fireRemote
	surf.remotes.GetHandler = function(name)
		return handlers[name]
	end
end)

run(function()
	local CharacterInfos = {}
	local CharacterAdded = Instance.new('BindableEvent')
	local CharacterRemoving = Instance.new('BindableEvent')

	local function getCharacter(player)
		return player and player.Character
	end

	local function getRoot(player)
		local char = getCharacter(player)
		if char then
			return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('Humanoid')
		end
	end

	local function setupCharacter(char, player)
		if not char then return end
		local root = getRoot(player)
		if root then
			local hum = char:FindFirstChildOfClass('Humanoid')
			CharacterInfos[player] = {
				Character = char,
				RootPart = root,
				Humanoid = hum,
				Velocity = root.AssemblyLinearVelocity,
				Position = root.Position,
				CFrame = root.CFrame,
				Health = hum and hum.Health or 100,
				MaxHealth = hum and hum.MaxHealth or 100,
				Speed = hum and hum.WalkSpeed or 16
			}
		end
	end

	playersService.LocalPlayer.CharacterAdded:Connect(function(char)
		setupCharacter(char, playersService.LocalPlayer)
		CharacterAdded:Fire(playersService.LocalPlayer, char)
	end)
	if playersService.LocalPlayer.Character then
		setupCharacter(playersService.LocalPlayer.Character, playersService.LocalPlayer)
	end

	for _, player in playersService:GetPlayers() do
		if player ~= playersService.LocalPlayer then
			if player.Character then
				setupCharacter(player.Character, player)
			end
			player.CharacterAdded:Connect(function(char)
				setupCharacter(char, player)
			end)
			player.CharacterRemoving:Connect(function()
				CharacterInfos[player] = nil
			end)
		end
	end

	playersService.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(char)
			setupCharacter(char, player)
		end)
	end)

	runService.Heartbeat:Connect(function()
		for player, info in CharacterInfos do
			if player and info and info.RootPart and info.RootPart.Parent then
				local newVel = info.RootPart.AssemblyLinearVelocity
				local humanoid = info.Character and info.Character:FindFirstChildOfClass('Humanoid')
				info.Velocity = newVel
				info.Position = info.RootPart.Position
				info.CFrame = info.RootPart.CFrame
				if humanoid then
					info.Health = humanoid.Health
					info.MaxHealth = humanoid.MaxHealth
					info.Speed = humanoid.WalkSpeed
				end
			end
		end
	end)

	surf.CharacterManager = {
		CharacterAdded = CharacterAdded,
		CharacterRemoving = CharacterRemoving,
		CharacterInfos = CharacterInfos,
		getCharacter = getCharacter,
		getRoot = getRoot,
		setupCharacter = setupCharacter
	}
end)

entitylib.Running = true

entitylib.Events.EntityAdded:Connect(function(entity)
	local player = entity.Player
	if player and CharacterInfos then
		local info = CharacterInfos[player]
		if info then
			entity.Health = info.Health
			entity.MaxHealth = info.MaxHealth
			entity.Speed = info.Speed
			entity.Velocity = info.Velocity
		end
	end
end)

run(function()
	surf.remotes.Add('Tag', function(tag, value)
		if tag == 'Speed' then
			surf.store.speed = value
		elseif tag == 'Time' then
			surf.store.time = value
		elseif tag == 'Checkpoint' then
			surf.store.checkpoint = value
		elseif tag == 'Finished' then
			surf.store.finished = value
		elseif tag == 'Map' then
			surf.store.map = value
		end
	end)

	surf.remotes.Add('NewHighscore', function(time)
		notif('Surf', 'New highscore: '..string.format('%.2f', time)..'s!', 5)
	end)

	surf.remotes.Add('PlayerInfo', function(playerName, data)
		if playerName and data then
			local player = playersService:FindFirstChild(playerName)
			if player and CharacterInfos then
				local info = CharacterInfos[player]
				if info then
					info.Speed = data.Speed or info.Speed
				end
			end
		end
	end)
end)

run(function()
	local speedItem = sessioninfo:AddItem('Speed')
	local timeItem = sessioninfo:AddItem('Time')
	local checkpointItem = sessioninfo:AddItem('CP')
	local finishedItem = sessioninfo:AddItem('Finished')

	runService.Heartbeat:Connect(function()
		local info = CharacterInfos and CharacterInfos[lplr]
		if info and info.Velocity then
			local spd = info.Velocity.Magnitude
			speedItem:Set(math.floor(spd))
			surf.store.speed = spd
		end
		timeItem:Set(surf.store.time)
		checkpointItem:Set(surf.store.checkpoint)
		finishedItem:Set(surf.store.finished and 'Yes' or 'No')
	end)
end)

run(function()
	local AutoHop
	local Autostrafe

	AutoHop = vape.Categories.Combat:CreateModule({
		Name = 'AutoHop',
		Function = function(callback)
			if callback then
				AutoHop:Clean(runService.Heartbeat:Connect(function()
					if not AutoHop.Enabled then return end
					local char = lplr.Character
					if not char then return end
					local hum = char:FindFirstChildOfClass('Humanoid')
					if not hum then return end
					local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
					if not root then return end
					if hum.FloorMaterial ~= Enum.Material.Air then
						local vel = root.AssemblyLinearVelocity
						if vel.Y < -2 or vel.Y > 2 then
							hum.Jump = true
						end
					end
				end))
			end
		end,
		Tooltip = 'Automatically hops when on surf'
	})

	Autostrafe = vape.Categories.Combat:CreateModule({
		Name = 'AutoStrafe',
		Function = function(callback)
			if callback then
				local keysHeld = {}
				Autostrafe:Clean(inputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then return end
					if input.KeyCode == Enum.KeyCode.A then keysHeld.A = true end
					if input.KeyCode == Enum.KeyCode.D then keysHeld.D = true end
				end))
				Autostrafe:Clean(inputService.InputEnded:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.A then keysHeld.A = nil end
					if input.KeyCode == Enum.KeyCode.D then keysHeld.D = nil end
				end))
				Autostrafe:Clean(runService.Heartbeat:Connect(function()
					if not Autostrafe.Enabled then return end
					local char = lplr.Character
					if not char then return end
					local hum = char:FindFirstChildOfClass('Humanoid')
					if not hum then return end
					local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
					if not root then return end
					if hum.FloorMaterial == Enum.Material.Air then
						local vel = root.AssemblyLinearVelocity
						local rightDir = Vector3.new(gameCamera.CFrame.RightVector.X, 0, gameCamera.CFrame.RightVector.Z).Unit
						local strafeDir = Vector3.zero
						if keysHeld.A then strafeDir = strafeDir - rightDir end
						if keysHeld.D then strafeDir = strafeDir + rightDir end
						if strafeDir.Magnitude > 0.1 then
							local newVel = Vector3.new(vel.X + strafeDir.X * 0.5, vel.Y, vel.Z + strafeDir.Z * 0.5)
							root.AssemblyLinearVelocity = newVel
						end
					end
				end))
			end
		end,
		Tooltip = 'Auto-strafes while in air for CS:GO-style surf speed'
	})
end)

run(function()
	local LagServer
	local lagThread = nil

	LagServer = vape.Categories.Combat:CreateModule({
		Name = 'LagServer',
		Function = function(callback)
			if callback then
				lagThread = task.spawn(function()
					while LagServer.Enabled do
						pcall(function()
							surf.remotes.Fire('LagCompensation', tick())
						end)
						task.wait(0.1)
					end
				end)
			else
				if lagThread then
					task.cancel(lagThread)
					lagThread = nil
				end
			end
		end,
		Tooltip = 'Sends lag compensation packets to server'
	})
end)

run(function()
	local ShowTimes

	ShowTimes = vape.Categories.Blatant:CreateModule({
		Name = 'ShowSurfTimes',
		Function = function(callback)
			local nametagObjects = {}

			local function drawNametag(player, time)
				if nametagObjects[player] then
					nametagObjects[player]:Destroy()
					nametagObjects[player] = nil
				end
				if not player or not player.Character then return end
				local root = player.Character:FindFirstChild('HumanoidRootPart') or player.Character:FindFirstChild('Torso')
				if not root then return end

				local billboard = Instance.new('BillboardGui')
				billboard.Name = 'SurfTimeTag'
				billboard.Size = UDim2.new(0, 100, 0, 40)
				billboard.StudsOffset = Vector3.new(0, 3, 0)
				billboard.Adornee = root
				billboard.AlwaysOnTop = true
				billboard.Parent = root

				local label = Instance.new('TextLabel')
				label.Size = UDim2.new(1, 0, 1, 0)
				label.BackgroundTransparency = 0.5
				label.BackgroundColor3 = Color3.new(0, 0, 0)
				label.TextColor3 = Color3.new(1, 1, 1)
				label.Text = string.format('%.2f', time or 0)
				label.TextScaled = true
				label.Font = Enum.Font.GothamBold
				label.Parent = billboard

				nametagObjects[player] = billboard
			end

			if callback then
				ShowTimes:Clean(playersService.PlayerAdded:Connect(function(player)
					player.CharacterAdded:Connect(function(char)
						local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
						if root then
							drawNametag(player, 0)
						end
					end)
				end))

				ShowTimes:Clean(playersService.PlayerRemoving:Connect(function(player)
					if nametagObjects[player] then
						nametagObjects[player]:Destroy()
						nametagObjects[player] = nil
					end
				end))

				for _, player in playersService:GetPlayers() do
					if player ~= lplr and player.Character then
						local root = player.Character:FindFirstChild('HumanoidRootPart') or player.Character:FindFirstChild('Torso')
						if root then
							drawNametag(player, 0)
						end
					end
				end

				ShowTimes:Clean(runService.Heartbeat:Connect(function()
					for player, tag in nametagObjects do
						if not player or not player.Character or not player.Character:FindFirstChild('HumanoidRootPart') then
							if tag then tag:Destroy() end
							nametagObjects[player] = nil
						end
					end
				end))
			else
				for _, tag in nametagObjects do
					if tag then tag:Destroy() end
				end
				table.clear(nametagObjects)
			end
		end,
		Tooltip = 'Shows surf times above other players'
	})
end)

notif('Surf', 'Surf module loaded!', 3)
