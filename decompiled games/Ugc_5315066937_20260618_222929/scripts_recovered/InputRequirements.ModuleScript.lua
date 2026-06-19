-- Decompiled from: InputRequirements
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
local l__new__5 = Vector2.new;
local l__UserInputService__6 = game:GetService("UserInputService");
local l__VRService__7 = game:GetService("VRService");
local l__LocalPlayer__8 = game:GetService("Players").LocalPlayer;
local u3 = false;
local l__Color1__9 = u1.Color1;
local l__Color2__10 = u1.Color2;
local u4 = nil;
local u5 = nil;
local u6 = false;
return function() --[[ Line: 50 ]]
    -- upvalues: u5 (ref), u1 (copy), u4 (ref), u2 (copy), u6 (ref), l__ColourLerp__3 (copy), l__Color1__9 (copy), l__Color2__10 (copy), l__ResizeToText__4 (copy), l__new__5 (copy), u3 (ref), l__FreeMouse__2 (copy), l__VRService__7 (copy), l__LocalPlayer__8 (copy), l__UserInputService__6 (copy)
    u5 = u1.New();
    u5.DrawBackground = false;
    u5.Visible = false;
    u5.SizeOffsetX = 400;
    u5.SizeOffsetY = 300;
    u5.PosScaleX = 0.5;
    u5.PosOffsetX = u5.SizeX / -2;
    u5.PosOffsetY = -u5.SizeY;
    u4 = u2.New(u5.PosY, function(p7) --[[ Line: 61 ]]
        -- upvalues: u6 (ref), u5 (ref)
        u6 = true;
        u5.PosOffsetY = p7;
        u6 = false;
    end);
    function u5.Moved() --[[ Line: 67 ]]
        -- upvalues: u4 (ref), u5 (ref)
        if not u4.Tweening then
            u4.x1 = u5.PosOffsetY;
        end;
    end;
    local v8 = u1.TextBox(u5, "Input Requirements");
    v8.SizeScaleX = 1;
    v8.SizeOffsetX = -30;
    v8.SizeOffsetY = 30;
    u1.DragBar(v8, u5);
    local u9 = u1.TextBox(u5, "x");
    u9.PosOffsetX = -30;
    u9.PosScaleX = 1;
    u9.SizeOffsetX = 30;
    u9.SizeOffsetY = 30;
    function u9.Fade(p10) --[[ Line: 87 ]]
        -- upvalues: u9 (copy), l__ColourLerp__3 (ref), l__Color1__9 (ref), l__Color2__10 (ref)
        u9.BackgroundColor = l__ColourLerp__3(l__Color1__9, l__Color2__10, p10);
    end;
    local v11 = u1.New(u5);
    v11.BackgroundColor = u1.Color0;
    v11.PosOffsetY = 30;
    v11.SizeScaleX = 1;
    v11.SizeScaleY = 1;
    v11.SizeOffsetY = -60;
    local u12 = u1.New(nil);
    u12.DrawBackground = false;
    u12.SizeScaleX = 1;
    local u13 = u1.TextBox(u12, "Gaming");
    u13.DrawBackground = false;
    u13.PosOffsetX = 10;
    u13.SizeOffsetX = -20;
    u13.SizeScaleX = 1;
    u13.SizeOffsetY = 140;
    u13.TextWraps = true;
    u13.TextAlignment = "TopLeft";
    function u13.TextResize() --[[ Line: 112 ]]
        -- upvalues: l__ResizeToText__4 (ref), u13 (copy), l__new__5 (ref), u12 (copy)
        l__ResizeToText__4(u13, l__new__5(u13.SizeX, (1 / 0)), true);
        u12.SizeOffsetY = u13.SizeY;
    end;
    u1.Scroll(u12, v11);
    local u14 = u1.TextBox(u5, "Ok");
    u14.PosScaleY = 1;
    u14.PosOffsetY = -30;
    u14.SizeScaleX = 1;
    u14.SizeOffsetY = 30;
    function u14.Fade(p15) --[[ Line: 128 ]]
        -- upvalues: u14 (copy), l__ColourLerp__3 (ref), l__Color1__9 (ref), l__Color2__10 (ref)
        u14.BackgroundColor = l__ColourLerp__3(l__Color1__9, l__Color2__10, p15);
    end;
    function u14.Button1Down() --[[ Line: 132 ]]
        -- upvalues: u3 (ref), l__FreeMouse__2 (ref), u4 (ref), u5 (ref)
        u3 = false;
        l__FreeMouse__2("PromptInput", false);
        u4:Target(-u5.SizeY / 2, function() --[[ Line: 36 ]]
            -- upvalues: u5 (ref)
            u5.Visible = false;
        end);
    end;
    function u9.Button1Down() --[[ Line: 135 ]]
        -- upvalues: u3 (ref), l__FreeMouse__2 (ref), u4 (ref), u5 (ref)
        u3 = false;
        l__FreeMouse__2("PromptInput", false);
        u4:Target(-u5.SizeY / 2, function() --[[ Line: 36 ]]
            -- upvalues: u5 (ref)
            u5.Visible = false;
        end);
    end;
    spawn(function() --[[ Line: 139 ]]
        -- upvalues: u1 (ref), u4 (ref), u2 (ref), l__VRService__7 (ref), l__LocalPlayer__8 (ref), l__UserInputService__6 (ref), u13 (copy), u3 (ref), l__FreeMouse__2 (ref), u5 (ref)
        while not u1.SizeY do
            wait();
        end;
        u4.MaxAcceleration = u2.MaxAcceleration(0, u1.SizeY, 0, 0, 0.5);
        if l__VRService__7.VREnabled then
            l__LocalPlayer__8:Kick("Please disconnect your VR headset before playing this game");
        end;
        if not (l__UserInputService__6.MouseEnabled and l__UserInputService__6.KeyboardEnabled) then
            u13.Text = "You must have a mouse and keyboard plugged in to play this game.  This game does not support alternative inputs as it does not make sense for the precise gameplay." .. "\n" .. "Mouse Detected:" .. (l__UserInputService__6.MouseEnabled and "Yes" or "No") .. "\n" .. "Keyboard Detected:" .. (l__UserInputService__6.KeyboardEnabled and "Yes" or "No");
            u3 = true;
            l__FreeMouse__2("PromptInput", true);
            u5.Visible = true;
            u4:Target(u1.SizeY / 2 - u5.SizeY / 2);
        end;
    end);
end;
