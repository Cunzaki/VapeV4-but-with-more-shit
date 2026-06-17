-- Decompiled from: Start.Client.Classes._xe0e88f94014b801e
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__Promise__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Spring__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Spring);
game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local l__Classes__3 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._x83ed94bfb82a8c9f() --[[ Line: 21 ]]
    -- upvalues: u1 (copy), l__Spring__2 (copy)
    local v2 = setmetatable({}, u1);
    v2._x6b5f13372c713ba8 = {
        shake_spring_x = l__Spring__2.new(1, 20, 75),
        shake_spring_y = l__Spring__2.new(1, 20, 75),
        shake_spring_z = l__Spring__2.new(1, 20, 75)
    };
    v2._x3741abac220619fd = {};
    v2._x9a72b1b4e8722932 = nil;
    v2._xa3fe4f9696ee59ce = false;
    v2._xa2afa8ee69af4cfa = false;
    return v2;
end;
function u1._xa7917e5545cc80d6(_, p3) --[[ Line: 38 ]]
    p3:PivotTo(workspace.CurrentCamera.CFrame);
    return p3;
end;
function u1._x99a92a621ee17c24(_, u4, u5) --[[ Line: 43 ]]
    -- upvalues: l__Classes__3 (copy)
    local function v10(u6) --[[ Line: 44 ]]
        -- upvalues: l__Classes__3 (ref), u5 (copy), u4 (copy)
        if u6 then
            task.defer(function() --[[ Line: 46 ]]
                -- upvalues: l__Classes__3 (ref), u6 (copy)
                local v7 = l__Classes__3._x1a4ce4062771e36e._x7c0477cd83a7fb82:FindFirstChild("Shirt", 10);
                if v7 then
                    v7:Clone().Parent = u6;
                end;
            end);
            local v8 = l__Classes__3._x1a4ce4062771e36e._x5b9cf15ca6de30f6:FindFirstChild("HumanoidDescription");
            if v8 then
                local v9 = v8[u5 .. "Color"];
                if v9 then
                    u6["Right Arm"].Color = v9;
                else
                    warn("INVALID body_part", u5, game.Players.LocalPlayer);
                end;
            end;
        else
            warn("VIEWMODEL HAS NO SleeveHumanoid : ", u4, game.Players.LocalPlayer);
        end;
    end;
    for _, v11 in u4:GetChildren() do
        if string.find(v11.Name, "SleeveHumanoid") then
            v10(v11);
        end;
    end;
end;
function u1._x45821945fb1d741b(p12, u13, u14) --[[ Line: 79 ]]
    -- upvalues: l__Promise__1 (copy)
    if p12._x9a72b1b4e8722932 then
        p12._x9a72b1b4e8722932:cancel();
        p12._x9a72b1b4e8722932 = nil;
    end;
    local v32 = l__Promise__1.new(function(u15, u16, p17) --[[ Line: 85 ]]
        -- upvalues: u14 (copy), u13 (copy)
        local u18 = {};
        local u19 = {};
        for _, v20 in ipairs(workspace.CurrentCamera:GetChildren()) do
            if v20:IsA("Model") then
                local v21 = v20:FindFirstChild("Animator", true);
                if v21 then
                    for _, v22 in ipairs(v21:GetPlayingAnimationTracks()) do
                        if not u18[v22] then
                            u18[v22] = v22.Speed;
                        end;
                        v22:AdjustSpeed(0);
                        u19[v22] = true;
                    end;
                end;
            end;
        end;
        local u23 = {};
        if u14 then
            local l__Character__4 = game.Players.LocalPlayer.Character;
            if l__Character__4 then
                for _, v24 in ipairs(l__Character__4:GetDescendants()) do
                    if v24:IsA("BasePart") then
                        u23[v24] = v24.Anchored;
                        v24.Anchored = true;
                    end;
                end;
            end;
        end;
        local u28 = task.delay(u13 or 0, function() --[[ Line: 117 ]]
            -- upvalues: u19 (copy), u18 (copy), u14 (ref), u23 (copy), u15 (copy)
            for v25 in pairs(u19) do
                v25:AdjustSpeed(u18[v25] or 1);
            end;
            if u14 then
                for v26, v27 in pairs(u23) do
                    if v26.Parent then
                        v26.Anchored = v27;
                    end;
                end;
            end;
            u15();
        end);
        p17(function() --[[ Line: 132 ]]
            -- upvalues: u28 (copy), u19 (copy), u18 (copy), u14 (ref), u23 (copy), u16 (copy)
            if u28 then
                task.cancel(u28);
            end;
            for v29 in pairs(u19) do
                v29:AdjustSpeed(u18[v29] or 1);
            end;
            if u14 then
                for v30, v31 in pairs(u23) do
                    if v30.Parent then
                        v30.Anchored = v31;
                    end;
                end;
            end;
            u16("cancelled");
        end);
    end);
    p12._x9a72b1b4e8722932 = v32;
    return v32;
end;
function u1._xfc87e2d0f240a915(p33, p34, p35, p36, p37) --[[ Line: 155 ]]
    local l___x6b5f13372c713ba8__5 = p33._x6b5f13372c713ba8;
    l___x6b5f13372c713ba8__5.shake_spring_x:SetGoal(p34 * p35);
    l___x6b5f13372c713ba8__5.shake_spring_y:SetGoal(p34 * p36);
    l___x6b5f13372c713ba8__5.shake_spring_z:SetGoal(p34 * p37);
    return CFrame.Angles(l___x6b5f13372c713ba8__5.shake_spring_x.Velocity, l___x6b5f13372c713ba8__5.shake_spring_y.Velocity, l___x6b5f13372c713ba8__5.shake_spring_z.Velocity);
end;
function u1._x2ee640861a885045(_, p38, p39, p40) --[[ Line: 164 ]]
    local v41 = p38:FindFirstAncestorWhichIsA("Model");
    local l__Animations__6 = game:GetService("ReplicatedStorage").Assets.Animations;
    local v42 = nil;
    if typeof(p40) == "Instance" then
        v42 = p40;
    elseif typeof(p40) == "string" then
        v42 = l__Animations__6:FindFirstChild(p40);
    end;
    if not v42 and v41 then
        v42 = l__Animations__6:FindFirstChild(v41.Name);
    end;
    if v42 then
        for _, v43 in v42:GetChildren() do
            local l__Name__7 = v43.Name;
            local v44 = v43:GetAttribute("Priority");
            local v45 = v43:GetAttribute("Looped");
            local v46 = p38:LoadAnimation(v43);
            v46.Priority = v44;
            v46.Looped = v45;
            p39[l__Name__7] = v46;
        end;
        return p39;
    else
        warn("COULD NOT FIND ANIMATIONS FOLDER FOR : ", p40, p38, v41);
        return p39;
    end;
end;
function u1._xe06ac9b0519e0083(_, _) --[[ Line: 200 ]]
    -- upvalues: l__Classes__3 (copy)
    local l__Unit__8 = (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    local l___x53e94b51b4ca2b03__9 = l__Classes__3._x1a4ce4062771e36e._x951b8a58c97ff8ca._x53e94b51b4ca2b03;
    if l__Classes__3._x1a4ce4062771e36e._x951b8a58c97ff8ca._x233608aa6099009b then
        l___x53e94b51b4ca2b03__9 = -l___x53e94b51b4ca2b03__9;
    end;
    local v47 = l__Unit__8:Dot(l___x53e94b51b4ca2b03__9);
    local v48 = math.clamp(v47, -1, 1);
    local v49 = math.acos(v48);
    return math.deg(v49), l__Unit__8:Cross(l___x53e94b51b4ca2b03__9);
end;
function u1._x44bcd6af41218f92(_) --[[ Line: 211 ]] end;
return u1;
