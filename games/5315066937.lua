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
	local pendingCalls = {}
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

	vape:AddAttribute('SurfRemotes', surf.remotes)
end)

run(function()
	local LocalPlayer = entitylib.localPlayer
	local CharacterManager
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
			CharacterInfos[player] = {
				Character = char,
				RootPart = root,
				Humanoid = char:FindFirstChildOfClass('Humanoid'),
				Velocity = root.AssemblyLinearVelocity,
				Position = root.Position,
				CFrame = root.CFrame,
				Health = (char:FindFirstChildOfClass('Humanoid') and char.Humanoid.Health) or 0,
				MaxHealth = (char:FindFirstChildOfClass('Humanoid') and char.Humanoid.MaxHealth) or 100
			}
		end
	end

	local function onCharacterAdded(char)
		local player = playersService.LocalPlayer
		setupCharacter(char, player)
		CharacterAdded:Fire(player, char)
	end

	local function onCharacterRemoving(char)
		local player = playersService.LocalPlayer
		CharacterInfos[player] = nil
		CharacterRemoving:Fire(player, char)
	end

	playersService.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
	if playersService.LocalPlayer.Character then
		onCharacterAdded(playersService.LocalPlayer.Character)
	end

	for _, player in playersService:GetPlayers() do
		if player ~= playersService.LocalPlayer then
			if player.Character then
				setupCharacter(player.Character, player)
			end
			player.CharacterAdded:Connect(function(char)
				char.AncestryChanged:Connect(function()
					if char:IsDescendantOf(game) then
						setupCharacter(char, player)
					end
				end)
				setupCharacter(char, player)
			end)
			player.CharacterRemoving:Connect(function()
				CharacterInfos[player] = nil
			end)
		end
	end

	playersService.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(char)
			char.AncestryChanged:Connect(function()
				if char:IsDescendantOf(game) then
					setupCharacter(char, player)
				end
			end)
			setupCharacter(char, player)
		end)
	end)

	runService.Heartbeat:Connect(function()
		for player, info in CharacterInfos do
			if player and info and info.RootPart then
				local newVel = info.RootPart.AssemblyLinearVelocity
				local newPos = info.RootPart.Position
				local newCFrame = info.RootPart.CFrame
				local humanoid = info.Character and info.Character:FindFirstChildOfClass('Humanoid')
				info.Velocity = newVel
				info.Position = newPos
				info.CFrame = newCFrame
				if humanoid then
					info.Health = humanoid.Health
					info.MaxHealth = humanoid.MaxHealth
					info.Speed = humanoid.WalkSpeed
					info.JumpPower = humanoid.JumpPower
				end
			end
		end
	end)

	entitylib.localPlayer = {
		Player = lplr,
		Character = playersService.LocalPlayer.Character,
		RootPart = getRoot(playersService.LocalPlayer),
		Health = 100,
		MaxHealth = 100,
		Speed = 16,
		JumpPower = 50,
		isAlive = true
	}

	surf.CharacterManager = {
		CharacterAdded = CharacterAdded,
		CharacterRemoving = CharacterRemoving,
		CharacterInfos = CharacterInfos,
		getCharacter = getCharacter,
		getRoot = getRoot,
		setupCharacter = setupCharacter,
		LocalPlayer = entitylib.localPlayer
	}

	vape:AddAttribute('CharacterManager', surf.CharacterManager)
end)

run(function()
	local View
	local RenderManager
	local FixLocalPlayer
	local VisibilityManager
	local BulkMove
	local ContextManager
	local TimelineReplication
	local TimerSynchronization

	local function setupGlobals()
		View = surf.remotes.GetHandler and surf.remotes.GetHandler('View') and _G.obtain and _G.obtain('View')
		RenderManager = _G.obtain and _G.obtain('RenderManager')
		FixLocalPlayer = _G.obtain and _G.obtain('FixLocalPlayer')
		VisibilityManager = _G.obtain and _G.obtain('VisibilityManager')
		BulkMove = _G.obtain and _G.obtain('BulkMove')
		ContextManager = _G.obtain and _G.obtain('ContextManager')
	end

	if not View then
		for i = 1, 60 do
			setupGlobals()
			if View then break end
			task.wait()
		end
	end

	if RenderManager then
		RenderManager.Bind('PositionCharacters', function()
			if View and View.PlaybackContext then
				View.PlaybackContext:Run()
				local player = View.Player
				if player and player ~= 'Local' then
				end
				if BulkMove then
					BulkMove.Flush()
				end
			end
		end)
	end

	runService.Heartbeat:Connect(function()
		if ContextManager then
			local contexts = ContextManager.Contexts
			if contexts and View then
				for player, ctx in contexts do
					if player ~= View.Player then
						ctx:Run()
					end
				end
				if BulkMove then
					BulkMove.Flush()
				end
			end
		end
	end)

	surf.RenderGlobals = {
		View = View,
		RenderManager = RenderManager,
		FixLocalPlayer = FixLocalPlayer,
		VisibilityManager = VisibilityManager,
		BulkMove = BulkMove,
		ContextManager = ContextManager
	}
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
end)

entitylib:AddGetCharacter(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	return info and info.Character
end)

entitylib:AddGetRoot(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	return info and info.RootPart
end)

entitylib:AddGetHealth(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	if info then return info.Health or 100 end
	local char = surf.CharacterManager and surf.CharacterManager.getCharacter(player)
	if char then
		local hum = char:FindFirstChildOfClass('Humanoid')
		return hum and hum.Health or 100
	end
	return 100
end)

entitylib:AddGetMaxHealth(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	if info then return info.MaxHealth or 100 end
	local char = surf.CharacterManager and surf.CharacterManager.getCharacter(player)
	if char then
		local hum = char:FindFirstChildOfClass('Humanoid')
		return hum and hum.MaxHealth or 100
	end
	return 100
end)

entitylib:AddGetVelocity(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	return info and info.Velocity or Vector3.zero
end)

entitylib:AddIsAlive(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	if info then
		return info.Character ~= nil and info.Health > 0
	end
	local char = surf.CharacterManager and surf.CharacterManager.getCharacter(player)
	if char then
		local hum = char:FindFirstChildOfClass('Humanoid')
		return hum and hum.Health > 0
	end
	return false
end)

entitylib:AddTargetable(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	if not info then return false end
	local char = info.Character
	if not char then return false end
	local hum = char:FindFirstChildOfClass('Humanoid')
	return hum and hum.Health > 0
end)

entitylib:AddFriend(function(player)
	if not player then return false end
	if vape.Categories.Friends.Options['Use friends'].Enabled then
		local friend = table.find(vape.Categories.Friends.ListEnabled, player.Name) and true
		return friend
	end
	return false
end)

entitylib:AddTeam(function(player)
	if not player then return nil end
	return player.Team
end)

entitylib:AddTeamColor(function(player)
	local team = entitylib:Team(player)
	if team then
		return team.TeamColor.Color
	end
	return Color3.new(1, 1, 1)
end)

entitylib:AddColor(function(player)
	local teamColor = entitylib:TeamColor(player)
	if teamColor then
		return teamColor
	end
	return Color3.new(1, 1, 1)
end)

entitylib:AddSpecialK(function(player)
	return false
end)

entitylib:AddNPC(function(player)
	return false
end)

entitylib:AddIllegal(function(player)
	return false
end)

entitylib:AddVulnerable(function(player)
	return entitylib:Targetable(player) and entitylib:IsAlive(player)
end)

entitylib:AddUpdateCharacter(function(player)
	local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
	if info then
		info.Character = info.Character
		info.RootPart = info.RootPart
	end
end)

entitylib:AddOnLivingRemoved(function(player)
end)

entitylib:AddOnSpawn(function(player)
end)

run(function()
	local session = {
		speed = sessioninfo:AddItem('Speed'),
		time = sessioninfo:AddItem('Time'),
		checkpoint = sessioninfo:AddItem('Checkpoint'),
		finished = sessioninfo:AddItem('Finished')
	}

	runService.Heartbeat:Connect(function()
		local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[lplr]
		if info and info.Velocity then
			local spd = info.Velocity.Magnitude
			session.speed:Set(spd)
			surf.store.speed = spd
		end
		session.time:Set(surf.store.time)
		session.checkpoint:Set(surf.store.checkpoint)
		session.finished:Set(surf.store.finished and 'Yes' or 'No')
	end)

	vape:AddAttribute('SurfSession', session)
end)

run(function()
	for _, v in vape.Modules do
		if v.Category == 'Combat' or v.Category == 'Minigames' then
		end
	end
end)

run(function()
	local AutoHop
	local Autostrafe
	local SpeedModifier
	local Noclip
	local Fly
	local flyToggled = false
	local flyConnection = nil

	AutoHop = vape.Categories.Movement:CreateModule({
		Name = 'AutoHop',
		Function = function(callback)
			if callback then
				runService.Heartbeat:Connect(function()
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
				end)
			end
		end,
		Tooltip = 'Automatically hops when on surf'
	})

	Autostrafe = vape.Categories.Movement:CreateModule({
		Name = 'AutoStrafe',
		Function = function(callback)
			if callback then
				local keysHeld = {}
				inputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then return end
					if input.KeyCode == Enum.KeyCode.A then keysHeld.A = true end
					if input.KeyCode == Enum.KeyCode.D then keysHeld.D = true end
				end)
				inputService.InputEnded:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.A then keysHeld.A = nil end
					if input.KeyCode == Enum.KeyCode.D then keysHeld.D = nil end
				end)
				runService.Heartbeat:Connect(function()
					if not Autostrafe.Enabled then return end
					local char = lplr.Character
					if not char then return end
					local hum = char:FindFirstChildOfClass('Humanoid')
					if not hum then return end
					local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso')
					if not root then return end
					if hum.FloorMaterial == Enum.Material.Air then
						local vel = root.AssemblyLinearVelocity
						local lookDir = Vector3.new(gameCamera.CFrame.LookVector.X, 0, gameCamera.CFrame.LookVector.Z).Unit
						local rightDir = Vector3.new(gameCamera.CFrame.RightVector.X, 0, gameCamera.CFrame.RightVector.Z).Unit
						local strafeDir = Vector3.zero
						if keysHeld.A then strafeDir = strafeDir - rightDir end
						if keysHeld.D then strafeDir = strafeDir + rightDir end
						if strafeDir.Magnitude > 0.1 then
							local newVel = Vector3.new(vel.X + strafeDir.X * 0.5, vel.Y, vel.Z + strafeDir.Z * 0.5)
							root.AssemblyLinearVelocity = newVel
						end
					end
				end)
			end
		end,
		Tooltip = 'Auto-strafes while in air for speed maintenance'
	})

	SpeedModifier = vape.Categories.Movement:CreateModule({
		Name = 'SpeedModifier',
		Function = function(callback)
		end,
		Tooltip = 'Modify surfing speed (edits local physics only)'
	})
end)

run(function()
	local TimerHook
	local TimerSync = {}

	TimerSync.NewTimeHook = surf.remotes.GetHandler and _G.obtain and _G.obtain('TimerSync') and _G.obtain('TimerSync').NewTimeHook
	TimerSync.NewTimeHook = TimerSync.NewTimeHook or Instance.new('BindableEvent')

	TimerHook = vape.Categories.Utility:CreateModule({
		Name = 'TimerHook',
		Function = function(callback)
			if callback then
				TimerHook:Clean(TimerSync.NewTimeHook:Connect(function(time)
					surf.store.time = time
				end))
				surf.remotes.Call('GetOffset')
			end
		end,
		Tooltip = 'Syncs with server timer for speedrun tracking'
	})
end)

run(function()
	local LagServer
	local lagThread = nil

	LagServer = vape.Categories.Movement:CreateModule({
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

	ShowTimes = vape.Categories.Render:CreateModule({
		Name = 'ShowSurfTimes',
		Function = function(callback)
			local nametagObjects = {}

			local function drawNametag(player, time)
				if nametagObjects[player] then
					nametagObjects[player]:Destroy()
					nametagObjects[player] = nil
				end
				if not player.Character then return end
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

				for _, player in playersService:GetPlayers() do
					if player ~= lplr then
						if player.Character then
							local root = player.Character:FindFirstChild('HumanoidRootPart') or player.Character:FindFirstChild('Torso')
							if root then
								drawNametag(player, 0)
							end
						end
					end
				end

				ShowTimes:Clean(runService.Heartbeat:Connect(function()
					for player, tag in nametagObjects do
						if not player.Character or not entitylib:IsAlive(player) then
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

run(function()
	surf.remotes.Add('PlayerInfo', function(playerName, data)
		if playerName and data then
			local player = playersService:FindFirstChild(playerName)
			if player then
				local info = surf.CharacterManager and surf.CharacterManager.CharacterInfos[player]
				if info then
					info.Speed = data.Speed or info.Speed
					info.Time = data.Time or info.Time
				end
			end
		end
	end)
end)

notif('Surf', 'Surf module loaded!', 3)
