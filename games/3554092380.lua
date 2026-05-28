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

-- No Env/Explosive Damage
run(function()
    local NoEnvDamage
    local origExplosion = nil
    
    NoEnvDamage = vape.Categories.Combat:CreateModule({
        Name = "No Env Damage",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    -- Disable explosive damage via hooking Functions.Explosion
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
                    
                    while NoEnvDamage.Enabled do
                        local lavaFolder = workspace:FindFirstChild("Lava")
                        if lavaFolder then
                            for _, v in ipairs(lavaFolder:GetDescendants()) do
                                if v:IsA("BasePart") and v.CanTouch then
                                    v.CanTouch = false
                                end
                            end
                        end
                        task.wait(1)
                    end
                end)
            else
                -- We leave CanTouch false since reverting it might be dangerous, 
                -- and disabling it doesn't hurt normal gameplay
            end
        end,
        Tooltip = "Disables Lava, Toxic Waste, Fire, and Explosive damage."
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
    
    local function applyGodMode()
        if GodMode.Enabled then
            if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
                lplr.Character.Humanoid.Health = lplr.Character.Humanoid.MaxHealth
            end
            
            -- Hook __namecall to block the ETC remote from sending damage ("DMS" or "Damage5")
            if not origNamecall and getgenv().hookmetamethod then
                pcall(function()
                    origNamecall = getgenv().hookmetamethod(game, "__namecall", function(self, ...)
                        local method = getnamecallmethod()
                        local args = {...}
                        
                        if GodMode and GodMode.Enabled and method == "FireServer" and self.Name == "ETC" then
                            if type(args[1]) == "table" then
                                local subArgs = args[1]
                                -- Block damage remotes (DMS = Damage Sync, Damage5 = Tutorial/Bridge damage sync)
                                if type(subArgs[#subArgs]) == "string" and (string.find(subArgs[#subArgs], "DMS") or string.find(subArgs[#subArgs], "Damage5")) then
                                    return -- Block the damage completely
                                end
                            end
                        end
                        
                        return origNamecall(self, ...)
                    end)
                end)
            end
        else
            -- We don't necessarily unhook namecall, just let GodMode.Enabled condition bypass it
        end
    end

    GodMode = vape.Categories.Combat:CreateModule({
        Name = "God Mode",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while GodMode.Enabled do
                        applyGodMode()
                        task.wait(0.01) -- Very fast loop to ensure we stay alive locally too
                    end
                end)
            else
                -- Nothing needed on disable
            end
        end,
        Tooltip = "Makes you invincible by blocking damage remotes to the server."
    })
end)

-- Infinite Points (Remote Event Abuse)
run(function()
    local InfPoints
    
    InfPoints = vape.Categories.Combat:CreateModule({
        Name = "Infinite Points",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    -- The ETC event is actually located in game.Lighting.ETC or game.ReplicatedStorage.Events.ETC depending on the game mode
                    local etcEvent = game:GetService("Lighting"):FindFirstChild("ETC") or (replicatedStorage:FindFirstChild("Events") and replicatedStorage.Events:FindFirstChild("ETC"))
                    
                    while InfPoints.Enabled do
                        if etcEvent then
                            -- Another method to get points is via the "Rewards8" event but the argument format is tricky
                            -- Some variants use { 0, amount, "Rewards8\240\159\144\153" }
                            pcall(function()
                                etcEvent:FireServer({ 0, 500, "Rewards8\240\159\144\153" })
                            end)
                        end
                        task.wait(0.1)
                    end
                end)
            end
        end,
        Tooltip = "Abuses the reward remote to rapidly give you points."
    })
end)
