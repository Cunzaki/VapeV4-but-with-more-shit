-- Decompiled from: ReplicatedStorage.Config.Shared.Inventory
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
for _, v2 in script:GetChildren() do
    if v2:IsA("ModuleScript") then
        v1[v2.Name] = require(v2);
    end;
end;
return v1;
