-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tick;
local u2 = unpack;
local l__clear__1 = table.clear;
local l__obtain__2 = _G.obtain;
local u3 = l__obtain__2("LabelPrint");
local u4 = l__obtain__2("FakeRoot").Get("Server");
local l__SetContextData__3 = l__obtain__2("ContextManager").SetContextData;
local u5 = l__obtain__2("EventQueueGroup");
local l__RootTimer__4 = l__obtain__2("RealtimeTimerSystem").RootTimer;
local u6 = l__obtain__2("TimelineReplicationCommon");
local l__Channel__5 = u6.Channel;
local l__AdvanceLimit__6 = u6.AdvanceLimit;
local l__SubmitSample__7 = u6.SubmitSample;
local l__ExternalHandlers__8 = u6.ExternalHandlers;
local u7 = l__obtain__2("EventQueueIndexer")();
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};
local function u18() --[[ Line: 54 ]]
    -- upvalues: u7 (copy), u6 (copy), l__AdvanceLimit__6 (copy), l__clear__1 (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy), u8 (copy), l__Channel__5 (copy), u4 (copy), l__RootTimer__4 (copy)
    for v13 in u7.Active do
        local l__Timer__9 = v13.Timeline.Timer;
        v13:AdvanceToTimeWithIndexLimit(l__Timer__9:Time() + u6.Buffer * l__Timer__9:GetGlobalScale(), l__AdvanceLimit__6);
    end;
    l__clear__1(u9);
    l__clear__1(u10);
    l__clear__1(u11);
    l__clear__1(u12);
    local v14 = 0;
    for v15 in u7.Queued do
        local l__EventQueueGroup__10 = v15.EventQueueGroup;
        local v16 = u8[l__EventQueueGroup__10];
        local l__Data__11 = v16.Data;
        if not u9[l__EventQueueGroup__10] then
            u9[l__EventQueueGroup__10] = true;
            l__clear__1(l__Data__11);
            v14 = v14 + 1;
            u10[v14] = v16.Target;
            u11[v14] = v16.Name;
            u12[v14] = l__Data__11;
        end;
        v15:Build();
        l__Data__11[v15.Label] = v15.Queue;
    end;
    l__Channel__5:Send("ReplicateTimelineEvents", u4:Time(), l__RootTimer__4:Time(), v14, u10, u11, u12);
    for v17 in u7.Queued do
        v17:Flush();
    end;
end;
local u19 = {};
local u20 = {};
local function u32(p21, p22, p23, p24, p25) --[[ Line: 93 ]]
    -- upvalues: l__SubmitSample__7 (copy), u20 (copy), u3 (copy)
    l__SubmitSample__7(p21, p22);
    local v26 = u20[p21];
    if v26 then
        for v27 = 1, p23 do
            local v28 = v26[p24[v27]];
            if v28 then
                for v29, v30 in p25[v27] do
                    local v31 = v28[v29];
                    if v31 then
                        v31:PostList(v30);
                    else
                        u3("Timeline Label \'" .. tostring(v29) .. "\' does not exist for Index Player=", p21, "Name=", p24[v27]);
                    end;
                end;
            else
                u3("Group missing fromIndex Player=", p21, "Name=", p24[v27]);
            end;
        end;
    end;
end;
function u19.ReplicateTimelineEvents(p33, p34, p35, p36, p37, p38) --[[ Line: 117 ]]
    -- upvalues: l__SetContextData__3 (copy), u32 (copy)
    for v39 = 1, #p33 do
        l__SetContextData__3(p33[v39], "Ping", p38[v39]);
        u32(p33[v39], p34[v39], p35[v39], p36[v39], p37[v39]);
    end;
end;
local function u46(p40, p41, ...) --[[ Line: 124 ]]
    -- upvalues: l__ExternalHandlers__8 (copy), u20 (copy)
    local v42 = l__ExternalHandlers__8[p41](p40, ...);
    local v43 = v42 ~= nil;
    local v44 = "TimelineGroup==nil Name=" .. tostring(p41) .. " Player=" .. tostring(p40);
    assert(v43, v44);
    local v45 = u20[p40];
    if not v45 then
        v45 = {};
        u20[p40] = v45;
    end;
    v45[p41] = v42;
end;
u19.ReplicateTimelineGroup = u46;
function u19.SetTimelineGroups(p47) --[[ Line: 139 ]]
    -- upvalues: u3 (copy), u46 (copy), u2 (copy)
    u3("SetTimelineGroups #CallList=", #p47);
    for v48 = 1, #p47 do
        u46(u2(p47[v48]));
    end;
end;
function u19.RemoveTimelineGroups(p49) --[[ Line: 146 ]]
    -- upvalues: u20 (copy), l__clear__1 (copy), u3 (copy)
    local v50 = u20[p49];
    if v50 then
        l__clear__1(v50);
        u20[p49] = nil;
    else
        u3("RemoveTimelineGroups No such Index Player=", p49);
    end;
end;
l__Channel__5:Listen(function(p51, ...) --[[ Line: 156 ]]
    -- upvalues: u19 (copy), u3 (copy)
    local v52 = u19[p51];
    if v52 then
        v52(...);
    else
        u3("No such Handler Type=", p51);
    end;
end);
local u53 = u1() - 0.03333333333333333;
return {
    Init = function() --[[ Name: Init, Line 167 ]]
        -- upvalues: l__Channel__5 (copy), u1 (copy), u53 (ref), u18 (copy)
        l__Channel__5:Send("GetTimelineGroups");
        game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 169 ]]
            -- upvalues: u1 (ref), u53 (ref), u18 (ref)
            local v54 = u1();
            if v54 - u53 > 0.016666666666666666 then
                if v54 - u53 > 0.03333333333333333 then
                    u53 = v54;
                else
                    u53 = u53 + 0.016666666666666666;
                end;
                u18();
            end;
        end);
    end,
    ReplicateTimelineGroup = function(p55, p56, p57, ...) --[[ Name: ReplicateTimelineGroup, Line 35 ]]
        -- upvalues: u3 (copy), u5 (copy), u7 (copy), u8 (copy), l__Channel__5 (copy)
        u3("ReplicateTimelineGroup", p55, p56);
        u8[u5(p57, u7)] = {
            Target = p55,
            Name = p56,
            Data = {}
        };
        l__Channel__5:Send("ReplicateTimelineGroup", p55, p56, ...);
    end,
    SetHandler = u6.SetHandler
};
