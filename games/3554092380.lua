local run = function(func)
    func()
end
local cloneref = cloneref or function(obj)
    return obj
end

local playersService = cloneref(game:GetService("Players"))
local lplr = playersService.LocalPlayer
local vape = shared.vape

local originalSettings = {}
local gunConfigs = {}

-- Safely scan memory for the weapon configuration tables.
-- This bypasses the "getsenv (inactive script)" error entirely!
local function scanForGunConfigs()
    for _, v in ipairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Damage") ~= nil and rawget(v, "Recoil") ~= nil and rawget(v, "Headshot") ~= nil and rawget(v, "Spread") ~= nil then
            if not table.find(gunConfigs, v) then
                table.insert(gunConfigs, v)
                originalSettings[v] = {
                    FreeAmmo = rawget(v, "FreeAmmo"),
                    Recoil = rawget(v, "Recoil"),
                    CameraRecoil = rawget(v, "CameraRecoil"),
                    Spread = rawget(v, "Spread"),
                    MinSpread = rawget(v, "MinSpread"),
                    MaxSpread = rawget(v, "MaxSpread"),
                    Auto = rawget(v, "Auto"),
                    FireType = rawget(v, "FireType"),
                    Damage = rawget(v, "Damage"),
                    Headshot = rawget(v, "Headshot")
                }
            end
        end
    end
end

-- Hook when a new gun is equipped to rescan memory
local function setupCharacter(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            task.delay(0.5, function()
                scanForGunConfigs()
            end)
        end
    end)
end

if lplr.Character then
    setupCharacter(lplr.Character)
end
lplr.CharacterAdded:Connect(setupCharacter)


-- Gun Mods (Infinite Ammo, Fire Rate, Recoil, Spread)
run(function()
    local GunModsModule
    local InfiniteAmmo
    local NoRecoil
    local NoSpread
    local AutoFire
    
    local function applyMods()
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
                        config.Recoil = 0
                        config.CameraRecoil = 0 
                    else 
                        config.Recoil = orig.Recoil
                        config.CameraRecoil = orig.CameraRecoil 
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
                    scanForGunConfigs()
                    while GunModsModule.Enabled do
                        applyMods()
                        task.wait(0.5)
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
                    scanForGunConfigs()
                    while InstaKill.Enabled do
                        applyInstaKill()
                        task.wait(0.5)
                    end
                end)
            else
                applyInstaKill()
            end
        end,
        Tooltip = "Modifies gun damage to instantly kill zombies."
    })
end)
