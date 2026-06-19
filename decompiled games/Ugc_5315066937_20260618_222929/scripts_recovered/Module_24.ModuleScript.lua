-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local v2 = _G.obtain("Class")();
local u3 = 0;
function v2.Constructor(p4, p5, p6, p7) --[[ Line: 9 ]]
    -- upvalues: u3 (ref)
    if not p5 then
        u3 = u3 + 1;
        p5 = -u3;
    end;
    p4.Id = p5;
    p4.Name = p6 or "Jeffrey";
    p4.userId = p7;
end;
function v2.IsLocal(p8) --[[ Line: 19 ]]
    -- upvalues: u1 (copy)
    local v9;
    if u1(p8.Id) == "number" then
        v9 = p8.Id < 0;
    else
        v9 = false;
    end;
    return v9;
end;
return v2;
