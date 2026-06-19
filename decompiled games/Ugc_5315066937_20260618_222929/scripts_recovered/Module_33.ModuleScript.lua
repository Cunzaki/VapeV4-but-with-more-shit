-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__obtain__1 = _G.obtain;
local u2 = l__obtain__1("LabelPrint");
local l__RootTimer__2 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local l__Get__3 = l__obtain__1("FakeRoot").Get;
local v3 = l__obtain__1("PlayerManager");
local v4 = l__obtain__1("BotManager");
local v5 = l__obtain__1("Signal");
local u6 = v5();
local u7 = v5();
local u8 = v3.LocalPlayer or "Server";
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = {};
v3.PlayerRemoving:Add(function(p14) --[[ Name: ClearTimers, Line 151 ]]
    -- upvalues: u2 (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy)
    u2("ClearTimers Player=", p14);
    u9[p14] = nil;
    u10[p14] = nil;
    u11[p14] = nil;
    u12[p14] = nil;
end);
v4.BotRemoving:Add(function(p15) --[[ Line: 160 ]]
    -- upvalues: u2 (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy)
    local l__Id__4 = p15.Id;
    u2("ClearTimers Player=", l__Id__4);
    u9[l__Id__4] = nil;
    u10[l__Id__4] = nil;
    u11[l__Id__4] = nil;
    u12[l__Id__4] = nil;
end);
return {
    Init = function() --[[ Name: Init, Line 164 ]]
        -- upvalues: l__RootTimer__2 (copy), u1 (copy), u10 (copy), l__Get__3 (copy), u12 (copy), u11 (copy), u6 (copy)
        game:GetService("RunService").Stepped:connect(function() --[[ Line: 165 ]]
            -- upvalues: l__RootTimer__2 (ref), u1 (ref), u10 (ref), l__Get__3 (ref), u12 (ref), u11 (ref), u6 (ref)
            local v16 = l__RootTimer__2:Time();
            for v17, v18 in u1, u10 do
                if v16 - v18 > 0.15 then
                    l__Get__3(v17):SetScale(l__RootTimer__2:Time(), 1);
                    u10[v17] = nil;
                    u12[v17] = nil;
                    u11[v17] = nil;
                    u6:Call(v17);
                end;
            end;
        end);
    end,
    SubmitSample = function(p19, p20) --[[ Name: SubmitSample, Line 86 ]]
        -- upvalues: l__RootTimer__2 (copy), l__Get__3 (copy), u13 (copy), u2 (copy), u8 (copy), u11 (copy), u9 (copy), u12 (copy), u7 (copy), u10 (copy)
        local v21 = l__RootTimer__2:Time();
        if type(p19) == "number" then
        else
            local v22 = l__Get__3(p19);
            if v22 then
                if u8 ~= "Server" and p19 ~= "Server" then
                    p20 = p20 - 0.2;
                end;
                local v23 = u11[p19];
                if v23 then
                    if u9[p19] then
                        if v21 - v23 > 0.05 then
                            local v24 = p20 - v22:Time();
                            if v24 * v24 < 0.010000000000000002 then
                                v22:SetScale(l__RootTimer__2:Time(), 1 + v24 / 5);
                                u12[p19] = nil;
                            else
                                local v25 = true;
                                local v26 = u12[p19];
                                if v26 then
                                    if v21 - v26 > 5 then
                                        u12[p19] = nil;
                                        local v27 = l__RootTimer__2:Time();
                                        u2("Teleporting Time for Player=", p19, "ServerTime=", v27, "OldTime=", v22:Time(v27), "Time=", p20);
                                        u7:Call(p19, v24);
                                        v22:SetScale(v27, 1);
                                        v22:SetTime(v27, p20);
                                        v25 = false;
                                    end;
                                else
                                    u12[p19] = v21;
                                end;
                                if v25 then
                                    if v24 < 0 then
                                        v22:SetScale(l__RootTimer__2:Time(), 0.98);
                                    else
                                        v22:SetScale(l__RootTimer__2:Time(), 1.02);
                                    end;
                                end;
                            end;
                        end;
                    else
                        u9[p19] = true;
                        v22:SetTime(l__RootTimer__2:Time(), p20);
                    end;
                else
                    u11[p19] = v21;
                end;
                u10[p19] = v21;
            else
                local v28 = u13[p19] or 0;
                if v28 % 1000 == 0 then
                    u2("Discarding sample Player=", p19);
                end;
                u13[p19] = v28 + 1;
            end;
        end;
    end,
    SampleCleared = u6,
    TimeTeleported = u7
};
