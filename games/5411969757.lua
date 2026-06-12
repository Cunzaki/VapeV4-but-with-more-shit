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
local gunHookOriginals = {wait = nil, taskWait = nil}
local gunHookState = {fireDelay = nil, instantReload = false}
local wrappedReloads = setmetatable({}, {__mode = 'k'})

local GUN_WAIT_SCRIPT_NAMES = {
	Gun = true,
	gunModule = true,
	ToolService = true
}

local function isGunWaitScript(calling)
	return calling and GUN_WAIT_SCRIPT_NAMES[calling.Name] or false
end

local function adjustGunWait(delayTime)
	if type(delayTime) ~= 'number' then
		return delayTime
	end

	if gunHookState.fireDelay and (delayTime == 0.09 or (delayTime >= 0.07 and delayTime <= 0.12)) then
		return gunHookState.fireDelay
	end

	if gunHookState.instantReload then
		if delayTime == 0.4 or delayTime == 0.18 or delayTime == 0.13 then
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

local function collectGunScripts()
	local scripts = {}

	local function add(script)
		if script and script:IsA('LocalScript') then
			scripts[#scripts + 1] = script
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
		for _, name in {'gunModule', 'ToolService'} do
			local script = vak:FindFirstChild(name, true)
			if script and script:IsA('LocalScript') then
				add(script)
			end
		end
	end

	return scripts
end

local function wrapReloadTable(tbl)
	if type(tbl) ~= 'table' or wrappedReloads[tbl] then
		return
	end

	local oldReload = rawget(tbl, 'Reload')
	if type(oldReload) ~= 'function' then
		return
	end

	wrappedReloads[tbl] = true
	rawset(tbl, 'Reload', function(...)
		if InstantReload and InstantReload.Enabled then
			local mag = rawget(tbl, 'Mag')
			if type(mag) == 'number' then
				rawset(tbl, 'Mag', 999999)
			end
			local healMag = rawget(tbl, 'HealMag')
			if type(healMag) == 'number' then
				rawset(tbl, 'HealMag', 999999)
			end
			return
		end
		return oldReload(...)
	end)
end

local function patchFunctionUpvalues(fn, opts, depth)
	if type(fn) ~= 'function' or depth > 3 or not debug or not debug.getupvalue then
		return
	end

	for i = 1, 60 do
		local ok, name, val = pcall(debug.getupvalue, fn, i)
		if not ok or name == nil or name == '' then
			break
		end

		if opts.infiniteAmmo then
			if name == 'u6' then
				pcall(debug.setupvalue, fn, i, true)
			elseif name == 'u13' and type(val) == 'number' then
				pcall(debug.setupvalue, fn, i, 35)
			elseif (name == 'Mag' or name == 'HealMag') and type(val) == 'number' then
				pcall(debug.setupvalue, fn, i, 999999)
			end
		end

		if opts.instantReload then
			if name == 'u16' then
				pcall(debug.setupvalue, fn, i, false)
			elseif name == 'u13' and type(val) == 'number' then
				pcall(debug.setupvalue, fn, i, 35)
			end
		end

		if opts.fireRate and name == 'u17' then
			pcall(debug.setupvalue, fn, i, true)
		end

		if type(val) == 'function' then
			patchFunctionUpvalues(val, opts, depth + 1)
		elseif type(val) == 'table' then
			if opts.instantReload then
				wrapReloadTable(val)
			end
		end
	end
end

local function patchGunEnv(env, opts)
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
		if type(rawget(env, 'Mag')) == 'number' then
			rawset(env, 'Mag', 999999)
		end
		if type(rawget(env, 'HealMag')) == 'number' then
			rawset(env, 'HealMag', 999999)
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
			wrapReloadTable(u25)
		end
	end

	if opts.fireRate and rawget(env, 'u17') ~= nil then
		rawset(env, 'u17', true)
	end

	for _, key in {'u50', 'u25', 'u24', 'u22'} do
		local val = rawget(env, key)
		if type(val) == 'function' then
			patchFunctionUpvalues(val, opts, 0)
		elseif type(val) == 'table' then
			for _, subKey in {'MouseClick', 'Reload', 'Fire', 'KeyPressed'} do
				local subVal = rawget(val, subKey)
				if type(subVal) == 'function' then
					patchFunctionUpvalues(subVal, opts, 0)
				end
			end
		end
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

	if not getsenv then
		return
	end

	for _, gunScript in collectGunScripts() do
		local ok, env = pcall(getsenv, gunScript)
		if ok then
			patchGunEnv(env, opts)
		end
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
		return
	end

	applyWeaponMods()

	if not weaponLoop then
		weaponLoop = task.spawn(function()
			while anyWeaponModEnabled() do
				applyWeaponMods()
				task.wait(0.25)
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
