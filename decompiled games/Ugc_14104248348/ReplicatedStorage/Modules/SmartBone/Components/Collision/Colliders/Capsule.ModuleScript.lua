-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.Colliders.Capsule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, p4) --[[ Line: 27 ]]
    local v5 = (p2.Y < p2.Z and p2.Y or p2.Z) * 0.5;
    local l__X__1 = p2.X;
    local v6 = p1 * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0);
    local l__Position__2 = v6.Position;
    local l__UpVector__3 = v6.UpVector;
    local v7 = l__X__1 * 0.5;
    local v8 = (p3 - l__Position__2):Dot(l__UpVector__3);
    local v9 = l__Position__2 + l__UpVector__3 * math.clamp(v8, -v7, v7);
    local l__Magnitude__4 = (v9 - p3).Magnitude;
    local v10 = p3 - v9;
    local v11 = v10.Magnitude == 0 and Vector3.new(0, 0, 0) or v10.Unit;
    local v12 = l__Magnitude__4 <= v5;
    local v13 = v9 + v11 * v5;
    if v12 then
        return v12, v13, v11;
    else
        return (v13 - p3).Magnitude < p4, v13, v11;
    end;
end;
