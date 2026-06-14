-- Decompiled from: ReplicatedStorage.Modules.LTCS
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = { 33, 126 };
local _ = u1[2] - u1[1];
local u2 = "";
for v3 = u1[1], u1[2] do
    u2 = u2 .. string.char(v3);
end;
local l__floor__1 = math.floor;
local l__insert__2 = table.insert;
function encode(p4)
    -- upvalues: l__floor__1 (copy), u2 (ref), l__insert__2 (copy)
    local v5 = l__floor__1(p4);
    local v6 = string.len(u2);
    local v7 = {};
    repeat
        local v8 = v5 % v6 + 1;
        v5 = l__floor__1(v5 / v6);
        l__insert__2(v7, 1, u2:sub(v8, v8));
    until v5 == 0;
    return table.concat(v7, "");
end;
function decode(p9)
    -- upvalues: u2 (ref), u1 (copy), l__floor__1 (copy)
    local v10 = #p9;
    local v11 = string.len(u2);
    local v12 = 0;
    local v13 = 0;
    while true do
        local v14 = string.byte(p9:sub(v10, v10)) - u1[1];
        if v12 > 0 then
            v14 = v14 * v11 ^ v12;
        end;
        v13 = v13 + v14;
        v10 = v10 - 1;
        v12 = v12 + 1;
        if v10 == 0 then
            return l__floor__1(v13);
        end;
    end;
end;
local u15 = {};
local u16 = {};
for v17 = 1, 91 do
    u15[v17 - 1] = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v17, v17);
    u16[string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v17, v17)] = v17 - 1;
end;
local function u27(p18) --[[ Line: 40 ]]
    -- upvalues: u15 (copy)
    local v19 = 0;
    local v20 = 0;
    local v21 = {};
    local v22 = 1;
    for v23 = 1, #p18 do
        local v24 = string.byte(p18, v23);
        local v25 = bit32.lshift(v24, v19);
        v20 = bit32.bor(v20, v25);
        v19 = v19 + 8;
        if v19 > 13 then
            local v26 = bit32.band(v20, 8191);
            if v26 > 88 then
                v20 = bit32.rshift(v20, 13);
                v19 = v19 - 13;
            else
                v26 = bit32.band(v20, 16383);
                v20 = bit32.rshift(v20, 14);
                v19 = v19 - 14;
            end;
            v21[v22] = u15[v26 % 91] .. u15[math.floor(v26 / 91)];
            v22 = v22 + 1;
        end;
    end;
    if v19 > 0 then
        v21[v22] = u15[v20 % 91];
        if v19 > 7 or v20 > 90 then
            v21[v22 + 1] = u15[math.floor(v20 / 91)];
        end;
    end;
    return table.concat(v21);
end;
local function u39(p28) --[[ Line: 74 ]]
    -- upvalues: u16 (copy)
    local v29 = 1;
    local v30 = -1;
    local v31 = 0;
    local v32 = 0;
    local v33 = {};
    for v34 = 1, #p28 do
        if u16[string.sub(p28, v34, v34)] then
            if v30 == -1 then
                v30 = u16[string.sub(p28, v34, v34)];
            else
                local v35 = v30 + u16[string.sub(p28, v34, v34)] * 91;
                local v36 = bit32.lshift(v35, v31);
                v32 = bit32.bor(v32, v36);
                if bit32.band(v35, 8191) > 88 then
                    v31 = v31 + 13;
                else
                    v31 = v31 + 14;
                end;
                while v31 > 7 do
                    v33[v29] = string.char(v32 % 256);
                    v29 = v29 + 1;
                    v32 = bit32.rshift(v32, 8);
                    v31 = v31 - 8;
                end;
                v30 = -1;
            end;
        end;
    end;
    if v30 ~= -1 then
        local v37 = bit32.lshift(v30, v31);
        local v38 = bit32.bor(v32, v37) % 256;
        v33[v29] = string.char(v38);
    end;
    return table.concat(v33);
end;
local u41 = {
    _VERSION = 0.36,
    SpecialChars = ",^*#\"?{}",
    EscapeCharacter = "\\",
    Indents = {
        "Ordered",
        "NumberHash",
        "NumberSmall",
        "Number",
        "String",
        "Bool",
        "Table",
        "TableAnchor"
    },
    IdentsToChar = {},
    CharToIdents = {},
    Cast = {},
    Vert = {},
    EscapeGsub = function(p40) --[[ Name: EscapeGsub, Line 127 ]]
        return p40:gsub("%%", "%%%%"):gsub("^%^", "%%^"):gsub("%$$", "%%$"):gsub("%(", "%%("):gsub("%)", "%%)"):gsub("%.", "%%."):gsub("%[", "%%["):gsub("%]", "%%]"):gsub("%*", "%%*"):gsub("%+", "%%+"):gsub("%-", "%%-"):gsub("%?", "%%?");
    end
};
function u41.EscapeAllIdents(p42) --[[ Line: 130 ]]
    -- upvalues: u41 (copy)
    for v43 = 1, #u41.Indents do
        local v44 = u41.SpecialChars:sub(v43, v43);
        p42 = p42:gsub(u41.EscapeGsub(v44), u41.EscapeGsub("\\" .. v44));
    end;
    return p42;
end;
function u41.EscapeStringableIdents(p45) --[[ Line: 138 ]]
    -- upvalues: u41 (copy)
    local v46 = p45:gsub(u41.EscapeGsub(u41.EscapeCharacter), u41.EscapeGsub(string.rep(u41.EscapeCharacter, 2)));
    local v47 = { "String", "Table", "TableAnchor" };
    for v48 = 1, #v47 do
        local v49 = u41.IdentsToChar[v47[v48]];
        v46 = v46:gsub(u41.EscapeGsub(v49), u41.EscapeGsub("\\" .. v49));
    end;
    return v46;
end;
function u41.EscapeSymbol(p50, p51) --[[ Line: 150 ]]
    -- upvalues: u41 (copy)
    local v52 = u41.IdentsToChar[p51];
    return p50:gsub(u41.EscapeGsub(v52), u41.EscapeGsub("\\" .. v52));
end;
function u41.DescapeSymbol(p53, p54) --[[ Line: 156 ]]
    -- upvalues: u41 (copy)
    local v55 = u41.IdentsToChar[p54];
    return p53:gsub(u41.EscapeGsub("\\" .. v55), u41.EscapeGsub(v55));
end;
function u41.DescapeStringableIdents(p56, _) --[[ Line: 162 ]]
    -- upvalues: u41 (copy)
    local v57 = p56:gsub(u41.EscapeGsub(string.rep(u41.EscapeCharacter, 2)), u41.EscapeGsub(u41.EscapeCharacter));
    local v58 = { "String", "Table", "TableAnchor" };
    for v59 = 1, #v58 do
        local v60 = u41.IdentsToChar[v58[v59]];
        v57 = v57:gsub(u41.EscapeGsub("\\" .. v60), u41.EscapeGsub(v60));
    end;
    return v57;
end;
function u41.AssignIdents() --[[ Line: 175 ]]
    -- upvalues: u41 (copy)
    for v61 = 1, #u41.Indents do
        local v62 = u41.Indents[v61];
        local v63 = u41.SpecialChars:sub(v61, v61);
        u41.IdentsToChar[v62] = v63;
        u41.CharToIdents[v63] = v62;
    end;
end;
function u41.GenerateValue(p64, p65) --[[ Line: 183 ]]
    -- upvalues: u41 (copy)
    local v66 = u41.Cast[p65];
    if v66 then
        return v66(p64, p65);
    end;
end;
function u41.ConvertValue(p67, p68, p69) --[[ Line: 190 ]]
    -- upvalues: u41 (copy)
    local v70 = u41.Vert[p68];
    if v70 then
        return v70(p67, p68, p69);
    end;
end;
function u41.GetMember(p71) --[[ Line: 197 ]]
    -- upvalues: u41 (copy)
    return u41.CharToIdents[p71];
end;
function u41.Encode(p72, _) --[[ Line: 202 ]]
    -- upvalues: u41 (copy)
    local v73 = #p72;
    local v74 = "";
    local v75 = false;
    for _, v76 in ipairs(p72) do
        v75 = true;
        local v77 = u41.GenerateValue(v76, (type(v76)));
        if v77 then
            v74 = v74 .. u41.IdentsToChar.Ordered .. v77;
        end;
    end;
    for v78, v79 in pairs(p72) do
        local v80 = type(v78);
        local v81 = u41.GenerateValue(v78, v75 and (v80 == "number" and v78 <= v73) and "Invalid" or v80);
        if v81 then
            local v82 = u41.GenerateValue(v79, (type(v79)));
            if v82 then
                v74 = v74 .. v81 .. v82;
            end;
        end;
    end;
    return v74;
end;
function u41.Throw(p83, p84) --[[ Line: 232 ]]
    error(p83 .. ":~|" .. p84);
end;
function u41.ReadBase92Stream(p85, p86) --[[ Line: 236 ]]
    local v87 = p86 - 1;
    while v87 < #p85 do
        v87 = v87 + 1;
        if p85:sub(v87, v87) == " " then
            return p85:sub(p86, v87 - 1), v87 + 1;
        end;
    end;
    return p85:sub(p86, v87), v87;
end;
function u41.ReadStream(p88, p89, p90, p91, p92) --[[ Line: 247 ]]
    -- upvalues: u41 (copy)
    local v93 = p89 - 1;
    local v94 = v93 - 1;
    local v95 = 0;
    while v93 < #p88 do
        v93 = v93 + 1;
        local v96 = p88:sub(v93, v93);
        local v97 = u41.GetMember(v96);
        if v96 == u41.EscapeCharacter and v94 < v93 then
            v94 = v93 + 1;
        end;
        if v94 < v93 then
            if p92 and p90 then
                local _ = v97 == p92;
            end;
            if p90 then
                if v97 == p90 and v95 < 1 then
                    return p88:sub(p89, v93 - 1), v93;
                end;
                if v97 == p91 then
                    v95 = v95 + 1;
                end;
                if v97 == p90 then
                    v95 = v95 - 1;
                end;
            elseif v97 then
                return p88:sub(p89, v93 - 1), v93;
            end;
        end;
    end;
    return p88:sub(p89, v93), v93;
end;
function u41.Decode(p98) --[[ Line: 293 ]]
    -- upvalues: u41 (copy)
    local v99 = 1;
    local v100 = 0;
    local v101 = {};
    while v99 < #p98 - 1 do
        local v102 = p98:sub(v99, v99);
        local v103, _ = u41.GetMember(v102);
        local v104 = v99 + 1;
        if not v103 then
            u41.Throw(v104, "[Index]Failed to find member for " .. p98:sub(v104 - 1, v104 - 1));
        end;
        if v103 == "Ordered" then
            v100 = v100 + 1;
        end;
        local v105, v106;
        if v103 == "String" then
            local v107;
            v105, v107 = u41.ReadStream(p98, v104, "String", "Invalid");
            NewPos = v107;
            v106 = NewPos + 1;
        elseif v103 == "NumberHash" or v103 == "NumberSmall" then
            local v108;
            v105, v108 = u41.ReadBase92Stream(p98, v104);
            NewPos = v108;
            v106 = NewPos;
        elseif v103 == "Table" then
            local v109;
            v105, v109 = u41.ReadStream(p98, v104, "TableAnchor", "Table", "String");
            NewPos = v109;
            v106 = NewPos + 1;
        else
            local v110;
            v105, v110 = u41.ReadStream(p98, v104);
            NewPos = v110;
            v106 = NewPos;
        end;
        local v111 = p98:sub(v106, v106);
        local v112, _ = u41.GetMember(v111);
        local v113 = v106 + 1;
        if not v112 then
            u41.Throw(v113, "[Value]Failed to find member for " .. p98:sub(v113 - 1, v113 - 1));
        end;
        local v114;
        if v112 == "String" then
            local v115;
            v114, v115 = u41.ReadStream(p98, v113, "String", "Invalid");
            NewPos = v115;
            v99 = NewPos + 1;
        elseif v112 == "NumberHash" or v112 == "NumberSmall" then
            local v116;
            v114, v116 = u41.ReadBase92Stream(p98, v113);
            NewPos = v116;
            v99 = NewPos;
        elseif v112 == "Table" then
            local v117;
            v114, v117 = u41.ReadStream(p98, v113, "TableAnchor", "Table", "String");
            NewPos = v117;
            v99 = NewPos + 1;
        else
            local v118;
            v114, v118 = u41.ReadStream(p98, v113);
            NewPos = v118;
            v99 = NewPos;
        end;
        local v119, v120 = u41.ConvertValue(v114, v112, v100);
        if v119 == nil then
            u41.Throw(v99, "ValueData was not able to convert [" .. v112 .. "]");
        else
            v120 = u41.ConvertValue(v105, v103, v100);
            if v120 == nil then
                u41.Throw(v99, "IndexData was not able to convert [" .. v103 .. "]");
            end;
        end;
        v101[v120] = v119;
    end;
    return v101;
end;
function u41.EncodeBase91(p121) --[[ Line: 347 ]]
    -- upvalues: u27 (copy), u41 (copy)
    return u27(u41.Encode(p121));
end;
function u41.DecodeBase91(p122) --[[ Line: 351 ]]
    -- upvalues: u41 (copy), u39 (copy)
    return u41.Decode(u39(p122));
end;
u41.AssignIdents();
function u41.Cast.number(p123, _) --[[ Line: 359 ]]
    -- upvalues: u41 (copy), u27 (copy)
    if p123 == math.floor(p123) and #tostring(p123) > 2 then
        local v124 = encode(p123);
        return u41.IdentsToChar.NumberSmall .. u41.EscapeStringableIdents(v124) .. " ";
    end;
    if #tostring(p123) <= 5 then
        return u41.IdentsToChar.Number .. p123;
    end;
    local v125 = u27(string.pack("f", p123));
    return u41.IdentsToChar.NumberHash .. u41.EscapeStringableIdents(v125) .. " ";
end;
function u41.Cast.string(p126, _) --[[ Line: 374 ]]
    -- upvalues: u41 (copy)
    return u41.IdentsToChar.String .. u41.EscapeStringableIdents(p126) .. u41.IdentsToChar.String;
end;
function u41.Cast.boolean(p127, _) --[[ Line: 378 ]]
    -- upvalues: u41 (copy)
    return u41.IdentsToChar.Bool .. ({
        [true] = "1",
        [false] = "0"
    })[p127];
end;
function u41.Cast.table(p128, _) --[[ Line: 382 ]]
    -- upvalues: u41 (copy)
    return u41.IdentsToChar.Table .. u41.Encode(p128) .. u41.IdentsToChar.TableAnchor;
end;
function u41.Vert.Bool(p129, _) --[[ Line: 386 ]]
    return ({
        ["1"] = true,
        ["0"] = false
    })[p129];
end;
function u41.Vert.Number(p130, _) --[[ Line: 390 ]]
    return tonumber(p130);
end;
function u41.Vert.NumberHash(p131, _) --[[ Line: 394 ]]
    -- upvalues: u41 (copy), u39 (copy)
    local v132 = u41.DescapeStringableIdents(p131);
    return string.unpack("f", u39(v132));
end;
function u41.Vert.NumberSmall(p133, _) --[[ Line: 399 ]]
    -- upvalues: u41 (copy)
    local v134 = u41.DescapeStringableIdents(p133);
    return decode(v134);
end;
function u41.Vert.String(p135, _) --[[ Line: 404 ]]
    -- upvalues: u41 (copy)
    return u41.DescapeStringableIdents(p135);
end;
function u41.Vert.Table(p136, _) --[[ Line: 408 ]]
    -- upvalues: u41 (copy)
    return u41.Decode(p136);
end;
function u41.Vert.Ordered(_, _, p137) --[[ Line: 412 ]]
    return p137;
end;
return u41;
