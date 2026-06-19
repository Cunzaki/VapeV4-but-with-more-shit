-- Decompiled from: InfoProvider
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = tick;
local u2 = v1();
local v3 = _G.obtain("Remote");
v3.Add("JoinTick", function() --[[ Line: 5 ]]
    -- upvalues: u2 (copy)
    return u2;
end);
v3.Add("tick", v1);
return true;
