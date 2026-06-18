-- Decompiled from: Start.Client.Classes._x64f8d2b27adbc0f7
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._x90d4581ac99dd483() --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    local v2 = setmetatable({}, u1);
    v2._xeab7fd84ae7ea9f9 = {
        main = "",
        previous = nil,
        context = nil,
        previous_context = nil,
        corresponding_played = false,
        timestamp = 0
    };
    v2._x63ef6d95f26d661a = {
        main = "",
        previous = nil,
        context = nil,
        previous_context = nil,
        corresponding_played = false,
        timestamp = 0
    };
    v2._x755d014fa3db3241 = {
        wallriding = false,
        sliding = false,
        dashing = false
    };
    v2._xb7bc362dc9415747 = nil;
    v2._x67783353828f3ace = l__Signal__3.new();
    v2._xc5fa3e947191ba87 = l__Signal__3.new();
    return v2;
end;
function u1._x5daee86d2092aec1(p3) --[[ Line: 68 ]]
    p3._xeab7fd84ae7ea9f9.context = nil;
    p3._xb7bc362dc9415747 = nil;
end;
function u1._xe4db8187bf6fa86d(p4) --[[ Line: 73 ]]
    p4._xeab7fd84ae7ea9f9.previous = nil;
end;
function u1._x9f84975b8e5e1d56(p5) --[[ Line: 78 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x7058397dabccd000__5 = l__Classes__4._x7058397dabccd000;
    local l__Magnitude__6 = l___x7058397dabccd000__5:getMoveDirection().Magnitude;
    local l__Magnitude__7 = l___x7058397dabccd000__5._x1d287c838240a901.Magnitude;
    local l___x755d014fa3db3241__8 = p5._x755d014fa3db3241;
    local l___x8500fad561a4bbc9__9 = l___x7058397dabccd000__5._x8500fad561a4bbc9;
    local l___x5242295569714a31__10 = l___x7058397dabccd000__5._x5242295569714a31;
    return l___x755d014fa3db3241__8.wallriding and "wallriding" or (l___x755d014fa3db3241__8.sliding and "sliding" or (l___x755d014fa3db3241__8.dashing and "dashing" or (l___x8500fad561a4bbc9__9 and (not l___x5242295569714a31__10 and l__Magnitude__7 > 1) and "bhop_jump" or (l___x5242295569714a31__10 and (l__Magnitude__6 ~= 0 and l__Magnitude__7 > 1) and "running" or (l___x8500fad561a4bbc9__9 and "idle" or "falling")))));
end;
function u1._x0180403c7fcc5f15(p6) --[[ Line: 86 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x7058397dabccd000__11 = l__Classes__4._x7058397dabccd000;
    local l__Magnitude__12 = l___x7058397dabccd000__11:getMoveDirection().Magnitude;
    local l__Magnitude__13 = l___x7058397dabccd000__11._x1d287c838240a901.Magnitude;
    local l___x755d014fa3db3241__14 = p6._x755d014fa3db3241;
    local l___x8500fad561a4bbc9__15 = l___x7058397dabccd000__11._x8500fad561a4bbc9;
    local l___x5242295569714a31__16 = l___x7058397dabccd000__11._x5242295569714a31;
    return l___x755d014fa3db3241__14.wallriding and "wallriding" or (l___x755d014fa3db3241__14.dashing and "dashing" or (l___x8500fad561a4bbc9__15 and (not l___x5242295569714a31__16 and l__Magnitude__13 > 1) and "bhop_jump" or (l___x5242295569714a31__16 and (l__Magnitude__12 ~= 0 and l__Magnitude__13 > 1) and "running" or (l___x8500fad561a4bbc9__15 and "idle" or "falling"))));
end;
function u1._x811167b32a66893d(p7, p8, p9) --[[ Line: 94 ]]
    p7._xeab7fd84ae7ea9f9.previous_context = p7._xeab7fd84ae7ea9f9.context;
    p7._xeab7fd84ae7ea9f9.previous = p7._xeab7fd84ae7ea9f9.main;
    local v10 = os.clock();
    p7._xeab7fd84ae7ea9f9.main = p8;
    p7._xeab7fd84ae7ea9f9.context = p9;
    p7._xeab7fd84ae7ea9f9.timestamp = v10;
    p7._xeab7fd84ae7ea9f9.corresponding_played = false;
    p7._x67783353828f3ace:Fire(p7._xeab7fd84ae7ea9f9);
end;
function u1._x8c6fb57a0311ef98(p11, p12, p13) --[[ Line: 108 ]]
    p11._x63ef6d95f26d661a.previous_context = p11._x63ef6d95f26d661a.context;
    p11._x63ef6d95f26d661a.previous = p11._x63ef6d95f26d661a.main;
    local v14 = os.clock();
    p11._x63ef6d95f26d661a.main = p12;
    p11._x63ef6d95f26d661a.context = p13;
    p11._x63ef6d95f26d661a.timestamp = v14;
    p11._x63ef6d95f26d661a.corresponding_played = false;
    p11._xc5fa3e947191ba87:Fire(p11._x63ef6d95f26d661a);
end;
function u1._xb75a9b96f615b203(u15) --[[ Line: 122 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x5178379199a428dc__17 = l__Classes__4._x7058397dabccd000._x5178379199a428dc;
    l___x5178379199a428dc__17.dash_started.Event:Connect(function(p16) --[[ Line: 125 ]]
        -- upvalues: u15 (copy)
        u15._x755d014fa3db3241.dashing = true;
        if p16 then
            u15._xb7bc362dc9415747 = p16;
        end;
    end;
    l___x5178379199a428dc__17.dash_ended.Event:Connect(function(p17) --[[ Line: 133 ]]
        -- upvalues: u15 (copy)
        u15._x755d014fa3db3241.dashing = false;
        u15._xb7bc362dc9415747 = p17;
    end;
    l___x5178379199a428dc__17.wallride_started.Event:Connect(function(p18) --[[ Line: 138 ]]
        -- upvalues: u15 (copy)
        u15._x755d014fa3db3241.wallriding = true;
        u15._xb7bc362dc9415747 = p18;
    end;
    l___x5178379199a428dc__17.wallride_ended.Event:Connect(function(p19) --[[ Line: 143 ]]
        -- upvalues: u15 (copy)
        u15._x755d014fa3db3241.wallriding = false;
        u15._xb7bc362dc9415747 = p19;
    end;
    l___x5178379199a428dc__17.slide_started.Event:Connect(function(p20) --[[ Line: 148 ]]
        -- upvalues: u15 (copy)
        u15._x755d014fa3db3241.sliding = true;
        u15._xb7bc362dc9415747 = p20;
    end;
    l___x5178379199a428dc__17.slide_ended.Event:Connect(function(p21) --[[ Line: 153 ]]
        -- upvalues: u15 (copy)
        u15._x755d014fa3db3241.sliding = false;
        u15._xb7bc362dc9415747 = p21;
    end;
end;
function u1._xd009baa5e5683b01(p22) --[[ Line: 160 ]]
    return p22._xeab7fd84ae7ea9f9;
end;
function u1._xbf06ccdc4b35dfcd(p23) --[[ Line: 164 ]]
    p23._xeab7fd84ae7ea9f9.corresponding_played = true;
end;
function u1._x74f3b438f5ad4a5a(p24) --[[ Line: 169 ]]
    p24._x63ef6d95f26d661a.corresponding_played = true;
end;
function u1._x0cfe0af1d4d19d5b(p25) --[[ Line: 173 ]]
    local v26 = p25:_x9f84975b8e5e1d56();
    local l___xb7bc362dc9415747__18 = p25._xb7bc362dc9415747;
    if v26 == "idle" or v26 == "running" then
        p25._xb7bc362dc9415747 = nil;
        l___xb7bc362dc9415747__18 = nil;
    end;
    if v26 ~= p25._xeab7fd84ae7ea9f9.main or l___xb7bc362dc9415747__18 ~= p25._xeab7fd84ae7ea9f9.context then
        p25:_x811167b32a66893d(v26, l___xb7bc362dc9415747__18);
    end;
end;
function u1._x2e6523af597c44c7(p27) --[[ Line: 188 ]]
    local v28 = p27:_x0180403c7fcc5f15();
    local l___xb7bc362dc9415747__19 = p27._xb7bc362dc9415747;
    if v28 == "idle" or v28 == "running" then
        l___xb7bc362dc9415747__19 = nil;
    end;
    if v28 ~= p27._x63ef6d95f26d661a.main or l___xb7bc362dc9415747__19 ~= p27._x63ef6d95f26d661a.context then
        p27:_x8c6fb57a0311ef98(v28, l___xb7bc362dc9415747__19);
    end;
end;
function u1._x3fe04ae6a44f82de(p29) --[[ Line: 203 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x7058397dabccd000__20 = l__Classes__4._x7058397dabccd000;
    local l__Magnitude__21 = l___x7058397dabccd000__20:getMoveDirection().Magnitude;
    local l__Magnitude__22 = l___x7058397dabccd000__20._x1d287c838240a901.Magnitude;
    local l___x755d014fa3db3241__23 = p29._x755d014fa3db3241;
    local l___xb7bc362dc9415747__24 = p29._xb7bc362dc9415747;
    local l___x8500fad561a4bbc9__25 = l___x7058397dabccd000__20._x8500fad561a4bbc9;
    local l___x5242295569714a31__26 = l___x7058397dabccd000__20._x5242295569714a31;
    local v30 = l___x755d014fa3db3241__23.wallriding and "wallriding" or (l___x755d014fa3db3241__23.sliding and "sliding" or (l___x755d014fa3db3241__23.dashing and "dashing" or (l___x8500fad561a4bbc9__25 and (not l___x5242295569714a31__26 and l__Magnitude__22 > 1) and "bhop_jump" or (l___x5242295569714a31__26 and (l__Magnitude__21 ~= 0 and l__Magnitude__22 > 1) and "running" or (l___x8500fad561a4bbc9__25 and "idle" or "falling")))));
    if v30 == "idle" or v30 == "running" then
        p29._xb7bc362dc9415747 = nil;
        l___xb7bc362dc9415747__24 = nil;
    end;
    if v30 ~= p29._xeab7fd84ae7ea9f9.main or l___xb7bc362dc9415747__24 ~= p29._xeab7fd84ae7ea9f9.context then
        p29:_x811167b32a66893d(v30, l___xb7bc362dc9415747__24);
    end;
    local l___x8500fad561a4bbc9__27 = l___x7058397dabccd000__20._x8500fad561a4bbc9;
    local l___x5242295569714a31__28 = l___x7058397dabccd000__20._x5242295569714a31;
    local v31 = l___x755d014fa3db3241__23.wallriding and "wallriding" or (l___x755d014fa3db3241__23.dashing and "dashing" or (l___x8500fad561a4bbc9__27 and (not l___x5242295569714a31__28 and l__Magnitude__22 > 1) and "bhop_jump" or (l___x5242295569714a31__28 and (l__Magnitude__21 ~= 0 and l__Magnitude__22 > 1) and "running" or (l___x8500fad561a4bbc9__27 and "idle" or "falling"))));
    local l___xb7bc362dc9415747__29 = p29._xb7bc362dc9415747;
    if v31 == "idle" or v31 == "running" then
        l___xb7bc362dc9415747__29 = nil;
    end;
    if v31 ~= p29._x63ef6d95f26d661a.main or l___xb7bc362dc9415747__29 ~= p29._x63ef6d95f26d661a.context then
        p29:_x8c6fb57a0311ef98(v31, l___xb7bc362dc9415747__29);
    end;
end;
function u1._xe53615d96cf36a6b(u32) --[[ Line: 232 ]]
    -- upvalues: l__RunService__1 (copy)
    task.defer(function() --[[ Line: 233 ]]
        -- upvalues: u32 (copy), l__RunService__1 (ref)
        u32:_xb75a9b96f615b203();
        l__RunService__1.RenderStepped:Connect(function() --[[ Line: 236 ]]
            -- upvalues: u32 (ref)
            u32:_x3fe04ae6a44f82de();
        end;
    end;
end;
return u1;
