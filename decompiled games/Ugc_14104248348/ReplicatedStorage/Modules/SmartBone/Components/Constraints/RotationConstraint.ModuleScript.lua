-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.RotationConstraint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) --[[ Line: 9 ]]
    local v4 = p3.Bones[p1.ParentIndex];
    if not v4 then
        return p2;
    end;
    local l__RotationLimit__1 = v4.RotationLimit;
    if l__RotationLimit__1 >= 180 then
        return p2;
    end;
    local v5 = p3.Bones[v4.ParentIndex];
    if not v5 then
        return p2;
    end;
    local l__Position__2 = v4.Position;
    local v6 = v4.Position - v5.Position;
    local v7 = v6.Magnitude == 0 and Vector3.new(0, 0, 0) or v6.Unit;
    local l__Magnitude__3 = (p2 - l__Position__2).Magnitude;
    local v8 = p2 - l__Position__2;
    local v9 = v8.Magnitude == 0 and Vector3.new(0, 0, 0) or v8.Unit;
    if l__RotationLimit__1 <= 0 then
        return l__Position__2 + v7 * l__Magnitude__3;
    end;
    local v10 = math.rad(p1.RotationLimit);
    local v11 = v7:Dot(v9);
    if v10 <= math.acos(v11) then
        local v12 = v7:Cross(v9);
        v9 = CFrame.fromAxisAngle(v12.Magnitude == 0 and Vector3.new(0, 0, 0) or v12.Unit, v10) * v7;
    end;
    return l__Position__2 + v9 * l__Magnitude__3;
end;
