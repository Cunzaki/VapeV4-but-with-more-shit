-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Area.LightArea
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__RunService__3 = game:GetService("RunService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__RotatedRegion3__5 = require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
local l__SpatialHash__6 = require(l__ReplicatedStorage__1.Modules.SpatialHash);
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__EnvironmentUtil__8 = require(l__ReplicatedStorage__1.Modules.EnvironmentUtil);
local u1 = {
    Tag = "LightArea",
    UseRobloxSpatialQuery = false,
    UseNexusDetectionMethod = true,
    ScanRate = 0,
    LastPlayerMapID = "000000",
    TimeElapsed = 0,
    LightAreas = {},
    LightAreasByBasePart = {},
    OverlapParam = OverlapParams.new(),
    ScanAreas = {},
    SpatialMap = l__SpatialHash__6.NewMap(25),
    DefaultFolder = l__ReplicatedStorage__1.Assets.Lighting.Default
};
u1.OverlapParam.FilterType = Enum.RaycastFilterType.Whitelist;
function u1.ScanLightArea(p2) --[[ Line: 48 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__4 (copy), l__RotatedRegion3__5 (copy)
    local v3 = false;
    if u1.UseRobloxSpatialQuery then
        for _, v4 in game.Workspace:GetPartsInPart(p2.BasePart, u1.OverlapParam) do
            if v4.Parent == l__LocalPlayer__4.Character then
                v3 = true;
            end;
        end;
    elseif u1.HRP then
        if u1.UseNexusDetectionMethod then
            debug.profilebegin("NexusDetection :: SoundArea");
            local v5 = p2.CFrame:Inverse();
            local v6 = p2.Size / 2;
            local v7 = v5 * u1.HRP.CFrame;
            local v8 = (math.abs(v7.X) > v6.X or math.abs(v7.Y) > v6.Y) and true or math.abs(v7.Z) > v6.Z;
            debug.profileend();
            v3 = not v8;
        else
            v3 = l__RotatedRegion3__5.FromPart(p2.BasePart):CastPart(u1.HRP);
        end;
    end;
    if p2.PlayerInArea ~= v3 then
        u1.UpdateAreaStatus(p2, v3);
    end;
end;
function u1.GetNextArea() --[[ Line: 78 ]]
    -- upvalues: u1 (copy)
    for _, v9 in u1.LightAreas do
        if v9.PlayerInArea then
            return v9;
        end;
    end;
    return false;
end;
function u1.UpdateAreaStatus(p10, p11) --[[ Line: 88 ]]
    -- upvalues: l__EnvironmentUtil__8 (copy), u1 (copy)
    p10.PlayerInArea = p11;
    if p11 then
        local _ = p10.Volumetric;
        if p10.Folder then
            l__EnvironmentUtil__8.SwitchEnvironment(p10.Folder);
        end;
    else
        local v12 = u1.GetNextArea();
        if not v12 then
            l__EnvironmentUtil__8.SwitchEnvironment(u1.DefaultFolder);
            return;
        end;
        l__EnvironmentUtil__8.SwitchEnvironment(v12.Folder);
    end;
end;
function u1.SetupLightArea(p13) --[[ Line: 109 ]]
    -- upvalues: u1 (copy), l__ReplicatedStorage__1 (copy)
    if p13:IsA("BasePart") then
        local u14 = p13:GetAttributes();
        u14.PlayerInArea = false;
        u14.BasePart = p13;
        u14.CFrame = u14.BasePart.CFrame;
        u14.Size = u14.BasePart.Size;
        u1.SpatialMap.Add(u14.BasePart);
        u14.Folder = l__ReplicatedStorage__1.Assets.Lighting:WaitForChild(u14.Lighting);
        table.insert(u1.LightAreas, u14);
        u1.LightAreasByBasePart[u14.BasePart] = u14;
        u1.ScanLightArea(u14);
        task.delay(0.1, function() --[[ Line: 129 ]]
            -- upvalues: u1 (ref), u14 (copy)
            u1.ScanLightArea(u14);
        end);
    else
        warn("LightArea must be a BasePart");
    end;
end;
function u1.Update(p15) --[[ Line: 143 ]]
    -- upvalues: u1 (copy), l__Mince__7 (copy)
    local v16 = u1;
    v16.TimeElapsed = v16.TimeElapsed + p15;
    if u1.TimeElapsed > u1.ScanRate then
        local v17 = u1;
        v17.TimeElapsed = v17.TimeElapsed - u1.ScanRate;
        if u1.HRP then
            local v18 = os.clock();
            local v19 = u1.SpatialMap.GetMapID(u1.HRP.Position);
            if v19 ~= u1.LastPlayerMapID then
                local v20 = u1.SpatialMap.GetPartsInRadius(u1.HRP.Position, 1);
                u1.ScanAreas = v20;
                u1.LastPlayerMapID = v19;
                l__Mince__7.Config.Stats.LightAreaStatus = { 5, (`LastLoadTime:{os.clock() - v18}, LastChunkSize:{#v20}, ID:{v19}`) };
            end;
        end;
        debug.profilebegin("LightAreaHandler :: ScanLightAreas");
        for _, v21 in ipairs(u1.ScanAreas) do
            local v22 = u1.LightAreasByBasePart[v21];
            if v22 then
                u1.ScanLightArea(v22);
            end;
        end;
        for _, v23 in u1.LightAreas do
            u1.ScanLightArea(v23);
        end;
        debug.profileend();
    end;
end;
function u1.Setup() --[[ Line: 186 ]]
    -- upvalues: u1 (copy), l__Mince__7 (copy), l__LocalPlayer__4 (copy), l__RunService__3 (copy), l__CollectionService__2 (copy)
    local function v25(p24) --[[ Line: 187 ]]
        -- upvalues: u1 (ref)
        local l__Humanoid__9 = p24:WaitForChild("Humanoid");
        local l__HumanoidRootPart__10 = p24:WaitForChild("HumanoidRootPart");
        u1.OverlapParam.FilterDescendantsInstances = { l__HumanoidRootPart__10 };
        u1.HRP = l__HumanoidRootPart__10;
        u1.LastPlayerMapID = "";
        l__Humanoid__9.Died:Connect(function() --[[ Line: 194 ]]
            -- upvalues: u1 (ref)
            u1.HRP = nil;
        end);
    end;
    l__Mince__7.Config.Stats.LightAreaStatus = { 5, "IDLE" };
    l__LocalPlayer__4.CharacterAdded:Connect(v25);
    if l__LocalPlayer__4.Character then
        v25(l__LocalPlayer__4.Character);
    end;
    l__RunService__3.Heartbeat:Connect(u1.Update);
    for _, v26 in l__CollectionService__2:GetTagged(u1.Tag) do
        task.spawn(u1.SetupLightArea, v26);
    end;
end;
return u1;
