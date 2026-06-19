-- Decompiled from: Console
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local u1 = warn;
local _ = table.sort;
local _ = table.insert;
local _ = table.remove;
local _ = table.concat;
local _ = string.format;
local l__obtain__1 = _G.obtain;
local _ = l__obtain__1("Game").GameID;
local v2 = l__obtain__1("QBox");
local _ = v2.Color;
local l__FreeMouse__2 = v2.FreeMouse;
local _ = v2.TextBox;
local _ = v2.FromList;
local v3 = l__obtain__1("Tween");
local v4 = l__obtain__1("Local");
local v5 = l__obtain__1("Remote");
local _ = v5.Call;
local v6 = l__obtain__1("Command");
local u7 = l__obtain__1("date");
local u8 = v2.New();
u8.Visible = false;
u8.DrawBackground = false;
u8.SizeOffsetX = 600;
u8.SizeOffsetY = 700;
u8.PosScaleX = 0.5;
u8.PosScaleY = 1;
local u9 = false;
local u11 = v3.New(0, function(p10) --[[ Line: 42 ]]
    -- upvalues: u9 (ref), u8 (copy)
    u9 = true;
    u8.PosOffsetY = p10;
    u9 = false;
end);
u11.MaxAcceleration = v3.MaxAcceleration(0, u8.SizeY, 0, 0, 1);
u8.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 48 ]]
    -- upvalues: u9 (ref), u11 (copy), u8 (copy)
    if not u9 then
        u11.x1 = u8.PosOffsetY;
    end;
end;
function u8.Resize() --[[ Line: 54 ]]
    -- upvalues: u8 (copy), u11 (copy)
    u8.PosOffsetX = u8.SizeX / -2;
    u8.PosOffsetY = u11:Value();
end;
local v12 = v2.TextBox(u8, "Console");
v12.TextSize = 12 * v2.roblox_messing_with_guis_factor;
v12.TextAlignment = "Center";
v12.BackgroundColor = v2.Color2;
v12.SizeScaleX = 1;
v12.SizeOffsetX = -40;
v12.SizeOffsetY = 40;
v2.DragBar(v12, u8);
local v13 = v2.TextBox(u8, "x");
v13.TextSize = 12 * v2.roblox_messing_with_guis_factor;
v13.TextAlignment = "Center";
v13.SizeOffsetX = 40;
v13.SizeOffsetY = 40;
v13.PosOffsetX = -40;
v13.PosScaleX = 1;
local v14 = v2.New(u8);
v14.SizeScaleX = 1;
v14.SizeScaleY = 1;
v14.SizeOffsetY = -40;
v14.PosOffsetY = 40;
local v15 = v2.New();
v15.SizeScaleX = 1;
local v16 = 0 + 10;
local v17 = v2.TextBox(v15, "Empty");
v17.TextSize = 20 * v2.roblox_messing_with_guis_factor;
v17.TextAlignment = "Left";
v17.TextWraps = true;
v17.SizeScaleX = 1;
v17.PosOffsetX = 10;
v17.PosOffsetY = v16;
v17.SizeOffsetX = -20;
v17.SizeOffsetY = 30;
v5.Add("AddConsoleLine", function(p18) --[[ Line: 103 ]]
    -- upvalues: u1 (copy)
    u1("[Server]" .. p18);
end);
v5.Add("AddConsoleLines", function(p19) --[[ Line: 112 ]]
    -- upvalues: u1 (copy), u7 (copy)
    print("Dumping server console lines...");
    for _, v20 in p19 do
        u1("[Server " .. u7("%X", v20.timestamp) .. "] " .. v20.message);
    end;
end);
v15.SizeOffsetY = v16 + v17.SizeY + 10;
v2.Scroll(v15, v14);
local u21 = false;
function v13.Button1Down() --[[ Line: 128 ]]
    -- upvalues: u21 (ref), l__FreeMouse__2 (copy), u11 (copy), u8 (copy)
    u21 = false;
    l__FreeMouse__2("Console", false);
    u11:Target(0, function() --[[ Line: 131 ]]
        -- upvalues: u8 (ref)
        u8.Visible = false;
    end);
end;
local function v22() --[[ Line: 138 ]]
    -- upvalues: u21 (ref), l__FreeMouse__2 (copy), u8 (copy), u11 (copy)
    u21 = true;
    l__FreeMouse__2("Console", true);
    u8.Visible = true;
    u11:Target(-u8.Parent.SizeY / 2 - u8.SizeY / 2);
end;
v4.Add("OpenConsole", v22);
v5.Add("OpenConsole", v22);
v6.Add("/", {}, function() --[[ Line: 148 ]]
    -- upvalues: u21 (ref), l__FreeMouse__2 (copy), u11 (copy), u8 (copy)
    if u21 then
        u21 = false;
        l__FreeMouse__2("Console", false);
        u11:Target(0, function() --[[ Line: 131 ]]
            -- upvalues: u8 (ref)
            u8.Visible = false;
        end);
    else
        u21 = true;
        l__FreeMouse__2("Console", true);
        u8.Visible = true;
        u11:Target(-u8.Parent.SizeY / 2 - u8.SizeY / 2);
    end;
end);
return true;
