-- Decompiled from: VisibilityControl
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__Add__2 = l__obtain__1("Command").Add;
local l__GetBotFromId__3 = l__obtain__1("BotManager").GetBotFromId;
local l__Global__4 = l__obtain__1("PersistentData").Global;
local v1 = l__obtain__1("VisibilityManager");
local l__SetHiding__5 = v1.SetHiding;
local l__SetHidingAll__6 = v1.SetHidingAll;
local l__SetHideDistance__7 = v1.SetHideDistance;
local l__GetHideDistance__8 = v1.GetHideDistance;
local l__PlayersVisible__9 = v1.PlayersVisible;
l__Global__4:MonitorKey("HideDistance", function(p2) --[[ Line: 19 ]]
    -- upvalues: l__PlayersVisible__9 (copy), l__SetHidingAll__6 (copy), l__SetHideDistance__7 (copy)
    if p2 and not l__PlayersVisible__9() then
        l__SetHidingAll__6(false);
    end;
    l__SetHideDistance__7(p2);
end);
l__Global__4:MonitorKey("SpeedCoeff", v1.SetSpeedCoeff);
l__Global__4:MonitorKey("PlayersVisible", function(p3) --[[ Line: 26 ]]
    -- upvalues: l__GetHideDistance__8 (copy), l__SetHidingAll__6 (copy)
    if p3 then
        if not l__GetHideDistance__8() then
            l__SetHidingAll__6(false);
        end;
    else
        l__SetHidingAll__6(true);
    end;
end);
l__Add__2("hide", { "Player" }, function(p4) --[[ Line: 36 ]]
    -- upvalues: l__SetHiding__5 (copy)
    l__SetHiding__5(p4, "User", true);
end);
l__Add__2("show", { "Player" }, function(p5) --[[ Line: 39 ]]
    -- upvalues: l__SetHiding__5 (copy)
    l__SetHiding__5(p5, "User", false);
end);
l__Add__2("hide", { "BotId" }, function(p6) --[[ Line: 42 ]]
    -- upvalues: l__GetBotFromId__3 (copy), l__SetHiding__5 (copy)
    local v7 = l__GetBotFromId__3(p6);
    if v7 then
        l__SetHiding__5(v7, "User", true);
    end;
end);
l__Add__2("show", { "BotId" }, function(p8) --[[ Line: 48 ]]
    -- upvalues: l__GetBotFromId__3 (copy), l__SetHiding__5 (copy)
    local v9 = l__GetBotFromId__3(p8);
    if v9 then
        l__SetHiding__5(v9, "User", false);
    end;
end);
return true;
