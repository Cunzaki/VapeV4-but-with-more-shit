-- Decompiled from: ReplicatedStorage.Assets.Library.Database
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
for _, v2 in script:GetChildren() do
    v1[v2.Name] = require(v2);
end;
return v1;
