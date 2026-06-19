-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local v2 = _G.obtain("Class")();
function v2.Call(p3, ...) --[[ Line: 7 ]]
    -- upvalues: u1 (copy)
    for v4, v5 in u1, p3.Objects do
        v5(v4, ...);
    end;
end;
function v2.Register(p6, p7, p8) --[[ Line: 12 ]]
    assert(p8 ~= nil, "Method==nil");
    p6.IsHooked = true;
    p6.Objects[p7] = p8;
end;
function v2.Constructor(p9) --[[ Line: 17 ]]
    p9.Objects = {};
end;
return v2;
