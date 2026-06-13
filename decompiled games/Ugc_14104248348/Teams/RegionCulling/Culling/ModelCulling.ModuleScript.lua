-- Decompiled from: Teams.RegionCulling.Culling.ModelCulling
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__ModelCullingContext__2 = require(script.Parent:WaitForChild("ModelCullingContext"));
local l__ModelHidingContext__3 = require(script.Parent:WaitForChild("ModelHidingContext"));
require(script.Parent.Parent:WaitForChild("State"):WaitForChild("RegionState"));
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 37 ]]
    -- upvalues: u1 (copy), l__ReplicatedStorage__1 (copy)
    local u3 = setmetatable({
        ModelCullingStrategy = "Parent",
        ReparentOperationsPerStep = 250,
        PartClusterSize = 50,
        ProcessStepDelay = 0.03333333333333333,
        PassiveModelFlattenDelay = 5,
        TransparencyOperationsPerStep = 1000,
        RegionState = p2,
        Contexts = {},
        QueuedOperations = {}
    }, u1);
    if not l__ReplicatedStorage__1:FindFirstChild("ModelCullingHiddenGeometry") then
        local v4 = Instance.new("Folder");
        v4.Name = "ModelCullingHiddenGeometry";
        v4.Parent = l__ReplicatedStorage__1;
    end;
    u3.HiddenGeometry = l__ReplicatedStorage__1:FindFirstChild("ModelCullingHiddenGeometry");
    p2.RegionVisible:Connect(function(p5) --[[ Line: 61 ]]
        -- upvalues: u3 (copy)
        u3:ShowRegion(p5);
    end);
    p2.RegionHidden:Connect(function(p6) --[[ Line: 64 ]]
        -- upvalues: u3 (copy)
        u3:HideRegion(p6);
    end);
    return u3;
end;
function u1.HandleInitialModel(p7, p8, p9) --[[ Line: 75 ]]
    if not p7.RegionState:IsRegionVisible(p8) then
        table.insert(p7.QueuedOperations, {
            Operation = "Hide",
            RegionName = p8,
            Context = p9
        });
    end;
end;
function u1.BindModelToRegion(u10, u11, p12) --[[ Line: 88 ]]
    -- upvalues: l__ModelHidingContext__3 (copy), l__ModelCullingContext__2 (copy)
    local u13;
    if u10.ModelCullingStrategy == "Transparency" then
        u13 = l__ModelHidingContext__3.new(p12);
    else
        u13 = l__ModelCullingContext__2.new(p12, u10);
    end;
    if not u10.Contexts[u11] then
        u10.Contexts[u11] = {};
    end;
    table.insert(u10.Contexts[u11], u13);
    task.delay(1, function() --[[ Line: 103 ]]
        -- upvalues: u13 (ref), u10 (copy), u11 (copy)
        u13:FlattenModel();
        u10:HandleInitialModel(u11, u13);
    end);
    return u13;
end;
function u1.RemoveQueuedOperations(p14, p15) --[[ Line: 115 ]]
    for v16 = #p14.QueuedOperations, 1, -1 do
        if p14.QueuedOperations[v16].RegionName == p15 then
            table.remove(p14.QueuedOperations, v16);
        end;
    end;
end;
function u1.GetSummary(p17) --[[ Line: 125 ]]
    local v18 = {};
    for v19, v20 in p17.Contexts do
        v18[v19] = {};
        for _, v21 in v20 do
            table.insert(v18[v19], v21:GetSummary());
        end;
    end;
    return v18;
end;
function u1.HideRegion(p22, p23) --[[ Line: 139 ]]
    p22:RemoveQueuedOperations(p23);
    if p22.Contexts[p23] then
        for _, v24 in p22.Contexts[p23] do
            table.insert(p22.QueuedOperations, {
                Operation = "Hide",
                RegionName = p23,
                Context = v24
            });
        end;
    end;
end;
function u1.ShowRegion(p25, p26) --[[ Line: 155 ]]
    p25:RemoveQueuedOperations(p26);
    if p25.Contexts[p26] then
        for _, v27 in p25.Contexts[p26] do
            table.insert(p25.QueuedOperations, 1, {
                Operation = "Show",
                RegionName = p26,
                Context = v27
            });
        end;
    end;
end;
function u1.PerformQueueStep(p28) --[[ Line: 171 ]]
    local v29 = p28.ModelCullingStrategy == "Transparency" and p28.TransparencyOperationsPerStep or p28.ReparentOperationsPerStep;
    for _, v30 in p28.QueuedOperations do
        if v30.Operation == "Show" and v30.Context.ReparentOperationsPerStep then
            v29 = math.max(v29, v30.Context.ReparentOperationsPerStep);
        end;
    end;
    while v29 > 0 and #p28.QueuedOperations > 0 do
        local v31 = p28.QueuedOperations[1];
        if v31.Operation == "Show" then
            v29 = v31.Context:ShowModel(v29);
        elseif v31.Operation == "Hide" then
            v29 = v31.Context:HideModel(v29);
        end;
        if v29 ~= 0 then
            table.remove(p28.QueuedOperations, 1);
        end;
    end;
end;
function u1.StartProcessingQueue(u32) --[[ Line: 203 ]]
    task.spawn(function() --[[ Line: 205 ]]
        -- upvalues: u32 (copy)
        while true do
            u32:PerformQueueStep();
            task.wait(u32.ProcessStepDelay);
        end;
    end);
    for v33, v34 in u32.Contexts do
        for _, v35 in v34 do
            u32:HandleInitialModel(v33, v35);
        end;
    end;
end;
function u1.StartModelFlattening(u36) --[[ Line: 224 ]]
    if u36.ModelCullingStrategy == "Transparency" then
    else
        task.spawn(function() --[[ Line: 226 ]]
            -- upvalues: u36 (copy)
            while true do
                for _, v37 in u36.Contexts do
                    for _, v38 in v37 do
                        v38:FlattenModel();
                        task.wait();
                    end;
                end;
                task.wait(u36.PassiveModelFlattenDelay);
            end;
        end);
    end;
end;
return u1;
