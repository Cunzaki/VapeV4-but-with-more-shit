-- Decompiled from: HUD
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local _ = math.min;
local l__max__2 = math.max;
local l__format__3 = string.format;
local l__obtain__4 = _G.obtain;
local u1 = l__obtain__4("GetFormattedTime");
local u2 = l__obtain__4("QBox");
local l__New__5 = u2.New;
local l__TextBox__6 = u2.TextBox;
local l__Image__7 = u2.Image;
local l__Color__8 = u2.Color;
local l__ColourLerp__9 = u2.ColourLerp;
local v3 = l__obtain__4("Tween");
local v4 = l__obtain__4("Local");
local l__GetContext__10 = l__obtain__4("ContextManager").GetContext;
local l__GetStyleName__11 = l__obtain__4("Styles").GetStyleName;
local u5 = l__obtain__4("View");
local u6 = l__obtain__4("FixLocalPlayer");
local v7 = l__obtain__4("RunManager");
local l__LocalPlayer__12 = game:GetService("Players").LocalPlayer;
local u8 = l__Color__8(45, 45, 45, 255);
local v9 = l__Color__8(60, 60, 60, 255);
local v10 = l__Color__8(255, 255, 255, 255);
local u11 = l__New__5();
u11.BackgroundColor = v9;
u11.PosOffsetX = 10;
function u11.Resize() --[[ Line: 44 ]]
    -- upvalues: u11 (copy)
    u11.PosOffsetY = -10 - u11.SizeY;
end;
u11.PosScaleY = 1;
u11.SizeOffsetX = 200;
u11.SizeOffsetY = 105;
local u13 = v3.New(200, function(p12) --[[ Line: 51 ]]
    -- upvalues: u11 (copy)
    u11.SizeOffsetX = p12;
end);
u13.MaxAcceleration = v3.MaxAcceleration(0, 200, 0, 0, 0.5);
local u15 = v3.New(105, function(p14) --[[ Line: 53 ]]
    -- upvalues: u11 (copy)
    u11.SizeOffsetY = p14;
end);
u15.MaxAcceleration = v3.MaxAcceleration(105, 130, 0, 0, 1);
local u16 = l__TextBox__6(u11);
u16.Visible = false;
u16.TextAlignment = "Center";
u16.TextSize = 12 * u2.roblox_messing_with_guis_factor;
u16.BackgroundColor = u8;
u16.SizeScaleX = 1;
u16.SizeOffsetX = -10;
u16.SizeOffsetY = 20;
u16.PosOffsetX = 5;
u16.PosOffsetY = 5;
local u17 = l__TextBox__6(u11, "Autohop");
u17.TextAlignment = "Center";
u17.TextSize = 12 * u2.roblox_messing_with_guis_factor;
u17.TextColor = v10;
u17.BackgroundColor = u8;
u17.SizeScaleX = 1;
u17.SizeOffsetX = -10;
u17.SizeOffsetY = 20;
u17.PosOffsetX = 5;
u17.PosOffsetY = -100;
u17.PosScaleY = 1;
u2.DragBar(u17, u11);
function u16.TextResize() --[[ Line: 84 ]]
    -- upvalues: u13 (copy), u16 (copy), u17 (copy), l__max__2 (copy)
    u13:Target((l__max__2(200, u16.TextSizeX + 20, u17.TextSizeX + 20)));
end;
function u17.TextResize() --[[ Line: 88 ]]
    -- upvalues: u13 (copy), u16 (copy), u17 (copy), l__max__2 (copy)
    u13:Target((l__max__2(200, u16.TextSizeX + 20, u17.TextSizeX + 20)));
end;
function u17.Think() --[[ Line: 92 ]]
    -- upvalues: u5 (copy), l__GetStyleName__11 (copy), u17 (copy)
    local l__PlaybackContext__13 = u5.PlaybackContext;
    local v18 = l__PlaybackContext__13 and l__GetStyleName__11(l__PlaybackContext__13.Cache:GetKey("Style"));
    if v18 then
        u17.Text = v18;
    else
        u17.Text = "???";
    end;
end;
local u19 = l__Color__8(30, 30, 30, 255);
local u20 = l__Color__8(15, 142.5, 15, 255);
local u21 = l__Color__8(142.5, 15, 15, 255);
local u22 = 0;
local u23 = {};
local function u35(u24) --[[ Line: 111 ]]
    -- upvalues: l__New__5 (copy), u11 (copy), u22 (ref), u19 (copy), u8 (copy), u20 (copy), u21 (copy), l__TextBox__6 (copy), l__GetContext__10 (copy), u6 (copy), u5 (copy), u1 (copy)
    local u25 = l__New__5(u11);
    u25.DrawBackground = false;
    u25.SizeScaleX = 1;
    u25.SizeOffsetX = -10;
    u25.SizeOffsetY = 45;
    u25.PosOffsetX = 5;
    u25.PosOffsetY = -75;
    u25.PosScaleX = u22;
    u25.PosScaleY = 1;
    u22 = u22 + 1;
    u25.Run = u24;
    local u26 = l__New__5(u25);
    u26.SizeScaleY = 1;
    u26.BackgroundColor = u19;
    local u27 = l__New__5(u25);
    u27.SizeScaleY = 1;
    u27.BackgroundColor = u8;
    u27.SizeScaleX = 1;
    u27.PosScaleX = 1;
    function u27.Resize() --[[ Line: 134 ]]
        -- upvalues: u27 (copy)
        u27.PosOffsetX = -u27.SizeX;
    end;
    local u28 = l__TextBox__6(u25, "Time: ");
    u28.DrawBackground = false;
    u28.SizeOffsetX = u28.TextSizeX;
    u28.SizeScaleY = 0.5;
    u28.TextAlignment = "Left";
    u28.ZIndex = 6;
    local u29 = l__TextBox__6(u25, "");
    u29.DrawBackground = false;
    u29.DontCheckBounds = true;
    u29.SizeScaleX = 1;
    u29.SizeOffsetX = -u28.TextSizeX;
    u29.SizeScaleY = 0.5;
    u29.PosOffsetX = u28.TextSizeX;
    u29.TextAlignment = "Left";
    u29.ZIndex = 6;
    function u28.TextResize() --[[ Line: 175 ]]
        -- upvalues: u29 (copy), u28 (copy)
        u29.SizeOffsetX = -u28.TextSizeX;
        u29.PosOffsetX = u28.TextSizeX;
    end;
    local v30 = l__TextBox__6(u25, "Record:");
    v30.DrawBackground = false;
    v30.SizeScaleX = 1;
    v30.SizeScaleY = 0.5;
    v30.PosScaleY = 0.5;
    v30.TextAlignment = "Left";
    v30.ZIndex = 6;
    local v31 = l__GetContext__10(u6(u5.Player));
    local v32;
    if v31 then
        v32 = v31:GetIndex("Times", u24.Mode, u24.Style);
        u25.Record = v32;
    else
        v32 = nil;
    end;
    v30.Text = "Record: " .. (v32 and u1(v32) or "None");
    u25.TopRecord = v30;
    function u25.Think() --[[ Line: 197 ]]
        -- upvalues: u24 (copy), u28 (copy), u29 (copy), u1 (ref), u25 (copy), u26 (copy), u27 (copy), u19 (ref), u20 (ref), u21 (ref)
        local v33 = u24.Timer:Time();
        u28.Text = (u24.Valid == false and "❌" or "") .. "Time: ";
        u29.Text = u1(v33);
        if u25.Record then
            local v34 = v33 / u25.Record;
            if v34 <= 0 then
                u26.SizeScaleX = 0;
                u27.SizeScaleX = 1;
                u26.BackgroundColor = u19;
            elseif v34 < 1 then
                u26.SizeScaleX = v34;
                u27.SizeScaleX = 1 - v34;
                u26.BackgroundColor = u20;
            elseif v34 == 1 then
                u26.SizeScaleX = 1;
                u27.SizeScaleX = 0;
                u26.BackgroundColor = u19;
            else
                u26.SizeScaleX = 1;
                u27.SizeScaleX = 0;
                u26.BackgroundColor = u21;
            end;
        elseif v33 > 0 then
            u26.SizeScaleX = 1;
            u27.SizeScaleX = 0;
            u26.BackgroundColor = u19;
        else
            u26.SizeScaleX = 0;
            u27.SizeScaleX = 1;
            u26.BackgroundColor = u19;
        end;
    end;
    return u25;
end;
local v36 = l__New__5(u11);
v36.DrawBackground = false;
v36.SizeScaleX = 1;
v36.SizeOffsetX = -10;
v36.SizeOffsetY = 20;
v36.PosOffsetX = 5;
v36.PosOffsetY = -25;
v36.PosScaleY = 1;
local u37 = l__New__5(v36);
u37.SizeScaleY = 1;
u37.BackgroundColor = l__Color__8(30, 30, 30, 255);
local u38 = l__New__5(v36);
u38.SizeScaleY = 1;
u38.BackgroundColor = u8;
u38.SizeScaleX = 1;
u38.PosScaleX = 1;
function u38.Resize() --[[ Line: 239 ]]
    -- upvalues: u38 (copy)
    u38.PosOffsetX = -u38.SizeX;
end;
local u39 = l__TextBox__6(v36, "0 u/s");
u39.DrawBackground = false;
u39.TextAlignment = "Center";
u39.AutoLocalize = false;
u39.DontCheckBounds = true;
u39.SizeScaleX = 1;
u39.SizeScaleY = 1;
u39.ZIndex = 6;
u2.DragBar(u39, u39);
function v36.Think() --[[ Line: 260 ]]
    -- upvalues: u5 (copy), u37 (copy), u38 (copy), u39 (copy), l__format__3 (copy)
    local l__PlaybackContext__14 = u5.PlaybackContext;
    if l__PlaybackContext__14 then
        local _, v40 = l__PlaybackContext__14.Context:GetPV();
        if v40 then
            local l__x__15 = v40.x;
            local l__z__16 = v40.z;
            local v41 = (l__x__15 * l__x__15 + l__z__16 * l__z__16) ^ 0.5;
            local v42 = v41 / (v41 + 72);
            u37.SizeScaleX = v42;
            u38.SizeScaleX = 1 - v42;
            u39.Text = l__format__3("%.2f u/s", v41);
        end;
    end;
end;
v7.RunClear:Add(function(p43) --[[ Line: 274 ]]
    -- upvalues: u5 (copy), u23 (copy), u22 (ref)
    local v44 = u5.Player == p43.Player and u23[p43.Mode];
    if v44 then
        u23[p43.Mode] = nil;
        u22 = 0;
        v44:Remove();
        for _, v45 in u23 do
            v45.PosScaleX = u22;
            u22 = u22 + 1;
        end;
    end;
end);
v7.RunPrepare:Add(function(p46) --[[ Line: 284 ]]
    -- upvalues: u5 (copy), u23 (copy), u22 (ref), u35 (copy)
    if u5.Player == p46.Player then
        for _, v47 in u23 do
            local l__Run__17 = v47.Run;
            if l__Run__17.InProgress == false then
                u23[l__Run__17.Mode] = nil;
                u22 = 0;
                v47:Remove();
                for _, v48 in u23 do
                    v48.PosScaleX = u22;
                    u22 = u22 + 1;
                end;
            end;
        end;
        u23[p46.Mode] = u35(p46);
    end;
end);
u5.PlayerChanged:Add(function(p49) --[[ Line: 298 ]]
    -- upvalues: u16 (copy), u15 (copy), u23 (copy), u22 (ref), l__clear__1 (copy), l__GetContext__10 (copy), u35 (copy)
    if p49 == "Local" then
        u16.Visible = false;
        u15:Target(105);
        u16.Text = "";
    else
        u15:Target(130);
        u16.Visible = true;
        u16.Text = p49.Name;
    end;
    for _, v50 in u23 do
        u22 = 0;
        v50:Remove();
        for _, v51 in u23 do
            v51.PosScaleX = u22;
            u22 = u22 + 1;
        end;
    end;
    u22 = 0;
    l__clear__1(u23);
    local v52 = l__GetContext__10(p49);
    if v52 then
        for v53, v54 in v52.Runs do
            u23[v53] = u35(v54);
        end;
    end;
end);
local u55 = l__New__5(u11);
u55.BackgroundColor = u8;
u55.SizeOffsetX = 140;
u55.SizeOffsetY = 40;
u55.PosOffsetX = 10;
u55.PosOffsetY = -90;
u55.PosScaleX = 1;
u55.PosScaleY = 1;
function u55.Fade(p56) --[[ Line: 329 ]]
    -- upvalues: u55 (copy), l__ColourLerp__9 (copy), u2 (copy)
    u55.BackgroundColor = l__ColourLerp__9(u2.Color1, u2.Color2, p56);
end;
u55.Button1Down = v4.GetCallFunction("ToggleShop");
local v57 = l__TextBox__6(u55, "Shop");
v57.DrawBackground = false;
v57.TextAlignment = "Center";
v57.TextSize = 18 * u2.roblox_messing_with_guis_factor;
v57.SizeOffsetX = 100;
v57.SizeScaleY = 1;
local v58 = l__Image__7(u55, "rbxassetid://8418042737");
v58.DrawBackground = false;
v58.SizeOffsetX = 40;
v58.SizeScaleY = 1;
v58.PosScaleX = 1;
v58.PosOffsetX = -40;
local u59 = l__New__5(u11);
u59.BackgroundColor = u8;
u59.SizeOffsetX = 140;
u59.SizeOffsetY = 40;
u59.PosOffsetX = 10;
u59.PosOffsetY = -40;
u59.PosScaleX = 1;
u59.PosScaleY = 1;
function u59.Fade(p60) --[[ Line: 357 ]]
    -- upvalues: u59 (copy), l__ColourLerp__9 (copy), u2 (copy)
    u59.BackgroundColor = l__ColourLerp__9(u2.Color1, u2.Color2, p60);
end;
u59.Button1Down = v4.GetCallFunction("ToggleMenu");
local v61 = l__TextBox__6(u59, "Menu");
v61.DrawBackground = false;
v61.TextAlignment = "Center";
v61.TextSize = 18 * u2.roblox_messing_with_guis_factor;
v61.SizeOffsetX = 100;
v61.SizeScaleY = 1;
local v62 = l__Image__7(u59, "rbxassetid://8418041484");
v62.DrawBackground = false;
v62.SizeOffsetX = 40;
v62.SizeScaleY = 1;
v62.PosScaleX = 1;
v62.PosOffsetX = -40;
return function() --[[ Line: 377 ]]
    -- upvalues: l__GetContext__10 (copy), l__LocalPlayer__12 (copy), u5 (copy), u23 (copy), u1 (copy), u35 (copy)
    local u63 = l__GetContext__10(l__LocalPlayer__12);
    u63.Cache:MonitorKey("Times", function(p64) --[[ Line: 379 ]]
        -- upvalues: u5 (ref), u23 (ref), u63 (copy), u1 (ref)
        local v65 = p64 and (u5.Player == "Local" and u5.PlaybackContext);
        if v65 then
            for v66, v67 in v65.Runs do
                if v67.Started == false then
                    local v68 = u23[v66];
                    if v68 then
                        local v69 = u63:GetIndex("Times", v67.Mode, v67.Style);
                        v68.Record = v69;
                        v68.TopRecord.Text = "Record: " .. (v69 and u1(v69) or "None");
                    end;
                end;
            end;
        end;
    end);
    local l__PlaybackContext__18 = u5.PlaybackContext;
    if l__PlaybackContext__18 then
        for v70, v71 in l__PlaybackContext__18.Runs do
            u23[v70] = u35(v71);
        end;
    end;
end;
