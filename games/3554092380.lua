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
local rpmUpvalueTargets = {}

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
                    RPM = rawget(v, "RPM"),
                    RPM2 = rawget(v, "RPM2"),
                    PreshootFunc = rawget(v, "PreshootFunc")
                }
            end
        end
    end
end

-- Compatibility: use either getupvalue/setupvalue or debug.getupvalue/debug.setupvalue
local getupvalue = getupvalue or debug.getupvalue
local setupvalue = setupvalue or debug.setupvalue

-- Scan for functions that have RPM-related upvalues (u35, u49, u54)
local function scanForRPMUpvalues()
    rpmUpvalueTargets = {}
    for _, obj in ipairs(getgc(true)) do
        if type(obj) == "function" then
            local success, err = pcall(function()
                -- Check upvalues for numeric values that are typical RPM values (0.01 to 1.0)
                local upvalueIndex = 1
                while true do
                    local name, value = getupvalue(obj, upvalueIndex)
                    if not name and not value then break end -- Exit loop if no more upvalues
                    
                    -- Look for upvalues that are numbers in the typical RPM range
                    if type(value) == "number" and value >= 0.01 and value <= 1.0 then
                        -- Check if this function has multiple such upvalues (likely RPM vars)
                        table.insert(rpmUpvalueTargets, {
                            func = obj,
                            index = upvalueIndex,
                            originalValue = value
                        })
                    end
                    
                    upvalueIndex = upvalueIndex + 1
                end
            end)
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

-- Gun Mods (Infinite Ammo, Fire Rate, Recoil, Spread)
run(function()
    local GunModsModule
    local InfiniteAmmo
    local NoRecoil
    local NoSpread
    local FastFireRate
    
    local function applyMods()
        local Functions = getFunctionsModule()
        
        -- Modify config properties first
        for _, config in ipairs(gunConfigs) do
            local orig = originalSettings[config]
            if orig then
                if GunModsModule.Enabled then
                    -- Infinite Ammo: override PreshootFunc to always set FreeAmmo = true
                    if InfiniteAmmo.Enabled then 
                        local originalPreshoot = orig.PreshootFunc
                        config.PreshootFunc = function()
                            if originalPreshoot then
                                originalPreshoot()
                            end
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

                    -- Set both RPM and RPM2 for fire rate
                    config.RPM = FastFireRate.Value
                    config.RPM2 = FastFireRate.Value
                else
                    config.PreshootFunc = orig.PreshootFunc
                    config.Recoil = orig.Recoil
                    config.CameraRecoil = orig.CameraRecoil
                    config.RecoilReduc = orig.RecoilReduc
                    config.Spread = orig.Spread
                    config.MinSpread = orig.MinSpread
                    config.MaxSpread = orig.MaxSpread
                    config.RPM = orig.RPM
                    config.RPM2 = orig.RPM2
                end
            end
        end
        
        -- Now modify the upvalues (local variables) inside WeaponModule functions
        if GunModsModule.Enabled then
            for _, target in ipairs(rpmUpvalueTargets) do
                pcall(function()
                    setupvalue(target.func, target.index, FastFireRate.Value)
                end)
            end
        else
            -- Restore original upvalues
            for _, target in ipairs(rpmUpvalueTargets) do
                pcall(function()
                    setupvalue(target.func, target.index, target.originalValue)
                end)
            end
        end
    end

    GunModsModule = vape.Categories.Combat:CreateModule({
        Name = "GunMods",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    scanForGunConfigs()
                    scanForRPMUpvalues()
                    while GunModsModule.Enabled do
                        applyMods()
                        task.wait(0.05) -- Even faster updates for fire rate
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
        Name = "Fire Rate",
        Min = 0.01,
        Max = 0.5,
        Default = 0.1,
        Decimal = 100,
        Function = function(val) applyMods() end
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
                        task.wait(0.1)
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
    local ClaimPowerups
    ClaimPowerups = vape.Categories.Combat:CreateModule({
        Name = "Autoclaim Powerups",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while ClaimPowerups.Enabled do
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
        Tooltip = "Attempts to auto-claim powerups via remote events"
    })
end)
