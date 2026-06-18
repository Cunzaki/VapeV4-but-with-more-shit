-- Decompiled from: Start.Client.Classes._x596eb619070480ba
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
local l__Signal__5 = require(l__ModuleScripts__3.Signal);
local l__Promise__6 = require(l__ModuleScripts__3.Promise);
local l__Trove__7 = require(l__ModuleScripts__3.Trove);
local u1 = {};
u1.__index = u1;
local l__ClientRoot__8 = require(script.Parent.Parent.ClientRoot);
local l__Classes__9 = l__ClientRoot__8.Classes;
local l__Context__10 = l__ClientRoot__8.Context;
local l__InternalSymbols__11 = require(script.Parent.Parent.InternalSymbols);
local l__LocalPlayer__12 = game.Players.LocalPlayer;
function u1._xafd29f1684593d0b() --[[ Line: 39 ]]
    -- upvalues: u1 (copy), l__Signal__5 (copy), l__Trove__7 (copy)
    local v2 = setmetatable({}, u1);
    v2._x885b2725a1933f2e = "inactive";
    v2._x27395816f3884377 = game.Players.LocalPlayer:WaitForChild("ReadOnly");
    v2._x7f9c9d94108df00a = nil;
    v2._xc4a7fd8f25937fc7 = {
        onDeath = l__Signal__5.new(),
        onSpawn = l__Signal__5.new(),
        onBreaking = l__Signal__5.new(),
        onDamageTaken = l__Signal__5.new(),
        onHit = l__Signal__5.new(),
        pingChanged = l__Signal__5.new()
    };
    v2._x730775c5207957d3 = {
        is_breaking = false,
        break_duration = 0,
        initial_duration = 0,
        break_end_time = 0
    };
    v2._xcd2d5f129d825c00 = 0;
    v2._xaa9a3c6bb43edabe = nil;
    v2._xc2d2438cd4ae1da5 = l__Trove__7.new();
    v2._x0ebb8be9d0fb54be = 0;
    v2._x6c5abddbda8a829c = 0;
    v2._x6719cebafa604e6c = false;
    v2._x3645bb400b362a9e = false;
    return v2;
end;
function u1._x66a8dec3fc4a9bdd(p3) --[[ Line: 76 ]]
    -- upvalues: l__Context__10 (copy), l__Packets__4 (copy)
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and not l__Context__10.is_ffa_mode then
    else
        local v7 = tostring(game.GameId);
        local v8 = 46;
        for v9 = 1, #v7 do
            v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
        end;
        if v8 == 272 and (p3._x885b2725a1933f2e ~= "alive" or p3._x3645bb400b362a9e) then
        else
            p3._x3645bb400b362a9e = true;
            l__Packets__4._x8558823a46f1bd44:Fire();
        end;
    end;
end;
function u1._xa877bda3a1894ffc(p10) --[[ Line: 89 ]]
    return p10._x0ebb8be9d0fb54be;
end;
function u1._xd8041402b83e75db(u11) --[[ Line: 93 ]]
    -- upvalues: l__Packets__4 (copy), l__RunService__1 (copy)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    u11:_xd52e2a8167582716();
    local v12 = u11:_x99c2a19f9a3f5eff("level");
    u11._x6c5abddbda8a829c = v12.Value;
    v12.Changed:Connect(function(p13) --[[ Line: 104 ]]
        -- upvalues: u11 (copy)
        u11._x6c5abddbda8a829c = p13;
    end);
    l__Packets__4.unreliablePackets._xedf0e52fe5242c34.OnClientEvent:Connect(function(p14) --[[ Line: 108 ]]
        -- upvalues: u11 (copy)
        u11._x0ebb8be9d0fb54be = p14;
        u11:_x0b64af9146930e4b("pingChanged"):Fire(p14);
    end);
    l__RunService__1.RenderStepped:Connect(function(p15) --[[ Line: 113 ]]
        -- upvalues: u11 (copy)
        u11:_x8c8024bb1156055f(p15);
    end);
end;
function u1._x8c8024bb1156055f(p16, p17) --[[ Line: 118 ]]
    -- upvalues: l__Classes__9 (copy), l__LocalPlayer__12 (copy), l__UserInputService__2 (copy)
    local l___x730775c5207957d3__13 = p16._x730775c5207957d3;
    local l__break_end_time__14 = l___x730775c5207957d3__13.break_end_time;
    local v18 = tostring(game.GameId);
    local v19 = 46;
    for v20 = 1, #v18 do
        v19 = (v19 * 33 + string.byte(v18, v20)) % 65521;
    end;
    local v21 = v19 == 272 and (typeof(l__break_end_time__14) ~= "number" or (l__break_end_time__14 ~= l__break_end_time__14 or (l__break_end_time__14 == (1 / 0) or l__break_end_time__14 == (-1 / 0)))) and 0 or math.max(l__break_end_time__14, 0);
    local l__break_duration__15 = l___x730775c5207957d3__13.break_duration;
    local v22 = tostring(game.GameId);
    local v23 = 46;
    for v24 = 1, #v22 do
        v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
    end;
    local v25 = v23 == 272 and (typeof(l__break_duration__15) ~= "number" or (l__break_duration__15 ~= l__break_duration__15 or (l__break_duration__15 == (1 / 0) or l__break_duration__15 == (-1 / 0)))) and 0 or math.max(l__break_duration__15, 0);
    local v26 = tostring(game.GameId);
    local v27 = 46;
    for v28 = 1, #v26 do
        v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
    end;
    if v27 == 272 and v21 > 0 then
        local v29 = v21 - os.clock();
        v25 = math.max(v29, 0);
    else
        local v30 = tostring(game.GameId);
        local v31 = 46;
        for v32 = 1, #v30 do
            v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
        end;
        if v31 == 272 and v25 > 0 then
            v25 = math.max(v25 - p17, 0);
        end;
    end;
    l___x730775c5207957d3__13.break_duration = v25;
    local v33 = tostring(game.GameId);
    local v34 = 46;
    for v35 = 1, #v33 do
        v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
    end;
    if v34 == 272 and v25 <= 0 then
        local v36 = tostring(game.GameId);
        local v37 = 46;
        for v38 = 1, #v36 do
            v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
        end;
        if v37 == 272 and (l___x730775c5207957d3__13.is_breaking or v21 > 0) then
            p16:_xa6fc29314bdec4f8(false);
        else
            l___x730775c5207957d3__13.is_breaking = false;
            l___x730775c5207957d3__13.break_duration = 0;
            l___x730775c5207957d3__13.break_end_time = 0;
        end;
    else
        l___x730775c5207957d3__13.is_breaking = true;
    end;
    local l___x39fa63447426dab1__16 = l__Classes__9._x39fa63447426dab1;
    local l___xb90403a8caac4128__17 = l__Classes__9._xb90403a8caac4128;
    local v39 = p16._x6719cebafa604e6c or l___x39fa63447426dab1__16 and l___x39fa63447426dab1__16._x9e8bd43692d96e07 or (l___xb90403a8caac4128__17 and #l___xb90403a8caac4128__17._x31cb67b0006e6506 >= 1 and true or false);
    local l__FreeMouse__18 = l__LocalPlayer__12.PlayerGui.FreeMouse;
    local v40 = tostring(game.GameId);
    local v41 = 46;
    for v42 = 1, #v40 do
        v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
    end;
    if v41 == 272 and v39 then
        l__UserInputService__2.MouseIconEnabled = true;
    end;
    l__FreeMouse__18.Enabled = v39;
    l__FreeMouse__18.Modal.Visible = v39;
end;
function u1._xb42429132e1dead7(p43, p44) --[[ Line: 157 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy)
    local v45 = tostring(game.GameId);
    local v46 = 46;
    for v47 = 1, #v45 do
        v46 = (v46 * 33 + string.byte(v45, v47)) % 65521;
    end;
    if v46 == 272 and not (p44 or l__Context__10.is_gameplay_mode) then
    else
        p43._x885b2725a1933f2e = "suspended";
        l__Classes__9._xd2c44c643b0c3fb4:_x7bb8b491a142ab2b();
        l__Classes__9._xaffa998c3a825e19._x0e0d0acaaa1322c0 = false;
        l__Classes__9._x2b1f81c73714b323._x7324f78af14e3910 = true;
    end;
end;
function u1._xa6fc29314bdec4f8(p48, p49) --[[ Line: 166 ]]
    p48._xcd2d5f129d825c00 = p48._xcd2d5f129d825c00 + 1;
    p48._x730775c5207957d3.break_duration = 0;
    p48._x730775c5207957d3.initial_duration = 0;
    p48._x730775c5207957d3.break_end_time = 0;
    p48._x730775c5207957d3.is_breaking = false;
    local l___xaa9a3c6bb43edabe__19 = p48._xaa9a3c6bb43edabe;
    p48._xaa9a3c6bb43edabe = nil;
    local v50 = tostring(game.GameId);
    local v51 = 46;
    for v52 = 1, #v50 do
        v51 = (v51 * 33 + string.byte(v50, v52)) % 65521;
    end;
    if v51 == 272 and l___xaa9a3c6bb43edabe__19 then
        local v53, v54 = pcall(l___xaa9a3c6bb43edabe__19, p49 == true);
        local v55 = tostring(game.GameId);
        local v56 = 46;
        for v57 = 1, #v55 do
            v56 = (v56 * 33 + string.byte(v55, v57)) % 65521;
        end;
        if v56 == 272 and not v53 then
            warn("Failed to clear client break effect: ", v54);
        end;
    end;
end;
function u1._x70236efbf6182c75(u58, p59) --[[ Line: 184 ]]
    local v60 = tostring(game.GameId);
    local v61 = 46;
    for v62 = 1, #v60 do
        v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
    end;
    local v63 = v61 == 272 and (typeof(p59) ~= "number" or (p59 ~= p59 or (p59 == (1 / 0) or p59 == (-1 / 0)))) and 0 or math.max(p59, 0);
    local v64 = tostring(game.GameId);
    local v65 = 46;
    for v66 = 1, #v64 do
        v65 = (v65 * 33 + string.byte(v64, v66)) % 65521;
    end;
    if v65 == 272 and v63 <= 0 then
        u58:_xa6fc29314bdec4f8(false);
        return false;
    end;
    u58:_xa6fc29314bdec4f8(true);
    u58._xcd2d5f129d825c00 = u58._xcd2d5f129d825c00 + 1;
    u58._x730775c5207957d3.break_duration = v63;
    u58._x730775c5207957d3.initial_duration = v63;
    u58._x730775c5207957d3.break_end_time = os.clock() + v63;
    u58._x730775c5207957d3.is_breaking = true;
    local l___xcd2d5f129d825c00__20 = u58._xcd2d5f129d825c00;
    task.delay(v63 + 0.1, function() --[[ Line: 199 ]]
        -- upvalues: u58 (copy), l___xcd2d5f129d825c00__20 (copy)
        local v67 = tostring(game.GameId);
        local v68 = 46;
        for v69 = 1, #v67 do
            v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
        end;
        if v68 == 272 and u58._xcd2d5f129d825c00 == l___xcd2d5f129d825c00__20 then
            u58:_xa6fc29314bdec4f8(false);
        end;
    end);
    return true;
end;
function u1._x0b64af9146930e4b(p70, p71) --[[ Line: 208 ]]
    return p70._xc4a7fd8f25937fc7[p71];
end;
function u1._x99c2a19f9a3f5eff(_, p72) --[[ Line: 212 ]]
    -- upvalues: l__LocalPlayer__12 (copy)
    local v73 = game.Players.LocalPlayer:WaitForChild("ReadOnly"):FindFirstChild(p72);
    local v74 = tostring(game.GameId);
    local v75 = 46;
    for v76 = 1, #v74 do
        v75 = (v75 * 33 + string.byte(v74, v76)) % 65521;
    end;
    if v75 == 272 and not v73 then
        local v77 = game:GetService("ReplicatedStorage").ReadOnly.Players:FindFirstChild(l__LocalPlayer__12.UserId);
        local v78 = tostring(game.GameId);
        local v79 = 46;
        for v80 = 1, #v78 do
            v79 = (v79 * 33 + string.byte(v78, v80)) % 65521;
        end;
        if v79 == 272 and v77 then
            v73 = v77:FindFirstChild(p72);
        end;
    end;
    return v73;
end;
function u1._x5470da2f9f3949e6(p81, p82) --[[ Line: 227 ]]
    -- upvalues: l__Classes__9 (copy)
    p81._x7f9c9d94108df00a = p82;
    local l__aimpunch_args__21 = p82.aimpunch_args;
    local v83 = tostring(game.GameId);
    local v84 = 46;
    for v85 = 1, #v83 do
        v84 = (v84 * 33 + string.byte(v83, v85)) % 65521;
    end;
    if v84 == 272 and (l__aimpunch_args__21 and l__Classes__9._x2b1f81c73714b323) then
        l__Classes__9._x2b1f81c73714b323:_x06defdf12fcc7217(unpack(l__aimpunch_args__21));
    end;
end;
function u1._x58401f12a940ee59(p86, p87, u88) --[[ Line: 235 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy), l__LocalPlayer__12 (copy), l__Promise__6 (copy), l__InternalSymbols__11 (copy)
    local v89 = tostring(game.GameId);
    local v90 = 46;
    for v91 = 1, #v89 do
        v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
    end;
    if v90 == 272 and not l__Context__10.is_gameplay_mode then
        p86._x885b2725a1933f2e = "alive";
    else
        p86._xc2d2438cd4ae1da5:Clean();
        p86._x885b2725a1933f2e = "alive";
        p86._x3645bb400b362a9e = false;
        p86:_xa6fc29314bdec4f8(true);
        l__Classes__9._x2b1f81c73714b323._xd74d8ca88b35620d = nil;
        l__Classes__9._x2b1f81c73714b323.attacker_model = nil;
        local v92 = tostring(game.GameId);
        local v93 = 46;
        for v94 = 1, #v92 do
            v93 = (v93 * 33 + string.byte(v92, v94)) % 65521;
        end;
        if v93 == 272 and (not p87 and l__Classes__9.MenuManager.in_menu) then
            l__Classes__9._x3103fdab012bc1c0:_x26bc3c27878259a9();
            local v95 = l__LocalPlayer__12.PlayerGui:FindFirstChild("GameplayUI");
            local v96 = tostring(game.GameId);
            local v97 = 46;
            for v98 = 1, #v96 do
                v97 = (v97 * 33 + string.byte(v96, v98)) % 65521;
            end;
            if v97 == 272 and v95 then
                v95.Enabled = false;
            end;
            l__Classes__9._xaffa998c3a825e19._x0e0d0acaaa1322c0 = false;
            l__Classes__9._x2b1f81c73714b323._x7324f78af14e3910 = true;
            l__Classes__9._x20ced43136f3a8e4:_xcc5f292712de0f3a(false);
        else
            l__Classes__9._x3103fdab012bc1c0._x0b50f415660624d5.Enabled = true;
            l__Classes__9._x7c4d08c7bcf3460a:_x18bcd3394764cd9a();
            l__Classes__9.MenuManager.in_menu = false;
            l__Classes__9.MenuManager:close();
            l__Classes__9._xef0ffbcc2c92f7b4:_xc3170e4806c48d20();
            task.spawn(function() --[[ Line: 266 ]]
                -- upvalues: l__LocalPlayer__12 (ref)
                local v99 = l__LocalPlayer__12.Character or l__LocalPlayer__12.CharacterAdded:Wait();
                game.Workspace.CurrentCamera.CameraSubject = v99:WaitForChild("Humanoid");
            end);
            l__Classes__9._x3103fdab012bc1c0:_x26bc3c27878259a9();
            l__Promise__6.defer(function() --[[ Line: 272 ]]
                -- upvalues: l__Classes__9 (ref), u88 (copy)
                l__Classes__9._x3103fdab012bc1c0:_x8529e8f2c155b40b();
                local v100 = tostring(game.GameId);
                local v101 = 46;
                for v102 = 1, #v100 do
                    v101 = (v101 * 33 + string.byte(v100, v102)) % 65521;
                end;
                if v101 == 272 and (u88 and u88.deathcard_data) then
                    task.spawn(function() --[[ Line: 276 ]]
                        -- upvalues: l__Classes__9 (ref), u88 (ref)
                        l__Classes__9._x3103fdab012bc1c0:_xf264c3a6ce7d5162(u88.deathcard_data);
                    end);
                end;
                local v103 = l__Classes__9._x337410ce64f03086:_x3efa7d2770a422ee("gun");
                local v104 = tostring(game.GameId);
                local v105 = 46;
                for v106 = 1, #v104 do
                    v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
                end;
                if v105 == 272 and (v103 and v103._xc694ad81e85c384a) then
                    l__Classes__9._x3103fdab012bc1c0:_xea7f02709f56fb9f(v103._xc694ad81e85c384a);
                end;
            end);
            task.spawn(function() --[[ Line: 287 ]]
                -- upvalues: l__LocalPlayer__12 (ref), l__Classes__9 (ref)
                local v107 = tostring(game.GameId);
                local v108 = 46;
                for v109 = 1, #v107 do
                    v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
                end;
                if v108 == 272 and l__LocalPlayer__12.Character then
                    l__Classes__9._xef0ffbcc2c92f7b4._x9fa4fd001bd486e8 = l__LocalPlayer__12.Character:WaitForChild("Head").Position;
                    l__Classes__9._xef0ffbcc2c92f7b4._x6f8b06bb5d0138ea = l__LocalPlayer__12.Character:WaitForChild("Head").Position;
                end;
            end);
            l__Promise__6.defer(function() --[[ Line: 294 ]]
                -- upvalues: l__Classes__9 (ref), l__LocalPlayer__12 (ref)
                local v110 = tostring(game.GameId);
                local v111 = 46;
                for v112 = 1, #v110 do
                    v111 = (v111 * 33 + string.byte(v110, v112)) % 65521;
                end;
                if v111 == 272 and l__Classes__9._x337410ce64f03086:_x3efa7d2770a422ee("melee") then
                    l__Classes__9._x337410ce64f03086:_x958385851734f66b("melee");
                end;
                local l__Character__22 = l__LocalPlayer__12.Character;
                if l__Character__22 then
                    l__Character__22 = l__LocalPlayer__12.Character:WaitForChild("Humanoid");
                end;
                workspace.CurrentCamera.CameraSubject = l__Character__22;
            end);
            local v113 = tostring(game.GameId);
            local v114 = 46;
            for v115 = 1, #v113 do
                v114 = (v114 * 33 + string.byte(v113, v115)) % 65521;
            end;
            if v114 == 272 and p87 then
                local v116 = l__InternalSymbols__11.owner("", l__Classes__9._xa96baf85cc071464._x5f340294268fed4e);
                local v117 = tostring(game.GameId);
                local v118 = 46;
                for v119 = 1, #v117 do
                    v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
                end;
                if v118 == 272 and (not l__Classes__9._xa96baf85cc071464._x0b17678890427567 or v116 and v116._x819b626fc6c8368b) then
                    l__Classes__9._x9b074161e70581e8:_xcc5f292712de0f3a("combat");
                end;
                local v120 = tostring(game.GameId);
                local v121 = 46;
                for v122 = 1, #v120 do
                    v121 = (v121 * 33 + string.byte(v120, v122)) % 65521;
                end;
                if v121 == 272 and (u88 and u88.loadout) then
                    local u123 = u88.skin_ids or {};
                    for u124, u125 in u88.loadout do
                        task.defer(function() --[[ Line: 310 ]]
                            -- upvalues: l__Classes__9 (ref), u124 (copy), u125 (copy), u123 (copy)
                            l__Classes__9._x337410ce64f03086:_xdcd0754166a136d8(u124, u125, u123[u124]);
                        end);
                    end;
                end;
            end;
            local v126 = l__LocalPlayer__12.PlayerGui:FindFirstChild("GameplayUI");
            local v127 = tostring(game.GameId);
            local v128 = 46;
            for v129 = 1, #v127 do
                v128 = (v128 * 33 + string.byte(v127, v129)) % 65521;
            end;
            if v128 == 272 and v126 then
                v126.Enabled = true;
            end;
            l__Classes__9._x2b1f81c73714b323._x7324f78af14e3910 = false;
            l__Classes__9._xd2c44c643b0c3fb4:_x7bb8b491a142ab2b();
            l__Classes__9._xd2c44c643b0c3fb4:_x3410b88865eec644("active", true);
            l__Classes__9._xd2c44c643b0c3fb4:_x3410b88865eec644("movement", true);
            l__Classes__9._xaffa998c3a825e19._x0e0d0acaaa1322c0 = true;
        end;
    end;
end;
function u1._xb966dd5e7f5bf1f2(p130, p131) --[[ Line: 327 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy)
    local v132 = tostring(game.GameId);
    local v133 = 46;
    for v134 = 1, #v132 do
        v133 = (v133 * 33 + string.byte(v132, v134)) % 65521;
    end;
    if v133 == 272 and not l__Context__10.is_gameplay_mode then
    else
        p130._x885b2725a1933f2e = "dead";
        l__Classes__9._x02c5f8f89640473a:_xa2c2f0587694a915("DEATH", true);
        l__Classes__9._xd2c44c643b0c3fb4:_x3410b88865eec644("active", false);
        l__Classes__9._xd2c44c643b0c3fb4:_x3410b88865eec644("movement", false);
        l__Classes__9._x9b074161e70581e8:_xcde373a27057623b(-0.3);
        local v135 = l__Classes__9._x7c4d08c7bcf3460a:_xa729e3407dc03d77();
        local v136 = game:GetService("ReplicatedStorage").Assets.UIAssets.DeathCC:Clone();
        v136.Parent = game:GetService("Lighting");
        p130._xc2d2438cd4ae1da5:Add(v136);
        p130._xc2d2438cd4ae1da5:Add(v135);
        l__Classes__9._xef0ffbcc2c92f7b4._xed86f944048d8fdc = Vector3.new(0, -1, 0);
        l__Classes__9._xaffa998c3a825e19._x0e0d0acaaa1322c0 = false;
        local v137 = tostring(game.GameId);
        local v138 = 46;
        for v139 = 1, #v137 do
            v138 = (v138 * 33 + string.byte(v137, v139)) % 65521;
        end;
        local v140;
        if v138 == 272 and (p131 and p131:IsA("Model")) then
            v140 = game:GetService("Players"):GetPlayerFromCharacter(p131);
        else
            v140 = nil;
        end;
        l__Classes__9._x20ced43136f3a8e4:_xcc5f292712de0f3a(false, v140);
        p130._xc2d2438cd4ae1da5:Add(function() --[[ Line: 349 ]]
            -- upvalues: l__Classes__9 (ref)
            l__Classes__9._x20ced43136f3a8e4:cleanUp();
        end);
    end;
end;
function u1._xd52e2a8167582716(u141) --[[ Line: 354 ]]
    -- upvalues: l__Packets__4 (copy), l__UserInputService__2 (copy), l__Context__10 (copy), l__Classes__9 (copy)
    game:GetService("ReplicatedStorage").Assets.RemoteEvents.Reset.Event:Connect(function() --[[ Line: 355 ]]
        -- upvalues: l__Packets__4 (ref)
        l__Packets__4._x95a7dcd2ba19667f:Fire();
    end);
    l__UserInputService__2.InputBegan:Connect(function() --[[ Line: 359 ]]
        -- upvalues: u141 (copy)
        u141:_x66a8dec3fc4a9bdd();
    end);
    l__Packets__4._x7385f04acbd3d15f.OnClientEvent:Connect(function(...) --[[ Line: 363 ]]
        -- upvalues: u141 (copy)
        u141._xc4a7fd8f25937fc7.onHit:Fire(...);
    end);
    l__Packets__4._x4dc83f2504cf2f57.OnClientEvent:Connect(function() --[[ Line: 367 ]]
        -- upvalues: u141 (copy)
        u141:_xb42429132e1dead7();
    end);
    l__Packets__4._x13adfdc69dfdf777.OnClientEvent:Connect(function(p142) --[[ Line: 371 ]]
        -- upvalues: u141 (copy)
        u141:_x5470da2f9f3949e6(p142);
        u141._xc4a7fd8f25937fc7.onDamageTaken:Fire(p142);
    end);
    l__Packets__4._xf83bd5b1e5c00bd6.OnClientEvent:Connect(function(p143) --[[ Line: 376 ]]
        -- upvalues: u141 (copy), l__Context__10 (ref), l__Classes__9 (ref)
        u141:_xb966dd5e7f5bf1f2(p143);
        u141._xc4a7fd8f25937fc7.onDeath:Fire(p143);
        local v144 = tostring(game.GameId);
        local v145 = 46;
        for v146 = 1, #v144 do
            v145 = (v145 * 33 + string.byte(v144, v146)) % 65521;
        end;
        if v145 == 272 and (l__Context__10.is_gameplay_mode and l__Classes__9._xef0ffbcc2c92f7b4) then
            l__Classes__9._xef0ffbcc2c92f7b4._x1ba439069c6b2196 = 3;
            l__Classes__9._xef0ffbcc2c92f7b4._xa65e11f304617618 = 3;
        end;
        u141:_xa6fc29314bdec4f8(true);
    end);
    l__Packets__4._xf0d64c6a69399585.OnClientEvent:Connect(function(p147, p148) --[[ Line: 388 ]]
        -- upvalues: u141 (copy)
        u141:_x58401f12a940ee59(p147, p148);
        u141._xc4a7fd8f25937fc7.onSpawn:Fire(p147, p148);
    end);
    l__Packets__4._x71a4ac7aba517193.OnClientEvent:Connect(function(p149) --[[ Line: 393 ]]
        -- upvalues: u141 (copy), l__Context__10 (ref), l__Classes__9 (ref)
        local v150 = tostring(game.GameId);
        local v151 = 46;
        for v152 = 1, #v150 do
            v151 = (v151 * 33 + string.byte(v150, v152)) % 65521;
        end;
        local v153 = v151 == 272 and (typeof(p149) ~= "number" or (p149 ~= p149 or (p149 == (1 / 0) or p149 == (-1 / 0)))) and 0 or math.max(p149, 0);
        local v154 = tostring(game.GameId);
        local v155 = 46;
        for v156 = 1, #v154 do
            v155 = (v155 * 33 + string.byte(v154, v156)) % 65521;
        end;
        if v155 == 272 and v153 <= 0 then
            u141:_xa6fc29314bdec4f8(u141._x885b2725a1933f2e ~= "alive");
        else
            local v157 = tostring(game.GameId);
            local v158 = 46;
            for v159 = 1, #v157 do
                v158 = (v158 * 33 + string.byte(v157, v159)) % 65521;
            end;
            if v158 == 272 and not l__Context__10.is_gameplay_mode then
            else
                local v160 = tostring(game.GameId);
                local v161 = 46;
                for v162 = 1, #v160 do
                    v161 = (v161 * 33 + string.byte(v160, v162)) % 65521;
                end;
                if v161 == 272 and u141._x885b2725a1933f2e ~= "alive" then
                else
                    local v163 = tostring(game.GameId);
                    local v164 = 46;
                    for v165 = 1, #v163 do
                        v164 = (v164 * 33 + string.byte(v163, v165)) % 65521;
                    end;
                    if v164 == 272 and not u141:_x70236efbf6182c75(v153) then
                    else
                        l__Classes__9._xef0ffbcc2c92f7b4._x1ba439069c6b2196 = 0;
                        l__Classes__9._xef0ffbcc2c92f7b4._xa65e11f304617618 = 0;
                        local v166, v167 = pcall(l__Classes__9._x7c4d08c7bcf3460a._x4bf8be97f08f8659, l__Classes__9._x7c4d08c7bcf3460a, v153);
                        local v168 = tostring(game.GameId);
                        local v169 = 46;
                        for v170 = 1, #v168 do
                            v169 = (v169 * 33 + string.byte(v168, v170)) % 65521;
                        end;
                        if v169 == 272 and (v166 and typeof(v167) == "function") then
                            u141._xaa9a3c6bb43edabe = v167;
                        else
                            warn("Failed to start client break effect: ", v167);
                        end;
                        u141._xc4a7fd8f25937fc7.onBreaking:Fire(v153);
                    end;
                end;
            end;
        end;
    end);
end;
return u1;
