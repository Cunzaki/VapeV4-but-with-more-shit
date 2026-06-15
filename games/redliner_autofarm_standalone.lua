--[[
	REDLINER AutoFarm — standalone (no Vape dependency).
	Fully auto-executable: run the script and it will join REDLINER FFA, press DROP-IN, then farm.

	Flow: correct place (115875349872417) → scan/press DROP-IN → wait → farm loop.
	Set _G.AutoFarmStop = true before running to prevent auto-start.
	Set _G.AutoFarmStop = true while running to stop gracefully.

	Config (_G.RedlinerAutoFarm.config):
	  autoJoin            — join FFA + DROP-IN before farming (default true)
	  targetPlaceId       — REDLINER FFA place id (default 115875349872417)
	  dropInWaitAfterPress — seconds after DROP-IN before farm (default 2)
	  dropInScanInterval  — seconds between DROP-IN UI scans (default 0.15)
	  joinAttemptCooldown — min seconds between teleport retries (default 30)
	  maxFarmDistance     — only farm enemies within this many studs (default 110)
	  waitPollInterval    — seconds to poll when no targets in range (default 1.5)
	  backDistance        — studs behind target when attached
	  attackDelay         — seconds between attack clicks
	  blinkDepth          — Y depth for blink setup TP (default -100)
	  farmPollInterval    — main loop poll while farming a target
]]

-- ---------------------------------------------------------------------------
-- Config
-- ---------------------------------------------------------------------------

local DEFAULT_CONFIG = {
	autoJoin = true,
	targetPlaceId = 115875349872417,
	dropInWaitAfterPress = 2,
	dropInScanInterval = 0.15,
	joinAttemptCooldown = 30,
	maxFarmDistance = 110,
	waitPollInterval = 1.5,
	backDistance = 3.5,
	attackDelay = 0.15,
	blinkDepth = -100,
	blinkSetupWait = 0.08,
	farmPollInterval = 0.08,
	noEnemyWait = 0.5,
	respawnWait = 0.35,
	clickLogEvery = 25,
	minAttackDelay = 1 / 60,
	cameraHeight = 2,
	cameraBackOffset = 5,
	antiAfkMinInterval = 60,
	antiAfkMaxInterval = 90,
}

local STATE = _G.RedlinerAutoFarm or {}
_G.RedlinerAutoFarm = STATE
STATE._joinAttemptAt = STATE._joinAttemptAt
STATE._dropInDone = STATE._dropInDone == true

local CONFIG = STATE.config or {}
for key, value in DEFAULT_CONFIG do
	if CONFIG[key] == nil then
		CONFIG[key] = value
	end
end
STATE.config = CONFIG

-- ---------------------------------------------------------------------------
-- Services
-- ---------------------------------------------------------------------------

local cloneref = cloneref or function(obj)
	return obj
end

local Players = cloneref(game:GetService('Players'))
local RunService = cloneref(game:GetService('RunService'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local VirtualInputManager = cloneref(game:GetService('VirtualInputManager'))
local VirtualUser = cloneref(game:GetService('VirtualUser'))
local TeleportService = cloneref(game:GetService('TeleportService'))
local HttpService = cloneref(game:GetService('HttpService'))
local CoreGui = cloneref(game:GetService('CoreGui'))
local Workspace = cloneref(workspace)

local LocalPlayer = Players.LocalPlayer

-- ---------------------------------------------------------------------------
-- Logging
-- ---------------------------------------------------------------------------

local PREFIX = '[AutoFarm]'

local function log(...)
	print(PREFIX, ...)
end

local function logWarn(...)
	warn(PREFIX, ...)
end

local function logPhase(phase, detail)
	if detail ~= nil then
		log('PHASE:', phase, '|', detail)
	else
		log('PHASE:', phase)
	end
end

local function logError(context, err)
	logWarn('ERROR in', context .. ':', tostring(err))
	if debug and debug.traceback then
		logWarn(debug.traceback(err, 2))
	end
end

local function safeCall(context, fn, ...)
	local ok, result = pcall(fn, ...)
	if not ok then
		logError(context, result)
	end
	return ok, result
end

-- ---------------------------------------------------------------------------
-- Executor capability probe
-- ---------------------------------------------------------------------------

local CAPS = {
	setfflag = setfflag ~= nil,
	mouse1click = mouse1click ~= nil,
	isrbxactive = isrbxactive ~= nil,
	iswindowactive = iswindowactive ~= nil,
}

log('Script loaded — REDLINER standalone AutoFarm (PlaceId=' .. tostring(game.PlaceId) .. ', autoJoin=' .. tostring(CONFIG.autoJoin) .. ')')
log('Capabilities:',
	'setfflag=' .. tostring(CAPS.setfflag),
	'mouse1click=' .. tostring(CAPS.mouse1click),
	'isrbxactive=' .. tostring(CAPS.isrbxactive),
	'iswindowactive=' .. tostring(CAPS.iswindowactive))

if not CAPS.setfflag then
	logWarn('setfflag unavailable — blink movement-only will be skipped (farm still TPs + clicks)')
end

-- ---------------------------------------------------------------------------
-- State
-- ---------------------------------------------------------------------------

local running = false
local loopToken = 0
local currentTarget = nil
local blinkHeld = false
local lastAttackAt = 0
local clickCount = 0
local stepBound = false
local attackBound = false
local cameraBound = false
local characterConn = nil
local antiAfkRunning = false
local savedCameraType = nil
local savedCameraSubject = nil

-- ---------------------------------------------------------------------------
-- Status dot UI (bottom-right: green=running, red=stopped)
-- ---------------------------------------------------------------------------

local STATUS_DOT_SIZE = 14
local STATUS_DOT_PADDING = 16
local STATUS_COLOR_ACTIVE = Color3.fromRGB(60, 200, 80)
local STATUS_COLOR_STOPPED = Color3.fromRGB(220, 55, 55)

local statusDot = nil

local function setStatusDotActive(active)
	if not statusDot then
		return
	end
	statusDot.BackgroundColor3 = active and STATUS_COLOR_ACTIVE or STATUS_COLOR_STOPPED
end

local function createStatusDot()
	local playerGui = LocalPlayer:FindFirstChild('PlayerGui')
	if not playerGui then
		playerGui = LocalPlayer:WaitForChild('PlayerGui', 10)
	end
	if not playerGui then
		logWarn('Status dot skipped — PlayerGui unavailable')
		return
	end

	local existing = playerGui:FindFirstChild('RedlinerAutoFarmStatus')
	if existing then
		existing:Destroy()
	end

	local gui = Instance.new('ScreenGui')
	gui.Name = 'RedlinerAutoFarmStatus'
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 9999

	local dot = Instance.new('Frame')
	dot.Name = 'StatusDot'
	dot.Size = UDim2.fromOffset(STATUS_DOT_SIZE, STATUS_DOT_SIZE)
	dot.Position = UDim2.new(1, -STATUS_DOT_PADDING, 1, -STATUS_DOT_PADDING)
	dot.AnchorPoint = Vector2.new(1, 1)
	dot.BackgroundColor3 = STATUS_COLOR_STOPPED
	dot.BorderSizePixel = 0

	local corner = Instance.new('UICorner')
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = dot

	dot.Parent = gui
	gui.Parent = playerGui
	statusDot = dot
	log('Status dot created (green=running, red=stopped)')
end

task.defer(createStatusDot)


local function isTargetPlace()
	return game.PlaceId == CONFIG.targetPlaceId
end

local function httpGetPublicServers(placeId, limit)
	limit = limit or 10
	local url = ('https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=%d'):format(placeId, limit)
	local ok, body = pcall(function()
		if HttpService.GetAsync then
			return HttpService:GetAsync(url)
		end
		if game.HttpGet then
			return game:HttpGet(url)
		end
		error('HttpGet unavailable')
	end)
	if not ok or type(body) ~= 'string' then
		return nil, body
	end
	local decodeOk, data = pcall(function()
		return HttpService:JSONDecode(body)
	end)
	if not decodeOk then
		return nil, data
	end
	return data
end

local function pickOpenServer(servers)
	if type(servers) ~= 'table' then
		return nil
	end
	for _, server in servers do
		local playing = tonumber(server.playing) or 0
		local maxPlayers = tonumber(server.maxPlayers) or 0
		if server.id and playing > 0 and (maxPlayers <= 0 or playing < maxPlayers) then
			return server.id
		end
	end
	for _, server in servers do
		if server.id then
			return server.id
		end
	end
	return nil
end

local function teleportToTargetGame()
	local placeId = CONFIG.targetPlaceId
	local player = LocalPlayer
	local jobId = nil

	local data = httpGetPublicServers(placeId, 10)
	if data and data.data then
		jobId = pickOpenServer(data.data)
		if jobId then
			log('Teleport: picked public server jobId=' .. tostring(jobId))
		end
	end

	if jobId then
		local ok, err = pcall(function()
			TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
		end)
		if ok then
			return true
		end
		logWarn('TeleportToPlaceInstance failed:', tostring(err))
	end

	local ok, err = pcall(function()
		TeleportService:Teleport(placeId, player)
	end)
	if not ok then
		logWarn('Teleport failed:', tostring(err))
		return false
	end
	log('Teleport: random server via Teleport()')
	return true
end

local function ensureCorrectGame()
	if isTargetPlace() then
		return true
	end
	if not CONFIG.autoJoin then
		logWarn('Wrong place (PlaceId=' .. tostring(game.PlaceId) .. ') and autoJoin=false')
		return false
	end

	local now = tick()
	local lastAttempt = STATE._joinAttemptAt or 0
	local cooldown = CONFIG.joinAttemptCooldown or 30
	if now - lastAttempt < cooldown then
		logWarn('Join cooldown active (' .. string.format('%.0f', cooldown - (now - lastAttempt)) .. 's left)')
		return false
	end

	STATE._joinAttemptAt = now
	logPhase('teleport_game', 'not in FFA, joining...')
	teleportToTargetGame()
	return false
end

local function normalizeDropInText(text)
	if type(text) ~= 'string' or text == '' then
		return false
	end
	local upper = text:upper()
	if upper == 'DROP-IN' then
		return true
	end
	local compact = upper:gsub('%s+', '-')
	return compact == 'DROP-IN' or compact == 'DROPIN'
end

local function getGuiDisplayText(guiObj)
	if guiObj:IsA('TextButton') or guiObj:IsA('TextLabel') then
		return guiObj.Text
	end
	local label = guiObj:FindFirstChildWhichIsA('TextLabel', true)
	if label then
		return label.Text
	end
	return nil
end

local function isDropInButton(obj)
	if not obj:IsA('GuiButton') and not obj:IsA('TextButton') and not obj:IsA('ImageButton') then
		return false
	end
	return normalizeDropInText(getGuiDisplayText(obj))
end

local function collectGuiRoots()
	local roots = {}
	local playerGui = LocalPlayer:FindFirstChild('PlayerGui')
	if playerGui then
		table.insert(roots, playerGui)
	end
	table.insert(roots, CoreGui)
	return roots
end

local function findDropInButton()
	for _, root in collectGuiRoots() do
		for _, desc in root:GetDescendants() do
			if isDropInButton(desc) then
				return desc
			end
		end
	end
	return nil
end

local function fireButtonSignal(button, signalName)
	if not getconnections then
		return false
	end
	local signal = button[signalName]
	if not signal then
		return false
	end
	local any = false
	for _, conn in getconnections(signal) do
		local ok = pcall(function()
			conn:Fire()
		end)
		any = any or ok
	end
	return any
end

local function pressDropInButton(button)
	local pressed = false

	if button.Activate then
		pressed = pcall(function()
			button:Activate()
		end) or pressed
	end

	if firesignal then
		if button.Activated then
			pressed = pcall(firesignal, button.Activated) or pressed
		end
		if button.MouseButton1Click then
			pressed = pcall(firesignal, button.MouseButton1Click) or pressed
		end
	end

	pressed = fireButtonSignal(button, 'Activated') or pressed
	pressed = fireButtonSignal(button, 'MouseButton1Click') or pressed

	if button:IsA('GuiObject') then
		local pos = button.AbsolutePosition
		local size = button.AbsoluteSize
		local cx = pos.X + size.X * 0.5
		local cy = pos.Y + size.Y * 0.5
		pressed = safeCall('dropIn.VIM', function()
			VirtualInputManager:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
			VirtualInputManager:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
		end) or pressed
	end

	return pressed
end

local function runDropInFlow()
	if STATE._dropInDone then
		log('DROP-IN already pressed this session — skipping scan')
		return true
	end

	logPhase('drop_in_scan')
	while not _G.AutoFarmStop do
		local button = findDropInButton()
		if button then
			logPhase('drop_in_found', button:GetFullName())
			pressDropInButton(button)
			logPhase('drop_in_pressed')
			STATE._dropInDone = true
			task.wait(CONFIG.dropInWaitAfterPress)
			return true
		end
		task.wait(CONFIG.dropInScanInterval)
	end
	return false
end

-- ---------------------------------------------------------------------------
-- Window focus
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

-- ---------------------------------------------------------------------------
-- Character helpers
-- ---------------------------------------------------------------------------

local function getCharacter(plr)
	plr = plr or LocalPlayer
	local char = plr.Character
	if char and char.Parent then
		return char
	end
	return nil
end

local function getRoot(plr)
	local char = getCharacter(plr)
	if not char then
		return nil
	end
	return char:FindFirstChild('HumanoidRootPart')
end

local function isAlive(plr)
	plr = plr or LocalPlayer
	local char = getCharacter(plr)
	if not char then
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

-- ---------------------------------------------------------------------------
-- Enemy detection (REDLINER Chrono_EntityStorage clones)
-- ---------------------------------------------------------------------------

local function getPlayerFromModel(model)
	if not model then
		return nil
	end
	local plr = Players:GetPlayerFromCharacter(model)
	if plr then
		return plr
	end
	for _, p in Players:GetPlayers() do
		if p ~= LocalPlayer and p.Character and (model:IsDescendantOf(p.Character) or model == p.Character) then
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
	local chronoStorage = Workspace:FindFirstChild('Chrono_EntityStorage')
	if chronoStorage then
		for _, child in chronoStorage:GetChildren() do
			if child:IsA('Model') and getPlayerFromModel(child) == plr then
				table.insert(models, child)
			end
		end
	end
	return models
end

local function isEnemyAlive(plr)
	if not plr or plr == LocalPlayer then
		return false
	end
	for _, model in getEnemyModels(plr) do
		if model and model.Parent then
			local hum = model:FindFirstChildWhichIsA('Humanoid')
			if hum and hum.Health > 0 and hum:GetState() ~= Enum.HumanoidStateType.Dead then
				return true
			end
		end
	end
	return false
end

local function getEnemyRoot(plr)
	for _, model in getEnemyModels(plr) do
		if model and model.Parent then
			local root = model:FindFirstChild('HumanoidRootPart')
			if root then
				return root
			end
		end
	end
	return nil
end

local function collectAliveEnemies()
	local list = {}
	for _, plr in Players:GetPlayers() do
		if plr ~= LocalPlayer and isEnemyAlive(plr) then
			table.insert(list, plr)
		end
	end
	return list
end

local function getDistanceToEnemy(plr)
	local myRoot = getRoot()
	local enemyRoot = getEnemyRoot(plr)
	if not myRoot or not enemyRoot then
		return math.huge
	end
	return (enemyRoot.Position - myRoot.Position).Magnitude
end

local function collectEnemiesInRange(maxDist)
	local list = {}
	local myRoot = getRoot()
	if not myRoot then
		return list
	end
	maxDist = maxDist or CONFIG.maxFarmDistance
	for _, plr in Players:GetPlayers() do
		if plr ~= LocalPlayer and isEnemyAlive(plr) then
			local dist = getDistanceToEnemy(plr)
			if dist <= maxDist then
				table.insert(list, plr)
			else
				log('skip: too_far name=' .. plr.Name
					.. ' dist=' .. string.format('%.1f', dist)
					.. ' max=' .. tostring(maxDist))
			end
		end
	end
	return list
end

-- ---------------------------------------------------------------------------
-- Teleport + attach
-- ---------------------------------------------------------------------------

local function getAttachCFrame(targetRoot, distance)
	local look = targetRoot.CFrame.LookVector
	local flatLook = Vector3.new(look.X, 0, look.Z)
	if flatLook.Magnitude < 0.01 then
		flatLook = Vector3.new(0, 0, -1)
	else
		flatLook = flatLook.Unit
	end
	local pos = targetRoot.Position - flatLook * distance
	pos = Vector3.new(pos.X, targetRoot.Position.Y, pos.Z)
	return CFrame.lookAt(pos, targetRoot.Position)
end

local function teleportTo(cf)
	local root = getRoot()
	if not root then
		logWarn('teleportTo failed — no local HumanoidRootPart')
		return false
	end
	local ok = safeCall('teleportTo.CFrame', function()
		root.CFrame = cf
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end)
	local char = getCharacter()
	if char then
		safeCall('teleportTo.PivotTo', function()
			char:PivotTo(cf)
		end)
	end
	return ok
end

-- ---------------------------------------------------------------------------
-- Blink (movement-only, no autosend) — universal.lua pattern
-- ---------------------------------------------------------------------------

local BLINK_FLAGS = {
	{ name = 'S2PhysicsSenderRate', getValue = function(physicsrate) return physicsrate end },
	{ name = 'PhysicsSenderMaxBandwidthBps', getValue = function(physicsrate) return physicsrate == '0' and '0' or '38760' end },
	{ name = 'DataSenderRate', getValue = function(_, senderrate) return senderrate end },
}

local function applyBlinkRates(physicsrate, senderrate, silent)
	if not CAPS.setfflag then
		return false
	end
	local anyOk = false
	for _, flag in BLINK_FLAGS do
		local value = flag.getValue(physicsrate, senderrate)
		local ok, err = pcall(function()
			setfflag(flag.name, value)
		end)
		if ok then
			if not silent then
				log('Blink flag OK:', flag.name, '=', value)
			end
			anyOk = true
		else
			logWarn('Blink flag FAIL:', flag.name, '=', value, '|', tostring(err))
		end
	end
	return anyOk
end

local function holdBlinkMovementOnly()
	if blinkHeld then
		return applyBlinkRates('0', '60', true)
	end
	logPhase('blink_hold', 'movement-only (physics=0, data=60)')
	blinkHeld = true
	return applyBlinkRates('0', '60')
end

local function releaseBlink(force, reason)
	local wasHeld = blinkHeld
	if not wasHeld and not force then
		return
	end
	if wasHeld then
		logPhase('blink_release', reason or 'restoring physics=15 data=60')
	end
	blinkHeld = false
	applyBlinkRates('15', '60', not wasHeld)
end

local function resetBlinkForTarget()
	releaseBlink(true, 'target_switch_or_kill')
end

-- ---------------------------------------------------------------------------
-- Anti-AFK (starts/stops with farm)
-- ---------------------------------------------------------------------------

local function runAntiAfkTick()
	local ok = pcall(function()
		VirtualUser:CaptureFocus()
		VirtualUser:ClickButton2(Vector2.new())
	end)
	if ok then
		log('AntiAFK: tick')
		return true
	end

	ok = pcall(function()
		if getconnections and LocalPlayer.Idle then
			for _, conn in getconnections(LocalPlayer.Idle) do
				conn:Fire()
			end
		else
			error('getconnections/Idle unavailable')
		end
	end)
	if ok then
		log('AntiAFK: tick')
		return true
	end

	logWarn('AntiAFK: no method available (VirtualUser / getconnections Idle)')
	return false
end

local function startAntiAfk()
	if antiAfkRunning then
		return
	end
	antiAfkRunning = true
	task.spawn(function()
		while antiAfkRunning do
			local minI = CONFIG.antiAfkMinInterval or 60
			local maxI = CONFIG.antiAfkMaxInterval or 90
			local waitTime = minI + math.random() * (maxI - minI)
			task.wait(waitTime)
			if not antiAfkRunning then
				break
			end
			runAntiAfkTick()
		end
	end)
	log('AntiAFK started (interval ~' .. tostring(CONFIG.antiAfkMinInterval) .. '-' .. tostring(CONFIG.antiAfkMaxInterval) .. 's)')
end

local function stopAntiAfk()
	antiAfkRunning = false
end

-- ---------------------------------------------------------------------------
-- Camera follow (over-shoulder toward current target)
-- ---------------------------------------------------------------------------

local function saveCameraState()
	local cam = Workspace.CurrentCamera
	if cam and savedCameraType == nil then
		savedCameraType = cam.CameraType
		savedCameraSubject = cam.CameraSubject
	end
end

local function restoreCamera()
	local cam = Workspace.CurrentCamera
	if cam and savedCameraType ~= nil then
		safeCall('camera.restore', function()
			cam.CameraType = savedCameraType
			if savedCameraSubject then
				cam.CameraSubject = savedCameraSubject
			end
		end)
		savedCameraType = nil
		savedCameraSubject = nil
	end
end

local function updateCameraFollow(targetRoot, root)
	local cam = Workspace.CurrentCamera
	if not cam or not targetRoot or not root then
		return
	end
	local toTarget = targetRoot.Position - root.Position
	local flatLook = Vector3.new(toTarget.X, 0, toTarget.Z)
	if flatLook.Magnitude < 0.01 then
		flatLook = root.CFrame.LookVector
	else
		flatLook = flatLook.Unit
	end
	local camPos = root.Position
		+ Vector3.new(0, CONFIG.cameraHeight, 0)
		- flatLook * CONFIG.cameraBackOffset
	local aimAt = targetRoot.Position + Vector3.new(0, 1, 0)
	safeCall('camera.follow', function()
		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = CFrame.lookAt(camPos, aimAt)
	end)
end

local function bindCameraFollow()
	if cameraBound then
		return
	end
	cameraBound = true
	RunService.RenderStepped:Connect(function()
		if not running or _G.AutoFarmStop then
			return
		end
		if not currentTarget or not isAlive() then
			return
		end
		local targetRoot = getEnemyRoot(currentTarget)
		local root = getRoot()
		if not targetRoot or not root then
			return
		end
		if not isEnemyAlive(currentTarget) then
			return
		end
		updateCameraFollow(targetRoot, root)
	end)
end

-- ---------------------------------------------------------------------------
-- Click
-- ---------------------------------------------------------------------------

local function pressAttackClick()
	if not isGameWindowFocused() then
		return false
	end

	if CAPS.mouse1click then
		local ok = safeCall('mouse1click', mouse1click)
		if ok then
			clickCount += 1
			if clickCount % CONFIG.clickLogEvery == 0 then
				log('Click burst — total clicks:', clickCount, '(window focused)')
			end
			lastAttackAt = tick()
			return true
		end
		return false
	end

	local mousePos = UserInputService:GetMouseLocation()
	safeCall('VIM.mouseDown', function()
		VirtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, true, game, 1)
	end)
	task.defer(function()
		safeCall('VIM.mouseUp', function()
			VirtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, false, game, 1)
		end)
	end)

	clickCount += 1
	if clickCount % CONFIG.clickLogEvery == 0 then
		log('Click burst (VIM) — total clicks:', clickCount)
	end
	lastAttackAt = tick()
	return true
end

-- ---------------------------------------------------------------------------
-- Per-frame farm step (independent of blink success)
-- ---------------------------------------------------------------------------

local function bindFarmStep()
	if stepBound then
		return
	end
	stepBound = true
	RunService.RenderStepped:Connect(function()
		if not running or _G.AutoFarmStop then
			return
		end
		if blinkHeld then
			applyBlinkRates('0', '60', true)
		end
		if not currentTarget or not isAlive() then
			return
		end
		local targetRoot = getEnemyRoot(currentTarget)
		local root = getRoot()
		if not targetRoot or not root then
			return
		end
		if not isEnemyAlive(currentTarget) then
			return
		end
		local cf = getAttachCFrame(targetRoot, CONFIG.backDistance)
		safeCall('farmStep.snap', function()
			root.CFrame = cf
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end)
	end)
end

local function bindAttackLoop()
	if attackBound then
		return
	end
	attackBound = true
	RunService.RenderStepped:Connect(function()
		if not running or _G.AutoFarmStop then
			return
		end
		if not currentTarget or not isAlive() then
			return
		end
		if not isEnemyAlive(currentTarget) then
			return
		end
		local interval = CONFIG.attackDelay > 0 and CONFIG.attackDelay or CONFIG.minAttackDelay
		if tick() - lastAttackAt >= interval then
			pressAttackClick()
		end
	end)
end

-- ---------------------------------------------------------------------------
-- Target setup phases
-- ---------------------------------------------------------------------------

local function runTargetSetup(plr, targetRoot)
	local root = getRoot()
	if not root then
		logWarn('setup skip — no local root')
		return false
	end

	targetRoot = getEnemyRoot(plr)
	if not targetRoot or not targetRoot.Parent then
		logWarn('setup skip — no target HRP for', plr.Name)
		releaseBlink(true, 'no_target_hrp')
		return false
	end

	local pos = root.Position
	log('Target:', plr.Name,
		'| dist=', string.format('%.1f', (targetRoot.Position - pos).Magnitude),
		'| targetPos=', tostring(targetRoot.Position))

	-- 1. full blink release/reset
	releaseBlink(true, 'pre_target_setup')

	-- 2. brief settle so restored flags apply
	task.wait(CONFIG.blinkSetupWait)

	-- 3. TP down to blink depth (keep X/Z)
	local downPos = Vector3.new(pos.X, CONFIG.blinkDepth, pos.Z)
	logPhase('tp_down', 'before=' .. tostring(pos) .. ' -> ' .. tostring(downPos))
	if not teleportTo(CFrame.new(downPos)) then
		logWarn('tp_down failed — continuing anyway')
	end
	local afterDown = getRoot()
	if afterDown then
		log('tp_down after=', tostring(afterDown.Position))
	end

	-- 4. start blink (movement only) BEFORE locking onto target
	local blinkOk = holdBlinkMovementOnly()
	if not blinkOk then
		logWarn('blink_hold failed or unavailable — continuing to tp_behind + farm')
	end

	-- brief settle so blink flags apply before attach TP
	task.wait(CONFIG.blinkSetupWait)

	-- re-validate target HRP before tp_behind
	targetRoot = getEnemyRoot(plr)
	if not targetRoot or not targetRoot.Parent or not isEnemyAlive(plr) then
		logWarn('tp_behind skip — target HRP invalid for', plr.Name)
		releaseBlink(true, 'target_hrp_invalid')
		return false
	end

	-- 5. TP behind target at play height (match target Y, not blink depth)
	local beforeBehind = getRoot()
	local beforePos = beforeBehind and beforeBehind.Position or pos
	local attachCF = getAttachCFrame(targetRoot, CONFIG.backDistance)
	logPhase('tp_behind', plr.Name
		.. ' before=' .. tostring(beforePos)
		.. ' -> ' .. tostring(attachCF.Position)
		.. ' targetY=' .. string.format('%.1f', targetRoot.Position.Y))
	if not teleportTo(attachCF) then
		logWarn('tp_behind failed — RenderStepped will keep snapping each frame')
	end
	local afterBehind = getRoot()
	if afterBehind then
		log('tp_behind after=', tostring(afterBehind.Position))
	end

	logPhase('camera_follow', 'target=' .. plr.Name)
	logPhase('farming', plr.Name)
	return true
end

-- ---------------------------------------------------------------------------
-- Main loop
-- ---------------------------------------------------------------------------

local function farmMainLoop(token)
	bindFarmStep()
	bindAttackLoop()
	bindCameraFollow()

	while running and token == loopToken and not _G.AutoFarmStop do
		if not isAlive() then
			logPhase('waiting_respawn')
			currentTarget = nil
			releaseBlink(true)
			task.wait(CONFIG.respawnWait)
			continue
		end

		local enemies = collectEnemiesInRange(CONFIG.maxFarmDistance)
		if #enemies == 0 then
			logPhase('waiting', 'no_targets_in_range')
			currentTarget = nil
			releaseBlink(true)
			task.wait(CONFIG.waitPollInterval)
			continue
		end

		log('Enemies in range:', #enemies, table.concat(
			(function()
				local names = {}
				for _, e in enemies do
					table.insert(names, e.Name)
				end
				return names
			end)(),
			', '
		))

		for _, plr in enemies do
			if not running or token ~= loopToken or _G.AutoFarmStop then
				break
			end
			if not isAlive() then
				break
			end
			if not isEnemyAlive(plr) then
				log('Skip dead/invalid:', plr.Name)
				continue
			end
			local targetRoot = getEnemyRoot(plr)
			if not targetRoot then
				logWarn('Skip — no HRP for', plr.Name)
				continue
			end
			local dist = getDistanceToEnemy(plr)
			if dist > CONFIG.maxFarmDistance then
				log('skip: too_far name=' .. plr.Name
					.. ' dist=' .. string.format('%.1f', dist)
					.. ' max=' .. tostring(CONFIG.maxFarmDistance))
				continue
			end

			logPhase('next_target', plr.Name)
			currentTarget = plr
			if not runTargetSetup(plr, targetRoot) then
				currentTarget = nil
				continue
			end

			while running and token == loopToken and not _G.AutoFarmStop
				and isAlive() and isEnemyAlive(plr) do
				task.wait(CONFIG.farmPollInterval)
			end

			if not isEnemyAlive(plr) then
				logPhase('target_died', plr.Name)
			else
				log('Stopped farming', plr.Name, '(alive=', isEnemyAlive(plr), 'localAlive=', isAlive(), ')')
			end

			currentTarget = nil
			resetBlinkForTarget()
			task.wait(0.05)
		end
	end

	currentTarget = nil
	releaseBlink(true)
	restoreCamera()
	stopAntiAfk()
	running = false
	setStatusDotActive(false)
	log('Farm loop ended')
end

-- ---------------------------------------------------------------------------
-- Start / stop API
-- ---------------------------------------------------------------------------

local function startFarm()
	if running then
		log('Already running')
		return
	end
	if _G.AutoFarmStop then
		logWarn('Start blocked — _G.AutoFarmStop is true')
		return
	end
	saveCameraState()
	running = true
	setStatusDotActive(true)
	loopToken += 1
	local token = loopToken
	startAntiAfk()
	log('Starting farm loop (token=' .. token .. ', maxDist=' .. tostring(CONFIG.maxFarmDistance) .. ')')
	task.spawn(function()
		farmMainLoop(token)
	end)
end

local function stopFarm()
	if not running then
		releaseBlink(true)
		stopAntiAfk()
		restoreCamera()
		setStatusDotActive(false)
		return
	end
	log('Stopping farm loop')
	running = false
	setStatusDotActive(false)
	loopToken += 1
	currentTarget = nil
	releaseBlink(true)
	stopAntiAfk()
	restoreCamera()
end

STATE.start = startFarm
STATE.stop = stopFarm
STATE.config = CONFIG

-- ---------------------------------------------------------------------------
-- Auto-start: join FFA → DROP-IN → farm
-- ---------------------------------------------------------------------------

local function onCharacterReady()
	if _G.AutoFarmStop then
		log('_G.AutoFarmStop set — not auto-starting (call _G.RedlinerAutoFarm.start() manually)')
		return
	end
	task.wait(0.5)
	if isAlive() then
		startFarm()
	else
		logWarn('Character not alive after wait — retrying on next spawn')
	end
end

local function bindCharacter()
	if characterConn then
		characterConn:Disconnect()
	end
	characterConn = LocalPlayer.CharacterAdded:Connect(function()
		log('CharacterAdded — rebinding farm')
		currentTarget = nil
		releaseBlink(true)
		restoreCamera()
		if running then
			saveCameraState()
			task.wait(0.75)
		elseif not CONFIG.autoJoin or STATE._dropInDone then
			onCharacterReady()
		end
	end)
	if LocalPlayer.Character then
		onCharacterReady()
	else
		log('Waiting for character...')
	end
end

local function runAutoStartup()
	if _G.AutoFarmStop then
		log('_G.AutoFarmStop set — auto flow disabled')
		return
	end

	if CONFIG.autoJoin then
		if not ensureCorrectGame() then
			return
		end
		task.spawn(function()
			if not runDropInFlow() then
				return
			end
			logPhase('farm_start')
			bindCharacter()
		end)
		return
	end

	bindCharacter()
end

runAutoStartup()

log('Ready — auto-join + DROP-IN + farm enabled. Set _G.AutoFarmStop=true to disable. Stop with _G.RedlinerAutoFarm.stop()')
