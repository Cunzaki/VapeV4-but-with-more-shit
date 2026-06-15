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

local MELEE_AIM_DOT = 0.32
local GUN_AIM_DOT = 0.32
local CLOSE_RANGE_STUDS = 3
local MELEE_SWING_MIN_TIME = 0
local MELEE_SWING_MAX_TIME = 0.55
local MELEE_PARRY_DELAY = 0.2
local GUN_SHOT_MAX_TIME = 0.15
local GUN_DRAW_EDGE_MAX_TIME = 0.45
local DASH_VELOCITY_MIN = 20

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

local GUN_DRAW_TIMES = {
	Castigate = 0.75,
	Phoenix = 0.80,
	Siege = 1.10,
	Monarch = 1.85,
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
local castigateParryDelay = 0.36
local myHurtboxes = {}
local enemyStates = {}
local charWatchers = {}
local watchersStarted = false
local meleeTemplate = nil
local meleeHooked = false
local lastParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local attackPressToken = 0
local lastDebugHeartbeat = 0
local lastDebugSkipAt = {}
local lastDebugAnimAt = {}
local parryIdsLogged = false
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
			lastDrawId = '',
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
		if track.IsPlaying and track.WeightCurrent >= 0.15 then
			local _, animId = getTrackAnimInfo(track)
			local kind = getParryAnimKind(animId)
			if kind then
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
	if gunName == 'Castigate' then
		return castigateParryDelay
	end
	return math.max(0.02, (GUN_DRAW_TIMES[gunName] or 0.75) - 0.14)
end

local function scheduleGunDrawParry(char, gunName, normId, timePosition, source, track)
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
		if not autoParryActive or token ~= state.scheduledDrawToken then
			return
		end
		if not char.Parent or not isLocalAlive() then
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
		if not shouldParryGun(char, true) then
			debugSkip('gun_draw_aim', char.Name, gunName, string.format('%.2f', getAimDot(char)))
			return
		end
		debugLog('trigger', 'gun_draw_timed_' .. gunName, normId, string.format('%.2f', getAimDot(char)))
		tryParry('gun_draw_' .. gunName .. '_' .. normId)
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
	if not isParryMeleeAnim(animId) then
		debugSkip('not_whitelisted', name, normId, source)
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

local function handleGunDrawAnimation(char, track, source)
	source = source or 'edge'
	if not track.IsPlaying or track.WeightCurrent < 0.05 then
		debugSkip('gun_draw_low_weight', getTrackAnimInfo(track), source)
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local gunName = GUN_DRAW_ANIM_IDS[normId]
	if not gunName then
		return
	end
	if track.TimePosition > GUN_DRAW_EDGE_MAX_TIME then
		debugSkip('gun_draw_late', name, string.format('%.2f', track.TimePosition), source)
		return
	end
	if not shouldParryGun(char, true) then
		debugSkip('gun_draw_aim_edge', name, string.format('%.2f', getAimDot(char)), source)
		return
	end

	scheduleGunDrawParry(char, gunName, normId, track.TimePosition, source, track)
end

local function handleGunShotAnimation(char, track, source)
	source = source or 'edge'
	if not track.IsPlaying or track.WeightCurrent < 0.08 then
		debugSkip('gun_shot_low_weight', getTrackAnimInfo(track), source)
		return
	end

	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local gunName = GUN_SHOT_ANIM_IDS[normId]
	if not gunName then
		return
	end
	if track.TimePosition > GUN_SHOT_MAX_TIME then
		debugSkip('gun_shot_late', name, string.format('%.2f', track.TimePosition), source)
		return
	end
	if not shouldParryGun(char, true) then
		debugSkip('gun_shot_aim', name, string.format('%.2f', getAimDot(char)), source)
		return
	end
	if not charHasGunEquipped(char) then
		debugSkip('gun_shot_no_gun', name, normId, source)
		return
	end

	local state = getEnemyState(char)
	local shotKey = normId .. ':gun_shot'
	if state.lastShotId == shotKey then
		return
	end
	state.lastShotId = shotKey
	track.Stopped:Once(function()
		if state.lastShotId == shotKey then
			state.lastShotId = ''
		end
	end)

	debugLog('trigger', 'gun_shot_' .. gunName, normId, 'aim=' .. string.format('%.2f', getAimDot(char)), source)
	tryParry('gun_shot_' .. gunName .. '_' .. normId)
end

local function handleGlintSpawn(char, inst)
	if not isGlintInstance(inst) then
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
	if not shouldParryGun(char, true) then
		debugSkip('glint_aim', inst.Name, string.format('%.2f', getAimDot(char)))
		return
	end
	local gunName = detectEquippedGun(char)
	debugLog('trigger', 'gun_glint', gunName, 'aim=' .. string.format('%.2f', getAimDot(char)))
	scheduleGunDrawParry(char, gunName, 'glint:' .. gunName, 0, 'glint')
end

local function onEnemyAnimationPlayed(char, track)
	if not autoParryActive or not isLocalAlive() then
		return
	end
	local name, animId = getTrackAnimInfo(track)
	local normId = normalizeAnimId(animId)
	local kind = getParryAnimKind(animId)
	if debugEnabled then
		if BLOCKED_ANIM_IDS[normId] then
			debugAnimLog('blocked', normId, BLOCKED_ANIM_IDS[normId], 'w=' .. string.format('%.2f', track.WeightCurrent))
		elseif kind or track.WeightCurrent >= 0.35 then
			debugAnimLog('played', name, 'id=' .. normId, kind or '-', 'w=' .. string.format('%.2f', track.WeightCurrent))
		end
	end
	if kind == 'melee' then
		handleMeleeAnimation(char, track, 'edge')
	elseif kind == 'gun_draw' then
		handleGunDrawAnimation(char, track, 'edge')
	elseif kind == 'gun_shot' then
		handleGunShotAnimation(char, track, 'edge')
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
					local _, animId = getTrackAnimInfo(track)
					local kind = getParryAnimKind(animId)
					if kind == 'melee' and meleeDist <= meleeRangeSetting and track.TimePosition <= MELEE_SWING_MAX_TIME then
						handleMeleeAnimation(ownerChar, track, 'scan')
					elseif kind == 'gun_draw' and track.TimePosition <= GUN_DRAW_EDGE_MAX_TIME then
						handleGunDrawAnimation(ownerChar, track, 'scan')
					elseif kind == 'gun_shot' and track.TimePosition <= GUN_SHOT_MAX_TIME then
						handleGunShotAnimation(ownerChar, track, 'scan')
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
	for _, track in getAllPlayingTracksForChar(char) do
		if track.IsPlaying and track.WeightCurrent >= 0.08 then
			local _, animId = getTrackAnimInfo(track)
			local kind = getParryAnimKind(animId)
			if kind == 'melee' and getEnemyDistance(char) <= meleeRange and shouldParryMelee(char, true) then
				return true
			end
			if (kind == 'gun_draw' or kind == 'gun_shot') and shouldParryGun(char, true) then
				return true
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
-- Animation Logger (file dump for ID identification)
-- ---------------------------------------------------------------------------

local animLogActive = false
local animLogLocal = false
local animLogEnemies = true
local animLogFilePath = ''
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
	path = path or animLogFilePath
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
	path = path or animLogFilePath
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
		return animLogEnemies
	end
	if plr == lplr then
		return animLogLocal
	end
	return animLogEnemies
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
		lines[#lines + 1] = 'dist=' .. animLogSafeNumber(getEnemyDistance(char), 2)
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
	if not animLogActive then
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
				if animLogActive then
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
	if animLogLocal then
		animLogWatchPlayer(lplr)
	end
	if animLogEnemies then
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
				if animLogActive then
					animLogWatchPlayer(plr)
				end
			end)
		end)
		task.defer(function()
			if animLogActive then
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
				if animLogActive then
					animLogWatchPlayer(plr)
				end
			end)
		end)
	end

	animLogFlushToken += 1
	local token = animLogFlushToken
	task.spawn(function()
		while animLogActive and token == animLogFlushToken do
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
	if animLogFilePath == '' then
		animLogFilePath = animLogGetFilePath()
	end
	local path = animLogFilePath
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
	animLogFilePath = animLogGetFilePath()
	animLogEventCount = 0
	animLogMirrorConsole = false
	local header = table.concat({
		'',
		'################################################################################',
		'# REDLINER Animation Log',
		'# place=' .. tostring(game.PlaceId),
		'# started=' .. os.date('%Y-%m-%d %H:%M:%S'),
		'# local=' .. lplr.Name,
		'# log_local=' .. tostring(animLogLocal),
		'# log_enemies=' .. tostring(animLogEnemies),
		'# file=' .. animLogFilePath,
		'# executor=' .. animLogGetExecutorName(),
		'################################################################################',
		'',
	}, '\n')
	local ok, err
	if clearFile then
		ok, err = animLogWriteFile(header, animLogFilePath)
	else
		ok, err = animLogAppendFile(header, animLogFilePath)
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
	print('[REDLINER] Animation Logger | wrote test OK | executor=' .. animLogGetExecutorName() .. ' | file=' .. animLogFilePath)
	return true
end

local function animLogStop()
	animLogWriteLine('# session ended', os.date('%Y-%m-%d %H:%M:%S'), 'events=' .. animLogEventCount)
	animLogFlush(true)
	animLogActive = false
	animLogStopWatchers()
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
				logParryAnimIds()
				startEnemyWatchers()
				bindParryScanLoop()
				bindPacketListeners()
				notif('Auto Parry', 'Melee + gun draw/shot parry when enemies aim at you.', 5)
			end
		end,
		Tooltip = 'Parries melee swings and gun draw/shot animations when enemies aim at you.',
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

	CastigateDelay = AutoParry:CreateSlider({
		Name = 'Castigate Parry Delay',
		Min = 0.05,
		Max = 0.90,
		Decimal = 100,
		Default = 0.36,
		Function = function(val)
			castigateParryDelay = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Seconds after revolver draw starts to press parry. Lower = earlier.',
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
				logParryAnimIds(true)
				print('[REDLINER] debug on | alive=', isLocalAlive(), 'autoParry=', autoParryActive, 'castigateDelay=', castigateParryDelay)
			else
				table.clear(lastDebugAnimAt)
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

	local AnimLogger
	AnimLogger = minigames:CreateModule({
		Name = 'Animation Logger',
		Function = function(callback)
			if callback then
				local ok, err = animLogBeginSession(false)
				if not ok then
					return
				end
				animLogActive = true
				animLogStartWatchers()
				if err then
					notif('Animation Logger', 'File write failed — logging to console. ' .. err, 10, 'warning')
				else
					notif('Animation Logger', animLogFilePath .. ' (' .. animLogGetExecutorName() .. ' workspace)', 8)
				end
			else
				animLogStop()
			end
		end,
		Tooltip = 'Writes played animations to a text file. File is in your executor workspace, not this repo folder.',
	})

	AnimLogger:CreateToggle({
		Name = 'Log Local',
		Default = false,
		Function = function(callback)
			animLogLocal = callback
			if animLogActive then
				animLogRefreshWatchers()
			end
		end,
		Tooltip = 'Include your own character animations in the log.',
	})

	AnimLogger:CreateToggle({
		Name = 'Log Enemies',
		Default = true,
		Function = function(callback)
			animLogEnemies = callback
			if animLogActive then
				animLogRefreshWatchers()
			end
		end,
		Tooltip = 'Include enemy player animations in the log.',
	})

	AnimLogger:CreateButton({
		Name = 'Dump Catalog',
		Function = function()
			local path, err = animLogDumpCatalog()
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
			local ok, err = animLogBeginSession(true)
			if not ok then
				return
			end
			if animLogActive then
				animLogStartWatchers()
			end
			if err then
				notif('Animation Logger', 'New session (console mirror). ' .. err, 8, 'warning')
			else
				notif('Animation Logger', 'New session: ' .. animLogFilePath, 6)
			end
		end,
		Tooltip = 'Clears the log file and writes a fresh header + catalog.',
	})

	AnimLogger:CreateButton({
		Name = 'Flush Now',
		Function = function()
			animLogFlush(true)
			notif('Animation Logger', 'Buffer flushed to ' .. (animLogFilePath ~= '' and animLogFilePath or animLogGetFilePath()), 4)
		end,
		Tooltip = 'Immediately write buffered events to the log file.',
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
		notif('REDLINER', 'Minigames: Auto Parry, Auto Attack, Reach, Animation Logger ready.', 5)
	end)
end)
