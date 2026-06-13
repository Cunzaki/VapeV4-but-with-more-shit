-- Decompiled from: ReplicatedStorage.Modules.EditableImageFilters
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    PercentComplete = 0
};
local u2 = os.clock();
function Work()
    -- upvalues: u2 (ref)
    if os.clock() - u2 > 0.03333333333333333 then
        u2 = os.clock();
        task.wait();
        return true;
    end;
end;
function u1.applyGrayscale(p3) --[[ Line: 18 ]]
    -- upvalues: u1 (copy)
    local _ = p3.Size.X;
    local _ = p3.Size.Y;
    local v4 = p3:ReadPixels(Vector2.new(), p3.Size);
    local v5 = {};
    for v6 = 1, #v4, 4 do
        local v7 = 0.2989 * v4[v6] + 0.587 * v4[v6 + 1] + 0.114 * v4[v6 + 2];
        table.insert(v5, v7);
        table.insert(v5, v7);
        table.insert(v5, v7);
        table.insert(v5, v4[v6 + 3]);
        if Work() then
            u1.PercentComplete = v6 / #v4;
        end;
    end;
    p3:WritePixels(Vector2.new(), p3.Size, v5);
end;
function u1.applyNoise(p8, p9) --[[ Line: 49 ]]
    -- upvalues: u1 (copy)
    local _ = p8.Size.X;
    local _ = p8.Size.Y;
    local v10 = p8:ReadPixels(Vector2.new(), p8.Size);
    local v11 = {};
    for v12 = 1, #v10, 4 do
        local v13 = v10[v12];
        local v14 = v10[v12 + 1];
        local v15 = v10[v12 + 2];
        local v16 = math.random() * p9;
        local v17 = math.random() * p9;
        local v18 = math.random() * p9;
        local v19 = math.max(0, v13 + v16);
        local v20 = math.min(1, v19);
        local v21 = math.max(0, v14 + v17);
        local v22 = math.min(1, v21);
        local v23 = math.max(0, v15 + v18);
        local v24 = math.min(1, v23);
        table.insert(v11, v20);
        table.insert(v11, v22);
        table.insert(v11, v24);
        table.insert(v11, v10[v12 + 3]);
        if Work() then
            u1.PercentComplete = v12 / #v10;
        end;
    end;
    p8:WritePixels(Vector2.new(), p8.Size, v11);
end;
function u1.applyMosaicFilter(p25, p26) --[[ Line: 88 ]]
    -- upvalues: u1 (copy)
    local l__X__1 = p25.Size.X;
    local l__Y__2 = p25.Size.Y;
    local v27 = p25:ReadPixels(Vector2.new(), p25.Size);
    for v28 = 0, l__Y__2 - 1, p26 do
        for v29 = 0, l__X__1 - 1, p26 do
            local v30 = 0;
            local v31 = 0;
            local v32 = 0;
            local v33 = 0;
            for v34 = 0, math.min(p26 - 1, l__Y__2 - v28 - 1) do
                for v35 = 0, math.min(p26 - 1, l__X__1 - v29 - 1) do
                    local v36 = ((v28 + v34) * l__X__1 + (v29 + v35)) * 4;
                    v30 = v30 + v27[v36 + 1];
                    v31 = v31 + v27[v36 + 2];
                    v32 = v32 + v27[v36 + 3];
                    v33 = v33 + 1;
                end;
            end;
            local v37 = v30 / v33;
            local v38 = v31 / v33;
            local v39 = v32 / v33;
            for v40 = 0, math.min(p26 - 1, l__Y__2 - v28 - 1) do
                for v41 = 0, math.min(p26 - 1, l__X__1 - v29 - 1) do
                    local v42 = ((v28 + v40) * l__X__1 + (v29 + v41)) * 4;
                    v27[v42 + 1] = v37;
                    v27[v42 + 2] = v38;
                    v27[v42 + 3] = v39;
                end;
            end;
            if Work() then
                u1.PercentComplete = v28 / l__Y__2;
            end;
        end;
    end;
    p25:WritePixels(Vector2.new(), p25.Size, v27);
end;
function u1.applyEmbossFilter(p43) --[[ Line: 137 ]]
    -- upvalues: u1 (copy)
    local l__X__3 = p43.Size.X;
    local l__Y__4 = p43.Size.Y;
    local v44 = p43:ReadPixels(Vector2.new(), p43.Size);
    local v45 = {};
    local v46 = {
        { -2, -1, 0 },
        { -1, 1, 1 },
        { 0, 1, 2 }
    };
    for v47 = 0, l__Y__4 - 1 do
        for v48 = 0, l__X__3 - 1 do
            local v49 = 0;
            local v50 = 0;
            local v51 = 0;
            for v52 = 1, #v46 do
                for v53 = 1, #v46[1] do
                    local v54 = v48 + v53 - math.floor(#v46[1] / 2);
                    local v55 = v47 + v52 - math.floor(#v46 / 2);
                    if v54 >= 0 and (v54 < l__X__3 and (v55 >= 0 and v55 < l__Y__4)) then
                        local v56 = (v55 * l__X__3 + v54) * 4;
                        local v57 = v46[v52][v53];
                        v49 = v49 + v44[v56 + 1] * v57;
                        v50 = v50 + v44[v56 + 2] * v57;
                        v51 = v51 + v44[v56 + 3] * v57;
                    end;
                end;
            end;
            local v58 = math.max(0, v49);
            local v59 = math.min(1, v58);
            local v60 = math.max(0, v50);
            local v61 = math.min(1, v60);
            local v62 = math.max(0, v51);
            local v63 = math.min(1, v62);
            local v64 = (v47 * l__X__3 + v48) * 4;
            v45[v64 + 1] = v59;
            v45[v64 + 2] = v61;
            v45[v64 + 3] = v63;
            v45[v64 + 4] = v44[v64 + 4];
            if Work() then
                u1.PercentComplete = v47 / l__Y__4;
            end;
        end;
    end;
    p43:WritePixels(Vector2.new(), p43.Size, v45);
end;
function u1.applyDeepFriedEffect(p65, p66, p67) --[[ Line: 196 ]]
    -- upvalues: u1 (copy)
    local l__X__5 = p65.Size.X;
    local l__Y__6 = p65.Size.Y;
    local v68 = p65:ReadPixels(Vector2.new(), p65.Size);
    local v69 = {};
    for v70 = 0, l__Y__6 - 1 do
        for v71 = 0, l__X__5 - 1 do
            local v72 = (v70 * l__X__5 + v71) * 4;
            local v73 = v68[v72 + 1] * (p66 + 1);
            local v74 = v68[v72 + 2] * (p66 + 1);
            local v75 = v68[v72 + 3] * (p66 + 1);
            local v76 = (v73 + v74 + v75) / 3;
            local v77 = v76 + p67 * (v73 - v76);
            local v78 = v76 + p67 * (v74 - v76);
            local v79 = v76 + p67 * (v75 - v76);
            local v80 = math.max(0, v77);
            local v81 = math.min(1, v80);
            local v82 = math.max(0, v78);
            local v83 = math.min(1, v82);
            local v84 = math.max(0, v79);
            local v85 = math.min(1, v84);
            v69[v72 + 1] = v81;
            v69[v72 + 2] = v83;
            v69[v72 + 3] = v85;
            v69[v72 + 4] = v68[v72 + 4];
            if Work() then
                u1.PercentComplete = v70 / l__Y__6;
            end;
        end;
    end;
    p65:WritePixels(Vector2.new(), p65.Size, v69);
end;
function u1.applyContrastFilter(p86, p87) --[[ Line: 241 ]]
    -- upvalues: u1 (copy)
    local l__X__7 = p86.Size.X;
    local l__Y__8 = p86.Size.Y;
    local v88 = p86:ReadPixels(Vector2.new(), p86.Size);
    local v89 = {};
    for v90 = 0, l__Y__8 - 1 do
        for v91 = 0, l__X__7 - 1 do
            local v92 = (v90 * l__X__7 + v91) * 4;
            local v93 = v88[v92 + 1];
            local v94 = v88[v92 + 2];
            local v95 = v88[v92 + 3];
            local v96 = (v93 - 0.5) * p87 + 0.5;
            local v97 = (v94 - 0.5) * p87 + 0.5;
            local v98 = (v95 - 0.5) * p87 + 0.5;
            local v99 = math.max(0, v96);
            local v100 = math.min(1, v99);
            local v101 = math.max(0, v97);
            local v102 = math.min(1, v101);
            local v103 = math.max(0, v98);
            local v104 = math.min(1, v103);
            v89[v92 + 1] = v100;
            v89[v92 + 2] = v102;
            v89[v92 + 3] = v104;
            v89[v92 + 4] = v88[v92 + 4];
            if Work() then
                u1.PercentComplete = v90 / l__Y__8;
            end;
        end;
    end;
    p86:WritePixels(Vector2.new(), p86.Size, v89);
end;
function u1.applySepiaFilter(p105) --[[ Line: 285 ]]
    -- upvalues: u1 (copy)
    local l__X__9 = p105.Size.X;
    local l__Y__10 = p105.Size.Y;
    local v106 = p105:ReadPixels(Vector2.new(), p105.Size);
    local v107 = {};
    for v108 = 0, l__Y__10 - 1 do
        for v109 = 0, l__X__9 - 1 do
            local v110 = (v108 * l__X__9 + v109) * 4;
            local v111 = v106[v110 + 1];
            local v112 = v106[v110 + 2];
            local v113 = v106[v110 + 3];
            local v114 = v111 * 0.393 + v112 * 0.769 + v113 * 0.189;
            local v115 = v111 * 0.349 + v112 * 0.686 + v113 * 0.168;
            local v116 = v111 * 0.272 + v112 * 0.534 + v113 * 0.131;
            local v117 = math.max(0, v114);
            local v118 = math.min(1, v117);
            local v119 = math.max(0, v115);
            local v120 = math.min(1, v119);
            local v121 = math.max(0, v116);
            local v122 = math.min(1, v121);
            v107[v110 + 1] = v118;
            v107[v110 + 2] = v120;
            v107[v110 + 3] = v122;
            v107[v110 + 4] = v106[v110 + 4];
            if Work() then
                u1.PercentComplete = v108 / l__Y__10;
            end;
        end;
    end;
    p105:WritePixels(Vector2.new(), p105.Size, v107);
end;
function u1.applyThresholdFilter(p123, p124) --[[ Line: 329 ]]
    -- upvalues: u1 (copy)
    local l__X__11 = p123.Size.X;
    local l__Y__12 = p123.Size.Y;
    local v125 = p123:ReadPixels(Vector2.new(), p123.Size);
    local v126 = {};
    for v127 = 0, l__Y__12 - 1 do
        for v128 = 0, l__X__11 - 1 do
            local v129 = (v127 * l__X__11 + v128) * 4;
            local v130 = p124 < (v125[v129 + 1] + v125[v129 + 2] + v125[v129 + 3]) / 3 and 1 or 0;
            v126[v129 + 1] = v130;
            v126[v129 + 2] = v130;
            v126[v129 + 3] = v130;
            v126[v129 + 4] = v125[v129 + 4];
            if Work() then
                u1.PercentComplete = v127 / l__Y__12;
            end;
        end;
    end;
    p123:WritePixels(Vector2.new(), p123.Size, v126);
end;
function u1.applyInvertFilter(p131) --[[ Line: 364 ]]
    -- upvalues: u1 (copy)
    local l__X__13 = p131.Size.X;
    local l__Y__14 = p131.Size.Y;
    local v132 = p131:ReadPixels(Vector2.new(), p131.Size);
    local v133 = {};
    for v134 = 0, l__Y__14 - 1 do
        for v135 = 0, l__X__13 - 1 do
            local v136 = (v134 * l__X__13 + v135) * 4;
            local v137 = 1 - v132[v136 + 1];
            local v138 = 1 - v132[v136 + 2];
            local v139 = 1 - v132[v136 + 3];
            v133[v136 + 1] = v137;
            v133[v136 + 2] = v138;
            v133[v136 + 3] = v139;
            v133[v136 + 4] = v132[v136 + 4];
            if Work() then
                u1.PercentComplete = v134 / l__Y__14;
            end;
        end;
    end;
    p131:WritePixels(Vector2.new(), p131.Size, v133);
end;
function u1.applySolarizeFilter(p140, p141) --[[ Line: 398 ]]
    -- upvalues: u1 (copy)
    local l__X__15 = p140.Size.X;
    local l__Y__16 = p140.Size.Y;
    local v142 = p140:ReadPixels(Vector2.new(), p140.Size);
    local v143 = {};
    for v144 = 0, l__Y__16 - 1 do
        for v145 = 0, l__X__15 - 1 do
            local v146 = (v144 * l__X__15 + v145) * 4;
            if p141 < (v142[v146 + 1] + v142[v146 + 2] + v142[v146 + 3]) / 3 then
                v143[v146 + 1] = 1 - v142[v146 + 1];
                v143[v146 + 2] = 1 - v142[v146 + 2];
                v143[v146 + 3] = 1 - v142[v146 + 3];
            else
                v143[v146 + 1] = v142[v146 + 1];
                v143[v146 + 2] = v142[v146 + 2];
                v143[v146 + 3] = v142[v146 + 3];
            end;
            v143[v146 + 4] = v142[v146 + 4];
            if Work() then
                u1.PercentComplete = v144 / l__Y__16;
            end;
        end;
    end;
    p140:WritePixels(Vector2.new(), p140.Size, v143);
end;
function u1.applyGlitchFilter(p147, p148) --[[ Line: 440 ]]
    -- upvalues: u1 (copy)
    local l__X__17 = p147.Size.X;
    local l__Y__18 = p147.Size.Y;
    local v149 = p147:ReadPixels(Vector2.new(), p147.Size);
    local v150 = {};
    for v151 = 0, l__Y__18 - 1 do
        for v152 = 0, l__X__17 - 1 do
            local v153 = (v151 * l__X__17 + v152) * 4;
            local v154 = math.random() * p148;
            local v155 = math.random() * v154;
            local v156 = math.random() * v154;
            local v157 = math.random() * v154;
            local v158 = math.random() * p148 * 2;
            local v159 = math.floor(v158) - p148;
            local v160 = math.random() * p148 * 2;
            local v161 = math.floor(v160) - p148;
            local v162 = v152 + v159;
            local v163 = v151 + v161;
            local v164 = math.min(v162, l__X__17 - 1);
            local v165 = math.max(0, v164);
            local v166 = math.min(v163, l__Y__18 - 1);
            local v167 = math.max(0, v166);
            local v168 = v149[(v167 * l__X__17 + v165) * 4 + 1] or 0;
            local v169 = v149[(v167 * l__X__17 + v165) * 4 + 2] or 0;
            local v170 = v149[(v167 * l__X__17 + v165) * 4 + 3] or 0;
            local v171 = (v168 or 0) + v155;
            local v172 = (v169 or 0) + v156;
            local v173 = (v170 or 0) + v157;
            local v174 = math.max(0, v171);
            local v175 = math.min(1, v174);
            local v176 = math.max(0, v172);
            local v177 = math.min(1, v176);
            local v178 = math.max(0, v173);
            local v179 = math.min(1, v178);
            v150[v153 + 1] = v175;
            v150[v153 + 2] = v177;
            v150[v153 + 3] = v179;
            v150[v153 + 4] = v149[v153 + 4];
            if Work() then
                u1.PercentComplete = v151 / l__Y__18;
            end;
        end;
    end;
    p147:WritePixels(Vector2.new(), p147.Size, v150);
end;
function u1.applyVHSFilter(p180, p181) --[[ Line: 500 ]]
    -- upvalues: u1 (copy)
    local l__X__19 = p180.Size.X;
    local l__Y__20 = p180.Size.Y;
    local v182 = p180:ReadPixels(Vector2.new(), p180.Size);
    local v183 = math.floor(l__Y__20 / 20);
    local v184 = {};
    for v185 = 0, l__Y__20 - 1 do
        for v186 = 0, l__X__19 - 1 do
            local v187 = (v185 * l__X__19 + v186) * 4;
            local v188 = (math.random() - 0.5) * p181;
            local _ = v182[v187 + 1] + v188;
            local _ = v182[v187 + 2] + v188;
            local _ = v182[v187 + 3] + v188;
            local v189 = v182[v187 + 1];
            local v190 = v182[v187 + 2] + (math.random() - 0.5) * p181;
            local v191 = v182[v187 + 3] + (math.random() - 0.5) * p181;
            local v192 = math.random() * p181 * 2;
            if v185 % v183 == 0 then
                local v193 = (math.random() - 0.5) * p181 * 5;
                local _ = v192 * (math.floor(v193) / 100 + 1);
            end;
            local v194 = (math.random() - 0.5) * p181 * 2;
            math.floor(v194);
            local v195 = (math.random() - 0.5) * p181 * 2;
            math.floor(v195);
            local v196 = math.max(0, v189);
            local v197 = math.min(1, v196);
            local v198 = math.max(0, v190);
            local v199 = math.min(1, v198);
            local v200 = math.max(0, v191);
            local v201 = math.min(1, v200);
            v184[v187 + 1] = v197;
            v184[v187 + 2] = v199;
            v184[v187 + 3] = v201;
            v184[v187 + 4] = v182[v187 + 4];
            if Work() then
                u1.PercentComplete = v185 / l__Y__20;
            end;
        end;
    end;
    p180:WritePixels(Vector2.new(), p180.Size, v184);
end;
function u1.applyColorAberration(p202, p203) --[[ Line: 559 ]]
    -- upvalues: u1 (copy)
    local l__X__21 = p202.Size.X;
    local l__Y__22 = p202.Size.Y;
    local v204 = p202:ReadPixels(Vector2.new(), p202.Size);
    local v205 = {};
    for v206 = 0, l__Y__22 - 1 do
        for v207 = 0, l__X__21 - 1 do
            local v208 = (v206 * l__X__21 + v207) * 4;
            local v209 = math.floor(p203 * 10);
            local v210 = math.max(0, v204[v208 + 1]);
            local v211 = math.min(1, v210);
            local v212 = math.max(0, v204[v208 + 2]);
            local v213 = math.min(1, v212);
            local v214 = math.max(0, v204[v208 + 3]);
            local v215 = math.min(1, v214);
            local v216 = math.max(0, v204[v208 + 1 + v209] or v211);
            local v217 = math.min(1, v216);
            local v218 = math.max(0, v204[v208 + 2 - v209] or v213);
            local v219 = math.min(1, v218);
            local v220 = math.max(0, v204[v208 + 3 + v209] or v215);
            local v221 = math.min(1, v220);
            v205[v208 + 1] = v217;
            v205[v208 + 2] = v219;
            v205[v208 + 3] = v221;
            v205[v208 + 4] = v204[v208 + 4];
            if Work() then
                u1.PercentComplete = v206 / l__Y__22;
            end;
        end;
    end;
    p202:WritePixels(Vector2.new(), p202.Size, v205);
end;
function u1.applyPosterizationFilter(p222, p223) --[[ Line: 599 ]]
    -- upvalues: u1 (copy)
    local l__X__23 = p222.Size.X;
    local l__Y__24 = p222.Size.Y;
    local v224 = p222:ReadPixels(Vector2.new(), p222.Size);
    local v225 = {};
    for v226 = 0, l__Y__24 - 1 do
        for v227 = 0, l__X__23 - 1 do
            local v228 = (v226 * l__X__23 + v227) * 4;
            local v229 = math.floor((v224[v228 + 1] + v224[v228 + 2] + v224[v228 + 3]) / 3 * (p223 - 1)) / (p223 - 1);
            v225[v228 + 1] = v229;
            v225[v228 + 2] = v229;
            v225[v228 + 3] = v229;
            v225[v228 + 4] = v224[v228 + 4];
            if Work() then
                u1.PercentComplete = v226 / l__Y__24;
            end;
        end;
    end;
    p222:WritePixels(Vector2.new(), p222.Size, v225);
end;
function u1.applyBulgeDistortionFilter(p230, p231, p232, p233) --[[ Line: 636 ]]
    -- upvalues: u1 (copy)
    local l__X__25 = p230.Size.X;
    local l__Y__26 = p230.Size.Y;
    local v234 = p230:ReadPixels(Vector2.new(), p230.Size);
    local v235 = {};
    for v236 = 0, l__Y__26 - 1 do
        for v237 = 0, l__X__25 - 1 do
            local v238 = v237 - p231;
            local v239 = v236 - p232;
            local v240 = math.sqrt(v238 * v238 + v239 * v239) / p233;
            local v241 = v237 + v238 * v240;
            local v242 = v236 + v239 * v240;
            local v243 = math.min(l__X__25 - 1, v241);
            local v244 = math.max(0, v243);
            local v245 = math.min(l__Y__26 - 1, v242);
            local v246 = math.max(0, v245);
            local v247 = (math.floor(v246) * l__X__25 + math.floor(v244)) * 4;
            local v248 = v234[v247 + 1];
            local v249 = v234[v247 + 2];
            local v250 = v234[v247 + 3];
            local v251 = v234[v247 + 4];
            local v252 = (v236 * l__X__25 + v237) * 4;
            v235[v252 + 1] = v248;
            v235[v252 + 2] = v249;
            v235[v252 + 3] = v250;
            v235[v252 + 4] = v251;
            if Work() then
                u1.PercentComplete = v236 / l__Y__26;
            end;
        end;
    end;
    p230:WritePixels(Vector2.new(), p230.Size, v235);
end;
function u1.applyPolarDistortion(p253, p254, p255) --[[ Line: 687 ]]
    -- upvalues: u1 (copy)
    local l__X__27 = p253.Size.X;
    local l__Y__28 = p253.Size.Y;
    local v256 = math.sqrt(p254 ^ 2 + p255 ^ 2);
    local v257 = p253:ReadPixels(Vector2.new(), p253.Size);
    for v258 = 0, l__Y__28 - 1 do
        for v259 = 0, l__X__27 - 1 do
            local v260 = v259 - p254;
            local v261 = v258 - p255;
            local v262 = math.sqrt(v260 ^ 2 + v261 ^ 2);
            local v263 = math.atan2(v261, v260);
            local v264 = math.sqrt(v262) * math.sqrt(v256);
            local v265 = v264 * math.cos(v263) + p254;
            local v266 = v264 * math.sin(v263) + p255;
            local v267 = math.min(l__X__27 - 1, v265);
            local v268 = math.max(0, v267);
            local v269 = math.min(l__Y__28 - 1, v266);
            local v270 = math.max(0, v269);
            local v271 = (math.floor(v270) * l__X__27 + math.floor(v268)) * 4;
            local v272 = v257[v271 + 1];
            local v273 = v257[v271 + 2];
            local v274 = v257[v271 + 3];
            local v275 = v257[v271 + 4];
            v257[(v258 * l__X__27 + v259) * 4 + 1] = v272;
            v257[(v258 * l__X__27 + v259) * 4 + 2] = v273;
            v257[(v258 * l__X__27 + v259) * 4 + 3] = v274;
            v257[(v258 * l__X__27 + v259) * 4 + 4] = v275;
            if Work() then
                u1.PercentComplete = v258 / l__Y__28;
            end;
        end;
    end;
    p253:WritePixels(Vector2.new(), p253.Size, v257);
end;
function u1.applyRippleDistortion(p276, p277, p278, p279, p280) --[[ Line: 737 ]]
    -- upvalues: u1 (copy)
    local l__X__29 = p276.Size.X;
    local l__Y__30 = p276.Size.Y;
    local v281 = p276:ReadPixels(Vector2.new(), p276.Size);
    for v282 = 0, l__Y__30 - 1 do
        for v283 = 0, l__X__29 - 1 do
            local v284 = v283 - p277;
            local v285 = v282 - p278;
            local v286 = math.sqrt(v284 * v284 + v285 * v285) * p280;
            local v287 = p279 * math.sin(v286);
            local v288 = v283 + v287;
            local v289 = v282 + v287;
            local v290 = math.min(l__X__29 - 1, v288);
            local v291 = math.max(0, v290);
            local v292 = math.min(l__Y__30 - 1, v289);
            local v293 = math.max(0, v292);
            local v294 = (math.floor(v293) * l__X__29 + math.floor(v291)) * 4;
            local v295 = v281[v294 + 1];
            local v296 = v281[v294 + 2];
            local v297 = v281[v294 + 3];
            local v298 = v281[v294 + 4];
            v281[(v282 * l__X__29 + v283) * 4 + 1] = v295;
            v281[(v282 * l__X__29 + v283) * 4 + 2] = v296;
            v281[(v282 * l__X__29 + v283) * 4 + 3] = v297;
            v281[(v282 * l__X__29 + v283) * 4 + 4] = v298;
            if Work() then
                u1.PercentComplete = v282 / l__Y__30;
            end;
        end;
    end;
    p276:WritePixels(Vector2.new(), p276.Size, v281);
end;
function u1.applyTwirlDistortion(p299, p300, p301, p302, p303) --[[ Line: 787 ]]
    -- upvalues: u1 (copy)
    local l__X__31 = p299.Size.X;
    local l__Y__32 = p299.Size.Y;
    local v304 = p299:ReadPixels(Vector2.new(), p299.Size);
    for v305 = 0, l__Y__32 - 1 do
        for v306 = 0, l__X__31 - 1 do
            local v307 = v306 - p300;
            local v308 = v305 - p301;
            local v309 = math.sqrt(v307 * v307 + v308 * v308);
            local v310 = math.atan2(v308, v307) + p303 * (p302 - v309) / p302;
            local v311 = v306 + math.cos(v310) * (v309 - p302);
            local v312 = v305 + math.sin(v310) * (v309 - p302);
            local v313 = math.min(l__X__31 - 1, v311);
            local v314 = math.max(0, v313);
            local v315 = math.min(l__Y__32 - 1, v312);
            local v316 = math.max(0, v315);
            local v317 = (math.floor(v316) * l__X__31 + math.floor(v314)) * 4;
            local v318 = v304[v317 + 1];
            local v319 = v304[v317 + 2];
            local v320 = v304[v317 + 3];
            local v321 = v304[v317 + 4];
            v304[(v305 * l__X__31 + v306) * 4 + 1] = v318;
            v304[(v305 * l__X__31 + v306) * 4 + 2] = v319;
            v304[(v305 * l__X__31 + v306) * 4 + 3] = v320;
            v304[(v305 * l__X__31 + v306) * 4 + 4] = v321;
            if Work() then
                u1.PercentComplete = v305 / l__Y__32;
            end;
        end;
    end;
    p299:WritePixels(Vector2.new(), p299.Size, v304);
end;
function u1.applyTurbulenceDistortion(p322, p323) --[[ Line: 835 ]]
    local l__X__33 = p322.Size.X;
    local l__Y__34 = p322.Size.Y;
    local v324 = p322:ReadPixels(Vector2.new(), p322.Size);
    for v325 = 0, l__Y__34 - 1 do
        for v326 = 0, l__X__33 - 1 do
            local v327 = math.cos(v325 * p323) * 10;
            local v328 = math.sin(v326 * p323) * 10;
            local v329 = v326 + v327;
            local v330 = v325 + v328;
            local v331 = math.min(l__X__33 - 1, v329);
            local v332 = math.max(0, v331);
            local v333 = math.min(l__Y__34 - 1, v330);
            local v334 = math.max(0, v333);
            local v335 = (math.floor(v334) * l__X__33 + math.floor(v332)) * 4;
            local v336 = v324[v335 + 1];
            local v337 = v324[v335 + 2];
            local v338 = v324[v335 + 3];
            local v339 = v324[v335 + 4];
            v324[(v325 * l__X__33 + v326) * 4 + 1] = v336;
            v324[(v325 * l__X__33 + v326) * 4 + 2] = v337;
            v324[(v325 * l__X__33 + v326) * 4 + 3] = v338;
            v324[(v325 * l__X__33 + v326) * 4 + 4] = v339;
        end;
    end;
    p322:WritePixels(Vector2.new(), p322.Size, v324);
end;
function u1.applyDreamyBlur(p340, p341, p342) --[[ Line: 878 ]]
    -- upvalues: u1 (copy)
    local l__X__35 = p340.Size.X;
    local l__Y__36 = p340.Size.Y;
    local v343 = p340:ReadPixels(Vector2.new(), p340.Size);
    for v344 = 0, l__Y__36 - 1 do
        for v345 = 0, l__X__35 - 1 do
            local v346 = (v344 * l__X__35 + v345) * 4;
            local v347 = 0;
            local v348 = 0;
            local v349 = 0;
            local v350 = 0;
            for v351 = -p341, p341 do
                for v352 = -p341, p341 do
                    local v353 = math.min(l__X__35 - 1, v345 + v352);
                    local v354 = math.max(0, v353);
                    local v355 = math.min(l__Y__36 - 1, v344 + v351);
                    local v356 = (math.max(0, v355) * l__X__35 + v354) * 4;
                    local v357 = math.exp(-(v352 * v352 + v351 * v351) / (p341 * 2 * p341));
                    v348 = v348 + v343[v356 + 1] * v357;
                    v349 = v349 + v343[v356 + 2] * v357;
                    v350 = v350 + v343[v356 + 3] * v357;
                    v347 = v347 + v357;
                end;
            end;
            v343[v346 + 1] = v348 / v347;
            v343[v346 + 2] = v349 / v347;
            v343[v346 + 3] = v350 / v347;
            if Work() then
                u1.PercentComplete = v344 / l__Y__36;
            end;
        end;
    end;
    task.wait();
    for v358 = 0, l__Y__36 - 1 do
        for v359 = 0, l__X__35 - 1 do
            local v360 = (v358 * l__X__35 + v359) * 4;
            v343[v360 + 1] = v343[v360 + 1] + v343[v360 + 1] * p342;
            v343[v360 + 2] = v343[v360 + 2] + v343[v360 + 2] * p342;
            v343[v360 + 3] = v343[v360 + 3] + v343[v360 + 3] * p342;
        end;
    end;
    p340:WritePixels(Vector2.new(), p340.Size, v343);
end;
function u1.applyPopArtFilter(p361) --[[ Line: 928 ]]
    -- upvalues: u1 (copy)
    local l__X__37 = p361.Size.X;
    local l__Y__38 = p361.Size.Y;
    local v362 = p361:ReadPixels(Vector2.new(), p361.Size);
    for v363 = 1, #v362, 4 do
        local v364 = v362[v363];
        local v365 = v362[v363 + 1];
        local v366 = v362[v363 + 2];
        local v367 = v364 >= 0.7 and 1 or 0;
        local v368 = v365 >= 0.7 and 1 or 0;
        local v369 = v366 >= 0.7 and 1 or 0;
        v362[v363] = v367;
        v362[v363 + 1] = v368;
        v362[v363 + 2] = v369;
        if Work() then
            u1.PercentComplete = v363 / #v362;
        end;
    end;
    for v370 = 1, #v362, 4 do
        if v362[v370] == 1 then
            local v371 = v370 + 1;
            local v372 = v370 + 2;
            v362[v370] = 1;
            v362[v371] = 0;
            v362[v372] = 0;
        elseif v362[v370] == 0 then
            local v373 = v370 + 1;
            local v374 = v370 + 2;
            v362[v370] = 0;
            v362[v373] = 0;
            v362[v374] = 1;
        end;
        if Work() then
            u1.PercentComplete = v370 / #v362;
        end;
    end;
    for v375 = 1, l__Y__38 - 2 do
        for v376 = 1, l__X__37 - 2 do
            local v377 = (v375 * l__X__37 + v376) * 4;
            local v378 = (v375 * l__X__37 + v376 + 1) * 4;
            if math.abs(v362[v377] - v362[v378]) > 0.1 or math.abs(v362[v377] - v362[v378 + 4]) > 0.1 then
                v362[v377] = 1;
                v362[v377 + 1] = 1;
                v362[v377 + 2] = 1;
            end;
            if Work() then
                u1.PercentComplete = v375 / l__Y__38;
            end;
        end;
    end;
    p361:WritePixels(Vector2.new(), p361.Size, v362);
end;
function u1.applyEdgeDetectionFilter(p379) --[[ Line: 997 ]]
    -- upvalues: u1 (copy)
    local l__X__39 = p379.Size.X;
    local l__Y__40 = p379.Size.Y;
    local v380 = p379:ReadPixels(Vector2.new(), p379.Size);
    local v381 = {
        { -1, 0, 1 },
        { -2, 0, 2 },
        { -1, 0, 1 }
    };
    local v382 = {};
    local v383 = {
        { -1, -2, -1 },
        { 0, 0, 0 },
        { 1, 2, 1 }
    };
    for v384 = 0, l__Y__40 - 1 do
        for v385 = 0, l__X__39 - 1 do
            local v386 = 0;
            local v387 = 0;
            local v388 = 0;
            local v389 = 0;
            local v390 = 0;
            local v391 = 0;
            for v392 = 1, #v383 do
                for v393 = 1, #v383[1] do
                    local v394 = v385 + v393 - math.floor(#v383[1] / 2);
                    local v395 = v384 + v392 - math.floor(#v383 / 2);
                    if v394 >= 0 and (v394 < l__X__39 and (v395 >= 0 and v395 < l__Y__40)) then
                        local v396 = (v395 * l__X__39 + v394) * 4;
                        local v397 = v381[v392][v393];
                        local v398 = v383[v392][v393];
                        v388 = v388 + v380[v396 + 1] * v397;
                        v389 = v389 + v380[v396 + 2] * v397;
                        v390 = v390 + v380[v396 + 3] * v397;
                        v391 = v391 + v380[v396 + 1] * v398;
                        v386 = v386 + v380[v396 + 2] * v398;
                        v387 = v387 + v380[v396 + 3] * v398;
                    end;
                end;
            end;
            local v399 = math.sqrt(v388 ^ 2 + v391 ^ 2);
            local v400 = math.sqrt(v389 ^ 2 + v386 ^ 2);
            local v401 = math.sqrt(v390 ^ 2 + v387 ^ 2);
            local v402 = math.max(0, v399);
            local v403 = math.min(1, v402);
            local v404 = math.max(0, v400);
            local v405 = math.min(1, v404);
            local v406 = math.max(0, v401);
            local v407 = math.min(1, v406);
            local v408 = (v384 * l__X__39 + v385) * 4;
            v382[v408 + 1] = v403;
            v382[v408 + 2] = v405;
            v382[v408 + 3] = v407;
            v382[v408 + 4] = v380[v408 + 4];
            if Work() then
                u1.PercentComplete = v384 / l__Y__40;
            end;
        end;
    end;
    p379:WritePixels(Vector2.new(), p379.Size, v382);
end;
function u1.findMostAverageColor(p409) --[[ Line: 1072 ]]
    local l__X__41 = p409.Size.X;
    local l__Y__42 = p409.Size.Y;
    local v410 = p409:ReadPixels(Vector2.new(), p409.Size);
    local v411 = l__X__41 * l__Y__42;
    local v412 = 0;
    local v413 = 0;
    local v414 = 0;
    for v415 = 1, v411 * 4, 4 do
        v412 = v412 + v410[v415];
        v413 = v413 + v410[v415 + 1];
        v414 = v414 + v410[v415 + 2];
    end;
    return Color3.new(v412 / v411, v413 / v411, v414 / v411);
end;
function u1.findVerticalAverageColors(p416) --[[ Line: 1098 ]]
    local l__X__43 = p416.Size.X;
    local l__Y__44 = p416.Size.Y;
    local v417 = p416:ReadPixels(Vector2.new(), p416.Size);
    local v418 = l__Y__44 / 4;
    local v419 = 0;
    local v420 = 0;
    local v421 = 0;
    local v422 = 0;
    local v423 = 0;
    local v424 = 0;
    local v425 = 0;
    local v426 = 0;
    local v427 = 0;
    local v428 = 0;
    local v429 = 0;
    local v430 = 0;
    for v431 = 0, l__Y__44 - 1 do
        for v432 = 0, l__X__43 - 1 do
            local v433 = (v431 * l__X__43 + v432) * 4;
            local v434 = v417[v433 + 1];
            local v435 = v417[v433 + 2];
            local v436 = v417[v433 + 3];
            if v431 < v418 then
                v424 = v424 + v434;
                v419 = v419 + v435;
                v420 = v420 + v436;
            elseif v431 < v418 * 2 then
                v421 = v421 + v434;
                v425 = v425 + v435;
                v426 = v426 + v436;
            elseif v431 < v418 * 3 then
                v427 = v427 + v434;
                v422 = v422 + v435;
                v423 = v423 + v436;
            else
                v428 = v428 + v434;
                v429 = v429 + v435;
                v430 = v430 + v436;
            end;
        end;
    end;
    local v437 = l__X__43 * l__Y__44;
    return Color3.new(v424 / v437, v419 / v437, v420 / v437):Lerp(Color3.new(1, 1, 1), 0.1), Color3.new(v421 / v437, v425 / v437, v426 / v437):Lerp(Color3.new(1, 1, 1), 0.1), Color3.new(v427 / v437, v422 / v437, v423 / v437):Lerp(Color3.new(1, 1, 1), 0.1), Color3.new(v428 / v437, v429 / v437, v430 / v437):Lerp(Color3.new(1, 1, 1), 0.1);
end;
return u1;
