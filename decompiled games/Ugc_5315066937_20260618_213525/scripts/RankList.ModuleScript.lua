-- Decompiled from: RankList
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local u1 = tick;
local l__obtain__1 = _G.obtain;
local u2 = tostring;
local l__min__2 = math.min;
local l__max__3 = math.max;
local l__clear__4 = table.clear;
local l__format__5 = string.format;
local l__ToDate__6 = l__obtain__1("DateTime").ToDate;
local u3 = l__obtain__1("QBox");
local l__Color__7 = u3.Color;
local l__New__8 = u3.New;
local l__Avatar__9 = u3.Avatar;
local l__TextBox__10 = u3.TextBox;
local l__FreeMouse__11 = u3.FreeMouse;
local l__IsFreeingMouse__12 = u3.IsFreeingMouse;
local v4 = l__obtain__1("Tween");
local l__New__13 = v4.New;
local l__MaxAcceleration__14 = v4.MaxAcceleration;
local v5 = l__obtain__1("Remote");
local l__Call__15 = v5.Call;
local v6 = l__obtain__1("Styles");
local l__TypeNames__16 = v6.TypeNames;
local l__TypeNumberToId__17 = v6.TypeNumberToId;
local v7 = l__obtain__1("Command");
local v8 = false;
local v9 = 1;
local l__DefaultStyle__18 = v6.DefaultStyle;
local u10 = l__obtain__1("GetRankName");
local function u12(p11) --[[ Line: 46 ]]
    return p11 < 35 and "F-" or (p11 < 42 and "F" or (p11 < 50 and "F+" or (p11 < 53 and "D-" or (p11 < 57 and "D" or (p11 < 60 and "D+" or (p11 < 63 and "C-" or (p11 < 67 and "C" or (p11 < 70 and "C+" or (p11 < 73 and "B-" or (p11 < 77 and "B" or (p11 < 80 and "B+" or (p11 < 85 and "A-" or (p11 < 90 and "A" or (p11 < 100 and "A+" or "A++"))))))))))))));
end;
local u13 = nil;
local u14 = nil;
local u15 = l__New__8();
u15.Visible = false;
u15.BackgroundColor = l__Color__7(37.5, 37.5, 37.5, 255);
u15.SizeOffsetX = 450;
u15.SizeOffsetY = 600;
u15.PosScaleX = 0.5;
function u15.Resize() --[[ Line: 73 ]]
    -- upvalues: u15 (copy)
    u15.PosOffsetX = u15.SizeX / -2;
end;
local u17 = l__New__13(-u15.SizeY, function(p16) --[[ Line: 77 ]]
    -- upvalues: u15 (copy)
    u15.PosOffsetY = p16;
end);
u17.MaxAcceleration = l__MaxAcceleration__14(1080, 0, 0, 0, 1);
spawn(function() --[[ Line: 80 ]]
    -- upvalues: u15 (copy), u17 (copy)
    while u15.Parent.SizeY == 0 do
        wait();
    end;
    u17:Target(-u15.SizeY);
end);
function u15.Moved() --[[ Line: 87 ]]
    -- upvalues: u17 (copy), u15 (copy)
    if not u17.Tweening then
        u17.x1 = u15.PosOffsetY;
    end;
end;
local u18 = u3.Resizable(u15);
u18.ClipsDescendants = true;
u18.MinY = 240;
local u19 = l__TextBox__10(u18, "Top 100");
u19.BackgroundColor = u3.Color1;
u19.TextAlignment = "Center";
u19.SizeScaleX = 1;
u19.SizeOffsetX = -60;
u19.SizeOffsetY = 30;
local u20 = l__TextBox__10(u18, "C");
u20.TextAlignment = "Center";
u20.TextSize = 12 * u3.roblox_messing_with_guis_factor;
u20.SizeOffsetX = 30;
u20.SizeOffsetY = 30;
u20.PosScaleX = 1;
u20.PosOffsetX = -60;
function u20.Button1Down() --[[ Line: 113 ]]
    -- upvalues: l__IsFreeingMouse__12 (copy), l__FreeMouse__11 (copy), u20 (copy)
    local v21 = not l__IsFreeingMouse__12("Ranks");
    l__FreeMouse__11("Ranks", v21);
    if v21 then
        u20.Text = "C";
    else
        u20.Text = "^";
    end;
end;
local v22 = l__TextBox__10(u18, "x");
v22.TextAlignment = "Center";
v22.TextSize = 12 * u3.roblox_messing_with_guis_factor;
v22.SizeOffsetX = 30;
v22.SizeOffsetY = 30;
v22.PosScaleX = 1;
v22.PosOffsetX = -30;
function v22.Button1Down() --[[ Line: 132 ]]
    -- upvalues: u14 (ref)
    u14();
end;
u3.DragBar(u19, u15);
local u23 = {
    "#",
    "",
    "Username",
    "Rank",
    "Skill"
};
local v24 = l__New__8(u18);
v24.PosOffsetY = 60;
v24.SizeScaleX = 1;
v24.SizeOffsetY = 20;
v24.DrawBackground = false;
local u25 = u14;
local u26 = v9;
local u27 = v8;
local u28 = l__DefaultStyle__18;
local u29 = {};
for v30 = 1, #u23 do
    local v31 = l__TextBox__10(v24, u23[v30]);
    v31.TextAlignment = "Center";
    v31.SizeScaleY = 1;
    v31.SizeOffsetX = v31.TextSizeX + 10;
    u29[v30] = v31;
end;
local v32 = l__New__8(u18);
v32.DrawBackground = false;
v32.SizeScaleX = 1;
v32.SizeScaleY = 1;
v32.PosOffsetY = 80;
v32.SizeOffsetY = -80;
local u33 = l__New__8();
u3.Scroll(u33, v32);
local v34 = l__New__8(u18);
v34.SizeScaleX = 1;
v34.SizeOffsetY = 30;
v34.PosOffsetY = 30;
v34.DrawBackground = false;
local v36 = u3.Dropdown(v34, { "Rank", "Skill" }, function(p35) --[[ Line: 173 ]]
    -- upvalues: u26 (ref), u27 (ref), l__Call__15 (copy), u28 (ref)
    u26 = p35;
    if u27 then
        l__Call__15("GetRankList", u26, u28);
    end;
end, "Rank");
v36.PosOffsetX = 5;
v36.PosOffsetY = 5;
v36.SizeOffsetY = 20;
v36.SizeOffsetX = v36.GetWidth() + 10;
local v38 = u3.Dropdown(v34, l__TypeNames__16, function(p37) --[[ Line: 183 ]]
    -- upvalues: u28 (ref), l__TypeNumberToId__17 (copy), u27 (ref), l__Call__15 (copy), u26 (ref)
    u28 = l__TypeNumberToId__17[p37];
    if u27 then
        l__Call__15("GetRankList", u26, u28);
    end;
end, l__TypeNames__16[1]);
v38.PosOffsetY = 5;
v38.SizeOffsetY = 20;
v38.SizeOffsetX = v38.GetWidth() + 10;
v38.PosOffsetX = -5 - v38.SizeX;
v38.PosScaleX = 1;
u15.SizeOffsetX = 25 + v36.SizeX + v38.SizeX;
local u39 = {};
local function u55() --[[ Line: 197 ]]
    -- upvalues: u29 (copy), u39 (copy), u2 (copy), u23 (copy), u33 (copy), u18 (copy), u19 (copy), l__max__3 (copy)
    local v40 = {};
    for v41 = 1, #u29 do
        v40[v41] = u29[v41].TextSizeX + 10;
    end;
    for v42 = 1, #u39 do
        local v43 = u39[v42];
        v43[1].Text = u2(v42) .. ".";
        v43.PY:Target((v42 - 1) * 30);
        for v44 = 1, #u23 do
            local v45 = v44 == 2 and v43[v44].SizeX or v43[v44].TextSizeX + 10;
            if v40[v44] < v45 then
                v40[v44] = v45;
            end;
        end;
    end;
    local v46 = { 0 };
    for v47 = 1, #u23 do
        local v48 = v40[v47];
        local v49 = v46[v47];
        v46[v47 + 1] = v49 + v48;
        local v50 = u29[v47];
        v50.SizeOffsetX = v48;
        v50.PosOffsetX = v49;
    end;
    u33.SizeOffsetX = v46[#v46];
    u33.SizeOffsetY = #u39 * 30;
    u18.MinX = l__max__3(v46[#v46], u19.TextSizeX + 70);
    for v51 = 1, #u39 do
        local v52 = u39[v51];
        for v53 = 1, #u23 do
            local v54 = v52[v53];
            v54.SizeOffsetX = v40[v53];
            v54.PosOffsetX = v46[v53];
        end;
    end;
end;
local u56 = {};
local u57 = {};
local u58 = nil;
local function u73(u59, p60, p61) --[[ Line: 251 ]]
    -- upvalues: u58 (ref), l__New__8 (copy), u57 (copy), u56 (copy), l__TextBox__10 (copy), u3 (copy), l__max__3 (copy), l__Color__7 (copy), l__min__2 (copy)
    if u58 then
        u58:Remove();
    end;
    local u62 = l__New__8();
    local v63 = {};
    local v64 = 0;
    local v65 = false;
    for v66 = 1, #u57 do
        local v67 = u56[v66](u59);
        if v67 then
            local u68 = u57[v66];
            local u69 = l__TextBox__10(u62, v67);
            u69.TextAlignment = "Center";
            u69.BackgroundColor = u3.Color0;
            v64 = l__max__3(v64, 10 + u69.TextSizeX);
            u69.SizeScaleX = 1;
            u69.SizeOffsetY = 20;
            u69.PosOffsetY = #v63 * 20;
            function u69.Button1Down() --[[ Line: 271 ]]
                -- upvalues: u59 (copy), u68 (copy), u62 (copy), u58 (ref)
                if u59 then
                    u68(u59);
                end;
                u62:Remove();
                u58 = nil;
            end;
            function u69.Fade(p70) --[[ Line: 278 ]]
                -- upvalues: u69 (copy), u3 (ref), l__Color__7 (ref)
                local v71 = u69;
                local l__Color0__19 = u3.Color0;
                local l__Color2__20 = u3.Color2;
                local v72 = 1 - p70;
                v71.BackgroundColor = l__Color__7(l__Color0__19.r * v72 + l__Color2__20.r * p70, l__Color0__19.g * v72 + l__Color2__20.g * p70, l__Color0__19.b * v72 + l__Color2__20.b * p70, l__Color0__19.a * v72 + l__Color2__20.a * p70);
            end;
            v63[#v63 + 1] = u69;
            v65 = true;
        end;
    end;
    if v65 then
        u62.SizeOffsetX = v64;
        u62.SizeOffsetY = #v63 * 20;
        u62.PosOffsetX = l__max__3(0, (l__min__2(u62.Parent.SizeX - u62.SizeX, p60)));
        u62.PosOffsetY = l__max__3(0, (l__min__2(u62.Parent.SizeY - u62.SizeY, p61)));
        function u62.MouseLeave() --[[ Line: 289 ]]
            -- upvalues: u62 (copy), u58 (ref)
            u62:Remove();
            u58 = nil;
        end;
        u58 = u62;
    else
        u62:Remove();
    end;
end;
local function u92(p74, p75) --[[ Line: 299 ]]
    -- upvalues: l__New__8 (copy), u33 (copy), l__TextBox__10 (copy), u2 (copy), l__Avatar__9 (copy), u3 (copy), u10 (copy), u12 (copy), l__format__5 (copy), l__New__13 (copy), l__MaxAcceleration__14 (copy), u73 (copy)
    local u76 = l__New__8(u33);
    u76.SizeScaleX = 1;
    u76.SizeOffsetY = 30;
    local v77 = 0;
    local v78 = l__TextBox__10(u76, u2(p74) .. ".");
    v78.DrawBackground = false;
    v78.TextAlignment = "Center";
    v78.SizeScaleY = 1;
    v78.SizeOffsetX = v78.TextSizeX + 10;
    v78.PosOffsetX = v77;
    u76[1] = v78;
    local v79 = v77 + v78.SizeX;
    local v80 = l__Avatar__9(u76, p75.UserID);
    v80.DrawBackground = false;
    v80.SizeOffsetX = 30;
    v80.SizeScaleY = 1;
    v80.PosOffsetX = v79;
    u76[2] = v80;
    local v81 = v79 + v80.SizeX;
    local v82 = l__TextBox__10(u76, p75.Username);
    v82.DrawBackground = false;
    v82.TextAlignment = "Center";
    v82.TextSize = 12 * u3.roblox_messing_with_guis_factor;
    v82.SizeScaleY = 1;
    v82.SizeOffsetX = v82.TextSizeX + 10;
    v82.PosOffsetX = v81;
    u76[3] = v82;
    local v83 = v81 + v82.SizeX;
    local v84, _ = u10(p75.Rank, true);
    local v85 = l__TextBox__10(u76, v84);
    v85.DrawBackground = false;
    v85.TextAlignment = "Center";
    v85.TextSize = 12 * u3.roblox_messing_with_guis_factor;
    v85.SizeScaleY = 1;
    v85.SizeOffsetX = v85.TextSizeX + 10;
    v85.PosOffsetX = v83;
    u76[4] = v85;
    local v86 = v83 + v85.SizeX;
    local v87 = l__TextBox__10(u76, u12(100 * p75.Skill) .. " (" .. l__format__5("%.3f", 100 * p75.Skill) .. "%)");
    v87.DrawBackground = false;
    v87.TextAlignment = "Center";
    v87.TextSize = 12 * u3.roblox_messing_with_guis_factor;
    v87.SizeScaleY = 1;
    v87.SizeOffsetX = v87.TextSizeX + 10;
    v87.PosOffsetX = v86;
    u76[5] = v87;
    local _ = v86 + v87.SizeX;
    local u89 = l__New__13(30 * (p74 - 1), function(p88) --[[ Line: 353 ]]
        -- upvalues: u76 (copy)
        u76.PosOffsetY = p88;
    end);
    u89.MaxAcceleration = l__MaxAcceleration__14(0, 30, 0, 0, 2);
    u76.PY = u89;
    u76.t = p75;
    function u76.Button2Down(p90, p91) --[[ Line: 357 ]]
        -- upvalues: u73 (ref), u76 (copy)
        u73(u76, u76.PosX + p90 + 1, u76.PosY + p91 + 1);
    end;
    function u76.Removed() --[[ Line: 360 ]]
        -- upvalues: u89 (copy)
        u89:Remove();
    end;
    return u76;
end;
v5.Add("SetRankList", function(p93, p94) --[[ Line: 374 ]]
    -- upvalues: u19 (copy), l__ToDate__6 (copy), u1 (copy), u39 (copy), l__clear__4 (copy), u92 (copy), u55 (copy)
    if p94 then
        u19.Text = "Top 100 - Updated At " .. l__ToDate__6(u1() + p94, true, false, false, false, false, false);
    end;
    if p93 then
        for v95 = 1, #u39 do
            u39[v95]:Remove();
        end;
        l__clear__4(u39);
        for v96 = 1, #p93 do
            u39[v96] = u92(v96, p93[v96]);
        end;
        u55();
    else
        print("[Ranks] User times were missing!");
    end;
end);
v7.Add("ranks", {}, function() --[[ Line: 395 ]]
    -- upvalues: u27 (ref), u25 (ref), u13 (ref), l__Call__15 (copy), u26 (ref), u28 (ref)
    if u27 then
        u25();
    else
        u13();
        if u27 then
            l__Call__15("GetRankList", u26, u28);
        end;
    end;
end);
local function _() --[[ Line: 404 ]]
    -- upvalues: u20 (copy), u27 (ref), u15 (copy), l__FreeMouse__11 (copy), u17 (copy)
    u20.Text = "C";
    u27 = true;
    u15.Visible = true;
    l__FreeMouse__11("Ranks", true);
    u17:Target(u15.Parent.SizeY / 2 - u15.SizeY / 2);
end;
u14 = function() --[[ Name: ClosePanel, Line 411 ]]
    -- upvalues: u27 (ref), l__FreeMouse__11 (copy), u17 (copy), u15 (copy), u39 (copy), l__clear__4 (copy)
    u27 = false;
    l__FreeMouse__11("Ranks", false);
    u17:Target(-u15.SizeY, function() --[[ Line: 414 ]]
        -- upvalues: u39 (ref), l__clear__4 (ref), u15 (ref)
        for v97 = 1, #u39 do
            u39[v97]:Remove();
        end;
        l__clear__4(u39);
        u15.Visible = false;
    end);
end;
return true;
