--[[
	REDLINER shared game script (FFA + MATCH place IDs).
	Auto Parry, Auto Attack, Reach (melee packet extension).
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

pcall(function()
	vape:Remove('Reach')
end)

-- Decompiled Attack/Hitbox default box size is 3; wideslash reach ~10 studs total
local BASE_SWORD_REACH = 10

local PARRY_KEY = Enum.KeyCode.F
local PARRY_VK = 0x46

local PARRY_PACKET_NAME = '_x01d1e6369b1ddabb'
local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'

local SWING_ANIM_PATTERNS = {
	'swing', 'slash', 'dark_slash', 'darkslash', 'wideslash', 'toolslash',
}
local GUN_SHOT_PATTERNS = {
	'shot', 'fire', 'castigate', 'monarch', 'siege', 'phoenix', 'bullet', 'shoot',
}

local Packets
local packetsReady = false
local autoParryActive = false
local autoAttackActive = false
local reachActive = false
local reachExtend = 0
local debugEnabled = false
local myHurtboxes = {}
local enemyStates = {}
local meleeTemplate = nil
local meleeHooked = false
local lastParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local packetListenersBound = false
local parryPressToken = 0
local attackPressToken = 0

local function notif(...)
	return vape:CreateNotification(...)
end

local function withThread(func)
	if vape.ThreadFix and setthreadidentity then
		setthreadidentity(8)
	end
	return func()
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

local function getMeleeReach()
	return BASE_SWORD_REACH + (reachActive and reachExtend or 0)
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
			lastSwingId = '',
			lastShotId = '',
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

local function getActiveAttackTrack(char, patterns, minTime, maxTime)
	local hum = char:FindFirstChildWhichIsA('Humanoid')
	if not hum then
		return nil
	end
	minTime = minTime or 0
	maxTime = maxTime or 0.45
	for _, track in hum:GetPlayingAnimationTracks() do
		if track.IsPlaying and track.WeightCurrent >= 0.45 then
			local animName = track.Animation and track.Animation.Name or ''
			if animNameMatches(animName, patterns) then
				if track.Priority.Value >= Enum.AnimationPriority.Action.Value then
					local t = track.TimePosition
					if t >= minTime and t <= maxTime then
						return track
					end
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
	if not isFacingTarget(enemyRoot, root.Position, 0.45) then
		return false
	end
	return getActiveAttackTrack(char, SWING_ANIM_PATTERNS, 0.08, 0.38) ~= nil
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
	if not isFacingTarget(enemyRoot, root.Position, 0.55) then
		return false
	end
	return getActiveAttackTrack(char, GUN_SHOT_PATTERNS, 0.05, 0.55) ~= nil
end

local function fireParryPacket()
	refreshPacketsReady()
	if not packetsReady or not Packets then
		return false
	end
	local packet = Packets[PARRY_PACKET_NAME]
	if not packet or not packet.Id then
		return false
	end
	task.spawn(function()
		withThread(function()
			pcall(function()
				packet:Fire()
			end)
		end)
	end)
	return true
end

local function pressParryKey()
	parryPressToken += 1
	local token = parryPressToken
	parryBlockAttackUntil = tick() + 0.22

	local sent = fireParryPacket()

	pcall(function()
		virtualInputManager:SendKeyEvent(true, PARRY_KEY, false, game)
	end)
	if keypress then
		pcall(keypress, PARRY_VK)
	end

	task.delay(0.05, function()
		if token ~= parryPressToken then
			return
		end
		fireParryPacket()
		pcall(function()
			virtualInputManager:SendKeyEvent(false, PARRY_KEY, false, game)
		end)
		if keyrelease then
			pcall(keyrelease, PARRY_VK)
		end
	end)

	debugLog('parry sent', sent and 'packet+key' or 'key only')
	return sent
end

local function tryParry(reason)
	if not autoParryActive or not entitylib.isAlive then
		return false
	end
	if tick() - lastParryAt < 0.12 then
		return false
	end

	debugLog('parry trigger', reason)
	lastParryAt = tick()
	parryBlockAttackUntil = tick() + 0.22
	pressParryKey()
	return true
end

local function pressAttackClick()
	if tick() < parryBlockAttackUntil then
		return false
	end
	if tick() - lastParryAt < 0.2 then
		return false
	end

	attackPressToken += 1
	local token = attackPressToken

	if mouse1click then
		local windowActive = true
		if isrbxactive then
			windowActive = isrbxactive()
		elseif iswindowactive then
			windowActive = iswindowactive()
		end
		if windowActive then
			pcall(mouse1click)
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
	return true
end

local function getEnemyHurtboxesInRange(range, origin)
	origin = origin or (entitylib.isAlive and entitylib.character.RootPart.Position)
	if not origin then
		return {}
	end
	local sorted = {}
	for _, part in collectionService:GetTagged('Hurtbox') do
		if part.Parent then
			local owner = part:FindFirstAncestorWhichIsA('Model')
			if owner and isEnemyCharacter(owner) then
				local dist = (part.Position - origin).Magnitude
				if dist <= range then
					table.insert(sorted, {Part = part, Distance = dist})
				end
			end
		end
	end
	table.sort(sorted, function(a, b)
		return a.Distance < b.Distance
	end)
	local results = {}
	for _, entry in sorted do
		table.insert(results, entry.Part)
	end
	return results
end

local function captureMeleeTemplate(packed)
	if packed.n < 2 or typeof(packed[2]) ~= 'string' then
		return
	end
	local action = string.upper(packed[2])
	if string.find(action, 'SWING', 1, true) or string.find(action, 'SLASH', 1, true) then
		meleeTemplate = packed
	end
end

local function installMeleeReachHook()
	if meleeHooked or not initPackets() then
		return
	end
	local packet = Packets[MELEE_PACKET_NAME]
	if not packet or packet._reachHooked then
		return
	end
	packet._reachHooked = true
	meleeHooked = true
	local oldFire = packet.Fire
	packet.Fire = function(self, ...)
		local packed = table.pack(...)
		captureMeleeTemplate(packed)

		if reachActive and entitylib.isAlive then
			local root = entitylib.character.RootPart
			local hurtboxes = getEnemyHurtboxesInRange(getMeleeReach(), root.Position)
			if #hurtboxes > 0 then
				local aimDir = (hurtboxes[1].Position - root.Position).Unit
				if packed.n < 5 then
					local template = meleeTemplate
					packed[1] = packed[1] or (template and template[1]) or 'Redliner'
					packed[2] = packed[2] or (template and template[2]) or 'SWING'
					packed[3] = packed[3] or (template and template[3]) or ''
					packed[4] = aimDir
					packed[5] = hurtboxes
					packed[6] = packed[6] or (template and template[6])
					packed.n = math.max(packed.n, 5)
				else
					packed[4] = aimDir
					packed[5] = hurtboxes
				end
			end
		end

		return oldFire(self, table.unpack(packed, 1, packed.n))
	end
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
	return typeof(action) == 'string' and (
		string.find(string.lower(action), 'swing', 1, true)
		or string.find(string.lower(action), 'slash', 1, true)
	)
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
					if dist <= 18 and dot > 0.6 then
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
				if dist <= 160 and dot > 0.8 then
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
	installMeleeReachHook()
end

local function updateParryFromVisuals(char, meleeRange, gunRange)
	if not autoParryActive then
		return
	end

	local state = getEnemyState(char)
	local swingTrack = isEnemySwingingAtMe(char, meleeRange) and getActiveAttackTrack(char, SWING_ANIM_PATTERNS, 0.08, 0.38)
	local shotTrack = isEnemyShootingAtMe(char, gunRange) and getActiveAttackTrack(char, GUN_SHOT_PATTERNS, 0.05, 0.55)

	local swingId = swingTrack and swingTrack.Animation and swingTrack.Animation.AnimationId or ''
	local shotId = shotTrack and shotTrack.Animation and shotTrack.Animation.AnimationId or ''

	if swingTrack and swingId ~= state.lastSwingId then
		state.lastSwingId = swingId
		tryParry('visual_melee_swing')
	end
	if shotTrack and shotId ~= state.lastShotId then
		state.lastShotId = shotId
		tryParry('visual_gun_shot')
	end

	if not swingTrack then
		state.lastSwingId = ''
	end
	if not shotTrack then
		state.lastShotId = ''
	end

	state.swinging = swingTrack ~= nil
	state.shooting = shotTrack ~= nil
end

local function enemyThreatensMe(char, meleeRange, gunRange)
	return isEnemySwingingAtMe(char, meleeRange + 2) or isEnemyShootingAtMe(char, gunRange)
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

local function tryAutoAttack(attackCooldown)
	if not autoAttackActive or not entitylib.isAlive then
		return
	end
	if tick() < parryBlockAttackUntil then
		return
	end
	if tick() - lastParryAt < 0.22 then
		return
	end
	if tick() - lastAttackAt < attackCooldown then
		return
	end

	local swordReach = getMeleeReach()
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

local function combatHeartbeat(meleeRange, gunRange, attackCooldown)
	if not entitylib.isAlive then
		return
	end

	refreshPacketsReady()
	bindPacketListeners()

	if autoParryActive then
		for _, plr in playersService:GetPlayers() do
			if plr ~= lplr and plr.Character then
				updateParryFromVisuals(plr.Character, meleeRange, gunRange)
			end
		end
	end

	tryAutoAttack(attackCooldown)
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
	local Reach
	local MeleeRange
	local GunRange
	local ExtendReach
	local AttackCooldown
	local Debug
	local TestParry

	AutoParry = minigames:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			autoParryActive = callback
			if callback then
				refreshPacketsReady()
				bindPacketListeners()
				notif('Auto Parry', 'Active — parries on real swings/shots.', 4)
			end
		end,
		Tooltip = 'Fires parry packet + F key when enemies actually swing or shoot at you.',
	})

	AutoAttack = minigames:CreateModule({
		Name = 'Auto Attack',
		Function = function(callback)
			autoAttackActive = callback
			if callback then
				notif('Auto Attack', 'Active — LMB when enemies are in sword reach.', 4)
			end
		end,
		Tooltip = 'Left clicks when an enemy is within reach. Pauses while parrying.',
	})

	Reach = minigames:CreateModule({
		Name = 'Reach',
		Function = function(callback)
			reachActive = callback
			if callback then
				bindPacketListeners()
				notif('Reach', 'Extends sword melee packet range. Swing once manually first if needed.', 5)
			else
				reachExtend = 0
			end
		end,
		Tooltip = 'Hooks REDLINER melee packet to hit hurtboxes farther away (base ' .. BASE_SWORD_REACH .. ' studs).',
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

	ExtendReach = Reach:CreateSlider({
		Name = 'Extend',
		Min = 0,
		Max = 12,
		Default = 4,
		Function = function(val)
			reachExtend = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Added on top of base ' .. BASE_SWORD_REACH .. ' stud sword reach.',
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
			if callback then
				refreshPacketsReady()
				print('[REDLINER] debug on | packetsReady=', packetsReady, 'parryId=', Packets and Packets[PARRY_PACKET_NAME] and Packets[PARRY_PACKET_NAME].Id)
			end
		end,
	})

	TestParry = AutoParry:CreateToggle({
		Name = 'Test Parry',
		Function = function(callback)
			if callback then
				refreshPacketsReady()
				pressParryKey()
				task.defer(function()
					if TestParry.Enabled then
						TestParry:Toggle(true)
					end
				end)
			end
		end,
		Tooltip = 'Sends one parry (packet + F). Use to verify parry works.',
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
			if not AutoParry.Enabled and not AutoAttack.Enabled and not Reach.Enabled then
				return
			end
			combatHeartbeat(MeleeRange.Value, GunRange.Value, AttackCooldown.Value)
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
		notif('REDLINER', 'Minigames: Auto Parry, Auto Attack, Reach ready.', 5)
	end)
end)
