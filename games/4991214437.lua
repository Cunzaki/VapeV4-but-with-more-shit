local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end
local vapeEvents = setmetatable({}, {
	__index = function(self, index)
		self[index] = Instance.new('BindableEvent')
		return self[index]
	end
})

local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local replicatedFirst = cloneref(game:GetService('ReplicatedFirst'))
local collectionService = cloneref(game:GetService('CollectionService'))
local tweenService = cloneref(game:GetService('TweenService'))
local runService = cloneref(game:GetService('RunService'))
local guiService = cloneref(game:GetService('GuiService'))
local teams = cloneref(game:GetService('Teams'))
local coreGui = cloneref(game:GetService('CoreGui'))

local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local whitelist = vape.Libraries.whitelist
local targetinfo = vape.Libraries.targetinfo
local sessioninfo = vape.Libraries.sessioninfo
local getfontsize = vape.Libraries.getfontsize

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

local function isTarget(plr)
	return table.find(vape.Categories.Targets.ListEnabled, plr.Name) and true
end

local function notif(...)
	return vape:CreateNotification(...)
end

local function removeTags(str)
	str = str:gsub('<br%s*/>', '\n')
	return (str:gsub('<[^<>]->', ''))
end

local function hasForcefield(ent)
	local char = ent.Character
	if not char then return true end
	local torso = char:FindFirstChild('Torso')
	if not torso then
		torso = char:FindFirstChild('UpperTorso')
	end
	if torso and torso.Material == Enum.Material.ForceField then
		return true
	end
	if char:FindFirstChildWhichIsA('ForceField') then
		return true
	end
	return false
end

run(function()
	entitylib.getUpdateConnections = function(ent)
		local hum = ent.Humanoid
		local char = ent.Character
		local torso = char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		local conns = {
			hum:GetPropertyChangedSignal('Health'),
			hum:GetPropertyChangedSignal('MaxHealth'),
			{
				Connect = function()
					ent.Friend = ent.Player and isFriend(ent.Player) or nil
					ent.Target = ent.Player and isTarget(ent.Player) or nil
					return {Disconnect = function() end}
				end
			}
		}
		if torso then
			table.insert(conns, torso:GetPropertyChangedSignal('Material'))
		end
		return conns
	end

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

	entitylib.IgnoreObject.RespectCanCollide = false
	
	-- Fast update loop
	vape:Clean(runService.Heartbeat:Connect(function()
		for _, ent in entitylib.List do
			if ent and ent.Character then
				local oldVuln = ent.Vulnerable
				ent.Vulnerable = entitylib.isVulnerable(ent)
				ent.Targetable = entitylib.targetCheck(ent)
			end
		end
	end))
end)
entitylib.start()

-- Add under Minigames
for _, v in {'Reach', 'Invisible', 'Killaura', 'MurderMystery'} do
	vape:Remove(v)
end
