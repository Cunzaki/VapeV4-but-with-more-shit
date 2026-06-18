-- Decompiled from: Start.Client.Classes._x20ced43136f3a8e4
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__RunService__4 = game:GetService("RunService");
local l__ModuleScripts__5 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__6 = require(l__ModuleScripts__5.Packets);
local l__Trove__7 = require(l__ModuleScripts__5.Trove);
local l__Spring__8 = require(l__ModuleScripts__5.Spring);
local l__UIAssets__9 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__ClientRoot__10 = require(script.Parent.Parent.ClientRoot);
local l__Classes__11 = l__ClientRoot__10.Classes;
local l__Context__12 = l__ClientRoot__10.Context;
local l__LocalPlayer__13 = l__Players__2.LocalPlayer;
local function u3(p2) --[[ Line: 72 ]]
    return p2:IsA("ParticleEmitter") or (p2:IsA("Beam") or p2:IsA("Trail") or (p2:IsA("BillboardGui") or p2:IsA("SurfaceGui")) or (p2:IsA("PointLight") or p2:IsA("SpotLight") or (p2:IsA("SurfaceLight") or p2:IsA("Highlight"))));
end;
local function u10(p4) --[[ Line: 88 ]]
    local l__CFrame__14 = p4.CFrame;
    local v5 = p4.Size * 0.5;
    local l__RightVector__15 = l__CFrame__14.RightVector;
    local l__UpVector__16 = l__CFrame__14.UpVector;
    local l__LookVector__17 = l__CFrame__14.LookVector;
    local v6 = math.abs(l__RightVector__15.X) * v5.X + math.abs(l__UpVector__16.X) * v5.Y + math.abs(l__LookVector__17.X) * v5.Z;
    local v7 = math.abs(l__RightVector__15.Y) * v5.X + math.abs(l__UpVector__16.Y) * v5.Y + math.abs(l__LookVector__17.Y) * v5.Z;
    local v8 = math.abs(l__RightVector__15.Z) * v5.X + math.abs(l__UpVector__16.Z) * v5.Y + math.abs(l__LookVector__17.Z) * v5.Z;
    local v9 = Vector3.new(v6, v7, v8);
    local l__Position__18 = l__CFrame__14.Position;
    return l__Position__18 - v9, l__Position__18 + v9;
end;
local function u37(p11) --[[ Line: 103 ]]
    -- upvalues: u10 (copy)
    local v12 = p11:FindFirstChild("CameraAngles");
    local v13 = nil;
    local v14 = nil;
    for _, v15 in p11:GetDescendants() do
        local v16 = tostring(game.GameId);
        local v17 = 46;
        for v18 = 1, #v16 do
            v17 = (v17 * 33 + string.byte(v16, v18)) % 65521;
        end;
        if v17 ~= 272 or not (v12 and v15:IsDescendantOf(v12)) then
            local v19 = tostring(game.GameId);
            local v20 = 46;
            for v21 = 1, #v19 do
                v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
            end;
            if v20 ~= 272 or v15:IsA("BasePart") then
                local v22, v23 = u10(v15);
                local v24 = tostring(game.GameId);
                local v25 = 46;
                for v26 = 1, #v24 do
                    v25 = (v25 * 33 + string.byte(v24, v26)) % 65521;
                end;
                if v25 == 272 and not (v13 and v14) then
                    v14 = v23;
                    v13 = v22;
                else
                    local v27 = math.min(v13.X, v22.X);
                    local v28 = math.min(v13.Y, v22.Y);
                    local v29 = math.min(v13.Z, v22.Z);
                    v13 = Vector3.new(v27, v28, v29);
                    local v30 = math.max(v14.X, v23.X);
                    local v31 = math.max(v14.Y, v23.Y);
                    local v32 = math.max(v14.Z, v23.Z);
                    v14 = Vector3.new(v30, v31, v32);
                end;
            end;
        end;
    end;
    local v33 = tostring(game.GameId);
    local v34 = 46;
    for v35 = 1, #v33 do
        v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
    end;
    if v34 == 272 and not (v13 and v14) then
        return nil, nil;
    end;
    local v36 = v14 - v13;
    return v13 + v36 * 0.5, v36;
end;
function u1._xafd29f1684593d0b() --[[ Line: 145 ]]
    -- upvalues: u1 (copy), l__Trove__7 (copy), l__Spring__8 (copy)
    local v38 = setmetatable({}, u1);
    v38._xbf2bb995065a6e4e = l__Trove__7.new();
    v38._xb5094b2a73d152dd = "idle";
    v38._x8da08b8171b99263 = nil;
    v38._x7c4bba2ed6a18623 = nil;
    v38._xe9a51df2beb9bdef = false;
    v38._x90e8c96b7a1e17ef = v38._xbf2bb995065a6e4e:Extend();
    v38._x248911b72ae28ede = 0;
    v38._x9a44b10356bc8ffa = {
        x = l__Spring__8.fromFrequency(5, 4, 1),
        y = l__Spring__8.fromFrequency(5, 4, 1),
        z = l__Spring__8.fromFrequency(5, 4, 1)
    };
    v38._xeb52c9971a207a45 = {
        wideshot_bored = 3
    };
    for _, v39 in pairs(v38._x9a44b10356bc8ffa) do
        v39:SnapToCriticalDamping();
    end;
    v38._x2a2e1c6d9275cabb = game:GetService("UserInputService"):GetMouseLocation();
    v38._x72007d221f1213a0 = 0;
    v38._x563219c9454957ce = 0;
    v38._x36cfb662c2966343 = 0;
    v38._x739adb675af80490 = 0;
    v38._x28713087f4b4d8f9 = 0;
    v38._x7c5ccd2dce210790 = Vector3.new(0, 8, 0);
    v38._x8ef8433648aa9e0e = Vector3.new(80, 45, 80);
    v38._x46c5a9ba2af25d56 = l__Trove__7.new();
    v38._x69d9097960a81d7b = nil;
    v38._xd043f601fd2213ab = nil;
    v38._x1900aefc902c2a28 = nil;
    v38._x1a52592a47759cad = nil;
    v38._x5f5110c9d3ed6625 = 0;
    v38._x3bffe2d62fe2cf8e = Vector3.new(0, 0, -1);
    v38._xbe54b00e3b616209 = nil;
    v38._x6aded71b3421a941 = 0;
    v38._x01c025bff540dd23 = false;
    v38._xba7a2c4e14f5bd61 = 0;
    v38._xe9067999549b00df = false;
    v38._x01f30da894efed9f = l__Trove__7.new();
    v38._xc51986732fb3da98 = {};
    return v38;
end;
function u1.cleanUp(p40) --[[ Line: 203 ]]
    -- upvalues: l__Classes__11 (copy)
    p40._x90e8c96b7a1e17ef:Clean();
    p40:_xa17153d5b112a1de();
    p40._xbf2bb995065a6e4e:Clean();
    p40._x90e8c96b7a1e17ef = p40._xbf2bb995065a6e4e:Extend();
    p40._xb5094b2a73d152dd = "idle";
    p40._x8da08b8171b99263 = nil;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    p40._x9fb2eddc44d0cd7b = nil;
    p40._xe9a51df2beb9bdef = false;
    l__Classes__11._x2b1f81c73714b323._x7324f78af14e3910 = false;
end;
function u1._xe784425b7783ee5a(p41) --[[ Line: 216 ]]
    -- upvalues: l__Classes__11 (copy)
    local v42 = tostring(game.GameId);
    local v43 = 46;
    for v44 = 1, #v42 do
        v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
    end;
    if v43 == 272 and not p41._xe9a51df2beb9bdef then
        return false;
    end;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    p41._x9fb2eddc44d0cd7b = nil;
    p41._xe9a51df2beb9bdef = false;
    return true;
end;
function u1._x2d22ad2b428d420d(p45, p46) --[[ Line: 228 ]]
    local v47 = tostring(game.GameId);
    local v48 = 46;
    for v49 = 1, #v47 do
        v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
    end;
    if v48 == 272 and p45._xe9a51df2beb9bdef then
    else
        p45:_xcc5f292712de0f3a(false, p46 or p45._x8da08b8171b99263);
    end;
end;
function u1._xc4aa9cc4a17a1ba0(p50, p51) --[[ Line: 236 ]]
    local v52 = tostring(game.GameId);
    local v53 = 46;
    for v54 = 1, #v52 do
        v53 = (v53 * 33 + string.byte(v52, v54)) % 65521;
    end;
    if v53 == 272 and p50._xb5094b2a73d152dd == "first_person" then
        p50:_xa17153d5b112a1de();
    end;
    p50._x90e8c96b7a1e17ef:Clean();
    p50._x248911b72ae28ede = 0;
    p50._xb5094b2a73d152dd = p51;
end;
function u1._xeec12df25ded61d5(p55) --[[ Line: 246 ]]
    p55._x46c5a9ba2af25d56:Clean();
    p55._x69d9097960a81d7b = nil;
    p55._xd043f601fd2213ab = nil;
    p55._x1900aefc902c2a28 = nil;
end;
function u1._x9156a6c42ff2d69b(p56, p57, u58) --[[ Line: 253 ]]
    -- upvalues: u3 (copy)
    local v59 = tostring(game.GameId);
    local v60 = 46;
    for v61 = 1, #v59 do
        v60 = (v60 * 33 + string.byte(v59, v61)) % 65521;
    end;
    if v60 == 272 and not (p57 and p57.Parent) then
    else
        local v62 = tostring(game.GameId);
        local v63 = 46;
        for v64 = 1, #v62 do
            v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
        end;
        if v63 == 272 and (p56._x69d9097960a81d7b == p57 and p56._xd043f601fd2213ab == u58) then
        else
            p56:_xeec12df25ded61d5();
            p56._x69d9097960a81d7b = p57;
            p56._xd043f601fd2213ab = u58;
            local u65 = {};
            p56._x1900aefc902c2a28 = u65;
            local function u79(p66) --[[ Line: 299 ]]
                -- upvalues: u65 (copy), u3 (ref)
                local v67 = tostring(game.GameId);
                local v68 = 46;
                for v69 = 1, #v67 do
                    v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
                end;
                if v68 == 272 and u65[p66] then
                else
                    local v70 = tostring(game.GameId);
                    local v71 = 46;
                    for v72 = 1, #v70 do
                        v71 = (v71 * 33 + string.byte(v70, v72)) % 65521;
                    end;
                    if v71 == 272 and p66:IsA("BasePart") then
                        u65[p66] = {
                            local_transparency_modifier = p66.LocalTransparencyModifier
                        };
                        p66.LocalTransparencyModifier = 1;
                    else
                        local v73 = tostring(game.GameId);
                        local v74 = 46;
                        for v75 = 1, #v73 do
                            v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
                        end;
                        if v74 == 272 and p66:IsA("Decal") then
                            u65[p66] = {
                                transparency = p66.Transparency
                            };
                            p66.Transparency = 1;
                        else
                            local v76 = tostring(game.GameId);
                            local v77 = 46;
                            for v78 = 1, #v76 do
                                v77 = (v77 * 33 + string.byte(v76, v78)) % 65521;
                            end;
                            if v77 == 272 and u3(p66) then
                                u65[p66] = {
                                    enabled = p66.Enabled
                                };
                                p66.Enabled = false;
                            end;
                        end;
                    end;
                end;
            end;
            local function u100(p80) --[[ Line: 277 ]]
                -- upvalues: u65 (copy), u58 (copy)
                local v81 = tostring(game.GameId);
                local v82 = 46;
                for v83 = 1, #v81 do
                    v82 = (v82 * 33 + string.byte(v81, v83)) % 65521;
                end;
                local v84, v85, v86, v87, v88, v89;
                if v82 == 272 then
                    if not u65[p80] then
                        local v90 = tostring(game.GameId);
                        local v91 = 46;
                        for v92 = 1, #v90 do
                            v91 = (v91 * 33 + string.byte(v90, v92)) % 65521;
                        end;
                        local v93;
                        if v91 == 272 and not u58 then
                            v93 = false;
                        else
                            v93 = p80 == u58 and true or p80:IsDescendantOf(u58);
                        end;
                        if not v93 then
                            v84 = tostring(game.GameId);
                            v85 = 46;
                            for v97 = 1, #v84 do
                                v85 = (v85 * 33 + string.byte(v84, v97)) % 65521;
                            end;
                            if v85 == 272 and p80:IsA("BasePart") then
                                u65[p80] = {
                                    local_transparency_modifier = p80.LocalTransparencyModifier
                                };
                                v86 = tostring(game.GameId);
                                v87 = 46;
                                for v98 = 1, #v86 do
                                    v87 = (v87 * 33 + string.byte(v86, v98)) % 65521;
                                end;
                                if v87 == 272 and (p80.Parent and p80.Parent:IsA("Accessory")) then
                                    p80.LocalTransparencyModifier = math.max(p80.LocalTransparencyModifier, 1);
                                else
                                    p80.LocalTransparencyModifier = math.max(p80.LocalTransparencyModifier, 0.97);
                                end;
                            else
                                v88 = tostring(game.GameId);
                                v89 = 46;
                                for v99 = 1, #v88 do
                                    v89 = (v89 * 33 + string.byte(v88, v99)) % 65521;
                                end;
                                if v89 == 272 and p80:IsA("Decal") then
                                    u65[p80] = {
                                        transparency = p80.Transparency
                                    };
                                    p80.Transparency = math.max(p80.Transparency, 0.97);
                                end;
                            end;
                        end;
                    end;
                else
                    v84 = tostring(game.GameId);
                    v85 = 46;
                    for v97 = 1, #v84 do
                        v85 = (v85 * 33 + string.byte(v84, v97)) % 65521;
                    end;
                    if v85 == 272 and p80:IsA("BasePart") then
                        u65[p80] = {
                            local_transparency_modifier = p80.LocalTransparencyModifier
                        };
                        v86 = tostring(game.GameId);
                        v87 = 46;
                        for v98 = 1, #v86 do
                            v87 = (v87 * 33 + string.byte(v86, v98)) % 65521;
                        end;
                        if v87 == 272 and (p80.Parent and p80.Parent:IsA("Accessory")) then
                            p80.LocalTransparencyModifier = math.max(p80.LocalTransparencyModifier, 1);
                        else
                            p80.LocalTransparencyModifier = math.max(p80.LocalTransparencyModifier, 0.97);
                        end;
                    else
                        v88 = tostring(game.GameId);
                        v89 = 46;
                        for v99 = 1, #v88 do
                            v89 = (v89 * 33 + string.byte(v88, v99)) % 65521;
                        end;
                        if v89 == 272 and p80:IsA("Decal") then
                            u65[p80] = {
                                transparency = p80.Transparency
                            };
                            p80.Transparency = math.max(p80.Transparency, 0.97);
                        end;
                    end;
                end;
            end;
            for _, v101 in p57:GetDescendants() do
                u100(v101);
            end;
            local v102 = tostring(game.GameId);
            local v103 = 46;
            for v104 = 1, #v102 do
                v103 = (v103 * 33 + string.byte(v102, v104)) % 65521;
            end;
            if v103 == 272 and u58 then
                u79(u58);
                for _, v105 in u58:GetDescendants() do
                    u79(v105);
                end;
            end;
            p56._x46c5a9ba2af25d56:Connect(p57.DescendantAdded, function(p106) --[[ Line: 332 ]]
                -- upvalues: u58 (copy), u79 (copy), u100 (copy)
                local v107 = tostring(game.GameId);
                local v108 = 46;
                for v109 = 1, #v107 do
                    v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
                end;
                if v108 == 272 then
                    local v110 = tostring(game.GameId);
                    local v111 = 46;
                    for v112 = 1, #v110 do
                        v111 = (v111 * 33 + string.byte(v110, v112)) % 65521;
                    end;
                    local v113;
                    if v111 == 272 and not u58 then
                        v113 = false;
                    else
                        v113 = p106 == u58 and true or p106:IsDescendantOf(u58);
                    end;
                    if v113 then
                        u79(p106);
                        return;
                    end;
                end;
                u100(p106);
            end);
            p56._x46c5a9ba2af25d56:Add(function() --[[ Line: 340 ]]
                -- upvalues: u65 (copy), u3 (ref)
                for v114, v115 in u65 do
                    local v116 = tostring(game.GameId);
                    local v117 = 46;
                    for v118 = 1, #v116 do
                        v117 = (v117 * 33 + string.byte(v116, v118)) % 65521;
                    end;
                    if v117 ~= 272 or v114 and v114.Parent then
                        local v119 = tostring(game.GameId);
                        local v120 = 46;
                        for v121 = 1, #v119 do
                            v120 = (v120 * 33 + string.byte(v119, v121)) % 65521;
                        end;
                        if v120 == 272 and (v115.local_transparency_modifier ~= nil and v114:IsA("BasePart")) then
                            v114.LocalTransparencyModifier = v115.local_transparency_modifier;
                        else
                            local v122 = tostring(game.GameId);
                            local v123 = 46;
                            for v124 = 1, #v122 do
                                v123 = (v123 * 33 + string.byte(v122, v124)) % 65521;
                            end;
                            if v123 == 272 and (v115.transparency ~= nil and v114:IsA("Decal")) then
                                v114.Transparency = v115.transparency;
                            else
                                local v125 = tostring(game.GameId);
                                local v126 = 46;
                                for v127 = 1, #v125 do
                                    v126 = (v126 * 33 + string.byte(v125, v127)) % 65521;
                                end;
                                if v126 == 272 and (v115.enabled ~= nil and u3(v114)) then
                                    v114.Enabled = v115.enabled;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end;
end;
function u1._xa17153d5b112a1de(p128) --[[ Line: 357 ]]
    -- upvalues: l__Classes__11 (copy)
    p128:_xeec12df25ded61d5();
    p128:_xf58b56ffe01752ee(false);
    local v129 = tostring(game.GameId);
    local v130 = 46;
    for v131 = 1, #v129 do
        v130 = (v130 * 33 + string.byte(v129, v131)) % 65521;
    end;
    if v130 == 272 and l__Classes__11._x3103fdab012bc1c0 then
        l__Classes__11._x3103fdab012bc1c0:_x95633951897b1101();
    end;
    p128._x1a52592a47759cad = nil;
    p128._x5f5110c9d3ed6625 = 0;
    p128._x3bffe2d62fe2cf8e = Vector3.new(0, 0, -1);
    p128._xbe54b00e3b616209 = nil;
    p128._x6aded71b3421a941 = 0;
    p128._x01c025bff540dd23 = false;
    p128._xba7a2c4e14f5bd61 = 0;
end;
function u1._xbc9d5453fb921564(p132, p133) --[[ Line: 374 ]]
    local v134 = tostring(game.GameId);
    local v135 = 46;
    for v136 = 1, #v134 do
        v135 = (v135 * 33 + string.byte(v134, v136)) % 65521;
    end;
    if v135 == 272 and not (p133 and p133.Parent) then
        p132:_xeec12df25ded61d5();
    else
        local v137 = p133:FindFirstChild("Head");
        local v138 = tostring(game.GameId);
        local v139 = 46;
        for v140 = 1, #v138 do
            v139 = (v139 * 33 + string.byte(v138, v140)) % 65521;
        end;
        if v139 ~= 272 or not (v137 and v137:IsA("BasePart")) then
            v137 = nil;
        end;
        p132:_x9156a6c42ff2d69b(p133, v137);
    end;
end;
local function u160() --[[ Line: 385 ]]
    -- upvalues: l__Players__2 (copy)
    local v141 = {};
    for _, v142 in game:GetService("ReplicatedStorage").ReadOnly.Players:GetChildren() do
        local v143 = v142:FindFirstChild("in_combat");
        local v144 = v142:FindFirstChild("status");
        local v145 = tostring(game.GameId);
        local v146 = 46;
        for v147 = 1, #v145 do
            v146 = (v146 * 33 + string.byte(v145, v147)) % 65521;
        end;
        if v146 == 272 and (v143 and v144) then
            local l__Value__19 = v143.Value;
            local v148 = v144.Value == "alive";
            local v149 = tostring(game.GameId);
            local v150 = 46;
            for v151 = 1, #v149 do
                v150 = (v150 * 33 + string.byte(v149, v151)) % 65521;
            end;
            if v150 == 272 and (l__Value__19 and v148) then
                local v152 = tonumber(v142.Name);
                local v153 = tostring(game.GameId);
                local v154 = 46;
                for v155 = 1, #v153 do
                    v154 = (v154 * 33 + string.byte(v153, v155)) % 65521;
                end;
                local v156;
                if v154 == 272 and v152 then
                    v156 = l__Players__2:GetPlayerByUserId(v152);
                else
                    v156 = nil;
                end;
                local v157 = tostring(game.GameId);
                local v158 = 46;
                for v159 = 1, #v157 do
                    v158 = (v158 * 33 + string.byte(v157, v159)) % 65521;
                end;
                if v158 == 272 and v156 then
                    table.insert(v141, v156);
                end;
            end;
        end;
    end;
    return v141;
end;
function u1._x48ce183cbbb06ff1(u161) --[[ Line: 409 ]]
    -- upvalues: u160 (copy), l__Classes__11 (copy)
    local u162 = workspace:FindFirstChild("Map");
    local u163;
    if u162 then
        u163 = u162:FindFirstChild("CameraAngles");
    else
        u163 = u162;
    end;
    local v164 = u160();
    local function u197(p165) --[[ Line: 415 ]]
        -- upvalues: u161 (copy), l__Classes__11 (ref), u197 (copy)
        u161:_xc4aa9cc4a17a1ba0("orbit");
        u161._x8da08b8171b99263 = p165;
        local l___xfe425cd0b7e6cb04__20 = l__Classes__11._xfe425cd0b7e6cb04;
        local v166 = l___xfe425cd0b7e6cb04__20:_xd737c93ca9a43e53(u161._x8da08b8171b99263, "wasHit");
        local v167 = l___xfe425cd0b7e6cb04__20:_xd737c93ca9a43e53(u161._x8da08b8171b99263, "clashed");
        local v168 = l___xfe425cd0b7e6cb04__20:_xd737c93ca9a43e53(u161._x8da08b8171b99263, "wasParried");
        local v169 = l___xfe425cd0b7e6cb04__20:_xd737c93ca9a43e53(u161._x8da08b8171b99263, "wasKilled");
        local v170 = tostring(game.GameId);
        local v171 = 46;
        for v172 = 1, #v170 do
            v171 = (v171 * 33 + string.byte(v170, v172)) % 65521;
        end;
        if v171 == 272 and not (v166 and (v167 and (v168 and v169))) then
            u161._x8da08b8171b99263 = nil;
            u161:_xc4aa9cc4a17a1ba0("idle");
        else
            local v178 = v166:Connect(function(p173) --[[ Line: 439 ]]
                -- upvalues: u197 (ref)
                local v174 = game:GetService("Players"):GetPlayerFromCharacter(p173);
                local v175 = tostring(game.GameId);
                local v176 = 46;
                for v177 = 1, #v175 do
                    v176 = (v176 * 33 + string.byte(v175, v177)) % 65521;
                end;
                if v176 == 272 and v174 then
                    u197(v174);
                end;
            end);
            local v184 = v167:Connect(function(p179) --[[ Line: 443 ]]
                -- upvalues: u197 (ref)
                local v180 = game:GetService("Players"):GetPlayerFromCharacter(p179);
                local v181 = tostring(game.GameId);
                local v182 = 46;
                for v183 = 1, #v181 do
                    v182 = (v182 * 33 + string.byte(v181, v183)) % 65521;
                end;
                if v182 == 272 and v180 then
                    u197(v180);
                end;
            end);
            local v190 = v168:Connect(function(p185) --[[ Line: 447 ]]
                -- upvalues: u197 (ref)
                local v186 = game:GetService("Players"):GetPlayerFromCharacter(p185);
                local v187 = tostring(game.GameId);
                local v188 = 46;
                for v189 = 1, #v187 do
                    v188 = (v188 * 33 + string.byte(v187, v189)) % 65521;
                end;
                if v188 == 272 and v186 then
                    u197(v186);
                end;
            end);
            local v196 = v169:Connect(function(p191) --[[ Line: 451 ]]
                -- upvalues: u197 (ref)
                local v192 = game:GetService("Players"):GetPlayerFromCharacter(p191);
                local v193 = tostring(game.GameId);
                local v194 = 46;
                for v195 = 1, #v193 do
                    v194 = (v194 * 33 + string.byte(v193, v195)) % 65521;
                end;
                if v194 == 272 and v192 then
                    u197(v192);
                end;
            end);
            u161._x90e8c96b7a1e17ef:Add(v178);
            u161._x90e8c96b7a1e17ef:Add(v184);
            u161._x90e8c96b7a1e17ef:Add(v190);
            u161._x90e8c96b7a1e17ef:Add(v196);
        end;
    end;
    local v198 = tostring(game.GameId);
    local v199 = 46;
    local function v204(p200) --[[ Line: 475 ]]
        -- upvalues: u197 (copy), u161 (copy)
        u197(p200);
        local l___x8da08b8171b99263__21 = u161._x8da08b8171b99263;
        if l___x8da08b8171b99263__21 then
            l___x8da08b8171b99263__21 = u161._x8da08b8171b99263.Character;
        end;
        if l___x8da08b8171b99263__21 then
            l___x8da08b8171b99263__21 = l___x8da08b8171b99263__21.PrimaryPart;
        end;
        local v201 = tostring(game.GameId);
        local v202 = 46;
        for v203 = 1, #v201 do
            v202 = (v202 * 33 + string.byte(v201, v203)) % 65521;
        end;
        if v202 == 272 and l___x8da08b8171b99263__21 then
            local l__Position__22 = l___x8da08b8171b99263__21.Position;
            u161._x9a44b10356bc8ffa.x:SetOffset(l__Position__22.X, true);
            u161._x9a44b10356bc8ffa.y:SetOffset(l__Position__22.Y, true);
            u161._x9a44b10356bc8ffa.z:SetOffset(l__Position__22.Z, true);
        end;
    end;
    local function v212() --[[ Line: 461 ]]
        -- upvalues: u161 (copy), u162 (copy), u163 (copy)
        u161:_xc4aa9cc4a17a1ba0("wideshot");
        u161._x8da08b8171b99263 = nil;
        u161._x7c4bba2ed6a18623 = nil;
        u161:_x094c391e25e7be65(u162);
        local v205 = tostring(game.GameId);
        local v206 = 46;
        for v207 = 1, #v205 do
            v206 = (v206 * 33 + string.byte(v205, v207)) % 65521;
        end;
        if v206 == 272 and u163 then
            local v208 = u163:GetChildren();
            local v209 = tostring(game.GameId);
            local v210 = 46;
            for v211 = 1, #v209 do
                v210 = (v210 * 33 + string.byte(v209, v211)) % 65521;
            end;
            if v210 == 272 and #v208 > 0 then
                u161._x7c4bba2ed6a18623 = v208[math.random(1, #v208)];
            end;
        end;
    end;
    for v213 = 1, #v198 do
        v199 = (v199 * 33 + string.byte(v198, v213)) % 65521;
    end;
    if v199 == 272 and u161._x8da08b8171b99263 then
        v204(u161._x8da08b8171b99263);
    else
        local v214 = tostring(game.GameId);
        local v215 = 46;
        for v216 = 1, #v214 do
            v215 = (v215 * 33 + string.byte(v214, v216)) % 65521;
        end;
        if v215 == 272 and #v164 > 0 then
            v204(v164[math.random(1, #v164)]);
        else
            v212();
        end;
    end;
end;
function u1._x8b565f977e085555(p217, _) --[[ Line: 499 ]]
    local v218 = game:GetService("UserInputService"):GetMouseLocation();
    local v219 = v218 - p217._x2a2e1c6d9275cabb;
    p217._x2a2e1c6d9275cabb = v218;
    p217._x36cfb662c2966343 = p217._x36cfb662c2966343 + v219.X * 0.0002;
    p217._x739adb675af80490 = p217._x739adb675af80490 + v219.Y * 0.0002;
    p217._x36cfb662c2966343 = math.clamp(p217._x36cfb662c2966343, -0.5, 0.5);
    p217._x739adb675af80490 = math.clamp(p217._x739adb675af80490, -0.3, 0.3);
end;
function u1._x094c391e25e7be65(p220, p221) --[[ Line: 514 ]]
    -- upvalues: u37 (copy)
    local v222 = tostring(game.GameId);
    local v223 = 46;
    local v224 = Vector3.new(0, 8, 0);
    local v225 = Vector3.new(80, 45, 80);
    for v226 = 1, #v222 do
        v223 = (v223 * 33 + string.byte(v222, v226)) % 65521;
    end;
    local v227, v228;
    if v223 == 272 and p221 then
        v227, v228 = u37(p221);
        local v229 = tostring(game.GameId);
        local v230 = 46;
        for v231 = 1, #v229 do
            v230 = (v230 * 33 + string.byte(v229, v231)) % 65521;
        end;
        if v230 == 272 and v227 then
            if not v228 then
                v228 = v225;
                v227 = v224;
            end;
        else
            v228 = v225;
            v227 = v224;
        end;
    else
        v228 = v225;
        v227 = v224;
    end;
    p220._x7c5ccd2dce210790 = v227;
    p220._x8ef8433648aa9e0e = v228;
end;
function u1._xc65f132bf49c5a18(p232, p233) --[[ Line: 534 ]]
    local l___x7c5ccd2dce210790__23 = p232._x7c5ccd2dce210790;
    local l___x8ef8433648aa9e0e__24 = p232._x8ef8433648aa9e0e;
    local v234 = math.max(l___x8ef8433648aa9e0e__24.X, l___x8ef8433648aa9e0e__24.Z);
    local v235 = math.clamp(v234 * 0.9, 80, 320);
    local v236 = math.max(l___x8ef8433648aa9e0e__24.Y * 1.1, v234 * 0.35);
    local v237 = math.clamp(v236, 45, 180);
    p232._x28713087f4b4d8f9 = p232._x28713087f4b4d8f9 + p233 * 0.08;
    local v238 = p232._x28713087f4b4d8f9 + p232._x72007d221f1213a0;
    local v239 = v237 + p232._x563219c9454957ce * v235;
    local v240 = l___x7c5ccd2dce210790__23 + CFrame.Angles(0, v238, 0):VectorToWorldSpace((Vector3.new(0, v239, v235)));
    workspace.CurrentCamera.CFrame = CFrame.lookAt(v240, l___x7c5ccd2dce210790__23);
end;
function u1._x9deea9b706847b06(p241, p242, p243, p244) --[[ Line: 557 ]]
    local v245 = tostring(game.GameId);
    local v246 = 46;
    for v247 = 1, #v245 do
        v246 = (v246 * 33 + string.byte(v245, v247)) % 65521;
    end;
    if v246 == 272 and p241._xb5094b2a73d152dd ~= "first_person" then
    else
        local v248 = tostring(game.GameId);
        local v249 = 46;
        for v250 = 1, #v248 do
            v249 = (v249 * 33 + string.byte(v248, v250)) % 65521;
        end;
        if v249 == 272 and p242 ~= p241._x1a52592a47759cad then
        else
            local v251 = tostring(game.GameId);
            local v252 = 46;
            for v253 = 1, #v251 do
                v252 = (v252 * 33 + string.byte(v251, v253)) % 65521;
            end;
            if v252 == 272 and p244 <= p241._x5f5110c9d3ed6625 then
            else
                local v254 = tostring(game.GameId);
                local v255 = 46;
                for v256 = 1, #v254 do
                    v255 = (v255 * 33 + string.byte(v254, v256)) % 65521;
                end;
                local v257;
                if v255 == 272 and not p243 then
                    v257 = nil;
                else
                    local l__Magnitude__25 = p243.Magnitude;
                    local v258 = tostring(game.GameId);
                    local v259 = 46;
                    for v260 = 1, #v258 do
                        v259 = (v259 * 33 + string.byte(v258, v260)) % 65521;
                    end;
                    if v259 == 272 and (l__Magnitude__25 ~= l__Magnitude__25 or l__Magnitude__25 <= 0) then
                        v257 = nil;
                    else
                        v257 = p243 / l__Magnitude__25;
                    end;
                end;
                local v261 = tostring(game.GameId);
                local v262 = 46;
                for v263 = 1, #v261 do
                    v262 = (v262 * 33 + string.byte(v261, v263)) % 65521;
                end;
                if v262 == 272 and not v257 then
                else
                    p241._x5f5110c9d3ed6625 = p244;
                    p241._x3bffe2d62fe2cf8e = v257;
                    p241._x6aded71b3421a941 = os.clock();
                    local v264 = tostring(game.GameId);
                    local v265 = 46;
                    for v266 = 1, #v264 do
                        v265 = (v265 * 33 + string.byte(v264, v266)) % 65521;
                    end;
                    if v265 == 272 and not (p241._x01c025bff540dd23 and p241._xbe54b00e3b616209) then
                        p241._xbe54b00e3b616209 = v257;
                    end;
                    p241._x01c025bff540dd23 = true;
                end;
            end;
        end;
    end;
end;
function u1._xfe29b010a6b094eb(p267, p268, p269, p270) --[[ Line: 586 ]]
    -- upvalues: l__Classes__11 (copy)
    local v271 = tostring(game.GameId);
    local v272 = 46;
    for v273 = 1, #v271 do
        v272 = (v272 * 33 + string.byte(v271, v273)) % 65521;
    end;
    if v272 == 272 and p267._xb5094b2a73d152dd ~= "first_person" then
    else
        local v274 = tostring(game.GameId);
        local v275 = 46;
        for v276 = 1, #v274 do
            v275 = (v275 * 33 + string.byte(v274, v276)) % 65521;
        end;
        if v275 == 272 and p268 ~= p267._x1a52592a47759cad then
        else
            local v277 = tostring(game.GameId);
            local v278 = 46;
            for v279 = 1, #v277 do
                v278 = (v278 * 33 + string.byte(v277, v279)) % 65521;
            end;
            if v278 == 272 and p270 <= p267._xba7a2c4e14f5bd61 then
            else
                local v280 = tostring(game.GameId);
                local v281 = 46;
                for v282 = 1, #v280 do
                    v281 = (v281 * 33 + string.byte(v280, v282)) % 65521;
                end;
                if v281 == 272 and typeof(p269) ~= "table" then
                else
                    p267._xba7a2c4e14f5bd61 = p270;
                    local v283 = tostring(game.GameId);
                    local v284 = 46;
                    for v285 = 1, #v283 do
                        v284 = (v284 * 33 + string.byte(v283, v285)) % 65521;
                    end;
                    if v284 == 272 and l__Classes__11._x3103fdab012bc1c0 then
                        l__Classes__11._x3103fdab012bc1c0:_x7666a0aef33372bd(p269);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._xe0ce8e9a58800463(p286) --[[ Line: 610 ]]
    for _, v287 in p286._xc51986732fb3da98 do
        local v288 = tostring(game.GameId);
        local v289 = 46;
        for v290 = 1, #v288 do
            v289 = (v289 * 33 + string.byte(v288, v290)) % 65521;
        end;
        if v289 == 272 and v287 then
            v287:Destroy();
        end;
    end;
    table.clear(p286._xc51986732fb3da98);
end;
function u1._x46d4ce0cb6e47ad0(p291, p292) --[[ Line: 619 ]]
    local v293 = p291._xc51986732fb3da98[p292];
    local v294 = tostring(game.GameId);
    local v295 = 46;
    for v296 = 1, #v294 do
        v295 = (v295 * 33 + string.byte(v294, v296)) % 65521;
    end;
    if v295 == 272 and v293 then
        v293:Destroy();
        p291._xc51986732fb3da98[p292] = nil;
    end;
end;
function u1._x7af8528487a1f2b5(p297, p298) --[[ Line: 627 ]]
    local v299 = p297._xc51986732fb3da98[p298];
    local v300 = tostring(game.GameId);
    local v301 = 46;
    for v302 = 1, #v300 do
        v301 = (v301 * 33 + string.byte(v300, v302)) % 65521;
    end;
    if v301 == 272 and (v299 and v299.Parent) then
        return v299;
    end;
    local v303 = Instance.new("Highlight");
    v303.Name = "SpectateWallhackHighlight";
    v303.FillColor = Color3.fromRGB(255, 255, 255);
    v303.OutlineColor = Color3.fromRGB(255, 255, 255);
    v303.FillTransparency = 0.5;
    v303.OutlineTransparency = 0.5;
    v303.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v303.Adornee = p298;
    v303.Parent = p298;
    p297._xc51986732fb3da98[p298] = v303;
    return v303;
end;
function u1._xc4b830c372e42337(p304) --[[ Line: 647 ]]
    -- upvalues: l__Classes__11 (copy)
    local v305 = tostring(game.GameId);
    local v306 = 46;
    for v307 = 1, #v305 do
        v306 = (v306 * 33 + string.byte(v305, v307)) % 65521;
    end;
    if v306 == 272 and not p304._xe9067999549b00df then
    else
        local v308 = workspace:FindFirstChild("Entities");
        local v309 = tostring(game.GameId);
        local v310 = 46;
        for v311 = 1, #v309 do
            v310 = (v310 * 33 + string.byte(v309, v311)) % 65521;
        end;
        if v310 == 272 and not v308 then
            p304:_xe0ce8e9a58800463();
        else
            local l__Position__26 = workspace.CurrentCamera.CFrame.Position;
            local v312 = {};
            for _, v313 in v308:GetChildren() do
                local v314 = l__Classes__11.Util:getLikelyVec3(v313);
                local v315 = tostring(game.GameId);
                local v316 = 46;
                for v317 = 1, #v315 do
                    v316 = (v316 * 33 + string.byte(v315, v317)) % 65521;
                end;
                if v316 == 272 and not v314 then
                    p304:_x46d4ce0cb6e47ad0(v313);
                else
                    local v318 = l__Classes__11.Util:hasLineOfSight(l__Position__26, v314);
                    local v319 = tostring(game.GameId);
                    local v320 = 46;
                    for v321 = 1, #v319 do
                        v320 = (v320 * 33 + string.byte(v319, v321)) % 65521;
                    end;
                    if v320 == 272 and v318 then
                        p304:_x46d4ce0cb6e47ad0(v313);
                    else
                        v312[v313] = true;
                        p304:_x7af8528487a1f2b5(v313);
                    end;
                end;
            end;
            local v322 = {};
            for v323, _ in p304._xc51986732fb3da98 do
                local v324 = tostring(game.GameId);
                local v325 = 46;
                for v326 = 1, #v324 do
                    v325 = (v325 * 33 + string.byte(v324, v326)) % 65521;
                end;
                if v325 == 272 and not (v312[v323] and v323.Parent) then
                    table.insert(v322, v323);
                end;
            end;
            for _, v327 in v322 do
                p304:_x46d4ce0cb6e47ad0(v327);
            end;
        end;
    end;
end;
function u1._xf58b56ffe01752ee(u328, p329) --[[ Line: 689 ]]
    -- upvalues: l__RunService__4 (copy)
    local v330 = tostring(game.GameId);
    local v331 = 46;
    for v332 = 1, #v330 do
        v331 = (v331 * 33 + string.byte(v330, v332)) % 65521;
    end;
    if v331 == 272 and (u328._xe9067999549b00df == p329 and p329) then
    else
        u328._xe9067999549b00df = p329;
        u328._x01f30da894efed9f:Clean();
        u328:_xe0ce8e9a58800463();
        local v333 = tostring(game.GameId);
        local v334 = 46;
        for v335 = 1, #v333 do
            v334 = (v334 * 33 + string.byte(v333, v335)) % 65521;
        end;
        if v334 == 272 and not p329 then
        else
            local u336 = 0.12;
            u328._x01f30da894efed9f:Connect(l__RunService__4.Heartbeat, function(p337) --[[ Line: 703 ]]
                -- upvalues: u328 (copy), u336 (ref)
                local v338 = tostring(game.GameId);
                local v339 = 46;
                for v340 = 1, #v338 do
                    v339 = (v339 * 33 + string.byte(v338, v340)) % 65521;
                end;
                if v339 == 272 and u328._xb5094b2a73d152dd ~= "first_person" then
                    u328:_xf58b56ffe01752ee(false);
                else
                    u336 = u336 + p337;
                    local v341 = tostring(game.GameId);
                    local v342 = 46;
                    for v343 = 1, #v341 do
                        v342 = (v342 * 33 + string.byte(v341, v343)) % 65521;
                    end;
                    if v342 == 272 and u336 < 0.12 then
                    else
                        u336 = 0;
                        u328:_xc4b830c372e42337();
                    end;
                end;
            end);
            u328:_xc4b830c372e42337();
        end;
    end;
end;
function u1._x4176c0e3db093c72(u344, p345) --[[ Line: 721 ]]
    -- upvalues: l__Players__2 (copy), l__Classes__11 (copy)
    u344:_xeec12df25ded61d5();
    if p345 then
        p345 = p345.user_id;
    end;
    local v346 = tostring(game.GameId);
    local v347 = 46;
    for v348 = 1, #v346 do
        v347 = (v347 * 33 + string.byte(v346, v348)) % 65521;
    end;
    if v347 == 272 and typeof(p345) ~= "number" then
    else
        local u349 = l__Players__2:GetPlayerByUserId(p345);
        local v350 = tostring(game.GameId);
        local v351 = 46;
        for v352 = 1, #v350 do
            v351 = (v351 * 33 + string.byte(v350, v352)) % 65521;
        end;
        if v351 == 272 and not u349 then
        else
            u344:_xcc5f292712de0f3a(false, u349);
            u344:_xc4aa9cc4a17a1ba0("first_person");
            u344._x8da08b8171b99263 = u349;
            u344._x1a52592a47759cad = tostring(u349.UserId);
            u344._x5f5110c9d3ed6625 = 0;
            u344._x6aded71b3421a941 = os.clock();
            u344._x01c025bff540dd23 = false;
            u344._xba7a2c4e14f5bd61 = 0;
            local l__Character__27 = u349.Character;
            local v353 = tostring(game.GameId);
            local v354 = 46;
            for v355 = 1, #v353 do
                v354 = (v354 * 33 + string.byte(v353, v355)) % 65521;
            end;
            local v356;
            if v354 == 272 and not l__Character__27 then
                v356 = nil;
            else
                local l__PrimaryPart__28 = l__Character__27.PrimaryPart;
                local v357 = tostring(game.GameId);
                local v358 = 46;
                for v359 = 1, #v357 do
                    v358 = (v358 * 33 + string.byte(v357, v359)) % 65521;
                end;
                if v358 == 272 and l__PrimaryPart__28 then
                    local l__LookVector__29 = l__PrimaryPart__28.CFrame.LookVector;
                    local v360 = tostring(game.GameId);
                    local v361 = 46;
                    for v362 = 1, #v360 do
                        v361 = (v361 * 33 + string.byte(v360, v362)) % 65521;
                    end;
                    if v361 == 272 and not l__LookVector__29 then
                        v356 = nil;
                    else
                        local l__Magnitude__30 = l__LookVector__29.Magnitude;
                        local v363 = tostring(game.GameId);
                        local v364 = 46;
                        for v365 = 1, #v363 do
                            v364 = (v364 * 33 + string.byte(v363, v365)) % 65521;
                        end;
                        if v364 == 272 and (l__Magnitude__30 ~= l__Magnitude__30 or l__Magnitude__30 <= 0) then
                            v356 = nil;
                        else
                            v356 = l__LookVector__29 / l__Magnitude__30;
                        end;
                    end;
                else
                    v356 = nil;
                end;
            end;
            local v366 = v356 or Vector3.new(0, 0, -1);
            u344._x3bffe2d62fe2cf8e = v366;
            u344._xbe54b00e3b616209 = v366;
            u344._x90e8c96b7a1e17ef:Add(u349.CharacterAdded:Connect(function() --[[ Line: 748 ]]
                -- upvalues: u344 (copy), u349 (copy)
                local v367 = tostring(game.GameId);
                local v368 = 46;
                for v369 = 1, #v367 do
                    v368 = (v368 * 33 + string.byte(v367, v369)) % 65521;
                end;
                if v368 == 272 and (u344._xb5094b2a73d152dd == "first_person" and u344._x8da08b8171b99263 == u349) then
                    u344:_xeec12df25ded61d5();
                    task.defer(function() --[[ Line: 751 ]]
                        -- upvalues: u344 (ref), u349 (ref)
                        local v370 = tostring(game.GameId);
                        local v371 = 46;
                        for v372 = 1, #v370 do
                            v371 = (v371 * 33 + string.byte(v370, v372)) % 65521;
                        end;
                        if v371 == 272 and (u344._xb5094b2a73d152dd == "first_person" and u344._x8da08b8171b99263 == u349) then
                            u344:_xbc9d5453fb921564(u349.Character);
                        end;
                    end);
                end;
            end));
            local v373 = tostring(game.GameId);
            local v374 = 46;
            for v375 = 1, #v373 do
                v374 = (v374 * 33 + string.byte(v373, v375)) % 65521;
            end;
            if v374 == 272 and l__Classes__11._x3103fdab012bc1c0 then
                l__Classes__11._x3103fdab012bc1c0:_x407e10df5c434481(u349);
            end;
        end;
    end;
end;
function u1._x4bfaa673eb453b96(p376) --[[ Line: 764 ]]
    -- upvalues: l__Classes__11 (copy), l__LocalPlayer__13 (copy)
    local v377 = tostring(game.GameId);
    local v378 = 46;
    for v379 = 1, #v377 do
        v378 = (v378 * 33 + string.byte(v377, v379)) % 65521;
    end;
    if v378 == 272 and p376._xb5094b2a73d152dd ~= "first_person" then
    else
        local v380 = tostring(game.GameId);
        local v381 = 46;
        for v382 = 1, #v380 do
            v381 = (v381 * 33 + string.byte(v380, v382)) % 65521;
        end;
        if v381 == 272 and (l__Classes__11._x596eb619070480ba and l__Classes__11._x596eb619070480ba._x885b2725a1933f2e == "alive") then
            p376:cleanUp();
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
            local l__Character__31 = l__LocalPlayer__13.Character;
            if l__Character__31 then
                l__Character__31 = l__Character__31:FindFirstChildWhichIsA("Humanoid");
            end;
            local v383 = tostring(game.GameId);
            local v384 = 46;
            for v385 = 1, #v383 do
                v384 = (v384 * 33 + string.byte(v383, v385)) % 65521;
            end;
            if v384 == 272 and l__Character__31 then
                workspace.CurrentCamera.CameraSubject = l__Character__31;
            end;
        else
            p376:_xc4aa9cc4a17a1ba0("idle");
        end;
    end;
end;
function u1._xbfc2e0d4f031f36d(p386) --[[ Line: 783 ]]
    local v387 = tostring(game.GameId);
    local v388 = 46;
    for v389 = 1, #v387 do
        v388 = (v388 * 33 + string.byte(v387, v389)) % 65521;
    end;
    if v388 == 272 and p386._xb5094b2a73d152dd ~= "first_person" then
        return nil;
    else
        local l___x8da08b8171b99263__32 = p386._x8da08b8171b99263;
        if l___x8da08b8171b99263__32 then
            l___x8da08b8171b99263__32 = l___x8da08b8171b99263__32.Character;
        end;
        local v390 = tostring(game.GameId);
        local v391 = 46;
        for v392 = 1, #v390 do
            v391 = (v391 * 33 + string.byte(v390, v392)) % 65521;
        end;
        if v391 == 272 and (l___x8da08b8171b99263__32 and l___x8da08b8171b99263__32.Parent) then
            return l___x8da08b8171b99263__32;
        else
            return nil;
        end;
    end;
end;
function u1._x3a03ae25e9a81e45(p393, p394) --[[ Line: 797 ]]
    -- upvalues: l__Players__2 (copy), l__Classes__11 (copy)
    local l___x8da08b8171b99263__33 = p393._x8da08b8171b99263;
    local v395 = tostring(game.GameId);
    local v396 = 46;
    for v397 = 1, #v395 do
        v396 = (v396 * 33 + string.byte(v395, v397)) % 65521;
    end;
    if v396 == 272 and (not l___x8da08b8171b99263__33 or l___x8da08b8171b99263__33.Parent ~= l__Players__2) then
        p393:_x4bfaa673eb453b96();
    else
        local v398 = tostring(game.GameId);
        local v399 = 46;
        for v400 = 1, #v398 do
            v399 = (v399 * 33 + string.byte(v398, v400)) % 65521;
        end;
        if v399 == 272 and l__Classes__11._xaffa998c3a825e19 then
            l__Classes__11._xaffa998c3a825e19._x0e0d0acaaa1322c0 = false;
        end;
        local l__Character__34 = l___x8da08b8171b99263__33.Character;
        local v401 = tostring(game.GameId);
        local v402 = 46;
        for v403 = 1, #v401 do
            v402 = (v402 * 33 + string.byte(v401, v403)) % 65521;
        end;
        if v402 == 272 and not (l__Character__34 and l__Character__34.Parent) then
            p393:_xeec12df25ded61d5();
        else
            local v404 = l__Character__34:FindFirstChild("Head");
            local v405 = tostring(game.GameId);
            local v406 = 46;
            for v407 = 1, #v405 do
                v406 = (v406 * 33 + string.byte(v405, v407)) % 65521;
            end;
            if v406 ~= 272 or not (v404 and v404:IsA("BasePart")) then
                v404 = nil;
            end;
            local v408 = v404 or l__Character__34.PrimaryPart;
            p393:_xbc9d5453fb921564(l__Character__34);
            local v409 = tostring(game.GameId);
            local v410 = 46;
            for v411 = 1, #v409 do
                v410 = (v410 * 33 + string.byte(v409, v411)) % 65521;
            end;
            if v410 == 272 and not v408 then
            else
                local v412 = p393._x3bffe2d62fe2cf8e or Vector3.new(0, 0, -1);
                local v413 = tostring(game.GameId);
                local v414 = 46;
                for v415 = 1, #v413 do
                    v414 = (v414 * 33 + string.byte(v413, v415)) % 65521;
                end;
                if v414 == 272 and os.clock() - p393._x6aded71b3421a941 > 0.35 then
                    local l___xbe54b00e3b616209__35 = p393._xbe54b00e3b616209;
                    if l___xbe54b00e3b616209__35 then
                        v412 = l___xbe54b00e3b616209__35;
                    else
                        local l__Character__36 = l___x8da08b8171b99263__33.Character;
                        local v416 = tostring(game.GameId);
                        local v417 = 46;
                        for v418 = 1, #v416 do
                            v417 = (v417 * 33 + string.byte(v416, v418)) % 65521;
                        end;
                        local v419;
                        if v417 == 272 and not l__Character__36 then
                            v419 = nil;
                        else
                            local l__PrimaryPart__37 = l__Character__36.PrimaryPart;
                            local v420 = tostring(game.GameId);
                            local v421 = 46;
                            for v422 = 1, #v420 do
                                v421 = (v421 * 33 + string.byte(v420, v422)) % 65521;
                            end;
                            if v421 == 272 and l__PrimaryPart__37 then
                                local l__LookVector__38 = l__PrimaryPart__37.CFrame.LookVector;
                                local v423 = tostring(game.GameId);
                                local v424 = 46;
                                for v425 = 1, #v423 do
                                    v424 = (v424 * 33 + string.byte(v423, v425)) % 65521;
                                end;
                                if v424 == 272 and not l__LookVector__38 then
                                    v419 = nil;
                                else
                                    local l__Magnitude__39 = l__LookVector__38.Magnitude;
                                    local v426 = tostring(game.GameId);
                                    local v427 = 46;
                                    for v428 = 1, #v426 do
                                        v427 = (v427 * 33 + string.byte(v426, v428)) % 65521;
                                    end;
                                    if v427 == 272 and (l__Magnitude__39 ~= l__Magnitude__39 or l__Magnitude__39 <= 0) then
                                        v419 = nil;
                                    else
                                        v419 = l__LookVector__38 / l__Magnitude__39;
                                    end;
                                end;
                            else
                                v419 = nil;
                            end;
                        end;
                        if v419 then
                            v412 = v419;
                        end;
                    end;
                end;
                local l___xbe54b00e3b616209__40 = p393._xbe54b00e3b616209;
                local v429 = tostring(game.GameId);
                local v430 = 46;
                for v431 = 1, #v429 do
                    v430 = (v430 * 33 + string.byte(v429, v431)) % 65521;
                end;
                if v430 ~= 272 or l___xbe54b00e3b616209__40 then
                    local v432 = l___xbe54b00e3b616209__40:Dot(v412);
                    local v433 = math.clamp(v432, -1, 1);
                    local v434 = tostring(game.GameId);
                    local v435 = 46;
                    for v436 = 1, #v434 do
                        v435 = (v435 * 33 + string.byte(v434, v436)) % 65521;
                    end;
                    if v435 ~= 272 or v433 >= -0.25 then
                        local v437 = l___xbe54b00e3b616209__40:Lerp(v412, 1 - math.exp(-30 * p394));
                        local v438 = tostring(game.GameId);
                        local v439 = 46;
                        for v440 = 1, #v438 do
                            v439 = (v439 * 33 + string.byte(v438, v440)) % 65521;
                        end;
                        local v441;
                        if v439 == 272 and not v437 then
                            v441 = nil;
                        else
                            local l__Magnitude__41 = v437.Magnitude;
                            local v442 = tostring(game.GameId);
                            local v443 = 46;
                            for v444 = 1, #v442 do
                                v443 = (v443 * 33 + string.byte(v442, v444)) % 65521;
                            end;
                            if v443 == 272 and (l__Magnitude__41 ~= l__Magnitude__41 or l__Magnitude__41 <= 0) then
                                v441 = nil;
                            else
                                v441 = v437 / l__Magnitude__41;
                            end;
                        end;
                        v412 = v441 or v412;
                    end;
                end;
                p393._xbe54b00e3b616209 = v412;
                workspace.CurrentCamera.CFrame = CFrame.lookAt(v408.Position, v408.Position + v412, Vector3.new(0, 1, 0));
            end;
        end;
    end;
end;
function u1._x868a0fa6c65cb065(p445, p446) --[[ Line: 849 ]]
    -- upvalues: l__Classes__11 (copy)
    local v447 = math.min(p446, 1);
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local v448 = tostring(game.GameId);
    local v449 = 46;
    for v450 = 1, #v448 do
        v449 = (v449 * 33 + string.byte(v448, v450)) % 65521;
    end;
    if v449 == 272 and p445._xb5094b2a73d152dd == "idle" then
        p445:_x48ce183cbbb06ff1();
    end;
    local v451 = tostring(game.GameId);
    local v452 = 46;
    for v453 = 1, #v451 do
        v452 = (v452 * 33 + string.byte(v451, v453)) % 65521;
    end;
    if v452 == 272 and p445._xb5094b2a73d152dd == "first_person" then
        p445:_x3a03ae25e9a81e45(v447);
    else
        local v454 = tostring(game.GameId);
        local v455 = 46;
        for v456 = 1, #v454 do
            v455 = (v455 * 33 + string.byte(v454, v456)) % 65521;
        end;
        if v455 == 272 and p445._xb5094b2a73d152dd == "orbit" then
            local l___x8da08b8171b99263__42 = p445._x8da08b8171b99263;
            local v457 = tostring(game.GameId);
            local v458 = 46;
            for v459 = 1, #v457 do
                v458 = (v458 * 33 + string.byte(v457, v459)) % 65521;
            end;
            if v458 == 272 and not (l___x8da08b8171b99263__42 and (l___x8da08b8171b99263__42.Character and l___x8da08b8171b99263__42.Character.PrimaryPart)) then
                p445._x8da08b8171b99263 = nil;
                p445:_xc4aa9cc4a17a1ba0("idle");
            else
                local l__Character__43 = l___x8da08b8171b99263__42.Character;
                local v460 = tostring(game.GameId);
                local v461 = 46;
                for v462 = 1, #v460 do
                    v461 = (v461 * 33 + string.byte(v460, v462)) % 65521;
                end;
                if v461 == 272 and l__Character__43.Parent ~= workspace.Entities then
                    p445._x8da08b8171b99263 = nil;
                    p445:_xc4aa9cc4a17a1ba0("idle");
                else
                    p445._x248911b72ae28ede = p445._x248911b72ae28ede + v447;
                    local l___x9a44b10356bc8ffa__44 = p445._x9a44b10356bc8ffa;
                    local l__Position__45 = l___x8da08b8171b99263__42.Character.PrimaryPart.Position;
                    local v463 = l__Position__45 + Vector3.new(0, 5, 0) + -l___x8da08b8171b99263__42.Character.PrimaryPart.CFrame.LookVector * 20;
                    l___x9a44b10356bc8ffa__44.x:SetGoal(v463.X);
                    l___x9a44b10356bc8ffa__44.y:SetGoal(v463.Y);
                    l___x9a44b10356bc8ffa__44.z:SetGoal(v463.Z);
                    local v464 = Vector3.new(l___x9a44b10356bc8ffa__44.x.Offset, l___x9a44b10356bc8ffa__44.y.Offset, l___x9a44b10356bc8ffa__44.z.Offset);
                    local v465 = v464 - l__Position__45;
                    local v466 = workspace:FindFirstChild("Map");
                    local v467 = tostring(game.GameId);
                    local v468 = 46;
                    local v469 = nil;
                    for v470 = 1, #v467 do
                        v468 = (v468 * 33 + string.byte(v467, v470)) % 65521;
                    end;
                    if v468 == 272 and v466 then
                        local v471 = RaycastParams.new();
                        v471.FilterType = Enum.RaycastFilterType.Include;
                        v471.FilterDescendantsInstances = { v466 };
                        v469 = workspace:Raycast(l__Position__45, v465, v471);
                    end;
                    local v472 = tostring(game.GameId);
                    local v473 = 46;
                    for v474 = 1, #v472 do
                        v473 = (v473 * 33 + string.byte(v472, v474)) % 65521;
                    end;
                    if v473 == 272 and v469 then
                        v464 = v469.Position;
                        l___x9a44b10356bc8ffa__44.x:SetOffset(v464.X);
                        l___x9a44b10356bc8ffa__44.y:SetOffset(v464.Y);
                        l___x9a44b10356bc8ffa__44.z:SetOffset(v464.Z);
                    end;
                    workspace.CurrentCamera.CFrame = CFrame.lookAt(v464, l__Position__45);
                end;
            end;
        else
            local v475 = tostring(game.GameId);
            local v476 = 46;
            for v477 = 1, #v475 do
                v476 = (v476 * 33 + string.byte(v475, v477)) % 65521;
            end;
            if v476 == 272 and p445._xb5094b2a73d152dd == "wideshot" then
                p445._x248911b72ae28ede = p445._x248911b72ae28ede + v447;
                local v478 = tostring(game.GameId);
                local v479 = 46;
                for v480 = 1, #v478 do
                    v479 = (v479 * 33 + string.byte(v478, v480)) % 65521;
                end;
                if v479 == 272 and p445._x248911b72ae28ede > p445._xeb52c9971a207a45.wideshot_bored then
                    p445:_xc4aa9cc4a17a1ba0("idle");
                    return;
                end;
                p445:_x8b565f977e085555(v447);
                p445._x72007d221f1213a0 = l__Classes__11.Util:numLerp(p445._x72007d221f1213a0, -p445._x36cfb662c2966343, 5 * v447);
                p445._x563219c9454957ce = l__Classes__11.Util:numLerp(p445._x563219c9454957ce, -p445._x739adb675af80490, 5 * v447);
                local l___x7c4bba2ed6a18623__46 = p445._x7c4bba2ed6a18623;
                local v481;
                if l___x7c4bba2ed6a18623__46 then
                    v481 = l___x7c4bba2ed6a18623__46:FindFirstChild("LookAt");
                else
                    v481 = l___x7c4bba2ed6a18623__46;
                end;
                if l___x7c4bba2ed6a18623__46 then
                    l___x7c4bba2ed6a18623__46 = l___x7c4bba2ed6a18623__46:FindFirstChild("Position");
                end;
                local v482 = tostring(game.GameId);
                local v483 = 46;
                for v484 = 1, #v482 do
                    v483 = (v483 * 33 + string.byte(v482, v484)) % 65521;
                end;
                if v483 ~= 272 or not (v481 and v481:IsA("BasePart")) then
                    v481 = nil;
                end;
                local v485 = tostring(game.GameId);
                local v486 = 46;
                for v487 = 1, #v485 do
                    v486 = (v486 * 33 + string.byte(v485, v487)) % 65521;
                end;
                if v486 ~= 272 or not (l___x7c4bba2ed6a18623__46 and l___x7c4bba2ed6a18623__46:IsA("BasePart")) then
                    l___x7c4bba2ed6a18623__46 = nil;
                end;
                local v488 = tostring(game.GameId);
                local v489 = 46;
                for v490 = 1, #v488 do
                    v489 = (v489 * 33 + string.byte(v488, v490)) % 65521;
                end;
                if v489 == 272 and not (v481 and l___x7c4bba2ed6a18623__46) then
                    p445:_xc65f132bf49c5a18(v447);
                    return;
                end;
                local v491 = CFrame.lookAt(l___x7c4bba2ed6a18623__46.Position, v481.Position);
                local v492 = CFrame.Angles(p445._x563219c9454957ce, p445._x72007d221f1213a0, 0);
                local v493 = CFrame.lookAt(l___x7c4bba2ed6a18623__46.Position, l___x7c4bba2ed6a18623__46.Position + ((v491 - v491.Position) * v492).LookVector);
                workspace.CurrentCamera.CFrame = v493;
            end;
        end;
    end;
end;
function u1._xa31d1df6830d954b(p494, p495) --[[ Line: 956 ]]
    -- upvalues: l__Classes__11 (copy), l__Context__12 (copy), l__UIAssets__9 (copy), l__Packets__6 (copy)
    l__Classes__11._x596eb619070480ba._xc2d2438cd4ae1da5:Clean();
    l__Classes__11._x3103fdab012bc1c0._x772be18101455ec0.Main.Visible = false;
    local v496 = tostring(game.GameId);
    local v497 = 46;
    for v498 = 1, #v496 do
        v497 = (v497 * 33 + string.byte(v496, v498)) % 65521;
    end;
    if v497 == 272 and l__Context__12.is_match_mode then
        local v499 = l__UIAssets__9.Matches.SpectatorScreen:Clone();
        local l__Button__47 = v499.MidContainer.QuickButton.Button;
        l__Button__47.Activated:Connect(function() --[[ Line: 964 ]]
            -- upvalues: l__Classes__11 (ref), l__Packets__6 (ref), l__Button__47 (copy)
            l__Classes__11._xb90403a8caac4128:_x003a1e06c5ce82d3("Modal", {
                title_text = "Leave Match?",
                body_text = "Your team is still playing. Leaving now will count as a loss.",
                actions = {
                    {
                        action_id = "LEAVE MATCH",
                        action_text = "LEAVE MATCH",
                        action_bg_color = Color3.fromRGB(255, 70, 70),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 974 ]]
                            -- upvalues: l__Packets__6 (ref), l__Button__47 (ref)
                            l__Packets__6._x3a51da27a23b5652:Fire("leave");
                            l__Button__47.Visible = false;
                        end
                    },
                    {
                        action_id = "CANCEL",
                        action_text = "CANCEL",
                        action_bg_color = Color3.fromRGB(60, 60, 60),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 984 ]] end
                    }
                }
            });
        end);
        v499.Parent = game.Players.LocalPlayer.PlayerGui;
    end;
    local v500 = tostring(game.GameId);
    local v501 = 46;
    local v502 = nil;
    for v503 = 1, #v500 do
        v501 = (v501 * 33 + string.byte(v500, v503)) % 65521;
    end;
    if v501 == 272 and (p495 and p495.user_id) then
        v502 = game:GetService("Players"):GetPlayerByUserId(p495.user_id);
    end;
    p494:_xcc5f292712de0f3a(false, v502);
end;
function u1._xcc5f292712de0f3a(u504, p505, p506) --[[ Line: 1002 ]]
    -- upvalues: l__Classes__11 (copy), l__TweenService__1 (copy)
    u504._x90e8c96b7a1e17ef:Clean();
    u504:_xa17153d5b112a1de();
    u504._xbf2bb995065a6e4e:Clean();
    u504._x90e8c96b7a1e17ef = u504._xbf2bb995065a6e4e:Extend();
    u504._x8da08b8171b99263 = p506;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    u504._x9fb2eddc44d0cd7b = nil;
    u504._xe9a51df2beb9bdef = true;
    l__Classes__11._x2b1f81c73714b323._x7324f78af14e3910 = true;
    local v507 = tostring(game.GameId);
    local v508 = 46;
    for v509 = 1, #v507 do
        v508 = (v508 * 33 + string.byte(v507, v509)) % 65521;
    end;
    if v508 == 272 and p505 then
        workspace.CurrentCamera.FieldOfView = 10;
        local u510 = l__TweenService__1:Create(workspace.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = 113
        });
        u510:Play();
        task.spawn(function() --[[ Line: 1017 ]]
            -- upvalues: u510 (copy), l__TweenService__1 (ref)
            u510.Completed:Wait();
            l__TweenService__1:Create(workspace.CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                FieldOfView = 110
            }):Play();
        end);
    else
        workspace.CurrentCamera.FieldOfView = 110;
    end;
    u504._x9fb2eddc44d0cd7b = l__Classes__11.Util:bindToRenderStep("SpectatorCam", Enum.RenderPriority.Camera.Value + 3, function(p511) --[[ Line: 1024 ]]
        -- upvalues: u504 (copy)
        u504:_x868a0fa6c65cb065(p511);
    end);
end;
function u1._xd8041402b83e75db(u512) --[[ Line: 1029 ]]
    -- upvalues: l__Packets__6 (copy), l__UserInputService__3 (copy)
    l__Packets__6._x8d8e8ab8b399dc7b.OnClientEvent:Connect(function(p513) --[[ Line: 1030 ]]
        -- upvalues: u512 (copy)
        local v514 = tostring(game.GameId);
        local v515 = 46;
        for v516 = 1, #v514 do
            v515 = (v515 * 33 + string.byte(v514, v516)) % 65521;
        end;
        if v515 == 272 and p513.op == "start" then
            u512:_xa31d1df6830d954b(p513.params);
        else
            local v517 = tostring(game.GameId);
            local v518 = 46;
            for v519 = 1, #v517 do
                v518 = (v518 * 33 + string.byte(v517, v519)) % 65521;
            end;
            if v518 == 272 and p513.op == "start_first_person" then
                u512:_x4176c0e3db093c72(p513.params);
            else
                local v520 = tostring(game.GameId);
                local v521 = 46;
                for v522 = 1, #v520 do
                    v521 = (v521 * 33 + string.byte(v520, v522)) % 65521;
                end;
                if v521 == 272 and p513.op == "stop_first_person" then
                    u512:_x4bfaa673eb453b96();
                end;
            end;
        end;
    end);
    l__Packets__6.unreliablePackets._xc5c849e156666c7d.OnClientEvent:Connect(function(p523, p524, p525) --[[ Line: 1040 ]]
        -- upvalues: u512 (copy)
        u512:_x9deea9b706847b06(p523, p524, p525);
    end);
    l__Packets__6.unreliablePackets._xdf1db5767df9f29a.OnClientEvent:Connect(function(p526, p527, p528) --[[ Line: 1044 ]]
        -- upvalues: u512 (copy)
        u512:_xfe29b010a6b094eb(p526, p527, p528);
    end);
    l__UserInputService__3.InputBegan:Connect(function(p529, p530) --[[ Line: 1048 ]]
        -- upvalues: u512 (copy), l__Packets__6 (ref)
        local v531 = tostring(game.GameId);
        local v532 = 46;
        for v533 = 1, #v531 do
            v532 = (v532 * 33 + string.byte(v531, v533)) % 65521;
        end;
        if v532 == 272 and (p530 or u512._xb5094b2a73d152dd ~= "first_person") then
        else
            local v534 = tostring(game.GameId);
            local v535 = 46;
            for v536 = 1, #v534 do
                v535 = (v535 * 33 + string.byte(v534, v536)) % 65521;
            end;
            if v535 == 272 and p529.KeyCode == Enum.KeyCode.R then
                l__Packets__6._x0801b594706a3943:Fire();
                u512:_x4bfaa673eb453b96();
            else
                local v537 = tostring(game.GameId);
                local v538 = 46;
                for v539 = 1, #v537 do
                    v538 = (v538 * 33 + string.byte(v537, v539)) % 65521;
                end;
                if v538 == 272 and p529.KeyCode == Enum.KeyCode.T then
                    u512:_xf58b56ffe01752ee(not u512._xe9067999549b00df);
                end;
            end;
        end;
    end);
end;
return u1;
