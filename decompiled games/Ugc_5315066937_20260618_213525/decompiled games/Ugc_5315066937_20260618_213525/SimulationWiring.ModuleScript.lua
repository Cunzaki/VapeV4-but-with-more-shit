-- Decompiled from: SimulationWiring
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local v2 = l__obtain__1("Remote");
local l__RootTimer__2 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local l__Get__3 = l__obtain__1("FakeRoot").Get;
local u3 = l__obtain__1("TimelineGroup");
local u4 = l__obtain__1("EventQueueIndexer");
local v5 = l__obtain__1("TimelineReplication");
local v6 = l__obtain__1("Simulation");
local v7 = l__obtain__1("SimulationDirector");
local v8 = l__obtain__1("SimulationControl");
local u9 = l__obtain__1("PlaybackContext");
local v10 = l__obtain__1("RealtimeContext");
local u11 = l__obtain__1("OfflineContext");
local u12 = l__obtain__1("EventQueueGroup");
local v13 = l__obtain__1("SmoothingSimulation");
local v14 = l__obtain__1("ContextManager");
local l__GetContext__4 = v14.GetContext;
local l__RegisterContext__5 = v14.RegisterContext;
local v15 = l__obtain__1("SimulationSynchronization");
local u16 = l__obtain__1("MapManager");
local l__LocalPlayer__6 = game:GetService("Players").LocalPlayer;
local v17 = v6(l__RootTimer__2);
v17.GameMechanics.debugGetMousePos = true;
v13.Simulation.GameMechanics.debugGetMousePos = true;
v13.SetReferenceSimulation(v17);
local v18 = u9("Local", l__RootTimer__2, v10(v17, v13.Simulation));
l__RegisterContext__5(v18);
local u19 = v7(v17.Timer);
v8.OutputMulticall:Register(u19, u19.HandleInput);
u19.OutputMulticall:Register(v17, v17.HandleInput);
u19.ControlMulticall:Register(v17, v17.HandleControl);
v17.OutputMulticall:Register(v18, v18.HandleInput);
u19.ControlMulticall:Register(v18, v18.HandleControl);
local v20 = u3();
v20:CopyHandlers(u19.InputHandlers, l__RootTimer__2);
v8.OutputMulticall:Register(v20, v20.PostTo);
v5.ReplicateTimelineGroup("Character", "SimulationControl", v20);
v5.SetHandler("Playback", function(p21) --[[ Line: 76 ]]
    -- upvalues: u1 (copy), l__Get__3 (copy), u9 (copy), u3 (copy), u11 (copy), l__RegisterContext__5 (copy)
    if p21 then
        local v22 = u9(p21, (l__Get__3(p21)));
        local v23 = u3();
        v23:CopyHandlers(v22.InputHandlers, v22.Timer);
        for _, v24 in next, v23 do
            v24.KeepN = 1;
        end;
        local v25 = u11(v22.Timer, v23);
        v22.Context = v25;
        v25.Indexer.Multicall:Register(v22, v22.HandleInput);
        l__RegisterContext__5(v22);
        return v23;
    end;
    u1("Player is nil");
end);
v5.SetHandler("PlaybackControl", function(p26) --[[ Line: 95 ]]
    -- upvalues: l__GetContext__4 (copy), l__Get__3 (copy), u4 (copy), u3 (copy), u12 (copy), u1 (copy)
    local v27 = l__GetContext__4(p26);
    if v27 then
        local v28 = l__Get__3(p26);
        local v29 = u4();
        v27.Context.ControlIndexer = v29;
        local v30 = u3();
        v30:CopyHandlers(v27.ControlHandlers, v28);
        u12(v30, v29);
        v29.Multicall:Register(v27, v27.HandleControl);
        return v30;
    end;
    u1("Fatal replication bug: PlaybackContext does not exist for player", p26);
end);
l__RegisterContext__5(u9(l__LocalPlayer__6, l__Get__3(l__LocalPlayer__6)));
v5.SetHandler("PlaybackData", function(p31) --[[ Line: 115 ]]
    -- upvalues: l__GetContext__4 (copy), l__Get__3 (copy), u4 (copy), u3 (copy), u12 (copy), u1 (copy)
    local v32 = l__GetContext__4(p31);
    if v32 then
        local v33 = l__Get__3(p31);
        local v34 = u4();
        v32.DataIndexer = v34;
        local v35 = u3();
        v35:CopyHandlers(v32.DataHandlers, v33);
        u12(v35, v34);
        v34.Multicall:Register(v32, v32.HandleData);
        return v35;
    end;
    u1("PlaybackData no PlaybackContext for Player=", p31);
end);
local v36 = l__obtain__1("QBox");
local u37 = 0;
local u38 = v36.TextBox(nil, "Desync will happen soon");
u38.Visible = false;
u38.PosScaleX = 0.5;
u38.PosOffsetX = -250;
u38.PosScaleY = 1;
u38.PosOffsetY = -50;
u38.SizeOffsetX = 500;
u38.SizeOffsetY = 40;
u38.DrawBackground = false;
u38.TextSize = 20 * v36.roblox_messing_with_guis_factor;
u38.TextAlignment = "Center";
v36.DragBar(u38, u38);
local u39 = v15();
u39:BindSimulation(v17, u19);
u39:Initialize();
local u40 = v36.Color(255, 0, 0);
local l__TextColor1__7 = v36.TextColor1;
u39.Desynced:Add(function() --[[ Line: 157 ]]
    -- upvalues: u38 (copy), u40 (copy)
    u38.TextColor = u40;
end);
u39.Resynced:Add(function() --[[ Line: 160 ]]
    -- upvalues: u38 (copy), l__TextColor1__7 (copy), u37 (ref)
    u38.TextColor = l__TextColor1__7;
    u37 = u37 + 1;
    u38.Text = "Resynchronization Attempts: " .. u37;
end);
v2.Add("SimulationFailed", function(p41) --[[ Line: 166 ]]
    -- upvalues: u38 (copy)
    if p41 then
        u38.Text = "Server SimulationReady has failed.  Times will not count!  Must rejoin!";
    else
        u38.Text = "Simulation is Ready";
    end;
end);
local v42 = l__obtain__1("Command");
v42.Add("desync", {}, function() --[[ Line: 175 ]]
    -- upvalues: u38 (copy)
    u38.Visible = not u38.Visible;
end);
v42.Add("desync", { "Boolean" }, function(p43) --[[ Line: 178 ]]
    -- upvalues: u38 (copy)
    u38.Visible = p43;
end);
v2.Add("FlagInProgressRuns", function() --[[ Line: 182 ]]
    -- upvalues: u19 (copy), l__RootTimer__2 (copy)
    u19:FlagInProgressRuns(l__RootTimer__2:Time());
end);
v5.SetHandler("State", function(_) --[[ Line: 186 ]]
    -- upvalues: u39 (copy)
    return u39.ServerStateTimelines;
end);
local function u45(p44) --[[ Line: 190 ]]
    -- upvalues: u39 (copy)
    u39:SetMapInfo(p44);
    u39:LoadWorld(p44);
end;
return function() --[[ Line: 195 ]]
    -- upvalues: u16 (copy), u39 (copy), u45 (copy)
    local l__MapInfo__8 = u16.MapInfo;
    if l__MapInfo__8 then
        u39:SetMapInfo(l__MapInfo__8);
        u39:LoadWorld(l__MapInfo__8);
    end;
    u16.MapInfoChanged:Add(u45);
end;
