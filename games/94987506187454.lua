--[[
	REDLINER shared game script (MAIN + FFA + MATCH place IDs).
	Place IDs: 94987506187454 (main), 115875349872417 (FFA), 126691165749976 (match).
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

local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'

local MELEE_AIM_DOT = 0.38
local GUN_AIM_DOT = 0.58
local MELEE_SWING_MAX_TIME = 0.42

local IDLE_ANIM_PATTERNS = {
	'idle', 'walk', 'run', 'jump', 'fall', 'land', 'equip', 'crouch', 'sit', 'climb',
	'emote', 'dance', 'hurt', 'stun', 'death', 'respawn', 'block',
}
local MELEE_ANIM_PATTERNS = {
	'swing', 'slash', 'dark_slash', 'darkslash', 'wideslash', 'toolslash', 'swing_heavy',
	'inherit_hit', 'inherit_clash', 'melee_hit', 'clash', 'redliner',
}
local GUN_DRAW_PATTERNS = {
	'draw', 'aim', 'holster', 'reload', 'equip',
}
local GUN_SHOT_PATTERNS = {
	'shot', 'fire', 'castigate', 'phoenix', 'siege', 'monarch', 'bullet', 'shoot',
	'destroy_shot', 'awp_shot', 'destroyer', 'goldrose', 'afterburn', 'zealot', 'heavy',
}
local GLINT_NAME_PATTERNS = {
	'glint', 'flash', 'sparkle', 'shine', 'telegraph', 'warn',
}
local SLASH_VFX_PATTERNS = {
	'slash', 'swing', 'hitbox', 'attack', 'trail', 'blade', 'melee',
}

local Packets
local packetsReady = false
local autoParryActive = false
local autoAttackActive = false
local reachActive = false
local reachExtend = 0
local debugEnabled = false
local meleeRangeSetting = 12
local gunRangeSetting = 120
local myHurtboxes = {}
local enemyStates = {}
local charWatchers = {}
local watchersStarted = false
local meleeTemplate = nil
local meleeHooked = false
local lastParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local packetListenersBound = false
local unreliableListenersBound = false
local workspaceWatcherBound = false
local attackPressToken = 0
local lastDebugHeartbeat = 0
local tryParry

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

local function getMeleeReach()
	return BASE_SWORD_REACH + (reachActive and reachExtend or 0)
end

local function refreshMyHurtboxes()
	table.clear(myHurtboxes)
	local char = getLocalCharacter()
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

local function isLocalAlive()
	if entitylib.isAlive and entitylib.character.RootPart then
		return true
	end
	local char = lplr.Character
	local hum = char and char:FindFirstChildWhichIsA('Humanoid')
	return hum ~= nil and hum.Health > 0
end

local function getLocalRoot()
	if entitylib.isAlive and entitylib.character.RootPart then
		return entitylib.character.RootPart
	end
	local char = lplr.Character
	return char and char:FindFirstChild('HumanoidRootPart')
end

local function getLocalCharacter()
	if entitylib.isAlive and entitylib.character.Character then
		return entitylib.character.Character
	end
	return lplr.Character
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
			lastAnimParry = '',
			glintParried = false,
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

local function animNameMatches(name, patterns)
	local lower = string.lower(name or '')
	for _, pat in patterns do
		if string.find(lower, pat, 1, true) then
			return true
		end
	end
	return false
end

local function isIdleAnimation(name)
	local lower = string.lower(name or '')
	for _, pat in IDLE_ANIM_PATTERNS do
		if string.find(lower, pat, 1, true) then
			return true
		end
	end
	return false
end

local function getAimDot(char)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return 0
	end
	local offset = root.Position - enemyRoot.Position
	if offset.Magnitude < 0.05 then
		return 1
	end
	local dir = offset.Unit
	local best = enemyRoot.CFrame.LookVector:Dot(dir)
	local head = char:FindFirstChild('Head')
	if head then
		best = math.max(best, head.CFrame.LookVector:Dot(dir))
	end
	return best
end

local function isEnemyAimingAtMe(char, minDot)
	return getAimDot(char) >= minDot
end

local function classifyThreatAnimation(name)
	if isIdleAnimation(name) then
		return false, nil
	end
	local lower = string.lower(name or '')
	if string.find(lower, 'parry', 1, true) then
		return false, nil
	end
	if animNameMatches(lower, MELEE_ANIM_PATTERNS) then
		return true, 'melee'
	end
	if animNameMatches(lower, GUN_SHOT_PATTERNS) then
		return true, 'gun'
	end
	if animNameMatches(lower, GUN_DRAW_PATTERNS) then
		return true, 'draw'
	end
	if string.find(lower, 'dark', 1, true) and not string.find(lower, 'parry', 1, true) then
		return true, 'melee'
	end
	return false, nil
end

local function isGlintName(name)
	local lower = string.lower(name or '')
	for _, pat in GLINT_NAME_PATTERNS do
		if string.find(lower, pat, 1, true) then
			return true
		end
	end
	return false
end

local function getEnemyDistance(char)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return math.huge
	end
	return (enemyRoot.Position - root.Position).Magnitude
end

local function shouldParryMelee(char, maxRange)
	if getEnemyDistance(char) > maxRange then
		return false
	end
	return isEnemyAimingAtMe(char, MELEE_AIM_DOT)
end

local function shouldParryGun(char, maxRange)
	if getEnemyDistance(char) > maxRange then
		return false
	end
	return isEnemyAimingAtMe(char, GUN_AIM_DOT)
end

local function getPlayerFromModel(model)
	if not model then
		return nil
	end
	local plr = playersService:GetPlayerFromCharacter(model)
	if plr then
		return plr
	end
	for _, p in playersService:GetPlayers() do
		if p ~= lplr and p.Character and model:IsDescendantOf(p.Character) then
			return p
		end
		if p ~= lplr and p.Character and model == p.Character then
			return p
		end
	end
	return nil
end

local function getEnemyModels(plr)
	local models = {}
	if plr.Character then
		table.insert(models, plr.Character)
	end
	local chronoStorage = workspace:FindFirstChild('Chrono_EntityStorage')
	if chronoStorage then
		for _, child in chronoStorage:GetChildren() do
			if child:IsA('Model') then
				local owner = getPlayerFromModel(child)
				if owner == plr then
					table.insert(models, child)
				end
			end
		end
	end
	return models
end

local function onEnemyThreat(char, reason)
	if not autoParryActive or not isLocalAlive() then
		return
	end
	debugLog('threat', reason, char.Name, 'aimDot=', string.format('%.2f', getAimDot(char)))
	tryParry(reason)
end

local function evaluateMeleeTrack(char, track, source)
	if not track.IsPlaying or track.WeightCurrent < 0.12 then
		return
	end
	local animName = track.Animation and track.Animation.Name or 'unknown'
	local isThreat, kind = classifyThreatAnimation(animName)
	if not isThreat or kind ~= 'melee' then
		if getEnemyDistance(char) <= 8 and track.WeightCurrent >= 0.4
			and track.TimePosition <= MELEE_SWING_MAX_TIME and not isIdleAnimation(animName) then
			isThreat = true
			kind = 'melee'
		else
			return
		end
	end
	if track.TimePosition > MELEE_SWING_MAX_TIME then
		return
	end
	if not shouldParryMelee(char, meleeRangeSetting) then
		debugLog('melee skip aim', char.Name, animName, string.format('%.2f', getAimDot(char)))
		return
	end
	local state = getEnemyState(char)
	local key = (track.Animation and track.Animation.AnimationId or animName) .. ':' .. source
	if key == state.lastSwingId then
		return
	end
	state.lastSwingId = key
	task.delay(0.45, function()
		if state.lastSwingId == key then
			state.lastSwingId = ''
		end
	end)
	onEnemyThreat(char, source .. '_melee_' .. animName)
end

local function evaluateGunTrack(char, track, source)
	if not track.IsPlaying or track.WeightCurrent < 0.12 then
		return
	end
	local animName = track.Animation and track.Animation.Name or 'unknown'
	local isThreat, kind = classifyThreatAnimation(animName)
	if not isThreat or (kind ~= 'gun' and kind ~= 'draw') then
		return
	end
	if kind == 'draw' then
		if not shouldParryGun(char, gunRangeSetting) then
			return
		end
		local state = getEnemyState(char)
		if state.glintParried then
			return
		end
		state.glintParried = true
		onEnemyThreat(char, source .. '_draw_' .. animName)
		return
	end
	if track.TimePosition > 0.55 then
		return
	end
	if not shouldParryGun(char, gunRangeSetting) then
		debugLog('gun skip aim', char.Name, animName, string.format('%.2f', getAimDot(char)))
		return
	end
	local state = getEnemyState(char)
	local key = (track.Animation and track.Animation.AnimationId or animName) .. ':' .. source
	if key == state.lastShotId then
		return
	end
	state.lastShotId = key
	task.delay(0.6, function()
		if state.lastShotId == key then
			state.lastShotId = ''
		end
	end)
	onEnemyThreat(char, source .. '_gun_' .. animName)
end

local function getAllPlayingTracks(char)
	local tracks = {}
	local hum = char:FindFirstChildWhichIsA('Humanoid')
	if hum then
		for _, track in hum:GetPlayingAnimationTracks() do
			table.insert(tracks, track)
		end
	end
	for _, desc in char:GetDescendants() do
		if desc:IsA('Animator') then
			for _, track in desc:GetPlayingAnimationTracks() do
				table.insert(tracks, track)
			end
		end
	end
	return tracks
end

local function onEnemyAnimationPlayed(char, track)
	if not autoParryActive or not isLocalAlive() then
		return
	end
	local animName = track.Animation and track.Animation.Name or 'unknown'
	local _, kind = classifyThreatAnimation(animName)
	debugLog('anim played', char.Name, animName, kind or 'none', 't=', string.format('%.2f', track.TimePosition), 'aim=', string.format('%.2f', getAimDot(char)))
	if kind == 'gun' or kind == 'draw' then
		evaluateGunTrack(char, track, 'anim')
	else
		evaluateMeleeTrack(char, track, 'anim')
	end
end

local function onEnemyGlintSpawned(char, inst)
	if not autoParryActive or not isLocalAlive() then
		return
	end
	if not shouldParryGun(char, gunRangeSetting) then
		debugLog('glint skip aim', char.Name, inst.Name, string.format('%.2f', getAimDot(char)))
		return
	end
	local state = getEnemyState(char)
	if state.glintParried then
		return
	end
	state.glintParried = true
	onEnemyThreat(char, 'glint_' .. inst.Name)
end

local function unwatchCharacter(char)
	local conns = charWatchers[char]
	if conns then
		for _, conn in conns do
			conn:Disconnect()
		end
	end
	charWatchers[char] = nil
	enemyStates[char] = nil
end

local function hookModelAnimations(model, ownerChar)
	for _, desc in model:GetDescendants() do
		if desc:IsA('Animator') then
			desc.AnimationPlayed:Connect(function(track)
				onEnemyAnimationPlayed(ownerChar, track)
			end)
		end
	end
	model.DescendantAdded:Connect(function(inst)
		if inst:IsA('Animator') then
			inst.AnimationPlayed:Connect(function(track)
				onEnemyAnimationPlayed(ownerChar, track)
			end)
		end
		if isGlintName(inst.Name) then
			onEnemyGlintSpawned(ownerChar, inst)
		end
		local lower = string.lower(inst.Name)
		for _, pat in SLASH_VFX_PATTERNS do
			if string.find(lower, pat, 1, true) then
				if shouldParryMelee(ownerChar, meleeRangeSetting + 2) then
					onEnemyThreat(ownerChar, 'vfx_' .. inst.Name)
				end
				break
			end
		end
	end)
end

local function watchEnemyCharacter(char, ownerPlr)
	if not char or char == getLocalCharacter() or charWatchers[char] then
		return
	end
	local plr = ownerPlr or playersService:GetPlayerFromCharacter(char)
	if not plr or plr == lplr then
		if not isEnemyCharacter(char) then
			return
		end
		plr = playersService:GetPlayerFromCharacter(char)
	end

	local conns = {}
	charWatchers[char] = conns
	local ownerChar = (plr and plr.Character) or char

	table.insert(conns, char.DescendantAdded:Connect(function(inst)
		if isGlintName(inst.Name) then
			onEnemyGlintSpawned(char, inst)
		end
	end))

	for _, inst in char:GetDescendants() do
		if isGlintName(inst.Name) then
			onEnemyGlintSpawned(char, inst)
		end
	end

	task.spawn(function()
		local hum = char:WaitForChild('Humanoid', 10)
		if not hum or not char.Parent or not charWatchers[char] then
			return
		end
		local animator = hum:FindFirstChildOfClass('Animator')
		if animator then
			table.insert(conns, animator.AnimationPlayed:Connect(function(track)
				onEnemyAnimationPlayed(ownerChar, track)
			end))
		end
		hookModelAnimations(char, ownerChar)
		if plr then
			for _, extraModel in getEnemyModels(plr) do
				if extraModel ~= char then
					hookModelAnimations(extraModel, ownerChar)
				end
			end
		end
		debugLog('watching', char.Name, animator and 'animator' or 'no animator')
	end)
end

local function watchEnemyPlayer(plr)
	if plr == lplr then
		return
	end
	if plr.Character then
		watchEnemyCharacter(plr.Character)
	end
	for _, model in getEnemyModels(plr) do
		if model ~= plr.Character then
			watchEnemyCharacter(model, plr)
		end
	end
end

local function startEnemyWatchers()
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			watchEnemyPlayer(plr)
		end
	end
	if watchersStarted then
		return
	end
	watchersStarted = true

	playersService.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function()
			task.defer(function()
				watchEnemyPlayer(plr)
			end)
		end)
		task.defer(function()
			watchEnemyPlayer(plr)
		end)
	end)

	playersService.PlayerRemoving:Connect(function(plr)
		if plr.Character then
			unwatchCharacter(plr.Character)
		end
		for _, model in getEnemyModels(plr) do
			unwatchCharacter(model)
		end
	end)

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			plr.CharacterAdded:Connect(function()
				task.defer(function()
					watchEnemyPlayer(plr)
				end)
			end)
		end
	end
end

local function pressParryKey()
	parryBlockAttackUntil = tick() + 0.2

	task.spawn(function()
		withThread(function()
			pcall(function()
				virtualInputManager:SendKeyEvent(true, PARRY_KEY, false, game)
			end)
			if keypress then
				pcall(keypress, PARRY_VK)
			end
			task.wait(0.08)
			pcall(function()
				virtualInputManager:SendKeyEvent(false, PARRY_KEY, false, game)
			end)
			if keyrelease then
				pcall(keyrelease, PARRY_VK)
			end
		end)
	end)

	debugLog('parry key pressed')
	return true
end

tryParry = function(reason)
	if not autoParryActive or not isLocalAlive() then
		return false
	end
	if tick() - lastParryAt < 0.08 then
		return false
	end

	lastParryAt = tick()
	parryBlockAttackUntil = tick() + 0.2
	debugLog('parry trigger', reason)

	task.defer(pressParryKey)
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

local function onGunPacket(itemId, _, _, _, _, direction)
	if not autoParryActive or typeof(direction) ~= 'Vector3' then
		return
	end
	local root = getLocalRoot()
	if not root or direction.Magnitude < 0.05 then
		return
	end
	local dir = direction.Unit
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local char = plr.Character
			if not shouldParryGun(char, gunRangeSetting) then
				continue
			end
			local enemyRoot = char:FindFirstChild('HumanoidRootPart')
			local head = char:FindFirstChild('Head')
			local from = head and head.Position or (enemyRoot and enemyRoot.Position)
			if from then
				local toUs = root.Position - from
				local dist = toUs.Magnitude
				if dist > 0.1 and dist <= gunRangeSetting and dir:Dot(toUs.Unit) > 0.78 then
					tryParry('packet_gun_' .. tostring(itemId))
					return
				end
			end
		end
	end
end

local function directionAimsAtLocal(origin, direction, maxDist, minDot)
	local root = getLocalRoot()
	if not root or typeof(direction) ~= 'Vector3' or direction.Magnitude < 0.05 then
		return false
	end
	if typeof(origin) == 'Vector3' then
		local toUs = root.Position - origin
		local dist = toUs.Magnitude
		return dist > 0.1 and dist <= maxDist and direction.Unit:Dot(toUs.Unit) >= minDot
	end
	return false
end

local function onUnreliablePacket(packetName, ...)
	if not autoParryActive then
		return
	end
	local packed = table.pack(...)
	for i = 1, packed.n do
		local arg = packed[i]
		if typeof(arg) == 'Vector3' then
			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character then
					local char = plr.Character
					if not shouldParryGun(char, gunRangeSetting) then
						continue
					end
					local enemyRoot = char:FindFirstChild('HumanoidRootPart')
					if enemyRoot and directionAimsAtLocal(enemyRoot.Position, arg, gunRangeSetting, 0.72) then
						tryParry('vfx_packet_' .. packetName)
						return
					end
				end
			end
		end
	end
end

local function bindWorkspaceAttackWatcher()
	if workspaceWatcherBound then
		return
	end
	workspaceWatcherBound = true
	workspace.DescendantAdded:Connect(function(inst)
		if not autoParryActive or not isLocalAlive() then
			return
		end
		if not inst:IsA('BasePart') then
			return
		end
		local root = getLocalRoot()
		if not root then
			return
		end
		if (inst.Position - root.Position).Magnitude > meleeRangeSetting + 4 then
			return
		end
		if inst.Material == Enum.Material.ForceField and inst.Color == Color3.fromRGB(255, 0, 0) then
			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character and shouldParryMelee(plr.Character, meleeRangeSetting + 2) then
					tryParry('hitbox_part')
					return
				end
			end
		end
	end)
end

local function bindPacketListeners()
	if not initPackets() then
		return
	end
	installMeleeReachHook()
	if packetListenersBound then
		return
	end
	local gunPacket = Packets[GUN_PACKET_NAME]
	if gunPacket and gunPacket.OnClientEvent then
		packetListenersBound = true
		gunPacket.OnClientEvent:Connect(onGunPacket)
	end
	if not unreliableListenersBound and Packets.unreliablePackets then
		unreliableListenersBound = true
		for name, packet in Packets.unreliablePackets do
			if packet.OnClientEvent then
				packet.OnClientEvent:Connect(function(...)
					onUnreliablePacket(name, ...)
				end)
			end
		end
	end
end

local function scanHeartbeatParry(meleeRange, gunRange)
	meleeRangeSetting = meleeRange
	gunRangeSetting = gunRange

	for _, plr in playersService:GetPlayers() do
		if plr == lplr or not plr.Character then
			continue
		end
		local char = plr.Character
		for _, track in getAllPlayingTracks(char) do
			local animName = track.Animation and track.Animation.Name or ''
			local _, kind = classifyThreatAnimation(animName)
			if kind == 'gun' or kind == 'draw' then
				evaluateGunTrack(char, track, 'scan')
			else
				evaluateMeleeTrack(char, track, 'scan')
			end
		end

		for _, model in getEnemyModels(plr) do
			if model ~= char then
				for _, track in getAllPlayingTracks(model) do
					local animName = track.Animation and track.Animation.Name or ''
					local _, kind = classifyThreatAnimation(animName)
					if kind == 'gun' or kind == 'draw' then
						evaluateGunTrack(char, track, 'scan_extra')
					else
						evaluateMeleeTrack(char, track, 'scan_extra')
					end
				end
			end
		end

		local state = getEnemyState(char)
		local hasGlint = false
		for _, inst in char:GetDescendants() do
			if isGlintName(inst.Name) then
				hasGlint = true
				if not state.glintParried and shouldParryGun(char, gunRange) then
					state.glintParried = true
					onEnemyThreat(char, 'scan_glint_' .. inst.Name)
				end
				break
			end
		end
		if not hasGlint then
			state.glintParried = false
		end
	end
end

local function enemyThreatensMe(char, meleeRange, gunRange)
	if shouldParryMelee(char, meleeRange + 2) then
		for _, track in getAllPlayingTracks(char) do
			if track.IsPlaying and track.WeightCurrent >= 0.1 then
				local animName = track.Animation and track.Animation.Name or ''
				local isThreat, kind = classifyThreatAnimation(animName)
				if isThreat and kind == 'melee' then
					return true
				end
			end
		end
	end
	if shouldParryGun(char, gunRange) then
		for _, inst in char:GetDescendants() do
			if isGlintName(inst.Name) then
				return true
			end
		end
		for _, track in getAllPlayingTracks(char) do
			if track.IsPlaying then
				local _, kind = classifyThreatAnimation(track.Animation and track.Animation.Name or '')
				if kind == 'gun' or kind == 'draw' then
					return true
				end
			end
		end
	end
	return false
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
	if not autoAttackActive or not isLocalAlive() then
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
	if not isLocalAlive() then
		return
	end

	bindPacketListeners()

	if autoParryActive then
		startEnemyWatchers()
		bindWorkspaceAttackWatcher()
		scanHeartbeatParry(meleeRange, gunRange)

		if debugEnabled and tick() - lastDebugHeartbeat > 2 then
			lastDebugHeartbeat = tick()
			local enemyCount = 0
			local watchedCount = 0
			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character then
					enemyCount += 1
					if charWatchers[plr.Character] then
						watchedCount += 1
					end
				end
			end
			print('[REDLINER] heartbeat | alive=', isLocalAlive(), 'enemies=', enemyCount, 'watched=', watchedCount, 'autoParry=', autoParryActive)
			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character then
					local char = plr.Character
					local dist = getEnemyDistance(char)
					if dist <= 25 then
						for _, track in getAllPlayingTracks(char) do
							if track.IsPlaying and track.WeightCurrent > 0.05 then
								local animName = track.Animation and track.Animation.Name or '?'
								local _, kind = classifyThreatAnimation(animName)
								print('[REDLINER] nearby anim', plr.Name, string.format('%.1f', dist), animName, kind or '-', 'aim', string.format('%.2f', getAimDot(char)), track.WeightCurrent)
							end
						end
					end
				end
			end
		end
	end

	tryAutoAttack(attackCooldown)
end

local function cleanupEnemyState(model)
	unwatchCharacter(model)
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
				startEnemyWatchers()
				bindPacketListeners()
				notif('Auto Parry', 'Watching enemy animations + glint spawns.', 4)
				if debugEnabled then
					print('[REDLINER] auto parry enabled | watchers started')
				end
			end
		end,
		Tooltip = 'Presses F when enemies aim melee/gun attacks at you. Guns require facing you.',
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
				print('[REDLINER] debug on | alive=', isLocalAlive(), 'autoParry=', autoParryActive)
			end
		end,
	})

	TestParry = AutoParry:CreateToggle({
		Name = 'Test Parry',
		Function = function(callback)
			if callback then
				task.defer(pressParryKey)
				task.defer(function()
					if TestParry.Enabled then
						TestParry:Toggle(true)
					end
				end)
			end
		end,
		Tooltip = 'Sends one F key press. Use to verify parry works.',
	})

	local combatBound = false
	local function bindCombatLoop()
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
	end

	task.defer(bindCombatLoop)
	task.defer(function()
		local start = tick()
		repeat
			task.wait(0.25)
		until vape.Loaded or tick() - start > 8
		bindCombatLoop()
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
