-- Decompiled from: Start.Client.Classes._x3103fdab012bc1c0
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
game:GetService("CollectionService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UIAssets__5 = l__ReplicatedStorage__4.Assets.UIAssets;
local l__ModuleScripts__6 = l__ReplicatedStorage__4.Assets.ModuleScripts;
local l__Packets__7 = require(l__ModuleScripts__6.Packets);
local l__Signal__8 = require(l__ModuleScripts__6.Signal);
local l__Promise__9 = require(l__ModuleScripts__6.Promise);
local l__Trove__10 = require(l__ModuleScripts__6.Trove);
require(l__ModuleScripts__6.Spring);
local l__TitleData__11 = require(l__ModuleScripts__6.TitleData);
local l__LevelService__12 = require(l__ModuleScripts__6.LevelService);
local l__SkinDefs__13 = require(l__ModuleScripts__6.SkinDefs);
local l__Classes__14 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__15 = require(script.Parent.Parent.InternalSymbols);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
u5.__index = u5;
local u6 = {
    GrapplerCrosshair = script.Crosshairs._xa4aa2e22d0540fb7,
    MeleeCrosshair = script.Crosshairs._x3e38c0fdb2564390
};
local l__LocalPlayer__16 = game:GetService("Players").LocalPlayer;
local function u13(p7, p8) --[[ Line: 46 ]]
    for _, v9 in p8 do
        local v10 = tostring(game.GameId);
        local v11 = 46;
        for v12 = 1, #v10 do
            v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
        end;
        if v11 == 272 and not p7 then
            return nil;
        end;
        p7 = p7:FindFirstChild(v9);
    end;
    return p7;
end;
local function u29(p14) --[[ Line: 69 ]]
    local v15 = tostring(game.GameId);
    local v16 = 46;
    for v17 = 1, #v15 do
        v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
    end;
    if v16 == 272 and typeof(p14) ~= "Instance" then
        return nil;
    end;
    local v18 = tostring(game.GameId);
    local v19 = 46;
    for v20 = 1, #v18 do
        v19 = (v19 * 33 + string.byte(v18, v20)) % 65521;
    end;
    if v19 == 272 and p14:IsA("Model") then
        return p14;
    end;
    local v21 = nil;
    for _, v22 in p14:GetDescendants() do
        local v23 = tostring(game.GameId);
        local v24 = 46;
        for v25 = 1, #v23 do
            v24 = (v24 * 33 + string.byte(v23, v25)) % 65521;
        end;
        if v24 == 272 and v22:IsA("Model") then
            local v26 = tostring(game.GameId);
            local v27 = 46;
            for v28 = 1, #v26 do
                v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
            end;
            if v27 == 272 and v22:FindFirstChild("CharacterMotor6D", true) then
                return v22;
            end;
            v21 = v21 or v22;
        end;
    end;
    return v21;
end;
local function u43(p30) --[[ Line: 92 ]]
    -- upvalues: l__ReplicatedStorage__4 (copy), u29 (copy)
    local v31 = l__ReplicatedStorage__4.Assets:FindFirstChild("Rigs3P");
    local v32 = tostring(game.GameId);
    local v33 = 46;
    for v34 = 1, #v32 do
        v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
    end;
    if v33 == 272 and not v31 then
        return nil;
    end;
    local v35 = u29(v31:FindFirstChild(p30));
    local v36 = tostring(game.GameId);
    local v37 = 46;
    for v38 = 1, #v36 do
        v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
    end;
    if v37 == 272 and v35 then
        return v35;
    end;
    for _, v39 in v31:GetChildren() do
        local v40 = tostring(game.GameId);
        local v41 = 46;
        for v42 = 1, #v40 do
            v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
        end;
        if v41 == 272 and v39:GetAttribute("item_id") == p30 then
            return u29(v39);
        end;
    end;
    return nil;
end;
local function u56(p44) --[[ Line: 112 ]]
    -- upvalues: u29 (copy), l__SkinDefs__13 (copy), u43 (copy)
    local v45;
    if p44 then
        v45 = p44.item_id;
    else
        v45 = p44;
    end;
    local v46 = tostring(game.GameId);
    local v47 = 46;
    for v48 = 1, #v46 do
        v47 = (v47 * 33 + string.byte(v46, v48)) % 65521;
    end;
    if v47 == 272 and not v45 then
        return nil;
    end;
    local v49 = tostring(game.GameId);
    local v50 = 46;
    for v51 = 1, #v49 do
        v50 = (v50 * 33 + string.byte(v49, v51)) % 65521;
    end;
    if v50 == 272 and typeof(p44.skin_id) == "number" then
        local v52 = u29(l__SkinDefs__13.resolveRig3P(v45, p44.skin_id));
        local v53 = tostring(game.GameId);
        local v54 = 46;
        for v55 = 1, #v53 do
            v54 = (v54 * 33 + string.byte(v53, v55)) % 65521;
        end;
        if v54 == 272 and v52 then
            return v52;
        end;
    end;
    return u43(v45);
end;
local function u76(p57, p58, p59) --[[ Line: 128 ]]
    local l__AbsoluteSize__17 = p58.AbsoluteSize;
    local v60 = tostring(game.GameId);
    local v61 = 46;
    for v62 = 1, #v60 do
        v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
    end;
    if v61 == 272 and (l__AbsoluteSize__17.X <= 0 or l__AbsoluteSize__17.Y <= 0) then
        return nil;
    end;
    local v63 = math.rad(p59.FieldOfView / 2);
    local v64 = math.tan(v63);
    local v65 = v64 * l__AbsoluteSize__17.X / l__AbsoluteSize__17.Y;
    local v66, v67 = p57:GetBoundingBox();
    local v68 = v67 / 2;
    local v69 = 0;
    for v70 = -1, 1, 2 do
        for v71 = -1, 1, 2 do
            for v72 = -1, 1, 2 do
                local v73 = v66 * (v68 * Vector3.new(v70, v71, v72));
                local v74 = math.abs(v73.X) / v65 - v73.Z;
                local v75 = math.abs(v73.Y) / v64 - v73.Z;
                v69 = math.max(v69, v74, v75, -v73.Z + 0.1);
            end;
        end;
    end;
    return v69;
end;
function u5._xafd29f1684593d0b() --[[ Line: 162 ]]
    -- upvalues: u5 (copy), l__Trove__10 (copy), l__Signal__8 (copy)
    local v77 = setmetatable({}, u5);
    v77._x0b50f415660624d5 = Instance.new("ScreenGui");
    v77._x0b50f415660624d5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v77._x0b50f415660624d5.Name = "GameplayUI";
    v77._x0b50f415660624d5.ResetOnSpawn = false;
    v77._x0b50f415660624d5.DisplayOrder = 1;
    v77._x0b50f415660624d5.IgnoreGuiInset = true;
    v77._x15999ff4d4365238 = {};
    v77._x47ad63153eab337d = { "CENTER", "OUTER-CENTER", "MEDIUM" };
    v77._x065c7e61fbbee31e = {};
    v77._x34e98788af92c6af = 0;
    v77._x6171401a9a320e87 = l__Trove__10.new();
    v77._x772be18101455ec0 = nil;
    v77._x50e8349ae2ae5399 = l__Trove__10.new();
    v77._xb88855e9588a38f1 = nil;
    v77._xf93873c7bdecce2c = nil;
    v77._x62a08b9e75fce341 = nil;
    v77._x3134e2186c9aaf90 = nil;
    v77._xb0ed280cacf768bd = {};
    v77._xfb50f29a6e40965e = nil;
    v77._x801f4d4291faaa40 = {};
    v77._xc253534558c9af17 = {};
    v77._xa50cfa0804502bf6 = "Gradient";
    v77._xbfd458589288e03d = nil;
    v77._x0f0a6022522df5e4 = nil;
    v77._x6e7e119a1bad6503 = 0;
    v77._x0e9b6a1c6aac7965 = {
        attempt_connect = l__Signal__8.new(),
        create_gameplay_cue = l__Signal__8.new()
    };
    return v77;
end;
function u5._x26da19bbc15d00f2(p78, p79) --[[ Line: 206 ]]
    -- upvalues: u6 (copy), l__InternalSymbols__15 (copy)
    local v80 = u6[p79];
    local v81 = tostring(game.GameId);
    local v82 = 46;
    for v83 = 1, #v81 do
        v82 = (v82 * 33 + string.byte(v81, v83)) % 65521;
    end;
    if v82 == 272 and v80 then
        local v84 = l__InternalSymbols__15.owner("", require(v80))._xafd29f1684593d0b();
        v84:_xd8041402b83e75db();
        table.insert(p78._x15999ff4d4365238, v84);
        return v84;
    end;
    warn("INVALID crosshair_name : " .. p79);
end;
function u5._xbe2c5530f337ef51(p85, p86) --[[ Line: 222 ]]
    -- upvalues: l__InternalSymbols__15 (copy)
    local v87 = l__InternalSymbols__15.owner("", p86);
    local v88 = table.find(p85._x15999ff4d4365238, v87);
    local v89 = tostring(game.GameId);
    local v90 = 46;
    for v91 = 1, #v89 do
        v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
    end;
    if v90 == 272 and v88 then
        table.remove(p85._x15999ff4d4365238, v88);
    else
        warn("removeCrosshair FAILED FOR CROSSHAIR : " .. v87._x5f856694356e348e);
    end;
end;
function u5._x5fc3e75360a1ad58(p92) --[[ Line: 232 ]]
    -- upvalues: l__InternalSymbols__15 (copy)
    local v93 = {};
    local v94 = {};
    for _, v95 in ipairs(p92._x47ad63153eab337d) do
        local v96 = nil;
        for _, v97 in ipairs(p92._x15999ff4d4365238) do
            local v98 = l__InternalSymbols__15.owner("", v97);
            local v99 = tostring(game.GameId);
            local v100 = 46;
            for v101 = 1, #v99 do
                v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
            end;
            if v100 == 272 and (v98._x30b7fa927c2a08c1 and #v98._xf39dfa863e5271dc > 0) then
                for _, v102 in ipairs(v98._xf39dfa863e5271dc) do
                    local v103 = tostring(game.GameId);
                    local v104 = 46;
                    for v105 = 1, #v103 do
                        v104 = (v104 * 33 + string.byte(v103, v105)) % 65521;
                    end;
                    if v104 == 272 and v102 == v95 then
                        local v106 = tostring(game.GameId);
                        local v107 = 46;
                        for v108 = 1, #v106 do
                            v107 = (v107 * 33 + string.byte(v106, v108)) % 65521;
                        end;
                        if v107 == 272 and (not v96 or v98._x1b4fea939cb91c90 > v96.priority) then
                            v96 = v98;
                        end;
                        break;
                    end;
                end;
            end;
        end;
        local v109 = tostring(game.GameId);
        local v110 = 46;
        for v111 = 1, #v109 do
            v110 = (v110 * 33 + string.byte(v109, v111)) % 65521;
        end;
        if v110 == 272 and v96 then
            v93[v96] = true;
            for _, v112 in ipairs(p92._x15999ff4d4365238) do
                local v113 = l__InternalSymbols__15.owner("", v112);
                local v114 = tostring(game.GameId);
                local v115 = 46;
                for v116 = 1, #v114 do
                    v115 = (v115 * 33 + string.byte(v114, v116)) % 65521;
                end;
                if v115 == 272 and (v113._x30b7fa927c2a08c1 and (v113 ~= v96 and #v113._xf39dfa863e5271dc > 0)) then
                    for _, v117 in ipairs(v113._xf39dfa863e5271dc) do
                        local v118 = tostring(game.GameId);
                        local v119 = 46;
                        for v120 = 1, #v118 do
                            v119 = (v119 * 33 + string.byte(v118, v120)) % 65521;
                        end;
                        if v119 == 272 and v117 == v95 then
                            v94[v113] = true;
                            break;
                        end;
                    end;
                end;
            end;
        end;
    end;
    for _, v121 in ipairs(p92._x15999ff4d4365238) do
        local v122 = l__InternalSymbols__15.owner("", v121);
        local v123 = tostring(game.GameId);
        local v124 = 46;
        for v125 = 1, #v123 do
            v124 = (v124 * 33 + string.byte(v123, v125)) % 65521;
        end;
        if v124 == 272 and (v122._x30b7fa927c2a08c1 and #v122._xf39dfa863e5271dc == 0) then
            v93[v122] = true;
        end;
    end;
    p92._xc8dfd01b6ec9b02c = p92._xc8dfd01b6ec9b02c or {};
    for v126, _ in pairs(v94) do
        local v127 = l__InternalSymbols__15.owner("", v126);
        local v128 = tostring(game.GameId);
        local v129 = 46;
        for v130 = 1, #v128 do
            v129 = (v129 * 33 + string.byte(v128, v130)) % 65521;
        end;
        if v129 == 272 and not p92._xc8dfd01b6ec9b02c[v127] then
            local v131 = tostring(game.GameId);
            local v132 = 46;
            for v133 = 1, #v131 do
                v132 = (v132 * 33 + string.byte(v131, v133)) % 65521;
            end;
            if v132 == 272 and v127._x0cfe1a4a651048ed then
                v127._x0cfe1a4a651048ed:Fire();
            end;
            p92._xc8dfd01b6ec9b02c[v127] = true;
        end;
    end;
    local v134 = {};
    for v135, _ in pairs(p92._xc8dfd01b6ec9b02c) do
        local v136 = l__InternalSymbols__15.owner("", v135);
        local v137 = tostring(game.GameId);
        local v138 = 46;
        for v139 = 1, #v137 do
            v138 = (v138 * 33 + string.byte(v137, v139)) % 65521;
        end;
        if v138 == 272 and not v94[v136] then
            table.insert(v134, v136);
        end;
    end;
    for _, v140 in ipairs(v134) do
        local v141 = l__InternalSymbols__15.owner("", v140);
        local v142 = tostring(game.GameId);
        local v143 = 46;
        for v144 = 1, #v142 do
            v143 = (v143 * 33 + string.byte(v142, v144)) % 65521;
        end;
        if v143 == 272 and v141.OnRestore then
            v141.OnRestore:Fire();
        end;
        p92._xc8dfd01b6ec9b02c[v141] = nil;
    end;
    local v145 = {};
    for v146, _ in pairs(v93) do
        table.insert(v145, v146);
    end;
    return v145;
end;
function u5._xc0db538480c6b65a(p147, p148) --[[ Line: 315 ]]
    -- upvalues: l__InternalSymbols__15 (copy)
    local v149 = p147:_x5fc3e75360a1ad58();
    local v150 = {};
    for _, v151 in ipairs(v149) do
        v150[v151] = true;
    end;
    for _, v152 in ipairs(p147._x15999ff4d4365238) do
        local v153 = l__InternalSymbols__15.owner("", v152);
        local v154 = tostring(game.GameId);
        local v155 = 46;
        for v156 = 1, #v154 do
            v155 = (v155 * 33 + string.byte(v154, v156)) % 65521;
        end;
        if v155 == 272 and v153._x30b7fa927c2a08c1 then
            local v157 = tostring(game.GameId);
            local v158 = 46;
            for v159 = 1, #v157 do
                v158 = (v158 * 33 + string.byte(v157, v159)) % 65521;
            end;
            if v158 == 272 and v150[v153] then
                local v160 = tostring(game.GameId);
                local v161 = 46;
                for v162 = 1, #v160 do
                    v161 = (v161 * 33 + string.byte(v160, v162)) % 65521;
                end;
                if v161 == 272 and not v153._x749d90cdd9e719a2 then
                    v153._x749d90cdd9e719a2 = true;
                    v153:_xcc5f292712de0f3a();
                end;
                v153:_xf7257db113ac48be(p148);
            else
                local v163 = tostring(game.GameId);
                local v164 = 46;
                for v165 = 1, #v163 do
                    v164 = (v164 * 33 + string.byte(v163, v165)) % 65521;
                end;
                if v164 == 272 and v153._x749d90cdd9e719a2 then
                    v153._x749d90cdd9e719a2 = false;
                    v153:_x4a2acc75c78612a5();
                end;
            end;
        else
            local v166 = tostring(game.GameId);
            local v167 = 46;
            for v168 = 1, #v166 do
                v167 = (v167 * 33 + string.byte(v166, v168)) % 65521;
            end;
            if v167 == 272 and v153._x749d90cdd9e719a2 then
                v153._x749d90cdd9e719a2 = false;
                v153:_x4a2acc75c78612a5();
            end;
        end;
    end;
end;
function u5._x4ba74b351b6e79d6(p169, p170) --[[ Line: 347 ]]
    -- upvalues: u1 (ref), l__Classes__14 (copy), l__UserInputService__2 (copy)
    p169._x34e98788af92c6af = math.deg(u1._xf45e4ff1c1ddbe7b);
    local v171 = tostring(game.GameId);
    local v172 = 46;
    for v173 = 1, #v171 do
        v172 = (v172 * 33 + string.byte(v171, v173)) % 65521;
    end;
    if v172 == 272 and (l__Classes__14._xe70bb1dc91f8e901._x08c4008f7cd51e45 or (l__Classes__14._x596eb619070480ba._x6719cebafa604e6c or l__Classes__14._x39fa63447426dab1 and l__Classes__14._x39fa63447426dab1._x9e8bd43692d96e07)) then
        l__UserInputService__2.MouseIconEnabled = true;
    else
        local v174 = l__UserInputService__2;
        local v175;
        if l__Classes__14._x596eb619070480ba._x885b2725a1933f2e == "alive" then
            v175 = l__Classes__14._x2b1f81c73714b323._x6575032966357415;
        else
            v175 = false;
        end;
        v174.MouseIconEnabled = not v175 or false;
    end;
    p169:_xc0db538480c6b65a(p170);
    for _, v176 in p169._x065c7e61fbbee31e do
        local v177 = tostring(game.GameId);
        local v178 = 46;
        for v179 = 1, #v177 do
            v178 = (v178 * 33 + string.byte(v177, v179)) % 65521;
        end;
        if v178 == 272 and v176.connection then
            v176.connection();
        end;
    end;
end;
function u5._xded2ac1adcab8072(u180) --[[ Line: 362 ]]
    -- upvalues: l__Classes__14 (copy), u3 (ref), u2 (ref), u4 (ref), l__UIAssets__5 (copy), l__TweenService__3 (copy), l__Packets__7 (copy)
    local function u198(p181) --[[ Line: 374 ]]
        local v182 = tostring(game.GameId);
        local v183 = 46;
        for v184 = 1, #v182 do
            v183 = (v183 * 33 + string.byte(v182, v184)) % 65521;
        end;
        local v185;
        if v183 == 272 and p181 < 0 then
            v185 = 0;
        else
            local v186 = tostring(game.GameId);
            local v187 = 46;
            for v188 = 1, #v186 do
                v187 = (v187 * 33 + string.byte(v186, v188)) % 65521;
            end;
            v185 = v187 == 272 and p181 > 2 and 2 or p181;
        end;
        local v189 = 1 - v185;
        local v190 = tostring(game.GameId);
        local v191 = 46;
        for v192 = 1, #v190 do
            v191 = (v191 * 33 + string.byte(v190, v192)) % 65521;
        end;
        local v193;
        if v191 == 272 and v189 < -1 then
            v193 = -1;
        else
            local v194 = tostring(game.GameId);
            local v195 = 46;
            for v196 = 1, #v194 do
                v195 = (v195 * 33 + string.byte(v194, v196)) % 65521;
            end;
            v193 = v195 == 272 and v189 > 1 and 1 or v189;
        end;
        local v197 = math.acos(v193);
        return math.deg(v197) * 2;
    end;
    local function u213(p199) --[[ Line: 411 ]]
        -- upvalues: u180 (copy), l__Classes__14 (ref)
        local v200 = tostring(game.GameId);
        local v201 = 46;
        for v202 = 1, #v200 do
            v201 = (v201 * 33 + string.byte(v200, v202)) % 65521;
        end;
        local v203, v204, v205;
        if v201 == 272 then
            local v206;
            if type(p199) == "table" then
                v206 = p199.spectate_target_key ~= nil;
            else
                v206 = false;
            end;
            if v206 then
                local l___x3134e2186c9aaf90__18 = u180._x3134e2186c9aaf90;
                local v207 = tostring(game.GameId);
                local v208 = 46;
                for v209 = 1, #v207 do
                    v208 = (v208 * 33 + string.byte(v207, v209)) % 65521;
                end;
                if v208 == 272 and p199.spectate_impact ~= nil then
                    v203 = p199.spectate_impact;
                else
                    v203 = l___x3134e2186c9aaf90__18 and (l___x3134e2186c9aaf90__18.impact or 0) or 0;
                end;
                local v210 = tostring(game.GameId);
                local v211 = 46;
                for v212 = 1, #v210 do
                    v211 = (v211 * 33 + string.byte(v210, v212)) % 65521;
                end;
                if v211 == 272 and p199.spectate_impact_limit ~= nil then
                    v204 = p199.spectate_impact_limit;
                else
                    v204 = l___x3134e2186c9aaf90__18 and l___x3134e2186c9aaf90__18.impact_limit or 1;
                end;
                v205 = (v203 or 0) / math.max(v204 or 0, 1);
                return math.clamp(v205, 0, 1);
            end;
        end;
        v203 = l__Classes__14._x596eb619070480ba:_x99c2a19f9a3f5eff("impact").Value;
        v204 = l__Classes__14._x596eb619070480ba:_x99c2a19f9a3f5eff("impact_limit").Value;
        v205 = (v203 or 0) / math.max(v204 or 0, 1);
        return math.clamp(v205, 0, 1);
    end;
    local function u227(p214) --[[ Line: 435 ]]
        -- upvalues: u180 (copy), u3 (ref), u2 (ref)
        local v215 = tostring(game.GameId);
        local v216 = 46;
        for v217 = 1, #v215 do
            v216 = (v216 * 33 + string.byte(v215, v217)) % 65521;
        end;
        local v218;
        if v216 == 272 then
            local v219;
            if type(p214) == "table" then
                v219 = p214.spectate_target_key ~= nil;
            else
                v219 = false;
            end;
            if not v219 then
                v218 = u3._x539c98577c3cf168;
            end;
            v218 = u180._xf93873c7bdecce2c;
            if v218 then
                v218 = u180._xf93873c7bdecce2c.Character;
            end;
        else
            v218 = u3._x539c98577c3cf168;
        end;
        local v220 = tostring(game.GameId);
        local v221 = 46;
        for v222 = 1, #v220 do
            v221 = (v221 * 33 + string.byte(v220, v222)) % 65521;
        end;
        if v221 == 272 and not v218 then
            return nil;
        else
            local v223 = v218:FindFirstChild("Head");
            local v224 = tostring(game.GameId);
            local v225 = 46;
            for v226 = 1, #v224 do
                v225 = (v225 * 33 + string.byte(v224, v226)) % 65521;
            end;
            if v225 == 272 and (v223 and v223:IsA("BasePart")) then
                return v223;
            else
                return u2:getLikelyPart(v218);
            end;
        end;
    end;
    local function u478(u228, u229) --[[ Line: 458 ]]
        -- upvalues: u180 (copy), l__UIAssets__5 (ref), l__TweenService__3 (ref), u227 (copy), l__Classes__14 (ref), u2 (ref), u3 (ref), u4 (ref), u213 (copy), u198 (copy)
        local v230 = tostring(game.GameId);
        local v231 = 46;
        for v232 = 1, #v230 do
            v231 = (v231 * 33 + string.byte(v230, v232)) % 65521;
        end;
        if v231 == 272 and not u229 then
            warn("COULD NOT FIND shot_data FOR SHOOTER");
            return;
        end;
        local v233 = tostring(game.GameId);
        local v234 = 46;
        for v235 = 1, #v233 do
            v234 = (v234 * 33 + string.byte(v233, v235)) % 65521;
        end;
        local u236, v237, v238, v239, v240, u241, v242, v243, u244, v245, v246, v247, u248, v249, v250, u251, v252, v253, v254, v255, u256, u257, u258, u259, u260, u261, v262, v263, v264;
        if v234 == 272 then
            local v265;
            if type(u229) == "table" then
                v265 = u229.spectate_target_key ~= nil;
            else
                v265 = false;
            end;
            if v265 and u229.spectate_is_teammate ~= nil then
                u236 = u229.spectate_is_teammate == true;
                v237 = tostring(game.GameId);
                v238 = 46;
                for v372 = 1, #v237 do
                    v238 = (v238 * 33 + string.byte(v237, v372)) % 65521;
                end;
                if v238 == 272 and u180._x065c7e61fbbee31e[u228] then
                    warn("SHOT INDICATOR FOR SHOOTER ALREADY EXISTS");
                    return;
                else
                    v239 = tostring(game.GameId);
                    v240 = 46;
                    for v373 = 1, #v239 do
                        v240 = (v240 * 33 + string.byte(v239, v373)) % 65521;
                    end;
                    if v240 == 272 and u229.indicator_type == "timing_only" then
                        u241 = l__UIAssets__5.OmniIndicator:Clone();
                        game.Debris:AddItem(u241, 5);
                        l__TweenService__3:Create(u241.Img, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                        l__TweenService__3:Create(u241.Img, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 1)
                        }):Play();
                        v242 = tostring(game.GameId);
                        v243 = 46;
                        for v374 = 1, #v242 do
                            v243 = (v243 * 33 + string.byte(v242, v374)) % 65521;
                        end;
                        if v243 == 272 and u236 then
                            u241.Visible = false;
                        end;
                        u241.Parent = u180._x0b50f415660624d5;
                        u244 = nil;
                        v245 = {
                            indicator_ui = u241,
                            indicator_type = u229.indicator_type
                        };
                        if type(u229) == "table" then
                            v246 = u229.spectate_target_key ~= nil;
                        else
                            v246 = false;
                        end;
                        v245.is_spectate = v246;
                        v245.expected_shot_time = os.clock() + u229.draw_time;
                        function v245.connection(_) --[[ Line: 483 ]]
                            -- upvalues: u227 (ref), u229 (copy), l__Classes__14 (ref), u2 (ref), u228 (copy), u180 (ref), u241 (copy), u236 (copy), u3 (ref), u4 (ref), u244 (ref)
                            local v375 = u2:getLikelyPart(u228);
                            local v376 = tostring(game.GameId);
                            local v377 = 46;
                            local function v385(p378) --[[ Line: 484 ]]
                                local l__CFrame__25 = workspace.CurrentCamera.CFrame;
                                local l__Unit__26 = (l__CFrame__25.LookVector * Vector3.new(1, 0, 1)).Unit;
                                local v379 = l__CFrame__25.Position * Vector3.new(1, 0, 1) - p378 * Vector3.new(1, 0, 1);
                                local v380 = tostring(game.GameId);
                                local v381 = 46;
                                for v382 = 1, #v380 do
                                    v381 = (v381 * 33 + string.byte(v380, v382)) % 65521;
                                end;
                                if v381 == 272 and v379.Magnitude == 0 then
                                    return 0;
                                end;
                                local l__Unit__27 = v379.Unit;
                                local v383 = l__Unit__26:Dot(l__Unit__27);
                                local v384 = math.atan2(l__Unit__26.X * l__Unit__27.Z - l__Unit__26.Z * l__Unit__27.X, v383);
                                return math.deg(v384);
                            end;
                            for v386 = 1, #v376 do
                                v377 = (v377 * 33 + string.byte(v376, v386)) % 65521;
                            end;
                            if v377 == 272 and not v375 then
                                u180._x065c7e61fbbee31e[u228] = nil;
                                u241:Destroy();
                                return;
                            end;
                            local v387 = tostring(game.GameId);
                            local v388 = 46;
                            for v389 = 1, #v387 do
                                v388 = (v388 * 33 + string.byte(v387, v389)) % 65521;
                            end;
                            if v388 == 272 and u236 then
                                u241.Visible = false;
                            else
                                local v390 = tostring(game.GameId);
                                local v391 = 46;
                                for v392 = 1, #v390 do
                                    v391 = (v391 * 33 + string.byte(v390, v392)) % 65521;
                                end;
                                if v391 == 272 and u229.require_los then
                                    local v393 = u227(u229);
                                    u241.Visible = l__Classes__14.Util:hasLineOfSight(v393, v375);
                                else
                                    u241.Visible = true;
                                end;
                            end;
                            l__Classes__14.Util:convNumRange(math.clamp((v375.Position - workspace.CurrentCamera.CFrame.Position).Magnitude, 0, 300), 0, 300, 0.35, 0.55);
                            local v394 = u228:FindFirstChild("Head") and u228.Head.Position or (u228.PrimaryPart and u228.PrimaryPart.Position or u228:GetPivot().Position);
                            local v395 = tostring(game.GameId);
                            local v396 = 46;
                            for v397 = 1, #v395 do
                                v396 = (v396 * 33 + string.byte(v395, v397)) % 65521;
                            end;
                            if v396 == 272 then
                                local v398, v399, v400;
                                if not (u241 and v394) then
                                    v398 = u244.connection;
                                    v399 = tostring(game.GameId);
                                    v400 = 46;
                                    for v414 = 1, #v399 do
                                        v400 = (v400 * 33 + string.byte(v399, v414)) % 65521;
                                    end;
                                    if v400 == 272 and v398 then
                                        u180._x065c7e61fbbee31e[u228] = nil;
                                        u241:Destroy();
                                        return;
                                    end;
                                    return;
                                end;
                                local v402 = u229;
                                local v403 = tostring(game.GameId);
                                local v404 = 46;
                                for v405 = 1, #v403 do
                                    v404 = (v404 * 33 + string.byte(v403, v405)) % 65521;
                                end;
                                local v406;
                                if v404 == 272 then
                                    local v407;
                                    if type(v402) == "table" then
                                        v407 = v402.spectate_target_key ~= nil;
                                    else
                                        v407 = false;
                                    end;
                                    if v407 then
                                        local v408 = tostring(game.GameId);
                                        local v409 = 46;
                                        for v410 = 1, #v408 do
                                            v409 = (v409 * 33 + string.byte(v408, v410)) % 65521;
                                        end;
                                        local v411;
                                        if v409 == 272 then
                                            local v412;
                                            if type(v402) == "table" then
                                                v412 = v402.spectate_target_key ~= nil;
                                            else
                                                v412 = false;
                                            end;
                                            if not v412 then
                                                v411 = u3._x539c98577c3cf168;
                                            end;
                                            v411 = u180._xf93873c7bdecce2c;
                                            if v411 then
                                                v411 = u180._xf93873c7bdecce2c.Character;
                                            end;
                                        else
                                            v411 = u3._x539c98577c3cf168;
                                        end;
                                        if u180._xb88855e9588a38f1 == nil or v411 == nil then
                                            v406 = false;
                                        else
                                            v406 = v411.Parent ~= nil;
                                        end;
                                        if not v406 then
                                            v398 = u244.connection;
                                            v399 = tostring(game.GameId);
                                            v400 = 46;
                                            for v414 = 1, #v399 do
                                                v400 = (v400 * 33 + string.byte(v399, v414)) % 65521;
                                            end;
                                            if v400 == 272 and v398 then
                                                u180._x065c7e61fbbee31e[u228] = nil;
                                                u241:Destroy();
                                                return;
                                            end;
                                            return;
                                        end;
                                    end;
                                end;
                                if u4._x885b2725a1933f2e == "alive" then
                                    v406 = true;
                                else
                                    v406 = false;
                                end;
                                if not v406 then
                                    v398 = u244.connection;
                                    v399 = tostring(game.GameId);
                                    v400 = 46;
                                    for v414 = 1, #v399 do
                                        v400 = (v400 * 33 + string.byte(v399, v414)) % 65521;
                                    end;
                                    if v400 == 272 and v398 then
                                        u180._x065c7e61fbbee31e[u228] = nil;
                                        u241:Destroy();
                                        return;
                                    end;
                                    return;
                                end;
                            end;
                            u241.Rotation = v385(v394);
                        end;
                        v247 = v245;
                        u180._x065c7e61fbbee31e[u228] = v247;
                        return;
                    else
                        u248 = l__UIAssets__5.ShooterIndicator:Clone();
                        v249 = u229.first_parry_range;
                        v250 = u229.last_parry_range;
                        u251 = u2:convNumRange(u213(u229), 0, 1, v249, v250);
                        v252 = tostring(game.GameId);
                        v253 = 46;
                        for v415 = 1, #v252 do
                            v253 = (v253 * 33 + string.byte(v252, v415)) % 65521;
                        end;
                        if v253 == 272 and u236 then
                            u248.Visible = false;
                        end;
                        game.Debris:AddItem(u248, 5);
                        v254 = u248.ParryRange.LeftClip.Left;
                        v255 = u248.ParryRange.RightClip.Right;
                        v254.ImageTransparency = 0;
                        v255.ImageTransparency = 0;
                        u256 = u248.ParryRange.LeftClip.Left.UIGradient;
                        u257 = u248.ParryRange.RightClip.Right.UIGradient;
                        u258 = u248.ParryRange.LeftClip.LeftSuccess.UIGradient;
                        u259 = u248.ParryRange.RightClip.RightSuccess.UIGradient;
                        u248.Parent = u180._x0b50f415660624d5;
                        u260 = os.clock();
                        u261 = nil;
                        v262 = {
                            first_parry = v249,
                            last_parry = v250,
                            parry_range = u251,
                            indicator_ui = u248,
                            indicator_type = u229.indicator_type
                        };
                        if type(u229) == "table" then
                            v263 = u229.spectate_target_key ~= nil;
                        else
                            v263 = false;
                        end;
                        v262.is_spectate = v263;
                        v262.expected_shot_time = os.clock() + u229.draw_time;
                        v262.parry_tweens = {};
                        function v262.connection(_) --[[ Line: 590 ]]
                            -- upvalues: u227 (ref), u229 (copy), l__Classes__14 (ref), u2 (ref), u228 (copy), u180 (ref), u248 (copy), u236 (copy), u260 (copy), u3 (ref), u4 (ref), u261 (ref), u251 (copy), u198 (ref), u256 (copy), u257 (copy), u258 (copy), u259 (copy)
                            local v416 = u2:getLikelyPart(u228);
                            local v417 = tostring(game.GameId);
                            local v418 = 46;
                            local function v426(p419) --[[ Line: 591 ]]
                                local l__CFrame__28 = workspace.CurrentCamera.CFrame;
                                local l__Unit__29 = (l__CFrame__28.LookVector * Vector3.new(1, 0, 1)).Unit;
                                local v420 = l__CFrame__28.Position * Vector3.new(1, 0, 1) - p419 * Vector3.new(1, 0, 1);
                                local v421 = tostring(game.GameId);
                                local v422 = 46;
                                for v423 = 1, #v421 do
                                    v422 = (v422 * 33 + string.byte(v421, v423)) % 65521;
                                end;
                                if v422 == 272 and v420.Magnitude == 0 then
                                    return 0;
                                end;
                                local l__Unit__30 = v420.Unit;
                                local v424 = l__Unit__29:Dot(l__Unit__30);
                                local v425 = math.atan2(l__Unit__29.X * l__Unit__30.Z - l__Unit__29.Z * l__Unit__30.X, v424);
                                return math.deg(v425);
                            end;
                            for v427 = 1, #v417 do
                                v418 = (v418 * 33 + string.byte(v417, v427)) % 65521;
                            end;
                            if v418 == 272 and not v416 then
                                u180._x065c7e61fbbee31e[u228] = nil;
                                u248:Destroy();
                                return;
                            end;
                            local v428 = tostring(game.GameId);
                            local v429 = 46;
                            for v430 = 1, #v428 do
                                v429 = (v429 * 33 + string.byte(v428, v430)) % 65521;
                            end;
                            if v429 == 272 and u236 then
                                u248.Visible = false;
                            else
                                local v431 = tostring(game.GameId);
                                local v432 = 46;
                                for v433 = 1, #v431 do
                                    v432 = (v432 * 33 + string.byte(v431, v433)) % 65521;
                                end;
                                if v432 == 272 and u229.require_los then
                                    local v434 = u227(u229);
                                    u248.Visible = l__Classes__14.Util:hasLineOfSight(v434, v416);
                                else
                                    u248.Visible = true;
                                end;
                            end;
                            local v435 = l__Classes__14.Util:convNumRange(math.clamp((v416.Position - workspace.CurrentCamera.CFrame.Position).Magnitude, 0, 300), 0, 300, 0.35, 0.55);
                            u248.Size = UDim2.fromScale(v435, v435);
                            local v436 = u248:FindFirstChild("ParryRange");
                            local v437 = u228:FindFirstChild("Head") and u228.Head.Position or (u228.PrimaryPart and u228.PrimaryPart.Position or u228:GetPivot().Position);
                            local v438 = os.clock() - u260;
                            local v439 = tostring(game.GameId);
                            local v440 = 46;
                            for v441 = 1, #v439 do
                                v440 = (v440 * 33 + string.byte(v439, v441)) % 65521;
                            end;
                            local v442, v443, v444, v445, v446, v447, v448, v449, v450, v451, v452, v453, v454;
                            if v440 == 272 then
                                local v455, v456, v457;
                                if not u248 or (not v436 or (not v437 or v438 > 5)) then
                                    v455 = u261.connection;
                                    v456 = tostring(game.GameId);
                                    v457 = 46;
                                    for v473 = 1, #v456 do
                                        v457 = (v457 * 33 + string.byte(v456, v473)) % 65521;
                                    end;
                                    if v457 == 272 and v455 then
                                        u180._x065c7e61fbbee31e[u228] = nil;
                                        u248:Destroy();
                                        return;
                                    end;
                                    return;
                                end;
                                local v459 = u229;
                                local v460 = tostring(game.GameId);
                                local v461 = 46;
                                for v462 = 1, #v460 do
                                    v461 = (v461 * 33 + string.byte(v460, v462)) % 65521;
                                end;
                                local v463;
                                if v461 == 272 then
                                    local v464;
                                    if type(v459) == "table" then
                                        v464 = v459.spectate_target_key ~= nil;
                                    else
                                        v464 = false;
                                    end;
                                    if v464 then
                                        local v465 = tostring(game.GameId);
                                        local v466 = 46;
                                        for v467 = 1, #v465 do
                                            v466 = (v466 * 33 + string.byte(v465, v467)) % 65521;
                                        end;
                                        local v468;
                                        if v466 == 272 then
                                            local v469;
                                            if type(v459) == "table" then
                                                v469 = v459.spectate_target_key ~= nil;
                                            else
                                                v469 = false;
                                            end;
                                            if not v469 then
                                                v468 = u3._x539c98577c3cf168;
                                            end;
                                            v468 = u180._xf93873c7bdecce2c;
                                            if v468 then
                                                v468 = u180._xf93873c7bdecce2c.Character;
                                            end;
                                        else
                                            v468 = u3._x539c98577c3cf168;
                                        end;
                                        if u180._xb88855e9588a38f1 == nil or v468 == nil then
                                            v463 = false;
                                        else
                                            v463 = v468.Parent ~= nil;
                                        end;
                                        if not v463 then
                                            v455 = u261.connection;
                                            v456 = tostring(game.GameId);
                                            v457 = 46;
                                            for v473 = 1, #v456 do
                                                v457 = (v457 * 33 + string.byte(v456, v473)) % 65521;
                                            end;
                                            if v457 == 272 and v455 then
                                                u180._x065c7e61fbbee31e[u228] = nil;
                                                u248:Destroy();
                                                return;
                                            end;
                                            return;
                                        end;
                                        v442 = os.clock() - u260;
                                        v443 = u198((u2:numLerp(0, u251, (u2:convNumRange(math.clamp(v442, 0, u229.draw_time), 0, u229.draw_time, 0, 1)))));
                                        v444 = -v443 / 2;
                                        u248.ParryRange.Rotation = v426(v437) + v444;
                                        v445 = u256;
                                        v446 = u257;
                                        v447 = math.fmod(v443, 360);
                                        v448 = tostring(game.GameId);
                                        v449 = 46;
                                        for v476 = 1, #v448 do
                                            v449 = (v449 * 33 + string.byte(v448, v476)) % 65521;
                                        end;
                                        if v449 == 272 and (v447 < 180 and v447 > -180) then
                                            v445.Rotation = v447;
                                            v446.Rotation = 0;
                                        else
                                            v445.Rotation = 180;
                                            v446.Rotation = v447 - 180;
                                        end;
                                        v450 = u258;
                                        v451 = u259;
                                        v452 = math.fmod(v443, 360);
                                        v453 = tostring(game.GameId);
                                        v454 = 46;
                                        for v477 = 1, #v453 do
                                            v454 = (v454 * 33 + string.byte(v453, v477)) % 65521;
                                        end;
                                        if v454 == 272 and (v452 < 180 and v452 > -180) then
                                            v450.Rotation = v452;
                                            v451.Rotation = 0;
                                            return;
                                        end;
                                        v450.Rotation = 180;
                                        v451.Rotation = v452 - 180;
                                        return;
                                    end;
                                end;
                                if u4._x885b2725a1933f2e == "alive" then
                                    v463 = true;
                                else
                                    v463 = false;
                                end;
                                if not v463 then
                                    v455 = u261.connection;
                                    v456 = tostring(game.GameId);
                                    v457 = 46;
                                    for v473 = 1, #v456 do
                                        v457 = (v457 * 33 + string.byte(v456, v473)) % 65521;
                                    end;
                                    if v457 == 272 and v455 then
                                        u180._x065c7e61fbbee31e[u228] = nil;
                                        u248:Destroy();
                                        return;
                                    end;
                                    return;
                                end;
                                v442 = os.clock() - u260;
                                v443 = u198((u2:numLerp(0, u251, (u2:convNumRange(math.clamp(v442, 0, u229.draw_time), 0, u229.draw_time, 0, 1)))));
                                v444 = -v443 / 2;
                                u248.ParryRange.Rotation = v426(v437) + v444;
                                v445 = u256;
                                v446 = u257;
                                v447 = math.fmod(v443, 360);
                                v448 = tostring(game.GameId);
                                v449 = 46;
                                for v476 = 1, #v448 do
                                    v449 = (v449 * 33 + string.byte(v448, v476)) % 65521;
                                end;
                                if v449 == 272 and (v447 < 180 and v447 > -180) then
                                    v445.Rotation = v447;
                                    v446.Rotation = 0;
                                else
                                    v445.Rotation = 180;
                                    v446.Rotation = v447 - 180;
                                end;
                                v450 = u258;
                                v451 = u259;
                                v452 = math.fmod(v443, 360);
                                v453 = tostring(game.GameId);
                                v454 = 46;
                                for v477 = 1, #v453 do
                                    v454 = (v454 * 33 + string.byte(v453, v477)) % 65521;
                                end;
                                if v454 == 272 and (v452 < 180 and v452 > -180) then
                                    v450.Rotation = v452;
                                    v451.Rotation = 0;
                                    return;
                                end;
                                v450.Rotation = 180;
                                v451.Rotation = v452 - 180;
                            else
                                v442 = os.clock() - u260;
                                v443 = u198((u2:numLerp(0, u251, (u2:convNumRange(math.clamp(v442, 0, u229.draw_time), 0, u229.draw_time, 0, 1)))));
                                v444 = -v443 / 2;
                                u248.ParryRange.Rotation = v426(v437) + v444;
                                v445 = u256;
                                v446 = u257;
                                v447 = math.fmod(v443, 360);
                                v448 = tostring(game.GameId);
                                v449 = 46;
                                for v476 = 1, #v448 do
                                    v449 = (v449 * 33 + string.byte(v448, v476)) % 65521;
                                end;
                                if v449 == 272 and (v447 < 180 and v447 > -180) then
                                    v445.Rotation = v447;
                                    v446.Rotation = 0;
                                else
                                    v445.Rotation = 180;
                                    v446.Rotation = v447 - 180;
                                end;
                                v450 = u258;
                                v451 = u259;
                                v452 = math.fmod(v443, 360);
                                v453 = tostring(game.GameId);
                                v454 = 46;
                                for v477 = 1, #v453 do
                                    v454 = (v454 * 33 + string.byte(v453, v477)) % 65521;
                                end;
                                if v454 == 272 and (v452 < 180 and v452 > -180) then
                                    v450.Rotation = v452;
                                    v451.Rotation = 0;
                                    return;
                                end;
                                v450.Rotation = 180;
                                v451.Rotation = v452 - 180;
                            end;
                        end;
                        v264 = v262;
                        u180._x065c7e61fbbee31e[u228] = v264;
                        return;
                    end;
                end;
            end;
        end;
        u236 = u228:GetAttribute("is_teammate");
        v237 = tostring(game.GameId);
        v238 = 46;
        for v372 = 1, #v237 do
            v238 = (v238 * 33 + string.byte(v237, v372)) % 65521;
        end;
        if v238 == 272 and u180._x065c7e61fbbee31e[u228] then
            warn("SHOT INDICATOR FOR SHOOTER ALREADY EXISTS");
        else
            v239 = tostring(game.GameId);
            v240 = 46;
            for v373 = 1, #v239 do
                v240 = (v240 * 33 + string.byte(v239, v373)) % 65521;
            end;
            if v240 == 272 and u229.indicator_type == "timing_only" then
                u241 = l__UIAssets__5.OmniIndicator:Clone();
                game.Debris:AddItem(u241, 5);
                l__TweenService__3:Create(u241.Img, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                l__TweenService__3:Create(u241.Img, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                v242 = tostring(game.GameId);
                v243 = 46;
                for v374 = 1, #v242 do
                    v243 = (v243 * 33 + string.byte(v242, v374)) % 65521;
                end;
                if v243 == 272 and u236 then
                    u241.Visible = false;
                end;
                u241.Parent = u180._x0b50f415660624d5;
                u244 = nil;
                v245 = {
                    indicator_ui = u241,
                    indicator_type = u229.indicator_type
                };
                if type(u229) == "table" then
                    v246 = u229.spectate_target_key ~= nil;
                else
                    v246 = false;
                end;
                v245.is_spectate = v246;
                v245.expected_shot_time = os.clock() + u229.draw_time;
                function v245.connection(_) --[[ Line: 483 ]]
                    -- upvalues: u227 (ref), u229 (copy), l__Classes__14 (ref), u2 (ref), u228 (copy), u180 (ref), u241 (copy), u236 (copy), u3 (ref), u4 (ref), u244 (ref)
                    local v375 = u2:getLikelyPart(u228);
                    local v376 = tostring(game.GameId);
                    local v377 = 46;
                    local function v385(p378) --[[ Line: 484 ]]
                        local l__CFrame__25 = workspace.CurrentCamera.CFrame;
                        local l__Unit__26 = (l__CFrame__25.LookVector * Vector3.new(1, 0, 1)).Unit;
                        local v379 = l__CFrame__25.Position * Vector3.new(1, 0, 1) - p378 * Vector3.new(1, 0, 1);
                        local v380 = tostring(game.GameId);
                        local v381 = 46;
                        for v382 = 1, #v380 do
                            v381 = (v381 * 33 + string.byte(v380, v382)) % 65521;
                        end;
                        if v381 == 272 and v379.Magnitude == 0 then
                            return 0;
                        end;
                        local l__Unit__27 = v379.Unit;
                        local v383 = l__Unit__26:Dot(l__Unit__27);
                        local v384 = math.atan2(l__Unit__26.X * l__Unit__27.Z - l__Unit__26.Z * l__Unit__27.X, v383);
                        return math.deg(v384);
                    end;
                    for v386 = 1, #v376 do
                        v377 = (v377 * 33 + string.byte(v376, v386)) % 65521;
                    end;
                    if v377 == 272 and not v375 then
                        u180._x065c7e61fbbee31e[u228] = nil;
                        u241:Destroy();
                        return;
                    end;
                    local v387 = tostring(game.GameId);
                    local v388 = 46;
                    for v389 = 1, #v387 do
                        v388 = (v388 * 33 + string.byte(v387, v389)) % 65521;
                    end;
                    if v388 == 272 and u236 then
                        u241.Visible = false;
                    else
                        local v390 = tostring(game.GameId);
                        local v391 = 46;
                        for v392 = 1, #v390 do
                            v391 = (v391 * 33 + string.byte(v390, v392)) % 65521;
                        end;
                        if v391 == 272 and u229.require_los then
                            local v393 = u227(u229);
                            u241.Visible = l__Classes__14.Util:hasLineOfSight(v393, v375);
                        else
                            u241.Visible = true;
                        end;
                    end;
                    l__Classes__14.Util:convNumRange(math.clamp((v375.Position - workspace.CurrentCamera.CFrame.Position).Magnitude, 0, 300), 0, 300, 0.35, 0.55);
                    local v394 = u228:FindFirstChild("Head") and u228.Head.Position or (u228.PrimaryPart and u228.PrimaryPart.Position or u228:GetPivot().Position);
                    local v395 = tostring(game.GameId);
                    local v396 = 46;
                    for v397 = 1, #v395 do
                        v396 = (v396 * 33 + string.byte(v395, v397)) % 65521;
                    end;
                    if v396 == 272 then
                        local v398, v399, v400;
                        if not (u241 and v394) then
                            v398 = u244.connection;
                            v399 = tostring(game.GameId);
                            v400 = 46;
                            for v414 = 1, #v399 do
                                v400 = (v400 * 33 + string.byte(v399, v414)) % 65521;
                            end;
                            if v400 == 272 and v398 then
                                u180._x065c7e61fbbee31e[u228] = nil;
                                u241:Destroy();
                                return;
                            end;
                            return;
                        end;
                        local v402 = u229;
                        local v403 = tostring(game.GameId);
                        local v404 = 46;
                        for v405 = 1, #v403 do
                            v404 = (v404 * 33 + string.byte(v403, v405)) % 65521;
                        end;
                        local v406;
                        if v404 == 272 then
                            local v407;
                            if type(v402) == "table" then
                                v407 = v402.spectate_target_key ~= nil;
                            else
                                v407 = false;
                            end;
                            if v407 then
                                local v408 = tostring(game.GameId);
                                local v409 = 46;
                                for v410 = 1, #v408 do
                                    v409 = (v409 * 33 + string.byte(v408, v410)) % 65521;
                                end;
                                local v411;
                                if v409 == 272 then
                                    local v412;
                                    if type(v402) == "table" then
                                        v412 = v402.spectate_target_key ~= nil;
                                    else
                                        v412 = false;
                                    end;
                                    if not v412 then
                                        v411 = u3._x539c98577c3cf168;
                                    end;
                                    v411 = u180._xf93873c7bdecce2c;
                                    if v411 then
                                        v411 = u180._xf93873c7bdecce2c.Character;
                                    end;
                                else
                                    v411 = u3._x539c98577c3cf168;
                                end;
                                if u180._xb88855e9588a38f1 == nil or v411 == nil then
                                    v406 = false;
                                else
                                    v406 = v411.Parent ~= nil;
                                end;
                                if not v406 then
                                    v398 = u244.connection;
                                    v399 = tostring(game.GameId);
                                    v400 = 46;
                                    for v414 = 1, #v399 do
                                        v400 = (v400 * 33 + string.byte(v399, v414)) % 65521;
                                    end;
                                    if v400 == 272 and v398 then
                                        u180._x065c7e61fbbee31e[u228] = nil;
                                        u241:Destroy();
                                        return;
                                    end;
                                    return;
                                end;
                            end;
                        end;
                        if u4._x885b2725a1933f2e == "alive" then
                            v406 = true;
                        else
                            v406 = false;
                        end;
                        if not v406 then
                            v398 = u244.connection;
                            v399 = tostring(game.GameId);
                            v400 = 46;
                            for v414 = 1, #v399 do
                                v400 = (v400 * 33 + string.byte(v399, v414)) % 65521;
                            end;
                            if v400 == 272 and v398 then
                                u180._x065c7e61fbbee31e[u228] = nil;
                                u241:Destroy();
                                return;
                            end;
                            return;
                        end;
                    end;
                    u241.Rotation = v385(v394);
                end;
                v247 = v245;
                u180._x065c7e61fbbee31e[u228] = v247;
            else
                u248 = l__UIAssets__5.ShooterIndicator:Clone();
                v249 = u229.first_parry_range;
                v250 = u229.last_parry_range;
                u251 = u2:convNumRange(u213(u229), 0, 1, v249, v250);
                v252 = tostring(game.GameId);
                v253 = 46;
                for v415 = 1, #v252 do
                    v253 = (v253 * 33 + string.byte(v252, v415)) % 65521;
                end;
                if v253 == 272 and u236 then
                    u248.Visible = false;
                end;
                game.Debris:AddItem(u248, 5);
                v254 = u248.ParryRange.LeftClip.Left;
                v255 = u248.ParryRange.RightClip.Right;
                v254.ImageTransparency = 0;
                v255.ImageTransparency = 0;
                u256 = u248.ParryRange.LeftClip.Left.UIGradient;
                u257 = u248.ParryRange.RightClip.Right.UIGradient;
                u258 = u248.ParryRange.LeftClip.LeftSuccess.UIGradient;
                u259 = u248.ParryRange.RightClip.RightSuccess.UIGradient;
                u248.Parent = u180._x0b50f415660624d5;
                u260 = os.clock();
                u261 = nil;
                v262 = {
                    first_parry = v249,
                    last_parry = v250,
                    parry_range = u251,
                    indicator_ui = u248,
                    indicator_type = u229.indicator_type
                };
                if type(u229) == "table" then
                    v263 = u229.spectate_target_key ~= nil;
                else
                    v263 = false;
                end;
                v262.is_spectate = v263;
                v262.expected_shot_time = os.clock() + u229.draw_time;
                v262.parry_tweens = {};
                function v262.connection(_) --[[ Line: 590 ]]
                    -- upvalues: u227 (ref), u229 (copy), l__Classes__14 (ref), u2 (ref), u228 (copy), u180 (ref), u248 (copy), u236 (copy), u260 (copy), u3 (ref), u4 (ref), u261 (ref), u251 (copy), u198 (ref), u256 (copy), u257 (copy), u258 (copy), u259 (copy)
                    local v416 = u2:getLikelyPart(u228);
                    local v417 = tostring(game.GameId);
                    local v418 = 46;
                    local function v426(p419) --[[ Line: 591 ]]
                        local l__CFrame__28 = workspace.CurrentCamera.CFrame;
                        local l__Unit__29 = (l__CFrame__28.LookVector * Vector3.new(1, 0, 1)).Unit;
                        local v420 = l__CFrame__28.Position * Vector3.new(1, 0, 1) - p419 * Vector3.new(1, 0, 1);
                        local v421 = tostring(game.GameId);
                        local v422 = 46;
                        for v423 = 1, #v421 do
                            v422 = (v422 * 33 + string.byte(v421, v423)) % 65521;
                        end;
                        if v422 == 272 and v420.Magnitude == 0 then
                            return 0;
                        end;
                        local l__Unit__30 = v420.Unit;
                        local v424 = l__Unit__29:Dot(l__Unit__30);
                        local v425 = math.atan2(l__Unit__29.X * l__Unit__30.Z - l__Unit__29.Z * l__Unit__30.X, v424);
                        return math.deg(v425);
                    end;
                    for v427 = 1, #v417 do
                        v418 = (v418 * 33 + string.byte(v417, v427)) % 65521;
                    end;
                    if v418 == 272 and not v416 then
                        u180._x065c7e61fbbee31e[u228] = nil;
                        u248:Destroy();
                        return;
                    end;
                    local v428 = tostring(game.GameId);
                    local v429 = 46;
                    for v430 = 1, #v428 do
                        v429 = (v429 * 33 + string.byte(v428, v430)) % 65521;
                    end;
                    if v429 == 272 and u236 then
                        u248.Visible = false;
                    else
                        local v431 = tostring(game.GameId);
                        local v432 = 46;
                        for v433 = 1, #v431 do
                            v432 = (v432 * 33 + string.byte(v431, v433)) % 65521;
                        end;
                        if v432 == 272 and u229.require_los then
                            local v434 = u227(u229);
                            u248.Visible = l__Classes__14.Util:hasLineOfSight(v434, v416);
                        else
                            u248.Visible = true;
                        end;
                    end;
                    local v435 = l__Classes__14.Util:convNumRange(math.clamp((v416.Position - workspace.CurrentCamera.CFrame.Position).Magnitude, 0, 300), 0, 300, 0.35, 0.55);
                    u248.Size = UDim2.fromScale(v435, v435);
                    local v436 = u248:FindFirstChild("ParryRange");
                    local v437 = u228:FindFirstChild("Head") and u228.Head.Position or (u228.PrimaryPart and u228.PrimaryPart.Position or u228:GetPivot().Position);
                    local v438 = os.clock() - u260;
                    local v439 = tostring(game.GameId);
                    local v440 = 46;
                    for v441 = 1, #v439 do
                        v440 = (v440 * 33 + string.byte(v439, v441)) % 65521;
                    end;
                    local v442, v443, v444, v445, v446, v447, v448, v449, v450, v451, v452, v453, v454;
                    if v440 == 272 then
                        local v455, v456, v457;
                        if not u248 or (not v436 or (not v437 or v438 > 5)) then
                            v455 = u261.connection;
                            v456 = tostring(game.GameId);
                            v457 = 46;
                            for v473 = 1, #v456 do
                                v457 = (v457 * 33 + string.byte(v456, v473)) % 65521;
                            end;
                            if v457 == 272 and v455 then
                                u180._x065c7e61fbbee31e[u228] = nil;
                                u248:Destroy();
                                return;
                            end;
                            return;
                        end;
                        local v459 = u229;
                        local v460 = tostring(game.GameId);
                        local v461 = 46;
                        for v462 = 1, #v460 do
                            v461 = (v461 * 33 + string.byte(v460, v462)) % 65521;
                        end;
                        local v463;
                        if v461 == 272 then
                            local v464;
                            if type(v459) == "table" then
                                v464 = v459.spectate_target_key ~= nil;
                            else
                                v464 = false;
                            end;
                            if v464 then
                                local v465 = tostring(game.GameId);
                                local v466 = 46;
                                for v467 = 1, #v465 do
                                    v466 = (v466 * 33 + string.byte(v465, v467)) % 65521;
                                end;
                                local v468;
                                if v466 == 272 then
                                    local v469;
                                    if type(v459) == "table" then
                                        v469 = v459.spectate_target_key ~= nil;
                                    else
                                        v469 = false;
                                    end;
                                    if not v469 then
                                        v468 = u3._x539c98577c3cf168;
                                    end;
                                    v468 = u180._xf93873c7bdecce2c;
                                    if v468 then
                                        v468 = u180._xf93873c7bdecce2c.Character;
                                    end;
                                else
                                    v468 = u3._x539c98577c3cf168;
                                end;
                                if u180._xb88855e9588a38f1 == nil or v468 == nil then
                                    v463 = false;
                                else
                                    v463 = v468.Parent ~= nil;
                                end;
                                if not v463 then
                                    v455 = u261.connection;
                                    v456 = tostring(game.GameId);
                                    v457 = 46;
                                    for v473 = 1, #v456 do
                                        v457 = (v457 * 33 + string.byte(v456, v473)) % 65521;
                                    end;
                                    if v457 == 272 and v455 then
                                        u180._x065c7e61fbbee31e[u228] = nil;
                                        u248:Destroy();
                                        return;
                                    end;
                                    return;
                                end;
                                v442 = os.clock() - u260;
                                v443 = u198((u2:numLerp(0, u251, (u2:convNumRange(math.clamp(v442, 0, u229.draw_time), 0, u229.draw_time, 0, 1)))));
                                v444 = -v443 / 2;
                                u248.ParryRange.Rotation = v426(v437) + v444;
                                v445 = u256;
                                v446 = u257;
                                v447 = math.fmod(v443, 360);
                                v448 = tostring(game.GameId);
                                v449 = 46;
                                for v476 = 1, #v448 do
                                    v449 = (v449 * 33 + string.byte(v448, v476)) % 65521;
                                end;
                                if v449 == 272 and (v447 < 180 and v447 > -180) then
                                    v445.Rotation = v447;
                                    v446.Rotation = 0;
                                else
                                    v445.Rotation = 180;
                                    v446.Rotation = v447 - 180;
                                end;
                                v450 = u258;
                                v451 = u259;
                                v452 = math.fmod(v443, 360);
                                v453 = tostring(game.GameId);
                                v454 = 46;
                                for v477 = 1, #v453 do
                                    v454 = (v454 * 33 + string.byte(v453, v477)) % 65521;
                                end;
                                if v454 == 272 and (v452 < 180 and v452 > -180) then
                                    v450.Rotation = v452;
                                    v451.Rotation = 0;
                                    return;
                                end;
                                v450.Rotation = 180;
                                v451.Rotation = v452 - 180;
                                return;
                            end;
                        end;
                        if u4._x885b2725a1933f2e == "alive" then
                            v463 = true;
                        else
                            v463 = false;
                        end;
                        if not v463 then
                            v455 = u261.connection;
                            v456 = tostring(game.GameId);
                            v457 = 46;
                            for v473 = 1, #v456 do
                                v457 = (v457 * 33 + string.byte(v456, v473)) % 65521;
                            end;
                            if v457 == 272 and v455 then
                                u180._x065c7e61fbbee31e[u228] = nil;
                                u248:Destroy();
                                return;
                            end;
                            return;
                        end;
                        v442 = os.clock() - u260;
                        v443 = u198((u2:numLerp(0, u251, (u2:convNumRange(math.clamp(v442, 0, u229.draw_time), 0, u229.draw_time, 0, 1)))));
                        v444 = -v443 / 2;
                        u248.ParryRange.Rotation = v426(v437) + v444;
                        v445 = u256;
                        v446 = u257;
                        v447 = math.fmod(v443, 360);
                        v448 = tostring(game.GameId);
                        v449 = 46;
                        for v476 = 1, #v448 do
                            v449 = (v449 * 33 + string.byte(v448, v476)) % 65521;
                        end;
                        if v449 == 272 and (v447 < 180 and v447 > -180) then
                            v445.Rotation = v447;
                            v446.Rotation = 0;
                        else
                            v445.Rotation = 180;
                            v446.Rotation = v447 - 180;
                        end;
                        v450 = u258;
                        v451 = u259;
                        v452 = math.fmod(v443, 360);
                        v453 = tostring(game.GameId);
                        v454 = 46;
                        for v477 = 1, #v453 do
                            v454 = (v454 * 33 + string.byte(v453, v477)) % 65521;
                        end;
                        if v454 == 272 and (v452 < 180 and v452 > -180) then
                            v450.Rotation = v452;
                            v451.Rotation = 0;
                            return;
                        end;
                        v450.Rotation = 180;
                        v451.Rotation = v452 - 180;
                    else
                        v442 = os.clock() - u260;
                        v443 = u198((u2:numLerp(0, u251, (u2:convNumRange(math.clamp(v442, 0, u229.draw_time), 0, u229.draw_time, 0, 1)))));
                        v444 = -v443 / 2;
                        u248.ParryRange.Rotation = v426(v437) + v444;
                        v445 = u256;
                        v446 = u257;
                        v447 = math.fmod(v443, 360);
                        v448 = tostring(game.GameId);
                        v449 = 46;
                        for v476 = 1, #v448 do
                            v449 = (v449 * 33 + string.byte(v448, v476)) % 65521;
                        end;
                        if v449 == 272 and (v447 < 180 and v447 > -180) then
                            v445.Rotation = v447;
                            v446.Rotation = 0;
                        else
                            v445.Rotation = 180;
                            v446.Rotation = v447 - 180;
                        end;
                        v450 = u258;
                        v451 = u259;
                        v452 = math.fmod(v443, 360);
                        v453 = tostring(game.GameId);
                        v454 = 46;
                        for v477 = 1, #v453 do
                            v454 = (v454 * 33 + string.byte(v453, v477)) % 65521;
                        end;
                        if v454 == 272 and (v452 < 180 and v452 > -180) then
                            v450.Rotation = v452;
                            v451.Rotation = 0;
                            return;
                        end;
                        v450.Rotation = 180;
                        v451.Rotation = v452 - 180;
                    end;
                end;
                v264 = v262;
                u180._x065c7e61fbbee31e[u228] = v264;
            end;
        end;
    end;
    local function u517(p479, p480) --[[ Line: 671 ]]
        -- upvalues: u180 (copy), l__Classes__14 (ref), l__TweenService__3 (ref)
        local v481 = tostring(game.GameId);
        local v482 = 46;
        for v483 = 1, #v481 do
            v482 = (v482 * 33 + string.byte(v481, v483)) % 65521;
        end;
        if v482 == 272 and u180._x065c7e61fbbee31e[p479] then
            local v484 = u180._x065c7e61fbbee31e[p479];
            local l__indicator_ui__31 = v484.indicator_ui;
            local v485 = l__Classes__14._x7c4d08c7bcf3460a._xde0b84dc197307ba[p479];
            local v486 = tostring(game.GameId);
            local v487 = 46;
            for v488 = 1, #v486 do
                v487 = (v487 * 33 + string.byte(v486, v488)) % 65521;
            end;
            if v487 == 272 and v485 then
                pcall(v485);
            end;
            local v489 = tostring(game.GameId);
            local v490 = 46;
            for v491 = 1, #v489 do
                v490 = (v490 * 33 + string.byte(v489, v491)) % 65521;
            end;
            if v490 == 272 and (p480 == "parried" or p480 == "iframed") then
                local v492 = tostring(game.GameId);
                local v493 = 46;
                for v494 = 1, #v492 do
                    v493 = (v493 * 33 + string.byte(v492, v494)) % 65521;
                end;
                if v493 == 272 and v484.parry_tweens then
                    for _, v495 in v484.parry_tweens do
                        v495:Cancel();
                    end;
                end;
                local v496 = tostring(game.GameId);
                local v497 = 46;
                for v498 = 1, #v496 do
                    v497 = (v497 * 33 + string.byte(v496, v498)) % 65521;
                end;
                if v497 == 272 and v484.indicator_ui then
                    local v499 = tostring(game.GameId);
                    local v500 = 46;
                    for v501 = 1, #v499 do
                        v500 = (v500 * 33 + string.byte(v499, v501)) % 65521;
                    end;
                    if v500 == 272 and v484.indicator_type == "timing_only" then
                        local v502 = tostring(game.GameId);
                        local v503 = 46;
                        for v504 = 1, #v502 do
                            v503 = (v503 * 33 + string.byte(v502, v504)) % 65521;
                        end;
                        if v503 == 272 and l__indicator_ui__31 then
                            l__indicator_ui__31:Destroy();
                        end;
                    else
                        local v505 = tostring(game.GameId);
                        local v506 = 46;
                        for v507 = 1, #v505 do
                            v506 = (v506 * 33 + string.byte(v505, v507)) % 65521;
                        end;
                        if v506 == 272 and v484.indicator_type == "surefire_bullet" then
                            local l__LeftClip__32 = l__indicator_ui__31.ParryRange.LeftClip;
                            local l__RightClip__33 = l__indicator_ui__31.ParryRange.RightClip;
                            l__LeftClip__32.Left.Visible = false;
                            l__RightClip__33.Right.Visible = false;
                            game.Debris:AddItem(l__indicator_ui__31, 0.3);
                            local l__LeftSuccess__34 = l__LeftClip__32.LeftSuccess;
                            local l__RightSuccess__35 = l__RightClip__33.RightSuccess;
                            l__LeftSuccess__34.Image = "rbxassetid://119413129698155";
                            l__LeftSuccess__34.ImageTransparency = 0;
                            l__LeftSuccess__34.Size = UDim2.fromScale(1, 0.5);
                            l__TweenService__3:Create(l__LeftSuccess__34, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(2, 1)
                            }):Play();
                            l__TweenService__3:Create(l__LeftSuccess__34, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            }):Play();
                            l__RightSuccess__35.Image = "rbxassetid://119413129698155";
                            l__RightSuccess__35.ImageTransparency = 0;
                            l__RightSuccess__35.Size = UDim2.fromScale(1, 0.5);
                            l__TweenService__3:Create(l__RightSuccess__35, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(2, 1)
                            }):Play();
                            l__TweenService__3:Create(l__RightSuccess__35, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            }):Play();
                        end;
                    end;
                end;
            else
                local v508 = tostring(game.GameId);
                local v509 = 46;
                for v510 = 1, #v508 do
                    v509 = (v509 * 33 + string.byte(v508, v510)) % 65521;
                end;
                if v509 == 272 and v484.indicator_type == "timing_only" then
                    local v511 = tostring(game.GameId);
                    local v512 = 46;
                    for v513 = 1, #v511 do
                        v512 = (v512 * 33 + string.byte(v511, v513)) % 65521;
                    end;
                    if v512 == 272 and l__indicator_ui__31 then
                        l__indicator_ui__31:Destroy();
                    end;
                else
                    local v514 = tostring(game.GameId);
                    local v515 = 46;
                    for v516 = 1, #v514 do
                        v515 = (v515 * 33 + string.byte(v514, v516)) % 65521;
                    end;
                    if v515 == 272 and v484.indicator_type == "surefire_bullet" then
                        local l__indicator_ui__36 = v484.indicator_ui;
                        local l__LeftClip__37 = l__indicator_ui__36.ParryRange.LeftClip;
                        local l__RightClip__38 = l__indicator_ui__36.ParryRange.RightClip;
                        game.Debris:AddItem(l__indicator_ui__36, 0.1);
                        l__TweenService__3:Create(l__LeftClip__37, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            GroupTransparency = 1
                        }):Play();
                        l__TweenService__3:Create(l__RightClip__38, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            GroupTransparency = 1
                        }):Play();
                    end;
                end;
            end;
            u180._x065c7e61fbbee31e[p479] = nil;
        end;
    end;
    l__Packets__7._xc2cd69c902ae68f8.OnClientEvent:Connect(function(p518, p519) --[[ Line: 741 ]]
        -- upvalues: u180 (copy), u478 (copy)
        local v520 = tostring(game.GameId);
        local v521 = 46;
        for v522 = 1, #v520 do
            v521 = (v521 * 33 + string.byte(v520, v522)) % 65521;
        end;
        if v521 == 272 and u180._xb88855e9588a38f1 then
        else
            u478(p518, p519);
        end;
    end);
    l__Packets__7._xfb6e8daf30b26df5.OnClientEvent:Connect(function(p523, p524) --[[ Line: 749 ]]
        -- upvalues: u517 (copy)
        u517(p523, p524);
    end);
    l__Packets__7._x62371b6ac34c03a2.OnClientEvent:Connect(function(p525, p526, p527) --[[ Line: 753 ]]
        -- upvalues: u180 (copy), u478 (copy)
        local v528 = tostring(game.GameId);
        local v529 = 46;
        for v530 = 1, #v528 do
            v529 = (v529 * 33 + string.byte(v528, v530)) % 65521;
        end;
        if v529 == 272 then
            local v531 = u180._xf93873c7bdecce2c and u180._xb88855e9588a38f1;
            if v531 then
                v531 = tostring(u180._xf93873c7bdecce2c.UserId) == tostring(p525);
            end;
            if v531 then
                u478(p526, p527);
            end;
        end;
    end);
    l__Packets__7._x2abba096e4373872.OnClientEvent:Connect(function(p532, p533, p534) --[[ Line: 759 ]]
        -- upvalues: u180 (copy), u517 (copy)
        local v535 = tostring(game.GameId);
        local v536 = 46;
        for v537 = 1, #v535 do
            v536 = (v536 * 33 + string.byte(v535, v537)) % 65521;
        end;
        if v536 == 272 then
            local v538 = u180._xf93873c7bdecce2c and u180._xb88855e9588a38f1;
            if v538 then
                v538 = tostring(u180._xf93873c7bdecce2c.UserId) == tostring(p532);
            end;
            if v538 then
                u517(p533, p534);
            end;
        end;
    end);
end;
function u5._x2a3b490e2e346dae(p539) --[[ Line: 766 ]]
    local v540 = tostring(game.GameId);
    local v541 = 46;
    for v542 = 1, #v540 do
        v541 = (v541 * 33 + string.byte(v540, v542)) % 65521;
    end;
    if v541 ~= 272 or p539._x772be18101455ec0 and p539._x772be18101455ec0.Parent ~= nil then
        local l__AugmentHolder__39 = p539._x772be18101455ec0.Main.BottomLeft.AugmentContainer.AugmentHolder;
        return {
            augment_text = l__AugmentHolder__39.AugmentText,
            subtext = l__AugmentHolder__39.Subtext,
            key_text = l__AugmentHolder__39.AugmentKey.KeyText,
            progress = l__AugmentHolder__39.CircularImageFill.Progress,
            counter_text = l__AugmentHolder__39.CircularImageFill.CounterText
        };
    end;
end;
function u5._x44f73aa250bdf574(p543) --[[ Line: 778 ]]
    local v544 = tostring(game.GameId);
    local v545 = 46;
    for v546 = 1, #v544 do
        v545 = (v545 * 33 + string.byte(v544, v546)) % 65521;
    end;
    if v545 ~= 272 or p543._x772be18101455ec0 then
        return p543.shot_progress_inst;
    end;
end;
function u5._x26bc3c27878259a9(p547) --[[ Line: 783 ]]
    p547._x6171401a9a320e87:Clean();
    p547._xbfd458589288e03d = nil;
end;
function u5._x06583611585697cc(p548) --[[ Line: 788 ]]
    local v549 = tostring(game.GameId);
    local v550 = 46;
    for v551 = 1, #v549 do
        v550 = (v550 * 33 + string.byte(v549, v551)) % 65521;
    end;
    if v550 == 272 and not p548._xb88855e9588a38f1 then
        return nil;
    else
        return p548._xb88855e9588a38f1:FindFirstChild("Main") or p548._xb88855e9588a38f1;
    end;
end;
function u5._x1f4a68e517e7f5df(p552, p553) --[[ Line: 796 ]]
    -- upvalues: u13 (copy)
    local v554 = p552:_x06583611585697cc();
    local v555 = tostring(game.GameId);
    local v556 = 46;
    for v557 = 1, #v555 do
        v556 = (v556 * 33 + string.byte(v555, v557)) % 65521;
    end;
    if v556 == 272 and not v554 then
        return nil;
    else
        return u13(v554, p553);
    end;
end;
function u5._xf17b2823eceeb752(p558) --[[ Line: 805 ]]
    -- upvalues: u13 (copy)
    for _, v559 in {
        { "BottomLeft", "StaminaContainer" },
        { "BottomLeft", "AugmentContainer" },
        { "BottomCenter", "GameplayCues" }
    } do
        local v560 = p558:_x1f4a68e517e7f5df(v559);
        local v561 = tostring(game.GameId);
        local v562 = 46;
        for v563 = 1, #v561 do
            v562 = (v562 * 33 + string.byte(v561, v563)) % 65521;
        end;
        if v562 == 272 and (v560 and v560:IsA("GuiObject")) then
            v560.Visible = false;
        end;
    end;
    for _, v564 in {
        { "TopbarUI" },
        { "DamageFrame" }
    } do
        local v565 = u13(p558._xb88855e9588a38f1, v564);
        local v566 = tostring(game.GameId);
        local v567 = 46;
        for v568 = 1, #v566 do
            v567 = (v567 * 33 + string.byte(v566, v568)) % 65521;
        end;
        if v567 == 272 and (v565 and v565:IsA("GuiObject")) then
            v565.Visible = false;
        end;
    end;
    local v569 = p558:_x1f4a68e517e7f5df({ "BottomLeft", "GunContainer", "GunKey" });
    local v570 = tostring(game.GameId);
    local v571 = 46;
    for v572 = 1, #v570 do
        v571 = (v571 * 33 + string.byte(v570, v572)) % 65521;
    end;
    if v571 == 272 and (v569 and v569:IsA("GuiObject")) then
        v569.Visible = false;
    end;
end;
function u5._x0af54eb829cf3904(_, p573, p574) --[[ Line: 824 ]]
    -- upvalues: l__TweenService__3 (copy), u2 (ref)
    local v575 = p573:FindFirstChild("CircleFrame");
    local v576 = tostring(game.GameId);
    local v577 = 46;
    for v578 = 1, #v576 do
        v577 = (v577 * 33 + string.byte(v576, v578)) % 65521;
    end;
    if v577 == 272 and not (v575 and v575:IsA("GuiObject")) then
    else
        local v579 = Color3.fromRGB(255, 30, 30);
        local v580 = v575:Clone();
        v580.Parent = v575.Parent;
        local v581 = p573:FindFirstChild("Counter");
        local v582 = tostring(game.GameId);
        local v583 = 46;
        for v584 = 1, #v582 do
            v583 = (v583 * 33 + string.byte(v582, v584)) % 65521;
        end;
        if v583 == 272 and (v581 and v581:IsA("TextLabel")) then
            v581.TextTransparency = 1;
            l__TweenService__3:Create(v581, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                TextTransparency = 0
            }):Play();
        end;
        local v585 = p573:FindFirstChild("Elimination");
        local v586 = tostring(game.GameId);
        local v587 = 46;
        for v588 = 1, #v586 do
            v587 = (v587 * 33 + string.byte(v586, v588)) % 65521;
        end;
        if v587 == 272 and (v585 and v585:IsA("ImageLabel")) then
            v585.ImageColor3 = v579;
            v585.ImageTransparency = 0;
            v585.Size = UDim2.fromScale(3, 3);
            l__TweenService__3:Create(v585, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1.3, 1.3)
            }):Play();
            l__TweenService__3:Create(v585, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ImageTransparency = 1
            }):Play();
        end;
        for _, v589 in { "Radial", "Flare", "Glow" } do
            local v590 = p573:FindFirstChild(v589);
            local v591 = tostring(game.GameId);
            local v592 = 46;
            for v593 = 1, #v591 do
                v592 = (v592 * 33 + string.byte(v591, v593)) % 65521;
            end;
            if v592 == 272 and (v590 and v590:IsA("ImageLabel")) then
                v590.ImageColor3 = v579;
                l__TweenService__3:Create(v590, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
        end;
        local v594 = v580:FindFirstChildWhichIsA("UIStroke");
        local v595 = tostring(game.GameId);
        local v596 = 46;
        for v597 = 1, #v595 do
            v596 = (v596 * 33 + string.byte(v595, v597)) % 65521;
        end;
        if v596 == 272 and v594 then
            v594.Transparency = 0;
            v594.Color = v579;
            v594.Thickness = 7;
            l__TweenService__3:Create(v594, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            l__TweenService__3:Create(v594, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Thickness = 0
            }):Play();
        end;
        local v598 = tostring(game.GameId);
        local v599 = 46;
        for v600 = 1, #v598 do
            v599 = (v599 * 33 + string.byte(v598, v600)) % 65521;
        end;
        local v601 = ((v599 ~= 272 or not u2) and true or false) and 3 or u2:convNumRange(math.clamp(p574, 0, 15), 0, 20, 2, 6);
        l__TweenService__3:Create(v580, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(v601, v601)
        }):Play();
        game.Debris:AddItem(v580, 1);
    end;
end;
function u5._xe55937291e257f21(p602, p603) --[[ Line: 871 ]]
    local v604 = p602:_x1f4a68e517e7f5df({ "BottomCenter", "KillstreakVisualizer" });
    local v605 = tostring(game.GameId);
    local v606 = 46;
    for v607 = 1, #v605 do
        v606 = (v606 * 33 + string.byte(v605, v607)) % 65521;
    end;
    if v606 == 272 and not v604 then
    else
        local v608 = p603.killstreak or 0;
        v604.Visible = v608 >= 1;
        local v609 = v604:FindFirstChild("Counter");
        local v610 = tostring(v608);
        local v611 = tostring(game.GameId);
        local v612 = 46;
        for v613 = 1, #v611 do
            v612 = (v612 * 33 + string.byte(v611, v613)) % 65521;
        end;
        if v612 == 272 and (v609 and (v609:IsA("TextLabel") or v609:IsA("TextButton"))) then
            v609.Text = v610;
        end;
        local l__killstreak__40 = p602._xb0ed280cacf768bd.killstreak;
        local v614 = tostring(game.GameId);
        local v615 = 46;
        for v616 = 1, #v614 do
            v615 = (v615 * 33 + string.byte(v614, v616)) % 65521;
        end;
        if v615 == 272 and (l__killstreak__40 and l__killstreak__40 < v608) then
            p602:_x0af54eb829cf3904(v604, v608);
        end;
        p602._xb0ed280cacf768bd.killstreak = v608;
    end;
end;
function u5._x138eb46f8d26e3e8(p617, p618) --[[ Line: 891 ]]
    -- upvalues: l__TweenService__3 (copy)
    local v619 = p617:_x1f4a68e517e7f5df({
        "BottomCenter",
        "HealthContainer",
        "HealthMain",
        "Bar",
        "Max",
        "HealthProgress"
    });
    local v620 = tostring(game.GameId);
    local v621 = 46;
    for v622 = 1, #v620 do
        v621 = (v621 * 33 + string.byte(v620, v622)) % 65521;
    end;
    if v621 == 272 and not (v619 and v619:IsA("GuiObject")) then
    else
        local v623 = p618.health or 0;
        local v624 = math.max(p618.health_max or 0, 1);
        local v625 = math.clamp(v623 / v624, 0, 1);
        v619.Size = UDim2.fromScale(v625, 1);
        local v626 = v619:FindFirstChild("TextLabel");
        local v627 = math.floor(v623);
        local v628 = tostring(v627);
        local v629 = tostring(game.GameId);
        local v630 = 46;
        for v631 = 1, #v629 do
            v630 = (v630 * 33 + string.byte(v629, v631)) % 65521;
        end;
        if v630 == 272 and (v626 and (v626:IsA("TextLabel") or v626:IsA("TextButton"))) then
            v626.Text = v628;
        end;
        local l__health__41 = p617._xb0ed280cacf768bd.health;
        local v632 = tostring(game.GameId);
        local v633 = 46;
        for v634 = 1, #v632 do
            v633 = (v633 * 33 + string.byte(v632, v634)) % 65521;
        end;
        if v633 == 272 and l__health__41 then
            local v635 = l__health__41 - v623;
            local v636 = tostring(game.GameId);
            local v637 = 46;
            for v638 = 1, #v636 do
                v637 = (v637 * 33 + string.byte(v636, v638)) % 65521;
            end;
            if v637 == 272 and v635 > 0 then
                local v639 = p617:_x1f4a68e517e7f5df({
                    "BottomCenter",
                    "HealthContainer",
                    "HealthMain",
                    "Bar",
                    "Max",
                    "DamagedFrame"
                });
                local v640 = tostring(game.GameId);
                local v641 = 46;
                for v642 = 1, #v640 do
                    v641 = (v641 * 33 + string.byte(v640, v642)) % 65521;
                end;
                if v641 == 272 and (v639 and v639:IsA("GuiObject")) then
                    local v643 = math.clamp(v635 / v624, 0, 1);
                    v639.Size = UDim2.fromScale(v643, 1);
                    l__TweenService__3:Create(v639, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    local v644 = v639:FindFirstChild("GradientFrame");
                    local v645 = tostring(game.GameId);
                    local v646 = 46;
                    for v647 = 1, #v645 do
                        v646 = (v646 * 33 + string.byte(v645, v647)) % 65521;
                    end;
                    if v646 == 272 and (v644 and v644:IsA("GuiObject")) then
                        v644.BackgroundTransparency = 0;
                        l__TweenService__3:Create(v644, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                end;
                v619.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
                l__TweenService__3:Create(v619, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Play();
            else
                local v648 = tostring(game.GameId);
                local v649 = 46;
                for v650 = 1, #v648 do
                    v649 = (v649 * 33 + string.byte(v648, v650)) % 65521;
                end;
                if v649 == 272 and v635 < 0 then
                    v619.BackgroundColor3 = Color3.fromRGB(0, 255, 0);
                    l__TweenService__3:Create(v619, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end;
            end;
        end;
        p617._xb0ed280cacf768bd.health = v623;
    end;
end;
function u5._x95ef8913766a19a7(p651, p652) --[[ Line: 931 ]]
    -- upvalues: u2 (ref)
    local l___x3134e2186c9aaf90__42 = p651._x3134e2186c9aaf90;
    local v653 = p651:_x1f4a68e517e7f5df({ "TopCenter", "ImpactHolder" });
    local v654 = p651:_x1f4a68e517e7f5df({ "TopCenter", "ImpactHolder", "ImpactContainer" });
    local v655 = p651:_x1f4a68e517e7f5df({
        "TopCenter",
        "ImpactHolder",
        "ImpactContainer",
        "ImpactMain",
        "Bar",
        "Max",
        "ImpactFill"
    });
    local v656 = p651:_x1f4a68e517e7f5df({
        "TopCenter",
        "ImpactHolder",
        "ImpactContainer",
        "ImpactMain",
        "Bar",
        "Max",
        "ImpactFlash"
    });
    local v657 = tostring(game.GameId);
    local v658 = 46;
    for v659 = 1, #v657 do
        v658 = (v658 * 33 + string.byte(v657, v659)) % 65521;
    end;
    if v658 == 272 and not (l___x3134e2186c9aaf90__42 and (v653 and (v655 and v655:IsA("GuiObject")))) then
    else
        local v660 = l___x3134e2186c9aaf90__42.impact or 0;
        local v661 = math.max(l___x3134e2186c9aaf90__42.impact_limit or 0, 1);
        local v662 = l___x3134e2186c9aaf90__42.is_breaking == true;
        local v663 = math.clamp((p652 or 0) * 14, 0, 1);
        local l__Scale__43 = v655.Size.X.Scale;
        local v664 = p651._xb0ed280cacf768bd.impact_delayed_fill or 0;
        local v665 = tostring(game.GameId);
        local v666 = 46;
        for v667 = 1, #v665 do
            v666 = (v666 * 33 + string.byte(v665, v667)) % 65521;
        end;
        if v666 == 272 and v662 then
            local v668 = math.max(l___x3134e2186c9aaf90__42.break_duration or 0, 0.001);
            local l__break_remaining__44 = l___x3134e2186c9aaf90__42.break_remaining;
            local v669 = tostring(game.GameId);
            local v670 = 46;
            for v671 = 1, #v669 do
                v670 = (v670 * 33 + string.byte(v669, v671)) % 65521;
            end;
            if v670 == 272 and (l___x3134e2186c9aaf90__42.break_end_time and l___x3134e2186c9aaf90__42.break_end_time > 0) then
                local v672 = l___x3134e2186c9aaf90__42.break_end_time - workspace:GetServerTimeNow();
                l__break_remaining__44 = math.max(v672, 0);
            end;
            local v673 = math.clamp(l__break_remaining__44 or v668, 0, v668);
            v653.Visible = true;
            local v674 = l__Scale__43 + (v673 / v668 - l__Scale__43) * math.clamp(v663, 0, 1);
            v655.Size = UDim2.fromScale(v674, 1);
            v655.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            local v675 = v653:FindFirstChild("ImpactText");
            local v676 = tostring(game.GameId);
            local v677 = 46;
            for v678 = 1, #v676 do
                v677 = (v677 * 33 + string.byte(v676, v678)) % 65521;
            end;
            if v677 == 272 and (v675 and (v675:IsA("TextLabel") or v675:IsA("TextButton"))) then
                v675.Text = "!! DISABLED !!";
            end;
            local v679 = v653:FindFirstChild("BreakingSubtext");
            local v680 = tostring(game.GameId);
            local v681 = 46;
            for v682 = 1, #v680 do
                v681 = (v681 * 33 + string.byte(v680, v682)) % 65521;
            end;
            if v681 == 272 and (v679 and v679:IsA("GuiObject")) then
                v679.Visible = true;
            end;
            p651._xb0ed280cacf768bd.impact_delayed_fill = v674;
            local l__Parent__45 = v655.Parent;
            if l__Parent__45 then
                l__Parent__45 = v655.Parent:FindFirstChild("ImpactFlash");
            end;
            local v683 = tostring(game.GameId);
            local v684 = 46;
            for v685 = 1, #v683 do
                v684 = (v684 * 33 + string.byte(v683, v685)) % 65521;
            end;
            if v684 == 272 and (l__Parent__45 and l__Parent__45:IsA("GuiObject")) then
                l__Parent__45.Visible = false;
            end;
            if v654 then
                v654 = v654:FindFirstChild("ImpactStroke");
            end;
            if v654 then
                v654 = v654:FindFirstChildWhichIsA("UIStroke");
            end;
            local v686 = tostring(game.GameId);
            local v687 = 46;
            for v688 = 1, #v686 do
                v687 = (v687 * 33 + string.byte(v686, v688)) % 65521;
            end;
            if v687 == 272 and v654 then
                v654.Color = Color3.fromRGB(255, 0, 0);
            end;
        else
            local v689 = tostring(game.GameId);
            local v690 = 46;
            for v691 = 1, #v689 do
                v690 = (v690 * 33 + string.byte(v689, v691)) % 65521;
            end;
            if v690 == 272 and v660 > 0 then
                v653.Visible = true;
                v655.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                local v692 = v653:FindFirstChild("ImpactText");
                local v693 = tostring(game.GameId);
                local v694 = 46;
                for v695 = 1, #v693 do
                    v694 = (v694 * 33 + string.byte(v693, v695)) % 65521;
                end;
                if v694 == 272 and (v692 and (v692:IsA("TextLabel") or v692:IsA("TextButton"))) then
                    v692.Text = "[ INSTABILITY ]";
                end;
                local v696 = v653:FindFirstChild("BreakingSubtext");
                local v697 = tostring(game.GameId);
                local v698 = 46;
                for v699 = 1, #v697 do
                    v698 = (v698 * 33 + string.byte(v697, v699)) % 65521;
                end;
                if v698 == 272 and (v696 and v696:IsA("GuiObject")) then
                    v696.Visible = false;
                end;
                if v654 then
                    v654 = v654:FindFirstChild("ImpactStroke");
                end;
                if v654 then
                    v654 = v654:FindFirstChildWhichIsA("UIStroke");
                end;
                local v700 = tostring(game.GameId);
                local v701 = 46;
                for v702 = 1, #v700 do
                    v701 = (v701 * 33 + string.byte(v700, v702)) % 65521;
                end;
                if v701 == 272 and v654 then
                    v654.Color = Color3.fromRGB(255, 255, 255);
                end;
                local v703 = math.clamp(v660 / v661, 0, 1);
                local v704 = tostring(game.GameId);
                local v705 = 46;
                for v706 = 1, #v704 do
                    v705 = (v705 * 33 + string.byte(v704, v706)) % 65521;
                end;
                local v707;
                if v705 == 272 and u2 then
                    v707 = u2:numLerp(l__Scale__43, v703, v663);
                else
                    v707 = l__Scale__43 + (v703 - l__Scale__43) * math.clamp(v663, 0, 1);
                end;
                v655.Size = UDim2.fromScale(v707, 1);
                local v708 = math.clamp((p652 or 0) * 8, 0, 1);
                local v709 = v664 + (v707 - v664) * math.clamp(v708, 0, 1);
                p651._xb0ed280cacf768bd.impact_delayed_fill = v709;
                local v710 = tostring(game.GameId);
                local v711 = 46;
                for v712 = 1, #v710 do
                    v711 = (v711 * 33 + string.byte(v710, v712)) % 65521;
                end;
                if v711 == 272 and (v656 and v656:IsA("GuiObject")) then
                    local v713 = math.abs(v707 - v709);
                    local v714 = tostring(game.GameId);
                    local v715 = 46;
                    for v716 = 1, #v714 do
                        v715 = (v715 * 33 + string.byte(v714, v716)) % 65521;
                    end;
                    if v715 == 272 and v713 > 0 then
                        v713 = math.max(v713, 0.007);
                    end;
                    v656.Visible = true;
                    v656.Position = UDim2.fromScale(v707, 0.5);
                    v656.Size = UDim2.fromScale(v713, 7 + math.random(-2, 2));
                    v656.BackgroundTransparency = 0.2 + math.random(-0.1, 0.1);
                end;
            else
                local v717 = l__Scale__43 + (0 - l__Scale__43) * math.clamp(v663, 0, 1);
                v655.Size = UDim2.fromScale(v717, 1);
                p651._xb0ed280cacf768bd.impact_delayed_fill = v664 + (0 - v664) * math.clamp(v663, 0, 1);
                local v718 = tostring(game.GameId);
                local v719 = 46;
                for v720 = 1, #v718 do
                    v719 = (v719 * 33 + string.byte(v718, v720)) % 65521;
                end;
                if v719 == 272 and (v656 and v656:IsA("GuiObject")) then
                    v656.Visible = false;
                end;
                local v721 = tostring(game.GameId);
                local v722 = 46;
                for v723 = 1, #v721 do
                    v722 = (v722 * 33 + string.byte(v721, v723)) % 65521;
                end;
                if v722 == 272 and v717 <= 0.001 then
                    v653.Visible = false;
                    v655.Size = UDim2.fromScale(0, 1);
                    p651._xb0ed280cacf768bd.impact_delayed_fill = 0;
                end;
            end;
        end;
    end;
end;
function u5._x7c27bd8225e6d6a4(p724) --[[ Line: 1017 ]]
    local v725 = tostring(game.GameId);
    local v726 = 46;
    for v727 = 1, #v725 do
        v726 = (v726 * 33 + string.byte(v725, v727)) % 65521;
    end;
    if v726 == 272 and p724._xfb50f29a6e40965e then
        p724._xfb50f29a6e40965e:Destroy();
        p724._xfb50f29a6e40965e = nil;
    end;
    for _, v728 in p724._x801f4d4291faaa40 do
        local v729 = tostring(game.GameId);
        local v730 = 46;
        for v731 = 1, #v729 do
            v730 = (v730 * 33 + string.byte(v729, v731)) % 65521;
        end;
        if v730 == 272 and v728 then
            v728:Destroy();
        end;
    end;
    p724._x801f4d4291faaa40 = {};
end;
function u5._x9a28323902a1ff56(p732, p733, p734) --[[ Line: 1031 ]]
    -- upvalues: l__UIAssets__5 (copy)
    p732:_x7c27bd8225e6d6a4();
    local v735 = p732:_x1f4a68e517e7f5df({ "BottomLeft", "GunContainer" });
    local v736 = tostring(game.GameId);
    local v737 = 46;
    for v738 = 1, #v736 do
        v737 = (v737 * 33 + string.byte(v736, v738)) % 65521;
    end;
    if v737 == 272 and not v735 then
    else
        local v739 = l__UIAssets__5:FindFirstChild("ItemSilhouettes");
        local v740;
        if v739 then
            v740 = v739:FindFirstChild(p733);
        else
            v740 = v739;
        end;
        local v741 = tostring(game.GameId);
        local v742 = 46;
        for v743 = 1, #v741 do
            v742 = (v742 * 33 + string.byte(v741, v743)) % 65521;
        end;
        if v742 == 272 and (not v740 and v739) then
            v740 = v739:FindFirstChild("Castigate");
        end;
        local v744 = tostring(game.GameId);
        local v745 = 46;
        for v746 = 1, #v744 do
            v745 = (v745 * 33 + string.byte(v744, v746)) % 65521;
        end;
        if v745 == 272 and v740 then
            p732._xfb50f29a6e40965e = v740:Clone();
            p732._xfb50f29a6e40965e.Parent = v735;
        end;
        local v747 = v735:FindFirstChild("BulletArray");
        local v748 = tostring(game.GameId);
        local v749 = 46;
        for v750 = 1, #v748 do
            v749 = (v749 * 33 + string.byte(v748, v750)) % 65521;
        end;
        if v749 == 272 and not v747 then
        else
            for _, v751 in v747:GetChildren() do
                local v752 = tostring(game.GameId);
                local v753 = 46;
                for v754 = 1, #v752 do
                    v753 = (v753 * 33 + string.byte(v752, v754)) % 65521;
                end;
                if v753 == 272 and (v751.Name == "BulletFrame" or v751:FindFirstChild("ActiveBullet")) then
                    v751:Destroy();
                end;
            end;
            for v755 = 1, p734 do
                local v756 = l__UIAssets__5.HUDAssets.BulletFrame:Clone();
                v756.Parent = v747;
                p732._x801f4d4291faaa40[v755] = v756;
            end;
        end;
    end;
end;
function u5._x2baab1fc4e1082c1(_, p757, p758) --[[ Line: 1068 ]]
    local v759 = p757:FindFirstChild("ActiveBullet");
    local v760 = p757:FindFirstChild("InactiveBullet");
    local v761 = tostring(game.GameId);
    local v762 = 46;
    for v763 = 1, #v761 do
        v762 = (v762 * 33 + string.byte(v761, v763)) % 65521;
    end;
    if v762 == 272 and (v759 and v759:IsA("GuiObject")) then
        v759.Visible = p758;
    end;
    local v764 = tostring(game.GameId);
    local v765 = 46;
    local v766 = not p758;
    for v767 = 1, #v764 do
        v765 = (v765 * 33 + string.byte(v764, v767)) % 65521;
    end;
    if v765 == 272 and (v760 and v760:IsA("GuiObject")) then
        v760.Visible = v766;
    end;
end;
function u5._xc179bd10f679a152(p768, p769) --[[ Line: 1076 ]]
    -- upvalues: l__TweenService__3 (copy), u2 (ref)
    local l__gun_item_id__46 = p769.gun_item_id;
    local v770 = tostring(game.GameId);
    local v771 = 46;
    for v772 = 1, #v770 do
        v771 = (v771 * 33 + string.byte(v770, v772)) % 65521;
    end;
    if v771 == 272 and l__gun_item_id__46 == "" then
        l__gun_item_id__46 = nil;
    end;
    local v773 = math.max(p769.heat or 0, 0);
    local v774 = math.max(p769.heat_max or 0, 0);
    local v775 = math.max(p769.heat_per_bullet or 0, 0);
    local v776 = tostring(game.GameId);
    local v777 = 46;
    for v778 = 1, #v776 do
        v777 = (v777 * 33 + string.byte(v776, v778)) % 65521;
    end;
    local v779 = (v777 ~= 272 or v775 <= 0) and 0 or math.floor(v774 / v775);
    local v780 = tostring(game.GameId);
    local v781 = 46;
    for v782 = 1, #v780 do
        v781 = (v781 * 33 + string.byte(v780, v782)) % 65521;
    end;
    local v783 = (v781 ~= 272 or v775 <= 0) and 0 or math.floor(v773 / v775);
    local v784 = tostring(game.GameId);
    local v785 = 46;
    for v786 = 1, #v784 do
        v785 = (v785 * 33 + string.byte(v784, v786)) % 65521;
    end;
    if v785 == 272 and v774 > 0 then
        if v774 <= v773 then
            v783 = v779;
        end;
    end;
    local v787 = math.clamp(v783, 0, v779);
    local v788 = tostring(game.GameId);
    local v789 = 46;
    for v790 = 1, #v788 do
        v789 = (v789 * 33 + string.byte(v788, v790)) % 65521;
    end;
    if v789 == 272 and (l__gun_item_id__46 ~= p768._xb0ed280cacf768bd.gun_item_id or v779 ~= p768._xb0ed280cacf768bd.max_bullets) then
        p768:_x9a28323902a1ff56(l__gun_item_id__46 or "Castigate", v779);
        p768._xb0ed280cacf768bd.gun_item_id = l__gun_item_id__46;
        p768._xb0ed280cacf768bd.max_bullets = v779;
        p768._xb0ed280cacf768bd.bullet_count = nil;
    end;
    local v791 = p768._xb0ed280cacf768bd.heat ~= v773;
    local l__bullet_count__47 = p768._xb0ed280cacf768bd.bullet_count;
    local v792 = tostring(game.GameId);
    local v793 = 46;
    for v794 = 1, #v792 do
        v793 = (v793 * 33 + string.byte(v792, v794)) % 65521;
    end;
    if v793 == 272 and (not v791 and l__bullet_count__47 ~= nil) then
    else
        for v795, v796 in p768._x801f4d4291faaa40 do
            p768:_x2baab1fc4e1082c1(v796, v795 <= v787);
        end;
        local v797 = tostring(game.GameId);
        local v798 = 46;
        for v799 = 1, #v797 do
            v798 = (v798 * 33 + string.byte(v797, v799)) % 65521;
        end;
        if v798 == 272 and l__bullet_count__47 then
            local v800 = tostring(game.GameId);
            local v801 = 46;
            for v802 = 1, #v800 do
                v801 = (v801 * 33 + string.byte(v800, v802)) % 65521;
            end;
            if v801 == 272 and (l__bullet_count__47 < v787 and p768._xfb50f29a6e40965e) then
                local v803 = p768._xfb50f29a6e40965e:FindFirstChild("Flash");
                local v804 = tostring(game.GameId);
                local v805 = 46;
                for v806 = 1, #v804 do
                    v805 = (v805 * 33 + string.byte(v804, v806)) % 65521;
                end;
                if v805 == 272 and (v803 and v803:IsA("GuiObject")) then
                    v803.BackgroundTransparency = 0;
                    l__TweenService__3:Create(v803, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play();
                end;
                local v807 = p768._x801f4d4291faaa40[v787];
                if v807 then
                    v807 = v807:FindFirstChild("ActiveBullet");
                end;
                local v808 = tostring(game.GameId);
                local v809 = 46;
                for v810 = 1, #v808 do
                    v809 = (v809 * 33 + string.byte(v808, v810)) % 65521;
                end;
                if v809 == 272 and (v807 and v807:IsA("GuiObject")) then
                    v807.Position = UDim2.fromScale(0.5, -0.5);
                    l__TweenService__3:Create(v807, TweenInfo.new(0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0.5, 0.5)
                    }):Play();
                end;
            else
                local v811 = tostring(game.GameId);
                local v812 = 46;
                for v813 = 1, #v811 do
                    v812 = (v812 * 33 + string.byte(v811, v813)) % 65521;
                end;
                if v812 == 272 and v787 < l__bullet_count__47 then
                    local v814 = p768._x801f4d4291faaa40[v787 + 1];
                    if v814 then
                        v814 = v814:FindFirstChild("Flash");
                    end;
                    local v815 = tostring(game.GameId);
                    local v816 = 46;
                    for v817 = 1, #v815 do
                        v816 = (v816 * 33 + string.byte(v815, v817)) % 65521;
                    end;
                    if v816 == 272 and (v814 and v814:IsA("GuiObject")) then
                        v814.BackgroundTransparency = 0;
                        l__TweenService__3:Create(v814, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                end;
            end;
        end;
        local l___xfb50f29a6e40965e__48 = p768._xfb50f29a6e40965e;
        if l___xfb50f29a6e40965e__48 then
            l___xfb50f29a6e40965e__48 = p768._xfb50f29a6e40965e:FindFirstChildWhichIsA("UIGradient");
        end;
        local v818 = tostring(game.GameId);
        local v819 = 46;
        for v820 = 1, #v818 do
            v819 = (v819 * 33 + string.byte(v818, v820)) % 65521;
        end;
        if v819 == 272 and (l___xfb50f29a6e40965e__48 and v775 > 0) then
            local v821 = math.fmod(v773, v775);
            local v822 = tostring(game.GameId);
            local v823 = 46;
            for v824 = 1, #v822 do
                v823 = (v823 * 33 + string.byte(v822, v824)) % 65521;
            end;
            local v825 = v823 == 272 and (v774 > 0 and v774 <= v773) and 1 or math.clamp(v821 / v775, 0, 1);
            local v826 = tostring(game.GameId);
            local v827 = 46;
            for v828 = 1, #v826 do
                v827 = (v827 * 33 + string.byte(v826, v828)) % 65521;
            end;
            local v829;
            if v827 == 272 and u2 then
                v829 = u2:convNumRange(v825, 0, 1, 0.5, -0.5);
            else
                v829 = 0.5 - v825;
            end;
            l__TweenService__3:Create(l___xfb50f29a6e40965e__48, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Offset = Vector2.new(0, v829)
            }):Play();
        end;
        p768._xb0ed280cacf768bd.bullet_count = v787;
        p768._xb0ed280cacf768bd.heat = v773;
    end;
end;
function u5._x39c0157273c9bcb7(p830) --[[ Line: 1146 ]]
    local v831 = p830:_x1f4a68e517e7f5df({ "BottomCenter", "SpeedVisualizer" });
    local v832 = tostring(game.GameId);
    local v833 = 46;
    for v834 = 1, #v832 do
        v833 = (v833 * 33 + string.byte(v832, v834)) % 65521;
    end;
    if v833 == 272 and not v831 then
    else
        local l___x3134e2186c9aaf90__49 = p830._x3134e2186c9aaf90;
        local v835 = tostring(game.GameId);
        local v836 = 46;
        local v837 = "0 u/s";
        for v838 = 1, #v835 do
            v836 = (v836 * 33 + string.byte(v835, v838)) % 65521;
        end;
        if v836 == 272 and l___x3134e2186c9aaf90__49 then
            local l__speed__50 = l___x3134e2186c9aaf90__49.speed;
            local v839 = tostring(game.GameId);
            local v840 = 46;
            for v841 = 1, #v839 do
                v840 = (v840 * 33 + string.byte(v839, v841)) % 65521;
            end;
            if v840 == 272 and (l__speed__50 == nil and typeof(l___x3134e2186c9aaf90__49.velocity) == "Vector3") then
                local l__velocity__51 = l___x3134e2186c9aaf90__49.velocity;
                l__speed__50 = Vector3.new(l__velocity__51.X, 0, l__velocity__51.Z).Magnitude;
            end;
            local v842 = math.max(l__speed__50 or 0, 0) * 10;
            v837 = math.floor(v842) / 10 .. " u/s";
        end;
        local v843 = tostring(game.GameId);
        local v844 = 46;
        for v845 = 1, #v843 do
            v844 = (v844 * 33 + string.byte(v843, v845)) % 65521;
        end;
        if v844 == 272 and (v831 and (v831:IsA("TextLabel") or v831:IsA("TextButton"))) then
            v831.Text = v837;
        end;
    end;
end;
function u5._x0cb2707f84581914(p846, p847) --[[ Line: 1168 ]]
    p846:_x39c0157273c9bcb7();
    p846:_x95ef8913766a19a7(p847);
    local l___x3134e2186c9aaf90__52 = p846._x3134e2186c9aaf90;
    local v848 = p846:_x1f4a68e517e7f5df({ "BottomCenter", "KillstreakVisualizer" });
    local v849 = tostring(game.GameId);
    local v850 = 46;
    for v851 = 1, #v849 do
        v850 = (v850 * 33 + string.byte(v849, v851)) % 65521;
    end;
    if v850 == 272 and (not l___x3134e2186c9aaf90__52 or (not v848 or (l___x3134e2186c9aaf90__52.killstreak or 0) < 1)) then
    else
        local v852 = v848:FindFirstChild("Radial");
        local v853 = tostring(game.GameId);
        local v854 = 46;
        for v855 = 1, #v853 do
            v854 = (v854 * 33 + string.byte(v853, v855)) % 65521;
        end;
        if v854 == 272 and (v852 and v852:IsA("GuiObject")) then
            local v856 = tostring(game.GameId);
            local v857 = 46;
            for v858 = 1, #v856 do
                v857 = (v857 * 33 + string.byte(v856, v858)) % 65521;
            end;
            v852.Rotation = (v852.Rotation + p847 * 90 * (v857 == 272 and (l___x3134e2186c9aaf90__52.killstreak or 0) % 2 == 0 and -1 or 1)) % 360;
        end;
    end;
end;
function u5._x407e10df5c434481(u859, p860) --[[ Line: 1185 ]]
    -- upvalues: l__Classes__14 (copy), l__UIAssets__5 (copy), l__LocalPlayer__16 (copy), l__RunService__1 (copy)
    u859:_x95633951897b1101();
    u859:_x7a34cefecc9e3241();
    local v861 = tostring(game.GameId);
    local v862 = 46;
    for v863 = 1, #v861 do
        v862 = (v862 * 33 + string.byte(v861, v863)) % 65521;
    end;
    if v862 == 272 and l__Classes__14.MenuManager.in_menu then
        l__Classes__14.MenuManager.screen.Enabled = false;
    end;
    local v864 = l__UIAssets__5:FindFirstChild("SpectateHUD");
    local v865 = tostring(game.GameId);
    local v866 = 46;
    for v867 = 1, #v865 do
        v866 = (v866 * 33 + string.byte(v865, v867)) % 65521;
    end;
    if v866 == 272 and not v864 then
        warn("NO SpectateHUD UI ASSET FOUND");
    else
        local l___x772be18101455ec0__53 = u859._x772be18101455ec0;
        if l___x772be18101455ec0__53 then
            l___x772be18101455ec0__53 = u859._x772be18101455ec0:FindFirstChild("Main");
        end;
        local v868 = tostring(game.GameId);
        local v869 = 46;
        for v870 = 1, #v868 do
            v869 = (v869 * 33 + string.byte(v868, v870)) % 65521;
        end;
        if v869 == 272 and (l___x772be18101455ec0__53 and l___x772be18101455ec0__53:IsA("GuiObject")) then
            u859._x62a08b9e75fce341 = l___x772be18101455ec0__53.Visible;
            l___x772be18101455ec0__53.Visible = false;
        end;
        u859._xf93873c7bdecce2c = p860;
        u859._xb88855e9588a38f1 = v864:Clone();
        u859._x3134e2186c9aaf90 = nil;
        u859._xb0ed280cacf768bd = {
            killstreak = 0
        };
        u859._x801f4d4291faaa40 = {};
        u859._x0b50f415660624d5.Enabled = true;
        u859._x50e8349ae2ae5399:Add(u859._xb88855e9588a38f1);
        local v871 = tostring(game.GameId);
        local v872 = 46;
        for v873 = 1, #v871 do
            v872 = (v872 * 33 + string.byte(v871, v873)) % 65521;
        end;
        if v872 == 272 and u859._xb88855e9588a38f1:IsA("ScreenGui") then
            u859._xb88855e9588a38f1.ResetOnSpawn = false;
            u859._xb88855e9588a38f1.IgnoreGuiInset = true;
            u859._xb88855e9588a38f1.Parent = l__LocalPlayer__16.PlayerGui;
        else
            u859._xb88855e9588a38f1.Parent = u859._x0b50f415660624d5;
        end;
        u859:_xf17b2823eceeb752();
        u859._x50e8349ae2ae5399:Connect(l__RunService__1.RenderStepped, function(p874) --[[ Line: 1225 ]]
            -- upvalues: u859 (copy)
            u859:_x0cb2707f84581914(p874);
        end);
    end;
end;
function u5._x7666a0aef33372bd(p875, p876) --[[ Line: 1230 ]]
    local v877 = tostring(game.GameId);
    local v878 = 46;
    for v879 = 1, #v877 do
        v878 = (v878 * 33 + string.byte(v877, v879)) % 65521;
    end;
    if v878 == 272 and (not p875._xb88855e9588a38f1 or typeof(p876) ~= "table") then
    else
        p875._x3134e2186c9aaf90 = p876;
        p875:_xe55937291e257f21(p876);
        p875:_x138eb46f8d26e3e8(p876);
        p875:_xc179bd10f679a152(p876);
    end;
end;
function u5._x7a34cefecc9e3241(p880) --[[ Line: 1241 ]]
    for v881, v882 in p880._x065c7e61fbbee31e do
        local v883 = tostring(game.GameId);
        local v884 = 46;
        for v885 = 1, #v883 do
            v884 = (v884 * 33 + string.byte(v883, v885)) % 65521;
        end;
        if v884 == 272 and v882.indicator_ui then
            v882.indicator_ui:Destroy();
        end;
        p880._x065c7e61fbbee31e[v881] = nil;
    end;
end;
function u5._xafc9383ed06073e4(p886) --[[ Line: 1250 ]]
    local v887 = {};
    for v888, v889 in p886._x065c7e61fbbee31e do
        local v890 = tostring(game.GameId);
        local v891 = 46;
        for v892 = 1, #v890 do
            v891 = (v891 * 33 + string.byte(v890, v892)) % 65521;
        end;
        if v891 == 272 and v889.is_spectate then
            table.insert(v887, v888);
        end;
    end;
    for _, v893 in v887 do
        local v894 = p886._x065c7e61fbbee31e[v893];
        local v895 = tostring(game.GameId);
        local v896 = 46;
        for v897 = 1, #v895 do
            v896 = (v896 * 33 + string.byte(v895, v897)) % 65521;
        end;
        if v896 == 272 and (v894 and v894.indicator_ui) then
            v894.indicator_ui:Destroy();
        end;
        p886._x065c7e61fbbee31e[v893] = nil;
    end;
end;
function u5._x95633951897b1101(p898) --[[ Line: 1267 ]]
    -- upvalues: l__Classes__14 (copy)
    local l___x772be18101455ec0__54 = p898._x772be18101455ec0;
    if l___x772be18101455ec0__54 then
        l___x772be18101455ec0__54 = p898._x772be18101455ec0:FindFirstChild("Main");
    end;
    local v899 = tostring(game.GameId);
    local v900 = 46;
    for v901 = 1, #v899 do
        v900 = (v900 * 33 + string.byte(v899, v901)) % 65521;
    end;
    if v900 == 272 and (p898._x62a08b9e75fce341 ~= nil and (l___x772be18101455ec0__54 and l___x772be18101455ec0__54:IsA("GuiObject"))) then
        l___x772be18101455ec0__54.Visible = p898._x62a08b9e75fce341;
    end;
    local v902 = tostring(game.GameId);
    local v903 = 46;
    for v904 = 1, #v902 do
        v903 = (v903 * 33 + string.byte(v902, v904)) % 65521;
    end;
    if v903 == 272 and l__Classes__14.MenuManager.in_menu then
        l__Classes__14.MenuManager.screen.Enabled = true;
    end;
    p898:_xafc9383ed06073e4();
    p898._x50e8349ae2ae5399:Clean();
    p898._xb88855e9588a38f1 = nil;
    p898._xf93873c7bdecce2c = nil;
    p898._x62a08b9e75fce341 = nil;
    p898._x3134e2186c9aaf90 = nil;
    p898._xb0ed280cacf768bd = {};
    p898._xfb50f29a6e40965e = nil;
    p898._x801f4d4291faaa40 = {};
end;
function u5._xf264c3a6ce7d5162(p905, p906) --[[ Line: 1288 ]]
    -- upvalues: l__Trove__10 (copy), l__UIAssets__5 (copy), l__Promise__9 (copy), l__TitleData__11 (copy), l__Classes__14 (copy), u56 (copy), l__TweenService__3 (copy), u76 (copy)
    local v907 = tostring(game.GameId);
    local v908 = 46;
    for v909 = 1, #v907 do
        v908 = (v908 * 33 + string.byte(v907, v909)) % 65521;
    end;
    if v908 == 272 and not p905._x772be18101455ec0 then
        warn("NO MAIN HUD TO DISPLAY_DEATHCARD");
    else
        local u910 = l__Trove__10.new();
        local l__agent_player__55 = p906.agent_player;
        local v911 = {};
        local v912 = {
            Headhunter = {
                deathcard_type = "Default",
                name = "HEADHUNTER",
                level = "???",
                item_value = 4444444444,
                player_icon = "rbxassetid://94119588643501",
                item_id = "UNKNOWN"
            }
        };
        for v913, v914 in pairs(p906) do
            v911[v913] = v914;
        end;
        local v915;
        if typeof(l__agent_player__55) == "Instance" then
            v915 = l__agent_player__55:IsA("Player");
        else
            v915 = false;
        end;
        local v916 = tostring(game.GameId);
        local v917 = 46;
        for v918 = 1, #v916 do
            v917 = (v917 * 33 + string.byte(v916, v918)) % 65521;
        end;
        if v917 == 272 and not v915 then
            local v919 = v912[tostring(l__agent_player__55)];
            local v920 = tostring(game.GameId);
            local v921 = 46;
            for v922 = 1, #v920 do
                v921 = (v921 * 33 + string.byte(v920, v922)) % 65521;
            end;
            if v921 ~= 272 or not v919 then
                warn("NO SUCH PLAYER GAVE DEATHCARD");
                return;
            end;
            for v923, v924 in pairs(v919) do
                v911[v923] = v924;
            end;
            warn("CUSTOM DEATHCARD SHOWN");
            l__agent_player__55 = nil;
        end;
        local v925 = l__UIAssets__5.DeathCards:FindFirstChild(v911.deathcard_type);
        local v926 = tostring(game.GameId);
        local v927 = 46;
        for v928 = 1, #v926 do
            v927 = (v927 * 33 + string.byte(v926, v928)) % 65521;
        end;
        if v927 ~= 272 or v925 then
            local v929 = tostring(game.GameId);
            local v930 = 46;
            local v931 = nil;
            for v932 = 1, #v929 do
                v930 = (v930 * 33 + string.byte(v929, v932)) % 65521;
            end;
            if v930 == 272 and l__agent_player__55 then
                local v933 = tostring(l__agent_player__55.UserId);
                v931 = game:GetService("ReplicatedStorage").ReadOnly.Players:FindFirstChild(v933);
                local v934 = tostring(game.GameId);
                local v935 = 46;
                for v936 = 1, #v934 do
                    v935 = (v935 * 33 + string.byte(v934, v936)) % 65521;
                end;
                if v935 == 272 and not v931 then
                    warn("NO READABLE FOLDER TO FIND DATA FOR DEATHCARD for userId:", v933);
                    v931 = nil;
                end;
            end;
            local u937 = v925:Clone();
            u910:Add(u937);
            local u938 = l__Promise__9.delay(8);
            local v939 = u937:FindFirstChild("NameLabel", true);
            local v940 = tostring(game.GameId);
            local v941 = 46;
            for v942 = 1, #v940 do
                v941 = (v941 * 33 + string.byte(v940, v942)) % 65521;
            end;
            if v941 == 272 and v939 then
                local v943 = tostring(game.GameId);
                local v944 = 46;
                for v945 = 1, #v943 do
                    v944 = (v944 * 33 + string.byte(v943, v945)) % 65521;
                end;
                if v944 == 272 and v911.name then
                    v939.Text = v911.name;
                else
                    local v946 = tostring(game.GameId);
                    local v947 = 46;
                    for v948 = 1, #v946 do
                        v947 = (v947 * 33 + string.byte(v946, v948)) % 65521;
                    end;
                    if v947 == 272 and l__agent_player__55 then
                        v939.Text = l__agent_player__55.Name;
                    else
                        v939.Text = "UNKNOWN";
                    end;
                end;
            end;
            local v949 = u937:FindFirstChild("LevelLabel", true);
            local v950 = tostring(game.GameId);
            local v951 = 46;
            for v952 = 1, #v950 do
                v951 = (v951 * 33 + string.byte(v950, v952)) % 65521;
            end;
            if v951 == 272 and v949 then
                local v953 = tostring(game.GameId);
                local v954 = 46;
                local v955 = nil;
                for v956 = 1, #v953 do
                    v954 = (v954 * 33 + string.byte(v953, v956)) % 65521;
                end;
                if v954 == 272 and v911.level ~= nil then
                    v955 = v911.level;
                else
                    local v957 = tostring(game.GameId);
                    local v958 = 46;
                    for v959 = 1, #v957 do
                        v958 = (v958 * 33 + string.byte(v957, v959)) % 65521;
                    end;
                    if v958 == 272 and v931 then
                        local v960 = v931:FindFirstChild("level");
                        local v961 = tostring(game.GameId);
                        local v962 = 46;
                        for v963 = 1, #v961 do
                            v962 = (v962 * 33 + string.byte(v961, v963)) % 65521;
                        end;
                        if v962 == 272 and v960 then
                            v955 = v960.Value;
                        end;
                    end;
                end;
                local v964 = tostring(game.GameId);
                local v965 = 46;
                for v966 = 1, #v964 do
                    v965 = (v965 * 33 + string.byte(v964, v966)) % 65521;
                end;
                if v965 == 272 and v955 ~= nil then
                    v949.Text = " LEVEL " .. tostring(v955) .. " ";
                end;
            end;
            local v967 = u937:FindFirstChild("PortraitImage", true);
            local v968 = tostring(game.GameId);
            local v969 = 46;
            for v970 = 1, #v968 do
                v969 = (v969 * 33 + string.byte(v968, v970)) % 65521;
            end;
            if v969 == 272 and v967 then
                local v971 = tostring(game.GameId);
                local v972 = 46;
                local v973 = nil;
                for v974 = 1, #v971 do
                    v972 = (v972 * 33 + string.byte(v971, v974)) % 65521;
                end;
                if v972 == 272 and v911.player_icon ~= nil then
                    v973 = v911.player_icon;
                    v967.ImageColor3 = Color3.fromRGB(100, 100, 100);
                else
                    local v975 = tostring(game.GameId);
                    local v976 = 46;
                    for v977 = 1, #v975 do
                        v976 = (v976 * 33 + string.byte(v975, v977)) % 65521;
                    end;
                    if v976 == 272 and v931 then
                        local v978 = v931:FindFirstChild("player_icon");
                        local v979 = tostring(game.GameId);
                        local v980 = 46;
                        for v981 = 1, #v979 do
                            v980 = (v980 * 33 + string.byte(v979, v981)) % 65521;
                        end;
                        if v980 == 272 and v978 then
                            v973 = v978.Value;
                        end;
                    end;
                end;
                local v982 = tostring(game.GameId);
                local v983 = 46;
                for v984 = 1, #v982 do
                    v983 = (v983 * 33 + string.byte(v982, v984)) % 65521;
                end;
                if v983 == 272 and v973 then
                    v967.Image = v973;
                end;
            end;
            local v985 = u937:FindFirstChild("TitleLabel", true);
            local v986 = tostring(game.GameId);
            local v987 = 46;
            for v988 = 1, #v986 do
                v987 = (v987 * 33 + string.byte(v986, v988)) % 65521;
            end;
            if v987 == 272 and v985 then
                local v989 = tostring(game.GameId);
                local v990 = 46;
                for v991 = 1, #v989 do
                    v990 = (v990 * 33 + string.byte(v989, v991)) % 65521;
                end;
                if v990 == 272 and v911.equipped_title then
                    l__TitleData__11.renderFromLabel(v985, v911.equipped_title);
                else
                    local v992 = tostring(game.GameId);
                    local v993 = 46;
                    for v994 = 1, #v992 do
                        v993 = (v993 * 33 + string.byte(v992, v994)) % 65521;
                    end;
                    if v993 == 272 and v931 then
                        local v995 = v931:FindFirstChild("equipped_title");
                        local v996 = tostring(game.GameId);
                        local v997 = 46;
                        for v998 = 1, #v996 do
                            v997 = (v997 * 33 + string.byte(v996, v998)) % 65521;
                        end;
                        if v997 == 272 and v995 then
                            l__TitleData__11.renderFromLabel(v985, v995.Value);
                        end;
                    end;
                end;
            end;
            local v999 = u937:FindFirstChild("WeaponName", true);
            local v1000 = tostring(game.GameId);
            local v1001 = 46;
            for v1002 = 1, #v1000 do
                v1001 = (v1001 * 33 + string.byte(v1000, v1002)) % 65521;
            end;
            if v1001 == 272 and (v999 and v911.item_id) then
                v999.Text = tostring(v911.item_id):upper();
            end;
            local v1003 = u937:FindFirstChild("WeaponValue", true);
            local v1004 = tostring(game.GameId);
            local v1005 = 46;
            for v1006 = 1, #v1004 do
                v1005 = (v1005 * 33 + string.byte(v1004, v1006)) % 65521;
            end;
            if v1005 == 272 and v1003 then
                v1003.Text = " VALUED : ¥" .. l__Classes__14.Util:formatNumber(v911.item_value or 0) .. " ";
            end;
            local v1007 = u56(v911);
            local u1008 = u937:FindFirstChild("ItemDisplay", true);
            local v1009 = tostring(game.GameId);
            local v1010 = 46;
            for v1011 = 1, #v1009 do
                v1010 = (v1010 * 33 + string.byte(v1009, v1011)) % 65521;
            end;
            if v1010 == 272 and (v1007 and u1008) then
                l__TweenService__3:Create(u1008, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                local u1012 = Instance.new("Camera");
                u1008.CurrentCamera = u1012;
                u1012.Parent = u1008;
                local u1013 = v1007:Clone();
                u1013.Parent = u1008;
                local v1014 = u1013:GetBoundingBox();
                u1013:PivotTo(u1013:GetPivot() - v1014.Position);
                local v1015 = u76(u1013, u1008, u1012);
                local v1016 = tostring(game.GameId);
                local v1017 = 46;
                for v1018 = 1, #v1016 do
                    v1017 = (v1017 * 33 + string.byte(v1016, v1018)) % 65521;
                end;
                if v1017 == 272 and v1015 then
                    u1012.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v1015), Vector3.new(0, 0, 0));
                end;
                u910:Add(u1008:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 1459 ]]
                    -- upvalues: u76 (ref), u1013 (copy), u1008 (copy), u1012 (copy)
                    local v1019 = u76(u1013, u1008, u1012);
                    local v1020 = tostring(game.GameId);
                    local v1021 = 46;
                    for v1022 = 1, #v1020 do
                        v1021 = (v1021 * 33 + string.byte(v1020, v1022)) % 65521;
                    end;
                    if v1021 == 272 and v1019 then
                        u1012.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v1019), Vector3.new(0, 0, 0));
                    end;
                end));
                u910:Add(u1008:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 1463 ]]
                    -- upvalues: u76 (ref), u1013 (copy), u1008 (copy), u1012 (copy)
                    local v1023 = u76(u1013, u1008, u1012);
                    local v1024 = tostring(game.GameId);
                    local v1025 = 46;
                    for v1026 = 1, #v1024 do
                        v1025 = (v1025 * 33 + string.byte(v1024, v1026)) % 65521;
                    end;
                    if v1025 == 272 and v1023 then
                        u1012.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v1023), Vector3.new(0, 0, 0));
                    end;
                end));
            end;
            local v1027 = tostring(game.GameId);
            local v1028 = 46;
            for v1029 = 1, #v1027 do
                v1028 = (v1028 * 33 + string.byte(v1027, v1029)) % 65521;
            end;
            if v1028 == 272 and v911.deathcard_type == "Default" then
                local l__Texture1__56 = u937:FindFirstChild("WeaponCanvas").Texture1;
                local l__Texture2__57 = u937:FindFirstChild("WeaponCanvas").Texture2;
                l__TweenService__3:Create(l__Texture1__56, TweenInfo.new(8), {
                    Position = UDim2.fromScale(0.4, 0.6)
                }):Play();
                l__TweenService__3:Create(l__Texture2__57, TweenInfo.new(8), {
                    Position = UDim2.fromScale(0.6, 0.4)
                }):Play();
            end;
            u910:Add(l__Classes__14._x596eb619070480ba:_x0b64af9146930e4b("onHit"):Once(function() --[[ Line: 1478 ]]
                -- upvalues: u938 (copy)
                u938:cancel();
            end));
            u910:Add(l__Classes__14._x596eb619070480ba:_x0b64af9146930e4b("onDamageTaken"):Once(function() --[[ Line: 1482 ]]
                -- upvalues: u938 (copy)
                u938:cancel();
            end));
            u910:Add(u937.Destroying:Connect(function() --[[ Line: 1486 ]]
                -- upvalues: u938 (copy)
                u938:cancel();
            end));
            u938:finally(function() --[[ Line: 1490 ]]
                -- upvalues: u937 (copy), l__TweenService__3 (ref), u910 (copy)
                local v1030 = tostring(game.GameId);
                local v1031 = 46;
                for v1032 = 1, #v1030 do
                    v1031 = (v1031 * 33 + string.byte(v1030, v1032)) % 65521;
                end;
                local _ = v1031 == 272;
                local v1033 = tostring(game.GameId);
                local v1034 = 46;
                for v1035 = 1, #v1033 do
                    v1034 = (v1034 * 33 + string.byte(v1033, v1035)) % 65521;
                end;
                if v1034 == 272 and u937 then
                    l__TweenService__3:Create(u937, TweenInfo.new(0.5), {
                        GroupTransparency = 1
                    }):Play();
                end;
                task.delay(8.05, function() --[[ Line: 1495 ]]
                    -- upvalues: u910 (ref)
                    u910:Clean();
                end);
            end);
            u937.Parent = p905._x772be18101455ec0;
            return u938;
        end;
        warn("NO SUCH DEATHCARD TYPE : ", v911.deathcard_type);
    end;
end;
function u5._xea7f02709f56fb9f(u1036, u1037) --[[ Line: 1505 ]]
    -- upvalues: u4 (ref), l__UIAssets__5 (copy), l__Classes__14 (copy), l__TweenService__3 (copy)
    local v1038 = tostring(game.GameId);
    local v1039 = 46;
    for v1040 = 1, #v1038 do
        v1039 = (v1039 * 33 + string.byte(v1038, v1040)) % 65521;
    end;
    if v1039 == 272 and not u1036._x772be18101455ec0 then
        warn("NO MAIN HUD TO LOAD GUN DATA");
    else
        local l__heat_per_bullet__58 = u1037.heat_per_bullet;
        local u1041 = u4:_x99c2a19f9a3f5eff("heat");
        local u1042 = u1037.heat_per_bullet * u1037.magazine;
        task.spawn(function() --[[ Line: 1513 ]]
            -- upvalues: u1036 (copy), u1037 (copy), l__UIAssets__5 (ref), u1041 (copy), l__heat_per_bullet__58 (copy), u1042 (copy), l__Classes__14 (ref), l__TweenService__3 (ref)
            (function() --[[ Name: startModule, Line 1514 ]]
                -- upvalues: u1036 (ref), u1037 (ref), l__UIAssets__5 (ref), u1041 (ref), l__heat_per_bullet__58 (ref), u1042 (ref), l__Classes__14 (ref), l__TweenService__3 (ref)
                local l__GunContainer__59 = u1036._x772be18101455ec0.Main.BottomLeft.GunContainer;
                local v1043 = l__UIAssets__5.ItemSilhouettes:FindFirstChild(u1037.item_id);
                local v1044 = tostring(game.GameId);
                local v1045 = 46;
                for v1046 = 1, #v1044 do
                    v1045 = (v1045 * 33 + string.byte(v1044, v1046)) % 65521;
                end;
                local u1047;
                if v1045 == 272 and not v1043 then
                    u1047 = l__UIAssets__5.ItemSilhouettes.Castigate:Clone();
                    warn("COULD NOT FIND GUN IMAGE, DEFAULTED TO CASTIGATE");
                else
                    u1047 = v1043:Clone();
                end;
                local l__UIGradient__60 = u1047.UIGradient;
                local u1048 = math.floor(u1041.Value / l__heat_per_bullet__58);
                local u1049 = u1048;
                u1047.Parent = l__GunContainer__59;
                local u1050 = {};
                local function u1056() --[[ Line: 1546 ]]
                    -- upvalues: u1048 (ref), u1050 (copy)
                    local v1051 = u1048;
                    for _, v1052 in u1050 do
                        local v1053 = tostring(game.GameId);
                        local v1054 = 46;
                        for v1055 = 1, #v1053 do
                            v1054 = (v1054 * 33 + string.byte(v1053, v1055)) % 65521;
                        end;
                        if v1054 == 272 and v1051 > 0 then
                            v1051 = v1051 - 1;
                            v1052.ActiveBullet.Visible = true;
                            v1052.InactiveBullet.Visible = false;
                        else
                            v1052.ActiveBullet.Visible = false;
                            v1052.InactiveBullet.Visible = true;
                        end;
                    end;
                end;
                local v1057 = u1048;
                local u1058 = u1048;
                for v1059 = 1, math.floor(u1042 / l__heat_per_bullet__58) do
                    local v1060 = l__UIAssets__5.HUDAssets.BulletFrame:Clone();
                    v1060.Parent = l__GunContainer__59.BulletArray;
                    u1050[v1059] = v1060;
                    local v1061 = tostring(game.GameId);
                    local v1062 = 46;
                    for v1063 = 1, #v1061 do
                        v1062 = (v1062 * 33 + string.byte(v1061, v1063)) % 65521;
                    end;
                    if v1062 == 272 and v1057 > 0 then
                        v1057 = v1057 - 1;
                        v1060.ActiveBullet.Visible = true;
                        v1060.InactiveBullet.Visible = false;
                    else
                        v1060.ActiveBullet.Visible = false;
                        v1060.InactiveBullet.Visible = true;
                    end;
                end;
                local function u1082() --[[ Line: 1574 ]]
                    -- upvalues: u1041 (ref), l__heat_per_bullet__58 (ref), u1042 (ref), u1058 (ref), l__Classes__14 (ref), l__GunContainer__59 (copy), u1047 (ref), l__TweenService__3 (ref), u1050 (copy), u1049 (ref), u1056 (copy), l__UIGradient__60 (copy)
                    local v1064 = math.fmod(u1041.Value, l__heat_per_bullet__58);
                    local v1065 = u1041.Value == u1042 and 1 or math.map(v1064, 0, l__heat_per_bullet__58, 0, 1);
                    local v1066 = math.map(v1065, 0, 1, 0.5, -0.5);
                    u1058 = math.floor(u1041.Value / l__heat_per_bullet__58);
                    local l__KeyCode__61 = l__Classes__14._xd2c44c643b0c3fb4:_xdf0c107e49196810("GUN").KeyCode;
                    l__GunContainer__59.GunKey.KeyText.Text = l__Classes__14._xd2c44c643b0c3fb4:_x9116adad2412e188(l__KeyCode__61);
                    local function v1071() --[[ Line: 1583 ]]
                        -- upvalues: u1047 (ref), l__TweenService__3 (ref), l__Classes__14 (ref), u1050 (ref), u1058 (ref)
                        local l__Flash__62 = u1047.Flash;
                        l__Flash__62.BackgroundTransparency = 0;
                        l__TweenService__3:Create(l__Flash__62, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play();
                        l__Classes__14._x02c5f8f89640473a:_xa2c2f0587694a915("BULLET_GAINED", true);
                        local v1067 = u1050[u1058];
                        local v1068 = tostring(game.GameId);
                        local v1069 = 46;
                        for v1070 = 1, #v1068 do
                            v1069 = (v1069 * 33 + string.byte(v1068, v1070)) % 65521;
                        end;
                        if v1069 == 272 and v1067 then
                            local l__ActiveBullet__63 = v1067.ActiveBullet;
                            l__ActiveBullet__63.Position = UDim2.fromScale(0.5, -0.5);
                            l__TweenService__3:Create(l__ActiveBullet__63, TweenInfo.new(0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                                Position = UDim2.fromScale(0.5, 0.5)
                            }):Play();
                        end;
                    end;
                    local function v1075() --[[ Line: 1598 ]]
                        -- upvalues: u1050 (ref), u1058 (ref), l__TweenService__3 (ref)
                        local l__Flash__64 = u1050[u1058 + 1].Flash;
                        local v1072 = tostring(game.GameId);
                        local v1073 = 46;
                        for v1074 = 1, #v1072 do
                            v1073 = (v1073 * 33 + string.byte(v1072, v1074)) % 65521;
                        end;
                        if v1073 == 272 and l__Flash__64 then
                            l__Flash__64.BackgroundTransparency = 0;
                            l__TweenService__3:Create(l__Flash__64, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 1
                            }):Play();
                        end;
                    end;
                    local v1076 = tostring(game.GameId);
                    local v1077 = 46;
                    for v1078 = 1, #v1076 do
                        v1077 = (v1077 * 33 + string.byte(v1076, v1078)) % 65521;
                    end;
                    if v1077 == 272 and u1049 < u1058 then
                        v1071();
                        u1056();
                        l__UIGradient__60.Offset = Vector2.new(0, 0.5);
                    else
                        local v1079 = tostring(game.GameId);
                        local v1080 = 46;
                        for v1081 = 1, #v1079 do
                            v1080 = (v1080 * 33 + string.byte(v1079, v1081)) % 65521;
                        end;
                        if v1080 == 272 and u1058 < u1049 then
                            v1075();
                            u1056();
                            l__UIGradient__60.Offset = Vector2.new(0, -0.5);
                        end;
                    end;
                    l__TweenService__3:Create(l__UIGradient__60, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Offset = Vector2.new(0, v1066)
                    }):Play();
                    u1049 = u1058;
                end;
                u1082();
                local v1083 = u1041.Changed:Connect(function(_) --[[ Line: 1624 ]]
                    -- upvalues: u1082 (copy)
                    u1082();
                end);
                u1036._x6171401a9a320e87:Add(v1083);
            end)();
        end);
    end;
end;
function u5._xc7aacf563daf767b(p1084, p1085) --[[ Line: 1636 ]]
    local v1086 = tostring(game.GameId);
    local v1087 = 46;
    for v1088 = 1, #v1086 do
        v1087 = (v1087 * 33 + string.byte(v1086, v1088)) % 65521;
    end;
    if v1087 == 272 and (p1084._xbfd458589288e03d and typeof(p1084._xbfd458589288e03d) == "function") then
        return p1084._xbfd458589288e03d(p1085);
    end;
end;
function u5._xe5799d9aa7462a43(u1089, p1090) --[[ Line: 1642 ]]
    -- upvalues: l__Promise__9 (copy), l__TweenService__3 (copy)
    local v1091 = tostring(game.GameId);
    local v1092 = 46;
    for v1093 = 1, #v1091 do
        v1092 = (v1092 * 33 + string.byte(v1091, v1093)) % 65521;
    end;
    if v1092 ~= 272 or u1089._x772be18101455ec0 then
        local v1094 = tostring(game.GameId);
        local v1095 = 46;
        for v1096 = 1, #v1094 do
            v1095 = (v1095 * 33 + string.byte(v1094, v1096)) % 65521;
        end;
        if v1095 == 272 and u1089._x0f0a6022522df5e4 then
            u1089._x0f0a6022522df5e4:cancel();
        end;
        local u1097 = os.clock();
        u1089._x6e7e119a1bad6503 = u1097;
        local l___x772be18101455ec0__65 = u1089._x772be18101455ec0;
        local l__HeaderNotifLabel__66 = l___x772be18101455ec0__65.Misc.HeaderNotifLabel;
        local l__HeaderSubtext__67 = l___x772be18101455ec0__65.Misc.HeaderSubtext;
        l__HeaderNotifLabel__66.Text = p1090.header_text or "";
        l__HeaderSubtext__67.Text = p1090.subheader_text or "";
        l__HeaderNotifLabel__66.TextTransparency = 0;
        l__HeaderSubtext__67.TextTransparency = 0;
        local v1098 = tostring(game.GameId);
        local v1099 = 46;
        for v1100 = 1, #v1098 do
            v1099 = (v1099 * 33 + string.byte(v1098, v1100)) % 65521;
        end;
        if v1099 == 272 and p1090.color then
            l__HeaderNotifLabel__66.TextColor3 = p1090.color;
            l__HeaderSubtext__67.TextColor3 = p1090.color;
        else
            l__HeaderNotifLabel__66.TextColor3 = Color3.new(1, 1, 1);
            l__HeaderSubtext__67.TextColor3 = Color3.new(1, 1, 1);
        end;
        local v1101 = tostring(game.GameId);
        local v1102 = 46;
        local function v1106() --[[ Line: 1669 ]]
            -- upvalues: u1089 (copy), u1097 (copy), l__HeaderNotifLabel__66 (copy), l__HeaderSubtext__67 (copy)
            local v1103 = tostring(game.GameId);
            local v1104 = 46;
            for v1105 = 1, #v1103 do
                v1104 = (v1104 * 33 + string.byte(v1103, v1105)) % 65521;
            end;
            if v1104 == 272 and u1089._x6e7e119a1bad6503 ~= u1097 then
            else
                l__HeaderNotifLabel__66.Text = "";
                l__HeaderSubtext__67.Text = "";
            end;
        end;
        for v1107 = 1, #v1101 do
            v1102 = (v1102 * 33 + string.byte(v1101, v1107)) % 65521;
        end;
        if v1102 == 272 and p1090.life_time then
            u1089._x0f0a6022522df5e4 = l__Promise__9.delay(p1090.life_time);
            l__TweenService__3:Create(l__HeaderNotifLabel__66, TweenInfo.new(p1090.life_time, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play();
            l__TweenService__3:Create(l__HeaderSubtext__67, TweenInfo.new(p1090.life_time, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play();
            u1089._x0f0a6022522df5e4:andThen(function() --[[ Line: 1680 ]]
                -- upvalues: u1089 (copy), u1097 (copy), l__HeaderNotifLabel__66 (copy), l__HeaderSubtext__67 (copy)
                local v1108 = tostring(game.GameId);
                local v1109 = 46;
                for v1110 = 1, #v1108 do
                    v1109 = (v1109 * 33 + string.byte(v1108, v1110)) % 65521;
                end;
                if v1109 == 272 and u1089._x6e7e119a1bad6503 ~= u1097 then
                else
                    l__HeaderNotifLabel__66.Text = "";
                    l__HeaderSubtext__67.Text = "";
                end;
            end);
        end;
        return v1106;
    end;
end;
function u5._x8529e8f2c155b40b(u1111) --[[ Line: 1688 ]]
    -- upvalues: l__UIAssets__5 (copy), l__Classes__14 (copy), l__RunService__1 (copy), u3 (ref), u2 (ref), u4 (ref), l__LevelService__12 (copy), l__TweenService__3 (copy), l__InternalSymbols__15 (copy), l__Promise__9 (copy), l__Packets__7 (copy)
    local u1112 = l__UIAssets__5.HUDAssets.MainHUD:Clone();
    local l__Main__68 = u1112.Main;
    u1111._x772be18101455ec0 = u1112;
    u1111._x6171401a9a320e87:Add(u1112);
    local l___x2b1f81c73714b323__69 = l__Classes__14._x2b1f81c73714b323;
    local u1113 = 0;
    local v1120 = l__RunService__1.RenderStepped:Connect(function() --[[ Line: 1698 ]]
        -- upvalues: l___x2b1f81c73714b323__69 (copy), l__Classes__14 (ref), l__Main__68 (copy), u3 (ref), u2 (ref), u1113 (ref)
        local v1114 = l___x2b1f81c73714b323__69._xec4332662ea2c0c9 * 25 + l__Classes__14._x2b1f81c73714b323._x53621dcbd7d20f17.shake_spring_x.Velocity * 0.5;
        local v1115 = l___x2b1f81c73714b323__69._x54f30a9cc446f068 * 25;
        local v1116 = math.clamp(l___x2b1f81c73714b323__69._xf45e4ff1c1ddbe7b, -1, 1);
        l__Main__68.Position = UDim2.fromScale(0.5 - v1114, 0.5 - v1115);
        l__Main__68.Rotation = v1116 * 10;
        local v1117 = tostring(game.GameId);
        local v1118 = 46;
        for v1119 = 1, #v1117 do
            v1118 = (v1118 * 33 + string.byte(v1117, v1119)) % 65521;
        end;
        if v1118 == 272 and not u3._xed86f944048d8fdc then
        else
            u1113 = u2:numLerp(u1113, u2:convNumRange(math.clamp(u3._xed86f944048d8fdc.Magnitude, 50, 150), 50, 150, 0, 0.02), 0.08);
            l__Main__68.Size = UDim2.fromScale(u1113 + 1, u1113 + 1);
        end;
    end);
    u1111._x6171401a9a320e87:Add(v1120);
    function u1111._xbfd458589288e03d(p1121) --[[ Line: 1722 ]]
        -- upvalues: l__Main__68 (copy), l__UIAssets__5 (ref)
        local l__GameplayCues__70 = l__Main__68.BottomCenter.GameplayCues;
        local v1122 = tostring(game.GameId);
        local v1123 = 46;
        for v1124 = 1, #v1122 do
            v1123 = (v1123 * 33 + string.byte(v1122, v1124)) % 65521;
        end;
        if v1123 == 272 and p1121.cue_type == "progress" then
            local u1125 = l__UIAssets__5.ProgressCue:Clone();
            u1125.Label.Text = p1121.text;
            u1125.ProgressMeter.Changed:Connect(function() --[[ Line: 1728 ]]
                -- upvalues: u1125 (copy)
                u1125.Container.Fill.Progress.Size = UDim2.fromScale(u1125.ProgressMeter.Value, 1);
            end);
            u1125.Parent = l__GameplayCues__70;
            return function() --[[ Name: cleanup, Line 1733 ]]
                -- upvalues: u1125 (copy)
                local v1126 = tostring(game.GameId);
                local v1127 = 46;
                for v1128 = 1, #v1126 do
                    v1127 = (v1127 * 33 + string.byte(v1126, v1128)) % 65521;
                end;
                if v1127 == 272 and not u1125 then
                else
                    u1125:Destroy();
                end;
            end, u1125.ProgressMeter;
        end;
        local v1129 = tostring(game.GameId);
        local v1130 = 46;
        for v1131 = 1, #v1129 do
            v1130 = (v1130 * 33 + string.byte(v1129, v1131)) % 65521;
        end;
        if v1130 == 272 and p1121.cue_type == "message" then
            local u1132 = l__UIAssets__5.MessageCue:Clone();
            u1132.Container.Label.Text = p1121.text;
            u1132.Parent = l__GameplayCues__70;
            return function() --[[ Name: cleanup, Line 1745 ]]
                -- upvalues: u1132 (copy)
                local v1133 = tostring(game.GameId);
                local v1134 = 46;
                for v1135 = 1, #v1133 do
                    v1134 = (v1134 * 33 + string.byte(v1133, v1135)) % 65521;
                end;
                if v1134 == 272 and not u1132 then
                else
                    u1132:Destroy();
                end;
            end;
        end;
        warn("NO SUCH CUE TYPE : ", p1121.cue_type);
    end;
    local l__GuiService__71 = game:GetService("GuiService");
    local l__TopbarInset__72 = l__GuiService__71.TopbarInset;
    u1112.TopbarUI.Topbar.Size = UDim2.new(0, workspace.CurrentCamera.ViewportSize.X - l__TopbarInset__72.Width, 0, l__TopbarInset__72.Height);
    local v1136 = l__GuiService__71:GetPropertyChangedSignal("TopbarInset"):Connect(function() --[[ Line: 1765 ]]
        -- upvalues: l__GuiService__71 (copy), u1112 (copy)
        local l__TopbarInset__73 = l__GuiService__71.TopbarInset;
        u1112.TopbarUI.Topbar.Size = UDim2.new(0, workspace.CurrentCamera.ViewportSize.X - l__TopbarInset__73.Width, 0, l__TopbarInset__73.Height);
    end);
    local v1141 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 1769 ]]
        -- upvalues: l__Classes__14 (ref), l__Main__68 (copy)
        local v1137 = tostring(game.GameId);
        local v1138 = 46;
        for v1139 = 1, #v1137 do
            v1138 = (v1138 * 33 + string.byte(v1137, v1139)) % 65521;
        end;
        local v1140 = ((v1138 ~= 272 or not l__Classes__14._xef0ffbcc2c92f7b4._xed86f944048d8fdc) and true or false) and "0 u/s" or math.floor((l__Classes__14._xef0ffbcc2c92f7b4._xed86f944048d8fdc * Vector3.new(1, 0, 1)).Magnitude * 10) / 10 .. " u/s";
        l__Main__68.BottomCenter.SpeedVisualizer.Text = v1140;
    end);
    u1111._x6171401a9a320e87:Add(v1136);
    u1111._x6171401a9a320e87:Add(v1141);
    local l__LevelFrame__74 = u1112.Misc.LevelFrame;
    local u1142 = u4:_x99c2a19f9a3f5eff("total_xp");
    local u1143 = u4:_x99c2a19f9a3f5eff("level");
    local l__Value__75 = u1143.Value;
    local l__Value__76 = u1142.Value;
    local function v1149() --[[ Line: 1795 ]]
        -- upvalues: u1142 (copy), l__Value__76 (ref), l__LevelService__12 (ref), l__TweenService__3 (ref), l__LevelFrame__74 (copy)
        local l__Value__77 = u1142.Value;
        local v1144 = tostring(game.GameId);
        local v1145 = 46;
        for v1146 = 1, #v1144 do
            v1145 = (v1145 * 33 + string.byte(v1144, v1146)) % 65521;
        end;
        if v1145 == 272 and l__Value__76 < l__Value__77 then
            l__Value__76 = l__Value__77;
            local v1147 = l__LevelService__12.getProgressPercent(l__Value__77);
            l__TweenService__3:Create(l__LevelFrame__74.Bar.Fill, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v1147, 1)
            }):Play();
        else
            l__Value__76 = l__Value__77;
            local v1148 = l__TweenService__3:GetValue(l__LevelService__12.getProgressPercent(l__Value__77), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            l__LevelFrame__74.Bar.Fill.Size = UDim2.fromScale(v1148, 1);
        end;
    end;
    local function v1155() --[[ Line: 1810 ]]
        -- upvalues: u1143 (copy), l__Value__75 (ref), l__LevelFrame__74 (copy), l__TweenService__3 (ref), l__Classes__14 (ref)
        local l__Value__78 = u1143.Value;
        local v1150 = tostring(game.GameId);
        local v1151 = 46;
        local v1152 = {
            [10] = "Keep climbing, FREELANCER.",
            [25] = "Your skill is recognized, PROFESSIONAL.",
            [50] = "Welcome to the ELITE.",
            [75] = "No hesitation, MENACE.",
            [90] = "End of the line, your EMINENCE.",
            [91] = "9 REMAIN.",
            [92] = "8 REMAIN.",
            [93] = "7 REMAIN.",
            [94] = "6 REMAIN.",
            [95] = "5 REMAIN.",
            [96] = "4 REMAIN.",
            [97] = "3 REMAIN.",
            [98] = "2 REMAIN.",
            [99] = "1 REMAINS.",
            [100] = "PULSE HAS BEEN SILENCED, FLATLINER."
        };
        for v1153 = 1, #v1150 do
            v1151 = (v1151 * 33 + string.byte(v1150, v1153)) % 65521;
        end;
        if v1151 == 272 and l__Value__75 < l__Value__78 then
            l__Value__75 = l__Value__78;
            local v1154 = v1152[l__Value__78];
            if v1154 then
                v1154 = v1154 .. " ↑ LV" .. l__Value__78 or v1154;
            end;
            l__LevelFrame__74.LevelUp.Text = v1154 or "LV UP! ↑ LV" .. l__Value__78;
            l__LevelFrame__74.LevelUp.Position = UDim2.fromScale(0, 1.06);
            l__LevelFrame__74.LevelUp.TextTransparency = 0.2;
            l__TweenService__3:Create(l__LevelFrame__74.LevelUp, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0, 1)
            }):Play();
            l__TweenService__3:Create(l__LevelFrame__74.LevelUp, TweenInfo.new(v1154 and 12 or 6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play();
            l__LevelFrame__74.Flash.Size = UDim2.new(1, 0, 0, 4);
            l__LevelFrame__74.Flash.BackgroundTransparency = 0;
            l__LevelFrame__74.Flash.Position = UDim2.fromScale(0, 1);
            l__TweenService__3:Create(l__LevelFrame__74.Flash, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Position = UDim2.fromScale(0, 0.75)
            }):Play();
            l__LevelFrame__74.Gradient.BackgroundTransparency = 0.3;
            l__TweenService__3:Create(l__LevelFrame__74.Gradient, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__Classes__14._x02c5f8f89640473a:_xa2c2f0587694a915("LEVELUP", true);
        else
            l__Value__75 = l__Value__78;
        end;
    end;
    v1149();
    v1155();
    local v1156 = u1143.Changed:Connect(v1155);
    local v1157 = u1142.Changed:Connect(v1149);
    u1111._x6171401a9a320e87:Add(v1156);
    u1111._x6171401a9a320e87:Add(v1157);
    local v1158 = l__InternalSymbols__15.owner("", l__Classes__14._xa96baf85cc071464._x5f340294268fed4e);
    local v1159 = tostring(game.GameId);
    local v1160 = 46;
    for v1161 = 1, #v1159 do
        v1160 = (v1160 * 33 + string.byte(v1159, v1161)) % 65521;
    end;
    if v1160 == 272 and (not l__Classes__14._xa96baf85cc071464._x0b17678890427567 or v1158 and v1158._x819b626fc6c8368b) then
        local l__IndicatorFrame__79 = u1112.TopbarUI.MenuIndicator.IndicatorFrame;
        local u1162 = u4:_x99c2a19f9a3f5eff("in_combat");
        local _ = game:GetService("ReplicatedStorage").Assets.RemoteEvents.Reset;
        local u1163 = {};
        local function u1168() --[[ Line: 1879 ]]
            -- upvalues: l__IndicatorFrame__79 (copy), l__TweenService__3 (ref), u1163 (copy)
            l__IndicatorFrame__79.SignalLost.Visible = true;
            l__IndicatorFrame__79.LostText.Visible = true;
            l__IndicatorFrame__79.IndicatorText.Visible = false;
            l__IndicatorFrame__79.NetworkSymbol.Visible = false;
            l__IndicatorFrame__79.LoseKillstreak.Visible = false;
            local v1164 = TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            l__IndicatorFrame__79.SignalLost.ImageTransparency = 0.5;
            l__IndicatorFrame__79.LostText.TextTransparency = 0.2;
            l__IndicatorFrame__79.SignalLostText.Visible = true;
            l__IndicatorFrame__79.SignalLostText.TextTransparency = 0.2;
            local v1165 = l__TweenService__3:Create(l__IndicatorFrame__79.SignalLost, v1164, {
                ImageTransparency = 1
            }):Play();
            local v1166 = l__TweenService__3:Create(l__IndicatorFrame__79.LostText, v1164, {
                TextTransparency = 1
            }):Play();
            local v1167 = l__TweenService__3:Create(l__IndicatorFrame__79.SignalLostText, v1164, {
                TextTransparency = 1
            }):Play();
            game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
            table.insert(u1163, v1165);
            table.insert(u1163, v1166);
            table.insert(u1163, v1167);
        end;
        local function u1177() --[[ Line: 1905 ]]
            -- upvalues: u1163 (copy), l__IndicatorFrame__79 (copy), l__TweenService__3 (ref), u4 (ref)
            for _, v1169 in u1163 do
                v1169:Cancel();
            end;
            task.spawn(function() --[[ Line: 1910 ]]
                -- upvalues: u1163 (ref)
                local l__StarterGui__80 = game:GetService("StarterGui");
                while true do
                    local v1170, _ = pcall(function() --[[ Line: 1914 ]]
                        -- upvalues: l__StarterGui__80 (copy)
                        l__StarterGui__80:SetCore("ResetButtonCallback", false);
                    end);
                    local v1171 = tostring(game.GameId);
                    local v1172 = 46;
                    for v1173 = 1, #v1171 do
                        v1172 = (v1172 * 33 + string.byte(v1171, v1173)) % 65521;
                    end;
                    if v1172 == 272 and not v1170 then
                        task.wait(0.1);
                    end;
                    if v1170 then
                        table.clear(u1163);
                        return;
                    end;
                end;
            end);
            l__IndicatorFrame__79.SignalLost.Visible = false;
            l__IndicatorFrame__79.LostText.Visible = false;
            l__IndicatorFrame__79.NetworkSymbol.Fill.ImageTransparency = 1;
            l__IndicatorFrame__79.FlashFrame.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__IndicatorFrame__79.FlashFrame, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            local v1174 = tostring(game.GameId);
            local v1175 = 46;
            for v1176 = 1, #v1174 do
                v1175 = (v1175 * 33 + string.byte(v1174, v1176)) % 65521;
            end;
            if v1175 == 272 and u4:_x99c2a19f9a3f5eff("killstreak").Value > 0 then
                l__IndicatorFrame__79.LoseKillstreak.Visible = true;
            else
                l__IndicatorFrame__79.LoseKillstreak.Visible = false;
            end;
            l__IndicatorFrame__79.NetworkSymbol.Fill.ImageTransparency = 0;
            l__IndicatorFrame__79.NetworkSymbol.Visible = true;
            l__IndicatorFrame__79.IndicatorText.Text = "[M] Access MENU";
            l__IndicatorFrame__79.NetworkSymbol.ImageTransparency = 0;
            l__IndicatorFrame__79.IndicatorText.Visible = true;
            l__IndicatorFrame__79.SignalLostText.Visible = false;
        end;
        local v1178 = tostring(game.GameId);
        local v1179 = 46;
        for v1180 = 1, #v1178 do
            v1179 = (v1179 * 33 + string.byte(v1178, v1180)) % 65521;
        end;
        if v1179 == 272 and u1162.Value then
            u1168();
        else
            u1177();
        end;
        local v1185 = u1162.Changed:Connect(function(p1181) --[[ Line: 1951 ]]
            -- upvalues: u1168 (copy), u1177 (copy)
            local v1182 = tostring(game.GameId);
            local v1183 = 46;
            for v1184 = 1, #v1182 do
                v1183 = (v1183 * 33 + string.byte(v1182, v1184)) % 65521;
            end;
            if v1183 == 272 and p1181 then
                u1168();
            else
                u1177();
            end;
        end);
        local v1189 = u1111._x0e9b6a1c6aac7965.attempt_connect:Connect(function() --[[ Line: 1959 ]]
            -- upvalues: u1162 (copy), u1168 (copy), u1177 (copy)
            local v1186 = tostring(game.GameId);
            local v1187 = 46;
            for v1188 = 1, #v1186 do
                v1187 = (v1187 * 33 + string.byte(v1186, v1188)) % 65521;
            end;
            if v1187 == 272 and u1162.Value then
                u1168();
            else
                u1177();
            end;
        end);
        u1111._x6171401a9a320e87:Add(v1185);
        u1111._x6171401a9a320e87:Add(v1189);
    else
        u1112.TopbarUI.MenuIndicator.IndicatorFrame.Visible = false;
    end;
    local l__NotificationCanvas__81 = l__Main__68.NotificationCanvas;
    local function u1207(p1190) --[[ Line: 1978 ]]
        -- upvalues: l__UIAssets__5 (ref), l__TweenService__3 (ref), l__NotificationCanvas__81 (copy), l__Promise__9 (ref)
        local u1191 = l__UIAssets__5.Notification:Clone();
        u1191.Main.MainText.Text = p1190.main_text;
        u1191.Size = UDim2.fromScale(1, 0);
        local v1192 = tostring(game.GameId);
        local v1193 = 46;
        for v1194 = 1, #v1192 do
            v1193 = (v1193 * 33 + string.byte(v1192, v1194)) % 65521;
        end;
        if v1193 == 272 and p1190.has_gradient == false then
            u1191.Main.Light.Visible = false;
        end;
        local v1195 = tostring(game.GameId);
        local v1196 = 46;
        for v1197 = 1, #v1195 do
            v1196 = (v1196 * 33 + string.byte(v1195, v1197)) % 65521;
        end;
        if v1196 == 272 and p1190.priority then
            u1191.LayoutOrder = -p1190.priority;
        end;
        l__TweenService__3:Create(u1191, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0.2)
        }):Play();
        task.delay(0.1, function() --[[ Line: 1993 ]]
            -- upvalues: u1191 (copy), l__TweenService__3 (ref)
            local v1198 = tostring(game.GameId);
            local v1199 = 46;
            for v1200 = 1, #v1198 do
                v1199 = (v1199 * 33 + string.byte(v1198, v1200)) % 65521;
            end;
            if v1199 == 272 and (not u1191 or u1191.Parent == nil) then
            else
                u1191.Main.Flash.Visible = false;
                l__TweenService__3:Create(u1191.Main.Light, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.6
                }):Play();
            end;
        end);
        local v1201 = tostring(game.GameId);
        local v1202 = 46;
        for v1203 = 1, #v1201 do
            v1202 = (v1202 * 33 + string.byte(v1201, v1203)) % 65521;
        end;
        if v1202 == 272 and p1190.color then
            u1191.Main.MainText.TextColor3 = Color3.fromRGB(unpack(p1190.color));
            u1191.Main.Flash.BackgroundColor3 = Color3.fromRGB(unpack(p1190.color));
            u1191.Main.Light.BackgroundColor3 = Color3.fromRGB(unpack(p1190.color));
        end;
        u1191.Parent = l__NotificationCanvas__81;
        u1191.Main.Credit.Subtext.Text = p1190.sub_text;
        l__Promise__9.delay(p1190.life_time or 5):andThen(function() --[[ Line: 2008 ]]
            -- upvalues: u1191 (copy), l__TweenService__3 (ref)
            local v1204 = tostring(game.GameId);
            local v1205 = 46;
            for v1206 = 1, #v1204 do
                v1205 = (v1205 * 33 + string.byte(v1204, v1206)) % 65521;
            end;
            if v1205 == 272 and (not u1191 or u1191.Parent == nil) then
            else
                l__TweenService__3:Create(u1191.Main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.fromScale(0, -1)
                }):Play();
                l__TweenService__3:Create(u1191, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Size = UDim2.fromScale(1, 0)
                }):Play();
                game.Debris:AddItem(u1191, 0.5);
            end;
        end);
    end;
    local v1209 = l__Packets__7._xe671a0aa8a52fedd.OnClientEvent:Connect(function(p1208) --[[ Line: 2022 ]]
        -- upvalues: u1207 (copy)
        u1207(p1208);
    end);
    local v1211 = l__Packets__7._x3129728123d8b7b9.OnClientEvent:Connect(function(p1210) --[[ Line: 2026 ]]
        game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):DisplaySystemMessage(p1210);
    end);
    u1111._x6171401a9a320e87:Add(v1209);
    u1111._x6171401a9a320e87:Add(v1211);
    local l__KillstreakVisualizer__82 = l__Main__68.BottomCenter.KillstreakVisualizer;
    local u1212 = u4:_x99c2a19f9a3f5eff("killstreak");
    local l__Value__83 = u1212.Value;
    local u1213 = 0;
    local l___x9b074161e70581e8__84 = l__Classes__14._x9b074161e70581e8;
    local function u1217() --[[ Line: 2042 ]]
        -- upvalues: l__KillstreakVisualizer__82 (copy), l__TweenService__3 (ref), u2 (ref), u1212 (copy)
        local v1214 = Color3.fromRGB(255, 30, 30);
        local v1215 = l__KillstreakVisualizer__82.CircleFrame:Clone();
        l__KillstreakVisualizer__82.Counter.TextTransparency = 1;
        l__TweenService__3:Create(l__KillstreakVisualizer__82.Counter, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            TextTransparency = 0
        }):Play();
        l__KillstreakVisualizer__82.Elimination.ImageColor3 = v1214;
        l__KillstreakVisualizer__82.CircleFrame.UIStroke.Color = v1214;
        l__TweenService__3:Create(l__KillstreakVisualizer__82.CircleFrame.UIStroke, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Color = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__KillstreakVisualizer__82.Radial.ImageColor3 = v1214;
        l__KillstreakVisualizer__82.Flare.ImageColor3 = v1214;
        l__KillstreakVisualizer__82.Glow.ImageColor3 = v1214;
        l__TweenService__3:Create(l__KillstreakVisualizer__82.Glow, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__TweenService__3:Create(l__KillstreakVisualizer__82.Flare, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__TweenService__3:Create(l__KillstreakVisualizer__82.Radial, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
        v1215.Parent = l__KillstreakVisualizer__82.CircleFrame.Parent;
        v1215.UIStroke.Transparency = 0;
        v1215.UIStroke.Color = v1214;
        v1215.UIStroke.Thickness = 7;
        l__KillstreakVisualizer__82.Elimination.ImageTransparency = 0;
        l__KillstreakVisualizer__82.Elimination.Size = UDim2.fromScale(3, 3);
        l__TweenService__3:Create(l__KillstreakVisualizer__82.Elimination, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1.3, 1.3)
        }):Play();
        l__TweenService__3:Create(l__KillstreakVisualizer__82.Elimination, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
        l__TweenService__3:Create(v1215.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        local v1216 = u2:convNumRange(math.clamp(u1212.Value, 0, 15), 0, 20, 2, 6);
        l__TweenService__3:Create(v1215, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(v1216, v1216)
        }):Play();
        l__TweenService__3:Create(v1215.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Thickness = 0
        }):Play();
        game.Debris:AddItem(v1215, 1);
    end;
    local v1222 = u1212.Changed:Connect(function(p1218) --[[ Line: 2075 ]]
        -- upvalues: l__Value__83 (ref), u1217 (copy)
        local v1219 = tostring(game.GameId);
        local v1220 = 46;
        for v1221 = 1, #v1219 do
            v1220 = (v1220 * 33 + string.byte(v1219, v1221)) % 65521;
        end;
        if v1220 == 272 and l__Value__83 < p1218 then
            u1217();
        end;
        l__Value__83 = p1218;
    end);
    local function u1242() --[[ Line: 2082 ]]
        -- upvalues: u1212 (copy), u2 (ref), l__TweenService__3 (ref), l___x9b074161e70581e8__84 (copy), l__KillstreakVisualizer__82 (copy)
        local v1223 = tostring(game.GameId);
        local v1224 = 46;
        for v1225 = 1, #v1223 do
            v1224 = (v1224 * 33 + string.byte(v1223, v1225)) % 65521;
        end;
        if v1224 == 272 and u1212.Value == 0 then
        else
            local v1226 = u2:numLerp(1.1, 2, l__TweenService__3:GetValue(l___x9b074161e70581e8__84._x279b42a5502bb102, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
            local v1227 = l__KillstreakVisualizer__82.CircleFrame:Clone();
            v1227.Parent = l__KillstreakVisualizer__82.CircleFrame.Parent;
            local v1228 = tostring(game.GameId);
            local v1229 = 46;
            for v1230 = 1, #v1228 do
                v1229 = (v1229 * 33 + string.byte(v1228, v1230)) % 65521;
            end;
            if v1229 == 272 and u1212.Value >= 3 then
                local v1231 = u2:numLerp(0, 0.02, l__TweenService__3:GetValue(l___x9b074161e70581e8__84._x279b42a5502bb102, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                l__KillstreakVisualizer__82.Size = UDim2.fromScale(0.175 - v1231, 0.175 - v1231);
                l__TweenService__3:Create(l__KillstreakVisualizer__82, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.175, 0.175)
                }):Play();
            end;
            local v1232 = tostring(game.GameId);
            local v1233 = 46;
            for v1234 = 1, #v1232 do
                v1233 = (v1233 * 33 + string.byte(v1232, v1234)) % 65521;
            end;
            if v1233 == 272 and u1212.Value >= 3 then
                local v1235 = u2:numLerp(1, 0, l__TweenService__3:GetValue(l___x9b074161e70581e8__84._x279b42a5502bb102, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
                l__KillstreakVisualizer__82.Glow.ImageTransparency = v1235;
                l__TweenService__3:Create(l__KillstreakVisualizer__82.Glow, TweenInfo.new(0.2), {
                    ImageTransparency = 1
                }):Play();
            end;
            local v1236 = tostring(game.GameId);
            local v1237 = 46;
            for v1238 = 1, #v1236 do
                v1237 = (v1237 * 33 + string.byte(v1236, v1238)) % 65521;
            end;
            if v1237 == 272 and u1212.Value >= 5 then
                local v1239 = u2:numLerp(1, 0.2, l__TweenService__3:GetValue(l___x9b074161e70581e8__84._x279b42a5502bb102, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                l__KillstreakVisualizer__82.Flare.ImageTransparency = v1239;
                local v1240 = math.random(0, 360);
                l__KillstreakVisualizer__82.Flare.Rotation = v1240;
                local _ = math.random(0, 1) == 0;
                local v1241 = 10 * v1226;
                l__TweenService__3:Create(l__KillstreakVisualizer__82.Flare, TweenInfo.new(0.2), {
                    ImageTransparency = 1,
                    Rotation = v1240 + v1241
                }):Play();
            end;
            v1227.UIStroke.Transparency = 0.5;
            v1227.UIStroke.Thickness = 3;
            l__TweenService__3:Create(v1227, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v1226, v1226)
            }):Play();
            l__TweenService__3:Create(v1227.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Thickness = 0
            }):Play();
            l__TweenService__3:Create(v1227.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            game.Debris:AddItem(v1227, 1);
        end;
    end;
    local v1243 = l___x9b074161e70581e8__84._xcd7daa1c4cf4bd7d.onBeat:Connect(function() --[[ Line: 2120 ]]
        -- upvalues: u1242 (copy)
        u1242();
    end);
    local v1262 = l__RunService__1.RenderStepped:Connect(function(p1244) --[[ Line: 2124 ]]
        -- upvalues: l__KillstreakVisualizer__82 (copy), u1212 (copy), l___x9b074161e70581e8__84 (copy), u1213 (ref), u2 (ref), l__TweenService__3 (ref)
        local l__Radial__85 = l__KillstreakVisualizer__82.Radial;
        local l__Value__86 = u1212.Value;
        local v1245 = tostring(game.GameId);
        local v1246 = 46;
        for v1247 = 1, #v1245 do
            v1246 = (v1246 * 33 + string.byte(v1245, v1247)) % 65521;
        end;
        if v1246 == 272 and l__Value__86 > 0 then
            local v1248 = tostring(game.GameId);
            local v1249 = 46;
            for v1250 = 1, #v1248 do
                v1249 = (v1249 * 33 + string.byte(v1248, v1250)) % 65521;
            end;
            if v1249 == 272 and not (l___x9b074161e70581e8__84._xf558833e149ad49a or l___x9b074161e70581e8__84._xf558833e149ad49a[l___x9b074161e70581e8__84._x47a0874526b0e664]) then
            else
                local v1251 = tostring(game.GameId);
                local v1252 = 46;
                local v1253 = 1;
                for v1254 = 1, #v1251 do
                    v1252 = (v1252 * 33 + string.byte(v1251, v1254)) % 65521;
                end;
                local v1255 = v1252 == 272 and l__Value__86 % 2 == 0 and -1 or v1253;
                u1213 = u2:numLerp(0.3, 4, l__TweenService__3:GetValue(l___x9b074161e70581e8__84._x279b42a5502bb102, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
                l__Radial__85.Rotation = l__Radial__85.Rotation + p1244 * (u1213 * 60) * v1255;
                local v1256 = tostring(game.GameId);
                local v1257 = 46;
                for v1258 = 1, #v1256 do
                    v1257 = (v1257 * 33 + string.byte(v1256, v1258)) % 65521;
                end;
                if v1257 == 272 and l__Radial__85.Rotation > 360 then
                    l__Radial__85.Rotation = l__Radial__85.Rotation % 360;
                end;
                local v1259 = tostring(game.GameId);
                local v1260 = 46;
                for v1261 = 1, #v1259 do
                    v1260 = (v1260 * 33 + string.byte(v1259, v1261)) % 65521;
                end;
                if v1260 == 272 and l__Radial__85.Rotation < 0 then
                    l__Radial__85.Rotation = 360 + l__Radial__85.Rotation;
                end;
                l__KillstreakVisualizer__82.Visible = true;
                l__KillstreakVisualizer__82.Counter.Text = tostring(l__Value__86);
            end;
        else
            l__KillstreakVisualizer__82.Visible = false;
        end;
    end);
    u1111._x6171401a9a320e87:Add(v1262);
    u1111._x6171401a9a320e87:Add(v1243);
    u1111._x6171401a9a320e87:Add(v1222);
    local v1349 = u4:_x0b64af9146930e4b("onDamageTaken"):Connect(function(u1263) --[[ Line: 2162 ]]
        -- upvalues: u2 (ref), u1111 (copy), l__UIAssets__5 (ref), l__TweenService__3 (ref), u1112 (copy), l__RunService__1 (ref)
        local v1264 = tostring(game.GameId);
        local v1265 = 46;
        for v1266 = 1, #v1264 do
            v1265 = (v1265 * 33 + string.byte(v1264, v1266)) % 65521;
        end;
        if v1265 == 272 and (not u1263.attacker_identifier or u1263.damage <= 0) then
        else
            local u1267 = u2:getLikelyVec3(u1263.attacker_identifier);
            local v1268 = tostring(game.GameId);
            local v1269 = 46;
            for v1270 = 1, #v1268 do
                v1269 = (v1269 * 33 + string.byte(v1268, v1270)) % 65521;
            end;
            if v1269 == 272 and not u1267 then
            else
                local v1271 = u2:getBoundaryUDimFromPosition(workspace.CurrentCamera.CFrame, u1267);
                local v1272 = tostring(game.GameId);
                local v1273 = 46;
                local u1274 = nil;
                for v1275 = 1, #v1272 do
                    v1273 = (v1273 * 33 + string.byte(v1272, v1275)) % 65521;
                end;
                if v1273 == 272 and u1111._xa50cfa0804502bf6 == "Gradient" then
                    u1274 = l__UIAssets__5.DamageIndicator:Clone();
                    l__TweenService__3:Create(u1274.Gradient, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    l__TweenService__3:Create(u1274.Gradient.UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play();
                    l__TweenService__3:Create(u1274.Gradient, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1
                    }):Play();
                else
                    local v1276 = tostring(game.GameId);
                    local v1277 = 46;
                    for v1278 = 1, #v1276 do
                        v1277 = (v1277 * 33 + string.byte(v1276, v1278)) % 65521;
                    end;
                    if v1277 == 272 and u1111._xa50cfa0804502bf6 == "Blob" then
                        u1274 = l__UIAssets__5.DamageIndicatorBlob:Clone();
                        l__TweenService__3:Create(u1274.Outer, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(0, 0.75)
                        }):Play();
                        l__TweenService__3:Create(u1274.Outer, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        l__TweenService__3:Create(u1274.Inner, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        l__TweenService__3:Create(u1274.Inner, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                    else
                        warn("UNKNOWN DAMAGE INDICATOR TYPE : ", u1111._xa50cfa0804502bf6);
                    end;
                end;
                u1274.Position = v1271;
                local v1279 = UDim2.fromScale(0.5, 0.5);
                local l__ViewportSize__87 = workspace.CurrentCamera.ViewportSize;
                local v1280 = math.atan2((v1279.Y.Scale - v1271.Y.Scale) * l__ViewportSize__87.Y, (v1279.X.Scale - v1271.X.Scale) * l__ViewportSize__87.X);
                u1274.Rotation = math.deg(v1280) + 90;
                u1274.Parent = u1112.DamageFrame;
                local u1281 = nil;
                local u1282 = false;
                u1281 = l__RunService__1.RenderStepped:Connect(function() --[[ Line: 2222 ]]
                    -- upvalues: u1263 (copy), u1282 (ref), u1281 (ref), u1274 (ref), u1267 (ref), u2 (ref)
                    local v1283 = tostring(game.GameId);
                    local v1284 = 46;
                    for v1285 = 1, #v1283 do
                        v1284 = (v1284 * 33 + string.byte(v1283, v1285)) % 65521;
                    end;
                    if v1284 == 272 and not u1263.attacker_identifier then
                        local v1286 = tostring(game.GameId);
                        local v1287 = 46;
                        for v1288 = 1, #v1286 do
                            v1287 = (v1287 * 33 + string.byte(v1286, v1288)) % 65521;
                        end;
                        if v1287 == 272 and u1282 then
                        else
                            u1282 = true;
                            local v1289 = tostring(game.GameId);
                            local v1290 = 46;
                            for v1291 = 1, #v1289 do
                                v1290 = (v1290 * 33 + string.byte(v1289, v1291)) % 65521;
                            end;
                            if v1290 == 272 and u1281 then
                                u1281:Disconnect();
                                u1281 = nil;
                            end;
                            local v1292 = tostring(game.GameId);
                            local v1293 = 46;
                            for v1294 = 1, #v1292 do
                                v1293 = (v1293 * 33 + string.byte(v1292, v1294)) % 65521;
                            end;
                            if v1293 == 272 and u1274 then
                                u1274:Destroy();
                            end;
                        end;
                    else
                        local v1295 = tostring(game.GameId);
                        local v1296 = 46;
                        for v1297 = 1, #v1295 do
                            v1296 = (v1296 * 33 + string.byte(v1295, v1297)) % 65521;
                        end;
                        if v1296 == 272 and u1263.attacker_identifier.Parent ~= workspace.Entities then
                            local v1298 = tostring(game.GameId);
                            local v1299 = 46;
                            for v1300 = 1, #v1298 do
                                v1299 = (v1299 * 33 + string.byte(v1298, v1300)) % 65521;
                            end;
                            if v1299 == 272 and u1282 then
                            else
                                u1282 = true;
                                local v1301 = tostring(game.GameId);
                                local v1302 = 46;
                                for v1303 = 1, #v1301 do
                                    v1302 = (v1302 * 33 + string.byte(v1301, v1303)) % 65521;
                                end;
                                if v1302 == 272 and u1281 then
                                    u1281:Disconnect();
                                    u1281 = nil;
                                end;
                                local v1304 = tostring(game.GameId);
                                local v1305 = 46;
                                for v1306 = 1, #v1304 do
                                    v1305 = (v1305 * 33 + string.byte(v1304, v1306)) % 65521;
                                end;
                                if v1305 == 272 and u1274 then
                                    u1274:Destroy();
                                end;
                            end;
                        else
                            local v1307 = tostring(game.GameId);
                            local v1308 = 46;
                            for v1309 = 1, #v1307 do
                                v1308 = (v1308 * 33 + string.byte(v1307, v1309)) % 65521;
                            end;
                            if v1308 == 272 and not u1274 then
                                local v1310 = tostring(game.GameId);
                                local v1311 = 46;
                                for v1312 = 1, #v1310 do
                                    v1311 = (v1311 * 33 + string.byte(v1310, v1312)) % 65521;
                                end;
                                if v1311 == 272 and u1282 then
                                else
                                    u1282 = true;
                                    local v1313 = tostring(game.GameId);
                                    local v1314 = 46;
                                    for v1315 = 1, #v1313 do
                                        v1314 = (v1314 * 33 + string.byte(v1313, v1315)) % 65521;
                                    end;
                                    if v1314 == 272 and u1281 then
                                        u1281:Disconnect();
                                        u1281 = nil;
                                    end;
                                    local v1316 = tostring(game.GameId);
                                    local v1317 = 46;
                                    for v1318 = 1, #v1316 do
                                        v1317 = (v1317 * 33 + string.byte(v1316, v1318)) % 65521;
                                    end;
                                    if v1317 == 272 and u1274 then
                                        u1274:Destroy();
                                    end;
                                end;
                            else
                                u1267 = u2:getLikelyVec3(u1263.attacker_identifier);
                                local v1319 = tostring(game.GameId);
                                local v1320 = 46;
                                for v1321 = 1, #v1319 do
                                    v1320 = (v1320 * 33 + string.byte(v1319, v1321)) % 65521;
                                end;
                                if v1320 == 272 and not u1267 then
                                    local v1322 = tostring(game.GameId);
                                    local v1323 = 46;
                                    for v1324 = 1, #v1322 do
                                        v1323 = (v1323 * 33 + string.byte(v1322, v1324)) % 65521;
                                    end;
                                    if v1323 == 272 and u1282 then
                                    else
                                        u1282 = true;
                                        local v1325 = tostring(game.GameId);
                                        local v1326 = 46;
                                        for v1327 = 1, #v1325 do
                                            v1326 = (v1326 * 33 + string.byte(v1325, v1327)) % 65521;
                                        end;
                                        if v1326 == 272 and u1281 then
                                            u1281:Disconnect();
                                            u1281 = nil;
                                        end;
                                        local v1328 = tostring(game.GameId);
                                        local v1329 = 46;
                                        for v1330 = 1, #v1328 do
                                            v1329 = (v1329 * 33 + string.byte(v1328, v1330)) % 65521;
                                        end;
                                        if v1329 == 272 and u1274 then
                                            u1274:Destroy();
                                        end;
                                    end;
                                else
                                    local l__ViewportSize__88 = workspace.CurrentCamera.ViewportSize;
                                    local v1331 = l__ViewportSize__88.Y / l__ViewportSize__88.X;
                                    local v1332 = u2:getBoundaryUDimFromPosition(workspace.CurrentCamera.CFrame, u1267);
                                    local l__Scale__89 = v1332.X.Scale;
                                    local v1333 = tostring(game.GameId);
                                    local v1334 = 46;
                                    for v1335 = 1, #v1333 do
                                        v1334 = (v1334 * 33 + string.byte(v1333, v1335)) % 65521;
                                    end;
                                    local v1336;
                                    if v1334 == 272 and l__Scale__89 < 0.5 then
                                        v1336 = u2:convNumRange(l__Scale__89, 0, 0.5, 1, v1331);
                                    else
                                        v1336 = u2:convNumRange(l__Scale__89, 0.5, 1, v1331, 1);
                                    end;
                                    u1274.Size = UDim2.fromScale(0.7 * v1336, 0.7 * v1336);
                                    u1274.Position = v1332;
                                    local v1337 = u1274;
                                    local v1338 = UDim2.fromScale(0.5, 0.5);
                                    local l__ViewportSize__90 = workspace.CurrentCamera.ViewportSize;
                                    local v1339 = math.atan2((v1338.Y.Scale - v1332.Y.Scale) * l__ViewportSize__90.Y, (v1338.X.Scale - v1332.X.Scale) * l__ViewportSize__90.X);
                                    v1337.Rotation = math.deg(v1339) + 90;
                                end;
                            end;
                        end;
                    end;
                end);
                game.Debris:AddItem(u1274, 0.8);
                task.delay(0.8, function() --[[ Line: 2245 ]]
                    -- upvalues: u1282 (ref), u1281 (ref), u1274 (ref)
                    local v1340 = tostring(game.GameId);
                    local v1341 = 46;
                    for v1342 = 1, #v1340 do
                        v1341 = (v1341 * 33 + string.byte(v1340, v1342)) % 65521;
                    end;
                    if v1341 == 272 and u1282 then
                    else
                        u1282 = true;
                        local v1343 = tostring(game.GameId);
                        local v1344 = 46;
                        for v1345 = 1, #v1343 do
                            v1344 = (v1344 * 33 + string.byte(v1343, v1345)) % 65521;
                        end;
                        if v1344 == 272 and u1281 then
                            u1281:Disconnect();
                            u1281 = nil;
                        end;
                        local v1346 = tostring(game.GameId);
                        local v1347 = 46;
                        for v1348 = 1, #v1346 do
                            v1347 = (v1347 * 33 + string.byte(v1346, v1348)) % 65521;
                        end;
                        if v1347 == 272 and u1274 then
                            u1274:Destroy();
                        end;
                    end;
                end);
                u1111._x6171401a9a320e87:Add(u1274);
                u1111._x6171401a9a320e87:Add(u1281);
            end;
        end;
    end);
    u1111._x6171401a9a320e87:Add(v1349);
    local u1350 = 0;
    local function u1365() --[[ Line: 2260 ]]
        -- upvalues: l__Main__68 (copy), u4 (ref), u1350 (ref), l__TweenService__3 (ref), u1112 (copy), u2 (ref)
        local l__HealthContainer__91 = l__Main__68.BottomCenter.HealthContainer;
        local l__HealthProgress__92 = l__HealthContainer__91.HealthMain.Bar.Max.HealthProgress;
        local l__Value__93 = u4:_x99c2a19f9a3f5eff("health").Value;
        local l__Value__94 = u4:_x99c2a19f9a3f5eff("health_max").Value;
        local v1351 = u1350 - l__Value__93;
        u1350 = l__Value__93;
        local v1352 = math.map(l__Value__93, 0, l__Value__94, 0, 1);
        l__HealthProgress__92.Size = UDim2.fromScale(v1352, 1);
        l__HealthProgress__92.TextLabel.Text = tostring(l__Value__93);
        local function v1353(_) --[[ Line: 2272 ]]
            -- upvalues: l__HealthProgress__92 (copy), l__TweenService__3 (ref)
            l__HealthProgress__92.BackgroundColor3 = Color3.fromRGB(0, 255, 0);
            l__TweenService__3:Create(l__HealthProgress__92, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end;
        local function v1356(p1354) --[[ Line: 2277 ]]
            -- upvalues: l__HealthContainer__91 (copy), l__Value__94 (copy), l__TweenService__3 (ref), l__HealthProgress__92 (copy)
            local l__DamagedFrame__95 = l__HealthContainer__91.HealthMain.Bar.Max.DamagedFrame;
            local l__GradientFrame__96 = l__DamagedFrame__95.GradientFrame;
            local v1355 = math.map(p1354, 0, l__Value__94, 0, 1);
            l__DamagedFrame__95.Size = UDim2.fromScale(v1355, 1);
            l__GradientFrame__96.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__DamagedFrame__95, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 1)
            }):Play();
            l__TweenService__3:Create(l__GradientFrame__96, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__HealthProgress__92.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            l__TweenService__3:Create(l__HealthProgress__92, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end;
        local l__BotGradient__97 = u1112.BotGradient;
        local v1357 = Color3.fromRGB(255, 0, 0);
        local v1358 = Color3.fromRGB(0, 0, 0):Lerp(v1357, l__TweenService__3:GetValue(u2:convNumRange(l__Value__93, l__Value__94 * 0.4, l__Value__94, 1, 0), Enum.EasingStyle.Exponential, Enum.EasingDirection.In));
        l__TweenService__3:Create(l__BotGradient__97, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageColor3 = v1358
        }):Play();
        local v1359 = tostring(game.GameId);
        local v1360 = 46;
        for v1361 = 1, #v1359 do
            v1360 = (v1360 * 33 + string.byte(v1359, v1361)) % 65521;
        end;
        if v1360 == 272 and v1351 > 0 then
            v1356(v1351);
        else
            local v1362 = tostring(game.GameId);
            local v1363 = 46;
            for v1364 = 1, #v1362 do
                v1363 = (v1363 * 33 + string.byte(v1362, v1364)) % 65521;
            end;
            if v1363 == 272 and v1351 < 0 then
                v1353(v1351);
            end;
        end;
    end;
    u1365();
    local v1366 = u4:_x99c2a19f9a3f5eff("health").Changed:Connect(function() --[[ Line: 2307 ]]
        -- upvalues: u1365 (copy)
        u1365();
    end);
    local v1371 = l__Classes__14._x9b074161e70581e8._xcd7daa1c4cf4bd7d.onBeat:Connect(function() --[[ Line: 2311 ]]
        -- upvalues: u4 (ref), u1112 (copy), l__TweenService__3 (ref)
        local l__Value__98 = u4:_x99c2a19f9a3f5eff("health_max").Value;
        local l__Value__99 = u4:_x99c2a19f9a3f5eff("health").Value;
        local v1367 = l__Value__98 * 0.4;
        local l__LowHPGradient__100 = u1112.LowHPGradient;
        local v1368 = tostring(game.GameId);
        local v1369 = 46;
        for v1370 = 1, #v1368 do
            v1369 = (v1369 * 33 + string.byte(v1368, v1370)) % 65521;
        end;
        if v1369 == 272 and v1367 <= l__Value__99 then
            l__LowHPGradient__100.Visible = false;
        else
            l__LowHPGradient__100.Visible = true;
            l__LowHPGradient__100.Size = UDim2.fromScale(1, 0.5);
            l__LowHPGradient__100.ImageTransparency = 0;
            l__TweenService__3:Create(l__LowHPGradient__100, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 1,
                Size = UDim2.fromScale(1, 0)
            }):Play();
        end;
    end);
    u1111._x6171401a9a320e87:Add(v1366);
    u1111._x6171401a9a320e87:Add(v1371);
    local l__StaminaContainer__101 = l__Main__68.BottomLeft.StaminaContainer;
    for u1372 = 1, l__Classes__14.Config._x4cbacf74134e79b4 do
        local u1373 = l__UIAssets__5.HUDAssets.StaminaGauge:Clone();
        local u1374 = false;
        u1373.Parent = l__Main__68.BottomLeft.StaminaContainer.StaminaArray;
        local function u1375() --[[ Line: 2337 ]]
            -- upvalues: u1373 (copy), l__TweenService__3 (ref)
            local l__FillFlash__102 = u1373.FillFlash;
            l__FillFlash__102.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__FillFlash__102, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            u1373.Fill.BackgroundTransparency = 0;
        end;
        local function u1376() --[[ Line: 2345 ]]
            -- upvalues: u1373 (copy), l__TweenService__3 (ref), l__StaminaContainer__101 (copy)
            local l__UseFlash__103 = u1373.UseFlash;
            l__UseFlash__103.BackgroundTransparency = 0;
            l__TweenService__3:Create(l__UseFlash__103, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            u1373.Fill.BackgroundTransparency = 0.5;
            local l__Enders__104 = l__StaminaContainer__101.Enders;
            l__Enders__104.Size = UDim2.fromScale(1.15, 0.1);
            l__TweenService__3:Create(l__Enders__104, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, 0.1)
            }):Play();
        end;
        local v1388 = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 2355 ]]
            -- upvalues: u3 (ref), u1372 (copy), u1373 (copy), u1374 (ref), u1375 (copy), u1376 (copy)
            local l___x1ba439069c6b2196__105 = u3._x1ba439069c6b2196;
            local l___xa65e11f304617618__106 = u3._xa65e11f304617618;
            local v1377 = math.clamp(l___x1ba439069c6b2196__105 - u1372 + 1, 0, 1);
            u1373.Fill.Size = UDim2.fromScale(v1377, 1);
            local v1378 = u1372 <= l___xa65e11f304617618__106;
            local v1379 = tostring(game.GameId);
            local v1380 = 46;
            for v1381 = 1, #v1379 do
                v1380 = (v1380 * 33 + string.byte(v1379, v1381)) % 65521;
            end;
            if v1380 == 272 and v1378 then
                local v1382 = tostring(game.GameId);
                local v1383 = 46;
                for v1384 = 1, #v1382 do
                    v1383 = (v1383 * 33 + string.byte(v1382, v1384)) % 65521;
                end;
                if v1383 == 272 and not u1374 then
                    u1374 = true;
                    u1375();
                end;
            else
                local v1385 = tostring(game.GameId);
                local v1386 = 46;
                for v1387 = 1, #v1385 do
                    v1386 = (v1386 * 33 + string.byte(v1385, v1387)) % 65521;
                end;
                if v1386 == 272 and u1374 then
                    u1374 = false;
                    u1376();
                end;
                u1373.Fill.BackgroundTransparency = 0.5;
            end;
        end);
        u1111._x6171401a9a320e87:Add(v1388);
    end;
    local l__CircularImageFill__107 = l__Main__68.BottomLeft.AugmentContainer.AugmentHolder.CircularImageFill;
    local v1398 = l__CircularImageFill__107.Progress.Changed:Connect(function(p1389) --[[ Line: 2385 ]]
        -- upvalues: l__Classes__14 (ref), l__Main__68 (copy), l__CircularImageFill__107 (copy)
        local l__KeyCode__108 = l__Classes__14._xd2c44c643b0c3fb4:_xdf0c107e49196810("AUGMENT").KeyCode;
        l__Main__68.BottomLeft.AugmentContainer.AugmentHolder.AugmentKey.KeyText.Text = l__Classes__14._xd2c44c643b0c3fb4:_x9116adad2412e188(l__KeyCode__108);
        local v1390 = math.map(p1389, 0, 1, 0, 360);
        local l__UIGradient__109 = l__CircularImageFill__107.RightClip.Right.UIGradient;
        local l__UIGradient__110 = l__CircularImageFill__107.LeftClip.Left.UIGradient;
        local v1391 = tostring(game.GameId);
        local v1392 = 46;
        for v1393 = 1, #v1391 do
            v1392 = (v1392 * 33 + string.byte(v1391, v1393)) % 65521;
        end;
        if v1392 == 272 and v1390 == 360 then
            l__UIGradient__110.Rotation = 180;
            l__UIGradient__109.Rotation = 180;
        else
            local v1394 = math.fmod(v1390, 360);
            local v1395 = tostring(game.GameId);
            local v1396 = 46;
            for v1397 = 1, #v1395 do
                v1396 = (v1396 * 33 + string.byte(v1395, v1397)) % 65521;
            end;
            if v1396 == 272 and (v1394 < 180 and v1394 > -180) then
                l__UIGradient__109.Rotation = v1394;
                l__UIGradient__110.Rotation = 0;
            else
                l__UIGradient__109.Rotation = 180;
                l__UIGradient__110.Rotation = v1394 - 180;
            end;
        end;
    end);
    u1111._x6171401a9a320e87:Add(v1398);
    local l__ImpactHolder__111 = l__Main__68.TopCenter.ImpactHolder;
    local l__ImpactContainer__112 = l__ImpactHolder__111.ImpactContainer;
    local l__ImpactFill__113 = l__ImpactContainer__112.ImpactMain.Bar.Max.ImpactFill;
    local l__ImpactFlash__114 = l__ImpactContainer__112.ImpactMain.Bar.Max.ImpactFlash;
    local u1399 = u4:_x99c2a19f9a3f5eff("impact");
    local u1400 = u4:_x99c2a19f9a3f5eff("impact_limit");
    local u1401 = 0;
    local v1406 = l__Packets__7.unreliablePackets._x7ad20ae11b77256d.OnClientEvent:Connect(function(p1402) --[[ Line: 2425 ]]
        -- upvalues: l__ImpactContainer__112 (copy), u1401 (ref), l__TweenService__3 (ref)
        local v1403 = tostring(game.GameId);
        local v1404 = 46;
        for v1405 = 1, #v1403 do
            v1404 = (v1404 * 33 + string.byte(v1403, v1405)) % 65521;
        end;
        if v1404 == 272 and not p1402 then
            local l__FilledFlash__115 = l__ImpactContainer__112.ImpactStroke.FilledFlash;
            u1401 = 0;
            l__FilledFlash__115.BackgroundTransparency = 0;
            l__FilledFlash__115.Size = UDim2.fromScale(1, 4);
            l__TweenService__3:Create(l__FilledFlash__115, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            }):Play();
            l__TweenService__3:Create(l__FilledFlash__115, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 4)
            }):Play();
        end;
    end);
    local v1423 = l__RunService__1.RenderStepped:Connect(function() --[[ Line: 2437 ]]
        -- upvalues: u1399 (copy), u1400 (copy), u4 (ref), l__ImpactHolder__111 (copy), l__ImpactFill__113 (copy), l__ImpactContainer__112 (copy), u2 (ref), l__Promise__9 (ref), u1401 (ref), l__ImpactFlash__114 (copy)
        local l__Value__116 = u1399.Value;
        local l__Value__117 = u1400.Value;
        local v1407 = tostring(game.GameId);
        local v1408 = 46;
        for v1409 = 1, #v1407 do
            v1408 = (v1408 * 33 + string.byte(v1407, v1409)) % 65521;
        end;
        if v1408 == 272 and u4._x730775c5207957d3.is_breaking then
            l__ImpactHolder__111.Visible = true;
            local v1410 = math.map(u4._x730775c5207957d3.break_duration, 0, u4._x730775c5207957d3.initial_duration, 0, 1);
            l__ImpactFill__113.Size = UDim2.fromScale(v1410, 1);
            l__ImpactFill__113.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            l__ImpactHolder__111.BreakingSubtext.Visible = true;
            l__ImpactContainer__112.ImpactStroke.UIStroke.Color = Color3.fromRGB(255, 0, 0);
            l__ImpactHolder__111.ImpactText.Text = "!! DISABLED !!";
            l__ImpactFill__113.Parent.ImpactFlash.Visible = false;
        else
            local v1411 = tostring(game.GameId);
            local v1412 = 46;
            for v1413 = 1, #v1411 do
                v1412 = (v1412 * 33 + string.byte(v1411, v1413)) % 65521;
            end;
            if v1412 == 272 and l__Value__116 > 0 then
                l__ImpactHolder__111.ImpactText.Text = "[ INSTABILITY ]";
                l__ImpactFill__113.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                l__ImpactContainer__112.ImpactStroke.UIStroke.Color = Color3.fromRGB(255, 255, 255);
                l__ImpactHolder__111.BreakingSubtext.Visible = false;
                l__ImpactHolder__111.Visible = true;
                l__ImpactFill__113.Parent.ImpactFlash.Visible = true;
                local v1414 = math.map(l__Value__116, 0, l__Value__117, 0, 1);
                local u1415 = u2:numLerp(l__ImpactFill__113.Size.X.Scale, v1414, 0.1);
                l__ImpactFill__113.Size = UDim2.fromScale(u1415, 1);
                l__Promise__9.delay(0.07):andThen(function() --[[ Line: 2468 ]]
                    -- upvalues: u1401 (ref), u1415 (copy)
                    u1401 = u1415;
                end);
                l__ImpactFlash__114.Position = UDim2.fromScale(u1415, 0.5);
                local v1416 = math.abs(u1415 - u1401);
                local v1417 = tostring(game.GameId);
                local v1418 = 46;
                for v1419 = 1, #v1417 do
                    v1418 = (v1418 * 33 + string.byte(v1417, v1419)) % 65521;
                end;
                local v1420;
                if v1418 == 272 and v1416 == 0 then
                    v1420 = 0;
                else
                    local v1421 = math.sign(v1416);
                    local v1422 = math.abs(v1416);
                    v1420 = v1421 * math.max(v1422, 0.007);
                end;
                l__ImpactFlash__114.Size = UDim2.fromScale(v1420, 7 + math.random(-2, 2));
                l__ImpactFlash__114.BackgroundTransparency = 0.2 + math.random(-0.1, 0.1);
            else
                l__ImpactHolder__111.Visible = false;
                l__ImpactFill__113.Size = UDim2.fromScale(0, 1);
                u1401 = 0;
            end;
        end;
    end);
    u1111._x6171401a9a320e87:Add(v1423);
    u1111._x6171401a9a320e87:Add(v1406);
    u1112.Parent = u1111._x0b50f415660624d5;
    local v1424 = tostring(game.GameId);
    local v1425 = 46;
    for v1426 = 1, #v1424 do
        v1425 = (v1425 * 33 + string.byte(v1424, v1426)) % 65521;
    end;
    if v1425 == 272 and l__Classes__14._xce372113b7898ad8 then
        l__Classes__14._xce372113b7898ad8:_x3e733224b50f021e();
    end;
end;
function u5._xd8041402b83e75db(u1427) --[[ Line: 2499 ]]
    -- upvalues: u1 (ref), l__Classes__14 (copy), u2 (ref), u3 (ref), u4 (ref), l__RunService__1 (copy)
    task.defer(function() --[[ Line: 2500 ]]
        -- upvalues: u1 (ref), l__Classes__14 (ref), u2 (ref), u3 (ref), u4 (ref), u1427 (copy), l__RunService__1 (ref)
        u1 = l__Classes__14._x2b1f81c73714b323;
        u2 = l__Classes__14.Util;
        u3 = l__Classes__14._xef0ffbcc2c92f7b4;
        u4 = l__Classes__14._x596eb619070480ba;
        u1427._x0b50f415660624d5.Parent = u3._x27372aa3ce026ec9.PlayerGui;
        u1427:_xded2ac1adcab8072();
        table.insert(u1427._xc253534558c9af17, l__RunService__1.RenderStepped:Connect(function(p1428) --[[ Line: 2508 ]]
            -- upvalues: u1427 (ref)
            u1427:_x4ba74b351b6e79d6(p1428);
        end));
    end);
end;
return u5;
