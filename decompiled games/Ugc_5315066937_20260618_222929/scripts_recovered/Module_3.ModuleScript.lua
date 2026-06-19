-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local function u3(p1) --[[ Line: 20 ]]
    local l__x__1 = p1.x;
    local l__y__2 = p1.y;
    local l__z__3 = p1.z;
    local v2 = math.min(l__x__1 * l__x__1, l__y__2 * l__y__2, l__z__3 * l__z__3);
    if l__x__1 * l__x__1 == v2 then
        return Vector3.new(l__y__2 * l__y__2 + l__z__3 * l__z__3, -l__x__1 * l__y__2, -l__x__1 * l__z__3);
    elseif l__y__2 * l__y__2 == v2 then
        return Vector3.new(-l__x__1 * l__y__2, l__x__1 * l__x__1 + l__z__3 * l__z__3, -l__y__2 * l__z__3);
    else
        return Vector3.new(-l__x__1 * l__z__3, -l__y__2 * l__z__3, l__x__1 * l__x__1 + l__y__2 * l__y__2);
    end;
end;
local function u7(p4, p5) --[[ Line: 36 ]]
    local v6 = -(p5 - p4);
    return v6.magnitude == 0 and Vector3.new(1, 0, 0) or v6, p4, p5;
end;
local function u17(p8, p9, p10, p11) --[[ Line: 49 ]]
    -- upvalues: u3 (copy)
    local v12 = p9 - p8;
    local v13 = p11 - p10;
    local v14 = -v12;
    local v15 = v13 - v12;
    if v14:Dot(v15) < 0 then
        if v14.magnitude == 0 then
            v14 = u3(v15);
        end;
        return v14, p8, p9;
    end;
    local v16 = v15:Cross(v14):Cross(v15);
    if v16.magnitude == 0 then
        v16 = u3(v15);
    end;
    return v16, p8, p9, p10, p11;
end;
local function u40(p18, p19, p20, p21, p22, p23) --[[ Line: 76 ]]
    local v24 = p19 - p18;
    local v25 = p21 - p20;
    local v26 = p23 - p22;
    local v27 = -v24;
    local v28 = v25 - v24;
    local v29 = v26 - v24;
    local v30 = v28:Cross(v29);
    local v31 = v28:Cross(v27);
    local v32 = v27:Cross(v29);
    local v33 = v30:Dot(v31);
    local v34 = v30:Dot(v32);
    if v33 >= 0 and v34 >= 0 then
        if v30:Dot(v27) < 0 then
            v30 = -v30 or v30;
        end;
        return v30, p18, p19, p20, p21, p22, p23;
    end;
    local v35 = v28:Dot(v28);
    local v36 = v29:Dot(v29);
    local v37 = v33 / (v35 * v29.magnitude);
    local v38 = v34 / (v36 * v28.magnitude);
    if v38 == math.min(v37, v38) then
        v31 = -v32;
        v30 = -v30;
    else
        p23 = p21;
        p22 = p20;
        v29 = v28;
    end;
    if v27:Dot(v29) < 0 then
        if v27.magnitude ~= 0 then
            v30 = v27;
        end;
        return v30, p18, p19;
    end;
    local v39 = v31:Cross(v29);
    if v39.magnitude ~= 0 then
        v30 = v39;
    end;
    return v30, p18, p19, p22, p23;
end;
local function u78(p41, p42, p43, p44, p45, p46, p47, p48) --[[ Line: 138 ]]
    local v49 = p42 - p41;
    local v50 = p44 - p43;
    local v51 = p46 - p45;
    local v52 = p48 - p47;
    local v53 = -v49;
    local v54 = v50 - v49;
    local v55 = v51 - v49;
    local v56 = v52 - v49;
    local v57 = v54:Cross(v55);
    local v58 = v55:Cross(v56);
    local v59 = v56:Cross(v54);
    local v60 = v57:Dot(v56);
    local v61 = v58:Dot(v53);
    local v62 = v59:Dot(v53);
    local v63 = v57:Dot(v53);
    if v61 / v60 >= 0 and (v62 / v60 >= 0 and v63 / v60 >= 0) then
        return Vector3.new(0, 0, 0), p41, p42, p43, p44, p45, p46, p47, p48;
    end;
    local v64 = v60 < 0 and -1 or (v60 > 0 and 1 or 0);
    local v65 = v63 * v64 / v57.magnitude;
    local v66 = v61 * v64 / v58.magnitude;
    local v67 = v62 * v64 / v59.magnitude;
    local v68 = math.min(v65, v66, v67);
    if v66 == v68 then
        v59 = v58;
        v54 = v56;
        v56 = v55;
        p44 = p48;
        p48 = p46;
        p43 = p47;
        p47 = p45;
    elseif v67 ~= v68 then
        p47 = p43;
        p43 = p45;
        v59 = v57;
        v56 = v54;
        v54 = v55;
        p48 = p44;
        p44 = p46;
    end;
    local v69 = v56:Cross(v53);
    local v70 = v53:Cross(v54);
    local v71 = v59:Dot(v69);
    local v72 = v59:Dot(v70);
    if v71 >= 0 and v72 >= 0 then
        return v60 < 0 and v59 and v59 or -v59, p41, p42, p47, p48, p43, p44;
    end;
    local v73 = v56:Dot(v56);
    local v74 = v54:Dot(v54);
    local v75 = v71 / (v73 * v54.magnitude);
    local v76 = v72 / (v74 * v56.magnitude);
    if v76 == math.min(v75, v76) then
        v69 = -v70;
        v59 = -v59;
    else
        p44 = p48;
        p43 = p47;
        v54 = v56;
    end;
    if v53:Dot(v54) < 0 then
        if v53.magnitude == 0 then
            v53 = v60 < 0 and v59 and v59 or -v59;
        end;
        return v53, p41, p42;
    end;
    local v77 = v69:Cross(v54);
    if v77.magnitude == 0 then
        v77 = v60 < 0 and v59 and v59 or -v59;
    end;
    return v77, p41, p42, p43, p44;
end;
local function u94(p79, p80, p81, p82) --[[ Line: 226 ]]
    local v83 = p80 - p79;
    local v84 = p81 - p79;
    local v85 = p82 - p79;
    local v86 = v84:Cross(v85);
    local v87 = v85:Cross(v83);
    local v88 = v83:Cross(v84);
    local v89 = v86 + v87 + v88;
    local v90 = v89:Dot(v86);
    local v91 = v89:Dot(v87);
    local v92 = v89:Dot(v88);
    local v93 = v90 + v91 + v92;
    return v90 / v93, v91 / v93, v92 / v93;
end;
local function u115(p95, p96, p97, p98, p99, p100, p101) --[[ Line: 265 ]]
    -- upvalues: u94 (copy)
    if p100 then
        local v102, v103, v104 = u94(p95, p97 - p96, p99 - p98, p101 - p100);
        return v102 * p96 + v103 * p98 + v104 * p100, v102 * p97 + v103 * p99 + v104 * p101, v102, v103, v104;
    end;
    if p98 then
        local v105 = p97 - p96;
        local v106 = p99 - p98;
        local v107 = v105 - p95;
        local v108 = v106 - p95;
        local v109 = v108:Dot(v108 - v107);
        local v110 = v107:Dot(v107 - v108);
        local v111 = v109 + v110;
        local v112 = v109 / v111;
        local v113 = v110 / v111;
        return v112 * p96 + v113 * p98, v112 * p97 + v113 * p99, v112, v113;
    end;
    if p96 then
        local _ = p97 - p96 - p95;
        local v114 = 1;
        return v114 * p96, v114 * p97, v114;
    end;
    error("wtf");
end;
local function u124(p116, p117, p118, p119, p120, p121, p122, p123) --[[ Line: 298 ]]
    -- upvalues: u78 (copy), u40 (copy), u17 (copy), u7 (copy)
    if p122 then
        return u78(p116, p117, p118, p119, p120, p121, p122, p123);
    end;
    if p120 then
        return u40(p116, p117, p118, p119, p120, p121);
    end;
    if p118 then
        return u17(p116, p117, p118, p119);
    end;
    if p116 then
        return u7(p116, p117);
    end;
    error("can a simplex have 0 points?");
end;
local u125 = {};
local u126 = {};
local u127 = {};
local u128 = {};
local u129 = {};
local function u138(p130, p131, p132) --[[ Line: 360 ]]
    -- upvalues: u126 (copy), u125 (copy), u127 (copy), u128 (copy), u129 (copy)
    local v133 = u126[p130] - u125[p130];
    local l__unit__4 = (u126[p131] - u125[p131] - v133):Cross(u126[p132] - u125[p132] - v133).unit;
    local v134 = l__unit__4:Dot(v133);
    u127[p131 + (p131 + p132) * (p131 + p132 + 1) / 2] = p130;
    u127[p132 + (p132 + p130) * (p132 + p130 + 1) / 2] = p131;
    u127[p130 + (p130 + p131) * (p130 + p131 + 1) / 2] = p132;
    if p130 < p131 then
        if p130 < p132 then
            local v135 = p131;
            p131 = p132;
            p132 = p130;
            p130 = v135;
        end;
    elseif p131 < p132 then
        local v136 = p131;
        p131 = p130;
        p130 = p132;
        p132 = v136;
    end;
    local v137 = p132 + 65536 * p130 + 4294967296 * p131;
    u128[v137] = l__unit__4;
    u129[v137] = v134;
end;
local function u152(p139, p140, p141) --[[ Line: 386 ]]
    -- upvalues: u127 (copy), u126 (copy), u125 (copy), u128 (copy), u129 (copy), u152 (copy), u138 (copy)
    local v142 = u127[p139 + (p139 + p140) * (p139 + p140 + 1) / 2];
    local v143 = u127[p140 + (p140 + p139) * (p140 + p139 + 1) / 2];
    if v142 then
        local v144, v145, v146;
        if p139 < p140 then
            if p139 < v142 then
                v144 = v142;
                v145 = p139;
                v146 = p140;
            else
                v144 = p140;
                v145 = v142;
                v146 = p139;
            end;
        elseif p140 < v142 then
            v144 = p139;
            v145 = p140;
            v146 = v142;
        else
            v144 = p140;
            v145 = v142;
            v146 = p139;
        end;
        local v147 = v145 + 65536 * v146 + 4294967296 * v144;
        if u128[v147]:Dot(u126[p141] - u125[p141]) - u129[v147] > 0 then
            u127[p140 + (p140 + v142) * (p140 + v142 + 1) / 2] = nil;
            u127[v142 + (v142 + p139) * (v142 + p139 + 1) / 2] = nil;
            u127[p139 + (p139 + p140) * (p139 + p140 + 1) / 2] = nil;
            local v148, v149, v150;
            if p139 < p140 then
                if p139 < v142 then
                    v148 = v142;
                    v149 = p139;
                    v150 = p140;
                else
                    v148 = p140;
                    v149 = v142;
                    v150 = p139;
                end;
            elseif p140 < v142 then
                v148 = p139;
                v149 = p140;
                v150 = v142;
            else
                v148 = p140;
                v149 = v142;
                v150 = p139;
            end;
            local v151 = v149 + 65536 * v150 + 4294967296 * v148;
            u128[v151] = nil;
            u129[v151] = nil;
            u152(p140, p139, p141);
            u152(p139, v142, p141);
            u152(v142, p140, p141);
        elseif v143 then
        else
            u138(p140, p139, p141);
        end;
    end;
end;
local function u181(p153, p154, p155, p156, p157, p158, p159, p160, p161, p162, p163) --[[ Line: 417 ]]
    -- upvalues: u125 (copy), u126 (copy), u128 (copy), u129 (copy), u127 (copy), u138 (copy), u152 (copy)
    table.clear(u125);
    table.clear(u126);
    table.clear(u128);
    table.clear(u129);
    table.clear(u127);
    local v164 = p156 - p155;
    local v165 = p158 - p157;
    local v166 = p160 - p159;
    local v167 = p162 - p161;
    if (v164 - v167):Cross(v165 - v167):Dot(v166 - v167) / 6 < 0 then
        local v168 = p158;
        p158 = p160;
        p160 = p162;
        p162 = p156;
        p156 = v168;
        v168 = p161;
        p161 = p155;
        p155 = p157;
        p157 = p159;
        p159 = v168;
    end;
    u125[1] = p155;
    u125[2] = p157;
    u125[3] = p159;
    u125[4] = p161;
    u126[1] = p156;
    u126[2] = p158;
    u126[3] = p160;
    u126[4] = p162;
    u138(1, 2, 3);
    u138(4, 3, 2);
    u138(4, 2, 1);
    u138(4, 1, 3);
    for _ = 1, 100 do
        local v169 = (1 / 0);
        local v170 = nil;
        for v171, v172 in next, u129 do
            if v172 < v169 then
                v170 = v171;
                v169 = v172;
            end;
        end;
        local v173 = u128[v170];
        local v174 = u129[v170];
        local v175 = p153(-v173);
        local v176 = p154(v173);
        local v177 = v170 % 65536;
        local v178 = (v170 - v177) / 65536;
        local v179 = v178 % 65536;
        local v180 = (v178 - v179) / 65536;
        if v173:Dot(v176 - v175) - v174 < p163 then
            return v173, v174, u125[v177], u126[v177], u125[v179], u126[v179], u125[v180], u126[v180];
        end;
        table.insert(u125, v175);
        table.insert(u126, v176);
        u152(v177, v179, #u125);
    end;
    return nil;
end;
local function u223(p182, p183, p184, p185, p186, p187) --[[ Line: 497 ]]
    -- upvalues: u124 (copy), u181 (copy), u115 (copy)
    local v188 = p184() - p182();
    local v189 = p182(v188);
    local v190 = p184(-v188);
    local v191 = nil;
    local v192 = nil;
    local v193 = nil;
    local v194 = nil;
    local v195 = nil;
    local v196 = nil;
    local v197 = p187 and 0 or (p186 or (1 / 0));
    for _ = 1, 100 do
        local v198, v199, v200;
        v198, v195, v196, v191, v192, v193, v194, v199, v200 = u124(v189, v190, v195, v196, v191, v192, v193, v194);
        local v201, v202, v203, v204;
        if v199 then
            v201 = v196 - v195;
            v202 = v192 - v191;
            v203 = v194 - v193;
            v204 = v200 - v199;
        elseif v193 then
            v201 = v196 - v195;
            v202 = v192 - v191;
            v203 = v194 - v193;
            v204 = nil;
        elseif v191 then
            v201 = v196 - v195;
            v202 = v192 - v191;
            v203 = nil;
            v204 = nil;
        elseif v195 then
            v201 = v196 - v195;
            v203 = nil;
            v204 = nil;
            v202 = nil;
        else
            error("what");
            v203 = nil;
            v204 = nil;
            v201 = nil;
            v202 = nil;
        end;
        if v201 and (v202 and (v203 and v204)) then
            if p187 then
                return true;
            end;
            local v205, v206, v207, v208, v209, v210, v211, v212 = u181(p182, p184, v195, v196, v191, v192, v193, v194, v199, v200, 0.00001);
            if not v205 then
                return nil;
            end;
            local v213, v214 = u115(Vector3.new(0, 0, 0), v207, v208, v209, v210, v211, v212);
            return true, -v206 - p183 - p185, v213 - p183 * v205, -v205, v214 + p185 * v205, v205;
        end;
        v189 = p182(-v198);
        v190 = p184(v198);
        local v215 = v190 - v189;
        if -v198:Dot(v215) > (v197 + p183 + p185) * v198.magnitude then
            return false;
        end;
        local v216, v217, v218, v219, v220;
        if v198:Dot(v215 - v201) <= 0 then
            v216 = v198.unit;
            v217 = v201:Dot(v216);
            v218 = -v217 < p183 + p185;
            if p187 then
                return v218;
            end;
            if -v217 > v197 + p183 + p185 then
                return false;
            end;
            v219, v220 = u115(Vector3.new(0, 0, 0), v195, v196, v191, v192, v193, v194);
            return v218, -v217 - p183 - p185, v219 - p183 * v216, -v216, v220 + p185 * v216, v216;
        end;
        local v221;
        if v203 then
            local v222 = (v201 - v215):Cross(v202 - v215):Dot(v203 - v215);
            v221 = math.abs(v222);
        elseif v202 then
            v221 = (v201 - v215):Cross(v202 - v215).magnitude;
        else
            v221 = not v201 and 1 or (v201 - v215).magnitude;
        end;
        if v221 < 1e-6 then
            v216 = v198.unit;
            v217 = v201:Dot(v216);
            v218 = -v217 < p183 + p185;
            if p187 then
                return v218;
            end;
            if -v217 > v197 + p183 + p185 then
                return false;
            end;
            v219, v220 = u115(Vector3.new(0, 0, 0), v195, v196, v191, v192, v193, v194);
            return v218, -v217 - p183 - p185, v219 - p183 * v216, -v216, v220 + p185 * v216, v216;
        end;
    end;
    return nil;
end;
local function u236(u224, u225, u226, p227, u228, u229, u230, p231, p232, p233) --[[ Line: 557 ]]
    -- upvalues: u223 (copy)
    return u223(function(p234) --[[ Name: tempQueryP, Line 562 ]]
        -- upvalues: u226 (copy), u225 (copy), u224 (copy)
        if p234 then
            p234 = u226 * u225:vectorToObjectSpace(p234);
        end;
        return u225 * (u226 * u224(p234));
    end, p227, function(p235) --[[ Name: tempQueryQ, Line 568 ]]
        -- upvalues: u230 (copy), u229 (copy), u228 (copy)
        if p235 then
            p235 = u230 * u229:vectorToObjectSpace(p235);
        end;
        return u229 * (u230 * u228(p235));
    end, p231, p232, p233);
end;
return {
    difference = function(p237, p238, p239, p240, p241, p242) --[[ Name: difference, Line 604 ]]
        -- upvalues: u223 (copy)
        debug.profilebegin("MinimumDifference");
        local v243, v244, v245, v246, v247, v248 = u223(p237, p238, p239, p240, p241, p242);
        debug.profileend();
        return v243, v244, v245, v246, v247, v248;
    end,
    differenceConvexSet = function(p249, p250, p251, p252) --[[ Name: differenceConvexSet, Line 611 ]]
        -- upvalues: u223 (copy)
        debug.profilebegin("MinimumDifference");
        local v253, v254, v255, v256, v257, v258 = u223(p249, p249.radius, p250, p250.radius, p251, p252);
        debug.profileend();
        return v253, v254, v255, v256, v257, v258;
    end,
    intersectsFull = function(...) --[[ Name: intersectsFull, Line 618 ]]
        -- upvalues: u236 (copy)
        debug.profilebegin("intersectsFull");
        local v259, v260, v261, v262, v263, v264, v265, v266, v267 = ...;
        local v268 = u236(v259, v260, v261, v262, v263, v264, v265, v266, v267, true);
        debug.profileend();
        return v268;
    end,
    differenceFull = function(...) --[[ Name: differenceFull, Line 625 ]]
        -- upvalues: u236 (copy)
        debug.profilebegin("differenceFull");
        local v269, v270, v271, v272, v273, v274 = u236(...);
        debug.profileend();
        return v269, v270, v271, v272, v273, v274;
    end
};
