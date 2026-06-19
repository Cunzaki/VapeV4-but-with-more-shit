-- Decompiled from: BotDiff
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__sqrt__1 = math.sqrt;
local l__format__2 = string.format;
local l__obtain__3 = _G.obtain;
local u1 = l__obtain__3("LabelPrint");
local v2 = l__obtain__3("QBox");
local l__Color__4 = v2.Color;
local u3 = l__obtain__3("View");
local l__SetHiding__5 = l__obtain__3("VisibilityManager").SetHiding;
local v4 = l__obtain__3("Command");
local u5 = l__obtain__3("Trackers");
local v6 = l__obtain__3("ContextManager");
local l__GetContext__6 = v6.GetContext;
local l__GetContextData__7 = v6.GetContextData;
local v7 = l__obtain__3("BotManager");
local l__Bots__8 = v7.Bots;
local v8 = l__obtain__3("MapManager");
local l__GetNewestRun__9 = l__obtain__3("RunManager").GetNewestRun;
local l__GetRaceBot__10 = l__obtain__3("Race").GetRaceBot;
local l__Dot__11 = Vector3.zero.Dot;
local u9 = l__Color__4(0, 255, 0);
local u10 = l__Color__4(255, 0, 0);
local u11 = l__Color__4(128, 128, 128);
local u12 = v2.New();
u12.PosScaleX = 1;
u12.PosScaleY = 0.5;
u12.SizeOffsetX = 250;
u12.SizeOffsetY = 60;
u12.PosOffsetX = -u12.SizeX;
u12.DrawBackground = false;
u12.Visible = false;
local v13 = v2.TextBox(u12, "Diff");
v13.TextColor = u11;
v13.SizeScaleX = 1;
v13.SizeOffsetY = 20;
v13.DrawBackground = false;
local u14 = v2.TextBox(u12, "Time: +0");
u14.TextColor = l__Color__4(255, 0, 0);
u14.PosOffsetY = 20;
u14.SizeScaleX = 1;
u14.SizeOffsetY = 20;
u14.DrawBackground = false;
local u15 = v2.TextBox(u12, "Velocity: +0");
u15.TextColor = l__Color__4(255, 0, 0);
u15.PosOffsetY = 40;
u15.SizeScaleX = 1;
u15.SizeOffsetY = 20;
u15.DrawBackground = false;
v2.DragBar(v13, u12);
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local function u27() --[[ Line: 99 ]]
    -- upvalues: u12 (copy), u3 (copy), l__GetNewestRun__9 (copy), u1 (copy), l__GetRaceBot__10 (copy), l__Bots__8 (copy), l__GetContextData__7 (copy), u18 (ref), l__SetHiding__5 (copy), u20 (ref), u16 (ref), u17 (ref), u19 (ref), l__GetContext__6 (copy), u5 (copy)
    if u12.Visible then
        local v21 = u3.PlaybackContext.Cache:GetKey("Style");
        local v22 = l__GetNewestRun__9(u3.PlaybackContext.Runs);
        if not v22 then
            u1("No newest run");
            return;
        end;
        local v23 = l__GetRaceBot__10();
        if not v23 then
            for v24 = 1, #l__Bots__8 do
                local v25 = l__Bots__8[v24];
                if l__GetContextData__7(v25, "Style") == v21 and l__GetContextData__7(v25, "Mode") == v22.Mode then
                    v23 = v25;
                    break;
                end;
            end;
        end;
        if v23 and v23 ~= u18 then
            if u18 then
                l__SetHiding__5(u18, "BotDiff", false);
            end;
            l__SetHiding__5(v23, "BotDiff", false, true);
            if u20 then
                u20:Remove();
            end;
            u16 = nil;
            u17 = nil;
            u19 = nil;
            u20 = nil;
            u18 = nil;
            local v26 = l__GetContext__6(v23);
            if not v26 then
                u1("No BotContext");
                return;
            end;
            local l__Context__12 = v26.Context;
            if not l__Context__12 then
                u1("No OfflineContext");
                return;
            end;
            local l__Timelines__13 = l__Context__12.Timelines;
            if not l__Timelines__13 then
                u1("No Timelines");
                return;
            end;
            local l__Output__14 = l__Timelines__13.Output;
            if not l__Output__14 then
                u1("No OutputTimeline");
                return;
            end;
            u19 = l__Output__14.Events;
            u20 = u5(l__Output__14);
            u17 = v21;
            u16 = v22.Mode;
            u18 = v23;
        end;
    end;
end;
local function u62() --[[ Line: 167 ]]
    -- upvalues: u3 (copy), l__GetNewestRun__9 (copy), u18 (ref), u17 (ref), u16 (ref), l__GetRaceBot__10 (copy), u27 (copy), l__GetContext__6 (copy), u20 (ref), u19 (ref), l__Dot__11 (copy), l__format__2 (copy), u14 (copy), u9 (copy), u10 (copy), u11 (copy), l__sqrt__1 (copy), u15 (copy)
    local l__PlaybackContext__15 = u3.PlaybackContext;
    local v28 = l__GetNewestRun__9(l__PlaybackContext__15.Runs);
    if not (l__PlaybackContext__15 and v28) then
        return;
    end;
    if not u18 or (l__PlaybackContext__15.Cache:GetKey("Style") ~= u17 or (v28.Mode ~= u16 or l__GetRaceBot__10() and l__GetRaceBot__10() ~= u18)) then
        u27();
    end;
    if u18 then
        local v29, v30 = l__PlaybackContext__15.Context:GetPV();
        if not v29 then
            return;
        end;
        local v31 = v29 + l__PlaybackContext__15.MapOffset;
        local v32 = l__GetContext__6(u18);
        if not v32 then
            return;
        end;
        local l__MapOffset__16 = v32.MapOffset;
        local v33 = nil;
        local l__Index__17 = u20.Index;
        local v34 = u20:After();
        local v35 = not v34 and (1 / 0) or (v34[4] + l__MapOffset__16 - v31).magnitude;
        local v36 = u19[1];
        local v37;
        if v36 then
            v37 = (v36[4] + l__MapOffset__16 - v31).magnitude;
            if v37 < v35 then
                v33 = 1;
            else
                v37 = v35;
            end;
        else
            v37 = v35;
        end;
        for v38 = 0, 32 do
            local v39 = l__Index__17 - 2 ^ v38;
            local v40 = u19[v39];
            if not v40 then
                break;
            end;
            local l__magnitude__18 = (v40[4] + l__MapOffset__16 - v31).magnitude;
            if l__magnitude__18 <= v37 then
                v33 = v39;
                v37 = l__magnitude__18;
            end;
        end;
        for v41 = 0, 32 do
            local v42 = l__Index__17 + 2 ^ v41;
            local v43 = u19[v42];
            if not v43 then
                break;
            end;
            local l__magnitude__19 = (v43[4] + l__MapOffset__16 - v31).magnitude;
            if l__magnitude__19 < v37 then
                v33 = v42;
                v37 = l__magnitude__19;
            end;
        end;
        if v33 then
            u20:SetIndex(v33);
            v34 = u20:After();
        end;
        if v34 then
            local v44 = v34[4] + l__MapOffset__16;
            local v45 = v34[5];
            local v46 = u16;
            local v47 = l__GetContext__6(u18);
            local v48 = v47 and v47.Runs[v46];
            local v49;
            if v48 then
                v49 = v48.Timer;
            else
                v49 = nil;
            end;
            local v50 = u16;
            local v51 = l__GetContext__6(u3.Player);
            local v52 = v51 and v51.Runs[v50];
            local v53;
            if v52 then
                v53 = v52.Timer;
            else
                v53 = nil;
            end;
            if v49 and v53 then
                local v54 = v49:Time(v34[1]);
                if v49.Scale ~= 0 then
                    local v55 = l__Dot__11(v45, v45);
                    if v55 > 0.01 then
                        v54 = v54 + v49.Scale * l__Dot__11(v31 - v44, v45) / v55;
                    end;
                end;
                local v56 = v53:Time() - v54;
                local v57 = l__format__2("%0.3f", v56);
                local v58 = u14;
                if v56 > 0 then
                    v57 = "+" .. v57 or v57;
                end;
                v58.Text = v57;
                u14.TextColor = v56 < 0 and u9 or (v56 > 0 and u10 or u11);
                local l__x__20 = v30.x;
                local l__z__21 = v30.z;
                local l__x__22 = v45.x;
                local l__z__23 = v45.z;
                local v59 = l__sqrt__1(l__x__20 * l__x__20 + l__z__21 * l__z__21) - l__sqrt__1(l__x__22 * l__x__22 + l__z__23 * l__z__23);
                local v60 = l__format__2("%0.2f", v59);
                local v61 = u15;
                if v59 > 0 then
                    v60 = "+" .. v60 or v60;
                end;
                v61.Text = v60;
                u15.TextColor = v59 < 0 and u10 or (v59 > 0 and u9 or u11);
            end;
        end;
    end;
end;
v8.MapInfoChanged:Add(function() --[[ Name: ClearBot, Line 88 ]]
    -- upvalues: u20 (ref), u16 (ref), u17 (ref), u19 (ref), u18 (ref)
    if u20 then
        u20:Remove();
    end;
    u16 = nil;
    u17 = nil;
    u19 = nil;
    u20 = nil;
    u18 = nil;
end);
u3.PlayerChanged:Add(function() --[[ Line: 269 ]]
    -- upvalues: u20 (ref), u16 (ref), u17 (ref), u19 (ref), u18 (ref), u27 (copy)
    if u20 then
        u20:Remove();
    end;
    u16 = nil;
    u17 = nil;
    u19 = nil;
    u20 = nil;
    u18 = nil;
    u27();
end);
v7.BotRemoving:Add(function(p63) --[[ Line: 274 ]]
    -- upvalues: u18 (ref), u20 (ref), u16 (ref), u17 (ref), u19 (ref)
    if p63 == u18 then
        if u20 then
            u20:Remove();
        end;
        u16 = nil;
        u17 = nil;
        u19 = nil;
        u20 = nil;
        u18 = nil;
    end;
end);
v4.Add("diff", {}, function() --[[ Line: 288 ]]
    -- upvalues: u12 (copy), u62 (copy), u27 (copy)
    u12.Visible = not u12.Visible;
    if u12.Visible then
        u12.Think = u62;
        u27();
    else
        u12.Think = nil;
    end;
end);
v4.Add("diff", { "Boolean" }, function(p64) --[[ Line: 296 ]]
    -- upvalues: u12 (copy), u62 (copy), u27 (copy)
    u12.Visible = p64;
    if p64 then
        u12.Think = u62;
        u27();
    else
        u12.Think = nil;
    end;
end);
return true;
