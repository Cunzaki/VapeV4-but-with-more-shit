-- Decompiled from: ReplicatedStorage.Modules.FastCastRedux.TypeMarshaller
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = typeof;
return function(p2) --[[ Name: typeof, Line 5 ]]
    -- upvalues: u1 (copy)
    local v3 = u1(p2);
    if v3 == "table" then
        local v4 = getmetatable(p2);
        if u1(v4) == "table" then
            local l____type__1 = v4.__type;
            if l____type__1 == nil then
                return v3;
            else
                return l____type__1;
            end;
        else
            return v3;
        end;
    else
        return v3;
    end;
end;
