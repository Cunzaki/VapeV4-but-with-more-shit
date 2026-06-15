--[[
	REDLINER shared game script (MAIN + FFA + MATCH place IDs).
	Place IDs: 94987506187454 (main), 115875349872417 (FFA), 126691165749976 (match).
	Auto Parry, Auto Attack, Reach (melee hitbox + packet extension).
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
local workspaceService = cloneref(workspace)

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
local MELEE_PACKET_REMOTE = '_xe6cbd0bf2a4cf278'
local MELEE_ACTION_HINTS = { 'SWING', 'SLASH', 'HIT', 'ATTACK', 'WIDE', 'STAB', 'CUT' }
local DASH_VELOCITY_MIN = 20
local AUTO_ATTACK_RANGE_DEFAULT = 14
local AUTO_ATTACK_MIN_DELAY = 1 / 60

local AUTO_PARRY_DEFAULTS = {
	meleeRange = 20,
	threatRange = 100,
	watcherThreatRange = 120,
	meleeEnemyDebounce = 0.15,
	gunEnemyDebounce = 0.3,
	meleeAimDot = 0.32,
	gunAimDot = 0.8,
	meleeParryCooldown = 0,
	parryCooldown = 0.05,
	meleeSwingWindow = 0.55,
	gunDrawWindow = 0.45,
	gunShotWindow = 0.15,
	closeRangeStuds = 3,
	castigateDelay = 0.36,
	phoenixDelay = 0.66,
	siegeDelay = 0.96,
	monarchDelay = 1.71,
	parryMelee = true,
	parryGunDraw = true,
	parryGunShot = true,
	parryGlint = true,
	threatDebug = false,
}

-- Melee + gun animations from ReplicatedStorage.Assets.Animations catalog.
local PARRY_ANIM_IDS = {
	['105441036119013'] = 'melee',
}

-- Movement false-positives (NOT gun attacks).
local BLOCKED_ANIM_IDS = {
	['115078691506529'] = 'walk', -- Redliner.3P_Walk
}

-- Gun draw: 3P_Gundraw + first-person Draw per weapon.
local GUN_DRAW_ANIM_IDS = {
	['124492122976293'] = 'Castigate', -- Castigate.3P_Gundraw
	['95978217334708'] = 'Castigate', -- Castigate.Draw
	['108324409673822'] = 'Phoenix', -- Phoenix.3P_Gundraw
	['128865035304346'] = 'Phoenix', -- Phoenix.Draw
	['134702782811301'] = 'Siege', -- Siege.3P_Gundraw
	['76542766199369'] = 'Siege', -- Siege.Draw
	['125490982378115'] = 'Monarch', -- Monarch.3P_Gundraw
	['133803127890988'] = 'Monarch', -- Monarch.Draw
}

-- Gun shot: 3P_Gunshot + Fire (+ Siege bonus shots).
local GUN_SHOT_ANIM_IDS = {
	['110389010823335'] = 'Castigate', -- Castigate.3P_Gunshot
	['131479610656562'] = 'Castigate', -- Castigate.Fire
	['115498395958050'] = 'Phoenix', -- Phoenix.3P_Gunshot
	['102568803482882'] = 'Phoenix', -- Phoenix.Fire
	['82893125154254'] = 'Siege', -- Siege.3P_Gunshot
	['117470706732508'] = 'Siege', -- Siege.Fire
	['106013608253968'] = 'Siege', -- Siege.3P_Bonusshot
	['125194834753017'] = 'Siege', -- Siege.BonusFire
	['96091952971711'] = 'Monarch', -- Monarch.3P_Gunshot
	['107008811118123'] = 'Monarch', -- Monarch.Fire
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
local autoAttackRangeSetting = AUTO_ATTACK_RANGE_DEFAULT
local attackDelaySetting = 0.38
local debugEnabled = false
local threatDebugEnabled = AUTO_PARRY_DEFAULTS.threatDebug
local meleeRangeSetting = AUTO_PARRY_DEFAULTS.meleeRange
local threatRangeSetting = AUTO_PARRY_DEFAULTS.threatRange
local watcherThreatRangeSetting = AUTO_PARRY_DEFAULTS.watcherThreatRange
local meleeEnemyDebounceSetting = AUTO_PARRY_DEFAULTS.meleeEnemyDebounce
local gunEnemyDebounceSetting = AUTO_PARRY_DEFAULTS.gunEnemyDebounce
local meleeAimDotSetting = AUTO_PARRY_DEFAULTS.meleeAimDot
local gunAimDotSetting = AUTO_PARRY_DEFAULTS.gunAimDot
local meleeParryCooldownSetting = AUTO_PARRY_DEFAULTS.meleeParryCooldown
local parryCooldownSetting = AUTO_PARRY_DEFAULTS.parryCooldown
local meleeSwingWindowSetting = AUTO_PARRY_DEFAULTS.meleeSwingWindow
local gunDrawWindowSetting = AUTO_PARRY_DEFAULTS.gunDrawWindow
local gunShotWindowSetting = AUTO_PARRY_DEFAULTS.gunShotWindow
local closeRangeStudsSetting = AUTO_PARRY_DEFAULTS.closeRangeStuds
local gunParryDelays = {
	Castigate = AUTO_PARRY_DEFAULTS.castigateDelay,
	Phoenix = AUTO_PARRY_DEFAULTS.phoenixDelay,
	Siege = AUTO_PARRY_DEFAULTS.siegeDelay,
	Monarch = AUTO_PARRY_DEFAULTS.monarchDelay,
}
local parryMeleeEnabled = AUTO_PARRY_DEFAULTS.parryMelee
local parryGunDrawEnabled = AUTO_PARRY_DEFAULTS.parryGunDraw
local parryGunShotEnabled = AUTO_PARRY_DEFAULTS.parryGunShot
local parryGlintEnabled = AUTO_PARRY_DEFAULTS.parryGlint
local myHurtboxes = {}
local enemyStates = {}
local charWatchers = {}
local watchersStarted = false
local meleeTemplate = nil
local meleeHooked = false
local lastParryAt = 0
local lastMeleeParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local lastDebugHeartbeat = 0
local lastDebugSkipAt = {}
local lastDebugAnimAt = {}
local parryIdsLogged = false
local parryScanBound = false
local autoAttackLoopBound = false
local localRespawnBound = false
local lastParryScanAt = 0
local lastWatcherRefreshAt = 0
local PARRY_SCAN_INTERVAL = 0.05
local WATCHER_REFRESH_INTERVAL = 0.25
local GUN_AIM_RANGE_BONUS = 0.12
local tryParry
local canSafelyParry
local hitboxReachHooked = false
local meleePacketHooked = false
local packetMetatableHooked = false
local attackReachHooked = false
local reachHitboxHookSource = nil
local reachAttackHookSource = nil
local reachDebugEnabled = false
local lastReachDebugHeartbeat = 0
local lastReachDebugSkipAt = {}

local function reachDebugLog(...)
	if reachDebugEnabled then
		print('[REDLINER][Reach]', ...)
	end
end

local function reachDebugWarn(...)
	if reachDebugEnabled then
		warn('[REDLINER][Reach]', ...)
	end
end

local function reachDebugSkip(key, ...)
	if not reachDebugEnabled then
		return
	end
	local now = tick()
	if now - (lastReachDebugSkipAt[key] or 0) < 0.2 then
		return
	end
	lastReachDebugSkipAt[key] = now
	print('[REDLINER][Reach] skip:', key, ...)
end

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

local function threatDebugSkip(...)
	if not threatDebugEnabled and not debugEnabled then
		return
	end
	local key = table.concat({...}, '|')
	local now = tick()
	if now - (lastDebugSkipAt[key] or 0) < 0.2 then
		return
	end
	lastDebugSkipAt[key] = now
	print('[REDLINER] skip:', ...)
end

-- ---------------------------------------------------------------------------
-- Packets / reach
-- ---------------------------------------------------------------------------

local function initPackets()
	if Packets then
		return true
	end
	local assets = replicatedStorage:FindFirstChild('Assets')
		or replicatedStorage:WaitForChild('Assets', 20)
	if not assets then
		return false
	end
	local modules = assets:FindFirstChild('ModuleScripts')
		or assets:WaitForChild('ModuleScripts', 20)
	if not modules then
		return false
	end
	local packetsModule = modules:FindFirstChild('Packets')
		or modules:WaitForChild('Packets', 20)
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

local function getLocalCharacter()
	local char = lplr.Character
	if entitylib.isAlive and entitylib.character.Character then
		local elibChar = entitylib.character.Character
		if char and elibChar == char then
			return elibChar
		end
		if elibChar and elibChar.Parent then
			return elibChar
		end
	end
	return char
end

local function getLocalRoot()
	local char = getLocalCharacter()
	if not char then
		return nil
	end
	if entitylib.isAlive and entitylib.character.RootPart then
		local root = entitylib.character.RootPart
		if root:IsDescendantOf(char) then
			return root
		end
	end
	return char:FindFirstChild('HumanoidRootPart')
end

local function isLocalAlive()
	local char = getLocalCharacter()
	if not char or not char.Parent then
		return false
	end
	if entitylib.isAlive and entitylib.character.Character == char and entitylib.character.RootPart then
		local root = entitylib.character.RootPart
		if root:IsDescendantOf(char) then
			return true
		end
	end
	local hum = char:FindFirstChildWhichIsA('Humanoid')
	if not hum or hum.Health <= 0 then
		return false
	end
	if hum:GetState() == Enum.HumanoidStateType.Dead then
		return false
	end
	return true
end

canSafelyParry = function()
	if not autoParryActive then
		return false
	end
	if not isLocalAlive() then
		return false
	end
	local root = getLocalRoot()
	return root ~= nil and root.Parent ~= nil
end

local function isEnemyCharacter(model)
	if not model or model == lplr.Character then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(model)
	return plr and plr ~= lplr
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
	local chronoStorage = workspaceService:FindFirstChild('Chrono_EntityStorage')
	if chronoStorage then
		for _, child in chronoStorage:GetChildren() do
			if child:IsA('Model') and getPlayerFromModel(child) == plr then
				table.insert(models, child)
			end
		end
	end
	return models
end

local function getClosestEnemyDistance(charOrPlr)
	local root = getLocalRoot()
	if not root then
		return math.huge
	end
	local models
	if typeof(charOrPlr) == 'Instance' and charOrPlr:IsA('Player') then
		models = getEnemyModels(charOrPlr)
	elseif charOrPlr then
		local plr = playersService:GetPlayerFromCharacter(charOrPlr)
		models = plr and getEnemyModels(plr) or {charOrPlr}
	else
		return math.huge
	end
	local best = math.huge
	for _, model in models do
		if model and model.Parent then
			local enemyRoot = model:FindFirstChild('HumanoidRootPart')
			if enemyRoot then
				best = math.min(best, (enemyRoot.Position - root.Position).Magnitude)
			end
		end
	end
	return best
end

local function getEnemyDistance(char)
	return getClosestEnemyDistance(char)
end

local function getEnemyState(char)
		if not enemyStates[char] then
		enemyStates[char] = {
			lastSwingId = '',
			lastShotId = '',
			lastDrawId = '',
			glintToken = 0,
			scheduledDrawToken = 0,
			scheduledMeleeToken = 0,
			lastAnimTriggerKey = '',
			lastAnimTriggerAt = 0,
			lastMeleeParryAt = 0,
			lastGunParryAt = 0,
		}
	end
	return enemyStates[char]
end

local function isEnemyInMeleeThreatRange(char)
	return getEnemyDistance(char) <= meleeRangeSetting
end

local function isEnemyInGunThreatRange(char)
	return getEnemyDistance(char) <= threatRangeSetting
end

local function getEffectiveWatcherRange()
	return math.max(watcherThreatRangeSetting, threatRangeSetting, meleeRangeSetting)
end

local function isInstUnderEnemyModels(char, inst)
	if not inst or not char then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(char)
	local models = plr and getEnemyModels(plr) or {char}
	for _, model in models do
		if model and model.Parent and (inst == model or inst:IsDescendantOf(model)) then
			return true
		end
	end
	return false
end

local function getTriggerDebounce(triggerKey)
	if string.find(triggerKey, ':melee:', 1, true) then
		return meleeEnemyDebounceSetting
	end
	return gunEnemyDebounceSetting
end

local function canEnemyAnimTrigger(char, triggerKey)
	local state = getEnemyState(char)
	local now = tick()
	local debounce = getTriggerDebounce(triggerKey)
	if state.lastAnimTriggerKey == triggerKey and now - (state.lastAnimTriggerAt or 0) < debounce then
		threatDebugSkip('cooldown', char.Name, triggerKey)
		return false
	end
	state.lastAnimTriggerKey = triggerKey
	state.lastAnimTriggerAt = now
	return true
end

-- ---------------------------------------------------------------------------
-- Animation catalog (whitelist-only)
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- Parry animation IDs (strict whitelist only)
-- ---------------------------------------------------------------------------

local function normalizeAnimId(animId)
	if typeof(animId) ~= 'string' or animId == '' then
		return ''
	end
	local numeric = string.match(animId, '(%d+)')
	return numeric or string.lower(animId)
end

local function getTrackAnimInfo(track)
	local anim = track and track.Animation
	if not anim then
		return '', ''
	end
	return anim.Name or '', anim.AnimationId or ''
end

local function getParryAnimKind(animId)
	local normId = normalizeAnimId(animId)
	if BLOCKED_ANIM_IDS[normId] then
		return nil
	end
	if PARRY_ANIM_IDS[normId] then
		return PARRY_ANIM_IDS[normId]
	end
	if GUN_DRAW_ANIM_IDS[normId] then
		return 'gun_draw'
	end
	if GUN_SHOT_ANIM_IDS[normId] then
		return 'gun_shot'
	end
	return nil
end

local function isParryMeleeAnim(animId)
	return getParryAnimKind(animId) == 'melee'
end

local function debugAnimLog(...)
	if not debugEnabled then
		return
	end
	local key = table.concat({...}, '|')
	local now = tick()
	if now - (lastDebugAnimAt[key] or 0) < 0.5 then
		return
	end
	lastDebugAnimAt[key] = now
	print('[REDLINER] anim:', ...)
end

local function logParryAnimIds(force)
	if parryIdsLogged and not force then
		return
	end
	parryIdsLogged = true
	print('[REDLINER] parry ids | melee=105441036119013 | gun_draw+gun_shot from catalog | blocked walk=115078691506529')
end

local function getAllPlayingTracks(char)
	if not char then
		return {}
	end
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

local function getAllPlayingTracksForChar(char)
	local plr = playersService:GetPlayerFromCharacter(char)
	local models = plr and getEnemyModels(plr) or {char}
	local tracks = {}
	for _, model in models do
		if model and model.Parent then
			for _, track in getAllPlayingTracks(model) do
				table.insert(tracks, track)
			end
		end
	end
	return tracks
end

local function charHasWhitelistAttackPlaying(char)
	for _, track in getAllPlayingTracksForChar(char) do
		if not track.IsPlaying then
			continue
		end
		local _, animId = getTrackAnimInfo(track)
		local kind = getParryAnimKind(animId)
		if kind == 'melee' then
			return true
		end
		if track.WeightCurrent >= 0.15 and kind then
			return true
		end
	end
	return false
end

-- ---------------------------------------------------------------------------
-- Aim checks
-- ---------------------------------------------------------------------------

local function getTrackOwnerModel(track)
	if not track then
		return nil
	end
	local inst = track.Parent
	while inst do
		if inst:IsA('Model') and inst:FindFirstChild('HumanoidRootPart') then
			return inst
		end
		inst = inst.Parent
	end
	return nil
end

local function getGunAimDotFromModel(model)
	local root = getLocalRoot()
	local enemyRoot = model and model:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return 0
	end
	local offset = root.Position - enemyRoot.Position
	local flatOffset = Vector3.new(offset.X, 0, offset.Z)
	if flatOffset.Magnitude < 0.05 then
		return 1
	end
	local dir = flatOffset.Unit
	local flatLook = Vector3.new(enemyRoot.CFrame.LookVector.X, 0, enemyRoot.CFrame.LookVector.Z)
	if flatLook.Magnitude < 0.05 then
		return 0
	end
	return flatLook.Unit:Dot(dir)
end

local function getHeadAimDotFromModel(model)
	local root = getLocalRoot()
	local head = model and model:FindFirstChild('Head')
	if not root or not head then
		return 0
	end
	local offset = root.Position - head.Position
	local flatOffset = Vector3.new(offset.X, 0, offset.Z)
	if flatOffset.Magnitude < 0.05 then
		return 1
	end
	local flatHead = Vector3.new(head.CFrame.LookVector.X, 0, head.CFrame.LookVector.Z)
	if flatHead.Magnitude < 0.05 then
		return 0
	end
	return flatHead.Unit:Dot(flatOffset.Unit)
end

local function getEffectiveGunAimThreshold(dist)
	local base = gunAimDotSetting
	if threatRangeSetting <= 0 then
		return math.min(base, 0.95)
	end
	local rangeFactor = math.clamp(dist / threatRangeSetting, 0, 1)
	return math.min(base + rangeFactor * GUN_AIM_RANGE_BONUS, 0.95)
end

local function getGunAimDot(char, aimModel)
	return getGunAimDotFromModel(aimModel or char)
end

local function getAimDot(char)
	local hrpDot = getGunAimDotFromModel(char)
	local headDot = getHeadAimDotFromModel(char)
	return math.max(hrpDot, headDot)
end

local function isEnemyAimingAtMeForGun(char, aimModel)
	local model = aimModel or char
	local dist = getClosestEnemyDistance(char)
	local hrpDot = getGunAimDotFromModel(model)
	local need = getEffectiveGunAimThreshold(dist)
	if hrpDot < need then
		return false, hrpDot, need
	end
	return true, hrpDot, need
end

local function isEnemyTargetingMe(char, minDot, confirmedAttack)
	local dist = getClosestEnemyDistance(char)
	if not confirmedAttack and dist < closeRangeStudsSetting and not charHasWhitelistAttackPlaying(char) then
		debugSkip('close_range_no_attack', char.Name, string.format('%.1f', dist))
		return false
	end
	return getAimDot(char) >= minDot
end

local function shouldParryMelee(char, _confirmedAttack)
	if not parryMeleeEnabled then
		return false
	end
	if not isEnemyInMeleeThreatRange(char) then
		threatDebugSkip('out_of_range', char.Name, 'melee', string.format('%.1f', getClosestEnemyDistance(char)))
		return false
	end
	return true
end

local function shouldParryGun(char, confirmedAttack, aimModel)
	if not parryGunDrawEnabled and not parryGunShotEnabled then
		return false
	end
	if not char then
		return false
	end
	if not isEnemyInGunThreatRange(char) then
		threatDebugSkip('out_of_range', char.Name, 'gun', string.format('%.1f', getClosestEnemyDistance(char)))
		return false
	end
	local aiming, dot, need = isEnemyAimingAtMeForGun(char, aimModel)
	if not aiming then
		threatDebugSkip('not_aiming', char.Name, 'gun', string.format('dot=%.3f need=%.2f', dot, need))
		return false
	end
	return true
end

local function isMeleeSwingTrackActive(track)
	return track.IsPlaying
end

-- ---------------------------------------------------------------------------
-- Gun helpers
-- ---------------------------------------------------------------------------

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

local function charHasGunEquipped(char)
	for _, desc in char:GetDescendants() do
		local lower = string.lower(desc.Name)
		for _, entry in GUN_ITEM_PATTERNS do
			if string.find(lower, entry.pattern, 1, true) then
				return true
			end
		end
	end
	return false
end

local function isEnemyDashing(char)
	local root = char:FindFirstChild('HumanoidRootPart')
	if root then
		local vel = root.AssemblyLinearVelocity
		local horizontal = Vector3.new(vel.X, 0, vel.Z)
		if horizontal.Magnitude >= DASH_VELOCITY_MIN then
			return true
		end
	end
	return false
end

local function isGlintInstance(inst)
	return string.find(string.lower(inst.Name), 'glint', 1, true) ~= nil
end

local function getGunParryDelay(gunName)
	return gunParryDelays[gunName] or gunParryDelays.Castigate
end

local function scheduleGunDrawParry(char, gunName, normId, timePosition, source, track, aimModel)
	if not shouldParryGun(char, true, aimModel) then
		debugSkip('gun_draw_aim_schedule', char.Name, gunName, normId, source)
		return
	end
	local state = getEnemyState(char)
	local drawKey = normId .. ':gun_draw'
	if state.lastDrawId == drawKey then
		return
	end
	state.lastDrawId = drawKey
	state.scheduledDrawToken += 1
	local token = state.scheduledDrawToken
	timePosition = timePosition or 0
	local delay = math.max(0, getGunParryDelay(gunName) - timePosition)

	debugLog('trigger', 'gun_draw_schedule_' .. gunName, 'id=' .. normId, 'delay=' .. string.format('%.2f', delay), source)

	if track then
		track.Stopped:Once(function()
			if state.lastDrawId == drawKey then
				state.lastDrawId = ''
			end
		end)
	end

	task.delay(delay + 0.5, function()
		if state.lastDrawId == drawKey then
			state.lastDrawId = ''
		end
	end)

	task.delay(delay, function()
		if not canSafelyParry() or token ~= state.scheduledDrawToken then
			return
		end
		if not char.Parent then
			return
		end
		if not charHasGunEquipped(char) then
			debugSkip('gun_draw_no_gun', char.Name, gunName, normId)
			return
		end
		if isEnemyDashing(char) then
			debugSkip('gun_draw_dash', char.Name, gunName, normId)
			return
		end
		if not shouldParryGun(char, true, aimModel) then
			debugSkip('gun_draw_out_of_range', char.Name, gunName, string.format('%.1f', getClosestEnemyDistance(char)))
			return
		end
		debugLog('trigger', 'gun_draw_timed_' .. gunName, normId, string.format('%.2f', getClosestEnemyDistance(char)))
		tryParry('gun_draw_' .. gunName .. '_' .. normId, char)
	end)
end

-- ---------------------------------------------------------------------------
-- Parry input
-- ---------------------------------------------------------------------------

local function pressParryKey()
	if not canSafelyParry() then
		return false
	end
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

tryParry = function(reason, char)
	if not canSafelyParry() then
		return false
	end
	local now = tick()
	local isMeleeParry = reason and string.sub(reason, 1, 6) == 'melee_'
	if isMeleeParry then
		if now - lastMeleeParryAt < meleeParryCooldownSetting then
			if char then
				threatDebugSkip('cooldown', 'melee', char.Name, reason)
			end
			return false
		end
	else
		if now - lastParryAt < parryCooldownSetting then
			if char then
				threatDebugSkip('cooldown', 'global', char.Name, reason)
			end
			return false
		end
	end
	if char then
		local state = getEnemyState(char)
		local perEnemyDebounce = isMeleeParry and meleeEnemyDebounceSetting or gunEnemyDebounceSetting
		local lastAt = isMeleeParry and (state.lastMeleeParryAt or 0) or (state.lastGunParryAt or 0)
		if now - lastAt < perEnemyDebounce then
			threatDebugSkip('cooldown', char.Name, reason)
			return false
		end
		if isMeleeParry then
			state.lastMeleeParryAt = now
		else
			state.lastGunParryAt = now
		end
	end
	if isMeleeParry then
		lastMeleeParryAt = now
	end
	lastParryAt = now
	parryBlockAttackUntil = tick() + 0.2
	debugLog('parry trigger', reason, char and char.Name or '-')
	pressParryKey()
	return true
end

-- ---------------------------------------------------------------------------
-- Threat handlers (edge-triggered only)
-- ---------------------------------------------------------------------------

local function handleMeleeAnimation(char, track, source, aimModel)
	source = source or 'edge'
	if not isMeleeSwingTrackActive(track) then
		debugSkip('melee_not_playing', getTrackAnimInfo(track), source)
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	if not isParryMeleeAnim(animId) then
		debugSkip('not_whitelisted', name, normId, source)
		return
	end
	if track.TimePosition > meleeSwingWindowSetting then
		debugSkip('melee_late_window', name, string.format('%.2f', track.TimePosition), source)
		return
	end
	if not shouldParryMelee(char, true) then
		return
	end

	local swingKey = normId .. ':melee:swing'
	if not canEnemyAnimTrigger(char, swingKey) then
		return
	end

	local state = getEnemyState(char)
	if state.lastSwingId == swingKey then
		return
	end
	state.lastSwingId = swingKey
	track.Stopped:Once(function()
		if state.lastSwingId == swingKey then
			state.lastSwingId = ''
		end
	end)
	debugLog('trigger', 'melee_' .. normId, 'dist=' .. string.format('%.1f', getClosestEnemyDistance(char)), source)
	tryParry('melee_' .. normId, char)
end

local function handleGunDrawAnimation(char, track, source, aimModel)
	if not parryGunDrawEnabled then
		return
	end
	source = source or 'edge'
	if not track.IsPlaying then
		debugSkip('gun_draw_not_playing', getTrackAnimInfo(track), source)
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local gunName = GUN_DRAW_ANIM_IDS[normId]
	if not gunName then
		return
	end
	if track.TimePosition > gunDrawWindowSetting then
		debugSkip('gun_draw_late', name, string.format('%.2f', track.TimePosition), source)
		return
	end
	if not shouldParryGun(char, true, aimModel) then
		return
	end

	local drawKey = normId .. ':gun_draw'
	if not canEnemyAnimTrigger(char, drawKey) then
		return
	end

	scheduleGunDrawParry(char, gunName, normId, track.TimePosition, source, track, aimModel)
end

local function handleGunShotAnimation(char, track, source, aimModel)
	if not parryGunShotEnabled then
		return
	end
	source = source or 'edge'
	if not track.IsPlaying then
		debugSkip('gun_shot_not_playing', getTrackAnimInfo(track), source)
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local gunName = GUN_SHOT_ANIM_IDS[normId]
	if not gunName then
		return
	end
	if track.TimePosition > gunShotWindowSetting then
		debugSkip('gun_shot_late', name, string.format('%.2f', track.TimePosition), source)
		return
	end
	if not shouldParryGun(char, true, aimModel) then
		return
	end
	if not charHasGunEquipped(char) then
		debugSkip('gun_shot_no_gun', name, normId, source)
		return
	end

	local shotKey = normId .. ':gun_shot'
	if not canEnemyAnimTrigger(char, shotKey) then
		return
	end

	local state = getEnemyState(char)
	if state.lastShotId == shotKey then
		return
	end
	state.lastShotId = shotKey
	track.Stopped:Once(function()
		if state.lastShotId == shotKey then
			state.lastShotId = ''
		end
	end)

	debugLog('trigger', 'gun_shot_' .. gunName, normId, 'dist=' .. string.format('%.1f', getClosestEnemyDistance(char)), source)
	tryParry('gun_shot_' .. gunName .. '_' .. normId, char)
end

local function handleGlintSpawn(char, inst)
	if not isGlintInstance(inst) then
		return
	end
	if not isInstUnderEnemyModels(char, inst) then
		threatDebugSkip('wrong_enemy', inst.Name, char.Name)
		return
	end
	if not parryGlintEnabled or not parryGunDrawEnabled then
		return
	end
	if not isEnemyInGunThreatRange(char) then
		threatDebugSkip('out_of_range', char.Name, 'glint', string.format('%.1f', getClosestEnemyDistance(char)))
		return
	end
	if not charHasGunEquipped(char) then
		debugSkip('glint_no_gun', inst.Name)
		return
	end
	if isEnemyDashing(char) then
		debugSkip('glint_dash', inst.Name)
		return
	end
	local aimModel = inst
	while aimModel and not aimModel:FindFirstChild('HumanoidRootPart') do
		aimModel = aimModel.Parent
	end
	if not aimModel or not aimModel:IsA('Model') then
		aimModel = char
	end
	if not shouldParryGun(char, true, aimModel) then
		return
	end
	local glintKey = 'glint:' .. inst:GetFullName()
	if not canEnemyAnimTrigger(char, glintKey) then
		return
	end
	local gunName = detectEquippedGun(char)
	debugLog('trigger', 'gun_glint', gunName, 'dist=' .. string.format('%.1f', getClosestEnemyDistance(char)))
	scheduleGunDrawParry(char, gunName, 'glint:' .. gunName, 0, 'glint', nil, aimModel)
end

local function onEnemyAnimationPlayed(char, track)
	if not autoParryActive or not isLocalAlive() then
		return
	end
	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local kind = getParryAnimKind(animId)
	local aimModel = getTrackOwnerModel(track) or char
	if debugEnabled then
		if BLOCKED_ANIM_IDS[normId] then
			debugAnimLog('blocked', normId, BLOCKED_ANIM_IDS[normId], 'w=' .. string.format('%.2f', track.WeightCurrent))
		elseif kind or track.WeightCurrent >= 0.35 then
			debugAnimLog('played', name, 'id=' .. normId, kind or '-', 'w=' .. string.format('%.2f', track.WeightCurrent))
		end
	end
	if kind == 'melee' and parryMeleeEnabled then
		if getClosestEnemyDistance(char) > meleeRangeSetting then
			threatDebugSkip('out_of_range', char.Name, 'melee_edge', string.format('%.1f', getClosestEnemyDistance(char)))
			return
		end
		handleMeleeAnimation(char, track, 'edge', aimModel)
	elseif kind == 'gun_draw' and parryGunDrawEnabled then
		if getClosestEnemyDistance(char) > threatRangeSetting then
			threatDebugSkip('out_of_range', char.Name, 'gun_draw_edge', string.format('%.1f', getClosestEnemyDistance(char)))
			return
		end
		handleGunDrawAnimation(char, track, 'edge', aimModel)
	elseif kind == 'gun_shot' and parryGunShotEnabled then
		if getClosestEnemyDistance(char) > threatRangeSetting then
			threatDebugSkip('out_of_range', char.Name, 'gun_shot_edge', string.format('%.1f', getClosestEnemyDistance(char)))
			return
		end
		handleGunShotAnimation(char, track, 'edge', aimModel)
	end
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
		if isGlintInstance(desc) then
			handleGlintSpawn(ownerChar, desc)
		end
	end

	table.insert(conns, model.DescendantAdded:Connect(function(inst)
		if inst:IsA('Animator') then
			table.insert(conns, inst.AnimationPlayed:Connect(function(track)
				onEnemyAnimationPlayed(ownerChar, track)
			end))
		end
		if isGlintInstance(inst) then
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

local function cancelPendingParries()
	for _, state in enemyStates do
		state.scheduledDrawToken += 1
		state.scheduledMeleeToken += 1
		state.lastSwingId = ''
		state.lastShotId = ''
		state.lastDrawId = ''
	end
end

local function unwatchAllForPlayer(plr)
	local toRemove = {}
	for char in charWatchers do
		if getPlayerFromModel(char) == plr then
			table.insert(toRemove, char)
		end
	end
	for _, char in toRemove do
		unwatchCharacter(char)
	end
end

local function purgeOrphanWatchers()
	local toRemove = {}
	for char in charWatchers do
		if not char.Parent then
			table.insert(toRemove, char)
		end
	end
	for _, char in toRemove do
		unwatchCharacter(char)
	end
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
	local plrDist = getClosestEnemyDistance(plr)
	if plrDist > getEffectiveWatcherRange() then
		unwatchAllForPlayer(plr)
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

local function refreshThreatWatchers(force)
	if not autoParryActive then
		return
	end
	local now = tick()
	if not force and now - lastWatcherRefreshAt < WATCHER_REFRESH_INTERVAL then
		return
	end
	lastWatcherRefreshAt = now
	purgeOrphanWatchers()
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			if getClosestEnemyDistance(plr) <= getEffectiveWatcherRange() then
				watchEnemyPlayer(plr)
			else
				unwatchAllForPlayer(plr)
			end
		end
	end
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

local function refreshEnemyWatchers()
	refreshThreatWatchers(true)
end

local function onEnemyCharacterSpawned(plr)
	task.defer(function()
		if not plr.Parent then
			return
		end
		unwatchAllForPlayer(plr)
		watchEnemyPlayer(plr)
	end)
end

local function blockLocalParry()
	cancelPendingParries()
end

local function bindLocalRespawnHandler()
	if localRespawnBound then
		return
	end
	localRespawnBound = true

	local function hookCharacter(char)
		if not char then
			return
		end
		refreshMyHurtboxes()
		local hum = char:FindFirstChildWhichIsA('Humanoid') or char:WaitForChild('Humanoid', 8)
		if hum then
			hum.Died:Connect(function()
				blockLocalParry()
			end)
		end
	end

	lplr.CharacterRemoving:Connect(function()
		blockLocalParry()
	end)

	lplr.CharacterAdded:Connect(function(char)
		blockLocalParry()
		task.defer(function()
			refreshMyHurtboxes()
			refreshEnemyWatchers()
			hookCharacter(char)
		end)
	end)

	if lplr.Character then
		hookCharacter(lplr.Character)
	end
end

local function startEnemyWatchers()
	refreshEnemyWatchers()
	if watchersStarted then
		return
	end
	watchersStarted = true

	playersService.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function()
			onEnemyCharacterSpawned(plr)
		end)
		task.defer(function()
			onEnemyCharacterSpawned(plr)
		end)
	end)

	playersService.PlayerRemoving:Connect(function(plr)
		unwatchAllForPlayer(plr)
	end)

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			plr.CharacterAdded:Connect(function()
				onEnemyCharacterSpawned(plr)
			end)
		end
	end
end

-- ---------------------------------------------------------------------------
-- Packet hooks (melee reach)
-- ---------------------------------------------------------------------------

local function isGameWindowFocused()
	if isrbxactive then
		return isrbxactive()
	end
	if iswindowactive then
		return iswindowactive()
	end
	return true
end

local function isEnemyOwner(model)
	local plr = getPlayerFromModel(model)
	return plr ~= nil and plr ~= lplr
end

local function isMeleeSwingAction(action)
	if typeof(action) ~= 'string' then
		return false
	end
	action = string.upper(action)
	for _, hint in MELEE_ACTION_HINTS do
		if string.find(action, hint, 1, true) then
			return true
		end
	end
	return false
end

local function isMeleeHurtboxFire(packed)
	return type(packed) == 'table' and packed.n >= 4 and typeof(packed[4]) == 'Vector3'
end

local function isMeleePacketObject(packet)
	return packet and (packet.Name == MELEE_PACKET_REMOTE or packet.Name == MELEE_PACKET_NAME)
end

local function mergeHurtboxLists(...)
	local merged = {}
	local seen = {}
	for i = 1, select('#', ...) do
		local list = select(i, ...)
		if type(list) == 'table' then
			for _, part in list do
				if typeof(part) == 'Instance' and part:IsA('BasePart') and not seen[part] then
					seen[part] = true
					table.insert(merged, part)
				end
			end
		end
	end
	return merged
end

local function getEnemyHurtboxesInRange(range, origin)
	local root = getLocalRoot()
	origin = origin or (root and root.Position)
	if not origin then
		return {}
	end
	local sorted = {}
	for _, part in collectionService:GetTagged('Hurtbox') do
		if part.Parent then
			local owner = part:FindFirstAncestorWhichIsA('Model')
			if owner and isEnemyOwner(owner) then
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
	if type(packed) ~= 'table' or packed.n < 2 or typeof(packed[2]) ~= 'string' then
		return
	end
	if isMeleeHurtboxFire(packed) or isMeleeSwingAction(packed[2]) then
		meleeTemplate = packed
	end
end

local function countPackedHurtboxes(packed)
	if type(packed) ~= 'table' or type(packed[5]) ~= 'table' then
		return 0
	end
	return #packed[5]
end

local function describeNearestEnemy(range, origin)
	local root = getLocalRoot()
	origin = origin or (root and root.Position)
	if not origin then
		return nil, nil, nil
	end
	local nearestPart, nearestDist, nearestName = nil, range, nil
	for _, part in collectionService:GetTagged('Hurtbox') do
		if part.Parent then
			local owner = part:FindFirstAncestorWhichIsA('Model')
			if owner and isEnemyOwner(owner) then
				local dist = (part.Position - origin).Magnitude
				if dist < nearestDist then
					nearestPart = part
					nearestDist = dist
					local plr = getPlayerFromModel(owner)
					nearestName = plr and plr.Name or owner.Name
				end
			end
		end
	end
	return nearestPart, nearestDist, nearestName
end

local function looksLikeHitboxModule(mod)
	if type(mod) ~= 'table' or type(mod.new) ~= 'function' or type(mod.cast) ~= 'function' then
		return false
	end
	local ok, instance = pcall(mod.new, {shape = 'Box', size = Vector3.new(1, 1, 1)})
	if not ok or type(instance) ~= 'table' then
		return false
	end
	return instance.shape == 'Box' and typeof(instance.size) == 'Vector3'
end

local function tryRequireHitboxModule(moduleScript, label)
	if not moduleScript then
		return nil, label .. ': ModuleScript missing'
	end
	local ok, mod = pcall(require, moduleScript)
	if not ok then
		return nil, label .. ': require failed (' .. tostring(mod) .. ')'
	end
	if not looksLikeHitboxModule(mod) then
		return nil, label .. ': table lacks Hitbox.new/cast signature'
	end
	return mod, label .. ': ' .. moduleScript:GetFullName()
end

local function discoverHitboxModule()
	local attempts = {}
	local assets = replicatedStorage:FindFirstChild('Assets')
	if not assets then
		table.insert(attempts, 'Assets folder missing under ReplicatedStorage')
	else
		local modules = assets:FindFirstChild('ModuleScripts')
		if not modules then
			table.insert(attempts, 'Assets.ModuleScripts missing')
		else
			local attackModule = modules:FindFirstChild('Attack')
			if attackModule then
				local hitboxModule = attackModule:FindFirstChild('Hitbox')
				local mod, detail = tryRequireHitboxModule(hitboxModule, 'Attack.Hitbox')
				if mod then
					return mod, detail, attempts
				end
				table.insert(attempts, detail)
			else
				table.insert(attempts, 'ModuleScripts.Attack missing')
				for _, child in modules:GetChildren() do
					if child:IsA('ModuleScript') and string.find(child.Name:lower(), 'attack', 1, true) then
						local hitboxChild = child:FindFirstChild('Hitbox')
						local mod, detail = tryRequireHitboxModule(hitboxChild, 'search:' .. child.Name .. '.Hitbox')
						if mod then
							return mod, detail, attempts
						end
						table.insert(attempts, detail)
					end
				end
			end
			for _, desc in modules:GetDescendants() do
				if desc:IsA('ModuleScript') and desc.Name == 'Hitbox' then
					local mod, detail = tryRequireHitboxModule(desc, 'descendant Hitbox')
					if mod then
						return mod, detail, attempts
					end
					table.insert(attempts, detail)
				end
			end
		end
	end
	if getgc then
		local gcOk, gc = pcall(getgc, true)
		if gcOk and type(gc) == 'table' then
			local gcHits = 0
			for _, value in gc do
				if looksLikeHitboxModule(value) then
					gcHits += 1
					if not hitboxReachHooked then
						return value, 'getgc table #' .. gcHits, attempts
					end
				end
			end
			table.insert(attempts, 'getgc scanned, Hitbox-like tables=' .. gcHits)
		else
			table.insert(attempts, 'getgc unavailable or failed')
		end
	else
		table.insert(attempts, 'getgc not supported by executor')
	end
	return nil, nil, attempts
end

local function augmentMeleePacket(packed)
	local action = packed[2]
	local beforeCount = countPackedHurtboxes(packed)
	if not reachActive then
		reachDebugSkip('reach_off', 'augment skipped (reach inactive)', 'action=', action)
		return packed
	end
	if not isLocalAlive() then
		reachDebugSkip('not_alive', 'augment skipped (local dead)', 'action=', action)
		return packed
	end
	if not isMeleeHurtboxFire(packed) then
		reachDebugSkip('not_melee_shape', 'augment skipped (not melee hurtbox packet)', 'action=', action, 'n=', packed.n)
		return packed
	end
	local root = getLocalRoot()
	if not root then
		reachDebugSkip('no_root', 'augment skipped (no HumanoidRootPart)')
		return packed
	end
	if reachExtend <= 0 then
		reachDebugSkip('extend_zero', 'augment skipped (Extend slider is 0)', 'extend=', reachExtend)
		return packed
	end
	local meleeReach = getMeleeReach()
	local extended = getEnemyHurtboxesInRange(meleeReach, root.Position)
	local nearestPart, nearestDist, nearestName = describeNearestEnemy(meleeReach, root.Position)
	if #extended == 0 then
		reachDebugLog(
			'augment: no enemy hurtboxes in range',
			'action=', action,
			'reach=', meleeReach,
			'extend=', reachExtend,
			'nearest=', nearestName or 'none',
			'nearestDist=', nearestDist and string.format('%.2f', nearestDist) or 'n/a',
			'taggedHurtboxes=', #collectionService:GetTagged('Hurtbox')
		)
		return packed
	end
	local aimDir = (extended[1].Position - root.Position).Unit
	local template = meleeTemplate
	packed[1] = packed[1] or (template and template[1]) or 'Redliner'
	packed[2] = packed[2] or (template and template[2]) or 'SWING'
	packed[3] = packed[3] or (template and template[3]) or ''
	packed[4] = packed[4] or aimDir
	if typeof(packed[4]) == 'Vector3' and packed[4].Magnitude > 0 then
		aimDir = packed[4].Unit
	end
	packed[5] = mergeHurtboxLists(packed[5], extended)
	packed[6] = packed[6] or (template and template[6])
	packed.n = math.max(packed.n, 5)
	reachDebugLog(
		'augment applied',
		'action=', packed[2],
		'aimDir=', aimDir,
		'extend=', reachExtend,
		'hurtboxes before=', beforeCount,
		'after=', countPackedHurtboxes(packed),
		'added=', #extended,
		'nearest=', nearestName,
		'nearestDist=', nearestDist and string.format('%.2f', nearestDist) or 'n/a',
		'meleeReach=', meleeReach
	)
	return packed
end

local function applyMeleeFireAugment(...)
	local packed = table.pack(...)
	captureMeleeTemplate(packed)
	local okAugment, augmented = pcall(augmentMeleePacket, packed)
	if okAugment then
		packed = augmented
	end
	return table.unpack(packed, 1, packed.n)
end

local function logMeleePacketFire(context, packet, ...)
	local n = select('#', ...)
	local action = select(2, ...)
	local packed = table.pack(...)
	reachDebugLog(
		context,
		'packet=', packet and packet.Name or '?',
		'action=', action,
		'n=', n,
		'hurtboxesIn=', countPackedHurtboxes(packed),
		'extend=', reachExtend,
		'totalReach=', getMeleeReach(),
		'reachActive=', reachActive
	)
end

local function wrapReachCallable(label, fn, wrapperFactory)
	if type(fn) ~= 'function' then
		return nil, label .. ': not a function'
	end
	local wrapper = wrapperFactory(fn)
	if hookfunction then
		local ok, original = pcall(hookfunction, fn, wrapper)
		if ok and type(original) == 'function' then
			return original, label .. ': hookfunction'
		end
	end
	return fn, label .. ': assign'
end

local function extendAttackHurtboxes(attack)
	if not reachActive or reachExtend <= 0 or type(attack) ~= 'table' then
		return 0
	end
	if type(attack.hit_hurtboxes) ~= 'table' then
		return 0
	end
	local root = getLocalRoot()
	if not root then
		return 0
	end
	local before = #attack.hit_hurtboxes
	local extended = getEnemyHurtboxesInRange(getMeleeReach(), root.Position)
	for _, part in extended do
		if not table.find(attack.hit_hurtboxes, part) then
			table.insert(attack.hit_hurtboxes, part)
		end
	end
	return #attack.hit_hurtboxes - before
end

local function looksLikeAttackModule(mod)
	return type(mod) == 'table'
		and type(mod.new) == 'function'
		and type(mod.castOnce) == 'function'
		and type(mod.addHitbox) == 'function'
end

local function discoverAttackModule()
	local assets = replicatedStorage:FindFirstChild('Assets')
	local modules = assets and assets:FindFirstChild('ModuleScripts')
	local attackModule = modules and modules:FindFirstChild('Attack')
	if attackModule then
		local ok, mod = pcall(require, attackModule)
		if ok and looksLikeAttackModule(mod) then
			return mod, 'Attack: ' .. attackModule:GetFullName()
		end
	end
	if getgc then
		local gcOk, gc = pcall(getgc, true)
		if gcOk and type(gc) == 'table' then
			for _, value in gc do
				if looksLikeAttackModule(value) then
					return value, 'getgc Attack-like table'
				end
			end
		end
	end
	return nil, nil
end

local function installAttackReachHook()
	if attackReachHooked then
		reachDebugSkip('attack_already', 'Attack.castOnce hook already installed at', reachAttackHookSource or '?')
		return true
	end
	local Attack, source = discoverAttackModule()
	if not Attack then
		reachDebugWarn('Attack hook FAILED — module not found')
		return false
	end
	local function wrapCast(methodName)
		local oldMethod = Attack[methodName]
		if type(oldMethod) ~= 'function' then
			return
		end
		local function makeWrapper(oldFn)
			return function(attack, ...)
				local results = oldFn(attack, ...)
				local added = extendAttackHurtboxes(attack)
				if reachDebugEnabled or (reachActive and reachExtend > 0) then
					reachDebugLog(
						methodName,
						'extend=', reachExtend,
						'totalReach=', getMeleeReach(),
						'added=', added,
						'hurtboxes=', type(attack.hit_hurtboxes) == 'table' and #attack.hit_hurtboxes or 0
					)
				end
				return results
			end
		end
		local wrapper = makeWrapper(oldMethod)
		local _, detail = wrapReachCallable('Attack.' .. methodName, oldMethod, makeWrapper)
		Attack[methodName] = wrapper
		reachDebugLog('Attack.' .. methodName, 'hook OK —', detail)
	end
	wrapCast('castOnce')
	wrapCast('castMore')
	wrapCast('castContinuous')
	attackReachHooked = true
	reachAttackHookSource = source
	reachDebugLog('Attack hook OK —', source)
	return true
end

local function buildHitboxCastWrapper(oldCast)
	return function(self)
		local shape = self.shape
		local origSize = self.size
		local origOffset = self.offset
		local taggedHurtboxes = #collectionService:GetTagged('Hurtbox')
		local extended = false
		local result
		if reachDebugEnabled then
			reachDebugLog(
				'Hitbox.cast called',
				'shape=', shape,
				'extend=', reachExtend,
				'totalReach=', getMeleeReach(),
				'reachActive=', reachActive
			)
		end
		if reachActive and reachExtend > 0 then
			local extra = reachExtend
			if shape == 'Box' and typeof(self.size) == 'Vector3' then
				local savedSize, savedOffset = self.size, self.offset
				self.size = Vector3.new(savedSize.X, savedSize.Y, savedSize.Z + extra)
				self.offset = savedOffset * CFrame.new(0, 0, extra * 0.5)
				result = oldCast(self)
				self.size = savedSize
				self.offset = savedOffset
				extended = true
				reachDebugLog(
					'cast Box extended',
					'origSize=', savedSize,
					'newSize=', Vector3.new(savedSize.X, savedSize.Y, savedSize.Z + extra),
					'extra=', extra,
					'partsHit=', #result,
					'taggedHurtboxes=', taggedHurtboxes
				)
				return result
			end
			if (shape == 'Cone' or shape == 'Sphere') and typeof(self.size) == 'number' then
				local savedSize = self.size
				self.size = savedSize + extra
				result = oldCast(self)
				self.size = savedSize
				extended = true
				reachDebugLog(
					'cast', shape, 'extended',
					'origRadius=', savedSize,
					'newRadius=', savedSize + extra,
					'partsHit=', #result,
					'taggedHurtboxes=', taggedHurtboxes
				)
				return result
			end
			reachDebugLog(
				'cast not extended (unsupported shape/size)',
				'shape=', shape,
				'sizeType=', typeof(self.size),
				'size=', origSize,
				'reachActive=', reachActive,
				'reachExtend=', reachExtend
			)
		elseif reachDebugEnabled then
			reachDebugSkip('cast_no_extend', 'cast without extension', 'shape=', shape, 'reachActive=', reachActive, 'extend=', reachExtend)
		end
		result = oldCast(self)
		if not extended and reachDebugEnabled then
			reachDebugLog('cast', shape, 'origSize=', origSize, 'partsHit=', #result, 'taggedHurtboxes=', taggedHurtboxes)
		end
		return result
	end
end

local function installHitboxReachHook()
	if hitboxReachHooked then
		reachDebugSkip('hitbox_already', 'Hitbox.cast hook already installed at', reachHitboxHookSource or '?')
		return true
	end
	local Hitbox, source, attempts = discoverHitboxModule()
	if not Hitbox then
		reachDebugWarn('Hitbox hook FAILED — no module found')
		for _, line in attempts do
			reachDebugWarn('  try:', line)
		end
		return false
	end
	local oldCast = Hitbox.cast
	local wrapper = buildHitboxCastWrapper(oldCast)
	local _, detail = wrapReachCallable('Hitbox.cast', oldCast, function(oldFn)
		return buildHitboxCastWrapper(oldFn)
	end)
	Hitbox.cast = wrapper
	hitboxReachHooked = true
	reachHitboxHookSource = source .. ' (' .. detail .. ')'
	reachDebugLog('Hitbox.cast hook OK —', reachHitboxHookSource)
	if getgc then
		local gcOk, gc = pcall(getgc, true)
		if gcOk and type(gc) == 'table' then
			local extraHits = 0
			for _, value in gc do
				if value ~= Hitbox and looksLikeHitboxModule(value) and value.cast == oldCast then
					value.cast = wrapper
					extraHits += 1
				end
			end
			if extraHits > 0 then
				reachDebugLog('Hitbox.cast mirrored to', extraHits, 'getgc tables')
			end
		end
	end
	return true
end

local function installPacketMetatableHook()
	if packetMetatableHooked then
		reachDebugSkip('meta_already', 'Packet metatable Fire hook already installed')
		return true
	end
	if not initPackets() then
		return false
	end
	local packet = Packets[MELEE_PACKET_NAME]
	if not packet then
		return false
	end
	local mt = getmetatable(packet)
	if not mt or type(mt.Fire) ~= 'function' then
		reachDebugWarn('Packet metatable Fire hook FAILED — metatable missing Fire')
		return false
	end
	if mt._reachFireHooked then
		packetMetatableHooked = true
		return true
	end
	local oldFire = mt.Fire
	local function wrappedFire(firePacket, ...)
		if isMeleePacketObject(firePacket) then
			logMeleePacketFire('packet Fire (meta)', firePacket, ...)
			local before = countPackedHurtboxes(table.pack(...))
			local augmented = table.pack(applyMeleeFireAugment(...))
			local ok, result = pcall(oldFire, firePacket, table.unpack(augmented, 1, augmented.n))
			if reachDebugEnabled then
				reachDebugLog(
					'packet Fire post-augment (meta)',
					'action=', augmented[2],
					'before=', before,
					'after=', countPackedHurtboxes(augmented)
				)
			end
			if ok then
				return result
			end
			reachDebugWarn('packet Fire (meta) pcall failed:', result)
			error(result, 0)
		end
		return oldFire(firePacket, ...)
	end
	local _, detail = wrapReachCallable('Packet.Fire', oldFire, function()
		return wrappedFire
	end)
	mt.Fire = wrappedFire
	mt._reachFireHooked = true
	packetMetatableHooked = true
	reachDebugLog('Packet metatable Fire hook OK —', detail, 'remote=', MELEE_PACKET_REMOTE)
	return true
end

local function installMeleePacketHook()
	if meleeHooked then
		reachDebugSkip('packet_already', 'melee packet hook already installed')
		return true
	end
	if not initPackets() then
		reachDebugWarn('packet hook FAILED — initPackets() returned false (Assets/ModuleScripts/Packets?)')
		return false
	end
	local packet = Packets[MELEE_PACKET_NAME]
	if not packet then
		local keys = {}
		for key in Packets do
			if type(key) == 'string' and string.sub(key, 1, 1) == '_' then
				table.insert(keys, key)
			end
		end
		table.sort(keys)
		reachDebugWarn(
			'packet hook FAILED — Packets[' .. MELEE_PACKET_NAME .. '] missing',
			'obfuscatedKeys=', table.concat(keys, ', ')
		)
		return false
	end
	if packet._reachHooked then
		meleeHooked = true
		meleePacketHooked = true
		reachDebugSkip('packet_flag', 'packet already marked _reachHooked')
		return true
	end
	packet._reachHooked = true
	meleeHooked = true
	meleePacketHooked = true
	local oldFire = packet.Fire
	if type(oldFire) ~= 'function' then
		reachDebugWarn('packet hook FAILED — packet.Fire is not a function')
		return false
	end
	local function wrappedFire(self, ...)
		logMeleePacketFire('packet Fire (inst)', self, ...)
		local before = countPackedHurtboxes(table.pack(...))
		local augmented = table.pack(applyMeleeFireAugment(...))
		local ok, result = pcall(oldFire, self, table.unpack(augmented, 1, augmented.n))
		if reachDebugEnabled then
			reachDebugLog(
				'packet Fire post-augment (inst)',
				'action=', augmented[2],
				'before=', before,
				'after=', countPackedHurtboxes(augmented)
			)
		end
		if ok then
			return result
		end
		reachDebugWarn('packet Fire (inst) pcall failed:', result)
		error(result, 0)
	end
	local _, detail = wrapReachCallable('meleePacket.Fire', oldFire, function()
		return wrappedFire
	end)
	packet.Fire = wrappedFire
	reachDebugLog('packet instance hook OK —', MELEE_PACKET_NAME, detail)
	return true
end

local function installMeleeReachHook()
	installHitboxReachHook()
	installAttackReachHook()
	installPacketMetatableHook()
	installMeleePacketHook()
end

local function logReachHookStatus(context)
	if not reachDebugEnabled then
		return
	end
	reachDebugLog(
		'hook status (' .. context .. ')',
		'reachActive=', reachActive,
		'extend=', reachExtend,
		'totalReach=', getMeleeReach(),
		'hitboxHook=', hitboxReachHooked,
		'hitboxSource=', reachHitboxHookSource or 'none',
		'attackHook=', attackReachHooked,
		'attackSource=', reachAttackHookSource or 'none',
		'packetHook=', meleePacketHooked,
		'packetMetaHook=', packetMetatableHooked,
		'meleeTemplate=', meleeTemplate ~= nil,
		'packetsLoaded=', Packets ~= nil,
		'hookfunction=', hookfunction ~= nil
	)
end

local function bindPacketListeners()
	if not initPackets() then
		return
	end
	installMeleeReachHook()
end

-- ---------------------------------------------------------------------------
-- Auto attack
-- ---------------------------------------------------------------------------

local function pressAttackClick()
	if tick() < parryBlockAttackUntil then
		return false
	end
	if tick() - lastParryAt < 0.15 then
		return false
	end
	if not isGameWindowFocused() then
		return false
	end

	if mouse1click then
		pcall(mouse1click)
		lastAttackAt = tick()
		debugLog('attack', 'lmb')
		return true
	end

	local mousePos = inputService:GetMouseLocation()
	pcall(function()
		virtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, true, game, 1)
	end)
	task.defer(function()
		pcall(function()
			virtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, false, game, 1)
		end)
	end)

	lastAttackAt = tick()
	debugLog('attack', 'lmb')
	return true
end

local function scanMeleeWhitelistRealtime()
	local root = getLocalRoot()
	if not root then
		return
	end
	for _, plr in playersService:GetPlayers() do
		if plr == lplr then
			continue
		end
		local ownerChar = plr.Character
		if not ownerChar then
			continue
		end
		if getClosestEnemyDistance(plr) > meleeRangeSetting then
			continue
		end
		for _, model in getEnemyModels(plr) do
			if not model or not model.Parent then
				continue
			end
			local enemyRoot = model:FindFirstChild('HumanoidRootPart')
			if not enemyRoot then
				continue
			end
			local dist = (enemyRoot.Position - root.Position).Magnitude
			if dist > meleeRangeSetting then
				continue
			end
			for _, track in getAllPlayingTracks(model) do
				if not track.IsPlaying then
					continue
				end
				local _, animId = getTrackAnimInfo(track)
				if getParryAnimKind(animId) == 'melee' and track.TimePosition <= meleeSwingWindowSetting then
					handleMeleeAnimation(ownerChar, track, 'scan', model)
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
		local now = tick()
		if now - lastParryScanAt < PARRY_SCAN_INTERVAL then
			return
		end
		lastParryScanAt = now
		scanMeleeWhitelistRealtime()
	end)
end

local function getNearestEnemyInAttackRange(attackRange)
	local root = getLocalRoot()
	if not root then
		return nil
	end
	local origin = root.Position
	local nearestModel, nearestDist = nil, attackRange
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			for _, model in getEnemyModels(plr) do
				if model and model.Parent then
					local enemyRoot = model:FindFirstChild('HumanoidRootPart')
					if enemyRoot then
						local dist = (enemyRoot.Position - origin).Magnitude
						if dist <= attackRange and dist < nearestDist then
							nearestModel = model
							nearestDist = dist
						end
					end
				end
			end
		end
	end
	return nearestModel
end

local function tryAutoAttack(attackDelay)
	if not autoAttackActive or not isLocalAlive() then
		return
	end
	if not isGameWindowFocused() then
		return
	end
	if tick() < parryBlockAttackUntil then
		return
	end
	if tick() - lastParryAt < 0.15 then
		return
	end

	local interval = attackDelay > 0 and attackDelay or AUTO_ATTACK_MIN_DELAY
	if tick() - lastAttackAt < interval then
		return
	end

	if not getNearestEnemyInAttackRange(autoAttackRangeSetting) then
		return
	end

	pressAttackClick()
end

local function bindAutoAttackLoop()
	if autoAttackLoopBound then
		return
	end
	autoAttackLoopBound = true
	runService.RenderStepped:Connect(function()
		if not autoAttackActive then
			return
		end
		tryAutoAttack(attackDelaySetting)
	end)
end

local function combatHeartbeat(meleeRange)
	meleeRangeSetting = meleeRange
	if reachActive or reachDebugEnabled or autoParryActive then
		bindPacketListeners()
	end

	if reachDebugEnabled and tick() - lastReachDebugHeartbeat > 2 then
		lastReachDebugHeartbeat = tick()
		local root = getLocalRoot()
		local meleeReach = getMeleeReach()
		local nearbyCount = 0
		if root then
			nearbyCount = #getEnemyHurtboxesInRange(meleeReach, root.Position)
		end
		local _, nearestDist, nearestName = describeNearestEnemy(meleeReach, root and root.Position)
		reachDebugLog(
			'heartbeat',
			'active=', reachActive,
			'extend=', reachExtend,
			'totalReach=', meleeReach,
			'hitboxHook=', hitboxReachHooked,
			'attackHook=', attackReachHooked,
			'packetHook=', meleePacketHooked,
			'packetMetaHook=', packetMetatableHooked,
			'hitboxSource=', reachHitboxHookSource or 'none',
			'attackSource=', reachAttackHookSource or 'none',
			'alive=', isLocalAlive(),
			'rootPos=', root and tostring(root.Position) or 'nil',
			'nearbyEnemyHurtboxes=', nearbyCount,
			'nearestEnemy=', nearestName or 'none',
			'nearestDist=', nearestDist and string.format('%.2f', nearestDist) or 'n/a',
			'taggedHurtboxes=', #collectionService:GetTagged('Hurtbox')
		)
		if (reachActive or reachDebugEnabled) and (not hitboxReachHooked or not meleePacketHooked or not packetMetatableHooked or not attackReachHooked) then
			bindPacketListeners()
			logReachHookStatus('heartbeat retry')
		end
	end

	if not isLocalAlive() then
		return
	end

	if autoParryActive then
		bindParryScanLoop()
		refreshThreatWatchers(false)

		if debugEnabled and tick() - lastDebugHeartbeat > 3 then
			lastDebugHeartbeat = tick()
			local enemyCount, watchedCount, threatCount = 0, 0, 0
			for _, plr in playersService:GetPlayers() do
				if plr ~= lplr and plr.Character then
					enemyCount += 1
					if charWatchers[plr.Character] then
						watchedCount += 1
					end
					if getClosestEnemyDistance(plr) <= getEffectiveWatcherRange() then
						threatCount += 1
					end
				end
			end
			print('[REDLINER] status | enemies=', enemyCount, 'watched=', watchedCount, 'inThreat=', threatCount, 'meleeRange=', meleeRange, 'threatRange=', threatRangeSetting)
		end
	end
end

local function cleanupEnemyState(model)
	unwatchAllForPlayer(getPlayerFromModel(model) or playersService:GetPlayerFromCharacter(model))
end

-- ---------------------------------------------------------------------------
-- Animation Logger (file dump for ID identification)
-- ---------------------------------------------------------------------------

local AnimLog = {
	active = false,
	logLocal = false,
	logEnemies = true,
	filePath = '',
}

run(function()
local animLogBuffer = {}
local animLogBufferChars = 0
local animLogLastFlush = 0
local animLogWatchers = {}
local animLogGlobalConns = {}
local animLogEventCount = 0
local animLogFlushToken = 0
local animLogMirrorConsole = false
local animLogLastWriteError = ''

local function animLogGetExecutorName()
	if identifyexecutor then
		local ok, name = pcall(identifyexecutor)
		if ok and name then
			return tostring(name)
		end
	end
	return 'executor'
end

local function animLogCanWrite()
	return type(writefile) == 'function'
end

local function animLogEnsureFolder()
	if type(makefolder) ~= 'function' or type(isfolder) ~= 'function' then
		return true
	end
	local ok = pcall(function()
		if not isfolder('newvape') then
			makefolder('newvape')
		end
		if not isfolder('newvape/redliner') then
			makefolder('newvape/redliner')
		end
	end)
	return ok
end

local function animLogVerifyFile(path)
	return type(isfile) == 'function' and isfile(path)
end

local function animLogAppendFile(text, path)
	path = path or AnimLog.filePath
	if not animLogCanWrite() or path == '' then
		animLogLastWriteError = 'writefile unavailable'
		return false, animLogLastWriteError
	end
	animLogEnsureFolder()

	local ok, err
	if type(appendfile) == 'function' then
		ok, err = pcall(appendfile, path, text)
	else
		local existing = ''
		if type(readfile) == 'function' and animLogVerifyFile(path) then
			pcall(function()
				existing = readfile(path)
			end)
		end
		ok, err = pcall(writefile, path, existing .. text)
	end

	if not ok then
		animLogLastWriteError = tostring(err)
		return false, animLogLastWriteError
	end
	if not animLogVerifyFile(path) then
		animLogLastWriteError = 'write returned ok but isfile=false (check ' .. animLogGetExecutorName() .. ' workspace, not this repo folder)'
		return false, animLogLastWriteError
	end
	animLogLastWriteError = ''
	return true
end

local function animLogWriteFile(text, path)
	path = path or AnimLog.filePath
	if not animLogCanWrite() or path == '' then
		animLogLastWriteError = 'writefile unavailable'
		return false, animLogLastWriteError
	end
	animLogEnsureFolder()
	local ok, err = pcall(writefile, path, text)
	if not ok then
		animLogLastWriteError = tostring(err)
		return false, animLogLastWriteError
	end
	if not animLogVerifyFile(path) then
		animLogLastWriteError = 'write returned ok but isfile=false (check ' .. animLogGetExecutorName() .. ' workspace, not this repo folder)'
		return false, animLogLastWriteError
	end
	animLogLastWriteError = ''
	return true
end

local function animLogFlush(force)
	if animLogBufferChars == 0 then
		return
	end
	if not force and tick() - animLogLastFlush < 1.5 then
		return
	end
	local chunk = table.concat(animLogBuffer)
	table.clear(animLogBuffer)
	animLogBufferChars = 0
	animLogLastFlush = tick()
	local ok, err = animLogAppendFile(chunk)
	if not ok then
		animLogMirrorConsole = true
		warn('[REDLINER] anim log flush failed:', err)
		print(chunk)
	end
end

local function animLogQueue(text)
	if animLogMirrorConsole then
		print(text)
	end
	table.insert(animLogBuffer, text)
	animLogBufferChars += #text
	if animLogBufferChars >= 12000 then
		animLogFlush(true)
	end
end

local function animLogWriteLine(...)
	local parts = {}
	for i = 1, select('#', ...) do
		table.insert(parts, tostring(select(i, ...)))
	end
	animLogQueue(table.concat(parts, ' ') .. '\n')
end

local function animLogWriteBlock(lines)
	for _, line in lines do
		animLogQueue(line .. '\n')
	end
	animLogQueue('\n')
end

local function animLogGetFilePath()
	return 'newvape/redliner/' .. tostring(game.PlaceId) .. '_anim_log.txt'
end

local function animLogKnownLabel(normId)
	if PARRY_ANIM_IDS[normId] then
		return 'parry:' .. PARRY_ANIM_IDS[normId]
	end
	if GUN_DRAW_ANIM_IDS[normId] then
		return 'gun_draw:' .. GUN_DRAW_ANIM_IDS[normId]
	end
	if GUN_SHOT_ANIM_IDS[normId] then
		return 'gun_shot:' .. GUN_SHOT_ANIM_IDS[normId]
	end
	if BLOCKED_ANIM_IDS[normId] then
		return 'blocked:' .. BLOCKED_ANIM_IDS[normId]
	end
	return ''
end

local function animLogShouldLogPlayer(plr)
	if not plr then
		return AnimLog.logEnemies
	end
	if plr == lplr then
		return AnimLog.logLocal
	end
	return AnimLog.logEnemies
end

local function animLogSafeNumber(value, digits)
	if typeof(value) ~= 'number' then
		return 'n/a'
	end
	if digits then
		return string.format('%.' .. digits .. 'f', value)
	end
	return tostring(value)
end

local function animLogFormatTrackEvent(char, plr, track, eventName)
	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local root = char:FindFirstChild('HumanoidRootPart')
	local horizVel = 0
	if root then
		local vel = root.AssemblyLinearVelocity
		horizVel = Vector3.new(vel.X, 0, vel.Z).Magnitude
	end
	local known = animLogKnownLabel(normId)
	local lines = {
		'=== ' .. string.upper(eventName) .. ' #' .. animLogEventCount .. ' ===',
		'time=' .. string.format('%.3f', tick()),
		'event=' .. eventName,
		'player=' .. (plr and plr.Name or 'npc') .. (plr == lplr and ' (local)' or (plr and ' (enemy)' or '')),
		'character=' .. char.Name,
		'anim_name=' .. name,
		'anim_id=' .. (animId ~= '' and animId or 'n/a'),
		'norm_id=' .. (normId ~= '' and normId or 'n/a'),
		'known=' .. (known ~= '' and known or '-'),
		'priority=' .. tostring(track.Priority),
		'weight=' .. animLogSafeNumber(track.WeightCurrent, 3),
		'weight_target=' .. animLogSafeNumber(track.WeightTarget, 3),
		'time_pos=' .. animLogSafeNumber(track.TimePosition, 3),
		'length=' .. animLogSafeNumber(track.Length, 3),
		'speed=' .. animLogSafeNumber(track.Speed, 3),
		'is_playing=' .. tostring(track.IsPlaying),
		'looped=' .. tostring(track.Looped),
	}
	if plr ~= lplr then
		lines[#lines + 1] = 'dist=' .. animLogSafeNumber(getClosestEnemyDistance(char), 2)
		local hrpDot = getGunAimDotFromModel(char)
		local need = getEffectiveGunAimThreshold(getClosestEnemyDistance(char))
		lines[#lines + 1] = 'gun_hrp_dot=' .. animLogSafeNumber(hrpDot, 3) .. ' need=' .. animLogSafeNumber(need, 2)
		lines[#lines + 1] = 'aim_dot=' .. animLogSafeNumber(getAimDot(char), 3)
	end
	lines[#lines + 1] = 'horiz_vel=' .. animLogSafeNumber(horizVel, 2)
	lines[#lines + 1] = 'gun_equipped=' .. tostring(charHasGunEquipped(char))
	lines[#lines + 1] = 'gun=' .. detectEquippedGun(char)
	local anim = track.Animation
	if anim then
		lines[#lines + 1] = 'animation_parent=' .. anim.Parent:GetFullName()
	end
	return lines
end

local function animLogOnTrackEvent(char, plr, track, eventName)
	if not AnimLog.active then
		return
	end
	animLogEventCount += 1
	animLogWriteBlock(animLogFormatTrackEvent(char, plr, track, eventName))
end

local function animLogHookAnimator(animator, ownerChar, ownerPlr, conns)
	table.insert(conns, animator.AnimationPlayed:Connect(function(track)
		animLogOnTrackEvent(ownerChar, ownerPlr, track, 'played')
		pcall(function()
			track.Stopped:Once(function()
				if AnimLog.active then
					animLogOnTrackEvent(ownerChar, ownerPlr, track, 'stopped')
				end
			end)
		end)
	end))
end

local function animLogHookModel(model, ownerChar, ownerPlr, conns)
	for _, desc in model:GetDescendants() do
		if desc:IsA('Animator') then
			animLogHookAnimator(desc, ownerChar, ownerPlr, conns)
		end
	end
	table.insert(conns, model.DescendantAdded:Connect(function(inst)
		if inst:IsA('Animator') then
			animLogHookAnimator(inst, ownerChar, ownerPlr, conns)
		end
	end))
end

local function animLogUnwatch(key)
	local conns = animLogWatchers[key]
	if conns then
		for _, conn in conns do
			conn:Disconnect()
		end
	end
	animLogWatchers[key] = nil
end

local function animLogWatchCharacter(char, ownerPlr)
	if not char or not animLogShouldLogPlayer(ownerPlr) then
		return
	end
	local key = char
	if animLogWatchers[key] then
		return
	end
	local conns = {}
	animLogWatchers[key] = conns
	local ownerChar = (ownerPlr and ownerPlr.Character) or char
	animLogHookModel(char, ownerChar, ownerPlr, conns)
	if ownerPlr then
		for _, extraModel in getEnemyModels(ownerPlr) do
			if extraModel ~= char then
				animLogHookModel(extraModel, ownerChar, ownerPlr, conns)
			end
		end
	end
end

local function animLogWatchPlayer(plr)
	if not animLogShouldLogPlayer(plr) then
		return
	end
	if plr.Character then
		animLogWatchCharacter(plr.Character, plr)
	end
	if plr ~= lplr then
		for _, model in getEnemyModels(plr) do
			if model ~= plr.Character then
				animLogWatchCharacter(model, plr)
			end
		end
	end
end

local function animLogRefreshWatchers()
	for key in animLogWatchers do
		animLogUnwatch(key)
	end
	if AnimLog.logLocal then
		animLogWatchPlayer(lplr)
	end
	if AnimLog.logEnemies then
		for _, plr in playersService:GetPlayers() do
			if plr ~= lplr then
				animLogWatchPlayer(plr)
			end
		end
	end
end

local function animLogStopWatchers()
	for key in animLogWatchers do
		animLogUnwatch(key)
	end
	for _, conn in animLogGlobalConns do
		conn:Disconnect()
	end
	table.clear(animLogGlobalConns)
end

local function animLogStartWatchers()
	animLogStopWatchers()
	animLogRefreshWatchers()

	table.insert(animLogGlobalConns, playersService.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function()
			task.defer(function()
				if AnimLog.active then
					animLogWatchPlayer(plr)
				end
			end)
		end)
		task.defer(function()
			if AnimLog.active then
				animLogWatchPlayer(plr)
			end
		end)
	end))

	table.insert(animLogGlobalConns, playersService.PlayerRemoving:Connect(function(plr)
		if plr.Character then
			animLogUnwatch(plr.Character)
		end
		for _, model in getEnemyModels(plr) do
			animLogUnwatch(model)
		end
	end))

	for _, plr in playersService:GetPlayers() do
		plr.CharacterAdded:Connect(function()
			task.defer(function()
				if AnimLog.active then
					animLogWatchPlayer(plr)
				end
			end)
		end)
	end

	animLogFlushToken += 1
	local token = animLogFlushToken
	task.spawn(function()
		while AnimLog.active and token == animLogFlushToken do
			animLogFlush(false)
			task.wait(1.5)
		end
	end)
end

local function animLogScanAnimations(root, pathPrefix, out)
	for _, inst in root:GetDescendants() do
		if inst:IsA('Animation') then
			local normId = normalizeAnimId(inst.AnimationId)
			local fullPath = pathPrefix .. inst:GetFullName()
			table.insert(out, {
				path = fullPath,
				name = inst.Name,
				animId = inst.AnimationId,
				normId = normId,
				known = animLogKnownLabel(normId),
			})
		end
	end
end

local function animLogDumpCatalog()
	if not animLogCanWrite() then
		notif('Animation Logger', 'writefile not available in this executor.', 6, 'warning')
		return '', 'writefile unavailable'
	end

	animLogEnsureFolder()
	if AnimLog.filePath == '' then
		AnimLog.filePath = animLogGetFilePath()
	end
	local path = AnimLog.filePath
	local entries = {}
	local roots = {
		{root = replicatedStorage:FindFirstChild('Assets'), prefix = ''},
		{root = replicatedStorage, prefix = ''},
		{root = workspace:FindFirstChild('Chrono_EntityStorage'), prefix = ''},
	}
	for _, entry in roots do
		if entry.root then
			animLogScanAnimations(entry.root, entry.prefix, entries)
		end
	end

	table.sort(entries, function(a, b)
		return a.normId < b.normId or (a.normId == b.normId and a.path < b.path)
	end)

	local lines = {
		'################################################################################',
		'# ANIMATION CATALOG DUMP',
		'# place=' .. tostring(game.PlaceId),
		'# time=' .. os.date('%Y-%m-%d %H:%M:%S'),
		'# total=' .. #entries,
		'################################################################################',
	}
	local seenIds = {}
	for _, entry in entries do
		local idKey = entry.normId .. '|' .. entry.name
		if not seenIds[idKey] then
			seenIds[idKey] = true
			lines[#lines + 1] = string.format(
				'[CATALOG] path=%s | name=%s | id=%s | norm_id=%s | known=%s',
				entry.path,
				entry.name,
				entry.animId ~= '' and entry.animId or 'n/a',
				entry.normId ~= '' and entry.normId or 'n/a',
				entry.known ~= '' and entry.known or '-'
			)
		end
	end
	lines[#lines + 1] = ''
	lines[#lines + 1] = '# End catalog'
	lines[#lines + 1] = ''

	local text = table.concat(lines, '\n')
	local ok, err = animLogAppendFile(text, path)
	if not ok then
		warn('[REDLINER] catalog dump failed:', err)
		print(text)
		return path, err
	end
	return path
end

local function animLogBeginSession(clearFile)
	if not animLogCanWrite() then
		notif('Animation Logger', 'writefile not available in this executor.', 6, 'warning')
		return false, 'writefile unavailable'
	end
	animLogEnsureFolder()
	AnimLog.filePath = animLogGetFilePath()
	animLogEventCount = 0
	animLogMirrorConsole = false
	local header = table.concat({
		'',
		'################################################################################',
		'# REDLINER Animation Log',
		'# place=' .. tostring(game.PlaceId),
		'# started=' .. os.date('%Y-%m-%d %H:%M:%S'),
		'# local=' .. lplr.Name,
		'# log_local=' .. tostring(AnimLog.logLocal),
		'# log_enemies=' .. tostring(AnimLog.logEnemies),
		'# file=' .. AnimLog.filePath,
		'# executor=' .. animLogGetExecutorName(),
		'################################################################################',
		'',
	}, '\n')
	local ok, err
	if clearFile then
		ok, err = animLogWriteFile(header, AnimLog.filePath)
	else
		ok, err = animLogAppendFile(header, AnimLog.filePath)
	end
	if not ok then
		animLogMirrorConsole = true
		warn('[REDLINER] anim log file write failed:', err)
		notif('Animation Logger', 'File write failed — mirroring to console. ' .. err, 10, 'warning')
		print(header)
		return true, err
	end
	local catalogPath, catalogErr = animLogDumpCatalog()
	if catalogErr then
		return true, catalogErr
	end
	print('[REDLINER] Animation Logger | wrote test OK | executor=' .. animLogGetExecutorName() .. ' | file=' .. AnimLog.filePath)
	return true
end

local function animLogStop()
	animLogWriteLine('# session ended', os.date('%Y-%m-%d %H:%M:%S'), 'events=' .. animLogEventCount)
	animLogFlush(true)
	AnimLog.active = false
	animLogStopWatchers()
end


AnimLog.beginSession = animLogBeginSession
AnimLog.stop = animLogStop
AnimLog.startWatchers = animLogStartWatchers
AnimLog.refreshWatchers = animLogRefreshWatchers
AnimLog.dumpCatalog = animLogDumpCatalog
AnimLog.flush = animLogFlush
AnimLog.getFilePath = animLogGetFilePath
AnimLog.getExecutorName = animLogGetExecutorName
end)

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
				logParryAnimIds()
				bindLocalRespawnHandler()
				startEnemyWatchers()
				bindParryScanLoop()
				bindPacketListeners()
				notif('Auto Parry', '360° within threat range — melee + gun draw/shot (proximity gated).', 5)
			end
		end,
		Tooltip = 'Parries nearby enemy melee swings and gun draw/shot animations (360° within Melee/Threat range).',
	})

	AutoAttack = minigames:CreateModule({
		Name = 'Auto Attack',
		Function = function(callback)
			autoAttackActive = callback
			if callback then
				bindAutoAttackLoop()
				notif('Auto Attack', 'Active — LMB when enemies are in range (game window must be focused).', 4)
			end
		end,
		Tooltip = 'Left clicks when an enemy is within Attack Range. Only fires while Roblox is focused. Pauses while parrying.',
	})

	Reach = minigames:CreateModule({
		Name = 'Reach',
		Function = function(callback)
			reachActive = callback
			if callback then
				bindPacketListeners()
				logReachHookStatus('enabled')
				reachDebugLog('Reach ENABLED — extend=', reachExtend, 'totalReach=', getMeleeReach())
				notif('Reach', 'Extends melee hitboxes + packet hurtbox list. Swing once manually first if needed.', 5)
			else
				reachExtend = 0
				reachDebugLog('Reach DISABLED')
				logReachHookStatus('disabled')
			end
		end,
		Tooltip = 'Hooks Attack.Hitbox.cast, Attack.castOnce, and melee packet ' .. MELEE_PACKET_NAME .. ' / ' .. MELEE_PACKET_REMOTE .. ' (base ' .. BASE_SWORD_REACH .. ' studs + Extend slider).',
	})

	MeleeRange = AutoParry:CreateSlider({
		Name = 'Melee Range',
		Min = 4,
		Max = 30,
		Default = AUTO_PARRY_DEFAULTS.meleeRange,
		Function = function(val)
			meleeRangeSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = '360° melee parry radius. Default 20 studs.',
	})

	local ThreatRange
	local WatcherThreatRange
	local MeleeEnemyDebounce
	local GunEnemyDebounce
	local ThreatDebug

	ThreatRange = AutoParry:CreateSlider({
		Name = 'Threat Range',
		Min = 12,
		Max = 200,
		Default = AUTO_PARRY_DEFAULTS.threatRange,
		Function = function(val)
			threatRangeSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Gun draw/shot/glint parry radius. Enemy must be aiming at you (Gun Aim Dot). Default 100 studs.',
	})

	WatcherThreatRange = AutoParry:CreateSlider({
		Name = 'Watcher Range',
		Min = 20,
		Max = 200,
		Default = AUTO_PARRY_DEFAULTS.watcherThreatRange,
		Function = function(val)
			watcherThreatRangeSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Anim/glint watcher attach radius. Effective range is max of this, Threat Range, and Melee Range.',
	})

	MeleeEnemyDebounce = AutoParry:CreateSlider({
		Name = 'Melee Enemy Debounce',
		Min = 0.05,
		Max = 0.6,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.meleeEnemyDebounce,
		Function = function(val)
			meleeEnemyDebounceSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Per-enemy cooldown between melee parry triggers. Lower = faster re-parry in crowded fights.',
	})

	GunEnemyDebounce = AutoParry:CreateSlider({
		Name = 'Gun Enemy Debounce',
		Min = 0.1,
		Max = 0.6,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.gunEnemyDebounce,
		Function = function(val)
			gunEnemyDebounceSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Per-enemy cooldown between gun parry triggers (blocks duplicate anim/glint edges).',
	})

	local ParryMelee
	local ParryGunDraw
	local ParryGunShot
	local ParryGlint
	local MeleeAimDot
	local GunAimDot
	local ParryCooldown
	local CloseRangeStuds
	local MeleeSwingWindow
	local GunDrawWindow
	local GunShotWindow
	local CastigateDelay
	local PhoenixDelay
	local SiegeDelay
	local MonarchDelay

	ParryMelee = AutoParry:CreateToggle({
		Name = 'Parry Melee',
		Default = AUTO_PARRY_DEFAULTS.parryMelee,
		Function = function(callback)
			parryMeleeEnabled = callback
		end,
	})

	ParryGunDraw = AutoParry:CreateToggle({
		Name = 'Parry Gun Draw',
		Default = AUTO_PARRY_DEFAULTS.parryGunDraw,
		Function = function(callback)
			parryGunDrawEnabled = callback
		end,
	})

	ParryGunShot = AutoParry:CreateToggle({
		Name = 'Parry Gun Shot',
		Default = AUTO_PARRY_DEFAULTS.parryGunShot,
		Function = function(callback)
			parryGunShotEnabled = callback
		end,
	})

	ParryGlint = AutoParry:CreateToggle({
		Name = 'Glint Backup',
		Default = AUTO_PARRY_DEFAULTS.parryGlint,
		Function = function(callback)
			parryGlintEnabled = callback
		end,
		Tooltip = 'Fallback draw parry when glint VFX spawns.',
	})

	MeleeAimDot = AutoParry:CreateSlider({
		Name = 'Melee Aim Dot',
		Min = 0.1,
		Max = 0.9,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.meleeAimDot,
		Function = function(val)
			meleeAimDotSetting = val
		end,
		Tooltip = 'How directly enemies must face you for melee parry.',
	})

	GunAimDot = AutoParry:CreateSlider({
		Name = 'Gun Aim Dot',
		Min = 0.5,
		Max = 0.95,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.gunAimDot,
		Function = function(val)
			gunAimDotSetting = val
		end,
		Tooltip = 'HRP must face you (flat dot). Default 0.80 ≈ 37° cone; stricter at long range. 0.95 ≈ 18°.',
	})

	ParryCooldown = AutoParry:CreateSlider({
		Name = 'Parry Cooldown',
		Min = 0.02,
		Max = 0.5,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.parryCooldown,
		Function = function(val)
			parryCooldownSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	CloseRangeStuds = AutoParry:CreateSlider({
		Name = 'Close Range Guard',
		Min = 0,
		Max = 8,
		Decimal = 10,
		Default = AUTO_PARRY_DEFAULTS.closeRangeStuds,
		Function = function(val)
			closeRangeStudsSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Within this range, require a confirmed attack anim before parrying.',
	})

	MeleeSwingWindow = AutoParry:CreateSlider({
		Name = 'Melee Swing Window',
		Min = 0.2,
		Max = 1,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.meleeSwingWindow,
		Function = function(val)
			meleeSwingWindowSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	GunDrawWindow = AutoParry:CreateSlider({
		Name = 'Gun Draw Window',
		Min = 0.1,
		Max = 1.2,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.gunDrawWindow,
		Function = function(val)
			gunDrawWindowSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	GunShotWindow = AutoParry:CreateSlider({
		Name = 'Gun Shot Window',
		Min = 0.05,
		Max = 0.4,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.gunShotWindow,
		Function = function(val)
			gunShotWindowSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	CastigateDelay = AutoParry:CreateSlider({
		Name = 'Castigate Draw Delay',
		Min = 0.05,
		Max = 0.90,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.castigateDelay,
		Function = function(val)
			gunParryDelays.Castigate = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Seconds after revolver draw starts to press parry.',
	})

	PhoenixDelay = AutoParry:CreateSlider({
		Name = 'Phoenix Draw Delay',
		Min = 0.05,
		Max = 1.2,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.phoenixDelay,
		Function = function(val)
			gunParryDelays.Phoenix = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	SiegeDelay = AutoParry:CreateSlider({
		Name = 'Siege Draw Delay',
		Min = 0.05,
		Max = 1.5,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.siegeDelay,
		Function = function(val)
			gunParryDelays.Siege = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	MonarchDelay = AutoParry:CreateSlider({
		Name = 'Monarch Draw Delay',
		Min = 0.05,
		Max = 2.2,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.monarchDelay,
		Function = function(val)
			gunParryDelays.Monarch = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	local function setToggleDefault(toggle, enabled)
		if toggle and toggle.Enabled ~= enabled then
			toggle:Toggle()
		end
	end

	local function applyAutoParryDefaults()
		local d = AUTO_PARRY_DEFAULTS
		meleeRangeSetting = d.meleeRange
		threatRangeSetting = d.threatRange
		watcherThreatRangeSetting = d.watcherThreatRange
		meleeEnemyDebounceSetting = d.meleeEnemyDebounce
		gunEnemyDebounceSetting = d.gunEnemyDebounce
		threatDebugEnabled = d.threatDebug
		meleeAimDotSetting = d.meleeAimDot
		gunAimDotSetting = d.gunAimDot
		meleeParryCooldownSetting = d.meleeParryCooldown
		parryCooldownSetting = d.parryCooldown
		meleeSwingWindowSetting = d.meleeSwingWindow
		gunDrawWindowSetting = d.gunDrawWindow
		gunShotWindowSetting = d.gunShotWindow
		closeRangeStudsSetting = d.closeRangeStuds
		gunParryDelays.Castigate = d.castigateDelay
		gunParryDelays.Phoenix = d.phoenixDelay
		gunParryDelays.Siege = d.siegeDelay
		gunParryDelays.Monarch = d.monarchDelay
		parryMeleeEnabled = d.parryMelee
		parryGunDrawEnabled = d.parryGunDraw
		parryGunShotEnabled = d.parryGunShot
		parryGlintEnabled = d.parryGlint

		MeleeRange:SetValue(d.meleeRange)
		ThreatRange:SetValue(d.threatRange)
		WatcherThreatRange:SetValue(d.watcherThreatRange)
		MeleeEnemyDebounce:SetValue(d.meleeEnemyDebounce)
		GunEnemyDebounce:SetValue(d.gunEnemyDebounce)
		MeleeAimDot:SetValue(d.meleeAimDot)
		GunAimDot:SetValue(d.gunAimDot)
		ParryCooldown:SetValue(d.parryCooldown)
		CloseRangeStuds:SetValue(d.closeRangeStuds)
		MeleeSwingWindow:SetValue(d.meleeSwingWindow)
		GunDrawWindow:SetValue(d.gunDrawWindow)
		GunShotWindow:SetValue(d.gunShotWindow)
		CastigateDelay:SetValue(d.castigateDelay)
		PhoenixDelay:SetValue(d.phoenixDelay)
		SiegeDelay:SetValue(d.siegeDelay)
		MonarchDelay:SetValue(d.monarchDelay)
		setToggleDefault(ParryMelee, d.parryMelee)
		setToggleDefault(ParryGunDraw, d.parryGunDraw)
		setToggleDefault(ParryGunShot, d.parryGunShot)
		setToggleDefault(ParryGlint, d.parryGlint)
		setToggleDefault(ThreatDebug, d.threatDebug)
	end

	ExtendReach = Reach:CreateSlider({
		Name = 'Extend',
		Min = 0,
		Max = 12,
		Default = 4,
		Function = function(val)
			reachExtend = val
			reachDebugLog('Extend slider=', val, 'totalReach=', getMeleeReach())
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Added on top of base ' .. BASE_SWORD_REACH .. ' stud sword reach.',
	})

	Reach:CreateToggle({
		Name = 'Reach Debug',
		Default = false,
		Function = function(callback)
			reachDebugEnabled = callback
			if callback then
				print('[REDLINER][Reach] debug ON — swing sword near an enemy and watch console')
				bindPacketListeners()
				logReachHookStatus('debug toggled on')
			else
				print('[REDLINER][Reach] debug OFF')
				table.clear(lastReachDebugSkipAt)
			end
		end,
		Tooltip = 'Prints [REDLINER][Reach] hook install, hitbox cast, packet augment, and heartbeat logs to console.',
	})

	AttackCooldown = AutoAttack:CreateSlider({
		Name = 'Attack Delay',
		Min = 0,
		Max = 1,
		Decimal = 100,
		Default = 0.38,
		Function = function(val)
			attackDelaySetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Seconds between LMB clicks. 0 = every frame (~60/s). Pauses briefly after parry.',
	})

	AutoAttack:CreateSlider({
		Name = 'Attack Range',
		Min = 4,
		Max = 30,
		Default = AUTO_ATTACK_RANGE_DEFAULT,
		Function = function(val)
			autoAttackRangeSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Max distance to an enemy before Auto Attack sends LMB.',
	})

	Debug = AutoParry:CreateToggle({
		Name = 'Debug',
		Function = function(callback)
			debugEnabled = callback
			if callback then
				logParryAnimIds(true)
				print('[REDLINER] debug on | alive=', isLocalAlive(), 'autoParry=', autoParryActive, 'threatRange=', threatRangeSetting, 'castigateDelay=', gunParryDelays.Castigate)
			else
				table.clear(lastDebugAnimAt)
			end
		end,
	})

	ThreatDebug = AutoParry:CreateToggle({
		Name = 'Threat Debug',
		Default = AUTO_PARRY_DEFAULTS.threatDebug,
		Function = function(callback)
			threatDebugEnabled = callback
			if callback then
				print('[REDLINER] threat debug on | meleeRange=', meleeRangeSetting, 'threatRange=', threatRangeSetting, 'watcherRange=', watcherThreatRangeSetting, 'effectiveWatcher=', getEffectiveWatcherRange(), 'gunAimDot=', gunAimDotSetting, 'meleeDebounce=', meleeEnemyDebounceSetting, 'gunDebounce=', gunEnemyDebounceSetting)
			else
				table.clear(lastDebugSkipAt)
			end
		end,
		Tooltip = 'Log skip reasons: out_of_range, not_aiming, wrong_enemy, cooldown.',
	})

	TestParry = AutoParry:CreateToggle({
		Name = 'Test Parry',
		Function = function(callback)
			if callback then
				if canSafelyParry() then
					task.defer(pressParryKey)
				end
				task.defer(function()
					if TestParry.Enabled then
						TestParry:Toggle(true)
					end
				end)
			end
		end,
		Tooltip = 'Sends one F key press when alive. Use to verify parry works.',
	})

	AutoParry:CreateButton({
		Name = 'Reset to Defaults',
		Function = function()
			applyAutoParryDefaults()
			notif('Auto Parry', 'Settings reset to defaults.', 4)
		end,
		Tooltip = 'Restore all Auto Parry sliders and toggles to recommended defaults.',
	})

	local AnimLogger
	AnimLogger = minigames:CreateModule({
		Name = 'Animation Logger',
		Function = function(callback)
			if callback then
				local ok, err = AnimLog.beginSession(false)
				if not ok then
					return
				end
				AnimLog.active = true
				AnimLog.startWatchers()
				if err then
					notif('Animation Logger', 'File write failed — logging to console. ' .. err, 10, 'warning')
				else
					notif('Animation Logger', AnimLog.filePath .. ' (' .. AnimLog.getExecutorName() .. ' workspace)', 8)
				end
			else
				AnimLog.stop()
			end
		end,
		Tooltip = 'Writes played animations to a text file. File is in your executor workspace, not this repo folder.',
	})

	AnimLogger:CreateToggle({
		Name = 'Log Local',
		Default = false,
		Function = function(callback)
			AnimLog.logLocal = callback
			if AnimLog.active then
				AnimLog.refreshWatchers()
			end
		end,
		Tooltip = 'Include your own character animations in the log.',
	})

	AnimLogger:CreateToggle({
		Name = 'Log Enemies',
		Default = true,
		Function = function(callback)
			AnimLog.logEnemies = callback
			if AnimLog.active then
				AnimLog.refreshWatchers()
			end
		end,
		Tooltip = 'Include enemy player animations in the log.',
	})

	AnimLogger:CreateButton({
		Name = 'Dump Catalog',
		Function = function()
			local path, err = AnimLog.dumpCatalog()
			if err then
				notif('Animation Logger', 'Catalog dump failed — check console. ' .. err, 8, 'warning')
			else
				notif('Animation Logger', 'Catalog written to ' .. path, 6)
			end
		end,
		Tooltip = 'Scan ReplicatedStorage/workspace for Animation instances and append to log.',
	})

	AnimLogger:CreateButton({
		Name = 'New Session',
		Function = function()
			local ok, err = AnimLog.beginSession(true)
			if not ok then
				return
			end
			if AnimLog.active then
				AnimLog.startWatchers()
			end
			if err then
				notif('Animation Logger', 'New session (console mirror). ' .. err, 8, 'warning')
			else
				notif('Animation Logger', 'New session: ' .. AnimLog.filePath, 6)
			end
		end,
		Tooltip = 'Clears the log file and writes a fresh header + catalog.',
	})

	AnimLogger:CreateButton({
		Name = 'Flush Now',
		Function = function()
			AnimLog.flush(true)
			notif('Animation Logger', 'Buffer flushed to ' .. (AnimLog.filePath ~= '' and AnimLog.filePath or AnimLog.getFilePath()), 4)
		end,
		Tooltip = 'Immediately write buffered events to the log file.',
	})

	local combatBound = false
	local function bindCombatLoop()
		if combatBound then
			return
		end
		combatBound = true
		bindLocalRespawnHandler()
		bindAutoAttackLoop()

		runService.Heartbeat:Connect(function()
			if not AutoParry.Enabled and not AutoAttack.Enabled and not Reach.Enabled and not reachDebugEnabled then
				return
			end
			combatHeartbeat(MeleeRange.Value)
		end)

		playersService.PlayerRemoving:Connect(function(plr)
			unwatchAllForPlayer(plr)
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
