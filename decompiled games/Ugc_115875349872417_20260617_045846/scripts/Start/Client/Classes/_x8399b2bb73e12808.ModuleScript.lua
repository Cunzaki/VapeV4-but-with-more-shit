-- Decompiled from: Start.Client.Classes._x8399b2bb73e12808
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
local l___x7749231778538ccb__11 = require(script.Parent.Parent._x7749231778538ccb);
local l__LocalPlayer__12 = game.Players.LocalPlayer;
function u1._x83ed94bfb82a8c9f() --[[ Line: 39 ]]
    -- upvalues: u1 (copy), l__Signal__5 (copy), l__Trove__7 (copy)
    local v2 = setmetatable({}, u1);
    v2._x69155c6c2c2143d0 = "inactive";
    v2._x5072ab1387b6a719 = game.Players.LocalPlayer:WaitForChild("ReadOnly");
    v2._x2f6db62464cabe71 = nil;
    v2._xfa3d4dc00b28ebe7 = {
        onDeath = l__Signal__5.new(),
        onSpawn = l__Signal__5.new(),
        onBreaking = l__Signal__5.new(),
        onDamageTaken = l__Signal__5.new(),
        onHit = l__Signal__5.new(),
        pingChanged = l__Signal__5.new()
    };
    v2._x1609eb07758d3751 = {
        is_breaking = false,
        break_duration = 0,
        initial_duration = 0,
        break_end_time = 0
    };
    v2._xb0e1fd1658a7eb7a = 0;
    v2._xd587be529cdf414d = nil;
    v2._x5128018f5f9eac94 = l__Trove__7.new();
    v2._x960604a1a4049caa = 0;
    v2._x04513e3b388a13df = 0;
    v2._xd201386e6033df53 = false;
    v2._x76ef3ddea3571f37 = false;
    return v2;
end;
function u1._x44cc42f70c546f76(p3) --[[ Line: 76 ]]
    -- upvalues: l__Context__10 (copy), l__Packets__4 (copy)
    if l__Context__10.is_ffa_mode then
        if p3._x69155c6c2c2143d0 == "alive" and not p3._x76ef3ddea3571f37 then
            p3._x76ef3ddea3571f37 = true;
            l__Packets__4._xd62c578b7c77d170:Fire();
        end;
    end;
end;
function u1._xd963cc717e453825(p4) --[[ Line: 89 ]]
    return p4._x960604a1a4049caa;
end;
function u1._x44bcd6af41218f92(u5) --[[ Line: 93 ]]
    -- upvalues: l__Packets__4 (copy), l__RunService__1 (copy)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false);
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    u5:_x6a5751bfe463daa4();
    local v6 = u5:_xe7f02e22353709c3("level");
    u5._x04513e3b388a13df = v6.Value;
    v6.Changed:Connect(function(p7) --[[ Line: 104 ]]
        -- upvalues: u5 (copy)
        u5._x04513e3b388a13df = p7;
    end);
    l__Packets__4.unreliablePackets._xb881b1d13c8068a4.OnClientEvent:Connect(function(p8) --[[ Line: 108 ]]
        -- upvalues: u5 (copy)
        u5._x960604a1a4049caa = p8;
        u5:_x9ccd957f12430c82("pingChanged"):Fire(p8);
    end);
    l__RunService__1.RenderStepped:Connect(function(p9) --[[ Line: 113 ]]
        -- upvalues: u5 (copy)
        u5:_xd30c575a2a387fde(p9);
    end);
end;
function u1._xd30c575a2a387fde(p10, p11) --[[ Line: 118 ]]
    -- upvalues: l__Classes__9 (copy), l__LocalPlayer__12 (copy), l__UserInputService__2 (copy)
    local l___x1609eb07758d3751__13 = p10._x1609eb07758d3751;
    local l__break_end_time__14 = l___x1609eb07758d3751__13.break_end_time;
    local v12 = (typeof(l__break_end_time__14) ~= "number" or (l__break_end_time__14 ~= l__break_end_time__14 or (l__break_end_time__14 == (1 / 0) or l__break_end_time__14 == (-1 / 0)))) and 0 or math.max(l__break_end_time__14, 0);
    local l__break_duration__15 = l___x1609eb07758d3751__13.break_duration;
    local v13 = (typeof(l__break_duration__15) ~= "number" or (l__break_duration__15 ~= l__break_duration__15 or (l__break_duration__15 == (1 / 0) or l__break_duration__15 == (-1 / 0)))) and 0 or math.max(l__break_duration__15, 0);
    if v12 > 0 then
        local v14 = v12 - os.clock();
        v13 = math.max(v14, 0);
    elseif v13 > 0 then
        v13 = math.max(v13 - p11, 0);
    end;
    l___x1609eb07758d3751__13.break_duration = v13;
    if v13 <= 0 then
        if l___x1609eb07758d3751__13.is_breaking or v12 > 0 then
            p10:_xe6f7aebd0a9a7b0a(false);
        else
            l___x1609eb07758d3751__13.is_breaking = false;
            l___x1609eb07758d3751__13.break_duration = 0;
            l___x1609eb07758d3751__13.break_end_time = 0;
        end;
    else
        l___x1609eb07758d3751__13.is_breaking = true;
    end;
    local l___x3b55708f7532e346__16 = l__Classes__9._x3b55708f7532e346;
    local l___xe4b708070c7cd741__17 = l__Classes__9._xe4b708070c7cd741;
    local v15 = p10._xd201386e6033df53 or l___x3b55708f7532e346__16 and l___x3b55708f7532e346__16._xf152cbc8a1fd227f or (l___xe4b708070c7cd741__17 and #l___xe4b708070c7cd741__17._x78b57187de62bd29 >= 1 and true or false);
    local l__FreeMouse__18 = l__LocalPlayer__12.PlayerGui.FreeMouse;
    if v15 then
        l__UserInputService__2.MouseIconEnabled = true;
    end;
    l__FreeMouse__18.Enabled = v15;
    l__FreeMouse__18.Modal.Visible = v15;
end;
function u1._xfe8f1e78d32e7ce0(p16, p17) --[[ Line: 157 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy)
    if p17 or l__Context__10.is_gameplay_mode then
        p16._x69155c6c2c2143d0 = "suspended";
        l__Classes__9._xf1ad98d2d70b7408:_xc3a3137d642c21e6();
        l__Classes__9._xe0e88f94014b801e._xa3fe4f9696ee59ce = false;
        l__Classes__9._xdca80115d2839102._x711166f3dabb680d = true;
    end;
end;
function u1._xe6f7aebd0a9a7b0a(p18, p19) --[[ Line: 166 ]]
    p18._xb0e1fd1658a7eb7a = p18._xb0e1fd1658a7eb7a + 1;
    p18._x1609eb07758d3751.break_duration = 0;
    p18._x1609eb07758d3751.initial_duration = 0;
    p18._x1609eb07758d3751.break_end_time = 0;
    p18._x1609eb07758d3751.is_breaking = false;
    local l___xd587be529cdf414d__19 = p18._xd587be529cdf414d;
    p18._xd587be529cdf414d = nil;
    if l___xd587be529cdf414d__19 then
        local v20, v21 = pcall(l___xd587be529cdf414d__19, p19 == true);
        if not v20 then
            warn("Failed to clear client break effect: ", v21);
        end;
    end;
end;
function u1._x347d856633de5782(u22, p23) --[[ Line: 184 ]]
    local v24 = (typeof(p23) ~= "number" or (p23 ~= p23 or (p23 == (1 / 0) or p23 == (-1 / 0)))) and 0 or math.max(p23, 0);
    if v24 <= 0 then
        u22:_xe6f7aebd0a9a7b0a(false);
        return false;
    end;
    u22:_xe6f7aebd0a9a7b0a(true);
    u22._xb0e1fd1658a7eb7a = u22._xb0e1fd1658a7eb7a + 1;
    u22._x1609eb07758d3751.break_duration = v24;
    u22._x1609eb07758d3751.initial_duration = v24;
    u22._x1609eb07758d3751.break_end_time = os.clock() + v24;
    u22._x1609eb07758d3751.is_breaking = true;
    local l___xb0e1fd1658a7eb7a__20 = u22._xb0e1fd1658a7eb7a;
    task.delay(v24 + 0.1, function() --[[ Line: 199 ]]
        -- upvalues: u22 (copy), l___xb0e1fd1658a7eb7a__20 (copy)
        if u22._xb0e1fd1658a7eb7a == l___xb0e1fd1658a7eb7a__20 then
            u22:_xe6f7aebd0a9a7b0a(false);
        end;
    end);
    return true;
end;
function u1._x9ccd957f12430c82(p25, p26) --[[ Line: 208 ]]
    return p25._xfa3d4dc00b28ebe7[p26];
end;
function u1._xe7f02e22353709c3(_, p27) --[[ Line: 212 ]]
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
function u1._x702331960f18c4d1(p30, p31) --[[ Line: 227 ]]
    -- upvalues: l__Classes__9 (copy)
    p30._x2f6db62464cabe71 = p31;
    local l__aimpunch_args__21 = p31.aimpunch_args;
    if l__aimpunch_args__21 and l__Classes__9._xdca80115d2839102 then
        l__Classes__9._xdca80115d2839102:_x37e1f658b04f8d69(unpack(l__aimpunch_args__21));
    end;
end;
function u1._x7eb95db5e4041d3a(p32, p33, u34) --[[ Line: 235 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy), l__LocalPlayer__12 (copy), l__Promise__6 (copy), l___x7749231778538ccb__11 (copy)
    if l__Context__10.is_gameplay_mode then
        p32._x5128018f5f9eac94:Clean();
        p32._x69155c6c2c2143d0 = "alive";
        p32._x76ef3ddea3571f37 = false;
        p32:_xe6f7aebd0a9a7b0a(true);
        l__Classes__9._xdca80115d2839102._xf140f42262ec2d57 = nil;
        l__Classes__9._xdca80115d2839102.attacker_model = nil;
        if p33 or not l__Classes__9.MenuManager.in_menu then
            l__Classes__9._x6a15bbeeb97caae0._x150106ccf5e1fa00.Enabled = true;
            l__Classes__9._x181e05d210129765:_xf0923056b6c4ca4a();
            l__Classes__9.MenuManager.in_menu = false;
            l__Classes__9.MenuManager:close();
            l__Classes__9._x1a4ce4062771e36e:_x96ec4a1252301c5a();
            task.spawn(function() --[[ Line: 266 ]]
                -- upvalues: l__LocalPlayer__12 (ref)
                local v35 = l__LocalPlayer__12.Character or l__LocalPlayer__12.CharacterAdded:Wait();
                game.Workspace.CurrentCamera.CameraSubject = v35:WaitForChild("Humanoid");
            end);
            l__Classes__9._x6a15bbeeb97caae0:_xf98f587c3f464384();
            l__Promise__6.defer(function() --[[ Line: 272 ]]
                -- upvalues: l__Classes__9 (ref), u34 (copy)
                l__Classes__9._x6a15bbeeb97caae0:_x2c8149245b825cb9();
                if u34 and u34.deathcard_data then
                    task.spawn(function() --[[ Line: 276 ]]
                        -- upvalues: l__Classes__9 (ref), u34 (ref)
                        l__Classes__9._x6a15bbeeb97caae0:_x847902aa3abd060a(u34.deathcard_data);
                    end);
                end;
                local v36 = l__Classes__9._x8613500a592ecb35:_x743a226b34a5008a("gun");
                if v36 and v36._x6ae550825323339e then
                    l__Classes__9._x6a15bbeeb97caae0:_xa2afd2b77542b209(v36._x6ae550825323339e);
                end;
            end);
            task.spawn(function() --[[ Line: 287 ]]
                -- upvalues: l__LocalPlayer__12 (ref), l__Classes__9 (ref)
                if l__LocalPlayer__12.Character then
                    l__Classes__9._x1a4ce4062771e36e._x932370e16d2f1e9d = l__LocalPlayer__12.Character:WaitForChild("Head").Position;
                    l__Classes__9._x1a4ce4062771e36e._x3569d7da12ecb14c = l__LocalPlayer__12.Character:WaitForChild("Head").Position;
                end;
            end);
            l__Promise__6.defer(function() --[[ Line: 294 ]]
                -- upvalues: l__Classes__9 (ref), l__LocalPlayer__12 (ref)
                if l__Classes__9._x8613500a592ecb35:_x743a226b34a5008a("melee") then
                    l__Classes__9._x8613500a592ecb35:_x6581ac8b859aac7a("melee");
                end;
                local l__Character__22 = l__LocalPlayer__12.Character;
                if l__Character__22 then
                    l__Character__22 = l__LocalPlayer__12.Character:WaitForChild("Humanoid");
                end;
                workspace.CurrentCamera.CameraSubject = l__Character__22;
            end);
            if p33 then
                local v37 = l___x7749231778538ccb__11._xd644d9e3ba63f27f("", l__Classes__9._xddeb4dd489515b18._x4852b50d8a214859);
                if not l__Classes__9._xddeb4dd489515b18._x0822391eeeb254e9 or v37 and v37._x1157c0637bb2e313 then
                    l__Classes__9._x3019cc5b1f776551:_xba28441e0836bc41("combat");
                end;
                if u34 and u34.loadout then
                    local u38 = u34.skin_ids or {};
                    for u39, u40 in u34.loadout do
                        task.defer(function() --[[ Line: 310 ]]
                            -- upvalues: l__Classes__9 (ref), u39 (copy), u40 (copy), u38 (copy)
                            l__Classes__9._x8613500a592ecb35:_x60f7cfe778c89dde(u39, u40, u38[u39]);
                        end);
                    end;
                end;
            end;
            local v41 = l__LocalPlayer__12.PlayerGui:FindFirstChild("GameplayUI");
            if v41 then
                v41.Enabled = true;
            end;
            l__Classes__9._xdca80115d2839102._x711166f3dabb680d = false;
            l__Classes__9._xf1ad98d2d70b7408:_xc3a3137d642c21e6();
            l__Classes__9._xf1ad98d2d70b7408:_x9a7b8c3e8ffd27b6("active", true);
            l__Classes__9._xf1ad98d2d70b7408:_x9a7b8c3e8ffd27b6("movement", true);
            l__Classes__9._xe0e88f94014b801e._xa3fe4f9696ee59ce = true;
        else
            l__Classes__9._x6a15bbeeb97caae0:_xf98f587c3f464384();
            local v42 = l__LocalPlayer__12.PlayerGui:FindFirstChild("GameplayUI");
            if v42 then
                v42.Enabled = false;
            end;
            l__Classes__9._xe0e88f94014b801e._xa3fe4f9696ee59ce = false;
            l__Classes__9._xdca80115d2839102._x711166f3dabb680d = true;
            l__Classes__9._xb6e091f68afb5ee8:_xba28441e0836bc41(false);
        end;
    else
        p32._x69155c6c2c2143d0 = "alive";
    end;
end;
function u1._x97889f9bbdcffc1c(p43, p44) --[[ Line: 327 ]]
    -- upvalues: l__Context__10 (copy), l__Classes__9 (copy)
    if l__Context__10.is_gameplay_mode then
        p43._x69155c6c2c2143d0 = "dead";
        l__Classes__9._x6dbba03a0636f7d8:_x282746dbf42c87cb("DEATH", true);
        l__Classes__9._xf1ad98d2d70b7408:_x9a7b8c3e8ffd27b6("active", false);
        l__Classes__9._xf1ad98d2d70b7408:_x9a7b8c3e8ffd27b6("movement", false);
        l__Classes__9._x3019cc5b1f776551:_x3a3a2a5d005b7d04(-0.3);
        local v45 = l__Classes__9._x181e05d210129765:_xae7b694bd5e96407();
        local v46 = game:GetService("ReplicatedStorage").Assets.UIAssets.DeathCC:Clone();
        v46.Parent = game:GetService("Lighting");
        p43._x5128018f5f9eac94:Add(v46);
        p43._x5128018f5f9eac94:Add(v45);
        l__Classes__9._x1a4ce4062771e36e._xfd7cc994ccc60ad7 = Vector3.new(0, -1, 0);
        l__Classes__9._xe0e88f94014b801e._xa3fe4f9696ee59ce = false;
        local v47;
        if p44 and p44:IsA("Model") then
            v47 = game:GetService("Players"):GetPlayerFromCharacter(p44);
        else
            v47 = nil;
        end;
        l__Classes__9._xb6e091f68afb5ee8:_xba28441e0836bc41(false, v47);
        p43._x5128018f5f9eac94:Add(function() --[[ Line: 349 ]]
            -- upvalues: l__Classes__9 (ref)
            l__Classes__9._xb6e091f68afb5ee8:cleanUp();
        end);
    end;
end;
function u1._x6a5751bfe463daa4(u48) --[[ Line: 354 ]]
    -- upvalues: l__Packets__4 (copy), l__UserInputService__2 (copy), l__Context__10 (copy), l__Classes__9 (copy)
    game:GetService("ReplicatedStorage").Assets.RemoteEvents.Reset.Event:Connect(function() --[[ Line: 355 ]]
        -- upvalues: l__Packets__4 (ref)
        l__Packets__4._x2b80b9b0eee78387:Fire();
    end);
    l__UserInputService__2.InputBegan:Connect(function() --[[ Line: 359 ]]
        -- upvalues: u48 (copy)
        u48:_x44cc42f70c546f76();
    end);
    l__Packets__4._x803fb597e29aa8b8.OnClientEvent:Connect(function(...) --[[ Line: 363 ]]
        -- upvalues: u48 (copy)
        u48._xfa3d4dc00b28ebe7.onHit:Fire(...);
    end);
    l__Packets__4._xbbc4a0659c684667.OnClientEvent:Connect(function() --[[ Line: 367 ]]
        -- upvalues: u48 (copy)
        u48:_xfe8f1e78d32e7ce0();
    end);
    l__Packets__4._xbdf0cfbe82f87173.OnClientEvent:Connect(function(p49) --[[ Line: 371 ]]
        -- upvalues: u48 (copy)
        u48:_x702331960f18c4d1(p49);
        u48._xfa3d4dc00b28ebe7.onDamageTaken:Fire(p49);
    end);
    l__Packets__4._x1a76bdb4b5ac1626.OnClientEvent:Connect(function(p50) --[[ Line: 376 ]]
        -- upvalues: u48 (copy), l__Context__10 (ref), l__Classes__9 (ref)
        u48:_x97889f9bbdcffc1c(p50);
        u48._xfa3d4dc00b28ebe7.onDeath:Fire(p50);
        if l__Context__10.is_gameplay_mode and l__Classes__9._x1a4ce4062771e36e then
            l__Classes__9._x1a4ce4062771e36e._x432e58342e608916 = 3;
            l__Classes__9._x1a4ce4062771e36e._xe20202528e9f738d = 3;
        end;
        u48:_xe6f7aebd0a9a7b0a(true);
    end);
    l__Packets__4._x7988d8d64cb8f58e.OnClientEvent:Connect(function(p51, p52) --[[ Line: 388 ]]
        -- upvalues: u48 (copy)
        u48:_x7eb95db5e4041d3a(p51, p52);
        u48._xfa3d4dc00b28ebe7.onSpawn:Fire(p51, p52);
    end);
    l__Packets__4._xdb2548bded1dd8e3.OnClientEvent:Connect(function(p53) --[[ Line: 393 ]]
        -- upvalues: u48 (copy), l__Context__10 (ref), l__Classes__9 (ref)
        local v54 = (typeof(p53) ~= "number" or (p53 ~= p53 or (p53 == (1 / 0) or p53 == (-1 / 0)))) and 0 or math.max(p53, 0);
        if v54 <= 0 then
            u48:_xe6f7aebd0a9a7b0a(u48._x69155c6c2c2143d0 ~= "alive");
        elseif l__Context__10.is_gameplay_mode then
            if u48._x69155c6c2c2143d0 == "alive" then
                if u48:_x347d856633de5782(v54) then
                    l__Classes__9._x1a4ce4062771e36e._x432e58342e608916 = 0;
                    l__Classes__9._x1a4ce4062771e36e._xe20202528e9f738d = 0;
                    local v55, v56 = pcall(l__Classes__9._x181e05d210129765._xce257a006afdcb1d, l__Classes__9._x181e05d210129765, v54);
                    if v55 and typeof(v56) == "function" then
                        u48._xd587be529cdf414d = v56;
                    else
                        warn("Failed to start client break effect: ", v56);
                    end;
                    u48._xfa3d4dc00b28ebe7.onBreaking:Fire(v54);
                end;
            end;
        end;
    end);
end;
return u1;
