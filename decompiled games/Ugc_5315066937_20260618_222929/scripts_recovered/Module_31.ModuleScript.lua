-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__DefEvaluate__2 = l__obtain__1("LuCAS-Base").DefEvaluate;
local v1 = l__obtain__1("LuCAS-Constructor");
v1.DefConstructor("Boolean", v1.DefaultConstructor("Boolean"), function(p2) --[[ Line: 11 ]]
    return p2[2];
end);
l__DefEvaluate__2("Or", "Boolean", function(p3, p4) --[[ Line: 23 ]]
    return p3 or p4;
end);
l__DefEvaluate__2("And", "Boolean", function(p5, p6) --[[ Line: 28 ]]
    return p5 and p6;
end);
l__DefEvaluate__2("LessThan", "Boolean", function(p7, p8) --[[ Line: 34 ]]
    return p7 < p8;
end, 0);
return true;
