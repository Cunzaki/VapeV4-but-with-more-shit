-- Decompiled from: Clipboard
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("QBox");
local l__Color__2 = v1.Color;
local l__FreeMouse__3 = v1.FreeMouse;
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Remote");
local v4 = l__obtain__1("Command");
local u5 = v1.New();
u5.Visible = false;
u5.DrawBackground = true;
u5.SizeOffsetX = 400;
u5.SizeOffsetY = 300;
u5.PosScaleX = 0.5;
u5.PosScaleY = 1;
local u6 = false;
local u8 = v2.New(0, function(p7) --[[ Line: 29 ]]
    -- upvalues: u6 (ref), u5 (copy)
    u6 = true;
    u5.PosOffsetY = p7;
    u6 = false;
end);
u8.MaxAcceleration = v2.MaxAcceleration(0, u5.SizeY, 0, 0, 1);
u5.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 35 ]]
    -- upvalues: u6 (ref), u8 (copy), u5 (copy)
    if not u6 then
        u8.x1 = u5.PosOffsetY;
    end;
end;
function u5.Resize() --[[ Line: 41 ]]
    -- upvalues: u5 (copy), u8 (copy)
    u5.PosOffsetX = u5.SizeX / -2;
    u5.PosOffsetY = u8:Value();
end;
local v9 = v1.TextBox(u5, "Clipboard");
v9.TextSize = 12 * v1.roblox_messing_with_guis_factor;
v9.TextAlignment = "Center";
v9.BackgroundColor = v1.Color2;
v9.SizeScaleX = 1;
v9.SizeOffsetX = -40;
v9.SizeOffsetY = 40;
v1.DragBar(v9, u5);
local v10 = v1.TextBox(u5, "x");
v10.TextSize = 12 * v1.roblox_messing_with_guis_factor;
v10.TextAlignment = "Center";
v10.SizeOffsetX = 40;
v10.SizeOffsetY = 40;
v10.PosOffsetX = -40;
v10.PosScaleX = 1;
local u11 = v1.TextBox(u5);
u11.Editable = true;
u11.PosOffsetX = 10;
u11.PosOffsetY = 50;
u11.SizeScaleX = 1;
u11.SizeScaleY = 1;
u11.SizeOffsetX = -20;
u11.SizeOffsetY = -60;
u11.BackgroundColor = l__Color__2(255, 255, 255);
u11.TextColor = l__Color__2(112, 110, 106);
u11.TextFont = Enum.Font.SourceSansBold;
u11.TextSize = 18;
u11.TextAlignment = "TopLeft";
local u12 = false;
function v10.Button1Down() --[[ Line: 82 ]]
    -- upvalues: u12 (ref), l__FreeMouse__3 (copy), u8 (copy), u5 (copy)
    u12 = false;
    l__FreeMouse__3("Clipboard", false);
    u8:Target(0, function() --[[ Line: 85 ]]
        -- upvalues: u5 (ref)
        u5.Visible = false;
    end);
end;
local function v13() --[[ Line: 99 ]]
    -- upvalues: u12 (ref), l__FreeMouse__3 (copy), u8 (copy), u5 (copy)
    if u12 then
        u12 = false;
        l__FreeMouse__3("Clipboard", false);
        u8:Target(0, function() --[[ Line: 85 ]]
            -- upvalues: u5 (ref)
            u5.Visible = false;
        end);
    else
        u12 = true;
        l__FreeMouse__3("Clipboard", true);
        u5.Visible = true;
        u8:Target(-u5.Parent.SizeY / 2 - u5.SizeY / 2);
    end;
end;
v3.Add("SetClipboardText", function(p14) --[[ Line: 107 ]]
    -- upvalues: u11 (copy)
    u11.Text = p14;
end);
v4.Add("clip", {}, v13);
return true;
