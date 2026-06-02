local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape

if not vape.Categories.Minigames then
	vape.Categories.Minigames = vape:CreateCategory({
		Name = 'Minigames',
		Icon = 'vape/assets/new/minigames.png'
	})
end

local minigames = vape.Categories.Minigames

local function notif(...)
	return vape:CreateNotification(...)
end

local function waitRemote(parent, name, timeout)
	timeout = timeout or 8
	local ok, inst = pcall(function()
		return parent:WaitForChild(name, timeout)
	end)
	return ok and inst or nil
end

local function getHalloweenClientScript()
	return lplr.PlayerScripts:FindFirstChild('Halloween24_Client')
end

local function getCharacter()
	return lplr.Character
end

local function getHead()
	local char = getCharacter()
	return char and char:FindFirstChild('Head')
end

-- RP chat bubbles above your character (server_message_sent -> OnClientEvent -> Chat on all clients)
run(function()
	local RPBubbleSpam
	local Delay

	RPBubbleSpam = minigames:CreateModule({
		Name = 'RP Bubble Spam',
		Function = function(enabled)
			if enabled then
				local remote = waitRemote(replicatedStorage, 'server_message_sent')
				if not remote then
					notif('RP Bubble Spam', 'server_message_sent missing', 5, 'warning')
					RPBubbleSpam:ToggleButton(false)
					return
				end
				local lines = {
					'...',
					'hello?',
					'can you hear me',
					'lag?',
					'brb',
					'what',
					'stop',
					'help',
					'???',
					'ok'
				}
				local index = 1
				task.spawn(function()
					while RPBubbleSpam.Enabled do
						if replicatedStorage:GetAttribute('IsInCharacter') then
							pcall(function()
								remote:FireServer(lines[index])
							end)
							index = index % #lines + 1
						end
						task.wait(math.max(Delay.Value, 0.05))
					end
				end)
			end
		end,
		Tooltip = 'Spams roleplay bubbles via ReplicatedStorage.server_message_sent (visible to nearby players). Needs IsInCharacter.'
	})
	Delay = RPBubbleSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 3,
		Default = 0.35,
		Suffix = 's'
	})
end)

-- Halloween death/emote animations from Halloween24_Client script (replicate on your character)
run(function()
	local HalloweenAnimSpam
	local Delay
	local AnimPick
	local loaded = {}

	local function refreshAnimations()
		table.clear(loaded)
		local scriptRef = getHalloweenClientScript()
		if not scriptRef then return end
		for _, child in ipairs(scriptRef:GetChildren()) do
			if child:IsA('Animation') then
				table.insert(loaded, child.Name)
			end
		end
		table.sort(loaded)
	end

	refreshAnimations()

	HalloweenAnimSpam = minigames:CreateModule({
		Name = 'Halloween Anim Spam',
		Function = function(enabled)
			if enabled then
				refreshAnimations()
				if #loaded == 0 then
					notif('Halloween Anim Spam', 'No Animation children on Halloween24_Client', 5, 'warning')
					HalloweenAnimSpam:ToggleButton(false)
					return
				end
				local tracks = {}
				local function stopTracks()
					for _, track in pairs(tracks) do
						pcall(function()
							track:Stop(0)
						end)
					end
					table.clear(tracks)
				end
				HalloweenAnimSpam:Clean(function()
					stopTracks()
				end)
				task.spawn(function()
					local scriptRef = getHalloweenClientScript()
					while HalloweenAnimSpam.Enabled do
						local char = getCharacter()
						local hum = char and char:FindFirstChildOfClass('Humanoid')
						local animator = hum and hum:FindFirstChildOfClass('Animator')
						if scriptRef and animator then
							local pick = AnimPick.Value
							if pick == 'Random' then
								pick = loaded[math.random(1, #loaded)]
							end
							local animObj = scriptRef:FindFirstChild(pick)
							if animObj and animObj:IsA('Animation') then
								pcall(function()
									local track = animator:LoadAnimation(animObj)
									track.Priority = Enum.AnimationPriority.Action4
									track:Play(0.1, 1, 1)
									tracks[track] = track
									track.Stopped:Connect(function()
										tracks[track] = nil
									end)
								end)
							end
						end
						task.wait(math.max(Delay.Value, 0.1))
					end
					stopTracks()
				end)
			end
		end,
		Tooltip = 'Loops Halloween24_Client Animation instances on your character (others see the anims).'
	})
	Delay = HalloweenAnimSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 5,
		Default = 0.5,
		Suffix = 's'
	})
	AnimPick = HalloweenAnimSpam:CreateDropdown({
		Name = 'Animation',
		List = function()
			refreshAnimations()
			local list = table.clone(loaded)
			table.insert(list, 1, 'Random')
			return list
		end
	})
end)

-- Loud replicated sounds parented to Head (Halloween23_Remotes + Halloween24_Client Sounds)
run(function()
	local HalloweenSoundSpam
	local Delay
	local Volume
	local SoundPick

	local soundNames = {}
	local function refreshSounds()
		table.clear(soundNames)
		local folder = replicatedStorage:FindFirstChild('Halloween23_Remotes')
		if folder then
			for _, v in ipairs(folder:GetChildren()) do
				if v:IsA('Sound') then
					table.insert(soundNames, 'Remote:' .. v.Name)
				elseif v:IsA('Model') or v:IsA('BasePart') then
					for _, d in ipairs(v:GetDescendants()) do
						if d:IsA('Sound') then
							table.insert(soundNames, v.Name .. '/' .. d.Name)
						end
					end
				end
			end
		end
		local scriptRef = getHalloweenClientScript()
		if scriptRef then
			for _, v in ipairs(scriptRef:GetChildren()) do
				if v:IsA('Sound') then
					table.insert(soundNames, 'Client:' .. v.Name)
				end
			end
		end
		table.sort(soundNames)
	end

	refreshSounds()

	local function resolveSound(name)
		if name:sub(1, 7) == 'Remote:' then
			local folder = replicatedStorage:FindFirstChild('Halloween23_Remotes')
			return folder and folder:FindFirstChild(name:sub(8))
		end
		if name:sub(1, 7) == 'Client:' then
			local scriptRef = getHalloweenClientScript()
			return scriptRef and scriptRef:FindFirstChild(name:sub(8))
		end
		local slash = name:find('/')
		if slash then
			local folder = replicatedStorage:FindFirstChild('Halloween23_Remotes')
			local parent = folder and folder:FindFirstChild(name:sub(1, slash - 1))
			return parent and parent:FindFirstChild(name:sub(slash + 1), true)
		end
	end

	HalloweenSoundSpam = minigames:CreateModule({
		Name = 'Halloween Sound Spam',
		Function = function(enabled)
			if enabled then
				refreshSounds()
				if #soundNames == 0 then
					notif('Halloween Sound Spam', 'No Halloween sounds found', 5, 'warning')
					HalloweenSoundSpam:ToggleButton(false)
					return
				end
				task.spawn(function()
					while HalloweenSoundSpam.Enabled do
						local head = getHead()
						local pick = SoundPick.Value
						if pick == 'Random' then
							pick = soundNames[math.random(1, #soundNames)]
						end
						local template = resolveSound(pick)
						if head and template and template:IsA('Sound') then
							pcall(function()
								local clone = template:Clone()
								clone.Volume = Volume.Value / 100
								clone.RollOffMaxDistance = 500
								clone.Parent = head
								clone:Play()
								task.delay(clone.TimeLength > 0 and clone.TimeLength + 0.2 or 2, function()
									pcall(function()
										clone:Destroy()
									end)
								end)
							end)
						end
						task.wait(math.max(Delay.Value, 0.05))
					end
				end)
			end
		end,
		Tooltip = 'Plays cloned Halloween23_Remotes / Halloween24_Client sounds on your Head (others hear them).'
	})
	Delay = HalloweenSoundSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 3,
		Default = 0.25,
		Suffix = 's'
	})
	Volume = HalloweenSoundSpam:CreateSlider({
		Name = 'Volume',
		Min = 10,
		Max = 100,
		Default = 100,
		Suffix = '%'
	})
	SoundPick = HalloweenSoundSpam:CreateDropdown({
		Name = 'Sound',
		List = function()
			refreshSounds()
			local list = table.clone(soundNames)
			table.insert(list, 1, 'Random')
			return list
		end
	})
end)

-- Ghost_Acquired remote (Ghost.ModuleScript.lua:143) — ghost names Red/Green/Blue from GhostSpawner
run(function()
	local GhostAcquireSpam
	local Delay
	local GhostColor

	GhostAcquireSpam = minigames:CreateModule({
		Name = 'Ghost Acquire Spam',
		Function = function(enabled)
			if enabled then
				local folder = waitRemote(replicatedStorage, 'Halloween23_Remotes')
				local remote = folder and folder:FindFirstChild('Ghost_Acquired')
				if not remote then
					notif('Ghost Acquire Spam', 'Halloween23_Remotes.Ghost_Acquired missing', 5, 'warning')
					GhostAcquireSpam:ToggleButton(false)
					return
				end
				task.spawn(function()
					while GhostAcquireSpam.Enabled do
						pcall(function()
							remote:FireServer(GhostColor.Value)
						end)
						task.wait(math.max(Delay.Value, 0.1))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes.Ghost_Acquired with ghost color name (Red/Green/Blue).'
	})
	Delay = GhostAcquireSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 5,
		Default = 0.5,
		Suffix = 's'
	})
	GhostColor = GhostAcquireSpam:CreateDropdown({
		Name = 'Ghost',
		List = {'Red', 'Green', 'Blue'}
	})
end)

-- EasterItems.EggObtain FireServer("Sound") from EasterEvent.LocalScript.lua:540
run(function()
	local EasterSoundSpam
	local Delay

	EasterSoundSpam = minigames:CreateModule({
		Name = 'Easter Egg Sound Spam',
		Function = function(enabled)
			if enabled then
				local folder = waitRemote(replicatedStorage, 'EasterItems')
				local remote = folder and folder:FindFirstChild('EggObtain')
				if not remote then
					notif('Easter Egg Sound Spam', 'EasterItems.EggObtain missing', 5, 'warning')
					EasterSoundSpam:ToggleButton(false)
					return
				end
				task.spawn(function()
					while EasterSoundSpam.Enabled do
						pcall(function()
							remote:FireServer('Sound')
						end)
						task.wait(math.max(Delay.Value, 0.1))
					end
				end)
			end
		end,
		Tooltip = 'Spams ReplicatedStorage.EasterItems.EggObtain:FireServer("Sound").'
	})
	Delay = EasterSoundSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 5,
		Default = 0.35,
		Suffix = 's'
	})
end)

-- Terramancer_Stunned FireServer from Halloween24_Client.LocalScript.lua:744 (local ragdoll; server may relay)
run(function()
	local StunRemoteSpam
	local Delay

	StunRemoteSpam = minigames:CreateModule({
		Name = 'Terramancer Stun Spam',
		Function = function(enabled)
			if enabled then
				local folder = waitRemote(replicatedStorage, 'Halloween23_Remotes')
				local remote = folder and folder:FindFirstChild('Terramancer_Stunned')
				if not remote then
					notif('Terramancer Stun Spam', 'Terramancer_Stunned missing', 5, 'warning')
					StunRemoteSpam:ToggleButton(false)
					return
				end
				task.spawn(function()
					while StunRemoteSpam.Enabled do
						pcall(function()
							remote:FireServer()
						end)
						task.wait(math.max(Delay.Value, 0.25))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes.Terramancer_Stunned (ragdoll/knockback when server accepts it).'
	})
	Delay = StunRemoteSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.25,
		Max = 5,
		Default = 1,
		Suffix = 's'
	})
end)

-- One-shot Remotes.SunsetGet from Gearman.LocalScript.lua:126
run(function()
	local SunsetGet

	SunsetGet = minigames:CreateModule({
		Name = 'Sunset Get',
		Function = function(enabled)
			if enabled then
				local remotes = waitRemote(replicatedStorage, 'Remotes')
				local remote = remotes and remotes:FindFirstChild('SunsetGet')
				if not remote then
					notif('Sunset Get', 'Remotes.SunsetGet missing', 5, 'warning')
					SunsetGet:ToggleButton(false)
					return
				end
				pcall(function()
					remote:FireServer()
				end)
				task.defer(function()
					SunsetGet:ToggleButton(false)
				end)
			end
		end,
		Tooltip = 'Fires Remotes.SunsetGet once (Gear Man sunset reward remote).'
	})
end)

-- Ghost_Data sync remote from GhostSpawner.ModuleScript.lua:37
run(function()
	local GhostDataSpam
	local Delay

	GhostDataSpam = minigames:CreateModule({
		Name = 'Ghost Data Spam',
		Function = function(enabled)
			if enabled then
				local folder = waitRemote(replicatedStorage, 'Halloween23_Remotes')
				local remote = folder and folder:FindFirstChild('Ghost_Data')
				if not remote then
					notif('Ghost Data Spam', 'Ghost_Data missing', 5, 'warning')
					GhostDataSpam:ToggleButton(false)
					return
				end
				task.spawn(function()
					while GhostDataSpam.Enabled do
						pcall(function()
							remote:FireServer()
						end)
						task.wait(math.max(Delay.Value, 0.2))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes.Ghost_Data:FireServer() (ghost event sync).'
	})
	Delay = GhostDataSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.2,
		Max = 5,
		Default = 0.5,
		Suffix = 's'
	})
end)
