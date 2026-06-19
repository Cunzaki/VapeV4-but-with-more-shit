-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local u2 = l__obtain__1("Timers");
local l__RootTimer__2 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local u3 = {};
local u4 = assert;
local u5 = tostring;
local function v7(p6) --[[ Line: 14 ]]
    -- upvalues: u3 (copy)
    return u3[p6];
end;
local function v10(p8) --[[ Line: 18 ]]
    -- upvalues: u3 (copy), u5 (copy), u4 (copy), u1 (copy), u2 (copy), l__RootTimer__2 (copy)
    u4(u3[p8] == nil, "Attempted to duplicate timer for Player=" .. u5(p8));
    u1("Creating timer for Player=", p8);
    local v9 = u2(l__RootTimer__2);
    v9:SetTime(l__RootTimer__2:Time(), 0);
    u3[p8] = v9;
end;
local function v12(p11) --[[ Line: 25 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1("Remove timer for Player=", p11);
    u3[p11] = nil;
end;
if game:GetService("Players").LocalPlayer then
    u4(u3.Server == nil, "Attempted to duplicate timer for Player=" .. u5("Server"));
    u1("Creating timer for Player=", "Server");
    local v13 = u2(l__RootTimer__2);
    v13:SetTime(l__RootTimer__2:Time(), 0);
    u3.Server = v13;
end;
return {
    Get = v7,
    Add = v10,
    Remove = v12
};
