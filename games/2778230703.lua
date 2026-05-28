local run = function(func)
    func()
end
local cloneref = cloneref or function(obj)
    return obj
end

local playersService = cloneref(game:GetService("Players"))
local inputService = cloneref(game:GetService("UserInputService"))
local replicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local runService = cloneref(game:GetService("RunService"))

local lplr = playersService.LocalPlayer
local vape = shared.vape

-- Gun Mods (Infinite Ammo, Fire Rate, Recoil, Spread)
run(function()
    local GunModsModule
    local InfiniteAmmo
    local NoRecoil
    local NoSpread
    local InstantReload
    local AutoFire
    
    local originalSettings = {}
    local hookedGuns = {}

    local function ApplyMods(gunModel)
        if not gunModel then return end
        local gunScript = gunModel:FindFirstChild("GunScript") or gunModel:FindFirstChild("RealisticV4")
        if not gunScript then return end
        
        -- Find the environment or required module that holds the gun stats.
        -- Often these games use a module in ReplicatedStorage for Weapon stats, 
        -- but if the client has direct access to them, we can modify them via getrenv/getupvalue/etc.
        
        -- The decompiled scripts indicate there's a WeaponModule and a RealisticV4 script.
        -- We will loop through the localplayer's weapons and modify the configuration.
        task.spawn(function()
            local env = getsenv and getsenv(gunScript)
            if env and env.u47 then -- u47 seems to be the gun configuration table from decompiled script
                if not originalSettings[gunModel] then
                    originalSettings[gunModel] = {
                        FreeAmmo = env.u47.FreeAmmo,
                        Recoil = env.u47.Recoil,
                        Spread = env.u47.Spread,
                        ReloadTime = env.u47.ReloadTime,
                        AutoFire = env.u47.AutoFire
                    }
                end
                
                if InfiniteAmmo.Enabled then
                    env.u47.FreeAmmo = true
                else
                    env.u47.FreeAmmo = originalSettings[gunModel].FreeAmmo
                end
                
                if NoRecoil.Enabled then
                    env.u47.Recoil = 0
                    env.u47.CameraRecoil = 0
                else
                    env.u47.Recoil = originalSettings[gunModel].Recoil
                end
                
                if NoSpread.Enabled then
                    env.u47.Spread = 0
                    env.u47.MinSpread = 0
                    env.u47.MaxSpread = 0
                else
                    env.u47.Spread = originalSettings[gunModel].Spread
                end
                
                if AutoFire.Enabled then
                    env.u47.Auto = true
                    env.u47.FireType = "Auto"
                end
            end
        end)
    end

    local function HookGuns()
        local char = lplr.Character
        if char then
            for _, v in ipairs(char:GetChildren()) do
                if v:IsA("Tool") and not hookedGuns[v] then
                    hookedGuns[v] = true
                    ApplyMods(v)
                end
            end
        end
        
        local cam = workspace.CurrentCamera
        if cam then
            for _, v in ipairs(cam:GetChildren()) do
                if v:IsA("Model") and not hookedGuns[v] then
                    hookedGuns[v] = true
                    ApplyMods(v)
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
                        HookGuns()
                        task.wait(1)
                    end
                end)
            else
                for gun, orig in pairs(originalSettings) do
                    local gunScript = gun:FindFirstChild("GunScript") or gun:FindFirstChild("RealisticV4")
                    if gunScript then
                        local env = getsenv and getsenv(gunScript)
                        if env and env.u47 then
                            env.u47.FreeAmmo = orig.FreeAmmo
                            env.u47.Recoil = orig.Recoil
                            env.u47.Spread = orig.Spread
                        end
                    end
                end
                table.clear(hookedGuns)
                table.clear(originalSettings)
            end
        end,
        Tooltip = "Modifies your gun's stats"
    })
    
    InfiniteAmmo = GunModsModule:CreateToggle({
        Name = "Infinite Ammo",
        Function = function() end
    })
    
    NoRecoil = GunModsModule:CreateToggle({
        Name = "No Recoil",
        Function = function() end
    })
    
    NoSpread = GunModsModule:CreateToggle({
        Name = "No Spread",
        Function = function() end
    })
    
    AutoFire = GunModsModule:CreateToggle({
        Name = "Auto Fire",
        Function = function() end
    })
end)

-- InstaKill (Headshots)
run(function()
    local InstaKill
    
    InstaKill = vape.Categories.Combat:CreateModule({
        Name = "InstaKill",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    while InstaKill.Enabled do
                        local char = lplr.Character
                        local cam = workspace.CurrentCamera
                        
                        -- Find currently equipped gun config
                        local currentGun = nil
                        if cam then
                            for _, v in ipairs(cam:GetChildren()) do
                                if v:IsA("Model") and (v:FindFirstChild("GunScript") or v:FindFirstChild("RealisticV4")) then
                                    currentGun = v
                                    break
                                end
                            end
                        end
                        
                        if currentGun then
                            local gunScript = currentGun:FindFirstChild("GunScript") or currentGun:FindFirstChild("RealisticV4")
                            local env = getsenv and getsenv(gunScript)
                            if env and env.u47 then
                                env.u47.Damage = 99999
                                env.u47.Headshot = 99999
                            end
                        end
                        
                        task.wait(1)
                    end
                end)
            end
        end,
        Tooltip = "Modifies gun damage to instantly kill zombies."
    })
end)

-- Lobby Exploits
run(function()
    local InfiniteTokens
    local CaseSpammer
    
    InfiniteTokens = vape.Categories.Utility:CreateModule({
        Name = "Infinite Tokens",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    local events = replicatedStorage:FindFirstChild("Events")
                    local gunCamos = events and events:FindFirstChild("GunCamos")
                    
                    if gunCamos then
                        -- Exploit 1: Admin Code Creation Abuse
                        -- Creates a custom code and redeems it
                        local codeName = "VAPE_" .. tostring(math.random(1000, 9999))
                        pcall(function()
                            gunCamos:InvokeServer(5, codeName, "9999", "99999")
                            gunCamos:InvokeServer(4, codeName)
                        end)
                        
                        -- Exploit 2: Daily Reward Spam
                        pcall(function()
                            gunCamos:InvokeServer(8)
                        end)
                    end
                    
                    InfiniteTokens:ToggleButton(false)
                end)
            end
        end,
        Tooltip = "Exploits remote vulnerabilities to give you infinite Z-Tokens."
    })
    
    local caseDropdown
    local selectedCase = "Daily Shop"
    local casesList = {
        "Christmas 2023", "Christmas 2024", "Daily Shop", "Radiant", "Aether",
        "Community", "Community 2", "Community 3", "Aether Charms", "Shimmer",
        "Redux", "Material", "Hardened", "Charms", "Halloween 2024",
        "Valentine's Day 2024", "St. Patrick's Day 2024", "Daily Shop Charms",
        "Letter", "Power Up", "Sinister", "Valentine's Charms", "Sk8ter", "Boot Camp", "X-mas '25"
    }
    
    CaseSpammer = vape.Categories.Utility:CreateModule({
        Name = "Case Spammer",
        Function = function(callback)
            if callback then
                task.spawn(function()
                    local gunCamos = replicatedStorage:FindFirstChild("Events") and replicatedStorage.Events:FindFirstChild("GunCamos")
                    while CaseSpammer.Enabled and gunCamos do
                        pcall(function()
                            gunCamos:InvokeServer(3, selectedCase)
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end,
        Tooltip = "Spams opening the selected case. Works best with Infinite Tokens."
    })
    
    caseDropdown = CaseSpammer:CreateDropdown({
        Name = "Case",
        List = casesList,
        Function = function(val)
            selectedCase = val
        end
    })
end)
