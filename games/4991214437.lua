local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local whitelist = vape.Libraries.whitelist

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

local function hasForcefield(ent)
	if not ent.Character then return false end
	local torso = ent.Character:FindFirstChild('Torso') or ent.Character:FindFirstChild('UpperTorso')
	if torso and torso.Material == Enum.Material.ForceField then
		return true
	end
	if ent.Character:FindFirstChildWhichIsA('ForceField') then
		return true
	end
	return false
end

run(function()
	entitylib.targetCheck = function(ent)
		if ent.TeamCheck then return ent:TeamCheck() end
		if ent.NPC then return true end
		if isFriend(ent.Player) then return false end
		if not select(2, whitelist:get(ent.Player)) then return false end
		return not hasForcefield(ent)
	end

	entitylib.isVulnerable = function(ent)
		return ent.Health > 0 and not hasForcefield(ent)
	end
end)
entitylib.start()

-- Add under Minigames
for _, v in {'Reach', 'Invisible', 'Killaura', 'MurderMystery'} do
	vape:Remove(v)
end
