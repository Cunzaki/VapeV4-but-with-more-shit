-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("LuCAS-Base");
local l__DefEvaluate__2 = v1.DefEvaluate;
local l__DefDerivative__3 = v1.DefDerivative;
local v2 = l__obtain__1("LuCAS-Constructor");
local l__DefConstructor__4 = v2.DefConstructor;
local l__DefaultConstructor__5 = v2.DefaultConstructor;
local u6 = l__DefConstructor__4("Lerp", function(p3, p4, p5) --[[ Line: 12 ]]
    return (1 - p5) * p3 + p5 * p4;
end);
l__DefEvaluate__2("Piece", function(_, p7) --[[ Line: 19 ]]
    return p7;
end, function(p8, p9) --[[ Line: 23 ]]
    return { p8, p9 };
end);
l__DefDerivative__3("Piece", "Custom", function(p10, p11) --[[ Line: 28 ]]
    return { "Piece", p10[1], p11[2] };
end);
l__DefEvaluate__2("Piecewise", function(...) --[[ Line: 34 ]]
    return ...;
end, function(...) --[[ Line: 38 ]]
    local v12 = { ... };
    for v13 = 1, #v12 do
        local v14 = v12[v13];
        if v14[1] == true then
            return v14[2];
        end;
    end;
end, "Independent");
local u15 = l__DefaultConstructor__5("LessThan");
local u16 = l__DefaultConstructor__5("Piece");
local u17 = l__DefaultConstructor__5("Piecewise");
l__DefConstructor__4("forwardsandback", function(p18, p19, p20) --[[ Line: 55 ]]
    -- upvalues: u17 (copy), u16 (copy), u15 (copy), u6 (copy)
    return u17(u16(u15(p20 % 2, 1), u6(p18, p19, p20 % 2)), u16(true, u6(p19, p18, p20 % 2 - 1)));
end);
return true;
