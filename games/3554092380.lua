local run = function(func)
    func()
end
local cloneref = cloneref or function(obj)
    return obj
end

local playersService = cloneref(game:GetService("Players"))
local replicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local lplr = playersService.LocalPlayer
local vape = shared.vape

local originalSettings = {}
local gunConfigs = {}

local function scanForGunConfigs()
    for _, v in ipairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Damage") ~= nil and rawget(v, "RPM") ~= nil and rawget(v, "Bullets") ~= nil then
            if not table.find(gunConfigs, v) then
                table.insert(gunConfigs, v)
                originalSettings[v] = {
                    Recoil = rawget(v, "Recoil"),
                    CameraRecoil = rawget(v, "CameraRecoil"),
                    RecoilReduc = rawget(v, "RecoilReduc"),
                    Spread = rawget(v, "Spread"),
                    MinSpread = rawget(v, "MinSpread"),
                    MaxSpread = rawget(v, "MaxSpread"),
                    Damage = rawget(v, "Damage"),
                    Headshot = rawget(v, "Headshot"),
                    PreshootFunc = rawget(v, "PreshootFunc")
                }
            end
        end
    end
end

-- Get the Functions module from ReplicatedStorage
local function getFunctionsModule()
    local success, result = pcall(function()
        return require(replicatedStorage:WaitForChild("Functions"))
    end)
    return success and result or nil
end

local originalConvertd = nil
local originalPerkMin = nil
local FunctionsModule = getFunctionsModule()

-- Gun Mods (Infinite Ammo, Fire Rate, Recoil, Spread)
run(function()
    local GunModsModule
    local InfiniteAmmo
    local NoRecoil
    local NoSpread
    local FastFireRate
    
    -- Hook Functions.convertd for perfectly reliable Fire Rate
    if FunctionsModule and not originalConvertd then
        originalConvertd = FunctionsModule.convertd
        FunctionsModule.convertd = function(rpm, player, ...)
            local result = originalConvertd(rpm, player, ...)
            if GunModsModule and GunModsModule.Enabled and FastFireRate and FastFireRate.Value > 1 then
                result = result / FastFireRate.Value
            end
            return result
        end
    end
    
    local function applyMods()
        -- 1. Modify gunConfigs (for recoil, spread, ammo)
        for _, config in ipairs(gunConfigs) do
            local orig = originalSettings[config]
            if orig then
                if GunModsModule.Enabled then
                    if InfiniteAmmo.Enabled then 
                        local originalPreshoot = orig.PreshootFunc
                        config.PreshootFunc = function()
                            if originalPreshoot then originalPreshoot() end
                            config.FreeAmmo = true
                        end
                    else 
                        config.PreshootFunc = orig.PreshootFunc
                    end
                    
                    if NoRecoil.Enabled then 
                        config.Recoil = Vector3.new(0, 0, 0)
                        config.CameraRecoil = Vector3.new(0, 0, 0)
                        config.RecoilReduc = {["Easy"] = 0, ["Original"] = 0}
                    else 
                        config.Recoil = orig.Recoil
                        config.CameraRecoil = orig.CameraRecoil
                        config.RecoilReduc = orig.RecoilReduc
                    end
                    
                    if NoSpread.Enabled then 
                        config.Spread = 0
                        config.MinSpread = 0
                        config.MaxSpread = 0 
                    else 
                        config.Spread = orig.Spread
                        config.MinSpread = orig.MinSpread
                        config.MaxSpread = orig.MaxSpread 
                    end
                else
                    config.PreshootFunc = orig.PreshootFunc
                    config.Recoil = orig.Recoil
                    config.CameraRecoil = orig.CameraRecoil
                    config.RecoilReduc = orig.RecoilReduc
                    config.Spread = orig.Spread
                    config.MinSpread = orig.MinSpread
                    config.MaxSpread = orig.MaxSpread
                end
            end
        end
    end

    GunModsModule = vape.Categories.Combat:CreateModule({
        Name = "GunMods",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    scanForGunConfigs()
                    while GunModsModule.Enabled do
                        applyMods()
                        task.wait(1)
                    end
                end)
            else
                applyMods()
            end
        end,
        Tooltip = "Modifies your gun's stats"
    })
    
    InfiniteAmmo = GunModsModule:CreateToggle({
        Name = "Infinite Ammo",
        Function = function() applyMods() end
    })
    
    NoRecoil = GunModsModule:CreateToggle({
        Name = "No Recoil",
        Function = function() applyMods() end
    })
    
    NoSpread = GunModsModule:CreateToggle({
        Name = "No Spread",
        Function = function() applyMods() end
    })
    
    FastFireRate = GunModsModule:CreateSlider({
        Name = "Fire Rate Multiplier",
        Min = 1,
        Max = 20,
        Default = 2,
        Decimal = 10,
        Function = function(val) end -- Handled entirely by the convertd hook!
    })
end)

-- InstaKill (Headshots)
run(function()
    local InstaKill
    
    local function applyInstaKill()
        for _, config in ipairs(gunConfigs) do
            local orig = originalSettings[config]
            if orig then
                if InstaKill.Enabled then
                    config.Damage = math.huge
                    config.Headshot = math.huge
                    -- Also add immunity bypass so bosses don't ignore the damage
                    config.ImmunityCheck = false
                else
                    config.Damage = orig.Damage
                    config.Headshot = orig.Headshot
                    config.ImmunityCheck = orig.ImmunityCheck
                end
            end
        end
    end

    InstaKill = vape.Categories.Combat:CreateModule({
        Name = "InstaKill",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    scanForGunConfigs()
                    while InstaKill.Enabled do
                        applyInstaKill()
                        task.wait(1)
                    end
                end)
            else
                applyInstaKill()
            end
        end,
        Tooltip = "Modifies gun damage to instantly kill all zombies (including bosses)."
    })
end)

-- Perk Spoofing
run(function()
    local PerkSpoofModule
    local perkToggles = {}
    
    local perkList = {
        {Name = "Juggernog", Internal = {"Juggernog"}},
        {Name = "Speed Cola", Internal = {"SpeedCola"}},
        {Name = "Double Tap", Internal = {"DoubleTap", "DTOne", "DTHalf"}},
        {Name = "PhD Flopper", Internal = {"PHDFlopper"}},
        {Name = "Stamin-Up", Internal = {"StaminUp"}},
        {Name = "Quick Revive", Internal = {"QuickR"}},
        {Name = "Deadshot", Internal = {"Deadshot", "Bullseye"}},
        {Name = "Mule Kick", Internal = {"MuleKick", "MK"}},
        {Name = "Tombstone", Internal = {"Tombstone"}},
        {Name = "Who's Who", Internal = {"Who'sWho"}},
        {Name = "Death Perception", Internal = {"DeathPerception"}},
        {Name = "Widow's Web", Internal = {"Web"}},
        {Name = "Explosive Spirits", Internal = {"ESpirits"}},
        {Name = "Nade Cola", Internal = {"NadeCola"}},
        {Name = "Shopper", Internal = {"Shopper"}}
    }
    
    -- Hook PerkMin for Limit Bypass
    if FunctionsModule and not originalPerkMin then
        originalPerkMin = FunctionsModule.PerkMin
        FunctionsModule.PerkMin = function(...)
            if PerkSpoofModule and PerkSpoofModule.Enabled then
                return math.huge -- Infinite perk limit
            end
            if originalPerkMin then
                return originalPerkMin(...)
            end
            return 4
        end
    end

    local function applyPerks()
        for _, perkData in ipairs(perkList) do
            local toggle = perkToggles[perkData.Name]
            local shouldHave = PerkSpoofModule.Enabled and toggle and toggle.Enabled
            
            for _, internalName in ipairs(perkData.Internal) do
                local existing = lplr.PlayerGui:FindFirstChild(internalName)
                
                if shouldHave then
                    if not existing then
                        -- To make it show up on the HUD, the game requires the Perk instance to be a specific type 
                        -- (usually an ImageLabel or similar) with specific formatting, but often it relies on the "Permanent" attribute
                        -- or fires a local remote to update the HUD.
                        -- However, injecting a Folder or StringValue tricks most logical checks, and we can force the HUD via
                        -- the game's internal HUD updater if we find it. For now, creating a fake ScreenGui/ImageLabel helps.
                        
                        local val = Instance.new("Folder")
                        val.Name = internalName
                        val.Parent = lplr.PlayerGui
                        -- Add a fake ImageLabel so ResortPerks counts it as a HUD icon
                        local img = Instance.new("ImageLabel")
                        img.Name = "ImageLabel"
                        -- Set a generic icon to prevent errors if the game expects one
                        img.Image = "rbxassetid://0" 
                        img.Parent = val
                        
                        -- Add an ImageButton too, as some perk scripts specifically look for that
                        local btn = Instance.new("ImageButton")
                        btn.Name = "ImageButton"
                        btn.Parent = val
                        
                        -- Attempt to trigger the game's native UI update function for perks
                        pcall(function()
                            if FunctionsModule and FunctionsModule.ResortPerks then
                                FunctionsModule.ResortPerks(lplr.PlayerGui)
                            end
                        end)
                    end
                else
                    if existing and (existing:IsA("Folder") or existing:IsA("StringValue")) then
                        existing:Destroy()
                        pcall(function()
                            if FunctionsModule and FunctionsModule.ResortPerks then
                                FunctionsModule.ResortPerks(lplr.PlayerGui)
                            end
                        end)
                    end
                end
            end
        end
    end

    PerkSpoofModule = vape.Categories.Combat:CreateModule({
        Name = "Spoof Perks",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while PerkSpoofModule.Enabled do
                        applyPerks()
                        task.wait(1)
                    end
                end)
            else
                applyPerks()
            end
        end,
        Tooltip = "Gives you the effects of selected perk sodas and unlocks 6 perk limit."
    })
    
    for _, perkData in ipairs(perkList) do
        perkToggles[perkData.Name] = PerkSpoofModule:CreateToggle({
            Name = perkData.Name,
            Function = function() applyPerks() end
        })
    end
end)

-- No Env/Explosive/Gas Damage
run(function()
    local NoEnvDamage
    local origExplosion = nil
    local hazardNames = {
        ["Lava"] = true,
        ["Toxic Waste"] = true,
        ["Gas"] = true,
        ["Smoke"] = true,
        ["NovaGas"] = true,
        ["CrawlerGas"] = true,
        ["Acid"] = true,
        ["Fire"] = true
    }
    
    local function disableHazard(v)
        if v:IsA("BasePart") and hazardNames[v.Name] then
            v.CanTouch = false
        end
    end
    
    NoEnvDamage = vape.Categories.Combat:CreateModule({
        Name = "No Env Damage",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    -- Disable explosive damage via hooking Functions.Explosion
                    local FunctionsModule = getFunctionsModule()
                    if FunctionsModule and FunctionsModule.Explosion and not origExplosion then
                        local hookfunction = hookfunction or detour_function
                        if hookfunction then
                            pcall(function()
                                origExplosion = hookfunction(FunctionsModule.Explosion, function(pos, range, damage, p4, player, ...)
                                    if NoEnvDamage.Enabled and player == lplr then
                                        -- Nullify the damage if we are the ones getting hit by an explosion
                                        damage = 0
                                    end
                                    return origExplosion(pos, range, damage, p4, player, ...)
                                end)
                            end)
                        end
                    end
                    
                    -- Hook dynamically added hazards
                    local connection = workspace.DescendantAdded:Connect(function(v)
                        if NoEnvDamage.Enabled then
                            task.wait() -- let properties initialize
                            disableHazard(v)
                        end
                    end)
                    
                    while NoEnvDamage.Enabled do
                        -- Scan workspace for existing hazards
                        for _, v in ipairs(workspace:GetDescendants()) do
                            disableHazard(v)
                        end
                        
                        task.wait(1)
                    end
                    
                    connection:Disconnect()
                end)
            else
                -- We leave CanTouch false since reverting it might be dangerous, 
                -- and disabling it doesn't hurt normal gameplay
            end
        end,
        Tooltip = "Disables Lava, Toxic Waste, Fire, Gas, Smoke, and Explosive damage."
    })
end)

-- Exploit Points/Powerups
run(function()
    local ClaimPowerups
    local powerupToggles = {}
    
    local powerupsList = {
        "Max Ammo",
        "Insta-Kill",
        "Double Points",
        "Nuke",
        "Carpenter",
        "Fire Sale",
        "Death Machine",
        "Bonus Points",
        "Zombie Blood",
        "Insta-PAP"
    }
    
    local function doClaimPowerups()
        -- With recent filtering updates, checking workspace for dropped powerups is more reliable
        -- Powerups are stored inside workspace["Power-ups"] (sometimes as models or stringvalues locally synced)
        -- AND the powerupInfo folder in replicated storage syncs their existence
        
        local powerupInfo = replicatedStorage:FindFirstChild("PowerupInfo")
        local powerupsEvent = replicatedStorage:FindFirstChild("Resources") and replicatedStorage.Resources:FindFirstChild("Power-ups") and replicatedStorage.Resources["Power-ups"]:FindFirstChild("Event")
        
        if powerupInfo and powerupsEvent then
            for _, powerupValue in ipairs(powerupInfo:GetChildren()) do
                -- Check if this specific powerup is toggled on
                local toggle = powerupToggles[powerupValue.Name]
                if toggle and toggle.Enabled then
                    pcall(function()
                        powerupsEvent:FireServer(powerupValue)
                    end)
                end
            end
        end
        
        -- Fallback: check workspace drops
        local powerupsFolder = workspace:FindFirstChild("Power-ups") or workspace:FindFirstChild("Powerups")
        if powerupsFolder then
            for _, drop in ipairs(powerupsFolder:GetChildren()) do
                -- Check if this specific powerup is toggled on
                local pName = drop.Name
                local toggle = powerupToggles[pName]
                if toggle and toggle.Enabled then
                    -- PowerupVisuals handles the touch logic on the client, but the actual claim goes through the same remote using the ObjectValue/StringValue 
                    -- associated with the drop.
                    -- If we find the drop in workspace, we can try firing the remote with it directly
                    if powerupsEvent then
                        pcall(function() powerupsEvent:FireServer(drop) end)
                    end
                    
                    -- Also attempt local physical touch just in case
                    local touchPart = drop:FindFirstChild("Hitbox") or drop:FindFirstChild("Part") or drop:FindFirstChildWhichIsA("BasePart") or drop
                    if touchPart and touchPart:IsA("BasePart") and lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            firetouchinterest(lplr.Character.HumanoidRootPart, touchPart, 0)
                            firetouchinterest(lplr.Character.HumanoidRootPart, touchPart, 1)
                        end)
                    end
                end
            end
        end
    end

    ClaimPowerups = vape.Categories.Combat:CreateModule({
        Name = "Autoclaim Powerups",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while ClaimPowerups.Enabled do
                        doClaimPowerups()
                        task.wait(0.2)
                    end
                end)
            else
                -- Nothing needed on disable
            end
        end,
        Tooltip = "Attempts to auto-claim selected powerups via remote events"
    })
    
    for _, pName in ipairs(powerupsList) do
        powerupToggles[pName] = ClaimPowerups:CreateToggle({
            Name = pName,
            Function = function() doClaimPowerups() end
        })
    end
end)

-- God Mode (Server-side bypass via Remote hooking)
run(function()
    local GodMode
    local origNamecall = nil
    local origNewIndex = nil
    
    GodMode = vape.Categories.Combat:CreateModule({
        Name = "God Mode",
        Function = function(callback)
            if callback then
                -- Hook __namecall to block TakeDamage and damage remotes
                if not origNamecall and getgenv().hookmetamethod then
                    pcall(function()
                        origNamecall = getgenv().hookmetamethod(game, "__namecall", function(self, ...)
                            local method = getnamecallmethod()
                            local args = {...}
                            
                            if GodMode and GodMode.Enabled then
                                -- 1. Block Server Sync Remotes
                                if method == "FireServer" and self.Name == "ETC" then
                                    if type(args[1]) == "table" then
                                        local subArgs = args[1]
                                        if type(subArgs[#subArgs]) == "string" and (string.find(subArgs[#subArgs], "DMS") or string.find(subArgs[#subArgs], "Damage5")) then
                                            return -- Block the damage sync completely
                                        end
                                    end
                                end
                                
                                -- 2. Block Local TakeDamage
                                if method == "TakeDamage" and self:IsA("Humanoid") and lplr.Character and self.Parent == lplr.Character then
                                    return -- Block local TakeDamage
                                end
                            end
                            
                            return origNamecall(self, ...)
                        end)
                    end)
                end
                
                -- Hook __newindex to block direct Health modifications (e.g. Humanoid.Health = Health - 50)
                if not origNewIndex and getgenv().hookmetamethod then
                    pcall(function()
                        origNewIndex = getgenv().hookmetamethod(game, "__newindex", function(self, index, value)
                            if GodMode and GodMode.Enabled then
                                if self:IsA("Humanoid") and index == "Health" and lplr.Character and self.Parent == lplr.Character then
                                    -- Only allow healing, block damage
                                    if type(value) == "number" and value < self.Health then
                                        return
                                    end
                                end
                            end
                            return origNewIndex(self, index, value)
                        end)
                    end)
                end

                task.spawn(function()
                    while GodMode.Enabled do
                        if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
                            lplr.Character.Humanoid.Health = lplr.Character.Humanoid.MaxHealth
                        end
                        task.wait(0.01) -- Very fast loop to ensure we stay alive locally too
                    end
                end)
            else
                -- Nothing needed on disable
            end
        end,
        Tooltip = "Makes you invincible by blocking all local and remote damage methods."
    })
end)

-- XP/Kills Spoofing (Auto-Farm)
run(function()
    local XPSpoofer
    
    XPSpoofer = vape.Categories.Combat:CreateModule({
        Name = "XP/Kills Spoofer",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    local etcEvent = game:GetService("Lighting"):FindFirstChild("ETC") or (replicatedStorage:FindFirstChild("Events") and replicatedStorage.Events:FindFirstChild("ETC"))
                    local HandleDataModule = nil
                    
                    pcall(function()
                        HandleDataModule = require(replicatedStorage:WaitForChild("HandleData"))
                    end)
                    
                    while XPSpoofer.Enabled do
                        -- 1. Exploit Local Data Tracker to farm XP/Kills
                        if HandleDataModule then
                            pcall(function()
                                if HandleDataModule.IncreaseStat then
                                    HandleDataModule.IncreaseStat(lplr, "Kills", 50)
                                    HandleDataModule.IncreaseStat(lplr, "Headshots", 50)
                                end
                                if HandleDataModule.AwardXP then
                                    HandleDataModule.AwardXP(lplr, 500, "Exploiting", 100)
                                end
                            end)
                        end
                        
                        -- 2. Direct Zombie Execution (Real Kills + Server XP)
                        -- Instead of trying to forge a generic ETC request, we find real spawned zombies
                        -- and hit them with infinite damage using the specific signature the server expects
                        local zombies = workspace:FindFirstChild("Zombies")
                        if zombies and etcEvent then
                            for _, z in ipairs(zombies:GetChildren()) do
                                local hum = z:FindFirstChild("Humanoid")
                                if hum and hum.Health > 0 then
                                    pcall(function()
                                        -- { Zombie, Damage, "Damage5(logo)", HeadshotBool, false, false, PartHit, DirectionVector, {} }
                                        etcEvent:FireServer({ hum, math.huge, "Damage5\240\159\144\153", true, false, false, z:FindFirstChild("Head") or z:FindFirstChild("Torso"), Vector3.new(0, -1, 0), {} })
                                    end)
                                end
                            end
                        end
                        
                        task.wait(0.2)
                    end
                end)
            end
        end,
        Tooltip = "Rapidly spoofs kills, headshots, and XP by locally exploiting data and executing all zombies."
    })
end)

-- Zombies Object ESP (Mystery Box, Pack-a-Punch, Power)
run(function()
    local ZombiesESPModule
    local ShowMysteryBox
    local ShowPackAPunch
    local ShowPowerBox
    
    local espDrawings = {}

    local function createESP(obj, name, color)
        local text = Drawing.new("Text")
        text.Text = name
        text.Size = 20
        text.Center = true
        text.Outline = true
        text.Color = color
        text.Visible = false
        
        table.insert(espDrawings, {
            obj = obj,
            drawing = text,
            type = name
        })
    end

    local function scanObjects()
        -- Clear old
        for _, v in ipairs(espDrawings) do
            if v.drawing then
                v.drawing.Visible = false
                v.drawing:Remove()
            end
        end
        espDrawings = {}
        
        -- Power Box
        local power = workspace:FindFirstChild("Power") or (workspace:FindFirstChild("Interactions") and workspace.Interactions:FindFirstChild("Power"))
        if power then
            createESP(power, "Power Box", Color3.fromRGB(255, 255, 0))
        end
        
        -- Interactions (Mystery Box, Pack-A-Punch)
        local interactions = workspace:FindFirstChild("Interactions")
        if interactions then
            for _, v in ipairs(interactions:GetChildren()) do
                local nameLower = string.lower(v.Name)
                if string.find(nameLower, "mystery") then
                    createESP(v, "Mystery Box", Color3.fromRGB(150, 0, 255))
                elseif string.find(nameLower, "pack") or string.find(nameLower, "punch") or string.find(string.upper(v.Name), "PAP") then
                    createESP(v, "Pack-a-Punch", Color3.fromRGB(0, 255, 255))
                end
            end
        end
    end

    local function updateESP()
        local camera = workspace.CurrentCamera
        if not camera then return end
        
        for _, esp in ipairs(espDrawings) do
            local obj = esp.obj
            local shouldShow = false
            
            if esp.type == "Mystery Box" and ShowMysteryBox.Enabled then shouldShow = true end
            if esp.type == "Pack-a-Punch" and ShowPackAPunch.Enabled then shouldShow = true end
            if esp.type == "Power Box" and ShowPowerBox.Enabled then shouldShow = true end
            
            if shouldShow and obj and obj.Parent then
                local pos
                if obj:IsA("Model") and obj.PrimaryPart then
                    pos = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    -- Get first part
                    local part = obj:FindFirstChildWhichIsA("BasePart", true)
                    if part then pos = part.Position end
                elseif obj:IsA("BasePart") then
                    pos = obj.Position
                end
                
                if pos then
                    local vector, onScreen = camera:WorldToViewportPoint(pos)
                    if onScreen then
                        esp.drawing.Position = Vector2.new(vector.X, vector.Y)
                        esp.drawing.Visible = true
                    else
                        esp.drawing.Visible = false
                    end
                else
                    esp.drawing.Visible = false
                end
            else
                esp.drawing.Visible = false
            end
        end
    end

    ZombiesESPModule = vape.Categories.Render:CreateModule({
        Name = "Zombies ESP",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    scanObjects()
                    while ZombiesESPModule.Enabled do
                        updateESP()
                        task.wait()
                    end
                end)
                
                -- Refresh periodically in case box moves
                task.spawn(function()
                    while ZombiesESPModule.Enabled do
                        task.wait(5)
                        scanObjects()
                    end
                end)
            else
                for _, v in ipairs(espDrawings) do
                    if v.drawing then
                        v.drawing.Visible = false
                        v.drawing:Remove()
                    end
                end
                espDrawings = {}
            end
        end,
        Tooltip = "Shows ESP for important Zombie map locations."
    })
    
    ShowMysteryBox = ZombiesESPModule:CreateToggle({
        Name = "Mystery Box",
        Function = function() end,
        Default = true
    })
    
    ShowPackAPunch = ZombiesESPModule:CreateToggle({
        Name = "Pack-a-Punch",
        Function = function() end,
        Default = true
    })
    
    ShowPowerBox = ZombiesESPModule:CreateToggle({
        Name = "Power Box",
        Function = function() end,
        Default = true
    })
end)
