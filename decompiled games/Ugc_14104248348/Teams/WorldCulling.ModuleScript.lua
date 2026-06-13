-- Decompiled from: Teams.WorldCulling
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Workspace__2 = game:GetService("Workspace");
local l__RunService__3 = game:GetService("RunService");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__Mince__7 = require(l__ReplicatedStorage__5.Modules.Mince);
local l__Signal__8 = require(l__ReplicatedStorage__5.Modules.Signal);
local l__Regions__9 = require(l__ReplicatedStorage__5.Config.Regions);
local l__Utility__10 = require(l__ReplicatedStorage__5.Modules.Utility);
local l__RotatedRegion3__11 = require(l__ReplicatedStorage__5.Modules.RotatedRegion3);
local l__RegionCulling__12 = require(l__ReplicatedStorage__5.Modules.RegionCulling);
local u2 = {
    __IsAsyncSetup = true,
    IsReady = false,
    Disabled = true,
    FlatteningEnabled = false,
    MaxOperationsPerStep = 0,
    TransparencyOperationsPerStep = 1000,
    ForceDetailedDetection = true,
    MaxWorkingPerFrame = 0.03333333333333333,
    Ready = l__Signal__8.new(),
    BlacklistedNames = l__Utility__10.CreateFuzzyFinder({
        "ExteriorWall",
        "Wall",
        "Walls",
        "Floor",
        "ExteriorFloor"
    }),
    FlattenedTags = {},
    LoadAlwaysTags = l__Mince__7.Config.AlwaysLoadedTags,
    HiddenGeometryContainer = l__RegionCulling__12.ModelCulling.HiddenGeometry,
    ContainersToCull = { l__Workspace__2:WaitForChild("Map"), l__Workspace__2:WaitForChild("Unorganized") },
    IsDisabled = function(p1) --[[ Name: IsDisabled, Line 48 ]]
        return p1.Disabled;
    end
};
function u2.Work() --[[ Line: 52 ]]
    -- upvalues: u2 (copy)
    u2.LastBreakWas = u2.LastBreakWas or os.clock();
    if os.clock() - u2.LastBreakWas > u2.MaxWorkingPerFrame then
        u2.LastBreakWas = os.clock();
        task.wait();
    end;
end;
function u2.SetRenderFocus(p3) --[[ Line: 63 ]]
    -- upvalues: l__Workspace__2 (copy)
    local l__CurrentCamera__13 = l__Workspace__2.CurrentCamera;
    if l__CurrentCamera__13 and l__CurrentCamera__13.CameraSubject then
        if l__CurrentCamera__13.CameraSubject:IsA("Humanoid") then
            if p3 then
                local v4 = typeof(p3) == "Vector3";
                assert(v4, "RenderFocus can only be a Vector3~!");
            end;
            l__CurrentCamera__13.CameraSubject:SetAttribute("RenderFocus", p3);
        end;
    end;
end;
function u2.ContextFilter(p5) --[[ Line: 71 ]]
    -- upvalues: u2 (copy)
    for _, v6 in u2.FlattenedTags do
        if p5:HasTag(v6) then
            return false, `Instance has tag {v6}.`;
        end;
    end;
    return true;
end;
function u2.Update() --[[ Line: 81 ]]
    -- upvalues: l__RunService__3 (copy), l__Mince__7 (copy)
    if l__RunService__3:IsStudio() then
    else
        l__Mince__7.Config.Stats.WorldCulling[2] = "Cannot provide any stats outside of studio! ";
    end;
end;
function u2.IsSimple(p7) --[[ Line: 101 ]]
    -- upvalues: u2 (copy)
    if p7 then
        return p7:HasTag("SimpleRegion") and true or u2.IsSimple(p7.Parent);
    else
        return false;
    end;
end;
function u2.IsBlacklisted(p8) --[[ Line: 111 ]]
    -- upvalues: u2 (copy)
    if p8 then
        return u2.BlacklistedNames[p8.Name] and true or u2.IsBlacklisted(p8.Parent);
    else
        return false;
    end;
end;
function u2.IsOverlappingRegion(p9, p10, p11) --[[ Line: 121 ]]
    -- upvalues: l__Regions__9 (copy), u2 (copy), l__RotatedRegion3__11 (copy)
    for _, v12 in l__Regions__9[p9].Bounds do
        u2.SizePart.Size = p11;
        u2.SizePart.CFrame = p10;
        if l__RotatedRegion3__11.Block(v12.CFrame, v12.Size):CastPart(u2.SizePart) then
            return true;
        end;
    end;
    return false;
end;
function u2.IsInRegion(p13, p14) --[[ Line: 133 ]]
    -- upvalues: l__Regions__9 (copy)
    for _, v15 in l__Regions__9[p13].Bounds do
        local v16 = v15.CFrame:Inverse() * p14;
        local v17 = v15.Size / 2;
        if math.abs(v16.X) <= v17.X and (math.abs(v16.Y) <= v17.Y and math.abs(v16.Z) <= v17.Z) then
            return true;
        end;
    end;
    return false;
end;
function u2.GetRegions(p18, p19) --[[ Line: 144 ]]
    -- upvalues: l__Regions__9 (copy), u2 (copy)
    local v20 = {};
    for v21, v22 in l__Regions__9 do
        u2.Work();
        if not v22.AlwaysVisible and u2.IsOverlappingRegion(v21, p18, p19) then
            table.insert(v20, v21);
        end;
    end;
    return v20;
end;
function u2.GetRegion(p23) --[[ Line: 159 ]]
    -- upvalues: l__Regions__9 (copy), u2 (copy)
    for v24, v25 in l__Regions__9 do
        u2.Work();
        if not v25.AlwaysVisible and u2.IsInRegion(v24, p23) then
            return v24;
        end;
    end;
    return nil;
end;
function u2.GetSizeDetails(p26) --[[ Line: 173 ]]
    if p26:IsA("Model") then
        return p26:GetBoundingBox();
    else
        return p26.CFrame, p26.Size;
    end;
end;
function u2.GetCenter(p27) --[[ Line: 180 ]]
    if not p27:IsA("Model") then
        return p27.CFrame;
    end;
    local v28, _ = p27:GetBoundingBox();
    return v28;
end;
function u2.AddGeometry(p29) --[[ Line: 188 ]]
    -- upvalues: u2 (copy), l__RegionCulling__12 (copy)
    u2.Work();
    if u2.IsBlacklisted(p29) then
    elseif p29:IsA("Folder") or p29:GetAttribute("Flatten") then
        for _, v30 in p29:GetChildren() do
            u2.AddGeometry(v30);
        end;
    else
        if p29:IsA("BasePart") or p29:IsA("Model") then
            if u2.ForceDetailedDetection and not u2.IsSimple(p29) then
                local v31, v32 = u2.GetSizeDetails(p29);
                local v33 = u2.GetRegions(v31, v32);
                if #v33 == 0 then
                    return;
                else
                    for _, v34 in v33 do
                        local v35 = l__RegionCulling__12.ModelCulling:BindModelToRegion(v34, p29);
                        if u2.FlatteningEnabled then
                            v35:EnableFlattening();
                        end;
                        if next(u2.FlattenedTags) then
                            v35:AddFlatteningFilter(u2.ContextFilter);
                        end;
                    end;
                    return;
                end;
            end;
            local v36 = u2.GetCenter(p29);
            local v37 = u2.GetRegion(v36);
            if not v37 then
                return;
            end;
            local v38 = l__RegionCulling__12.ModelCulling:BindModelToRegion(v37, p29);
            if u2.FlatteningEnabled then
                v38:EnableFlattening();
            end;
            if next(u2.FlattenedTags) then
                v38:AddFlatteningFilter(u2.ContextFilter);
            end;
        end;
    end;
end;
function u2.Setup() --[[ Line: 241 ]]
    -- upvalues: u2 (copy), l__Mince__7 (copy), l__LocalPlayer__6 (copy), l__Regions__9 (copy), l__RegionCulling__12 (copy), l__CollectionService__4 (copy), l__Workspace__2 (copy)
    if u2.Disabled or game:GetService("VRService").VREnabled then
        l__Mince__7.Config.Stats.WorldCulling = { 3, "DISABLED" };
    else
        local v39 = Instance.new("Folder");
        v39.Name = "CulllingEscape";
        v39.Parent = game.Workspace;
        local v40 = Instance.new("Part");
        v40.Anchored = true;
        u2.SizePart = v40;
        u2.CullingEscape = v39;
        if not game:IsLoaded() then
            game.Loaded:Wait();
        end;
        if not l__LocalPlayer__6.Character then
            l__LocalPlayer__6.CharacterAdded:Wait();
        end;
        for v41, v42 in l__Regions__9 do
            if #v42.Bounds ~= 0 then
                for _, v43 in v42.Bounds do
                    l__RegionCulling__12.RegionState:AddRegion(v41, v43.CFrame, v43.Size);
                end;
                if v42.VisibleWhenOutside then
                    l__RegionCulling__12.RegionState:SetVisibleWhenOutsideRegions(v41);
                end;
            end;
        end;
        for v44, v45 in l__Regions__9 do
            if #v45.Bounds ~= 0 then
                for _, v46 in v45.ConnectedTo do
                    l__RegionCulling__12.RegionState:ConnectRegions(v44, v46);
                end;
            end;
        end;
        l__RegionCulling__12.ModelCulling.ReparentOperationsPerStep = u2.MaxOperationsPerStep;
        l__RegionCulling__12.ModelCulling.TransparencyOperationsPerStep = u2.TransparencyOperationsPerStep;
        for _, v47 in u2.LoadAlwaysTags do
            for _, v48 in l__CollectionService__4:GetTagged(v47) do
                if v48:IsDescendantOf(l__Workspace__2) and not v48:HasTag("DontReparentCulling") then
                    v48.Parent = v39;
                end;
            end;
        end;
        for _, v49 in u2.ContainersToCull do
            u2.AddGeometry(v49);
        end;
        l__Mince__7.Config.Stats.WorldCulling = { 3, "IDLE" };
        task.spawn(function() --[[ Line: 312 ]]
            -- upvalues: u2 (ref)
            while true do
                u2.Update();
                task.wait(0.1);
            end;
        end);
        l__RegionCulling__12:Start();
        u2.IsReady = true;
        u2.Ready:Fire();
    end;
end;
return u2;
