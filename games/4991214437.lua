local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local replicatedFirst = cloneref(game:GetService('ReplicatedFirst'))
local collectionService = cloneref(game:GetService('CollectionService'))
local tweenService = cloneref(game:GetService('TweenService'))
local runService = cloneref(game:GetService('RunService'))
local guiService = cloneref(game:GetService('GuiService'))
local coreGui = cloneref(game:GetService('CoreGui'))

local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local whitelist = vape.Libraries.whitelist
local targetinfo = vape.Libraries.targetinfo
local sessioninfo = vape.Libraries.sessioninfo
local getfontsize = vape.Libraries.getfontsize

local pl = {}

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

local hasForcefieldMaterial = function(ent)
	local success, result = pcall(function()
		if not ent.Character then return false end
		
		local torso = ent.Character:FindFirstChild('Torso') or ent.Character:FindFirstChild('UpperTorso')
		if not torso then return false end
		
		local materialName = tostring(torso.Material):lower()
		
		if materialName:find('forcefield') or materialName:find('force field') then
			return true
		end
		
		return false
	end)
	
	return success and result
end

local updateLoop

run(function()
	entitylib.getUpdateConnections = function(ent)
		local hum = ent.Humanoid
		
		local connections = {
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
		
		return connections
	end

	entitylib.targetCheck = function(ent)
		if ent.TeamCheck then return ent:TeamCheck() end
		if ent.NPC then return true end
		if isFriend(ent.Player) then return false end
		if not select(2, whitelist:get(ent.Player)) then return false end
		return not hasForcefieldMaterial(ent)
	end

	entitylib.isVulnerable = function(ent)
		return ent.Health > 0 and not hasForcefieldMaterial(ent)
	end
	
	-- Super fast update loop to catch material changes instantly
	updateLoop = runService.Heartbeat:Connect(function()
		local success, err = pcall(function()
			for _, ent in entitylib.List do
				if ent.Character then
					local current = hasForcefieldMaterial(ent)
					if current ~= (ent._lastForcefield or false) then
						ent._lastForcefield = current
						entitylib.Events.EntityUpdated:Fire(ent)
					end
				end
			end
		end)
		if not success then
			warn('[4991214437] Update loop error:', err)
		end
	end)
end)

entitylib.start()

vape:Clean(function()
	if updateLoop then
		updateLoop:Disconnect()
		updateLoop = nil
	end
end)
