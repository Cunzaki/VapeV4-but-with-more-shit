-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local function u11(p1, p2, p3, p4, p5, p6) --[[ Line: 80 ]]
    local v7 = p1:Dot(p3);
    local v8 = p4:Dot(p6);
    local v9 = p2:Cross(p5);
    local v10 = v9:Dot((p1:Cross(p4)));
    if math.abs(v10) >= 0.0001 then
        return (v7 * p4:Cross(v9) + v8 * v9:Cross(p1)) / v10;
    end;
end;
local function u22(p12, _, p13, p14, _, p15, p16, _, p17) --[[ Line: 95 ]]
    local v18 = p12:Dot(p13);
    local v19 = p14:Dot(p15);
    local v20 = p16:Dot(p17);
    local v21 = p16:Dot((p12:Cross(p14)));
    if math.abs(v21) >= 0.0001 then
        return (v18 * p14:Cross(p16) + v19 * p16:Cross(p12) + v20 * p12:Cross(p14)) / v21;
    end;
end;
local function u28(p23, p24, p25) --[[ Line: 123 ]]
    local v26 = p24:Cross(p25);
    local v27 = v26:Dot(v26);
    if v27 ~= 0 then
        return v26:Dot(p23:Cross(p25)) / v27, v26:Dot(p24:Cross(p23)) / v27;
    end;
end;
local function u34(p29, p30, p31, p32) --[[ Line: 135 ]]
    local v33 = p30:Cross(p31):Dot(p32);
    if v33 ~= 0 then
        return p29:Cross(p31):Dot(p32) / v33, p30:Cross(p29):Dot(p32) / v33, p30:Cross(p31):Dot(p29) / v33;
    end;
end;
local function u45(p35, p36, p37, p38, p39, p40, p41) --[[ Line: 161 ]]
    -- upvalues: u11 (copy), u28 (copy)
    local v42 = u11(p36, p37, p37, p39, p40, p40);
    if v42 then
        local v43, v44 = u28(v42, p37, p40);
        if v43 and (v43 >= 0 and v44 >= 0) then
            return u11(p36, p37, p38 - p35, p39, p40, p41 - p35) + p35, v42;
        end;
    end;
end;
local function u60(p46, p47, p48, p49, p50, p51, p52, p53, p54, p55) --[[ Line: 172 ]]
    -- upvalues: u22 (copy), u34 (copy)
    local v56 = u22(p47, p48, p48, p50, p51, p51, p53, p54, p54);
    if v56 then
        local v57, v58, v59 = u34(v56, p48, p51, p54);
        if v57 and (v57 >= 0 and (v58 >= 0 and v59 >= 0)) then
            return u22(p47, p48, p49 - p46, p50, p51, p52 - p46, p53, p54, p55 - p46) + p46, v56;
        end;
    end;
end;
local function u76(p61, p62, p63, p64, p65, p66, p67, p68) --[[ Line: 188 ]]
    local v69 = (1 / 0);
    local v70 = nil;
    for v71 in p61 do
        if v71 ~= p66 and (v71 ~= p67 and v71 ~= p68) then
            local v72 = p61[v71];
            local v73 = p62[v71];
            local v74 = p63[v71];
            local v75 = (p64 - v72):Dot(v73) / (v74 - p65):Dot(v73);
            if (p65 - v74):Dot(v73) < -0.0001 and v75 < v69 then
                v70 = v71;
                v69 = v75;
            end;
        end;
    end;
    return v69, v70;
end;
local function u88(p77, p78, p79, p80) --[[ Line: 207 ]]
    -- upvalues: u88 (copy)
    if p80 then
        local v81 = p77:Cross(p78):Dot(p79);
        local v82 = p77:Cross(p78):Dot(p80);
        local v83 = p77:Cross(p79):Dot(p80);
        local v84 = p78:Cross(p79):Dot(p80);
        return v81 * v82 < 0 and (-v81 * v83 < 0 and (v82 * v83 < 0 and (v81 * v84 < 0 and (-v82 * v84 < 0 and v83 * v84 < 0)))) and true or (u88(p77, p78, p79) or u88(p77, p78, p80) or (u88(p77, p79, p80) or u88(p78, p79, p80)));
    elseif p79 then
        if p77:Cross(p78):Dot(p79) ~= 0 then
            return false;
        end;
        local v85 = p77:Cross(p78):Dot(p77:Cross(p79));
        local v86 = p77:Cross(p78):Dot(p78:Cross(p79));
        local v87 = p77:Cross(p79):Dot(p78:Cross(p79));
        return v85 * v86 <= 0 and (v86 * v87 <= 0 and -v87 * v85 <= 0) and true or (u88(p77, p78) or (u88(p77, p79) or u88(p78, p79)));
    elseif p78 then
        if p77:Cross(p78) == Vector3.new(0, 0, 0) then
            return p77:Dot(p78) < 0;
        else
            return false;
        end;
    elseif p77 then
        return false;
    else
        return false;
    end;
end;
local function u166(p89, p90, p91, p92, p93, p94, p95, p96) --[[ Line: 280 ]]
    -- upvalues: u88 (copy), u166 (copy), u60 (copy), u45 (copy)
    local v97 = p89[p93];
    local v98 = p90[p93];
    local v99 = p91[p93];
    local v100 = p89[p94];
    local v101 = p90[p94];
    local v102 = p91[p94];
    local v103 = p89[p95];
    local v104 = p90[p95];
    local v105 = p91[p95];
    local _ = p89[p96];
    local v106 = p90[p96];
    local v107 = p91[p96];
    if u88(v98, v101, v104, v106) then
        return nil, nil, p93, p94, p95, p96;
    elseif v106 then
        local v108, v109, v110, v111, v112 = u166(p89, p90, p91, p92, p93, p94, p95);
        local v113, v114, v115, v116, v117 = u166(p89, p90, p91, p92, p93, p94, p96);
        local v118, v119, v120, v121, v122 = u166(p89, p90, p91, p92, p93, p95, p96);
        local v123;
        if v108 then
            v123 = (v108 - v107):Dot(v106);
        else
            v123 = v108;
        end;
        local v124;
        if v113 then
            v124 = (v113 - v105):Dot(v104);
        else
            v124 = v113;
        end;
        local v125;
        if v118 then
            v125 = (v118 - v102):Dot(v101);
        else
            v125 = v118;
        end;
        local v126 = math.max(0, v123 or 0, v124 or 0, v125 or 0);
        if v126 == v123 then
            return v108, v109, v110, v111, v112;
        end;
        if v126 == v124 then
            return v113, v114, v115, v116, v117;
        end;
        if v126 == v125 then
            return v118, v119, v120, v121, v122;
        end;
    elseif v104 then
        local v127, v128 = u60(p92, v98, v99, v97, v101, v102, v100, v104, v105, v103);
        if v128 then
            return v127, v128, p93, p94, p95;
        else
            local v129, v130 = u45(p92, v98, v99, v97, v101, v102, v100);
            local v131;
            if v130 then
                v131 = (not v104 or (v130 - v105):Dot(v104) >= 0) and true or false;
            else
                v131 = false;
            end;
            if v131 then
                return v129, v130, p93, p94;
            else
                local v132, v133 = u45(p92, v98, v99, v97, v104, v105, v103);
                local v134;
                if v133 then
                    v134 = (not v101 or (v133 - v102):Dot(v101) >= 0) and true or false;
                else
                    v134 = false;
                end;
                if v134 then
                    return v132, v133, p93, p95;
                else
                    local v135 = v98:Dot(v99);
                    local v136 = v98:Dot(v99);
                    local v137;
                    if math.abs(v136) < 0.0001 then
                        v137 = nil;
                    else
                        v137 = v135 * v99 / v136;
                    end;
                    local v138;
                    if v137 then
                        local v139 = v99:Dot(v99);
                        local v140;
                        if v139 == 0 then
                            v140 = nil;
                        else
                            v140 = v99:Dot(v137) / v139;
                        end;
                        if v140 and v140 >= 0 then
                            local v141 = v98:Dot(v97 - p92);
                            local v142 = v98:Dot(v99);
                            local v143;
                            if math.abs(v142) < 0.0001 then
                                v143 = nil;
                            else
                                v143 = v141 * v99 / v142;
                            end;
                            v138 = v143 + p92;
                        else
                            v137 = nil;
                            v138 = nil;
                        end;
                    else
                        v137 = nil;
                        v138 = nil;
                    end;
                    local v144;
                    if v137 and (not v101 or (v137 - v102):Dot(v101) >= 0) then
                        v144 = (not v104 or (v137 - v105):Dot(v104) >= 0) and true or false;
                    else
                        v144 = false;
                    end;
                    if v144 then
                        return v138, v137, p93;
                    else
                        return nil, nil, p93, p94, p95;
                    end;
                end;
            end;
        end;
    elseif v101 then
        local v145, v146 = u45(p92, v98, v99, v97, v101, v102, v100);
        if v146 then
            return v145, v146, p93, p94;
        else
            local v147 = v98:Dot(v99);
            local v148 = v98:Dot(v99);
            local v149;
            if math.abs(v148) < 0.0001 then
                v149 = nil;
            else
                v149 = v147 * v99 / v148;
            end;
            local v150;
            if v149 then
                local v151 = v99:Dot(v99);
                local v152;
                if v151 == 0 then
                    v152 = nil;
                else
                    v152 = v99:Dot(v149) / v151;
                end;
                if v152 and v152 >= 0 then
                    local v153 = v98:Dot(v97 - p92);
                    local v154 = v98:Dot(v99);
                    local v155;
                    if math.abs(v154) < 0.0001 then
                        v155 = nil;
                    else
                        v155 = v153 * v99 / v154;
                    end;
                    v150 = v155 + p92;
                else
                    v149 = nil;
                    v150 = nil;
                end;
            else
                v149 = nil;
                v150 = nil;
            end;
            local v156;
            if v149 then
                v156 = (not v101 or (v149 - v102):Dot(v101) >= 0) and true or false;
            else
                v156 = false;
            end;
            if v156 then
                return v150, v149, p93;
            else
                return nil, nil, p93, p94;
            end;
        end;
    elseif v98 then
        local v157 = v98:Dot(v99);
        local v158 = v98:Dot(v99);
        local v159;
        if math.abs(v158) < 0.0001 then
            v159 = nil;
        else
            v159 = v157 * v99 / v158;
        end;
        local v160;
        if v159 then
            local v161 = v99:Dot(v99);
            local v162;
            if v161 == 0 then
                v162 = nil;
            else
                v162 = v99:Dot(v159) / v161;
            end;
            if v162 and v162 >= 0 then
                local v163 = v98:Dot(v97 - p92);
                local v164 = v98:Dot(v99);
                local v165;
                if math.abs(v164) < 0.0001 then
                    v165 = nil;
                else
                    v165 = v163 * v99 / v164;
                end;
                v160 = v165 + p92;
            else
                v159 = nil;
                v160 = nil;
            end;
        else
            v159 = nil;
            v160 = nil;
        end;
        if v159 then
            return v160, v159, p93;
        else
            return nil, nil, p93;
        end;
    else
        return p92, Vector3.new(0, 0, 0);
    end;
end;
local function u198(p167, p168, p169, p170, p171) --[[ Line: 362 ]]
    -- upvalues: u166 (copy), u76 (copy), u22 (copy), u11 (copy)
    if not next(p167) then
        return p170;
    end;
    local v172, v173, v174, v175, v176, _ = u166(p167, p168, p169, p170);
    local v177 = nil;
    for v178 = 1, 300 do
        local v179, v180 = u76(p167, p168, p169, v172, v173, v174, v175, v176);
        if p171 and v177 then
            local v181 = math.min(0, v179) - v177;
            local _ = p167[v174];
            local v182 = p168[v174];
            local v183 = p169[v174];
            local _ = p167[v175];
            local v184 = p168[v175];
            local v185 = p169[v175];
            local _ = p167[v176];
            local v186 = p168[v176];
            local v187 = p169[v176];
            if v176 then
                local v188, v189, v190 = u22(v182, v183, v183, v184, v185, v185, v186, v187, v187);
                p171[v174] = (p171[v174] or 0) + v181 * v188;
                p171[v175] = (p171[v175] or 0) + v181 * v189;
                p171[v176] = (p171[v176] or 0) + v181 * v190;
            elseif v175 then
                local v191, v192 = u11(v182, v183, v183, v184, v185, v185);
                p171[v174] = (p171[v174] or 0) + v181 * v191;
                p171[v175] = (p171[v175] or 0) + v181 * v192;
            elseif v174 then
                local v193 = v182:Dot(v183);
                local v194 = v182:Dot(v183);
                local v195;
                if math.abs(v194) < 0.0001 then
                    v195 = nil;
                else
                    v195 = v193 * v183 / v194;
                end;
                p171[v174] = (p171[v174] or 0) + v181 * v195;
            end;
        end;
        if v179 >= 0 then
            return v172;
        end;
        local v196 = v172 + v179 * v173;
        local v197;
        v172, v173, v174, v175, v176, v197 = u166(p167, p168, p169, v196, v180, v174, v175, v176);
        if not v173 then
            return v196;
        end;
        if v178 == 300 then
            warn("Incenter.push: Max iteration reached");
            print(p167);
            print(p168);
            print(p169);
            print(p170);
            v177 = v179;
        else
            v177 = v179;
        end;
    end;
    return p170;
end;
return {
    push = function(p199, p200, p201, p202, p203) --[[ Name: push, Line 425 ]]
        -- upvalues: u198 (copy)
        debug.profilebegin("Incenter");
        local v204 = u198(p199, p200, p201, p202, p203);
        debug.profileend();
        return v204;
    end
};
