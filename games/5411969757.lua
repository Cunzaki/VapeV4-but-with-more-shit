local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local lightingService = cloneref(game:GetService('Lighting'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity

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
		if not folder or not ent.RootPart then
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
		if head and head:FindFirstChild('FT_TeamESP') and head.FT_TeamESP.Enabled and ent.Player.Team == lplr.Team then
			local localFFA = getTeamFlags(lplr.Team)
			if not localFFA then
				ctx.Flag('team-esp-bypass', 10)
			end
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

return '5411969757'
