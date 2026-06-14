-- Decompiled from: ReplicatedStorage.Modules.Utility
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local function u6(p2) --[[ Line: 14 ]]
    -- upvalues: u6 (copy)
    local v3 = {};
    for v4, v5 in pairs(p2) do
        if type(v5) == "table" then
            v3[v4] = u6(v5);
        else
            v3[v4] = v5;
        end;
    end;
    return v3;
end;
local function u11(p7, p8) --[[ Line: 26 ]]
    -- upvalues: u6 (copy), u11 (copy)
    for v9, v10 in p8 do
        if type(v9) == "string" then
            if p7[v9] == nil then
                if type(v10) == "table" then
                    p7[v9] = u6(v10);
                else
                    p7[v9] = v10;
                end;
            elseif type(p7[v9]) == "table" and type(v10) == "table" then
                u11(p7[v9], v10);
            end;
        end;
    end;
end;
function deepcopy(p12)
    if type(p12) ~= "table" then
        return p12;
    end;
    local v13 = {};
    for v14, v15 in next, p12 do
        v13[deepcopy(v14)] = deepcopy(v15);
    end;
    local v16 = deepcopy;
    local v17 = getmetatable(p12);
    setmetatable(v13, v16(v17));
    return v13;
end;
function table_eq(p18, p19)
    local u20 = {};
    local function u32(p21, p22) --[[ Line: 60 ]]
        -- upvalues: u20 (copy), u32 (copy)
        if type(p21) ~= type(p22) then
            return false;
        end;
        if type(p21) ~= "table" then
            return p21 == p22;
        end;
        if u20[p21] then
            return u20[p21] == p22;
        end;
        u20[p21] = p22;
        local v23 = {};
        local v24 = {};
        for v25, _ in pairs(p22) do
            if type(v25) == "table" then
                table.insert(v24, v25);
            end;
            v23[v25] = true;
        end;
        for v26, v27 in pairs(p21) do
            local v28 = p22[v26];
            if type(v26) == "table" then
                local v29 = false;
                for v30, v31 in ipairs(v24) do
                    if table_eq(v26, v31) and u32(v27, p22[v31]) then
                        table.remove(v24, v30);
                        v23[v31] = nil;
                        v29 = true;
                        break;
                    end;
                end;
                if not v29 then
                    return false;
                end;
            else
                if v28 == nil then
                    return false;
                end;
                v23[v26] = nil;
                if not u32(v27, v28) then
                    return false;
                end;
            end;
        end;
        return not next(v23);
    end;
    return u32(p18, p19);
end;
function dipairs(...)
    local u33 = { ... };
    local u34 = 1;
    local u35 = 0;
    local u36 = false;
    return function() --[[ Line: 108 ]]
        -- upvalues: u36 (ref), u35 (ref), u33 (copy), u34 (ref)
        if u36 then
            u35 = 0;
            u36 = false;
            if u33[u34] and #u33[u34] == 0 then
                return;
            end;
        end;
        local v37 = u33[u34];
        if v37 then
            u35 = u35 + 1;
            if v37[u35 + 1] == nil then
                u34 = u34 + 1;
                u36 = true;
            end;
            return u35, v37[u35];
        end;
    end;
end;
function dpairs(...)
    local u38 = { ... };
    local u39 = 1;
    local u40 = nil;
    local u41 = false;
    return function() --[[ Line: 125 ]]
        -- upvalues: u41 (ref), u40 (ref), u38 (copy), u39 (ref)
        if u41 then
            u40 = nil;
            u41 = false;
        end;
        local v42 = u38[u39];
        if v42 then
            u40 = next(v42, u40);
            if v42[u40] == nil then
                u39 = u39 + 1;
                u41 = true;
            end;
            return u40, v42[u40];
        end;
    end;
end;
v1.dpairs = dpairs;
v1.dipairs = dipairs;
function v1.Contains(p43, p44) --[[ Line: 5 ]]
    for _, v45 in ipairs(p43) do
        if v45 == p44 then
            return true;
        end;
    end;
    return false;
end;
v1.TableEq = table_eq;
v1.Deepcopy = deepcopy;
v1.ReconcileTable = u11;
function v1.AssertTypes(p46, p47, p48) --[[ Line: 144 ]]
    local v49 = typeof(p46);
    local v50 = p47 or "nil";
    return v49 == v50, (p48 or "Expected type \'%s\' got type \'%s\'"):format(v50, v49);
end;
function v1.CreateFuzzyFinder(p51) --[[ Line: 152 ]]
    local v52 = {};
    for _, v53 in ipairs(p51) do
        v52[v53] = true;
    end;
    return v52;
end;
return v1;
