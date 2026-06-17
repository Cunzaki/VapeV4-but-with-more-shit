-- Decompiled from: Start.Client.Classes._x6a15bbeeb97caae0
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
game:GetService("CollectionService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UIAssets__5 = l__ReplicatedStorage__4.Assets.UIAssets;
local l__ModuleScripts__6 = l__ReplicatedStorage__4.Assets.ModuleScripts;
local l__Packets__7 = require(l__ModuleScripts__6.Packets);
local l__Signal__8 = require(l__ModuleScripts__6.Signal);
local l__Promise__9 = require(l__ModuleScripts__6.Promise);
local l__Trove__10 = require(l__ModuleScripts__6.Trove);
require(l__ModuleScripts__6.Spring);
local l__TitleData__11 = require(l__ModuleScripts__6.TitleData);
local l__LevelService__12 = require(l__ModuleScripts__6.LevelService);
local l__SkinDefs__13 = require(l__ModuleScripts__6.SkinDefs);
local l__Classes__14 = require(script.Parent.Parent.ClientRoot).Classes;
local l___x7749231778538ccb__15 = require(script.Parent.Parent._x7749231778538ccb);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
u5.__index = u5;
local u6 = {
    GrapplerCrosshair = script.Crosshairs._xe66c0c31798afb1a,
    MeleeCrosshair = script.Crosshairs._x8ddf765ac8c1eb6a
};
local l__LocalPlayer__16 = game:GetService("Players").LocalPlayer;
local function u10(p7) --[[ Line: 69 ]]
    if typeof(p7) ~= "Instance" then
        return nil;
    end;
    if p7:IsA("Model") then
        return p7;
    end;
    local v8 = nil;
    for _, v9 in p7:GetDescendants() do
        if v9:IsA("Model") then
            if v9:FindFirstChild("CharacterMotor6D", true) then
                return v9;
            end;
            v8 = v8 or v9;
        end;
    end;
    return v8;
end;
local function u15(p11) --[[ Line: 92 ]]
    -- upvalues: l__ReplicatedStorage__4 (copy), u10 (copy)
    local v12 = l__ReplicatedStorage__4.Assets:FindFirstChild("Rigs3P");
    if not v12 then
        return nil;
    end;
    local v13 = u10(v12:FindFirstChild(p11));
    if v13 then
        return v13;
    end;
    for _, v14 in v12:GetChildren() do
        if v14:GetAttribute("item_id") == p11 then
            return u10(v14);
        end;
    end;
    return nil;
end;
local function u32(p16, p17, p18) --[[ Line: 128 ]]
    local l__AbsoluteSize__17 = p17.AbsoluteSize;
    if l__AbsoluteSize__17.X <= 0 or l__AbsoluteSize__17.Y <= 0 then
        return nil;
    end;
    local v19 = math.rad(p18.FieldOfView / 2);
    local v20 = math.tan(v19);
    local v21 = v20 * l__AbsoluteSize__17.X / l__AbsoluteSize__17.Y;
    local v22, v23 = p16:GetBoundingBox();
    local v24 = v23 / 2;
    local v25 = 0;
    for v26 = -1, 1, 2 do
        for v27 = -1, 1, 2 do
            for v28 = -1, 1, 2 do
                local v29 = v22 * (v24 * Vector3.new(v26, v27, v28));
                local v30 = math.abs(v29.X) / v21 - v29.Z;
                local v31 = math.abs(v29.Y) / v20 - v29.Z;
                v25 = math.max(v25, v30, v31, -v29.Z + 0.1);
            end;
        end;
    end;
    return v25;
end;
function u5._x83ed94bfb82a8c9f() --[[ Line: 162 ]]
    -- upvalues: u5 (copy), l__Trove__10 (copy), l__Signal__8 (copy)
    local v33 = setmetatable({}, u5);
    v33._x150106ccf5e1fa00 = Instance.new("ScreenGui");
    v33._x150106ccf5e1fa00.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v33._x150106ccf5e1fa00.Name = "GameplayUI";
    v33._x150106ccf5e1fa00.ResetOnSpawn = false;
    v33._x150106ccf5e1fa00.DisplayOrder = 1;
    v33._x150106ccf5e1fa00.IgnoreGuiInset = true;
    v33._xc9142462f74ee046 = {};
    v33._x5afa82d65f994d22 = { "CENTER", "OUTER-CENTER", "MEDIUM" };
    v33._x6a63f35101775a95 = {};
    v33._xcca6084c04ce0c66 = 0;
    v33._x06f6523fee19e54a = l__Trove__10.new();
    v33._xfd176cd213628135 = nil;
    v33._x4cc2fe9bd0030f75 = l__Trove__10.new();
    v33._x2b1d1be5f01bc37f = nil;
    v33._xa6d3fe82369e0c2f = nil;
    v33._xd04b1e50b6aaffb8 = nil;
    v33._x01e762287076c1a5 = nil;
    v33._x3e2173c278cffc55 = {};
    v33._x44c74dfd9ba7f108 = nil;
    v33._x8a1ad518dae63348 = {};
    v33._x2c34df6b193a13d0 = {};
    v33._x9750ea86f12297c2 = "Gradient";
    v33._xf32023927dadf4ad = nil;
    v33._xf3c4e81cd8c7fb47 = nil;
    v33._xeac713f43d41c2b8 = 0;
    v33._x169361cbea19e64b = {
        attempt_connect = l__Signal__8.new(),
        create_gameplay_cue = l__Signal__8.new()
    };
    return v33;
end;
function u5._xf78eb1d97abd9c59(p34, p35) --[[ Line: 206 ]]
    -- upvalues: u6 (copy), l___x7749231778538ccb__15 (copy)
    local v36 = u6[p35];
    if v36 then
        local v37 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", require(v36))._x83ed94bfb82a8c9f();
        v37:_x44bcd6af41218f92();
        table.insert(p34._xc9142462f74ee046, v37);
        return v37;
    end;
    warn("INVALID crosshair_name : " .. p35);
end;
function u5._x439b4f89b7a1886a(p38, p39) --[[ Line: 222 ]]
    -- upvalues: l___x7749231778538ccb__15 (copy)
    local v40 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", p39);
    local v41 = table.find(p38._xc9142462f74ee046, v40);
    if v41 then
        table.remove(p38._xc9142462f74ee046, v41);
    else
        warn("removeCrosshair FAILED FOR CROSSHAIR : " .. v40._x648014a928c5987c);
    end;
end;
function u5._x518564bf3a355cdb(p42) --[[ Line: 232 ]]
    -- upvalues: l___x7749231778538ccb__15 (copy)
    local v43 = {};
    local v44 = {};
    for _, v45 in ipairs(p42._x5afa82d65f994d22) do
        local v46 = nil;
        for _, v47 in ipairs(p42._xc9142462f74ee046) do
            local v48 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v47);
            if v48._xaba85bda16c99811 and #v48._x053125a0509474ef > 0 then
                for _, v49 in ipairs(v48._x053125a0509474ef) do
                    if v49 == v45 then
                        if not v46 or v48._xe0aaee91d34b28d7 > v46.priority then
                            v46 = v48;
                        end;
                        break;
                    end;
                end;
            end;
        end;
        if v46 then
            v43[v46] = true;
            for _, v50 in ipairs(p42._xc9142462f74ee046) do
                local v51 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v50);
                if v51._xaba85bda16c99811 and (v51 ~= v46 and #v51._x053125a0509474ef > 0) then
                    for _, v52 in ipairs(v51._x053125a0509474ef) do
                        if v52 == v45 then
                            v44[v51] = true;
                            break;
                        end;
                    end;
                end;
            end;
        end;
    end;
    for _, v53 in ipairs(p42._xc9142462f74ee046) do
        local v54 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v53);
        if v54._xaba85bda16c99811 and #v54._x053125a0509474ef == 0 then
            v43[v54] = true;
        end;
    end;
    p42._x009275e17f52f1a2 = p42._x009275e17f52f1a2 or {};
    for v55, _ in pairs(v44) do
        local v56 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v55);
        if not p42._x009275e17f52f1a2[v56] then
            if v56._x8589e331f179b29f then
                v56._x8589e331f179b29f:Fire();
            end;
            p42._x009275e17f52f1a2[v56] = true;
        end;
    end;
    local v57 = {};
    for v58, _ in pairs(p42._x009275e17f52f1a2) do
        local v59 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v58);
        if not v44[v59] then
            table.insert(v57, v59);
        end;
    end;
    for _, v60 in ipairs(v57) do
        local v61 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v60);
        if v61.OnRestore then
            v61.OnRestore:Fire();
        end;
        p42._x009275e17f52f1a2[v61] = nil;
    end;
    local v62 = {};
    for v63, _ in pairs(v43) do
        table.insert(v62, v63);
    end;
    return v62;
end;
function u5._xccd054097e29ea7b(p64, p65) --[[ Line: 315 ]]
    -- upvalues: l___x7749231778538ccb__15 (copy)
    local v66 = p64:_x518564bf3a355cdb();
    local v67 = {};
    for _, v68 in ipairs(v66) do
        v67[v68] = true;
    end;
    for _, v69 in ipairs(p64._xc9142462f74ee046) do
        local v70 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", v69);
        if v70._xaba85bda16c99811 then
            if v67[v70] then
                if not v70._xee901c9028066f15 then
                    v70._xee901c9028066f15 = true;
                    v70:_xba28441e0836bc41();
                end;
                v70:_x9b3fec950346ada1(p65);
            elseif v70._xee901c9028066f15 then
                v70._xee901c9028066f15 = false;
                v70:_xf995955fd312e0ce();
            end;
        elseif v70._xee901c9028066f15 then
            v70._xee901c9028066f15 = false;
            v70:_xf995955fd312e0ce();
        end;
    end;
end;
function u5._x3e94c6ef859458ed(p71, p72) --[[ Line: 347 ]]
    -- upvalues: u1 (ref), l__Classes__14 (copy), l__UserInputService__2 (copy)
    p71._xcca6084c04ce0c66 = math.deg(u1._x120f4a9aed8ade07);
    if l__Classes__14._x5e4b900ba734c53c._x68be8a7a00400919 or (l__Classes__14._x8399b2bb73e12808._xd201386e6033df53 or l__Classes__14._x3b55708f7532e346 and l__Classes__14._x3b55708f7532e346._xf152cbc8a1fd227f) then
        l__UserInputService__2.MouseIconEnabled = true;
    else
        local v73 = l__UserInputService__2;
        local v74;
        if l__Classes__14._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
            v74 = l__Classes__14._xdca80115d2839102._xf5c5c2152a2970b7;
        else
            v74 = false;
        end;
        v73.MouseIconEnabled = not v74 or false;
    end;
    p71:_xccd054097e29ea7b(p72);
    for _, v75 in p71._x6a63f35101775a95 do
        if v75.connection then
            v75.connection();
        end;
    end;
end;
function u5._xd2e40a17ea9c5d26(u76) --[[ Line: 362 ]]
    -- upvalues: l__Classes__14 (copy), u3 (ref), u2 (ref), u4 (ref), l__UIAssets__5 (copy), l__TweenService__3 (copy), l__Packets__7 (copy)
    local function u82(p77) --[[ Line: 411 ]]
        -- upvalues: u76 (copy), l__Classes__14 (ref)
        local v78;
        if type(p77) == "table" then
            v78 = p77.spectate_target_key ~= nil;
        else
            v78 = false;
        end;
        local v79, v80;
        if v78 then
            local l___x01e762287076c1a5__18 = u76._x01e762287076c1a5;
            if p77.spectate_impact == nil then
                v79 = l___x01e762287076c1a5__18 and (l___x01e762287076c1a5__18.impact or 0) or 0;
            else
                v79 = p77.spectate_impact;
            end;
            if p77.spectate_impact_limit == nil then
                v80 = l___x01e762287076c1a5__18 and l___x01e762287076c1a5__18.impact_limit or 1;
            else
                v80 = p77.spectate_impact_limit;
            end;
        else
            v79 = l__Classes__14._x8399b2bb73e12808:_xe7f02e22353709c3("impact").Value;
            v80 = l__Classes__14._x8399b2bb73e12808:_xe7f02e22353709c3("impact_limit").Value;
        end;
        local v81 = (v79 or 0) / math.max(v80 or 0, 1);
        return math.clamp(v81, 0, 1);
    end;
    local function u145(u83, u84) --[[ Line: 458 ]]
        -- upvalues: u76 (copy), l__UIAssets__5 (ref), l__TweenService__3 (ref), u3 (ref), u2 (ref), l__Classes__14 (ref), u4 (ref), u82 (copy)
        if u84 then
            local v85;
            if type(u84) == "table" then
                v85 = u84.spectate_target_key ~= nil;
            else
                v85 = false;
            end;
            local u86;
            if v85 and u84.spectate_is_teammate ~= nil then
                u86 = u84.spectate_is_teammate == true;
            else
                u86 = u83:GetAttribute("is_teammate");
            end;
            if u76._x6a63f35101775a95[u83] then
                warn("SHOT INDICATOR FOR SHOOTER ALREADY EXISTS : ", u83);
            elseif u84.indicator_type == "timing_only" then
                local u87 = l__UIAssets__5.OmniIndicator:Clone();
                game.Debris:AddItem(u87, 5);
                l__TweenService__3:Create(u87.Img, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                l__TweenService__3:Create(u87.Img, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                if u86 then
                    u87.Visible = false;
                end;
                u87.Parent = u76._x150106ccf5e1fa00;
                local u88 = nil;
                local v89 = {
                    indicator_ui = u87,
                    indicator_type = u84.indicator_type
                };
                local v90;
                if type(u84) == "table" then
                    v90 = u84.spectate_target_key ~= nil;
                else
                    v90 = false;
                end;
                v89.is_spectate = v90;
                v89.expected_shot_time = os.clock() + u84.draw_time;
                function v89.connection(_) --[[ Line: 483 ]]
                    -- upvalues: u84 (copy), u76 (ref), u3 (ref), u2 (ref), l__Classes__14 (ref), u83 (copy), u87 (copy), u86 (copy), u4 (ref), u88 (ref)
                    local function v95(p91) --[[ Line: 484 ]]
                        local l__CFrame__19 = workspace.CurrentCamera.CFrame;
                        local l__Unit__20 = (l__CFrame__19.LookVector * Vector3.new(1, 0, 1)).Unit;
                        local v92 = l__CFrame__19.Position * Vector3.new(1, 0, 1) - p91 * Vector3.new(1, 0, 1);
                        if v92.Magnitude == 0 then
                            return 0;
                        end;
                        local l__Unit__21 = v92.Unit;
                        local v93 = l__Unit__20:Dot(l__Unit__21);
                        local v94 = math.atan2(l__Unit__20.X * l__Unit__21.Z - l__Unit__20.Z * l__Unit__21.X, v93);
                        return math.deg(v94);
                    end;
                    local v96 = u2:getLikelyPart(u83);
                    if not v96 then
                        u76._x6a63f35101775a95[u83] = nil;
                        u87:Destroy();
                        return;
                    end;
                    if u86 then
                        u87.Visible = false;
                    elseif u84.require_los then
                        local v97 = u84;
                        local v98;
                        if type(v97) == "table" then
                            v98 = v97.spectate_target_key ~= nil;
                        else
                            v98 = false;
                        end;
                        local v99;
                        if v98 then
                            v99 = u76._xa6d3fe82369e0c2f;
                            if v99 then
                                v99 = u76._xa6d3fe82369e0c2f.Character;
                            end;
                        else
                            v99 = u3._x7c0477cd83a7fb82;
                        end;
                        local v100;
                        if v99 then
                            v100 = v99:FindFirstChild("Head");
                            if not (v100 and v100:IsA("BasePart")) then
                                v100 = u2:getLikelyPart(v99);
                            end;
                        else
                            v100 = nil;
                        end;
                        u87.Visible = l__Classes__14.Util:hasLineOfSight(v100, v96);
                    else
                        u87.Visible = true;
                    end;
                    l__Classes__14.Util:convNumRange(math.clamp((v96.Position - workspace.CurrentCamera.CFrame.Position).Magnitude, 0, 300), 0, 300, 0.35, 0.55);
                    local v101 = u83:FindFirstChild("Head") and u83.Head.Position or (u83.PrimaryPart and u83.PrimaryPart.Position or u83:GetPivot().Position);
                    if u87 and v101 then
                        local v102 = u84;
                        local v103;
                        if type(v102) == "table" then
                            v103 = v102.spectate_target_key ~= nil;
                        else
                            v103 = false;
                        end;
                        local v104;
                        if v103 then
                            local v105;
                            if type(v102) == "table" then
                                v105 = v102.spectate_target_key ~= nil;
                            else
                                v105 = false;
                            end;
                            local v106;
                            if v105 then
                                v106 = u76._xa6d3fe82369e0c2f;
                                if v106 then
                                    v106 = u76._xa6d3fe82369e0c2f.Character;
                                end;
                            else
                                v106 = u3._x7c0477cd83a7fb82;
                            end;
                            if u76._x2b1d1be5f01bc37f == nil or v106 == nil then
                                v104 = false;
                            else
                                v104 = v106.Parent ~= nil;
                            end;
                        else
                            v104 = u4._x69155c6c2c2143d0 == "alive";
                        end;
                        if v104 then
                            u87.Rotation = v95(v101);
                        end;
                    end;
                    if u88.connection then
                        u76._x6a63f35101775a95[u83] = nil;
                        u87:Destroy();
                    end;
                end;
                local v107 = v89;
                u76._x6a63f35101775a95[u83] = v107;
            else
                local u108 = l__UIAssets__5.ShooterIndicator:Clone();
                local l__first_parry_range__22 = u84.first_parry_range;
                local l__last_parry_range__23 = u84.last_parry_range;
                local u109 = u2:convNumRange(u82(u84), 0, 1, l__first_parry_range__22, l__last_parry_range__23);
                if u86 then
                    u108.Visible = false;
                end;
                game.Debris:AddItem(u108, 5);
                local l__Left__24 = u108.ParryRange.LeftClip.Left;
                local l__Right__25 = u108.ParryRange.RightClip.Right;
                l__Left__24.ImageTransparency = 0;
                l__Right__25.ImageTransparency = 0;
                local l__UIGradient__26 = u108.ParryRange.LeftClip.Left.UIGradient;
                local l__UIGradient__27 = u108.ParryRange.RightClip.Right.UIGradient;
                local l__UIGradient__28 = u108.ParryRange.LeftClip.LeftSuccess.UIGradient;
                local l__UIGradient__29 = u108.ParryRange.RightClip.RightSuccess.UIGradient;
                u108.Parent = u76._x150106ccf5e1fa00;
                local u110 = os.clock();
                local u111 = nil;
                local v112 = {
                    first_parry = l__first_parry_range__22,
                    last_parry = l__last_parry_range__23,
                    parry_range = u109,
                    indicator_ui = u108,
                    indicator_type = u84.indicator_type
                };
                local v113;
                if type(u84) == "table" then
                    v113 = u84.spectate_target_key ~= nil;
                else
                    v113 = false;
                end;
                v112.is_spectate = v113;
                v112.expected_shot_time = os.clock() + u84.draw_time;
                v112.parry_tweens = {};
                function v112.connection(_) --[[ Line: 590 ]]
                    -- upvalues: u84 (copy), u76 (ref), u3 (ref), u2 (ref), l__Classes__14 (ref), u83 (copy), u108 (copy), u86 (copy), u110 (copy), u4 (ref), u111 (ref), u109 (copy), l__UIGradient__26 (copy), l__UIGradient__27 (copy), l__UIGradient__28 (copy), l__UIGradient__29 (copy)
                    local function v118(p114) --[[ Line: 591 ]]
                        local l__CFrame__30 = workspace.CurrentCamera.CFrame;
                        local l__Unit__31 = (l__CFrame__30.LookVector * Vector3.new(1, 0, 1)).Unit;
                        local v115 = l__CFrame__30.Position * Vector3.new(1, 0, 1) - p114 * Vector3.new(1, 0, 1);
                        if v115.Magnitude == 0 then
                            return 0;
                        end;
                        local l__Unit__32 = v115.Unit;
                        local v116 = l__Unit__31:Dot(l__Unit__32);
                        local v117 = math.atan2(l__Unit__31.X * l__Unit__32.Z - l__Unit__31.Z * l__Unit__32.X, v116);
                        return math.deg(v117);
                    end;
                    local v119 = u2:getLikelyPart(u83);
                    if not v119 then
                        u76._x6a63f35101775a95[u83] = nil;
                        u108:Destroy();
                        return;
                    end;
                    if u86 then
                        u108.Visible = false;
                    elseif u84.require_los then
                        local v120 = u84;
                        local v121;
                        if type(v120) == "table" then
                            v121 = v120.spectate_target_key ~= nil;
                        else
                            v121 = false;
                        end;
                        local v122;
                        if v121 then
                            v122 = u76._xa6d3fe82369e0c2f;
                            if v122 then
                                v122 = u76._xa6d3fe82369e0c2f.Character;
                            end;
                        else
                            v122 = u3._x7c0477cd83a7fb82;
                        end;
                        local v123;
                        if v122 then
                            v123 = v122:FindFirstChild("Head");
                            if not (v123 and v123:IsA("BasePart")) then
                                v123 = u2:getLikelyPart(v122);
                            end;
                        else
                            v123 = nil;
                        end;
                        u108.Visible = l__Classes__14.Util:hasLineOfSight(v123, v119);
                    else
                        u108.Visible = true;
                    end;
                    local v124 = l__Classes__14.Util:convNumRange(math.clamp((v119.Position - workspace.CurrentCamera.CFrame.Position).Magnitude, 0, 300), 0, 300, 0.35, 0.55);
                    u108.Size = UDim2.fromScale(v124, v124);
                    local v125 = u108:FindFirstChild("ParryRange");
                    local v126 = u83:FindFirstChild("Head") and u83.Head.Position or (u83.PrimaryPart and u83.PrimaryPart.Position or u83:GetPivot().Position);
                    if u108 and (v125 and (v126 and os.clock() - u110 <= 5)) then
                        local v127 = u84;
                        local v128;
                        if type(v127) == "table" then
                            v128 = v127.spectate_target_key ~= nil;
                        else
                            v128 = false;
                        end;
                        local v129;
                        if v128 then
                            local v130;
                            if type(v127) == "table" then
                                v130 = v127.spectate_target_key ~= nil;
                            else
                                v130 = false;
                            end;
                            local v131;
                            if v130 then
                                v131 = u76._xa6d3fe82369e0c2f;
                                if v131 then
                                    v131 = u76._xa6d3fe82369e0c2f.Character;
                                end;
                            else
                                v131 = u3._x7c0477cd83a7fb82;
                            end;
                            if u76._x2b1d1be5f01bc37f == nil or v131 == nil then
                                v129 = false;
                            else
                                v129 = v131.Parent ~= nil;
                            end;
                        else
                            v129 = u4._x69155c6c2c2143d0 == "alive";
                        end;
                        if v129 then
                            local v132 = os.clock() - u110;
                            local v133 = u2:numLerp(0, u109, (u2:convNumRange(math.clamp(v132, 0, u84.draw_time), 0, u84.draw_time, 0, 1)));
                            local v134 = 1 - (v133 < 0 and 0 or (v133 > 2 and 2 or v133));
                            local v135 = math.acos(v134 < -1 and -1 or (v134 > 1 and 1 or v134));
                            local v136 = math.deg(v135) * 2;
                            local v137 = -v136 / 2;
                            u108.ParryRange.Rotation = v118(v126) + v137;
                            local v138 = l__UIGradient__26;
                            local v139 = l__UIGradient__27;
                            local v140 = math.fmod(v136, 360);
                            if v140 < 180 and v140 > -180 then
                                v138.Rotation = v140;
                                v139.Rotation = 0;
                            else
                                v138.Rotation = 180;
                                v139.Rotation = v140 - 180;
                            end;
                            local v141 = l__UIGradient__28;
                            local v142 = l__UIGradient__29;
                            local v143 = math.fmod(v136, 360);
                            if v143 < 180 and v143 > -180 then
                                v141.Rotation = v143;
                                v142.Rotation = 0;
                                return;
                            end;
                            v141.Rotation = 180;
                            v142.Rotation = v143 - 180;
                        end;
                    end;
                    if u111.connection then
                        u76._x6a63f35101775a95[u83] = nil;
                        u108:Destroy();
                    end;
                end;
                local v144 = v112;
                u76._x6a63f35101775a95[u83] = v144;
            end;
        else
            warn("COULD NOT FIND shot_data FOR SHOOTER");
        end;
    end;
    local function u151(p146, p147) --[[ Line: 671 ]]
        -- upvalues: u76 (copy), l__Classes__14 (ref), l__TweenService__3 (ref)
        if u76._x6a63f35101775a95[p146] then
            local v148 = u76._x6a63f35101775a95[p146];
            local l__indicator_ui__33 = v148.indicator_ui;
            local v149 = l__Classes__14._x181e05d210129765._x85b32f0b9c67055f[p146];
            if v149 then
                pcall(v149);
            end;
            if p147 == "parried" or p147 == "iframed" then
                if v148.parry_tweens then
                    for _, v150 in v148.parry_tweens do
                        v150:Cancel();
                    end;
                end;
                if v148.indicator_ui then
                    if v148.indicator_type == "timing_only" then
                        if l__indicator_ui__33 then
                            l__indicator_ui__33:Destroy();
                        end;
                    elseif v148.indicator_type == "surefire_bullet" then
                        local l__LeftClip__34 = l__indicator_ui__33.ParryRange.LeftClip;
                        local l__RightClip__35 = l__indicator_ui__33.ParryRange.RightClip;
                        l__LeftClip__34.Left.Visible = false;
                        l__RightClip__35.Right.Visible = false;
                        game.Debris:AddItem(l__indicator_ui__33, 0.3);
                        local l__LeftSuccess__36 = l__LeftClip__34.LeftSuccess;
                        local l__RightSuccess__37 = l__RightClip__35.RightSuccess;
                        l__LeftSuccess__36.Image = "rbxassetid://119413129698155";
                        l__LeftSuccess__36.ImageTransparency = 0;
                        l__LeftSuccess__36.Size = UDim2.fromScale(1, 0.5);
                        l__TweenService__3:Create(l__LeftSuccess__36, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(2, 1)
                        }):Play();
                        l__TweenService__3:Create(l__LeftSuccess__36, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        l__RightSuccess__37.Image = "rbxassetid://119413129698155";
                        l__RightSuccess__37.ImageTransparency = 0;
                        l__RightSuccess__37.Size = UDim2.fromScale(1, 0.5);
                        l__TweenService__3:Create(l__RightSuccess__37, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(2, 1)
                        }):Play();
                        l__TweenService__3:Create(l__RightSuccess__37, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end;
            elseif v148.indicator_type == "timing_only" then
                if l__indicator_ui__33 then
                    l__indicator_ui__33:Destroy();
                end;
            elseif v148.indicator_type == "surefire_bullet" then
                local l__indicator_ui__38 = v148.indicator_ui;
                local l__LeftClip__39 = l__indicator_ui__38.ParryRange.LeftClip;
                local l__RightClip__40 = l__indicator_ui__38.ParryRange.RightClip;
                game.Debris:AddItem(l__indicator_ui__38, 0.1);
                l__TweenService__3:Create(l__LeftClip__39, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                l__TweenService__3:Create(l__RightClip__40, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
            end;
            u76._x6a63f35101775a95[p146] = nil;
        end;
    end;
    l__Packets__7._x34754b6705aa3689.OnClientEvent:Connect(function(p152, p153) --[[ Line: 741 ]]
        -- upvalues: u76 (copy), u145 (copy)
        if u76._x2b1d1be5f01bc37f then
        else
            u145(p152, p153);
        end;
    end);
    l__Packets__7._x79961bff1a8a3f4c.OnClientEvent:Connect(function(p154, p155) --[[ Line: 749 ]]
        -- upvalues: u151 (copy)
        u151(p154, p155);
    end);
    l__Packets__7._xf29dcc6a78e136c2.OnClientEvent:Connect(function(p156, p157, p158) --[[ Line: 753 ]]
        -- upvalues: u76 (copy), u145 (copy)
        local v159 = u76._xa6d3fe82369e0c2f and u76._x2b1d1be5f01bc37f;
        if v159 then
            v159 = tostring(u76._xa6d3fe82369e0c2f.UserId) == tostring(p156);
        end;
        if v159 then
            u145(p157, p158);
        end;
    end);
    l__Packets__7._x0b2e7b7fe0af03fc.OnClientEvent:Connect(function(p160, p161, p162) --[[ Line: 759 ]]
        -- upvalues: u76 (copy), u151 (copy)
        local v163 = u76._xa6d3fe82369e0c2f and u76._x2b1d1be5f01bc37f;
        if v163 then
            v163 = tostring(u76._xa6d3fe82369e0c2f.UserId) == tostring(p160);
        end;
        if v163 then
            u151(p161, p162);
        end;
    end);
end;
function u5._xe97716d0c0a9fe51(p164) --[[ Line: 766 ]]
    if p164._xfd176cd213628135 and p164._xfd176cd213628135.Parent ~= nil then
        local l__AugmentHolder__41 = p164._xfd176cd213628135.Main.BottomLeft.AugmentContainer.AugmentHolder;
        return {
            augment_text = l__AugmentHolder__41.AugmentText,
            subtext = l__AugmentHolder__41.Subtext,
            key_text = l__AugmentHolder__41.AugmentKey.KeyText,
            progress = l__AugmentHolder__41.CircularImageFill.Progress,
            counter_text = l__AugmentHolder__41.CircularImageFill.CounterText
        };
    end;
end;
function u5._x97ce83c688ed4179(p165) --[[ Line: 778 ]]
    if p165._xfd176cd213628135 then
        return p165.shot_progress_inst;
    end;
end;
function u5._xf98f587c3f464384(p166) --[[ Line: 783 ]]
    p166._x06f6523fee19e54a:Clean();
    p166._xf32023927dadf4ad = nil;
end;
function u5._xfe37ca018b470fff(p167) --[[ Line: 788 ]]
    if p167._x2b1d1be5f01bc37f then
        return p167._x2b1d1be5f01bc37f:FindFirstChild("Main") or p167._x2b1d1be5f01bc37f;
    else
        return nil;
    end;
end;
function u5._xa097f78b7818eea2(p168, p169) --[[ Line: 796 ]]
    local v170 = p168:_xfe37ca018b470fff();
    if not v170 then
        return nil;
    end;
    for _, v171 in p169 do
        if not v170 then
            return nil;
        end;
        v170 = v170:FindFirstChild(v171);
    end;
    return v170;
end;
function u5._x3bef611200666541(p172) --[[ Line: 805 ]]
    for _, v173 in {
        { "BottomLeft", "StaminaContainer" },
        { "BottomLeft", "AugmentContainer" },
        { "BottomCenter", "GameplayCues" }
    } do
        local v174 = p172:_xa097f78b7818eea2(v173);
        if v174 and v174:IsA("GuiObject") then
            v174.Visible = false;
        end;
    end;
    for _, v175 in {
        { "TopbarUI" },
        { "DamageFrame" }
    } do
        local l___x2b1d1be5f01bc37f__42 = p172._x2b1d1be5f01bc37f;
        for _, v176 in v175 do
            if not l___x2b1d1be5f01bc37f__42 then
                l___x2b1d1be5f01bc37f__42 = nil;
                break;
            end;
            l___x2b1d1be5f01bc37f__42 = l___x2b1d1be5f01bc37f__42:FindFirstChild(v176);
        end;
        if l___x2b1d1be5f01bc37f__42 and l___x2b1d1be5f01bc37f__42:IsA("GuiObject") then
            l___x2b1d1be5f01bc37f__42.Visible = false;
        end;
    end;
    local v177 = p172:_xa097f78b7818eea2({ "BottomLeft", "GunContainer", "GunKey" });
    if v177 and v177:IsA("GuiObject") then
        v177.Visible = false;
    end;
end;
function u5._x1fd1cc2293ca4f7b(_, p178, p179) --[[ Line: 824 ]]
    -- upvalues: l__TweenService__3 (copy), u2 (ref)
    local v180 = p178:FindFirstChild("CircleFrame");
    if v180 and v180:IsA("GuiObject") then
        local v181 = Color3.fromRGB(255, 30, 30);
        local v182 = v180:Clone();
        v182.Parent = v180.Parent;
        local v183 = p178:FindFirstChild("Counter");
        if v183 and v183:IsA("TextLabel") then
            v183.TextTransparency = 1;
            l__TweenService__3:Create(v183, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                TextTransparency = 0
            }):Play();
        end;
        local v184 = p178:FindFirstChild("Elimination");
        if v184 and v184:IsA("ImageLabel") then
            v184.ImageColor3 = v181;
            v184.ImageTransparency = 0;
            v184.Size = UDim2.fromScale(3, 3);
            l__TweenService__3:Create(v184, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1.3, 1.3)
            }):Play();
            l__TweenService__3:Create(v184, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ImageTransparency = 1
            }):Play();
        end;
        for _, v185 in { "Radial", "Flare", "Glow" } do
            local v186 = p178:FindFirstChild(v185);
            if v186 and v186:IsA("ImageLabel") then
                v186.ImageColor3 = v181;
                l__TweenService__3:Create(v186, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
        end;
        local v187 = v182:FindFirstChildWhichIsA("UIStroke");
        if v187 then
            v187.Transparency = 0;
            v187.Color = v181;
            v187.Thickness = 7;
            l__TweenService__3:Create(v187, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            l__TweenService__3:Create(v187, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Thickness = 0
            }):Play();
        end;
        local v188 = not u2 and 3 or u2:convNumRange(math.clamp(p179, 0, 15), 0, 20, 2, 6);
        l__TweenService__3:Create(v182, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(v188, v188)
        }):Play();
        game.Debris:AddItem(v182, 1);
    end;
end;
function u5._x681056133a1b3d7d(p189, p190) --[[ Line: 871 ]]
    local v191 = p189:_xa097f78b7818eea2({ "BottomCenter", "KillstreakVisualizer" });
    if v191 then
        local v192 = p190.killstreak or 0;
        v191.Visible = v192 >= 1;
        local v193 = v191:FindFirstChild("Counter");
        local v194 = tostring(v192);
        if v193 and (v193:IsA("TextLabel") or v193:IsA("TextButton")) then
            v193.Text = v194;
        end;
        local l__killstreak__43 = p189._x3e2173c278cffc55.killstreak;
        if l__killstreak__43 and l__killstreak__43 < v192 then
            p189:_x1fd1cc2293ca4f7b(v191, v192);
        end;
        p189._x3e2173c278cffc55.killstreak = v192;
    end;
end;
function u5._xbfcfcfddb187a803(p195, p196) --[[ Line: 891 ]]
    -- upvalues: l__TweenService__3 (copy)
    local v197 = p195:_xa097f78b7818eea2({
        "BottomCenter",
        "HealthContainer",
        "HealthMain",
        "Bar",
        "Max",
        "HealthProgress"
    });
    if v197 and v197:IsA("GuiObject") then
        local v198 = p196.health or 0;
        local v199 = math.max(p196.health_max or 0, 1);
        local v200 = math.clamp(v198 / v199, 0, 1);
        v197.Size = UDim2.fromScale(v200, 1);
        local v201 = v197:FindFirstChild("TextLabel");
        local v202 = math.floor(v198);
        local v203 = tostring(v202);
        if v201 and (v201:IsA("TextLabel") or v201:IsA("TextButton")) then
            v201.Text = v203;
        end;
        local l__health__44 = p195._x3e2173c278cffc55.health;
        if l__health__44 then
            local v204 = l__health__44 - v198;
            if v204 > 0 then
                local v205 = p195:_xa097f78b7818eea2({
                    "BottomCenter",
                    "HealthContainer",
                    "HealthMain",
                    "Bar",
                    "Max",
                    "DamagedFrame"
                });
                if v205 and v205:IsA("GuiObject") then
                    local v206 = math.clamp(v204 / v199, 0, 1);
                    v205.Size = UDim2.fromScale(v206, 1);
                    l__TweenService__3:Create(v205, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    local v207 = v205:FindFirstChild("GradientFrame");
                    if v207 and v207:IsA("GuiObject") then
                        v207.BackgroundTransparency = 0;
                        l__TweenService__3:Create(v207, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                end;
                v197.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
                l__TweenService__3:Create(v197, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Play();
            elseif v204 < 0 then
                v197.BackgroundColor3 = Color3.fromRGB(0, 255, 0);
                l__TweenService__3:Create(v197, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
        end;
        p195._x3e2173c278cffc55.health = v198;
    end;
end;
function u5._x64c4b23c2707135c(p208, p209) --[[ Line: 931 ]]
    -- upvalues: u2 (ref)
    local l___x01e762287076c1a5__45 = p208._x01e762287076c1a5;
    local v210 = p208:_xa097f78b7818eea2({ "TopCenter", "ImpactHolder" });
    local v211 = p208:_xa097f78b7818eea2({ "TopCenter", "ImpactHolder", "ImpactContainer" });
    local v212 = p208:_xa097f78b7818eea2({
        "TopCenter",
        "ImpactHolder",
        "ImpactContainer",
        "ImpactMain",
        "Bar",
        "Max",
        "ImpactFill"
    });
    local v213 = p208:_xa097f78b7818eea2({
        "TopCenter",
        "ImpactHolder",
        "ImpactContainer",
        "ImpactMain",
        "Bar",
        "Max",
        "ImpactFlash"
    });
    if l___x01e762287076c1a5__45 and (v210 and (v212 and v212:IsA("GuiObject"))) then
        local v214 = l___x01e762287076c1a5__45.impact or 0;
        local v215 = math.max(l___x01e762287076c1a5__45.impact_limit or 0, 1);
        local v216 = l___x01e762287076c1a5__45.is_breaking == true;
        local v217 = math.clamp((p209 or 0) * 14, 0, 1);
        local l__Scale__46 = v212.Size.X.Scale;
        local v218 = p208._x3e2173c278cffc55.impact_delayed_fill or 0;
        if v216 then
            local v219 = math.max(l___x01e762287076c1a5__45.break_duration or 0, 0.001);
            local l__break_remaining__47 = l___x01e762287076c1a5__45.break_remaining;
            if l___x01e762287076c1a5__45.break_end_time and l___x01e762287076c1a5__45.break_end_time > 0 then
                local v220 = l___x01e762287076c1a5__45.break_end_time - workspace:GetServerTimeNow();
                l__break_remaining__47 = math.max(v220, 0);
            end;
            local v221 = math.clamp(l__break_remaining__47 or v219, 0, v219);
            v210.Visible = true;
            local v222 = l__Scale__46 + (v221 / v219 - l__Scale__46) * math.clamp(v217, 0, 1);
            v212.Size = UDim2.fromScale(v222, 1);
            v212.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            local v223 = v210:FindFirstChild("ImpactText");
            if v223 and (v223:IsA("TextLabel") or v223:IsA("TextButton")) then
                v223.Text = "!! DISABLED !!";
            end;
            local v224 = v210:FindFirstChild("BreakingSubtext");
            if v224 and v224:IsA("GuiObject") then
                v224.Visible = true;
            end;
            p208._x3e2173c278cffc55.impact_delayed_fill = v222;
            local l__Parent__48 = v212.Parent;
            if l__Parent__48 then
                l__Parent__48 = v212.Parent:FindFirstChild("ImpactFlash");
            end;
            if l__Parent__48 and l__Parent__48:IsA("GuiObject") then
                l__Parent__48.Visible = false;
            end;
            if v211 then
                v211 = v211:FindFirstChild("ImpactStroke");
            end;
            if v211 then
                v211 = v211:FindFirstChildWhichIsA("UIStroke");
            end;
            if v211 then
                v211.Color = Color3.fromRGB(255, 0, 0);
            end;
        elseif v214 > 0 then
            v210.Visible = true;
            v212.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            local v225 = v210:FindFirstChild("ImpactText");
            if v225 and (v225:IsA("TextLabel") or v225:IsA("TextButton")) then
                v225.Text = "[ INSTABILITY ]";
            end;
            local v226 = v210:FindFirstChild("BreakingSubtext");
            if v226 and v226:IsA("GuiObject") then
                v226.Visible = false;
            end;
            if v211 then
                v211 = v211:FindFirstChild("ImpactStroke");
            end;
            if v211 then
                v211 = v211:FindFirstChildWhichIsA("UIStroke");
            end;
            if v211 then
                v211.Color = Color3.fromRGB(255, 255, 255);
            end;
            local v227 = math.clamp(v214 / v215, 0, 1);
            local v228;
            if u2 then
                v228 = u2:numLerp(l__Scale__46, v227, v217);
            else
                v228 = l__Scale__46 + (v227 - l__Scale__46) * math.clamp(v217, 0, 1);
            end;
            v212.Size = UDim2.fromScale(v228, 1);
            local v229 = math.clamp((p209 or 0) * 8, 0, 1);
            local v230 = v218 + (v228 - v218) * math.clamp(v229, 0, 1);
            p208._x3e2173c278cffc55.impact_delayed_fill = v230;
            if v213 and v213:IsA("GuiObject") then
                local v231 = math.abs(v228 - v230);
                if v231 > 0 then
                    v231 = math.max(v231, 0.007);
                end;
                v213.Visible = true;
                v213.Position = UDim2.fromScale(v228, 0.5);
                v213.Size = UDim2.fromScale(v231, 7 + math.random(-2, 2));
                v213.BackgroundTransparency = 0.2 + math.random(-0.1, 0.1);
            end;
        else
            local v232 = l__Scale__46 + (0 - l__Scale__46) * math.clamp(v217, 0, 1);
            v212.Size = UDim2.fromScale(v232, 1);
            p208._x3e2173c278cffc55.impact_delayed_fill = v218 + (0 - v218) * math.clamp(v217, 0, 1);
            if v213 and v213:IsA("GuiObject") then
                v213.Visible = false;
            end;
            if v232 <= 0.001 then
                v210.Visible = false;
                v212.Size = UDim2.fromScale(0, 1);
                p208._x3e2173c278cffc55.impact_delayed_fill = 0;
            end;
        end;
    end;
end;
function u5._xec70d13473c9357a(p233) --[[ Line: 1017 ]]
    if p233._x44c74dfd9ba7f108 then
        p233._x44c74dfd9ba7f108:Destroy();
        p233._x44c74dfd9ba7f108 = nil;
    end;
    for _, v234 in p233._x8a1ad518dae63348 do
        if v234 then
            v234:Destroy();
        end;
    end;
    p233._x8a1ad518dae63348 = {};
end;
function u5._xeecc00b1114ae2e0(p235, p236, p237) --[[ Line: 1031 ]]
    -- upvalues: l__UIAssets__5 (copy)
    p235:_xec70d13473c9357a();
    local v238 = p235:_xa097f78b7818eea2({ "BottomLeft", "GunContainer" });
    if v238 then
        local v239 = l__UIAssets__5:FindFirstChild("ItemSilhouettes");
        local v240;
        if v239 then
            v240 = v239:FindFirstChild(p236);
        else
            v240 = v239;
        end;
        if not v240 and v239 then
            v240 = v239:FindFirstChild("Castigate");
        end;
        if v240 then
            p235._x44c74dfd9ba7f108 = v240:Clone();
            p235._x44c74dfd9ba7f108.Parent = v238;
        end;
        local v241 = v238:FindFirstChild("BulletArray");
        if v241 then
            for _, v242 in v241:GetChildren() do
                if v242.Name == "BulletFrame" or v242:FindFirstChild("ActiveBullet") then
                    v242:Destroy();
                end;
            end;
            for v243 = 1, p237 do
                local v244 = l__UIAssets__5.HUDAssets.BulletFrame:Clone();
                v244.Parent = v241;
                p235._x8a1ad518dae63348[v243] = v244;
            end;
        end;
    end;
end;
function u5._x7b5c8200697a1737(_, p245, p246) --[[ Line: 1068 ]]
    local v247 = p245:FindFirstChild("ActiveBullet");
    local v248 = p245:FindFirstChild("InactiveBullet");
    if v247 and v247:IsA("GuiObject") then
        v247.Visible = p246;
    end;
    local v249 = not p246;
    if v248 and v248:IsA("GuiObject") then
        v248.Visible = v249;
    end;
end;
function u5._x99f9ec35dc296f36(p250, p251) --[[ Line: 1076 ]]
    -- upvalues: l__TweenService__3 (copy), u2 (ref)
    local l__gun_item_id__49 = p251.gun_item_id;
    if l__gun_item_id__49 == "" then
        l__gun_item_id__49 = nil;
    end;
    local v252 = math.max(p251.heat or 0, 0);
    local v253 = math.max(p251.heat_max or 0, 0);
    local v254 = math.max(p251.heat_per_bullet or 0, 0);
    local v255 = v254 <= 0 and 0 or math.floor(v253 / v254);
    local v256 = v254 <= 0 and 0 or math.floor(v252 / v254);
    if v253 > 0 then
        if v253 <= v252 then
            v256 = v255;
        end;
    end;
    local v257 = math.clamp(v256, 0, v255);
    if l__gun_item_id__49 ~= p250._x3e2173c278cffc55.gun_item_id or v255 ~= p250._x3e2173c278cffc55.max_bullets then
        p250:_xeecc00b1114ae2e0(l__gun_item_id__49 or "Castigate", v255);
        p250._x3e2173c278cffc55.gun_item_id = l__gun_item_id__49;
        p250._x3e2173c278cffc55.max_bullets = v255;
        p250._x3e2173c278cffc55.bullet_count = nil;
    end;
    local v258 = p250._x3e2173c278cffc55.heat ~= v252;
    local l__bullet_count__50 = p250._x3e2173c278cffc55.bullet_count;
    if v258 or l__bullet_count__50 == nil then
        for v259, v260 in p250._x8a1ad518dae63348 do
            p250:_x7b5c8200697a1737(v260, v259 <= v257);
        end;
        if l__bullet_count__50 then
            if l__bullet_count__50 < v257 and p250._x44c74dfd9ba7f108 then
                local v261 = p250._x44c74dfd9ba7f108:FindFirstChild("Flash");
                if v261 and v261:IsA("GuiObject") then
                    v261.BackgroundTransparency = 0;
                    l__TweenService__3:Create(v261, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play();
                end;
                local v262 = p250._x8a1ad518dae63348[v257];
                if v262 then
                    v262 = v262:FindFirstChild("ActiveBullet");
                end;
                if v262 and v262:IsA("GuiObject") then
                    v262.Position = UDim2.fromScale(0.5, -0.5);
                    l__TweenService__3:Create(v262, TweenInfo.new(0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0.5, 0.5)
                    }):Play();
                end;
            elseif v257 < l__bullet_count__50 then
                local v263 = p250._x8a1ad518dae63348[v257 + 1];
                if v263 then
                    v263 = v263:FindFirstChild("Flash");
                end;
                if v263 and v263:IsA("GuiObject") then
                    v263.BackgroundTransparency = 0;
                    l__TweenService__3:Create(v263, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play();
                end;
            end;
        end;
        local l___x44c74dfd9ba7f108__51 = p250._x44c74dfd9ba7f108;
        if l___x44c74dfd9ba7f108__51 then
            l___x44c74dfd9ba7f108__51 = p250._x44c74dfd9ba7f108:FindFirstChildWhichIsA("UIGradient");
        end;
        if l___x44c74dfd9ba7f108__51 and v254 > 0 then
            local v264 = math.fmod(v252, v254);
            local v265 = v253 > 0 and v253 <= v252 and 1 or math.clamp(v264 / v254, 0, 1);
            local v266;
            if u2 then
                v266 = u2:convNumRange(v265, 0, 1, 0.5, -0.5);
            else
                v266 = 0.5 - v265;
            end;
            l__TweenService__3:Create(l___x44c74dfd9ba7f108__51, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Offset = Vector2.new(0, v266)
            }):Play();
        end;
        p250._x3e2173c278cffc55.bullet_count = v257;
        p250._x3e2173c278cffc55.heat = v252;
    end;
end;
function u5._x9fd5a168d7692773(p267) --[[ Line: 1146 ]]
    local v268 = p267:_xa097f78b7818eea2({ "BottomCenter", "SpeedVisualizer" });
    if v268 then
        local l___x01e762287076c1a5__52 = p267._x01e762287076c1a5;
        local v269;
        if l___x01e762287076c1a5__52 then
            local l__speed__53 = l___x01e762287076c1a5__52.speed;
            if l__speed__53 == nil and typeof(l___x01e762287076c1a5__52.velocity) == "Vector3" then
                local l__velocity__54 = l___x01e762287076c1a5__52.velocity;
                l__speed__53 = Vector3.new(l__velocity__54.X, 0, l__velocity__54.Z).Magnitude;
            end;
            local v270 = math.max(l__speed__53 or 0, 0) * 10;
            v269 = math.floor(v270) / 10 .. " u/s";
        else
            v269 = "0 u/s";
        end;
        if v268 and (v268:IsA("TextLabel") or v268:IsA("TextButton")) then
            v268.Text = v269;
        end;
    end;
end;
function u5._xc4b67eadc4eed6b7(p271, p272) --[[ Line: 1168 ]]
    p271:_x9fd5a168d7692773();
    p271:_x64c4b23c2707135c(p272);
    local l___x01e762287076c1a5__55 = p271._x01e762287076c1a5;
    local v273 = p271:_xa097f78b7818eea2({ "BottomCenter", "KillstreakVisualizer" });
    if l___x01e762287076c1a5__55 and (v273 and (l___x01e762287076c1a5__55.killstreak or 0) >= 1) then
        local v274 = v273:FindFirstChild("Radial");
        if v274 and v274:IsA("GuiObject") then
            v274.Rotation = (v274.Rotation + p272 * 90 * ((l___x01e762287076c1a5__55.killstreak or 0) % 2 == 0 and -1 or 1)) % 360;
        end;
    end;
end;
function u5._x2f63a8330ae40624(u275, p276) --[[ Line: 1185 ]]
    -- upvalues: l__Classes__14 (copy), l__UIAssets__5 (copy), l__LocalPlayer__16 (copy), l__RunService__1 (copy)
    u275:_xe3f2a9674668048b();
    u275:_xdbd7a6fb380428bc();
    if l__Classes__14.MenuManager.in_menu then
        l__Classes__14.MenuManager.screen.Enabled = false;
    end;
    local v277 = l__UIAssets__5:FindFirstChild("SpectateHUD");
    if v277 then
        local l___xfd176cd213628135__56 = u275._xfd176cd213628135;
        if l___xfd176cd213628135__56 then
            l___xfd176cd213628135__56 = u275._xfd176cd213628135:FindFirstChild("Main");
        end;
        if l___xfd176cd213628135__56 and l___xfd176cd213628135__56:IsA("GuiObject") then
            u275._xd04b1e50b6aaffb8 = l___xfd176cd213628135__56.Visible;
            l___xfd176cd213628135__56.Visible = false;
        end;
        u275._xa6d3fe82369e0c2f = p276;
        u275._x2b1d1be5f01bc37f = v277:Clone();
        u275._x01e762287076c1a5 = nil;
        u275._x3e2173c278cffc55 = {
            killstreak = 0
        };
        u275._x8a1ad518dae63348 = {};
        u275._x150106ccf5e1fa00.Enabled = true;
        u275._x4cc2fe9bd0030f75:Add(u275._x2b1d1be5f01bc37f);
        if u275._x2b1d1be5f01bc37f:IsA("ScreenGui") then
            u275._x2b1d1be5f01bc37f.ResetOnSpawn = false;
            u275._x2b1d1be5f01bc37f.IgnoreGuiInset = true;
            u275._x2b1d1be5f01bc37f.Parent = l__LocalPlayer__16.PlayerGui;
        else
            u275._x2b1d1be5f01bc37f.Parent = u275._x150106ccf5e1fa00;
        end;
        u275:_x3bef611200666541();
        u275._x4cc2fe9bd0030f75:Connect(l__RunService__1.RenderStepped, function(p278) --[[ Line: 1225 ]]
            -- upvalues: u275 (copy)
            u275:_xc4b67eadc4eed6b7(p278);
        end);
    else
        warn("NO SpectateHUD UI ASSET FOUND");
    end;
end;
function u5._xa289f60345f4f436(p279, p280) --[[ Line: 1230 ]]
    if p279._x2b1d1be5f01bc37f and typeof(p280) == "table" then
        p279._x01e762287076c1a5 = p280;
        p279:_x681056133a1b3d7d(p280);
        p279:_xbfcfcfddb187a803(p280);
        p279:_x99f9ec35dc296f36(p280);
    end;
end;
function u5._xdbd7a6fb380428bc(p281) --[[ Line: 1241 ]]
    for v282, v283 in p281._x6a63f35101775a95 do
        if v283.indicator_ui then
            v283.indicator_ui:Destroy();
        end;
        p281._x6a63f35101775a95[v282] = nil;
    end;
end;
function u5._x17fbefc711a68d3f(p284) --[[ Line: 1250 ]]
    local v285 = {};
    for v286, v287 in p284._x6a63f35101775a95 do
        if v287.is_spectate then
            table.insert(v285, v286);
        end;
    end;
    for _, v288 in v285 do
        local v289 = p284._x6a63f35101775a95[v288];
        if v289 and v289.indicator_ui then
            v289.indicator_ui:Destroy();
        end;
        p284._x6a63f35101775a95[v288] = nil;
    end;
end;
function u5._xe3f2a9674668048b(p290) --[[ Line: 1267 ]]
    -- upvalues: l__Classes__14 (copy)
    local l___xfd176cd213628135__57 = p290._xfd176cd213628135;
    if l___xfd176cd213628135__57 then
        l___xfd176cd213628135__57 = p290._xfd176cd213628135:FindFirstChild("Main");
    end;
    if p290._xd04b1e50b6aaffb8 ~= nil and (l___xfd176cd213628135__57 and l___xfd176cd213628135__57:IsA("GuiObject")) then
        l___xfd176cd213628135__57.Visible = p290._xd04b1e50b6aaffb8;
    end;
    if l__Classes__14.MenuManager.in_menu then
        l__Classes__14.MenuManager.screen.Enabled = true;
    end;
    p290:_x17fbefc711a68d3f();
    p290._x4cc2fe9bd0030f75:Clean();
    p290._x2b1d1be5f01bc37f = nil;
    p290._xa6d3fe82369e0c2f = nil;
    p290._xd04b1e50b6aaffb8 = nil;
    p290._x01e762287076c1a5 = nil;
    p290._x3e2173c278cffc55 = {};
    p290._x44c74dfd9ba7f108 = nil;
    p290._x8a1ad518dae63348 = {};
end;
function u5._x847902aa3abd060a(p291, p292) --[[ Line: 1288 ]]
    -- upvalues: l__Trove__10 (copy), l__UIAssets__5 (copy), l__Promise__9 (copy), l__TitleData__11 (copy), l__Classes__14 (copy), u10 (copy), l__SkinDefs__13 (copy), u15 (copy), l__TweenService__3 (copy), u32 (copy)
    if p291._xfd176cd213628135 then
        local u293 = l__Trove__10.new();
        local l__agent_player__58 = p292.agent_player;
        local v294 = {};
        local v295 = {
            Headhunter = {
                deathcard_type = "Default",
                name = "HEADHUNTER",
                level = "???",
                item_value = 4444444444,
                player_icon = "rbxassetid://94119588643501",
                item_id = "UNKNOWN"
            }
        };
        for v296, v297 in pairs(p292) do
            v294[v296] = v297;
        end;
        local v298;
        if typeof(l__agent_player__58) == "Instance" then
            v298 = l__agent_player__58:IsA("Player");
        else
            v298 = false;
        end;
        if not v298 then
            local v299 = v295[tostring(l__agent_player__58)];
            if not v299 then
                warn("NO SUCH PLAYER GAVE DEATHCARD", l__agent_player__58);
                return;
            end;
            for v300, v301 in pairs(v299) do
                v294[v300] = v301;
            end;
            warn("CUSTOM DEATHCARD SHOWN :", l__agent_player__58);
            l__agent_player__58 = nil;
        end;
        local v302 = l__UIAssets__5.DeathCards:FindFirstChild(v294.deathcard_type);
        if v302 then
            local v303;
            if l__agent_player__58 then
                local v304 = tostring(l__agent_player__58.UserId);
                v303 = game:GetService("ReplicatedStorage").ReadOnly.Players:FindFirstChild(v304);
                if not v303 then
                    warn("NO READABLE FOLDER TO FIND DATA FOR DEATHCARD for userId:", v304);
                    v303 = nil;
                end;
            else
                v303 = nil;
            end;
            local u305 = v302:Clone();
            u293:Add(u305);
            local u306 = l__Promise__9.delay(8);
            local v307 = u305:FindFirstChild("NameLabel", true);
            if v307 then
                if v294.name then
                    v307.Text = v294.name;
                elseif l__agent_player__58 then
                    v307.Text = l__agent_player__58.Name;
                else
                    v307.Text = "UNKNOWN";
                end;
            end;
            local v308 = u305:FindFirstChild("LevelLabel", true);
            if v308 then
                local v309 = nil;
                if v294.level == nil then
                    if v303 then
                        local v310 = v303:FindFirstChild("level");
                        if v310 then
                            v309 = v310.Value;
                        end;
                    end;
                else
                    v309 = v294.level;
                end;
                if v309 ~= nil then
                    v308.Text = " LEVEL " .. tostring(v309) .. " ";
                end;
            end;
            local v311 = u305:FindFirstChild("PortraitImage", true);
            if v311 then
                local v312 = nil;
                if v294.player_icon == nil then
                    if v303 then
                        local v313 = v303:FindFirstChild("player_icon");
                        if v313 then
                            v312 = v313.Value;
                        end;
                    end;
                else
                    v312 = v294.player_icon;
                    v311.ImageColor3 = Color3.fromRGB(100, 100, 100);
                end;
                if v312 then
                    v311.Image = v312;
                end;
            end;
            local v314 = u305:FindFirstChild("TitleLabel", true);
            if v314 then
                if v294.equipped_title then
                    l__TitleData__11.renderFromLabel(v314, v294.equipped_title);
                else
                    local v315 = v303 and v303:FindFirstChild("equipped_title");
                    if v315 then
                        l__TitleData__11.renderFromLabel(v314, v315.Value);
                    end;
                end;
            end;
            local v316 = u305:FindFirstChild("WeaponName", true);
            if v316 and v294.item_id then
                v316.Text = tostring(v294.item_id):upper();
            end;
            local v317 = u305:FindFirstChild("WeaponValue", true);
            if v317 then
                v317.Text = " VALUED : ¥" .. l__Classes__14.Util:formatNumber(v294.item_value or 0) .. " ";
            end;
            local v318;
            if v294 then
                v318 = v294.item_id;
            else
                v318 = v294;
            end;
            local v319;
            if v318 then
                v319 = typeof(v294.skin_id) == "number" and u10(l__SkinDefs__13.resolveRig3P(v318, v294.skin_id)) or u15(v318);
            else
                v319 = nil;
            end;
            local u320 = u305:FindFirstChild("ItemDisplay", true);
            if v319 and u320 then
                l__TweenService__3:Create(u320, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                local u321 = Instance.new("Camera");
                u320.CurrentCamera = u321;
                u321.Parent = u320;
                local u322 = v319:Clone();
                u322.Parent = u320;
                local v323 = u322:GetBoundingBox();
                u322:PivotTo(u322:GetPivot() - v323.Position);
                local v324 = u32(u322, u320, u321);
                if v324 then
                    u321.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v324), Vector3.new(0, 0, 0));
                end;
                u293:Add(u320:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 1459 ]]
                    -- upvalues: u32 (ref), u322 (copy), u320 (copy), u321 (copy)
                    local v325 = u32(u322, u320, u321);
                    if v325 then
                        u321.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v325), Vector3.new(0, 0, 0));
                    end;
                end));
                u293:Add(u320:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 1463 ]]
                    -- upvalues: u32 (ref), u322 (copy), u320 (copy), u321 (copy)
                    local v326 = u32(u322, u320, u321);
                    if v326 then
                        u321.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v326), Vector3.new(0, 0, 0));
                    end;
                end));
            end;
            if v294.deathcard_type == "Default" then
                local l__Texture1__59 = u305:FindFirstChild("WeaponCanvas").Texture1;
                local l__Texture2__60 = u305:FindFirstChild("WeaponCanvas").Texture2;
                l__TweenService__3:Create(l__Texture1__59, TweenInfo.new(8), {
                    Position = UDim2.fromScale(0.4, 0.6)
                }):Play();
                l__TweenService__3:Create(l__Texture2__60, TweenInfo.new(8), {
                    Position = UDim2.fromScale(0.6, 0.4)
                }):Play();
            end;
            u293:Add(l__Classes__14._x8399b2bb73e12808:_x9ccd957f12430c82("onHit"):Once(function() --[[ Line: 1478 ]]
                -- upvalues: u306 (copy)
                u306:cancel();
            end));
            u293:Add(l__Classes__14._x8399b2bb73e12808:_x9ccd957f12430c82("onDamageTaken"):Once(function() --[[ Line: 1482 ]]
                -- upvalues: u306 (copy)
                u306:cancel();
            end));
            u293:Add(u305.Destroying:Connect(function() --[[ Line: 1486 ]]
                -- upvalues: u306 (copy)
                u306:cancel();
            end));
            u306:finally(function() --[[ Line: 1490 ]]
                -- upvalues: u305 (copy), l__TweenService__3 (ref), u293 (copy)
                if u305 then
                    l__TweenService__3:Create(u305, TweenInfo.new(0.5), {
                        GroupTransparency = 1
                    }):Play();
                end;
                task.delay(8.05, function() --[[ Line: 1495 ]]
                    -- upvalues: u293 (ref)
                    u293:Clean();
                end);
            end);
            u305.Parent = p291._xfd176cd213628135;
            return u306;
        end;
        warn("NO SUCH DEATHCARD TYPE : ", v294.deathcard_type);
    else
        warn("NO MAIN HUD TO DISPLAY_DEATHCARD");
    end;
end;
function u5._xa2afd2b77542b209(u327, u328) --[[ Line: 1505 ]]
    -- upvalues: u4 (ref), l__UIAssets__5 (copy), l__Classes__14 (copy), l__TweenService__3 (copy)
    if u327._xfd176cd213628135 then
        local l__heat_per_bullet__61 = u328.heat_per_bullet;
        local u329 = u4:_xe7f02e22353709c3("heat");
        local u330 = u328.heat_per_bullet * u328.magazine;
        task.spawn(function() --[[ Line: 1513 ]]
            -- upvalues: u327 (copy), u328 (copy), l__UIAssets__5 (ref), u329 (copy), l__heat_per_bullet__61 (copy), u330 (copy), l__Classes__14 (ref), l__TweenService__3 (ref)
            (function() --[[ Name: startModule, Line 1514 ]]
                -- upvalues: u327 (ref), u328 (ref), l__UIAssets__5 (ref), u329 (ref), l__heat_per_bullet__61 (ref), u330 (ref), l__Classes__14 (ref), l__TweenService__3 (ref)
                local l__GunContainer__62 = u327._xfd176cd213628135.Main.BottomLeft.GunContainer;
                local v331 = l__UIAssets__5.ItemSilhouettes:FindFirstChild(u328.item_id);
                local u332;
                if v331 then
                    u332 = v331:Clone();
                else
                    u332 = l__UIAssets__5.ItemSilhouettes.Castigate:Clone();
                    warn("COULD NOT FIND GUN IMAGE, DEFAULTED TO CASTIGATE");
                end;
                local l__UIGradient__63 = u332.UIGradient;
                local u333 = math.floor(u329.Value / l__heat_per_bullet__61);
                local u334 = u333;
                u332.Parent = l__GunContainer__62;
                local u335 = {};
                local function u338() --[[ Line: 1546 ]]
                    -- upvalues: u333 (ref), u335 (copy)
                    local v336 = u333;
                    for _, v337 in u335 do
                        if v336 > 0 then
                            v336 = v336 - 1;
                            v337.ActiveBullet.Visible = true;
                            v337.InactiveBullet.Visible = false;
                        else
                            v337.ActiveBullet.Visible = false;
                            v337.InactiveBullet.Visible = true;
                        end;
                    end;
                end;
                local v339 = u333;
                local u340 = u333;
                for v341 = 1, math.floor(u330 / l__heat_per_bullet__61) do
                    local v342 = l__UIAssets__5.HUDAssets.BulletFrame:Clone();
                    v342.Parent = l__GunContainer__62.BulletArray;
                    u335[v341] = v342;
                    if v339 > 0 then
                        v339 = v339 - 1;
                        v342.ActiveBullet.Visible = true;
                        v342.InactiveBullet.Visible = false;
                    else
                        v342.ActiveBullet.Visible = false;
                        v342.InactiveBullet.Visible = true;
                    end;
                end;
                local function u349() --[[ Line: 1574 ]]
                    -- upvalues: u329 (ref), l__heat_per_bullet__61 (ref), u330 (ref), u340 (ref), l__Classes__14 (ref), l__GunContainer__62 (copy), u332 (ref), l__TweenService__3 (ref), u335 (copy), u334 (ref), u338 (copy), l__UIGradient__63 (copy)
                    local v343 = math.fmod(u329.Value, l__heat_per_bullet__61);
                    local v344 = u329.Value == u330 and 1 or math.map(v343, 0, l__heat_per_bullet__61, 0, 1);
                    local v345 = math.map(v344, 0, 1, 0.5, -0.5);
                    u340 = math.floor(u329.Value / l__heat_per_bullet__61);
                    local l__KeyCode__64 = l__Classes__14._xf1ad98d2d70b7408:_x93fd21adac562b5e("GUN").KeyCode;
                    l__GunContainer__62.GunKey.KeyText.Text = l__Classes__14._xf1ad98d2d70b7408:_x9afb0bbcc2b58dcd(l__KeyCode__64);
                    local function v347() --[[ Line: 1583 ]]
                        -- upvalues: u332 (ref), l__TweenService__3 (ref), l__Classes__14 (ref), u335 (ref), u340 (ref)
                        local l__Flash__65 = u332.Flash;
                        l__Flash__65.BackgroundTransparency = 0;
                        l__TweenService__3:Create(l__Flash__65, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play();
                        l__Classes__14._x6dbba03a0636f7d8:_x282746dbf42c87cb("BULLET_GAINED", true);
                        local v346 = u335[u340];
                        if v346 then
                            local l__ActiveBullet__66 = v346.ActiveBullet;
                            l__ActiveBullet__66.Position = UDim2.fromScale(0.5, -0.5);
                            l__TweenService__3:Create(l__ActiveBullet__66, TweenInfo.new(0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                                Position = UDim2.fromScale(0.5, 0.5)
                            }):Play();
                        end;
                    end;
                    local function v348() --[[ Line: 1598 ]]
                        -- upvalues: u335 (ref), u340 (ref), l__TweenService__3 (ref)
                        local l__Flash__67 = u335[u340 + 1].Flash;
                        if l__Flash__67 then
                            l__Flash__67.BackgroundTransparency = 0;
                            l__TweenService__3:Create(l__Flash__67, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 1
                            }):Play();
                        end;
                    end;
                    if u334 < u340 then
                        v347();
                        u338();
                        l__UIGradient__63.Offset = Vector2.new(0, 0.5);
                    elseif u340 < u334 then
                        v348();
                        u338();
                        l__UIGradient__63.Offset = Vector2.new(0, -0.5);
                    end;
                    l__TweenService__3:Create(l__UIGradient__63, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Offset = Vector2.new(0, v345)
                    }):Play();
                    u334 = u340;
                end;
                u349();
                local v350 = u329.Changed:Connect(function(_) --[[ Line: 1624 ]]
                    -- upvalues: u349 (copy)
                    u349();
                end);
                u327._x06f6523fee19e54a:Add(v350);
            end)();
        end);
    else
        warn("NO MAIN HUD TO LOAD GUN DATA");
    end;
end;
function u5._xa26b35492ceca8db(p351, p352) --[[ Line: 1636 ]]
    if p351._xf32023927dadf4ad and typeof(p351._xf32023927dadf4ad) == "function" then
        return p351._xf32023927dadf4ad(p352);
    end;
end;
function u5._x82a81ec01445cd97(u353, p354) --[[ Line: 1642 ]]
    -- upvalues: l__Promise__9 (copy), l__TweenService__3 (copy)
    if u353._xfd176cd213628135 then
        if u353._xf3c4e81cd8c7fb47 then
            u353._xf3c4e81cd8c7fb47:cancel();
        end;
        local u355 = os.clock();
        u353._xeac713f43d41c2b8 = u355;
        local l___xfd176cd213628135__68 = u353._xfd176cd213628135;
        local l__HeaderNotifLabel__69 = l___xfd176cd213628135__68.Misc.HeaderNotifLabel;
        local l__HeaderSubtext__70 = l___xfd176cd213628135__68.Misc.HeaderSubtext;
        l__HeaderNotifLabel__69.Text = p354.header_text or "";
        l__HeaderSubtext__70.Text = p354.subheader_text or "";
        l__HeaderNotifLabel__69.TextTransparency = 0;
        l__HeaderSubtext__70.TextTransparency = 0;
        if p354.color then
            l__HeaderNotifLabel__69.TextColor3 = p354.color;
            l__HeaderSubtext__70.TextColor3 = p354.color;
        else
            l__HeaderNotifLabel__69.TextColor3 = Color3.new(1, 1, 1);
            l__HeaderSubtext__70.TextColor3 = Color3.new(1, 1, 1);
        end;
        local function v356() --[[ Line: 1669 ]]
            -- upvalues: u353 (copy), u355 (copy), l__HeaderNotifLabel__69 (copy), l__HeaderSubtext__70 (copy)
            if u353._xeac713f43d41c2b8 == u355 then
                l__HeaderNotifLabel__69.Text = "";
                l__HeaderSubtext__70.Text = "";
            end;
        end;
        if p354.life_time then
            u353._xf3c4e81cd8c7fb47 = l__Promise__9.delay(p354.life_time);
            l__TweenService__3:Create(l__HeaderNotifLabel__69, TweenInfo.new(p354.life_time, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play();
            l__TweenService__3:Create(l__HeaderSubtext__70, TweenInfo.new(p354.life_time, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play();
            u353._xf3c4e81cd8c7fb47:andThen(function() --[[ Line: 1680 ]]
                -- upvalues: u353 (copy), u355 (copy), l__HeaderNotifLabel__69 (copy), l__HeaderSubtext__70 (copy)
                if u353._xeac713f43d41c2b8 == u355 then
                    l__HeaderNotifLabel__69.Text = "";
                    l__HeaderSubtext__70.Text = "";
                end;
            end);
        end;
        return v356;
    end;
end;
function u5._x2c8149245b825cb9(u357) --[[ Line: 1688 ]]
    -- upvalues: l__UIAssets__5 (copy), l__Classes__14 (copy), l__RunService__1 (copy), u3 (ref), u2 (ref), u4 (ref), l__LevelService__12 (copy), l__TweenService__3 (copy), l___x7749231778538ccb__15 (copy), l__Promise__9 (copy), l__Packets__7 (copy)
    local u358 = l__UIAssets__5.HUDAssets.MainHUD:Clone();
    local l__Main__71 = u358.Main;
    u357._xfd176cd213628135 = u358;
    u357._x06f6523fee19e54a:Add(u358);
    local l___xdca80115d2839102__72 = l__Classes__14._xdca80115d2839102;
    local u359 = 0;
    local v363 = l__RunService__1.RenderStepped:Connect(function() --[[ Line: 1698 ]]
        -- upvalues: l___xdca80115d2839102__72 (copy), l__Classes__14 (ref), l__Main__71 (copy), u3 (ref), u2 (ref), u359 (ref)
        local v360 = l___xdca80115d2839102__72._x5d3b27bfd0a12cd9 * 25 + l__Classes__14._xdca80115d2839102._x12d03a44e8b02ddc.shake_spring_x.Velocity * 0.5;
        local v361 = l___xdca80115d2839102__72._x9e17087c104df3a7 * 25;
        local v362 = math.clamp(l___xdca80115d2839102__72._x120f4a9aed8ade07, -1, 1);
        l__Main__71.Position = UDim2.fromScale(0.5 - v360, 0.5 - v361);
        l__Main__71.Rotation = v362 * 10;
        if u3._xfd7cc994ccc60ad7 then
            u359 = u2:numLerp(u359, u2:convNumRange(math.clamp(u3._xfd7cc994ccc60ad7.Magnitude, 50, 150), 50, 150, 0, 0.02), 0.08);
            l__Main__71.Size = UDim2.fromScale(u359 + 1, u359 + 1);
        end;
    end);
    u357._x06f6523fee19e54a:Add(v363);
    function u357._xf32023927dadf4ad(p364) --[[ Line: 1722 ]]
        -- upvalues: l__Main__71 (copy), l__UIAssets__5 (ref)
        local l__GameplayCues__73 = l__Main__71.BottomCenter.GameplayCues;
        if p364.cue_type == "progress" then
            local u365 = l__UIAssets__5.ProgressCue:Clone();
            u365.Label.Text = p364.text;
            u365.ProgressMeter.Changed:Connect(function() --[[ Line: 1728 ]]
                -- upvalues: u365 (copy)
                u365.Container.Fill.Progress.Size = UDim2.fromScale(u365.ProgressMeter.Value, 1);
            end);
            u365.Parent = l__GameplayCues__73;
            return function() --[[ Name: cleanup, Line 1733 ]]
                -- upvalues: u365 (copy)
                if u365 then
                    u365:Destroy();
                end;
            end, u365.ProgressMeter;
        end;
        if p364.cue_type == "message" then
            local u366 = l__UIAssets__5.MessageCue:Clone();
            u366.Container.Label.Text = p364.text;
            u366.Parent = l__GameplayCues__73;
            return function() --[[ Name: cleanup, Line 1745 ]]
                -- upvalues: u366 (copy)
                if u366 then
                    u366:Destroy();
                end;
            end;
        end;
        warn("NO SUCH CUE TYPE : ", p364.cue_type);
    end;
    local l__GuiService__74 = game:GetService("GuiService");
    local l__TopbarInset__75 = l__GuiService__74.TopbarInset;
    u358.TopbarUI.Topbar.Size = UDim2.new(0, workspace.CurrentCamera.ViewportSize.X - l__TopbarInset__75.Width, 0, l__TopbarInset__75.Height);
    local v367 = l__GuiService__74:GetPropertyChangedSignal("TopbarInset"):Connect(function() --[[ Line: 1765 ]]
        -- upvalues: l__GuiService__74 (copy), u358 (copy)
        local l__TopbarInset__76 = l__GuiService__74.TopbarInset;
        u358.TopbarUI.Topbar.Size = UDim2.new(0, workspace.CurrentCamera.ViewportSize.X - l__TopbarInset__76.Width, 0, l__TopbarInset__76.Height);
    end);
    local v369 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 1769 ]]
        -- upvalues: l__Classes__14 (ref), l__Main__71 (copy)
        local v368 = not l__Classes__14._x1a4ce4062771e36e._xfd7cc994ccc60ad7 and "0 u/s" or math.floor((l__Classes__14._x1a4ce4062771e36e._xfd7cc994ccc60ad7 * Vector3.new(1, 0, 1)).Magnitude * 10) / 10 .. " u/s";
        l__Main__71.BottomCenter.SpeedVisualizer.Text = v368;
    end);
    u357._x06f6523fee19e54a:Add(v367);
    u357._x06f6523fee19e54a:Add(v369);
    local l__LevelFrame__77 = u358.Misc.LevelFrame;
    local u370 = u4:_xe7f02e22353709c3("total_xp");
    local u371 = u4:_xe7f02e22353709c3("level");
    local l__Value__78 = u371.Value;
    local l__Value__79 = u370.Value;
    local function v374() --[[ Line: 1795 ]]
        -- upvalues: u370 (copy), l__Value__79 (ref), l__LevelService__12 (ref), l__TweenService__3 (ref), l__LevelFrame__77 (copy)
        local l__Value__80 = u370.Value;
        if l__Value__79 < l__Value__80 then
            l__Value__79 = l__Value__80;
            local v372 = l__LevelService__12.getProgressPercent(l__Value__80);
            l__TweenService__3:Create(l__LevelFrame__77.Bar.Fill, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v372, 1)
            }):Play();
        else
            l__Value__79 = l__Value__80;
            local v373 = l__TweenService__3:GetValue(l__LevelService__12.getProgressPercent(l__Value__80), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            l__LevelFrame__77.Bar.Fill.Size = UDim2.fromScale(v373, 1);
        end;
    end;
    local function v377() --[[ Line: 1810 ]]
        -- upvalues: u371 (copy), l__Value__78 (ref), l__LevelFrame__77 (copy), l__TweenService__3 (ref), l__Classes__14 (ref)
        local l__Value__81 = u371.Value;
        local v375 = {
            [10] = "Keep climbing, FREELANCER.",
            [25] = "Your skill is recognized, PROFESSIONAL.",
            [50] = "Welcome to the ELITE.",
            [75] = "No hesitation, MENACE.",
            [90] = "End of the line, your EMINENCE.",
            [91] = "9 REMAIN.",
            [92] = "8 REMAIN.",
            [93] = "7 REMAIN.",
            [94] = "6 REMAIN.",
            [95] = "5 REMAIN.",
            [96] = "4 REMAIN.",
            [97] = "3 REMAIN.",
            [98] = "2 REMAIN.",
            [99] = "1 REMAINS.",
            [100] = "PULSE HAS BEEN SILENCED, FLATLINER."
        };
        if l__Value__78 < l__Value__81 then
            l__Value__78 = l__Value__81;
            local v376 = v375[l__Value__81];
            if v376 then
                v376 = v376 .. " ↑ LV" .. l__Value__81 or v376;
            end;
            l__LevelFrame__77.LevelUp.Text = v376 or "LV UP! ↑ LV" .. l__Value__81;
            l__LevelFrame__77.LevelUp.Position = UDim2.fromScale(0, 1.06);
            l__LevelFrame__77.LevelUp.TextTransparency = 0.2;
            l__TweenService__3:Create(l__LevelFrame__77.LevelUp, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0, 1)
            }):Play();
            l__TweenService__3:Create(l__LevelFrame__77.LevelUp, TweenInfo.new(v376 and 12 or 6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play();
            l__LevelFrame__77.Flash.Size = UDim2.new(1, 0, 0, 4);
            l__LevelFrame__77.Flash.BackgroundTransparency = 0;
            l__LevelFrame__77.Flash.Position = UDim2.fromScale(0, 1);
            l__TweenService__3:Create(l__LevelFrame__77.Flash, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Position = UDim2.fromScale(0, 0.75)
            }):Play();
            l__LevelFrame__77.Gradient.BackgroundTransparency = 0.3;
            l__TweenService__3:Create(l__LevelFrame__77.Gradient, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__Classes__14._x6dbba03a0636f7d8:_x282746dbf42c87cb("LEVELUP", true);
        else
            l__Value__78 = l__Value__81;
        end;
    end;
    v374();
    v377();
    local v378 = u371.Changed:Connect(v377);
    local v379 = u370.Changed:Connect(v374);
    u357._x06f6523fee19e54a:Add(v378);
    u357._x06f6523fee19e54a:Add(v379);
    local v380 = l___x7749231778538ccb__15._xd644d9e3ba63f27f("", l__Classes__14._xddeb4dd489515b18._x4852b50d8a214859);
    if l__Classes__14._xddeb4dd489515b18._x0822391eeeb254e9 and not (v380 and v380._x1157c0637bb2e313) then
        u358.TopbarUI.MenuIndicator.IndicatorFrame.Visible = false;
    else
        local l__IndicatorFrame__82 = u358.TopbarUI.MenuIndicator.IndicatorFrame;
        local u381 = u4:_xe7f02e22353709c3("in_combat");
        local _ = game:GetService("ReplicatedStorage").Assets.RemoteEvents.Reset;
        local u382 = {};
        local function u387() --[[ Line: 1879 ]]
            -- upvalues: l__IndicatorFrame__82 (copy), l__TweenService__3 (ref), u382 (copy)
            l__IndicatorFrame__82.SignalLost.Visible = true;
            l__IndicatorFrame__82.LostText.Visible = true;
            l__IndicatorFrame__82.IndicatorText.Visible = false;
            l__IndicatorFrame__82.NetworkSymbol.Visible = false;
            l__IndicatorFrame__82.LoseKillstreak.Visible = false;
            local v383 = TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            l__IndicatorFrame__82.SignalLost.ImageTransparency = 0.5;
            l__IndicatorFrame__82.LostText.TextTransparency = 0.2;
            l__IndicatorFrame__82.SignalLostText.Visible = true;
            l__IndicatorFrame__82.SignalLostText.TextTransparency = 0.2;
            local v384 = l__TweenService__3:Create(l__IndicatorFrame__82.SignalLost, v383, {
                ImageTransparency = 1
            }):Play();
            local v385 = l__TweenService__3:Create(l__IndicatorFrame__82.LostText, v383, {
                TextTransparency = 1
            }):Play();
            local v386 = l__TweenService__3:Create(l__IndicatorFrame__82.SignalLostText, v383, {
                TextTransparency = 1
            }):Play();
            game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
            table.insert(u382, v384);
            table.insert(u382, v385);
            table.insert(u382, v386);
        end;
        local function u390() --[[ Line: 1905 ]]
            -- upvalues: u382 (copy), l__IndicatorFrame__82 (copy), l__TweenService__3 (ref), u4 (ref)
            for _, v388 in u382 do
                v388:Cancel();
            end;
            task.spawn(function() --[[ Line: 1910 ]]
                -- upvalues: u382 (ref)
                local l__StarterGui__83 = game:GetService("StarterGui");
                while true do
                    local v389, _ = pcall(function() --[[ Line: 1914 ]]
                        -- upvalues: l__StarterGui__83 (copy)
                        l__StarterGui__83:SetCore("ResetButtonCallback", false);
                    end);
                    if not v389 then
                        task.wait(0.1);
                    end;
                    if v389 then
                        table.clear(u382);
                        return;
                    end;
                end;
            end);
            l__IndicatorFrame__82.SignalLost.Visible = false;
            l__IndicatorFrame__82.LostText.Visible = false;
            l__IndicatorFrame__82.NetworkSymbol.Fill.ImageTransparency = 1;
            l__IndicatorFrame__82.FlashFrame.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__IndicatorFrame__82.FlashFrame, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            if u4:_xe7f02e22353709c3("killstreak").Value > 0 then
                l__IndicatorFrame__82.LoseKillstreak.Visible = true;
            else
                l__IndicatorFrame__82.LoseKillstreak.Visible = false;
            end;
            l__IndicatorFrame__82.NetworkSymbol.Fill.ImageTransparency = 0;
            l__IndicatorFrame__82.NetworkSymbol.Visible = true;
            l__IndicatorFrame__82.IndicatorText.Text = "[M] Access MENU";
            l__IndicatorFrame__82.NetworkSymbol.ImageTransparency = 0;
            l__IndicatorFrame__82.IndicatorText.Visible = true;
            l__IndicatorFrame__82.SignalLostText.Visible = false;
        end;
        if u381.Value then
            u387();
        else
            u390();
        end;
        local v392 = u381.Changed:Connect(function(p391) --[[ Line: 1951 ]]
            -- upvalues: u387 (copy), u390 (copy)
            if p391 then
                u387();
            else
                u390();
            end;
        end);
        local v393 = u357._x169361cbea19e64b.attempt_connect:Connect(function() --[[ Line: 1959 ]]
            -- upvalues: u381 (copy), u387 (copy), u390 (copy)
            if u381.Value then
                u387();
            else
                u390();
            end;
        end);
        u357._x06f6523fee19e54a:Add(v392);
        u357._x06f6523fee19e54a:Add(v393);
    end;
    local l__NotificationCanvas__84 = l__Main__71.NotificationCanvas;
    local function u396(p394) --[[ Line: 1978 ]]
        -- upvalues: l__UIAssets__5 (ref), l__TweenService__3 (ref), l__NotificationCanvas__84 (copy), l__Promise__9 (ref)
        local u395 = l__UIAssets__5.Notification:Clone();
        u395.Main.MainText.Text = p394.main_text;
        u395.Size = UDim2.fromScale(1, 0);
        if p394.has_gradient == false then
            u395.Main.Light.Visible = false;
        end;
        if p394.priority then
            u395.LayoutOrder = -p394.priority;
        end;
        l__TweenService__3:Create(u395, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0.2)
        }):Play();
        task.delay(0.1, function() --[[ Line: 1993 ]]
            -- upvalues: u395 (copy), l__TweenService__3 (ref)
            if u395 and u395.Parent ~= nil then
                u395.Main.Flash.Visible = false;
                l__TweenService__3:Create(u395.Main.Light, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.6
                }):Play();
            end;
        end);
        if p394.color then
            u395.Main.MainText.TextColor3 = Color3.fromRGB(unpack(p394.color));
            u395.Main.Flash.BackgroundColor3 = Color3.fromRGB(unpack(p394.color));
            u395.Main.Light.BackgroundColor3 = Color3.fromRGB(unpack(p394.color));
        end;
        u395.Parent = l__NotificationCanvas__84;
        u395.Main.Credit.Subtext.Text = p394.sub_text;
        l__Promise__9.delay(p394.life_time or 5):andThen(function() --[[ Line: 2008 ]]
            -- upvalues: u395 (copy), l__TweenService__3 (ref)
            if u395 and u395.Parent ~= nil then
                l__TweenService__3:Create(u395.Main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.fromScale(0, -1)
                }):Play();
                l__TweenService__3:Create(u395, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Size = UDim2.fromScale(1, 0)
                }):Play();
                game.Debris:AddItem(u395, 0.5);
            end;
        end);
    end;
    local v398 = l__Packets__7._x471df2faea508528.OnClientEvent:Connect(function(p397) --[[ Line: 2022 ]]
        -- upvalues: u396 (copy)
        u396(p397);
    end);
    local v400 = l__Packets__7._x1b62682bd6f16761.OnClientEvent:Connect(function(p399) --[[ Line: 2026 ]]
        game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):DisplaySystemMessage(p399);
    end);
    u357._x06f6523fee19e54a:Add(v398);
    u357._x06f6523fee19e54a:Add(v400);
    local l__KillstreakVisualizer__85 = l__Main__71.BottomCenter.KillstreakVisualizer;
    local u401 = u4:_xe7f02e22353709c3("killstreak");
    local l__Value__86 = u401.Value;
    local u402 = 0;
    local l___x3019cc5b1f776551__87 = l__Classes__14._x3019cc5b1f776551;
    local function u406() --[[ Line: 2042 ]]
        -- upvalues: l__KillstreakVisualizer__85 (copy), l__TweenService__3 (ref), u2 (ref), u401 (copy)
        local v403 = Color3.fromRGB(255, 30, 30);
        local v404 = l__KillstreakVisualizer__85.CircleFrame:Clone();
        l__KillstreakVisualizer__85.Counter.TextTransparency = 1;
        l__TweenService__3:Create(l__KillstreakVisualizer__85.Counter, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            TextTransparency = 0
        }):Play();
        l__KillstreakVisualizer__85.Elimination.ImageColor3 = v403;
        l__KillstreakVisualizer__85.CircleFrame.UIStroke.Color = v403;
        l__TweenService__3:Create(l__KillstreakVisualizer__85.CircleFrame.UIStroke, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Color = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__KillstreakVisualizer__85.Radial.ImageColor3 = v403;
        l__KillstreakVisualizer__85.Flare.ImageColor3 = v403;
        l__KillstreakVisualizer__85.Glow.ImageColor3 = v403;
        l__TweenService__3:Create(l__KillstreakVisualizer__85.Glow, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__TweenService__3:Create(l__KillstreakVisualizer__85.Flare, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__TweenService__3:Create(l__KillstreakVisualizer__85.Radial, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
        v404.Parent = l__KillstreakVisualizer__85.CircleFrame.Parent;
        v404.UIStroke.Transparency = 0;
        v404.UIStroke.Color = v403;
        v404.UIStroke.Thickness = 7;
        l__KillstreakVisualizer__85.Elimination.ImageTransparency = 0;
        l__KillstreakVisualizer__85.Elimination.Size = UDim2.fromScale(3, 3);
        l__TweenService__3:Create(l__KillstreakVisualizer__85.Elimination, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1.3, 1.3)
        }):Play();
        l__TweenService__3:Create(l__KillstreakVisualizer__85.Elimination, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
        l__TweenService__3:Create(v404.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        local v405 = u2:convNumRange(math.clamp(u401.Value, 0, 15), 0, 20, 2, 6);
        l__TweenService__3:Create(v404, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(v405, v405)
        }):Play();
        l__TweenService__3:Create(v404.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Thickness = 0
        }):Play();
        game.Debris:AddItem(v404, 1);
    end;
    local v408 = u401.Changed:Connect(function(p407) --[[ Line: 2075 ]]
        -- upvalues: l__Value__86 (ref), u406 (copy)
        if l__Value__86 < p407 then
            u406();
        end;
        l__Value__86 = p407;
    end);
    local function u416() --[[ Line: 2082 ]]
        -- upvalues: u401 (copy), u2 (ref), l__TweenService__3 (ref), l___x3019cc5b1f776551__87 (copy), l__KillstreakVisualizer__85 (copy)
        if u401.Value == 0 then
        else
            local v409 = u2:numLerp(1.1, 2, l__TweenService__3:GetValue(l___x3019cc5b1f776551__87._x91b580da79977c96, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
            local v410 = l__KillstreakVisualizer__85.CircleFrame:Clone();
            v410.Parent = l__KillstreakVisualizer__85.CircleFrame.Parent;
            if u401.Value >= 3 then
                local v411 = u2:numLerp(0, 0.02, l__TweenService__3:GetValue(l___x3019cc5b1f776551__87._x91b580da79977c96, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                l__KillstreakVisualizer__85.Size = UDim2.fromScale(0.175 - v411, 0.175 - v411);
                l__TweenService__3:Create(l__KillstreakVisualizer__85, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.175, 0.175)
                }):Play();
            end;
            if u401.Value >= 3 then
                local v412 = u2:numLerp(1, 0, l__TweenService__3:GetValue(l___x3019cc5b1f776551__87._x91b580da79977c96, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
                l__KillstreakVisualizer__85.Glow.ImageTransparency = v412;
                l__TweenService__3:Create(l__KillstreakVisualizer__85.Glow, TweenInfo.new(0.2), {
                    ImageTransparency = 1
                }):Play();
            end;
            if u401.Value >= 5 then
                local v413 = u2:numLerp(1, 0.2, l__TweenService__3:GetValue(l___x3019cc5b1f776551__87._x91b580da79977c96, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                l__KillstreakVisualizer__85.Flare.ImageTransparency = v413;
                local v414 = math.random(0, 360);
                l__KillstreakVisualizer__85.Flare.Rotation = v414;
                local _ = math.random(0, 1) == 0;
                local v415 = 10 * v409;
                l__TweenService__3:Create(l__KillstreakVisualizer__85.Flare, TweenInfo.new(0.2), {
                    ImageTransparency = 1,
                    Rotation = v414 + v415
                }):Play();
            end;
            v410.UIStroke.Transparency = 0.5;
            v410.UIStroke.Thickness = 3;
            l__TweenService__3:Create(v410, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v409, v409)
            }):Play();
            l__TweenService__3:Create(v410.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Thickness = 0
            }):Play();
            l__TweenService__3:Create(v410.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            game.Debris:AddItem(v410, 1);
        end;
    end;
    local v417 = l___x3019cc5b1f776551__87._x1bda6760872f43ee.onBeat:Connect(function() --[[ Line: 2120 ]]
        -- upvalues: u416 (copy)
        u416();
    end);
    local v420 = l__RunService__1.RenderStepped:Connect(function(p418) --[[ Line: 2124 ]]
        -- upvalues: l__KillstreakVisualizer__85 (copy), u401 (copy), l___x3019cc5b1f776551__87 (copy), u402 (ref), u2 (ref), l__TweenService__3 (ref)
        local l__Radial__88 = l__KillstreakVisualizer__85.Radial;
        local l__Value__89 = u401.Value;
        if l__Value__89 > 0 then
            if l___x3019cc5b1f776551__87._xbef5d1d860f06f75 or l___x3019cc5b1f776551__87._xbef5d1d860f06f75[l___x3019cc5b1f776551__87._x7451e0cd1ca4d9e4] then
                local v419 = l__Value__89 % 2 == 0 and -1 or 1;
                u402 = u2:numLerp(0.3, 4, l__TweenService__3:GetValue(l___x3019cc5b1f776551__87._x91b580da79977c96, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
                l__Radial__88.Rotation = l__Radial__88.Rotation + p418 * (u402 * 60) * v419;
                if l__Radial__88.Rotation > 360 then
                    l__Radial__88.Rotation = l__Radial__88.Rotation % 360;
                end;
                if l__Radial__88.Rotation < 0 then
                    l__Radial__88.Rotation = 360 + l__Radial__88.Rotation;
                end;
                l__KillstreakVisualizer__85.Visible = true;
                l__KillstreakVisualizer__85.Counter.Text = tostring(l__Value__89);
            end;
        else
            l__KillstreakVisualizer__85.Visible = false;
        end;
    end);
    u357._x06f6523fee19e54a:Add(v420);
    u357._x06f6523fee19e54a:Add(v417);
    u357._x06f6523fee19e54a:Add(v408);
    local v435 = u4:_x9ccd957f12430c82("onDamageTaken"):Connect(function(u421) --[[ Line: 2162 ]]
        -- upvalues: u2 (ref), u357 (copy), l__UIAssets__5 (ref), l__TweenService__3 (ref), u358 (copy), l__RunService__1 (ref)
        if u421.attacker_identifier and u421.damage > 0 then
            local u422 = u2:getLikelyVec3(u421.attacker_identifier);
            if u422 then
                local v423 = u2:getBoundaryUDimFromPosition(workspace.CurrentCamera.CFrame, u422);
                local u424 = nil;
                if u357._x9750ea86f12297c2 == "Gradient" then
                    u424 = l__UIAssets__5.DamageIndicator:Clone();
                    l__TweenService__3:Create(u424.Gradient, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    l__TweenService__3:Create(u424.Gradient.UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play();
                    l__TweenService__3:Create(u424.Gradient, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1
                    }):Play();
                elseif u357._x9750ea86f12297c2 == "Blob" then
                    u424 = l__UIAssets__5.DamageIndicatorBlob:Clone();
                    l__TweenService__3:Create(u424.Outer, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0, 0.75)
                    }):Play();
                    l__TweenService__3:Create(u424.Outer, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ImageTransparency = 1
                    }):Play();
                    l__TweenService__3:Create(u424.Inner, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0, 0)
                    }):Play();
                    l__TweenService__3:Create(u424.Inner, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ImageTransparency = 1
                    }):Play();
                else
                    warn("UNKNOWN DAMAGE INDICATOR TYPE : ", u357._x9750ea86f12297c2);
                end;
                u424.Position = v423;
                local v425 = UDim2.fromScale(0.5, 0.5);
                local l__ViewportSize__90 = workspace.CurrentCamera.ViewportSize;
                local v426 = math.atan2((v425.Y.Scale - v423.Y.Scale) * l__ViewportSize__90.Y, (v425.X.Scale - v423.X.Scale) * l__ViewportSize__90.X);
                u424.Rotation = math.deg(v426) + 90;
                u424.Parent = u358.DamageFrame;
                local u427 = nil;
                local u428 = false;
                u427 = l__RunService__1.RenderStepped:Connect(function() --[[ Line: 2222 ]]
                    -- upvalues: u421 (copy), u428 (ref), u427 (ref), u424 (ref), u422 (ref), u2 (ref)
                    if u421.attacker_identifier then
                        if u421.attacker_identifier.Parent == workspace.Entities then
                            if u424 then
                                u422 = u2:getLikelyVec3(u421.attacker_identifier);
                                if u422 then
                                    local l__ViewportSize__91 = workspace.CurrentCamera.ViewportSize;
                                    local v429 = l__ViewportSize__91.Y / l__ViewportSize__91.X;
                                    local v430 = u2:getBoundaryUDimFromPosition(workspace.CurrentCamera.CFrame, u422);
                                    local l__Scale__92 = v430.X.Scale;
                                    local v431;
                                    if l__Scale__92 < 0.5 then
                                        v431 = u2:convNumRange(l__Scale__92, 0, 0.5, 1, v429);
                                    else
                                        v431 = u2:convNumRange(l__Scale__92, 0.5, 1, v429, 1);
                                    end;
                                    u424.Size = UDim2.fromScale(0.7 * v431, 0.7 * v431);
                                    u424.Position = v430;
                                    local v432 = u424;
                                    local v433 = UDim2.fromScale(0.5, 0.5);
                                    local l__ViewportSize__93 = workspace.CurrentCamera.ViewportSize;
                                    local v434 = math.atan2((v433.Y.Scale - v430.Y.Scale) * l__ViewportSize__93.Y, (v433.X.Scale - v430.X.Scale) * l__ViewportSize__93.X);
                                    v432.Rotation = math.deg(v434) + 90;
                                elseif u428 then
                                else
                                    u428 = true;
                                    if u427 then
                                        u427:Disconnect();
                                        u427 = nil;
                                    end;
                                    if u424 then
                                        u424:Destroy();
                                    end;
                                end;
                            elseif u428 then
                            else
                                u428 = true;
                                if u427 then
                                    u427:Disconnect();
                                    u427 = nil;
                                end;
                                if u424 then
                                    u424:Destroy();
                                end;
                            end;
                        elseif u428 then
                        else
                            u428 = true;
                            if u427 then
                                u427:Disconnect();
                                u427 = nil;
                            end;
                            if u424 then
                                u424:Destroy();
                            end;
                        end;
                    elseif u428 then
                    else
                        u428 = true;
                        if u427 then
                            u427:Disconnect();
                            u427 = nil;
                        end;
                        if u424 then
                            u424:Destroy();
                        end;
                    end;
                end);
                game.Debris:AddItem(u424, 0.8);
                task.delay(0.8, function() --[[ Line: 2245 ]]
                    -- upvalues: u428 (ref), u427 (ref), u424 (ref)
                    if u428 then
                    else
                        u428 = true;
                        if u427 then
                            u427:Disconnect();
                            u427 = nil;
                        end;
                        if u424 then
                            u424:Destroy();
                        end;
                    end;
                end);
                u357._x06f6523fee19e54a:Add(u424);
                u357._x06f6523fee19e54a:Add(u427);
            end;
        end;
    end);
    u357._x06f6523fee19e54a:Add(v435);
    local u436 = 0;
    local function u445() --[[ Line: 2260 ]]
        -- upvalues: l__Main__71 (copy), u4 (ref), u436 (ref), l__TweenService__3 (ref), u358 (copy), u2 (ref)
        local l__HealthContainer__94 = l__Main__71.BottomCenter.HealthContainer;
        local l__HealthProgress__95 = l__HealthContainer__94.HealthMain.Bar.Max.HealthProgress;
        local l__Value__96 = u4:_xe7f02e22353709c3("health").Value;
        local l__Value__97 = u4:_xe7f02e22353709c3("health_max").Value;
        local v437 = u436 - l__Value__96;
        u436 = l__Value__96;
        local v438 = math.map(l__Value__96, 0, l__Value__97, 0, 1);
        l__HealthProgress__95.Size = UDim2.fromScale(v438, 1);
        l__HealthProgress__95.TextLabel.Text = tostring(l__Value__96);
        local function v439(_) --[[ Line: 2272 ]]
            -- upvalues: l__HealthProgress__95 (copy), l__TweenService__3 (ref)
            l__HealthProgress__95.BackgroundColor3 = Color3.fromRGB(0, 255, 0);
            l__TweenService__3:Create(l__HealthProgress__95, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end;
        local function v442(p440) --[[ Line: 2277 ]]
            -- upvalues: l__HealthContainer__94 (copy), l__Value__97 (copy), l__TweenService__3 (ref), l__HealthProgress__95 (copy)
            local l__DamagedFrame__98 = l__HealthContainer__94.HealthMain.Bar.Max.DamagedFrame;
            local l__GradientFrame__99 = l__DamagedFrame__98.GradientFrame;
            local v441 = math.map(p440, 0, l__Value__97, 0, 1);
            l__DamagedFrame__98.Size = UDim2.fromScale(v441, 1);
            l__GradientFrame__99.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__DamagedFrame__98, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 1)
            }):Play();
            l__TweenService__3:Create(l__GradientFrame__99, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__HealthProgress__95.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            l__TweenService__3:Create(l__HealthProgress__95, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end;
        local l__BotGradient__100 = u358.BotGradient;
        local v443 = Color3.fromRGB(255, 0, 0);
        local v444 = Color3.fromRGB(0, 0, 0):Lerp(v443, l__TweenService__3:GetValue(u2:convNumRange(l__Value__96, l__Value__97 * 0.4, l__Value__97, 1, 0), Enum.EasingStyle.Exponential, Enum.EasingDirection.In));
        l__TweenService__3:Create(l__BotGradient__100, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageColor3 = v444
        }):Play();
        if v437 > 0 then
            v442(v437);
        else
            if v437 < 0 then
                v439(v437);
            end;
        end;
    end;
    u445();
    local v446 = u4:_xe7f02e22353709c3("health").Changed:Connect(function() --[[ Line: 2307 ]]
        -- upvalues: u445 (copy)
        u445();
    end);
    local v448 = l__Classes__14._x3019cc5b1f776551._x1bda6760872f43ee.onBeat:Connect(function() --[[ Line: 2311 ]]
        -- upvalues: u4 (ref), u358 (copy), l__TweenService__3 (ref)
        local l__Value__101 = u4:_xe7f02e22353709c3("health_max").Value;
        local l__Value__102 = u4:_xe7f02e22353709c3("health").Value;
        local v447 = l__Value__101 * 0.4;
        local l__LowHPGradient__103 = u358.LowHPGradient;
        if v447 <= l__Value__102 then
            l__LowHPGradient__103.Visible = false;
        else
            l__LowHPGradient__103.Visible = true;
            l__LowHPGradient__103.Size = UDim2.fromScale(1, 0.5);
            l__LowHPGradient__103.ImageTransparency = 0;
            l__TweenService__3:Create(l__LowHPGradient__103, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 1,
                Size = UDim2.fromScale(1, 0)
            }):Play();
        end;
    end);
    u357._x06f6523fee19e54a:Add(v446);
    u357._x06f6523fee19e54a:Add(v448);
    local l__StaminaContainer__104 = l__Main__71.BottomLeft.StaminaContainer;
    for u449 = 1, l__Classes__14._x150a19552e17c1ce._x391ddf3642715a44 do
        local u450 = l__UIAssets__5.HUDAssets.StaminaGauge:Clone();
        local u451 = false;
        u450.Parent = l__Main__71.BottomLeft.StaminaContainer.StaminaArray;
        local function u452() --[[ Line: 2337 ]]
            -- upvalues: u450 (copy), l__TweenService__3 (ref)
            local l__FillFlash__105 = u450.FillFlash;
            l__FillFlash__105.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__FillFlash__105, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            u450.Fill.BackgroundTransparency = 0;
        end;
        local function u453() --[[ Line: 2345 ]]
            -- upvalues: u450 (copy), l__TweenService__3 (ref), l__StaminaContainer__104 (copy)
            local l__UseFlash__106 = u450.UseFlash;
            l__UseFlash__106.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__UseFlash__106, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            u450.Fill.BackgroundTransparency = 0.5;
            local l__Enders__107 = l__StaminaContainer__104.Enders;
            l__Enders__107.Size = UDim2.fromScale(1.15, 0.1);
            l__TweenService__3:Create(l__Enders__107, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, 0.1)
            }):Play();
        end;
        local v455 = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 2355 ]]
            -- upvalues: u3 (ref), u449 (copy), u450 (copy), u451 (ref), u452 (copy), u453 (copy)
            local l___x432e58342e608916__108 = u3._x432e58342e608916;
            local l___xe20202528e9f738d__109 = u3._xe20202528e9f738d;
            local v454 = math.clamp(l___x432e58342e608916__108 - u449 + 1, 0, 1);
            u450.Fill.Size = UDim2.fromScale(v454, 1);
            if u449 <= l___xe20202528e9f738d__109 then
                if not u451 then
                    u451 = true;
                    u452();
                end;
            else
                if u451 then
                    u451 = false;
                    u453();
                end;
                u450.Fill.BackgroundTransparency = 0.5;
            end;
        end);
        u357._x06f6523fee19e54a:Add(v455);
    end;
    local l__CircularImageFill__110 = l__Main__71.BottomLeft.AugmentContainer.AugmentHolder.CircularImageFill;
    local v459 = l__CircularImageFill__110.Progress.Changed:Connect(function(p456) --[[ Line: 2385 ]]
        -- upvalues: l__Classes__14 (ref), l__Main__71 (copy), l__CircularImageFill__110 (copy)
        local l__KeyCode__111 = l__Classes__14._xf1ad98d2d70b7408:_x93fd21adac562b5e("AUGMENT").KeyCode;
        l__Main__71.BottomLeft.AugmentContainer.AugmentHolder.AugmentKey.KeyText.Text = l__Classes__14._xf1ad98d2d70b7408:_x9afb0bbcc2b58dcd(l__KeyCode__111);
        local v457 = math.map(p456, 0, 1, 0, 360);
        local l__UIGradient__112 = l__CircularImageFill__110.RightClip.Right.UIGradient;
        local l__UIGradient__113 = l__CircularImageFill__110.LeftClip.Left.UIGradient;
        if v457 == 360 then
            l__UIGradient__113.Rotation = 180;
            l__UIGradient__112.Rotation = 180;
        else
            local v458 = math.fmod(v457, 360);
            if v458 < 180 and v458 > -180 then
                l__UIGradient__112.Rotation = v458;
                l__UIGradient__113.Rotation = 0;
            else
                l__UIGradient__112.Rotation = 180;
                l__UIGradient__113.Rotation = v458 - 180;
            end;
        end;
    end);
    u357._x06f6523fee19e54a:Add(v459);
    local l__ImpactHolder__114 = l__Main__71.TopCenter.ImpactHolder;
    local l__ImpactContainer__115 = l__ImpactHolder__114.ImpactContainer;
    local l__ImpactFill__116 = l__ImpactContainer__115.ImpactMain.Bar.Max.ImpactFill;
    local l__ImpactFlash__117 = l__ImpactContainer__115.ImpactMain.Bar.Max.ImpactFlash;
    local u460 = u4:_xe7f02e22353709c3("impact");
    local u461 = u4:_xe7f02e22353709c3("impact_limit");
    local u462 = 0;
    local v464 = l__Packets__7.unreliablePackets._x6e915d67a1f06f56.OnClientEvent:Connect(function(p463) --[[ Line: 2425 ]]
        -- upvalues: l__ImpactContainer__115 (copy), u462 (ref), l__TweenService__3 (ref)
        if not p463 then
            local l__FilledFlash__118 = l__ImpactContainer__115.ImpactStroke.FilledFlash;
            u462 = 0;
            l__FilledFlash__118.BackgroundTransparency = 0;
            l__FilledFlash__118.Size = UDim2.fromScale(1, 4);
            l__TweenService__3:Create(l__FilledFlash__118, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            }):Play();
            l__TweenService__3:Create(l__FilledFlash__118, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 4)
            }):Play();
        end;
    end);
    local v472 = l__RunService__1.RenderStepped:Connect(function() --[[ Line: 2437 ]]
        -- upvalues: u460 (copy), u461 (copy), u4 (ref), l__ImpactHolder__114 (copy), l__ImpactFill__116 (copy), l__ImpactContainer__115 (copy), u2 (ref), l__Promise__9 (ref), u462 (ref), l__ImpactFlash__117 (copy)
        local l__Value__119 = u460.Value;
        local l__Value__120 = u461.Value;
        if u4._x1609eb07758d3751.is_breaking then
            l__ImpactHolder__114.Visible = true;
            local v465 = math.map(u4._x1609eb07758d3751.break_duration, 0, u4._x1609eb07758d3751.initial_duration, 0, 1);
            l__ImpactFill__116.Size = UDim2.fromScale(v465, 1);
            l__ImpactFill__116.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            l__ImpactHolder__114.BreakingSubtext.Visible = true;
            l__ImpactContainer__115.ImpactStroke.UIStroke.Color = Color3.fromRGB(255, 0, 0);
            l__ImpactHolder__114.ImpactText.Text = "!! DISABLED !!";
            l__ImpactFill__116.Parent.ImpactFlash.Visible = false;
        elseif l__Value__119 > 0 then
            l__ImpactHolder__114.ImpactText.Text = "[ INSTABILITY ]";
            l__ImpactFill__116.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            l__ImpactContainer__115.ImpactStroke.UIStroke.Color = Color3.fromRGB(255, 255, 255);
            l__ImpactHolder__114.BreakingSubtext.Visible = false;
            l__ImpactHolder__114.Visible = true;
            l__ImpactFill__116.Parent.ImpactFlash.Visible = true;
            local v466 = math.map(l__Value__119, 0, l__Value__120, 0, 1);
            local u467 = u2:numLerp(l__ImpactFill__116.Size.X.Scale, v466, 0.1);
            l__ImpactFill__116.Size = UDim2.fromScale(u467, 1);
            l__Promise__9.delay(0.07):andThen(function() --[[ Line: 2468 ]]
                -- upvalues: u462 (ref), u467 (copy)
                u462 = u467;
            end);
            l__ImpactFlash__117.Position = UDim2.fromScale(u467, 0.5);
            local v468 = math.abs(u467 - u462);
            local v469;
            if v468 == 0 then
                v469 = 0;
            else
                local v470 = math.sign(v468);
                local v471 = math.abs(v468);
                v469 = v470 * math.max(v471, 0.007);
            end;
            l__ImpactFlash__117.Size = UDim2.fromScale(v469, 7 + math.random(-2, 2));
            l__ImpactFlash__117.BackgroundTransparency = 0.2 + math.random(-0.1, 0.1);
        else
            l__ImpactHolder__114.Visible = false;
            l__ImpactFill__116.Size = UDim2.fromScale(0, 1);
            u462 = 0;
        end;
    end);
    u357._x06f6523fee19e54a:Add(v472);
    u357._x06f6523fee19e54a:Add(v464);
    u358.Parent = u357._x150106ccf5e1fa00;
    if l__Classes__14._x9a86d5566d6a5327 then
        l__Classes__14._x9a86d5566d6a5327:_xad7fa18a5a354dc6();
    end;
end;
function u5._x44bcd6af41218f92(u473) --[[ Line: 2499 ]]
    -- upvalues: u1 (ref), l__Classes__14 (copy), u2 (ref), u3 (ref), u4 (ref), l__RunService__1 (copy)
    task.defer(function() --[[ Line: 2500 ]]
        -- upvalues: u1 (ref), l__Classes__14 (ref), u2 (ref), u3 (ref), u4 (ref), u473 (copy), l__RunService__1 (ref)
        u1 = l__Classes__14._xdca80115d2839102;
        u2 = l__Classes__14.Util;
        u3 = l__Classes__14._x1a4ce4062771e36e;
        u4 = l__Classes__14._x8399b2bb73e12808;
        u473._x150106ccf5e1fa00.Parent = u3._x671856f9c7356970.PlayerGui;
        u473:_xd2e40a17ea9c5d26();
        table.insert(u473._x2c34df6b193a13d0, l__RunService__1.RenderStepped:Connect(function(p474) --[[ Line: 2508 ]]
            -- upvalues: u473 (ref)
            u473:_x3e94c6ef859458ed(p474);
        end));
    end);
end;
return u5;
