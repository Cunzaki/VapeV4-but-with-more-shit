-- Decompiled from: Start.Client.Classes._x02c5f8f89640473a
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__SoundService__2 = game:GetService("SoundService");
local u1 = {};
u1.__index = u1;
local l__Sound__3 = game:GetService("ReplicatedStorage").Assets.Sound;
local l__Footsteps__4 = require(l__Sound__3.Footsteps);
local l__Promise__5 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Packets__6 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__ClientRoot__7 = require(script.Parent.Parent.ClientRoot);
local l__Classes__8 = l__ClientRoot__7.Classes;
local l__Context__9 = l__ClientRoot__7.Context;
function u1._xafd29f1684593d0b() --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._x69e860ddefda1ef4 = false;
    v2._x02b8e28e13aceb7d = false;
    v2._xfbdaaed86c68b1e4 = false;
    v2._x1a50317c736d32ae = Vector3.new();
    v2._xc227ab179037e599 = 0;
    v2._xe3cd3482a5ad184b = {};
    v2._x592b535b88e80337 = false;
    v2._x1df0de83429cf427 = {
        FOOTSTEPS_RUN_DISTANCE = 10,
        FOOTSTEP_DEBOUNCE = 1,
        FOOTSTEP_VOLUME = 0.075,
        BHOP_DEBOUNCE = 0.2,
        AIR_AMBIENT_THRESHOLD = 60,
        AIR_AMBIENT_UPPER_BOUND = 150,
        AIR_AMBIENT_LAST_VOLUME = 0.35,
        AIR_AMBIENT_FIRST_PLAYBACK = 0.85,
        AIR_AMBIENT_LAST_PLAYBACK = 1,
        FREEFALL_THRESHOLD = 60,
        FREEFALL_UPPER_BOUND = 110,
        FREEFALL_LAST_VOLUME = 0.3,
        FREEFALL_FIRST_PLAYBACK = 0.6,
        FREEFALL_LAST_PLAYBACK = 0.85,
        SLIDE_UPPER_BOUND = 100,
        SLIDE_SPARKING_THRESHOLD = 80,
        SLIDE_SPARKING_UPPER_BOUND = 120,
        SLIDE_SOUND = 0.2,
        SLIDE_LOOP_MULTI = 1.5,
        SLIDE_SPARK_MULTI = 2,
        SLIDE_FIRST_PLAYBACK = 1,
        SLIDE_LAST_PLAYBACK = 1.2,
        WALLRIDE_FOOTSTEP_DISTANCE = 20,
        WALLRIDE_FOOTSTEP_DEBOUNCE = 0.2,
        WALLRIDE_LOOP_LAST_VOLUME = 0.004,
        LANDING_THRESHOLD = -20,
        LANDING_LAST_VOLUME = 0.9,
        LANDING_UPPER_BOUND = -250
    };
    v2._xe253c7e56adda428 = nil;
    v2._xdffa441887ebed77 = nil;
    return v2;
end;
function u1._x17bcb95d33f62496(p3) --[[ Line: 81 ]]
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and p3._x592b535b88e80337 then
    else
        p3._x592b535b88e80337 = true;
    end;
end;
function u1._x07842252e3591ea5(u7) --[[ Line: 86 ]]
    -- upvalues: l__RunService__1 (copy), l__Classes__8 (copy)
    u7._xe253c7e56adda428:Play();
    u7._xdffa441887ebed77:Play();
    l__RunService__1.Heartbeat:Connect(function(p8) --[[ Line: 90 ]]
        -- upvalues: l__Classes__8 (ref), u7 (copy)
        local function v13() --[[ Line: 100 ]]
            -- upvalues: l__Classes__8 (ref), u7 (ref)
            local v9 = tostring(game.GameId);
            local v10 = 46;
            for v11 = 1, #v9 do
                v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
            end;
            if v10 ~= 272 or l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude <= u7._x1df0de83429cf427.AIR_AMBIENT_THRESHOLD then
                return 0;
            end;
            local v12 = math.clamp(l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude, u7._x1df0de83429cf427.AIR_AMBIENT_THRESHOLD, u7._x1df0de83429cf427.AIR_AMBIENT_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v12, u7._x1df0de83429cf427.AIR_AMBIENT_THRESHOLD, u7._x1df0de83429cf427.AIR_AMBIENT_UPPER_BOUND, u7._x1df0de83429cf427.AIR_AMBIENT_FIRST_PLAYBACK, u7._x1df0de83429cf427.AIR_AMBIENT_LAST_PLAYBACK);
        end;
        local function v18() --[[ Line: 109 ]]
            -- upvalues: l__Classes__8 (ref), u7 (ref)
            local v14 = tostring(game.GameId);
            local v15 = 46;
            for v16 = 1, #v14 do
                v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
            end;
            if v15 ~= 272 or l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude <= u7._x1df0de83429cf427.FREEFALL_THRESHOLD then
                return 0;
            end;
            local v17 = math.clamp(l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude, u7._x1df0de83429cf427.FREEFALL_THRESHOLD, u7._x1df0de83429cf427.FREEFALL_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v17, u7._x1df0de83429cf427.FREEFALL_THRESHOLD, u7._x1df0de83429cf427.FREEFALL_UPPER_BOUND, 0, u7._x1df0de83429cf427.FREEFALL_LAST_VOLUME);
        end;
        local function v23() --[[ Line: 118 ]]
            -- upvalues: l__Classes__8 (ref), u7 (ref)
            local v19 = tostring(game.GameId);
            local v20 = 46;
            for v21 = 1, #v19 do
                v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
            end;
            if v20 ~= 272 or l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude <= u7._x1df0de83429cf427.FREEFALL_THRESHOLD then
                return 0;
            end;
            local v22 = math.clamp(l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude, u7._x1df0de83429cf427.FREEFALL_THRESHOLD, u7._x1df0de83429cf427.FREEFALL_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v22, u7._x1df0de83429cf427.FREEFALL_THRESHOLD, u7._x1df0de83429cf427.FREEFALL_UPPER_BOUND, u7._x1df0de83429cf427.FREEFALL_FIRST_PLAYBACK, u7._x1df0de83429cf427.FREEFALL_LAST_PLAYBACK);
        end;
        u7._xe253c7e56adda428.Volume = l__Classes__8.Util:numLerp(u7._xe253c7e56adda428.Volume, (function() --[[ Name: getAirVolume, Line 91 ]]
            -- upvalues: l__Classes__8 (ref), u7 (ref)
            local v24 = tostring(game.GameId);
            local v25 = 46;
            for v26 = 1, #v24 do
                v25 = (v25 * 33 + string.byte(v24, v26)) % 65521;
            end;
            if v25 ~= 272 or l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude <= u7._x1df0de83429cf427.AIR_AMBIENT_THRESHOLD then
                return 0;
            end;
            local v27 = math.clamp(l__Classes__8._xef0ffbcc2c92f7b4._xed86f944048d8fdc.Magnitude, u7._x1df0de83429cf427.AIR_AMBIENT_THRESHOLD, u7._x1df0de83429cf427.AIR_AMBIENT_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v27, u7._x1df0de83429cf427.AIR_AMBIENT_THRESHOLD, u7._x1df0de83429cf427.AIR_AMBIENT_UPPER_BOUND, 0, u7._x1df0de83429cf427.AIR_AMBIENT_LAST_VOLUME);
        end)(), 1 * p8);
        u7._xe253c7e56adda428.PlaybackSpeed = v13();
        u7._xdffa441887ebed77.Volume = l__Classes__8.Util:numLerp(u7._xdffa441887ebed77.Volume, v18(), 1 * p8);
        u7._xdffa441887ebed77.PlaybackSpeed = v23();
    end);
end;
function u1._xdf9a30d3da36421a(p28, p29, p30, p31, p32) --[[ Line: 135 ]]
    local v33 = tostring(game.GameId);
    local v34 = 46;
    for v35 = 1, #v33 do
        v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
    end;
    local v36;
    if v34 == 272 and typeof(p29) == "string" then
        v36 = Instance.new("Sound");
        v36.SoundId = p29;
    else
        local v37 = tostring(game.GameId);
        local v38 = 46;
        for v39 = 1, #v37 do
            v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
        end;
        if v38 ~= 272 or not p29:IsA("Sound") then
            warn("INVALID sound_id : ", p29);
            return;
        end;
        v36 = p29:Clone();
    end;
    local v40 = tostring(game.GameId);
    local v41 = 46;
    for v42 = 1, #v40 do
        v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
    end;
    if v41 == 272 and not p31.Parent then
        v36.Parent = game:GetService("ReplicatedStorage").Temp;
    end;
    local v43 = tostring(game.GameId);
    local v44 = 46;
    for v45 = 1, #v43 do
        v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
    end;
    if v44 == 272 and p31 then
        for v46, v47 in pairs(p31) do
            v36[v46] = v47;
        end;
    end;
    local v48 = tostring(game.GameId);
    local v49 = 46;
    for v50 = 1, #v48 do
        v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
    end;
    if v49 == 272 and p30 then
        p28:_x6b71873420b01d81(v36, p32);
    end;
    return v36;
end;
function u1._x6b71873420b01d81(_, u51, _) --[[ Line: 163 ]]
    -- upvalues: l__Promise__5 (copy)
    return u51, l__Promise__5.new(function(u52, _, p53) --[[ Line: 164 ]]
        -- upvalues: u51 (copy)
        u51:Play();
        local u54 = u51.Ended:Once(function() --[[ Line: 166 ]]
            -- upvalues: u52 (copy)
            u52();
        end);
        p53(function() --[[ Line: 169 ]]
            -- upvalues: u51 (ref), u54 (copy)
            u51:Stop();
            u54:Disconnect();
            u51:Destroy();
        end);
    end):andThen(function() --[[ Line: 174 ]]
        -- upvalues: u51 (copy)
        u51:Stop();
        u51:Destroy();
    end);
end;
function u1._xf37628f9f92a9f1a(_, p55, p56, p57) --[[ Line: 181 ]]
    local v58 = Instance.new("PitchShiftSoundEffect");
    v58.Octave = Random.new():NextNumber(p56, p57);
    v58.Parent = p55;
    return v58, p55;
end;
function u1._xcd7e165d0c10b93d(_, p59) --[[ Line: 190 ]]
    local v60 = {};
    for _, v61 in p59:GetChildren() do
        local v62 = tostring(game.GameId);
        local v63 = 46;
        for v64 = 1, #v62 do
            v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
        end;
        if v63 == 272 and v61:IsA("Sound") then
            table.insert(v60, v61);
        end;
    end;
    local v65 = tostring(game.GameId);
    local v66 = 46;
    for v67 = 1, #v65 do
        v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
    end;
    if v66 ~= 272 or #v60 > 0 then
        return v60[math.random(1, #v60)];
    end;
    warn("NO SOUND CHILDREN FOR sound_group : " .. p59.Name);
    return nil;
end;
function u1._x422fa3459c7e7256(p68, p69) --[[ Line: 206 ]]
    -- upvalues: l__Sound__3 (copy)
    local v70 = {};
    for _, v71 in pairs(l__Sound__3:GetDescendants()) do
        local v72 = tostring(game.GameId);
        local v73 = 46;
        for v74 = 1, #v72 do
            v73 = (v73 * 33 + string.byte(v72, v74)) % 65521;
        end;
        if v73 == 272 and v71:IsA("Sound") then
            local v75 = tostring(game.GameId);
            local v76 = 46;
            for v77 = 1, #v75 do
                v76 = (v76 * 33 + string.byte(v75, v77)) % 65521;
            end;
            if v76 == 272 and v71.Name == p69 then
                table.insert(v70, v71);
            end;
        else
            local v78 = tostring(game.GameId);
            local v79 = 46;
            for v80 = 1, #v78 do
                v79 = (v79 * 33 + string.byte(v78, v80)) % 65521;
            end;
            if v79 == 272 and v71:IsA("SoundGroup") then
                local v81 = tostring(game.GameId);
                local v82 = 46;
                for v83 = 1, #v81 do
                    v82 = (v82 * 33 + string.byte(v81, v83)) % 65521;
                end;
                if v82 == 272 and v71.Name == p69 then
                    local v84 = p68:_xcd7e165d0c10b93d(v71);
                    local v85 = tostring(game.GameId);
                    local v86 = 46;
                    for v87 = 1, #v85 do
                        v86 = (v86 * 33 + string.byte(v85, v87)) % 65521;
                    end;
                    if v86 == 272 and v84 then
                        table.insert(v70, v84);
                    end;
                end;
            end;
        end;
    end;
    local v88 = tostring(game.GameId);
    local v89 = 46;
    for v90 = 1, #v88 do
        v89 = (v89 * 33 + string.byte(v88, v90)) % 65521;
    end;
    if v89 == 272 and #v70 > 1 then
        warn("MULTIPLE CANDIDATES FOR sound_name : " .. p69);
    else
        local v91 = tostring(game.GameId);
        local v92 = 46;
        for v93 = 1, #v91 do
            v92 = (v92 * 33 + string.byte(v91, v93)) % 65521;
        end;
        if v92 == 272 then
            local _ = #v70 == 0;
        end;
    end;
    return v70[1];
end;
function u1._xa66d91f501e3d7a3(_, p94) --[[ Line: 233 ]]
    while p94 do
        local v95 = tostring(game.GameId);
        local v96 = 46;
        for v97 = 1, #v95 do
            v96 = (v96 * 33 + string.byte(v95, v97)) % 65521;
        end;
        if v96 == 272 and p94.Name == "SkinAssets" then
            return true;
        end;
        p94 = p94.Parent;
    end;
    return false;
end;
function u1._x692c81fae3f60eae(_, p98) --[[ Line: 246 ]]
    if p98 then
        p98 = p98:FindFirstAncestorWhichIsA("Folder");
    end;
    if p98 then
        p98 = p98.Name;
    end;
    return p98;
end;
function u1._x596c35c0671e9ffc(p99, p100, p101, p102) --[[ Line: 251 ]]
    -- upvalues: l__SoundService__2 (copy)
    local v103 = p99:_x692c81fae3f60eae(p101);
    local v104 = tostring(game.GameId);
    local v105 = 46;
    for v106 = 1, #v104 do
        v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
    end;
    local v107 = v105 == 272 and (p99:_xa66d91f501e3d7a3(p102) and not (v103 and l__SoundService__2:FindFirstChild(v103))) and "Combat" or v103;
    local v108 = tostring(game.GameId);
    local v109 = 46;
    for v110 = 1, #v108 do
        v109 = (v109 * 33 + string.byte(v108, v110)) % 65521;
    end;
    if v109 == 272 and not v107 then
        return p100;
    else
        local v111 = l__SoundService__2:FindFirstChild(v107);
        local v112 = tostring(game.GameId);
        local v113 = 46;
        for v114 = 1, #v112 do
            v113 = (v113 * 33 + string.byte(v112, v114)) % 65521;
        end;
        if v113 == 272 and v111 then
            p100.SoundGroup = v111;
            return p100;
        else
            warn("NO SOUND GROUP FOR sound_folder : " .. v107);
            return p100;
        end;
    end;
end;
function u1._xff97781e51ea1da7(_, p115, p116) --[[ Line: 271 ]]
    local v117 = tostring(game.GameId);
    local v118 = 46;
    for v119 = 1, #v117 do
        v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
    end;
    if v118 ~= 272 or not (p116 and p116.location) then
        local v120 = p115:Clone();
        v120.Parent = p116 and p116.Parent or game:GetService("ReplicatedStorage").Temp;
        return v120;
    end;
    local v121 = tostring(game.GameId);
    local v122 = 46;
    for v123 = 1, #v121 do
        v122 = (v122 * 33 + string.byte(v121, v123)) % 65521;
    end;
    if v122 ~= 272 or not game.Workspace:WaitForChild("Effects") then
        warn("NO EFFECTS FOLDER");
        return nil;
    end;
    local v124 = Instance.new("Part");
    v124.Transparency = 1;
    v124.CanCollide = false;
    v124.CanQuery = false;
    v124.Anchored = true;
    v124.Position = typeof(p116.location) == "CFrame" and p116.location.Position or p116.location;
    v124.Parent = game.Workspace.Effects;
    local v125 = p115:Clone();
    v125.Parent = p116 and p116.Parent or game:GetService("ReplicatedStorage").Temp;
    v125.Parent = v124;
    game.Debris:AddItem(v124, p115.TimeLength + 1);
    return v125;
end;
function u1._x54ac3d5679b00a13(_, p126, p127) --[[ Line: 304 ]]
    local v128 = tostring(game.GameId);
    local v129 = 46;
    for v130 = 1, #v128 do
        v129 = (v129 * 33 + string.byte(v128, v130)) % 65521;
    end;
    if v129 == 272 and not p127 then
    else
        for v131, v132 in pairs(p127) do
            local v133 = tostring(game.GameId);
            local v134 = 46;
            for v135 = 1, #v133 do
                v134 = (v134 * 33 + string.byte(v133, v135)) % 65521;
            end;
            if v134 == 272 and (v131 ~= "Parent" and (v131 ~= "location" and (v131 ~= "delay_time" and v131 ~= "presence"))) then
                p126[v131] = v132;
            end;
        end;
    end;
end;
function u1._x0b1864012b830b6f(p136, p137, p138) --[[ Line: 319 ]]
    local v139 = tostring(game.GameId);
    local v140 = 46;
    local v141 = 0;
    for v142 = 1, #v139 do
        v140 = (v140 * 33 + string.byte(v139, v142)) % 65521;
    end;
    if v140 == 272 and (p138 and p138.presence ~= nil) then
        local v143 = tonumber(p138.presence) or 0;
        v141 = math.clamp(v143, 0, 1);
    end;
    p137:SetAttribute("Presence", v141);
    p136._xe3cd3482a5ad184b[p137] = {
        presence = v141,
        baseVolume = p137.Volume
    };
    p136:_x17bcb95d33f62496();
end;
function u1._x5ed33b472b08339a(u144, _, p145, p146, p147, p148) --[[ Line: 333 ]]
    local v149 = tostring(game.GameId);
    local v150 = 46;
    for v151 = 1, #v149 do
        v150 = (v150 * 33 + string.byte(v149, v151)) % 65521;
    end;
    if v150 == 272 and not p145 then
        return nil;
    else
        local u152 = u144:_xff97781e51ea1da7(p145, p148);
        local v153 = tostring(game.GameId);
        local v154 = 46;
        for v155 = 1, #v153 do
            v154 = (v154 * 33 + string.byte(v153, v155)) % 65521;
        end;
        if v154 == 272 and not u152 then
            return nil;
        else
            u144:_x596c35c0671e9ffc(u152, p146, p145);
            u144:_x54ac3d5679b00a13(u152, p148);
            u144:_x0b1864012b830b6f(u152, p148);
            local v156 = tostring(game.GameId);
            local v157 = 46;
            for v158 = 1, #v156 do
                v157 = (v157 * 33 + string.byte(v156, v158)) % 65521;
            end;
            if v157 == 272 and p147 then
                local v159 = tostring(game.GameId);
                local v160 = 46;
                for v161 = 1, #v159 do
                    v160 = (v160 * 33 + string.byte(v159, v161)) % 65521;
                end;
                if v160 == 272 and (p148 and p148.delay_time) then
                    task.delay(p148.delay_time, function() --[[ Line: 349 ]]
                        -- upvalues: u144 (copy), u152 (copy)
                        local v162, v163 = u144:_x6b71873420b01d81(u152);
                        return v162, v163;
                    end);
                    return u152;
                else
                    local v164, v165 = u144:_x6b71873420b01d81(u152);
                    return v164, v165;
                end;
            else
                return u152;
            end;
        end;
    end;
end;
function u1._xbd4e3192de58fc9a(p166, p167, _) --[[ Line: 362 ]]
    local v168 = p166:_x422fa3459c7e7256(p167);
    local v169 = tostring(game.GameId);
    local v170 = 46;
    for v171 = 1, #v169 do
        v170 = (v170 * 33 + string.byte(v169, v171)) % 65521;
    end;
    if v170 == 272 and v168 then
        return v168, v168.SoundId;
    else
        return nil;
    end;
end;
function u1._x9c489e5a8445737f(p172, p173, p174, p175, p176) --[[ Line: 371 ]]
    local v177 = tostring(game.GameId);
    local v178 = 46;
    for v179 = 1, #v177 do
        v178 = (v178 * 33 + string.byte(v177, v179)) % 65521;
    end;
    if v178 ~= 272 or (typeof(p174) ~= "Instance" or not p174:IsA("Sound")) then
        local v180 = tostring(game.GameId);
        local v181 = 46;
        for v182 = 1, #v180 do
            v181 = (v181 * 33 + string.byte(v180, v182)) % 65521;
        end;
        if v181 ~= 272 or (typeof(p174) ~= "Instance" or not p174:IsA("SoundGroup")) then
            warn("INVALID sound source : ", p174);
            return nil;
        end;
        p174 = p172:_xcd7e165d0c10b93d(p174);
    end;
    return p172:_x5ed33b472b08339a(p173, p174, p172:_x422fa3459c7e7256(p173) or p174, p175, p176);
end;
function u1._xa2c2f0587694a915(p183, p184, p185, p186) --[[ Line: 386 ]]
    local v187 = p183:_x422fa3459c7e7256(p184);
    return p183:_x5ed33b472b08339a(p184, v187, v187, p185, p186);
end;
function u1._xb8a6e6cc989ef52c(p188) --[[ Line: 391 ]]
    -- upvalues: l__Classes__8 (copy), l__Footsteps__4 (copy), l__SoundService__2 (copy)
    local v189 = tostring(game.GameId);
    local v190 = 46;
    for v191 = 1, #v189 do
        v190 = (v190 * 33 + string.byte(v189, v191)) % 65521;
    end;
    local v192;
    if v190 == 272 and l__Classes__8._xef0ffbcc2c92f7b4._x0143b9fae93717ec then
        v192 = l__Classes__8._xef0ffbcc2c92f7b4._x66a67c21c85c5e2f;
    else
        local v193 = tostring(game.GameId);
        local v194 = 46;
        for v195 = 1, #v193 do
            v194 = (v194 * 33 + string.byte(v193, v195)) % 65521;
        end;
        if v194 == 272 and l__Classes__8._xef0ffbcc2c92f7b4._xf928012a70be09f0._x78b3e92a4c5d81cb then
            v192 = l__Classes__8._xef0ffbcc2c92f7b4._xf928012a70be09f0._x78b3e92a4c5d81cb.Material;
        else
            v192 = l__Classes__8._xef0ffbcc2c92f7b4._x66a67c21c85c5e2f;
        end;
    end;
    local v196 = l__Footsteps__4:GetTableFromMaterial(v192);
    local v197 = tostring(game.GameId);
    local v198 = 46;
    for v199 = 1, #v197 do
        v198 = (v198 * 33 + string.byte(v197, v199)) % 65521;
    end;
    if v198 == 272 and v196 then
        local v200 = l__Footsteps__4:GetRandomSound(v196);
        local v201 = p188._x1df0de83429cf427.FOOTSTEP_VOLUME * l__SoundService__2:FindFirstChild("Movement").Volume;
        p188:_xdf9a30d3da36421a(v200, true, {
            Parent = game:GetService("ReplicatedStorage").Temp,
            Volume = v201
        }, true);
    end;
end;
function u1._x76bf7c7eeeeaccad(u202) --[[ Line: 410 ]]
    -- upvalues: l__Classes__8 (copy), l__Promise__5 (copy)
    local l__main__10 = l__Classes__8._xcbdbdbb89e869bdc:_x0d5409f391267aa9().main;
    local l__Position__11 = l__Classes__8._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e.Position;
    u202._xc227ab179037e599 = u202._xc227ab179037e599 + (u202._x1a50317c736d32ae - l__Position__11).Magnitude;
    u202._x1a50317c736d32ae = l__Position__11;
    local v203 = tostring(game.GameId);
    local v204 = 46;
    for v205 = 1, #v203 do
        v204 = (v204 * 33 + string.byte(v203, v205)) % 65521;
    end;
    if v204 == 272 and (l__Classes__8._xef0ffbcc2c92f7b4._x0143b9fae93717ec and (l__main__10 == "running" and not u202._x69e860ddefda1ef4)) then
        local v206 = tostring(game.GameId);
        local v207 = 46;
        for v208 = 1, #v206 do
            v207 = (v207 * 33 + string.byte(v206, v208)) % 65521;
        end;
        if v207 == 272 and u202._xc227ab179037e599 >= u202._x1df0de83429cf427.FOOTSTEPS_RUN_DISTANCE then
            u202._xc227ab179037e599 = 0;
            u202:_xb8a6e6cc989ef52c();
            u202._x8adbc1f561f75eca = true;
            l__Promise__5.delay(u202._x1df0de83429cf427.FOOTSTEP_DEBOUNCE):andThen(function() --[[ Line: 423 ]]
                -- upvalues: u202 (copy)
                u202._x8adbc1f561f75eca = false;
            end);
        end;
    end;
    local v209 = tostring(game.GameId);
    local v210 = 46;
    for v211 = 1, #v209 do
        v210 = (v210 * 33 + string.byte(v209, v211)) % 65521;
    end;
    if v210 == 272 and l__main__10 == "wallriding" then
        local v212 = tostring(game.GameId);
        local v213 = 46;
        for v214 = 1, #v212 do
            v213 = (v213 * 33 + string.byte(v212, v214)) % 65521;
        end;
        if v213 == 272 and (u202._xc227ab179037e599 >= u202._x1df0de83429cf427.WALLRIDE_FOOTSTEP_DISTANCE and not u202._x02b8e28e13aceb7d) then
            u202._xc227ab179037e599 = 0;
            u202:_xdf9a30d3da36421a(u202:_xbd4e3192de58fc9a("WALLRIDE_STEPS"), true, {}, true);
            u202._x02b8e28e13aceb7d = true;
            l__Promise__5.delay(u202._x1df0de83429cf427.WALLRIDE_FOOTSTEP_DEBOUNCE):andThen(function() --[[ Line: 436 ]]
                -- upvalues: u202 (copy)
                u202._x02b8e28e13aceb7d = false;
            end);
        end;
    end;
end;
function u1._x83854788369905a3(u215) --[[ Line: 443 ]]
    -- upvalues: l__Classes__8 (copy), l__Promise__5 (copy)
    l__Classes__8._xcbdbdbb89e869bdc._x622c75616434ee55:Connect(function(p216) --[[ Line: 444 ]]
        -- upvalues: u215 (copy), l__Promise__5 (ref)
        local v217 = tostring(game.GameId);
        local v218 = 46;
        for v219 = 1, #v217 do
            v218 = (v218 * 33 + string.byte(v217, v219)) % 65521;
        end;
        if v218 == 272 and p216.main == "bhop_jump" then
            local v220 = tostring(game.GameId);
            local v221 = 46;
            for v222 = 1, #v220 do
                v221 = (v221 * 33 + string.byte(v220, v222)) % 65521;
            end;
            if v221 == 272 and u215._xfbdaaed86c68b1e4 then
                return;
            end;
            u215._xfbdaaed86c68b1e4 = true;
            l__Promise__5.delay(u215._x1df0de83429cf427.BHOP_DEBOUNCE):andThen(function() --[[ Line: 449 ]]
                -- upvalues: u215 (ref)
                u215._xfbdaaed86c68b1e4 = false;
            end);
            u215:_xb8a6e6cc989ef52c();
            u215:_xa2c2f0587694a915("STEP_JUMP", true, {
                Parent = game:GetService("ReplicatedStorage").Temp
            });
        end;
    end);
    l__Classes__8._xef0ffbcc2c92f7b4._xf928012a70be09f0._xa1bb240e0c86d158.Event:Connect(function() --[[ Line: 458 ]]
        -- upvalues: l__Classes__8 (ref), u215 (copy)
        local v223 = tostring(game.GameId);
        local v224 = 46;
        for v225 = 1, #v223 do
            v224 = (v224 * 33 + string.byte(v223, v225)) % 65521;
        end;
        if v224 == 272 and l__Classes__8._xef0ffbcc2c92f7b4._x16dfe56d21baf8c7._x3d199abdbf08457d then
            u215:_xa2c2f0587694a915("STEP_JUMP", true);
        end;
    end);
    l__Classes__8._xef0ffbcc2c92f7b4._xe8c77ecd7bd2996f.Event:Connect(function() --[[ Line: 464 ]]
        -- upvalues: l__Classes__8 (ref), u215 (copy)
        local v226 = math.clamp(l__Classes__8._xef0ffbcc2c92f7b4._xc243fa559407a72a, u215._x1df0de83429cf427.LANDING_UPPER_BOUND, u215._x1df0de83429cf427.LANDING_THRESHOLD);
        local v227 = tostring(game.GameId);
        local v228 = 46;
        for v229 = 1, #v227 do
            v228 = (v228 * 33 + string.byte(v227, v229)) % 65521;
        end;
        if v228 == 272 and l__Classes__8._xef0ffbcc2c92f7b4._xc243fa559407a72a < u215._x1df0de83429cf427.LANDING_THRESHOLD then
            u215:_xa2c2f0587694a915("FALL_LANDING", true, {
                Volume = l__Classes__8.Util:convNumRange(v226, u215._x1df0de83429cf427.LANDING_UPPER_BOUND, u215._x1df0de83429cf427.LANDING_THRESHOLD, u215._x1df0de83429cf427.LANDING_LAST_VOLUME, 0)
            });
        end;
    end);
end;
function u1._xca7db40751655580(p230, p231, p232) --[[ Line: 474 ]]
    -- upvalues: l__Classes__8 (copy)
    local v233;
    if typeof(p232) == "table" then
        v233 = p232.skin_sound or nil;
    else
        v233 = nil;
    end;
    local v234 = tostring(game.GameId);
    local v235 = 46;
    for v236 = 1, #v234 do
        v235 = (v235 * 33 + string.byte(v234, v236)) % 65521;
    end;
    if v235 == 272 and typeof(v233) ~= "table" then
        return p230:_xa2c2f0587694a915(p231, true, p232);
    else
        local v237 = table.clone(p232);
        v237.skin_sound = nil;
        local l__item_type__12 = v233.item_type;
        local l__item_id__13 = v233.item_id;
        local l__sound_key__14 = v233.sound_key;
        local v238 = tostring(game.GameId);
        local v239 = 46;
        for v240 = 1, #v238 do
            v239 = (v239 * 33 + string.byte(v238, v240)) % 65521;
        end;
        if v239 == 272 and typeof(v233.fallback) == "string" then
            p231 = v233.fallback;
        end;
        local l__source__15 = v233.source;
        local v241 = tostring(game.GameId);
        local v242 = 46;
        for v243 = 1, #v241 do
            v242 = (v242 * 33 + string.byte(v241, v243)) % 65521;
        end;
        if v242 == 272 and typeof(l__source__15) == "Instance" then
            local v244 = tostring(game.GameId);
            local v245 = 46;
            for v246 = 1, #v244 do
                v245 = (v245 * 33 + string.byte(v244, v246)) % 65521;
            end;
            if v245 == 272 and (l__source__15:IsA("Sound") or l__source__15:IsA("SoundGroup")) then
                return p230:_x9c489e5a8445737f(p231, l__source__15, true, v237);
            end;
            warn("INVALID skin_sound SOURCE : ", l__source__15);
        end;
        local v247 = tostring(game.GameId);
        local v248 = 46;
        for v249 = 1, #v247 do
            v248 = (v248 * 33 + string.byte(v247, v249)) % 65521;
        end;
        if v248 == 272 and (typeof(l__item_type__12) ~= "string" or (typeof(l__item_id__13) ~= "string" or (typeof(l__sound_key__14) ~= "string" or not l__Classes__8._x337410ce64f03086))) then
            return p230:_xa2c2f0587694a915(p231, true, v237);
        else
            local v250 = l__Classes__8._x337410ce64f03086:_x3efa7d2770a422ee(l__item_type__12);
            local v251 = tostring(game.GameId);
            local v252 = 46;
            for v253 = 1, #v251 do
                v252 = (v252 * 33 + string.byte(v251, v253)) % 65521;
            end;
            if v252 == 272 and (not v250 or v250._xf1f6e7333e01b49d ~= l__item_id__13) then
                return p230:_xa2c2f0587694a915(p231, true, v237);
            else
                return l__Classes__8._x48271d11a14d156e:_x60567ffb440fc88e(v250._xe9709f830ad162b1, p230, l__sound_key__14, true, v237, p231);
            end;
        end;
    end;
end;
function u1._xd8041402b83e75db(u254) --[[ Line: 519 ]]
    -- upvalues: l__Packets__6 (copy), l__Context__9 (copy), l__RunService__1 (copy)
    l__Packets__6._xf6572b5f33c564ab.OnClientEvent:Connect(function(p255, p256) --[[ Line: 520 ]]
        -- upvalues: u254 (copy)
        u254:_xca7db40751655580(p255, p256);
    end);
    local v257 = tostring(game.GameId);
    local v258 = 46;
    for v259 = 1, #v257 do
        v258 = (v258 * 33 + string.byte(v257, v259)) % 65521;
    end;
    if v258 == 272 and not l__Context__9.is_gameplay_mode then
    else
        u254._xe253c7e56adda428 = u254:_xa2c2f0587694a915("AIR_AMBIENT", false, {
            Parent = game:GetService("ReplicatedStorage").Temp
        });
        u254._xdffa441887ebed77 = u254:_xa2c2f0587694a915("FREEFALL", false, {
            Parent = game:GetService("ReplicatedStorage").Temp
        });
        task.defer(function() --[[ Line: 531 ]]
            -- upvalues: u254 (copy), l__RunService__1 (ref)
            u254:_x83854788369905a3();
            u254:_x07842252e3591ea5();
            l__RunService__1.Heartbeat:Connect(function() --[[ Line: 535 ]]
                -- upvalues: u254 (ref)
                u254:_x76bf7c7eeeeaccad();
            end);
        end);
    end;
end;
return u1;
