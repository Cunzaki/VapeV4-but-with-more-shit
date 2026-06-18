-- Decompiled from: Start.Client.ItemData.Melee._xa7109feafc3a83d4
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

if not LPH_OBFUSCATED then
    function LPH_JIT_MAX(p1)
        return p1;
    end;
    function LPH_NO_VIRTUALIZE(p2)
        return p2;
    end;
end;
local l__Promise__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Easer__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local l__Packets__3 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__Attack__4 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Attack);
local l__Classes__5 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__6 = require(script.Parent.Parent.Parent.InternalSymbols);
local l__RunService__7 = game:GetService("RunService");
local l__TweenService__8 = game:GetService("TweenService");
local u3 = nil;
local l__Instances__9 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local u4 = {};
u4.__index = u4;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = false;
local u16 = false;
local u17 = l__Promise__1.resolve();
local u18 = l__Promise__1.resolve();
local u19 = l__Promise__1.resolve();
local u20 = task.spawn(function() --[[ Line: 49 ]] end);
local u21 = task.spawn(function() --[[ Line: 50 ]] end);
local u22 = task.spawn(function() --[[ Line: 51 ]] end);
local u23 = false;
local u24 = 0;
local u25 = {};
local u26 = CFrame.new();
local u27 = Random.new();
local u39 = LPH_JIT_MAX(function(p28, p29, p30, p31, p32) --[[ Line: 64 ]]
    -- upvalues: u8 (ref)
    local v33 = math.min(p29, p30);
    local v34 = math.max(p29, p30);
    local v35 = math.clamp(p28, v33, v34);
    local v36 = tostring(game.GameId);
    local v37 = 46;
    for v38 = 1, #v36 do
        v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
    end;
    if v37 == 272 and v35 > 0 then
        return u8:numLerp(0, p32, (u8:convNumRange(v35, 0, p30, 0, 1)));
    else
        return u8:numLerp(0, p31, (u8:convNumRange(v35, p29, 0, 1, 0)));
    end;
end);
function u4._x47262089ae496a5d(_) --[[ Line: 76 ]]
    -- upvalues: l__Instances__9 (copy)
    return {
        model = l__Instances__9.Redliner,
        params = {
            model_scale = 0.3
        },
        effects = {
            defaultParry = "defaultParry",
            swoopAttackClient = "swoopAttackClient"
        }
    };
end;
function u4._xafd29f1684593d0b(p40) --[[ Line: 89 ]]
    -- upvalues: l__Classes__5 (copy), u4 (copy), l__Instances__9 (copy)
    local v41 = p40 or l__Classes__5._x48271d11a14d156e:_xfa248435cddccd62(u4, script, "melee", "Redliner");
    local v42 = setmetatable({}, u4);
    v42._x724636a6d678bf05 = "Redliner";
    v42._xe9709f830ad162b1 = v41;
    local v43;
    if v41 then
        v43 = v41.animations;
    else
        v43 = v41;
    end;
    v42._xdc1585eaf9e7c3e9 = v43;
    local v44;
    if v41 then
        v44 = v41.animations_3p;
    else
        v44 = v41;
    end;
    v42._x728d17d147b3a2f1 = v44;
    local v45 = v41 and v41.params;
    if v45 then
        v45 = v41.params.model_scale;
    end;
    v42._xf4562ec9bc065b6c = v45;
    v42._x18197f2fde14fb56 = {};
    v42._xea78a328779fee1f = {};
    v42._x4122b81a127722c4 = false;
    v42._x230b45c416d8b27a = false;
    v42._xc74b9e5f0e92c00d = 0;
    v42._x62c67a48a27d03c8 = CFrame.new();
    v42._xc63a1c80c7a373c6 = {};
    v42._xa5a4ba95ecf755ae = 1;
    v42._xc5e9290a687f7218 = v41 and v41.model or l__Instances__9.Redliner:Clone();
    v42._xd19ea879328dfb90 = v42._xc5e9290a687f7218.AnimationController.Animator;
    v42._x6c396c8cf55960de = false;
    local v46 = Instance.new("Highlight");
    v46.FillTransparency = 1;
    v46.OutlineTransparency = 1;
    v46.DepthMode = Enum.HighlightDepthMode.Occluded;
    v46.FillColor = Color3.fromRGB(255, 255, 255);
    v46.Parent = v42._xc5e9290a687f7218.Weapon;
    v42._x9eea16c4c9bc296b = v46;
    v42._xb47463a00394061f = { v42._xc5e9290a687f7218.Weapon:FindFirstChild("NeonPart1", true) };
    v42._xf9da6da55ad9a7f7 = CFrame.new();
    v42._xd303afaf7f9f54ab = CFrame.new();
    v42._x15deb9c4f7cc7ce0 = CFrame.new();
    v42._x4f00ff8f356153eb = CFrame.new();
    v42._x83b7504b63c5edaf = CFrame.new();
    v42._xd5556aac29905657 = CFrame.new();
    v42._x29a8818312286ff1 = CFrame.new();
    v42._xbd9ab775e248f5bf = 0;
    v42._xc48ce68aecf16e26 = 0;
    v42._xc76870e83b3fa813 = 0;
    v42._x07fda085616a5057 = "reset";
    v42._x97b6d586cc0555a5 = false;
    v42._x1ab263b36f6a1ab8 = nil;
    v42._x9010d48a62f4ef13 = nil;
    v42._x849da4e8af7c2b7c = false;
    v42._x4152d51f2de863b7 = false;
    v42._x081489d45a4b404e = 0;
    v42._xc53ca76fe39943ad = {
        EQUIP_TIME = 0.5,
        ATTACK_TIMEOUT = 0.65,
        CHARGE_ATTACK_TIME = 0.5,
        CHARGE_ATTACK_COST = 2
    };
    v42._x16b4e70c92861953 = table.freeze({
        MODEL_SCALE = 0.3,
        BASE_OFFSET = CFrame.new(0, 0, -0.05),
        BASE_OFFSET_ATTACKING = CFrame.new(0, 0.03, -0.05),
        BASE_ROTATION = CFrame.Angles(0, 0, 0.03),
        WALLRIDE_MAX_FORWARD_ANGLE = 90,
        WALLRIDE_MAX_BACKWARD_ANGLE = 50,
        WALLRIDE_ARM_TURN_POINT = 0,
        WALLRIDE_MAX_PITCH = 0.026179938779914945,
        WALLRIDE_MIN_PITCH = -0.026179938779914945,
        WALLRIDE_Y_UPPER_BOUND = 50,
        WALLRIDE_Y_LOWER_BOUND = -50,
        SWAY_AMOUNT = 0.5,
        VEL_FORWARD_OFFSET = -0.015,
        VEL_BACKWARD_OFFSET = 0.04,
        VEL_Z_UPPER_BOUND = 200,
        VEL_Z_LOWER_BOUND = -100,
        VEL_LEFT_OFFSET = -0.05,
        VEL_RIGHT_OFFSET = 0.08,
        VEL_X_UPPER_BOUND = 140,
        VEL_X_LOWER_BOUND = -140,
        VEL_UP_OFFSET = 0.05,
        VEL_DOWN_OFFSET = -0.07,
        VEL_Y_UPPER_BOUND = 100,
        VEL_Y_LOWER_BOUND = -100,
        VEL_ROLL_UPPER_BOUND = 40,
        VEL_ROLL_LOWER_BOUND = -40,
        VEL_YAW_UPPER_BOUND = 50,
        VEL_YAW_LOWER_BOUND = -50,
        VEL_FORWARD_YAW = 0.15,
        VEL_BACKWARD_YAW = -0.15,
        VEL_UP_ROLL = -0.07,
        VEL_DOWN_ROLL = 0.07,
        STRAFE_SWEET_SPOT = 2,
        STRAFE_DEADZONE = 3,
        STRAFE_ROTATION = 0.1,
        SLIDE_UPPER_BOUND = 100,
        SLIDE_LOWER_BOUND = 0,
        SLIDE_MAX_ANIM_SPEED = 1,
        SLIDE_MIN_ANIM_SPEED = 0,
        SLIDESHAKE_MIN = 0,
        SLIDESHAKE_MAX = 0.7
    });
    return v42;
end;
function u4._x7e13c4109cbdc910(p47, p48, p49, p50) --[[ Line: 222 ]]
    -- upvalues: l__Classes__5 (copy), u14 (ref)
    return l__Classes__5._x48271d11a14d156e:_x60567ffb440fc88e(p47._xe9709f830ad162b1, u14, p48, p49, p50);
end;
function u4._x4afabe947422b922(p51, p52, ...) --[[ Line: 226 ]]
    -- upvalues: l__Classes__5 (copy)
    return l__Classes__5._x48271d11a14d156e:_xbc713bc0a6db24ba(p51._xe9709f830ad162b1, p52, ...);
end;
function u4._xdcc39f9041f87f71(p53) --[[ Line: 230 ]]
    return (p53._xc5e9290a687f7218.Weapon.Handle.From.WorldPosition - p53._xc5e9290a687f7218.Weapon.Handle.To.WorldPosition).Unit;
end;
function u4._xfb1f81c23a7008b1(p54) --[[ Line: 237 ]]
    p54:_x05ef013203e1616c();
    p54._x230b45c416d8b27a = true;
    p54._xc74b9e5f0e92c00d = p54._xc74b9e5f0e92c00d + 1;
    local l___xc74b9e5f0e92c00d__10 = p54._xc74b9e5f0e92c00d;
    p54:_xc34aedc02807d47a(l___xc74b9e5f0e92c00d__10);
    p54:_x3fb28fbda32a9e10(l___xc74b9e5f0e92c00d__10);
end;
function u4._xc34aedc02807d47a(u55, u56) --[[ Line: 246 ]]
    -- upvalues: u26 (copy), l__Promise__1 (copy), l__Classes__5 (copy), l__RunService__7 (copy), u13 (ref), u10 (ref), u12 (ref), u6 (ref), u8 (ref), u27 (copy), u9 (ref), u11 (ref), u7 (ref), u39 (copy)
    local u57 = u26;
    local u58 = 0;
    u55:_x7bd29c4ad85ca826(false);
    l__Promise__1.defer(function() --[[ Line: 251 ]]
        -- upvalues: u55 (copy), u56 (copy), l__Classes__5 (ref)
        local v59 = tostring(game.GameId);
        local v60 = 46;
        for v61 = 1, #v59 do
            v60 = (v60 * 33 + string.byte(v59, v61)) % 65521;
        end;
        if v60 == 272 and not u55:_xc82a8a7392439247(u56) then
        else
            u55._xc5e9290a687f7218.Parent = workspace.CurrentCamera;
            u55:_x7bd29c4ad85ca826(true);
            u55:_x6c278a11b5cfb1e7(0);
            l__Classes__5._xcbdbdbb89e869bdc:_xb1cadc94713d0542();
            u55:_xd6a3771448d19d38(l__Classes__5._xcbdbdbb89e869bdc:_x0d5409f391267aa9());
        end;
    end);
    table.insert(u55._x18197f2fde14fb56, l__RunService__7.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(p62) --[[ Line: 263 ]]
        -- upvalues: u55 (copy), u13 (ref), u10 (ref), u12 (ref), u6 (ref), u8 (ref), u27 (ref), u9 (ref), u26 (ref), u11 (ref), u7 (ref), u57 (ref), u39 (ref), u58 (ref), l__Classes__5 (ref)
        local v63 = tostring(game.GameId);
        local v64 = 46;
        for v65 = 1, #v63 do
            v64 = (v64 * 33 + string.byte(v63, v65)) % 65521;
        end;
        if v64 == 272 and u55.velocity ~= u55.velocity then
        else
            local v66 = tostring(game.GameId);
            local v67 = 46;
            for v68 = 1, #v66 do
                v67 = (v67 * 33 + string.byte(v66, v68)) % 65521;
            end;
            if v67 == 272 and u13.SlideLoop then
                local l__Magnitude__11 = u10._xed86f944048d8fdc.Magnitude;
                local v69 = tostring(game.GameId);
                local v70 = 46;
                for v71 = 1, #v69 do
                    v70 = (v70 * 33 + string.byte(v69, v71)) % 65521;
                end;
                if v70 == 272 and (u12._x3d199abdbf08457d and u10._x0143b9fae93717ec) then
                    local v72 = math.clamp(l__Magnitude__11, u6.SLIDE_LOWER_BOUND, u6.SLIDE_UPPER_BOUND);
                    local v73 = u8:convNumRange(v72, u6.SLIDE_LOWER_BOUND, u6.SLIDE_UPPER_BOUND, u6.SLIDE_MIN_ANIM_SPEED, u6.SLIDE_MAX_ANIM_SPEED);
                    local v74 = u8:convNumRange(v72, u6.SLIDE_LOWER_BOUND, u6.SLIDE_UPPER_BOUND, u6.SLIDESHAKE_MIN, u6.SLIDESHAKE_MAX);
                    local v75 = u27:NextNumber(-v74, v74);
                    u13.SlideLoop:AdjustSpeed(u8:easeInCubic(v73));
                    u55._xd5556aac29905657 = u55._xd5556aac29905657:Lerp(u9:_x00e2b733e2399c9e(v75, 0.01, 0.03, 0.003), 0.5);
                else
                    u13.SlideLoop:AdjustSpeed(0);
                    u55._xd5556aac29905657 = u55._xd5556aac29905657:Lerp(u26, 0.5);
                end;
            end;
            u55._xa5a4ba95ecf755ae = math.clamp(u55._xa5a4ba95ecf755ae + p62 * 0.08, 0.85, 1);
            local l___x46060bfdbc6f3740__12 = u11._x46060bfdbc6f3740;
            if l___x46060bfdbc6f3740__12 then
                l___x46060bfdbc6f3740__12 = u11._x6f3d94d0e996e7bb;
            end;
            local l__Walldrop__13 = u13.Walldrop;
            local v76 = tostring(game.GameId);
            local v77 = 46;
            for v78 = 1, #v76 do
                v77 = (v77 * 33 + string.byte(v76, v78)) % 65521;
            end;
            if v77 == 272 and (l___x46060bfdbc6f3740__12 and (u11._x5e1e7d26ab50a0b3 and not l__Walldrop__13.IsPlaying)) then
                l__Walldrop__13:Play(0, 1, 1);
            else
                local v79 = tostring(game.GameId);
                local v80 = 46;
                for v81 = 1, #v79 do
                    v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
                end;
                if v80 == 272 and (l___x46060bfdbc6f3740__12 and (l__Walldrop__13.IsPlaying and (not u11._x5e1e7d26ab50a0b3 or u11._x67acd0e60109d750))) then
                    l__Walldrop__13:Stop();
                end;
            end;
            local l___x3d199abdbf08457d__14 = u12._x3d199abdbf08457d;
            if l___x3d199abdbf08457d__14 then
                if u12._x7844df488f492f86 > u7.CHARGE_ATTACK_TIME and os.clock() - u55._x081489d45a4b404e > u7.CHARGE_ATTACK_TIME then
                    l___x3d199abdbf08457d__14 = u10._x1ba439069c6b2196 > u7.CHARGE_ATTACK_COST;
                else
                    l___x3d199abdbf08457d__14 = false;
                end;
            end;
            local v82 = tostring(game.GameId);
            local v83 = 46;
            for v84 = 1, #v82 do
                v83 = (v83 * 33 + string.byte(v82, v84)) % 65521;
            end;
            if v83 == 272 and l___x3d199abdbf08457d__14 then
                local v85 = tostring(game.GameId);
                local v86 = 46;
                for v87 = 1, #v85 do
                    v86 = (v86 * 33 + string.byte(v85, v87)) % 65521;
                end;
                if v86 == 272 and not u55._x4152d51f2de863b7 then
                    u55._x4152d51f2de863b7 = true;
                    u55:_x7e13c4109cbdc910("READIED", true);
                    u55:_x7e13c4109cbdc910("CUE2", true);
                    u55._x9eea16c4c9bc296b.FillTransparency = 0.7;
                end;
            else
                u55._x4152d51f2de863b7 = false;
                u55._x9eea16c4c9bc296b.FillTransparency = 1;
            end;
            local l__CFrame__15 = workspace.CurrentCamera.CFrame;
            local v88, v89 = l__CFrame__15:ToObjectSpace(u57):ToOrientation();
            local v90 = l__CFrame__15:VectorToObjectSpace(u10._xed86f944048d8fdc);
            local v91 = math.clamp(-v90.X, u6.VEL_X_LOWER_BOUND, u6.VEL_X_UPPER_BOUND);
            local v92 = math.clamp(-v90.Y, u6.VEL_Y_LOWER_BOUND, u6.VEL_Y_UPPER_BOUND);
            local v93 = math.clamp(-v90.Z, u6.VEL_Z_LOWER_BOUND, u6.VEL_Z_UPPER_BOUND);
            local v94 = u39(v91, u6.VEL_X_LOWER_BOUND, u6.VEL_X_UPPER_BOUND, u6.VEL_LEFT_OFFSET, u6.VEL_RIGHT_OFFSET);
            local v95 = u39(v92, u6.VEL_Y_LOWER_BOUND, u6.VEL_Y_UPPER_BOUND, u6.VEL_DOWN_OFFSET, u6.VEL_UP_OFFSET);
            local v96 = u39(v93, u6.VEL_Z_LOWER_BOUND, u6.VEL_Z_UPPER_BOUND, u6.VEL_FORWARD_OFFSET, u6.VEL_BACKWARD_OFFSET);
            u57 = l__CFrame__15;
            u55._xd303afaf7f9f54ab = u55._xd303afaf7f9f54ab:Lerp(CFrame.Angles(math.sin(v88) * u6.SWAY_AMOUNT, math.sin(v89) * u6.SWAY_AMOUNT, 0), 0.15);
            u55._x15deb9c4f7cc7ce0 = u55._x15deb9c4f7cc7ce0:Lerp(CFrame.new(v94, v95, v96), 0.15);
            local _, v97 = l__CFrame__15:ToOrientation();
            local v98 = math.deg((v97 - u58 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793);
            local v99 = (u10._x8ac9fccbafd948a7 - v98 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
            local v100 = math.abs(v99);
            local l__STRAFE_SWEET_SPOT__16 = u6.STRAFE_SWEET_SPOT;
            local l__STRAFE_DEADZONE__17 = u6.STRAFE_DEADZONE;
            local v101 = 0;
            u58 = v97;
            local v102 = tostring(game.GameId);
            local v103 = 46;
            for v104 = 1, #v102 do
                v103 = (v103 * 33 + string.byte(v102, v104)) % 65521;
            end;
            if v103 == 272 and l__STRAFE_DEADZONE__17 ~= l__STRAFE_SWEET_SPOT__16 then
                local v105 = tostring(game.GameId);
                local v106 = 46;
                for v107 = 1, #v105 do
                    v106 = (v106 * 33 + string.byte(v105, v107)) % 65521;
                end;
                if v106 == 272 and v100 <= l__STRAFE_SWEET_SPOT__16 then
                    v101 = u6.STRAFE_ROTATION;
                else
                    local v108 = tostring(game.GameId);
                    local v109 = 46;
                    for v110 = 1, #v108 do
                        v109 = (v109 * 33 + string.byte(v108, v110)) % 65521;
                    end;
                    if v109 == 272 and v100 < l__STRAFE_DEADZONE__17 then
                        local v111 = (v100 - l__STRAFE_SWEET_SPOT__16) / (l__STRAFE_DEADZONE__17 - l__STRAFE_SWEET_SPOT__16);
                        v101 = u6.STRAFE_ROTATION * (v99 > 0 and 1 - v111 * v111 or 1 - v111);
                    end;
                end;
            end;
            local l__Held__18 = l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("RIGHT").Held;
            local l__Held__19 = l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEFT").Held;
            u55._x83b7504b63c5edaf = u55._x83b7504b63c5edaf:Lerp(CFrame.Angles(0, 0, (l___x46060bfdbc6f3740__12 or l__Held__18 and l__Held__19) and 0 or (l__Held__18 and (not u10._x47c398d88c08e62a and v100 > 0.3) and -v101 or ((not l__Held__19 or (u10._x47c398d88c08e62a or (v100 <= 0.3 or not v101))) and 0 or v101))), 0.06);
            local v112 = tostring(game.GameId);
            local v113 = 46;
            for v114 = 1, #v112 do
                v113 = (v113 * 33 + string.byte(v112, v114)) % 65521;
            end;
            if v113 == 272 and (not l___x46060bfdbc6f3740__12 or (u55._x97b6d586cc0555a5 or u55._x849da4e8af7c2b7c)) then
                u55._xf9da6da55ad9a7f7 = u55._xf9da6da55ad9a7f7:Lerp(u26, 6 * p62);
            else
                local v115, v116 = u9:_x734a46f84d48f11b("right");
                local v117 = tostring(game.GameId);
                local v118 = 46;
                for v119 = 1, #v117 do
                    v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
                end;
                local v120 = v118 == 272 and v115 ~= v115 and 0 or v115;
                local v121 = math.clamp(u10._xed86f944048d8fdc.Y, u6.WALLRIDE_Y_LOWER_BOUND, u6.WALLRIDE_Y_UPPER_BOUND);
                local v122 = u6.WALLRIDE_Y_UPPER_BOUND - u6.WALLRIDE_Y_LOWER_BOUND;
                local v123 = v122 == 0 and u6.WALLRIDE_MIN_PITCH or (v121 - u6.WALLRIDE_Y_LOWER_BOUND) / v122 * (u6.WALLRIDE_MAX_PITCH - u6.WALLRIDE_MIN_PITCH) + u6.WALLRIDE_MIN_PITCH;
                local v124 = CFrame.Angles(v123, 0, v123);
                local v125 = tostring(game.GameId);
                local v126 = 46;
                for v127 = 1, #v125 do
                    v126 = (v126 * 33 + string.byte(v125, v127)) % 65521;
                end;
                local v128;
                if v126 == 272 and v116.Y < u6.WALLRIDE_ARM_TURN_POINT then
                    local v129 = math.clamp(v120, 0, u6.WALLRIDE_MAX_FORWARD_ANGLE);
                    v128 = -math.rad(v129);
                else
                    local v130 = math.clamp(v120, 0, u6.WALLRIDE_MAX_BACKWARD_ANGLE);
                    v128 = math.rad(v130);
                end;
                u55._xf9da6da55ad9a7f7 = u55._xf9da6da55ad9a7f7:Lerp(CFrame.Angles(0, v128, 0), 0.15) * v124;
            end;
        end;
    end)));
    u8:bindRenderStepToTable(u55._x18197f2fde14fb56, l__Classes__5._x2b1f81c73714b323._x1550222c87a9e915 + 1, "redliner_viewmodel", LPH_NO_VIRTUALIZE(function() --[[ Line: 368 ]]
        -- upvalues: u9 (ref), u55 (copy), u6 (ref)
        u9:_x2ccb90caca713ad9(u55._xc5e9290a687f7218);
        local v131 = tostring(game.GameId);
        local v132 = 46;
        for v133 = 1, #v131 do
            v132 = (v132 * 33 + string.byte(v131, v133)) % 65521;
        end;
        local v134;
        if v132 == 272 and u55._x97b6d586cc0555a5 then
            v134 = u6.BASE_OFFSET_ATTACKING;
        else
            v134 = u6.BASE_OFFSET;
        end;
        u55._xc5e9290a687f7218:PivotTo(workspace.CurrentCamera.CFrame * v134 * u6.BASE_ROTATION * u55._xf9da6da55ad9a7f7 * u55._xd303afaf7f9f54ab * u55._x15deb9c4f7cc7ce0 * u55._x83b7504b63c5edaf * u55._xd5556aac29905657 * u55._x29a8818312286ff1);
    end));
end;
function u4._xc82a8a7392439247(p135, p136) --[[ Line: 383 ]]
    local l___x230b45c416d8b27a__20 = p135._x230b45c416d8b27a;
    if l___x230b45c416d8b27a__20 then
        l___x230b45c416d8b27a__20 = p135._xc74b9e5f0e92c00d == p136;
    end;
    return l___x230b45c416d8b27a__20;
end;
function u4._x6c278a11b5cfb1e7(_, p137) --[[ Line: 387 ]]
    -- upvalues: u13 (ref)
    local l__Idle__21 = u13.Idle;
    local v138 = tostring(game.GameId);
    local v139 = 46;
    for v140 = 1, #v138 do
        v139 = (v139 * 33 + string.byte(v138, v140)) % 65521;
    end;
    if v139 == 272 and not l__Idle__21 then
    else
        local v141 = tostring(game.GameId);
        local v142 = 46;
        for v143 = 1, #v141 do
            v142 = (v142 * 33 + string.byte(v141, v143)) % 65521;
        end;
        if v142 == 272 and l__Idle__21.IsPlaying then
            l__Idle__21:AdjustSpeed(1);
            l__Idle__21:AdjustWeight(1, p137 or 0);
        else
            l__Idle__21:Play(p137 or 0, 1, 1);
        end;
    end;
end;
function u4._x3230677c9d06df19(p144, p145, p146, p147) --[[ Line: 398 ]]
    -- upvalues: u13 (ref)
    local v148 = p144._xd19ea879328dfb90:GetPlayingAnimationTracks();
    local v149 = {
        u13.Idle,
        u13.Recovery,
        u13.Attack1,
        u13.Attack2,
        u13.SlideAttack,
        u13.SlideEnd,
        u13.WallrideLoop,
        u13.Parry,
        u13.ParrySuccess
    };
    local v150 = tostring(game.GameId);
    local v151 = 46;
    for v152 = 1, #v150 do
        v151 = (v151 * 33 + string.byte(v150, v152)) % 65521;
    end;
    if v151 == 272 and p147 then
        table.move(p147, 1, #p147, #v149 + 1, v149);
    end;
    local v153 = tostring(game.GameId);
    local v154 = 46;
    for v155 = 1, #v153 do
        v154 = (v154 * 33 + string.byte(v153, v155)) % 65521;
    end;
    if v154 == 272 and v148 then
        for _, v156 in v148 do
            local v157 = tostring(game.GameId);
            local v158 = 46;
            for v159 = 1, #v157 do
                v158 = (v158 * 33 + string.byte(v157, v159)) % 65521;
            end;
            if v158 ~= 272 or v156 ~= p145 then
                local v160 = tostring(game.GameId);
                local v161 = 46;
                for v162 = 1, #v160 do
                    v161 = (v161 * 33 + string.byte(v160, v162)) % 65521;
                end;
                if v161 ~= 272 or not table.find(v149, v156) then
                    v156:AdjustWeight(0, p146);
                end;
            end;
        end;
    end;
    local v163 = tostring(game.GameId);
    local v164 = 46;
    for v165 = 1, #v163 do
        v164 = (v164 * 33 + string.byte(v163, v165)) % 65521;
    end;
    if v164 == 272 and table.find(v148, p145) then
        p145:AdjustWeight(1, p146);
    else
        p145:Play(p146, 1);
    end;
end;
function u4._xd6a3771448d19d38(p166, p167) --[[ Line: 419 ]]
    -- upvalues: u13 (ref), u11 (ref), l__Classes__5 (copy), l__Promise__1 (copy)
    local v168 = tostring(game.GameId);
    local v169 = 46;
    for v170 = 1, #v168 do
        v169 = (v169 * 33 + string.byte(v168, v170)) % 65521;
    end;
    if v169 == 272 and not u13.SlideLoop then
    else
        local l__main__22 = p167.main;
        local l__previous__23 = p167.previous;
        local l__context__24 = p167.context;
        local l__previous_context__25 = p167.previous_context;
        local l__corresponding_played__26 = p167.corresponding_played;
        local v171 = tostring(game.GameId);
        local v172 = 46;
        for v173 = 1, #v171 do
            v172 = (v172 * 33 + string.byte(v171, v173)) % 65521;
        end;
        if v172 == 272 and not u11._x46060bfdbc6f3740 then
            u13.WallrideLoop:AdjustWeight(0.001);
        end;
        local v174 = tostring(game.GameId);
        local v175 = 46;
        for v176 = 1, #v174 do
            v175 = (v175 * 33 + string.byte(v174, v176)) % 65521;
        end;
        if v175 == 272 and l__main__22 == "sliding" then
            local v177 = tostring(game.GameId);
            local v178 = 46;
            for v179 = 1, #v177 do
                v178 = (v178 * 33 + string.byte(v177, v179)) % 65521;
            end;
            if v178 == 272 and not (l__corresponding_played__26 or p166._x97b6d586cc0555a5) then
                local v180 = tostring(game.GameId);
                local v181 = 46;
                for v182 = 1, #v180 do
                    v181 = (v181 * 33 + string.byte(v180, v182)) % 65521;
                end;
                if v181 == 272 and os.clock() - p167.timestamp < 0.1 then
                    p166:_x3230677c9d06df19(u13.SlideStart, 0.1);
                    l__Classes__5._xcbdbdbb89e869bdc:_xd460d84d01269e4b();
                end;
            end;
            p166:_x3230677c9d06df19(u13.SlideLoop, 0.1, { u13.SlideStart, u13.SlideRecovery });
        else
            local v183 = tostring(game.GameId);
            local v184 = 46;
            for v185 = 1, #v183 do
                v184 = (v184 * 33 + string.byte(v183, v185)) % 65521;
            end;
            if v184 == 272 and l__main__22 == "wallriding" then
                local v186 = tostring(game.GameId);
                local v187 = 46;
                for v188 = 1, #v186 do
                    v187 = (v187 * 33 + string.byte(v186, v188)) % 65521;
                end;
                if v187 == 272 and l__context__24 == "right" then
                    local v189 = tostring(game.GameId);
                    local v190 = 46;
                    for v191 = 1, #v189 do
                        v190 = (v190 * 33 + string.byte(v189, v191)) % 65521;
                    end;
                    if v190 == 272 and u13.SlideEnd.IsPlaying then
                        u13.SlideEnd:Stop();
                    end;
                    p166:_x3230677c9d06df19(u13.WallrideLoop, 0.1);
                else
                    p166:_x3230677c9d06df19(u13.Idle, 0.15);
                end;
            else
                local v192 = tostring(game.GameId);
                local v193 = 46;
                for v194 = 1, #v192 do
                    v193 = (v193 * 33 + string.byte(v192, v194)) % 65521;
                end;
                if v193 == 272 and l__main__22 == "running" then
                    local v195 = tostring(game.GameId);
                    local v196 = 46;
                    for v197 = 1, #v195 do
                        v196 = (v196 * 33 + string.byte(v195, v197)) % 65521;
                    end;
                    if v196 == 272 and l__previous__23 == "idle" then
                        p166:_x3230677c9d06df19(u13.Run, 0.3);
                    else
                        p166:_x3230677c9d06df19(u13.Run, 0.15);
                    end;
                else
                    local v198 = tostring(game.GameId);
                    local v199 = 46;
                    for v200 = 1, #v198 do
                        v199 = (v199 * 33 + string.byte(v198, v200)) % 65521;
                    end;
                    if v199 == 272 and l__main__22 == "idle" then
                        local v201 = tostring(game.GameId);
                        local v202 = 46;
                        for v203 = 1, #v201 do
                            v202 = (v202 * 33 + string.byte(v201, v203)) % 65521;
                        end;
                        if v202 == 272 and l__previous__23 == "running" then
                            p166:_x3230677c9d06df19(u13.Idle, 0.2);
                        else
                            u13.Idle:AdjustWeight(1);
                            p166:_x3230677c9d06df19(u13.Idle, 0.2, { u13.Walldrop });
                        end;
                    else
                        local v204 = tostring(game.GameId);
                        local v205 = 46;
                        for v206 = 1, #v204 do
                            v205 = (v205 * 33 + string.byte(v204, v206)) % 65521;
                        end;
                        if v205 == 272 and l__main__22 == "falling" then
                            local v207 = tostring(game.GameId);
                            local v208 = 46;
                            for v209 = 1, #v207 do
                                v208 = (v208 * 33 + string.byte(v207, v209)) % 65521;
                            end;
                            if v208 == 272 and l__context__24 == "wallkick_right" then
                                p166:_x3230677c9d06df19(u13.Wallkick, 0.03);
                                p166:_x3230677c9d06df19(u13.Idle, 0.1, { u13.Wallkick });
                                l__Promise__1.defer(function() --[[ Line: 471 ]]
                                    -- upvalues: l__Classes__5 (ref)
                                    l__Classes__5._xcbdbdbb89e869bdc:_xfad26b6cfc108682();
                                end);
                            else
                                local v210 = tostring(game.GameId);
                                local v211 = 46;
                                for v212 = 1, #v210 do
                                    v211 = (v211 * 33 + string.byte(v210, v212)) % 65521;
                                end;
                                if v211 == 272 and (l__previous__23 == "wallriding" and l__previous_context__25 == "right") then
                                    u13.Idle:AdjustWeight(0.01);
                                    p166:_x3230677c9d06df19(u13.Idle, 0.1, { u13.Walldrop });
                                else
                                    u13.Idle:AdjustWeight(0.01);
                                    p166:_x3230677c9d06df19(u13.Idle, 0.1, { u13.Walldrop });
                                end;
                            end;
                        else
                            local v213 = tostring(game.GameId);
                            local v214 = 46;
                            for v215 = 1, #v213 do
                                v214 = (v214 * 33 + string.byte(v213, v215)) % 65521;
                            end;
                            if v214 == 272 and l__main__22 == "dashing" then
                                local v216 = tostring(game.GameId);
                                local v217 = 46;
                                for v218 = 1, #v216 do
                                    v217 = (v217 * 33 + string.byte(v216, v218)) % 65521;
                                end;
                                if v217 == 272 and l__context__24 == "lunge_right" then
                                    p166:_x3230677c9d06df19(u13.Wallkick, 0.03);
                                    p166:_x3230677c9d06df19(u13.Idle, 0.1, { u13.Wallkick });
                                    l__Promise__1.defer(function() --[[ Line: 488 ]]
                                        -- upvalues: l__Classes__5 (ref)
                                        l__Classes__5._xcbdbdbb89e869bdc:_xfad26b6cfc108682();
                                    end);
                                else
                                    p166:_x3230677c9d06df19(u13.Idle, 0.15);
                                end;
                            else
                                p166:_x3230677c9d06df19(u13.Idle, 0.1);
                            end;
                        end;
                    end;
                end;
            end;
        end;
        local v219 = tostring(game.GameId);
        local v220 = 46;
        for v221 = 1, #v219 do
            v220 = (v220 * 33 + string.byte(v219, v221)) % 65521;
        end;
        if v220 == 272 and l__previous__23 == "sliding" then
            u13.SlideEnd:Play(0.1);
            l__Classes__5._xcbdbdbb89e869bdc:_x5e60ff1516bf3174();
        end;
    end;
end;
function u4._x61eea08bc8b8232e(p222) --[[ Line: 505 ]]
    -- upvalues: u16 (ref), u15 (ref), u10 (ref), l__Classes__5 (copy)
    local v223 = not (u16 or u15) and (u10._x539c98577c3cf168 and not l__Classes__5._x596eb619070480ba._x730775c5207957d3.is_breaking);
    if v223 then
        v223 = not p222._x6c396c8cf55960de;
    end;
    return v223;
end;
function u4._x74fbc6314d850992(u224) --[[ Line: 509 ]]
    -- upvalues: l__Classes__5 (copy), u10 (ref), l__TweenService__8 (copy), l__Packets__3 (copy), u3 (ref), u17 (ref), l__Promise__1 (copy), u13 (ref), u24 (ref), u25 (copy), u16 (ref), u15 (ref), u21 (ref), l__Easer__2 (copy), u18 (ref)
    local v225 = tostring(game.GameId);
    local v226 = 46;
    for v227 = 1, #v225 do
        v226 = (v226 * 33 + string.byte(v225, v227)) % 65521;
    end;
    if v226 == 272 and not u224:_x61eea08bc8b8232e() then
        return false;
    end;
    local function u256() --[[ Line: 511 ]]
        -- upvalues: l__Classes__5 (ref), u10 (ref), l__TweenService__8 (ref), l__Packets__3 (ref), u3 (ref), u224 (copy)
        local function v254() --[[ Line: 512 ]]
            -- upvalues: l__Classes__5 (ref), u10 (ref), l__TweenService__8 (ref)
            local _ = l__Classes__5._x596eb619070480ba;
            local v228 = nil;
            local v229 = {};
            for v230, v231 in l__Classes__5._x3103fdab012bc1c0._x065c7e61fbbee31e do
                local v232 = tostring(game.GameId);
                local v233 = 46;
                for v234 = 1, #v232 do
                    v233 = (v233 * 33 + string.byte(v232, v234)) % 65521;
                end;
                if v233 ~= 272 or v231.indicator_type == "surefire_bullet" then
                    local l__parry_range__27 = v231.parry_range;
                    local v235 = u10._x539c98577c3cf168:FindFirstChild("Head") and u10._x539c98577c3cf168.Head.Position or u10._x539c98577c3cf168.PrimaryPart.Position;
                    local v236 = v230:FindFirstChild("Head") and v230.Head.Position or (v230.PrimaryPart and v230.PrimaryPart.Position or v230:GetPivot().Position);
                    local v237 = 1 - (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit:Dot(((v236 - v235) * Vector3.new(1, 0, 1)).Unit);
                    local v238 = math.abs(v237) <= l__parry_range__27;
                    local v239 = tostring(game.GameId);
                    local v240 = 46;
                    for v241 = 1, #v239 do
                        v240 = (v240 * 33 + string.byte(v239, v241)) % 65521;
                    end;
                    if v240 == 272 and v238 then
                        v229[v230] = true;
                        local v242 = tostring(game.GameId);
                        local v243 = 46;
                        for v244 = 1, #v242 do
                            v243 = (v243 * 33 + string.byte(v242, v244)) % 65521;
                        end;
                        if v243 == 272 and not v228 then
                            v228 = v231;
                        else
                            local v245 = tostring(game.GameId);
                            local v246 = 46;
                            for v247 = 1, #v245 do
                                v246 = (v246 * 33 + string.byte(v245, v247)) % 65521;
                            end;
                            if v246 == 272 and v231.expected_shot_time < v228.expected_shot_time then
                                v228 = v231;
                            end;
                        end;
                    end;
                end;
            end;
            local v248 = tostring(game.GameId);
            local v249 = 46;
            for v250 = 1, #v248 do
                v249 = (v249 * 33 + string.byte(v248, v250)) % 65521;
            end;
            if v249 == 272 and v228 then
                local l__indicator_ui__28 = v228.indicator_ui;
                local l__RightSuccess__29 = l__indicator_ui__28.ParryRange.RightClip.RightSuccess;
                local l__LeftSuccess__30 = l__indicator_ui__28.ParryRange.LeftClip.LeftSuccess;
                l__RightSuccess__29.ImageTransparency = 0;
                l__LeftSuccess__30.ImageTransparency = 0;
                local v251 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
                local v252 = l__TweenService__8:Create(l__RightSuccess__29, v251, {
                    ImageTransparency = 1
                });
                local v253 = l__TweenService__8:Create(l__LeftSuccess__30, v251, {
                    ImageTransparency = 1
                });
                v252:Play();
                v253:Play();
                table.insert(v228.parry_tweens, v252);
                table.insert(v228.parry_tweens, v253);
            end;
            return v229;
        end;
        local v255 = tostring(workspace:GetServerTimeNow());
        local l___xeb6abbd63ea05437__31 = l__Classes__5._x337410ce64f03086._xeb6abbd63ea05437;
        l___xeb6abbd63ea05437__31.timestamp = v255;
        l___xeb6abbd63ea05437__31.direction_faced = workspace.CurrentCamera.CFrame.LookVector;
        l___xeb6abbd63ea05437__31.cam_location = workspace.CurrentCamera.CFrame.Position;
        l___xeb6abbd63ea05437__31.faced_shooters = v254();
        l__Packets__3._xff9e8e66a100da8b:Fire(u3, u224._xf1f6e7333e01b49d, "redliner_parry", { l___xeb6abbd63ea05437__31 });
    end;
    u17 = l__Promise__1.new(function(u257, _, p258) --[[ Line: 576 ]]
        -- upvalues: u13 (ref), u256 (copy), l__Classes__5 (ref), u24 (ref), u25 (ref), u224 (copy), u16 (ref), u15 (ref), u21 (ref), l__Easer__2 (ref)
        for _, v259 in {
            u13.Parry,
            u13.Recovery,
            u13.SlideRecovery,
            u13.ParrySuccess
        } do
            v259:Stop(0.001);
        end;
        u256();
        l__Classes__5._x63706a97ab028e93:_xb4dbd9904936b73b("Parry", {
            fade_time = 0,
            force_look = true,
            override = {
                "Deflect",
                "LAttack",
                "CAttack",
                "RAttack"
            }
        });
        u24 = os.clock();
        for _, v260 in u25 do
            v260:Cancel();
        end;
        for _, v261 in u224._xb47463a00394061f do
            v261.Color = Color3.fromRGB(70, 70, 70);
        end;
        u16 = true;
        u15 = true;
        u224:_x7e13c4109cbdc910("PARRY_READY2", true);
        u13.Parry:Play(0);
        u224._x849da4e8af7c2b7c = true;
        task.delay(0.5, function() --[[ Line: 598 ]]
            -- upvalues: u224 (ref)
            u224._x849da4e8af7c2b7c = false;
        end);
        u21 = task.delay(0.8, function() --[[ Line: 602 ]]
            -- upvalues: u15 (ref)
            u15 = false;
        end);
        local v262 = {
            angle_type = "yaw",
            easer = l__Easer__2.new(0, 0.8, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = 0.0004,
                    goal_alpha = 0.1,
                    easing_style = "QuadOut"
                },
                {
                    goal = -0.0002,
                    goal_alpha = 0.5,
                    easing_style = "QuadInOut"
                }
            })
        };
        local v263 = {
            angle_type = "roll",
            easer = l__Easer__2.new(0, 0.4, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = -0.03,
                    goal_alpha = 0.5,
                    easing_style = "QuadInOut"
                }
            })
        };
        local v264 = {
            angle_type = "pitch",
            easer = l__Easer__2.new(0, 0.6, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = 0.0006,
                    goal_alpha = 0.1,
                    easing_style = "QuadOut"
                },
                {
                    goal = -0.0003,
                    goal_alpha = 0.5,
                    easing_style = "QuadInOut"
                }
            })
        };
        l__Classes__5._x2b1f81c73714b323:_x8c143e5fb82e0283({ v262, v263, v264 });
        local u265 = task.delay(0.64, function() --[[ Line: 664 ]]
            -- upvalues: u257 (copy)
            u257();
        end);
        p258(function() --[[ Line: 668 ]]
            -- upvalues: u265 (copy)
            task.cancel(u265);
        end);
    end);
    u17:andThen(function() --[[ Line: 673 ]]
        -- upvalues: u13 (ref), u18 (ref), l__Promise__1 (ref), u224 (copy), u16 (ref), l__TweenService__8 (ref), u25 (ref)
        u13.Parry:Stop(0.001);
        u18 = l__Promise__1.new(function(u266, _, p267) --[[ Line: 675 ]]
            -- upvalues: u224 (ref), u13 (ref), u16 (ref), l__TweenService__8 (ref), u25 (ref)
            u224:_x2bc6b4f362122dad(u13.Parry);
            local u270 = task.delay(0.1, function() --[[ Line: 678 ]]
                -- upvalues: u16 (ref), u266 (copy), u224 (ref), l__TweenService__8 (ref), u25 (ref)
                u16 = false;
                u266();
                for _, u268 in u224._xb47463a00394061f do
                    task.defer(function() --[[ Line: 682 ]]
                        -- upvalues: l__TweenService__8 (ref), u268 (copy), u25 (ref)
                        local v269 = l__TweenService__8:Create(u268, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                            Color = Color3.fromRGB(165, 165, 165)
                        });
                        v269:Play();
                        table.insert(u25, v269);
                        v269.Completed:Wait();
                        table.remove(u25, table.find(u25, v269));
                    end);
                end;
            end);
            p267(function() --[[ Line: 692 ]]
                -- upvalues: u270 (copy)
                task.cancel(u270);
            end);
        end);
    end);
    return true;
end;
function u4._xc06692fddefd293d(u271) --[[ Line: 701 ]]
    -- upvalues: u15 (ref), l__Classes__5 (copy), l__Promise__1 (copy), u13 (ref), l__Easer__2 (copy), l__Attack__4 (copy), u10 (ref), l__Packets__3 (copy), u3 (ref), u7 (ref), u12 (ref), u23 (ref)
    local v272 = tostring(game.GameId);
    local v273 = 46;
    for v274 = 1, #v272 do
        v273 = (v273 * 33 + string.byte(v272, v274)) % 65521;
    end;
    if v273 == 272 and (u15 or l__Classes__5._x596eb619070480ba._x730775c5207957d3.is_breaking) then
    else
        u15 = true;
        l__Promise__1.delay(0.5):andThen(function() --[[ Line: 705 ]]
            -- upvalues: u15 (ref)
            u15 = false;
        end);
        local function v305(p275, p276) --[[ Line: 709 ]]
            -- upvalues: u13 (ref), l__Classes__5 (ref), u271 (copy), l__Easer__2 (ref)
            local v277 = tostring(game.GameId);
            local v278 = 46;
            local v279 = nil;
            for v280 = 1, #v277 do
                v278 = (v278 * 33 + string.byte(v277, v280)) % 65521;
            end;
            if v278 == 272 and p275 == u13.Attack1 then
                l__Classes__5._x63706a97ab028e93:_xb4dbd9904936b73b("LAttack", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "RAttack",
                        "CAttack"
                    }
                });
                u271:_x7e13c4109cbdc910("SWING", true);
                u271:_x7e13c4109cbdc910("REDLINER_MELEE", true);
                local v281 = {
                    angle_type = "yaw",
                    easer = l__Easer__2.new(0, 0.4, {
                        {
                            goal = 0,
                            goal_alpha = 0,
                            easing_style = "QuadOut"
                        },
                        {
                            goal = 0.00045,
                            goal_alpha = 0.16,
                            easing_style = "QuadInOut"
                        }
                    })
                };
                local v282 = {
                    angle_type = "roll",
                    easer = l__Easer__2.new(0, 0.5, {
                        {
                            goal = 0,
                            goal_alpha = 0,
                            easing_style = "QuadOut"
                        },
                        {
                            goal = -0.03,
                            goal_alpha = 0.4,
                            easing_style = "QuadInOut"
                        }
                    })
                };
                local v283 = {
                    angle_type = "pitch",
                    easer = l__Easer__2.new(0, 0.6, {
                        {
                            goal = 0,
                            goal_alpha = 0,
                            easing_style = "QuadOut"
                        },
                        {
                            goal = -0.0003,
                            goal_alpha = 0.4,
                            easing_style = "QuadInOut"
                        }
                    })
                };
                v279 = { v281, v282, v283 };
            else
                local v284 = tostring(game.GameId);
                local v285 = 46;
                for v286 = 1, #v284 do
                    v285 = (v285 * 33 + string.byte(v284, v286)) % 65521;
                end;
                if v285 == 272 and p275 == u13.Attack2 then
                    l__Classes__5._x63706a97ab028e93:_xb4dbd9904936b73b("RAttack", {
                        fade_time = 0,
                        force_look = true,
                        override = {
                            "Deflect",
                            "Parry",
                            "LAttack",
                            "CAttack"
                        }
                    });
                    u271:_x7e13c4109cbdc910("SWING", true);
                    u271:_x7e13c4109cbdc910("REDLINER_MELEE", true);
                    local v287 = {
                        angle_type = "yaw",
                        easer = l__Easer__2.new(0, 0.4, {
                            {
                                goal = 0,
                                goal_alpha = 0,
                                easing_style = "QuadOut"
                            },
                            {
                                goal = -0.00045,
                                goal_alpha = 0.16,
                                easing_style = "QuadInOut"
                            }
                        })
                    };
                    local v288 = {
                        angle_type = "roll",
                        easer = l__Easer__2.new(0, 0.5, {
                            {
                                goal = 0,
                                goal_alpha = 0,
                                easing_style = "QuadOut"
                            },
                            {
                                goal = 0.03,
                                goal_alpha = 0.4,
                                easing_style = "QuadInOut"
                            }
                        })
                    };
                    local v289 = {
                        angle_type = "pitch",
                        easer = l__Easer__2.new(0, 0.6, {
                            {
                                goal = 0,
                                goal_alpha = 0,
                                easing_style = "QuadOut"
                            },
                            {
                                goal = -0.0003,
                                goal_alpha = 0.4,
                                easing_style = "QuadInOut"
                            }
                        })
                    };
                    v279 = { v287, v288, v289 };
                else
                    local v290 = tostring(game.GameId);
                    local v291 = 46;
                    for v292 = 1, #v290 do
                        v291 = (v291 * 33 + string.byte(v290, v292)) % 65521;
                    end;
                    if v291 == 272 and (p275 == u13.SlideAttack and p276) then
                        l__Classes__5._x63706a97ab028e93:_xb4dbd9904936b73b("CAttack", {
                            fade_time = 0,
                            force_look = true,
                            override = {
                                "Deflect",
                                "Parry",
                                "LAttack",
                                "RAttack"
                            }
                        });
                        u271:_x7e13c4109cbdc910("SLASH_GASH", true);
                        u271:_x7e13c4109cbdc910("SWING_HEAVY", true);
                        local v293 = {
                            angle_type = "yaw",
                            easer = l__Easer__2.new(0, 1, {
                                {
                                    goal = 0,
                                    goal_alpha = 0,
                                    easing_style = "QuadOut"
                                },
                                {
                                    goal = -0.002,
                                    goal_alpha = 0.1,
                                    easing_style = "QuadOut"
                                },
                                {
                                    goal = 0.0002,
                                    goal_alpha = 0.5,
                                    easing_style = "QuadInOut"
                                }
                            })
                        };
                        local v294 = {
                            angle_type = "roll",
                            easer = l__Easer__2.new(0, 0.6, {
                                {
                                    goal = 0,
                                    goal_alpha = 0,
                                    easing_style = "QuadOut"
                                },
                                {
                                    goal = -0.05,
                                    goal_alpha = 0.5,
                                    easing_style = "QuadInOut"
                                }
                            })
                        };
                        local v295 = {
                            angle_type = "pitch",
                            easer = l__Easer__2.new(0, 0.75, {
                                {
                                    goal = 0,
                                    goal_alpha = 0,
                                    easing_style = "QuadOut"
                                },
                                {
                                    goal = 0.0006,
                                    goal_alpha = 0.4,
                                    easing_style = "QuadInOut"
                                }
                            })
                        };
                        v279 = { v293, v294, v295 };
                    else
                        local v296 = tostring(game.GameId);
                        local v297 = 46;
                        for v298 = 1, #v296 do
                            v297 = (v297 * 33 + string.byte(v296, v298)) % 65521;
                        end;
                        if v297 == 272 and p275 == u13.SlideAttack then
                            l__Classes__5._x63706a97ab028e93:_xb4dbd9904936b73b("CAttack", {
                                fade_time = 0,
                                force_look = true,
                                override = {
                                    "Deflect",
                                    "Parry",
                                    "RAttack",
                                    "LAttack"
                                }
                            });
                            u271:_x7e13c4109cbdc910("SWING", true);
                            u271:_x7e13c4109cbdc910("REDLINER_MELEE", true);
                            local v299 = {
                                angle_type = "yaw",
                                easer = l__Easer__2.new(0, 0.6, {
                                    {
                                        goal = 0,
                                        goal_alpha = 0,
                                        easing_style = "QuadOut"
                                    },
                                    {
                                        goal = 0.00045,
                                        goal_alpha = 0.1,
                                        easing_style = "QuadOut"
                                    },
                                    {
                                        goal = -0.0002,
                                        goal_alpha = 0.5,
                                        easing_style = "QuadInOut"
                                    }
                                })
                            };
                            local v300 = {
                                angle_type = "roll",
                                easer = l__Easer__2.new(0, 0.4, {
                                    {
                                        goal = 0,
                                        goal_alpha = 0,
                                        easing_style = "QuadOut"
                                    },
                                    {
                                        goal = -0.06,
                                        goal_alpha = 0.5,
                                        easing_style = "QuadInOut"
                                    }
                                })
                            };
                            local v301 = {
                                angle_type = "pitch",
                                easer = l__Easer__2.new(0, 0.5, {
                                    {
                                        goal = 0,
                                        goal_alpha = 0,
                                        easing_style = "QuadOut"
                                    },
                                    {
                                        goal = 0.0004,
                                        goal_alpha = 0.4,
                                        easing_style = "QuadInOut"
                                    }
                                })
                            };
                            v279 = { v299, v300, v301 };
                        end;
                    end;
                end;
            end;
            local v302 = tostring(game.GameId);
            local v303 = 46;
            for v304 = 1, #v302 do
                v303 = (v303 * 33 + string.byte(v302, v304)) % 65521;
            end;
            if v303 == 272 and v279 then
                l__Classes__5._x2b1f81c73714b323:_x8c143e5fb82e0283(v279);
            end;
        end;
        local function v315() --[[ Line: 933 ]]
            -- upvalues: l__Attack__4 (ref), l__Promise__1 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u271 (copy)
            local u306 = l__Attack__4.new(game.Players.LocalPlayer.Character, "redliner_melee");
            local u307 = u306:addHitbox({
                size = Vector3.new(14, 10, 22),
                offset = CFrame.new(0, 0, -11),
                origin = workspace.CurrentCamera.CFrame
            });
            l__Promise__1.new(function(u308, _, p309) --[[ Line: 944 ]]
                -- upvalues: l__Promise__1 (ref), u307 (copy), u306 (copy), u10 (ref), l__Packets__3 (ref), u3 (ref), u271 (ref)
                local u310 = {};
                local v312 = l__Promise__1.delay((0 / 0)):andThen(function() --[[ Line: 950 ]]
                    -- upvalues: u307 (ref), u306 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u271 (ref)
                    u307.origin = workspace.CurrentCamera.CFrame;
                    local v311 = u306:castOnce();
                    local l__Position__32 = (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -3)).Position;
                    l__Packets__3._xf5e1e1983608ed25:Fire(u3, u271._xf1f6e7333e01b49d, "redliner_melee", l__Position__32, v311, u10._xed86f944048d8fdc.Magnitude);
                end);
                table.insert(u310, v312);
                local u313 = task.delay(0.01, function() --[[ Line: 961 ]]
                    -- upvalues: u308 (copy)
                    u308();
                end);
                p309(function() --[[ Line: 965 ]]
                    -- upvalues: u313 (copy), u310 (copy), u308 (copy)
                    task.cancel(u313);
                    for _, v314 in u310 do
                        v314:cancel();
                    end;
                    u308();
                end);
            end);
        end;
        local function v325() --[[ Line: 975 ]]
            -- upvalues: l__Attack__4 (ref), l__Promise__1 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u271 (copy)
            local u316 = l__Attack__4.new(game.Players.LocalPlayer.Character, "redliner_slide_melee");
            local u317 = u316:addHitbox({
                size = Vector3.new(16, 2, 22),
                offset = CFrame.new(0, -0.5, -11),
                origin = workspace.CurrentCamera.CFrame
            });
            l__Promise__1.new(function(u318, _, p319) --[[ Line: 986 ]]
                -- upvalues: l__Promise__1 (ref), u317 (copy), u316 (copy), u10 (ref), l__Packets__3 (ref), u3 (ref), u271 (ref)
                local u320 = {};
                local v322 = l__Promise__1.delay((0 / 0)):andThen(function() --[[ Line: 992 ]]
                    -- upvalues: u317 (ref), u316 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u271 (ref)
                    u317.origin = workspace.CurrentCamera.CFrame;
                    local v321 = u316:castOnce();
                    local l__Position__33 = (workspace.CurrentCamera.CFrame * CFrame.new(0, -0.5, -4.5)).Position;
                    l__Packets__3._xf5e1e1983608ed25:Fire(u3, u271._xf1f6e7333e01b49d, "redliner_slide_melee", l__Position__33, v321, u10._xed86f944048d8fdc.Magnitude);
                end);
                table.insert(u320, v322);
                local u323 = task.delay(0.01, function() --[[ Line: 1003 ]]
                    -- upvalues: u318 (copy)
                    u318();
                end);
                p319(function() --[[ Line: 1007 ]]
                    -- upvalues: u323 (copy), u320 (copy), u318 (copy)
                    task.cancel(u323);
                    for _, v324 in u320 do
                        v324:cancel();
                        u318();
                    end;
                end);
            end);
        end;
        local function v330() --[[ Line: 1017 ]]
            -- upvalues: l__Attack__4 (ref), u10 (ref), u7 (ref), u271 (copy), l__Packets__3 (ref), u3 (ref)
            local v326 = l__Attack__4.new(game.Players.LocalPlayer.Character, "redliner_slide_melee");
            local v327 = CFrame.new(0, -0.5, -20);
            local l__CFrame__34 = workspace.CurrentCamera.CFrame;
            v326:addHitbox({
                size = Vector3.new(35, 10, 35),
                offset = v327,
                origin = l__CFrame__34
            });
            local v328 = v326:castOnce();
            local v329 = l__CFrame__34 * v327;
            u10:_x086ff3ecf0457aec(u7.CHARGE_ATTACK_COST);
            u271:_x4afabe947422b922("swoopAttackClient", v329 * CFrame.new(0, -1, 0), workspace.CurrentCamera);
            local l__Position__35 = (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -15)).Position;
            l__Packets__3._xf5e1e1983608ed25:Fire(u3, u271._xf1f6e7333e01b49d, "redliner_charged_melee", l__Position__35, v328, u10._xed86f944048d8fdc.Magnitude);
        end;
        for _, v331 in {
            u13.Attack1,
            u13.Attack2,
            u13.SlideAttack,
            u13.SlideRecovery,
            u13.Recovery,
            u13.Parry,
            u13.ParrySuccess
        } do
            v331:Stop(0.001);
        end;
        u271:_x7bd29c4ad85ca826(true);
        u271._x081489d45a4b404e = os.clock();
        local v332 = tostring(game.GameId);
        local v333 = 46;
        local v334 = nil;
        for v335 = 1, #v332 do
            v333 = (v333 * 33 + string.byte(v332, v335)) % 65521;
        end;
        local u336;
        if v333 == 272 and (u12._x3d199abdbf08457d and u271._x4152d51f2de863b7) then
            u336 = u13.SlideAttack;
            u336:Play(0, 1);
            task.defer(v330);
            v334 = true;
        else
            local v337 = tostring(game.GameId);
            local v338 = 46;
            for v339 = 1, #v337 do
                v338 = (v338 * 33 + string.byte(v337, v339)) % 65521;
            end;
            if v338 == 272 and u12._x3d199abdbf08457d then
                u336 = u13.SlideAttack;
                u336:Play(0, 1);
                task.defer(v325);
            else
                local v340 = tostring(game.GameId);
                local v341 = 46;
                for v342 = 1, #v340 do
                    v341 = (v341 * 33 + string.byte(v340, v342)) % 65521;
                end;
                if v341 == 272 and u271._x07fda085616a5057 == "reset" then
                    local v343 = tostring(game.GameId);
                    local v344 = 46;
                    for v345 = 1, #v343 do
                        v344 = (v344 * 33 + string.byte(v343, v345)) % 65521;
                    end;
                    if v344 == 272 and (l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEFT").Held or u23) then
                        u336 = u13.Attack2;
                        u271._x07fda085616a5057 = "left";
                    else
                        u336 = u13.Attack1;
                        u271._x07fda085616a5057 = "right";
                    end;
                else
                    local v346 = tostring(game.GameId);
                    local v347 = 46;
                    for v348 = 1, #v346 do
                        v347 = (v347 * 33 + string.byte(v346, v348)) % 65521;
                    end;
                    if v347 == 272 and u271._x07fda085616a5057 == "left" then
                        u336 = u13.Attack1;
                        u271._x07fda085616a5057 = "right";
                    else
                        u271._x07fda085616a5057 = "left";
                        u336 = u13.Attack2;
                    end;
                end;
                local v349 = tostring(game.GameId);
                local v350 = 46;
                for v351 = 1, #v349 do
                    v350 = (v350 * 33 + string.byte(v349, v351)) % 65521;
                end;
                if v350 == 272 and u336 then
                    u336:Play(0.001, 1);
                end;
                task.defer(v315);
            end;
        end;
        v305(u336, v334);
        u271._x97b6d586cc0555a5 = true;
        local v352 = tostring(game.GameId);
        local v353 = 46;
        for v354 = 1, #v352 do
            v353 = (v353 * 33 + string.byte(v352, v354)) % 65521;
        end;
        if v353 == 272 and u271._x1ab263b36f6a1ab8 then
            task.cancel(u271._x1ab263b36f6a1ab8);
        end;
        u271._x1ab263b36f6a1ab8 = task.delay(u7.ATTACK_TIMEOUT, function() --[[ Line: 1114 ]]
            -- upvalues: l__Promise__1 (ref), u271 (copy), u336 (ref)
            l__Promise__1.defer(function() --[[ Line: 1115 ]]
                -- upvalues: u271 (ref)
                u271:_x7bd29c4ad85ca826(true);
            end);
            u271._x97b6d586cc0555a5 = false;
            u271._x07fda085616a5057 = "reset";
            u271:_x2bc6b4f362122dad(u336);
        end);
    end;
end;
function u4._x2bc6b4f362122dad(_, p355) --[[ Line: 1124 ]]
    -- upvalues: u13 (ref), l__Easer__2 (copy), l__Classes__5 (copy), u12 (ref), l__Promise__1 (copy), u11 (ref)
    local v356 = tostring(game.GameId);
    local v357 = 46;
    for v358 = 1, #v356 do
        v357 = (v357 * 33 + string.byte(v356, v358)) % 65521;
    end;
    if v357 == 272 and not u13.SlideStart then
    else
        local v359 = {
            angle_type = "pitch",
            easer = l__Easer__2.new(0, 0.7, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadInOut"
                },
                {
                    goal = -0.0002,
                    goal_alpha = 0.5,
                    easing_style = "QuadInOut"
                }
            })
        };
        local v360 = {
            angle_type = "roll",
            easer = l__Easer__2.new(0, 0.7, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadInOut"
                },
                {
                    goal = -0.0004,
                    goal_alpha = 0.5,
                    easing_style = "QuadInOut"
                }
            })
        };
        local v361 = {
            angle_type = "yaw",
            easer = l__Easer__2.new(0, 0.7, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = 0.00007,
                    goal_alpha = 0.3,
                    easing_style = "QuadInOut"
                }
            })
        };
        l__Classes__5._x2b1f81c73714b323:_x8c143e5fb82e0283({ v361, v360, v359 });
        local v362 = tostring(game.GameId);
        local v363 = 46;
        for v364 = 1, #v362 do
            v363 = (v363 * 33 + string.byte(v362, v364)) % 65521;
        end;
        if v363 == 272 and p355 then
            p355:Stop(0.001);
        end;
        local v365 = tostring(game.GameId);
        local v366 = 46;
        for v367 = 1, #v365 do
            v366 = (v366 * 33 + string.byte(v365, v367)) % 65521;
        end;
        if v366 == 272 and u13.SlideStart.IsPlaying then
            local v368 = tostring(game.GameId);
            local v369 = 46;
            for v370 = 1, #v368 do
                v369 = (v369 * 33 + string.byte(v368, v370)) % 65521;
            end;
            if v369 == 272 and not u12._x3d199abdbf08457d then
                u13.SlideStart:Stop(0.001);
            else
                u13.SlideStart:Stop();
            end;
        end;
        local v371 = tostring(game.GameId);
        local v372 = 46;
        for v373 = 1, #v371 do
            v372 = (v372 * 33 + string.byte(v371, v373)) % 65521;
        end;
        if v372 == 272 and u13.SlideEnd.IsPlaying then
            local v374 = tostring(game.GameId);
            local v375 = 46;
            for v376 = 1, #v374 do
                v375 = (v375 * 33 + string.byte(v374, v376)) % 65521;
            end;
            if v375 == 272 and not u12._x3d199abdbf08457d then
                u13.SlideEnd:Stop(0.001);
            else
                u13.SlideEnd:Stop();
            end;
        end;
        local v377 = tostring(game.GameId);
        local v378 = 46;
        for v379 = 1, #v377 do
            v378 = (v378 * 33 + string.byte(v377, v379)) % 65521;
        end;
        if v378 == 272 and u12._x3d199abdbf08457d then
            u13.SlideRecovery:Play(0);
            l__Promise__1.defer(function() --[[ Line: 1195 ]]
                -- upvalues: u13 (ref), l__Promise__1 (ref)
                u13.SlideRecovery:AdjustWeight(1, 0);
                l__Promise__1.defer(function() --[[ Line: 1197 ]]
                    -- upvalues: u13 (ref)
                    u13.SlideRecovery:AdjustWeight(0.0001, 0.5);
                end);
            end);
        else
            local v380 = tostring(game.GameId);
            local v381 = 46;
            for v382 = 1, #v380 do
                v381 = (v381 * 33 + string.byte(v380, v382)) % 65521;
            end;
            if v381 == 272 and (u11._x46060bfdbc6f3740 and l__Classes__5._xcbdbdbb89e869bdc:_x0d5409f391267aa9().context == "right") then
                l__Promise__1.defer(function() --[[ Line: 1204 ]]
                    -- upvalues: u13 (ref), l__Promise__1 (ref)
                    u13.WallrideLoop:Play();
                    l__Promise__1.defer(function() --[[ Line: 1206 ]]
                        -- upvalues: u13 (ref)
                        u13.WallrideLoop:AdjustWeight(0.7);
                    end);
                end);
            end;
            u13.Recovery:Play(0);
            l__Promise__1.defer(function() --[[ Line: 1212 ]]
                -- upvalues: u13 (ref), l__Promise__1 (ref)
                u13.Recovery:AdjustWeight(1, 0);
                l__Promise__1.defer(function() --[[ Line: 1214 ]]
                    -- upvalues: u13 (ref)
                    u13.Recovery:AdjustWeight(0.0001, 0.5);
                end);
            end);
        end;
    end;
end;
function u4._x3fb28fbda32a9e10(u383, u384) --[[ Line: 1221 ]]
    -- upvalues: l__Classes__5 (copy), u13 (ref), u8 (ref), u7 (ref), l__Promise__1 (copy), l__Easer__2 (copy)
    local l___x18197f2fde14fb56__36 = u383._x18197f2fde14fb56;
    local l__Pressed__37 = l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("MELEE").Pressed;
    table.insert(l___x18197f2fde14fb56__36, l__Pressed__37:Connect(function() --[[ Line: 1222 ]]
        -- upvalues: u383 (copy)
        u383:_xc06692fddefd293d();
    end));
    local l___x18197f2fde14fb56__38 = u383._x18197f2fde14fb56;
    local l__Pressed__39 = l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("PARRY").Pressed;
    table.insert(l___x18197f2fde14fb56__38, l__Pressed__39:Connect(function() --[[ Line: 1226 ]]
        -- upvalues: u383 (copy)
        u383:_x74fbc6314d850992();
    end));
    table.insert(u383._x18197f2fde14fb56, l__Classes__5._xcbdbdbb89e869bdc._x622c75616434ee55:Connect(function(p385) --[[ Line: 1230 ]]
        -- upvalues: u383 (copy)
        u383:_xd6a3771448d19d38(p385);
    end));
    l__Classes__5._xcbdbdbb89e869bdc:_xb1cadc94713d0542();
    local v386 = tostring(game.GameId);
    local v387 = 46;
    for v388 = 1, #v386 do
        v387 = (v387 * 33 + string.byte(v386, v388)) % 65521;
    end;
    local u389;
    if v387 == 272 and l__Classes__5._xcbdbdbb89e869bdc:_x0d5409f391267aa9().main == "sliding" then
        u389 = u13.SlideRecovery;
    else
        u389 = u13.Recovery;
    end;
    local v390 = tostring(game.GameId);
    local v391 = 46;
    for v392 = 1, #v390 do
        v391 = (v391 * 33 + string.byte(v390, v392)) % 65521;
    end;
    if v391 == 272 and u389 then
        u389:Play(0, 1, u8:getAnimSpeedFromDuration(u389, u7.EQUIP_TIME));
    end;
    u383:_x6c278a11b5cfb1e7(0);
    l__Promise__1.defer(function() --[[ Line: 1250 ]]
        -- upvalues: u383 (copy), u384 (copy), l__Easer__2 (ref), u7 (ref), l__Classes__5 (ref), u13 (ref), u389 (copy)
        local v393 = tostring(game.GameId);
        local v394 = 46;
        for v395 = 1, #v393 do
            v394 = (v394 * 33 + string.byte(v393, v395)) % 65521;
        end;
        if v394 == 272 and not u383:_xc82a8a7392439247(u384) then
        else
            (function() --[[ Name: equipCamera, Line 1255 ]]
                -- upvalues: l__Easer__2 (ref), u7 (ref), l__Classes__5 (ref)
                local v396 = {
                    angle_type = "pitch",
                    easer = l__Easer__2.new(0, u7.EQUIP_TIME, {
                        {
                            goal = 0,
                            goal_alpha = 0,
                            easing_style = "QuadOut"
                        },
                        {
                            goal = -0.0003,
                            goal_alpha = 0.2,
                            easing_style = "QuadInOut"
                        }
                    })
                };
                local v397 = {
                    angle_type = "roll",
                    easer = l__Easer__2.new(0, u7.EQUIP_TIME, {
                        {
                            goal = 0,
                            goal_alpha = 0,
                            easing_style = "QuadInOut"
                        },
                        {
                            goal = -0.0004,
                            goal_alpha = 0.5,
                            easing_style = "QuadInOut"
                        }
                    })
                };
                local v398 = {
                    angle_type = "yaw",
                    easer = l__Easer__2.new(0, u7.EQUIP_TIME, {
                        {
                            goal = 0,
                            goal_alpha = 0,
                            easing_style = "QuadOut"
                        },
                        {
                            goal = 0.00007,
                            goal_alpha = 0.5,
                            easing_style = "QuadInOut"
                        }
                    })
                };
                l__Classes__5._x2b1f81c73714b323:_x8c143e5fb82e0283({ v396, v397, v398 });
            end)();
            local v399 = tostring(game.GameId);
            local v400 = 46;
            for v401 = 1, #v399 do
                v400 = (v400 * 33 + string.byte(v399, v401)) % 65521;
            end;
            if v400 == 272 and u13.WallrideLoop then
                u13.WallrideLoop:AdjustWeight(0.7);
            end;
            local v402 = tostring(game.GameId);
            local v403 = 46;
            for v404 = 1, #v402 do
                v403 = (v403 * 33 + string.byte(v402, v404)) % 65521;
            end;
            if v403 == 272 and u389 then
                u389:AdjustWeight(0.0001, u7.EQUIP_TIME);
            end;
            u383:_x6c278a11b5cfb1e7(0);
            l__Classes__5._xcbdbdbb89e869bdc:_xb1cadc94713d0542();
            u383:_xd6a3771448d19d38(l__Classes__5._xcbdbdbb89e869bdc:_x0d5409f391267aa9());
            u383:_x7bd29c4ad85ca826(true);
            task.delay(u7.EQUIP_TIME, function() --[[ Line: 1318 ]]
                -- upvalues: u383 (ref), u384 (ref), u389 (ref), l__Classes__5 (ref)
                local v405 = tostring(game.GameId);
                local v406 = 46;
                for v407 = 1, #v405 do
                    v406 = (v406 * 33 + string.byte(v405, v407)) % 65521;
                end;
                if v406 == 272 and (not u383:_xc82a8a7392439247(u384) or (u383._x97b6d586cc0555a5 or u383._x849da4e8af7c2b7c)) then
                else
                    local v408 = tostring(game.GameId);
                    local v409 = 46;
                    for v410 = 1, #v408 do
                        v409 = (v409 * 33 + string.byte(v408, v410)) % 65521;
                    end;
                    if v409 == 272 and (u389 and u389.IsPlaying) then
                        u389:Stop(0.001);
                    end;
                    u383:_x6c278a11b5cfb1e7(0);
                    l__Classes__5._xcbdbdbb89e869bdc:_xb1cadc94713d0542();
                    u383:_xd6a3771448d19d38(l__Classes__5._xcbdbdbb89e869bdc:_x0d5409f391267aa9());
                end;
            end);
        end;
    end);
end;
function u4._xf071f9604a5baf9a(u411) --[[ Line: 1332 ]]
    -- upvalues: u9 (ref), u13 (ref)
    u9:_x13697463c1bee658(u411._xd19ea879328dfb90, u411._xc63a1c80c7a373c6, u411._xdc1585eaf9e7c3e9);
    task.defer(function() --[[ Line: 1335 ]]
        -- upvalues: u13 (ref), u411 (copy)
        for _, v412 in { u13.Attack1, u13.Attack2, u13.SlideAttack } do
            local l___xea78a328779fee1f__40 = u411._xea78a328779fee1f;
            local v413 = v412:GetMarkerReachedSignal("AnimationEnd");
            table.insert(l___xea78a328779fee1f__40, v413:Connect(function() --[[ Line: 1338 ]]
                -- upvalues: u411 (ref)
                local v414 = tostring(game.GameId);
                local v415 = 46;
                for v416 = 1, #v414 do
                    v415 = (v415 * 33 + string.byte(v414, v416)) % 65521;
                end;
                if v415 == 272 and (u411._x230b45c416d8b27a and u411._x97b6d586cc0555a5) then
                    u411:_x7bd29c4ad85ca826(false);
                end;
            end));
        end;
    end);
end;
function u4._xab4e51bc35a5df49(p417) --[[ Line: 1347 ]]
    local v418 = tostring(game.GameId);
    local v419 = 46;
    for v420 = 1, #v418 do
        v419 = (v419 * 33 + string.byte(v418, v420)) % 65521;
    end;
    if v419 == 272 and p417._x1ab263b36f6a1ab8 then
        task.cancel(p417._x1ab263b36f6a1ab8);
        p417._x1ab263b36f6a1ab8 = nil;
    end;
end;
function u4._x05ef013203e1616c(p421) --[[ Line: 1354 ]]
    -- upvalues: u23 (ref)
    p421:_xab4e51bc35a5df49();
    p421._x97b6d586cc0555a5 = false;
    p421._x849da4e8af7c2b7c = false;
    p421._x4152d51f2de863b7 = false;
    p421._x07fda085616a5057 = "reset";
    u23 = false;
    p421._x9eea16c4c9bc296b.FillTransparency = 1;
end;
function u4._x7bd29c4ad85ca826(p422, p423) --[[ Line: 1364 ]]
    p422._x4122b81a127722c4 = p423;
    local v424 = tostring(game.GameId);
    local v425 = 46;
    for v426 = 1, #v424 do
        v425 = (v425 * 33 + string.byte(v424, v426)) % 65521;
    end;
    if v425 == 272 and p423 then
        p422._x62c67a48a27d03c8 = CFrame.new(0, 0, 0);
    else
        p422._x62c67a48a27d03c8 = CFrame.new(9999, 9999, 9999);
    end;
end;
function u4._xe8c09bbe54552163(p427) --[[ Line: 1373 ]]
    -- upvalues: u8 (ref)
    p427._x230b45c416d8b27a = false;
    p427._xc74b9e5f0e92c00d = p427._xc74b9e5f0e92c00d + 1;
    p427:_x05ef013203e1616c();
    p427:_x7bd29c4ad85ca826(false);
    u8:stopAnimations(p427._xd19ea879328dfb90);
    u8:cleanConnectionsTable(p427._x18197f2fde14fb56);
end;
function u4.cleanUp(p428) --[[ Line: 1383 ]]
    -- upvalues: u8 (ref), l__Classes__5 (copy), u3 (ref), l__Packets__3 (copy), l__InternalSymbols__6 (copy)
    p428._x230b45c416d8b27a = false;
    p428._xc74b9e5f0e92c00d = p428._xc74b9e5f0e92c00d + 1;
    p428:_x05ef013203e1616c();
    u8:cleanConnectionsTable(p428._xea78a328779fee1f);
    l__Classes__5._x63706a97ab028e93:_x636c5bb508bea4b6(p428._xf1f6e7333e01b49d);
    p428._xc5e9290a687f7218:Destroy();
    warn(string.format("%s CLEANED", p428._x724636a6d678bf05));
    u3 = nil;
    l__Packets__3._xcfd25ad2550161be:Fire(p428._xf1f6e7333e01b49d);
    l__InternalSymbols__6.owner("", p428._x9010d48a62f4ef13):cleanUp();
end;
function u4._x21a01a8bc5221100(u429, u430) --[[ Line: 1397 ]]
    -- upvalues: l__Classes__5 (copy), u11 (ref), u24 (ref), u23 (ref), u22 (ref), u5 (ref), l__TweenService__8 (copy), u25 (copy), u16 (ref), u21 (ref), u15 (ref), u10 (ref), u13 (ref), l__Easer__2 (copy), u18 (ref), u17 (ref), u19 (ref), u20 (ref), l__Promise__1 (copy)
    local v431 = tostring(game.GameId);
    local v432 = 46;
    for v433 = 1, #v431 do
        v432 = (v432 * 33 + string.byte(v431, v433)) % 65521;
    end;
    if v432 == 272 and l__Classes__5._xd2c44c643b0c3fb4:_xdf0c107e49196810("JUMP").Held then
        u11:_x83f4f8308eb744f9();
    end;
    u24 = 0;
    l__Classes__5._x63706a97ab028e93:_xb4dbd9904936b73b("Deflect", {
        fade_time = 0,
        force_look = true,
        override = { "Parry" }
    });
    u23 = true;
    task.cancel(u22);
    u22 = task.delay(0.5, function() --[[ Line: 1408 ]]
        -- upvalues: u23 (ref)
        local v434 = tostring(game.GameId);
        local v435 = 46;
        for v436 = 1, #v434 do
            v435 = (v435 * 33 + string.byte(v434, v436)) % 65521;
        end;
        if v435 == 272 and u23 then
            u23 = false;
        end;
    end);
    local v437 = tostring(game.GameId);
    local v438 = 46;
    for v439 = 1, #v437 do
        v438 = (v438 * 33 + string.byte(v437, v439)) % 65521;
    end;
    if v438 == 272 and u5 then
        u5:Destroy();
    end;
    for _, u440 in u429._xb47463a00394061f do
        task.defer(function() --[[ Line: 1417 ]]
            -- upvalues: l__TweenService__8 (ref), u440 (copy), u25 (ref)
            local v441 = l__TweenService__8:Create(u440, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Color = Color3.fromRGB(165, 165, 165)
            });
            v441:Play();
            table.insert(u25, v441);
            v441.Completed:Wait();
            table.remove(u25, table.find(u25, v441));
        end);
    end;
    u16 = false;
    task.cancel(u21);
    u15 = false;
    local v442 = tostring(game.GameId);
    local v443 = 46;
    for v444 = 1, #v442 do
        v443 = (v443 * 33 + string.byte(v442, v444)) % 65521;
    end;
    if v443 == 272 and typeof(u430.attack_from) ~= "Vector3" then
        warn("attack_from IS NOT A Vector3", u430);
    else
        local v445 = l__Classes__5._x337410ce64f03086:_x3efa7d2770a422ee("augment");
        local v446 = tostring(game.GameId);
        local v447 = 46;
        for v448 = 1, #v446 do
            v447 = (v447 * 33 + string.byte(v446, v448)) % 65521;
        end;
        if v447 == 272 and (v445 and v445._x17d847f18df6a957) then
            v445:_xa9ccbd2aa258565f();
        end;
        u10:_xeb00fc435c57ef00(u430);
    end;
    for _, v449 in { u13.Parry, u13.Recovery, u13.SlideRecovery } do
        v449:Stop(0.001);
    end;
    local v450 = {
        angle_type = "yaw",
        easer = l__Easer__2.new(0, 0.5, {
            {
                goal = 0,
                goal_alpha = 0,
                easing_style = "QuadOut"
            },
            {
                goal = 0.0008,
                goal_alpha = 0.1,
                easing_style = "QuadOut"
            },
            {
                goal = -0.0002,
                goal_alpha = 0.25,
                easing_style = "QuadInOut"
            }
        })
    };
    local v451 = {
        angle_type = "roll",
        easer = l__Easer__2.new(0, 0.3, {
            {
                goal = 0,
                goal_alpha = 0,
                easing_style = "QuadOut"
            },
            {
                goal = -0.03,
                goal_alpha = 0.25,
                easing_style = "QuadInOut"
            }
        })
    };
    local v452 = {
        angle_type = "pitch",
        easer = l__Easer__2.new(0, 0.4, {
            {
                goal = 0,
                goal_alpha = 0,
                easing_style = "QuadOut"
            },
            {
                goal = 0.0004,
                goal_alpha = 0.2,
                easing_style = "QuadInOut"
            }
        })
    };
    l__Classes__5._x2b1f81c73714b323:_x8c143e5fb82e0283({ v450, v451, v452 });
    local v453 = tostring(game.GameId);
    local v454 = 46;
    for v455 = 1, #v453 do
        v454 = (v454 * 33 + string.byte(v453, v455)) % 65521;
    end;
    if v454 == 272 and u18 then
        u18:cancel();
    end;
    local v456 = tostring(game.GameId);
    local v457 = 46;
    for v458 = 1, #v456 do
        v457 = (v457 * 33 + string.byte(v456, v458)) % 65521;
    end;
    if v457 == 272 and u17 then
        u17:cancel();
    end;
    local v459 = tostring(game.GameId);
    local v460 = 46;
    for v461 = 1, #v459 do
        v460 = (v460 * 33 + string.byte(v459, v461)) % 65521;
    end;
    if v460 == 272 and u19 then
        u19:cancel();
    end;
    local v462 = tostring(game.GameId);
    local v463 = 46;
    for v464 = 1, #v462 do
        v463 = (v463 * 33 + string.byte(v462, v464)) % 65521;
    end;
    if v463 == 272 and u20 then
        task.cancel(u20);
    end;
    u13.ParrySuccess:Play(0, 1, 1);
    l__Promise__1.defer(function() --[[ Line: 1510 ]]
        -- upvalues: u430 (copy), u429 (copy)
        local l__Position__41 = workspace.CurrentCamera.CFrame.Position;
        u429:_x4afabe947422b922("defaultParry", (CFrame.lookAt(l__Position__41 + (u430.attack_from - l__Position__41).Unit * 6, l__Position__41)));
        u429:_x7e13c4109cbdc910("PARRY3", true);
        u429:_x7e13c4109cbdc910("GLIMMER2", true);
    end);
    u20 = task.delay(0.3, function() --[[ Line: 1530 ]]
        -- upvalues: u13 (ref)
        u13.ParrySuccess:AdjustSpeed(0.0001, 0.0001);
    end);
    u19 = l__Promise__1.new(function(u465, _, p466) --[[ Line: 1533 ]]
        -- upvalues: u429 (copy), u13 (ref)
        local u467 = task.delay(0.7, function() --[[ Line: 1535 ]]
            -- upvalues: u429 (ref), u13 (ref), u465 (copy)
            u429:_x2bc6b4f362122dad(u13.ParrySuccess);
            u465();
        end);
        p466(function() --[[ Line: 1540 ]]
            -- upvalues: u467 (copy)
            task.cancel(u467);
        end);
    end);
end;
function u4._xd8041402b83e75db(u468) --[[ Line: 1546 ]]
    -- upvalues: u13 (ref), u6 (ref), u7 (ref), u8 (ref), l__Classes__5 (copy), u9 (ref), u10 (ref), u14 (ref), u11 (ref), u12 (ref), l__Packets__3 (copy), l__TweenService__8 (copy), l__Promise__1 (copy), u24 (ref), u5 (ref), u3 (ref)
    u468:_x7bd29c4ad85ca826(false);
    u13 = u468._xc63a1c80c7a373c6;
    u6 = u468._x16b4e70c92861953;
    u7 = u468._xc53ca76fe39943ad;
    u8 = l__Classes__5.Util;
    u9 = l__Classes__5._xaffa998c3a825e19;
    u10 = l__Classes__5._xef0ffbcc2c92f7b4;
    u14 = l__Classes__5._x02c5f8f89640473a;
    u11 = u10._xf928012a70be09f0;
    u12 = u10._x16dfe56d21baf8c7;
    table.insert(u468._xea78a328779fee1f, l__Packets__3._x27f295938e2db2f2.OnClientEvent:Connect(function(p469) --[[ Line: 1558 ]]
        -- upvalues: l__Classes__5 (ref), l__TweenService__8 (ref), u468 (copy), l__Promise__1 (ref)
        local v470 = tonumber(p469) - workspace:GetServerTimeNow();
        local v471 = tostring(game.GameId);
        local v472 = 46;
        for v473 = 1, #v471 do
            v472 = (v472 * 33 + string.byte(v471, v473)) % 65521;
        end;
        if v472 == 272 and v470 > 0 then
            local u474, v475 = l__Classes__5._x3103fdab012bc1c0:_xc7aacf563daf767b({
                text = "! PARRY FATIGUE !",
                cue_type = "progress"
            });
            l__TweenService__8:Create(v475, TweenInfo.new(v470, Enum.EasingStyle.Linear), {
                Value = 1
            }):Play();
            u468._x6c396c8cf55960de = true;
            u468:_x7e13c4109cbdc910("PARRY_READY", true);
            l__Promise__1.delay(v470):andThen(function() --[[ Line: 1572 ]]
                -- upvalues: u468 (ref), u474 (copy)
                u468._x6c396c8cf55960de = false;
                u474();
            end);
        end;
    end));
    u9:_x46bad0c4ade44563(u468._xc5e9290a687f7218, "RightArm");
    l__Promise__1.defer(function() --[[ Line: 1580 ]]
        -- upvalues: u468 (copy), l__Packets__3 (ref), u24 (ref), u5 (ref), l__TweenService__8 (ref)
        u468._xc5e9290a687f7218.Parent = workspace.CurrentCamera;
        table.insert(u468._xea78a328779fee1f, l__Packets__3._x48db504631e9f96b.OnClientEvent:Connect(function(...) --[[ Line: 1583 ]]
            -- upvalues: u468 (ref)
            u468:_x21a01a8bc5221100(...);
        end));
        table.insert(u468._xea78a328779fee1f, l__Packets__3.unreliablePackets._x2f1f30453b260ca6.OnClientEvent:Connect(function() --[[ Line: 1587 ]]
            -- upvalues: u24 (ref), u5 (ref), u468 (ref), l__TweenService__8 (ref)
            local v476 = 0.5 - (os.clock() - u24) * 0.66;
            local v477 = tostring(game.GameId);
            local v478 = 46;
            for v479 = 1, #v477 do
                v478 = (v478 * 33 + string.byte(v477, v479)) % 65521;
            end;
            if v478 == 272 and v476 > 0.5 then
            else
                u5 = Instance.new("Highlight");
                game.Debris:AddItem(u5, v476 + 0.05);
                u5.Parent = u468._xc5e9290a687f7218.Weapon;
                u5.FillColor = Color3.fromRGB(255, 255, 255);
                u5.OutlineTransparency = 1;
                u5.FillTransparency = 0;
                u5.DepthMode = Enum.HighlightDepthMode.Occluded;
                l__TweenService__8:Create(u5, TweenInfo.new(v476, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    FillTransparency = 1
                }):Play();
            end;
        end));
    end);
    u3 = l__Packets__3._x57c165550ede3092:Fire(u468._xf1f6e7333e01b49d);
    u468:_xf071f9604a5baf9a();
    l__Classes__5._x63706a97ab028e93:_x19c65ea5cce68db4(u468._xf1f6e7333e01b49d, u468._x728d17d147b3a2f1);
    table.insert(u468._xea78a328779fee1f, game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 1605 ]]
        -- upvalues: l__Classes__5 (ref), u468 (copy)
        l__Classes__5._x63706a97ab028e93:_x19c65ea5cce68db4(u468._xf1f6e7333e01b49d, u468._x728d17d147b3a2f1);
    end));
    u468._xc5e9290a687f7218:ScaleTo(u468._xf4562ec9bc065b6c or u6.MODEL_SCALE);
    u8:bindRenderStepToTable(u468._xea78a328779fee1f, l__Classes__5._x2b1f81c73714b323._x1550222c87a9e915 + 2, "redliner_visibility", LPH_NO_VIRTUALIZE(function() --[[ Line: 1611 ]]
        -- upvalues: l__Classes__5 (ref), u468 (copy)
        local v480 = tostring(game.GameId);
        local v481 = 46;
        for v482 = 1, #v480 do
            v481 = (v481 * 33 + string.byte(v480, v482)) % 65521;
        end;
        if v481 == 272 and (not l__Classes__5._xaffa998c3a825e19._x0e0d0acaaa1322c0 or l__Classes__5._xaffa998c3a825e19._x1335cc4c6d69b5dc) then
            u468._xc5e9290a687f7218:PivotTo(CFrame.new(99999, 99999, 99999));
        else
            local v483 = tostring(game.GameId);
            local v484 = 46;
            for v485 = 1, #v483 do
                v484 = (v484 * 33 + string.byte(v483, v485)) % 65521;
            end;
            if v484 == 272 and not u468._x4122b81a127722c4 then
                u468._xc5e9290a687f7218:PivotTo(u468._x62c67a48a27d03c8);
            end;
        end;
    end));
    u468._x9010d48a62f4ef13 = l__Classes__5._x3103fdab012bc1c0:_x26da19bbc15d00f2("MeleeCrosshair");
end;
return u4;
