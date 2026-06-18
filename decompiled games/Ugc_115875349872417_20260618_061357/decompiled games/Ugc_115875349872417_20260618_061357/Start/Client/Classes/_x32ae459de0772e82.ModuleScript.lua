-- Decompiled from: Start.Client.Classes._x32ae459de0772e82
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Players__2 = game:GetService("Players");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;
local l__ClientRoot__4 = require(script.Parent.Parent.ClientRoot);
local l__Classes__5 = l__ClientRoot__4.Classes;
local l__Context__6 = l__ClientRoot__4.Context;
local l__Spring__7 = require(l__ReplicatedStorage__3.Assets.ModuleScripts.Spring);
local l__Easer__8 = require(l__ReplicatedStorage__3.Assets.ModuleScripts.Easer);
local l__Promise__9 = require(l__ReplicatedStorage__3.Assets.ModuleScripts.Promise);
local l__Packets__10 = require(l__ReplicatedStorage__3.Assets.ModuleScripts.Packets);
local l__PlaceContext__11 = require(l__ReplicatedStorage__3.Assets.ModuleScripts.PlaceContext);
local l__UserInputService__12 = game:GetService("UserInputService");
local l___x828224cc752f9bda__13 = require(script._x828224cc752f9bda);
local u2 = Random.new();
local u3 = 0;
local l__Instances__14 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local function u5(u4) --[[ Line: 61 ]]
    task.spawn(function() --[[ Line: 62 ]]
        -- upvalues: u4 (copy)
        local l__Humanoid__15 = u4:WaitForChild("Humanoid", 10);
        if l__Humanoid__15 then
            local l__CurrentCamera__16 = workspace.CurrentCamera;
            if l__CurrentCamera__16 then
                l__CurrentCamera__16.CameraSubject = l__Humanoid__15;
            end;
        end;
    end);
end;
local function u9(p6) --[[ Line: 73 ]]
    -- upvalues: l__Context__6 (copy), l__ReplicatedStorage__3 (copy)
    if l__Context__6.is_public_lobby then
        local v7 = l__ReplicatedStorage__3.Assets:FindFirstChild("Models");
        if v7 then
            v7 = v7:FindFirstChild("Animate");
        end;
        if v7 then
            local v8 = v7:Clone();
            v8.Parent = p6;
            if v8:IsA("LocalScript") or v8:IsA("Script") then
                v8.Enabled = true;
            end;
        else
            warn("[Camera] Missing ReplicatedStorage.Assets.Models.Animate for lobby character.");
        end;
    end;
end;
local function u11(u10) --[[ Line: 92 ]]
    -- upvalues: u9 (copy)
    task.spawn(function() --[[ Line: 62 ]]
        -- upvalues: u10 (copy)
        local l__Humanoid__17 = u10:WaitForChild("Humanoid", 10);
        if l__Humanoid__17 then
            local l__CurrentCamera__18 = workspace.CurrentCamera;
            if l__CurrentCamera__18 then
                l__CurrentCamera__18.CameraSubject = l__Humanoid__17;
            end;
        end;
    end);
    u9(u10);
end;
function u1._x90d4581ac99dd483() --[[ Line: 97 ]]
    -- upvalues: u1 (copy), l__Spring__7 (copy), l__Instances__14 (copy)
    local v12 = setmetatable({}, u1);
    v12._xfb1e5eeed3a7e98d = require(script._xc2cf86a485f928f6)._x90d4581ac99dd483();
    v12._x8ff5d6204140ad8b = Enum.RenderPriority.Camera.Value + 2;
    v12._x5b34a8c32cf04968 = false;
    v12._x90d2e1498eb5b292 = false;
    v12._x35ab62be68c330ef = v12._xfb1e5eeed3a7e98d._x3026d7d6f5887abd;
    v12._x07e5a385b26662d8 = 0;
    v12._xfd4d166e99e8b444 = 0;
    v12._x31140f5e63ff1d95 = 0;
    v12._x6d21ba231c669b23 = 1;
    v12._x91f3c66611d1bad2 = 50;
    v12._xc520c90471d94810 = 0;
    v12._xee78bfd6b6850f3b = 0;
    v12._x76277f3a420c2007 = 0;
    v12._xd0c9e96c377df437 = nil;
    v12._x048ede89f6130c59 = nil;
    v12._x85ab498e726fbfe4 = 0;
    v12._x3a23844f215a95b8 = 0;
    v12._x98d5fd112c62c9d8 = 0;
    v12._x99066ac348930027 = 0;
    v12._xb30b7f13778b9dbc = 0;
    v12._x16bf30d0817e6cfe = 0;
    v12._x2eef2c6f68c250a2 = 0;
    v12._x42d40e4ffa13187f = 0;
    v12._x13a5d8654e8357eb = CFrame.new();
    v12._x690baadfd46f04b0 = 0;
    v12._x02ff933e776c2712 = false;
    v12._x225082f3a917962c = nil;
    v12._x3ec9227a0d89a9b3 = UDim2.new();
    v12._xba86765c885864a8 = UDim2.new();
    v12._xfb85155ec89e5a89 = {
        wallride_spring = l__Spring__7.new(1, 15, 100),
        shake_spring_x = l__Spring__7.new(1, 20, 75),
        shake_spring_y = l__Spring__7.new(1, 20, 75),
        shake_spring_z = l__Spring__7.new(1, 5, 2)
    };
    v12._x849ab0e429c951df = {};
    v12._xbd609c4c7dab98ad = {};
    v12._x1e1d15a4897b34d4 = {};
    v12._x297b1e038f8c3806 = {};
    v12._xd6a72042c8e55735 = {};
    v12._xf04b6b1e35ce6046 = {};
    v12._x22de00640d5cc364 = l__Instances__14.HeadOnly;
    for v13, v14 in require(script._xbc6e078e5fa9dfa2) do
        v12._x297b1e038f8c3806[v13] = v14;
    end;
    return v12;
end;
function u1._xccb12ea9ca4915a6(_, p15, u16) --[[ Line: 165 ]]
    -- upvalues: l__Promise__9 (copy), l__Classes__5 (copy)
    for _, u17 in pairs(p15) do
        l__Promise__9.defer(function() --[[ Line: 168 ]]
            -- upvalues: l__Classes__5 (ref), u17 (copy), u16 (copy)
            l__Classes__5._x32ae459de0772e82:_x89ab120f43b710d2(u17, true, u16);
            u17.easer:Run();
        end);
    end;
end;
function u1._x70452e3a4a96af0f(u18, p19) --[[ Line: 176 ]]
    -- upvalues: l__Classes__5 (copy), u2 (copy), u3 (ref)
    if l__Classes__5._x7058397dabccd000._x1d287c838240a901 == l__Classes__5._x7058397dabccd000._x1d287c838240a901 then
        local v20 = math.min(p19, 0.05);
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        if u18._xfb1e5eeed3a7e98d._x03cf20dbc09da11e then
            if l__Classes__5._x7058397dabccd000._x1d287c838240a901.Magnitude > u18._xfb1e5eeed3a7e98d._xaf323cac74eb06b2 then
                local v21 = math.clamp(l__Classes__5._x7058397dabccd000._x1d287c838240a901.Magnitude, u18._xfb1e5eeed3a7e98d._xaf323cac74eb06b2, u18._xfb1e5eeed3a7e98d._x50b46c9cd93e07d6);
                local v22 = l__Classes__5.Util:convNumRange(v21, u18._xfb1e5eeed3a7e98d._xaf323cac74eb06b2, u18._xfb1e5eeed3a7e98d._x50b46c9cd93e07d6, u18._xfb1e5eeed3a7e98d._xbc3c43d85e98708d, u18._xfb1e5eeed3a7e98d._x9723c1256c08d208);
                u18._x76277f3a420c2007 = u2:NextNumber(v22, -v22);
            else
                u18._x76277f3a420c2007 = 0;
            end;
        end;
        if l__Classes__5._x7058397dabccd000._x1d287c838240a901.Magnitude > u18._xfb1e5eeed3a7e98d._xcd6893211af81a75 then
            local v23 = u18._xfb1e5eeed3a7e98d._x3026d7d6f5887abd + u18._xfb1e5eeed3a7e98d._xe7cf8a0c892e1b7e;
            local v24 = math.clamp(l__Classes__5._x7058397dabccd000._x1d287c838240a901.Magnitude, u18._xfb1e5eeed3a7e98d._xcd6893211af81a75, u18._xfb1e5eeed3a7e98d._x279342d8ccd8e917);
            u18._x35ab62be68c330ef = l__Classes__5.Util:convNumRange(v24, u18._xfb1e5eeed3a7e98d._xcd6893211af81a75, u18._xfb1e5eeed3a7e98d._x279342d8ccd8e917, u18._xfb1e5eeed3a7e98d._x3026d7d6f5887abd, v23);
        elseif l__Classes__5._x7430d6d194f43373._x3668b6edfe3dbbd4 == "dead" then
            u18._x35ab62be68c330ef = u18._xfb1e5eeed3a7e98d._x554463d2c4588ac5;
        else
            u18._x35ab62be68c330ef = u18._xfb1e5eeed3a7e98d._x3026d7d6f5887abd;
        end;
        if l__Classes__5._x7058397dabccd000._x77aafe36a385b603._xa822f9aecc59b964 then
            local v25 = l__Classes__5.Util:convNumRange(l__Classes__5._x7058397dabccd000._x77aafe36a385b603._x959c28b970f68b72, l__Classes__5.Config._x8b87a7340c3d55ea, l__Classes__5.Config._x80d230f937a3d131, u18._xfb1e5eeed3a7e98d._xa497a59950ce0e45, 0);
            if l__Classes__5._x7058397dabccd000._x77aafe36a385b603._x959c28b970f68b72 < l__Classes__5.Config._x79bcfa8ed622f54a and l__Classes__5._x7058397dabccd000._x1d287c838240a901.Magnitude > 30 then
                u18._xfd4d166e99e8b444 = l__Classes__5.Util:numLerp(u18._xfd4d166e99e8b444, v25, 3 * v20);
            else
                u18._xfd4d166e99e8b444 = l__Classes__5.Util:numLerp(u18._xfd4d166e99e8b444, 0, 2 * v20);
            end;
            u18._x35ab62be68c330ef = u18._x35ab62be68c330ef + u18._xfd4d166e99e8b444;
        else
            u18._xfd4d166e99e8b444 = l__Classes__5.Util:numLerp(u18._xfd4d166e99e8b444, 0, 5 * v20);
            u18._x35ab62be68c330ef = u18._x35ab62be68c330ef + u18._xfd4d166e99e8b444;
        end;
        if l__Classes__5._x7058397dabccd000._xab5fa47aca1475aa._x698d7df6fb2f7f8d then
            local v26 = Vector3.new(l__Classes__5._x7058397dabccd000._xab5fa47aca1475aa._x000769dd6bd34893.X, 0, l__Classes__5._x7058397dabccd000._xab5fa47aca1475aa._x000769dd6bd34893.Z);
            local v27;
            if v26.Magnitude > 0 then
                v27 = v26.Unit;
            else
                v27 = l__Classes__5._x7058397dabccd000._xab5fa47aca1475aa._x000769dd6bd34893.Unit;
            end;
            local v28 = Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X, 0, workspace.CurrentCamera.CFrame.LookVector.Z);
            local v29;
            if v28.Magnitude > 0 then
                v29 = v28.Unit;
            else
                v29 = workspace.CurrentCamera.CFrame.LookVector.Unit;
            end;
            local v30 = v29:Dot(v27);
            local v31 = math.abs(v30);
            local v32 = math.clamp(v31, -1, 1);
            local v33 = math.acos(v32) / 1.5707963267948966 * u18._xfb1e5eeed3a7e98d._x967e365ed66ada67;
            u18._xc520c90471d94810 = (workspace.CurrentCamera.CFrame.RightVector:Dot(v27) > 0 and -1 or 1) * v33;
        else
            u18._xc520c90471d94810 = 0;
        end;
        local _, v34, _ = workspace.CurrentCamera.CFrame:ToOrientation();
        local v35 = math.deg((v34 - u3 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793);
        u3 = v34;
        local v36 = (l__Classes__5._x7058397dabccd000._x8c912a44b28c4237 - v35 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
        local function v40(p37) --[[ Line: 252 ]]
            -- upvalues: u18 (copy)
            local v38 = math.abs(p37);
            if v38 <= u18._xfb1e5eeed3a7e98d._x6ad9a123c0dfe95d then
                return u18._xfb1e5eeed3a7e98d._xd0c5f53970ca5ef8;
            elseif u18._xfb1e5eeed3a7e98d._x2934a6b951ea06ce <= v38 then
                return 0;
            else
                local v39 = (v38 - u18._xfb1e5eeed3a7e98d._x6ad9a123c0dfe95d) / (u18._xfb1e5eeed3a7e98d._x2934a6b951ea06ce - 0.5);
                if p37 > 0 then
                    return u18._xfb1e5eeed3a7e98d._xd0c5f53970ca5ef8 * (1 - v39 ^ 2);
                else
                    return u18._xfb1e5eeed3a7e98d._xd0c5f53970ca5ef8 * (1 - v39);
                end;
            end;
        end;
        local v41;
        if l__Classes__5._x7058397dabccd000._xab5fa47aca1475aa._x698d7df6fb2f7f8d and l__Classes__5._x7058397dabccd000._xab5fa47aca1475aa._x02c535481ceb65a2 or l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("RIGHT").Held and l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("LEFT").Held then
            v41 = 0;
        elseif l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("RIGHT").Held and (not l__Classes__5._x7058397dabccd000._x5242295569714a31 and math.abs(v35) > 0.3) then
            v41 = -v40(v36);
        else
            v41 = (not l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("LEFT").Held or (l__Classes__5._x7058397dabccd000._x5242295569714a31 or math.abs(v35) <= 0.3)) and 0 or v40(v36);
        end;
        u18._x3a23844f215a95b8 = l__Classes__5.Util:numLerp(u18._x3a23844f215a95b8, v41, 2 * v20);
    end;
end;
function u1._x5d1cf7800847ed79(u42) --[[ Line: 286 ]]
    -- upvalues: l__Classes__5 (copy), l__Easer__8 (copy), l__Promise__9 (copy), l__Players__2 (copy), u5 (copy)
    l__Classes__5._x7058397dabccd000._x5178379199a428dc.slide_started.Event:Connect(function() --[[ Line: 287 ]]
        -- upvalues: u42 (copy), l__Easer__8 (ref)
        u42._x297b1e038f8c3806.slide_began:Run();
        local v43 = {
            angle_type = "roll",
            easer = l__Easer__8.new(0, 0.6, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = 0.03,
                    goal_alpha = 0.2,
                    easing_style = "QuadIn"
                }
            })
        };
        u42:_x89ab120f43b710d2(v43, true);
        v43.easer:Run();
    end);
    l__Classes__5._x7058397dabccd000._x5178379199a428dc.slide_ended.Event:Connect(function() --[[ Line: 310 ]]
        -- upvalues: u42 (copy)
        u42._x297b1e038f8c3806.slide_ended:Run();
    end);
    l__Classes__5._x7058397dabccd000._x5178379199a428dc.wallride_ended.Event:Connect(function(p44) --[[ Line: 314 ]]
        -- upvalues: u42 (copy)
        if p44 == "wallkick_right" or p44 == "wallkick_left" then
            u42._x297b1e038f8c3806.wall_kick:Run();
        end;
    end);
    l__Classes__5._x7058397dabccd000._x5178379199a428dc.dash_started.Event:Connect(function() --[[ Line: 320 ]]
        -- upvalues: u42 (copy), l__Promise__9 (ref)
        u42._x07e5a385b26662d8 = u42._xfb1e5eeed3a7e98d._x3026d7d6f5887abd + u42._xfb1e5eeed3a7e98d._xb32c60bc1c37bd9b;
        l__Promise__9.defer(function() --[[ Line: 322 ]]
            -- upvalues: u42 (ref)
            u42._x07e5a385b26662d8 = 0;
        end);
    end);
    l__Players__2.LocalPlayer.CharacterAdded:Connect(u5);
end;
function u1._x9169ece3daeba31c(u45, p46) --[[ Line: 331 ]]
    -- upvalues: l__Classes__5 (copy), l__UserInputService__12 (copy)
    if u45._x5b34a8c32cf04968 then
    elseif l__Classes__5._x7058397dabccd000._x1d287c838240a901 == l__Classes__5._x7058397dabccd000._x1d287c838240a901 then
        if u45._x02ff933e776c2712 then
        else
            local u47 = math.min(p46, 0.1);
            if l__Classes__5._x7058397dabccd000._xbcaafe2ed14862c8 and l__Classes__5._x7058397dabccd000._xbcaafe2ed14862c8:FindFirstChild("Head") then
                u45._x90d2e1498eb5b292 = l__Classes__5._x7058397dabccd000._xbcaafe2ed14862c8.Head.LocalTransparencyModifier == 1;
                if u45._x90d2e1498eb5b292 and l__Classes__5._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" then
                    l__Classes__5._x910f31e87b3c7281._x0dabd010e1f00f2e = true;
                else
                    l__Classes__5._x910f31e87b3c7281._x0dabd010e1f00f2e = false;
                end;
            end;
            u45._x3ec9227a0d89a9b3 = l__Classes__5.Util:Vec2ToUDim2(workspace.CurrentCamera.ViewportSize / 2);
            local l___xb30b7f13778b9dbc__19 = u45._xb30b7f13778b9dbc;
            local l___x99066ac348930027__20 = u45._x99066ac348930027;
            local l___x42d40e4ffa13187f__21 = u45._x42d40e4ffa13187f;
            local l___x2eef2c6f68c250a2__22 = u45._x2eef2c6f68c250a2;
            u45._x42d40e4ffa13187f = 0;
            u45._x2eef2c6f68c250a2 = 0;
            u45._x16bf30d0817e6cfe = 0;
            u45._xb30b7f13778b9dbc = 0;
            u45._x99066ac348930027 = 0;
            u45._x31140f5e63ff1d95 = 0;
            u45:_x70452e3a4a96af0f(u47);
            local function v48() --[[ Line: 375 ]]
                -- upvalues: u45 (copy)
                u45._xfb85155ec89e5a89.shake_spring_x:SetGoal(u45._x76277f3a420c2007 * u45._xfb1e5eeed3a7e98d._x7e59fcfcccf2db17);
                u45._xfb85155ec89e5a89.shake_spring_y:SetGoal(u45._x76277f3a420c2007 * u45._xfb1e5eeed3a7e98d._x7e59fcfcccf2db17);
                u45._xfb85155ec89e5a89.shake_spring_z:SetGoal(u45._x76277f3a420c2007);
                return CFrame.Angles(u45._xfb85155ec89e5a89.shake_spring_x.Velocity, u45._xfb85155ec89e5a89.shake_spring_y.Velocity, u45._xfb85155ec89e5a89.shake_spring_z.Velocity);
            end;
            local function v52() --[[ Line: 388 ]]
                -- upvalues: u45 (copy), l__Classes__5 (ref), u47 (ref)
                for _, u49 in pairs(u45._xbd609c4c7dab98ad) do
                    if typeof(u49.value) == "number" then
                        if u49.cancel_when_zero and u49.value == 0 then
                            u49.promise:cancel();
                        else
                            task.spawn(function() --[[ Line: 394 ]]
                                -- upvalues: u45 (ref), u49 (copy)
                                local v50 = u45;
                                v50._x31140f5e63ff1d95 = v50._x31140f5e63ff1d95 + u49.value;
                            end);
                        end;
                    elseif u49.value:IsA("NumberValue") then
                        if u49.cancel_when_zero and u49.value.Value == 0 then
                            u49.promise:cancel();
                        else
                            task.spawn(function() --[[ Line: 402 ]]
                                -- upvalues: u45 (ref), u49 (copy)
                                local v51 = u45;
                                v51._x31140f5e63ff1d95 = v51._x31140f5e63ff1d95 + u49.value.Value;
                            end);
                        end;
                    end;
                end;
                workspace.CurrentCamera.FieldOfView = u45._x07e5a385b26662d8 ~= 0 and u45._x07e5a385b26662d8 or l__Classes__5.Util:numLerp(workspace.CurrentCamera.FieldOfView, u45._x35ab62be68c330ef, 8 * u47);
                local l__CurrentCamera__23 = workspace.CurrentCamera;
                l__CurrentCamera__23.FieldOfView = l__CurrentCamera__23.FieldOfView + u45._x31140f5e63ff1d95;
            end;
            local function u62(p53, p54, p55) --[[ Line: 413 ]]
                -- upvalues: u45 (copy)
                if p53 == "roll" then
                    if p55 then
                        local v56 = u45;
                        v56._x16bf30d0817e6cfe = v56._x16bf30d0817e6cfe + p54;
                    else
                        local v57 = u45;
                        v57._x98d5fd112c62c9d8 = v57._x98d5fd112c62c9d8 + p54;
                    end;
                    return true;
                end;
                if p53 == "yaw" then
                    if p55 then
                        local v58 = u45;
                        v58._x2eef2c6f68c250a2 = v58._x2eef2c6f68c250a2 + p54;
                    else
                        local v59 = u45;
                        v59._x99066ac348930027 = v59._x99066ac348930027 + p54;
                    end;
                    return true;
                end;
                if p53 ~= "pitch" then
                    return false;
                end;
                if p55 then
                    local v60 = u45;
                    v60._x42d40e4ffa13187f = v60._x42d40e4ffa13187f + p54;
                else
                    local v61 = u45;
                    v61._xb30b7f13778b9dbc = v61._xb30b7f13778b9dbc + p54;
                end;
                return true;
            end;
            local function v68() --[[ Line: 440 ]]
                -- upvalues: u45 (copy), l__Classes__5 (ref), u62 (copy)
                for _, v63 in pairs(u45._x1e1d15a4897b34d4) do
                    local l__decay_time__24 = v63.decay_time;
                    local v64 = os.clock() - v63.start_time;
                    local v65 = math.min(v64, l__decay_time__24);
                    local v66 = l__Classes__5.Util:convNumRange(v65, 0, l__decay_time__24, 1, 0);
                    if v66 == 0 then
                        v63.promise:cancel();
                    end;
                    for _, v67 in pairs(v63.springs) do
                        u62(v67.angle_type, v67.spring.Offset * v66, not v63.use_normal_angles);
                    end;
                end;
            end;
            local function v73() --[[ Line: 515 ]]
                -- upvalues: l__Classes__5 (ref), u45 (copy)
                local l__X__25 = workspace.CurrentCamera.CFrame:VectorToObjectSpace(l__Classes__5._x7058397dabccd000._x1d287c838240a901).X;
                local v69 = math.clamp(l__X__25, -u45._xfb1e5eeed3a7e98d._xf1b514930e91d065, u45._xfb1e5eeed3a7e98d._xf1b514930e91d065);
                local v70 = l__Classes__5._x7058397dabccd000._x77aafe36a385b603._xa822f9aecc59b964 and -u45._xfb1e5eeed3a7e98d._xcb621b5baea5fa66 or (l__Classes__5._x7058397dabccd000._xda13c0969fbb05c9._x5e20b8280d45f2ef and u45._xfb1e5eeed3a7e98d._xcb621b5baea5fa66 or u45._xfb1e5eeed3a7e98d._x5e0bb01080c2285a);
                if v69 > 0 then
                    local v71 = l__Classes__5.Util:convNumRange(v69, 0, u45._xfb1e5eeed3a7e98d._xf1b514930e91d065, 0, -v70);
                    u45._x85ab498e726fbfe4 = l__Classes__5.Util:numLerp(u45._x85ab498e726fbfe4, v71, 0.1);
                    return math.rad(u45._x85ab498e726fbfe4);
                else
                    local v72 = l__Classes__5.Util:convNumRange(v69, 0, -u45._xfb1e5eeed3a7e98d._xf1b514930e91d065, 0, v70);
                    u45._x85ab498e726fbfe4 = l__Classes__5.Util:numLerp(u45._x85ab498e726fbfe4, v72, 0.1);
                    return math.rad(u45._x85ab498e726fbfe4);
                end;
            end;
            u45._xfb85155ec89e5a89.wallride_spring:SetGoal(l__Classes__5.Util:numLerp(u45._xee78bfd6b6850f3b, u45._xc520c90471d94810, 0.7));
            u45._xee78bfd6b6850f3b = u45._xfb85155ec89e5a89.wallride_spring.Offset;
            v52();
            u45._xb30b7f13778b9dbc = u45._xb30b7f13778b9dbc + (u45._x297b1e038f8c3806.landing_rot.Position + u45._x297b1e038f8c3806.slide_began.Position + u45._x297b1e038f8c3806.slide_ended.Position + u45._x297b1e038f8c3806.wall_kick.Position);
            u45._x98d5fd112c62c9d8 = math.rad(u45._xee78bfd6b6850f3b) + v73() + u45._x3a23844f215a95b8 + u45._x16bf30d0817e6cfe;
            (function() --[[ Name: processCustomEases, Line 456 ]]
                -- upvalues: u45 (copy), u62 (copy)
                for _, v74 in pairs(u45._x849ab0e429c951df) do
                    if not u62(v74.angle_type, v74.easer.Position, v74.external) then
                        warn("INVALID EASE ANGLE TYPE : " .. tostring(v74.angle_type));
                    end;
                end;
            end)();
            v68();
            (function() --[[ Name: processExternalAngles, Line 464 ]]
                -- upvalues: u45 (copy)
                for _, v75 in pairs(u45._xd6a72042c8e55735) do
                    local l__angle_type__26 = v75.angle_type;
                    local l__value__27 = v75.value;
                    local v76;
                    if l__angle_type__26 == "roll" then
                        local v77 = u45;
                        v77._x98d5fd112c62c9d8 = v77._x98d5fd112c62c9d8 + l__value__27;
                        v76 = true;
                    elseif l__angle_type__26 == "yaw" then
                        local v78 = u45;
                        v78._x99066ac348930027 = v78._x99066ac348930027 + l__value__27;
                        v76 = true;
                    elseif l__angle_type__26 == "pitch" then
                        local v79 = u45;
                        v79._xb30b7f13778b9dbc = v79._xb30b7f13778b9dbc + l__value__27;
                        v76 = true;
                    else
                        v76 = false;
                    end;
                    if not v76 then
                        warn("INVALID EASE ANGLE TYPE : " .. tostring(v75.angle_type));
                    end;
                end;
            end)();
            (function() --[[ Name: processHeadAnimations, Line 472 ]]
                -- upvalues: u45 (copy)
                local v80 = os.clock();
                local v81 = 0;
                local v82 = 0;
                local v83 = 0;
                for v84 = #u45._xf04b6b1e35ce6046, 1, -1 do
                    local v85 = u45._xf04b6b1e35ce6046[v84];
                    if v85.expiry < v80 or not v85.head then
                        table.remove(u45._xf04b6b1e35ce6046, v84);
                    else
                        local v86, v87, v88 = v85.base_cf:ToObjectSpace(v85.head.CFrame):ToEulerAnglesXYZ();
                        v85.roll = v85.roll + (v88 - v85.roll) * v85.weight;
                        v85.yaw = v85.yaw + (v87 - v85.yaw) * v85.weight;
                        v85.pitch = v85.pitch + (v86 - v85.pitch) * v85.weight;
                        v81 = v81 + v85.roll;
                        v82 = v82 + v85.yaw;
                        v83 = v83 + v85.pitch;
                    end;
                end;
                local v89 = u45;
                v89._x98d5fd112c62c9d8 = v89._x98d5fd112c62c9d8 + math.rad(v81);
                local v90 = u45;
                v90._x99066ac348930027 = v90._x99066ac348930027 + math.rad(v82);
                local v91 = u45;
                v91._xb30b7f13778b9dbc = v91._xb30b7f13778b9dbc + math.rad(v83);
            end)();
            local l__FieldOfView__28 = workspace.CurrentCamera.FieldOfView;
            if l__FieldOfView__28 >= 80 then
                l__UserInputService__12.MouseDeltaSensitivity = 1;
            else
                local v92 = math.rad(l__FieldOfView__28 / 2);
                l__UserInputService__12.MouseDeltaSensitivity = math.tan(v92) / 0.8390996311772799;
            end;
            local v93 = v48();
            l__Classes__5._x7058397dabccd000._x8b126a5573d2ae07.CameraOffset = (function() --[[ Name: getCameraOffset, Line 545 ]]
                -- upvalues: l__Classes__5 (ref), u45 (copy)
                local v94 = l__Classes__5._x7058397dabccd000._x048ee3bda38e30d2 <= 0 and 0 or math.clamp(u45._x690baadfd46f04b0 / l__Classes__5._x7058397dabccd000._x048ee3bda38e30d2, 0, 1);
                if not (l__Classes__5._x7058397dabccd000._x945ab195596e2183 and l__Classes__5._x7058397dabccd000._x0e71d3ad266246bf) then
                    return Vector3.new();
                end;
                local v95 = l__Classes__5._x7058397dabccd000._x945ab195596e2183:Lerp(l__Classes__5._x7058397dabccd000._x0e71d3ad266246bf, v94);
                local l__CurrentCamera__29 = workspace.CurrentCamera;
                if l__CurrentCamera__29 then
                    local v96 = l__CurrentCamera__29.CFrame:PointToObjectSpace(v95);
                    if not (u45.humanoid and u45.humanoid.Parent) then
                        return Vector3.new();
                    end;
                    if v96.Magnitude > 10 then
                        v96 = v96.Unit * 10;
                    end;
                    return v96;
                end;
            end)() + Vector3.new(0, u45._x297b1e038f8c3806.landing_pos.Position, 0);
            local v97 = u45._xb30b7f13778b9dbc - l___xb30b7f13778b9dbc__19;
            local v98 = u45._x99066ac348930027 - l___x99066ac348930027__20;
            local v99 = u45._x42d40e4ffa13187f - l___x42d40e4ffa13187f__21;
            local v100 = u45._x2eef2c6f68c250a2 - l___x2eef2c6f68c250a2__22;
            local _ = game.Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson;
            local l__CurrentCamera__30 = workspace.CurrentCamera;
            local l__CFrame__31 = l__CurrentCamera__30.CFrame;
            local v101, _, _ = l__CFrame__31:ToOrientation();
            local v102 = math.cos(v101);
            math.abs(v102);
            local v103 = (v97 + v99) * u45._x91f3c66611d1bad2;
            local v104 = (v98 + v100) * u45._x91f3c66611d1bad2;
            local l___x98d5fd112c62c9d8__32 = u45._x98d5fd112c62c9d8;
            local v105 = math.clamp(v101 + v103, -1.3962634015954636, 1.3962634015954636) - v101;
            l__CurrentCamera__30.CFrame = l__CFrame__31 * (CFrame.Angles(v105, v104, l___x98d5fd112c62c9d8__32) * v93);
            u45._xba86765c885864a8 = u45:_x4a566e19c4041715();
        end;
    end;
end;
function u1._x6bcb757f3207ce9e(u106, p107, p108, p109, p110, p111) --[[ Line: 633 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), l__Promise__9 (copy)
    local v112 = p111 or p107;
    local l__Animations__33 = l__ReplicatedStorage__3.Assets.Animations;
    local v113;
    if typeof(v112) == "Instance" then
        v113 = v112;
    elseif typeof(v112) == "string" then
        v113 = l__Animations__33:FindFirstChild(v112) or nil;
    else
        v113 = nil;
    end;
    if not v113 then
        warn("COULD NOT FIND VIEWMODEL HEAD ANIMATION FOLDER FOR : ", v112);
        return l__Promise__9.resolve();
    end;
    local v114 = v113:FindFirstChild(p108);
    if not v114 then
        warn("COULD NOT FIND VIEWMODEL HEAD ANIMATION : ", p108, v113);
        return l__Promise__9.resolve();
    end;
    local u115 = u106._x22de00640d5cc364:Clone();
    u115.Parent = game.Workspace:WaitForChild("Effects");
    u115:PivotTo(CFrame.new(50000, 50000, 50000));
    local l__Head__34 = u115.Head;
    local u116 = u115.AnimationController.Animator:LoadAnimation(v114);
    local u117 = {
        roll = 0,
        yaw = 0,
        pitch = 0,
        cleanuped = false,
        head = l__Head__34,
        base_cf = l__Head__34.CFrame,
        weight = p109,
        expiry = os.clock() + p110,
        track = u116
    };
    table.insert(u106._xf04b6b1e35ce6046, u117);
    u116:Play();
    u116.Stopped:Connect(function() --[[ Name: cleanup, Line 673 ]]
        -- upvalues: u117 (copy), u116 (copy), u115 (copy), u106 (copy)
        if u117.cleanuped then
        else
            u117.cleanuped = true;
            u116:Stop();
            u115:Destroy();
            local v118 = table.find(u106._xf04b6b1e35ce6046, u117);
            if v118 then
                table.remove(u106._xf04b6b1e35ce6046, v118);
            end;
        end;
    end);
    local v119 = l__Promise__9.delay(p110);
    v119:finally(function() --[[ Line: 687 ]]
        -- upvalues: u117 (copy), u116 (copy), u115 (copy), u106 (copy)
        if u117.cleanuped then
        else
            u117.cleanuped = true;
            u116:Stop();
            u115:Destroy();
            local v120 = table.find(u106._xf04b6b1e35ce6046, u117);
            if v120 then
                table.remove(u106._xf04b6b1e35ce6046, v120);
            end;
        end;
    end);
    return v119;
end;
function u1._x4a566e19c4041715(p121) --[[ Line: 695 ]]
    local l__CurrentCamera__35 = game.Workspace.CurrentCamera;
    local l__ViewportSize__36 = l__CurrentCamera__35.ViewportSize;
    local v122 = l__ViewportSize__36.Y / 2;
    local v123 = math.rad(l__CurrentCamera__35.FieldOfView) / 2;
    local v124 = v122 / math.tan(v123);
    local v125 = v124 * math.tan(p121._x99066ac348930027 * p121._x91f3c66611d1bad2);
    local v126 = v124 * math.tan(-p121._xb30b7f13778b9dbc * p121._x91f3c66611d1bad2);
    return UDim2.fromOffset(l__ViewportSize__36.X / 2 + v125, l__ViewportSize__36.Y / 2 - v126);
end;
function u1._x89ab120f43b710d2(u127, u128, p129, p130) --[[ Line: 710 ]]
    table.insert(u127._x849ab0e429c951df, u128);
    if p129 then
        u128.external = p130;
        u128.easer.destroy_once_completed = true;
        u128.easer.Completed.Event:Once(function() --[[ Line: 715 ]]
            -- upvalues: u127 (copy), u128 (copy)
            local v131 = table.find(u127._x849ab0e429c951df, u128);
            if v131 then
                table.remove(u127._x849ab0e429c951df, v131);
            end;
        end);
    end;
end;
function u1._x8ee1ac854964ea1a(u132, p133, p134, p135, p136, u137, p138, p139, p140, p141) --[[ Line: 724 ]]
    -- upvalues: u2 (copy), l__Spring__7 (copy), l__Promise__9 (copy)
    local u142 = {
        decay_time = u137,
        cancel_when_zero = p138 or false,
        springs = {},
        use_normal_angles = p139 or false,
        start_time = os.clock()
    };
    for _, v143 in p136 do
        local v144 = {
            angle_type = v143
        };
        local v145 = p141 and p134 and p134 or u2:NextNumber(p134 - p134 * 0.05, p134 + p134 * 0.05);
        local v146 = p141 and p135 and p135 or u2:NextNumber(p135 - p135 * 0.05, p135 + p135 * 0.05);
        v144.spring = l__Spring__7.fromFrequency(1, v145, v146);
        local v147 = p140 and p133 and p133 or ({ p133, -p133 })[math.random(1, 2)];
        local v148 = p141 and v147 and v147 or u2:NextNumber(v147 - v147 * 0.05, v147 + v147 * 0.05);
        if v143 == "roll" then
            v144.spring:AddVelocity(v148 / 10);
        elseif v143 == "pitch" then
            v144.spring:AddVelocity(v148 / 100);
        elseif v143 == "yaw" then
            v144.spring:AddVelocity(v148 / 160);
        end;
        table.insert(u142.springs, v144);
    end;
    table.insert(u132._x1e1d15a4897b34d4, u142);
    local v153 = l__Promise__9.new(function(u149, _, p150) --[[ Line: 753 ]]
        -- upvalues: u132 (copy), u142 (copy), u137 (copy)
        task.delay(u137, function() --[[ Line: 761 ]]
            -- upvalues: u132 (ref), u142 (ref), u149 (copy)
            local v151 = table.find(u132._x1e1d15a4897b34d4, u142);
            if v151 then
                table.remove(u132._x1e1d15a4897b34d4, v151);
            end;
            u149();
        end);
        p150(function() --[[ Line: 766 ]]
            -- upvalues: u132 (ref), u142 (ref)
            local v152 = table.find(u132._x1e1d15a4897b34d4, u142);
            if v152 then
                table.remove(u132._x1e1d15a4897b34d4, v152);
            end;
        end);
    end);
    u142.promise = v153;
    return v153, u142;
end;
function u1._x8ca42af5fe3be726(u154, u155) --[[ Line: 774 ]]
    -- upvalues: l__Promise__9 (copy)
    table.insert(u154._xbd609c4c7dab98ad, u155);
    local v158 = l__Promise__9.new(function(_, _, p156) --[[ Line: 776 ]]
        -- upvalues: u155 (copy), u154 (copy)
        p156(function() --[[ Line: 777 ]]
            -- upvalues: u155 (ref), u154 (ref)
            if u155.value:IsA("NumberValue") then
                u155.value:Destroy();
            end;
            local v157 = table.find(u154._xbd609c4c7dab98ad, u155);
            if v157 then
                table.remove(u154._xbd609c4c7dab98ad, v157);
            end;
        end);
    end);
    u155.promise = v158;
    return v158;
end;
function u1._xcd08cb309b2bdd1e(u159, u160) --[[ Line: 791 ]]
    -- upvalues: l__Promise__9 (copy)
    return l__Promise__9.new(function(_, _, p161) --[[ Line: 792 ]]
        -- upvalues: u159 (copy), u160 (copy)
        table.insert(u159._xd6a72042c8e55735, u160);
        p161(function() --[[ Line: 795 ]]
            -- upvalues: u159 (ref), u160 (ref)
            local v162 = table.find(u159._xd6a72042c8e55735, u160);
            if v162 then
                table.remove(u159._xd6a72042c8e55735, v162);
            end;
        end);
    end);
end;
function u1._x76b38494ff05a56c(p163) --[[ Line: 804 ]]
    return workspace.CurrentCamera:ViewportPointToRay(p163._xba86765c885864a8.X.Offset, p163._xba86765c885864a8.Y.Offset, 0).Direction;
end;
local u164 = {};
function u1._xab3431bda299b7c7(p165) --[[ Line: 812 ]]
    -- upvalues: l__Context__6 (copy), l__Classes__5 (copy), l___x828224cc752f9bda__13 (copy), u164 (copy)
    if l__Context__6.is_gameplay_mode and l__Classes__5._x910f31e87b3c7281 then
        if l__Classes__5._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" then
            if p165._x02ff933e776c2712 then
                l__Classes__5._x3e046bec2684f59c:_xc7d90d6af08271a9(false);
                l__Classes__5._x910f31e87b3c7281._x0dabd010e1f00f2e = true;
                p165._x02ff933e776c2712 = false;
                l___x828224cc752f9bda__13:_x93aa151a87226b31();
                for v166, v167 in u164 do
                    v166.Enabled = v167;
                end;
            else
                l__Classes__5._x3e046bec2684f59c:_xc7d90d6af08271a9(true);
                l__Classes__5._x910f31e87b3c7281._x0dabd010e1f00f2e = false;
                p165._x02ff933e776c2712 = true;
                l___x828224cc752f9bda__13:_x3066b638ee2d6a82();
                for _, u168 in game.Players.LocalPlayer.PlayerGui:GetChildren() do
                    if u168.Name ~= "CommandUI" then
                        pcall(function() --[[ Line: 834 ]]
                            -- upvalues: u164 (ref), u168 (copy)
                            u164[u168] = u168.Enabled;
                            u168.Enabled = false;
                        end);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._xe53615d96cf36a6b(u169) --[[ Line: 842 ]]
    -- upvalues: l__PlaceContext__11 (copy), l__RunService__1 (copy), l__Packets__10 (copy), l__Players__2 (copy), u11 (copy), u9 (copy), l__Context__6 (copy), l__Classes__5 (copy)
    if l__PlaceContext__11.get().effective_mode ~= l__PlaceContext__11.EffectiveModes.PUBLIC_LOBBY and not l__RunService__1:IsStudio() then
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
    end;
    l__Packets__10._x1e60efff7ef01a3a.OnClientEvent:Connect(function() --[[ Line: 847 ]]
        -- upvalues: u169 (copy)
        u169:_xab3431bda299b7c7();
    end);
    l__Players__2.LocalPlayer.CharacterAdded:Connect(u11);
    if l__Players__2.LocalPlayer.Character then
        local l__Character__37 = l__Players__2.LocalPlayer.Character;
        task.spawn(function() --[[ Line: 62 ]]
            -- upvalues: l__Character__37 (copy)
            local l__Humanoid__38 = l__Character__37:WaitForChild("Humanoid", 10);
            if l__Humanoid__38 then
                local l__CurrentCamera__39 = workspace.CurrentCamera;
                if l__CurrentCamera__39 then
                    l__CurrentCamera__39.CameraSubject = l__Humanoid__38;
                end;
            end;
        end);
        u9(l__Character__37);
    end;
    if l__Context__6.is_gameplay_mode then
        task.defer(function() --[[ Line: 860 ]]
            -- upvalues: u169 (copy), l__Classes__5 (ref)
            u169:_x5d1cf7800847ed79();
            l__Classes__5.Util:bindToRenderStep("camera_update", u169._x8ff5d6204140ad8b, function(p170) --[[ Line: 863 ]]
                -- upvalues: u169 (ref)
                u169:_x9169ece3daeba31c(p170);
            end);
        end);
    end;
end;
return u1;
