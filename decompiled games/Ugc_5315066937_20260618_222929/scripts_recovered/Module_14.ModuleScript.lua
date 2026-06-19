-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = typeof;
local u2 = unpack;
local u3 = getmetatable;
local u4 = setmetatable;
local l__FuncReturnTypes__1 = _G.obtain("LuCAS-Base").FuncReturnTypes;
local u5 = {
    __metatable = "spicy"
};
local u6 = {};
local u7 = {};
local function u14(p8) --[[ Line: 38 ]]
    -- upvalues: u3 (copy), l__FuncReturnTypes__1 (copy), u14 (copy), u2 (copy), u1 (copy)
    if u3(p8) == "spicy" then
        local v9 = p8[1];
        local v10 = l__FuncReturnTypes__1[v9];
        if v10 then
            local v11 = type(v10);
            if v11 == "string" then
                return v10;
            end;
            if v11 == "function" then
                local v12 = {};
                for v13 = 2, #p8 do
                    v12[v13 - 1] = u14(p8[v13]);
                end;
                return v10(u2(v12));
            end;
        end;
        error("No type for Head=" .. v9);
    end;
    if p8 == nil then
        error("nil");
    end;
    return u1(p8);
end;
local function u20(p15) --[[ Line: 66 ]]
    -- upvalues: u3 (copy), u20 (copy), u7 (copy)
    local v16;
    if u3(p15) == "spicy" then
        v16 = p15[1];
    else
        v16 = nil;
    end;
    if v16 then
        local v17 = { v16 };
        for v18 = 2, #p15 do
            v17[v18] = u20(p15[v18]);
        end;
        local v19 = u7[v16];
        if v19 then
            return v19(v17);
        else
            return v17;
        end;
    else
        return p15;
    end;
end;
return {
    Metatable = u5,
    Constructors = u6,
    DefConstructor = function(p21, p22, p23) --[[ Name: DefConstructor, Line 20 ]]
        -- upvalues: u6 (copy), u7 (copy)
        u6[p21] = p22;
        u7[p21] = p23;
        return p22;
    end,
    DefaultConstructor = function(u24) --[[ Name: DefaultConstructor, Line 26 ]]
        -- upvalues: u5 (copy), u4 (copy)
        return function(...) --[[ Line: 27 ]]
            -- upvalues: u24 (copy), u5 (ref), u4 (ref)
            return u4({ u24, ... }, u5);
        end;
    end,
    Compile = u20,
    Head = function(p25) --[[ Name: Head, Line 32 ]]
        -- upvalues: u3 (copy)
        if u3(p25) == "spicy" then
            return p25[1];
        end;
    end,
    ReturnValue = u14
};
