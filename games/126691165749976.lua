--[[
	REDLINER shared game script (FFA + MATCH place IDs).
	Auto Parry presses F (parry bind) via VirtualInputManager / keypress.
]]

local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[REDLINER]', err)
	end
end

local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local collectionService = cloneref(game:GetService('CollectionService'))
local runService = cloneref(game:GetService('RunService'))
local virtualInputManager = cloneref(game:GetService('VirtualInputManager'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local entitylib = vape.Libraries.entity

local PARRY_KEY = Enum.KeyCode.F
local PARRY_VK = 0x46

local PARRY_PACKET_NAME = '_x01d1e6369b1ddabb'
local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'

local Packets
local packetsReady = false
local autoParryActive = false
local debugEnabled = false
local myHurtboxes = {}
local lastParryAt = 0
local enemyGlintState = {}
local packetListenersBound = false
local parryPressToken = 0

local function notif(...)
	return vape:CreateNotification(...)
end

local function debugLog(...)
	if debugEnabled then
		print('[REDLINER AutoParry]', ...)
	end
end

local function initPackets()
	if Packets then
		return true
	end

	local assets = replicatedStorage:FindFirstChild('Assets')
	if not assets then
		return false
	end

	local modules = assets:FindFirstChild('ModuleScripts')
	if not modules then
		return false
	end

	local packetsModule = modules:FindFirstChild('Packets')
	if not packetsModule then
		return false
	end

	local ok, loaded = pcall(require, packetsModule)
	if not ok then
		return false
	end

	Packets = loaded
	return true
end

local function refreshPacketsReady()
	if initPackets() then
		local parryPacket = Packets[PARRY_PACKET_NAME]
		packetsReady = parryPacket and parryPacket.Id ~= nil
	end
	return packetsReady
end

local function refreshMyHurtboxes()
	table.clear(myHurtboxes)
	if not entitylib.isAlive then
		return
	end
	local char = entitylib.character.Character
	if not char then
		return
	end
	for _, part in collectionService:GetTagged('Hurtbox') do
		if part.Parent and part:IsDescendantOf(char) then
			table.insert(myHurtboxes, part)
		end
	end
	if #myHurtboxes == 0 then
		local root = char:FindFirstChild('HumanoidRootPart')
		local head = char:FindFirstChild('Head')
		if root then
			table.insert(myHurtboxes, root)
		end
		if head then
			table.insert(myHurtboxes, head)
		end
	end
end

local function getLocalRoot()
	return entitylib.isAlive and entitylib.character.RootPart
end

local function isEnemyCharacter(model)
	if not model or model == lplr.Character then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(model)
	return plr and plr ~= lplr
end

local function flatDot(fromPos, toPos, direction)
	local offset = toPos - fromPos
	local dist = offset.Magnitude
	if dist < 0.05 or direction.Magnitude < 0.05 then
		return 0, dist
	end
	return direction.Unit:Dot(offset.Unit), dist
end

local function isFacingTarget(fromRoot, toPos, minDot)
	local toTarget = toPos - fromRoot.Position
	if toTarget.Magnitude < 0.1 then
		return true
	end
	return fromRoot.CFrame.LookVector:Dot(toTarget.Unit) > minDot
end

local function pressParryKey()
	parryPressToken += 1
	local token = parryPressToken

	local sent = false

	pcall(function()
		virtualInputManager:SendKeyEvent(true, PARRY_KEY, false, game)
		sent = true
	end)

	if keypress then
		pcall(function()
			keypress(PARRY_VK)
			sent = true
		end)
	end

	task.delay(0.04, function()
		if token ~= parryPressToken then
			return
		end
		pcall(function()
			virtualInputManager:SendKeyEvent(false, PARRY_KEY, false, game)
		end)
		if keyrelease then
			pcall(keyrelease, PARRY_VK)
		end
	end)

	if packetsReady and Packets then
		local packet = Packets[PARRY_PACKET_NAME]
		if packet and packet.Id then
			task.spawn(function()
				pcall(function()
					packet:Fire()
				end)
			end)
		end
	end

	return sent
end

local function tryParry(reason)
	if not autoParryActive then
		return false
	end
	if tick() - lastParryAt < 0.05 then
		return false
	end
	if not entitylib.isAlive then
		return false
	end

	debugLog('parry', reason or 'unknown')
	if pressParryKey() then
		lastParryAt = tick()
		return true
	end
	return false
end

local function listIncludesMyHurtbox(list)
	if typeof(list) ~= 'table' then
		return false
	end
	refreshMyHurtboxes()
	for _, mine in myHurtboxes do
		if table.find(list, mine) then
			return true
		end
	end
	return false
end

local function directionThreatensMe(direction, maxRange)
	local root = getLocalRoot()
	if not root or typeof(direction) ~= 'Vector3' then
		return false
	end
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
			if enemyRoot then
				local dot, dist = flatDot(enemyRoot.Position, root.Position, direction)
				if dist <= maxRange and dot > 0.2 then
					return true
				end
			end
		end
	end
	return false
end

local function isSwingAction(action)
	if typeof(action) ~= 'string' then
		return false
	end
	local lower = string.lower(action)
	return string.find(lower, 'swing', 1, true)
		or string.find(lower, 'slash', 1, true)
		or string.find(lower, 'hit', 1, true)
		or string.find(lower, 'attack', 1, true)
end

local function onMeleePacket(_, action, _, direction, hurtboxes)
	if listIncludesMyHurtbox(hurtboxes) then
		tryParry('melee_packet_hurtbox')
		return
	end
	if isSwingAction(action) and directionThreatensMe(direction, 20) then
		tryParry('melee_packet_direction')
	end
end

local function onGunPacket(_, _, _, _, _, direction)
	if typeof(direction) ~= 'Vector3' then
		return
	end

	local root = getLocalRoot()
	if not root then
		return
	end

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
			local enemyHead = plr.Character:FindFirstChild('Head') or enemyRoot
			if enemyRoot and enemyHead then
				local dist = (enemyRoot.Position - root.Position).Magnitude
				if dist <= 150 then
					local dot, shotDist = flatDot(enemyHead.Position, root.Position, direction)
					if shotDist <= 150 and dot > 0.65 then
						tryParry('gun_packet')
						return
					end
				end
			end
		end
	end
end

local function bindPacketListeners()
	if packetListenersBound then
		return
	end
	if not refreshPacketsReady() then
		return
	end
	packetListenersBound = true

	local meleePacket = Packets[MELEE_PACKET_NAME]
	local gunPacket = Packets[GUN_PACKET_NAME]

	if meleePacket and meleePacket.OnClientEvent then
		meleePacket.OnClientEvent:Connect(onMeleePacket)
	end
	if gunPacket and gunPacket.OnClientEvent then
		gunPacket.OnClientEvent:Connect(onGunPacket)
	end
end

local function isCombatAnimation(track)
	if not track.IsPlaying or track.WeightCurrent < 0.1 then
		return false
	end
	local animName = track.Animation and string.lower(track.Animation.Name) or ''
	if string.find(animName, 'idle', 1, true)
		or string.find(animName, 'walk', 1, true)
		or string.find(animName, 'run', 1, true)
		or string.find(animName, 'jump', 1, true)
		or string.find(animName, 'fall', 1, true)
		or string.find(animName, 'land', 1, true) then
		return false
	end
	return track.Priority.Value >= Enum.AnimationPriority.Action.Value
		or string.find(animName, 'swing', 1, true)
		or string.find(animName, 'slash', 1, true)
		or string.find(animName, 'shot', 1, true)
		or string.find(animName, 'fire', 1, true)
		or string.find(animName, 'draw', 1, true)
		or string.find(animName, 'attack', 1, true)
end

local function isEnemyAttacking(char)
	local hum = char:FindFirstChildWhichIsA('Humanoid')
	if not hum then
		return false
	end
	for _, track in hum:GetPlayingAnimationTracks() do
		if isCombatAnimation(track) then
			return true
		end
	end
	return false
end

local function instanceShowsGlint(inst)
	if inst:IsA('ParticleEmitter') and inst.Enabled and inst.Rate > 0 then
		return true
	end
	if inst:IsA('BillboardGui') and inst.Enabled then
		for _, child in inst:GetDescendants() do
			if child:IsA('ImageLabel') and child.ImageTransparency < 0.95 then
				return true
			end
		end
	end
	if inst:IsA('Highlight') and inst.Enabled then
		return true
	end
	if inst:IsA('Beam') and inst.Enabled then
		return true
	end
	return false
end

local function modelHasGlint(model)
	for _, attr in {'Glint', 'GunDrawn', 'Drawing', 'Drawn', 'Aiming', 'Draw'} do
		local val = model:GetAttribute(attr)
		if val == true or val == 1 then
			return true
		end
	end

	for _, inst in model:GetDescendants() do
		local name = string.lower(inst.Name)
		if string.find(name, 'glint', 1, true)
			or string.find(name, 'draw', 1, true)
			or string.find(name, 'aim', 1, true)
			or string.find(name, 'scope', 1, true)
			or string.find(name, 'flash', 1, true) then
			if instanceShowsGlint(inst) then
				return true
			end
		end
	end

	return false
end

local function swingZoneHitsMe(enemyRoot, range)
	refreshMyHurtboxes()
	if #myHurtboxes == 0 then
		return false
	end

	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = myHurtboxes

	local swingCF = enemyRoot.CFrame * CFrame.new(0, 0, -range * 0.35)
	local swingSize = Vector3.new(range * 1.2, 7, range * 1.1)
	local hits = workspace:GetPartBoundsInBox(swingCF, swingSize, params)
	if #hits > 0 then
		return true
	end

	local radiusHits = workspace:GetPartBoundsInRadius(enemyRoot.Position, range * 0.75, params)
	return #radiusHits > 0
end

local function isMeleeThreat(char, range)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return false
	end

	local dist = (enemyRoot.Position - root.Position).Magnitude
	if dist > range then
		return false
	end

	if not isFacingTarget(enemyRoot, root.Position, 0.05) then
		return false
	end

	local toMe = (root.Position - enemyRoot.Position).Unit
	local approach = enemyRoot.AssemblyLinearVelocity:Dot(toMe)

	if dist <= 7 then
		return isEnemyAttacking(char) or approach > 4 or swingZoneHitsMe(enemyRoot, range)
	end

	if isEnemyAttacking(char) and (approach > 2 or dist <= range * 0.85) then
		return true
	end

	if swingZoneHitsMe(enemyRoot, range) then
		return true
	end

	return approach > 10 and dist <= range * 0.7
end

local function isGunThreat(char, range)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return false
	end

	local dist = (enemyRoot.Position - root.Position).Magnitude
	if dist > range then
		return false
	end

	if modelHasGlint(char) then
		return isFacingTarget(enemyRoot, root.Position, 0.05)
	end

	if isEnemyAttacking(char) and isFacingTarget(enemyRoot, root.Position, 0.15) then
		local hum = char:FindFirstChildWhichIsA('Humanoid')
		if hum then
			for _, track in hum:GetPlayingAnimationTracks() do
				local animName = track.Animation and string.lower(track.Animation.Name) or ''
				if track.IsPlaying and (
					string.find(animName, 'shot', 1, true)
					or string.find(animName, 'fire', 1, true)
					or string.find(animName, 'draw', 1, true)
					or string.find(animName, 'aim', 1, true)
				) then
					return true
				end
			end
		end
	end

	return false
end

local function trackEnemyGlint(model)
	if not isEnemyCharacter(model) or enemyGlintState[model] then
		return
	end
	enemyGlintState[model] = true

	local function onDescendant()
		if not autoParryActive or not entitylib.isAlive then
			return
		end
		if modelHasGlint(model) then
			local root = getLocalRoot()
			local enemyRoot = model:FindFirstChild('HumanoidRootPart')
			if root and enemyRoot and (enemyRoot.Position - root.Position).Magnitude <= 120 then
				tryParry('glint_spawn')
			end
		end
	end

	model.DescendantAdded:Connect(onDescendant)
end

local function scanThreats(meleeRange, gunRange)
	if not entitylib.isAlive then
		return
	end

	refreshMyHurtboxes()

	for _, plr in playersService:GetPlayers() do
		if plr == lplr then
			continue
		end
		local char = plr.Character
		if not char then
			continue
		end

		trackEnemyGlint(char)

		if isGunThreat(char, gunRange) then
			tryParry('gun_visual')
		elseif isMeleeThreat(char, meleeRange) then
			tryParry('melee_visual')
		end
	end
end

local function cleanupEnemyState(model)
	enemyGlintState[model] = nil
end

run(function()
	if not vape.Categories.Minigames then
		vape.Categories.Minigames = vape:CreateCategory({
			Name = 'Minigames',
			Icon = 'vape/assets/new/minigames.png'
		})
	end

	local minigames = vape.Categories.Minigames
	local AutoParry
	local MeleeRange
	local GunRange
	local Debug
	local TestParry

	AutoParry = minigames:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			autoParryActive = callback
			if not callback then
				return
			end

			refreshPacketsReady()
			bindPacketListeners()
			notif('Auto Parry', 'Active. Parries with F key.', 4)

			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character then
					trackEnemyGlint(plr.Character)
				end
			end

			AutoParry:Clean(playersService.PlayerAdded:Connect(function(plr)
				if plr == lplr then
					return
				end
				AutoParry:Clean(plr.CharacterAdded:Connect(function(char)
					trackEnemyGlint(char)
				end))
				if plr.Character then
					trackEnemyGlint(plr.Character)
				end
			end))

			AutoParry:Clean(playersService.PlayerRemoving:Connect(function(plr)
				if plr.Character then
					cleanupEnemyState(plr.Character)
				end
			end))

			AutoParry:Clean(runService.Heartbeat:Connect(function()
				refreshPacketsReady()
				scanThreats(MeleeRange.Value, GunRange.Value)
			end))
		end,
		Tooltip = 'Presses F to parry incoming melee swings and gun shots.',
	})

	MeleeRange = AutoParry:CreateSlider({
		Name = 'Melee Range',
		Min = 4,
		Max = 24,
		Default = 16,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})

	GunRange = AutoParry:CreateSlider({
		Name = 'Gun Range',
		Min = 20,
		Max = 200,
		Default = 120,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})

	Debug = AutoParry:CreateToggle({
		Name = 'Debug',
		Function = function(callback)
			debugEnabled = callback
			if callback then
				refreshPacketsReady()
				print('[REDLINER AutoParry] debug on | packetsReady=', packetsReady, 'parryId=', Packets and Packets[PARRY_PACKET_NAME] and Packets[PARRY_PACKET_NAME].Id)
			end
		end,
	})

	TestParry = AutoParry:CreateToggle({
		Name = 'Test Parry (F)',
		Function = function(callback)
			if callback then
				pressParryKey()
				notif('Auto Parry', 'Sent F key press. Toggle off Test Parry.', 3)
				task.defer(function()
					if TestParry.Enabled then
						TestParry:Toggle(true)
					end
				end)
			end
		end,
		Tooltip = 'Sends one F key press so you can verify parry input works.',
	})
end)

run(function()
	task.defer(function()
		local start = tick()
		repeat
			task.wait(0.25)
		until vape.Loaded or tick() - start > 20
		notif('REDLINER', 'Enable Auto Parry in Minigames. Use Test Parry to verify F input.', 6)
	end)
end)
