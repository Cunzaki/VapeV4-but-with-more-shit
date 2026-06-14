-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.CollisionConstraint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) --[[ Line: 1 ]]
    local v4 = {};
    local v5 = {};
    for _, v6 in p3 do
        local v7 = v6:GetCollisions(p2, p1.Radius);
        if #v7 > 0 then
            table.insert(v4, v6:GetObject());
        end;
        for _, v8 in v7 do
            table.insert(v5, v8);
        end;
    end;
    for _, v9 in v5 do
        p2 = v9.ClosestPoint + v9.Normal * p1.Radius;
    end;
    p1.CollisionsData = v5;
    p1.CollisionHits = v4;
    return p2;
end;
