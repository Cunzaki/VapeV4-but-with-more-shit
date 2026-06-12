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

local function getEquippedGunScript()
	local function scan(parent)
		if not parent then return end
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

local requirementHook = {old = nil, req = nil}
local function updateRequirementHook(infiniteAmmo, teamDamage)
	local req = lplr:FindFirstChild('Requirement')
	if not req then
		return
	end

	if not infiniteAmmo and not teamDamage then
		if requirementHook.req == req and requirementHook.old then
			req.OnInvoke = requirementHook.old
			requirementHook.old = nil
			requirementHook.req = nil
		end
		return
	end

	if requirementHook.req ~= req or not requirementHook.old then
		requirementHook.old = req.OnInvoke
		requirementHook.req = req
	end

	req.OnInvoke = function(action, ...)
		if infiniteAmmo and action == 'getsvar' and (...) == 'infammo' then
			return true
		end
		if teamDamage and action == 'damage_check' then
			return true
		end
		return requirementHook.old(action, ...)
	end
end

local gunHooks = {wait = nil, random = nil}
local gunHookState = {fireDelay = nil, noSpread = false, instantReload = false}
local FireRate, FireDelay, NoSpread, InstantReload

local function syncGunHooks()
	if not hookfunction then
		return
	end

	gunHookState.fireDelay = FireRate and FireRate.Enabled and (FireDelay.Value / 100) or nil
	gunHookState.noSpread = NoSpread and NoSpread.Enabled or false
	gunHookState.instantReload = InstantReload and InstantReload.Enabled or false

	local active = gunHookState.fireDelay or gunHookState.noSpread or gunHookState.instantReload
	if not active then
		if gunHooks.wait and restorefunction then
			pcall(restorefunction, wait)
			gunHooks.wait = nil
		end
		if gunHooks.random and restorefunction then
			pcall(restorefunction, math.random)
			gunHooks.random = nil
		end
		return
	end

	if not gunHooks.wait then
		local oldWait = wait
		gunHooks.wait = hookfunction(wait, function(delayTime)
			local calling = getcallingscript and getcallingscript()
			if calling and calling.Name == 'Gun' then
				if gunHookState.fireDelay and delayTime == 0.09 then
					delayTime = gunHookState.fireDelay
				elseif gunHookState.instantReload and delayTime > 0.09 then
					delayTime = 0
				end
			end
			return oldWait(delayTime)
		end)
	end

	if gunHookState.noSpread and not gunHooks.random then
		local oldRandom = math.random
		gunHooks.random = hookfunction(math.random, function(a, b)
			local calling = getcallingscript and getcallingscript()
			if calling and calling.Name == 'Gun' and a and b and typeof(a) == 'number' and typeof(b) == 'number' and a < 0 and b > 0 then
				return 0
			end
			return oldRandom(a, b)
		end)
	elseif not gunHookState.noSpread and gunHooks.random then
		if restorefunction then
			pcall(restorefunction, math.random)
		end
		gunHooks.random = nil
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
	local currentGamemode = lightingService:WaitForChild('CurrentGamemode', 30)
	if not currentGamemode then
		return
	end

	vape:Clean(currentGamemode:GetPropertyChangedSignal('Value'):Connect(function()
		entitylib.refresh()
	end))
	vape:Clean(lplr:GetPropertyChangedSignal('Team'):Connect(function()
		entitylib.refresh()
	end))
end)

run(function()
	local InfiniteAmmo
	local TeamDamage
	local AlwaysSprint
	local SprintSpeed

	InfiniteAmmo = minigames:CreateModule({
		Name = 'InfiniteAmmo',
		Function = function(callback)
			updateRequirementHook(callback and InfiniteAmmo.Enabled, TeamDamage and TeamDamage.Enabled)
		end,
		Tooltip = 'Never run out of SMG ammo.'
	})

	TeamDamage = minigames:CreateModule({
		Name = 'TeamDamage',
		Function = function(callback)
			updateRequirementHook(InfiniteAmmo and InfiniteAmmo.Enabled, callback and TeamDamage.Enabled)
		end,
		Tooltip = 'Allows damaging teammates in team gamemodes.'
	})

	FireRate = minigames:CreateModule({
		Name = 'FireRate',
		Function = function()
			syncGunHooks()
		end,
		Tooltip = 'Lowers the 0.09s delay between SMG shots.'
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
				syncGunHooks()
			end
		end
	})

	NoSpread = minigames:CreateModule({
		Name = 'NoSpread',
		Function = function()
			syncGunHooks()
		end,
		Tooltip = 'Removes SMG bullet spread randomization.'
	})

	InstantReload = minigames:CreateModule({
		Name = 'InstantReload',
		Function = function()
			syncGunHooks()
		end,
		Tooltip = 'Skips SMG reload animation delays.'
	})

	AlwaysSprint = minigames:CreateModule({
		Name = 'AlwaysSprint',
		Function = function(callback)
			if callback then
				AlwaysSprint:Clean(runService.Heartbeat:Connect(function()
					local char = lplr.Character
					local hum = char and char:FindFirstChildOfClass('Humanoid')
					if hum and hum.Health > 0 and getEquippedGunScript() then
						local holster = char:FindFirstChild('armToggle')
						if not holster or not holster.Value then
							hum.WalkSpeed = SprintSpeed.Value
						end
					end
				end))
			end
		end,
		Tooltip = 'Keeps sprint speed while your gun is equipped.'
	})
	SprintSpeed = AlwaysSprint:CreateSlider({
		Name = 'Speed',
		Min = 16,
		Max = 32,
		Default = 22
	})

	lplr.ChildAdded:Connect(function(child)
		if child.Name == 'Requirement' and (InfiniteAmmo.Enabled or TeamDamage.Enabled) then
			task.defer(updateRequirementHook, InfiniteAmmo.Enabled, TeamDamage.Enabled)
		end
	end)
end)

return '5411969757'
