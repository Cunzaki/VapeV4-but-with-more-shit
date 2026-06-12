local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local lightingService = cloneref(game:GetService('Lighting'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
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

local InfiniteAmmo, TeamDamage, FireRate, FireDelay, NoSpread, NoRecoil, InstantReload, AlwaysSprint, SprintSpeed
local serverVars = {infammo = false}
local teamFFAFlag = nil
local gamemodeValue = nil
local requirementInstalled = false

local function findServerVarsTable()
	if getgc then
		for _, v in getgc(true) do
			if type(v) == 'table' and rawget(v, 'infammo') ~= nil then
				return v
			end
		end
	end
	return serverVars
end

local function getIgnorable()
	local gameObjects = workspace:FindFirstChild('GameObjects')
	return (gameObjects and gameObjects:FindFirstChild('__Ignorable')) or workspace:FindFirstChild('__Ignorable')
end

local function requirementHandler(action, ...)
	local args = {...}

	if InfiniteAmmo and InfiniteAmmo.Enabled and action == 'getsvar' and args[1] == 'infammo' then
		return true
	end
	if TeamDamage and TeamDamage.Enabled and action == 'damage_check' then
		return true
	end

	if action == 'hitpart_check' then
		local part = args[1]
		if not part then
			return
		end
		local targetPlr = playersService:GetPlayerFromCharacter(part.Parent) or playersService:GetPlayerFromCharacter(part.Parent and part.Parent.Parent)
		local hum = part.Parent and part.Parent:FindFirstChild('Humanoid') or part.Parent and part.Parent.Parent and part.Parent.Parent:FindFirstChild('Humanoid')
		if targetPlr and hum then
			return {targetPlr, hum}
		end
	elseif action == 'damage_check' then
		local targetPlr = args[1]
		if not targetPlr then
			return
		end
		local mode = gamemodeValue
		if mode == 'ffa' and teamFFAFlag ~= nil then
			if lplr.TeamColor == targetPlr.TeamColor then
				return true
			end
		elseif lplr.TeamColor ~= targetPlr.TeamColor then
			return true
		end
	elseif action == 'get_ignorable' then
		local spectateFolder = workspace:FindFirstChild('SpectateFolder')
		return {
			lplr.Character,
			getIgnorable(),
			workspace:FindFirstChild('FE_Ignorable', true),
			spectateFolder
		}
	elseif action == 'getsvar' then
		local vars = findServerVarsTable()
		return vars[args[1]]
	end
end

local function installRequirementHandler()
	local req = lplr:FindFirstChild('Requirement')
	if not req or not req:IsA('BindableFunction') then
		return
	end
	req.OnInvoke = requirementHandler
	requirementInstalled = true
end

local function getLegacyGunScript()
	local function scan(parent)
		if not parent then
			return
		end
		for _, tool in parent:GetChildren() do
			if tool:IsA('Tool') then
				local gun = tool:FindFirstChild('Gun')
				if gun and gun:IsA('LocalScript') then
					return gun
				end
			end
		end
	end
	return scan(lplr.Character) or scan(lplr:FindFirstChild('Backpack'))
end

local function getLegacyGunEnv()
	local gun = getLegacyGunScript()
	if gun and getsenv then
		local ok, env = pcall(getsenv, gun)
		if ok and type(env) == 'table' then
			return env, gun
		end
	end
end

local function hasVAKUI()
	return lplr.PlayerGui:FindFirstChild('VAK_UI') ~= nil
end

local WEAPON_KEYS = {
	FireRate = 'fireRate', fireRate = 'fireRate', RPM = 'fireRate', rpm = 'fireRate',
	FireDelay = 'fireRate', fireDelay = 'fireRate', Cooldown = 'fireRate', cooldown = 'fireRate',
	ShotDelay = 'fireRate', shotDelay = 'fireRate', Rate = 'fireRate',
	Recoil = 'recoil', recoil = 'recoil', RecoilMult = 'recoil', recoilMult = 'recoil',
	Kick = 'recoil', kick = 'recoil', CameraKick = 'recoil',
	Spread = 'spread', spread = 'spread', SpreadMult = 'spread', spreadMult = 'spread',
	ReloadTime = 'reload', Reload = 'reload', reloadTime = 'reload', reload = 'reload',
	Ammo = 'ammo', ammo = 'ammo', CurrentAmmo = 'ammo', currentAmmo = 'ammo',
	Clip = 'ammo', clip = 'ammo', MaxAmmo = 'maxAmmo', maxAmmo = 'maxAmmo', Mag = 'ammo'
}

local function patchWeaponTable(tbl, seen, opts)
	if type(tbl) ~= 'table' or seen[tbl] then
		return
	end
	seen[tbl] = true

	local matches = 0
	for key in WEAPON_KEYS do
		if tbl[key] ~= nil then
			matches += 1
		end
	end

	if matches >= 2 then
		for key, kind in WEAPON_KEYS do
			local val = tbl[key]
			if type(val) == 'number' then
				if kind == 'fireRate' and opts.fireRate then
					local lk = key:lower()
					if lk:find('rpm') or (lk:find('rate') and not lk:find('delay')) then
						tbl[key] = math.max(val, math.floor(1 / opts.fireRate))
					else
						tbl[key] = opts.fireRate
					end
				elseif kind == 'recoil' and opts.noRecoil then
					tbl[key] = 0
				elseif kind == 'spread' and opts.noSpread then
					tbl[key] = 0
				elseif kind == 'reload' and opts.instantReload then
					tbl[key] = 0
				elseif kind == 'ammo' and opts.infiniteAmmo then
					tbl[key] = math.max(val, 999)
				elseif kind == 'maxAmmo' and opts.infiniteAmmo then
					tbl[key] = math.max(val, 999)
				end
			end
		end
	end

	for _, v in tbl do
		if type(v) == 'table' then
			patchWeaponTable(v, seen, opts)
		end
	end
end

local function patchVAKWeaponTables(opts)
	if not hasVAKUI() or not getgc then
		return
	end

	local seen = {}
	for _, v in getgc(true) do
		if type(v) == 'table' then
			patchWeaponTable(v, seen, opts)
		end
	end
end

local function applyLegacyGunMods(opts)
	local env = getLegacyGunEnv()
	if not env then
		return
	end

	if opts.infiniteAmmo then
		if env.u6 ~= nil then
			env.u6 = true
		end
		if type(env.u13) == 'number' then
			env.u13 = math.max(env.u13, 35)
		end
	end

	if opts.instantReload then
		if env.u16 ~= nil then
			env.u16 = false
		end
		if type(env.u13) == 'number' then
			env.u13 = 35
		end
	end

	if opts.fireRate and env.u17 == false and env.u15 then
		env.u17 = true
	end

	if opts.noSpread and env.u25 and type(env.u25.Fire) == 'function' then
		if not env.u25.__vapeWrapped then
			local oldFire = env.u25.Fire
			env.u25.Fire = function(target, clickState)
				if not (NoSpread and NoSpread.Enabled) then
					return oldFire(target, clickState)
				end
				local oldRandom = math.random
				math.random = function(a, b)
					if a and b and typeof(a) == 'number' and typeof(b) == 'number' and a < 0 and b > 0 then
						return 0
					end
					return oldRandom(a, b)
				end
				local ok, res = pcall(oldFire, target, clickState)
				math.random = oldRandom
				if not ok then
					error(res)
				end
				return res
			end
			env.u25.__vapeWrapped = true
		end
	end
end

local function applyWeaponMods()
	local opts = {
		infiniteAmmo = InfiniteAmmo and InfiniteAmmo.Enabled,
		fireRate = FireRate and FireRate.Enabled and (FireDelay.Value / 100) or nil,
		noSpread = NoSpread and NoSpread.Enabled,
		noRecoil = NoRecoil and NoRecoil.Enabled,
		instantReload = InstantReload and InstantReload.Enabled
	}

	if (InfiniteAmmo and InfiniteAmmo.Enabled) or (TeamDamage and TeamDamage.Enabled) then
		installRequirementHandler()
	end

	if opts.infiniteAmmo then
		local vars = findServerVarsTable()
		vars.infammo = true
	end

	applyLegacyGunMods(opts)
	patchVAKWeaponTables(opts)

	if opts.noRecoil then
		local cam = workspace.CurrentCamera
		if cam then
			for _, v in cam:GetChildren() do
				if v.Name:find('Blur') or v.Name:find('Color') or v.Name:find('Recoil') then
					v:Destroy()
				end
			end
		end
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
		gamemodeValue = currentGamemode.Value
		vape:Clean(currentGamemode:GetPropertyChangedSignal('Value'):Connect(function()
			gamemodeValue = currentGamemode.Value
			entitylib.refresh()
		end))
	end

	vape:Clean(lplr:GetPropertyChangedSignal('Team'):Connect(function()
		teamFFAFlag = lplr.Team and lplr.Team:FindFirstChild('isFFA') or nil
		entitylib.refresh()
	end))
	if lplr.Team then
		teamFFAFlag = lplr.Team:FindFirstChild('isFFA')
	end

	local requestRemote = replicatedStorage:WaitForChild('FTPStorage', 30)
	requestRemote = requestRemote and requestRemote:WaitForChild('Remotes', 30)
	requestRemote = requestRemote and requestRemote:WaitForChild('Request', 30)
	if requestRemote then
		vape:Clean(requestRemote.OnClientEvent:Connect(function(key, val)
			if key == 'infammo' and (val == true or val == false) then
				serverVars.infammo = val
			end
		end))
		pcall(function()
			requestRemote:FireServer('getvars')
		end)
	end

	local function onRequirement()
		installRequirementHandler()
	end

	vape:Clean(lplr.ChildAdded:Connect(function(child)
		if child.Name == 'Requirement' then
			task.defer(onRequirement)
		end
	end))
	if lplr:FindFirstChild('Requirement') then
		onRequirement()
	else
		task.spawn(function()
			lplr:WaitForChild('Requirement', 30)
			onRequirement()
		end)
	end
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
	local weaponLoop

	local function anyWeaponModEnabled()
		return (InfiniteAmmo and InfiniteAmmo.Enabled)
			or (FireRate and FireRate.Enabled)
			or (NoSpread and NoSpread.Enabled)
			or (NoRecoil and NoRecoil.Enabled)
			or (InstantReload and InstantReload.Enabled)
	end

	local function syncWeaponLoop()
		if anyWeaponModEnabled() then
			if not weaponLoop then
				weaponLoop = task.spawn(function()
					while anyWeaponModEnabled() do
						applyWeaponMods()
						task.wait()
					end
					weaponLoop = nil
				end)
			end
		end
	end

	local function refreshRequirement()
		installRequirementHandler()
	end

	local function bindWeaponModule(mod, extra)
		local oldFunc = mod.Function
		mod.Function = function(callback)
			if extra then
				extra(callback)
			end
			if oldFunc then
				oldFunc(callback)
			end
			if callback then
				syncWeaponLoop()
			else
				applyWeaponMods()
			end
		end
	end

	InfiniteAmmo = minigames:CreateModule({
		Name = 'InfiniteAmmo',
		Function = function() end,
		Tooltip = 'Never run out of ammo (legacy SMG + VAK).'
	})

	TeamDamage = minigames:CreateModule({
		Name = 'TeamDamage',
		Function = function() end,
		Tooltip = 'Allows damaging teammates in team gamemodes.'
	})

	FireRate = minigames:CreateModule({
		Name = 'FireRate',
		Function = function() end,
		Tooltip = 'Increases fire rate for SMG and VAK weapons.'
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
				applyWeaponMods()
			end
		end
	})

	NoSpread = minigames:CreateModule({
		Name = 'NoSpread',
		Function = function() end,
		Tooltip = 'Removes bullet spread.'
	})

	NoRecoil = minigames:CreateModule({
		Name = 'NoRecoil',
		Function = function() end,
		Tooltip = 'Removes gun recoil and camera shake.'
	})

	InstantReload = minigames:CreateModule({
		Name = 'InstantReload',
		Function = function() end,
		Tooltip = 'Instantly finishes reloads.'
	})

	bindWeaponModule(InfiniteAmmo, refreshRequirement)
	bindWeaponModule(TeamDamage, refreshRequirement)
	bindWeaponModule(FireRate)
	bindWeaponModule(NoSpread)
	bindWeaponModule(NoRecoil)
	bindWeaponModule(InstantReload)

	AlwaysSprint = minigames:CreateModule({
		Name = 'AlwaysSprint',
		Function = function(callback)
			if callback then
				AlwaysSprint:Clean(runService.Heartbeat:Connect(function()
					local char = lplr.Character
					local hum = char and char:FindFirstChildOfClass('Humanoid')
					if not hum or hum.Health <= 0 then
						return
					end
					if getLegacyGunScript() or hasVAKUI() then
						local holster = char:FindFirstChild('armToggle')
						if not holster or not holster.Value then
							hum.WalkSpeed = SprintSpeed.Value
						end
					end
				end))
			end
		end,
		Tooltip = 'Keeps sprint speed while using weapons.'
	})
	SprintSpeed = AlwaysSprint:CreateSlider({
		Name = 'Speed',
		Min = 16,
		Max = 32,
		Default = 22
	})
end)

return '5411969757'
