-- Decompiled from: Start.Client.AEAD
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local function u102(p1, p2) --[[ Line: 53 ]]
    local v3 = buffer.len(p1);
    local v4, v5;
    if v3 % 16 == 0 and v3 ~= 0 then
        v4 = p1;
        v5 = v3;
    else
        v5 = v3 + (16 - v3 % 16);
        v4 = buffer.create(v5);
        buffer.copy(v4, 0, p1, 0, v3);
        buffer.writeu8(v4, v3, 1);
    end;
    local v6 = v3 - 15;
    local v7 = buffer.readu32(p2, 0) % 268435456;
    local v8 = buffer.readu32(p2, 4);
    local v9 = bit32.band(v8, 268435452) % 268435456 * 4294967296;
    local v10 = buffer.readu32(p2, 8);
    local v11 = bit32.band(v10, 268435452) % 268435456 * 1.8446744073709552e19;
    local v12 = buffer.readu32(p2, 12);
    local v13 = bit32.band(v12, 268435452) % 268435456 * 7.922816251426434e28;
    local v14 = v7 % 262144;
    local v15 = v7 - v14;
    local v16 = v9 % 1125899906842624;
    local v17 = v9 - v16;
    local v18 = v11 % 4.835703278458517e24;
    local v19 = v11 - v18;
    local v20 = v13 % 5.192296858534828e33;
    local v21 = v13 - v20;
    local v22 = v9 * 3.6734198463196485e-39;
    local v23 = v11 * 3.6734198463196485e-39;
    local v24 = v13 * 3.6734198463196485e-39;
    local v25 = v22 % 8.271806125530277e-25;
    local v26 = v22 - v25;
    local v27 = v23 % 3.552713678800501e-15;
    local v28 = v23 - v27;
    local v29 = v24 % 0.0000152587890625;
    local v30 = v24 - v29;
    local v31 = 0;
    local v32 = 0;
    local v33 = 0;
    local v34 = 0;
    local v35 = 0;
    local v36 = 0;
    local v37 = 0;
    local v38 = 0;
    for v39 = 0, v5 - 1, 16 do
        local v40 = buffer.readu32(v4, v39);
        local v41 = buffer.readu32(v4, v39 + 4);
        local v42 = buffer.readu32(v4, v39 + 8);
        local v43 = buffer.readu32(v4, v39 + 12);
        local v44 = v38 + v31 + v40;
        local v45 = v32 + v33 + v41 * 4294967296;
        local v46 = v34 + v35 + v42 * 1.8446744073709552e19;
        local v47 = v36 + v37 + v43 * 7.922816251426434e28;
        if v39 < v6 then
            v47 = v47 + 3.402823669209385e38;
        end;
        local v48 = v44 * v14 + v45 * v29 + v46 * v27 + v47 * v25;
        local v49 = v44 * v15 + v45 * v30 + v46 * v28 + v47 * v26;
        local v50 = v44 * v16 + v45 * v14 + v46 * v29 + v47 * v27;
        local v51 = v44 * v17 + v45 * v15 + v46 * v30 + v47 * v28;
        local v52 = v44 * v18 + v45 * v16 + v46 * v14 + v47 * v29;
        local v53 = v44 * v19 + v45 * v17 + v46 * v15 + v47 * v30;
        local v54 = v44 * v20 + v45 * v18 + v46 * v16 + v47 * v14;
        local v55 = v44 * v21 + v45 * v19 + v46 * v17 + v47 * v15;
        local v56 = v48 + 1.770887431076117e21 - 1.770887431076117e21;
        local v57 = v48 - v56;
        local v58 = v49 + v56;
        local v59 = v58 + 2.90142196707511e25 - 2.90142196707511e25;
        v31 = v58 - v59;
        local v60 = v50 + v59;
        local v61 = v60 + 7.605903601369376e30 - 7.605903601369376e30;
        v32 = v60 - v61;
        local v62 = v51 + v61;
        local v63 = v62 + 1.2461512460483586e35 - 1.2461512460483586e35;
        v33 = v62 - v63;
        local v64 = v52 + v63;
        local v65 = v64 + 3.2667107224410092e40 - 3.2667107224410092e40;
        v34 = v64 - v65;
        local v66 = v53 + v65;
        local v67 = v66 + 5.3521788476473496e44 - 5.3521788476473496e44;
        v35 = v66 - v67;
        local v68 = v54 + v67;
        local v69 = v68 + 3.507603929594167e49 - 3.507603929594167e49;
        v36 = v68 - v69;
        local v70 = v55 + v69;
        local v71 = v70 + 9.194973245195333e54 - 9.194973245195333e54;
        v37 = v70 - v71;
        v38 = v57 + v71 * 3.6734198463196485e-39;
    end;
    local v72 = v38 % 65536;
    local v73 = v38 - v72 + v31;
    local v74 = v73 % 4294967296;
    local v75 = v73 - v74 + v32;
    local v76 = v75 % 281474976710656;
    local v77 = v75 - v76 + v33;
    local v78 = v77 % 1.8446744073709552e19;
    local v79 = v77 - v78 + v34;
    local v80 = v79 % 1.2089258196146292e24;
    local v81 = v79 - v80 + v35;
    local v82 = v81 % 7.922816251426434e28;
    local v83 = v81 - v82 + v36;
    local v84 = v83 % 5.192296858534828e33;
    local v85 = v83 - v84 + v37;
    local v86 = v85 % 1.361129467683754e39;
    local v87 = v72 + (v85 - v86) * 3.6734198463196485e-39;
    local v88 = v87 % 65536;
    local v89 = v87 - v88 + v74;
    if v86 == 1.3611242753868953e39 and (v84 == 5.1922176303723134e33 and (v82 == 7.922695358844472e28 and (v80 == 1.2089073728705555e24 and (v78 == 1.844646259873284e19 and (v76 == 281470681743360 and (v89 == 4294901760 and v88 >= 65531)))))) then
        v88 = v88 - 65531;
        v86 = 0;
        v89 = 0;
        v76 = 0;
        v78 = 0;
        v80 = 0;
        v82 = 0;
        v84 = 0;
    end;
    local v90 = buffer.readu32(p2, 16);
    local v91 = buffer.readu32(p2, 20);
    local v92 = buffer.readu32(p2, 24);
    local v93 = buffer.readu32(p2, 28);
    local v94 = v90 + v88 + v89;
    local v95 = v94 % 4294967296;
    local v96 = v94 - v95 + v91 * 4294967296 + v76 + v78;
    local v97 = v96 % 1.8446744073709552e19;
    local v98 = v96 - v97 + v92 * 1.8446744073709552e19 + v80 + v82;
    local v99 = v98 % 7.922816251426434e28;
    local v100 = (v98 - v99 + v93 * 7.922816251426434e28 + v84 + v86) % 3.402823669209385e38;
    local v101 = buffer.create(16);
    buffer.writeu32(v101, 0, v95);
    buffer.writeu32(v101, 4, v97 / 4294967296);
    buffer.writeu32(v101, 8, v99 / 1.8446744073709552e19);
    buffer.writeu32(v101, 12, v100 / 7.922816251426434e28);
    return v101;
end;
local u103 = buffer.create(16);
local u104 = {};
local function u108(p105, p106) --[[ Line: 222 ]]
    -- upvalues: u102 (copy)
    if p105 == nil then
        error("Message cannot be nil", 2);
    end;
    if typeof(p105) ~= "buffer" then
        error(`Message must be a buffer, got {typeof(p105)}`, 2);
    end;
    if p106 == nil then
        error("Key cannot be nil", 2);
    end;
    if typeof(p106) ~= "buffer" then
        error(`Key must be a buffer, got {typeof(p106)}`, 2);
    end;
    local v107 = buffer.len(p106);
    if v107 ~= 32 then
        error(`Key must be exactly {32} bytes long, got {v107} bytes`, 2);
    end;
    return u102(p105, p106);
end;
for v109, v110 in { string.byte("expand 32-byte k", 1, -1) } do
    buffer.writeu8(u103, v109 - 1, v110);
end;
local u111 = buffer.create(16);
for v112, v113 in { string.byte("expand 16-byte k", 1, -1) } do
    buffer.writeu8(u111, v112 - 1, v113);
end;
local function u228(p114, p115) --[[ Line: 271 ]]
    local v116 = buffer.readu32(p114, 0);
    local v117 = buffer.readu32(p114, 4);
    local v118 = buffer.readu32(p114, 8);
    local v119 = buffer.readu32(p114, 12);
    local v120 = buffer.readu32(p114, 16);
    local v121 = buffer.readu32(p114, 20);
    local v122 = buffer.readu32(p114, 24);
    local v123 = buffer.readu32(p114, 28);
    local v124 = buffer.readu32(p114, 32);
    local v125 = buffer.readu32(p114, 36);
    local v126 = buffer.readu32(p114, 40);
    local v127 = buffer.readu32(p114, 44);
    local v128 = buffer.readu32(p114, 48);
    local v129 = buffer.readu32(p114, 52);
    local v130 = buffer.readu32(p114, 56);
    local v131 = buffer.readu32(p114, 60);
    for _ = 1, p115, 2 do
        local v132 = bit32.bor(v116 + v120, 0);
        local v133 = bit32.bxor(v128, v132);
        local v134 = bit32.lrotate(v133, 16);
        local v135 = bit32.bor(v124 + v134, 0);
        local v136 = bit32.bxor(v120, v135);
        local v137 = bit32.lrotate(v136, 12);
        local v138 = bit32.bor(v132 + v137, 0);
        local v139 = bit32.bxor(v134, v138);
        local v140 = bit32.lrotate(v139, 8);
        local v141 = bit32.bor(v135 + v140, 0);
        local v142 = bit32.bxor(v137, v141);
        local v143 = bit32.lrotate(v142, 7);
        local v144 = bit32.bor(v117 + v121, 0);
        local v145 = bit32.bxor(v129, v144);
        local v146 = bit32.lrotate(v145, 16);
        local v147 = bit32.bor(v125 + v146, 0);
        local v148 = bit32.bxor(v121, v147);
        local v149 = bit32.lrotate(v148, 12);
        local v150 = bit32.bor(v144 + v149, 0);
        local v151 = bit32.bxor(v146, v150);
        local v152 = bit32.lrotate(v151, 8);
        local v153 = bit32.bor(v147 + v152, 0);
        local v154 = bit32.bxor(v149, v153);
        local v155 = bit32.lrotate(v154, 7);
        local v156 = bit32.bor(v118 + v122, 0);
        local v157 = bit32.bxor(v130, v156);
        local v158 = bit32.lrotate(v157, 16);
        local v159 = bit32.bor(v126 + v158, 0);
        local v160 = bit32.bxor(v122, v159);
        local v161 = bit32.lrotate(v160, 12);
        local v162 = bit32.bor(v156 + v161, 0);
        local v163 = bit32.bxor(v158, v162);
        local v164 = bit32.lrotate(v163, 8);
        local v165 = bit32.bor(v159 + v164, 0);
        local v166 = bit32.bxor(v161, v165);
        local v167 = bit32.lrotate(v166, 7);
        local v168 = bit32.bor(v119 + v123, 0);
        local v169 = bit32.bxor(v131, v168);
        local v170 = bit32.lrotate(v169, 16);
        local v171 = bit32.bor(v127 + v170, 0);
        local v172 = bit32.bxor(v123, v171);
        local v173 = bit32.lrotate(v172, 12);
        local v174 = bit32.bor(v168 + v173, 0);
        local v175 = bit32.bxor(v170, v174);
        local v176 = bit32.lrotate(v175, 8);
        local v177 = bit32.bor(v171 + v176, 0);
        local v178 = bit32.bxor(v173, v177);
        local v179 = bit32.lrotate(v178, 7);
        local v180 = bit32.bor(v138 + v155, 0);
        local v181 = bit32.bxor(v176, v180);
        local v182 = bit32.lrotate(v181, 16);
        local v183 = bit32.bor(v165 + v182, 0);
        local v184 = bit32.bxor(v155, v183);
        local v185 = bit32.lrotate(v184, 12);
        v116 = bit32.bor(v180 + v185, 0);
        local v186 = bit32.bxor(v182, v116);
        v131 = bit32.lrotate(v186, 8);
        v126 = bit32.bor(v183 + v131, 0);
        local v187 = bit32.bxor(v185, v126);
        v121 = bit32.lrotate(v187, 7);
        local v188 = bit32.bor(v150 + v167, 0);
        local v189 = bit32.bxor(v140, v188);
        local v190 = bit32.lrotate(v189, 16);
        local v191 = bit32.bor(v177 + v190, 0);
        local v192 = bit32.bxor(v167, v191);
        local v193 = bit32.lrotate(v192, 12);
        v117 = bit32.bor(v188 + v193, 0);
        local v194 = bit32.bxor(v190, v117);
        v128 = bit32.lrotate(v194, 8);
        v127 = bit32.bor(v191 + v128, 0);
        local v195 = bit32.bxor(v193, v127);
        v122 = bit32.lrotate(v195, 7);
        local v196 = bit32.bor(v162 + v179, 0);
        local v197 = bit32.bxor(v152, v196);
        local v198 = bit32.lrotate(v197, 16);
        local v199 = bit32.bor(v141 + v198, 0);
        local v200 = bit32.bxor(v179, v199);
        local v201 = bit32.lrotate(v200, 12);
        v118 = bit32.bor(v196 + v201, 0);
        local v202 = bit32.bxor(v198, v118);
        v129 = bit32.lrotate(v202, 8);
        v124 = bit32.bor(v199 + v129, 0);
        local v203 = bit32.bxor(v201, v124);
        v123 = bit32.lrotate(v203, 7);
        local v204 = bit32.bor(v174 + v143, 0);
        local v205 = bit32.bxor(v164, v204);
        local v206 = bit32.lrotate(v205, 16);
        local v207 = bit32.bor(v153 + v206, 0);
        local v208 = bit32.bxor(v143, v207);
        local v209 = bit32.lrotate(v208, 12);
        v119 = bit32.bor(v204 + v209, 0);
        local v210 = bit32.bxor(v206, v119);
        v130 = bit32.lrotate(v210, 8);
        v125 = bit32.bor(v207 + v130, 0);
        local v211 = bit32.bxor(v209, v125);
        v120 = bit32.lrotate(v211, 7);
    end;
    local v212 = buffer.readu32(p114, 0) + v116;
    buffer.writeu32(p114, 0, v212);
    local v213 = buffer.readu32(p114, 4) + v117;
    buffer.writeu32(p114, 4, v213);
    local v214 = buffer.readu32(p114, 8) + v118;
    buffer.writeu32(p114, 8, v214);
    local v215 = buffer.readu32(p114, 12) + v119;
    buffer.writeu32(p114, 12, v215);
    local v216 = buffer.readu32(p114, 16) + v120;
    buffer.writeu32(p114, 16, v216);
    local v217 = buffer.readu32(p114, 20) + v121;
    buffer.writeu32(p114, 20, v217);
    local v218 = buffer.readu32(p114, 24) + v122;
    buffer.writeu32(p114, 24, v218);
    local v219 = buffer.readu32(p114, 28) + v123;
    buffer.writeu32(p114, 28, v219);
    local v220 = buffer.readu32(p114, 32) + v124;
    buffer.writeu32(p114, 32, v220);
    local v221 = buffer.readu32(p114, 36) + v125;
    buffer.writeu32(p114, 36, v221);
    local v222 = buffer.readu32(p114, 40) + v126;
    buffer.writeu32(p114, 40, v222);
    local v223 = buffer.readu32(p114, 44) + v127;
    buffer.writeu32(p114, 44, v223);
    local v224 = buffer.readu32(p114, 48) + v128;
    buffer.writeu32(p114, 48, v224);
    local v225 = buffer.readu32(p114, 52) + v129;
    buffer.writeu32(p114, 52, v225);
    local v226 = buffer.readu32(p114, 56) + v130;
    buffer.writeu32(p114, 56, v226);
    local v227 = buffer.readu32(p114, 60) + v131;
    buffer.writeu32(p114, 60, v227);
end;
local function u234(p229, p230, p231) --[[ Line: 342 ]]
    -- upvalues: u103 (copy), u111 (copy)
    local v232 = buffer.len(p229);
    local v233 = buffer.create(64);
    buffer.copy(v233, 0, v232 == 32 and u103 or u111, 0, 16);
    buffer.copy(v233, 16, p229, 0, (math.min(v232, 16)));
    if v232 == 32 then
        buffer.copy(v233, 32, p229, 16, 16);
    else
        buffer.copy(v233, 32, p229, 0, 16);
    end;
    buffer.writeu32(v233, 48, p231);
    buffer.copy(v233, 52, p230, 0, 12);
    return v233;
end;
function u104.ChaCha20(p235, p236, p237, p238, p239) --[[ Line: 363 ]]
    -- upvalues: u234 (copy), u228 (copy)
    if p235 == nil then
        error("Data cannot be nil", 2);
    end;
    if typeof(p235) ~= "buffer" then
        error(`Data must be a buffer, got {typeof(p235)}`, 2);
    end;
    if p236 == nil then
        error("Key cannot be nil", 2);
    end;
    if typeof(p236) ~= "buffer" then
        error(`Key must be a buffer, got {typeof(p236)}`, 2);
    end;
    local v240 = buffer.len(p236);
    if v240 ~= 16 and v240 ~= 32 then
        error(`Key must be {16} or {32} bytes long, got {v240} bytes`, 2);
    end;
    if p237 == nil then
        error("Nonce cannot be nil", 2);
    end;
    if typeof(p237) ~= "buffer" then
        error(`Nonce must be a buffer, got {typeof(p237)}`, 2);
    end;
    local v241 = buffer.len(p237);
    if v241 ~= 12 then
        error(`Nonce must be exactly {12} bytes long, got {v241} bytes`, 2);
    end;
    if p238 then
        if typeof(p238) ~= "number" then
            error(`Counter must be a number, got {typeof(p238)}`, 2);
        end;
        if p238 < 0 then
            error(`Counter cannot be negative, got {p238}`, 2);
        end;
        if p238 ~= math.floor(p238) then
            error(`Counter must be an integer, got {p238}`, 2);
        end;
        if p238 >= 4294967296 then
            error(`Counter must be less than 2^32, got {p238}`, 2);
        end;
    end;
    if p239 then
        if typeof(p239) ~= "number" then
            error(`Rounds must be a number, got {typeof(p239)}`, 2);
        end;
        if p239 <= 0 then
            error(`Rounds must be positive, got {p239}`, 2);
        end;
        if p239 ~= math.floor(p239) then
            error(`Rounds must be an integer, got {p239}`, 2);
        end;
        if p239 % 2 ~= 0 then
            error(`Rounds must be even, got {p239}`, 2);
        end;
    end;
    local v242 = p238 or 1;
    local v243 = p239 or 20;
    local v244 = buffer.len(p235);
    if v244 == 0 then
        return buffer.create(0);
    end;
    local v245 = buffer.create(v244);
    local v246 = u234(p236, p237, v242);
    local v247 = buffer.create(64);
    buffer.copy(v247, 0, v246, 0);
    local v248 = 0;
    while v248 < v244 do
        u228(v246, v243);
        local v249 = math.min(64, v244 - v248);
        local v250 = v249 % 4;
        for v251 = 0, v249 - v250 - 1, 4 do
            local v252 = buffer.readu32(p235, v248 + v251);
            local v253 = buffer.readu32(v246, v251);
            local v254 = v248 + v251;
            local v255 = bit32.bxor(v252, v253);
            buffer.writeu32(v245, v254, v255);
        end;
        for v256 = v249 - v250, v249 - 1 do
            local v257 = buffer.readu8(p235, v248 + v256);
            local v258 = buffer.readu8(v246, v256);
            local v259 = v248 + v256;
            local v260 = bit32.bxor(v257, v258);
            buffer.writeu8(v245, v259, v260);
        end;
        v248 = v248 + v249;
        v242 = v242 + 1;
        buffer.copy(v246, 0, v247, 0);
        buffer.writeu32(v246, 48, v242);
    end;
    return v245;
end;
function u104.HChaCha20(p261, p262, p263) --[[ Line: 477 ]]
    -- upvalues: u103 (copy), u111 (copy)
    if p261 == nil then
        error("Key cannot be nil", 2);
    end;
    if typeof(p261) ~= "buffer" then
        error(`Key must be a buffer, got {typeof(p261)}`, 2);
    end;
    local v264 = buffer.len(p261);
    if v264 ~= 16 and v264 ~= 32 then
        error(`Key must be {16} or {32} bytes long, got {v264} bytes`, 2);
    end;
    if p262 == nil then
        error("Nonce cannot be nil", 2);
    end;
    if typeof(p262) ~= "buffer" then
        error(`Nonce must be a buffer, got {typeof(p262)}`, 2);
    end;
    local v265 = buffer.len(p262);
    if v265 ~= 16 then
        error(`HChaCha20 requires a 16-byte nonce, got {v265} bytes`, 2);
    end;
    if p263 then
        if typeof(p263) ~= "number" then
            error(`Rounds must be a number, got {typeof(p263)}`, 2);
        end;
        if p263 <= 0 then
            error(`Rounds must be positive, got {p263}`, 2);
        end;
        if p263 ~= math.floor(p263) then
            error(`Rounds must be an integer, got {p263}`, 2);
        end;
        if p263 % 2 ~= 0 then
            error(`Rounds must be even, got {p263}`, 2);
        end;
    end;
    local v266 = p263 or 20;
    local v267;
    if v264 == 32 then
        v267 = p261;
    else
        v267 = buffer.create(32);
        buffer.copy(v267, 0, p261, 0, 16);
        buffer.copy(v267, 16, p261, 0, 16);
    end;
    local v268 = buffer.len(v267) == 32 and u103 or u111;
    local v269 = buffer.create(64);
    buffer.copy(v269, 0, v268, 0, 16);
    buffer.copy(v269, 16, v267, 0, 16);
    buffer.copy(v269, 32, v267, 16, 16);
    buffer.copy(v269, 48, p262, 0, 16);
    local v270 = buffer.readu32(v269, 0);
    local v271 = buffer.readu32(v269, 4);
    local v272 = buffer.readu32(v269, 8);
    local v273 = buffer.readu32(v269, 12);
    local v274 = buffer.readu32(v269, 16);
    local v275 = buffer.readu32(v269, 20);
    local v276 = buffer.readu32(v269, 24);
    local v277 = buffer.readu32(v269, 28);
    local v278 = buffer.readu32(v269, 32);
    local v279 = buffer.readu32(v269, 36);
    local v280 = buffer.readu32(v269, 40);
    local v281 = buffer.readu32(v269, 44);
    local v282 = buffer.readu32(v269, 48);
    local v283 = buffer.readu32(v269, 52);
    local v284 = buffer.readu32(v269, 56);
    local v285 = buffer.readu32(v269, 60);
    for v286 = 1, v266 do
        if v286 % 2 == 1 then
            local v287 = bit32.bor(v270 + v274, 0);
            local v288 = bit32.bxor(v282, v287);
            local v289 = bit32.lrotate(v288, 16);
            local v290 = bit32.bor(v278 + v289, 0);
            local v291 = bit32.bxor(v274, v290);
            local v292 = bit32.lrotate(v291, 12);
            v270 = bit32.bor(v287 + v292, 0);
            local v293 = bit32.bxor(v289, v270);
            v282 = bit32.lrotate(v293, 8);
            v278 = bit32.bor(v290 + v282, 0);
            local v294 = bit32.bxor(v292, v278);
            v274 = bit32.lrotate(v294, 7);
            local v295 = bit32.bor(v271 + v275, 0);
            local v296 = bit32.bxor(v283, v295);
            local v297 = bit32.lrotate(v296, 16);
            local v298 = bit32.bor(v279 + v297, 0);
            local v299 = bit32.bxor(v275, v298);
            local v300 = bit32.lrotate(v299, 12);
            v271 = bit32.bor(v295 + v300, 0);
            local v301 = bit32.bxor(v297, v271);
            v283 = bit32.lrotate(v301, 8);
            v279 = bit32.bor(v298 + v283, 0);
            local v302 = bit32.bxor(v300, v279);
            v275 = bit32.lrotate(v302, 7);
            local v303 = bit32.bor(v272 + v276, 0);
            local v304 = bit32.bxor(v284, v303);
            local v305 = bit32.lrotate(v304, 16);
            local v306 = bit32.bor(v280 + v305, 0);
            local v307 = bit32.bxor(v276, v306);
            local v308 = bit32.lrotate(v307, 12);
            v272 = bit32.bor(v303 + v308, 0);
            local v309 = bit32.bxor(v305, v272);
            v284 = bit32.lrotate(v309, 8);
            v280 = bit32.bor(v306 + v284, 0);
            local v310 = bit32.bxor(v308, v280);
            v276 = bit32.lrotate(v310, 7);
            local v311 = bit32.bor(v273 + v277, 0);
            local v312 = bit32.bxor(v285, v311);
            local v313 = bit32.lrotate(v312, 16);
            local v314 = bit32.bor(v281 + v313, 0);
            local v315 = bit32.bxor(v277, v314);
            local v316 = bit32.lrotate(v315, 12);
            v273 = bit32.bor(v311 + v316, 0);
            local v317 = bit32.bxor(v313, v273);
            v285 = bit32.lrotate(v317, 8);
            v281 = bit32.bor(v314 + v285, 0);
            local v318 = bit32.bxor(v316, v281);
            v277 = bit32.lrotate(v318, 7);
        else
            local v319 = bit32.bor(v270 + v275, 0);
            local v320 = bit32.bxor(v285, v319);
            local v321 = bit32.lrotate(v320, 16);
            local v322 = bit32.bor(v280 + v321, 0);
            local v323 = bit32.bxor(v275, v322);
            local v324 = bit32.lrotate(v323, 12);
            v270 = bit32.bor(v319 + v324, 0);
            local v325 = bit32.bxor(v321, v270);
            v285 = bit32.lrotate(v325, 8);
            v280 = bit32.bor(v322 + v285, 0);
            local v326 = bit32.bxor(v324, v280);
            v275 = bit32.lrotate(v326, 7);
            local v327 = bit32.bor(v271 + v276, 0);
            local v328 = bit32.bxor(v282, v327);
            local v329 = bit32.lrotate(v328, 16);
            local v330 = bit32.bor(v281 + v329, 0);
            local v331 = bit32.bxor(v276, v330);
            local v332 = bit32.lrotate(v331, 12);
            v271 = bit32.bor(v327 + v332, 0);
            local v333 = bit32.bxor(v329, v271);
            v282 = bit32.lrotate(v333, 8);
            v281 = bit32.bor(v330 + v282, 0);
            local v334 = bit32.bxor(v332, v281);
            v276 = bit32.lrotate(v334, 7);
            local v335 = bit32.bor(v272 + v277, 0);
            local v336 = bit32.bxor(v283, v335);
            local v337 = bit32.lrotate(v336, 16);
            local v338 = bit32.bor(v278 + v337, 0);
            local v339 = bit32.bxor(v277, v338);
            local v340 = bit32.lrotate(v339, 12);
            v272 = bit32.bor(v335 + v340, 0);
            local v341 = bit32.bxor(v337, v272);
            v283 = bit32.lrotate(v341, 8);
            v278 = bit32.bor(v338 + v283, 0);
            local v342 = bit32.bxor(v340, v278);
            v277 = bit32.lrotate(v342, 7);
            local v343 = bit32.bor(v273 + v274, 0);
            local v344 = bit32.bxor(v284, v343);
            local v345 = bit32.lrotate(v344, 16);
            local v346 = bit32.bor(v279 + v345, 0);
            local v347 = bit32.bxor(v274, v346);
            local v348 = bit32.lrotate(v347, 12);
            v273 = bit32.bor(v343 + v348, 0);
            local v349 = bit32.bxor(v345, v273);
            v284 = bit32.lrotate(v349, 8);
            v279 = bit32.bor(v346 + v284, 0);
            local v350 = bit32.bxor(v348, v279);
            v274 = bit32.lrotate(v350, 7);
        end;
    end;
    local v351 = buffer.create(32);
    buffer.writeu32(v351, 0, v270);
    buffer.writeu32(v351, 4, v271);
    buffer.writeu32(v351, 8, v272);
    buffer.writeu32(v351, 12, v273);
    buffer.writeu32(v351, 16, v282);
    buffer.writeu32(v351, 20, v283);
    buffer.writeu32(v351, 24, v284);
    buffer.writeu32(v351, 28, v285);
    return v351;
end;
function u104.XChaCha20(p352, p353, p354, p355, p356) --[[ Line: 610 ]]
    -- upvalues: u104 (copy)
    if p354 == nil then
        error("Nonce cannot be nil", 2);
    end;
    if typeof(p354) ~= "buffer" then
        error(`Nonce must be a buffer, got {typeof(p354)}`, 2);
    end;
    local v357 = buffer.len(p354);
    if v357 ~= 24 then
        error(`XChaCha20 requires a 24-byte nonce, got {v357} bytes`, 2);
    end;
    local l__HChaCha20__1 = u104.HChaCha20;
    local v358 = buffer.create(16);
    buffer.copy(v358, 0, p354, 0, 16);
    local v359 = l__HChaCha20__1(p353, v358, p356);
    local v360 = buffer.create(12);
    buffer.copy(v360, 4, p354, 16, 8);
    return u104.ChaCha20(p352, v359, v360, p355, p356);
end;
local v361 = {
    ChaCha20 = u104.ChaCha20,
    XChaCha20 = u104.XChaCha20,
    Poly1305 = u108
};
local function u370(p362, p363) --[[ Line: 657 ]]
    local v364 = buffer.len(p362);
    if v364 ~= buffer.len(p363) then
        return false;
    end;
    local v365 = 0;
    for v366 = 0, v364 - 1 do
        local v367 = buffer.readu8(p362, v366);
        local v368 = buffer.readu8(p363, v366);
        local v369 = bit32.bxor(v367, v368);
        v365 = bit32.bor(v365, v369);
    end;
    return v365 == 0;
end;
local function u381(p371, p372) --[[ Line: 675 ]]
    local v373 = buffer.len(p371);
    local v374 = buffer.len(p372);
    local v375 = -v373 % 16;
    local v376 = -v374 % 16;
    local v377 = buffer.create(v373 + v375 + v374 + v376 + 16);
    local v378 = 0;
    buffer.copy(v377, v378, p371, 0, v373);
    local v379 = v378 + (v373 + v375);
    buffer.copy(v377, v379, p372, 0, v374);
    local v380 = v379 + (v374 + v376);
    buffer.writeu32(v377, v380, v373);
    buffer.writeu32(v377, v380 + 8, v374);
    return v377;
end;
function v361.Encrypt(p382, p383, p384, p385, p386, p387) --[[ Line: 703 ]]
    -- upvalues: u104 (copy), u381 (copy), u108 (copy)
    if p382 == nil then
        error("Message cannot be nil", 2);
    end;
    if typeof(p382) ~= "buffer" then
        error(`Message must be a buffer, got {typeof(p382)}`, 2);
    end;
    if buffer.len(p382) == 0 then
        error("Message cannot be empty", 2);
    end;
    if p383 == nil then
        error("Key cannot be nil", 2);
    end;
    if typeof(p383) ~= "buffer" then
        error(`Key must be a buffer, got {typeof(p383)}`, 2);
    end;
    local v388 = buffer.len(p383);
    if v388 ~= 32 then
        error(`Key must be exactly {32} bytes long, got {v388} bytes`, 2);
    end;
    if p384 == nil then
        error("Nonce cannot be nil", 2);
    end;
    if typeof(p384) ~= "buffer" then
        error(`Nonce must be a buffer, got {typeof(p384)}`, 2);
    end;
    local v389 = buffer.len(p384);
    local v390 = p387 and 24 or 12;
    if v389 ~= v390 then
        error(`Nonce must be exactly {v390} bytes long, got {v389} bytes`, 2);
    end;
    if p385 and typeof(p385) ~= "buffer" then
        error(`AdditionalAuthData must be a buffer, got {typeof(p385)}`, 2);
    end;
    if p386 then
        if typeof(p386) ~= "number" then
            error(`Rounds must be a number, got {typeof(p386)}`, 2);
        end;
        if p386 <= 0 then
            error(`Rounds must be positive, got {p386}`, 2);
        end;
        if p386 % 2 ~= 0 then
            error(`Rounds must be even, got {p386}`, 2);
        end;
    end;
    local v391 = p386 or 20;
    local v392 = p385 or buffer.create(0);
    local v393 = v391 or 20;
    local v394 = buffer.create(32);
    local v395;
    if p387 then
        v395 = u104.XChaCha20;
    else
        v395 = u104.ChaCha20;
    end;
    local v396 = v395(v394, p383, p384, 0, v393);
    local v397;
    if p387 then
        v397 = u104.XChaCha20;
    else
        v397 = u104.ChaCha20;
    end;
    local v398 = v397(p382, p383, p384, 1, v391);
    return v398, u108(u381(v392, v398), v396);
end;
function v361.Decrypt(p399, p400, p401, p402, p403, p404, p405) --[[ Line: 775 ]]
    -- upvalues: u104 (copy), u381 (copy), u108 (copy), u370 (copy)
    if p399 == nil then
        error("Ciphertext cannot be nil", 2);
    end;
    if typeof(p399) ~= "buffer" then
        error(`Ciphertext must be a buffer, got {typeof(p399)}`, 2);
    end;
    if buffer.len(p399) == 0 then
        error("Ciphertext cannot be empty", 2);
    end;
    if p400 == nil then
        error("Key cannot be nil", 2);
    end;
    if typeof(p400) ~= "buffer" then
        error(`Key must be a buffer, got {typeof(p400)}`, 2);
    end;
    local v406 = buffer.len(p400);
    if v406 ~= 32 then
        error(`Key must be exactly {32} bytes long, got {v406} bytes`, 2);
    end;
    if p401 == nil then
        error("Nonce cannot be nil", 2);
    end;
    if typeof(p401) ~= "buffer" then
        error(`Nonce must be a buffer, got {typeof(p401)}`, 2);
    end;
    local v407 = buffer.len(p401);
    local v408 = p405 and 24 or 12;
    if v407 ~= v408 then
        error(`Nonce must be exactly {v408} bytes long, got {v407} bytes`, 2);
    end;
    if p402 == nil then
        error("Tag cannot be nil", 2);
    end;
    if typeof(p402) ~= "buffer" then
        error(`Tag must be a buffer, got {typeof(p402)}`, 2);
    end;
    local v409 = buffer.len(p402);
    if v409 ~= 16 then
        error(`Tag must be exactly {16} bytes long, got {v409} bytes`, 2);
    end;
    if p403 and typeof(p403) ~= "buffer" then
        error(`AdditionalAuthData must be a buffer, got {typeof(p403)}`, 2);
    end;
    if p404 then
        if typeof(p404) ~= "number" then
            error(`Rounds must be a number, got {typeof(p404)}`, 2);
        end;
        if p404 <= 0 then
            error(`Rounds must be positive, got {p404}`, 2);
        end;
        if p404 % 2 ~= 0 then
            error(`Rounds must be even, got {p404}`, 2);
        end;
    end;
    local v410 = p404 or 20;
    local v411 = p403 or buffer.create(0);
    local v412 = v410 or 20;
    local v413 = buffer.create(32);
    local v414;
    if p405 then
        v414 = u104.XChaCha20;
    else
        v414 = u104.ChaCha20;
    end;
    local v415 = v414(v413, p400, p401, 0, v412);
    if not u370(p402, (u108(u381(v411, p399), v415))) then
        return nil;
    end;
    local v416;
    if p405 then
        v416 = u104.XChaCha20;
    else
        v416 = u104.ChaCha20;
    end;
    return v416(p399, p400, p401, 1, v410);
end;
return v361;
