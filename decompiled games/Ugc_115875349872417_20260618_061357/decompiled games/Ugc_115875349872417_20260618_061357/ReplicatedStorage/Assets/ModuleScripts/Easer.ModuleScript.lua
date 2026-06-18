-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Easer
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Promise__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local u1 = {};
u1.__index = u1;
local u18 = {
    Linear = function(p2) --[[ Name: Linear, Line 7 ]]
        return p2;
    end,
    QuadIn = function(p3) --[[ Name: QuadIn, Line 8 ]]
        return p3 * p3;
    end,
    QuadOut = function(p4) --[[ Name: QuadOut, Line 9 ]]
        return 1 - (1 - p4) * (1 - p4);
    end,
    QuadInOut = function(p5) --[[ Name: QuadInOut, Line 10 ]]
        if p5 < 0.5 then
            return 2 * p5 * p5;
        else
            return 1 - 2 * (1 - p5) * (1 - p5);
        end;
    end,
    CubicIn = function(p6) --[[ Name: CubicIn, Line 11 ]]
        return p6 ^ 3;
    end,
    CubicOut = function(p7) --[[ Name: CubicOut, Line 12 ]]
        return 1 - (1 - p7) ^ 3;
    end,
    CubicInOut = function(p8) --[[ Name: CubicInOut, Line 13 ]]
        if p8 < 0.5 then
            return 4 * p8 ^ 3;
        else
            return 1 - (-2 * p8 + 2) ^ 3 / 2;
        end;
    end,
    QuartIn = function(p9) --[[ Name: QuartIn, Line 14 ]]
        return p9 ^ 4;
    end,
    QuartOut = function(p10) --[[ Name: QuartOut, Line 15 ]]
        return 1 - (1 - p10) ^ 4;
    end,
    QuartInOut = function(p11) --[[ Name: QuartInOut, Line 16 ]]
        if p11 < 0.5 then
            return 8 * p11 ^ 4;
        else
            return 1 - 8 * (1 - p11) ^ 4;
        end;
    end,
    QuintIn = function(p12) --[[ Name: QuintIn, Line 17 ]]
        return p12 ^ 5;
    end,
    QuintOut = function(p13) --[[ Name: QuintOut, Line 18 ]]
        return 1 - (1 - p13) ^ 5;
    end,
    QuintInOut = function(p14) --[[ Name: QuintInOut, Line 19 ]]
        if p14 < 0.5 then
            return 16 * p14 ^ 5;
        else
            return 1 - 16 * (1 - p14) ^ 5;
        end;
    end,
    CircIn = function(p15) --[[ Name: CircIn, Line 20 ]]
        return 1 - math.sqrt(1 - p15 * p15);
    end,
    CircOut = function(p16) --[[ Name: CircOut, Line 21 ]]
        return math.sqrt(1 - (p16 - 1) ^ 2);
    end,
    CircInOut = function(p17) --[[ Name: CircInOut, Line 22 ]]
        if p17 < 0.5 then
            return (1 - math.sqrt(1 - (2 * p17) ^ 2)) / 2;
        else
            return (math.sqrt(1 - (-2 * p17 + 2) ^ 2) + 1) / 2;
        end;
    end
};
function u1.new(p19, p20, p21, p22) --[[ Line: 25 ]]
    -- upvalues: u1 (copy)
    local v23 = setmetatable({}, u1);
    v23.rest = p19 or 0;
    v23.duration = p20 or 1;
    v23.phases = {};
    for _, v24 in ipairs(p21) do
        table.insert(v23.phases, {
            goal = v24.goal,
            goal_alpha = v24.goal_alpha,
            easing_style = v24.easing_style
        });
    end;
    table.sort(v23.phases, function(p25, p26) --[[ Line: 33 ]]
        return p25.goal_alpha < p26.goal_alpha;
    end);
    if #v23.phases == 0 or v23.phases[1].goal_alpha > 0 then
        table.insert(v23.phases, 1, {
            goal_alpha = 0,
            easing_style = "QuadIn",
            goal = v23.rest
        });
    end;
    if v23.phases[#v23.phases].goal_alpha < 1 then
        table.insert(v23.phases, {
            goal_alpha = 1,
            goal = v23.rest,
            easing_style = v23.phases[#v23.phases].easing_style or "QuadOut"
        });
    end;
    v23.Position = v23.rest;
    v23.accumulated_vel = 0;
    v23.Velocity = 0;
    v23.Completed = Instance.new("BindableEvent");
    v23.destroy_once_completed = p22 or false;
    v23._running = false;
    v23._time = 0;
    v23._initial = v23.Position;
    v23._lastPosition = v23.Position;
    v23._conn = nil;
    return v23;
end;
function u1.Run(u27, p28) --[[ Line: 53 ]]
    -- upvalues: l__RunService__1 (copy)
    if u27._running and u27._conn then
        u27._conn:Disconnect();
        u27._conn = nil;
    end;
    if p28 == nil then
        u27._initial = u27.Position;
    else
        u27._initial = p28;
        u27.Position = p28;
        for _, v29 in ipairs(u27.phases) do
            if v29.goal_alpha == 0 then
                v29.goal = p28;
                break;
            end;
        end;
    end;
    u27._time = 0;
    u27._lastPosition = u27.Position;
    u27.accumulated_vel = 0;
    u27.Velocity = 0;
    u27._running = true;
    u27._conn = l__RunService__1.RenderStepped:Connect(function(p30) --[[ Line: 75 ]]
        -- upvalues: u27 (copy)
        u27:Update(p30);
    end);
end;
function u1.Update(u31, p32) --[[ Line: 81 ]]
    -- upvalues: u18 (copy), l__Promise__2 (copy)
    if not u31._running then
        return;
    end;
    u31._time = u31._time + p32;
    local v33 = u31._time / u31.duration;
    if v33 >= 1 then
        u31._running = false;
    else
        local v34 = nil;
        for v35 = 1, #u31.phases - 1 do
            if u31.phases[v35].goal_alpha <= v33 and v33 < u31.phases[v35 + 1].goal_alpha then
                v34 = v35;
                break;
            end;
        end;
        if v34 then
            local v36 = u31.phases[v34];
            local v37 = u31.phases[v34 + 1];
            local v38 = (u18[v36.easing_style] or u18.QuadIn)((v33 - v36.goal_alpha) / (v37.goal_alpha - v36.goal_alpha));
            local v39 = v36.goal + (v37.goal - v36.goal) * v38;
            u31.Velocity = (v39 - u31._lastPosition) / p32;
            u31._lastPosition = v39;
            u31.Position = v39;
        else
            local l__rest__3 = u31.rest;
            u31.Velocity = 0;
            u31._running = false;
            u31.Velocity = (l__rest__3 - u31._lastPosition) / p32;
            u31._lastPosition = l__rest__3;
            u31.Position = l__rest__3;
        end;
    end;
    if not u31._running and u31._conn then
        local v40 = u31.rest - u31.Position;
        u31.Velocity = v40;
        u31.Position = u31.Position + v40;
        l__Promise__2.defer(function() --[[ Line: 121 ]]
            -- upvalues: u31 (copy)
            u31.Velocity = 0;
            u31.Position = u31.rest;
            u31._conn:Disconnect();
            u31._conn = nil;
            u31.Completed:Fire();
            if u31.destroy_once_completed then
                task.defer(function() --[[ Line: 128 ]]
                    -- upvalues: u31 (ref)
                    u31.Completed:Destroy();
                end);
            end;
        end);
    end;
end;
return u1;
