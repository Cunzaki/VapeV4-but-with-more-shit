-- Decompiled from: ReplicatedStorage.Config.Shared.Voicelines
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
for _, v2 in script:GetDescendants() do
    if v2:IsA("ModuleScript") then
        local v3 = require(v2);
        v1[v2.Name] = v3;
    end;
end;
return v1;
