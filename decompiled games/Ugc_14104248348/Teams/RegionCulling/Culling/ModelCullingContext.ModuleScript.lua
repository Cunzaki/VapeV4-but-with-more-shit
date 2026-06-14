-- Decompiled from: Teams.RegionCulling.Culling.ModelCullingContext
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 35 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        FlatteningEnabled = false,
        ClusteringEnabled = false,
        Model = p2,
        ModelCulling = p3,
        ModelParent = p2.Parent,
        HiddenParts = {},
        FlatteningFilters = {},
        UnflattenableModelCache = {}
    }, u1);
end;
function u1.EnableFlattening(p4, p5) --[[ Line: 55 ]]
    p4.FlatteningEnabled = true;
    p4.ReparentOperationsPerStep = p5;
    if not p4.Model:FindFirstChild("StaticParts") then
        local v6 = Instance.new("Folder");
        v6.Name = "StaticParts";
        v6.Parent = p4.Model;
    end;
    return p4;
end;
function u1.EnableClustering(p7, p8) --[[ Line: 75 ]]
    p7.ClusteringEnabled = true;
    p7.PartClusterSize = p8;
    return p7;
end;
function u1.AddFlatteningFilter(p9, p10) --[[ Line: 90 ]]
    table.insert(p9.FlatteningFilters, p10);
    return p9;
end;
function u1.CanFlatten(p11, p12) --[[ Line: 98 ]]
    for _, v13 in p11.FlatteningFilters do
        local v14, _ = v13(p12);
        if not v14 then
            return false;
        end;
    end;
    for _, v15 in p12:GetChildren() do
        if not p11:CanFlatten(v15) then
            return false;
        end;
    end;
    return true;
end;
function u1.CanFlattenCaching(p16, p17) --[[ Line: 120 ]]
    local l__UnflattenableModelCache__1 = p16.UnflattenableModelCache;
    if not (l__UnflattenableModelCache__1[p17] or p16:CanFlatten(p17)) then
        l__UnflattenableModelCache__1[p17] = true;
    end;
    return l__UnflattenableModelCache__1[p17] ~= true;
end;
function u1.FlattenModel(p18) --[[ Line: 131 ]]
    if p18.FlatteningEnabled then
        local v19 = p18.Model:FindFirstChild("StaticParts");
        if v19 then
            for _, v20 in p18.Model:GetChildren() do
                if v20 ~= v19 and p18:CanFlattenCaching(v20) then
                    if v20:FindFirstChildOfClass("Humanoid") then
                        v20.Parent = v19;
                    else
                        for _, v21 in v20:GetDescendants() do
                            if v21:FindFirstChildOfClass("Humanoid") then
                                v21.Parent = v19;
                            end;
                        end;
                        if v20:IsA("BasePart") then
                            v20.Parent = v19;
                        end;
                        for _, v22 in v20:GetDescendants() do
                            if v22:IsA("BasePart") then
                                v22.Parent = v19;
                            end;
                        end;
                    end;
                end;
            end;
            if p18.ClusteringEnabled then
                local v23 = p18.PartClusterSize or p18.ModelCulling.PartClusterSize;
                local l__HiddenGeometry__2 = p18.ModelCulling.HiddenGeometry;
                local v24 = {};
                for _, v25 in v19:GetChildren() do
                    if v25:IsA("BasePart") then
                        table.insert(v24, v25);
                    end;
                end;
                for v26 = 1, math.floor(#v24 / v23) do
                    local v27 = Instance.new("Folder");
                    v27.Name = "PartCluster";
                    if p18.Model:IsDescendantOf(l__HiddenGeometry__2) then
                        table.insert(p18.HiddenParts, {
                            Part = v27,
                            Parent = v19
                        });
                        v27.Parent = l__HiddenGeometry__2;
                    else
                        v27.Parent = v19;
                    end;
                    for v28 = 1, v23 do
                        v24[(v26 - 1) * v23 + v28].Parent = v27;
                    end;
                end;
            end;
        end;
    end;
end;
function u1.GetSummary(p29) --[[ Line: 191 ]]
    local v30 = {
        FlattenedParts = 0,
        UnflattenedParts = 0,
        Model = p29.Model,
        Issues = {}
    };
    local v31 = p29.Model:GetDescendants();
    local v32 = {};
    local v33 = {};
    for _, v34 in p29.HiddenParts do
        table.insert(v32, v34.Part);
        for _, v35 in v34.Part:GetDescendants() do
            table.insert(v33, v35);
        end;
    end;
    local v36 = p29.Model:FindFirstChild("StaticParts");
    for _, v37 in { v31, v32, v33 } do
        for _, v38 in v37 do
            if v38:IsA("BasePart") then
                if v36 and (v38:IsDescendantOf(v36) or not v38:IsDescendantOf(p29.Model)) then
                    v30.FlattenedParts = v30.FlattenedParts + 1;
                else
                    v30.UnflattenedParts = v30.UnflattenedParts + 1;
                end;
            end;
            local v39 = {};
            for _, v40 in p29.FlatteningFilters do
                local v41, v42 = v40(v38);
                if not v41 then
                    table.insert(v39, v42);
                end;
            end;
            if #v39 > 0 then
                table.insert(v30.Issues, {
                    Instance = v38,
                    Issues = v39
                });
            end;
        end;
    end;
    return v30;
end;
function u1.HideModel(p43, p44) --[[ Line: 248 ]]
    local v45 = p43.Model:FindFirstChild("StaticParts");
    local l__HiddenGeometry__3 = p43.ModelCulling.HiddenGeometry;
    if v45 then
        local v46 = v45:GetChildren();
        for v47 = #v46, 1, -1 do
            if p44 <= 0 then
                break;
            end;
            local v48 = v46[v47];
            v48.Parent = l__HiddenGeometry__3;
            table.insert(p43.HiddenParts, {
                Part = v48,
                Parent = v45
            });
            p44 = p44 + -((v48:IsA("Model") or v48:IsA("Folder")) and (#v48:GetChildren() or 1) or 1);
        end;
    end;
    if p44 > 0 and (p43.Model.Parent ~= l__HiddenGeometry__3 and (not v45 or #v45:GetChildren() == 0)) then
        local v49 = 0;
        for _, v50 in p43.Model:GetDescendants() do
            if v50:IsA("BasePart") then
                v49 = v49 + 1;
            end;
        end;
        p43.Model.Parent = l__HiddenGeometry__3;
        p44 = p44 + -v49;
    end;
    return math.max(0, p44);
end;
function u1.ShowModel(p51, p52) --[[ Line: 282 ]]
    if p51.Model.Parent ~= p51.ModelParent then
        local v53 = 0;
        for _, v54 in p51.Model:GetDescendants() do
            if v54:IsA("BasePart") then
                v53 = v53 + 1;
            end;
        end;
        p51.Model.Parent = p51.ModelParent;
        p52 = p52 + -v53;
    end;
    for v55 = #p51.HiddenParts, 1, -1 do
        if p52 <= 0 then
            break;
        end;
        local v56 = table.remove(p51.HiddenParts, v55);
        local l__Part__4 = v56.Part;
        l__Part__4.Parent = v56.Parent;
        p52 = p52 + -(l__Part__4:IsA("BasePart") and 1 or #l__Part__4:GetChildren());
    end;
    return math.max(0, p52);
end;
return u1;
