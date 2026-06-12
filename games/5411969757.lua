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

local function notif(...)
	return vape:CreateNotification(...)
end

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
local teamFFAFlag = nil
local gamemodeValue = nil
local weaponLoop

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
			return env
		end
	end
end

local function hasVAKUI()
	return lplr.PlayerGui:FindFirstChild('VAK_UI') ~= nil
end

local function getVAKGunEnv()
	if not hasVAKUI() or not getsenv then
		return
	end
	local vak = lplr.PlayerGui:FindFirstChild('VAK_UI')
	if not vak then
		return
	end
	for _, inst in vak:GetDescendants() do
		if inst:IsA('LocalScript') and (inst.Name == 'gunModule' or inst.Name:lower():find('gun')) then
			local ok, env = pcall(getsenv, inst)
			if ok and type(env) == 'table' then
				return env, inst
			end
		end
	end
end

local function patchNumericField(tbl, key, val)
	if type(tbl) == 'table' and type(tbl[key]) == 'number' then
		tbl[key] = val
		return true
	end
	return false
end

local function patchEnvNumbers(env, map)
	if type(env) ~= 'table' then
		return
	end
	for key, val in map do
		patchNumericField(env, key, val)
	end
	for _, v in env do
		if type(v) == 'table' then
			patchEnvNumbers(v, map)
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
			env.u13 = 35
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

	if opts.noSpread and env.u25 and type(env.u25.Fire) == 'function' and not env.u25.__vapeWrapped then
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

local function applyVAKGunMods(opts)
	local env = getVAKGunEnv()
	if not env then
		return
	end

	if opts.fireRate then
		patchEnvNumbers(env, {
			fireDelay = opts.fireRate,
			FireDelay = opts.fireRate,
			cooldown = opts.fireRate,
			Cooldown = opts.fireRate,
			shotDelay = opts.fireRate,
			ShotDelay = opts.fireRate
		})
	end

	if opts.noSpread then
		patchEnvNumbers(env, {
			spread = 0,
			Spread = 0,
			spreadMult = 0,
			SpreadMult = 0
		})
	end

	if opts.noRecoil then
		patchEnvNumbers(env, {
			recoil = 0,
			Recoil = 0,
			recoilMult = 0,
			RecoilMult = 0,
			kick = 0,
			Kick = 0,
			cameraKick = 0,
			CameraKick = 0
		})
	end

	if opts.instantReload then
		patchEnvNumbers(env, {
			reloadTime = 0,
			ReloadTime = 0,
			reload = 0,
			Reload = 0
		})
	end

	if opts.infiniteAmmo then
		patchEnvNumbers(env, {
			ammo = 999,
			Ammo = 999,
			currentAmmo = 999,
			CurrentAmmo = 999,
			clip = 999,
			Clip = 999,
			mag = 999,
			Mag = 999
		})
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

	if not (opts.infiniteAmmo or opts.fireRate or opts.noSpread or opts.noRecoil or opts.instantReload) then
		return
	end

	applyLegacyGunMods(opts)
	applyVAKGunMods(opts)
end

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
					task.wait(0.1)
				end
				weaponLoop = nil
			end)
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
			if callback then
				syncWeaponLoop()
			end
		end
	end

	InfiniteAmmo = minigames:CreateModule({
		Name = 'InfiniteAmmo',
		Function = function() end,
		Tooltip = 'Refills legacy SMG / VAK ammo client-side while equipped.'
	})

	TeamDamage = minigames:CreateModule({
		Name = 'TeamDamage',
		Function = function(callback)
			if callback then
				notif('TeamDamage', 'Disabled for this game anti-cheat.', 5, 'warning')
				TeamDamage:Toggle()
			end
		end,
		Tooltip = 'Not available on this game (anti-cheat).'
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
				applyWeaponMods()
			end
		end
	})

	NoSpread = minigames:CreateModule({
		Name = 'NoSpread',
		Function = function() end,
		Tooltip = 'Removes bullet spread while equipped.'
	})

	NoRecoil = minigames:CreateModule({
		Name = 'NoRecoil',
		Function = function() end,
		Tooltip = 'Removes recoil values while equipped.'
	})

	InstantReload = minigames:CreateModule({
		Name = 'InstantReload',
		Function = function() end,
		Tooltip = 'Skips reload timers while equipped.'
	})

	for _, mod in {InfiniteAmmo, FireRate, NoSpread, NoRecoil, InstantReload} do
		bindWeaponModule(mod)
	end

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
