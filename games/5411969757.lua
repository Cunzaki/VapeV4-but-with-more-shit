local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local lightingService = cloneref(game:GetService('Lighting'))
local runService = cloneref(game:GetService('RunService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity

if not vape.Categories.Minigames then
	vape.Categories.Minigames = vape:CreateCategory({
		Name = 'Minigames',
		Icon = 'vape/assets/new/minigames.png'
	})
end
local minigames = vape.Categories.Minigames

local function isFriend(plr, recolor)
	if vape.Categories.Friends.Options['Use friends'].Enabled then
		local friend = table.find(vape.Categories.Friends.ListEnabled, plr.Name) and true
		if recolor then
			friend = friend and vape.Categories.Friends.Options['Recolor visuals'].Enabled
		end
		return friend
	end
	return nil
end

local function getTeamFlags(team)
	if not team then
		return nil, nil
	end
	return team:FindFirstChild('isFFA'), team:FindFirstChild('isLobby')
end

local function canTargetPlayer(plr)
	if plr == lplr then
		return false
	end

	local localTeam = lplr.Team
	local targetTeam = plr.Team
	local localFFA, localLobby = getTeamFlags(localTeam)
	local targetFFA, targetLobby = getTeamFlags(targetTeam)

	if localLobby or targetLobby then
		return true
	end
	if localFFA or targetFFA then
		return true
	end

	if vape.Categories.Main.Options['Teams by server'].Enabled then
		if not localTeam or not targetTeam then
			return true
		end
		if targetTeam ~= localTeam then
			return true
		end
		return #targetTeam:GetPlayers() == #playersService:GetPlayers()
	end

	if not localTeam or not targetTeam then
		return true
	end
	return targetTeam ~= localTeam
end

local function getFTPlayerTeamColor(plr)
	if not plr then
		return
	end
	if tostring(plr.TeamColor) ~= 'White' then
		return plr.TeamColor.Color
	end
	if plr.Team and tostring(plr.Team.TeamColor) ~= 'White' then
		return plr.Team.TeamColor.Color
	end
end

local InfiniteAmmo, FireRate, FireDelay, InstantReload
local weaponHeartbeat
local weaponHeartbeatAccum = 0
local WEAPON_HEARTBEAT_INTERVAL = 0.05
local gunHookOriginals = {wait = nil, taskWait = nil}
local gunHookState = {fireDelay = nil, instantReload = false}
local knownFireDelays = {[0.09] = true, [0.1] = true}
local wrappedLegacyReloads = setmetatable({}, {__mode = 'k'})
local wrappedVAKReloads = setmetatable({}, {__mode = 'k'})
local wrappedVAKMediRecharges = setmetatable({}, {__mode = 'k'})
local trackedWeaponStats = setmetatable({}, {__mode = 'k'})
local connectorWeaponRef
local vakServiceHooksInstalled = false

local WEAPON_STAT_KEYS = {'RoF', 'Rate', 'Ammo', 'MaxAmmo', 'Charge', 'MaxCharge', 'ReloadTime', 'Recharge', 'BaseDamage', 'BaseHeal'}

local function registerFireDelay(delayTime)
	if type(delayTime) == 'number' and delayTime > 0 and delayTime <= 0.5 then
		knownFireDelays[delayTime] = true
	end
end

local function isVAKWeaponTable(weapon)
	if type(weapon) ~= 'table' then
		return false
	end

	local model = rawget(weapon, 'Model')
	if not (model and typeof(model) == 'Instance') and rawget(weapon, 'Name') == nil then
		return false
	end

	for _, key in WEAPON_STAT_KEYS do
		if type(rawget(weapon, key)) == 'number' then
			return true
		end
	end

	return false
end

local function tryWeaponFromTool(tool)
	if not tool or not tool:IsA('Tool') then
		return
	end

	if not lplr.PlayerGui:FindFirstChild('VAK_UI') then
		return
	end

	local client = tool:FindFirstChild('Client') or tool:FindFirstChild('Client', true)
	if not client or not client:IsA('ModuleScript') then
		return
	end

	local ok, weapon = pcall(require, client)
	if ok and isVAKWeaponTable(weapon) then
		return weapon
	end
end

local function getVAKWeapons()
	local weapons = {}
	local seen = {}

	for _, parent in {lplr.Character, lplr:FindFirstChild('Backpack')} do
		if parent then
			for _, tool in parent:GetChildren() do
				local weapon = tryWeaponFromTool(tool)
				if weapon and not seen[weapon] then
					seen[weapon] = true
					table.insert(weapons, weapon)
				end
			end
		end
	end

	return weapons
end

local function isWeaponEquipped(weapon)
	if rawget(weapon, 'Out') == true or rawget(weapon, 'IsActive') == true then
		return true
	end

	local model = rawget(weapon, 'Model')
	local char = lplr.Character
	if model and typeof(model) == 'Instance' and char and model:IsDescendantOf(char) then
		return true
	end

	return false
end

local function captureConnectorWeapon()
	if not (getconnections and debug and debug.getupvalue) then
		return connectorWeaponRef
	end

	local char = lplr.Character
	local vakUi = lplr.PlayerGui:FindFirstChild('VAK_UI')
	if not char or not vakUi then
		return connectorWeaponRef
	end

	for _, conn in getconnections(char.ChildAdded) do
		local func = conn.Function
		if func then
			for i = 1, 30 do
				local ok, name, val = pcall(debug.getupvalue, func, i)
				if not ok then
					break
				end
				if name == 'u3' and isVAKWeaponTable(val) then
					connectorWeaponRef = val
					return val
				end
			end
		end
	end

	return connectorWeaponRef
end

local function getActiveVAKWeapons()
	captureConnectorWeapon()

	local active = {}
	local seen = {}

	if connectorWeaponRef and isWeaponEquipped(connectorWeaponRef) and not seen[connectorWeaponRef] then
		seen[connectorWeaponRef] = true
		table.insert(active, connectorWeaponRef)
	end

	for _, weapon in getVAKWeapons() do
		if isWeaponEquipped(weapon) and not seen[weapon] then
			seen[weapon] = true
			table.insert(active, weapon)
		end
	end

	return active
end

local function isToolEquipped(tool)
	local char = lplr.Character
	return char and tool:IsDescendantOf(char)
end

local function findLegacyGunScript(tool)
	local gun = tool:FindFirstChild('Gun', true)
	if gun and gun:IsA('LocalScript') then
		return gun
	end
end

local function getLegacyGunEnvs()
	local envs = {}
	local seen = {}

	if not getsenv then
		return envs
	end

	for _, parent in {lplr.Character, lplr:FindFirstChild('Backpack')} do
		if parent then
			for _, tool in parent:GetChildren() do
				if tool:IsA('Tool') and isToolEquipped(tool) then
					local gun = findLegacyGunScript(tool)
					if gun and not seen[gun] then
						local ok, env = pcall(getsenv, gun)
						if ok and type(env) == 'table' then
							seen[gun] = true
							table.insert(envs, env)
						end
					end
				end
			end
		end
	end

	return envs
end

local function isGunWaitScript(calling)
	if not calling then
		return false
	end
	if calling.Name == 'Gun' or calling.Name == 'ToolService' or calling.Name == 'MediService' or calling.Name == 'Client' or calling.Name == 'Connector' then
		return true
	end
	local parent = calling
	while parent do
		if parent.Name == 'VAK_UI' or (parent:IsA('Tool') and parent:FindFirstChild('Client', true)) then
			return true
		end
		parent = parent.Parent
	end
	return false
end

local function isReloadWait(delayTime)
	return delayTime == 0.4 or delayTime == 0.18 or delayTime == 0.13 or delayTime == 0.04
end

local function isFireWait(delayTime)
	if knownFireDelays[delayTime] then
		return true
	end
	return delayTime >= 0.005 and delayTime <= 0.35 and not isReloadWait(delayTime)
end

local function adjustGunWait(delayTime)
	if type(delayTime) ~= 'number' then
		return delayTime
	end

	if gunHookState.fireDelay and isFireWait(delayTime) then
		return gunHookState.fireDelay
	end

	if gunHookState.instantReload then
		if isReloadWait(delayTime) then
			return 0
		end
		local calling = getcallingscript and getcallingscript()
		if calling and (calling.Name == 'Gun' or calling.Name == 'Client') and delayTime >= 0.03 and delayTime <= 3.5 then
			return 0
		end
	end

	return delayTime
end

local function installGunWaitHook(target, storageKey)
	if gunHookOriginals[storageKey] or not hookfunction then
		return
	end

	gunHookOriginals[storageKey] = hookfunction(target, function(delayTime, ...)
		if not checkcaller() and isGunWaitScript(getcallingscript and getcallingscript()) then
			delayTime = adjustGunWait(delayTime)
		end
		return gunHookOriginals[storageKey](delayTime, ...)
	end)
end

local function removeGunWaitHook(target, storageKey)
	if not gunHookOriginals[storageKey] or not restorefunction then
		return
	end
	pcall(restorefunction, target)
	gunHookOriginals[storageKey] = nil
end

local function syncGunHooks()
	gunHookState.fireDelay = FireRate and FireRate.Enabled and (FireDelay.Value / 100) or nil
	gunHookState.instantReload = InstantReload and InstantReload.Enabled or false

	local active = gunHookState.fireDelay or gunHookState.instantReload
	if not active then
		removeGunWaitHook(wait, 'wait')
		if task.wait ~= wait then
			removeGunWaitHook(task.wait, 'taskWait')
		end
		return
	end

	installGunWaitHook(wait, 'wait')
	if task.wait ~= wait then
		installGunWaitHook(task.wait, 'taskWait')
	end
end

local function wrapLegacyReloadTable(tbl)
	if type(tbl) ~= 'table' or wrappedLegacyReloads[tbl] then
		return
	end

	local oldReload = rawget(tbl, 'Reload')
	if type(oldReload) ~= 'function' then
		return
	end

	wrappedLegacyReloads[tbl] = true
	rawset(tbl, 'Reload', function(...)
		if InstantReload and InstantReload.Enabled then
			return
		end
		return oldReload(...)
	end)
end

local function wrapVAKReload(weapon)
	if wrappedVAKReloads[weapon] then
		return
	end

	local oldReload = rawget(weapon, 'Reload')
	if type(oldReload) ~= 'function' then
		local mt = getmetatable(weapon)
		if mt and type(mt.Reload) == 'function' then
			oldReload = mt.Reload
		else
			return
		end
	end

	wrappedVAKReloads[weapon] = true
	rawset(weapon, 'Reload', function(self, ...)
		if InstantReload and InstantReload.Enabled then
			local maxAmmo = rawget(self, 'MaxAmmo')
			if type(maxAmmo) == 'number' then
				rawset(self, 'Ammo', maxAmmo)
				rawset(self, 'Reloading', false)
				rawset(self, 'Enabled', true)
			end
			return
		end
		return oldReload(self, ...)
	end)
end

local function wrapVAKMediRecharge(weapon)
	if wrappedVAKMediRecharges[weapon] then
		return
	end

	local oldRecharge = rawget(weapon, 'MediRecharge')
	if type(oldRecharge) ~= 'function' then
		local mt = getmetatable(weapon)
		if mt and type(mt.MediRecharge) == 'function' then
			oldRecharge = mt.MediRecharge
		else
			return
		end
	end

	wrappedVAKMediRecharges[weapon] = true
	rawset(weapon, 'MediRecharge', function(self, ...)
		if InstantReload and InstantReload.Enabled then
			local maxCharge = rawget(self, 'MaxCharge')
			if type(maxCharge) == 'number' then
				rawset(self, 'Charge', maxCharge)
			end
			rawset(self, 'Recharging', false)
			return
		end
		return oldRecharge(self, ...)
	end)
end

local function trackWeaponStats(weapon)
	if trackedWeaponStats[weapon] then
		return
	end

	local stats = {}
	for _, key in {'RoF', 'Rate', 'ReloadTime', 'Recharge'} do
		local value = rawget(weapon, key)
		if type(value) == 'number' then
			stats[key] = value
			registerFireDelay(value)
		end
	end
	trackedWeaponStats[weapon] = stats
end

local function patchVAKWeapon(weapon, opts)
	trackWeaponStats(weapon)

	local fireDelay = FireDelay.Value / 100

	if opts.fireRate then
		if type(rawget(weapon, 'RoF')) == 'number' then
			rawset(weapon, 'RoF', fireDelay)
		end
		if type(rawget(weapon, 'Rate')) == 'number' then
			rawset(weapon, 'Rate', fireDelay)
		end
	end

	if opts.infiniteAmmo then
		local maxAmmo = rawget(weapon, 'MaxAmmo')
		if type(maxAmmo) == 'number' then
			rawset(weapon, 'Ammo', maxAmmo)
		end
		local maxCharge = rawget(weapon, 'MaxCharge')
		if type(maxCharge) == 'number' then
			rawset(weapon, 'Charge', maxCharge)
		end
	end

	if opts.instantReload then
		wrapVAKReload(weapon)
		wrapVAKMediRecharge(weapon)

		if type(rawget(weapon, 'ReloadTime')) == 'number' then
			rawset(weapon, 'ReloadTime', 0)
		end
		if type(rawget(weapon, 'Recharge')) == 'number' then
			rawset(weapon, 'Recharge', 0)
		end
		if rawget(weapon, 'Reloading') then
			rawset(weapon, 'Reloading', false)
		end
		if rawget(weapon, 'Recharging') then
			rawset(weapon, 'Recharging', false)
		end
		if rawget(weapon, 'Enabled') == false then
			rawset(weapon, 'Enabled', true)
		end
	end
end

local function patchLegacyGunEnv(env, opts)
	if type(env) ~= 'table' then
		return
	end

	if opts.infiniteAmmo then
		if rawget(env, 'u6') ~= nil then
			rawset(env, 'u6', true)
		end
		if type(rawget(env, 'u13')) == 'number' then
			rawset(env, 'u13', 35)
		end
	end

	if opts.instantReload then
		if rawget(env, 'u16') ~= nil then
			rawset(env, 'u16', false)
		end
		if type(rawget(env, 'u13')) == 'number' then
			rawset(env, 'u13', 35)
		end
		local u25 = rawget(env, 'u25')
		if type(u25) == 'table' then
			wrapLegacyReloadTable(u25)
		end
	end

	if opts.fireRate and rawget(env, 'u17') ~= nil then
		rawset(env, 'u17', true)
	end
end

local function getWeaponModOpts()
	return {
		infiniteAmmo = InfiniteAmmo and InfiniteAmmo.Enabled,
		fireRate = FireRate and FireRate.Enabled,
		instantReload = InstantReload and InstantReload.Enabled
	}
end

local function applyWeaponMods()
	local opts = getWeaponModOpts()
	if not (opts.infiniteAmmo or opts.fireRate or opts.instantReload) then
		return
	end

	for _, weapon in getActiveVAKWeapons() do
		patchVAKWeapon(weapon, opts)
	end

	for _, legacyEnv in getLegacyGunEnvs() do
		patchLegacyGunEnv(legacyEnv, opts)
	end
end

local function scheduleWeaponMods()
	hookVAKServices()
	applyWeaponMods()
	task.defer(function()
		hookVAKServices()
		applyWeaponMods()
	end)
	task.delay(0.05, function()
		hookVAKServices()
		applyWeaponMods()
	end)
	task.delay(0.2, function()
		hookVAKServices()
		applyWeaponMods()
	end)
end

local function resetVAKServiceHooks()
	vakServiceHooksInstalled = false
	connectorWeaponRef = nil
end

local function hookVAKServices()
	if vakServiceHooksInstalled then
		return
	end

	local vakUi = lplr.PlayerGui:FindFirstChild('VAK_UI')
	if not vakUi then
		return
	end

	local okTs, toolService = pcall(require, vakUi:WaitForChild('ToolService', 2))
	if okTs and type(toolService) == 'table' and not rawget(toolService, '__vapeHooked') then
		rawset(toolService, '__vapeHooked', true)

		local oldFiring = toolService.Firing
		toolService.Firing = function(weapon, ...)
			if anyWeaponModEnabled() and type(weapon) == 'table' and isVAKWeaponTable(weapon) then
				patchVAKWeapon(weapon, getWeaponModOpts())
				connectorWeaponRef = weapon
			end
			return oldFiring(weapon, ...)
		end

		local oldReload = toolService.Reload
		toolService.Reload = function(weapon, ...)
			if InstantReload and InstantReload.Enabled and type(weapon) == 'table' then
				local maxAmmo = rawget(weapon, 'MaxAmmo')
				if type(maxAmmo) == 'number' then
					rawset(weapon, 'Ammo', maxAmmo)
					rawset(weapon, 'Reloading', false)
					rawset(weapon, 'Enabled', true)
					return
				end
			end
			if anyWeaponModEnabled() and type(weapon) == 'table' then
				patchVAKWeapon(weapon, getWeaponModOpts())
			end
			return oldReload(weapon, ...)
		end
	end

	local okMs, mediService = pcall(require, vakUi:WaitForChild('MediService', 2))
	if okMs and type(mediService) == 'table' and not rawget(mediService, '__vapeHooked') then
		rawset(mediService, '__vapeHooked', true)

		local oldMediFire = mediService.MediFire
		mediService.MediFire = function(weapon, ...)
			if anyWeaponModEnabled() and type(weapon) == 'table' then
				patchVAKWeapon(weapon, getWeaponModOpts())
				connectorWeaponRef = weapon
			end
			return oldMediFire(weapon, ...)
		end

		local oldMediRecharge = mediService.MediRecharge
		mediService.MediRecharge = function(weapon, ...)
			if InstantReload and InstantReload.Enabled and type(weapon) == 'table' then
				local maxCharge = rawget(weapon, 'MaxCharge')
				if type(maxCharge) == 'number' then
					rawset(weapon, 'Charge', maxCharge)
				end
				rawset(weapon, 'Recharging', false)
				return
			end
			if anyWeaponModEnabled() and type(weapon) == 'table' then
				patchVAKWeapon(weapon, getWeaponModOpts())
			end
			return oldMediRecharge(weapon, ...)
		end
	end

	vakServiceHooksInstalled = true
end

local function anyWeaponModEnabled()
	return (InfiniteAmmo and InfiniteAmmo.Enabled)
		or (FireRate and FireRate.Enabled)
		or (InstantReload and InstantReload.Enabled)
end

local function stopWeaponHeartbeat()
	if weaponHeartbeat then
		weaponHeartbeat:Disconnect()
		weaponHeartbeat = nil
	end
end

local function startWeaponHeartbeat()
	if weaponHeartbeat then
		return
	end
	weaponHeartbeatAccum = 0
	weaponHeartbeat = runService.Heartbeat:Connect(function(dt)
		if not anyWeaponModEnabled() then
			stopWeaponHeartbeat()
			return
		end
		weaponHeartbeatAccum = weaponHeartbeatAccum + dt
		if weaponHeartbeatAccum >= WEAPON_HEARTBEAT_INTERVAL then
			weaponHeartbeatAccum = 0
			applyWeaponMods()
		end
	end)
end

local function syncWeaponMods()
	syncGunHooks()
	hookVAKServices()

	if not anyWeaponModEnabled() then
		stopWeaponHeartbeat()
		return
	end

	applyWeaponMods()
	startWeaponHeartbeat()
end

run(function()
	local function hookToolParent(parent)
		if not parent then
			return
		end
		vape:Clean(parent.ChildAdded:Connect(function(child)
			if child:IsA('Tool') and anyWeaponModEnabled() then
				scheduleWeaponMods()
			end
		end))
	end

	local function hookCharacter(char)
		hookToolParent(char)
	end

	if lplr.Character then
		hookCharacter(lplr.Character)
	end
	vape:Clean(lplr.CharacterAdded:Connect(function(char)
		connectorWeaponRef = nil
		hookCharacter(char)
		if anyWeaponModEnabled() then
			task.defer(scheduleWeaponMods)
		end
	end))
	vape:Clean(lplr.ChildAdded:Connect(function(child)
		if child.Name == 'Backpack' then
			hookToolParent(child)
		end
	end))
	if lplr:FindFirstChild('Backpack') then
		hookToolParent(lplr.Backpack)
	end

	vape:Clean(lplr.PlayerGui.ChildAdded:Connect(function(child)
		if child.Name == 'VAK_UI' then
			resetVAKServiceHooks()
			if anyWeaponModEnabled() then
				scheduleWeaponMods()
			end
		end
	end))
	if lplr.PlayerGui:FindFirstChild('VAK_UI') then
		hookVAKServices()
		if anyWeaponModEnabled() then
			scheduleWeaponMods()
		end
	end
end)

run(function()
	local oldTargetCheck = entitylib.targetCheck
	local oldGetEntityColor = entitylib.getEntityColor

	entitylib.targetCheck = function(ent)
		if ent.Health <= 0 then
			return false
		end
		if ent.NPC then
			return true
		end
		if ent.TeamCheck then
			return ent:TeamCheck()
		end
		if isFriend(ent.Player) then
			return false
		end
		if ent.Player and not select(2, whitelist:get(ent.Player)) then
			return false
		end

		if vape.Categories.Main.Options['Teams by torso color'].Enabled then
			return oldTargetCheck(ent)
		end

		if ent.Player and not canTargetPlayer(ent.Player) then
			return false
		end
		return true
	end

	entitylib.getEntityColor = function(ent)
		local plr = ent.Player
		if plr and isFriend(plr, true) then
			return Color3.fromHSV(vape.Categories.Friends.Options['Friends color'].Hue, vape.Categories.Friends.Options['Friends color'].Sat, vape.Categories.Friends.Options['Friends color'].Value)
		end
		if plr and vape.Categories.Main.Options['Use team color'].Enabled then
			local color = getFTPlayerTeamColor(plr)
			if color then
				return color
			end
		end
		return oldGetEntityColor(ent)
	end

	local oldGetUpdateConnections = entitylib.getUpdateConnections
	entitylib.getUpdateConnections = function(ent)
		local connections = oldGetUpdateConnections(ent)
		if ent.Player then
			table.insert(connections, ent.Player:GetPropertyChangedSignal('Team'))
			table.insert(connections, ent.Player:GetPropertyChangedSignal('TeamColor'))
		end
		return connections
	end
	entitylib.getupdatedconnections = entitylib.getUpdateConnections
end)

run(function()
	local currentGamemode = lightingService:WaitForChild('CurrentGamemode', 30)
	if currentGamemode then
		vape:Clean(currentGamemode:GetPropertyChangedSignal('Value'):Connect(function()
			entitylib.refresh()
			resetVAKServiceHooks()
			task.defer(scheduleWeaponMods)
		end))
	end

	vape:Clean(lplr:GetPropertyChangedSignal('Team'):Connect(function()
		entitylib.refresh()
	end))
	vape:Clean(lplr:GetPropertyChangedSignal('TeamColor'):Connect(function()
		entitylib.refresh()
	end))
end)

run(function()
	repeat
		task.wait()
	until vape.CheatDetector

	local spectateFolder = workspace:WaitForChild('SpectateFolder', 30)
	local ignorable = workspace:FindFirstChild('__Ignorable')
	local feIgnorable = workspace:FindFirstChild('FE_Ignorable', true)

	if spectateFolder then
		vape.CheatDetector.RegisterFilterExtra(spectateFolder)
	end
	if ignorable then
		vape.CheatDetector.RegisterFilterExtra(ignorable)
	end
	if feIgnorable then
		vape.CheatDetector.RegisterFilterExtra(feIgnorable)
	end

	local function isInLobby(plr)
		local team = plr and plr.Team
		return team and team:FindFirstChild('isLobby') ~= nil
	end

	local function isSpectating(ent, folder)
		if not folder or not ent.RootPart or not ent.Character then
			return false
		end
		return ent.RootPart:IsDescendantOf(folder) or ent.Character:IsDescendantOf(folder)
	end

	vape.CheatDetector.RegisterScan(function(ent, ctx)
		if not ent.Player or ctx.grace then
			return
		end

		if isInLobby(ent.Player) or isInLobby(lplr) then
			return
		end

		if isSpectating(ent, spectateFolder) then
			if ent.Health > 0 then
				ctx.Flag('spectate-exploit', 4)
			end
			return
		end

		local head = ent.Head
		local localFFA = select(1, getTeamFlags(lplr.Team))
		if head and head:FindFirstChild('FT_TeamESP') and head.FT_TeamESP.Enabled and ent.Player.Team == lplr.Team and not localFFA then
			ctx.Flag('team-esp-bypass', 10)
		end
	end)
end)

run(function()
	local function bindWeaponModule(mod)
		local oldFunc = mod.Function
		mod.Function = function(callback)
			if oldFunc then
				oldFunc(callback)
			end
			syncWeaponMods()
		end
	end

	InfiniteAmmo = minigames:CreateModule({
		Name = 'InfiniteAmmo',
		Function = function() end,
		Tooltip = 'Unlimited ammo for all equipped weapons (VAK, medi, legacy SMG).'
	})

	FireRate = minigames:CreateModule({
		Name = 'FireRate',
		Function = function() end,
		Tooltip = 'Lowers shot delay while your weapon is equipped.'
	})
	FireDelay = FireRate:CreateSlider({
		Name = 'Delay',
		Min = 1,
		Max = 100,
		Default = 10,
		Decimal = 100,
		Suffix = 's',
		Function = function()
			if FireRate.Enabled then
				syncWeaponMods()
			end
		end
	})

	InstantReload = minigames:CreateModule({
		Name = 'InstantReload',
		Function = function() end,
		Tooltip = 'Skips reload timers while equipped.'
	})

	for _, mod in {InfiniteAmmo, FireRate, InstantReload} do
		bindWeaponModule(mod)
	end
end)

return '5411969757'
