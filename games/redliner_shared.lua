--[[
	REDLINER shared game script (MAIN + FFA + MATCH place IDs).
	Place IDs: 94987506187454 (main), 115875349872417 (FFA), 126691165749976 (match).
	All three places share one Vape profile config (FFA place ID 115875349872417).
	Auto Parry, Auto Attack, Reach, Kill Aura, Draw Timer HUD, Threat Indicator,
	Hitbox Visualizer (swing/cone/bullet/enemy), Animation Logger.
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
end)

local BASE_SWORD_REACH = 10

local PARRY_KEY = Enum.KeyCode.F
local PARRY_VK = 0x46

local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local MELEE_PACKET_REMOTE = '_xe6cbd0bf2a4cf278'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'
local MELEE_ACTION_HINTS = { 'SWING', 'SLASH', 'HIT', 'ATTACK', 'WIDE', 'STAB', 'CUT' }
local DASH_VELOCITY_MIN = 20
local AUTO_ATTACK_RANGE_DEFAULT = 14
local AUTO_ATTACK_MIN_DELAY = 1 / 60

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
	castigateDelay = 0.36,
	phoenixDelay = 0.66,
	siegeDelay = 0.96,
	monarchDelay = 1.71,
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
local PARRY_MODE_LIST = {'Hybrid', 'Animation', 'Packet'}

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
local parryModeSetting = AUTO_PARRY_DEFAULTS.parryMode
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
local PARRY_ATTACK_BLOCK_SEC = 0.08
local lastDebugHeartbeat = 0
local lastDebugSkipAt = {}
local lastDebugAnimAt = {}
local parryIdsLogged = false
local parryScanBound = false
local autoAttackLoopBound = false
local localRespawnBound = false
local lastParryScanAt = 0
local lastWatcherRefreshAt = 0
local PARRY_SCAN_INTERVAL = 0.02
local WATCHER_REFRESH_INTERVAL = 0.25
local GUN_AIM_RANGE_BONUS = 0.12
local GUN_MUZZLE_NAMES = {'Muzzle', 'Barrel', 'FirePoint', 'Gun', 'Handle', 'Tip', 'ShootPoint', 'Ray', 'Flash', 'Emitter', 'Glint'}
local GUN_RAY_HIT_RADIUS = 5
local GUN_RAY_MAX_RANGE = 100000
local PING_PARRY_MULTIPLIER = 0.9
local PING_PARRY_MAX_OFFSET = 0.5
local tryParry
local canSafelyParry
local hitboxReachHooked = false
local meleePacketHooked = false
local gunParryPacketHooked = false
local breakPacketHooked = false
local packetMetatableHooked = false
local attackReachHooked = false
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
	killAuraActive = false,
	killAuraRangeSetting = 18,
	killAuraExtendSetting = 10,
	killAuraDelaySetting = 0.35,
	killAuraItemIdSetting = 'Auto',
	killAuraBound = false,
	lastKillAuraAt = 0,
	killAuraAttackSerial = 0,
	hudTickCallback = nil,
	drawTimerOffsetSetting = 0,
	drawTimerWorldEspSetting = true,
	drawTimerScreenHudSetting = false,
	drawTimerEspScaleSetting = 1,
	bulletWarningsEnabled = false,
	bulletWarningsTextSetting = 'SHOT READY',
	impactEspEnabled = false,
	impactEspMaxSetting = 100,
	breakTimerEnabled = false,
	aimlockDetectorEnabled = false,
	aimlockVisualizeSetting = true,
	aimlockThresholdSetting = 0.93,
	aimlockMinSamplesSetting = 18,
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

local function parryModeUsesAnimation()
	return parryModeSetting ~= 'Packet'
end

local function parryModeUsesPacket()
	return parryModeSetting ~= 'Animation'
end

local function isPacketParryReason(reason)
	if type(reason) ~= 'string' then
		return false
	end
	return string.find(reason, 'gun_packet_', 1, true) ~= nil
		or string.find(reason, 'packet_cue_', 1, true) ~= nil
end

local function isAnimationParryReason(reason)
	if type(reason) ~= 'string' then
		return false
	end
	return string.find(reason, 'melee_', 1, true) ~= nil
		or string.find(reason, 'gun_draw_', 1, true) ~= nil
		or string.find(reason, 'gun_shot_', 1, true) ~= nil
		or string.find(reason, 'glint', 1, true) ~= nil
end

local function spawnBulletVizRay(origin, direction, color)
	if not hud.hitboxVisualizerBulletEnabled then
		return
	end
	if typeof(origin) ~= 'Vector3' or typeof(direction) ~= 'Vector3' then
		return
	end
	local dir = direction.Magnitude > 0.01 and direction.Unit or Vector3.new(0, 0, -1)
	local length = 120
	local part = Instance.new('Part')
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CastShadow = false
	part.Material = Enum.Material.Neon
	part.Color = color or hud.hitboxVisualizerColorSetting
	part.Transparency = 0.35
	part.Size = Vector3.new(0.15, 0.15, length)
	part.CFrame = CFrame.lookAt(origin, origin + dir) * CFrame.new(0, 0, -length / 2)
	part.Parent = workspaceService
	debrisService:AddItem(part, hud.hitboxVisualizerDurationSetting)
end

local function isGameWindowFocused()
	if isrbxactive then
		return isrbxactive()
	end
	if iswindowactive then
		return iswindowactive()
	end
	return true
end

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

local function postDiscord(payload)
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

local function discordEmbed(title, description, color, fields, thumbnailUrl)
	local embed = {
		title = title,
		description = description,
		color = color or 5793266,
		fields = fields,
		footer = {text = 'Priv v9 • REDLINER'},
		timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
	}
	if thumbnailUrl and thumbnailUrl ~= '' then
		embed.thumbnail = {url = thumbnailUrl}
	end
	postDiscord({
		username = 'Priv • REDLINER',
		embeds = {embed},
	})
end

local function readFolderValue(folder, name)
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
					value = 'ReadOnly profile folder not replicated yet — basic identity only.',
					inline = false,
				})
			end

			discordEmbed(
				'📋 Player Report',
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

local function getPlayerReadOnlyFolder(plr)
	return plr and plr:FindFirstChild('ReadOnly')
end

local function getPlayerReadOnlyNumber(plr, name)
	local ro = getPlayerReadOnlyFolder(plr)
	local v = ro and ro:FindFirstChild(name)
	if v and (v:IsA('NumberValue') or v:IsA('IntValue')) then
		return v.Value
	end
	return nil
end

local function getEntityHeadPart(plr)
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

local function isPlayerVisible(plr)
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

local function getLocalRoot()
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

local function isLocalAlive()
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

local function isEnemyCharVisible(char)
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
	return isEnemyCharVisible(char)
end

local function isEnemyInGunThreatRange(char)
	return isEnemyCharVisible(char)
end

local function getEffectiveWatcherRange()
	return math.huge
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
	return true
end

local function confirmEnemyAnimTrigger(char, triggerKey)
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

local function getAimDot3D(origin, lookVector, targetPos)
	local offset = targetPos - origin
	if offset.Magnitude < 0.05 then
		return 1
	end
	if lookVector.Magnitude < 0.05 then
		return 0
	end
	return lookVector.Unit:Dot(offset.Unit)
end

local function rayClosestDistance(origin, dir, point, maxRange)
	dir = dir.Unit
	local rel = point - origin
	local t = math.clamp(rel:Dot(dir), 0, maxRange or GUN_RAY_MAX_RANGE)
	local closest = origin + dir * t
	return (point - closest).Magnitude, t
end

local refreshMyHurtboxes

local function isGunRayThreatening(origin, direction, maxRange, maxRadius)
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

local function isGunMuzzlePart(name)
	local lower = string.lower(name)
	for _, mName in GUN_MUZZLE_NAMES do
		if string.find(lower, string.lower(mName), 1, true) then
			return true
		end
	end
	return false
end

local function collectEnemyGunAimSources(char, aimModel)
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
		for _, desc in model:GetDescendants() do
			if desc:IsA('BasePart') and isGunMuzzlePart(desc.Name) then
				local toMe = targetPos - desc.Position
				if toMe.Magnitude > 0.05 then
					table.insert(rays, {origin = desc.Position, direction = toMe.Unit})
				end
				table.insert(dots, getAimDot3D(desc.Position, desc.CFrame.LookVector, targetPos))
			end
		end
	end
	if aimModel and aimModel:IsA('BasePart') and string.find(string.lower(aimModel.Name), 'glint', 1, true) then
		local toMe = targetPos - aimModel.Position
		if toMe.Magnitude > 0.05 then
			table.insert(rays, {origin = aimModel.Position, direction = toMe.Unit})
		end
	end
	return rays, dots
end

local function getGunAimDotFromModel(model)
	local root = getLocalRoot()
	local enemyRoot = model and model:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return 0
	end
	return getAimDot3D(enemyRoot.Position, enemyRoot.CFrame.LookVector, root.Position)
end

local function getHeadAimDotFromModel(model)
	local root = getLocalRoot()
	local head = model and model:FindFirstChild('Head')
	if not root or not head then
		return 0
	end
	return getAimDot3D(head.Position, head.CFrame.LookVector, root.Position)
end

local function getEffectiveGunAimThreshold(_dist)
	return math.min(gunAimDotSetting, 0.95)
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
	local dist = getClosestEnemyDistance(char)
	local need = getEffectiveGunAimThreshold(dist)
	local rays, dotList = collectEnemyGunAimSources(char, aimModel)
	for _, ray in rays do
		if isGunRayThreatening(ray.origin, ray.direction, GUN_RAY_MAX_RANGE, GUN_RAY_HIT_RADIUS) then
			return true, 1, need
		end
	end
	local maxDot = getGunAimDotFromModel(aimModel or char)
	maxDot = math.max(maxDot, getHeadAimDotFromModel(aimModel or char))
	for _, d in dotList do
		maxDot = math.max(maxDot, d)
	end
	if maxDot < need then
		return false, maxDot, need
	end
	return true, maxDot, need
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
	if not isEnemyCharVisible(char) then
		threatDebugSkip('not_visible', char.Name, 'melee')
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
	if not isEnemyCharVisible(char) then
		threatDebugSkip('not_visible', char.Name, 'gun')
		return false
	end
	local aiming, dot, need = isEnemyAimingAtMeForGun(char, aimModel)
	if aiming then
		return true
	end
	if confirmedAttack then
		local myRoot = getLocalRoot()
		if myRoot then
			local permissiveRange = GUN_RAY_MAX_RANGE
			local permissiveRadius = 8
			local rays = collectEnemyGunAimSources(char, aimModel)
			for _, ray in rays do
				if isGunRayThreatening(ray.origin, ray.direction, permissiveRange, permissiveRadius) then
					return true
				end
			end
			local hrp = char:FindFirstChild('HumanoidRootPart')
			if hrp then
				local toMe = myRoot.Position - hrp.Position
				if toMe.Magnitude > 0.05 and isGunRayThreatening(hrp.Position, toMe, permissiveRange, permissiveRadius) then
					return true
				end
			end
			if aimModel and aimModel:IsA('BasePart') and string.find(string.lower(aimModel.Name), 'glint', 1, true) then
				local toMe = myRoot.Position - aimModel.Position
				if toMe.Magnitude > 0.05 and isGunRayThreatening(aimModel.Position, toMe, permissiveRange, permissiveRadius) then
					return true
				end
			end
		end
	end
	threatDebugSkip('not_aiming', char.Name, 'gun', string.format('dot=%.3f need=%.2f', dot, need))
	return false
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

local function getPingParryOffset()
	local ping = 0
	pcall(function()
		if lplr.GetNetworkPing then
			ping = lplr:GetNetworkPing()
		end
	end)
	if typeof(ping) ~= 'number' or ping ~= ping or ping < 0 then
		return 0
	end
	return math.clamp(ping * PING_PARRY_MULTIPLIER, 0, PING_PARRY_MAX_OFFSET)
end

local function getEffectiveGunParryDelay(gunName)
	return math.max(0, getGunParryDelay(gunName) - getPingParryOffset())
end

local function getAdjustedParryDelay(baseDelay, timePosition)
	return math.max(0, (baseDelay or 0) - (timePosition or 0) - getPingParryOffset())
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

local function pressParryKey()
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
local ENEMY_PARRY_ANIM_IDS = {}

local function buildEnemyParryAnimCatalog()
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

local function isEnemyParryAnim(animId, animName)
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

local function isEnemyParrying(charOrPlr)
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
				if track.IsPlaying and track.WeightCurrent >= 0.25 then
					local name, animId = getTrackAnimInfo(track)
					if isEnemyParryAnim(animId, name) and track.TimePosition <= 0.85 then
						return true
					end
				end
			end
		end
	end
	return false
end

local function anyEnemyInRangeParrying(attackRange)
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			if getClosestEnemyDistance(plr) <= attackRange and isEnemyParrying(plr) then
				return true
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

installGunParryPacketHook = function()
	if gunParryPacketHooked then
		return true
	end
	if not initPackets() then
		return false
	end
	local packet = Packets[GUN_PACKET_NAME]
	if not packet or not packet.OnClientEvent or type(packet.OnClientEvent.Connect) ~= 'function' then
		return false
	end
	if packet._gunParryHooked then
		gunParryPacketHooked = true
		return true
	end
	packet._gunParryHooked = true
	gunParryPacketHooked = true
	packet.OnClientEvent:Connect(function(arg1, _arg2, _arg3, _arg4, _arg5, aimDir, gunName, arg8, arg9)
		if not autoParryActive or not parryGunShotEnabled or not parryModeUsesPacket() or not isLocalAlive() then
			return
		end
		if typeof(aimDir) ~= 'Vector3' or aimDir.Magnitude < 0.05 then
			return
		end
		local char
		if typeof(arg1) == 'string' and arg1 ~= '' then
			local plr = playersService:FindFirstChild(arg1)
			if plr and plr ~= lplr then
				char = plr.Character
			end
		end
		if not char then
			local uid
			if typeof(arg8) == 'number' and arg8 > 0 then
				uid = arg8
			elseif typeof(arg9) == 'number' and arg9 > 0 then
				uid = arg9
			elseif typeof(arg1) == 'number' and arg1 > 0 then
				uid = arg1
			end
			if uid then
				local plr = playersService:GetPlayerByUserId(uid)
				if plr and plr ~= lplr then
					char = plr.Character
				end
			end
		end
		if not char or not char.Parent then
			return
		end
		if not isEnemyInGunThreatRange(char) then
			return
		end
		local originPos
		local hrp = char:FindFirstChild('HumanoidRootPart')
		if hrp then
			originPos = hrp.Position
		end
		for _, desc in char:GetDescendants() do
			if desc:IsA('BasePart') and isGunMuzzlePart(desc.Name) then
				originPos = desc.Position
				break
			end
		end
		if not originPos then
			return
		end
		if not isGunRayThreatening(originPos, aimDir, GUN_RAY_MAX_RANGE, GUN_RAY_HIT_RADIUS) then
			return
		end
		local label = typeof(gunName) == 'string' and gunName ~= '' and gunName or detectEquippedGun(char)
		debugLog('trigger', 'gun_packet', label, 'dist=' .. string.format('%.1f', getClosestEnemyDistance(char)))
		tryParry('gun_packet_' .. label, char)
	end)
	return true
end

local function updateBreakState(duration)
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
-- Packet hooks (melee reach)
-- ---------------------------------------------------------------------------

local MELEE_ITEM_PATTERNS = {
	{pattern = 'redliner', id = 'Redliner'},
	{pattern = 'nothing', id = 'Nothing'},
}

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

getEnemyHurtboxesInRange = function(range, origin)
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
				local plr = getPlayerFromModel(owner)
				if plr and isPlayerVisible(plr) then
					local dist = (part.Position - origin).Magnitude
					if not range or dist <= range then
						table.insert(sorted, {Part = part, Distance = dist})
					end
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

local function getVisibleEnemyHurtboxes()
	return getEnemyHurtboxesInRange(nil, getLocalRoot() and getLocalRoot().Position)
end

detectLocalMeleeItemId = function()
	local char = getLocalCharacter()
	if char then
		for _, desc in char:GetDescendants() do
			local lower = string.lower(desc.Name)
			for _, entry in MELEE_ITEM_PATTERNS do
				if string.find(lower, entry.pattern, 1, true) then
					return entry.id
				end
			end
		end
	end
	if type(meleeTemplate) == 'table' and typeof(meleeTemplate[1]) == 'string' and meleeTemplate[1] ~= '' then
		return meleeTemplate[1]
	end
	if hud.killAuraItemIdSetting ~= 'Auto' then
		return hud.killAuraItemIdSetting
	end
	return 'Redliner'
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
	local usingReach = reachActive and reachExtend > 0
	local usingKillAura = hud.killAuraActive
	if not usingReach and not usingKillAura then
		reachDebugSkip('reach_off', 'augment skipped (reach/kill aura inactive)', 'action=', action)
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
	local meleeReach = usingReach and getMeleeReach() or (hud.killAuraRangeSetting + hud.killAuraExtendSetting)
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
		'usingReach=', usingReach,
		'usingKillAura=', usingKillAura,
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

installGunBulletVizHook = function()
	if hud.gunBulletVizHooked or not hud.hitboxVisualizerBulletEnabled then
		return true
	end
	if not initPackets() then
		return false
	end
	local packet = Packets[GUN_PACKET_NAME]
	if not packet or type(packet.Fire) ~= 'function' then
		return false
	end
	if packet._bulletVizHooked then
		hud.gunBulletVizHooked = true
		return true
	end
	local oldFire = packet.Fire
	packet._bulletVizHooked = true
	hud.gunBulletVizHooked = true
	packet.Fire = function(firePacket, ...)
		local packed = table.pack(...)
		local aimDir = packed[6]
		if typeof(aimDir) == 'Vector3' then
			task.defer(function()
				local root = getLocalRoot()
				if root then
					spawnBulletVizRay(root.Position, aimDir, hud.hitboxVisualizerColorSetting)
				end
			end)
		end
		return oldFire(firePacket, ...)
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

bindPacketListeners = function()
	if not initPackets() then
		return
	end
	installMeleeReachHook()
	if not breakPacketHooked then
		local breakPacket = Packets and Packets._xdb2548bded1dd8e3
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

	local interval = attackDelay > 0 and attackDelay or AUTO_ATTACK_MIN_DELAY
	if tick() - lastAttackAt < interval then
		return
	end

	if not getNearestEnemyInAttackRange(autoAttackRangeSetting) then
		return
	end

	if hud.antiParryEnabled and anyEnemyInRangeParrying(autoAttackRangeSetting) then
		return
	end

	pressAttackClick()
end

bindAutoAttackLoop = function()
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

combatHeartbeat = function(meleeRange)
	meleeRangeSetting = meleeRange
	if reachActive or reachDebugEnabled or autoParryActive or hud.killAuraActive
		or hud.hitboxVisualizerSwingEnabled or hud.hitboxVisualizerBulletEnabled then
		bindPacketListeners()
	end
	if hud.hitboxVisualizerSwingEnabled and not hitboxReachHooked then
		installHitboxReachHook()
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
-- HUD overlays + Kill Aura
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
			threatPanel.BackgroundColor3 = Color3.fromRGB(12, 8, 8)
			threatPanel.BackgroundTransparency = 0.35
			threatPanel.BorderSizePixel = 0
			threatPanel.AnchorPoint = Vector2.new(0.5, 1)
			threatPanel.Size = UDim2.fromScale(0.92, 0.22)
			threatPanel.Position = UDim2.fromScale(0.5, 0.92)
			threatPanel.ZIndex = 3
			threatPanel.Parent = threatOverlay
			local panelCorner = Instance.new('UICorner')
			panelCorner.CornerRadius = UDim.new(0, 12)
			panelCorner.Parent = threatPanel

			threatTitle = Instance.new('TextLabel')
			threatTitle.Name = 'ThreatTitle'
			threatTitle.BackgroundTransparency = 1
			threatTitle.Size = UDim2.fromScale(1, 0.62)
			threatTitle.Font = Enum.Font.GothamBlack
			threatTitle.TextColor3 = Color3.fromRGB(255, 90, 90)
			threatTitle.TextScaled = true
			threatTitle.Text = ''
			threatTitle.Parent = threatPanel

			threatSub = Instance.new('TextLabel')
			threatSub.Name = 'ThreatSub'
			threatSub.BackgroundTransparency = 1
			threatSub.Position = UDim2.fromScale(0, 0.58)
			threatSub.Size = UDim2.fromScale(1, 0.38)
			threatSub.Font = Enum.Font.GothamMedium
			threatSub.TextColor3 = Color3.fromRGB(230, 230, 230)
			threatSub.TextScaled = true
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
	end

	local function ensureEspOverlay(plr)
		if playerEspOverlays[plr] then
			return playerEspOverlays[plr]
		end
		if not Drawing then
			return nil
		end
		local overlay = {
			PanelBg = newDraw('Square', {Filled = true, Thickness = 1, ZIndex = 0, Transparency = 0.42, Color = Color3.fromRGB(10, 10, 14)}),
			DrawText = newDraw('Text', {Center = true, Size = 13, ZIndex = 3, Color = Color3.fromRGB(185, 185, 195)}),
			DrawShadow = newDraw('Text', {Center = true, Size = 13, ZIndex = 2, Color = Color3.new()}),
			TimerText = newDraw('Text', {Center = true, Size = 17, ZIndex = 4, Color = Color3.fromRGB(255, 220, 120)}),
			TimerShadow = newDraw('Text', {Center = true, Size = 17, ZIndex = 3, Color = Color3.new()}),
			KindText = newDraw('Text', {Center = true, Size = 11, ZIndex = 3, Color = Color3.fromRGB(150, 150, 160)}),
			KindShadow = newDraw('Text', {Center = true, Size = 11, ZIndex = 2, Color = Color3.new()}),
			BarBg = newDraw('Line', {Thickness = 4, ZIndex = 1, Transparency = 0.5, Color = Color3.new()}),
			BarFill = newDraw('Line', {Thickness = 2, ZIndex = 2, Color = Color3.fromRGB(255, 140, 50)}),
			WarnText = newDraw('Text', {Center = true, Size = 15, ZIndex = 4, Color = Color3.fromRGB(255, 90, 90)}),
			WarnShadow = newDraw('Text', {Center = true, Size = 15, ZIndex = 3, Color = Color3.new()}),
			ImpactBorder = newDraw('Line', {Thickness = 3, ZIndex = 1, Transparency = 0.35, Color = Color3.new()}),
			ImpactLine = newDraw('Line', {Thickness = 1, ZIndex = 2, Color = Color3.fromRGB(255, 120, 60)}),
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

	local function setAimlockRay(plr, fromWorld, toWorld, visible, color, thickness)
		local line = aimlockRayPool[plr]
		if not line and Drawing then
			line = Drawing.new('Line')
			line.ZIndex = 6
			aimlockRayPool[plr] = line
		end
		if not line then
			return
		end
		local cam = getGameCamera()
		if not visible or not cam or typeof(fromWorld) ~= 'Vector3' or typeof(toWorld) ~= 'Vector3' then
			line.Visible = false
			return
		end
		local fromPos, fromOnScreen = cam:WorldToViewportPoint(fromWorld)
		local toPos, toOnScreen = cam:WorldToViewportPoint(toWorld)
		if fromPos.Z <= 0 and toPos.Z <= 0 then
			line.Visible = false
			return
		end
		line.From = Vector2.new(fromPos.X, fromPos.Y)
		line.To = Vector2.new(toPos.X, toPos.Y)
		line.Color = color or Color3.fromRGB(255, 60, 60)
		line.Thickness = thickness or 2
		line.Transparency = 0.15
		line.Visible = fromOnScreen or toOnScreen
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
		local threshold = math.clamp(hud.aimlockThresholdSetting, 0.75, 0.995)
		local needSamples = math.max(8, hud.aimlockMinSamplesSetting)
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
			drawn[plr] = true
			local look = head.CFrame.LookVector
			local toMe = myPos - head.Position
			if toMe.Magnitude < 2 then
				setAimlockRay(plr, Vector3.zero, Vector3.zero, false)
				continue
			end
			local dot = look:Dot(toMe.Unit)
			local state = aimlockState[plr.UserId] or {samples = 0, flagged = false}
			aimlockState[plr.UserId] = state

			if dot >= threshold then
				state.samples = math.min(state.samples + 1, 120)
			else
				state.samples = math.max(0, state.samples - 3)
			end

			local suspicious = dot >= threshold - 0.02
			local showRay = hud.aimlockVisualizeSetting and dot >= 0.35
			local rayColor = suspicious and Color3.fromRGB(255, 55, 55) or Color3.fromRGB(255, 195, 75)
			local rayThickness = suspicious and 2.5 or 1.5
			local rayEnd = head.Position + look.Unit * math.min(toMe.Magnitude, 120)
			setAimlockRay(plr, head.Position, rayEnd, showRay, rayColor, rayThickness)

			if not state.flagged and state.samples >= needSamples then
				state.flagged = true
				local pct = math.floor(dot * 100)
				notif('Aimlock Detector', plr.Name .. ' flagged — head tracking ' .. pct .. '%', 45, 'warning')
				discordEmbed(
					'🎯 Aimlock Detected',
					'**' .. plr.Name .. '** is tracking your head too consistently.',
					16724787,
					{
						{name = 'Player', value = plr.Name, inline = true},
						{name = 'User ID', value = tostring(plr.UserId), inline = true},
						{name = 'Tracking', value = pct .. '%', inline = true},
						{name = 'Samples', value = tostring(state.samples), inline = true},
						{name = 'Threshold', value = math.floor(threshold * 100) .. '%', inline = true},
						{name = 'Place', value = tostring(game.PlaceId), inline = true},
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

	local function layoutDrawTimerWidget(overlay, centerX, topY, textScale, labelText, remaining, delay, kind, accentColor)
		local kindSize = math.floor(11 * textScale)
		local nameSize = math.floor(13 * textScale)
		local timerSize = math.floor(18 * textScale)
		local kindY = topY
		local nameY = kindY + math.floor(13 * textScale)
		local timerY = nameY + math.floor(15 * textScale)
		local barY = timerY + math.floor(14 * textScale)
		local barWidth = math.floor(math.clamp(72 * textScale, 56, 110))
		local barLeft = centerX - barWidth / 2
		local barRight = centerX + barWidth / 2

		overlay.KindText.Size = kindSize
		overlay.KindShadow.Size = kindSize
		overlay.KindText.Text = string.upper(kind or 'DRAW')
		overlay.KindShadow.Text = overlay.KindText.Text
		overlay.KindText.Color = accentColor
		overlay.KindText.Position = Vector2.new(centerX, kindY)
		overlay.KindShadow.Position = overlay.KindText.Position + Vector2.new(1, 1)
		overlay.KindText.Visible = true
		overlay.KindShadow.Visible = true

		overlay.DrawText.Size = nameSize
		overlay.DrawShadow.Size = nameSize
		overlay.DrawText.Text = labelText
		overlay.DrawShadow.Text = labelText
		overlay.DrawText.Color = Color3.fromRGB(190, 190, 200)
		overlay.DrawText.Position = Vector2.new(centerX, nameY)
		overlay.DrawShadow.Position = overlay.DrawText.Position + Vector2.new(1, 1)
		overlay.DrawText.Visible = true
		overlay.DrawShadow.Visible = true

		local timerText = string.format('%.2fs', remaining)
		overlay.TimerText.Size = timerSize
		overlay.TimerShadow.Size = timerSize
		overlay.TimerText.Text = timerText
		overlay.TimerShadow.Text = timerText
		overlay.TimerText.Color = remaining < 0.25 and Color3.fromRGB(255, 70, 70) or accentColor
		overlay.TimerText.Position = Vector2.new(centerX, timerY)
		overlay.TimerShadow.Position = overlay.TimerText.Position + Vector2.new(1, 1)
		overlay.TimerText.Visible = true
		overlay.TimerShadow.Visible = true

		local panelPadX, panelPadY = 8, 5
		local panelTop = kindY - panelPadY
		local panelBottom = barY + panelPadY
		local panelWidth = math.max(
			overlay.KindText.TextBounds.X,
			overlay.DrawText.TextBounds.X,
			overlay.TimerText.TextBounds.X,
			barWidth
		) + panelPadX * 2

		if overlay.PanelBg then
			overlay.PanelBg.Position = Vector2.new(centerX - panelWidth / 2, panelTop)
			overlay.PanelBg.Size = Vector2.new(panelWidth, panelBottom - panelTop)
			overlay.PanelBg.Visible = true
		end

		if delay > 0 then
			local ratio = math.clamp(remaining / delay, 0, 1)
			local fillRight = barLeft + barWidth * ratio
			overlay.BarBg.From = Vector2.new(barLeft, barY)
			overlay.BarBg.To = Vector2.new(barRight, barY)
			overlay.BarBg.Visible = true
			overlay.BarFill.From = Vector2.new(barLeft, barY)
			overlay.BarFill.To = Vector2.new(fillRight, barY)
			overlay.BarFill.Color = remaining < 0.25 and Color3.fromRGB(255, 50, 50) or accentColor
			overlay.BarFill.Visible = true
		end
	end

	local function updatePlayerWorldEsp()
		local anyEsp = (hud.drawTimerEnabled and hud.drawTimerWorldEspSetting)
			or hud.bulletWarningsEnabled
			or hud.impactEspEnabled
		if not anyEsp then
			for plr in playerEspOverlays do
				destroyEspOverlay(plr)
			end
			return
		end

		local active = {}
		local textScale = math.clamp(hud.drawTimerEspScaleSetting, 0.6, 2)
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
			local accentColor = Color3.fromRGB(255, 220, 120)

			hideDraw(overlay.PanelBg)
			hideDraw(overlay.DrawText)
			hideDraw(overlay.DrawShadow)
			hideDraw(overlay.TimerText)
			hideDraw(overlay.TimerShadow)
			hideDraw(overlay.KindText)
			hideDraw(overlay.KindShadow)
			hideDraw(overlay.BarBg)
			hideDraw(overlay.BarFill)
			hideDraw(overlay.WarnText)
			hideDraw(overlay.WarnShadow)
			hideDraw(overlay.ImpactBorder)
			hideDraw(overlay.ImpactLine)

			local showDraw = hud.drawTimerEnabled and hud.drawTimerWorldEspSetting
			local gunName, remaining, delay, kind = getActiveGunDrawInfo(plr)
			if showDraw and gunName then
				remaining = math.max(0, remaining + hud.drawTimerOffsetSetting)
				accentColor = GUN_DRAW_COLORS[gunName] or GUN_DRAW_COLORS.Castigate
				local stackHeight = math.floor(52 * textScale)
				local topY = iy - stackHeight
				layoutDrawTimerWidget(
					overlay, centerX, topY, textScale,
					string.format('%s · %s', plr.Name, gunName),
					remaining, delay, kind, accentColor
				)
			end

			local heat = getPlayerReadOnlyNumber(plr, 'heat')
			local perBullet = getPlayerReadOnlyNumber(plr, 'heat_per_bullet')
			local shotReady = hud.bulletWarningsEnabled and heat and perBullet and heat >= perBullet
			if shotReady then
				local warnText = hud.bulletWarningsTextSetting
				overlay.WarnText.Size = math.floor(14 * textScale)
				overlay.WarnShadow.Size = overlay.WarnText.Size
				overlay.WarnText.Text = warnText
				overlay.WarnShadow.Text = warnText
				overlay.WarnText.Position = Vector2.new(centerX, iy + isy + math.floor(8 * textScale))
				overlay.WarnShadow.Position = overlay.WarnText.Position + Vector2.new(1, 1)
				overlay.WarnText.Visible = true
				overlay.WarnShadow.Visible = true
			end

			if hud.impactEspEnabled then
				local impact = getPlayerReadOnlyNumber(plr, 'impact') or 0
				local maxImpact = math.max(1, hud.impactEspMaxSetting)
				local ratio = math.clamp(impact / maxImpact, 0, 1)
				local healthposy = isy * ratio
				overlay.ImpactBorder.From = Vector2.new(ix - 6, iy + 1)
				overlay.ImpactBorder.To = Vector2.new(ix - 6, iy + isy - 1)
				overlay.ImpactBorder.Visible = true
				overlay.ImpactLine.From = Vector2.new(ix - 6, iy + isy - healthposy)
				overlay.ImpactLine.To = Vector2.new(ix - 6, iy)
				overlay.ImpactLine.Color = Color3.fromHSV((1 - ratio) * 0.33, 0.89, 0.75)
				overlay.ImpactLine.Visible = impact > 0
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
					title.Text = string.format('%s  •  %s', entry.name, entry.gun)
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

	local function collectThreatEntries()
		local threats = {}
		for _, plr in playersService:GetPlayers() do
			if plr ~= lplr and plr.Character and isPlayerVisible(plr) then
				local char = plr.Character
				local dist = getClosestEnemyDistance(plr)
				for _, model in getEnemyModels(plr) do
					if not model or not model.Parent then
						continue
					end
					for _, track in getAllPlayingTracks(model) do
						if not track.IsPlaying then
							continue
						end
						local _, animId = getTrackAnimInfo(track)
						local kind = getParryAnimKind(animId)
						if kind == 'melee' and hud.threatShowMeleeSetting then
							table.insert(threats, {
								type = 'MELEE',
								name = plr.Name,
								dist = dist,
								color = hud.threatColorMeleeSetting,
								remaining = 0,
								score = 7000 - dist * 20,
							})
						elseif kind == 'gun_draw' and hud.threatShowGunDrawSetting then
							local aiming = true
							if hud.threatRequireAimingSetting then
								aiming = isEnemyAimingAtMeForGun(char, model)
							end
							if aiming then
								local gunName = GUN_DRAW_ANIM_IDS[normalizeAnimId(animId)] or detectEquippedGun(char)
								local delay = getEffectiveGunParryDelay(gunName)
								local remaining = getAdjustedParryDelay(getGunParryDelay(gunName), track.TimePosition)
								table.insert(threats, {
									type = 'GUN DRAW',
									name = plr.Name,
									dist = dist,
									color = hud.threatColorGunDrawSetting,
									remaining = remaining,
									score = 8000 - dist * 5 - remaining * 200,
								})
							end
						elseif kind == 'gun_shot' and hud.threatShowGunShotSetting then
							local aiming = true
							if hud.threatRequireAimingSetting then
								aiming = isEnemyAimingAtMeForGun(char, model)
							end
							if aiming then
								table.insert(threats, {
									type = 'GUN SHOT',
									name = plr.Name,
									dist = dist,
									color = hud.threatColorGunShotSetting,
									remaining = 0,
									score = 10000 - dist * 10,
								})
							end
						end
					end
					if hud.threatShowGlintSetting then
						for _, desc in model:GetDescendants() do
							if isGlintInstance(desc) then
								local aiming = true
								if hud.threatRequireAimingSetting then
									aiming = isEnemyAimingAtMeForGun(char, model)
								end
								if aiming then
									table.insert(threats, {
										type = 'GLINT',
										name = plr.Name,
										dist = dist,
										color = hud.threatColorGlintSetting,
										remaining = 0,
										score = 9000 - dist * 10,
									})
								end
								break
							end
						end
					end
				end
			end
		end
		table.sort(threats, function(a, b)
			return a.score > b.score
		end)
		return threats
	end

	local function animateThreatChange(threat, flashRed)
		if not threatPanel then
			return
		end
		local speed = math.clamp(hud.threatIndicatorAnimSpeedSetting, 0.05, 1)
		threatPanel.Size = UDim2.fromScale(0.85, 0.18)
		tweenService:Create(threatPanel, TweenInfo.new(speed, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = hud.threatIndicatorFullscreenSetting and UDim2.fromScale(1, 1) or UDim2.fromScale(0.92, 0.22),
		}):Play()
		if flashRed and threatFlash then
			threatFlash.BackgroundTransparency = 0.55
			tweenService:Create(threatFlash, TweenInfo.new(speed * 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = 1,
			}):Play()
		end
	end

	local function updateThreatHud()
		if not threatOverlay then
			return
		end
		if not hud.threatIndicatorEnabled then
			threatOverlay.Visible = false
			lastPrimaryKey = ''
			return
		end
		ensureHudGui()
		local threats = collectThreatEntries()
		local primary = threats[1]
		threatOverlay.Visible = true
		if not primary then
			lastPrimaryKey = ''
			if hud.threatIndicatorFullscreenSetting then
				threatOverlay.BackgroundTransparency = 1 - hud.threatIndicatorOpacitySetting * 0.35
				threatPanel.AnchorPoint = Vector2.new(0.5, 0.5)
				threatPanel.Position = UDim2.fromScale(0.5, 0.5)
				threatPanel.Size = UDim2.fromScale(0.7, 0.18)
			else
				threatOverlay.BackgroundTransparency = 1
				threatPanel.AnchorPoint = Vector2.new(0.5, 1)
				threatPanel.Position = UDim2.fromScale(0.5, math.clamp(hud.threatIndicatorPosYSetting, 0.55, 0.98))
				threatPanel.Size = UDim2.fromScale(0.92, 0.16)
			end
			threatPanel.BackgroundTransparency = 1 - hud.threatIndicatorOpacitySetting
			if threatTitle then
				threatTitle.TextSize = math.floor(hud.threatIndicatorFontSizeSetting * 0.65)
				threatTitle.Text = 'ALL CLEAR'
				threatTitle.TextColor3 = Color3.fromRGB(120, 220, 140)
			end
			if threatSub then
				threatSub.TextSize = math.floor(hud.threatIndicatorFontSizeSetting * 0.28)
				threatSub.Text = 'Threat indicator active — watching for melee / gun / glint'
			end
			return
		end
		if hud.threatIndicatorFullscreenSetting then
			threatOverlay.BackgroundTransparency = 1 - hud.threatIndicatorOpacitySetting * 0.65
			threatPanel.AnchorPoint = Vector2.new(0.5, 0.5)
			threatPanel.Position = UDim2.fromScale(0.5, 0.5)
			threatPanel.Size = UDim2.fromScale(0.96, 0.38)
		else
			threatOverlay.BackgroundTransparency = 1
			threatPanel.AnchorPoint = Vector2.new(0.5, 1)
			threatPanel.Position = UDim2.fromScale(0.5, math.clamp(hud.threatIndicatorPosYSetting, 0.55, 0.98))
			threatPanel.Size = UDim2.fromScale(0.92, 0.22)
		end
		threatPanel.BackgroundTransparency = 1 - hud.threatIndicatorOpacitySetting
		local key = primary.type .. ':' .. primary.name
		local flash = primary.type == 'GUN SHOT' or primary.type == 'GLINT'
		if key ~= lastPrimaryKey then
			lastPrimaryKey = key
			animateThreatChange(primary, flash)
		end
		if threatTitle then
			threatTitle.TextSize = hud.threatIndicatorFontSizeSetting
			threatTitle.Text = primary.type
			threatTitle.TextColor3 = primary.color
		end
		if threatSub then
			local subSize = math.floor(hud.threatIndicatorFontSizeSetting * 0.45)
			threatSub.TextSize = subSize
			if primary.type == 'GUN DRAW' and primary.remaining > 0 then
				threatSub.Text = string.format('%s  •  %.1f studs  •  %.2fs', primary.name, primary.dist, primary.remaining)
			else
				threatSub.Text = string.format('%s  •  %.1f studs', primary.name, primary.dist)
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

	local function suppressBreakVisuals()
		if not noBreakScreenEnabled and not destabilizeBypassEnabled then
			return
		end
		local playerGui = lplr:FindFirstChild('PlayerGui')
		if playerGui then
			local gameplayUi = playerGui:FindFirstChild('GameplayUI')
			if gameplayUi then
				local destabilized = gameplayUi:FindFirstChild('Destabilized', true)
				if destabilized then
					pcall(function()
						destabilized:Destroy()
					end)
				end
				local impactFrame = gameplayUi:FindFirstChild('ImpactFrame', true)
				if impactFrame and noBreakScreenEnabled then
					pcall(function()
						impactFrame.Visible = false
					end)
				end
				if destabilizeBypassEnabled then
					pcall(function()
						gameplayUi.Enabled = true
					end)
				end
			end
		end
		local lighting = cloneref(game:GetService('Lighting'))
		for _, effect in lighting:GetChildren() do
			if effect:IsA('ColorCorrectionEffect') and effect.Saturation <= -0.9 then
				pcall(function()
					effect:Destroy()
				end)
			end
		end
		if destabilizeBypassEnabled and isLocalAlive() then
			local root = getLocalRoot()
			if root and root.Anchored then
				pcall(function()
					root.Anchored = false
				end)
			end
		end
	end

	local function updateHud()
		suppressBreakVisuals()
		updateDrawHud()
		updateBreakTimerHud()
		updateThreatHud()
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
			if not hud.drawTimerEnabled and not hud.threatIndicatorEnabled
				and not hud.bulletWarningsEnabled and not hud.impactEspEnabled
				and not hud.aimlockDetectorEnabled then
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
		local ray = aimlockRayPool[plr]
		if ray then
			pcall(function()
				ray.Visible = false
				ray:Remove()
			end)
			aimlockRayPool[plr] = nil
		end
	end)

	local function tryKillAura()
		if not hud.killAuraActive or not isLocalAlive() then
			return
		end
		if not isGameWindowFocused() then
			return
		end
		bindPacketListeners()
		local range = hud.killAuraRangeSetting
		if not getNearestEnemyInAttackRange(range) then
			return
		end
		if hud.antiParryEnabled and anyEnemyInRangeParrying(range) then
			return
		end
		pressAttackClick()
	end

	local function bindKillAuraLoop()
		if hud.killAuraBound then
			return
		end
		hud.killAuraBound = true
		runService.Heartbeat:Connect(function()
			if not hud.killAuraActive or not isLocalAlive() then
				return
			end
			local delay = math.max(0.2, hud.killAuraDelaySetting)
			if tick() - hud.lastKillAuraAt < delay then
				return
			end
			hud.lastKillAuraAt = tick()
			tryKillAura()
		end)
	end

	task.defer(bindKillAuraLoop)
end)

-- ---------------------------------------------------------------------------
-- Animation Logger (file dump for ID identification)
-- ---------------------------------------------------------------------------

run(function()
local AnimLog = {
	active = false,
	logLocal = false,
	logEnemies = true,
	filePath = '',
}
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
shared.RedlinerAnimLog = AnimLog
end)

-- ---------------------------------------------------------------------------
-- UI modules
-- ---------------------------------------------------------------------------

run(function()
	local AnimLog = shared.RedlinerAnimLog
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
				notif('Auto Parry', '360° within threat range — melee + gun draw/shot (proximity gated).', 5)
			end
		end,
		Tooltip = 'Parries nearby enemy melee swings and gun draw/shot animations (360° within Melee/Threat range).',
	})

	AutoAttack = extras:CreateModule({
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

	AutoAttack:CreateToggle({
		Name = 'Anti Parry',
		Default = true,
		Function = function(callback)
			hud.antiParryEnabled = callback
		end,
		Tooltip = 'Skips attacking when a nearby enemy is playing a parry animation (scanned from Assets.Animations).',
	})

	Reach = extras:CreateModule({
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
		Tooltip = 'Legacy setting — melee parry uses visible players at any distance (360°).',
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
		Tooltip = 'Legacy setting — gun parry uses visible players and ray validation at any distance.',
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
		Tooltip = 'Legacy setting — animation watchers attach to all visible players.',
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
		Max = 15,
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
		Tooltip = 'Floating timer above each visible enemy while they draw.',
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
		Default = false,
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

	local NoBreakScreen
	NoBreakScreen = extras:CreateModule({
		Name = 'No Break Screen',
		Function = function(callback)
			noBreakScreenEnabled = callback
			if callback then
				notif('No Break Screen', 'Suppressing destabilized UI and break flash effects.', 4)
			end
		end,
		Tooltip = 'Hides destabilized overlays and strong break visual effects.',
	})
	NoBreakScreen:CreateToggle({
		Name = 'Destabilize Bypass (Experimental)',
		Default = false,
		Function = function(callback)
			destabilizeBypassEnabled = callback
		end,
		Tooltip = 'Best effort only: keeps visuals usable and attempts to reduce local lock feel. Server still decides true disable.',
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
		Tooltip = 'Health-style bar from Player.ReadOnly.impact (0–100).',
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
		Min = 80,
		Max = 99,
		Default = 93,
		Function = function(val)
			hud.aimlockThresholdSetting = val / 100
		end,
		Suffix = '%',
	})
	AimlockDetector:CreateSlider({
		Name = 'Confirm Samples',
		Min = 8,
		Max = 40,
		Default = 18,
		Function = function(val)
			hud.aimlockMinSamplesSetting = val
		end,
	})

	local ThreatIndicator
	ThreatIndicator = extras:CreateModule({
		Name = 'Threat Indicator',
		Function = function(callback)
			hud.threatIndicatorEnabled = callback
			if callback then
				notif('Threat Indicator', 'Primary threat banner HUD active.', 4)
				if hud.hudTickCallback then
					pcall(hud.hudTickCallback)
				end
			end
		end,
		Tooltip = 'Large animated banner for the most urgent melee/gun/glint threat.',
	})
	ThreatIndicator:CreateToggle({
		Name = 'Require Aiming',
		Default = false,
		Function = function(callback)
			hud.threatRequireAimingSetting = callback
		end,
		Tooltip = 'Only show gun/glint threats when the enemy is actually aiming at you.',
	})
	ThreatIndicator:CreateToggle({
		Name = 'Fullscreen Mode',
		Default = false,
		Function = function(callback)
			hud.threatIndicatorFullscreenSetting = callback
		end,
		Tooltip = 'Use full-screen semi-transparent overlay instead of bottom panel.',
	})
	ThreatIndicator:CreateToggle({
		Name = 'Show Melee',
		Default = true,
		Function = function(callback)
			hud.threatShowMeleeSetting = callback
		end,
	})
	ThreatIndicator:CreateToggle({
		Name = 'Show Gun Draw',
		Default = true,
		Function = function(callback)
			hud.threatShowGunDrawSetting = callback
		end,
	})
	ThreatIndicator:CreateToggle({
		Name = 'Show Gun Shot',
		Default = true,
		Function = function(callback)
			hud.threatShowGunShotSetting = callback
		end,
	})
	ThreatIndicator:CreateToggle({
		Name = 'Show Glint',
		Default = true,
		Function = function(callback)
			hud.threatShowGlintSetting = callback
		end,
	})
	ThreatIndicator:CreateSlider({
		Name = 'Font Size',
		Min = 24,
		Max = 72,
		Default = 42,
		Function = function(val)
			hud.threatIndicatorFontSizeSetting = val
		end,
		Suffix = 'px',
	})
	ThreatIndicator:CreateSlider({
		Name = 'Overlay Opacity',
		Min = 10,
		Max = 90,
		Default = 55,
		Function = function(val)
			hud.threatIndicatorOpacitySetting = val / 100
		end,
		Suffix = '%',
	})
	ThreatIndicator:CreateSlider({
		Name = 'Position Y',
		Min = 55,
		Max = 98,
		Default = 82,
		Function = function(val)
			hud.threatIndicatorPosYSetting = val / 100
		end,
		Suffix = '%',
		Tooltip = 'Vertical anchor for panel mode (ignored in fullscreen).',
	})
	ThreatIndicator:CreateSlider({
		Name = 'Animation Speed',
		Min = 5,
		Max = 100,
		Default = 25,
		Function = function(val)
			hud.threatIndicatorAnimSpeedSetting = val / 100
		end,
		Suffix = 's',
	})
	if ThreatIndicator.CreateColorSlider then
		ThreatIndicator:CreateColorSlider({
			Name = 'Melee Color',
			Default = Color3.fromRGB(255, 130, 90),
			Function = function(val)
				hud.threatColorMeleeSetting = val
			end,
		})
		ThreatIndicator:CreateColorSlider({
			Name = 'Gun Draw Color',
			Default = Color3.fromRGB(255, 210, 90),
			Function = function(val)
				hud.threatColorGunDrawSetting = val
			end,
		})
		ThreatIndicator:CreateColorSlider({
			Name = 'Gun Shot Color',
			Default = Color3.fromRGB(255, 90, 90),
			Function = function(val)
				hud.threatColorGunShotSetting = val
			end,
		})
		ThreatIndicator:CreateColorSlider({
			Name = 'Glint Color',
			Default = Color3.fromRGB(180, 130, 255),
			Function = function(val)
				hud.threatColorGlintSetting = val
			end,
		})
	end

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

	local KillAura
	KillAura = extras:CreateModule({
		Name = 'Kill Aura',
		Function = function(callback)
			hud.killAuraActive = callback
			if callback then
				bindPacketListeners()
				notif('Kill Aura', 'Real LMB swings with extended reach — swing once manually if hits fail.', 5)
			end
		end,
		Tooltip = 'Auto-attacks through the real melee pipeline with Kill Aura reach augment (server-valid hits).',
	})
	KillAura:CreateSlider({
		Name = 'Range',
		Min = 4,
		Max = 40,
		Default = 18,
		Function = function(val)
			hud.killAuraRangeSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	KillAura:CreateSlider({
		Name = 'Extend',
		Min = 0,
		Max = 20,
		Default = 10,
		Function = function(val)
			hud.killAuraExtendSetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	KillAura:CreateSlider({
		Name = 'Attack Delay',
		Min = 0.2,
		Max = 0.5,
		Decimal = 100,
		Default = 0.35,
		Function = function(val)
			hud.killAuraDelaySetting = val
		end,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'Delay between kill aura swings. Uses real attack clicks + reach augment, not raw packets.',
	})
	KillAura:CreateDropdown({
		Name = 'Item ID',
		List = { 'Auto', 'Redliner', 'Nothing' },
		Default = 'Auto',
		Function = function(val)
			hud.killAuraItemIdSetting = val
		end,
		Tooltip = 'Auto detects equipped melee from character; falls back to captured swing template.',
	})

	local AnimLogger
	AnimLogger = extras:CreateModule({
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
			if not AutoParry.Enabled and not AutoAttack.Enabled and not Reach.Enabled
				and not KillAura.Enabled and not hud.drawTimerEnabled and not hud.threatIndicatorEnabled
				and not hud.bulletWarningsEnabled and not hud.impactEspEnabled
				and not hud.aimlockDetectorEnabled
				and not hud.breakTimerEnabled and not noBreakScreenEnabled and not destabilizeBypassEnabled
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

	local REDLINER_PROFILE_MODULES = {
		'Auto Parry', 'Auto Attack', 'Reach',
		'Draw Timer', 'Bullet Warnings', 'Impact ESP', 'Aimlock Detector',
		'Threat Indicator', 'Hitbox Visualizer', 'Kill Aura', 'Animation Logger', 'No Break Screen',
	}

	local function applyRedlinerProfileModules()
		if not vape.Loaded then
			return
		end
		for _, name in REDLINER_PROFILE_MODULES do
			pcall(function()
				vape:ApplyModuleProfile(name)
			end)
		end
	end

	task.defer(function()
		repeat
			task.wait()
		until vape.Loaded
		applyRedlinerProfileModules()
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
		notif('REDLINER', 'Extras: packet parry mode, break timer, no-break-screen, draw timer, and combat tools ready.', 6)
	end)
end)
