-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("Run");
local v2 = l__obtain__1("CustomEnums");
local l__EVENT_RUN_PREPARE__2 = v2.EVENT_RUN_PREPARE;
local l__EVENT_RUN_START__3 = v2.EVENT_RUN_START;
local l__EVENT_RUN_FINISH__4 = v2.EVENT_RUN_FINISH;
local l__EVENT_RUN_CLEAR__5 = v2.EVENT_RUN_CLEAR;
local l__EVENT_RUN_FLAG__6 = v2.EVENT_RUN_FLAG;
local v3 = l__obtain__1("ContextManager");
local l__GetContext__7 = v3.GetContext;
local l__GetContextData__8 = v3.GetContextData;
local v4 = l__obtain__1("VisibilityManager");
local l__GetHiding__9 = v4.GetHiding;
local l__SetHiding__10 = v4.SetHiding;
local l__RootTimer__11 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local function u14() --[[ Line: 27 ]]
    -- upvalues: l__GetContext__7 (copy), u5 (ref), l__GetContextData__8 (copy), l__EVENT_RUN_PREPARE__2 (copy), u1 (copy), l__EVENT_RUN_START__3 (copy), l__EVENT_RUN_FINISH__4 (copy), l__EVENT_RUN_CLEAR__5 (copy), l__EVENT_RUN_FLAG__6 (copy), u7 (ref)
    local v8 = l__GetContext__7(u5);
    local v9 = l__GetContextData__8(u5, "Mode");
    local l__Events__12 = v8.Context.Timelines.Run.Events;
    local v10 = nil;
    for v11 = 1, #l__Events__12 do
        local v12 = l__Events__12[v11];
        if v12[3] == v9 then
            local v13 = v12[2];
            if v13 == l__EVENT_RUN_PREPARE__2 then
                v10 = u1(v12[1], nil);
            elseif v10 then
                if v13 == l__EVENT_RUN_START__3 then
                    v10:Start(v12[1]);
                elseif v13 == l__EVENT_RUN_FINISH__4 then
                    if v10:Finish(v12[1]) then
                        if v10.Valid then
                            break;
                        end;
                    end;
                elseif v13 == l__EVENT_RUN_CLEAR__5 then
                    v10:Clear(v12[1]);
                    v10 = nil;
                elseif v13 == l__EVENT_RUN_FLAG__6 then
                    v10:Flag(v12[1]);
                end;
            end;
        end;
    end;
    if v10 then
        u7 = v10.Started;
    end;
end;
local function u17(p15) --[[ Line: 65 ]]
    -- upvalues: u7 (ref), u14 (copy), l__GetContext__7 (copy), u5 (ref), l__RootTimer__11 (copy)
    if not u7 then
        u14();
    end;
    local v16 = (u7 or p15) and l__GetContext__7(u5);
    if v16 then
        v16.PlaybackControl:Call("Timer", l__RootTimer__11:Time(), "SetPaused", true);
        v16.PlaybackControl:Call("Timer", l__RootTimer__11:Time(), "SetTime", u7 or p15);
    end;
end;
return {
    GetRaceBot = function() --[[ Name: GetRaceBot, Line 61 ]]
        -- upvalues: u5 (ref)
        return u5;
    end,
    SetRaceBot = function(p18) --[[ Name: SetRaceBot, Line 98 ]]
        -- upvalues: u5 (ref), l__GetContext__7 (copy), u7 (ref), u14 (copy), l__RootTimer__11 (copy), l__SetHiding__10 (copy), u6 (ref), l__GetHiding__9 (copy), u17 (copy)
        if u5 then
            local v19 = l__GetContext__7(u5);
            if v19 then
                if not u7 then
                    u14();
                end;
                v19.PlaybackControl:Call("Timer", l__RootTimer__11:Time(), "SetPaused", false);
            end;
            l__SetHiding__10(u5, "User", u6);
        end;
        u5 = nil;
        u7 = nil;
        u6 = nil;
        u5 = p18;
        u6 = l__GetHiding__9(u5);
        l__SetHiding__10(u5, "User", false);
        u17(u5.TEMP_BEGINTIME);
    end,
    StartRaceBot = function() --[[ Name: StartRaceBot, Line 78 ]]
        -- upvalues: l__GetContext__7 (copy), u5 (ref), u7 (ref), u14 (copy), l__RootTimer__11 (copy)
        local v20 = l__GetContext__7(u5);
        if v20 then
            if not u7 then
                u14();
            end;
            v20.PlaybackControl:Call("Timer", l__RootTimer__11:Time(), "SetPaused", false);
        end;
    end,
    PrepareRaceBot = u17,
    ClearRaceBot = function() --[[ Name: ClearRaceBot, Line 88 ]]
        -- upvalues: u5 (ref), l__GetContext__7 (copy), u7 (ref), u14 (copy), l__RootTimer__11 (copy), l__SetHiding__10 (copy), u6 (ref)
        if u5 then
            local v21 = l__GetContext__7(u5);
            if v21 then
                if not u7 then
                    u14();
                end;
                v21.PlaybackControl:Call("Timer", l__RootTimer__11:Time(), "SetPaused", false);
            end;
            l__SetHiding__10(u5, "User", u6);
        end;
        u5 = nil;
        u7 = nil;
        u6 = nil;
    end
};
