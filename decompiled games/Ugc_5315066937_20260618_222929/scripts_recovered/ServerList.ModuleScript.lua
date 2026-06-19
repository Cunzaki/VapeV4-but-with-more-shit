-- Decompiled from: ServerList
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__time__1 = os.time;
local u1 = tostring;
local l__min__2 = math.min;
local l__max__3 = math.max;
local l__floor__4 = math.floor;
local l__sort__5 = table.sort;
local l__clear__6 = table.clear;
local l__sub__7 = string.sub;
local l__upper__8 = string.upper;
local l__obtain__9 = _G.obtain;
local u2 = l__obtain__9("QBox");
local l__Color__10 = u2.Color;
local l__New__11 = u2.New;
local l__Image__12 = u2.Image;
local l__TextBox__13 = u2.TextBox;
local l__FreeMouse__14 = u2.FreeMouse;
local l__IsFreeingMouse__15 = u2.IsFreeingMouse;
local v3 = l__obtain__9("Tween");
local l__New__16 = v3.New;
local l__MaxAcceleration__17 = v3.MaxAcceleration;
local v4 = l__obtain__9("Local");
local v5 = l__obtain__9("Remote");
local l__Call__18 = v5.Call;
local v6 = l__obtain__9("Command");
local v7 = l__obtain__9("MapLists");
local l__GetCompletion__19 = v7.GetCompletion;
local u8 = nil;
local l__PlaceId__20 = game.PlaceId;
local l__userId__21 = l__obtain__9("PlayerManager").LocalPlayer.userId;
local l__TeleportService__22 = game:GetService("TeleportService");
local u9 = {
    [52250025] = true,
    [467315479] = true
};
local u10 = false;
local u11 = l__Color__10(137, 232, 148, 255);
local u12 = l__Color__10(97, 164, 105, 255);
local u13 = nil;
local l__PlaceId__23 = game.PlaceId;
local function v14() --[[ Line: 62 ]]
    -- upvalues: l__Call__18 (copy), l__PlaceId__23 (ref)
    l__Call__18("GetServerList", l__PlaceId__23);
end;
local u15 = l__New__11();
u15.Visible = false;
u15.BackgroundColor = l__Color__10(37.5, 37.5, 37.5, 255);
u15.SizeOffsetX = 450;
u15.SizeOffsetY = 600;
u15.PosScaleX = 0.5;
function u15.Resize() --[[ Line: 75 ]]
    -- upvalues: u15 (copy)
    u15.PosOffsetX = u15.SizeX / -2;
end;
local u17 = l__New__16(-u15.SizeY, function(p16) --[[ Line: 79 ]]
    -- upvalues: u15 (copy)
    u15.PosOffsetY = p16;
end);
u17.MaxAcceleration = l__MaxAcceleration__17(1080, 0, 0, 0, 1);
spawn(function() --[[ Line: 82 ]]
    -- upvalues: u15 (copy), u17 (copy)
    while u15.Parent.SizeY == 0 do
        wait();
    end;
    u17:Target(-u15.SizeY);
end);
function u15.Moved() --[[ Line: 89 ]]
    -- upvalues: u17 (copy), u15 (copy)
    if not u17.Tweening then
        u17.x1 = u15.PosOffsetY;
    end;
end;
local u18 = u2.Resizable(u15);
u18.ClipsDescendants = true;
u18.MinY = 240;
local u19 = l__TextBox__13(u18, "Server List");
u19.BackgroundColor = u2.Color1;
u19.TextAlignment = "Center";
u19.SizeScaleX = 1;
u19.SizeOffsetX = -60;
u19.SizeOffsetY = 30;
local u20 = l__TextBox__13(u18, "C");
u20.TextAlignment = "Center";
u20.TextSize = 12 * u2.roblox_messing_with_guis_factor;
u20.SizeOffsetX = 30;
u20.SizeOffsetY = 30;
u20.PosScaleX = 1;
u20.PosOffsetX = -60;
function u20.Button1Down() --[[ Line: 115 ]]
    -- upvalues: l__IsFreeingMouse__15 (copy), l__FreeMouse__14 (copy), u20 (copy)
    local v21 = not l__IsFreeingMouse__15("ServerList");
    l__FreeMouse__14("ServerList", v21);
    if v21 then
        u20.Text = "C";
    else
        u20.Text = "^";
    end;
end;
local v22 = l__TextBox__13(u18, "x");
v22.TextAlignment = "Center";
v22.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v22.SizeOffsetX = 30;
v22.SizeOffsetY = 30;
v22.PosScaleX = 1;
v22.PosOffsetX = -30;
function v22.Button1Down() --[[ Line: 134 ]]
    -- upvalues: u13 (ref)
    u13();
end;
u2.DragBar(u19, u15);
local u23 = {
    "Server Type",
    "ID",
    "Server Age",
    "",
    "Map",
    "Changed Map",
    "Players"
};
local v24 = l__New__11(u18);
v24.PosOffsetY = 60;
v24.SizeScaleX = 1;
v24.SizeOffsetY = 20;
v24.DrawBackground = false;
local u25 = u13;
local u26 = l__PlaceId__23;
local u27 = {};
for v28 = 1, #u23 do
    local v29 = l__TextBox__13(v24, u23[v28]);
    v29.TextAlignment = "Center";
    v29.SizeScaleY = 1;
    v29.SizeOffsetX = v29.TextSizeX + 10;
    u27[v28] = v29;
end;
local u30 = l__New__11(u18);
u30.DrawBackground = false;
u30.SizeScaleX = 1;
u30.SizeScaleY = 1;
u30.PosOffsetY = 80;
u30.SizeOffsetY = -80;
local u31 = l__New__11();
u2.Scroll(u31, u30);
local u32 = l__New__11(u18);
u32.SizeScaleX = 1;
u32.SizeOffsetY = 30;
u32.PosOffsetY = 30;
u32.DrawBackground = false;
local u33 = u2.TextBox(u32, "Teleport to Place");
u33.PosOffsetY = 5;
u33.SizeOffsetX = u33.TextSizeX + 10;
u33.PosOffsetX = 5;
u33.SizeOffsetY = 20;
function u33.Fade(p34) --[[ Line: 181 ]]
    -- upvalues: u33 (copy), u2 (copy), l__Color__10 (copy)
    local v35 = u33;
    local l__Color0__24 = u2.Color0;
    local l__Color1__25 = u2.Color1;
    local v36 = 1 - p34;
    v35.BackgroundColor = l__Color__10(l__Color0__24.r * v36 + l__Color1__25.r * p34, l__Color0__24.g * v36 + l__Color1__25.g * p34, l__Color0__24.b * v36 + l__Color1__25.b * p34, l__Color0__24.a * v36 + l__Color1__25.a * p34);
end;
function u33.Button1Down() --[[ Line: 184 ]]
    -- upvalues: l__TeleportService__22 (copy), u26 (ref)
    l__TeleportService__22:Teleport(u26);
end;
u33.Visible = u26 ~= l__PlaceId__20;
local u37 = nil;
v5.Add("SetGamePlaces", function(u38, p39, p40) --[[ Line: 190 ]]
    -- upvalues: u37 (ref), u2 (copy), u32 (copy), u26 (ref), u33 (copy), l__PlaceId__20 (copy), l__Call__18 (copy)
    u37 = u2.Dropdown(u32, p39, function(p41) --[[ Line: 191 ]]
        -- upvalues: u26 (ref), u38 (copy), u33 (ref), l__PlaceId__20 (ref), l__Call__18 (ref)
        u26 = u38[p41];
        u33.Visible = u26 ~= l__PlaceId__20;
        l__Call__18("GetServerList", u26);
    end, p40);
    u37.PosOffsetX = 5;
    u37.PosOffsetY = 5;
    u37.SizeOffsetY = 20;
    u37.SizeOffsetX = u37.GetWidth() + 10;
    u33.PosOffsetX = u37.PosOffsetX + u37.SizeX + 5;
end);
l__Call__18("GetGamePlaces");
v5.Add("SetServerID", function(p42) --[[ Line: 205 ]]
    -- upvalues: u19 (copy), l__upper__8 (copy), u1 (copy)
    u19.Text = "Server List (This server: " .. l__upper__8((u1(p42))) .. ")";
end);
l__Call__18("GetServerID");
local u43 = u2.TextBox(u32, "Refresh");
u43.PosOffsetY = 5;
u43.PosScaleX = 1;
u43.SizeOffsetX = u43.TextSizeX + 10;
u43.PosOffsetX = -5 - u43.SizeX;
u43.SizeOffsetY = 20;
function u43.Fade(p44) --[[ Line: 216 ]]
    -- upvalues: u43 (copy), u2 (copy), l__Color__10 (copy)
    local v45 = u43;
    local l__Color0__26 = u2.Color0;
    local l__Color1__27 = u2.Color1;
    local v46 = 1 - p44;
    v45.BackgroundColor = l__Color__10(l__Color0__26.r * v46 + l__Color1__27.r * p44, l__Color0__26.g * v46 + l__Color1__27.g * p44, l__Color0__26.b * v46 + l__Color1__27.b * p44, l__Color0__26.a * v46 + l__Color1__27.a * p44);
end;
u43.Button1Down = v14;
local u47 = l__Image__12(u15, nil);
u47.Visible = false;
u47.DrawBackground = false;
u47.SizeOffsetX = 500;
u47.SizeOffsetY = 500;
function u47.Think() --[[ Line: 226 ]]
    -- upvalues: u47 (copy), u2 (copy)
    local l__Target__28 = u47.Target;
    if l__Target__28 then
        local l__MouseX__29 = u2.MouseX;
        local l__MouseY__30 = u2.MouseY;
        if l__MouseX__29 < l__Target__28.PosX or (l__Target__28.PosX + l__Target__28.SizeX < l__MouseX__29 or (l__MouseY__30 < l__Target__28.PosY or l__Target__28.PosY + l__Target__28.SizeY < l__MouseY__30)) then
            u47.Visible = false;
        end;
    end;
end;
u47.ZIndex = 6;
function u47.MouseWheeled(p48) --[[ Line: 236 ]]
    -- upvalues: u30 (copy)
    u30.MouseWheeled(p48 * 30 / (0.2 * u30.SizeY));
end;
local u49 = l__TextBox__13(u47, "");
u49.DrawBackground = false;
u49.TextAlignment = "Center";
u49.TextSize = 18;
u49.PosScaleY = 1;
u49.PosOffsetY = -60;
u49.SizeScaleX = 1;
u49.SizeOffsetY = 60;
u49.ZIndex = 6;
local u50 = {};
local function u74() --[[ Line: 252 ]]
    -- upvalues: u27 (copy), u50 (copy), l__sub__7 (copy), l__upper__8 (copy), u23 (copy), u31 (copy), u18 (copy), u19 (copy), l__max__3 (copy)
    local v51 = {};
    for v52 = 1, #u27 do
        v51[v52] = u27[v52].TextSizeX + 10;
    end;
    local v53 = 4;
    local v54 = {};
    local v55 = {};
    for v56 = v53, 36 do
        v54[v56] = {};
    end;
    for v57 = 1, #u50 do
        local l__ID__31 = u50[v57].t.ID;
        local v58 = v53;
        for v59 = v53, 36 do
            if v54[v59][l__sub__7(l__ID__31, 1, v59)] then
                v55[v59] = true;
                v53 = nil;
            end;
        end;
        if not v53 then
            for v60 = v58, 36 do
                if not v55[v60] then
                    v53 = v60;
                    break;
                end;
            end;
        end;
    end;
    for v61 = 1, #u50 do
        local v62 = u50[v61];
        v62.ServerID.Text = l__upper__8((l__sub__7(v62.t.ID, 1, v53))) .. (v53 == 36 and "" or "...");
        v62.PY:Target((v61 - 1) * 30);
        for v63 = 1, #u23 do
            local v64 = v62[v63].TextSizeX + 10;
            if v51[v63] < v64 then
                v51[v63] = v64;
            end;
        end;
    end;
    local v65 = { 0 };
    for v66 = 1, #u23 do
        local v67 = v51[v66];
        local v68 = v65[v66];
        v65[v66 + 1] = v68 + v67;
        local v69 = u27[v66];
        v69.SizeOffsetX = v67;
        v69.PosOffsetX = v68;
    end;
    u31.SizeOffsetX = v65[#v65];
    u31.SizeOffsetY = #u50 * 30;
    u18.MinX = l__max__3(v65[#v65], u19.TextSizeX + 70);
    for v70 = 1, #u50 do
        local v71 = u50[v70];
        for v72 = 1, #u23 do
            local v73 = v71[v72];
            v73.SizeOffsetX = v51[v72];
            v73.PosOffsetX = v65[v72];
        end;
    end;
end;
local u75 = { function(_) --[[ Line: 328 ]]
        return "Meme";
    end };
local u76 = { function(_) --[[ Line: 333 ]] end };
local u77 = nil;
local function u92(u78, p79, p80) --[[ Line: 339 ]]
    -- upvalues: u77 (ref), l__New__11 (copy), u76 (copy), u75 (copy), l__TextBox__13 (copy), u2 (copy), l__max__3 (copy), l__Color__10 (copy), l__min__2 (copy)
    if u77 then
        u77:Remove();
    end;
    local u81 = l__New__11();
    local v82 = {};
    local v83 = 0;
    local v84 = false;
    for v85 = 1, #u76 do
        local v86 = u75[v85](u78);
        if v86 then
            local u87 = u76[v85];
            local u88 = l__TextBox__13(u81, v86);
            u88.TextAlignment = "Center";
            u88.BackgroundColor = u2.Color0;
            v83 = l__max__3(v83, 10 + u88.TextSizeX);
            u88.SizeScaleX = 1;
            u88.SizeOffsetY = 20;
            u88.PosOffsetY = #v82 * 20;
            function u88.Button1Down() --[[ Line: 359 ]]
                -- upvalues: u78 (copy), u87 (copy), u81 (copy), u77 (ref)
                if u78 then
                    u87(u78);
                end;
                u81:Remove();
                u77 = nil;
            end;
            function u88.Fade(p89) --[[ Line: 366 ]]
                -- upvalues: u88 (copy), u2 (ref), l__Color__10 (ref)
                local v90 = u88;
                local l__Color0__32 = u2.Color0;
                local l__Color2__33 = u2.Color2;
                local v91 = 1 - p89;
                v90.BackgroundColor = l__Color__10(l__Color0__32.r * v91 + l__Color2__33.r * p89, l__Color0__32.g * v91 + l__Color2__33.g * p89, l__Color0__32.b * v91 + l__Color2__33.b * p89, l__Color0__32.a * v91 + l__Color2__33.a * p89);
            end;
            v82[#v82 + 1] = u88;
            v84 = true;
        end;
    end;
    if v84 then
        u81.SizeOffsetX = v83;
        u81.SizeOffsetY = #v82 * 20;
        u81.PosOffsetX = l__max__3(0, (l__min__2(u81.Parent.SizeX - u81.SizeX, p79)));
        u81.PosOffsetY = l__max__3(0, (l__min__2(u81.Parent.SizeY - u81.SizeY, p80)));
        function u81.MouseLeave() --[[ Line: 377 ]]
            -- upvalues: u81 (copy), u77 (ref)
            u81:Remove();
            u77 = nil;
        end;
        u77 = u81;
    else
        u81:Remove();
    end;
end;
local function u136(p93, u94) --[[ Line: 387 ]]
    -- upvalues: l__New__11 (copy), u31 (copy), l__TextBox__13 (copy), l__upper__8 (copy), l__time__1 (copy), l__floor__4 (copy), l__Image__12 (copy), u49 (copy), u47 (copy), u15 (copy), u2 (copy), l__New__16 (copy), l__MaxAcceleration__17 (copy), l__userId__21 (copy), u9 (copy), u10 (ref), l__Call__18 (copy), u25 (ref), u8 (ref), u11 (copy), u12 (copy), l__Color__10 (copy), u92 (copy)
    local u95 = l__New__11(u31);
    u95.SizeScaleX = 1;
    u95.SizeOffsetY = 30;
    local v96 = l__TextBox__13(u95, u94.ServerType == 2 and u94.ServerOwnerName .. "\'s Scripted Server" or (u94.ServerType == 1 and (u94.ServerOwnerName .. "\'s Private Server" or "Public Server") or "Public Server"));
    v96.DrawBackground = false;
    v96.TextAlignment = "Center";
    v96.SizeScaleY = 1;
    v96.SizeOffsetX = v96.TextSizeX + 10;
    local v97 = 0 + 1;
    u95[v97] = v96;
    local v98 = 0 + v96.SizeX;
    local v99 = l__TextBox__13(u95, l__upper__8(u94.ID));
    u95.ServerID = v99;
    v99.DrawBackground = false;
    v99.TextAlignment = "Center";
    v99.SizeScaleY = 1;
    v99.SizeOffsetX = v99.TextSizeX + 10;
    v99.PosOffsetX = v98;
    local v100 = v97 + 1;
    u95[v100] = v99;
    local v101 = v98 + v99.SizeX;
    local u102 = l__TextBox__13(u95, "yes");
    u102.DrawBackground = false;
    u102.SizeOffsetX = 30;
    u102.SizeScaleY = 1;
    u102.PosOffsetX = v101;
    function u102.Think() --[[ Line: 416 ]]
        -- upvalues: u94 (copy), l__time__1 (ref), l__floor__4 (ref), u102 (copy)
        if u94.MapDate then
            local v103 = l__time__1() - u94.StartTime;
            local v104 = v103 < 0 and 0 or v103;
            local v105, v106;
            if v104 < 60 then
                v105 = "second";
                v106 = 1;
            elseif v104 < 3600 then
                v105 = "minute";
                v106 = 60;
            elseif v104 < 86400 then
                v105 = "hour";
                v106 = 3600;
            elseif v104 < 604800 then
                v105 = "day";
                v106 = 86400;
            elseif v104 < 2628000 then
                v105 = "week";
                v106 = 604800;
            elseif v104 < 31536000 then
                v105 = "month";
                v106 = 2628000;
            else
                v105 = "year";
                v106 = 31536000;
            end;
            if v105 then
                local v107 = l__floor__4(v104 / v106);
                u102.Text = v107 .. " " .. v105 .. ((v107 == 1 or v105 == "ms") and "" or "s");
            end;
        end;
    end;
    u102.Think();
    local v108 = v100 + 1;
    u95[v108] = u102;
    local v109 = v101 + u102.SizeX;
    local l__MapID__34 = u94.MapID;
    local l__Thumbnail__35 = u94.Thumbnail;
    local u110;
    if l__Thumbnail__35 then
        u110 = l__Image__12(u95, "rbxassetid://" .. l__Thumbnail__35);
        function u110.MouseEnter() --[[ Line: 467 ]]
            -- upvalues: u49 (ref), u94 (copy), u47 (ref), u110 (ref), u15 (ref), u95 (copy)
            u49.Text = u94.MapName;
            u47.Image = u110.Image;
            u47.Target = u110;
            u47.Visible = true;
            u47.PosOffsetX = u110.PosX - u15.PosX + (u110.SizeX - u47.SizeX) / 2;
            u47.PosOffsetY = u110.PosY - u15.PosY + (u110.SizeY - u47.SizeY) / 2;
            u47.Button1Down = u95.Button1Down;
        end;
        u110.DrawBackground = false;
        u110.SizeOffsetX = 30;
        u110.SizeScaleY = 1;
        u110.TextSizeX = 20;
    else
        u110 = l__New__11(u95);
        u110.TextSizeX = 20;
    end;
    local v111 = v108 + 1;
    u95[v111] = u110;
    local v112 = v109 + u110.SizeX;
    local u113 = l__TextBox__13(u95, u94.MapName or "Unreadchable");
    u113.DrawBackground = false;
    u113.SizeOffsetX = 30;
    u113.SizeScaleY = 1;
    u113.PosOffsetX = v112;
    local v114 = v111 + 1;
    u95[v114] = u113;
    local v115 = v112 + u113.SizeX;
    local u116 = l__TextBox__13(u95, "hi");
    u116.DrawBackground = false;
    u116.TextAlignment = "Center";
    u116.TextSize = 12 * u2.roblox_messing_with_guis_factor;
    u116.SizeScaleY = 1;
    u116.SizeOffsetX = u116.TextSizeX + 10;
    u116.PosOffsetX = v115;
    function u116.Think() --[[ Line: 505 ]]
        -- upvalues: u94 (copy), l__time__1 (ref), l__floor__4 (ref), u116 (copy)
        if u94.MapDate then
            local v117 = l__time__1() - u94.MapDate;
            local v118 = v117 < 0 and 0 or v117;
            local v119, v120;
            if v118 < 60 then
                v119 = "second";
                v120 = 1;
            elseif v118 < 3600 then
                v119 = "minute";
                v120 = 60;
            elseif v118 < 86400 then
                v119 = "hour";
                v120 = 3600;
            elseif v118 < 604800 then
                v119 = "day";
                v120 = 86400;
            elseif v118 < 2628000 then
                v119 = "week";
                v120 = 604800;
            elseif v118 < 31536000 then
                v119 = "month";
                v120 = 2628000;
            else
                v119 = "year";
                v120 = 31536000;
            end;
            if v119 then
                local v121 = l__floor__4(v118 / v120);
                u116.Text = v121 .. " " .. v119 .. ((v121 == 1 or v119 == "ms") and "" or "s");
            end;
        end;
    end;
    u116.Think();
    local v122 = v114 + 1;
    u95[v122] = u116;
    local v123 = v115 + u116.SizeX;
    local v124 = l__TextBox__13(u95, u94.PlayerCount or "0");
    v124.DrawBackground = false;
    v124.TextAlignment = "Center";
    v124.TextSize = 12 * u2.roblox_messing_with_guis_factor;
    v124.SizeScaleY = 1;
    v124.SizeOffsetX = v124.TextSizeX + 10;
    v124.PosOffsetX = v123;
    u95[v122 + 1] = v124;
    local _ = v123 + v124.SizeX;
    local u126 = l__New__16(30 * (p93 - 1), function(p125) --[[ Line: 562 ]]
        -- upvalues: u95 (copy)
        u95.PosOffsetY = p125;
    end);
    u126.MaxAcceleration = l__MaxAcceleration__17(0, 30, 0, 0, 2);
    u95.PY = u126;
    u95.t = u94;
    if (u94.ServerOwnerID == nil or u94.ServerOwnerID == l__userId__21) and true or u9[l__userId__21] then
        function u95.Button1Down() --[[ Line: 568 ]]
            -- upvalues: u10 (ref), l__Call__18 (ref), u94 (copy), u25 (ref)
            if u10 then
                l__Call__18("TeleportToID", u94.ID);
                u25();
            end;
        end;
        function u95.Fade(p127) --[[ Line: 574 ]]
            -- upvalues: u8 (ref), l__MapID__34 (copy), u113 (copy), u11 (ref), u12 (ref), l__Color__10 (ref), u95 (copy), u2 (ref)
            if u8 and u8[l__MapID__34] then
                u113.DrawBackground = true;
                local v128 = u113;
                local v129 = u11;
                local v130 = u12;
                local v131 = 1 - p127;
                v128.BackgroundColor = l__Color__10(v129.r * v131 + v130.r * p127, v129.g * v131 + v130.g * p127, v129.b * v131 + v130.b * p127, v129.a * v131 + v130.a * p127);
            end;
            local v132 = u95;
            local l__Color1__36 = u2.Color1;
            local l__Color2__37 = u2.Color2;
            local v133 = 1 - p127;
            v132.BackgroundColor = l__Color__10(l__Color1__36.r * v133 + l__Color2__37.r * p127, l__Color1__36.g * v133 + l__Color2__37.g * p127, l__Color1__36.b * v133 + l__Color2__37.b * p127, l__Color1__36.a * v133 + l__Color2__37.a * p127);
        end;
    end;
    function u95.Button2Down(p134, p135) --[[ Line: 582 ]]
        -- upvalues: u92 (ref), u95 (copy)
        u92(u95, u95.PosX + p134 + 1, u95.PosY + p135 + 1);
    end;
    function u95.Removed() --[[ Line: 585 ]]
        -- upvalues: u126 (copy)
        u126:Remove();
    end;
    return u95;
end;
local function u139() --[[ Line: 591 ]]
    -- upvalues: u50 (copy)
    for v137 = 1, #u50 do
        local v138 = u50[v137];
        if v138.Fade then
            v138.Fade(v138.FadeTween:Value());
        end;
    end;
end;
v7.CompletionUpdated:Add(u139);
local function u140() --[[ Line: 602 ]]
    -- upvalues: u20 (copy), u10 (ref), u15 (copy), l__FreeMouse__14 (copy), u17 (copy), u8 (ref), l__GetCompletion__19 (copy), u139 (copy)
    u20.Text = "C";
    u10 = true;
    u15.Visible = true;
    l__FreeMouse__14("ServerList", true);
    u17:Target(u15.Parent.SizeY / 2 - u15.SizeY / 2);
    if not u8 then
        u8 = l__GetCompletion__19();
        u139();
    end;
end;
u13 = function() --[[ Name: ClosePanel, Line 613 ]]
    -- upvalues: u10 (ref), l__FreeMouse__14 (copy), u17 (copy), u15 (copy), u50 (copy), l__clear__6 (copy)
    u10 = false;
    l__FreeMouse__14("ServerList", false);
    u17:Target(-u15.SizeY, function() --[[ Line: 616 ]]
        -- upvalues: u50 (ref), l__clear__6 (ref), u15 (ref)
        for v141 = 1, #u50 do
            u50[v141]:Remove();
        end;
        l__clear__6(u50);
        u15.Visible = false;
    end);
end;
v5.Add("SetServerList", function(p142) --[[ Line: 625 ]]
    -- upvalues: u50 (copy), l__clear__6 (copy), u33 (copy), u26 (ref), l__PlaceId__20 (copy), l__sort__5 (copy), u136 (copy), u74 (copy)
    if p142 then
        for v143 = 1, #u50 do
            u50[v143]:Remove();
        end;
        l__clear__6(u50);
        if #p142 == 0 then
            u33.Visible = u26 ~= l__PlaceId__20;
        else
            u33.Visible = false;
            l__sort__5(p142, function(p144, p145) --[[ Line: 635 ]]
                if p144 and p145 then
                    if p144.ServerType == p145.ServerType then
                        if p144.ServerOwnerID == p145.ServerOwnerID or not (p144.ServerOwnerID and p145.ServerOwnerID) then
                            if p144.PlayerCount == p145.PlayerCount then
                                if p144.StartTime == p145.StartTime then
                                    return p144.ID < p145.ID;
                                else
                                    return p144.StartTime > p145.StartTime;
                                end;
                            else
                                return p144.PlayerCount > p145.PlayerCount;
                            end;
                        else
                            return p144.ServerOwnerID < p145.ServerOwnerID;
                        end;
                    else
                        return p144.ServerType < p145.ServerType;
                    end;
                end;
            end);
            for v146 = 1, #p142 do
                u50[v146] = u136(v146, p142[v146]);
            end;
        end;
        u74();
    else
        print("[ServerList] Received no server list!");
    end;
end);
v4.Add("OpenServerList", function() --[[ Line: 667 ]]
    -- upvalues: u10 (ref), l__Call__18 (copy), u26 (ref), u140 (ref)
    if not u10 then
        l__Call__18("GetServerList", u26);
        u140();
    end;
end);
v6.Add({ "serverlist", "sl" }, {}, function() --[[ Line: 674 ]]
    -- upvalues: u10 (ref), l__Call__18 (copy), u26 (ref), u140 (ref), u13 (ref)
    u10 = not u10;
    if u10 then
        l__Call__18("GetServerList", u26);
        u140();
    else
        u13();
    end;
end);
return true;
