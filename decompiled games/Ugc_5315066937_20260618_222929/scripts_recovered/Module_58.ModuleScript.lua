-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = unpack;
local l__min__1 = math.min;
local l__move__2 = table.move;
local l__clear__3 = table.clear;
local l__obtain__4 = _G.obtain;
local v2 = l__obtain__4("Class");
local u3 = l__obtain__4("Trackers");
local v4 = v2();
function v4.AdvanceToIndex(p5, p6) --[[ Line: 22 ]]
    local l__Index__5 = p5.Queued.Index;
    local v7 = #p5.Timeline.Events + 1;
    if v7 < p6 then
        p6 = v7;
    end;
    if l__Index__5 < p6 then
        p5.Queued:SetIndex(p6);
    end;
end;
function v4.PickIndex(p8, p9) --[[ Line: 34 ]]
    local v10 = #p8.Timeline.Events;
    if v10 < p9 then
        p8.Queued:SetIndex(v10 + 1);
        p8.Processed:SetIndex(v10 + 1);
    else
        p8.Queued:SetIndex(p9 + 1);
        p8.Processed:SetIndex(p9);
    end;
end;
function v4.JumpToIndex(p11, p12) --[[ Line: 48 ]]
    local _ = p11.Queued.Index;
    local v13 = #p11.Timeline.Events + 1;
    if v13 < p12 then
        p12 = v13;
    end;
    p11.Queued:SetIndex(p12);
    p11.Processed:SetIndex(p12);
end;
function v4.AdvanceToIndexWithIndexLimit(p14, p15, p16) --[[ Line: 58 ]]
    -- upvalues: l__min__1 (copy)
    p14:AdvanceToIndex((l__min__1(p15, p14.Queued.Index + p16)));
end;
function v4.AdvanceIncrement(p17, p18) --[[ Line: 61 ]]
    p17:AdvanceToIndex(p17.Queued.Index + p18);
end;
function v4.AdvanceToTime(p19, p20) --[[ Line: 64 ]]
    p19:AdvanceToIndex(p19.Timeline:GetIndexAfter(p20 or p19.Timeline.Timer:Time(), p19.Queued.Index));
end;
function v4.JumpToTime(p21, p22) --[[ Line: 67 ]]
    p21:JumpToIndex(p21.Timeline:GetIndexAfter(p22 or p21.Timeline.Timer:Time(), p21.Queued.Index));
end;
function v4.FindTime(p23, p24) --[[ Line: 70 ]]
    p23:PickIndex(p23.Timeline:GetIndexAfter(p24 or p23.Timeline.Timer:Time(), p23.Queued.Index));
end;
function v4.AdvanceToTimeWithIndexLimit(p25, p26, p27) --[[ Line: 73 ]]
    p25:AdvanceToIndexWithIndexLimit(p25.Timeline:GetIndexAfter(p26 or p25.Timeline.Timer:Time(), p25.Queued.Index), p27);
end;
function v4.AdvanceToLast(p28) --[[ Line: 77 ]]
    p28:AdvanceToIndex(#p28.Timeline.Events + 1);
end;
function v4.AdvanceToLastWithIndexLimit(p29, p30) --[[ Line: 80 ]]
    p29:AdvanceToIndexWithIndexLimit(#p29.Timeline.Events + 1, p30);
end;
function v4.Build(p31) --[[ Line: 85 ]]
    -- upvalues: l__clear__3 (copy), l__move__2 (copy)
    l__clear__3(p31.Queue);
    l__move__2(p31.Timeline.Events, p31.Processed.Index, p31.Queued.Index - 1, 1, p31.Queue);
end;
function v4.Flush(p32) --[[ Line: 90 ]]
    -- upvalues: u1 (copy)
    local l__Multicall__6 = p32.Indexer.Multicall;
    if l__Multicall__6.IsHooked then
        local l__Call__7 = l__Multicall__6.Call;
        local l__Label__8 = p32.Label;
        local l__Events__9 = p32.Timeline.Events;
        for v33 = p32.Processed.Index, p32.Queued.Index - 1 do
            l__Call__7(l__Multicall__6, l__Label__8, u1(l__Events__9[v33]));
        end;
    end;
    p32.Processed:SetIndex(p32.Queued.Index);
end;
function v4.Remove(p34) --[[ Line: 103 ]]
    local l__Indexer__10 = p34.Indexer;
    p34.Indexer = nil;
    l__Indexer__10:SetActive(p34, false);
    l__Indexer__10:SetQueued(p34, false);
    p34.Processed:Remove();
    p34.Processed = nil;
    p34.Queued:Remove();
    p34.Queued = nil;
    p34.Timeline = nil;
end;
local function u36(p35) --[[ Line: 115 ]]
    local l__Indexer__11 = p35.Indexer;
    l__Indexer__11:SetActive(p35, p35.Queued.Index <= #p35.Timeline.Events);
    l__Indexer__11:SetQueued(p35, p35.Processed.Index ~= p35.Queued.Index);
end;
local function u38(p37) --[[ Line: 120 ]]
    p37.Indexer:SetQueued(p37, p37.Processed.Index ~= p37.Queued.Index);
end;
function v4.Constructor(p39, p40, p41, p42) --[[ Line: 125 ]]
    -- upvalues: u3 (copy), u36 (copy), u38 (copy)
    p39.Timeline = p40;
    local v43 = u3(p40);
    v43.EventQueueType = 1;
    v43.EventQueueHook = u36;
    v43.EventQueue = p39;
    p39.Queued = v43;
    local v44 = u3(p40);
    v44.EventQueueHook = u38;
    v44.EventQueue = p39;
    p39.Processed = v44;
    p39.Queue = {};
    p39.Indexer = p41;
    p39.Label = p42;
    local l__Indexer__12 = p39.Indexer;
    l__Indexer__12:SetActive(p39, p39.Queued.Index <= #p39.Timeline.Events);
    l__Indexer__12:SetQueued(p39, p39.Processed.Index ~= p39.Queued.Index);
end;
return v4;
