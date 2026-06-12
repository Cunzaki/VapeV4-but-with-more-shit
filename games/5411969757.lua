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
local weaponLoop
local gunHooks = {wait = nil, taskWait = nil}
local gunHookState = {fireDelay = nil, instantReload = false}
local cachedWeaponTables = {}
local weaponTablesScanned = false

local GUN_SCRIPT_NAMES = {
	Gun = true,
	gunModule = true,
	ToolService = true
}

local function isGunCallingScript(calling)
	if not calling then
		return false
	end
	if GUN_SCRIPT_NAMES[calling.Name] then
		return true
	end

	local lower = calling.Name:lower()
	if lower:find('gun') or lower:find('tool') or lower:find('wolfram') then
		return true
	end

	local parent = calling
	while parent do
		if parent.Name == 'VAK_UI' then
			return true
		end
		if parent:IsA('Tool') and parent:FindFirstChild('Gun') then
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

	if gunHookState.fireDelay and (delayTime == 0.09 or (delayTime >= 0.05 and delayTime <= 0.12)) then
		return gunHookState.fireDelay
	end
	if gunHookState.instantReload and delayTime >= 0.13 then
		return 0
	end
	return delayTime
end

local function syncGunHooks()
	if not hookfunction then
		return
	end

	gunHookState.fireDelay = FireRate and FireRate.Enabled and (FireDelay.Value / 100) or nil
	gunHookState.instantReload = InstantReload and InstantReload.Enabled or false

	local active = gunHookState.fireDelay or gunHookState.instantReload
	if not active then
		if gunHooks.wait and restorefunction then
			pcall(restorefunction, wait)
			gunHooks.wait = nil
		end
		if gunHooks.taskWait and restorefunction and task.wait ~= wait then
			pcall(restorefunction, task.wait)
			gunHooks.taskWait = nil
		end
		return
	end

	if not gunHooks.wait then
		local oldWait = wait
		gunHooks.wait = hookfunction(wait, function(delayTime, ...)
			if isGunCallingScript(getcallingscript and getcallingscript()) then
				delayTime = adjustGunWait(delayTime)
			end
			return oldWait(delayTime, ...)
		end)
	end

	if not gunHooks.taskWait then
		local oldTaskWait = task.wait
		gunHooks.taskWait = hookfunction(task.wait, function(delayTime, ...)
			if isGunCallingScript(getcallingscript and getcallingscript()) then
				delayTime = adjustGunWait(delayTime)
			end
			return oldTaskWait(delayTime, ...)
		end)
	end
end

local function collectGunScripts()
	local scripts = {}

	local function add(script)
		if script and script:IsA('LocalScript') then
			scripts[script] = true
		end
	end

	local function scanTools(parent)
		if not parent then
			return
		end
		for _, tool in parent:GetChildren() do
			if tool:IsA('Tool') then
				add(tool:FindFirstChild('Gun'))
			end
		end
	end

	scanTools(lplr.Character)
	scanTools(lplr:FindFirstChild('Backpack'))

	local vak = lplr.PlayerGui:FindFirstChild('VAK_UI')
	if vak then
		for _, inst in vak:GetDescendants() do
			if inst:IsA('LocalScript') then
				add(inst)
			end
		end
	end

	return scripts
end

local function looksLikeWeaponTable(tbl)
	if type(tbl) ~= 'table' then
		return false
	end

	if type(tbl.Mag) == 'number' or type(tbl.HealMag) == 'number' then
		return true
	end
	if tbl.u6 ~= nil and type(tbl.u13) == 'number' then
		return true
	end
	if tbl.u25 and type(tbl.u25.Fire) == 'function' and type(tbl.u25.Reload) == 'function' then
		return true
	end

	local matches = 0
	for key, val in tbl do
		if type(key) == 'string' and type(val) == 'number' then
			local lk = key:lower()
			if lk == 'ammo' or lk == 'mag' or lk == 'clip' or lk == 'currentammo' then
				matches += 1
			end
		end
	end
	return matches >= 2
end

local function scanWeaponTables()
	if weaponTablesScanned or not getgc then
		return
	end
	weaponTablesScanned = true

	local seen = {}
	for _, value in getgc(true) do
		if type(value) == 'table' and not seen[value] and looksLikeWeaponTable(value) then
			seen[value] = true
			table.insert(cachedWeaponTables, value)
		end
	end
end

local function patchNumericFields(tbl, map, depth)
	if type(tbl) ~= 'table' or depth > 2 then
		return
	end

	for key, val in map do
		if type(tbl[key]) == 'number' then
			tbl[key] = val
		end
	end

	for _, child in tbl do
		if type(child) == 'table' then
			patchNumericFields(child, map, depth + 1)
		end
	end
end

local function wrapReloadTable(tbl)
	if type(tbl) ~= 'table' or type(tbl.Reload) ~= 'function' or tbl.__vapeReload then
		return
	end

	local oldReload = tbl.Reload
	tbl.Reload = function(...)
		if InstantReload and InstantReload.Enabled then
			if type(tbl.Mag) == 'number' then
				tbl.Mag = 999999
			end
			if type(tbl.HealMag) == 'number' then
				tbl.HealMag = 999999
			end
			return
		end
		return oldReload(...)
	end
	tbl.__vapeReload = true
end

local function patchGunEnv(env, opts)
	if type(env) ~= 'table' then
		return
	end

	if opts.infiniteAmmo then
		if env.u6 ~= nil then
			env.u6 = true
		end
		if type(env.u13) == 'number' then
			env.u13 = 35
		end
		if type(env.Mag) == 'number' then
			env.Mag = 999999
		end
		if type(env.HealMag) == 'number' then
			env.HealMag = 999999
		end

		patchNumericFields(env, {
			ammo = 999999,
			Ammo = 999999,
			currentAmmo = 999999,
			CurrentAmmo = 999999,
			clip = 999999,
			Clip = 999999,
			mag = 999999,
			Mag = 999999
		}, 0)
	end

	if opts.instantReload then
		if env.u16 ~= nil then
			env.u16 = false
		end
		if type(env.u13) == 'number' then
			env.u13 = 35
		end
		if env.u25 then
			wrapReloadTable(env.u25)
		end
	end

	if opts.fireRate and env.u17 ~= nil then
		env.u17 = true
	end
end

local function patchWeaponTable(tbl, opts)
	if opts.infiniteAmmo then
		if tbl.u6 ~= nil then
			tbl.u6 = true
		end
		if type(tbl.u13) == 'number' then
			tbl.u13 = 35
		end
		if type(tbl.Mag) == 'number' then
			tbl.Mag = 999999
		end
		if type(tbl.HealMag) == 'number' then
			tbl.HealMag = 999999
		end
		patchNumericFields(tbl, {
			ammo = 999999,
			Ammo = 999999,
			currentAmmo = 999999,
			CurrentAmmo = 999999,
			clip = 999999,
			Clip = 999999,
			mag = 999999,
			Mag = 999999
		}, 0)
	end

	if opts.instantReload then
		if tbl.u16 ~= nil then
			tbl.u16 = false
		end
		if type(tbl.u13) == 'number' then
			tbl.u13 = 35
		end
		if tbl.u25 then
			wrapReloadTable(tbl.u25)
		end
		wrapReloadTable(tbl)
	end

	if opts.fireRate and tbl.u17 ~= nil then
		tbl.u17 = true
	end
end

local function applyWeaponMods()
	local opts = {
		infiniteAmmo = InfiniteAmmo and InfiniteAmmo.Enabled,
		fireRate = FireRate and FireRate.Enabled,
		instantReload = InstantReload and InstantReload.Enabled
	}

	if not (opts.infiniteAmmo or opts.fireRate or opts.instantReload) then
		return
	end

	if opts.infiniteAmmo or opts.instantReload then
		scanWeaponTables()
	end

	if getsenv then
		for gunScript in collectGunScripts() do
			local ok, env = pcall(getsenv, gunScript)
			if ok then
				patchGunEnv(env, opts)
			end
		end
	end

	for _, tbl in cachedWeaponTables do
		patchWeaponTable(tbl, opts)
	end
end

local function anyWeaponModEnabled()
	return (InfiniteAmmo and InfiniteAmmo.Enabled)
		or (FireRate and FireRate.Enabled)
		or (InstantReload and InstantReload.Enabled)
end

local function syncWeaponMods()
	syncGunHooks()

	if not anyWeaponModEnabled() then
		cachedWeaponTables = {}
		weaponTablesScanned = false
		return
	end

	applyWeaponMods()

	if not weaponLoop then
		weaponLoop = task.spawn(function()
			while anyWeaponModEnabled() do
				applyWeaponMods()
				task.wait(0.1)
			end
			weaponLoop = nil
		end)
	end
end

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
		Max = 90,
		Default = 9,
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
