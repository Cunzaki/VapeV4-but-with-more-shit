-- Decompiled from: Tutorial(surf)
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__GameID__2 = l__obtain__1("Game").GameID;
local v1 = l__obtain__1("QBox");
local l__FreeMouse__3 = v1.FreeMouse;
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Local");
local v4 = l__obtain__1("Remote");
local v5 = l__obtain__1("Command");
local u6 = v1.New();
u6.Visible = false;
u6.DrawBackground = false;
u6.SizeOffsetX = 400;
u6.SizeOffsetY = 700;
u6.PosScaleX = 0.5;
u6.PosScaleY = 1;
local u7 = false;
local u9 = v2.New(0, function(p8) --[[ Line: 27 ]]
    -- upvalues: u7 (ref), u6 (copy)
    u7 = true;
    u6.PosOffsetY = p8;
    u7 = false;
end);
u9.MaxAcceleration = v2.MaxAcceleration(0, u6.SizeY, 0, 0, 1);
u6.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 33 ]]
    -- upvalues: u7 (ref), u9 (copy), u6 (copy)
    if not u7 then
        u9.x1 = u6.PosOffsetY;
    end;
end;
function u6.Resize() --[[ Line: 39 ]]
    -- upvalues: u6 (copy), u9 (copy)
    u6.PosOffsetX = u6.SizeX / -2;
    u6.PosOffsetY = u9:Value();
end;
local v10 = v1.TextBox(u6, "Tutorial");
v10.TextSize = 12 * v1.roblox_messing_with_guis_factor;
v10.TextAlignment = "Center";
v10.BackgroundColor = v1.Color2;
v10.SizeScaleX = 1;
v10.SizeOffsetX = -40;
v10.SizeOffsetY = 40;
v1.DragBar(v10, u6);
local v11 = v1.TextBox(u6, "x");
v11.TextSize = 12 * v1.roblox_messing_with_guis_factor;
v11.TextAlignment = "Center";
v11.SizeOffsetX = 40;
v11.SizeOffsetY = 40;
v11.PosOffsetX = -40;
v11.PosScaleX = 1;
local v12 = v1.New(u6);
v12.SizeScaleX = 1;
v12.SizeScaleY = 1;
v12.SizeOffsetY = -40;
v12.PosOffsetY = 40;
local v13 = v1.New();
v13.SizeScaleX = 1;
local v14 = 15;
local v15 = v1.TextBox(v13, "Say !tutorial to open or close this tutorial.  To start surfing, get a running start and jump onto the surf.  Once you\'re surfing, you NEVER press W.");
v15.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v15.TextAlignment = "TopLeft";
v15.TextWraps = true;
v15.PosOffsetY = v14;
v15.SizeScaleX = 1;
v15.SizeOffsetY = 48;
local v16 = v14 + v15.SizeY + 15;
local v17 = v1.Image(v13, "rbxassetid://398629655");
v17.SizeOffsetX = 288;
v17.SizeOffsetY = 187;
v17.PosScaleX = 0.5;
v17.PosOffsetX = v17.SizeX / -2;
v17.PosOffsetY = v16;
local v18 = v16 + v17.SizeY + 15;
local v19 = v1.TextBox(v13, "Before you land on the surf, you need to be holding either the A or D key, depending on which side you land on.");
v19.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v19.TextAlignment = "TopLeft";
v19.TextWraps = true;
v19.PosOffsetY = v18;
v19.SizeScaleX = 1;
v19.SizeOffsetY = 32;
local v20 = v18 + v19.SizeY + 15;
local v21 = v1.Image(v13, "rbxassetid://398630118");
v21.SizeOffsetX = 380;
v21.SizeOffsetY = 288;
v21.PosOffsetY = v20;
local v22 = v20 + v21.SizeY + 15;
local v23 = v1.TextBox(v13, "To stay on the surf, look straight ahead.  You can move towards the top of the surf by looking slightly towards the top, and move towards the bottom by looking slightly towards the bottom.");
v23.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v23.TextAlignment = "TopLeft";
v23.TextWraps = true;
v23.PosOffsetY = v22;
v23.SizeScaleX = 1;
v23.SizeOffsetY = 64;
local v24 = v22 + v23.SizeY + 15;
local v25 = v1.Image(v13, "rbxassetid://398630266");
v25.SizeOffsetX = 380;
v25.SizeOffsetY = 423;
v25.PosOffsetY = v24;
local v26 = v24 + v25.SizeY + 15;
local v27 = v1.TextBox(v13, "When you reach the end of the surf and there\'s a big gap to the next one, you\'ll want to launch yourself into the air by gently curving towards the top of the surf.  One of the hardest parts of surfing is launching yourself just the right amount, so don\'t worry if it doesn\'t work right the first time!\n\nStrafing:\nTo navigate through the air to the next surf, you need to know how to strafe.  To turn right, hold the D key and then move the mouse to the right.  To turn left, hold the A key and then move the mouse to the left.  Make sure you are pressing the key before you start turning.\n\nLanding:\nMost people learning how to surf lose lots of speed by crashing into them at a sharp angle.  When you land, you will keep more speed if you land parallel to the surface, almost like you\'re already surfing on it and moving towards the bottom.\n\nHappy cursing!  I mean uh... surfing :)");
v27.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v27.TextAlignment = "TopLeft";
v27.TextWraps = true;
v27.PosOffsetY = v26;
v27.SizeScaleX = 1;
v27.SizeOffsetY = 336;
v13.SizeOffsetY = v26 + v27.SizeY + 15;
v1.Scroll(v13, v12);
local u28 = false;
function v11.Button1Down() --[[ Line: 145 ]]
    -- upvalues: u28 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    u28 = false;
    l__FreeMouse__3("Tutorial", false);
    u9:Target(0, function() --[[ Line: 148 ]]
        -- upvalues: u6 (ref)
        u6.Visible = false;
    end);
end;
local function v29() --[[ Line: 155 ]]
    -- upvalues: u28 (ref), l__FreeMouse__3 (copy), u6 (copy), u9 (copy)
    u28 = true;
    l__FreeMouse__3("Tutorial", true);
    u6.Visible = true;
    u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
end;
local function v30() --[[ Line: 162 ]]
    -- upvalues: u28 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    if u28 then
        u28 = false;
        l__FreeMouse__3("Tutorial", false);
        u9:Target(0, function() --[[ Line: 148 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    else
        u28 = true;
        l__FreeMouse__3("Tutorial", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end;
if l__GameID__2 == 2 then
    v3.Add("OpenTutorial", v29);
    v4.Add("OpenTutorial", v29);
    v4.Add("ToggleTutorial", v30);
end;
v5.Add("surftutorial", {}, function() --[[ Line: 175 ]]
    -- upvalues: u28 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    if u28 then
        u28 = false;
        l__FreeMouse__3("Tutorial", false);
        u9:Target(0, function() --[[ Line: 148 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    else
        u28 = true;
        l__FreeMouse__3("Tutorial", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end);
return true;
