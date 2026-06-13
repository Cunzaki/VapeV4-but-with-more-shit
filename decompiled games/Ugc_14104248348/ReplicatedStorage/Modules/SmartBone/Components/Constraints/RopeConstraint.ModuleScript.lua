-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.RopeConstraint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) --[[ Line: 9 ]]
    local v4 = p3.Bones[p1.ParentIndex];
    if v4 then
        local l__FreeLength__1 = p1.FreeLength;
        local v5 = p2 - v4.Position;
        local v6 = v5.Magnitude == 0 and Vector3.new(0, 0, 0) or v5.Unit;
        if v5.Magnitude < l__FreeLength__1 then
            l__FreeLength__1 = v5.Magnitude or l__FreeLength__1;
        end;
        return v4.Position + v6 * l__FreeLength__1;
    end;
end;
