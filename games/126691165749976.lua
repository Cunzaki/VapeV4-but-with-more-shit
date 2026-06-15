--[[
	REDLINER shared game script (MAIN + FFA + MATCH place IDs).
	Place IDs: 94987506187454 (main), 115875349872417 (FFA), 126691165749976 (match).
	Auto Parry, Auto Attack, Reach (melee packet extension).
	Infinite Heat, Infinite Grapple.
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
local HEAT_PACKET_NAME = '_xdb2548bded1dd8e3'
local GRAPPLE_PACKET_NAME = '_xefd6d8e74acc7f88'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'
local DASH_VELOCITY_MIN = 20
local GRAPPLE_MAX_CHARGES = 2
local HEAT_UNRELIABLE_PACKETS = {
	'_x6b11fde7f06edda2',
	'_xb6e64d336fe43aa7',
	'_xbd2cb2a1aa5e781f',
	'_xb881b1d13c8068a4',
}
local HEAT_STATE_KEYS = {
	'heat',
	'Heat',
	'currentHeat',
	'current_heat',
	'bulletHeat',
	'bullets',
	'Bullets',
	'_heat',
	'ammo',
	'Ammo',
}
local HEAT_MAX_KEYS = {
	'maxHeat',
	'max_heat',
	'MaxHeat',
	'maxBullets',
}
local GRAPPLE_STATE_KEYS = {
	'uses',
	'Uses',
	'charges',
	'Charges',
	'remaining',
	'remainingUses',
	'_uses',
	'useCount',
}
local GRAPPLE_MAX_KEYS = {
	'maxUses',
	'max_uses',
	'maxCharges',
	'max_charges',
}

local AUTO_PARRY_DEFAULTS = {
	meleeRange = 20,
	meleeParryDelay = 0.2,
	meleeAimDot = 0.32,
	gunAimDot = 0.32,
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
local debugEnabled = false
local meleeRangeSetting = AUTO_PARRY_DEFAULTS.meleeRange
local meleeParryDelaySetting = AUTO_PARRY_DEFAULTS.meleeParryDelay
local meleeAimDotSetting = AUTO_PARRY_DEFAULTS.meleeAimDot
local gunAimDotSetting = AUTO_PARRY_DEFAULTS.gunAimDot
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
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local attackPressToken = 0
local lastDebugHeartbeat = 0
local lastDebugSkipAt = {}
local lastDebugAnimAt = {}
local parryIdsLogged = false
local parryScanBound = false
local tryParry
local infiniteHeatActive = false
local infiniteGrappleActive = false
local heatValueSetting = 200
local heatRateSetting = 0.25
local grappleRangeSetting = 120
local grappleRateSetting = 0.2
local grappleAutoFire = false
local grappleHoldOnly = true
local augmentHeld = false
local lastHeatAt = 0
local lastGrappleAt = 0
local mapMain = nil
local utilityHooksInstalled = false
local utilityIncomingHooked = false
local utilityLoopBound = false
local lastUtilityReadyWarn = 0
local utilityHookLogged = {
	heat = false,
	grapple = false,
}
local heatStateRefs = {}
local grappleStateRefs = {}
local lastHeatGcScan = 0
local lastGrappleGcScan = 0
local packetTemplates = {
	grapple = nil,
	gun = nil,
}

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
-- Character helpers (must be above utility/grapple — forward refs break)
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

local bindUtilityLoop
local installUtilityPacketHooks
run(function()
local function getMapMain()
	if mapMain and mapMain.Parent then
		return mapMain
	end
	local map = workspaceService:FindFirstChild('Map')
	mapMain = map and map:FindFirstChild('Main')
	return mapMain
end

local function getMapRayParams()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.IgnoreWater = true
	local main = getMapMain()
	params.FilterDescendantsInstances = main and {main} or {}
	return params
end

local function isPacketReady(packet)
	return packet ~= nil and packet.Id ~= nil
end

local function capturePacketTemplate(packed, key)
	if key and packed and packed.n and packed.n > 0 then
		packetTemplates[key] = packed
	end
end

local function logUtilityHookOnce(kind, message)
	if utilityHookLogged[kind] then
		return
	end
	utilityHookLogged[kind] = true
	print('[REDLINER]', message)
	debugLog(kind, message)
end

local function transformIncomingHeat(...)
	local n = select('#', ...)
	if n == 0 then
		return
	end
	local args = table.pack(...)
	local maxHeat = heatValueSetting
	if args.n >= 2 and type(args[2]) == 'number' then
		maxHeat = math.max(maxHeat, args[2])
		args[2] = maxHeat
	end
	for i = 1, args.n do
		if type(args[i]) == 'number' then
			args[i] = maxHeat
		end
	end
	return table.unpack(args, 1, args.n)
end

local function hookIncomingPacketSignal(packet, tag, transformFn, enabledFn)
	if not packet or not packet.OnClientEvent or packet['_utilityIncoming_' .. tag] then
		return false
	end
	local signal = packet.OnClientEvent
	local oldFire = signal.Fire
	signal.Fire = function(sig, ...)
		if enabledFn() then
			return oldFire(sig, transformFn(...))
		end
		return oldFire(sig, ...)
	end
	packet['_utilityIncoming_' .. tag] = true
	return true
end

local function installIncomingUtilityHooks()
	if utilityIncomingHooked then
		return true
	end
	if not initPackets() then
		return false
	end

	local hooked = 0
	if hookIncomingPacketSignal(Packets[HEAT_PACKET_NAME], 'heat', transformIncomingHeat, function()
		return infiniteHeatActive
	end) then
		hooked += 1
	end

	local unreliable = Packets.unreliablePackets
	if unreliable then
		for _, packetName in HEAT_UNRELIABLE_PACKETS do
			if hookIncomingPacketSignal(unreliable[packetName], 'heat_' .. packetName, transformIncomingHeat, function()
				return infiniteHeatActive
			end) then
				hooked += 1
			end
		end
	end

	if hooked > 0 then
		logUtilityHookOnce('heat', 'Infinite Heat: hooked ' .. hooked .. ' incoming heat sync packet(s)')
		utilityIncomingHooked = true
	end
	return utilityIncomingHooked
end

local function rememberHeatState(state)
	if table.find(heatStateRefs, state) then
		return
	end
	for _, key in HEAT_STATE_KEYS do
		if type(rawget(state, key)) == 'number' then
			table.insert(heatStateRefs, state)
			return
		end
	end
end

local function rememberGrappleState(state)
	if table.find(grappleStateRefs, state) then
		return
	end

	local itemId = rawget(state, 'item_id') or rawget(state, 'itemId')
	if itemId == 'Grappler' then
		table.insert(grappleStateRefs, state)
		return
	end

	for _, key in GRAPPLE_STATE_KEYS do
		local uses = rawget(state, key)
		if type(uses) == 'number' and uses >= 0 and uses <= GRAPPLE_MAX_CHARGES + 1 then
			table.insert(grappleStateRefs, state)
			return
		end
	end
end

local function scanClientStateTables()
	if not getgc then
		return
	end

	local now = tick()
	if infiniteHeatActive and now - lastHeatGcScan >= 2 then
		lastHeatGcScan = now
		for _, obj in getgc(true) do
			if type(obj) == 'table' then
				rememberHeatState(obj)
			end
		end
	end

	if infiniteGrappleActive and now - lastGrappleGcScan >= 2 then
		lastGrappleGcScan = now
		local before = #grappleStateRefs
		for _, obj in getgc(true) do
			if type(obj) == 'table' then
				rememberGrappleState(obj)
			end
		end
		if #grappleStateRefs > before then
			logUtilityHookOnce('grapple', 'Infinite Grapple: found ' .. #grappleStateRefs .. ' client charge state table(s)')
		end
	end
end

local function freezeHeatState()
	local maxHeat = heatValueSetting
	for _, state in heatStateRefs do
		if type(state) == 'table' then
			for _, key in HEAT_MAX_KEYS do
				local cap = rawget(state, key)
				if type(cap) == 'number' and cap > maxHeat then
					maxHeat = cap
				end
			end
		end
	end

	for _, state in heatStateRefs do
		if type(state) == 'table' then
			for _, key in HEAT_STATE_KEYS do
				local val = rawget(state, key)
				if type(val) == 'number' and val < maxHeat then
					rawset(state, key, maxHeat)
				end
			end
			for _, key in HEAT_MAX_KEYS do
				local val = rawget(state, key)
				if type(val) == 'number' and val < maxHeat then
					rawset(state, key, maxHeat)
				end
			end
		end
	end
end

local function freezeGrappleState()
	for _, state in grappleStateRefs do
		if type(state) == 'table' then
			for _, key in GRAPPLE_STATE_KEYS do
				if rawget(state, key) ~= nil then
					rawset(state, key, GRAPPLE_MAX_CHARGES)
				end
			end
			for _, key in GRAPPLE_MAX_KEYS do
				if rawget(state, key) ~= nil then
					rawset(state, key, GRAPPLE_MAX_CHARGES)
				end
			end
		end
	end
end

installUtilityPacketHooks = function()
	if utilityHooksInstalled then
		installIncomingUtilityHooks()
		return true
	end
	if not initPackets() then
		return false
	end

	local grapplePacket = Packets[GRAPPLE_PACKET_NAME]
	local gunPacket = Packets[GUN_PACKET_NAME]
	if not grapplePacket and not gunPacket and not Packets[HEAT_PACKET_NAME] then
		return false
	end

	if grapplePacket and not grapplePacket._utilityCaptureHooked then
		local oldGrappleFire = grapplePacket.Fire
		grapplePacket.Fire = function(self, ...)
			local packed = table.pack(...)
			capturePacketTemplate(packed, 'grapple')
			return oldGrappleFire(self, ...)
		end
		grapplePacket._utilityCaptureHooked = true
	end

	if gunPacket and not gunPacket._utilityCaptureHooked then
		local oldGunFire = gunPacket.Fire
		gunPacket.Fire = function(self, ...)
			local packed = table.pack(...)
			capturePacketTemplate(packed, 'gun')
			if infiniteHeatActive and packed.n >= 5 and type(packed[5]) == 'number' then
				packed[5] = 0
			end
			return oldGunFire(self, table.unpack(packed, 1, packed.n))
		end
		gunPacket._utilityCaptureHooked = true
	end

	installIncomingUtilityHooks()
	utilityHooksInstalled = true
	return true
end

local function utilityPacketsReady()
	if not initPackets() then
		return false
	end
	if grappleAutoFire and infiniteGrappleActive and not isPacketReady(Packets[GRAPPLE_PACKET_NAME]) then
		return false
	end
	return true
end

local function warnUtilityNotReady()
	if tick() - lastUtilityReadyWarn < 8 then
		return
	end
	lastUtilityReadyWarn = tick()
	notif('REDLINER', 'Auto grapple waiting for packet IDs — grapple manually once.', 6, 'warning')
end

local function setHeat(value)
	if not initPackets() then
		return false
	end
	installUtilityPacketHooks()
	local packet = Packets[HEAT_PACKET_NAME]
	if not isPacketReady(packet) then
		return false
	end
	task.spawn(function()
		pcall(function()
			packet:Fire(value)
		end)
	end)
	return true
end

local function fireGrappleTowardLook(range)
	if not isLocalAlive() or not initPackets() then
		return false
	end
	installUtilityPacketHooks()

	local packet = Packets[GRAPPLE_PACKET_NAME]
	if not isPacketReady(packet) then
		return false
	end

	local root = getLocalRoot()
	local camera = workspaceService.CurrentCamera
	if not root or not camera then
		return false
	end

	local look = camera.CFrame.LookVector
	local hit = workspaceService:Raycast(root.Position, look * range, getMapRayParams())
	local target = hit and hit.Position or (root.Position + look * range)
	local template = packetTemplates.grapple
	local itemId = template and template[1] or 'Grappler'
	local tag = template and template[4] or ''

	task.spawn(function()
		pcall(function()
			packet:Fire(itemId, root.Position, target, tag)
		end)
	end)
	return true
end

local function utilityHeartbeat()
	if not isLocalAlive() then
		return
	end

	if not infiniteHeatActive and not infiniteGrappleActive then
		return
	end

	installUtilityPacketHooks()
	scanClientStateTables()

	if infiniteHeatActive then
		freezeHeatState()
		local now = tick()
		if now - lastHeatAt >= heatRateSetting then
			lastHeatAt = now
			setHeat(heatValueSetting)
		end
		if not utilityHookLogged.heat then
			logUtilityHookOnce('heat', 'Infinite Heat: state freeze active (packets + client tables)')
		end
	end

	if infiniteGrappleActive then
		freezeGrappleState()
		if not utilityHookLogged.grapple then
			logUtilityHookOnce('grapple', 'Infinite Grapple: charge freeze active at ' .. GRAPPLE_MAX_CHARGES)
		end

		if grappleAutoFire then
			if not utilityPacketsReady() then
				warnUtilityNotReady()
			else
				local now = tick()
				if now - lastGrappleAt >= grappleRateSetting then
					if not grappleHoldOnly or augmentHeld then
						lastGrappleAt = now
						fireGrappleTowardLook(grappleRangeSetting)
					end
				end
			end
		end
	end
end

bindUtilityLoop = function()
	if utilityLoopBound then
		return
	end
	utilityLoopBound = true

	inputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonX then
			augmentHeld = true
		end
	end)

	inputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonX then
			augmentHeld = false
		end
	end)

	runService.Heartbeat:Connect(function()
		if not infiniteHeatActive and not infiniteGrappleActive then
			return
		end
		local ok, err = pcall(utilityHeartbeat)
		if not ok then
			warn('[REDLINER] utility error:', err)
		end
	end)

end)

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
	if not confirmedAttack and dist < closeRangeStudsSetting and not charHasWhitelistAttackPlaying(char) then
		debugSkip('close_range_no_attack', char.Name, string.format('%.1f', dist))
		return false
	end
	return getAimDot(char) >= minDot
end

local function shouldParryMelee(char, confirmedAttack)
	if not parryMeleeEnabled then
		return false
	end
	if getEnemyDistance(char) > meleeRangeSetting then
		return false
	end
	if not isEnemyTargetingMe(char, meleeAimDotSetting, confirmedAttack) then
		return false
	end
	return true
end

local function shouldParryGun(char, confirmedAttack)
	if not parryGunDrawEnabled and not parryGunShotEnabled then
		return false
	end
	return isEnemyTargetingMe(char, gunAimDotSetting, confirmedAttack)
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
	if tick() - lastParryAt < parryCooldownSetting then
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

	local delay = math.max(0, meleeParryDelaySetting - track.TimePosition)
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
	if not shouldParryGun(char, true) then
		debugSkip('gun_draw_aim_edge', name, string.format('%.2f', getAimDot(char)), source)
		return
	end

	scheduleGunDrawParry(char, gunName, normId, track.TimePosition, source, track)
end

local function handleGunShotAnimation(char, track, source)
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
	if not parryGlintEnabled or not parryGunDrawEnabled then
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
	if kind == 'melee' and parryMeleeEnabled then
		handleMeleeAnimation(char, track, 'edge')
	elseif kind == 'gun_draw' and parryGunDrawEnabled then
		handleGunDrawAnimation(char, track, 'edge')
	elseif kind == 'gun_shot' and parryGunShotEnabled then
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
	installUtilityPacketHooks()
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
					if not track.IsPlaying then
						continue
					end
					local _, animId = getTrackAnimInfo(track)
					local kind = getParryAnimKind(animId)
					if kind == 'melee' and meleeDist <= meleeRangeSetting and track.TimePosition <= meleeSwingWindowSetting then
						handleMeleeAnimation(ownerChar, track, 'scan')
					elseif kind == 'gun_draw' and track.TimePosition <= gunDrawWindowSetting then
						handleGunDrawAnimation(ownerChar, track, 'scan')
					elseif kind == 'gun_shot' and track.TimePosition <= gunShotWindowSetting then
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
			if kind == 'melee' and parryMeleeEnabled and getEnemyDistance(char) <= meleeRange and shouldParryMelee(char, true) then
				return true
			end
			if parryGunDrawEnabled and kind == 'gun_draw' and shouldParryGun(char, true) then
				return true
			end
			if parryGunShotEnabled and kind == 'gun_shot' and shouldParryGun(char, true) then
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

	local InfiniteHeat
	local HeatValue
	local HeatRate

	InfiniteHeat = minigames:CreateModule({
		Name = 'Infinite Heat',
		Function = function(callback)
			infiniteHeatActive = callback
			if callback then
				utilityHookLogged.heat = false
				heatStateRefs = {}
				bindPacketListeners()
				bindUtilityLoop()
				notif('Infinite Heat', 'Hooks heat sync + freezes client heat state. Check output for hook log.', 6)
			end
		end,
		Tooltip = 'Hooks incoming heat sync (_xdb2548bded1dd8e3 + unreliable NumberF16 packets) and freezes client heat tables. Gun packet heat cost zeroed. Castigate 100H, Phoenix 150H, Siege 140H, Monarch 200H.',
	})

	HeatValue = InfiniteHeat:CreateSlider({
		Name = 'Max Heat',
		Min = 50,
		Max = 500,
		Default = 200,
		Function = function(val)
			heatValueSetting = val
		end,
		Suffix = 'H',
		Tooltip = 'Target heat cap (200H covers Monarch). Incoming sync and client state are clamped to this.',
	})

	HeatRate = InfiniteHeat:CreateSlider({
		Name = 'Fallback Refresh',
		Min = 0.1,
		Max = 1,
		Decimal = 100,
		Default = 0.25,
		Function = function(val)
			heatRateSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Optional backup: re-sends client heat packet if sync hooks miss. Primary fix is incoming hook + state freeze.',
	})

	local InfiniteGrapple
	local GrappleAutoFire
	local GrappleRange
	local GrappleRate
	local GrappleHoldOnly

	InfiniteGrapple = minigames:CreateModule({
		Name = 'Infinite Grapple',
		Function = function(callback)
			infiniteGrappleActive = callback
			if callback then
				utilityHookLogged.grapple = false
				grappleStateRefs = {}
				bindPacketListeners()
				bindUtilityLoop()
				notif('Infinite Grapple', 'Keeps grapple charges at 2. Enable Auto Fire for optional E spam.', 6)
			end
		end,
		Tooltip = 'Freezes Grappler charges at 2 via getgc client state scan + heartbeat. Optional Auto Fire sends grapple packets toward look.',
	})

	GrappleAutoFire = InfiniteGrapple:CreateToggle({
		Name = 'Auto Fire',
		Default = false,
		Function = function(callback)
			grappleAutoFire = callback
		end,
		Tooltip = 'Off by default — use normal E grapple with infinite charges. On: auto-fires grapple packet toward camera.',
	})

	GrappleRange = InfiniteGrapple:CreateSlider({
		Name = 'Range',
		Min = 30,
		Max = 250,
		Default = 120,
		Function = function(val)
			grappleRangeSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})

	GrappleRate = InfiniteGrapple:CreateSlider({
		Name = 'Rate',
		Min = 0.05,
		Max = 1,
		Decimal = 100,
		Default = 0.2,
		Function = function(val)
			grappleRateSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})

	GrappleHoldOnly = InfiniteGrapple:CreateToggle({
		Name = 'Hold E Only',
		Default = true,
		Function = function(callback)
			grappleHoldOnly = callback
		end,
		Tooltip = 'When Auto Fire is on: only fire while holding E (AUGMENT). Turn off for constant auto grapple.',
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
	})

	local ParryMelee
	local ParryGunDraw
	local ParryGunShot
	local ParryGlint
	local MeleeParryDelay
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

	MeleeParryDelay = AutoParry:CreateSlider({
		Name = 'Melee Parry Delay',
		Min = 0,
		Max = 0.5,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.meleeParryDelay,
		Function = function(val)
			meleeParryDelaySetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
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
		Min = 0.1,
		Max = 0.9,
		Decimal = 100,
		Default = AUTO_PARRY_DEFAULTS.gunAimDot,
		Function = function(val)
			gunAimDotSetting = val
		end,
		Tooltip = 'How directly enemies must face you for gun parry.',
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
		meleeParryDelaySetting = d.meleeParryDelay
		meleeAimDotSetting = d.meleeAimDot
		gunAimDotSetting = d.gunAimDot
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
		MeleeParryDelay:SetValue(d.meleeParryDelay)
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
	end

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
				print('[REDLINER] debug on | alive=', isLocalAlive(), 'autoParry=', autoParryActive, 'castigateDelay=', gunParryDelays.Castigate)
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
	task.defer(bindUtilityLoop)
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
		notif('REDLINER', 'Minigames: Auto Parry, Auto Attack, Reach, Infinite Heat, Infinite Grapple ready.', 5)
	end)
end)
