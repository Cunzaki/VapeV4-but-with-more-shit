-- Decompiled from: Start.Client.Classes._x48271d11a14d156e
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__CEnum__3 = require(l__ModuleScripts__2.CEnum);
local l__SkinDefs__4 = require(l__ModuleScripts__2.SkinDefs);
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__6 = require(script.Parent.Parent.InternalSymbols);
local u1 = {};
u1.__index = u1;
local u2 = {
    model = true,
    animations = true,
    animations_3p = true,
    rig_3p = true,
    effects = true,
    sounds = true,
    params = true,
    offsets = true,
    auxiliary = true
};
local u3 = {
    equip_sound = true,
    shot_sound = true,
    bonus_shot_sound = true,
    lock_in = true,
    lock_off = true,
    shot_hit = true,
    dry_fire = true
};
local function u11(p4) --[[ Line: 47 ]]
    -- upvalues: u11 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and typeof(p4) ~= "table" then
        return p4;
    end;
    local v8 = {};
    for v9, v10 in pairs(p4) do
        v8[v9] = u11(v10);
    end;
    return v8;
end;
local function u22(p12, p13) --[[ Line: 59 ]]
    -- upvalues: u22 (copy), u11 (copy)
    local v14 = tostring(game.GameId);
    local v15 = 46;
    for v16 = 1, #v14 do
        v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
    end;
    if v15 == 272 and typeof(p13) ~= "table" then
        return p12;
    end;
    for v17, v18 in pairs(p13) do
        local v19 = tostring(game.GameId);
        local v20 = 46;
        for v21 = 1, #v19 do
            v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
        end;
        if v20 == 272 and (typeof(v18) == "table" and typeof(p12[v17]) == "table") then
            u22(p12[v17], v18);
        else
            p12[v17] = u11(v18);
        end;
    end;
    return p12;
end;
local function u35(p23) --[[ Line: 75 ]]
    -- upvalues: u22 (copy), u2 (copy), u11 (copy)
    local v24 = tostring(game.GameId);
    local v25 = 46;
    local v26 = {};
    for v27 = 1, #v24 do
        v25 = (v25 * 33 + string.byte(v24, v27)) % 65521;
    end;
    if v25 == 272 and typeof(p23) ~= "table" then
        return v26;
    end;
    local v28 = tostring(game.GameId);
    local v29 = 46;
    for v30 = 1, #v28 do
        v29 = (v29 * 33 + string.byte(v28, v30)) % 65521;
    end;
    if v29 == 272 and typeof(p23.render) == "table" then
        u22(v26, p23.render);
    end;
    for v31 in pairs(u2) do
        local v32 = tostring(game.GameId);
        local v33 = 46;
        for v34 = 1, #v32 do
            v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
        end;
        if v33 == 272 and p23[v31] ~= nil then
            v26[v31] = u11(p23[v31]);
        end;
    end;
    return v26;
end;
local function u46(p36) --[[ Line: 111 ]]
    local v37 = tostring(game.GameId);
    local v38 = 46;
    for v39 = 1, #v37 do
        v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
    end;
    if v38 == 272 and typeof(p36) ~= "table" then
        return false;
    end;
    local v40 = 0;
    for v41, v42 in pairs(p36) do
        local v43 = tostring(game.GameId);
        local v44 = 46;
        for v45 = 1, #v43 do
            v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
        end;
        if v44 == 272 and (typeof(v41) ~= "number" or (v41 < 1 or (v41 % 1 ~= 0 or (typeof(v42) ~= "string" or v42 == "")))) then
            return false;
        end;
        v40 = v40 + 1;
    end;
    return v40 > 0;
end;
local function u72(p47) --[[ Line: 145 ]]
    -- upvalues: u46 (copy), u72 (copy)
    local v48 = tostring(game.GameId);
    local v49 = 46;
    for v50 = 1, #v48 do
        v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
    end;
    if v49 == 272 and typeof(p47) == "string" then
        return true;
    end;
    local v51 = tostring(game.GameId);
    local v52 = 46;
    for v53 = 1, #v51 do
        v52 = (v52 * 33 + string.byte(v51, v53)) % 65521;
    end;
    if v52 == 272 and typeof(p47) ~= "table" then
        return false;
    end;
    local v54 = tostring(game.GameId);
    local v55 = 46;
    for v56 = 1, #v54 do
        v55 = (v55 * 33 + string.byte(v54, v56)) % 65521;
    end;
    if v55 ~= 272 or not u46(p47) then
        for _, v57 in pairs(p47) do
            local v58 = tostring(game.GameId);
            local v59 = 46;
            for v60 = 1, #v58 do
                v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
            end;
            if v59 == 272 then
                local v61;
                if typeof(v57) == "string" then
                    v61 = true;
                else
                    local v62 = tostring(game.GameId);
                    local v63 = 46;
                    for v64 = 1, #v62 do
                        v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
                    end;
                    if v63 == 272 and typeof(v57) == "string" then
                        v61 = string.find(v57, "/") ~= nil;
                    else
                        v61 = u46(v57);
                        if v61 then
                            if #v57 > 1 then
                                v61 = true;
                            else
                                v61 = false;
                            end;
                        end;
                    end;
                end;
                if v61 then
                    return true;
                end;
            end;
            local v65 = tostring(game.GameId);
            local v66 = 46;
            for v67 = 1, #v65 do
                v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
            end;
            if v66 == 272 and u72(v57) then
                return true;
            end;
        end;
        return false;
    end;
    local v68 = tostring(game.GameId);
    local v69 = 46;
    for v70 = 1, #v68 do
        v69 = (v69 * 33 + string.byte(v68, v70)) % 65521;
    end;
    if v69 == 272 and typeof(p47) == "string" then
        return string.find(p47, "/") ~= nil;
    end;
    local v71 = u46(p47);
    if v71 then
        v71 = #p47 > 1;
    end;
    return v71;
end;
local function u87(p73) --[[ Line: 171 ]]
    -- upvalues: u3 (copy), u46 (copy)
    local v74 = tostring(game.GameId);
    local v75 = 46;
    for v76 = 1, #v74 do
        v75 = (v75 * 33 + string.byte(v74, v76)) % 65521;
    end;
    if v75 == 272 and typeof(p73) ~= "table" then
        return false;
    end;
    for v77, v78 in pairs(p73) do
        local v79 = tostring(game.GameId);
        local v80 = 46;
        for v81 = 1, #v79 do
            v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
        end;
        if v80 == 272 then
            local v82;
            if u3[v77] == true then
                v82 = true;
            elseif typeof(v77) == "string" then
                v82 = string.sub(v77, -6) == "_sound";
            else
                v82 = false;
            end;
            if v82 then
                local v83;
                if typeof(v78) == "string" then
                    v83 = true;
                else
                    local v84 = tostring(game.GameId);
                    local v85 = 46;
                    for v86 = 1, #v84 do
                        v85 = (v85 * 33 + string.byte(v84, v86)) % 65521;
                    end;
                    if v85 == 272 and typeof(v78) == "string" then
                        v83 = string.find(v78, "/") ~= nil;
                    else
                        v83 = u46(v78);
                        if v83 then
                            if #v78 > 1 then
                                v83 = true;
                            else
                                v83 = false;
                            end;
                        end;
                    end;
                end;
                if v83 then
                    return true;
                end;
            end;
        end;
    end;
    return false;
end;
local function u102(p88, p89, p90) --[[ Line: 204 ]]
    local v91 = tostring(game.GameId);
    local v92 = 46;
    for v93 = 1, #v91 do
        v92 = (v92 * 33 + string.byte(v91, v93)) % 65521;
    end;
    if v92 == 272 and not p89 then
        return nil;
    else
        local v94 = p89:FindFirstChild(p90);
        local v95 = tostring(game.GameId);
        local v96 = 46;
        for v97 = 1, #v95 do
            v96 = (v96 * 33 + string.byte(v95, v97)) % 65521;
        end;
        if v96 == 272 and v94 then
            return v94;
        else
            local v98 = p88 - os.clock();
            local v99 = tostring(game.GameId);
            local v100 = 46;
            for v101 = 1, #v99 do
                v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
            end;
            if v100 == 272 and v98 <= 0 then
                return nil;
            else
                return p89:WaitForChild(p90, v98);
            end;
        end;
    end;
end;
local function u127(p103, p104) --[[ Line: 222 ]]
    -- upvalues: l__CEnum__3 (copy)
    local v105 = tostring(game.GameId);
    local v106 = 46;
    local v107 = {};
    local v108 = {};
    for v109 = 1, #v105 do
        v106 = (v106 * 33 + string.byte(v105, v109)) % 65521;
    end;
    if v106 ~= 272 or (typeof(p104) ~= "table" or typeof(p104.asset_folder) ~= "string") then
        local v110 = l__CEnum__3.reverse(l__CEnum__3.Skins, p103);
        local v111 = tostring(game.GameId);
        local v112 = 46;
        for v113 = 1, #v111 do
            v112 = (v112 * 33 + string.byte(v111, v113)) % 65521;
        end;
        if v112 ~= 272 or typeof(v110) == "string" and (v110 ~= "" and not v107[v110]) then
            v107[v110] = true;
            table.insert(v108, v110);
        end;
        local v114 = tostring(game.GameId);
        local v115 = 46;
        for v116 = 1, #v114 do
            v115 = (v115 * 33 + string.byte(v114, v116)) % 65521;
        end;
        if v115 == 272 and typeof(p104) == "table" then
            local l__name__7 = p104.name;
            local v117 = tostring(game.GameId);
            local v118 = 46;
            for v119 = 1, #v117 do
                v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
            end;
            if v118 ~= 272 or typeof(l__name__7) == "string" and (l__name__7 ~= "" and not v107[l__name__7]) then
                v107[l__name__7] = true;
                table.insert(v108, l__name__7);
            end;
        end;
        local v120 = tostring(p103);
        local v121 = tostring(game.GameId);
        local v122 = 46;
        for v123 = 1, #v121 do
            v122 = (v122 * 33 + string.byte(v121, v123)) % 65521;
        end;
        if v122 == 272 then
            if typeof(v120) ~= "string" or v120 == "" then
                return v108;
            end;
            if v107[v120] then
                return v108;
            end;
        end;
        v107[v120] = true;
        table.insert(v108, v120);
        return v108;
    end;
    local l__asset_folder__8 = p104.asset_folder;
    local v124 = tostring(game.GameId);
    local v125 = 46;
    for v126 = 1, #v124 do
        v125 = (v125 * 33 + string.byte(v124, v126)) % 65521;
    end;
    if v125 == 272 then
        if typeof(l__asset_folder__8) ~= "string" or l__asset_folder__8 == "" then
            return v108;
        end;
        if v107[l__asset_folder__8] then
            return v108;
        end;
    end;
    v107[l__asset_folder__8] = true;
    table.insert(v108, l__asset_folder__8);
    return v108;
end;
local function u138(p128, p129) --[[ Line: 250 ]]
    local v130 = tostring(game.GameId);
    local v131 = 46;
    for v132 = 1, #v130 do
        v131 = (v131 * 33 + string.byte(v130, v132)) % 65521;
    end;
    if v131 == 272 and not p128 then
        return nil;
    end;
    for _, v133 in p129 do
        local v134 = p128:FindFirstChild(v133);
        local v135 = tostring(game.GameId);
        local v136 = 46;
        for v137 = 1, #v135 do
            v136 = (v136 * 33 + string.byte(v135, v137)) % 65521;
        end;
        if v136 == 272 and (v134 and v134:IsA("Folder")) then
            return v134;
        end;
    end;
    return nil;
end;
local function u170(p139, p140, p141, p142) --[[ Line: 265 ]]
    -- upvalues: l__Players__1 (copy), u102 (copy), u127 (copy), u138 (copy)
    local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
    local v143 = os.clock() + 2;
    local v144;
    if l__LocalPlayer__9 then
        v144 = l__LocalPlayer__9:FindFirstChildOfClass("PlayerGui");
    else
        v144 = l__LocalPlayer__9;
    end;
    local v145 = tostring(game.GameId);
    local v146 = 46;
    for v147 = 1, #v145 do
        v146 = (v146 * 33 + string.byte(v145, v147)) % 65521;
    end;
    local v148;
    if v146 == 272 and (not v144 and (l__LocalPlayer__9 and p142)) then
        v148 = u102(v143, l__LocalPlayer__9, "PlayerGui");
        local v149 = tostring(game.GameId);
        local v150 = 46;
        for v151 = 1, #v149 do
            v150 = (v150 * 33 + string.byte(v149, v151)) % 65521;
        end;
        if v150 == 272 and v148 then
            if not v148:IsA("PlayerGui") then
                v148 = v144;
            end;
        else
            v148 = v144;
        end;
    else
        v148 = v144;
    end;
    local v152 = tostring(game.GameId);
    local v153 = 46;
    for v154 = 1, #v152 do
        v153 = (v153 * 33 + string.byte(v152, v154)) % 65521;
    end;
    if v153 == 272 and not v148 then
        return nil;
    end;
    local v155 = tostring(game.GameId);
    local v156 = 46;
    for v157 = 1, #v155 do
        v156 = (v156 * 33 + string.byte(v155, v157)) % 65521;
    end;
    local v158;
    if v156 == 272 and p142 then
        v158 = u102(v143, v148, "SkinAssets");
    else
        v158 = v148:FindFirstChild("SkinAssets");
    end;
    local v159 = tostring(game.GameId);
    local v160 = 46;
    for v161 = 1, #v159 do
        v160 = (v160 * 33 + string.byte(v159, v161)) % 65521;
    end;
    if v160 == 272 and p142 then
        v158 = u102(v143, v158, "Skins");
    elseif v158 then
        v158 = v158:FindFirstChild("Skins");
    end;
    local v162 = tostring(game.GameId);
    local v163 = 46;
    for v164 = 1, #v162 do
        v163 = (v163 * 33 + string.byte(v162, v164)) % 65521;
    end;
    if v163 == 272 and p142 then
        v158 = u102(v143, v158, p139);
    elseif v158 then
        v158 = v158:FindFirstChild(p139);
    end;
    local v165 = u127(p140, p141);
    local v166 = u138(v158, v165);
    while p142 and (not v166 and os.clock() < v143) do
        task.wait(0.05);
        v166 = u138(v158, v165);
    end;
    local v167 = tostring(game.GameId);
    local v168 = 46;
    for v169 = 1, #v167 do
        v168 = (v168 * 33 + string.byte(v167, v169)) % 65521;
    end;
    return v168 == 272 and v166 and v166 or nil;
end;
local function u173(p171, p172) --[[ Line: 304 ]]
    -- upvalues: l__SkinDefs__4 (copy)
    return l__SkinDefs__4.resolveReference(p171, p172);
end;
local function u189(p174, p175) --[[ Line: 317 ]]
    -- upvalues: u46 (copy), u173 (copy)
    local v176 = tostring(game.GameId);
    local v177 = 46;
    for v178 = 1, #v176 do
        v177 = (v177 * 33 + string.byte(v176, v178)) % 65521;
    end;
    if v177 ~= 272 or (typeof(p174) ~= "string" or string.find(p174, "/")) then
        local v179 = tostring(game.GameId);
        local v180 = 46;
        for v181 = 1, #v179 do
            v180 = (v180 * 33 + string.byte(v179, v181)) % 65521;
        end;
        if v180 == 272 then
            local v182 = tostring(game.GameId);
            local v183 = 46;
            for v184 = 1, #v182 do
                v183 = (v183 * 33 + string.byte(v182, v184)) % 65521;
            end;
            local v185;
            if v183 == 272 and typeof(p174) == "string" then
                v185 = string.find(p174, "/") ~= nil;
            else
                v185 = u46(p174);
                if v185 then
                    v185 = #p174 > 1;
                end;
            end;
            if v185 then
                return u173(p174, p175);
            end;
        end;
        return nil;
    end;
    if p175 then
        p175 = p175:FindFirstChild("Sounds");
    end;
    local v186 = tostring(game.GameId);
    local v187 = 46;
    for v188 = 1, #v186 do
        v187 = (v187 * 33 + string.byte(v186, v188)) % 65521;
    end;
    if v187 ~= 272 or not (p175 and p175:IsA("Folder")) then
        p175 = nil;
    end;
    if p175 then
        p175 = p175:FindFirstChild(p174);
    end;
    return p175;
end;
local function u204(p190, p191, p192) --[[ Line: 330 ]]
    -- upvalues: u189 (copy), u46 (copy), u11 (copy)
    local v193 = u189(p190, p191);
    local v194 = tostring(game.GameId);
    local v195 = 46;
    for v196 = 1, #v194 do
        v195 = (v195 * 33 + string.byte(v194, v196)) % 65521;
    end;
    if v195 == 272 and (v193 and (v193:IsA("Sound") or v193:IsA("SoundGroup"))) then
        return v193;
    end;
    local v197 = tostring(game.GameId);
    local v198 = 46;
    for v199 = 1, #v197 do
        v198 = (v198 * 33 + string.byte(v197, v199)) % 65521;
    end;
    if v198 == 272 then
        local v200 = tostring(game.GameId);
        local v201 = 46;
        for v202 = 1, #v200 do
            v201 = (v201 * 33 + string.byte(v200, v202)) % 65521;
        end;
        local v203;
        if v201 == 272 and typeof(p190) == "string" then
            v203 = string.find(p190, "/") ~= nil;
        else
            v203 = u46(p190);
            if v203 then
                v203 = #p190 > 1;
            end;
        end;
        if v203 then
            return u11(p192);
        end;
    end;
    return p190;
end;
local function u221(p205, p206, p207) --[[ Line: 343 ]]
    -- upvalues: u46 (copy), u204 (copy), u221 (copy)
    local v208 = tostring(game.GameId);
    local v209 = 46;
    for v210 = 1, #v208 do
        v209 = (v209 * 33 + string.byte(v208, v210)) % 65521;
    end;
    if v209 == 272 and typeof(p205) ~= "table" then
        return p205;
    end;
    local v211 = {};
    for v212, v213 in pairs(p205) do
        local v214;
        if typeof(p207) == "table" then
            v214 = p207[v212] or nil;
        else
            v214 = nil;
        end;
        local v215 = tostring(game.GameId);
        local v216 = 46;
        for v217 = 1, #v215 do
            v216 = (v216 * 33 + string.byte(v215, v217)) % 65521;
        end;
        if v216 == 272 and u46(v213) then
            v211[v212] = u204(v213, p206, v214);
        else
            local v218 = tostring(game.GameId);
            local v219 = 46;
            for v220 = 1, #v218 do
                v219 = (v219 * 33 + string.byte(v218, v220)) % 65521;
            end;
            if v219 == 272 and typeof(v213) == "table" then
                v211[v212] = u221(v213, p206, v214);
            else
                v211[v212] = u204(v213, p206, v214);
            end;
        end;
    end;
    return v211;
end;
local function u236(p222, p223, p224) --[[ Line: 365 ]]
    -- upvalues: u11 (copy), u3 (copy), u204 (copy)
    local v225 = tostring(game.GameId);
    local v226 = 46;
    for v227 = 1, #v225 do
        v226 = (v226 * 33 + string.byte(v225, v227)) % 65521;
    end;
    if v226 == 272 and typeof(p222) ~= "table" then
        return p222;
    end;
    local v228 = u11(p222);
    for v229, v230 in pairs(p222) do
        local v231 = tostring(game.GameId);
        local v232 = 46;
        for v233 = 1, #v231 do
            v232 = (v232 * 33 + string.byte(v231, v233)) % 65521;
        end;
        if v232 == 272 then
            local v234;
            if u3[v229] == true then
                v234 = true;
            elseif typeof(v229) == "string" then
                v234 = string.sub(v229, -6) == "_sound";
            else
                v234 = false;
            end;
            if v234 then
                local v235;
                if typeof(p224) == "table" then
                    v235 = p224[v229] or nil;
                else
                    v235 = nil;
                end;
                v228[v229] = u204(v230, p223, v235);
            end;
        end;
    end;
    return v228;
end;
function u1._xafd29f1684593d0b() --[[ Line: 381 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._xfa248435cddccd62(_, p237, p238, p239, p240, p241) --[[ Line: 387 ]]
    -- upvalues: l__InternalSymbols__6 (copy), l__SkinDefs__4 (copy), u11 (copy), u22 (copy), u35 (copy), u72 (copy), u87 (copy), u170 (copy), u127 (copy), u221 (copy), u236 (copy)
    local v242 = l__InternalSymbols__6.owner("", p237);
    local v243 = l__SkinDefs__4.getEquippedOrDefault(p240, p241);
    local v244 = l__SkinDefs__4.getSkin(p240, v243);
    local v245 = tostring(game.GameId);
    local v246 = 46;
    local v247 = {};
    for v248 = 1, #v245 do
        v246 = (v246 * 33 + string.byte(v245, v248)) % 65521;
    end;
    if v246 == 272 and (typeof(p241) == "number" and (p241 ~= l__SkinDefs__4.DEFAULT_SKIN_ID and v243 == l__SkinDefs__4.DEFAULT_SKIN_ID)) then
        warn("INVALID SKIN ID FOR ITEM, USING DEFAULT : ", p240, p241);
    end;
    local v249 = tostring(game.GameId);
    local v250 = 46;
    for v251 = 1, #v249 do
        v250 = (v250 * 33 + string.byte(v249, v251)) % 65521;
    end;
    local v252 = v250 == 272 and (v242 and typeof(v242._x47262089ae496a5d) == "function") and (v242._x47262089ae496a5d(p238) or {}) or v247;
    local v253 = u11(v252);
    u22(v253, (u35(v244)));
    local v254 = l__SkinDefs__4.getSkinFolder(p240, v243, v244);
    local v255 = tostring(game.GameId);
    local v256 = 46;
    local v257 = true;
    for v258 = 1, #v255 do
        v256 = (v256 * 33 + string.byte(v255, v258)) % 65521;
    end;
    local v259;
    if v256 == 272 and typeof(v244) ~= "table" then
        v259 = nil;
    else
        local v260 = tostring(game.GameId);
        local v261 = 46;
        for v262 = 1, #v260 do
            v261 = (v261 * 33 + string.byte(v260, v262)) % 65521;
        end;
        if v261 == 272 and v244.model ~= nil then
            v259 = v244.model;
        else
            local l__render__10 = v244.render;
            local v263 = tostring(game.GameId);
            local v264 = 46;
            for v265 = 1, #v263 do
                v264 = (v264 * 33 + string.byte(v263, v265)) % 65521;
            end;
            if v264 == 272 and typeof(l__render__10) == "table" then
                v259 = l__render__10.model;
            else
                v259 = nil;
            end;
        end;
    end;
    if v259 == nil then
        local v266 = tostring(game.GameId);
        local v267 = 46;
        for v268 = 1, #v266 do
            v267 = (v267 * 33 + string.byte(v266, v268)) % 65521;
        end;
        local v269;
        if v267 == 272 and typeof(v244) ~= "table" then
            v269 = nil;
        else
            local v270 = tostring(game.GameId);
            local v271 = 46;
            for v272 = 1, #v270 do
                v271 = (v271 * 33 + string.byte(v270, v272)) % 65521;
            end;
            if v271 == 272 and v244.animations ~= nil then
                v269 = v244.animations;
            else
                local l__render__11 = v244.render;
                local v273 = tostring(game.GameId);
                local v274 = 46;
                for v275 = 1, #v273 do
                    v274 = (v274 * 33 + string.byte(v273, v275)) % 65521;
                end;
                if v274 == 272 and typeof(l__render__11) == "table" then
                    v269 = l__render__11.animations;
                else
                    v269 = nil;
                end;
            end;
        end;
        if v269 == nil then
            v257 = false;
        else
            v257 = true;
        end;
    end;
    local v276;
    if v243 == l__SkinDefs__4.DEFAULT_SKIN_ID then
        v276 = false;
    else
        local v277 = tostring(game.GameId);
        local v278 = 46;
        v276 = true;
        for v279 = 1, #v277 do
            v278 = (v278 * 33 + string.byte(v277, v279)) % 65521;
        end;
        local v280;
        if v278 == 272 and typeof(v244) ~= "table" then
            v280 = nil;
        else
            local v281 = tostring(game.GameId);
            local v282 = 46;
            for v283 = 1, #v281 do
                v282 = (v282 * 33 + string.byte(v281, v283)) % 65521;
            end;
            if v282 == 272 and v244.model ~= nil then
                v280 = v244.model;
            else
                local l__render__12 = v244.render;
                local v284 = tostring(game.GameId);
                local v285 = 46;
                for v286 = 1, #v284 do
                    v285 = (v285 * 33 + string.byte(v284, v286)) % 65521;
                end;
                if v285 == 272 and typeof(l__render__12) == "table" then
                    v280 = l__render__12.model;
                else
                    v280 = nil;
                end;
            end;
        end;
        if v280 == nil then
            local v287 = tostring(game.GameId);
            local v288 = 46;
            for v289 = 1, #v287 do
                v288 = (v288 * 33 + string.byte(v287, v289)) % 65521;
            end;
            local v290;
            if v288 == 272 and typeof(v244) ~= "table" then
                v290 = nil;
            else
                local v291 = tostring(game.GameId);
                local v292 = 46;
                for v293 = 1, #v291 do
                    v292 = (v292 * 33 + string.byte(v291, v293)) % 65521;
                end;
                if v292 == 272 and v244.animations ~= nil then
                    v290 = v244.animations;
                else
                    local l__render__13 = v244.render;
                    local v294 = tostring(game.GameId);
                    local v295 = 46;
                    for v296 = 1, #v294 do
                        v295 = (v295 * 33 + string.byte(v294, v296)) % 65521;
                    end;
                    if v295 == 272 and typeof(l__render__13) == "table" then
                        v290 = l__render__13.animations;
                    else
                        v290 = nil;
                    end;
                end;
            end;
            if v290 == nil then
                v276 = false;
            else
                v276 = true;
            end;
        end;
        if not v276 then
            local v297 = u72;
            local v298 = tostring(game.GameId);
            local v299 = 46;
            for v300 = 1, #v298 do
                v299 = (v299 * 33 + string.byte(v298, v300)) % 65521;
            end;
            local v301;
            if v299 == 272 and typeof(v244) ~= "table" then
                v301 = nil;
            else
                local v302 = tostring(game.GameId);
                local v303 = 46;
                for v304 = 1, #v302 do
                    v303 = (v303 * 33 + string.byte(v302, v304)) % 65521;
                end;
                if v303 == 272 and v244.sounds ~= nil then
                    v301 = v244.sounds;
                else
                    local l__render__14 = v244.render;
                    local v305 = tostring(game.GameId);
                    local v306 = 46;
                    for v307 = 1, #v305 do
                        v306 = (v306 * 33 + string.byte(v305, v307)) % 65521;
                    end;
                    if v306 == 272 and typeof(l__render__14) == "table" then
                        v301 = l__render__14.sounds;
                    else
                        v301 = nil;
                    end;
                end;
            end;
            v276 = v297(v301);
            if not v276 then
                local v308 = u87;
                local v309 = tostring(game.GameId);
                local v310 = 46;
                for v311 = 1, #v309 do
                    v310 = (v310 * 33 + string.byte(v309, v311)) % 65521;
                end;
                local v312;
                if v310 == 272 and typeof(v244) ~= "table" then
                    v312 = nil;
                else
                    local v313 = tostring(game.GameId);
                    local v314 = 46;
                    for v315 = 1, #v313 do
                        v314 = (v314 * 33 + string.byte(v313, v315)) % 65521;
                    end;
                    if v314 == 272 and v244.params ~= nil then
                        v312 = v244.params;
                    else
                        local l__render__15 = v244.render;
                        local v316 = tostring(game.GameId);
                        local v317 = 46;
                        for v318 = 1, #v316 do
                            v317 = (v317 * 33 + string.byte(v316, v318)) % 65521;
                        end;
                        if v317 == 272 and typeof(l__render__15) == "table" then
                            v312 = l__render__15.params;
                        else
                            v312 = nil;
                        end;
                    end;
                end;
                v276 = v308(v312);
            end;
        end;
    end;
    local v319 = u170(p240, v243, v244, v276);
    local v320 = tostring(game.GameId);
    local v321 = 46;
    for v322 = 1, #v320 do
        v321 = (v321 * 33 + string.byte(v320, v322)) % 65521;
    end;
    if v321 == 272 and (v243 ~= l__SkinDefs__4.DEFAULT_SKIN_ID and (v257 and not v319)) then
        warn("PRIVATE SKIN ASSET MIRROR MISSING : ", p240, v243, table.concat(u127(v243, v244), ", "));
    end;
    local l__animations__16 = v253.animations;
    local v323 = l__SkinDefs__4.resolveReference(v253.model, v319);
    local v324 = l__SkinDefs__4.resolveReference(v253.model, v254);
    local v325 = tostring(game.GameId);
    local v326 = 46;
    local v327 = v319 or v254;
    for v328 = 1, #v325 do
        v326 = (v326 * 33 + string.byte(v325, v328)) % 65521;
    end;
    if v326 == 272 and v319 then
        local v329 = tostring(game.GameId);
        local v330 = 46;
        for v331 = 1, #v329 do
            v330 = (v330 * 33 + string.byte(v329, v331)) % 65521;
        end;
        local v332;
        if v330 == 272 and typeof(v244) ~= "table" then
            v332 = nil;
        else
            local v333 = tostring(game.GameId);
            local v334 = 46;
            for v335 = 1, #v333 do
                v334 = (v334 * 33 + string.byte(v333, v335)) % 65521;
            end;
            if v334 == 272 and v244.model ~= nil then
                v332 = v244.model;
            else
                local l__render__17 = v244.render;
                local v336 = tostring(game.GameId);
                local v337 = 46;
                for v338 = 1, #v336 do
                    v337 = (v337 * 33 + string.byte(v336, v338)) % 65521;
                end;
                if v337 == 272 and typeof(l__render__17) == "table" then
                    v332 = l__render__17.model;
                else
                    v332 = nil;
                end;
            end;
        end;
        if v332 ~= nil and not v323 then
            warn("PRIVATE SKIN MODEL MIRROR MISSING : ", p240, v243, v253.model, v319:GetFullName());
        end;
    end;
    local v339 = v323 or (v324 or l__SkinDefs__4.resolveReference(v252.model, nil));
    local v340 = l__SkinDefs__4.resolveReference(l__animations__16, v319);
    local v341 = l__SkinDefs__4.resolveReference(l__animations__16, v254);
    local v342 = tostring(game.GameId);
    local v343 = 46;
    for v344 = 1, #v342 do
        v343 = (v343 * 33 + string.byte(v342, v344)) % 65521;
    end;
    if v343 == 272 and v319 then
        local v345 = tostring(game.GameId);
        local v346 = 46;
        for v347 = 1, #v345 do
            v346 = (v346 * 33 + string.byte(v345, v347)) % 65521;
        end;
        local v348;
        if v346 == 272 and typeof(v244) ~= "table" then
            v348 = nil;
        else
            local v349 = tostring(game.GameId);
            local v350 = 46;
            for v351 = 1, #v349 do
                v350 = (v350 * 33 + string.byte(v349, v351)) % 65521;
            end;
            if v350 == 272 and v244.animations ~= nil then
                v348 = v244.animations;
            else
                local l__render__18 = v244.render;
                local v352 = tostring(game.GameId);
                local v353 = 46;
                for v354 = 1, #v352 do
                    v353 = (v353 * 33 + string.byte(v352, v354)) % 65521;
                end;
                if v353 == 272 and typeof(l__render__18) == "table" then
                    v348 = l__render__18.animations;
                else
                    v348 = nil;
                end;
            end;
        end;
        if v348 ~= nil and not v340 then
            warn("PRIVATE SKIN ANIMATION MIRROR MISSING : ", p240, v243, l__animations__16, v319:GetFullName());
        end;
    end;
    local v355 = v340 or (v341 or l__SkinDefs__4.resolveReference(v252.animations, nil));
    local v356 = tostring(game.GameId);
    local v357 = 46;
    local v358 = nil;
    for v359 = 1, #v356 do
        v357 = (v357 * 33 + string.byte(v356, v359)) % 65521;
    end;
    if v357 == 272 and not v355 then
        if typeof(l__animations__16) ~= "string" then
            l__animations__16 = v355;
        end;
    else
        l__animations__16 = v355;
    end;
    local v360 = tostring(game.GameId);
    local v361 = 46;
    for v362 = 1, #v360 do
        v361 = (v361 * 33 + string.byte(v360, v362)) % 65521;
    end;
    if v361 == 272 then
        l__animations__16 = l__animations__16 or p240;
    end;
    local v363 = tostring(game.GameId);
    local v364 = 46;
    for v365 = 1, #v363 do
        v364 = (v364 * 33 + string.byte(v363, v365)) % 65521;
    end;
    if v364 == 272 and (typeof(v244) == "table" and v244.animations_3p ~= nil) then
        v358 = l__SkinDefs__4.resolveAnimations3P(p240, v243);
        local v366 = tostring(game.GameId);
        local v367 = 46;
        for v368 = 1, #v366 do
            v367 = (v367 * 33 + string.byte(v366, v368)) % 65521;
        end;
        if v367 == 272 and not v358 then
            warn("COULD NOT RESOLVE animations_3p FOR SKIN : ", p240, v243, v244.animations_3p);
        end;
    end;
    v253.item_type = p239;
    v253.item_id = p240;
    v253.skin_id = v243;
    v253.skin_def = v244;
    v253.asset_folder = v327;
    v253.private_asset_folder = v319;
    v253.public_asset_folder = v254;
    v253.model_source = v339;
    v253.animations = l__animations__16;
    v253.animations_3p = v358;
    v253.params = v253.params or {};
    v253.offsets = v253.offsets or {};
    v253.sounds = v253.sounds or {};
    v253.effects = v253.effects or {};
    v253.sounds = u221(v253.sounds, v319, v252.sounds);
    v253.params = u236(v253.params, v319, v252.params);
    local v369 = tostring(game.GameId);
    local v370 = 46;
    for v371 = 1, #v369 do
        v370 = (v370 * 33 + string.byte(v369, v371)) % 65521;
    end;
    if v370 == 272 and v339 then
        v253.model = v339:Clone();
    end;
    local v372 = tostring(game.GameId);
    local v373 = 46;
    for v374 = 1, #v372 do
        v373 = (v373 * 33 + string.byte(v372, v374)) % 65521;
    end;
    if v373 == 272 and typeof(v253.auxiliary) == "table" then
        local v375 = {};
        for v376, v377 in pairs(v253.auxiliary) do
            local v378 = l__SkinDefs__4.resolveReference(v377, v254);
            local v379 = tostring(game.GameId);
            local v380 = 46;
            for v381 = 1, #v379 do
                v380 = (v380 * 33 + string.byte(v379, v381)) % 65521;
            end;
            if v380 == 272 and v378 then
                v375[v376] = v378:Clone();
            end;
        end;
        v253.auxiliary_models = v375;
    end;
    local l__gunpoint_path__19 = v253.params.gunpoint_path;
    local v382 = tostring(game.GameId);
    local v383 = 46;
    for v384 = 1, #v382 do
        v383 = (v383 * 33 + string.byte(v382, v384)) % 65521;
    end;
    if v383 == 272 and (not v253.params.gunpoint and (v253.model and l__gunpoint_path__19)) then
        v253.params.gunpoint = l__SkinDefs__4.findByPath(v253.model, l__gunpoint_path__19);
    end;
    v253.params.animation_source = v253.animations;
    v253.params.animations_3p = v253.animations_3p;
    v253.params.effects = v253.effects;
    v253.params.sounds = v253.sounds;
    v253.params.render_context = v253;
    return v253;
end;
function u1._xe11fc2d7956c68af(_, p385, p386, p387) --[[ Line: 491 ]]
    if p385 then
        p385 = p385.sounds;
    end;
    local v388 = tostring(game.GameId);
    local v389 = 46;
    for v390 = 1, #v388 do
        v389 = (v389 * 33 + string.byte(v388, v390)) % 65521;
    end;
    if v389 == 272 and typeof(p385) == "table" then
        return p385[p386] or (p385[p387] or (p387 or p386));
    else
        return p387 or p386;
    end;
end;
function u1._x60567ffb440fc88e(p391, p392, p393, p394, p395, p396, p397) --[[ Line: 500 ]]
    -- upvalues: l__InternalSymbols__6 (copy)
    local v398 = l__InternalSymbols__6.owner("", p393);
    local v399 = p391:_xe11fc2d7956c68af(p392, p394, p397);
    local v400 = tostring(game.GameId);
    local v401 = 46;
    for v402 = 1, #v400 do
        v401 = (v401 * 33 + string.byte(v400, v402)) % 65521;
    end;
    if v401 ~= 272 or typeof(v399) ~= "Instance" then
        return v398:_xa2c2f0587694a915(v399, p395, p396);
    end;
    local v403 = tostring(game.GameId);
    local v404 = 46;
    for v405 = 1, #v403 do
        v404 = (v404 * 33 + string.byte(v403, v405)) % 65521;
    end;
    if v404 == 272 and (v399:IsA("Sound") or v399:IsA("SoundGroup")) then
        return v398:_x9c489e5a8445737f(v399.Name, v399, p395, p396);
    end;
    warn("INVALID SKIN SOUND INSTANCE : ", v399);
    return nil;
end;
function u1._xe3aac2ea798b279f(_, p406, p407, p408) --[[ Line: 515 ]]
    if p406 then
        p406 = p406.effects;
    end;
    local v409 = tostring(game.GameId);
    local v410 = 46;
    for v411 = 1, #v409 do
        v410 = (v410 * 33 + string.byte(v409, v411)) % 65521;
    end;
    if v410 == 272 and typeof(p406) == "table" then
        return p406[p407] or (p406[p408] or (p408 or p407));
    else
        return p408 or p407;
    end;
end;
function u1._xbc713bc0a6db24ba(p412, p413, p414, ...) --[[ Line: 524 ]]
    -- upvalues: l__Classes__5 (copy)
    local v415 = p412:_xe3aac2ea798b279f(p413, p414, p414);
    local v416 = tostring(game.GameId);
    local v417 = 46;
    for v418 = 1, #v416 do
        v417 = (v417 * 33 + string.byte(v416, v418)) % 65521;
    end;
    if v417 == 272 and typeof(v415) == "function" then
        return v415(l__Classes__5._x7c4d08c7bcf3460a, ...);
    else
        return l__Classes__5._x7c4d08c7bcf3460a:_xaf38e84cb4723af1(v415, ...);
    end;
end;
function u1._xd8041402b83e75db(_) --[[ Line: 533 ]] end;
return u1;
