-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local u2 = setmetatable;
local v3 = _G.obtain("LuCAS-Constructor");
local l__Metatable__1 = v3.Metatable;
local l__ReturnValue__2 = v3.ReturnValue;
local u4 = {};
local u5 = {};
local function v17(u6, u7, u8) --[[ Line: 15 ]]
    -- upvalues: u4 (copy), u5 (copy), l__ReturnValue__2 (copy), u1 (copy), u2 (copy)
    local u9 = {};
    local u10 = {};
    local v11 = u5;
    u4[u8] = u9;
    v11[u8] = u10;
    u6[u7] = function(p12, p13) --[[ Line: 18 ]]
        -- upvalues: l__ReturnValue__2 (ref), u9 (copy), u10 (copy), u1 (ref), u6 (copy), u2 (ref), u8 (copy), u7 (copy)
        local v14 = l__ReturnValue__2(p12) .. "-" .. l__ReturnValue__2(p13);
        if u9[v14] then
            local v15 = u10[v14];
            local v16 = u1(v15);
            if v16 == "function" then
                return v15(p12, p13);
            end;
            if v16 == "string" then
                return u2({ v15, p12, p13 }, u6);
            end;
            if v16 == "nil" then
                return u2({ u8, p12, p13 }, u6);
            end;
        else
            error("[LuCAS] No rule for " .. u7 .. " " .. v14);
        end;
    end;
end;
v17(l__Metatable__1, "__add", "Add");
v17(l__Metatable__1, "__sub", "Sub");
v17(l__Metatable__1, "__mul", "Mul");
v17(l__Metatable__1, "__div", "Div");
v17(l__Metatable__1, "__mod", "Mod");
v17(l__Metatable__1, "__pow", "Pow");
(function(u18, u19, u20) --[[ Name: MakeMetamethodN, Line 36 ]]
    -- upvalues: u4 (copy), u5 (copy), l__ReturnValue__2 (copy), u1 (copy), u2 (copy)
    local u21 = {};
    local u22 = {};
    local v23 = u5;
    u4[u20] = u21;
    v23[u20] = u22;
    u18[u19] = function(p24, ...) --[[ Line: 39 ]]
        -- upvalues: l__ReturnValue__2 (ref), u21 (copy), u22 (copy), u1 (ref), u18 (copy), u2 (ref), u20 (copy), u19 (copy)
        local v25 = l__ReturnValue__2(p24);
        if u21[v25] then
            local v26 = u22[v25];
            local v27 = u1(v26);
            if v27 == "function" then
                return v26(p24, ...);
            end;
            if v27 == "string" then
                return u2({ v26, p24, ... }, u18);
            end;
            if v27 == "nil" then
                return u2({ u20, p24, ... }, u18);
            end;
        else
            error("[LuCAS] No rule for " .. u19 .. " " .. v25);
        end;
    end;
end)(l__Metatable__1, "__unm", "Unm");
return {
    DefRule = function(p28, p29, p30, p31) --[[ Name: DefRule, Line 67 ]]
        -- upvalues: u5 (copy), u4 (copy)
        u5[p28][p30] = p31;
        u4[p28][p30] = p29;
    end,
    RuleCopy = function(p32, p33, p34) --[[ Name: RuleCopy, Line 71 ]]
        -- upvalues: u5 (copy), u4 (copy)
        u5[p32][p34] = u5[p32][p33];
        u4[p32][p34] = u4[p32][p33];
    end,
    RuleReflect = function(p35, p36, p37) --[[ Name: RuleReflect, Line 75 ]]
        -- upvalues: u5 (copy), u4 (copy)
        local u38 = u5[p35][p36];
        if u38 then
            u5[p35][p37] = function(p39, p40) --[[ Line: 78 ]]
                -- upvalues: u38 (copy)
                u38(p40, p39);
            end;
        end;
        u4[p35][p37] = u4[p35][p36];
    end,
    Metatable = l__Metatable__1
};
