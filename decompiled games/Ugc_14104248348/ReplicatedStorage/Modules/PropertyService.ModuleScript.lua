-- Decompiled from: ReplicatedStorage.Modules.PropertyService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    Checks = {
        Valid = {},
        Defaults = {}
    }
};
function u1.IsCreatable(u2) --[[ Line: 8 ]]
    -- upvalues: u1 (copy)
    local v3 = u1.Checks.Valid[u2];
    if not v3 then
        u1.Checks.Valid[u2] = pcall(function() --[[ Line: 11 ]]
            -- upvalues: u2 (copy)
            Instance.new(u2);
        end);
        v3 = u1.Checks.Valid[u2];
    end;
    return v3;
end;
function u1.GetDefaults(p4, u5) --[[ Line: 19 ]]
    -- upvalues: u1 (copy)
    local u6 = u1.Checks.Defaults[p4];
    if not u6 then
        u1.Checks.Defaults[p4] = Instance.new(p4);
        u6 = u1.Checks.Defaults[p4];
    end;
    local v7, v8 = pcall(function() --[[ Line: 25 ]]
        -- upvalues: u6 (ref), u5 (copy)
        return u6[u5];
    end);
    if v7 then
        return v8;
    end;
end;
return u1;
