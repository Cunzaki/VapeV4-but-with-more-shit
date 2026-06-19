-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__byte__1 = string.byte;
local u1 = {
    {
        r = 253,
        g = 41,
        b = 67,
        a = 255
    },
    {
        r = 1,
        g = 162,
        b = 255,
        a = 255
    },
    {
        r = 2,
        g = 184,
        b = 87,
        a = 255
    },
    {
        r = 107,
        g = 50,
        b = 124,
        a = 255
    },
    {
        r = 218,
        g = 133,
        b = 65,
        a = 255
    },
    {
        r = 245,
        g = 205,
        b = 48,
        a = 255
    },
    {
        r = 232,
        g = 186,
        b = 200,
        a = 255
    },
    {
        r = 215,
        g = 197,
        b = 154,
        a = 255
    }
};
return function(p2) --[[ Name: GetNameColour, Line 18 ]]
    -- upvalues: l__byte__1 (copy), u1 (copy)
    local v3 = #p2;
    local v4 = v3 - v3 % 2 + 1;
    local v5 = 0;
    for v6 = 1, v3 do
        v5 = v5 + ((v4 - v6) % 4 < 2 and 1 or -1) * l__byte__1(p2, v6);
    end;
    return u1[v5 % 8 + 1];
end;
