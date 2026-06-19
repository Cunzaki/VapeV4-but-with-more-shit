-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = setmetatable;
local l__clone__1 = table.clone;
local u5 = {
    __newindex = function(p2, p3, p4) --[[ Name: SetMetamethod, Line 8 ]]
        p2.Metamethods[p3] = p4;
    end
};
local function u8(p6, p7, ...) --[[ Line: 13 ]]
    -- upvalues: u8 (copy)
    if p6.Base then
        u8(p6.Base, p7, ...);
    end;
    p6.Constructor(p7, ...);
end;
function u5.__call(p9, ...) --[[ Line: 20 ]]
    -- upvalues: u1 (copy), u8 (copy)
    local v10 = u1({}, p9.Metatable);
    u8(p9, v10, ...);
    return v10;
end;
local function u11(...) --[[ Line: 27 ]]
    return ...;
end;
return function(p12) --[[ Name: New, Line 31 ]]
    -- upvalues: l__clone__1 (copy), u11 (copy), u5 (copy), u1 (copy)
    local v13 = not p12 and {} or l__clone__1(p12.Metamethods);
    return u1({
        Base = p12,
        Constructor = u11,
        Metatable = {
            __index = v13
        },
        Metamethods = v13
    }, u5);
end;
