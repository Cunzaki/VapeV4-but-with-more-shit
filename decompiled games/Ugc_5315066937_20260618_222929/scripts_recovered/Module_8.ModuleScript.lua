-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local _ = table.move;
local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Class");
local u2 = l__obtain__1("Timelines");
local u3 = v1();
function u3.StartRecording(p4, p5) --[[ Line: 22 ]]
    -- upvalues: u3 (copy)
    local v6 = u3();
    local v7 = {};
    for v8, v9 in p4 do
        local u10 = v6:CreateTimeline(v8);
        u10.AutoTrim = false;
        u10.IsRealtime = v9.IsRealtime;
        local function v12(_, p11) --[[ Line: 29 ]]
            -- upvalues: u10 (copy)
            u10:Post(p11);
        end;
        v9.EventAdded:Add(v12);
        v7[v9] = v12;
        if p5 then
            u10:PostList(v9.Events);
        end;
    end;
    v6.Recording = v7;
    return v6;
end;
function u3.StopRecording(p13) --[[ Line: 47 ]]
    local l__Recording__2 = p13.Recording;
    if l__Recording__2 then
        for v14, v15 in l__Recording__2 do
            v14.EventAdded:Remove(v15);
        end;
        p13.Recording = nil;
    else
        print("[TimelineGroup] StopRecording error: TimelineGroup is not recording");
    end;
end;
function u3.CreateTimeline(p16, p17, p18) --[[ Line: 59 ]]
    -- upvalues: u2 (copy)
    local v19 = u2(p18);
    p16[p17] = v19;
    return v19;
end;
function u3.CopyHandlers(p20, p21, p22) --[[ Line: 65 ]]
    assert(p21 ~= nil, "[TimelineGroup] CopyHandlers Handlers==nil");
    for v23 in p21 do
        p20:CreateTimeline(v23, p22);
    end;
end;
function u3.SetAutoTrim(p24, p25) --[[ Line: 72 ]]
    for _, v26 in p24 do
        v26.AutoTrim = p25;
    end;
end;
function u3.PostTo(p27, p28, ...) --[[ Line: 78 ]]
    p27[p28]:Post({ ... });
end;
return u3;
