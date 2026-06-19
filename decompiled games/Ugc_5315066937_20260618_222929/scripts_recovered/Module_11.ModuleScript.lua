-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clone__1 = table.clone;
local l__clear__2 = table.clear;
local l__obtain__3 = _G.obtain;
local u1 = l__obtain__3("L1Copy");
local v2 = l__obtain__3("Class")();
function v2.GetState(p3) --[[ Line: 12 ]]
    -- upvalues: l__clone__1 (copy)
    return {
        CFrames = l__clone__1(p3.CFrames),
        TimeOverrides = l__clone__1(p3.TimeOverrides),
        Time = p3.Time
    };
end;
function v2.SetState(p4, p5) --[[ Line: 19 ]]
    -- upvalues: l__clone__1 (copy)
    p4.CFrames = l__clone__1(p5.CFrames);
    p4.TimeOverrides = l__clone__1(p5.TimeOverrides);
    p4.Time = p5.Time;
end;
function v2.CopyState(p6, p7) --[[ Line: 24 ]]
    -- upvalues: l__clear__2 (copy), u1 (copy)
    l__clear__2(p6.CFrames);
    p6.CFrames = u1(p7.CFrames, p6.CFrames);
    l__clear__2(p6.TimeOverrides);
    p6.TimeOverrides = u1(p7.TimeOverrides, p6.TimeOverrides);
    p6.Time = p7.Time;
end;
function v2.CopyStateRemap(p8, p9, p10, p11) --[[ Line: 31 ]]
    -- upvalues: l__clear__2 (copy)
    local l__CFrames__4 = p8.CFrames;
    l__clear__2(l__CFrames__4);
    for v12, v13 in p9.CFrames do
        local v14 = p11[p10[v12]];
        assert(v14 ~= nil, "nil");
        l__CFrames__4[v14] = v13;
    end;
    local l__TimeOverrides__5 = p8.TimeOverrides;
    l__clear__2(l__TimeOverrides__5);
    for v15, v16 in p9.TimeOverrides do
        local v17 = p11[p10[v15]];
        assert(v17 ~= nil, "nil");
        l__TimeOverrides__5[v17] = v16;
    end;
    p8.Time = p9.Time;
end;
function v2.Clear(p18) --[[ Line: 49 ]]
    -- upvalues: l__clear__2 (copy)
    l__clear__2(p18.CFrames);
    l__clear__2(p18.TimeOverrides);
end;
function v2.Constructor(p19) --[[ Line: 54 ]]
    p19.CFrames = {};
    p19.TimeOverrides = {};
    p19.Time = 0;
end;
return v2;
