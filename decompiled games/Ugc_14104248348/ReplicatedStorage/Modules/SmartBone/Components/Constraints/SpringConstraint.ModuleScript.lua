-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.SpringConstraint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, p4, p5) --[[ Line: 2 ]]
    local l__Settings__1 = p4.Settings;
    local l__Stiffness__2 = l__Settings__1.Stiffness;
    local l__Elasticity__3 = l__Settings__1.Elasticity;
    local v6 = p4.Bones[p1.ParentIndex];
    if v6 then
        local l__FreeLength__4 = p1.FreeLength;
        if l__Stiffness__2 > 0 or l__Elasticity__3 > 0 then
            local v7 = p3 or (CFrame.new(v6.Position) * v6.TransformOffset.Rotation * CFrame.new(p1.LocalTransformOffset.Position)).Position;
            p2 = p2 + (v7 - p2) * (l__Elasticity__3 * p5);
            if l__Stiffness__2 > 0 then
                local v8 = v7 - p2;
                local l__Magnitude__5 = v8.Magnitude;
                local v9 = l__FreeLength__4 * (1 - l__Stiffness__2) * 2;
                if v9 < l__Magnitude__5 then
                    p2 = p2 + v8 * ((l__Magnitude__5 - v9) / l__Magnitude__5);
                end;
            end;
        end;
        local v10 = v6.Position - p2;
        local l__Magnitude__6 = v10.Magnitude;
        if l__Magnitude__6 > 0 then
            p2 = p2 + v10 * ((l__Magnitude__6 - l__FreeLength__4) / l__Magnitude__6);
        end;
    end;
    return p2;
end;
