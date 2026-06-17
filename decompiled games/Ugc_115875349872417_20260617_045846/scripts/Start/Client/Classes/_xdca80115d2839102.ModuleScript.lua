-- Decompiled from: Start.Client.Classes._xdca80115d2839102
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
local l___xc1176ac192711e72__13 = require(script._xc1176ac192711e72);
local u2 = Random.new();
local u3 = 0;
local l__Instances__14 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local function u5(u4) --[[ Line: 74 ]]
    task.spawn(function() --[[ Line: 75 ]]
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
local function u9(p6) --[[ Line: 86 ]]
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
                print("enabled");
                v8.Enabled = true;
            end;
        else
            warn("[Camera] Missing ReplicatedStorage.Assets.Models.Animate for lobby character.");
        end;
    end;
end;
local function u11(u10) --[[ Line: 106 ]]
    -- upvalues: u9 (copy)
    task.spawn(function() --[[ Line: 75 ]]
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
function u1._x83ed94bfb82a8c9f() --[[ Line: 111 ]]
    -- upvalues: u1 (copy), l__Spring__7 (copy), l__Instances__14 (copy)
    local v12 = setmetatable({}, u1);
    v12._x6142a368f111d36e = require(script._x569c479bf6ea5ebc)._x83ed94bfb82a8c9f();
    v12._x77180ae41c82e39b = Enum.RenderPriority.Camera.Value + 2;
    v12._x711166f3dabb680d = false;
    v12._xf5c5c2152a2970b7 = false;
    v12._xc458e9217c19f77b = v12._x6142a368f111d36e._xb66c1aa5df35d452;
    v12._x24c9d58646ed2710 = 0;
    v12._x2b99c131507c2bc3 = 0;
    v12._xbb83464e1451cd03 = 0;
    v12._x61f9294968c01f56 = 1;
    v12._xa5c0aad232b62bd1 = 50;
    v12._x7875db7191909311 = 0;
    v12._x8e8b765431ffea09 = 0;
    v12._x414decf2c19974b5 = 0;
    v12._xf6a14f2ee4cc9344 = nil;
    v12._xdf591c16342e3998 = nil;
    v12._x7d7065c07b893f90 = 0;
    v12._x715dd1901820e45b = 0;
    v12._x120f4a9aed8ade07 = 0;
    v12._x5d3b27bfd0a12cd9 = 0;
    v12._x9e17087c104df3a7 = 0;
    v12._x57035e8df2813a5b = 0;
    v12._xd2e2ac21c271ebcf = 0;
    v12._x27ba4e1142eb1eb8 = 0;
    v12._x21f0b7567a9c530c = CFrame.new();
    v12._xd301a5e801fa3e35 = 0;
    v12._xb7ba9dddb83899b5 = false;
    v12._xf140f42262ec2d57 = nil;
    v12._xda381e3eaea72a8b = UDim2.new();
    v12._x54c3502e79e0b78a = UDim2.new();
    v12._x12d03a44e8b02ddc = {
        wallride_spring = l__Spring__7.new(1, 15, 100),
        shake_spring_x = l__Spring__7.new(1, 20, 75),
        shake_spring_y = l__Spring__7.new(1, 20, 75),
        shake_spring_z = l__Spring__7.new(1, 5, 2)
    };
    v12._x5bc75b28ed085616 = {};
    v12._xca68db72e68a5da9 = {};
    v12._x39bf6be6d6f47df2 = {};
    v12._x6072979e1970fdff = {};
    v12._x9aa3bce9db5771ce = {};
    v12._x81f32900ceb94713 = {};
    v12._x3e9becf9b9215745 = l__Instances__14.HeadOnly;
    for v13, v14 in require(script._x874c01f497bd7307) do
        v12._x6072979e1970fdff[v13] = v14;
    end;
    return v12;
end;
function u1._x03776a37ad8cd8fe(_, p15, u16) --[[ Line: 179 ]]
    -- upvalues: l__Promise__9 (copy), l__Classes__5 (copy)
    for _, u17 in pairs(p15) do
        l__Promise__9.defer(function() --[[ Line: 182 ]]
            -- upvalues: l__Classes__5 (ref), u17 (copy), u16 (copy)
            l__Classes__5._xdca80115d2839102:_x67da5f869bceed5d(u17, true, u16);
            u17.easer:Run();
        end);
    end;
end;
function u1._xdd9c71117ed0f27b(u18, p19) --[[ Line: 190 ]]
    -- upvalues: l__Classes__5 (copy), u2 (copy), u3 (ref)
    if l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7 == l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7 then
        local v20 = math.min(p19, 0.05);
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        if u18._x6142a368f111d36e._x911d60a5d00c0d20 then
            if l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude > u18._x6142a368f111d36e._xb65761075137c269 then
                local v21 = math.clamp(l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude, u18._x6142a368f111d36e._xb65761075137c269, u18._x6142a368f111d36e._xbdc74ad336e7be18);
                local v22 = l__Classes__5.Util:convNumRange(v21, u18._x6142a368f111d36e._xb65761075137c269, u18._x6142a368f111d36e._xbdc74ad336e7be18, u18._x6142a368f111d36e._xdd95c64ea85a4205, u18._x6142a368f111d36e._x388816ffe46eecbc);
                u18._x414decf2c19974b5 = u2:NextNumber(v22, -v22);
            else
                u18._x414decf2c19974b5 = 0;
            end;
        end;
        if l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude > u18._x6142a368f111d36e._xc7d1fe812e1c8c28 then
            local v23 = u18._x6142a368f111d36e._xb66c1aa5df35d452 + u18._x6142a368f111d36e._x2b5ba334c4353ce3;
            local v24 = math.clamp(l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude, u18._x6142a368f111d36e._xc7d1fe812e1c8c28, u18._x6142a368f111d36e._x954b0a6d1d5c7f0c);
            u18._xc458e9217c19f77b = l__Classes__5.Util:convNumRange(v24, u18._x6142a368f111d36e._xc7d1fe812e1c8c28, u18._x6142a368f111d36e._x954b0a6d1d5c7f0c, u18._x6142a368f111d36e._xb66c1aa5df35d452, v23);
        elseif l__Classes__5._x8399b2bb73e12808._x69155c6c2c2143d0 == "dead" then
            u18._xc458e9217c19f77b = u18._x6142a368f111d36e._xe5dcae7a45f6c4c5;
        else
            u18._xc458e9217c19f77b = u18._x6142a368f111d36e._xb66c1aa5df35d452;
        end;
        if l__Classes__5._x1a4ce4062771e36e._x0aa5621fbcbe69df._x3b8a76d53cd0b01a then
            local v25 = l__Classes__5.Util:convNumRange(l__Classes__5._x1a4ce4062771e36e._x0aa5621fbcbe69df._x4e699c18f52fc6a8, l__Classes__5._x150a19552e17c1ce._x9a090072a6522c65, l__Classes__5._x150a19552e17c1ce._xd7a9337de703427f, u18._x6142a368f111d36e._xe2f977586d0b5a9a, 0);
            if l__Classes__5._x1a4ce4062771e36e._x0aa5621fbcbe69df._x4e699c18f52fc6a8 < l__Classes__5._x150a19552e17c1ce._x980fed0cd99f1202 and l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude > 30 then
                u18._x2b99c131507c2bc3 = l__Classes__5.Util:numLerp(u18._x2b99c131507c2bc3, v25, 3 * v20);
            else
                u18._x2b99c131507c2bc3 = l__Classes__5.Util:numLerp(u18._x2b99c131507c2bc3, 0, 2 * v20);
            end;
            u18._xc458e9217c19f77b = u18._xc458e9217c19f77b + u18._x2b99c131507c2bc3;
        else
            u18._x2b99c131507c2bc3 = l__Classes__5.Util:numLerp(u18._x2b99c131507c2bc3, 0, 5 * v20);
            u18._xc458e9217c19f77b = u18._xc458e9217c19f77b + u18._x2b99c131507c2bc3;
        end;
        if l__Classes__5._x1a4ce4062771e36e._x951b8a58c97ff8ca._xeee95dd21a2f10e9 then
            local v26 = Vector3.new(l__Classes__5._x1a4ce4062771e36e._x951b8a58c97ff8ca._xadd91ba795aeb8fb.X, 0, l__Classes__5._x1a4ce4062771e36e._x951b8a58c97ff8ca._xadd91ba795aeb8fb.Z);
            local v27;
            if v26.Magnitude > 0 then
                v27 = v26.Unit;
            else
                v27 = l__Classes__5._x1a4ce4062771e36e._x951b8a58c97ff8ca._xadd91ba795aeb8fb.Unit;
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
            local v33 = math.acos(v32) / 1.5707963267948966 * u18._x6142a368f111d36e._xacc0c68288cc8833;
            u18._x7875db7191909311 = (workspace.CurrentCamera.CFrame.RightVector:Dot(v27) > 0 and -1 or 1) * v33;
        else
            u18._x7875db7191909311 = 0;
        end;
        local _, v34, _ = workspace.CurrentCamera.CFrame:ToOrientation();
        local v35 = math.deg((v34 - u3 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793);
        u3 = v34;
        local v36 = (l__Classes__5._x1a4ce4062771e36e._xaf40d0caf59277b4 - v35 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
        local function v40(p37) --[[ Line: 266 ]]
            -- upvalues: u18 (copy)
            local v38 = math.abs(p37);
            if v38 <= u18._x6142a368f111d36e._x75c71642a862bbf8 then
                return u18._x6142a368f111d36e._x5530d8b0d787d82c;
            elseif u18._x6142a368f111d36e._xfd6339ffd890586e <= v38 then
                return 0;
            else
                local v39 = (v38 - u18._x6142a368f111d36e._x75c71642a862bbf8) / (u18._x6142a368f111d36e._xfd6339ffd890586e - 0.5);
                if p37 > 0 then
                    return u18._x6142a368f111d36e._x5530d8b0d787d82c * (1 - v39 ^ 2);
                else
                    return u18._x6142a368f111d36e._x5530d8b0d787d82c * (1 - v39);
                end;
            end;
        end;
        local v41;
        if l__Classes__5._x1a4ce4062771e36e._x951b8a58c97ff8ca._xeee95dd21a2f10e9 and l__Classes__5._x1a4ce4062771e36e._x951b8a58c97ff8ca._x2eec252e734cb573 or l__Classes__5._xf1ad98d2d70b7408:_x93fd21adac562b5e("RIGHT").Held and l__Classes__5._xf1ad98d2d70b7408:_x93fd21adac562b5e("LEFT").Held then
            v41 = 0;
        elseif l__Classes__5._xf1ad98d2d70b7408:_x93fd21adac562b5e("RIGHT").Held and (not l__Classes__5._x1a4ce4062771e36e._xeefc92d109c9c85f and math.abs(v35) > 0.3) then
            v41 = -v40(v36);
        else
            v41 = (not l__Classes__5._xf1ad98d2d70b7408:_x93fd21adac562b5e("LEFT").Held or (l__Classes__5._x1a4ce4062771e36e._xeefc92d109c9c85f or math.abs(v35) <= 0.3)) and 0 or v40(v36);
        end;
        u18._x715dd1901820e45b = l__Classes__5.Util:numLerp(u18._x715dd1901820e45b, v41, 2 * v20);
    end;
end;
function u1._x3f8d063ef1080fdf(u42) --[[ Line: 300 ]]
    -- upvalues: l__Classes__5 (copy), l__Easer__8 (copy), l__Promise__9 (copy), l__Players__2 (copy), u5 (copy)
    l__Classes__5._x1a4ce4062771e36e._x6ca41a60efee84c4.slide_started.Event:Connect(function() --[[ Line: 301 ]]
        -- upvalues: u42 (copy), l__Easer__8 (ref)
        u42._x6072979e1970fdff.slide_began:Run();
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
        u42:_x67da5f869bceed5d(v43, true);
        v43.easer:Run();
    end);
    l__Classes__5._x1a4ce4062771e36e._x6ca41a60efee84c4.slide_ended.Event:Connect(function() --[[ Line: 324 ]]
        -- upvalues: u42 (copy)
        u42._x6072979e1970fdff.slide_ended:Run();
    end);
    l__Classes__5._x1a4ce4062771e36e._x6ca41a60efee84c4.wallride_ended.Event:Connect(function(p44) --[[ Line: 328 ]]
        -- upvalues: u42 (copy)
        if p44 == "wallkick_right" or p44 == "wallkick_left" then
            u42._x6072979e1970fdff.wall_kick:Run();
        end;
    end);
    l__Classes__5._x1a4ce4062771e36e._x6ca41a60efee84c4.dash_started.Event:Connect(function() --[[ Line: 334 ]]
        -- upvalues: u42 (copy), l__Promise__9 (ref)
        u42._x24c9d58646ed2710 = u42._x6142a368f111d36e._xb66c1aa5df35d452 + u42._x6142a368f111d36e._x1fb55c9d1cd72215;
        l__Promise__9.defer(function() --[[ Line: 336 ]]
            -- upvalues: u42 (ref)
            u42._x24c9d58646ed2710 = 0;
        end);
    end);
    l__Players__2.LocalPlayer.CharacterAdded:Connect(u5);
end;
function u1._x63bdd8a8b3f30f2c(u45, p46) --[[ Line: 345 ]]
    -- upvalues: l__Classes__5 (copy), l__UserInputService__12 (copy)
    if u45._x711166f3dabb680d then
    elseif l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7 == l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7 then
        if u45._xb7ba9dddb83899b5 then
        else
            local u47 = math.min(p46, 0.1);
            if l__Classes__5._x1a4ce4062771e36e._x7c0477cd83a7fb82 and l__Classes__5._x1a4ce4062771e36e._x7c0477cd83a7fb82:FindFirstChild("Head") then
                u45._xf5c5c2152a2970b7 = l__Classes__5._x1a4ce4062771e36e._x7c0477cd83a7fb82.Head.LocalTransparencyModifier == 1;
                if u45._xf5c5c2152a2970b7 and l__Classes__5._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
                    l__Classes__5._xe0e88f94014b801e._xa3fe4f9696ee59ce = true;
                else
                    l__Classes__5._xe0e88f94014b801e._xa3fe4f9696ee59ce = false;
                end;
            end;
            u45._xda381e3eaea72a8b = l__Classes__5.Util:Vec2ToUDim2(workspace.CurrentCamera.ViewportSize / 2);
            local l___x9e17087c104df3a7__19 = u45._x9e17087c104df3a7;
            local l___x5d3b27bfd0a12cd9__20 = u45._x5d3b27bfd0a12cd9;
            local l___x27ba4e1142eb1eb8__21 = u45._x27ba4e1142eb1eb8;
            local l___xd2e2ac21c271ebcf__22 = u45._xd2e2ac21c271ebcf;
            u45._x27ba4e1142eb1eb8 = 0;
            u45._xd2e2ac21c271ebcf = 0;
            u45._x57035e8df2813a5b = 0;
            u45._x9e17087c104df3a7 = 0;
            u45._x5d3b27bfd0a12cd9 = 0;
            u45._xbb83464e1451cd03 = 0;
            u45:_xdd9c71117ed0f27b(u47);
            local function v48() --[[ Line: 389 ]]
                -- upvalues: u45 (copy)
                u45._x12d03a44e8b02ddc.shake_spring_x:SetGoal(u45._x414decf2c19974b5 * u45._x6142a368f111d36e._x664e884fa371a7de);
                u45._x12d03a44e8b02ddc.shake_spring_y:SetGoal(u45._x414decf2c19974b5 * u45._x6142a368f111d36e._x664e884fa371a7de);
                u45._x12d03a44e8b02ddc.shake_spring_z:SetGoal(u45._x414decf2c19974b5);
                return CFrame.Angles(u45._x12d03a44e8b02ddc.shake_spring_x.Velocity, u45._x12d03a44e8b02ddc.shake_spring_y.Velocity, u45._x12d03a44e8b02ddc.shake_spring_z.Velocity);
            end;
            local function v52() --[[ Line: 402 ]]
                -- upvalues: u45 (copy), l__Classes__5 (ref), u47 (ref)
                for _, u49 in pairs(u45._xca68db72e68a5da9) do
                    if typeof(u49.value) == "number" then
                        if u49.cancel_when_zero and u49.value == 0 then
                            u49.promise:cancel();
                        else
                            task.spawn(function() --[[ Line: 408 ]]
                                -- upvalues: u45 (ref), u49 (copy)
                                local v50 = u45;
                                v50._xbb83464e1451cd03 = v50._xbb83464e1451cd03 + u49.value;
                            end);
                        end;
                    elseif u49.value:IsA("NumberValue") then
                        if u49.cancel_when_zero and u49.value.Value == 0 then
                            u49.promise:cancel();
                        else
                            task.spawn(function() --[[ Line: 416 ]]
                                -- upvalues: u45 (ref), u49 (copy)
                                local v51 = u45;
                                v51._xbb83464e1451cd03 = v51._xbb83464e1451cd03 + u49.value.Value;
                            end);
                        end;
                    end;
                end;
                workspace.CurrentCamera.FieldOfView = u45._x24c9d58646ed2710 ~= 0 and u45._x24c9d58646ed2710 or l__Classes__5.Util:numLerp(workspace.CurrentCamera.FieldOfView, u45._xc458e9217c19f77b, 8 * u47);
                local l__CurrentCamera__23 = workspace.CurrentCamera;
                l__CurrentCamera__23.FieldOfView = l__CurrentCamera__23.FieldOfView + u45._xbb83464e1451cd03;
            end;
            local function u62(p53, p54, p55) --[[ Line: 427 ]]
                -- upvalues: u45 (copy)
                if p53 == "roll" then
                    if p55 then
                        local v56 = u45;
                        v56._x57035e8df2813a5b = v56._x57035e8df2813a5b + p54;
                    else
                        local v57 = u45;
                        v57._x120f4a9aed8ade07 = v57._x120f4a9aed8ade07 + p54;
                    end;
                    return true;
                end;
                if p53 == "yaw" then
                    if p55 then
                        local v58 = u45;
                        v58._xd2e2ac21c271ebcf = v58._xd2e2ac21c271ebcf + p54;
                    else
                        local v59 = u45;
                        v59._x5d3b27bfd0a12cd9 = v59._x5d3b27bfd0a12cd9 + p54;
                    end;
                    return true;
                end;
                if p53 ~= "pitch" then
                    return false;
                end;
                if p55 then
                    local v60 = u45;
                    v60._x27ba4e1142eb1eb8 = v60._x27ba4e1142eb1eb8 + p54;
                else
                    local v61 = u45;
                    v61._x9e17087c104df3a7 = v61._x9e17087c104df3a7 + p54;
                end;
                return true;
            end;
            local function v68() --[[ Line: 454 ]]
                -- upvalues: u45 (copy), l__Classes__5 (ref), u62 (copy)
                for _, v63 in pairs(u45._x39bf6be6d6f47df2) do
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
            local function v73() --[[ Line: 529 ]]
                -- upvalues: l__Classes__5 (ref), u45 (copy)
                local l__X__25 = workspace.CurrentCamera.CFrame:VectorToObjectSpace(l__Classes__5._x1a4ce4062771e36e._xfd7cc994ccc60ad7).X;
                local v69 = math.clamp(l__X__25, -u45._x6142a368f111d36e._x3ea1f320462c67f0, u45._x6142a368f111d36e._x3ea1f320462c67f0);
                local v70 = l__Classes__5._x1a4ce4062771e36e._x0aa5621fbcbe69df._x3b8a76d53cd0b01a and -u45._x6142a368f111d36e._x13817c29fe7a26bc or (l__Classes__5._x1a4ce4062771e36e._x61456d34d31d41a7._xa40c4c49fe9fc7a3 and u45._x6142a368f111d36e._x13817c29fe7a26bc or u45._x6142a368f111d36e._xb74db00a80bcd35b);
                if v69 > 0 then
                    local v71 = l__Classes__5.Util:convNumRange(v69, 0, u45._x6142a368f111d36e._x3ea1f320462c67f0, 0, -v70);
                    u45._x7d7065c07b893f90 = l__Classes__5.Util:numLerp(u45._x7d7065c07b893f90, v71, 0.1);
                    return math.rad(u45._x7d7065c07b893f90);
                else
                    local v72 = l__Classes__5.Util:convNumRange(v69, 0, -u45._x6142a368f111d36e._x3ea1f320462c67f0, 0, v70);
                    u45._x7d7065c07b893f90 = l__Classes__5.Util:numLerp(u45._x7d7065c07b893f90, v72, 0.1);
                    return math.rad(u45._x7d7065c07b893f90);
                end;
            end;
            u45._x12d03a44e8b02ddc.wallride_spring:SetGoal(l__Classes__5.Util:numLerp(u45._x8e8b765431ffea09, u45._x7875db7191909311, 0.7));
            u45._x8e8b765431ffea09 = u45._x12d03a44e8b02ddc.wallride_spring.Offset;
            v52();
            u45._x9e17087c104df3a7 = u45._x9e17087c104df3a7 + (u45._x6072979e1970fdff.landing_rot.Position + u45._x6072979e1970fdff.slide_began.Position + u45._x6072979e1970fdff.slide_ended.Position + u45._x6072979e1970fdff.wall_kick.Position);
            u45._x120f4a9aed8ade07 = math.rad(u45._x8e8b765431ffea09) + v73() + u45._x715dd1901820e45b + u45._x57035e8df2813a5b;
            (function() --[[ Name: processCustomEases, Line 470 ]]
                -- upvalues: u45 (copy), u62 (copy)
                for _, v74 in pairs(u45._x5bc75b28ed085616) do
                    if not u62(v74.angle_type, v74.easer.Position, v74.external) then
                        warn("INVALID EASE ANGLE TYPE : " .. tostring(v74.angle_type));
                    end;
                end;
            end)();
            v68();
            (function() --[[ Name: processExternalAngles, Line 478 ]]
                -- upvalues: u45 (copy)
                for _, v75 in pairs(u45._x9aa3bce9db5771ce) do
                    local l__angle_type__26 = v75.angle_type;
                    local l__value__27 = v75.value;
                    local v76;
                    if l__angle_type__26 == "roll" then
                        local v77 = u45;
                        v77._x120f4a9aed8ade07 = v77._x120f4a9aed8ade07 + l__value__27;
                        v76 = true;
                    elseif l__angle_type__26 == "yaw" then
                        local v78 = u45;
                        v78._x5d3b27bfd0a12cd9 = v78._x5d3b27bfd0a12cd9 + l__value__27;
                        v76 = true;
                    elseif l__angle_type__26 == "pitch" then
                        local v79 = u45;
                        v79._x9e17087c104df3a7 = v79._x9e17087c104df3a7 + l__value__27;
                        v76 = true;
                    else
                        v76 = false;
                    end;
                    if not v76 then
                        warn("INVALID EASE ANGLE TYPE : " .. tostring(v75.angle_type));
                    end;
                end;
            end)();
            (function() --[[ Name: processHeadAnimations, Line 486 ]]
                -- upvalues: u45 (copy)
                local v80 = os.clock();
                local v81 = 0;
                local v82 = 0;
                local v83 = 0;
                for v84 = #u45._x81f32900ceb94713, 1, -1 do
                    local v85 = u45._x81f32900ceb94713[v84];
                    if v85.expiry < v80 or not v85.head then
                        table.remove(u45._x81f32900ceb94713, v84);
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
                v89._x120f4a9aed8ade07 = v89._x120f4a9aed8ade07 + math.rad(v81);
                local v90 = u45;
                v90._x5d3b27bfd0a12cd9 = v90._x5d3b27bfd0a12cd9 + math.rad(v82);
                local v91 = u45;
                v91._x9e17087c104df3a7 = v91._x9e17087c104df3a7 + math.rad(v83);
            end)();
            local l__FieldOfView__28 = workspace.CurrentCamera.FieldOfView;
            if l__FieldOfView__28 >= 80 then
                l__UserInputService__12.MouseDeltaSensitivity = 1;
            else
                local v92 = math.rad(l__FieldOfView__28 / 2);
                l__UserInputService__12.MouseDeltaSensitivity = math.tan(v92) / 0.8390996311772799;
            end;
            local v93 = v48();
            l__Classes__5._x1a4ce4062771e36e._x5b9cf15ca6de30f6.CameraOffset = (function() --[[ Name: getCameraOffset, Line 559 ]]
                -- upvalues: l__Classes__5 (ref), u45 (copy)
                local v94 = l__Classes__5._x1a4ce4062771e36e._x05f2f78e73855fef <= 0 and 0 or math.clamp(u45._xd301a5e801fa3e35 / l__Classes__5._x1a4ce4062771e36e._x05f2f78e73855fef, 0, 1);
                if not (l__Classes__5._x1a4ce4062771e36e._x932370e16d2f1e9d and l__Classes__5._x1a4ce4062771e36e._x3569d7da12ecb14c) then
                    return Vector3.new();
                end;
                local v95 = l__Classes__5._x1a4ce4062771e36e._x932370e16d2f1e9d:Lerp(l__Classes__5._x1a4ce4062771e36e._x3569d7da12ecb14c, v94);
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
            end)() + Vector3.new(0, u45._x6072979e1970fdff.landing_pos.Position, 0);
            local v97 = u45._x9e17087c104df3a7 - l___x9e17087c104df3a7__19;
            local v98 = u45._x5d3b27bfd0a12cd9 - l___x5d3b27bfd0a12cd9__20;
            local v99 = u45._x27ba4e1142eb1eb8 - l___x27ba4e1142eb1eb8__21;
            local v100 = u45._xd2e2ac21c271ebcf - l___xd2e2ac21c271ebcf__22;
            local _ = game.Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson;
            local l__CurrentCamera__30 = workspace.CurrentCamera;
            local l__CFrame__31 = l__CurrentCamera__30.CFrame;
            local v101, _, _ = l__CFrame__31:ToOrientation();
            local v102 = math.cos(v101);
            math.abs(v102);
            local v103 = (v97 + v99) * u45._xa5c0aad232b62bd1;
            local v104 = (v98 + v100) * u45._xa5c0aad232b62bd1;
            local l___x120f4a9aed8ade07__32 = u45._x120f4a9aed8ade07;
            local v105 = math.clamp(v101 + v103, -1.3962634015954636, 1.3962634015954636) - v101;
            l__CurrentCamera__30.CFrame = l__CFrame__31 * (CFrame.Angles(v105, v104, l___x120f4a9aed8ade07__32) * v93);
            u45._x54c3502e79e0b78a = u45:_x2166a83ba03aeba4();
        end;
    end;
end;
function u1._x78a2b39b32584aa1(u106, p107, p108, p109, p110, p111) --[[ Line: 647 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), l__Promise__9 (copy)
    local l__Animations__33 = l__ReplicatedStorage__3.Assets.Animations;
    local v112;
    if typeof(p111) == "Instance" then
        v112 = p111;
    else
        v112 = typeof(p111) == "string" and l__Animations__33:FindFirstChild(p111);
        if not v112 then
            if typeof(p107) == "string" then
                v112 = l__Animations__33:FindFirstChild(p107);
            else
                v112 = nil;
            end;
        end;
    end;
    if not v112 then
        warn("COULD NOT FIND VIEWMODEL HEAD ANIMATION FOLDER FOR : ", p111 or p107);
        return l__Promise__9.resolve();
    end;
    local v113 = v112:FindFirstChild(p108);
    if not v113 then
        warn("COULD NOT FIND VIEWMODEL HEAD ANIMATION : ", p108, v112);
        return l__Promise__9.resolve();
    end;
    local u114 = u106._x3e9becf9b9215745:Clone();
    u114.Parent = game.Workspace:WaitForChild("Effects");
    u114:PivotTo(CFrame.new(50000, 50000, 50000));
    local l__Head__34 = u114.Head;
    local u115 = u114.AnimationController.Animator:LoadAnimation(v113);
    local u116 = {
        roll = 0,
        yaw = 0,
        pitch = 0,
        cleanuped = false,
        head = l__Head__34,
        base_cf = l__Head__34.CFrame,
        weight = p109,
        expiry = os.clock() + p110,
        track = u115
    };
    table.insert(u106._x81f32900ceb94713, u116);
    u115:Play();
    u115.Stopped:Connect(function() --[[ Name: cleanup, Line 686 ]]
        -- upvalues: u116 (copy), u115 (copy), u114 (copy), u106 (copy)
        if u116.cleanuped then
        else
            u116.cleanuped = true;
            u115:Stop();
            u114:Destroy();
            local v117 = table.find(u106._x81f32900ceb94713, u116);
            if v117 then
                table.remove(u106._x81f32900ceb94713, v117);
            end;
        end;
    end);
    local v118 = l__Promise__9.delay(p110);
    v118:finally(function() --[[ Line: 700 ]]
        -- upvalues: u116 (copy), u115 (copy), u114 (copy), u106 (copy)
        if u116.cleanuped then
        else
            u116.cleanuped = true;
            u115:Stop();
            u114:Destroy();
            local v119 = table.find(u106._x81f32900ceb94713, u116);
            if v119 then
                table.remove(u106._x81f32900ceb94713, v119);
            end;
        end;
    end);
    return v118;
end;
function u1._x2166a83ba03aeba4(p120) --[[ Line: 708 ]]
    local l__CurrentCamera__35 = game.Workspace.CurrentCamera;
    local l__ViewportSize__36 = l__CurrentCamera__35.ViewportSize;
    local v121 = l__ViewportSize__36.Y / 2;
    local v122 = math.rad(l__CurrentCamera__35.FieldOfView) / 2;
    local v123 = v121 / math.tan(v122);
    local v124 = v123 * math.tan(p120._x5d3b27bfd0a12cd9 * p120._xa5c0aad232b62bd1);
    local v125 = v123 * math.tan(-p120._x9e17087c104df3a7 * p120._xa5c0aad232b62bd1);
    return UDim2.fromOffset(l__ViewportSize__36.X / 2 + v124, l__ViewportSize__36.Y / 2 - v125);
end;
function u1._x67da5f869bceed5d(u126, u127, p128, p129) --[[ Line: 723 ]]
    table.insert(u126._x5bc75b28ed085616, u127);
    if p128 then
        u127.external = p129;
        u127.easer.destroy_once_completed = true;
        u127.easer.Completed.Event:Once(function() --[[ Line: 728 ]]
            -- upvalues: u126 (copy), u127 (copy)
            local v130 = table.find(u126._x5bc75b28ed085616, u127);
            if v130 then
                table.remove(u126._x5bc75b28ed085616, v130);
            end;
        end);
    end;
end;
function u1._x37e1f658b04f8d69(u131, p132, p133, p134, p135, u136, p137, p138, p139, p140) --[[ Line: 737 ]]
    -- upvalues: u2 (copy), l__Spring__7 (copy), l__Promise__9 (copy)
    local u141 = {
        decay_time = u136,
        cancel_when_zero = p137 or false,
        springs = {},
        use_normal_angles = p138 or false,
        start_time = os.clock()
    };
    for _, v142 in p135 do
        local v143 = {
            angle_type = v142
        };
        local v144 = p140 and p133 and p133 or u2:NextNumber(p133 - p133 * 0.05, p133 + p133 * 0.05);
        local v145 = p140 and p134 and p134 or u2:NextNumber(p134 - p134 * 0.05, p134 + p134 * 0.05);
        v143.spring = l__Spring__7.fromFrequency(1, v144, v145);
        local v146 = p139 and p132 and p132 or ({ p132, -p132 })[math.random(1, 2)];
        local v147 = p140 and v146 and v146 or u2:NextNumber(v146 - v146 * 0.05, v146 + v146 * 0.05);
        if v142 == "roll" then
            v143.spring:AddVelocity(v147 / 10);
        elseif v142 == "pitch" then
            v143.spring:AddVelocity(v147 / 100);
        elseif v142 == "yaw" then
            v143.spring:AddVelocity(v147 / 160);
        end;
        table.insert(u141.springs, v143);
    end;
    table.insert(u131._x39bf6be6d6f47df2, u141);
    local v152 = l__Promise__9.new(function(u148, _, p149) --[[ Line: 766 ]]
        -- upvalues: u131 (copy), u141 (copy), u136 (copy)
        task.delay(u136, function() --[[ Line: 774 ]]
            -- upvalues: u131 (ref), u141 (ref), u148 (copy)
            local v150 = table.find(u131._x39bf6be6d6f47df2, u141);
            if v150 then
                table.remove(u131._x39bf6be6d6f47df2, v150);
            end;
            u148();
        end);
        p149(function() --[[ Line: 779 ]]
            -- upvalues: u131 (ref), u141 (ref)
            local v151 = table.find(u131._x39bf6be6d6f47df2, u141);
            if v151 then
                table.remove(u131._x39bf6be6d6f47df2, v151);
            end;
        end);
    end);
    u141.promise = v152;
    return v152, u141;
end;
function u1._x145395062c6646e5(u153, u154) --[[ Line: 787 ]]
    -- upvalues: l__Promise__9 (copy)
    table.insert(u153._xca68db72e68a5da9, u154);
    local v157 = l__Promise__9.new(function(_, _, p155) --[[ Line: 789 ]]
        -- upvalues: u154 (copy), u153 (copy)
        p155(function() --[[ Line: 790 ]]
            -- upvalues: u154 (ref), u153 (ref)
            if u154.value:IsA("NumberValue") then
                u154.value:Destroy();
            end;
            local v156 = table.find(u153._xca68db72e68a5da9, u154);
            if v156 then
                table.remove(u153._xca68db72e68a5da9, v156);
            end;
        end);
    end);
    u154.promise = v157;
    return v157;
end;
function u1._xefd1283dc89f1857(u158, u159) --[[ Line: 804 ]]
    -- upvalues: l__Promise__9 (copy)
    return l__Promise__9.new(function(_, _, p160) --[[ Line: 805 ]]
        -- upvalues: u158 (copy), u159 (copy)
        table.insert(u158._x9aa3bce9db5771ce, u159);
        p160(function() --[[ Line: 808 ]]
            -- upvalues: u158 (ref), u159 (ref)
            local v161 = table.find(u158._x9aa3bce9db5771ce, u159);
            if v161 then
                table.remove(u158._x9aa3bce9db5771ce, v161);
            end;
        end);
    end);
end;
function u1._x061224a5e52c670b(p162) --[[ Line: 817 ]]
    return workspace.CurrentCamera:ViewportPointToRay(p162._x54c3502e79e0b78a.X.Offset, p162._x54c3502e79e0b78a.Y.Offset, 0).Direction;
end;
local u163 = {};
function u1._x075b6d665b92daa4(p164) --[[ Line: 825 ]]
    -- upvalues: l__Context__6 (copy), l__Classes__5 (copy), l___xc1176ac192711e72__13 (copy), u163 (copy)
    if l__Context__6.is_gameplay_mode and l__Classes__5._xe0e88f94014b801e then
        if l__Classes__5._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
            if p164._xb7ba9dddb83899b5 then
                l__Classes__5._xf1ad98d2d70b7408:_x235841831c72ea6f(false);
                l__Classes__5._xe0e88f94014b801e._xa3fe4f9696ee59ce = true;
                p164._xb7ba9dddb83899b5 = false;
                l___xc1176ac192711e72__13:_xa00c0e9c56965c55();
                for v165, v166 in u163 do
                    v165.Enabled = v166;
                end;
            else
                l__Classes__5._xf1ad98d2d70b7408:_x235841831c72ea6f(true);
                l__Classes__5._xe0e88f94014b801e._xa3fe4f9696ee59ce = false;
                p164._xb7ba9dddb83899b5 = true;
                l___xc1176ac192711e72__13:_xb21d31a7208a6ebb();
                for _, u167 in game.Players.LocalPlayer.PlayerGui:GetChildren() do
                    if u167.Name ~= "CommandUI" then
                        pcall(function() --[[ Line: 847 ]]
                            -- upvalues: u163 (ref), u167 (copy)
                            u163[u167] = u167.Enabled;
                            u167.Enabled = false;
                        end);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._x44bcd6af41218f92(u168) --[[ Line: 855 ]]
    -- upvalues: l__PlaceContext__11 (copy), l__RunService__1 (copy), l__Packets__10 (copy), l__Players__2 (copy), u11 (copy), u9 (copy), l__Context__6 (copy), l__Classes__5 (copy)
    print(l__PlaceContext__11.get());
    if l__PlaceContext__11.get().effective_mode ~= l__PlaceContext__11.EffectiveModes.PUBLIC_LOBBY and not l__RunService__1:IsStudio() then
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
    end;
    l__Packets__10._x65d117c21ab35208.OnClientEvent:Connect(function() --[[ Line: 861 ]]
        -- upvalues: u168 (copy)
        u168:_x075b6d665b92daa4();
    end);
    l__Players__2.LocalPlayer.CharacterAdded:Connect(u11);
    if l__Players__2.LocalPlayer.Character then
        local l__Character__37 = l__Players__2.LocalPlayer.Character;
        task.spawn(function() --[[ Line: 75 ]]
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
        task.defer(function() --[[ Line: 874 ]]
            -- upvalues: u168 (copy), l__Classes__5 (ref)
            u168:_x3f8d063ef1080fdf();
            l__Classes__5.Util:bindToRenderStep("camera_update", u168._x77180ae41c82e39b, function(p169) --[[ Line: 877 ]]
                -- upvalues: u168 (ref)
                u168:_x63bdd8a8b3f30f2c(p169);
            end);
        end);
    end;
end;
return u1;
