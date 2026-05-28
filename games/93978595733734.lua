local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService("Players"))
local inputService = cloneref(game:GetService("UserInputService"))
local replicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local collectionService = cloneref(game:GetService("CollectionService"))
local tweenService = cloneref(game:GetService("TweenService"))
local runService = cloneref(game:GetService("RunService"))
local guiService = cloneref(game:GetService("GuiService"))
local coreGui = cloneref(game:GetService("CoreGui"))

local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local whitelist = vape.Libraries.whitelist
local targetinfo = vape.Libraries.targetinfo
local sessioninfo = vape.Libraries.sessioninfo
local getfontsize = vape.Libraries.getfontsize

local function isFriend(plr, recolor)
	if vape.Categories.Friends.Options["Use friends"].Enabled then
		local friend = table.find(vape.Categories.Friends.ListEnabled, plr.Name) and true
		if recolor then
			friend = friend and vape.Categories.Friends.Options["Recolor visuals"].Enabled
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
	str = str:gsub("<br%s*/>", "\n")
	return (str:gsub("<[^<>]->", ""))
end

-- Custom Entity Library Setup
run(function()
	entitylib.getUpdateConnections = function(ent)
		local hum = ent.Humanoid
		return {
			hum:GetPropertyChangedSignal("Health"),
			hum:GetPropertyChangedSignal("MaxHealth"),
			{
				Connect = function()
					ent.Friend = ent.Player and isFriend(ent.Player) or nil
					ent.Target = ent.Player and isTarget(ent.Player) or nil
					return {Disconnect = function() end}
				end
			}
		}
	end

	entitylib.targetCheck = function(ent)
		if ent.TeamCheck then return ent:TeamCheck() end
		if ent.NPC then return true end
		if isFriend(ent.Player) then return false end
		if not select(2, whitelist:get(ent.Player)) then return false end
		return true
	end
end)
entitylib.start()

-- Generator ESP
run(function()
	local GeneratorESP
	local FillColor
	local OutlineColor
	local FillTransparency
	local OutlineTransparency
	local Reference = {}
	local Folder = Instance.new("Folder")
	Folder.Parent = vape.gui

	local function Added(obj)
		local cham = Instance.new("Highlight")
		cham.Adornee = obj
		cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		cham.FillColor = Color3.fromHSV(FillColor.Hue, FillColor.Sat, FillColor.Value)
		cham.OutlineColor = Color3.fromHSV(OutlineColor.Hue, OutlineColor.Sat, OutlineColor.Value)
		cham.FillTransparency = FillTransparency.Value
		cham.OutlineTransparency = OutlineTransparency.Value
		cham.Parent = Folder
		Reference[obj] = cham
	end

	local function Removed(obj)
		if Reference[obj] then
			if vape.ThreadFix then
				setthreadidentity(8)
			end
			Reference[obj]:Destroy()
			Reference[obj] = nil
		end
	end

	GeneratorESP = vape.Categories.Render:CreateModule({
		Name = "GeneratorESP",
		Function = function(callback)
			if callback then
				GeneratorESP:Clean(collectionService:GetInstanceAddedSignal("Generator"):Connect(Added))
				GeneratorESP:Clean(collectionService:GetInstanceRemovedSignal("Generator"):Connect(Removed))
				for _, obj in collectionService:GetTagged("Generator") do
					task.spawn(Added, obj)
				end
				-- Also check workspace for generators manually
				for _, obj in workspace:GetDescendants() do
					if obj.Name == "Generator" and not Reference[obj] then
						task.spawn(Added, obj)
					end
				end
			else
				for _, v in Reference do
					v:Destroy()
				end
				table.clear(Reference)
			end
		end,
		Tooltip = "Display all generators"
	})
	FillColor = GeneratorESP:CreateColorSlider({
		Name = "Color",
		Function = function(hue, sat, val)
			for _, v in Reference do
				v.FillColor = Color3.fromHSV(hue, sat, val)
			end
		end
	})
	OutlineColor = GeneratorESP:CreateColorSlider({
		Name = "Outline Color",
		DefaultSat = 0,
		Function = function(hue, sat, val)
			for _, v in Reference do
				v.OutlineColor = Color3.fromHSV(hue, sat, val)
			end
		end
	})
	FillTransparency = GeneratorESP:CreateSlider({
		Name = "Transparency",
		Min = 0,
		Max = 1,
		Default = 0.5,
		Function = function(val)
			for _, v in Reference do
				v.FillTransparency = val
			end
		end,
		Decimal = 10
	})
	OutlineTransparency = GeneratorESP:CreateSlider({
		Name = "Outline Transparency",
		Min = 0,
		Max = 1,
		Default = 0.5,
		Function = function(val)
			for _, v in Reference do
				v.OutlineTransparency = val
			end
		end,
		Decimal = 10
	})
end)

-- Hook ESP
run(function()
	local HookESP
	local FillColor
	local OutlineColor
	local FillTransparency
	local OutlineTransparency
	local Reference = {}
	local Folder = Instance.new("Folder")
	Folder.Parent = vape.gui

	local function Added(obj)
		local cham = Instance.new("Highlight")
		cham.Adornee = obj
		cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		cham.FillColor = Color3.fromHSV(FillColor.Hue, FillColor.Sat, FillColor.Value)
		cham.OutlineColor = Color3.fromHSV(OutlineColor.Hue, OutlineColor.Sat, OutlineColor.Value)
		cham.FillTransparency = FillTransparency.Value
		cham.OutlineTransparency = OutlineTransparency.Value
		cham.Parent = Folder
		Reference[obj] = cham
	end

	local function Removed(obj)
		if Reference[obj] then
			if vape.ThreadFix then
				setthreadidentity(8)
			end
			Reference[obj]:Destroy()
			Reference[obj] = nil
		end
	end

	HookESP = vape.Categories.Render:CreateModule({
		Name = "HookESP",
		Function = function(callback)
			if callback then
				HookESP:Clean(collectionService:GetInstanceAddedSignal("Hook"):Connect(Added))
				HookESP:Clean(collectionService:GetInstanceRemovedSignal("Hook"):Connect(Removed))
				for _, obj in collectionService:GetTagged("Hook") do
					task.spawn(Added, obj)
				end
				-- Also check workspace for hooks manually
				for _, obj in workspace:GetDescendants() do
					if obj.Name == "Hook" and not Reference[obj] then
						task.spawn(Added, obj)
					end
				end
			else
				for _, v in Reference do
					v:Destroy()
				end
				table.clear(Reference)
			end
		end,
		Tooltip = "Display all hooks"
	})
	FillColor = HookESP:CreateColorSlider({
		Name = "Color",
		Function = function(hue, sat, val)
			for _, v in Reference do
				v.FillColor = Color3.fromHSV(hue, sat, val)
			end
		end
	})
	OutlineColor = HookESP:CreateColorSlider({
		Name = "Outline Color",
		DefaultSat = 0,
		Function = function(hue, sat, val)
			for _, v in Reference do
				v.OutlineColor = Color3.fromHSV(hue, sat, val)
			end
		end
	})
	FillTransparency = HookESP:CreateSlider({
		Name = "Transparency",
		Min = 0,
		Max = 1,
		Default = 0.5,
		Function = function(val)
			for _, v in Reference do
				v.FillTransparency = val
			end
		end,
		Decimal = 10
	})
	OutlineTransparency = HookESP:CreateSlider({
		Name = "Outline Transparency",
		Min = 0,
		Max = 1,
		Default = 0.5,
		Function = function(val)
			for _, v in Reference do
				v.OutlineTransparency = val
			end
		end,
		Decimal = 10
	})
end)

-- Auto Skill Check
run(function()
	local AutoSkillCheck
	local SkillCheckRemote
	local connections = {}

	local function setupSkillCheck()
		-- Find skill check remote in ReplicatedStorage.Remotes.Generator
		local remotes = replicatedStorage:FindFirstChild("Remotes")
		if remotes then
			local generator = remotes:FindFirstChild("Generator")
			if generator then
				for _, child in pairs(generator:GetChildren()) do
					if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
						if child.Name:lower():find("skill") then
							SkillCheckRemote = child
							break
						end
					end
				end
			end
		end
	end

	AutoSkillCheck = vape.Categories.Blatant:CreateModule({
		Name = "AutoSkillCheck",
		Function = function(callback)
			if callback then
				setupSkillCheck()
				-- Listen for UI changes for skill check
				AutoSkillCheck:Clean(lplr.PlayerGui.DescendantAdded:Connect(function(descendant)
					if descendant.Name:lower():find("skill") or descendant.Name:lower():find("check") then
						-- If skill check UI appears, try to press it
						task.wait()
						if SkillCheckRemote then
							if SkillCheckRemote:IsA("RemoteEvent") then
								SkillCheckRemote:FireServer(true)
							elseif SkillCheckRemote:IsA("RemoteFunction") then
								pcall(function() SkillCheckRemote:InvokeServer(true) end)
							end
						else
							-- Fallback: simulate spacebar press
							inputService.InputBegan:Connect(function(input)
								if input.KeyCode == Enum.KeyCode.Space then
									inputService.InputBegan:Disconnect()
								end
							end)
							-- Simulate space
							inputService.InputBegan:Fire({
								KeyCode = Enum.KeyCode.Space,
								UserInputType = Enum.UserInputType.Keyboard
							})
						end
					end
				end))
			else
				for _, conn in pairs(connections) do
					if conn then
						conn:Disconnect()
					end
				end
				table.clear(connections)
			end
		end,
		Tooltip = "Automatically pass skill checks"
	})
end)
