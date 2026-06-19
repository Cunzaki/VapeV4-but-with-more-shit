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
    for _, v4 in u1, p3.Functions do
        v4(...);
    end;
end;
function v2.CallWithIncludes(p5, p6, ...) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    for v7, v8 in u1, p5.Functions do
        if p6[v7] ~= false then
            v8(...);
        end;
    end;
end;
function v2.Register(p9, p10, p11) --[[ Line: 19 ]]
    assert(p11 ~= nil, "[Multicall] Register Func==nil");
    p9.Functions[p10] = p11;
end;
function v2.Constructor(p12) --[[ Line: 23 ]]
    p12.Functions = {};
end;
return v2;
