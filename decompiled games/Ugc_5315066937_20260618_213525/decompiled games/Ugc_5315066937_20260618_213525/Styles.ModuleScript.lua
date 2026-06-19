-- Decompiled from: Styles
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local l__Color__2 = u1.Color;
local l__FreeMouse__3 = u1.FreeMouse;
local l__TextBox__4 = u1.TextBox;
local l__FromList__5 = u1.FromList;
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Local");
local l__SetStyle__6 = l__obtain__1("SimulationControl").SetStyle;
local v4 = l__obtain__1("Styles");
local l__Add__7 = l__obtain__1("Command").Add;
local u5 = u1.New();
u5.Visible = false;
u5.DrawBackground = false;
u5.SizeOffsetX = 400;
u5.SizeOffsetY = 700;
u5.PosScaleX = 0.5;
u5.PosScaleY = 1;
local u6 = false;
local u8 = v2.New(0, function(p7) --[[ Line: 36 ]]
    -- upvalues: u6 (ref), u5 (copy)
    u6 = true;
    u5.PosOffsetY = p7;
    u6 = false;
end);
u8.MaxAcceleration = v2.MaxAcceleration(0, u5.SizeY, 0, 0, 1);
u5.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 42 ]]
    -- upvalues: u6 (ref), u8 (copy), u5 (copy)
    if not u6 then
        u8.x1 = u5.PosOffsetY;
    end;
end;
function u5.Resize() --[[ Line: 48 ]]
    -- upvalues: u5 (copy), u8 (copy)
    u5.PosOffsetX = u5.SizeX / -2;
    u5.PosOffsetY = u8:Value();
end;
local v9 = u1.TextBox(u5, "Select a Style");
v9.TextSize = 12 * u1.roblox_messing_with_guis_factor;
v9.TextAlignment = "Center";
v9.BackgroundColor = u1.Color2;
v9.SizeScaleX = 1;
v9.SizeOffsetX = -40;
v9.SizeOffsetY = 40;
u1.DragBar(v9, u5);
local v10 = u1.TextBox(u5, "x");
v10.TextSize = 12 * u1.roblox_messing_with_guis_factor;
v10.TextAlignment = "Center";
v10.SizeOffsetX = 40;
v10.SizeOffsetY = 40;
v10.PosOffsetX = -40;
v10.PosScaleX = 1;
local u11 = u1.New();
u11.DrawBackground = false;
u11.SizeScaleX = 1;
local v12 = u1.New(u5);
v12.PosOffsetY = 40;
v12.SizeScaleX = 1;
v12.SizeScaleY = 1;
v12.SizeOffsetY = -40;
u1.Scroll(u11, v12);
local u13 = false;
function v10.Button1Down() --[[ Line: 87 ]]
    -- upvalues: u13 (ref), l__FreeMouse__3 (copy), u8 (copy), u5 (copy)
    u13 = false;
    l__FreeMouse__3("StyleSelect", false);
    u8:Target(0, function() --[[ Line: 90 ]]
        -- upvalues: u5 (ref)
        u5.Visible = false;
    end);
end;
local l__Types__8 = v4.Types;
u11.SizeOffsetY = #l__Types__8 * 40;
l__FromList__5(l__Types__8, function(_, u14) --[[ Line: 99 ]]
    -- upvalues: l__TextBox__4 (copy), u11 (copy), u1 (copy), l__Color__2 (copy), u13 (ref), l__SetStyle__6 (copy), l__FreeMouse__3 (copy), u8 (copy), u5 (copy)
    local l__name__9 = u14.name;
    local u15 = l__TextBox__4(u11, l__name__9);
    u15.TextAlignment = "Center";
    function u15.Fade(p16) --[[ Line: 105 ]]
        -- upvalues: u15 (copy), u1 (ref), l__Color__2 (ref)
        local v17 = u15;
        local l__Color1__10 = u1.Color1;
        local l__Color2__11 = u1.Color2;
        local v18 = 1 - p16;
        v17.BackgroundColor = l__Color__2(l__Color1__10.r * v18 + l__Color2__11.r * p16, l__Color1__10.g * v18 + l__Color2__11.g * p16, l__Color1__10.b * v18 + l__Color2__11.b * p16, l__Color1__10.a * v18 + l__Color2__11.a * p16);
    end;
    u15.FadeDuration = 0.15;
    function u15.Button1Down() --[[ Line: 109 ]]
        -- upvalues: u13 (ref), l__SetStyle__6 (ref), u14 (copy), l__FreeMouse__3 (ref), u8 (ref), u5 (ref)
        if u13 then
            l__SetStyle__6(u14.id);
            u13 = false;
            l__FreeMouse__3("StyleSelect", false);
            u8:Target(0, function() --[[ Line: 90 ]]
                -- upvalues: u5 (ref)
                u5.Visible = false;
            end);
        end;
    end;
    function u15.MouseEnter() --[[ Line: 115 ]] end;
    function u15.MouseLeave() --[[ Line: 120 ]]
        -- upvalues: u15 (copy), l__name__9 (copy)
        u15.Text = l__name__9;
    end;
    return u15;
end);
v3.Add("OpenStyleSelect", function() --[[ Name: OpenStyleSelect, Line 128 ]]
    -- upvalues: u13 (ref), l__FreeMouse__3 (copy), u5 (copy), u8 (copy)
    u13 = true;
    l__FreeMouse__3("StyleSelect", true);
    u5.Visible = true;
    u8:Target(-u5.Parent.SizeY / 2 - u5.SizeY / 2);
end);
l__Add__7({ "styles", "style" }, {}, function() --[[ Line: 137 ]]
    -- upvalues: u13 (ref), l__FreeMouse__3 (copy), u8 (copy), u5 (copy)
    if u13 then
        u13 = false;
        l__FreeMouse__3("StyleSelect", false);
        u8:Target(0, function() --[[ Line: 90 ]]
            -- upvalues: u5 (ref)
            u5.Visible = false;
        end);
    else
        u13 = true;
        l__FreeMouse__3("StyleSelect", true);
        u5.Visible = true;
        u8:Target(-u5.Parent.SizeY / 2 - u5.SizeY / 2);
    end;
end);
l__Add__7("style", { "Style" }, function(p19) --[[ Line: 145 ]]
    -- upvalues: l__SetStyle__6 (copy)
    l__SetStyle__6(p19);
end);
for _, v20 in v4.Type do
    local l__id__12 = v20.id;
    for _, v21 in v20.cmds do
        l__Add__7(v21, {}, function() --[[ Line: 152 ]]
            -- upvalues: l__SetStyle__6 (copy), l__id__12 (copy)
            l__SetStyle__6(l__id__12);
        end);
    end;
end;
return true;
