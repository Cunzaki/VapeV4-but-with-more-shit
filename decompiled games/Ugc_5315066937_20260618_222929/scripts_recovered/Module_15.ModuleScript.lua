-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = type;
local l__sub__1 = string.sub;
local l__find__2 = string.find;
local l__lower__3 = string.lower;
local l__gmatch__4 = string.gmatch;
local l__obtain__5 = _G.obtain;
local l__band__6 = bit32.band;
local l__Enumify__7 = l__obtain__5("Enums").Enumify;
local u3 = l__obtain__5("GetNameColour");
local l__Players__8 = game:GetService("Players");
local l__GetPlayers__9 = l__Players__8.GetPlayers;
local u4 = { ":" };
local u5 = {
    black = {
        r = 0,
        g = 0,
        b = 0,
        a = 255
    },
    maroon = {
        r = 128,
        g = 0,
        b = 0,
        a = 255
    },
    red = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    green = {
        r = 0,
        g = 128,
        b = 0,
        a = 255
    },
    olive = {
        r = 128,
        g = 128,
        b = 0,
        a = 255
    },
    orange = {
        r = 255,
        g = 128,
        b = 0,
        a = 255
    },
    lime = {
        r = 0,
        g = 255,
        b = 0,
        a = 255
    },
    chartreuse = {
        r = 128,
        g = 255,
        b = 0,
        a = 255
    },
    yellow = {
        r = 255,
        g = 255,
        b = 0,
        a = 255
    },
    navy = {
        r = 0,
        g = 0,
        b = 128,
        a = 255
    },
    royal = {
        r = 128,
        g = 0,
        b = 128,
        a = 255
    },
    pink = {
        r = 255,
        g = 20,
        b = 147,
        a = 255
    },
    teal = {
        r = 0,
        g = 128,
        b = 128,
        a = 255
    },
    grey = {
        r = 128,
        g = 128,
        b = 128,
        a = 255
    },
    gray = {
        r = 128,
        g = 128,
        b = 128,
        a = 255
    },
    salmon = {
        r = 255,
        g = 128,
        b = 128,
        a = 255
    },
    springgreen = {
        r = 0,
        g = 255,
        b = 128,
        a = 255
    },
    lightgreen = {
        r = 128,
        g = 255,
        b = 128,
        a = 255
    },
    khaki = {
        r = 255,
        g = 255,
        b = 128,
        a = 255
    },
    blue = {
        r = 0,
        g = 0,
        b = 255,
        a = 255
    },
    purple = {
        r = 148,
        g = 0,
        b = 211,
        a = 255
    },
    magenta = {
        r = 255,
        g = 0,
        b = 255,
        a = 255
    },
    dodger = {
        r = 0,
        g = 128,
        b = 255,
        a = 255
    },
    malibu = {
        r = 128,
        g = 128,
        b = 255,
        a = 255
    },
    violet = {
        r = 255,
        g = 128,
        b = 255,
        a = 255
    },
    cyan = {
        r = 0,
        g = 255,
        b = 255,
        a = 255
    },
    aqua = {
        r = 0,
        g = 255,
        b = 255,
        a = 255
    },
    electric = {
        r = 128,
        g = 255,
        b = 255,
        a = 255
    },
    white = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    silver = {
        r = 192,
        g = 192,
        b = 192,
        a = 255
    },
    admin = {
        r = 255,
        g = 215,
        b = 0,
        a = 255
    },
    brown = {
        r = 139,
        g = 69,
        b = 19,
        a = 255
    },
    red100 = {
        r = 253,
        g = 29,
        b = 36,
        a = 255
    }
};
local u6 = {
    ["100"] = { 404271559, 2000, 1759 },
    angry = { 401984295, 2164, 442 },
    angryflip = { 401984363, 3810, 431 },
    bear = { 401984498, 937, 312 },
    box = { 401984542, 311, 309 },
    chbx = { 401984587, 357, 310 },
    chill = { 401984625, 2895, 434 },
    cry = { 401984749, 1733, 434 },
    cute = { 407689215, 1747, 394 },
    dong = { 401984849, 1575, 489 },
    dunno = { 401984935, 1879, 435 },
    flip = { 401985003, 3777, 419 },
    garry = { 401985062, 1178, 469 },
    heart = { 401985171, 368, 313 },
    heha = { 1207583893, 125, 128 },
    kappa = { 419473958, 312, 419 },
    lenny = { 401978485, 1136, 414 },
    perfect = { 419473414, 1645, 492 },
    praise = { 401985294, 2280, 433 },
    salt = { 408191159, 1058, 876 },
    scissors = { 401985345, 2250, 425 },
    sniper = { 401985394, 2240, 504 },
    spider = { 401985458, 1946, 446 },
    srs = { 401985552, 801, 418 },
    strong = { 401985659, 1751, 394 },
    unnamed = { 401985833, 2177, 449 },
    wand = { 401986285, 4073, 424 },
    euler = { 516991452, 461, 602 },
    gauss = { 516991693, 576, 738 }
};
local u7 = {};
local u8 = {};
local function v15(p9, p10, p11, p12, p13) --[[ Line: 113 ]]
    -- upvalues: u8 (copy)
    local v14 = u8[p9];
    if v14 then
        v14[#v14 + 1] = {
            ClassName = p10,
            ArgumentTypes = p11,
            Function = p12,
            Permissions = p13
        };
    else
        u8[p9] = {
            {
                ClassName = p10,
                ArgumentTypes = p11,
                Function = p12,
                Permissions = p13
            }
        };
    end;
end;
local function u49(p16, p17, p18, p19, p20) --[[ Line: 121 ]]
    -- upvalues: u7 (copy), u49 (copy), u4 (copy), l__find__2 (copy), l__sub__1 (copy)
    local v21 = #p17;
    local v22 = #p20 + 1;
    local v23 = p19[v22];
    local v24 = u7[v23];
    if not v24 then
        print("Invalid type \'" .. tostring(v23) .. "\'");
        return;
    end;
    local l__InputConsumption__10 = v24.InputConsumption;
    if l__InputConsumption__10 == "None" then
        local v25 = v24.Interpreter(p16, nil, p18);
        if v25 ~= nil then
            local v26 = {};
            for v27 = 1, #p20 do
                v26[v27] = p20[v27];
            end;
            v26[v22] = v25;
            if v22 == #p19 then
                if v21 == 0 then
                    return v26;
                end;
            else
                local v28 = v22 < #p19 and u49(p16, p17, p18, p19, v26);
                if v28 then
                    return v28;
                end;
            end;
        end;
    elseif l__InputConsumption__10 == "Any" then
        local v29 = {};
        for v30 = 1, #u4 do
            local v31 = u4[v30];
            local v32 = 1;
            while v32 <= v21 do
                local v33, v34 = l__find__2(p17, v31, v32, true);
                if not (v33 and v34) then
                    break;
                end;
                local v35, v36 = l__find__2(p17, "%b<>", v32);
                if v35 and (v36 and (v34 >= v35 and v36 >= v33)) then
                    v32 = v36 + 1;
                else
                    v29[#v29 + 1] = { v33, v34 };
                    v32 = v34 + 1;
                end;
            end;
        end;
        v29[#v29 + 1] = { v21 + 1, v21 };
        if #v29 < 1000 then
            local l__Interpreter__11 = v24.Interpreter;
            for v37 = 1, #v29 do
                local v38 = v29[v37];
                local v39 = l__sub__1(p17, 1, v38[1] - 1);
                local v40 = l__sub__1(p17, v38[2] + 1);
                local v41 = l__Interpreter__11(p16, v39, p18);
                if v41 ~= nil then
                    local v42 = {};
                    for v43 = 1, #p20 do
                        v42[v43] = p20[v43];
                    end;
                    v42[v22] = v41;
                    if v22 == #p19 then
                        if #v40 == 0 then
                            return v42;
                        end;
                    elseif v22 < #p19 then
                        local v44 = u49(p16, v40, p18, p19, v42);
                        if v44 then
                            return v44;
                        end;
                    end;
                end;
            end;
        end;
    elseif l__InputConsumption__10 == "All" then
        local v45 = v24.Interpreter(p16, p17, p18);
        if v45 ~= nil then
            local v46 = {};
            for v47 = 1, #p20 do
                v46[v47] = p20[v47];
            end;
            v46[v22] = v45;
            if v22 == #p19 then
                return v46;
            end;
            local v48 = v22 < #p19 and u49(p16, "", p18, p19, v46);
            if v48 then
                return v48;
            end;
        end;
    end;
end;
local function u73(p50, p51, p52) --[[ Line: 234 ]]
    -- upvalues: u1 (copy), u8 (copy), l__sub__1 (copy), l__band__6 (copy), u7 (copy), u4 (copy), u49 (copy)
    for v53, v54 in u1, u8 do
        if l__sub__1(p51, 1, #v53) == v53 then
            local v55 = l__sub__1(p51, #v53 + 1);
            for v56 = 1, #v54 do
                local v57 = v54[v56];
                local l__Permissions__12 = v57.Permissions;
                if not l__Permissions__12 or l__band__6(p52, l__Permissions__12) == l__Permissions__12 then
                    local l__ArgumentTypes__13 = v57.ArgumentTypes;
                    local v58 = {};
                    local v59 = true;
                    for v60 = 1, #l__ArgumentTypes__13 do
                        local v61 = u7[l__ArgumentTypes__13[v60]];
                        if not v61 then
                            v59 = false;
                            break;
                        end;
                        if v61.InputConsumption ~= "None" then
                            break;
                        end;
                        v58[v60] = v61.Interpreter(p50, nil, p52);
                    end;
                    if v59 then
                        if #l__ArgumentTypes__13 > #v58 then
                            for v62 = 1, #u4 do
                                local v63 = u4[v62];
                                if l__sub__1(v55, 1, #v63) == v63 then
                                    local v64 = u49(p50, l__sub__1(v55, #v63 + 1), p52, l__ArgumentTypes__13, v58);
                                    if v64 then
                                        return { v57.ClassName, v57.Function(unpack(v64)) };
                                    end;
                                end;
                            end;
                        elseif #v55 == 0 then
                            return { v57.ClassName, v57.Function(unpack(v58)) };
                        end;
                    end;
                end;
            end;
        end;
    end;
    local v65 = u8[""];
    if v65 then
        for v66 = 1, #v65 do
            local v67 = v65[v66];
            local l__Permissions__14 = v67.Permissions;
            if not l__Permissions__14 or l__band__6(p52, l__Permissions__14) == l__Permissions__14 then
                local l__ArgumentTypes__15 = v67.ArgumentTypes;
                local v68 = {};
                local v69 = true;
                for v70 = 1, #l__ArgumentTypes__15 do
                    local v71 = u7[l__ArgumentTypes__15[v70]];
                    if not v71 then
                        v69 = false;
                        break;
                    end;
                    if v71.InputConsumption ~= "None" then
                        break;
                    end;
                    v68[v70] = v71.Interpreter(p50, nil, p52);
                end;
                if v69 then
                    if #l__ArgumentTypes__15 > #v68 then
                        local v72 = u49(p50, p51, p52, l__ArgumentTypes__15, v68);
                        if v72 then
                            return { v67.ClassName, v67.Function(unpack(v72)) };
                        end;
                    elseif #p51 == 0 then
                        return { v67.ClassName, v67.Function(unpack(v68)) };
                    end;
                end;
            end;
        end;
    end;
end;
local function u85(p74, p75, p76) --[[ Line: 325 ]]
    -- upvalues: l__gmatch__4 (copy), l__sub__1 (copy), u73 (copy)
    local v77 = 1;
    local v78 = 1;
    local v79 = { "List" };
    local v80 = false;
    for v81, v82, v83 in l__gmatch__4(p75, "()(%b<>)()") do
        if v77 < v81 then
            v78 = v78 + 1;
            v79[v78] = { "Text", (l__sub__1(p75, v77, v81 - 1)) };
        end;
        v78 = v78 + 1;
        local v84 = u73(p74, l__sub__1(v82, 2, -2), p76);
        if v84 then
            v79[v78] = v84;
            v80 = true;
        else
            v79[v78] = { "Text", v82 };
        end;
        v77 = v83;
    end;
    if v77 <= #p75 then
        v79[v78 + 1] = { "Text", (l__sub__1(p75, v77)) };
    end;
    if #v79 > 1 then
        return v79, v80;
    end;
end;
local function u90(p86, p87, p88) --[[ Line: 354 ]]
    -- upvalues: u2 (copy), u90 (copy)
    if u2(p86) == "table" then
        if p86[1] == p87 then
            p88[#p88 + 1] = p86;
        end;
        for v89 = 2, #p86 do
            u90(p86[v89], p87, p88);
        end;
    end;
end;
local function v94(p91, p92, p93) --[[ Line: 366 ]]
    -- upvalues: u85 (copy)
    return u85(p91, p92, p93);
end;
if u7.Class then
    print("The type \'Class\' already exists! Use a different type name.");
else
    u7.Class = {
        InputConsumption = "Any",
        Interpreter = v94
    };
end;
local function v96(_, p95) --[[ Line: 369 ]]
    return p95;
end;
if u7.String then
    print("The type \'String\' already exists! Use a different type name.");
else
    u7.String = {
        InputConsumption = "Any",
        Interpreter = v96
    };
end;
local function v98(p97, _) --[[ Line: 372 ]]
    return p97;
end;
if u7.Commander then
    print("The type \'Commander\' already exists! Use a different type name.");
else
    u7.Commander = {
        InputConsumption = "None",
        Interpreter = v98
    };
end;
local u99 = l__Enumify__7(Enum.Font);
local l__Unknown__16 = Enum.Font.Unknown;
for v100, v101 in u99 do
    if v101 == l__Unknown__16 then
        u99[v100] = nil;
    end;
end;
local function v104(_, p102) --[[ Line: 385 ]]
    -- upvalues: u99 (copy)
    local v103 = u99[p102];
    if v103 then
        return v103.Value;
    end;
end;
if u7.Font then
    print("The type \'Font\' already exists! Use a different type name.");
else
    u7.Font = {
        InputConsumption = "Any",
        Interpreter = v104
    };
end;
local u105 = {
    big = 36,
    small = 12
};
local function v109(_, p106) --[[ Line: 393 ]]
    -- upvalues: u105 (copy), l__lower__3 (copy)
    local v107 = tonumber(p106);
    if v107 and (v107 >= 1 and v107 <= 99) then
        return v107;
    end;
    local v108 = u105[l__lower__3(p106)];
    if v108 then
        return v108;
    end;
end;
if u7.FontSize then
    print("The type \'FontSize\' already exists! Use a different type name.");
else
    u7.FontSize = {
        InputConsumption = "Any",
        Interpreter = v109
    };
end;
local function v112(_, p110) --[[ Line: 420 ]]
    local v111 = tonumber(p110);
    if v111 and (v111 >= 1 and v111 <= 100) then
        return v111;
    end;
end;
if u7.FontSize100 then
    print("The type \'FontSize100\' already exists! Use a different type name.");
else
    u7.FontSize100 = {
        InputConsumption = "Any",
        Interpreter = v112
    };
end;
local function v114(_, p113) --[[ Line: 426 ]]
    -- upvalues: l__lower__3 (copy)
    if p113 == "df" or l__lower__3(p113) == "default" then
        return "Default";
    end;
end;
if u7.Default then
    print("The type \'Default\' already exists! Use a different type name.");
else
    u7.Default = {
        InputConsumption = "Any",
        Interpreter = v114
    };
end;
local function v116(_, p115) --[[ Line: 431 ]]
    return tonumber(p115);
end;
if u7.Number then
    print("The type \'Number\' already exists! Use a different type name.");
else
    u7.Number = {
        InputConsumption = "Any",
        Interpreter = v116
    };
end;
local function v119(_, p117) --[[ Line: 434 ]]
    local v118 = tonumber(p117);
    if v118 and (v118 >= 0 and v118 <= 1) then
        return v118;
    end;
end;
if u7.Percent then
    print("The type \'Percent\' already exists! Use a different type name.");
else
    u7.Percent = {
        InputConsumption = "Any",
        Interpreter = v119
    };
end;
local function v122(_, p120) --[[ Line: 440 ]]
    local v121 = tonumber(p120);
    if v121 and v121 % 1 == 0 then
        return v121;
    end;
end;
if u7.Integer then
    print("The type \'Integer\' already exists! Use a different type name.");
else
    u7.Integer = {
        InputConsumption = "Any",
        Interpreter = v122
    };
end;
local function v125(_, p123) --[[ Line: 446 ]]
    local v124 = tonumber(p123);
    if v124 and v124 % 1 == 0 then
        return v124;
    end;
end;
if u7.DecalAssetId then
    print("The type \'DecalAssetId\' already exists! Use a different type name.");
else
    u7.DecalAssetId = {
        InputConsumption = "Any",
        Interpreter = v125
    };
end;
local function v128(_, p126) --[[ Line: 453 ]]
    -- upvalues: u6 (copy), l__lower__3 (copy)
    local v127 = u6[l__lower__3(p126)];
    if v127 then
        return v127;
    end;
end;
if u7.Donger then
    print("The type \'Donger\' already exists! Use a different type name.");
else
    u7.Donger = {
        InputConsumption = "Any",
        Interpreter = v128
    };
end;
local function v154(_, p129) --[[ Line: 459 ]]
    -- upvalues: u5 (copy)
    local v130 = u5[p129];
    if v130 then
        return v130;
    end;
    local v131 = tonumber(p129, 16);
    if v131 and #p129 == 6 then
        local v132 = v131 % 256;
        local v133 = (v131 - v132) / 256;
        local v134 = v133 % 256;
        return {
            a = 255,
            r = (v133 - v134) / 256,
            g = v134,
            b = v132
        };
    end;
    if v131 and #p129 == 8 then
        local v135 = v131 % 256;
        local v136 = (v131 - v135) / 256;
        local v137 = v136 % 256;
        local v138 = (v136 - v137) / 256;
        local v139 = v138 % 256;
        return {
            r = (v138 - v139) / 256,
            g = v139,
            b = v137,
            a = v135 or 255
        };
    end;
    local v140, v141, v142 = p129:match("^[^%+%-%w%.]*([%+%-%w%.]+)[^%+%-%w%.]+([%+%-%w%.]+)[^%+%-%w%.]+([%+%-%w%.]+)[^%+%-%w%.]*$");
    if v140 and (v141 and v142) then
        local v143 = tonumber(v140);
        local v144 = tonumber(v141);
        local v145 = tonumber(v142);
        if v143 and (v144 and v145) then
            return {
                a = 255,
                r = v143,
                g = v144,
                b = v145
            };
        end;
    else
        local v146, v147, v148, v149 = p129:match("^[^%+%-%w%.]*([%+%-%w%.]+)[^%+%-%w%.]+([%+%-%w%.]+)[^%+%-%w%.]+([%+%-%w%.]+)[^%+%-%w%.]+([%+%-%w%.]+)[^%+%-%w%.]*$");
        if v146 and (v147 and (v148 and v149)) then
            local v150 = tonumber(v146);
            local v151 = tonumber(v147);
            local v152 = tonumber(v148);
            local v153 = tonumber(v149);
            if v150 and (v151 and (v152 and v153)) then
                return {
                    r = v150,
                    g = v151,
                    b = v152,
                    a = v153 or 255
                };
            end;
        end;
    end;
end;
if u7.Color then
    print("The type \'Color\' already exists! Use a different type name.");
else
    u7.Color = {
        InputConsumption = "Any",
        Interpreter = v154
    };
end;
local function v176(p155, p156) --[[ Line: 495 ]]
    -- upvalues: l__lower__3 (copy), l__GetPlayers__9 (copy), l__Players__8 (copy), l__find__2 (copy)
    if p156 ~= "" then
        local v157 = l__lower__3(p156);
        if v157 == "@" then
            return;
        end;
        if v157 == "me" or v157 == "^" then
            return p155;
        end;
        local v158 = l__GetPlayers__9(l__Players__8);
        local v159 = {};
        for v160 = 1, #v158 do
            local v161 = v158[v160];
            local v162 = l__lower__3(v161.Name);
            if l__find__2(v162, v157, 1, true) or l__find__2(v162, p156) then
                v159[#v159 + 1] = v161;
            end;
        end;
        if #v159 == 1 then
            return v159[1];
        end;
        local v163 = (1 / 0);
        local v164 = {};
        for v165 = 1, #v159 do
            local v166 = v159[v165];
            local v167 = #v166.Name;
            if v167 < v163 then
                v163 = v167;
                v164 = { v166 };
            elseif v167 == v163 then
                v164[#v164 + 1] = v166;
            end;
        end;
        if #v164 == 1 then
            return v164[1];
        end;
        if #v164 > 1 then
            local v168 = {};
            for v169 = 1, #v158 do
                local v170 = v158[v169];
                local l__Name__17 = v170.Name;
                if l__find__2(l__Name__17, p156, 1, true) or l__find__2(l__Name__17, p156) then
                    v168[#v168 + 1] = v170;
                end;
            end;
            if #v168 == 1 then
                return v168[1];
            end;
            local v171 = (1 / 0);
            local v172 = {};
            for v173 = 1, #v168 do
                local v174 = v168[v173];
                local v175 = #v174.Name;
                if v175 < v171 then
                    v171 = v175;
                    v172 = { v174 };
                elseif v175 == v171 then
                    v172[#v172 + 1] = v174;
                end;
            end;
            if #v172 == 1 then
                return v172[1];
            end;
        end;
    end;
end;
if u7.Player then
    print("The type \'Player\' already exists! Use a different type name.");
else
    u7.Player = {
        InputConsumption = "Any",
        Interpreter = v176
    };
end;
local function u180(p177) --[[ Line: 565 ]]
    -- upvalues: u2 (copy), u180 (copy)
    if u2(p177) ~= "table" then
        return 0;
    end;
    if p177[1] == "Text" then
        return #p177[2];
    end;
    if p177[1] == "Image" then
        return 1;
    end;
    local v178 = 0;
    for v179 = 2, #p177 do
        v178 = v178 + u180(p177[v179]);
    end;
    return v178;
end;
local u181 = 144;
local function v182(...) --[[ Line: 597 ]]
    return ...;
end;
v15("", "ClearFormatting", {}, v182);
v15("", "List", { "Font", "Class" }, function(p183, p184) --[[ Line: 599 ]]
    return { "PushFont", p183 }, p184, { "PopFont" };
end, 1);
v15("", "Font", { "Font" }, v182, 1);
v15("font", "List", { "Font", "Class" }, function(p185, p186) --[[ Line: 603 ]]
    return { "PushFont", p185 }, p186, { "PopFont" };
end, 1);
v15("font", "Font", { "Font" }, v182, 1);
v15("font", "List", { "Default", "Class" }, function(p187, p188) --[[ Line: 607 ]]
    return { "PushFont", p187 }, p188, { "PopFont" };
end, 1);
v15("font", "Font", { "Default" }, v182, 1);
v15("b", "List", { "Class" }, function(p189) --[[ Line: 611 ]]
    return { "PushFont", Enum.Font.SourceSansBold.Value }, p189, { "PopFont" };
end);
v15("b", "Font", {}, function() --[[ Line: 614 ]]
    return Enum.Font.SourceSansBold.Value;
end);
v15("bold", "List", { "Class" }, function(p190) --[[ Line: 617 ]]
    return { "PushFont", Enum.Font.SourceSansBold.Value }, p190, { "PopFont" };
end);
v15("bold", "Font", {}, function() --[[ Line: 620 ]]
    return Enum.Font.SourceSansBold.Value;
end);
v15("i", "List", { "Class" }, function(p191) --[[ Line: 623 ]]
    return { "PushFont", Enum.Font.SourceSansItalic.Value }, p191, { "PopFont" };
end);
v15("i", "Font", {}, function() --[[ Line: 626 ]]
    return Enum.Font.SourceSansItalic.Value;
end);
v15("italic", "List", { "Class" }, function(p192) --[[ Line: 629 ]]
    return { "PushFont", Enum.Font.SourceSansItalic.Value }, p192, { "PopFont" };
end);
v15("italic", "Font", {}, function() --[[ Line: 632 ]]
    return Enum.Font.SourceSansItalic.Value;
end);
v15("", "List", { "Commander", "FontSize", "Class" }, function(p193, p194, p195) --[[ Line: 635 ]]
    if p193.userId == 52250025 then
        return { "PushFontSize", p194 }, p195, { "PopFontSize" };
    elseif p194 < 8 then
        return { "PushFontSize", 8 }, p195, { "PopFontSize" };
    elseif p194 < 48 then
        return { "PushFontSize", p194 }, p195, { "PopFontSize" };
    else
        return { "PushFontSize", 48 }, p195, { "PopFontSize" };
    end;
end, 1);
v15("", "FontSize", { "Commander", "FontSize" }, function(p196, p197) --[[ Line: 647 ]]
    if p196.userId == 52250025 then
        return p197;
    else
        return p197 < 8 and 8 or (p197 >= 48 and 48 or p197);
    end;
end, 1);
v15("fontsize", "List", { "Commander", "FontSize100", "Class" }, function(p198, p199, p200) --[[ Line: 659 ]]
    if p198.userId == 52250025 then
        return { "PushFontSize", p199 }, p200, { "PopFontSize" };
    elseif p199 < 8 then
        return { "PushFontSize", 8 }, p200, { "PopFontSize" };
    elseif p199 < 48 then
        return { "PushFontSize", p199 }, p200, { "PopFontSize" };
    else
        return { "PushFontSize", 48 }, p200, { "PopFontSize" };
    end;
end, 1);
v15("fontsize", "FontSize", { "Commander", "FontSize100" }, function(p201, p202) --[[ Line: 671 ]]
    if p201.userId == 52250025 then
        return p202;
    else
        return p202 < 8 and 8 or (p202 >= 48 and 48 or p202);
    end;
end, 1);
v15("fontsize", "List", { "Default", "Class" }, function(p203, p204) --[[ Line: 683 ]]
    return { "PushFontSize", p203 }, p204, { "PopFontSize" };
end, 1);
v15("fontsize", "FontSize", { "Default" }, v182, 1);
v15("stroke", "List", { "Color", "Class" }, function(p205, p206) --[[ Line: 687 ]]
    return { "PushTextStroke", p205 }, p206, { "PopTextStroke" };
end, 1);
v15("stroke", "TextStroke", { "Color" }, v182, 1);
v15("stroke", "List", { "Default", "Class" }, function(p207, p208) --[[ Line: 691 ]]
    return { "PushTextStroke", p207 }, p208, { "PopTextStroke" };
end, 1);
v15("stroke", "TextStroke", { "Default" }, v182);
v15("", "List", { "Color", "Class" }, function(p209, p210) --[[ Line: 695 ]]
    return { "PushFGColor", p209 }, p210, { "PopFGColor" };
end, 1);
v15("", "FGColor", { "Color" }, v182, 1);
v15("fg", "List", { "Color", "Class" }, function(p211, p212) --[[ Line: 699 ]]
    return { "PushFGColor", p211 }, p212, { "PopFGColor" };
end, 1);
v15("fg", "FGColor", { "Color" }, v182, 1);
v15("fg", "List", { "Default", "Class" }, function(p213, p214) --[[ Line: 703 ]]
    return { "PushFGColor", p213 }, p214, { "PopFGColor" };
end, 1);
v15("fg", "FGColor", { "Default" }, v182, 1);
v15("bg", "List", { "Color", "Class" }, function(p215, p216) --[[ Line: 707 ]]
    return { "PushBGColor", p215 }, p216, { "PopBGColor" };
end, 1);
v15("bg", "BGColor", { "Color" }, v182, 1);
v15("bg", "List", { "Default", "Class" }, function(p217, p218) --[[ Line: 711 ]]
    return { "PushBGColor", p217 }, p218, { "PopBGColor" };
end, 1);
v15("bg", "BGColor", { "Default" }, v182, 1);
v15("fonttf", "List", { "Default", "Class" }, function(p219, p220) --[[ Line: 715 ]]
    return { "PushFontThinkFunc", p219 }, p220, { "PopFontThinkFunc" };
end, 1);
v15("fonttf", "FontThinkFunc", { "Default" }, v182, 1);
v15("fontsizetf", "List", { "DefaultThinkFunc", "Class" }, function(p221, p222) --[[ Line: 719 ]]
    return { "PushFontSizeThinkFunc", p221 }, p222, { "PopFontSizeThinkFunc" };
end, 1);
v15("fontsizetf", "FontSizeThinkFunc", { "Default" }, v182, 1);
v15("stroketf", "List", { "Default", "Class" }, function(p223, p224) --[[ Line: 723 ]]
    return { "PushTextStrokeThinkFunc", p223 }, p224, { "PopTextStrokeThinkFunc" };
end, 1);
v15("stroketf", "TextStrokeThinkFunc", { "Default" }, v182, 1);
v15("fgtf", "List", { "Default", "Class" }, function(p225, p226) --[[ Line: 727 ]]
    return { "PushFGColorThinkFunc", p225 }, p226, { "PopFGColorThinkFunc" };
end, 1);
v15("fgtf", "FGColorThinkFunc", { "Default" }, v182, 1);
v15("bgtf", "List", { "Default", "Class" }, function(p227, p228) --[[ Line: 731 ]]
    return { "PushBGColorThinkFunc", p227 }, p228, { "PopBGColorThinkFunc" };
end, 1);
v15("bgtf", "BGColorThinkFunc", { "Default" }, v182, 1);
v15("plain", "Text", { "String" }, v182);
v15("time", "Text", {}, function() --[[ Line: 736 ]]
    return {
        "TimeStamp",
        { "Tick" }
    };
end);
v15("d", "List", { "Number", "Class" }, function(p229, p230) --[[ Line: 739 ]]
    return { "IncrementDelay", p229 }, p230, { "IncrementDelay", -p229 };
end);
v15("d", "IncrementDelay", { "Number" }, v182);
v15("delay", "List", { "Number", "Class" }, function(p231, p232) --[[ Line: 743 ]]
    return { "IncrementDelay", p231 }, p232, { "IncrementDelay", -p231 };
end);
v15("delay", "IncrementDelay", { "Number" }, v182);
v15("", "Image", { "Donger" }, function(p233) --[[ Line: 747 ]]
    return p233[2] / p233[3], 1, p233[1];
end, 2);
v15("img", "Image", { "DecalAssetId" }, function(p234) --[[ Line: 750 ]]
    -- upvalues: u181 (ref)
    return u181, u181, p234, true;
end, 2);
v15("img", "Image", { "Number", "DecalAssetId" }, function(p235, p236) --[[ Line: 753 ]]
    return p235, 2, p236, false;
end, 2);
v15("img", "Image", {
    "Commander",
    "Number",
    "Number",
    "DecalAssetId"
}, function(p237, p238, p239, p240) --[[ Line: 756 ]]
    -- upvalues: u181 (ref)
    if p237.userId == 52250025 then
        return p238, p239, p240, true;
    end;
    local v241 = p239 < u181 and p239 and p239 or u181;
    return p238 / p239 * v241, v241, p240, true;
end, 2);
v15("roll", "Roll", { "Number", "Class" }, v182, 8);
v15("roll", "Roll", { "Class" }, function(p242) --[[ Line: 764 ]]
    return 0.5, p242;
end, 8);
v15("spin", "Spin", { "Number", "Class" }, v182, 8);
v15("spin", "Spin", { "Class" }, function(p243) --[[ Line: 769 ]]
    return 0.5, p243;
end, 8);
v15("flip", "Rotate", { "Class" }, function(p244) --[[ Line: 773 ]]
    return 3.141592653589793, p244;
end, 8);
v15("rotate", "Rotate", { "Number", "Class" }, function(p245, p246) --[[ Line: 776 ]]
    return 0.017453292519943295 * p245, p246;
end, 8);
v15("intensify", "Intensify", { "Number", "Class" }, v182, 8);
v15("intensify", "Intensify", { "Class" }, function(p247) --[[ Line: 780 ]]
    return 2, p247;
end, 8);
v15("overunder", "Column", { "Class", "Class" }, v182, 8);
v15("mlg", "Wander", { "Number", "Number", "Class" }, v182, 8);
v15("mlg", "Wander", { "Class" }, function(p248) --[[ Line: 786 ]]
    return 6, 10, p248;
end, 8);
v15("bounce", "Bounce", { "Number", "Number", "Class" }, v182, 8);
v15("bounce", "Bounce", { "Class" }, function(p249) --[[ Line: 790 ]]
    return 10, 1, p249;
end, 8);
v15("wiggle", "Wiggle", { "Number", "Number", "Class" }, v182, 8);
v15("wiggle", "Wiggle", { "Class" }, function(p250) --[[ Line: 794 ]]
    return 0.5, 1, p250;
end, 8);
v15("wave", "List", {
    "Number",
    "Number",
    "Number",
    "Class"
}, function(p251, p252, p253, p254) --[[ Line: 797 ]]
    return {
        "PushThinkFunc",
        "Wave",
        p251,
        p252,
        p253
    }, p254, { "PopThinkFunc" };
end, 8);
v15("wave", "ThinkFunc", { "Number", "Number", "Number" }, function(p255, p256, p257) --[[ Line: 800 ]]
    return "Wave", p255, p256, p257;
end, 8);
v15("wave", "List", { "Class" }, function(p258) --[[ Line: 803 ]]
    return {
        "PushThinkFunc",
        "Wave",
        10,
        160,
        1
    }, p258, { "PopThinkFunc" };
end, 8);
v15("wave", "ThinkFunc", {}, function() --[[ Line: 806 ]]
    return "Wave", 10, 160, 1;
end, 8);
v15("rainbowstroke", "List", { "Class" }, function(p259) --[[ Line: 809 ]]
    -- upvalues: u180 (copy)
    return { "PushTextStroke", "Rainbow", (u180(p259)) }, p259, { "PopTextStroke" };
end, 4);
v15("rainbow", "List", { "Class" }, function(p260) --[[ Line: 812 ]]
    -- upvalues: u180 (copy)
    return { "PushFGColor", "Rainbow", (u180(p260)) }, p260, { "PopFGColor" };
end, 4);
v15("rainbowbg", "List", { "Class" }, function(p261) --[[ Line: 815 ]]
    -- upvalues: u180 (copy)
    return { "PushBGColor", "Rainbow", (u180(p261)) }, p261, { "PopBGColor" };
end, 4);
v15("gradstroke", "List", { "Color", "Color", "Class" }, function(p262, p263, p264) --[[ Line: 818 ]]
    -- upvalues: u180 (copy)
    return {
        "PushTextStroke",
        "Gradient",
        u180(p264),
        p262,
        p263
    }, p264, { "PopTextStroke" };
end, 4);
v15("grad", "List", { "Color", "Color", "Class" }, function(p265, p266, p267) --[[ Line: 821 ]]
    -- upvalues: u180 (copy)
    return {
        "PushFGColor",
        "Gradient",
        u180(p267),
        p265,
        p266
    }, p267, { "PopFGColor" };
end, 4);
v15("gradbg", "List", { "Color", "Color", "Class" }, function(p268, p269, p270) --[[ Line: 824 ]]
    -- upvalues: u180 (copy)
    return {
        "PushBGColor",
        "Gradient",
        u180(p270),
        p268,
        p269
    }, p270, { "PopBGColor" };
end, 4);
v15("ncstroke", "List", { "String", "Class" }, function(p271, p272) --[[ Line: 827 ]]
    -- upvalues: u3 (copy)
    return { "PushTextStroke", u3(p271) }, p272, { "PopTextStroke" };
end, 4);
v15("ncstroke", "TextStroke", { "String" }, function(p273) --[[ Line: 830 ]]
    -- upvalues: u3 (copy)
    return u3(p273);
end, 4);
v15("nc", "List", { "String", "Class" }, function(p274, p275) --[[ Line: 833 ]]
    -- upvalues: u3 (copy)
    return { "PushFGColor", u3(p274) }, p275, { "PopFGColor" };
end, 4);
v15("nc", "FGColor", { "String" }, function(p276) --[[ Line: 836 ]]
    -- upvalues: u3 (copy)
    return u3(p276);
end, 4);
v15("ncbg", "List", { "String", "Class" }, function(p277, p278) --[[ Line: 839 ]]
    -- upvalues: u3 (copy)
    return { "PushBGColor", u3(p277) }, p278, { "PopBGColor" };
end, 4);
v15("ncbg", "BGColor", { "String" }, function(p279) --[[ Line: 842 ]]
    -- upvalues: u3 (copy)
    return u3(p279);
end, 4);
v15("flashstroke", "List", {
    "Number",
    "Color",
    "Color",
    "Class"
}, function(p280, p281, p282, p283) --[[ Line: 845 ]]
    return {
        "PushTextStrokeThinkFunc",
        "Flash",
        p280,
        p281,
        p282
    }, p283, { "PopTextStrokeThinkFunc" };
end, 4);
v15("flashstroke", "List", { "Color", "Color", "Class" }, function(p284, p285, p286) --[[ Line: 848 ]]
    return {
        "PushTextStrokeThinkFunc",
        "Flash",
        1,
        p284,
        p285
    }, p286, { "PopTextStrokeThinkFunc" };
end, 4);
v15("flashstroke", "TextStrokeThinkFunc", { "Number", "Color", "Color" }, function(p287, p288, p289) --[[ Line: 851 ]]
    return "Flash", p287, p288, p289;
end, 4);
v15("flashstroke", "TextStrokeThinkFunc", { "Color", "Color" }, function(p290, p291) --[[ Line: 854 ]]
    return "Flash", 1, p290, p291;
end, 4);
v15("flash", "List", {
    "Number",
    "Color",
    "Color",
    "Class"
}, function(p292, p293, p294, p295) --[[ Line: 857 ]]
    return {
        "PushFGColorThinkFunc",
        "Flash",
        p292,
        p293,
        p294
    }, p295, { "PopFGColorThinkFunc" };
end, 4);
v15("flash", "List", { "Color", "Color", "Class" }, function(p296, p297, p298) --[[ Line: 860 ]]
    return {
        "PushFGColorThinkFunc",
        "Flash",
        1,
        p296,
        p297
    }, p298, { "PopFGColorThinkFunc" };
end, 4);
v15("flash", "FGColorThinkFunc", { "Number", "Color", "Color" }, function(p299, p300, p301) --[[ Line: 863 ]]
    return "Flash", p299, p300, p301;
end, 4);
v15("flash", "FGColorThinkFunc", { "Color", "Color" }, function(p302, p303) --[[ Line: 866 ]]
    return "Flash", 1, p302, p303;
end, 4);
v15("flashbg", "List", {
    "Number",
    "Color",
    "Color",
    "Class"
}, function(p304, p305, p306, p307) --[[ Line: 869 ]]
    return {
        "PushBGColorThinkFunc",
        "Flash",
        p304,
        p305,
        p306
    }, p307, { "PopBGColorThinkFunc" };
end, 4);
v15("flashbg", "List", { "Color", "Color", "Class" }, function(p308, p309, p310) --[[ Line: 872 ]]
    return {
        "PushBGColorThinkFunc",
        "Flash",
        1,
        p308,
        p309
    }, p310, { "PopBGColorThinkFunc" };
end, 4);
v15("flashbg", "BGColorThinkFunc", { "Number", "Color", "Color" }, function(p311, p312, p313) --[[ Line: 875 ]]
    return "Flash", p311, p312, p313;
end, 4);
v15("flashbg", "BGColorThinkFunc", { "Color", "Color" }, function(p314, p315) --[[ Line: 878 ]]
    return "Flash", 1, p314, p315;
end, 4);
v15("fadestroke", "List", {
    "Number",
    "Color",
    "Color",
    "Class"
}, function(p316, p317, p318, p319) --[[ Line: 881 ]]
    return {
        "PushTextStrokeThinkFunc",
        "Fade",
        p316,
        p317,
        p318
    }, p319, { "PopTextStrokeThinkFunc" };
end, 4);
v15("fadestroke", "List", { "Color", "Color", "Class" }, function(p320, p321, p322) --[[ Line: 884 ]]
    return {
        "PushTextStrokeThinkFunc",
        "Fade",
        1,
        p320,
        p321
    }, p322, { "PopTextStrokeThinkFunc" };
end, 4);
v15("fadestroke", "TextStrokeThinkFunc", { "Number", "Color", "Color" }, function(p323, p324, p325) --[[ Line: 887 ]]
    return "Fade", p323, p324, p325;
end, 4);
v15("fadestroke", "TextStrokeThinkFunc", { "Color", "Color" }, function(p326, p327) --[[ Line: 890 ]]
    return "Fade", 1, p326, p327;
end, 4);
v15("fade", "List", {
    "Number",
    "Color",
    "Color",
    "Class"
}, function(p328, p329, p330, p331) --[[ Line: 893 ]]
    return {
        "PushFGColorThinkFunc",
        "Fade",
        p328,
        p329,
        p330
    }, p331, { "PopFGColorThinkFunc" };
end, 4);
v15("fade", "List", { "Color", "Color", "Class" }, function(p332, p333, p334) --[[ Line: 896 ]]
    return {
        "PushFGColorThinkFunc",
        "Fade",
        1,
        p332,
        p333
    }, p334, { "PopFGColorThinkFunc" };
end, 4);
v15("fade", "FGColorThinkFunc", { "Number", "Color", "Color" }, function(p335, p336, p337) --[[ Line: 899 ]]
    return "Fade", p335, p336, p337;
end, 4);
v15("fade", "FGColorThinkFunc", { "Color", "Color" }, function(p338, p339) --[[ Line: 902 ]]
    return "Fade", 1, p338, p339;
end, 4);
v15("fadebg", "List", {
    "Number",
    "Color",
    "Color",
    "Class"
}, function(p340, p341, p342, p343) --[[ Line: 905 ]]
    return {
        "PushBGColorThinkFunc",
        "Fade",
        p340,
        p341,
        p342
    }, p343, { "PopBGColorThinkFunc" };
end, 4);
v15("fadebg", "List", { "Color", "Color", "Class" }, function(p344, p345, p346) --[[ Line: 908 ]]
    return {
        "PushBGColorThinkFunc",
        "Fade",
        1,
        p344,
        p345
    }, p346, { "PopBGColorThinkFunc" };
end, 4);
v15("fadebg", "BGColorThinkFunc", { "Number", "Color", "Color" }, function(p347, p348, p349) --[[ Line: 911 ]]
    return "Fade", p347, p348, p349;
end, 4);
v15("fadebg", "BGColorThinkFunc", { "Color", "Color" }, function(p350, p351) --[[ Line: 914 ]]
    return "Fade", 1, p350, p351;
end, 4);
v15("glowstroke", "List", { "Number", "Class" }, function(p352, p353) --[[ Line: 917 ]]
    return { "PushTextStrokeThinkFunc", "Glow", p352 }, p353, { "PopTextStrokeThinkFunc" };
end, 4);
v15("glowstroke", "List", { "Class" }, function(p354) --[[ Line: 920 ]]
    return { "PushTextStrokeThinkFunc", "Glow", 0.5 }, p354, { "PopTextStrokeThinkFunc" };
end, 4);
v15("glowstroke", "TextStrokeThinkFunc", { "Number" }, function(p355) --[[ Line: 923 ]]
    return "Glow", p355;
end, 4);
v15("glowstroke", "TextStrokeThinkFunc", {}, function() --[[ Line: 926 ]]
    return "Glow", 0.5;
end, 4);
v15("glow", "List", { "Number", "Class" }, function(p356, p357) --[[ Line: 929 ]]
    return { "PushFGColorThinkFunc", "Glow", p356 }, p357, { "PopFGColorThinkFunc" };
end, 4);
v15("glow", "List", { "Class" }, function(p358) --[[ Line: 932 ]]
    return { "PushFGColorThinkFunc", "Glow", 0.5 }, p358, { "PopFGColorThinkFunc" };
end, 4);
v15("glow", "FGColorThinkFunc", { "Number" }, function(p359) --[[ Line: 935 ]]
    return "Glow", p359;
end, 4);
v15("glow", "FGColorThinkFunc", {}, function() --[[ Line: 938 ]]
    return "Glow", 0.5;
end, 4);
v15("glowbg", "List", { "Number", "Class" }, function(p360, p361) --[[ Line: 941 ]]
    return { "PushBGColorThinkFunc", "Glow", p360 }, p361, { "PopBGColorThinkFunc" };
end, 4);
v15("glowbg", "List", { "Class" }, function(p362) --[[ Line: 944 ]]
    return { "PushBGColorThinkFunc", "Glow", 0.5 }, p362, { "PopBGColorThinkFunc" };
end, 4);
v15("glowbg", "BGColorThinkFunc", { "Number" }, function(p363) --[[ Line: 947 ]]
    return "Glow", p363;
end, 4);
v15("glowbg", "BGColorThinkFunc", {}, function() --[[ Line: 950 ]]
    return "Glow", 0.5;
end, 4);
v15("rainbowglowstroke", "List", { "Number", "Number", "Class" }, function(p364, p365, p366) --[[ Line: 953 ]]
    return {
        "PushTextStrokeThinkFunc",
        "RainbowGlow",
        p364,
        p365
    }, p366, { "PopTextStrokeThinkFunc" };
end, 4);
v15("rainbowglowstroke", "List", { "Class" }, function(p367) --[[ Line: 956 ]]
    return {
        "PushTextStrokeThinkFunc",
        "RainbowGlow",
        160,
        1
    }, p367, { "PopTextStrokeThinkFunc" };
end, 4);
v15("rainbowglowstroke", "TextStrokeThinkFunc", { "Number", "Number" }, function(p368, p369) --[[ Line: 959 ]]
    return "RainbowGlow", p368, p369;
end, 4);
v15("rainbowglowstroke", "TextStrokeThinkFunc", {}, function() --[[ Line: 962 ]]
    return "RainbowGlow", 160, 1;
end, 4);
v15("rainbowglow", "List", { "Number", "Number", "Class" }, function(p370, p371, p372) --[[ Line: 965 ]]
    return {
        "PushFGColorThinkFunc",
        "RainbowGlow",
        p370,
        p371
    }, p372, { "PopFGColorThinkFunc" };
end, 4);
v15("rainbowglow", "List", { "Class" }, function(p373) --[[ Line: 968 ]]
    return {
        "PushFGColorThinkFunc",
        "RainbowGlow",
        160,
        1
    }, p373, { "PopFGColorThinkFunc" };
end, 4);
v15("rainbowglow", "FGColorThinkFunc", { "Number", "Number" }, function(p374, p375) --[[ Line: 971 ]]
    return "RainbowGlow", p374, p375;
end, 4);
v15("rainbowglow", "FGColorThinkFunc", {}, function() --[[ Line: 974 ]]
    return "RainbowGlow", 160, 1;
end, 4);
v15("rainbowglowbg", "List", { "Number", "Number", "Class" }, function(p376, p377, p378) --[[ Line: 977 ]]
    return {
        "PushBGColorThinkFunc",
        "RainbowGlow",
        p376,
        p377
    }, p378, { "PopBGColorThinkFunc" };
end, 4);
v15("rainbowglowbg", "List", { "Class" }, function(p379) --[[ Line: 980 ]]
    return {
        "PushBGColorThinkFunc",
        "RainbowGlow",
        160,
        1
    }, p379, { "PopBGColorThinkFunc" };
end, 4);
v15("rainbowglowbg", "BGColorThinkFunc", { "Number", "Number" }, function(p380, p381) --[[ Line: 983 ]]
    return "RainbowGlow", p380, p381;
end, 4);
v15("rainbowglowbg", "BGColorThinkFunc", {}, function() --[[ Line: 986 ]]
    return "RainbowGlow", 160, 1;
end, 4);
v15("fadewavestroke", "List", {
    "Color",
    "Color",
    "Number",
    "Number",
    "Class"
}, function(p382, p383, p384, p385, p386) --[[ Line: 989 ]]
    return {
        "PushTextStrokeThinkFunc",
        "FadeWave",
        p382,
        p383,
        p384,
        p385
    }, p386, { "PopTextStrokeThinkFunc" };
end, 4);
v15("fadewavestroke", "List", { "Color", "Color", "Class" }, function(p387, p388, p389) --[[ Line: 992 ]]
    return {
        "PushTextStrokeThinkFunc",
        "FadeWave",
        p387,
        p388,
        160,
        1
    }, p389, { "PopTextStrokeThinkFunc" };
end, 4);
v15("fadewavestroke", "TextStrokeThinkFunc", {
    "Color",
    "Color",
    "Number",
    "Number"
}, function(p390, p391, p392, p393) --[[ Line: 995 ]]
    return "FadeWave", p390, p391, p392, p393;
end, 4);
v15("fadewavestroke", "TextStrokeThinkFunc", { "Color", "Color" }, function(p394, p395) --[[ Line: 998 ]]
    return "FadeWave", p394, p395, 160, 1;
end, 4);
v15("fadewave", "List", {
    "Color",
    "Color",
    "Number",
    "Number",
    "Class"
}, function(p396, p397, p398, p399, p400) --[[ Line: 1001 ]]
    return {
        "PushFGColorThinkFunc",
        "FadeWave",
        p396,
        p397,
        p398,
        p399
    }, p400, { "PopFGColorThinkFunc" };
end, 4);
v15("fadewave", "List", { "Color", "Color", "Class" }, function(p401, p402, p403) --[[ Line: 1004 ]]
    return {
        "PushFGColorThinkFunc",
        "FadeWave",
        p401,
        p402,
        160,
        1
    }, p403, { "PopFGColorThinkFunc" };
end, 4);
v15("fadewave", "FGColorThinkFunc", {
    "Color",
    "Color",
    "Number",
    "Number"
}, function(p404, p405, p406, p407) --[[ Line: 1007 ]]
    return "FadeWave", p404, p405, p406, p407;
end, 4);
v15("fadewave", "FGColorThinkFunc", { "Color", "Color" }, function(p408, p409) --[[ Line: 1010 ]]
    return "FadeWave", p408, p409, 160, 1;
end, 4);
v15("fadewavebg", "List", {
    "Color",
    "Color",
    "Number",
    "Number",
    "Class"
}, function(p410, p411, p412, p413, p414) --[[ Line: 1013 ]]
    return {
        "PushBGColorThinkFunc",
        "FadeWave",
        p410,
        p411,
        p412,
        p413
    }, p414, { "PopBGColorThinkFunc" };
end, 4);
v15("fadewavebg", "List", { "Color", "Color", "Class" }, function(p415, p416, p417) --[[ Line: 1016 ]]
    return {
        "PushBGColorThinkFunc",
        "FadeWave",
        p415,
        p416,
        160,
        1
    }, p417, { "PopBGColorThinkFunc" };
end, 4);
v15("fadewavebg", "BGColorThinkFunc", {
    "Color",
    "Color",
    "Number",
    "Number"
}, function(p418, p419, p420, p421) --[[ Line: 1019 ]]
    return "FadeWave", p418, p419, p420, p421;
end, 4);
v15("fadewavebg", "BGColorThinkFunc", { "Color", "Color" }, function(p422, p423) --[[ Line: 1022 ]]
    return "FadeWave", p422, p423, 160, 1;
end, 4);
return {
    Parse = u85,
    AddPattern = v15,
    SetMaxImageY = function(p424) --[[ Name: SetMaxImageY, Line 1032 ]]
        -- upvalues: u181 (ref)
        if p424 then
            u181 = p424;
        else
            u181 = 144;
        end;
    end,
    SearchStructure = u90
};
