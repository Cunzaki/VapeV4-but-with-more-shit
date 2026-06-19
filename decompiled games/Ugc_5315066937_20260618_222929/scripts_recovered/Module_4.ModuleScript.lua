-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tick;
local u2 = _G.obtain("Timers")();
u2.Pt = u1();
u2:SetTime(u2.Pt, 0);
print("[RealtimeTimerSystem] RootTimer Time =", u2:Time());
return {
    Run = function() --[[ Name: Run, Line 12 ]]
        -- upvalues: u2 (copy), u1 (copy)
        u2.Pt = u1();
    end,
    RootTimer = u2
};
