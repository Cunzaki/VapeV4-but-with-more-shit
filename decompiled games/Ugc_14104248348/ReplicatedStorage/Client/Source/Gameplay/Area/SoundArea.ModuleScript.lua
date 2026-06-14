-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Area.SoundArea
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__RunService__3 = game:GetService("RunService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__6 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__SpatialHash__7 = require(l__ReplicatedStorage__1.Modules.SpatialHash);
local l__RotatedRegion3__8 = require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
local u1 = l__Mince__5:Get("SoundHandler");
local u2 = {
    Tag = "SoundArea",
    LastPlayerMapID = "000000",
    UseRobloxSpatialQuery = false,
    UseNexusDetectionMethod = false,
    TimeElapsed = 0,
    ScanRate = 0,
    SoundAreas = {},
    SoundAreasByBasePart = {},
    ActiveSoundAreas = {},
    ScanAreas = {},
    SpatialMap = l__SpatialHash__7.NewMap(25),
    EffectChanged = l__Signal__6.new(),
    OverlapParam = OverlapParams.new()
};
u2.OverlapParam.FilterType = Enum.RaycastFilterType.Whitelist;
function u2.ScanSoundArea(p3) --[[ Line: 42 ]]
    -- upvalues: u2 (copy), l__RotatedRegion3__8 (copy), l__LocalPlayer__4 (copy)
    local v4 = false;
    if u2.Type == "Camera" then
        local l__Position__9 = game.Workspace.CurrentCamera:GetRenderCFrame().Position;
        debug.profilebegin("RotatedRegion3 :: SoundArea");
        v4 = l__RotatedRegion3__8.FromPart(p3.BasePart):CastPoint(l__Position__9);
        debug.profileend();
    elseif u2.UseRobloxSpatialQuery then
        if not l__LocalPlayer__4.Character then
            return;
        end;
        for _, v5 in game.Workspace:GetPartsInPart(p3.BasePart, u2.OverlapParam) do
            if v5.Parent == l__LocalPlayer__4.Character then
                v4 = true;
            end;
        end;
    elseif u2.HumanoidRootPart then
        if u2.UseNexusDetectionMethod then
            debug.profilebegin("NexusDetection :: SoundArea");
            local v6 = p3.BasePart.CFrame:Inverse();
            local v7 = p3.BasePart.Size / 2;
            local v8 = v6 * u2.HumanoidRootPart.CFrame;
            local v9 = (math.abs(v8.X) > v7.X or math.abs(v8.Y) > v7.Y) and true or math.abs(v8.Z) > v7.Z;
            debug.profileend();
            v4 = not v9;
        else
            debug.profilebegin("RotatedRegion3 :: SoundArea");
            v4 = l__RotatedRegion3__8.FromPart(p3.BasePart):CastPart(u2.HumanoidRootPart);
            debug.profileend();
        end;
    end;
    if p3.PlayerInArea ~= v4 then
        u2.UpdateAreaStatus(p3, v4);
    end;
end;
function u2.GetNextArea() --[[ Line: 83 ]]
    -- upvalues: u2 (copy)
    for _, v10 in u2.SoundAreas do
        if v10.PlayerInArea then
            return v10;
        end;
    end;
    return false;
end;
function u2.UpdateAreaStatus(p11, p12) --[[ Line: 93 ]]
    -- upvalues: u2 (copy), u1 (copy)
    p11.PlayerInArea = p12;
    if p12 then
        u2.ActiveSoundAreas[p11] = p11;
        if p11.Effect and p11.Effect ~= "None" then
            u1.SwitchEffect(p11.Effect);
        end;
        if p11.Effect == "None" then
            u2.EffectChanged:Fire("None");
        end;
        if p11.Effect ~= u2.CurrentEffect and not p11.DontSendChangedEvents then
            u2.CurrentEffect = p11.Effect;
            u2.EffectChanged:Fire(p11.Effect);
        end;
        for _, v13 in p11.Tracks do
            u1.PlayTrack(v13.Track.TrackName);
        end;
    else
        u2.ActiveSoundAreas[p11] = nil;
        local v14 = {};
        for _, v15 in u2.SoundAreas do
            if v15.PlayerInArea then
                for _, v16 in v15.Tracks do
                    v14[v16.Track.TrackName] = true;
                end;
            end;
        end;
        if next(v14) then
            for _, v17 in p11.Tracks do
                if not v14[v17.Track.TrackName] then
                    u1.StopTrack(v17.Track.TrackName);
                end;
            end;
            u1.RemoveEffects();
            u2.RestartTracks();
            if u2.GetNextArea() then
            else
                if u2.CurrentEffect ~= "None" then
                    u2.CurrentEffect = "None";
                    u2.EffectChanged:Fire("None");
                end;
            end;
        else
            for _, v18 in p11.Tracks do
                u1.StopTrack(v18.Track.TrackName);
            end;
            u1.RemoveEffects();
            u2.RestartTracks();
            if u2.CurrentEffect ~= "None" then
                u2.CurrentEffect = "None";
                u2.EffectChanged:Fire("None");
            end;
        end;
    end;
end;
function u2.RestartTracks() --[[ Line: 172 ]]
    -- upvalues: u2 (copy)
    for _, v19 in u2.SoundAreas do
        if v19.PlayerInArea then
            u2.UpdateAreaStatus(v19, v19.PlayerInArea);
        end;
    end;
end;
function u2.SetupSoundArea(p20) --[[ Line: 180 ]]
    -- upvalues: u2 (copy), u1 (copy)
    if p20:IsA("BasePart") then
        local u21 = p20:GetAttributes();
        u21.PlayerInArea = false;
        u21.BasePart = p20;
        u21.Effect = u21.Effect or u21.Effects;
        u2.SpatialMap.Add(u21.BasePart);
        local v22 = p20:FindFirstChild("Tracks");
        u21.AmbientReverb = Enum.ReverbType.NoReverb;
        u21.Tracks = {};
        if v22 then
            for _, v23 in v22:GetChildren() do
                if v23:IsA("Configuration") then
                    local l__Name__10 = v23.Name;
                    local v24 = u1.GetTrack(l__Name__10);
                    if v24 then
                        local v25 = v23:GetAttributes();
                        v25.TrackName = l__Name__10;
                        v25.Track = v24;
                        table.insert(u21.Tracks, v25);
                    else
                        warn(("SoundArea.Tracks.%s is not a valid track name."):format(l__Name__10));
                    end;
                end;
            end;
        end;
        table.insert(u2.SoundAreas, u21);
        u2.SoundAreasByBasePart[u21.BasePart] = u21;
        u2.ScanSoundArea(u21);
        task.delay(0.1, function() --[[ Line: 218 ]]
            -- upvalues: u2 (ref), u21 (copy)
            u2.ScanSoundArea(u21);
        end);
    else
        warn("SoundArea must be a BasePart");
    end;
end;
function u2.Update(p26) --[[ Line: 230 ]]
    -- upvalues: u2 (copy), l__Mince__5 (copy)
    local v27 = u2;
    v27.TimeElapsed = v27.TimeElapsed + p26;
    if u2.TimeElapsed > u2.ScanRate then
        local v28 = u2;
        v28.TimeElapsed = v28.TimeElapsed - u2.ScanRate;
        local v29 = nil;
        if u2.Type == "Camera" then
            local v30 = os.clock();
            local v31 = u2.SpatialMap.GetMapID(u2.HumanoidRootPart.Position);
            if v31 ~= u2.LastPlayerMapID then
                local v32 = u2.SpatialMap.GetPartsInRadius(u2.HumanoidRootPart.Position, 1);
                u2.ScanAreas = v32;
                u2.LastPlayerMapID = v31;
                l__Mince__5.Config.Stats.SoundAreaStatus = { 6, (`LastLoadTime:{os.clock() - v30}, LastChunkSize:{#v32}, ID:{v31}`) };
            end;
        elseif u2.HumanoidRootPart then
            v29 = u2.HumanoidRootPart.Position;
        end;
        if v29 then
            local v33 = os.clock();
            local _ = u2.HumanoidRootPart.Position;
            local v34 = u2.SpatialMap.GetMapID(v29);
            if v34 ~= u2.LastPlayerMapID then
                local v35 = u2.SpatialMap.GetPartsInRadius(v29, 1);
                u2.ScanAreas = v35;
                u2.LastPlayerMapID = v34;
                l__Mince__5.Config.Stats.SoundAreaStatus = { 6, (`LastLoadTime:{os.clock() - v33}, LastChunkSize:{#v35}, ID:{v34}`) };
            end;
        end;
        local v36 = {};
        for _, v37 in ipairs(u2.ScanAreas) do
            local v38 = u2.SoundAreasByBasePart[v37];
            if v38 then
                v36[v38] = true;
                u2.ScanSoundArea(v38);
            end;
        end;
        for _, v39 in u2.ActiveSoundAreas do
            if not v36[v39] then
                u2.ScanSoundArea(v39);
            end;
        end;
    end;
end;
function u2.Setup() --[[ Line: 295 ]]
    -- upvalues: u1 (copy), u2 (copy), l__Mince__5 (copy), l__LocalPlayer__4 (copy), l__RunService__3 (copy), l__CollectionService__2 (copy)
    u1.WaitUntilSoundLoaded();
    local function v42(p40) --[[ Line: 297 ]]
        -- upvalues: u2 (ref), u1 (ref)
        local l__Humanoid__11 = p40:WaitForChild("Humanoid");
        local l__HumanoidRootPart__12 = p40:WaitForChild("HumanoidRootPart");
        u2.OverlapParam.FilterDescendantsInstances = { l__HumanoidRootPart__12 };
        u2.HumanoidRootPart = l__HumanoidRootPart__12;
        u2.LastPlayerMapID = "";
        l__Humanoid__11.Died:Connect(function() --[[ Line: 304 ]]
            -- upvalues: u2 (ref)
            u2.HRP = nil;
        end);
        u1.StopAllTracks();
        for _, v41 in u2.SoundAreas do
            v41.PlayerInArea = false;
        end;
    end;
    l__Mince__5.Config.Stats.SoundAreaStatus = { 6, "IDLE" };
    l__LocalPlayer__4.CharacterAdded:Connect(v42);
    if l__LocalPlayer__4.Character then
        v42(l__LocalPlayer__4.Character);
    end;
    l__RunService__3.Heartbeat:Connect(u2.Update);
    for _, v43 in l__CollectionService__2:GetTagged(u2.Tag) do
        u2.SetupSoundArea(v43);
    end;
end;
return u2;
