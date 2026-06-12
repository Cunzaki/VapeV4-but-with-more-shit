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
	if not lplr.Team or not plr.Team then
		return true
	end

	local localFFA, localLobby = getTeamFlags(lplr.Team)
	local _, targetLobby = getTeamFlags(plr.Team)

	if localLobby or targetLobby then
		return true
	end
	if localFFA then
		return true
	end
	return plr.Team ~= lplr.Team
end

local InfiniteAmmo, FireRate, FireDelay, InstantReload
local weaponHeartbeat
local weaponHeartbeatAccum = 0
local WEAPON_HEARTBEAT_INTERVAL = 0.15
local gunHookOriginals = {wait = nil, taskWait = nil}
local gunHookState = {fireDelay = nil, instantReload = false}
local wrappedLegacyReloads = setmetatable({}, {__mode = 'k'})
local wrappedVAKReloads = setmetatable({}, {__mode = 'k'})

local function isVAKWeaponTable(weapon)
	if type(weapon) ~= 'table' or rawget(weapon, 'Name') == nil then
		return false
	end
	if type(rawget(weapon, 'RoF')) == 'number' and type(rawget(weapon, 'Ammo')) == 'number' then
		return true
	end
	if type(rawget(weapon, 'Rate')) == 'number' and type(rawget(weapon, 'Charge')) == 'number' then
		return true
	end
	return false
end

local function getVAKWeaponKind(weapon)
	if type(rawget(weapon, 'RoF')) == 'number' and type(rawget(weapon, 'Ammo')) == 'number' then
		return 'tool'
	end
	if type(rawget(weapon, 'Rate')) == 'number' and type(rawget(weapon, 'Charge')) == 'number' then
		return 'medi'
	end
end

local function tryWeaponFromTool(tool)
	if not tool or not tool:IsA('Tool') then
		return
	end
	local client = tool:FindFirstChild('Client')
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

local function getEquippedVAKWeapons()
	local equipped = {}
	for _, weapon in getVAKWeapons() do
		if rawget(weapon, 'Out') == true then
			table.insert(equipped, weapon)
		end
	end
	return equipped
end

local function getLegacyGunScript()
	for _, parent in {lplr.Character, lplr:FindFirstChild('Backpack')} do
		if parent then
			for _, tool in parent:GetChildren() do
				if tool:IsA('Tool') then
					local gun = tool:FindFirstChild('Gun')
					if gun and gun:IsA('LocalScript') then
						return gun
					end
				end
			end
		end
	end
end

local function getLegacyGunEnv()
	local gun = getLegacyGunScript()
	if gun and getsenv then
		local ok, env = pcall(getsenv, gun)
		if ok and type(env) == 'table' then
			return env
		end
	end
end

local function isGunWaitScript(calling)
	if not calling then
		return false
	end
	if calling.Name == 'Gun' or calling.Name == 'ToolService' or calling.Name == 'MediService' then
		return true
	end
	local parent = calling
	while parent do
		if parent.Name == 'VAK_UI' then
			return true
		end
		parent = parent.Parent
	end
	return false
end

local function adjustGunWait(delayTime)
	if type(delayTime) ~= 'number' then
		return delayTime
	end

	if gunHookState.fireDelay and (delayTime == 0.09 or delayTime == 0.1 or (delayTime >= 0.07 and delayTime <= 0.12)) then
		return gunHookState.fireDelay
	end

	if gunHookState.instantReload then
		if delayTime == 0.4 or delayTime == 0.18 or delayTime == 0.13 or delayTime == 0.04 then
			return 0
		end
		local calling = getcallingscript and getcallingscript()
		if calling and calling.Name == 'Gun' and delayTime >= 0.03 and delayTime <= 3.5 then
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

local function patchVAKWeapon(weapon, opts)
	local kind = getVAKWeaponKind(weapon)
	if kind == 'tool' then
		if opts.fireRate then
			rawset(weapon, 'RoF', FireDelay.Value / 100)
		end
		if opts.infiniteAmmo then
			local maxAmmo = rawget(weapon, 'MaxAmmo')
			if type(maxAmmo) == 'number' then
				rawset(weapon, 'Ammo', maxAmmo)
			end
		end
		if opts.instantReload then
			wrapVAKReload(weapon)
			if rawget(weapon, 'Reloading') then
				rawset(weapon, 'Reloading', false)
			end
			if rawget(weapon, 'Enabled') == false then
				rawset(weapon, 'Enabled', true)
			end
		end
	elseif kind == 'medi' then
		if opts.fireRate then
			rawset(weapon, 'Rate', FireDelay.Value / 100)
		end
		if opts.infiniteAmmo or opts.instantReload then
			local maxCharge = rawget(weapon, 'MaxCharge')
			if type(maxCharge) == 'number' then
				rawset(weapon, 'Charge', maxCharge)
			end
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

	for _, weapon in getEquippedVAKWeapons() do
		patchVAKWeapon(weapon, opts)
	end

	local legacyEnv = getLegacyGunEnv()
	if legacyEnv then
		patchLegacyGunEnv(legacyEnv, opts)
	end
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

	if not anyWeaponModEnabled() then
		stopWeaponHeartbeat()
		return
	end

	applyWeaponMods()
	startWeaponHeartbeat()
end

run(function()
	local function hookCharacter(char)
		vape:Clean(char.ChildAdded:Connect(function(child)
			if child:IsA('Tool') and anyWeaponModEnabled() then
				applyWeaponMods()
			end
		end))
	end

	if lplr.Character then
		hookCharacter(lplr.Character)
	end
	vape:Clean(lplr.CharacterAdded:Connect(hookCharacter))

	vape:Clean(lplr.PlayerGui.ChildAdded:Connect(function(child)
		if child.Name == 'VAK_UI' and anyWeaponModEnabled() then
			task.defer(applyWeaponMods)
		end
	end))
end)

run(function()
	local oldTargetCheck = entitylib.targetCheck
	entitylib.targetCheck = function(ent)
		if not oldTargetCheck(ent) then
			return false
		end
		if ent.Player and not canTargetPlayer(ent.Player) then
			return false
		end
		return true
	end

	local oldGetUpdateConnections = entitylib.getUpdateConnections
	entitylib.getUpdateConnections = function(ent)
		local connections = oldGetUpdateConnections(ent)
		if ent.Player then
			table.insert(connections, ent.Player:GetPropertyChangedSignal('Team'))
		end
		return connections
	end
	entitylib.getupdatedconnections = entitylib.getUpdateConnections

	entitylib.getEntityColor = function(ent)
		ent = ent.Player
		if not ent then return end
		if isFriend(ent, true) then
			return Color3.fromHSV(vape.Categories.Friends.Options['Friends color'].Hue, vape.Categories.Friends.Options['Friends color'].Sat, vape.Categories.Friends.Options['Friends color'].Value)
		end
		if vape.Categories.Main.Options['Use team color'].Enabled then
			return ent.TeamColor.Color
		end
		return nil
	end
end)

run(function()
	local currentGamemode = lightingService:WaitForChild('CurrentGamemode', 30)
	if currentGamemode then
		vape:Clean(currentGamemode:GetPropertyChangedSignal('Value'):Connect(function()
			entitylib.refresh()
		end))
	end

	vape:Clean(lplr:GetPropertyChangedSignal('Team'):Connect(function()
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
		Tooltip = 'Unlimited ammo for SMG and VAK weapons.'
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
