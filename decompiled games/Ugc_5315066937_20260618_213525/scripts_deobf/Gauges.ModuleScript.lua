-- Decompiled from: Gauges
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__band__1 = bit32.band;
local l__abs__2 = math.abs;
local l__sign__3 = math.sign;
local l__sqrt__4 = math.sqrt;
local l__clamp__5 = math.clamp;
local l__cos__6 = math.cos;
local l__sin__7 = math.sin;
local l__atan2__8 = math.atan2;
local l__insert__9 = table.insert;
local l__clear__10 = table.clear;
local l__match__11 = string.match;
local l__format__12 = string.format;
local l__new__13 = Vector3.new;
local u1 = l__new__13();
local l__Dot__14 = u1.Dot;
local l__new__15 = CFrame.new;
local l__IsA__16 = game.IsA;
local l__Clone__17 = game.Clone;
local l__obtain__18 = _G.obtain;
local v2 = l__obtain__18("CustomEnums");
local _ = v2.MODE_MAIN;
local l__TICKINFO_BIT_TICKEND__19 = v2.TICKINFO_BIT_TICKEND;
local l__TICKINFO_BIT_JUMP__20 = v2.TICKINFO_BIT_JUMP;
local l__TICKINFO_BIT_STRAFE__21 = v2.TICKINFO_BIT_STRAFE;
local l__TICKINFO_BIT_TOUCHING__22 = v2.TICKINFO_BIT_TOUCHING;
local v3 = l__obtain__18("QBox");
local l__Color__23 = v3.Color;
local v4 = l__obtain__18("Command");
local u5 = l__obtain__18("View");
local v6 = l__obtain__18("RenderManager");
local v7 = l__obtain__18("Simulation");
local v8 = l__obtain__18("GameControl");
local l__GetControlState__24 = v8.GetControlState;
local l__UnpackageControls__25 = v8.UnpackageControls;
local u9 = l__obtain__18("MapManager");
local v10 = l__obtain__18("RunManager");
local u11 = l__Color__23(255, 255, 255);
local v12 = l__Color__23(0, 0, 0);
local u13 = 0;
v4.Add("gaugemode", { "Integer" }, function(p14) --[[ Line: 61 ]]
    -- upvalues: u13 (ref)
    u13 = p14;
end);
local u15 = v3.Image(nil, "rbxassetid://342990539");
u15.Visible = false;
u15.DrawBackground = false;
u15.PosScaleX = 0.5;
u15.PosOffsetX = -211;
u15.PosScaleY = 1;
u15.PosOffsetY = -211;
u15.SizeOffsetX = 422;
u15.SizeOffsetY = 211;
v3.DragBar(u15, u15);
local u16 = v3.Image(u15, "rbxassetid://342999770");
u16.DrawBackground = false;
u16.SizeOffsetX = 240;
u16.SizeOffsetY = 60;
u16.PosScaleX = 0.5;
u16.PosScaleY = 1;
v4.Add({ "gauge", "g" }, {}, function() --[[ Line: 88 ]]
    -- upvalues: u15 (copy)
    u15.Visible = not u15.Visible;
    return "You have " .. (u15.Visible and "enabled" or "disabled") .. " the strafing gauge." .. (u15.Visible and "\nTry to keep the needle in the white area.\nRed means you\'re moving the mouse too fast, blue means too slow." or "");
end);
v4.Add({ "gauge", "g" }, { "Boolean" }, function(p17) --[[ Name: SetEnabledGauge, Line 84 ]]
    -- upvalues: u15 (copy)
    u15.Visible = p17;
    return "You have " .. (u15.Visible and "enabled" or "disabled") .. " the strafing gauge." .. (u15.Visible and "\nTry to keep the needle in the white area.\nRed means you\'re moving the mouse too fast, blue means too slow." or "");
end);
local u18 = v3.Image(nil, "rbxassetid://1001542903");
u18.Visible = false;
u18.DrawBackground = false;
u18.PosScaleX = 1;
u18.PosOffsetX = -211;
u18.PosScaleY = 1;
u18.PosOffsetY = -316.5;
u18.SizeOffsetX = 211;
u18.SizeOffsetY = 211;
v3.DragBar(u18, u18);
local u19 = v3.Image(u18, "rbxassetid://342999770");
u19.DrawBackground = false;
u19.SizeOffsetX = 120;
u19.SizeOffsetY = 30;
u19.PosScaleX = 0.5;
u19.PosScaleY = 0.5;
local u20 = v3.TextBox(u18, "0 u²/s²");
u20.DrawBackground = false;
u20.TextAlignment = "Center";
u20.AutoLocalize = false;
u20.DontCheckBounds = true;
u20.SizeScaleX = 1;
u20.SizeScaleY = 1;
u20.ZIndex = 6;
v3.DragBar(u20, u20);
local u21 = false;
local u22 = Instance.new("Part", workspace);
u22.Name = "MaxHeight";
u22.Anchored = true;
u22.CanCollide = false;
u22.BrickColor = BrickColor.new(310);
u22.Size = Vector3.new(2048, 2.8, 2048);
u22.TopSurface = Enum.SurfaceType.Smooth;
u22.BottomSurface = Enum.SurfaceType.Weld;
u22.Transparency = 1;
v4.Add("energy", {}, function() --[[ Line: 145 ]]
    -- upvalues: u18 (copy)
    u18.Visible = not u18.Visible;
    return "You have " .. (u18.Visible and "enabled" or "disabled") .. " the energy gauge." .. (u18.Visible and "\nIf the needle turns to the right you are gaining energy, if it turns to the left you are losing energy." or "");
end);
v4.Add("energy", { "Boolean" }, function(p23) --[[ Name: SetEnabledEnergy, Line 141 ]]
    -- upvalues: u18 (copy)
    u18.Visible = p23;
    return "You have " .. (u18.Visible and "enabled" or "disabled") .. " the energy gauge." .. (u18.Visible and "\nIf the needle turns to the right you are gaining energy, if it turns to the left you are losing energy." or "");
end);
local function v25(p24) --[[ Line: 150 ]]
    -- upvalues: u21 (ref), u22 (copy)
    u21 = p24;
    if u21 then
        u22.Transparency = 0.8;
    else
        u22.Transparency = 1;
    end;
    return "You have " .. (u21 and "enabled" or "disabled") .. " the maxheight surface." .. (u21 and "\nThe green surface represents the maximum achievable height at your current speed." or "");
end;
v4.Add("maxheight", {}, function() --[[ Line: 159 ]]
    -- upvalues: u21 (ref), u22 (copy)
    u21 = not u21;
    if u21 then
        u22.Transparency = 0.8;
    else
        u22.Transparency = 1;
    end;
    return "You have " .. (u21 and "enabled" or "disabled") .. " the maxheight surface." .. (u21 and "\nThe green surface represents the maximum achievable height at your current speed." or "");
end);
v4.Add("maxheight", { "Boolean" }, v25);
local u26 = Instance.new("Part", workspace);
u26.Name = "TrajectoryApex";
u26.Anchored = true;
u26.CanCollide = false;
u26.BrickColor = BrickColor.new(322);
u26.Size = Vector3.new(2048, 5, 2048);
u26.TopSurface = Enum.SurfaceType.Smooth;
u26.BottomSurface = Enum.SurfaceType.Weld;
u26.Transparency = 1;
local u27 = false;
local function v29(p28) --[[ Line: 176 ]]
    -- upvalues: u27 (ref), u26 (copy)
    u27 = p28;
    if not u27 then
        u26.Transparency = 1;
    end;
    return "You have " .. (u27 and "enabled" or "disabled") .. " the apex gauge." .. (u27 and "\nThe purple surface represents the maximum height you will reach on your current trajectory." or "");
end;
v4.Add("apex", {}, function() --[[ Line: 183 ]]
    -- upvalues: u27 (ref), u26 (copy)
    u27 = not u27;
    if not u27 then
        u26.Transparency = 1;
    end;
    return "You have " .. (u27 and "enabled" or "disabled") .. " the apex gauge." .. (u27 and "\nThe purple surface represents the maximum height you will reach on your current trajectory." or "");
end);
v4.Add("apex", { "Boolean" }, v29);
local u30 = Instance.new("Part", workspace);
u30.Name = "HitMarker";
u30.Anchored = true;
u30.CanCollide = false;
u30.BrickColor = BrickColor.new(21);
u30.Size = Vector3.new(5, 2, 2);
u30.Shape = Enum.PartType.Cylinder;
u30.TopSurface = Enum.SurfaceType.Smooth;
u30.BottomSurface = Enum.SurfaceType.Smooth;
u30.Transparency = 1;
local u31 = l__new__15(0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 1);
local u32 = v7();
u32.MovingPartsEnabled = false;
local function u35(p33, p34) --[[ Line: 203 ]]
    -- upvalues: u32 (copy)
    if p33.GameMechanics:IsTouchable(p34.Part) then
        p34.Type = "TickEnd";
        u32.ShouldRun = false;
    end;
end;
local u36 = false;
local function v38(p37) --[[ Line: 213 ]]
    -- upvalues: u36 (ref), u30 (copy)
    u36 = p37;
    if not u36 then
        u30.Transparency = 1;
    end;
    return "You have " .. (u36 and "enabled" or "disabled") .. " the hitmarker gauge." .. (u36 and "\nThe red hitbox represents where you will collide if you don\'t change direction." or "");
end;
v4.Add("hit", {}, function() --[[ Line: 220 ]]
    -- upvalues: u36 (ref), u30 (copy)
    u36 = not u36;
    if not u36 then
        u30.Transparency = 1;
    end;
    return "You have " .. (u36 and "enabled" or "disabled") .. " the hitmarker gauge." .. (u36 and "\nThe red hitbox represents where you will collide if you don\'t change direction." or "");
end);
v4.Add("hit", { "Boolean" }, v38);
local u39 = l__Color__23(0, 0, 0, 255);
local u40 = l__Color__23(90, 200, 95);
local u41 = l__Color__23(210, 95, 95);
local u42 = l__Color__23(255, 0, 0);
local u43 = l__Color__23(0, 0, 255);
local u44 = l__Color__23(64, 224, 224);
local u45 = l__Color__23(255, 215, 0);
local u46 = l__Color__23(192, 192, 192);
local u47 = l__Color__23(205, 127, 50);
local u48 = v3.New();
u48.PosScaleX = 1;
u48.PosScaleY = 0.5;
u48.SizeOffsetX = 250;
u48.SizeOffsetY = 60;
u48.PosOffsetX = -u48.SizeX;
u48.DrawBackground = false;
u48.Visible = false;
local v49 = v3.TextBox(u48, "Sync");
v49.TextStrokeColor = v12;
v49.SizeScaleX = 1;
v49.SizeOffsetY = 20;
v49.DrawBackground = false;
local u50 = v3.TextBox(u48, "");
u50.TextStrokeColor = v12;
u50.PosOffsetY = 20;
u50.SizeScaleX = 1;
u50.SizeOffsetY = 20;
u50.DrawBackground = false;
u50.DontCheckBounds = true;
local u51 = v3.New(u48);
u51.BackgroundColor = u39;
u51.PosOffsetY = 40;
u51.SizeScaleX = 1;
u51.SizeOffsetY = 20;
v3.DragBar(u48, u48);
v4.Add("sync", {}, function() --[[ Line: 298 ]]
    -- upvalues: u48 (copy)
    u48.Visible = not u48.Visible;
    return "You have " .. (u48.Visible and "enabled" or "disabled") .. " the sync gauge." .. (u48.Visible and "\nThis represents the percentage of frames that you are accelerating while moving the mouse." or "");
end);
v4.Add("sync", { "Boolean" }, function(p52) --[[ Name: SetEnabledSync, Line 294 ]]
    -- upvalues: u48 (copy)
    u48.Visible = p52;
    return "You have " .. (u48.Visible and "enabled" or "disabled") .. " the sync gauge." .. (u48.Visible and "\nThis represents the percentage of frames that you are accelerating while moving the mouse." or "");
end);
local v53 = 0;
local v54 = 0;
local u55 = v3.New();
u55.PosScaleX = 1;
u55.PosScaleY = 0.5;
u55.SizeOffsetX = 200;
u55.SizeOffsetY = 60;
u55.PosOffsetX = -u48.SizeX - u55.SizeX;
u55.DrawBackground = false;
u55.Visible = false;
local v56 = v3.TextBox(u55, "Average");
v56.TextColor = u11;
v56.TextAlignment = "Right";
v56.TextStrokeColor = v12;
v56.PosScaleX = 0.3333333333333333;
v56.SizeScaleX = 0.3333333333333333;
v56.SizeScaleY = 0.3333333333333333;
v56.DrawBackground = false;
local v57 = v3.TextBox(u55, "Current");
v57.TextColor = u11;
v57.TextAlignment = "Right";
v57.TextStrokeColor = v12;
v57.PosScaleX = 0.6666666666666666;
v57.SizeScaleX = 0.3333333333333333;
v57.SizeScaleY = 0.3333333333333333;
v57.DrawBackground = false;
local v58 = v3.TextBox(u55, "Strafe:");
v58.TextColor = u11;
v58.TextAlignment = "Right";
v58.TextStrokeColor = v12;
v58.PosScaleY = 0.3333333333333333;
v58.SizeScaleX = 0.3333333333333333;
v58.SizeScaleY = 0.3333333333333333;
v58.DrawBackground = false;
local u59 = v3.TextBox(u55, "-");
u59.TextColor = u11;
u59.TextAlignment = "Right";
u59.TextStrokeColor = v12;
u59.PosScaleX = 0.3333333333333333;
u59.PosScaleY = 0.3333333333333333;
u59.SizeScaleX = 0.3333333333333333;
u59.SizeScaleY = 0.3333333333333333;
u59.DrawBackground = false;
u59.DontCheckBounds = true;
local u60 = v3.TextBox(u55, "-");
u60.TextColor = u11;
u60.TextAlignment = "Right";
u60.TextStrokeColor = v12;
u60.PosScaleX = 0.6666666666666666;
u60.PosScaleY = 0.3333333333333333;
u60.SizeScaleX = 0.3333333333333333;
u60.SizeScaleY = 0.3333333333333333;
u60.DrawBackground = false;
u60.DontCheckBounds = true;
local v61 = v3.TextBox(u55, "Efficiency:");
v61.TextColor = u11;
v61.TextAlignment = "Right";
v61.TextStrokeColor = v12;
v61.PosScaleY = 0.6666666666666666;
v61.SizeScaleX = 0.3333333333333333;
v61.SizeScaleY = 0.3333333333333333;
v61.DrawBackground = false;
local u62 = v3.TextBox(u55, "-");
u62.TextColor = u11;
u62.TextAlignment = "Right";
u62.TextStrokeColor = v12;
u62.PosScaleX = 0.3333333333333333;
u62.PosScaleY = 0.6666666666666666;
u62.SizeScaleX = 0.3333333333333333;
u62.SizeScaleY = 0.3333333333333333;
u62.DrawBackground = false;
u62.DontCheckBounds = true;
local u63 = v3.TextBox(u55, "-");
u63.TextColor = u11;
u63.TextAlignment = "Right";
u63.TextStrokeColor = v12;
u63.PosScaleX = 0.6666666666666666;
u63.PosScaleY = 0.6666666666666666;
u63.SizeScaleX = 0.3333333333333333;
u63.SizeScaleY = 0.3333333333333333;
u63.DrawBackground = false;
u63.DontCheckBounds = true;
v3.DragBar(u55, u55);
v4.Add("strafe", {}, function() --[[ Line: 417 ]]
    -- upvalues: u55 (copy)
    u55.Visible = not u55.Visible;
    return "You have " .. (u55.Visible and "enabled" or "disabled") .. " the strafe efficiency gauge." .. (u55.Visible and "\nThis averages the gain you get on each tick as a percentage of the maximum possible gain." or "");
end);
v4.Add("strafe", { "Boolean" }, function(p64) --[[ Name: SetEnabledStrafe, Line 413 ]]
    -- upvalues: u55 (copy)
    u55.Visible = p64;
    return "You have " .. (u55.Visible and "enabled" or "disabled") .. " the strafe efficiency gauge." .. (u55.Visible and "\nThis averages the gain you get on each tick as a percentage of the maximum possible gain." or "");
end);
local u65 = 0;
local u66 = 0;
local u67 = 0;
local function u77(p68, p69) --[[ Line: 425 ]]
    -- upvalues: u65 (ref), u66 (ref), u67 (ref), u55 (copy), u62 (copy), l__format__12 (copy), u41 (copy), u11 (copy), u47 (copy), u46 (copy), u45 (copy), u44 (copy), u63 (copy), u59 (copy), u42 (copy), u43 (copy), u60 (copy), u13 (ref), u15 (copy), l__clamp__5 (copy), u16 (copy), l__cos__6 (copy), l__sin__7 (copy)
    u65 = u65 + p68;
    u66 = u66 + p69;
    u67 = u67 + 1;
    if u55.Visible then
        local v70 = u65 / u67;
        local v71 = u66 / u67;
        u62.Text = l__format__12("%0.1f%%", v70 * 100);
        local v72 = u62;
        local v73;
        if v70 < 0.5 then
            v73 = u41;
        elseif v70 < 0.7 then
            v73 = u11;
        elseif v70 < 0.8 then
            v73 = u47;
        elseif v70 < 0.9 then
            v73 = u46;
        elseif v70 < 0.95 then
            v73 = u45;
        else
            v73 = u44;
        end;
        v72.TextColor = v73;
        u63.Text = l__format__12("%0.1f%%", 100 * p68);
        local v74 = u63;
        local v75;
        if p68 < 0.5 then
            v75 = u41;
        elseif p68 < 0.7 then
            v75 = u11;
        elseif p68 < 0.8 then
            v75 = u47;
        elseif p68 < 0.9 then
            v75 = u46;
        elseif p68 < 0.95 then
            v75 = u45;
        else
            v75 = u44;
        end;
        v74.TextColor = v75;
        u59.Text = l__format__12("%0.1f%%", v71 * 100);
        u59.TextColor = v71 > 1 and u42 or u43;
        u60.Text = l__format__12("%0.1f%%", 100 * p69);
        u60.TextColor = p69 > 1 and u42 or u43;
    end;
    if u13 == 0 and u15.Visible then
        local v76 = 1.5707963267948966 * l__clamp__5(p69, 0, 2);
        u16.PosOffsetX = -120 - l__cos__6(v76) * 90;
        u16.PosOffsetY = -30 - l__sin__7(v76) * 90;
        u16.Rotation = 3.141592653589793 + v76;
    end;
end;
local u78 = v3.New();
u78.PosScaleX = 0.5;
u78.PosScaleY = 0.5;
u78.SizeOffsetX = 140;
u78.SizeOffsetY = 100;
u78.PosOffsetX = -u48.SizeX - u78.SizeX;
u78.PosOffsetY = -u48.SizeY - u78.SizeY;
u78.DrawBackground = false;
u78.Visible = false;
local u79 = v3.TextBox(u78, "#");
u79.TextColor = u11;
u79.TextAlignment = "Right";
u79.TextStrokeColor = v12;
u79.SizeScaleX = 0.5;
u79.SizeScaleY = 0.2;
u79.DrawBackground = false;
local u80 = v3.TextBox(u78, "u/s");
u80.TextColor = u11;
u80.TextAlignment = "Right";
u80.TextStrokeColor = v12;
u80.PosScaleX = 0.5;
u80.SizeScaleX = 0.5;
u80.SizeScaleY = 0.2;
u80.DrawBackground = false;
local u81 = v3.TextBox(u78, "Strafe:");
u81.TextColor = u11;
u81.TextAlignment = "Right";
u81.TextStrokeColor = v12;
u81.PosScaleY = 0.2;
u81.SizeScaleX = 0.5;
u81.SizeScaleY = 0.2;
u81.DrawBackground = false;
local u82 = v3.TextBox(u78, "-");
u82.TextColor = u11;
u82.TextAlignment = "Right";
u82.TextStrokeColor = v12;
u82.PosScaleX = 0.5;
u82.PosScaleY = 0.2;
u82.SizeScaleX = 0.5;
u82.SizeScaleY = 0.2;
u82.DrawBackground = false;
local v83 = v3.TextBox(u78, "Efficiency:");
v83.TextColor = u11;
v83.TextAlignment = "Right";
v83.TextStrokeColor = v12;
v83.PosScaleY = 0.4;
v83.SizeScaleX = 0.5;
v83.SizeScaleY = 0.2;
v83.DrawBackground = false;
local u84 = v3.TextBox(u78, "-");
u84.TextColor = u11;
u84.TextAlignment = "Right";
u84.TextStrokeColor = v12;
u84.PosScaleX = 0.5;
u84.PosScaleY = 0.4;
u84.SizeScaleX = 0.5;
u84.SizeScaleY = 0.2;
u84.DrawBackground = false;
local u85 = v3.TextBox(u78, "Time Δ:");
u85.TextColor = u11;
u85.TextAlignment = "Right";
u85.TextStrokeColor = v12;
u85.PosScaleY = 0.6;
u85.SizeScaleX = 0.5;
u85.SizeScaleY = 0.2;
u85.DrawBackground = false;
u85.Visible = false;
local u86 = v3.TextBox(u78, "-");
u86.TextColor = u11;
u86.TextAlignment = "Right";
u86.TextStrokeColor = v12;
u86.PosScaleX = 0.5;
u86.PosScaleY = 0.6;
u86.SizeScaleX = 0.5;
u86.SizeScaleY = 0.2;
u86.DrawBackground = false;
u86.Visible = false;
local u87 = v3.TextBox(u78, "Height Δ:");
u87.TextColor = u11;
u87.TextAlignment = "Right";
u87.TextStrokeColor = v12;
u87.PosScaleY = 0.8;
u87.SizeScaleX = 0.5;
u87.SizeScaleY = 0.2;
u87.DrawBackground = false;
u87.Visible = false;
local u88 = v3.TextBox(u78, "-");
u88.TextColor = u11;
u88.TextAlignment = "Right";
u88.TextStrokeColor = v12;
u88.PosScaleX = 0.5;
u88.PosScaleY = 0.8;
u88.SizeScaleX = 0.5;
u88.SizeScaleY = 0.2;
u88.DrawBackground = false;
u88.Visible = false;
v3.DragBar(u78, u78);
local u89 = false;
local function v91(p90) --[[ Line: 573 ]]
    -- upvalues: u89 (ref), u85 (copy), u86 (copy), u87 (copy), u88 (copy)
    u89 = p90;
    u85.Visible = u89;
    u86.Visible = u89;
    u87.Visible = u89;
    u88.Visible = u89;
    return "You have " .. (u89 and "enabled" or "disabled") .. " the jhud deltas." .. (u89 and "\nThis shows the time and height change from your last jump.\nThe first jump also accounts for time spent outside of start zone" or "");
end;
local function v92() --[[ Line: 582 ]]
    -- upvalues: u89 (ref), u85 (copy), u86 (copy), u87 (copy), u88 (copy)
    u89 = not u89;
    u85.Visible = u89;
    u86.Visible = u89;
    u87.Visible = u89;
    u88.Visible = u89;
    local _ = "You have " .. (u89 and "enabled" or "disabled") .. " the jhud deltas." .. (u89 and "\nThis shows the time and height change from your last jump.\nThe first jump also accounts for time spent outside of start zone" or "");
end;
local u93 = u67;
local u94 = v53;
local u95 = u21;
local u96 = u65;
local u97 = u36;
local u98 = u13;
local u99 = v54;
local u100 = u66;
local u101 = u27;
for _, v102 in {
    u79,
    u80,
    u81,
    u82,
    v83,
    u84,
    u85,
    u86,
    u87,
    u88
} do
    v102.Button1Down = v92;
end;
v4.Add("showdeltas", {}, v92);
v4.Add("showdeltas", { "Boolean" }, v91);
v4.Add({ "jhud", "ssj" }, {}, function() --[[ Line: 599 ]]
    -- upvalues: u78 (copy)
    u78.Visible = not u78.Visible;
    return "You have " .. (u78.Visible and "enabled" or "disabled") .. " the jhud." .. (u78.Visible and "\nThis shows speed, average gain efficiency, and average strafe speed relative to optimal on each jump." or "");
end);
v4.Add({ "jhud", "ssj" }, { "Boolean" }, function(p103) --[[ Name: SetEnabledJHUD, Line 595 ]]
    -- upvalues: u78 (copy)
    u78.Visible = p103;
    return "You have " .. (u78.Visible and "enabled" or "disabled") .. " the jhud." .. (u78.Visible and "\nThis shows speed, average gain efficiency, and average strafe speed relative to optimal on each jump." or "");
end);
local function u117(p104, p105, p106, p107) --[[ Line: 605 ]]
    -- upvalues: u9 (copy), l__IsA__16 (copy), l__match__11 (copy), l__insert__9 (copy)
    local v108 = u9.MapInfo.RobloxModel:GetDescendants();
    for v109 = 1, #v108 do
        local v110 = v108[v109];
        if l__IsA__16(v110, "BasePart") then
            local l__Name__26 = v110.Name;
            local v111 = p107;
            local v112 = true;
            for _, v113 in p105 do
                if l__match__11(l__Name__26, v113) then
                    v111 = not p107;
                    break;
                end;
            end;
            if p106 then
                for v114, v115 in p106 do
                    local v116 = v110[v114];
                    if type(v115) == "number" then
                        if v116 < v115 then
                            v112 = false;
                        end;
                    elseif v116 ~= v115 then
                        v112 = false;
                    end;
                end;
            end;
            if v111 and v112 then
                l__insert__9(p104, v110);
            end;
        end;
    end;
end;
local u118 = Instance.new("Texture");
u118.StudsPerTileU = 3;
u118.StudsPerTileV = 3;
u118.ZIndex = 9000000000;
u118.Texture = "rbxassetid://621502542";
local u119 = Enum.NormalId:GetEnumItems();
local u120 = false;
local u121 = {};
local u122 = {};
local u123 = {
    "^Trigger%d+$",
    "^ForceTrigger%d+$",
    "^Teleport%d+$",
    "^ForceTeleport%d+$",
    "^WormholeIn%d+$",
    "^SpawnAt%d+$",
    "^MapAnticheat$",
    "^Map(%d+)Anticheat$",
    "^MapAnticheat(%d+)$",
    "^Bonus(%d+)Anticheat$",
    "^BonusAnticheat(%d+)$",
    "^Accelerator$",
    "^SetVelocity$",
    "^Water$"
};
local function u130(p124) --[[ Line: 670 ]]
    -- upvalues: u120 (ref), u121 (copy), u117 (copy), u123 (copy), u119 (copy), l__Clone__17 (copy), u118 (copy), u122 (copy), l__insert__9 (copy)
    u120 = p124;
    if #u121 == 0 and u120 then
        u117(u121, u123);
        for _, v125 in u121 do
            for _, v126 in u119 do
                local v127 = l__Clone__17(u118);
                v127.Face = v126;
                v127.Parent = v125;
                l__insert__9(u122, v127);
            end;
        end;
    end;
    local v128 = p124 and 0.5 or 1;
    for _, v129 in u122 do
        v129.Transparency = v128;
    end;
    return "You have " .. (u120 and "enabled" or "disabled") .. " showtriggers." .. (u120 and "\nThis marks triggers with an orange tinted texture with the word \'TRIGGER\' on them." or "");
end;
v4.Add({ "showtriggers", "st" }, { "Boolean" }, function(p131) --[[ Line: 691 ]]
    -- upvalues: u130 (copy)
    return u130(p131);
end);
v4.Add({ "showtriggers", "st" }, {}, function() --[[ Line: 694 ]]
    -- upvalues: u130 (copy), u120 (ref)
    return u130(not u120);
end);
local u132 = Instance.new("Texture");
u132.StudsPerTileU = 3;
u132.StudsPerTileV = 3;
u132.ZIndex = 9000000000;
u132.Texture = "rbxassetid://949363541";
local u133 = false;
local u134 = {};
local u135 = {};
local u136 = { "Platform", "^Trigger%d+$", "^ForceTrigger%d+$" };
local function u143(p137) --[[ Line: 711 ]]
    -- upvalues: u133 (ref), u134 (copy), u117 (copy), u136 (copy), u119 (copy), l__Clone__17 (copy), u132 (copy), u135 (copy), l__insert__9 (copy)
    u133 = p137;
    if #u134 == 0 and u133 then
        u117(u134, u136, {
            Transparency = 1,
            CanCollide = true
        }, true);
        for _, v138 in u134 do
            for _, v139 in u119 do
                local v140 = l__Clone__17(u132);
                v140.Face = v139;
                v140.Parent = v138;
                l__insert__9(u135, v140);
            end;
        end;
    end;
    local v141 = p137 and 0.5 or 1;
    for _, v142 in u135 do
        v142.Transparency = v141;
    end;
    return "You have " .. (u133 and "enabled" or "disabled") .. " showclips." .. (u133 and "\nThis marks clips with a purple tinted texture as well as an outline on them." or "");
end;
v4.Add({ "showclips", "sc" }, { "Boolean" }, function(p144) --[[ Line: 730 ]]
    -- upvalues: u143 (copy)
    return u143(p144);
end);
v4.Add({ "showclips", "sc" }, {}, function() --[[ Line: 733 ]]
    -- upvalues: u143 (copy), u133 (ref)
    return u143(not u133);
end);
local u145 = 0;
local u146 = 0;
local u147 = 0;
local u148 = 0;
local u149 = 0;
local u150 = 0;
local u151 = 0;
local u152 = 0;
local u153 = 0;
local u154 = 0;
local u155 = nil;
local function u168(p156, p157, p158) --[[ Line: 753 ]]
    -- upvalues: u145 (ref), u93 (ref), u149 (ref), u96 (ref), u147 (ref), u100 (ref), u148 (ref), l__sqrt__4 (copy), u150 (ref), u151 (ref), u152 (ref), u79 (copy), u80 (copy), l__format__12 (copy), u40 (copy), u41 (copy), u81 (copy), u146 (ref), u154 (ref), u86 (copy), u153 (ref), u88 (copy), u82 (copy), u11 (copy), u84 (copy), u42 (copy), u43 (copy), u47 (copy), u46 (copy), u45 (copy), u44 (copy)
    u145 = u145 + 1;
    local v159 = u93 == u149;
    local v160 = (u96 - u147) / (u93 - u149);
    local v161 = (u100 - u148) / (u93 - u149);
    local v162 = l__sqrt__4(p158.x * p158.x + p158.z * p158.z);
    local _ = v162 - u150;
    local l__y__27 = p157.y;
    local v163 = l__y__27 - u151;
    local v164 = p156 - u152;
    local _ = (v162 > 18 and 300 or 90) * (0.01 - v164 % 0.01);
    local v165 = u150 < v162;
    u150 = v162;
    u151 = l__y__27;
    u152 = p156;
    u79.Text = u145;
    u80.Text = l__format__12("%0.2f", v162);
    u80.TextColor = v165 and u40 or u41;
    u81.Text = l__format__12("%d %s:", u146, u146 == 1 and "Strafe" or "Strafes");
    if u145 == 1 then
        v164 = u154 == 0 and 0 or p156 - u154;
        v163 = 0;
    end;
    u86.TextColor = v164 <= u153 and u40 or u41;
    u86.Text = l__format__12("%0.3f", v164);
    u88.Text = (v163 > 0 and "+" or "") .. l__format__12("%0.3f", v163);
    if v159 then
        u82.Text = "N/A";
        u82.TextColor = u11;
        u84.Text = "N/A";
        u84.TextColor = u11;
    else
        u82.Text = l__format__12("%0.1f%%", v161 * 100);
        u82.TextColor = v161 > 1 and u42 or u43;
        u84.Text = l__format__12("%0.1f%%", v160 * 100);
        local v166 = u84;
        local v167;
        if v160 < 0.5 then
            v167 = u41;
        elseif v160 < 0.7 then
            v167 = u11;
        elseif v160 < 0.8 then
            v167 = u47;
        elseif v160 < 0.9 then
            v167 = u46;
        elseif v160 < 0.95 then
            v167 = u45;
        else
            v167 = u44;
        end;
        v166.TextColor = v167;
    end;
    u147 = u96;
    u148 = u100;
    u149 = u93;
    u153 = v164;
    u146 = 0;
end;
local function u182(p169, p170, p171, p172, p173, p174, p175) --[[ Line: 830 ]]
    -- upvalues: l__cos__6 (copy), l__sin__7 (copy), l__new__13 (copy), u1 (copy)
    local v176 = p169 and p169.keys;
    if v176 then
        local l__w__28 = v176.w;
        local l__a__29 = v176.a;
        local l__s__30 = v176.s;
        local l__d__31 = v176.d;
        if (not p169.total or p169.total == (p172 and l__w__28 and l__w__28 or 0) + (p173 and l__a__29 and l__a__29 or 0) + (p174 and l__s__30 and l__s__30 or 0) + (p175 and l__d__31 and l__d__31 or 0)) and ((l__w__28 ~= 2 or p172) and ((l__a__29 ~= 2 or p173) and ((l__s__30 ~= 2 or p174) and (l__d__31 ~= 2 or p175)))) then
            local v177 = ((l__d__31 == 0 or not p175) and 0 or 1) - ((l__a__29 == 0 or not p173) and 0 or 1);
            local v178 = ((l__s__30 == 0 or not p174) and 0 or 1) - ((l__w__28 == 0 or not p172) and 0 or 1);
            if v177 ~= 0 or v178 ~= 0 then
                local v179 = l__cos__6(p170);
                local v180 = l__sin__7(p170);
                local l__unit__32 = l__new__13(v177 * v179 + v178 * v180, 0, v178 * v179 - v177 * v180).unit;
                local l__allow_strafe_dir__33 = p169.allow_strafe_dir;
                if not l__allow_strafe_dir__33 then
                    return l__unit__32, false;
                end;
                local v181 = Vector2.new(l__unit__32.x * p171.x + l__unit__32.z * p171.z, l__unit__32.x * p171.z - l__unit__32.z * p171.x):Dot(l__allow_strafe_dir__33);
                if v181 == 0 or v181 < 0 and not p173 or v181 > 0 and not p175 then
                    return l__unit__32, false;
                end;
            end;
        end;
    end;
    return u1, true;
end;
local u183 = nil;
local u184 = nil;
local u185 = nil;
local u186 = nil;
local u187 = nil;
local u188 = l__TICKINFO_BIT_STRAFE__21 + l__TICKINFO_BIT_TOUCHING__22;
local u189 = l__TICKINFO_BIT_JUMP__20 + l__TICKINFO_BIT_STRAFE__21 + l__TICKINFO_BIT_TOUCHING__22;
u5.OutputSignal:Add(function(p190, p191, p192, p193, p194, _) --[[ Line: 869 ]]
    -- upvalues: l__TICKINFO_BIT_TICKEND__19 (copy), l__band__1 (copy), u5 (copy), u183 (ref), u184 (ref), u188 (copy), l__TICKINFO_BIT_STRAFE__21 (copy), u185 (ref), l__GetControlState__24 (copy), u182 (copy), l__Dot__14 (copy), u94 (ref), u99 (ref), u48 (copy), u50 (copy), l__format__12 (copy), u41 (copy), u11 (copy), u47 (copy), u46 (copy), u45 (copy), u44 (copy), u51 (copy), u40 (copy), l__sqrt__4 (copy), l__sign__3 (copy), u77 (copy), l__atan2__8 (copy), l__abs__2 (copy), l__clamp__5 (copy), u155 (ref), u146 (ref), u187 (ref), u189 (copy), l__TICKINFO_BIT_TOUCHING__22 (copy), u145 (ref), u147 (ref), u148 (ref), u149 (ref), u150 (ref), u151 (ref), u152 (ref), u154 (ref), u153 (ref), u79 (copy), u80 (copy), u82 (copy), u84 (copy), u86 (copy), u88 (copy), u81 (copy), u186 (ref), l__TICKINFO_BIT_JUMP__20 (copy), u168 (copy)
    local l__y__34 = p192.y;
    if l__band__1(p191, l__TICKINFO_BIT_TICKEND__19) == l__TICKINFO_BIT_TICKEND__19 then
        local l__PlaybackContext__35 = u5.PlaybackContext;
        local l__StyleInfo__36 = l__PlaybackContext__35.StyleInfo;
        if not u183 and (u184 and (l__band__1(p191, u188) == l__TICKINFO_BIT_STRAFE__21 and l__StyleInfo__36)) then
            local l__mv__37 = l__StyleInfo__36.mv;
            local v195 = l__y__34 ~= u185;
            local _, v196, _, _ = l__PlaybackContext__35.Context:GetInput();
            local v197, v198 = u182(l__StyleInfo__36, l__y__34, u184, l__GetControlState__24(v196, "MoveForward"), l__GetControlState__24(v196, "MoveLeft"), l__GetControlState__24(v196, "MoveBack"), (l__GetControlState__24(v196, "MoveRight")));
            if v195 then
                local v199 = not v198;
                if v199 then
                    v199 = l__Dot__14(u184, v197) < l__mv__37;
                end;
                if v199 then
                    u94 = u94 + 1;
                end;
                u99 = u99 + 1;
                if u48.Visible then
                    local v200 = u94 / u99;
                    u50.Text = l__format__12("%0.1f%%", v200 * 100);
                    local v201 = u50;
                    local v202;
                    if v200 < 0.5 then
                        v202 = u41;
                    elseif v200 < 0.7 then
                        v202 = u11;
                    elseif v200 < 0.8 then
                        v202 = u47;
                    elseif v200 < 0.9 then
                        v202 = u46;
                    elseif v200 < 0.95 then
                        v202 = u45;
                    else
                        v202 = u44;
                    end;
                    v201.TextColor = v202;
                    u51.BackgroundColor = v199 and u40 or u41;
                end;
                local l__x__38 = p194.x;
                local l__z__39 = p194.z;
                local v203 = l__sqrt__4(l__x__38 * l__x__38 + l__z__39 * l__z__39);
                local l__x__40 = u184.x;
                local l__z__41 = u184.z;
                local v204 = l__x__40 * l__x__40 + l__z__41 * l__z__41;
                local v205 = l__sqrt__4(v204);
                local v206 = l__sqrt__4(v204 + l__mv__37 * l__mv__37);
                local l__x__42 = v197.x;
                local l__z__43 = v197.z;
                local v207 = l__sign__3(l__y__34 - u185);
                local v208 = v205 < v203;
                u77(v208 and ((v203 - v205) / (v206 - v205) or 0) or 0, (l__clamp__5(1 + (l__abs__2((l__atan2__8(l__x__42 * l__z__41 - l__z__43 * l__x__40, l__x__42 * l__x__40 + l__z__43 * l__z__41))) - 1.5707963267948966) / l__atan2__8(l__mv__37, v205), 0, 2)));
                if v208 and v207 ~= u155 then
                    u146 = u146 + 1;
                    u155 = v207;
                end;
            end;
        end;
        if u187 then
            if l__band__1(p191, u189) == l__TICKINFO_BIT_TOUCHING__22 then
                u145 = 0;
                u146 = 0;
                u147 = 0;
                u148 = 0;
                u149 = 0;
                u150 = 0;
                u151 = 0;
                u152 = 0;
                u154 = 0;
                u153 = 0;
                u155 = 0;
                u79.Text = "#";
                u79.TextColor = u11;
                u80.Text = "u/s";
                u80.TextColor = u11;
                u82.Text = "-";
                u82.TextColor = u11;
                u84.Text = "-";
                u84.TextColor = u11;
                u86.Text = "-";
                u86.TextColor = u11;
                u88.Text = "-";
                u81.Text = "Strafe:";
            end;
            u187 = false;
        end;
        if u186 and (l__band__1(u186, u189) ~= l__TICKINFO_BIT_TOUCHING__22 and l__band__1(p191, u189) == l__TICKINFO_BIT_TOUCHING__22) then
            if l__StyleInfo__36 and l__StyleInfo__36.scroll_jump then
                u187 = true;
            else
                u145 = 0;
                u146 = 0;
                u147 = 0;
                u148 = 0;
                u149 = 0;
                u150 = 0;
                u151 = 0;
                u152 = 0;
                u154 = 0;
                u153 = 0;
                u155 = 0;
                u79.Text = "#";
                u79.TextColor = u11;
                u80.Text = "u/s";
                u80.TextColor = u11;
                u82.Text = "-";
                u82.TextColor = u11;
                u84.Text = "-";
                u84.TextColor = u11;
                u86.Text = "-";
                u86.TextColor = u11;
                u88.Text = "-";
                u81.Text = "Strafe:";
            end;
        end;
        u183 = false;
    else
        u183 = true;
    end;
    if l__band__1(p191, l__TICKINFO_BIT_JUMP__20) == l__TICKINFO_BIT_JUMP__20 then
        u168(p190, p193, p194);
    end;
    u184 = p194;
    u185 = l__y__34;
    u186 = p191;
end);
local function v209() --[[ Line: 938 ]]
    -- upvalues: u96 (ref), u100 (ref), u93 (ref), u62 (copy), u11 (copy), u59 (copy), u63 (copy), u60 (copy), u94 (ref), u99 (ref), u50 (copy), u51 (copy), u39 (copy), u145 (ref), u146 (ref), u147 (ref), u148 (ref), u149 (ref), u150 (ref), u151 (ref), u152 (ref), u154 (ref), u153 (ref), u155 (ref), u79 (copy), u80 (copy), u82 (copy), u84 (copy), u86 (copy), u88 (copy), u81 (copy), u184 (ref), u185 (ref), u183 (ref)
    u96 = 0;
    u100 = 0;
    u93 = 0;
    u62.Text = "-";
    u62.TextColor = u11;
    u59.Text = "-";
    u59.TextColor = u11;
    u63.Text = "-";
    u63.TextColor = u11;
    u60.Text = "-";
    u60.TextColor = u11;
    u94 = 0;
    u99 = 0;
    u50.Text = "-";
    u50.TextColor = u11;
    u51.BackgroundColor = u39;
    u145 = 0;
    u146 = 0;
    u147 = 0;
    u148 = 0;
    u149 = 0;
    u150 = 0;
    u151 = 0;
    u152 = 0;
    u154 = 0;
    u153 = 0;
    u155 = 0;
    u79.Text = "#";
    u79.TextColor = u11;
    u80.Text = "u/s";
    u80.TextColor = u11;
    u82.Text = "-";
    u82.TextColor = u11;
    u84.Text = "-";
    u84.TextColor = u11;
    u86.Text = "-";
    u86.TextColor = u11;
    u88.Text = "-";
    u81.Text = "Strafe:";
    u184 = nil;
    u185 = nil;
    u183 = nil;
end;
u5.PlayerChanged:Add(v209);
v10.RunPrepare:Add(function(p210) --[[ Line: 948 ]]
    -- upvalues: u5 (copy), u96 (ref), u100 (ref), u93 (ref), u62 (copy), u11 (copy), u59 (copy), u63 (copy), u60 (copy), u94 (ref), u99 (ref), u50 (copy), u51 (copy), u39 (copy), u145 (ref), u146 (ref), u147 (ref), u148 (ref), u149 (ref), u150 (ref), u151 (ref), u152 (ref), u154 (ref), u153 (ref), u155 (ref), u79 (copy), u80 (copy), u82 (copy), u84 (copy), u86 (copy), u88 (copy), u81 (copy), u184 (ref), u185 (ref), u183 (ref)
    if p210.Player == u5.Player then
        u96 = 0;
        u100 = 0;
        u93 = 0;
        u62.Text = "-";
        u62.TextColor = u11;
        u59.Text = "-";
        u59.TextColor = u11;
        u63.Text = "-";
        u63.TextColor = u11;
        u60.Text = "-";
        u60.TextColor = u11;
        u94 = 0;
        u99 = 0;
        u50.Text = "-";
        u50.TextColor = u11;
        u51.BackgroundColor = u39;
        u145 = 0;
        u146 = 0;
        u147 = 0;
        u148 = 0;
        u149 = 0;
        u150 = 0;
        u151 = 0;
        u152 = 0;
        u154 = 0;
        u153 = 0;
        u155 = 0;
        u79.Text = "#";
        u79.TextColor = u11;
        u80.Text = "u/s";
        u80.TextColor = u11;
        u82.Text = "-";
        u82.TextColor = u11;
        u84.Text = "-";
        u84.TextColor = u11;
        u86.Text = "-";
        u86.TextColor = u11;
        u88.Text = "-";
        u81.Text = "Strafe:";
        u184 = nil;
        u185 = nil;
        u183 = nil;
    end;
end);
v10.RunStart:Add(function(p211) --[[ Line: 953 ]]
    -- upvalues: u5 (copy), u154 (ref)
    if p211.Player == u5.Player then
        u154 = p211.Started;
    end;
end);
v4.Add({ "resetgauge", "resetgauges", "rg" }, {}, v209);
local u212 = 0;
u9.MapInfoChanged:Add(function(p213) --[[ Line: 962 ]]
    -- upvalues: u212 (ref), u32 (copy), u35 (copy), l__clear__10 (copy), u121 (copy), u122 (copy), u134 (copy), u135 (copy), u120 (ref), u130 (copy), u133 (ref), u143 (copy)
    u212 = p213.MinY;
    u32.GameMechanics:SetMapInfo(p213);
    u32:LoadWorld(p213);
    u32.Phys.Handlers.CollisionStart:Add(u35);
    l__clear__10(u121);
    l__clear__10(u122);
    l__clear__10(u134);
    l__clear__10(u135);
    if u120 then
        u130(u120);
    end;
    if u133 then
        u143(u133);
    end;
end);
v6.Bind("Gauges", function() --[[ Line: 979 ]]
    -- upvalues: u5 (copy), u98 (ref), u15 (copy), u16 (copy), l__abs__2 (copy), l__sqrt__4 (copy), l__atan2__8 (copy), l__clamp__5 (copy), l__cos__6 (copy), l__sin__7 (copy), u95 (ref), u18 (copy), u212 (ref), l__Dot__14 (copy), u20 (copy), l__format__12 (copy), u19 (copy), u22 (copy), l__new__15 (copy), u101 (ref), u26 (copy), u97 (ref), u32 (copy), l__UnpackageControls__25 (copy), u30 (copy), u31 (copy)
    local l__PlaybackContext__44 = u5.PlaybackContext;
    if l__PlaybackContext__44 then
        local l__Context__45 = l__PlaybackContext__44.Context;
        local v214 = nil;
        local v215 = nil;
        local v216 = nil;
        local v217 = nil;
        if u98 == 1 and u15.Visible then
            local v218, _, v219, _, _, _ = l__Context__45:GetOutput();
            if v218 and v219 then
                local l__StyleInfo__46 = l__PlaybackContext__44.StyleInfo;
                if l__StyleInfo__46 and u16.RobloxBox then
                    v214, v215 = l__Context__45:GetPV();
                    v217 = l__Context__45:GetAngles();
                    if v214 and (v215 and v217) then
                        local l__x__47 = v215.x;
                        local l__z__48 = v215.z;
                        local v220 = 1.5707963267948966 * l__clamp__5(l__abs__2(v217.y - v219.y) / (l__Context__45.Timer:Time() - v218) / l__StyleInfo__46.tickrate / l__atan2__8(l__StyleInfo__46.mv, (l__sqrt__4(l__x__47 * l__x__47 + l__z__48 * l__z__48))), 0, 2);
                        u16.PosOffsetX = -120 - l__cos__6(v220) * 90;
                        u16.PosOffsetY = -30 - l__sin__7(v220) * 90;
                        u16.Rotation = 3.141592653589793 + v220;
                    end;
                end;
            end;
        end;
        if u95 or u18.Visible then
            if not (v214 and v215) then
                v214, v215 = l__Context__45:GetPV();
            end;
            v216 = v216 or l__Context__45:GetGravity();
            if v214 and (v215 and v216) then
                local v221 = u212;
                local v222 = 0.5 * l__Dot__14(v215, v215) - (v214.y - v221) * v216.y;
                if u20.Visible and u20.RobloxBox then
                    u20.Text = l__format__12("%d u²/s²", v222);
                end;
                if u18.Visible and u19.RobloxBox then
                    local v223 = v222 / 400;
                    u19.PosOffsetX = l__sin__7(v223) * 45 + -60;
                    u19.PosOffsetY = -15 - l__cos__6(v223) * 45;
                    u19.Rotation = v223 - 1.5707963267948966;
                end;
                if u95 then
                    u22.CFrame = l__new__15(v214.x, v221 - v222 / v216.y, v214.z);
                end;
            end;
        end;
        if u101 then
            if not (v214 and v215) then
                v214, v215 = l__Context__45:GetPV();
            end;
            local v224 = v216 or l__Context__45:GetGravity();
            if v214 and (v215 and v224) then
                if v215.y > 0 then
                    u26.Transparency = 0.8;
                    u26.CFrame = l__new__15(v214.x, v214.y - v215.y * v215.y / (2 * v224.y), v214.z);
                else
                    u26.Transparency = 1;
                end;
            end;
        end;
        if u97 then
            if not (v214 and v215) then
                v214, v215 = l__Context__45:GetPV();
            end;
            if v214 and v215 then
                local v225 = v214 + l__PlaybackContext__44.MapOffset;
                local l__SmoothingSimulation__49 = l__Context__45.SmoothingSimulation;
                if l__SmoothingSimulation__49 then
                    u32:CopyState(l__SmoothingSimulation__49);
                    u32.ShouldRun = true;
                else
                    local v226 = l__PlaybackContext__44.Cache:GetKey("Style");
                    if v226 ~= u32.GameMechanics.Style then
                        u32.GameMechanics:SetStyle(v226);
                    end;
                    local v227 = l__Context__45.Timer:Time();
                    local l__Phys__50 = u32.Phys;
                    l__Phys__50.Time = v227;
                    l__Phys__50:SetVelocity(v215);
                    l__Phys__50:SetPosition(v225);
                    local v228 = v217 or l__Context__45:GetAngles();
                    u32.Camera:SetAngles(v228);
                    u32.Camera:SetTime(v227);
                    u32.ShouldRun = true;
                end;
                if u32.ShouldRun then
                    local l__Phys__51 = u32.Phys;
                    local l__Time__52 = l__Phys__51.Time;
                    local l__Position__53 = l__Phys__51.Position;
                    local _, v229, v230 = l__Context__45:GetInput();
                    if v229 and v230 then
                        local v231 = 0;
                        while u32.ShouldRun and l__Phys__51.Time - l__Time__52 < 2 do
                            v231 = v231 + 1;
                            if not u32:Tick(l__UnpackageControls__25(l__Time__52 + v231 / 10, v229, v230)) then
                                print("HitSimulation failed lol");
                                break;
                            end;
                            if l__Phys__51.Position == l__Position__53 then
                                break;
                            end;
                        end;
                    end;
                    if u32.ShouldRun then
                        u30.Transparency = 1;
                        return;
                    end;
                    local l__magnitude__54 = (v225 - l__Phys__51.Position).magnitude;
                    if l__magnitude__54 < 2 then
                        u30.Transparency = 1;
                    elseif l__magnitude__54 < 5 then
                        u30.Transparency = 1.3333333333333333 - l__magnitude__54 / 6;
                    else
                        u30.Transparency = 0.5;
                    end;
                    u30.CFrame = u31 + l__Phys__51.Position;
                end;
            end;
        end;
    end;
end);
return true;
