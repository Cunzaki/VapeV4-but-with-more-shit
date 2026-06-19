-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local v2 = l__obtain__1("Class");
local u3 = l__obtain__1("Timers");
local v4 = l__obtain__1("CustomEnums");
local l__MODE_ALL__2 = v4.MODE_ALL;
local l__MODE_INPROGRESS__3 = v4.MODE_INPROGRESS;
local l__EVENT_RUN_CLEAR__4 = v4.EVENT_RUN_CLEAR;
local l__EVENT_RUN_FLAG__5 = v4.EVENT_RUN_FLAG;
local l__EVENT_RUN_LOADSTATE__6 = v4.EVENT_RUN_LOADSTATE;
local l__EVENT_RUN_SAVESTATE__7 = v4.EVENT_RUN_SAVESTATE;
local l__EVENT_SETTING_FOV__8 = v4.EVENT_SETTING_FOV;
local l__EVENT_SETTING_VSENSMUL__9 = v4.EVENT_SETTING_VSENSMUL;
local l__EVENT_SETTING_SENSITIVITY__10 = v4.EVENT_SETTING_SENSITIVITY;
local l__EVENT_SETTING_TURN_SPEED__11 = v4.EVENT_SETTING_TURN_SPEED;
local l__EVENT_SETTING_ABSOLUTE_SENS__12 = v4.EVENT_SETTING_ABSOLUTE_SENS;
local u5 = l__obtain__1("Zones");
local u6 = l__obtain__1("Physics");
local u7 = l__obtain__1("World");
local u8 = l__obtain__1("Signal");
local u9 = l__obtain__1("GameMechanics");
local u10 = l__obtain__1("CustomCamera");
local u11 = l__obtain__1("MulticallObjectMethod");
local l__UnpackageControls__13 = l__obtain__1("GameControl").UnpackageControls;
local v12 = v2();
function v12.GetState(p13) --[[ Line: 41 ]]
    return {
        Phys = p13.Phys:GetState(),
        GameMechanics = p13.GameMechanics:GetState(),
        Camera = p13.Camera:GetState()
    };
end;
function v12.SetState(p14, p15) --[[ Line: 48 ]]
    p14.Phys:SetState(p15.Phys);
    p14.GameMechanics:SetState(p15.GameMechanics);
    p14.Camera:SetState(p15.Camera);
end;
function v12.CopyState(p16, p17) --[[ Line: 54 ]]
    p16.Timer:CopyState(p17.Timer);
    p16.Phys:CopyState(p17.Phys);
    p16.GameMechanics:CopyState(p17.GameMechanics);
    p16.Camera:CopyState(p17.Camera);
end;
function v12.SyncState(p18, p19) --[[ Line: 60 ]]
    p18.Phys:SyncState(p19.Phys);
    p18.GameMechanics:CopyState(p19.GameMechanics);
    p18.Camera:CopyState(p19.Camera);
end;
function v12.DifferentiateState(p20, p21, p22) --[[ Line: 65 ]]
    assert(p22 ~= nil, "DifferentiateState Instructions cannot be nil");
    p20.Phys:DifferentiateState(p21.Phys, p22);
    p20.GameMechanics:DifferentiateState(p21.GameMechanics, p22);
    local v23, v24 = p20.Camera:DifferentiateState(p21.Camera);
    p22.CameraRemovals = v23;
    p22.CameraChanges = v24;
end;
function v12.IntegrateState(p25, p26) --[[ Line: 72 ]]
    p25.Phys:IntegrateState(p26);
    p25.GameMechanics:IntegrateState(p26);
    p25.Camera:IntegrateState(p26.CameraRemovals, p26.CameraChanges);
end;
function v12.Tick(p27, p28) --[[ Line: 79 ]]
    -- upvalues: u1 (copy)
    p27.GameMechanics:SetNextControls(p28);
    local l__Time__14 = p28.Time;
    if l__Time__14 < 0 or l__Time__14 >= 4194304 then
        u1("Attempted to run Simulation to insane time TargetTime=", l__Time__14);
        return false;
    end;
    local l__Phys__15 = p27.Phys;
    if p27.MovingPartsEnabled then
        local l__World__16 = l__Phys__15.World;
        l__World__16:PrepareInterpolationTarget(l__World__16.Timer:Time(l__Time__14));
    end;
    local v29 = l__Phys__15:Tick(l__Time__14);
    if not v29 then
        u1("Simulation failed!  Rescuing to last spawn.");
        l__Phys__15.Time = l__Time__14;
        p27.GameMechanics:Spawn(nil);
    end;
    p27.PostTick:Call(p27, l__Time__14);
    return v29;
end;
function v12.LoadWorld(p30, p31) --[[ Line: 109 ]]
    -- upvalues: u6 (copy)
    if p30.World.ID ~= p31.MapChangeID then
        p30.World:Remove();
        p30.World:InitClone(p31);
    end;
    local v32 = u6();
    v32.World:InitReuse(p30.World, p30.Timer, 0);
    p30.Phys = v32;
    local l__GameMechanics__17 = p30.GameMechanics;
    l__GameMechanics__17:AttachPhysics(v32);
    l__GameMechanics__17:SetStyle(l__GameMechanics__17:GetStyle());
    p30.Zones:Clear();
    p30.Ready = true;
end;
function v12.Fail(p33) --[[ Line: 125 ]]
    if not p33.Failed and p33.SendClientNoticeSpaghettiFunction then
        p33.Failed = true;
        p33.SendClientNoticeSpaghettiFunction(true);
    end;
end;
function v12.Unfail(p34) --[[ Line: 131 ]]
    if p34.SendClientNoticeSpaghettiFunction then
        p34.Failed = false;
        p34.SendClientNoticeSpaghettiFunction(false);
    end;
end;
local u85 = {
    SetFOV = function(p35, p36, p37) --[[ Name: SetFOV, Line 157 ]]
        -- upvalues: l__EVENT_SETTING_FOV__8 (copy)
        p35.GameMechanics:WrapSettingEvent(p36, l__EVENT_SETTING_FOV__8, p37);
    end,
    SetVSensMul = function(p38, p39, p40) --[[ Name: SetVSensMul, Line 160 ]]
        -- upvalues: l__EVENT_SETTING_VSENSMUL__9 (copy)
        p38.GameMechanics:WrapSettingEvent(p39, l__EVENT_SETTING_VSENSMUL__9, p40);
    end,
    SetSensitivity = function(p41, p42, p43) --[[ Name: SetSensitivity, Line 163 ]]
        -- upvalues: l__EVENT_SETTING_SENSITIVITY__10 (copy)
        p41.GameMechanics:WrapSettingEvent(p42, l__EVENT_SETTING_SENSITIVITY__10, p43);
    end,
    SetTurnSpeed = function(p44, p45, p46) --[[ Name: SetTurnSpeed, Line 166 ]]
        -- upvalues: l__EVENT_SETTING_TURN_SPEED__11 (copy)
        p44.GameMechanics.TurnSpeed = p46;
        p44.GameMechanics:WrapSettingEvent(p45, l__EVENT_SETTING_TURN_SPEED__11, p46);
    end,
    SetUseAbsoluteSens = function(p47, p48, p49) --[[ Name: SetUseAbsoluteSens, Line 170 ]]
        -- upvalues: l__EVENT_SETTING_ABSOLUTE_SENS__12 (copy)
        p47.GameMechanics:WrapSettingEvent(p48, l__EVENT_SETTING_ABSOLUTE_SENS__12, p49 == true and 1 or 0);
    end,
    SetStyle = function(p50, _, p51) --[[ Name: SetStyle, Line 173 ]]
        p50.GameMechanics:SetStyle(p51);
    end,
    SetGravity = function(p52, _, p53) --[[ Name: SetGravity, Line 176 ]]
        p52.GameMechanics:SetGravity(p53);
    end,
    SetAutoRestart = function(p54, _, p55) --[[ Name: SetAutoRestart, Line 179 ]]
        p54.GameMechanics.AutoRestart = p55;
    end,
    SetWorldTimerOffset = function(p56, _, p57) --[[ Name: SetWorldTimerOffset, Line 182 ]]
        p56.GameMechanics.WorldTimerOffset = p57;
    end,
    FlagAllRuns = function(p58, _, p59) --[[ Name: FlagAllRuns, Line 185 ]]
        -- upvalues: l__EVENT_RUN_FLAG__5 (copy), l__MODE_ALL__2 (copy)
        p58.OutputMulticall:Call("Run", p58.Phys.Time, l__EVENT_RUN_FLAG__5, l__MODE_ALL__2, p59);
    end,
    FlagInProgressRuns = function(p60, _, p61) --[[ Name: FlagInProgressRuns, Line 188 ]]
        -- upvalues: l__EVENT_RUN_FLAG__5 (copy), l__MODE_INPROGRESS__3 (copy)
        p60.OutputMulticall:Call("Run", p60.Phys.Time, l__EVENT_RUN_FLAG__5, l__MODE_INPROGRESS__3, p61);
    end,
    SetSimulationReady = function(p62, _, p63) --[[ Name: SetSimulationReady, Line 191 ]]
        p62.Ready = p63;
    end,
    LoadMapInfo = function(p64, _, p65) --[[ Name: LoadMapInfo, Line 194 ]]
        assert(p65 ~= nil, "MapInfo cannot be nil");
        p64.GameMechanics:SetMapInfo(p65);
        p64:LoadWorld(p65);
    end,
    PhysTimeTeleport = function(p66, _, p67) --[[ Name: PhysTimeTeleport, Line 199 ]]
        p66.Phys.Time = p67;
    end,
    Reset = function(p68, _, p69) --[[ Name: Reset, Line 202 ]]
        -- upvalues: l__EVENT_RUN_CLEAR__4 (copy), l__MODE_ALL__2 (copy)
        p68.OutputMulticall:Call("Run", p68.Phys.Time, l__EVENT_RUN_CLEAR__4, l__MODE_ALL__2);
        p68.GameMechanics:Reset(p69);
    end,
    MapSpawn0 = function(p70, _, p71) --[[ Name: MapSpawn0, Line 206 ]]
        -- upvalues: l__EVENT_RUN_CLEAR__4 (copy), l__MODE_ALL__2 (copy)
        p70.OutputMulticall:Call("Run", p70.Phys.Time, l__EVENT_RUN_CLEAR__4, l__MODE_ALL__2);
        p70.GameMechanics:Spawn(p71, true);
    end,
    Spawn = function(p72, _, p73) --[[ Name: Spawn, Line 210 ]]
        p72.GameMechanics:Spawn(p73, true);
    end,
    SetSpawn = function(p74, _, _) --[[ Name: SetSpawn, Line 213 ]]
        p74.GameMechanics:SetSpawn();
    end,
    SetFlyMode = function(p75, _, p76) --[[ Name: SetFlyMode, Line 216 ]]
        p75.GameMechanics:SetFlyMode(p76);
    end,
    SetFlySpeed = function(p77, _, p78) --[[ Name: SetFlySpeed, Line 219 ]]
        p77.GameMechanics.FlySpeed = p78;
    end,
    SaveState = function(p79, _, p80) --[[ Name: SaveState, Line 222 ]]
        -- upvalues: l__EVENT_RUN_SAVESTATE__7 (copy), l__MODE_ALL__2 (copy)
        local v81 = p79:GetState();
        v81.SimulationTime = p79.Phys.Time;
        p79.States[p80] = v81;
        p79.GameMechanics.RequireExplicitRestart = true;
        p79.OutputMulticall:Call("Run", p79.Phys.Time, l__EVENT_RUN_SAVESTATE__7, l__MODE_ALL__2, p80);
    end,
    LoadState = function(p82, _, p83) --[[ Name: LoadState, Line 229 ]]
        -- upvalues: l__EVENT_RUN_LOADSTATE__6 (copy), l__MODE_ALL__2 (copy)
        local l__Time__18 = p82.Phys.Time;
        local v84 = p82.States[p83];
        if v84 then
            p82:SetState(v84);
            p82.Phys.Time = l__Time__18;
            p82.Phys:SetPosition(v84.Phys.Position);
            p82.GameMechanics.RequireExplicitRestart = true;
            p82.OutputMulticall:Call("Run", l__Time__18, l__EVENT_RUN_LOADSTATE__6, l__MODE_ALL__2, p83);
        end;
    end
};
local u94 = {
    Input = function(p86, p87, p88, p89) --[[ Name: InputEvent, Line 138 ]]
        -- upvalues: l__UnpackageControls__13 (copy)
        if p86.Ready then
            p86:Tick(l__UnpackageControls__13(p87, p88, p89));
            p86.OutputMulticall:Call("Input", p87, p88, p89);
            if p86.Failed then
                p86:Unfail();
            end;
        else
            p86:Fail();
        end;
    end,
    Control = function(p90, p91, p92, ...) --[[ Name: ControlEvent, Line 241 ]]
        -- upvalues: u85 (copy), u1 (copy)
        if type(p91) == "number" then
            local v93 = u85[p92];
            if v93 then
                v93(p90, p91, ...);
            else
                u1("ControlEvent no such event: ", p92);
            end;
        else
            u1("ControlEvent Time is not type number: ", p91);
        end;
    end
};
v12.InputHandlers = u94;
function v12.HandleInput(p95, p96, ...) --[[ Line: 261 ]]
    -- upvalues: u94 (copy)
    u94[p96](p95, ...);
end;
local u106 = {
    SetPaused = function(p97, p98, p99) --[[ Name: SetPaused, Line 266 ]]
        if p99 then
            p97.Timer:Pause(p98);
        else
            p97.Timer:Play(p98);
        end;
    end,
    SetTimescale = function(p100, p101, p102) --[[ Name: SetTimescale, Line 273 ]]
        p100.Timer:SetScale(p101, p102);
    end,
    SetTime = function(p103, p104, p105) --[[ Name: SetTime, Line 276 ]]
        p103.Timer:SetTime(p104, p105);
    end
};
local u111 = {
    Aux = false,
    Timer = function(p107, p108, p109, ...) --[[ Name: TimerEvent, Line 281 ]]
        -- upvalues: u106 (copy), u1 (copy)
        if type(p108) == "number" then
            local v110 = u106[p109];
            if v110 then
                v110(p107, p108, ...);
            else
                u1("TimerEvent no such event: ", p109);
            end;
        else
            u1("TimerEvent Time is not type number: ", p108);
        end;
    end
};
v12.ControlHandlers = u111;
function v12.HandleControl(p112, p113, ...) --[[ Line: 298 ]]
    -- upvalues: u111 (copy)
    local v114 = u111[p113];
    if v114 then
        v114(p112, ...);
    end;
end;
function v12.Constructor(p115, p116) --[[ Line: 305 ]]
    -- upvalues: u8 (copy), u3 (copy), u10 (copy), u11 (copy), u5 (copy), u9 (copy), u6 (copy), u7 (copy)
    p115.MovingPartsEnabled = true;
    p115.PostTick = u8();
    p115.Timer = u3(p116);
    p115.Camera = u10();
    p115.OutputMulticall = u11();
    p115.Zones = u5();
    p115.GameMechanics = u9(p115);
    p115.Phys = u6();
    p115.World = u7();
    p115.States = {};
end;
return v12;
