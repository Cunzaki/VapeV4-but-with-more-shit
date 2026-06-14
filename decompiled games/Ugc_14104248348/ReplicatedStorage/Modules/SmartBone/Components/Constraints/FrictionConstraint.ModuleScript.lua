-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.FrictionConstraint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) --[[ Line: 1 ]]
    return p3:Lerp(p2, 1 - p1.Friction);
end;
