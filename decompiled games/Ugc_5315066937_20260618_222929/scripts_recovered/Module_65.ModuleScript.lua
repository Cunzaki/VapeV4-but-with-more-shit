-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ceil__1 = math.ceil;
local l__floor__2 = math.floor;
local l__sub__3 = string.sub;
local l__byte__4 = string.byte;
local l__char__5 = string.char;
local l__concat__6 = table.concat;
function v1.comp48(p2) --[[ Line: 10 ]]
    -- upvalues: l__char__5 (copy)
    local v3 = p2 % 256;
    local v4 = (p2 - v3) / 256;
    local v5 = v4 % 256;
    local v6 = (v4 - v5) / 256;
    local v7 = v6 % 256;
    local v8 = (v6 - v7) / 256;
    local v9 = v8 % 256;
    local v10 = (v8 - v9) / 256;
    local v11 = v10 % 256;
    local v12 = (v10 - v11) / 256;
    local v13 = v12 % 256;
    local _ = (v12 - v13) / 256;
    return l__char__5(v3, v5, v7, v9, v11, v13);
end;
function v1.decomp48(p14, p15) --[[ Line: 21 ]]
    -- upvalues: l__byte__4 (copy)
    local v16, v17, v18, v19, v20, v21 = l__byte__4(p14, 6 * p15 - 5, 6 * p15);
    return v16 * 1 + v17 * 256 + v18 * 65536 + v19 * 16777216 + v20 * 4294967296 + v21 * 1099511627776;
end;
function v1.newbitwriter() --[[ Line: 27 ]]
    -- upvalues: l__char__5 (copy), l__ceil__1 (copy), l__sub__3 (copy), l__concat__6 (copy)
    local u22 = 0;
    local u23 = {};
    local u24 = 0;
    local u25 = 0;
    return function(p26, p27) --[[ Name: write, Line 32 ]]
        -- upvalues: u24 (ref), u22 (ref), u23 (copy), u25 (ref), l__char__5 (ref)
        while u24 + p26 >= 48 do
            local v28 = 48 - u24;
            local v29 = 2 ^ v28;
            local v30 = p27 % v29;
            u22 = u22 + 1;
            local v31 = u23;
            local v32 = u22;
            local v33 = u25 + v30 * 2 ^ u24;
            local v34 = v33 % 256;
            local v35 = (v33 - v34) / 256;
            local v36 = v35 % 256;
            local v37 = (v35 - v36) / 256;
            local v38 = v37 % 256;
            local v39 = (v37 - v38) / 256;
            local v40 = v39 % 256;
            local v41 = (v39 - v40) / 256;
            local v42 = v41 % 256;
            local v43 = (v41 - v42) / 256;
            local v44 = v43 % 256;
            local _ = (v43 - v44) / 256;
            v31[v32] = l__char__5(v34, v36, v38, v40, v42, v44);
            u24 = 0;
            u25 = 0;
            p26 = p26 - v28;
            p27 = (p27 - v30) / v29;
        end;
        u25 = u25 + p27 * 2 ^ u24;
        u24 = u24 + p26;
    end, function(p45) --[[ Name: finalize, Line 61 ]]
        -- upvalues: u24 (ref), u25 (ref), l__char__5 (ref), l__ceil__1 (ref), l__sub__3 (ref), u22 (ref), u23 (copy), l__concat__6 (ref)
        if u24 ~= 0 then
            local v46 = u25;
            local v47 = v46 % 256;
            local v48 = (v46 - v47) / 256;
            local v49 = v48 % 256;
            local v50 = (v48 - v49) / 256;
            local v51 = v50 % 256;
            local v52 = (v50 - v51) / 256;
            local v53 = v52 % 256;
            local v54 = (v52 - v53) / 256;
            local v55 = v54 % 256;
            local v56 = (v54 - v55) / 256;
            local v57 = v56 % 256;
            local _ = (v56 - v57) / 256;
            local v58 = l__char__5(v47, v49, v51, v53, v55, v57);
            if p45 then
                v58 = l__sub__3(v58, 1, (l__ceil__1(u24 / 8)));
            end;
            u22 = u22 + 1;
            u23[u22] = v58;
            u24 = 0;
            u25 = 0;
        end;
        return l__concat__6(u23);
    end, function(p59) --[[ Name: raw, Line 67 ]]
        -- upvalues: u24 (ref), u25 (ref), l__char__5 (ref), l__ceil__1 (ref), l__sub__3 (ref), u22 (ref), u23 (copy)
        if u24 ~= 0 then
            local v60 = u25;
            local v61 = v60 % 256;
            local v62 = (v60 - v61) / 256;
            local v63 = v62 % 256;
            local v64 = (v62 - v63) / 256;
            local v65 = v64 % 256;
            local v66 = (v64 - v65) / 256;
            local v67 = v66 % 256;
            local v68 = (v66 - v67) / 256;
            local v69 = v68 % 256;
            local v70 = (v68 - v69) / 256;
            local v71 = v70 % 256;
            local _ = (v70 - v71) / 256;
            local v72 = l__sub__3(l__char__5(v61, v63, v65, v67, v69, v71), 1, (l__ceil__1(u24 / 8)));
            u22 = u22 + 1;
            u23[u22] = v72;
            u24 = 0;
            u25 = 0;
        end;
        u22 = u22 + 1;
        u23[u22] = p59;
    end;
end;
function v1.newbitreader(u73) --[[ Line: 76 ]]
    -- upvalues: l__byte__4 (copy), l__floor__2 (copy), l__sub__3 (copy), l__char__5 (copy)
    local u74 = 0;
    local u75 = 0;
    local u76 = 0;
    local function u90(p77) --[[ Line: 80 ]]
        -- upvalues: u75 (ref), u76 (ref), u74 (ref), u73 (copy), l__byte__4 (ref)
        local v78 = 0;
        local v79 = 0;
        while u75 + v78 < p77 do
            v79 = v79 + u76 * 2 ^ v78;
            v78 = v78 + u75;
            u74 = u74 + 1;
            local v80 = u74;
            local v81, v82, v83, v84, v85, v86 = l__byte__4(u73, 6 * v80 - 5, 6 * v80);
            u76 = v81 * 1 + v82 * 256 + v83 * 65536 + v84 * 16777216 + v85 * 4294967296 + v86 * 1099511627776;
            u75 = 48;
        end;
        local v87 = p77 - v78;
        local v88 = 2 ^ v87;
        local v89 = u76 % v88;
        u75 = u75 - v87;
        u76 = (u76 - v89) / v88;
        return v79 + v89 * 2 ^ v78;
    end;
    return u90, function(p91) --[[ Name: tellp, Line 99 ]]
        -- upvalues: u74 (ref), u75 (ref)
        if p91 then
            return u74 * 6 - u75 / 8;
        else
            return u74 * 6;
        end;
    end, function(p92) --[[ Name: raw, Line 108 ]]
        -- upvalues: u75 (ref), u74 (ref), l__floor__2 (ref), u76 (ref), u90 (copy), u73 (copy), l__sub__3 (ref), l__char__5 (ref)
        if u75 < p92 * 8 then
            local v93 = u74 * 6 - u75 / 8;
            local v94 = v93 + p92;
            u74 = l__floor__2(v94 / 6);
            u75 = 0;
            u76 = 0;
            u90(v94 % 6 * 8);
            return l__sub__3(u73, v93 + 1, v94);
        end;
        local v95 = u90(p92 * 8);
        local v96 = v95 % 256;
        local v97 = (v95 - v96) / 256;
        local v98 = v97 % 256;
        local v99 = (v97 - v98) / 256;
        local v100 = v99 % 256;
        local v101 = (v99 - v100) / 256;
        local v102 = v101 % 256;
        local v103 = (v101 - v102) / 256;
        local v104 = v103 % 256;
        local v105 = (v103 - v104) / 256;
        local v106 = v105 % 256;
        local _ = (v105 - v106) / 256;
        return l__sub__3(l__char__5(v96, v98, v100, v102, v104, v106), 1, p92);
    end;
end;
return v1;
