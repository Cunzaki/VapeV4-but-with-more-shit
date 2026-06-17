-- Decompiled from: Start.Client.Classes._xcc1d26f1d7ab7ac2
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u1._x83ed94bfb82a8c9f() --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._x9a534d0c2abfa25f = nil;
    v2._x1f8f3729d8021293 = 0;
    v2._x266471a3f3ce58ee = nil;
    v2._x9a486a8544feda85 = false;
    return v2;
end;
function u1._x3cc841239fb369c2(p3) --[[ Line: 42 ]]
    local l___x9a534d0c2abfa25f__4 = p3._x9a534d0c2abfa25f;
    if l___x9a534d0c2abfa25f__4 then
        l___x9a534d0c2abfa25f__4 = p3._x9a534d0c2abfa25f.gameplay;
    end;
    if not l___x9a534d0c2abfa25f__4 then
        return nil;
    end;
    if l___x9a534d0c2abfa25f__4.photosensitivity_enabled == nil then
        l___x9a534d0c2abfa25f__4.photosensitivity_enabled = false;
    end;
    if l___x9a534d0c2abfa25f__4.photosensitivity_warning_seen == nil then
        l___x9a534d0c2abfa25f__4.photosensitivity_warning_seen = false;
    end;
    return l___x9a534d0c2abfa25f__4;
end;
function u1._xa23ebef6e64b3ee7(u4) --[[ Line: 58 ]]
    if u4._x266471a3f3ce58ee then
        task.cancel(u4._x266471a3f3ce58ee);
        u4._x266471a3f3ce58ee = nil;
    end;
    local v5 = 0.6 - (os.clock() - u4._x1f8f3729d8021293);
    local v6 = math.max(0, v5);
    u4._x266471a3f3ce58ee = task.delay(v6, function() --[[ Line: 66 ]]
        -- upvalues: u4 (copy)
        u4._x266471a3f3ce58ee = nil;
        u4:_x311cb8a4b6f24c96();
    end);
end;
function u1._xa1c622209bb3a67a(u7) --[[ Line: 72 ]]
    -- upvalues: l__Classes__3 (copy)
    local u8 = u7:_x3cc841239fb369c2();
    if u8 then
        if u8.photosensitivity_warning_seen or u7._x9a486a8544feda85 then
        else
            u7._x9a486a8544feda85 = true;
            l__Classes__3._xe4b708070c7cd741:_x85ec8b5d5b90212b("Modal", {
                title_text = "This game contains flashing lights.",
                body_text = "If you are sensitive to flashing lights, enable the photosensitivity setting (darkens flashes) and <b>play with caution.</b>",
                actions = {
                    {
                        action_text = "I Understand",
                        action_bg_color = Color3.fromRGB(0, 120, 0),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 90 ]]
                            -- upvalues: u8 (copy), u7 (copy)
                            u8.photosensitivity_warning_seen = true;
                            u7:_xa23ebef6e64b3ee7();
                        end
                    }
                }
            });
        end;
    end;
end;
function u1._xa9e43af7dbc27298(p9) --[[ Line: 99 ]]
    -- upvalues: l__Classes__3 (copy)
    if p9._x9a534d0c2abfa25f then
        local v10 = p9:_x3cc841239fb369c2();
        if v10 then
            if l__Classes__3._xdca80115d2839102 then
                l__Classes__3._xdca80115d2839102._x6142a368f111d36e._xb66c1aa5df35d452 = v10.fov;
            end;
            if l__Classes__3._x150a19552e17c1ce then
                l__Classes__3._x150a19552e17c1ce._x2a8f690325de1f43 = v10.strafe_assist;
                l__Classes__3._x150a19552e17c1ce._x9067c0c3e7e7a67a = v10.wallrun_input;
            end;
            if l__Classes__3._x3019cc5b1f776551 then
                l__Classes__3._x3019cc5b1f776551._xb9df97bde374ab0a = v10.dynamic_music;
                l__Classes__3._x3019cc5b1f776551._x81af12119ee977ea = v10.mute_music;
            end;
            if l__Classes__3._x181e05d210129765 then
                l__Classes__3._x181e05d210129765._x2ed0ede9312970c7 = v10.effect_quality;
                l__Classes__3._x181e05d210129765:_x30accd53c498f58e(v10.photosensitivity_enabled);
            end;
            game:GetService("Lighting").GlobalShadows = v10.shadows_enabled;
            if v10.contract_notifs == "Disabled" and l__Classes__3._xa02ac272d3d8651f then
                l__Classes__3._xa02ac272d3d8651f._x973f0f5695fe8b64 = true;
            end;
        end;
        local l__keybinds__5 = p9._x9a534d0c2abfa25f.keybinds;
        if l__keybinds__5 then
            for v11, v12 in pairs(l__keybinds__5) do
                local v13 = v11:upper();
                l__Classes__3._xf1ad98d2d70b7408:_x699126f0fae5b271(v13, Enum.KeyCode[v12], true);
            end;
        end;
    else
        warn("NO SETTINGS");
    end;
end;
function u1._x311cb8a4b6f24c96(p14) --[[ Line: 145 ]]
    -- upvalues: l__Packets__2 (copy)
    p14._x1f8f3729d8021293 = os.clock();
    l__Packets__2._x1e8f270f7b6f5329:Fire(p14._x9a534d0c2abfa25f);
end;
function u1._x32846173efb1c157(p15) --[[ Line: 150 ]]
    return p15._x9a534d0c2abfa25f;
end;
function u1._x1013ebf1bb6eb8a8(p16) --[[ Line: 154 ]]
    -- upvalues: l__Packets__2 (copy)
    p16._x1f8f3729d8021293 = os.clock();
    return l__Packets__2._x6058574c8f1e416c:Fire();
end;
function u1._x44bcd6af41218f92(p17) --[[ Line: 159 ]]
    p17._x9a534d0c2abfa25f = p17:_x1013ebf1bb6eb8a8();
    if p17._x9a534d0c2abfa25f then
        p17:_xa9e43af7dbc27298();
        p17:_xa1c622209bb3a67a();
    end;
end;
return u1;
