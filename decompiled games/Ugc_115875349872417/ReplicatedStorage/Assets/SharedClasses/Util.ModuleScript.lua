-- Decompiled from: ReplicatedStorage.Assets.SharedClasses.Util
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("CollectionService");
local l__Promise__3 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.client_rendersteps = {};
    return v2;
end;
function u1.yenToCrimson(_, p3) --[[ Line: 21 ]]
    return p3 / 4000;
end;
function u1.deepCopyTable(p4, p5) --[[ Line: 25 ]]
    local v6 = {};
    for v7, v8 in pairs(p5) do
        if type(v8) == "table" then
            v6[v7] = p4:deepCopyTable(v8);
        else
            v6[v7] = v8;
        end;
    end;
    return v6;
end;
function u1.getContrastColor(_, p9) --[[ Line: 37 ]]
    if 0.299 * p9.R + 0.587 * p9.G + 0.114 * p9.B > 0.5 then
        return Color3.new(0, 0, 0);
    else
        return Color3.new(1, 1, 1);
    end;
end;
function u1.clampProximity(_, p10, p11, p12) --[[ Line: 47 ]]
    local v13 = p11 - p10;
    if p12 < v13.Magnitude then
        v13 = v13.Unit * p12;
    end;
    return p10 + v13;
end;
function u1.getClosestAlignment(_, p14, p15, p16) --[[ Line: 58 ]]
    if p14:Dot(p15) >= p14:Dot(p16) then
        return p15;
    else
        return p16;
    end;
end;
function u1.getDictionarySize(_, p17) --[[ Line: 70 ]]
    local v18 = 0;
    for _ in p17 do
        v18 = v18 + 1;
    end;
    return v18;
end;
function u1.randomizeTable(_, p19) --[[ Line: 78 ]]
    local v20 = {};
    if p19[1] ~= nil then
        for v21 = 1, #p19 do
            local v22 = math.random(1, #v20 + 1);
            table.insert(v20, v22, p19[v21]);
        end;
    end;
    return v20;
end;
function u1.shortenNumber(_, p23) --[[ Line: 88 ]]
    local v24 = math.floor(p23);
    if v24 >= 1000000000 then
        return "1B+";
    end;
    if v24 >= 1000000 then
        local v25 = v24 / 1000000;
        return v25 % 1 == 0 and v25 .. "M" or string.format("%.1fM", v25);
    end;
    if v24 < 1000 then
        return tostring(v24);
    end;
    local v26 = v24 / 1000;
    return v26 % 1 == 0 and v26 .. "K" or string.format("%.1fK", v26);
end;
function u1.getCircularUDimFromPosition(_, p27, p28) --[[ Line: 105 ]]
    local v29 = p27:PointToObjectSpace(p28);
    local v30 = math.atan2(v29.X, -v29.Z);
    local v31 = math.sin(v30) * 0.4 + 0.5;
    local v32 = 0.5 - math.cos(v30) * 0.4;
    return UDim2.fromScale(v31, v32);
end;
function u1.getBoundaryUDimFromPosition(_, p33, p34) --[[ Line: 116 ]]
    local v35 = p33:PointToObjectSpace(p34);
    local l__Unit__4 = Vector2.new(v35.X, -v35.Z).Unit;
    if l__Unit__4.Magnitude == 0 then
        return UDim2.fromScale(0.5, 0.5);
    end;
    local v36 = math.abs(l__Unit__4.X);
    local v37 = math.abs(l__Unit__4.Y);
    local v38;
    if v37 < v36 then
        v38 = 0.5 / v36;
    else
        v38 = 0.5 / v37;
    end;
    return UDim2.fromScale(0.5 + l__Unit__4.X * v38, 0.5 - l__Unit__4.Y * v38);
end;
function u1.vecIsBad(_, p39) --[[ Line: 136 ]]
    local l__X__5 = p39.X;
    local l__Y__6 = p39.Y;
    local l__Z__7 = p39.Z;
    return (l__X__5 ~= l__X__5 or (l__Y__6 ~= l__Y__6 or l__Z__7 ~= l__Z__7)) and true or (l__X__5 == (1 / 0) or (l__X__5 == (-1 / 0) or (l__Y__6 == (1 / 0) or (l__Y__6 == (-1 / 0) or (l__Z__7 == (1 / 0) or l__Z__7 == (-1 / 0))))));
end;
function u1.getServerType(_) --[[ Line: 147 ]]
    return game.PrivateServerId == "" and "StandardServer" or (game.PrivateServerOwnerId == 0 and "ReservedServer" or "VIPServer");
end;
function u1.getPublicDataOfUserId(_, p40, p41) --[[ Line: 159 ]]
    if p41 then
        local v42 = game:GetService("ReplicatedStorage").ReadOnly:FindFirstChild(p40);
        if v42 then
            return v42:FindFirstChild(p41);
        else
            return nil;
        end;
    else
        return game:GetService("ReplicatedStorage").ReadOnly:FindFirstChild(p40);
    end;
end;
function u1.hasLineOfSight(_, p43, p44) --[[ Line: 174 ]]
    -- upvalues: u1 (copy)
    if not (p43 and p44) then
        return false;
    end;
    local v45 = u1:getLikelyVec3(p43);
    local v46 = u1:getLikelyVec3(p44);
    local v47 = RaycastParams.new();
    v47.FilterType = Enum.RaycastFilterType.Include;
    v47.IgnoreWater = true;
    v47.FilterDescendantsInstances = { workspace.Map.Main };
    for _ = 1, 32 do
        local v48 = v46 - v45;
        if v48.Magnitude <= 0.001 then
            return true;
        end;
        local v49 = workspace:Raycast(v45, v48, v47);
        if not v49 then
            return true;
        end;
        local l__Instance__8 = v49.Instance;
        if not l__Instance__8:IsA("BasePart") or l__Instance__8.Transparency ~= 1 then
            return false, v49;
        end;
        v45 = v49.Position + v48.Unit * 0.01;
    end;
    return false;
end;
function u1.formatTime(_, p50, p51) --[[ Line: 211 ]]
    local v52 = p50 < 0;
    local v53 = math.abs(p50);
    local v54 = math.floor(v53);
    local v55 = math.floor(v54 / 3600);
    local v56 = math.floor(v54 % 3600 / 60);
    local v57 = v54 % 60;
    local v58;
    if v55 > 0 or p51 then
        v58 = string.format("%02d:%02d:%02d", v55, v56, v57);
    else
        v58 = string.format("%02d:%02d", v56, v57);
    end;
    if v52 then
        v58 = "-" .. v58 or v58;
    end;
    return v58;
end;
function u1.formatNumber(_, p59, p60) --[[ Line: 228 ]]
    local v61 = tostring(p59);
    local v62;
    if v61:sub(1, 1) == "-" then
        v61 = v61:sub(2);
        v62 = "-";
    else
        v62 = "";
    end;
    local v63, v64 = v61:match("^([^%.]+)(.*)$");
    local v65 = #v63;
    local v66 = {};
    for v67 = v65, 1, -1 do
        table.insert(v66, v63:sub(v67, v67));
    end;
    local v68 = {};
    for v69, v70 in ipairs(v66) do
        table.insert(v68, v70);
        if v69 % 3 == 0 and v69 < v65 then
            table.insert(v68, p60 or "\'");
        end;
    end;
    return v62 .. table.concat(v68):reverse() .. v64;
end;
function u1.normalizePair(_, p71, p72, p73) --[[ Line: 266 ]]
    local v74 = p71 ^ p73;
    local v75 = p72 ^ p73;
    local v76 = v74 + v75;
    if v76 == 0 then
        return 0, 0;
    else
        return v74 / v76, v75 / v76;
    end;
end;
function u1.getLikelyPart(_, p77) --[[ Line: 279 ]]
    if p77:IsA("Model") then
        return p77:FindFirstChild("Head") or p77.PrimaryPart or (p77:FindFirstChild("Torso") or p77:FindFirstChildWhichIsA("BasePart"));
    end;
    if p77:IsA("Part") then
        return p77.Position;
    end;
end;
function u1.getLikelyVec3(_, p78) --[[ Line: 288 ]]
    if typeof(p78) == "Vector3" then
        return p78;
    end;
    if typeof(p78) == "CFrame" then
        return p78.Position;
    end;
    if p78:IsA("Attachment") then
        return p78.WorldPosition;
    end;
    if p78:IsA("Model") then
        return (p78.PrimaryPart or (p78:FindFirstChild("Head") or p78:GetPivot())).Position;
    end;
    if p78:IsA("BasePart") then
        return p78.Position;
    end;
end;
function u1.dotToDegrees(_, p79) --[[ Line: 304 ]]
    local v80 = math.clamp(p79, -1, 1);
    local v81 = math.acos(v80);
    return math.deg(v81);
end;
function u1.degreesToDot(_, p82) --[[ Line: 311 ]]
    local v83 = math.rad(p82);
    local v84 = math.cos(v83);
    return math.clamp(v84, -1, 1);
end;
function u1.sortByClosest(_, u85, p86) --[[ Line: 317 ]]
    table.sort(p86, function(p87, p88) --[[ Line: 318 ]]
        -- upvalues: u85 (copy)
        return (p87.Position - u85).Magnitude < (p88.Position - u85).Magnitude;
    end);
    return p86;
end;
function u1.filter(_, p89, p90) --[[ Line: 324 ]]
    local v91 = {};
    for _, v92 in p89 do
        if p90(v92) then
            table.insert(v91, v92);
        end;
    end;
    return v91;
end;
function u1.randomizeDirection(_, p93, p94) --[[ Line: 334 ]]
    local l__Unit__9 = p93.Unit;
    local v95 = math.rad(p94);
    local v96 = 1 - math.random() * (1 - math.cos(v95));
    local v97 = math.acos(v96);
    local v98 = math.random() * 3.141592653589793 * 2;
    local v99 = math.sin(v97) * math.cos(v98);
    local v100 = math.sin(v97) * math.sin(v98);
    local v101 = math.cos(v97);
    local l__Unit__10 = l__Unit__9:Cross(math.abs(l__Unit__9.Y) < 0.999 and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 0)).Unit;
    local v102 = l__Unit__10:Cross(l__Unit__9);
    return (l__Unit__10 * v99 + v102 * v100 + l__Unit__9 * v101).Unit;
end;
function u1.getRandomPosInPart(_, p103) --[[ Line: 361 ]]
    local v104 = math.random() * p103.Size.X - p103.Size.X / 2;
    local v105 = math.random() * p103.Size.Y - p103.Size.Y / 2;
    local v106 = math.random() * p103.Size.Z - p103.Size.Z / 2;
    local v107 = Vector3.new(v104, v105, v106);
    return p103.CFrame:PointToWorldSpace(v107);
end;
function u1.getScaledVec3(_, p108, p109, p110) --[[ Line: 371 ]]
    local l__PrimaryPart__11 = p109.PrimaryPart;
    if l__PrimaryPart__11 then
        local l__Magnitude__12 = (p108.WorldPosition - l__PrimaryPart__11.Position).Magnitude;
        if l__Magnitude__12 ~= 0 then
            return (p108.WorldPosition - l__PrimaryPart__11.Position).Unit * (l__Magnitude__12 * (p110 / p109:GetScale()));
        end;
        warn("ZERO DIRECTION FOR base_model : " .. p109.Name);
    else
        warn("NO PRIMARY PART FOR base_model :" .. p109.Name);
    end;
end;
function u1.Vec2ToUDim2(_, p111) --[[ Line: 395 ]]
    return UDim2.fromOffset(p111.X, p111.Y);
end;
function u1.UDim2ToVec2(_, p112) --[[ Line: 399 ]]
    return Vector2.new(p112.X.Offset, p112.Y.Offset);
end;
function u1.getAnimSpeedFromDuration(_, p113, p114) --[[ Line: 403 ]]
    return p113.Length / p114;
end;
function u1.numLerp(_, p115, p116, p117) --[[ Line: 407 ]]
    return p115 + (p116 - p115) * p117;
end;
function u1.getSpawnCF(p118) --[[ Line: 411 ]]
    local v119 = workspace.Map.Spawnpoints:GetChildren();
    if #v119 <= 0 then
        warn("NO SPAWNPOINT!!");
        return CFrame.new(Vector3.new(148.314, 1937.203, -50.948));
    end;
    local v120 = v119[math.random(1, #v119)];
    local v121;
    if v120:IsA("Vector3Value") then
        v121 = v120.Value;
    else
        v121 = p118:getLikelyVec3(v120);
    end;
    return CFrame.new(v121);
end;
function u1.randomizeUnitVectorGaussian(_, p122, p123, p124) --[[ Line: 430 ]]
    local l__Unit__13 = p122.Unit;
    local v125 = math.rad(p123) * 0.5;
    local v126 = math.random();
    local v127 = math.max(v126, 1e-6);
    local v128 = math.random();
    local v129 = math.log(v127) * -2;
    local v130 = math.sqrt(v129);
    local v131 = v130 * math.cos(6.283185307179586 * v128);
    local _ = v130 * math.sin(6.283185307179586 * v128);
    local v132 = math.abs(v131 * (p124 or 0.4));
    local v133 = math.min(v132, v125);
    local v134 = 6.283185307179586 * math.random();
    local l__Unit__14 = l__Unit__13:Cross(math.abs(l__Unit__13.Y) < 0.999 and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 0)).Unit;
    local l__Unit__15 = l__Unit__14:Cross(l__Unit__13).Unit;
    return (l__Unit__13 * math.cos(v133) + l__Unit__14 * (math.sin(v133) * math.cos(v134)) + l__Unit__15 * (math.sin(v133) * math.sin(v134))).Unit;
end;
function u1.getBasicRaycastParams(_, p135) --[[ Line: 465 ]]
    local v136 = RaycastParams.new();
    v136.RespectCanCollide = true;
    v136.IgnoreWater = true;
    local v137 = {};
    local l__Map__16 = workspace.Map;
    if p135 then
        p135 = workspace.Entities;
    end;
    v137[1], v137[2] = l__Map__16, p135;
    v136.FilterDescendantsInstances = v137;
    v136.FilterType = Enum.RaycastFilterType.Include;
    return v136;
end;
function u1.fadeOutSound(_, u138, u139, u140) --[[ Line: 474 ]]
    -- upvalues: l__RunService__1 (copy), l__TweenService__2 (copy), l__Promise__3 (copy)
    local u141 = coroutine.create(function() --[[ Line: 475 ]]
        -- upvalues: u139 (copy), l__RunService__1 (ref), u138 (copy), u140 (copy), l__TweenService__2 (ref)
        while not u139() do
            l__RunService__1.Heartbeat:Wait();
        end;
        if u138 then
            l__TweenService__2:Create(u138, TweenInfo.new(u140 or 0.5), {
                Volume = 0
            }):Play();
        end;
    end);
    l__Promise__3.defer(function() --[[ Line: 486 ]]
        -- upvalues: u141 (copy)
        coroutine.resume(u141);
    end);
end;
function u1.convNumRange(_, p142, p143, p144, p145, p146) --[[ Line: 491 ]]
    if p143 == p144 or p145 == p146 then
        warn("convNumRange: zero input or output range; returning n_min:", debug.traceback());
        return p145;
    end;
    local v147 = math.min(p143, p144);
    local v148 = math.max(p143, p144);
    local v149 = math.min(p145, p146);
    local v150 = math.max(p145, p146);
    local v151 = math.clamp(p142, v147, v148);
    local v152;
    if p143 <= p144 then
        v152 = (v151 - v147) / (v148 - v147);
    else
        v152 = (v148 - v151) / (v148 - v147);
    end;
    local v153 = math.clamp(v152, 0, 1);
    local v154 = v149 + v153 * (v150 - v149);
    if p146 < p145 then
        v154 = v150 - v153 * (v150 - v149);
    end;
    return v154;
end;
function u1.cleanConnectionsTable(p155, p156) --[[ Line: 521 ]]
    local v157 = #p156;
    if v157 == 0 then
        return p156;
    end;
    for v158 = v157, 1, -1 do
        local v159 = p156[v158];
        if typeof(v159) == "RBXScriptConnection" then
            v159:Disconnect();
            p156[v158] = nil;
        elseif typeof(v159) == "table" and (v159.Disconnect and typeof(v159.Disconnect) == "function") then
            v159:Disconnect();
            p156[v158] = nil;
        elseif typeof(v159) == "thread" then
            xpcall(task.cancel, function(p160) --[[ Line: 533 ]]
                local v161 = debug.info(4, "n");
                warn(debug.traceback(string.format("Could not cancel thread for \"%s\": %s", v161 or "Unknown Function", p160)));
            end, v159);
            p156[v158] = nil;
        elseif typeof(v159) == "string" then
            p155:unbindRenderStepFromTable(p156, v159);
            p156[v158] = nil;
        end;
    end;
    return p156;
end;
function u1.bindRenderStepToTable(p162, p163, p164, p165, p166) --[[ Line: 546 ]]
    if not table.find(p163, p165) then
        table.insert(p163, p165);
        p162:bindToRenderStep(p165, p164, p166);
        return p163;
    end;
    warn("ATTEMPTED TO BIND PRE-EXISTING func_name : " .. p165 .. " UNBINDING PREVIOUS COPY");
    p162:unbindRenderStepFromTable(p163, p165);
    p162:bindToRenderStep(p165, p164, p166);
end;
function u1.unbindRenderStepFromTable(p167, p168, p169) --[[ Line: 561 ]]
    local v170 = table.find(p168, p169);
    if not v170 then
        return p168;
    end;
    p167:unbindFromRenderStep(p169, p168);
    table.remove(p168, v170);
    return p168;
end;
function u1.unbindFromRenderStep(p171, p172, p173) --[[ Line: 575 ]]
    -- upvalues: l__RunService__1 (copy)
    local v174 = table.find(p171.client_rendersteps, p172);
    if v174 then
        table.remove(p171.client_rendersteps, v174);
        l__RunService__1:UnbindFromRenderStep(p172);
    elseif p173 then
    end;
end;
function u1.bindToRenderStep(p175, p176, p177, p178) --[[ Line: 590 ]]
    -- upvalues: l__RunService__1 (copy)
    if table.find(p175.client_rendersteps, p176) then
        p175:unbindFromRenderStep(p176);
        l__RunService__1:BindToRenderStep(p176, p177, p178);
    else
        table.insert(p175.client_rendersteps, p176);
        l__RunService__1:BindToRenderStep(p176, p177, p178);
    end;
end;
function u1.vectorToCFrameAngles(_, p179) --[[ Line: 603 ]]
    return CFrame.Angles(p179.X, p179.Y, p179.Z);
end;
function u1.flatten(_, p180) --[[ Line: 607 ]]
    return Vector2.new(p180.X, p180.Y).Unit;
end;
function u1.easeInBack(_, p181, p182) --[[ Line: 611 ]]
    local v183 = p182 or 1.70158;
    return (v183 + 1) * p181 * p181 * p181 - v183 * p181 * p181;
end;
function u1.easeInExpo(_, p184) --[[ Line: 617 ]]
    return math.pow(2, 10 * p184 - 10);
end;
function u1.easeOutCirc(_, p185) --[[ Line: 621 ]]
    local v186 = 1 - math.pow(p185 - 1, 2);
    return math.sqrt(v186);
end;
function u1.easeInQuad(_, p187) --[[ Line: 625 ]]
    return p187 * p187;
end;
function u1.easeInCubic(_, p188) --[[ Line: 629 ]]
    return p188 * p188 * p188;
end;
function u1.easeInQuint(_, p189) --[[ Line: 633 ]]
    return p189 * p189 * p189 * p189 * p189;
end;
function u1.shorten(_, p190) --[[ Line: 637 ]]
    return tonumber(string.format("%.2f", p190));
end;
function u1.stopAnimations(_, p191) --[[ Line: 642 ]]
    for _, v192 in ipairs(p191:GetPlayingAnimationTracks()) do
        v192:Stop(0.001);
    end;
end;
function u1.Init(_) --[[ Line: 648 ]] end;
return u1;
