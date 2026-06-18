-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.BetterSpring
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local v1 = {};
local _ = table.sort;
local l__atan2__1 = math.atan2;
local l__cos__2 = math.cos;
local l__sin__3 = math.sin;
local u2 = setmetatable;
local u3 = tick;
local l__Dot__4 = Vector3.new().Dot;
v1.spring = {};
local v4 = {};
v1.spring = v4;
local l__cos__5 = math.cos;
local l__sin__6 = math.sin;
function v4.new(p5) --[[ Line: 21 ]]
    -- upvalues: u3 (copy), l__cos__5 (copy), l__sin__6 (copy), u2 (copy)
    local u6 = 0 * (p5 or 0);
    local u7 = 1;
    local u8 = 1;
    local u9 = p5 or u6;
    local u10 = u6;
    local u11 = p5 or u6;
    local u12 = u3();
    local u13 = 0;
    local u14 = u6;
    local u15 = u6;
    local v16 = {};
    local v17 = {};
    local function u20() --[[ Line: 34 ]]
        -- upvalues: u8 (ref), u13 (ref), u14 (ref), u6 (copy), u15 (ref), u7 (ref), u9 (ref), u11 (ref), u10 (ref)
        if u8 == 0 then
            u13 = 0;
            u14 = u6;
            u15 = u6;
        elseif u7 < 0.99999999 then
            u13 = (1 - u7 * u7) ^ 0.5;
            u14 = u9 - u11;
            u15 = u7 / u13 * u14 + u10 / (u13 * u8);
        elseif u7 < 1.00000001 then
            u13 = 0;
            u14 = u9 - u11;
            u15 = u14 + u10 / u8;
        else
            u13 = (u7 * u7 - 1) ^ 0.5;
            local v18 = -u10 / (u8 * 2 * u13);
            local v19 = -(u11 - u9) / 2;
            u14 = (1 - u7 / u13) * v19 + v18;
            u15 = (u7 / u13 + 1) * v19 - v18;
        end;
    end;
    local function u25(p21) --[[ Line: 55 ]]
        -- upvalues: u9 (ref), u8 (ref), u7 (ref), u13 (ref), l__cos__5 (ref), l__sin__6 (ref), u14 (ref), u15 (ref), u11 (ref)
        if p21 < 0.001 then
            return u9;
        elseif u8 == 0 then
            return u9;
        elseif u7 < 0.99999999 then
            local v22 = l__cos__5(u13 * u8 * p21);
            local v23 = l__sin__6(u13 * u8 * p21);
            local v24 = 2.718281828459045 ^ (u7 * u8 * p21);
            return v22 / v24 * u14 + v23 / v24 * u15 + u11;
        elseif u7 < 1.00000001 then
            return (u14 + u8 * p21 * u15) / 2.718281828459045 ^ (u8 * p21) + u11;
        else
            return u14 * 2.718281828459045 ^ ((-u7 - u13) * u8 * p21) + u15 * 2.718281828459045 ^ ((-u7 + u13) * u8 * p21) + u11;
        end;
    end;
    local function u30(p26) --[[ Line: 75 ]]
        -- upvalues: u10 (ref), u8 (ref), u9 (ref), u7 (ref), u13 (ref), l__cos__5 (ref), l__sin__6 (ref), u15 (ref), u14 (ref)
        if p26 < 0.001 then
            return u10;
        elseif u8 == 0 then
            return u9;
        elseif u7 < 0.99999999 then
            local v27 = l__cos__5(u13 * u8 * p26);
            local v28 = l__sin__6(u13 * u8 * p26);
            local v29 = 2.718281828459045 ^ (u7 * u8 * p26);
            return u8 * (v27 * u13 - u7 * v28) / v29 * u15 - u8 * (v27 * u7 + u13 * v28) / v29 * u14;
        elseif u7 < 1.00000001 then
            return -u8 / 2.718281828459045 ^ (u8 * p26) * (u14 + (u8 * p26 - 1) * u15);
        else
            return 2.718281828459045 ^ ((-u7 + u13) * u8 * p26) * (u13 - u7) * u8 * u15 - 2.718281828459045 ^ ((-u7 - u13) * u8 * p26) * (u7 + u13) * u8 * u14;
        end;
    end;
    local function u38(p31) --[[ Line: 95 ]]
        -- upvalues: u8 (ref), u9 (ref), u7 (ref), u13 (ref), l__cos__5 (ref), l__sin__6 (ref), u14 (ref), u15 (ref), u11 (ref)
        if u8 == 0 then
            return u9;
        elseif u7 < 0.99999999 then
            local v32 = l__cos__5(u13 * u8 * p31);
            local v33 = l__sin__6(u13 * u8 * p31);
            local v34 = 2.718281828459045 ^ (u7 * u8 * p31);
            return v32 / v34 * u14 + v33 / v34 * u15 + u11, u8 * (v32 * u13 - u7 * v33) / v34 * u15 - u8 * (v32 * u7 + u13 * v33) / v34 * u14;
        else
            if u7 < 1.00000001 then
                local v35 = 2.718281828459045 ^ (u8 * p31);
                return (u14 + u8 * p31 * u15) / v35 + u11, -u8 / v35 * (u14 + (u8 * p31 - 1) * u15);
            end;
            local v36 = 2.718281828459045 ^ ((-u7 - u13) * u8 * p31);
            local v37 = 2.718281828459045 ^ ((-u7 + u13) * u8 * p31);
            return u14 * v36 + u15 * v37 + u11, v37 * (u13 - u7) * u8 * u15 - v36 * (u7 + u13) * u8 * u14;
        end;
    end;
    u20();
    function v16.getpv() --[[ Line: 113 ]]
        -- upvalues: u38 (copy), u3 (ref), u12 (ref)
        return u38(u3() - u12);
    end;
    function v16.setpv(p39, p40) --[[ Line: 116 ]]
        -- upvalues: u3 (ref), u9 (ref), u10 (ref), u12 (ref), u20 (copy)
        local v41 = u3();
        u9 = p39;
        u10 = p40;
        u12 = v41;
        u20();
    end;
    function v16.accelerate(_, p42) --[[ Line: 122 ]]
        -- upvalues: u3 (ref), u38 (copy), u12 (ref), u9 (ref), u10 (ref), u20 (copy)
        local v43 = u3();
        local v44, v45 = u38(v43 - u12);
        local v46 = v45 + p42;
        u9 = v44;
        u10 = v46;
        u12 = v43;
        u20();
    end;
    function v17.__index(_, p47) --[[ Line: 129 ]]
        -- upvalues: u3 (ref), u25 (copy), u12 (ref), u30 (copy), u11 (ref), u7 (ref), u8 (ref)
        local v48 = u3();
        if p47 == "p" then
            return u25(v48 - u12);
        end;
        if p47 == "v" then
            return u30(v48 - u12);
        end;
        if p47 == "t" then
            return u11;
        end;
        if p47 == "d" then
            return u7;
        end;
        if p47 == "s" then
            return u8;
        end;
    end;
    function v17.__newindex(_, p49, p50) --[[ Line: 143 ]]
        -- upvalues: u3 (ref), u9 (ref), u10 (ref), u30 (copy), u12 (ref), u25 (copy), u38 (copy), u11 (ref), u7 (ref), u8 (ref), u20 (copy)
        local v51 = u3();
        if p49 == "p" then
            local v52 = u30(v51 - u12);
            u9 = p50;
            u10 = v52;
        elseif p49 == "v" then
            u9 = u25(v51 - u12);
            u10 = p50;
        elseif p49 == "t" then
            local v53, v54 = u38(v51 - u12);
            u9 = v53;
            u10 = v54;
            u11 = p50;
        elseif p49 == "d" then
            if p50 == nil then
                warn("nil value for d");
                warn(debug.stacktrace());
                p50 = u7;
            end;
            local v55, v56 = u38(v51 - u12);
            u9 = v55;
            u10 = v56;
            u7 = p50;
        elseif p49 == "s" then
            if p50 == nil then
                warn("nil value for s");
                warn(debug.stacktrace());
                p50 = u8;
            end;
            local v57, v58 = u38(v51 - u12);
            u9 = v57;
            u10 = v58;
            u8 = p50;
        elseif p49 == "a" then
            local v59, v60 = u38(v51 - u12);
            local v61 = v60 + p50;
            u9 = v59;
            u10 = v61;
        end;
        u12 = v51;
        u20();
    end;
    return u2(v16, v17);
end;
local function u96(p62, p63, p64, p65, p66) --[[ Line: 179 ]]
    -- upvalues: u96 (copy), l__atan2__1 (copy), l__cos__2 (copy), l__sin__3 (copy)
    if p62 then
        if p62 > -1e-10 and p62 < 1e-10 then
            return u96(p63, p64, p65, p66);
        elseif p66 then
            local v67 = -p63 / (4 * p62);
            local v68 = (8 * p62 * p64 - 3 * p63 * p63) / (8 * p62 * p62);
            local v69 = (p63 * p63 * p63 + 8 * p62 * p62 * p65 - 4 * p62 * p63 * p64) / (8 * p62 * p62 * p62);
            local v70 = (16 * p62 * p62 * p63 * p63 * p64 + 256 * p62 * p62 * p62 * p62 * p66 - 3 * p62 * p63 * p63 * p63 * p63 - 64 * p62 * p62 * p62 * p63 * p65) / (256 * p62 * p62 * p62 * p62 * p62);
            local v71, _, v72 = u96(1, 2 * v68, v68 * v68 - 4 * v70, -v69 * v69);
            local v73 = v72 or v71;
            if v73 < 1e-10 then
                local _, v74 = u96(1, v68, v70);
                if v74 and v74 >= 0 then
                    local v75 = v74 ^ 0.5;
                    return v67 - v75, v67 + v75;
                end;
            else
                local v76 = v73 ^ 0.5;
                local v77 = (v76 * v76 * v76 + v76 * v68 - v69) / (2 * v76);
                if v77 > -1e-10 and v77 < 1e-10 then
                    return v67 - v76, v67;
                end;
                local v78, v79 = u96(1, v76, v77);
                local v80, v81 = u96(1, -v76, v70 / v77);
                if v78 and v80 then
                    return v67 + v78, v67 + v79, v67 + v80, v67 + v81;
                end;
                if v78 then
                    return v67 + v78, v67 + v79;
                end;
                if v80 then
                    return v67 + v80, v67 + v81;
                end;
            end;
        elseif p65 then
            local v82 = -p63 / (3 * p62);
            local v83 = (3 * p62 * p64 - p63 * p63) / (9 * p62 * p62);
            local v84 = (2 * p63 * p63 * p63 - 9 * p62 * p63 * p64 + 27 * p62 * p62 * p65) / (54 * p62 * p62 * p62);
            local v85 = v83 * v83 * v83 + v84 * v84;
            local v86 = v85 ^ 0.5 + v84;
            if v86 > -1e-10 and v86 < 1e-10 then
                if v84 < 0 then
                    return v82 + (-2 * v84) ^ 0.3333333333333333;
                else
                    return v82 - (2 * v84) ^ 0.3333333333333333;
                end;
            elseif v85 < 0 then
                local v87 = (-v83) ^ 0.5;
                local v88 = l__atan2__1((-v85) ^ 0.5, v84) / 3;
                local v89 = v87 * l__cos__2(v88);
                local v90 = v87 * l__sin__3(v88);
                return v82 - 2 * v89, v82 + v89 - 1.7320508075688772 * v90, v82 + v89 + 1.7320508075688772 * v90;
            elseif v86 < 0 then
                local v91 = -(-v86) ^ 0.3333333333333333;
                return v82 + v83 / v91 - v91;
            else
                local v92 = v86 ^ 0.3333333333333333;
                return v82 + v83 / v92 - v92;
            end;
        elseif p64 then
            local v93 = -p63 / (2 * p62);
            local v94 = v93 * v93 - p64 / p62;
            if v94 >= 0 then
                local v95 = v94 ^ 0.5;
                return v93 - v95, v93 + v95;
            end;
        else
            if p63 then
                return -p63 / p62;
            end;
        end;
    end;
end;
v1.solve = u96;
local function u101(p97, p98, p99, p100) --[[ Line: 260 ]]
    if p97 and p97 >= 0 then
        return p97;
    end;
    if p98 and p98 >= 0 then
        return p98;
    end;
    if p99 and p99 >= 0 then
        return p99;
    end;
    if p100 and p100 >= 0 then
        return p100;
    end;
end;
v1.minpos = u101;
function v1.minposroot(p102, p103, p104, p105, p106) --[[ Line: 272 ]]
    -- upvalues: u101 (copy), u96 (copy)
    return u101(u96(p102, p103, p104, p105, p106));
end;
function v1.cpoint_traj_point(p107, p108, p109) --[[ Line: 276 ]]
    -- upvalues: l__Dot__4 (copy), u96 (copy)
    local v110 = -2 * l__Dot__4(p109, p107);
    local v111 = 2 * (l__Dot__4(p107, p107) - l__Dot__4(p108, p109));
    local v112 = 3 * l__Dot__4(p108, p107);
    local v116, v116, v116, v116 = u96(l__Dot__4(p108, p108), v112, v111, v110);
    if not v116 or v116 < 0 then
        if not v116 or v116 < 0 then
            if not v116 or v116 < 0 then
                if not v116 or v116 < 0 then
                    v116 = nil;
                end;
            end;
        end;
    end;
    if v116 then
        return v116, v116 * p107 + v116 * v116 / 2 * p108;
    end;
end;
function v1.simple_trajectory(p117, p118, p119) --[[ Line: 286 ]]
    -- upvalues: l__Dot__4 (copy), u96 (copy)
    local v120 = 4 * l__Dot__4(p119, p119);
    local v121 = -4 * (l__Dot__4(p118, p119) + p117 * p117);
    local v122 = l__Dot__4(p118, p118);
    local v123, v124, v125, v126;
    if v122 then
        if v122 > -1e-10 and v122 < 1e-10 then
            v123, v124, v125, v126 = u96(v121, v120, nil, nil);
        elseif v120 then
            local v127 = -v121 / (2 * v122);
            local v128 = v127 * v127 - v120 / v122;
            if v128 < 0 then
                v123 = nil;
                v124 = nil;
                v125 = nil;
                v126 = nil;
            else
                local v129 = v128 ^ 0.5;
                v123 = v127 - v129;
                v124 = v127 + v129;
                v125 = nil;
                v126 = nil;
            end;
        elseif v121 then
            v123 = -v121 / v122;
            v124 = nil;
            v125 = nil;
            v126 = nil;
        else
            v123 = nil;
            v124 = nil;
            v125 = nil;
            v126 = nil;
        end;
    else
        v123 = nil;
        v124 = nil;
        v125 = nil;
        v126 = nil;
    end;
    if v123 and v123 >= 0 then
        v126 = v123;
    elseif v124 and v124 >= 0 then
        v126 = v124;
    elseif v125 and v125 >= 0 then
        v126 = v125;
    elseif not v126 or v126 < 0 then
        v126 = nil;
    end;
    if v126 then
        local v130 = v126 ^ 0.5;
        return p119 / v130 - v130 / 2 * p118;
    end;
end;
function v1.trajectory(p131, p132, p133, p134, p135, p136, p137) --[[ Line: 296 ]]
    -- upvalues: u96 (copy), l__Dot__4 (copy)
    local v138 = p134 - p131;
    local v139 = p135 - p132;
    local v140 = p136 - p133;
    local v141, v142, v143, v144 = u96(l__Dot__4(v140, v140) / 4, l__Dot__4(v140, v139), l__Dot__4(v140, v138) + l__Dot__4(v139, v139) - p137 * p137, 2 * l__Dot__4(v138, v139), l__Dot__4(v138, v138));
    if v141 and v141 > 0 then
        return v140 * v141 / 2 + p135 + v138 / v141, v141;
    end;
    if v142 and v142 > 0 then
        return v140 * v142 / 2 + p135 + v138 / v142, v142;
    end;
    if v143 and v143 > 0 then
        return v140 * v143 / 2 + p135 + v138 / v143, v143;
    end;
    if v144 and v144 > 0 then
        return v140 * v144 / 2 + p135 + v138 / v144, v144;
    end;
end;
return v1;
