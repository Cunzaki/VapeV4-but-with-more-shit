-- Decompiled from: Start.Client.ItemData.Melee._xaa9f8acded4f50b4
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
local u20 = task.spawn(function() --[[ Line: 40 ]] end);
local u21 = task.spawn(function() --[[ Line: 41 ]] end);
local u22 = task.spawn(function() --[[ Line: 42 ]] end);
local u23 = false;
local u24 = 0;
local u25 = {};
local u26 = CFrame.new();
local u27 = Random.new();
local u36 = LPH_JIT_MAX(function(p28, p29, p30, p31, p32) --[[ Line: 55 ]]
    -- upvalues: u8 (ref)
    local v33 = math.min(p29, p30);
    local v34 = math.max(p29, p30);
    local v35 = math.clamp(p28, v33, v34);
    if v35 > 0 then
        return u8:numLerp(0, p32, (u8:convNumRange(v35, 0, p30, 0, 1)));
    else
        return u8:numLerp(0, p31, (u8:convNumRange(v35, p29, 0, 1, 0)));
    end;
end);
function u4._xc091da12abbfb546(_) --[[ Line: 67 ]]
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
function u4._x90d4581ac99dd483(p37) --[[ Line: 80 ]]
    -- upvalues: l__Classes__5 (copy), u4 (copy), l__Instances__9 (copy)
    local v38 = p37 or l__Classes__5._x51bf23f1b9ed859b:_x5e63d412d07a8493(u4, script, "melee", "Redliner");
    local v39 = setmetatable({}, u4);
    v39._x4d3bf34322a1c779 = "Redliner";
    v39._x7b47345bff92786e = v38;
    local v40;
    if v38 then
        v40 = v38.animations;
    else
        v40 = v38;
    end;
    v39._x02117f18592d2969 = v40;
    local v41;
    if v38 then
        v41 = v38.animations_3p;
    else
        v41 = v38;
    end;
    v39._xedb2653e48fcba49 = v41;
    local v42 = v38 and v38.params;
    if v42 then
        v42 = v38.params.model_scale;
    end;
    v39._x7214c747228d16cf = v42;
    v39._x5fc464bc7c353b05 = {};
    v39._x5b2bf231942f08fa = {};
    v39._xe5a6abb4ed229331 = false;
    v39._xbbe7ab002fc2768b = false;
    v39._xbfc2fd04e9532c31 = 0;
    v39._xf489083a4af63c40 = CFrame.new();
    v39._x40ea8a7650a021e2 = {};
    v39._xd922d3e0aa4c9306 = 1;
    v39._xdca31d4244f207fa = v38 and v38.model or l__Instances__9.Redliner:Clone();
    v39._x905cdb18b06baf7f = v39._xdca31d4244f207fa.AnimationController.Animator;
    v39._x7c9324b01cf87024 = false;
    local v43 = Instance.new("Highlight");
    v43.FillTransparency = 1;
    v43.OutlineTransparency = 1;
    v43.DepthMode = Enum.HighlightDepthMode.Occluded;
    v43.FillColor = Color3.fromRGB(255, 255, 255);
    v43.Parent = v39._xdca31d4244f207fa.Weapon;
    v39._x45ea5ed590624ac8 = v43;
    v39._x6c4729327b11b476 = { v39._xdca31d4244f207fa.Weapon:FindFirstChild("NeonPart1", true) };
    v39._x9fee7bcb123703b7 = CFrame.new();
    v39._x217aeb0aea48aae2 = CFrame.new();
    v39._xe6d765640436bd41 = CFrame.new();
    v39._x056b78c4b6229ef3 = CFrame.new();
    v39._x505af8939b3dbe31 = CFrame.new();
    v39._xb98bdaabd176e2cc = CFrame.new();
    v39._xe43ccb4932c00cd2 = CFrame.new();
    v39._x8bd3d06433352c65 = 0;
    v39._xaaa86afc953fac9f = 0;
    v39._x01eecb2b48cff917 = 0;
    v39._x4c1db4420b3b0f09 = "reset";
    v39._xbb46fa3a981206ba = false;
    v39._x2a67820e84edcb4d = nil;
    v39._x4f326c90f85bc596 = nil;
    v39._xa4a3c5f1d8be9b5f = false;
    v39._x94200073de4a8617 = false;
    v39._xaa3614b569352b7e = 0;
    v39._x29b70d7fd945e6fe = {
        EQUIP_TIME = 0.5,
        ATTACK_TIMEOUT = 0.65,
        CHARGE_ATTACK_TIME = 0.5,
        CHARGE_ATTACK_COST = 2
    };
    v39._xce7312025a7f2a9a = table.freeze({
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
    return v39;
end;
function u4._xe7b1d327f3522d85(p44, p45, p46, p47) --[[ Line: 213 ]]
    -- upvalues: l__Classes__5 (copy), u14 (ref)
    return l__Classes__5._x51bf23f1b9ed859b:_xc782ad79ba49be57(p44._x7b47345bff92786e, u14, p45, p46, p47);
end;
function u4._x234304bda3fb9857(p48, p49, ...) --[[ Line: 217 ]]
    -- upvalues: l__Classes__5 (copy)
    return l__Classes__5._x51bf23f1b9ed859b:_x1e643afd7367aa17(p48._x7b47345bff92786e, p49, ...);
end;
function u4._x0cda07b8bd2ab5ec(p50) --[[ Line: 221 ]]
    return (p50._xdca31d4244f207fa.Weapon.Handle.From.WorldPosition - p50._xdca31d4244f207fa.Weapon.Handle.To.WorldPosition).Unit;
end;
function u4._xe4e131028b00eb5a(p51) --[[ Line: 228 ]]
    p51:_x34214aa304bc6e1d();
    p51._xbbe7ab002fc2768b = true;
    p51._xbfc2fd04e9532c31 = p51._xbfc2fd04e9532c31 + 1;
    local l___xbfc2fd04e9532c31__10 = p51._xbfc2fd04e9532c31;
    p51:_x94f8c38ee76a40b7(l___xbfc2fd04e9532c31__10);
    p51:_x4d646f3b007d67b6(l___xbfc2fd04e9532c31__10);
end;
function u4._x94f8c38ee76a40b7(u52, u53) --[[ Line: 237 ]]
    -- upvalues: u26 (copy), l__Promise__1 (copy), l__Classes__5 (copy), l__RunService__7 (copy), u13 (ref), u10 (ref), u12 (ref), u6 (ref), u8 (ref), u27 (copy), u9 (ref), u11 (ref), u7 (ref), u36 (copy)
    local u54 = u26;
    local u55 = 0;
    u52:_xfd6946570a7c8e7e(false);
    l__Promise__1.defer(function() --[[ Line: 242 ]]
        -- upvalues: u52 (copy), u53 (copy), l__Classes__5 (ref)
        if u52:_xf6542255ee73bbaa(u53) then
            u52._xdca31d4244f207fa.Parent = workspace.CurrentCamera;
            u52:_xfd6946570a7c8e7e(true);
            u52:_x0321ee2667dead9b(0);
            l__Classes__5._x64f8d2b27adbc0f7:_x3fe04ae6a44f82de();
            u52:_xf71325ce4aad91f4(l__Classes__5._x64f8d2b27adbc0f7:_xd009baa5e5683b01());
        end;
    end);
    table.insert(u52._x5fc464bc7c353b05, l__RunService__7.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(p56) --[[ Line: 254 ]]
        -- upvalues: u52 (copy), u13 (ref), u10 (ref), u12 (ref), u6 (ref), u8 (ref), u27 (ref), u9 (ref), u26 (ref), u11 (ref), u7 (ref), u54 (ref), u36 (ref), u55 (ref), l__Classes__5 (ref)
        if u52.velocity == u52.velocity then
            if u13.SlideLoop then
                local l__Magnitude__11 = u10._x1d287c838240a901.Magnitude;
                if u12._xa822f9aecc59b964 and u10._x8500fad561a4bbc9 then
                    local v57 = math.clamp(l__Magnitude__11, u6.SLIDE_LOWER_BOUND, u6.SLIDE_UPPER_BOUND);
                    local v58 = u8:convNumRange(v57, u6.SLIDE_LOWER_BOUND, u6.SLIDE_UPPER_BOUND, u6.SLIDE_MIN_ANIM_SPEED, u6.SLIDE_MAX_ANIM_SPEED);
                    local v59 = u8:convNumRange(v57, u6.SLIDE_LOWER_BOUND, u6.SLIDE_UPPER_BOUND, u6.SLIDESHAKE_MIN, u6.SLIDESHAKE_MAX);
                    local v60 = u27:NextNumber(-v59, v59);
                    u13.SlideLoop:AdjustSpeed(u8:easeInCubic(v58));
                    u52._xb98bdaabd176e2cc = u52._xb98bdaabd176e2cc:Lerp(u9:_x673cf961d3c48621(v60, 0.01, 0.03, 0.003), 0.5);
                else
                    u13.SlideLoop:AdjustSpeed(0);
                    u52._xb98bdaabd176e2cc = u52._xb98bdaabd176e2cc:Lerp(u26, 0.5);
                end;
            end;
            u52._xd922d3e0aa4c9306 = math.clamp(u52._xd922d3e0aa4c9306 + p56 * 0.08, 0.85, 1);
            local l___x698d7df6fb2f7f8d__12 = u11._x698d7df6fb2f7f8d;
            if l___x698d7df6fb2f7f8d__12 then
                l___x698d7df6fb2f7f8d__12 = u11._x02c535481ceb65a2;
            end;
            local l__Walldrop__13 = u13.Walldrop;
            if l___x698d7df6fb2f7f8d__12 and (u11._x53d97d9b33a9c094 and not l__Walldrop__13.IsPlaying) then
                l__Walldrop__13:Play(0, 1, 1);
            elseif l___x698d7df6fb2f7f8d__12 and (l__Walldrop__13.IsPlaying and (not u11._x53d97d9b33a9c094 or u11._x91fc77a25c1cec20)) then
                l__Walldrop__13:Stop();
            end;
            local l___xa822f9aecc59b964__14 = u12._xa822f9aecc59b964;
            if l___xa822f9aecc59b964__14 then
                if u12._xbe750e9d3cca427c > u7.CHARGE_ATTACK_TIME and os.clock() - u52._xaa3614b569352b7e > u7.CHARGE_ATTACK_TIME then
                    l___xa822f9aecc59b964__14 = u10._xa2a90f9baae72ac5 > u7.CHARGE_ATTACK_COST;
                else
                    l___xa822f9aecc59b964__14 = false;
                end;
            end;
            if l___xa822f9aecc59b964__14 then
                if not u52._x94200073de4a8617 then
                    u52._x94200073de4a8617 = true;
                    u52:_xe7b1d327f3522d85("READIED", true);
                    u52:_xe7b1d327f3522d85("CUE2", true);
                    u52._x45ea5ed590624ac8.FillTransparency = 0.7;
                end;
            else
                u52._x94200073de4a8617 = false;
                u52._x45ea5ed590624ac8.FillTransparency = 1;
            end;
            local l__CFrame__15 = workspace.CurrentCamera.CFrame;
            local v61, v62 = l__CFrame__15:ToObjectSpace(u54):ToOrientation();
            local v63 = l__CFrame__15:VectorToObjectSpace(u10._x1d287c838240a901);
            local v64 = math.clamp(-v63.X, u6.VEL_X_LOWER_BOUND, u6.VEL_X_UPPER_BOUND);
            local v65 = math.clamp(-v63.Y, u6.VEL_Y_LOWER_BOUND, u6.VEL_Y_UPPER_BOUND);
            local v66 = math.clamp(-v63.Z, u6.VEL_Z_LOWER_BOUND, u6.VEL_Z_UPPER_BOUND);
            local v67 = u36(v64, u6.VEL_X_LOWER_BOUND, u6.VEL_X_UPPER_BOUND, u6.VEL_LEFT_OFFSET, u6.VEL_RIGHT_OFFSET);
            local v68 = u36(v65, u6.VEL_Y_LOWER_BOUND, u6.VEL_Y_UPPER_BOUND, u6.VEL_DOWN_OFFSET, u6.VEL_UP_OFFSET);
            local v69 = u36(v66, u6.VEL_Z_LOWER_BOUND, u6.VEL_Z_UPPER_BOUND, u6.VEL_FORWARD_OFFSET, u6.VEL_BACKWARD_OFFSET);
            u54 = l__CFrame__15;
            u52._x217aeb0aea48aae2 = u52._x217aeb0aea48aae2:Lerp(CFrame.Angles(math.sin(v61) * u6.SWAY_AMOUNT, math.sin(v62) * u6.SWAY_AMOUNT, 0), 0.15);
            u52._xe6d765640436bd41 = u52._xe6d765640436bd41:Lerp(CFrame.new(v67, v68, v69), 0.15);
            local _, v70 = l__CFrame__15:ToOrientation();
            local v71 = math.deg((v70 - u55 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793);
            local v72 = (u10._x8c912a44b28c4237 - v71 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
            local v73 = math.abs(v72);
            local l__STRAFE_SWEET_SPOT__16 = u6.STRAFE_SWEET_SPOT;
            local l__STRAFE_DEADZONE__17 = u6.STRAFE_DEADZONE;
            local v74 = 0;
            u55 = v70;
            if l__STRAFE_DEADZONE__17 ~= l__STRAFE_SWEET_SPOT__16 then
                if v73 <= l__STRAFE_SWEET_SPOT__16 then
                    v74 = u6.STRAFE_ROTATION;
                elseif v73 < l__STRAFE_DEADZONE__17 then
                    local v75 = (v73 - l__STRAFE_SWEET_SPOT__16) / (l__STRAFE_DEADZONE__17 - l__STRAFE_SWEET_SPOT__16);
                    v74 = u6.STRAFE_ROTATION * (v72 > 0 and 1 - v75 * v75 or 1 - v75);
                end;
            end;
            local l__Held__18 = l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("RIGHT").Held;
            local l__Held__19 = l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("LEFT").Held;
            u52._x505af8939b3dbe31 = u52._x505af8939b3dbe31:Lerp(CFrame.Angles(0, 0, (l___x698d7df6fb2f7f8d__12 or l__Held__18 and l__Held__19) and 0 or (l__Held__18 and (not u10._x5242295569714a31 and v73 > 0.3) and -v74 or ((not l__Held__19 or (u10._x5242295569714a31 or (v73 <= 0.3 or not v74))) and 0 or v74))), 0.06);
            if l___x698d7df6fb2f7f8d__12 and not (u52._xbb46fa3a981206ba or u52._xa4a3c5f1d8be9b5f) then
                local v76, v77 = u9:_xc556bd7165b71d2d("right");
                local v78 = v76 ~= v76 and 0 or v76;
                local v79 = math.clamp(u10._x1d287c838240a901.Y, u6.WALLRIDE_Y_LOWER_BOUND, u6.WALLRIDE_Y_UPPER_BOUND);
                local v80 = u6.WALLRIDE_Y_UPPER_BOUND - u6.WALLRIDE_Y_LOWER_BOUND;
                local v81 = v80 == 0 and u6.WALLRIDE_MIN_PITCH or (v79 - u6.WALLRIDE_Y_LOWER_BOUND) / v80 * (u6.WALLRIDE_MAX_PITCH - u6.WALLRIDE_MIN_PITCH) + u6.WALLRIDE_MIN_PITCH;
                local v82 = CFrame.Angles(v81, 0, v81);
                local v83;
                if v77.Y < u6.WALLRIDE_ARM_TURN_POINT then
                    local v84 = math.clamp(v78, 0, u6.WALLRIDE_MAX_FORWARD_ANGLE);
                    v83 = -math.rad(v84);
                else
                    local v85 = math.clamp(v78, 0, u6.WALLRIDE_MAX_BACKWARD_ANGLE);
                    v83 = math.rad(v85);
                end;
                u52._x9fee7bcb123703b7 = u52._x9fee7bcb123703b7:Lerp(CFrame.Angles(0, v83, 0), 0.15) * v82;
            else
                u52._x9fee7bcb123703b7 = u52._x9fee7bcb123703b7:Lerp(u26, 6 * p56);
            end;
        end;
    end)));
    u8:bindRenderStepToTable(u52._x5fc464bc7c353b05, l__Classes__5._x32ae459de0772e82._x8ff5d6204140ad8b + 1, "redliner_viewmodel", LPH_NO_VIRTUALIZE(function() --[[ Line: 359 ]]
        -- upvalues: u9 (ref), u52 (copy), u6 (ref)
        u9:_x9ad3e8b8be11532e(u52._xdca31d4244f207fa);
        local v86;
        if u52._xbb46fa3a981206ba then
            v86 = u6.BASE_OFFSET_ATTACKING;
        else
            v86 = u6.BASE_OFFSET;
        end;
        u52._xdca31d4244f207fa:PivotTo(workspace.CurrentCamera.CFrame * v86 * u6.BASE_ROTATION * u52._x9fee7bcb123703b7 * u52._x217aeb0aea48aae2 * u52._xe6d765640436bd41 * u52._x505af8939b3dbe31 * u52._xb98bdaabd176e2cc * u52._xe43ccb4932c00cd2);
    end));
end;
function u4._xf6542255ee73bbaa(p87, p88) --[[ Line: 374 ]]
    local l___xbbe7ab002fc2768b__20 = p87._xbbe7ab002fc2768b;
    if l___xbbe7ab002fc2768b__20 then
        l___xbbe7ab002fc2768b__20 = p87._xbfc2fd04e9532c31 == p88;
    end;
    return l___xbbe7ab002fc2768b__20;
end;
function u4._x0321ee2667dead9b(_, p89) --[[ Line: 378 ]]
    -- upvalues: u13 (ref)
    local l__Idle__21 = u13.Idle;
    if l__Idle__21 then
        if l__Idle__21.IsPlaying then
            l__Idle__21:AdjustSpeed(1);
            l__Idle__21:AdjustWeight(1, p89 or 0);
        else
            l__Idle__21:Play(p89 or 0, 1, 1);
        end;
    end;
end;
function u4._xe4530e0ae6777dbd(p90, p91, p92, p93) --[[ Line: 389 ]]
    -- upvalues: u13 (ref)
    local v94 = p90._x905cdb18b06baf7f:GetPlayingAnimationTracks();
    local v95 = {
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
    if p93 then
        table.move(p93, 1, #p93, #v95 + 1, v95);
    end;
    if v94 then
        for _, v96 in v94 do
            if v96 ~= p91 and not table.find(v95, v96) then
                v96:AdjustWeight(0, p92);
            end;
        end;
    end;
    if table.find(v94, p91) then
        p91:AdjustWeight(1, p92);
    else
        p91:Play(p92, 1);
    end;
end;
function u4._xf71325ce4aad91f4(p97, p98) --[[ Line: 410 ]]
    -- upvalues: u13 (ref), u11 (ref), l__Classes__5 (copy), l__Promise__1 (copy)
    if u13.SlideLoop then
        local l__main__22 = p98.main;
        local l__previous__23 = p98.previous;
        local l__context__24 = p98.context;
        local l__previous_context__25 = p98.previous_context;
        local l__corresponding_played__26 = p98.corresponding_played;
        if not u11._x698d7df6fb2f7f8d then
            u13.WallrideLoop:AdjustWeight(0.001);
        end;
        if l__main__22 == "sliding" then
            if not l__corresponding_played__26 and (not p97._xbb46fa3a981206ba and os.clock() - p98.timestamp < 0.1) then
                p97:_xe4530e0ae6777dbd(u13.SlideStart, 0.1);
                l__Classes__5._x64f8d2b27adbc0f7:_xbf06ccdc4b35dfcd();
            end;
            p97:_xe4530e0ae6777dbd(u13.SlideLoop, 0.1, { u13.SlideStart, u13.SlideRecovery });
        elseif l__main__22 == "wallriding" then
            if l__context__24 == "right" then
                if u13.SlideEnd.IsPlaying then
                    u13.SlideEnd:Stop();
                end;
                p97:_xe4530e0ae6777dbd(u13.WallrideLoop, 0.1);
            else
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.15);
            end;
        elseif l__main__22 == "running" then
            if l__previous__23 == "idle" then
                p97:_xe4530e0ae6777dbd(u13.Run, 0.3);
            else
                p97:_xe4530e0ae6777dbd(u13.Run, 0.15);
            end;
        elseif l__main__22 == "idle" then
            if l__previous__23 == "running" then
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.2);
            else
                u13.Idle:AdjustWeight(1);
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.2, { u13.Walldrop });
            end;
        elseif l__main__22 == "falling" then
            if l__context__24 == "wallkick_right" then
                p97:_xe4530e0ae6777dbd(u13.Wallkick, 0.03);
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.1, { u13.Wallkick });
                l__Promise__1.defer(function() --[[ Line: 462 ]]
                    -- upvalues: l__Classes__5 (ref)
                    l__Classes__5._x64f8d2b27adbc0f7:_x5daee86d2092aec1();
                end);
            elseif l__previous__23 == "wallriding" and l__previous_context__25 == "right" then
                u13.Idle:AdjustWeight(0.01);
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.1, { u13.Walldrop });
            else
                u13.Idle:AdjustWeight(0.01);
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.1, { u13.Walldrop });
            end;
        elseif l__main__22 == "dashing" then
            if l__context__24 == "lunge_right" then
                p97:_xe4530e0ae6777dbd(u13.Wallkick, 0.03);
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.1, { u13.Wallkick });
                l__Promise__1.defer(function() --[[ Line: 479 ]]
                    -- upvalues: l__Classes__5 (ref)
                    l__Classes__5._x64f8d2b27adbc0f7:_x5daee86d2092aec1();
                end);
            else
                p97:_xe4530e0ae6777dbd(u13.Idle, 0.15);
            end;
        else
            p97:_xe4530e0ae6777dbd(u13.Idle, 0.1);
        end;
        if l__previous__23 == "sliding" then
            u13.SlideEnd:Play(0.1);
            l__Classes__5._x64f8d2b27adbc0f7:_xe4db8187bf6fa86d();
        end;
    end;
end;
function u4._x18da794854d4ae00(p99) --[[ Line: 496 ]]
    -- upvalues: u16 (ref), u15 (ref), u10 (ref), l__Classes__5 (copy)
    local v100 = not (u16 or u15) and (u10._xbcaafe2ed14862c8 and not l__Classes__5._x7430d6d194f43373._x7176ea97549fd9b6.is_breaking);
    if v100 then
        v100 = not p99._x7c9324b01cf87024;
    end;
    return v100;
end;
function u4._xc3837e3fd8cfd093(u101) --[[ Line: 500 ]]
    -- upvalues: l__Classes__5 (copy), u10 (ref), l__TweenService__8 (copy), l__Packets__3 (copy), u3 (ref), u17 (ref), l__Promise__1 (copy), u13 (ref), u24 (ref), u25 (copy), u16 (ref), u15 (ref), u21 (ref), l__Easer__2 (copy), u18 (ref)
    if not u101:_x18da794854d4ae00() then
        return false;
    end;
    local function u114() --[[ Line: 502 ]]
        -- upvalues: l__Classes__5 (ref), u10 (ref), l__TweenService__8 (ref), l__Packets__3 (ref), u3 (ref), u101 (copy)
        local function v112() --[[ Line: 503 ]]
            -- upvalues: l__Classes__5 (ref), u10 (ref), l__TweenService__8 (ref)
            local _ = l__Classes__5._x7430d6d194f43373;
            local v102 = {};
            local v103 = nil;
            for v104, v105 in l__Classes__5._xafc4950d7b094088._xe47bf301ff0f8f5e do
                if v105.indicator_type == "surefire_bullet" then
                    local l__parry_range__27 = v105.parry_range;
                    local v106 = u10._xbcaafe2ed14862c8:FindFirstChild("Head") and u10._xbcaafe2ed14862c8.Head.Position or u10._xbcaafe2ed14862c8.PrimaryPart.Position;
                    local v107 = v104:FindFirstChild("Head") and v104.Head.Position or (v104.PrimaryPart and v104.PrimaryPart.Position or v104:GetPivot().Position);
                    local v108 = 1 - (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit:Dot(((v107 - v106) * Vector3.new(1, 0, 1)).Unit);
                    if math.abs(v108) <= l__parry_range__27 then
                        v102[v104] = true;
                        if v103 then
                            if v105.expected_shot_time < v103.expected_shot_time then
                                v103 = v105;
                            end;
                        else
                            v103 = v105;
                        end;
                    end;
                end;
            end;
            if v103 then
                local l__indicator_ui__28 = v103.indicator_ui;
                local l__RightSuccess__29 = l__indicator_ui__28.ParryRange.RightClip.RightSuccess;
                local l__LeftSuccess__30 = l__indicator_ui__28.ParryRange.LeftClip.LeftSuccess;
                l__RightSuccess__29.ImageTransparency = 0;
                l__LeftSuccess__30.ImageTransparency = 0;
                local v109 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
                local v110 = l__TweenService__8:Create(l__RightSuccess__29, v109, {
                    ImageTransparency = 1
                });
                local v111 = l__TweenService__8:Create(l__LeftSuccess__30, v109, {
                    ImageTransparency = 1
                });
                v110:Play();
                v111:Play();
                table.insert(v103.parry_tweens, v110);
                table.insert(v103.parry_tweens, v111);
            end;
            return v102;
        end;
        local v113 = tostring(workspace:GetServerTimeNow());
        local l___x9a2cccdf85bd7596__31 = l__Classes__5._xd1706540247308ea._x9a2cccdf85bd7596;
        l___x9a2cccdf85bd7596__31.timestamp = v113;
        l___x9a2cccdf85bd7596__31.direction_faced = workspace.CurrentCamera.CFrame.LookVector;
        l___x9a2cccdf85bd7596__31.cam_location = workspace.CurrentCamera.CFrame.Position;
        l___x9a2cccdf85bd7596__31.faced_shooters = v112();
        l__Packets__3._x0cdd43b25777bec6:Fire(u3, u101._x850fb72bedc0eacc, "redliner_parry", { l___x9a2cccdf85bd7596__31 });
    end;
    u17 = l__Promise__1.new(function(u115, _, p116) --[[ Line: 567 ]]
        -- upvalues: u13 (ref), u114 (copy), l__Classes__5 (ref), u24 (ref), u25 (ref), u101 (copy), u16 (ref), u15 (ref), u21 (ref), l__Easer__2 (ref)
        for _, v117 in {
            u13.Parry,
            u13.Recovery,
            u13.SlideRecovery,
            u13.ParrySuccess
        } do
            v117:Stop(0.001);
        end;
        u114();
        l__Classes__5._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Parry", {
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
        for _, v118 in u25 do
            v118:Cancel();
        end;
        for _, v119 in u101._x6c4729327b11b476 do
            v119.Color = Color3.fromRGB(70, 70, 70);
        end;
        u16 = true;
        u15 = true;
        u101:_xe7b1d327f3522d85("PARRY_READY2", true);
        u13.Parry:Play(0);
        u101._xa4a3c5f1d8be9b5f = true;
        task.delay(0.5, function() --[[ Line: 589 ]]
            -- upvalues: u101 (ref)
            u101._xa4a3c5f1d8be9b5f = false;
        end);
        u21 = task.delay(0.8, function() --[[ Line: 593 ]]
            -- upvalues: u15 (ref)
            u15 = false;
        end);
        local v120 = {
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
        local v121 = {
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
        local v122 = {
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
        l__Classes__5._x32ae459de0772e82:_xccb12ea9ca4915a6({ v120, v121, v122 });
        local u123 = task.delay(0.64, function() --[[ Line: 655 ]]
            -- upvalues: u115 (copy)
            u115();
        end);
        p116(function() --[[ Line: 659 ]]
            -- upvalues: u123 (copy)
            task.cancel(u123);
        end);
    end);
    u17:andThen(function() --[[ Line: 664 ]]
        -- upvalues: u13 (ref), u18 (ref), l__Promise__1 (ref), u101 (copy), u16 (ref), l__TweenService__8 (ref), u25 (ref)
        u13.Parry:Stop(0.001);
        u18 = l__Promise__1.new(function(u124, _, p125) --[[ Line: 666 ]]
            -- upvalues: u101 (ref), u13 (ref), u16 (ref), l__TweenService__8 (ref), u25 (ref)
            u101:_x9c8a0b4285c0053d(u13.Parry);
            local u128 = task.delay(0.1, function() --[[ Line: 669 ]]
                -- upvalues: u16 (ref), u124 (copy), u101 (ref), l__TweenService__8 (ref), u25 (ref)
                u16 = false;
                u124();
                for _, u126 in u101._x6c4729327b11b476 do
                    task.defer(function() --[[ Line: 673 ]]
                        -- upvalues: l__TweenService__8 (ref), u126 (copy), u25 (ref)
                        local v127 = l__TweenService__8:Create(u126, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                            Color = Color3.fromRGB(165, 165, 165)
                        });
                        v127:Play();
                        table.insert(u25, v127);
                        v127.Completed:Wait();
                        table.remove(u25, table.find(u25, v127));
                    end);
                end;
            end);
            p125(function() --[[ Line: 683 ]]
                -- upvalues: u128 (copy)
                task.cancel(u128);
            end);
        end);
    end);
    return true;
end;
function u4._xab79d02d40d58c0e(u129) --[[ Line: 692 ]]
    -- upvalues: u15 (ref), l__Classes__5 (copy), l__Promise__1 (copy), u13 (ref), l__Easer__2 (copy), l__Attack__4 (copy), u10 (ref), l__Packets__3 (copy), u3 (ref), u7 (ref), u12 (ref), u23 (ref)
    if u15 or l__Classes__5._x7430d6d194f43373._x7176ea97549fd9b6.is_breaking then
    else
        u15 = true;
        l__Promise__1.delay(0.5):andThen(function() --[[ Line: 696 ]]
            -- upvalues: u15 (ref)
            u15 = false;
        end);
        local function v145(p130, p131) --[[ Line: 700 ]]
            -- upvalues: u13 (ref), l__Classes__5 (ref), u129 (copy), l__Easer__2 (ref)
            local v132 = nil;
            if p130 == u13.Attack1 then
                l__Classes__5._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("LAttack", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "RAttack",
                        "CAttack"
                    }
                });
                u129:_xe7b1d327f3522d85("SWING", true);
                u129:_xe7b1d327f3522d85("REDLINER_MELEE", true);
                local v133 = {
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
                local v134 = {
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
                local v135 = {
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
                v132 = { v133, v134, v135 };
            elseif p130 == u13.Attack2 then
                l__Classes__5._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("RAttack", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "LAttack",
                        "CAttack"
                    }
                });
                u129:_xe7b1d327f3522d85("SWING", true);
                u129:_xe7b1d327f3522d85("REDLINER_MELEE", true);
                local v136 = {
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
                local v137 = {
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
                local v138 = {
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
                v132 = { v136, v137, v138 };
            elseif p130 == u13.SlideAttack and p131 then
                l__Classes__5._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("CAttack", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "LAttack",
                        "RAttack"
                    }
                });
                u129:_xe7b1d327f3522d85("SLASH_GASH", true);
                u129:_xe7b1d327f3522d85("SWING_HEAVY", true);
                local v139 = {
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
                local v140 = {
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
                local v141 = {
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
                v132 = { v139, v140, v141 };
            elseif p130 == u13.SlideAttack then
                l__Classes__5._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("CAttack", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "RAttack",
                        "LAttack"
                    }
                });
                u129:_xe7b1d327f3522d85("SWING", true);
                u129:_xe7b1d327f3522d85("REDLINER_MELEE", true);
                local v142 = {
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
                local v143 = {
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
                local v144 = {
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
                v132 = { v142, v143, v144 };
            end;
            if v132 then
                l__Classes__5._x32ae459de0772e82:_xccb12ea9ca4915a6(v132);
            end;
        end;
        local function v155() --[[ Line: 924 ]]
            -- upvalues: l__Attack__4 (ref), l__Promise__1 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u129 (copy)
            local u146 = l__Attack__4.new(game.Players.LocalPlayer.Character, "redliner_melee");
            local u147 = u146:addHitbox({
                size = Vector3.new(14, 10, 22),
                offset = CFrame.new(0, 0, -11),
                origin = workspace.CurrentCamera.CFrame
            });
            l__Promise__1.new(function(u148, _, p149) --[[ Line: 935 ]]
                -- upvalues: l__Promise__1 (ref), u147 (copy), u146 (copy), u10 (ref), l__Packets__3 (ref), u3 (ref), u129 (ref)
                local u150 = {};
                local v152 = l__Promise__1.delay((0 / 0)):andThen(function() --[[ Line: 941 ]]
                    -- upvalues: u147 (ref), u146 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u129 (ref)
                    u147.origin = workspace.CurrentCamera.CFrame;
                    local v151 = u146:castOnce();
                    local l__Position__32 = (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -3)).Position;
                    l__Packets__3._xa20c1ad6e56c96e7:Fire(u3, u129._x850fb72bedc0eacc, "redliner_melee", l__Position__32, v151, u10._x1d287c838240a901.Magnitude);
                end);
                table.insert(u150, v152);
                local u153 = task.delay(0.01, function() --[[ Line: 952 ]]
                    -- upvalues: u148 (copy)
                    u148();
                end);
                p149(function() --[[ Line: 956 ]]
                    -- upvalues: u153 (copy), u150 (copy), u148 (copy)
                    task.cancel(u153);
                    for _, v154 in u150 do
                        v154:cancel();
                    end;
                    u148();
                end);
            end);
        end;
        local function v165() --[[ Line: 966 ]]
            -- upvalues: l__Attack__4 (ref), l__Promise__1 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u129 (copy)
            local u156 = l__Attack__4.new(game.Players.LocalPlayer.Character, "redliner_slide_melee");
            local u157 = u156:addHitbox({
                size = Vector3.new(16, 2, 22),
                offset = CFrame.new(0, -0.5, -11),
                origin = workspace.CurrentCamera.CFrame
            });
            l__Promise__1.new(function(u158, _, p159) --[[ Line: 977 ]]
                -- upvalues: l__Promise__1 (ref), u157 (copy), u156 (copy), u10 (ref), l__Packets__3 (ref), u3 (ref), u129 (ref)
                local u160 = {};
                local v162 = l__Promise__1.delay((0 / 0)):andThen(function() --[[ Line: 983 ]]
                    -- upvalues: u157 (ref), u156 (ref), u10 (ref), l__Packets__3 (ref), u3 (ref), u129 (ref)
                    u157.origin = workspace.CurrentCamera.CFrame;
                    local v161 = u156:castOnce();
                    local l__Position__33 = (workspace.CurrentCamera.CFrame * CFrame.new(0, -0.5, -4.5)).Position;
                    l__Packets__3._xa20c1ad6e56c96e7:Fire(u3, u129._x850fb72bedc0eacc, "redliner_slide_melee", l__Position__33, v161, u10._x1d287c838240a901.Magnitude);
                end);
                table.insert(u160, v162);
                local u163 = task.delay(0.01, function() --[[ Line: 994 ]]
                    -- upvalues: u158 (copy)
                    u158();
                end);
                p159(function() --[[ Line: 998 ]]
                    -- upvalues: u163 (copy), u160 (copy), u158 (copy)
                    task.cancel(u163);
                    for _, v164 in u160 do
                        v164:cancel();
                        u158();
                    end;
                end);
            end);
        end;
        local function v170() --[[ Line: 1008 ]]
            -- upvalues: l__Attack__4 (ref), u10 (ref), u7 (ref), u129 (copy), l__Packets__3 (ref), u3 (ref)
            local v166 = l__Attack__4.new(game.Players.LocalPlayer.Character, "redliner_slide_melee");
            local v167 = CFrame.new(0, -0.5, -20);
            local l__CFrame__34 = workspace.CurrentCamera.CFrame;
            v166:addHitbox({
                size = Vector3.new(35, 10, 35),
                offset = v167,
                origin = l__CFrame__34
            });
            local v168 = v166:castOnce();
            local v169 = l__CFrame__34 * v167;
            u10:_xe0837378305c062e(u7.CHARGE_ATTACK_COST);
            u129:_x234304bda3fb9857("swoopAttackClient", v169 * CFrame.new(0, -1, 0), workspace.CurrentCamera);
            local l__Position__35 = (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -15)).Position;
            l__Packets__3._xa20c1ad6e56c96e7:Fire(u3, u129._x850fb72bedc0eacc, "redliner_charged_melee", l__Position__35, v168, u10._x1d287c838240a901.Magnitude);
        end;
        for _, v171 in {
            u13.Attack1,
            u13.Attack2,
            u13.SlideAttack,
            u13.SlideRecovery,
            u13.Recovery,
            u13.Parry,
            u13.ParrySuccess
        } do
            v171:Stop(0.001);
        end;
        u129:_xfd6946570a7c8e7e(true);
        u129._xaa3614b569352b7e = os.clock();
        local v172 = nil;
        local u173;
        if u12._xa822f9aecc59b964 and u129._x94200073de4a8617 then
            u173 = u13.SlideAttack;
            u173:Play(0, 1);
            task.defer(v170);
            v172 = true;
        elseif u12._xa822f9aecc59b964 then
            u173 = u13.SlideAttack;
            u173:Play(0, 1);
            task.defer(v165);
        else
            if u129._x4c1db4420b3b0f09 == "reset" then
                if l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("LEFT").Held or u23 then
                    u173 = u13.Attack2;
                    u129._x4c1db4420b3b0f09 = "left";
                else
                    u173 = u13.Attack1;
                    u129._x4c1db4420b3b0f09 = "right";
                end;
            elseif u129._x4c1db4420b3b0f09 == "left" then
                u173 = u13.Attack1;
                u129._x4c1db4420b3b0f09 = "right";
            else
                u129._x4c1db4420b3b0f09 = "left";
                u173 = u13.Attack2;
            end;
            if u173 then
                u173:Play(0.001, 1);
            end;
            task.defer(v155);
        end;
        v145(u173, v172);
        u129._xbb46fa3a981206ba = true;
        if u129._x2a67820e84edcb4d then
            task.cancel(u129._x2a67820e84edcb4d);
        end;
        u129._x2a67820e84edcb4d = task.delay(u7.ATTACK_TIMEOUT, function() --[[ Line: 1105 ]]
            -- upvalues: l__Promise__1 (ref), u129 (copy), u173 (ref)
            l__Promise__1.defer(function() --[[ Line: 1106 ]]
                -- upvalues: u129 (ref)
                u129:_xfd6946570a7c8e7e(true);
            end);
            u129._xbb46fa3a981206ba = false;
            u129._x4c1db4420b3b0f09 = "reset";
            u129:_x9c8a0b4285c0053d(u173);
        end);
    end;
end;
function u4._x9c8a0b4285c0053d(_, p174) --[[ Line: 1115 ]]
    -- upvalues: u13 (ref), l__Easer__2 (copy), l__Classes__5 (copy), u12 (ref), l__Promise__1 (copy), u11 (ref)
    if u13.SlideStart then
        local v175 = {
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
        local v176 = {
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
        local v177 = {
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
        l__Classes__5._x32ae459de0772e82:_xccb12ea9ca4915a6({ v177, v176, v175 });
        if p174 then
            p174:Stop(0.001);
        end;
        if u13.SlideStart.IsPlaying then
            if u12._xa822f9aecc59b964 then
                u13.SlideStart:Stop();
            else
                u13.SlideStart:Stop(0.001);
            end;
        end;
        if u13.SlideEnd.IsPlaying then
            if u12._xa822f9aecc59b964 then
                u13.SlideEnd:Stop();
            else
                u13.SlideEnd:Stop(0.001);
            end;
        end;
        if u12._xa822f9aecc59b964 then
            u13.SlideRecovery:Play(0);
            l__Promise__1.defer(function() --[[ Line: 1186 ]]
                -- upvalues: u13 (ref), l__Promise__1 (ref)
                u13.SlideRecovery:AdjustWeight(1, 0);
                l__Promise__1.defer(function() --[[ Line: 1188 ]]
                    -- upvalues: u13 (ref)
                    u13.SlideRecovery:AdjustWeight(0.0001, 0.5);
                end);
            end);
        else
            if u11._x698d7df6fb2f7f8d and l__Classes__5._x64f8d2b27adbc0f7:_xd009baa5e5683b01().context == "right" then
                l__Promise__1.defer(function() --[[ Line: 1195 ]]
                    -- upvalues: u13 (ref), l__Promise__1 (ref)
                    u13.WallrideLoop:Play();
                    l__Promise__1.defer(function() --[[ Line: 1197 ]]
                        -- upvalues: u13 (ref)
                        u13.WallrideLoop:AdjustWeight(0.7);
                    end);
                end);
            end;
            u13.Recovery:Play(0);
            l__Promise__1.defer(function() --[[ Line: 1203 ]]
                -- upvalues: u13 (ref), l__Promise__1 (ref)
                u13.Recovery:AdjustWeight(1, 0);
                l__Promise__1.defer(function() --[[ Line: 1205 ]]
                    -- upvalues: u13 (ref)
                    u13.Recovery:AdjustWeight(0.0001, 0.5);
                end);
            end);
        end;
    end;
end;
function u4._x4d646f3b007d67b6(u178, u179) --[[ Line: 1212 ]]
    -- upvalues: l__Classes__5 (copy), u13 (ref), u8 (ref), u7 (ref), l__Promise__1 (copy), l__Easer__2 (copy)
    local l___x5fc464bc7c353b05__36 = u178._x5fc464bc7c353b05;
    local l__Pressed__37 = l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("MELEE").Pressed;
    table.insert(l___x5fc464bc7c353b05__36, l__Pressed__37:Connect(function() --[[ Line: 1213 ]]
        -- upvalues: u178 (copy)
        u178:_xab79d02d40d58c0e();
    end));
    local l___x5fc464bc7c353b05__38 = u178._x5fc464bc7c353b05;
    local l__Pressed__39 = l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("PARRY").Pressed;
    table.insert(l___x5fc464bc7c353b05__38, l__Pressed__39:Connect(function() --[[ Line: 1217 ]]
        -- upvalues: u178 (copy)
        u178:_xc3837e3fd8cfd093();
    end));
    table.insert(u178._x5fc464bc7c353b05, l__Classes__5._x64f8d2b27adbc0f7._x67783353828f3ace:Connect(function(p180) --[[ Line: 1221 ]]
        -- upvalues: u178 (copy)
        u178:_xf71325ce4aad91f4(p180);
    end));
    l__Classes__5._x64f8d2b27adbc0f7:_x3fe04ae6a44f82de();
    local u181;
    if l__Classes__5._x64f8d2b27adbc0f7:_xd009baa5e5683b01().main == "sliding" then
        u181 = u13.SlideRecovery;
    else
        u181 = u13.Recovery;
    end;
    if u181 then
        u181:Play(0, 1, u8:getAnimSpeedFromDuration(u181, u7.EQUIP_TIME));
    end;
    u178:_x0321ee2667dead9b(0);
    l__Promise__1.defer(function() --[[ Line: 1241 ]]
        -- upvalues: u178 (copy), u179 (copy), l__Easer__2 (ref), u7 (ref), l__Classes__5 (ref), u13 (ref), u181 (copy)
        if u178:_xf6542255ee73bbaa(u179) then
            (function() --[[ Name: equipCamera, Line 1246 ]]
                -- upvalues: l__Easer__2 (ref), u7 (ref), l__Classes__5 (ref)
                local v182 = {
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
                local v183 = {
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
                local v184 = {
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
                l__Classes__5._x32ae459de0772e82:_xccb12ea9ca4915a6({ v182, v183, v184 });
            end)();
            if u13.WallrideLoop then
                u13.WallrideLoop:AdjustWeight(0.7);
            end;
            if u181 then
                u181:AdjustWeight(0.0001, u7.EQUIP_TIME);
            end;
            u178:_x0321ee2667dead9b(0);
            l__Classes__5._x64f8d2b27adbc0f7:_x3fe04ae6a44f82de();
            u178:_xf71325ce4aad91f4(l__Classes__5._x64f8d2b27adbc0f7:_xd009baa5e5683b01());
            u178:_xfd6946570a7c8e7e(true);
            task.delay(u7.EQUIP_TIME, function() --[[ Line: 1309 ]]
                -- upvalues: u178 (ref), u179 (ref), u181 (ref), l__Classes__5 (ref)
                if u178:_xf6542255ee73bbaa(u179) and not (u178._xbb46fa3a981206ba or u178._xa4a3c5f1d8be9b5f) then
                    if u181 and u181.IsPlaying then
                        u181:Stop(0.001);
                    end;
                    u178:_x0321ee2667dead9b(0);
                    l__Classes__5._x64f8d2b27adbc0f7:_x3fe04ae6a44f82de();
                    u178:_xf71325ce4aad91f4(l__Classes__5._x64f8d2b27adbc0f7:_xd009baa5e5683b01());
                end;
            end);
        end;
    end);
end;
function u4._x3003385a15dc35f6(u185) --[[ Line: 1323 ]]
    -- upvalues: u9 (ref), u13 (ref)
    u9:_x3dcf9d89d527a087(u185._x905cdb18b06baf7f, u185._x40ea8a7650a021e2, u185._x02117f18592d2969);
    task.defer(function() --[[ Line: 1326 ]]
        -- upvalues: u13 (ref), u185 (copy)
        for _, v186 in { u13.Attack1, u13.Attack2, u13.SlideAttack } do
            local l___x5b2bf231942f08fa__40 = u185._x5b2bf231942f08fa;
            local v187 = v186:GetMarkerReachedSignal("AnimationEnd");
            table.insert(l___x5b2bf231942f08fa__40, v187:Connect(function() --[[ Line: 1329 ]]
                -- upvalues: u185 (ref)
                if u185._xbbe7ab002fc2768b and u185._xbb46fa3a981206ba then
                    u185:_xfd6946570a7c8e7e(false);
                end;
            end));
        end;
    end);
end;
function u4._xec659e3c2d76297c(p188) --[[ Line: 1338 ]]
    if p188._x2a67820e84edcb4d then
        task.cancel(p188._x2a67820e84edcb4d);
        p188._x2a67820e84edcb4d = nil;
    end;
end;
function u4._x34214aa304bc6e1d(p189) --[[ Line: 1345 ]]
    -- upvalues: u23 (ref)
    p189:_xec659e3c2d76297c();
    p189._xbb46fa3a981206ba = false;
    p189._xa4a3c5f1d8be9b5f = false;
    p189._x94200073de4a8617 = false;
    p189._x4c1db4420b3b0f09 = "reset";
    u23 = false;
    p189._x45ea5ed590624ac8.FillTransparency = 1;
end;
function u4._xfd6946570a7c8e7e(p190, p191) --[[ Line: 1355 ]]
    p190._xe5a6abb4ed229331 = p191;
    if p191 then
        p190._xf489083a4af63c40 = CFrame.new(0, 0, 0);
    else
        p190._xf489083a4af63c40 = CFrame.new(9999, 9999, 9999);
    end;
end;
function u4._x5de5406ab187a367(p192) --[[ Line: 1364 ]]
    -- upvalues: u8 (ref)
    p192._xbbe7ab002fc2768b = false;
    p192._xbfc2fd04e9532c31 = p192._xbfc2fd04e9532c31 + 1;
    p192:_x34214aa304bc6e1d();
    p192:_xfd6946570a7c8e7e(false);
    u8:stopAnimations(p192._x905cdb18b06baf7f);
    u8:cleanConnectionsTable(p192._x5fc464bc7c353b05);
end;
function u4.cleanUp(p193) --[[ Line: 1374 ]]
    -- upvalues: u8 (ref), l__Classes__5 (copy), u3 (ref), l__Packets__3 (copy), l__InternalSymbols__6 (copy)
    p193._xbbe7ab002fc2768b = false;
    p193._xbfc2fd04e9532c31 = p193._xbfc2fd04e9532c31 + 1;
    p193:_x34214aa304bc6e1d();
    u8:cleanConnectionsTable(p193._x5b2bf231942f08fa);
    l__Classes__5._x1ab1568e6fe5e07f:_xd66b27d3e48ff743(p193._x850fb72bedc0eacc);
    p193._xdca31d4244f207fa:Destroy();
    warn(string.format("%s CLEANED", p193._x4d3bf34322a1c779));
    u3 = nil;
    l__Packets__3._x334266a937df41a9:Fire(p193._x850fb72bedc0eacc);
    l__InternalSymbols__6.owner("", p193._x4f326c90f85bc596):cleanUp();
end;
function u4._xcb5bcc0a29c3b878(u194, u195) --[[ Line: 1388 ]]
    -- upvalues: l__Classes__5 (copy), u11 (ref), u24 (ref), u23 (ref), u22 (ref), u5 (ref), l__TweenService__8 (copy), u25 (copy), u16 (ref), u21 (ref), u15 (ref), u10 (ref), u13 (ref), l__Easer__2 (copy), u18 (ref), u17 (ref), u19 (ref), u20 (ref), l__Promise__1 (copy)
    if l__Classes__5._x3e046bec2684f59c:_xc9966245cd0a44a8("JUMP").Held then
        u11:_xcc96d6b7159071cc();
    end;
    u24 = 0;
    l__Classes__5._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Deflect", {
        fade_time = 0,
        force_look = true,
        override = { "Parry" }
    });
    u23 = true;
    task.cancel(u22);
    u22 = task.delay(0.5, function() --[[ Line: 1399 ]]
        -- upvalues: u23 (ref)
        if u23 then
            u23 = false;
        end;
    end);
    if u5 then
        u5:Destroy();
    end;
    for _, u196 in u194._x6c4729327b11b476 do
        task.defer(function() --[[ Line: 1408 ]]
            -- upvalues: l__TweenService__8 (ref), u196 (copy), u25 (ref)
            local v197 = l__TweenService__8:Create(u196, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Color = Color3.fromRGB(165, 165, 165)
            });
            v197:Play();
            table.insert(u25, v197);
            v197.Completed:Wait();
            table.remove(u25, table.find(u25, v197));
        end);
    end;
    u16 = false;
    task.cancel(u21);
    u15 = false;
    if typeof(u195.attack_from) == "Vector3" then
        local v198 = l__Classes__5._xd1706540247308ea:_x372c01be8a28bc70("augment");
        if v198 and v198._x382b9a579614e669 then
            v198:_xcaef75cb09b92ea0();
        end;
        u10:_xd352b4906816a25e(u195);
    else
        warn("attack_from IS NOT A Vector3", u195);
    end;
    for _, v199 in { u13.Parry, u13.Recovery, u13.SlideRecovery } do
        v199:Stop(0.001);
    end;
    local v200 = {
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
    local v201 = {
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
    local v202 = {
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
    l__Classes__5._x32ae459de0772e82:_xccb12ea9ca4915a6({ v200, v201, v202 });
    if u18 then
        u18:cancel();
    end;
    if u17 then
        u17:cancel();
    end;
    if u19 then
        u19:cancel();
    end;
    if u20 then
        task.cancel(u20);
    end;
    u13.ParrySuccess:Play(0, 1, 1);
    l__Promise__1.defer(function() --[[ Line: 1501 ]]
        -- upvalues: u195 (copy), u194 (copy)
        local l__Position__41 = workspace.CurrentCamera.CFrame.Position;
        u194:_x234304bda3fb9857("defaultParry", (CFrame.lookAt(l__Position__41 + (u195.attack_from - l__Position__41).Unit * 6, l__Position__41)));
        u194:_xe7b1d327f3522d85("PARRY3", true);
        u194:_xe7b1d327f3522d85("GLIMMER2", true);
    end);
    u20 = task.delay(0.3, function() --[[ Line: 1521 ]]
        -- upvalues: u13 (ref)
        u13.ParrySuccess:AdjustSpeed(0.0001, 0.0001);
    end);
    u19 = l__Promise__1.new(function(u203, _, p204) --[[ Line: 1524 ]]
        -- upvalues: u194 (copy), u13 (ref)
        local u205 = task.delay(0.7, function() --[[ Line: 1526 ]]
            -- upvalues: u194 (ref), u13 (ref), u203 (copy)
            u194:_x9c8a0b4285c0053d(u13.ParrySuccess);
            u203();
        end);
        p204(function() --[[ Line: 1531 ]]
            -- upvalues: u205 (copy)
            task.cancel(u205);
        end);
    end);
end;
function u4._xe53615d96cf36a6b(u206) --[[ Line: 1537 ]]
    -- upvalues: u13 (ref), u6 (ref), u7 (ref), u8 (ref), l__Classes__5 (copy), u9 (ref), u10 (ref), u14 (ref), u11 (ref), u12 (ref), l__Packets__3 (copy), l__TweenService__8 (copy), l__Promise__1 (copy), u24 (ref), u5 (ref), u3 (ref)
    u206:_xfd6946570a7c8e7e(false);
    u13 = u206._x40ea8a7650a021e2;
    u6 = u206._xce7312025a7f2a9a;
    u7 = u206._x29b70d7fd945e6fe;
    u8 = l__Classes__5.Util;
    u9 = l__Classes__5._x910f31e87b3c7281;
    u10 = l__Classes__5._x7058397dabccd000;
    u14 = l__Classes__5._xbe184fb1376a575d;
    u11 = u10._xab5fa47aca1475aa;
    u12 = u10._x77aafe36a385b603;
    table.insert(u206._x5b2bf231942f08fa, l__Packets__3._x6c957041bc9a5148.OnClientEvent:Connect(function(p207) --[[ Line: 1549 ]]
        -- upvalues: l__Classes__5 (ref), l__TweenService__8 (ref), u206 (copy), l__Promise__1 (ref)
        local v208 = tonumber(p207) - workspace:GetServerTimeNow();
        if v208 > 0 then
            local u209, v210 = l__Classes__5._xafc4950d7b094088:_xaf76eb01fb5dda1c({
                text = "! PARRY FATIGUE !",
                cue_type = "progress"
            });
            l__TweenService__8:Create(v210, TweenInfo.new(v208, Enum.EasingStyle.Linear), {
                Value = 1
            }):Play();
            u206._x7c9324b01cf87024 = true;
            u206:_xe7b1d327f3522d85("PARRY_READY", true);
            l__Promise__1.delay(v208):andThen(function() --[[ Line: 1563 ]]
                -- upvalues: u206 (ref), u209 (copy)
                u206._x7c9324b01cf87024 = false;
                u209();
            end);
        end;
    end));
    u9:_x5b10a4521eeef17e(u206._xdca31d4244f207fa, "RightArm");
    l__Promise__1.defer(function() --[[ Line: 1571 ]]
        -- upvalues: u206 (copy), l__Packets__3 (ref), u24 (ref), u5 (ref), l__TweenService__8 (ref)
        u206._xdca31d4244f207fa.Parent = workspace.CurrentCamera;
        table.insert(u206._x5b2bf231942f08fa, l__Packets__3._xbfc686825bdb8cdf.OnClientEvent:Connect(function(...) --[[ Line: 1574 ]]
            -- upvalues: u206 (ref)
            u206:_xcb5bcc0a29c3b878(...);
        end));
        table.insert(u206._x5b2bf231942f08fa, l__Packets__3.unreliablePackets._x67d64518d3944c3c.OnClientEvent:Connect(function() --[[ Line: 1578 ]]
            -- upvalues: u24 (ref), u5 (ref), u206 (ref), l__TweenService__8 (ref)
            local v211 = 0.5 - (os.clock() - u24) * 0.66;
            if v211 > 0.5 then
            else
                u5 = Instance.new("Highlight");
                game.Debris:AddItem(u5, v211 + 0.05);
                u5.Parent = u206._xdca31d4244f207fa.Weapon;
                u5.FillColor = Color3.fromRGB(255, 255, 255);
                u5.OutlineTransparency = 1;
                u5.FillTransparency = 0;
                u5.DepthMode = Enum.HighlightDepthMode.Occluded;
                l__TweenService__8:Create(u5, TweenInfo.new(v211, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    FillTransparency = 1
                }):Play();
            end;
        end));
    end);
    u3 = l__Packets__3._xbfaa5820a4100b86:Fire(u206._x850fb72bedc0eacc);
    u206:_x3003385a15dc35f6();
    l__Classes__5._x1ab1568e6fe5e07f:_x8bbde1bc4032804c(u206._x850fb72bedc0eacc, u206._xedb2653e48fcba49);
    table.insert(u206._x5b2bf231942f08fa, game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 1596 ]]
        -- upvalues: l__Classes__5 (ref), u206 (copy)
        l__Classes__5._x1ab1568e6fe5e07f:_x8bbde1bc4032804c(u206._x850fb72bedc0eacc, u206._xedb2653e48fcba49);
    end));
    u206._xdca31d4244f207fa:ScaleTo(u206._x7214c747228d16cf or u6.MODEL_SCALE);
    u8:bindRenderStepToTable(u206._x5b2bf231942f08fa, l__Classes__5._x32ae459de0772e82._x8ff5d6204140ad8b + 2, "redliner_visibility", LPH_NO_VIRTUALIZE(function() --[[ Line: 1602 ]]
        -- upvalues: l__Classes__5 (ref), u206 (copy)
        if l__Classes__5._x910f31e87b3c7281._x0dabd010e1f00f2e and not l__Classes__5._x910f31e87b3c7281._x18b5705689fe6582 then
            if not u206._xe5a6abb4ed229331 then
                u206._xdca31d4244f207fa:PivotTo(u206._xf489083a4af63c40);
            end;
        else
            u206._xdca31d4244f207fa:PivotTo(CFrame.new(99999, 99999, 99999));
        end;
    end));
    u206._x4f326c90f85bc596 = l__Classes__5._xafc4950d7b094088:_x4a32d66b3276d269("MeleeCrosshair");
end;
return u4;
