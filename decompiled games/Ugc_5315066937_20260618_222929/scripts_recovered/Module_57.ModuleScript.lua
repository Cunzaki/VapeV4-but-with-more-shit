-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__move__1 = table.move;
local l__insert__2 = table.insert;
local l__remove__3 = table.remove;
local l__obtain__4 = _G.obtain;
local v2 = l__obtain__4("Class");
local u3 = l__obtain__4("Signal");
local u4 = l__obtain__4("GetIndexAfter");
local v5 = v2();
function v5.SetFirstIndex(p6, p7) --[[ Line: 20 ]]
    -- upvalues: l__move__1 (copy)
    if p7 > 1 then
        local l__Events__5 = p6.Events;
        l__move__1(l__Events__5, p7, #l__Events__5 + p7, 1);
        for v8 in p6.Trackers do
            local l__Index__6 = v8.Index;
            v8.Index = l__Index__6 < p7 and 1 or l__Index__6 + 1 - p7;
        end;
        return true;
    end;
end;
function v5.SetAfterLastIndex(p9, p10) --[[ Line: 38 ]]
    -- upvalues: l__move__1 (copy)
    local l__Events__7 = p9.Events;
    local v11 = #l__Events__7 + 1;
    if p10 < v11 then
        l__move__1(l__Events__7, v11, v11 * 2 - p10 - 1, p10);
        for v12 in p9.Trackers do
            if p10 < v12.Index then
                v12.Index = p10;
            end;
        end;
    end;
end;
function v5.Delete(p13, p14) --[[ Line: 57 ]]
    -- upvalues: l__remove__3 (copy)
    l__remove__3(p13.Events, p14);
    for v15 in p13.Trackers do
        local l__Index__8 = v15.Index;
        if p14 < l__Index__8 then
            v15:SetIndex(l__Index__8 - 1);
        end;
    end;
end;
function v5.GetIndexAfter(p16, p17, p18) --[[ Line: 67 ]]
    -- upvalues: u4 (copy)
    return u4(p16.Events, p17, p18);
end;
function v5.First(p19) --[[ Line: 71 ]]
    return p19.Events[1], 1;
end;
function v5.Last(p20) --[[ Line: 75 ]]
    local v21 = #p20.Events;
    return p20.Events[v21], v21;
end;
function v5.Clear(p22) --[[ Line: 80 ]]
    p22:SetAfterLastIndex(1);
end;
function v5.Post(p23, p24) --[[ Line: 85 ]]
    -- upvalues: u4 (copy), l__insert__2 (copy), u1 (copy)
    local l__Events__9 = p23.Events;
    local v25 = u4(l__Events__9, p24[1], #l__Events__9);
    l__insert__2(l__Events__9, v25, p24);
    for v26 in p23.Trackers do
        local l__Index__10 = v26.Index;
        if v25 < l__Index__10 then
            local l__EventQueue__11 = v26.EventQueue;
            if l__EventQueue__11 and l__EventQueue__11.AllowRewriteHistory then
                v26.Index = v25;
                v26.Timeline:AddTracker(v26);
                l__EventQueue__11.Indexer:SetQueued(l__EventQueue__11, v25 ~= l__EventQueue__11.Queued.Index);
            else
                v26.Index = l__Index__10 + 1;
            end;
        elseif v26.EventQueueType == 1 then
            local l__EventQueue__12 = v26.EventQueue;
            l__EventQueue__12.Indexer:SetActive(l__EventQueue__12, l__Index__10 <= #l__EventQueue__12.Timeline.Events);
        end;
    end;
    p23.EventAdded:Call(p23, p24, v25);
    if p23.AutoTrim and not u1(p23.Trackers) then
        local v27 = #l__Events__9 + 1;
        if p23.KeepN then
            v27 = v27 - p23.KeepN;
        end;
        p23:SetFirstIndex(v27);
    end;
end;
function v5.PostList(p28, p29) --[[ Line: 118 ]]
    for v30 = 1, #p29 do
        p28:Post(p29[v30]);
    end;
    p28.EventListAdded:Call(p28);
end;
function v5.UpdateTracker(p31, p32) --[[ Line: 126 ]]
    if p31.LowestIndexTracker == p32 then
        local v33 = (1 / 0);
        local v34 = nil;
        for v35 in p31.Trackers do
            local l__Index__13 = v35.Index;
            if l__Index__13 < v33 then
                v34 = v35;
                v33 = l__Index__13;
            end;
        end;
        p31.LowestIndexTracker = v34;
        if v34 and p31.AutoTrim then
            if p31.KeepN then
                v33 = v33 - p31.KeepN;
            end;
            p31:SetFirstIndex(v33);
        end;
    end;
end;
function v5.AddTracker(p36, p37) --[[ Line: 146 ]]
    p36.Trackers[p37] = true;
    local l__LowestIndexTracker__14 = p36.LowestIndexTracker;
    if l__LowestIndexTracker__14 then
        if p37.Index < l__LowestIndexTracker__14.Index then
            p36.LowestIndexTracker = p37;
        end;
    else
        p36.LowestIndexTracker = p37;
    end;
end;
function v5.RemoveTracker(p38, p39) --[[ Line: 157 ]]
    p38.Trackers[p39] = nil;
    p38:UpdateTracker(p39);
end;
function v5.Constructor(p40, p41) --[[ Line: 162 ]]
    -- upvalues: u3 (copy)
    p40.AutoTrim = true;
    p40.IsRealtime = false;
    p40.Timer = p41;
    p40.Events = {};
    p40.Trackers = {};
    p40.EventAdded = u3();
    p40.EventListAdded = u3();
end;
return v5;
