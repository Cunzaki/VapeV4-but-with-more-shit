-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Remote");
local v2 = l__obtain__1("MonitoredData");
local u3 = v2();
local u4 = v2();
v1.Add("GlobalDataSetKey", function(p5, p6) --[[ Line: 6 ]]
    -- upvalues: u3 (copy)
    u3:SetKey(p5, p6);
end);
v1.Add("ProfileDataSetKey", function(p7, p8) --[[ Line: 9 ]]
    -- upvalues: u4 (copy)
    u4:SetKey(p7, p8);
end);
return {
    Global = u3,
    Profile = u4
};
