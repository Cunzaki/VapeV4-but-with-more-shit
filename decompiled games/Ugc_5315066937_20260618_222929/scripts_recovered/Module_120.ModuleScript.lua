-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Remote");
local u2 = l__obtain__1("Signal")();
v1.Add("NewHighscore", function(p3) --[[ Line: 9 ]]
    -- upvalues: u2 (copy)
    u2:Call(p3);
end);
return {
    NewTimeHook = u2
};
