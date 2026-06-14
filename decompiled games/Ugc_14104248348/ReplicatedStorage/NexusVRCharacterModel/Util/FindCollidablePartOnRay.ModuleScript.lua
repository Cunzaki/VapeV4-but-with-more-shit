-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Util.FindCollidablePartOnRay
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
return function(p1, p2, p3, p4) --[[ Line: 6 ]]
    -- upvalues: l__Workspace__1 (copy)
    if typeof(p4) == "Instance" and p4:IsA("BasePart") then
        p4 = p4.CollisionGroup;
    end;
    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Exclude;
    v5.FilterDescendantsInstances = { l__Workspace__1.CurrentCamera };
    if p3 then
        v5:AddToFilter(p3);
    end;
    v5.IgnoreWater = true;
    if p4 then
        v5.CollisionGroup = p4;
    end;
    while true do
        local v6 = l__Workspace__1:Raycast(p1, p2, v5);
        if not v6 then
            break;
        end;
        local l__Instance__2 = v6.Instance;
        local l__Position__3 = v6.Position;
        if not l__Instance__2 or (l__Instance__2.CanCollide or l__Instance__2:IsA("Seat") and (l__Instance__2:IsA("VehicleSeat") and not l__Instance__2.Disabled)) then
            return l__Instance__2, l__Position__3;
        end;
        v5:AddToFilter(l__Instance__2);
    end;
    return nil, p1 + p2;
end;
