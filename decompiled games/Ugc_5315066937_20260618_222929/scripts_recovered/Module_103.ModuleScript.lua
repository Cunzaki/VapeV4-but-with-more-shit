-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Remote");
local v2 = l__obtain__1("Timers");
local l__RootTimer__2 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local u3 = v2(l__RootTimer__2);
v1.Add("SetOffset", function(p4) --[[ Line: 12 ]]
    -- upvalues: u3 (copy), l__RootTimer__2 (copy)
    u3:SetTime(l__RootTimer__2:Time(), p4);
end);
v1.Call("GetOffset");
return function() --[[ Line: 17 ]]
    -- upvalues: u3 (copy)
    return u3:Time(), u3.Offset ~= 0;
end;
