-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local l__yield__2 = coroutine.yield;
local l__obtain__3 = _G.obtain;
local v1 = l__obtain__3("Class");
local u2 = l__obtain__3("LabelPrint");
local u3 = l__obtain__3("Signal");
local u4 = l__obtain__3("Timelines");
local u5 = l__obtain__3("EventQueue");
local u6 = l__obtain__3("TimelineGroup");
local u7 = l__obtain__3("EventQueueGroup");
local u8 = l__obtain__3("EventQueueIndexer");
l__obtain__3("EventQueueIndexerCareful");
local u9 = l__obtain__3("Simulation");
local l__UnpackageControls__4 = l__obtain__3("GameControl").UnpackageControls;
local u10 = l__obtain__3("WriteSimulationStateDiffToTimeline");
local l__Job__5 = l__obtain__3("coProcessor").Job;
local function u18(p11, p12) --[[ Line: 34 ]]
    local l__Position__6 = p11.Phys.Position;
    local l__Position__7 = p12.Phys.Position;
    local l__Velocity__8 = p11.Phys.Velocity;
    local l__Velocity__9 = p12.Phys.Velocity;
    local l__Angles__10 = p11.Camera.Angles;
    local l__Angles__11 = p12.Camera.Angles;
    local v13 = l__Position__6 - l__Position__7;
    local v14 = v13.magnitude >= 1e-6 and v13.magnitude / l__Position__7.magnitude >= 0.0001;
    local v15 = l__Velocity__8 - l__Velocity__9;
    local v16 = v15.magnitude >= 1e-6 and v15.magnitude / l__Velocity__9.magnitude >= 0.0001 and true or v14;
    local v17 = l__Angles__10 - l__Angles__11;
    if v17.magnitude >= 1e-6 then
        if v17.magnitude / l__Angles__11.magnitude < 0.0001 then
            return v16;
        end;
        v16 = true;
    end;
    return v16;
end;
local function u22(p19, p20, _, p21) --[[ Line: 64 ]]
    if p20 == "State" then
        p19:IntegrateState(p21);
    end;
end;
local v23 = v1();
function v23.Initialize(u24) --[[ Line: 72 ]]
    u24.ServerStateTimeline.EventListAdded:Add(function() --[[ Line: 73 ]]
        -- upvalues: u24 (copy)
        u24:Run();
    end);
end;
function v23.BindSimulation(p25, p26, p27) --[[ Line: 79 ]]
    -- upvalues: u10 (copy)
    p25.Simulation = p26;
    p25.SimulationDirector = p27;
    p27.OutputMulticall:Register(p25.SimulationDirectorOutputTimelines, p25.SimulationDirectorOutputTimelines.PostTo);
    u10(p26, p27, p25.ClientStateTimeline);
end;
function v23.CopyStateHelper(p28, p29, p30) --[[ Line: 87 ]]
    -- upvalues: l__clear__1 (copy)
    local l__TempInstructions__12 = p28.TempInstructions;
    l__clear__1(l__TempInstructions__12);
    p29:DifferentiateState(p30, l__TempInstructions__12);
    p29:IntegrateState(l__TempInstructions__12);
end;
function v23.SynchronizeState(p31, p32) --[[ Line: 94 ]]
    -- upvalues: u2 (copy), l__Job__5 (copy), l__yield__2 (copy)
    local l__Simulation__13 = p31.Simulation;
    local l__KetchupSimulation__14 = p31.KetchupSimulation;
    local l__ServerState__15 = p31.ServerState;
    p31.ClientState:CopyState(l__ServerState__15);
    l__KetchupSimulation__14:SyncState(l__ServerState__15);
    l__KetchupSimulation__14.Phys:SetPosition(l__KetchupSimulation__14.Phys.Position);
    l__KetchupSimulation__14.GameMechanics:SetNextControls(p32);
    l__KetchupSimulation__14.GameMechanics:PropagateControls();
    if p31.Ketchup then
        u2("in-progress catch-up");
    else
        local l__SimulationDirectorIndexer__16 = p31.SimulationDirectorIndexer;
        if l__Simulation__13.Phys.Time - l__KetchupSimulation__14.Phys.Time > 0.16 then
            p31.Desynced:Call();
            p31.Ketchup = true;
            l__Job__5(function() --[[ Line: 122 ]]
                -- upvalues: l__Simulation__13 (copy), l__KetchupSimulation__14 (copy), l__SimulationDirectorIndexer__16 (copy), l__yield__2 (ref)
                while l__Simulation__13.Phys.Time - l__KetchupSimulation__14.Phys.Time > 0.16 do
                    l__SimulationDirectorIndexer__16:Run(l__KetchupSimulation__14.Phys.Time + 0.16);
                    l__yield__2();
                end;
            end);
            p31.Ketchup = false;
        end;
        l__SimulationDirectorIndexer__16:Advance();
        l__Simulation__13:SyncState(l__KetchupSimulation__14);
        p31.Resynced:Call();
    end;
end;
function v23.Run(p33) --[[ Line: 136 ]]
    -- upvalues: u18 (copy), l__UnpackageControls__4 (copy), u2 (copy)
    p33.ServerStateIndexer:Advance();
    local v34 = p33.ServerStateEventQueue.Queued:Before();
    if v34 then
        local v35 = v34[1];
        p33.ClientStateIndexer:Run(v35);
        local v36 = v35 / p33.SimulationDirector.TickRate;
        local l__Ketchup__17 = p33.Ketchup;
        if not l__Ketchup__17 or l__Ketchup__17 and p33.KetchupSimulation.Phys.Time < v36 then
            p33.SimulationDirectorOutputEventQueues:Jump(v36);
            local v37 = p33.SimulationDirectorOutputEventQueues.Input.Queued:Before();
            if not v37 then
                u2("Impossible case: abort resync!  Camera may appear to teleport.");
                return;
            end;
            if l__Ketchup__17 or u18(p33.ClientState, p33.ServerState) then
                p33:SynchronizeState(l__UnpackageControls__4(unpack(v37)));
            end;
        end;
    else
        u2("No StateEvent");
    end;
end;
function v23.SetMapInfo(p38, p39) --[[ Line: 174 ]]
    p38.KetchupSimulation.GameMechanics:SetMapInfo(p39);
    p38.ClientState.GameMechanics:SetMapInfo(p39);
    p38.ServerState.GameMechanics:SetMapInfo(p39);
end;
function v23.LoadWorld(p40, p41) --[[ Line: 180 ]]
    p40.KetchupSimulation:LoadWorld(p41);
    p40.ClientState:LoadWorld(p41);
    p40.ServerState:LoadWorld(p41);
end;
function v23.Constructor(p42) --[[ Line: 186 ]]
    -- upvalues: u8 (copy), u6 (copy), u5 (copy), u4 (copy), u9 (copy), u7 (copy), u22 (copy), u3 (copy)
    local v43 = u8();
    local v44 = u6();
    local v45 = v44:CreateTimeline("State");
    local v46 = u5(v45, v43, "State");
    v45.KeepN = 1;
    p42.ServerStateIndexer = v43;
    p42.ServerStateTimelines = v44;
    p42.ServerStateTimeline = v45;
    p42.ServerStateEventQueue = v46;
    local v47 = u8();
    local v48 = u4();
    local v49 = u5(v48, v47, "State");
    p42.ClientStateIndexer = v47;
    p42.ClientStateTimeline = v48;
    p42.ClientStateEventQueue = v49;
    local v50 = u8();
    local v51 = u6();
    v51:CopyHandlers(u9.Metamethods.InputHandlers);
    local v52 = u7(v51, v50);
    v51.Input.KeepN = 30;
    p42.SimulationDirectorIndexer = v50;
    p42.SimulationDirectorOutputTimelines = v51;
    p42.SimulationDirectorOutputEventQueues = v52;
    local v53 = u9();
    p42.KetchupSimulation = v53;
    p42.SimulationDirectorIndexer.Multicall:Register(v53, v53.HandleInput);
    local v54 = u9();
    local v55 = u9();
    v43.Multicall:Register(v54, u22);
    v47.Multicall:Register(v55, u22);
    p42.ServerState = v54;
    p42.ClientState = v55;
    p42.TempInstructions = {};
    p42.Desynced = u3();
    p42.Resynced = u3();
end;
return v23;
