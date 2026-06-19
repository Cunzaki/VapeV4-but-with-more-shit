-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tick;
local l__obtain__1 = _G.obtain;
local v2 = l__obtain__1("QBox");
local l__Image__2 = v2.Image;
local l__TextBox__3 = v2.TextBox;
local v3 = l__obtain__1("Remote");
local v4 = l__obtain__1("Command");
local l__SetPlayer__4 = l__obtain__1("Spectate").SetPlayer;
local v5 = l__obtain__1("PersistentData");
local l__Global__5 = v5.Global;
local l__Profile__6 = v5.Profile;
local v6 = l__obtain__1("VisibilityManager");
local _ = v6.PlayersVisible;
local _ = v6.SetHidingAll;
local _ = v6.SetHideDistance;
local _ = v6.SetSpeedCoeff;
local _ = v6.GetHideDistance;
local u7 = l__obtain__1("PauseMulticall");
local l__RootTimer__7 = l__obtain__1("RealtimeTimerSystem").RootTimer;
local v8 = l__obtain__1("CustomEnums");
local l__MODE_MAIN__8 = v8.MODE_MAIN;
local l__MODE_BONUS__9 = v8.MODE_BONUS;
local l__FLYMODE_FLY__10 = v8.FLYMODE_FLY;
local l__EVENT_INPUT_CONTROLS__11 = v8.EVENT_INPUT_CONTROLS;
local l__EVENT_INPUT_RESET__12 = v8.EVENT_INPUT_RESET;
local l__EVENT_INPUT_WORLDTIMEROFFSET__13 = v8.EVENT_INPUT_WORLDTIMEROFFSET;
local l__EVENT_INPUT_MAP__14 = v8.EVENT_INPUT_MAP;
local l__EVENT_INPUT_PAUSE__15 = v8.EVENT_INPUT_PAUSE;
local l__EVENT_INPUT_INIT__16 = v8.EVENT_INPUT_INIT;
local l__EVENT_INPUT_READY__17 = v8.EVENT_INPUT_READY;
local l__EVENT_INPUT_PRACTICEMODE__18 = v8.EVENT_INPUT_PRACTICEMODE;
local l__EVENT_INPUT_SPAWN__19 = v8.EVENT_INPUT_SPAWN;
local _ = v8.EVENT_INPUT_TIME;
local l__EVENT_INPUT_TIMESCALE__20 = v8.EVENT_INPUT_TIMESCALE;
local l__EVENT_INPUT_SAVESTATE__21 = v8.EVENT_INPUT_SAVESTATE;
local l__EVENT_INPUT_LOADSTATE__22 = v8.EVENT_INPUT_LOADSTATE;
local l__EVENT_INPUT_FLYMODE__23 = v8.EVENT_INPUT_FLYMODE;
local l__EVENT_INPUT_FLYSPEED__24 = v8.EVENT_INPUT_FLYSPEED;
local l__EVENT_INPUT_SETSPAWN__25 = v8.EVENT_INPUT_SETSPAWN;
local l__EVENT_INPUT_STYLE__26 = v8.EVENT_INPUT_STYLE;
local l__EVENT_INPUT_FOV__27 = v8.EVENT_INPUT_FOV;
local l__EVENT_INPUT_VSENSMUL__28 = v8.EVENT_INPUT_VSENSMUL;
local l__EVENT_INPUT_SENSITIVITY__29 = v8.EVENT_INPUT_SENSITIVITY;
local l__EVENT_INPUT_TURN_SPEED__30 = v8.EVENT_INPUT_TURN_SPEED;
local l__EVENT_INPUT_ABSOLUTE_SENS__31 = v8.EVENT_INPUT_ABSOLUTE_SENS;
local _ = v8.EVENT_INPUT_GAIN;
local _ = v8.EVENT_INPUT_GRAVITY;
local l__EVENT_INPUT_AUTORESTART__32 = v8.EVENT_INPUT_AUTORESTART;
local l__GetContext__33 = l__obtain__1("ContextManager").GetContext;
local u9 = l__obtain__1("Styles");
local u10 = l__obtain__1("MapManager");
local l__GetNewestRun__34 = l__obtain__1("RunManager").GetNewestRun;
local v11 = l__obtain__1("InputBinds");
local l__Hotkey__35 = v11.Hotkey;
local l__Game__36 = v11.Game;
local v12 = l__obtain__1("GameControl");
local l__PackageControls__37 = v12.PackageControls;
local u13 = l__obtain__1("GameControls");
local v14 = l__obtain__1("MulticallObjectMethod");
local v15 = l__obtain__1("RenderManager");
local u16 = l__obtain__1("View");
local l__StarterGui__38 = game:GetService("StarterGui");
local l__UserInputService__39 = game:GetService("UserInputService");
local l__new__40 = Vector2.new;
local l__ControlNames__41 = v12.ControlNames;
local _ = v12.ControlTypes;
local l__ControlBinds__42 = v12.ControlBinds;
local u17 = false;
local u18 = nil;
local u19 = nil;
for v20 = 1, v12.NBooleanControls do
    local u21 = l__ControlNames__41[v20];
    l__Game__36:RegisterBindable(u21, function(p22) --[[ Line: 107 ]]
        -- upvalues: u13 (copy), u21 (copy), u17 (ref), u18 (ref), u19 (ref)
        if p22 ~= nil then
            u13[u21] = p22;
        end;
        if p22 and u17 then
            u17 = false;
            if u18() then
                u19(false);
            end;
        end;
    end, l__ControlBinds__42[v20]);
end;
l__Game__36:RegisterBindable("MouseMovement", function(_, _, p23, p24) --[[ Line: 120 ]]
    -- upvalues: u13 (copy), l__new__40 (copy)
    u13.MousePos = u13.MousePos + l__new__40(p23, p24);
    return true;
end, "MouseMovement");
l__Game__36:RegisterBindable("ScrollPos", function(p25) --[[ Line: 125 ]]
    -- upvalues: l__GetContext__33 (copy), u13 (copy)
    local v26 = l__GetContext__33("Local");
    if v26 and v26.Context.Simulation.GameMechanics.StyleInfo.scroll_jump then
        u13.ScrollPos = u13.ScrollPos + p25;
        return true;
    end;
end, "MouseWheel");
local u27 = v14();
local u28 = false;
v15.Bind("Simulation", function() --[[ Line: 151 ]]
    -- upvalues: u28 (ref), u13 (copy), l__RootTimer__7 (copy), l__PackageControls__37 (copy), u27 (copy), l__EVENT_INPUT_CONTROLS__11 (copy)
    if u28 then
        u13.Time = l__RootTimer__7:Time();
        local v29, v30, v31, v32 = l__PackageControls__37(u13);
        u27:Call("Input", v29, l__EVENT_INPUT_CONTROLS__11, v30, v31, v32);
    end;
end);
v4.Add({ "turnspeed", "turnspeedslow" }, {}, function() --[[ Line: 173 ]]
    -- upvalues: l__Profile__6 (copy)
    local v33 = l__Profile__6:GetKey("TurnSpeedSlow") or 4.390225455974378;
    return "Your slow turnspeed is set to " .. tostring(v33);
end);
v4.Add("turnspeedfast", {}, function() --[[ Line: 177 ]]
    -- upvalues: l__Profile__6 (copy)
    local v34 = l__Profile__6:GetKey("TurnSpeedFast") or 8.780450911948757;
    return "Your fast turnspeed is set to " .. tostring(v34);
end);
local function u37() --[[ Line: 181 ]]
    -- upvalues: l__RootTimer__7 (copy), u27 (copy), l__EVENT_INPUT_FOV__27 (copy), l__Profile__6 (copy), l__EVENT_INPUT_VSENSMUL__28 (copy), l__EVENT_INPUT_SENSITIVITY__29 (copy), l__EVENT_INPUT_TURN_SPEED__30 (copy), l__EVENT_INPUT_ABSOLUTE_SENS__31 (copy), l__EVENT_INPUT_AUTORESTART__32 (copy)
    local v35 = l__RootTimer__7:Time();
    u27:Call("Input", v35, l__EVENT_INPUT_FOV__27, l__Profile__6:GetKey("FOV") or 90);
    u27:Call("Input", v35, l__EVENT_INPUT_VSENSMUL__28, l__Profile__6:GetKey("VSensMul") or 1);
    u27:Call("Input", v35, l__EVENT_INPUT_SENSITIVITY__29, l__Profile__6:GetKey("Sensitivity") or 0.3);
    u27:Call("Input", v35, l__EVENT_INPUT_TURN_SPEED__30, l__Profile__6:GetKey("TurnSpeedSlow") or 4.390225455974378);
    u27:Call("Input", v35, l__EVENT_INPUT_ABSOLUTE_SENS__31, l__Profile__6:GetKey("UseAbsoluteSens") == true);
    local v36 = l__Profile__6:GetKey("AutoRestart");
    if v36 ~= nil then
        u27:Call("Input", v35, l__EVENT_INPUT_AUTORESTART__32, v36);
    end;
end;
v3.Add("SimulationUnready", function() --[[ Line: 195 ]]
    -- upvalues: l__EVENT_INPUT_READY__17 (copy), u27 (copy), l__RootTimer__7 (copy), u7 (copy)
    local v38 = l__EVENT_INPUT_READY__17;
    local v39 = type(v38) == "number";
    assert(v39, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v38, false);
    u7:Call("MapLoading", true);
end);
u10.MapInfoChanged:Add(function(p40) --[[ Line: 200 ]]
    -- upvalues: u28 (ref), l__EVENT_INPUT_STYLE__26 (copy), u9 (copy), u27 (copy), l__RootTimer__7 (copy), l__EVENT_INPUT_MAP__14 (copy), u7 (copy)
    if not u28 then
        u28 = true;
        local v41 = l__EVENT_INPUT_STYLE__26;
        local l__DefaultStyle__43 = u9.DefaultStyle;
        local v42 = type(v41) == "number";
        assert(v42, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v41, l__DefaultStyle__43);
    end;
    local v43 = l__EVENT_INPUT_MAP__14;
    local l__MapChangeID__44 = p40.MapChangeID;
    local v44 = type(v43) == "number";
    assert(v44, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v43, l__MapChangeID__44);
    u7:Call("MapLoading", false);
end);
l__Profile__6:MonitorKey("FOV", function(p45) --[[ Line: 208 ]]
    -- upvalues: l__EVENT_INPUT_FOV__27 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v46 = l__EVENT_INPUT_FOV__27;
    local v47 = type(v46) == "number";
    assert(v47, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v46, p45);
end);
l__Profile__6:MonitorKey("Sensitivity", function(p48) --[[ Line: 211 ]]
    -- upvalues: l__EVENT_INPUT_SENSITIVITY__29 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v49 = l__EVENT_INPUT_SENSITIVITY__29;
    local v50 = type(v49) == "number";
    assert(v50, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v49, p48);
end);
l__Profile__6:MonitorKey("VSensMul", function(p51) --[[ Line: 214 ]]
    -- upvalues: l__EVENT_INPUT_VSENSMUL__28 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v52 = l__EVENT_INPUT_VSENSMUL__28;
    local v53 = type(v52) == "number";
    assert(v53, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v52, p51);
end);
l__Profile__6:MonitorKey("UseAbsoluteSens", function(p54) --[[ Line: 217 ]]
    -- upvalues: l__EVENT_INPUT_ABSOLUTE_SENS__31 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v55 = l__EVENT_INPUT_ABSOLUTE_SENS__31;
    local v56 = type(v55) == "number";
    assert(v56, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v55, p54);
end);
l__Profile__6:MonitorKey("AutoRestart", function(p57) --[[ Line: 221 ]]
    -- upvalues: l__EVENT_INPUT_AUTORESTART__32 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v58 = l__EVENT_INPUT_AUTORESTART__32;
    local v59 = type(v58) == "number";
    assert(v59, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v58, p57);
end);
l__Global__5:MonitorKey("GuiScale", v2.SetScale);
l__Global__5:MonitorKey("CrossHairIcon", v2.SetIcon);
l__Global__5:MonitorKey("CrossHairEnabled", v2.EnableMouseIcon);
l__Global__5:MonitorKey("CameraPunch", function(p60) --[[ Line: 229 ]]
    -- upvalues: u16 (copy)
    if p60 == nil then
        u16.CameraPunch = true;
    else
        u16.CameraPunch = false;
    end;
end);
l__Global__5:MonitorKey("JumpSounds", function(p61) --[[ Line: 236 ]]
    -- upvalues: u16 (copy)
    if p61 == nil then
        u16.JumpSounds = true;
    else
        u16.JumpSounds = false;
    end;
end);
local u62 = {};
u7:Register("Pause", function(p63, p64) --[[ Name: PauseSource, Line 249 ]]
    -- upvalues: u62 (copy), l__EVENT_INPUT_PAUSE__15 (copy), u27 (copy), l__RootTimer__7 (copy)
    u62[p63] = p64;
    if p64 then
        local v65 = l__EVENT_INPUT_PAUSE__15;
        local v66 = type(v65) == "number";
        assert(v66, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v65, true);
        return;
    end;
    local v67 = true;
    for _, v68 in u62 do
        if v68 then
            v67 = false;
            break;
        end;
    end;
    if v67 then
        local v69 = l__EVENT_INPUT_PAUSE__15;
        local v70 = type(v69) == "number";
        assert(v70, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v69, false);
    end;
end);
local function u71() --[[ Line: 268 ]]
    -- upvalues: u62 (copy)
    return u62.Pause;
end;
local function u73(p72) --[[ Line: 272 ]]
    -- upvalues: u7 (copy)
    u7:Call("Pause", p72);
end;
v4.Add("pause", {}, function() --[[ Line: 276 ]]
    -- upvalues: u73 (ref), u71 (ref)
    u73(not u71());
end);
v4.Add("pause", { "Boolean" }, function(p74) --[[ Line: 279 ]]
    -- upvalues: u73 (ref)
    u73(p74);
end);
v4.Add("unpause", {}, function() --[[ Line: 282 ]]
    -- upvalues: u71 (ref), u73 (ref)
    if not u71() then
        return "Not paused";
    end;
    u73(false);
end);
l__UserInputService__39.WindowFocused:connect(function() --[[ Line: 290 ]]
    -- upvalues: u7 (copy)
    u7:Call("WindowFocus", false);
end);
l__UserInputService__39.WindowFocusReleased:connect(function() --[[ Line: 293 ]]
    -- upvalues: u7 (copy)
    u7:Call("WindowFocus", true);
end);
v4.Add("wto", { "Duration" }, function(p75) --[[ Line: 297 ]]
    -- upvalues: l__EVENT_INPUT_WORLDTIMEROFFSET__13 (copy), u27 (copy), l__RootTimer__7 (copy)
    if p75 * p75 >= 7464960000 then
        return "Playback Timer Offset must be within 24h";
    end;
    local v76 = l__EVENT_INPUT_WORLDTIMEROFFSET__13;
    local v77 = type(v76) == "number";
    assert(v77, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v76, p75);
end);
v4.Add("r", {}, function() --[[ Line: 316 ]]
    -- upvalues: l__MODE_MAIN__8 (copy), l__GetContext__33 (copy), l__GetNewestRun__34 (copy), l__EVENT_INPUT_RESET__12 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v78 = l__MODE_MAIN__8;
    if not v78 then
        local v79 = l__GetContext__33("Local");
        if v79 then
            local v80 = l__GetNewestRun__34(v79.Runs);
            if v80 then
                v78 = v80.Mode;
            end;
        end;
    end;
    local v81 = l__EVENT_INPUT_RESET__12;
    local v82 = type(v81) == "number";
    assert(v82, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v81, v78);
end);
v4.Add("respawn", {}, function() --[[ Line: 319 ]]
    -- upvalues: l__EVENT_INPUT_MAP__14 (copy), u10 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v83 = l__EVENT_INPUT_MAP__14;
    local l__MapChangeID__45 = u10.MapInfo.MapChangeID;
    local v84 = type(v83) == "number";
    assert(v84, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v83, l__MapChangeID__45);
end);
v4.Add("b", {}, function() --[[ Line: 322 ]]
    -- upvalues: l__MODE_BONUS__9 (copy), l__GetContext__33 (copy), l__GetNewestRun__34 (copy), l__EVENT_INPUT_RESET__12 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v85 = l__MODE_BONUS__9;
    if not v85 then
        local v86 = l__GetContext__33("Local");
        if v86 then
            local v87 = l__GetNewestRun__34(v86.Runs);
            if v87 then
                v85 = v87.Mode;
            end;
        end;
    end;
    local v88 = l__EVENT_INPUT_RESET__12;
    local v89 = type(v88) == "number";
    assert(v89, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v88, v85);
end);
v4.Add("b", { "Integer" }, function(p90) --[[ Line: 325 ]]
    -- upvalues: l__GetContext__33 (copy), l__GetNewestRun__34 (copy), l__EVENT_INPUT_RESET__12 (copy), u27 (copy), l__RootTimer__7 (copy)
    if not p90 then
        local v91 = l__GetContext__33("Local");
        if v91 then
            local v92 = l__GetNewestRun__34(v91.Runs);
            if v92 then
                p90 = v92.Mode;
            end;
        end;
    end;
    local v93 = l__EVENT_INPUT_RESET__12;
    local v94 = type(v93) == "number";
    assert(v94, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v93, p90);
end);
local u95 = nil;
local v96 = v2.Color(255, 255, 255, 255);
local v97 = v2.Color(142.5, 15, 15, 255);
local v98 = v2.Color(45, 45, 45, 255);
local u99 = l__Image__2(nil, "rbxassetid://3615762331");
u99.SizeOffsetX = 100;
u99.SizeOffsetY = 100;
u99.DrawBackground = false;
u99.PosScaleX = 0.5;
u99.PosScaleY = 0.5;
u99.PosOffsetX = -50;
u99.PosOffsetY = 50;
u99.ImageColor = v98;
u99.Visible = false;
local u100 = l__Image__2(u99, "rbxassetid://3615762920");
u100.SizeOffsetX = 100;
u100.SizeOffsetY = 100;
u100.ImageColor = v97;
u100.DrawBackground = false;
u100.Visible = false;
local u101 = l__Image__2(u99, "rbxassetid://3615762920");
u101.SizeOffsetX = 100;
u101.SizeOffsetY = 100;
u101.ImageColor = v98;
u101.DrawBackground = false;
u101.Visible = false;
local u102 = l__Image__2(u99, "rbxassetid://3616168286");
u102.SizeOffsetX = 100;
u102.SizeOffsetY = 100;
u102.ImageColor = v97;
u102.DrawBackground = false;
u102.Visible = false;
local u103 = false;
local u104 = false;
local function u114(p105) --[[ Line: 376 ]]
    -- upvalues: u103 (ref), u100 (copy), u101 (copy), u102 (copy), u104 (ref), u99 (copy), u95 (ref), l__GetContext__33 (copy), l__GetNewestRun__34 (copy), l__EVENT_INPUT_RESET__12 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v106 = p105 > 0;
    if v106 and not u103 then
        u100.Visible = true;
    elseif not v106 and u103 then
        u101.Visible = false;
        u102.Visible = false;
        u100.Visible = false;
    end;
    u103 = v106;
    local v107 = p105 < 1;
    if v107 and not u104 then
        u100.Image = "rbxassetid://3615762920";
    elseif not v107 and u104 then
        u100.Image = "rbxassetid://3615762331";
    end;
    u104 = v107;
    if v106 then
        if v107 then
            local v108 = p105 < 0.5;
            u101.Visible = v108;
            u102.Visible = not v108;
            u100.Rotation = 6.283185307179586 * p105;
            return;
        end;
        u101.Visible = false;
        u102.Visible = false;
        u99.Visible = false;
        u95 = nil;
        local v109 = nil;
        if not v109 then
            local v110 = l__GetContext__33("Local");
            if v110 then
                local v111 = l__GetNewestRun__34(v110.Runs);
                if v111 then
                    v109 = v111.Mode;
                end;
            end;
        end;
        local v112 = l__EVENT_INPUT_RESET__12;
        local v113 = type(v112) == "number";
        assert(v113, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v112, v109);
    end;
end;
function u99.Think() --[[ Line: 409 ]]
    -- upvalues: u95 (ref), u114 (copy), u1 (copy)
    if u95 then
        u114(1 - (u95 - u1()) / 0.7);
    end;
end;
local v115 = l__Image__2(u99, "rbxassetid://3615945012");
v115.SizeOffsetX = 102;
v115.SizeOffsetY = 102;
v115.PosOffsetX = -1;
v115.PosOffsetY = -1;
v115.ImageColor = v96;
v115.DrawBackground = false;
v115.ZIndex = 6;
local v116 = l__TextBox__3(u99, "Reset");
v116.SizeScaleX = 1;
v116.SizeScaleY = 1;
v116.TextColor = v96;
v116.DrawBackground = false;
v116.TextFont = Enum.Font.Highway;
v116.TextSize = 40;
v116.TextAlignment = "Center";
v116.ZIndex = 6;
l__Hotkey__35:RegisterBindable("Reset", function(p117) --[[ Line: 432 ]]
    -- upvalues: l__GetContext__33 (copy), l__Global__5 (copy), l__GetNewestRun__34 (copy), l__EVENT_INPUT_RESET__12 (copy), u27 (copy), l__RootTimer__7 (copy), u99 (copy), u95 (ref), u1 (copy)
    if not p117 then
        u99.Visible = false;
        u95 = nil;
        return;
    end;
    local v118 = true;
    local v119 = l__GetContext__33("Local");
    if v119 then
        local v120 = l__Global__5:GetKey("SuppressResetBindAfterTime") or 60;
        for _, v121 in v119.Runs do
            if v121.InProgress and (v120 < v121.Timer:Time() or v121.ForceSupressReset) then
                v118 = false;
                break;
            end;
        end;
    end;
    if v118 then
        local v122 = nil;
        if not v122 then
            local v123 = l__GetContext__33("Local");
            if v123 then
                local v124 = l__GetNewestRun__34(v123.Runs);
                if v124 then
                    v122 = v124.Mode;
                end;
            end;
        end;
        local v125 = l__EVENT_INPUT_RESET__12;
        local v126 = type(v125) == "number";
        assert(v126, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v125, v122);
    else
        u99.Visible = true;
        u95 = u1() + 0.7;
    end;
end, "R");
local u127 = Instance.new("BindableEvent");
u127.Event:connect(function(p128) --[[ Name: Reset, Line 304 ]]
    -- upvalues: l__GetContext__33 (copy), l__GetNewestRun__34 (copy), l__EVENT_INPUT_RESET__12 (copy), u27 (copy), l__RootTimer__7 (copy)
    if not p128 then
        local v129 = l__GetContext__33("Local");
        if v129 then
            local v130 = l__GetNewestRun__34(v129.Runs);
            if v130 then
                p128 = v130.Mode;
            end;
        end;
    end;
    local v131 = l__EVENT_INPUT_RESET__12;
    local v132 = type(v131) == "number";
    assert(v132, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v131, p128);
end);
v4.Add({ "spawn", "s" }, {}, function() --[[ Line: 459 ]]
    -- upvalues: l__EVENT_INPUT_SPAWN__19 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v133 = l__EVENT_INPUT_SPAWN__19;
    local v134 = type(v133) == "number";
    assert(v134, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v133, nil);
end);
v4.Add({ "spawn", "s" }, { "Integer" }, function(p135) --[[ Line: 462 ]]
    -- upvalues: l__EVENT_INPUT_SPAWN__19 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v136 = l__EVENT_INPUT_SPAWN__19;
    local v137 = type(v136) == "number";
    assert(v137, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v136, p135);
end);
local u138 = false;
v4.Add({ "practice", "p" }, { "Boolean" }, function(p139) --[[ Line: 471 ]]
    -- upvalues: u138 (ref), l__EVENT_INPUT_PRACTICEMODE__18 (copy), u27 (copy), l__RootTimer__7 (copy)
    u138 = p139;
    local v140 = l__EVENT_INPUT_PRACTICEMODE__18;
    local v141 = u138;
    local v142 = type(v140) == "number";
    assert(v142, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v140, v141);
    return "Practice mode " .. (u138 and "enabled" or "disabled");
end);
v4.Add({ "practice", "p" }, {}, function() --[[ Line: 474 ]]
    -- upvalues: u138 (ref), l__EVENT_INPUT_PRACTICEMODE__18 (copy), u27 (copy), l__RootTimer__7 (copy)
    u138 = not u138;
    local v143 = l__EVENT_INPUT_PRACTICEMODE__18;
    local v144 = u138;
    local v145 = type(v143) == "number";
    assert(v145, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v143, v144);
    return "Practice mode " .. (u138 and "enabled" or "disabled");
end);
v4.Add("setspawn", {}, function() --[[ Line: 477 ]]
    -- upvalues: u138 (ref), l__GetContext__33 (copy), l__EVENT_INPUT_SETSPAWN__25 (copy), u27 (copy), l__RootTimer__7 (copy)
    if u138 then
        return "You cannot set spawn while in practice mode.";
    end;
    local v146 = l__GetContext__33("Local");
    if not v146 then
        return "No simulation context.";
    end;
    local l__Zones__46 = v146.Context.Simulation.GameMechanics.Zones;
    if l__Zones__46.VState then
        return "You cannot set spawn while the timer is running.";
    end;
    for _, v147 in l__Zones__46.InZones do
        if v147.Type == "Start" then
            local v148 = l__EVENT_INPUT_SETSPAWN__25;
            local v149 = type(v148) == "number";
            assert(v149, "EventID must be an integer");
            u27:Call("Input", l__RootTimer__7:Time(), v148, nil);
            return;
        end;
    end;
    return "You must be in the start zone to set spawn.";
end);
v4.Add({ "timescale", "ts" }, { "Number" }, function(p150) --[[ Line: 498 ]]
    -- upvalues: u138 (ref), l__GetContext__33 (copy), l__EVENT_INPUT_TIMESCALE__20 (copy), u27 (copy), l__RootTimer__7 (copy)
    if not u138 then
        local v151 = l__GetContext__33("Local");
        if v151 and not v151.Context.Simulation.GameMechanics.StyleInfo.allow_timescale then
            return "Timescale is not allowed in this style so is only available with /practice mode enabled.";
        end;
    end;
    if p150 < 0.01 or p150 > 2 then
        return "Timescale must be within the range 0.01-2";
    end;
    local v152 = l__EVENT_INPUT_TIMESCALE__20;
    local v153 = type(v152) == "number";
    assert(v153, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v152, p150);
end);
l__Hotkey__35:RegisterBindable("ToggleFly", function(p154) --[[ Line: 515 ]]
    -- upvalues: l__GetContext__33 (copy), u138 (ref), l__EVENT_INPUT_FLYMODE__23 (copy), u27 (copy), l__RootTimer__7 (copy)
    if p154 then
        local v155 = l__GetContext__33("Local");
        if v155 and (u138 or v155.Context.Simulation.GameMechanics.StyleInfo.allow_fly) then
            local v156 = l__EVENT_INPUT_FLYMODE__23;
            local v157 = (v155.Context.Simulation.GameMechanics:GetFlyMode() + 1) % 2;
            local v158 = type(v156) == "number";
            assert(v158, "EventID must be an integer");
            u27:Call("Input", l__RootTimer__7:Time(), v156, v157);
            return true;
        end;
    end;
end, "F");
local u159 = 80;
v4.Add({ "setflyspeed", "sfs" }, { "Number" }, function(p160) --[[ Line: 525 ]]
    -- upvalues: u138 (ref), l__GetContext__33 (copy), u159 (ref), l__EVENT_INPUT_FLYSPEED__24 (copy), u27 (copy), l__RootTimer__7 (copy)
    if not u138 then
        local v161 = l__GetContext__33("Local");
        if v161 and not v161.Context.Simulation.GameMechanics.StyleInfo.allow_fly_speed then
            return "SetFlySpeed is not allowed in this style so is only available with /practice mode enabled.";
        end;
    end;
    if p160 >= 1000 or p160 <= -1000 then
        return "Slow down there buddy, that\'s a bit fast.  Speed must be less than 1000.";
    end;
    u159 = p160;
    local v162 = l__EVENT_INPUT_FLYSPEED__24;
    local v163 = u159;
    local v164 = type(v162) == "number";
    assert(v164, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v162, v163);
end);
l__Hotkey__35:RegisterBindable("IncrementFlySpeed", function(p165) --[[ Line: 538 ]]
    -- upvalues: u138 (ref), l__GetContext__33 (copy), l__FLYMODE_FLY__10 (copy), u159 (ref), l__EVENT_INPUT_FLYSPEED__24 (copy), u27 (copy), l__RootTimer__7 (copy)
    if u138 then
        local v166 = l__GetContext__33("Local");
        if v166 and v166.Context.Simulation.GameMechanics:GetFlyMode() == l__FLYMODE_FLY__10 then
            u159 = math.clamp(u159 + p165, -1000, 1000);
            local v167 = l__EVENT_INPUT_FLYSPEED__24;
            local v168 = u159;
            local v169 = type(v167) == "number";
            assert(v169, "EventID must be an integer");
            u27:Call("Input", l__RootTimer__7:Time(), v167, v168);
            return true;
        end;
    end;
end, "MouseWheel");
l__Hotkey__35:RegisterBindable("ResetFlySpeed", function(p170) --[[ Line: 549 ]]
    -- upvalues: u159 (ref), l__EVENT_INPUT_FLYSPEED__24 (copy), u27 (copy), l__RootTimer__7 (copy)
    if p170 then
        u159 = 80;
        local v171 = l__EVENT_INPUT_FLYSPEED__24;
        local v172 = u159;
        local v173 = type(v171) == "number";
        assert(v173, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v171, v172);
    end;
end, "MouseButton3");
local u174 = false;
l__Profile__6:MonitorKey("TurnSpeedSlow", function(p175) --[[ Line: 558 ]]
    -- upvalues: u174 (ref), l__EVENT_INPUT_TURN_SPEED__30 (copy), u27 (copy), l__RootTimer__7 (copy)
    if not u174 then
        local v176 = l__EVENT_INPUT_TURN_SPEED__30;
        local v177 = type(v176) == "number";
        assert(v177, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v176, p175);
    end;
end);
l__Profile__6:MonitorKey("TurnSpeedFast", function(p178) --[[ Line: 563 ]]
    -- upvalues: u174 (ref), l__EVENT_INPUT_TURN_SPEED__30 (copy), u27 (copy), l__RootTimer__7 (copy)
    if u174 then
        local v179 = l__EVENT_INPUT_TURN_SPEED__30;
        local v180 = type(v179) == "number";
        assert(v180, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v179, p178);
    end;
end);
l__Hotkey__35:RegisterBindable("ToggleTurnFast", function(p181) --[[ Line: 568 ]]
    -- upvalues: u174 (ref), l__EVENT_INPUT_TURN_SPEED__30 (copy), l__Profile__6 (copy), u27 (copy), l__RootTimer__7 (copy)
    if p181 then
        u174 = not u174;
        local v182 = l__EVENT_INPUT_TURN_SPEED__30;
        local v183 = u174 and (l__Profile__6:GetKey("TurnSpeedFast") or 8.780450911948757) or (l__Profile__6:GetKey("TurnSpeedSlow") or 4.390225455974378);
        local v184 = type(v182) == "number";
        assert(v184, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v182, v183);
    end;
end);
l__Hotkey__35:RegisterBindable("HoldToTurnFast", function(p185) --[[ Line: 574 ]]
    -- upvalues: u174 (ref), l__EVENT_INPUT_TURN_SPEED__30 (copy), l__Profile__6 (copy), u27 (copy), l__RootTimer__7 (copy)
    u174 = p185;
    local v186 = l__EVENT_INPUT_TURN_SPEED__30;
    local v187 = p185 and (l__Profile__6:GetKey("TurnSpeedFast") or 8.780450911948757) or (l__Profile__6:GetKey("TurnSpeedSlow") or 4.390225455974378);
    local v188 = type(v186) == "number";
    assert(v188, "EventID must be an integer");
    u27:Call("Input", l__RootTimer__7:Time(), v186, v187);
end);
local u189 = {};
local function u196(p190) --[[ Line: 591 ]]
    -- upvalues: l__GetContext__33 (copy), u138 (ref), u13 (copy), u189 (copy), l__EVENT_INPUT_SAVESTATE__21 (copy), u27 (copy), l__RootTimer__7 (copy)
    local v191 = l__GetContext__33("Local");
    if not v191 then
        return;
    end;
    local v192, v193, v194;
    for _, v195 in v191.Runs do
        if not v195.Started then
            v192 = false;
            if v192 and (v191.Context.Simulation.GameMechanics.StyleInfo.allow_timetravel or u138) then
                u189[p190] = {
                    MousePos = u13.MousePos,
                    ScrollPos = u13.ScrollPos
                };
                v193 = l__EVENT_INPUT_SAVESTATE__21;
                v194 = type(v193) == "number";
                assert(v194, "EventID must be an integer");
                u27:Call("Input", l__RootTimer__7:Time(), v193, p190);
            end;
            return;
        end;
    end;
    v192 = true;
    if v192 and (v191.Context.Simulation.GameMechanics.StyleInfo.allow_timetravel or u138) then
        u189[p190] = {
            MousePos = u13.MousePos,
            ScrollPos = u13.ScrollPos
        };
        v193 = l__EVENT_INPUT_SAVESTATE__21;
        v194 = type(v193) == "number";
        assert(v194, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v193, p190);
    end;
end;
local function u209(p197) --[[ Line: 606 ]]
    -- upvalues: l__GetContext__33 (copy), u189 (copy), u138 (ref), u13 (copy), l__EVENT_INPUT_LOADSTATE__22 (copy), u27 (copy), l__RootTimer__7 (copy), u17 (ref), u73 (ref)
    local v198 = l__GetContext__33("Local");
    if not v198 then
        return;
    end;
    local v199, v200, v201, v202, v203;
    for _, v204 in v198.Runs do
        if not v204.Started then
            v199 = false;
            if v199 then
                v200 = v198.Context.Simulation;
                v201 = u189[p197];
                if not (v201 and v200.States[p197]) then
                    return "State with name \'" .. p197 .. "\' does not exist.", true;
                end;
                if v200.GameMechanics.StyleInfo.allow_timetravel or u138 then
                    for v207, v208 in v201 do
                        u13[v207] = v208;
                    end;
                    v202 = l__EVENT_INPUT_LOADSTATE__22;
                    v203 = type(v202) == "number";
                    assert(v203, "EventID must be an integer");
                    u27:Call("Input", l__RootTimer__7:Time(), v202, p197);
                    u17 = true;
                    u73(true);
                    return;
                end;
            end;
            return;
        end;
    end;
    v199 = true;
    if v199 then
        v200 = v198.Context.Simulation;
        v201 = u189[p197];
        if not (v201 and v200.States[p197]) then
            return "State with name \'" .. p197 .. "\' does not exist.", true;
        end;
        if v200.GameMechanics.StyleInfo.allow_timetravel or u138 then
            for v207, v208 in v201 do
                u13[v207] = v208;
            end;
            v202 = l__EVENT_INPUT_LOADSTATE__22;
            v203 = type(v202) == "number";
            assert(v203, "EventID must be an integer");
            u27:Call("Input", l__RootTimer__7:Time(), v202, p197);
            u17 = true;
            u73(true);
        end;
    end;
end;
local u210 = 0;
l__Hotkey__35:RegisterBindable("SaveState", function(p211) --[[ Line: 627 ]]
    -- upvalues: u210 (ref), u196 (copy)
    if p211 then
        u210 = u210 + 1;
        u196((tostring(u210)));
    end;
end, "One");
l__Hotkey__35:RegisterBindable("LoadState", function(p212) --[[ Line: 633 ]]
    -- upvalues: u209 (copy), u210 (ref)
    if p212 then
        u209((tostring(u210)));
    end;
end, "Two");
l__Hotkey__35:RegisterBindable("DecrementSaveState", function(p213) --[[ Line: 638 ]]
    -- upvalues: u210 (ref), u209 (copy)
    if p213 then
        u210 = u210 - 1;
        u209((tostring(u210)));
    end;
end, "Three");
l__Hotkey__35:RegisterBindable("IncrementSaveState", function(p214) --[[ Line: 644 ]]
    -- upvalues: u210 (ref), u209 (copy)
    if p214 then
        u210 = u210 + 1;
        u209((tostring(u210)));
    end;
end, "Four");
v4.Add("save", {}, function() --[[ Line: 651 ]]
    -- upvalues: u196 (copy)
    u196("Default");
end);
v4.Add("load", {}, function() --[[ Line: 654 ]]
    -- upvalues: u209 (copy)
    u209("Default");
end);
v4.Add("save", { "Source" }, u196);
v4.Add("load", { "Source" }, u209);
return {
    Init = function() --[[ Name: Init, Line 664 ]]
        -- upvalues: l__EVENT_INPUT_INIT__16 (copy), u27 (copy), l__RootTimer__7 (copy), u37 (copy), l__StarterGui__38 (copy), u127 (copy)
        local v215 = l__EVENT_INPUT_INIT__16;
        local v216 = type(v215) == "number";
        assert(v216, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v215, nil);
        u37();
        while not pcall(function() --[[ Line: 667 ]]
            -- upvalues: l__StarterGui__38 (ref), u127 (ref)
            l__StarterGui__38:SetCore("ResetButtonCallback", u127);
        end) do
            wait();
        end;
    end,
    OutputMulticall = u27,
    SetStyle = function(p217) --[[ Name: SetStyle, Line 329 ]]
        -- upvalues: l__SetPlayer__4 (copy), l__EVENT_INPUT_STYLE__26 (copy), u27 (copy), l__RootTimer__7 (copy)
        l__SetPlayer__4();
        local v218 = l__EVENT_INPUT_STYLE__26;
        local v219 = type(v218) == "number";
        assert(v219, "EventID must be an integer");
        u27:Call("Input", l__RootTimer__7:Time(), v218, p217);
    end
};
