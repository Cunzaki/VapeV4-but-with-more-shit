-- Decompiled from: ReplicatedStorage.Modules.Deepcopy
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

function deepcopy(p1)
    if type(p1) ~= "table" then
        return p1;
    end;
    local v2 = {};
    for v3, v4 in next, p1 do
        v2[deepcopy(v3)] = deepcopy(v4);
    end;
    local v5 = deepcopy;
    local v6 = getmetatable(p1);
    setmetatable(v2, v5(v6));
    return v2;
end;
return deepcopy;
