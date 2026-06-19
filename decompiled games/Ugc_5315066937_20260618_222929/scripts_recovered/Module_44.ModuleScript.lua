-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tonumber;
local l__match__1 = string.match;
local l__obtain__2 = _G.obtain;
local v2 = l__obtain__2("ObjectRecognition")();
local v3 = l__obtain__2("ZonesObjectRecognition");
v2:DefCategory("Zone", v3.ZoneDefCategoryZone);
v2:DefObject("Start", "Zone", "BasePart", v3.ZoneDefObjectStart);
v2:DefObject("Finish", "Zone", "BasePart", v3.ZoneDefObjectFinish);
v2:DefObject("Anticheat", "Zone", "BasePart", v3.ZoneDefObjectAnticheat);
v2:DefObject("Trigger", "Runtime", "BasePart", function(p4) --[[ Line: 34 ]]
    -- upvalues: l__match__1 (copy), u1 (copy)
    return u1(l__match__1(p4.Name, "^Trigger(%d+)$"));
end);
v2:DefObject("ForceTrigger", "Runtime", "BasePart", function(p5) --[[ Line: 41 ]]
    -- upvalues: l__match__1 (copy), u1 (copy)
    return u1(l__match__1(p5.Name, "^ForceTrigger(%d+)$"));
end);
v2:DefObject("Teleport", "Runtime", "BasePart", function(p6) --[[ Line: 48 ]]
    -- upvalues: l__match__1 (copy), u1 (copy)
    return u1(l__match__1(p6.Name, "^Teleport(%d+)$"));
end);
v2:DefObject("ForceTeleport", "Runtime", "BasePart", function(p7) --[[ Line: 55 ]]
    -- upvalues: l__match__1 (copy), u1 (copy)
    return u1(l__match__1(p7.Name, "^ForceTeleport(%d+)$"));
end);
v2:DefObject("WormholeIn", "Runtime", "BasePart", function(p8) --[[ Line: 63 ]]
    -- upvalues: l__match__1 (copy), u1 (copy)
    return u1(l__match__1(p8.Name, "^WormholeIn(%d+)$"));
end);
return v2;
