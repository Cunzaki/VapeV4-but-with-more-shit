-- Decompiled from: PremiumPrompt
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local l__FreeMouse__2 = u1.FreeMouse;
local l__ColourLerp__3 = u1.ColourLerp;
local l__ResizeToText__4 = u1.ResizeToText;
local u2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Remote");
local l__Call__5 = v3.Call;
local l__new__6 = Vector2.new;
local u4 = false;
local l__Color1__7 = u1.Color1;
local l__Color2__8 = u1.Color2;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = false;
local function u11() --[[ Line: 32 ]]
    -- upvalues: u4 (ref), l__FreeMouse__2 (copy), u5 (ref), u6 (ref)
    u4 = false;
    l__FreeMouse__2("PromptPremium", false);
    u5:Target(-u6.SizeY / 2, function() --[[ Line: 35 ]]
        -- upvalues: u6 (ref)
        u6.Visible = false;
    end);
end;
v3.Add("OpenPromptPremium", function() --[[ Name: OpenPrompt, Line 40 ]]
    -- upvalues: u4 (ref), l__FreeMouse__2 (copy), u6 (ref), u5 (ref), u1 (copy)
    u4 = true;
    l__FreeMouse__2("PromptPremium", true);
    u6.Visible = true;
    u5:Target(u1.SizeY / 2 - u6.SizeY / 2);
end);
v3.Add("ClosePromptPremium", u11);
return function() --[[ Line: 51 ]]
    -- upvalues: u6 (ref), u1 (copy), u5 (ref), u2 (copy), u10 (ref), u7 (ref), l__ColourLerp__3 (copy), l__Color1__7 (copy), l__Color2__8 (copy), u9 (ref), l__ResizeToText__4 (copy), l__new__6 (copy), u8 (ref), l__Call__5 (copy), u11 (copy)
    u6 = u1.New();
    u6.DrawBackground = false;
    u6.Visible = false;
    u6.SizeOffsetX = 400;
    u6.SizeOffsetY = 300;
    u6.PosScaleX = 0.5;
    u6.PosOffsetX = u6.SizeX / -2;
    u6.PosOffsetY = -u6.SizeY;
    u5 = u2.New(u6.PosY, function(p12) --[[ Line: 62 ]]
        -- upvalues: u10 (ref), u6 (ref)
        u10 = true;
        u6.PosOffsetY = p12;
        u10 = false;
    end);
    spawn(function() --[[ Line: 67 ]]
        -- upvalues: u1 (ref), u5 (ref), u2 (ref)
        while not u1.SizeY do
            wait();
        end;
        u5.MaxAcceleration = u2.MaxAcceleration(0, u1.SizeY, 0, 0, 0.5);
    end);
    function u6.Moved() --[[ Line: 72 ]]
        -- upvalues: u5 (ref), u6 (ref)
        if not u5.Tweening then
            u5.x1 = u6.PosOffsetY;
        end;
    end;
    u7 = u1.TextBox(u6, "Personal Bots");
    u7.SizeScaleX = 1;
    u7.SizeOffsetX = -30;
    u7.SizeOffsetY = 30;
    u1.DragBar(u7, u6);
    local u13 = u1.TextBox(u6, "x");
    u13.PosOffsetX = -30;
    u13.PosScaleX = 1;
    u13.SizeOffsetX = 30;
    u13.SizeOffsetY = 30;
    function u13.Fade(p14) --[[ Line: 92 ]]
        -- upvalues: u13 (copy), l__ColourLerp__3 (ref), l__Color1__7 (ref), l__Color2__8 (ref)
        u13.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p14);
    end;
    local v15 = u1.New(u6);
    v15.BackgroundColor = u1.Color0;
    v15.PosOffsetY = 30;
    v15.SizeScaleX = 1;
    v15.SizeScaleY = 1;
    v15.SizeOffsetY = -60;
    u9 = u1.TextBox(nil, "The Personal Bots feature allows you to save bots (replays) for all your times.  Saving bots uses storage space, which is paid for through Roblox Premium.  Would you like to subscribe to Roblox Premium to auto save bots for all your times?  Right click on your replay on the Playerlist and press Save to save your current replay.  New replays will save automatically once you are subscribed.\n");
    u9.BackgroundColor = u1.Color0;
    u9.SizeScaleX = 1;
    u9.SizeOffsetY = 140;
    u9.TextWraps = true;
    u9.TextAlignment = "TopLeft";
    function u9.TextResize() --[[ Line: 111 ]]
        -- upvalues: l__ResizeToText__4 (ref), u9 (ref), l__new__6 (ref)
        l__ResizeToText__4(u9, l__new__6(u9.SizeX, (1 / 0)), true);
    end;
    u1.Scroll(u9, v15);
    local u16 = u1.TextBox(u6, "Cancel");
    u16.PosScaleY = 1;
    u16.PosOffsetY = -30;
    u16.SizeScaleX = 0.5;
    u16.SizeOffsetY = 30;
    u8 = u1.TextBox(u6, "Subscribe");
    u8.PosScaleX = 0.5;
    u8.PosScaleY = 1;
    u8.PosOffsetY = -30;
    u8.SizeScaleX = 0.5;
    u8.SizeOffsetY = 30;
    function u8.Button1Down() --[[ Line: 133 ]]
        -- upvalues: l__Call__5 (ref)
        l__Call__5("PromptPremiumPurchase");
    end;
    function u8.Fade(p17) --[[ Line: 136 ]]
        -- upvalues: u8 (ref), l__ColourLerp__3 (ref), l__Color1__7 (ref), l__Color2__8 (ref)
        u8.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p17);
    end;
    function u16.Fade(p18) --[[ Line: 139 ]]
        -- upvalues: u16 (copy), l__ColourLerp__3 (ref), l__Color1__7 (ref), l__Color2__8 (ref)
        u16.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p18);
    end;
    u16.Button1Down = u11;
    u13.Button1Down = u11;
end;
