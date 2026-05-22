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

-- Minimal, error-free Adonis bypass for THIS specific game
local bypassCleanup = nil
minigames:CreateModule({
    Name = 'Anticheat Bypass',
    Function = function(enabled)
        if enabled then
            local hooked = {}

            -- 1. Scan GC for EXACT Adonis structure from decompiled files
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" then
                    -- Check for the specific Adonis client table: has Anti, Remote, Core, Functions, Disconnect, Kill
                    local hasAnti = rawget(v, "Anti") ~= nil
                    local hasRemote = rawget(v, "Remote") ~= nil
                    local hasCore = rawget(v, "Core") ~= nil
                    local hasDisconnect = rawget(v, "Disconnect") ~= nil
                    local hasKill = rawget(v, "Kill") ~= nil

                    if hasAnti and hasRemote and hasCore and hasDisconnect and hasKill then
                        -- Found EXACT Adonis table!

                        -- Hook Anti.Detected
                        if v.Anti and type(v.Anti) == "table" then
                            local detectFunc = v.Anti.Detected
                            if type(detectFunc) == "function" then
                                local oldDetect = detectFunc
                                v.Anti.Detected = function(...)
                                    return true
                                end
                                table.insert(hooked, function()
                                    v.Anti.Detected = oldDetect
                                end)
                            end
                        end

                        -- Hook Kill
                        if type(v.Kill) == "function" then
                            local oldKill = v.Kill
                            v.Kill = function(...)
                                return nil
                            end
                            table.insert(hooked, function()
                                v.Kill = oldKill
                            end)
                        end

                        -- Hook Disconnect
                        if type(v.Disconnect) == "function" then
                            local oldDisc = v.Disconnect
                            v.Disconnect = function(...)
                                return nil
                            end
                            table.insert(hooked, function()
                                v.Disconnect = oldDisc
                            end)
                        end

                        -- Hook Remote.Send if available
                        if v.Remote and type(v.Remote) == "table" and type(v.Remote.Send) == "function" then
                            local oldSend = v.Remote.Send
                            v.Remote.Send = function(p1, ...)
                                if p1 == "Detected" or p1 == "LogError" or p1 == "Log" then
                                    return nil
                                end
                                return oldSend(p1, ...)
                            end
                            table.insert(hooked, function()
                                v.Remote.Send = oldSend
                            end)
                        end

                        break
                    end
                end
            end

            -- 2. Also block Adonis remote traffic pattern (minimally)
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
                    if type(args[1]) == "table" and args[1].Mode and args[1].Sent and args[1].Received then
                        return nil
                    end
                end
                return oldNamecall(self, ...)
            end)
            table.insert(hooked, function()
                hookmetamethod(game, "__namecall", oldNamecall)
            end)

            -- Cleanup function
            bypassCleanup = function()
                for _, restore in ipairs(hooked) do
                    pcall(restore)
                end
                hooked = {}
            end

            return bypassCleanup
        else
            if bypassCleanup then
                bypassCleanup()
                bypassCleanup = nil
            end
        end
    end,
    Tooltip = 'Minimal, error-free Adonis bypass for this game.'
})

-- Fast-updating team check
local origGetColor = entitylib.getEntityColor
local origTargetCheck = entitylib.targetCheck

minigames:CreateModule({
    Name = 'Team Check',
    Function = function(enabled)
        if enabled then
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
                if ent.Player and ent.Player.Character and ent.Player.Character:FindFirstChild("ForceField") then
                    return false
                end

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
    Tooltip = 'Fast team/forcefield check.'
})

-- Stealthy gun exploits
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

            for _, t in ipairs(lplr.Backpack:GetChildren()) do
                if t:IsA("Tool") then hookGun(t) end
            end
            if lplr.Character then
                for _, t in ipairs(lplr.Character:GetChildren()) do
                    if t:IsA("Tool") then hookGun(t) end
                end
            end

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
