-- Decompiled from: Playerlist
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local _ = next;
local u1 = type;
local l__max__1 = math.max;
local l__min__2 = math.min;
local l__floor__3 = math.floor;
local _ = string.rep;
local l__remove__4 = table.remove;
local l__obtain__5 = _G.obtain;
local u2 = l__obtain__5("LabelPrint");
local u3 = l__obtain__5("GetFormattedTime");
local u4 = l__obtain__5("ImplIntoInt64");
local v5 = l__obtain__5("ContextManager");
local l__GetContext__6 = v5.GetContext;
local l__GetContextData__7 = v5.GetContextData;
local u6 = l__obtain__5("QBox");
local l__Color__8 = u6.Color;
local l__New__9 = u6.New;
local l__TextBox__10 = u6.TextBox;
local l__Avatar__11 = u6.Avatar;
local l__FreeMouse__12 = u6.FreeMouse;
local v7 = l__obtain__5("Tween");
local l__New__13 = v7.New;
local l__MaxAcceleration__14 = v7.MaxAcceleration;
local l__Call__15 = l__obtain__5("Local").Call;
local l__Call__16 = l__obtain__5("Remote").Call;
local l__GetStyleName__17 = l__obtain__5("Styles").GetStyleName;
local l__MODE_MAIN__18 = l__obtain__5("CustomEnums").MODE_MAIN;
local u8 = l__obtain__5("GetRankName");
local v9 = l__obtain__5("PlayerManager");
local l__LocalPlayer__19 = v9.LocalPlayer;
local l__PlayersService__20 = v9.PlayersService;
local l__GetPlayerByUserId__21 = l__PlayersService__20.GetPlayerByUserId;
local v10 = l__obtain__5("MuteManager");
local l__GetGlobalMuted__22 = v10.GetGlobalMuted;
local l__GetPersonalMuted__23 = v10.GetPersonalMuted;
local l__ShowChatModerationSignal__24 = v10.ShowChatModerationSignal;
local v11 = l__obtain__5("BotManager");
local l__GetBotFromId__25 = v11.GetBotFromId;
local l__SetPlayer__26 = l__obtain__5("Spectate").SetPlayer;
local l__SetRaceBot__27 = l__obtain__5("Race").SetRaceBot;
local v12 = l__obtain__5("Moderation");
local l__ApprovalStatus__28 = v12.ApprovalStatus;
local l__Gui__29 = l__obtain__5("InputBinds").Gui;
local l__GetNewestRun__30 = l__obtain__5("RunManager").GetNewestRun;
local u13 = l__obtain__5("GetNameColour");
local u14 = false;
local u15 = false;
local u16 = {};
local u17 = {};
local function u19(p18) --[[ Line: 88 ]]
    return p18 < 35 and "F-" or (p18 < 42 and "F" or (p18 < 50 and "F+" or (p18 < 53 and "D-" or (p18 < 57 and "D" or (p18 < 60 and "D+" or (p18 < 63 and "C-" or (p18 < 67 and "C" or (p18 < 70 and "C+" or (p18 < 73 and "B-" or (p18 < 77 and "B" or (p18 < 80 and "B+" or (p18 < 85 and "A-" or (p18 < 90 and "A" or (p18 < 100 and "A+" or "A++"))))))))))))));
end;
local u20 = false;
local u21 = true;
l__Gui__29:RegisterBindable("ExpandPlayerList", function(p22) --[[ Line: 95 ]]
    -- upvalues: u20 (ref)
    u20 = p22;
end, "Tab");
local l__LocalPlayer__31 = v9.LocalPlayer;
local u23 = {};
local u24 = {};
local u25 = l__New__9();
u25.DrawBackground = false;
u25.PosScaleX = 1;
u25.PosOffsetY = 5;
u25.SizeOffsetY = 30;
local u26 = l__TextBox__10(u25, "Player List");
u26.TextAlignment = "Center";
u26.SizeScaleX = 1;
u26.SizeOffsetX = 0;
u26.SizeOffsetY = 30;
function u26.Fade(p27) --[[ Line: 119 ]]
    -- upvalues: u26 (copy), u6 (copy), l__Color__8 (copy)
    local v28 = u26;
    local l__Color1__32 = u6.Color1;
    local l__Color2__33 = u6.Color2;
    local v29 = 1 - p27;
    v28.BackgroundColor = l__Color__8(l__Color1__32.r * v29 + l__Color2__33.r * p27, l__Color1__32.g * v29 + l__Color2__33.g * p27, l__Color1__32.b * v29 + l__Color2__33.b * p27, l__Color1__32.a * v29 + l__Color2__33.a * p27);
end;
local u31 = l__New__13(u26.TextSizeX + 10 - u26.SizeOffsetX, function(p30) --[[ Line: 125 ]]
    -- upvalues: u25 (copy)
    u25.SizeOffsetX = p30;
    u25.PosOffsetX = -5 - p30;
end);
u31.MaxAcceleration = l__MaxAcceleration__14(0, 100, 0, 0, 0.2);
local u32 = l__New__9(u25);
u32.DrawBackground = false;
u32.SizeScaleX = 1;
u32.SizeScaleY = 1;
u32.PosOffsetY = 30;
function u26.Button1Down() --[[ Line: 137 ]]
    -- upvalues: u21 (ref), u20 (ref), u32 (copy)
    u21 = not u21;
    if not u20 then
        u32.Visible = u21;
    end;
end;
local u33 = {
    "Name",
    "Personal Best",
    "Style",
    "Spectating",
    "Rank",
    "Skill",
    "Ping"
};
local u46 = {
    function(p34) --[[ Line: 180 ]]
        -- upvalues: l__GetPersonalMuted__23 (copy), l__GetGlobalMuted__22 (copy)
        return (l__GetPersonalMuted__23(p34) and "🔇" or "") .. (l__GetGlobalMuted__22(p34) and "🙊" or "") .. p34.Name;
    end,
    function(_) --[[ Line: 183 ]]
        return "Dead code";
    end,
    function(p35) --[[ Line: 186 ]]
        -- upvalues: l__GetStyleName__17 (copy), l__GetContextData__7 (copy)
        return l__GetStyleName__17(l__GetContextData__7(p35, "Style")) or "None";
    end,
    function(p36) --[[ Line: 189 ]]
        -- upvalues: l__GetContextData__7 (copy), u4 (copy), l__GetBotFromId__25 (copy)
        local v37 = l__GetContextData__7(p36, "Spectating");
        if not v37 then
            return "-";
        end;
        if not u4(v37) then
            return v37.Name;
        end;
        local v38 = l__GetBotFromId__25(v37);
        return not v38 and "Private Bot" or v38.Name;
    end,
    function(p39) --[[ Line: 205 ]]
        -- upvalues: l__GetContext__6 (copy), l__MODE_MAIN__18 (copy), l__GetContextData__7 (copy), u8 (copy)
        local v40 = l__GetContext__6(p39);
        local v41 = v40 and v40:GetIndex("Ranks", l__MODE_MAIN__18, l__GetContextData__7(p39, "Style"));
        return not v41 and "-" or u8(v41, true);
    end,
    function(p42) --[[ Line: 215 ]]
        -- upvalues: l__GetContext__6 (copy), l__MODE_MAIN__18 (copy), l__GetContextData__7 (copy), u19 (copy), l__floor__3 (copy)
        local v43 = l__GetContext__6(p42);
        local v44 = v43 and v43:GetIndex("Skills", l__MODE_MAIN__18, l__GetContextData__7(p42, "Style"));
        return not v44 and "-" or u19(100 * v44) .. " (" .. l__floor__3(1000 * v44) / 10 .. "%)";
    end,
    function(p45) --[[ Line: 225 ]]
        -- upvalues: l__GetContextData__7 (copy)
        return l__GetContextData__7(p45, "Ping");
    end
};
local function u49(p47) --[[ Line: 230 ]]
    -- upvalues: u1 (copy)
    local v48;
    if u1(p47) == "table" then
        v48 = p47.Id;
    else
        v48 = false;
    end;
    return v48;
end;
local u68 = {
    function(p50) --[[ Line: 235 ]]
        -- upvalues: l__LocalPlayer__31 (copy), l__GetContextData__7 (copy)
        if p50 ~= l__LocalPlayer__31 and not l__GetContextData__7(p50, "Spectating") then
            return "Spectate";
        end;
    end,
    function(p51) --[[ Line: 240 ]]
        -- upvalues: l__LocalPlayer__31 (copy), u1 (copy), l__GetPersonalMuted__23 (copy)
        if p51 ~= l__LocalPlayer__31 then
            local v52;
            if u1(p51) == "table" then
                v52 = p51.Id;
            else
                v52 = false;
            end;
            if not v52 then
                return l__GetPersonalMuted__23(p51) and "Unmute" or "Mute";
            end;
        end;
    end,
    function(p53) --[[ Line: 245 ]]
        -- upvalues: u15 (ref), u1 (copy), l__GetGlobalMuted__22 (copy)
        if u15 then
            local v54;
            if u1(p53) == "table" then
                v54 = p53.Id;
            else
                v54 = false;
            end;
            if not v54 then
                return l__GetGlobalMuted__22(p53) and "Global Unmute" or "Global Mute";
            end;
        end;
    end,
    function(p55) --[[ Line: 250 ]]
        -- upvalues: u1 (copy), l__LocalPlayer__19 (copy)
        local v56;
        if u1(p55) == "table" then
            v56 = p55.Id;
        else
            v56 = false;
        end;
        if v56 and (p55:IsLocal() and p55.userId == l__LocalPlayer__19.userId) then
            return "Save";
        end;
    end,
    function(p57) --[[ Line: 255 ]]
        -- upvalues: u1 (copy)
        local v58;
        if u1(p57) == "table" then
            v58 = p57.Id;
        else
            v58 = false;
        end;
        if v58 then
            return "Race";
        end;
    end,
    function(p59) --[[ Line: 260 ]]
        -- upvalues: u1 (copy)
        local v60;
        if u1(p59) == "table" then
            v60 = p59.Id;
        else
            v60 = false;
        end;
        if v60 then
            return "Unload";
        end;
    end,
    function(_) --[[ Line: 270 ]]
        -- upvalues: u14 (ref)
        if u14 then
            return "Review Times";
        end;
    end,
    function(p61) --[[ Line: 275 ]]
        -- upvalues: u14 (ref), l__ApprovalStatus__28 (copy)
        if u14 and (l__ApprovalStatus__28[p61.userId] and l__ApprovalStatus__28[p61.userId] ~= 0) then
            return "Clear moderation";
        end;
    end,
    function(p62) --[[ Line: 280 ]]
        -- upvalues: u14 (ref), l__ApprovalStatus__28 (copy)
        if u14 and l__ApprovalStatus__28[p62.userId] ~= 1 then
            return "Whitelist";
        end;
    end,
    function(p63) --[[ Line: 285 ]]
        -- upvalues: u14 (ref), l__ApprovalStatus__28 (copy)
        if u14 and l__ApprovalStatus__28[p63.userId] ~= 2 then
            return "Blacklist";
        end;
    end,
    function(p64) --[[ Line: 290 ]]
        -- upvalues: u14 (ref), u1 (copy)
        if u14 then
            local v65;
            if u1(p64) == "table" then
                v65 = p64.Id;
            else
                v65 = false;
            end;
            if v65 then
                return "Unload Bot";
            end;
        end;
    end,
    function(p66) --[[ Line: 295 ]]
        -- upvalues: u14 (ref), u1 (copy)
        if u14 then
            local v67;
            if u1(p66) == "table" then
                v67 = p66.Id;
            else
                v67 = false;
            end;
            if v67 then
                return "Analyse Bot";
            end;
        end;
    end
};
local u79 = {
    l__SetPlayer__26,
    function(p69) --[[ Line: 303 ]]
        -- upvalues: l__Call__16 (copy), l__GetPersonalMuted__23 (copy)
        l__Call__16("SetMutedPersonal", p69.userId, not l__GetPersonalMuted__23(p69));
    end,
    function(p70) --[[ Line: 306 ]]
        -- upvalues: l__Call__16 (copy), l__GetGlobalMuted__22 (copy)
        l__Call__16("SetMutedGlobal", p70, not l__GetGlobalMuted__22(p70));
    end,
    function(p71) --[[ Line: 309 ]]
        -- upvalues: l__Call__16 (copy)
        l__Call__16("UploadPrivateBot", p71.Id);
    end,
    l__SetRaceBot__27,
    function(p72) --[[ Line: 313 ]]
        -- upvalues: l__Call__16 (copy)
        l__Call__16("UnloadPrivateBot", p72.Id);
        p72:Kick();
    end,
    function(p73) --[[ Line: 322 ]]
        -- upvalues: l__Call__15 (copy), u13 (copy)
        l__Call__15("OpenModeration", p73.userId, p73.Name, u13(p73.Name));
    end,
    function(p74) --[[ Line: 325 ]]
        -- upvalues: l__Call__15 (copy)
        l__Call__15("ModerateUser", p74.userId, 0);
    end,
    function(p75) --[[ Line: 328 ]]
        -- upvalues: l__Call__15 (copy)
        l__Call__15("ModerateUser", p75.userId, 1);
    end,
    function(p76) --[[ Line: 331 ]]
        -- upvalues: l__Call__15 (copy)
        l__Call__15("ModerateUser", p76.userId, 2);
    end,
    function(p77) --[[ Line: 334 ]]
        -- upvalues: l__Call__16 (copy)
        l__Call__16("UnloadBot", p77.Id);
    end,
    function(p78) --[[ Line: 337 ]]
        -- upvalues: l__Call__16 (copy)
        l__Call__16("AnalyseBot", p78.Id);
    end
};
local u80 = nil;
local function u94(u81, p82, p83) --[[ Line: 343 ]]
    -- upvalues: u80 (ref), l__New__9 (copy), u79 (copy), u68 (copy), l__TextBox__10 (copy), u6 (copy), l__max__1 (copy), u1 (copy), l__Color__8 (copy), l__min__2 (copy)
    if u80 then
        u80:Remove();
    end;
    local u84 = l__New__9();
    u84.ZIndex = 7;
    local v85 = {};
    local v86 = 0;
    for v87 = 1, #u79 do
        local v88 = u68[v87](u81);
        if v88 then
            local u89 = u79[v87];
            local u90 = l__TextBox__10(u84, v88);
            u90.TextAlignment = "Center";
            u90.BackgroundColor = u6.Color0;
            v86 = l__max__1(v86, 10 + u90.TextSizeX);
            u90.SizeScaleX = 1;
            u90.SizeOffsetY = 20;
            u90.PosOffsetY = #v85 * 20;
            function u90.Button1Down() --[[ Line: 362 ]]
                -- upvalues: u81 (copy), u1 (ref), u89 (copy), u84 (copy), u80 (ref)
                if u81 and (u81.Parent or u1(u81) == "table") then
                    u89(u81);
                end;
                u84:Remove();
                u80 = nil;
            end;
            function u90.Fade(p91) --[[ Line: 369 ]]
                -- upvalues: u90 (copy), u6 (ref), l__Color__8 (ref)
                local v92 = u90;
                local l__Color0__34 = u6.Color0;
                local l__Color2__35 = u6.Color2;
                local v93 = 1 - p91;
                v92.BackgroundColor = l__Color__8(l__Color0__34.r * v93 + l__Color2__35.r * p91, l__Color0__34.g * v93 + l__Color2__35.g * p91, l__Color0__34.b * v93 + l__Color2__35.b * p91, l__Color0__34.a * v93 + l__Color2__35.a * p91);
            end;
            v85[#v85 + 1] = u90;
        end;
    end;
    u84.SizeOffsetX = v86;
    u84.SizeOffsetY = #v85 * 20;
    u84.PosOffsetX = l__max__1(0, (l__min__2(u84.Parent.SizeX - u84.SizeX, p82)));
    u84.PosOffsetY = l__max__1(0, (l__min__2(u84.Parent.SizeY - u84.SizeY, p83)));
    function u84.MouseLeave() --[[ Line: 379 ]]
        -- upvalues: u84 (copy), u80 (ref)
        u84:Remove();
        u80 = nil;
    end;
    u80 = u84;
end;
local u95 = {};
local u96 = {};
local u97 = 0;
local function u99() --[[ Line: 403 ]]
    -- upvalues: u97 (ref), u96 (copy), u20 (ref), u31 (copy), u26 (copy), l__max__1 (copy)
    u97 = 0;
    for v98 = 1, #u96 do
        u97 = u97 + u96[v98]:Value();
    end;
    if u20 then
        u31:Target((l__max__1(u97 + 20, u26.TextSizeX + 10 - u26.SizeOffsetX)));
    end;
end;
for u100 = 1, #u46 do
    local v107 = l__New__13(100, function(p101) --[[ Line: 414 ]]
        -- upvalues: u99 (copy), u95 (copy), u100 (copy)
        u99();
        for _, v102 in u95 do
            if v102 then
                local l__Stats__36 = v102.Stats;
                local v103 = l__Stats__36 and l__Stats__36[u100];
                if v103 then
                    if u100 == 1 and not v102.Avatar then
                        v103.SizeOffsetX = p101 + v102.SizeY;
                    else
                        v103.SizeOffsetX = p101;
                    end;
                end;
                local l__FadeTween__37 = v102.FadeTween;
                if l__FadeTween__37 and not l__FadeTween__37.Tweening then
                    v102.Fade(l__FadeTween__37:Value());
                end;
                local l__Children__38 = v102.Children;
                if l__Children__38 then
                    local v104 = 0;
                    for v105 = 1, #l__Children__38 do
                        local v106 = l__Children__38[v105];
                        v106.PosOffsetX = v104;
                        v104 = v104 + v106.SizeX;
                    end;
                end;
            end;
        end;
    end);
    v107.MaxAcceleration = l__MaxAcceleration__14(0, 100, 0, 0, 0.5);
    u96[u100] = v107;
end;
local u108 = l__New__9(u32);
u108.BackgroundColor = u6.Color0;
u108.Visible = false;
u108.ClipsDescendants = true;
u108.SizeOffsetY = 20;
u108.SizeScaleX = 1;
u108.PosScaleX = 1;
u108.PosOffsetY = 5;
function u108.Resize() --[[ Line: 451 ]]
    -- upvalues: u108 (ref)
    u108.PosOffsetX = -u108.SizeX;
end;
local v109 = {};
u108.Stats = v109;
for v110 = 1, #u33 do
    local v111 = l__TextBox__10(u108, u33[v110]);
    v111.SizeScaleY = 1;
    if v110 == 1 then
        v111.SizeOffsetX = u96[v110]:Value() + u108.SizeY;
    else
        v111.SizeOffsetX = u96[v110]:Value();
    end;
    v111.TextSize = 12 * u6.roblox_messing_with_guis_factor;
    v111.TextAlignment = "Center";
    v111.DrawBackground = false;
    v109[v110] = v111;
end;
local l__Children__39 = u108.Children;
if l__Children__39 then
    local v112 = 0;
    for v113 = 1, #l__Children__39 do
        local v114 = l__Children__39[v113];
        v114.PosOffsetX = v112;
        v112 = v112 + v114.SizeX;
    end;
end;
local function u122(p115) --[[ Line: 472 ]]
    -- upvalues: u108 (ref), l__max__1 (copy), u2 (copy), u95 (copy), u20 (ref), u31 (copy), u26 (copy), u96 (copy)
    local v116 = 0;
    local v117 = 0;
    local l__Stats__40 = u108.Stats;
    if l__Stats__40 then
        local v118 = l__Stats__40[p115];
        if v118 then
            if p115 == 1 then
                v116 = l__max__1(v116, v118.TextSizeX + 10);
                v117 = l__max__1(v117, v118.TextSizeX + 10 + 20);
            else
                v116 = l__max__1(v116, v118.TextSizeX + 10);
                v117 = l__max__1(v117, v118.TextSizeX + 10);
            end;
        else
            u2("STAT IS NIL", p115, nil);
        end;
    end;
    for v119, v120 in u95 do
        if v120 then
            local l__Stats__41 = v120.Stats;
            if l__Stats__41 then
                local v121 = l__Stats__41[p115];
                if v121 then
                    if p115 == 1 then
                        if v120.IsBot then
                            v116 = l__max__1(v116, v121.TextSizeX + 10 - 20);
                            v117 = l__max__1(v117, v121.TextSizeX + 10);
                        else
                            v116 = l__max__1(v116, v121.TextSizeX + 10);
                            v117 = l__max__1(v117, v121.TextSizeX + 10 + 20);
                        end;
                    else
                        v116 = l__max__1(v116, v121.TextSizeX + 10);
                        v117 = l__max__1(v117, v121.TextSizeX + 10);
                    end;
                else
                    u2("STAT IS NIL", p115, v119);
                end;
            end;
        end;
    end;
    if p115 == 1 and not u20 then
        u31:Target((l__max__1(v117, u26.TextSizeX + 10 - u26.SizeOffsetX)));
        u96[p115]:Target((l__max__1(v116, u26.TextSizeX + 10 - u26.SizeOffsetX - 20)));
    else
        u96[p115]:Target(v116);
    end;
end;
function u26.TextResize() --[[ Line: 522 ]]
    -- upvalues: u122 (copy), u99 (copy)
    u122(1);
    u99();
end;
local function u128() --[[ Line: 527 ]]
    -- upvalues: u20 (ref), u23 (copy), u95 (copy), u24 (copy), u25 (copy)
    local v123 = u20 and 30 or 5;
    for v124 = 1, #u23 do
        local v125 = u95[u23[v124]];
        if v125 then
            v125.PY:Target(v123);
            v123 = v123 + 25;
        end;
    end;
    for v126 = 1, #u24 do
        local v127 = u95[u24[v126]];
        if v127 then
            v127.PY:Target(v123);
            v123 = v123 + 25;
        end;
    end;
    u25.SizeOffsetY = v123;
end;
local function u137(u129, p130, u131, u132) --[[ Line: 546 ]]
    -- upvalues: u46 (copy), l__TextBox__10 (copy), u96 (copy), u6 (copy), u122 (copy)
    local u133 = u46[u129];
    local u134 = u133(u131);
    local u135 = l__TextBox__10(p130, u134);
    u135.SizeScaleY = 1;
    if u129 == 1 and u132 then
        u135.SizeOffsetX = u96[u129]:Value() + p130.SizeY;
    else
        u135.SizeOffsetX = u96[u129]:Value();
    end;
    u135.TextSize = 12 * u6.roblox_messing_with_guis_factor;
    u135.TextAlignment = "Center";
    u135.DrawBackground = false;
    function u135.Think() --[[ Line: 560 ]]
        -- upvalues: u131 (copy), u132 (copy), u133 (copy), u134 (ref), u135 (copy), u122 (ref), u129 (copy)
        if u131 and u131.Parent or u132 then
            local v136 = u133(u131);
            if v136 ~= nil and v136 ~= u134 then
                u135.Text = v136;
                u134 = v136;
                u122(u129);
            end;
        end;
    end;
    return u135;
end;
local function v142(p138, p139, p140, _) --[[ Line: 573 ]]
    -- upvalues: u137 (copy), u49 (copy)
    local v141 = u137(p138, p139, p140, u49);
    v141.AutoLocalize = false;
    return v141;
end;
local u143 = l__Color__8(45, 45, 45, 255);
local u144 = l__Color__8(30, 30, 30, 255);
local u145 = l__Color__8(15, 142.5, 15, 255);
local u146 = l__Color__8(142.5, 15, 15, 255);
local u161 = {
    v142,
    function(u147, p148, u149, p150) --[[ Line: 586 ]]
        -- upvalues: l__TextBox__10 (copy), u96 (copy), u6 (copy), l__New__9 (copy), u143 (copy), u144 (copy), u145 (copy), u146 (copy), l__GetContext__6 (copy), l__LocalPlayer__19 (copy), l__GetNewestRun__30 (copy), u3 (copy), u122 (copy)
        local u151 = l__TextBox__10(p148, "None");
        u151.SizeScaleY = 1;
        if u147 == 1 and p150 then
            u151.SizeOffsetX = u96[u147]:Value() + p148.SizeY;
        else
            u151.SizeOffsetX = u96[u147]:Value();
        end;
        u151.TextSize = 12 * u6.roblox_messing_with_guis_factor;
        u151.TextAlignment = "Center";
        u151.DrawBackground = false;
        local v152 = l__New__9(u151);
        v152.SizeScaleY = 1;
        v152.BackgroundColor = u143;
        v152.SizeScaleX = 1;
        local u153 = l__New__9(v152);
        u153.SizeScaleY = 1;
        u153.BackgroundColor = u144;
        local u154 = l__TextBox__10(u151, "None");
        u154.DrawBackground = false;
        u154.SizeScaleX = 1;
        u154.SizeScaleY = 1;
        u154.TextSize = 12 * u6.roblox_messing_with_guis_factor;
        u154.TextAlignment = "Center";
        u154.ZIndex = 6;
        function u151.Think() --[[ Line: 633 ]]
            -- upvalues: l__GetContext__6 (ref), u149 (copy), l__LocalPlayer__19 (ref), l__GetNewestRun__30 (ref), u3 (ref), u153 (copy), u144 (ref), u145 (ref), u146 (ref), u151 (copy), u154 (copy), u122 (ref), u147 (copy)
            local v155 = 0;
            local v156 = nil;
            local v157 = nil;
            local v158 = l__GetContext__6(u149 == l__LocalPlayer__19 and "Local" or u149);
            if v158 then
                local v159 = l__GetNewestRun__30(v158.Runs);
                if v159 then
                    v155 = v159.Timer:Time();
                    if u149 == l__LocalPlayer__19 then
                        v158 = l__GetContext__6(u149);
                    end;
                    v157 = v158:GetIndex("Times", v159.Mode, v159.Style);
                    if v157 then
                        v156 = u3(v157);
                    else
                        v156 = u3(v155);
                        if v159.InProgress and v159.Timer:GetGlobalScale() == 0 then
                            v156 = v156 .. "⏸";
                        end;
                    end;
                end;
            end;
            if v157 then
                local v160 = v155 / v157;
                if v160 <= 0 then
                    u153.SizeScaleX = 0;
                    u153.BackgroundColor = u144;
                elseif v160 < 1 then
                    u153.SizeScaleX = v160;
                    u153.BackgroundColor = u145;
                elseif v160 == 1 then
                    u153.SizeScaleX = 1;
                    u153.BackgroundColor = u144;
                else
                    u153.SizeScaleX = 1;
                    u153.BackgroundColor = u146;
                end;
            elseif v155 > 0 then
                u153.SizeScaleX = 1;
                u153.BackgroundColor = u144;
            else
                u153.SizeScaleX = 0;
                u153.BackgroundColor = u144;
            end;
            if v156 ~= nil and v156 ~= LastValue then
                u151.Text = v156;
                u154.Text = v156;
                LastValue = v156;
                u122(u147);
            end;
        end;
        return u151;
    end,
    v142,
    u137,
    u137,
    u137,
    u137
};
local u162 = { u6.Color1, u6.Color2, l__Color__8(90, 120, 160) };
local function u197(u163, u164) --[[ Line: 694 ]]
    -- upvalues: l__New__9 (copy), u32 (copy), u95 (copy), l__New__13 (copy), u23 (copy), u24 (copy), l__MaxAcceleration__14 (copy), l__Avatar__11 (copy), u46 (copy), u161 (copy), u122 (copy), u97 (ref), u14 (ref), l__GetContextData__7 (copy), u16 (copy), u17 (copy), l__Color__8 (copy), u15 (ref), u162 (copy), u1 (copy), u4 (copy), u6 (copy), l__ApprovalStatus__28 (copy), u94 (copy)
    local l__userId__42 = u163.userId;
    local u165 = l__New__9(u32);
    u95[u163] = u165;
    u165.IsBot = u164;
    u165.ClipsDescendants = true;
    u165.SizeOffsetY = 20;
    u165.SizeScaleX = 1;
    u165.PosScaleX = 1;
    local u167 = l__New__13(25 * (#u23 + (u164 and #u24 or 0)) - 20, function(p166) --[[ Line: 703 ]]
        -- upvalues: u165 (copy)
        u165.PosOffsetY = p166 - 5 * (u165.SizeY - 20) / 10;
    end);
    u167.MaxAcceleration = l__MaxAcceleration__14(0, 25, 0, 0, 0.2);
    u165.PY = u167;
    local u169 = l__New__13(20, function(p168) --[[ Line: 708 ]]
        -- upvalues: u165 (copy), u167 (copy)
        u165.SizeOffsetY = p168;
        if u167 then
            u165.PosOffsetY = u167:Value() - 5 * (p168 - 20) / 10;
        end;
    end);
    u169.MaxAcceleration = l__MaxAcceleration__14(20, 30, 0, 0, 0.2);
    u165.SY = u169;
    function u165.Resize() --[[ Line: 716 ]]
        -- upvalues: u165 (copy)
        u165.PosOffsetX = -u165.SizeX;
    end;
    local u170;
    if u164 then
        u170 = nil;
    else
        local u171 = l__Avatar__11(u165, l__userId__42 > 0 and l__userId__42 and l__userId__42 or 1);
        u171.DrawBackground = false;
        u171.SizeScaleY = 1;
        function u171.Resize() --[[ Line: 724 ]]
            -- upvalues: u171 (ref), u165 (copy)
            u171.SizeOffsetX = u165.SizeY;
            local l__Children__43 = u165.Children;
            if l__Children__43 then
                local v172 = 0;
                for v173 = 1, #l__Children__43 do
                    local v174 = l__Children__43[v173];
                    v174.PosOffsetX = v172;
                    v172 = v172 + v174.SizeX;
                end;
            end;
        end;
        u165.Avatar = u171;
        u170 = u171;
    end;
    local v175 = {};
    u165.Stats = v175;
    for v176 = 1, #u46 do
        v175[v176] = u161[v176](v176, u165, u163, u164);
        u122(v176);
    end;
    local l__Children__44 = u165.Children;
    if l__Children__44 then
        local v177 = 0;
        for v178 = 1, #l__Children__44 do
            local v179 = l__Children__44[v178];
            v179.PosOffsetX = v177;
            v177 = v177 + v179.SizeX;
        end;
    end;
    function u165.Fade(p180) --[[ Line: 737 ]]
        -- upvalues: u165 (copy), u97 (ref), u14 (ref), l__GetContextData__7 (ref), u163 (copy), u16 (ref), u17 (ref), l__Color__8 (ref), u15 (ref), u164 (copy), u162 (ref), u1 (ref), u4 (ref), u6 (ref), l__ApprovalStatus__28 (ref), l__userId__42 (copy), u170 (ref)
        u165.SizeScaleX = 1 - p180;
        u165.SizeOffsetX = p180 * (u97 + u165.SizeY);
        if u14 and l__GetContextData__7(u163, "Moderator") then
            local v181 = u165;
            local l__Moderator__45 = u16.Moderator;
            local l__Moderator__46 = u17.Moderator;
            local v182 = 1 - p180;
            v181.BackgroundColor = l__Color__8(l__Moderator__45.r * v182 + l__Moderator__46.r * p180, l__Moderator__45.g * v182 + l__Moderator__46.g * p180, l__Moderator__45.b * v182 + l__Moderator__46.b * p180, l__Moderator__45.a * v182 + l__Moderator__46.a * p180);
        elseif u15 and l__GetContextData__7(u163, "ChatModerator") then
            local v183 = u165;
            local l__ChatModerator__47 = u16.ChatModerator;
            local l__ChatModerator__48 = u17.ChatModerator;
            local v184 = 1 - p180;
            v183.BackgroundColor = l__Color__8(l__ChatModerator__47.r * v184 + l__ChatModerator__48.r * p180, l__ChatModerator__47.g * v184 + l__ChatModerator__48.g * p180, l__ChatModerator__47.b * v184 + l__ChatModerator__48.b * p180, l__ChatModerator__47.a * v184 + l__ChatModerator__48.a * p180);
        elseif u164 then
            local v185 = u165;
            local v186 = u162;
            local l__Id__49 = u163.Id;
            v185.BackgroundColor = v186[u1(l__Id__49) == "number" and l__Id__49 < 0 and 3 or (u4(l__Id__49) and 2 or 1)];
        else
            local v187 = u165;
            local l__Color1__50 = u6.Color1;
            local l__Color2__51 = u6.Color2;
            local v188 = 1 - p180;
            v187.BackgroundColor = l__Color__8(l__Color1__50.r * v188 + l__Color2__51.r * p180, l__Color1__50.g * v188 + l__Color2__51.g * p180, l__Color1__50.b * v188 + l__Color2__51.b * p180, l__Color1__50.a * v188 + l__Color2__51.a * p180);
        end;
        if u14 then
            local v189 = l__ApprovalStatus__28[l__userId__42] or 0;
            if u170 then
                local v190 = v189 ~= 0;
                u170.DrawBackground = v190;
                if v190 then
                    local v191 = u170;
                    local v192 = u16[v189];
                    local v193 = u17[v189];
                    local v194 = 1 - p180;
                    v191.BackgroundColor = l__Color__8(v192.r * v194 + v193.r * p180, v192.g * v194 + v193.g * p180, v192.b * v194 + v193.b * p180, v192.a * v194 + v193.a * p180);
                end;
            end;
        end;
    end;
    function u165.MouseEnter() --[[ Line: 760 ]]
        -- upvalues: u169 (copy)
        u169:Target(30);
    end;
    function u165.MouseLeave() --[[ Line: 763 ]]
        -- upvalues: u169 (copy)
        u169:Target(20);
    end;
    function u165.Button2Down(p195, p196) --[[ Line: 766 ]]
        -- upvalues: u94 (ref), u163 (copy), u165 (copy)
        u94(u163, u165.PosX + p195 + 1, u165.PosY + p196 + 1);
    end;
    function u165.Removed() --[[ Line: 769 ]]
        -- upvalues: u167 (copy), u169 (copy)
        u167:Remove();
        u169:Remove();
    end;
    return u165;
end;
local function v203(p198) --[[ Line: 796 ]]
    -- upvalues: u23 (copy), l__remove__4 (copy), u24 (copy), u95 (copy), u128 (copy), u46 (copy), u122 (copy), u26 (copy)
    for v199 = #u23, 1, -1 do
        if u23[v199] == p198 then
            l__remove__4(u23, v199);
        end;
    end;
    for v200 = #u24, 1, -1 do
        if u24[v200] == p198 then
            l__remove__4(u24, v200);
        end;
    end;
    local v201 = u95[p198];
    if v201 then
        v201:Remove();
        u95[p198] = nil;
        u128();
        for v202 = 1, #u46 do
            u122(v202);
        end;
    end;
    u26.Text = "Player List (" .. #u23 .. ")";
end;
v11.BotAdded:Add(function(p204) --[[ Name: BotAdded, Line 776 ]]
    -- upvalues: u24 (copy), u197 (copy), u128 (copy)
    u24[#u24 + 1] = p204;
    u197(p204, true);
    u128();
end);
v11.BotRemoving:Add(v203);
v11.BotIdChanged:Add(function(p205, _) --[[ Name: BotIdChanged, Line 782 ]]
    -- upvalues: u95 (copy)
    local v206 = u95[p205];
    if v206 then
        v206.Fade(v206.FadeTween:Value());
    end;
end);
v9.PlayerAdded:Add(function(p207) --[[ Name: PlayerJoined, Line 789 ]]
    -- upvalues: u23 (copy), u197 (copy), u26 (copy), u128 (copy)
    u23[#u23 + 1] = p207;
    u197(p207);
    u26.Text = "Player List (" .. #u23 .. ")";
    u128();
end);
v9.PlayerRemoving:Add(v203);
v12.ShowModerationSignal:Add(function() --[[ Line: 826 ]]
    -- upvalues: u14 (ref), u16 (copy), u6 (copy), l__Color__8 (copy), u17 (copy)
    u14 = true;
    u16[0] = u6.Color1;
    u16[1] = l__Color__8(224, 224, 224);
    u16[2] = l__Color__8(30, 30, 30);
    u16[3] = l__Color__8(255, 225, 53);
    u16[4] = l__Color__8(224, 30, 30);
    u16.Moderator = l__Color__8(128, 0, 192);
    u17[0] = u6.Color2;
    u17[1] = l__Color__8(168, 168, 168);
    u17[2] = l__Color__8(22.5, 22.5, 22.5);
    u17[3] = l__Color__8(191.25, 168.75, 39.75);
    u17[4] = l__Color__8(150, 30, 30);
    u17.Moderator = l__Color__8(96, 0, 144);
end);
v12.UserStatusChanged:Add(function(p208, p209) --[[ Line: 843 ]]
    -- upvalues: l__GetPlayerByUserId__21 (copy), l__PlayersService__20 (copy), u95 (copy), u16 (copy)
    local v210 = l__GetPlayerByUserId__21(l__PlayersService__20, p208);
    local v211 = v210 and u95[v210];
    if v211 then
        local l__Avatar__52 = v211.Avatar;
        l__Avatar__52.DrawBackground = p209 ~= 0;
        l__Avatar__52.BackgroundColor = u16[p209];
        local l__FadeTween__53 = v211.FadeTween;
        if l__FadeTween__53 and not l__FadeTween__53.Tweening then
            v211.Fade(l__FadeTween__53:Value());
        end;
    end;
end);
l__ShowChatModerationSignal__24:Add(function() --[[ Line: 859 ]]
    -- upvalues: u15 (ref), u16 (copy), l__Color__8 (copy), u17 (copy)
    u15 = true;
    u16.ChatModerator = l__Color__8(60, 120, 50);
    u17.ChatModerator = l__Color__8(40, 100, 30);
end);
return function() --[[ Line: 865 ]]
    -- upvalues: u20 (ref), l__FreeMouse__12 (copy), u32 (copy), u108 (ref), u95 (copy), u128 (copy), u31 (copy), u97 (ref), u26 (copy), l__max__1 (copy), u33 (copy), u122 (copy), u21 (ref), u96 (copy)
    local u212 = nil;
    game:GetService("RunService").RenderStepped:connect(function() --[[ Line: 867 ]]
        -- upvalues: u20 (ref), u212 (ref), l__FreeMouse__12 (ref), u32 (ref), u108 (ref), u95 (ref), u128 (ref), u31 (ref), u97 (ref), u26 (ref), l__max__1 (ref), u33 (ref), u122 (ref), u21 (ref), u96 (ref)
        if u20 ~= u212 then
            u212 = u20;
            l__FreeMouse__12("Tab", u20);
            if u20 then
                u32.Visible = true;
                u108.Visible = true;
                u95[true] = u108;
                u128();
                u31:Target((l__max__1(u97 + 20, u26.TextSizeX + 10 - u26.SizeOffsetX)));
                for v213 = 1, #u33 do
                    u122(v213);
                end;
                return;
            end;
            u32.Visible = u21;
            u108.Visible = false;
            u95[true] = nil;
            u128();
            u31:Target(u96[1]:Value() + 20);
            for v214 = 1, #u33 do
                u122(v214);
            end;
        end;
    end);
end;
