--[[
	REDLINER shared game script (FFA + MATCH place IDs).
	Auto Parry (F) + Auto Attack (LMB). Parry always wins over attack.
	Sword reach default 10 studs — derived from Attack/Hitbox default size (3)
	plus wideslash forward extent (Redliner tag: CROUCHED WIDESLASH, cone ~45°).
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
local inputService = cloneref(game:GetService('UserInputService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local entitylib = vape.Libraries.entity

-- Decompiled Attack/Hitbox.ModuleScript.lua: default box size Vector3.new(3, 3, 3), cone angle 45
local DEFAULT_SWORD_REACH = 10

local PARRY_KEY = Enum.KeyCode.F
local PARRY_VK = 0x46

local PARRY_PACKET_NAME = '_x01d1e6369b1ddabb'
local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'

local MELEE_ANIM_PATTERNS = {
	'swing', 'slash', 'dark_slash', 'darkslash', 'wideslash', 'toolslash', 'hit2', 'melee',
}
local GUN_SHOT_PATTERNS = {
	'shot', 'fire', 'castigate', 'monarch', 'siege', 'phoenix', 'bullet', 'shoot',
}

local Packets
local packetsReady = false
local autoParryActive = false
local autoAttackActive = false
local debugEnabled = false
local myHurtboxes = {}
local enemyStates = {}
local lastParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local packetListenersBound = false
local parryPressToken = 0
local attackPressToken = 0

local function notif(...)
	return vape:CreateNotification(...)
end

local function debugLog(...)
	if debugEnabled then
		print('[REDLINER]', ...)
	end
end

local function initPackets()
	if Packets then
		return true
	end
	local assets = replicatedStorage:FindFirstChild('Assets')
	local modules = assets and assets:FindFirstChild('ModuleScripts')
	local packetsModule = modules and modules:FindFirstChild('Packets')
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

local function getEnemyState(char)
	if not enemyStates[char] then
		enemyStates[char] = {
			swinging = false,
			shooting = false,
		}
	end
	return enemyStates[char]
end

local function isFacingTarget(fromRoot, toPos, minDot)
	local toTarget = toPos - fromRoot.Position
	if toTarget.Magnitude < 0.1 then
		return true
	end
	return fromRoot.CFrame.LookVector:Dot(toTarget.Unit) > minDot
end

local function flatDot(fromPos, toPos, direction)
	local offset = toPos - fromPos
	local dist = offset.Magnitude
	if dist < 0.05 or direction.Magnitude < 0.05 then
		return 0, dist
	end
	return direction.Unit:Dot(offset.Unit), dist
end

local function animNameMatches(name, patterns)
	local lower = string.lower(name or '')
	for _, pat in patterns do
		if string.find(lower, pat, 1, true) then
			return true
		end
	end
	return false
end

local function getMatchingTrack(char, patterns, minPriority)
	local hum = char:FindFirstChildWhichIsA('Humanoid')
	if not hum then
		return nil
	end
	for _, track in hum:GetPlayingAnimationTracks() do
		if track.IsPlaying and track.WeightCurrent >= 0.35 then
			local animName = track.Animation and track.Animation.Name or ''
			if animNameMatches(animName, patterns) then
				if not minPriority or track.Priority.Value >= minPriority.Value then
					return track
				end
			end
		end
	end
	return nil
end

local function isEnemySwingingAtMe(char, range)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return false
	end
	local dist = (enemyRoot.Position - root.Position).Magnitude
	if dist > range then
		return false
	end
	if not isFacingTarget(enemyRoot, root.Position, 0.4) then
		return false
	end
	return getMatchingTrack(char, MELEE_ANIM_PATTERNS, Enum.AnimationPriority.Action) ~= nil
end

local function isEnemyShootingAtMe(char, range)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return false
	end
	local dist = (enemyRoot.Position - root.Position).Magnitude
	if dist > range then
		return false
	end
	if not isFacingTarget(enemyRoot, root.Position, 0.5) then
		return false
	end
	return getMatchingTrack(char, GUN_SHOT_PATTERNS, Enum.AnimationPriority.Action) ~= nil
end

local function pressParryKey()
	parryPressToken += 1
	local token = parryPressToken
	parryBlockAttackUntil = tick() + 0.22

	pcall(function()
		virtualInputManager:SendKeyEvent(true, PARRY_KEY, false, game)
	end)
	if keypress then
		pcall(keypress, PARRY_VK)
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

	return true
end

local function tryParry(reason)
	if not autoParryActive or not entitylib.isAlive then
		return false
	end
	if tick() - lastParryAt < 0.08 then
		return false
	end
	debugLog('parry', reason)
	lastParryAt = tick()
	parryBlockAttackUntil = tick() + 0.22
	pressParryKey()
	return true
end

local function pressAttackClick()
	if tick() < parryBlockAttackUntil then
		return false
	end
	if tick() - lastParryAt < 0.15 then
		return false
	end

	attackPressToken += 1
	local token = attackPressToken

	local clicked = false
	if mouse1click then
		local windowActive = true
		if isrbxactive then
			windowActive = isrbxactive()
		elseif iswindowactive then
			windowActive = iswindowactive()
		end
		if windowActive then
			pcall(mouse1click)
			clicked = true
		end
	end

	local mousePos = inputService:GetMouseLocation()
	pcall(function()
		virtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, true, game, 1)
	end)
	task.delay(0.03, function()
		if token ~= attackPressToken then
			return
		end
		pcall(function()
			virtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, false, game, 1)
		end)
	end)

	lastAttackAt = tick()
	debugLog('attack', 'lmb')
	return clicked or true
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

local function isSwingPacketAction(action)
	return typeof(action) == 'string' and animNameMatches(action, {'swing', 'slash', 'hit'})
end

local function onMeleePacket(_, action, _, direction, hurtboxes)
	if not autoParryActive then
		return
	end
	if not isSwingPacketAction(action) then
		return
	end
	if listIncludesMyHurtbox(hurtboxes) then
		tryParry('packet_melee_hurtbox')
		return
	end
	local root = getLocalRoot()
	if root and typeof(direction) == 'Vector3' then
		for _, plr in playersService:GetPlayers() do
			if plr ~= lplr and plr.Character then
				local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
				if enemyRoot then
					local dot, dist = flatDot(enemyRoot.Position, root.Position, direction)
					if dist <= 18 and dot > 0.55 then
						tryParry('packet_melee_aim')
						return
					end
				end
			end
		end
	end
end

local function onGunPacket(_, _, _, _, _, direction)
	if not autoParryActive or typeof(direction) ~= 'Vector3' then
		return
	end
	local root = getLocalRoot()
	if not root then
		return
	end
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local enemyHead = plr.Character:FindFirstChild('Head')
			local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
			local aimFrom = enemyHead and enemyHead.Position or (enemyRoot and enemyRoot.Position)
			if aimFrom then
				local dot, dist = flatDot(aimFrom, root.Position, direction)
				if dist <= 160 and dot > 0.78 then
					tryParry('packet_gun_shot')
					return
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

local function updateParryFromVisuals(char, meleeRange, gunRange)
	if not autoParryActive then
		return
	end

	local state = getEnemyState(char)
	local swinging = isEnemySwingingAtMe(char, meleeRange)
	local shooting = isEnemyShootingAtMe(char, gunRange)

	if swinging and not state.swinging then
		tryParry('visual_melee_swing')
	end
	if shooting and not state.shooting then
		tryParry('visual_gun_shot')
	end

	state.swinging = swinging
	state.shooting = shooting
end

local function enemyThreatensMe(char, meleeRange, gunRange)
	return isEnemySwingingAtMe(char, meleeRange + 2)
		or isEnemyShootingAtMe(char, gunRange)
end

local function getNearestEnemyInReach(reach)
	local root = getLocalRoot()
	if not root then
		return nil
	end
	local nearest, nearestDist = nil, reach
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
			if enemyRoot then
				local dist = (enemyRoot.Position - root.Position).Magnitude
				if dist <= reach and dist < nearestDist then
					nearest = plr.Character
					nearestDist = dist
				end
			end
		end
	end
	return nearest
end

local function tryAutoAttack(swordReach, attackCooldown)
	if not autoAttackActive or not entitylib.isAlive then
		return
	end
	if tick() < parryBlockAttackUntil then
		return
	end
	if tick() - lastParryAt < 0.18 then
		return
	end
	if tick() - lastAttackAt < attackCooldown then
		return
	end

	local target = getNearestEnemyInReach(swordReach)
	if not target then
		return
	end

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character and enemyThreatensMe(plr.Character, swordReach + 4, 140) then
			return
		end
	end

	pressAttackClick()
end

local function combatHeartbeat(meleeRange, gunRange, swordReach, attackCooldown)
	if not entitylib.isAlive then
		return
	end

	refreshPacketsReady()
	bindPacketListeners()

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			updateParryFromVisuals(plr.Character, meleeRange, gunRange)
		end
	end

	tryAutoAttack(swordReach, attackCooldown)
end

local function cleanupEnemyState(model)
	enemyStates[model] = nil
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
	local AutoAttack
	local MeleeRange
	local GunRange
	local SwordReach
	local AttackCooldown
	local Debug
	local TestParry

	AutoParry = minigames:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			autoParryActive = callback
			if callback then
				notif('Auto Parry', 'Active — parries real swings and shots only.', 4)
			end
		end,
		Tooltip = 'Presses F when an enemy in range actually swings or shoots at you.',
	})

	AutoAttack = minigames:CreateModule({
		Name = 'Auto Attack',
		Function = function(callback)
			autoAttackActive = callback
			if callback then
				notif('Auto Attack', 'Active — LMB swings when enemies are in sword reach. Yields to parry.', 4)
			end
		end,
		Tooltip = 'Left clicks when an enemy is within sword reach. Pauses while Auto Parry is reacting.',
	})

	MeleeRange = AutoParry:CreateSlider({
		Name = 'Melee Range',
		Min = 4,
		Max = 20,
		Default = 12,
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

	SwordReach = AutoAttack:CreateSlider({
		Name = 'Sword Reach',
		Min = 4,
		Max = 16,
		Default = DEFAULT_SWORD_REACH,
		Tooltip = 'Default 10 studs from decompiled hitbox size (3) + wideslash reach.',
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})

	AttackCooldown = AutoAttack:CreateSlider({
		Name = 'Attack Cooldown',
		Min = 0.15,
		Max = 1,
		Decimal = 100,
		Default = 0.38,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	Debug = AutoParry:CreateToggle({
		Name = 'Debug',
		Function = function(callback)
			debugEnabled = callback
		end,
	})

	TestParry = AutoParry:CreateToggle({
		Name = 'Test Parry (F)',
		Function = function(callback)
			if callback then
				pressParryKey()
				task.defer(function()
					if TestParry.Enabled then
						TestParry:Toggle(true)
					end
				end)
			end
		end,
	})

	local combatBound = false
	task.defer(function()
		repeat
			task.wait(0.25)
		until vape.Loaded
		if combatBound then
			return
		end
		combatBound = true

		runService.Heartbeat:Connect(function()
			if not AutoParry.Enabled and not AutoAttack.Enabled then
				return
			end
			combatHeartbeat(
				MeleeRange.Value,
				GunRange.Value,
				SwordReach.Value,
				AttackCooldown.Value
			)
		end)

		playersService.PlayerRemoving:Connect(function(plr)
			if plr.Character then
				cleanupEnemyState(plr.Character)
			end
		end)
	end)
end)

run(function()
	task.defer(function()
		local start = tick()
		repeat
			task.wait(0.25)
		until vape.Loaded or tick() - start > 20
		notif('REDLINER', 'Enable Auto Parry / Auto Attack in Minigames.', 5)
	end)
end)
