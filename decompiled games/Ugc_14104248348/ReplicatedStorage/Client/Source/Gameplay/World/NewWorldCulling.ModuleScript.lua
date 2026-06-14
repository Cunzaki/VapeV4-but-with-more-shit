-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.NewWorldCulling
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StarterPlayer__2 = game:GetService("StarterPlayer");
local l__RunService__3 = game:GetService("RunService");
local l__Workspace__4 = game:GetService("Workspace");
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Regions__7 = require(l__ReplicatedStorage__1.Config.Regions);
local l__SpatialHash__8 = require(l__ReplicatedStorage__1.Modules.SpatialHash);
require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
local u1 = {
    Disabled = true,
    TimeElapsed = 0,
    UpdateRate = 0.2,
    Position = 0,
    MaxWork = 50,
    MaxWorkingPerFrame = 0.03333333333333333,
    IgnoreTags = {},
    LoadedRegions = {},
    BoundToRegionData = {},
    SpatialMap = l__SpatialHash__8.NewMap(25),
    Totals = {
        Count = 0,
        CurrentLoaded = 0
    }
};
function u1.ProfileBegin(p2) --[[ Line: 37 ]]
    -- upvalues: u1 (copy)
    u1.ThisLabel = p2;
    debug.profilebegin(p2);
end;
function u1.ProfileEnd() --[[ Line: 43 ]]
    -- upvalues: u1 (copy)
    u1.ThisLabel = nil;
    debug.profileend();
end;
function u1.ProfileWait(p3) --[[ Line: 49 ]]
    -- upvalues: u1 (copy)
    u1.LastBreakWas = os.clock();
    if u1.ThisLabel then
        debug.profileend();
        task.wait(p3);
        debug.profilebegin(u1.ThisLabel);
    end;
end;
function u1.IsCenterTouching(p4, p5) --[[ Line: 59 ]]
    local v6 = p4.CFrame:Inverse();
    local v7 = p4.Size / 2;
    local v8 = v6 * p5.CFrame;
    return math.abs(v8.X) <= v7.X and math.abs(v8.Y) <= v7.Y and math.abs(v8.Z) <= v7.Z;
end;
function u1.Update(p9) --[[ Line: 66 ]]
    -- upvalues: u1 (copy), l__Workspace__4 (copy), l__StarterPlayer__2 (copy), l__Mince__6 (copy)
    local v10 = u1;
    v10.TimeElapsed = v10.TimeElapsed + p9;
    if u1.TimeElapsed > u1.UpdateRate then
        u1.TimeElapsed = 0;
    elseif u1.HRP then
        local l__CurrentCamera__9 = l__Workspace__4.CurrentCamera;
        local l__Position__10 = l__CurrentCamera__9:GetRenderCFrame().Position;
        local v11;
        if l__CurrentCamera__9.CameraSubject and l__CurrentCamera__9.CameraSubject:IsA("Humanoid") then
            v11 = l__CurrentCamera__9.CameraSubject.RootPart.Position;
            if (v11 - l__Position__10).Magnitude > l__StarterPlayer__2.CameraMaxZoomDistance + 5 then
                v11 = l__Position__10;
            end;
        else
            v11 = nil;
        end;
        local v12 = v11 or l__Position__10;
        local v13 = u1.SpatialMap.GetMapID(v12);
        os.clock();
        if v13 ~= u1.LastPlayerMapID then
            u1.LoadedRegionBoundParts = u1.SpatialMap.GetPartsInRadius(v12, 1);
            u1.LastPlayerMapID = v13;
            u1.BeginExit = true;
        end;
        l__Mince__6.Config.Stats.WorldCulling = { 3, (`IP:{u1.Processing}, L:{u1.LoadRegionCount}/UL:{u1.UnloadRegionCount} CNB:{#u1.LoadedRegionBoundParts}, RCID:{v13}, Loaded:({u1.Totals.CurrentLoaded}/{u1.Totals.Count})`) };
        if u1.Processing then
        else
            u1.BeginExit = false;
            u1.Processing = true;
            debug.profilebegin("IsCenterTouching :: CheckingCulling");
            local v14 = {};
            for _, v15 in ipairs(u1.LoadedRegionBoundParts) do
                local v16 = u1.BoundToRegionData[v15];
                if v16 and u1.IsCenterTouching(v15, u1.HRP) then
                    v14[v16.Name] = v16.Name;
                end;
            end;
            debug.profileend();
            u1.SetMaxProcessingTimeForWork(true);
            u1.ProfileBegin("NewWorldCulling :: LoadRegions ");
            u1.LoadRegions(v14);
            u1.ProfileEnd();
            u1.SetMaxProcessingTimeForWork(false);
            u1.Processing = false;
            u1.BeginExit = false;
        end;
    end;
end;
function u1.SetMaxProcessingTimeForWork(p17) --[[ Line: 131 ]]
    -- upvalues: u1 (copy)
    u1.MaxWorking = p17;
    u1.LastBreakWas = os.clock();
end;
function u1.Work(p18) --[[ Line: 137 ]]
    -- upvalues: u1 (copy)
    if u1.MaxWorking then
        local v19 = u1;
        v19.Position = v19.Position + 1;
        if os.clock() - u1.LastBreakWas > u1.MaxWorkingPerFrame then
            u1.Position = 0;
            local v20 = u1.ProfileWait();
            if not (u1.BeginExit and (u1.Processing and p18)) then
                return v20;
            end;
            u1.BeginExit = false;
            u1.Processing = false;
            coroutine.yield();
            return v20;
        end;
    else
        local v21 = u1;
        v21.Position = v21.Position + 1;
        if u1.Position > u1.MaxWork then
            u1.Position = 0;
            local v22 = u1.ProfileWait();
            if not (u1.BeginExit and (u1.Processing and p18)) then
                return v22;
            end;
            u1.BeginExit = false;
            u1.Processing = false;
            coroutine.yield();
            return v22;
        end;
    end;
end;
function u1.LoadRegions(p23) --[[ Line: 176 ]]
    -- upvalues: u1 (copy)
    local v24 = next(p23) == nil;
    local v25 = {};
    for _, v26 in p23 do
        local v27 = u1.LoadedRegions[v26];
        if v27 then
            v25[v26] = true;
            if v27.ConnectedTo then
                for _, v28 in v27.ConnectedTo do
                    v25[v28] = true;
                end;
            end;
        end;
    end;
    local v29 = {};
    local v30 = {};
    if v24 then
        for _, v31 in u1.LoadedRegions do
            if v31.VisibleWhenOutside then
                table.insert(v29, v31);
            else
                table.insert(v30, v31);
            end;
        end;
    else
        for _, v32 in u1.LoadedRegions do
            if v25[v32.Name] then
                table.insert(v29, v32);
            else
                table.insert(v30, v32);
            end;
        end;
        u1.UnloadRegionCount = #v30;
        u1.LoadRegionCount = #v29;
    end;
    local v33 = {};
    for _, v34 in v29 do
        for _, v35 in v34.Parts do
            v33[v35] = true;
            if not v34.Loaded then
                v35.CastShadow = v34.CastShadow[v35];
                v35.LocalTransparencyModifier = 0;
                u1.Work(true);
            end;
        end;
        if not v34.Loaded then
            local l__Totals__11 = u1.Totals;
            l__Totals__11.CurrentLoaded = l__Totals__11.CurrentLoaded + v34.PartCount;
            v34.Loaded = true;
        end;
    end;
    for _, v36 in v30 do
        if not v36.AlwaysVisible and v36.Loaded then
            v36.Loaded = false;
            for _, v37 in v36.Parts do
                if not v33[v37] then
                    v37.CastShadow = false;
                    v37.LocalTransparencyModifier = 1;
                    u1.Work(true);
                end;
            end;
            local l__Totals__12 = u1.Totals;
            l__Totals__12.CurrentLoaded = l__Totals__12.CurrentLoaded - v36.PartCount;
        end;
    end;
end;
function u1.SetRegionData(p38, p39) --[[ Line: 255 ]]
    -- upvalues: u1 (copy)
    p39.Name = p38;
    p39.Position = 0;
    p39.PartBounds = {};
    p39.BoundsLookup = {};
    p39.Loaded = true;
    p39.Parts = {};
    p39.CastShadow = {};
    local v40 = Instance.new("Folder", u1.RegionsFolder);
    v40.Name = p38;
    p39.Folder = v40;
    u1.LoadedRegions[p38] = p39;
end;
function u1.CreateRegionBoundPart(p41, p42, p43) --[[ Line: 271 ]]
    local v44 = Instance.new("Part");
    v44.Locked = true;
    v44.Anchored = true;
    v44.Material = Enum.Material.Neon;
    v44.Transparency = 1;
    v44.Name = `{p41.Name}[{p41.Position}]`;
    v44.CFrame = p42;
    v44.Size = p43;
    return v44;
end;
function u1.AddRegionBound(p45, p46, p47) --[[ Line: 284 ]]
    -- upvalues: u1 (copy), l__Workspace__4 (copy)
    local v48 = u1.LoadedRegions[p45];
    if v48 then
        v48.Position = v48.Position + 1;
        local v49 = u1.CreateRegionBoundPart(v48, p46, p47);
        u1.BoundToRegionData[v49] = v48;
        v49.Parent = v48.Folder;
        u1.SpatialMap.Add(v49);
        local v50 = l__Workspace__4:GetPartsInPart(v49);
        u1.SetMaxProcessingTimeForWork(false);
        u1.ProfileBegin("NewWorldCulling :: FlattenBegin");
        local v51 = {};
        for _, v52 in v50 do
            if not v51[v52.Parent] then
                if v52.Parent and (v52.Parent:IsA("Model") and v52.Parent:FindFirstChild("Humanoid")) then
                    v51[v52.Parent] = true;
                elseif v52.CollisionGroup == "Default" and not v52:GetAttribute("Unflattenable") then
                    u1.Work();
                    table.insert(v48.Parts, v52);
                    local l__Totals__13 = u1.Totals;
                    l__Totals__13.Count = l__Totals__13.Count + 1;
                    local l__Totals__14 = u1.Totals;
                    l__Totals__14.CurrentLoaded = l__Totals__14.CurrentLoaded + 1;
                    v48.CastShadow[v52] = v52.CastShadow;
                end;
            end;
        end;
        u1.ProfileEnd();
        v48.PartCount = #v48.Parts;
        v48.BoundsLookup[v49] = true;
        table.insert(v48.PartBounds, {
            Part = v49
        });
    else
        warn("No reigon for ->", p45);
    end;
end;
function u1.NewCharacter(p53) --[[ Line: 328 ]]
    -- upvalues: u1 (copy)
    u1.HRP = p53:WaitForChild("HumanoidRootPart");
end;
function u1.Setup() --[[ Line: 333 ]]
    -- upvalues: u1 (copy), l__Workspace__4 (copy), l__LocalPlayer__5 (copy), l__Regions__7 (copy), l__RunService__3 (copy)
    if u1.Disabled or l__Workspace__4.StreamingEnabled then
    else
        local v54 = Instance.new("WorldModel", game);
        v54.Name = "WorldRegions";
        u1.RegionsFolder = v54;
        l__LocalPlayer__5.CharacterAdded:Connect(u1.NewCharacter);
        if l__LocalPlayer__5.Character then
            u1.NewCharacter(l__LocalPlayer__5.Character);
        end;
        for v55, v56 in l__Regions__7 do
            u1.SetRegionData(v55, v56);
            for _, v57 in v56.Bounds do
                u1.AddRegionBound(v55, v57.CFrame, v57.Size);
            end;
        end;
        l__RunService__3.Heartbeat:Connect(u1.Update);
    end;
end;
return u1;
