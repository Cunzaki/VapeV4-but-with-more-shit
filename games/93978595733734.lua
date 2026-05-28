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

    GeneratorESP = vape.Categories.Render:CreateModule({
        Name = "GeneratorESP",
        Function = function(callback)
            if callback then
                -- Listen for new generators via CollectionService
                GeneratorESP:Clean(collectionService:GetInstanceAddedSignal("Generator"):Connect(Added))
                GeneratorESP:Clean(collectionService:GetInstanceRemovedSignal("Generator"):Connect(Removed))
                
                -- Also check workspace for existing generators by name
                for _, obj in workspace:GetDescendants() do
                    if obj:IsA("Model") and obj.Name == "Generator" then
                        task.spawn(Added, obj)
                    elseif obj:IsA("BasePart") and obj.Name == "Generator" then
                        task.spawn(Added, obj.Parent or obj)
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

    HookESP = vape.Categories.Render:CreateModule({
        Name = "HookESP",
        Function = function(callback)
            if callback then
                -- Listen for new hooks via CollectionService
                HookESP:Clean(collectionService:GetInstanceAddedSignal("Hook"):Connect(Added))
                HookESP:Clean(collectionService:GetInstanceRemovedSignal("Hook"):Connect(Removed))
                
                -- Also check workspace for existing hooks by name
                for _, obj in workspace:GetDescendants() do
                    if obj:IsA("Model") and obj.Name == "Hook" then
                        task.spawn(Added, obj)
                    elseif obj:IsA("BasePart") and obj.Name == "Hook" then
                        task.spawn(Added, obj.Parent or obj)
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
    local connections = {}

    local function checkAndPress()
        -- Try to find the skill check UI
        local playerGui = lplr:FindFirstChildOfClass("PlayerGui")
        if not playerGui then return end
        
        -- Look for any UI elements that might be a skill check
        for _, child in ipairs(playerGui:GetDescendants()) do
            if child:IsA("GuiObject") and child.Visible and (
                child.Name:lower():find("skill") or 
                child.Name:lower():find("check") or
                (child.Parent and child.Parent.Name:lower():find("skill")) or
                (child.Parent and child.Parent.Name:lower():find("check"))
            ) then
                -- Simulate spacebar press
                inputService.InputBegan:Fire({
                    KeyCode = Enum.KeyCode.Space,
                    UserInputType = Enum.UserInputType.Keyboard,
                    UserInputState = Enum.UserInputState.Begin
                })
                inputService.InputEnded:Fire({
                    KeyCode = Enum.KeyCode.Space,
                    UserInputType = Enum.UserInputType.Keyboard,
                    UserInputState = Enum.UserInputState.End
                })
                
                -- Also try to fire any remote events we found
                local success, err = pcall(function()
                    local remotes = replicatedStorage:FindFirstChild("Remotes")
                    if remotes then
                        local generatorRemotes = remotes:FindFirstChild("Generator")
                        if generatorRemotes then
                            for _, remote in ipairs(generatorRemotes:GetChildren()) do
                                if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                                    if remote.Name:lower():find("repair") or remote.Name:lower():find("skill") then
                                        if remote:IsA("RemoteEvent") then
                                            remote:FireServer(true)
                                        elseif remote:IsA("RemoteFunction") then
                                            task.spawn(function() remote:InvokeServer(true) end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                
                break
            end
        end
    end

    AutoSkillCheck = vape.Categories.Blatant:CreateModule({
        Name = "AutoSkillCheck",
        Function = function(callback)
            if callback then
                -- Listen for new UI elements
                table.insert(connections, lplr.PlayerGui.DescendantAdded:Connect(function(descendant)
                    task.defer(checkAndPress)
                end))
                
                -- Also check every frame just in case
                table.insert(connections, runService.RenderStepped:Connect(checkAndPress))
            else
                for _, conn in ipairs(connections) do
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
