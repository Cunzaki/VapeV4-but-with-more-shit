-- Decompiled from: Start.Client.Classes._x9b074161e70581e8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
function u2._xafd29f1684593d0b(p3) --[[ Line: 35 ]]
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
function u1._xafd29f1684593d0b() --[[ Line: 60 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy), l__Signal__5 (copy)
    local v6 = setmetatable({}, u1);
    v6._x2027216e5ae6412a = {};
    v6._xf558833e149ad49a = {};
    v6._x47a0874526b0e664 = 1;
    v6._xd70dfae0d789e7a0 = nil;
    v6._xa90960bc078ef532 = true;
    v6._xf0f93a3799b30928 = false;
    v6._x095167748a1717be = true;
    v6._x279b42a5502bb102 = 0;
    v6._x7d5718c7eec5f97c = 0;
    v6._xf6321f3cb5d1462a = 1;
    v6._xc63fbce055723bb6 = 0;
    v6._x2d523cedcdd514f1 = 0;
    v6._xb4a858d5a5bba54c = 0.6;
    v6._x433d98dffc5fa23f = "combat";
    v6._x6c06f248e2f44fac = 0;
    v6._x416af87a244e509a = 0;
    v6._x01ed42540ed84ba7 = 0;
    v6._x7df31f99441c65c2 = nil;
    v6._x68764c92dc38d686 = false;
    v6._xcb9b40e30efb2dd2 = nil;
    v6._xe08b6632f51ae837 = 0;
    v6._x7f233d0eeb648f26 = {
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
    v6._xb573bf6f153ad1a5 = l__Trove__6.new();
    v6._xcd7daa1c4cf4bd7d = {
        onBeat = l__Signal__5.new()
    };
    v6._x0072c71aa60f4654 = false;
    v6._x431f4ca5517a4e53 = l__Signal__5.new();
    return v6;
end;
function u1._xd8041402b83e75db(p7) --[[ Line: 125 ]]
    -- upvalues: l__Music__8 (copy), u2 (copy), l__PlaceContext__7 (copy)
    local l__Music__10 = game:GetService("SoundService"):WaitForChild("Music");
    for _, v8 in l__Music__8:GetChildren() do
        v8.SoundGroup = l__Music__10;
        table.insert(p7._x2027216e5ae6412a, u2._xafd29f1684593d0b(v8));
    end;
    p7:_xe0f3f2c4816c8839();
    p7._x0072c71aa60f4654 = true;
    p7._x431f4ca5517a4e53:Fire();
    local v9 = tostring(game.GameId);
    local v10 = 46;
    for v11 = 1, #v9 do
        v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
    end;
    if v10 == 272 and l__PlaceContext__7.get().effective_mode == l__PlaceContext__7.EffectiveModes.PUBLIC_LOBBY then
        p7:_xcc5f292712de0f3a("menu");
    end;
end;
function u1._xe0f3f2c4816c8839(u12) --[[ Line: 144 ]]
    -- upvalues: l__Packets__4 (copy)
    u12._xb573bf6f153ad1a5:Connect(l__Packets__4.unreliablePackets._x03b97699d899b5d1.OnClientEvent, function(p13, p14) --[[ Line: 145 ]]
        -- upvalues: u12 (copy)
        u12:_xcde373a27057623b(p13, p14);
    end);
    u12._xb573bf6f153ad1a5:Connect(l__Packets__4.unreliablePackets._x5b55b35800d88aa6.OnClientEvent, function(p15, p16) --[[ Line: 149 ]]
        -- upvalues: u12 (copy)
        u12:_x9a1da09f62b60713(p15, p16);
    end);
end;
function u1._xcf8681029b881778(p17, p18) --[[ Line: 157 ]]
    local v19 = tostring(game.GameId);
    local v20 = 46;
    for v21 = 1, #v19 do
        v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
    end;
    if v20 == 272 and p17._xd70dfae0d789e7a0 then
        local l___xd70dfae0d789e7a0__11 = p17._xd70dfae0d789e7a0;
        l___xd70dfae0d789e7a0__11.TimePosition = l___xd70dfae0d789e7a0__11.TimePosition + p18;
    end;
end;
function u1._xcde373a27057623b(p22, p23, p24) --[[ Line: 163 ]]
    p22._x279b42a5502bb102 = math.clamp(p22._x279b42a5502bb102 + p23, 0, 1);
    local v25 = tostring(game.GameId);
    local v26 = 46;
    for v27 = 1, #v25 do
        v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
    end;
    if v26 == 272 and p24 then
        p22._x7d5718c7eec5f97c = math.clamp(p22._x7d5718c7eec5f97c + p24, 0, p22._x7f233d0eeb648f26.max_pause);
    end;
end;
function u1._xbfbee1a5722a295d(p28, p29) --[[ Line: 175 ]]
    p28._x2d523cedcdd514f1 = math.clamp(p28._x2d523cedcdd514f1 + p29, 0, p28._x7f233d0eeb648f26.max_distortion);
end;
function u1._x9a1da09f62b60713(p30, p31, p32) --[[ Line: 183 ]]
    p30._xf6321f3cb5d1462a = math.clamp(p30._xf6321f3cb5d1462a + p31, 1, p30._x7f233d0eeb648f26.max_boost);
    local v33 = tostring(game.GameId);
    local v34 = 46;
    for v35 = 1, #v33 do
        v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
    end;
    if v34 == 272 and p32 then
        p30._xc63fbce055723bb6 = math.clamp(p30._xc63fbce055723bb6 + p32, 0, p30._x7f233d0eeb648f26.max_boost_pause);
    end;
end;
function u1._x6a8668d8d8ff6166(p36, p37) --[[ Line: 202 ]]
    local v38 = p37.bpm / 60 / 10;
    local v39 = os.clock();
    local v40 = tostring(game.GameId);
    local v41 = 46;
    for v42 = 1, #v40 do
        v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
    end;
    if v41 == 272 and v38 <= v39 - p36._x6c06f248e2f44fac then
        p36._x6c06f248e2f44fac = v39;
        p36._xcd7daa1c4cf4bd7d.onBeat:Fire();
    end;
end;
function u1._xa459abb14a27290b(p43, p44) --[[ Line: 213 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l___xd70dfae0d789e7a0__12 = p43._xd70dfae0d789e7a0;
    local v45 = tostring(game.GameId);
    local v46 = 46;
    for v47 = 1, #v45 do
        v46 = (v46 * 33 + string.byte(v45, v47)) % 65521;
    end;
    if v46 == 272 and not (l___xd70dfae0d789e7a0__12 and l___xd70dfae0d789e7a0__12.IsPlaying) then
        local v48 = tostring(game.GameId);
        local v49 = 46;
        for v50 = 1, #v48 do
            v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
        end;
        if v49 == 272 and not p43._x68764c92dc38d686 then
            p43._x68764c92dc38d686 = true;
            p43:_x6ca7d1ae54ae193b();
        end;
    else
        local v51 = p43._xf558833e149ad49a[p43._x47a0874526b0e664];
        local v52 = tostring(game.GameId);
        local v53 = 46;
        for v54 = 1, #v52 do
            v53 = (v53 * 33 + string.byte(v52, v54)) % 65521;
        end;
        if v53 == 272 and not v51 then
        else
            local l__TimePosition__13 = l___xd70dfae0d789e7a0__12.TimePosition;
            local v55 = tostring(game.GameId);
            local v56 = 46;
            for v57 = 1, #v55 do
                v56 = (v56 * 33 + string.byte(v55, v57)) % 65521;
            end;
            if v56 == 272 and (not p43._x68764c92dc38d686 and v51.endtime <= l__TimePosition__13) then
                p43._x68764c92dc38d686 = true;
                p43:_x6ca7d1ae54ae193b();
            else
                p43._xc63fbce055723bb6 = math.max(p43._xc63fbce055723bb6 - p44, 0);
                p43._x7d5718c7eec5f97c = math.max(p43._x7d5718c7eec5f97c - p44, 0);
                p43._x2d523cedcdd514f1 = math.max(p43._x2d523cedcdd514f1 - p44 * p43._x7f233d0eeb648f26.distortion_decay, 0);
                local v58 = tostring(game.GameId);
                local v59 = 46;
                for v60 = 1, #v58 do
                    v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
                end;
                if v59 == 272 and p43._x7d5718c7eec5f97c == 0 then
                    p43._x279b42a5502bb102 = math.clamp(p43._x279b42a5502bb102 - p44 * p43._x7f233d0eeb648f26.clarity_decay, 0, 1);
                end;
                local v61 = tostring(game.GameId);
                local v62 = 46;
                for v63 = 1, #v61 do
                    v62 = (v62 * 33 + string.byte(v61, v63)) % 65521;
                end;
                if v62 == 272 and p43._xc63fbce055723bb6 == 0 then
                    p43._xf6321f3cb5d1462a = math.clamp(p43._xf6321f3cb5d1462a - p44 * p43._x7f233d0eeb648f26.boost_decay, 1, p43._x7f233d0eeb648f26.max_boost);
                end;
                p43:_x6a8668d8d8ff6166(v51);
                local v64 = tostring(game.GameId);
                local v65 = 46;
                for v66 = 1, #v64 do
                    v65 = (v65 * 33 + string.byte(v64, v66)) % 65521;
                end;
                if v65 == 272 and p43._xf0f93a3799b30928 then
                    l___xd70dfae0d789e7a0__12.Volume = 0;
                else
                    local v67 = tostring(game.GameId);
                    local v68 = 46;
                    for v69 = 1, #v67 do
                        v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
                    end;
                    if v68 == 272 and (v51.can_dynamic and p43._xa90960bc078ef532) then
                        local l__eq__14 = v51.eq;
                        local l__distortion__15 = v51.distortion;
                        local v70 = tostring(game.GameId);
                        local v71 = 46;
                        for v72 = 1, #v70 do
                            v71 = (v71 * 33 + string.byte(v70, v72)) % 65521;
                        end;
                        if v71 == 272 and l__eq__14 then
                            l__eq__14.Enabled = true;
                            l__eq__14.HighGain = math.map(p43._x279b42a5502bb102, 0, 1, v51.dampened_eq.HighGain, 0);
                            l__eq__14.MidGain = math.map(p43._x279b42a5502bb102, 0, 1, v51.dampened_eq.MidGain, 0);
                            l__eq__14.LowGain = math.map(l__TweenService__1:GetValue(p43._x279b42a5502bb102, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 0, 1, v51.dampened_eq.LowGain, 0);
                        end;
                        local v73 = tostring(game.GameId);
                        local v74 = 46;
                        for v75 = 1, #v73 do
                            v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
                        end;
                        if v74 == 272 and l__distortion__15 then
                            l__distortion__15.Level = p43._x2d523cedcdd514f1;
                        end;
                    else
                        local v76 = tostring(game.GameId);
                        local v77 = 46;
                        for v78 = 1, #v76 do
                            v77 = (v77 * 33 + string.byte(v76, v78)) % 65521;
                        end;
                        if v77 == 272 and v51.eq then
                            v51.eq.Enabled = false;
                        end;
                    end;
                    local v79 = tostring(game.GameId);
                    local v80 = 46;
                    for v81 = 1, #v79 do
                        v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
                    end;
                    if v80 == 272 and (p43._x416af87a244e509a > 0 and p43._x416af87a244e509a <= l__TimePosition__13) then
                        local v82 = math.map(l__TimePosition__13 - p43._x416af87a244e509a, 0, p43._x7f233d0eeb648f26.fade_time, 1, 0);
                        local v83 = math.clamp(v82, 0, 1);
                        l___xd70dfae0d789e7a0__12.Volume = v51.base_volume * p43._xf6321f3cb5d1462a * p43._xb4a858d5a5bba54c * v83;
                    else
                        l___xd70dfae0d789e7a0__12.Volume = v51.base_volume * p43._xf6321f3cb5d1462a * p43._xb4a858d5a5bba54c;
                    end;
                end;
            end;
        end;
    end;
end;
function u1._xcc5f292712de0f3a(u84, p85) --[[ Line: 335 ]]
    -- upvalues: l__Classes__9 (copy), l__RunService__2 (copy)
    local v86 = tostring(game.GameId);
    local v87 = 46;
    for v88 = 1, #v86 do
        v87 = (v87 * 33 + string.byte(v86, v88)) % 65521;
    end;
    if v87 == 272 and not u84._x0072c71aa60f4654 then
        u84._x431f4ca5517a4e53:Wait();
    end;
    local v89 = tostring(game.GameId);
    local v90 = 46;
    for v91 = 1, #v89 do
        v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
    end;
    if v90 == 272 and u84._x7df31f99441c65c2 then
        u84._x7df31f99441c65c2:Disconnect();
        u84._x7df31f99441c65c2 = nil;
    end;
    for _, v92 in u84._x2027216e5ae6412a do
        local l__inst__16 = v92.inst;
        local v93 = tostring(game.GameId);
        local v94 = 46;
        for v95 = 1, #v93 do
            v94 = (v94 * 33 + string.byte(v93, v95)) % 65521;
        end;
        if v94 == 272 and l__inst__16.IsPlaying then
            l__inst__16:Stop();
        end;
        l__inst__16.TimePosition = 0;
        l__inst__16.Volume = 0;
    end;
    u84._xd70dfae0d789e7a0 = nil;
    u84._x68764c92dc38d686 = false;
    local v96 = tostring(game.GameId);
    local v97 = 46;
    for v98 = 1, #v96 do
        v97 = (v97 * 33 + string.byte(v96, v98)) % 65521;
    end;
    if v97 == 272 and p85 then
        u84._x433d98dffc5fa23f = p85;
    end;
    u84._x47a0874526b0e664 = 1;
    local v99 = {};
    for _, v100 in u84._x2027216e5ae6412a do
        local v101 = tostring(game.GameId);
        local v102 = 46;
        for v103 = 1, #v101 do
            v102 = (v102 * 33 + string.byte(v101, v103)) % 65521;
        end;
        if v102 == 272 and v100.environment == u84._x433d98dffc5fa23f then
            table.insert(v99, v100);
        end;
    end;
    u84._xf558833e149ad49a = l__Classes__9.Util:randomizeTable(v99);
    local v104 = tostring(game.GameId);
    local v105 = 46;
    for v106 = 1, #v104 do
        v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
    end;
    if v105 == 272 and #u84._xf558833e149ad49a == 0 then
        warn("No music found for environment:", u84._x433d98dffc5fa23f);
    else
        u84:_x6751ab98ac79d546(1);
        u84._x7df31f99441c65c2 = l__RunService__2.Heartbeat:Connect(function(p107) --[[ Line: 383 ]]
            -- upvalues: u84 (copy)
            u84:_xa459abb14a27290b(p107);
        end);
        u84._xb573bf6f153ad1a5:Add(u84._x7df31f99441c65c2);
    end;
end;
function u1._x6751ab98ac79d546(p108, p109) --[[ Line: 391 ]]
    local v110 = p108._xf558833e149ad49a[p109];
    local v111 = tostring(game.GameId);
    local v112 = 46;
    for v113 = 1, #v111 do
        v112 = (v112 * 33 + string.byte(v111, v113)) % 65521;
    end;
    if v112 == 272 and not v110 then
        warn("INVALID INDEX:", p109);
    else
        local l__inst__17 = v110.inst;
        l__inst__17:Stop();
        l__inst__17.TimePosition = l__inst__17:GetAttribute("StartTime") or 0;
        l__inst__17.Volume = (v110.base_volume or 1) * p108._xf6321f3cb5d1462a * p108._xb4a858d5a5bba54c;
        p108._xd70dfae0d789e7a0 = l__inst__17;
        p108._x47a0874526b0e664 = p109;
        p108._x68764c92dc38d686 = false;
        l__inst__17:Play();
        p108._x01ed42540ed84ba7 = os.clock();
        p108._x416af87a244e509a = math.max(0, v110.endtime - p108._x7f233d0eeb648f26.fade_time);
    end;
end;
function u1._xa4619ea5d8417b61(p114) --[[ Line: 417 ]]
    local v115 = tostring(game.GameId);
    local v116 = 46;
    for v117 = 1, #v115 do
        v116 = (v116 * 33 + string.byte(v115, v117)) % 65521;
    end;
    if v116 == 272 and p114._xd70dfae0d789e7a0 then
        local l___xd70dfae0d789e7a0__18 = p114._xd70dfae0d789e7a0;
        p114._xd70dfae0d789e7a0 = nil;
        l___xd70dfae0d789e7a0__18:Stop();
        l___xd70dfae0d789e7a0__18.TimePosition = 0;
        l___xd70dfae0d789e7a0__18.Volume = 0;
    end;
    p114._x68764c92dc38d686 = false;
end;
function u1._x6ca7d1ae54ae193b(p118) --[[ Line: 432 ]]
    local v119 = p118._x47a0874526b0e664 + 1;
    local v120 = tostring(game.GameId);
    local v121 = 46;
    for v122 = 1, #v120 do
        v121 = (v121 * 33 + string.byte(v120, v122)) % 65521;
    end;
    if v121 == 272 and #p118._xf558833e149ad49a < v119 then
        local v123 = tostring(game.GameId);
        local v124 = 46;
        for v125 = 1, #v123 do
            v124 = (v124 * 33 + string.byte(v123, v125)) % 65521;
        end;
        if v124 ~= 272 or not p118._x095167748a1717be then
            p118._x68764c92dc38d686 = false;
            return;
        end;
        v119 = 1;
    end;
    p118:_xa4619ea5d8417b61();
    p118:_x6751ab98ac79d546(v119);
end;
function u1._x23b0fb54f68df7cc(p126) --[[ Line: 450 ]]
    local v127 = p126._x47a0874526b0e664 - 1;
    local v128 = tostring(game.GameId);
    local v129 = 46;
    for v130 = 1, #v128 do
        v129 = (v129 * 33 + string.byte(v128, v130)) % 65521;
    end;
    if v129 == 272 and v127 < 1 then
        local v131 = tostring(game.GameId);
        local v132 = 46;
        for v133 = 1, #v131 do
            v132 = (v132 * 33 + string.byte(v131, v133)) % 65521;
        end;
        if v132 ~= 272 or not p126._x095167748a1717be then
            return;
        end;
        v127 = #p126._xf558833e149ad49a;
    end;
    p126:_xa4619ea5d8417b61();
    p126:_x6751ab98ac79d546(v127);
end;
return u1;
