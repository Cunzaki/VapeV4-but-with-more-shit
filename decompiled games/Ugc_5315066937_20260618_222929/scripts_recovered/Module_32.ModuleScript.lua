-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local v2 = l__obtain__1("Signal");
local l__GameID__2 = l__obtain__1("Game").GameID;
local v3 = l__obtain__1("CustomEnums");
local l__MODE_ALL__3 = v3.MODE_ALL;
local l__MODE_INVALID__4 = v3.MODE_INVALID;
local l__MODE_INPROGRESS__5 = v3.MODE_INPROGRESS;
local u4 = l__obtain__1("MapManager");
local u5 = l__obtain__1("Run");
l__obtain__1("Timers");
local u6 = {
    [v3.FLAGREASON_ANTICHEAT] = "Passed through anticheat zone",
    [v3.FLAGREASON_STYLECHANGE] = "Changed style.",
    [v3.FLAGREASON_CLOCK] = "Incorrect clock.  (This can be caused by internet hiccups)",
    [v3.FLAGREASON_PAUSE] = "Pausing is not allowed in this style.",
    [v3.FLAGREASON_FLYING] = "Flying is not allowed in this style.",
    [v3.FLAGREASON_GRAVITY] = "Gravity modification is not allowed in this style.",
    [v3.FLAGREASON_TIMESCALE] = "Timescale is not allowed in this style.",
    [v3.FLAGREASON_TIMETRAVEL] = "Time travel is not allowed in this style.",
    [v3.FLAGREASON_TELEPORT] = "Illegal teleport.",
    [v3.FLAGREASON_PRACTICE] = "Practice mode triggers invalidation."
};
local u7 = v2();
local function v12(p8, p9, p10) --[[ Line: 51 ]]
    -- upvalues: u7 (copy)
    local l__Runs__6 = p8.Runs;
    local v11 = l__Runs__6 and l__Runs__6[p10];
    if v11 then
        l__Runs__6[p10] = nil;
        v11:Clear(p9);
        u7:Call(v11, p9);
    end;
end;
local u13 = v2();
local u14 = v2();
local u15 = v2();
local function v22(p16, p17, p18, p19) --[[ Line: 101 ]]
    -- upvalues: u7 (copy), u4 (copy), u5 (copy), l__GameID__2 (copy), u15 (copy)
    local l__Runs__7 = p16.Runs;
    local v20 = l__Runs__7 and l__Runs__7[p18];
    if v20 then
        l__Runs__7[p18] = nil;
        v20:Clear(p17);
        u7:Call(v20, p17);
    end;
    local l__MapInfo__8 = u4.MapInfo;
    if l__MapInfo__8 then
        local l__Player__9 = p16.Player;
        local l__Runs__10 = p16.Runs;
        local v21 = u5(p17, p16.Timer);
        v21.PlayerContext = p16;
        v21.Player = l__Player__9;
        v21.Map = l__MapInfo__8.Id;
        v21.Mode = p18;
        v21.Style = p19;
        v21.Game = l__GameID__2;
        assert(v21.Style ~= nil, "RunStart Run.Style==nil");
        l__Runs__10[p18] = v21;
        u15:Call(v21, p17);
    end;
end;
local u23 = v2();
local function v28(p24, p25, p26) --[[ Line: 123 ]]
    -- upvalues: u23 (copy)
    local l__Runs__11 = p24.Runs;
    if l__Runs__11 then
        local v27 = l__Runs__11[p26];
        if v27 and v27:Start(p25) then
            u23:Call(v27, p25);
        end;
    end;
end;
local u29 = v2();
local function v34(p30, p31, p32) --[[ Line: 135 ]]
    -- upvalues: u29 (copy)
    local l__Runs__12 = p30.Runs;
    if l__Runs__12 then
        local v33 = l__Runs__12[p32];
        if v33 and v33:Finish(p31) then
            u29:Call(v33, p31);
        end;
    end;
end;
local u35 = v2();
local function v41(p36, p37, p38, p39) --[[ Line: 149 ]]
    -- upvalues: u35 (copy), u6 (copy)
    local l__Runs__13 = p36.Runs;
    local v40 = l__Runs__13 and l__Runs__13[p38];
    if v40 then
        v40:Flag(p37, p39);
        u35:Call(v40, p37, u6[p39]);
    end;
end;
local u54 = {
    [v3.EVENT_RUN_PREPARE] = v22,
    [v3.EVENT_RUN_START] = v28,
    [v3.EVENT_RUN_FINISH] = v34,
    [v3.EVENT_RUN_CLEAR] = v12,
    [v3.EVENT_RUN_LOADSTATE] = function(p42, p43, p44, p45) --[[ Name: RunLoadState, Line 65 ]]
        -- upvalues: u13 (copy), u1 (copy)
        local l__Runs__14 = p42.Runs;
        local v46 = l__Runs__14 and l__Runs__14[p44];
        if v46 then
            local l__Timer__15 = v46.Timer;
            local v47 = v46.States[p45];
            if v47 then
                v46:SetState(v47);
                v46.ForceSupressReset = true;
                l__Timer__15.Offset = l__Timer__15.Offset - (l__Timer__15:Time(p43) - v47.StateTime);
                u13:Call(v46, p43);
                return;
            end;
            u1("RunState StateName=", p45, "does not exist");
        end;
    end,
    [v3.EVENT_RUN_SAVESTATE] = function(p48, p49, p50, p51) --[[ Name: RunSaveState, Line 86 ]]
        -- upvalues: u14 (copy)
        local l__Runs__16 = p48.Runs;
        local v52 = l__Runs__16 and l__Runs__16[p50];
        if v52 then
            local v53 = v52:GetState();
            v53.StateTime = v52.Timer:Time(p49);
            v52.States[p51] = v53;
            u14:Call(v52, p49);
        end;
    end,
    [v3.EVENT_RUN_FLAG] = v41
};
return {
    GetNewestRun = function(p55) --[[ Name: GetNewestRun, Line 37 ]]
        local v56 = (-1 / 0);
        local v57 = nil;
        for _, v58 in p55 do
            if v56 < v58.Created then
                v56 = v58.Created;
                v57 = v58;
            end;
        end;
        return v57;
    end,
    EventHandler = function(p59, p60, p61, p62, ...) --[[ Name: RunHandler, Line 172 ]]
        -- upvalues: u54 (copy), l__MODE_ALL__3 (copy), l__MODE_INVALID__4 (copy), l__MODE_INPROGRESS__5 (copy), u1 (copy)
        local v63 = u54[p61];
        if v63 then
            if p62 == l__MODE_ALL__3 then
                local l__Runs__17 = p59.Runs;
                if l__Runs__17 then
                    for v64 in l__Runs__17 do
                        v63(p59, p60, v64, ...);
                    end;
                end;
            elseif p62 == l__MODE_INVALID__4 then
                local l__Runs__18 = p59.Runs;
                if l__Runs__18 then
                    for v65, v66 in l__Runs__18 do
                        if not v66.Valid then
                            v63(p59, p60, v65, ...);
                        end;
                    end;
                end;
            else
                if p62 ~= l__MODE_INPROGRESS__5 then
                    v63(p59, p60, p62, ...);
                    return;
                end;
                local l__Runs__19 = p59.Runs;
                if l__Runs__19 then
                    for v67, v68 in l__Runs__19 do
                        if v68.InProgress then
                            v63(p59, p60, v67, ...);
                        end;
                    end;
                end;
            end;
        else
            u1("Event ID=", p61, "does not exist");
        end;
    end,
    RawRunStart = v28,
    RunStart = u23,
    RawRunPrepare = v22,
    RunPrepare = u15,
    RawRunFinish = v34,
    RunFinish = u29,
    RawRunClear = v12,
    RunClear = u7,
    RawRunFlag = v41,
    RunFlag = u35
};
