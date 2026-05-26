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

run(function()
	-- Custom entitylib functions for this game
	entitylib.getUpdateConnections = function(ent)
		local hum = ent.Humanoid
		local torso = ent.Character and (ent.Character:FindFirstChild('Torso') or ent.Character:FindFirstChild('UpperTorso'))
		local connections = {
			hum:GetPropertyChangedSignal('Health'),
			hum:GetPropertyChangedSignal('MaxHealth')
		}
		
		if torso then
			table.insert(connections, torso:GetPropertyChangedSignal('Material'))
		end
		
		table.insert(connections, {
			Connect = function()
				ent.Friend = ent.Player and isFriend(ent.Player) or nil
				ent.Target = ent.Player and isTarget(ent.Player) or nil
				return {Disconnect = function() end}
			end
		})
		
		return connections
	end
	
	-- Custom target check based on forcefield
	entitylib.targetCheck = function(ent)
		if ent.TeamCheck then return ent:TeamCheck() end
		if ent.NPC then return true end
		if isFriend(ent.Player) then return false end
		if not select(2, whitelist:get(ent.Player)) then return false end
		
		-- Check if torso is forcefield material (Neon/ForceField?)
		local torso = ent.Character and (ent.Character:FindFirstChild('Torso') or ent.Character:FindFirstChild('UpperTorso'))
		if torso then
			local hasForcefield = ent.Character:FindFirstChildWhichIsA('ForceField') ~= nil
			-- Or check material?
			if hasForcefield or (torso.Material == Enum.Material.ForceField or torso.Material == Enum.Material.Neon) then
				return false -- Don't target if they have forcefield
			end
		end
		
		return true
	end
	
	-- Custom isVulnerable
	entitylib.isVulnerable = function(ent)
		local torso = ent.Character and (ent.Character:FindFirstChild('Torso') or ent.Character:FindFirstChild('UpperTorso'))
		local hasForcefield = ent.Character:FindFirstChildWhichIsA('ForceField') ~= nil
		return ent.Health > 0 and not hasForcefield and (torso and torso.Material ~= Enum.Material.ForceField and torso.Material ~= Enum.Material.Neon)
	end
end)

entitylib.start()

run(function()
	-- Forcefield Check Module
	local ForcefieldCheck
	
	ForcefieldCheck = vape.Categories.Minigames:CreateModule({
		Name = 'Forcefield Check',
		Function = function(callback)
			if callback then
				-- Update entities on fast loop (every frame) to catch rapid changes
				ForcefieldCheck:Clean(runService.Heartbeat:Connect(function(dt)
					for _, ent in entitylib.List do
						-- Force update the entity to refresh target check
						if entitylib.Events.EntityUpdated then
							entitylib.Events.EntityUpdated:Fire(ent)
						end
					end
				end))
				
				notif('Forcefield Check', 'Forcefield-based team check enabled!', 5, 'info')
			else
				notif('Forcefield Check', 'Forcefield-based team check disabled!', 5, 'info')
			end
		end,
		Tooltip = 'Uses forcefield material to determine who to draw ESP for (updates very fast)'
	})
end)
