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

local BASE_SWORD_REACH = 10

local PARRY_KEY = Enum.KeyCode.F
local PARRY_VK = 0x46

local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local GUN_VFX_PACKET = '_x47fd55153a58f398'

local MELEE_AIM_DOT = 0.32
local GUN_AIM_DOT = 0.32
local CLOSE_RANGE_STUDS = 3
local MELEE_SWING_MIN_TIME = 0
local MELEE_SWING_MAX_TIME = 0.55
local MELEE_PARRY_DELAY = 0.2
local GUN_SHOT_MAX_TIME = 0.15
local GUN_DRAW_EARLY = 0.1

local KNOWN_MELEE_ANIM_IDS = {
	['105441036119013'] = true,
}
local KNOWN_GUN_SHOT_ANIM_IDS = {
	['110389010823335'] = true,
}

local MELEE_NAME_PATTERNS = {
	'swing', 'slash', 'dark_slash', 'darkslash', 'wideslash', 'toolslash', 'swing_heavy',
	'inherit_hit', 'inherit_clash', 'melee_hit', 'clash', 'redliner', 'hit2',
}
local GUN_DRAW_NAME_PATTERNS = {
	'draw', 'aim', 'holster', 'reload',
}
local GUN_SHOT_NAME_PATTERNS = {
	'shot', 'fire', 'castigate', 'phoenix', 'siege', 'monarch', 'bullet', 'shoot',
	'destroy_shot', 'awp_shot', 'destroyer', 'goldrose', 'afterburn', 'zealot',
}
local DENY_ANIM_EXACT = {
	animation = true,
	idle = true,
	walk = true,
	run = true,
	jump = true,
	fall = true,
	land = true,
	sit = true,
	climb = true,
	toolnone = true,
	toollunge = true,
	wave = true,
	point = true,
	dance = true,
	emote = true,
	equip = true,
}
local GLINT_NAME_PATTERNS = {
	'glint', 'flash', 'sparkle', 'shine', 'telegraph', 'warn',
}
local GUN_SHOT_SOUND_PATTERNS = {
	'destroy_shot', 'awp_shot', 'shot', 'fire', 'castigate', 'phoenix', 'siege', 'monarch',
}
local MELEE_SWING_SOUND_PATTERNS = {
	'dark_slash', 'swing_heavy', 'swing', 'toolslash', 'slash', 'wideslash', 'hit2', 'inherit_hit',
}
local GUN_DRAW_TIMES = {
	Castigate = 0.55,
	Phoenix = 0.60,
	Siege = 0.90,
	Monarch = 1.65,
}
local GUN_ITEM_PATTERNS = {
	{pattern = 'castigate', gun = 'Castigate'},
	{pattern = 'destroyer', gun = 'Castigate'},
	{pattern = 'goldrose', gun = 'Castigate'},
	{pattern = 'phoenix', gun = 'Phoenix'},
	{pattern = 'siege', gun = 'Siege'},
	{pattern = 'afterburn', gun = 'Siege'},
	{pattern = 'monarch', gun = 'Monarch'},
	{pattern = 'awp', gun = 'Monarch'},
}

local Packets
local autoParryActive = false
local autoAttackActive = false
local reachActive = false
local reachExtend = 0
local debugEnabled = false
local meleeRangeSetting = 20
local myHurtboxes = {}
local enemyStates = {}
local charWatchers = {}
local watchersStarted = false
local animCatalogBuilt = false
local animCatalog = {
	meleeNames = {},
	gunDrawNames = {},
	gunShotNames = {},
	meleeIds = {},
	gunDrawIds = {},
	gunShotIds = {},
}
local meleeTemplate = nil
local meleeHooked = false
local lastParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local packetListenersBound = false
local attackPressToken = 0
local lastDebugHeartbeat = 0
local lastDebugSkipAt = {}
local parryScanBound = false
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

local function debugSkip(...)
	if debugEnabled then
		local key = table.concat({...}, '|')
		local now = tick()
		if now - (lastDebugSkipAt[key] or 0) < 0.2 then
			return
		end
		lastDebugSkipAt[key] = now
		print('[REDLINER] skip:', ...)
	end
end

-- ---------------------------------------------------------------------------
-- Packets / reach
-- ---------------------------------------------------------------------------

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

-- ---------------------------------------------------------------------------
-- Character helpers
-- ---------------------------------------------------------------------------

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

local function getEnemyDistance(char)
	local root = getLocalRoot()
	local enemyRoot = char and char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return math.huge
	end
	return (enemyRoot.Position - root.Position).Magnitude
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
		if p ~= lplr and p.Character and (model:IsDescendantOf(p.Character) or model == p.Character) then
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
			if child:IsA('Model') and getPlayerFromModel(child) == plr then
				table.insert(models, child)
			end
		end
	end
	return models
end

local function getEnemyState(char)
	if not enemyStates[char] then
		enemyStates[char] = {
			lastSwingId = '',
			lastShotId = '',
			glintToken = 0,
			scheduledDrawToken = 0,
			scheduledMeleeToken = 0,
		}
	end
	return enemyStates[char]
end

-- ---------------------------------------------------------------------------
-- Animation catalog (whitelist-only)
-- ---------------------------------------------------------------------------

local function nameMatchesPatterns(name, patterns)
	local lower = string.lower(name or '')
	for _, pat in patterns do
		if string.find(lower, pat, 1, true) then
			return true
		end
	end
	return false
end

local function normalizeAnimId(animId)
	if typeof(animId) ~= 'string' or animId == '' then
		return ''
	end
	local numeric = string.match(animId, '(%d+)')
	return numeric or string.lower(animId)
end

local function isDeniedAnimName(name)
	local lower = string.lower(name or '')
	return DENY_ANIM_EXACT[lower] == true
end

local function addCatalogEntry(nameSet, idSet, name, animId)
	if not name or name == '' then
		return
	end
	local lower = string.lower(name)
	nameSet[lower] = true
	local normId = normalizeAnimId(animId)
	if normId ~= '' then
		idSet[normId] = true
		if animId and animId ~= '' then
			idSet[animId] = true
			idSet[string.lower(animId)] = true
		end
	end
end

local function scanAnimationsIn(root)
	if not root then
		return
	end
	for _, inst in root:GetDescendants() do
		if inst:IsA('Animation') then
			local name = inst.Name
			if isDeniedAnimName(name) then
				continue
			end
			if nameMatchesPatterns(name, MELEE_NAME_PATTERNS) or string.find(string.lower(name), 'dark', 1, true) then
				addCatalogEntry(animCatalog.meleeNames, animCatalog.meleeIds, name, inst.AnimationId)
			elseif nameMatchesPatterns(name, GUN_SHOT_NAME_PATTERNS) then
				addCatalogEntry(animCatalog.gunShotNames, animCatalog.gunShotIds, name, inst.AnimationId)
			elseif nameMatchesPatterns(name, GUN_DRAW_NAME_PATTERNS) then
				addCatalogEntry(animCatalog.gunDrawNames, animCatalog.gunDrawIds, name, inst.AnimationId)
			end
		end
	end
end

local function buildAnimCatalog(force)
	if animCatalogBuilt and not force then
		local idCount = 0
		for _ in animCatalog.meleeIds do
			idCount += 1
		end
		if idCount > 0 then
			return
		end
	end
	animCatalogBuilt = true
	table.clear(animCatalog.meleeNames)
	table.clear(animCatalog.gunDrawNames)
	table.clear(animCatalog.gunShotNames)
	table.clear(animCatalog.meleeIds)
	table.clear(animCatalog.gunDrawIds)
	table.clear(animCatalog.gunShotIds)

	local assets = replicatedStorage:FindFirstChild('Assets')
	if assets then
		scanAnimationsIn(assets:FindFirstChild('Animations'))
		scanAnimationsIn(assets:FindFirstChild('Rigs3P'))
		scanAnimationsIn(assets)
	end

	for _, pat in MELEE_NAME_PATTERNS do
		animCatalog.meleeNames[pat] = true
	end
	for _, pat in GUN_DRAW_NAME_PATTERNS do
		animCatalog.gunDrawNames[pat] = true
	end
	for _, pat in GUN_SHOT_NAME_PATTERNS do
		animCatalog.gunShotNames[pat] = true
	end
	for id, _ in KNOWN_MELEE_ANIM_IDS do
		animCatalog.meleeIds[id] = true
	end
	for id, _ in KNOWN_GUN_SHOT_ANIM_IDS do
		animCatalog.gunShotIds[id] = true
	end

	local meleeCount, drawCount, shotCount, idCount = 0, 0, 0, 0
	for _ in animCatalog.meleeNames do meleeCount += 1 end
	for _ in animCatalog.gunDrawNames do drawCount += 1 end
	for _ in animCatalog.gunShotNames do shotCount += 1 end
	for _ in animCatalog.meleeIds do idCount += 1 end
	print('[REDLINER] anim catalog | melee=', meleeCount, 'draw=', drawCount, 'shot=', shotCount, 'ids=', idCount)
end

local function catalogHasId(idSet, animId)
	local normId = normalizeAnimId(animId)
	if normId ~= '' and idSet[normId] then
		return true
	end
	if animId ~= '' and idSet[animId] then
		return true
	end
	return false
end

local function getTrackAnimInfo(track)
	local anim = track and track.Animation
	if not anim then
		return '', ''
	end
	return anim.Name or '', anim.AnimationId or ''
end

local function isKnownMeleeId(animId)
	return KNOWN_MELEE_ANIM_IDS[normalizeAnimId(animId)] == true
end

local function isKnownGunShotId(animId)
	return KNOWN_GUN_SHOT_ANIM_IDS[normalizeAnimId(animId)] == true
end

local function getAnimKind(name, animId)
	local normId = normalizeAnimId(animId)
	if isKnownMeleeId(animId) or catalogHasId(animCatalog.meleeIds, animId) then
		return 'melee'
	end
	if isKnownGunShotId(animId) or catalogHasId(animCatalog.gunShotIds, animId) then
		return 'gun_shot'
	end
	if catalogHasId(animCatalog.gunDrawIds, animId) then
		return 'gun_draw'
	end
	if isDeniedAnimName(name) then
		return nil
	end
	local lower = string.lower(name or '')
	if string.find(lower, 'parry', 1, true) then
		return nil
	end
	if animCatalog.meleeNames[lower] then
		return 'melee'
	end
	if animCatalog.gunShotNames[lower] then
		return 'gun_shot'
	end
	if animCatalog.gunDrawNames[lower] then
		return 'gun_draw'
	end
	if nameMatchesPatterns(name, MELEE_NAME_PATTERNS) or string.find(lower, 'dark', 1, true) or string.find(lower, 'wideslash', 1, true) then
		return 'melee'
	end
	if nameMatchesPatterns(name, GUN_SHOT_NAME_PATTERNS) then
		return 'gun_shot'
	end
	if nameMatchesPatterns(name, GUN_DRAW_NAME_PATTERNS) then
		return 'gun_draw'
	end
	return nil
end

local function isMeleePriority(track, kind)
	if kind ~= 'melee' then
		return track.Priority.Value >= Enum.AnimationPriority.Action.Value
	end
	return track.Priority.Value >= Enum.AnimationPriority.Core.Value
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

local function charHasWhitelistAttackPlaying(char)
	for _, track in getAllPlayingTracks(char) do
		if track.IsPlaying and track.WeightCurrent >= 0.1 then
			local name, animId = getTrackAnimInfo(track)
			local kind = getAnimKind(name, animId)
			if kind and isMeleePriority(track, kind) then
				return true
			end
		end
	end
	return false
end

-- ---------------------------------------------------------------------------
-- Aim checks
-- ---------------------------------------------------------------------------

local function getAimDot(char)
	local root = getLocalRoot()
	local enemyRoot = char:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return 0
	end
	local offset = root.Position - enemyRoot.Position
	local flatOffset = Vector3.new(offset.X, 0, offset.Z)
	if flatOffset.Magnitude < 0.05 then
		return 1
	end
	local dir = flatOffset.Unit
	local best = 0
	local flatLook = Vector3.new(enemyRoot.CFrame.LookVector.X, 0, enemyRoot.CFrame.LookVector.Z)
	if flatLook.Magnitude > 0.05 then
		best = flatLook.Unit:Dot(dir)
	end
	local head = char:FindFirstChild('Head')
	if head then
		local flatHead = Vector3.new(head.CFrame.LookVector.X, 0, head.CFrame.LookVector.Z)
		if flatHead.Magnitude > 0.05 then
			best = math.max(best, flatHead.Unit:Dot(dir))
		end
	end
	return best
end

local function isEnemyTargetingMe(char, minDot, confirmedAttack)
	local dist = getEnemyDistance(char)
	if not confirmedAttack and dist < CLOSE_RANGE_STUDS and not charHasWhitelistAttackPlaying(char) then
		debugSkip('close_range_no_attack', char.Name, string.format('%.1f', dist))
		return false
	end
	return getAimDot(char) >= minDot
end

local function shouldParryMelee(char, confirmedAttack)
	if getEnemyDistance(char) > meleeRangeSetting then
		return false
	end
	if not isEnemyTargetingMe(char, MELEE_AIM_DOT, confirmedAttack) then
		return false
	end
	return true
end

local function shouldParryGun(char, confirmedAttack)
	return isEnemyTargetingMe(char, GUN_AIM_DOT, confirmedAttack)
end

-- ---------------------------------------------------------------------------
-- Gun helpers
-- ---------------------------------------------------------------------------

local function isGlintName(name)
	return nameMatchesPatterns(name, GLINT_NAME_PATTERNS)
end

local function detectEquippedGun(char)
	local bestGun, bestScore = 'Castigate', 0
	for _, desc in char:GetDescendants() do
		local lower = string.lower(desc.Name)
		for _, entry in GUN_ITEM_PATTERNS do
			if string.find(lower, entry.pattern, 1, true) then
				local score = entry.pattern == 'castigate' and 1 or 2
				if score > bestScore then
					bestScore = score
					bestGun = entry.gun
				end
			end
		end
	end
	return bestGun
end

local function isShotSoundName(name)
	return nameMatchesPatterns(name, GUN_SHOT_SOUND_PATTERNS)
end

local function isMeleeSwingSoundName(name)
	return nameMatchesPatterns(name, MELEE_SWING_SOUND_PATTERNS)
end

local function scheduleDrawParry(char, gunName)
	local state = getEnemyState(char)
	state.scheduledDrawToken += 1
	local token = state.scheduledDrawToken
	local delay = math.max(0.05, (GUN_DRAW_TIMES[gunName] or GUN_DRAW_TIMES.Castigate) - GUN_DRAW_EARLY)

	task.delay(delay, function()
		if not autoParryActive or token ~= state.scheduledDrawToken then
			return
		end
		if not char.Parent or not isLocalAlive() then
			return
		end
		if not shouldParryGun(char, true) then
			debugSkip('timed_draw_aim_lost', char.Name, gunName)
			return
		end
		debugLog('trigger', 'gun_timed_' .. gunName, string.format('%.2f', getAimDot(char)))
		tryParry('gun_timed_' .. gunName)
	end)
end

-- ---------------------------------------------------------------------------
-- Parry input
-- ---------------------------------------------------------------------------

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
	if tick() - lastParryAt < 0.05 then
		return false
	end
	lastParryAt = tick()
	parryBlockAttackUntil = tick() + 0.2
	debugLog('parry trigger', reason)
	pressParryKey()
	return true
end

local function scheduleMeleeParry(char, animId, track, source)
	local state = getEnemyState(char)
	local normId = normalizeAnimId(animId)
	local swingKey = normId .. ':melee:swing'
	if state.lastSwingId == swingKey then
		return
	end
	state.lastSwingId = swingKey
	state.scheduledMeleeToken = (state.scheduledMeleeToken or 0) + 1
	local token = state.scheduledMeleeToken

	track.Stopped:Once(function()
		if state.lastSwingId == swingKey then
			state.lastSwingId = ''
		end
	end)

	local delay = math.max(0, MELEE_PARRY_DELAY - track.TimePosition)
	debugLog('trigger', 'melee_schedule_' .. normId, 'delay=' .. string.format('%.2f', delay), 'aim=' .. string.format('%.2f', getAimDot(char)), source)

	task.delay(delay, function()
		if not autoParryActive or token ~= state.scheduledMeleeToken then
			return
		end
		if not char.Parent or not isLocalAlive() then
			return
		end
		if not shouldParryMelee(char, true) then
			debugSkip('melee_timed_aim', normId, string.format('%.2f', getAimDot(char)))
			return
		end
		tryParry('melee_' .. normId)
	end)
end

-- ---------------------------------------------------------------------------
-- Threat handlers (edge-triggered only)
-- ---------------------------------------------------------------------------

local function handleMeleeAnimation(char, track, source)
	source = source or 'edge'
	if not track.IsPlaying or track.WeightCurrent < 0.05 then
		debugSkip('melee_low_weight', getTrackAnimInfo(track), source)
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local kind = getAnimKind(name, animId)
	local knownMelee = isKnownMeleeId(animId)
	if kind ~= 'melee' and not knownMelee then
		debugSkip('not_whitelisted', name, normId, source)
		return
	end
	if not knownMelee and not isMeleePriority(track, kind) then
		debugSkip('wrong_priority', name, track.Priority, source)
		return
	end
	if track.TimePosition > MELEE_SWING_MAX_TIME then
		debugSkip('melee_late_window', name, string.format('%.2f', track.TimePosition), source)
		return
	end
	if not shouldParryMelee(char, true) then
		debugSkip('melee_aim', name, string.format('%.2f', getAimDot(char)), source)
		return
	end

	if track.TimePosition <= 0.35 then
		scheduleMeleeParry(char, animId, track, source)
	else
		local state = getEnemyState(char)
		local swingKey = normId .. ':melee:swing'
		if state.lastSwingId == swingKey then
			return
		end
		state.lastSwingId = swingKey
		debugLog('trigger', 'melee_immediate_' .. normId, 'aim=' .. string.format('%.2f', getAimDot(char)), source)
		tryParry('melee_immediate_' .. normId)
	end
end

local function handleGunAnimation(char, track, source)
	source = source or 'edge'
	if not track.IsPlaying or track.WeightCurrent < 0.05 then
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local kind = getAnimKind(name, animId)
	if kind ~= 'gun_shot' and kind ~= 'gun_draw' then
		debugSkip('gun_not_whitelisted', name, normId, source)
		return
	end
	if not shouldParryGun(char, true) then
		debugSkip('gun_aim', name, string.format('%.2f', getAimDot(char)), source)
		return
	end

	if kind == 'gun_draw' then
		local gunName = detectEquippedGun(char)
		debugLog('trigger', 'gun_draw_' .. name, gunName, source)
		scheduleDrawParry(char, gunName)
		return
	end

	if track.TimePosition > GUN_SHOT_MAX_TIME then
		debugSkip('gun_shot_late', name, string.format('%.2f', track.TimePosition), source)
		return
	end

	local state = getEnemyState(char)
	local key = normId .. ':gun:swing'
	if state.lastShotId == key then
		return
	end
	state.lastShotId = key
	track.Stopped:Once(function()
		if state.lastShotId == key then
			state.lastShotId = ''
		end
	end)

	debugLog('trigger', 'gun_shot_' .. name, 'id=' .. normId, 'aim=' .. string.format('%.2f', getAimDot(char)), source)
	tryParry('gun_shot_' .. normId)
end

local function onEnemyAnimationPlayed(char, track)
	if not autoParryActive or not isLocalAlive() then
		return
	end
	local name, animId = getTrackAnimInfo(track)
	local kind = getAnimKind(name, animId)
	if debugEnabled then
		debugLog('anim_played', name, 'id=' .. normalizeAnimId(animId), kind or '-', 'w=' .. string.format('%.2f', track.WeightCurrent))
	end
	if not kind then
		return
	end
	if kind == 'melee' then
		handleMeleeAnimation(char, track, 'edge')
	elseif kind == 'gun_shot' or kind == 'gun_draw' then
		handleGunAnimation(char, track, 'edge')
	end
end

local function handleGlintSpawn(char, inst)
	if not shouldParryGun(char, false) then
		debugSkip('glint_aim', inst.Name, string.format('%.2f', getAimDot(char)))
		return
	end

	local state = getEnemyState(char)
	state.glintToken += 1
	local token = state.glintToken
	local gunName = detectEquippedGun(char)

	debugLog('trigger', 'gun_glint', gunName, 'timed', GUN_DRAW_TIMES[gunName] or GUN_DRAW_TIMES.Castigate, 'aim=' .. string.format('%.2f', getAimDot(char)))
	scheduleDrawParry(char, gunName)

	task.delay(1.5, function()
		if state.glintToken == token then
			state.glintToken = 0
		end
	end)
end

local function handleMeleeSound(char, sound)
	if not sound.IsPlaying then
		return
	end
	if not isMeleeSwingSoundName(sound.Name) then
		return
	end
	if not shouldParryMelee(char, true) then
		debugSkip('melee_sound_aim', sound.Name, string.format('%.2f', getAimDot(char)))
		return
	end
	local state = getEnemyState(char)
	local key = 'sound:' .. sound.Name
	if state.lastSwingId == key then
		return
	end
	state.lastSwingId = key
	task.delay(0.5, function()
		if state.lastSwingId == key then
			state.lastSwingId = ''
		end
	end)
	debugLog('trigger', 'melee_sound_' .. sound.Name, 'aim=' .. string.format('%.2f', getAimDot(char)))
	tryParry('melee_sound_' .. sound.Name)
end

local function handleShotSound(char, sound)
	if not sound.IsPlaying then
		return
	end
	if not isShotSoundName(sound.Name) then
		return
	end
	if not shouldParryGun(char, true) then
		debugSkip('sound_aim', sound.Name, string.format('%.2f', getAimDot(char)))
		return
	end
	debugLog('trigger', 'gun_sound_' .. sound.Name, 'aim=' .. string.format('%.2f', getAimDot(char)))
	tryParry('gun_sound_' .. sound.Name)
end

-- ---------------------------------------------------------------------------
-- Enemy watchers
-- ---------------------------------------------------------------------------

local function hookModel(model, ownerChar, conns)
	for _, desc in model:GetDescendants() do
		if desc:IsA('Animator') then
			table.insert(conns, desc.AnimationPlayed:Connect(function(track)
				onEnemyAnimationPlayed(ownerChar, track)
			end))
		end
		if desc:IsA('Sound') then
			table.insert(conns, desc:GetPropertyChangedSignal('IsPlaying'):Connect(function()
				if desc.IsPlaying then
					handleMeleeSound(ownerChar, desc)
					handleShotSound(ownerChar, desc)
				end
			end))
		end
		if isGlintName(desc.Name) then
			handleGlintSpawn(ownerChar, desc)
		end
	end

	table.insert(conns, model.DescendantAdded:Connect(function(inst)
		if inst:IsA('Animator') then
			table.insert(conns, inst.AnimationPlayed:Connect(function(track)
				onEnemyAnimationPlayed(ownerChar, track)
			end))
		end
		if inst:IsA('Sound') then
			table.insert(conns, inst:GetPropertyChangedSignal('IsPlaying'):Connect(function()
				if inst.IsPlaying then
					handleMeleeSound(ownerChar, inst)
					handleShotSound(ownerChar, inst)
				end
			end))
		end
		if isGlintName(inst.Name) then
			handleGlintSpawn(ownerChar, inst)
		end
	end))
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

	hookModel(char, ownerChar, conns)
	if plr then
		for _, extraModel in getEnemyModels(plr) do
			if extraModel ~= char then
				hookModel(extraModel, ownerChar, conns)
			end
		end
	end
	debugLog('watching', ownerChar.Name)
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
	buildAnimCatalog()
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

-- ---------------------------------------------------------------------------
-- Packet hooks (reach + gun VFX only)
-- ---------------------------------------------------------------------------

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

local function onGunVfxPacket(itemId, position)
	if not autoParryActive or typeof(position) ~= 'Vector3' then
		return
	end
	local root = getLocalRoot()
	if not root then
		return
	end
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local char = plr.Character
			if not shouldParryGun(char, true) then
				continue
			end
			local enemyRoot = char:FindFirstChild('HumanoidRootPart')
			if not enemyRoot then
				continue
			end
			local toUs = root.Position - enemyRoot.Position
			local shotDir = position - enemyRoot.Position
			if shotDir.Magnitude < 0.05 or toUs.Magnitude < 0.1 then
				continue
			end
			if shotDir.Unit:Dot(toUs.Unit) >= 0.75 then
				debugLog('trigger', 'gun_vfx_' .. tostring(itemId), 'aim=' .. string.format('%.2f', getAimDot(char)))
				tryParry('gun_vfx_' .. tostring(itemId))
				return
			end
		end
	end
end

local function bindPacketListeners()
	if not initPackets() then
		return
	end
	installMeleeReachHook()
	if packetListenersBound then
		return
	end
	local vfxPacket = Packets.unreliablePackets and Packets.unreliablePackets[GUN_VFX_PACKET]
	if vfxPacket and vfxPacket.OnClientEvent then
		packetListenersBound = true
		vfxPacket.OnClientEvent:Connect(function(itemId, position)
			onGunVfxPacket(itemId, position)
		end)
	end
end

-- ---------------------------------------------------------------------------
-- Auto attack
-- ---------------------------------------------------------------------------

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

local function scanWhitelistRealtime()
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local ownerChar = plr.Character
			local meleeDist = getEnemyDistance(ownerChar)
			for _, model in getEnemyModels(plr) do
				for _, track in getAllPlayingTracks(model) do
					if not track.IsPlaying or track.WeightCurrent < 0.05 then
						continue
					end
					local name, animId = getTrackAnimInfo(track)
					local kind = getAnimKind(name, animId)
					if kind == 'melee' and meleeDist <= meleeRangeSetting and track.TimePosition <= MELEE_SWING_MAX_TIME then
						handleMeleeAnimation(ownerChar, track, 'scan')
					elseif kind == 'gun_shot' and track.TimePosition <= GUN_SHOT_MAX_TIME then
						handleGunAnimation(ownerChar, track, 'scan')
					elseif kind == 'gun_draw' then
						handleGunAnimation(ownerChar, track, 'scan')
					end
				end
			end
		end
	end
end

local function bindParryScanLoop()
	if parryScanBound then
		return
	end
	parryScanBound = true
	runService.PreRender:Connect(function()
		if not autoParryActive or not isLocalAlive() then
			return
		end
		startEnemyWatchers()
		scanWhitelistRealtime()
	end)
end

local function enemyThreatensMe(char, meleeRange)
	for _, track in getAllPlayingTracks(char) do
		if track.IsPlaying and track.WeightCurrent >= 0.1 then
			local name, animId = getTrackAnimInfo(track)
			local kind = getAnimKind(name, animId)
			if kind == 'melee' and getEnemyDistance(char) <= meleeRange and shouldParryMelee(char, true) then
				return true
			end
			if (kind == 'gun_shot' or kind == 'gun_draw') and shouldParryGun(char, true) then
				return true
			end
		end
	end
	for _, inst in char:GetDescendants() do
		if isGlintName(inst.Name) and shouldParryGun(char, false) then
			return true
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
		if plr ~= lplr and plr.Character and enemyThreatensMe(plr.Character, swordReach + 4) then
			return
		end
	end

	pressAttackClick()
end

local function combatHeartbeat(meleeRange, attackCooldown)
	if not isLocalAlive() then
		return
	end

	meleeRangeSetting = meleeRange
	bindPacketListeners()

	if autoParryActive then
		bindParryScanLoop()

		if debugEnabled and tick() - lastDebugHeartbeat > 3 then
			lastDebugHeartbeat = tick()
			local enemyCount, watchedCount = 0, 0
			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character then
					enemyCount += 1
					if charWatchers[plr.Character] then
						watchedCount += 1
					end
				end
			end
			print('[REDLINER] status | enemies=', enemyCount, 'watched=', watchedCount, 'meleeRange=', meleeRange)
		end
	end

	tryAutoAttack(attackCooldown)
end

local function cleanupEnemyState(model)
	unwatchCharacter(model)
end

-- ---------------------------------------------------------------------------
-- UI modules
-- ---------------------------------------------------------------------------

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
	local ExtendReach
	local AttackCooldown
	local Debug
	local TestParry

	AutoParry = minigames:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			autoParryActive = callback
			if callback then
				buildAnimCatalog(true)
				startEnemyWatchers()
				bindParryScanLoop()
				bindPacketListeners()
				notif('Auto Parry', 'Timed melee + gun parry when enemies aim at you.', 5)
			end
		end,
		Tooltip = 'Parries whitelisted melee swings and gun shots when enemies aim at you.',
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
		Max = 30,
		Default = 20,
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
				buildAnimCatalog()
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
			combatHeartbeat(MeleeRange.Value, AttackCooldown.Value)
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
