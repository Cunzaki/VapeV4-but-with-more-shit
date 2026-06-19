-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = assert;
local v2 = _G.obtain("Class")();
function v2.After(p3) --[[ Line: 9 ]]
    return p3.Timeline.Events[p3.Index];
end;
function v2.Before(p4) --[[ Line: 13 ]]
    return p4.Timeline.Events[p4.Index - 1];
end;
function v2.SetIndex(p5, p6) --[[ Line: 18 ]]
    p5.Index = p6;
    if p5.EventQueueHook then
        p5.EventQueueHook(p5.EventQueue);
    end;
    p5.Timeline:UpdateTracker(p5);
end;
function v2.JumpToTime(p7, p8) --[[ Line: 26 ]]
    p7:SetIndex(p7.Timeline:GetIndexAfter(p8 or p7.Timeline.Timer:Time(), p7.Index));
end;
function v2.Remove(p9) --[[ Line: 30 ]]
    p9.Timeline:RemoveTracker(p9);
    p9.Timeline = nil;
end;
function v2.Constructor(p10, p11) --[[ Line: 35 ]]
    -- upvalues: u1 (copy)
    u1(p11 ~= nil, "Timeline==nil");
    p10.traceback = debug.traceback();
    p10.Index = 1;
    p10.Timeline = p11;
    p11:AddTracker(p10);
end;
return v2;
