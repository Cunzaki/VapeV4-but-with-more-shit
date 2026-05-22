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

-- First: Comprehensive, stealthy anticheat bypass
local bypassActive = false
local originalFindFirstChild = nil
local originalGetRealPhysicsFPS = nil
local originalNamecall = nil
local savedEnv = nil

minigames:CreateModule({
    Name = 'Anticheat Bypass',
    Function = function(enabled)
        if enabled and not bypassActive then
            bypassActive = true
            
            -- 1. Hook FindFirstChild to hide exploit objects
            originalFindFirstChild = hookinstancemethod(game, "FindFirstChild", function(self, name, recursive)
                if not checkcaller() and recursive then
                    if name == "SentinelSpy"
                    or name == "ScriptDumper"
                    or name == "SimpleSpy"
                    or name == "SimpleSpyV2"
                    or name == "SimpleSpyV3"
                    or name:find("Spy")
                    or name:find("Exploit") then
                        return nil
                    end
                end
                return originalFindFirstChild(self, name, recursive)
            end)
            
            -- 2. Hook GetRealPhysicsFPS for speed check bypass
            originalGetRealPhysicsFPS = hookinstancemethod(workspace, "GetRealPhysicsFPS", function(self)
                return 60
            end)
            
            -- 3. Hook __namecall to block all Adonis remote traffic
            originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
                    -- Block Adonis-style remote packets
                    if typeof(args[1]) == "table" and args[1].Mode and args[1].Sent and args[1].Received then
                        return nil
                    end
                end
                
                return originalNamecall(self, ...)
            end)
            
            -- 4. Try to hook the Adonis client table if it exists
            task.spawn(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "Anti") and rawget(v, "Remote") and rawget(v, "Core") then
                        -- Found Adonis!
                        if v.Anti.Detected then
                            local oldDetect = v.Anti.Detected
                            v.Anti.Detected = function(...)
                                return true
                            end
                        end
                        if v.Disconnect then
                            local oldDisc = v.Disconnect
                            v.Disconnect = function() end
                        end
                        if v.Kill then
                            local oldKill = v.Kill
                            v.Kill = function() end
                        end
                        if v.Remote.Send then
                            local oldSend = v.Remote.Send
                            v.Remote.Send = function(p1, ...)
                                if p1 == "Detected" or p1 == "LogError" or p1 == "Log" then
                                    return
                                end
                                return oldSend(p1, ...)
                            end
                        end
                        break
                    end
                end
            end)
            
            return function()
                bypassActive = false
                hookinstancemethod(game, "FindFirstChild", originalFindFirstChild)
                hookinstancemethod(workspace, "GetRealPhysicsFPS", originalGetRealPhysicsFPS)
                hookmetamethod(game, "__namecall", originalNamecall)
            end
        end
    end,
    Tooltip = 'Comprehensive bypass for Adonis anticheat.'
})

-- Fast-updating team check
local origGetColor = entitylib.getEntityColor
local origTargetCheck = entitylib.targetCheck
local lastUpdate = 0

minigames:CreateModule({
    Name = 'Team Check',
    Function = function(enabled)
        if enabled then
            -- Fast update loop for colors
            local conn = game:GetService('RunService').Heartbeat:Connect(function()
                lastUpdate = tick()
            end)
            
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
                -- Check forcefield first
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
                
                -- Fallback
                return origTargetCheck(ent)
            end
            
            return function()
                conn:Disconnect()
                entitylib.getEntityColor = origGetColor
                entitylib.targetCheck = origTargetCheck
            end
        end
    end,
    Tooltip = 'Fast-updating team check with forcefield support.'
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
