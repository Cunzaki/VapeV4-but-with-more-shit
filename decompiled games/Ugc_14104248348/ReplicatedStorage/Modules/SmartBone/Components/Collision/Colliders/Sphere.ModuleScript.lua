-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.Colliders.Sphere
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, p4) --[[ Line: 18 ]]
    local l__Position__1 = p1.Position;
    local v5 = math.min(p2.X, p2.Y, p2.Z) * 0.5;
    local l__Magnitude__2 = (l__Position__1 - p3).Magnitude;
    local v6 = p3 - l__Position__1;
    local v7 = v6.Magnitude == 0 and Vector3.new(0, 0, 0) or v6.Unit;
    local v8 = l__Magnitude__2 <= v5;
    local v9 = l__Position__1 + v7 * v5;
    if v8 then
        return v8, v9, v7;
    else
        return (v9 - p3).Magnitude < p4, v9, v7;
    end;
end;
