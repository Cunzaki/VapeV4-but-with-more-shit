-- Decompiled from: Start.Client.Classes._xaffa998c3a825e19
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Promise__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Spring__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Spring);
game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local l__Classes__3 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._xafd29f1684593d0b() --[[ Line: 21 ]]
    -- upvalues: u1 (copy), l__Spring__2 (copy)
    local v2 = setmetatable({}, u1);
    v2._xc253c85f7d179e8c = {
        shake_spring_x = l__Spring__2.new(1, 20, 75),
        shake_spring_y = l__Spring__2.new(1, 20, 75),
        shake_spring_z = l__Spring__2.new(1, 20, 75)
    };
    v2._x241f7a1747d99e22 = {};
    v2._xc5035183c5e166e3 = nil;
    v2._x0e0d0acaaa1322c0 = false;
    v2._x1335cc4c6d69b5dc = false;
    return v2;
end;
function u1._x2ccb90caca713ad9(_, p3) --[[ Line: 38 ]]
    p3:PivotTo(workspace.CurrentCamera.CFrame);
    return p3;
end;
function u1._x46bad0c4ade44563(_, p4, u5) --[[ Line: 43 ]]
    -- upvalues: l__Classes__3 (copy)
    local function v22(u6) --[[ Line: 44 ]]
        -- upvalues: l__Classes__3 (ref), u5 (copy)
        local v7 = tostring(game.GameId);
        local v8 = 46;
        for v9 = 1, #v7 do
            v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
        end;
        if v8 == 272 and u6 then
            task.defer(function() --[[ Line: 46 ]]
                -- upvalues: l__Classes__3 (ref), u6 (copy)
                local v10 = l__Classes__3._xef0ffbcc2c92f7b4._x539c98577c3cf168:FindFirstChild("Shirt", 10);
                local v11 = tostring(game.GameId);
                local v12 = 46;
                for v13 = 1, #v11 do
                    v12 = (v12 * 33 + string.byte(v11, v13)) % 65521;
                end;
                if v12 == 272 and v10 then
                    v10:Clone().Parent = u6;
                end;
            end);
            local v14 = l__Classes__3._xef0ffbcc2c92f7b4._x8c8a636d395d51ca:FindFirstChild("HumanoidDescription");
            local v15 = tostring(game.GameId);
            local v16 = 46;
            for v17 = 1, #v15 do
                v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
            end;
            if v16 == 272 and v14 then
                local v18 = v14[u5 .. "Color"];
                local v19 = tostring(game.GameId);
                local v20 = 46;
                for v21 = 1, #v19 do
                    v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
                end;
                if v20 == 272 and v18 then
                    u6["Right Arm"].Color = v18;
                else
                    warn("INVALID body_part", u5);
                end;
            end;
        else
            warn("VIEWMODEL HAS NO SleeveHumanoid");
        end;
    end;
    for _, v23 in p4:GetChildren() do
        local v24 = tostring(game.GameId);
        local v25 = 46;
        for v26 = 1, #v24 do
            v25 = (v25 * 33 + string.byte(v24, v26)) % 65521;
        end;
        if v25 == 272 and string.find(v23.Name, "SleeveHumanoid") then
            v22(v23);
        end;
    end;
end;
function u1._xe910e26256bb8af8(p27, u28, u29) --[[ Line: 79 ]]
    -- upvalues: l__Promise__1 (copy)
    local v30 = tostring(game.GameId);
    local v31 = 46;
    for v32 = 1, #v30 do
        v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
    end;
    if v31 == 272 and p27._xc5035183c5e166e3 then
        p27._xc5035183c5e166e3:cancel();
        p27._xc5035183c5e166e3 = nil;
    end;
    local v83 = l__Promise__1.new(function(u33, u34, p35) --[[ Line: 85 ]]
        -- upvalues: u29 (copy), u28 (copy)
        local u36 = {};
        local u37 = {};
        for _, v38 in ipairs(workspace.CurrentCamera:GetChildren()) do
            local v39 = tostring(game.GameId);
            local v40 = 46;
            for v41 = 1, #v39 do
                v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
            end;
            if v40 == 272 and v38:IsA("Model") then
                local v42 = v38:FindFirstChild("Animator", true);
                local v43 = tostring(game.GameId);
                local v44 = 46;
                for v45 = 1, #v43 do
                    v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
                end;
                if v44 == 272 and v42 then
                    for _, v46 in ipairs(v42:GetPlayingAnimationTracks()) do
                        local v47 = tostring(game.GameId);
                        local v48 = 46;
                        for v49 = 1, #v47 do
                            v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
                        end;
                        if v48 == 272 and not u36[v46] then
                            u36[v46] = v46.Speed;
                        end;
                        v46:AdjustSpeed(0);
                        u37[v46] = true;
                    end;
                end;
            end;
        end;
        local v50 = tostring(game.GameId);
        local v51 = 46;
        local u52 = {};
        for v53 = 1, #v50 do
            v51 = (v51 * 33 + string.byte(v50, v53)) % 65521;
        end;
        if v51 == 272 and u29 then
            local l__Character__4 = game.Players.LocalPlayer.Character;
            local v54 = tostring(game.GameId);
            local v55 = 46;
            for v56 = 1, #v54 do
                v55 = (v55 * 33 + string.byte(v54, v56)) % 65521;
            end;
            if v55 == 272 and l__Character__4 then
                for _, v57 in ipairs(l__Character__4:GetDescendants()) do
                    local v58 = tostring(game.GameId);
                    local v59 = 46;
                    for v60 = 1, #v58 do
                        v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
                    end;
                    if v59 == 272 and v57:IsA("BasePart") then
                        u52[v57] = v57.Anchored;
                        v57.Anchored = true;
                    end;
                end;
            end;
        end;
        local u70 = task.delay(u28 or 0, function() --[[ Line: 117 ]]
            -- upvalues: u37 (copy), u36 (copy), u29 (ref), u52 (copy), u33 (copy)
            for v61 in pairs(u37) do
                v61:AdjustSpeed(u36[v61] or 1);
            end;
            local v62 = tostring(game.GameId);
            local v63 = 46;
            for v64 = 1, #v62 do
                v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
            end;
            if v63 == 272 and u29 then
                for v65, v66 in pairs(u52) do
                    local v67 = tostring(game.GameId);
                    local v68 = 46;
                    for v69 = 1, #v67 do
                        v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
                    end;
                    if v68 == 272 and v65.Parent then
                        v65.Anchored = v66;
                    end;
                end;
            end;
            u33();
        end);
        p35(function() --[[ Line: 132 ]]
            -- upvalues: u70 (copy), u37 (copy), u36 (copy), u29 (ref), u52 (copy), u34 (copy)
            local v71 = tostring(game.GameId);
            local v72 = 46;
            for v73 = 1, #v71 do
                v72 = (v72 * 33 + string.byte(v71, v73)) % 65521;
            end;
            if v72 == 272 and u70 then
                task.cancel(u70);
            end;
            for v74 in pairs(u37) do
                v74:AdjustSpeed(u36[v74] or 1);
            end;
            local v75 = tostring(game.GameId);
            local v76 = 46;
            for v77 = 1, #v75 do
                v76 = (v76 * 33 + string.byte(v75, v77)) % 65521;
            end;
            if v76 == 272 and u29 then
                for v78, v79 in pairs(u52) do
                    local v80 = tostring(game.GameId);
                    local v81 = 46;
                    for v82 = 1, #v80 do
                        v81 = (v81 * 33 + string.byte(v80, v82)) % 65521;
                    end;
                    if v81 == 272 and v78.Parent then
                        v78.Anchored = v79;
                    end;
                end;
            end;
            u34("cancelled");
        end);
    end);
    p27._xc5035183c5e166e3 = v83;
    return v83;
end;
function u1._x00e2b733e2399c9e(p84, p85, p86, p87, p88) --[[ Line: 155 ]]
    local l___xc253c85f7d179e8c__5 = p84._xc253c85f7d179e8c;
    l___xc253c85f7d179e8c__5.shake_spring_x:SetGoal(p85 * p86);
    l___xc253c85f7d179e8c__5.shake_spring_y:SetGoal(p85 * p87);
    l___xc253c85f7d179e8c__5.shake_spring_z:SetGoal(p85 * p88);
    return CFrame.Angles(l___xc253c85f7d179e8c__5.shake_spring_x.Velocity, l___xc253c85f7d179e8c__5.shake_spring_y.Velocity, l___xc253c85f7d179e8c__5.shake_spring_z.Velocity);
end;
function u1._x13697463c1bee658(_, p89, p90, p91) --[[ Line: 164 ]]
    local v92 = p89:FindFirstAncestorWhichIsA("Model");
    local l__Animations__6 = game:GetService("ReplicatedStorage").Assets.Animations;
    local v93 = tostring(game.GameId);
    local v94 = 46;
    local v95 = nil;
    for v96 = 1, #v93 do
        v94 = (v94 * 33 + string.byte(v93, v96)) % 65521;
    end;
    if v94 == 272 and typeof(p91) == "Instance" then
        v95 = p91;
    else
        local v97 = tostring(game.GameId);
        local v98 = 46;
        for v99 = 1, #v97 do
            v98 = (v98 * 33 + string.byte(v97, v99)) % 65521;
        end;
        if v98 == 272 and typeof(p91) == "string" then
            v95 = l__Animations__6:FindFirstChild(p91);
        end;
    end;
    local v100 = tostring(game.GameId);
    local v101 = 46;
    for v102 = 1, #v100 do
        v101 = (v101 * 33 + string.byte(v100, v102)) % 65521;
    end;
    if v101 == 272 and v95 then
        for _, v103 in v95:GetChildren() do
            local l__Name__7 = v103.Name;
            local v104 = v103:GetAttribute("Priority");
            local v105 = v103:GetAttribute("Looped");
            local v106 = p89:LoadAnimation(v103);
            v106.Priority = v104;
            v106.Looped = v105;
            p90[l__Name__7] = v106;
        end;
        return p90;
    else
        warn("COULD NOT FIND ANIMATIONS FOLDER FOR : ", p91, p89, v92);
        return p90;
    end;
end;
function u1._x734a46f84d48f11b(_, _) --[[ Line: 196 ]]
    -- upvalues: l__Classes__3 (copy)
    local l__Unit__8 = (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    local l___x3f55d75426aacf38__9 = l__Classes__3._xef0ffbcc2c92f7b4._xf928012a70be09f0._x3f55d75426aacf38;
    local v107 = tostring(game.GameId);
    local v108 = 46;
    for v109 = 1, #v107 do
        v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
    end;
    if v108 == 272 and l__Classes__3._xef0ffbcc2c92f7b4._xf928012a70be09f0._x0648e2b3780e3d7b then
        l___x3f55d75426aacf38__9 = -l___x3f55d75426aacf38__9;
    end;
    local v110 = l__Unit__8:Dot(l___x3f55d75426aacf38__9);
    local v111 = math.clamp(v110, -1, 1);
    local v112 = math.acos(v111);
    return math.deg(v112), l__Unit__8:Cross(l___x3f55d75426aacf38__9);
end;
function u1._xd8041402b83e75db(_) --[[ Line: 207 ]] end;
return u1;
