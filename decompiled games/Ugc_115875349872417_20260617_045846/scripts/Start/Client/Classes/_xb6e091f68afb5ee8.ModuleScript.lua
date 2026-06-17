-- Decompiled from: Start.Client.Classes._xb6e091f68afb5ee8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
local function u25(p11) --[[ Line: 103 ]]
    -- upvalues: u10 (copy)
    local v12 = p11:FindFirstChild("CameraAngles");
    local v13 = nil;
    local v14 = nil;
    for _, v15 in p11:GetDescendants() do
        if not (v12 and v15:IsDescendantOf(v12)) and v15:IsA("BasePart") then
            local v16, v17 = u10(v15);
            if v13 and v14 then
                local v18 = math.min(v13.X, v16.X);
                local v19 = math.min(v13.Y, v16.Y);
                local v20 = math.min(v13.Z, v16.Z);
                v13 = Vector3.new(v18, v19, v20);
                local v21 = math.max(v14.X, v17.X);
                local v22 = math.max(v14.Y, v17.Y);
                local v23 = math.max(v14.Z, v17.Z);
                v14 = Vector3.new(v21, v22, v23);
            else
                v14 = v17;
                v13 = v16;
            end;
        end;
    end;
    if not (v13 and v14) then
        return nil, nil;
    end;
    local v24 = v14 - v13;
    return v13 + v24 * 0.5, v24;
end;
function u1._x83ed94bfb82a8c9f() --[[ Line: 145 ]]
    -- upvalues: u1 (copy), l__Trove__7 (copy), l__Spring__8 (copy)
    local v26 = setmetatable({}, u1);
    v26._xaa6f21863ddef024 = l__Trove__7.new();
    v26._xb5985ac0e787235b = "idle";
    v26._x1183cbeaf44ac72d = nil;
    v26._xf529fbd889120f93 = nil;
    v26._xd5f26d793f25fa67 = false;
    v26._x48174dcb448bdfc3 = v26._xaa6f21863ddef024:Extend();
    v26._x3c9b438843b29d37 = 0;
    v26._xb11f1d37bd1209ed = {
        x = l__Spring__8.fromFrequency(5, 4, 1),
        y = l__Spring__8.fromFrequency(5, 4, 1),
        z = l__Spring__8.fromFrequency(5, 4, 1)
    };
    v26._x0347714e73359edf = {
        wideshot_bored = 3
    };
    for _, v27 in pairs(v26._xb11f1d37bd1209ed) do
        v27:SnapToCriticalDamping();
    end;
    v26._xf534fb952eeeece6 = game:GetService("UserInputService"):GetMouseLocation();
    v26._xc4db3fd95f0215c0 = 0;
    v26._x603643e6312fb8c4 = 0;
    v26._x2977bf44a7efa09c = 0;
    v26._x1e1f979664bfda47 = 0;
    v26._x49b6903ce59690e2 = 0;
    v26._x2d1827fa14d186a5 = Vector3.new(0, 8, 0);
    v26._x822a09d97dfb93cf = Vector3.new(80, 45, 80);
    v26._xcf8a6f1de06b2678 = l__Trove__7.new();
    v26._x6de7d3b28195c724 = nil;
    v26._x3aea1ca71bde7ecf = nil;
    v26._x2b1b09e38d7356ff = nil;
    v26._xa262b6a461e8c64a = nil;
    v26._x615fbc5fb011c379 = 0;
    v26._xfdcf18e05b15a135 = Vector3.new(0, 0, -1);
    v26._x6f1b7d0cf08230e4 = nil;
    v26._x8b292ebec131900d = 0;
    v26._xcd2578a9b40cdfb4 = false;
    v26._xa9b21458f13dec02 = 0;
    v26._x6305f3142a4e4f55 = false;
    v26._xce143dd6dae8d761 = l__Trove__7.new();
    v26._x013e93fee8bdd1c9 = {};
    return v26;
end;
function u1.cleanUp(p28) --[[ Line: 203 ]]
    -- upvalues: l__Classes__11 (copy)
    p28._x48174dcb448bdfc3:Clean();
    p28:_x72753062c040d439();
    p28._xaa6f21863ddef024:Clean();
    p28._x48174dcb448bdfc3 = p28._xaa6f21863ddef024:Extend();
    p28._xb5985ac0e787235b = "idle";
    p28._x1183cbeaf44ac72d = nil;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    p28._xc3594590660ea585 = nil;
    p28._xd5f26d793f25fa67 = false;
    l__Classes__11._xdca80115d2839102._x711166f3dabb680d = false;
end;
function u1._x11bab4bb7fbe5abf(p29) --[[ Line: 216 ]]
    -- upvalues: l__Classes__11 (copy)
    if not p29._xd5f26d793f25fa67 then
        return false;
    end;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    p29._xc3594590660ea585 = nil;
    p29._xd5f26d793f25fa67 = false;
    return true;
end;
function u1._x991ac628e05c66da(p30, p31) --[[ Line: 228 ]]
    if p30._xd5f26d793f25fa67 then
    else
        p30:_xba28441e0836bc41(false, p31 or p30._x1183cbeaf44ac72d);
    end;
end;
function u1._x74e65eb5faef2d24(p32, p33) --[[ Line: 236 ]]
    if p32._xb5985ac0e787235b == "first_person" then
        p32:_x72753062c040d439();
    end;
    p32._x48174dcb448bdfc3:Clean();
    p32._x3c9b438843b29d37 = 0;
    p32._xb5985ac0e787235b = p33;
end;
function u1._xb50ca1137c641cbc(p34) --[[ Line: 246 ]]
    p34._xcf8a6f1de06b2678:Clean();
    p34._x6de7d3b28195c724 = nil;
    p34._x3aea1ca71bde7ecf = nil;
    p34._x2b1b09e38d7356ff = nil;
end;
function u1._x53dee63e1415e1d6(p35, p36, u37) --[[ Line: 253 ]]
    -- upvalues: u3 (copy)
    if p36 and p36.Parent then
        if p35._x6de7d3b28195c724 == p36 and p35._x3aea1ca71bde7ecf == u37 then
        else
            p35:_xb50ca1137c641cbc();
            p35._x6de7d3b28195c724 = p36;
            p35._x3aea1ca71bde7ecf = u37;
            local u38 = {};
            p35._x2b1b09e38d7356ff = u38;
            local function u40(p39) --[[ Line: 299 ]]
                -- upvalues: u38 (copy), u3 (ref)
                if u38[p39] then
                elseif p39:IsA("BasePart") then
                    u38[p39] = {
                        local_transparency_modifier = p39.LocalTransparencyModifier
                    };
                    p39.LocalTransparencyModifier = 1;
                elseif p39:IsA("Decal") then
                    u38[p39] = {
                        transparency = p39.Transparency
                    };
                    p39.Transparency = 1;
                else
                    if u3(p39) then
                        u38[p39] = {
                            enabled = p39.Enabled
                        };
                        p39.Enabled = false;
                    end;
                end;
            end;
            local function u43(p41) --[[ Line: 277 ]]
                -- upvalues: u38 (copy), u37 (copy)
                if not u38[p41] then
                    local v42;
                    if u37 then
                        v42 = p41 == u37 and true or p41:IsDescendantOf(u37);
                    else
                        v42 = false;
                    end;
                    if not v42 then
                        if p41:IsA("BasePart") then
                            u38[p41] = {
                                local_transparency_modifier = p41.LocalTransparencyModifier
                            };
                            if p41.Parent and p41.Parent:IsA("Accessory") then
                                p41.LocalTransparencyModifier = math.max(p41.LocalTransparencyModifier, 1);
                            else
                                p41.LocalTransparencyModifier = math.max(p41.LocalTransparencyModifier, 0.97);
                            end;
                        else
                            if p41:IsA("Decal") then
                                u38[p41] = {
                                    transparency = p41.Transparency
                                };
                                p41.Transparency = math.max(p41.Transparency, 0.97);
                            end;
                        end;
                    end;
                end;
            end;
            for _, v44 in p36:GetDescendants() do
                u43(v44);
            end;
            if u37 then
                u40(u37);
                for _, v45 in u37:GetDescendants() do
                    u40(v45);
                end;
            end;
            p35._xcf8a6f1de06b2678:Connect(p36.DescendantAdded, function(p46) --[[ Line: 332 ]]
                -- upvalues: u37 (copy), u40 (copy), u43 (copy)
                local v47;
                if u37 then
                    v47 = p46 == u37 and true or p46:IsDescendantOf(u37);
                else
                    v47 = false;
                end;
                if v47 then
                    u40(p46);
                else
                    u43(p46);
                end;
            end);
            p35._xcf8a6f1de06b2678:Add(function() --[[ Line: 340 ]]
                -- upvalues: u38 (copy), u3 (ref)
                for v48, v49 in u38 do
                    if v48 and v48.Parent then
                        if v49.local_transparency_modifier == nil or not v48:IsA("BasePart") then
                            if v49.transparency == nil or not v48:IsA("Decal") then
                                if v49.enabled ~= nil and u3(v48) then
                                    v48.Enabled = v49.enabled;
                                end;
                            else
                                v48.Transparency = v49.transparency;
                            end;
                        else
                            v48.LocalTransparencyModifier = v49.local_transparency_modifier;
                        end;
                    end;
                end;
            end);
        end;
    end;
end;
function u1._x72753062c040d439(p50) --[[ Line: 357 ]]
    -- upvalues: l__Classes__11 (copy)
    p50:_xb50ca1137c641cbc();
    p50:_x4c8f22ae19e9cadf(false);
    if l__Classes__11._x6a15bbeeb97caae0 then
        l__Classes__11._x6a15bbeeb97caae0:_xe3f2a9674668048b();
    end;
    p50._xa262b6a461e8c64a = nil;
    p50._x615fbc5fb011c379 = 0;
    p50._xfdcf18e05b15a135 = Vector3.new(0, 0, -1);
    p50._x6f1b7d0cf08230e4 = nil;
    p50._x8b292ebec131900d = 0;
    p50._xcd2578a9b40cdfb4 = false;
    p50._xa9b21458f13dec02 = 0;
end;
function u1._x2cc19208919584d8(p51, p52) --[[ Line: 374 ]]
    if p52 and p52.Parent then
        local v53 = p52:FindFirstChild("Head");
        if not (v53 and v53:IsA("BasePart")) then
            v53 = nil;
        end;
        p51:_x53dee63e1415e1d6(p52, v53);
    else
        p51:_xb50ca1137c641cbc();
    end;
end;
local function u60() --[[ Line: 385 ]]
    -- upvalues: l__Players__2 (copy)
    local v54 = {};
    for _, v55 in game:GetService("ReplicatedStorage").ReadOnly.Players:GetChildren() do
        local v56 = v55:FindFirstChild("in_combat");
        local v57 = v55:FindFirstChild("status");
        if v56 and v57 and (v56.Value and v57.Value == "alive") then
            local v58 = tonumber(v55.Name);
            local v59;
            if v58 then
                v59 = l__Players__2:GetPlayerByUserId(v58);
            else
                v59 = nil;
            end;
            if v59 then
                table.insert(v54, v59);
            end;
        end;
    end;
    return v54;
end;
function u1._x4a0abb93d8179f29(u61) --[[ Line: 409 ]]
    -- upvalues: u60 (copy), l__Classes__11 (copy)
    local u62 = workspace:FindFirstChild("Map");
    local u63;
    if u62 then
        u63 = u62:FindFirstChild("CameraAngles");
    else
        u63 = u62;
    end;
    local v64 = u60();
    local function u82(p65) --[[ Line: 415 ]]
        -- upvalues: u61 (copy), l__Classes__11 (ref), u82 (copy)
        u61:_x74e65eb5faef2d24("orbit");
        u61._x1183cbeaf44ac72d = p65;
        local l___xdf1bd3441ba6f71a__19 = l__Classes__11._xdf1bd3441ba6f71a;
        local v66 = l___xdf1bd3441ba6f71a__19:_xb9853b4b7ca133d8(u61._x1183cbeaf44ac72d, "wasHit");
        local v67 = l___xdf1bd3441ba6f71a__19:_xb9853b4b7ca133d8(u61._x1183cbeaf44ac72d, "clashed");
        local v68 = l___xdf1bd3441ba6f71a__19:_xb9853b4b7ca133d8(u61._x1183cbeaf44ac72d, "wasParried");
        local v69 = l___xdf1bd3441ba6f71a__19:_xb9853b4b7ca133d8(u61._x1183cbeaf44ac72d, "wasKilled");
        if v66 and (v67 and (v68 and v69)) then
            local v72 = v66:Connect(function(p70) --[[ Line: 439 ]]
                -- upvalues: u82 (ref)
                local v71 = game:GetService("Players"):GetPlayerFromCharacter(p70);
                if v71 then
                    u82(v71);
                end;
            end);
            local v75 = v67:Connect(function(p73) --[[ Line: 443 ]]
                -- upvalues: u82 (ref)
                local v74 = game:GetService("Players"):GetPlayerFromCharacter(p73);
                if v74 then
                    u82(v74);
                end;
            end);
            local v78 = v68:Connect(function(p76) --[[ Line: 447 ]]
                -- upvalues: u82 (ref)
                local v77 = game:GetService("Players"):GetPlayerFromCharacter(p76);
                if v77 then
                    u82(v77);
                end;
            end);
            local v81 = v69:Connect(function(p79) --[[ Line: 451 ]]
                -- upvalues: u82 (ref)
                local v80 = game:GetService("Players"):GetPlayerFromCharacter(p79);
                if v80 then
                    u82(v80);
                end;
            end);
            u61._x48174dcb448bdfc3:Add(v72);
            u61._x48174dcb448bdfc3:Add(v75);
            u61._x48174dcb448bdfc3:Add(v78);
            u61._x48174dcb448bdfc3:Add(v81);
        else
            u61._x1183cbeaf44ac72d = nil;
            u61:_x74e65eb5faef2d24("idle");
        end;
    end;
    local function v84() --[[ Line: 461 ]]
        -- upvalues: u61 (copy), u62 (copy), u63 (copy)
        u61:_x74e65eb5faef2d24("wideshot");
        u61._x1183cbeaf44ac72d = nil;
        u61._xf529fbd889120f93 = nil;
        u61:_x4e8d0d4f9e120777(u62);
        if u63 then
            local v83 = u63:GetChildren();
            if #v83 > 0 then
                u61._xf529fbd889120f93 = v83[math.random(1, #v83)];
            end;
        end;
    end;
    local function v86(p85) --[[ Line: 475 ]]
        -- upvalues: u82 (copy), u61 (copy)
        u82(p85);
        local l___x1183cbeaf44ac72d__20 = u61._x1183cbeaf44ac72d;
        if l___x1183cbeaf44ac72d__20 then
            l___x1183cbeaf44ac72d__20 = u61._x1183cbeaf44ac72d.Character;
        end;
        if l___x1183cbeaf44ac72d__20 then
            l___x1183cbeaf44ac72d__20 = l___x1183cbeaf44ac72d__20.PrimaryPart;
        end;
        if l___x1183cbeaf44ac72d__20 then
            local l__Position__21 = l___x1183cbeaf44ac72d__20.Position;
            u61._xb11f1d37bd1209ed.x:SetOffset(l__Position__21.X, true);
            u61._xb11f1d37bd1209ed.y:SetOffset(l__Position__21.Y, true);
            u61._xb11f1d37bd1209ed.z:SetOffset(l__Position__21.Z, true);
        end;
    end;
    if u61._x1183cbeaf44ac72d then
        v86(u61._x1183cbeaf44ac72d);
    elseif #v64 > 0 then
        v86(v64[math.random(1, #v64)]);
    else
        v84();
    end;
end;
function u1._x039baed3a67b85e2(p87, _) --[[ Line: 499 ]]
    local v88 = game:GetService("UserInputService"):GetMouseLocation();
    local v89 = v88 - p87._xf534fb952eeeece6;
    p87._xf534fb952eeeece6 = v88;
    p87._x2977bf44a7efa09c = p87._x2977bf44a7efa09c + v89.X * 0.0002;
    p87._x1e1f979664bfda47 = p87._x1e1f979664bfda47 + v89.Y * 0.0002;
    p87._x2977bf44a7efa09c = math.clamp(p87._x2977bf44a7efa09c, -0.5, 0.5);
    p87._x1e1f979664bfda47 = math.clamp(p87._x1e1f979664bfda47, -0.3, 0.3);
end;
function u1._x4e8d0d4f9e120777(p90, p91) --[[ Line: 514 ]]
    -- upvalues: u25 (copy)
    local v92 = Vector3.new(0, 8, 0);
    local v93 = Vector3.new(80, 45, 80);
    local v94, v95;
    if p91 then
        v94, v95 = u25(p91);
        if v94 then
            if not v95 then
                v95 = v93;
                v94 = v92;
            end;
        else
            v95 = v93;
            v94 = v92;
        end;
    else
        v95 = v93;
        v94 = v92;
    end;
    p90._x2d1827fa14d186a5 = v94;
    p90._x822a09d97dfb93cf = v95;
end;
function u1._xe8fc747f42e38f9a(p96, p97) --[[ Line: 534 ]]
    local l___x2d1827fa14d186a5__22 = p96._x2d1827fa14d186a5;
    local l___x822a09d97dfb93cf__23 = p96._x822a09d97dfb93cf;
    local v98 = math.max(l___x822a09d97dfb93cf__23.X, l___x822a09d97dfb93cf__23.Z);
    local v99 = math.clamp(v98 * 0.9, 80, 320);
    local v100 = math.max(l___x822a09d97dfb93cf__23.Y * 1.1, v98 * 0.35);
    local v101 = math.clamp(v100, 45, 180);
    p96._x49b6903ce59690e2 = p96._x49b6903ce59690e2 + p97 * 0.08;
    local v102 = p96._x49b6903ce59690e2 + p96._xc4db3fd95f0215c0;
    local v103 = v101 + p96._x603643e6312fb8c4 * v99;
    local v104 = l___x2d1827fa14d186a5__22 + CFrame.Angles(0, v102, 0):VectorToWorldSpace((Vector3.new(0, v103, v99)));
    workspace.CurrentCamera.CFrame = CFrame.lookAt(v104, l___x2d1827fa14d186a5__22);
end;
function u1._x643dd9e7137f85f1(p105, p106, p107, p108) --[[ Line: 557 ]]
    if p105._xb5985ac0e787235b == "first_person" then
        if p106 == p105._xa262b6a461e8c64a then
            if p108 <= p105._x615fbc5fb011c379 then
            else
                local v109;
                if p107 then
                    local l__Magnitude__24 = p107.Magnitude;
                    if l__Magnitude__24 == l__Magnitude__24 and l__Magnitude__24 > 0 then
                        v109 = p107 / l__Magnitude__24;
                    else
                        v109 = nil;
                    end;
                else
                    v109 = nil;
                end;
                if v109 then
                    p105._x615fbc5fb011c379 = p108;
                    p105._xfdcf18e05b15a135 = v109;
                    p105._x8b292ebec131900d = os.clock();
                    if not (p105._xcd2578a9b40cdfb4 and p105._x6f1b7d0cf08230e4) then
                        p105._x6f1b7d0cf08230e4 = v109;
                    end;
                    p105._xcd2578a9b40cdfb4 = true;
                end;
            end;
        end;
    end;
end;
function u1._x01a647466d3bd153(p110, p111, p112, p113) --[[ Line: 586 ]]
    -- upvalues: l__Classes__11 (copy)
    if p110._xb5985ac0e787235b == "first_person" then
        if p111 == p110._xa262b6a461e8c64a then
            if p113 <= p110._xa9b21458f13dec02 then
            elseif typeof(p112) == "table" then
                p110._xa9b21458f13dec02 = p113;
                if l__Classes__11._x6a15bbeeb97caae0 then
                    l__Classes__11._x6a15bbeeb97caae0:_xa289f60345f4f436(p112);
                end;
            end;
        end;
    end;
end;
function u1._xe967f7d4e9837ac9(p114) --[[ Line: 610 ]]
    for _, v115 in p114._x013e93fee8bdd1c9 do
        if v115 then
            v115:Destroy();
        end;
    end;
    table.clear(p114._x013e93fee8bdd1c9);
end;
function u1._xd8eb0289ac72bacd(p116, p117) --[[ Line: 619 ]]
    local v118 = p116._x013e93fee8bdd1c9[p117];
    if v118 then
        v118:Destroy();
        p116._x013e93fee8bdd1c9[p117] = nil;
    end;
end;
function u1._x35da7a285fefe658(p119, p120) --[[ Line: 627 ]]
    local v121 = p119._x013e93fee8bdd1c9[p120];
    if v121 and v121.Parent then
        return v121;
    end;
    local v122 = Instance.new("Highlight");
    v122.Name = "SpectateWallhackHighlight";
    v122.FillColor = Color3.fromRGB(255, 255, 255);
    v122.OutlineColor = Color3.fromRGB(255, 255, 255);
    v122.FillTransparency = 0.5;
    v122.OutlineTransparency = 0.5;
    v122.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v122.Adornee = p120;
    v122.Parent = p120;
    p119._x013e93fee8bdd1c9[p120] = v122;
    return v122;
end;
function u1._x3d76088d33b7fc69(p123) --[[ Line: 647 ]]
    -- upvalues: l__Classes__11 (copy)
    if p123._x6305f3142a4e4f55 then
        local v124 = workspace:FindFirstChild("Entities");
        if v124 then
            local l__Position__25 = workspace.CurrentCamera.CFrame.Position;
            local v125 = {};
            for _, v126 in v124:GetChildren() do
                local v127 = l__Classes__11.Util:getLikelyVec3(v126);
                if v127 then
                    if l__Classes__11.Util:hasLineOfSight(l__Position__25, v127) then
                        p123:_xd8eb0289ac72bacd(v126);
                    else
                        v125[v126] = true;
                        p123:_x35da7a285fefe658(v126);
                    end;
                else
                    p123:_xd8eb0289ac72bacd(v126);
                end;
            end;
            local v128 = {};
            for v129, _ in p123._x013e93fee8bdd1c9 do
                if not (v125[v129] and v129.Parent) then
                    table.insert(v128, v129);
                end;
            end;
            for _, v130 in v128 do
                p123:_xd8eb0289ac72bacd(v130);
            end;
        else
            p123:_xe967f7d4e9837ac9();
        end;
    end;
end;
function u1._x4c8f22ae19e9cadf(u131, p132) --[[ Line: 689 ]]
    -- upvalues: l__RunService__4 (copy)
    if u131._x6305f3142a4e4f55 == p132 and p132 then
    else
        u131._x6305f3142a4e4f55 = p132;
        u131._xce143dd6dae8d761:Clean();
        u131:_xe967f7d4e9837ac9();
        if p132 then
            local u133 = 0.12;
            u131._xce143dd6dae8d761:Connect(l__RunService__4.Heartbeat, function(p134) --[[ Line: 703 ]]
                -- upvalues: u131 (copy), u133 (ref)
                if u131._xb5985ac0e787235b == "first_person" then
                    u133 = u133 + p134;
                    if u133 < 0.12 then
                    else
                        u133 = 0;
                        u131:_x3d76088d33b7fc69();
                    end;
                else
                    u131:_x4c8f22ae19e9cadf(false);
                end;
            end);
            u131:_x3d76088d33b7fc69();
        end;
    end;
end;
function u1._xa75e0550e312f1eb(u135, p136) --[[ Line: 721 ]]
    -- upvalues: l__Players__2 (copy), l__Classes__11 (copy)
    u135:_xb50ca1137c641cbc();
    if p136 then
        p136 = p136.user_id;
    end;
    if typeof(p136) == "number" then
        local u137 = l__Players__2:GetPlayerByUserId(p136);
        if u137 then
            u135:_xba28441e0836bc41(false, u137);
            u135:_x74e65eb5faef2d24("first_person");
            u135._x1183cbeaf44ac72d = u137;
            u135._xa262b6a461e8c64a = tostring(u137.UserId);
            u135._x615fbc5fb011c379 = 0;
            u135._x8b292ebec131900d = os.clock();
            u135._xcd2578a9b40cdfb4 = false;
            u135._xa9b21458f13dec02 = 0;
            local l__Character__26 = u137.Character;
            local v138;
            if l__Character__26 then
                local l__PrimaryPart__27 = l__Character__26.PrimaryPart;
                if l__PrimaryPart__27 then
                    local l__LookVector__28 = l__PrimaryPart__27.CFrame.LookVector;
                    if l__LookVector__28 then
                        local l__Magnitude__29 = l__LookVector__28.Magnitude;
                        if l__Magnitude__29 == l__Magnitude__29 and l__Magnitude__29 > 0 then
                            v138 = l__LookVector__28 / l__Magnitude__29;
                        else
                            v138 = nil;
                        end;
                    else
                        v138 = nil;
                    end;
                else
                    v138 = nil;
                end;
            else
                v138 = nil;
            end;
            local v139 = v138 or Vector3.new(0, 0, -1);
            u135._xfdcf18e05b15a135 = v139;
            u135._x6f1b7d0cf08230e4 = v139;
            u135._x48174dcb448bdfc3:Add(u137.CharacterAdded:Connect(function() --[[ Line: 748 ]]
                -- upvalues: u135 (copy), u137 (copy)
                if u135._xb5985ac0e787235b == "first_person" and u135._x1183cbeaf44ac72d == u137 then
                    u135:_xb50ca1137c641cbc();
                    task.defer(function() --[[ Line: 751 ]]
                        -- upvalues: u135 (ref), u137 (ref)
                        if u135._xb5985ac0e787235b == "first_person" and u135._x1183cbeaf44ac72d == u137 then
                            u135:_x2cc19208919584d8(u137.Character);
                        end;
                    end);
                end;
            end));
            if l__Classes__11._x6a15bbeeb97caae0 then
                l__Classes__11._x6a15bbeeb97caae0:_x2f63a8330ae40624(u137);
            end;
        end;
    end;
end;
function u1._x9b4e8b76cb02f48d(p140) --[[ Line: 764 ]]
    -- upvalues: l__Classes__11 (copy), l__LocalPlayer__13 (copy)
    if p140._xb5985ac0e787235b == "first_person" then
        if l__Classes__11._x8399b2bb73e12808 and l__Classes__11._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
            p140:cleanUp();
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
            local l__Character__30 = l__LocalPlayer__13.Character;
            if l__Character__30 then
                l__Character__30 = l__Character__30:FindFirstChildWhichIsA("Humanoid");
            end;
            if l__Character__30 then
                workspace.CurrentCamera.CameraSubject = l__Character__30;
            end;
        else
            p140:_x74e65eb5faef2d24("idle");
        end;
    end;
end;
function u1._x04f89106f69c0765(p141) --[[ Line: 783 ]]
    if p141._xb5985ac0e787235b == "first_person" then
        local l___x1183cbeaf44ac72d__31 = p141._x1183cbeaf44ac72d;
        if l___x1183cbeaf44ac72d__31 then
            l___x1183cbeaf44ac72d__31 = l___x1183cbeaf44ac72d__31.Character;
        end;
        if l___x1183cbeaf44ac72d__31 and l___x1183cbeaf44ac72d__31.Parent then
            return l___x1183cbeaf44ac72d__31;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._xed948f5b1b8e1ef3(p142, p143) --[[ Line: 797 ]]
    -- upvalues: l__Players__2 (copy), l__Classes__11 (copy)
    local l___x1183cbeaf44ac72d__32 = p142._x1183cbeaf44ac72d;
    if l___x1183cbeaf44ac72d__32 and l___x1183cbeaf44ac72d__32.Parent == l__Players__2 then
        if l__Classes__11._xe0e88f94014b801e then
            l__Classes__11._xe0e88f94014b801e._xa3fe4f9696ee59ce = false;
        end;
        local l__Character__33 = l___x1183cbeaf44ac72d__32.Character;
        if l__Character__33 and l__Character__33.Parent then
            local v144 = l__Character__33:FindFirstChild("Head");
            if not (v144 and v144:IsA("BasePart")) then
                v144 = nil;
            end;
            local v145 = v144 or l__Character__33.PrimaryPart;
            p142:_x2cc19208919584d8(l__Character__33);
            if v145 then
                local v146 = p142._xfdcf18e05b15a135 or Vector3.new(0, 0, -1);
                local v147;
                if os.clock() - p142._x8b292ebec131900d > 0.35 then
                    v147 = p142._x6f1b7d0cf08230e4;
                    if not v147 then
                        local l__Character__34 = l___x1183cbeaf44ac72d__32.Character;
                        local v148;
                        if l__Character__34 then
                            local l__PrimaryPart__35 = l__Character__34.PrimaryPart;
                            if l__PrimaryPart__35 then
                                local l__LookVector__36 = l__PrimaryPart__35.CFrame.LookVector;
                                if l__LookVector__36 then
                                    local l__Magnitude__37 = l__LookVector__36.Magnitude;
                                    if l__Magnitude__37 == l__Magnitude__37 and l__Magnitude__37 > 0 then
                                        v148 = l__LookVector__36 / l__Magnitude__37;
                                    else
                                        v148 = nil;
                                    end;
                                else
                                    v148 = nil;
                                end;
                            else
                                v148 = nil;
                            end;
                        else
                            v148 = nil;
                        end;
                        v147 = v148 or v146;
                    end;
                else
                    v147 = v146;
                end;
                local l___x6f1b7d0cf08230e4__38 = p142._x6f1b7d0cf08230e4;
                if l___x6f1b7d0cf08230e4__38 then
                    local v149 = l___x6f1b7d0cf08230e4__38:Dot(v147);
                    if math.clamp(v149, -1, 1) >= -0.25 then
                        local v150 = l___x6f1b7d0cf08230e4__38:Lerp(v147, 1 - math.exp(-30 * p143));
                        local v151;
                        if v150 then
                            local l__Magnitude__39 = v150.Magnitude;
                            if l__Magnitude__39 == l__Magnitude__39 and l__Magnitude__39 > 0 then
                                v151 = v150 / l__Magnitude__39;
                            else
                                v151 = nil;
                            end;
                        else
                            v151 = nil;
                        end;
                        v147 = v151 or v147;
                    end;
                end;
                p142._x6f1b7d0cf08230e4 = v147;
                workspace.CurrentCamera.CFrame = CFrame.lookAt(v145.Position, v145.Position + v147, Vector3.new(0, 1, 0));
            end;
        else
            p142:_xb50ca1137c641cbc();
        end;
    else
        p142:_x9b4e8b76cb02f48d();
    end;
end;
function u1._x712c312e69645fa1(p152, p153) --[[ Line: 849 ]]
    -- upvalues: l__Classes__11 (copy)
    local v154 = math.min(p153, 1);
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    if p152._xb5985ac0e787235b == "idle" then
        p152:_x4a0abb93d8179f29();
    end;
    if p152._xb5985ac0e787235b == "first_person" then
        p152:_xed948f5b1b8e1ef3(v154);
    elseif p152._xb5985ac0e787235b == "orbit" then
        local l___x1183cbeaf44ac72d__40 = p152._x1183cbeaf44ac72d;
        if l___x1183cbeaf44ac72d__40 and (l___x1183cbeaf44ac72d__40.Character and l___x1183cbeaf44ac72d__40.Character.PrimaryPart) then
            if l___x1183cbeaf44ac72d__40.Character.Parent == workspace.Entities then
                p152._x3c9b438843b29d37 = p152._x3c9b438843b29d37 + v154;
                local l___xb11f1d37bd1209ed__41 = p152._xb11f1d37bd1209ed;
                local l__Position__42 = l___x1183cbeaf44ac72d__40.Character.PrimaryPart.Position;
                local v155 = l__Position__42 + Vector3.new(0, 5, 0) + -l___x1183cbeaf44ac72d__40.Character.PrimaryPart.CFrame.LookVector * 20;
                l___xb11f1d37bd1209ed__41.x:SetGoal(v155.X);
                l___xb11f1d37bd1209ed__41.y:SetGoal(v155.Y);
                l___xb11f1d37bd1209ed__41.z:SetGoal(v155.Z);
                local v156 = Vector3.new(l___xb11f1d37bd1209ed__41.x.Offset, l___xb11f1d37bd1209ed__41.y.Offset, l___xb11f1d37bd1209ed__41.z.Offset);
                local v157 = v156 - l__Position__42;
                local v158 = workspace:FindFirstChild("Map");
                local v159;
                if v158 then
                    local v160 = RaycastParams.new();
                    v160.FilterType = Enum.RaycastFilterType.Include;
                    v160.FilterDescendantsInstances = { v158 };
                    v159 = workspace:Raycast(l__Position__42, v157, v160);
                else
                    v159 = nil;
                end;
                if v159 then
                    v156 = v159.Position;
                    l___xb11f1d37bd1209ed__41.x:SetOffset(v156.X);
                    l___xb11f1d37bd1209ed__41.y:SetOffset(v156.Y);
                    l___xb11f1d37bd1209ed__41.z:SetOffset(v156.Z);
                end;
                workspace.CurrentCamera.CFrame = CFrame.lookAt(v156, l__Position__42);
            else
                p152._x1183cbeaf44ac72d = nil;
                p152:_x74e65eb5faef2d24("idle");
                print("PARENT CHANGED");
            end;
        else
            p152._x1183cbeaf44ac72d = nil;
            p152:_x74e65eb5faef2d24("idle");
            print("MISSING PARTS");
        end;
    else
        if p152._xb5985ac0e787235b == "wideshot" then
            p152._x3c9b438843b29d37 = p152._x3c9b438843b29d37 + v154;
            if p152._x3c9b438843b29d37 > p152._x0347714e73359edf.wideshot_bored then
                p152:_x74e65eb5faef2d24("idle");
                return;
            end;
            p152:_x039baed3a67b85e2(v154);
            p152._xc4db3fd95f0215c0 = l__Classes__11.Util:numLerp(p152._xc4db3fd95f0215c0, -p152._x2977bf44a7efa09c, 5 * v154);
            p152._x603643e6312fb8c4 = l__Classes__11.Util:numLerp(p152._x603643e6312fb8c4, -p152._x1e1f979664bfda47, 5 * v154);
            local l___xf529fbd889120f93__43 = p152._xf529fbd889120f93;
            local v161;
            if l___xf529fbd889120f93__43 then
                v161 = l___xf529fbd889120f93__43:FindFirstChild("LookAt");
            else
                v161 = l___xf529fbd889120f93__43;
            end;
            if l___xf529fbd889120f93__43 then
                l___xf529fbd889120f93__43 = l___xf529fbd889120f93__43:FindFirstChild("Position");
            end;
            if not (v161 and v161:IsA("BasePart")) then
                v161 = nil;
            end;
            if not (l___xf529fbd889120f93__43 and l___xf529fbd889120f93__43:IsA("BasePart")) then
                l___xf529fbd889120f93__43 = nil;
            end;
            if not (v161 and l___xf529fbd889120f93__43) then
                p152:_xe8fc747f42e38f9a(v154);
                return;
            end;
            local v162 = CFrame.lookAt(l___xf529fbd889120f93__43.Position, v161.Position);
            local v163 = CFrame.Angles(p152._x603643e6312fb8c4, p152._xc4db3fd95f0215c0, 0);
            local v164 = CFrame.lookAt(l___xf529fbd889120f93__43.Position, l___xf529fbd889120f93__43.Position + ((v162 - v162.Position) * v163).LookVector);
            workspace.CurrentCamera.CFrame = v164;
        end;
    end;
end;
function u1._xecd8f177aa233279(p165, p166) --[[ Line: 958 ]]
    -- upvalues: l__Classes__11 (copy), l__Context__12 (copy), l__UIAssets__9 (copy), l__Packets__6 (copy)
    l__Classes__11._x8399b2bb73e12808._x5128018f5f9eac94:Clean();
    l__Classes__11._x6a15bbeeb97caae0._xfd176cd213628135.Main.Visible = false;
    if l__Context__12.is_match_mode then
        local v167 = l__UIAssets__9.Matches.SpectatorScreen:Clone();
        local l__Button__44 = v167.MidContainer.QuickButton.Button;
        l__Button__44.Activated:Connect(function() --[[ Line: 966 ]]
            -- upvalues: l__Classes__11 (ref), l__Packets__6 (ref), l__Button__44 (copy)
            l__Classes__11._xe4b708070c7cd741:_x85ec8b5d5b90212b("Modal", {
                title_text = "Leave Match?",
                body_text = "Your team is still playing. Leaving now will count as a loss.",
                actions = {
                    {
                        action_id = "LEAVE MATCH",
                        action_text = "LEAVE MATCH",
                        action_bg_color = Color3.fromRGB(255, 70, 70),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 976 ]]
                            -- upvalues: l__Packets__6 (ref), l__Button__44 (ref)
                            l__Packets__6._xfc3d3b5e71267fb1:Fire("leave");
                            l__Button__44.Visible = false;
                        end
                    },
                    {
                        action_id = "CANCEL",
                        action_text = "CANCEL",
                        action_bg_color = Color3.fromRGB(60, 60, 60),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 986 ]] end
                    }
                }
            });
        end);
        v167.Parent = game.Players.LocalPlayer.PlayerGui;
    end;
    local v168 = nil;
    if p166 and p166.user_id then
        v168 = game:GetService("Players"):GetPlayerByUserId(p166.user_id);
        print("SPECTATING PLAYER :", v168);
    else
        print("MISSED TARGET");
    end;
    p165:_xba28441e0836bc41(false, v168);
end;
function u1._xba28441e0836bc41(u169, p170, p171) --[[ Line: 1007 ]]
    -- upvalues: l__Classes__11 (copy), l__TweenService__1 (copy)
    u169._x48174dcb448bdfc3:Clean();
    u169:_x72753062c040d439();
    u169._xaa6f21863ddef024:Clean();
    u169._x48174dcb448bdfc3 = u169._xaa6f21863ddef024:Extend();
    u169._x1183cbeaf44ac72d = p171;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    u169._xc3594590660ea585 = nil;
    u169._xd5f26d793f25fa67 = true;
    l__Classes__11._xdca80115d2839102._x711166f3dabb680d = true;
    if p170 then
        workspace.CurrentCamera.FieldOfView = 10;
        local u172 = l__TweenService__1:Create(workspace.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = 113
        });
        u172:Play();
        task.spawn(function() --[[ Line: 1022 ]]
            -- upvalues: u172 (copy), l__TweenService__1 (ref)
            u172.Completed:Wait();
            l__TweenService__1:Create(workspace.CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                FieldOfView = 110
            }):Play();
        end);
    else
        workspace.CurrentCamera.FieldOfView = 110;
    end;
    u169._xc3594590660ea585 = l__Classes__11.Util:bindToRenderStep("SpectatorCam", Enum.RenderPriority.Camera.Value + 3, function(p173) --[[ Line: 1029 ]]
        -- upvalues: u169 (copy)
        u169:_x712c312e69645fa1(p173);
    end);
end;
function u1._x44bcd6af41218f92(u174) --[[ Line: 1034 ]]
    -- upvalues: l__Packets__6 (copy), l__UserInputService__3 (copy)
    l__Packets__6._xd0d2e4f16cf63974.OnClientEvent:Connect(function(p175) --[[ Line: 1035 ]]
        -- upvalues: u174 (copy)
        if p175.op == "start" then
            u174:_xecd8f177aa233279(p175.params);
        elseif p175.op == "start_first_person" then
            u174:_xa75e0550e312f1eb(p175.params);
        else
            if p175.op == "stop_first_person" then
                u174:_x9b4e8b76cb02f48d();
            end;
        end;
    end);
    l__Packets__6.unreliablePackets._x47fd55153a58f398.OnClientEvent:Connect(function(p176, p177, p178) --[[ Line: 1045 ]]
        -- upvalues: u174 (copy)
        u174:_x643dd9e7137f85f1(p176, p177, p178);
    end);
    l__Packets__6.unreliablePackets._xccd26d6aa027d1d5.OnClientEvent:Connect(function(p179, p180, p181) --[[ Line: 1049 ]]
        -- upvalues: u174 (copy)
        u174:_x01a647466d3bd153(p179, p180, p181);
    end);
    l__UserInputService__3.InputBegan:Connect(function(p182, p183) --[[ Line: 1053 ]]
        -- upvalues: u174 (copy), l__Packets__6 (ref)
        if p183 or u174._xb5985ac0e787235b ~= "first_person" then
        elseif p182.KeyCode == Enum.KeyCode.R then
            l__Packets__6._x54d2d509e605e4a2:Fire();
            u174:_x9b4e8b76cb02f48d();
        else
            if p182.KeyCode == Enum.KeyCode.T then
                u174:_x4c8f22ae19e9cadf(not u174._x6305f3142a4e4f55);
            end;
        end;
    end);
end;
return u1;
