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

local getupvalue = getupvalue or debug.getupvalue
local setupvalue = setupvalue or debug.setupvalue
local getsenv = getsenv or function() return {} end

-- Find active GunScripts in Camera or Character
local function getActiveGunScripts()
    local scripts = {}
    local camera = workspace.CurrentCamera
    if camera then
        for _, model in ipairs(camera:GetChildren()) do
            local gs = model:FindFirstChild("GunScript", true)
            if gs and gs:IsA("LocalScript") then
                table.insert(scripts, gs)
            end
        end
    end
    if lplr.Character then
        for _, tool in ipairs(lplr.Character:GetChildren()) do
            if tool:IsA("Tool") or tool:IsA("Model") then
                local gs = tool:FindFirstChild("GunScript", true)
                if gs and gs:IsA("LocalScript") then
                    table.insert(scripts, gs)
                end
            end
        end
    end
    return scripts
end

local originalU54s = {}

-- Gun Mods (Infinite Ammo, Fire Rate, Recoil, Spread)
run(function()
    local GunModsModule
    local InfiniteAmmo
    local NoRecoil
    local NoSpread
    local FastFireRate
    
    local function applyMods()
        local multiplier = GunModsModule.Enabled and FastFireRate.Value or 1
        
        -- 1. Modify gunConfigs (for when the user equips a new gun)
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
        
        -- 2. Modify currently active GunScript upvalues instantly
        for _, gs in ipairs(getActiveGunScripts()) do
            pcall(function()
                local env = getsenv(gs)
                if env and env.checkFirerate then
                    -- checkFirerate has 4 upvalues: u107, u35(RPM), u49(RPM2), u54(Original Base RPM)
                    local _, u54_val = getupvalue(env.checkFirerate, 4)
                    
                    if type(u54_val) == "number" then
                        local origRPM = originalU54s[gs]
                        local currentExpectedRPM = origRPM and (origRPM / multiplier) or nil
                        
                        -- If we haven't stored it yet, or if u54_val changed significantly (meaning equip() reset it)
                        if not origRPM or math.abs(u54_val - currentExpectedRPM) > 0.0001 then
                            originalU54s[gs] = u54_val
                            origRPM = u54_val
                        end
                        
                        local targetRPM = origRPM / multiplier
                        
                        -- Set u35, u49, u54 to the target RPM
                        setupvalue(env.checkFirerate, 2, targetRPM)
                        setupvalue(env.checkFirerate, 3, targetRPM)
                        setupvalue(env.checkFirerate, 4, targetRPM)
                    end
                end
            end)
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
                        task.wait(0.05)
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
