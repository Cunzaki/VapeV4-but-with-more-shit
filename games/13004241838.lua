local playersService = cloneref(game:GetService('Players'))
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity

if not vape.Categories.Minigames then
    vape.Categories.Minigames = vape:CreateCategory({
        Name = 'Minigames',
        Icon = 'vape/assets/new/minigames.png'
    })
end

local minigames = vape.Categories.Minigames

-- 1. First: Adonis Bypass using user's method
local function BypassAdonis()
    local getinfo = getinfo or debug.getinfo
    local DEBUG = false
    local Hooked = {}
    local Detected, Kill

    -- Set thread identity to access internal tables (if supported)
    pcall(function() setthreadidentity(2) end)

    -- Scan Garbage Collection for the Adonis Client Table
    for i, v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            local DetectFunc = rawget(v, "Detected")
            local KillFunc = rawget(v, "Kill")
            local RemoteSend = rawget(v, "Send")

            -- Hook the 'Detected' function (Reporting)
            if typeof(DetectFunc) == "function" and not Detected then
                Detected = DetectFunc
                local Old
                Old = hookfunction(Detected, function(Action, Info, NoCrash)
                    if Action ~= "_" and DEBUG then
                        -- print("Blocked detection:", Action)
                    end
                    return true
                end)
                table.insert(Hooked, { Detected, Old })
            end

            -- Hook the 'Kill' function (The Kick/Crash mechanism)
            if typeof(KillFunc) == "function" and not Kill then
                Kill = KillFunc
                local Old
                Old = hookfunction(Kill, function(Info)
                    if DEBUG then
                        -- print("Blocked kill:", Info)
                    end
                end)
                table.insert(Hooked, { Kill, Old })
            end

            -- Also hook Remote.Send if available
            if typeof(RemoteSend) == "function" and v.Remote then
                local OldSend
                OldSend = hookfunction(RemoteSend, function(p1, ...)
                    if p1 == "Detected" or p1 == "LogError" or p1 == "Log" then
                        return nil
                    end
                    return OldSend(p1, ...)
                end)
                table.insert(Hooked, { RemoteSend, OldSend })
            end
        end
    end

    -- Hook debug.info to bypass integrity checks
    if debug and debug.info then
        local OldInfo
        OldInfo = hookfunction(debug.info, newcclosure(function(...)
            local LevelOrFunc, Info = ...
            if Detected and LevelOrFunc == Detected then
                return coroutine.yield(coroutine.running())
            end
            return OldInfo(...)
        end))
        table.insert(Hooked, { debug.info, OldInfo })
    end

    -- Also block remote traffic
    local originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
            if typeof(args[1]) == "table" and args[1].Mode and args[1].Sent and args[1].Received then
                return nil
            end
        end
        return originalNamecall(self, ...)
    end)
    table.insert(Hooked, { "__namecall", originalNamecall })

    -- And block speed checks
    if workspace.GetRealPhysicsFPS then
        local oldFPS = hookinstancemethod(workspace, "GetRealPhysicsFPS", function()
            return 60
        end)
        table.insert(Hooked, { "GetRealPhysicsFPS", oldFPS })
    end

    -- And block exploit object detection
    local oldFFC = hookinstancemethod(game, "FindFirstChild", function(self, name, recursive)
        if not checkcaller() and recursive then
            if name:find("Spy") or name:find("Exploit") or name:find("Dumper") then
                return nil
            end
        end
        return oldFFC(self, name, recursive)
    end)
    table.insert(Hooked, { "FindFirstChild", oldFFC })

    pcall(function() setthreadidentity(7) end)

    -- Return cleanup function
    return function()
        for _, h in ipairs(Hooked) do
            if h[1] == "__namecall" then
                hookmetamethod(game, "__namecall", h[2])
            elseif typeof(h[1]) == "function" and h[2] then
                hookfunction(h[1], h[2])
            elseif h[1] == "GetRealPhysicsFPS" then
                hookinstancemethod(workspace, "GetRealPhysicsFPS", h[2])
            elseif h[1] == "FindFirstChild" then
                hookinstancemethod(game, "FindFirstChild", h[2])
            end
        end
    end
end

minigames:CreateModule({
    Name = 'Anticheat Bypass',
    Function = function(enabled)
        if enabled then
            return BypassAdonis()
        end
    end,
    Tooltip = 'Comprehensive Adonis bypass using GC scanning.'
})

-- 2. Fast-updating team check
local origGetColor = entitylib.getEntityColor
local origTargetCheck = entitylib.targetCheck

minigames:CreateModule({
    Name = 'Team Check',
    Function = function(enabled)
        if enabled then
            -- Fast update every frame
            local conn = game:GetService('RunService').Heartbeat:Connect(function() end)

            entitylib.getEntityColor = function(ent)
                if ent.Player and ent.Player.Character then
                    local torso = ent.Player.Character:FindFirstChild("Torso") or ent.Player.Character:FindFirstChild("UpperTorso")
                    if torso then
                        return torso.Color
                    end
                end
                return origGetColor(ent)
            end

            entitylib.targetCheck = function(ent)
                -- Check forcefield
                if ent.Player and ent.Player.Character and ent.Player.Character:FindFirstChild("ForceField") then
                    return false
                end

                -- Check team color
                if lplr.Character and ent.Player and ent.Player.Character then
                    local myTorso = lplr.Character:FindFirstChild("Torso") or lplr.Character:FindFirstChild("UpperTorso")
                    local theirTorso = ent.Player.Character:FindFirstChild("Torso") or ent.Player.Character:FindFirstChild("UpperTorso")

                    if myTorso and theirTorso then
                        local t = 0.2
                        local mc = myTorso.Color
                        local tc = theirTorso.Color
                        if math.abs(mc.R-tc.R) < t and math.abs(mc.G-tc.G) < t and math.abs(mc.B-tc.B) < t then
                            return false
                        end
                    end
                end

                return origTargetCheck(ent)
            end

            return function()
                conn:Disconnect()
                entitylib.getEntityColor = origGetColor
                entitylib.targetCheck = origTargetCheck
            end
        end
    end,
    Tooltip = 'Fast-updating team/forcefield check.'
})

-- 3. Stealthy gun exploits
minigames:CreateModule({
    Name = 'Gun Exploits',
    Function = function(enabled)
        if enabled then
            local activeGuns = {}
            local ammoConns = {}
            local childConns = {}

            local function hookGun(gun)
                if not gun or activeGuns[gun] then return end
                local setts = gun:FindFirstChild("settings")
                if not setts then return end

                local s, r = pcall(function()
                    local ret = require(setts)
                    if not ret or not ret.returnclientcopy then return nil end
                    local origCopy = ret.returnclientcopy

                    activeGuns[gun] = {
                        ret = ret,
                        origCopy = origCopy,
                        origCool = ret.gun_data and ret.gun_data.cooldown or 0.08,
                        origSpreadX = ret.gun_data and ret.gun_data.SpreadX or 0,
                        origSpreadY = ret.gun_data and ret.gun_data.SpreadY or 0,
                        origRecoil = ret.gun_data and ret.gun_data.cam_recoil or 0,
                        origMaxAmmo = ret.gun_data and ret.gun_data.maxammo or 30
                    }

                    if ret.gun_data then
                        ret.gun_data.cooldown = 0.001
                        ret.gun_data.SpreadX = 0
                        ret.gun_data.SpreadY = 0
                        ret.gun_data.cam_recoil = 0
                    end

                    ret.returnclientcopy = function(self, k)
                        local d = origCopy(self, k)
                        if k == "gun_data" then
                            d.cooldown = 0.001
                            d.SpreadX = 0
                            d.SpreadY = 0
                            d.cam_recoil = 0
                        end
                        return d
                    end

                    return activeGuns[gun]
                end)

                if not s or not r then return end

                -- Infinite ammo
                local ammo = gun:FindFirstChild("ammo")
                if ammo and ammo:IsA("IntValue") then
                    local max = r.origMaxAmmo or 30
                    ammo.Value = max
                    local conn = ammo.Changed:Connect(function()
                        ammo.Value = max
                    end)
                    table.insert(ammoConns, conn)
                end
            end

            -- Hook existing
            for _, t in ipairs(lplr.Backpack:GetChildren()) do
                if t:IsA("Tool") then hookGun(t) end
            end
            if lplr.Character then
                for _, t in ipairs(lplr.Character:GetChildren()) do
                    if t:IsA("Tool") then hookGun(t) end
                end
            end

            -- Hook new
            local bpConn = lplr.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then task.wait(0.1); hookGun(child) end
            end)
            table.insert(childConns, bpConn)

            if lplr.Character then
                local charConn = lplr.Character.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then task.wait(0.1); hookGun(child) end
                end)
                table.insert(childConns, charConn)
            end

            local charAddConn = lplr.CharacterAdded:Connect(function(char)
                local cConn = char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then task.wait(0.1); hookGun(child) end
                end)
                table.insert(childConns, cConn)
            end)
            table.insert(childConns, charAddConn)

            return function()
                for gun, d in pairs(activeGuns) do
                    if d.ret and d.ret.gun_data then
                        d.ret.gun_data.cooldown = d.origCool
                        d.ret.gun_data.SpreadX = d.origSpreadX
                        d.ret.gun_data.SpreadY = d.origSpreadY
                        d.ret.gun_data.cam_recoil = d.origRecoil
                    end
                    if d.ret and d.origCopy then
                        d.ret.returnclientcopy = d.origCopy
                    end
                end
                for _, c in ipairs(ammoConns) do c:Disconnect() end
                for _, c in ipairs(childConns) do c:Disconnect() end
                activeGuns = {}; ammoConns = {}; childConns = {}
            end
        end
    end,
    Tooltip = 'Rapid Fire, No Spread, No Recoil, Infinite Ammo.'
})

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
