-- Decompiled from: RaceControls
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("View");
local v2 = l__obtain__1("Race");
local l__GetRaceBot__2 = v2.GetRaceBot;
local l__SetRaceBot__3 = v2.SetRaceBot;
local l__PrepareRaceBot__4 = v2.PrepareRaceBot;
local l__StartRaceBot__5 = v2.StartRaceBot;
local l__ClearRaceBot__6 = v2.ClearRaceBot;
local l__GetContextData__7 = l__obtain__1("ContextManager").GetContextData;
local v3 = l__obtain__1("BotManager");
local l__GetBotFromId__8 = v3.GetBotFromId;
local v4 = l__obtain__1("RunManager");
local v5 = l__obtain__1("Command");
v5.Add("race", {}, function() --[[ Line: 22 ]]
    -- upvalues: l__ClearRaceBot__6 (copy)
    l__ClearRaceBot__6();
    return "You have disabled the race bot.";
end);
v5.Add("race", { "BotId" }, function(p6) --[[ Line: 26 ]]
    -- upvalues: l__GetBotFromId__8 (copy), l__SetRaceBot__3 (copy)
    local v7 = l__GetBotFromId__8(p6);
    if v7 then
        l__SetRaceBot__3(v7);
        return "You are now racing \'" .. v7.Name .. "\'.  The bot will leave the start zone at the same time as you.";
    end;
end);
v3.BotRemoving:Add(function(p8) --[[ Line: 34 ]]
    -- upvalues: l__GetRaceBot__2 (copy), l__ClearRaceBot__6 (copy)
    if l__GetRaceBot__2() == p8 then
        l__ClearRaceBot__6();
    end;
end);
v4.RunPrepare:Add(function(p9, _) --[[ Line: 40 ]]
    -- upvalues: u1 (copy), l__GetRaceBot__2 (copy), l__GetContextData__7 (copy), l__PrepareRaceBot__4 (copy)
    if p9.Player == u1.Player then
        local v10 = l__GetRaceBot__2();
        if v10 and p9.Mode == l__GetContextData__7(v10, "Mode") then
            l__PrepareRaceBot__4();
        end;
    end;
end);
v4.RunStart:Add(function(p11, _) --[[ Line: 48 ]]
    -- upvalues: u1 (copy), l__GetRaceBot__2 (copy), l__GetContextData__7 (copy), l__StartRaceBot__5 (copy)
    if p11.Player == u1.Player then
        local v12 = l__GetRaceBot__2();
        if v12 and p11.Mode == l__GetContextData__7(v12, "Mode") then
            l__StartRaceBot__5();
        end;
    end;
end);
return true;
