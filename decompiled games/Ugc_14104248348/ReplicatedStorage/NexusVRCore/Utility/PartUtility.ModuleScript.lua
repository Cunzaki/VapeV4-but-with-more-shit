-- Decompiled from: ReplicatedStorage.NexusVRCore.Utility.PartUtility
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u11 = {
    RaycastToFront = function(p1, p2, p3) --[[ Name: RaycastToFront, Line 10 ]]
        local v4 = (p3 * CFrame.new(0, 0, -p2.Z / 2)):Inverse() * p1;
        local l__LookVector__1 = v4.LookVector;
        local v5 = math.atan2((l__LookVector__1.X ^ 2 + l__LookVector__1.Y ^ 2) ^ 0.5, l__LookVector__1.Z);
        local v6 = v4.Z / math.cos(v5);
        local l__Position__2 = (v4 * CFrame.new(0, 0, v6)).Position;
        return 1 - (0.5 + l__Position__2.X / p2.X), 1 - (0.5 + l__Position__2.Y / p2.Y), -v4.Z * (1 / l__LookVector__1.Z);
    end,
    ProjectToFront = function(p7, p8, p9) --[[ Name: ProjectToFront, Line 32 ]]
        local v10 = (p9 * CFrame.new(0, 0, -p8.Z / 2)):Inverse() * CFrame.new(p7);
        return 1 - (0.5 + v10.X / p8.X), 1 - (0.5 + v10.Y / p8.Y), -v10.Z;
    end
};
function u11.Raycast(p12, p13, p14) --[[ Line: 50 ]]
    -- upvalues: u11 (copy)
    local l__Size__3 = p12.Size;
    if p14 == Enum.NormalId.Front or p14 == "Front" then
        return u11.RaycastToFront(p13, l__Size__3, p12.CFrame);
    end;
    if p14 == Enum.NormalId.Back or p14 == "Back" then
        return u11.RaycastToFront(p13, l__Size__3, p12.CFrame * CFrame.Angles(0, 3.141592653589793, 0));
    end;
    if p14 == Enum.NormalId.Top or p14 == "Top" then
        local v15, v16, v17 = u11.RaycastToFront(p13, Vector3.new(l__Size__3.X, l__Size__3.Z, l__Size__3.Y), p12.CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
        return 1 - v15, v16, v17;
    end;
    if p14 == Enum.NormalId.Bottom or p14 == "Bottom" then
        local v18, v19, v20 = u11.RaycastToFront(p13, Vector3.new(l__Size__3.X, l__Size__3.Z, l__Size__3.Y), p12.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0));
        return v18, 1 - v19, v20;
    end;
    if p14 == Enum.NormalId.Left or p14 == "Left" then
        return u11.RaycastToFront(p13, Vector3.new(l__Size__3.Z, l__Size__3.Y, l__Size__3.X), p12.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    end;
    if p14 == Enum.NormalId.Right or p14 == "Right" then
        return u11.RaycastToFront(p13, Vector3.new(l__Size__3.Z, l__Size__3.Y, l__Size__3.X), p12.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    end;
    error("Unknown face type: " .. tostring(p14));
end;
function u11.Project(p21, p22, p23) --[[ Line: 76 ]]
    -- upvalues: u11 (copy)
    local l__Size__4 = p21.Size;
    if p23 == Enum.NormalId.Front or p23 == "Front" then
        return u11.ProjectToFront(p22, l__Size__4, p21.CFrame);
    end;
    if p23 == Enum.NormalId.Back or p23 == "Back" then
        return u11.ProjectToFront(p22, l__Size__4, p21.CFrame * CFrame.Angles(0, 3.141592653589793, 0));
    end;
    if p23 == Enum.NormalId.Top or p23 == "Top" then
        local v24, v25, v26 = u11.ProjectToFront(p22, Vector3.new(l__Size__4.X, l__Size__4.Z, l__Size__4.Y), p21.CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
        return 1 - v24, v25, v26;
    end;
    if p23 == Enum.NormalId.Bottom or p23 == "Bottom" then
        local v27, v28, v29 = u11.ProjectToFront(p22, Vector3.new(l__Size__4.X, l__Size__4.Z, l__Size__4.Y), p21.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0));
        return v27, 1 - v28, v29;
    end;
    if p23 == Enum.NormalId.Left or p23 == "Left" then
        return u11.ProjectToFront(p22, Vector3.new(l__Size__4.Z, l__Size__4.Y, l__Size__4.X), p21.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    end;
    if p23 == Enum.NormalId.Right or p23 == "Right" then
        return u11.ProjectToFront(p22, Vector3.new(l__Size__4.Z, l__Size__4.Y, l__Size__4.X), p21.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    end;
    error("Unknown face type: " .. tostring(p23));
end;
return u11;
