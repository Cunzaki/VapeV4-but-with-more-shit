-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__min__1 = math.min;
local l__max__2 = math.max;
local l__floor__3 = math.floor;
return function(p1, p2, p3) --[[ Line: 4 ]]
    -- upvalues: l__floor__3 (copy), l__max__2 (copy), l__min__1 (copy)
    local v4 = #p1;
    if v4 == 0 then
        return 1;
    end;
    if p2 < p1[1][1] then
        return 1;
    end;
    if p1[v4][1] <= p2 then
        return v4 + 1;
    end;
    local v5 = 1;
    local v6, v7;
    if p3 then
        if p3 < 1 then
            p3 = 1;
        elseif v4 < p3 then
            p3 = v4;
        end;
        local v8 = l__floor__3(v4 / 32);
        v6 = l__max__2(p3 - v8, 1);
        v7 = l__min__1(p3 + v8, v4);
        if p2 < p1[v6][1] then
            v7 = v6;
            v6 = v5;
        elseif p1[v7][1] <= p2 then
            v6 = v7;
            v7 = v4;
        end;
    else
        v6 = v5;
        v7 = v4;
    end;
    while v7 - v6 > 4 do
        local v9 = l__floor__3((v6 + v7) / 2);
        if p1[v9][1] <= p2 then
            v6 = v9;
            v9 = v7;
        end;
        v7 = v9;
    end;
    for v10 = v7, v6, -1 do
        if p1[v10][1] <= p2 then
            return v10 + 1;
        end;
    end;
    print("GetIndexAfter unsolvable bisection NEvents=", v4, "Target=", p2, "TUpper=", p1[v7][1], "TLower=", p1[v6][1]);
    for v11 = v4, 1, -1 do
        if p1[v11][1] <= p2 then
            return v11 + 1;
        end;
    end;
end;
