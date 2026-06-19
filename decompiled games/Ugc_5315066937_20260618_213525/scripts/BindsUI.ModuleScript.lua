-- Decompiled from: BindsUI
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__obtain__1 = _G.obtain;
local u2 = l__obtain__1("QBox");
local l__Color__2 = u2.Color;
local l__FreeMouse__3 = u2.FreeMouse;
local l__New__4 = u2.New;
local l__TextBox__5 = u2.TextBox;
local v3 = l__obtain__1("Command");
local l__Profile__6 = l__obtain__1("PersistentData").Profile;
local v4 = l__obtain__1("InputBinds");
local l__Game__7 = v4.Game;
local l__Hotkey__8 = v4.Hotkey;
local l__BindListener__9 = v4.BindListener;
local l__Call__10 = l__obtain__1("Remote").Call;
local l__Add__11 = l__obtain__1("Local").Add;
local v5 = l__obtain__1("Tween");
l__BindListener__9:SetBind("BindsInputKeyboard", "Keyboard");
l__BindListener__9:SetBind("BindsInputMouse1", "MouseButton1");
l__BindListener__9:SetBind("BindsInputMouse2", "MouseButton2");
l__BindListener__9:SetBind("BindsInputMouse3", "MouseButton3");
local u6 = {
    "MoveUp",
    "MoveDown",
    "LookUp",
    "LookDown",
    "LookLeft",
    "LookRight",
    "Jump",
    "Zoom"
};
local u7 = {
    "Reset",
    "ToggleFly",
    "AddPaint",
    "RemovePaint",
    "ToggleTurnFast",
    "HoldToTurnFast",
    "SaveState",
    "LoadState",
    "DecrementSaveState",
    "IncrementSaveState"
};
local u8 = {
    Game = {
        MoveUp = "E",
        MoveDown = "Q",
        LookUp = false,
        LookDown = false,
        LookLeft = false,
        LookRight = false,
        Jump = "Space",
        Zoom = "Z"
    },
    Hotkey = {
        Reset = "R",
        ToggleFly = "F",
        AddPaint = "MouseButton1",
        RemovePaint = "MouseButton2",
        ToggleTurnFast = false,
        HoldToTurnFast = false,
        SaveState = "One",
        LoadState = "Two",
        DecrementSaveState = "Three",
        IncrementSaveState = "Four"
    }
};
local u9 = {
    MoveForward = true,
    MoveLeft = true,
    MoveBack = true,
    MoveRight = true
};
local u10 = {
    Game = l__Game__7,
    Hotkey = l__Hotkey__8
};
local u11 = l__New__4();
u11.Visible = false;
u11.DrawBackground = false;
u11.SizeOffsetX = 400;
u11.SizeOffsetY = 550;
u11.PosScaleX = 0.5;
u11.PosScaleY = 1;
local u12 = false;
local u14 = v5.New(0, function(p13) --[[ Line: 88 ]]
    -- upvalues: u12 (ref), u11 (copy)
    u12 = true;
    u11.PosOffsetY = p13;
    u12 = false;
end);
u14.MaxAcceleration = v5.MaxAcceleration(0, u11.SizeY, 0, 0, 1);
u11.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 94 ]]
    -- upvalues: u12 (ref), u14 (copy), u11 (copy)
    if not u12 then
        u14.x1 = u11.PosOffsetY;
    end;
end;
function u11.Resize() --[[ Line: 100 ]]
    -- upvalues: u11 (copy), u14 (copy)
    u11.PosOffsetX = u11.SizeX / -2;
    u11.PosOffsetY = u14:Value();
end;
local v15 = l__TextBox__5(u11, "Binds");
v15.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v15.TextAlignment = "Center";
v15.BackgroundColor = u2.Color2;
v15.SizeScaleX = 1;
v15.SizeOffsetX = -40;
v15.SizeOffsetY = 40;
u2.DragBar(v15, u11);
local v16 = l__TextBox__5(u11, "x");
v16.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v16.TextAlignment = "Center";
v16.SizeOffsetX = 40;
v16.SizeOffsetY = 40;
v16.PosOffsetX = -40;
v16.PosScaleX = 1;
v16.BackgroundColor = u2.Color2;
local u17 = l__New__4();
u17.ZIndex = -1;
u17.DrawBackground = false;
u17.SizeScaleX = 1;
local v18 = l__New__4(u11);
v18.ZIndex = -1;
v18.PosOffsetY = 40;
v18.SizeScaleX = 1;
v18.SizeScaleY = 1;
v18.SizeOffsetY = -40;
u2.Scroll(u17, v18);
local u19 = {};
local u20 = {
    Game = {},
    Hotkey = {}
};
local u21 = false;
local u22 = false;
local u23 = false;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local function u32() --[[ Line: 157 ]]
    -- upvalues: u20 (copy), u10 (copy)
    for v28, v29 in u20 do
        for v30, v31 in v29 do
            v31.Text = u10[v28]:GetBindKeyFromName(v30) or "";
        end;
    end;
end;
local function u47(u33, u34, p35) --[[ Line: 177 ]]
    -- upvalues: l__New__4 (copy), u17 (copy), u11 (copy), u2 (copy), l__TextBox__5 (copy), u10 (copy), u22 (ref), u23 (ref), u25 (ref), u27 (ref), l__Color__2 (copy), u26 (ref), u24 (ref), u20 (copy), u19 (copy)
    local u36 = l__New__4(u17);
    u36.SizeOffsetX = u11.SizeOffsetX - 20 - 60;
    u36.SizeOffsetY = 25;
    u36.PosOffsetX = 10;
    u36.PosOffsetY = p35;
    u36.DrawBackground = true;
    u36.BackgroundColor = u2.Color1;
    local v37 = l__TextBox__5(u36, u34);
    v37.TextSize = 10 * u2.roblox_messing_with_guis_factor;
    v37.TextAlignment = "Left";
    v37.DrawBackground = false;
    v37.SizeScaleX = 1;
    v37.SizeScaleY = 1;
    local u38 = l__TextBox__5(u36, u10[u33]:GetBindKeyFromName(u34) or "");
    u38.TextSize = 10 * u2.roblox_messing_with_guis_factor;
    u38.TextAlignment = "Right";
    u38.DrawBackground = false;
    u38.SizeScaleX = 1;
    u38.SizeScaleY = 1;
    u38.PosOffsetX = -30;
    local u39 = l__TextBox__5(u17, "x");
    u39.TextSize = 10 * u2.roblox_messing_with_guis_factor;
    u39.TextAlignment = "Center";
    u39.DrawBackground = true;
    u39.SizeOffsetX = 30;
    u39.SizeOffsetY = 25;
    u39.PosScaleX = 1;
    u39.PosOffsetX = -10 - u39.SizeOffsetX;
    u39.PosOffsetY = p35;
    function u39.Button1Down() --[[ Line: 210 ]]
        -- upvalues: u22 (ref), u23 (ref), u25 (ref), u34 (copy), u27 (ref), u33 (copy)
        if u22 and not u23 then
            u25 = u34;
            u23 = true;
            u27(u33, nil);
        end;
    end;
    function u39.Fade(p40) --[[ Line: 218 ]]
        -- upvalues: u2 (ref), u39 (copy), l__Color__2 (ref)
        local l__Color1__12 = u2.Color1;
        local l__Color2__13 = u2.Color2;
        local v41 = 1 - p40;
        u39.BackgroundColor = l__Color__2(l__Color1__12.r * v41 + l__Color2__13.r * p40, l__Color1__12.g * v41 + l__Color2__13.g * p40, l__Color1__12.b * v41 + l__Color2__13.b * p40, l__Color1__12.a * v41 + l__Color2__13.a * p40);
    end;
    u39.FadeDuration = 0.15;
    local u42 = l__TextBox__5(u17, "↪️");
    u42.TextSize = 10 * u2.roblox_messing_with_guis_factor;
    u42.TextAlignment = "Center";
    u42.DrawBackground = true;
    u42.SizeOffsetX = 30;
    u42.SizeOffsetY = 25;
    u42.PosScaleX = 1;
    u42.PosOffsetX = -10 - u39.SizeOffsetX - u42.SizeOffsetX;
    u42.PosOffsetY = p35;
    function u42.Button1Down() --[[ Line: 235 ]]
        -- upvalues: u22 (ref), u23 (ref), u26 (ref), u33 (copy), u34 (copy)
        if u22 and not u23 then
            u26(u33, u34);
        end;
    end;
    function u42.Fade(p43) --[[ Line: 241 ]]
        -- upvalues: u2 (ref), u42 (copy), l__Color__2 (ref)
        local l__Color1__14 = u2.Color1;
        local l__Color2__15 = u2.Color2;
        local v44 = 1 - p43;
        u42.BackgroundColor = l__Color__2(l__Color1__14.r * v44 + l__Color2__15.r * p43, l__Color1__14.g * v44 + l__Color2__15.g * p43, l__Color1__14.b * v44 + l__Color2__15.b * p43, l__Color1__14.a * v44 + l__Color2__15.a * p43);
    end;
    u42.FadeDuration = 0.15;
    function u36.Fade(p45) --[[ Line: 249 ]]
        -- upvalues: u2 (ref), u36 (copy), l__Color__2 (ref)
        local l__Color1__16 = u2.Color1;
        local l__Color2__17 = u2.Color2;
        local v46 = 1 - p45;
        u36.BackgroundColor = l__Color__2(l__Color1__16.r * v46 + l__Color2__17.r * p45, l__Color1__16.g * v46 + l__Color2__17.g * p45, l__Color1__16.b * v46 + l__Color2__17.b * p45, l__Color1__16.a * v46 + l__Color2__17.a * p45);
    end;
    u36.FadeDuration = 0.15;
    function u36.Button1Down() --[[ Line: 257 ]]
        -- upvalues: u22 (ref), u23 (ref), u38 (copy), u24 (ref), u33 (copy), u25 (ref), u34 (copy)
        if u22 and not u23 then
            u23 = true;
            u38.Text = "Press a key...";
            u24 = u33;
            u25 = u34;
        end;
    end;
    u20[u33][u34] = u38;
    table.insert(u19, u36);
    table.insert(u19, u39);
    table.insert(u19, u42);
end;
local function u55() --[[ Line: 273 ]]
    -- upvalues: l__TextBox__5 (copy), u17 (copy), u2 (copy), u19 (copy), u1 (copy), u6 (copy), u47 (copy), u7 (copy), u21 (ref)
    local v48 = 0;
    local v49 = l__TextBox__5(u17, "Game Controls");
    v49.TextSize = 11 * u2.roblox_messing_with_guis_factor;
    v49.TextAlignment = "Center";
    v49.BackgroundColor = u2.Color2;
    v49.SizeScaleX = 1;
    v49.SizeOffsetY = 25;
    v49.PosOffsetY = v48;
    table.insert(u19, v49);
    local v50 = v48 + 30;
    for _, v51 in u1, u6 do
        u47("Game", v51, v50);
        v50 = v50 + 30;
    end;
    local v52 = l__TextBox__5(u17, "Hotkey Controls");
    v52.TextSize = 11 * u2.roblox_messing_with_guis_factor;
    v52.TextAlignment = "Center";
    v52.BackgroundColor = u2.Color2;
    v52.SizeScaleX = 1;
    v52.SizeOffsetY = 25;
    v52.PosOffsetY = v50;
    table.insert(u19, v52);
    local v53 = v50 + 30;
    for _, v54 in u1, u7 do
        u47("Hotkey", v54, v53);
        v53 = v53 + 30;
    end;
    u17.SizeOffsetY = v53;
    u21 = true;
end;
function v16.Button1Down() --[[ Line: 300 ]]
    -- upvalues: u22 (ref), u23 (ref), u24 (ref), u25 (ref), l__FreeMouse__3 (copy), u14 (copy), u11 (copy)
    u22 = false;
    u23 = false;
    u24 = nil;
    u25 = nil;
    l__FreeMouse__3("Binds", false);
    u14:Target(0, function() --[[ Line: 306 ]]
        -- upvalues: u11 (ref)
        u11.Visible = false;
    end);
end;
local function u62(p56, p57, p58) --[[ Line: 313 ]]
    -- upvalues: u10 (copy), u9 (copy), u24 (ref), u25 (ref), u21 (ref), u55 (copy), u32 (copy), l__Game__7 (copy), l__Hotkey__8 (copy)
    local v59 = u10[p56];
    local v60 = v59:GetBindKeyFromName(p57);
    local v61 = v59:GetBindNameFromBindKey(p58);
    if v61 and u9[v61] then
        u24 = nil;
        u25 = nil;
        if u21 then
            u32();
        else
            u55();
        end;
    else
        if v60 then
            l__Game__7:SetBind(nil, v60);
            l__Hotkey__8:SetBind(nil, v60);
        end;
        if p58 then
            l__Game__7:SetBind(nil, p58);
            l__Hotkey__8:SetBind(nil, p58);
            v59:SetBind(p57, p58);
        end;
        if u21 then
            u32();
        else
            u55();
        end;
    end;
end;
local function u68(p63) --[[ Line: 339 ]]
    -- upvalues: u8 (copy), u10 (copy)
    local v64 = {};
    for v65, v66 in u8[p63] do
        local v67 = u10[p63]:GetBindKeyFromName(v65);
        if v67 ~= v66 then
            v64[v65] = v67;
        end;
    end;
    return v64;
end;
u27 = function(p69, p70) --[[ Line: 350 ]]
    -- upvalues: u23 (ref), u10 (copy), u62 (copy), u25 (ref), u68 (copy), l__Call__10 (copy), u24 (ref), u21 (ref), u55 (copy), u32 (copy)
    if u23 then
        u23 = false;
        if u10[p69] then
            u62(p69, u25, p70);
            l__Call__10("SetBinds", p69, (u68(p69)));
        end;
        u24 = nil;
        u25 = nil;
        if u21 then
            u32();
        else
            u55();
        end;
        return true;
    end;
end;
u26 = function(p71, p72) --[[ Line: 365 ]]
    -- upvalues: u8 (copy), u25 (ref), u23 (ref), u27 (ref)
    local v73 = u8[p71][p72];
    u25 = p72;
    u23 = true;
    u27(p71, v73);
end;
local u74 = nil;
u74 = l__Profile__6:MonitorKey("Binds", function(p75) --[[ Line: 374 ]]
    -- upvalues: u62 (copy), u21 (ref), u55 (copy), u32 (copy), u74 (ref)
    if p75 then
        for v76, v77 in p75 do
            for v78, v79 in v77 do
                u62(v76, v78, v79);
            end;
        end;
    end;
    if u21 then
        u32();
    else
        u55();
    end;
    u74();
    u74 = nil;
end);
l__BindListener__9:RegisterBindable("BindsInputKeyboard", function(p80, p81) --[[ Line: 387 ]]
    -- upvalues: u23 (ref), u27 (ref), u24 (ref)
    if p81 and (u23 and p80) then
        return u27(u24, p80);
    end;
end);
l__BindListener__9:RegisterBindable("BindsInputMouse1", function(p82) --[[ Line: 393 ]]
    -- upvalues: u23 (ref), u27 (ref), u24 (ref)
    if p82 and u23 then
        return u27(u24, "MouseButton1");
    end;
end);
l__BindListener__9:RegisterBindable("BindsInputMouse2", function(p83) --[[ Line: 399 ]]
    -- upvalues: u23 (ref), u27 (ref), u24 (ref)
    if p83 and u23 then
        return u27(u24, "MouseButton2");
    end;
end);
l__BindListener__9:RegisterBindable("BindsInputMouse3", function(p84) --[[ Line: 405 ]]
    -- upvalues: u23 (ref), u27 (ref), u24 (ref)
    if p84 and u23 then
        return u27(u24, "MouseButton3");
    end;
end);
l__Add__11("OpenBinds", function() --[[ Name: OpenBinds, Line 411 ]]
    -- upvalues: u22 (ref), l__FreeMouse__3 (copy), u11 (copy), u14 (copy), u21 (ref), u55 (copy), u32 (copy)
    u22 = true;
    l__FreeMouse__3("Binds", true);
    u11.Visible = true;
    u14:Target(-u11.Parent.SizeY / 2 - u11.SizeY / 2);
    if u21 then
        u32();
    else
        u55();
    end;
end);
v3.Add({ "binds", "keybinds" }, { "Boolean" }, function(p85) --[[ Line: 421 ]]
    -- upvalues: u22 (ref), l__FreeMouse__3 (copy), u11 (copy), u14 (copy), u21 (ref), u55 (copy), u32 (copy), u23 (ref), u24 (ref), u25 (ref)
    if p85 then
        u22 = true;
        l__FreeMouse__3("Binds", true);
        u11.Visible = true;
        u14:Target(-u11.Parent.SizeY / 2 - u11.SizeY / 2);
        if u21 then
            u32();
        else
            u55();
        end;
    else
        u22 = false;
        u23 = false;
        u24 = nil;
        u25 = nil;
        l__FreeMouse__3("Binds", false);
        u14:Target(0, function() --[[ Line: 306 ]]
            -- upvalues: u11 (ref)
            u11.Visible = false;
        end);
    end;
end);
v3.Add({ "binds", "keybinds" }, {}, function() --[[ Line: 428 ]]
    -- upvalues: u11 (copy), u22 (ref), u23 (ref), u24 (ref), u25 (ref), l__FreeMouse__3 (copy), u14 (copy), u21 (ref), u55 (copy), u32 (copy)
    if u11.Visible then
        u22 = false;
        u23 = false;
        u24 = nil;
        u25 = nil;
        l__FreeMouse__3("Binds", false);
        u14:Target(0, function() --[[ Line: 306 ]]
            -- upvalues: u11 (ref)
            u11.Visible = false;
        end);
    else
        u22 = true;
        l__FreeMouse__3("Binds", true);
        u11.Visible = true;
        u14:Target(-u11.Parent.SizeY / 2 - u11.SizeY / 2);
        if u21 then
            u32();
        else
            u55();
        end;
    end;
end);
return true;
