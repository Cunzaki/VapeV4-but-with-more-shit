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
            -- 1. Hook FindFirstChild more broadly
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
            
            -- 3. Advanced Remote Hooking
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
                    -- Detect Adonis Remote Pattern
                    if typeof(args[1]) == "table" and args[1].Mode and args[1].Sent and args[1].Received then
                        -- We can't easily decrypt the second argument without the key, 
                        -- but we can block suspicious calls or block all "Fire" calls if they are not heartbeat
                        
                        -- If it's a "Fire" mode call, it's likely a command or detection
                        if args[1].Mode == "Fire" then
                            -- Heartbeats usually happen every 55+ seconds. 
                            -- Detections happen immediately.
                            -- For now, let's block all "Fire" calls that look like Adonis reports.
                            return nil
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
            
            -- 4. Try to find and hook Adonis client table via GC
             task.spawn(function()
                 for _, v in pairs(getgc(true)) do
                     if type(v) == "table" and rawget(v, "Remote") and rawget(v, "Anti") and rawget(v, "Core") then
                         -- Found Adonis client table!
                         local oldSend = v.Remote.Send
                         v.Remote.Send = function(p1, ...)
                             if p1 == "Detected" or p1 == "LogError" or p1 == "Log" then
                                 return nil
                             end
                             return oldSend(p1, ...)
                         end
                         
                         -- Hook the detection reporter directly in the Anti table
                          if v.Anti and v.Anti.Detected then
                              local oldDetected = v.Anti.Detected
                              v.Anti.Detected = function(p1, p2, p3)
                                  if p1 == "_" then return oldDetected(p1, p2, p3) end
                                  return true
                              end
                              anticheatBypass:Clean(function()
                                  v.Anti.Detected = oldDetected
                              end)
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
