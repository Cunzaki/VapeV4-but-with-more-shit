-- Decompiled from: Start.Client.ItemData.Gun._xfa1dcdd390325501
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
local l__Packets__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__Trove__3 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Trove);
local l__Classes__4 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__5 = require(script.Parent.Parent.Parent.InternalSymbols);
local l__RunService__6 = game:GetService("RunService");
local l__TweenService__7 = game:GetService("TweenService");
local u3 = nil;
local u4 = {};
u4.__index = u4;
local u5 = l__Promise__1.resolve();
local u6 = CFrame.new();
local u9 = {
    monarchScopeIn = LPH_NO_VIRTUALIZE(function(p7, p8) --[[ Line: 44 ]]
        -- upvalues: l__Classes__4 (copy)
        return l__Classes__4._x7c4d08c7bcf3460a:_x79e20823f1e7d31d(p7, p8);
    end)
};
function u4._xafd29f1684593d0b(p10, p11, p12) --[[ Line: 49 ]]
    -- upvalues: u4 (copy), l__Trove__3 (copy), l__Promise__1 (copy)
    local v13 = setmetatable({}, u4);
    local v14 = p11 or {};
    local v15 = p12 or {};
    v13._x993df2ff1969ab94 = v15;
    v13._xe9709f830ad162b1 = v15.render_context;
    local l___xe9709f830ad162b1__8 = v13._xe9709f830ad162b1;
    if l___xe9709f830ad162b1__8 then
        l___xe9709f830ad162b1__8 = v13._xe9709f830ad162b1.item_id;
    end;
    v13._xf1f6e7333e01b49d = l___xe9709f830ad162b1__8;
    v13._x15d586472898d5fc = v15.animation_source;
    v13._x4cc6ec36efbfcd87 = v15.animations_3p;
    v13._x7799b9a5f8275e5d = "BaseGun";
    v13._xe1be4e5d98e596e8 = {};
    v13._xa9139f0d9d4b267d = {};
    v13._xa2943846bb4c887f = {};
    v13._x41198087aee77709 = l__Trove__3.new();
    v13._x3e7ad28bf56c5405 = {};
    v13._x82ff6cea32389a9f = {};
    v13._xcdec2743d7c8310e = false;
    v13._x95dc57b21abd2541 = false;
    v13._xa499eade9887156e = nil;
    v13._x0ee373a33926e866 = 0;
    v13._xb4ace6cf46dfc446 = 0;
    v13._xf66560f84e5fde19 = 0;
    v13._x9e646643f5a00f04 = 0;
    v13._x76765a150d3cc076 = l__Promise__1.resolve();
    v13._x850704cd89e4e817 = {
        slide_rot = CFrame.new(),
        sway_offset = CFrame.new(),
        base_offset = v14.base_offset or CFrame.new(0, 0, 0.085)
    };
    v13._x41d71c4f92f98417 = {
        slide_offset = v14.slide_offset or CFrame.new(),
        slide_rot = v14.slide_rot or CFrame.Angles(0, 0, 0.17453292519943295),
        sway_amount = v14.sway_amount or 0.5
    };
    v13._x50add4bf329c5dbb = false;
    v13._xf9edef777a876219 = CFrame.new();
    v13._x697051f0c5bb84ab = {};
    v13._x7e2c022ba631eaff = {};
    v13._xb841a7e475e1bc20 = p10;
    v13._x6a42d95f79fc320f = false;
    local v16 = v15.effects or {};
    local v17 = tostring(game.GameId);
    local v18 = 46;
    for v19 = 1, #v17 do
        v18 = (v18 * 33 + string.byte(v17, v19)) % 65521;
    end;
    local v20;
    if v18 == 272 and v16.show_tracer ~= nil then
        v20 = v16.show_tracer;
    else
        v20 = v15.show_tracer or false;
    end;
    v13._x87108dbcdf3c270d = {
        shot = v16.shot or (v15.shot_effect or "castigateFlash"),
        show_tracer = v20
    };
    local v21 = v15.sounds or {};
    v13._x47173c5288ef6d62 = {
        equip = v21.equip or (v15.equip_sound or "SPIN_GUN"),
        shot = v21.shot or (v15.shot_sound or "KURO_SHOT"),
        lock_in = v21.lock_in or (v15.lock_in or "NEXTEL"),
        lock_off = v21.lock_off or (v15.lock_off or "LOST_TARGET"),
        shot_hit = v21.shot_hit or (v15.shot_hit or "GUN_HIT"),
        dry_fire = v21.dry_fire or (v15.dry_fire or "DRY_FIRE"),
        bonus_shot = v21.bonus_shot or (v15.bonus_shot_sound or v21.shot or (v15.shot_sound or "KURO_SHOT"))
    };
    v13._x712abf15db508ae2 = v15.recoil_args or {
        12,
        12,
        4,
        { "pitch" },
        0.4,
        true,
        false,
        true,
        true
    };
    v13._xf8bc85aed8d72492 = v15.gunpoint or (v13._xb841a7e475e1bc20:FindFirstChild("Gunpoint", true) or v13._xb841a7e475e1bc20:FindFirstChild("GunPoint", true));
    v13._x9c71d62e4a34208d = v13._xb841a7e475e1bc20:FindFirstChildWhichIsA("Animator", true);
    v13._xf6e7a1991fe02124 = nil;
    v13._x8723a202bc5701a5 = nil;
    v13._x91f6be3e93ee2005 = false;
    return v13;
end;
function u4._x5fb1a16c9b5d2bde(p22, p23, p24, p25) --[[ Line: 127 ]]
    -- upvalues: l__Classes__4 (copy)
    return l__Classes__4._x48271d11a14d156e:_x60567ffb440fc88e({
        sounds = {
            [p23] = p22._x47173c5288ef6d62[p23] or p23
        }
    }, l__Classes__4._x02c5f8f89640473a, p23, p24, p25);
end;
function u4._xf5d244762356c869(p26, p27, ...) --[[ Line: 132 ]]
    -- upvalues: l__Classes__4 (copy)
    return l__Classes__4._x48271d11a14d156e:_xbc713bc0a6db24ba({
        effects = {
            [p27] = p26._x87108dbcdf3c270d[p27] or p27
        }
    }, p27, ...);
end;
function u4._x5da6b7a5064d647d(p28) --[[ Line: 137 ]]
    return p28._xf1f6e7333e01b49d or p28._x15d586472898d5fc;
end;
function u4._x2f0353c990c06798(p29, p30, p31, p32) --[[ Line: 141 ]]
    -- upvalues: l__Classes__4 (copy)
    local v33 = p29:_x5da6b7a5064d647d();
    return l__Classes__4._x2b1f81c73714b323:_xa13afb685c7ba425(v33, p30, p31, p32, v33);
end;
function u4._x6346d08ccea5e934(p34) --[[ Line: 146 ]]
    -- upvalues: l__Classes__4 (copy), u5 (ref)
    local v35 = l__Classes__4._x337410ce64f03086._x7635ff7003194128 == "gun" and true or (p34._xcdec2743d7c8310e or p34._x6a42d95f79fc320f);
    p34._x41198087aee77709:Clean();
    for _, v36 in p34._xa2943846bb4c887f do
        local v37 = tostring(game.GameId);
        local v38 = 46;
        for v39 = 1, #v37 do
            v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
        end;
        if v38 == 272 and v36 then
            v36:Destroy();
        end;
    end;
    table.clear(p34._xa2943846bb4c887f);
    l__Classes__4.Util:cleanConnectionsTable(p34._xa9139f0d9d4b267d);
    local v40 = tostring(game.GameId);
    local v41 = 46;
    for v42 = 1, #v40 do
        v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
    end;
    if v41 == 272 and p34._x76765a150d3cc076 then
        p34._x76765a150d3cc076:cancel();
    end;
    local v43 = tostring(game.GameId);
    local v44 = 46;
    for v45 = 1, #v43 do
        v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
    end;
    if v44 == 272 and u5 then
        u5:cancel();
    end;
    p34:_x0536b0bfef20540e(false);
    p34._x6a42d95f79fc320f = false;
    p34._xcdec2743d7c8310e = false;
    p34._xa499eade9887156e = nil;
    p34._x0ee373a33926e866 = 0;
    p34._xb4ace6cf46dfc446 = 0;
    p34._xf66560f84e5fde19 = 0;
    p34._x9e646643f5a00f04 = 0;
    p34._x95dc57b21abd2541 = false;
    p34._x91f6be3e93ee2005 = true;
    for _, v46 in p34._x7e2c022ba631eaff do
        v46:Stop(0.01);
    end;
    table.clear(p34._x7e2c022ba631eaff);
    local v47 = l__Classes__4._x3103fdab012bc1c0:_x44f73aa250bdf574();
    local v48 = tostring(game.GameId);
    local v49 = 46;
    for v50 = 1, #v48 do
        v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
    end;
    if v49 == 272 and v47 then
        v47.Value = 0;
    end;
    local v51 = tostring(game.GameId);
    local v52 = 46;
    for v53 = 1, #v51 do
        v52 = (v52 * 33 + string.byte(v51, v53)) % 65521;
    end;
    if v52 == 272 and v35 then
        task.defer(LPH_JIT_MAX(function() --[[ Line: 187 ]]
            -- upvalues: l__Classes__4 (ref)
            local v54 = tostring(game.GameId);
            local v55 = 46;
            for v56 = 1, #v54 do
                v55 = (v55 * 33 + string.byte(v54, v56)) % 65521;
            end;
            if v55 == 272 and (l__Classes__4._x596eb619070480ba._x885b2725a1933f2e == "alive" and l__Classes__4._x337410ce64f03086._x7635ff7003194128 ~= "melee") then
                l__Classes__4._x337410ce64f03086:_x958385851734f66b("melee");
            end;
        end));
    end;
end;
function u4._x77cfacde0d41d67c(p57, p58, p59) --[[ Line: 195 ]]
    p57._xa499eade9887156e = p58;
    p57._x0ee373a33926e866 = p59;
    p57._xb4ace6cf46dfc446 = os.clock();
    p57._x9e646643f5a00f04 = p58.shot_time or 0;
    p57._xf66560f84e5fde19 = 0;
    p57._x95dc57b21abd2541 = false;
end;
function u4._x250bf104186bc116(p60, p61) --[[ Line: 204 ]]
    p60._x95dc57b21abd2541 = true;
    local v62 = tostring(game.GameId);
    local v63 = 46;
    for v64 = 1, #v62 do
        v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
    end;
    if v63 == 272 and p61 ~= false then
        p60._xf66560f84e5fde19 = os.clock();
    end;
end;
function u4._xc3e6953ea9dfbadf(p65) --[[ Line: 211 ]]
    local l___xa499eade9887156e__9 = p65._xa499eade9887156e;
    if l___xa499eade9887156e__9 then
        l___xa499eade9887156e__9 = tonumber(p65._xa499eade9887156e.time_started);
    end;
    local v66 = tostring(game.GameId);
    local v67 = 46;
    for v68 = 1, #v66 do
        v67 = (v67 * 33 + string.byte(v66, v68)) % 65521;
    end;
    if v67 == 272 and l___xa499eade9887156e__9 then
        return workspace:GetServerTimeNow() - l___xa499eade9887156e__9;
    else
        return os.clock() - p65._xb4ace6cf46dfc446;
    end;
end;
function u4._xb8c42a4cc22e4eb9(p69) --[[ Line: 220 ]]
    -- upvalues: l__Classes__4 (copy)
    local v70 = tostring(game.GameId);
    local v71 = 46;
    for v72 = 1, #v70 do
        v71 = (v71 * 33 + string.byte(v70, v72)) % 65521;
    end;
    if v71 == 272 and (l__Classes__4._x337410ce64f03086._x7635ff7003194128 ~= "gun" or (not p69._x6a42d95f79fc320f or p69._x95dc57b21abd2541)) then
        return false;
    end;
    local l___xa499eade9887156e__10 = p69._xa499eade9887156e;
    local v73 = tostring(game.GameId);
    local v74 = 46;
    for v75 = 1, #v73 do
        v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
    end;
    if v74 == 272 and (not l___xa499eade9887156e__10 or l___xa499eade9887156e__10.parry_cancellable ~= true) then
        return false;
    end;
    local v76 = l___xa499eade9887156e__10.parry_cancel_time or 0.7;
    local v77 = p69._x0ee373a33926e866 or (l___xa499eade9887156e__10.draw_time or 0);
    local v78 = tostring(game.GameId);
    local v79 = 46;
    for v80 = 1, #v78 do
        v79 = (v79 * 33 + string.byte(v78, v80)) % 65521;
    end;
    if v79 == 272 and v77 <= v76 then
        return false;
    end;
    local v81 = p69:_xc3e6953ea9dfbadf();
    local v82;
    if v76 <= v81 then
        v82 = v81 < v77;
    else
        v82 = false;
    end;
    return v82;
end;
function u4._xa687ebb1ebd0b321(p83) --[[ Line: 240 ]]
    -- upvalues: l__Classes__4 (copy)
    local v84 = tostring(game.GameId);
    local v85 = 46;
    for v86 = 1, #v84 do
        v85 = (v85 * 33 + string.byte(v84, v86)) % 65521;
    end;
    if v85 == 272 and (l__Classes__4._x337410ce64f03086._x7635ff7003194128 ~= "gun" or not (p83._x6a42d95f79fc320f and p83._x95dc57b21abd2541)) then
        return false;
    end;
    local l___xa499eade9887156e__11 = p83._xa499eade9887156e;
    local v87 = tostring(game.GameId);
    local v88 = 46;
    for v89 = 1, #v87 do
        v88 = (v88 * 33 + string.byte(v87, v89)) % 65521;
    end;
    if v88 == 272 and (not l___xa499eade9887156e__11 or l___xa499eade9887156e__11.holster_parry_cancellable == false) then
        return false;
    end;
    local v90 = l___xa499eade9887156e__11.holster_parry_cancel_time or 0.7;
    local v91 = p83._x9e646643f5a00f04 or (l___xa499eade9887156e__11.shot_time or 0);
    local v92 = tostring(game.GameId);
    local v93 = 46;
    for v94 = 1, #v92 do
        v93 = (v93 * 33 + string.byte(v92, v94)) % 65521;
    end;
    if v93 == 272 and v91 <= v90 then
        return false;
    end;
    local v95 = tostring(game.GameId);
    local v96 = 46;
    for v97 = 1, #v95 do
        v96 = (v96 * 33 + string.byte(v95, v97)) % 65521;
    end;
    if v96 == 272 and p83._xf66560f84e5fde19 <= 0 then
        return false;
    end;
    local v98 = os.clock() - p83._xf66560f84e5fde19;
    local v99;
    if v90 <= v98 then
        v99 = v98 < v91;
    else
        v99 = false;
    end;
    return v99;
end;
function u4._x96f8a14800fcbd4c(p100) --[[ Line: 264 ]]
    -- upvalues: l__Classes__4 (copy)
    local v101 = tostring(game.GameId);
    local v102 = 46;
    for v103 = 1, #v101 do
        v102 = (v102 * 33 + string.byte(v101, v103)) % 65521;
    end;
    if v102 == 272 and not (p100:_xb8c42a4cc22e4eb9() or p100:_xa687ebb1ebd0b321()) then
    else
        local v104 = l__Classes__4._x337410ce64f03086:_x3efa7d2770a422ee("melee");
        local v105 = tostring(game.GameId);
        local v106 = 46;
        for v107 = 1, #v105 do
            v106 = (v106 * 33 + string.byte(v105, v107)) % 65521;
        end;
        if v106 == 272 and (not v104 or (typeof(v104._x61eea08bc8b8232e) ~= "function" or not v104:_x61eea08bc8b8232e())) then
        else
            p100._x41198087aee77709:Clean();
            l__Classes__4._x337410ce64f03086:_x958385851734f66b("melee");
            v104:_x74fbc6314d850992();
        end;
    end;
end;
function u4._x9d3573df3d5ca26f(u108, p109, p110) --[[ Line: 279 ]]
    -- upvalues: l__Classes__4 (copy), l__Promise__1 (copy), l__Packets__2 (copy), u6 (copy), l__RunService__6 (copy), l__TweenService__7 (copy), u3 (ref)
    local u111 = false;
    local u112 = l__Classes__4._x3103fdab012bc1c0:_x44f73aa250bdf574();
    local u127 = LPH_NO_VIRTUALIZE(function(p113, _, p114) --[[ Line: 285 ]]
        -- upvalues: l__Classes__4 (ref), u108 (copy)
        local function v119(u115, u116) --[[ Line: 286 ]]
            -- upvalues: l__Classes__4 (ref), u108 (ref)
            l__Classes__4._x7c4d08c7bcf3460a:_xff77218ad0f885e7(u108._x8723a202bc5701a5, u108._xf6e7a1991fe02124, u116, u108._x87108dbcdf3c270d.show_tracer);
            local v117 = math.clamp((workspace.CurrentCamera.CFrame.Position - u116).Magnitude, 10, 200);
            local u118 = l__Classes__4.Util:convNumRange(v117, 10, 200, 0.25, 0.2);
            table.clear(u108._x7e2c022ba631eaff);
            task.delay(0.07, function() --[[ Line: 297 ]]
                -- upvalues: l__Classes__4 (ref), u116 (copy), u115 (copy), u118 (copy)
                l__Classes__4._x7c4d08c7bcf3460a:_xc4d94a025a223fb7(u116, u116 + -u115.Normal * 5);
                l__Classes__4._x02c5f8f89640473a:_xa2c2f0587694a915("BULLET_RICOCHET", true).Volume = u118;
                l__Classes__4._x02c5f8f89640473a:_xa2c2f0587694a915("BULLET_IMPACT", true).Volume = u118 * 3;
            end);
        end;
        local v120 = tostring(game.GameId);
        local v121 = 46;
        for v122 = 1, #v120 do
            v121 = (v121 * 33 + string.byte(v120, v122)) % 65521;
        end;
        if v121 == 272 and p114 then
            l__Classes__4._x7c4d08c7bcf3460a:_xff77218ad0f885e7(u108._x8723a202bc5701a5, u108._xf6e7a1991fe02124, p114.Position, p113.show_tracer);
        else
            local v123 = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, u108._x8723a202bc5701a5 * 300, l__Classes__4.Util:getBasicRaycastParams());
            local v124 = tostring(game.GameId);
            local v125 = 46;
            for v126 = 1, #v124 do
                v125 = (v125 * 33 + string.byte(v124, v126)) % 65521;
            end;
            if v125 == 272 and v123 then
                v119(v123, v123.Position);
            else
                l__Classes__4._x7c4d08c7bcf3460a:_xff77218ad0f885e7(u108._x8723a202bc5701a5, u108._xf6e7a1991fe02124, workspace.CurrentCamera.CFrame.Position + u108._x8723a202bc5701a5 * 300, u108._x87108dbcdf3c270d.show_tracer);
                l__Classes__4._x02c5f8f89640473a:_xa2c2f0587694a915("BULLET_RICOCHET", true).Volume = 0.2;
            end;
        end;
    end);
    local u139 = LPH_JIT_MAX(function(p128) --[[ Line: 328 ]]
        -- upvalues: u111 (ref), u112 (copy), u108 (copy), l__Classes__4 (ref), l__Promise__1 (ref)
        local v129 = tostring(game.GameId);
        local v130 = 46;
        for v131 = 1, #v129 do
            v130 = (v130 * 33 + string.byte(v129, v131)) % 65521;
        end;
        if v130 == 272 and u111 then
        else
            local v132 = tostring(game.GameId);
            local v133 = 46;
            for v134 = 1, #v132 do
                v133 = (v133 * 33 + string.byte(v132, v134)) % 65521;
            end;
            if v133 == 272 and u112 then
                u112.Value = 1;
            end;
            u111 = true;
            u108:_x250bf104186bc116();
            l__Classes__4.Util:cleanConnectionsTable(u108._xa9139f0d9d4b267d);
            for _, v135 in u108._xa2943846bb4c887f do
                v135:Destroy();
            end;
            u108._x8723a202bc5701a5 = l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3();
            u108._xf6e7a1991fe02124 = u108._xf8bc85aed8d72492.WorldPosition;
            u108._x697051f0c5bb84ab.Draw:Stop(0.0001);
            u108._x697051f0c5bb84ab.Fire:Play(0);
            l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gunshot", {
                fade_time = 0,
                force_look = true,
                override = {
                    "Deflect",
                    "Parry",
                    "RAttack",
                    "CAttack",
                    "LAttack",
                    "Gundraw"
                }
            });
            u108:_x2f0353c990c06798("Fire", 1, 1);
            l__Promise__1.delay(p128.shot_time):andThen(LPH_JIT_MAX(function() --[[ Line: 349 ]]
                -- upvalues: l__Classes__4 (ref)
                local l___x337410ce64f03086__12 = l__Classes__4._x337410ce64f03086;
                local v136 = tostring(game.GameId);
                local v137 = 46;
                for v138 = 1, #v136 do
                    v137 = (v137 * 33 + string.byte(v136, v138)) % 65521;
                end;
                if v137 == 272 and l___x337410ce64f03086__12._x7635ff7003194128 == "gun" then
                    l__Classes__4._x337410ce64f03086:_x958385851734f66b("melee");
                end;
            end));
            l__Classes__4._x2b1f81c73714b323:_x06defdf12fcc7217(unpack(u108._x712abf15db508ae2));
            u108:_x5fb1a16c9b5d2bde("shot", true);
            u108:_xf5d244762356c869("shot", u108._xf6e7a1991fe02124);
            l__Classes__4._xef0ffbcc2c92f7b4:_x453b523b854c9b40(p128);
        end;
    end);
    LPH_JIT_MAX(function(u140, p141) --[[ Line: 363 ]]
        -- upvalues: l__Classes__4 (ref), u108 (copy), l__Packets__2 (ref), u139 (copy), u127 (copy), l__Promise__1 (ref), u111 (ref), u6 (ref), l__RunService__6 (ref), l__TweenService__7 (ref), u3 (ref), u112 (copy)
        local v142 = tostring(game.GameId);
        local v143 = 46;
        for v144 = 1, #v142 do
            v143 = (v143 * 33 + string.byte(v142, v144)) % 65521;
        end;
        if v143 == 272 and not l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 then
        else
            table.insert(u108._x7e2c022ba631eaff, l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gundraw", {
                fade_time = 0,
                force_look = true,
                override = {
                    "Deflect",
                    "Parry",
                    "RAttack",
                    "CAttack",
                    "LAttack"
                }
            }));
            local u145 = p141 and u140.draw_time or u140.shot_interval;
            u108:_x77cfacde0d41d67c(u140, u145);
            u108._x6a42d95f79fc320f = true;
            u108:_x0536b0bfef20540e(true);
            u108._x697051f0c5bb84ab.Draw:Play(0);
            local v146 = u108:_x5fb1a16c9b5d2bde("equip", true);
            u108._x41198087aee77709:Add(v146);
            local v147 = l__Packets__2._x972e4673467ce2e8.OnClientEvent:Once(LPH_JIT_MAX(function(...) --[[ Line: 376 ]]
                -- upvalues: u139 (ref), u140 (copy), u127 (ref)
                u139(u140);
                u127(u140, ...);
            end));
            local v148 = l__Promise__1.delay(u140.draw_time + 0.2);
            u108._x76765a150d3cc076 = v148;
            v148:andThen(LPH_JIT_MAX(function() --[[ Line: 384 ]]
                -- upvalues: u111 (ref), u139 (ref), u140 (copy)
                local v149 = tostring(game.GameId);
                local v150 = 46;
                for v151 = 1, #v149 do
                    v150 = (v150 * 33 + string.byte(v149, v151)) % 65521;
                end;
                if v150 == 272 and not u111 then
                    warn("LATE OR DROPPED SERVER PACKET, RESOLVING EARLY");
                    u139(u140);
                end;
            end));
            table.insert(u108._xa9139f0d9d4b267d, v147);
            u108:_x2f0353c990c06798("Draw", 1, 1);
            local u152 = u6;
            table.insert(u108._xe1be4e5d98e596e8, l__RunService__6.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function() --[[ Line: 396 ]]
                -- upvalues: u108 (ref), u152 (ref), l__Classes__4 (ref), u6 (ref)
                local l___x850704cd89e4e817__13 = u108._x850704cd89e4e817;
                local l___x41d71c4f92f98417__14 = u108._x41d71c4f92f98417;
                local l__CFrame__15 = workspace.CurrentCamera.CFrame;
                local v153, v154 = l__CFrame__15:ToObjectSpace(u152):ToOrientation();
                local v155 = tostring(game.GameId);
                local v156 = 46;
                for v157 = 1, #v155 do
                    v156 = (v156 * 33 + string.byte(v155, v157)) % 65521;
                end;
                local v158;
                if v156 == 272 and l__Classes__4._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._x3d199abdbf08457d then
                    v158 = l___x41d71c4f92f98417__14.slide_rot;
                else
                    v158 = u6;
                end;
                u152 = l__CFrame__15;
                l___x850704cd89e4e817__13.sway_offset = l___x850704cd89e4e817__13.sway_offset:Lerp(CFrame.Angles(math.sin(-v153) * l___x41d71c4f92f98417__14.sway_amount, math.sin(-v154) * l___x41d71c4f92f98417__14.sway_amount, 0), 0.15);
                l___x850704cd89e4e817__13.slide_rot = l___x850704cd89e4e817__13.slide_rot:Lerp(v158, 0.1);
            end)));
            l__Classes__4.Util:bindRenderStepToTable(u108._xe1be4e5d98e596e8, l__Classes__4._x2b1f81c73714b323._x1550222c87a9e915 + 1, "gun_viewmodel", LPH_NO_VIRTUALIZE(function() --[[ Line: 408 ]]
                -- upvalues: l__Classes__4 (ref), u108 (ref)
                l__Classes__4._xaffa998c3a825e19:_x2ccb90caca713ad9(u108._xb841a7e475e1bc20);
                local l__CFrame__16 = workspace.CurrentCamera.CFrame;
                for _, v159 in u108._x850704cd89e4e817 do
                    l__CFrame__16 = l__CFrame__16 * v159;
                end;
                u108._xb841a7e475e1bc20:PivotTo(l__CFrame__16);
            end));
            local u160 = nil;
            local u161 = u140.assist_radius * 2;
            local u162 = game:GetService("ReplicatedStorage").Assets.UIAssets.ShotReticle:GetChildren();
            local u163 = {};
            local u164 = 0;
            local u165 = nil;
            local u166 = nil;
            local u167 = nil;
            LPH_NO_VIRTUALIZE(function() --[[ Line: 430 ]]
                -- upvalues: u162 (copy), u167 (ref), u165 (ref), u166 (ref), u163 (copy), u108 (ref), u161 (copy), u164 (ref), l__TweenService__7 (ref), u145 (copy)
                for _, v168 in ipairs(u162) do
                    local v169 = v168:Clone();
                    local v170 = tostring(game.GameId);
                    local v171 = 46;
                    for v172 = 1, #v170 do
                        v171 = (v171 * 33 + string.byte(v170, v172)) % 65521;
                    end;
                    if v171 == 272 and v168.Name == "ClosestCircle" then
                        u167 = v169;
                    else
                        local v173 = tostring(game.GameId);
                        local v174 = 46;
                        for v175 = 1, #v173 do
                            v174 = (v174 * 33 + string.byte(v173, v175)) % 65521;
                        end;
                        if v174 == 272 and v168.Name == "OuterCircle" then
                            u165 = v169;
                        else
                            local v176 = tostring(game.GameId);
                            local v177 = 46;
                            for v178 = 1, #v176 do
                                v177 = (v177 * 33 + string.byte(v176, v178)) % 65521;
                            end;
                            if v177 == 272 and v168.Name == "TimingCircle" then
                                u166 = v169;
                            end;
                        end;
                    end;
                    table.insert(u163, v169);
                    table.insert(u108._xa2943846bb4c887f, v169);
                end;
                u167.Size = UDim2.fromScale(u161, u161);
                u165.Size = UDim2.fromScale(u161, u161);
                u166.Size = UDim2.fromScale(u161, u161);
                u164 = u161;
                l__TweenService__7:Create(u165.Rotator, TweenInfo.new(u145, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Rotation = 360
                }):Play();
            end)();
            local u179 = game.Workspace.Entities:GetChildren();
            local u180 = nil;
            local u181 = nil;
            local u182 = false;
            local u183 = false;
            local u184 = os.clock();
            local u185 = TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
            local u190 = LPH_JIT_MAX(function(p186) --[[ Line: 463 ]]
                -- upvalues: l__Classes__4 (ref)
                local l___x02980fc0087c2697__17 = l__Classes__4._x02980fc0087c2697;
                local v187 = tostring(game.GameId);
                local v188 = 46;
                for v189 = 1, #v187 do
                    v188 = (v188 * 33 + string.byte(v187, v189)) % 65521;
                end;
                if v188 == 272 and (l___x02980fc0087c2697__17 and typeof(l___x02980fc0087c2697__17._x0f70e9454390dc59) == "function") then
                    return l___x02980fc0087c2697__17:_x0f70e9454390dc59(p186);
                else
                    return p186;
                end;
            end);
            local u196 = LPH_JIT_MAX(function(p191) --[[ Line: 473 ]]
                -- upvalues: u190 (copy)
                local v192 = u190(p191);
                local v193 = tostring(game.GameId);
                local v194 = 46;
                for v195 = 1, #v193 do
                    v194 = (v194 * 33 + string.byte(v193, v195)) % 65521;
                end;
                if v194 == 272 and (v192 and v192:IsA("Model")) then
                    return v192:FindFirstChild("Head") or v192.PrimaryPart;
                else
                    return p191:FindFirstChild("Head") or p191.PrimaryPart;
                end;
            end);
            local u199 = LPH_JIT_MAX(function(p197, p198) --[[ Line: 483 ]]
                -- upvalues: u182 (ref), u180 (ref), u181 (ref), u167 (ref), l__TweenService__7 (ref), u185 (copy)
                u182 = false;
                u180 = p197;
                u181 = p198;
                u167.Parent = p198;
                local l__ImageLabel__18 = u167.ImageLabel;
                l__ImageLabel__18.ImageTransparency = 1;
                l__TweenService__7:Create(l__ImageLabel__18, u185, {
                    ImageTransparency = l__ImageLabel__18:GetAttribute("StartTransparency")
                }):Play();
            end);
            local u202 = LPH_JIT_MAX(function(p200, p201, _) --[[ Line: 493 ]]
                -- upvalues: l__Classes__4 (ref)
                return not l__Classes__4.Util:hasLineOfSight(p200, p201);
            end);
            local u230 = LPH_JIT_MAX(function() --[[ Line: 497 ]]
                -- upvalues: u182 (ref), u160 (ref), u180 (ref), l__Promise__1 (ref), l__Packets__2 (ref), u3 (ref), u111 (ref), u108 (ref), u163 (copy), u167 (ref), u181 (ref), l__TweenService__7 (ref), u185 (copy)
                u182 = true;
                u160 = u180;
                l__Promise__1.defer(LPH_JIT_MAX(function() --[[ Line: 501 ]]
                    -- upvalues: l__Packets__2 (ref), u3 (ref), u160 (ref), u111 (ref), u108 (ref), u163 (ref), u167 (ref), u181 (ref), l__TweenService__7 (ref), u185 (ref)
                    local v203 = l__Packets__2._xd1d1ed4c2ff2e856:Fire(u3, u160);
                    local v204 = tostring(game.GameId);
                    local v205 = 46;
                    for v206 = 1, #v204 do
                        v205 = (v205 * 33 + string.byte(v204, v206)) % 65521;
                    end;
                    if v205 == 272 and v203 then
                        local v207 = tostring(game.GameId);
                        local v208 = 46;
                        for v209 = 1, #v207 do
                            v208 = (v208 * 33 + string.byte(v207, v209)) % 65521;
                        end;
                        if v208 == 272 and u111 then
                            return;
                        end;
                        u108:_x5fb1a16c9b5d2bde("lock_in", true);
                        for _, v210 in u163 do
                            local v211 = tostring(game.GameId);
                            local v212 = 46;
                            for v213 = 1, #v211 do
                                v212 = (v212 * 33 + string.byte(v211, v213)) % 65521;
                            end;
                            if v212 ~= 272 or v210 ~= u167 then
                                local v214 = tostring(game.GameId);
                                local v215 = 46;
                                for v216 = 1, #v214 do
                                    v215 = (v215 * 33 + string.byte(v214, v216)) % 65521;
                                end;
                                if v215 == 272 and u111 then
                                    return;
                                end;
                                v210.Parent = u181;
                                v210.Enabled = true;
                                for _, v217 in v210:GetDescendants() do
                                    local v218 = tostring(game.GameId);
                                    local v219 = 46;
                                    for v220 = 1, #v218 do
                                        v219 = (v219 * 33 + string.byte(v218, v220)) % 65521;
                                    end;
                                    if v219 ~= 272 or v217:GetAttribute("StartTransparency") then
                                        local v221 = tostring(game.GameId);
                                        local v222 = 46;
                                        for v223 = 1, #v221 do
                                            v222 = (v222 * 33 + string.byte(v221, v223)) % 65521;
                                        end;
                                        if v222 == 272 and v217:IsA("Frame") then
                                            v217.BackgroundTransparency = 1;
                                            l__TweenService__7:Create(v217, u185, {
                                                BackgroundTransparency = v217:GetAttribute("StartTransparency")
                                            }):Play();
                                        else
                                            local v224 = tostring(game.GameId);
                                            local v225 = 46;
                                            for v226 = 1, #v224 do
                                                v225 = (v225 * 33 + string.byte(v224, v226)) % 65521;
                                            end;
                                            if v225 == 272 and v217:IsA("ImageLabel") then
                                                v217.ImageTransparency = 1;
                                                l__TweenService__7:Create(v217, u185, {
                                                    ImageTransparency = v217:GetAttribute("StartTransparency")
                                                }):Play();
                                            else
                                                local v227 = tostring(game.GameId);
                                                local v228 = 46;
                                                for v229 = 1, #v227 do
                                                    v228 = (v228 * 33 + string.byte(v227, v229)) % 65521;
                                                end;
                                                if v228 == 272 and v217:IsA("TextLabel") then
                                                    v217.TextTransparency = 1;
                                                    l__TweenService__7:Create(v217, u185, {
                                                        TextTransparency = v217:GetAttribute("StartTransparency")
                                                    }):Play();
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end));
            end);
            local u255 = LPH_JIT_MAX(function() --[[ Line: 534 ]]
                -- upvalues: u160 (ref), u183 (ref), l__Promise__1 (ref), l__Packets__2 (ref), u3 (ref), u108 (ref), u182 (ref), u163 (copy), u167 (ref), u111 (ref), l__TweenService__7 (ref), u185 (copy)
                local v231 = tostring(game.GameId);
                local v232 = 46;
                for v233 = 1, #v231 do
                    v232 = (v232 * 33 + string.byte(v231, v233)) % 65521;
                end;
                if v232 == 272 and (u160 and not u183) then
                    u183 = true;
                    l__Promise__1.defer(LPH_JIT_MAX(function() --[[ Line: 537 ]]
                        -- upvalues: u160 (ref), l__Packets__2 (ref), u3 (ref), u108 (ref), u182 (ref), u183 (ref), u163 (ref), u167 (ref), u111 (ref), l__TweenService__7 (ref), u185 (ref)
                        u160 = nil;
                        local v234 = l__Packets__2._xd1d1ed4c2ff2e856:Fire(u3, u160);
                        local v235 = tostring(game.GameId);
                        local v236 = 46;
                        for v237 = 1, #v235 do
                            v236 = (v236 * 33 + string.byte(v235, v237)) % 65521;
                        end;
                        if v236 == 272 and v234 then
                            u108:_x5fb1a16c9b5d2bde("lock_off", true);
                            u182 = false;
                            u183 = false;
                            for _, v238 in u163 do
                                local v239 = tostring(game.GameId);
                                local v240 = 46;
                                for v241 = 1, #v239 do
                                    v240 = (v240 * 33 + string.byte(v239, v241)) % 65521;
                                end;
                                if v240 ~= 272 or v238 ~= u167 then
                                    local v242 = tostring(game.GameId);
                                    local v243 = 46;
                                    for v244 = 1, #v242 do
                                        v243 = (v243 * 33 + string.byte(v242, v244)) % 65521;
                                    end;
                                    if v243 == 272 and u111 then
                                        return;
                                    end;
                                    for _, v245 in v238:GetDescendants() do
                                        local v246 = tostring(game.GameId);
                                        local v247 = 46;
                                        for v248 = 1, #v246 do
                                            v247 = (v247 * 33 + string.byte(v246, v248)) % 65521;
                                        end;
                                        if v247 == 272 and v245:IsA("Frame") then
                                            l__TweenService__7:Create(v245, u185, {
                                                BackgroundTransparency = 1
                                            }):Play();
                                        else
                                            local v249 = tostring(game.GameId);
                                            local v250 = 46;
                                            for v251 = 1, #v249 do
                                                v250 = (v250 * 33 + string.byte(v249, v251)) % 65521;
                                            end;
                                            if v250 == 272 and v245:IsA("ImageLabel") then
                                                l__TweenService__7:Create(v245, u185, {
                                                    ImageTransparency = 1
                                                }):Play();
                                            else
                                                local v252 = tostring(game.GameId);
                                                local v253 = 46;
                                                for v254 = 1, #v252 do
                                                    v253 = (v253 * 33 + string.byte(v252, v254)) % 65521;
                                                end;
                                                if v253 == 272 and v245:IsA("TextLabel") then
                                                    l__TweenService__7:Create(v245, u185, {
                                                        TextTransparency = 1
                                                    }):Play();
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end));
                end;
            end);
            local u260 = LPH_JIT_MAX(function() --[[ Line: 567 ]]
                -- upvalues: l__Classes__4 (ref), u108 (ref)
                l__Classes__4.Util:unbindFromRenderStep("gun_targetting");
                local v256 = table.find(u108._xa9139f0d9d4b267d, "gun_targetting");
                local v257 = tostring(game.GameId);
                local v258 = 46;
                for v259 = 1, #v257 do
                    v258 = (v258 * 33 + string.byte(v257, v259)) % 65521;
                end;
                if v258 == 272 and v256 then
                    table.remove(u108._xa9139f0d9d4b267d, v256);
                end;
            end);
            local u308 = LPH_JIT_MAX(function() --[[ Line: 576 ]]
                -- upvalues: l__Classes__4 (ref), u182 (ref), u180 (ref), u196 (copy), u202 (copy), u199 (copy), u179 (copy), u140 (copy)
                local v261 = l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3();
                local l__Head__19 = l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168.Head;
                local l__Position__20 = l__Head__19.Position;
                local v262 = tostring(game.GameId);
                local v263 = 46;
                local v264 = -1;
                for v265 = 1, #v262 do
                    v263 = (v263 * 33 + string.byte(v262, v265)) % 65521;
                end;
                local v266 = v263 == 272 and u182 and 1.9 or v264;
                local v267 = tostring(game.GameId);
                local v268 = 46;
                local v269 = nil;
                local v270 = nil;
                for v271 = 1, #v267 do
                    v268 = (v268 * 33 + string.byte(v267, v271)) % 65521;
                end;
                if v268 == 272 and (u180 and not u182) then
                    local v272 = u196(u180);
                    local v273 = tostring(game.GameId);
                    local v274 = 46;
                    for v275 = 1, #v273 do
                        v274 = (v274 * 33 + string.byte(v273, v275)) % 65521;
                    end;
                    if v274 == 272 and (not v272 or u202(l__Head__19, v272, u180)) then
                        u199();
                    end;
                end;
                for _, v276 in ipairs(u179) do
                    local v277 = tostring(game.GameId);
                    local v278 = 46;
                    for v279 = 1, #v277 do
                        v278 = (v278 * 33 + string.byte(v277, v279)) % 65521;
                    end;
                    if v278 ~= 272 or v276:FindFirstChild("Hurtboxes") then
                        local v280 = tostring(game.GameId);
                        local v281 = 46;
                        for v282 = 1, #v280 do
                            v281 = (v281 * 33 + string.byte(v280, v282)) % 65521;
                        end;
                        if v281 ~= 272 or v276 and v276 ~= l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 then
                            local v283 = v276:GetAttribute("is_teammate");
                            local v284 = tostring(game.GameId);
                            local v285 = 46;
                            for v286 = 1, #v284 do
                                v285 = (v285 * 33 + string.byte(v284, v286)) % 65521;
                            end;
                            if v285 ~= 272 or v283 ~= true then
                                local v287 = u196(v276);
                                local v288 = tostring(game.GameId);
                                local v289 = 46;
                                for v290 = 1, #v288 do
                                    v289 = (v289 * 33 + string.byte(v288, v290)) % 65521;
                                end;
                                if v289 ~= 272 or v287 then
                                    local v291 = v287.Position - l__Position__20;
                                    local l__Magnitude__21 = v291.Magnitude;
                                    local v292 = tostring(game.GameId);
                                    local v293 = 46;
                                    for v294 = 1, #v292 do
                                        v293 = (v293 * 33 + string.byte(v292, v294)) % 65521;
                                    end;
                                    if v293 ~= 272 or u140.max_distance >= l__Magnitude__21 then
                                        local v295 = v261:Dot(v291.Unit);
                                        local v296 = tostring(game.GameId);
                                        local v297 = 46;
                                        for v298 = 1, #v296 do
                                            v297 = (v297 * 33 + string.byte(v296, v298)) % 65521;
                                        end;
                                        if v297 ~= 272 or v295 >= 0.5 then
                                            local v299 = tostring(game.GameId);
                                            local v300 = 46;
                                            for v301 = 1, #v299 do
                                                v300 = (v300 * 33 + string.byte(v299, v301)) % 65521;
                                            end;
                                            if v300 ~= 272 or not u202(l__Head__19, v287, v276) then
                                                local v302 = tostring(game.GameId);
                                                local v303 = 46;
                                                for v304 = 1, #v302 do
                                                    v303 = (v303 * 33 + string.byte(v302, v304)) % 65521;
                                                end;
                                                if v303 == 272 and v266 < v295 then
                                                    v270 = v287;
                                                    v269 = v276;
                                                    v266 = v295;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                local v305 = tostring(game.GameId);
                local v306 = 46;
                for v307 = 1, #v305 do
                    v306 = (v306 * 33 + string.byte(v305, v307)) % 65521;
                end;
                if v306 == 272 and (v269 and v269 ~= u180) then
                    u199(v269, v270);
                end;
            end);
            local u332 = LPH_JIT_MAX(function(p309) --[[ Line: 624 ]]
                -- upvalues: u180 (ref), u181 (ref), u255 (copy), u199 (copy), l__Classes__4 (ref), u167 (ref), u140 (copy), u182 (ref), u230 (copy), l__TweenService__7 (ref), u164 (ref), u166 (ref), u165 (ref)
                local v310 = tostring(game.GameId);
                local v311 = 46;
                for v312 = 1, #v310 do
                    v311 = (v311 * 33 + string.byte(v310, v312)) % 65521;
                end;
                if v311 == 272 and u180 then
                    local v313 = tostring(game.GameId);
                    local v314 = 46;
                    for v315 = 1, #v313 do
                        v314 = (v314 * 33 + string.byte(v313, v315)) % 65521;
                    end;
                    if v314 == 272 and not (u181 and u181.Parent) then
                        u255();
                        u199();
                        return;
                    end;
                    local l__CFrame__22 = workspace.CurrentCamera.CFrame;
                    local l__Position__23 = l__CFrame__22.Position;
                    local v316 = l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3();
                    local l__Position__24 = u181.Position;
                    local l__Magnitude__25 = (l__Position__24 - l__Position__23):Cross(v316).Magnitude;
                    local l__Unit__26 = (l__Position__24 - l__Position__23).Unit;
                    local l__RightVector__27 = l__CFrame__22.RightVector;
                    local l__UpVector__28 = l__CFrame__22.UpVector;
                    local v317 = l__Unit__26:Dot(-l__RightVector__27);
                    local v318 = l__Unit__26:Dot(-l__UpVector__28);
                    local v319 = math.atan2(v317, v318);
                    local v320 = math.deg(v319);
                    u167.ImageLabel.Rotation = v320;
                    local v321 = tostring(game.GameId);
                    local v322 = 46;
                    for v323 = 1, #v321 do
                        v322 = (v322 * 33 + string.byte(v321, v323)) % 65521;
                    end;
                    if v322 == 272 and (l__Magnitude__25 <= u140.assist_radius and u180.Parent == workspace.Entities) then
                        local v324 = tostring(game.GameId);
                        local v325 = 46;
                        for v326 = 1, #v324 do
                            v325 = (v325 * 33 + string.byte(v324, v326)) % 65521;
                        end;
                        if v325 == 272 and not u182 then
                            u230();
                        end;
                        local v327 = l__Classes__4.Util:convNumRange(l__TweenService__7:GetValue(p309, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), 0, 1, u164 - 1, 0.1);
                        local v328 = l__Classes__4.Util:convNumRange(p309, 0, 1, 1, 0);
                        u166.Size = UDim2.fromScale(v327, v327);
                        u166.ImageLabel.ImageTransparency = v328;
                        local v329 = l__Classes__4.Util:numLerp(1, 0.5, l__TweenService__7:GetValue(p309, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
                        u165.BotRight.Size = UDim2.fromScale(v329, v329);
                        u165.TopRight.Size = UDim2.fromScale(v329, v329);
                        u165.BotLeft.Size = UDim2.fromScale(v329, v329);
                        u165.TopLeft.Size = UDim2.fromScale(v329, v329);
                        local v330 = l__Classes__4.Util:convNumRange(p309, 0, 1, 0, 100);
                        local l__Percentage__29 = u165.BotRight.Percentage;
                        local v331 = math.floor(v330);
                        l__Percentage__29.Text = tostring(v331) .. "%";
                        return;
                    end;
                    u255();
                end;
            end);
            l__Classes__4.Util:bindRenderStepToTable(u108._xa9139f0d9d4b267d, l__Classes__4._x2b1f81c73714b323._x1550222c87a9e915 + 5, "gun_targetting", LPH_JIT_MAX(function() --[[ Line: 677 ]]
                -- upvalues: l__Classes__4 (ref), u167 (ref), u260 (copy), u184 (copy), u145 (copy), u112 (ref), u308 (copy), u332 (copy)
                local v333 = tostring(game.GameId);
                local v334 = 46;
                for v335 = 1, #v333 do
                    v334 = (v334 * 33 + string.byte(v333, v335)) % 65521;
                end;
                if v334 == 272 and (not game.Players.LocalPlayer.Character or (not l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 or l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 and not l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168.Parent)) then
                else
                    local v336 = tostring(game.GameId);
                    local v337 = 46;
                    for v338 = 1, #v336 do
                        v337 = (v337 * 33 + string.byte(v336, v338)) % 65521;
                    end;
                    if v337 == 272 and (not u167 or u167 and u167.Parent ~= u167.Parent) then
                        u260();
                    else
                        local v339 = os.clock() - u184;
                        local v340 = math.min(v339, u145);
                        local v341 = l__Classes__4.Util:convNumRange(v340, 0, u145, 0, 1);
                        local v342 = tostring(game.GameId);
                        local v343 = 46;
                        for v344 = 1, #v342 do
                            v343 = (v343 * 33 + string.byte(v342, v344)) % 65521;
                        end;
                        if v343 == 272 and v341 == 1 then
                            u260();
                        else
                            local v345 = tostring(game.GameId);
                            local v346 = 46;
                            for v347 = 1, #v345 do
                                v346 = (v346 * 33 + string.byte(v345, v347)) % 65521;
                            end;
                            if v346 == 272 and u112 then
                                u112.Value = v341;
                            end;
                            u308();
                            u332(v341);
                        end;
                    end;
                end;
            end));
        end;
    end)(p109, p110);
end;
function u4._xfceb48b9ebb9d756(u348, u349, p350) --[[ Line: 707 ]]
    -- upvalues: l__Classes__4 (copy), l__TweenService__7 (copy), l__Packets__2 (copy), u3 (ref), l__Promise__1 (copy), u6 (copy), l__RunService__6 (copy), u5 (ref)
    local v351 = tostring(game.GameId);
    local v352 = 46;
    for v353 = 1, #v351 do
        v352 = (v352 * 33 + string.byte(v351, v353)) % 65521;
    end;
    if v352 == 272 and not l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 then
    else
        local u354 = l__Classes__4._x3103fdab012bc1c0:_x44f73aa250bdf574();
        table.insert(u348._x7e2c022ba631eaff, l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gundraw", {
            fade_time = 0,
            force_look = true,
            override = {
                "Deflect",
                "Parry",
                "RAttack",
                "CAttack",
                "LAttack"
            }
        }));
        u348:_x77cfacde0d41d67c(u349, p350 and u349.draw_time or u349.shot_interval);
        u348._x6a42d95f79fc320f = true;
        local v355 = tonumber(u349.time_started) + u349.draw_time - workspace:GetServerTimeNow() - math.min(l__Classes__4._x596eb619070480ba._x0ebb8be9d0fb54be / 2, 0.1);
        local v356 = tostring(game.GameId);
        local v357 = 46;
        local u358 = nil;
        for v359 = 1, #v356 do
            v357 = (v357 * 33 + string.byte(v356, v359)) % 65521;
        end;
        if v357 == 272 and u354 then
            u358 = l__TweenService__7:Create(u354, TweenInfo.new(), {
                Value = 1
            }):Play();
        end;
        local u367 = LPH_JIT_MAX(function() --[[ Line: 732 ]]
            -- upvalues: u348 (copy), u358 (ref), u354 (copy), l__Classes__4 (ref), l__Packets__2 (ref), u3 (ref), l__Promise__1 (ref), u349 (copy)
            u348:_x250bf104186bc116();
            local v360 = tostring(game.GameId);
            local v361 = 46;
            for v362 = 1, #v360 do
                v361 = (v361 * 33 + string.byte(v360, v362)) % 65521;
            end;
            if v361 == 272 and u358 then
                u358:Cancel();
                u354.Value = 1;
            end;
            l__Classes__4.Util:cleanConnectionsTable(u348._xa9139f0d9d4b267d);
            for _, v363 in u348._xa2943846bb4c887f do
                v363:Destroy();
            end;
            u348._x8723a202bc5701a5 = l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3();
            u348._xf6e7a1991fe02124 = u348._xf8bc85aed8d72492.WorldPosition;
            l__Packets__2._x46607a58775a7f10:Fire(u3, u348._x8723a202bc5701a5, workspace.CurrentCamera.CFrame.Position + u348._x8723a202bc5701a5 * 1.5, (tostring(workspace:GetServerTimeNow())));
            u348._x697051f0c5bb84ab.Draw:Stop(0.0001);
            u348._x697051f0c5bb84ab.Fire:Play(0);
            l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gunshot", {
                fade_time = 0,
                force_look = true,
                override = {
                    "Deflect",
                    "Parry",
                    "RAttack",
                    "CAttack",
                    "LAttack",
                    "Gundraw"
                }
            });
            u348:_x2f0353c990c06798("Fire", 1, 1);
            l__Promise__1.delay(u349.shot_time):andThen(LPH_JIT_MAX(function() --[[ Line: 756 ]]
                -- upvalues: l__Classes__4 (ref)
                local l___x337410ce64f03086__30 = l__Classes__4._x337410ce64f03086;
                local v364 = tostring(game.GameId);
                local v365 = 46;
                for v366 = 1, #v364 do
                    v365 = (v365 * 33 + string.byte(v364, v366)) % 65521;
                end;
                if v365 == 272 and l___x337410ce64f03086__30._x7635ff7003194128 == "gun" then
                    l__Classes__4._x337410ce64f03086:_x958385851734f66b("melee");
                end;
            end));
            l__Classes__4._x2b1f81c73714b323:_x06defdf12fcc7217(unpack(u348._x712abf15db508ae2));
            u348:_x5fb1a16c9b5d2bde("shot", true);
            u348:_xf5d244762356c869("shot", u348._xf6e7a1991fe02124);
            l__Classes__4._xef0ffbcc2c92f7b4:_x453b523b854c9b40(u349);
        end);
        u348:_x0536b0bfef20540e(true);
        u348._x697051f0c5bb84ab.Draw:Play(0);
        local v368 = u348:_x5fb1a16c9b5d2bde("equip", true);
        u348._x41198087aee77709:Add(v368);
        u348:_x2f0353c990c06798("Draw", 1, 1);
        local u369 = u6;
        table.insert(u348._xe1be4e5d98e596e8, l__RunService__6.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function() --[[ Line: 777 ]]
            -- upvalues: u348 (copy), u369 (ref), l__Classes__4 (ref), u6 (ref)
            local l___x850704cd89e4e817__31 = u348._x850704cd89e4e817;
            local l___x41d71c4f92f98417__32 = u348._x41d71c4f92f98417;
            local l__CFrame__33 = workspace.CurrentCamera.CFrame;
            local v370, v371 = l__CFrame__33:ToObjectSpace(u369):ToOrientation();
            local v372 = tostring(game.GameId);
            local v373 = 46;
            for v374 = 1, #v372 do
                v373 = (v373 * 33 + string.byte(v372, v374)) % 65521;
            end;
            local v375;
            if v373 == 272 and l__Classes__4._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._x3d199abdbf08457d then
                v375 = l___x41d71c4f92f98417__32.slide_rot;
            else
                v375 = u6;
            end;
            u369 = l__CFrame__33;
            l___x850704cd89e4e817__31.sway_offset = l___x850704cd89e4e817__31.sway_offset:Lerp(CFrame.Angles(math.sin(-v370) * l___x41d71c4f92f98417__32.sway_amount, math.sin(-v371) * l___x41d71c4f92f98417__32.sway_amount, 0), 0.15);
            l___x850704cd89e4e817__31.slide_rot = l___x850704cd89e4e817__31.slide_rot:Lerp(v375, 0.1);
        end)));
        l__Classes__4.Util:bindRenderStepToTable(u348._xe1be4e5d98e596e8, l__Classes__4._x2b1f81c73714b323._x1550222c87a9e915 + 1, "gun_viewmodel", LPH_NO_VIRTUALIZE(function() --[[ Line: 789 ]]
            -- upvalues: l__Classes__4 (ref), u348 (copy)
            l__Classes__4._xaffa998c3a825e19:_x2ccb90caca713ad9(u348._xb841a7e475e1bc20);
            local l__CFrame__34 = workspace.CurrentCamera.CFrame;
            for _, v376 in u348._x850704cd89e4e817 do
                l__CFrame__34 = l__CFrame__34 * v376;
            end;
            u348._xb841a7e475e1bc20:PivotTo(l__CFrame__34);
        end));
        local v377 = tostring(game.GameId);
        local v378 = 46;
        for v379 = 1, #v377 do
            v378 = (v378 * 33 + string.byte(v377, v379)) % 65521;
        end;
        if v378 == 272 and v355 <= 0 then
            warn("CURRENT NOW HAS EXCEEDED EXPECTED SHOT TIME, FIRING NOW");
            u367();
        else
            local v380 = l__Promise__1.delay(v355);
            u348._x76765a150d3cc076 = v380;
            v380:andThen(LPH_JIT_MAX(function() --[[ Line: 812 ]]
                -- upvalues: u367 (copy)
                u367();
            end));
            local v381 = tostring(game.GameId);
            local v382 = 46;
            for v383 = 1, #v381 do
                v382 = (v382 * 33 + string.byte(v381, v383)) % 65521;
            end;
            if v382 == 272 and u5 then
                u5:cancel();
            end;
            u5 = l__Promise__1.delay(2);
            u5:andThen(LPH_JIT_MAX(function() --[[ Line: 824 ]]
                -- upvalues: u348 (copy)
                warn("FIRE TIMEOUT");
                u348:_x6346d08ccea5e934();
            end));
        end;
    end;
end;
function u4._x022aa2b28d850899(u384, u385) --[[ Line: 830 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy), u3 (ref), l__Promise__1 (copy), u9 (copy), l__TweenService__7 (copy), u5 (ref), u6 (copy), l__RunService__6 (copy)
    local v386 = tostring(game.GameId);
    local v387 = 46;
    for v388 = 1, #v386 do
        v387 = (v387 * 33 + string.byte(v386, v388)) % 65521;
    end;
    if v387 == 272 and not l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 then
    else
        local l__Hitbox__35 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Attack.Hitbox);
        local u389 = {
            Siege = {
                shape = "Cone",
                angle = 50,
                size = 100
            },
            Monarch = {
                shape = "Box",
                size = Vector3.new(8, 8, 1000),
                offset = CFrame.new(0, 0, -500)
            }
        };
        local u390 = l__Classes__4._x3103fdab012bc1c0:_x44f73aa250bdf574();
        local u391 = nil;
        table.insert(u384._x7e2c022ba631eaff, l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gundraw", {
            fade_time = 0,
            force_look = true,
            override = {
                "Deflect",
                "Parry",
                "RAttack",
                "CAttack",
                "LAttack"
            }
        }));
        u384:_x77cfacde0d41d67c(u385, u385.draw_time);
        u384._x6a42d95f79fc320f = true;
        local v392 = 0;
        local v393 = math.min(l__Classes__4._x596eb619070480ba._x0ebb8be9d0fb54be / 2, 0.1);
        local v394 = tonumber(u385.time_started);
        local v395 = workspace:GetServerTimeNow();
        local l__tags__36 = u385.tags;
        if l__tags__36 then
            l__tags__36 = u385.tags.bonus_shot;
        end;
        local u410 = LPH_JIT_MAX(function() --[[ Line: 866 ]]
            -- upvalues: u384 (copy), l__Classes__4 (ref), u389 (copy), l__Hitbox__35 (copy), l__Packets__2 (ref), u3 (ref), l__Promise__1 (ref), u385 (copy)
            u384._x697051f0c5bb84ab.Draw:Stop(0.0001);
            local v396 = tostring(game.GameId);
            local v397 = 46;
            for v398 = 1, #v396 do
                v397 = (v397 * 33 + string.byte(v396, v398)) % 65521;
            end;
            if v397 == 272 and u384._x697051f0c5bb84ab.BonusFire then
                u384._x697051f0c5bb84ab.BonusFire:Play(0);
            else
                local v399 = tostring(game.GameId);
                local v400 = 46;
                for v401 = 1, #v399 do
                    v400 = (v400 * 33 + string.byte(v399, v401)) % 65521;
                end;
                if v400 == 272 and u384._x697051f0c5bb84ab.Fire then
                    u384._x697051f0c5bb84ab.Fire:Play(0);
                end;
            end;
            u384:_x250bf104186bc116(false);
            u384._x8723a202bc5701a5 = l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3();
            u384._xf6e7a1991fe02124 = u384._xf8bc85aed8d72492.WorldPosition;
            local v402 = u389[u384._xf1f6e7333e01b49d];
            local l__CFrame__37 = workspace.CurrentCamera.CFrame;
            local v403 = tostring(game.GameId);
            local v404 = 46;
            local v405 = {};
            for v406 = 1, #v403 do
                v404 = (v404 * 33 + string.byte(v403, v406)) % 65521;
            end;
            if v404 == 272 and v402 then
                v402.origin = l__CFrame__37;
                v405 = l__Hitbox__35.new(v402):cast();
            else
                warn("NO HITBOX PARAMETERS FOR ITEM ID : ", u384._xf1f6e7333e01b49d);
            end;
            l__Packets__2._x6f11420c13d0d5ee:Fire(u3, l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3(), l__CFrame__37.Position, v405, (tostring(workspace:GetServerTimeNow())));
            local v407 = tostring(game.GameId);
            local v408 = 46;
            for v409 = 1, #v407 do
                v408 = (v408 * 33 + string.byte(v407, v409)) % 65521;
            end;
            if v408 == 272 and l__Classes__4._x63706a97ab028e93._xd3871c503e253e63.Bonusshot then
                l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Bonusshot", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "RAttack",
                        "CAttack",
                        "LAttack",
                        "Gundraw"
                    }
                });
            else
                l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gunshot", {
                    fade_time = 0,
                    force_look = true,
                    override = {
                        "Deflect",
                        "Parry",
                        "RAttack",
                        "CAttack",
                        "LAttack",
                        "Gundraw"
                    }
                });
            end;
            u384:_x2f0353c990c06798("Fire", 1, 1);
            l__Classes__4._x2b1f81c73714b323:_x06defdf12fcc7217(unpack(u384._x712abf15db508ae2));
            u384:_x5fb1a16c9b5d2bde("bonus_shot", true);
            l__Promise__1.defer(LPH_NO_VIRTUALIZE(function() --[[ Line: 903 ]]
                -- upvalues: u384 (ref)
                u384:_xf5d244762356c869("shot", u384._xf6e7a1991fe02124);
            end));
            l__Classes__4._xef0ffbcc2c92f7b4:_x453b523b854c9b40(u385);
        end);
        local v411 = tostring(game.GameId);
        local v412 = 46;
        for v413 = 1, #v411 do
            v412 = (v412 * 33 + string.byte(v411, v413)) % 65521;
        end;
        if v412 == 272 and l__tags__36 then
            for v414, _ in l__tags__36 do
                local l__shot_interval__38 = u384._xc694ad81e85c384a.shot_interval;
                v392 = v392 + l__shot_interval__38;
                local v415 = l__Promise__1.delay(v394 + u385.draw_time + l__shot_interval__38 * (v414 - 1) - v395 - v393);
                v415:andThen(LPH_JIT_MAX(function() --[[ Line: 920 ]]
                    -- upvalues: u410 (copy)
                    u410();
                end));
                u384._x41198087aee77709:AddPromise(v415);
            end;
        end;
        local u416 = v394 + u385.draw_time + v392;
        local v417 = u416 - v395 - v393;
        local u419 = LPH_NO_VIRTUALIZE(function() --[[ Line: 935 ]]
            -- upvalues: l__Classes__4 (ref), u384 (copy)
            l__Classes__4._xaffa998c3a825e19:_x2ccb90caca713ad9(u384._xb841a7e475e1bc20);
            local l__CFrame__39 = workspace.CurrentCamera.CFrame;
            for _, v418 in u384._x850704cd89e4e817 do
                l__CFrame__39 = l__CFrame__39 * v418;
            end;
            u384._xb841a7e475e1bc20:PivotTo(l__CFrame__39);
        end);
        local u420 = nil;
        local u421 = false;
        local u426 = LPH_NO_VIRTUALIZE(function() --[[ Line: 949 ]]
            -- upvalues: u421 (ref), u420 (ref)
            u421 = true;
            local v422 = tostring(game.GameId);
            local v423 = 46;
            for v424 = 1, #v422 do
                v423 = (v423 * 33 + string.byte(v422, v424)) % 65521;
            end;
            if v423 == 272 and not u420 then
            else
                local v425 = u420;
                u420 = nil;
                v425();
            end;
        end);
        local v427 = tostring(game.GameId);
        local u428 = u420;
        local u429 = u421;
        local v430 = 46;
        for v431 = 1, #v427 do
            v430 = (v430 * 33 + string.byte(v427, v431)) % 65521;
        end;
        if v430 == 272 and u385.tags.scope then
            local v432 = l__Promise__1.delay(v417 - u385.tags.scope.duration);
            v432:andThen(LPH_NO_VIRTUALIZE(function() --[[ Line: 966 ]]
                -- upvalues: u429 (ref), u9 (ref), u385 (copy), u416 (copy), u428 (ref), u384 (copy)
                local v433 = tostring(game.GameId);
                local v434 = 46;
                for v435 = 1, #v433 do
                    v434 = (v434 * 33 + string.byte(v433, v435)) % 65521;
                end;
                if v434 == 272 and u429 then
                else
                    local v436 = u9[u385.tags.scope.kind];
                    assert(v436, "Unsupported gun scope handler");
                    local u437 = v436(u416, 0.35);
                    u428 = u437;
                    u384._x41198087aee77709:Add(function() --[[ Line: 975 ]]
                        -- upvalues: u429 (ref), u428 (ref), u437 (copy)
                        u429 = true;
                        local v438 = tostring(game.GameId);
                        local v439 = 46;
                        for v440 = 1, #v438 do
                            v439 = (v439 * 33 + string.byte(v438, v440)) % 65521;
                        end;
                        if v439 == 272 and u428 == u437 then
                            u428 = nil;
                        end;
                        u437();
                    end);
                end;
            end));
            u384._x41198087aee77709:AddPromise(v432);
        end;
        local v441 = tostring(game.GameId);
        local v442 = 46;
        for v443 = 1, #v441 do
            v442 = (v442 * 33 + string.byte(v441, v443)) % 65521;
        end;
        if v442 == 272 and u390 then
            u391 = l__TweenService__7:Create(u390, TweenInfo.new(1), {
                Value = 1
            }):Play();
        end;
        local u462 = LPH_JIT_MAX(function() --[[ Line: 993 ]]
            -- upvalues: u384 (copy), u426 (copy), u419 (copy), u391 (ref), u390 (copy), l__Classes__4 (ref), u5 (ref), u389 (copy), l__Hitbox__35 (copy), l__Packets__2 (ref), u3 (ref), l__Promise__1 (ref), u385 (copy)
            u384._x697051f0c5bb84ab.Draw:Stop(0.0001);
            u384._x697051f0c5bb84ab.Fire:Play(0);
            u426();
            u384:_x250bf104186bc116();
            u419();
            local v444 = tostring(game.GameId);
            local v445 = 46;
            for v446 = 1, #v444 do
                v445 = (v445 * 33 + string.byte(v444, v446)) % 65521;
            end;
            if v445 == 272 and u391 then
                u391:Cancel();
                u390.Value = 1;
            end;
            l__Classes__4.Util:cleanConnectionsTable(u384._xa9139f0d9d4b267d);
            for _, v447 in u384._xa2943846bb4c887f do
                v447:Destroy();
            end;
            local v448 = tostring(game.GameId);
            local v449 = 46;
            for v450 = 1, #v448 do
                v449 = (v449 * 33 + string.byte(v448, v450)) % 65521;
            end;
            if v449 == 272 and u5 then
                u5:cancel();
            end;
            u384._x8723a202bc5701a5 = l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3();
            u384._xf6e7a1991fe02124 = u384._xf8bc85aed8d72492.WorldPosition;
            local v451 = u389[u384._xf1f6e7333e01b49d];
            local l__CFrame__40 = workspace.CurrentCamera.CFrame;
            local v452 = tostring(game.GameId);
            local v453 = 46;
            local v454 = {};
            for v455 = 1, #v452 do
                v453 = (v453 * 33 + string.byte(v452, v455)) % 65521;
            end;
            if v453 == 272 and v451 then
                v451.origin = l__CFrame__40;
                v454 = l__Hitbox__35.new(v451):cast();
            else
                warn("NO HITBOX PARAMETERS FOR ITEM ID : ", u384._xf1f6e7333e01b49d);
            end;
            l__Packets__2._x6f11420c13d0d5ee:Fire(u3, l__Classes__4._x2b1f81c73714b323:_xe472bf37dc82e1d3(), l__CFrame__40.Position, v454, (tostring(workspace:GetServerTimeNow())));
            local v456 = tostring(game.GameId);
            local v457 = 46;
            for v458 = 1, #v456 do
                v457 = (v457 * 33 + string.byte(v456, v458)) % 65521;
            end;
            if v457 == 272 and u384._x697051f0c5bb84ab.BonusFire then
                u384._x697051f0c5bb84ab.BonusFire:Stop(0.0001);
            end;
            l__Classes__4._x63706a97ab028e93:_xb4dbd9904936b73b("Gunshot", {
                fade_time = 0,
                force_look = true,
                override = {
                    "Deflect",
                    "Parry",
                    "RAttack",
                    "CAttack",
                    "LAttack",
                    "Gundraw",
                    "Bonusshot"
                }
            });
            u384:_x2f0353c990c06798("Fire", 1, 1);
            l__Promise__1.delay(u385.shot_time):andThen(LPH_JIT_MAX(function() --[[ Line: 1039 ]]
                -- upvalues: l__Classes__4 (ref)
                local l___x337410ce64f03086__41 = l__Classes__4._x337410ce64f03086;
                local v459 = tostring(game.GameId);
                local v460 = 46;
                for v461 = 1, #v459 do
                    v460 = (v460 * 33 + string.byte(v459, v461)) % 65521;
                end;
                if v460 == 272 and l___x337410ce64f03086__41._x7635ff7003194128 == "gun" then
                    l__Classes__4._x337410ce64f03086:_x958385851734f66b("melee");
                end;
            end));
            l__Classes__4._x2b1f81c73714b323:_x06defdf12fcc7217(unpack(u384._x712abf15db508ae2));
            u384:_x5fb1a16c9b5d2bde("shot", true);
            u384:_xf5d244762356c869("shot", u384._xf6e7a1991fe02124);
            l__Classes__4._xef0ffbcc2c92f7b4:_x453b523b854c9b40(u385);
        end);
        u384:_x0536b0bfef20540e(true);
        u384._x697051f0c5bb84ab.Draw:Play(0);
        local v463 = u384:_x5fb1a16c9b5d2bde("equip", true);
        u384._x41198087aee77709:Add(v463);
        u384:_x2f0353c990c06798("Draw", 1, 1);
        local u464 = u6;
        table.insert(u384._xe1be4e5d98e596e8, l__RunService__6.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function() --[[ Line: 1060 ]]
            -- upvalues: u384 (copy), u464 (ref), l__Classes__4 (ref), u6 (ref)
            local l___x850704cd89e4e817__42 = u384._x850704cd89e4e817;
            local l___x41d71c4f92f98417__43 = u384._x41d71c4f92f98417;
            local l__CFrame__44 = workspace.CurrentCamera.CFrame;
            local v465, v466 = l__CFrame__44:ToObjectSpace(u464):ToOrientation();
            local v467 = tostring(game.GameId);
            local v468 = 46;
            for v469 = 1, #v467 do
                v468 = (v468 * 33 + string.byte(v467, v469)) % 65521;
            end;
            local v470;
            if v468 == 272 and l__Classes__4._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._x3d199abdbf08457d then
                v470 = l___x41d71c4f92f98417__43.slide_rot * l___x41d71c4f92f98417__43.slide_offset;
            else
                v470 = u6;
            end;
            u464 = l__CFrame__44;
            l___x850704cd89e4e817__42.sway_offset = l___x850704cd89e4e817__42.sway_offset:Lerp(CFrame.Angles(math.sin(-v465) * l___x41d71c4f92f98417__43.sway_amount, math.sin(-v466) * l___x41d71c4f92f98417__43.sway_amount, 0), 0.15);
            l___x850704cd89e4e817__42.slide_rot = l___x850704cd89e4e817__42.slide_rot:Lerp(v470, 0.1);
        end)));
        l__Classes__4.Util:bindRenderStepToTable(u384._xe1be4e5d98e596e8, l__Classes__4._x2b1f81c73714b323._x1550222c87a9e915 + 1, "gun_viewmodel", LPH_NO_VIRTUALIZE(function() --[[ Line: 1074 ]]
            -- upvalues: u419 (copy)
            u419();
        end));
        local v471 = tostring(game.GameId);
        local v472 = 46;
        for v473 = 1, #v471 do
            v472 = (v472 * 33 + string.byte(v471, v473)) % 65521;
        end;
        if v472 == 272 and v417 <= 0 then
            warn("CURRENT NOW HAS EXCEEDED EXPECTED SHOT TIME, FIRING NOW");
            u462();
        else
            local v474 = l__Promise__1.delay(v417);
            u384._x76765a150d3cc076 = v474;
            v474:andThen(LPH_JIT_MAX(function() --[[ Line: 1091 ]]
                -- upvalues: u462 (copy)
                u462();
            end));
            local v475 = tostring(game.GameId);
            local v476 = 46;
            for v477 = 1, #v475 do
                v476 = (v476 * 33 + string.byte(v475, v477)) % 65521;
            end;
            if v476 == 272 and u5 then
                u5:cancel();
            end;
            u5 = l__Promise__1.delay(5);
            u5:andThen(LPH_JIT_MAX(function() --[[ Line: 1103 ]]
                -- upvalues: u384 (copy)
                warn("FIRE TIMEOUT");
                u384:_x6346d08ccea5e934();
            end));
        end;
    end;
end;
function u4._xfb1f81c23a7008b1(p478) --[[ Line: 1109 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy), u3 (ref)
    local v479 = tostring(game.GameId);
    local v480 = 46;
    for v481 = 1, #v479 do
        v480 = (v480 * 33 + string.byte(v479, v481)) % 65521;
    end;
    if v480 == 272 and (not l__Classes__4._xef0ffbcc2c92f7b4._x539c98577c3cf168 or (p478._x6a42d95f79fc320f or (not p478._xc694ad81e85c384a or p478._xcdec2743d7c8310e))) then
    else
        p478._xcdec2743d7c8310e = true;
        p478._x91f6be3e93ee2005 = false;
        local v482 = l__Packets__2._xb0f023e4d9d34617:Fire(u3, p478._xf1f6e7333e01b49d);
        local v483 = tostring(game.GameId);
        local v484 = 46;
        for v485 = 1, #v483 do
            v484 = (v484 * 33 + string.byte(v483, v485)) % 65521;
        end;
        if v484 == 272 and (v482 and not p478._x91f6be3e93ee2005) then
            local v486 = tostring(game.GameId);
            local v487 = 46;
            for v488 = 1, #v486 do
                v487 = (v487 * 33 + string.byte(v486, v488)) % 65521;
            end;
            if v487 == 272 and p478._xc694ad81e85c384a.tags.hitbox then
                p478:_x022aa2b28d850899(v482, true);
            else
                local v489 = tostring(game.GameId);
                local v490 = 46;
                for v491 = 1, #v489 do
                    v490 = (v490 * 33 + string.byte(v489, v491)) % 65521;
                end;
                if v490 == 272 and p478._xc694ad81e85c384a.tags.projectile then
                    p478:_xfceb48b9ebb9d756(v482, true);
                else
                    p478:_x9d3573df3d5ca26f(v482, true);
                end;
            end;
        else
            p478:_x6346d08ccea5e934();
        end;
    end;
end;
function u4._xe8c09bbe54552163(p492) --[[ Line: 1130 ]]
    -- upvalues: u5 (ref), l__InternalSymbols__5 (copy), l__Classes__4 (copy)
    p492:_x0536b0bfef20540e(false);
    for _, v493 in p492._xa2943846bb4c887f do
        local v494 = tostring(game.GameId);
        local v495 = 46;
        for v496 = 1, #v494 do
            v495 = (v495 * 33 + string.byte(v494, v496)) % 65521;
        end;
        if v495 == 272 and v493 then
            v493:Destroy();
        end;
    end;
    local v497 = tostring(game.GameId);
    local v498 = 46;
    for v499 = 1, #v497 do
        v498 = (v498 * 33 + string.byte(v497, v499)) % 65521;
    end;
    if v498 == 272 and u5 then
        u5:cancel();
    end;
    local v500 = tostring(game.GameId);
    local v501 = 46;
    for v502 = 1, #v500 do
        v501 = (v501 * 33 + string.byte(v500, v502)) % 65521;
    end;
    if v501 == 272 and p492.crosshair then
        l__InternalSymbols__5.owner("", p492.crosshair):cleanUp();
    end;
    for v503, v504 in p492._x82ff6cea32389a9f do
        local v505 = table.find(v503, v504);
        local v506 = tostring(game.GameId);
        local v507 = 46;
        for v508 = 1, #v506 do
            v507 = (v507 * 33 + string.byte(v506, v508)) % 65521;
        end;
        if v507 == 272 and v505 then
            table.remove(v503, v505);
        end;
    end;
    p492._x82ff6cea32389a9f = {};
    p492._x6a42d95f79fc320f = false;
    p492._xcdec2743d7c8310e = false;
    p492._xa499eade9887156e = nil;
    p492._x0ee373a33926e866 = 0;
    p492._xb4ace6cf46dfc446 = 0;
    p492._xf66560f84e5fde19 = 0;
    p492._x9e646643f5a00f04 = 0;
    p492._x95dc57b21abd2541 = false;
    p492._x76765a150d3cc076:cancel();
    l__Classes__4.Util:stopAnimations(p492._x9c71d62e4a34208d);
    l__Classes__4.Util:cleanConnectionsTable(p492._xe1be4e5d98e596e8);
    l__Classes__4.Util:cleanConnectionsTable(p492._xa9139f0d9d4b267d);
end;
function u4.cleanUp(p509) --[[ Line: 1167 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy)
    l__Classes__4.Util:cleanConnectionsTable(p509._x3e7ad28bf56c5405);
    l__Classes__4._x63706a97ab028e93:_x636c5bb508bea4b6(p509._xf1f6e7333e01b49d);
    l__Packets__2._xcfd25ad2550161be:Fire(p509._xf1f6e7333e01b49d);
    local v510 = tostring(game.GameId);
    local v511 = 46;
    for v512 = 1, #v510 do
        v511 = (v511 * 33 + string.byte(v510, v512)) % 65521;
    end;
    if v511 == 272 and p509._xb841a7e475e1bc20 then
        p509._xb841a7e475e1bc20:Destroy();
    end;
    warn(string.format("%s CLEANED", p509._x7799b9a5f8275e5d));
end;
function u4._x0536b0bfef20540e(p513, p514) --[[ Line: 1178 ]]
    p513._x50add4bf329c5dbb = p514;
    local v515 = tostring(game.GameId);
    local v516 = 46;
    for v517 = 1, #v515 do
        v516 = (v516 * 33 + string.byte(v515, v517)) % 65521;
    end;
    if v516 == 272 and p514 then
        p513._xf9edef777a876219 = CFrame.new(0, 0, 0);
    else
        p513._xf9edef777a876219 = CFrame.new(9999, 9999, 9999);
    end;
end;
function u4._xce2d7efe7c6824f4(p518) --[[ Line: 1187 ]]
    -- upvalues: l__Classes__4 (copy)
    l__Classes__4._xaffa998c3a825e19:_x13697463c1bee658(p518._x9c71d62e4a34208d, p518._x697051f0c5bb84ab, p518:_x5da6b7a5064d647d());
end;
function u4._xa0afbfd34c9ed306(p519) --[[ Line: 1191 ]]
    -- upvalues: u3 (ref), l__Packets__2 (copy), l__Classes__4 (copy)
    local v520 = tostring(game.GameId);
    local v521 = 46;
    for v522 = 1, #v520 do
        v521 = (v521 * 33 + string.byte(v520, v522)) % 65521;
    end;
    if v521 == 272 and u3 then
        p519._xc694ad81e85c384a = l__Packets__2._xe3f2932c4e467d66:Fire(u3, p519._xf1f6e7333e01b49d);
        l__Classes__4._x3103fdab012bc1c0:_xea7f02709f56fb9f(p519._xc694ad81e85c384a);
    else
        warn("NO TOKEN TO GET GUN DATA.");
    end;
end;
function u4._xd8041402b83e75db(u523) --[[ Line: 1200 ]]
    -- upvalues: l__Classes__4 (copy), l__Promise__1 (copy), u3 (ref), l__Packets__2 (copy)
    u523._xb841a7e475e1bc20:ScaleTo(u523._x993df2ff1969ab94.model_scale or 0.5);
    u523:_x0536b0bfef20540e(false);
    l__Classes__4._xaffa998c3a825e19:_x46bad0c4ade44563(u523._xb841a7e475e1bc20, "RightArm");
    l__Promise__1.defer(LPH_NO_VIRTUALIZE(function() --[[ Line: 1205 ]]
        -- upvalues: u523 (copy)
        u523._xb841a7e475e1bc20.Parent = workspace.CurrentCamera;
        u523:_xce2d7efe7c6824f4();
    end));
    l__Classes__4._x63706a97ab028e93:_x19c65ea5cce68db4(u523._xf1f6e7333e01b49d, u523._x4cc6ec36efbfcd87);
    table.insert(u523._x3e7ad28bf56c5405, game.Players.LocalPlayer.CharacterAdded:Connect(LPH_NO_VIRTUALIZE(function() --[[ Line: 1211 ]]
        -- upvalues: l__Classes__4 (ref), u523 (copy)
        l__Classes__4._x63706a97ab028e93:_x19c65ea5cce68db4(u523._xf1f6e7333e01b49d, u523._x4cc6ec36efbfcd87);
    end)));
    u3 = l__Packets__2._x57c165550ede3092:Fire(u523._xf1f6e7333e01b49d);
    task.defer(LPH_JIT_MAX(function() --[[ Line: 1217 ]]
        -- upvalues: u523 (copy)
        u523:_xa0afbfd34c9ed306();
    end));
    l__Classes__4.Util:bindRenderStepToTable(u523._x3e7ad28bf56c5405, l__Classes__4._x2b1f81c73714b323._x1550222c87a9e915 + 2, "gun_visibility", LPH_NO_VIRTUALIZE(function() --[[ Line: 1221 ]]
        -- upvalues: l__Classes__4 (ref), u523 (copy)
        local v524 = tostring(game.GameId);
        local v525 = 46;
        for v526 = 1, #v524 do
            v525 = (v525 * 33 + string.byte(v524, v526)) % 65521;
        end;
        if v525 == 272 and (not l__Classes__4._xaffa998c3a825e19._x0e0d0acaaa1322c0 or l__Classes__4._xaffa998c3a825e19._x1335cc4c6d69b5dc) then
            u523._xb841a7e475e1bc20:PivotTo(CFrame.new(99999, 99999, 99999));
        else
            local v527 = tostring(game.GameId);
            local v528 = 46;
            for v529 = 1, #v527 do
                v528 = (v528 * 33 + string.byte(v527, v529)) % 65521;
            end;
            if v528 == 272 and not u523._x50add4bf329c5dbb then
                u523._xb841a7e475e1bc20:PivotTo(u523._xf9edef777a876219);
            end;
        end;
    end));
    task.defer(LPH_JIT_MAX(function() --[[ Line: 1233 ]]
        -- upvalues: u523 (copy), l__Packets__2 (ref), l__Classes__4 (ref)
        table.insert(u523._x3e7ad28bf56c5405, l__Packets__2._xbbc61c8e01527b7c.OnClientEvent:Connect(LPH_JIT_MAX(function() --[[ Line: 1234 ]]
            -- upvalues: u523 (ref)
            u523:_x6346d08ccea5e934();
        end)));
        local l___x3e7ad28bf56c5405__45 = u523._x3e7ad28bf56c5405;
        local l__Pressed__46 = l__Classes__4._xd2c44c643b0c3fb4:_xdf0c107e49196810("PARRY").Pressed;
        table.insert(l___x3e7ad28bf56c5405__45, l__Pressed__46:Connect(LPH_JIT_MAX(function() --[[ Line: 1238 ]]
            -- upvalues: u523 (ref)
            u523:_x96f8a14800fcbd4c();
        end)));
        local l___x3e7ad28bf56c5405__47 = u523._x3e7ad28bf56c5405;
        local l__Pressed__48 = l__Classes__4._xd2c44c643b0c3fb4:_xdf0c107e49196810("GUN").Pressed;
        table.insert(l___x3e7ad28bf56c5405__47, l__Pressed__48:Connect(LPH_JIT_MAX(function() --[[ Line: 1242 ]]
            -- upvalues: u523 (ref), l__Classes__4 (ref)
            local v530 = tostring(game.GameId);
            local v531 = 46;
            for v532 = 1, #v530 do
                v531 = (v531 * 33 + string.byte(v530, v532)) % 65521;
            end;
            if v531 == 272 and not u523._xc694ad81e85c384a then
            else
                local l___x27395816f3884377__49 = l__Classes__4._x596eb619070480ba._x27395816f3884377;
                local l__Value__50 = l___x27395816f3884377__49.heat_per_bullet.Value;
                local l__Value__51 = l___x27395816f3884377__49.heat.Value;
                local v533 = u523._xc694ad81e85c384a.tags["two-handed"];
                local v534 = tostring(game.GameId);
                local v535 = 46;
                for v536 = 1, #v534 do
                    v535 = (v535 * 33 + string.byte(v534, v536)) % 65521;
                end;
                if v535 == 272 and (not u523._xcdec2743d7c8310e and (not u523._x6a42d95f79fc320f and (l__Value__50 <= l__Value__51 and (not l__Classes__4._x596eb619070480ba._x730775c5207957d3.is_breaking and l__Classes__4._x596eb619070480ba._x885b2725a1933f2e == "alive")))) then
                    for v537, v538 in u523._x82ff6cea32389a9f do
                        local v539 = table.find(v537, v538);
                        local v540 = tostring(game.GameId);
                        local v541 = 46;
                        for v542 = 1, #v540 do
                            v541 = (v541 * 33 + string.byte(v540, v542)) % 65521;
                        end;
                        if v541 == 272 and v539 then
                            table.remove(v537, v539);
                        end;
                    end;
                    local v543 = tostring(game.GameId);
                    local v544 = 46;
                    for v545 = 1, #v543 do
                        v544 = (v544 * 33 + string.byte(v543, v545)) % 65521;
                    end;
                    if v544 == 272 and v533 then
                        local v546 = l__Classes__4._x337410ce64f03086:_x3efa7d2770a422ee("augment");
                        local v547 = game:GetService("HttpService"):GenerateGUID();
                        local v548 = tostring(game.GameId);
                        local v549 = 46;
                        for v550 = 1, #v548 do
                            v549 = (v549 * 33 + string.byte(v548, v550)) % 65521;
                        end;
                        if v549 == 272 and v546 then
                            table.insert(v546._x2971e768368ab755, v547);
                            u523._x82ff6cea32389a9f[v546._x2971e768368ab755] = v547;
                        end;
                        local v551 = l__Classes__4._xd2c44c643b0c3fb4:_xdf0c107e49196810("AUGMENT");
                        table.insert(v551.Blockers, v547);
                        u523._x82ff6cea32389a9f[v551.Blockers] = v547;
                        l__Classes__4._xd2c44c643b0c3fb4:_xa377b6761ab0740f("AUGMENT");
                    end;
                    l__Classes__4._x337410ce64f03086:_x958385851734f66b("gun");
                end;
            end;
        end)));
    end));
end;
return u4;
