-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tonumber;
local l__match__1 = string.match;
local l__obtain__2 = _G.obtain;
local l__FetchState__3 = l__obtain__2("WorldHelpers").FetchState;
local v2 = l__obtain__2("ObjectRecognition")();
local l__IsA__4 = game.IsA;
v2:DefClassification("ModuleScript", function(p3) --[[ Line: 13 ]]
    -- upvalues: l__IsA__4 (copy)
    return l__IsA__4(p3, "ModuleScript");
end);
v2:DefCategory("World", function(p4) --[[ Line: 18 ]]
    return p4;
end);
v2:DefObject("Analytic", "World", "ModuleScript", function(p5) --[[ Line: 26 ]]
    -- upvalues: l__FetchState__3 (copy)
    if p5.Name == "Analytic" then
        return { l__FetchState__3(p5.Parent) };
    end;
end);
v2:DefObject("Interactive", "World", "ModuleScript", function(p6) --[[ Line: 36 ]]
    -- upvalues: l__match__1 (copy), u1 (copy), l__FetchState__3 (copy)
    local v7 = u1(l__match__1(p6.Name, "^Interactive(%d+)$"));
    if v7 then
        return { v7, l__FetchState__3(p6.Parent) };
    end;
end);
return v2;
