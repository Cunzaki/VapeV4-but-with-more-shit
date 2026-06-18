-- Decompiled from: Start.Client.Classes._xe5b4354b6db0787c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
function u1._xafd29f1684593d0b() --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._xd4adcc57399be3e0 = nil;
    v2._x3b893b9df9a61169 = 0;
    v2._x06f4a027cb8016f2 = nil;
    v2._x80ab2ac9432762e1 = false;
    return v2;
end;
function u1._x9311dd08b2638d27(p3) --[[ Line: 42 ]]
    local l___xd4adcc57399be3e0__4 = p3._xd4adcc57399be3e0;
    if l___xd4adcc57399be3e0__4 then
        l___xd4adcc57399be3e0__4 = p3._xd4adcc57399be3e0.gameplay;
    end;
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and not l___xd4adcc57399be3e0__4 then
        return nil;
    end;
    local v7 = tostring(game.GameId);
    local v8 = 46;
    for v9 = 1, #v7 do
        v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
    end;
    if v8 == 272 and l___xd4adcc57399be3e0__4.photosensitivity_enabled == nil then
        l___xd4adcc57399be3e0__4.photosensitivity_enabled = false;
    end;
    local v10 = tostring(game.GameId);
    local v11 = 46;
    for v12 = 1, #v10 do
        v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
    end;
    if v11 == 272 and l___xd4adcc57399be3e0__4.photosensitivity_warning_seen == nil then
        l___xd4adcc57399be3e0__4.photosensitivity_warning_seen = false;
    end;
    return l___xd4adcc57399be3e0__4;
end;
function u1._x292d1e6f7057797e(u13) --[[ Line: 58 ]]
    local v14 = tostring(game.GameId);
    local v15 = 46;
    for v16 = 1, #v14 do
        v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
    end;
    if v15 == 272 and u13._x06f4a027cb8016f2 then
        task.cancel(u13._x06f4a027cb8016f2);
        u13._x06f4a027cb8016f2 = nil;
    end;
    local v17 = 0.6 - (os.clock() - u13._x3b893b9df9a61169);
    local v18 = math.max(0, v17);
    u13._x06f4a027cb8016f2 = task.delay(v18, function() --[[ Line: 66 ]]
        -- upvalues: u13 (copy)
        u13._x06f4a027cb8016f2 = nil;
        u13:_x47a618573b7677b3();
    end);
end;
function u1._xe8ad7c39a0c80e57(u19) --[[ Line: 72 ]]
    -- upvalues: l__Classes__3 (copy)
    local u20 = u19:_x9311dd08b2638d27();
    local v21 = tostring(game.GameId);
    local v22 = 46;
    for v23 = 1, #v21 do
        v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
    end;
    if v22 == 272 and not u20 then
    else
        local v24 = tostring(game.GameId);
        local v25 = 46;
        for v26 = 1, #v24 do
            v25 = (v25 * 33 + string.byte(v24, v26)) % 65521;
        end;
        if v25 == 272 and (u20.photosensitivity_warning_seen or u19._x80ab2ac9432762e1) then
        else
            u19._x80ab2ac9432762e1 = true;
            l__Classes__3._xb90403a8caac4128:_x003a1e06c5ce82d3("Modal", {
                title_text = "This game contains flashing lights.",
                body_text = "If you are sensitive to flashing lights, enable the photosensitivity setting (darkens flashes) and <b>play with caution.</b>",
                actions = {
                    {
                        action_text = "I Understand",
                        action_bg_color = Color3.fromRGB(0, 120, 0),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 90 ]]
                            -- upvalues: u20 (copy), u19 (copy)
                            u20.photosensitivity_warning_seen = true;
                            u19:_x292d1e6f7057797e();
                        end
                    }
                }
            });
        end;
    end;
end;
function u1._x7d4c56fe29c74cc4(p27) --[[ Line: 99 ]]
    -- upvalues: l__Classes__3 (copy)
    local v28 = tostring(game.GameId);
    local v29 = 46;
    for v30 = 1, #v28 do
        v29 = (v29 * 33 + string.byte(v28, v30)) % 65521;
    end;
    if v29 == 272 and not p27._xd4adcc57399be3e0 then
        warn("NO SETTINGS");
    else
        local v31 = p27:_x9311dd08b2638d27();
        local v32 = tostring(game.GameId);
        local v33 = 46;
        for v34 = 1, #v32 do
            v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
        end;
        if v33 == 272 and v31 then
            local v35 = tostring(game.GameId);
            local v36 = 46;
            for v37 = 1, #v35 do
                v36 = (v36 * 33 + string.byte(v35, v37)) % 65521;
            end;
            if v36 == 272 and l__Classes__3._x2b1f81c73714b323 then
                l__Classes__3._x2b1f81c73714b323._x334823407cf33cc2._xae085f26c730ab30 = v31.fov;
            end;
            local v38 = tostring(game.GameId);
            local v39 = 46;
            for v40 = 1, #v38 do
                v39 = (v39 * 33 + string.byte(v38, v40)) % 65521;
            end;
            if v39 == 272 and l__Classes__3.Config then
                l__Classes__3.Config._x6eca27f9f9486423 = v31.strafe_assist;
                l__Classes__3.Config._xd6b90038c3129e33 = v31.wallrun_input;
            end;
            local v41 = tostring(game.GameId);
            local v42 = 46;
            for v43 = 1, #v41 do
                v42 = (v42 * 33 + string.byte(v41, v43)) % 65521;
            end;
            if v42 == 272 and l__Classes__3._x9b074161e70581e8 then
                l__Classes__3._x9b074161e70581e8._xa90960bc078ef532 = v31.dynamic_music;
                l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928 = v31.mute_music;
            end;
            local v44 = tostring(game.GameId);
            local v45 = 46;
            for v46 = 1, #v44 do
                v45 = (v45 * 33 + string.byte(v44, v46)) % 65521;
            end;
            if v45 == 272 and l__Classes__3._x7c4d08c7bcf3460a then
                l__Classes__3._x7c4d08c7bcf3460a._x24e13a8a21a89c10 = v31.effect_quality;
                l__Classes__3._x7c4d08c7bcf3460a:_x218da71a19068c73(v31.photosensitivity_enabled);
            end;
            game:GetService("Lighting").GlobalShadows = v31.shadows_enabled;
            local v47 = tostring(game.GameId);
            local v48 = 46;
            for v49 = 1, #v47 do
                v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
            end;
            if v48 == 272 and (v31.contract_notifs == "Disabled" and l__Classes__3._x681f9eca9bf2c7e2) then
                l__Classes__3._x681f9eca9bf2c7e2._x0101e6348c998de3 = true;
            end;
        end;
        local l__keybinds__5 = p27._xd4adcc57399be3e0.keybinds;
        local v50 = tostring(game.GameId);
        local v51 = 46;
        for v52 = 1, #v50 do
            v51 = (v51 * 33 + string.byte(v50, v52)) % 65521;
        end;
        if v51 == 272 and l__keybinds__5 then
            for v53, v54 in pairs(l__keybinds__5) do
                local v55 = v53:upper();
                l__Classes__3._xd2c44c643b0c3fb4:_xb0c25e51d5052cdf(v55, Enum.KeyCode[v54], true);
            end;
        end;
    end;
end;
function u1._x47a618573b7677b3(p56) --[[ Line: 145 ]]
    -- upvalues: l__Packets__2 (copy)
    p56._x3b893b9df9a61169 = os.clock();
    l__Packets__2._x38ed1f49b70152bd:Fire(p56._xd4adcc57399be3e0);
end;
function u1._xcce25b09da694450(p57) --[[ Line: 150 ]]
    return p57._xd4adcc57399be3e0;
end;
function u1._x02d532d0381e044d(p58) --[[ Line: 154 ]]
    -- upvalues: l__Packets__2 (copy)
    p58._x3b893b9df9a61169 = os.clock();
    return l__Packets__2._xb25cbf8ed4ab781d:Fire();
end;
function u1._xd8041402b83e75db(p59) --[[ Line: 159 ]]
    p59._xd4adcc57399be3e0 = p59:_x02d532d0381e044d();
    local v60 = tostring(game.GameId);
    local v61 = 46;
    for v62 = 1, #v60 do
        v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
    end;
    if v61 == 272 and p59._xd4adcc57399be3e0 then
        p59:_x7d4c56fe29c74cc4();
        p59:_xe8ad7c39a0c80e57();
    end;
end;
return u1;
