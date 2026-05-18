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

local function notif(title, msg, duration)
end

local function deferFunc(func)
	if vape.Categories then
		task.spawn(func)
	else
		local oldInit = vape.Init
		if oldInit then
			vape.Init = function(...)
				oldInit(...)
				func()
			end
		else
			vape.Init = func
		end
	end
end

local run = function(func)
	deferFunc(func)
end

local surf = {
	remotes = {},
	store = {
		speed = 0,
		time = 0,
		map = '',
		finished = false,
		checkpoint = 0,
		style = ''
	},
	playerData = {},
	flailData = {},
	lastLagComp = 0
}

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
		task.wait(3)
		for _, v in replicatedStorage:GetChildren() do
			if v.Name == 'RemoteCall' and v.ClassName == 'RemoteEvent' then
				RemoteCall = v
			end
			if v.Name == 'RemoteFetch' and v.ClassName == 'RemoteFunction' then
				RemoteFetch = v
			end
		end
	end

	if not RemoteCall or not RemoteFetch then
		return
	end

	local handlers = {}
	local callQueue = {}
	local callQueueTick = 0

	surf.remotes.Add = function(name, func)
		handlers[name] = func
	end

	surf.remotes.Call = function(name, ...)
		local args = {...}
		table.insert(callQueue, {name, 2 + select('#', ...), ...})
	end

	surf.remotes.Fire = function(name, ...)
		local args = {...}
		table.insert(callQueue, {name, 2 + select('#', ...), ...})
	end

	surf.remotes.Fetch = function(name, ...)
		local serialized = httpService:JSONEncode({name, 2 + select('#', ...), ...})
		local success, result = pcall(function()
			return RemoteFetch:InvokeServer(serialized, 2 + select('#', ...))
		end)
		if success and result then
			local decodeSuccess, data = pcall(function()
				return httpService:JSONDecode(result)
			end)
			if decodeSuccess and handlers[name] then
				return handlers[name](unpack(data, 1, #data))
			end
		end
		return nil
	end

	RemoteCall.OnClientEvent:Connect(function(serialized, count)
		local success, data = pcall(function()
			return httpService:JSONDecode(serialized)
		end)
		if not success or not data then return end

		for i = 1, #data do
			local entry = data[i]
			if type(entry) ~= 'table' then continue end
			local name = entry[1]
			local argc = entry[2]
			local args = {}
			for j = 3, 2 + argc do
				table.insert(args, entry[j])
			end
			local handler = handlers[name]
			if handler then
				task.spawn(function()
					pcall(handler, unpack(args, 1, argc))
				end)
			end
		end
	end)

	RemoteFetch.OnClientInvoke = function(serialized, count)
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
			local result = handler(unpack(args, 1, argc))
			return result
		end
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
			pcall(function()
				RemoteCall:FireServer(serialized, #callQueue)
			end)
			table.clear(callQueue)
		end
	end)
end)

run(function()
	local CharacterInfos = {}
	local localInfo = {
		Character = nil,
		RootPart = nil,
		Humanoid = nil,
		Velocity = Vector3.zero,
		Position = Vector3.zero,
		CFrame = CFrame.new(),
		Health = 100,
		MaxHealth = 100,
		Speed = 0,
		SurfSpeed = 0
	}

	local function getCharacter(player)
		return player and player.Character
	end

	local function getRoot(player)
		local char = getCharacter(player)
		if char then
			return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
		end
		return nil
	end

	local function setupCharacter(char, player)
		if not char then return end
		local root = getRoot(player)
		if root then
			local hum = char:FindFirstChildOfClass('Humanoid')
			local info = {
				Character = char,
				RootPart = root,
				Humanoid = hum,
				Velocity = root.AssemblyLinearVelocity,
				Position = root.Position,
				CFrame = root.CFrame,
				Health = hum and hum.Health or 100,
				MaxHealth = hum and hum.MaxHealth or 100,
				Speed = hum and hum.WalkSpeed or 16,
				SurfSpeed = root.AssemblyLinearVelocity.Magnitude
			}
			CharacterInfos[player] = info
			if player == lplr then
				localInfo = info
			end
		end
	end

	playersService.LocalPlayer.CharacterAdded:Connect(function(char)
		setupCharacter(char, lplr)
	end)
	if lplr.Character then
		setupCharacter(lplr.Character, lplr)
	end

	for _, player in playersService:GetPlayers() do
		if player ~= lplr then
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
				local hum = info.Character and info.Character:FindFirstChildOfClass('Humanoid')
				info.Velocity = info.RootPart.AssemblyLinearVelocity
				info.Position = info.RootPart.Position
				info.CFrame = info.RootPart.CFrame
				info.SurfSpeed = info.Velocity.Magnitude
				if hum then
					info.Health = hum.Health
					info.MaxHealth = hum.MaxHealth
					info.Speed = hum.WalkSpeed
				end
				if player == lplr then
					localInfo = info
				end
			end
		end
	end)

	surf.CharacterManager = {
		CharacterInfos = CharacterInfos,
		getCharacter = getCharacter,
		getRoot = getRoot,
		setupCharacter = setupCharacter,
		localInfo = function()
			return localInfo
		end
	}
end)

run(function()
	local entitylib = vape.Libraries.entity
	if entitylib then
		entitylib.Running = true
		entitylib.Events.EntityAdded:Connect(function(entity)
			local player = entity.Player
			if player and surf.CharacterManager then
				local info = surf.CharacterManager.CharacterInfos[player]
				if info then
					entity.Speed = info.Speed
					entity.SurfSpeed = info.SurfSpeed
				end
			end
		end)
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
		elseif tag == 'Style' then
			surf.store.style = value
		end
	end)

	surf.remotes.Add('NewHighscore', function(time)
		notif('Surf', 'New highscore: '..string.format('%.2f', time)..'s!', 5)
	end)

	surf.remotes.Add('PlayerInfo', function(playerName, data)
		if playerName and data then
			surf.playerData[playerName] = data
			local player = playersService:FindFirstChild(playerName)
			if player then
				local info = surf.CharacterManager.CharacterInfos[player]
				if info then
					info.Speed = data.Speed or info.Speed
				end
			end
		end
	end)

	surf.remotes.Add('RunFinish', function(playerName, time, style)
		if playerName == lplr.Name then
			notif('Surf', 'Finished! Time: '..string.format('%.2f', time)..'s', 5)
		end
	end)
end)



run(function()
	local AutoHop
	local hopConnection = nil
	local wasInAir = false
	local lastJumpTime = 0

	AutoHop = vape.Categories.Combat:CreateModule({
		Name = 'AutoHop',
		Function = function(callback)
			if callback then
				if hopConnection then hopConnection:Disconnect() end
				hopConnection = runService.Heartbeat:Connect(function()
					if not AutoHop.Enabled then return end
					local char = lplr.Character
					if not char then return end
					local hum = char:FindFirstChildOfClass('Humanoid')
					if not hum then return end
					local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
					if not root then return end

					local vel = root.AssemblyLinearVelocity
					local isInAir = hum.FloorMaterial == Enum.Material.Air
					local now = tick()

					if isInAir and not wasInAir then
						wasInAir = true
					end

					if isInAir and vel.Y < -5 then
						if now - lastJumpTime > 0.05 then
							hum.Jump = true
							lastJumpTime = now
						end
				 elseif not isInAir then
						wasInAir = false
					end
				end)
			else
				if hopConnection then
					hopConnection:Disconnect()
					hopConnection = nil
				end
				wasInAir = false
			end
		end,
		Tooltip = 'Auto-hop when landing on surf ramps'
	})
end)

run(function()
	local SurfNoclip
	local noclipConnection = nil

	SurfNoclip = vape.Categories.Combat:CreateModule({
		Name = 'SurfNoclip',
		Function = function(callback)
			if callback then
				if noclipConnection then noclipConnection:Disconnect() end
				noclipConnection = runService.Heartbeat:Connect(function()
					if not SurfNoclip.Enabled then return end
					local char = lplr.Character
					if not char then return end
					for _, part in char:GetDescendants() do
						if part:IsA('BasePart') then
							part.CanCollide = false
						end
					end
				end)
			else
				if noclipConnection then
					noclipConnection:Disconnect()
					noclipConnection = nil
				end
			end
		end,
		Tooltip = 'Disable collision while surfing'
	})
end)

run(function()
	local SpeedMultiplier
	local speedMulti = 1

	SpeedMultiplier = vape.Categories.Combat:CreateModule({
		Name = 'SpeedMultiplier',
		Function = function(callback)
		end,
		Tooltip = 'Modify surf speed multiplier (local only)'
	})

	SpeedMultiplier:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 500,
		Default = 100,
		Function = function(val)
			speedMulti = val / 100
		end
	})
end)

run(function()
	local LagServer
	local lagThread = nil
	local lagInterval = 0.1

	LagServer = vape.Categories.Combat:CreateModule({
		Name = 'LagServer',
		Function = function(callback)
			if callback then
				if lagThread then task.cancel(lagThread) end
				lagThread = task.spawn(function()
					while LagServer.Enabled do
						local now = tick()
						if now - surf.lastLagComp > lagInterval then
							surf.lastLagComp = now
							surf.remotes.Call('LagCompensation', now)
						end
						task.wait(lagInterval)
					end
				end)
			else
				if lagThread then
					task.cancel(lagThread)
					lagThread = nil
				end
			end
		end,
		Tooltip = 'Send lag compensation packets'
	})

	LagServer:CreateSlider({
		Name = 'Interval',
		Min = 1,
		Max = 100,
		Default = 10,
		Function = function(val)
			lagInterval = val / 100
		end
	})
end)

run(function()
	local Fly
	local flyConnection = nil
	local flySpeed = 50

	local keysHeld = {}
	inputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.Space then keysHeld.Space = true end
		if input.KeyCode == Enum.KeyCode.LeftControl then keysHeld.Ctrl = true end
		if input.KeyCode == Enum.KeyCode.W then keysHeld.W = true end
		if input.KeyCode == Enum.KeyCode.S then keysHeld.S = true end
		if input.KeyCode == Enum.KeyCode.A then keysHeld.A = true end
		if input.KeyCode == Enum.KeyCode.D then keysHeld.D = true end
	end)
	inputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Space then keysHeld.Space = nil end
		if input.KeyCode == Enum.KeyCode.LeftControl then keysHeld.Ctrl = nil end
		if input.KeyCode == Enum.KeyCode.W then keysHeld.W = nil end
		if input.KeyCode == Enum.KeyCode.S then keysHeld.S = nil end
		if input.KeyCode == Enum.KeyCode.A then keysHeld.A = nil end
		if input.KeyCode == Enum.KeyCode.D then keysHeld.D = nil end
	end)

	Fly = vape.Categories.Combat:CreateModule({
		Name = 'SurfFly',
		Function = function(callback)
			if callback then
				if flyConnection then flyConnection:Disconnect() end
				flyConnection = runService.Heartbeat:Connect(function()
					if not Fly.Enabled then return end
					local char = lplr.Character
					if not char then return end
					local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
					if not root then return end

					local camCF = gameCamera.CFrame
					local moveDir = Vector3.zero

					if keysHeld.W then moveDir = moveDir + camCF.LookVector end
					if keysHeld.S then moveDir = moveDir - camCF.LookVector end
					if keysHeld.A then moveDir = moveDir - camCF.RightVector end
					if keysHeld.D then moveDir = moveDir + camCF.RightVector end
					if keysHeld.Space then moveDir = moveDir + Vector3.new(0, 1, 0) end
					if keysHeld.Ctrl then moveDir = moveDir - Vector3.new(0, 1, 0) end

					if moveDir.Magnitude > 0 then
						moveDir = moveDir.Unit * flySpeed
					end

					root.AssemblyLinearVelocity = moveDir
				end)
			else
				if flyConnection then
					flyConnection:Disconnect()
					flyConnection = nil
				end
			end
		end,
		Tooltip = 'Fly in surf (WASD + Space/Ctrl)'
	})

	Fly:CreateSlider({
		Name = 'Speed',
		Min = 1,
		Max = 200,
		Default = 50,
		Function = function(val)
			flySpeed = val
		end
	})
end)

run(function()
	local ShowTimes
	local nametagObjects = {}

	local function drawNametag(player, timeData)
		if nametagObjects[player] then
			nametagObjects[player]:Destroy()
			nametagObjects[player] = nil
		end
		if not player or not player.Character then return end
		local root = player.Character:FindFirstChild('HumanoidRootPart') or player.Character:FindFirstChild('Torso')
		if not root then return end

		local time = timeData and timeData.Time or 0
		local style = timeData and timeData.Style or ''

		local billboard = Instance.new('BillboardGui')
		billboard.Name = 'SurfTimeTag'
		billboard.Size = UDim2.new(0, 120, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 4, 0)
		billboard.Adornee = root
		billboard.AlwaysOnTop = true
		billboard.Parent = root

		local bg = Instance.new('Frame')
		bg.Size = UDim2.new(1, 0, 1, 0)
		bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		bg.BackgroundTransparency = 0.3
		bg.Parent = billboard

		local corner = Instance.new('UICorner')
		corner.CornerRadius = UDim.new(0, 4)
		corner.Parent = bg

		local label = Instance.new('TextLabel')
		label.Size = UDim2.new(1, -4, 0.6, 0)
		label.Position = UDim2.new(0, 2, 0, 2)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Text = string.format('%.2f', time)
		label.TextScaled = true
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Center
		label.Parent = bg

		local styleLabel = Instance.new('TextLabel')
		styleLabel.Size = UDim2.new(1, -4, 0.4, 0)
		styleLabel.Position = UDim2.new(0, 2, 0.6, 0)
		styleLabel.BackgroundTransparency = 1
		styleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		styleLabel.Text = style
		styleLabel.TextScaled = true
		styleLabel.Font = Enum.Font.Gotham
		styleLabel.TextXAlignment = Enum.TextXAlignment.Center
		styleLabel.Parent = bg

		nametagObjects[player] = billboard
	end

	ShowTimes = vape.Categories.Blatant:CreateModule({
		Name = 'ShowSurfTimes',
		Function = function(callback)
			if callback then
				ShowTimes:Clean(playersService.PlayerAdded:Connect(function(player)
					player.CharacterAdded:Connect(function(char)
						local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
						if root then
							task.wait(0.1)
							local data = surf.playerData[player.Name]
							drawNametag(player, data)
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
							local data = surf.playerData[player.Name]
							drawNametag(player, data)
						end
					end
				end

				ShowTimes:Clean(runService.Heartbeat:Connect(function()
					for player, tag in pairs(nametagObjects) do
						if not player or not player.Parent or not player.Character then
							if tag then tag:Destroy() end
							nametagObjects[player] = nil
						else
							local data = surf.playerData[player.Name]
							if data then
								local bg = tag:FindFirstChild('Frame')
								if bg then
									local lbl = bg:FindFirstChildWhichIsA('TextLabel')
									if lbl then
										lbl.Text = string.format('%.2f', data.Time or 0)
									end
								end
							end
						end
					end
				end))
			else
				for _, tag in pairs(nametagObjects) do
					if tag then tag:Destroy() end
				end
				table.clear(nametagObjects)
			end
		end,
		Tooltip = 'Shows surf times above other players'
	})
end)
