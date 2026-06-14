-- Decompiled from: ReplicatedStorage.Modules.Mince.inspect
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = nil;
local v2;
if (tonumber((_VERSION or ""):match("[%d.]*$")) or 0) < 5.3 then
    local v3;
    v3, v2 = pcall(require, "compat53.module");
    if not v3 then
        v2 = v1;
    end;
else
    v2 = v1;
end;
local u4 = v2 and v2.math or math;
local v5 = v2 and v2.string or string;
local u6 = v2 and v2.table or table;
local u7 = {
    Options = {},
    _VERSION = "inspect.lua 3.1.0",
    _URL = "http://github.com/kikito/inspect.lua",
    _DESCRIPTION = "human-readable representations of tables",
    _LICENSE = "  MIT LICENSE\n\n  Copyright (c) 2022 Enrique García Cota\n\n  Permission is hereby granted, free of charge, to any person obtaining a\n  copy of this software and associated documentation files (the\n  \"Software\"), to deal in the Software without restriction, including\n  without limitation the rights to use, copy, modify, merge, publish,\n  distribute, sublicense, and/or sell copies of the Software, and to\n  permit persons to whom the Software is furnished to do so, subject to\n  the following conditions:\n\n  The above copyright notice and this permission notice shall be included\n  in all copies or substantial portions of the Software.\n\n  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n",
    KEY = setmetatable({}, {
        __tostring = function() --[[ Name: __tostring, Line 47 ]]
            return "inspect.KEY";
        end
    }),
    METATABLE = setmetatable({}, {
        __tostring = function() --[[ Name: __tostring, Line 48 ]]
            return "inspect.METATABLE";
        end
    })
};
local u8 = tostring;
local l__rep__1 = v5.rep;
local l__match__2 = v5.match;
local l__char__3 = v5.char;
local l__gsub__4 = v5.gsub;
local l__format__5 = v5.format;
local u11 = not rawget and function(p9, p10) --[[ Line: 61 ]]
    return p9[p10];
end or rawget;
local u12 = {
    ["\7"] = "\\a",
    ["\8"] = "\\b",
    ["\f"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
    ["\11"] = "\\v",
    ["\127"] = "\\127"
};
local u13 = {
    ["\127"] = "\127"
};
for v14 = 0, 31 do
    local v15 = l__char__3(v14);
    if not u12[v15] then
        u12[v15] = "\\" .. v14;
        u13[v15] = l__format__5("\\%03d", v14);
    end;
end;
local u16 = {
    ["and"] = true,
    ["break"] = true,
    ["do"] = true,
    ["else"] = true,
    ["elseif"] = true,
    ["end"] = true,
    ["false"] = true,
    ["for"] = true,
    ["function"] = true,
    goto = true,
    ["if"] = true,
    ["in"] = true,
    ["local"] = true,
    ["nil"] = true,
    ["not"] = true,
    ["or"] = true,
    ["repeat"] = true,
    ["return"] = true,
    ["then"] = true,
    ["true"] = true,
    ["until"] = true,
    ["while"] = true
};
local l__floor__6 = u4.floor;
local u17 = {
    number = 1,
    boolean = 2,
    string = 3,
    table = 4,
    ["function"] = 5,
    userdata = 6,
    thread = 7
};
local function u24(p18, p19) --[[ Line: 141 ]]
    -- upvalues: u17 (copy)
    local v20 = type(p18);
    local v21 = type(p19);
    if v20 == v21 and (v20 == "string" or v20 == "number") then
        return p18 < p19;
    end;
    local v22 = u17[v20] or 100;
    local v23 = u17[v21] or 100;
    return v22 == v23 and v20 < v21 and true or v22 < v23;
end;
local function u32(p25) --[[ Line: 156 ]]
    -- upvalues: u11 (ref), l__floor__6 (copy), u6 (copy), u24 (copy)
    local v26 = 1;
    while u11(p25, v26) ~= nil do
        v26 = v26 + 1;
    end;
    local v27 = v26 - 1;
    local v28 = 0;
    local v29 = {};
    for v30 in next, p25 do
        local v31;
        if type(v30) == "number" and (l__floor__6(v30) == v30 and v30 >= 1) then
            v31 = v30 <= v27;
        else
            v31 = false;
        end;
        if not v31 then
            v28 = v28 + 1;
            v29[v28] = v30;
        end;
    end;
    u6.sort(v29, u24);
    return v29, v28, v27;
end;
local function u37(p33, p34) --[[ Line: 175 ]]
    -- upvalues: u37 (copy)
    if type(p33) == "table" then
        if p34[p33] then
            p34[p33] = p34[p33] + 1;
            return;
        end;
        p34[p33] = 1;
        for v35, v36 in next, p33 do
            u37(v35, p34);
            u37(v36, p34);
        end;
        u37(getmetatable(p33), p34);
    end;
end;
local function u65(p38, p39, p40, p41) --[[ Line: 202 ]]
    -- upvalues: u65 (copy), u7 (copy)
    if p39 == nil then
        return nil;
    end;
    if p41[p39] then
        return p41[p39];
    end;
    local v42 = p38(p39, p40);
    local v43;
    if type(v42) == "table" then
        v43 = {};
        p41[p39] = v43;
        for v44, v45 in next, v42 do
            local v46 = u65;
            local l__KEY__7 = u7.KEY;
            local v47 = #p40;
            local v48 = p38;
            local v49 = v44;
            local v50 = {};
            for v51 = 1, v47 do
                v50[v51] = p40[v51];
            end;
            v50[v47 + 1] = v44;
            v50[v47 + 2] = l__KEY__7;
            local v52 = v46(p38, v49, v50, p41);
            if v52 == nil then
                p38 = v48;
            else
                local v53 = u65;
                local v54 = #p40;
                local v55 = v48;
                local v56 = v52;
                local v57 = {};
                for v58 = 1, v54 do
                    v57[v58] = p40[v58];
                end;
                v57[v54 + 1] = v56;
                v57[v54 + 2] = nil;
                v43[v52] = v53(v55, v45, v57, p41);
                p38 = v48;
            end;
        end;
        local v59 = u65;
        local v60 = getmetatable(v42);
        local l__METATABLE__8 = u7.METATABLE;
        local v61 = #p40;
        local v62 = {};
        for v63 = 1, v61 do
            v62[v63] = p40[v63];
        end;
        v62[v61 + 1] = l__METATABLE__8;
        v62[v61 + 2] = nil;
        local v64 = v59(p38, v60, v62, p41);
        if type(v64) ~= "table" then
            v64 = nil;
        end;
        setmetatable(v43, v64);
    else
        v43 = v42;
    end;
    return v43;
end;
local v66 = {};
local u67 = {
    __index = v66
};
function v66.getId(p68, p69) --[[ Line: 254 ]]
    -- upvalues: u8 (copy)
    local v70 = p68.ids[p69];
    local l__ids__9 = p68.ids;
    if not v70 then
        local v71 = type(p69);
        v70 = (l__ids__9[v71] or 0) + 1;
        l__ids__9[p69] = v70;
        l__ids__9[v71] = v70;
    end;
    return u8(v70);
end;
function v66.putValue(p72, p73) --[[ Line: 265 ]]
    -- upvalues: l__gsub__4 (copy), u13 (copy), u12 (copy), l__match__2 (copy), u8 (copy), u7 (copy), l__format__5 (copy), u32 (copy), l__rep__1 (copy), u16 (copy)
    local l__buf__10 = p72.buf;
    local v74 = type(p73);
    if v74 == "string" then
        local v75 = l__gsub__4(l__gsub__4(l__gsub__4(p73, "\\", "\\\\"), "(%c)%f[0-9]", u13), "%c", u12);
        local v76;
        if l__match__2(v75, "\"") and not l__match__2(v75, "\'") then
            v76 = "\'" .. v75 .. "\'";
        else
            v76 = "\"" .. l__gsub__4(v75, "\"", "\\\"") .. "\"";
        end;
        l__buf__10.n = l__buf__10.n + 1;
        l__buf__10[l__buf__10.n] = v76;
    elseif v74 == "number" or (v74 == "boolean" or (v74 == "nil" or (v74 == "cdata" or v74 == "ctype"))) then
        local v77 = u8(p73);
        l__buf__10.n = l__buf__10.n + 1;
        l__buf__10[l__buf__10.n] = v77;
    elseif v74 == "table" and not p72.ids[p73] then
        if p73 == u7.KEY or p73 == u7.METATABLE then
            local v78 = u8(p73);
            l__buf__10.n = l__buf__10.n + 1;
            l__buf__10[l__buf__10.n] = v78;
        elseif p72.level >= p72.depth then
            l__buf__10.n = l__buf__10.n + 1;
            l__buf__10[l__buf__10.n] = "{...}";
        else
            if p72.cycles[p73] > 1 then
                local v79 = l__format__5("<%d>", p72:getId(p73));
                l__buf__10.n = l__buf__10.n + 1;
                l__buf__10[l__buf__10.n] = v79;
            end;
            local v80, v81, v82 = u32(p73);
            l__buf__10.n = l__buf__10.n + 1;
            l__buf__10[l__buf__10.n] = "{";
            p72.level = p72.level + 1;
            for v83 = 1, v82 + v81 do
                if v83 > 1 then
                    l__buf__10.n = l__buf__10.n + 1;
                    l__buf__10[l__buf__10.n] = ",";
                end;
                if v83 <= v82 then
                    l__buf__10.n = l__buf__10.n + 1;
                    l__buf__10[l__buf__10.n] = " ";
                    p72:putValue(p73[v83]);
                else
                    local v84 = v80[v83 - v82];
                    local l__buf__11 = p72.buf;
                    local v85 = p72.newline .. l__rep__1(p72.indent, p72.level);
                    l__buf__11.n = l__buf__11.n + 1;
                    l__buf__11[l__buf__11.n] = v85;
                    local v86;
                    if type(v84) == "string" then
                        v86 = v84:match("^[_%a][_%a%d]*$") and true or false;
                        if v86 then
                            v86 = not u16[v84];
                        end;
                    else
                        v86 = false;
                    end;
                    if v86 then
                        l__buf__10.n = l__buf__10.n + 1;
                        l__buf__10[l__buf__10.n] = v84;
                    else
                        l__buf__10.n = l__buf__10.n + 1;
                        l__buf__10[l__buf__10.n] = "[";
                        p72:putValue(v84);
                        l__buf__10.n = l__buf__10.n + 1;
                        l__buf__10[l__buf__10.n] = "]";
                    end;
                    l__buf__10.n = l__buf__10.n + 1;
                    l__buf__10[l__buf__10.n] = " = ";
                    p72:putValue(p73[v84]);
                end;
            end;
            local v87 = getmetatable(p73);
            if type(v87) == "table" then
                if v82 + v81 > 0 then
                    l__buf__10.n = l__buf__10.n + 1;
                    l__buf__10[l__buf__10.n] = ",";
                end;
                local l__buf__12 = p72.buf;
                local v88 = p72.newline .. l__rep__1(p72.indent, p72.level);
                l__buf__12.n = l__buf__12.n + 1;
                l__buf__12[l__buf__12.n] = v88;
                l__buf__10.n = l__buf__10.n + 1;
                l__buf__10[l__buf__10.n] = "<metatable> = ";
                p72:putValue(v87);
            end;
            p72.level = p72.level - 1;
            if v81 > 0 or type(v87) == "table" then
                local l__buf__13 = p72.buf;
                local v89 = p72.newline .. l__rep__1(p72.indent, p72.level);
                l__buf__13.n = l__buf__13.n + 1;
                l__buf__13[l__buf__13.n] = v89;
            elseif v82 > 0 then
                l__buf__10.n = l__buf__10.n + 1;
                l__buf__10[l__buf__10.n] = " ";
            end;
            l__buf__10.n = l__buf__10.n + 1;
            l__buf__10[l__buf__10.n] = "}";
        end;
    else
        local v90 = l__format__5("<%s %d>", v74, p72:getId(p73));
        l__buf__10.n = l__buf__10.n + 1;
        l__buf__10[l__buf__10.n] = v90;
    end;
end;
function u7.inspect(p91, p92) --[[ Line: 335 ]]
    -- upvalues: u4 (copy), u65 (copy), u37 (copy), u67 (copy), u6 (copy)
    local v93 = p92 or {};
    local v94 = v93.depth or u4.huge;
    local v95 = v93.newline or "\n";
    local v96 = v93.indent or "  ";
    local l__process__14 = v93.process;
    if l__process__14 then
        p91 = u65(l__process__14, p91, {}, {});
    end;
    local v97 = {};
    u37(p91, v97);
    local v98 = setmetatable({
        level = 0,
        buf = {
            n = 0
        },
        ids = {},
        cycles = v97,
        depth = v94,
        newline = v95,
        indent = v96
    }, u67);
    v98:putValue(p91);
    return u6.concat(v98.buf);
end;
setmetatable(u7, {
    __call = function(_, p99, p100) --[[ Name: __call, Line 366 ]]
        -- upvalues: u7 (copy)
        return u7.inspect(p99, p100);
    end
});
return u7;
