--[[
	REDLINER shared game script (MAIN + FFA + MATCH place IDs).
	Place IDs: 94987506187454 (main), 115875349872417 (FFA), 126691165749976 (match).
	All three places share one Vape profile config (FFA place ID 115875349872417).
	Auto Parry, Auto Attack, Reach, HitBoxes, Draw Timer HUD,
	Hitbox Visualizer (swing/cone/bullet/enemy).
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
local debrisService = cloneref(game:GetService('Debris'))
local httpService = cloneref(game:GetService('HttpService'))
local workspaceService = cloneref(workspace)

local REDLINER_WEBHOOK = 'https://discord.com/api/webhooks/1516690090297004034/Lw4cv5VI9fo-M_iLCc3_7fzDyp9vUVaTk7314Tb86j61D-LHnoCzvGg41dni2OFSLnxj'

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local entitylib = vape.Libraries.entity

pcall(function()
	vape:Remove('Reach')
	vape:Remove('HitBoxes')
end)

local BASE_SWORD_REACH = 22

local PARRY_KEY = Enum.KeyCode.F
local PARRY_VK = 0x46

local MELEE_PACKET_NAME = '_xf5e1e1983608ed25'
local MELEE_PACKET_REMOTE = '_xf6afcf3c8b6be378'
local MELEE_SESSION_PACKET = '_x57c165550ede3092'
local PARRY_PACKET_NAME = '_xff9e8e66a100da8b'
local GUN_PACKET_NAME = '_x8458a1cfd21149ba'
local GUN_SHOT_PACKET_NAME = '_x6f11420c13d0d5ee'
local ALWAYS_PARRY_DEFAULT_VELOCITY = 200
local ALWAYS_PARRY_MIN_VELOCITY = 80
local ALWAYS_PARRY_MAX_VELOCITY = 200
local CLASH_VELOCITY_SERVER_CAP = 200
local HURTBOX_SCAN_CACHE_TTL = 0.2
local COMBAT_EVENT_PACKET = '_x6f165cf1c8a4a502'
local BREAK_PACKET_NAME = '_x71a4ac7aba517193'
local MELEE_DEFAULT_ACTION = 'SWING'
local MELEE_ACTION_FALLBACKS = {'SWING', 'SWING_HEAVY', 'wideslash', 'WIDESLASH', 'SLASH'}
local DASH_VELOCITY_MIN = 20
local AUTO_ATTACK_RANGE_DEFAULT = 14
local AUTO_ATTACK_MIN_DELAY = 0.12
local AUTO_ATTACK_SCAN_INTERVAL = 0.2

local redlinerApi = {
	resolved = false,
	meleePacketKey = nil,
	parryPacketKey = nil,
	sessionPacketKey = nil,
	combatEventKey = nil,
	breakPacketKey = nil,
	gunPacketKey = nil,
	gunShotPacketKey = nil,
	movementClassKey = nil,
	velocityField = nil,
	inputHandlers = {},
}

local MELEE_PACKET_CANDIDATES = {'_xa20c1ad6e56c96e7', '_xf5e1e1983608ed25'}
local PARRY_PACKET_CANDIDATES = {'_x0cdd43b25777bec6', '_xff9e8e66a100da8b'}
local SESSION_PACKET_CANDIDATES = {'_xbfaa5820a4100b86', '_x57c165550ede3092'}
local COMBAT_EVENT_CANDIDATES = {'_xeaae65f9581e0520', '_x6f165cf1c8a4a502'}
local BREAK_PACKET_CANDIDATES = {'_xc9c4207c75682687', '_x71a4ac7aba517193'}
local GUN_PACKET_CANDIDATES = {'_x67790e3a4ae7698a', '_x8458a1cfd21149ba'}
local GUN_SHOT_CANDIDATES = {'_x909c506c0531ca26', '_x6f11420c13d0d5ee'}
local MOVEMENT_CLASS_CANDIDATES = {'_x7058397dabccd000', '_xef0ffbcc2c92f7b4'}
local VELOCITY_FIELD_CANDIDATES = {'_x1d287c838240a901', '_xed86f944048d8fdc'}
local INPUT_HANDLER_CANDIDATES = {
	{class = '_x3e046bec2684f59c', method = '_xc9966245cd0a44a8'},
	{class = '_xd2c44c643b0c3fb4', method = '_xdf0c107e49196810'},
	{class = '_xf1ad98d2d70b7408', method = '_x93fd21adac562b5e'},
}

local AUTO_PARRY_DEFAULTS = {
	meleeRange = 20,
	threatRange = 100,
	watcherThreatRange = 120,
	meleeEnemyDebounce = 0.08,
	gunEnemyDebounce = 0.3,
	meleeAimDot = 0.32,
	gunAimDot = 0.65,
	meleeParryCooldown = 0,
	parryCooldown = 0.05,
	meleeSwingWindow = 0.7,
	gunDrawWindow = 0.45,
	gunShotWindow = 0.15,
	closeRangeStuds = 3,
	castigateDelay = 0.675,
	phoenixDelay = 0.72,
	siegeDelay = 0.99,
	monarchDelay = 1.665,
	parryMelee = true,
	parryGunDraw = true,
	parryGunShot = true,
	parryGlint = true,
	threatDebug = false,
	parryMode = 'Hybrid',
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
-- ItemDef draw_time (ReplicatedStorage.Assets.ModuleScripts.ItemDef).
local GUN_DRAW_TIMES = {
	Castigate = 0.75,
	Phoenix = 0.8,
	Siege = 1.1,
	Monarch = 1.85,
}
local PARRY_INPUT_LATENCY = 0.04
local PARRY_MODE_LIST = {'Hybrid', 'Animation', 'Packet'}

local Packets
local autoParryActive = false
local alwaysParryActive = false
local alwaysParryVelocitySetting = ALWAYS_PARRY_DEFAULT_VELOCITY
local autoAttackActive = false
local reachActive = false
local reachExtend = 0
local redlinerHitboxesActive = false
local redlinerHitboxExpand = 0
local redlinerHitboxVisualize = false
local redlinerHitboxPlayersOnly = true
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
local parryModeSetting = AUTO_PARRY_DEFAULTS.parryMode
local myHurtboxes = {}
local enemyStates = {}
local charWatchers = {}
local watchersStarted = false
local lastParryAt = 0
local lastMeleeParryAt = 0
local lastAttackAt = 0
local parryBlockAttackUntil = 0
local clashBlockUntil = 0
local PARRY_ATTACK_BLOCK_SEC = 0.08
local lastDebugHeartbeat = 0
local lastDebugSkipAt = {}
local lastDebugAnimAt = {}
local parryIdsLogged = false
local parryScanBound = false
local autoAttackLoopBound = false
local hurtboxScanCache = {time = 0, range = 0, visible = true, results = {}}
local autoAttackTargetCache = {time = 0, range = 0, model = nil}
local meleePacketGcMirrored = false
local alwaysParryInputBound = false
local localRespawnBound = false
local lastParryScanAt = 0
local lastWatcherRefreshAt = 0
local PARRY_SCAN_INTERVAL = 0.02
local WATCHER_REFRESH_INTERVAL = 0.25
local GUN_AIM_RANGE_BONUS = 0.12
local GUN_MUZZLE_NAMES = {'Muzzle', 'Barrel', 'FirePoint', 'Gun', 'Handle', 'Tip', 'ShootPoint', 'Ray', 'Flash', 'Emitter', 'Glint'}
local GUN_RAY_HIT_RADIUS = 5
local GUN_RAY_MAX_RANGE = 100000
local PING_PARRY_MAX_OFFSET = 0.35
local tryParry
local canSafelyParry
local hitboxReachHooked = false
local gunParryPacketHooked = false
local breakPacketHooked = false
local attackReachHooked = false
local meleePacketReachHooked = false
local reachHitboxHookSource = nil
local reachAttackHookSource = nil
local reachDebugEnabled = false
local lastReachDebugHeartbeat = 0
local lastReachDebugSkipAt = {}
local hud = {
	hitboxVisualizerSwingEnabled = false,
	hitboxVisualizerEnemyEnabled = false,
	hitboxVisualizerBulletEnabled = false,
	gunBulletVizHooked = false,
	hitboxVisualizerDurationSetting = 0.6,
	hitboxVisualizerRangeSetting = 22,
	drawTimerEnabled = false,
	drawTimerMaxEntriesSetting = 4,
	drawTimerFontSizeSetting = 22,
	drawTimerPositionPresetSetting = 'Center-Top',
	drawTimerScaleSetting = 1,
	drawTimerOpacitySetting = 0.88,
	threatIndicatorEnabled = false,
	threatIndicatorFontSizeSetting = 42,
	threatIndicatorOpacitySetting = 0.55,
	threatIndicatorPosYSetting = 0.82,
	threatIndicatorAnimSpeedSetting = 0.25,
	threatIndicatorFullscreenSetting = false,
	hudTickCallback = nil,
	drawTimerOffsetSetting = 0,
	drawTimerWorldEspSetting = true,
	drawTimerScreenHudSetting = false,
	drawTimerEspScaleSetting = 1,
	bulletWarningsEnabled = false,
	bulletWarningsTextSetting = 'SHOT READY',
	impactEspEnabled = false,
	impactEspMaxSetting = 100,
	healthEspEnabled = false,
	breakTimerEnabled = true,
	aimlockDetectorEnabled = false,
	aimlockVisualizeSetting = true,
	aimlockThresholdSetting = 0.985,
	aimlockMinSamplesSetting = 40,
	threatRequireAimingSetting = false,
	antiParryEnabled = true,
	threatShowMeleeSetting = true,
	threatShowGunDrawSetting = true,
	threatShowGunShotSetting = true,
	threatShowGlintSetting = true,
	threatColorMeleeSetting = Color3.fromRGB(255, 130, 90),
	threatColorGunDrawSetting = Color3.fromRGB(255, 210, 90),
	threatColorGunShotSetting = Color3.fromRGB(255, 90, 90),
	threatColorGlintSetting = Color3.fromRGB(180, 130, 255),
	hitboxVisualizerColorSetting = Color3.fromRGB(255, 60, 60),
	lastEnemyHurtboxVizAt = 0,
}
local noBreakScreenEnabled = false
local destabilizeBypassEnabled = false
local breakState = {
	active = false,
	duration = 0,
	endsAt = 0,
	lastDuration = 0,
	lastTriggeredAt = 0,
}

function parryModeUsesAnimation()
	return parryModeSetting ~= 'Packet'
end

function parryModeUsesPacket()
	return parryModeSetting ~= 'Animation'
end

function isPacketParryReason(reason)
	if type(reason) ~= 'string' then
		return false
	end
	return string.find(reason, 'gun_packet_', 1, true) ~= nil
		or string.find(reason, 'packet_cue_', 1, true) ~= nil
end

function isAnimationParryReason(reason)
	if type(reason) ~= 'string' then
		return false
	end
	return string.find(reason, 'melee_', 1, true) ~= nil
		or string.find(reason, 'gun_draw_', 1, true) ~= nil
		or string.find(reason, 'gun_shot_', 1, true) ~= nil
		or string.find(reason, 'glint', 1, true) ~= nil
end

function spawnWorldTracer(fromPos, toPos, color, opts)
	opts = opts or {}
	if typeof(fromPos) ~= 'Vector3' then
		return nil
	end
	local dir, length
	if opts.useDirection and typeof(toPos) == 'Vector3' then
		dir = toPos.Magnitude > 0.01 and toPos.Unit or Vector3.new(0, 0, -1)
		length = opts.length or 120
	elseif typeof(toPos) == 'Vector3' then
		local delta = toPos - fromPos
		length = delta.Magnitude
		if length < 0.05 then
			return nil
		end
		dir = delta.Unit
	else
		return nil
	end
	local thickness = opts.thickness or 0.15
	local part = opts.part or Instance.new('Part')
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CastShadow = false
	part.Material = Enum.Material.Neon
	part.Color = color or hud.hitboxVisualizerColorSetting
	part.Transparency = opts.transparency or 0.3
	part.Size = Vector3.new(thickness, thickness, length)
	part.CFrame = CFrame.lookAt(fromPos, fromPos + dir) * CFrame.new(0, 0, -length / 2)
	part.Parent = workspaceService
	if not opts.part and (opts.duration or hud.hitboxVisualizerDurationSetting) then
		debrisService:AddItem(part, opts.duration or hud.hitboxVisualizerDurationSetting)
	end
	return part
end

function spawnBulletVizRay(origin, direction, color)
	if not hud.hitboxVisualizerBulletEnabled then
		return
	end
	spawnWorldTracer(origin, direction, color, {useDirection = true, length = 120})
end

function isGameWindowFocused()
	if isrbxactive then
		return isrbxactive()
	end
	if iswindowactive then
		return iswindowactive()
	end
	return true
end

function reachDebugLog(...)
	if reachDebugEnabled then
		print('[REDLINER][Reach]', ...)
	end
end

function reachDebugWarn(...)
	if reachDebugEnabled then
		warn('[REDLINER][Reach]', ...)
	end
end

function reachDebugSkip(key, ...)
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

function notif(...)
	return vape:CreateNotification(...)
end

function postDiscord(payload)
	local body = httpService:JSONEncode(payload)
	local ok = pcall(function()
		if request then
			request({
				Url = REDLINER_WEBHOOK,
				Method = 'POST',
				Headers = {['Content-Type'] = 'application/json'},
				Body = body,
			})
		else
			httpService:PostAsync(REDLINER_WEBHOOK, body, Enum.HttpContentType.ApplicationJson, false)
		end
	end)
	return ok
end

function discordEmbed(title, description, color, fields, thumbnailUrl)
	local embed = {
		title = title,
		description = description,
		color = color or 5793266,
		fields = fields,
		footer = {text = 'Priv v9 | REDLINER'},
		timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
	}
	if thumbnailUrl and thumbnailUrl ~= '' then
		embed.thumbnail = {url = thumbnailUrl}
	end
	postDiscord({
		username = 'Priv | REDLINER',
		embeds = {embed},
	})
end

function readFolderValue(folder, name)
	if not folder then
		return nil
	end
	local inst = folder:FindFirstChild(name)
	if not inst then
		return nil
	end
	if inst:IsA('BoolValue') then
		return inst.Value
	end
	if inst:IsA('NumberValue') or inst:IsA('IntValue') then
		return inst.Value
	end
	if inst:IsA('StringValue') then
		return inst.Value
	end
	return inst.Value
end

run(function()
	local reportedPlayers = {}
	local PLAYER_STAT_KEYS = {
		'casual_duel_winstreak', 'crimson', 'equipped_title', 'in_combat', 'killstreak',
		'level', 'player_icon', 'robux_spent', 'rtt', 'status', 'total_xp', 'yen',
	}

	local function reportPlayer(plr)
		local ok, err = pcall(function()
			if not plr or plr == lplr or reportedPlayers[plr.UserId] then
				return
			end
			reportedPlayers[plr.UserId] = true

			local readOnlyRoot = replicatedStorage:FindFirstChild('ReadOnly')
			local playersFolder = readOnlyRoot and readOnlyRoot:FindFirstChild('Players')
			local statFolder = playersFolder and playersFolder:FindFirstChild(tostring(plr.UserId))

			local fields = {
				{name = 'Username', value = plr.Name, inline = true},
				{name = 'Display Name', value = plr.DisplayName, inline = true},
				{name = 'User ID', value = tostring(plr.UserId), inline = true},
				{name = 'Place', value = tostring(game.PlaceId), inline = true},
			}

			local iconUrl = ''
			for _, key in PLAYER_STAT_KEYS do
				local val = readFolderValue(statFolder, key)
				if val ~= nil then
					local display = tostring(val)
					if key == 'player_icon' then
						iconUrl = display
					end
					if key == 'in_combat' then
						display = val and 'Yes' or 'No'
					end
					table.insert(fields, {
						name = key:gsub('_', ' '):upper(),
						value = display,
						inline = true,
					})
				end
			end

			if not statFolder then
				table.insert(fields, {
					name = 'Stats',
					value = 'ReadOnly profile folder not replicated yet - basic identity only.',
					inline = false,
				})
			end

			discordEmbed(
				'ðŸ“‹ Player Report',
				'**' .. plr.Name .. '** is in this server.',
				3447003,
				fields,
				iconUrl
			)
		end)
		if not ok then
			warn('[REDLINER] Player report failed:', err)
		end
	end

	for _, plr in playersService:GetPlayers() do
		task.defer(reportPlayer, plr)
	end
	playersService.PlayerAdded:Connect(function(plr)
		task.defer(reportPlayer, plr)
	end)
end)

function getPlayerReadOnlyFolder(plr)
	return plr and plr:FindFirstChild('ReadOnly')
end

function getPlayerReadOnlyNumber(plr, name)
	local ro = getPlayerReadOnlyFolder(plr)
	local v = ro and ro:FindFirstChild(name)
	if v and (v:IsA('NumberValue') or v:IsA('IntValue')) then
		return v.Value
	end
	return nil
end

function getEntityHeadPart(plr)
	if not plr then
		return nil
	end
	local entities = workspaceService:FindFirstChild('Entities')
	local ent = entities and entities:FindFirstChild(plr.Name)
	if ent then
		local hurtboxes = ent:FindFirstChild('Hurtboxes')
		local headHb = hurtboxes and hurtboxes:FindFirstChild('Head_Hurtbox')
		if headHb and headHb:IsA('BasePart') then
			return headHb
		end
	end
	local char = plr.Character
	if char then
		return char:FindFirstChild('Head') or char:FindFirstChild('HumanoidRootPart')
	end
	return nil
end

function isPlayerVisible(plr)
	local head = getEntityHeadPart(plr)
	if not head or not head.Parent then
		return false
	end
	local cam = workspace.CurrentCamera
	if not cam then
		return false
	end
	local pos = cam:WorldToViewportPoint(head.Position)
	if pos.Z < 0 then
		return false
	end
	local size = cam.ViewportSize
	if pos.X < 0 or pos.X > size.X or pos.Y < 0 or pos.Y > size.Y then
		return false
	end
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	local ignore = {cam}
	if lplr.Character then
		table.insert(ignore, lplr.Character)
	end
	rayParams.FilterDescendantsInstances = ignore
	local origin = cam.CFrame.Position
	local dir = head.Position - origin
	if dir.Magnitude < 0.05 then
		return true
	end
	local hit = workspaceService:Raycast(origin, dir, rayParams)
	if not hit then
		return true
	end
	if plr.Character and hit.Instance:IsDescendantOf(plr.Character) then
		return true
	end
	local entFolder = workspaceService:FindFirstChild('Entities')
	local ent = entFolder and entFolder:FindFirstChild(plr.Name)
	if ent and hit.Instance:IsDescendantOf(ent) then
		return true
	end
	return false
end

function withThread(func)
	if vape.ThreadFix and setthreadidentity then
		setthreadidentity(8)
	end
	return func()
end

function debugLog(...)
	if debugEnabled then
		print('[REDLINER]', ...)
	end
end

function debugSkip(...)
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

function threatDebugSkip(...)
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

function initPackets()
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

local function pickPacket(candidates)
	if not Packets then
		return nil
	end
	for _, key in candidates do
		local packet = Packets[key]
		if type(packet) == 'table' and type(packet.Fire) == 'function' then
			return key
		end
	end
	return nil
end

local function pickUnreliablePacket(candidates)
	if not Packets or not Packets.unreliablePackets then
		return nil
	end
	for _, key in candidates do
		local packet = Packets.unreliablePackets[key]
		if type(packet) == 'table' and packet.OnClientEvent then
			return key
		end
	end
	return nil
end

resolveRedlinerRuntime = function(force)
	if redlinerApi.resolved and not force then
		return redlinerApi.meleePacketKey ~= nil
	end
	if not Packets and not initPackets() then
		return false
	end
	local prevMelee = redlinerApi.meleePacketKey
	redlinerApi.meleePacketKey = pickPacket(MELEE_PACKET_CANDIDATES) or pickPacket({MELEE_PACKET_NAME})
	redlinerApi.parryPacketKey = pickPacket(PARRY_PACKET_CANDIDATES) or pickPacket({PARRY_PACKET_NAME})
	redlinerApi.sessionPacketKey = pickPacket(SESSION_PACKET_CANDIDATES) or pickPacket({MELEE_SESSION_PACKET})
	redlinerApi.combatEventKey = pickUnreliablePacket(COMBAT_EVENT_CANDIDATES) or pickUnreliablePacket({COMBAT_EVENT_PACKET})
	redlinerApi.breakPacketKey = pickPacket(BREAK_PACKET_CANDIDATES) or pickPacket({BREAK_PACKET_NAME})
	redlinerApi.gunPacketKey = pickPacket(GUN_PACKET_CANDIDATES) or pickPacket({GUN_PACKET_NAME})
	redlinerApi.gunShotPacketKey = pickPacket(GUN_SHOT_CANDIDATES) or pickPacket({GUN_SHOT_PACKET_NAME})

	if prevMelee and redlinerApi.meleePacketKey and prevMelee ~= redlinerApi.meleePacketKey then
		meleePacketReachHooked = false
		meleePacketGcMirrored = false
	end

	redlinerApi.resolved = redlinerApi.meleePacketKey ~= nil
	return redlinerApi.resolved
end

getResolvedMeleePacket = function()
	resolveRedlinerRuntime()
	return redlinerApi.meleePacketKey and Packets and Packets[redlinerApi.meleePacketKey] or nil
end

function getMeleeReach()
	return BASE_SWORD_REACH + (reachActive and reachExtend or 0)
end

-- ---------------------------------------------------------------------------
-- Character helpers
-- ---------------------------------------------------------------------------

function getLocalCharacter()
	local char = lplr.Character
	if char and char.Parent then
		return char
	end
	if entitylib.isAlive and entitylib.character.Character then
		local elibChar = entitylib.character.Character
		if elibChar and elibChar.Parent then
			return elibChar
		end
	end
	return char
end

function getLocalRoot()
	local char = getLocalCharacter()
	if not char then
		return nil
	end
	local root = char:FindFirstChild('HumanoidRootPart')
	if root then
		return root
	end
	if entitylib.isAlive and entitylib.character.Character == char and entitylib.character.RootPart then
		local elibRoot = entitylib.character.RootPart
		if elibRoot.Parent and elibRoot:IsDescendantOf(char) then
			return elibRoot
		end
	end
	return nil
end

function isLocalAlive()
	local char = getLocalCharacter()
	if not char or not char.Parent then
		return false
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

function isEnemyCharacter(model)
	if not model or model == lplr.Character then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(model)
	return plr and plr ~= lplr
end

function getPlayerFromModel(model)
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

function isEnemyCharVisible(char)
	if not char then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(char)
	if not plr then
		plr = getPlayerFromModel(char)
	end
	if not plr or plr == lplr then
		return false
	end
	return isPlayerVisible(plr)
end

function getEnemyModels(plr)
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

function getClosestEnemyDistance(charOrPlr)
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

function getEnemyDistance(char)
	return getClosestEnemyDistance(char)
end

function getEnemyState(char)
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

function isEnemyInMeleeThreatRange(char)
	return isEnemyCharVisible(char)
end

function isEnemyInGunThreatRange(char)
	return isEnemyCharVisible(char)
end

function getEffectiveWatcherRange()
	return math.huge
end

function isInstUnderEnemyModels(char, inst)
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

function getTriggerDebounce(triggerKey)
	if string.find(triggerKey, ':melee:', 1, true) then
		return meleeEnemyDebounceSetting
	end
	return gunEnemyDebounceSetting
end

function canEnemyAnimTrigger(char, triggerKey)
	local state = getEnemyState(char)
	local now = tick()
	local debounce = getTriggerDebounce(triggerKey)
	if state.lastAnimTriggerKey == triggerKey and now - (state.lastAnimTriggerAt or 0) < debounce then
		threatDebugSkip('cooldown', char.Name, triggerKey)
		return false
	end
	return true
end

function confirmEnemyAnimTrigger(char, triggerKey)
	local state = getEnemyState(char)
	state.lastAnimTriggerKey = triggerKey
	state.lastAnimTriggerAt = tick()
end

-- ---------------------------------------------------------------------------
-- Animation catalog (whitelist-only)
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- Parry animation IDs (strict whitelist only)
-- ---------------------------------------------------------------------------

function normalizeAnimId(animId)
	if typeof(animId) ~= 'string' or animId == '' then
		return ''
	end
	local numeric = string.match(animId, '(%d+)')
	return numeric or string.lower(animId)
end

function getTrackAnimInfo(track)
	local anim = track and track.Animation
	if not anim then
		return '', ''
	end
	return anim.Name or '', anim.AnimationId or ''
end

function getParryAnimKind(animId)
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

function isParryMeleeAnim(animId)
	return getParryAnimKind(animId) == 'melee'
end

function debugAnimLog(...)
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

function logParryAnimIds(force)
	if parryIdsLogged and not force then
		return
	end
	parryIdsLogged = true
	print('[REDLINER] parry ids | melee=105441036119013 | gun_draw+gun_shot from catalog | blocked walk=115078691506529')
end

function getAllPlayingTracks(char)
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

function getAllPlayingTracksForChar(char)
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

function charHasWhitelistAttackPlaying(char)
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

function getTrackOwnerModel(track)
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

function getAimDot3D(origin, lookVector, targetPos)
	local offset = targetPos - origin
	if offset.Magnitude < 0.05 then
		return 1
	end
	if lookVector.Magnitude < 0.05 then
		return 0
	end
	return lookVector.Unit:Dot(offset.Unit)
end

function rayClosestDistance(origin, dir, point, maxRange)
	dir = dir.Unit
	local rel = point - origin
	local t = math.clamp(rel:Dot(dir), 0, maxRange or GUN_RAY_MAX_RANGE)
	local closest = origin + dir * t
	return (point - closest).Magnitude, t
end

local refreshMyHurtboxes

function isGunRayThreatening(origin, direction, maxRange, maxRadius)
	if direction.Magnitude < 0.05 then
		return false
	end
	if #myHurtboxes == 0 then
		refreshMyHurtboxes()
	end
	local dir = direction.Unit
	local range = maxRange or GUN_RAY_MAX_RANGE
	local radius = maxRadius or GUN_RAY_HIT_RADIUS
	for _, part in myHurtboxes do
		if part and part.Parent then
			local dist = select(1, rayClosestDistance(origin, dir, part.Position, range))
			if dist <= radius then
				return true
			end
		end
	end
	return false
end

function isGunMuzzlePart(name)
	local lower = string.lower(name)
	for _, mName in GUN_MUZZLE_NAMES do
		if string.find(lower, string.lower(mName), 1, true) then
			return true
		end
	end
	return false
end

function collectEnemyGunAimSources(char, aimModel)
	local rays = {}
	local dots = {}
	local myRoot = getLocalRoot()
	if not myRoot then
		return rays, dots
	end
	local targetPos = myRoot.Position
	local plr = playersService:GetPlayerFromCharacter(char)
	local models = plr and getEnemyModels(plr) or {char}
	for _, model in models do
		if not model or not model.Parent then
			continue
		end
		local hasMuzzle = false
		for _, desc in model:GetDescendants() do
			if desc:IsA('BasePart') and isGunMuzzlePart(desc.Name) then
				hasMuzzle = true
				table.insert(rays, {origin = desc.Position, direction = desc.CFrame.LookVector})
				table.insert(dots, getAimDot3D(desc.Position, desc.CFrame.LookVector, targetPos))
			end
		end
		if not hasMuzzle then
			local hrp = model:FindFirstChild('HumanoidRootPart')
			local head = model:FindFirstChild('Head')
			if hrp then
				table.insert(rays, {origin = hrp.Position, direction = hrp.CFrame.LookVector})
				table.insert(dots, getAimDot3D(hrp.Position, hrp.CFrame.LookVector, targetPos))
			end
			if head then
				table.insert(rays, {origin = head.Position, direction = head.CFrame.LookVector})
				table.insert(dots, getAimDot3D(head.Position, head.CFrame.LookVector, targetPos))
			end
		end
	end
	return rays, dots
end

function getEnemyGunOrigin(char)
	if not char then
		return nil
	end
	for _, desc in char:GetDescendants() do
		if desc:IsA('BasePart') and isGunMuzzlePart(desc.Name) then
			return desc.Position
		end
	end
	local hrp = char:FindFirstChild('HumanoidRootPart')
	return hrp and hrp.Position
end

function findGunShooterFromShotPacket(shotOrigin, aimDir)
	if typeof(shotOrigin) ~= 'Vector3' or typeof(aimDir) ~= 'Vector3' or aimDir.Magnitude < 0.05 then
		return nil
	end
	local bestChar, bestDist = nil, 30
	for _, plr in playersService:GetPlayers() do
		if plr == lplr then
			continue
		end
		local char = plr.Character
		if not char or not char.Parent or not isEnemyInGunThreatRange(char) then
			continue
		end
		local gunOrigin = getEnemyGunOrigin(char)
		if not gunOrigin then
			continue
		end
		local dist = (gunOrigin - shotOrigin).Magnitude
		if dist >= bestDist then
			continue
		end
		local aiming = isGunAimDirAtMe(shotOrigin, aimDir, char)
		if aiming or dist < 10 then
			bestDist = dist
			bestChar = char
		end
	end
	return bestChar
end

function isGunAimDirAtMe(originPos, aimDir, char)
	if not originPos or typeof(aimDir) ~= 'Vector3' or aimDir.Magnitude < 0.05 then
		return false
	end
	local myRoot = getLocalRoot()
	if not myRoot then
		return false
	end
	local need = getEffectiveGunAimThreshold(getClosestEnemyDistance(char))
	local aimDot = aimDir.Unit:Dot((myRoot.Position - originPos).Unit)
	if aimDot < need then
		return false, aimDot, need
	end
	if not isGunRayThreatening(originPos, aimDir, GUN_RAY_MAX_RANGE, GUN_RAY_HIT_RADIUS) then
		return false, aimDot, need
	end
	return true, aimDot, need
end

function getGunAimDotFromModel(model)
	local root = getLocalRoot()
	local enemyRoot = model and model:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return 0
	end
	return getAimDot3D(enemyRoot.Position, enemyRoot.CFrame.LookVector, root.Position)
end

function getHeadAimDotFromModel(model)
	local root = getLocalRoot()
	local head = model and model:FindFirstChild('Head')
	if not root or not head then
		return 0
	end
	return getAimDot3D(head.Position, head.CFrame.LookVector, root.Position)
end

function getEffectiveGunAimThreshold(_dist)
	return math.min(gunAimDotSetting, 0.95)
end

function getGunAimDot(char, aimModel)
	return getGunAimDotFromModel(aimModel or char)
end

function getAimDot(char)
	local hrpDot = getGunAimDotFromModel(char)
	local headDot = getHeadAimDotFromModel(char)
	return math.max(hrpDot, headDot)
end

function isEnemyAimingAtMeForGun(char, aimModel)
	local dist = getClosestEnemyDistance(char)
	local need = getEffectiveGunAimThreshold(dist)
	local rays, dotList = collectEnemyGunAimSources(char, aimModel)
	local maxDot = getGunAimDotFromModel(aimModel or char)
	maxDot = math.max(maxDot, getHeadAimDotFromModel(aimModel or char))
	for _, d in dotList do
		maxDot = math.max(maxDot, d)
	end
	if maxDot < need then
		return false, maxDot, need
	end
	for _, ray in rays do
		if isGunRayThreatening(ray.origin, ray.direction, GUN_RAY_MAX_RANGE, GUN_RAY_HIT_RADIUS) then
			return true, maxDot, need
		end
	end
	return false, maxDot, need
end

function isEnemyTargetingMe(char, minDot, confirmedAttack)
	local dist = getClosestEnemyDistance(char)
	if not confirmedAttack and dist < closeRangeStudsSetting and not charHasWhitelistAttackPlaying(char) then
		debugSkip('close_range_no_attack', char.Name, string.format('%.1f', dist))
		return false
	end
	return getAimDot(char) >= minDot
end

function shouldParryMelee(char, _confirmedAttack)
	if not parryMeleeEnabled then
		return false
	end
	if not isEnemyCharVisible(char) then
		threatDebugSkip('not_visible', char.Name, 'melee')
		return false
	end
	return true
end

function shouldParryGun(char, _confirmedAttack, aimModel, packetAimDir)
	if not parryGunDrawEnabled and not parryGunShotEnabled then
		return false
	end
	if not char then
		return false
	end
	if not isEnemyCharVisible(char) then
		threatDebugSkip('not_visible', char.Name, 'gun')
		return false
	end
	if typeof(packetAimDir) == 'Vector3' and packetAimDir.Magnitude > 0.05 then
		local origin = getEnemyGunOrigin(char)
		if origin then
			local aiming, dot, need = isGunAimDirAtMe(origin, packetAimDir, char)
			if aiming then
				return true
			end
			threatDebugSkip('not_aiming', char.Name, 'gun_packet', string.format('dot=%.3f need=%.2f', dot, need))
			return false
		end
	end
	local aiming, dot, need = isEnemyAimingAtMeForGun(char, aimModel)
	if aiming then
		return true
	end
	threatDebugSkip('not_aiming', char.Name, 'gun', string.format('dot=%.3f need=%.2f', dot, need))
	return false
end

function isMeleeSwingTrackActive(track)
	return track.IsPlaying
end

-- ---------------------------------------------------------------------------
-- Gun helpers
-- ---------------------------------------------------------------------------

function detectEquippedGun(char)
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

function charHasGunEquipped(char)
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

function isEnemyDashing(char)
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

function isGlintInstance(inst)
	return string.find(string.lower(inst.Name), 'glint', 1, true) ~= nil
end

function getNetworkPing()
	local ping = 0
	pcall(function()
		if lplr.GetNetworkPing then
			ping = lplr:GetNetworkPing()
		end
	end)
	if typeof(ping) ~= 'number' or ping ~= ping or ping < 0 then
		return 0
	end
	return ping
end

function getLocalImpactRatio()
	local impact = getPlayerReadOnlyNumber(lplr, 'impact') or 0
	local limit = getPlayerReadOnlyNumber(lplr, 'impact_limit') or 1
	return math.clamp(impact / math.max(limit, 1), 0, 1)
end

function getGunParryDelay(gunName)
	return gunParryDelays[gunName] or gunParryDelays.Castigate
end

function getParryLeadTime()
	return math.clamp(getNetworkPing() * 0.5 + PARRY_INPUT_LATENCY, 0, PING_PARRY_MAX_OFFSET + PARRY_INPUT_LATENCY)
end

function getPingParryOffset()
	return getParryLeadTime()
end

function getEffectiveGunParryDelay(gunName)
	return math.max(0, getGunParryDelay(gunName) - getParryLeadTime())
end

function getAdjustedParryDelay(baseDelay, timePosition)
	local impactShift = (1 - getLocalImpactRatio()) * 0.03
	return math.max(0, (baseDelay or 0) - (timePosition or 0) - getParryLeadTime() - impactShift)
end

function scheduleGunDrawParry(char, gunName, normId, timePosition, source, track, aimModel)
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
	local delay = getAdjustedParryDelay(getGunParryDelay(gunName), timePosition)

	debugLog(
		'trigger',
		'gun_draw_schedule_' .. gunName,
		'id=' .. normId,
		'delay=' .. string.format('%.2f', delay),
		'ping=' .. string.format('%.0fms', getPingParryOffset() * 1000),
		source
	)

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

function pressParryKey()
	if not canSafelyParry() then
		return false
	end
	parryBlockAttackUntil = tick() + PARRY_ATTACK_BLOCK_SEC
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
	if isAnimationParryReason(reason) and not parryModeUsesAnimation() then
		return false
	end
	if isPacketParryReason(reason) and not parryModeUsesPacket() then
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
	end
	debugLog('parry trigger', reason, char and char.Name or '-')
	local pressed = pressParryKey()
	if not pressed then
		return false
	end
	if isMeleeParry then
		lastMeleeParryAt = now
	else
		lastParryAt = now
	end
	if char then
		local state = getEnemyState(char)
		if isMeleeParry then
			state.lastMeleeParryAt = now
			local normId = string.match(reason, 'melee_(%d+)') or ''
			if normId ~= '' then
				confirmEnemyAnimTrigger(char, normId .. ':melee:swing')
			end
		else
			state.lastGunParryAt = now
			if reason and string.find(reason, 'gun_shot', 1, true) then
				local normId = string.match(reason, '(%d+)$') or reason
				confirmEnemyAnimTrigger(char, normId .. ':gun_shot')
			elseif reason and string.find(reason, 'gun_draw', 1, true) then
				local normId = string.match(reason, '(%d+)$') or reason
				confirmEnemyAnimTrigger(char, normId .. ':gun_draw')
			elseif reason and string.find(reason, 'glint', 1, true) then
				confirmEnemyAnimTrigger(char, 'glint')
			end
		end
	end
	return true
end

-- Enemy parry animations (built from Assets.Animations catalog at load).
ENEMY_PARRY_ANIM_IDS = {}

function buildEnemyParryAnimCatalog()
	table.clear(ENEMY_PARRY_ANIM_IDS)
	local assets = replicatedStorage:FindFirstChild('Assets')
	if not assets then
		return 0
	end
	local count = 0
	for _, inst in assets:GetDescendants() do
		if inst:IsA('Animation') then
			local upper = string.upper(inst.Name)
			if string.find(upper, 'PARRY', 1, true) then
				local normId = normalizeAnimId(inst.AnimationId)
				if normId ~= '' and not ENEMY_PARRY_ANIM_IDS[normId] then
					ENEMY_PARRY_ANIM_IDS[normId] = inst.Name
					count += 1
				end
			end
		end
	end
	return count
end

function isEnemyParryAnim(animId, animName)
	local normId = normalizeAnimId(animId)
	if normId == '' then
		return false
	end
	if GUN_DRAW_ANIM_IDS[normId] or GUN_SHOT_ANIM_IDS[normId] then
		return false
	end
	if ENEMY_PARRY_ANIM_IDS[normId] then
		return true
	end
	local upper = string.upper(animName or '')
	return string.find(upper, 'PARRY', 1, true) ~= nil
end

function isEnemyParrying(charOrPlr)
	local plr, char
	if charOrPlr and charOrPlr:IsA('Player') then
		plr = charOrPlr
		char = charOrPlr.Character
	else
		char = charOrPlr
		plr = char and playersService:GetPlayerFromCharacter(char)
	end
	if not char or not char.Parent then
		return false
	end
	local models = plr and getEnemyModels(plr) or {char}
	for _, model in models do
		if model and model.Parent then
			for _, track in getAllPlayingTracks(model) do
				if track.IsPlaying and track.WeightCurrent >= 0.12 then
					local name, animId = getTrackAnimInfo(track)
					if isEnemyParryAnim(animId, name) and track.TimePosition <= 1.05 then
						return true
					end
				end
			end
		end
	end
	return false
end

MELEE_SWING_NAME_HINTS = {'SLASH', 'SWING', 'WIDE', 'STAB', 'CUT', 'HIT', 'CROUCH'}
MELEE_SWING_NAME_BLOCK = {'PARRY', 'DRAW', 'GUN', 'IDLE', 'WALK', 'RUN', 'JUMP', 'LAND', 'BLOCK', 'DASH', 'DEATH', 'HURT'}

function isMeleeSwingAnimName(animName)
	local upper = string.upper(animName or '')
	for _, blocked in MELEE_SWING_NAME_BLOCK do
		if string.find(upper, blocked, 1, true) then
			return false
		end
	end
	for _, hint in MELEE_SWING_NAME_HINTS do
		if string.find(upper, hint, 1, true) then
			return true
		end
	end
	return false
end

function isEnemyMeleeSwinging(charOrPlr, maxSwingTime)
	maxSwingTime = maxSwingTime or 0.85
	local plr, char
	if charOrPlr and charOrPlr:IsA('Player') then
		plr = charOrPlr
		char = charOrPlr.Character
	else
		char = charOrPlr
		plr = char and playersService:GetPlayerFromCharacter(char)
	end
	if not char or not char.Parent then
		return false
	end
	local models = plr and getEnemyModels(plr) or {char}
	for _, model in models do
		if model and model.Parent then
			for _, track in getAllPlayingTracks(model) do
				if track.IsPlaying and track.WeightCurrent >= 0.12 then
					local name, animId = getTrackAnimInfo(track)
					if isEnemyParryAnim(animId, name) then
						continue
					end
					if isMeleeSwingAnimName(name) and track.TimePosition <= maxSwingTime then
						return true
					end
				end
			end
		end
	end
	return false
end

shouldBlockMeleeAttack = function(attackRange)
	if tick() < clashBlockUntil or tick() < parryBlockAttackUntil then
		return true
	end
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character and isPlayerVisible(plr) then
			if getClosestEnemyDistance(plr) <= attackRange then
				if isEnemyParrying(plr) or isEnemyMeleeSwinging(plr) then
					return true
				end
			end
		end
	end
	return false
end

task.defer(function()
	local count = buildEnemyParryAnimCatalog()
	if count > 0 then
		print('[REDLINER] enemy parry catalog | entries=', count)
	end
end)

run(function()
-- ---------------------------------------------------------------------------
-- Threat handlers (edge-triggered only)
-- ---------------------------------------------------------------------------

handleMeleeAnimation = function(char, track, source, aimModel)
	if not parryModeUsesAnimation() then
		return
	end
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
	local inWindow = track.TimePosition <= meleeSwingWindowSetting
		or (source == 'edge' and track.TimePosition < 0.2)
	if not inWindow then
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

	debugLog('trigger', 'melee_' .. normId, 'dist=' .. string.format('%.1f', getClosestEnemyDistance(char)), source)
	tryParry('melee_' .. normId, char)
end

local function handleGunDrawAnimation(char, track, source, aimModel)
	if not parryModeUsesAnimation() then
		return
	end
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
	if not parryModeUsesAnimation() then
		return
	end
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
	if hud.hitboxVisualizerBulletEnabled then
		task.defer(function()
			local aimRoot = aimModel and aimModel:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('HumanoidRootPart')
			local myRoot = getLocalRoot()
			if aimRoot and myRoot then
				spawnBulletVizRay(aimRoot.Position, myRoot.Position - aimRoot.Position, hud.threatColorGunShotSetting)
			end
		end)
	end
	tryParry('gun_shot_' .. gunName .. '_' .. normId, char)
end

local function handleGlintSpawn(char, inst)
	if not parryModeUsesAnimation() then
		return
	end
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
		handleMeleeAnimation(char, track, 'edge', aimModel)
	elseif kind == 'gun_draw' and parryGunDrawEnabled then
		handleGunDrawAnimation(char, track, 'edge', aimModel)
	elseif kind == 'gun_shot' and parryGunShotEnabled then
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

unwatchAllForPlayer = function(plr)
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
	if not isPlayerVisible(plr) then
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

refreshThreatWatchers = function(force)
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
			if isPlayerVisible(plr) then
				watchEnemyPlayer(plr)
			else
				unwatchAllForPlayer(plr)
			end
		end
	end
end

refreshMyHurtboxes = function()
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

refreshEnemyWatchers = function()
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

local function resetLocalParryState()
	lastParryAt = 0
	lastMeleeParryAt = 0
	parryBlockAttackUntil = 0
	cancelPendingParries()
end

local function blockLocalParry()
	cancelPendingParries()
end

bindLocalRespawnHandler = function()
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

	local function onLocalRespawn(char)
		resetLocalParryState()
		task.defer(function()
			if not char or not char.Parent then
				return
			end
			refreshMyHurtboxes()
			if autoAttackActive or alwaysParryActive or reachActive then
				if invalidateClientClassesCache then
					invalidateClientClassesCache()
				end
				resolveRedlinerRuntime(true)
				rebuildMeleePacketFireChain()
			end
			if autoParryActive then
				purgeOrphanWatchers()
				refreshEnemyWatchers()
			end
			hookCharacter(char)
		end)
	end

	lplr.CharacterRemoving:Connect(function()
		blockLocalParry()
	end)

	lplr.CharacterAdded:Connect(onLocalRespawn)

	if lplr.Character then
		hookCharacter(lplr.Character)
	end
end

startEnemyWatchers = function()
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

local function resolveGunParryShooter(arg1, arg9, arg10)
	local char
	if typeof(arg1) == 'string' and arg1 ~= '' then
		local plr = playersService:FindFirstChild(arg1)
		if plr and plr ~= lplr then
			char = plr.Character
		end
	end
	if char then
		return char
	end
	local uid
	if typeof(arg10) == 'number' and arg10 > 0 then
		uid = arg10
	elseif typeof(arg9) == 'number' and arg9 > 0 then
		uid = arg9
	elseif typeof(arg1) == 'number' and arg1 > 0 then
		uid = arg1
	end
	if uid then
		local plr = playersService:GetPlayerByUserId(uid)
		if plr and plr ~= lplr then
			return plr.Character
		end
	end
	return nil
end

local function handleIncomingGunParryPacket(char, aimDir, gunName, sourceTag)
	if not autoParryActive or not parryGunShotEnabled or not parryModeUsesPacket() or not isLocalAlive() then
		return
	end
	if typeof(aimDir) ~= 'Vector3' or aimDir.Magnitude < 0.05 then
		return
	end
	if not char or not char.Parent then
		return
	end
	if not isEnemyInGunThreatRange(char) then
		return
	end
	if not shouldParryGun(char, false, char, aimDir) then
		return
	end
	local label = typeof(gunName) == 'string' and gunName ~= '' and gunName or detectEquippedGun(char)
	debugLog('trigger', sourceTag, label, 'dist=' .. string.format('%.1f', getClosestEnemyDistance(char)))
	tryParry(sourceTag .. '_' .. label, char)
end

installGunParryPacketHook = function()
	if gunParryPacketHooked then
		return true
	end
	if not initPackets() then
		return false
	end
	resolveRedlinerRuntime()
	local gunKey = redlinerApi.gunPacketKey or GUN_PACKET_NAME
	local shotKey = redlinerApi.gunShotPacketKey or GUN_SHOT_PACKET_NAME
	local legacyPacket = Packets[gunKey]
	if legacyPacket and legacyPacket.OnClientEvent and type(legacyPacket.OnClientEvent.Connect) == 'function'
		and not legacyPacket._gunParryHooked then
		legacyPacket._gunParryHooked = true
		legacyPacket.OnClientEvent:Connect(function(arg1, _arg2, _arg3, _arg4, _arg5, _arg6, aimDir, gunName, arg9, arg10)
			local char = resolveGunParryShooter(arg1, arg9, arg10)
			handleIncomingGunParryPacket(char, aimDir, gunName, 'gun_packet')
		end)
		gunParryPacketHooked = true
	end
	local shotPacket = Packets[shotKey]
	if shotPacket and shotPacket.OnClientEvent and type(shotPacket.OnClientEvent.Connect) == 'function'
		and not shotPacket._gunParryHooked then
		shotPacket._gunParryHooked = true
		shotPacket.OnClientEvent:Connect(function(_sessionToken, aimDir, shotOrigin, _hurtboxes, _timestamp)
			local char = findGunShooterFromShotPacket(shotOrigin, aimDir)
			handleIncomingGunParryPacket(char, aimDir, nil, 'gun_shot_packet')
		end)
		gunParryPacketHooked = true
	end
	return gunParryPacketHooked
end

updateBreakState = function(duration)
	if typeof(duration) ~= 'number' then
		return
	end
	duration = math.max(0, duration)
	if duration <= 0 then
		breakState.active = false
		breakState.duration = 0
		breakState.endsAt = 0
		return
	end
	breakState.active = true
	breakState.duration = duration
	breakState.lastDuration = duration
	breakState.lastTriggeredAt = tick()
	breakState.endsAt = tick() + duration
end

end)

run(function()
-- ---------------------------------------------------------------------------
-- Combat reach hooks (Attack + Hitbox from decompiled modules)
-- ---------------------------------------------------------------------------

local expandedHurtboxSizes = {}
local redlinerHitboxViz = {}
local hitboxExpansionBound = false
local lastHitboxExpansionRefresh = 0
local HITBOX_EXPANSION_REFRESH_INTERVAL = 0.4

local function isLocalOwnedHurtbox(part)
	if not part or not part.Parent then
		return true
	end
	if lplr.Character and part:IsDescendantOf(lplr.Character) then
		return true
	end
	local owner = part:FindFirstAncestorWhichIsA('Model')
	if not owner then
		return false
	end
	if lplr.Character and (owner == lplr.Character or owner:IsDescendantOf(lplr.Character)) then
		return true
	end
	local plr = getPlayerFromModel(owner)
	if plr == lplr then
		return true
	end
	return false
end

local function shouldExpandRedlinerHurtbox(part)
	if isLocalOwnedHurtbox(part) then
		return false
	end
	local owner = part:FindFirstAncestorWhichIsA('Model')
	if not owner then
		return false
	end
	local plr = getPlayerFromModel(owner)
	if not plr or plr == lplr then
		return false
	end
	if redlinerHitboxPlayersOnly and not plr then
		return false
	end
	return true
end

local function applyRedlinerHurtboxExpand(part)
	if not shouldExpandRedlinerHurtbox(part) then
		return false
	end
	if not expandedHurtboxSizes[part] then
		expandedHurtboxSizes[part] = part.Size
	end
	local orig = expandedHurtboxSizes[part]
	local target = orig + Vector3.new(redlinerHitboxExpand, redlinerHitboxExpand, redlinerHitboxExpand)
	if (part.Size - target).Magnitude > 0.01 then
		part.Size = target
	end
	if redlinerHitboxVisualize then
		local adorn = redlinerHitboxViz[part]
		if not adorn or not adorn.Parent then
			adorn = Instance.new('BoxHandleAdornment')
			adorn.Name = 'VapeRedlinerHitbox'
			adorn.AlwaysOnTop = true
			adorn.ZIndex = 5
			adorn.Adornee = part
			adorn.Parent = part
			redlinerHitboxViz[part] = adorn
		end
		adorn.Size = part.Size
		adorn.Color3 = Color3.fromRGB(255, 85, 85)
		adorn.Transparency = 0.45
	elseif redlinerHitboxViz[part] then
		pcall(function()
			redlinerHitboxViz[part]:Destroy()
		end)
		redlinerHitboxViz[part] = nil
	end
	return true
end

local function releaseRedlinerHurtboxExpand(part)
	local origSize = expandedHurtboxSizes[part]
	if origSize and typeof(part) == 'Instance' and part.Parent then
		pcall(function()
			part.Size = origSize
		end)
	end
	local adorn = redlinerHitboxViz[part]
	if adorn then
		pcall(function()
			adorn:Destroy()
		end)
	end
	expandedHurtboxSizes[part] = nil
	redlinerHitboxViz[part] = nil
end

local function isEnemyOwner(model)
	local plr = getPlayerFromModel(model)
	return plr ~= nil and plr ~= lplr
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

getEnemyHurtboxesInRange = function(range, origin, requireVisible)
	local root = getLocalRoot()
	origin = origin or (root and root.Position)
	if not origin then
		return {}
	end
	if requireVisible == nil then
		requireVisible = true
	end
	local now = tick()
	if hurtboxScanCache.time + HURTBOX_SCAN_CACHE_TTL > now
		and hurtboxScanCache.range == (range or 0)
		and hurtboxScanCache.visible == requireVisible
		and hurtboxScanCache.origin
		and (hurtboxScanCache.origin - origin).Magnitude < 2 then
		return hurtboxScanCache.results
	end
	local bestPerEnemy = {}
	for _, part in collectionService:GetTagged('Hurtbox') do
		if part.Parent then
			local owner = part:FindFirstAncestorWhichIsA('Model')
			if owner and isEnemyOwner(owner) then
				local plr = getPlayerFromModel(owner)
				if not plr or (not requireVisible or isPlayerVisible(plr)) then
					local dist = (part.Position - origin).Magnitude
					if not range or dist <= range then
						local key = plr and plr.UserId or owner:GetFullName()
						local entry = bestPerEnemy[key]
						if not entry or dist < entry.Distance then
							bestPerEnemy[key] = {Part = part, Distance = dist}
						end
					end
				end
			end
		end
	end
	local sorted = {}
	for _, entry in bestPerEnemy do
		table.insert(sorted, entry)
	end
	table.sort(sorted, function(a, b)
		return a.Distance < b.Distance
	end)
	local results = {}
	for i = 1, math.min(#sorted, 8) do
		table.insert(results, sorted[i].Part)
	end
	hurtboxScanCache.time = now
	hurtboxScanCache.range = range or 0
	hurtboxScanCache.visible = requireVisible
	hurtboxScanCache.origin = origin
	hurtboxScanCache.results = results
	return results
end

local function clearRedlinerHitboxExpansion()
	for part in expandedHurtboxSizes do
		releaseRedlinerHurtboxExpand(part)
	end
	table.clear(expandedHurtboxSizes)
end

refreshRedlinerHitboxExpansion = function()
	if not redlinerHitboxesActive or redlinerHitboxExpand <= 0 then
		clearRedlinerHitboxExpansion()
		return
	end
	lastHitboxExpansionRefresh = tick()
	local keep = {}
	for _, part in collectionService:GetTagged('Hurtbox') do
		if not part.Parent then
			continue
		end
		if shouldExpandRedlinerHurtbox(part) then
			keep[part] = true
			applyRedlinerHurtboxExpand(part)
		end
	end
	for part in expandedHurtboxSizes do
		if not keep[part] then
			releaseRedlinerHurtboxExpand(part)
		end
	end
end

bindRedlinerHitboxExpansion = function()
	if hitboxExpansionBound then
		return
	end
	hitboxExpansionBound = true

	local function scheduleRefresh()
		if not redlinerHitboxesActive or redlinerHitboxExpand <= 0 then
			return
		end
		local now = tick()
		if now - lastHitboxExpansionRefresh < HITBOX_EXPANSION_REFRESH_INTERVAL then
			return
		end
		refreshRedlinerHitboxExpansion()
	end

	collectionService:GetInstanceAddedSignal('Hurtbox'):Connect(function(part)
		if redlinerHitboxesActive and redlinerHitboxExpand > 0 then
			task.defer(function()
				if shouldExpandRedlinerHurtbox(part) then
					applyRedlinerHurtboxExpand(part)
				end
			end)
		end
	end)
	collectionService:GetInstanceRemovedSignal('Hurtbox'):Connect(function(part)
		if expandedHurtboxSizes[part] then
			releaseRedlinerHurtboxExpand(part)
		end
	end)
	playersService.PlayerAdded:Connect(function()
		task.defer(scheduleRefresh)
	end)
	playersService.PlayerRemoving:Connect(function()
		task.defer(scheduleRefresh)
	end)
	runService.Heartbeat:Connect(function()
		if not redlinerHitboxesActive or redlinerHitboxExpand <= 0 then
			return
		end
		if tick() - lastHitboxExpansionRefresh >= HITBOX_EXPANSION_REFRESH_INTERVAL then
			refreshRedlinerHitboxExpansion()
		end
	end)
end

local function getVisibleEnemyHurtboxes()
	return getEnemyHurtboxesInRange(nil, getLocalRoot() and getLocalRoot().Position)
end

local function spawnConeHitboxViz(hitbox, radius, length)
	if not hud.hitboxVisualizerSwingEnabled or typeof(length) ~= 'number' or length <= 0 then
		return
	end
	local cf = hitbox.origin * hitbox.offset
	local part = Instance.new('Part')
	part.Shape = Enum.PartType.Cylinder
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CastShadow = false
	part.Material = Enum.Material.ForceField
	part.Color = hud.hitboxVisualizerColorSetting
	part.Transparency = 0.45
	part.Size = Vector3.new(length, radius * 2, radius * 2)
	part.CFrame = cf * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(0, 0, -length / 2)
	part.Parent = workspaceService
	debrisService:AddItem(part, hud.hitboxVisualizerDurationSetting)
end

describeNearestEnemy = function(range, origin)
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
	if type(mod) ~= 'table' then
		return false
	end
	-- rawget avoids chrono Signal/Connection __index errors on unrelated getgc tables
	return type(rawget(mod, 'new')) == 'function'
		and type(rawget(mod, 'cast')) == 'function'
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

getActiveMeleeReach = function()
	if reachActive then
		return getMeleeReach()
	end
	if autoAttackActive then
		return math.max(autoAttackRangeSetting, BASE_SWORD_REACH)
	end
	return BASE_SWORD_REACH
end

local function getHitboxCastExtend()
	if reachActive then
		return reachExtend
	end
	return 0
end

local function shouldExtendMeleeCombat()
	return reachActive or autoAttackActive
end

safeAimDirection = function(origin, targetPos, fallback)
	local delta = targetPos - origin
	if delta.Magnitude < 0.05 then
		return typeof(fallback) == 'Vector3' and fallback.Magnitude > 0.01 and fallback.Unit or Vector3.new(0, 0, -1)
	end
	return delta.Unit
end

local function trimHurtboxList(list, maxCount)
	if type(list) ~= 'table' then
		return {}
	end
	maxCount = maxCount or 8
	if #list <= maxCount then
		return list
	end
	local trimmed = {}
	for i = 1, maxCount do
		trimmed[i] = list[i]
	end
	return trimmed
end

local function extendAttackHurtboxes(attack)
	if not shouldExtendMeleeCombat() or type(attack) ~= 'table' then
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
	local extended = getEnemyHurtboxesInRange(getActiveMeleeReach(), root.Position, not autoAttackActive)
	for _, part in extended do
		if not table.find(attack.hit_hurtboxes, part) then
			table.insert(attack.hit_hurtboxes, part)
		end
	end
	attack.hit_hurtboxes = trimHurtboxList(attack.hit_hurtboxes, 8)
	return #attack.hit_hurtboxes - before
end

local function looksLikeAttackModule(mod)
	if type(mod) ~= 'table' then
		return false
	end
	return type(rawget(mod, 'new')) == 'function'
		and type(rawget(mod, 'castOnce')) == 'function'
		and type(rawget(mod, 'addHitbox')) == 'function'
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

local clientClassesCache = nil

invalidateClientClassesCache = function()
	clientClassesCache = nil
	table.clear(redlinerApi.inputHandlers)
	redlinerApi.movementClassKey = nil
	redlinerApi.velocityField = nil
end

local function tryRequireClientClasses(startInst)
	if not startInst then
		return nil
	end
	local client = startInst:FindFirstChild('Client')
	local clientRoot = client and client:FindFirstChild('ClientRoot')
	if not clientRoot then
		return nil
	end
	local ok, root = pcall(require, clientRoot)
	if ok and type(root) == 'table' and type(root.Classes) == 'table' then
		return root.Classes
	end
	return nil
end

local function getClientClasses()
	if clientClassesCache then
		return clientClassesCache
	end
	local classes = tryRequireClientClasses(replicatedStorage:FindFirstChild('Start'))
	if not classes and getnilinstances then
		local nilOk, nilInsts = pcall(getnilinstances)
		if nilOk and type(nilInsts) == 'table' then
			for _, inst in nilInsts do
				if inst.Name == 'Start' then
					classes = tryRequireClientClasses(inst)
					if classes then
						break
					end
				end
			end
		end
	end
	if not classes and getgc then
		local gcOk, gc = pcall(getgc, true)
		if gcOk and type(gc) == 'table' then
			for _, value in gc do
				if type(value) == 'table' and type(value.Classes) == 'table' then
					local cls = value.Classes
					if type(cls._x3e046bec2684f59c) == 'table'
						or type(cls._xd2c44c643b0c3fb4) == 'table'
						or type(cls._xf1ad98d2d70b7408) == 'table'
						or type(cls._x7058397dabccd000) == 'table'
						or type(cls._xef0ffbcc2c92f7b4) == 'table' then
						classes = cls
						break
					end
				end
			end
		end
	end
	clientClassesCache = classes
	return classes
end

local function resolveMovementApi()
	if redlinerApi.movementClassKey and redlinerApi.velocityField and #redlinerApi.inputHandlers > 0 then
		return
	end
	local classes = getClientClasses()
	if not classes then
		return
	end
	for _, classKey in MOVEMENT_CLASS_CANDIDATES do
		local ctrl = classes[classKey]
		if type(ctrl) == 'table' then
			for _, field in VELOCITY_FIELD_CANDIDATES do
				if typeof(ctrl[field]) == 'Vector3' then
					redlinerApi.movementClassKey = classKey
					redlinerApi.velocityField = field
					break
				end
			end
		end
		if redlinerApi.velocityField then
			break
		end
	end
	if #redlinerApi.inputHandlers == 0 then
		for _, entry in INPUT_HANDLER_CANDIDATES do
			local handler = classes[entry.class]
			if type(handler) == 'table' and type(handler[entry.method]) == 'function' then
				table.insert(redlinerApi.inputHandlers, entry)
			end
		end
	end
end

local function getMovementController()
	resolveMovementApi()
	local classes = getClientClasses()
	if not classes or not redlinerApi.movementClassKey then
		return nil
	end
	return classes[redlinerApi.movementClassKey]
end

local function getAlwaysParryVelocityMag(_current)
	return math.min(alwaysParryVelocitySetting, CLASH_VELOCITY_SERVER_CAP)
end

applyClashVelocitySpoof = function()
	resolveRedlinerRuntime()
	resolveMovementApi()
	local movement = getMovementController()
	local velocityField = redlinerApi.velocityField
	local root = getLocalRoot()
	if not movement or not velocityField or not root then
		return
	end
	local horiz = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
	if horiz.Magnitude < 2 then
		local cam = workspace.CurrentCamera
		local look = cam and cam.CFrame.LookVector or Vector3.new(0, 0, -1)
		horiz = look * Vector3.new(1, 0, 1)
		if horiz.Magnitude < 0.05 then
			horiz = Vector3.new(0, 0, -1)
		else
			horiz = horiz.Unit
		end
	else
		horiz = horiz.Unit
	end
	movement[velocityField] = horiz * getAlwaysParryVelocityMag()
end

local function aimAutoAttackHitboxes(attack)
	if not autoAttackActive or type(attack) ~= 'table' or type(attack.hitboxes) ~= 'table' then
		return
	end
	local root = getLocalRoot()
	if not root then
		return
	end
	local target = getNearestEnemyInAttackRange(autoAttackRangeSetting)
	if not target then
		return
	end
	local targetPart = target:FindFirstChild('HumanoidRootPart')
		or target:FindFirstChild('Head_Hurtbox')
		or target:FindFirstChild('Head')
	if not targetPart then
		return
	end
	local origin = CFrame.lookAt(root.Position, targetPart.Position)
	for _, hb in attack.hitboxes do
		if type(hb) == 'table' then
			hb.origin = origin
		end
	end
end

local function getMeleePacketBaseFire()
	if not resolveRedlinerRuntime() then
		return nil
	end
	local packet = getResolvedMeleePacket()
	if not packet or type(packet.Fire) ~= 'function' then
		return nil
	end
	if not packet._vapeMeleeBaseFire then
		packet._vapeMeleeBaseFire = packet.Fire
	end
	return packet._vapeMeleeBaseFire
end

local function mirrorMeleePacketFireWrapper(wrapper, oldFire)
	if not getgc or meleePacketGcMirrored then
		return
	end
	meleePacketGcMirrored = true
	local gcOk, gc = pcall(getgc, true)
	if not gcOk or type(gc) ~= 'table' then
		return
	end
	for _, value in gc do
		if type(value) ~= 'table' then
			continue
		end
		local key = redlinerApi.meleePacketKey or MELEE_PACKET_NAME
		local packet = rawget(value, key)
		if type(packet) == 'table' and type(rawget(packet, 'Fire')) == 'function' then
			packet.Fire = wrapper
		end
	end
end

rebuildMeleePacketFireChain = function()
	if not resolveRedlinerRuntime() then
		return false
	end
	local packet = getResolvedMeleePacket()
	local baseFire = getMeleePacketBaseFire()
	if not packet or not baseFire then
		return false
	end
	local fire = baseFire
	if alwaysParryActive then
		local nextFire = fire
		fire = function(packetSelf, sessionToken, weaponId, attackType, position, hurtboxes, velocityMag, ...)
			return nextFire(packetSelf, sessionToken, weaponId, attackType, position, hurtboxes, getAlwaysParryVelocityMag(velocityMag), ...)
		end
	end
	if shouldExtendMeleeCombat() then
		local nextFire = fire
		fire = function(packetSelf, sessionToken, weaponId, attackType, position, hurtboxes, velocityMag, ...)
			return nextFire(packetSelf, sessionToken, weaponId, attackType, position, augmentOutgoingMeleeHurtboxes(hurtboxes), velocityMag, ...)
		end
	end
	packet.Fire = fire
	packet._meleeReachHooked = true
	meleePacketReachHooked = true
	if hookfunction and type(baseFire) == 'function' and not packet._vapeHookfunctionApplied then
		pcall(function()
			local hooked = hookfunction(baseFire, fire)
			if type(hooked) == 'function' then
				packet._meleeReachOriginalFire = hooked
			end
			packet._vapeHookfunctionApplied = true
		end)
	end
	if not meleePacketGcMirrored then
		mirrorMeleePacketFireWrapper(fire, baseFire)
	end
	return true
end

installAlwaysParryHook = function()
	return rebuildMeleePacketFireChain()
end

installAlwaysParryHooks = installAlwaysParryHook

bindAlwaysParryInput = function()
	if alwaysParryInputBound then
		return
	end
	alwaysParryInputBound = true
	inputService.InputBegan:Connect(function(input, processed)
		if processed or not alwaysParryActive then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			applyClashVelocitySpoof()
		end
	end)
end

triggerGameMeleeAttack = function()
	if alwaysParryActive then
		applyClashVelocitySpoof()
	end
	resolveMovementApi()
	local classes = getClientClasses()
	for _, entry in redlinerApi.inputHandlers do
		local inputHandler = classes and classes[entry.class]
		if inputHandler and type(inputHandler[entry.method]) == 'function' then
			local meleeAction = inputHandler[entry.method](inputHandler, 'MELEE')
			if meleeAction and meleeAction.Pressed and type(meleeAction.Pressed.Fire) == 'function' then
				meleeAction.Pressed:Fire()
				if meleeAction.Released and type(meleeAction.Released.Fire) == 'function' then
					task.defer(function()
						meleeAction.Released:Fire()
					end)
				end
				lastAttackAt = tick()
				return true
			end
		end
	end
	return pressAttackClick()
end

augmentOutgoingMeleeHurtboxes = function(hurtboxes)
	if not shouldExtendMeleeCombat() then
		return hurtboxes
	end
	local root = getLocalRoot()
	if not root then
		return hurtboxes
	end
	local extended = getEnemyHurtboxesInRange(getActiveMeleeReach(), root.Position, not autoAttackActive)
	if type(hurtboxes) ~= 'table' then
		hurtboxes = {}
	end
	return trimHurtboxList(mergeHurtboxLists(hurtboxes, extended), 8)
end

installMeleePacketReachHook = function()
	local ok = rebuildMeleePacketFireChain()
	if ok and reachDebugEnabled then
		reachDebugLog('Melee packet Fire hook OK -', redlinerApi.meleePacketKey or MELEE_PACKET_NAME)
	end
	return ok
end

installAttackReachHook = function()
	if attackReachHooked then
		reachDebugSkip('attack_already', 'Attack.castOnce hook already installed at', reachAttackHookSource or '?')
		return true
	end
	local Attack, source = discoverAttackModule()
	if not Attack then
		reachDebugWarn('Attack hook FAILED - module not found')
		return false
	end
	local function wrapCast(methodName)
		local oldMethod = Attack[methodName]
		if type(oldMethod) ~= 'function' then
			return
		end
		local function makeWrapper(oldFn)
			return function(attack, ...)
				aimAutoAttackHitboxes(attack)
				local results = oldFn(attack, ...)
				local added = extendAttackHurtboxes(attack)
				if shouldExtendMeleeCombat() and type(attack.hit_hurtboxes) == 'table' and #attack.hit_hurtboxes > 0 then
					if reachDebugEnabled or (reachActive and reachExtend > 0) then
						reachDebugLog(
							methodName,
							'extend=', reachExtend,
							'totalReach=', getMeleeReach(),
							'added=', added,
							'hurtboxes=', #attack.hit_hurtboxes
						)
					end
					return attack.hit_hurtboxes
				end
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
		reachDebugLog('Attack.' .. methodName, 'hook OK -', detail)
	end
	wrapCast('castOnce')
	wrapCast('castMore')
	wrapCast('castContinuous')
	attackReachHooked = true
	reachAttackHookSource = source
	reachDebugLog('Attack hook OK -', source)
	return true
end

local function buildHitboxCastWrapper(oldCast)
	return function(self)
		local shape = self.shape
		local origSize = self.size
		local origOffset = self.offset
		local origVisible = self.visible
		if hud.hitboxVisualizerSwingEnabled then
			self.visible = true
		end
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
		if getHitboxCastExtend() > 0 then
			local extra = getHitboxCastExtend()
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
				if hud.hitboxVisualizerSwingEnabled then
					self.visible = origVisible
				end
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
				if hud.hitboxVisualizerSwingEnabled then
					self.visible = origVisible
				end
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
		if hud.hitboxVisualizerSwingEnabled and shape == 'Cone' and typeof(origSize) == 'number' then
			local halfAngle = math.rad((self.angle or 45) / 2)
			spawnConeHitboxViz(self, origSize * math.tan(halfAngle), origSize)
		end
		if hud.hitboxVisualizerSwingEnabled then
			self.visible = origVisible
		end
		if not extended and reachDebugEnabled then
			reachDebugLog('cast', shape, 'origSize=', origSize, 'partsHit=', #result, 'taggedHurtboxes=', taggedHurtboxes)
		end
		return result
	end
end

installHitboxReachHook = function()
	if hitboxReachHooked then
		reachDebugSkip('hitbox_already', 'Hitbox.cast hook already installed at', reachHitboxHookSource or '?')
		return true
	end
	local Hitbox, source, attempts = discoverHitboxModule()
	if not Hitbox then
		reachDebugWarn('Hitbox hook FAILED - no module found')
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
	reachDebugLog('Hitbox.cast hook OK -', reachHitboxHookSource)
	if getgc then
		local gcOk, gc = pcall(getgc, true)
		if gcOk and type(gc) == 'table' then
			local extraHits = 0
			for _, value in gc do
				if value ~= Hitbox and looksLikeHitboxModule(value) and rawget(value, 'cast') == oldCast then
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

local function hookGunBulletVizFire(packet, aimIndex, originIndex)
	if not packet or type(packet.Fire) ~= 'function' or packet._bulletVizHooked then
		return false
	end
	local oldFire = packet.Fire
	packet._bulletVizHooked = true
	packet.Fire = function(firePacket, ...)
		local packed = table.pack(...)
		local aimDir = packed[aimIndex]
		local origin = packed[originIndex]
		if typeof(aimDir) == 'Vector3' then
			task.defer(function()
				local startPos = typeof(origin) == 'Vector3' and origin or nil
				if not startPos then
					local root = getLocalRoot()
					startPos = root and root.Position
				end
				if startPos then
					spawnBulletVizRay(startPos, aimDir, hud.hitboxVisualizerColorSetting)
				end
			end)
		end
		return oldFire(firePacket, ...)
	end
	return true
end

installGunBulletVizHook = function()
	if hud.gunBulletVizHooked or not hud.hitboxVisualizerBulletEnabled then
		return true
	end
	if not initPackets() then
		return false
	end
	local hooked = hookGunBulletVizFire(Packets[GUN_SHOT_PACKET_NAME], 2, 3)
	if hookGunBulletVizFire(Packets[GUN_PACKET_NAME], 7, nil) then
		hooked = true
	end
	if hooked then
		hud.gunBulletVizHooked = true
	end
	return hooked
end

installCombatReachHooks = function()
	installHitboxReachHook()
	installAttackReachHook()
	installMeleePacketReachHook()
end

logReachHookStatus = function(context)
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
		'meleePacketHook=', meleePacketReachHooked,
		'packetsLoaded=', Packets ~= nil,
		'hookfunction=', hookfunction ~= nil
	)
end

local combatEventHooked = false

local function installCombatEventHook()
	if combatEventHooked then
		return
	end
	if not resolveRedlinerRuntime() then
		return
	end
	local eventKey = redlinerApi.combatEventKey or COMBAT_EVENT_PACKET
	local packet = Packets and Packets.unreliablePackets and Packets.unreliablePackets[eventKey]
	if not packet or not packet.OnClientEvent or type(packet.OnClientEvent.Connect) ~= 'function' then
		return
	end
	combatEventHooked = true
	packet.OnClientEvent:Connect(function(event)
		if type(event) ~= 'table' then
			return
		end
		local action = event.action
		if action ~= 'clashed' and action ~= 'parried' then
			return
		end
		local char = getLocalCharacter()
		if not char then
			return
		end
		if event.agent == char or event.victim == char then
			clashBlockUntil = tick() + 0.4
			parryBlockAttackUntil = math.max(parryBlockAttackUntil, tick() + 0.25)
		end
	end)
end

bindPacketListeners = function()
	if not resolveRedlinerRuntime() then
		return
	end
	if reachActive or reachDebugEnabled or hud.hitboxVisualizerSwingEnabled or hud.hitboxVisualizerBulletEnabled then
		installCombatReachHooks()
	elseif autoAttackActive and not attackReachHooked then
		installAttackReachHook()
	end
	if (autoAttackActive or alwaysParryActive or reachActive) then
		rebuildMeleePacketFireChain()
	end
	installCombatEventHook()
	if not breakPacketHooked then
		local breakKey = redlinerApi.breakPacketKey or BREAK_PACKET_NAME
		local breakPacket = Packets and Packets[breakKey]
		if breakPacket and breakPacket.OnClientEvent and type(breakPacket.OnClientEvent.Connect) == 'function' then
			breakPacket.OnClientEvent:Connect(function(duration)
				updateBreakState(duration)
			end)
			breakPacketHooked = true
		end
		local resetPacket = Packets and Packets.unreliablePackets and Packets.unreliablePackets._x6e915d67a1f06f56
		if resetPacket and resetPacket.OnClientEvent and type(resetPacket.OnClientEvent.Connect) == 'function' then
			resetPacket.OnClientEvent:Connect(function(isBreaking)
				if isBreaking == false then
					updateBreakState(0)
				end
			end)
		end
	end
	if hud.hitboxVisualizerBulletEnabled then
		installGunBulletVizHook()
	end
	if autoParryActive then
		installGunParryPacketHook()
	end
end

lplr.CharacterAdded:Connect(function()
	task.defer(function()
		if reachActive or autoAttackActive or alwaysParryActive then
			bindPacketListeners()
		end
	end)
end)

end)

run(function()
-- ---------------------------------------------------------------------------
-- Auto attack
-- ---------------------------------------------------------------------------

pressAttackClick = function()
	if tick() < parryBlockAttackUntil then
		return false
	end
	if not isGameWindowFocused() then
		return false
	end

	if mouse1click then
		pcall(mouse1click)
		lastAttackAt = tick()
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
		if not isPlayerVisible(plr) then
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

bindParryScanLoop = function()
	if parryScanBound then
		return
	end
	parryScanBound = true
	local function scanStep()
		if not autoParryActive or not isLocalAlive() then
			return
		end
		local now = tick()
		if now - lastParryScanAt < PARRY_SCAN_INTERVAL then
			return
		end
		lastParryScanAt = now
		scanMeleeWhitelistRealtime()
	end
	runService.PreRender:Connect(scanStep)
	runService.RenderStepped:Connect(scanStep)
end

getNearestEnemyInAttackRange = function(attackRange)
	local now = tick()
	if autoAttackTargetCache.time + HURTBOX_SCAN_CACHE_TTL > now
		and autoAttackTargetCache.range == attackRange then
		return autoAttackTargetCache.model
	end
	local root = getLocalRoot()
	if not root then
		autoAttackTargetCache.time = now
		autoAttackTargetCache.range = attackRange
		autoAttackTargetCache.model = nil
		return nil
	end
	local hurtboxes = getEnemyHurtboxesInRange(attackRange, root.Position, false)
	if #hurtboxes > 0 then
		local owner = hurtboxes[1]:FindFirstAncestorWhichIsA('Model')
		if owner then
			autoAttackTargetCache.time = now
			autoAttackTargetCache.range = attackRange
			autoAttackTargetCache.model = owner
			return owner
		end
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
	autoAttackTargetCache.time = now
	autoAttackTargetCache.range = attackRange
	autoAttackTargetCache.model = nearestModel
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

	local interval = attackDelay > 0 and attackDelay or AUTO_ATTACK_MIN_DELAY
	if tick() - lastAttackAt < interval then
		return
	end

	local target = getNearestEnemyInAttackRange(autoAttackRangeSetting)
	if not target then
		return
	end

	if hud.antiParryEnabled and shouldBlockMeleeAttack(autoAttackRangeSetting) then
		return
	end

	if triggerGameMeleeAttack() then
		lastAttackAt = tick()
	end
end

bindAutoAttackLoop = function()
	if autoAttackLoopBound then
		return
	end
	autoAttackLoopBound = true
	task.spawn(function()
		while true do
			if autoAttackActive then
				tryAutoAttack(attackDelaySetting)
				local interval = attackDelaySetting > 0 and attackDelaySetting or AUTO_ATTACK_MIN_DELAY
				task.wait(math.max(interval, AUTO_ATTACK_SCAN_INTERVAL))
			else
				task.wait(0.25)
			end
		end
	end)
end

combatHeartbeat = function(meleeRange)
	meleeRangeSetting = meleeRange
	if reachActive or reachDebugEnabled or autoParryActive then
		bindPacketListeners()
	end
	if hud.hitboxVisualizerSwingEnabled and not hitboxReachHooked then
		installHitboxReachHook()
	end

	if reachActive and (not hitboxReachHooked or not attackReachHooked or not meleePacketReachHooked) then
		installCombatReachHooks()
		if reachDebugEnabled then
			logReachHookStatus('heartbeat retry')
		end
	elseif (autoAttackActive or alwaysParryActive) and not meleePacketReachHooked then
		resolveRedlinerRuntime(true)
		rebuildMeleePacketFireChain()
		if autoAttackActive and not attackReachHooked then
			installAttackReachHook()
		end
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
			'hitboxSource=', reachHitboxHookSource or 'none',
			'attackSource=', reachAttackHookSource or 'none',
			'alive=', isLocalAlive(),
			'rootPos=', root and tostring(root.Position) or 'nil',
			'nearbyEnemyHurtboxes=', nearbyCount,
			'nearestEnemy=', nearestName or 'none',
			'nearestDist=', nearestDist and string.format('%.2f', nearestDist) or 'n/a',
			'taggedHurtboxes=', #collectionService:GetTagged('Hurtbox')
		)
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
					if isPlayerVisible(plr) then
						threatCount += 1
					end
				end
			end
			print('[REDLINER] status | enemies=', enemyCount, 'watched=', watchedCount, 'inThreat=', threatCount, 'meleeRange=', meleeRange, 'threatRange=', threatRangeSetting)
		end
	end

	if hud.hudTickCallback then
		pcall(hud.hudTickCallback)
	end
end

end)


-- ---------------------------------------------------------------------------
-- HUD overlays
-- ---------------------------------------------------------------------------

run(function()
	local DRAW_PRESET_ANCHORS = {
		['Center-Top'] = {0.5, 0, 0.5, 0},
		Center = {0.5, 0.5, 0.5, 0.5},
		Bottom = {0.5, 1, 0.5, 1},
	}
	local GUN_DRAW_COLORS = {
		Castigate = Color3.fromRGB(255, 140, 50),
		Phoenix = Color3.fromRGB(255, 70, 70),
		Siege = Color3.fromRGB(255, 220, 60),
		Monarch = Color3.fromRGB(180, 100, 255),
	}
	local tweenService = cloneref(game:GetService('TweenService'))
	local hudGui
	local drawContainer
	local drawCards = {}
	local threatOverlay
	local threatPanel
	local threatTitle
	local threatSub
	local threatFlash
	local breakOverlay
	local breakTitle
	local breakSub
	local breakBarBg
	local breakBarFill
	local lastPrimaryKey = ''
	local enemyAdornPool = {}

	local function ensureHudGui()
		if hudGui and hudGui.Parent then
			return hudGui
		end
		local playerGui = lplr:FindFirstChild('PlayerGui') or lplr:WaitForChild('PlayerGui')
		local existing = playerGui:FindFirstChild('RedlinerHUD')
		if existing then
			hudGui = existing
		else
			hudGui = Instance.new('ScreenGui')
			hudGui.Name = 'RedlinerHUD'
			hudGui.ResetOnSpawn = false
			hudGui.IgnoreGuiInset = true
			hudGui.DisplayOrder = 50
			hudGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			hudGui.Enabled = true
			hudGui.Parent = playerGui
		end
		if not drawContainer or not drawContainer.Parent then
			drawContainer = Instance.new('Frame')
			drawContainer.Name = 'DrawTimerRoot'
			drawContainer.BackgroundTransparency = 1
			drawContainer.BorderSizePixel = 0
			drawContainer.Parent = hudGui
			local drawLayout = Instance.new('UIListLayout')
			drawLayout.FillDirection = Enum.FillDirection.Vertical
			drawLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			drawLayout.SortOrder = Enum.SortOrder.LayoutOrder
			drawLayout.Padding = UDim.new(0, 8)
			drawLayout.Parent = drawContainer
		end
		if not threatOverlay or not threatOverlay.Parent then
			threatOverlay = Instance.new('Frame')
			threatOverlay.Name = 'ThreatOverlay'
			threatOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
			threatOverlay.BackgroundTransparency = 1
			threatOverlay.BorderSizePixel = 0
			threatOverlay.Size = UDim2.fromScale(1, 1)
			threatOverlay.Visible = false
			threatOverlay.Parent = hudGui

			threatFlash = Instance.new('Frame')
			threatFlash.Name = 'ThreatFlash'
			threatFlash.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
			threatFlash.BackgroundTransparency = 1
			threatFlash.BorderSizePixel = 0
			threatFlash.Size = UDim2.fromScale(1, 1)
			threatFlash.ZIndex = 2
			threatFlash.Parent = threatOverlay

			threatPanel = Instance.new('Frame')
			threatPanel.Name = 'ThreatPanel'
			threatPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
			threatPanel.BackgroundTransparency = 0.18
			threatPanel.BorderSizePixel = 0
			threatPanel.AnchorPoint = Vector2.new(0.5, 1)
			threatPanel.Size = UDim2.fromOffset(420, 72)
			threatPanel.Position = UDim2.new(0.5, 0, 0.9, 0)
			threatPanel.ZIndex = 3
			threatPanel.Parent = threatOverlay
			local panelCorner = Instance.new('UICorner')
			panelCorner.CornerRadius = UDim.new(0, 10)
			panelCorner.Parent = threatPanel
			local panelStroke = Instance.new('UIStroke')
			panelStroke.Color = Color3.fromRGB(55, 55, 68)
			panelStroke.Thickness = 1
			panelStroke.Transparency = 0.35
			panelStroke.Parent = threatPanel

			local threatAccent = Instance.new('Frame')
			threatAccent.Name = 'ThreatAccent'
			threatAccent.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
			threatAccent.BorderSizePixel = 0
			threatAccent.Size = UDim2.new(0, 4, 1, -12)
			threatAccent.Position = UDim2.new(0, 8, 0, 6)
			threatAccent.ZIndex = 4
			threatAccent.Parent = threatPanel
			local accentCorner = Instance.new('UICorner')
			accentCorner.CornerRadius = UDim.new(1, 0)
			accentCorner.Parent = threatAccent

			threatTitle = Instance.new('TextLabel')
			threatTitle.Name = 'ThreatTitle'
			threatTitle.BackgroundTransparency = 1
			threatTitle.Position = UDim2.new(0, 20, 0, 8)
			threatTitle.Size = UDim2.new(1, -28, 0, 30)
			threatTitle.Font = Enum.Font.GothamBlack
			threatTitle.TextXAlignment = Enum.TextXAlignment.Left
			threatTitle.TextColor3 = Color3.fromRGB(255, 90, 90)
			threatTitle.TextSize = 24
			threatTitle.Text = ''
			threatTitle.Parent = threatPanel

			threatSub = Instance.new('TextLabel')
			threatSub.Name = 'ThreatSub'
			threatSub.BackgroundTransparency = 1
			threatSub.Position = UDim2.new(0, 20, 0, 38)
			threatSub.Size = UDim2.new(1, -28, 0, 24)
			threatSub.Font = Enum.Font.GothamMedium
			threatSub.TextXAlignment = Enum.TextXAlignment.Left
			threatSub.TextColor3 = Color3.fromRGB(185, 185, 195)
			threatSub.TextSize = 14
			threatSub.Text = ''
			threatSub.Parent = threatPanel
		end
		if not breakOverlay or not breakOverlay.Parent then
			breakOverlay = Instance.new('Frame')
			breakOverlay.Name = 'BreakOverlay'
			breakOverlay.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
			breakOverlay.BackgroundTransparency = 0.3
			breakOverlay.BorderSizePixel = 0
			breakOverlay.AnchorPoint = Vector2.new(0.5, 0)
			breakOverlay.Position = UDim2.fromScale(0.5, 0.04)
			breakOverlay.Size = UDim2.fromOffset(300, 60)
			breakOverlay.Visible = false
			breakOverlay.ZIndex = 8
			breakOverlay.Parent = hudGui

			local breakCorner = Instance.new('UICorner')
			breakCorner.CornerRadius = UDim.new(0, 10)
			breakCorner.Parent = breakOverlay

			breakTitle = Instance.new('TextLabel')
			breakTitle.Name = 'BreakTitle'
			breakTitle.BackgroundTransparency = 1
			breakTitle.Size = UDim2.fromScale(1, 0.52)
			breakTitle.Font = Enum.Font.GothamBold
			breakTitle.TextScaled = true
			breakTitle.TextColor3 = Color3.fromRGB(255, 70, 70)
			breakTitle.Text = 'BREAK LOCK'
			breakTitle.ZIndex = 9
			breakTitle.Parent = breakOverlay

			breakSub = Instance.new('TextLabel')
			breakSub.Name = 'BreakSub'
			breakSub.BackgroundTransparency = 1
			breakSub.Position = UDim2.fromScale(0, 0.5)
			breakSub.Size = UDim2.fromScale(1, 0.3)
			breakSub.Font = Enum.Font.GothamMedium
			breakSub.TextScaled = true
			breakSub.TextColor3 = Color3.fromRGB(220, 220, 220)
			breakSub.Text = ''
			breakSub.ZIndex = 9
			breakSub.Parent = breakOverlay

			breakBarBg = Instance.new('Frame')
			breakBarBg.Name = 'BreakBarBg'
			breakBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
			breakBarBg.BorderSizePixel = 0
			breakBarBg.Position = UDim2.fromScale(0.06, 0.84)
			breakBarBg.Size = UDim2.fromScale(0.88, 0.1)
			breakBarBg.ZIndex = 9
			breakBarBg.Parent = breakOverlay
			local breakBarCorner = Instance.new('UICorner')
			breakBarCorner.CornerRadius = UDim.new(1, 0)
			breakBarCorner.Parent = breakBarBg

			breakBarFill = Instance.new('Frame')
			breakBarFill.Name = 'BreakBarFill'
			breakBarFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
			breakBarFill.BorderSizePixel = 0
			breakBarFill.Size = UDim2.fromScale(1, 1)
			breakBarFill.ZIndex = 10
			breakBarFill.Parent = breakBarBg
			local breakFillCorner = Instance.new('UICorner')
			breakFillCorner.CornerRadius = UDim.new(1, 0)
			breakFillCorner.Parent = breakBarFill
		end
		return hudGui
	end

	local function applyDrawLayout()
		if not drawContainer then
			return
		end
		local preset = DRAW_PRESET_ANCHORS[hud.drawTimerPositionPresetSetting] or DRAW_PRESET_ANCHORS['Center-Top']
		local scale = math.clamp(hud.drawTimerScaleSetting, 0.5, 2)
		drawContainer.AnchorPoint = Vector2.new(preset[1], preset[2])
		drawContainer.Position = UDim2.fromScale(preset[3], preset[4])
		drawContainer.Size = UDim2.fromOffset(math.floor(420 * scale), 0)
		drawContainer.AutomaticSize = Enum.AutomaticSize.Y
	end

	local function ensureDrawCard(index)
		local card = drawCards[index]
		if card and card.Parent then
			return card
		end
		card = Instance.new('Frame')
		card.Name = 'DrawCard' .. index
		card.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
		card.BackgroundTransparency = 1 - hud.drawTimerOpacitySetting
		card.BorderSizePixel = 0
		card.Size = UDim2.new(1, 0, 0, 0)
		card.AutomaticSize = Enum.AutomaticSize.Y
		card.LayoutOrder = index
		card.Visible = false
		card.Parent = drawContainer
		local corner = Instance.new('UICorner')
		corner.CornerRadius = UDim.new(0, 10)
		corner.Parent = card
		local pad = Instance.new('UIPadding')
		pad.PaddingTop = UDim.new(0, 10)
		pad.PaddingBottom = UDim.new(0, 10)
		pad.PaddingLeft = UDim.new(0, 14)
		pad.PaddingRight = UDim.new(0, 14)
		pad.Parent = card

		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.BackgroundTransparency = 1
		title.Size = UDim2.new(1, 0, 0, math.floor(hud.drawTimerFontSizeSetting * 1.35))
		title.Font = Enum.Font.GothamBold
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextSize = hud.drawTimerFontSizeSetting
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.Text = ''
		title.Parent = card

		local timer = Instance.new('TextLabel')
		timer.Name = 'Timer'
		timer.BackgroundTransparency = 1
		timer.Position = UDim2.fromOffset(0, math.floor(hud.drawTimerFontSizeSetting * 1.2))
		timer.Size = UDim2.new(1, 0, 0, math.floor(hud.drawTimerFontSizeSetting * 1.1))
		timer.Font = Enum.Font.GothamBlack
		timer.TextXAlignment = Enum.TextXAlignment.Left
		timer.TextSize = math.floor(hud.drawTimerFontSizeSetting * 1.15)
		timer.TextColor3 = Color3.fromRGB(255, 220, 120)
		timer.Text = ''
		timer.Parent = card

		local barBg = Instance.new('Frame')
		barBg.Name = 'BarBg'
		barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
		barBg.BorderSizePixel = 0
		barBg.Position = UDim2.fromOffset(0, math.floor(hud.drawTimerFontSizeSetting * 2.5))
		barBg.Size = UDim2.new(1, 0, 0, 8)
		barBg.Parent = card
		local barBgCorner = Instance.new('UICorner')
		barBgCorner.CornerRadius = UDim.new(1, 0)
		barBgCorner.Parent = barBg

		local barFill = Instance.new('Frame')
		barFill.Name = 'BarFill'
		barFill.BackgroundColor3 = Color3.fromRGB(255, 140, 50)
		barFill.BorderSizePixel = 0
		barFill.Size = UDim2.fromScale(1, 1)
		barFill.Parent = barBg
		local barFillCorner = Instance.new('UICorner')
		barFillCorner.CornerRadius = UDim.new(1, 0)
		barFillCorner.Parent = barFill

		drawCards[index] = card
		return card
	end

	local function getActiveGunDrawInfo(plr)
		if not plr then
			return nil
		end
		for _, model in getEnemyModels(plr) do
			for _, track in getAllPlayingTracks(model) do
				if track.IsPlaying then
					local _, animId = getTrackAnimInfo(track)
					local gunName = GUN_DRAW_ANIM_IDS[normalizeAnimId(animId)]
					if gunName then
						local delay = getEffectiveGunParryDelay(gunName)
						local remaining = getAdjustedParryDelay(getGunParryDelay(gunName), track.TimePosition)
						return gunName, remaining, delay, 'DRAW'
					end
					local shotGun = GUN_SHOT_ANIM_IDS[normalizeAnimId(animId)]
					if shotGun then
						local delay = gunShotWindowSetting
						local remaining = math.max(0, delay - track.TimePosition)
						return shotGun, remaining, delay, 'SHOT'
					end
				end
			end
		end
		return nil
	end

	local function collectDrawEntries()
		local entries = {}
		local seen = {}
		for _, plr in playersService:GetPlayers() do
			if plr ~= lplr and plr.Character and isPlayerVisible(plr) then
				local char = plr.Character
				local dist = getClosestEnemyDistance(plr)
					local gunName, remaining, delay, kind = getActiveGunDrawInfo(plr)
					if gunName then
						remaining = math.max(0, remaining + hud.drawTimerOffsetSetting)
						table.insert(entries, {
							name = plr.Name,
							gun = gunName,
							remaining = remaining,
							delay = delay,
							kind = kind,
							dist = dist,
						})
						seen[plr] = true
					end
					if not seen[plr] then
						for _, model in getEnemyModels(plr) do
							if model and model.Parent then
								for _, desc in model:GetDescendants() do
									if isGlintInstance(desc) then
										local glintGun = detectEquippedGun(char)
										local delay = getEffectiveGunParryDelay(glintGun)
										local rem = math.max(0, delay + hud.drawTimerOffsetSetting)
										table.insert(entries, {
											name = plr.Name,
											gun = glintGun,
											remaining = rem,
											delay = delay,
											kind = 'GLINT',
											dist = dist,
										})
										seen[plr] = true
										break
									end
								end
							end
							if seen[plr] then
								break
							end
						end
					end
			end
		end
		table.sort(entries, function(a, b)
			return a.remaining < b.remaining
		end)
		local out = {}
		for i = 1, math.min(#entries, hud.drawTimerMaxEntriesSetting) do
			out[i] = entries[i]
		end
		return out
	end

	local playerEspOverlays = {}
	local bulletWarnState = {}
	local aimlockState = {}
	local aimlockRayPool = {}

	local function getGameCamera()
		return workspace.CurrentCamera
	end

	local function newDraw(typeName, props)
		if not Drawing then
			return nil
		end
		local obj = Drawing.new(typeName)
		for key, val in props do
			obj[key] = val
		end
		obj.Visible = false
		return obj
	end

	local function hideDraw(obj)
		if obj then
			obj.Visible = false
		end
	end

	local function destroyEspOverlay(plr)
		local overlay = playerEspOverlays[plr]
		if not overlay then
			return
		end
		for _, obj in overlay do
			if obj and obj.Remove then
				pcall(function()
					obj.Visible = false
					obj:Remove()
				end)
			end
		end
		playerEspOverlays[plr] = nil
		bulletWarnState[plr] = nil
	end

	local function ensureEspOverlay(plr)
		if playerEspOverlays[plr] then
			return playerEspOverlays[plr]
		end
		if not Drawing then
			return nil
		end
		local overlay = {
			DrawGun = newDraw('Text', {Center = true, Size = 11, ZIndex = 4, Color = Color3.fromRGB(200, 200, 210)}),
			DrawTime = newDraw('Text', {Center = true, Size = 14, ZIndex = 5, Color = Color3.fromRGB(255, 220, 120)}),
			DrawBarBg = newDraw('Line', {Thickness = 3, ZIndex = 2, Transparency = 0.45, Color = Color3.fromRGB(25, 25, 32)}),
			DrawBarFill = newDraw('Line', {Thickness = 2, ZIndex = 3, Color = Color3.fromRGB(255, 150, 55)}),
			WarnText = newDraw('Text', {Center = true, Size = 12, ZIndex = 4, Color = Color3.fromRGB(255, 95, 95)}),
			ImpactBg = newDraw('Line', {Thickness = 4, ZIndex = 2, Transparency = 0.4, Color = Color3.fromRGB(18, 18, 24)}),
			ImpactFill = newDraw('Line', {Thickness = 3, ZIndex = 3, Color = Color3.fromRGB(255, 120, 60)}),
			HealthBg = newDraw('Line', {Thickness = 4, ZIndex = 2, Transparency = 0.4, Color = Color3.fromRGB(18, 18, 24)}),
			HealthFill = newDraw('Line', {Thickness = 3, ZIndex = 3, Color = Color3.fromRGB(80, 220, 120)}),
		}
		playerEspOverlays[plr] = overlay
		return overlay
	end

	local function getPlayerScreenBox(plr)
		local ent = entitylib.getEntity(plr)
		local root = ent and ent.RootPart
		if not root then
			local char = plr.Character
			root = char and char:FindFirstChild('HumanoidRootPart')
		end
		if not root or not getGameCamera() then
			return nil
		end
		local cam = getGameCamera()
		local hipHeight = ent and ent.HipHeight or 2
		local rootPos, rootVis = cam:WorldToViewportPoint(root.Position)
		if not rootVis then
			return nil
		end
		local topPos = cam:WorldToViewportPoint((CFrame.lookAlong(root.Position, cam.CFrame.LookVector) * CFrame.new(2, hipHeight, 0)).Position)
		local bottomPos = cam:WorldToViewportPoint((CFrame.lookAlong(root.Position, cam.CFrame.LookVector) * CFrame.new(-2, -hipHeight - 1, 0)).Position)
		local sizex = math.abs(topPos.X - bottomPos.X)
		local sizey = math.abs(topPos.Y - bottomPos.Y)
		return rootPos.X - sizex / 2, rootPos.Y - sizey / 2, sizex, sizey
	end

	local function hideEspOverlayDraw(overlay)
		for _, obj in overlay do
			hideDraw(obj)
		end
	end

	local function drawVerticalBar(bgLine, fillLine, x, topY, height, ratio, color)
		if height < 4 then
			hideDraw(bgLine)
			hideDraw(fillLine)
			return
		end
		bgLine.From = Vector2.new(x, topY)
		bgLine.To = Vector2.new(x, topY + height)
		bgLine.Visible = true
		local fillHeight = math.max(1, height * math.clamp(ratio, 0, 1))
		fillLine.From = Vector2.new(x, topY + height - fillHeight)
		fillLine.To = Vector2.new(x, topY + height)
		fillLine.Color = color
		fillLine.Visible = ratio > 0.01
	end

	local function setAimlockRay(plr, fromWorld, toWorld, visible, color, thickness)
		local entry = aimlockRayPool[plr]
		if not visible or typeof(fromWorld) ~= 'Vector3' or typeof(toWorld) ~= 'Vector3' then
			if entry and entry.part then
				entry.part.Parent = nil
			end
			return
		end
		if not entry then
			entry = {}
			aimlockRayPool[plr] = entry
		end
		if not entry.part then
			entry.part = Instance.new('Part')
			entry.part.Name = 'RedlinerAimlockTracer'
		end
		spawnWorldTracer(fromWorld, toWorld, color or Color3.fromRGB(255, 60, 60), {
			part = entry.part,
			thickness = math.clamp((thickness or 1.5) * 0.06, 0.08, 0.22),
			transparency = 0.22,
			duration = nil,
		})
	end

	local function updateAimlockDetector()
		if not hud.aimlockDetectorEnabled then
			for plr in aimlockRayPool do
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
			end
			return
		end
		local myHead = getEntityHeadPart(lplr)
		if not myHead then
			for plr in aimlockRayPool do
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
			end
			return
		end
		local myPos = myHead.Position
		local threshold = math.clamp(hud.aimlockThresholdSetting, 0.96, 0.999)
		local needStreak = math.max(30, hud.aimlockMinSamplesSetting)
		local drawn = {}

		for _, plr in playersService:GetPlayers() do
			if plr == lplr then
				continue
			end
			if not isPlayerVisible(plr) then
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
				continue
			end
			local head = getEntityHeadPart(plr)
			if not head then
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
				continue
			end
			local char = plr.Character
			local enemyRoot = char and char:FindFirstChild('HumanoidRootPart')
			if not enemyRoot then
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
				continue
			end
			drawn[plr] = true
			local toMe = myPos - head.Position
			local dist = toMe.Magnitude
			if dist < 8 or dist > 250 then
				aimlockState[plr.UserId] = {streak = 0, flagged = false, lastDot = 0}
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
				continue
			end
			local look = head.CFrame.LookVector
			local toMeUnit = toMe.Unit
			local dot = look:Dot(toMeUnit)
			local bodyDot = enemyRoot.CFrame.LookVector:Dot(toMeUnit)
			local enemyVel = enemyRoot.AssemblyLinearVelocity
			local runningAtMe = enemyVel.Magnitude > 7 and enemyVel.Unit:Dot(toMeUnit) > 0.65
			local state = aimlockState[plr.UserId] or {streak = 0, flagged = false, lastDot = 0}
			aimlockState[plr.UserId] = state

			local aimMismatch = math.abs(dot - bodyDot) > 0.18
			local perfectTrack = dot >= threshold and not runningAtMe and aimMismatch
			if perfectTrack then
				state.streak = math.min(state.streak + 1, 240)
			else
				state.streak = 0
			end
			state.lastDot = dot

			local suspicious = state.streak >= math.floor(needStreak * 0.6) and dot >= threshold - 0.005
			local showRay = hud.aimlockVisualizeSetting and suspicious
			local rayColor = (state.streak >= needStreak) and Color3.fromRGB(255, 55, 55) or Color3.fromRGB(255, 195, 75)
			local rayThickness = suspicious and 2.5 or 1.5
			local rayEnd = suspicious and myPos or (head.Position + look.Unit * math.min(dist, 120))
			setAimlockRay(plr, head.Position, rayEnd, showRay, rayColor, rayThickness)

			if not state.flagged and state.streak >= needStreak and dot >= threshold then
				state.flagged = true
				local pct = math.floor(dot * 1000) / 10
				notif('Aimlock Detector', plr.Name .. ' flagged - sustained head tracking ' .. pct .. '%', 45, 'warning')
				discordEmbed(
					'ðŸŽ¯ Aimlock Detected',
					'**' .. plr.Name .. '** sustained perfect head tracking without movement explain.',
					16724787,
					{
						{name = 'Player', value = plr.Name, inline = true},
						{name = 'User ID', value = tostring(plr.UserId), inline = true},
						{name = 'Tracking', value = pct .. '%', inline = true},
						{name = 'Streak', value = tostring(state.streak), inline = true},
						{name = 'Threshold', value = math.floor(threshold * 1000) / 10 .. '%', inline = true},
						{name = 'Distance', value = string.format('%.1f studs', dist), inline = true},
					}
				)
			end
		end

		for plr in aimlockRayPool do
			if not drawn[plr] then
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
			end
		end
	end

	local function updatePlayerWorldEsp()
		local anyEsp = (hud.drawTimerEnabled and hud.drawTimerWorldEspSetting)
			or hud.bulletWarningsEnabled
			or hud.impactEspEnabled
			or hud.healthEspEnabled
		if not anyEsp then
			for plr in playerEspOverlays do
				destroyEspOverlay(plr)
			end
			return
		end

		local active = {}
		local textScale = math.clamp(hud.drawTimerEspScaleSetting, 0.6, 2)
		local barOffset = math.floor(7 * textScale)
		for _, plr in playersService:GetPlayers() do
			if plr == lplr then
				continue
			end
			if not isPlayerVisible(plr) then
				destroyEspOverlay(plr)
				continue
			end
			active[plr] = true
			local overlay = ensureEspOverlay(plr)
			if not overlay then
				continue
			end
			local posx, posy, sizex, sizey = getPlayerScreenBox(plr)
			if not posx then
				hideEspOverlayDraw(overlay)
				continue
			end
			local ix, iy = math.floor(posx), math.floor(posy)
			local isx, isy = math.floor(sizex), math.floor(sizey)
			local centerX = ix + isx / 2
			local barTop = iy + 2
			local barHeight = math.max(12, isy - 4)

			hideEspOverlayDraw(overlay)

			local showDraw = hud.drawTimerEnabled and hud.drawTimerWorldEspSetting
			local gunName, remaining, delay, kind = getActiveGunDrawInfo(plr)
			if showDraw and gunName then
				remaining = math.max(0, remaining + hud.drawTimerOffsetSetting)
				local accentColor = GUN_DRAW_COLORS[gunName] or GUN_DRAW_COLORS.Castigate
				local topY = iy - math.floor(30 * textScale)
				overlay.DrawGun.Size = math.floor(11 * textScale)
				overlay.DrawGun.Text = string.upper(kind or 'DRAW') .. ' Â· ' .. gunName
				overlay.DrawGun.Color = accentColor
				overlay.DrawGun.Position = Vector2.new(centerX, topY)
				overlay.DrawGun.Visible = true
				overlay.DrawTime.Size = math.floor(14 * textScale)
				overlay.DrawTime.Text = string.format('%.2fs', remaining)
				overlay.DrawTime.Color = remaining < 0.25 and Color3.fromRGB(255, 70, 70) or accentColor
				overlay.DrawTime.Position = Vector2.new(centerX, topY + math.floor(13 * textScale))
				overlay.DrawTime.Visible = true
				if delay > 0 then
					local ratio = math.clamp(remaining / delay, 0, 1)
					local barY = topY + math.floor(24 * textScale)
					local barHalf = math.floor(34 * textScale)
					overlay.DrawBarBg.From = Vector2.new(centerX - barHalf, barY)
					overlay.DrawBarBg.To = Vector2.new(centerX + barHalf, barY)
					overlay.DrawBarBg.Visible = true
					overlay.DrawBarFill.From = Vector2.new(centerX - barHalf, barY)
					overlay.DrawBarFill.To = Vector2.new(centerX - barHalf + barHalf * 2 * ratio, barY)
					overlay.DrawBarFill.Color = remaining < 0.25 and Color3.fromRGB(255, 50, 50) or accentColor
					overlay.DrawBarFill.Visible = true
				end
			end

			local heat = getPlayerReadOnlyNumber(plr, 'heat')
			local perBullet = getPlayerReadOnlyNumber(plr, 'heat_per_bullet')
			local warnState = bulletWarnState[plr] or {active = false, offCount = 0}
			if hud.bulletWarningsEnabled and heat and perBullet and perBullet > 0 then
				if heat >= perBullet * 0.97 then
					warnState.active = true
					warnState.offCount = 0
				elseif warnState.active then
					warnState.offCount += 1
					if warnState.offCount >= 6 or heat < perBullet * 0.8 then
						warnState.active = false
					end
				end
			else
				warnState.active = false
				warnState.offCount = 0
			end
			bulletWarnState[plr] = warnState
			if warnState.active then
				overlay.WarnText.Size = math.floor(12 * textScale)
				overlay.WarnText.Text = hud.bulletWarningsTextSetting
				overlay.WarnText.Position = Vector2.new(centerX, iy + isy + math.floor(10 * textScale))
				overlay.WarnText.Visible = true
			end

			if hud.impactEspEnabled then
				local impact = getPlayerReadOnlyNumber(plr, 'impact') or 0
				local maxImpact = math.max(1, hud.impactEspMaxSetting)
				local ratio = math.clamp(impact / maxImpact, 0, 1)
				drawVerticalBar(
					overlay.ImpactBg, overlay.ImpactFill,
					ix - barOffset, barTop, barHeight, ratio,
					Color3.fromHSV((1 - ratio) * 0.33, 0.89, 0.75)
				)
			end

			if hud.healthEspEnabled then
				local health = getPlayerReadOnlyNumber(plr, 'health')
				local healthMax = getPlayerReadOnlyNumber(plr, 'health_max')
				if health and healthMax and healthMax > 0 then
					local ratio = math.clamp(health / healthMax, 0, 1)
					drawVerticalBar(
						overlay.HealthBg, overlay.HealthFill,
						ix + isx + barOffset, barTop, barHeight, ratio,
						Color3.fromHSV(ratio * 0.33, 0.85, 0.9)
					)
				end
			end
		end

		for plr in playerEspOverlays do
			if not active[plr] then
				destroyEspOverlay(plr)
			end
		end
	end

	local function updateDrawHud()
		if not drawContainer then
			return
		end
		local useScreen = hud.drawTimerEnabled and hud.drawTimerScreenHudSetting
		if not useScreen then
			drawContainer.Visible = false
			return
		end
		if not hud.drawTimerEnabled then
			drawContainer.Visible = false
			return
		end
		ensureHudGui()
		applyDrawLayout()
		drawContainer.Visible = true
		local entries = collectDrawEntries()
		local hasEntries = #entries > 0
		for i = 1, hud.drawTimerMaxEntriesSetting do
			local card = ensureDrawCard(i)
			local entry = entries[i]
			if entry then
				local gunColor = GUN_DRAW_COLORS[entry.gun] or GUN_DRAW_COLORS.Castigate
				card.Visible = true
				card.BackgroundTransparency = 1 - hud.drawTimerOpacitySetting
				local title = card:FindFirstChild('Title')
				local timer = card:FindFirstChild('Timer')
				local barBg = card:FindFirstChild('BarBg')
				local barFill = barBg and barBg:FindFirstChild('BarFill')
				if title then
					title.TextSize = hud.drawTimerFontSizeSetting
					title.Text = string.format('%s  |  %s', entry.name, entry.gun)
					title.TextColor3 = gunColor
				end
				if timer then
					timer.TextSize = math.floor(hud.drawTimerFontSizeSetting * 1.15)
					timer.Text = string.format('%s  %.2fs', entry.kind, entry.remaining)
					timer.TextColor3 = gunColor
				end
				if barFill and entry.delay > 0 then
					local ratio = math.clamp(entry.remaining / entry.delay, 0, 1)
					barFill.Size = UDim2.fromScale(ratio, 1)
					local urgent = entry.remaining < 0.25
					barFill.BackgroundColor3 = urgent and (tick() % 0.2 < 0.1 and Color3.fromRGB(255, 40, 40) or gunColor) or gunColor
				end
			else
				card.Visible = false
			end
		end
		if not hasEntries then
			local standby = ensureDrawCard(1)
			standby.Visible = true
			standby.BackgroundTransparency = 1 - hud.drawTimerOpacitySetting
			local title = standby:FindFirstChild('Title')
			local timer = standby:FindFirstChild('Timer')
			local barBg = standby:FindFirstChild('BarBg')
			if title then
				title.Text = 'DRAW TIMER'
				title.TextColor3 = Color3.fromRGB(255, 220, 120)
			end
			if timer then
				timer.Text = 'Scanning threats in range...'
				timer.TextColor3 = Color3.fromRGB(200, 200, 200)
			end
			if barBg then
				local barFill = barBg:FindFirstChild('BarFill')
				if barFill then
					barFill.Size = UDim2.fromScale(0.35, 1)
					barFill.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
				end
			end
		end
	end

	local function updateEnemyHurtboxViz()
		if not hud.hitboxVisualizerEnemyEnabled or not isLocalAlive() then
			for part, adorn in enemyAdornPool do
				if adorn then
					adorn.Visible = false
				end
			end
			return
		end
		local now = tick()
		if now - hud.lastEnemyHurtboxVizAt < 0.5 then
			return
		end
		hud.lastEnemyHurtboxVizAt = now
		local active = {}
		for _, part in getVisibleEnemyHurtboxes() do
			active[part] = true
			local adorn = enemyAdornPool[part]
			if not adorn then
				adorn = Instance.new('BoxHandleAdornment')
				adorn.Name = 'RedlinerHurtboxViz'
				adorn.AlwaysOnTop = true
				adorn.ZIndex = 5
				adorn.Adornee = part
				adorn.Parent = workspaceService
				enemyAdornPool[part] = adorn
			end
			adorn.Color3 = hud.hitboxVisualizerColorSetting
			adorn.Transparency = 0.45
			adorn.Size = part.Size
			adorn.Visible = true
		end
		for part, adorn in enemyAdornPool do
			if not active[part] then
				adorn.Visible = false
			end
		end
	end

	local function updateBreakTimerHud()
		if not breakOverlay then
			return
		end
		if not hud.breakTimerEnabled then
			breakOverlay.Visible = false
			return
		end
		local remaining = math.max(0, breakState.endsAt - tick())
		if remaining <= 0 then
			breakState.active = false
		end
		if breakState.active and breakState.duration > 0 then
			breakOverlay.Visible = true
			breakTitle.Text = string.format('BREAK LOCK  %.2fs', remaining)
			breakTitle.TextColor3 = remaining <= 0.35 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 110, 90)
			breakSub.Text = string.format('server duration %.2fs', breakState.duration)
			local ratio = math.clamp(remaining / breakState.duration, 0, 1)
			breakBarFill.Size = UDim2.fromScale(ratio, 1)
			breakBarFill.BackgroundColor3 = remaining <= 0.35 and Color3.fromRGB(255, 55, 55) or Color3.fromRGB(255, 140, 90)
		else
			breakOverlay.Visible = false
		end
	end

	local function updateHud()
		updateDrawHud()
		updateBreakTimerHud()
		updatePlayerWorldEsp()
		updateAimlockDetector()
		updateEnemyHurtboxViz()
	end

	hud.hudTickCallback = updateHud

	local hudUpdateBound = false
	local function bindHudUpdateLoop()
		if hudUpdateBound then
			return
		end
		hudUpdateBound = true
		runService.RenderStepped:Connect(function()
			if not hud.drawTimerEnabled
				and not hud.bulletWarningsEnabled and not hud.impactEspEnabled
				and not hud.healthEspEnabled and not hud.aimlockDetectorEnabled
				and not hud.breakTimerEnabled then
				return
			end
			if hud.hudTickCallback then
				pcall(hud.hudTickCallback)
			end
		end)
	end
	bindHudUpdateLoop()

	playersService.PlayerRemoving:Connect(function(plr)
		destroyEspOverlay(plr)
		aimlockState[plr.UserId] = nil
		local entry = aimlockRayPool[plr]
		if entry and entry.part then
			pcall(function()
				entry.part:Destroy()
			end)
			aimlockRayPool[plr] = nil
		end
	end)

end)


-- ---------------------------------------------------------------------------
-- UI modules
-- ---------------------------------------------------------------------------

run(function()
	local extras = vape.Categories.Extras
	if not extras then
		extras = vape:CreateCategory({
			Name = 'Extras',
			Icon = 'vape/assets/new/inventoryicon.png'
		})
		vape.Categories.Inventory = extras
	end

	local AutoParry
	local AutoAttack
	local Reach
	local MeleeRange
	local ExtendReach
	local AttackCooldown
	local Debug
	local TestParry

	AutoParry = extras:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			autoParryActive = callback
			if callback then
				logParryAnimIds()
				bindLocalRespawnHandler()
				startEnemyWatchers()
				bindParryScanLoop()
				bindPacketListeners()
				notif('Auto Parry', '360 within threat range - melee + gun draw/shot (proximity gated).', 5)
			end
		end,
		Tooltip = 'Parries nearby enemy melee swings and gun draw/shot animations (360 within Melee/Threat range).',
	})

	local AlwaysParry
	AlwaysParry = extras:CreateModule({
		Name = 'Always Parry',
		Function = function(callback)
			alwaysParryActive = callback
			bindAlwaysParryInput()
			resolveRedlinerRuntime(true)
			rebuildMeleePacketFireChain()
			if callback then
				notif('Always Parry', 'Clash boost active — max velocityMag on melee packets.', 5)
			end
		end,
		Tooltip = 'Spoofs max clash velocity (velocityMag) on every melee swing. Faster side wins clashes and applies more impact to the loser. Not Auto Parry.',
	})
	AlwaysParry:CreateSlider({
		Name = 'Clash Velocity',
		Min = ALWAYS_PARRY_MIN_VELOCITY,
		Max = ALWAYS_PARRY_MAX_VELOCITY,
		Default = ALWAYS_PARRY_DEFAULT_VELOCITY,
		Function = function(val)
			alwaysParryVelocitySetting = val
		end,
		Suffix = function(val)
			return math.floor(val * 10) / 10 .. ' u/s'
		end,
		Tooltip = 'Outgoing velocityMag on melee packets. Tutorial dummy is 50 u/s; default 200 wins clashes and applies max destabilization pressure.',
	})

	AutoAttack = extras:CreateModule({
		Name = 'Auto Attack',
		Function = function(callback)
			autoAttackActive = callback
			if callback then
				resolveRedlinerRuntime(true)
				installAttackReachHook()
				rebuildMeleePacketFireChain()
				bindAutoAttackLoop()
				notif('Auto Attack', '360 melee — aims at nearby enemies in range.', 4)
			else
				rebuildMeleePacketFireChain()
			end
		end,
		Tooltip = 'Swings when any valid enemy is within Attack Range (360). Aims the melee hitbox at the target and sends their hurtboxes even if they are behind you.',
	})

	AutoAttack:CreateToggle({
		Name = 'Anti Parry / Clash',
		Default = true,
		Function = function(callback)
			hud.antiParryEnabled = callback
		end,
		Tooltip = 'Skips attacking when a nearby enemy is parrying or mid melee swing (clash risk). Also backs off briefly after you clash/parry.',
	})

	Reach = extras:CreateModule({
		Name = 'Reach',
		Function = function(callback)
			reachActive = callback
			if callback then
				bindPacketListeners()
				logReachHookStatus('enabled')
				reachDebugLog('Reach ENABLED — extend=', reachExtend, 'totalReach=', getMeleeReach())
				notif('Reach', 'Extends Attack.Hitbox.cast + outgoing melee packet hurtboxes.', 5)
			else
				reachExtend = 0
				reachDebugLog('Reach DISABLED')
				logReachHookStatus('disabled')
				installMeleePacketReachHook()
			end
		end,
		Tooltip = 'Hooks Attack.Hitbox.cast and melee packet Fire (base ' .. BASE_SWORD_REACH .. ' studs + Extend slider).',
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
		Tooltip = 'Legacy setting - melee parry uses visible players at any distance (360).',
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
		Tooltip = 'Legacy setting - gun parry uses visible players and ray validation at any distance.',
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
		Tooltip = 'Legacy setting - animation watchers attach to all visible players.',
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
	local ParryModeDropdown
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

	ParryModeDropdown = AutoParry:CreateDropdown({
		Name = 'Parry Mode',
		List = PARRY_MODE_LIST,
		Default = AUTO_PARRY_DEFAULTS.parryMode,
		Function = function(val)
			parryModeSetting = table.find(PARRY_MODE_LIST, val) and val or AUTO_PARRY_DEFAULTS.parryMode
			if autoParryActive then
				bindPacketListeners()
			end
		end,
		Tooltip = 'Hybrid = animation + packets. Animation = old behavior. Packet = packet cues + gun packet only.',
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
		Tooltip = '3D aim dot (HRP/Head/muzzles) plus gun-ray proximity to your hurtboxes. Default 0.65; ray hits bypass dot. Stricter at long range.',
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
		Tooltip = 'Seconds after draw starts to press parry (~90% of ItemDef draw_time).',
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
		parryModeSetting = d.parryMode

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
		ParryModeDropdown:SetValue(d.parryMode)
		setToggleDefault(ThreatDebug, d.threatDebug)
	end

	ExtendReach = Reach:CreateSlider({
		Name = 'Extend',
		Min = 0,
		Max = 20,
		Default = 6,
		Function = function(val)
			reachExtend = val
			reachDebugLog('Extend slider=', val, 'totalReach=', getMeleeReach())
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
		Tooltip = 'Extra Z-depth on swing hitboxes + merges distant Hurtboxes into melee packets (base ' .. BASE_SWORD_REACH .. ' studs).',
	})

	Reach:CreateToggle({
		Name = 'Reach Debug',
		Default = false,
		Function = function(callback)
			reachDebugEnabled = callback
			if callback then
				print('[REDLINER][Reach] debug ON - swing sword near an enemy and watch console')
				bindPacketListeners()
				logReachHookStatus('debug toggled on')
			else
				print('[REDLINER][Reach] debug OFF')
				table.clear(lastReachDebugSkipAt)
			end
		end,
		Tooltip = 'Prints [REDLINER][Reach] hook install, hitbox cast, and heartbeat logs to console.',
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
				print('[REDLINER] debug on | alive=', isLocalAlive(), 'autoParry=', autoParryActive, 'threatRange=', threatRangeSetting, 'castigateDelay=', gunParryDelays.Castigate, 'pingOffset=', string.format('%.0fms', getPingParryOffset() * 1000))
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

	local DrawTimer
	DrawTimer = extras:CreateModule({
		Name = 'Draw Timer',
		Function = function(callback)
			hud.drawTimerEnabled = callback
			if callback then
				notif('Draw Timer', 'World ESP draw countdown above enemies (gun draw animations).', 5)
				if hud.hudTickCallback then
					pcall(hud.hudTickCallback)
				end
			end
		end,
		Tooltip = 'Shows gun draw shot countdown above visible enemies (ESP-style billboards).',
	})
	DrawTimer:CreateToggle({
		Name = 'World ESP',
		Default = true,
		Function = function(callback)
			hud.drawTimerWorldEspSetting = callback
		end,
		Tooltip = 'Floating draw timer chip above each visible enemy (screen ESP).',
	})
	DrawTimer:CreateToggle({
		Name = 'Screen HUD',
		Default = false,
		Function = function(callback)
			hud.drawTimerScreenHudSetting = callback
		end,
		Tooltip = 'Legacy screen-positioned draw timer list.',
	})
	DrawTimer:CreateToggle({
		Name = 'True Break Timer',
		Default = true,
		Function = function(callback)
			hud.breakTimerEnabled = callback
			if callback then
				bindPacketListeners()
			end
		end,
		Tooltip = 'Shows exact break-lock countdown from server break packet duration.',
	})
	DrawTimer:CreateDropdown({
		Name = 'Position Preset',
		List = { 'Center-Top', 'Center', 'Bottom' },
		Default = 'Center-Top',
		Function = function(val)
			hud.drawTimerPositionPresetSetting = val
		end,
	})
	DrawTimer:CreateSlider({
		Name = 'Max Entries',
		Min = 1,
		Max = 8,
		Default = 4,
		Function = function(val)
			hud.drawTimerMaxEntriesSetting = val
		end,
	})
	DrawTimer:CreateSlider({
		Name = 'Font Size',
		Min = 14,
		Max = 36,
		Default = 22,
		Function = function(val)
			hud.drawTimerFontSizeSetting = val
		end,
		Suffix = 'px',
	})
	DrawTimer:CreateSlider({
		Name = 'Scale',
		Min = 50,
		Max = 200,
		Default = 100,
		Function = function(val)
			hud.drawTimerScaleSetting = val / 100
		end,
		Suffix = '%',
	})
	DrawTimer:CreateSlider({
		Name = 'Opacity',
		Min = 20,
		Max = 100,
		Default = 88,
		Function = function(val)
			hud.drawTimerOpacitySetting = val / 100
		end,
		Suffix = '%',
	})
	DrawTimer:CreateSlider({
		Name = 'Timer Offset',
		Min = -0.5,
		Max = 0.5,
		Decimal = 100,
		Default = 0,
		Function = function(val)
			hud.drawTimerOffsetSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Offset added to displayed draw countdown.',
	})
	DrawTimer:CreateSlider({
		Name = 'ESP Scale',
		Min = 60,
		Max = 200,
		Default = 100,
		Function = function(val)
			hud.drawTimerEspScaleSetting = val / 100
		end,
		Suffix = '%',
	})

	local BulletWarnings
	BulletWarnings = extras:CreateModule({
		Name = 'Bullet Warnings',
		Function = function(callback)
			hud.bulletWarningsEnabled = callback
			if callback then
				notif('Bullet Warnings', 'Warns when visible enemies have heat for a shot.', 4)
			end
		end,
		Tooltip = 'Shows a warning on visible enemies when Player.ReadOnly.heat >= heat_per_bullet.',
	})
	BulletWarnings:CreateTextBox({
		Name = 'Warning Text',
		Placeholder = 'SHOT READY',
		Function = function(val)
			hud.bulletWarningsTextSetting = val ~= '' and val or 'SHOT READY'
		end,
	})

	local ImpactEsp
	ImpactEsp = extras:CreateModule({
		Name = 'Impact ESP',
		Function = function(callback)
			hud.impactEspEnabled = callback
			if callback then
				notif('Impact ESP', 'Impact bar shown on visible enemies.', 4)
			end
		end,
		Tooltip = 'Impact bar on the left side of visible enemies (Player.ReadOnly.impact).',
	})
	ImpactEsp:CreateSlider({
		Name = 'Max Impact',
		Min = 50,
		Max = 100,
		Default = 100,
		Function = function(val)
			hud.impactEspMaxSetting = val
		end,
	})

	local HealthEsp
	HealthEsp = extras:CreateModule({
		Name = 'Health ESP',
		Function = function(callback)
			hud.healthEspEnabled = callback
			if callback then
				notif('Health ESP', 'Health bar on the right side of visible enemies.', 4)
			end
		end,
		Tooltip = 'Health bar from Player.ReadOnly.health / health_max. Pairs with Impact ESP (left bar).',
	})

	local AimlockDetector
	AimlockDetector = extras:CreateModule({
		Name = 'Aimlock Detector',
		Function = function(callback)
			hud.aimlockDetectorEnabled = callback
			if callback then
				notif('Aimlock Detector', 'Tracking head aim rays on visible players.', 5)
			end
		end,
		Tooltip = 'Flags players whose head tracks you too perfectly. Sends Discord alerts.',
	})
	AimlockDetector:CreateToggle({
		Name = 'Visualize Rays',
		Default = true,
		Function = function(callback)
			hud.aimlockVisualizeSetting = callback
		end,
		Tooltip = 'Draws a 2D line from each enemy head along their look direction when they face you.',
	})
	AimlockDetector:CreateSlider({
		Name = 'Min Tracking',
		Min = 96,
		Max = 99,
		Default = 98,
		Function = function(val)
			hud.aimlockThresholdSetting = val / 100
		end,
		Suffix = '%',
	})
	AimlockDetector:CreateSlider({
		Name = 'Confirm Streak',
		Min = 30,
		Max = 90,
		Default = 40,
		Function = function(val)
			hud.aimlockMinSamplesSetting = val
		end,
		Tooltip = 'Consecutive perfect-tracking frames required before flagging.',
	})


	local HitboxVisualizer
	HitboxVisualizer = extras:CreateModule({
		Name = 'Hitbox Visualizer',
		Function = function(callback)
			if callback then
				bindPacketListeners()
			end
		end,
		Tooltip = 'Visualize swing hitboxes and visible enemy hurtboxes (no distance cap).',
	})
	HitboxVisualizer:CreateToggle({
		Name = 'Show Swing Hitboxes',
		Default = false,
		Function = function(callback)
			hud.hitboxVisualizerSwingEnabled = callback
			if callback then
				bindPacketListeners()
			end
		end,
	})
	HitboxVisualizer:CreateToggle({
		Name = 'Show Enemy Hurtboxes',
		Default = false,
		Function = function(callback)
			hud.hitboxVisualizerEnemyEnabled = callback
		end,
		Tooltip = 'Box adornments on all visible enemy hurtboxes at any distance.',
	})
	HitboxVisualizer:CreateToggle({
		Name = 'Show Bullet Rays',
		Default = false,
		Function = function(callback)
			hud.hitboxVisualizerBulletEnabled = callback
			if callback then
				bindPacketListeners()
				installGunBulletVizHook()
			end
		end,
		Tooltip = 'Draw aim rays on local gun fire and enemy gun shots.',
	})
	HitboxVisualizer:CreateSlider({
		Name = 'Marker Duration',
		Min = 0.1,
		Max = 2,
		Decimal = 100,
		Default = 0.6,
		Function = function(val)
			hud.hitboxVisualizerDurationSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})
	if HitboxVisualizer.CreateColorSlider then
		HitboxVisualizer:CreateColorSlider({
			Name = 'Marker Color',
			Default = Color3.fromRGB(255, 60, 60),
			Function = function(val)
				hud.hitboxVisualizerColorSetting = val
			end,
		})
	end

	local HitBoxes
	HitBoxes = extras:CreateModule({
		Name = 'HitBoxes',
		Function = function(callback)
			redlinerHitboxesActive = callback
			if callback then
				bindRedlinerHitboxExpansion()
				refreshRedlinerHitboxExpansion()
				notif('HitBoxes', 'Expands enemy Hurtbox parts (never yours) for REDLINER melee detection.', 4)
			else
				refreshRedlinerHitboxExpansion()
			end
		end,
		Tooltip = 'Expands enemy Hurtbox parts only — your own hurtboxes are never modified. Updates on a timer, not every frame.',
	})
	HitBoxes:CreateToggle({
		Name = 'Players Only',
		Default = true,
		Function = function(callback)
			redlinerHitboxPlayersOnly = callback
			if HitBoxes.Enabled then
				refreshRedlinerHitboxExpansion()
			end
		end,
	})
	HitBoxes:CreateSlider({
		Name = 'Expand amount',
		Min = 0,
		Max = 15,
		Decimal = 10,
		Default = 3,
		Function = function(val)
			redlinerHitboxExpand = val
			if HitBoxes.Enabled then
				refreshRedlinerHitboxExpansion()
			end
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	HitBoxes:CreateToggle({
		Name = 'Visualize',
		Default = false,
		Function = function(callback)
			redlinerHitboxVisualize = callback
			if HitBoxes.Enabled then
				refreshRedlinerHitboxExpansion()
			end
		end,
	})

	local combatBound = false
	local function bindCombatLoop()
		if combatBound then
			return
		end
		combatBound = true
		bindLocalRespawnHandler()

		runService.Heartbeat:Connect(function()
			if not AutoParry.Enabled and not AlwaysParry.Enabled and not AutoAttack.Enabled and not Reach.Enabled
				and not HitBoxes.Enabled and not hud.drawTimerEnabled
				and not hud.bulletWarningsEnabled and not hud.impactEspEnabled
				and not hud.healthEspEnabled and not hud.aimlockDetectorEnabled
				and not hud.breakTimerEnabled
				and not hud.hitboxVisualizerEnemyEnabled and not hud.hitboxVisualizerSwingEnabled
				and not hud.hitboxVisualizerBulletEnabled and not reachDebugEnabled then
				return
			end
			combatHeartbeat(MeleeRange.Value)
		end)

		playersService.PlayerRemoving:Connect(function(plr)
			unwatchAllForPlayer(plr)
		end)
	end

	task.defer(function()
		repeat
			task.wait()
		until vape._profileReady or not vape.Loaded
		if vape.Loaded and vape.ApplyAllModuleProfiles then
			vape:ApplyAllModuleProfiles()
		end
	end)

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
		notif('REDLINER', 'Extras loaded: reach, hitboxes, ESP, and aimlock ready. Use Combat tab for Silent Aim.', 6)
	end)
end)
