-- Decompiled from: ReplicatedStorage.Assets.Models.Animate
-- Class: LocalScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Torso__2 = l__Parent__1:WaitForChild("Torso");
local u1 = l__Torso__2:WaitForChild("Right Shoulder");
local u2 = l__Torso__2:WaitForChild("Left Shoulder");
local u3 = l__Torso__2:WaitForChild("Right Hip");
local u4 = l__Torso__2:WaitForChild("Left Hip");
l__Torso__2:WaitForChild("Neck");
local l__Humanoid__3 = l__Parent__1:WaitForChild("Humanoid");
local u5 = "Standing";
local v6, v7 = pcall(function() --[[ Line: 14 ]]
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u8 = v6 and v7;
local u9 = "";
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = 1;
local u14 = {};
local u15 = {
    idle = {
        {
            id = "http://www.roblox.com/asset/?id=180435571",
            weight = 9
        },
        {
            id = "http://www.roblox.com/asset/?id=180435792",
            weight = 1
        }
    },
    walk = {
        {
            id = "http://www.roblox.com/asset/?id=180426354",
            weight = 10
        }
    },
    run = {
        {
            id = "run.xml",
            weight = 10
        }
    },
    jump = {
        {
            id = "http://www.roblox.com/asset/?id=125750702",
            weight = 10
        }
    },
    fall = {
        {
            id = "http://www.roblox.com/asset/?id=180436148",
            weight = 10
        }
    },
    climb = {
        {
            id = "http://www.roblox.com/asset/?id=180436334",
            weight = 10
        }
    },
    sit = {
        {
            id = "http://www.roblox.com/asset/?id=178130996",
            weight = 10
        }
    },
    toolnone = {
        {
            id = "http://www.roblox.com/asset/?id=182393478",
            weight = 10
        }
    },
    toolslash = {
        {
            id = "http://www.roblox.com/asset/?id=129967390",
            weight = 10
        }
    },
    toollunge = {
        {
            id = "http://www.roblox.com/asset/?id=129967478",
            weight = 10
        }
    },
    wave = {
        {
            id = "http://www.roblox.com/asset/?id=128777973",
            weight = 10
        }
    },
    point = {
        {
            id = "http://www.roblox.com/asset/?id=128853357",
            weight = 10
        }
    },
    dance1 = {
        {
            id = "http://www.roblox.com/asset/?id=182435998",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491037",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491065",
            weight = 10
        }
    },
    dance2 = {
        {
            id = "http://www.roblox.com/asset/?id=182436842",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491248",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491277",
            weight = 10
        }
    },
    dance3 = {
        {
            id = "http://www.roblox.com/asset/?id=182436935",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491368",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491423",
            weight = 10
        }
    },
    laugh = {
        {
            id = "http://www.roblox.com/asset/?id=129423131",
            weight = 10
        }
    },
    cheer = {
        {
            id = "http://www.roblox.com/asset/?id=129423030",
            weight = 10
        }
    }
};
local u16 = { "dance1", "dance2", "dance3" };
local u17 = {
    wave = false,
    point = false,
    dance1 = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
function configureAnimationSet(u18, u19)
    -- upvalues: u14 (copy)
    if u14[u18] ~= nil then
        for _, v20 in pairs(u14[u18].connections) do
            v20:disconnect();
        end;
    end;
    u14[u18] = {};
    u14[u18].count = 0;
    u14[u18].totalWeight = 0;
    u14[u18].connections = {};
    local v21 = script:FindFirstChild(u18);
    if v21 ~= nil then
        table.insert(u14[u18].connections, v21.ChildAdded:connect(function(_) --[[ Line: 112 ]]
            -- upvalues: u18 (copy), u19 (copy)
            configureAnimationSet(u18, u19);
        end));
        table.insert(u14[u18].connections, v21.ChildRemoved:connect(function(_) --[[ Line: 113 ]]
            -- upvalues: u18 (copy), u19 (copy)
            configureAnimationSet(u18, u19);
        end));
        local v22 = 1;
        for _, v23 in pairs(v21:GetChildren()) do
            if v23:IsA("Animation") then
                table.insert(u14[u18].connections, v23.Changed:connect(function(_) --[[ Line: 117 ]]
                    -- upvalues: u18 (copy), u19 (copy)
                    configureAnimationSet(u18, u19);
                end));
                u14[u18][v22] = {};
                u14[u18][v22].anim = v23;
                local v24 = v23:FindFirstChild("Weight");
                if v24 == nil then
                    u14[u18][v22].weight = 1;
                else
                    u14[u18][v22].weight = v24.Value;
                end;
                u14[u18].count = u14[u18].count + 1;
                u14[u18].totalWeight = u14[u18].totalWeight + u14[u18][v22].weight;
                v22 = v22 + 1;
            end;
        end;
    end;
    if u14[u18].count <= 0 then
        for v25, v26 in pairs(u19) do
            u14[u18][v25] = {};
            u14[u18][v25].anim = Instance.new("Animation");
            u14[u18][v25].anim.Name = u18;
            u14[u18][v25].anim.AnimationId = v26.id;
            u14[u18][v25].weight = v26.weight;
            u14[u18].count = u14[u18].count + 1;
            u14[u18].totalWeight = u14[u18].totalWeight + v26.weight;
        end;
    end;
end;
function scriptChildModified(p27)
    -- upvalues: u15 (copy)
    local v28 = u15[p27.Name];
    if v28 ~= nil then
        configureAnimationSet(p27.Name, v28);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v29;
if l__Humanoid__3 then
    v29 = l__Humanoid__3:FindFirstChildOfClass("Animator");
else
    v29 = nil;
end;
if v29 then
    local v30 = v29:GetPlayingAnimationTracks();
    for _, v31 in ipairs(v30) do
        v31:Stop(0);
        v31:Destroy();
    end;
end;
for v32, v33 in pairs(u15) do
    configureAnimationSet(v32, v33);
end;
local u34 = "None";
local u35 = 0;
local u36 = 0;
function stopAllAnimations()
    -- upvalues: u9 (ref), u17 (copy), u10 (ref), u12 (ref), u11 (ref)
    local v37 = u9;
    local v38 = u17[v37] ~= nil and u17[v37] == false and "idle" or v37;
    u9 = "";
    u10 = nil;
    if u12 ~= nil then
        u12:disconnect();
    end;
    if u11 ~= nil then
        u11:Stop();
        u11:Destroy();
        u11 = nil;
    end;
    return v38;
end;
function setAnimationSpeed(p39)
    -- upvalues: u13 (ref), u11 (ref)
    if p39 ~= u13 then
        u13 = p39;
        u11:AdjustSpeed(u13);
    end;
end;
function keyFrameReachedFunc(p40)
    -- upvalues: u9 (ref), u17 (copy), u13 (ref), l__Humanoid__3 (copy)
    if p40 == "End" then
        local v41 = u9;
        local v42 = u13;
        playAnimation(u17[v41] ~= nil and u17[v41] == false and "idle" or v41, 0, l__Humanoid__3);
        setAnimationSpeed(v42);
    end;
end;
function playAnimation(p43, p44, p45)
    -- upvalues: u14 (copy), u10 (ref), u11 (ref), u13 (ref), u9 (ref), u12 (ref)
    local v46 = math.random(1, u14[p43].totalWeight);
    local v47 = 1;
    while u14[p43][v47].weight < v46 do
        v46 = v46 - u14[p43][v47].weight;
        v47 = v47 + 1;
    end;
    local l__anim__4 = u14[p43][v47].anim;
    if l__anim__4 ~= u10 then
        if u11 ~= nil then
            u11:Stop(p44);
            u11:Destroy();
        end;
        u13 = 1;
        u11 = p45:LoadAnimation(l__anim__4);
        u11.Priority = Enum.AnimationPriority.Core;
        u11:Play(p44);
        u9 = p43;
        u10 = l__anim__4;
        if u12 ~= nil then
            u12:disconnect();
        end;
        u12 = u11.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;
local u48 = "";
local u49 = nil;
local u50 = nil;
local u51 = nil;
function toolKeyFrameReachedFunc(p52)
    -- upvalues: u48 (ref), l__Humanoid__3 (copy)
    if p52 == "End" then
        playToolAnimation(u48, 0, l__Humanoid__3);
    end;
end;
function playToolAnimation(p53, p54, p55, p56)
    -- upvalues: u14 (copy), u50 (ref), u49 (ref), u48 (ref), u51 (ref)
    local v57 = math.random(1, u14[p53].totalWeight);
    local v58 = 1;
    while u14[p53][v58].weight < v57 do
        v57 = v57 - u14[p53][v58].weight;
        v58 = v58 + 1;
    end;
    local l__anim__5 = u14[p53][v58].anim;
    if u50 ~= l__anim__5 then
        if u49 ~= nil then
            u49:Stop();
            u49:Destroy();
            p54 = 0;
        end;
        u49 = p55:LoadAnimation(l__anim__5);
        if p56 then
            u49.Priority = p56;
        end;
        u49:Play(p54);
        u48 = p53;
        u50 = l__anim__5;
        u51 = u49.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
function stopToolAnimations()
    -- upvalues: u48 (ref), u51 (ref), u50 (ref), u49 (ref)
    local v59 = u48;
    if u51 ~= nil then
        u51:disconnect();
    end;
    u48 = "";
    u50 = nil;
    if u49 ~= nil then
        u49:Stop();
        u49:Destroy();
        u49 = nil;
    end;
    return v59;
end;
function onRunning(p60)
    -- upvalues: u8 (copy), l__Parent__1 (copy), l__Humanoid__3 (copy), u10 (ref), u5 (ref), u17 (copy), u9 (ref)
    local v61 = p60 / (not u8 and 1 or l__Parent__1:GetScale());
    if v61 > 0.01 then
        playAnimation("walk", 0.1, l__Humanoid__3);
        if u10 and u10.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
            setAnimationSpeed(v61 / 14.5);
        end;
        u5 = "Running";
    else
        if u17[u9] == nil then
            playAnimation("idle", 0.3, l__Humanoid__3);
            u5 = "Standing";
        end;
    end;
end;
function onDied()
    -- upvalues: u5 (ref)
    u5 = "Dead";
end;
function onJumping()
    -- upvalues: l__Humanoid__3 (copy), u36 (ref), u5 (ref)
    playAnimation("jump", 0.1, l__Humanoid__3);
    u36 = 0.3;
    u5 = "Jumping";
end;
function onClimbing(p62)
    -- upvalues: u8 (copy), l__Parent__1 (copy), l__Humanoid__3 (copy), u5 (ref)
    local v63 = p62 / (not u8 and 1 or l__Parent__1:GetScale());
    playAnimation("climb", 0.1, l__Humanoid__3);
    setAnimationSpeed(v63 / 12);
    u5 = "Climbing";
end;
function onGettingUp()
    -- upvalues: u5 (ref)
    u5 = "GettingUp";
end;
function onFreeFall()
    -- upvalues: u36 (ref), l__Humanoid__3 (copy), u5 (ref)
    if u36 <= 0 then
        playAnimation("fall", 0.3, l__Humanoid__3);
    end;
    u5 = "FreeFall";
end;
function onFallingDown()
    -- upvalues: u5 (ref)
    u5 = "FallingDown";
end;
function onSeated()
    -- upvalues: u5 (ref)
    u5 = "Seated";
end;
function onPlatformStanding()
    -- upvalues: u5 (ref)
    u5 = "PlatformStanding";
end;
function onSwimming(p64)
    -- upvalues: u5 (ref)
    if p64 > 0 then
        u5 = "Running";
    else
        u5 = "Standing";
    end;
end;
function getTool()
    -- upvalues: l__Parent__1 (copy)
    for _, v65 in ipairs(l__Parent__1:GetChildren()) do
        if v65.className == "Tool" then
            return v65;
        end;
    end;
    return nil;
end;
function getToolAnim(p66)
    for _, v67 in ipairs(p66:GetChildren()) do
        if v67.Name == "toolanim" and v67.className == "StringValue" then
            return v67;
        end;
    end;
    return nil;
end;
function animateTool()
    -- upvalues: u34 (ref), l__Humanoid__3 (copy)
    if u34 == "None" then
        playToolAnimation("toolnone", 0.1, l__Humanoid__3, Enum.AnimationPriority.Idle);
    elseif u34 == "Slash" then
        playToolAnimation("toolslash", 0, l__Humanoid__3, Enum.AnimationPriority.Action);
    elseif u34 == "Lunge" then
        playToolAnimation("toollunge", 0, l__Humanoid__3, Enum.AnimationPriority.Action);
    end;
end;
function moveSit()
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    u1.MaxVelocity = 0.15;
    u2.MaxVelocity = 0.15;
    u1:SetDesiredAngle(1.57);
    u2:SetDesiredAngle(-1.57);
    u3:SetDesiredAngle(1.57);
    u4:SetDesiredAngle(-1.57);
end;
local u68 = 0;
function move(p69)
    -- upvalues: u68 (ref), u36 (ref), u5 (ref), l__Humanoid__3 (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u34 (ref), u35 (ref), u50 (ref)
    local v70 = 1;
    local v71 = 1;
    local v72 = p69 - u68;
    u68 = p69;
    local v73 = false;
    if u36 > 0 then
        u36 = u36 - v72;
    end;
    if u5 == "FreeFall" and u36 <= 0 then
        playAnimation("fall", 0.3, l__Humanoid__3);
    else
        if u5 == "Seated" then
            playAnimation("sit", 0.5, l__Humanoid__3);
            return;
        end;
        if u5 == "Running" then
            playAnimation("walk", 0.1, l__Humanoid__3);
        elseif u5 == "Dead" or (u5 == "GettingUp" or (u5 == "FallingDown" or (u5 == "Seated" or u5 == "PlatformStanding"))) then
            stopAllAnimations();
            v73 = true;
            v71 = 1;
            v70 = 0.1;
        end;
    end;
    if v73 then
        local v74 = v70 * math.sin(p69 * v71);
        u1:SetDesiredAngle(v74 + 0);
        u2:SetDesiredAngle(v74 - 0);
        u3:SetDesiredAngle(-v74);
        u4:SetDesiredAngle(-v74);
    end;
    local v75 = getTool();
    if v75 and v75:FindFirstChild("Handle") then
        local v76 = getToolAnim(v75);
        if v76 then
            u34 = v76.Value;
            v76.Parent = nil;
            u35 = p69 + 0.3;
        end;
        if u35 < p69 then
            u35 = 0;
            u34 = "None";
        end;
        animateTool();
    else
        stopToolAnimations();
        u34 = "None";
        u50 = nil;
        u35 = 0;
    end;
end;
l__Humanoid__3.Died:connect(onDied);
l__Humanoid__3.Running:connect(onRunning);
l__Humanoid__3.Jumping:connect(onJumping);
l__Humanoid__3.Climbing:connect(onClimbing);
l__Humanoid__3.GettingUp:connect(onGettingUp);
l__Humanoid__3.FreeFalling:connect(onFreeFall);
l__Humanoid__3.FallingDown:connect(onFallingDown);
l__Humanoid__3.Seated:connect(onSeated);
l__Humanoid__3.PlatformStanding:connect(onPlatformStanding);
l__Humanoid__3.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(p77) --[[ Line: 539 ]]
    -- upvalues: u16 (copy), u5 (ref), u17 (copy), l__Humanoid__3 (copy)
    local v78 = "";
    if p77 == "/e dance" then
        v78 = u16[math.random(1, #u16)];
    elseif string.sub(p77, 1, 3) == "/e " then
        v78 = string.sub(p77, 4);
    elseif string.sub(p77, 1, 7) == "/emote " then
        v78 = string.sub(p77, 8);
    end;
    if u5 == "Standing" and u17[v78] ~= nil then
        playAnimation(v78, 0.1, l__Humanoid__3);
    end;
end);
script:WaitForChild("PlayEmote").OnInvoke = function(p79) --[[ Line: 556 ]]
    -- upvalues: u5 (ref), u17 (copy), l__Humanoid__3 (copy), u11 (ref)
    if u5 == "Standing" then
        if u17[p79] == nil then
            return false;
        end;
        playAnimation(p79, 0.1, l__Humanoid__3);
        return true, u11;
    end;
end;
playAnimation("idle", 0.1, l__Humanoid__3);
local _ = "Standing";
while l__Parent__1.Parent ~= nil do
    local _, v80 = wait(0.1);
    move(v80);
end;
