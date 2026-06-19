-- Decompiled from: Spectators
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local l__remove__2 = table.remove;
local l__obtain__3 = _G.obtain;
local v1 = l__obtain__3("Tween");
local l__New__4 = v1.New;
local l__MaxAcceleration__5 = v1.MaxAcceleration;
local u2 = l__obtain__3("QBox");
local l__Color__6 = u2.Color;
local v3 = l__obtain__3("Remote");
local v4 = l__obtain__3("Command");
local l__LocalPlayer__7 = game:GetService("Players").LocalPlayer;
local u5 = l__Color__6(255, 255, 255, 128);
local u6 = l__Color__6(150, 255, 150, 128);
local u7 = Instance.new("AudioEmitter", l__obtain__3("RobloxCamera"));
local u8 = u2.New();
u8.PosScaleX = 0;
u8.PosScaleY = 0.5;
u8.DrawBackground = false;
u8.SizeOffsetX = 100;
u8.SizeOffsetY = 20;
local u10 = l__New__4(-u8.SizeOffsetX, function(p9) --[[ Line: 34 ]]
    -- upvalues: u8 (copy)
    u8.PosOffsetX = p9;
end);
u10.MaxAcceleration = l__MaxAcceleration__5(-u8.SizeOffsetX, 0, 0, 0, 1);
local u12 = l__New__4(u8.SizeOffsetX, function(p11) --[[ Line: 36 ]]
    -- upvalues: u8 (copy)
    u8.SizeOffsetX = p11;
end);
u12.MaxAcceleration = l__MaxAcceleration__5(0, u8.SizeOffsetX, 0, 0, 1);
local v13 = u2.TextBox(u8, "Spectators");
v13.TextAlignment = "Center";
v13.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v13.TextColor = l__Color__6(255, 255, 255, 255);
v13.BackgroundColor = l__Color__6(60, 60, 60, 192);
v13.SizeScaleX = 1;
v13.SizeOffsetX = -20;
v13.SizeOffsetY = 20;
u2.DragBar(v13, u8);
local u14 = l__Color__6(40, 40, 40, 192);
local u15 = l__Color__6(10, 10, 10, 192);
local u16 = l__Color__6(255, 255, 255, 255);
local u17 = l__Color__6(255, 0, 0, 255);
local u18 = u2.TextBox(u8, "x");
u18.TextAlignment = "Center";
u18.TextSize = 12 * u2.roblox_messing_with_guis_factor;
u18.TextColor = u16;
u18.SizeOffsetX = 20;
u18.SizeOffsetY = 20;
u18.PosScaleX = 1;
u18.PosOffsetX = -20;
u18.BackgroundColor = u14;
function u18.Fade(p19) --[[ Line: 67 ]]
    -- upvalues: u18 (copy), l__Color__6 (copy), u14 (copy), u15 (copy), u16 (copy), u17 (copy)
    local v20 = 1 - p19;
    u18.BackgroundColor = l__Color__6(u14.r * v20 + u15.r * p19, u14.g * v20 + u15.g * p19, u14.b * v20 + u15.b * p19, u14.a * v20 + u15.a * p19);
    u18.TextColor = l__Color__6(u16.r * v20 + u17.r * p19, u16.g * v20 + u17.g * p19, u16.b * v20 + u17.b * p19, u16.a * v20 + u17.a * p19);
end;
function u18.Button1Down() --[[ Line: 73 ]]
    -- upvalues: u8 (copy)
    u8.Visible = false;
end;
local u21 = u2.New(u8);
u21.DrawBackground = false;
u21.PosScaleY = 1;
u21.SizeScaleX = 1;
u21.SizeOffsetY = 30;
local u22 = {};
v3.Add("AddSpectator", function(p23) --[[ Line: 86 ]]
    -- upvalues: u22 (copy), u10 (copy), u2 (copy), u21 (copy), l__Color__6 (copy), l__New__4 (copy), l__MaxAcceleration__5 (copy), u5 (copy), l__LocalPlayer__7 (copy), u7 (copy), u6 (copy), u12 (copy)
    if p23 then
        if #u22 == 0 then
            u10:Target(0);
        end;
        local v24 = #u22 + 1;
        local u25 = u2.TextBox(u21, p23.Name);
        u25.TextAlignment = "Center";
        u25.TextColor = l__Color__6(255, 255, 255, 255);
        u25.DrawBackground = false;
        u25.SizeScaleX = 1;
        u25.SizeScaleY = 1;
        u25.PosScaleY = v24;
        local v27 = l__New__4(v24 - 1, function(p26) --[[ Line: 100 ]]
            -- upvalues: u25 (copy)
            u25.PosScaleY = p26;
        end);
        v27.MaxAcceleration = l__MaxAcceleration__5(0, 1, 0, 0, 1);
        local v29 = l__New__4(0, function(p28) --[[ Line: 102 ]]
            -- upvalues: u25 (copy), l__Color__6 (ref), u5 (ref)
            u25.TextColor = l__Color__6(u5.r, u5.g, u5.b, u5.a * p28);
        end);
        v29.MaxAcceleration = l__MaxAcceleration__5(0, 1, 0, 0, 1);
        v29:Target(1);
        local v30 = nil;
        local v31 = p23:FindFirstChild("AudioDeviceInput");
        local u32;
        if v31 then
            if p23 ~= l__LocalPlayer__7 then
                v30 = Instance.new("Wire", v31);
                v30.SourceInstance = v31;
                v30.TargetInstance = u7;
            end;
            u32 = Instance.new("AudioAnalyzer", v31);
            local v33 = Instance.new("Wire", u32);
            v33.SourceInstance = v31;
            v33.TargetInstance = u32;
            function u25.Think() --[[ Line: 117 ]]
                -- upvalues: u25 (copy), u2 (ref), u5 (ref), u6 (ref), u32 (ref)
                u25.TextColor = u2.ColourLerp(u5, u6, (math.min(u32.RmsLevel * 25, 1)));
            end;
        else
            u32 = nil;
        end;
        u22[v24] = {
            Player = p23,
            Gui = u25,
            AT = v29,
            PY = v27,
            Wire = v30,
            Analyzer = u32
        };
        local v34 = 100;
        for v35 = 1, #u22 do
            local l__TextSizeX__8 = u22[v35].Gui.TextSizeX;
            if v34 < l__TextSizeX__8 then
                v34 = l__TextSizeX__8;
            end;
        end;
        u12:Target(v34);
    end;
end);
v3.Add("RemoveSpectator", function(p36) --[[ Line: 133 ]]
    -- upvalues: u22 (copy), l__remove__2 (copy), u12 (copy), u10 (copy)
    for v37 = #u22, 1, -1 do
        local u38 = u22[v37];
        if u38.Player == p36 then
            l__remove__2(u22, v37);
            local l__AT__9 = u38.AT;
            l__AT__9:Target(0);
            function l__AT__9.Callback() --[[ Line: 140 ]]
                -- upvalues: l__AT__9 (copy), u38 (copy)
                l__AT__9:Remove();
                u38.Gui:Remove();
                u38.PY:Remove();
            end;
            if u38.Wire then
                u38.Wire:Destroy();
            end;
            if u38.Analyzer then
                u38.Analyzer:Destroy();
            end;
            u38.Gui.Think = nil;
        end;
    end;
    if #u22 > 0 then
        local v39 = 100;
        for v40 = 1, #u22 do
            local v41 = u22[v40];
            v41.PY:Target(v40 - 1);
            local l__TextSizeX__10 = v41.Gui.TextSizeX;
            if v39 < l__TextSizeX__10 then
                v39 = l__TextSizeX__10;
            end;
        end;
        u12:Target(v39);
    else
        u12:Target(100);
        u10:Target(-100);
    end;
end);
v3.Add("ClearSpectators", function() --[[ Line: 171 ]]
    -- upvalues: u22 (copy), u12 (copy), u10 (copy), l__clear__1 (copy)
    for v42 = 1, #u22 do
        local u43 = u22[v42];
        local l__AT__11 = u43.AT;
        l__AT__11:Target(0);
        function l__AT__11.Callback() --[[ Line: 176 ]]
            -- upvalues: l__AT__11 (copy), u43 (copy)
            l__AT__11:Remove();
            u43.Gui:Remove();
            u43.PY:Remove();
        end;
        if u43.Wire then
            u43.Wire:Destroy();
        end;
        if u43.Analyzer then
            u43.Analyzer:Destroy();
        end;
        u43.Gui.Think = nil;
    end;
    u12:Target(100);
    u10:Target(-100);
    l__clear__1(u22);
end);
v4.Add({ "spectators", "specs" }, { "Boolean" }, function(p44) --[[ Line: 194 ]]
    -- upvalues: u8 (copy)
    u8.Visible = p44;
end);
v4.Add({ "spectators", "specs" }, {}, function() --[[ Line: 197 ]]
    -- upvalues: u8 (copy)
    u8.Visible = not u8.Visible;
end);
return true;
