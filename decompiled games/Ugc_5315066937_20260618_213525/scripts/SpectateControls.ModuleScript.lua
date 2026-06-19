-- Decompiled from: SpectateControls
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local _ = u1.FreeMouse;
local l__Color__2 = u1.Color;
local v2 = l__obtain__1("Tween");
local _ = l__obtain__1("Remote").Call;
local v3 = l__obtain__1("View");
local v4 = l__obtain__1("Spectate");
local l__Next__3 = v4.Next;
local l__Prev__4 = v4.Prev;
local l__SetPlayer__5 = v4.SetPlayer;
local l__ChangeView__6 = v4.ChangeView;
local l__Gui__7 = l__obtain__1("InputBinds").Gui;
local u5 = u1.New();
u5.DrawBackground = false;
u5.Visible = false;
u5.SizeOffsetX = 400;
u5.SizeOffsetY = 80;
u5.PosOffsetX = -200;
u5.PosScaleX = 0.5;
u5.PosScaleY = 1;
local u7 = v2.New(0, function(p6) --[[ Line: 35 ]]
    -- upvalues: u5 (copy)
    u5.PosOffsetY = p6;
end);
u7.MaxAcceleration = v2.MaxAcceleration(0, 160, 0, 0, 0.7);
local u8 = u1.Image(u5, "rbxassetid://409518502");
u8.BackgroundColor = l__Color__2(255, 255, 255, 0);
u8.SizeScaleY = 1;
u8.SizeOffsetX = 95;
u8.Button1Down = l__Prev__4;
function u8.Fade(p9) --[[ Line: 45 ]]
    -- upvalues: u8 (copy), l__Color__2 (copy)
    u8.BackgroundColor = l__Color__2(255, 255, 255, 128 * p9);
end;
local v10 = u1.TextBox(u8, "Q");
v10.DrawBackground = false;
v10.TextStrokeColor = l__Color__2(34, 34, 34, 64);
v10.PosScaleX = 1;
v10.PosScaleY = 1;
v10.PosOffsetX = -v10.TextSizeX;
v10.PosOffsetY = -v10.TextSizeY;
v10.SizeOffsetX = v10.TextSizeX;
v10.SizeOffsetY = v10.TextSizeY;
local u11 = u1.Image(u5, "rbxassetid://409518552");
u11.BackgroundColor = l__Color__2(255, 255, 255, 0);
u11.PosScaleX = 1;
u11.PosOffsetX = -95;
u11.SizeScaleY = 1;
u11.SizeOffsetX = 95;
u11.Button1Down = l__Next__3;
function u11.Fade(p12) --[[ Line: 65 ]]
    -- upvalues: u11 (copy), l__Color__2 (copy)
    u11.BackgroundColor = l__Color__2(255, 255, 255, 128 * p12);
end;
local v13 = u1.TextBox(u11, "E");
v13.DrawBackground = false;
v13.TextStrokeColor = l__Color__2(34, 34, 34, 64);
v13.PosScaleY = 1;
v13.PosOffsetY = -v13.TextSizeY;
v13.SizeOffsetX = v13.TextSizeX;
v13.SizeOffsetY = v13.TextSizeY;
local u14 = u1.TextBox(u5, "Change View(C)");
u14.BackgroundColor = l__Color__2(255, 255, 255, 0);
u14.TextStrokeColor = l__Color__2(34, 34, 34, 64);
u14.TextFont = Enum.Font.ArialBold;
u14.TextSize = 24;
u14.PosOffsetX = 95;
u14.SizeScaleX = 1;
u14.SizeScaleY = 0.5;
u14.SizeOffsetX = -190;
function u14.Button1Down() --[[ Line: 86 ]]
    -- upvalues: l__ChangeView__6 (copy)
    l__ChangeView__6();
end;
function u14.Fade(p15) --[[ Line: 89 ]]
    -- upvalues: u14 (copy), l__Color__2 (copy)
    u14.BackgroundColor = l__Color__2(255, 255, 255, 128 * p15);
end;
local u16 = u1.TextBox(u5, "Stop Spectating(X)");
u16.BackgroundColor = l__Color__2(255, 255, 255, 0);
u16.TextStrokeColor = l__Color__2(34, 34, 34, 64);
u16.TextFont = Enum.Font.ArialBold;
u16.TextSize = 24;
u16.PosScaleY = 0.5;
u16.PosOffsetX = 95;
u16.SizeScaleX = 1;
u16.SizeScaleY = 0.5;
u16.SizeOffsetX = -190;
function u16.Button1Down() --[[ Line: 103 ]]
    -- upvalues: l__SetPlayer__5 (copy)
    l__SetPlayer__5("Local");
end;
function u16.Fade(p17) --[[ Line: 106 ]]
    -- upvalues: u16 (copy), l__Color__2 (copy)
    u16.BackgroundColor = l__Color__2(255, 255, 255, 128 * p17);
end;
local u18 = false;
l__Gui__7:RegisterBindable("SpectatePrev", function(p19) --[[ Line: 189 ]]
    -- upvalues: u18 (ref), u1 (copy), l__Prev__4 (copy)
    if u18 and not u1.Focus then
        if p19 == true then
            l__Prev__4();
        end;
        return true;
    end;
end, "Q");
l__Gui__7:RegisterBindable("SpectateNext", function(p20) --[[ Line: 197 ]]
    -- upvalues: u18 (ref), u1 (copy), l__Next__3 (copy)
    if u18 and not u1.Focus then
        if p20 == true then
            l__Next__3();
        end;
        return true;
    end;
end, "E");
l__Gui__7:RegisterBindable("SpectateStop", function(p21) --[[ Line: 205 ]]
    -- upvalues: u18 (ref), u1 (copy), l__SetPlayer__5 (copy)
    if u18 and not u1.Focus then
        if p21 == true then
            l__SetPlayer__5("Local");
        end;
        return true;
    end;
end, "X");
l__Gui__7:RegisterBindable("SpectateChangeView", function(p22) --[[ Line: 213 ]]
    -- upvalues: u18 (ref), u1 (copy), l__ChangeView__6 (copy)
    if u18 and not u1.Focus then
        if p22 == true then
            l__ChangeView__6();
        end;
        return true;
    end;
end, "C");
v3.PlayerChanged:Add(function(p23) --[[ Line: 237 ]]
    -- upvalues: u18 (ref), u7 (copy), u5 (copy)
    if p23 == "Local" and u18 then
        u18 = false;
        u7:Target(0, function() --[[ Line: 225 ]]
            -- upvalues: u5 (ref)
            u5.Visible = false;
        end);
    else
        if p23 ~= "Local" and not u18 then
            u18 = true;
            u5.Visible = true;
            u7:Target(-2 * u5.SizeY);
        end;
    end;
end);
return true;
