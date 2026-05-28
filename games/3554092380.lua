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

local function getWeaponModule()
    local weaponModule = replicatedStorage:FindFirstChild("WeaponModule")
    if weaponModule then
        local success, result = pcall(function()
            return require(weaponModule)
        end)
        if success and type(result) == "table" and result.Weapons then
            return result.Weapons
        end
    end
    return nil
end

local originalSettings = {}
local gunConfigs = {}

-- Directly require the module to change the guns permanently.
local function scanForGunConfigs()
    local weapons = getWeaponModule()
    if weapons then
        for name, config in pairs(weapons) do
            if type(config) == "table" and config.Damage then
                if not originalSettings[config] then
                    table.insert(gunConfigs, config)
                    originalSettings[config] = {
                        FreeAmmo = config.FreeAmmo,
                        Recoil = config.Recoil,
                        CameraRecoil = config.CameraRecoil,
                        RecoilReduc = config.RecoilReduc,
                        Spread = config.Spread,
                        MinSpread = config.MinSpread,
                        MaxSpread = config.MaxSpread,
                        Auto = config.Auto,
                        FireType = config.FireType,
                        Damage = config.Damage,
                        Headshot = config.Headshot
                    }
                end
            end
        end
    end
end

-- Gun Mods (Infinite Ammo, Fire Rate, Recoil, Spread)
run(function()
    local GunModsModule
    local InfiniteAmmo
    local NoRecoil
    local NoSpread
    local AutoFire
    
    local function applyMods()
        scanForGunConfigs()
        for _, config in ipairs(gunConfigs) do
            local orig = originalSettings[config]
            if orig then
                if GunModsModule.Enabled then
                    if InfiniteAmmo.Enabled then 
                        config.FreeAmmo = true 
                    else 
                        config.FreeAmmo = orig.FreeAmmo 
                    end
                    
                    if NoRecoil.Enabled then 
                        config.Recoil = {0,0,0}
                        config.CameraRecoil = {0,0,0}
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
                    
                    if AutoFire.Enabled then 
                        config.Auto = true
                        config.FireType = "Auto" 
                    else 
                        config.Auto = orig.Auto
                        config.FireType = orig.FireType 
                    end
                else
                    config.FreeAmmo = orig.FreeAmmo
                    config.Recoil = orig.Recoil
                    config.CameraRecoil = orig.CameraRecoil
                    config.RecoilReduc = orig.RecoilReduc
                    config.Spread = orig.Spread
                    config.MinSpread = orig.MinSpread
                    config.MaxSpread = orig.MaxSpread
                    config.Auto = orig.Auto
                    config.FireType = orig.FireType
                end
            end
        end
    end

    GunModsModule = vape.Categories.Combat:CreateModule({
        Name = "GunMods",
        Function = function(callback)
            if callback then
                task.spawn(function()
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
    
    AutoFire = GunModsModule:CreateToggle({
        Name = "Auto Fire",
        Function = function() applyMods() end
    })
end)

-- InstaKill (Headshots)
run(function()
    local InstaKill
    
    local function applyInstaKill()
        scanForGunConfigs()
        for _, config in ipairs(gunConfigs) do
            local orig = originalSettings[config]
            if orig then
                if InstaKill.Enabled then
                    config.Damage = 999999
                    config.Headshot = 999999
                else
                    config.Damage = orig.Damage
                    config.Headshot = orig.Headshot
                end
            end
        end
    end

    InstaKill = vape.Categories.Combat:CreateModule({
        Name = "InstaKill",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while InstaKill.Enabled do
                        applyInstaKill()
                        task.wait(1)
                    end
                end)
            else
                applyInstaKill()
            end
        end,
        Tooltip = "Modifies gun damage to instantly kill zombies."
    })
end)

-- Exploit Points/Powerups
run(function()
    local ClaimPoints
    ClaimPoints = vape.Categories.Combat:CreateModule({
        Name = "ClaimPoints",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while ClaimPoints.Enabled do
                        -- Looking through decompiled structure, powerups use ReplicatedStorage.Resources["Power-ups"].Event:FireServer(PowerupValue)
                        -- The powerup values are stored in ReplicatedStorage.PowerupInfo
                        local powerupInfo = replicatedStorage:FindFirstChild("PowerupInfo")
                        local powerupsEvent = replicatedStorage:FindFirstChild("Resources") and replicatedStorage.Resources:FindFirstChild("Power-ups") and replicatedStorage.Resources["Power-ups"]:FindFirstChild("Event")
                        
                        if powerupInfo and powerupsEvent then
                            for _, powerupValue in ipairs(powerupInfo:GetChildren()) do
                                pcall(function()
                                    powerupsEvent:FireServer(powerupValue)
                                end)
                            end
                        end
                        task.wait(0.2)
                    end
                end)
            end
        end,
        Tooltip = "Attempts to exploit points via remote events"
    })
end)
