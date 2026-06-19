-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Class");
local u2 = l__obtain__1("Signal");
local v3 = v1();
function v3.SetKey(p4, p5, p6) --[[ Line: 9 ]]
    p4.Data[p5] = p6;
    local v7 = p4.KeyMonitors[p5];
    if v7 then
        v7:Call(p6);
    end;
    p4.Monitor:Call(p5, p6);
end;
function v3.GetKey(p8, p9) --[[ Line: 19 ]]
    return p8.Data[p9];
end;
function v3.SoftSetKey(p10, p11, p12) --[[ Line: 24 ]]
    if p10:GetKey(p11) == nil then
        p10:SetKey(p11, p12);
    end;
end;
function v3.MonitorKey(p13, p14, u15) --[[ Line: 30 ]]
    -- upvalues: u2 (copy)
    local u16 = p13.KeyMonitors[p14];
    if not u16 then
        u16 = u2();
        p13.KeyMonitors[p14] = u16;
    end;
    u16:Add(u15);
    return function() --[[ Line: 37 ]]
        -- upvalues: u16 (ref), u15 (copy)
        u16:Remove(u15);
    end;
end;
function v3.Constructor(p17) --[[ Line: 42 ]]
    -- upvalues: u2 (copy)
    p17.Data = {};
    p17.KeyMonitors = {};
    p17.Monitor = u2();
end;
return v3;
