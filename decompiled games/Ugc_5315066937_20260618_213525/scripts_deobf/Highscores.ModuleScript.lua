-- Decompiled from: Highscores
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__time__1 = os.time;
local l__min__2 = math.min;
local l__max__3 = math.max;
local l__floor__4 = math.floor;
local l__sort__5 = table.sort;
local l__clear__6 = table.clear;
local l__insert__7 = table.insert;
local l__remove__8 = table.remove;
local l__obtain__9 = _G.obtain;
local u1 = l__obtain__9("LabelPrint");
local u2 = l__obtain__9("L1Copy");
local u3 = l__obtain__9("GetFormattedTime");
local u4 = l__obtain__9("ImplIntoInt64");
local u5 = l__obtain__9("date");
local u6 = l__obtain__9("QBox");
local l__Color__10 = u6.Color;
local l__New__11 = u6.New;
local l__Avatar__12 = u6.Avatar;
local l__TextBox__13 = u6.TextBox;
local l__FreeMouse__14 = u6.FreeMouse;
local l__IsFreeingMouse__15 = u6.IsFreeingMouse;
local v7 = l__obtain__9("Tween");
local l__New__16 = v7.New;
local l__MaxAcceleration__17 = v7.MaxAcceleration;
local v8 = l__obtain__9("Local");
local l__Call__18 = v8.Call;
local v9 = l__obtain__9("Remote");
local l__Call__19 = v9.Call;
local v10 = l__obtain__9("Styles");
local l__TypeNames__20 = v10.TypeNames;
local l__TypeNumberToId__21 = v10.TypeNumberToId;
local l__ModeNames__22 = v10.ModeNames;
local l__ModeNumberToId__23 = v10.ModeNumberToId;
local v11 = l__obtain__9("Command");
local l__LocalPlayer__24 = l__obtain__9("PlayerManager").LocalPlayer;
local v12 = l__obtain__9("Moderation");
local v13 = l__obtain__9("MapManager");
local v14 = l__obtain__9("MapLists");
local l__AllMaps__25 = v14.AllMaps;
local v15 = l__obtain__9("TimeManager");
local v16 = l__obtain__9("WaitForBot");
local l__WFBRace__26 = v16.WFBRace;
local l__WFBSpectate__27 = v16.WFBSpectate;
local u17 = l__obtain__9("ConfirmDeletion");
local u18 = ({
    [52250025] = true,
    [467315479] = true,
    [19136944] = true,
    [1455906620] = true,
    [70034157] = true
})[l__LocalPlayer__24.userId];
local u19 = false;
local v20 = false;
local u21 = nil;
local v22 = u21;
local v23 = 0;
local l__DefaultStyle__28 = v10.DefaultStyle;
local v24 = false;
local u25 = nil;
local u26 = l__New__11();
u26.Visible = false;
u26.BackgroundColor = l__Color__10(37.5, 37.5, 37.5, 255);
u26.SizeOffsetX = 450;
u26.SizeOffsetY = 620;
u26.PosScaleX = 0.5;
function u26.Resize() --[[ Line: 104 ]]
    -- upvalues: u26 (copy)
    u26.PosOffsetX = u26.SizeX / -2;
end;
local u28 = l__New__16(-u26.SizeY, function(p27) --[[ Line: 108 ]]
    -- upvalues: u26 (copy)
    u26.PosOffsetY = p27;
end);
u28.MaxAcceleration = l__MaxAcceleration__17(1080, 0, 0, 0, 1);
spawn(function() --[[ Line: 111 ]]
    -- upvalues: u26 (copy), u28 (copy)
    while u26.Parent.SizeY == 0 do
        wait();
    end;
    u28:Target(-u26.SizeY);
end);
function u26.Moved() --[[ Line: 118 ]]
    -- upvalues: u28 (copy), u26 (copy)
    if not u28.Tweening then
        u28.x1 = u26.PosOffsetY;
    end;
end;
local u29 = u6.Resizable(u26);
u29.ClipsDescendants = true;
u29.MinY = 240;
local u30 = l__TextBox__13(u29, "Highscores");
u30.BackgroundColor = u6.Color1;
u30.TextAlignment = "Center";
u30.SizeScaleX = 1;
u30.SizeOffsetX = -60;
u30.SizeOffsetY = 30;
local u31 = l__TextBox__13(u29, "C");
u31.TextAlignment = "Center";
u31.TextSize = 12 * u6.roblox_messing_with_guis_factor;
u31.SizeOffsetX = 30;
u31.SizeOffsetY = 30;
u31.PosScaleX = 1;
u31.PosOffsetX = -60;
function u31.Button1Down() --[[ Line: 144 ]]
    -- upvalues: l__IsFreeingMouse__15 (copy), l__FreeMouse__14 (copy), u31 (copy)
    local v32 = not l__IsFreeingMouse__15("Highscores");
    l__FreeMouse__14("Highscores", v32);
    if v32 then
        u31.Text = "C";
    else
        u31.Text = "^";
    end;
end;
local v33 = l__TextBox__13(u29, "x");
v33.TextAlignment = "Center";
v33.TextSize = 12 * u6.roblox_messing_with_guis_factor;
v33.SizeOffsetX = 30;
v33.SizeOffsetY = 30;
v33.PosScaleX = 1;
v33.PosOffsetX = -30;
function v33.Button1Down() --[[ Line: 163 ]]
    -- upvalues: u25 (ref)
    u25();
end;
u6.DragBar(u30, u26);
local u34 = {
    "#",
    "",
    "Name",
    "Time",
    "Date"
};
local v35 = l__New__11(u29);
v35.PosOffsetY = 60;
v35.SizeScaleX = 1;
v35.SizeOffsetY = 20;
v35.DrawBackground = false;
local u36 = v20;
local u37 = v22;
local u38 = v24;
local u39 = v23;
local u40 = l__DefaultStyle__28;
local u41 = {};
for v42 = 1, #u34 do
    local v43 = l__TextBox__13(v35, u34[v42]);
    v43.TextAlignment = "Center";
    v43.SizeScaleY = 1;
    v43.SizeOffsetX = v43.TextSizeX + 10;
    u41[v42] = v43;
end;
local u44 = l__New__11(u29);
u44.DrawBackground = false;
u44.SizeScaleX = 1;
u44.SizeScaleY = 1;
u44.PosOffsetY = 80;
u44.SizeOffsetY = -80;
local u45 = l__New__11();
u6.Scroll(u45, u44);
local u46 = l__New__11(u29);
u46.SizeScaleX = 1;
u46.SizeOffsetY = 30;
u46.PosOffsetY = 30;
u46.DrawBackground = false;
local u48 = u6.Dropdown(u46, l__TypeNames__20, function(p47) --[[ Line: 204 ]]
    -- upvalues: u40 (ref), l__TypeNumberToId__21 (copy), u36 (ref), l__Call__19 (copy), u37 (ref), u39 (ref), u38 (ref)
    u40 = l__TypeNumberToId__21[p47];
    if u36 then
        l__Call__19("GetHighscores", u37, u39, u40, u38);
    end;
end, l__TypeNames__20[1]);
u48.PosOffsetY = 5;
u48.SizeOffsetY = 20;
u48.SizeOffsetX = u48.GetWidth() + 10;
u48.PosOffsetX = -5 - u48.SizeX;
u48.PosScaleX = 1;
local u49 = nil;
local u50 = nil;
local function u53(p51) --[[ Line: 225 ]]
    -- upvalues: u49 (ref), u6 (copy), u46 (copy), u39 (ref), u36 (ref), l__Call__19 (copy), u37 (ref), u40 (ref), u38 (ref), u48 (copy), u50 (ref)
    if u49 then
        u49:Remove();
    end;
    u49 = u6.Dropdown(u46, p51, function(p52) --[[ Line: 229 ]]
        -- upvalues: u39 (ref), u36 (ref), l__Call__19 (ref), u37 (ref), u40 (ref), u38 (ref)
        u39 = p52 - 1;
        if u36 then
            l__Call__19("GetHighscores", u37, u39, u40, u38);
        end;
    end, p51[1]);
    u39 = 0;
    u49.PosOffsetY = 5;
    u49.SizeOffsetY = 20;
    u49.SizeOffsetX = u49.GetWidth() + 10;
    u49.PosScaleX = 1;
    u49.PosOffsetX = -10 - u49.SizeX - u48.SizeX;
    if u50 then
        u50.PosOffsetX = -15 - u50.SizeX - u49.SizeX - u48.SizeX;
    end;
end;
u53(l__ModeNames__22, l__ModeNumberToId__23);
local u54 = {};
local function u57() --[[ Line: 247 ]]
    -- upvalues: u50 (ref), u6 (copy), u46 (copy), u38 (ref), u36 (ref), l__Call__19 (copy), u37 (ref), u39 (ref), u40 (ref), u49 (ref), u48 (copy)
    local v55 = { "Approved", "All" };
    u50 = u6.Dropdown(u46, v55, function(p56) --[[ Line: 249 ]]
        -- upvalues: u38 (ref), u36 (ref), l__Call__19 (ref), u37 (ref), u39 (ref), u40 (ref)
        u38 = p56 == 2;
        if u36 then
            l__Call__19("GetHighscores", u37, u39, u40, u38);
        end;
    end, v55[1]);
    u50.PosOffsetY = 5;
    u50.SizeOffsetY = 20;
    u50.SizeOffsetX = u50.GetWidth() + 10;
    u50.PosScaleX = 1;
    u50.PosOffsetX = -15 - u50.SizeX - u49.SizeX - u48.SizeX;
end;
local u58 = nil;
v14.Ready:Add(function() --[[ Line: 262 ]]
    -- upvalues: u37 (ref), u21 (ref), l__sort__5 (copy), l__AllMaps__25 (copy), u58 (ref), u6 (copy), u46 (copy), u53 (copy), u36 (ref), l__Call__19 (copy), u39 (ref), u40 (ref), u38 (ref), u26 (copy), u49 (ref), u48 (copy), u50 (ref), u1 (copy)
    u37 = u21;
    l__sort__5(l__AllMaps__25, function(p59, p60) --[[ Line: 264 ]]
        if p59 and p60 then
            return p59.DisplayName < p60.DisplayName;
        end;
    end);
    local v61 = {};
    local v62 = nil;
    for v63 = 1, #l__AllMaps__25 do
        local v64 = l__AllMaps__25[v63];
        v61[v63] = v64.DisplayName;
        if v64.AssetId == u37 then
            v62 = v63;
        end;
    end;
    u58 = u6.Dropdown(u46, v61, function(p65) --[[ Line: 278 ]]
        -- upvalues: l__AllMaps__25 (ref), u37 (ref), u53 (ref), u36 (ref), l__Call__19 (ref), u39 (ref), u40 (ref), u38 (ref)
        local v66 = l__AllMaps__25[p65];
        u37 = v66.AssetId;
        local v67 = u53;
        local v68 = { "Main" };
        for v69 = 2, v66.Modes do
            v68[v69] = "Bonus " .. v69 - 1;
        end;
        v67(v68);
        if u36 then
            l__Call__19("GetHighscores", u37, u39, u40, u38);
        end;
    end, v61[v62]);
    u58.PosOffsetX = 5;
    u58.PosOffsetY = 5;
    u58.SizeOffsetY = 20;
    u58.SizeOffsetX = u58.GetWidth() + 10;
    u26.SizeOffsetX = 25 + u58.SizeX + u49.SizeX + u48.SizeX + (u50 and u50.SizeX or 0);
    if v62 then
        u58.ChooseItem(v62);
    else
        u1("Could not find map for CurrentMapId=", u21);
    end;
end);
local u70 = nil;
local u71 = {};
local u72 = {};
local function u99() --[[ Line: 301 ]]
    -- upvalues: u41 (copy), l__clear__6 (copy), u71 (copy), u34 (copy), u72 (ref), u70 (ref), u45 (copy), u29 (copy), u30 (copy), l__max__3 (copy)
    local u73 = {};
    for v74 = 1, #u41 do
        u73[v74] = u41[v74].TextSizeX + 10;
    end;
    l__clear__6(u71);
    local u75 = 0;
    local u76 = 0;
    local function v82(p77, p78, p79) --[[ Line: 311 ]]
        -- upvalues: u71 (ref), u76 (ref), u75 (ref), u34 (ref), u73 (copy)
        if p79 then
            u71[p77.t.User] = p78;
            if p77.t.Time ~= u76 then
                u75 = p78;
                u76 = p77.t.Time;
            end;
            p77[1].Text = tostring(u75) .. ".";
            p77.PY:Target(30 * (p78 - 1));
        end;
        for v80 = 1, #u34 do
            local v81 = v80 == 2 and p77[v80].SizeX or p77[v80].TextSizeX + 10;
            if u73[v80] < v81 then
                u73[v80] = v81;
            end;
        end;
    end;
    for v83 = 1, #u72 do
        v82(u72[v83], v83, true);
    end;
    if u70 then
        local v84 = u70;
        for v85 = 1, #u34 do
            local v86 = v85 == 2 and v84[v85].SizeX or v84[v85].TextSizeX + 10;
            if u73[v85] < v86 then
                u73[v85] = v86;
            end;
        end;
    end;
    local v87 = { 0 };
    for v88 = 1, #u34 do
        local v89 = u73[v88];
        local v90 = v87[v88];
        v87[v88 + 1] = v90 + v89;
        local v91 = u41[v88];
        v91.SizeOffsetX = v89;
        v91.PosOffsetX = v90;
    end;
    u45.SizeOffsetX = v87[#v87];
    u45.SizeOffsetY = #u72 * 30;
    u29.MinX = l__max__3(v87[#v87], u30.TextSizeX + 70);
    for v92 = 1, #u72 do
        local v93 = u72[v92];
        for v94 = 1, #u34 do
            local v95 = v93[v94];
            v95.SizeOffsetX = u73[v94];
            v95.PosOffsetX = v87[v94];
        end;
    end;
    if u70 then
        local v96 = u70;
        for v97 = 1, #u34 do
            local v98 = v96[v97];
            v98.SizeOffsetX = u73[v97];
            v98.PosOffsetX = v87[v97];
        end;
    end;
end;
local u100 = { u6.Color1, u6.Color2, l__Color__10(90, 120, 160) };
local u111 = {
    function(p101) --[[ Line: 391 ]]
        -- upvalues: u18 (copy)
        if u18 and p101.t.ID then
            return "ID: " .. p101.t.ID;
        end;
    end,
    function(p102) --[[ Line: 396 ]]
        -- upvalues: u18 (copy)
        if u18 and p102.t.ID then
            return "Delete";
        end;
    end,
    function(p103) --[[ Line: 401 ]]
        -- upvalues: u18 (copy)
        if u18 and p103.t.Bot then
            return "BotID: " .. p103.t.Bot;
        end;
    end,
    function(p104) --[[ Line: 406 ]]
        -- upvalues: u37 (ref), u21 (ref)
        if p104.t.Bot and u37 == u21 then
            return "Spectate";
        end;
    end,
    function(p105) --[[ Line: 411 ]]
        -- upvalues: u37 (ref), u21 (ref), u4 (copy)
        if p105.t.Bot and u37 == u21 then
            local l__Bot__29 = p105.t.Bot;
            if (type(l__Bot__29) == "number" and l__Bot__29 < 0 and 3 or (u4(l__Bot__29) and 2 or 1)) == 3 then
                return "Save";
            end;
        end;
    end,
    function(p106) --[[ Line: 416 ]]
        -- upvalues: u37 (ref), u21 (ref)
        if p106.t.Bot and u37 == u21 then
            return "Race";
        end;
    end,
    function(_) --[[ Line: 421 ]]
        -- upvalues: u19 (ref)
        if u19 then
            return "Review times";
        end;
    end,
    function(p107) --[[ Line: 426 ]]
        -- upvalues: u19 (ref)
        if u19 and p107.t.State ~= 0 then
            return "Clear moderation";
        end;
    end,
    function(p108) --[[ Line: 431 ]]
        -- upvalues: u19 (ref)
        if u19 and p108.t.State ~= 1 then
            return "Whitelist";
        end;
    end,
    function(p109) --[[ Line: 436 ]]
        -- upvalues: u19 (ref)
        if u19 and p109.t.State ~= 2 then
            return "Blacklist";
        end;
    end,
    function(p110) --[[ Line: 441 ]]
        -- upvalues: u19 (ref)
        if u19 and p110.t.Bot then
            return "Analyse Bot";
        end;
    end
};
local u121 = {
    false,
    function(p112) --[[ Line: 449 ]]
        -- upvalues: u17 (copy)
        u17(p112.t);
    end,
    false,
    function(p113) --[[ Line: 453 ]]
        -- upvalues: l__WFBSpectate__27 (copy)
        l__WFBSpectate__27(p113.t.ID, p113.t.Bot);
    end,
    function(p114) --[[ Line: 456 ]]
        -- upvalues: l__Call__19 (copy)
        l__Call__19("UploadPrivateBot", p114.t.Bot);
    end,
    function(p115) --[[ Line: 459 ]]
        -- upvalues: l__WFBRace__26 (copy)
        l__WFBRace__26(p115.t.ID, p115.t.Bot);
    end,
    function(p116) --[[ Line: 462 ]]
        -- upvalues: l__Call__18 (copy)
        l__Call__18("OpenModeration", p116.t.User);
    end,
    function(p117) --[[ Line: 465 ]]
        -- upvalues: l__Call__18 (copy)
        l__Call__18("ModerateUser", p117.t.User, 0);
    end,
    function(p118) --[[ Line: 468 ]]
        -- upvalues: l__Call__18 (copy)
        l__Call__18("ModerateUser", p118.t.User, 1);
    end,
    function(p119) --[[ Line: 471 ]]
        -- upvalues: l__Call__18 (copy)
        l__Call__18("ModerateUser", p119.t.User, 2);
    end,
    function(p120) --[[ Line: 474 ]]
        -- upvalues: l__Call__19 (copy)
        l__Call__19("AnalyseBot", p120.t.Bot);
    end
};
local u122 = nil;
local function u137(u123, p124, p125) --[[ Line: 480 ]]
    -- upvalues: u122 (ref), l__New__11 (copy), u121 (copy), u111 (copy), l__TextBox__13 (copy), u6 (copy), l__max__3 (copy), l__Color__10 (copy), l__min__2 (copy)
    if u122 then
        u122:Remove();
    end;
    local u126 = l__New__11();
    local v127 = 0;
    local v128 = {};
    local v129 = false;
    for v130 = 1, #u121 do
        local v131 = u111[v130](u123);
        if v131 then
            v129 = true;
            local u132 = l__TextBox__13(u126, v131);
            u132.TextAlignment = "Center";
            u132.BackgroundColor = u6.Color0;
            v127 = l__max__3(v127, 10 + u132.TextSizeX);
            u132.SizeScaleX = 1;
            u132.SizeOffsetY = 20;
            u132.PosOffsetY = #v128 * 20;
            local u133 = u121[v130];
            if u133 then
                function u132.Button1Down() --[[ Line: 501 ]]
                    -- upvalues: u123 (copy), u133 (copy), u126 (copy), u122 (ref)
                    if u123 then
                        u133(u123);
                    end;
                    u126:Remove();
                    u122 = nil;
                end;
                function u132.Fade(p134) --[[ Line: 508 ]]
                    -- upvalues: u132 (copy), u6 (ref), l__Color__10 (ref)
                    local v135 = u132;
                    local l__Color0__30 = u6.Color0;
                    local l__Color2__31 = u6.Color2;
                    local v136 = 1 - p134;
                    v135.BackgroundColor = l__Color__10(l__Color0__30.r * v136 + l__Color2__31.r * p134, l__Color0__30.g * v136 + l__Color2__31.g * p134, l__Color0__30.b * v136 + l__Color2__31.b * p134, l__Color0__30.a * v136 + l__Color2__31.a * p134);
                end;
            end;
            v128[#v128 + 1] = u132;
        end;
    end;
    if v129 then
        u126.SizeOffsetX = v127;
        u126.SizeOffsetY = #v128 * 20;
        u126.PosOffsetX = l__max__3(0, (l__min__2(u126.Parent.SizeX - u126.SizeX, p124)));
        u126.PosOffsetY = l__max__3(0, (l__min__2(u126.Parent.SizeY - u126.SizeY, p125)));
        function u126.MouseLeave() --[[ Line: 520 ]]
            -- upvalues: u126 (copy), u122 (ref)
            u126:Remove();
            u122 = nil;
        end;
        u122 = u126;
    else
        u126:Remove();
    end;
end;
local function u163(p138, p139, u140, p141) --[[ Line: 530 ]]
    -- upvalues: l__New__11 (copy), u100 (copy), u4 (copy), l__TextBox__13 (copy), l__Avatar__12 (copy), u19 (ref), u38 (ref), u54 (copy), u6 (copy), u3 (copy), u5 (copy), l__time__1 (copy), l__floor__4 (copy), u137 (copy), l__New__16 (copy), l__MaxAcceleration__17 (copy)
    local u142 = l__New__11(p138);
    u142.SizeScaleX = 1;
    u142.SizeOffsetY = 30;
    local l__Bot__32 = u140.Bot;
    u142.BackgroundColor = u100[type(l__Bot__32) == "number" and l__Bot__32 < 0 and 3 or (u4(l__Bot__32) and 2 or 1)];
    local v143 = 0;
    local v144 = l__TextBox__13(u142, tostring(p139) .. ".");
    v144.DrawBackground = false;
    v144.TextAlignment = "Center";
    v144.SizeScaleY = 1;
    v144.SizeOffsetX = v144.TextSizeX + 10;
    v144.PosOffsetX = v143;
    u142[1] = v144;
    local v145 = v143 + v144.SizeX;
    local v146 = l__Avatar__12(u142, u140.User);
    v146.SizeOffsetX = 30;
    v146.SizeScaleY = 1;
    v146.PosOffsetX = v145;
    if u19 and (u38 and u54[u140.State]) then
        v146.BackgroundColor = u54[u140.State];
    else
        v146.DrawBackground = false;
    end;
    u142[2] = v146;
    local v147 = v145 + v146.SizeX;
    local v148 = l__TextBox__13(u142, u140.Name);
    v148.DrawBackground = false;
    v148.TextAlignment = "Center";
    v148.TextSize = 12 * u6.roblox_messing_with_guis_factor;
    v148.SizeScaleY = 1;
    v148.SizeOffsetX = v148.TextSizeX + 10;
    v148.PosOffsetX = v147;
    u142[3] = v148;
    local v149 = v147 + v148.SizeX;
    local v150 = l__TextBox__13(u142, u3(u140.Time));
    v150.DrawBackground = false;
    v150.TextAlignment = "Center";
    v150.TextSize = 12 * u6.roblox_messing_with_guis_factor;
    v150.SizeScaleY = 1;
    v150.SizeOffsetX = v150.TextSizeX + 10;
    v150.PosOffsetX = v149;
    u142[4] = v150;
    local v151 = v149 + v150.SizeX;
    local u152 = l__TextBox__13(u142, u5("%x", u140.Date or 0));
    u152.DrawBackground = false;
    u152.TextAlignment = "Center";
    u152.TextSize = 12 * u6.roblox_messing_with_guis_factor;
    u152.SizeScaleY = 1;
    u152.SizeOffsetX = u152.TextSizeX + 10;
    u152.PosOffsetX = v151;
    if u140.Date and l__time__1() - u140.Date < 604800 then
        function u152.Think() --[[ Line: 585 ]]
            -- upvalues: u140 (copy), l__time__1 (ref), u152 (copy), l__floor__4 (ref), u5 (ref)
            if u140.Date then
                local v153 = l__time__1() - u140.Date;
                local v154 = v153 < 0 and 0 or v153;
                local v155 = nil;
                local v156 = 1;
                local v157 = nil;
                if v154 < 60 then
                    v155 = "second";
                    v156 = 1;
                elseif v154 < 3600 then
                    v155 = "minute";
                    v156 = 60;
                elseif v154 < 86400 then
                    v155 = "hour";
                    v156 = 3600;
                elseif v154 < 172800 then
                    v157 = "Yesterday";
                elseif v154 < 604800 then
                    v155 = "day";
                    v156 = 86400;
                end;
                if v157 then
                    u152.Text = v157;
                    return;
                end;
                if v155 then
                    local v158 = l__floor__4(v154 / v156);
                    u152.Text = v158 .. " " .. v155 .. ((v158 == 1 or v155 == "ms") and "" or "s");
                    return;
                end;
                u152.Think = nil;
                u152.Text = u5("%x", v154.Date);
            end;
        end;
        u152.Think();
    end;
    u142[5] = u152;
    local _ = v151 + u152.SizeX;
    u142.t = u140;
    function u142.Button2Down(p159, p160) --[[ Line: 634 ]]
        -- upvalues: u137 (ref), u142 (copy)
        u137(u142, u142.PosX + p159 + 1, u142.PosY + p160 + 1);
    end;
    if p141 then
        local u162 = l__New__16(30 * (p139 - 1), function(p161) --[[ Line: 638 ]]
            -- upvalues: u142 (copy)
            u142.PosOffsetY = p161;
        end);
        u162.MaxAcceleration = l__MaxAcceleration__17(0, 30, 0, 0, 2);
        u142.PY = u162;
        function u142.Removed() --[[ Line: 641 ]]
            -- upvalues: u162 (copy)
            u162:Remove();
        end;
    end;
    return u142;
end;
local function u166(p164, p165) --[[ Line: 648 ]]
    if p164 and p165 then
        return p164.t.Time == p165.t.Time and p164.t.Date < p165.t.Date and true or p164.t.Time < p165.t.Time;
    end;
end;
v9.Add("SetHighscores", function(p167, p168, p169, _) --[[ Line: 654 ]]
    -- upvalues: u72 (ref), l__clear__6 (copy), l__min__2 (copy), u163 (copy), u45 (copy), u70 (ref), u29 (copy), u26 (copy), u44 (copy), u99 (copy), u1 (copy)
    if p167 then
        for v170 = 1, #u72 do
            u72[v170]:Remove();
        end;
        l__clear__6(u72);
        for v171 = 1, l__min__2(#p167, 300) do
            u72[v171] = u163(u45, v171, p167[v171], true);
        end;
        if u70 then
            u70:Remove();
        end;
        if p168 then
            u70 = u163(u29, p169, p168, false);
            u70.PosScaleY = 1;
            u70.PosOffsetY = -u70.SizeY;
            u26.SizeOffsetY = 650;
            u44.SizeOffsetY = -115;
        else
            u70 = nil;
            u26.SizeOffsetY = 620;
            u44.SizeOffsetY = -80;
        end;
        u99();
    else
        u1("Highscores were missing!");
    end;
end);
v15.NewTimeHook:Add(function(p172) --[[ Line: 684 ]]
    -- upvalues: u36 (ref), u40 (ref), u39 (ref), u37 (ref), u72 (ref), u2 (copy), u100 (copy), u4 (copy), u3 (copy), l__sort__5 (copy), u166 (copy), u163 (copy), u45 (copy), l__insert__7 (copy), l__remove__8 (copy), u99 (copy), u70 (ref)
    if u36 and (p172.Style == u40 and (p172.Mode == u39 and p172.Map == u37)) then
        local v173 = true;
        local v174 = nil;
        for v175 = 1, #u72 do
            local v176 = u72[v175];
            if p172.User == v176.t.User then
                u2(p172, v176.t);
                local l__Bot__33 = p172.Bot;
                v176.BackgroundColor = u100[type(l__Bot__33) == "number" and l__Bot__33 < 0 and 3 or (u4(l__Bot__33) and 2 or 1)];
                v176[3].Text = p172.Name;
                v176[4].Text = u3(p172.Time);
                l__sort__5(u72, u166);
                v174 = v176;
                v173 = false;
                break;
            end;
        end;
        if v173 then
            for v177 = 1, #u72 do
                if p172.Time < u72[v177].t.Time then
                    l__insert__7(u72, v177, (u163(u45, v177, p172, true)));
                    v173 = false;
                    break;
                end;
            end;
            if v173 then
                if #u72 < 300 then
                    u72[#u72 + 1] = u163(u45, #u72 + 1, p172, true);
                end;
            elseif #u72 > 300 then
                for v178 = #u72, 301, -1 do
                    l__remove__8(u72, v178):Remove();
                end;
            end;
        end;
        u99();
        if u70 and (v174 and p172.User == u70.t.User) then
            local v179 = u70;
            v179[1].Text = v174[1].Text;
            u2(p172, v179.t);
            local l__Bot__34 = p172.Bot;
            v179.BackgroundColor = u100[type(l__Bot__34) == "number" and l__Bot__34 < 0 and 3 or (u4(l__Bot__34) and 2 or 1)];
            v179[3].Text = p172.Name;
            v179[4].Text = u3(p172.Time);
        end;
    end;
end);
local u180 = {};
v9.Add("NewHighscores", function(p181) --[[ Line: 739 ]]
    -- upvalues: u36 (ref), u72 (ref), l__clear__6 (copy), u180 (copy), u37 (ref), u39 (ref), u40 (ref), l__remove__8 (copy), u3 (copy), l__sort__5 (copy), u166 (copy), u163 (copy), u45 (copy), l__min__2 (copy), u99 (copy)
    if u36 and (not u72[300] or u72[300].t.Time > p181[1].Time) then
        l__clear__6(u180);
        for v182 = #u72, 1, -1 do
            local v183 = u72[v182];
            local l__t__35 = v183.t;
            if l__t__35.Map == u37 and (l__t__35.Mode == u39 and l__t__35.Style == u40) then
                u180[l__t__35.User] = v183;
            else
                l__remove__8(u72, v182):Remove();
            end;
        end;
        for v184 = #p181, 1, -1 do
            local v185 = p181[v184];
            if v185.Map == u37 and (v185.Mode == u39 and v185.Style == u40) then
                local v186 = u180[v185.User];
                if v186 then
                    v186.t = v185;
                    v186[2].User = v185.User;
                    v186[3].Text = v185.Name;
                    v186[4].Text = u3(v185.Time);
                    l__remove__8(p181, v184);
                end;
            else
                l__remove__8(p181, v184);
            end;
        end;
        l__sort__5(u72, u166);
        local v187 = #u72;
        local v188 = #p181;
        local v189 = 0;
        local v190 = 1;
        local v191 = 1;
        local v192 = {};
        while v189 < 300 and (v190 <= v187 and v191 <= v188) do
            v189 = v189 + 1;
            local v193 = u72[v190];
            local v194 = p181[v191];
            if v193.t.Time < v194.Time then
                v192[v189] = v193;
                v190 = v190 + 1;
            else
                v192[v189] = u163(u45, v189, v194, true);
                v191 = v191 + 1;
            end;
        end;
        for v195 = v191, l__min__2(v188, v191 + 300 - v189) do
            v189 = v189 + 1;
            v192[v189] = u163(u45, v189, p181[v195], true);
        end;
        local v196 = l__min__2(v187, v190 + 300 - v189);
        for v197 = v190, v196 do
            v189 = v189 + 1;
            v192[v189] = u72[v197];
        end;
        for v198 = v196 + 1, v187 do
            u72[v198]:Remove();
        end;
        u72 = v192;
        u99();
    end;
end);
v9.Add("DeleteHighscore", function(p199) --[[ Line: 804 ]]
    -- upvalues: u36 (ref), u71 (copy), u72 (ref), l__remove__8 (copy), u99 (copy)
    if u36 then
        local v200 = u71[p199.User];
        if v200 then
            local v201 = u72[v200];
            if p199.ID == v201.t.ID then
                l__remove__8(u72, v200);
                v201:Remove();
            end;
        end;
        u99();
    end;
end);
v9.Add("DeleteHighscores", function(p202) --[[ Line: 819 ]]
    -- upvalues: u36 (ref), l__clear__6 (copy), u180 (copy), u72 (ref), l__remove__8 (copy), u99 (copy)
    if u36 then
        l__clear__6(u180);
        for v203 = 1, #p202 do
            u180[p202[v203].ID] = true;
        end;
        for v204 = #u72, 1, -1 do
            local v205 = u72[v204];
            if u180[v205.t.ID] then
                l__remove__8(u72, v204);
                v205:Remove();
            end;
        end;
        u99();
    end;
end);
local function u206() --[[ Line: 839 ]]
    -- upvalues: u31 (copy), u36 (ref), u26 (copy), l__FreeMouse__14 (copy), u28 (copy)
    u31.Text = "C";
    u36 = true;
    u26.Visible = true;
    l__FreeMouse__14("Highscores", true);
    u28:Target(u26.Parent.SizeY / 2 - u26.SizeY / 2);
end;
u25 = function() --[[ Name: ClosePanel, Line 846 ]]
    -- upvalues: u36 (ref), l__FreeMouse__14 (copy), u28 (copy), u26 (copy), u72 (ref), l__clear__6 (copy)
    u36 = false;
    l__FreeMouse__14("Highscores", false);
    u28:Target(-u26.SizeY, function() --[[ Line: 849 ]]
        -- upvalues: u72 (ref), l__clear__6 (ref), u26 (ref)
        for v207 = 1, #u72 do
            u72[v207]:Remove();
        end;
        l__clear__6(u72);
        u26.Visible = false;
    end);
end;
v8.Add("OpenWRList", function() --[[ Line: 858 ]]
    -- upvalues: u36 (ref), l__Call__19 (copy), u37 (ref), u39 (ref), u40 (ref), u38 (ref), u206 (ref)
    if not u36 then
        u36 = true;
        if u36 then
            l__Call__19("GetHighscores", u37, u39, u40, u38);
        end;
        u206();
    end;
end);
v11.Add("wr", {}, function() --[[ Line: 866 ]]
    -- upvalues: u36 (ref), l__Call__19 (copy), u37 (ref), u39 (ref), u40 (ref), u38 (ref), u206 (ref), u25 (ref)
    u36 = not u36;
    if u36 then
        if u36 then
            l__Call__19("GetHighscores", u37, u39, u40, u38);
        end;
        u206();
    else
        u25();
    end;
end);
v13.MapInfoChanged:Add(function(p208) --[[ Line: 876 ]]
    -- upvalues: u21 (ref), u36 (ref), u37 (ref), u58 (ref), l__AllMaps__25 (copy)
    local l__Id__36 = p208.Id;
    u21 = l__Id__36;
    if not u36 then
        u37 = l__Id__36;
        if u58 then
            for v209 = 1, #l__AllMaps__25 do
                if l__AllMaps__25[v209].AssetId == u37 then
                    u58.ChooseItem(v209);
                    return;
                end;
            end;
        end;
    end;
end);
v11.Add("wr", { "MapId" }, function(p210) --[[ Line: 892 ]]
    -- upvalues: u36 (ref), u206 (ref), u58 (ref), l__AllMaps__25 (copy)
    if not u36 then
        u206();
    end;
    if u58 then
        for v211 = 1, #l__AllMaps__25 do
            if l__AllMaps__25[v211].AssetId == p210 then
                u58.ChooseItem(v211);
                return;
            end;
        end;
    end;
end);
v12.ShowModerationSignal:Add(function() --[[ Line: 906 ]]
    -- upvalues: u54 (copy), l__Color__10 (copy), u57 (copy), u19 (ref)
    u54[1] = l__Color__10(224, 224, 224);
    u54[2] = l__Color__10(30, 30, 30);
    u54[3] = l__Color__10(255, 225, 53);
    u54[4] = l__Color__10(224, 30, 30);
    u57();
    u19 = true;
end);
v12.UserStatusChanged:Add(function(p212, p213) --[[ Line: 916 ]]
    -- upvalues: u71 (copy), u72 (ref), u38 (ref), l__remove__8 (copy), u99 (copy), u19 (ref), u54 (copy)
    local v214 = u71[p212];
    local v215 = v214 and u72[v214];
    if v215 then
        if not u38 and (p213 == 2 or (p213 == 3 or p213 == 4)) then
            v215:Remove();
            l__remove__8(u72, v214);
            u99();
            return;
        end;
        v215.t.State = p213;
        if u19 and (u38 and u54[p213]) then
            v215[2].DrawBackground = true;
            v215[2].BackgroundColor = u54[p213];
            return;
        end;
        v215[2].DrawBackground = false;
    end;
end);
return true;
