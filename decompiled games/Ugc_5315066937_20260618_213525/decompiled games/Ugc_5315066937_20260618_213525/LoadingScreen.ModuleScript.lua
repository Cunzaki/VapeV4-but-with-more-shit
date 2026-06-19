-- Decompiled from: LoadingScreen
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local l__FreeMouse__2 = u1.FreeMouse;
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Remote");
local u4 = u1.New();
u4.SizeScaleX = 1;
u4.SizeScaleY = 1;
u4.ZIndex = 1;
u4.BackgroundColor = u1.Color(0, 0, 0, 0);
u4.Visible = false;
local u6 = v2.New(0, function(p5) --[[ Line: 19 ]]
    -- upvalues: u4 (copy), u1 (copy)
    u4.BackgroundColor = u1.Color(0, 0, 0, p5);
end);
u6.MaxAcceleration = v2.MaxAcceleration(0, 255, 0, 0, 1);
local v7 = u1.TextBox(u4, "Loading...");
v7.DrawBackground = false;
v7.TextFont = Enum.Font.SourceSansBold;
v7.TextSize = 96;
v7.SizeOffsetX = v7.TextSizeX;
v7.SizeOffsetY = v7.TextSizeY;
v7.PosScaleX = 0.5;
v7.PosScaleY = 0.5;
v7.PosOffsetX = v7.SizeX / -2;
v7.PosOffsetY = v7.SizeY / -2;
local u8 = u1.TextBox(v7, "");
u8.DrawBackground = false;
u8.TextFont = Enum.Font.SourceSans;
u8.TextSize = 60;
u8.SizeOffsetX = u8.TextSizeX;
u8.SizeOffsetY = u8.TextSizeY;
u8.PosScaleX = 0.5;
u8.PosScaleY = 1;
u8.PosOffsetX = v7.SizeX / -2;
local v9 = u1.New(u4);
v9.BackgroundColor = u1.Color(0, 128, 128, 255);
v9.SizeOffsetY = 80;
v9.SizeScaleX = 0.8;
v9.PosScaleX = 0.1;
v9.PosScaleY = 0.8;
v9.PosOffsetY = -40;
local u10 = u1.New(v9);
u10.BackgroundColor = u1.Color(0, 204, 204, 255);
u10.SizeScaleX = 0;
u10.SizeScaleY = 1;
v3.Add("ActivateLoadingScreen", function(p11) --[[ Line: 60 ]]
    -- upvalues: u8 (copy), u4 (copy), u6 (copy), u10 (copy), l__FreeMouse__2 (copy)
    u8.Text = p11 or "";
    u8.SizeOffsetX = u8.TextSizeX;
    u8.SizeOffsetY = u8.TextSizeY;
    u8.PosOffsetX = u8.SizeX / -2;
    u4.Visible = true;
    u6:Target(255);
    u10.SizeScaleX = 0;
    l__FreeMouse__2("LoadingScreen", true);
end);
return true;
