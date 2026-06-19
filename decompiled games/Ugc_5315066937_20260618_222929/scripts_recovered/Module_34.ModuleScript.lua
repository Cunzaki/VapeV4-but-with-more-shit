-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local function u14(p1, p2, p3) --[[ Line: 1 ]]
    local v4 = p2:Dot(p2);
    local v5 = p2:Dot(p3);
    local v6 = p2:Cross(p3);
    local v7 = v6:Cross(p2);
    local v8 = v6:Dot(v6);
    local v9 = p1 * p1 - v8 / v4;
    local v10 = v9 >= 0;
    local v11 = -v7 / v4;
    local v12 = v5 / v4;
    if v9 > 0 then
        local v13 = math.sqrt(v9 / v4);
        v11 = v11 - v13 * p2;
        v12 = v12 - v13;
    end;
    if v11:Dot(v11) == 0 then
        if not v10 then
            print("wtttff");
            v10 = true;
        end;
        v11 = -p2;
    end;
    return v10, v12, v11;
end;
local function u35(p15, p16, p17, p18) --[[ Line: 31 ]]
    local v19 = p16:Dot(p18);
    local v20 = p18:Dot(p18);
    local v21 = p16:Cross(p18);
    local v22 = p17:Cross(p18);
    local v23 = p16:Cross(p17);
    local v24 = v21:Dot(p17);
    local v25 = p18:Cross(v21);
    local v26 = v23:Dot(v21);
    local v27 = v21:Dot(v21);
    local v28 = v22:Dot(v21);
    if v27 ~= 0 then
        local v29 = p15 * p15 - v24 * v24 / v27;
        local v30 = v29 >= 0;
        local v31 = -v24 / v27 * v21;
        local v32 = v28 / v27;
        local v33 = -v26 / v27;
        if v29 > 0 then
            local v34 = math.sqrt(v29 / (v20 * v27));
            v31 = v31 - v34 * v25;
            v32 = v32 - v34 * v20;
            v33 = v33 - v34 * v19;
        end;
        if v31:Dot(v31) == 0 then
            if not v30 then
                print("wtttff");
                v30 = true;
            end;
            v31 = -v25;
        end;
        return v30, v32, v31, v33;
    end;
end;
local function u55(p36, p37, p38, p39, p40) --[[ Line: 72 ]]
    local v41 = p37:Cross(p40);
    local v42 = p39:Cross(p37);
    local v43 = p39:Cross(p40);
    local v44 = v43:Dot(p37);
    local v45 = v43:Dot(p38);
    local v46 = v41:Dot(p38);
    local v47 = v42:Dot(p38);
    local v48 = v43:Dot(v43);
    local v49 = v43:Dot(v41);
    local v50 = v43:Dot(v42);
    local v51 = math.sqrt(v48);
    if v44 ~= 0 then
        local v52, v53, v54;
        if v44 < 0 then
            v52 = (v45 + p36 * v51) / v44;
            v53 = (v46 + p36 * v49 / v51) / v44;
            v54 = (v47 + p36 * v50 / v51) / v44;
        else
            v43 = -v43;
            v52 = (v45 - p36 * v51) / v44;
            v53 = (v46 - p36 * v49 / v51) / v44;
            v54 = (v47 - p36 * v50 / v51) / v44;
        end;
        return true, v52, v43, v53, v54;
    end;
end;
local function u63(p56, p57, p58, p59) --[[ Line: 108 ]]
    -- upvalues: u14 (copy)
    local v60, v61, v62 = u14(p56, p57, p59 - p58);
    return v60, v61, v62, p58, p59;
end;
local function u78(p64, p65, p66, p67, p68, p69) --[[ Line: 117 ]]
    -- upvalues: u35 (copy), u14 (copy)
    local v70 = p67 - p66;
    local v71, v72, v73, v74 = u35(p64, p65, v70, p69 - p68 - v70);
    if v72 and v74 >= 0 then
        return v71, v72, v73, p66, p67, p68, p69;
    end;
    local v75, v76, v77 = u14(p64, p65, v70);
    return v75, v76, v77, p66, p67;
end;
local function u116(p79, p80, p81, p82, p83, p84, p85, p86) --[[ Line: 133 ]]
    -- upvalues: u55 (copy), u35 (copy), u14 (copy)
    local v87 = p82 - p81;
    local v88 = p84 - p83;
    local v89 = p86 - p85;
    local v90 = v88 - v87;
    local v91 = v89 - v87;
    local v92 = v90:Cross(v91);
    local v93 = v90:Cross(p80);
    local v94 = p80:Cross(v91);
    local v95 = v92:Dot(p80);
    local v96 = v92:Dot(v93);
    local v97 = v92:Dot(v94);
    local v98 = v95 ~= 0 and true or v96 > 0;
    local v99 = v95 ~= 0 and true or v97 > 0;
    local v100, v101;
    if v95 == 0 then
        v100 = 0;
        v101 = 0;
    else
        local v102, v103, v104;
        v102, v103, v104, v101, v100 = u55(p79, p80, v87, v90, v91);
        if v103 and (v101 >= 0 and v100 >= 0) then
            return v102, v103, v104, p81, p82, p83, p84, p85, p86;
        end;
    end;
    if v98 and v100 <= 0 then
        local v105, v106, v107, v108 = u35(p79, p80, v87, v90);
        if v106 and v108 >= 0 then
            return v105, v106, v107, p81, p82, p83, p84;
        end;
    end;
    if v99 and v101 <= 0 then
        local v109, v110, v111, v112 = u35(p79, p80, v87, v91);
        if v110 and v112 >= 0 then
            return v109, v110, v111, p81, p82, p85, p86;
        end;
    end;
    local v113, v114, v115 = u14(p79, p80, v87);
    return v113, v114, v115, p81, p82;
end;
local function u174(p117, p118, p119, p120, p121, p122, p123, p124, p125, p126) --[[ Line: 180 ]]
    -- upvalues: u55 (copy), u35 (copy), u14 (copy)
    local v127 = p120 - p119;
    local v128 = p122 - p121;
    local v129 = p124 - p123;
    local v130 = p126 - p125;
    local v131 = v128 - v127;
    local v132 = v129 - v127;
    local v133 = v130 - v127;
    local v134 = v131:Cross(v132);
    local v135 = v132:Cross(v133);
    local v136 = v133:Cross(v131);
    local v137 = v134:Dot(v133);
    local v138 = v134:Dot(p118);
    local v139 = v135:Dot(p118);
    local v140 = v136:Dot(p118);
    local v141;
    if v137 == 0 and v138 ~= 0 or v138 < 0 and v137 < 0 then
        v141 = true;
    elseif v138 > 0 then
        v141 = v137 > 0;
    else
        v141 = false;
    end;
    local v142;
    if v137 == 0 and v139 ~= 0 or v139 < 0 and v137 < 0 then
        v142 = true;
    elseif v139 > 0 then
        v142 = v137 > 0;
    else
        v142 = false;
    end;
    local v143;
    if v137 == 0 and v140 ~= 0 or v140 < 0 and v137 < 0 then
        v143 = true;
    elseif v140 > 0 then
        v143 = v137 > 0;
    else
        v143 = false;
    end;
    local v144 = 0;
    local v145 = 0;
    local v146 = 0;
    local v147 = 0;
    local v148, v149;
    if v141 then
        local v150, v151, v152;
        v150, v151, v152, v148, v149 = u55(p117, p118, v127, v131, v132);
        if v151 and (v148 >= 0 and v149 >= 0) then
            return v150, v151, v152, p119, p120, p121, p122, p123, p124;
        end;
    else
        v149 = 0;
        v148 = 0;
    end;
    if v142 then
        local v153, v154, v155;
        v153, v154, v155, v144, v145 = u55(p117, p118, v127, v132, v133);
        if v154 and (v144 >= 0 and v145 >= 0) then
            return v153, v154, v155, p119, p120, p123, p124, p125, p126;
        end;
    end;
    if v143 then
        local v156, v157, v158;
        v156, v157, v158, v146, v147 = u55(p117, p118, v127, v133, v131);
        if v157 and (v146 >= 0 and v147 >= 0) then
            return v156, v157, v158, p119, p120, p125, p126, p121, p122;
        end;
    end;
    if v141 and v149 <= 0 or v143 and v146 <= 0 then
        local v159, v160, v161, v162 = u35(p117, p118, v127, v131);
        if v160 and v162 >= 0 then
            return v159, v160, v161, p119, p120, p121, p122;
        end;
    end;
    if v141 and v148 <= 0 or v142 and v145 <= 0 then
        local v163, v164, v165, v166 = u35(p117, p118, v127, v132);
        if v164 and v166 >= 0 then
            return v163, v164, v165, p119, p120, p123, p124;
        end;
    end;
    if v143 and v147 <= 0 or v142 and v144 <= 0 then
        local v167, v168, v169, v170 = u35(p117, p118, v127, v133);
        if v168 and v170 >= 0 then
            return v167, v168, v169, p119, p120, p125, p126;
        end;
    end;
    local v171, v172, v173 = u14(p117, p118, v127);
    return v171, v172, v173, p119, p120;
end;
local function u185(p175, p176, p177, p178, p179, p180, p181, p182, p183, p184) --[[ Line: 256 ]]
    -- upvalues: u174 (copy), u116 (copy), u78 (copy), u63 (copy)
    if p183 then
        return u174(p175, p176, p177, p178, p179, p180, p181, p182, p183, p184);
    end;
    if p181 then
        return u116(p175, p176, p177, p178, p179, p180, p181, p182);
    end;
    if p179 then
        return u78(p175, p176, p177, p178, p179, p180);
    end;
    if p177 then
        return u63(p175, p176, p177, p178);
    end;
    error("wtf u doin");
end;
local function u197(p186, p187, p188) --[[ Line: 270 ]]
    local v189 = p187:Cross(p188);
    local v190 = p188:Cross(p186);
    local v191 = p186:Cross(p187);
    local v192 = v189 + v190 + v191;
    local v193 = v192:Dot(v189);
    local v194 = v192:Dot(v190);
    local v195 = v192:Dot(v191);
    local v196 = v193 + v194 + v195;
    return v193 / v196, v194 / v196, v195 / v196;
end;
local function u217(p198, p199, p200, p201, p202, p203, p204, p205) --[[ Line: 309 ]]
    -- upvalues: u197 (copy)
    if p204 then
        local v206, v207, v208 = u197(p199 + p201 - (p198 + p200), p199 + p203 - (p198 + p202), p199 + p205 - (p198 + p204));
        return p198 + v206 * p200 + v207 * p202 + v208 * p204, p199 + v206 * p201 + v207 * p203 + v208 * p205, v206, v207, v208;
    end;
    if p202 then
        local v209 = p199 + p201 - (p198 + p200);
        local v210 = p199 + p203 - (p198 + p202);
        local v211 = v210:Dot(v210 - v209);
        local v212 = v209:Dot(v209 - v210);
        local v213 = v211 + v212;
        local v214 = v211 / v213;
        local v215 = v212 / v213;
        return p198 + v214 * p200 + v215 * p202, p199 + v214 * p201 + v215 * p203, v214, v215;
    end;
    if p200 then
        local _ = p199 + p201 - (p198 + p200);
        local v216 = 1;
        return p198 + v216 * p200, p199 + v216 * p201, v216;
    end;
    error("wtf");
end;
local function u251(p218, p219, p220, p221, p222, p223, p224) --[[ Line: 352 ]]
    -- upvalues: u185 (copy), u217 (copy)
    if (p223 - p220).magnitude == 0 then
        return nil;
    end;
    local v225 = p218(p220 - p223);
    local v226 = p221(p223 - p220);
    local v227 = (1 / 0);
    local v228 = nil;
    local v229 = nil;
    local v230 = nil;
    local v231 = nil;
    local v232 = nil;
    local v233 = nil;
    local v234 = p224 or (1 / 0);
    local v235 = nil;
    local v236 = nil;
    local v237 = nil;
    local v238 = nil;
    local v239 = nil;
    local v240 = nil;
    local v241 = nil;
    local v242 = nil;
    local v243 = nil;
    for v244 = 1, 300 do
        debug.profilebegin("step");
        local v245, v246, v247;
        v245, v246, v247, v228, v229, v231, v230, v232, v233 = u185(p219 + p222, p220 - p223, v225, v226, v228, v229, v231, v230, v232, v233);
        v225 = p218(-v247);
        v226 = p221(v247);
        if v246 ~= v246 then
            debug.profileend();
            break;
        end;
        local v248 = v247:Dot(v226 - v225 - (v229 - v228)) / v247.magnitude;
        if v248 < v227 then
            v243 = v246;
            v242 = v247;
            v241 = v233;
            v240 = v232;
            v239 = v245;
            v238 = v230;
            v237 = v231;
            v236 = v229;
            v235 = v228;
            v227 = v248;
        end;
        if v248 <= v244 * 1e-7 then
            debug.profileend();
            break;
        end;
        if not v245 and v247:Dot(v246 * p220 + v225 - (v246 * p223 + v226)) > (v234 + p219 + p222) * v247.magnitude then
            debug.profileend();
            return nil;
        end;
        debug.profileend();
    end;
    if v239 == nil then
        return nil;
    end;
    local v249, v250 = u217(v243 * p220, v243 * p223, v235, v236, v237, v238, v240, v241);
    local l__unit__1 = v242.unit;
    return v239, v243, v249 + p219 * l__unit__1, -l__unit__1, v250 - p222 * l__unit__1, l__unit__1;
end;
local function u265(u252, u253, u254, p255, p256, u257, u258, u259, p260, p261, p262) --[[ Line: 424 ]]
    -- upvalues: u251 (copy)
    return u251(function(p263) --[[ Name: tempQueryP, Line 429 ]]
        -- upvalues: u254 (copy), u253 (copy), u252 (copy)
        if p263 then
            p263 = u254 * u253:vectorToObjectSpace(p263);
        end;
        return u253 * (u254 * u252(p263));
    end, p255, p256, function(p264) --[[ Name: tempQueryQ, Line 435 ]]
        -- upvalues: u259 (copy), u258 (copy), u257 (copy)
        if p264 then
            p264 = u259 * u258:vectorToObjectSpace(p264);
        end;
        return u258 * (u259 * u257(p264));
    end, p260, p261, p262);
end;
return {
    mesh = function(...) --[[ Name: mesh, Line 463 ]]
        -- upvalues: u251 (copy)
        debug.profilebegin("Sweep");
        local v266, v267, v268, v269, v270, v271 = u251(...);
        debug.profileend();
        return v266, v267, v268, v269, v270, v271;
    end,
    full = function(...) --[[ Name: full, Line 470 ]]
        -- upvalues: u265 (copy)
        debug.profilebegin("Sweep");
        local v272, v273, v274, v275, v276, v277 = u265(...);
        debug.profileend();
        return v272, v273, v274, v275, v276, v277;
    end,
    convexSet = function(...) --[[ Name: convexSet, Line 477 ]]
        -- upvalues: u251 (copy)
        debug.profilebegin("Sweep");
        local v278, v279, v280, v281, v282 = ...;
        local v283, v284, v285, v286, v287, v288 = u251(v278, v278.radius, v279, v280, v280.radius, v281, v282);
        debug.profileend();
        return v283, v284, v285, v286, v287, v288;
    end
};
