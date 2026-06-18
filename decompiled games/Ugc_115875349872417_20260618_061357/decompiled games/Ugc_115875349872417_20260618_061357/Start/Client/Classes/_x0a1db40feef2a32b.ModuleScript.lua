-- Decompiled from: Start.Client.Classes._x0a1db40feef2a32b
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
local u1 = {};
u1.__index = u1;
local l__Classes__3 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x90d4581ac99dd483() --[[ Line: 22 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._xefa97ea8f9399a0a = nil;
    v2._xb127edb846a18934 = 0;
    v2._x61f947c314c00930 = nil;
    v2._xba8de60c910f83ec = false;
    return v2;
end;
function u1._xbb108b351c993ee3(p3) --[[ Line: 33 ]]
    local l___xefa97ea8f9399a0a__4 = p3._xefa97ea8f9399a0a;
    if l___xefa97ea8f9399a0a__4 then
        l___xefa97ea8f9399a0a__4 = p3._xefa97ea8f9399a0a.gameplay;
    end;
    if not l___xefa97ea8f9399a0a__4 then
        return nil;
    end;
    if l___xefa97ea8f9399a0a__4.photosensitivity_enabled == nil then
        l___xefa97ea8f9399a0a__4.photosensitivity_enabled = false;
    end;
    if l___xefa97ea8f9399a0a__4.photosensitivity_warning_seen == nil then
        l___xefa97ea8f9399a0a__4.photosensitivity_warning_seen = false;
    end;
    return l___xefa97ea8f9399a0a__4;
end;
function u1._x073b3a608436dc36(u4) --[[ Line: 49 ]]
    if u4._x61f947c314c00930 then
        task.cancel(u4._x61f947c314c00930);
        u4._x61f947c314c00930 = nil;
    end;
    local v5 = 0.6 - (os.clock() - u4._xb127edb846a18934);
    local v6 = math.max(0, v5);
    u4._x61f947c314c00930 = task.delay(v6, function() --[[ Line: 57 ]]
        -- upvalues: u4 (copy)
        u4._x61f947c314c00930 = nil;
        u4:_x392b49fd3c63be6e();
    end);
end;
function u1._x9a6c15ea327322be(u7) --[[ Line: 63 ]]
    -- upvalues: l__Classes__3 (copy)
    local u8 = u7:_xbb108b351c993ee3();
    if u8 then
        if u8.photosensitivity_warning_seen or u7._xba8de60c910f83ec then
        else
            u7._xba8de60c910f83ec = true;
            l__Classes__3._xd00ac57201023755:_x4782af5368e4c758("Modal", {
                title_text = "This game contains flashing lights.",
                body_text = "If you are sensitive to flashing lights, enable the photosensitivity setting (darkens flashes) and <b>play with caution.</b>",
                actions = {
                    {
                        action_text = "I Understand",
                        action_bg_color = Color3.fromRGB(0, 120, 0),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 81 ]]
                            -- upvalues: u8 (copy), u7 (copy)
                            u8.photosensitivity_warning_seen = true;
                            u7:_x073b3a608436dc36();
                        end
                    }
                }
            });
        end;
    end;
end;
function u1._xb850ce5141a9c1be(p9) --[[ Line: 90 ]]
    -- upvalues: l__Classes__3 (copy)
    if p9._xefa97ea8f9399a0a then
        local v10 = p9:_xbb108b351c993ee3();
        if v10 then
            if l__Classes__3._x32ae459de0772e82 then
                l__Classes__3._x32ae459de0772e82._xfb1e5eeed3a7e98d._x3026d7d6f5887abd = v10.fov;
            end;
            if l__Classes__3.Config then
                l__Classes__3.Config._xc444013050a10961 = v10.strafe_assist;
                l__Classes__3.Config._xf52953a67b88942f = v10.wallrun_input;
            end;
            if l__Classes__3._xfaee1d1d64cdfe93 then
                l__Classes__3._xfaee1d1d64cdfe93._xbfb7d045fd9aeae2 = v10.dynamic_music;
                l__Classes__3._xfaee1d1d64cdfe93._x9d953ef0950533a5 = v10.mute_music;
            end;
            if l__Classes__3._x255cd8d76027f039 then
                l__Classes__3._x255cd8d76027f039._x6b731715d23e3286 = v10.effect_quality;
                l__Classes__3._x255cd8d76027f039:_x94162666f637b130(v10.photosensitivity_enabled);
            end;
            game:GetService("Lighting").GlobalShadows = v10.shadows_enabled;
            if v10.contract_notifs == "Disabled" and l__Classes__3._x79fd9ea2402ae279 then
                l__Classes__3._x79fd9ea2402ae279._x970206ebb8c0860b = true;
            end;
        end;
        local l__keybinds__5 = p9._xefa97ea8f9399a0a.keybinds;
        if l__keybinds__5 then
            for v11, v12 in pairs(l__keybinds__5) do
                local v13 = v11:upper();
                l__Classes__3._x3e046bec2684f59c:_xe8233003806bed87(v13, Enum.KeyCode[v12], true);
            end;
        end;
    else
        warn("NO SETTINGS");
    end;
end;
function u1._x392b49fd3c63be6e(p14) --[[ Line: 136 ]]
    -- upvalues: l__Packets__2 (copy)
    p14._xb127edb846a18934 = os.clock();
    l__Packets__2._x8d4e0a4e661af272:Fire(p14._xefa97ea8f9399a0a);
end;
function u1._x2c5470dc192b8f08(p15) --[[ Line: 141 ]]
    return p15._xefa97ea8f9399a0a;
end;
function u1._x19ed44bd7a2702f0(p16) --[[ Line: 145 ]]
    -- upvalues: l__Packets__2 (copy)
    p16._xb127edb846a18934 = os.clock();
    return l__Packets__2._x3f12d9c922d8fa3c:Fire();
end;
function u1._xe53615d96cf36a6b(p17) --[[ Line: 150 ]]
    p17._xefa97ea8f9399a0a = p17:_x19ed44bd7a2702f0();
    if p17._xefa97ea8f9399a0a then
        p17:_xb850ce5141a9c1be();
        p17:_x9a6c15ea327322be();
    end;
end;
return u1;
