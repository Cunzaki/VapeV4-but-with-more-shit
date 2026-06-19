-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = unpack;
local l__move__1 = table.move;
local l__clear__2 = table.clear;
local l__obtain__3 = _G.obtain;
local u2 = l__obtain__3("LabelPrint");
local v3 = l__obtain__3("Class")(l__obtain__3("EventQueueIndexer"));
function v3.Flush(p4) --[[ Line: 14 ]]
    -- upvalues: l__clear__2 (copy), u2 (copy), l__move__1 (copy), u1 (copy)
    local l__GlobalEvents__4 = p4.GlobalEvents;
    local l__GlobalEventLabels__5 = p4.GlobalEventLabels;
    l__clear__2(l__GlobalEvents__4);
    l__clear__2(l__GlobalEventLabels__5);
    for v5 in p4.Queued do
        local l__Events__6 = v5.Timeline.Events;
        local l__Processed__7 = v5.Processed;
        local l__Index__8 = l__Processed__7.Index;
        local l__Index__9 = v5.Queued.Index;
        local l__Label__10 = v5.Label;
        local v6 = l__Index__9 - l__Index__8;
        local v7 = #l__GlobalEvents__4;
        if v7 ~= 0 then
            if v6 == 0 then
                u2("Impossible case");
            else
                for v8 = v7 + v6, 1, -1 do
                    local v9 = l__Events__6[v6];
                    local v10 = l__GlobalEvents__4[v8 - v6];
                    if v9[1] < v10[1] then
                        l__GlobalEvents__4[v8] = v10;
                        l__GlobalEventLabels__5[v8] = l__GlobalEventLabels__5[v8 - v6];
                    else
                        v6 = v6 - 1;
                        if v8 == v6 then
                            break;
                        end;
                        l__GlobalEvents__4[v8] = v9;
                        l__GlobalEventLabels__5[v8] = l__Label__10;
                    end;
                end;
            end;
        end;
        if v6 ~= 0 then
            for v11 = 1, v6 do
                l__GlobalEventLabels__5[v11] = l__Label__10;
            end;
            l__move__1(l__Events__6, 1, v6, 1, l__GlobalEvents__4);
        end;
        l__Processed__7:SetIndex(l__Index__9);
    end;
    local l__Multicall__11 = p4.Multicall;
    local l__Call__12 = l__Multicall__11.Call;
    for v12 = 1, #l__GlobalEvents__4 do
        l__Call__12(l__Multicall__11, l__GlobalEventLabels__5[v12], u1(l__GlobalEvents__4[v12]));
    end;
end;
function v3.Constructor(p13) --[[ Line: 68 ]]
    p13.GlobalEvents = {};
    p13.GlobalEventLabels = {};
end;
return v3;
