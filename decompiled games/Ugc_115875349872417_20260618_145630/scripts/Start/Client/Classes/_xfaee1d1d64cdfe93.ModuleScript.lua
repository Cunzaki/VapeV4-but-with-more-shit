-- Decompiled from: Start.Client.Classes._xfaee1d1d64cdfe93
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
local l__Signal__5 = require(l__ModuleScripts__3.Signal);
local l__Trove__6 = require(l__ModuleScripts__3.Trove);
local l__PlaceContext__7 = require(l__ModuleScripts__3.PlaceContext);
local l__Music__8 = game:GetService("ReplicatedStorage").Assets.Music;
local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;
local l__Classes__9 = require(script.Parent.Parent.ClientRoot).Classes;
function u2._x90d4581ac99dd483(p3) --[[ Line: 26 ]]
    -- upvalues: u2 (copy)
    local v4 = p3:FindFirstChild("EqualizerSoundEffect");
    local v5 = {
        can_dynamic = true,
        inst = p3,
        environment = p3:GetAttribute("Environment"),
        title = p3:GetAttribute("Title"),
        base_volume = p3:GetAttribute("BaseVolume"),
        endtime = p3:GetAttribute("EndTime"),
        eq = v4,
        bpm = p3:GetAttribute("BPM"),
        distortion = p3:FindFirstChild("DistortionSoundEffect"),
        dampened_eq = {
            HighGain = v4 and (v4.HighGain or 0) or 0,
            MidGain = v4 and (v4.MidGain or 0) or 0,
            LowGain = v4 and v4.LowGain or 0
        }
    };
    return setmetatable(v5, u2);
end;
function u1._x90d4581ac99dd483() --[[ Line: 51 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy), l__Signal__5 (copy)
    local v6 = setmetatable({}, u1);
    v6._xfe4c2602dab49106 = {};
    v6._x371b503c898dc1aa = {};
    v6._x6f4db409cdf45146 = 1;
    v6._x793b18940d27b61e = nil;
    v6._xbfb7d045fd9aeae2 = true;
    v6._x9d953ef0950533a5 = false;
    v6._xcac7c6cf3fa6e959 = true;
    v6._x5fc8868a2d4cd8f9 = 0;
    v6._x6b86ed52c0a35647 = 0;
    v6._x6eea72ee5f438bb8 = 1;
    v6._x4f80b13c165cc066 = 0;
    v6._x66b42a1f10d77113 = 0;
    v6._x9374c60b0eb68ccd = 0.6;
    v6._x7406e6cf304936ad = "combat";
    v6._x2839e0e629ebe05b = 0;
    v6._xea14c1ed0bab6b1a = 0;
    v6._xbbeeb8d541e0d0df = 0;
    v6._x4d55b3a2374149ec = nil;
    v6._x89c4223f0a282b10 = false;
    v6._x3b8e5ed719a04f66 = nil;
    v6._x4b1a48ea3764371f = 0;
    v6._xe1dd33f94f36b34c = {
        max_pause = 11,
        clarity_decay = 0.01,
        distortion_decay = 0.2,
        max_distortion = 0.5,
        fade_time = 5,
        max_boost = 1.5,
        boost_decay = 0.1,
        max_boost_pause = 0.5,
        crossfade_time = 1
    };
    v6._x038c50aa9b468f1f = l__Trove__6.new();
    v6._xc94f8ca0598b7403 = {
        onBeat = l__Signal__5.new()
    };
    v6._xd40e9e2c970278a4 = false;
    v6._x69d088e44678c49a = l__Signal__5.new();
    return v6;
end;
function u1._xe53615d96cf36a6b(p7) --[[ Line: 116 ]]
    -- upvalues: l__Music__8 (copy), u2 (copy), l__PlaceContext__7 (copy)
    local l__Music__10 = game:GetService("SoundService"):WaitForChild("Music");
    for _, v8 in l__Music__8:GetChildren() do
        v8.SoundGroup = l__Music__10;
        table.insert(p7._xfe4c2602dab49106, u2._x90d4581ac99dd483(v8));
    end;
    p7:_x0fb034219169fd72();
    p7._xd40e9e2c970278a4 = true;
    p7._x69d088e44678c49a:Fire();
    if l__PlaceContext__7.get().effective_mode == l__PlaceContext__7.EffectiveModes.PUBLIC_LOBBY then
        p7:_x8fcdafeb8ad3312d("menu");
    end;
end;
function u1._x0fb034219169fd72(u9) --[[ Line: 135 ]]
    -- upvalues: l__Packets__4 (copy)
    u9._x038c50aa9b468f1f:Connect(l__Packets__4.unreliablePackets._xb2c4d57f1a1d68e0.OnClientEvent, function(p10, p11) --[[ Line: 136 ]]
        -- upvalues: u9 (copy)
        u9:_x3f8b63442918abf2(p10, p11);
    end;
    u9._x038c50aa9b468f1f:Connect(l__Packets__4.unreliablePackets._x32655291067177dc.OnClientEvent, function(p12, p13) --[[ Line: 140 ]]
        -- upvalues: u9 (copy)
        u9:_x71e0dd46f992ad7c(p12, p13);
    end;
end;
function u1._x5aefbb1e0aaf3407(p14, p15) --[[ Line: 148 ]]
    if p14._x793b18940d27b61e then
        local l___x793b18940d27b61e__11 = p14._x793b18940d27b61e;
        l___x793b18940d27b61e__11.TimePosition = l___x793b18940d27b61e__11.TimePosition + p15;
    end;
end;
function u1._x3f8b63442918abf2(p16, p17, p18) --[[ Line: 154 ]]
    p16._x5fc8868a2d4cd8f9 = math.clamp(p16._x5fc8868a2d4cd8f9 + p17, 0, 1);
    if p18 then
        p16._x6b86ed52c0a35647 = math.clamp(p16._x6b86ed52c0a35647 + p18, 0, p16._xe1dd33f94f36b34c.max_pause);
    end;
end;
function u1._x8857a3c89504ee1a(p19, p20) --[[ Line: 166 ]]
    p19._x66b42a1f10d77113 = math.clamp(p19._x66b42a1f10d77113 + p20, 0, p19._xe1dd33f94f36b34c.max_distortion);
end;
function u1._x71e0dd46f992ad7c(p21, p22, p23) --[[ Line: 174 ]]
    p21._x6eea72ee5f438bb8 = math.clamp(p21._x6eea72ee5f438bb8 + p22, 1, p21._xe1dd33f94f36b34c.max_boost);
    if p23 then
        p21._x4f80b13c165cc066 = math.clamp(p21._x4f80b13c165cc066 + p23, 0, p21._xe1dd33f94f36b34c.max_boost_pause);
    end;
end;
function u1._xda9979f186a38426(p24, p25) --[[ Line: 193 ]]
    local v26 = p25.bpm / 60 / 10;
    local v27 = os.clock();
    if v26 <= v27 - p24._x2839e0e629ebe05b then
        p24._x2839e0e629ebe05b = v27;
        p24._xc94f8ca0598b7403.onBeat:Fire();
    end;
end;
function u1._x18ce98f7a2e31248(p28, p29) --[[ Line: 204 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l___x793b18940d27b61e__12 = p28._x793b18940d27b61e;
    if l___x793b18940d27b61e__12 and l___x793b18940d27b61e__12.IsPlaying then
        local v30 = p28._x371b503c898dc1aa[p28._x6f4db409cdf45146];
        if v30 then
            local l__TimePosition__13 = l___x793b18940d27b61e__12.TimePosition;
            if p28._x89c4223f0a282b10 or v30.endtime > l__TimePosition__13 then
                p28._x4f80b13c165cc066 = math.max(p28._x4f80b13c165cc066 - p29, 0);
                p28._x6b86ed52c0a35647 = math.max(p28._x6b86ed52c0a35647 - p29, 0);
                p28._x66b42a1f10d77113 = math.max(p28._x66b42a1f10d77113 - p29 * p28._xe1dd33f94f36b34c.distortion_decay, 0);
                if p28._x6b86ed52c0a35647 == 0 then
                    p28._x5fc8868a2d4cd8f9 = math.clamp(p28._x5fc8868a2d4cd8f9 - p29 * p28._xe1dd33f94f36b34c.clarity_decay, 0, 1);
                end;
                if p28._x4f80b13c165cc066 == 0 then
                    p28._x6eea72ee5f438bb8 = math.clamp(p28._x6eea72ee5f438bb8 - p29 * p28._xe1dd33f94f36b34c.boost_decay, 1, p28._xe1dd33f94f36b34c.max_boost);
                end;
                p28:_xda9979f186a38426(v30);
                if p28._x9d953ef0950533a5 then
                    l___x793b18940d27b61e__12.Volume = 0;
                else
                    if v30.can_dynamic and p28._xbfb7d045fd9aeae2 then
                        local l__eq__14 = v30.eq;
                        local l__distortion__15 = v30.distortion;
                        if l__eq__14 then
                            l__eq__14.Enabled = true;
                            l__eq__14.HighGain = math.map(p28._x5fc8868a2d4cd8f9, 0, 1, v30.dampened_eq.HighGain, 0);
                            l__eq__14.MidGain = math.map(p28._x5fc8868a2d4cd8f9, 0, 1, v30.dampened_eq.MidGain, 0);
                            l__eq__14.LowGain = math.map(l__TweenService__1:GetValue(p28._x5fc8868a2d4cd8f9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 0, 1, v30.dampened_eq.LowGain, 0);
                        end;
                        if l__distortion__15 then
                            l__distortion__15.Level = p28._x66b42a1f10d77113;
                        end;
                    elseif v30.eq then
                        v30.eq.Enabled = false;
                    end;
                    if p28._xea14c1ed0bab6b1a > 0 and p28._xea14c1ed0bab6b1a <= l__TimePosition__13 then
                        local v31 = math.map(l__TimePosition__13 - p28._xea14c1ed0bab6b1a, 0, p28._xe1dd33f94f36b34c.fade_time, 1, 0);
                        local v32 = math.clamp(v31, 0, 1);
                        l___x793b18940d27b61e__12.Volume = v30.base_volume * p28._x6eea72ee5f438bb8 * p28._x9374c60b0eb68ccd * v32;
                    else
                        l___x793b18940d27b61e__12.Volume = v30.base_volume * p28._x6eea72ee5f438bb8 * p28._x9374c60b0eb68ccd;
                    end;
                end;
            else
                p28._x89c4223f0a282b10 = true;
                p28:_x41223ebcb934acdb();
            end;
        end;
    else
        if not p28._x89c4223f0a282b10 then
            p28._x89c4223f0a282b10 = true;
            p28:_x41223ebcb934acdb();
        end;
    end;
end;
function u1._x8fcdafeb8ad3312d(u33, p34) --[[ Line: 326 ]]
    -- upvalues: l__Classes__9 (copy), l__RunService__2 (copy)
    if not u33._xd40e9e2c970278a4 then
        u33._x69d088e44678c49a:Wait();
    end;
    if u33._x4d55b3a2374149ec then
        u33._x4d55b3a2374149ec:Disconnect();
        u33._x4d55b3a2374149ec = nil;
    end;
    for _, v35 in u33._xfe4c2602dab49106 do
        local l__inst__16 = v35.inst;
        if l__inst__16.IsPlaying then
            l__inst__16:Stop();
        end;
        l__inst__16.TimePosition = 0;
        l__inst__16.Volume = 0;
    end;
    u33._x793b18940d27b61e = nil;
    u33._x89c4223f0a282b10 = false;
    if p34 then
        u33._x7406e6cf304936ad = p34;
    end;
    u33._x6f4db409cdf45146 = 1;
    local v36 = {};
    for _, v37 in u33._xfe4c2602dab49106 do
        if v37.environment == u33._x7406e6cf304936ad then
            table.insert(v36, v37);
        end;
    end;
    u33._x371b503c898dc1aa = l__Classes__9.Util:randomizeTable(v36);
    if #u33._x371b503c898dc1aa == 0 then
        warn("No music found for environment:", u33._x7406e6cf304936ad);
    else
        u33:_x7a2a88807f90032e(1);
        u33._x4d55b3a2374149ec = l__RunService__2.Heartbeat:Connect(function(p38) --[[ Line: 374 ]]
            -- upvalues: u33 (copy)
            u33:_x18ce98f7a2e31248(p38);
        end;
        u33._x038c50aa9b468f1f:Add(u33._x4d55b3a2374149ec);
    end;
end;
function u1._x7a2a88807f90032e(p39, p40) --[[ Line: 382 ]]
    local v41 = p39._x371b503c898dc1aa[p40];
    if v41 then
        local l__inst__17 = v41.inst;
        l__inst__17:Stop();
        l__inst__17.TimePosition = l__inst__17:GetAttribute("StartTime") or 0;
        l__inst__17.Volume = (v41.base_volume or 1) * p39._x6eea72ee5f438bb8 * p39._x9374c60b0eb68ccd;
        p39._x793b18940d27b61e = l__inst__17;
        p39._x6f4db409cdf45146 = p40;
        p39._x89c4223f0a282b10 = false;
        l__inst__17:Play();
        p39._xbbeeb8d541e0d0df = os.clock();
        p39._xea14c1ed0bab6b1a = math.max(0, v41.endtime - p39._xe1dd33f94f36b34c.fade_time);
    else
        warn("INVALID INDEX:", p40);
    end;
end;
function u1._x76075f44dc107d6f(p42) --[[ Line: 408 ]]
    if p42._x793b18940d27b61e then
        local l___x793b18940d27b61e__18 = p42._x793b18940d27b61e;
        p42._x793b18940d27b61e = nil;
        l___x793b18940d27b61e__18:Stop();
        l___x793b18940d27b61e__18.TimePosition = 0;
        l___x793b18940d27b61e__18.Volume = 0;
    end;
    p42._x89c4223f0a282b10 = false;
end;
function u1._x41223ebcb934acdb(p43) --[[ Line: 423 ]]
    local v44 = p43._x6f4db409cdf45146 + 1;
    if #p43._x371b503c898dc1aa < v44 then
        if not p43._xcac7c6cf3fa6e959 then
            p43._x89c4223f0a282b10 = false;
            return;
        end;
        v44 = 1;
    end;
    p43:_x76075f44dc107d6f();
    p43:_x7a2a88807f90032e(v44);
end;
function u1._x332cf78eb78ec6e3(p45) --[[ Line: 441 ]]
    local v46 = p45._x6f4db409cdf45146 - 1;
    if v46 < 1 then
        if not p45._xcac7c6cf3fa6e959 then
            return;
        end;
        v46 = #p45._x371b503c898dc1aa;
    end;
    p45:_x76075f44dc107d6f();
    p45:_x7a2a88807f90032e(v46);
end;
return u1;
