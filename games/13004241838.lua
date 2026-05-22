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

-- Team color definitions from the user
local teamColors = {
    Yellow = Color3.fromRGB(251, 255, 11),
    Red = Color3.fromRGB(151, 0, 0),
    Blue = Color3.fromRGB(13, 105, 172)
}

-- Get player's team color from their Torso (or HumanoidRootPart for same-team check per gun_rules.lua)
local function getPlayerTeamColor(player)
    if not player then return nil end
    local char = player.Character
    if not char then return nil end
    
    -- Try Torso first, then UpperTorso
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso or not torso:IsA("BasePart") then return nil end
    
    return torso.Color
end

-- Check if player has ForceField (spawn protection)
local function playerHasForceField(player)
    if not player then return false end
    local char = player.Character
    if not char then return false end
    return char:FindFirstChild("ForceField") ~= nil
end

-- Check if two colors are similar (with tolerance for lighting/lighting effects)
local function colorsMatch(color1, color2, tolerance)
    tolerance = tolerance or 0.15
    return math.abs(color1.R - color2.R) < tolerance
        and math.abs(color1.G - color2.G) < tolerance
        and math.abs(color1.B - color2.B) < tolerance
end

-- Track active modules
local teamCheckActive = false
local noForceFieldActive = false
local rapidFireActive = false
local noSpreadActive = false
local noRecoilActive = false
local infiniteAmmoActive = false

-- Store original functions to restore
local originalGetEntityColor = entitylib.getEntityColor
local originalTargetCheck = entitylib.targetCheck

-- Combined module that handles team check and no forcefield
local teamAndForcefield = minigames:CreateModule({
    Name = 'Team + ForceField Check',
    Function = function(callback)
        if callback then
            teamCheckActive = true
            noForceFieldActive = true
            
            -- Override entity color to use torso colors
            entitylib.getEntityColor = function(ent)
                if teamCheckActive then
                    local playerColor = getPlayerTeamColor(ent.Player)
                    if playerColor then
                        return playerColor
                    end
                end
                return originalGetEntityColor(ent)
            end
            
            -- Override target check to use torso colors and skip forcefield players
            entitylib.targetCheck = function(ent)
                -- First check forcefield
                if noForceFieldActive and ent.Player and playerHasForceField(ent.Player) then
                    return false
                end
                
                -- Then check team
                if teamCheckActive then
                    local myColor = getPlayerTeamColor(lplr)
                    local theirColor = getPlayerTeamColor(ent.Player)
                    if myColor and theirColor then
                        if colorsMatch(myColor, theirColor, 0.2) then
                            return false
                        end
                    end
                end
                
                -- If different or colors not available, use original check
                return originalTargetCheck(ent)
            end
            
            teamAndForcefield:Clean(function()
                entitylib.getEntityColor = originalGetEntityColor
                entitylib.targetCheck = originalTargetCheck
                teamCheckActive = false
                noForceFieldActive = false
            end)
        else
            teamCheckActive = false
            noForceFieldActive = false
        end
    end,
    Tooltip = 'Skips targeting same-team (torso color) and ForceField (spawn protection) players, uses team colors in ESP/Chams.'
})

-- Gun exploits combined module - using debug library to modify original settings!
local gunExploits = minigames:CreateModule({
    Name = 'Gun Exploits',
    Function = function(callback)
        if callback then
            rapidFireActive = true
            noSpreadActive = true
            noRecoilActive = true
            infiniteAmmoActive = true
            
            local activeGuns = {}
            local ammoConnections = {}
            local childConnections = {}
            
            local function hookGun(gun)
                if not gun or activeGuns[gun] then return end
                
                local settingsModule = gun:FindFirstChild("settings")
                if not settingsModule then return end
                
                local success, env = pcall(function()
                    -- Require the module to get the return table
                    local settingsReturn = require(settingsModule)
                    
                    if not settingsReturn or not settingsReturn.returnclientcopy then
                        return nil
                    end
                    
                    -- Now use debug library to get the original internal table (u1) from returnclientcopy's upvalues!
                    local originalReturnClientCopy = settingsReturn.returnclientcopy
                    local upvalues = {}
                    
                    -- Get all upvalues from returnclientcopy
                    for i = 1, 100 do
                        local name, value = debug.getupvalue(originalReturnClientCopy, i)
                        if not name then break end
                        upvalues[name] = value
                        upvalues[i] = value
                    end
                    
                    -- Find the u1 table (the internal settings table)
                    local u1Table = nil
                    for name, value in pairs(upvalues) do
                        if type(value) == "table" and value.gun_data then
                            u1Table = value
                            break
                        end
                    end
                    
                    -- If we couldn't find via upvalues, try to modify the gun_data inside the returned table
                    -- and also hook returnclientcopy!
                    if not u1Table then
                        u1Table = settingsReturn
                    end
                    
                    activeGuns[gun] = {
                        settingsReturn = settingsReturn,
                        u1Table = u1Table,
                        originalReturnClientCopy = originalReturnClientCopy,
                        originalCooldown = u1Table.gun_data.cooldown,
                        originalSpreadX = u1Table.gun_data.SpreadX,
                        originalSpreadY = u1Table.gun_data.SpreadY,
                        originalCamRecoil = u1Table.gun_data.cam_recoil,
                        originalMaxAmmo = u1Table.gun_data.maxammo
                    }
                    
                    -- 1. Modify the gun_data directly in the u1 table
                    if rapidFireActive then
                        u1Table.gun_data.cooldown = 0.001
                    end
                    if noSpreadActive then
                        u1Table.gun_data.SpreadX = 0
                        u1Table.gun_data.SpreadY = 0
                    end
                    if noRecoilActive then
                        u1Table.gun_data.cam_recoil = 0
                    end
                    
                    -- 2. ALSO HOOK returnclientcopy to ALWAYS return modified data when gun_data is requested!
                    u1Table.returnclientcopy = function(self, key)
                        local data = originalReturnClientCopy(self, key)
                        if key == "gun_data" then
                            if rapidFireActive then data.cooldown = 0.001 end
                            if noSpreadActive then data.SpreadX = 0; data.SpreadY = 0 end
                            if noRecoilActive then data.cam_recoil = 0 end
                        end
                        return data
                    end
                    
                    gunExploits:Clean(function()
                        u1Table.returnclientcopy = originalReturnClientCopy
                    end)
                    
                    return activeGuns[gun]
                end)
                
                if not success or not env then return end
                
                -- Handle infinite ammo
                if infiniteAmmoActive then
                    local ammo = gun:FindFirstChild("ammo")
                    if ammo and ammo:IsA("IntValue") then
                        local maxAmmo = env.originalMaxAmmo or 30
                        ammo.Value = maxAmmo
                        
                        local conn = ammo.Changed:Connect(function()
                            if infiniteAmmoActive then
                                ammo.Value = maxAmmo
                            end
                        end)
                        table.insert(ammoConnections, conn)
                    end
                end
            end
            
            -- Hook existing guns
            for _, tool in ipairs(lplr.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    hookGun(tool)
                end
            end
            if lplr.Character then
                for _, tool in ipairs(lplr.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        hookGun(tool)
                    end
                end
            end
            
            -- Hook new guns
            local backpackConn = lplr.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    hookGun(child)
                end
            end)
            table.insert(childConnections, backpackConn)
            
            if lplr.Character then
                local charConn = lplr.Character.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        hookGun(child)
                    end
                end)
                table.insert(childConnections, charConn)
            end
            
            local charAddedConn = lplr.CharacterAdded:Connect(function(char)
                local charConn = char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        hookGun(child)
                    end
                end)
                table.insert(childConnections, charConn)
            end)
            table.insert(childConnections, charAddedConn)
            
            gunExploits:Clean(function()
                -- Restore all original gun data
                for gun, data in pairs(activeGuns) do
                    if data.u1Table and data.u1Table.gun_data then
                        data.u1Table.gun_data.cooldown = data.originalCooldown
                        data.u1Table.gun_data.SpreadX = data.originalSpreadX
                        data.u1Table.gun_data.SpreadY = data.originalSpreadY
                        data.u1Table.gun_data.cam_recoil = data.originalCamRecoil
                    end
                    if data.settingsReturn and data.originalReturnClientCopy then
                        data.settingsReturn.returnclientcopy = data.originalReturnClientCopy
                    end
                end
                
                -- Disconnect all connections
                for _, conn in ipairs(ammoConnections) do
                    conn:Disconnect()
                end
                for _, conn in ipairs(childConnections) do
                    conn:Disconnect()
                end
                
                activeGuns = {}
                ammoConnections = {}
                childConnections = {}
                
                rapidFireActive = false
                noSpreadActive = false
                noRecoilActive = false
                infiniteAmmoActive = false
            end)
        end
    end,
    Tooltip = 'Rapid Fire, No Spread, No Recoil, Infinite Ammo all in one (uses debug library to modify original settings).'
})

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
