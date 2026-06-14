-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.EncodeDecodeTypes
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__StreamTools__1 = script.Parent.StreamTools;
local l__StringStream__2 = require(l__StreamTools__1.StringStream);
local l__SLEB128Stream__3 = require(l__StreamTools__1.SLEB128Stream);
local l__ULEB128Stream__4 = require(l__StreamTools__1.ULEB128Stream);
local l__UVF128Stream__5 = require(l__StreamTools__1.UVF128Stream);
local l__SVF128Stream__6 = require(l__StreamTools__1.SVF128Stream);
local l__PrefixSizeBlockStream__7 = require(l__StreamTools__1.PrefixSizeBlockStream);
local u1 = {
    Encode = {},
    Decode = {},
    TypeAccept = {
        number = {
            uint = true,
            int = true,
            ufloat = true,
            float = true,
            ffloat = true
        }
    },
    boolean = {
        [1] = true,
        [0] = false,
        [true] = 1,
        [false] = 0
    }
};
function u1.Encode.string(p2, p3) --[[ Line: 33 ]]
    -- upvalues: l__PrefixSizeBlockStream__7 (copy)
    l__PrefixSizeBlockStream__7:Write(p2, p3);
end;
function u1.Decode.string(p4) --[[ Line: 37 ]]
    -- upvalues: l__PrefixSizeBlockStream__7 (copy)
    return l__PrefixSizeBlockStream__7:Read(p4);
end;
function u1.Encode.boolean(p5, p6) --[[ Line: 41 ]]
    -- upvalues: l__StringStream__2 (copy), u1 (copy)
    l__StringStream__2.WriteU8(p5, u1.boolean[p6]);
end;
function u1.Decode.boolean(p7) --[[ Line: 45 ]]
    -- upvalues: u1 (copy), l__StringStream__2 (copy)
    return u1.boolean[l__StringStream__2.ReadU8(p7)];
end;
function u1.Encode.number(p8, p9) --[[ Line: 49 ]]
    -- upvalues: l__StringStream__2 (copy)
    l__StringStream__2.WriteF(p8, p9);
end;
function u1.Decode.number(p10) --[[ Line: 53 ]]
    -- upvalues: l__StringStream__2 (copy)
    return l__StringStream__2.ReadF(p10);
end;
function u1.Encode.int(p11, p12) --[[ Line: 57 ]]
    p11:WriteI4(p12);
end;
function u1.Decode.int(p13) --[[ Line: 61 ]]
    return p13:ReadI4();
end;
function u1.Encode.float(p14, p15) --[[ Line: 65 ]]
    p14:WriteF(p15);
end;
function u1.Decode.float(p16) --[[ Line: 69 ]]
    return p16:ReadF();
end;
function u1.Encode.dfloat(p17, p18) --[[ Line: 73 ]]
    -- upvalues: l__SVF128Stream__6 (copy)
    l__SVF128Stream__6:Write(p17, p18);
end;
function u1.Decode.dfloat(p19) --[[ Line: 77 ]]
    -- upvalues: l__SVF128Stream__6 (copy)
    return l__SVF128Stream__6:Read(p19);
end;
function u1.Encode.dufloat(p20, p21) --[[ Line: 81 ]]
    -- upvalues: l__UVF128Stream__5 (copy)
    l__UVF128Stream__5:Write(p20, p21);
end;
function u1.Decode.dufloat(p22) --[[ Line: 85 ]]
    -- upvalues: l__UVF128Stream__5 (copy)
    return l__UVF128Stream__5:Read(p22);
end;
function u1.Encode.duint(p23, p24) --[[ Line: 89 ]]
    -- upvalues: l__ULEB128Stream__4 (copy)
    l__ULEB128Stream__4:Write(p23, p24);
end;
function u1.Decode.duint(p25) --[[ Line: 93 ]]
    -- upvalues: l__ULEB128Stream__4 (copy)
    return l__ULEB128Stream__4:Read(p25);
end;
function u1.Encode.dint(p26, p27) --[[ Line: 97 ]]
    -- upvalues: l__SLEB128Stream__3 (copy)
    l__SLEB128Stream__3:Write(p26, p27);
end;
function u1.Decode.dint(p28) --[[ Line: 101 ]]
    -- upvalues: l__SLEB128Stream__3 (copy)
    return l__SLEB128Stream__3:Read(p28);
end;
function u1.ValidType(_, p29) --[[ Line: 105 ]]
    -- upvalues: u1 (copy)
    return u1.Encode[p29] and u1.Decode[p29] and true or false;
end;
local l__Encode__8 = u1.Encode;
local l__Decode__9 = u1.Decode;
function u1.EncodeStream(_, p30, p31, p32) --[[ Line: 115 ]]
    -- upvalues: l__Encode__8 (copy)
    l__Encode__8[p31](p30, p32);
end;
function u1.DecodeStream(_, p33, p34) --[[ Line: 121 ]]
    -- upvalues: l__Decode__9 (copy)
    local v35 = l__Decode__9[p34];
    local v36 = "Cannot decode type: " .. tostring(p34);
    assert(v35, v36);
    return l__Decode__9[p34](p33);
end;
return u1;
