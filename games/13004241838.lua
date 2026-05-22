local loadstring = function(...)
	local res, err = loadstring(...)
	if err and vape then vape:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert') end
	return res
end
local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil and res ~= ''
end
local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function() return game:HttpGet('https://raw.githubusercontent.com/Cunzaki/VapeV4-but-with-more-shit/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true) end)
		if not suc or res == '404: Not Found' then error(res) end
		if path:find('.lua') then res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res end
		writefile(path, res)
	end
	return (func or readfile)(path)
end
local run = function(func) func() end
local cloneref = cloneref or function(obj) return obj end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))
local inputService = cloneref(game:GetService('UserInputService'))
local jointsService = cloneref(game:GetService('JointsService'))
local teamsService = cloneref(game:GetService('Teams'))
local lightingService = cloneref(game:GetService('Lighting'))
local starterGuiService = cloneref(game:GetService('StarterGui'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity

-- Create Minigames category if it doesn't exist
if not vape.Categories.Minigames then
    vape.Categories.Minigames = vape:CreateCategory({
        Name = 'Minigames',
        Icon = 'vape/assets/new/minigames.png'
    })
end

local minigames = vape.Categories.Minigames

-- Helper functions (local only to avoid detection)
local function getTorsoColor(player)
    if not player then return nil end
    local char = player.Character
    if not char then return nil end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso or not torso:IsA("BasePart") then return nil end
    return torso.Color
end

local function hasForceField(player)
    if not player then return false end
    local char = player.Character
    return char and char:FindFirstChild("ForceField") ~= nil
end

local function colorsSimilar(c1, c2, t)
    t = t or 0.2
    return math.abs(c1.R - c2.R) < t 
        and math.abs(c1.G - c2.G) < t 
        and math.abs(c1.B - c2.B) < t
end

-- Store original functions
local origGetColor = entitylib.getEntityColor
local origTargetCheck = entitylib.targetCheck

-- Team module (minimal, stealthy)
local teamCheckActive = false
local teamModule = minigames:CreateModule({
    Name = 'Team Check',
    Function = function(enabled)
        teamCheckActive = enabled
        if enabled then
            entitylib.getEntityColor = function(ent)
                if teamCheckActive then
                    local c = getTorsoColor(ent.Player)
                    if c then return c end
                end
                return origGetColor(ent)
            end
            
            entitylib.targetCheck = function(ent)
                if teamCheckActive then
                    if hasForceField(ent.Player) then return false end
                    local myC = getTorsoColor(lplr)
                    local theirC = getTorsoColor(ent.Player)
                    if myC and theirC and colorsSimilar(myC, theirC) then return false end
                end
                return origTargetCheck(ent)
            end
            
            teamModule:Clean(function()
                entitylib.getEntityColor = origGetColor
                entitylib.targetCheck = origTargetCheck
                teamCheckActive = false
            end)
        end
    end,
    Tooltip = 'Skips same-team and spawn-protected players, uses torso color for ESP.'
})

-- Gun exploits module (stealthy)
local rapidFireActive = false
local noSpreadActive = false
local noRecoilActive = false
local infAmmoActive = false

local gunExploits = minigames:CreateModule({
    Name = 'Gun Exploits',
    Function = function(enabled)
        rapidFireActive = enabled
        noSpreadActive = enabled
        noRecoilActive = enabled
        infAmmoActive = enabled
        
        local guns = {}
        local ammoConns = {}
        local childConns = {}
        
        local function hookGun(gun)
            if not gun or guns[gun] then return end
            local setts = gun:FindFirstChild("settings")
            if not setts then return end
            
            local s, r = pcall(function()
                local ret = require(setts)
                if not ret or not ret.returnclientcopy then return nil end
                local origCopy = ret.returnclientcopy
                
                guns[gun] = {
                    ret = ret,
                    origCopy = origCopy,
                    origCool = ret.gun_data and ret.gun_data.cooldown or 0.08,
                    origSpreadX = ret.gun_data and ret.gun_data.SpreadX or 0,
                    origSpreadY = ret.gun_data and ret.gun_data.SpreadY or 0,
                    origRecoil = ret.gun_data and ret.gun_data.cam_recoil or 0,
                    origMaxAmmo = ret.gun_data and ret.gun_data.maxammo or 30
                }
                
                if ret.gun_data then
                    if rapidFireActive then ret.gun_data.cooldown = 0.001 end
                    if noSpreadActive then ret.gun_data.SpreadX = 0; ret.gun_data.SpreadY = 0 end
                    if noRecoilActive then ret.gun_data.cam_recoil = 0 end
                end
                
                ret.returnclientcopy = function(self, k)
                    local d = origCopy(self, k)
                    if k == "gun_data" then
                        if rapidFireActive then d.cooldown = 0.001 end
                        if noSpreadActive then d.SpreadX = 0; d.SpreadY = 0 end
                        if noRecoilActive then d.cam_recoil = 0 end
                    end
                    return d
                end
                
                gunExploits:Clean(function()
                    ret.returnclientcopy = origCopy
                end)
                
                return guns[gun]
            end)
            
            if not s or not r then return end
            
            if infAmmoActive then
                local ammo = gun:FindFirstChild("ammo")
                if ammo and ammo:IsA("IntValue") then
                    local max = r.origMaxAmmo or 30
                    ammo.Value = max
                    local conn = ammo.Changed:Connect(function()
                        if infAmmoActive then ammo.Value = max end
                    end)
                    table.insert(ammoConns, conn)
                end
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
        
        gunExploits:Clean(function()
            for gun, d in pairs(guns) do
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
            guns = {}; ammoConns = {}; childConns = {}
            rapidFireActive = false; noSpreadActive = false; noRecoilActive = false; infAmmoActive = false
        end)
    end,
    Tooltip = 'Rapid Fire, No Spread, No Recoil, Infinite Ammo'
})

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
