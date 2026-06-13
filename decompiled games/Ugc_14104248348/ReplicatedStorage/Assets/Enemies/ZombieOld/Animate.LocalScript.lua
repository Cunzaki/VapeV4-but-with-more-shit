-- Decompiled from: ReplicatedStorage.Assets.Enemies.ZombieOld.Animate
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Humanoid__2 = l__Parent__1:WaitForChild("Humanoid");
local u1 = "Standing";
local v2, v3 = pcall(function() --[[ Line: 7 ]]
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local u4 = v2 and v3;
local v5, v6 = pcall(function() --[[ Line: 10 ]]
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u7 = v5 and v6;
local function u8() --[[ Line: 13 ]]
    -- upvalues: u7 (copy), l__Parent__1 (copy)
    return not u7 and 1 or l__Parent__1:GetScale();
end;
local u9 = script:FindFirstChild("ScaleDampeningPercent");
local u10 = "";
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = 1;
local u15 = nil;
local u16 = nil;
local u17 = {};
local u18 = {};
local u19 = {
    idle = {
        {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        },
        {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        },
        {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        }
    },
    walk = {
        {
            id = "http://www.roblox.com/asset/?id=507777826",
            weight = 10
        }
    },
    run = {
        {
            id = "http://www.roblox.com/asset/?id=507767714",
            weight = 10
        }
    },
    swim = {
        {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        }
    },
    swimidle = {
        {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        }
    },
    jump = {
        {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        }
    },
    fall = {
        {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        }
    },
    climb = {
        {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        }
    },
    sit = {
        {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        }
    },
    toolnone = {
        {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        }
    },
    toolslash = {
        {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        }
    },
    toollunge = {
        {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        }
    },
    wave = {
        {
            id = "http://www.roblox.com/asset/?id=507770239",
            weight = 10
        }
    },
    point = {
        {
            id = "http://www.roblox.com/asset/?id=507770453",
            weight = 10
        }
    },
    dance = {
        {
            id = "http://www.roblox.com/asset/?id=507771019",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507771955",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507772104",
            weight = 10
        }
    },
    dance2 = {
        {
            id = "http://www.roblox.com/asset/?id=507776043",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507776720",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507776879",
            weight = 10
        }
    },
    dance3 = {
        {
            id = "http://www.roblox.com/asset/?id=507777268",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507777451",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507777623",
            weight = 10
        }
    },
    laugh = {
        {
            id = "http://www.roblox.com/asset/?id=507770818",
            weight = 10
        }
    },
    cheer = {
        {
            id = "http://www.roblox.com/asset/?id=507770677",
            weight = 10
        }
    }
};
local u20 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
math.randomseed(tick());
function findExistingAnimationInSet(p21, p22)
    if p21 == nil or p22 == nil then
        return 0;
    end;
    for v23 = 1, p21.count do
        if p21[v23].anim.AnimationId == p22.AnimationId then
            return v23;
        end;
    end;
    return 0;
end;
function configureAnimationSet(u24, u25)
    -- upvalues: u18 (copy), u17 (copy), l__Humanoid__2 (copy)
    if u18[u24] ~= nil then
        for _, v26 in pairs(u18[u24].connections) do
            v26:disconnect();
        end;
    end;
    u18[u24] = {};
    u18[u24].count = 0;
    u18[u24].totalWeight = 0;
    u18[u24].connections = {};
    local u27 = true;
    local v28, _ = pcall(function() --[[ Line: 138 ]]
        -- upvalues: u27 (ref)
        u27 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u27 = not v28 and true or u27;
    local v29 = script:FindFirstChild(u24);
    if u27 and v29 ~= nil then
        table.insert(u18[u24].connections, v29.ChildAdded:connect(function(_) --[[ Line: 146 ]]
            -- upvalues: u24 (copy), u25 (copy)
            configureAnimationSet(u24, u25);
        end));
        table.insert(u18[u24].connections, v29.ChildRemoved:connect(function(_) --[[ Line: 147 ]]
            -- upvalues: u24 (copy), u25 (copy)
            configureAnimationSet(u24, u25);
        end));
        for _, v30 in pairs(v29:GetChildren()) do
            if v30:IsA("Animation") then
                local v31 = v30:FindFirstChild("Weight");
                local v32 = v31 == nil and 1 or v31.Value;
                u18[u24].count = u18[u24].count + 1;
                local l__count__3 = u18[u24].count;
                u18[u24][l__count__3] = {};
                u18[u24][l__count__3].anim = v30;
                u18[u24][l__count__3].weight = v32;
                u18[u24].totalWeight = u18[u24].totalWeight + u18[u24][l__count__3].weight;
                table.insert(u18[u24].connections, v30.Changed:connect(function(_) --[[ Line: 163 ]]
                    -- upvalues: u24 (copy), u25 (copy)
                    configureAnimationSet(u24, u25);
                end));
                table.insert(u18[u24].connections, v30.ChildAdded:connect(function(_) --[[ Line: 164 ]]
                    -- upvalues: u24 (copy), u25 (copy)
                    configureAnimationSet(u24, u25);
                end));
                table.insert(u18[u24].connections, v30.ChildRemoved:connect(function(_) --[[ Line: 165 ]]
                    -- upvalues: u24 (copy), u25 (copy)
                    configureAnimationSet(u24, u25);
                end));
            end;
        end;
    end;
    if u18[u24].count <= 0 then
        for v33, v34 in pairs(u25) do
            u18[u24][v33] = {};
            u18[u24][v33].anim = Instance.new("Animation");
            u18[u24][v33].anim.Name = u24;
            u18[u24][v33].anim.AnimationId = v34.id;
            u18[u24][v33].weight = v34.weight;
            u18[u24].count = u18[u24].count + 1;
            u18[u24].totalWeight = u18[u24].totalWeight + v34.weight;
        end;
    end;
    for _, v35 in pairs(u18) do
        for v36 = 1, v35.count do
            if u17[v35[v36].anim.AnimationId] == nil then
                l__Humanoid__2:LoadAnimation(v35[v36].anim);
                u17[v35[v36].anim.AnimationId] = true;
            end;
        end;
    end;
end;
function configureAnimationSetOld(u37, u38)
    -- upvalues: u18 (copy), l__Humanoid__2 (copy)
    if u18[u37] ~= nil then
        for _, v39 in pairs(u18[u37].connections) do
            v39:disconnect();
        end;
    end;
    u18[u37] = {};
    u18[u37].count = 0;
    u18[u37].totalWeight = 0;
    u18[u37].connections = {};
    local u40 = true;
    local v41, _ = pcall(function() --[[ Line: 209 ]]
        -- upvalues: u40 (ref)
        u40 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u40 = not v41 and true or u40;
    local v42 = script:FindFirstChild(u37);
    if u40 and v42 ~= nil then
        table.insert(u18[u37].connections, v42.ChildAdded:connect(function(_) --[[ Line: 217 ]]
            -- upvalues: u37 (copy), u38 (copy)
            configureAnimationSet(u37, u38);
        end));
        table.insert(u18[u37].connections, v42.ChildRemoved:connect(function(_) --[[ Line: 218 ]]
            -- upvalues: u37 (copy), u38 (copy)
            configureAnimationSet(u37, u38);
        end));
        local v43 = 1;
        for _, v44 in pairs(v42:GetChildren()) do
            if v44:IsA("Animation") then
                table.insert(u18[u37].connections, v44.Changed:connect(function(_) --[[ Line: 222 ]]
                    -- upvalues: u37 (copy), u38 (copy)
                    configureAnimationSet(u37, u38);
                end));
                u18[u37][v43] = {};
                u18[u37][v43].anim = v44;
                local v45 = v44:FindFirstChild("Weight");
                if v45 == nil then
                    u18[u37][v43].weight = 1;
                else
                    u18[u37][v43].weight = v45.Value;
                end;
                u18[u37].count = u18[u37].count + 1;
                u18[u37].totalWeight = u18[u37].totalWeight + u18[u37][v43].weight;
                v43 = v43 + 1;
            end;
        end;
    end;
    if u18[u37].count <= 0 then
        for v46, v47 in pairs(u38) do
            u18[u37][v46] = {};
            u18[u37][v46].anim = Instance.new("Animation");
            u18[u37][v46].anim.Name = u37;
            u18[u37][v46].anim.AnimationId = v47.id;
            u18[u37][v46].weight = v47.weight;
            u18[u37].count = u18[u37].count + 1;
            u18[u37].totalWeight = u18[u37].totalWeight + v47.weight;
        end;
    end;
    for _, v48 in pairs(u18) do
        for v49 = 1, v48.count do
            l__Humanoid__2:LoadAnimation(v48[v49].anim);
        end;
    end;
end;
function scriptChildModified(p50)
    -- upvalues: u19 (copy)
    local v51 = u19[p50.Name];
    if v51 ~= nil then
        configureAnimationSet(p50.Name, v51);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v52;
if l__Humanoid__2 then
    v52 = l__Humanoid__2:FindFirstChildOfClass("Animator");
else
    v52 = nil;
end;
if v52 then
    local v53 = v52:GetPlayingAnimationTracks();
    for _, v54 in ipairs(v53) do
        v54:Stop(0);
        v54:Destroy();
    end;
end;
for v55, v56 in pairs(u19) do
    configureAnimationSet(v55, v56);
end;
local u57 = "None";
local u58 = 0;
local u59 = 0;
local u60 = false;
function stopAllAnimations()
    -- upvalues: u10 (ref), u20 (copy), u60 (ref), u11 (ref), u13 (ref), u12 (ref), u16 (ref), u15 (ref)
    local v61 = u10;
    local v62 = u20[v61] ~= nil and u20[v61] == false and "idle" or v61;
    if u60 then
        v62 = "idle";
        u60 = false;
    end;
    u10 = "";
    u11 = nil;
    if u13 ~= nil then
        u13:disconnect();
    end;
    if u12 ~= nil then
        u12:Stop();
        u12:Destroy();
        u12 = nil;
    end;
    if u16 ~= nil then
        u16:disconnect();
    end;
    if u15 ~= nil then
        u15:Stop();
        u15:Destroy();
        u15 = nil;
    end;
    return v62;
end;
function getHeightScale()
    -- upvalues: l__Humanoid__2 (copy), u8 (copy), u9 (ref)
    if not l__Humanoid__2 then
        return u8();
    end;
    if not l__Humanoid__2.AutomaticScalingEnabled then
        return u8();
    end;
    local v63 = l__Humanoid__2.HipHeight / 2;
    if u9 == nil then
        u9 = script:FindFirstChild("ScaleDampeningPercent");
    end;
    if u9 ~= nil then
        v63 = 1 + (l__Humanoid__2.HipHeight - 2) * u9.Value / 2;
    end;
    return v63;
end;
local function u69(p64) --[[ Line: 369 ]]
    -- upvalues: u12 (ref), u15 (ref)
    local v65 = p64 * 1.25 / getHeightScale();
    local v66 = 0.0001;
    local v67 = 0.0001;
    local v68 = 1;
    if v65 <= 0.5 then
        v68 = v65 / 0.5;
        v66 = 1;
    elseif v65 < 1 then
        v67 = (v65 - 0.5) / 0.5;
        v66 = 1 - v67;
    else
        v68 = v65 / 1;
        v67 = 1;
    end;
    u12:AdjustWeight(v66);
    u15:AdjustWeight(v67);
    u12:AdjustSpeed(v68);
    u15:AdjustSpeed(v68);
end;
function setAnimationSpeed(p70)
    -- upvalues: u10 (ref), u69 (copy), u14 (ref), u12 (ref)
    if u10 == "walk" then
        u69(p70);
    else
        if p70 ~= u14 then
            u14 = p70;
            u12:AdjustSpeed(u14);
        end;
    end;
end;
function keyFrameReachedFunc(p71)
    -- upvalues: u10 (ref), u4 (copy), u15 (ref), u12 (ref), u20 (copy), u60 (ref), u14 (ref), l__Humanoid__2 (copy)
    if p71 == "End" then
        if u10 == "walk" then
            if u4 ~= true then
                u15.TimePosition = 0;
                u12.TimePosition = 0;
                return;
            end;
            if u15.Looped ~= true then
                u15.TimePosition = 0;
            end;
            if u12.Looped ~= true then
                u12.TimePosition = 0;
            end;
        else
            local v72 = u10;
            local v73 = u20[v72] ~= nil and u20[v72] == false and "idle" or v72;
            if u60 then
                if u12.Looped then
                    return;
                end;
                v73 = "idle";
                u60 = false;
            end;
            local v74 = u14;
            playAnimation(v73, 0.15, l__Humanoid__2);
            setAnimationSpeed(v74);
        end;
    end;
end;
function rollAnimation(p75)
    -- upvalues: u18 (copy)
    local v76 = math.random(1, u18[p75].totalWeight);
    local v77 = 1;
    while u18[p75][v77].weight < v76 do
        v76 = v76 - u18[p75][v77].weight;
        v77 = v77 + 1;
    end;
    return v77;
end;
local function u83(p78, p79, p80, p81) --[[ Line: 455 ]]
    -- upvalues: u11 (ref), u12 (ref), u15 (ref), u4 (copy), u14 (ref), u10 (ref), u13 (ref), u18 (copy), u16 (ref)
    if p78 ~= u11 then
        if u12 ~= nil then
            u12:Stop(p80);
            u12:Destroy();
        end;
        if u15 ~= nil then
            u15:Stop(p80);
            u15:Destroy();
            if u4 == true then
                u15 = nil;
            end;
        end;
        u14 = 1;
        u12 = p81:LoadAnimation(p78);
        u12.Priority = Enum.AnimationPriority.Core;
        u12:Play(p80);
        u10 = p79;
        u11 = p78;
        if u13 ~= nil then
            u13:disconnect();
        end;
        u13 = u12.KeyframeReached:connect(keyFrameReachedFunc);
        if p79 == "walk" then
            local v82 = rollAnimation("run");
            u15 = p81:LoadAnimation(u18.run[v82].anim);
            u15.Priority = Enum.AnimationPriority.Core;
            u15:Play(p80);
            if u16 ~= nil then
                u16:disconnect();
            end;
            u16 = u15.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;
function playAnimation(p84, p85, p86)
    -- upvalues: u18 (copy), u83 (copy), u60 (ref)
    local v87 = rollAnimation(p84);
    u83(u18[p84][v87].anim, p84, p85, p86);
    u60 = false;
end;
function playEmote(p88, p89, p90)
    -- upvalues: u83 (copy), u60 (ref)
    u83(p88, p88.Name, p89, p90);
    u60 = true;
end;
local u91 = "";
local u92 = nil;
local u93 = nil;
local u94 = nil;
function toolKeyFrameReachedFunc(p95)
    -- upvalues: u91 (ref), l__Humanoid__2 (copy)
    if p95 == "End" then
        playToolAnimation(u91, 0, l__Humanoid__2);
    end;
end;
function playToolAnimation(p96, p97, p98, p99)
    -- upvalues: u18 (copy), u93 (ref), u92 (ref), u91 (ref), u94 (ref)
    local v100 = rollAnimation(p96);
    local l__anim__4 = u18[p96][v100].anim;
    if u93 ~= l__anim__4 then
        if u92 ~= nil then
            u92:Stop();
            u92:Destroy();
            p97 = 0;
        end;
        u92 = p98:LoadAnimation(l__anim__4);
        if p99 then
            u92.Priority = p99;
        end;
        u92:Play(p97);
        u91 = p96;
        u93 = l__anim__4;
        u94 = u92.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
function stopToolAnimations()
    -- upvalues: u91 (ref), u94 (ref), u93 (ref), u92 (ref)
    local v101 = u91;
    if u94 ~= nil then
        u94:disconnect();
    end;
    u91 = "";
    u93 = nil;
    if u92 ~= nil then
        u92:Stop();
        u92:Destroy();
        u92 = nil;
    end;
    return v101;
end;
function onRunning(p102)
    -- upvalues: u7 (copy), u60 (ref), l__Humanoid__2 (copy), u1 (ref), u20 (copy), u10 (ref)
    local v103 = not u7 and 1 or getHeightScale();
    local v104 = u60;
    if v104 then
        v104 = l__Humanoid__2.MoveDirection == Vector3.new(0, 0, 0);
    end;
    if (v104 and (l__Humanoid__2.WalkSpeed / v103 or 0.75) or 0.75) * v103 < p102 then
        playAnimation("walk", 0.2, l__Humanoid__2);
        setAnimationSpeed(p102 / 16);
        u1 = "Running";
    else
        if u20[u10] == nil and not u60 then
            playAnimation("idle", 0.2, l__Humanoid__2);
            u1 = "Standing";
        end;
    end;
end;
function onDied()
    -- upvalues: u1 (ref)
    u1 = "Dead";
end;
function onJumping()
    -- upvalues: l__Humanoid__2 (copy), u59 (ref), u1 (ref)
    playAnimation("jump", 0.1, l__Humanoid__2);
    u59 = 0.31;
    u1 = "Jumping";
end;
function onClimbing(p105)
    -- upvalues: u7 (copy), l__Humanoid__2 (copy), u1 (ref)
    if u7 then
        p105 = p105 / getHeightScale();
    end;
    playAnimation("climb", 0.1, l__Humanoid__2);
    setAnimationSpeed(p105 / 5);
    u1 = "Climbing";
end;
function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;
function onFreeFall()
    -- upvalues: u59 (ref), l__Humanoid__2 (copy), u1 (ref)
    if u59 <= 0 then
        playAnimation("fall", 0.2, l__Humanoid__2);
    end;
    u1 = "FreeFall";
end;
function onFallingDown()
    -- upvalues: u1 (ref)
    u1 = "FallingDown";
end;
function onSeated()
    -- upvalues: u1 (ref)
    u1 = "Seated";
end;
function onPlatformStanding()
    -- upvalues: u1 (ref)
    u1 = "PlatformStanding";
end;
function onSwimming(p106)
    -- upvalues: u7 (copy), l__Humanoid__2 (copy), u1 (ref)
    if u7 then
        p106 = p106 / getHeightScale();
    end;
    if p106 > 1 then
        playAnimation("swim", 0.4, l__Humanoid__2);
        setAnimationSpeed(p106 / 10);
        u1 = "Swimming";
    else
        playAnimation("swimidle", 0.4, l__Humanoid__2);
        u1 = "Standing";
    end;
end;
function animateTool()
    -- upvalues: u57 (ref), l__Humanoid__2 (copy)
    if u57 == "None" then
        playToolAnimation("toolnone", 0.1, l__Humanoid__2, Enum.AnimationPriority.Idle);
    elseif u57 == "Slash" then
        playToolAnimation("toolslash", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
    elseif u57 == "Lunge" then
        playToolAnimation("toollunge", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
    end;
end;
function getToolAnim(p107)
    for _, v108 in ipairs(p107:GetChildren()) do
        if v108.Name == "toolanim" and v108.className == "StringValue" then
            return v108;
        end;
    end;
    return nil;
end;
local u109 = 0;
function stepAnimate(p110)
    -- upvalues: u109 (ref), u59 (ref), u1 (ref), l__Humanoid__2 (copy), l__Parent__1 (copy), u57 (ref), u58 (ref), u93 (ref)
    local v111 = p110 - u109;
    u109 = p110;
    if u59 > 0 then
        u59 = u59 - v111;
    end;
    if u1 == "FreeFall" and u59 <= 0 then
        playAnimation("fall", 0.2, l__Humanoid__2);
    else
        if u1 == "Seated" then
            playAnimation("sit", 0.5, l__Humanoid__2);
            return;
        end;
        if u1 == "Running" then
            playAnimation("walk", 0.2, l__Humanoid__2);
        elseif u1 == "Dead" or (u1 == "GettingUp" or (u1 == "FallingDown" or (u1 == "Seated" or u1 == "PlatformStanding"))) then
            stopAllAnimations();
        end;
    end;
    local v112 = l__Parent__1:FindFirstChildOfClass("Tool");
    if v112 and v112:FindFirstChild("Handle") then
        local v113 = getToolAnim(v112);
        if v113 then
            u57 = v113.Value;
            v113.Parent = nil;
            u58 = p110 + 0.3;
        end;
        if u58 < p110 then
            u58 = 0;
            u57 = "None";
        end;
        animateTool();
    else
        stopToolAnimations();
        u57 = "None";
        u93 = nil;
        u58 = 0;
    end;
end;
l__Humanoid__2.Died:connect(onDied);
l__Humanoid__2.Running:connect(onRunning);
l__Humanoid__2.Jumping:connect(onJumping);
l__Humanoid__2.Climbing:connect(onClimbing);
l__Humanoid__2.GettingUp:connect(onGettingUp);
l__Humanoid__2.FreeFalling:connect(onFreeFall);
l__Humanoid__2.FallingDown:connect(onFallingDown);
l__Humanoid__2.Seated:connect(onSeated);
l__Humanoid__2.PlatformStanding:connect(onPlatformStanding);
l__Humanoid__2.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(p114) --[[ Line: 756 ]]
    -- upvalues: u1 (ref), u20 (copy), l__Humanoid__2 (copy)
    local v115 = "";
    if string.sub(p114, 1, 3) == "/e " then
        v115 = string.sub(p114, 4);
    elseif string.sub(p114, 1, 7) == "/emote " then
        v115 = string.sub(p114, 8);
    end;
    if u1 == "Standing" and u20[v115] ~= nil then
        playAnimation(v115, 0.1, l__Humanoid__2);
    end;
end);
script:WaitForChild("PlayEmote").OnInvoke = function(p116) --[[ Line: 770 ]]
    -- upvalues: u1 (ref), u20 (copy), l__Humanoid__2 (copy), u12 (ref)
    if u1 == "Standing" then
        if u20[p116] ~= nil then
            playAnimation(p116, 0.1, l__Humanoid__2);
            return true, u12;
        end;
        if typeof(p116) ~= "Instance" or not p116:IsA("Animation") then
            return false;
        end;
        playEmote(p116, 0.1, l__Humanoid__2);
        return true, u12;
    end;
end;
if l__Parent__1.Parent ~= nil then
    playAnimation("idle", 0.1, l__Humanoid__2);
    local _ = "Standing";
end;
while l__Parent__1.Parent ~= nil do
    local _, v117 = wait(0.1);
    stepAnimate(v117);
end;
