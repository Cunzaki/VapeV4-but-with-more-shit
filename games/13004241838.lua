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

-- Store original entitylib functions
local origGetColor = entitylib.getEntityColor
local origTargetCheck = entitylib.targetCheck

-- Simple team/forcefield check
minigames:CreateModule({
    Name = 'Team Check',
    Function = function(enabled)
        if enabled then
            entitylib.getEntityColor = function(ent)
                -- Try torso color
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
                entitylib.getEntityColor = origGetColor
                entitylib.targetCheck = origTargetCheck
            end
        end
    end,
    Tooltip = 'Skips same-team and spawn-protected players.'
})

vape:CreateNotification('Vape', 'Loaded custom script for game 13004241838', 5)
