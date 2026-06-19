-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local u2 = unpack;
local u3 = tostring;
local u4 = _G.obtain("serialize");
local l__move__1 = table.move;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local function u14(...) --[[ Line: 36 ]]
    -- upvalues: u1 (copy)
    local v9 = { ... };
    local v10 = { "Add" };
    for v11 = 1, #v9 do
        local v12 = v9[v11];
        if u1(v12) == "table" and v12[1] == "Add" then
            for v13 = 2, #v12 do
                v10[#v10 + 1] = v12[v13];
            end;
        elseif v12 ~= 0 then
            v10[#v10 + 1] = v12;
        end;
    end;
    if #v10 == 1 then
        return 0;
    elseif #v10 == 2 then
        return v10[2];
    else
        return v10;
    end;
end;
local function u21(...) --[[ Line: 58 ]]
    -- upvalues: u1 (copy)
    local v15 = { ... };
    local v16 = { "Mul" };
    for v17 = 1, #v15 do
        local v18 = v15[v17];
        if u1(v18) == "table" and v18[1] == "Mul" then
            for v19 = 2, #v18 do
                local v20 = v18[v19];
                if v20 == 0 then
                    return 0;
                end;
                if v20 ~= 1 then
                    v16[#v16 + 1] = v18[v19];
                end;
            end;
        else
            if v18 == 0 then
                return 0;
            end;
            if v18 ~= 1 then
                v16[#v16 + 1] = v18;
            end;
        end;
    end;
    if #v16 == 1 then
        return 1;
    elseif #v16 == 2 then
        return v16[2];
    else
        return v16;
    end;
end;
local function u31(p22, p23) --[[ Line: 87 ]]
    -- upvalues: u1 (copy), u31 (copy), u3 (copy), u4 (copy), u2 (copy), u6 (copy)
    local v24 = u1(p22);
    if v24 ~= "table" then
        if v24 == "string" then
            local v25 = p23[p22];
            if v25 ~= nil then
                return v25;
            end;
            local v26 = u6[p22];
            if v26 ~= nil then
                return v26;
            end;
            print("[LuCAS-Base] Could not evaluate Input=" .. p22);
        end;
        return p22;
    end;
    local v27 = {};
    for v28 = 1, #p22 do
        local v29 = u31(p22[v28], p23);
        v27[v28] = v29;
        if v29 == nil then
            error("Argument is nil Head=" .. u3(p22[1]) .. " i=" .. v28 .. " Input[i]=" .. u4(p22[v28]));
        end;
    end;
    local v30 = v27[1];
    if u1(v30) == "function" then
        return v30(u2(v27, 2));
    end;
    print("[LuCAS-Base] Missing function \'" .. u3(v30) .. "\' pass through");
    return u2(v27, 2);
end;
local function u45(p32, p33) --[[ Line: 123 ]]
    -- upvalues: u1 (copy), u7 (copy), u8 (copy), u2 (copy), u21 (copy), u45 (copy), u14 (copy), l__move__1 (copy), u3 (copy)
    if u1(p32) ~= "table" then
        return u1(p32) == "string" and (p32 == p33 and 1 or 0) or (getmetatable(p32) ~= "The metatable is locked" and 0 or p32 * 0);
    end;
    local v34 = p32[1];
    local v35 = u7[v34];
    if v35 == "Partials" then
        local v36 = { u8[v34](u2(p32, 2, #p32)) };
        local v37 = {};
        for v38 = 1, #v36 do
            v37[v38] = u21(u45(p32[v38 + 1], p33), v36[v38]);
        end;
        return u14(u2(v37));
    end;
    if v35 == "Constant" then
        return u21(u45(p32[2], p33), u8[v34]);
    end;
    if v35 == "Independent" then
        local v39 = { p32[1] };
        for v40 = 2, #p32 do
            v39[v40] = u45(p32[v40], p33);
        end;
        return v39;
    end;
    if v35 == "Custom" then
        local v41 = #p32;
        local v42 = l__move__1(p32, 2, v41, 1, {});
        local v43 = {};
        for v44 = 2, v41 do
            v43[v44 - 1] = u45(p32[v44], p33);
        end;
        return u8[v34](v42, v43);
    end;
    print("[LuCAS-Base] Derivative of \'" .. u3(v34) .. "\' unknown.");
end;
return {
    DefEvaluate = function(p46, p47, p48, p49) --[[ Name: DefEvaluate, Line 22 ]]
        -- upvalues: u5 (copy), u6 (copy), u1 (copy), u7 (copy), u8 (copy)
        u5[p46] = p47;
        u6[p46] = p48;
        local v50 = u1(p49);
        if v50 == "function" then
            assert(true, "DefDerivative requires derivative type");
            assert(u7[p46] == nil, "Derivative redefinition!");
            u7[p46] = "Partials";
            u8[p46] = p49;
        elseif v50 == "string" then
            local v51 = u1(p49) == "string";
            assert(v51, "DefDerivative requires derivative type");
            assert(u7[p46] == nil, "Derivative redefinition!");
            u7[p46] = p49;
            u8[p46] = nil;
        else
            if v50 == "number" then
                assert(true, "DefDerivative requires derivative type");
                assert(u7[p46] == nil, "Derivative redefinition!");
                u7[p46] = "Constant";
                u8[p46] = p49;
            end;
        end;
    end,
    DefDerivative = function(p52, p53, p54) --[[ Name: DefDerivative, Line 15 ]]
        -- upvalues: u1 (copy), u7 (copy), u8 (copy)
        local v55 = u1(p53) == "string";
        assert(v55, "DefDerivative requires derivative type");
        assert(u7[p52] == nil, "Derivative redefinition!");
        u7[p52] = p53;
        u8[p52] = p54;
    end,
    FuncReturnTypes = u5,
    Evaluates = u6,
    Evaluate = u31,
    Derivative = u45
};
