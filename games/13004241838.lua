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

-- Anticheat Bypass
local anticheatBypass = {Enabled = false}
anticheatBypass = minigames:CreateModule({
    Name = 'Anticheat Bypass',
    Function = function(callback)
        if callback then
            -- 1. Hook FindFirstChild for recursive malicious object checks
            local oldFFC
            oldFFC = hookinstancemethod(game, "FindFirstChild", function(self, name, recursive)
                if recursive and (name == "SentinelSpy" or name == "ScriptDumper" or name == "SimpleSpy") then
                    return nil
                end
                return oldFFC(self, name, recursive)
            end)
            
            -- 2. Hook GetRealPhysicsFPS for speed check bypass
            local oldFPS
            oldFPS = hookinstancemethod(workspace, "GetRealPhysicsFPS", function(self)
                return 60
            end)
            
            -- 3. Hook RemoteEvent for "Detected" reports
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if not checkcaller() and method == "FireServer" and self.Parent == jointsService then
                    if typeof(args[1]) == "table" and args[1].Mode == "Fire" then
                        -- Adonis usually sends "Detected" as the command name.
                        -- Since it's encrypted, we block all "Fire" calls from these scripts to be safe.
                        return nil
                    end
                end
                return oldNamecall(self, ...)
            end)
            
            anticheatBypass:Clean(function()
                hookinstancemethod(game, "FindFirstChild", oldFFC)
                hookinstancemethod(workspace, "GetRealPhysicsFPS", oldFPS)
                hookmetamethod(game, "__namecall", oldNamecall)
            end)
        else
            -- Cleanup handled by :Clean()
        end
    end,
    Tooltip = 'Bypasses Adonis-based anticheat detections by filtering Remote traffic and spoofing physics data.'
})

-- Team Check
local teamCheck = {Enabled = false}
teamCheck = minigames:CreateModule({
    Name = 'Team Check',
    Function = function(callback)
        if callback then
            local oldTargetCheck = entitylib.targetCheck
            entitylib.targetCheck = function(ent)
                if ent.Player and ent.Player.Team == lplr.Team then
                    return false
                end
                return oldTargetCheck(ent)
            end
            teamCheck:Clean(function()
                entitylib.targetCheck = oldTargetCheck
            end)
        else
            -- Cleanup handled by :Clean()
        end
    end,
    Tooltip = 'Prevents targeting players on your team.'
})

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
