-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__floor__1 = math.floor;
local l__concat__2 = table.concat;
local l__format__3 = string.format;
return function(p1) --[[ Line: 4 ]]
    -- upvalues: l__floor__1 (copy), l__format__3 (copy), l__concat__2 (copy)
    local v2 = l__floor__1(1000 * p1 + 0.5);
    local v3 = l__floor__1(v2 / 1000);
    local v4 = l__floor__1(v3 / 60);
    local v5 = { l__floor__1(v4 / 60), v4 % 60, v3 % 60 };
    local v6 = nil;
    for v7 = 1, #v5 do
        local v8 = v5[v7];
        if v6 then
            v6[#v6 + 1] = l__format__3("%.2i", v8);
        elseif v7 == 2 then
            v6 = { l__format__3("%.2i", v8) };
        elseif v8 ~= 0 then
            v6 = { v8 };
        end;
    end;
    if #v6 < 3 then
        return l__concat__2(v6, ":") .. "." .. l__format__3("%.3i", v2 % 1000);
    else
        return l__concat__2(v6, ":");
    end;
end;
