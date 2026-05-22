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

-- Get player's team color from their Torso
local function getPlayerTeamColor(player)
    if not player then return nil end
    local char = player.Character
    if not char then return nil end
    
    -- Try Torso first, then UpperTorso
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso or not torso:IsA("BasePart") then return nil end
    
    return torso.Color
end

-- Check if two colors are similar (with tolerance for lighting/lighting effects)
local function colorsMatch(color1, color2, tolerance)
    tolerance = tolerance or 0.15
    return math.abs(color1.R - color2.R) < tolerance
        and math.abs(color1.G - color2.G) < tolerance
        and math.abs(color1.B - color2.B) < tolerance
end

-- Track if Team Check is active globally
local teamCheckActive = false

-- Team Check
local teamCheck = {Enabled = false}
teamCheck = minigames:CreateModule({
    Name = 'Team Check',
    Function = function(callback)
        if callback then
            teamCheckActive = true
            
            -- Store original functions
            local oldTargetCheck = entitylib.targetCheck
            local oldGetEntityColor = entitylib.getEntityColor
            
            -- Override target check to use torso colors
            entitylib.targetCheck = function(ent)
                -- First check if both players have torso colors
                local myColor = getPlayerTeamColor(lplr)
                local theirColor = getPlayerTeamColor(ent.Player)
                
                if myColor and theirColor then
                    -- Don't target same-color players
                    if colorsMatch(myColor, theirColor, 0.2) then
                        return false
                    end
                end
                
                -- If different or colors not available, use original check
                return oldTargetCheck(ent)
            end
            
            -- Override entity color to use torso colors
            entitylib.getEntityColor = function(ent)
                if teamCheckActive then
                    local playerColor = getPlayerTeamColor(ent.Player)
                    if playerColor then
                        return playerColor
                    end
                end
                
                -- Fall back to original if no torso color
                return oldGetEntityColor(ent)
            end
            
            teamCheck:Clean(function()
                entitylib.targetCheck = oldTargetCheck
                entitylib.getEntityColor = oldGetEntityColor
                teamCheckActive = false
            end)
        else
            teamCheckActive = false
        end
    end,
    Tooltip = 'Prevents targeting players with same torso color (yellow/red/blue) and shows team colors in ESP/Chams.'
})

-- Gun Rapid Fire Module
local rapidFire = {Enabled = false}
rapidFire = minigames:CreateModule({
    Name = 'Rapid Fire',
    Function = function(callback)
        if callback then
            local activeGuns = {}
            local connections = {}
            
            local function hookGun(gun)
                if not gun or activeGuns[gun] then return end
                
                local settingsModule = gun:FindFirstChild("settings")
                if not settingsModule then return end
                
                local success, settings = pcall(function() return require(settingsModule) end)
                if not success or not settings or not settings.gun_data then return end
                
                activeGuns[gun] = true
                
                -- Store original values
                local originalCooldown = settings.gun_data.cooldown
                
                -- Set cooldown to near zero for rapid fire
                settings.gun_data.cooldown = 0.001
                
                -- Also try to hook the gun framework's register remote if possible
                local framework = gun:FindFirstChild("framework")
                if framework then
                    local event = framework:FindFirstChild("event")
                    if event then
                        local register = event:FindFirstChild("register")
                        if register and register:IsA("RemoteEvent") then
                            -- We could hook FireServer here but it's already very fast with cooldown 0
                        end
                    end
                end
                
                rapidFire:Clean(function()
                    -- Restore original values when disabled
                    if settings and settings.gun_data then
                        settings.gun_data.cooldown = originalCooldown
                    end
                end)
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
            table.insert(connections, lplr.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    hookGun(child)
                end
            end))
            
            table.insert(connections, lplr.CharacterAdded:Connect(function(char)
                char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        hookGun(child)
                    end
                end)
            end))
            
            rapidFire:Clean(function()
                for _, conn in ipairs(connections) do
                    conn:Disconnect()
                end
                activeGuns = {}
            end)
        end
    end,
    Tooltip = 'Makes all guns fire extremely quickly by reducing cooldown.'
})

-- No Spread Module
local noSpread = {Enabled = false}
noSpread = minigames:CreateModule({
    Name = 'No Spread',
    Function = function(callback)
        if callback then
            local activeGuns = {}
            local connections = {}
            
            local function hookGun(gun)
                if not gun or activeGuns[gun] then return end
                
                local settingsModule = gun:FindFirstChild("settings")
                if not settingsModule then return end
                
                local success, settings = pcall(function() return require(settingsModule) end)
                if not success or not settings or not settings.gun_data then return end
                
                activeGuns[gun] = true
                
                -- Store original values
                local originalSpreadX = settings.gun_data.SpreadX
                local originalSpreadY = settings.gun_data.SpreadY
                
                -- Remove spread
                settings.gun_data.SpreadX = 0
                settings.gun_data.SpreadY = 0
                
                noSpread:Clean(function()
                    if settings and settings.gun_data then
                        settings.gun_data.SpreadX = originalSpreadX
                        settings.gun_data.SpreadY = originalSpreadY
                    end
                end)
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
            table.insert(connections, lplr.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    hookGun(child)
                end
            end))
            
            table.insert(connections, lplr.CharacterAdded:Connect(function(char)
                char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        hookGun(child)
                    end
                end)
            end))
            
            noSpread:Clean(function()
                for _, conn in ipairs(connections) do
                    conn:Disconnect()
                end
                activeGuns = {}
            end)
        end
    end,
    Tooltip = 'Removes all bullet spread from guns.'
})

-- No Recoil Module
local noRecoil = {Enabled = false}
noRecoil = minigames:CreateModule({
    Name = 'No Recoil',
    Function = function(callback)
        if callback then
            local activeGuns = {}
            local connections = {}
            
            local function hookGun(gun)
                if not gun or activeGuns[gun] then return end
                
                local settingsModule = gun:FindFirstChild("settings")
                if not settingsModule then return end
                
                local success, settings = pcall(function() return require(settingsModule) end)
                if not success or not settings or not settings.gun_data then return end
                
                activeGuns[gun] = true
                
                -- Store original value
                local originalCamRecoil = settings.gun_data.cam_recoil
                
                -- Remove recoil
                settings.gun_data.cam_recoil = 0
                
                noRecoil:Clean(function()
                    if settings and settings.gun_data then
                        settings.gun_data.cam_recoil = originalCamRecoil
                    end
                end)
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
            table.insert(connections, lplr.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    hookGun(child)
                end
            end))
            
            table.insert(connections, lplr.CharacterAdded:Connect(function(char)
                char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        hookGun(child)
                    end
                end)
            end))
            
            noRecoil:Clean(function()
                for _, conn in ipairs(connections) do
                    conn:Disconnect()
                end
                activeGuns = {}
            end)
        end
    end,
    Tooltip = 'Removes camera recoil when shooting.'
})

-- Infinite Ammo Module
local infiniteAmmo = {Enabled = false}
infiniteAmmo = minigames:CreateModule({
    Name = 'Infinite Ammo',
    Function = function(callback)
        if callback then
            local connections = {}
            
            -- Hook ammo Value objects
            local function hookAmmo(tool)
                if not tool then return end
                local ammo = tool:FindFirstChild("ammo")
                if ammo and ammo:IsA("IntValue") then
                    -- Store original max ammo from settings
                    local maxAmmo = 30 -- Default
                    local settingsModule = tool:FindFirstChild("settings")
                    if settingsModule then
                        local success, settings = pcall(function() return require(settingsModule) end)
                        if success and settings and settings.gun_data and settings.gun_data.maxammo then
                            maxAmmo = settings.gun_data.maxammo
                        end
                    end
                    
                    -- Keep ammo at max
                    ammo.Value = maxAmmo
                    
                    local conn = ammo.Changed:Connect(function()
                        if infiniteAmmo.Enabled then
                            ammo.Value = maxAmmo
                        end
                    end)
                    
                    table.insert(connections, conn)
                end
            end
            
            -- Hook existing tools
            for _, tool in ipairs(lplr.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    hookAmmo(tool)
                end
            end
            if lplr.Character then
                for _, tool in ipairs(lplr.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        hookAmmo(tool)
                    end
                end
            end
            
            -- Hook new tools
            table.insert(connections, lplr.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    hookAmmo(child)
                end
            end))
            
            table.insert(connections, lplr.CharacterAdded:Connect(function(char)
                char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        hookAmmo(child)
                    end
                end)
            end))
            
            infiniteAmmo:Clean(function()
                for _, conn in ipairs(connections) do
                    conn:Disconnect()
                end
            end)
        end
    end,
    Tooltip = 'Keeps your ammo at maximum capacity.'
})

-- Expose team check state and helper functions to other modules if needed
shared.StreetsTeamCheckActive = function() return teamCheckActive end
shared.StreetsGetTeamColor = getPlayerTeamColor
shared.StreetsColorsMatch = colorsMatch

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
