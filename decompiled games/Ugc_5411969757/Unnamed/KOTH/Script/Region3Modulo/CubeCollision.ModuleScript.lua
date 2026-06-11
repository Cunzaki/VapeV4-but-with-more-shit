-- Decompiled from: .KOTH.Script.Region3Modulo.CubeCollision
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__components__1 = CFrame.new().components;
return function(p1, p2, p3, p4, p5) --[[ Name: BoxCollision, Line 5 ]]
    -- upvalues: l__components__1 (copy)
    local v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 = l__components__1(p1);
    local v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29 = l__components__1(p3);
    local v30 = p2.x / 2;
    local v31 = p2.y / 2;
    local v32 = p2.z / 2;
    local v33 = p4.x / 2;
    local v34 = p4.y / 2;
    local v35 = p4.z / 2;
    local v36 = v18 - v6;
    local v37 = v19 - v7;
    local v38 = v20 - v8;
    local v39 = v9 * v36 + v12 * v37 + v15 * v38;
    local v40 = v10 * v36 + v13 * v37 + v16 * v38;
    local v41 = v11 * v36 + v14 * v37 + v17 * v38;
    local v42 = v21 * v36 + v24 * v37 + v27 * v38;
    local v43 = v22 * v36 + v25 * v37 + v28 * v38;
    local v44 = v23 * v36 + v26 * v37 + v29 * v38;
    local v45 = v33 < v42 and v42 - v33 or (v42 < -v33 and (v42 + v33 or 0) or 0);
    local v46 = v34 < v43 and v43 - v34 or (v43 < -v34 and (v43 + v34 or 0) or 0);
    local v47 = v35 < v44 and v44 - v35 or (v44 < -v35 and (v44 + v35 or 0) or 0);
    local v48 = v30 < v39 and v39 - v30 or (v39 < -v30 and (v39 + v30 or 0) or 0);
    local v49 = v31 < v40 and v40 - v31 or (v40 < -v31 and (v40 + v31 or 0) or 0);
    local v50 = v32 < v41 and v41 - v32 or (v41 < -v32 and (v41 + v32 or 0) or 0);
    local v51 = v45 * v45 + v46 * v46 + v47 * v47;
    local v52 = v48 * v48 + v49 * v49 + v50 * v50;
    local v54;
    if v30 < v31 then
        if v30 < v32 and v30 then
            local v54;
            local v55 = 0;
            while true do
                if v55 == 0 then
                    v55 = -1;
                    v54 = v30;
                    v55 = 1;
                    continue;
                elseif v55 == 1 then
                    v55 = -1;
                    local v56;
                    if v33 < v34 then
                        if v33 < v35 and v33 then
                            v56 = v33;
                            if v51 < v54 * v54 or v52 < v56 * v56 then
                                return true;
                            end;
                            if v30 * v30 + v31 * v31 + v32 * v32 < v51 or v33 * v33 + v34 * v34 + v35 * v35 < v52 then
                                return false;
                            end;
                            if p5 ~= nil then
                                return p5;
                            end;
                            local v57 = v9 * v21 + v12 * v24 + v15 * v27;
                            local v58 = v9 * v22 + v12 * v25 + v15 * v28;
                            local v59 = v9 * v23 + v12 * v26 + v15 * v29;
                            local v60 = v10 * v21 + v13 * v24 + v16 * v27;
                            local v61 = v10 * v22 + v13 * v25 + v16 * v28;
                            local v62 = v10 * v23 + v13 * v26 + v16 * v29;
                            local v63 = v11 * v21 + v14 * v24 + v17 * v27;
                            local v64 = v11 * v22 + v14 * v25 + v17 * v28;
                            local v65 = v11 * v23 + v14 * v26 + v17 * v29;
                            local v66 = v35 * v35;
                            local v67 = v33 * v33;
                            local v68 = v34 * v34;
                            local v69 = v30 * v57;
                            local v70 = v31 * v60;
                            local v71 = v32 * v63;
                            local v72 = v30 * v58;
                            local v73 = v31 * v61;
                            local v74 = v32 * v64;
                            local v75 = v30 * v59;
                            local v76 = v31 * v62;
                            local v77 = v32 * v65;
                            local v78 = v69 + v70 + v71 - v42;
                            if v78 * v78 < v67 then
                                local v79 = v72 + v73 + v74 - v43;
                                if v79 * v79 < v68 then
                                    local v80 = v75 + v76 + v77 - v44;
                                    if v80 * v80 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v81 = -v69 + v70 + v71 - v42;
                            if v81 * v81 < v67 then
                                local v82 = -v72 + v73 + v74 - v43;
                                if v82 * v82 < v68 then
                                    local v83 = -v75 + v76 + v77 - v44;
                                    if v83 * v83 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v84 = v69 - v70 + v71 - v42;
                            if v84 * v84 < v67 then
                                local v85 = v72 - v73 + v74 - v43;
                                if v85 * v85 < v68 then
                                    local v86 = v75 - v76 + v77 - v44;
                                    if v86 * v86 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v87 = -v69 - v70 + v71 - v42;
                            if v87 * v87 < v67 then
                                local v88 = -v72 - v73 + v74 - v43;
                                if v88 * v88 < v68 then
                                    local v89 = -v75 - v76 + v77 - v44;
                                    if v89 * v89 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v90 = v69 + v70 - v71 - v42;
                            if v90 * v90 < v67 then
                                local v91 = v72 + v73 - v74 - v43;
                                if v91 * v91 < v68 then
                                    local v92 = v75 + v76 - v77 - v44;
                                    if v92 * v92 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v93 = -v69 + v70 - v71 - v42;
                            if v93 * v93 < v67 then
                                local v94 = -v72 + v73 - v74 - v43;
                                if v94 * v94 < v68 then
                                    local v95 = -v75 + v76 - v77 - v44;
                                    if v95 * v95 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v96 = v69 - v70 - v71 - v42;
                            if v96 * v96 < v67 then
                                local v97 = v72 - v73 - v74 - v43;
                                if v97 * v97 < v68 then
                                    local v98 = v75 - v76 - v77 - v44;
                                    if v98 * v98 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v99 = -v69 - v70 - v71 - v42;
                            if v99 * v99 < v67 then
                                local v100 = -v72 - v73 - v74 - v43;
                                if v100 * v100 < v68 then
                                    local v101 = -v75 - v76 - v77 - v44;
                                    if v101 * v101 < v66 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v102 = v30 * v30;
                            local v103 = v31 * v31;
                            local v104 = v32 * v32;
                            local v105 = v33 * v63;
                            local v106 = v34 * v64;
                            local v107 = v33 * v57;
                            local v108 = v34 * v58;
                            local v109 = v33 * v60;
                            local v110 = v34 * v61;
                            local v111 = v35 * v65;
                            local v112 = v35 * v59;
                            local v113 = v35 * v62;
                            local v114 = (v41 - v32 + v105 + v106) / v65;
                            if v114 * v114 < v66 then
                                local v115 = v39 + v107 + v108 - v114 * v59;
                                if v115 * v115 < v102 then
                                    local v116 = v40 + v109 + v110 - v114 * v62;
                                    if v116 * v116 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v117 = (v41 + v32 + v105 + v106) / v65;
                            if v117 * v117 < v66 then
                                local v118 = v39 + v107 + v108 - v117 * v59;
                                if v118 * v118 < v102 then
                                    local v119 = v40 + v109 + v110 - v117 * v62;
                                    if v119 * v119 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v120 = (v41 - v32 - v105 + v106) / v65;
                            if v120 * v120 < v66 then
                                local v121 = v39 - v107 + v108 - v120 * v59;
                                if v121 * v121 < v102 then
                                    local v122 = v40 - v109 + v110 - v120 * v62;
                                    if v122 * v122 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v123 = (v41 + v32 - v105 + v106) / v65;
                            if v123 * v123 < v66 then
                                local v124 = v39 - v107 + v108 - v123 * v59;
                                if v124 * v124 < v102 then
                                    local v125 = v40 - v109 + v110 - v123 * v62;
                                    if v125 * v125 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v126 = (v41 - v32 + v105 - v106) / v65;
                            if v126 * v126 < v66 then
                                local v127 = v39 + v107 - v108 - v126 * v59;
                                if v127 * v127 < v102 then
                                    local v128 = v40 + v109 - v110 - v126 * v62;
                                    if v128 * v128 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v129 = (v41 + v32 + v105 - v106) / v65;
                            if v129 * v129 < v66 then
                                local v130 = v39 + v107 - v108 - v129 * v59;
                                if v130 * v130 < v102 then
                                    local v131 = v40 + v109 - v110 - v129 * v62;
                                    if v131 * v131 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v132 = (v41 - v32 - v105 - v106) / v65;
                            if v132 * v132 < v66 then
                                local v133 = v39 - v107 - v108 - v132 * v59;
                                if v133 * v133 < v102 then
                                    local v134 = v40 - v109 - v110 - v132 * v62;
                                    if v134 * v134 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v135 = (v41 + v32 - v105 - v106) / v65;
                            if v135 * v135 < v66 then
                                local v136 = v39 - v107 - v108 - v135 * v59;
                                if v136 * v136 < v102 then
                                    local v137 = v40 - v109 - v110 - v135 * v62;
                                    if v137 * v137 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v138 = (v39 - v30 + v107 + v108) / v59;
                            if v138 * v138 < v66 then
                                local v139 = v40 + v109 + v110 - v138 * v62;
                                if v139 * v139 < v103 then
                                    local v140 = v41 + v105 + v106 - v138 * v65;
                                    if v140 * v140 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v141 = (v39 + v30 + v107 + v108) / v59;
                            if v141 * v141 < v66 then
                                local v142 = v40 + v109 + v110 - v141 * v62;
                                if v142 * v142 < v103 then
                                    local v143 = v41 + v105 + v106 - v141 * v65;
                                    if v143 * v143 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v144 = (v39 - v30 - v107 + v108) / v59;
                            if v144 * v144 < v66 then
                                local v145 = v40 - v109 + v110 - v144 * v62;
                                if v145 * v145 < v103 then
                                    local v146 = v41 - v105 + v106 - v144 * v65;
                                    if v146 * v146 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v147 = (v39 + v30 - v107 + v108) / v59;
                            if v147 * v147 < v66 then
                                local v148 = v40 - v109 + v110 - v147 * v62;
                                if v148 * v148 < v103 then
                                    local v149 = v41 - v105 + v106 - v147 * v65;
                                    if v149 * v149 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v150 = (v39 - v30 + v107 - v108) / v59;
                            if v150 * v150 < v66 then
                                local v151 = v40 + v109 - v110 - v150 * v62;
                                if v151 * v151 < v103 then
                                    local v152 = v41 + v105 - v106 - v150 * v65;
                                    if v152 * v152 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v153 = (v39 + v30 + v107 - v108) / v59;
                            if v153 * v153 < v66 then
                                local v154 = v40 + v109 - v110 - v153 * v62;
                                if v154 * v154 < v103 then
                                    local v155 = v41 + v105 - v106 - v153 * v65;
                                    if v155 * v155 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v156 = (v39 - v30 - v107 - v108) / v59;
                            if v156 * v156 < v66 then
                                local v157 = v40 - v109 - v110 - v156 * v62;
                                if v157 * v157 < v103 then
                                    local v158 = v41 - v105 - v106 - v156 * v65;
                                    if v158 * v158 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v159 = (v39 + v30 - v107 - v108) / v59;
                            if v159 * v159 < v66 then
                                local v160 = v40 - v109 - v110 - v159 * v62;
                                if v160 * v160 < v103 then
                                    local v161 = v41 - v105 - v106 - v159 * v65;
                                    if v161 * v161 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v162 = (v40 - v31 + v109 + v110) / v62;
                            if v162 * v162 < v66 then
                                local v163 = v41 + v105 + v106 - v162 * v65;
                                if v163 * v163 < v104 then
                                    local v164 = v39 + v107 + v108 - v162 * v59;
                                    if v164 * v164 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v165 = (v40 + v31 + v109 + v110) / v62;
                            if v165 * v165 < v66 then
                                local v166 = v41 + v105 + v106 - v165 * v65;
                                if v166 * v166 < v104 then
                                    local v167 = v39 + v107 + v108 - v165 * v59;
                                    if v167 * v167 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v168 = (v40 - v31 - v109 + v110) / v62;
                            if v168 * v168 < v66 then
                                local v169 = v41 - v105 + v106 - v168 * v65;
                                if v169 * v169 < v104 then
                                    local v170 = v39 - v107 + v108 - v168 * v59;
                                    if v170 * v170 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v171 = (v40 + v31 - v109 + v110) / v62;
                            if v171 * v171 < v66 then
                                local v172 = v41 - v105 + v106 - v171 * v65;
                                if v172 * v172 < v104 then
                                    local v173 = v39 - v107 + v108 - v171 * v59;
                                    if v173 * v173 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v174 = (v40 - v31 + v109 - v110) / v62;
                            if v174 * v174 < v66 then
                                local v175 = v41 + v105 - v106 - v174 * v65;
                                if v175 * v175 < v104 then
                                    local v176 = v39 + v107 - v108 - v174 * v59;
                                    if v176 * v176 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v177 = (v40 + v31 + v109 - v110) / v62;
                            if v177 * v177 < v66 then
                                local v178 = v41 + v105 - v106 - v177 * v65;
                                if v178 * v178 < v104 then
                                    local v179 = v39 + v107 - v108 - v177 * v59;
                                    if v179 * v179 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v180 = (v40 - v31 - v109 - v110) / v62;
                            if v180 * v180 < v66 then
                                local v181 = v41 - v105 - v106 - v180 * v65;
                                if v181 * v181 < v104 then
                                    local v182 = v39 - v107 - v108 - v180 * v59;
                                    if v182 * v182 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v183 = (v40 + v31 - v109 - v110) / v62;
                            if v183 * v183 < v66 then
                                local v184 = v41 - v105 - v106 - v183 * v65;
                                if v184 * v184 < v104 then
                                    local v185 = v39 - v107 - v108 - v183 * v59;
                                    if v185 * v185 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v186 = (v41 - v32 + v106 + v111) / v63;
                            if v186 * v186 < v67 then
                                local v187 = v39 + v108 + v112 - v186 * v57;
                                if v187 * v187 < v102 then
                                    local v188 = v40 + v110 + v113 - v186 * v60;
                                    if v188 * v188 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v189 = (v41 + v32 + v106 + v111) / v63;
                            if v189 * v189 < v67 then
                                local v190 = v39 + v108 + v112 - v189 * v57;
                                if v190 * v190 < v102 then
                                    local v191 = v40 + v110 + v113 - v189 * v60;
                                    if v191 * v191 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v192 = (v41 - v32 - v106 + v111) / v63;
                            if v192 * v192 < v67 then
                                local v193 = v39 - v108 + v112 - v192 * v57;
                                if v193 * v193 < v102 then
                                    local v194 = v40 - v110 + v113 - v192 * v60;
                                    if v194 * v194 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v195 = (v41 + v32 - v106 + v111) / v63;
                            if v195 * v195 < v67 then
                                local v196 = v39 - v108 + v112 - v195 * v57;
                                if v196 * v196 < v102 then
                                    local v197 = v40 - v110 + v113 - v195 * v60;
                                    if v197 * v197 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v198 = (v41 - v32 + v106 - v111) / v63;
                            if v198 * v198 < v67 then
                                local v199 = v39 + v108 - v112 - v198 * v57;
                                if v199 * v199 < v102 then
                                    local v200 = v40 + v110 - v113 - v198 * v60;
                                    if v200 * v200 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v201 = (v41 + v32 + v106 - v111) / v63;
                            if v201 * v201 < v67 then
                                local v202 = v39 + v108 - v112 - v201 * v57;
                                if v202 * v202 < v102 then
                                    local v203 = v40 + v110 - v113 - v201 * v60;
                                    if v203 * v203 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v204 = (v41 - v32 - v106 - v111) / v63;
                            if v204 * v204 < v67 then
                                local v205 = v39 - v108 - v112 - v204 * v57;
                                if v205 * v205 < v102 then
                                    local v206 = v40 - v110 - v113 - v204 * v60;
                                    if v206 * v206 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v207 = (v41 + v32 - v106 - v111) / v63;
                            if v207 * v207 < v67 then
                                local v208 = v39 - v108 - v112 - v207 * v57;
                                if v208 * v208 < v102 then
                                    local v209 = v40 - v110 - v113 - v207 * v60;
                                    if v209 * v209 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v210 = (v39 - v30 + v108 + v112) / v57;
                            if v210 * v210 < v67 then
                                local v211 = v40 + v110 + v113 - v210 * v60;
                                if v211 * v211 < v103 then
                                    local v212 = v41 + v106 + v111 - v210 * v63;
                                    if v212 * v212 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v213 = (v39 + v30 + v108 + v112) / v57;
                            if v213 * v213 < v67 then
                                local v214 = v40 + v110 + v113 - v213 * v60;
                                if v214 * v214 < v103 then
                                    local v215 = v41 + v106 + v111 - v213 * v63;
                                    if v215 * v215 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v216 = (v39 - v30 - v108 + v112) / v57;
                            if v216 * v216 < v67 then
                                local v217 = v40 - v110 + v113 - v216 * v60;
                                if v217 * v217 < v103 then
                                    local v218 = v41 - v106 + v111 - v216 * v63;
                                    if v218 * v218 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v219 = (v39 + v30 - v108 + v112) / v57;
                            if v219 * v219 < v67 then
                                local v220 = v40 - v110 + v113 - v219 * v60;
                                if v220 * v220 < v103 then
                                    local v221 = v41 - v106 + v111 - v219 * v63;
                                    if v221 * v221 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v222 = (v39 - v30 + v108 - v112) / v57;
                            if v222 * v222 < v67 then
                                local v223 = v40 + v110 - v113 - v222 * v60;
                                if v223 * v223 < v103 then
                                    local v224 = v41 + v106 - v111 - v222 * v63;
                                    if v224 * v224 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v225 = (v39 + v30 + v108 - v112) / v57;
                            if v225 * v225 < v67 then
                                local v226 = v40 + v110 - v113 - v225 * v60;
                                if v226 * v226 < v103 then
                                    local v227 = v41 + v106 - v111 - v225 * v63;
                                    if v227 * v227 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v228 = (v39 - v30 - v108 - v112) / v57;
                            if v228 * v228 < v67 then
                                local v229 = v40 - v110 - v113 - v228 * v60;
                                if v229 * v229 < v103 then
                                    local v230 = v41 - v106 - v111 - v228 * v63;
                                    if v230 * v230 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v231 = (v39 + v30 - v108 - v112) / v57;
                            if v231 * v231 < v67 then
                                local v232 = v40 - v110 - v113 - v231 * v60;
                                if v232 * v232 < v103 then
                                    local v233 = v41 - v106 - v111 - v231 * v63;
                                    if v233 * v233 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v234 = (v40 - v31 + v110 + v113) / v60;
                            if v234 * v234 < v67 then
                                local v235 = v41 + v106 + v111 - v234 * v63;
                                if v235 * v235 < v104 then
                                    local v236 = v39 + v108 + v112 - v234 * v57;
                                    if v236 * v236 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v237 = (v40 + v31 + v110 + v113) / v60;
                            if v237 * v237 < v67 then
                                local v238 = v41 + v106 + v111 - v237 * v63;
                                if v238 * v238 < v104 then
                                    local v239 = v39 + v108 + v112 - v237 * v57;
                                    if v239 * v239 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v240 = (v40 - v31 - v110 + v113) / v60;
                            if v240 * v240 < v67 then
                                local v241 = v41 - v106 + v111 - v240 * v63;
                                if v241 * v241 < v104 then
                                    local v242 = v39 - v108 + v112 - v240 * v57;
                                    if v242 * v242 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v243 = (v40 + v31 - v110 + v113) / v60;
                            if v243 * v243 < v67 then
                                local v244 = v41 - v106 + v111 - v243 * v63;
                                if v244 * v244 < v104 then
                                    local v245 = v39 - v108 + v112 - v243 * v57;
                                    if v245 * v245 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v246 = (v40 - v31 + v110 - v113) / v60;
                            if v246 * v246 < v67 then
                                local v247 = v41 + v106 - v111 - v246 * v63;
                                if v247 * v247 < v104 then
                                    local v248 = v39 + v108 - v112 - v246 * v57;
                                    if v248 * v248 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v249 = (v40 + v31 + v110 - v113) / v60;
                            if v249 * v249 < v67 then
                                local v250 = v41 + v106 - v111 - v249 * v63;
                                if v250 * v250 < v104 then
                                    local v251 = v39 + v108 - v112 - v249 * v57;
                                    if v251 * v251 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v252 = (v40 - v31 - v110 - v113) / v60;
                            if v252 * v252 < v67 then
                                local v253 = v41 - v106 - v111 - v252 * v63;
                                if v253 * v253 < v104 then
                                    local v254 = v39 - v108 - v112 - v252 * v57;
                                    if v254 * v254 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v255 = (v40 + v31 - v110 - v113) / v60;
                            if v255 * v255 < v67 then
                                local v256 = v41 - v106 - v111 - v255 * v63;
                                if v256 * v256 < v104 then
                                    local v257 = v39 - v108 - v112 - v255 * v57;
                                    if v257 * v257 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v258 = (v41 - v32 + v111 + v105) / v64;
                            if v258 * v258 < v68 then
                                local v259 = v39 + v112 + v107 - v258 * v58;
                                if v259 * v259 < v102 then
                                    local v260 = v40 + v113 + v109 - v258 * v61;
                                    if v260 * v260 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v261 = (v41 + v32 + v111 + v105) / v64;
                            if v261 * v261 < v68 then
                                local v262 = v39 + v112 + v107 - v261 * v58;
                                if v262 * v262 < v102 then
                                    local v263 = v40 + v113 + v109 - v261 * v61;
                                    if v263 * v263 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v264 = (v41 - v32 - v111 + v105) / v64;
                            if v264 * v264 < v68 then
                                local v265 = v39 - v112 + v107 - v264 * v58;
                                if v265 * v265 < v102 then
                                    local v266 = v40 - v113 + v109 - v264 * v61;
                                    if v266 * v266 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v267 = (v41 + v32 - v111 + v105) / v64;
                            if v267 * v267 < v68 then
                                local v268 = v39 - v112 + v107 - v267 * v58;
                                if v268 * v268 < v102 then
                                    local v269 = v40 - v113 + v109 - v267 * v61;
                                    if v269 * v269 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v270 = (v41 - v32 + v111 - v105) / v64;
                            if v270 * v270 < v68 then
                                local v271 = v39 + v112 - v107 - v270 * v58;
                                if v271 * v271 < v102 then
                                    local v272 = v40 + v113 - v109 - v270 * v61;
                                    if v272 * v272 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v273 = (v41 + v32 + v111 - v105) / v64;
                            if v273 * v273 < v68 then
                                local v274 = v39 + v112 - v107 - v273 * v58;
                                if v274 * v274 < v102 then
                                    local v275 = v40 + v113 - v109 - v273 * v61;
                                    if v275 * v275 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v276 = (v41 - v32 - v111 - v105) / v64;
                            if v276 * v276 < v68 then
                                local v277 = v39 - v112 - v107 - v276 * v58;
                                if v277 * v277 < v102 then
                                    local v278 = v40 - v113 - v109 - v276 * v61;
                                    if v278 * v278 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v279 = (v41 + v32 - v111 - v105) / v64;
                            if v279 * v279 < v68 then
                                local v280 = v39 - v112 - v107 - v279 * v58;
                                if v280 * v280 < v102 then
                                    local v281 = v40 - v113 - v109 - v279 * v61;
                                    if v281 * v281 < v103 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v282 = (v39 - v30 + v112 + v107) / v58;
                            if v282 * v282 < v68 then
                                local v283 = v40 + v113 + v109 - v282 * v61;
                                if v283 * v283 < v103 then
                                    local v284 = v41 + v111 + v105 - v282 * v64;
                                    if v284 * v284 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v285 = (v39 + v30 + v112 + v107) / v58;
                            if v285 * v285 < v68 then
                                local v286 = v40 + v113 + v109 - v285 * v61;
                                if v286 * v286 < v103 then
                                    local v287 = v41 + v111 + v105 - v285 * v64;
                                    if v287 * v287 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v288 = (v39 - v30 - v112 + v107) / v58;
                            if v288 * v288 < v68 then
                                local v289 = v40 - v113 + v109 - v288 * v61;
                                if v289 * v289 < v103 then
                                    local v290 = v41 - v111 + v105 - v288 * v64;
                                    if v290 * v290 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v291 = (v39 + v30 - v112 + v107) / v58;
                            if v291 * v291 < v68 then
                                local v292 = v40 - v113 + v109 - v291 * v61;
                                if v292 * v292 < v103 then
                                    local v293 = v41 - v111 + v105 - v291 * v64;
                                    if v293 * v293 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v294 = (v39 - v30 + v112 - v107) / v58;
                            if v294 * v294 < v68 then
                                local v295 = v40 + v113 - v109 - v294 * v61;
                                if v295 * v295 < v103 then
                                    local v296 = v41 + v111 - v105 - v294 * v64;
                                    if v296 * v296 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v297 = (v39 + v30 + v112 - v107) / v58;
                            if v297 * v297 < v68 then
                                local v298 = v40 + v113 - v109 - v297 * v61;
                                if v298 * v298 < v103 then
                                    local v299 = v41 + v111 - v105 - v297 * v64;
                                    if v299 * v299 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v300 = (v39 - v30 - v112 - v107) / v58;
                            if v300 * v300 < v68 then
                                local v301 = v40 - v113 - v109 - v300 * v61;
                                if v301 * v301 < v103 then
                                    local v302 = v41 - v111 - v105 - v300 * v64;
                                    if v302 * v302 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v303 = (v39 + v30 - v112 - v107) / v58;
                            if v303 * v303 < v68 then
                                local v304 = v40 - v113 - v109 - v303 * v61;
                                if v304 * v304 < v103 then
                                    local v305 = v41 - v111 - v105 - v303 * v64;
                                    if v305 * v305 < v104 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v306 = (v40 - v31 + v113 + v109) / v61;
                            if v306 * v306 < v68 then
                                local v307 = v41 + v111 + v105 - v306 * v64;
                                if v307 * v307 < v104 then
                                    local v308 = v39 + v112 + v107 - v306 * v58;
                                    if v308 * v308 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v309 = (v40 + v31 + v113 + v109) / v61;
                            if v309 * v309 < v68 then
                                local v310 = v41 + v111 + v105 - v309 * v64;
                                if v310 * v310 < v104 then
                                    local v311 = v39 + v112 + v107 - v309 * v58;
                                    if v311 * v311 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v312 = (v40 - v31 - v113 + v109) / v61;
                            if v312 * v312 < v68 then
                                local v313 = v41 - v111 + v105 - v312 * v64;
                                if v313 * v313 < v104 then
                                    local v314 = v39 - v112 + v107 - v312 * v58;
                                    if v314 * v314 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v315 = (v40 + v31 - v113 + v109) / v61;
                            if v315 * v315 < v68 then
                                local v316 = v41 - v111 + v105 - v315 * v64;
                                if v316 * v316 < v104 then
                                    local v317 = v39 - v112 + v107 - v315 * v58;
                                    if v317 * v317 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v318 = (v40 - v31 + v113 - v109) / v61;
                            if v318 * v318 < v68 then
                                local v319 = v41 + v111 - v105 - v318 * v64;
                                if v319 * v319 < v104 then
                                    local v320 = v39 + v112 - v107 - v318 * v58;
                                    if v320 * v320 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v321 = (v40 + v31 + v113 - v109) / v61;
                            if v321 * v321 < v68 then
                                local v322 = v41 + v111 - v105 - v321 * v64;
                                if v322 * v322 < v104 then
                                    local v323 = v39 + v112 - v107 - v321 * v58;
                                    if v323 * v323 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v324 = (v40 - v31 - v113 - v109) / v61;
                            if v324 * v324 < v68 then
                                local v325 = v41 - v111 - v105 - v324 * v64;
                                if v325 * v325 < v104 then
                                    local v326 = v39 - v112 - v107 - v324 * v58;
                                    if v326 * v326 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            local v327 = (v40 + v31 - v113 - v109) / v61;
                            if v327 * v327 < v68 then
                                local v328 = v41 - v111 - v105 - v327 * v64;
                                if v328 * v328 < v104 then
                                    local v329 = v39 - v112 - v107 - v327 * v58;
                                    if v329 * v329 < v102 then
                                        return true;
                                    end;
                                end;
                            end;
                            return false;
                        end;
                        if v35 then
                            v56 = v35;
                            goto l0;
                        end;
                    end;
                    v56 = v34 < v35 and v34 and v34 or v35;
                    goto l0;
                else
                    break;
                end;
            end;
        end;
        if v32 then
            v54 = v32;
            goto l1;
        end;
    end;
    v54 = v31 < v32 and v31 and v31 or v32;
    goto l1;
end;
