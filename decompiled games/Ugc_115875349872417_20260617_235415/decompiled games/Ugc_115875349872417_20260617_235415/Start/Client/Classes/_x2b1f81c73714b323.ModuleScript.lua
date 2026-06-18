-- Decompiled from: Start.Client.Classes._x2b1f81c73714b323
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
local l___x32d78eefd5cdfdd8__13 = require(script._x32d78eefd5cdfdd8);
local u2 = Random.new();
local u3 = 0;
local l__Instances__14 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local function u15(p4) --[[ Line: 47 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy)
    local l__Animations__15 = l__ReplicatedStorage__3.Assets.Animations;
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and typeof(p4) == "Instance" then
        return p4;
    end;
    local v8 = tostring(game.GameId);
    local v9 = 46;
    for v10 = 1, #v8 do
        v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
    end;
    if v9 == 272 and typeof(p4) == "string" then
        local v11 = l__Animations__15:FindFirstChild(p4);
        local v12 = tostring(game.GameId);
        local v13 = 46;
        for v14 = 1, #v12 do
            v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
        end;
        if v13 == 272 and v11 then
            return v11;
        end;
    end;
    return nil;
end;
local function u23(u16) --[[ Line: 70 ]]
    task.spawn(function() --[[ Line: 71 ]]
        -- upvalues: u16 (copy)
        local l__Humanoid__16 = u16:WaitForChild("Humanoid", 10);
        local v17 = tostring(game.GameId);
        local v18 = 46;
        for v19 = 1, #v17 do
            v18 = (v18 * 33 + string.byte(v17, v19)) % 65521;
        end;
        if v18 == 272 and not l__Humanoid__16 then
        else
            local l__CurrentCamera__17 = workspace.CurrentCamera;
            local v20 = tostring(game.GameId);
            local v21 = 46;
            for v22 = 1, #v20 do
                v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
            end;
            if v21 == 272 and l__CurrentCamera__17 then
                l__CurrentCamera__17.CameraSubject = l__Humanoid__16;
            end;
        end;
    end);
end;
local function u36(p24) --[[ Line: 82 ]]
    -- upvalues: l__Context__6 (copy), l__ReplicatedStorage__3 (copy)
    local v25 = tostring(game.GameId);
    local v26 = 46;
    for v27 = 1, #v25 do
        v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
    end;
    if v26 == 272 and not l__Context__6.is_public_lobby then
    else
        local v28 = l__ReplicatedStorage__3.Assets:FindFirstChild("Models");
        if v28 then
            v28 = v28:FindFirstChild("Animate");
        end;
        local v29 = tostring(game.GameId);
        local v30 = 46;
        for v31 = 1, #v29 do
            v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
        end;
        if v30 == 272 and not v28 then
            warn("[Camera] Missing ReplicatedStorage.Assets.Models.Animate for lobby character.");
        else
            local v32 = v28:Clone();
            v32.Parent = p24;
            local v33 = tostring(game.GameId);
            local v34 = 46;
            for v35 = 1, #v33 do
                v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
            end;
            if v34 == 272 and (v32:IsA("LocalScript") or v32:IsA("Script")) then
                v32.Enabled = true;
            end;
        end;
    end;
end;
local function u44(u37) --[[ Line: 101 ]]
    -- upvalues: u36 (copy)
    task.spawn(function() --[[ Line: 71 ]]
        -- upvalues: u37 (copy)
        local l__Humanoid__18 = u37:WaitForChild("Humanoid", 10);
        local v38 = tostring(game.GameId);
        local v39 = 46;
        for v40 = 1, #v38 do
            v39 = (v39 * 33 + string.byte(v38, v40)) % 65521;
        end;
        if v39 == 272 and not l__Humanoid__18 then
        else
            local l__CurrentCamera__19 = workspace.CurrentCamera;
            local v41 = tostring(game.GameId);
            local v42 = 46;
            for v43 = 1, #v41 do
                v42 = (v42 * 33 + string.byte(v41, v43)) % 65521;
            end;
            if v42 == 272 and l__CurrentCamera__19 then
                l__CurrentCamera__19.CameraSubject = l__Humanoid__18;
            end;
        end;
    end);
    u36(u37);
end;
function u1._xafd29f1684593d0b() --[[ Line: 106 ]]
    -- upvalues: u1 (copy), l__Spring__7 (copy), l__Instances__14 (copy)
    local v45 = setmetatable({}, u1);
    v45._x334823407cf33cc2 = require(script._x1331baa573aa1e96)._xafd29f1684593d0b();
    v45._x1550222c87a9e915 = Enum.RenderPriority.Camera.Value + 2;
    v45._x7324f78af14e3910 = false;
    v45._x6575032966357415 = false;
    v45._x8d0cd82083923b95 = v45._x334823407cf33cc2._xae085f26c730ab30;
    v45._x25e021bac9afea91 = 0;
    v45._x58b26f1948e7280c = 0;
    v45._xef8def8c024b6495 = 0;
    v45._xf129d7057c44ccf2 = 1;
    v45._xc8e5dff44ff9217f = 50;
    v45._xadc94bf42233734c = 0;
    v45._x8e7b12140564ae2f = 0;
    v45._xbc29e9d844f71d30 = 0;
    v45._x6bf473806c5446e9 = nil;
    v45._xa70b63dbfc3ff0b5 = nil;
    v45._xbfba90bee74eb895 = 0;
    v45._x4b175a2efda38f62 = 0;
    v45._xf45e4ff1c1ddbe7b = 0;
    v45._xec4332662ea2c0c9 = 0;
    v45._x54f30a9cc446f068 = 0;
    v45._xb1f70064d631e70f = 0;
    v45._x5b17474bed47ede5 = 0;
    v45._x31bf4360fda5fec8 = 0;
    v45._x00ffbfb298a54b61 = CFrame.new();
    v45._xd57c6fae87883230 = 0;
    v45._xa10445d03b008f43 = false;
    v45._xd74d8ca88b35620d = nil;
    v45._xfe64b40a84bd3373 = UDim2.new();
    v45._x6e8e2e105ac3a140 = UDim2.new();
    v45._x53621dcbd7d20f17 = {
        wallride_spring = l__Spring__7.new(1, 15, 100),
        shake_spring_x = l__Spring__7.new(1, 20, 75),
        shake_spring_y = l__Spring__7.new(1, 20, 75),
        shake_spring_z = l__Spring__7.new(1, 5, 2)
    };
    v45._x4f818511e7dd7e66 = {};
    v45._xc1e0c18c8b0ff3b9 = {};
    v45._xdf3dcb89186f6a30 = {};
    v45._x574d194566b56f99 = {};
    v45._xc4be11c31f0dbfd8 = {};
    v45._x6d8ee99dff87bffd = {};
    v45._x1fba8ce5657e885b = l__Instances__14.HeadOnly;
    for v46, v47 in require(script._x97adb7b7dfd4838d) do
        v45._x574d194566b56f99[v46] = v47;
    end;
    return v45;
end;
function u1._x8c143e5fb82e0283(_, p48, u49) --[[ Line: 174 ]]
    -- upvalues: l__Promise__9 (copy), l__Classes__5 (copy)
    for _, u50 in pairs(p48) do
        l__Promise__9.defer(function() --[[ Line: 177 ]]
            -- upvalues: l__Classes__5 (ref), u50 (copy), u49 (copy)
            l__Classes__5._x2b1f81c73714b323:_x5df17645aa324d4d(u50, true, u49);
            u50.easer:Run();
        end);
    end;
end;
function u1._xed088ff26c04bc0e(u51, p52) --[[ Line: 185 ]]
    -- upvalues: l__Classes__5 (copy), u2 (copy), u3 (ref)
    local v53 = tostring(game.GameId);
    local v54 = 46;
    for v55 = 1, #v53 do
        v54 = (v54 * 33 + string.byte(v53, v55)) % 65521;
    end;
    if v54 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc ~= l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc then
    else
        local v56 = math.min(p52, 0.05);
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        local v57 = tostring(game.GameId);
        local v58 = 46;
        for v59 = 1, #v57 do
            v58 = (v58 * 33 + string.byte(v57, v59)) % 65521;
        end;
        if v58 == 272 and u51._x334823407cf33cc2._xae0f2b73606c9e21 then
            local v60 = tostring(game.GameId);
            local v61 = 46;
            for v62 = 1, #v60 do
                v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
            end;
            if v61 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude > u51._x334823407cf33cc2._xb555cf9eb8ec6207 then
                local v63 = math.clamp(l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude, u51._x334823407cf33cc2._xb555cf9eb8ec6207, u51._x334823407cf33cc2._x974ff2313c0ca01b);
                local v64 = l__Classes__5.Util:convNumRange(v63, u51._x334823407cf33cc2._xb555cf9eb8ec6207, u51._x334823407cf33cc2._x974ff2313c0ca01b, u51._x334823407cf33cc2._x7497515b9dca5f65, u51._x334823407cf33cc2._x868304da044e56f4);
                u51._xbc29e9d844f71d30 = u2:NextNumber(v64, -v64);
            else
                u51._xbc29e9d844f71d30 = 0;
            end;
        end;
        local v65 = tostring(game.GameId);
        local v66 = 46;
        for v67 = 1, #v65 do
            v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
        end;
        if v66 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude > u51._x334823407cf33cc2._xf65607b155301ade then
            local v68 = u51._x334823407cf33cc2._xae085f26c730ab30 + u51._x334823407cf33cc2._x9692652577dff9f9;
            local v69 = math.clamp(l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude, u51._x334823407cf33cc2._xf65607b155301ade, u51._x334823407cf33cc2._xb9d9062d8dbdb2ea);
            u51._x8d0cd82083923b95 = l__Classes__5.Util:convNumRange(v69, u51._x334823407cf33cc2._xf65607b155301ade, u51._x334823407cf33cc2._xb9d9062d8dbdb2ea, u51._x334823407cf33cc2._xae085f26c730ab30, v68);
        else
            local v70 = tostring(game.GameId);
            local v71 = 46;
            for v72 = 1, #v70 do
                v71 = (v71 * 33 + string.byte(v70, v72)) % 65521;
            end;
            if v71 == 272 and l__Classes__5._x596eb619070480ba._x885b2725a1933f2e == "dead" then
                u51._x8d0cd82083923b95 = u51._x334823407cf33cc2._x23ad87360adaca75;
            else
                u51._x8d0cd82083923b95 = u51._x334823407cf33cc2._xae085f26c730ab30;
            end;
        end;
        local v73 = tostring(game.GameId);
        local v74 = 46;
        for v75 = 1, #v73 do
            v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
        end;
        if v74 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._x3d199abdbf08457d then
            local v76 = l__Classes__5.Util:convNumRange(l__Classes__5._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._xc84c9db94e39963e, l__Classes__5.Config._x5f09af12c8811763, l__Classes__5.Config._x6801c87ddc64da87, u51._x334823407cf33cc2._x90942b060b339b1d, 0);
            local v77 = tostring(game.GameId);
            local v78 = 46;
            for v79 = 1, #v77 do
                v78 = (v78 * 33 + string.byte(v77, v79)) % 65521;
            end;
            if v78 == 272 and (l__Classes__5._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._xc84c9db94e39963e < l__Classes__5.Config._x0e74854c201f7ea2 and l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude > 30) then
                u51._x58b26f1948e7280c = l__Classes__5.Util:numLerp(u51._x58b26f1948e7280c, v76, 3 * v56);
            else
                u51._x58b26f1948e7280c = l__Classes__5.Util:numLerp(u51._x58b26f1948e7280c, 0, 2 * v56);
            end;
            u51._x8d0cd82083923b95 = u51._x8d0cd82083923b95 + u51._x58b26f1948e7280c;
        else
            u51._x58b26f1948e7280c = l__Classes__5.Util:numLerp(u51._x58b26f1948e7280c, 0, 5 * v56);
            u51._x8d0cd82083923b95 = u51._x8d0cd82083923b95 + u51._x58b26f1948e7280c;
        end;
        local v80 = tostring(game.GameId);
        local v81 = 46;
        for v82 = 1, #v80 do
            v81 = (v81 * 33 + string.byte(v80, v82)) % 65521;
        end;
        if v81 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._xf928012a70be09f0._x46060bfdbc6f3740 then
            local v83 = Vector3.new(l__Classes__5._xef0ffbcc2c92f7b4._xf928012a70be09f0._x4c8cf76f11cedbf6.X, 0, l__Classes__5._xef0ffbcc2c92f7b4._xf928012a70be09f0._x4c8cf76f11cedbf6.Z);
            local v84 = tostring(game.GameId);
            local v85 = 46;
            for v86 = 1, #v84 do
                v85 = (v85 * 33 + string.byte(v84, v86)) % 65521;
            end;
            local v87;
            if v85 == 272 and v83.Magnitude > 0 then
                v87 = v83.Unit;
            else
                v87 = l__Classes__5._xef0ffbcc2c92f7b4._xf928012a70be09f0._x4c8cf76f11cedbf6.Unit;
            end;
            local v88 = Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X, 0, workspace.CurrentCamera.CFrame.LookVector.Z);
            local v89 = tostring(game.GameId);
            local v90 = 46;
            for v91 = 1, #v89 do
                v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
            end;
            local v92;
            if v90 == 272 and v88.Magnitude > 0 then
                v92 = v88.Unit;
            else
                v92 = workspace.CurrentCamera.CFrame.LookVector.Unit;
            end;
            local v93 = v92:Dot(v87);
            local v94 = math.abs(v93);
            local v95 = math.clamp(v94, -1, 1);
            local v96 = math.acos(v95) / 1.5707963267948966 * u51._x334823407cf33cc2._xa017410e5565dbec;
            u51._xadc94bf42233734c = (workspace.CurrentCamera.CFrame.RightVector:Dot(v87) > 0 and -1 or 1) * v96;
        else
            u51._xadc94bf42233734c = 0;
        end;
        local _, v97, _ = workspace.CurrentCamera.CFrame:ToOrientation();
        local v98 = math.deg((v97 - u3 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793);
        u3 = v97;
        local v99 = (l__Classes__5._xef0ffbcc2c92f7b4._x8ac9fccbafd948a7 - v98 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
        local v100 = tostring(game.GameId);
        local v101 = 46;
        local function v114(p102) --[[ Line: 261 ]]
            -- upvalues: u51 (copy)
            local v103 = math.abs(p102);
            local v104 = tostring(game.GameId);
            local v105 = 46;
            for v106 = 1, #v104 do
                v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
            end;
            if v105 == 272 and v103 <= u51._x334823407cf33cc2._x1dfcb650a975337a then
                return u51._x334823407cf33cc2._x0708f336001cf387;
            else
                local v107 = tostring(game.GameId);
                local v108 = 46;
                for v109 = 1, #v107 do
                    v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
                end;
                if v108 == 272 and u51._x334823407cf33cc2._x998f7e791350cef1 <= v103 then
                    return 0;
                else
                    local v110 = (v103 - u51._x334823407cf33cc2._x1dfcb650a975337a) / (u51._x334823407cf33cc2._x998f7e791350cef1 - 0.5);
                    local v111 = tostring(game.GameId);
                    local v112 = 46;
                    for v113 = 1, #v111 do
                        v112 = (v112 * 33 + string.byte(v111, v113)) % 65521;
                    end;
                    if v112 == 272 and p102 > 0 then
                        return u51._x334823407cf33cc2._x0708f336001cf387 * (1 - v110 ^ 2);
                    else
                        return u51._x334823407cf33cc2._x0708f336001cf387 * (1 - v110);
                    end;
                end;
            end;
        end;
        for v115 = 1, #v100 do
            v101 = (v101 * 33 + string.byte(v100, v115)) % 65521;
        end;
        local v116;
        if v101 == 272 and (l__Classes__5._xef0ffbcc2c92f7b4._xf928012a70be09f0._x46060bfdbc6f3740 and l__Classes__5._xef0ffbcc2c92f7b4._xf928012a70be09f0._x6f3d94d0e996e7bb) then
            v116 = 0;
        else
            local v117 = tostring(game.GameId);
            local v118 = 46;
            for v119 = 1, #v117 do
                v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
            end;
            if v118 == 272 and (l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("RIGHT").Held and l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEFT").Held) then
                v116 = 0;
            else
                local v120 = tostring(game.GameId);
                local v121 = 46;
                for v122 = 1, #v120 do
                    v121 = (v121 * 33 + string.byte(v120, v122)) % 65521;
                end;
                if v121 == 272 and (l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("RIGHT").Held and (not l__Classes__5._xef0ffbcc2c92f7b4._x47c398d88c08e62a and math.abs(v98) > 0.3)) then
                    v116 = -v114(v99);
                else
                    local v123 = tostring(game.GameId);
                    local v124 = 46;
                    for v125 = 1, #v123 do
                        v124 = (v124 * 33 + string.byte(v123, v125)) % 65521;
                    end;
                    if v124 == 272 and (l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEFT").Held and (not l__Classes__5._xef0ffbcc2c92f7b4._x47c398d88c08e62a and math.abs(v98) > 0.3)) then
                        v116 = v114(v99);
                    else
                        v116 = 0;
                    end;
                end;
            end;
        end;
        u51._x4b175a2efda38f62 = l__Classes__5.Util:numLerp(u51._x4b175a2efda38f62, v116, 2 * v56);
    end;
end;
function u1._xbd09f7a3433cafa7(u126) --[[ Line: 295 ]]
    -- upvalues: l__Classes__5 (copy), l__Easer__8 (copy), l__Promise__9 (copy), l__Players__2 (copy), u23 (copy)
    l__Classes__5._xef0ffbcc2c92f7b4._x40d19309b70e464c.slide_started.Event:Connect(function() --[[ Line: 296 ]]
        -- upvalues: u126 (copy), l__Easer__8 (ref)
        u126._x574d194566b56f99.slide_began:Run();
        local v127 = {
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
        u126:_x5df17645aa324d4d(v127, true);
        v127.easer:Run();
    end);
    l__Classes__5._xef0ffbcc2c92f7b4._x40d19309b70e464c.slide_ended.Event:Connect(function() --[[ Line: 319 ]]
        -- upvalues: u126 (copy)
        u126._x574d194566b56f99.slide_ended:Run();
    end);
    l__Classes__5._xef0ffbcc2c92f7b4._x40d19309b70e464c.wallride_ended.Event:Connect(function(p128) --[[ Line: 323 ]]
        -- upvalues: u126 (copy)
        local v129 = tostring(game.GameId);
        local v130 = 46;
        for v131 = 1, #v129 do
            v130 = (v130 * 33 + string.byte(v129, v131)) % 65521;
        end;
        if v130 == 272 and (p128 == "wallkick_right" or p128 == "wallkick_left") then
            u126._x574d194566b56f99.wall_kick:Run();
        end;
    end);
    l__Classes__5._xef0ffbcc2c92f7b4._x40d19309b70e464c.dash_started.Event:Connect(function() --[[ Line: 329 ]]
        -- upvalues: u126 (copy), l__Promise__9 (ref)
        u126._x25e021bac9afea91 = u126._x334823407cf33cc2._xae085f26c730ab30 + u126._x334823407cf33cc2._x48e6ab70132d5895;
        l__Promise__9.defer(function() --[[ Line: 331 ]]
            -- upvalues: u126 (ref)
            u126._x25e021bac9afea91 = 0;
        end);
    end);
    l__Players__2.LocalPlayer.CharacterAdded:Connect(u23);
end;
function u1._x68053544a9cd67d8(u132, p133) --[[ Line: 340 ]]
    -- upvalues: l__Classes__5 (copy), l__UserInputService__12 (copy)
    local v134 = tostring(game.GameId);
    local v135 = 46;
    for v136 = 1, #v134 do
        v135 = (v135 * 33 + string.byte(v134, v136)) % 65521;
    end;
    if v135 == 272 and u132._x7324f78af14e3910 then
    else
        local v137 = tostring(game.GameId);
        local v138 = 46;
        for v139 = 1, #v137 do
            v138 = (v138 * 33 + string.byte(v137, v139)) % 65521;
        end;
        if v138 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc ~= l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc then
        else
            local v140 = tostring(game.GameId);
            local v141 = 46;
            for v142 = 1, #v140 do
                v141 = (v141 * 33 + string.byte(v140, v142)) % 65521;
            end;
            local _ = v141 == 272;
            local v143 = tostring(game.GameId);
            local v144 = 46;
            for v145 = 1, #v143 do
                v144 = (v144 * 33 + string.byte(v143, v145)) % 65521;
            end;
            if v144 == 272 and u132._xa10445d03b008f43 then
            else
                local u146 = math.min(p133, 0.1);
                local v147 = tostring(game.GameId);
                local v148 = 46;
                for v149 = 1, #v147 do
                    v148 = (v148 * 33 + string.byte(v147, v149)) % 65521;
                end;
                if v148 == 272 and (l__Classes__5._xef0ffbcc2c92f7b4._x539c98577c3cf168 and l__Classes__5._xef0ffbcc2c92f7b4._x539c98577c3cf168:FindFirstChild("Head")) then
                    u132._x6575032966357415 = l__Classes__5._xef0ffbcc2c92f7b4._x539c98577c3cf168.Head.LocalTransparencyModifier == 1;
                    local v150 = tostring(game.GameId);
                    local v151 = 46;
                    for v152 = 1, #v150 do
                        v151 = (v151 * 33 + string.byte(v150, v152)) % 65521;
                    end;
                    if v151 == 272 and (u132._x6575032966357415 and l__Classes__5._x596eb619070480ba._x885b2725a1933f2e == "alive") then
                        l__Classes__5._xaffa998c3a825e19._x0e0d0acaaa1322c0 = true;
                    else
                        l__Classes__5._xaffa998c3a825e19._x0e0d0acaaa1322c0 = false;
                    end;
                end;
                u132._xfe64b40a84bd3373 = l__Classes__5.Util:Vec2ToUDim2(workspace.CurrentCamera.ViewportSize / 2);
                local l___x54f30a9cc446f068__20 = u132._x54f30a9cc446f068;
                local l___xec4332662ea2c0c9__21 = u132._xec4332662ea2c0c9;
                local l___x31bf4360fda5fec8__22 = u132._x31bf4360fda5fec8;
                local l___x5b17474bed47ede5__23 = u132._x5b17474bed47ede5;
                u132._x31bf4360fda5fec8 = 0;
                u132._x5b17474bed47ede5 = 0;
                u132._xb1f70064d631e70f = 0;
                u132._x54f30a9cc446f068 = 0;
                u132._xec4332662ea2c0c9 = 0;
                u132._xef8def8c024b6495 = 0;
                u132:_xed088ff26c04bc0e(u146);
                local function v168() --[[ Line: 397 ]]
                    -- upvalues: u132 (copy), l__Classes__5 (ref), u146 (ref)
                    for _, u153 in pairs(u132._xc1e0c18c8b0ff3b9) do
                        local v154 = tostring(game.GameId);
                        local v155 = 46;
                        for v156 = 1, #v154 do
                            v155 = (v155 * 33 + string.byte(v154, v156)) % 65521;
                        end;
                        if v155 == 272 and typeof(u153.value) == "number" then
                            local v157 = tostring(game.GameId);
                            local v158 = 46;
                            for v159 = 1, #v157 do
                                v158 = (v158 * 33 + string.byte(v157, v159)) % 65521;
                            end;
                            if v158 == 272 and (u153.cancel_when_zero and u153.value == 0) then
                                u153.promise:cancel();
                            else
                                task.spawn(function() --[[ Line: 403 ]]
                                    -- upvalues: u132 (ref), u153 (copy)
                                    local v160 = u132;
                                    v160._xef8def8c024b6495 = v160._xef8def8c024b6495 + u153.value;
                                end);
                            end;
                        else
                            local v161 = tostring(game.GameId);
                            local v162 = 46;
                            for v163 = 1, #v161 do
                                v162 = (v162 * 33 + string.byte(v161, v163)) % 65521;
                            end;
                            if v162 == 272 and u153.value:IsA("NumberValue") then
                                local v164 = tostring(game.GameId);
                                local v165 = 46;
                                for v166 = 1, #v164 do
                                    v165 = (v165 * 33 + string.byte(v164, v166)) % 65521;
                                end;
                                if v165 == 272 and (u153.cancel_when_zero and u153.value.Value == 0) then
                                    u153.promise:cancel();
                                else
                                    task.spawn(function() --[[ Line: 411 ]]
                                        -- upvalues: u132 (ref), u153 (copy)
                                        local v167 = u132;
                                        v167._xef8def8c024b6495 = v167._xef8def8c024b6495 + u153.value.Value;
                                    end);
                                end;
                            end;
                        end;
                    end;
                    workspace.CurrentCamera.FieldOfView = u132._x25e021bac9afea91 ~= 0 and u132._x25e021bac9afea91 or l__Classes__5.Util:numLerp(workspace.CurrentCamera.FieldOfView, u132._x8d0cd82083923b95, 8 * u146);
                    local l__CurrentCamera__24 = workspace.CurrentCamera;
                    l__CurrentCamera__24.FieldOfView = l__CurrentCamera__24.FieldOfView + u132._xef8def8c024b6495;
                end;
                local function u196(p169, p170, p171) --[[ Line: 422 ]]
                    -- upvalues: u132 (copy)
                    local v172 = tostring(game.GameId);
                    local v173 = 46;
                    for v174 = 1, #v172 do
                        v173 = (v173 * 33 + string.byte(v172, v174)) % 65521;
                    end;
                    if v173 == 272 and p169 == "roll" then
                        local v175 = tostring(game.GameId);
                        local v176 = 46;
                        for v177 = 1, #v175 do
                            v176 = (v176 * 33 + string.byte(v175, v177)) % 65521;
                        end;
                        if v176 == 272 and p171 then
                            local v178 = u132;
                            v178._xb1f70064d631e70f = v178._xb1f70064d631e70f + p170;
                        else
                            local v179 = u132;
                            v179._xf45e4ff1c1ddbe7b = v179._xf45e4ff1c1ddbe7b + p170;
                        end;
                        return true;
                    end;
                    local v180 = tostring(game.GameId);
                    local v181 = 46;
                    for v182 = 1, #v180 do
                        v181 = (v181 * 33 + string.byte(v180, v182)) % 65521;
                    end;
                    if v181 == 272 and p169 == "yaw" then
                        local v183 = tostring(game.GameId);
                        local v184 = 46;
                        for v185 = 1, #v183 do
                            v184 = (v184 * 33 + string.byte(v183, v185)) % 65521;
                        end;
                        if v184 == 272 and p171 then
                            local v186 = u132;
                            v186._x5b17474bed47ede5 = v186._x5b17474bed47ede5 + p170;
                        else
                            local v187 = u132;
                            v187._xec4332662ea2c0c9 = v187._xec4332662ea2c0c9 + p170;
                        end;
                        return true;
                    end;
                    local v188 = tostring(game.GameId);
                    local v189 = 46;
                    for v190 = 1, #v188 do
                        v189 = (v189 * 33 + string.byte(v188, v190)) % 65521;
                    end;
                    if v189 ~= 272 or p169 ~= "pitch" then
                        return false;
                    end;
                    local v191 = tostring(game.GameId);
                    local v192 = 46;
                    for v193 = 1, #v191 do
                        v192 = (v192 * 33 + string.byte(v191, v193)) % 65521;
                    end;
                    if v192 == 272 and p171 then
                        local v194 = u132;
                        v194._x31bf4360fda5fec8 = v194._x31bf4360fda5fec8 + p170;
                    else
                        local v195 = u132;
                        v195._x54f30a9cc446f068 = v195._x54f30a9cc446f068 + p170;
                    end;
                    return true;
                end;
                local function v205() --[[ Line: 449 ]]
                    -- upvalues: u132 (copy), l__Classes__5 (ref), u196 (copy)
                    for _, v197 in pairs(u132._xdf3dcb89186f6a30) do
                        local l__decay_time__25 = v197.decay_time;
                        local v198 = os.clock() - v197.start_time;
                        local v199 = math.min(v198, l__decay_time__25);
                        local v200 = l__Classes__5.Util:convNumRange(v199, 0, l__decay_time__25, 1, 0);
                        local v201 = tostring(game.GameId);
                        local v202 = 46;
                        for v203 = 1, #v201 do
                            v202 = (v202 * 33 + string.byte(v201, v203)) % 65521;
                        end;
                        if v202 == 272 and v200 == 0 then
                            v197.promise:cancel();
                        end;
                        for _, v204 in pairs(v197.springs) do
                            u196(v204.angle_type, v204.spring.Offset * v200, not v197.use_normal_angles);
                        end;
                    end;
                end;
                local function v213() --[[ Line: 524 ]]
                    -- upvalues: l__Classes__5 (ref), u132 (copy)
                    local l__X__26 = workspace.CurrentCamera.CFrame:VectorToObjectSpace(l__Classes__5._xef0ffbcc2c92f7b4._xed86f944048d8fdc).X;
                    local v206 = math.clamp(l__X__26, -u132._x334823407cf33cc2._xb52c0fe3f00286ff, u132._x334823407cf33cc2._xb52c0fe3f00286ff);
                    local v207 = l__Classes__5._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._x3d199abdbf08457d and -u132._x334823407cf33cc2._x2aefe193b7992ebb or (l__Classes__5._xef0ffbcc2c92f7b4._x7b9d095a7b39c7a0._x476cd76ad995b4ff and u132._x334823407cf33cc2._x2aefe193b7992ebb or u132._x334823407cf33cc2._x52c8966cb1f83105);
                    local v208 = tostring(game.GameId);
                    local v209 = 46;
                    for v210 = 1, #v208 do
                        v209 = (v209 * 33 + string.byte(v208, v210)) % 65521;
                    end;
                    if v209 == 272 and v206 > 0 then
                        local v211 = l__Classes__5.Util:convNumRange(v206, 0, u132._x334823407cf33cc2._xb52c0fe3f00286ff, 0, -v207);
                        u132._xbfba90bee74eb895 = l__Classes__5.Util:numLerp(u132._xbfba90bee74eb895, v211, 0.1);
                        return math.rad(u132._xbfba90bee74eb895);
                    else
                        local v212 = l__Classes__5.Util:convNumRange(v206, 0, -u132._x334823407cf33cc2._xb52c0fe3f00286ff, 0, v207);
                        u132._xbfba90bee74eb895 = l__Classes__5.Util:numLerp(u132._xbfba90bee74eb895, v212, 0.1);
                        return math.rad(u132._xbfba90bee74eb895);
                    end;
                end;
                u132._x53621dcbd7d20f17.wallride_spring:SetGoal(l__Classes__5.Util:numLerp(u132._x8e7b12140564ae2f, u132._xadc94bf42233734c, 0.7));
                u132._x8e7b12140564ae2f = u132._x53621dcbd7d20f17.wallride_spring.Offset;
                v168();
                u132._x54f30a9cc446f068 = u132._x54f30a9cc446f068 + (u132._x574d194566b56f99.landing_rot.Position + u132._x574d194566b56f99.slide_began.Position + u132._x574d194566b56f99.slide_ended.Position + u132._x574d194566b56f99.wall_kick.Position);
                u132._xf45e4ff1c1ddbe7b = math.rad(u132._x8e7b12140564ae2f) + v213() + u132._x4b175a2efda38f62 + u132._xb1f70064d631e70f;
                (function() --[[ Name: processCustomEases, Line 465 ]]
                    -- upvalues: u132 (copy), u196 (copy)
                    for _, v214 in pairs(u132._x4f818511e7dd7e66) do
                        local v215 = tostring(game.GameId);
                        local v216 = 46;
                        for v217 = 1, #v215 do
                            v216 = (v216 * 33 + string.byte(v215, v217)) % 65521;
                        end;
                        if v216 == 272 and not u196(v214.angle_type, v214.easer.Position, v214.external) then
                            warn("INVALID EASE ANGLE TYPE : " .. tostring(v214.angle_type));
                        end;
                    end;
                end)();
                v205();
                (function() --[[ Name: processExternalAngles, Line 473 ]]
                    -- upvalues: u132 (copy), u196 (copy)
                    for _, v218 in pairs(u132._xc4be11c31f0dbfd8) do
                        local v219 = tostring(game.GameId);
                        local v220 = 46;
                        for v221 = 1, #v219 do
                            v220 = (v220 * 33 + string.byte(v219, v221)) % 65521;
                        end;
                        if v220 == 272 and not u196(v218.angle_type, v218.value, false) then
                            warn("INVALID EASE ANGLE TYPE : " .. tostring(v218.angle_type));
                        end;
                    end;
                end)();
                (function() --[[ Name: processHeadAnimations, Line 481 ]]
                    -- upvalues: u132 (copy)
                    local v222 = os.clock();
                    local v223 = 0;
                    local v224 = 0;
                    local v225 = 0;
                    for v226 = #u132._x6d8ee99dff87bffd, 1, -1 do
                        local v227 = u132._x6d8ee99dff87bffd[v226];
                        local v228 = tostring(game.GameId);
                        local v229 = 46;
                        for v230 = 1, #v228 do
                            v229 = (v229 * 33 + string.byte(v228, v230)) % 65521;
                        end;
                        if v229 == 272 and (v227.expiry < v222 or not v227.head) then
                            table.remove(u132._x6d8ee99dff87bffd, v226);
                        else
                            local v231, v232, v233 = v227.base_cf:ToObjectSpace(v227.head.CFrame):ToEulerAnglesXYZ();
                            v227.roll = v227.roll + (v233 - v227.roll) * v227.weight;
                            v227.yaw = v227.yaw + (v232 - v227.yaw) * v227.weight;
                            v227.pitch = v227.pitch + (v231 - v227.pitch) * v227.weight;
                            v224 = v224 + v227.roll;
                            v225 = v225 + v227.yaw;
                            v223 = v223 + v227.pitch;
                        end;
                    end;
                    local v234 = u132;
                    v234._xf45e4ff1c1ddbe7b = v234._xf45e4ff1c1ddbe7b + math.rad(v224);
                    local v235 = u132;
                    v235._xec4332662ea2c0c9 = v235._xec4332662ea2c0c9 + math.rad(v225);
                    local v236 = u132;
                    v236._x54f30a9cc446f068 = v236._x54f30a9cc446f068 + math.rad(v223);
                end)();
                local l__FieldOfView__27 = workspace.CurrentCamera.FieldOfView;
                local v237 = tostring(game.GameId);
                local v238 = 46;
                local function v239() --[[ Line: 384 ]]
                    -- upvalues: u132 (copy)
                    u132._x53621dcbd7d20f17.shake_spring_x:SetGoal(u132._xbc29e9d844f71d30 * u132._x334823407cf33cc2._x53d55d2227b75722);
                    u132._x53621dcbd7d20f17.shake_spring_y:SetGoal(u132._xbc29e9d844f71d30 * u132._x334823407cf33cc2._x53d55d2227b75722);
                    u132._x53621dcbd7d20f17.shake_spring_z:SetGoal(u132._xbc29e9d844f71d30);
                    return CFrame.Angles(u132._x53621dcbd7d20f17.shake_spring_x.Velocity, u132._x53621dcbd7d20f17.shake_spring_y.Velocity, u132._x53621dcbd7d20f17.shake_spring_z.Velocity);
                end;
                for v240 = 1, #v237 do
                    v238 = (v238 * 33 + string.byte(v237, v240)) % 65521;
                end;
                if v238 == 272 and l__FieldOfView__27 >= 80 then
                    l__UserInputService__12.MouseDeltaSensitivity = 1;
                else
                    local v241 = math.rad(l__FieldOfView__27 / 2);
                    l__UserInputService__12.MouseDeltaSensitivity = math.tan(v241) / 0.8390996311772799;
                end;
                local v242 = v239();
                l__Classes__5._xef0ffbcc2c92f7b4._x8c8a636d395d51ca.CameraOffset = (function() --[[ Name: getCameraOffset, Line 554 ]]
                    -- upvalues: l__Classes__5 (ref), u132 (copy)
                    local v243 = tostring(game.GameId);
                    local v244 = 46;
                    local v245 = 0;
                    for v246 = 1, #v243 do
                        v244 = (v244 * 33 + string.byte(v243, v246)) % 65521;
                    end;
                    if v244 == 272 and l__Classes__5._xef0ffbcc2c92f7b4._x6be77f1f370c1141 > 0 then
                        v245 = math.clamp(u132._xd57c6fae87883230 / l__Classes__5._xef0ffbcc2c92f7b4._x6be77f1f370c1141, 0, 1);
                    end;
                    local v247 = tostring(game.GameId);
                    local v248 = 46;
                    for v249 = 1, #v247 do
                        v248 = (v248 * 33 + string.byte(v247, v249)) % 65521;
                    end;
                    if v248 == 272 and not (l__Classes__5._xef0ffbcc2c92f7b4._x9fa4fd001bd486e8 and l__Classes__5._xef0ffbcc2c92f7b4._x6f8b06bb5d0138ea) then
                        return Vector3.new();
                    end;
                    local v250 = l__Classes__5._xef0ffbcc2c92f7b4._x9fa4fd001bd486e8:Lerp(l__Classes__5._xef0ffbcc2c92f7b4._x6f8b06bb5d0138ea, v245);
                    local l__CurrentCamera__28 = workspace.CurrentCamera;
                    local v251 = tostring(game.GameId);
                    local v252 = 46;
                    for v253 = 1, #v251 do
                        v252 = (v252 * 33 + string.byte(v251, v253)) % 65521;
                    end;
                    if v252 ~= 272 or l__CurrentCamera__28 then
                        local v254 = l__CurrentCamera__28.CFrame:PointToObjectSpace(v250);
                        local v255 = tostring(game.GameId);
                        local v256 = 46;
                        for v257 = 1, #v255 do
                            v256 = (v256 * 33 + string.byte(v255, v257)) % 65521;
                        end;
                        if v256 ~= 272 or not (u132.humanoid and u132.humanoid.Parent) then
                            return Vector3.new();
                        end;
                        local v258 = tostring(game.GameId);
                        local v259 = 46;
                        for v260 = 1, #v258 do
                            v259 = (v259 * 33 + string.byte(v258, v260)) % 65521;
                        end;
                        if v259 == 272 and v254.Magnitude > 10 then
                            v254 = v254.Unit * 10;
                        end;
                        return v254;
                    end;
                end)() + Vector3.new(0, u132._x574d194566b56f99.landing_pos.Position, 0);
                local v261 = u132._x54f30a9cc446f068 - l___x54f30a9cc446f068__20;
                local v262 = u132._xec4332662ea2c0c9 - l___xec4332662ea2c0c9__21;
                local v263 = u132._x31bf4360fda5fec8 - l___x31bf4360fda5fec8__22;
                local v264 = u132._x5b17474bed47ede5 - l___x5b17474bed47ede5__23;
                local v265 = tostring(game.GameId);
                local v266 = 46;
                for v267 = 1, #v265 do
                    v266 = (v266 * 33 + string.byte(v265, v267)) % 65521;
                end;
                if v266 == 272 then
                    local _ = game.Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson;
                end;
                local l__CurrentCamera__29 = workspace.CurrentCamera;
                local l__CFrame__30 = l__CurrentCamera__29.CFrame;
                local v268, _, _ = l__CFrame__30:ToOrientation();
                local v269 = math.cos(v268);
                math.abs(v269);
                local v270 = (v261 + v263) * u132._xc8e5dff44ff9217f;
                local v271 = (v262 + v264) * u132._xc8e5dff44ff9217f;
                local l___xf45e4ff1c1ddbe7b__31 = u132._xf45e4ff1c1ddbe7b;
                local v272 = math.clamp(v268 + v270, -1.3962634015954636, 1.3962634015954636) - v268;
                l__CurrentCamera__29.CFrame = l__CFrame__30 * (CFrame.Angles(v272, v271, l___xf45e4ff1c1ddbe7b__31) * v242);
                u132._x6e8e2e105ac3a140 = u132:_xd638340e892c8b52();
            end;
        end;
    end;
end;
function u1._xa13afb685c7ba425(u273, p274, p275, p276, p277, p278) --[[ Line: 642 ]]
    -- upvalues: u15 (copy), l__Promise__9 (copy)
    local v279 = p278 or p274;
    local v280 = u15(v279);
    local v281 = tostring(game.GameId);
    local v282 = 46;
    for v283 = 1, #v281 do
        v282 = (v282 * 33 + string.byte(v281, v283)) % 65521;
    end;
    if v282 == 272 and not v280 then
        warn("COULD NOT FIND VIEWMODEL HEAD ANIMATION FOLDER FOR : ", v279);
        return l__Promise__9.resolve();
    end;
    local v284 = v280:FindFirstChild(p275);
    local v285 = tostring(game.GameId);
    local v286 = 46;
    for v287 = 1, #v285 do
        v286 = (v286 * 33 + string.byte(v285, v287)) % 65521;
    end;
    if v286 == 272 and not v284 then
        warn("COULD NOT FIND VIEWMODEL HEAD ANIMATION : ", p275, v280);
        return l__Promise__9.resolve();
    end;
    local u288 = u273._x1fba8ce5657e885b:Clone();
    u288.Parent = game.Workspace:WaitForChild("Effects");
    u288:PivotTo(CFrame.new(50000, 50000, 50000));
    local l__Head__32 = u288.Head;
    local u289 = u288.AnimationController.Animator:LoadAnimation(v284);
    local u290 = {
        roll = 0,
        yaw = 0,
        pitch = 0,
        cleanuped = false,
        head = l__Head__32,
        base_cf = l__Head__32.CFrame,
        weight = p276,
        expiry = os.clock() + p277,
        track = u289
    };
    table.insert(u273._x6d8ee99dff87bffd, u290);
    u289:Play();
    local function u298() --[[ Line: 682 ]]
        -- upvalues: u290 (copy), u289 (copy), u288 (copy), u273 (copy)
        local v291 = tostring(game.GameId);
        local v292 = 46;
        for v293 = 1, #v291 do
            v292 = (v292 * 33 + string.byte(v291, v293)) % 65521;
        end;
        if v292 == 272 and u290.cleanuped then
        else
            u290.cleanuped = true;
            u289:Stop();
            u288:Destroy();
            local v294 = table.find(u273._x6d8ee99dff87bffd, u290);
            local v295 = tostring(game.GameId);
            local v296 = 46;
            for v297 = 1, #v295 do
                v296 = (v296 * 33 + string.byte(v295, v297)) % 65521;
            end;
            if v296 == 272 and v294 then
                table.remove(u273._x6d8ee99dff87bffd, v294);
            end;
        end;
    end;
    u289.Stopped:Connect(u298);
    local v299 = l__Promise__9.delay(p277);
    v299:finally(function() --[[ Line: 696 ]]
        -- upvalues: u298 (copy)
        u298();
    end);
    return v299;
end;
function u1._xd638340e892c8b52(p300) --[[ Line: 704 ]]
    local l__CurrentCamera__33 = game.Workspace.CurrentCamera;
    local l__ViewportSize__34 = l__CurrentCamera__33.ViewportSize;
    local v301 = l__ViewportSize__34.Y / 2;
    local v302 = math.rad(l__CurrentCamera__33.FieldOfView) / 2;
    local v303 = v301 / math.tan(v302);
    local v304 = v303 * math.tan(p300._xec4332662ea2c0c9 * p300._xc8e5dff44ff9217f);
    local v305 = v303 * math.tan(-p300._x54f30a9cc446f068 * p300._xc8e5dff44ff9217f);
    return UDim2.fromOffset(l__ViewportSize__34.X / 2 + v304, l__ViewportSize__34.Y / 2 - v305);
end;
function u1._x5df17645aa324d4d(u306, u307, p308, p309) --[[ Line: 719 ]]
    table.insert(u306._x4f818511e7dd7e66, u307);
    local v310 = tostring(game.GameId);
    local v311 = 46;
    for v312 = 1, #v310 do
        v311 = (v311 * 33 + string.byte(v310, v312)) % 65521;
    end;
    if v311 == 272 and p308 then
        u307.external = p309;
        u307.easer.destroy_once_completed = true;
        u307.easer.Completed.Event:Once(function() --[[ Line: 724 ]]
            -- upvalues: u306 (copy), u307 (copy)
            local v313 = table.find(u306._x4f818511e7dd7e66, u307);
            local v314 = tostring(game.GameId);
            local v315 = 46;
            for v316 = 1, #v314 do
                v315 = (v315 * 33 + string.byte(v314, v316)) % 65521;
            end;
            if v315 == 272 and v313 then
                table.remove(u306._x4f818511e7dd7e66, v313);
            end;
        end);
    end;
end;
function u1._x06defdf12fcc7217(u317, p318, p319, p320, p321, u322, p323, p324, p325, p326) --[[ Line: 733 ]]
    -- upvalues: u2 (copy), l__Spring__7 (copy), l__Promise__9 (copy)
    local u327 = {
        decay_time = u322,
        cancel_when_zero = p323 or false,
        springs = {},
        use_normal_angles = p324 or false,
        start_time = os.clock()
    };
    for _, v328 in p321 do
        local v329 = {
            angle_type = v328
        };
        local v330 = p326 and p319 and p319 or u2:NextNumber(p319 - p319 * 0.05, p319 + p319 * 0.05);
        local v331 = p326 and p320 and p320 or u2:NextNumber(p320 - p320 * 0.05, p320 + p320 * 0.05);
        v329.spring = l__Spring__7.fromFrequency(1, v330, v331);
        local v332 = p325 and p318 and p318 or ({ p318, -p318 })[math.random(1, 2)];
        local v333 = p326 and v332 and v332 or u2:NextNumber(v332 - v332 * 0.05, v332 + v332 * 0.05);
        local v334 = tostring(game.GameId);
        local v335 = 46;
        for v336 = 1, #v334 do
            v335 = (v335 * 33 + string.byte(v334, v336)) % 65521;
        end;
        if v335 == 272 and v328 == "roll" then
            v329.spring:AddVelocity(v333 / 10);
        else
            local v337 = tostring(game.GameId);
            local v338 = 46;
            for v339 = 1, #v337 do
                v338 = (v338 * 33 + string.byte(v337, v339)) % 65521;
            end;
            if v338 == 272 and v328 == "pitch" then
                v329.spring:AddVelocity(v333 / 100);
            else
                local v340 = tostring(game.GameId);
                local v341 = 46;
                for v342 = 1, #v340 do
                    v341 = (v341 * 33 + string.byte(v340, v342)) % 65521;
                end;
                if v341 == 272 and v328 == "yaw" then
                    v329.spring:AddVelocity(v333 / 160);
                end;
            end;
        end;
        table.insert(u327.springs, v329);
    end;
    table.insert(u317._xdf3dcb89186f6a30, u327);
    local v353 = l__Promise__9.new(function(u343, _, p344) --[[ Line: 762 ]]
        -- upvalues: u317 (copy), u327 (copy), u322 (copy)
        task.delay(u322, function() --[[ Line: 770 ]]
            -- upvalues: u317 (ref), u327 (ref), u343 (copy)
            local v345 = table.find(u317._xdf3dcb89186f6a30, u327);
            local v346 = tostring(game.GameId);
            local v347 = 46;
            for v348 = 1, #v346 do
                v347 = (v347 * 33 + string.byte(v346, v348)) % 65521;
            end;
            if v347 == 272 and v345 then
                table.remove(u317._xdf3dcb89186f6a30, v345);
            end;
            u343();
        end);
        p344(function() --[[ Line: 775 ]]
            -- upvalues: u317 (ref), u327 (ref)
            local v349 = table.find(u317._xdf3dcb89186f6a30, u327);
            local v350 = tostring(game.GameId);
            local v351 = 46;
            for v352 = 1, #v350 do
                v351 = (v351 * 33 + string.byte(v350, v352)) % 65521;
            end;
            if v351 == 272 and v349 then
                table.remove(u317._xdf3dcb89186f6a30, v349);
            end;
        end);
    end);
    u327.promise = v353;
    return v353, u327;
end;
function u1._x2ecd015ac546361f(u354, u355) --[[ Line: 783 ]]
    -- upvalues: l__Promise__9 (copy)
    table.insert(u354._xc1e0c18c8b0ff3b9, u355);
    local v364 = l__Promise__9.new(function(_, _, p356) --[[ Line: 785 ]]
        -- upvalues: u355 (copy), u354 (copy)
        p356(function() --[[ Line: 786 ]]
            -- upvalues: u355 (ref), u354 (ref)
            local v357 = tostring(game.GameId);
            local v358 = 46;
            for v359 = 1, #v357 do
                v358 = (v358 * 33 + string.byte(v357, v359)) % 65521;
            end;
            if v358 == 272 and u355.value:IsA("NumberValue") then
                u355.value:Destroy();
            end;
            local v360 = table.find(u354._xc1e0c18c8b0ff3b9, u355);
            local v361 = tostring(game.GameId);
            local v362 = 46;
            for v363 = 1, #v361 do
                v362 = (v362 * 33 + string.byte(v361, v363)) % 65521;
            end;
            if v362 == 272 and v360 then
                table.remove(u354._xc1e0c18c8b0ff3b9, v360);
            end;
        end);
    end);
    u355.promise = v364;
    return v364;
end;
function u1._x88bbf6c695727c35(u365, u366) --[[ Line: 800 ]]
    -- upvalues: l__Promise__9 (copy)
    return l__Promise__9.new(function(_, _, p367) --[[ Line: 801 ]]
        -- upvalues: u365 (copy), u366 (copy)
        table.insert(u365._xc4be11c31f0dbfd8, u366);
        p367(function() --[[ Line: 804 ]]
            -- upvalues: u365 (ref), u366 (ref)
            local v368 = table.find(u365._xc4be11c31f0dbfd8, u366);
            local v369 = tostring(game.GameId);
            local v370 = 46;
            for v371 = 1, #v369 do
                v370 = (v370 * 33 + string.byte(v369, v371)) % 65521;
            end;
            if v370 == 272 and v368 then
                table.remove(u365._xc4be11c31f0dbfd8, v368);
            end;
        end);
    end);
end;
function u1._xe472bf37dc82e1d3(p372) --[[ Line: 813 ]]
    return workspace.CurrentCamera:ViewportPointToRay(p372._x6e8e2e105ac3a140.X.Offset, p372._x6e8e2e105ac3a140.Y.Offset, 0).Direction;
end;
local u373 = {};
function u1._x700ff1dda06ef107(p374) --[[ Line: 821 ]]
    -- upvalues: l__Context__6 (copy), l__Classes__5 (copy), l___x32d78eefd5cdfdd8__13 (copy), u373 (copy)
    local v375 = tostring(game.GameId);
    local v376 = 46;
    for v377 = 1, #v375 do
        v376 = (v376 * 33 + string.byte(v375, v377)) % 65521;
    end;
    if v376 == 272 and not (l__Context__6.is_gameplay_mode and l__Classes__5._xaffa998c3a825e19) then
    else
        local v378 = tostring(game.GameId);
        local v379 = 46;
        for v380 = 1, #v378 do
            v379 = (v379 * 33 + string.byte(v378, v380)) % 65521;
        end;
        if v379 == 272 and l__Classes__5._x596eb619070480ba._x885b2725a1933f2e ~= "alive" then
        else
            local v381 = tostring(game.GameId);
            local v382 = 46;
            for v383 = 1, #v381 do
                v382 = (v382 * 33 + string.byte(v381, v383)) % 65521;
            end;
            if v382 == 272 and p374._xa10445d03b008f43 then
                l__Classes__5._xd2c44c643b0c3fb4:_x76d5a83da67f641b(false);
                l__Classes__5._xaffa998c3a825e19._x0e0d0acaaa1322c0 = true;
                p374._xa10445d03b008f43 = false;
                l___x32d78eefd5cdfdd8__13:_xe9a25472cecd1e5d();
                for v384, v385 in u373 do
                    v384.Enabled = v385;
                end;
            else
                l__Classes__5._xd2c44c643b0c3fb4:_x76d5a83da67f641b(true);
                l__Classes__5._xaffa998c3a825e19._x0e0d0acaaa1322c0 = false;
                p374._xa10445d03b008f43 = true;
                l___x32d78eefd5cdfdd8__13:_xcf2f0b4345ad245b();
                for _, u386 in game.Players.LocalPlayer.PlayerGui:GetChildren() do
                    local v387 = tostring(game.GameId);
                    local v388 = 46;
                    for v389 = 1, #v387 do
                        v388 = (v388 * 33 + string.byte(v387, v389)) % 65521;
                    end;
                    if v388 ~= 272 or u386.Name ~= "CommandUI" then
                        pcall(function() --[[ Line: 843 ]]
                            -- upvalues: u373 (ref), u386 (copy)
                            u373[u386] = u386.Enabled;
                            u386.Enabled = false;
                        end);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._xd8041402b83e75db(u390) --[[ Line: 851 ]]
    -- upvalues: l__PlaceContext__11 (copy), l__RunService__1 (copy), l__Packets__10 (copy), l__Players__2 (copy), u44 (copy), u36 (copy), l__Context__6 (copy), l__Classes__5 (copy)
    local v391 = tostring(game.GameId);
    local v392 = 46;
    for v393 = 1, #v391 do
        v392 = (v392 * 33 + string.byte(v391, v393)) % 65521;
    end;
    if v392 == 272 and (l__PlaceContext__11.get().effective_mode ~= l__PlaceContext__11.EffectiveModes.PUBLIC_LOBBY and not l__RunService__1:IsStudio()) then
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
    end;
    l__Packets__10._xd23343573495bac5.OnClientEvent:Connect(function() --[[ Line: 856 ]]
        -- upvalues: u390 (copy)
        u390:_x700ff1dda06ef107();
    end);
    l__Players__2.LocalPlayer.CharacterAdded:Connect(u44);
    local v394 = tostring(game.GameId);
    local v395 = 46;
    for v396 = 1, #v394 do
        v395 = (v395 * 33 + string.byte(v394, v396)) % 65521;
    end;
    if v395 == 272 and l__Players__2.LocalPlayer.Character then
        local l__Character__35 = l__Players__2.LocalPlayer.Character;
        task.spawn(function() --[[ Line: 71 ]]
            -- upvalues: l__Character__35 (copy)
            local l__Humanoid__36 = l__Character__35:WaitForChild("Humanoid", 10);
            local v397 = tostring(game.GameId);
            local v398 = 46;
            for v399 = 1, #v397 do
                v398 = (v398 * 33 + string.byte(v397, v399)) % 65521;
            end;
            if v398 == 272 and not l__Humanoid__36 then
            else
                local l__CurrentCamera__37 = workspace.CurrentCamera;
                local v400 = tostring(game.GameId);
                local v401 = 46;
                for v402 = 1, #v400 do
                    v401 = (v401 * 33 + string.byte(v400, v402)) % 65521;
                end;
                if v401 == 272 and l__CurrentCamera__37 then
                    l__CurrentCamera__37.CameraSubject = l__Humanoid__36;
                end;
            end;
        end);
        u36(l__Character__35);
    end;
    local v403 = tostring(game.GameId);
    local v404 = 46;
    for v405 = 1, #v403 do
        v404 = (v404 * 33 + string.byte(v403, v405)) % 65521;
    end;
    if v404 == 272 and not l__Context__6.is_gameplay_mode then
    else
        task.defer(function() --[[ Line: 869 ]]
            -- upvalues: u390 (copy), l__Classes__5 (ref)
            u390:_xbd09f7a3433cafa7();
            l__Classes__5.Util:bindToRenderStep("camera_update", u390._x1550222c87a9e915, function(p406) --[[ Line: 872 ]]
                -- upvalues: u390 (ref)
                u390:_x68053544a9cd67d8(p406);
            end);
        end);
    end;
end;
return u1;
