-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__insert__1 = table.insert;
local v2 = _G.obtain("Class")();
function v2.GetState(p3, p4) --[[ Line: 11 ]]
    -- upvalues: u1 (copy)
    local v5 = {};
    for v6 in u1, p3.Indices do
        v5[v6] = p4[v6];
    end;
    return v5;
end;
function v2.SetState(p7, p8, p9) --[[ Line: 19 ]]
    -- upvalues: u1 (copy)
    for v10 in u1, p7.Indices do
        p8[v10] = p9[v10];
    end;
end;
function v2.Differentiate(p11, p12, p13) --[[ Line: 26 ]]
    -- upvalues: u1 (copy), l__insert__1 (copy)
    local v14 = {};
    local v15 = {};
    local v16 = true;
    for v17 in u1, p11.Indices do
        local v18 = p13[v17];
        if v18 ~= p12[v17] then
            if v18 == nil then
                l__insert__1(v15, v17);
            else
                v14[v17] = v18;
                v16 = false;
            end;
        end;
    end;
    if #v15 == 0 then
        v15 = nil;
    end;
    if v16 then
        v14 = nil;
    end;
    return v15, v14;
end;
function v2.Integrate(p19, p20, p21, p22) --[[ Line: 50 ]]
    -- upvalues: u1 (copy)
    local l__Indices__2 = p19.Indices;
    if p21 then
        for v23 = 1, #p21 do
            local v24 = p21[v23];
            if l__Indices__2[v24] then
                p20[v24] = nil;
            end;
        end;
    end;
    if p22 then
        for v25, v26 in u1, p22 do
            if l__Indices__2[v25] then
                p20[v25] = v26;
            end;
        end;
    end;
end;
local u30 = {
    GetState = function(p27) --[[ Name: GetState, Line 72 ]]
        return p27.StateCalculus:GetState(p27);
    end,
    SetState = function(p28, p29) --[[ Name: SetState, Line 75 ]]
        p28.StateCalculus:SetState(p28, p29);
    end
};
u30.CopyState = u30.SetState;
function u30.DifferentiateState(p31, p32) --[[ Line: 79 ]]
    return p31.StateCalculus:Differentiate(p31, p32);
end;
function u30.IntegrateState(p33, p34, p35) --[[ Line: 82 ]]
    p33.StateCalculus:Integrate(p33, p34, p35);
end;
function v2.Simple(p36, p37) --[[ Line: 86 ]]
    -- upvalues: u1 (copy), u30 (copy)
    p37.StateCalculus = p36;
    for v38, v39 in u1, u30 do
        p37[v38] = v39;
    end;
end;
function v2.Constructor(p40, p41) --[[ Line: 93 ]]
    local v42 = {};
    for v43 = 1, #p41 do
        v42[p41[v43]] = true;
    end;
    p40.Indices = v42;
end;
return v2;
