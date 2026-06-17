-- Decompiled from: Start.Client.Classes._xec10753807252baa
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._x83ed94bfb82a8c9f() --[[ Line: 40 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    local v2 = setmetatable({}, u1);
    v2._xdb9dcceb5fe596b4 = {
        main = "",
        previous = nil,
        context = nil,
        previous_context = nil,
        corresponding_played = false,
        timestamp = 0
    };
    v2._xe5ca0833fa69bf40 = {
        main = "",
        previous = nil,
        context = nil,
        previous_context = nil,
        corresponding_played = false,
        timestamp = 0
    };
    v2._x8ecb8c84dd476bce = {
        wallriding = false,
        sliding = false,
        dashing = false
    };
    v2._xc7b0dfabca9d516c = nil;
    v2._xb113ba88524e9dcd = l__Signal__3.new();
    v2._x80da228185a26245 = l__Signal__3.new();
    return v2;
end;
function u1._x7f5184d63d859109(p3) --[[ Line: 77 ]]
    p3._xdb9dcceb5fe596b4.context = nil;
    p3._xc7b0dfabca9d516c = nil;
end;
function u1._x3ae313a79cdb521b(p4) --[[ Line: 82 ]]
    p4._xdb9dcceb5fe596b4.previous = nil;
end;
function u1._x208c2ca1c5aae40f(p5) --[[ Line: 87 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x1a4ce4062771e36e__5 = l__Classes__4._x1a4ce4062771e36e;
    local l__Magnitude__6 = l___x1a4ce4062771e36e__5:getMoveDirection().Magnitude;
    local l__Magnitude__7 = l___x1a4ce4062771e36e__5._xfd7cc994ccc60ad7.Magnitude;
    local l___x8ecb8c84dd476bce__8 = p5._x8ecb8c84dd476bce;
    local l___x9baf9bb47de1af88__9 = l___x1a4ce4062771e36e__5._x9baf9bb47de1af88;
    local l___xeefc92d109c9c85f__10 = l___x1a4ce4062771e36e__5._xeefc92d109c9c85f;
    return l___x8ecb8c84dd476bce__8.wallriding and "wallriding" or (l___x8ecb8c84dd476bce__8.sliding and "sliding" or (l___x8ecb8c84dd476bce__8.dashing and "dashing" or (l___x9baf9bb47de1af88__9 and (not l___xeefc92d109c9c85f__10 and l__Magnitude__7 > 1) and "bhop_jump" or (l___xeefc92d109c9c85f__10 and (l__Magnitude__6 ~= 0 and l__Magnitude__7 > 1) and "running" or (l___x9baf9bb47de1af88__9 and "idle" or "falling")))));
end;
function u1._x9120a6bf0b3aeec0(p6) --[[ Line: 95 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x1a4ce4062771e36e__11 = l__Classes__4._x1a4ce4062771e36e;
    local l__Magnitude__12 = l___x1a4ce4062771e36e__11:getMoveDirection().Magnitude;
    local l__Magnitude__13 = l___x1a4ce4062771e36e__11._xfd7cc994ccc60ad7.Magnitude;
    local l___x8ecb8c84dd476bce__14 = p6._x8ecb8c84dd476bce;
    local l___x9baf9bb47de1af88__15 = l___x1a4ce4062771e36e__11._x9baf9bb47de1af88;
    local l___xeefc92d109c9c85f__16 = l___x1a4ce4062771e36e__11._xeefc92d109c9c85f;
    return l___x8ecb8c84dd476bce__14.wallriding and "wallriding" or (l___x8ecb8c84dd476bce__14.dashing and "dashing" or (l___x9baf9bb47de1af88__15 and (not l___xeefc92d109c9c85f__16 and l__Magnitude__13 > 1) and "bhop_jump" or (l___xeefc92d109c9c85f__16 and (l__Magnitude__12 ~= 0 and l__Magnitude__13 > 1) and "running" or (l___x9baf9bb47de1af88__15 and "idle" or "falling"))));
end;
function u1._xb1589c2c34ac3b4a(p7, p8, p9) --[[ Line: 103 ]]
    p7._xdb9dcceb5fe596b4.previous_context = p7._xdb9dcceb5fe596b4.context;
    p7._xdb9dcceb5fe596b4.previous = p7._xdb9dcceb5fe596b4.main;
    local v10 = os.clock();
    p7._xdb9dcceb5fe596b4.main = p8;
    p7._xdb9dcceb5fe596b4.context = p9;
    p7._xdb9dcceb5fe596b4.timestamp = v10;
    p7._xdb9dcceb5fe596b4.corresponding_played = false;
    p7._xb113ba88524e9dcd:Fire(p7._xdb9dcceb5fe596b4);
end;
function u1._xfebd7ee48f70605a(p11, p12, p13) --[[ Line: 117 ]]
    p11._xe5ca0833fa69bf40.previous_context = p11._xe5ca0833fa69bf40.context;
    p11._xe5ca0833fa69bf40.previous = p11._xe5ca0833fa69bf40.main;
    local v14 = os.clock();
    p11._xe5ca0833fa69bf40.main = p12;
    p11._xe5ca0833fa69bf40.context = p13;
    p11._xe5ca0833fa69bf40.timestamp = v14;
    p11._xe5ca0833fa69bf40.corresponding_played = false;
    p11._x80da228185a26245:Fire(p11._xe5ca0833fa69bf40);
end;
function u1._xa7b35771ea0d656b(u15) --[[ Line: 131 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x6ca41a60efee84c4__17 = l__Classes__4._x1a4ce4062771e36e._x6ca41a60efee84c4;
    l___x6ca41a60efee84c4__17.dash_started.Event:Connect(function(p16) --[[ Line: 134 ]]
        -- upvalues: u15 (copy)
        u15._x8ecb8c84dd476bce.dashing = true;
        if p16 then
            u15._xc7b0dfabca9d516c = p16;
        end;
    end);
    l___x6ca41a60efee84c4__17.dash_ended.Event:Connect(function(p17) --[[ Line: 142 ]]
        -- upvalues: u15 (copy)
        u15._x8ecb8c84dd476bce.dashing = false;
        u15._xc7b0dfabca9d516c = p17;
    end);
    l___x6ca41a60efee84c4__17.wallride_started.Event:Connect(function(p18) --[[ Line: 147 ]]
        -- upvalues: u15 (copy)
        u15._x8ecb8c84dd476bce.wallriding = true;
        u15._xc7b0dfabca9d516c = p18;
    end);
    l___x6ca41a60efee84c4__17.wallride_ended.Event:Connect(function(p19) --[[ Line: 152 ]]
        -- upvalues: u15 (copy)
        u15._x8ecb8c84dd476bce.wallriding = false;
        u15._xc7b0dfabca9d516c = p19;
    end);
    l___x6ca41a60efee84c4__17.slide_started.Event:Connect(function(p20) --[[ Line: 157 ]]
        -- upvalues: u15 (copy)
        u15._x8ecb8c84dd476bce.sliding = true;
        u15._xc7b0dfabca9d516c = p20;
    end);
    l___x6ca41a60efee84c4__17.slide_ended.Event:Connect(function(p21) --[[ Line: 162 ]]
        -- upvalues: u15 (copy)
        u15._x8ecb8c84dd476bce.sliding = false;
        u15._xc7b0dfabca9d516c = p21;
    end);
end;
function u1._x1aa0845d51ab47a4(p22) --[[ Line: 169 ]]
    return p22._xdb9dcceb5fe596b4;
end;
function u1._x93703dac4ae0145f(p23) --[[ Line: 173 ]]
    p23._xdb9dcceb5fe596b4.corresponding_played = true;
end;
function u1._xa6d9be354e28825e(p24) --[[ Line: 178 ]]
    p24._xe5ca0833fa69bf40.corresponding_played = true;
end;
function u1._x12d3547c63e50087(p25) --[[ Line: 182 ]]
    local v26 = p25:_x208c2ca1c5aae40f();
    local l___xc7b0dfabca9d516c__18 = p25._xc7b0dfabca9d516c;
    if v26 == "idle" or v26 == "running" then
        p25._xc7b0dfabca9d516c = nil;
        l___xc7b0dfabca9d516c__18 = nil;
    end;
    if v26 ~= p25._xdb9dcceb5fe596b4.main or l___xc7b0dfabca9d516c__18 ~= p25._xdb9dcceb5fe596b4.context then
        p25:_xb1589c2c34ac3b4a(v26, l___xc7b0dfabca9d516c__18);
    end;
end;
function u1._xe6a2780f94a6f221(p27) --[[ Line: 197 ]]
    local v28 = p27:_x9120a6bf0b3aeec0();
    local l___xc7b0dfabca9d516c__19 = p27._xc7b0dfabca9d516c;
    if v28 == "idle" or v28 == "running" then
        l___xc7b0dfabca9d516c__19 = nil;
    end;
    if v28 ~= p27._xe5ca0833fa69bf40.main or l___xc7b0dfabca9d516c__19 ~= p27._xe5ca0833fa69bf40.context then
        p27:_xfebd7ee48f70605a(v28, l___xc7b0dfabca9d516c__19);
    end;
end;
function u1._x6c791873d9806d95(p29) --[[ Line: 212 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x1a4ce4062771e36e__20 = l__Classes__4._x1a4ce4062771e36e;
    local l__Magnitude__21 = l___x1a4ce4062771e36e__20:getMoveDirection().Magnitude;
    local l__Magnitude__22 = l___x1a4ce4062771e36e__20._xfd7cc994ccc60ad7.Magnitude;
    local l___x8ecb8c84dd476bce__23 = p29._x8ecb8c84dd476bce;
    local l___xc7b0dfabca9d516c__24 = p29._xc7b0dfabca9d516c;
    local l___x9baf9bb47de1af88__25 = l___x1a4ce4062771e36e__20._x9baf9bb47de1af88;
    local l___xeefc92d109c9c85f__26 = l___x1a4ce4062771e36e__20._xeefc92d109c9c85f;
    local v30 = l___x8ecb8c84dd476bce__23.wallriding and "wallriding" or (l___x8ecb8c84dd476bce__23.sliding and "sliding" or (l___x8ecb8c84dd476bce__23.dashing and "dashing" or (l___x9baf9bb47de1af88__25 and (not l___xeefc92d109c9c85f__26 and l__Magnitude__22 > 1) and "bhop_jump" or (l___xeefc92d109c9c85f__26 and (l__Magnitude__21 ~= 0 and l__Magnitude__22 > 1) and "running" or (l___x9baf9bb47de1af88__25 and "idle" or "falling")))));
    if v30 == "idle" or v30 == "running" then
        p29._xc7b0dfabca9d516c = nil;
        l___xc7b0dfabca9d516c__24 = nil;
    end;
    if v30 ~= p29._xdb9dcceb5fe596b4.main or l___xc7b0dfabca9d516c__24 ~= p29._xdb9dcceb5fe596b4.context then
        p29:_xb1589c2c34ac3b4a(v30, l___xc7b0dfabca9d516c__24);
    end;
    local l___x9baf9bb47de1af88__27 = l___x1a4ce4062771e36e__20._x9baf9bb47de1af88;
    local l___xeefc92d109c9c85f__28 = l___x1a4ce4062771e36e__20._xeefc92d109c9c85f;
    local v31 = l___x8ecb8c84dd476bce__23.wallriding and "wallriding" or (l___x8ecb8c84dd476bce__23.dashing and "dashing" or (l___x9baf9bb47de1af88__27 and (not l___xeefc92d109c9c85f__28 and l__Magnitude__22 > 1) and "bhop_jump" or (l___xeefc92d109c9c85f__28 and (l__Magnitude__21 ~= 0 and l__Magnitude__22 > 1) and "running" or (l___x9baf9bb47de1af88__27 and "idle" or "falling"))));
    local l___xc7b0dfabca9d516c__29 = p29._xc7b0dfabca9d516c;
    if v31 == "idle" or v31 == "running" then
        l___xc7b0dfabca9d516c__29 = nil;
    end;
    if v31 ~= p29._xe5ca0833fa69bf40.main or l___xc7b0dfabca9d516c__29 ~= p29._xe5ca0833fa69bf40.context then
        p29:_xfebd7ee48f70605a(v31, l___xc7b0dfabca9d516c__29);
    end;
end;
function u1._x44bcd6af41218f92(u32) --[[ Line: 241 ]]
    -- upvalues: l__RunService__1 (copy)
    task.defer(function() --[[ Line: 242 ]]
        -- upvalues: u32 (copy), l__RunService__1 (ref)
        u32:_xa7b35771ea0d656b();
        l__RunService__1.RenderStepped:Connect(function() --[[ Line: 245 ]]
            -- upvalues: u32 (ref)
            u32:_x6c791873d9806d95();
        end);
    end);
end;
return u1;
