-- Decompiled from: ReplicatedStorage.Modules.MD5
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    _VERSION = "md5.lua 1.1.0",
    _DESCRIPTION = "MD5 computation in Lua (5.1-3, LuaJIT)",
    _URL = "https://github.com/kikito/md5.lua",
    _LICENSE = "    MIT LICENSE\n\n    Copyright (c) 2013 Enrique García Cota + Adam Baldwin + hanzao + Equi 4 Software\n\n    Permission is hereby granted, free of charge, to any person obtaining a\n    copy of this software and associated documentation files (the\n    \"Software\"), to deal in the Software without restriction, including\n    without limitation the rights to use, copy, modify, merge, publish,\n    distribute, sublicense, and/or sell copies of the Software, and to\n    permit persons to whom the Software is furnished to do so, subject to\n    the following conditions:\n\n    The above copyright notice and this permission notice shall be included\n    in all copies or substantial portions of the Software.\n\n    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n  "
};
local l__char__1 = string.char;
local l__byte__2 = string.byte;
local l__format__3 = string.format;
local l__rep__4 = string.rep;
local l__sub__5 = string.sub;
local v2, v3 = pcall(require, "bit");
local v4, u5 = pcall(require, "ffi");
local u6, u7, u8, u9, u10;
if v2 then
    u6 = v3.bor;
    u7 = v3.band;
    local _ = v3.bnot;
    u8 = v3.bxor;
    u9 = v3.rshift;
    u10 = v3.lshift;
else
    local v11, v12 = pcall(require, "bit32");
    if v11 then
        local l__bnot__6 = v12.bnot;
        local l__bor__7 = v12.bor;
        u6 = function(p13, p14) --[[ Line: 53 ]]
            -- upvalues: l__bor__7 (copy), l__bnot__6 (ref)
            local v15 = l__bor__7(p13 <= 2147483647 and p13 and p13 or -(l__bnot__6(p13) + 1), p14 <= 2147483647 and p14 and p14 or -(l__bnot__6(p14) + 1));
            return v15 <= 2147483647 and v15 and v15 or -(l__bnot__6(v15) + 1);
        end;
        local l__band__8 = v12.band;
        u7 = function(p16, p17) --[[ Line: 53 ]]
            -- upvalues: l__band__8 (copy), l__bnot__6 (ref)
            local v18 = l__band__8(p16 <= 2147483647 and p16 and p16 or -(l__bnot__6(p16) + 1), p17 <= 2147483647 and p17 and p17 or -(l__bnot__6(p17) + 1));
            return v18 <= 2147483647 and v18 and v18 or -(l__bnot__6(v18) + 1);
        end;
        local l__bxor__9 = v12.bxor;
        u8 = function(p19, p20) --[[ Line: 53 ]]
            -- upvalues: l__bxor__9 (copy), l__bnot__6 (ref)
            local v21 = l__bxor__9(p19 <= 2147483647 and p19 and p19 or -(l__bnot__6(p19) + 1), p20 <= 2147483647 and p20 and p20 or -(l__bnot__6(p20) + 1));
            return v21 <= 2147483647 and v21 and v21 or -(l__bnot__6(v21) + 1);
        end;
        local l__rshift__10 = v12.rshift;
        u9 = function(p22, p23) --[[ Line: 53 ]]
            -- upvalues: l__rshift__10 (copy), l__bnot__6 (ref)
            local v24 = l__rshift__10(p22 <= 2147483647 and p22 and p22 or -(l__bnot__6(p22) + 1), p23 <= 2147483647 and p23 and p23 or -(l__bnot__6(p23) + 1));
            return v24 <= 2147483647 and v24 and v24 or -(l__bnot__6(v24) + 1);
        end;
        local l__lshift__11 = v12.lshift;
        u10 = function(p25, p26) --[[ Line: 53 ]]
            -- upvalues: l__lshift__11 (copy), l__bnot__6 (ref)
            local v27 = l__lshift__11(p25 <= 2147483647 and p25 and p25 or -(l__bnot__6(p25) + 1), p26 <= 2147483647 and p26 and p26 or -(l__bnot__6(p26) + 1));
            return v27 <= 2147483647 and v27 and v27 or -(l__bnot__6(v27) + 1);
        end;
    else
        local u28 = nil;
        local function u35(p29) --[[ Line: 84 ]]
            -- upvalues: u28 (ref)
            local v30 = u28(p29);
            for v31 = 1, math.max(#v30, 32) do
                if v30[v31] == 1 then
                    v30[v31] = 0;
                else
                    v30[v31] = 1;
                end;
            end;
            local v32 = 1;
            local v33 = 0;
            for v34 = 1, #v30 do
                v33 = v33 + v30[v34] * v32;
                v32 = v32 * 2;
            end;
            return v33;
        end;
        u28 = function(p36) --[[ Line: 98 ]]
            -- upvalues: u28 (ref), u35 (ref)
            if p36 < 0 then
                return u28(u35((math.abs(p36))) + 1);
            end;
            local v37 = {};
            local v38 = 1;
            while p36 > 0 do
                local v39 = p36 % 2;
                v37[v38] = v39;
                p36 = (p36 - v39) / 2;
                v38 = v38 + 1;
            end;
            return v37;
        end;
        local function u52(p40, p41) --[[ Line: 117 ]]
            -- upvalues: u28 (ref)
            local v42 = u28(p40);
            local v43 = u28(p41);
            local v44, v45;
            if #v42 < #v43 then
                v44 = v43;
                v45 = v42;
            else
                v44 = v42;
                v45 = v43;
            end;
            for v46 = #v45 + 1, #v44 do
                v45[v46] = 0;
            end;
            local v47 = {};
            for v48 = 1, #v42 do
                if v42[v48] == 0 and v43[v48] == 0 then
                    v47[v48] = 0;
                else
                    v47[v48] = 1;
                end;
            end;
            local v49 = 1;
            local v50 = 0;
            for v51 = 1, #v47 do
                v50 = v50 + v47[v51] * v49;
                v49 = v49 * 2;
            end;
            return v50;
        end;
        local function u65(p53, p54) --[[ Line: 134 ]]
            -- upvalues: u28 (ref)
            local v55 = u28(p53);
            local v56 = u28(p54);
            local v57, v58;
            if #v55 < #v56 then
                v57 = v56;
                v58 = v55;
            else
                v57 = v55;
                v58 = v56;
            end;
            for v59 = #v58 + 1, #v57 do
                v58[v59] = 0;
            end;
            local v60 = {};
            for v61 = 1, #v55 do
                if v55[v61] == 0 or v56[v61] == 0 then
                    v60[v61] = 0;
                else
                    v60[v61] = 1;
                end;
            end;
            local v62 = 1;
            local v63 = 0;
            for v64 = 1, #v60 do
                v63 = v63 + v60[v64] * v62;
                v62 = v62 * 2;
            end;
            return v63;
        end;
        u8 = function(p66, p67) --[[ Line: 151 ]]
            -- upvalues: u28 (ref)
            local v68 = u28(p66);
            local v69 = u28(p67);
            local v70, v71;
            if #v68 < #v69 then
                v70 = v69;
                v71 = v68;
            else
                v70 = v68;
                v71 = v69;
            end;
            for v72 = #v71 + 1, #v70 do
                v71[v72] = 0;
            end;
            local v73 = {};
            for v74 = 1, #v68 do
                if v68[v74] == v69[v74] then
                    v73[v74] = 0;
                else
                    v73[v74] = 1;
                end;
            end;
            local v75 = 1;
            local v76 = 0;
            for v77 = 1, #v73 do
                v76 = v76 + v73[v77] * v75;
                v75 = v75 * 2;
            end;
            return v76;
        end;
        u9 = function(p78, p79) --[[ Line: 168 ]]
            -- upvalues: u35 (ref), u52 (ref)
            local v80;
            if p78 < 0 then
                p78 = u35((math.abs(p78))) + 1;
                v80 = 2147483648;
            else
                v80 = 0;
            end;
            local l__floor__12 = math.floor;
            for _ = 1, p79 do
                p78 = u52(l__floor__12(p78 / 2), v80);
            end;
            return l__floor__12(p78);
        end;
        u10 = function(p81, p82) --[[ Line: 185 ]]
            -- upvalues: u35 (ref), u65 (ref)
            if p81 < 0 then
                p81 = u35((math.abs(p81))) + 1;
            end;
            for _ = 1, p82 do
                p81 = p81 * 2;
            end;
            return u65(p81, 4294967295);
        end;
        u7 = u65;
        u6 = u52;
    end;
end;
local u83;
if v4 then
    local u84 = u5.typeof("int[1]");
    u83 = function(p85) --[[ Line: 204 ]]
        -- upvalues: u5 (copy), u84 (copy)
        return u5.string(u84(p85), 4);
    end;
else
    u83 = function(p86) --[[ Line: 206 ]]
        -- upvalues: u7 (ref), u9 (ref), l__char__1 (copy)
        return l__char__1(u7(u9(p86, 0), 255)) .. l__char__1(u7(u9(p86, 8), 255)) .. l__char__1(u7(u9(p86, 16), 255)) .. l__char__1(u7(u9(p86, 24), 255));
    end;
end;
local u87;
if v4 then
    local u88 = u5.typeof("const char*");
    local u89 = u5.typeof("const int*");
    u87 = function(p90) --[[ Line: 229 ]]
        -- upvalues: u88 (copy), u5 (copy), u89 (copy)
        local v91 = u88(p90);
        return u5.cast(u89, v91)[0];
    end;
else
    u87 = function(p92) --[[ Line: 234 ]]
        -- upvalues: l__byte__2 (copy)
        local v93 = 0;
        for v94 = #p92, 1, -1 do
            v93 = v93 * 256 + l__byte__2(p92, v94);
        end;
        return v93;
    end;
end;
local function u96(p95) --[[ Line: 245 ]]
    -- upvalues: u87 (ref), l__sub__5 (copy)
    return {
        u87((l__sub__5(p95, 1, 4))),
        u87((l__sub__5(p95, 5, 8))),
        u87((l__sub__5(p95, 9, 12))),
        u87((l__sub__5(p95, 13, 16))),
        u87((l__sub__5(p95, 17, 20))),
        u87((l__sub__5(p95, 21, 24))),
        u87((l__sub__5(p95, 25, 28))),
        u87((l__sub__5(p95, 29, 32))),
        u87((l__sub__5(p95, 33, 36))),
        u87((l__sub__5(p95, 37, 40))),
        u87((l__sub__5(p95, 41, 44))),
        u87((l__sub__5(p95, 45, 48))),
        u87((l__sub__5(p95, 49, 52))),
        u87((l__sub__5(p95, 53, 56))),
        u87((l__sub__5(p95, 57, 60))),
        u87((l__sub__5(p95, 61, 64)))
    };
end;
local u97 = {
    3614090360,
    3905402710,
    606105819,
    3250441966,
    4118548399,
    1200080426,
    2821735955,
    4249261313,
    1770035416,
    2336552879,
    4294925233,
    2304563134,
    1804603682,
    4254626195,
    2792965006,
    1236535329,
    4129170786,
    3225465664,
    643717713,
    3921069994,
    3593408605,
    38016083,
    3634488961,
    3889429448,
    568446438,
    3275163606,
    4107603335,
    1163531501,
    2850285829,
    4243563512,
    1735328473,
    2368359562,
    4294588738,
    2272392833,
    1839030562,
    4259657740,
    2763975236,
    1272893353,
    4139469664,
    3200236656,
    681279174,
    3936430074,
    3572445317,
    76029189,
    3654602809,
    3873151461,
    530742520,
    3299628645,
    4096336452,
    1126891415,
    2878612391,
    4237533241,
    1700485571,
    2399980690,
    4293915773,
    2240044497,
    1873313359,
    4264355552,
    2734768916,
    1309151649,
    4149444226,
    3174756917,
    718787259,
    3951481745,
    1732584193,
    4023233417,
    2562383102,
    271733878
};
local function u101(p98, p99, p100) --[[ Line: 289 ]]
    -- upvalues: u6 (ref), u7 (ref)
    return u6(u7(p98, p99), u7(-p98 - 1, p100));
end;
local function u105(p102, p103, p104) --[[ Line: 290 ]]
    -- upvalues: u6 (ref), u7 (ref)
    return u6(u7(p102, p104), u7(p103, -p104 - 1));
end;
local function u109(p106, p107, p108) --[[ Line: 291 ]]
    -- upvalues: u8 (ref)
    return u8(p106, u8(p107, p108));
end;
local function u113(p110, p111, p112) --[[ Line: 292 ]]
    -- upvalues: u8 (ref), u6 (ref)
    return u8(p111, u6(p110, -p112 - 1));
end;
local function u123(p114, p115, p116, p117, p118, p119, p120, p121) --[[ Line: 293 ]]
    -- upvalues: u7 (ref), u6 (ref), u10 (ref), u9 (ref)
    local v122 = u7(p115 + p114(p116, p117, p118) + p119 + p121, 4294967295);
    return u6(u10(u7(v122, u9(4294967295, p120)), p120), u9(v122, 32 - p120)) + p116;
end;
local function u194(p124, p125, p126, p127, p128) --[[ Line: 299 ]]
    -- upvalues: u97 (copy), u123 (copy), u101 (copy), u105 (copy), u109 (copy), u113 (copy), u7 (ref)
    local v129 = u97;
    local v130 = u123(u101, p124, p125, p126, p127, p128[0], 7, v129[1]);
    local v131 = u123(u101, p127, v130, p125, p126, p128[1], 12, v129[2]);
    local v132 = u123(u101, p126, v131, v130, p125, p128[2], 17, v129[3]);
    local v133 = u123(u101, p125, v132, v131, v130, p128[3], 22, v129[4]);
    local v134 = u123(u101, v130, v133, v132, v131, p128[4], 7, v129[5]);
    local v135 = u123(u101, v131, v134, v133, v132, p128[5], 12, v129[6]);
    local v136 = u123(u101, v132, v135, v134, v133, p128[6], 17, v129[7]);
    local v137 = u123(u101, v133, v136, v135, v134, p128[7], 22, v129[8]);
    local v138 = u123(u101, v134, v137, v136, v135, p128[8], 7, v129[9]);
    local v139 = u123(u101, v135, v138, v137, v136, p128[9], 12, v129[10]);
    local v140 = u123(u101, v136, v139, v138, v137, p128[10], 17, v129[11]);
    local v141 = u123(u101, v137, v140, v139, v138, p128[11], 22, v129[12]);
    local v142 = u123(u101, v138, v141, v140, v139, p128[12], 7, v129[13]);
    local v143 = u123(u101, v139, v142, v141, v140, p128[13], 12, v129[14]);
    local v144 = u123(u101, v140, v143, v142, v141, p128[14], 17, v129[15]);
    local v145 = u123(u101, v141, v144, v143, v142, p128[15], 22, v129[16]);
    local v146 = u123(u105, v142, v145, v144, v143, p128[1], 5, v129[17]);
    local v147 = u123(u105, v143, v146, v145, v144, p128[6], 9, v129[18]);
    local v148 = u123(u105, v144, v147, v146, v145, p128[11], 14, v129[19]);
    local v149 = u123(u105, v145, v148, v147, v146, p128[0], 20, v129[20]);
    local v150 = u123(u105, v146, v149, v148, v147, p128[5], 5, v129[21]);
    local v151 = u123(u105, v147, v150, v149, v148, p128[10], 9, v129[22]);
    local v152 = u123(u105, v148, v151, v150, v149, p128[15], 14, v129[23]);
    local v153 = u123(u105, v149, v152, v151, v150, p128[4], 20, v129[24]);
    local v154 = u123(u105, v150, v153, v152, v151, p128[9], 5, v129[25]);
    local v155 = u123(u105, v151, v154, v153, v152, p128[14], 9, v129[26]);
    local v156 = u123(u105, v152, v155, v154, v153, p128[3], 14, v129[27]);
    local v157 = u123(u105, v153, v156, v155, v154, p128[8], 20, v129[28]);
    local v158 = u123(u105, v154, v157, v156, v155, p128[13], 5, v129[29]);
    local v159 = u123(u105, v155, v158, v157, v156, p128[2], 9, v129[30]);
    local v160 = u123(u105, v156, v159, v158, v157, p128[7], 14, v129[31]);
    local v161 = u123(u105, v157, v160, v159, v158, p128[12], 20, v129[32]);
    local v162 = u123(u109, v158, v161, v160, v159, p128[5], 4, v129[33]);
    local v163 = u123(u109, v159, v162, v161, v160, p128[8], 11, v129[34]);
    local v164 = u123(u109, v160, v163, v162, v161, p128[11], 16, v129[35]);
    local v165 = u123(u109, v161, v164, v163, v162, p128[14], 23, v129[36]);
    local v166 = u123(u109, v162, v165, v164, v163, p128[1], 4, v129[37]);
    local v167 = u123(u109, v163, v166, v165, v164, p128[4], 11, v129[38]);
    local v168 = u123(u109, v164, v167, v166, v165, p128[7], 16, v129[39]);
    local v169 = u123(u109, v165, v168, v167, v166, p128[10], 23, v129[40]);
    local v170 = u123(u109, v166, v169, v168, v167, p128[13], 4, v129[41]);
    local v171 = u123(u109, v167, v170, v169, v168, p128[0], 11, v129[42]);
    local v172 = u123(u109, v168, v171, v170, v169, p128[3], 16, v129[43]);
    local v173 = u123(u109, v169, v172, v171, v170, p128[6], 23, v129[44]);
    local v174 = u123(u109, v170, v173, v172, v171, p128[9], 4, v129[45]);
    local v175 = u123(u109, v171, v174, v173, v172, p128[12], 11, v129[46]);
    local v176 = u123(u109, v172, v175, v174, v173, p128[15], 16, v129[47]);
    local v177 = u123(u109, v173, v176, v175, v174, p128[2], 23, v129[48]);
    local v178 = u123(u113, v174, v177, v176, v175, p128[0], 6, v129[49]);
    local v179 = u123(u113, v175, v178, v177, v176, p128[7], 10, v129[50]);
    local v180 = u123(u113, v176, v179, v178, v177, p128[14], 15, v129[51]);
    local v181 = u123(u113, v177, v180, v179, v178, p128[5], 21, v129[52]);
    local v182 = u123(u113, v178, v181, v180, v179, p128[12], 6, v129[53]);
    local v183 = u123(u113, v179, v182, v181, v180, p128[3], 10, v129[54]);
    local v184 = u123(u113, v180, v183, v182, v181, p128[10], 15, v129[55]);
    local v185 = u123(u113, v181, v184, v183, v182, p128[1], 21, v129[56]);
    local v186 = u123(u113, v182, v185, v184, v183, p128[8], 6, v129[57]);
    local v187 = u123(u113, v183, v186, v185, v184, p128[15], 10, v129[58]);
    local v188 = u123(u113, v184, v187, v186, v185, p128[6], 15, v129[59]);
    local v189 = u123(u113, v185, v188, v187, v186, p128[13], 21, v129[60]);
    local v190 = u123(u113, v186, v189, v188, v187, p128[4], 6, v129[61]);
    local v191 = u123(u113, v187, v190, v189, v188, p128[11], 10, v129[62]);
    local v192 = u123(u113, v188, v191, v190, v189, p128[2], 15, v129[63]);
    local v193 = u123(u113, v189, v192, v191, v190, p128[9], 21, v129[64]);
    return u7(p124 + v190, 4294967295), u7(p125 + v193, 4294967295), u7(p126 + v192, 4294967295), u7(p127 + v191, 4294967295);
end;
local function u204(p195, p196) --[[ Line: 377 ]]
    -- upvalues: u96 (copy), l__sub__5 (copy), u194 (copy)
    p195.pos = p195.pos + #p196;
    local v197 = p195.buf .. p196;
    for v198 = 1, #v197 - 63, 64 do
        local v199 = u96((l__sub__5(v197, v198, v198 + 63)));
        assert(#v199 == 16);
        v199[0] = table.remove(v199, 1);
        local v200, v201, v202, v203 = u194(p195.a, p195.b, p195.c, p195.d, v199);
        p195.a = v200;
        p195.b = v201;
        p195.c = v202;
        p195.d = v203;
    end;
    p195.buf = l__sub__5(v197, math.floor(#v197 / 64) * 64 + 1, #v197);
    return p195;
end;
local function u207(p205) --[[ Line: 390 ]]
    -- upvalues: l__rep__4 (copy), u83 (ref), u7 (ref), u204 (copy)
    local l__pos__13 = p205.pos;
    local v206 = 56 - l__pos__13 % 64;
    if l__pos__13 % 64 > 56 then
        v206 = v206 + 64;
    end;
    u204(p205, "\128" .. l__rep__4("\0", (v206 == 0 and 64 or v206) - 1) .. u83(u7(8 * l__pos__13, 4294967295)) .. u83((math.floor(l__pos__13 / 536870912))));
    assert(p205.pos % 64 == 0);
    return u83(p205.a) .. u83(p205.b) .. u83(p205.c) .. u83(p205.d);
end;
function u1.new() --[[ Line: 407 ]]
    -- upvalues: u97 (copy), u204 (copy), u207 (copy)
    return {
        pos = 0,
        buf = "",
        a = u97[65],
        b = u97[66],
        c = u97[67],
        d = u97[68],
        update = u204,
        finish = u207
    };
end;
function u1.tohex(p208) --[[ Line: 415 ]]
    -- upvalues: l__format__3 (copy), l__sub__5 (copy), l__byte__2 (copy)
    local v209 = l__format__3;
    local v210 = l__sub__5(p208, 1, 4);
    local v211 = 0;
    local v212 = "%08x%08x%08x%08x";
    for v213 = 1, #v210 do
        v211 = v211 * 256 + l__byte__2(v210, v213);
    end;
    local v214 = l__sub__5(p208, 5, 8);
    local v215 = 0;
    for v216 = 1, #v214 do
        v215 = v215 * 256 + l__byte__2(v214, v216);
    end;
    local v217 = l__sub__5(p208, 9, 12);
    local v218 = 0;
    for v219 = 1, #v217 do
        v218 = v218 * 256 + l__byte__2(v217, v219);
    end;
    local v220 = l__sub__5(p208, 13, 16);
    local v221 = 0;
    for v222 = 1, #v220 do
        v221 = v221 * 256 + l__byte__2(v220, v222);
    end;
    return v209(v212, v211, v215, v218, v221);
end;
function u1.sum(p223) --[[ Line: 419 ]]
    -- upvalues: u1 (copy)
    return u1.new():update(p223):finish();
end;
function u1.sumhexa(p224) --[[ Line: 423 ]]
    -- upvalues: u1 (copy)
    return u1.tohex(u1.sum(p224));
end;
return u1;
