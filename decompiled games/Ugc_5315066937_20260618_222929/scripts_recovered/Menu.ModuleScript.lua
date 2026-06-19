-- Decompiled from: Menu
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local l__Color__2 = u1.Color;
local l__FreeMouse__3 = u1.FreeMouse;
local l__TextBox__4 = u1.TextBox;
local l__FromList__5 = u1.FromList;
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Local");
local l__GetCallFunction__6 = v3.GetCallFunction;
local l__GetCallFunction__7 = l__obtain__1("Remote").GetCallFunction;
local v4 = l__obtain__1("Spectate");
local v5 = l__obtain__1("Command");
local l__Gui__8 = l__obtain__1("InputBinds").Gui;
local u6 = u1.New();
u6.Visible = false;
u6.DrawBackground = false;
u6.SizeOffsetX = 400;
u6.SizeOffsetY = 700;
u6.PosScaleX = 0.5;
u6.PosScaleY = 1;
local u7 = false;
local u9 = v2.New(0, function(p8) --[[ Line: 39 ]]
    -- upvalues: u7 (ref), u6 (copy)
    u7 = true;
    u6.PosOffsetY = p8;
    u7 = false;
end);
u9.MaxAcceleration = v2.MaxAcceleration(0, u6.SizeY, 0, 0, 1);
u6.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 45 ]]
    -- upvalues: u7 (ref), u9 (copy), u6 (copy)
    if not u7 then
        u9.x1 = u6.PosOffsetY;
    end;
end;
function u6.Resize() --[[ Line: 51 ]]
    -- upvalues: u6 (copy), u9 (copy)
    u6.PosOffsetX = u6.SizeX / -2;
    u6.PosOffsetY = u9:Value();
end;
local v10 = u1.TextBox(u6, "Menu");
v10.TextSize = 12 * u1.roblox_messing_with_guis_factor;
v10.TextAlignment = "Center";
v10.BackgroundColor = u1.Color2;
v10.SizeScaleX = 1;
v10.SizeOffsetX = -40;
v10.SizeOffsetY = 40;
u1.DragBar(v10, u6);
local v11 = u1.TextBox(u6, "x");
v11.TextSize = 12 * u1.roblox_messing_with_guis_factor;
v11.TextAlignment = "Center";
v11.SizeOffsetX = 40;
v11.SizeOffsetY = 40;
v11.PosOffsetX = -40;
v11.PosScaleX = 1;
local u12 = u1.New();
u12.DrawBackground = false;
u12.SizeScaleX = 1;
local v13 = u1.New(u6);
v13.PosOffsetY = 40;
v13.SizeScaleX = 1;
v13.SizeScaleY = 1;
v13.SizeOffsetY = -40;
u1.Scroll(u12, v13);
local u14 = false;
function v11.Button1Down() --[[ Line: 90 ]]
    -- upvalues: u14 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    u14 = false;
    l__FreeMouse__3("Menu", false);
    u9:Target(0, function() --[[ Line: 93 ]]
        -- upvalues: u6 (ref)
        u6.Visible = false;
    end);
end;
local v15 = {
    {
        Title = "Change Style (/style)",
        Activate = l__GetCallFunction__6("OpenStyleSelect")
    },
    {
        Title = "Spectate (/spec)",
        Activate = v4.Prev
    },
    {
        Title = "World Records (/wr)",
        Activate = l__GetCallFunction__6("OpenWRList")
    },
    {
        Title = "Nominate a Map (/nominate)",
        Activate = l__GetCallFunction__6("OpenNominate")
    },
    {
        Title = "Rock the Vote (/rtv)",
        Activate = l__GetCallFunction__7("rtv")
    },
    {
        Title = "Server List (/serverlist)",
        Activate = l__GetCallFunction__6("OpenServerList")
    },
    {
        Title = "Shop (/shop)",
        Activate = l__GetCallFunction__6("OpenShop")
    },
    {
        Title = "Change Nametag (/tag)",
        Activate = l__GetCallFunction__6("GutenTag")
    },
    {
        Title = "Open Tutorial (/tutorial)",
        Activate = l__GetCallFunction__7("OpenTutorial")
    },
    {
        Title = "Restart to the Beginning of the Map (/r)",
        Activate = l__GetCallFunction__6("SpawnCharacter")
    },
    {
        Title = "View in-game leaderboard/chat rules (/rules)",
        Activate = l__GetCallFunction__7("OpenRules")
    },
    {
        Title = "Manage key binds (/binds)",
        Activate = l__GetCallFunction__6("OpenBinds")
    }
};
u12.SizeOffsetY = #v15 * 40;
l__FromList__5(v15, function(_, u16) --[[ Line: 152 ]]
    -- upvalues: l__TextBox__4 (copy), u12 (copy), u1 (copy), l__Color__2 (copy), u14 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    local u17 = l__TextBox__4(u12, u16.Title);
    u17.TextAlignment = "Center";
    function u17.Fade(p18) --[[ Line: 156 ]]
        -- upvalues: u17 (copy), u1 (ref), l__Color__2 (ref)
        local v19 = u17;
        local l__Color1__9 = u1.Color1;
        local l__Color2__10 = u1.Color2;
        local v20 = 1 - p18;
        v19.BackgroundColor = l__Color__2(l__Color1__9.r * v20 + l__Color2__10.r * p18, l__Color1__9.g * v20 + l__Color2__10.g * p18, l__Color1__9.b * v20 + l__Color2__10.b * p18, l__Color1__9.a * v20 + l__Color2__10.a * p18);
    end;
    u17.FadeDuration = 0.15;
    function u17.Button1Down() --[[ Line: 160 ]]
        -- upvalues: u14 (ref), u16 (copy), l__FreeMouse__3 (ref), u9 (ref), u6 (ref)
        if u14 then
            u16.Activate();
            u14 = false;
            l__FreeMouse__3("Menu", false);
            u9:Target(0, function() --[[ Line: 93 ]]
                -- upvalues: u6 (ref)
                u6.Visible = false;
            end);
        end;
    end;
    return u17;
end);
local function v21() --[[ Line: 178 ]]
    -- upvalues: u14 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    if u14 then
        u14 = false;
        l__FreeMouse__3("Menu", false);
        u9:Target(0, function() --[[ Line: 93 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    else
        u14 = true;
        l__FreeMouse__3("Menu", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end;
l__Gui__8:RegisterBindable("ToggleMenu", function(p22) --[[ Line: 186 ]]
    -- upvalues: u14 (ref), l__FreeMouse__3 (copy), u9 (copy), u6 (copy)
    if p22 == true then
        if u14 then
            u14 = false;
            l__FreeMouse__3("Menu", false);
            u9:Target(0, function() --[[ Line: 93 ]]
                -- upvalues: u6 (ref)
                u6.Visible = false;
            end);
            return;
        end;
        u14 = true;
        l__FreeMouse__3("Menu", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end, "M");
v3.Add("ToggleMenu", v21);
v5.Add("menu", {}, v21);
return true;
