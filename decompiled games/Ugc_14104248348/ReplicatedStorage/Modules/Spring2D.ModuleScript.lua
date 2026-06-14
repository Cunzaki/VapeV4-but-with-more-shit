-- Decompiled from: ReplicatedStorage.Modules.Spring2D
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__exp__1 = math.exp;
local l__sin__2 = math.sin;
local l__cos__3 = math.cos;
local l__sqrt__4 = math.sqrt;
function u1.new(p2, p3, p4) --[[ Line: 11 ]]
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    assert(p2 * p3 >= 0, "stop that");
    v5.d = p2;
    v5.f = p3;
    v5.g = p4;
    v5.p = p4;
    v5.v = p4 * 0;
    return v5;
end;
function u1.setGoal(p6, p7) --[[ Line: 25 ]]
    p6.g = p7;
end;
function u1.getState(p8) --[[ Line: 29 ]]
    return p8.p, p8.v;
end;
function u1.push(p9, p10) --[[ Line: 33 ]]
    p9.v = p9.v + p10;
end;
function u1.step(p11, p12) --[[ Line: 38 ]]
    -- upvalues: l__exp__1 (copy), l__sqrt__4 (copy), l__cos__3 (copy), l__sin__2 (copy)
    local l__d__5 = p11.d;
    local v13 = p11.f * 2 * 3.141592653589793;
    local l__g__6 = p11.g;
    local l__p__7 = p11.p;
    local l__v__8 = p11.v;
    local v14 = l__p__7 - l__g__6;
    local v15 = l__exp__1(-p12 * l__d__5 * v13);
    if l__d__5 == 1 then
        p11.p = (l__v__8 * p12 + v14 * (v13 * p12 + 1)) * v15 + l__g__6;
        p11.v = (l__v__8 - v13 * p12 * (v14 * v13 + l__v__8)) * v15;
    elseif l__d__5 < 1 then
        local v16 = l__sqrt__4(1 - l__d__5 * l__d__5);
        local v17 = l__cos__3(v13 * v16 * p12);
        local v18 = l__sin__2(v13 * v16 * p12);
        p11.p = (v17 * v14 + v18 * (l__v__8 + l__d__5 * v13 * v14) / (v13 * v16)) * v15 + l__g__6;
        p11.v = (v17 * v16 * l__v__8 - v18 * (l__v__8 * l__d__5 + v13 * v14)) * v15 / v16;
    else
        if l__d__5 > 1 then
            local v19 = l__sqrt__4(l__d__5 * l__d__5 - 1);
            local v20 = -v13 * (l__d__5 - v19);
            local v21 = -v13 * (l__d__5 + v19);
            local v22 = (l__v__8 - v20 * v14) / (2 * v13 * v19);
            local v23 = (v14 - v22) * l__exp__1(v20 * p12);
            local v24 = v22 * l__exp__1(v21 * p12);
            p11.p = v23 + v24 + l__g__6;
            p11.v = v20 * v23 + v21 * v24;
        end;
    end;
end;
return u1;
