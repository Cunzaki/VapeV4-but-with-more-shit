-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Area.TriggerHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__RotatedRegion3__4 = require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
local l__SpatialHash__5 = require(l__ReplicatedStorage__1.Modules.SpatialHash);
local l__microid__6 = require(l__ReplicatedStorage__1.Modules.microid);
local l__Signal__7 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__8 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.EnvironmentUtil);
local u1 = {
    Tag = "Trigger",
    UseRobloxSpatialQuery = false,
    UseNexusDetectionMethod = true,
    ScanRate = 0,
    LastPlayerMapID = "000000",
    TriggerAdded = l__Signal__7.new(),
    EventBases = {},
    ActiveTriggers = {},
    Triggers = {},
    TriggersByName = {},
    TriggersByBasePart = {},
    OverlapParam = OverlapParams.new(),
    ScanAreas = {},
    SpatialMap = l__SpatialHash__5.NewMap(25, true)
};
u1.OverlapParam.FilterType = Enum.RaycastFilterType.Include;
function u1.TriggerFromPart(p2) --[[ Line: 49 ]]
    -- upvalues: l__microid__6 (copy), u1 (copy)
    p2:SetAttribute("Name", l__microid__6.gent(32));
    return u1.SetupTrigger(p2);
end;
function u1.PsudeoTrigger(p3, p4, p5) --[[ Line: 55 ]]
    -- upvalues: l__microid__6 (copy), u1 (copy)
    local v6 = Instance.new("Part", script);
    v6.Name = "__NonPhysicalTriggerRepresent";
    v6.Anchored = true;
    v6:PivotTo(p3);
    v6.Size = p4;
    local v7 = p5 or {};
    v7.Name = v7.Name or l__microid__6.gent(32);
    for v8, v9 in v7 do
        v6:SetAttribute(v8, v9);
    end;
    return u1.SetupTrigger(v6), v6;
end;
function u1.GetEventBases(p10) --[[ Line: 72 ]]
    -- upvalues: u1 (copy), l__Signal__7 (copy)
    if u1.EventBases[p10] then
        return u1.EventBases[p10];
    end;
    u1.EventBases[p10] = {
        PlayerInArea = false,
        Entered = l__Signal__7.new(),
        Leaved = l__Signal__7.new(),
        Exited = l__Signal__7.new(),
        Parts = {}
    };
    return u1.GetEventBases(p10);
end;
function u1.ScanTrigger(p11) --[[ Line: 90 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__3 (copy), l__RotatedRegion3__4 (copy)
    local v12 = false;
    if u1.UseRobloxSpatialQuery then
        for _, v13 in game.Workspace:GetPartsInPart(p11.BasePart, u1.OverlapParam) do
            if v13.Parent == l__LocalPlayer__3.Character then
                v12 = true;
            end;
        end;
    elseif u1.HRP then
        if u1.UseNexusDetectionMethod then
            local v14 = p11.BasePart.CFrame:Inverse();
            local v15 = p11.BasePart.Size / 2;
            local v16 = v14 * u1.HRP.CFrame;
            local v17 = (math.abs(v16.X) > v15.X or math.abs(v16.Y) > v15.Y) and true or math.abs(v16.Z) > v15.Z;
            v12 = not v17;
        else
            v12 = l__RotatedRegion3__4.FromPart(p11.BasePart):CastPart(u1.HRP);
        end;
    end;
    if p11.PlayerInArea ~= v12 then
        return true, v12;
    end;
end;
function u1.GetNextArea() --[[ Line: 118 ]]
    -- upvalues: u1 (copy)
    for _, v18 in u1.Triggers do
        if v18.PlayerInArea then
            return v18;
        end;
    end;
    return false;
end;
function u1.GetTrigger(u19) --[[ Line: 129 ]]
    -- upvalues: u1 (copy)
    if not u1.TriggersByName[u19] then
        local u20 = coroutine.running();
        u1.TriggerAdded:Connect(function(p21) --[[ Line: 132 ]]
            -- upvalues: u19 (copy), u20 (copy)
            if p21.Name == u19 then
                task.spawn(u20);
            end;
        end);
        coroutine.yield();
    end;
    return u1.TriggersByName[u19].Events;
end;
function u1.SetupTrigger(p22) --[[ Line: 144 ]]
    -- upvalues: u1 (copy)
    if p22:IsA("BasePart") then
        local v23 = p22:GetAttributes();
        v23.BasePart = p22;
        assert(v23.Name, "Trigger requires a name!");
        local v24 = u1.GetEventBases(v23.Name);
        v23.Entered = v24.Entered;
        v23.Leaved = v24.Leaved;
        v23.Exited = v24.Exited;
        v23.Events = v24;
        table.insert(v24.Parts, p22);
        v23.BasePart.Anchored = true;
        u1.SpatialMap.Add(v23.BasePart);
        table.insert(u1.Triggers, v23);
        u1.TriggersByName[v23.Name] = v23;
        u1.TriggersByBasePart[v23.BasePart] = v23;
        u1.TriggerAdded:Fire(v23);
        return v23;
    end;
    warn("Trigger must be a BasePart");
end;
function u1.Update(_) --[[ Line: 180 ]]
    -- upvalues: u1 (copy), l__Mince__8 (copy)
    if u1.HRP then
        local v25 = os.clock();
        local v26 = u1.SpatialMap.GetMapID(u1.HRP.Position);
        if v26 ~= u1.LastPlayerMapID then
            local v27 = u1.SpatialMap.GetPartsInRadius(u1.HRP.Position, 1);
            u1.ScanAreas = v27;
            u1.LastPlayerMapID = v26;
            l__Mince__8.Config.Stats.TriggerStatus = { 20, (`LastLoadTime:{os.clock() - v25}, LastChunkSize:{#v27}, ID:{v26}`) };
        end;
    end;
    debug.profilebegin("TriggerHandler :: UpdateTriggerStatus // Scan");
    local v28 = {};
    local v29 = {};
    local v30 = {};
    for _, v31 in ipairs(u1.ScanAreas) do
        v28[v31] = true;
        local v32 = u1.TriggersByBasePart[v31];
        if v32 then
            if not v29[v32.Name] then
                v29[v32.Name] = true;
            end;
            local v33, v34 = u1.ScanTrigger(v32);
            if v33 then
                if v34 then
                    v32.Events.LastEntered = v31;
                end;
                v30[v32.Name] = v30[v32.Name] or {};
                table.insert(v30[v32.Name], v34);
            end;
        end;
    end;
    for _, v35 in u1.ActiveTriggers do
        for _, v36 in v35.Parts do
            if not v28[v36] then
                local v37 = u1.TriggersByBasePart[v36];
                if v37 then
                    if not v29[v37.Name] then
                        v29[v37.Name] = true;
                    end;
                    local v38, v39 = u1.ScanTrigger(v37);
                    if v38 then
                        if v39 then
                            v37.Events.LastEntered = v36;
                        end;
                        v30[v37.Name] = v30[v37.Name] or {};
                        table.insert(v30[v37.Name], v39);
                    end;
                end;
            end;
        end;
    end;
    for v40, v41 in v30 do
        local v42 = u1.GetEventBases(v40);
        local v43 = false;
        for _, v44 in v41 do
            if v44 then
                v43 = true;
                break;
            end;
        end;
        if v42.PlayerInArea ~= v43 then
            v42.PlayerInArea = v43;
            if v43 then
                v42.Entered:Fire(v42.LastEntered or v42.Parts[1]);
                u1.ActiveTriggers[v42] = v42;
            else
                v42.Leaved:Fire(v42.LastEntered or v42.Parts[1]);
                v42.Exited:Fire(v42.LastEntered or v42.Parts[1]);
                u1.ActiveTriggers[v42] = nil;
            end;
        end;
    end;
    debug.profileend();
end;
function u1.Setup() --[[ Line: 279 ]]
    -- upvalues: u1 (copy), l__Mince__8 (copy), l__LocalPlayer__3 (copy), l__CollectionService__2 (copy)
    local function v46(p45) --[[ Line: 280 ]]
        -- upvalues: u1 (ref)
        local l__Humanoid__9 = p45:WaitForChild("Humanoid");
        local l__HumanoidRootPart__10 = p45:WaitForChild("HumanoidRootPart");
        u1.OverlapParam.FilterDescendantsInstances = { l__HumanoidRootPart__10 };
        u1.HRP = l__HumanoidRootPart__10;
        l__Humanoid__9.Died:Connect(function() --[[ Line: 287 ]]
            -- upvalues: u1 (ref)
            u1.HRP = nil;
        end);
        u1.LastPlayerMapID = nil;
    end;
    l__Mince__8.Config.Stats.TriggerStatus = { 20, "IDLE" };
    l__LocalPlayer__3.CharacterAdded:Connect(v46);
    if l__LocalPlayer__3.Character then
        v46(l__LocalPlayer__3.Character);
    end;
    task.spawn(function() --[[ Line: 302 ]]
        -- upvalues: u1 (ref)
        while true do
            local v47, v48;
            repeat
                v47, v48 = pcall(function() --[[ Line: 304 ]]
                    -- upvalues: u1 (ref)
                    u1.Update(task.wait(u1.ScanRate));
                end);
            until not v47;
            warn(v48);
        end;
    end);
    for _, v49 in l__CollectionService__2:GetTagged(u1.Tag) do
        u1.SetupTrigger(v49);
    end;
    l__CollectionService__2:GetInstanceAddedSignal(u1.Tag):Connect(u1.SetupTrigger);
end;
return u1;
