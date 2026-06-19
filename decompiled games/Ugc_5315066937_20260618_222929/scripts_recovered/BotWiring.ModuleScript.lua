-- Decompiled from: BotWiring
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local l__Get__2 = l__obtain__1("FakeRoot").Get;
local l__RootTimer__3 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local l__GetRaceBot__4 = l__obtain__1("Race").GetRaceBot;
local v2 = l__obtain__1("BotManager");
local l__CreateBot__5 = v2.CreateBot;
local l__GetBotFromId__6 = v2.GetBotFromId;
local u3 = l__obtain__1("PlaybackContext");
local u4 = l__obtain__1("MulticallObjectMethod");
local v5 = l__obtain__1("ContextManager");
local l__GetContext__7 = v5.GetContext;
local l__RegisterContext__8 = v5.RegisterContext;
local u6 = l__obtain__1("OfflineContext");
local u7 = l__obtain__1("Timelines");
local u8 = l__obtain__1("EventQueue");
local u9 = l__obtain__1("TimelineGroup");
local u10 = l__obtain__1("EventQueueGroup");
local u11 = l__obtain__1("EventQueueIndexer");
local v12 = l__obtain__1("TimelineReplication");
local l__ReplicateTimelineGroup__9 = v12.ReplicateTimelineGroup;
local u13 = {
    "World",
    "Gravity",
    "Camera",
    "Setting",
    "Run"
};
local u14 = { "Output", "Input", "Sound" };
local function u22(p15, p16, p17, p18, p19) --[[ Line: 40 ]]
    -- upvalues: u13 (copy), u14 (copy)
    if p16 == "Timer" and p18 == "SetTime" then
        p15.TimeTravelCount = p15.TimeTravelCount + 1;
        p15.InsideEventQueue:JumpToIndex(1);
        local l__EventQueues__10 = p15.Context.EventQueues;
        for v20 = 1, #u13 do
            l__EventQueues__10[u13[v20]]:JumpToIndex(1);
        end;
        for v21 = 1, #u14 do
            l__EventQueues__10[u14[v21]]:JumpToTime(p19);
        end;
        p15.Camera:NoBlunder();
    end;
    p15:HandleControl(p16, p17, p18, p19);
end;
local function u28(p23, _, p24, p25) --[[ Line: 62 ]]
    -- upvalues: l__GetRaceBot__4 (copy)
    if p25 == "RECORDING_END" then
        local l__Timer__11 = p23.Timer;
        if l__Timer__11.Scale ~= 0 then
            local v26 = p23.TimeTravelCount + 1;
            p23.TimeTravelCount = v26;
            local v27 = l__Timer__11:ParentTime(p24);
            p23.PlaybackControl:Call("Timer", v27, "SetPaused", true);
            if p23.Player ~= l__GetRaceBot__4() then
                p23.OutsideTimeline:Post({ v27 + 1, "PLAYBACK_SEEK_BEGINNING", v26 });
            end;
        end;
    end;
end;
local function u33(p29, _, p30, p31, p32) --[[ Line: 78 ]]
    if p31 == "PLAYBACK_SEEK_BEGINNING" and p29.TimeTravelCount == p32 then
        p29.PlaybackControl:Call("Timer", p30, "SetTime", p29.TEMP_BEGINTIME);
        p29.PlaybackControl:Call("Timer", p30, "SetPaused", false);
    end;
end;
v12.SetHandler("BotPlayback", function(p34, p35, p36, p37, p38, p39) --[[ Line: 88 ]]
    -- upvalues: u1 (copy), l__CreateBot__5 (copy), u3 (copy), l__RootTimer__3 (copy), u9 (copy), u6 (copy), u7 (copy), u11 (copy), u8 (copy), u28 (copy), u33 (copy), l__ReplicateTimelineGroup__9 (copy), u4 (copy), u22 (copy), l__RegisterContext__8 (copy)
    u1("BotPlayback BotId=", p34, "BotName=", p35, "BotUserId=", p36);
    local v40 = u3(l__CreateBot__5(p34, p35, p36), l__RootTimer__3);
    local v41 = u9();
    v41:CopyHandlers(v40.InputHandlers, v40.Timer);
    v41:SetAutoTrim(false);
    local v42 = u6(v40.Timer, v41);
    v40.Context = v42;
    v42.Indexer.Multicall:Register(v40, v40.HandleInput);
    v40.Timer:SetTime(p37, p38);
    v40.TimeTravelCount = 0;
    v40.TEMP_BEGINTIME = p38;
    v40.TEMP_ENDTIME = p39;
    local v43 = u7(v40.Timer);
    v43.AutoTrim = false;
    v43:Post({ p39, "RECORDING_END" });
    local v44 = u11();
    v40.InsideEventQueue = u8(v43, v44, "InsideEventQueue");
    v40.InsideIndexer = v44;
    v40.InsideTimeline = v43;
    v44.Multicall:Register(v40, u28);
    local v45 = u7(l__RootTimer__3);
    local v46 = u11();
    v40.OutsideEventQueue = u8(v45, v46, "OutsideEventQueue");
    v40.OutsideIndexer = v46;
    v40.OutsideTimeline = v45;
    v46.Multicall:Register(v40, u33);
    local v47 = u9();
    v47:CopyHandlers(v40.ControlHandlers, l__RootTimer__3);
    l__ReplicateTimelineGroup__9(p34, "BotPlaybackControl", v47);
    local v48 = u4();
    v48:Register(v40, u22);
    v48:Register(v47, v47.PostTo);
    v40.PlaybackControl = v48;
    l__RegisterContext__8(v40);
    return v41;
end);
v12.SetHandler("BotPlaybackData", function(p49) --[[ Line: 140 ]]
    -- upvalues: l__GetBotFromId__6 (copy), l__GetContext__7 (copy), u11 (copy), u9 (copy), l__Get__2 (copy), u10 (copy), u1 (copy)
    local v50 = l__GetBotFromId__6(p49);
    if v50 then
        local v51 = l__GetContext__7(v50);
        if v51 then
            local v52 = u11();
            v51.DataIndexer = v52;
            local v53 = u9();
            v53:CopyHandlers(v51.DataHandlers, l__Get__2(v50));
            u10(v53, v52);
            v52.Multicall:Register(v51, v51.HandleData);
            return v53;
        end;
        u1("Missing PlaybackContext for bot id=", p49, "Name=", v50.Name);
    else
        u1("Missing bot id=", p49);
    end;
end);
return true;
