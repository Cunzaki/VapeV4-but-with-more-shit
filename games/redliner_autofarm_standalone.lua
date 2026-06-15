--[[
	REDLINER AutoFarm — standalone (no Vape dependency).
	Execute in your executor while in a REDLINER place (94987506187454 / 115875349872417 / 126691165749976).

	Auto-starts when your character loads. Set _G.AutoFarmStop = true before running to prevent start.
	Set _G.AutoFarmStop = true while running to stop gracefully.
]]

-- ---------------------------------------------------------------------------
-- Config
-- ---------------------------------------------------------------------------

local CONFIG = {
	backDistance = 3.5,
	attackDelay = 0.15,
	blinkDepth = -5000,
	blinkSetupWait = 0.06,
	farmPollInterval = 0.08,
	noEnemyWait = 0.5,
	respawnWait = 0.35,
	clickLogEvery = 25,
	minAttackDelay = 1 / 60,
}

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

log('Script loaded — REDLINER standalone AutoFarm')
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
local characterConn = nil

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

local function applyBlinkRates(physicsrate, senderrate)
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
			log('Blink flag OK:', flag.name, '=', value)
			anyOk = true
		else
			logWarn('Blink flag FAIL:', flag.name, '=', value, '|', tostring(err))
		end
	end
	return anyOk
end

local function holdBlink()
	if blinkHeld then
		return applyBlinkRates('0', '60')
	end
	logPhase('blink_on', 'movement-only (physics=0, data=60)')
	blinkHeld = true
	return applyBlinkRates('0', '60')
end

local function releaseBlink()
	if not blinkHeld then
		return
	end
	logPhase('blink_off', 'restoring physics=15 data=60')
	blinkHeld = false
	applyBlinkRates('15', '60')
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
			applyBlinkRates('0', '60')
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
	if not targetRoot then
		logWarn('setup skip — no target root for', plr.Name)
		return false
	end

	local pos = root.Position
	log('Target:', plr.Name,
		'| dist=', string.format('%.1f', (targetRoot.Position - pos).Magnitude),
		'| targetPos=', tostring(targetRoot.Position))

	logPhase('tp_down', 'Y=' .. tostring(CONFIG.blinkDepth) .. ' X/Z=' .. string.format('%.1f,%.1f', pos.X, pos.Z))
	if not teleportTo(CFrame.new(pos.X, CONFIG.blinkDepth, pos.Z)) then
		logWarn('tp_down failed — continuing anyway')
	end

	local blinkOk = holdBlink()
	if not blinkOk then
		logWarn('blink_on failed or unavailable — continuing to tp_behind + farm')
	end

	task.wait(CONFIG.blinkSetupWait)

	local attachCF = getAttachCFrame(targetRoot, CONFIG.backDistance)
	logPhase('tp_behind', plr.Name .. ' @ ' .. tostring(attachCF.Position))
	if not teleportTo(attachCF) then
		logWarn('tp_behind failed — RenderStepped will keep snapping each frame')
	end

	logPhase('farming', plr.Name)
	return true
end

-- ---------------------------------------------------------------------------
-- Main loop
-- ---------------------------------------------------------------------------

local function farmMainLoop(token)
	bindFarmStep()
	bindAttackLoop()

	while running and token == loopToken and not _G.AutoFarmStop do
		if not isAlive() then
			logPhase('waiting_respawn')
			currentTarget = nil
			releaseBlink()
			task.wait(CONFIG.respawnWait)
			continue
		end

		local enemies = collectAliveEnemies()
		if #enemies == 0 then
			log('No alive enemies — waiting')
			currentTarget = nil
			releaseBlink()
			task.wait(CONFIG.noEnemyWait)
			continue
		end

		log('Enemies found:', #enemies, table.concat(
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

			logPhase('next_target', plr.Name)
			currentTarget = plr
			runTargetSetup(plr, targetRoot)

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
			releaseBlink()
			task.wait(0.05)
		end
	end

	currentTarget = nil
	releaseBlink()
	running = false
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
	running = true
	loopToken += 1
	local token = loopToken
	log('Starting farm loop (token=' .. token .. ')')
	task.spawn(function()
		farmMainLoop(token)
	end)
end

local function stopFarm()
	if not running then
		releaseBlink()
		return
	end
	log('Stopping farm loop')
	running = false
	loopToken += 1
	currentTarget = nil
	releaseBlink()
end

_G.RedlinerAutoFarm = {
	start = startFarm,
	stop = stopFarm,
	config = CONFIG,
}

-- ---------------------------------------------------------------------------
-- Auto-start on character load
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
		releaseBlink()
		if running then
			task.wait(0.75)
		else
			onCharacterReady()
		end
	end)
	if LocalPlayer.Character then
		onCharacterReady()
	else
		log('Waiting for character...')
	end
end

bindCharacter()

log('Ready — auto-start enabled. Set _G.AutoFarmStop=true to disable. Stop with _G.RedlinerAutoFarm.stop()')
