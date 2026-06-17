-- Decompiled from: Start.Client.Classes._x3019cc5b1f776551
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u2._x83ed94bfb82a8c9f(p3) --[[ Line: 35 ]]
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
function u1._x83ed94bfb82a8c9f() --[[ Line: 60 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy), l__Signal__5 (copy)
    local v6 = setmetatable({}, u1);
    v6._xc36efc58996f5d85 = {};
    v6._xbef5d1d860f06f75 = {};
    v6._x7451e0cd1ca4d9e4 = 1;
    v6._x8f6e292d73153338 = nil;
    v6._xb9df97bde374ab0a = true;
    v6._x81af12119ee977ea = false;
    v6._x2db8e95a52f064da = true;
    v6._x91b580da79977c96 = 0;
    v6._x9144943684ea5ae0 = 0;
    v6._x32eba52aa3038179 = 1;
    v6._x008d534f79d2ac94 = 0;
    v6._x4940efa3d45ce5b3 = 0;
    v6._x38a4648a006d6ac6 = 0.6;
    v6._x2d92a287d9fcba18 = "combat";
    v6._x8638ba0d2d8d72ac = 0;
    v6._x38d840e373f3f97b = 0;
    v6._xaa5a6b549c08ee9e = 0;
    v6._x2bf045fe01292f07 = nil;
    v6._xdf1b248b1e7ebba8 = false;
    v6._xc080a1384bc8bd0c = nil;
    v6._x621f5c5a2d610006 = 0;
    v6._x4a8612c436fd95e6 = {
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
    v6._x05c83eccd4855c88 = l__Trove__6.new();
    v6._x1bda6760872f43ee = {
        onBeat = l__Signal__5.new()
    };
    v6._x1f4e9a7f7a0502d9 = false;
    v6._x141cec1831495884 = l__Signal__5.new();
    return v6;
end;
function u1._x44bcd6af41218f92(p7) --[[ Line: 125 ]]
    -- upvalues: l__Music__8 (copy), u2 (copy), l__PlaceContext__7 (copy)
    local l__Music__10 = game:GetService("SoundService"):WaitForChild("Music");
    for _, v8 in l__Music__8:GetChildren() do
        v8.SoundGroup = l__Music__10;
        table.insert(p7._xc36efc58996f5d85, u2._x83ed94bfb82a8c9f(v8));
    end;
    p7:_xaa2dd46b4786a947();
    p7._x1f4e9a7f7a0502d9 = true;
    p7._x141cec1831495884:Fire();
    if l__PlaceContext__7.get().effective_mode == l__PlaceContext__7.EffectiveModes.PUBLIC_LOBBY then
        p7:_xba28441e0836bc41("menu");
    end;
end;
function u1._xaa2dd46b4786a947(u9) --[[ Line: 144 ]]
    -- upvalues: l__Packets__4 (copy)
    u9._x05c83eccd4855c88:Connect(l__Packets__4.unreliablePackets._x6b11fde7f06edda2.OnClientEvent, function(p10, p11) --[[ Line: 145 ]]
        -- upvalues: u9 (copy)
        u9:_x3a3a2a5d005b7d04(p10, p11);
    end);
    u9._x05c83eccd4855c88:Connect(l__Packets__4.unreliablePackets._xbd2cb2a1aa5e781f.OnClientEvent, function(p12, p13) --[[ Line: 149 ]]
        -- upvalues: u9 (copy)
        u9:_x1e8655ddd9e8f763(p12, p13);
    end);
end;
function u1._x678ac90d81c1c878(p14, p15) --[[ Line: 157 ]]
    if p14._x8f6e292d73153338 then
        local l___x8f6e292d73153338__11 = p14._x8f6e292d73153338;
        l___x8f6e292d73153338__11.TimePosition = l___x8f6e292d73153338__11.TimePosition + p15;
    end;
end;
function u1._x3a3a2a5d005b7d04(p16, p17, p18) --[[ Line: 163 ]]
    p16._x91b580da79977c96 = math.clamp(p16._x91b580da79977c96 + p17, 0, 1);
    if p18 then
        p16._x9144943684ea5ae0 = math.clamp(p16._x9144943684ea5ae0 + p18, 0, p16._x4a8612c436fd95e6.max_pause);
    end;
end;
function u1._xe4c08adaf44f0341(p19, p20) --[[ Line: 175 ]]
    p19._x4940efa3d45ce5b3 = math.clamp(p19._x4940efa3d45ce5b3 + p20, 0, p19._x4a8612c436fd95e6.max_distortion);
end;
function u1._x1e8655ddd9e8f763(p21, p22, p23) --[[ Line: 183 ]]
    p21._x32eba52aa3038179 = math.clamp(p21._x32eba52aa3038179 + p22, 1, p21._x4a8612c436fd95e6.max_boost);
    if p23 then
        p21._x008d534f79d2ac94 = math.clamp(p21._x008d534f79d2ac94 + p23, 0, p21._x4a8612c436fd95e6.max_boost_pause);
    end;
end;
function u1._x95bac8ed5b795464(p24, p25) --[[ Line: 202 ]]
    local v26 = p25.bpm / 60 / 10;
    local v27 = os.clock();
    if v26 <= v27 - p24._x8638ba0d2d8d72ac then
        p24._x8638ba0d2d8d72ac = v27;
        p24._x1bda6760872f43ee.onBeat:Fire();
    end;
end;
function u1._xc03325fd48494b20(p28, p29) --[[ Line: 213 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l___x8f6e292d73153338__12 = p28._x8f6e292d73153338;
    if l___x8f6e292d73153338__12 and l___x8f6e292d73153338__12.IsPlaying then
        local v30 = p28._xbef5d1d860f06f75[p28._x7451e0cd1ca4d9e4];
        if v30 then
            local l__TimePosition__13 = l___x8f6e292d73153338__12.TimePosition;
            if p28._xdf1b248b1e7ebba8 or v30.endtime > l__TimePosition__13 then
                p28._x008d534f79d2ac94 = math.max(p28._x008d534f79d2ac94 - p29, 0);
                p28._x9144943684ea5ae0 = math.max(p28._x9144943684ea5ae0 - p29, 0);
                p28._x4940efa3d45ce5b3 = math.max(p28._x4940efa3d45ce5b3 - p29 * p28._x4a8612c436fd95e6.distortion_decay, 0);
                if p28._x9144943684ea5ae0 == 0 then
                    p28._x91b580da79977c96 = math.clamp(p28._x91b580da79977c96 - p29 * p28._x4a8612c436fd95e6.clarity_decay, 0, 1);
                end;
                if p28._x008d534f79d2ac94 == 0 then
                    p28._x32eba52aa3038179 = math.clamp(p28._x32eba52aa3038179 - p29 * p28._x4a8612c436fd95e6.boost_decay, 1, p28._x4a8612c436fd95e6.max_boost);
                end;
                p28:_x95bac8ed5b795464(v30);
                if p28._x81af12119ee977ea then
                    l___x8f6e292d73153338__12.Volume = 0;
                else
                    if v30.can_dynamic and p28._xb9df97bde374ab0a then
                        local l__eq__14 = v30.eq;
                        local l__distortion__15 = v30.distortion;
                        if l__eq__14 then
                            l__eq__14.Enabled = true;
                            l__eq__14.HighGain = math.map(p28._x91b580da79977c96, 0, 1, v30.dampened_eq.HighGain, 0);
                            l__eq__14.MidGain = math.map(p28._x91b580da79977c96, 0, 1, v30.dampened_eq.MidGain, 0);
                            l__eq__14.LowGain = math.map(l__TweenService__1:GetValue(p28._x91b580da79977c96, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 0, 1, v30.dampened_eq.LowGain, 0);
                        end;
                        if l__distortion__15 then
                            l__distortion__15.Level = p28._x4940efa3d45ce5b3;
                        end;
                    elseif v30.eq then
                        v30.eq.Enabled = false;
                    end;
                    if p28._x38d840e373f3f97b > 0 and p28._x38d840e373f3f97b <= l__TimePosition__13 then
                        local v31 = math.map(l__TimePosition__13 - p28._x38d840e373f3f97b, 0, p28._x4a8612c436fd95e6.fade_time, 1, 0);
                        local v32 = math.clamp(v31, 0, 1);
                        l___x8f6e292d73153338__12.Volume = v30.base_volume * p28._x32eba52aa3038179 * p28._x38a4648a006d6ac6 * v32;
                    else
                        l___x8f6e292d73153338__12.Volume = v30.base_volume * p28._x32eba52aa3038179 * p28._x38a4648a006d6ac6;
                    end;
                end;
            else
                p28._xdf1b248b1e7ebba8 = true;
                p28:_x5063164e5a3c84de();
            end;
        end;
    else
        if not p28._xdf1b248b1e7ebba8 then
            p28._xdf1b248b1e7ebba8 = true;
            p28:_x5063164e5a3c84de();
        end;
    end;
end;
function u1._xba28441e0836bc41(u33, p34) --[[ Line: 335 ]]
    -- upvalues: l__Classes__9 (copy), l__RunService__2 (copy)
    if not u33._x1f4e9a7f7a0502d9 then
        u33._x141cec1831495884:Wait();
    end;
    if u33._x2bf045fe01292f07 then
        u33._x2bf045fe01292f07:Disconnect();
        u33._x2bf045fe01292f07 = nil;
    end;
    for _, v35 in u33._xc36efc58996f5d85 do
        local l__inst__16 = v35.inst;
        if l__inst__16.IsPlaying then
            l__inst__16:Stop();
        end;
        l__inst__16.TimePosition = 0;
        l__inst__16.Volume = 0;
    end;
    u33._x8f6e292d73153338 = nil;
    u33._xdf1b248b1e7ebba8 = false;
    if p34 then
        u33._x2d92a287d9fcba18 = p34;
    end;
    u33._x7451e0cd1ca4d9e4 = 1;
    local v36 = {};
    for _, v37 in u33._xc36efc58996f5d85 do
        if v37.environment == u33._x2d92a287d9fcba18 then
            table.insert(v36, v37);
        end;
    end;
    u33._xbef5d1d860f06f75 = l__Classes__9.Util:randomizeTable(v36);
    if #u33._xbef5d1d860f06f75 == 0 then
        warn("No music found for environment:", u33._x2d92a287d9fcba18);
    else
        u33:_x598271f2ff8ebf63(1);
        u33._x2bf045fe01292f07 = l__RunService__2.Heartbeat:Connect(function(p38) --[[ Line: 383 ]]
            -- upvalues: u33 (copy)
            u33:_xc03325fd48494b20(p38);
        end);
        u33._x05c83eccd4855c88:Add(u33._x2bf045fe01292f07);
    end;
end;
function u1._x598271f2ff8ebf63(p39, p40) --[[ Line: 391 ]]
    local v41 = p39._xbef5d1d860f06f75[p40];
    if v41 then
        local l__inst__17 = v41.inst;
        l__inst__17:Stop();
        l__inst__17.TimePosition = l__inst__17:GetAttribute("StartTime") or 0;
        l__inst__17.Volume = (v41.base_volume or 1) * p39._x32eba52aa3038179 * p39._x38a4648a006d6ac6;
        p39._x8f6e292d73153338 = l__inst__17;
        p39._x7451e0cd1ca4d9e4 = p40;
        p39._xdf1b248b1e7ebba8 = false;
        l__inst__17:Play();
        p39._xaa5a6b549c08ee9e = os.clock();
        p39._x38d840e373f3f97b = math.max(0, v41.endtime - p39._x4a8612c436fd95e6.fade_time);
    else
        warn("INVALID INDEX:", p40);
    end;
end;
function u1._x3313e4125fba1aad(p42) --[[ Line: 417 ]]
    if p42._x8f6e292d73153338 then
        local l___x8f6e292d73153338__18 = p42._x8f6e292d73153338;
        p42._x8f6e292d73153338 = nil;
        l___x8f6e292d73153338__18:Stop();
        l___x8f6e292d73153338__18.TimePosition = 0;
        l___x8f6e292d73153338__18.Volume = 0;
    end;
    p42._xdf1b248b1e7ebba8 = false;
end;
function u1._x5063164e5a3c84de(p43) --[[ Line: 432 ]]
    local v44 = p43._x7451e0cd1ca4d9e4 + 1;
    if #p43._xbef5d1d860f06f75 < v44 then
        if not p43._x2db8e95a52f064da then
            p43._xdf1b248b1e7ebba8 = false;
            return;
        end;
        v44 = 1;
    end;
    p43:_x3313e4125fba1aad();
    p43:_x598271f2ff8ebf63(v44);
end;
function u1._x1c98630577f6c428(p45) --[[ Line: 450 ]]
    local v46 = p45._x7451e0cd1ca4d9e4 - 1;
    if v46 < 1 then
        if not p45._x2db8e95a52f064da then
            return;
        end;
        v46 = #p45._xbef5d1d860f06f75;
    end;
    p45:_x3313e4125fba1aad();
    p45:_x598271f2ff8ebf63(v46);
end;
return u1;
