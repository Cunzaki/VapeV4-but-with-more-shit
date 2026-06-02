local function disableModule(mod)
	if mod and mod.Enabled then
		mod:Toggle(true)
	end
end

local function optValue(opt, default)
	if opt and opt.Value ~= nil then
		return opt.Value
	end
	return default
end

local function cloneList(list)
	local copy = {}
	for i, v in ipairs(list) do
		copy[i] = v
	end
	return copy
end

local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[9692003445] module init failed:', err)
	end
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

local function getHalloweenRemotes()
	return replicatedStorage:FindFirstChild('Halloween23_Remotes')
end

local function findHalloweenRemote(name)
	local folder = getHalloweenRemotes()
	return folder and folder:FindFirstChild(name)
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
					disableModule(RPBubbleSpam)
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
						task.wait(math.max(optValue(Delay, 0.35), 0.05))
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

	local function getAnimationList()
		refreshAnimations()
		local list = cloneList(loaded)
		table.insert(list, 1, 'Random')
		return list
	end

	refreshAnimations()

	HalloweenAnimSpam = minigames:CreateModule({
		Name = 'Halloween Anim Spam',
		Function = function(enabled)
			if enabled then
				if AnimPick then
					AnimPick:Change(getAnimationList())
				end
				if #loaded == 0 then
					notif('Halloween Anim Spam', 'No Animation children on Halloween24_Client', 5, 'warning')
					disableModule(HalloweenAnimSpam)
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
							local pick = optValue(AnimPick, 'Random')
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
						task.wait(math.max(optValue(Delay, 0.5), 0.1))
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
		List = {'Random'}
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

	local function getSoundList()
		refreshSounds()
		local list = cloneList(soundNames)
		table.insert(list, 1, 'Random')
		return list
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
				if SoundPick then
					SoundPick:Change(getSoundList())
				end
				if #soundNames == 0 then
					notif('Halloween Sound Spam', 'No Halloween sounds found', 5, 'warning')
					disableModule(HalloweenSoundSpam)
					return
				end
				task.spawn(function()
					while HalloweenSoundSpam.Enabled do
						local head = getHead()
						local pick = optValue(SoundPick, 'Random')
						if pick == 'Random' then
							pick = soundNames[math.random(1, #soundNames)]
						end
						local template = resolveSound(pick)
						if head and template and template:IsA('Sound') then
							pcall(function()
								local clone = template:Clone()
								clone.Volume = optValue(Volume, 100) / 100
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
						task.wait(math.max(optValue(Delay, 0.25), 0.05))
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
		List = {'Random'}
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
				local remote = findHalloweenRemote('Ghost_Acquired')
				if not remote then
					notif('Ghost Acquire Spam', 'Halloween23_Remotes.Ghost_Acquired missing', 5, 'warning')
					disableModule(GhostAcquireSpam)
					return
				end
				task.spawn(function()
					while GhostAcquireSpam.Enabled do
						pcall(function()
							remote:FireServer(optValue(GhostColor, 'Red'))
						end)
						task.wait(math.max(optValue(Delay, 0.5), 0.1))
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

-- EasterItems.EggObtain FireServer from EasterEvent.LocalScript.lua (Touch/Taste/Sound/Smell/Sight)
run(function()
	local EasterEggSpam
	local Delay
	local EggMode

	EasterEggSpam = minigames:CreateModule({
		Name = 'Easter Egg Spam',
		Function = function(enabled)
			if enabled then
				local folder = waitRemote(replicatedStorage, 'EasterItems')
				local remote = folder and folder:FindFirstChild('EggObtain')
				if not remote then
					notif('Easter Egg Spam', 'EasterItems.EggObtain missing', 5, 'warning')
					disableModule(EasterEggSpam)
					return
				end
				task.spawn(function()
					while EasterEggSpam.Enabled do
						pcall(function()
							remote:FireServer(optValue(EggMode, 'Sound'))
						end)
						task.wait(math.max(optValue(Delay, 0.35), 0.1))
					end
				end)
			end
		end,
		Tooltip = 'Spams ReplicatedStorage.EasterItems.EggObtain with sense mode (Touch/Taste/Sound/Smell/Sight).'
	})
	Delay = EasterEggSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 5,
		Default = 0.35,
		Suffix = 's'
	})
	EggMode = EasterEggSpam:CreateDropdown({
		Name = 'Mode',
		List = {'Sound', 'Touch', 'Taste', 'Smell', 'Sight'}
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
				local remote = findHalloweenRemote('Terramancer_Stunned')
				if not remote then
					notif('Terramancer Stun Spam', 'Terramancer_Stunned missing', 5, 'warning')
					disableModule(StunRemoteSpam)
					return
				end
				task.spawn(function()
					while StunRemoteSpam.Enabled do
						pcall(function()
							remote:FireServer()
						end)
						task.wait(math.max(optValue(Delay, 1), 0.25))
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
					disableModule(SunsetGet)
					return
				end
				pcall(function()
					remote:FireServer()
				end)
				task.defer(function()
					disableModule(SunsetGet)
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
				local remote = findHalloweenRemote('Ghost_Data')
				if not remote then
					notif('Ghost Data Spam', 'Ghost_Data missing', 5, 'warning')
					disableModule(GhostDataSpam)
					return
				end
				task.spawn(function()
					while GhostDataSpam.Enabled do
						pcall(function()
							remote:FireServer()
						end)
						task.wait(math.max(optValue(Delay, 0.5), 0.2))
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

-- Halloween win remotes from Halloween24_Client.LocalScript.lua
run(function()
	local HalloweenWinSpam
	local Delay
	local WinRemote

	local winRemotes = {
		Terramancer_Win = function(remote)
			remote:FireServer()
		end,
		Necromancer_Win = function(remote)
			remote:FireServer()
		end,
		PlagueDoctor_Win = function(remote)
			remote:FireServer()
		end,
		Fisherman_Win = function(remote)
			remote:FireServer()
		end,
		Cryomancer_Win = function(remote)
			remote:FireServer(0)
		end
	}

	HalloweenWinSpam = minigames:CreateModule({
		Name = 'Halloween Win Spam',
		Function = function(enabled)
			if enabled then
				local remoteName = optValue(WinRemote, 'Terramancer_Win')
				local remote = findHalloweenRemote(remoteName)
				if not remote then
					notif('Halloween Win Spam', 'Halloween23_Remotes.' .. remoteName .. ' missing', 5, 'warning')
					disableModule(HalloweenWinSpam)
					return
				end
				local fire = winRemotes[remoteName]
				task.spawn(function()
					while HalloweenWinSpam.Enabled do
						pcall(function()
							fire(remote)
						end)
						task.wait(math.max(optValue(Delay, 1), 0.25))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes win remotes (Terramancer/Necromancer/PlagueDoctor/Fisherman/Cryomancer).'
	})
	Delay = HalloweenWinSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.25,
		Max = 5,
		Default = 1,
		Suffix = 's'
	})
	WinRemote = HalloweenWinSpam:CreateDropdown({
		Name = 'Remote',
		List = {'Terramancer_Win', 'Necromancer_Win', 'PlagueDoctor_Win', 'Fisherman_Win', 'Cryomancer_Win'}
	})
end)

-- Halloween death remotes from Halloween24_Client.LocalScript.lua
run(function()
	local HalloweenDeathSpam
	local Delay
	local DeathRemote

	local deathRemotes = {
		Carnomancer_Death = function(remote)
			remote:FireServer()
		end,
		Hydromancer_Death = function(remote)
			remote:FireServer()
		end,
		Alchemist_Death = function(remote)
			remote:FireServer(1)
		end
	}

	HalloweenDeathSpam = minigames:CreateModule({
		Name = 'Halloween Death Spam',
		Function = function(enabled)
			if enabled then
				local remoteName = optValue(DeathRemote, 'Carnomancer_Death')
				local remote = findHalloweenRemote(remoteName)
				if not remote then
					notif('Halloween Death Spam', 'Halloween23_Remotes.' .. remoteName .. ' missing', 5, 'warning')
					disableModule(HalloweenDeathSpam)
					return
				end
				local fire = deathRemotes[remoteName]
				task.spawn(function()
					while HalloweenDeathSpam.Enabled do
						pcall(function()
							fire(remote)
						end)
						task.wait(math.max(optValue(Delay, 1), 0.25))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes death remotes (Carnomancer/Hydromancer/Alchemist).'
	})
	Delay = HalloweenDeathSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.25,
		Max = 5,
		Default = 1,
		Suffix = 's'
	})
	DeathRemote = HalloweenDeathSpam:CreateDropdown({
		Name = 'Remote',
		List = {'Carnomancer_Death', 'Hydromancer_Death', 'Alchemist_Death'}
	})
end)

-- Cabinet opened remotes from Halloween24_Client.LocalScript.lua
run(function()
	local CabinetOpenSpam
	local Delay
	local CabinetRemote

	CabinetOpenSpam = minigames:CreateModule({
		Name = 'Cabinet Open Spam',
		Function = function(enabled)
			if enabled then
				local remoteName = optValue(CabinetRemote, 'Carnomancer_CabinetOpened')
				local remote = findHalloweenRemote(remoteName)
				if not remote then
					notif('Cabinet Open Spam', 'Halloween23_Remotes.' .. remoteName .. ' missing', 5, 'warning')
					disableModule(CabinetOpenSpam)
					return
				end
				task.spawn(function()
					while CabinetOpenSpam.Enabled do
						pcall(function()
							remote:FireServer()
						end)
						task.wait(math.max(optValue(Delay, 1), 0.25))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes cabinet-open remotes (Carnomancer/Pyromancer/Luxomancer).'
	})
	Delay = CabinetOpenSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.25,
		Max = 5,
		Default = 1,
		Suffix = 's'
	})
	CabinetRemote = CabinetOpenSpam:CreateDropdown({
		Name = 'Remote',
		List = {'Carnomancer_CabinetOpened', 'Pyromancer_CabinetOpened', 'Luxomancer_CabinetOpened'}
	})
end)

-- Carnomancer_PlayerInChallenge FireServer(true/false) from Halloween24_Client.LocalScript.lua
run(function()
	local ChallengeStateSpam
	local Delay
	local ChallengeState

	ChallengeStateSpam = minigames:CreateModule({
		Name = 'Challenge State Spam',
		Function = function(enabled)
			if enabled then
				local remote = findHalloweenRemote('Carnomancer_PlayerInChallenge')
				if not remote then
					notif('Challenge State Spam', 'Carnomancer_PlayerInChallenge missing', 5, 'warning')
					disableModule(ChallengeStateSpam)
					return
				end
				task.spawn(function()
					while ChallengeStateSpam.Enabled do
						pcall(function()
							remote:FireServer(optValue(ChallengeState, 'Not In Challenge') == 'In Challenge')
						end)
						task.wait(math.max(optValue(Delay, 1), 0.25))
					end
				end)
			end
		end,
		Tooltip = 'Spams Halloween23_Remotes.Carnomancer_PlayerInChallenge with true/false.'
	})
	Delay = ChallengeStateSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.25,
		Max = 5,
		Default = 1,
		Suffix = 's'
	})
	ChallengeState = ChallengeStateSpam:CreateDropdown({
		Name = 'State',
		List = {'In Challenge', 'Not In Challenge'}
	})
end)
