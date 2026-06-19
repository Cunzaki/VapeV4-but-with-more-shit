-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = print;
local l__match__1 = string.match;
local l__traceback__2 = debug.traceback;
return function(...) --[[ Line: 4 ]]
    -- upvalues: l__traceback__2 (copy), l__match__1 (copy), u1 (copy)
    local v2 = l__traceback__2();
    local v3 = l__match__1(v2, ":.-%.([^\n%.]+:%d+)");
    if v3 then
        u1("[" .. v3 .. "]", ...);
    else
        u1("@@@@@@LabelPrint@@@@@@", v2, ...);
    end;
end;
