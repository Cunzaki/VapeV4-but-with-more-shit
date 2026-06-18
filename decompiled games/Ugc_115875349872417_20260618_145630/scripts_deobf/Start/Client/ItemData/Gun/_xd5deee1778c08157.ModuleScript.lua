-- Decompiled from: Start.Client.ItemData.Gun._xd5deee1778c08157
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

    function LPH_NO_VIRTUALIZE(p2)
        return p2;
    end;
end;
local l__Promise__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Packets__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets) -- Packets;
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
    monarchScopeIn = function(p7, p8) --[[ Line: 35 ]]
        -- upvalues: l__Classes__4 (copy)
        return l__Classes__4._x255cd8d76027f039:_x70c1945e7032f1be(p7, p8);
    end
};
function u4._x90d4581ac99dd483(p10, p11, p12) --[[ Line: 40 ]]
    -- upvalues: u4 (copy), l__Trove__3 (copy), l__Promise__1 (copy)
    local v13 = setmetatable({}, u4);
    local v14 = p11 or {};
    local v15 = p12 or {};
    v13._xaf95301040bf877f = v15;
    v13._x7b47345bff92786e = v15.render_context;
    local l___x7b47345bff92786e__8 = v13._x7b47345bff92786e;
    if l___x7b47345bff92786e__8 then
        l___x7b47345bff92786e__8 = v13._x7b47345bff92786e.item_id;
    end;
    v13._x850fb72bedc0eacc = l___x7b47345bff92786e__8;
    v13._xcfe3e118053886b5 = v15.animation_source;
    v13._x8703b52a47175c59 = v15.animations_3p;
    v13._x4034dcd9337c4ea0 = "BaseGun";
    v13._x57f55f05c54c5863 = {};
    v13._x0211cb82d66ed99b = {};
    v13._x4e962b44bc166476 = {};
    v13._x721903c2557f3d22 = l__Trove__3.new();
    v13._x22a4f1cdca62d968 = {};
    v13._x0fd136c9c08cfbc3 = {};
    v13._xd5a82911ccd71c0b = false;
    v13._xec7b9d181ba2c12b = false;
    v13._x8e98c8665437fd02 = nil;
    v13._x606caf6edcb0fe97 = 0;
    v13._xcf93f169dbd89daf = 0;
    v13._xbc41b1af1cd55158 = 0;
    v13._xebba98f5a3ce59b4 = 0;
    v13._xb9f7cfbffb6ba69e = l__Promise__1.resolve();
    v13._xf5983b8666055755 = {
        slide_rot = CFrame.new(),
        sway_offset = CFrame.new(),
        base_offset = v14.base_offset or CFrame.new(0, 0, 0.085)
    };
    v13._x0422388900551318 = {
        slide_offset = v14.slide_offset or CFrame.new(),
        slide_rot = v14.slide_rot or CFrame.Angles(0, 0, 0.17453292519943295),
        sway_amount = v14.sway_amount or 0.5
    };
    v13._x4780cee9c2e35076 = false;
    v13._xee20d740f560ba8c = CFrame.new();
    v13._xa767b76951528128 = {};
    v13._xf6283a2b4ef130b0 = {};
    v13._x13e3faed2ed5902b = p10;
    v13._x51c29ca818c5a13c = false;
    local v16 = v15.effects or {};
    local v17;
    if v16.show_tracer == nil then
        v17 = v15.show_tracer or false;
    else
        v17 = v16.show_tracer;
    end;
    v13._xbe42f5bd934177fd = {
        shot = v16.shot or (v15.shot_effect or "castigateFlash"),
        show_tracer = v17
    };
    local v18 = v15.sounds or {};
    v13._x7f6da09d603ba256 = {
        equip = v18.equip or (v15.equip_sound or "SPIN_GUN"),
        shot = v18.shot or (v15.shot_sound or "KURO_SHOT"),
        lock_in = v18.lock_in or (v15.lock_in or "NEXTEL"),
        lock_off = v18.lock_off or (v15.lock_off or "LOST_TARGET"),
        shot_hit = v18.shot_hit or (v15.shot_hit or "GUN_HIT"),
        dry_fire = v18.dry_fire or (v15.dry_fire or "DRY_FIRE"),
        bonus_shot = v18.bonus_shot or (v15.bonus_shot_sound or v18.shot or (v15.shot_sound or "KURO_SHOT"))
    };
    v13._x3f030f36c034cfb5 = v15.recoil_args or {
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
    v13._x8f8f3c55f1e79ebe = v15.gunpoint or (v13._x13e3faed2ed5902b:FindFirstChild("Gunpoint", true) or v13._x13e3faed2ed5902b:FindFirstChild("GunPoint", true));
    v13._x2dbab9f27e7f0ca1 = v13._x13e3faed2ed5902b:FindFirstChildWhichIsA("Animator", true);
    v13._xf349702abeec1dea = nil;
    v13._xfe6e1614a25e0272 = nil;
    v13._xaab598a46a296fa7 = false;
    return v13;
end;
function u4._xf89ba7ae4cd9bf78(p19, p20, p21, p22) --[[ Line: 118 ]]
    -- upvalues: l__Classes__4 (copy)
    return l__Classes__4._x51bf23f1b9ed859b:_xc782ad79ba49be57({
        sounds = {
            [p20] = p19._x7f6da09d603ba256[p20] or p20
        }
    }, l__Classes__4._xbe184fb1376a575d, p20, p21, p22);
end;
function u4._x30c63f8f2bd70f3c(p23, p24, ...) --[[ Line: 123 ]]
    -- upvalues: l__Classes__4 (copy)
    return l__Classes__4._x51bf23f1b9ed859b:_x1e643afd7367aa17({
        effects = {
            [p24] = p23._xbe42f5bd934177fd[p24] or p24
        }
    }, p24, ...);
end;
function u4._xba48ec5865d2872d(p25) --[[ Line: 128 ]]
    return p25._x850fb72bedc0eacc or p25._xcfe3e118053886b5;
end;
function u4._x8a47335f38cccd86(p26, p27, p28, p29) --[[ Line: 132 ]]
    -- upvalues: l__Classes__4 (copy)
    local v30 = p26:_xba48ec5865d2872d();
    return l__Classes__4._x32ae459de0772e82:_x6bcb757f3207ce9e(v30, p27, p28, p29, v30);
end;
function u4._xc0c41c03168537df(p31) --[[ Line: 137 ]]
    -- upvalues: l__Classes__4 (copy), u5 (ref)
    local v32 = l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b == "gun" and true or (p31._xd5a82911ccd71c0b or p31._x51c29ca818c5a13c);
    p31._x721903c2557f3d22:Clean();
    for _, v33 in p31._x4e962b44bc166476 do
        if v33 then
            v33:Destroy();
        end;
    end;
    table.clear(p31._x4e962b44bc166476);
    l__Classes__4.Util:cleanConnectionsTable(p31._x0211cb82d66ed99b);
    if p31._xb9f7cfbffb6ba69e then
        p31._xb9f7cfbffb6ba69e:cancel();
    end;
    if u5 then
        u5:cancel();
    end;
    p31:_x94a830a36a63b78f(false);
    p31._x51c29ca818c5a13c = false;
    p31._xd5a82911ccd71c0b = false;
    p31._x8e98c8665437fd02 = nil;
    p31._x606caf6edcb0fe97 = 0;
    p31._xcf93f169dbd89daf = 0;
    p31._xbc41b1af1cd55158 = 0;
    p31._xebba98f5a3ce59b4 = 0;
    p31._xec7b9d181ba2c12b = false;
    p31._xaab598a46a296fa7 = true;
    for _, v34 in p31._xf6283a2b4ef130b0 do
        v34:Stop(0.01);
    end;
    table.clear(p31._xf6283a2b4ef130b0);
    local v35 = l__Classes__4._xafc4950d7b094088:_x1c4ac4ec2fd3ec91();
    if v35 then
        v35.Value = 0;
    end;
    if v32 then
        task.defer(function() --[[ Line: 178 ]]
            -- upvalues: l__Classes__4 (ref)
            if l__Classes__4._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" and l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b ~= "melee" then
                l__Classes__4._xd1706540247308ea:_xabcc58e6f4374b9e("melee");
            end;
        end;
    end;
end;
function u4._xd5d565e93d25f5b8(p36, p37, p38) --[[ Line: 186 ]]
    p36._x8e98c8665437fd02 = p37;
    p36._x606caf6edcb0fe97 = p38;
    p36._xcf93f169dbd89daf = os.clock();
    p36._xebba98f5a3ce59b4 = p37.shot_time or 0;
    p36._xbc41b1af1cd55158 = 0;
    p36._xec7b9d181ba2c12b = false;
end;
function u4._x3a3408ac26173680(p39, p40) --[[ Line: 195 ]]
    p39._xec7b9d181ba2c12b = true;
    if p40 ~= false then
        p39._xbc41b1af1cd55158 = os.clock();
    end;
end;
function u4._xa01e4a0382cfd493(p41) --[[ Line: 202 ]]
    local l___x8e98c8665437fd02__9 = p41._x8e98c8665437fd02;
    if l___x8e98c8665437fd02__9 then
        l___x8e98c8665437fd02__9 = tonumber(p41._x8e98c8665437fd02.time_started);
    end;
    if l___x8e98c8665437fd02__9 then
        return workspace:GetServerTimeNow() - l___x8e98c8665437fd02__9;
    else
        return os.clock() - p41._xcf93f169dbd89daf;
    end;
end;
function u4._x5c5e4ade12692a07(p42) --[[ Line: 211 ]]
    -- upvalues: l__Classes__4 (copy)
    if l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b ~= "gun" or (not p42._x51c29ca818c5a13c or p42._xec7b9d181ba2c12b) then
        return false;
    end;
    local l___x8e98c8665437fd02__10 = p42._x8e98c8665437fd02;
    if not l___x8e98c8665437fd02__10 or l___x8e98c8665437fd02__10.parry_cancellable ~= true then
        return false;
    end;
    local v43 = l___x8e98c8665437fd02__10.parry_cancel_time or 0.7;
    local v44 = p42._x606caf6edcb0fe97 or (l___x8e98c8665437fd02__10.draw_time or 0);
    if v44 <= v43 then
        return false;
    end;
    local v45 = p42:_xa01e4a0382cfd493();
    local v46;
    if v43 <= v45 then
        v46 = v45 < v44;
    else
        v46 = false;
    end;
    return v46;
end;
function u4._x04bc11a6ed7ca03c(p47) --[[ Line: 231 ]]
    -- upvalues: l__Classes__4 (copy)
    if l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b ~= "gun" or not (p47._x51c29ca818c5a13c and p47._xec7b9d181ba2c12b) then
        return false;
    end;
    local l___x8e98c8665437fd02__11 = p47._x8e98c8665437fd02;
    if not l___x8e98c8665437fd02__11 or l___x8e98c8665437fd02__11.holster_parry_cancellable == false then
        return false;
    end;
    local v48 = l___x8e98c8665437fd02__11.holster_parry_cancel_time or 0.7;
    local v49 = p47._xebba98f5a3ce59b4 or (l___x8e98c8665437fd02__11.shot_time or 0);
    if v49 <= v48 then
        return false;
    end;
    if p47._xbc41b1af1cd55158 <= 0 then
        return false;
    end;
    local v50 = os.clock() - p47._xbc41b1af1cd55158;
    local v51;
    if v48 <= v50 then
        v51 = v50 < v49;
    else
        v51 = false;
    end;
    return v51;
end;
function u4._x6c6d491eafed896a(p52) --[[ Line: 255 ]]
    -- upvalues: l__Classes__4 (copy)
    if p52:_x5c5e4ade12692a07() or p52:_x04bc11a6ed7ca03c() then
        local v53 = l__Classes__4._xd1706540247308ea:_x372c01be8a28bc70("melee");
        if v53 and (typeof(v53._x18da794854d4ae00) == "function" and v53:_x18da794854d4ae00()) then
            p52._x721903c2557f3d22:Clean();
            l__Classes__4._xd1706540247308ea:_xabcc58e6f4374b9e("melee");
            v53:_xc3837e3fd8cfd093();
        end;
    end;
end;
function u4._x72baca0219a3d784(u54, p55, p56) --[[ Line: 270 ]]
    -- upvalues: l__Classes__4 (copy), l__Promise__1 (copy), l__Packets__2 (copy), u6 (copy), l__RunService__6 (copy), l__TweenService__7 (copy), u3 (ref)
    local u57 = false;
    local u58 = l__Classes__4._xafc4950d7b094088:_x1c4ac4ec2fd3ec91();
    local u67 = function(p59, _, p60) --[[ Line: 276 ]]
        -- upvalues: l__Classes__4 (ref), u54 (copy)
        local function v65(u61, u62) --[[ Line: 277 ]]
            -- upvalues: l__Classes__4 (ref), u54 (ref)
            l__Classes__4._x255cd8d76027f039:_x15cfa3355252d8ab(u54._xfe6e1614a25e0272, u54._xf349702abeec1dea, u62, u54._xbe42f5bd934177fd.show_tracer);
            local v63 = math.clamp((workspace.CurrentCamera.CFrame.Position - u62).Magnitude, 10, 200);
            local u64 = l__Classes__4.Util:convNumRange(v63, 10, 200, 0.25, 0.2);
            table.clear(u54._xf6283a2b4ef130b0);
            task.delay(0.07, function() --[[ Line: 288 ]]
                -- upvalues: l__Classes__4 (ref), u62 (copy), u61 (copy), u64 (copy)
                l__Classes__4._x255cd8d76027f039:_x9917b899e6060d83(u62, u62 + -u61.Normal * 5);
                l__Classes__4._xbe184fb1376a575d:_x7ab8b42cc5920a78("BULLET_RICOCHET", true).Volume = u64;
                l__Classes__4._xbe184fb1376a575d:_x7ab8b42cc5920a78("BULLET_IMPACT", true).Volume = u64 * 3;
            end;
        end;
        if p60 then
            l__Classes__4._x255cd8d76027f039:_x15cfa3355252d8ab(u54._xfe6e1614a25e0272, u54._xf349702abeec1dea, p60.Position, p59.show_tracer);
        else
            local v66 = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, u54._xfe6e1614a25e0272 * 300, l__Classes__4.Util:getBasicRaycastParams());
            if v66 then
                v65(v66, v66.Position);
            else
                l__Classes__4._x255cd8d76027f039:_x15cfa3355252d8ab(u54._xfe6e1614a25e0272, u54._xf349702abeec1dea, workspace.CurrentCamera.CFrame.Position + u54._xfe6e1614a25e0272 * 300, u54._xbe42f5bd934177fd.show_tracer);
                l__Classes__4._xbe184fb1376a575d:_x7ab8b42cc5920a78("BULLET_RICOCHET", true).Volume = 0.2;
            end;
        end;
    end;
    local u70 = function(p68) --[[ Line: 319 ]]
        -- upvalues: u57 (ref), u58 (copy), u54 (copy), l__Classes__4 (ref), l__Promise__1 (ref)
        if u57 then
        else
            if u58 then
                u58.Value = 1;
            end;
            u57 = true;
            u54:_x3a3408ac26173680();
            l__Classes__4.Util:cleanConnectionsTable(u54._x0211cb82d66ed99b);
            for _, v69 in u54._x4e962b44bc166476 do
                v69:Destroy();
            end;
            u54._xfe6e1614a25e0272 = l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c();
            u54._xf349702abeec1dea = u54._x8f8f3c55f1e79ebe.WorldPosition;
            u54._xa767b76951528128.Draw:Stop(0.0001);
            u54._xa767b76951528128.Fire:Play(0);
            l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gunshot", {
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
            u54:_x8a47335f38cccd86("Fire", 1, 1);
            l__Promise__1.delay(p68.shot_time):andThen(function() --[[ Line: 340 ]]
                -- upvalues: l__Classes__4 (ref)
                if l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b == "gun" then
                    l__Classes__4._xd1706540247308ea:_xabcc58e6f4374b9e("melee");
                end;
            end;
            l__Classes__4._x32ae459de0772e82:_x8ee1ac854964ea1a(unpack(u54._x3f030f36c034cfb5));
            u54:_xf89ba7ae4cd9bf78("shot", true);
            u54:_x30c63f8f2bd70f3c("shot", u54._xf349702abeec1dea);
            l__Classes__4._x7058397dabccd000:_xfd2bbe952d55830d(p68);
        end;
    end;
    function(u71, p72) --[[ Line: 354 ]]
        -- upvalues: l__Classes__4 (ref), u54 (copy), l__Packets__2 (ref), u70 (copy), u67 (copy), l__Promise__1 (ref), u57 (ref), u6 (ref), l__RunService__6 (ref), l__TweenService__7 (ref), u3 (ref), u58 (copy)
        if l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 then
            table.insert(u54._xf6283a2b4ef130b0, l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gundraw", {
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
            local u73 = p72 and u71.draw_time or u71.shot_interval;
            u54:_xd5d565e93d25f5b8(u71, u73);
            u54._x51c29ca818c5a13c = true;
            u54:_x94a830a36a63b78f(true);
            u54._xa767b76951528128.Draw:Play(0);
            local v74 = u54:_xf89ba7ae4cd9bf78("equip", true);
            u54._x721903c2557f3d22:Add(v74);
            local v75 = l__Packets__2._x1d844bfc9ae8096f.OnClientEvent:Once(function(...) --[[ Line: 367 ]]
                -- upvalues: u70 (ref), u71 (copy), u67 (ref)
                u70(u71);
                u67(u71, ...);
            end;
            local v76 = l__Promise__1.delay(u71.draw_time + 0.2);
            u54._xb9f7cfbffb6ba69e = v76;
            v76:andThen(function() --[[ Line: 375 ]]
                -- upvalues: u57 (ref), u70 (ref), u71 (copy)
                if not u57 then
                    warn("LATE OR DROPPED SERVER PACKET, RESOLVING EARLY");
                    u70(u71);
                end;
            end;
            table.insert(u54._x0211cb82d66ed99b, v75);
            u54:_x8a47335f38cccd86("Draw", 1, 1);
            local u77 = u6;
            table.insert(u54._x57f55f05c54c5863, l__RunService__6.Heartbeat:Connect(function() --[[ Line: 387 ]]
                -- upvalues: u54 (ref), u77 (ref), l__Classes__4 (ref), u6 (ref)
                local l___xf5983b8666055755__12 = u54._xf5983b8666055755;
                local l___x0422388900551318__13 = u54._x0422388900551318;
                local l__CFrame__14 = workspace.CurrentCamera.CFrame;
                local v78, v79 = l__CFrame__14:ToObjectSpace(u77):ToOrientation();
                local v80;
                if l__Classes__4._x7058397dabccd000._x77aafe36a385b603._xa822f9aecc59b964 then
                    v80 = l___x0422388900551318__13.slide_rot;
                else
                    v80 = u6;
                end;
                u77 = l__CFrame__14;
                l___xf5983b8666055755__12.sway_offset = l___xf5983b8666055755__12.sway_offset:Lerp(CFrame.Angles(math.sin(-v78) * l___x0422388900551318__13.sway_amount, math.sin(-v79) * l___x0422388900551318__13.sway_amount, 0), 0.15);
                l___xf5983b8666055755__12.slide_rot = l___xf5983b8666055755__12.slide_rot:Lerp(v80, 0.1);
            end;
            l__Classes__4.Util:bindRenderStepToTable(u54._x57f55f05c54c5863, l__Classes__4._x32ae459de0772e82._x8ff5d6204140ad8b + 1, "gun_viewmodel", function() --[[ Line: 399 ]]
                -- upvalues: l__Classes__4 (ref), u54 (ref)
                l__Classes__4._x910f31e87b3c7281:_x9ad3e8b8be11532e(u54._x13e3faed2ed5902b);
                local l__CFrame__15 = workspace.CurrentCamera.CFrame;
                for _, v81 in u54._xf5983b8666055755 do
                    l__CFrame__15 = l__CFrame__15 * v81;
                end;
                u54._x13e3faed2ed5902b:PivotTo(l__CFrame__15);
            end;
            local u82 = nil;
            local u83 = u71.assist_radius * 2;
            local u84 = game:GetService("ReplicatedStorage").Assets.UIAssets.ShotReticle:GetChildren();
            local u85 = {};
            local u86 = 0;
            local u87 = nil;
            local u88 = nil;
            local u89 = nil;
            function() --[[ Line: 421 ]]
                -- upvalues: u84 (copy), u89 (ref), u87 (ref), u88 (ref), u85 (copy), u54 (ref), u83 (copy), u86 (ref), l__TweenService__7 (ref), u73 (copy)
                for _, v90 in ipairs(u84) do
                    local v91 = v90:Clone();
                    if v90.Name == "ClosestCircle" then
                        u89 = v91;
                    elseif v90.Name == "OuterCircle" then
                        u87 = v91;
                    elseif v90.Name == "TimingCircle" then
                        u88 = v91;
                    end;
                    table.insert(u85, v91);
                    table.insert(u54._x4e962b44bc166476, v91);
                end;
                u89.Size = UDim2.fromScale(u83, u83);
                u87.Size = UDim2.fromScale(u83, u83);
                u88.Size = UDim2.fromScale(u83, u83);
                u86 = u83;
                l__TweenService__7:Create(u87.Rotator, TweenInfo.new(u73, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Rotation = 360
                }):Play();
            end();
            local u92 = game.Workspace.Entities:GetChildren();
            local u93 = nil;
            local u94 = nil;
            local u95 = false;
            local u96 = false;
            local u97 = os.clock();
            local u98 = TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
            local u100 = function(p99) --[[ Line: 454 ]]
                -- upvalues: l__Classes__4 (ref)
                local l___xa582dff88acd1962__16 = l__Classes__4._xa582dff88acd1962;
                if l___xa582dff88acd1962__16 and typeof(l___xa582dff88acd1962__16._x1e7ec68c15abf5de) == "function" then
                    return l___xa582dff88acd1962__16:_x1e7ec68c15abf5de(p99);
                else
                    return p99;
                end;
            end;
            local u103 = function(p101) --[[ Line: 464 ]]
                -- upvalues: u100 (copy)
                local v102 = u100(p101);
                if v102 and v102:IsA("Model") then
                    return v102:FindFirstChild("Head") or v102.PrimaryPart;
                else
                    return p101:FindFirstChild("Head") or p101.PrimaryPart;
                end;
            end;
            local u106 = function(p104, p105) --[[ Line: 474 ]]
                -- upvalues: u95 (ref), u93 (ref), u94 (ref), u89 (ref), l__TweenService__7 (ref), u98 (copy)
                u95 = false;
                u93 = p104;
                u94 = p105;
                u89.Parent = p105;
                local l__ImageLabel__17 = u89.ImageLabel;
                l__ImageLabel__17.ImageTransparency = 1;
                l__TweenService__7:Create(l__ImageLabel__17, u98, {
                    ImageTransparency = l__ImageLabel__17:GetAttribute("StartTransparency")
                }):Play();
            end;
            local u109 = function(p107, p108, _) --[[ Line: 484 ]]
                -- upvalues: l__Classes__4 (ref)
                return not l__Classes__4.Util:hasLineOfSight(p107, p108);
            end;
            local u112 = function() --[[ Line: 488 ]]
                -- upvalues: u95 (ref), u82 (ref), u93 (ref), l__Promise__1 (ref), l__Packets__2 (ref), u3 (ref), u57 (ref), u54 (ref), u85 (copy), u89 (ref), u94 (ref), l__TweenService__7 (ref), u98 (copy)
                u95 = true;
                u82 = u93;
                l__Promise__1.defer(function() --[[ Line: 492 ]]
                    -- upvalues: l__Packets__2 (ref), u3 (ref), u82 (ref), u57 (ref), u54 (ref), u85 (ref), u89 (ref), u94 (ref), l__TweenService__7 (ref), u98 (ref)
                    if l__Packets__2._x67790e3a4ae7698a:Fire(u3, u82) then
                        if u57 then
                            return;
                        end;
                        u54:_xf89ba7ae4cd9bf78("lock_in", true);
                        for _, v110 in u85 do
                            if v110 ~= u89 then
                                if u57 then
                                    return;
                                end;
                                v110.Parent = u94;
                                v110.Enabled = true;
                                for _, v111 in v110:GetDescendants() do
                                    if v111:GetAttribute("StartTransparency") then
                                        if v111:IsA("Frame") then
                                            v111.BackgroundTransparency = 1;
                                            l__TweenService__7:Create(v111, u98, {
                                                BackgroundTransparency = v111:GetAttribute("StartTransparency")
                                            }):Play();
                                        elseif v111:IsA("ImageLabel") then
                                            v111.ImageTransparency = 1;
                                            l__TweenService__7:Create(v111, u98, {
                                                ImageTransparency = v111:GetAttribute("StartTransparency")
                                            }):Play();
                                        elseif v111:IsA("TextLabel") then
                                            v111.TextTransparency = 1;
                                            l__TweenService__7:Create(v111, u98, {
                                                TextTransparency = v111:GetAttribute("StartTransparency")
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            local u115 = function() --[[ Line: 525 ]]
                -- upvalues: u82 (ref), u96 (ref), l__Promise__1 (ref), l__Packets__2 (ref), u3 (ref), u54 (ref), u95 (ref), u85 (copy), u89 (ref), u57 (ref), l__TweenService__7 (ref), u98 (copy)
                if u82 and not u96 then
                    u96 = true;
                    l__Promise__1.defer(function() --[[ Line: 528 ]]
                        -- upvalues: u82 (ref), l__Packets__2 (ref), u3 (ref), u54 (ref), u95 (ref), u96 (ref), u85 (ref), u89 (ref), u57 (ref), l__TweenService__7 (ref), u98 (ref)
                        u82 = nil;
                        if l__Packets__2._x67790e3a4ae7698a:Fire(u3, u82) then
                            u54:_xf89ba7ae4cd9bf78("lock_off", true);
                            u95 = false;
                            u96 = false;
                            for _, v113 in u85 do
                                if v113 ~= u89 then
                                    if u57 then
                                        return;
                                    end;
                                    for _, v114 in v113:GetDescendants() do
                                        if v114:IsA("Frame") then
                                            l__TweenService__7:Create(v114, u98, {
                                                BackgroundTransparency = 1
                                            }):Play();
                                        elseif v114:IsA("ImageLabel") then
                                            l__TweenService__7:Create(v114, u98, {
                                                ImageTransparency = 1
                                            }):Play();
                                        elseif v114:IsA("TextLabel") then
                                            l__TweenService__7:Create(v114, u98, {
                                                TextTransparency = 1
                                            }):Play();
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            local u117 = function() --[[ Line: 558 ]]
                -- upvalues: l__Classes__4 (ref), u54 (ref)
                l__Classes__4.Util:unbindFromRenderStep("gun_targetting");
                local v116 = table.find(u54._x0211cb82d66ed99b, "gun_targetting");
                if v116 then
                    table.remove(u54._x0211cb82d66ed99b, v116);
                end;
            end;
            local u127 = function() --[[ Line: 567 ]]
                -- upvalues: l__Classes__4 (ref), u95 (ref), u93 (ref), u103 (copy), u109 (copy), u106 (copy), u92 (copy), u71 (copy)
                local v118 = l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c();
                local l__Head__18 = l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8.Head;
                local l__Position__19 = l__Head__18.Position;
                local v119 = u95 and 1.9 or -1;
                local v120 = nil;
                local v121 = nil;
                if u93 and not u95 then
                    local v122 = u103(u93);
                    if not v122 or u109(l__Head__18, v122, u93) then
                        u106();
                    end;
                end;
                for _, v123 in ipairs(u92) do
                    if v123:FindFirstChild("Hurtboxes") and (v123 and (v123 ~= l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 and v123:GetAttribute("is_teammate") ~= true)) then
                        local v124 = u103(v123);
                        if v124 then
                            local v125 = v124.Position - l__Position__19;
                            if v125.Magnitude <= u71.max_distance then
                                local v126 = v118:Dot(v125.Unit);
                                if v126 >= 0.5 and (not u109(l__Head__18, v124, v123) and v119 < v126) then
                                    v121 = v124;
                                    v120 = v123;
                                    v119 = v126;
                                end;
                            end;
                        end;
                    end;
                end;
                if v120 and v120 ~= u93 then
                    u106(v120, v121);
                end;
            end;
            local u139 = function(p128) --[[ Line: 615 ]]
                -- upvalues: u93 (ref), u94 (ref), u115 (copy), u106 (copy), l__Classes__4 (ref), u89 (ref), u71 (copy), u95 (ref), u112 (copy), l__TweenService__7 (ref), u86 (ref), u88 (ref), u87 (ref)
                if u93 then
                    if not (u94 and u94.Parent) then
                        u115();
                        u106();
                        return;
                    end;
                    local l__CFrame__20 = workspace.CurrentCamera.CFrame;
                    local l__Position__21 = l__CFrame__20.Position;
                    local v129 = l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c();
                    local l__Position__22 = u94.Position;
                    local l__Magnitude__23 = (l__Position__22 - l__Position__21):Cross(v129).Magnitude;
                    local l__Unit__24 = (l__Position__22 - l__Position__21).Unit;
                    local l__RightVector__25 = l__CFrame__20.RightVector;
                    local l__UpVector__26 = l__CFrame__20.UpVector;
                    local v130 = l__Unit__24:Dot(-l__RightVector__25);
                    local v131 = l__Unit__24:Dot(-l__UpVector__26);
                    local v132 = math.atan2(v130, v131);
                    local v133 = math.deg(v132);
                    u89.ImageLabel.Rotation = v133;
                    if l__Magnitude__23 <= u71.assist_radius and u93.Parent == workspace.Entities then
                        if not u95 then
                            u112();
                        end;
                        local v134 = l__Classes__4.Util:convNumRange(l__TweenService__7:GetValue(p128, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), 0, 1, u86 - 1, 0.1);
                        local v135 = l__Classes__4.Util:convNumRange(p128, 0, 1, 1, 0);
                        u88.Size = UDim2.fromScale(v134, v134);
                        u88.ImageLabel.ImageTransparency = v135;
                        local v136 = l__Classes__4.Util:numLerp(1, 0.5, l__TweenService__7:GetValue(p128, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
                        u87.BotRight.Size = UDim2.fromScale(v136, v136);
                        u87.TopRight.Size = UDim2.fromScale(v136, v136);
                        u87.BotLeft.Size = UDim2.fromScale(v136, v136);
                        u87.TopLeft.Size = UDim2.fromScale(v136, v136);
                        local v137 = l__Classes__4.Util:convNumRange(p128, 0, 1, 0, 100);
                        local l__Percentage__27 = u87.BotRight.Percentage;
                        local v138 = math.floor(v137);
                        l__Percentage__27.Text = tostring(v138) .. "%";
                        return;
                    end;
                    u115();
                end;
            end;
            l__Classes__4.Util:bindRenderStepToTable(u54._x0211cb82d66ed99b, l__Classes__4._x32ae459de0772e82._x8ff5d6204140ad8b + 5, "gun_targetting", function() --[[ Line: 668 ]]
                -- upvalues: l__Classes__4 (ref), u89 (ref), u117 (copy), u97 (copy), u73 (copy), u58 (ref), u127 (copy), u139 (copy)
                if game.Players.LocalPlayer.Character and (l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 and (not l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 or l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8.Parent)) then
                    if u89 and (not u89 or u89.Parent == u89.Parent) then
                        local v140 = os.clock() - u97;
                        local v141 = math.min(v140, u73);
                        local v142 = l__Classes__4.Util:convNumRange(v141, 0, u73, 0, 1);
                        if v142 == 1 then
                            u117();
                        else
                            if u58 then
                                u58.Value = v142;
                            end;
                            u127();
                            u139(v142);
                        end;
                    else
                        u117();
                    end;
                end;
            end;
        end;
    end(p55, p56);
end;
function u4._x187df79582936573(u143, u144, p145) --[[ Line: 698 ]]
    -- upvalues: l__Classes__4 (copy), l__TweenService__7 (copy), l__Packets__2 (copy), u3 (ref), l__Promise__1 (copy), u6 (copy), l__RunService__6 (copy), u5 (ref)
    if l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 then
        local u146 = l__Classes__4._xafc4950d7b094088:_x1c4ac4ec2fd3ec91();
        table.insert(u143._xf6283a2b4ef130b0, l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gundraw", {
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
        u143:_xd5d565e93d25f5b8(u144, p145 and u144.draw_time or u144.shot_interval);
        u143._x51c29ca818c5a13c = true;
        local v147 = tonumber(u144.time_started) + u144.draw_time - workspace:GetServerTimeNow() - math.min(l__Classes__4._x7430d6d194f43373._x4cd4bc083f273ad5 / 2, 0.1);
        local u148;
        if u146 then
            u148 = l__TweenService__7:Create(u146, TweenInfo.new(), {
                Value = 1
            }):Play();
        else
            u148 = nil;
        end;
        local u150 = function() --[[ Line: 723 ]]
            -- upvalues: u143 (copy), u148 (ref), u146 (copy), l__Classes__4 (ref), l__Packets__2 (ref), u3 (ref), l__Promise__1 (ref), u144 (copy)
            u143:_x3a3408ac26173680();
            if u148 then
                u148:Cancel();
                u146.Value = 1;
            end;
            l__Classes__4.Util:cleanConnectionsTable(u143._x0211cb82d66ed99b);
            for _, v149 in u143._x4e962b44bc166476 do
                v149:Destroy();
            end;
            u143._xfe6e1614a25e0272 = l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c();
            u143._xf349702abeec1dea = u143._x8f8f3c55f1e79ebe.WorldPosition;
            l__Packets__2._x055d17c7b310ad24:Fire(u3, u143._xfe6e1614a25e0272, workspace.CurrentCamera.CFrame.Position + u143._xfe6e1614a25e0272 * 1.5, (tostring(workspace:GetServerTimeNow())));
            u143._xa767b76951528128.Draw:Stop(0.0001);
            u143._xa767b76951528128.Fire:Play(0);
            l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gunshot", {
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
            u143:_x8a47335f38cccd86("Fire", 1, 1);
            l__Promise__1.delay(u144.shot_time):andThen(function() --[[ Line: 747 ]]
                -- upvalues: l__Classes__4 (ref)
                if l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b == "gun" then
                    l__Classes__4._xd1706540247308ea:_xabcc58e6f4374b9e("melee");
                end;
            end;
            l__Classes__4._x32ae459de0772e82:_x8ee1ac854964ea1a(unpack(u143._x3f030f36c034cfb5));
            u143:_xf89ba7ae4cd9bf78("shot", true);
            u143:_x30c63f8f2bd70f3c("shot", u143._xf349702abeec1dea);
            l__Classes__4._x7058397dabccd000:_xfd2bbe952d55830d(u144);
        end;
        u143:_x94a830a36a63b78f(true);
        u143._xa767b76951528128.Draw:Play(0);
        local v151 = u143:_xf89ba7ae4cd9bf78("equip", true);
        u143._x721903c2557f3d22:Add(v151);
        u143:_x8a47335f38cccd86("Draw", 1, 1);
        local u152 = u6;
        table.insert(u143._x57f55f05c54c5863, l__RunService__6.Heartbeat:Connect(function() --[[ Line: 768 ]]
            -- upvalues: u143 (copy), u152 (ref), l__Classes__4 (ref), u6 (ref)
            local l___xf5983b8666055755__28 = u143._xf5983b8666055755;
            local l___x0422388900551318__29 = u143._x0422388900551318;
            local l__CFrame__30 = workspace.CurrentCamera.CFrame;
            local v153, v154 = l__CFrame__30:ToObjectSpace(u152):ToOrientation();
            local v155;
            if l__Classes__4._x7058397dabccd000._x77aafe36a385b603._xa822f9aecc59b964 then
                v155 = l___x0422388900551318__29.slide_rot;
            else
                v155 = u6;
            end;
            u152 = l__CFrame__30;
            l___xf5983b8666055755__28.sway_offset = l___xf5983b8666055755__28.sway_offset:Lerp(CFrame.Angles(math.sin(-v153) * l___x0422388900551318__29.sway_amount, math.sin(-v154) * l___x0422388900551318__29.sway_amount, 0), 0.15);
            l___xf5983b8666055755__28.slide_rot = l___xf5983b8666055755__28.slide_rot:Lerp(v155, 0.1);
        end;
        l__Classes__4.Util:bindRenderStepToTable(u143._x57f55f05c54c5863, l__Classes__4._x32ae459de0772e82._x8ff5d6204140ad8b + 1, "gun_viewmodel", function() --[[ Line: 780 ]]
            -- upvalues: l__Classes__4 (ref), u143 (copy)
            l__Classes__4._x910f31e87b3c7281:_x9ad3e8b8be11532e(u143._x13e3faed2ed5902b);
            local l__CFrame__31 = workspace.CurrentCamera.CFrame;
            for _, v156 in u143._xf5983b8666055755 do
                l__CFrame__31 = l__CFrame__31 * v156;
            end;
            u143._x13e3faed2ed5902b:PivotTo(l__CFrame__31);
        end;
        if v147 <= 0 then
            warn("CURRENT NOW HAS EXCEEDED EXPECTED SHOT TIME, FIRING NOW");
            u150();
        else
            local v157 = l__Promise__1.delay(v147);
            u143._xb9f7cfbffb6ba69e = v157;
            v157:andThen(function() --[[ Line: 803 ]]
                -- upvalues: u150 (copy)
                u150();
            end;
            if u5 then
                u5:cancel();
            end;
            u5 = l__Promise__1.delay(2);
            u5:andThen(function() --[[ Line: 815 ]]
                -- upvalues: u143 (copy)
                warn("FIRE TIMEOUT");
                u143:_xc0c41c03168537df();
            end;
        end;
    end;
end;
function u4._xa17c0c70a82185fc(u158, u159) --[[ Line: 821 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy), u3 (ref), l__Promise__1 (copy), u9 (copy), l__TweenService__7 (copy), u5 (ref), u6 (copy), l__RunService__6 (copy)
    if l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 then
        local l__Hitbox__32 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Attack.Hitbox);
        local u160 = {
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
        local u161 = l__Classes__4._xafc4950d7b094088:_x1c4ac4ec2fd3ec91();
        local u162 = nil;
        table.insert(u158._xf6283a2b4ef130b0, l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gundraw", {
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
        u158:_xd5d565e93d25f5b8(u159, u159.draw_time);
        u158._x51c29ca818c5a13c = true;
        local v163 = 0;
        local v164 = math.min(l__Classes__4._x7430d6d194f43373._x4cd4bc083f273ad5 / 2, 0.1);
        local v165 = tonumber(u159.time_started);
        local v166 = workspace:GetServerTimeNow();
        local l__tags__33 = u159.tags;
        if l__tags__33 then
            l__tags__33 = u159.tags.bonus_shot;
        end;
        local u169 = function() --[[ Line: 857 ]]
            -- upvalues: u158 (copy), l__Classes__4 (ref), u160 (copy), l__Hitbox__32 (copy), l__Packets__2 (ref), u3 (ref), l__Promise__1 (ref), u159 (copy)
            u158._xa767b76951528128.Draw:Stop(0.0001);
            if u158._xa767b76951528128.BonusFire then
                u158._xa767b76951528128.BonusFire:Play(0);
            elseif u158._xa767b76951528128.Fire then
                u158._xa767b76951528128.Fire:Play(0);
            end;
            u158:_x3a3408ac26173680(false);
            u158._xfe6e1614a25e0272 = l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c();
            u158._xf349702abeec1dea = u158._x8f8f3c55f1e79ebe.WorldPosition;
            local v167 = u160[u158._x850fb72bedc0eacc];
            local v168 = {};
            local l__CFrame__34 = workspace.CurrentCamera.CFrame;
            if v167 then
                v167.origin = l__CFrame__34;
                v168 = l__Hitbox__32.new(v167):cast();
            else
                warn("NO HITBOX PARAMETERS FOR ITEM ID : ", u158._x850fb72bedc0eacc);
            end;
            l__Packets__2._x909c506c0531ca26:Fire(u3, l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c(), l__CFrame__34.Position, v168, (tostring(workspace:GetServerTimeNow())));
            if l__Classes__4._x1ab1568e6fe5e07f._xab8671c08d9c2d3f.Bonusshot then
                l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Bonusshot", {
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
                l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gunshot", {
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
            u158:_x8a47335f38cccd86("Fire", 1, 1);
            l__Classes__4._x32ae459de0772e82:_x8ee1ac854964ea1a(unpack(u158._x3f030f36c034cfb5));
            u158:_xf89ba7ae4cd9bf78("bonus_shot", true);
            l__Promise__1.defer(function() --[[ Line: 894 ]]
                -- upvalues: u158 (ref)
                u158:_x30c63f8f2bd70f3c("shot", u158._xf349702abeec1dea);
            end;
            l__Classes__4._x7058397dabccd000:_xfd2bbe952d55830d(u159);
        end;
        if l__tags__33 then
            for v170, _ in l__tags__33 do
                local l__shot_interval__35 = u158._xcd31646afa821cd4.shot_interval;
                v163 = v163 + l__shot_interval__35;
                local v171 = l__Promise__1.delay(v165 + u159.draw_time + l__shot_interval__35 * (v170 - 1) - v166 - v164);
                v171:andThen(function() --[[ Line: 911 ]]
                    -- upvalues: u169 (copy)
                    u169();
                end;
                u158._x721903c2557f3d22:AddPromise(v171);
            end;
        end;
        local u172 = v165 + u159.draw_time + v163;
        local v173 = u172 - v166 - v164;
        local u175 = function() --[[ Line: 926 ]]
            -- upvalues: l__Classes__4 (ref), u158 (copy)
            l__Classes__4._x910f31e87b3c7281:_x9ad3e8b8be11532e(u158._x13e3faed2ed5902b);
            local l__CFrame__36 = workspace.CurrentCamera.CFrame;
            for _, v174 in u158._xf5983b8666055755 do
                l__CFrame__36 = l__CFrame__36 * v174;
            end;
            u158._x13e3faed2ed5902b:PivotTo(l__CFrame__36);
        end;
        local u176 = nil;
        local u177 = false;
        local u179 = function() --[[ Line: 940 ]]
            -- upvalues: u177 (ref), u176 (ref)
            u177 = true;
            if u176 then
                local v178 = u176;
                u176 = nil;
                v178();
            end;
        end;
        if u159.tags.scope then
            local v180 = l__Promise__1.delay(v173 - u159.tags.scope.duration);
            v180:andThen(function() --[[ Line: 957 ]]
                -- upvalues: u177 (ref), u9 (ref), u159 (copy), u172 (copy), u176 (ref), u158 (copy)
                if u177 then
                else
                    local v181 = u9[u159.tags.scope.kind];
                    assert(v181, "Unsupported gun scope handler");
                    local u182 = v181(u172, 0.35);
                    u176 = u182;
                    u158._x721903c2557f3d22:Add(function() --[[ Line: 966 ]]
                        -- upvalues: u177 (ref), u176 (ref), u182 (copy)
                        u177 = true;
                        if u176 == u182 then
                            u176 = nil;
                        end;
                        u182();
                    end;
                end;
            end;
            u158._x721903c2557f3d22:AddPromise(v180);
        end;
        if u161 then
            u162 = l__TweenService__7:Create(u161, TweenInfo.new(1), {
                Value = 1
            }):Play();
        end;
        local u186 = function() --[[ Line: 984 ]]
            -- upvalues: u158 (copy), u179 (copy), u175 (copy), u162 (ref), u161 (copy), l__Classes__4 (ref), u5 (ref), u160 (copy), l__Hitbox__32 (copy), l__Packets__2 (ref), u3 (ref), l__Promise__1 (ref), u159 (copy)
            u158._xa767b76951528128.Draw:Stop(0.0001);
            u158._xa767b76951528128.Fire:Play(0);
            u179();
            u158:_x3a3408ac26173680();
            u175();
            if u162 then
                u162:Cancel();
                u161.Value = 1;
            end;
            l__Classes__4.Util:cleanConnectionsTable(u158._x0211cb82d66ed99b);
            for _, v183 in u158._x4e962b44bc166476 do
                v183:Destroy();
            end;
            if u5 then
                u5:cancel();
            end;
            u158._xfe6e1614a25e0272 = l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c();
            u158._xf349702abeec1dea = u158._x8f8f3c55f1e79ebe.WorldPosition;
            local v184 = u160[u158._x850fb72bedc0eacc];
            local v185 = {};
            local l__CFrame__37 = workspace.CurrentCamera.CFrame;
            if v184 then
                v184.origin = l__CFrame__37;
                v185 = l__Hitbox__32.new(v184):cast();
            else
                warn("NO HITBOX PARAMETERS FOR ITEM ID : ", u158._x850fb72bedc0eacc);
            end;
            l__Packets__2._x909c506c0531ca26:Fire(u3, l__Classes__4._x32ae459de0772e82:_x76b38494ff05a56c(), l__CFrame__37.Position, v185, (tostring(workspace:GetServerTimeNow())));
            if u158._xa767b76951528128.BonusFire then
                u158._xa767b76951528128.BonusFire:Stop(0.0001);
            end;
            l__Classes__4._x1ab1568e6fe5e07f:_xcf4dfc356bd5ec17("Gunshot", {
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
            u158:_x8a47335f38cccd86("Fire", 1, 1);
            l__Promise__1.delay(u159.shot_time):andThen(function() --[[ Line: 1030 ]]
                -- upvalues: l__Classes__4 (ref)
                if l__Classes__4._xd1706540247308ea._x6d87aed2c44a568b == "gun" then
                    l__Classes__4._xd1706540247308ea:_xabcc58e6f4374b9e("melee");
                end;
            end;
            l__Classes__4._x32ae459de0772e82:_x8ee1ac854964ea1a(unpack(u158._x3f030f36c034cfb5));
            u158:_xf89ba7ae4cd9bf78("shot", true);
            u158:_x30c63f8f2bd70f3c("shot", u158._xf349702abeec1dea);
            l__Classes__4._x7058397dabccd000:_xfd2bbe952d55830d(u159);
        end;
        u158:_x94a830a36a63b78f(true);
        u158._xa767b76951528128.Draw:Play(0);
        local v187 = u158:_xf89ba7ae4cd9bf78("equip", true);
        u158._x721903c2557f3d22:Add(v187);
        u158:_x8a47335f38cccd86("Draw", 1, 1);
        local u188 = u6;
        table.insert(u158._x57f55f05c54c5863, l__RunService__6.Heartbeat:Connect(function() --[[ Line: 1051 ]]
            -- upvalues: u158 (copy), u188 (ref), l__Classes__4 (ref), u6 (ref)
            local l___xf5983b8666055755__38 = u158._xf5983b8666055755;
            local l___x0422388900551318__39 = u158._x0422388900551318;
            local l__CFrame__40 = workspace.CurrentCamera.CFrame;
            local v189, v190 = l__CFrame__40:ToObjectSpace(u188):ToOrientation();
            local v191;
            if l__Classes__4._x7058397dabccd000._x77aafe36a385b603._xa822f9aecc59b964 then
                v191 = l___x0422388900551318__39.slide_rot * l___x0422388900551318__39.slide_offset;
            else
                v191 = u6;
            end;
            u188 = l__CFrame__40;
            l___xf5983b8666055755__38.sway_offset = l___xf5983b8666055755__38.sway_offset:Lerp(CFrame.Angles(math.sin(-v189) * l___x0422388900551318__39.sway_amount, math.sin(-v190) * l___x0422388900551318__39.sway_amount, 0), 0.15);
            l___xf5983b8666055755__38.slide_rot = l___xf5983b8666055755__38.slide_rot:Lerp(v191, 0.1);
        end;
        l__Classes__4.Util:bindRenderStepToTable(u158._x57f55f05c54c5863, l__Classes__4._x32ae459de0772e82._x8ff5d6204140ad8b + 1, "gun_viewmodel", function() --[[ Line: 1065 ]]
            -- upvalues: u175 (copy)
            u175();
        end;
        if v173 <= 0 then
            warn("CURRENT NOW HAS EXCEEDED EXPECTED SHOT TIME, FIRING NOW");
            u186();
        else
            local v192 = l__Promise__1.delay(v173);
            u158._xb9f7cfbffb6ba69e = v192;
            v192:andThen(function() --[[ Line: 1082 ]]
                -- upvalues: u186 (copy)
                u186();
            end;
            if u5 then
                u5:cancel();
            end;
            u5 = l__Promise__1.delay(5);
            u5:andThen(function() --[[ Line: 1094 ]]
                -- upvalues: u158 (copy)
                warn("FIRE TIMEOUT");
                u158:_xc0c41c03168537df();
            end;
        end;
    end;
end;
function u4._xe4e131028b00eb5a(p193) --[[ Line: 1100 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy), u3 (ref)
    if l__Classes__4._x7058397dabccd000._xbcaafe2ed14862c8 and (not p193._x51c29ca818c5a13c and (p193._xcd31646afa821cd4 and not p193._xd5a82911ccd71c0b)) then
        p193._xd5a82911ccd71c0b = true;
        p193._xaab598a46a296fa7 = false;
        local v194 = l__Packets__2._xade50db7ec690d88:Fire(u3, p193._x850fb72bedc0eacc);
        if v194 and not p193._xaab598a46a296fa7 then
            if p193._xcd31646afa821cd4.tags.hitbox then
                p193:_xa17c0c70a82185fc(v194, true);
            elseif p193._xcd31646afa821cd4.tags.projectile then
                p193:_x187df79582936573(v194, true);
            else
                p193:_x72baca0219a3d784(v194, true);
            end;
        else
            p193:_xc0c41c03168537df();
        end;
    end;
end;
function u4._x5de5406ab187a367(p195) --[[ Line: 1121 ]]
    -- upvalues: u5 (ref), l__InternalSymbols__5 (copy), l__Classes__4 (copy)
    p195:_x94a830a36a63b78f(false);
    for _, v196 in p195._x4e962b44bc166476 do
        if v196 then
            v196:Destroy();
        end;
    end;
    if u5 then
        u5:cancel();
    end;
    if p195.crosshair then
        l__InternalSymbols__5.owner("", p195.crosshair):cleanUp();
    end;
    for v197, v198 in p195._x0fd136c9c08cfbc3 do
        local v199 = table.find(v197, v198);
        if v199 then
            table.remove(v197, v199);
        end;
    end;
    p195._x0fd136c9c08cfbc3 = {};
    p195._x51c29ca818c5a13c = false;
    p195._xd5a82911ccd71c0b = false;
    p195._x8e98c8665437fd02 = nil;
    p195._x606caf6edcb0fe97 = 0;
    p195._xcf93f169dbd89daf = 0;
    p195._xbc41b1af1cd55158 = 0;
    p195._xebba98f5a3ce59b4 = 0;
    p195._xec7b9d181ba2c12b = false;
    p195._xb9f7cfbffb6ba69e:cancel();
    l__Classes__4.Util:stopAnimations(p195._x2dbab9f27e7f0ca1);
    l__Classes__4.Util:cleanConnectionsTable(p195._x57f55f05c54c5863);
    l__Classes__4.Util:cleanConnectionsTable(p195._x0211cb82d66ed99b);
end;
function u4.cleanUp(p200) --[[ Line: 1158 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy)
    l__Classes__4.Util:cleanConnectionsTable(p200._x22a4f1cdca62d968);
    l__Classes__4._x1ab1568e6fe5e07f:_xd66b27d3e48ff743(p200._x850fb72bedc0eacc);
    l__Packets__2._x334266a937df41a9:Fire(p200._x850fb72bedc0eacc);
    if p200._x13e3faed2ed5902b then
        p200._x13e3faed2ed5902b:Destroy();
    end;
    warn(string.format("%s CLEANED", p200._x4034dcd9337c4ea0));
end;
function u4._x94a830a36a63b78f(p201, p202) --[[ Line: 1169 ]]
    p201._x4780cee9c2e35076 = p202;
    if p202 then
        p201._xee20d740f560ba8c = CFrame.new(0, 0, 0);
    else
        p201._xee20d740f560ba8c = CFrame.new(9999, 9999, 9999);
    end;
end;
function u4._x045348c003087058(p203) --[[ Line: 1178 ]]
    -- upvalues: l__Classes__4 (copy)
    l__Classes__4._x910f31e87b3c7281:_x3dcf9d89d527a087(p203._x2dbab9f27e7f0ca1, p203._xa767b76951528128, p203:_xba48ec5865d2872d());
end;
function u4._x2245616839d15591(p204) --[[ Line: 1182 ]]
    -- upvalues: u3 (ref), l__Packets__2 (copy), l__Classes__4 (copy)
    if u3 then
        p204._xcd31646afa821cd4 = l__Packets__2._x064f9c5cc00bec7e:Fire(u3, p204._x850fb72bedc0eacc);
        l__Classes__4._xafc4950d7b094088:_x19a8c13b7d43296b(p204._xcd31646afa821cd4);
    else
        warn("NO TOKEN TO GET GUN DATA.");
    end;
end;
function u4._xe53615d96cf36a6b(u205) --[[ Line: 1191 ]]
    -- upvalues: l__Classes__4 (copy), l__Promise__1 (copy), u3 (ref), l__Packets__2 (copy)
    u205._x13e3faed2ed5902b:ScaleTo(u205._xaf95301040bf877f.model_scale or 0.5);
    u205:_x94a830a36a63b78f(false);
    l__Classes__4._x910f31e87b3c7281:_x5b10a4521eeef17e(u205._x13e3faed2ed5902b, "RightArm");
    l__Promise__1.defer(function() --[[ Line: 1196 ]]
        -- upvalues: u205 (copy)
        u205._x13e3faed2ed5902b.Parent = workspace.CurrentCamera;
        u205:_x045348c003087058();
    end;
    l__Classes__4._x1ab1568e6fe5e07f:_x8bbde1bc4032804c(u205._x850fb72bedc0eacc, u205._x8703b52a47175c59);
    table.insert(u205._x22a4f1cdca62d968, game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 1202 ]]
        -- upvalues: l__Classes__4 (ref), u205 (copy)
        l__Classes__4._x1ab1568e6fe5e07f:_x8bbde1bc4032804c(u205._x850fb72bedc0eacc, u205._x8703b52a47175c59);
    end;
    u3 = l__Packets__2._xbfaa5820a4100b86:Fire(u205._x850fb72bedc0eacc);
    task.defer(function() --[[ Line: 1208 ]]
        -- upvalues: u205 (copy)
        u205:_x2245616839d15591();
    end;
    l__Classes__4.Util:bindRenderStepToTable(u205._x22a4f1cdca62d968, l__Classes__4._x32ae459de0772e82._x8ff5d6204140ad8b + 2, "gun_visibility", function() --[[ Line: 1212 ]]
        -- upvalues: l__Classes__4 (ref), u205 (copy)
        if l__Classes__4._x910f31e87b3c7281._x0dabd010e1f00f2e and not l__Classes__4._x910f31e87b3c7281._x18b5705689fe6582 then
            if not u205._x4780cee9c2e35076 then
                u205._x13e3faed2ed5902b:PivotTo(u205._xee20d740f560ba8c);
            end;
        else
            u205._x13e3faed2ed5902b:PivotTo(CFrame.new(99999, 99999, 99999));
        end;
    end;
    task.defer(function() --[[ Line: 1224 ]]
        -- upvalues: u205 (copy), l__Packets__2 (ref), l__Classes__4 (ref)
        table.insert(u205._x22a4f1cdca62d968, l__Packets__2._x75a938726f9fe95f.OnClientEvent:Connect(function() --[[ Line: 1225 ]]
            -- upvalues: u205 (ref)
            u205:_xc0c41c03168537df();
        end;
        local l___x22a4f1cdca62d968__41 = u205._x22a4f1cdca62d968;
        local l__Pressed__42 = l__Classes__4._x3e046bec2684f59c:_xc9966245cd0a44a8("PARRY").Pressed;
        table.insert(l___x22a4f1cdca62d968__41, l__Pressed__42:Connect(function() --[[ Line: 1229 ]]
            -- upvalues: u205 (ref)
            u205:_x6c6d491eafed896a();
        end;
        local l___x22a4f1cdca62d968__43 = u205._x22a4f1cdca62d968;
        local l__Pressed__44 = l__Classes__4._x3e046bec2684f59c:_xc9966245cd0a44a8("GUN").Pressed;
        table.insert(l___x22a4f1cdca62d968__43, l__Pressed__44:Connect(function() --[[ Line: 1233 ]]
            -- upvalues: u205 (ref), l__Classes__4 (ref)
            if u205._xcd31646afa821cd4 then
                local l___xc93ed121260ef808__45 = l__Classes__4._x7430d6d194f43373._xc93ed121260ef808;
                local l__Value__46 = l___xc93ed121260ef808__45.heat_per_bullet.Value;
                local l__Value__47 = l___xc93ed121260ef808__45.heat.Value;
                local v206 = u205._xcd31646afa821cd4.tags["two-handed"];
                if not u205._xd5a82911ccd71c0b and (not u205._x51c29ca818c5a13c and (l__Value__46 <= l__Value__47 and (not l__Classes__4._x7430d6d194f43373._x7176ea97549fd9b6.is_breaking and l__Classes__4._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive"))) then
                    for v207, v208 in u205._x0fd136c9c08cfbc3 do
                        local v209 = table.find(v207, v208);
                        if v209 then
                            table.remove(v207, v209);
                        end;
                    end;
                    if v206 then
                        local v210 = l__Classes__4._xd1706540247308ea:_x372c01be8a28bc70("augment");
                        local v211 = game:GetService("HttpService"):GenerateGUID();
                        if v210 then
                            table.insert(v210._x9d751f2c4a021d66, v211);
                            u205._x0fd136c9c08cfbc3[v210._x9d751f2c4a021d66] = v211;
                        end;
                        local v212 = l__Classes__4._x3e046bec2684f59c:_xc9966245cd0a44a8("AUGMENT");
                        table.insert(v212.Blockers, v211);
                        u205._x0fd136c9c08cfbc3[v212.Blockers] = v211;
                        l__Classes__4._x3e046bec2684f59c:_xfb4a3db782d53e1e("AUGMENT");
                    end;
                    l__Classes__4._xd1706540247308ea:_xabcc58e6f4374b9e("gun");
                end;
            end;
        end;
    end;
end;
return u4;
