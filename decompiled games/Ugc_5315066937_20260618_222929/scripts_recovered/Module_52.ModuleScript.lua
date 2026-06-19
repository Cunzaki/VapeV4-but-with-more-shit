-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local u2 = typeof;
local u3 = tostring;
local l__band__1 = bit32.band;
local l__floor__2 = math.floor;
local l__obtain__3 = _G.obtain;
local u4 = l__obtain__3("LabelPrint");
local v5 = l__obtain__3("Class");
local u6 = l__obtain__3("CustomEnums");
local _ = u6.MODE_MAIN;
local _ = u6.FLAGREASON_ANTICHEAT;
local l__FLAGREASON_STYLECHANGE__4 = u6.FLAGREASON_STYLECHANGE;
local l__FLAGREASON_PAUSE__5 = u6.FLAGREASON_PAUSE;
local l__FLAGREASON_FLYING__6 = u6.FLAGREASON_FLYING;
local l__FLAGREASON_GRAVITY__7 = u6.FLAGREASON_GRAVITY;
local l__FLAGREASON_TIMESCALE__8 = u6.FLAGREASON_TIMESCALE;
local l__FLAGREASON_TIMETRAVEL__9 = u6.FLAGREASON_TIMETRAVEL;
local l__FLAGREASON_TELEPORT__10 = u6.FLAGREASON_TELEPORT;
local l__EVENT_INPUT_CONTROLS__11 = u6.EVENT_INPUT_CONTROLS;
local l__EVENT_INPUT_RESET__12 = u6.EVENT_INPUT_RESET;
local l__EVENT_INPUT_WORLDTIMEROFFSET__13 = u6.EVENT_INPUT_WORLDTIMEROFFSET;
local l__EVENT_INPUT_MAP__14 = u6.EVENT_INPUT_MAP;
local l__EVENT_INPUT_PAUSE__15 = u6.EVENT_INPUT_PAUSE;
local l__EVENT_INPUT_INIT__16 = u6.EVENT_INPUT_INIT;
local l__EVENT_INPUT_READY__17 = u6.EVENT_INPUT_READY;
local l__EVENT_INPUT_PRACTICEMODE__18 = u6.EVENT_INPUT_PRACTICEMODE;
local l__EVENT_INPUT_SPAWN__19 = u6.EVENT_INPUT_SPAWN;
local l__EVENT_INPUT_TIME__20 = u6.EVENT_INPUT_TIME;
local l__EVENT_INPUT_TIMESCALE__21 = u6.EVENT_INPUT_TIMESCALE;
local l__EVENT_INPUT_SAVESTATE__22 = u6.EVENT_INPUT_SAVESTATE;
local l__EVENT_INPUT_LOADSTATE__23 = u6.EVENT_INPUT_LOADSTATE;
local l__EVENT_INPUT_FLYMODE__24 = u6.EVENT_INPUT_FLYMODE;
local l__EVENT_INPUT_FLYSPEED__25 = u6.EVENT_INPUT_FLYSPEED;
local l__EVENT_INPUT_SETSPAWN__26 = u6.EVENT_INPUT_SETSPAWN;
local l__EVENT_INPUT_STYLE__27 = u6.EVENT_INPUT_STYLE;
local l__EVENT_INPUT_FOV__28 = u6.EVENT_INPUT_FOV;
local l__EVENT_INPUT_VSENSMUL__29 = u6.EVENT_INPUT_VSENSMUL;
local l__EVENT_INPUT_SENSITIVITY__30 = u6.EVENT_INPUT_SENSITIVITY;
local l__EVENT_INPUT_TURN_SPEED__31 = u6.EVENT_INPUT_TURN_SPEED;
local l__EVENT_INPUT_ABSOLUTE_SENS__32 = u6.EVENT_INPUT_ABSOLUTE_SENS;
local _ = u6.EVENT_INPUT_GAIN;
local _ = u6.EVENT_INPUT_GRAVITY;
local l__EVENT_INPUT_AUTORESTART__33 = u6.EVENT_INPUT_AUTORESTART;
local u7 = l__obtain__3("Styles");
local l__CreateStyleInfo__34 = u7.CreateStyleInfo;
local u8 = l__obtain__3("MulticallObjectMethod");
local u9 = l__obtain__3("MapManager");
local u10 = l__obtain__3("GameControl").GetControlBit("Jump");
local u11 = bit32.bnot(u10);
local l__zero__35 = Vector2.zero;
local l__Lerp__36 = l__zero__35.Lerp;
local v12 = v5();
local function u22(p13, p14, p15, p16, p17) --[[ Line: 76 ]]
    -- upvalues: u1 (copy), u2 (copy), u11 (copy), l__band__1 (copy), u10 (copy), l__Lerp__36 (copy), l__floor__2 (copy), u4 (copy), l__FLAGREASON_TIMETRAVEL__9 (copy), u3 (copy)
    if u1(p14) == "number" and (u1(p15) == "number" and (u2(p16) == "Vector2" and u1(p17) == "number")) then
        local l__t0__37 = p13.t0;
        local l__k0__38 = p13.k0;
        local l__m0__39 = p13.m0;
        local l__s0__40 = p13.s0;
        local v18 = p13.Timer:Time(p14);
        p13.t0 = v18;
        p13.k0 = p15;
        p13.m0 = p16;
        p13.s0 = p17;
        if l__t0__37 and l__t0__37 < v18 then
            local l__NextInputN__41 = p13.NextInputN;
            local v19 = l__NextInputN__41 / p13.TickRate;
            while v19 < v18 do
                if p13.StyleInfo and p13.StyleInfo.scroll_jump then
                    l__k0__38 = l__band__1(l__k0__38, u11) + (p13.Input_s0 == l__s0__40 and 0 or (u10 or 0));
                end;
                p13.Input_s0 = l__s0__40;
                p13.OutputMulticall:Call("Input", v19, l__k0__38, l__Lerp__36(l__m0__39, p16, (v19 - l__t0__37) / (v18 - l__t0__37)));
                local v20 = p13.NextInputN + 1;
                p13.NextInputN = v20;
                v19 = v20 / p13.TickRate;
                if v20 - l__NextInputN__41 > 256 then
                    local v21 = l__floor__2(v18 * p13.TickRate);
                    u4("Over 256 ticks attempted to run! t0=", l__t0__37, "t1=", v18, "N=", v21 - l__NextInputN__41);
                    p13.OutputMulticall:Call("Control", v19, "FlagInProgressRuns", l__FLAGREASON_TIMETRAVEL__9);
                    p13.NextInputN = v21;
                    p13.t0 = nil;
                    p13.k0 = nil;
                    p13.m0 = nil;
                    p13.s0 = nil;
                    return;
                end;
            end;
        end;
    else
        error("WeaveInput invalid Time=" .. u3(p14) .. "k1=" .. u3(p15) .. "m1=" .. u3(p16) .. "s1=" .. u3(p17));
    end;
end;
function v12.CheckSimulation(p23, p24) --[[ Line: 121 ]]
    -- upvalues: u6 (copy), l__FLAGREASON_STYLECHANGE__4 (copy), l__FLAGREASON_FLYING__6 (copy), l__FLAGREASON_TIMESCALE__8 (copy), l__FLAGREASON_GRAVITY__7 (copy)
    if p23.PracticeMode then
        return u6.FLAGREASON_PRACTICE;
    end;
    local l__GameMechanics__42 = p24.GameMechanics;
    local l__StyleInfo__43 = l__GameMechanics__42.StyleInfo;
    if l__StyleInfo__43.id ~= p23.StyleInfo.id then
        return l__FLAGREASON_STYLECHANGE__4;
    end;
    if l__GameMechanics__42.FlyMode ~= l__StyleInfo__43.fly_mode and not l__StyleInfo__43.allow_fly then
        return l__FLAGREASON_FLYING__6;
    end;
    if p24.Timer.Scale ~= l__StyleInfo__43.timescale and not l__StyleInfo__43.allow_timescale then
        return l__FLAGREASON_TIMESCALE__8;
    end;
    if p24.Phys.Gravity ~= l__StyleInfo__43.gravity and not l__StyleInfo__43.allow_gravity then
        return l__FLAGREASON_GRAVITY__7;
    end;
end;
function v12.FlagInProgressRuns(p25, p26, p27) --[[ Line: 142 ]]
    p25.OutputMulticall:Call("Control", p25.Timer:Time(p26), "FlagInProgressRuns", p27);
end;
local u98 = {
    [l__EVENT_INPUT_CONTROLS__11] = u22,
    [l__EVENT_INPUT_INIT__16] = function(p28, _, _) --[[ Line: 151 ]]
        -- upvalues: u4 (copy), u22 (copy), l__zero__35 (copy)
        if p28.Initialized then
            u4("Attempted to init more than once");
        else
            p28.Initialized = true;
            u22(p28, 0, 0, l__zero__35, 0);
        end;
    end,
    [l__EVENT_INPUT_FOV__28] = function(p29, p30, p31) --[[ Line: 159 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p30) == "number" and (u1(p31) == "number" and (p31 >= 1 and p31 <= 120)) then
            p29.OutputMulticall:Call("Control", p29.Timer:Time(p30), "SetFOV", p31);
        else
            u4("SetFOV invalid Time=", p30, "Value=", p31);
        end;
    end,
    [l__EVENT_INPUT_VSENSMUL__29] = function(p32, p33, p34) --[[ Line: 166 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p33) == "number" and u1(p34) == "number" then
            p32.OutputMulticall:Call("Control", p32.Timer:Time(p33), "SetVSensMul", p34);
        else
            u4("SetVSensMul invalid Time=", p33, "Value=", p34);
        end;
    end,
    [l__EVENT_INPUT_SENSITIVITY__30] = function(p35, p36, p37) --[[ Line: 173 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p36) == "number" and u1(p37) == "number" then
            p35.OutputMulticall:Call("Control", p35.Timer:Time(p36), "SetSensitivity", p37);
        else
            u4("SetSensitivity invalid Time=", p36, "Value=", p37);
        end;
    end,
    [l__EVENT_INPUT_TURN_SPEED__31] = function(p38, p39, p40) --[[ Line: 180 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p39) == "number" and u1(p40) == "number" then
            p38.OutputMulticall:Call("Control", p38.Timer:Time(p39), "SetTurnSpeed", p40);
        else
            u4("SetTurnSpeed invalid Time=", p39, "Value=", p40);
        end;
    end,
    [l__EVENT_INPUT_ABSOLUTE_SENS__32] = function(p41, p42, p43) --[[ Line: 187 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p42) == "number" and u1(p43) == "boolean" then
            p41.OutputMulticall:Call("Control", p41.Timer:Time(p42), "SetUseAbsoluteSens", p43);
        else
            u4("SetUseAbsoluteSens invalid Time=", p42, "Value=", p43);
        end;
    end,
    [l__EVENT_INPUT_STYLE__27] = function(p44, p45, p46) --[[ Line: 194 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_STYLECHANGE__4 (copy), l__CreateStyleInfo__34 (copy), u4 (copy)
        if u1(p45) == "number" and u1(p46) == "number" then
            local v47 = p44.Timer:Time(p45);
            p44.OutputMulticall:Call("Control", v47, "FlagAllRuns", l__FLAGREASON_STYLECHANGE__4);
            local v48 = l__CreateStyleInfo__34(p46);
            if not v48 then
                u4("CreateStyleInfo returned nil for Style=", p46);
                return;
            end;
            p44.StyleInfo = v48;
            p44.ControlMulticall:Call("Timer", p45, "SetTimescale", v48.timescale);
            p44.ControlMulticall:Call("Aux", p45, "SetStyle", p46);
            p44.OutputMulticall:Call("Control", v47, "SetStyle", p46);
            if not p44.PracticeMode then
                p44.OutputMulticall:Call("Control", v47, "Reset");
            end;
        else
            u4("SetStyle invalid Time=", p45, "Value=", p46);
        end;
    end,
    [l__EVENT_INPUT_PAUSE__15] = function(p49, p50, p51) --[[ Line: 220 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_PAUSE__5 (copy), u4 (copy)
        if u1(p50) == "number" and u1(p51) == "boolean" then
            local l__allow_pause__44 = p49.StyleInfo.allow_pause;
            if l__allow_pause__44 or p49.PracticeMode then
                if not l__allow_pause__44 then
                    p49.OutputMulticall:Call("Control", p49.Timer:Time(p50), "FlagInProgressRuns", l__FLAGREASON_PAUSE__5);
                end;
                p49.ControlMulticall:Call("Timer", p50, "SetPaused", p51);
            end;
        else
            u4("SetPaused invalid Time=", p50, "Value=", p51);
        end;
    end,
    [l__EVENT_INPUT_TIMESCALE__21] = function(p52, p53, p54) --[[ Line: 233 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_TIMESCALE__8 (copy), u4 (copy)
        if u1(p53) == "number" and (u1(p54) == "number" and (p54 >= 0.01 and p54 <= 2)) then
            local l__allow_timescale__45 = p52.StyleInfo.allow_timescale;
            if l__allow_timescale__45 or p52.PracticeMode then
                if not l__allow_timescale__45 then
                    p52.OutputMulticall:Call("Control", p52.Timer:Time(p53), "FlagInProgressRuns", l__FLAGREASON_TIMESCALE__8);
                end;
                p52.ControlMulticall:Call("Timer", p53, "SetTimescale", p54);
            end;
        else
            u4("SetTimescale invalid Time=", p53, "Value=", p54);
        end;
    end,
    [l__EVENT_INPUT_SAVESTATE__22] = function(p55, p56, p57) --[[ Line: 246 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_TIMETRAVEL__9 (copy), u4 (copy)
        if u1(p56) == "number" and u1(p57) == "string" then
            local l__allow_timetravel__46 = p55.StyleInfo.allow_timetravel;
            if l__allow_timetravel__46 or p55.PracticeMode then
                if not l__allow_timetravel__46 then
                    p55.OutputMulticall:Call("Control", p55.Timer:Time(p56), "FlagInProgressRuns", l__FLAGREASON_TIMETRAVEL__9);
                end;
                p55.OutputMulticall:Call("Control", p56, "SaveState", p57);
            end;
        else
            u4("SaveState invalid Time=", p56, "Value=", p57);
        end;
    end,
    [l__EVENT_INPUT_LOADSTATE__23] = function(p58, p59, p60) --[[ Line: 259 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_TIMETRAVEL__9 (copy), u4 (copy)
        if u1(p59) == "number" and u1(p60) == "string" then
            local l__allow_timetravel__47 = p58.StyleInfo.allow_timetravel;
            if l__allow_timetravel__47 or p58.PracticeMode then
                p58.OutputMulticall:Call("Control", p59, "LoadState", p60);
                if not l__allow_timetravel__47 then
                    p58.OutputMulticall:Call("Control", p58.Timer:Time(p59), "FlagInProgressRuns", l__FLAGREASON_TIMETRAVEL__9);
                end;
            end;
        else
            u4("LoadState invalid Time=", p59, "Value=", p60);
        end;
    end,
    [l__EVENT_INPUT_TIME__20] = function(p61, p62, p63) --[[ Line: 272 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_TIMETRAVEL__9 (copy), u4 (copy)
        if u1(p62) == "number" and u1(p63) == "number" then
            local l__allow_timescale__48 = p61.StyleInfo.allow_timescale;
            if l__allow_timescale__48 or p61.PracticeMode then
                if not l__allow_timescale__48 then
                    p61.OutputMulticall:Call("Control", p61.Timer:Time(p62), "FlagInProgressRuns", l__FLAGREASON_TIMETRAVEL__9);
                end;
                p61.ControlMulticall:Call("Timer", p62, "SetTime", p63);
            end;
        else
            u4("SetTime invalid Time=", p62, "Value=", p63);
        end;
    end,
    [l__EVENT_INPUT_AUTORESTART__33] = function(p64, p65, p66) --[[ Line: 300 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p65) == "number" and u1(p66) == "boolean" then
            p64.OutputMulticall:Call("Control", p64.Timer:Time(p65), "SetAutoRestart", p66);
        else
            u4("SetAutoRestart invalid Time=", p65, "Value=", p66);
        end;
    end,
    [l__EVENT_INPUT_WORLDTIMEROFFSET__13] = function(p67, p68, p69) --[[ Line: 307 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p68) == "number" and (u1(p69) == "number" and p69 * p69 < 7464960000) then
            p67.OutputMulticall:Call("Control", p67.Timer:Time(p68), "SetWorldTimerOffset", p69);
        else
            u4("SetWorldTimerOffset invalid Time=", p68, "Value=", p69);
        end;
    end,
    [l__EVENT_INPUT_READY__17] = function(p70, p71, p72) --[[ Line: 314 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p71) == "number" and p72 == false then
            p70.OutputMulticall:Call("Control", p70.Timer:Time(p71), "SetSimulationReady", p72);
        else
            u4("SetSimulationReady invalid Time=", p71, "Value=", p72);
        end;
    end,
    [l__EVENT_INPUT_MAP__14] = function(p73, p74, p75) --[[ Line: 321 ]]
        -- upvalues: u9 (copy), u1 (copy), u4 (copy)
        local l__MapInfo__49 = u9.MapInfo;
        if u1(p74) == "number" and (l__MapInfo__49 and p75 == l__MapInfo__49.MapChangeID) then
            local v76 = p73.Timer:Time(p74);
            p73.OutputMulticall:Call("Control", v76, "LoadMapInfo", l__MapInfo__49);
            p73.OutputMulticall:Call("Control", v76, "PhysTimeTeleport", p73.NextInputN / p73.TickRate);
            p73.OutputMulticall:Call("Control", v76, "MapSpawn0", l__MapInfo__49.MapSpawnId);
        else
            u4("LoadMap invalid Time=", p74, "Client MapChangeID=", p75, "Server MapChangeID=", l__MapInfo__49.MapChangeID);
        end;
    end,
    [l__EVENT_INPUT_RESET__12] = function(p77, p78, p79) --[[ Line: 332 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p78) == "number" and (p79 == nil or u1(p79) == "number") then
            local v80 = p77.Timer:Time(p78);
            p77.OutputMulticall:Call("Control", v80, "Reset", p79);
        else
            u4("Reset invalid Time=", p78, "Value=", p79);
        end;
    end,
    [l__EVENT_INPUT_SPAWN__19] = function(p81, p82, p83) --[[ Line: 340 ]]
        -- upvalues: u1 (copy), u4 (copy), l__FLAGREASON_TELEPORT__10 (copy)
        if u1(p82) == "number" and (p83 == nil or u1(p83) == "number") then
            u4("Spawn setting RunInProgress=false");
            if p81.PracticeMode or false then
                local v84 = p81.Timer:Time(p82);
                if p83 ~= nil then
                    p81.OutputMulticall:Call("Control", v84, "FlagAllRuns", l__FLAGREASON_TELEPORT__10);
                end;
                p81.OutputMulticall:Call("Control", v84, "Spawn", p83);
            end;
        else
            u4("Spawn invalid Time=", p82, "Value=", p83);
        end;
    end,
    [l__EVENT_INPUT_PRACTICEMODE__18] = function(p85, p86, p87) --[[ Line: 356 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p87) == "boolean" then
            p85.PracticeMode = p87;
            if p87 == false then
                local v88 = p85.Timer:Time(p86);
                p85.ControlMulticall:Call("Timer", p86, "SetTimescale", p85.StyleInfo.timescale);
                p85.OutputMulticall:Call("Control", v88, "Reset");
                p85.OutputMulticall:Call("Control", v88, "SetStyle", p85.StyleInfo.id);
            end;
        else
            u4("SetPracticeMode invalid Value=", p87);
        end;
    end,
    [l__EVENT_INPUT_FLYMODE__24] = function(p89, p90, p91) --[[ Line: 369 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_FLYING__6 (copy), u4 (copy)
        if u1(p90) == "number" and u1(p91) == "number" then
            local l__allow_fly__50 = p89.StyleInfo.allow_fly;
            if p89.PracticeMode or l__allow_fly__50 then
                if not l__allow_fly__50 then
                    p89.OutputMulticall:Call("Control", p89.Timer:Time(p90), "FlagInProgressRuns", l__FLAGREASON_FLYING__6);
                end;
                p89.OutputMulticall:Call("Control", p89.Timer:Time(p90), "SetFlyMode", p91);
            end;
        else
            u4("SetFlyMode invalid Time=", p90, "Value=", p91);
        end;
    end,
    [l__EVENT_INPUT_FLYSPEED__25] = function(p92, p93, p94) --[[ Line: 382 ]]
        -- upvalues: u1 (copy), l__FLAGREASON_FLYING__6 (copy), u4 (copy)
        if u1(p93) == "number" and u1(p94) == "number" then
            local l__allow_fly_speed__51 = p92.StyleInfo.allow_fly_speed;
            if p92.PracticeMode or l__allow_fly_speed__51 then
                if not l__allow_fly_speed__51 then
                    p92.OutputMulticall:Call("Control", p92.Timer:Time(p93), "FlagInProgressRuns", l__FLAGREASON_FLYING__6);
                end;
                local v95 = math.clamp(p94, -1000, 1000);
                p92.OutputMulticall:Call("Control", p92.Timer:Time(p93), "SetFlySpeed", v95);
            end;
        else
            u4("SetFlySpeed invalid Time=", p93, "Value=", p94);
        end;
    end,
    [l__EVENT_INPUT_SETSPAWN__26] = function(p96, p97, _) --[[ Line: 396 ]]
        -- upvalues: u1 (copy), u4 (copy)
        if u1(p97) == "number" then
            if p96.PracticeMode then
                u4("SetSpawn ignored in practice mode");
            else
                p96.OutputMulticall:Call("Control", p96.Timer:Time(p97), "SetSpawn");
            end;
        else
            u4("SetSpawn invalid Time=", p97);
        end;
    end
};
v12.InputHandlers = {
    Input = false
};
function v12.HandleInput(p99, p100, p101, p102, ...) --[[ Line: 414 ]]
    -- upvalues: u1 (copy), u98 (copy), u4 (copy)
    if p100 == "Input" and (u1(p101) == "number" and u1(p102) == "number") then
        local v103 = u98[p102];
        if v103 then
            v103(p99, p101, ...);
        else
            u4("HandleInput no such event: ", p102);
        end;
    else
        u4("HandleInput Invalid: Label=", p100, "Time=", p101, "InputEventID=", p102);
    end;
end;
function v12.Constructor(p104, p105) --[[ Line: 427 ]]
    -- upvalues: u8 (copy), l__CreateStyleInfo__34 (copy), u7 (copy)
    p104.TickRate = 100;
    p104.NextInputN = 0;
    p104.Timer = p105;
    p104.OutputMulticall = u8();
    p104.ControlMulticall = u8();
    p104.StyleInfo = l__CreateStyleInfo__34(u7.DefaultStyle);
    p104.States = {};
end;
return v12;
