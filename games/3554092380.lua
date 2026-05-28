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
                    -- checkFirerate is a global function inside the script's environment.
                    -- It accesses u35, u49, u54 which are the actual RPM variables used in the firing loop!
                    
                    -- To ensure we aren't breaking anything, let's also hook the environment directly if possible
                    -- but modifying the upvalues of `checkFirerate` is the cleanest way to reach the main file's locals.
                    
                    local _, current_u35 = getupvalue(env.checkFirerate, 2)
                    local _, current_u49 = getupvalue(env.checkFirerate, 3)
                    local _, current_u54 = getupvalue(env.checkFirerate, 4)
                    
                    -- Some exploits map debug.getupvalue differently, so we also scan the whole function's upvalues
                    if current_u54 == nil then
                        for i = 1, 10 do
                            local name, val = getupvalue(env.checkFirerate, i)
                            if name == "u54" or (type(val) == "number" and val > 0.01 and val < 1) then
                                current_u54 = val
                                break
                            end
                        end
                    end
                    
                    if type(current_u54) == "number" then
                        local origRPM = originalU54s[gs]
                        
                        -- If we haven't stored it, or it changed significantly (meaning equip() reset it), store it
                        if not origRPM or math.abs(current_u54 - (origRPM / multiplier)) > 0.0001 then
                            if current_u54 > 0.001 then -- basic sanity check
                                originalU54s[gs] = current_u54
                                origRPM = current_u54
                            end
                        end
                        
                        if origRPM then
                            local targetRPM = origRPM / multiplier
                            
                            -- Set u35, u49, u54 to the target RPM directly
                            for i = 1, 10 do
                                local name, val = getupvalue(env.checkFirerate, i)
                                if type(val) == "number" and val > 0.001 and val < 1 then
                                    setupvalue(env.checkFirerate, i, targetRPM)
                                end
                            end
                            
                            -- Also set the main environment variables if they exist
                            pcall(function() env.u35 = targetRPM end)
                            pcall(function() env.u49 = targetRPM end)
                            pcall(function() env.u54 = targetRPM end)
                        end
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
