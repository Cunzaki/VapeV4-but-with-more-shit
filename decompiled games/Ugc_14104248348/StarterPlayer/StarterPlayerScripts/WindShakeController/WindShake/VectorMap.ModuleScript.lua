-- Decompiled from: StarterPlayer.StarterPlayerScripts.WindShakeController.WindShake.VectorMap
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 6 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        _voxelSize = p2 or 50,
        _voxels = {}
    }, u1);
end;
function u1._debugDrawVoxel(p3, p4) --[[ Line: 13 ]]
    local v5 = Instance.new("Part");
    v5.Name = tostring(p4);
    v5.Anchored = true;
    v5.CanCollide = false;
    v5.Transparency = 1;
    v5.Size = Vector3.new(1, 1, 1) * p3._voxelSize;
    v5.Position = p4 * p3._voxelSize + Vector3.new(1, 1, 1) * (p3._voxelSize / 2);
    v5.Parent = workspace;
    local v6 = Instance.new("SelectionBox");
    v6.Color3 = Color3.new(0, 0, 1);
    v6.Adornee = v5;
    v6.Parent = v5;
    task.delay(0.03333333333333333, v5.Destroy, v5);
end;
function u1.AddObject(p7, p8, p9) --[[ Line: 31 ]]
    local l__ClassName__1 = p9.ClassName;
    local l___voxelSize__2 = p7._voxelSize;
    local v10 = math.floor(p8.X / l___voxelSize__2);
    local v11 = math.floor(p8.Y / l___voxelSize__2);
    local v12 = math.floor(p8.Z / l___voxelSize__2);
    local v13 = Vector3.new(v10, v11, v12);
    local v14 = p7._voxels[v13];
    if v14 == nil then
        p7._voxels[v13] = {
            [l__ClassName__1] = { p9 }
        };
        return v13;
    elseif v14[l__ClassName__1] == nil then
        v14[l__ClassName__1] = { p9 };
        return v13;
    else
        table.insert(v14[l__ClassName__1], p9);
        return v13;
    end;
end;
function u1.RemoveObject(p15, p16, p17) --[[ Line: 56 ]]
    local v18 = p15._voxels[p16];
    if v18 == nil then
        return;
    end;
    local l__ClassName__3 = p17.ClassName;
    if v18[l__ClassName__3] == nil then
        return;
    end;
    local v19 = v18[l__ClassName__3];
    for v20, v21 in v19 do
        if v21 == p17 then
            local v22 = #v19;
            v19[v20] = v19[v22];
            v19[v22] = nil;
            break;
        end;
    end;
    if #v19 == 0 then
        v18[l__ClassName__3] = nil;
        if next(v18) == nil then
            p15._voxels[p16] = nil;
        end;
    end;
end;
function u1.GetVoxel(p23, p24) --[[ Line: 90 ]]
    return p23._voxels[p24];
end;
function u1.ForEachObjectInRegion(p25, p26, p27, p28) --[[ Line: 94 ]]
    local l___voxelSize__4 = p25._voxelSize;
    local v29 = math.min(p27.X, p26.X);
    local v30 = math.min(p27.Y, p26.Y);
    local v31 = math.min(p27.Z, p26.Z);
    local v32 = math.max(p27.X, p26.X);
    local v33 = math.max(p27.Y, p26.Y);
    local v34 = math.max(p27.Z, p26.Z);
    for v35 = math.floor(v29 / l___voxelSize__4), math.floor(v32 / l___voxelSize__4) do
        for v36 = math.floor(v31 / l___voxelSize__4), math.floor(v34 / l___voxelSize__4) do
            for v37 = math.floor(v30 / l___voxelSize__4), math.floor(v33 / l___voxelSize__4) do
                local v38 = p25._voxels[Vector3.new(v35, v37, v36)];
                if v38 then
                    for v39, v40 in v38 do
                        for _, v41 in v40 do
                            p28(v39, v41);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u1.ForEachObjectInView(p42, p43, p44, p45) --[[ Line: 117 ]]
    local l___voxelSize__5 = p42._voxelSize;
    local l__CFrame__6 = p43.CFrame;
    local l__Position__7 = l__CFrame__6.Position;
    local l__RightVector__8 = l__CFrame__6.RightVector;
    local l__UpVector__9 = l__CFrame__6.UpVector;
    local u46 = p44 / 2;
    local v47 = math.rad((p43.FieldOfView + 5) / 2);
    local u48 = math.tan(v47) * p44;
    local u49 = u48 * (p43.ViewportSize.X / p43.ViewportSize.Y);
    local v50 = l__CFrame__6 * CFrame.new(0, 0, -p44);
    local v51 = v50 * Vector3.new(-u49, u48, 0);
    local v52 = v50 * Vector3.new(u49, u48, 0);
    local v53 = v50 * Vector3.new(-u49, -u48, 0);
    local v54 = v50 * Vector3.new(u49, -u48, 0);
    local u55 = (l__CFrame__6 * CFrame.new(0, 0, -u46)):Inverse();
    local l__Unit__10 = l__UpVector__9:Cross(v54 - l__Position__7).Unit;
    local l__Unit__11 = l__UpVector__9:Cross(v53 - l__Position__7).Unit;
    local l__Unit__12 = l__RightVector__8:Cross(l__Position__7 - v52).Unit;
    local l__Unit__13 = l__RightVector__8:Cross(l__Position__7 - v54).Unit;
    local v56 = l__Position__7:Min(v51):Min(v52):Min(v53):Min(v54);
    local v57 = l__Position__7:Max(v51):Max(v52):Max(v53):Max(v54);
    local v58 = math.floor(v56.X / l___voxelSize__5);
    local v59 = math.floor(v56.Y / l___voxelSize__5);
    local v60 = math.floor(v56.Z / l___voxelSize__5);
    local v61 = Vector3.new(v58, v59, v60);
    local v62 = math.floor(v57.X / l___voxelSize__5);
    local v63 = math.floor(v57.Y / l___voxelSize__5);
    local v64 = math.floor(v57.Z / l___voxelSize__5);
    local v65 = Vector3.new(v62, v63, v64);
    local function v69(p66) --[[ Line: 155 ]]
        -- upvalues: u55 (copy), u49 (copy), u48 (copy), u46 (copy), l__Position__7 (copy), l__Unit__10 (copy), l__Unit__11 (copy), l__Unit__12 (copy), l__Unit__13 (copy)
        local v67 = u55 * p66;
        if u49 < v67.X or (v67.X < -u49 or (u48 < v67.Y or (v67.Y < -u48 or (u46 < v67.Z or v67.Z < -u46)))) then
            return false;
        end;
        local v68 = p66 - l__Position__7;
        return l__Unit__10:Dot(v68) >= 0 and (l__Unit__11:Dot(v68) <= 0 and (l__Unit__12:Dot(v68) >= 0 and l__Unit__13:Dot(v68) <= 0));
    end;
    for v70 = v61.X, v65.X do
        local v71 = v70 * l___voxelSize__5;
        local v72 = math.clamp(v50.X, v71, v71 + l___voxelSize__5);
        for v73 = v61.Y, v65.Y do
            local v74 = v73 * l___voxelSize__5;
            local v75 = math.clamp(v50.Y, v74, v74 + l___voxelSize__5);
            for v83 = v61.Z, v65.Z do
                local v77 = v83 * l___voxelSize__5;
                local v78 = math.clamp(v50.Z, v77, v77 + l___voxelSize__5);
                if v69((Vector3.new(v72, v75, v78))) then
                    local v79 = v61.Z - 1;
                    local l__Z__14 = v65.Z;
                    local v80 = v83;
                    while v83 <= l__Z__14 do
                        local v81 = math.floor((v83 + l__Z__14) / 2);
                        local v82 = math.clamp(v50.Z, v81 * l___voxelSize__5, v81 * l___voxelSize__5 + l___voxelSize__5);
                        if v69((Vector3.new(v72, v75, v82))) then
                            local v83 = v81 + 1;
                        else
                            l__Z__14 = v81 - 1;
                            v81 = v79;
                        end;
                        v79 = v81;
                    end;
                    for v84 = v80, v79 do
                        local v85 = p42._voxels[Vector3.new(v70, v73, v84)];
                        if v85 then
                            for v86, v87 in v85 do
                                for _, v88 in v87 do
                                    p45(v86, v88);
                                end;
                            end;
                        end;
                    end;
                    break;
                end;
            end;
        end;
    end;
end;
function u1.ClearAll(p89) --[[ Line: 238 ]]
    p89._voxels = {};
end;
return u1;
