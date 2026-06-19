-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local l__floor__1 = math.floor;
local l__match__2 = string.match;
return function(p2) --[[ Line: 5 ]]
    -- upvalues: u1 (copy), l__floor__1 (copy), l__match__2 (copy)
    local v3;
    if u1(p2) == "number" and l__floor__1(p2) == p2 then
        v3 = true;
    elseif u1(p2) == "string" and #p2 <= 20 then
        v3 = l__match__2(p2, "^%d+$");
    else
        v3 = false;
    end;
    return v3;
end;
