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

-- Anticheat Bypass
local anticheatBypass = {Enabled = false}
anticheatBypass = minigames:CreateModule({
    Name = 'Anticheat Bypass',
    Function = function(callback)
        if callback then
            -- 1. Hook FindFirstChild for recursive malicious object checks
            local oldFFC
            oldFFC = hookinstancemethod(game, "FindFirstChild", function(self, name, recursive)
                if not checkcaller() and recursive and (name == "SentinelSpy" or name == "ScriptDumper" or name == "SimpleSpy" or name == "SimpleSpyV2" or name == "SimpleSpyV3") then
                    return nil
                end
                return oldFFC(self, name, recursive)
            end)
            
            -- 2. Hook GetRealPhysicsFPS for speed check bypass
            local oldFPS
            oldFPS = hookinstancemethod(workspace, "GetRealPhysicsFPS", function(self)
                return 60
            end)
            
            -- 3. Hook Lighting changed to prevent lock lighting detections
            local lightingProperties = {}
            local function saveLightingState()
                lightingProperties.Ambient = lightingService.Ambient
                lightingProperties.Brightness = lightingService.Brightness
                lightingProperties.ColorShift_Bottom = lightingService.ColorShift_Bottom
                lightingProperties.ColorShift_Top = lightingService.ColorShift_Top
                lightingProperties.GlobalShadows = lightingService.GlobalShadows
                lightingProperties.OutdoorAmbient = lightingService.OutdoorAmbient
                lightingProperties.Outlines = lightingService.Outlines
                lightingProperties.ShadowColor = lightingService.ShadowColor
                lightingProperties.GeographicLatitude = lightingService.GeographicLatitude
                lightingProperties.TimeOfDay = lightingService.TimeOfDay
                lightingProperties.FogColor = lightingService.FogColor
                lightingProperties.FogEnd = lightingService.FogEnd
                lightingProperties.FogStart = lightingService.FogStart
            end
            saveLightingState()
            
            -- Hook index/newindex for Lighting
            local lightingMeta = getmetatable(lightingService)
            local oldLightingIndex = lightingMeta.__index
            local oldLightingNewindex = lightingMeta.__newindex
            lightingMeta.__index = function(self, idx)
                if lightingProperties[idx] ~= nil then
                    return lightingProperties[idx]
                end
                return oldLightingIndex(self, idx)
            end
            lightingMeta.__newindex = function(self, idx, value)
                if lightingProperties[idx] ~= nil then
                    return
                end
                return oldLightingNewindex(self, idx, value)
            end
            
            -- 4. Advanced Remote Hooking for ALL Adonis traffic
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
                    -- Detect Adonis Remote Pattern
                    if typeof(args[1]) == "table" and args[1].Mode and args[1].Sent and args[1].Received then
                        -- If it's a "Fire" or "Get" mode call, block it silently
                        return nil
                    end
                end
                return oldNamecall(self, ...)
            end)
            
            -- 5. Try to find and hook Adonis client table via GC for deep hooks
            task.spawn(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "Remote") and rawget(v, "Anti") and rawget(v, "Core") then
                        -- Found Adonis client table!
                        local oldSend = v.Remote.Send
                        v.Remote.Send = function(p1, ...)
                            if p1 == "Detected" or p1 == "LogError" or p1 == "Log" or p1 == "AddReplication" then
                                return nil
                            end
                            return oldSend(p1, ...)
                        end
                        
                        -- Hook the detection reporter directly in the Anti table
                        if v.Anti and type(v.Anti) == "table" then
                            -- Try to find any detection function in Anti
                            for k, _ in pairs(v.Anti) do
                                if type(k) == "string" and (k:lower():find("detect") or k:lower():find("log")) then
                                    local oldFunc = v.Anti[k]
                                    if type(oldFunc) == "function" then
                                        v.Anti[k] = function(...)
                                            return true
                                        end
                                        anticheatBypass:Clean(function()
                                            v.Anti[k] = oldFunc
                                        end)
                                    end
                                end
                            end
                        end
                        
                        -- Hook Disconnect and Kill to prevent local kicks/crashes
                        if v.Disconnect then
                            local oldDisconnect = v.Disconnect
                            v.Disconnect = function(...) return nil end
                            anticheatBypass:Clean(function()
                                v.Disconnect = oldDisconnect
                            end)
                        end

                        if v.Kill then
                            local oldKill = v.Kill
                            v.Kill = function(...) return nil end
                            anticheatBypass:Clean(function()
                                v.Kill = oldKill
                            end)
                        end

                        anticheatBypass:Clean(function()
                            v.Remote.Send = oldSend
                        end)
                        break
                    end
                end
            end)
            
            anticheatBypass:Clean(function()
                hookinstancemethod(game, "FindFirstChild", oldFFC)
                hookinstancemethod(workspace, "GetRealPhysicsFPS", oldFPS)
                hookmetamethod(game, "__namecall", oldNamecall)
                lightingMeta.__index = oldLightingIndex
                lightingMeta.__newindex = oldLightingNewindex
            end)
        else
            -- Cleanup handled by :Clean()
        end
    end,
    Tooltip = 'Comprehensive bypass for all Adonis anticheat detections.'
})

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

-- Expose team check state and helper functions to other modules if needed
shared.StreetsTeamCheckActive = function() return teamCheckActive end
shared.StreetsGetTeamColor = getPlayerTeamColor
shared.StreetsColorsMatch = colorsMatch

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
