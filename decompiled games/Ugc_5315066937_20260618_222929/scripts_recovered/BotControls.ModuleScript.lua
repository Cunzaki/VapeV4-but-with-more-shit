-- Decompiled from: BotControls
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clamp__1 = math.clamp;
local l__match__2 = string.match;
local l__format__3 = string.format;
local l__obtain__4 = _G.obtain;
local v1 = l__obtain__4("Tween");
local u2 = l__obtain__4("QBox");
local l__New__5 = u2.New;
local l__Image__6 = u2.Image;
local l__TextBox__7 = u2.TextBox;
local l__ColourLerp__8 = u2.ColourLerp;
local l__Gui__9 = l__obtain__4("InputBinds").Gui;
local l__RootTimer__10 = l__obtain__4("RealtimeTimerSystem").RootTimer;
local u3 = l__obtain__4("GetFormattedTime");
local u4 = l__obtain__4("View");
local u5 = false;
local u6 = l__New__5(nil);
u6.DrawBackground = true;
u6.Visible = false;
u6.SizeOffsetX = 480;
u6.SizeOffsetY = 120;
u6.PosOffsetX = -730;
u6.PosScaleX = 0.5;
u6.PosScaleY = 1;
local v7 = u2.Resizable(u6);
v7.MinX = 300;
v7.MinY = 120;
local u9 = v1.New(0, function(p8) --[[ Line: 41 ]]
    -- upvalues: u6 (copy)
    u6.PosOffsetY = p8;
end);
u9.MaxAcceleration = v1.MaxAcceleration(0, 160, 0, 0, 0.7);
function u6.Moved() --[[ Line: 46 ]]
    -- upvalues: u9 (copy), u6 (copy)
    if not u9.Tweening then
        u9.x1 = u6.PosOffsetY;
    end;
end;
local v10 = l__TextBox__7(v7, "Bot Playback Controls");
v10.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v10.TextAlignment = "Center";
v10.BackgroundColor = u2.Color2;
v10.SizeScaleX = 1;
v10.SizeOffsetX = -20;
v10.SizeOffsetY = 20;
u2.DragBar(v10, u6);
local v11 = l__TextBox__7(v7, "x");
v11.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v11.TextAlignment = "Center";
v11.SizeOffsetX = 20;
v11.SizeOffsetY = 20;
v11.PosOffsetX = -20;
v11.PosScaleX = 1;
local v12 = 20;
local u13 = l__TextBox__7(v7, "↪️");
u13.PosOffsetX = v12;
u13.PosOffsetY = 30;
u13.SizeOffsetX = 20;
u13.SizeOffsetY = 20;
local v14 = v12 + u13.SizeX + 5;
function u13.Button1Down() --[[ Line: 84 ]]
    -- upvalues: u4 (copy), l__RootTimer__10 (copy)
    local l__TEMP_BEGINTIME__11 = u4.PlaybackContext.TEMP_BEGINTIME;
    if l__TEMP_BEGINTIME__11 then
        u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTime", l__TEMP_BEGINTIME__11);
    end;
end;
l__Gui__9:RegisterBindable("PlaybackControlRestart", function(p15) --[[ Line: 90 ]]
    -- upvalues: u5 (ref), u2 (copy), u13 (copy)
    if u5 and not u2.Focus then
        if p15 == true then
            u13.Button1Down();
        end;
        return true;
    end;
end, "R");
local u16 = l__TextBox__7(v7, "⏯");
u16.PosOffsetX = v14;
u16.PosOffsetY = 30;
u16.SizeOffsetX = 20;
u16.SizeOffsetY = 20;
local v17 = v14 + u16.SizeX + 5;
function u16.Button1Down() --[[ Line: 105 ]]
    -- upvalues: u4 (copy), l__RootTimer__10 (copy)
    local v18 = not u4.PlaybackContext.Timer.SavedScale;
    u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetPaused", v18);
end;
l__Gui__9:RegisterBindable("PlaybackControlPlayPause", function(p19) --[[ Line: 108 ]]
    -- upvalues: u5 (ref), u2 (copy), u16 (copy)
    if u5 and not u2.Focus then
        if p19 == true then
            u16.Button1Down();
        end;
        return true;
    end;
end, "Space");
local v20 = l__TextBox__7(v7, "⬅️");
v20.PosOffsetX = v17;
v20.PosOffsetY = 30;
v20.SizeOffsetX = 20;
v20.SizeOffsetY = 20;
local v21 = v17 + v20.SizeX + 5;
local v22 = l__TextBox__7(v7, "➡️");
v22.PosOffsetX = v21;
v22.PosOffsetY = 30;
v22.SizeOffsetX = 20;
v22.SizeOffsetY = 20;
local v23 = v21 + v22.SizeX + 5;
local u24 = l__TextBox__7(v7, "⏮");
u24.PosOffsetX = v23;
u24.PosOffsetY = 30;
u24.SizeOffsetX = 20;
u24.SizeOffsetY = 20;
local v25 = v23 + u24.SizeX + 5;
function u24.Button1Down() --[[ Line: 158 ]]
    -- upvalues: u4 (copy), l__RootTimer__10 (copy)
    local l__PlaybackContext__12 = u4.PlaybackContext;
    local v26 = l__PlaybackContext__12.TEMP_BEGINTIME or 0;
    local v27 = l__PlaybackContext__12.Timer:Time() - 1 * l__PlaybackContext__12.Timer:GetScale();
    if v27 < v26 then
        v27 = v26;
    end;
    u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTime", v27);
end;
l__Gui__9:RegisterBindable("PlaybackControlBack", function(p28) --[[ Line: 167 ]]
    -- upvalues: u5 (ref), u2 (copy), u24 (copy)
    if u5 and not u2.Focus then
        if p28 == true then
            u24.Button1Down();
        end;
        return true;
    end;
end, "Left");
local u29 = l__TextBox__7(v7, "⏭");
u29.PosOffsetX = v25;
u29.PosOffsetY = 30;
u29.SizeOffsetX = 20;
u29.SizeOffsetY = 20;
local v30 = v25 + u29.SizeX + 5;
function u29.Button1Down() --[[ Line: 182 ]]
    -- upvalues: u4 (copy), l__RootTimer__10 (copy)
    local l__PlaybackContext__13 = u4.PlaybackContext;
    local l__TEMP_ENDTIME__14 = l__PlaybackContext__13.TEMP_ENDTIME;
    local v31 = l__PlaybackContext__13.Timer:Time() + 1 * l__PlaybackContext__13.Timer:GetScale();
    if l__TEMP_ENDTIME__14 then
        if l__TEMP_ENDTIME__14 >= v31 then
            l__TEMP_ENDTIME__14 = v31;
        end;
    else
        l__TEMP_ENDTIME__14 = v31;
    end;
    u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTime", l__TEMP_ENDTIME__14);
end;
l__Gui__9:RegisterBindable("PlaybackControlForward", function(p32) --[[ Line: 191 ]]
    -- upvalues: u5 (ref), u2 (copy), u29 (copy)
    if u5 and not u2.Focus then
        if p32 == true then
            u29.Button1Down();
        end;
        return true;
    end;
end, "Right");
local u33 = l__TextBox__7(v7, "⏪");
u33.PosOffsetX = v30;
u33.PosOffsetY = 30;
u33.SizeOffsetX = 20;
u33.SizeOffsetY = 20;
local v34 = v30 + u33.SizeX + 5;
function u33.Button1Down() --[[ Line: 209 ]]
    -- upvalues: u4 (copy), l__clamp__1 (copy), l__RootTimer__10 (copy)
    local v35 = l__clamp__1(u4.PlaybackContext.Timer:GetScale() * 0.8, 0.009223372036854775, 108.42021724855044);
    u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTimescale", v35);
end;
l__Gui__9:RegisterBindable("PlaybackControlDecreaseSpeed", function(p36) --[[ Line: 212 ]]
    -- upvalues: u5 (ref), u2 (copy), u33 (copy)
    if u5 and not u2.Focus then
        if p36 == true then
            u33.Button1Down();
        end;
        return true;
    end;
end, "Down");
local u37 = l__TextBox__7(v7, "1x");
u37.PosOffsetX = v34;
u37.PosOffsetY = 30;
u37.SizeOffsetX = 40;
u37.SizeOffsetY = 20;
u37.Editable = true;
function u37.FocusLost(_, p38) --[[ Line: 227 ]]
    -- upvalues: u37 (copy), l__match__2 (copy), l__clamp__1 (copy), u4 (copy), l__RootTimer__10 (copy)
    if p38 then
        local l__Text__15 = u37.Text;
        local v39 = l__clamp__1(tonumber(l__Text__15) or tonumber(l__match__2(l__Text__15, "(.-)x")) or 1, 0.009223372036854775, 108.42021724855044);
        u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTimescale", v39);
        u37.Text = v39 .. "x";
    end;
end;
local v40 = v34 + u37.SizeX + 5;
function u37.Think() --[[ Line: 236 ]]
    -- upvalues: u2 (copy), u37 (copy), l__format__3 (copy), u4 (copy)
    if not u2.Focus then
        u37.Text = l__format__3("%.3gx", u4.PlaybackContext.Timer:GetScale());
    end;
end;
local u41 = l__TextBox__7(v7, "⏩");
u41.PosOffsetX = v40;
u41.PosOffsetY = 30;
u41.SizeOffsetX = 20;
u41.SizeOffsetY = 20;
local _ = v40 + u41.SizeX + 5;
function u41.Button1Down() --[[ Line: 248 ]]
    -- upvalues: u4 (copy), l__clamp__1 (copy), l__RootTimer__10 (copy)
    local v42 = l__clamp__1(u4.PlaybackContext.Timer:GetScale() * 1.25, 0.009223372036854775, 108.42021724855044);
    u4.PlaybackContext.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTimescale", v42);
end;
l__Gui__9:RegisterBindable("PlaybackControlIncreaseSpeed", function(p43) --[[ Line: 251 ]]
    -- upvalues: u5 (ref), u2 (copy), u41 (copy)
    if u5 and not u2.Focus then
        if p43 == true then
            u41.Button1Down();
        end;
        return true;
    end;
end, "Up");
local u44 = l__New__5(v7);
u44.DrawBackground = false;
u44.PosOffsetY = -70;
u44.PosScaleY = 1;
u44.SizeScaleX = 1;
u44.SizeOffsetY = 40;
local u45 = l__New__5(u44);
u45.BackgroundColor = u2.Color2;
u45.PosOffsetX = 20;
u45.SizeScaleX = 1;
u45.SizeOffsetX = -40;
u45.SizeOffsetY = 6;
u45.PosScaleY = 0.5;
u45.PosOffsetY = u45.SizeY / -2;
local u46 = l__Image__6(u45, "rbxassetid://3615762331");
u46.ImageColor = u2.Color0;
u46.DrawBackground = false;
u46.SizeOffsetX = 20;
u46.SizeOffsetY = 20;
u46.PosOffsetX = u46.SizeX / -2;
u46.PosOffsetY = (u45.SizeY - u46.SizeY) / 2;
function u46.Fade(p47) --[[ Line: 286 ]]
    -- upvalues: u46 (copy), l__ColourLerp__8 (copy), u2 (copy)
    u46.ImageColor = l__ColourLerp__8(u2.Color0, u2.Color1, p47 / 2);
end;
function u44.Think() --[[ Line: 291 ]]
    -- upvalues: u4 (copy), u46 (copy), l__clamp__1 (copy)
    local l__PlaybackContext__16 = u4.PlaybackContext;
    local l__TEMP_BEGINTIME__17 = l__PlaybackContext__16.TEMP_BEGINTIME;
    local l__TEMP_ENDTIME__18 = l__PlaybackContext__16.TEMP_ENDTIME;
    if l__TEMP_BEGINTIME__17 and l__TEMP_ENDTIME__18 then
        u46.Visible = true;
        u46.PosScaleX = l__clamp__1((l__PlaybackContext__16.Timer:Time() - l__TEMP_BEGINTIME__17) / (l__TEMP_ENDTIME__18 - l__TEMP_BEGINTIME__17), 0, 1);
    else
        u46.Visible = false;
    end;
end;
local u48 = l__TextBox__7(v7, "");
u48.TextAlignment = "Left";
u48.DrawBackground = false;
u48.PosOffsetX = 10;
u48.PosOffsetY = -30;
u48.PosScaleY = 1;
u48.SizeOffsetX = 100;
u48.SizeOffsetY = 20;
function u48.Think() --[[ Line: 312 ]]
    -- upvalues: u4 (copy), u48 (copy), u3 (copy)
    local l__PlaybackContext__19 = u4.PlaybackContext;
    local l__TEMP_BEGINTIME__20 = l__PlaybackContext__19.TEMP_BEGINTIME;
    if l__TEMP_BEGINTIME__20 then
        u48.Text = u3(l__PlaybackContext__19.Timer:Time() - l__TEMP_BEGINTIME__20);
    else
        u48.Text = "";
    end;
end;
local u49 = l__TextBox__7(v7, "");
u49.TextAlignment = "Left";
u49.DrawBackground = false;
u49.PosScaleX = 1;
u49.PosOffsetX = -110;
u49.PosOffsetY = -30;
u49.PosScaleY = 1;
u49.SizeOffsetX = 100;
u49.SizeOffsetY = 20;
function u49.Think() --[[ Line: 331 ]]
    -- upvalues: u4 (copy), u49 (copy), u3 (copy)
    local l__PlaybackContext__21 = u4.PlaybackContext;
    local l__TEMP_BEGINTIME__22 = l__PlaybackContext__21.TEMP_BEGINTIME;
    local l__TEMP_ENDTIME__23 = l__PlaybackContext__21.TEMP_ENDTIME;
    if l__TEMP_BEGINTIME__22 and l__TEMP_ENDTIME__23 then
        u49.Text = u3(l__TEMP_ENDTIME__23 - l__TEMP_BEGINTIME__22);
    else
        u49.Text = "";
    end;
end;
local u50 = nil;
local u51 = nil;
local function v54(p52, _) --[[ Line: 347 ]]
    -- upvalues: u50 (ref), u45 (copy), l__clamp__1 (copy), u51 (ref), l__RootTimer__10 (copy)
    if u50 then
        local v53 = l__clamp__1((p52 + u50 - u45.PosX) / u45.SizeX, 0, 1);
        u51.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTime", (1 - v53) * u51.TEMP_BEGINTIME + v53 * u51.TEMP_ENDTIME);
    end;
end;
function u44.Button1Down(p55, p56) --[[ Line: 353 ]]
    -- upvalues: u50 (ref), u4 (copy), u51 (ref), l__RootTimer__10 (copy), u44 (copy), u46 (copy), u45 (copy), l__clamp__1 (copy)
    if not u50 then
        local l__PlaybackContext__24 = u4.PlaybackContext;
        if l__PlaybackContext__24.TEMP_BEGINTIME and l__PlaybackContext__24.TEMP_ENDTIME then
            u51 = l__PlaybackContext__24;
            u51.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetPaused", true);
            local v57 = u44.PosX + p55;
            local v58 = u44.PosY + p56;
            local v59 = u46.PosX + u46.SizeX / 2 - v57;
            local v60 = u46.PosY + u46.SizeY / 2 - v58;
            if v59 * v59 + v60 * v60 < (u46.SizeX / 2) ^ 2 then
                u50 = v59;
                return;
            end;
            u50 = 0;
            if u50 then
                local v61 = l__clamp__1((v57 + u50 - u45.PosX) / u45.SizeX, 0, 1);
                u51.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTime", (1 - v61) * u51.TEMP_BEGINTIME + v61 * u51.TEMP_ENDTIME);
            end;
        end;
    end;
end;
u44.MouseMoved = v54;
function u44.Button1Up(p62, p63) --[[ Line: 374 ]]
    -- upvalues: u44 (copy), u50 (ref), u45 (copy), l__clamp__1 (copy), u51 (ref), l__RootTimer__10 (copy)
    local v64 = u44.PosX + p62;
    local _ = u44.PosY + p63;
    if u50 then
        local v65 = l__clamp__1((v64 + u50 - u45.PosX) / u45.SizeX, 0, 1);
        u51.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetTime", (1 - v65) * u51.TEMP_BEGINTIME + v65 * u51.TEMP_ENDTIME);
    end;
    u51.PlaybackControl:Call("Timer", l__RootTimer__10:Time(), "SetPaused", false);
    u50 = nil;
    u51 = nil;
end;
function u44.MouseWheeled(p66) --[[ Line: 381 ]]
    -- upvalues: u24 (copy), u29 (copy)
    if p66 < 0 then
        u24.Button1Down();
    else
        u29.Button1Down();
    end;
end;
function v11.Button1Down() --[[ Line: 389 ]]
    -- upvalues: u5 (ref), u9 (copy), u6 (copy)
    u5 = false;
    u9:Target(0, function() --[[ Line: 391 ]]
        -- upvalues: u6 (ref)
        u6.Visible = false;
    end);
end;
u4.PlayerChanged:Add(function(p67) --[[ Line: 404 ]]
    -- upvalues: u5 (ref), u9 (copy), u6 (copy)
    local v68;
    if type(p67) == "table" then
        v68 = p67.Id ~= nil;
    else
        v68 = false;
    end;
    if v68 or not u5 then
        if v68 and not u5 then
            u5 = true;
            u6.Visible = true;
            u9:Target(-110 - u6.SizeY);
        end;
    else
        u5 = false;
        u9:Target(0, function() --[[ Line: 391 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    end;
end);
return true;
