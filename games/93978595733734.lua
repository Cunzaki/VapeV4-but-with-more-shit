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
local virtualInputManager = cloneref(game:GetService("VirtualInputManager"))

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
                ["Connect"] = function()
                    ent.Friend = ent.Player and isFriend(ent.Player) or nil
                    ent.Target = ent.Player and isTarget(ent.Player) or nil
                    return { ["Disconnect"] = function() end }
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

-- [ESP Logic Helper]
local function CreateESPModule(name, collectionTag, fallbackNames, tooltip)
    run(function()
        local ESPModule
        local FillColor
        local OutlineColor
        local FillTransparency
        local OutlineTransparency
        local Reference = {}
        local Folder = Instance.new("Folder")
        Folder.Parent = vape.gui

        local function Added(obj)
            if not obj:IsDescendantOf(workspace) then return end
            if Reference[obj] then return end
            
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
                Reference[obj]:Destroy()
                Reference[obj] = nil
            end
        end

        ESPModule = vape.Categories.Minigames:CreateModule({
            Name = name,
            Function = function(callback)
                if callback then
                    if collectionTag then
                        ESPModule:Clean(collectionService:GetInstanceAddedSignal(collectionTag):Connect(Added))
                        ESPModule:Clean(collectionService:GetInstanceRemovedSignal(collectionTag):Connect(Removed))
                        for _, obj in collectionService:GetTagged(collectionTag) do
                            task.spawn(Added, obj)
                        end
                    end
                    
                    if fallbackNames then
                        for _, obj in workspace:GetDescendants() do
                            if obj:IsA("Model") and table.find(fallbackNames, obj.Name) then
                                task.spawn(Added, obj)
                            elseif obj:IsA("BasePart") and table.find(fallbackNames, obj.Name) then
                                task.spawn(Added, obj.Parent or obj)
                            end
                        end
                    end
                else
                    for _, v in Reference do
                        v:Destroy()
                    end
                    table.clear(Reference)
                end
            end,
            Tooltip = tooltip
        })
        FillColor = ESPModule:CreateColorSlider({
            Name = "Color",
            Function = function(hue, sat, val)
                for _, v in Reference do v.FillColor = Color3.fromHSV(hue, sat, val) end
            end
        })
        OutlineColor = ESPModule:CreateColorSlider({
            Name = "Outline Color",
            DefaultSat = 0,
            Function = function(hue, sat, val)
                for _, v in Reference do v.OutlineColor = Color3.fromHSV(hue, sat, val) end
            end
        })
        FillTransparency = ESPModule:CreateSlider({
            Name = "Transparency",
            Min = 0, Max = 1, Default = 0.5, Decimal = 10,
            Function = function(val)
                for _, v in Reference do v.FillTransparency = val end
            end
        })
        OutlineTransparency = ESPModule:CreateSlider({
            Name = "Outline Transparency",
            Min = 0, Max = 1, Default = 0.5, Decimal = 10,
            Function = function(val)
                for _, v in Reference do v.OutlineTransparency = val end
            end
        })
    end)
end

CreateESPModule("GeneratorESP", "GeneratorPoint", {"Generator"}, "Display all generators")
CreateESPModule("HookESP", "UnhookPoint", {"Hook"}, "Display all hooks")
CreateESPModule("PalletESP", "PalletPoint", {"Pallet"}, "Display all pallets")
CreateESPModule("WindowESP", "VaultPoint", {"Window"}, "Display all windows/vaults")

-- Auto Skill Check
run(function()
    local AutoSkillCheck
    local connections = {}
    local debounce = false

    local function checkAndPress()
        if debounce then return end
        local playerGui = lplr:FindFirstChildOfClass("PlayerGui")
        if not playerGui then return end
        
        for _, child in ipairs(playerGui:GetDescendants()) do
            if child:IsA("GuiObject") and child.Visible and (
                child.Name:lower():find("skill") or 
                child.Name:lower():find("check") or
                (child.Parent and child.Parent.Name:lower():find("skill")) or
                (child.Parent and child.Parent.Name:lower():find("check"))
            ) then
                debounce = true
                
                -- Use VirtualInputManager instead of InputBegan:Fire
                virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.delay(0.05, function()
                    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                    debounce = false
                end)
                
                -- Fallback to remote if possible
                pcall(function()
                    local remotes = replicatedStorage:FindFirstChild("Remotes")
                    if remotes then
                        local generatorRemotes = remotes:FindFirstChild("Generator")
                        if generatorRemotes then
                            for _, remote in ipairs(generatorRemotes:GetChildren()) do
                                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("repair") or remote.Name:lower():find("skill")) then
                                    remote:FireServer(true)
                                end
                            end
                        end
                    end
                end)
                break
            end
        end
    end

    AutoSkillCheck = vape.Categories.Minigames:CreateModule({
        Name = "AutoSkillCheck",
        Function = function(callback)
            if callback then
                table.insert(connections, lplr.PlayerGui.DescendantAdded:Connect(function()
                    task.defer(checkAndPress)
                end))
                table.insert(connections, runService.RenderStepped:Connect(checkAndPress))
            else
                for _, conn in ipairs(connections) do
                    if conn then conn:Disconnect() end
                end
                table.clear(connections)
            end
        end,
        Tooltip = "Automatically pass skill checks"
    })
end)

-- Gameplay Exploits
run(function()
    local DropAllPallets
    DropAllPallets = vape.Categories.Minigames:CreateModule({
        Name = "DropAllPallets",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    local remotes = replicatedStorage:FindFirstChild("Remotes")
                    local palletDrop = remotes and remotes:FindFirstChild("Pallet") and remotes.Pallet:FindFirstChild("PalletDropEvent")
                    if palletDrop then
                        local count = 0
                        for _, pallet in ipairs(collectionService:GetTagged("PalletPoint")) do
                            palletDrop:FireServer(pallet)
                            count = count + 1
                        end
                        notif("DropAllPallets", "Attempted to drop " .. tostring(count) .. " pallets.", 3)
                    else
                        notif("DropAllPallets", "Could not find pallet remote.", 3)
                    end
                    DropAllPallets:ToggleButton(false)
                end)
            end
        end,
        Tooltip = "Drops all pallets on the map instantly."
    })
end)

run(function()
    local VaultNearest
    VaultNearest = vape.Categories.Minigames:CreateModule({
        Name = "VaultNearest",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    local remotes = replicatedStorage:FindFirstChild("Remotes")
                    local vaultEvent = remotes and remotes:FindFirstChild("Window") and remotes.Window:FindFirstChild("VaultEvent")
                    if vaultEvent then
                        local root = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            local nearest, dist = nil, math.huge
                            for _, window in ipairs(collectionService:GetTagged("VaultPoint")) do
                                local d = (window.Position - root.Position).Magnitude
                                if d < dist then
                                    dist = d
                                    nearest = window
                                end
                            end
                            if nearest then
                                vaultEvent:FireServer(nearest, true)
                                notif("VaultNearest", "Vaulted nearest window.", 3)
                            end
                        else
                            notif("VaultNearest", "Character not found.", 3)
                        end
                    else
                        notif("VaultNearest", "Could not find vault remote.", 3)
                    end
                    VaultNearest:ToggleButton(false)
                end)
            end
        end,
        Tooltip = "Instantly vaults the nearest window (may teleport)."
    })
end)

run(function()
    local AutoMedalClaim
    local connections = {}
    AutoMedalClaim = vape.Categories.Minigames:CreateModule({
        Name = "AutoMedalClaim",
        Function = function(callback)
            if callback then
                table.insert(connections, runService.Heartbeat:Connect(function()
                    local medalQuestClaim = replicatedStorage:FindFirstChild("Remotes") and replicatedStorage.Remotes:FindFirstChild("Events") and replicatedStorage.Remotes.Events:FindFirstChild("Medal") and replicatedStorage.Remotes.Events.Medal:FindFirstChild("MedalQuestClaim")
                    if medalQuestClaim then
                        pcall(function() medalQuestClaim:InvokeServer() end)
                    end
                end))
            else
                for _, conn in ipairs(connections) do
                    if conn then
                        conn:Disconnect()
                    end
                end
                table.clear(connections)
            end
        end,
        Tooltip = "Automatically claim medals (Exploit)"
    })
end)
