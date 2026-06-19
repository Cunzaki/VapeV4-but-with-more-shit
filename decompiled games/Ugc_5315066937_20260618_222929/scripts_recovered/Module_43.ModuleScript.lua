-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = assert;
local l__obtain__1 = _G.obtain;
local v2 = l__obtain__1("Class");
local u3 = l__obtain__1("EventQueue");
local v4 = v2();
function v4.Jump(p5, p6) --[[ Line: 11 ]]
    for _, v7 in p5 do
        v7:JumpToTime(p6);
    end;
end;
function v4.Find(p8, p9) --[[ Line: 17 ]]
    for _, v10 in p8 do
        v10:FindTime(p9);
    end;
end;
function v4.Remove(p11) --[[ Line: 23 ]]
    for _, v12 in p11 do
        v12:Remove();
    end;
end;
function v4.Constructor(p13, p14, p15) --[[ Line: 29 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1(p14 ~= nil, "TimelineGroup==nil");
    for v16, v17 in p14 do
        local v18 = u3(v17, p15, v16);
        v18.EventQueueGroup = p13;
        p13[v16] = v18;
    end;
end;
return v4;
