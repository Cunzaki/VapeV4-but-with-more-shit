-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Packets.Packet.Types
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local v7 = {};
local v8 = {};
local v9 = {};
local u10 = {};
local u11 = {};
local function u16() --[[ Line: 85 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v12 = u4 * 8;
    u4 = u4 + 2;
    local v13 = buffer.readbits(u2, v12 + 0, 10);
    local v14 = buffer.readbits(u2, v12 + 10, 5);
    local v15 = buffer.readbits(u2, v12 + 15, 1);
    if v13 == 0 then
        if v14 == 0 then
            return 0;
        end;
        if v14 == 31 then
            return v15 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif v14 == 31 then
        return (0 / 0);
    end;
    if v15 == 0 then
        return (v13 / 1024 + 1) * 2 ^ (v14 - 15);
    else
        return -(v13 / 1024 + 1) * 2 ^ (v14 - 15);
    end;
end;
local function u22(p17) --[[ Line: 101 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v18 = u4 * 8;
    u4 = u4 + 2;
    if p17 == 0 then
        buffer.writebits(u2, v18, 16, 0);
    elseif p17 >= 65520 then
        buffer.writebits(u2, v18, 16, 31744);
    elseif p17 <= -65520 then
        buffer.writebits(u2, v18, 16, 64512);
    elseif p17 == p17 then
        local v19;
        if p17 < 0 then
            p17 = -p17;
            v19 = 1;
        else
            v19 = 0;
        end;
        local v20, v21 = math.frexp(p17);
        buffer.writebits(u2, v18 + 0, 10, v20 * 2048 - 1023.5);
        buffer.writebits(u2, v18 + 10, 5, v21 + 14);
        buffer.writebits(u2, v18 + 15, 1, v19);
    else
        buffer.writebits(u2, v18, 16, 31745);
    end;
end;
local function u27() --[[ Line: 122 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v23 = u4 * 8;
    u4 = u4 + 3;
    local v24 = buffer.readbits(u2, v23 + 0, 17);
    local v25 = buffer.readbits(u2, v23 + 17, 6);
    local v26 = buffer.readbits(u2, v23 + 23, 1);
    if v24 == 0 then
        if v25 == 0 then
            return 0;
        end;
        if v25 == 63 then
            return v26 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif v25 == 63 then
        return (0 / 0);
    end;
    if v26 == 0 then
        return (v24 / 131072 + 1) * 2 ^ (v25 - 31);
    else
        return -(v24 / 131072 + 1) * 2 ^ (v25 - 31);
    end;
end;
local function u33(p28) --[[ Line: 138 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v29 = u4 * 8;
    u4 = u4 + 3;
    if p28 == 0 then
        buffer.writebits(u2, v29, 24, 0);
    elseif p28 >= 4294959104 then
        buffer.writebits(u2, v29, 24, 8257536);
    elseif p28 <= -4294959104 then
        buffer.writebits(u2, v29, 24, 16646144);
    elseif p28 == p28 then
        local v30;
        if p28 < 0 then
            p28 = -p28;
            v30 = 1;
        else
            v30 = 0;
        end;
        local v31, v32 = math.frexp(p28);
        buffer.writebits(u2, v29 + 0, 17, v31 * 262144 - 131071.5);
        buffer.writebits(u2, v29 + 17, 6, v32 + 30);
        buffer.writebits(u2, v29 + 23, 1, v30);
    else
        buffer.writebits(u2, v29, 24, 8257537);
    end;
end;
v7.Any = "Any";
function v8.Any() --[[ Line: 162 ]]
    -- upvalues: u10 (copy), u2 (ref), u4 (ref)
    local v34 = u10;
    local v35 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return v34[v35]();
end;
function v9.Any(p36) --[[ Line: 163 ]]
    -- upvalues: u11 (copy)
    u11[typeof(p36)](p36);
end;
v7.Nil = "Nil";
function v8.Nil() --[[ Line: 166 ]]
    return nil;
end;
function v9.Nil(_) --[[ Line: 167 ]] end;
v7.NumberS8 = "NumberS8";
function v8.NumberS8() --[[ Line: 170 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v37 = buffer.readi8(u2, u4);
    u4 = u4 + 1;
    return v37;
end;
function v9.NumberS8(p38) --[[ Line: 171 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v39 = u4 + 1;
    if u3 < v39 then
        while u3 < v39 do
            u3 = u3 * 2;
        end;
        local v40 = buffer.create(u3);
        buffer.copy(v40, 0, u2, 0, u4);
        u1.Buffer = v40;
        u2 = v40;
    end;
    buffer.writei8(u2, u4, p38);
    u4 = u4 + 1;
end;
v7.NumberS16 = "NumberS16";
function v8.NumberS16() --[[ Line: 174 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v41 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return v41;
end;
function v9.NumberS16(p42) --[[ Line: 175 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v43 = u4 + 2;
    if u3 < v43 then
        while u3 < v43 do
            u3 = u3 * 2;
        end;
        local v44 = buffer.create(u3);
        buffer.copy(v44, 0, u2, 0, u4);
        u1.Buffer = v44;
        u2 = v44;
    end;
    buffer.writei16(u2, u4, p42);
    u4 = u4 + 2;
end;
v7.NumberS24 = "NumberS24";
function v8.NumberS24() --[[ Line: 178 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v45 = buffer.readbits(u2, u4 * 8, 24) - 8388608;
    u4 = u4 + 3;
    return v45;
end;
function v9.NumberS24(p46) --[[ Line: 179 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v47 = u4 + 3;
    if u3 < v47 then
        while u3 < v47 do
            u3 = u3 * 2;
        end;
        local v48 = buffer.create(u3);
        buffer.copy(v48, 0, u2, 0, u4);
        u1.Buffer = v48;
        u2 = v48;
    end;
    buffer.writebits(u2, u4 * 8, 24, p46 + 8388608);
    u4 = u4 + 3;
end;
v7.NumberS32 = "NumberS32";
function v8.NumberS32() --[[ Line: 182 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v49 = buffer.readi32(u2, u4);
    u4 = u4 + 4;
    return v49;
end;
function v9.NumberS32(p50) --[[ Line: 183 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v51 = u4 + 4;
    if u3 < v51 then
        while u3 < v51 do
            u3 = u3 * 2;
        end;
        local v52 = buffer.create(u3);
        buffer.copy(v52, 0, u2, 0, u4);
        u1.Buffer = v52;
        u2 = v52;
    end;
    buffer.writei32(u2, u4, p50);
    u4 = u4 + 4;
end;
v7.NumberU8 = "NumberU8";
function v8.NumberU8() --[[ Line: 186 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v53 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return v53;
end;
function v9.NumberU8(p54) --[[ Line: 187 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v55 = u4 + 1;
    if u3 < v55 then
        while u3 < v55 do
            u3 = u3 * 2;
        end;
        local v56 = buffer.create(u3);
        buffer.copy(v56, 0, u2, 0, u4);
        u1.Buffer = v56;
        u2 = v56;
    end;
    buffer.writeu8(u2, u4, p54);
    u4 = u4 + 1;
end;
v7.NumberU16 = "NumberU16";
function v8.NumberU16() --[[ Line: 190 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v57 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    return v57;
end;
function v9.NumberU16(p58) --[[ Line: 191 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v59 = u4 + 2;
    if u3 < v59 then
        while u3 < v59 do
            u3 = u3 * 2;
        end;
        local v60 = buffer.create(u3);
        buffer.copy(v60, 0, u2, 0, u4);
        u1.Buffer = v60;
        u2 = v60;
    end;
    buffer.writeu16(u2, u4, p58);
    u4 = u4 + 2;
end;
v7.NumberU24 = "NumberU24";
function v8.NumberU24() --[[ Line: 194 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v61 = buffer.readbits(u2, u4 * 8, 24);
    u4 = u4 + 3;
    return v61;
end;
function v9.NumberU24(p62) --[[ Line: 195 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v63 = u4 + 3;
    if u3 < v63 then
        while u3 < v63 do
            u3 = u3 * 2;
        end;
        local v64 = buffer.create(u3);
        buffer.copy(v64, 0, u2, 0, u4);
        u1.Buffer = v64;
        u2 = v64;
    end;
    buffer.writebits(u2, u4 * 8, 24, p62);
    u4 = u4 + 3;
end;
v7.NumberU32 = "NumberU32";
function v8.NumberU32() --[[ Line: 198 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v65 = buffer.readu32(u2, u4);
    u4 = u4 + 4;
    return v65;
end;
function v9.NumberU32(p66) --[[ Line: 199 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v67 = u4 + 4;
    if u3 < v67 then
        while u3 < v67 do
            u3 = u3 * 2;
        end;
        local v68 = buffer.create(u3);
        buffer.copy(v68, 0, u2, 0, u4);
        u1.Buffer = v68;
        u2 = v68;
    end;
    buffer.writeu32(u2, u4, p66);
    u4 = u4 + 4;
end;
v7.NumberF16 = "NumberF16";
function v8.NumberF16() --[[ Line: 202 ]]
    -- upvalues: u16 (copy)
    return u16();
end;
function v9.NumberF16(p69) --[[ Line: 203 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u22 (copy)
    local v70 = u4 + 2;
    if u3 < v70 then
        while u3 < v70 do
            u3 = u3 * 2;
        end;
        local v71 = buffer.create(u3);
        buffer.copy(v71, 0, u2, 0, u4);
        u1.Buffer = v71;
        u2 = v71;
    end;
    u22(p69);
end;
v7.NumberF24 = "NumberF24";
function v8.NumberF24() --[[ Line: 206 ]]
    -- upvalues: u27 (copy)
    return u27();
end;
function v9.NumberF24(p72) --[[ Line: 207 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v73 = u4 + 3;
    if u3 < v73 then
        while u3 < v73 do
            u3 = u3 * 2;
        end;
        local v74 = buffer.create(u3);
        buffer.copy(v74, 0, u2, 0, u4);
        u1.Buffer = v74;
        u2 = v74;
    end;
    u33(p72);
end;
v7.NumberF32 = "NumberF32";
function v8.NumberF32() --[[ Line: 210 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v75 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return v75;
end;
function v9.NumberF32(p76) --[[ Line: 211 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v77 = u4 + 4;
    if u3 < v77 then
        while u3 < v77 do
            u3 = u3 * 2;
        end;
        local v78 = buffer.create(u3);
        buffer.copy(v78, 0, u2, 0, u4);
        u1.Buffer = v78;
        u2 = v78;
    end;
    buffer.writef32(u2, u4, p76);
    u4 = u4 + 4;
end;
v7.NumberF64 = "NumberF64";
function v8.NumberF64() --[[ Line: 214 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v79 = buffer.readf64(u2, u4);
    u4 = u4 + 8;
    return v79;
end;
function v9.NumberF64(p80) --[[ Line: 215 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v81 = u4 + 8;
    if u3 < v81 then
        while u3 < v81 do
            u3 = u3 * 2;
        end;
        local v82 = buffer.create(u3);
        buffer.copy(v82, 0, u2, 0, u4);
        u1.Buffer = v82;
        u2 = v82;
    end;
    buffer.writef64(u2, u4, p80);
    u4 = u4 + 8;
end;
v7.String = "String";
function v8.String() --[[ Line: 218 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v83 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v84 = buffer.readstring(u2, u4, v83);
    u4 = u4 + v83;
    return v84;
end;
function v9.String(p85) --[[ Line: 219 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v86 = #p85;
    local v87 = u4 + (v86 + 1);
    if u3 < v87 then
        while u3 < v87 do
            u3 = u3 * 2;
        end;
        local v88 = buffer.create(u3);
        buffer.copy(v88, 0, u2, 0, u4);
        u1.Buffer = v88;
        u2 = v88;
    end;
    buffer.writeu8(u2, u4, v86);
    u4 = u4 + 1;
    buffer.writestring(u2, u4, p85);
    u4 = u4 + #p85;
end;
v7.StringLong = "StringLong";
function v8.StringLong() --[[ Line: 222 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v89 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v90 = buffer.readstring(u2, u4, v89);
    u4 = u4 + v89;
    return v90;
end;
function v9.StringLong(p91) --[[ Line: 223 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v92 = #p91;
    local v93 = u4 + (v92 + 2);
    if u3 < v93 then
        while u3 < v93 do
            u3 = u3 * 2;
        end;
        local v94 = buffer.create(u3);
        buffer.copy(v94, 0, u2, 0, u4);
        u1.Buffer = v94;
        u2 = v94;
    end;
    buffer.writeu16(u2, u4, v92);
    u4 = u4 + 2;
    buffer.writestring(u2, u4, p91);
    u4 = u4 + #p91;
end;
v7.Buffer = "Buffer";
function v8.Buffer() --[[ Line: 226 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v95 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v96 = buffer.create(v95);
    buffer.copy(v96, 0, u2, u4, v95);
    u4 = u4 + v95;
    return v96;
end;
function v9.Buffer(p97) --[[ Line: 227 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v98 = buffer.len(p97);
    local v99 = u4 + (1 + v98);
    if u3 < v99 then
        while u3 < v99 do
            u3 = u3 * 2;
        end;
        local v100 = buffer.create(u3);
        buffer.copy(v100, 0, u2, 0, u4);
        u1.Buffer = v100;
        u2 = v100;
    end;
    buffer.writeu8(u2, u4, v98);
    u4 = u4 + 1;
    buffer.copy(u2, u4, p97);
    u4 = u4 + buffer.len(p97);
end;
v7.BufferLong = "BufferLong";
function v8.BufferLong() --[[ Line: 230 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v101 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v102 = buffer.create(v101);
    buffer.copy(v102, 0, u2, u4, v101);
    u4 = u4 + v101;
    return v102;
end;
function v9.BufferLong(p103) --[[ Line: 231 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v104 = buffer.len(p103);
    local v105 = u4 + (2 + v104);
    if u3 < v105 then
        while u3 < v105 do
            u3 = u3 * 2;
        end;
        local v106 = buffer.create(u3);
        buffer.copy(v106, 0, u2, 0, u4);
        u1.Buffer = v106;
        u2 = v106;
    end;
    buffer.writeu16(u2, u4, v104);
    u4 = u4 + 2;
    buffer.copy(u2, u4, p103);
    u4 = u4 + buffer.len(p103);
end;
v7.Instance = "Instance";
function v8.Instance() --[[ Line: 234 ]]
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;
    return u5[u6];
end;
function v9.Instance(p107) --[[ Line: 235 ]]
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;
    u5[u6] = p107;
end;
v7.Boolean8 = "Boolean8";
function v8.Boolean8() --[[ Line: 238 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v108 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return v108 == 1;
end;
function v9.Boolean8(p109) --[[ Line: 239 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v110 = u4 + 1;
    if u3 < v110 then
        while u3 < v110 do
            u3 = u3 * 2;
        end;
        local v111 = buffer.create(u3);
        buffer.copy(v111, 0, u2, 0, u4);
        u1.Buffer = v111;
        u2 = v111;
    end;
    buffer.writeu8(u2, u4, p109 and 1 or 0);
    u4 = u4 + 1;
end;
v7.NumberRange = "NumberRange";
function v8.NumberRange() --[[ Line: 242 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__1 = NumberRange.new;
    local v112 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v113 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__1(v112, v113);
end;
function v9.NumberRange(p114) --[[ Line: 243 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v115 = u4 + 8;
    if u3 < v115 then
        while u3 < v115 do
            u3 = u3 * 2;
        end;
        local v116 = buffer.create(u3);
        buffer.copy(v116, 0, u2, 0, u4);
        u1.Buffer = v116;
        u2 = v116;
    end;
    buffer.writef32(u2, u4, p114.Min);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p114.Max);
    u4 = u4 + 4;
end;
v7.BrickColor = "BrickColor";
function v8.BrickColor() --[[ Line: 246 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__2 = BrickColor.new;
    local v117 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    return l__new__2(v117);
end;
function v9.BrickColor(p118) --[[ Line: 247 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v119 = u4 + 2;
    if u3 < v119 then
        while u3 < v119 do
            u3 = u3 * 2;
        end;
        local v120 = buffer.create(u3);
        buffer.copy(v120, 0, u2, 0, u4);
        u1.Buffer = v120;
        u2 = v120;
    end;
    buffer.writeu16(u2, u4, p118.Number);
    u4 = u4 + 2;
end;
v7.Color3 = "Color3";
function v8.Color3() --[[ Line: 250 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__fromRGB__3 = Color3.fromRGB;
    local v121 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v122 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v123 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return l__fromRGB__3(v121, v122, v123);
end;
function v9.Color3(p124) --[[ Line: 251 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v125 = u4 + 3;
    if u3 < v125 then
        while u3 < v125 do
            u3 = u3 * 2;
        end;
        local v126 = buffer.create(u3);
        buffer.copy(v126, 0, u2, 0, u4);
        u1.Buffer = v126;
        u2 = v126;
    end;
    buffer.writeu8(u2, u4, p124.R * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p124.G * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p124.B * 255 + 0.5);
    u4 = u4 + 1;
end;
v7.UDim = "UDim";
function v8.UDim() --[[ Line: 254 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__4 = UDim.new;
    local v127 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v128 = v127 / 1000;
    local v129 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return l__new__4(v128, v129);
end;
function v9.UDim(p130) --[[ Line: 255 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v131 = u4 + 4;
    if u3 < v131 then
        while u3 < v131 do
            u3 = u3 * 2;
        end;
        local v132 = buffer.create(u3);
        buffer.copy(v132, 0, u2, 0, u4);
        u1.Buffer = v132;
        u2 = v132;
    end;
    buffer.writei16(u2, u4, p130.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p130.Offset);
    u4 = u4 + 2;
end;
v7.UDim2 = "UDim2";
function v8.UDim2() --[[ Line: 258 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__5 = UDim2.new;
    local v133 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v134 = v133 / 1000;
    local v135 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v136 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v137 = v136 / 1000;
    local v138 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return l__new__5(v134, v135, v137, v138);
end;
function v9.UDim2(p139) --[[ Line: 259 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v140 = u4 + 8;
    if u3 < v140 then
        while u3 < v140 do
            u3 = u3 * 2;
        end;
        local v141 = buffer.create(u3);
        buffer.copy(v141, 0, u2, 0, u4);
        u1.Buffer = v141;
        u2 = v141;
    end;
    buffer.writei16(u2, u4, p139.X.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p139.X.Offset);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p139.Y.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p139.Y.Offset);
    u4 = u4 + 2;
end;
v7.Rect = "Rect";
function v8.Rect() --[[ Line: 262 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__6 = Rect.new;
    local v142 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v143 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v144 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v145 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__6(v142, v143, v144, v145);
end;
function v9.Rect(p146) --[[ Line: 263 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v147 = u4 + 16;
    if u3 < v147 then
        while u3 < v147 do
            u3 = u3 * 2;
        end;
        local v148 = buffer.create(u3);
        buffer.copy(v148, 0, u2, 0, u4);
        u1.Buffer = v148;
        u2 = v148;
    end;
    buffer.writef32(u2, u4, p146.Min.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p146.Min.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p146.Max.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p146.Max.Y);
    u4 = u4 + 4;
end;
v7.Vector2S16 = "Vector2S16";
function v8.Vector2S16() --[[ Line: 266 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__7 = Vector2.new;
    local v149 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v150 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return l__new__7(v149, v150);
end;
function v9.Vector2S16(p151) --[[ Line: 267 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v152 = u4 + 4;
    if u3 < v152 then
        while u3 < v152 do
            u3 = u3 * 2;
        end;
        local v153 = buffer.create(u3);
        buffer.copy(v153, 0, u2, 0, u4);
        u1.Buffer = v153;
        u2 = v153;
    end;
    buffer.writei16(u2, u4, p151.X);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p151.Y);
    u4 = u4 + 2;
end;
v7.Vector2F24 = "Vector2F24";
function v8.Vector2F24() --[[ Line: 270 ]]
    -- upvalues: u27 (copy)
    return Vector2.new(u27(), (u27()));
end;
function v9.Vector2F24(p154) --[[ Line: 271 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v155 = u4 + 6;
    if u3 < v155 then
        while u3 < v155 do
            u3 = u3 * 2;
        end;
        local v156 = buffer.create(u3);
        buffer.copy(v156, 0, u2, 0, u4);
        u1.Buffer = v156;
        u2 = v156;
    end;
    u33(p154.X);
    u33(p154.Y);
end;
v7.Vector2F32 = "Vector2F32";
function v8.Vector2F32() --[[ Line: 274 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__8 = Vector2.new;
    local v157 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v158 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__8(v157, v158);
end;
function v9.Vector2F32(p159) --[[ Line: 275 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v160 = u4 + 8;
    if u3 < v160 then
        while u3 < v160 do
            u3 = u3 * 2;
        end;
        local v161 = buffer.create(u3);
        buffer.copy(v161, 0, u2, 0, u4);
        u1.Buffer = v161;
        u2 = v161;
    end;
    buffer.writef32(u2, u4, p159.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p159.Y);
    u4 = u4 + 4;
end;
v7.Vector3S16 = "Vector3S16";
function v8.Vector3S16() --[[ Line: 278 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v162 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v163 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v164 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return Vector3.new(v162, v163, v164);
end;
function v9.Vector3S16(p165) --[[ Line: 279 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v166 = u4 + 6;
    if u3 < v166 then
        while u3 < v166 do
            u3 = u3 * 2;
        end;
        local v167 = buffer.create(u3);
        buffer.copy(v167, 0, u2, 0, u4);
        u1.Buffer = v167;
        u2 = v167;
    end;
    buffer.writei16(u2, u4, p165.X);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p165.Y);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p165.Z);
    u4 = u4 + 2;
end;
v7.Vector3F24 = "Vector3F24";
function v8.Vector3F24() --[[ Line: 282 ]]
    -- upvalues: u27 (copy)
    local v168 = u27();
    local v169 = u27();
    local v170 = u27();
    return Vector3.new(v168, v169, v170);
end;
function v9.Vector3F24(p171) --[[ Line: 283 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v172 = u4 + 9;
    if u3 < v172 then
        while u3 < v172 do
            u3 = u3 * 2;
        end;
        local v173 = buffer.create(u3);
        buffer.copy(v173, 0, u2, 0, u4);
        u1.Buffer = v173;
        u2 = v173;
    end;
    u33(p171.X);
    u33(p171.Y);
    u33(p171.Z);
end;
v7.Vector3F32 = "Vector3F32";
function v8.Vector3F32() --[[ Line: 286 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v174 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v175 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v176 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return Vector3.new(v174, v175, v176);
end;
function v9.Vector3F32(p177) --[[ Line: 287 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v178 = u4 + 12;
    if u3 < v178 then
        while u3 < v178 do
            u3 = u3 * 2;
        end;
        local v179 = buffer.create(u3);
        buffer.copy(v179, 0, u2, 0, u4);
        u1.Buffer = v179;
        u2 = v179;
    end;
    buffer.writef32(u2, u4, p177.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p177.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p177.Z);
    u4 = u4 + 4;
end;
v7.NumberU4 = "NumberU4";
function v8.NumberU4() --[[ Line: 290 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v180 = u4 * 8;
    u4 = u4 + 1;
    return { buffer.readbits(u2, v180 + 0, 4), buffer.readbits(u2, v180 + 4, 4) };
end;
function v9.NumberU4(p181) --[[ Line: 298 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v182 = u4 + 1;
    if u3 < v182 then
        while u3 < v182 do
            u3 = u3 * 2;
        end;
        local v183 = buffer.create(u3);
        buffer.copy(v183, 0, u2, 0, u4);
        u1.Buffer = v183;
        u2 = v183;
    end;
    local v184 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v184 + 0, 4, p181[1]);
    buffer.writebits(u2, v184 + 4, 4, p181[2]);
end;
v7.BooleanNumber = "BooleanNumber";
function v8.BooleanNumber() --[[ Line: 307 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v185 = u4 * 8;
    u4 = u4 + 1;
    return {
        Boolean = buffer.readbits(u2, v185 + 0, 1) == 1,
        Number = buffer.readbits(u2, v185 + 1, 7)
    };
end;
function v9.BooleanNumber(p186) --[[ Line: 315 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v187 = u4 + 1;
    if u3 < v187 then
        while u3 < v187 do
            u3 = u3 * 2;
        end;
        local v188 = buffer.create(u3);
        buffer.copy(v188, 0, u2, 0, u4);
        u1.Buffer = v188;
        u2 = v188;
    end;
    local v189 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v189 + 0, 1, p186.Boolean and 1 or 0);
    buffer.writebits(u2, v189 + 1, 7, p186.Number);
end;
v7.Boolean1 = "Boolean1";
function v8.Boolean1() --[[ Line: 324 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v190 = u4 * 8;
    u4 = u4 + 1;
    return {
        buffer.readbits(u2, v190 + 0, 1) == 1,
        buffer.readbits(u2, v190 + 1, 1) == 1,
        buffer.readbits(u2, v190 + 2, 1) == 1,
        buffer.readbits(u2, v190 + 3, 1) == 1,
        buffer.readbits(u2, v190 + 4, 1) == 1,
        buffer.readbits(u2, v190 + 5, 1) == 1,
        buffer.readbits(u2, v190 + 6, 1) == 1,
        buffer.readbits(u2, v190 + 7, 1) == 1
    };
end;
function v9.Boolean1(p191) --[[ Line: 338 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v192 = u4 + 1;
    if u3 < v192 then
        while u3 < v192 do
            u3 = u3 * 2;
        end;
        local v193 = buffer.create(u3);
        buffer.copy(v193, 0, u2, 0, u4);
        u1.Buffer = v193;
        u2 = v193;
    end;
    local v194 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v194 + 0, 1, p191[1] and 1 or 0);
    buffer.writebits(u2, v194 + 1, 1, p191[2] and 1 or 0);
    buffer.writebits(u2, v194 + 2, 1, p191[3] and 1 or 0);
    buffer.writebits(u2, v194 + 3, 1, p191[4] and 1 or 0);
    buffer.writebits(u2, v194 + 4, 1, p191[5] and 1 or 0);
    buffer.writebits(u2, v194 + 5, 1, p191[6] and 1 or 0);
    buffer.writebits(u2, v194 + 6, 1, p191[7] and 1 or 0);
    buffer.writebits(u2, v194 + 7, 1, p191[8] and 1 or 0);
end;
v7.CFrameF24U8 = "CFrameF24U8";
function v8.CFrameF24U8() --[[ Line: 353 ]]
    -- upvalues: u2 (ref), u4 (ref), u27 (copy)
    local l__fromEulerAnglesXYZ__9 = CFrame.fromEulerAnglesXYZ;
    local v195 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v196 = v195 / 40.58451048843331;
    local v197 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v198 = v197 / 40.58451048843331;
    local v199 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v200 = l__fromEulerAnglesXYZ__9(v196, v198, v199 / 40.58451048843331);
    local v201 = u27();
    local v202 = u27();
    local v203 = u27();
    return v200 + Vector3.new(v201, v202, v203);
end;
function v9.CFrameF24U8(p204) --[[ Line: 357 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v205, v206, v207 = p204:ToEulerAnglesXYZ();
    local v208 = u4 + 12;
    if u3 < v208 then
        while u3 < v208 do
            u3 = u3 * 2;
        end;
        local v209 = buffer.create(u3);
        buffer.copy(v209, 0, u2, 0, u4);
        u1.Buffer = v209;
        u2 = v209;
    end;
    buffer.writeu8(u2, u4, v205 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v206 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v207 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    u33(p204.X);
    u33(p204.Y);
    u33(p204.Z);
end;
v7.CFrameF32U8 = "CFrameF32U8";
function v8.CFrameF32U8() --[[ Line: 365 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__fromEulerAnglesXYZ__10 = CFrame.fromEulerAnglesXYZ;
    local v210 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v211 = v210 / 40.58451048843331;
    local v212 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v213 = v212 / 40.58451048843331;
    local v214 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v215 = l__fromEulerAnglesXYZ__10(v211, v213, v214 / 40.58451048843331);
    local v216 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v217 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v218 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return v215 + Vector3.new(v216, v217, v218);
end;
function v9.CFrameF32U8(p219) --[[ Line: 369 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v220, v221, v222 = p219:ToEulerAnglesXYZ();
    local v223 = u4 + 15;
    if u3 < v223 then
        while u3 < v223 do
            u3 = u3 * 2;
        end;
        local v224 = buffer.create(u3);
        buffer.copy(v224, 0, u2, 0, u4);
        u1.Buffer = v224;
        u2 = v224;
    end;
    buffer.writeu8(u2, u4, v220 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v221 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v222 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p219.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p219.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p219.Z);
    u4 = u4 + 4;
end;
v7.CFrameF32U16 = "CFrameF32U16";
function v8.CFrameF32U16() --[[ Line: 377 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__fromEulerAnglesXYZ__11 = CFrame.fromEulerAnglesXYZ;
    local v225 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v226 = v225 / 10430.219195527361;
    local v227 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v228 = v227 / 10430.219195527361;
    local v229 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v230 = l__fromEulerAnglesXYZ__11(v226, v228, v229 / 10430.219195527361);
    local v231 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v232 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v233 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return v230 + Vector3.new(v231, v232, v233);
end;
function v9.CFrameF32U16(p234) --[[ Line: 381 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v235, v236, v237 = p234:ToEulerAnglesXYZ();
    local v238 = u4 + 18;
    if u3 < v238 then
        while u3 < v238 do
            u3 = u3 * 2;
        end;
        local v239 = buffer.create(u3);
        buffer.copy(v239, 0, u2, 0, u4);
        u1.Buffer = v239;
        u2 = v239;
    end;
    buffer.writeu16(u2, u4, v235 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v236 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v237 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writef32(u2, u4, p234.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p234.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p234.Z);
    u4 = u4 + 4;
end;
v7.Region3 = "Region3";
function v8.Region3() --[[ Line: 389 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__12 = Region3.new;
    local v240 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v241 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v242 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v243 = Vector3.new(v240, v241, v242);
    local v244 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v245 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v246 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__12(v243, (Vector3.new(v244, v245, v246)));
end;
function v9.Region3(p247) --[[ Line: 395 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v248 = p247.Size / 2;
    local v249 = p247.CFrame.Position - v248;
    local v250 = p247.CFrame.Position + v248;
    local v251 = u4 + 24;
    if u3 < v251 then
        while u3 < v251 do
            u3 = u3 * 2;
        end;
        local v252 = buffer.create(u3);
        buffer.copy(v252, 0, u2, 0, u4);
        u1.Buffer = v252;
        u2 = v252;
    end;
    buffer.writef32(u2, u4, v249.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v249.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v249.Z);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v250.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v250.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v250.Z);
    u4 = u4 + 4;
end;
v7.NumberSequence = "NumberSequence";
function v8.NumberSequence() --[[ Line: 405 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v253 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v254 = table.create(v253);
    for _ = 1, v253 do
        local l__new__13 = NumberSequenceKeypoint.new;
        local v255 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v256 = v255 / 255;
        local v257 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v258 = v257 / 255;
        local v259 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(v254, l__new__13(v256, v258, v259 / 255));
    end;
    return NumberSequence.new(v254);
end;
function v9.NumberSequence(p260) --[[ Line: 413 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v261 = #p260.Keypoints;
    local v262 = u4 + (v261 * 3 + 1);
    if u3 < v262 then
        while u3 < v262 do
            u3 = u3 * 2;
        end;
        local v263 = buffer.create(u3);
        buffer.copy(v263, 0, u2, 0, u4);
        u1.Buffer = v263;
        u2 = v263;
    end;
    buffer.writeu8(u2, u4, v261);
    u4 = u4 + 1;
    for _, v264 in p260.Keypoints do
        buffer.writeu8(u2, u4, v264.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v264.Value * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v264.Envelope * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;
v7.ColorSequence = "ColorSequence";
function v8.ColorSequence() --[[ Line: 423 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v265 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v266 = table.create(v265);
    for _ = 1, v265 do
        local l__new__14 = ColorSequenceKeypoint.new;
        local v267 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v268 = v267 / 255;
        local l__fromRGB__15 = Color3.fromRGB;
        local v269 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v270 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v271 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(v266, l__new__14(v268, l__fromRGB__15(v269, v270, v271)));
    end;
    return ColorSequence.new(v266);
end;
function v9.ColorSequence(p272) --[[ Line: 431 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v273 = #p272.Keypoints;
    local v274 = u4 + (v273 * 4 + 1);
    if u3 < v274 then
        while u3 < v274 do
            u3 = u3 * 2;
        end;
        local v275 = buffer.create(u3);
        buffer.copy(v275, 0, u2, 0, u4);
        u1.Buffer = v275;
        u2 = v275;
    end;
    buffer.writeu8(u2, u4, v273);
    u4 = u4 + 1;
    for _, v276 in p272.Keypoints do
        buffer.writeu8(u2, u4, v276.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v276.Value.R * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v276.Value.G * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v276.Value.B * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;
local l__Characters__16 = require(script.Characters);
local u277 = u5;
local u278 = u6;
local u279 = u1;
local u280 = u3;
local u281 = u4;
local u282 = u2;
local u283 = {};
for v284, v285 in l__Characters__16 do
    u283[v285] = v284;
end;
local v286 = math.log(#l__Characters__16 + 1, 2);
local u287 = math.ceil(v286);
local u288 = u287 / 8;
v7.Characters = "Characters";
function v8.Characters() --[[ Line: 447 ]]
    -- upvalues: u282 (ref), u281 (ref), u288 (copy), l__Characters__16 (copy), u287 (copy)
    local v289 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v290 = table.create(v289);
    local v291 = u281 * 8;
    u281 = u281 + math.ceil(v289 * u288);
    for _ = 1, v289 do
        local v292 = l__Characters__16[buffer.readbits(u282, v291, u287)];
        table.insert(v290, v292);
        v291 = v291 + u287;
    end;
    return table.concat(v290);
end;
function v9.Characters(p293) --[[ Line: 458 ]]
    -- upvalues: u288 (copy), u281 (ref), u280 (ref), u282 (ref), u279 (ref), u287 (copy), u283 (copy)
    local v294 = #p293;
    local v295 = math.ceil(v294 * u288);
    local v296 = u281 + (v295 + 1);
    if u280 < v296 then
        while u280 < v296 do
            u280 = u280 * 2;
        end;
        local v297 = buffer.create(u280);
        buffer.copy(v297, 0, u282, 0, u281);
        u279.Buffer = v297;
        u282 = v297;
    end;
    buffer.writeu8(u282, u281, v294);
    u281 = u281 + 1;
    local v298 = u281 * 8;
    for v299 = 1, v294 do
        buffer.writebits(u282, v298, u287, u283[p293:sub(v299, v299)]);
        v298 = v298 + u287;
    end;
    u281 = u281 + v295;
end;
local l__Enums__17 = require(script.Enums);
local u300 = {};
for v301, v302 in l__Enums__17 do
    u300[v302] = v301;
end;
v7.EnumItem = "EnumItem";
function v8.EnumItem() --[[ Line: 475 ]]
    -- upvalues: l__Enums__17 (copy), u282 (ref), u281 (ref)
    local v303 = l__Enums__17;
    local v304 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v305 = v303[v304];
    local v306 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    return v305:FromValue(v306);
end;
function v9.EnumItem(p307) --[[ Line: 476 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u300 (copy)
    local v308 = u281 + 3;
    if u280 < v308 then
        while u280 < v308 do
            u280 = u280 * 2;
        end;
        local v309 = buffer.create(u280);
        buffer.copy(v309, 0, u282, 0, u281);
        u279.Buffer = v309;
        u282 = v309;
    end;
    buffer.writeu8(u282, u281, u300[p307.EnumType]);
    u281 = u281 + 1;
    buffer.writeu16(u282, u281, p307.Value);
    u281 = u281 + 2;
end;
local l__Static1__18 = require(script.Static1);
local u310 = {};
for v311, v312 in l__Static1__18 do
    u310[v312] = v311;
end;
v7.Static1 = "Static1";
function v8.Static1() --[[ Line: 482 ]]
    -- upvalues: l__Static1__18 (copy), u282 (ref), u281 (ref)
    local v313 = l__Static1__18;
    local v314 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return v313[v314];
end;
function v9.Static1(p315) --[[ Line: 483 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u310 (copy)
    local v316 = u281 + 1;
    if u280 < v316 then
        while u280 < v316 do
            u280 = u280 * 2;
        end;
        local v317 = buffer.create(u280);
        buffer.copy(v317, 0, u282, 0, u281);
        u279.Buffer = v317;
        u282 = v317;
    end;
    buffer.writeu8(u282, u281, u310[p315] or 0);
    u281 = u281 + 1;
end;
local l__Static2__19 = require(script.Static2);
local u318 = {};
for v319, v320 in l__Static2__19 do
    u318[v320] = v319;
end;
v7.Static2 = "Static2";
function v8.Static2() --[[ Line: 489 ]]
    -- upvalues: l__Static2__19 (copy), u282 (ref), u281 (ref)
    local v321 = l__Static2__19;
    local v322 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return v321[v322];
end;
function v9.Static2(p323) --[[ Line: 490 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u318 (copy)
    local v324 = u281 + 1;
    if u280 < v324 then
        while u280 < v324 do
            u280 = u280 * 2;
        end;
        local v325 = buffer.create(u280);
        buffer.copy(v325, 0, u282, 0, u281);
        u279.Buffer = v325;
        u282 = v325;
    end;
    buffer.writeu8(u282, u281, u318[p323] or 0);
    u281 = u281 + 1;
end;
local l__Static3__20 = require(script.Static3);
local u326 = {};
for v327, v328 in l__Static3__20 do
    u326[v328] = v327;
end;
v7.Static3 = "Static3";
function v8.Static3() --[[ Line: 496 ]]
    -- upvalues: l__Static3__20 (copy), u282 (ref), u281 (ref)
    local v329 = l__Static3__20;
    local v330 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return v329[v330];
end;
function v9.Static3(p331) --[[ Line: 497 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u326 (copy)
    local v332 = u281 + 1;
    if u280 < v332 then
        while u280 < v332 do
            u280 = u280 * 2;
        end;
        local v333 = buffer.create(u280);
        buffer.copy(v333, 0, u282, 0, u281);
        u279.Buffer = v333;
        u282 = v333;
    end;
    buffer.writeu8(u282, u281, u326[p331] or 0);
    u281 = u281 + 1;
end;
u10[0] = function() --[[ Line: 501 ]]
    return nil;
end;
u11["nil"] = function(_) --[[ Line: 502 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v334 = u281 + 1;
    if u280 < v334 then
        while u280 < v334 do
            u280 = u280 * 2;
        end;
        local v335 = buffer.create(u280);
        buffer.copy(v335, 0, u282, 0, u281);
        u279.Buffer = v335;
        u282 = v335;
    end;
    buffer.writeu8(u282, u281, 0);
    u281 = u281 + 1;
end;
u10[1] = function() --[[ Line: 504 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v336 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return -v336;
end;
u10[2] = function() --[[ Line: 505 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v337 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    return -v337;
end;
u10[3] = function() --[[ Line: 506 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v338 = buffer.readbits(u282, u281 * 8, 24);
    u281 = u281 + 3;
    return -v338;
end;
u10[4] = function() --[[ Line: 507 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v339 = buffer.readu32(u282, u281);
    u281 = u281 + 4;
    return -v339;
end;
u10[5] = function() --[[ Line: 508 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v340 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return v340;
end;
u10[6] = function() --[[ Line: 509 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v341 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    return v341;
end;
u10[7] = function() --[[ Line: 510 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v342 = buffer.readbits(u282, u281 * 8, 24);
    u281 = u281 + 3;
    return v342;
end;
u10[8] = function() --[[ Line: 511 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v343 = buffer.readu32(u282, u281);
    u281 = u281 + 4;
    return v343;
end;
u10[9] = function() --[[ Line: 512 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v344 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return v344;
end;
u10[10] = function() --[[ Line: 513 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v345 = buffer.readf64(u282, u281);
    u281 = u281 + 8;
    return v345;
end;
function u11.number(p346) --[[ Line: 514 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    if p346 % 1 == 0 then
        if p346 < 0 then
            if p346 > -256 then
                local v347 = u281 + 2;
                if u280 < v347 then
                    while u280 < v347 do
                        u280 = u280 * 2;
                    end;
                    local v348 = buffer.create(u280);
                    buffer.copy(v348, 0, u282, 0, u281);
                    u279.Buffer = v348;
                    u282 = v348;
                end;
                buffer.writeu8(u282, u281, 1);
                u281 = u281 + 1;
                buffer.writeu8(u282, u281, -p346);
                u281 = u281 + 1;
            elseif p346 > -65536 then
                local v349 = u281 + 3;
                if u280 < v349 then
                    while u280 < v349 do
                        u280 = u280 * 2;
                    end;
                    local v350 = buffer.create(u280);
                    buffer.copy(v350, 0, u282, 0, u281);
                    u279.Buffer = v350;
                    u282 = v350;
                end;
                buffer.writeu8(u282, u281, 2);
                u281 = u281 + 1;
                buffer.writeu16(u282, u281, -p346);
                u281 = u281 + 2;
            elseif p346 > -16777216 then
                local v351 = u281 + 4;
                if u280 < v351 then
                    while u280 < v351 do
                        u280 = u280 * 2;
                    end;
                    local v352 = buffer.create(u280);
                    buffer.copy(v352, 0, u282, 0, u281);
                    u279.Buffer = v352;
                    u282 = v352;
                end;
                buffer.writeu8(u282, u281, 3);
                u281 = u281 + 1;
                buffer.writebits(u282, u281 * 8, 24, -p346);
                u281 = u281 + 3;
            elseif p346 > -4294967296 then
                local v353 = u281 + 5;
                if u280 < v353 then
                    while u280 < v353 do
                        u280 = u280 * 2;
                    end;
                    local v354 = buffer.create(u280);
                    buffer.copy(v354, 0, u282, 0, u281);
                    u279.Buffer = v354;
                    u282 = v354;
                end;
                buffer.writeu8(u282, u281, 4);
                u281 = u281 + 1;
                buffer.writeu32(u282, u281, -p346);
                u281 = u281 + 4;
            else
                local v355 = u281 + 9;
                if u280 < v355 then
                    while u280 < v355 do
                        u280 = u280 * 2;
                    end;
                    local v356 = buffer.create(u280);
                    buffer.copy(v356, 0, u282, 0, u281);
                    u279.Buffer = v356;
                    u282 = v356;
                end;
                buffer.writeu8(u282, u281, 10);
                u281 = u281 + 1;
                buffer.writef64(u282, u281, p346);
                u281 = u281 + 8;
            end;
        elseif p346 < 256 then
            local v357 = u281 + 2;
            if u280 < v357 then
                while u280 < v357 do
                    u280 = u280 * 2;
                end;
                local v358 = buffer.create(u280);
                buffer.copy(v358, 0, u282, 0, u281);
                u279.Buffer = v358;
                u282 = v358;
            end;
            buffer.writeu8(u282, u281, 5);
            u281 = u281 + 1;
            buffer.writeu8(u282, u281, p346);
            u281 = u281 + 1;
        elseif p346 < 65536 then
            local v359 = u281 + 3;
            if u280 < v359 then
                while u280 < v359 do
                    u280 = u280 * 2;
                end;
                local v360 = buffer.create(u280);
                buffer.copy(v360, 0, u282, 0, u281);
                u279.Buffer = v360;
                u282 = v360;
            end;
            buffer.writeu8(u282, u281, 6);
            u281 = u281 + 1;
            buffer.writeu16(u282, u281, p346);
            u281 = u281 + 2;
        elseif p346 < 16777216 then
            local v361 = u281 + 4;
            if u280 < v361 then
                while u280 < v361 do
                    u280 = u280 * 2;
                end;
                local v362 = buffer.create(u280);
                buffer.copy(v362, 0, u282, 0, u281);
                u279.Buffer = v362;
                u282 = v362;
            end;
            buffer.writeu8(u282, u281, 7);
            u281 = u281 + 1;
            buffer.writebits(u282, u281 * 8, 24, p346);
            u281 = u281 + 3;
        elseif p346 < 4294967296 then
            local v363 = u281 + 5;
            if u280 < v363 then
                while u280 < v363 do
                    u280 = u280 * 2;
                end;
                local v364 = buffer.create(u280);
                buffer.copy(v364, 0, u282, 0, u281);
                u279.Buffer = v364;
                u282 = v364;
            end;
            buffer.writeu8(u282, u281, 8);
            u281 = u281 + 1;
            buffer.writeu32(u282, u281, p346);
            u281 = u281 + 4;
        else
            local v365 = u281 + 9;
            if u280 < v365 then
                while u280 < v365 do
                    u280 = u280 * 2;
                end;
                local v366 = buffer.create(u280);
                buffer.copy(v366, 0, u282, 0, u281);
                u279.Buffer = v366;
                u282 = v366;
            end;
            buffer.writeu8(u282, u281, 10);
            u281 = u281 + 1;
            buffer.writef64(u282, u281, p346);
            u281 = u281 + 8;
        end;
    elseif p346 > -1048576 and p346 < 1048576 then
        local v367 = u281 + 5;
        if u280 < v367 then
            while u280 < v367 do
                u280 = u280 * 2;
            end;
            local v368 = buffer.create(u280);
            buffer.copy(v368, 0, u282, 0, u281);
            u279.Buffer = v368;
            u282 = v368;
        end;
        buffer.writeu8(u282, u281, 9);
        u281 = u281 + 1;
        buffer.writef32(u282, u281, p346);
        u281 = u281 + 4;
    else
        local v369 = u281 + 9;
        if u280 < v369 then
            while u280 < v369 do
                u280 = u280 * 2;
            end;
            local v370 = buffer.create(u280);
            buffer.copy(v370, 0, u282, 0, u281);
            u279.Buffer = v370;
            u282 = v370;
        end;
        buffer.writeu8(u282, u281, 10);
        u281 = u281 + 1;
        buffer.writef64(u282, u281, p346);
        u281 = u281 + 8;
    end;
end;
u10[11] = function() --[[ Line: 548 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v371 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v372 = buffer.readstring(u282, u281, v371);
    u281 = u281 + v371;
    return v372;
end;
function u11.string(p373) --[[ Line: 549 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v374 = #p373;
    local v375 = u281 + (v374 + 2);
    if u280 < v375 then
        while u280 < v375 do
            u280 = u280 * 2;
        end;
        local v376 = buffer.create(u280);
        buffer.copy(v376, 0, u282, 0, u281);
        u279.Buffer = v376;
        u282 = v376;
    end;
    buffer.writeu8(u282, u281, 11);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, v374);
    u281 = u281 + 1;
    buffer.writestring(u282, u281, p373);
    u281 = u281 + #p373;
end;
u10[12] = function() --[[ Line: 551 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v377 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v378 = buffer.create(v377);
    buffer.copy(v378, 0, u282, u281, v377);
    u281 = u281 + v377;
    return v378;
end;
function u11.buffer(p379) --[[ Line: 552 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v380 = buffer.len(p379);
    local v381 = u281 + (2 + v380);
    if u280 < v381 then
        while u280 < v381 do
            u280 = u280 * 2;
        end;
        local v382 = buffer.create(u280);
        buffer.copy(v382, 0, u282, 0, u281);
        u279.Buffer = v382;
        u282 = v382;
    end;
    buffer.writeu8(u282, u281, 12);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, v380);
    u281 = u281 + 1;
    buffer.copy(u282, u281, p379);
    u281 = u281 + buffer.len(p379);
end;
u10[13] = function() --[[ Line: 554 ]]
    -- upvalues: u278 (ref), u277 (ref)
    u278 = u278 + 1;
    return u277[u278];
end;
function u11.Instance(p383) --[[ Line: 555 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u278 (ref), u277 (ref)
    local v384 = u281 + 1;
    if u280 < v384 then
        while u280 < v384 do
            u280 = u280 * 2;
        end;
        local v385 = buffer.create(u280);
        buffer.copy(v385, 0, u282, 0, u281);
        u279.Buffer = v385;
        u282 = v385;
    end;
    buffer.writeu8(u282, u281, 13);
    u281 = u281 + 1;
    u278 = u278 + 1;
    u277[u278] = p383;
end;
u10[14] = function() --[[ Line: 557 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v386 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return v386 == 1;
end;
function u11.boolean(p387) --[[ Line: 558 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v388 = u281 + 2;
    if u280 < v388 then
        while u280 < v388 do
            u280 = u280 * 2;
        end;
        local v389 = buffer.create(u280);
        buffer.copy(v389, 0, u282, 0, u281);
        u279.Buffer = v389;
        u282 = v389;
    end;
    buffer.writeu8(u282, u281, 14);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, p387 and 1 or 0);
    u281 = u281 + 1;
end;
u10[15] = function() --[[ Line: 560 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__21 = NumberRange.new;
    local v390 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v391 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return l__new__21(v390, v391);
end;
function u11.NumberRange(p392) --[[ Line: 561 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v393 = u281 + 9;
    if u280 < v393 then
        while u280 < v393 do
            u280 = u280 * 2;
        end;
        local v394 = buffer.create(u280);
        buffer.copy(v394, 0, u282, 0, u281);
        u279.Buffer = v394;
        u282 = v394;
    end;
    buffer.writeu8(u282, u281, 15);
    u281 = u281 + 1;
    buffer.writef32(u282, u281, p392.Min);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p392.Max);
    u281 = u281 + 4;
end;
u10[16] = function() --[[ Line: 563 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__22 = BrickColor.new;
    local v395 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    return l__new__22(v395);
end;
function u11.BrickColor(p396) --[[ Line: 564 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v397 = u281 + 3;
    if u280 < v397 then
        while u280 < v397 do
            u280 = u280 * 2;
        end;
        local v398 = buffer.create(u280);
        buffer.copy(v398, 0, u282, 0, u281);
        u279.Buffer = v398;
        u282 = v398;
    end;
    buffer.writeu8(u282, u281, 16);
    u281 = u281 + 1;
    buffer.writeu16(u282, u281, p396.Number);
    u281 = u281 + 2;
end;
u10[17] = function() --[[ Line: 566 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__fromRGB__23 = Color3.fromRGB;
    local v399 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v400 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v401 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    return l__fromRGB__23(v399, v400, v401);
end;
function u11.Color3(p402) --[[ Line: 567 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v403 = u281 + 4;
    if u280 < v403 then
        while u280 < v403 do
            u280 = u280 * 2;
        end;
        local v404 = buffer.create(u280);
        buffer.copy(v404, 0, u282, 0, u281);
        u279.Buffer = v404;
        u282 = v404;
    end;
    buffer.writeu8(u282, u281, 17);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, p402.R * 255 + 0.5);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, p402.G * 255 + 0.5);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, p402.B * 255 + 0.5);
    u281 = u281 + 1;
end;
u10[18] = function() --[[ Line: 569 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__24 = UDim.new;
    local v405 = buffer.readi16(u282, u281);
    u281 = u281 + 2;
    local v406 = v405 / 1000;
    local v407 = buffer.readi16(u282, u281);
    u281 = u281 + 2;
    return l__new__24(v406, v407);
end;
function u11.UDim(p408) --[[ Line: 570 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v409 = u281 + 5;
    if u280 < v409 then
        while u280 < v409 do
            u280 = u280 * 2;
        end;
        local v410 = buffer.create(u280);
        buffer.copy(v410, 0, u282, 0, u281);
        u279.Buffer = v410;
        u282 = v410;
    end;
    buffer.writeu8(u282, u281, 18);
    u281 = u281 + 1;
    buffer.writei16(u282, u281, p408.Scale * 1000);
    u281 = u281 + 2;
    buffer.writei16(u282, u281, p408.Offset);
    u281 = u281 + 2;
end;
u10[19] = function() --[[ Line: 572 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__25 = UDim2.new;
    local v411 = buffer.readi16(u282, u281);
    u281 = u281 + 2;
    local v412 = v411 / 1000;
    local v413 = buffer.readi16(u282, u281);
    u281 = u281 + 2;
    local v414 = buffer.readi16(u282, u281);
    u281 = u281 + 2;
    local v415 = v414 / 1000;
    local v416 = buffer.readi16(u282, u281);
    u281 = u281 + 2;
    return l__new__25(v412, v413, v415, v416);
end;
function u11.UDim2(p417) --[[ Line: 573 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v418 = u281 + 9;
    if u280 < v418 then
        while u280 < v418 do
            u280 = u280 * 2;
        end;
        local v419 = buffer.create(u280);
        buffer.copy(v419, 0, u282, 0, u281);
        u279.Buffer = v419;
        u282 = v419;
    end;
    buffer.writeu8(u282, u281, 19);
    u281 = u281 + 1;
    buffer.writei16(u282, u281, p417.X.Scale * 1000);
    u281 = u281 + 2;
    buffer.writei16(u282, u281, p417.X.Offset);
    u281 = u281 + 2;
    buffer.writei16(u282, u281, p417.Y.Scale * 1000);
    u281 = u281 + 2;
    buffer.writei16(u282, u281, p417.Y.Offset);
    u281 = u281 + 2;
end;
u10[20] = function() --[[ Line: 575 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__26 = Rect.new;
    local v420 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v421 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v422 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v423 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return l__new__26(v420, v421, v422, v423);
end;
function u11.Rect(p424) --[[ Line: 576 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v425 = u281 + 17;
    if u280 < v425 then
        while u280 < v425 do
            u280 = u280 * 2;
        end;
        local v426 = buffer.create(u280);
        buffer.copy(v426, 0, u282, 0, u281);
        u279.Buffer = v426;
        u282 = v426;
    end;
    buffer.writeu8(u282, u281, 20);
    u281 = u281 + 1;
    buffer.writef32(u282, u281, p424.Min.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p424.Min.Y);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p424.Max.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p424.Max.Y);
    u281 = u281 + 4;
end;
u10[21] = function() --[[ Line: 578 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__27 = Vector2.new;
    local v427 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v428 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return l__new__27(v427, v428);
end;
function u11.Vector2(p429) --[[ Line: 579 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v430 = u281 + 9;
    if u280 < v430 then
        while u280 < v430 do
            u280 = u280 * 2;
        end;
        local v431 = buffer.create(u280);
        buffer.copy(v431, 0, u282, 0, u281);
        u279.Buffer = v431;
        u282 = v431;
    end;
    buffer.writeu8(u282, u281, 21);
    u281 = u281 + 1;
    buffer.writef32(u282, u281, p429.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p429.Y);
    u281 = u281 + 4;
end;
u10[22] = function() --[[ Line: 581 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v432 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v433 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v434 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return Vector3.new(v432, v433, v434);
end;
function u11.Vector3(p435) --[[ Line: 582 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v436 = u281 + 13;
    if u280 < v436 then
        while u280 < v436 do
            u280 = u280 * 2;
        end;
        local v437 = buffer.create(u280);
        buffer.copy(v437, 0, u282, 0, u281);
        u279.Buffer = v437;
        u282 = v437;
    end;
    buffer.writeu8(u282, u281, 22);
    u281 = u281 + 1;
    buffer.writef32(u282, u281, p435.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p435.Y);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p435.Z);
    u281 = u281 + 4;
end;
u10[23] = function() --[[ Line: 584 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__fromEulerAnglesXYZ__28 = CFrame.fromEulerAnglesXYZ;
    local v438 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    local v439 = v438 / 10430.219195527361;
    local v440 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    local v441 = v440 / 10430.219195527361;
    local v442 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    local v443 = l__fromEulerAnglesXYZ__28(v439, v441, v442 / 10430.219195527361);
    local v444 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v445 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v446 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return v443 + Vector3.new(v444, v445, v446);
end;
function u11.CFrame(p447) --[[ Line: 588 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v448, v449, v450 = p447:ToEulerAnglesXYZ();
    local v451 = u281 + 19;
    if u280 < v451 then
        while u280 < v451 do
            u280 = u280 * 2;
        end;
        local v452 = buffer.create(u280);
        buffer.copy(v452, 0, u282, 0, u281);
        u279.Buffer = v452;
        u282 = v452;
    end;
    buffer.writeu8(u282, u281, 23);
    u281 = u281 + 1;
    buffer.writeu16(u282, u281, v448 * 10430.219195527361 + 0.5);
    u281 = u281 + 2;
    buffer.writeu16(u282, u281, v449 * 10430.219195527361 + 0.5);
    u281 = u281 + 2;
    buffer.writeu16(u282, u281, v450 * 10430.219195527361 + 0.5);
    u281 = u281 + 2;
    buffer.writef32(u282, u281, p447.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p447.Y);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, p447.Z);
    u281 = u281 + 4;
end;
u10[24] = function() --[[ Line: 596 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local l__new__29 = Region3.new;
    local v453 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v454 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v455 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v456 = Vector3.new(v453, v454, v455);
    local v457 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v458 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    local v459 = buffer.readf32(u282, u281);
    u281 = u281 + 4;
    return l__new__29(v456, (Vector3.new(v457, v458, v459)));
end;
function u11.Region3(p460) --[[ Line: 602 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v461 = p460.Size / 2;
    local v462 = p460.CFrame.Position - v461;
    local v463 = p460.CFrame.Position + v461;
    local v464 = u281 + 25;
    if u280 < v464 then
        while u280 < v464 do
            u280 = u280 * 2;
        end;
        local v465 = buffer.create(u280);
        buffer.copy(v465, 0, u282, 0, u281);
        u279.Buffer = v465;
        u282 = v465;
    end;
    buffer.writeu8(u282, u281, 24);
    u281 = u281 + 1;
    buffer.writef32(u282, u281, v462.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, v462.Y);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, v462.Z);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, v463.X);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, v463.Y);
    u281 = u281 + 4;
    buffer.writef32(u282, u281, v463.Z);
    u281 = u281 + 4;
end;
u10[25] = function() --[[ Line: 612 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v466 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v467 = table.create(v466);
    for _ = 1, v466 do
        local l__new__30 = NumberSequenceKeypoint.new;
        local v468 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        local v469 = v468 / 255;
        local v470 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        local v471 = v470 / 255;
        local v472 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        table.insert(v467, l__new__30(v469, v471, v472 / 255));
    end;
    return NumberSequence.new(v467);
end;
function u11.NumberSequence(p473) --[[ Line: 620 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v474 = #p473.Keypoints;
    local v475 = u281 + (v474 * 3 + 2);
    if u280 < v475 then
        while u280 < v475 do
            u280 = u280 * 2;
        end;
        local v476 = buffer.create(u280);
        buffer.copy(v476, 0, u282, 0, u281);
        u279.Buffer = v476;
        u282 = v476;
    end;
    buffer.writeu8(u282, u281, 25);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, v474);
    u281 = u281 + 1;
    for _, v477 in p473.Keypoints do
        buffer.writeu8(u282, u281, v477.Time * 255 + 0.5);
        u281 = u281 + 1;
        buffer.writeu8(u282, u281, v477.Value * 255 + 0.5);
        u281 = u281 + 1;
        buffer.writeu8(u282, u281, v477.Envelope * 255 + 0.5);
        u281 = u281 + 1;
    end;
end;
u10[26] = function() --[[ Line: 630 ]]
    -- upvalues: u282 (ref), u281 (ref)
    local v478 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v479 = table.create(v478);
    for _ = 1, v478 do
        local l__new__31 = ColorSequenceKeypoint.new;
        local v480 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        local v481 = v480 / 255;
        local l__fromRGB__32 = Color3.fromRGB;
        local v482 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        local v483 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        local v484 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        table.insert(v479, l__new__31(v481, l__fromRGB__32(v482, v483, v484)));
    end;
    return ColorSequence.new(v479);
end;
function u11.ColorSequence(p485) --[[ Line: 638 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref)
    local v486 = #p485.Keypoints;
    local v487 = u281 + (v486 * 4 + 2);
    if u280 < v487 then
        while u280 < v487 do
            u280 = u280 * 2;
        end;
        local v488 = buffer.create(u280);
        buffer.copy(v488, 0, u282, 0, u281);
        u279.Buffer = v488;
        u282 = v488;
    end;
    buffer.writeu8(u282, u281, 26);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, v486);
    u281 = u281 + 1;
    for _, v489 in p485.Keypoints do
        buffer.writeu8(u282, u281, v489.Time * 255 + 0.5);
        u281 = u281 + 1;
        buffer.writeu8(u282, u281, v489.Value.R * 255 + 0.5);
        u281 = u281 + 1;
        buffer.writeu8(u282, u281, v489.Value.G * 255 + 0.5);
        u281 = u281 + 1;
        buffer.writeu8(u282, u281, v489.Value.B * 255 + 0.5);
        u281 = u281 + 1;
    end;
end;
u10[27] = function() --[[ Line: 649 ]]
    -- upvalues: l__Enums__17 (copy), u282 (ref), u281 (ref)
    local v490 = l__Enums__17;
    local v491 = buffer.readu8(u282, u281);
    u281 = u281 + 1;
    local v492 = v490[v491];
    local v493 = buffer.readu16(u282, u281);
    u281 = u281 + 2;
    return v492:FromValue(v493);
end;
function u11.EnumItem(p494) --[[ Line: 652 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u300 (copy)
    local v495 = u281 + 4;
    if u280 < v495 then
        while u280 < v495 do
            u280 = u280 * 2;
        end;
        local v496 = buffer.create(u280);
        buffer.copy(v496, 0, u282, 0, u281);
        u279.Buffer = v496;
        u282 = v496;
    end;
    buffer.writeu8(u282, u281, 27);
    u281 = u281 + 1;
    buffer.writeu8(u282, u281, u300[p494.EnumType]);
    u281 = u281 + 1;
    buffer.writeu16(u282, u281, p494.Value);
    u281 = u281 + 2;
end;
u10[28] = function() --[[ Line: 659 ]]
    -- upvalues: u282 (ref), u281 (ref), u10 (copy)
    local v497 = {};
    while true do
        local v498 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        if v498 == 0 then
            break;
        end;
        local v499 = u10[v498]();
        local v500 = u10;
        local v501 = buffer.readu8(u282, u281);
        u281 = u281 + 1;
        v497[v499] = v500[v501]();
    end;
    return v497;
end;
function u11.table(p502) --[[ Line: 666 ]]
    -- upvalues: u281 (ref), u280 (ref), u282 (ref), u279 (ref), u11 (copy)
    local v503 = u281 + 1;
    if u280 < v503 then
        while u280 < v503 do
            u280 = u280 * 2;
        end;
        local v504 = buffer.create(u280);
        buffer.copy(v504, 0, u282, 0, u281);
        u279.Buffer = v504;
        u282 = v504;
    end;
    buffer.writeu8(u282, u281, 28);
    u281 = u281 + 1;
    for v505, v506 in p502 do
        u11[typeof(v505)](v505);
        u11[typeof(v506)](v506);
    end;
    local v507 = u281 + 1;
    if u280 < v507 then
        while u280 < v507 do
            u280 = u280 * 2;
        end;
        local v508 = buffer.create(u280);
        buffer.copy(v508, 0, u282, 0, u281);
        u279.Buffer = v508;
        u282 = v508;
    end;
    buffer.writeu8(u282, u281, 0);
    u281 = u281 + 1;
end;
return {
    Import = function(p509) --[[ Name: Import, Line 676 ]]
        -- upvalues: u279 (ref), u282 (ref), u280 (ref), u281 (ref), u277 (ref), u278 (ref)
        u279 = p509;
        u282 = p509.Buffer;
        u280 = p509.BufferLength;
        u281 = p509.BufferOffset;
        u277 = p509.Instances;
        u278 = p509.InstancesOffset;
    end,
    Export = function() --[[ Name: Export, Line 685 ]]
        -- upvalues: u279 (ref), u280 (ref), u281 (ref), u278 (ref)
        u279.BufferLength = u280;
        u279.BufferOffset = u281;
        u279.InstancesOffset = u278;
        return u279;
    end,
    Truncate = function() --[[ Name: Truncate, Line 692 ]]
        -- upvalues: u281 (ref), u282 (ref), u278 (ref), u277 (ref)
        local v510 = buffer.create(u281);
        buffer.copy(v510, 0, u282, 0, u281);
        if u278 == 0 then
            return v510;
        else
            return v510, u277;
        end;
    end,
    Ended = function() --[[ Name: Ended, Line 698 ]]
        -- upvalues: u281 (ref), u280 (ref)
        return u280 <= u281;
    end,
    Types = v7,
    Reads = v8,
    Writes = v9
};
