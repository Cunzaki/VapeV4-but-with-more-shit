-- Decompiled from: Start.Client.Classes._x63706a97ab028e93
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__ModuleScripts__3 = l__ReplicatedStorage__2.Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
require(l__ModuleScripts__3.Signal);
local l__Promise__5 = require(l__ModuleScripts__3.Promise);
local l__Trove__6 = require(l__ModuleScripts__3.Trove);
require(l__ModuleScripts__3.Spring);
local u1 = {};
u1.__index = u1;
local l__Classes__7 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__8 = game.Players.LocalPlayer;
local u2 = {
    "Idle",
    "Walk",
    "RJump",
    "LJump",
    "LAerial",
    "RAerial",
    "LWallride",
    "RWallride",
    "Wallkick",
    "SlideStartArm",
    "SlideLoopArm",
    "SlideLoop",
    "SlideEndArm",
    "SlideAerialArm",
    "GrapplePull",
    "GrappleThrow",
    "PullGrounded",
    "Parry",
    "Deflect",
    "CAttack",
    "LAttack",
    "RAttack",
    "Gundraw",
    "Gunshot",
    "Bonusshot"
};
function u1._xafd29f1684593d0b() --[[ Line: 35 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy)
    local v3 = setmetatable({}, u1);
    v3._xd3871c503e253e63 = {};
    v3._x63e45fe77bb0f49c = {};
    v3._xe10c355847aeca27 = {};
    v3._x8ead96513766f21d = l__Trove__6.new();
    v3._xf641edc0690f84e7 = {};
    v3._x307ab6a2b3c6a962 = false;
    v3._x396abf5abf91a245 = false;
    v3._x703d70a3b2cae0a5 = false;
    v3._x94d217a5ed70aa50 = {};
    return v3;
end;
function u1._xe22155c30981caf8(_) --[[ Line: 60 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local v4, v5 = pcall(function() --[[ Line: 61 ]]
        -- upvalues: l__LocalPlayer__8 (ref)
        return l__LocalPlayer__8.Character.Humanoid.Animator;
    end);
    local v6 = tostring(game.GameId);
    local v7 = 46;
    for v8 = 1, #v6 do
        v7 = (v7 * 33 + string.byte(v6, v8)) % 65521;
    end;
    if v7 == 272 and v4 then
        return v5;
    end;
end;
function u1._x42c88c6ff8c6db93(p9, p10, p11) --[[ Line: 68 ]]
    p9._xd3871c503e253e63[p10] = p11;
end;
function u1._xb4dbd9904936b73b(u12, p13, p14) --[[ Line: 72 ]]
    -- upvalues: l__Promise__5 (copy)
    local u15 = u12._xd3871c503e253e63[p13];
    local v16 = tostring(game.GameId);
    local v17 = 46;
    for v18 = 1, #v16 do
        v17 = (v17 * 33 + string.byte(v16, v18)) % 65521;
    end;
    if v17 == 272 and u15 then
        local v19;
        if p14 then
            v19 = p14.fade_time;
        else
            v19 = p14;
        end;
        local v20;
        if p14 then
            v20 = p14.weight;
        else
            v20 = p14;
        end;
        u15:Play(v19, v20);
        local v21 = tostring(game.GameId);
        local v22 = 46;
        for v23 = 1, #v21 do
            v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
        end;
        if v22 == 272 and p14.force_look then
            local u24 = game:GetService("HttpService"):GenerateGUID();
            table.insert(u12._x94d217a5ed70aa50, u24);
            task.defer(function() --[[ Line: 83 ]]
                -- upvalues: l__Promise__5 (ref), u15 (copy), u12 (copy), u24 (copy)
                local v34 = { l__Promise__5.delay(5), (l__Promise__5.new(function(u25, _, p26) --[[ Line: 85 ]]
                        -- upvalues: u15 (ref)
                        local u27 = nil;
                        u27 = u15.Stopped:Once(function() --[[ Line: 93 ]]
                            -- upvalues: u25 (copy), u27 (ref)
                            u25();
                            local v28 = tostring(game.GameId);
                            local v29 = 46;
                            for v30 = 1, #v28 do
                                v29 = (v29 * 33 + string.byte(v28, v30)) % 65521;
                            end;
                            if v29 == 272 and u27 then
                                u27:Disconnect();
                                u27 = nil;
                            end;
                        end);
                        p26(function() --[[ Line: 97 ]]
                            -- upvalues: u27 (ref)
                            local v31 = tostring(game.GameId);
                            local v32 = 46;
                            for v33 = 1, #v31 do
                                v32 = (v32 * 33 + string.byte(v31, v33)) % 65521;
                            end;
                            if v32 == 272 and u27 then
                                u27:Disconnect();
                                u27 = nil;
                            end;
                        end);
                    end)) };
                l__Promise__5.race(v34):finally(function() --[[ Line: 103 ]]
                    -- upvalues: u12 (ref), u24 (ref)
                    local v35 = table.find(u12._x94d217a5ed70aa50, u24);
                    local v36 = tostring(game.GameId);
                    local v37 = 46;
                    for v38 = 1, #v36 do
                        v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
                    end;
                    if v37 == 272 and v35 then
                        table.remove(u12._x94d217a5ed70aa50, v35);
                    end;
                end);
            end);
        end;
        local v39 = tostring(game.GameId);
        local v40 = 46;
        for v41 = 1, #v39 do
            v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
        end;
        if v40 == 272 and p14.override then
            for _, v42 in p14.override do
                local v43 = u12._xd3871c503e253e63[v42];
                local v44 = tostring(game.GameId);
                local v45 = 46;
                for v46 = 1, #v44 do
                    v45 = (v45 * 33 + string.byte(v44, v46)) % 65521;
                end;
                if v45 == 272 and v43 then
                    v43:Stop();
                end;
            end;
        end;
        return u15;
    end;
    warn(p13 .. " DOES NOT EXIST");
end;
function u1._x4d1852ccfc365606(p47, p48, p49) --[[ Line: 130 ]]
    local v50 = p47._xd3871c503e253e63[p48];
    local v51 = tostring(game.GameId);
    local v52 = 46;
    for v53 = 1, #v51 do
        v52 = (v52 * 33 + string.byte(v51, v53)) % 65521;
    end;
    if v52 == 272 and v50 then
        v50:Stop(p49);
    end;
end;
function u1._xb48f4ae2fb0a91f5(u54, u55, p56, p57) --[[ Line: 138 ]]
    -- upvalues: l__Promise__5 (copy)
    local v58 = tostring(game.GameId);
    local v59 = 46;
    for v60 = 1, #v58 do
        v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
    end;
    if v59 == 272 and typeof(u55) == "string" then
        u55 = u54._xd3871c503e253e63[u55];
    end;
    local v61 = tostring(game.GameId);
    local v62 = 46;
    for v63 = 1, #v61 do
        v62 = (v62 * 33 + string.byte(v61, v63)) % 65521;
    end;
    if v62 == 272 and not u55 then
        return;
    end;
    local v64 = u54:_xe22155c30981caf8();
    local v65 = tostring(game.GameId);
    local v66 = 46;
    for v67 = 1, #v65 do
        v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
    end;
    if v66 == 272 and not v64 then
        return;
    end;
    local v68 = v64:GetPlayingAnimationTracks();
    local v69 = tostring(game.GameId);
    local v70 = 46;
    local v71 = {
        "SlideEndArm",
        "SlideStartArm",
        "SlideLoopArm",
        "SlideLoop",
        "GrappleThrow",
        "GrapplePull",
        "PullGrounded",
        "Parry",
        "Deflect",
        "CAttack",
        "LAttack",
        "RAttack",
        "Gundraw",
        "Gunshot",
        "Bonusshot"
    };
    for v72 = 1, #v69 do
        v70 = (v70 * 33 + string.byte(v69, v72)) % 65521;
    end;
    if v70 == 272 and p56.force_look then
        local u73 = game:GetService("HttpService"):GenerateGUID();
        table.insert(u54._x94d217a5ed70aa50, u73);
        task.defer(function() --[[ Line: 157 ]]
            -- upvalues: l__Promise__5 (ref), u55 (ref), u54 (copy), u73 (copy)
            local v83 = { l__Promise__5.delay(5), (l__Promise__5.new(function(u74, _, p75) --[[ Line: 159 ]]
                    -- upvalues: u55 (ref)
                    local u76 = nil;
                    u76 = u55.Stopped:Once(function() --[[ Line: 167 ]]
                        -- upvalues: u74 (copy), u76 (ref)
                        u74();
                        local v77 = tostring(game.GameId);
                        local v78 = 46;
                        for v79 = 1, #v77 do
                            v78 = (v78 * 33 + string.byte(v77, v79)) % 65521;
                        end;
                        if v78 == 272 and u76 then
                            u76:Disconnect();
                            u76 = nil;
                        end;
                    end);
                    p75(function() --[[ Line: 171 ]]
                        -- upvalues: u76 (ref)
                        local v80 = tostring(game.GameId);
                        local v81 = 46;
                        for v82 = 1, #v80 do
                            v81 = (v81 * 33 + string.byte(v80, v82)) % 65521;
                        end;
                        if v81 == 272 and u76 then
                            u76:Disconnect();
                            u76 = nil;
                        end;
                    end);
                end)) };
            l__Promise__5.race(v83):finally(function() --[[ Line: 177 ]]
                -- upvalues: u54 (ref), u73 (ref)
                local v84 = table.find(u54._x94d217a5ed70aa50, u73);
                local v85 = tostring(game.GameId);
                local v86 = 46;
                for v87 = 1, #v85 do
                    v86 = (v86 * 33 + string.byte(v85, v87)) % 65521;
                end;
                if v86 == 272 and v84 then
                    table.remove(u54._x94d217a5ed70aa50, v84);
                end;
            end);
        end);
    end;
    local v88 = tostring(game.GameId);
    local v89 = 46;
    for v90 = 1, #v88 do
        v89 = (v89 * 33 + string.byte(v88, v90)) % 65521;
    end;
    if v89 == 272 and v68 then
        for _, v91 in v68 do
            local v92 = tostring(game.GameId);
            local v93 = 46;
            for v94 = 1, #v92 do
                v93 = (v93 * 33 + string.byte(v92, v94)) % 65521;
            end;
            if v93 ~= 272 or v91 ~= u55 then
                local v95 = false;
                for _, v96 in v71 do
                    local v97 = tostring(game.GameId);
                    local v98 = 46;
                    for v99 = 1, #v97 do
                        v98 = (v98 * 33 + string.byte(v97, v99)) % 65521;
                    end;
                    if v98 == 272 and (u54._xd3871c503e253e63[v96] and v91 == u54._xd3871c503e253e63[v96]) then
                        v95 = true;
                        break;
                    end;
                end;
                local v100 = tostring(game.GameId);
                local v101 = 46;
                for v102 = 1, #v100 do
                    v101 = (v101 * 33 + string.byte(v100, v102)) % 65521;
                end;
                if v101 ~= 272 or not v95 then
                    local v103 = tostring(game.GameId);
                    local v104 = 46;
                    for v105 = 1, #v103 do
                        v104 = (v104 * 33 + string.byte(v103, v105)) % 65521;
                    end;
                    if v104 ~= 272 or not (p57 and table.find(p57, v91)) then
                        local v106;
                        if p56 then
                            v106 = p56.fade_time;
                        else
                            v106 = p56;
                        end;
                        v91:Stop(v106);
                    end;
                end;
            end;
        end;
    end;
    local v107 = tostring(game.GameId);
    local v108 = 46;
    for v109 = 1, #v107 do
        v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
    end;
    if v108 == 272 and table.find(v68, u55) then
        local v110 = 1;
        local v111;
        if p56 then
            v111 = p56.fade_time;
        else
            v111 = p56;
        end;
        u55:AdjustWeight(v110, v111);
        local v112;
        if p56 then
            v112 = p56.fade_time;
        else
            v112 = p56;
        end;
        if p56 then
            p56 = p56.weight;
        end;
        u55:Play(v112, p56);
    else
        local v113;
        if p56 then
            v113 = p56.fade_time;
        else
            v113 = p56;
        end;
        if p56 then
            p56 = p56.weight;
        end;
        u55:Play(v113, p56);
    end;
end;
function u1._x038e8ec76226df29(p114, p115) --[[ Line: 212 ]]
    -- upvalues: l__Classes__7 (copy)
    local v116 = tostring(game.GameId);
    local v117 = 46;
    for v118 = 1, #v116 do
        v117 = (v117 * 33 + string.byte(v116, v118)) % 65521;
    end;
    if v117 == 272 and not p114._x396abf5abf91a245 then
    else
        local l__main__9 = p115.main;
        local _ = p115.previous;
        local l__context__10 = p115.context;
        local _ = p115.previous_context;
        local _ = p115.corresponding_played;
        local l___xd3871c503e253e63__11 = p114._xd3871c503e253e63;
        local l___xef0ffbcc2c92f7b4__12 = l__Classes__7._xef0ffbcc2c92f7b4;
        local _ = l___xef0ffbcc2c92f7b4__12._x16dfe56d21baf8c7._x3d199abdbf08457d;
        local _ = l___xef0ffbcc2c92f7b4__12._xf928012a70be09f0;
        local v119 = tostring(game.GameId);
        local v120 = 46;
        for v121 = 1, #v119 do
            v120 = (v120 * 33 + string.byte(v119, v121)) % 65521;
        end;
        if v120 == 272 and l__main__9 == "bhop_jump" then
            local v122 = tostring(game.GameId);
            local v123 = 46;
            for v124 = 1, #v122 do
                v123 = (v123 * 33 + string.byte(v122, v124)) % 65521;
            end;
            if v123 == 272 and p114._x307ab6a2b3c6a962 then
                p114:_xb48f4ae2fb0a91f5(l___xd3871c503e253e63__11.LJump, {
                    fade_time = 0.15
                });
            else
                p114:_xb48f4ae2fb0a91f5(l___xd3871c503e253e63__11.RJump, {
                    fade_time = 0.15
                });
            end;
        else
            local v125 = tostring(game.GameId);
            local v126 = 46;
            for v127 = 1, #v125 do
                v126 = (v126 * 33 + string.byte(v125, v127)) % 65521;
            end;
            if v126 == 272 and l__main__9 == "falling" then
                local v128 = tostring(game.GameId);
                local v129 = 46;
                for v130 = 1, #v128 do
                    v129 = (v129 * 33 + string.byte(v128, v130)) % 65521;
                end;
                if v129 == 272 and p114._x307ab6a2b3c6a962 then
                    p114:_xb48f4ae2fb0a91f5(l___xd3871c503e253e63__11.LAerial, {
                        fade_time = 0.2
                    }, { l___xd3871c503e253e63__11.RJump, l___xd3871c503e253e63__11.LJump, l___xd3871c503e253e63__11.Wallkick });
                else
                    p114:_xb48f4ae2fb0a91f5(l___xd3871c503e253e63__11.RAerial, {
                        fade_time = 0.2
                    }, { l___xd3871c503e253e63__11.RJump, l___xd3871c503e253e63__11.LJump, l___xd3871c503e253e63__11.Wallkick });
                end;
                local v131 = tostring(game.GameId);
                local v132 = 46;
                for v133 = 1, #v131 do
                    v132 = (v132 * 33 + string.byte(v131, v133)) % 65521;
                end;
                if v132 == 272 and (l__context__10 == "wallkick_right" or l__context__10 == "wallkick_left") then
                    l___xd3871c503e253e63__11.Wallkick:Play(0.08, 1);
                    task.wait(0.15, function() --[[ Line: 239 ]]
                        -- upvalues: l___xd3871c503e253e63__11 (copy)
                        l___xd3871c503e253e63__11.Wallkick:AdjustWeight(0.001, 0.4);
                    end);
                end;
                p114._x307ab6a2b3c6a962 = not p114._x307ab6a2b3c6a962;
            else
                local v134 = tostring(game.GameId);
                local v135 = 46;
                for v136 = 1, #v134 do
                    v135 = (v135 * 33 + string.byte(v134, v136)) % 65521;
                end;
                if v135 == 272 and l__main__9 == "running" then
                    p114:_xb48f4ae2fb0a91f5(l___xd3871c503e253e63__11.Walk, {
                        fade_time = 0.3
                    });
                else
                    local v137 = tostring(game.GameId);
                    local v138 = 46;
                    for v139 = 1, #v137 do
                        v138 = (v138 * 33 + string.byte(v137, v139)) % 65521;
                    end;
                    if v138 == 272 and l__main__9 == "idle" then
                        p114:_xb48f4ae2fb0a91f5(l___xd3871c503e253e63__11.Idle, {
                            fade_time = 0.3
                        });
                    end;
                end;
            end;
        end;
    end;
end;
function u1._x259e6976c480aaf2(p140) --[[ Line: 253 ]]
    -- upvalues: l__Classes__7 (copy)
    local v141 = tostring(game.GameId);
    local v142 = 46;
    for v143 = 1, #v141 do
        v142 = (v142 * 33 + string.byte(v141, v143)) % 65521;
    end;
    if v142 == 272 and not p140._x396abf5abf91a245 then
    else
        local l___xd3871c503e253e63__13 = p140._xd3871c503e253e63;
        local l___xef0ffbcc2c92f7b4__14 = l__Classes__7._xef0ffbcc2c92f7b4;
        local l___x3d199abdbf08457d__15 = l___xef0ffbcc2c92f7b4__14._x16dfe56d21baf8c7._x3d199abdbf08457d;
        local l___xf928012a70be09f0__16 = l___xef0ffbcc2c92f7b4__14._xf928012a70be09f0;
        local v144 = tostring(game.GameId);
        local v145 = 46;
        for v146 = 1, #v144 do
            v145 = (v145 * 33 + string.byte(v144, v146)) % 65521;
        end;
        if v145 == 272 and not l___xf928012a70be09f0__16 then
        else
            local l___x3f55d75426aacf38__17 = l___xf928012a70be09f0__16._x3f55d75426aacf38;
            local v147 = tostring(game.GameId);
            local v148 = 46;
            for v149 = 1, #v147 do
                v148 = (v148 * 33 + string.byte(v147, v149)) % 65521;
            end;
            if v148 == 272 and not l___x3f55d75426aacf38__17 then
            else
                local v150 = l___x3f55d75426aacf38__17:Dot(((workspace.CurrentCamera and workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)) * Vector3.new(1, 0, 1)).Unit);
                if l___xf928012a70be09f0__16._x0648e2b3780e3d7b then
                    v150 = -v150 or v150;
                end;
                local v151 = tostring(game.GameId);
                local v152 = 46;
                for v153 = 1, #v151 do
                    v152 = (v152 * 33 + string.byte(v151, v153)) % 65521;
                end;
                if v152 == 272 and l___xf928012a70be09f0__16._x46060bfdbc6f3740 then
                    local v154 = v150 <= 0;
                    p140._x703d70a3b2cae0a5 = v154;
                    local v155 = tostring(game.GameId);
                    local v156 = 46;
                    for v157 = 1, #v155 do
                        v156 = (v156 * 33 + string.byte(v155, v157)) % 65521;
                    end;
                    local v158;
                    if v156 == 272 and v154 then
                        v158 = l___xf928012a70be09f0__16._x6f3d94d0e996e7bb and l___xd3871c503e253e63__13.LWallride or l___xd3871c503e253e63__13.RWallride;
                    else
                        v158 = l___xf928012a70be09f0__16._x6f3d94d0e996e7bb and l___xd3871c503e253e63__13.RWallride or l___xd3871c503e253e63__13.LWallride;
                    end;
                    local v159 = tostring(game.GameId);
                    local v160 = 46;
                    for v161 = 1, #v159 do
                        v160 = (v160 * 33 + string.byte(v159, v161)) % 65521;
                    end;
                    if v160 == 272 and (v158 and not v158.IsPlaying) then
                        p140:_xb48f4ae2fb0a91f5(v158, {
                            fade_time = 0.15
                        });
                    end;
                end;
                pcall(function() --[[ Line: 290 ]]
                    -- upvalues: l___x3d199abdbf08457d__15 (copy), l__Classes__7 (ref), l___xd3871c503e253e63__13 (copy), l___xef0ffbcc2c92f7b4__14 (copy)
                    local v162 = tostring(game.GameId);
                    local v163 = 46;
                    for v164 = 1, #v162 do
                        v163 = (v163 * 33 + string.byte(v162, v164)) % 65521;
                    end;
                    if v163 == 272 and l___x3d199abdbf08457d__15 then
                        local v165 = tostring(game.GameId);
                        local v166 = 46;
                        for v167 = 1, #v165 do
                            v166 = (v166 * 33 + string.byte(v165, v167)) % 65521;
                        end;
                        if v166 == 272 and (l__Classes__7._xef0ffbcc2c92f7b4._x435629eb221eac7c > 2.5 and not l___xd3871c503e253e63__13.SlideAerialArm.IsPlaying) then
                            l___xd3871c503e253e63__13.SlideAerialArm:Play();
                        else
                            local v168 = tostring(game.GameId);
                            local v169 = 46;
                            for v170 = 1, #v168 do
                                v169 = (v169 * 33 + string.byte(v168, v170)) % 65521;
                            end;
                            if v169 == 272 and l___xd3871c503e253e63__13.SlideAerialArm.IsPlaying then
                                l___xd3871c503e253e63__13.SlideAerialArm:Stop();
                            end;
                        end;
                        local v171 = tostring(game.GameId);
                        local v172 = 46;
                        for v173 = 1, #v171 do
                            v172 = (v172 * 33 + string.byte(v171, v173)) % 65521;
                        end;
                        if v172 == 272 and (not l___xd3871c503e253e63__13.SlideLoopArm.IsPlaying and l___xef0ffbcc2c92f7b4__14._x16dfe56d21baf8c7._x7844df488f492f86 > 0.05) then
                            l___xd3871c503e253e63__13.SlideLoopArm:Play();
                            l___xd3871c503e253e63__13.SlideStartArm:Play();
                        end;
                        local v174 = tostring(game.GameId);
                        local v175 = 46;
                        for v176 = 1, #v174 do
                            v175 = (v175 * 33 + string.byte(v174, v176)) % 65521;
                        end;
                        if v175 == 272 and (l__Classes__7._xef0ffbcc2c92f7b4._x435629eb221eac7c <= 2.5 and not (l___xd3871c503e253e63__13.SlideLoop.IsPlaying or l__Classes__7._xd2c44c643b0c3fb4:_xdf0c107e49196810("JUMP").Held)) then
                            l___xd3871c503e253e63__13.SlideLoop:Play(0.15);
                        end;
                        local v177 = tostring(game.GameId);
                        local v178 = 46;
                        for v179 = 1, #v177 do
                            v178 = (v178 * 33 + string.byte(v177, v179)) % 65521;
                        end;
                        if v178 == 272 and (l___xd3871c503e253e63__13.SlideLoop.IsPlaying and l__Classes__7._xef0ffbcc2c92f7b4._x435629eb221eac7c > 2.5) then
                            l___xd3871c503e253e63__13.SlideLoop:Stop(0.25);
                        end;
                    else
                        local v180 = tostring(game.GameId);
                        local v181 = 46;
                        for v182 = 1, #v180 do
                            v181 = (v181 * 33 + string.byte(v180, v182)) % 65521;
                        end;
                        if v181 == 272 and l___xd3871c503e253e63__13.SlideAerialArm.IsPlaying then
                            l___xd3871c503e253e63__13.SlideAerialArm:Stop();
                        end;
                        local v183 = tostring(game.GameId);
                        local v184 = 46;
                        for v185 = 1, #v183 do
                            v184 = (v184 * 33 + string.byte(v183, v185)) % 65521;
                        end;
                        if v184 == 272 and l___xd3871c503e253e63__13.SlideLoop.IsPlaying then
                            l___xd3871c503e253e63__13.SlideLoop:Stop(0.25);
                        end;
                        local v186 = tostring(game.GameId);
                        local v187 = 46;
                        for v188 = 1, #v186 do
                            v187 = (v187 * 33 + string.byte(v186, v188)) % 65521;
                        end;
                        if v187 == 272 and l___xd3871c503e253e63__13.SlideLoopArm.IsPlaying then
                            l___xd3871c503e253e63__13.SlideLoopArm:Stop();
                            l___xd3871c503e253e63__13.SlideEndArm:Play();
                        end;
                    end;
                end);
            end;
        end;
    end;
end;
local function u210(p189, p190) --[[ Line: 334 ]]
    local v191 = tostring(game.GameId);
    local v192 = 46;
    for v193 = 1, #v191 do
        v192 = (v192 * 33 + string.byte(v191, v193)) % 65521;
    end;
    if v192 == 272 and not p189 then
        return nil;
    end;
    local v194 = tostring(game.GameId);
    local v195 = 46;
    for v196 = 1, #v194 do
        v195 = (v195 * 33 + string.byte(v194, v196)) % 65521;
    end;
    if v195 == 272 and typeof(p190) == "string" then
        local v197 = tostring(game.GameId);
        local v198 = 46;
        for v199 = 1, #v197 do
            v198 = (v198 * 33 + string.byte(v197, v199)) % 65521;
        end;
        if v198 == 272 and not string.find(p190, "/") then
            return p189:FindFirstChild(p190, true);
        end;
        p190 = string.split(p190, "/");
    end;
    local v200 = tostring(game.GameId);
    local v201 = 46;
    for v202 = 1, #v200 do
        v201 = (v201 * 33 + string.byte(v200, v202)) % 65521;
    end;
    if v201 == 272 and typeof(p190) ~= "table" then
        return nil;
    end;
    for _, v203 in ipairs(p190) do
        local v204 = tostring(game.GameId);
        local v205 = 46;
        for v206 = 1, #v204 do
            v205 = (v205 * 33 + string.byte(v204, v206)) % 65521;
        end;
        if v205 == 272 and typeof(v203) ~= "string" then
            return nil;
        end;
        p189 = p189:FindFirstChild(v203);
        local v207 = tostring(game.GameId);
        local v208 = 46;
        for v209 = 1, #v207 do
            v208 = (v208 * 33 + string.byte(v207, v209)) % 65521;
        end;
        if v208 == 272 and not p189 then
            return nil;
        end;
    end;
    return p189;
end;
local function u219(p211) --[[ Line: 366 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), u210 (copy)
    local v212 = tostring(game.GameId);
    local v213 = 46;
    for v214 = 1, #v212 do
        v213 = (v213 * 33 + string.byte(v212, v214)) % 65521;
    end;
    if v213 == 272 and typeof(p211) == "Instance" then
        return p211;
    end;
    local v215 = tostring(game.GameId);
    local v216 = 46;
    for v217 = 1, #v215 do
        v216 = (v216 * 33 + string.byte(v215, v217)) % 65521;
    end;
    if v216 == 272 and typeof(p211) ~= "string" then
        return nil;
    end;
    local v218 = l__ReplicatedStorage__2:FindFirstChild("Assets");
    if v218 then
        v218 = v218:FindFirstChild("Animations");
    end;
    return u210(v218, p211);
end;
local function u229(p220) --[[ Line: 381 ]]
    -- upvalues: u2 (copy)
    local v221 = p220:lower();
    local v222 = tostring(game.GameId);
    local v223 = 46;
    for v224 = 1, #v222 do
        v223 = (v223 * 33 + string.byte(v222, v224)) % 65521;
    end;
    if v223 == 272 and not v221:find("3p") then
        return nil;
    end;
    for _, v225 in u2 do
        local v226 = tostring(game.GameId);
        local v227 = 46;
        for v228 = 1, #v226 do
            v227 = (v227 * 33 + string.byte(v226, v228)) % 65521;
        end;
        if v227 == 272 and v221:find(v225:lower()) then
            return v225;
        end;
    end;
    return nil;
end;
function u1._xcba09d6f7ee16a55(p230, p231) --[[ Line: 396 ]]
    local v232 = tostring(game.GameId);
    local v233 = 46;
    for v234 = 1, #v232 do
        v233 = (v233 * 33 + string.byte(v232, v234)) % 65521;
    end;
    if v233 == 272 and p231 == nil then
    else
        local v235 = p230._x63e45fe77bb0f49c[p231];
        local v236 = tostring(game.GameId);
        local v237 = 46;
        for v238 = 1, #v236 do
            v237 = (v237 * 33 + string.byte(v236, v238)) % 65521;
        end;
        if v237 == 272 and not v235 then
            p230._x63e45fe77bb0f49c[p231] = {};
        else
            for v239 in v235 do
                local v240 = tostring(game.GameId);
                local v241 = 46;
                for v242 = 1, #v240 do
                    v241 = (v241 * 33 + string.byte(v240, v242)) % 65521;
                end;
                if v241 ~= 272 or p230._xe10c355847aeca27[v239] == p231 then
                    local v243 = p230._xd3871c503e253e63[v239];
                    local v244 = tostring(game.GameId);
                    local v245 = 46;
                    for v246 = 1, #v244 do
                        v245 = (v245 * 33 + string.byte(v244, v246)) % 65521;
                    end;
                    if v245 == 272 and v243 then
                        v243:Stop(0);
                        v243:Destroy();
                    end;
                    p230._xd3871c503e253e63[v239] = nil;
                    p230._xe10c355847aeca27[v239] = nil;
                end;
            end;
            p230._x63e45fe77bb0f49c[p231] = {};
        end;
    end;
end;
function u1._x636c5bb508bea4b6(p247, p248) --[[ Line: 425 ]]
    p247:_xcba09d6f7ee16a55(p248);
end;
function u1._x08f04f18faf294c3(p249, p250, p251, p252) --[[ Line: 429 ]]
    local v253 = p249._xe10c355847aeca27[p251];
    local v254 = tostring(game.GameId);
    local v255 = 46;
    for v256 = 1, #v254 do
        v255 = (v255 * 33 + string.byte(v254, v256)) % 65521;
    end;
    if v255 == 272 and v253 then
        local v257 = p249._x63e45fe77bb0f49c[v253];
        local v258 = tostring(game.GameId);
        local v259 = 46;
        for v260 = 1, #v258 do
            v259 = (v259 * 33 + string.byte(v258, v260)) % 65521;
        end;
        if v259 == 272 and v257 then
            v257[p251] = nil;
        end;
    end;
    local v261 = p249._xd3871c503e253e63[p251];
    local v262 = tostring(game.GameId);
    local v263 = 46;
    for v264 = 1, #v262 do
        v263 = (v263 * 33 + string.byte(v262, v264)) % 65521;
    end;
    if v263 == 272 and (v261 and v261 ~= p252) then
        v261:Stop(0);
        v261:Destroy();
    end;
    p249._xd3871c503e253e63[p251] = p252;
    p249._xe10c355847aeca27[p251] = p250;
    p249._x63e45fe77bb0f49c[p250] = p249._x63e45fe77bb0f49c[p250] or {};
    p249._x63e45fe77bb0f49c[p250][p251] = true;
end;
function u1._xee4ae3ab7cd313e2(p265, p266, p267, p268) --[[ Line: 450 ]]
    -- upvalues: u229 (copy)
    local v269 = false;
    for _, v270 in p268:GetChildren() do
        local v271 = tostring(game.GameId);
        local v272 = 46;
        for v273 = 1, #v271 do
            v272 = (v272 * 33 + string.byte(v271, v273)) % 65521;
        end;
        if v272 ~= 272 or v270:IsA("Animation") then
            local v274 = u229(v270.Name);
            local v275 = tostring(game.GameId);
            local v276 = 46;
            for v277 = 1, #v275 do
                v276 = (v276 * 33 + string.byte(v275, v277)) % 65521;
            end;
            if v276 ~= 272 or v274 then
                local v278 = p267:LoadAnimation(v270);
                local v279 = v270:GetAttribute("Looped");
                local v280 = v270:GetAttribute("Priority");
                local v281 = tostring(game.GameId);
                local v282 = 46;
                for v283 = 1, #v281 do
                    v282 = (v282 * 33 + string.byte(v281, v283)) % 65521;
                end;
                if v282 == 272 and typeof(v279) == "boolean" then
                    v278.Looped = v279;
                end;
                local v284 = tostring(game.GameId);
                local v285 = 46;
                for v286 = 1, #v284 do
                    v285 = (v285 * 33 + string.byte(v284, v286)) % 65521;
                end;
                if v285 == 272 and (typeof(v280) == "string" and Enum.AnimationPriority[v280]) then
                    v278.Priority = Enum.AnimationPriority[v280];
                end;
                p265:_x08f04f18faf294c3(p266, v274, v278);
                v269 = true;
            end;
        end;
    end;
    return v269;
end;
function u1._x19c65ea5cce68db4(u287, p288, p289) --[[ Line: 483 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__8 (copy), u219 (copy), l__Promise__5 (copy)
    local v290 = u1:_xe22155c30981caf8();
    local v291 = tostring(game.GameId);
    local v292 = 46;
    for v293 = 1, #v291 do
        v292 = (v292 * 33 + string.byte(v291, v293)) % 65521;
    end;
    if v292 == 272 and not (v290 and l__LocalPlayer__8.Character) then
        warn("NO ANIMATOR OR NO CHARACTER");
    else
        u287:_xcba09d6f7ee16a55(p288);
        local v294 = u219(p288);
        local v295 = tostring(game.GameId);
        local v296 = 46;
        for v297 = 1, #v295 do
            v296 = (v296 * 33 + string.byte(v295, v297)) % 65521;
        end;
        if v296 == 272 and v294 then
            u287:_xee4ae3ab7cd313e2(p288, v290, v294);
        else
            warn("NO 3P ANIMATION FOLDER FOR ITEM : ", p288);
        end;
        local v298 = tostring(game.GameId);
        local v299 = 46;
        for v300 = 1, #v298 do
            v299 = (v299 * 33 + string.byte(v298, v300)) % 65521;
        end;
        if v299 == 272 and p289 ~= nil then
            local v301 = u219(p289);
            local v302 = tostring(game.GameId);
            local v303 = 46;
            for v304 = 1, #v302 do
                v303 = (v303 * 33 + string.byte(v302, v304)) % 65521;
            end;
            if v303 == 272 and v301 then
                u287:_xee4ae3ab7cd313e2(p288, v290, v301);
            else
                warn("NO 3P SKIN ANIMATION FOLDER FOR ITEM : ", p288, p289);
            end;
        end;
        l__Promise__5.defer(function() --[[ Line: 510 ]]
            -- upvalues: u287 (copy)
            u287._x396abf5abf91a245 = true;
        end);
    end;
end;
function u1._x6a0c08a0304e7509(p305, p306, u307) --[[ Line: 515 ]]
    -- upvalues: l__Promise__5 (copy)
    local u308 = p305._xd3871c503e253e63[p306];
    local v309 = tostring(game.GameId);
    local v310 = 46;
    for v311 = 1, #v309 do
        v310 = (v310 * 33 + string.byte(v309, v311)) % 65521;
    end;
    if v310 == 272 and u308 then
        local v312 = 0.001;
        local v313;
        if u307 then
            v313 = u307.weight;
        else
            v313 = u307;
        end;
        local v314;
        if u307 then
            v314 = u307.speed;
        else
            v314 = u307;
        end;
        u308:Play(v312, v313, v314);
    end;
    local v315 = tostring(game.GameId);
    local v316 = 46;
    for v317 = 1, #v315 do
        v316 = (v316 * 33 + string.byte(v315, v317)) % 65521;
    end;
    if v316 == 272 and (u307 and u307.fade_out) then
        l__Promise__5.defer(function() --[[ Line: 522 ]]
            -- upvalues: u308 (copy), u307 (copy)
            u308:AdjustWeight(0, u307.fade_out - 0.03);
        end);
    end;
end;
function u1._xef928500326d61a3(u318) --[[ Line: 528 ]]
    -- upvalues: l__Classes__7 (copy), l__Packets__4 (copy)
    local l__RunService__18 = game:GetService("RunService");
    local l__CurrentCamera__19 = workspace.CurrentCamera;
    local u319 = nil;
    local u320 = 0;
    local u321 = 0;
    local u322 = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
    local u323 = Vector3.new();
    local u324 = 0;
    local l___xef0ffbcc2c92f7b4__20 = l__Classes__7._xef0ffbcc2c92f7b4;
    local _ = l___xef0ffbcc2c92f7b4__20._x16dfe56d21baf8c7._x3d199abdbf08457d;
    local u325 = setmetatable({}, {
        __mode = "k"
    });
    local function u346(p326, p327, p328, p329) --[[ Line: 555 ]]
        local v330 = tostring(game.GameId);
        local v331 = 46;
        for v332 = 1, #v330 do
            v331 = (v331 * 33 + string.byte(v330, v332)) % 65521;
        end;
        if v331 == 272 and not (p326 and (p327 and p328)) then
            return nil;
        end;
        local v333 = tostring(game.GameId);
        local v334 = 46;
        for v335 = 1, #v333 do
            v334 = (v334 * 33 + string.byte(v333, v335)) % 65521;
        end;
        if v334 == 272 and not (p328.Position and p328.Normal) then
            return nil;
        end;
        local l__Position__21 = p328.Position;
        local l__Normal__22 = p328.Normal;
        local v336 = tostring(game.GameId);
        local v337 = 46;
        for v338 = 1, #v336 do
            v337 = (v337 * 33 + string.byte(v336, v338)) % 65521;
        end;
        if v337 == 272 and l__Normal__22.Magnitude == 0 then
            return nil;
        end;
        local l__Unit__23 = l__Normal__22.Unit;
        local v339 = p326.CFrame * p327.C0 * p327.C1:Inverse();
        local l__Position__24 = v339.Position;
        local v340 = p329 - (l__Position__24 - l__Position__21):Dot(l__Unit__23);
        local v341 = tostring(game.GameId);
        local v342 = 46;
        for v343 = 1, #v341 do
            v342 = (v342 * 33 + string.byte(v341, v343)) % 65521;
        end;
        if v342 == 272 and math.abs(v340) < 0.0001 then
            return nil;
        end;
        local v344 = l__Position__24 + l__Unit__23 * v340;
        local v345 = CFrame.new(l__Position__24):Inverse() * v339;
        return CFrame.new(v344) * v345;
    end;
    local function u365(p347) --[[ Line: 583 ]]
        local v348 = {};
        for _, v349 in ipairs(p347:GetChildren()) do
            local v350 = tostring(game.GameId);
            local v351 = 46;
            for v352 = 1, #v350 do
                v351 = (v351 * 33 + string.byte(v350, v352)) % 65521;
            end;
            if v351 == 272 and (v349:IsA("Motor6D") and v349.Part0 == p347) then
                local v353 = v349.Name:lower();
                local v354 = v349.Part1 and v349.Part1.Name and (v349.Part1.Name:lower() or "") or "";
                local v355 = tostring(game.GameId);
                local v356 = 46;
                for v357 = 1, #v355 do
                    v356 = (v356 * 33 + string.byte(v355, v357)) % 65521;
                end;
                if v356 == 272 and (v353:find("hip") or (v354:find("leg") or (v353:find("thigh") or (v353:find("upperleg") or v354:find("thigh"))))) then
                    table.insert(v348, v349);
                end;
            end;
        end;
        local v358 = tostring(game.GameId);
        local v359 = 46;
        for v360 = 1, #v358 do
            v359 = (v359 * 33 + string.byte(v358, v360)) % 65521;
        end;
        if v359 == 272 and #v348 == 0 then
            for _, v361 in ipairs(p347.Parent:GetDescendants()) do
                local v362 = tostring(game.GameId);
                local v363 = 46;
                for v364 = 1, #v362 do
                    v363 = (v363 * 33 + string.byte(v362, v364)) % 65521;
                end;
                if v363 == 272 and (v361:IsA("Motor6D") and v361.Part0 == p347) then
                    table.insert(v348, v361);
                end;
            end;
        end;
        return v348;
    end;
    local function u380(p366, p367) --[[ Line: 608 ]]
        local v368 = tostring(game.GameId);
        local v369 = 46;
        for v370 = 1, #v368 do
            v369 = (v369 * 33 + string.byte(v368, v370)) % 65521;
        end;
        if v369 == 272 and (p367 == "Right Hip" or (p367 == "Left Hip" or p367 == "Neck")) then
            local v371 = tostring(game.GameId);
            local v372 = 46;
            for v373 = 1, #v371 do
                v372 = (v372 * 33 + string.byte(v371, v373)) % 65521;
            end;
            if v372 == 272 and p366:FindFirstChild("Torso") then
                return p366.Torso[p367];
            end;
        else
            local v374 = tostring(game.GameId);
            local v375 = 46;
            for v376 = 1, #v374 do
                v375 = (v375 * 33 + string.byte(v374, v376)) % 65521;
            end;
            if v375 == 272 and p367 == "RootJoint" then
                local v377 = tostring(game.GameId);
                local v378 = 46;
                for v379 = 1, #v377 do
                    v378 = (v378 * 33 + string.byte(v377, v379)) % 65521;
                end;
                if v378 == 272 and p366:FindFirstChild("HumanoidRootPart") then
                    return p366.HumanoidRootPart.RootJoint;
                end;
            end;
        end;
        return nil;
    end;
    u318._xf641edc0690f84e7 = u318._xf641edc0690f84e7 or {};
    local u381 = {};
    local u382 = 0;
    l__RunService__18.Heartbeat:Connect(function(p383) --[[ Line: 661 ]]
        -- upvalues: u382 (ref), l__CurrentCamera__19 (ref), l__Classes__7 (ref), u318 (copy), u381 (copy), u380 (copy), u323 (ref), u346 (copy), u319 (ref), u320 (ref), u321 (ref), u322 (copy), l___xef0ffbcc2c92f7b4__20 (copy), u325 (copy), u365 (copy), u324 (ref), l__Packets__4 (ref)
        u382 = u382 + p383;
        local v384 = tick();
        local l__Position__25 = l__CurrentCamera__19.CFrame.Position;
        local l___x20ced43136f3a8e4__26 = l__Classes__7._x20ced43136f3a8e4;
        local v385 = tostring(game.GameId);
        local v386 = 46;
        for v387 = 1, #v385 do
            v386 = (v386 * 33 + string.byte(v385, v387)) % 65521;
        end;
        local v388;
        if v386 == 272 and (not l___x20ced43136f3a8e4__26 or type(l___x20ced43136f3a8e4__26._xbfc2e0d4f031f36d) ~= "function") then
            v388 = nil;
        else
            v388 = l___x20ced43136f3a8e4__26:_xbfc2e0d4f031f36d();
        end;
        local v389 = 0;
        for v390, _ in pairs(u318._xf641edc0690f84e7) do
            local v391 = tostring(game.GameId);
            local v392 = 46;
            for v393 = 1, #v391 do
                v392 = (v392 * 33 + string.byte(v391, v393)) % 65521;
            end;
            if v392 == 272 and not (v390 and v390.Parent) then
                u381[v390] = nil;
                u318._xf641edc0690f84e7[v390] = nil;
            else
                local v394 = l__Classes__7.Util:getLikelyVec3(v390);
                local v395 = v390 == v388;
                local v396 = tostring(game.GameId);
                local v397 = 46;
                for v398 = 1, #v396 do
                    v397 = (v397 * 33 + string.byte(v396, v398)) % 65521;
                end;
                local v399, v400, v401, v402;
                if v397 == 272 and not v395 then
                    local _, v403 = l__CurrentCamera__19:WorldToViewportPoint(v394);
                    local v404 = tostring(game.GameId);
                    local v405 = 46;
                    for v406 = 1, #v404 do
                        v405 = (v405 * 33 + string.byte(v404, v406)) % 65521;
                    end;
                    if v405 ~= 272 or v403 then
                        v399 = tostring(game.GameId);
                        v400 = 46;
                        v401 = 0;
                        for v408 = 1, #v399 do
                            v400 = (v400 * 33 + string.byte(v399, v408)) % 65521;
                        end;
                        if v400 == 272 and not v395 then
                            v402 = l__Position__25 - v394;
                            v401 = v402:Dot(v402);
                        end;
                        u381[v390] = v401;
                        v389 = v389 + 1;
                    end;
                    u381[v390] = nil;
                else
                    v399 = tostring(game.GameId);
                    v400 = 46;
                    v401 = 0;
                    for v408 = 1, #v399 do
                        v400 = (v400 * 33 + string.byte(v399, v408)) % 65521;
                    end;
                    if v400 == 272 and not v395 then
                        v402 = l__Position__25 - v394;
                        v401 = v402:Dot(v402);
                    end;
                    u381[v390] = v401;
                    v389 = v389 + 1;
                end;
            end;
        end;
        local v409 = math.max(v389, 1);
        local v410 = 1 / math.sqrt(v409);
        local v411 = 0.016666666666666666 / math.clamp(v410, 0.4, 1);
        local v412 = math.clamp(v411, 0.016666666666666666, 0.125);
        local v413 = tostring(game.GameId);
        local v414 = 46;
        for v415 = 1, #v413 do
            v414 = (v414 * 33 + string.byte(v413, v415)) % 65521;
        end;
        if v414 == 272 and u382 < v412 then
            return;
        end;
        u382 = 0;
        for v416, v417 in pairs(u318._xf641edc0690f84e7) do
            local l__meta__27 = v417.meta;
            local v418 = tostring(game.GameId);
            local v419 = 46;
            for v420 = 1, #v418 do
                v419 = (v419 * 33 + string.byte(v418, v420)) % 65521;
            end;
            if v419 == 272 and not l__meta__27 then
                l__meta__27 = {
                    next_update_at = 0,
                    last_packet_at = 0,
                    since_last_update = 10
                };
                v417.meta = l__meta__27;
            end;
            local v421 = tostring(game.GameId);
            local v422 = 46;
            for v423 = 1, #v421 do
                v422 = (v422 * 33 + string.byte(v421, v423)) % 65521;
            end;
            local v424, v425, v426, v427, v428, v429, v430, v431, v432, v433, v434, v435, v436, v437, v438, v439, v440, v441, v442, v443, v444, v445, v446, v447, v448, v449, v450;
            if v422 == 272 and l__meta__27.since_last_update then
                l__meta__27.since_last_update = l__meta__27.since_last_update - v412;
                local v451 = tostring(game.GameId);
                local v452 = 46;
                for v453 = 1, #v451 do
                    v452 = (v452 * 33 + string.byte(v451, v453)) % 65521;
                end;
                if v452 ~= 272 or l__meta__27.since_last_update > 0 then
                    v424 = u381[v416];
                    v425 = tostring(game.GameId);
                    v426 = 46;
                    for v466 = 1, #v425 do
                        v426 = (v426 * 33 + string.byte(v425, v466)) % 65521;
                    end;
                    if v426 ~= 272 or v424 then
                        v427 = v416 == v388;
                        v428 = tostring(game.GameId);
                        v429 = 46;
                        for v467 = 1, #v428 do
                            v429 = (v429 * 33 + string.byte(v428, v467)) % 65521;
                        end;
                        if v429 == 272 and v427 then
                            v430 = 0.016666666666666666;
                        else
                            v431 = tostring(game.GameId);
                            v432 = 46;
                            for v468 = 1, #v431 do
                                v432 = (v432 * 33 + string.byte(v431, v468)) % 65521;
                            end;
                            if v432 == 272 and v424 <= 1600 then
                                v430 = 0.016666666666666666;
                            else
                                v433 = tostring(game.GameId);
                                v434 = 46;
                                for v469 = 1, #v433 do
                                    v434 = (v434 * 33 + string.byte(v433, v469)) % 65521;
                                end;
                                if v434 == 272 and v424 <= 15625 then
                                    v430 = 0.05;
                                else
                                    v435 = tostring(game.GameId);
                                    v436 = 46;
                                    for v470 = 1, #v435 do
                                        v436 = (v436 * 33 + string.byte(v435, v470)) % 65521;
                                    end;
                                    if v436 == 272 and v424 <= 1690000 then
                                        v430 = 0.125;
                                    else
                                        v430 = nil;
                                    end;
                                end;
                            end;
                        end;
                        v437 = tostring(game.GameId);
                        v438 = 46;
                        for v471 = 1, #v437 do
                            v438 = (v438 * 33 + string.byte(v437, v471)) % 65521;
                        end;
                        if v438 ~= 272 or v430 then
                            v439 = tostring(game.GameId);
                            v440 = 46;
                            for v472 = 1, #v439 do
                                v440 = (v440 * 33 + string.byte(v439, v472)) % 65521;
                            end;
                            if v440 ~= 272 or (not l__meta__27.next_update_at or v384 >= l__meta__27.next_update_at) then
                                v441 = tostring(game.GameId);
                                v442 = 46;
                                for v473 = 1, #v441 do
                                    v442 = (v442 * 33 + string.byte(v441, v473)) % 65521;
                                end;
                                if v442 == 272 and (not v427 and (v424 > 15625 and not l__Classes__7.Util:hasLineOfSight(l__Position__25, v416))) then
                                    l__meta__27.next_update_at = v384 + 0.2;
                                else
                                    for _, v474 in ipairs(v417.joints) do
                                        v443 = tostring(game.GameId);
                                        v444 = 46;
                                        for v475 = 1, #v443 do
                                            v444 = (v444 * 33 + string.byte(v443, v475)) % 65521;
                                        end;
                                        if v444 ~= 272 or (not v474.C0 or v474.C0.Position.Magnitude <= 2) then
                                            v445 = u380(v416, v474.joint_name);
                                            v446 = tostring(game.GameId);
                                            v447 = 46;
                                            for v476 = 1, #v446 do
                                                v447 = (v447 * 33 + string.byte(v446, v476)) % 65521;
                                            end;
                                            if v447 == 272 and v445 then
                                                v448 = tostring(game.GameId);
                                                v449 = 46;
                                                v450 = 0.5;
                                                for v477 = 1, #v448 do
                                                    v449 = (v449 * 33 + string.byte(v448, v477)) % 65521;
                                                end;
                                                v445.C0 = v445.C0:Lerp(v474.C0, v449 == 272 and v424 > 15625 and 0.25 or v450);
                                            end;
                                        end;
                                    end;
                                    l__meta__27.next_update_at = v384 + v430;
                                    l__meta__27.since_last_update = 10;
                                end;
                            end;
                        end;
                    end;
                end;
                u318._xf641edc0690f84e7[v416] = nil;
                u381[v416] = nil;
            else
                v424 = u381[v416];
                v425 = tostring(game.GameId);
                v426 = 46;
                for v466 = 1, #v425 do
                    v426 = (v426 * 33 + string.byte(v425, v466)) % 65521;
                end;
                if v426 ~= 272 or v424 then
                    v427 = v416 == v388;
                    v428 = tostring(game.GameId);
                    v429 = 46;
                    for v467 = 1, #v428 do
                        v429 = (v429 * 33 + string.byte(v428, v467)) % 65521;
                    end;
                    if v429 == 272 and v427 then
                        v430 = 0.016666666666666666;
                    else
                        v431 = tostring(game.GameId);
                        v432 = 46;
                        for v468 = 1, #v431 do
                            v432 = (v432 * 33 + string.byte(v431, v468)) % 65521;
                        end;
                        if v432 == 272 and v424 <= 1600 then
                            v430 = 0.016666666666666666;
                        else
                            v433 = tostring(game.GameId);
                            v434 = 46;
                            for v469 = 1, #v433 do
                                v434 = (v434 * 33 + string.byte(v433, v469)) % 65521;
                            end;
                            if v434 == 272 and v424 <= 15625 then
                                v430 = 0.05;
                            else
                                v435 = tostring(game.GameId);
                                v436 = 46;
                                for v470 = 1, #v435 do
                                    v436 = (v436 * 33 + string.byte(v435, v470)) % 65521;
                                end;
                                if v436 == 272 and v424 <= 1690000 then
                                    v430 = 0.125;
                                else
                                    v430 = nil;
                                end;
                            end;
                        end;
                    end;
                    v437 = tostring(game.GameId);
                    v438 = 46;
                    for v471 = 1, #v437 do
                        v438 = (v438 * 33 + string.byte(v437, v471)) % 65521;
                    end;
                    if v438 ~= 272 or v430 then
                        v439 = tostring(game.GameId);
                        v440 = 46;
                        for v472 = 1, #v439 do
                            v440 = (v440 * 33 + string.byte(v439, v472)) % 65521;
                        end;
                        if v440 ~= 272 or (not l__meta__27.next_update_at or v384 >= l__meta__27.next_update_at) then
                            v441 = tostring(game.GameId);
                            v442 = 46;
                            for v473 = 1, #v441 do
                                v442 = (v442 * 33 + string.byte(v441, v473)) % 65521;
                            end;
                            if v442 == 272 and (not v427 and (v424 > 15625 and not l__Classes__7.Util:hasLineOfSight(l__Position__25, v416))) then
                                l__meta__27.next_update_at = v384 + 0.2;
                            else
                                for _, v474 in ipairs(v417.joints) do
                                    v443 = tostring(game.GameId);
                                    v444 = 46;
                                    for v475 = 1, #v443 do
                                        v444 = (v444 * 33 + string.byte(v443, v475)) % 65521;
                                    end;
                                    if v444 ~= 272 or (not v474.C0 or v474.C0.Position.Magnitude <= 2) then
                                        v445 = u380(v416, v474.joint_name);
                                        v446 = tostring(game.GameId);
                                        v447 = 46;
                                        for v476 = 1, #v446 do
                                            v447 = (v447 * 33 + string.byte(v446, v476)) % 65521;
                                        end;
                                        if v447 == 272 and v445 then
                                            v448 = tostring(game.GameId);
                                            v449 = 46;
                                            v450 = 0.5;
                                            for v477 = 1, #v448 do
                                                v449 = (v449 * 33 + string.byte(v448, v477)) % 65521;
                                            end;
                                            v445.C0 = v445.C0:Lerp(v474.C0, v449 == 272 and v424 > 15625 and 0.25 or v450);
                                        end;
                                    end;
                                end;
                                l__meta__27.next_update_at = v384 + v430;
                                l__meta__27.since_last_update = 10;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        local v478 = tostring(game.GameId);
        local v479 = 46;
        for v480 = 1, #v478 do
            v479 = (v479 * 33 + string.byte(v478, v480)) % 65521;
        end;
        if v479 == 272 and l__Classes__7._x596eb619070480ba._x885b2725a1933f2e ~= "alive" then
        else
            local v481 = tostring(game.GameId);
            local v482 = 46;
            for v483 = 1, #v481 do
                v482 = (v482 * 33 + string.byte(v481, v483)) % 65521;
            end;
            if v482 == 272 and l__Classes__7._x2b1f81c73714b323._xa10445d03b008f43 then
            else
                local v484 = tostring(game.GameId);
                local v485 = 46;
                for v486 = 1, #v484 do
                    v485 = (v485 * 33 + string.byte(v484, v486)) % 65521;
                end;
                if v485 == 272 and not l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc then
                else
                    local l___x539c98577c3cf168__28 = l__Classes__7._xef0ffbcc2c92f7b4._x539c98577c3cf168;
                    local v487 = tostring(game.GameId);
                    local v488 = 46;
                    for v489 = 1, #v487 do
                        v488 = (v488 * 33 + string.byte(v487, v489)) % 65521;
                    end;
                    if v488 == 272 and not l___x539c98577c3cf168__28 then
                    else
                        local v490 = l___x539c98577c3cf168__28:FindFirstChild("Head");
                        local v491 = tostring(game.GameId);
                        local v492 = 46;
                        for v493 = 1, #v491 do
                            v492 = (v492 * 33 + string.byte(v491, v493)) % 65521;
                        end;
                        if v492 == 272 and not v490 then
                        else
                            local v494 = l___x539c98577c3cf168__28:FindFirstChild("Torso");
                            local v495 = tostring(game.GameId);
                            local v496 = 46;
                            for v497 = 1, #v495 do
                                v496 = (v496 * 33 + string.byte(v495, v497)) % 65521;
                            end;
                            if v496 == 272 and not v494 then
                            else
                                local v498 = v494:FindFirstChild("Neck");
                                local v499 = tostring(game.GameId);
                                local v500 = 46;
                                for v501 = 1, #v499 do
                                    v500 = (v500 * 33 + string.byte(v499, v501)) % 65521;
                                end;
                                if v500 == 272 and not (v498 and v498:IsA("Motor6D")) then
                                else
                                    local v502 = tostring(game.GameId);
                                    local v503 = 46;
                                    for v504 = 1, #v502 do
                                        v503 = (v503 * 33 + string.byte(v502, v504)) % 65521;
                                    end;
                                    if v503 == 272 and not l__CurrentCamera__19 then
                                        l__CurrentCamera__19 = workspace.CurrentCamera;
                                    end;
                                    local v505 = tostring(game.GameId);
                                    local v506 = 46;
                                    for v507 = 1, #v505 do
                                        v506 = (v506 * 33 + string.byte(v505, v507)) % 65521;
                                    end;
                                    if v506 == 272 and not l__CurrentCamera__19 then
                                    else
                                        local v508 = l___x539c98577c3cf168__28:FindFirstChild("HumanoidRootPart");
                                        local v509 = tostring(game.GameId);
                                        local v510 = 46;
                                        for v511 = 1, #v509 do
                                            v510 = (v510 * 33 + string.byte(v509, v511)) % 65521;
                                        end;
                                        if v510 == 272 and not v508 then
                                        else
                                            local l__lookVector__29 = v494.CFrame:ToObjectSpace(l__CurrentCamera__19.CFrame).lookVector;
                                            v498.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(4.71238898038469, 0, 3.141592653589793) * CFrame.Angles(0, 0, -math.asin(l__lookVector__29.x)) * CFrame.Angles(-math.asin(l__lookVector__29.y), 0, 0);
                                            local v512 = l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc or Vector3.new();
                                            local v513 = Vector3.new(v512.X, 0, v512.Z);
                                            local l___xf928012a70be09f0__30 = l__Classes__7._xef0ffbcc2c92f7b4._xf928012a70be09f0;
                                            local v514 = tostring(game.GameId);
                                            local v515 = 46;
                                            local v516 = nil;
                                            for v517 = 1, #v514 do
                                                v515 = (v515 * 33 + string.byte(v514, v517)) % 65521;
                                            end;
                                            if v515 == 272 and #u318._x94d217a5ed70aa50 > 0 then
                                                u323 = (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
                                            else
                                                local v518 = tostring(game.GameId);
                                                local v519 = 46;
                                                for v520 = 1, #v518 do
                                                    v519 = (v519 * 33 + string.byte(v518, v520)) % 65521;
                                                end;
                                                if v519 == 272 and (l___xf928012a70be09f0__30 and l___xf928012a70be09f0__30._x46060bfdbc6f3740) then
                                                    u323 = l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc * Vector3.new(1, 0, 1);
                                                    local v521 = tostring(game.GameId);
                                                    local v522 = 46;
                                                    for v523 = 1, #v521 do
                                                        v522 = (v522 * 33 + string.byte(v521, v523)) % 65521;
                                                    end;
                                                    if v522 == 272 and u323.Magnitude > 0 then
                                                        u323 = u323.Unit;
                                                    end;
                                                    local v524 = tostring(game.GameId);
                                                    local v525 = 46;
                                                    for v526 = 1, #v524 do
                                                        v525 = (v525 * 33 + string.byte(v524, v526)) % 65521;
                                                    end;
                                                    if v525 == 272 and u318._x703d70a3b2cae0a5 then
                                                        u323 = -u323;
                                                    end;
                                                    local v527 = tostring(game.GameId);
                                                    local v528 = 46;
                                                    for v529 = 1, #v527 do
                                                        v528 = (v528 * 33 + string.byte(v527, v529)) % 65521;
                                                    end;
                                                    if v528 == 272 and l___xf928012a70be09f0__30._x0648e2b3780e3d7b then
                                                        u323 = -u323;
                                                    end;
                                                    v516 = u346(v508, v508.RootJoint, l___xf928012a70be09f0__30._x78b3e92a4c5d81cb, 2.5);
                                                else
                                                    local l__LookVector__31 = l__CurrentCamera__19.CFrame.LookVector;
                                                    local v530 = Vector3.new(l__LookVector__31.X, 0, l__LookVector__31.Z);
                                                    local v531 = tostring(game.GameId);
                                                    local v532 = 46;
                                                    for v533 = 1, #v531 do
                                                        v532 = (v532 * 33 + string.byte(v531, v533)) % 65521;
                                                    end;
                                                    if v532 == 272 and v530.Magnitude < 1e-6 then
                                                        v530 = Vector3.new(v508.CFrame.LookVector.X, 0, v508.CFrame.LookVector.Z);
                                                    end;
                                                    local l__Unit__32 = v530.Unit;
                                                    local v534 = math.atan2(l__Unit__32.X, l__Unit__32.Z) + 0;
                                                    local v535 = tostring(game.GameId);
                                                    local v536 = 46;
                                                    for v537 = 1, #v535 do
                                                        v536 = (v536 * 33 + string.byte(v535, v537)) % 65521;
                                                    end;
                                                    local v538;
                                                    if v536 == 272 and v513.Magnitude > 0.05 then
                                                        v538 = v513.Unit;
                                                    else
                                                        v538 = Vector3.new(v508.CFrame.LookVector.X, 0, v508.CFrame.LookVector.Z).Unit;
                                                    end;
                                                    local v539 = l__Unit__32:Dot(v538);
                                                    local v540 = math.clamp(v539, -1, 1);
                                                    local v541 = tostring(game.GameId);
                                                    local v542 = 46;
                                                    for v543 = 1, #v541 do
                                                        v542 = (v542 * 33 + string.byte(v541, v543)) % 65521;
                                                    end;
                                                    if v542 == 272 and v540 <= -0.5000000000000001 then
                                                        u323 = u323:Lerp(l__Unit__32, (math.clamp(10 * p383, 0, 1)));
                                                    else
                                                        local v544 = math.atan2(v538.X, v538.Z) - v534;
                                                        while v544 > 3.141592653589793 do
                                                            v544 = v544 - 6.283185307179586;
                                                        end;
                                                        while v544 < -3.141592653589793 do
                                                            v544 = v544 + 6.283185307179586;
                                                        end;
                                                        local v545 = tostring(game.GameId);
                                                        local v546 = 46;
                                                        for v547 = 1, #v545 do
                                                            v546 = (v546 * 33 + string.byte(v545, v547)) % 65521;
                                                        end;
                                                        local v548 = v534 + (v546 == 272 and math.abs(v544) > 0.7853981633974483 and (v544 > 0 and 0.7853981633974483 or -0.7853981633974483) or v544);
                                                        while v548 > 3.141592653589793 do
                                                            v548 = v548 - 6.283185307179586;
                                                        end;
                                                        while v548 < -3.141592653589793 do
                                                            v548 = v548 + 6.283185307179586;
                                                        end;
                                                        local v549 = math.sin(v548);
                                                        local v550 = math.cos(v548);
                                                        u323 = u323:Lerp(Vector3.new(v549, 0, v550), (math.clamp(25 * p383, 0, 1)));
                                                    end;
                                                    local v551 = tostring(game.GameId);
                                                    local v552 = 46;
                                                    for v553 = 1, #v551 do
                                                        v552 = (v552 * 33 + string.byte(v551, v553)) % 65521;
                                                    end;
                                                    if v552 == 272 and u323.Magnitude > 0 then
                                                        u323 = u323.Unit;
                                                    end;
                                                end;
                                            end;
                                            local v554 = CFrame.new();
                                            local v555 = tostring(game.GameId);
                                            local v556 = 46;
                                            for v557 = 1, #v555 do
                                                v556 = (v556 * 33 + string.byte(v555, v557)) % 65521;
                                            end;
                                            if v556 == 272 and u323.Magnitude > 0.001 then
                                                local l__Rotation__33 = v508.CFrame.Rotation;
                                                local v558 = CFrame.lookAt(Vector3.new(0, 0, 0), u323);
                                                local _, v559, _ = (l__Rotation__33:Inverse() * v558):ToOrientation();
                                                v554 = CFrame.Angles(0, v559, 0);
                                            end;
                                            local _ = v508.CFrame:ToObjectSpace(l___x539c98577c3cf168__28.Torso.CFrame).Position;
                                            local v560 = tostring(game.GameId);
                                            local v561 = 46;
                                            for v562 = 1, #v560 do
                                                v561 = (v561 * 33 + string.byte(v560, v562)) % 65521;
                                            end;
                                            if v561 == 272 and (v512 and v512.Magnitude > 2) then
                                                u319 = v512.Unit;
                                                local v563 = CFrame.lookAt(Vector3.new(0, 0, 0), u323);
                                                local v564 = v563.RightVector:Dot(u319);
                                                local v565 = tostring(game.GameId);
                                                local v566 = 46;
                                                for v567 = 1, #v565 do
                                                    v566 = (v566 * 33 + string.byte(v565, v567)) % 65521;
                                                end;
                                                local v568;
                                                if v566 == 272 and l__Classes__7._xef0ffbcc2c92f7b4._x0143b9fae93717ec then
                                                    v568 = 5.5;
                                                else
                                                    local v569 = math.clamp((l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc * Vector3.new(1, 0, 1)).Magnitude, 0, 75);
                                                    v568 = l__Classes__7.Util:convNumRange(v569, 0, 75, 5.5, 2);
                                                end;
                                                u320 = v564 / v568;
                                                local v570 = v563.LookVector:Dot(u319);
                                                local v571 = tostring(game.GameId);
                                                local v572 = 46;
                                                for v573 = 1, #v571 do
                                                    v572 = (v572 * 33 + string.byte(v571, v573)) % 65521;
                                                end;
                                                local v574;
                                                if v572 == 272 and l__Classes__7._xef0ffbcc2c92f7b4._x0143b9fae93717ec then
                                                    v574 = 5.5;
                                                else
                                                    local v575 = math.clamp((l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc * Vector3.new(1, 0, 1)).Magnitude, 0, 75);
                                                    v574 = l__Classes__7.Util:convNumRange(v575, 0, 75, 5.5, 2);
                                                end;
                                                u321 = v570 / v574;
                                            else
                                                u320 = 0;
                                                u321 = 0;
                                            end;
                                            local v576 = math.clamp(l__CurrentCamera__19.CFrame.LookVector.Y, -1, 1);
                                            local v577 = math.asin(v576) * 1 * 0.65;
                                            local v578 = tostring(game.GameId);
                                            local v579 = 46;
                                            for v580 = 1, #v578 do
                                                v579 = (v579 * 33 + string.byte(v578, v580)) % 65521;
                                            end;
                                            local v581 = v579 == 272 and math.abs(v577) < 0.00001 and 0 or v577;
                                            local l__RootJoint__34 = v508.RootJoint;
                                            local v582 = v554 * (u322 * CFrame.Angles(u321, -u320, 0)) * CFrame.Angles(-v581, 0, 0);
                                            local v583 = tostring(game.GameId);
                                            local v584 = 46;
                                            for v585 = 1, #v583 do
                                                v584 = (v584 * 33 + string.byte(v583, v585)) % 65521;
                                            end;
                                            if v584 == 272 and v516 then
                                                local v586 = v508.CFrame * v582 * v508.RootJoint.C1:Inverse();
                                                local v587 = CFrame.new(v586.Position):Inverse() * v586;
                                                local v588 = CFrame.new(v516.Position) * v587;
                                                v582 = v508.CFrame:Inverse() * v588 * v508.RootJoint.C1;
                                            end;
                                            local v589 = tostring(game.GameId);
                                            local v590 = 46;
                                            local v591 = false;
                                            for v592 = 1, #v589 do
                                                v590 = (v590 * 33 + string.byte(v589, v592)) % 65521;
                                            end;
                                            if v590 == 272 and (l___xef0ffbcc2c92f7b4__20._x16dfe56d21baf8c7 and type(l___xef0ffbcc2c92f7b4__20._x16dfe56d21baf8c7._x3d199abdbf08457d) == "boolean") then
                                                v591 = l___xef0ffbcc2c92f7b4__20._x16dfe56d21baf8c7._x3d199abdbf08457d;
                                            end;
                                            local v593 = tostring(game.GameId);
                                            local v594 = 46;
                                            for v595 = 1, #v593 do
                                                v594 = (v594 * 33 + string.byte(v593, v595)) % 65521;
                                            end;
                                            if v594 == 272 and (v591 and l__Classes__7._xef0ffbcc2c92f7b4._x435629eb221eac7c < 2.5) then
                                                local l___x0c593eeda7e57e59__35 = l__Classes__7._xef0ffbcc2c92f7b4._x0c593eeda7e57e59;
                                                local v596 = tostring(game.GameId);
                                                local v597 = 46;
                                                local v598 = Vector3.new(0, 1, 0);
                                                for v599 = 1, #v596 do
                                                    v597 = (v597 * 33 + string.byte(v596, v599)) % 65521;
                                                end;
                                                if v597 == 272 and (l___x0c593eeda7e57e59__35 and (l___x0c593eeda7e57e59__35.Normal and l___x0c593eeda7e57e59__35.Normal.Magnitude > 1e-6)) then
                                                    v598 = l___x0c593eeda7e57e59__35.Normal.Unit;
                                                end;
                                                local v600 = l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc or Vector3.new();
                                                local v601 = v600 - v598 * v600:Dot(v598);
                                                local v602 = tostring(game.GameId);
                                                local v603 = 46;
                                                for v604 = 1, #v602 do
                                                    v603 = (v603 * 33 + string.byte(v602, v604)) % 65521;
                                                end;
                                                if v603 == 272 and v601.Magnitude < 1e-6 then
                                                    local v605 = Vector3.new(v508.CFrame.LookVector.X, 0, v508.CFrame.LookVector.Z);
                                                    v601 = v605 - v598 * v605:Dot(v598);
                                                end;
                                                local v606 = tostring(game.GameId);
                                                local v607 = 46;
                                                local v608 = Vector3.new(0, 0, -1);
                                                for v609 = 1, #v606 do
                                                    v607 = (v607 * 33 + string.byte(v606, v609)) % 65521;
                                                end;
                                                if v607 == 272 and v601.Magnitude > 1e-6 then
                                                    v608 = v601.Unit;
                                                end;
                                                local l__Y__36 = v608.Y;
                                                local v610 = math.clamp(-l__Y__36, 0, 1);
                                                local v611 = math.clamp(l__Y__36, 0, 1);
                                                local v612 = math.clamp(v610 * 0.7068583470577035 + 0.7853981633974483 - v611 * 0.39269908169872414, 0, 1.3962634015954636);
                                                v582 = v582 * CFrame.Angles(-v612, 0, 0);
                                            end;
                                            l__RootJoint__34.C0 = v582;
                                            local v613 = tostring(game.GameId);
                                            local v614 = 46;
                                            for v615 = 1, #v613 do
                                                v614 = (v614 * 33 + string.byte(v613, v615)) % 65521;
                                            end;
                                            if v614 == 272 and not u325[l___x539c98577c3cf168__28] then
                                                local v616 = u365(v494);
                                                local v617 = {};
                                                for _, v618 in ipairs(v616) do
                                                    v617[v618.Name] = v618.C0;
                                                end;
                                                u325[l___x539c98577c3cf168__28] = v617;
                                            end;
                                            local v619 = u325[l___x539c98577c3cf168__28] or {};
                                            local v620 = nil;
                                            local v621 = nil;
                                            for v622, v623 in pairs(v619) do
                                                local v624 = v494:FindFirstChild(v622);
                                                local v625 = tostring(game.GameId);
                                                local v626 = 46;
                                                for v627 = 1, #v625 do
                                                    v626 = (v626 * 33 + string.byte(v625, v627)) % 65521;
                                                end;
                                                if v626 == 272 and (v624 and v624:IsA("Motor6D")) then
                                                    local v628 = tostring(game.GameId);
                                                    local v629 = 46;
                                                    for v630 = 1, #v628 do
                                                        v629 = (v629 * 33 + string.byte(v628, v630)) % 65521;
                                                    end;
                                                    if v629 == 272 and v624.Name == "Right Hip" then
                                                        v624.C0 = v623 * CFrame.Angles(0, 0, -v581 * 0.74);
                                                        v620 = v624;
                                                    else
                                                        local v631 = tostring(game.GameId);
                                                        local v632 = 46;
                                                        for v633 = 1, #v631 do
                                                            v632 = (v632 * 33 + string.byte(v631, v633)) % 65521;
                                                        end;
                                                        if v632 == 272 and v624.Name == "Left Hip" then
                                                            v624.C0 = v623 * CFrame.Angles(0, 0, v581 * 0.74);
                                                            v621 = v624;
                                                        end;
                                                    end;
                                                else
                                                    v619[v622] = nil;
                                                end;
                                            end;
                                            v508.RootJoint.C0 = v508.RootJoint.C0:Lerp(v554 * u322 * CFrame.Angles(u321, -u320, 0), 0.1);
                                            u324 = u324 + p383;
                                            local v634 = tostring(game.GameId);
                                            local v635 = 46;
                                            for v636 = 1, #v634 do
                                                v635 = (v635 * 33 + string.byte(v634, v636)) % 65521;
                                            end;
                                            if v635 == 272 and u324 >= 0.05 then
                                                u324 = u324 - 0.05;
                                                local v637 = {};
                                                local v638 = {};
                                                for _, v639 in {
                                                    v508.RootJoint,
                                                    v498,
                                                    v620,
                                                    v621
                                                } do
                                                    table.insert(v637, {
                                                        joint_name = v639.Name,
                                                        C0 = v639.C0
                                                    });
                                                end;
                                                v638.joints = v637;
                                                l__Packets__4.unreliablePackets._x0b71847ea26b42a0:Fire(v638);
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;
function u1._xd8041402b83e75db(u640) --[[ Line: 1098 ]]
    -- upvalues: l__Packets__4 (copy), l__Classes__7 (copy), l__RunService__1 (copy)
    local u641 = {
        ["Right Hip"] = true,
        ["Left Hip"] = true,
        Neck = true,
        RootJoint = true
    };
    l__Packets__4.unreliablePackets._x0b71847ea26b42a0.OnClientEvent:Connect(function(p642) --[[ Line: 1105 ]]
        -- upvalues: u640 (copy), u641 (copy)
        local v643 = tostring(game.GameId);
        local v644 = 46;
        for v645 = 1, #v643 do
            v644 = (v644 * 33 + string.byte(v643, v645)) % 65521;
        end;
        if v644 == 272 and not (p642 and p642.character) then
        else
            local l__character__37 = p642.character;
            local v646 = tostring(game.GameId);
            local v647 = 46;
            for v648 = 1, #v646 do
                v647 = (v647 * 33 + string.byte(v646, v648)) % 65521;
            end;
            if v647 == 272 and not l__character__37.Parent then
            else
                local v649 = tick();
                local v650 = u640._xf641edc0690f84e7[l__character__37];
                local v651 = tostring(game.GameId);
                local v652 = 46;
                for v653 = 1, #v651 do
                    v652 = (v652 * 33 + string.byte(v651, v653)) % 65521;
                end;
                if v652 == 272 and (p642.ts and (v650 and (v650.meta and v650.meta.last_packet_at))) then
                    local v654 = tostring(game.GameId);
                    local v655 = 46;
                    for v656 = 1, #v654 do
                        v655 = (v655 * 33 + string.byte(v654, v656)) % 65521;
                    end;
                    if v655 == 272 and p642.ts <= v650.meta.last_packet_at then
                        return;
                    end;
                end;
                local v657 = tostring(game.GameId);
                local v658 = 46;
                for v659 = 1, #v657 do
                    v658 = (v658 * 33 + string.byte(v657, v659)) % 65521;
                end;
                if v658 == 272 and not v650 then
                    v650 = {
                        joints = {},
                        meta = {
                            next_update_at = 0,
                            last_packet_at = 0,
                            since_last_update = 3
                        }
                    };
                    u640._xf641edc0690f84e7[l__character__37] = v650;
                end;
                v650.joints = {};
                local v660 = tostring(game.GameId);
                local v661 = 46;
                for v662 = 1, #v660 do
                    v661 = (v661 * 33 + string.byte(v660, v662)) % 65521;
                end;
                if v661 == 272 and (p642.joints and type(p642.joints) == "table") then
                    for v663 = 1, #p642.joints do
                        local v664 = p642.joints[v663];
                        local v665 = tostring(game.GameId);
                        local v666 = 46;
                        for v667 = 1, #v665 do
                            v666 = (v666 * 33 + string.byte(v665, v667)) % 65521;
                        end;
                        if v666 == 272 and (v664 and (v664.joint_name and (u641[v664.joint_name] and v664.C0))) then
                            table.insert(v650.joints, {
                                joint_name = v664.joint_name,
                                C0 = v664.C0
                            });
                        end;
                    end;
                end;
                v650.meta.last_packet_at = p642.ts or v649;
                v650.meta.since_last_update = 3;
            end;
        end;
    end);
    task.defer(function() --[[ Line: 1160 ]]
        -- upvalues: l__Classes__7 (ref), u640 (copy), l__RunService__1 (ref)
        l__Classes__7._xcbdbdbb89e869bdc._x95757e626c0bfd56:Connect(function(...) --[[ Line: 1161 ]]
            -- upvalues: u640 (ref)
            u640:_x038e8ec76226df29(...);
        end);
        l__RunService__1.Heartbeat:Connect(function() --[[ Line: 1165 ]]
            -- upvalues: u640 (ref)
            u640:_x259e6976c480aaf2();
        end);
        u640:_xef928500326d61a3();
    end);
end;
return u1;
