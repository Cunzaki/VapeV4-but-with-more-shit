-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = select;
local u2 = unpack;
local u3 = typeof;
local l__obtain__1 = _G.obtain;
local v4 = l__obtain__1("LuCAS-Base");
local l__DefEvaluate__2 = v4.DefEvaluate;
local l__DefDerivative__3 = v4.DefDerivative;
local v5 = l__obtain__1("LuCAS-Rule");
local l__DefRule__4 = v5.DefRule;
local l__RuleCopy__5 = v5.RuleCopy;
local _ = v5.RuleReflect;
local v6 = l__obtain__1("LuCAS-Constructor");
local l__Head__6 = v6.Head;
local l__DefConstructor__7 = v6.DefConstructor;
local l__DefaultConstructor__8 = v6.DefaultConstructor;
local u7 = {
    [2] = Vector2.new,
    [3] = Vector3.new
};
local u8 = l__DefaultConstructor__8("Vector");
l__DefEvaluate__2("Vector", "Vector", function(...) --[[ Line: 29 ]]
    -- upvalues: u7 (copy), u1 (copy), u3 (copy)
    local v9 = u7[u1("#", ...)];
    if v9 then
        return v9(...);
    end;
    local v10 = u3(...);
    if v10 == "Vector3" or v10 == "Vector2" then
        return ...;
    end;
    print("[LuCAS-Vector] Vector Evaluate robloxtype arg1=", v10, "args:", ...);
    error("[LuCAS-Vector] Vector Evaluate No VectorFunc VectorLength=", u1("#", ...));
end, "Independent");
local u11 = nil;
u11 = l__DefConstructor__7("Vector", function(...) --[[ Line: 48 ]]
    -- upvalues: u1 (copy), u3 (copy), u8 (copy), l__Head__6 (copy), u11 (ref), u2 (copy)
    if u1("#", ...) == 1 then
        local v12 = ...;
        local v13 = u3(v12);
        if v13 == "Vector3" or v13 == "CFrame" then
            return u8(v12.x, v12.y, v12.z);
        end;
        if v13 == "Vector2" then
            return u8(v12.x, v12.y);
        end;
        if v13 == "table" then
            local v14 = l__Head__6(v12);
            if v14 == "CFrame" then
                return v12[2];
            end;
            if v14 == "Vector" then
                return v12;
            end;
            if not v14 then
                local v15 = v12[1];
                if v15 == "CFrame" then
                    return u11(v12[2]);
                end;
                if v15 == "Vector" then
                    return u8(u2(v12, 2));
                end;
            end;
        end;
    end;
    return u8(...);
end);
l__DefEvaluate__2("VAdd", "Vector", function(p16, p17) --[[ Line: 90 ]]
    return p16 + p17;
end, "Independent");
l__DefEvaluate__2("VSub", "Vector", function(p18, p19) --[[ Line: 104 ]]
    return p18 - p19;
end, "Independent");
l__DefEvaluate__2("Dot", "Scalar", function(p20, p21) --[[ Line: 111 ]]
    local v22 = 0;
    for v23 = 1, #p20 do
        v22 = v22 + p20[v23] * p21[v23];
    end;
    return v22;
end);
l__DefDerivative__3("Dot", "Custom", function(p24, p25) --[[ Line: 120 ]]
    return {
        "Add",
        { "Dot", p24[1], p25[2] },
        { "Dot", p25[1], p24[2] }
    };
end);
l__DefEvaluate__2("Cross", "Vector", function(p26, p27) --[[ Line: 127 ]]
    local v28 = p26[1];
    local v29 = p26[2];
    local v30 = p26[3];
    local v31 = p27[1];
    local v32 = p27[2];
    local v33 = p27[3];
    return v29 * v33 - v30 * v32, v30 * v31 - v28 * v33, v28 * v32 - v29 * v31;
end);
l__DefDerivative__3("Cross", "Custom", function(p34, p35) --[[ Line: 134 ]]
    return {
        "VAdd",
        { "Cross", p34[1], p35[2] },
        { "Cross", p35[1], p34[2] }
    };
end);
l__DefRule__4("Add", "Vector", "Vector-Vector", "VAdd");
l__DefRule__4("Sub", "Vector", "Vector-Vector", "VSub");
l__DefEvaluate__2("VMulScalar", "Vector", function(p36, p37) --[[ Line: 152 ]]
    return p36 * p37;
end);
l__DefDerivative__3("VMulScalar", "Custom", function(p38, p39) --[[ Line: 164 ]]
    return {
        "VAdd",
        { "VMulScalar", p38[1], p39[2] },
        { "VMulScalar", p39[1], p38[2] }
    };
end);
l__DefRule__4("Mul", "Vector", "Vector-Scalar", "VMulScalar");
l__DefRule__4("Mul", "Vector", "Scalar-Vector", function(p40, p41) --[[ Line: 180 ]]
    return p41 * p40;
end);
l__RuleCopy__5("Mul", "Vector-Scalar", "Vector-number");
l__RuleCopy__5("Mul", "Scalar-Vector", "number-Vector");
l__DefRule__4("Mul", "Vector", "Scalar-Vector3", function(p42, p43) --[[ Line: 188 ]]
    -- upvalues: u11 (ref)
    return u11(p43) * p42;
end);
return true;
