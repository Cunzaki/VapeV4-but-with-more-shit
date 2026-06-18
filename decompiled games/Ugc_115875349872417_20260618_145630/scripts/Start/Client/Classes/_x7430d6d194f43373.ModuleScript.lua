-- Decompiled from: Start.Client.Classes._x7430d6d194f43373
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
function u1._x90d4581ac99dd483() --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l__Signal__5 (copy), l__Trove__7 (copy)
    local v2 = setmetatable({}, u1);
    v2._x3668b6edfe3dbbd4 = "inactive";
    v2._xc93ed121260ef808 = game.Players.LocalPlayer:WaitForChild("ReadOnly");
    v2._x5a2478a74e4a6085 = nil;
    v2._x4c73cbbfebe5e189 = {
        onDeath = l__Signal__5.new(),
        onSpawn = l__Signal__5.new(),
        onBreaking = l__Signal__5.new(),
        onDamageTaken = l__Signal__5.new(),
        onHit = l__Signal__5.new(),
        pingChanged = l__Signal__5.new()
    };
    v2._x7176ea97549fd9b6 = {
        is_breaking = false,
        break_duration = 0,
        initial_duration = 0,
        break_end_time = 0
    };
    v2._xa2dfe1fe1946b587 = 0;
    v2._xa4c494d027f65483 = nil;
    v2._xfc59a57f1de8b1fb = l__Trove__7.new();
    v2._x4cd4bc083f273ad5 = 0;
    v2._x32d41ff6f4037be9 = 0;
    v2._x48da6bf6d188aa71 = false;
    v2._xd43b7c3d1751527d = false;
    return v2;
end;
function u1._x6e37ecbe684f2f2f(p3) --[[ Line: 67 ]]
    -- upvalues: l__Context__10 (copy), l__Packets__4 (copy)
    if l__Context__10.is_ffa_mode then
        if p3._x3668b6edfe3dbbd4 == "alive" and not p3._xd43b7c3d1751527d then
            p3._xd43b7c3d1751527d = true;
            l__Packets__4._xceeb9bb38d6dafa5:Fire();
        end;
    end;
end;
function u1._xc3928e9432f37b2e(p4) --[[ Line: 80 ]]
    return p4._x4cd4bc083f273ad5;
end;
function u1._xe53615d96cf36a6b(u5) --[[ Line: 84 ]]
    -- upvalues: l__Packets__4 (copy), l__RunService__1 (copy)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    u5:_x5cd04277933546af();
    local v6 = u5:_x57c044514acd3a73("level");
    u5._x32d41ff6f4037be9 = v6.Value;
    v6.Changed:Connect(function(p7) --[[ Line: 95 ]]
        -- upvalues: u5 (copy)
        u5._x32d41ff6f4037be9 = p7;
    end;
    l__Packets__4.unreliablePackets._x5ae310e9248fdbec.OnClientEvent:Connect(function(p8) --[[ Line: 99 ]]
        -- upvalues: u5 (copy)
        u5._x4cd4bc083f273ad5 = p8;
        u5:_x685b03ceb3f7e330("pingChanged"):Fire(p8);
    end;
    l__RunService__1.RenderStepped:Connect(function(p9) --[[ Line: 104 ]]
        -- upvalues: u5 (copy)
        u5:_x25588e7cc9e0f609(p9);
    end;
end;
function u1._x25588e7cc9e0f609(p10, p11) --[[ Line: 109 ]]
    -- upvalues: l__Classes__9 (copy), l__LocalPlayer__12 (copy), l__UserInputService__2 (copy)
    local l___x7176ea97549fd9b6__13 = p10._x7176ea97549fd9b6;
    local l__break_end_time__14 = l___x7176ea97549fd9b6__13.break_end_time;
    local v12 = (typeof(l__break_end_time__14) ~= "number" or (l__break_end_time__14 ~= l__break_end_time__14 or (l__break_end_time__14 == (1 / 0) or l__break_end_time__14 == (-1 / 0)))) and 0 or math.max(l__break_end_time__14, 0);
    local l__break_duration__15 = l___x7176ea97549fd9b6__13.break_duration;
    local v13 = (typeof(l__break_duration__15) ~= "number" or (l__break_duration__15 ~= l__break_duration__15 or (l__break_duration__15 == (1 / 0) or l__break_duration__15 == (-1 / 0)))) and 0 or math.max(l__break_duration__15, 0);
    if v12 > 0 then
        local v14 = v12 - os.clock();
        v13 = math.max(v14, 0);
    elseif v13 > 0 then
        v13 = math.max(v13 - p11, 0);
    end;
    l___x7176ea97549fd9b6__13.break_duration = v13;
    if v13 <= 0 then
        if l___x7176ea97549fd9b6__13.is_breaking or v12 > 0 then
            p10:_xc83f153c1a9518e7(false);
        else
            l___x7176ea97549fd9b6__13.is_breaking = false;
            l___x7176ea97549fd9b6__13.break_duration = 0;
            l___x7176ea97549fd9b6__13.break_end_time = 0;
        end;
    else
        l___x7176ea97549fd9b6__13.is_breaking = true;
    end;
    local l___xb880259db2a1f0f1__16 = l__Classes__9._xb880259db2a1f0f1;
    local l___xd00ac57201023755__17 = l__Classes__9._xd00ac57201023755;
    local v15 = p10._x48da6bf6d188aa71 or l___xb880259db2a1f0f1__16 and l___xb880259db2a1f0f1__16._x74c655fada9e6996 or (l___xd00ac57201023755__17 and #l___xd00ac57201023755__17._x5706f358225e50c1 >= 1 and true or false);
    local l__FreeMouse__18 = l__LocalPlayer__12.PlayerGui.FreeMouse;
    if v15 then
        l__UserInputService__2.MouseIconEnabled = true;
    end;
    l__FreeMouse__18.Enabled = v15;
    l__FreeMouse__18.Modal.Visible = v15;
end;
function u1._xbbd21c88eb4b9b6c(p16, p17) --[[ Line: 148 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy)
    if p17 or l__Context__10.is_gameplay_mode then
        p16._x3668b6edfe3dbbd4 = "suspended";
        l__Classes__9._x3e046bec2684f59c:_xb8c1a4d190637d84();
        l__Classes__9._x910f31e87b3c7281._x0dabd010e1f00f2e = false;
        l__Classes__9._x32ae459de0772e82._x5b34a8c32cf04968 = true;
    end;
end;
function u1._xc83f153c1a9518e7(p18, p19) --[[ Line: 157 ]]
    p18._xa2dfe1fe1946b587 = p18._xa2dfe1fe1946b587 + 1;
    p18._x7176ea97549fd9b6.break_duration = 0;
    p18._x7176ea97549fd9b6.initial_duration = 0;
    p18._x7176ea97549fd9b6.break_end_time = 0;
    p18._x7176ea97549fd9b6.is_breaking = false;
    local l___xa4c494d027f65483__19 = p18._xa4c494d027f65483;
    p18._xa4c494d027f65483 = nil;
    if l___xa4c494d027f65483__19 then
        local v20, v21 = pcall(l___xa4c494d027f65483__19, p19 == true);
        if not v20 then
            warn("Failed to clear client break effect: ", v21);
        end;
    end;
end;
function u1._x34dd7070d2ff927b(u22, p23) --[[ Line: 175 ]]
    local v24 = (typeof(p23) ~= "number" or (p23 ~= p23 or (p23 == (1 / 0) or p23 == (-1 / 0)))) and 0 or math.max(p23, 0);
    if v24 <= 0 then
        u22:_xc83f153c1a9518e7(false);
        return false;
    end;
    u22:_xc83f153c1a9518e7(true);
    u22._xa2dfe1fe1946b587 = u22._xa2dfe1fe1946b587 + 1;
    u22._x7176ea97549fd9b6.break_duration = v24;
    u22._x7176ea97549fd9b6.initial_duration = v24;
    u22._x7176ea97549fd9b6.break_end_time = os.clock() + v24;
    u22._x7176ea97549fd9b6.is_breaking = true;
    local l___xa2dfe1fe1946b587__20 = u22._xa2dfe1fe1946b587;
    task.delay(v24 + 0.1, function() --[[ Line: 190 ]]
        -- upvalues: u22 (copy), l___xa2dfe1fe1946b587__20 (copy)
        if u22._xa2dfe1fe1946b587 == l___xa2dfe1fe1946b587__20 then
            u22:_xc83f153c1a9518e7(false);
        end;
    end;
    return true;
end;
function u1._x685b03ceb3f7e330(p25, p26) --[[ Line: 199 ]]
    return p25._x4c73cbbfebe5e189[p26];
end;
function u1._x57c044514acd3a73(_, p27) --[[ Line: 203 ]]
    -- upvalues: l__LocalPlayer__12 (copy)
    local v28 = game.Players.LocalPlayer:WaitForChild("ReadOnly"):FindFirstChild(p27);
    if not v28 then
        local v29 = game:GetService("ReplicatedStorage").ReadOnly.Players:FindFirstChild(l__LocalPlayer__12.UserId);
        if v29 then
            v28 = v29:FindFirstChild(p27);
        end;
    end;
    return v28;
end;
function u1._x55bdf5eccc2aefaf(p30, p31) --[[ Line: 218 ]]
    -- upvalues: l__Classes__9 (copy)
    p30._x5a2478a74e4a6085 = p31;
    local l__aimpunch_args__21 = p31.aimpunch_args;
    if l__aimpunch_args__21 and l__Classes__9._x32ae459de0772e82 then
        l__Classes__9._x32ae459de0772e82:_x8ee1ac854964ea1a(unpack(l__aimpunch_args__21));
    end;
end;
function u1._xadf54f5060bf3a4a(p32, p33, u34) --[[ Line: 226 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy), l__LocalPlayer__12 (copy), l__Promise__6 (copy), l__InternalSymbols__11 (copy)
    if l__Context__10.is_gameplay_mode then
        p32._xfc59a57f1de8b1fb:Clean();
        p32._x3668b6edfe3dbbd4 = "alive";
        p32._xd43b7c3d1751527d = false;
        p32:_xc83f153c1a9518e7(true);
        l__Classes__9._x32ae459de0772e82._x225082f3a917962c = nil;
        l__Classes__9._x32ae459de0772e82.attacker_model = nil;
        if p33 or not l__Classes__9.MenuManager.in_menu then
            l__Classes__9._xafc4950d7b094088._xef1fb561476b0a5b.Enabled = true;
            l__Classes__9._x255cd8d76027f039:_x67f094c26bedf245();
            l__Classes__9.MenuManager.in_menu = false;
            l__Classes__9.MenuManager:close();
            l__Classes__9._x7058397dabccd000:_x1c697eac9a419071();
            task.spawn(function() --[[ Line: 257 ]]
                -- upvalues: l__LocalPlayer__12 (ref)
                local v35 = l__LocalPlayer__12.Character or l__LocalPlayer__12.CharacterAdded:Wait();
                game.Workspace.CurrentCamera.CameraSubject = v35:WaitForChild("Humanoid");
            end;
            l__Classes__9._xafc4950d7b094088:_x2d147abfc340ba12();
            l__Promise__6.defer(function() --[[ Line: 263 ]]
                -- upvalues: l__Classes__9 (ref), u34 (copy)
                l__Classes__9._xafc4950d7b094088:_xcb7fcd214aed2202();
                if u34 and u34.deathcard_data then
                    task.spawn(function() --[[ Line: 267 ]]
                        -- upvalues: l__Classes__9 (ref), u34 (ref)
                        l__Classes__9._xafc4950d7b094088:_x0c03f29ad12df05e(u34.deathcard_data);
                    end;
                end;
                local v36 = l__Classes__9._xd1706540247308ea:_x372c01be8a28bc70("gun");
                if v36 and v36._xcd31646afa821cd4 then
                    l__Classes__9._xafc4950d7b094088:_x19a8c13b7d43296b(v36._xcd31646afa821cd4);
                end;
            end;
            task.spawn(function() --[[ Line: 278 ]]
                -- upvalues: l__LocalPlayer__12 (ref), l__Classes__9 (ref)
                if l__LocalPlayer__12.Character then
                    l__Classes__9._x7058397dabccd000._x945ab195596e2183 = l__LocalPlayer__12.Character:WaitForChild("Head").Position;
                    l__Classes__9._x7058397dabccd000._x0e71d3ad266246bf = l__LocalPlayer__12.Character:WaitForChild("Head").Position;
                end;
            end;
            l__Promise__6.defer(function() --[[ Line: 285 ]]
                -- upvalues: l__Classes__9 (ref), l__LocalPlayer__12 (ref)
                if l__Classes__9._xd1706540247308ea:_x372c01be8a28bc70("melee") then
                    l__Classes__9._xd1706540247308ea:_xabcc58e6f4374b9e("melee");
                end;
                local l__Character__22 = l__LocalPlayer__12.Character;
                if l__Character__22 then
                    l__Character__22 = l__LocalPlayer__12.Character:WaitForChild("Humanoid");
                end;
                workspace.CurrentCamera.CameraSubject = l__Character__22;
            end;
            if p33 then
                local v37 = l__InternalSymbols__11.owner("", l__Classes__9._x545ff694ddcc66c8._x54ffdfaa6954a8fc);
                if not l__Classes__9._x545ff694ddcc66c8._x52b3d9fd81166d6c or v37 and v37._x995dd18e69a73646 then
                    l__Classes__9._xfaee1d1d64cdfe93:_x8fcdafeb8ad3312d("combat");
                end;
                if u34 and u34.loadout then
                    local u38 = u34.skin_ids or {};
                    for u39, u40 in u34.loadout do
                        task.defer(function() --[[ Line: 301 ]]
                            -- upvalues: l__Classes__9 (ref), u39 (copy), u40 (copy), u38 (copy)
                            l__Classes__9._xd1706540247308ea:_xc7194a90fb0dcb84(u39, u40, u38[u39]);
                        end;
                    end;
                end;
            end;
            local v41 = l__LocalPlayer__12.PlayerGui:FindFirstChild("GameplayUI");
            if v41 then
                v41.Enabled = true;
            end;
            l__Classes__9._x32ae459de0772e82._x5b34a8c32cf04968 = false;
            l__Classes__9._x3e046bec2684f59c:_xb8c1a4d190637d84();
            l__Classes__9._x3e046bec2684f59c:_x4c9977b827e9b5fa("active", true);
            l__Classes__9._x3e046bec2684f59c:_x4c9977b827e9b5fa("movement", true);
            l__Classes__9._x910f31e87b3c7281._x0dabd010e1f00f2e = true;
        else
            l__Classes__9._xafc4950d7b094088:_x2d147abfc340ba12();
            local v42 = l__LocalPlayer__12.PlayerGui:FindFirstChild("GameplayUI");
            if v42 then
                v42.Enabled = false;
            end;
            l__Classes__9._x910f31e87b3c7281._x0dabd010e1f00f2e = false;
            l__Classes__9._x32ae459de0772e82._x5b34a8c32cf04968 = true;
            l__Classes__9._x199aee2e6ba696d1:_x8fcdafeb8ad3312d(false);
        end;
    else
        p32._x3668b6edfe3dbbd4 = "alive";
    end;
end;
function u1._xcaea3b804bfd5ffd(p43, p44) --[[ Line: 318 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy)
    if l__Context__10.is_gameplay_mode then
        p43._x3668b6edfe3dbbd4 = "dead";
        l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("DEATH", true);
        l__Classes__9._x3e046bec2684f59c:_x4c9977b827e9b5fa("active", false);
        l__Classes__9._x3e046bec2684f59c:_x4c9977b827e9b5fa("movement", false);
        l__Classes__9._xfaee1d1d64cdfe93:_x3f8b63442918abf2(-0.3);
        local v45 = l__Classes__9._x255cd8d76027f039:_x035085183a54275c();
        local v46 = game:GetService("ReplicatedStorage").Assets.UIAssets.DeathCC:Clone();
        v46.Parent = game:GetService("Lighting");
        p43._xfc59a57f1de8b1fb:Add(v46);
        p43._xfc59a57f1de8b1fb:Add(v45);
        l__Classes__9._x7058397dabccd000._x1d287c838240a901 = Vector3.new(0, -1, 0);
        l__Classes__9._x910f31e87b3c7281._x0dabd010e1f00f2e = false;
        local v47;
        if p44 and p44:IsA("Model") then
            v47 = game:GetService("Players"):GetPlayerFromCharacter(p44);
        else
            v47 = nil;
        end;
        l__Classes__9._x199aee2e6ba696d1:_x8fcdafeb8ad3312d(false, v47);
        p43._xfc59a57f1de8b1fb:Add(function() --[[ Line: 340 ]]
            -- upvalues: l__Classes__9 (ref)
            l__Classes__9._x199aee2e6ba696d1:cleanUp();
        end;
    end;
end;
function u1._x5cd04277933546af(u48) --[[ Line: 345 ]]
    -- upvalues: l__Packets__4 (copy), l__UserInputService__2 (copy), l__Context__10 (copy), l__Classes__9 (copy)
    game:GetService("ReplicatedStorage").Assets.RemoteEvents.Reset.Event:Connect(function() --[[ Line: 346 ]]
        -- upvalues: l__Packets__4 (ref)
        l__Packets__4._xf02780962360a20d:Fire();
    end;
    l__UserInputService__2.InputBegan:Connect(function() --[[ Line: 350 ]]
        -- upvalues: u48 (copy)
        u48:_x6e37ecbe684f2f2f();
    end;
    l__Packets__4._x506bc57f88c7fb18.OnClientEvent:Connect(function(...) --[[ Line: 354 ]]
        -- upvalues: u48 (copy)
        u48._x4c73cbbfebe5e189.onHit:Fire(...);
    end;
    l__Packets__4._xf4f412e8abf108a3.OnClientEvent:Connect(function() --[[ Line: 358 ]]
        -- upvalues: u48 (copy)
        u48:_xbbd21c88eb4b9b6c();
    end;
    l__Packets__4._x37a4b30a0b3cb2b9.OnClientEvent:Connect(function(p49) --[[ Line: 362 ]]
        -- upvalues: u48 (copy)
        u48:_x55bdf5eccc2aefaf(p49);
        u48._x4c73cbbfebe5e189.onDamageTaken:Fire(p49);
    end;
    l__Packets__4._x4245eccb88c28d52.OnClientEvent:Connect(function(p50) --[[ Line: 367 ]]
        -- upvalues: u48 (copy), l__Context__10 (ref), l__Classes__9 (ref)
        u48:_xcaea3b804bfd5ffd(p50);
        u48._x4c73cbbfebe5e189.onDeath:Fire(p50);
        if l__Context__10.is_gameplay_mode and l__Classes__9._x7058397dabccd000 then
            l__Classes__9._x7058397dabccd000._xa2a90f9baae72ac5 = 3;
            l__Classes__9._x7058397dabccd000._x95981622da89ab0b = 3;
        end;
        u48:_xc83f153c1a9518e7(true);
    end;
    l__Packets__4._x531476857d90e575.OnClientEvent:Connect(function(p51, p52) --[[ Line: 379 ]]
        -- upvalues: u48 (copy)
        u48:_xadf54f5060bf3a4a(p51, p52);
        u48._x4c73cbbfebe5e189.onSpawn:Fire(p51, p52);
    end;
    l__Packets__4._xc9c4207c75682687.OnClientEvent:Connect(function(p53) --[[ Line: 384 ]]
        -- upvalues: u48 (copy), l__Context__10 (ref), l__Classes__9 (ref)
        local v54 = (typeof(p53) ~= "number" or (p53 ~= p53 or (p53 == (1 / 0) or p53 == (-1 / 0)))) and 0 or math.max(p53, 0);
        if v54 <= 0 then
            u48:_xc83f153c1a9518e7(u48._x3668b6edfe3dbbd4 ~= "alive");
        elseif l__Context__10.is_gameplay_mode then
            if u48._x3668b6edfe3dbbd4 == "alive" then
                if u48:_x34dd7070d2ff927b(v54) then
                    l__Classes__9._x7058397dabccd000._xa2a90f9baae72ac5 = 0;
                    l__Classes__9._x7058397dabccd000._x95981622da89ab0b = 0;
                    local v55, v56 = pcall(l__Classes__9._x255cd8d76027f039._xb31d1abafc606df8, l__Classes__9._x255cd8d76027f039, v54);
                    if v55 and typeof(v56) == "function" then
                        u48._xa4c494d027f65483 = v56;
                    else
                        warn("Failed to start client break effect: ", v56);
                    end;
                    u48._x4c73cbbfebe5e189.onBreaking:Fire(v54);
                end;
            end;
        end;
    end;
end;
return u1;
