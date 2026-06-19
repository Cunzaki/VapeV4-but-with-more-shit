-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = type;
local u3 = tostring;
local u4 = u3((0 / 0));
local l__floor__1 = math.floor;
local l__frexp__2 = math.frexp;
local l__byte__3 = string.byte;
local l__char__4 = string.char;
local l__concat__5 = table.concat;
local l__yield__6 = coroutine.yield;
local l__obtain__7 = _G.obtain;
local v5 = l__obtain__7("bitstream");
local l__newbitwriter__8 = v5.newbitwriter;
local l__newbitreader__9 = v5.newbitreader;
local l__comp48__10 = v5.comp48;
local l__decomp48__11 = v5.decomp48;
local l__AddJob__12 = l__obtain__7("coProcessor").AddJob;
function v1.serialize(p6) --[[ Line: 30 ]]
    -- upvalues: l__newbitwriter__8 (copy), l__frexp__2 (copy), u2 (copy), u3 (copy), u4 (copy), l__floor__1 (copy), l__decomp48__11 (copy), l__byte__3 (copy)
    local u7, v8 = l__newbitwriter__8();
    local u9 = 0;
    local u10 = {};
    local u11 = {};
    local u12 = 0;
    local u13 = {};
    local function u34(p14) --[[ Line: 37 ]]
        -- upvalues: u10 (copy), u7 (copy), l__frexp__2 (ref), u2 (ref), u3 (ref), u4 (ref), u9 (ref), l__floor__1 (ref), l__decomp48__11 (ref), l__byte__3 (ref), u34 (copy), u13 (copy), u12 (ref), u11 (copy)
        local v15 = u10[p14];
        if v15 then
            u7(3, 0);
            local _, v16 = l__frexp__2(v15);
            u7(5, v16);
            u7(v16, v15);
        else
            local v17 = u2(p14);
            if v17 == "nil" then
                u7(3, 2);
            elseif v17 == "boolean" then
                u7(3, 3);
                u7(1, p14 and 1 or 0);
            elseif v17 == "number" then
                if p14 % 1 == 0 and (p14 > -2147483648 and p14 < 2147483648) then
                    u7(3, 4);
                    local _, v18 = l__frexp__2(p14);
                    u7(5, v18);
                    if p14 < 0 then
                        u7(1, 1);
                        u7(v18, -p14);
                    else
                        u7(1, 0);
                        u7(v18, p14);
                    end;
                else
                    u7(3, 5);
                    if p14 == p14 then
                        if p14 < 0 then
                            u7(1, 1);
                            p14 = -p14;
                        else
                            u7(1, 0);
                        end;
                        if p14 == (1 / 0) then
                            u7(11, 2047);
                            u7(52, 0);
                        elseif p14 < 2.2250738585072014e-308 then
                            u7(11, 0);
                            u7(52, p14 * 4.49423283715579e307 * 4503599627370496);
                        else
                            local v19, v20 = l__frexp__2(p14);
                            u7(11, v20 + 1022);
                            u7(52, (v19 * 2 - 1) * 4503599627370496);
                        end;
                    else
                        u7(1, 0);
                        u7(11, 2047);
                        if u3(p14) == u4 then
                            u7(52, 1);
                        else
                            u7(52, 2);
                        end;
                    end;
                end;
            elseif v17 == "string" then
                u9 = u9 + 1;
                u10[p14] = u9;
                u7(3, 6);
                local v21 = #p14;
                if v21 >= 2147483648 then
                    error("string must be less than 2 gigabytes. Sorry! :(");
                end;
                local _, v22 = l__frexp__2(v21);
                u7(5, v22);
                u7(v22, v21);
                local v23 = l__floor__1(v21 / 6);
                for v24 = 1, v23 do
                    u7(48, l__decomp48__11(p14, v24));
                end;
                for v25 = v23 * 6 + 1, v21 do
                    u7(8, l__byte__3(p14, v25));
                end;
            elseif v17 == "table" then
                u9 = u9 + 1;
                u10[p14] = u9;
                u7(3, 7);
                local v26 = 0;
                while p14[v26 + 1] do
                    v26 = v26 + 1;
                end;
                local v27 = -v26;
                for _ in next, p14 do
                    v27 = v27 + 1;
                end;
                local _, v28 = l__frexp__2(v26);
                local _, v29 = l__frexp__2(v27);
                u7(5, v28);
                u7(v28, v26);
                u7(5, v29);
                u7(v29, v27);
                for v30 = 1, v26 do
                    u34(p14[v30]);
                end;
                for v31, v32 in next, p14 do
                    if u2(v31) ~= "number" or (v31 % 1 ~= 0 or (v31 < 1 or v26 < v31)) then
                        u34(v31);
                        u34(v32);
                    end;
                end;
            else
                if not u13[p14] then
                    u12 = u12 + 1;
                    u11[u12] = p14;
                    u13[p14] = u12;
                end;
                local _, v33 = l__frexp__2(u13[p14]);
                u7(3, 1);
                u7(5, v33);
                u7(v33, u13[p14]);
            end;
        end;
    end;
    u34(p6);
    return v8(), u11;
end;
function v1.deserialize(p35, u36) --[[ Line: 164 ]]
    -- upvalues: l__newbitreader__9 (copy), l__floor__1 (copy), l__comp48__10 (copy), l__char__4 (copy), l__concat__5 (copy)
    local u37 = l__newbitreader__9(p35);
    local u38 = 0;
    local u39 = {};
    local function u56() --[[ Line: 169 ]]
        -- upvalues: u37 (copy), u39 (copy), u36 (copy), l__floor__1 (ref), l__comp48__10 (ref), l__char__4 (ref), l__concat__5 (ref), u38 (ref), u56 (copy)
        local v40 = u37(3);
        if v40 == 0 then
            return u39[u37(u37(5))];
        elseif v40 == 1 then
            return u36[u37(u37(5))];
        elseif v40 == 2 then
            return nil;
        elseif v40 == 3 then
            return u37(1) == 1;
        elseif v40 == 4 then
            local v41 = u37(5);
            if u37(1) == 0 then
                return u37(v41);
            else
                return -u37(v41);
            end;
        elseif v40 == 5 then
            local v42 = u37(1);
            local v43 = u37(11);
            local v44 = u37(52);
            local v45 = v42 == 0 and 1 or -1;
            if v43 == 2047 then
                return v44 ~= 0 and (v44 == 1 and (0 / 0) or (0 / 0)) or v45 / 0;
            elseif v43 == 0 then
                return v45 * v44 * 0;
            else
                return v45 * (v44 / 4503599627370496 + 1) * 2 ^ (v43 - 1023);
            end;
        else
            if v40 == 6 then
                local v46 = u37(u37(5));
                local v47 = l__floor__1(v46 / 6);
                local v48 = {};
                for v49 = 1, v47 do
                    v48[v49] = l__comp48__10(u37(48));
                end;
                for v50 = 1, v46 - v47 * 6 do
                    v48[v47 + v50] = l__char__4(u37(8));
                end;
                local v51 = l__concat__5(v48);
                u38 = u38 + 1;
                u39[u38] = v51;
                return v51;
            end;
            if v40 == 7 then
                local v52 = u37(u37(5));
                local v53 = u37(u37(5));
                local v54 = {};
                u38 = u38 + 1;
                u39[u38] = v54;
                for v55 = 1, v52 do
                    v54[v55] = u56();
                end;
                for _ = 1, v53 do
                    v54[u56()] = u56();
                end;
                return v54;
            end;
            error("Invalid datatype");
        end;
    end;
    return u56();
end;
function v1.serializec(u57, p58, p59) --[[ Line: 239 ]]
    -- upvalues: l__newbitwriter__8 (copy), l__yield__6 (copy), l__frexp__2 (copy), u2 (copy), u3 (copy), u4 (copy), l__floor__1 (copy), l__decomp48__11 (copy), l__byte__3 (copy), l__AddJob__12 (copy)
    local u60, u61 = l__newbitwriter__8();
    local u62 = 0;
    local u63 = {};
    local u64 = {};
    local u65 = 0;
    local u66 = {};
    local u67 = 0;
    local u68 = p58 or 10000;
    local function u89(p69) --[[ Line: 248 ]]
        -- upvalues: u67 (ref), u68 (ref), l__yield__6 (ref), u63 (copy), u60 (copy), l__frexp__2 (ref), u2 (ref), u3 (ref), u4 (ref), u62 (ref), l__floor__1 (ref), l__decomp48__11 (ref), l__byte__3 (ref), u89 (copy), u66 (copy), u65 (ref), u64 (copy)
        u67 = u67 + 1;
        if u67 == u68 then
            u67 = 0;
            l__yield__6();
        end;
        local v70 = u63[p69];
        if v70 then
            u60(3, 0);
            local _, v71 = l__frexp__2(v70);
            u60(5, v71);
            u60(v71, v70);
        else
            local v72 = u2(p69);
            if v72 == "nil" then
                u60(3, 2);
            elseif v72 == "boolean" then
                u60(3, 3);
                u60(1, p69 and 1 or 0);
            elseif v72 == "number" then
                if p69 % 1 == 0 and (p69 > -2147483648 and p69 < 2147483648) then
                    u60(3, 4);
                    local _, v73 = l__frexp__2(p69);
                    u60(5, v73);
                    if p69 < 0 then
                        u60(1, 1);
                        u60(v73, -p69);
                    else
                        u60(1, 0);
                        u60(v73, p69);
                    end;
                else
                    u60(3, 5);
                    if p69 == p69 then
                        if p69 < 0 then
                            u60(1, 1);
                            p69 = -p69;
                        else
                            u60(1, 0);
                        end;
                        if p69 == (1 / 0) then
                            u60(11, 2047);
                            u60(52, 0);
                        elseif p69 < 2.2250738585072014e-308 then
                            u60(11, 0);
                            u60(52, p69 * 4.49423283715579e307 * 4503599627370496);
                        else
                            local v74, v75 = l__frexp__2(p69);
                            u60(11, v75 + 1022);
                            u60(52, (v74 * 2 - 1) * 4503599627370496);
                        end;
                    else
                        u60(1, 0);
                        u60(11, 2047);
                        if u3(p69) == u4 then
                            u60(52, 1);
                        else
                            u60(52, 2);
                        end;
                    end;
                end;
            elseif v72 == "string" then
                u62 = u62 + 1;
                u63[p69] = u62;
                u60(3, 6);
                local v76 = #p69;
                if v76 >= 2147483648 then
                    error("string must be less than 2 gigabytes. Sorry! :(");
                end;
                local _, v77 = l__frexp__2(v76);
                u60(5, v77);
                u60(v77, v76);
                local v78 = l__floor__1(v76 / 6);
                for v79 = 1, v78 do
                    u60(48, l__decomp48__11(p69, v79));
                end;
                for v80 = v78 * 6 + 1, v76 do
                    u60(8, l__byte__3(p69, v80));
                end;
            elseif v72 == "table" then
                u62 = u62 + 1;
                u63[p69] = u62;
                u60(3, 7);
                local v81 = 0;
                while p69[v81 + 1] do
                    v81 = v81 + 1;
                end;
                local v82 = -v81;
                for _ in next, p69 do
                    v82 = v82 + 1;
                end;
                local _, v83 = l__frexp__2(v81);
                local _, v84 = l__frexp__2(v82);
                u60(5, v83);
                u60(v83, v81);
                u60(5, v84);
                u60(v84, v82);
                for v85 = 1, v81 do
                    u89(p69[v85]);
                end;
                for v86, v87 in next, p69 do
                    if u2(v86) ~= "number" or (v86 % 1 ~= 0 or (v86 < 1 or v81 < v86)) then
                        u89(v86);
                        u89(v87);
                    end;
                end;
            else
                if not u66[p69] then
                    u65 = u65 + 1;
                    u64[u65] = p69;
                    u66[p69] = u65;
                end;
                local _, v88 = l__frexp__2(u66[p69]);
                u60(3, 1);
                u60(5, v88);
                u60(v88, u66[p69]);
            end;
        end;
    end;
    l__AddJob__12(function() --[[ Line: 370 ]]
        -- upvalues: u57 (copy), u61 (copy), u64 (copy)
        u57(u61(), u64);
    end, u89, p59);
end;
function v1.deserializec(p90, p91, p92, u93) --[[ Line: 375 ]]
    -- upvalues: l__newbitreader__9 (copy), l__yield__6 (copy), l__floor__1 (copy), l__comp48__10 (copy), l__char__4 (copy), l__concat__5 (copy), l__AddJob__12 (copy)
    local u94 = l__newbitreader__9(p92);
    local u95 = 0;
    local u96 = {};
    local u97 = 0;
    local u98 = p91 or 10000;
    local function u115() --[[ Line: 382 ]]
        -- upvalues: u97 (ref), u98 (ref), l__yield__6 (ref), u94 (copy), u96 (copy), u93 (copy), l__floor__1 (ref), l__comp48__10 (ref), l__char__4 (ref), l__concat__5 (ref), u95 (ref), u115 (copy)
        u97 = u97 + 1;
        if u97 == u98 then
            u97 = 0;
            l__yield__6();
        end;
        local v99 = u94(3);
        if v99 == 0 then
            return u96[u94(u94(5))];
        elseif v99 == 1 then
            return u93[u94(u94(5))];
        elseif v99 == 2 then
            return nil;
        elseif v99 == 3 then
            return u94(1) == 1;
        elseif v99 == 4 then
            local v100 = u94(5);
            if u94(1) == 0 then
                return u94(v100);
            else
                return -u94(v100);
            end;
        elseif v99 == 5 then
            local v101 = u94(1);
            local v102 = u94(11);
            local v103 = u94(52);
            local v104 = v101 == 0 and 1 or -1;
            if v102 == 2047 then
                return v103 ~= 0 and (v103 == 1 and (0 / 0) or (0 / 0)) or v104 / 0;
            elseif v102 == 0 then
                return v104 * v103 * 0;
            else
                return v104 * (v103 / 4503599627370496 + 1) * 2 ^ (v102 - 1023);
            end;
        else
            if v99 == 6 then
                local v105 = u94(u94(5));
                local v106 = l__floor__1(v105 / 6);
                local v107 = {};
                for v108 = 1, v106 do
                    v107[v108] = l__comp48__10(u94(48));
                end;
                for v109 = 1, v105 - v106 * 6 do
                    v107[v106 + v109] = l__char__4(u94(8));
                end;
                local v110 = l__concat__5(v107);
                u95 = u95 + 1;
                u96[u95] = v110;
                return v110;
            end;
            if v99 == 7 then
                local v111 = u94(u94(5));
                local v112 = u94(u94(5));
                local v113 = {};
                u95 = u95 + 1;
                u96[u95] = v113;
                for v114 = 1, v111 do
                    v113[v114] = u115();
                end;
                for _ = 1, v112 do
                    v113[u115()] = u115();
                end;
                return v113;
            end;
            error("Invalid datatype");
        end;
    end;
    l__AddJob__12(p90, u115);
end;
return v1;
