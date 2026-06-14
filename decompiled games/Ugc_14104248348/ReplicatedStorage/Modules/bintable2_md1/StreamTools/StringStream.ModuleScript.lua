-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.StringStream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u11 = {
    new = function(p1) --[[ Name: new, Line 4 ]]
        local v2 = p1 or {};
        v2.Buffer = "";
        v2.BytePosition = 0;
        return v2;
    end,
    fromString = function(p3, p4) --[[ Name: fromString, Line 11 ]]
        local v5 = p3 or {};
        v5.Buffer = p4;
        v5.BytePosition = 0;
        return v5;
    end,
    ToString = function(p6) --[[ Name: ToString, Line 18 ]]
        return p6.Buffer;
    end,
    EOF = function(p7) --[[ Name: EOF, Line 22 ]]
        return p7.BytePosition >= #p7.Buffer;
    end,
    Length = function(p8) --[[ Name: Length, Line 26 ]]
        return #p8.Buffer;
    end,
    WriteI4 = function(p9, p10) --[[ Name: WriteI4, Line 30 ]]
        string.packsize("i4");
        p9:WriteString(string.pack("i4", p10));
    end
};
function u11.WriteF(p12, p13) --[[ Line: 36 ]]
    -- upvalues: u11 (copy)
    string.packsize("f");
    u11.WriteString(p12, string.pack("f", p13));
end;
function u11.ReadU8(p14) --[[ Line: 41 ]]
    assert(p14.BytePosition < #p14.Buffer, "Reading out of range!");
    local v15 = p14.Buffer:byte(p14.BytePosition + 1);
    p14.BytePosition = p14.BytePosition + 1;
    return v15;
end;
function u11.ReadString(p16, p17) --[[ Line: 49 ]]
    local v18 = type(p17) == "number";
    assert(v18, "Expected number!");
    assert(p16.BytePosition + p17 <= #p16.Buffer, "Reading out of range!");
    local v19 = p16.Buffer:sub(p16.BytePosition + 1, p16.BytePosition + p17);
    p16.BytePosition = p16.BytePosition + p17;
    return v19;
end;
function u11.ReadI4(p20, _) --[[ Line: 58 ]]
    local v21, _ = string.unpack("i4", p20:ReadString(string.packsize("i4")));
    return v21;
end;
function u11.ReadF(p22, _) --[[ Line: 63 ]]
    -- upvalues: u11 (copy)
    local v23, _ = string.unpack("f", u11.ReadString(p22, string.packsize("f")));
    return v23;
end;
function u11.WriteU8(p24, p25) --[[ Line: 68 ]]
    local v26;
    if p25 >= 0 then
        v26 = p25 <= 255;
    else
        v26 = false;
    end;
    assert(v26, string.format("number out of range! (%s)", p25));
    p24.Buffer = p24.Buffer .. string.char(p25);
    p24.BytePosition = p24.BytePosition + 1;
end;
function u11.WriteString(p27, p28) --[[ Line: 74 ]]
    local v29 = type(p28) == "string";
    assert(v29, "Expected string!");
    local v30 = #p28;
    p27.Buffer = p27.Buffer .. p28;
    p27.BytePosition = p27.BytePosition + v30;
end;
function u11.Rewind(p31) --[[ Line: 83 ]]
    p31.BytePosition = 0;
end;
return u11;
