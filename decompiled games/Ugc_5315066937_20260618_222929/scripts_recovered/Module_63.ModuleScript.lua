-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__GetChildren__1 = game.GetChildren;
local function u13(p2, p3, p4) --[[ Line: 3 ]]
    -- upvalues: u1 (copy), l__GetChildren__1 (copy), u13 (copy)
    local v5 = u1;
    local v6, v7 = l__GetChildren__1(p2);
    local v8 = {};
    for _, v9 in v5, v6, v7 do
        if not p3 or p3(v9) then
            v8[#v8 + 1] = v9;
        end;
        if not p4 or p4(v9) then
            local v10 = #v8;
            local v11 = u13(v9, p3, p4);
            for v12 = 1, #v11 do
                v8[v10 + v12] = v11[v12];
            end;
        end;
    end;
    return v8;
end;
return u13;
