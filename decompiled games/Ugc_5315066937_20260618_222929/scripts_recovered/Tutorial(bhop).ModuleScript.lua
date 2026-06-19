-- Decompiled from: Tutorial(bhop)
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
local v14 = v1.TextBox(v13, "1. Hold spacebar.\n2. Hold D while turning right.\n3. Hold A while turning left.\n4. DO NOT press W while jumping.\n\n\tWelcome to bhop!  Say !tutorial to open or close this tutorial.\n\n\tMost of your questions can be answered by other players, ask around if you\'re confused about something.  This is your first time playing, so if you haven\'t bhopped before, this is very important.\n\n\tIt\'s difficult to get the hang of it right away, but you will get better at it very quickly.  You can get a running start before you start jumping using W, but pressing W while jumping makes it much more difficult to gain speed.\n\tYou gain speed by STRAFING.  Strafing is when you hold the D key and move your mouse right, or hold the A key and turn your mouse left.  There is a sweet spot for how fast you should move your mouse to gain the most speed, but moving the mouse smoothly is critical to speed up quickly.  Practice, practice, practice.\n");
v14.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v14.TextAlignment = "TopLeft";
v14.TextWraps = true;
v14.SizeScaleX = 1;
v14.SizeOffsetY = 490;
local v15 = v1.TextBox(v13, "SURFING:\n\n\tSurfing is a whole different game.  Literally.  Check my other games.  However, sometimes there is some surfing in bhop maps.\n\nSurfing guidelines:\n\n1. It doesn\'t matter if you are pressing space.\n2. If you are on the right side of the surf, hold only A.\n3. If you are on the left side of the surf, hold only D.\n4. Look straight ahead on the surf.\n\n\tIf /\\ is the surf, then the key you should be holding depending on shich side you\'re on is: D /\\ A\n\nIf you are looking down the slope, you will go down, and if you are looking up the slope, you will go up.\n\nCHANGING MAPS:\n\n\tSay !rtv to vote to change the map.  Once enough players do so, the voting gui will appear.  Use the scroll wheel to select an option, or hold tab and use the mouse.\n\n\tGood luck on your bhopping adventures, remember to ask questions if you are confused, and help others to learn to play!\n");
v15.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v15.TextAlignment = "TopLeft";
v15.TextWraps = true;
v15.SizeScaleX = 1;
v15.PosOffsetY = 490;
v15.SizeOffsetY = 450;
v13.SizeOffsetY = 940;
v1.Scroll(v13, v12);
local u16 = false;
function v11.Button1Down() --[[ Line: 126 ]]
    -- upvalues: u16 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    u16 = false;
    l__FreeMouse__3("Tutorial", false);
    u9:Target(0, function() --[[ Line: 129 ]]
        -- upvalues: u6 (ref)
        u6.Visible = false;
    end);
end;
local function v17() --[[ Line: 136 ]]
    -- upvalues: u16 (ref), l__FreeMouse__3 (copy), u6 (copy), u9 (copy)
    u16 = true;
    l__FreeMouse__3("Tutorial", true);
    u6.Visible = true;
    u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
end;
local function v18() --[[ Line: 143 ]]
    -- upvalues: u16 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    if u16 then
        u16 = false;
        l__FreeMouse__3("Tutorial", false);
        u9:Target(0, function() --[[ Line: 129 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    else
        u16 = true;
        l__FreeMouse__3("Tutorial", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end;
if l__GameID__2 == 1 then
    v3.Add("OpenTutorial", v17);
    v4.Add("OpenTutorial", v17);
    v4.Add("ToggleTutorial", v18);
end;
v5.Add("bhoptutorial", {}, function() --[[ Line: 156 ]]
    -- upvalues: u16 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    if u16 then
        u16 = false;
        l__FreeMouse__3("Tutorial", false);
        u9:Target(0, function() --[[ Line: 129 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    else
        u16 = true;
        l__FreeMouse__3("Tutorial", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end);
return true;
