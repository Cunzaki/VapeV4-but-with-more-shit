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
local workspaceService = cloneref(game:GetService('Workspace'))

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

local function getHalloweenRemotes()
	return replicatedStorage:FindFirstChild('Halloween23_Remotes')
end

local function getHalloweenClientScript()
	return lplr.PlayerScripts:FindFirstChild('Halloween24_Client')
end

local function getCharacter()
	return lplr.Character
end

local function getHumanoidRoot()
	local char = getCharacter()
	return char and (char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Head'))
end

local function isInCharacter()
	return replicatedStorage:GetAttribute('IsInCharacter') == true
end

-- client_message_receiver: message_sent.Event -> FireServer(text) when IsInCharacter
local function fireRpBubble(text, mode)
	if mode ~= 'Direct' and not isInCharacter() then
		return false, 'not_in_character'
	end
	if mode ~= 'Direct' then
		local bindable = replicatedStorage:FindFirstChild('message_sent')
		if bindable and bindable:IsA('BindableEvent') then
			pcall(function()
				bindable:Fire(text)
			end)
			return true
		end
	end
	local remote = replicatedStorage:FindFirstChild('server_message_sent')
	if remote then
		pcall(function()
			remote:FireServer(text)
		end)
		return true
	end
	return false, 'missing_remote'
end

local function findWaterVfxTemplate()
	local searchModels = {
		'Halloween23_Necromancer',
		'Halloween23_Alchemist',
		'Halloween23_Hydromancer'
	}
	for _, modelName in ipairs(searchModels) do
		local model = workspaceService:FindFirstChild(modelName)
		if model then
			local liquid = model:FindFirstChild('CAULDRON_LIQUID', true)
				or model:FindFirstChild('LIQUID', true)
			if liquid then
				return liquid
			end
			local water = model:FindFirstChild('WATER', true)
			if water then
				return water
			end
		end
	end
	return nil
end

local function burstWaterVfx(root)
	local template = findWaterVfxTemplate()
	if not template or not root then
		return false
	end
	local emitterNames = { 'WATER SPRAY', 'MAIN SPRAY', 'RIPPLE', 'GLOW', 'SPECKS', 'SPIKES', 'FLAMEPILLAR' }
	local any = false
	for _, name in ipairs(emitterNames) do
		local src = template:FindFirstChild(name, true)
		if src and src:IsA('ParticleEmitter') then
			any = true
			local clone = src:Clone()
			clone.Enabled = true
			clone.Parent = root
			pcall(function()
				clone:Emit(math.max(clone:GetAttribute('EmitCount') or 12, 8))
			end)
			task.delay(1.25, function()
				pcall(function()
					clone:Destroy()
				end)
			end)
		end
	end
	for _, child in ipairs(template:GetChildren()) do
		if child:IsA('Sound') then
			any = true
			local snd = child:Clone()
			snd.Parent = root
			snd.Looped = false
			snd:Play()
			task.delay(snd.TimeLength > 0 and snd.TimeLength + 0.2 or 2, function()
				pcall(function()
					snd:Destroy()
				end)
			end)
		end
	end
	return any
end

local function doSwimSplash()
	local char = getCharacter()
	local hum = char and char:FindFirstChildOfClass('Humanoid')
	local root = getHumanoidRoot()
	if not hum or not root then
		return false
	end
	pcall(function()
		hum:ChangeState(Enum.HumanoidStateType.Swimming)
	end)
	local splash = root:FindFirstChild('VapeSplashSound')
	if not splash then
		splash = Instance.new('Sound')
		splash.Name = 'VapeSplashSound'
		splash.SoundId = 'rbxasset://sounds/impact_water.mp3'
		splash.RollOffMaxDistance = 120
		splash.RollOffMinDistance = 5
		splash.EmitterSize = 10
		splash.Parent = root
	end
	splash.Volume = 1
	splash.TimePosition = 0
	splash:Play()
	return true
end

local function doTerramancerStun()
	local folder = getHalloweenRemotes()
	if folder then
		local remote = folder:FindFirstChild('Terramancer_Stunned')
		if remote then
			pcall(function()
				remote:FireServer()
			end)
		end
	end
	local char = getCharacter()
	if not char then
		return
	end
	local hum = char:FindFirstChildOfClass('Humanoid')
	local torso = char:FindFirstChild('UpperTorso') or char:FindFirstChild('Torso')
	if not hum or not torso then
		return
	end
	pcall(function()
		hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		hum.PlatformStand = true
		hum:ChangeState(Enum.HumanoidStateType.Ragdoll)
		torso.AssemblyLinearVelocity = Vector3.new(math.random(-250, -100), 50, math.random(-150, 150))
		torso.AssemblyAngularVelocity = Vector3.new(
			math.rad(math.random(-1000, 1000)),
			math.rad(math.random(-1000, 1000)),
			math.rad(math.random(-1000, 1000))
		)
	end)
end

local function stopTerramancerStun()
	local char = getCharacter()
	local hum = char and char:FindFirstChildOfClass('Humanoid')
	if hum then
		pcall(function()
			hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
			hum.PlatformStand = false
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end)
	end
end

local ghostAcquireNames = {}
for _, color in ipairs({ 'Red', 'Green', 'Blue' }) do
	table.insert(ghostAcquireNames, color)
	for i = 1, 4 do
		table.insert(ghostAcquireNames, color .. '_' .. i)
	end
end

-- server_message_sent -> OnClientEvent(player, message) -> Chat:Chat on all clients
run(function()
	local RPBubbleSpam
	local Delay
	local CustomText
	local SendMode
	local warnedCharacter = false
	local warnedRemote = false

	local presetLines = {
		'...',
		'hello?',
		'can you hear me',
		'lag?',
		'brb',
		'what',
		'stop',
		'help',
		'???',
		'ok',
		'AAAAAAAA',
		'why is everyone staring',
		'*splash*',
		'help im drowning',
		'water water water'
	}
	local presetIndex = 1

	RPBubbleSpam = minigames:CreateModule({
		Name = 'RP Bubble Spam',
		Function = function(enabled)
			if enabled then
				local remote = replicatedStorage:FindFirstChild('server_message_sent')
				if not remote then
					remote = waitRemote(replicatedStorage, 'server_message_sent', 4)
				end
				if not remote then
					notif('RP Bubble Spam', 'server_message_sent missing', 5, 'warning')
					disableModule(RPBubbleSpam)
					return
				end
				if optValue(SendMode, 'Game path') == 'Game path' and not isInCharacter() then
					notif('RP Bubble Spam', 'Game path needs IsInCharacter', 6, 'warning')
				end
				task.spawn(function()
					while RPBubbleSpam.Enabled do
						local text = CustomText and CustomText.Value or ''
						if text == '' then
							text = presetLines[presetIndex]
							presetIndex = presetIndex % #presetLines + 1
						end
						local mode = optValue(SendMode, 'Game path')
						local ok, reason = fireRpBubble(text, mode)
						if not ok then
							if reason == 'not_in_character' and not warnedCharacter then
								warnedCharacter = true
								notif('RP Bubble Spam', 'Use Direct mode or spawn in role', 5, 'warning')
							elseif reason == 'missing_remote' and not warnedRemote then
								warnedRemote = true
								notif('RP Bubble Spam', 'server_message_sent missing', 5, 'warning')
								disableModule(RPBubbleSpam)
								break
							end
						else
							warnedCharacter = false
						end
						task.wait(math.max(optValue(Delay, 0.25), 0.05))
					end
				end)
			else
				warnedCharacter = false
				warnedRemote = false
			end
		end,
		Tooltip = 'TRUE server broadcast: FireServer(string) -> Chat bubbles on every client (client_message_receiver). Game path uses message_sent bindable like typing RP chat.'
	})
	Delay = RPBubbleSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 3,
		Default = 0.25,
		Suffix = 's'
	})
	SendMode = RPBubbleSpam:CreateDropdown({
		Name = 'Send Path',
		List = { 'Game path', 'Direct' }
	})
	CustomText = RPBubbleSpam:CreateTextBox({
		Name = 'Custom Bubble',
		Placeholder = 'leave empty for presets'
	})
end)

-- Halloween24_Client Animation children on Humanoid (replicates to nearby players)
run(function()
	local HalloweenAnimSpam
	local Delay
	local AnimPick
	local loaded = {}

	local function refreshAnimations()
		table.clear(loaded)
		local scriptRef = getHalloweenClientScript()
		if not scriptRef then
			return
		end
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
				refreshAnimations()
				if AnimPick then
					AnimPick:Change(getAnimationList())
				end
				if #loaded == 0 then
					notif('Halloween Anim Spam', 'Halloween24_Client animations missing', 5, 'warning')
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
		Tooltip = 'Nearby replication: loops Halloween24_Client animations on YOUR Humanoid. Other players see your character emote.'
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
		List = getAnimationList()
	})
end)

-- Halloween23_Remotes + Halloween24_Client sounds (Terramancer_Stone etc. from decompile line 718-724)
run(function()
	local HalloweenSFXSpam
	local Delay
	local Volume
	local SoundPick

	local soundNames = {}
	local function refreshSounds()
		table.clear(soundNames)
		local scriptRef = getHalloweenClientScript()
		if scriptRef then
			for _, v in ipairs(scriptRef:GetChildren()) do
				if v:IsA('Sound') then
					table.insert(soundNames, 'Client:' .. v.Name)
				end
			end
		end
		local folder = getHalloweenRemotes()
		if folder then
			for _, v in ipairs(folder:GetChildren()) do
				if v:IsA('Sound') then
					table.insert(soundNames, 'Remote:' .. v.Name)
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

	local function resolveSound(name)
		if name:sub(1, 7) == 'Client:' then
			local scriptRef = getHalloweenClientScript()
			return scriptRef and scriptRef:FindFirstChild(name:sub(8))
		end
		if name:sub(1, 7) == 'Remote:' then
			local folder = getHalloweenRemotes()
			return folder and folder:FindFirstChild(name:sub(8))
		end
	end

	local function playReplicatedSound(template, vol)
		local root = getHumanoidRoot()
		if not root or not template or not template:IsA('Sound') then
			return
		end
		local clone = template:Clone()
		clone.Volume = vol
		clone.Looped = false
		clone.RollOffMaxDistance = 1000
		clone.RollOffMinDistance = 5
		clone.EmitterSize = math.max(clone.EmitterSize, 12)
		clone.Parent = root
		clone:Play()
		local lifetime = clone.TimeLength > 0 and clone.TimeLength + 0.25 or 2
		task.delay(lifetime, function()
			pcall(function()
				clone:Destroy()
			end)
		end)
	end

	refreshSounds()

	HalloweenSFXSpam = minigames:CreateModule({
		Name = 'Halloween SFX Spam',
		Function = function(enabled)
			if enabled then
				refreshSounds()
				if SoundPick then
					SoundPick:Change(getSoundList())
				end
				if #soundNames == 0 then
					notif('Halloween SFX Spam', 'No Halloween sounds found', 5, 'warning')
					disableModule(HalloweenSFXSpam)
					return
				end
				task.spawn(function()
					while HalloweenSFXSpam.Enabled do
						local pick = optValue(SoundPick, 'Random')
						if pick == 'Random' then
							pick = soundNames[math.random(1, #soundNames)]
						end
						pcall(function()
							playReplicatedSound(resolveSound(pick), optValue(Volume, 100) / 100)
						end)
						task.wait(math.max(optValue(Delay, 0.2), 0.05))
					end
				end)
			end
		end,
		Tooltip = 'Clones Halloween23_Remotes / Halloween24_Client sounds onto HumanoidRootPart (same pattern as Terramancer_Stone in decompile). Nearby 3D audio; not a server-targeted remote.'
	})
	Delay = HalloweenSFXSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 3,
		Default = 0.2,
		Suffix = 's'
	})
	Volume = HalloweenSFXSpam:CreateSlider({
		Name = 'Volume',
		Min = 10,
		Max = 100,
		Default = 100,
		Suffix = '%'
	})
	SoundPick = HalloweenSFXSpam:CreateDropdown({
		Name = 'Sound',
		List = getSoundList()
	})
end)

-- No FireServer for water splash in decompile; RbxCharacterSounds Splash + Swimming state (line 145-176)
run(function()
	local SwimSplashSpam
	local Delay
	local ModePick
	local warned = false

	SwimSplashSpam = minigames:CreateModule({
		Name = 'Swim Splash Spam',
		Function = function(enabled)
			if enabled then
				task.spawn(function()
					while SwimSplashSpam.Enabled do
						local mode = optValue(ModePick, 'Splash + Swim')
						local ok = false
						if mode == 'Splash + Swim' or mode == 'Splash only' then
							ok = doSwimSplash() or ok
						end
						if mode == 'Splash + Swim' or mode == 'VFX burst' then
							ok = burstWaterVfx(getHumanoidRoot()) or ok
						end
						if not ok and not warned then
							warned = true
							notif('Swim Splash Spam', 'Need character / workspace water assets', 5, 'warning')
						end
						task.wait(math.max(optValue(Delay, 0.35), 0.08))
					end
				end)
			end
		end,
		Tooltip = 'No water-splash remote exists. Uses Swimming state + impact_water (RbxCharacterSounds) and/or cloned CAULDRON_LIQUID particles from workspace Halloween maps. Nearby visibility only.'
	})
	Delay = SwimSplashSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.08,
		Max = 3,
		Default = 0.35,
		Suffix = 's'
	})
	ModePick = SwimSplashSpam:CreateDropdown({
		Name = 'Mode',
		List = { 'Splash + Swim', 'Splash only', 'VFX burst' }
	})
end)

-- Terramancer_Stunned:FireServer() with no args (Halloween24_Client line 744) + client ragdoll
run(function()
	local TerramancerStunSpam
	local Delay

	TerramancerStunSpam = minigames:CreateModule({
		Name = 'Terramancer Stun Spam',
		Function = function(enabled)
			if enabled then
				local folder = getHalloweenRemotes()
				if not folder or not folder:FindFirstChild('Terramancer_Stunned') then
					notif('Terramancer Stun Spam', 'Halloween23_Remotes.Terramancer_Stunned missing', 5, 'warning')
					disableModule(TerramancerStunSpam)
					return
				end
				task.spawn(function()
					while TerramancerStunSpam.Enabled do
						doTerramancerStun()
						task.wait(math.max(optValue(Delay, 1), 0.35))
					end
					stopTerramancerStun()
				end)
			else
				stopTerramancerStun()
			end
		end,
		Tooltip = 'Fires Halloween23_Remotes.Terramancer_Stunned:FireServer() (no args) then local ragdoll like terra wall hit. Server may replicate stun; others see you ragdoll.'
	})
	TerramancerStunSpam:Clean(stopTerramancerStun)
	Delay = TerramancerStunSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.35,
		Max = 5,
		Default = 1,
		Suffix = 's'
	})
end)

-- Ghost_Acquired:FireServer(ghostName) per Ghost.ModuleScript line 143
run(function()
	local GhostAcquireSpam
	local Delay
	local NamePick
	local ghostIndex = 1

	local function getGhostList()
		local list = cloneList(ghostAcquireNames)
		table.insert(list, 1, 'Random')
		return list
	end

	GhostAcquireSpam = minigames:CreateModule({
		Name = 'Ghost Acquire Spam',
		Function = function(enabled)
			if enabled then
				local folder = getHalloweenRemotes()
				local remote = folder and folder:FindFirstChild('Ghost_Acquired')
				if not remote then
					notif('Ghost Acquire Spam', 'Ghost_Acquired missing', 5, 'warning')
					disableModule(GhostAcquireSpam)
					return
				end
				task.spawn(function()
					while GhostAcquireSpam.Enabled do
						local pick = optValue(NamePick, 'Random')
						if pick == 'Random' then
							pick = ghostAcquireNames[ghostIndex]
							ghostIndex = ghostIndex % #ghostAcquireNames + 1
						end
						pcall(function()
							remote:FireServer(pick)
						end)
						task.wait(math.max(optValue(Delay, 0.5), 0.15))
					end
				end)
			end
		end,
		Tooltip = 'Server: Halloween23_Remotes.Ghost_Acquired:FireServer(ghostName) e.g. Red, Green_2. May spam ghost catch events if server accepts fake names.'
	})
	Delay = GhostAcquireSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.15,
		Max = 5,
		Default = 0.5,
		Suffix = 's'
	})
	NamePick = GhostAcquireSpam:CreateDropdown({
		Name = 'Ghost Name',
		List = getGhostList()
	})
end)

-- Reverse_Walkspeed BindableEvent :Fire(bool) — local movement flip (ControlModule line 8)
run(function()
	local ReverseWalkSpam

	ReverseWalkSpam = minigames:CreateModule({
		Name = 'Reverse Walk Spam',
		Function = function(enabled)
			if enabled then
				local folder = getHalloweenRemotes()
				local bindable = folder and folder:FindFirstChild('Reverse_Walkspeed')
				if not bindable then
					notif('Reverse Walk Spam', 'Reverse_Walkspeed missing', 5, 'warning')
					disableModule(ReverseWalkSpam)
					return
				end
				pcall(function()
					bindable:Fire(true)
				end)
				notif('Reverse Walk Spam', 'Movement inverted locally until disabled', 4, 'info')
			else
				local folder = getHalloweenRemotes()
				local bindable = folder and folder:FindFirstChild('Reverse_Walkspeed')
				if bindable then
					pcall(function()
						bindable:Fire(false)
					end)
				end
			end
		end,
		Tooltip = 'LOCAL only: Reverse_Walkspeed:Fire(true/false) flips ControlModule walk direction. Others see erratic movement replication, not a server effect remote.'
	})
end)

-- Hydromancer_Death:FireServer() no args when touching flood water (line 3668)
run(function()
	local HydromancerDeathSpam
	local Delay

	HydromancerDeathSpam = minigames:CreateModule({
		Name = 'Hydromancer Death Spam',
		Function = function(enabled)
			if enabled then
				local folder = getHalloweenRemotes()
				local remote = folder and folder:FindFirstChild('Hydromancer_Death')
				if not remote then
					notif('Hydromancer Death Spam', 'Hydromancer_Death missing', 5, 'warning')
					disableModule(HydromancerDeathSpam)
					return
				end
				notif('Hydromancer Death Spam', 'Fires death remote; may move YOU (not others)', 5, 'info')
				task.spawn(function()
					while HydromancerDeathSpam.Enabled do
						pcall(function()
							remote:FireServer()
						end)
						task.wait(math.max(optValue(Delay, 2), 0.5))
					end
				end)
			end
		end,
		Tooltip = 'Fires Halloween23_Remotes.Hydromancer_Death:FireServer() with no args. Decompile uses this for flood death cutscene on YOU — Hydromancer_FloodBegun is server->client only.'
	})
	Delay = HydromancerDeathSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.5,
		Max = 10,
		Default = 2,
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
				notif('Sunset Get', 'Fired SunsetGet once', 3, 'info')
				task.defer(function()
					disableModule(SunsetGet)
				end)
			end
		end,
		Tooltip = 'Fires Remotes.SunsetGet once (Gear Man reward). Does not annoy other players.'
	})
end)
