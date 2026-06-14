-- Decompiled from: Workspace.gi8r.Animate
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Humanoid__2 = l__Parent__1:WaitForChild("Humanoid");
local u1 = "Standing";
local function u2() --[[ Line: 7 ]]
    -- upvalues: l__Parent__1 (copy)
    return l__Parent__1:GetScale();
end;
local u3 = script:FindFirstChild("ScaleDampeningPercent");
local u4 = "";
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = 1;
local u9 = nil;
local u10 = nil;
local u11 = {};
local u12 = {};
local u13 = {
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
local u14 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
function resetManagerListeners()
    -- upvalues: u15 (ref), u16 (ref), u17 (ref)
    if u15 then
        u15:Disconnect();
        u15 = nil;
    end;
    if u16 then
        u16:Disconnect();
        u16 = nil;
    end;
    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;
end;
function processIfManagerBelongsToCharacter(u20)
    -- upvalues: l__Parent__1 (copy), u19 (ref), u18 (ref), u15 (ref), u16 (ref), u17 (ref)
    if u20.RootPart ~= l__Parent__1.PrimaryPart then
        return false;
    end;
    if u19 ~= u20 then
        resetManagerListeners();
        u18 = u20.GroundSensor;
        u15 = u20:GetPropertyChangedSignal("GroundSensor"):Connect(function() --[[ Line: 137 ]]
            -- upvalues: u20 (copy), u15 (ref)
            if processIfManagerBelongsToCharacter(u20) then
                u15:Disconnect();
                u15 = nil;
            end;
        end);
        u16 = u20:GetPropertyChangedSignal("RootPart"):Connect(function() --[[ Line: 143 ]]
            -- upvalues: u20 (copy), u16 (ref)
            if processIfManagerBelongsToCharacter(u20) then
                u16:Disconnect();
                u16 = nil;
            end;
        end);
        u17 = u20.AncestryChanged:Connect(function(_, p21) --[[ Line: 149 ]]
            if p21 == nil then
                resetManagerListeners();
                lookForControllerManager();
            end;
        end);
        u19 = u20;
    end;
    return true;
end;
function lookForControllerManager()
    -- upvalues: u18 (ref), u19 (ref), l__Parent__1 (copy)
    u18 = nil;
    u19 = nil;
    local v22 = l__Parent__1:FindFirstChildOfClass("ControllerManager");
    if v22 then
        processIfManagerBelongsToCharacter(v22);
    end;
    if u19 == nil then
        local u23 = nil;
        u23 = l__Parent__1.ChildAdded:Connect(function(p24) --[[ Line: 177 ]]
            -- upvalues: u23 (ref)
            if p24:IsA("ControllerManager") and processIfManagerBelongsToCharacter(p24) then
                u23:Disconnect();
                u23 = nil;
            end;
        end);
    end;
end;
lookForControllerManager();
math.randomseed(tick());
function findExistingAnimationInSet(p25, p26)
    if p25 == nil or p26 == nil then
        return 0;
    end;
    for v27 = 1, p25.count do
        if p25[v27].anim.AnimationId == p26.AnimationId then
            return v27;
        end;
    end;
    return 0;
end;
function configureAnimationSet(u28, u29)
    -- upvalues: u12 (copy), u11 (copy), l__Humanoid__2 (copy)
    if u12[u28] ~= nil then
        for _, v30 in pairs(u12[u28].connections) do
            v30:disconnect();
        end;
    end;
    u12[u28] = {};
    u12[u28].count = 0;
    u12[u28].totalWeight = 0;
    u12[u28].connections = {};
    local u31 = true;
    local v32, _ = pcall(function() --[[ Line: 218 ]]
        -- upvalues: u31 (ref)
        u31 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u31 = not v32 and true or u31;
    local v33 = script:FindFirstChild(u28);
    if u31 and v33 ~= nil then
        table.insert(u12[u28].connections, v33.ChildAdded:connect(function(_) --[[ Line: 226 ]]
            -- upvalues: u28 (copy), u29 (copy)
            configureAnimationSet(u28, u29);
        end));
        table.insert(u12[u28].connections, v33.ChildRemoved:connect(function(_) --[[ Line: 227 ]]
            -- upvalues: u28 (copy), u29 (copy)
            configureAnimationSet(u28, u29);
        end));
        for _, v34 in pairs(v33:GetChildren()) do
            if v34:IsA("Animation") then
                local v35 = v34:FindFirstChild("Weight");
                local v36 = v35 == nil and 1 or v35.Value;
                u12[u28].count = u12[u28].count + 1;
                local l__count__3 = u12[u28].count;
                u12[u28][l__count__3] = {};
                u12[u28][l__count__3].anim = v34;
                u12[u28][l__count__3].weight = v36;
                u12[u28].totalWeight = u12[u28].totalWeight + u12[u28][l__count__3].weight;
                table.insert(u12[u28].connections, v34.Changed:connect(function(_) --[[ Line: 243 ]]
                    -- upvalues: u28 (copy), u29 (copy)
                    configureAnimationSet(u28, u29);
                end));
                table.insert(u12[u28].connections, v34.ChildAdded:connect(function(_) --[[ Line: 244 ]]
                    -- upvalues: u28 (copy), u29 (copy)
                    configureAnimationSet(u28, u29);
                end));
                table.insert(u12[u28].connections, v34.ChildRemoved:connect(function(_) --[[ Line: 245 ]]
                    -- upvalues: u28 (copy), u29 (copy)
                    configureAnimationSet(u28, u29);
                end));
            end;
        end;
    end;
    if u12[u28].count <= 0 then
        for v37, v38 in pairs(u29) do
            u12[u28][v37] = {};
            u12[u28][v37].anim = Instance.new("Animation");
            u12[u28][v37].anim.Name = u28;
            u12[u28][v37].anim.AnimationId = v38.id;
            u12[u28][v37].weight = v38.weight;
            u12[u28].count = u12[u28].count + 1;
            u12[u28].totalWeight = u12[u28].totalWeight + v38.weight;
        end;
    end;
    for _, v39 in pairs(u12) do
        for v40 = 1, v39.count do
            if u11[v39[v40].anim.AnimationId] == nil then
                l__Humanoid__2:LoadAnimation(v39[v40].anim);
                u11[v39[v40].anim.AnimationId] = true;
            end;
        end;
    end;
end;
function configureAnimationSetOld(u41, u42)
    -- upvalues: u12 (copy), l__Humanoid__2 (copy)
    if u12[u41] ~= nil then
        for _, v43 in pairs(u12[u41].connections) do
            v43:disconnect();
        end;
    end;
    u12[u41] = {};
    u12[u41].count = 0;
    u12[u41].totalWeight = 0;
    u12[u41].connections = {};
    local u44 = true;
    local v45, _ = pcall(function() --[[ Line: 289 ]]
        -- upvalues: u44 (ref)
        u44 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u44 = not v45 and true or u44;
    local v46 = script:FindFirstChild(u41);
    if u44 and v46 ~= nil then
        table.insert(u12[u41].connections, v46.ChildAdded:connect(function(_) --[[ Line: 297 ]]
            -- upvalues: u41 (copy), u42 (copy)
            configureAnimationSet(u41, u42);
        end));
        table.insert(u12[u41].connections, v46.ChildRemoved:connect(function(_) --[[ Line: 298 ]]
            -- upvalues: u41 (copy), u42 (copy)
            configureAnimationSet(u41, u42);
        end));
        local v47 = 1;
        for _, v48 in pairs(v46:GetChildren()) do
            if v48:IsA("Animation") then
                table.insert(u12[u41].connections, v48.Changed:connect(function(_) --[[ Line: 302 ]]
                    -- upvalues: u41 (copy), u42 (copy)
                    configureAnimationSet(u41, u42);
                end));
                u12[u41][v47] = {};
                u12[u41][v47].anim = v48;
                local v49 = v48:FindFirstChild("Weight");
                if v49 == nil then
                    u12[u41][v47].weight = 1;
                else
                    u12[u41][v47].weight = v49.Value;
                end;
                u12[u41].count = u12[u41].count + 1;
                u12[u41].totalWeight = u12[u41].totalWeight + u12[u41][v47].weight;
                v47 = v47 + 1;
            end;
        end;
    end;
    if u12[u41].count <= 0 then
        for v50, v51 in pairs(u42) do
            u12[u41][v50] = {};
            u12[u41][v50].anim = Instance.new("Animation");
            u12[u41][v50].anim.Name = u41;
            u12[u41][v50].anim.AnimationId = v51.id;
            u12[u41][v50].weight = v51.weight;
            u12[u41].count = u12[u41].count + 1;
            u12[u41].totalWeight = u12[u41].totalWeight + v51.weight;
        end;
    end;
    for _, v52 in pairs(u12) do
        for v53 = 1, v52.count do
            l__Humanoid__2:LoadAnimation(v52[v53].anim);
        end;
    end;
end;
function scriptChildModified(p54)
    -- upvalues: u13 (copy)
    local v55 = u13[p54.Name];
    if v55 ~= nil then
        configureAnimationSet(p54.Name, v55);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v56;
if l__Humanoid__2 then
    v56 = l__Humanoid__2:FindFirstChildOfClass("Animator");
else
    v56 = nil;
end;
local u57, u58;
if v56 then
    local v59 = v56:GetPlayingAnimationTracks();
    u57 = u19;
    u58 = u18;
    for _, v60 in ipairs(v59) do
        v60:Stop(0);
        v60:Destroy();
    end;
else
    u57 = u19;
    u58 = u18;
end;
for v61, v62 in pairs(u13) do
    configureAnimationSet(v61, v62);
end;
local u63 = "None";
local u64 = 0;
local u65 = 0;
local u66 = false;
function stopAllAnimations()
    -- upvalues: u4 (ref), u14 (copy), u66 (ref), u5 (ref), u7 (ref), u6 (ref), u10 (ref), u9 (ref)
    local v67 = u4;
    local v68 = u14[v67] ~= nil and u14[v67] == false and "idle" or v67;
    if u66 then
        v68 = "idle";
        u66 = false;
    end;
    u4 = "";
    u5 = nil;
    if u7 ~= nil then
        u7:disconnect();
    end;
    if u6 ~= nil then
        u6:Stop();
        u6:Destroy();
        u6 = nil;
    end;
    if u10 ~= nil then
        u10:disconnect();
    end;
    if u9 ~= nil then
        u9:Stop();
        u9:Destroy();
        u9 = nil;
    end;
    return v68;
end;
function getHeightScale()
    -- upvalues: l__Humanoid__2 (copy), u2 (copy), u3 (ref)
    if not l__Humanoid__2 then
        return u2();
    end;
    if not l__Humanoid__2.AutomaticScalingEnabled then
        return u2();
    end;
    local v69 = l__Humanoid__2.HipHeight / 2;
    if u3 == nil then
        u3 = script:FindFirstChild("ScaleDampeningPercent");
    end;
    if u3 ~= nil then
        v69 = 1 + (l__Humanoid__2.HipHeight - 2) * u3.Value / 2;
    end;
    return v69;
end;
local function u75(p70) --[[ Line: 449 ]]
    -- upvalues: u6 (ref), u9 (ref)
    local v71 = p70 * 1.25 / getHeightScale();
    local v72 = 0.0001;
    local v73 = 0.0001;
    local v74 = 1;
    if v71 <= 0.5 then
        v74 = v71 / 0.5;
        v72 = 1;
    elseif v71 < 1 then
        v73 = (v71 - 0.5) / 0.5;
        v72 = 1 - v73;
    else
        v74 = v71 / 1;
        v73 = 1;
    end;
    u6:AdjustWeight(v72);
    u9:AdjustWeight(v73);
    u6:AdjustSpeed(v74);
    u9:AdjustSpeed(v74);
end;
function setAnimationSpeed(p76)
    -- upvalues: u4 (ref), u75 (copy), u8 (ref), u6 (ref)
    if u4 == "walk" then
        u75(p76);
    else
        if p76 ~= u8 then
            u8 = p76;
            u6:AdjustSpeed(u8);
        end;
    end;
end;
function keyFrameReachedFunc(p77)
    -- upvalues: u4 (ref), u9 (ref), u6 (ref), u14 (copy), u66 (ref), u8 (ref), l__Humanoid__2 (copy)
    if p77 == "End" then
        if u4 == "walk" then
            if u9.Looped ~= true then
                u9.TimePosition = 0;
            end;
            if u6.Looped ~= true then
                u6.TimePosition = 0;
            end;
        else
            local v78 = u4;
            local v79 = u14[v78] ~= nil and u14[v78] == false and "idle" or v78;
            if u66 then
                if u6.Looped then
                    return;
                end;
                v79 = "idle";
                u66 = false;
            end;
            local v80 = u8;
            playAnimation(v79, 0.15, l__Humanoid__2);
            setAnimationSpeed(v80);
        end;
    end;
end;
function rollAnimation(p81)
    -- upvalues: u12 (copy)
    local v82 = math.random(1, u12[p81].totalWeight);
    local v83 = 1;
    while u12[p81][v83].weight < v82 do
        v82 = v82 - u12[p81][v83].weight;
        v83 = v83 + 1;
    end;
    return v83;
end;
local function u89(p84, p85, p86, p87) --[[ Line: 530 ]]
    -- upvalues: u5 (ref), u6 (ref), u9 (ref), u8 (ref), u4 (ref), u7 (ref), u12 (copy), u10 (ref)
    if p84 ~= u5 then
        if u6 ~= nil then
            u6:Stop(p86);
            u6:Destroy();
        end;
        if u9 ~= nil then
            u9:Stop(p86);
            u9:Destroy();
            u9 = nil;
        end;
        u8 = 1;
        u6 = p87:LoadAnimation(p84);
        u6.Priority = Enum.AnimationPriority.Core;
        u6:Play(p86);
        u4 = p85;
        u5 = p84;
        if u7 ~= nil then
            u7:disconnect();
        end;
        u7 = u6.KeyframeReached:connect(keyFrameReachedFunc);
        if p85 == "walk" then
            local v88 = rollAnimation("run");
            u9 = p87:LoadAnimation(u12.run[v88].anim);
            u9.Priority = Enum.AnimationPriority.Core;
            u9:Play(p86);
            if u10 ~= nil then
                u10:disconnect();
            end;
            u10 = u9.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;
function playAnimation(p90, p91, p92)
    -- upvalues: u12 (copy), u89 (copy), u66 (ref)
    local v93 = rollAnimation(p90);
    u89(u12[p90][v93].anim, p90, p91, p92);
    u66 = false;
end;
function playEmote(p94, p95, p96)
    -- upvalues: u89 (copy), u66 (ref)
    u89(p94, p94.Name, p95, p96);
    u66 = true;
end;
local u97 = "";
local u98 = nil;
local u99 = nil;
local u100 = nil;
function toolKeyFrameReachedFunc(p101)
    -- upvalues: u97 (ref), l__Humanoid__2 (copy)
    if p101 == "End" then
        playToolAnimation(u97, 0, l__Humanoid__2);
    end;
end;
function playToolAnimation(p102, p103, p104, p105)
    -- upvalues: u12 (copy), u99 (ref), u98 (ref), u97 (ref), u100 (ref)
    local v106 = rollAnimation(p102);
    local l__anim__4 = u12[p102][v106].anim;
    if u99 ~= l__anim__4 then
        if u98 ~= nil then
            u98:Stop();
            u98:Destroy();
            p103 = 0;
        end;
        u98 = p104:LoadAnimation(l__anim__4);
        if p105 then
            u98.Priority = p105;
        end;
        u98:Play(p103);
        u97 = p102;
        u99 = l__anim__4;
        u100 = u98.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
function stopToolAnimations()
    -- upvalues: u97 (ref), u100 (ref), u99 (ref), u98 (ref)
    local v107 = u97;
    if u100 ~= nil then
        u100:disconnect();
    end;
    u97 = "";
    u99 = nil;
    if u98 ~= nil then
        u98:Stop();
        u98:Destroy();
        u98 = nil;
    end;
    return v107;
end;
function onRunning(p108)
    -- upvalues: u58 (ref), l__Humanoid__2 (copy), u57 (ref), u66 (ref), u1 (ref), u14 (copy), u4 (ref)
    local v109 = getHeightScale();
    if u58 ~= nil and l__Humanoid__2.EvaluateStateMachine == false then
        local l__RootPart__5 = l__Humanoid__2.RootPart;
        local l__SensedPart__6 = u58.SensedPart;
        if l__SensedPart__6 then
            local v110 = l__SensedPart__6:GetVelocityAtPosition(u58.HitFrame.Position);
            local l__AssemblyLinearVelocity__7 = l__RootPart__5.AssemblyLinearVelocity;
            local l__Magnitude__8 = Vector3.new(l__AssemblyLinearVelocity__7.X - v110.X, 0, l__AssemblyLinearVelocity__7.Z - v110.Z).Magnitude;
            local l__Magnitude__9 = u57.MovingDirection.Magnitude;
            if l__Magnitude__9 < 0.1 then
                l__Magnitude__8 = 0;
                l__Magnitude__9 = 0;
            elseif l__Magnitude__9 > 1 then
                l__Magnitude__9 = 1;
            end;
            p108 = l__Magnitude__8 * l__Magnitude__9;
        end;
    end;
    local v111 = u66;
    if v111 then
        v111 = l__Humanoid__2.MoveDirection == Vector3.new(0, 0, 0);
    end;
    if (v111 and (l__Humanoid__2.WalkSpeed / v109 or 0.75) or 0.75) * v109 < p108 then
        playAnimation("walk", 0.2, l__Humanoid__2);
        setAnimationSpeed(p108 / 16);
        u1 = "Running";
    else
        if u14[u4] == nil and not u66 then
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
    -- upvalues: l__Humanoid__2 (copy), u65 (ref), u1 (ref)
    playAnimation("jump", 0.1, l__Humanoid__2);
    u65 = 0.31;
    u1 = "Jumping";
end;
function onClimbing(p112)
    -- upvalues: l__Humanoid__2 (copy), u1 (ref)
    local v113 = p112 / getHeightScale();
    playAnimation("climb", 0.1, l__Humanoid__2);
    setAnimationSpeed(v113 / 5);
    u1 = "Climbing";
end;
function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;
function onFreeFall()
    -- upvalues: u65 (ref), l__Humanoid__2 (copy), u1 (ref)
    if u65 <= 0 then
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
function onSwimming(p114)
    -- upvalues: l__Humanoid__2 (copy), u1 (ref)
    local v115 = p114 / getHeightScale();
    if v115 > 1 then
        playAnimation("swim", 0.4, l__Humanoid__2);
        setAnimationSpeed(v115 / 10);
        u1 = "Swimming";
    else
        playAnimation("swimidle", 0.4, l__Humanoid__2);
        u1 = "Standing";
    end;
end;
function animateTool()
    -- upvalues: u63 (ref), l__Humanoid__2 (copy)
    if u63 == "None" then
        playToolAnimation("toolnone", 0.1, l__Humanoid__2, Enum.AnimationPriority.Idle);
    elseif u63 == "Slash" then
        playToolAnimation("toolslash", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
    elseif u63 == "Lunge" then
        playToolAnimation("toollunge", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
    end;
end;
function getToolAnim(p116)
    for _, v117 in ipairs(p116:GetChildren()) do
        if v117.Name == "toolanim" and v117.className == "StringValue" then
            return v117;
        end;
    end;
    return nil;
end;
local u118 = 0;
function stepAnimate(p119)
    -- upvalues: u118 (ref), u65 (ref), u1 (ref), l__Humanoid__2 (copy), l__Parent__1 (copy), u63 (ref), u64 (ref), u99 (ref)
    local v120 = p119 - u118;
    u118 = p119;
    if u65 > 0 then
        u65 = u65 - v120;
    end;
    if u1 == "FreeFall" and u65 <= 0 then
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
    local v121 = l__Parent__1:FindFirstChildOfClass("Tool");
    if v121 and v121:FindFirstChild("Handle") then
        local v122 = getToolAnim(v121);
        if v122 then
            u63 = v122.Value;
            v122.Parent = nil;
            u64 = p119 + 0.3;
        end;
        if u64 < p119 then
            u64 = 0;
            u63 = "None";
        end;
        animateTool();
    else
        stopToolAnimations();
        u63 = "None";
        u99 = nil;
        u64 = 0;
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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p123) --[[ Line: 850 ]]
    -- upvalues: u1 (ref), u14 (copy), l__Humanoid__2 (copy)
    local v124 = "";
    if string.sub(p123, 1, 3) == "/e " then
        v124 = string.sub(p123, 4);
    elseif string.sub(p123, 1, 7) == "/emote " then
        v124 = string.sub(p123, 8);
    end;
    if u1 == "Standing" and u14[v124] ~= nil then
        playAnimation(v124, 0.1, l__Humanoid__2);
    end;
end);
script:WaitForChild("PlayEmote").OnInvoke = function(p125) --[[ Line: 864 ]]
    -- upvalues: u1 (ref), u14 (copy), l__Humanoid__2 (copy), u6 (ref)
    if u1 == "Standing" then
        if u14[p125] ~= nil then
            playAnimation(p125, 0.1, l__Humanoid__2);
            return true, u6;
        end;
        if typeof(p125) ~= "Instance" or not p125:IsA("Animation") then
            return false;
        end;
        playEmote(p125, 0.1, l__Humanoid__2);
        return true, u6;
    end;
end;
if l__Parent__1.Parent ~= nil then
    playAnimation("idle", 0.1, l__Humanoid__2);
    local _ = "Standing";
end;
while l__Parent__1.Parent ~= nil do
    local _, v126 = wait(0.1);
    stepAnimate(v126);
end;
