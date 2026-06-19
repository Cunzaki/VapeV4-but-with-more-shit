-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = type;
local u3 = typeof;
local u4 = tostring;
local l__format__1 = string.format;
local l__sort__2 = table.sort;
local l__concat__3 = table.concat;
local function u19(p5, p6, p7) --[[ Line: 12 ]]
    -- upvalues: u2 (copy), u4 (copy), l__format__1 (copy), u1 (copy), u19 (ref), l__concat__3 (copy), l__sort__2 (copy), u3 (copy)
    local v8 = p7 and p7 + 1 or 1;
    local v9 = p6 or {};
    local v10 = v9[p5];
    if v10 then
        return "SELF" .. v8 - v10;
    end;
    local v11 = u2(p5);
    if v11 == "nil" or (v11 == "boolean" or v11 == "number") then
        return u4(p5);
    end;
    if v11 == "string" then
        return l__format__1("%q", p5);
    end;
    if v11 ~= "table" then
        return u3(p5) .. ":" .. u4(p5);
    end;
    v9[p5] = v8;
    local v12 = 0;
    local v13 = {};
    local v14 = {};
    while p5[v12 + 1] do
        v12 = v12 + 1;
    end;
    local v15 = 0;
    for v16, v17 in u1, p5 do
        local v18 = u19(v17, v9, v8);
        v13[#v13 + 1] = "[" .. u19(v16, v9, v8) .. "]=" .. v18;
        v14[v16] = v18;
        if v18 == nil then
            print("sv nil", v17);
        end;
        v15 = v15 + 1;
    end;
    v9[p5] = nil;
    if v15 == v12 then
        return "{" .. l__concat__3(v14, ",") .. "}";
    end;
    l__sort__2(v13);
    return "{" .. l__concat__3(v13, ",") .. "}";
end;
return u19;
