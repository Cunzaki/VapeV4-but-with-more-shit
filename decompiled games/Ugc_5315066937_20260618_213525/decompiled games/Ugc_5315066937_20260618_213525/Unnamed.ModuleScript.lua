-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__DefEvaluate__2 = l__obtain__1("LuCAS-Base").DefEvaluate;
local v1 = l__obtain__1("LuCAS-Rule");
local l__DefRule__3 = v1.DefRule;
local l__RuleCopy__4 = v1.RuleCopy;
local v2 = l__obtain__1("LuCAS-Constructor");
local l__DefConstructor__5 = v2.DefConstructor;
local u3 = v2.DefaultConstructor("Scalar");
local u4 = type;
local u5 = assert;
l__DefConstructor__5("Scalar", function(p6) --[[ Line: 17 ]]
    -- upvalues: u4 (copy), u5 (copy), u3 (copy)
    u5(u4(p6) == "string");
    return u3(p6);
end, function(p7) --[[ Line: 21 ]]
    return p7[2];
end);
l__DefEvaluate__2("Scalar", "Scalar", function(p8) --[[ Line: 26 ]]
    return p8;
end, 1);
l__DefEvaluate__2("Add", "Scalar", function(...) --[[ Line: 32 ]]
    local v9 = { ... };
    local v10 = v9[1];
    for v11 = 2, #v9 do
        v10 = v10 + v9[v11];
    end;
    return v10;
end, "Independent");
l__DefRule__3("Add", "Scalar", "Scalar-Scalar");
l__DefRule__3("Add", "Scalar", "Scalar-number");
l__DefRule__3("Add", "Scalar", "number-Scalar");
l__DefRule__3("Sub", "Scalar", "Scalar-Scalar", function(p12, p13) --[[ Line: 55 ]]
    return p12 + -1 * p13;
end);
l__RuleCopy__4("Sub", "Scalar-Scalar", "Scalar-number");
l__RuleCopy__4("Sub", "Scalar-Scalar", "number-Scalar");
l__DefEvaluate__2("Mul", "Scalar", function(...) --[[ Line: 62 ]]
    local v14 = { ... };
    local v15 = v14[1];
    for v16 = 2, #v14 do
        v15 = v15 * v14[v16];
    end;
    return v15;
end, function(...) --[[ Line: 70 ]]
    local v17 = { ... };
    local v18 = #v17;
    local v19 = {};
    for v20 = 1, v18 do
        local v21 = { "Mul" };
        for v22 = 2, v18 do
            v21[v22] = v17[(v20 + v22 - 2) % v18 + 1];
        end;
        v19[v20] = v21;
    end;
    return unpack(v19);
end);
l__DefRule__3("Mul", "Scalar", "Scalar-Scalar");
l__DefRule__3("Mul", "Scalar", "Scalar-number");
l__DefRule__3("Mul", "Scalar", "number-Scalar");
l__DefRule__3("Div", "Scalar", "Scalar-Scalar", function(p23, p24) --[[ Line: 88 ]]
    return p23 * p24 ^ (-1);
end);
l__RuleCopy__4("Div", "Scalar-Scalar", "Scalar-number");
l__RuleCopy__4("Div", "Scalar-Scalar", "number-Scalar");
l__DefEvaluate__2("Pow", "Scalar", math.pow, function(p25, p26) --[[ Line: 96 ]]
    return {
        "Mul",
        {
            "Pow",
            p25,
            { "Add", p26, -1 }
        },
        p26
    }, {
        "Mul",
        { "Log", p25 },
        { "Pow", p25, p26 }
    };
end);
l__DefRule__3("Pow", "Scalar", "Scalar-Scalar");
l__DefRule__3("Pow", "Scalar", "Scalar-number");
l__DefRule__3("Pow", "Scalar", "number-Scalar");
l__DefEvaluate__2("Mod", "Scalar", function(p27, p28) --[[ Line: 104 ]]
    return p27 % p28;
end, function(p29, p30) --[[ Line: 107 ]]
    return 1, {
        "Floor",
        {
            "Mul",
            p29,
            { "Pow", p30, -1 }
        }
    };
end);
l__DefRule__3("Mod", "Scalar", "Scalar-Scalar");
l__DefRule__3("Mod", "Scalar", "Scalar-number");
l__DefRule__3("Mod", "Scalar", "number-Scalar");
l__DefRule__3("Unm", "Scalar", "Scalar", function(p31) --[[ Line: 115 ]]
    return -1 * p31;
end);
l__DefEvaluate__2("Step", "Scalar", function(p32) --[[ Line: 120 ]]
    return p32 > 0 and 1 or 0;
end, 0);
l__DefEvaluate__2("Sign", "Scalar", function(p33) --[[ Line: 126 ]]
    return (p33 > 0 and 1 or 0) - (p33 < 0 and 1 or 0);
end, 0);
l__DefEvaluate__2("Abs", "Scalar", math.abs, function(p34) --[[ Line: 133 ]]
    return { "Sign", p34 };
end);
l__DefEvaluate__2("Floor", "Scalar", math.floor, 0);
l__DefEvaluate__2("Ceil", "Scalar", math.ceil, 0);
l__DefEvaluate__2("Log", "Scalar", math.log, function(p35) --[[ Line: 147 ]]
    return { "Pow", p35, -1 };
end);
l__DefEvaluate__2("Cos", "Scalar", math.cos, function(p36) --[[ Line: 153 ]]
    return {
        "Mul",
        -1,
        { "Sin", p36 }
    };
end);
l__DefEvaluate__2("Sin", "Scalar", math.sin, function(p37) --[[ Line: 159 ]]
    return { "Cos", p37 };
end);
local l__atan2__6 = math.atan2;
l__DefEvaluate__2("ArcTan", "Scalar", function(p38, p39) --[[ Line: 166 ]]
    -- upvalues: l__atan2__6 (copy)
    return l__atan2__6(p39, p38);
end, function(p40, p41) --[[ Line: 169 ]]
    local v42 = {
        "Pow",
        {
            "Add",
            { "Pow", p40, 2 },
            { "Pow", p41, 2 }
        },
        -1
    };
    return {
        "Mul",
        -1,
        p41,
        v42
    }, { "Mul", p40, v42 };
end);
return true;
