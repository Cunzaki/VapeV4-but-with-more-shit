-- Decompiled from: Product
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
local u4 = nil;
local u5 = nil;
local u6 = false;
local l__Color1__7 = u1.Color1;
local l__Color2__8 = u1.Color2;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = false;
v3.Add("OpenPrompt", function(p13, p14, p15, p16) --[[ Line: 50 ]]
    -- upvalues: u4 (ref), u9 (ref), u11 (ref), u10 (ref), u5 (ref), u6 (ref), l__FreeMouse__2 (copy), u8 (ref), u7 (ref), u1 (copy)
    u4 = p13;
    u9.Text = "Buy \'" .. p14 .. "\'";
    u11.Text = p16;
    u10.Text = "Purchase (" .. p15 .. "P)";
    u5 = true;
    u6 = true;
    l__FreeMouse__2("PromptPurchase", true);
    u8.Visible = true;
    u7:Target(u1.SizeY / 2 - u8.SizeY / 2);
end);
v3.Add("UpdatePrompt", function(p17) --[[ Line: 59 ]]
    -- upvalues: u5 (ref), u11 (ref)
    if u5 then
        u5 = false;
        u11.Text = p17;
    else
        u11.Text = u11.Text .. "\n" .. p17;
    end;
end);
v3.Add("ClosePrompt", function() --[[ Line: 69 ]]
    -- upvalues: u6 (ref), l__FreeMouse__2 (copy), u7 (ref), u8 (ref)
    u6 = false;
    l__FreeMouse__2("PromptPurchase", false);
    u7:Target(-u8.SizeY / 2, function() --[[ Line: 38 ]]
        -- upvalues: u8 (ref)
        u8.Visible = false;
    end);
end);
return function() --[[ Line: 74 ]]
    -- upvalues: u8 (ref), u1 (copy), u7 (ref), u2 (copy), u12 (ref), u9 (ref), l__ColourLerp__3 (copy), l__Color1__7 (copy), l__Color2__8 (copy), u11 (ref), l__ResizeToText__4 (copy), l__new__6 (copy), u10 (ref), l__Call__5 (copy), u4 (ref), u6 (ref), l__FreeMouse__2 (copy)
    u8 = u1.New();
    u8.DrawBackground = false;
    u8.Visible = false;
    u8.SizeOffsetX = 300;
    u8.SizeOffsetY = 200;
    u8.PosScaleX = 0.5;
    u8.PosOffsetX = u8.SizeX / -2;
    u8.PosOffsetY = -u8.SizeY;
    u7 = u2.New(u8.PosY, function(p18) --[[ Line: 85 ]]
        -- upvalues: u12 (ref), u8 (ref)
        u12 = true;
        u8.PosOffsetY = p18;
        u12 = false;
    end);
    spawn(function() --[[ Line: 90 ]]
        -- upvalues: u1 (ref), u7 (ref), u2 (ref)
        while not u1.SizeY do
            wait();
        end;
        u7.MaxAcceleration = u2.MaxAcceleration(0, u1.SizeY, 0, 0, 0.5);
    end);
    function u8.Moved() --[[ Line: 95 ]]
        -- upvalues: u7 (ref), u8 (ref)
        if not u7.Tweening then
            u7.x1 = u8.PosOffsetY;
        end;
    end;
    u9 = u1.TextBox(u8, "Buy");
    u9.SizeScaleX = 1;
    u9.SizeOffsetX = -30;
    u9.SizeOffsetY = 30;
    u1.DragBar(u9, u8);
    local u19 = u1.TextBox(u8, "x");
    u19.PosOffsetX = -30;
    u19.PosScaleX = 1;
    u19.SizeOffsetX = 30;
    u19.SizeOffsetY = 30;
    function u19.Fade(p20) --[[ Line: 115 ]]
        -- upvalues: u19 (copy), l__ColourLerp__3 (ref), l__Color1__7 (ref), l__Color2__8 (ref)
        u19.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p20);
    end;
    local v21 = u1.New(u8);
    v21.BackgroundColor = u1.Color0;
    v21.PosOffsetY = 30;
    v21.SizeScaleX = 1;
    v21.SizeScaleY = 1;
    v21.SizeOffsetY = -60;
    u11 = u1.TextBox(nil, "Gaming");
    u11.BackgroundColor = u1.Color0;
    u11.SizeScaleX = 1;
    u11.SizeOffsetY = 140;
    u11.TextWraps = true;
    u11.TextAlignment = "TopLeft";
    function u11.TextResize() --[[ Line: 134 ]]
        -- upvalues: l__ResizeToText__4 (ref), u11 (ref), l__new__6 (ref)
        l__ResizeToText__4(u11, l__new__6(u11.SizeX, (1 / 0)), true);
    end;
    u1.Scroll(u11, v21);
    local u22 = u1.TextBox(u8, "Cancel");
    u22.PosScaleY = 1;
    u22.PosOffsetY = -30;
    u22.SizeScaleX = 0.5;
    u22.SizeOffsetY = 30;
    u10 = u1.TextBox(u8, "Purchase");
    u10.PosScaleX = 0.5;
    u10.PosScaleY = 1;
    u10.PosOffsetY = -30;
    u10.SizeScaleX = 0.5;
    u10.SizeOffsetY = 30;
    function u10.Button1Down() --[[ Line: 156 ]]
        -- upvalues: l__Call__5 (ref), u4 (ref)
        l__Call__5("ConfirmPromptID", u4);
    end;
    function u10.Fade(p23) --[[ Line: 159 ]]
        -- upvalues: u10 (ref), l__ColourLerp__3 (ref), l__Color1__7 (ref), l__Color2__8 (ref)
        u10.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p23);
    end;
    function u22.Fade(p24) --[[ Line: 162 ]]
        -- upvalues: u22 (copy), l__ColourLerp__3 (ref), l__Color1__7 (ref), l__Color2__8 (ref)
        u22.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p24);
    end;
    function u22.Button1Down() --[[ Line: 166 ]]
        -- upvalues: l__Call__5 (ref), u4 (ref)
        l__Call__5("ClosePromptID", u4);
    end;
    function u19.Button1Down() --[[ Line: 171 ]]
        -- upvalues: l__Call__5 (ref), u4 (ref), u6 (ref), l__FreeMouse__2 (ref), u7 (ref), u8 (ref)
        l__Call__5("ClosePromptID", u4, true);
        u6 = false;
        l__FreeMouse__2("PromptPurchase", false);
        u7:Target(-u8.SizeY / 2, function() --[[ Line: 38 ]]
            -- upvalues: u8 (ref)
            u8.Visible = false;
        end);
    end;
end;
