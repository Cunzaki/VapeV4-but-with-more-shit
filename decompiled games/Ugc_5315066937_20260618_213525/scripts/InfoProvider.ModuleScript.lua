-- Decompiled from: InfoProvider
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

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
