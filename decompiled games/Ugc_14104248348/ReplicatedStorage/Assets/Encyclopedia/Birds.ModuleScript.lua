-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Birds
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
for _, v2 in script:GetChildren() do
    local v3 = require(v2);
    v1[v3._id] = v3;
end;
return v1;
