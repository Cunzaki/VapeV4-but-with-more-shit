-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack.NexusVRBackpack.State.Inventory
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 23 ]]
    -- upvalues: u1 (copy)
    local v3 = {
        Containers = {},
        Tools = {},
        Events = {}
    };
    setmetatable(v3, u1);
    v3.ToolsChangedEvent = Instance.new("BindableEvent");
    v3.ToolsChanged = v3.ToolsChangedEvent.Event;
    if p2 then
        for _, v4 in p2 do
            v3:AddContainer(v4);
        end;
    end;
    return v3;
end;
function u1.AddTool(p5, p6) --[[ Line: 50 ]]
    if p6:IsA("BackpackItem") then
        for _, v7 in p5.Tools do
            if p6 == v7 then
                return;
            end;
        end;
        table.insert(p5.Tools, p6);
        p5.ToolsChangedEvent:Fire();
    end;
end;
function u1.RemoveTool(p8, p9) --[[ Line: 68 ]]
    if not p9:IsA("BackpackItem") then
        return;
    end;
    for _, v10 in p8.Containers do
        if p9.Parent == v10 then
            return;
        end;
    end;
    local v11 = nil;
    for v12, v13 in p8.Tools do
        if p9 == v13 then
            v11 = v12;
            break;
        end;
    end;
    if v11 then
        table.remove(p8.Tools, v11);
        p8.ToolsChangedEvent:Fire();
    end;
end;
function u1.AddContainer(u14, p15) --[[ Line: 94 ]]
    table.insert(u14.Containers, p15);
    for _, v16 in p15:GetChildren() do
        u14:AddTool(v16);
    end;
    table.insert(u14.Events, p15.ChildAdded:Connect(function(p17) --[[ Line: 99 ]]
        -- upvalues: u14 (copy)
        u14:AddTool(p17);
    end));
    table.insert(u14.Events, p15.ChildRemoved:Connect(function(p18) --[[ Line: 102 ]]
        -- upvalues: u14 (copy)
        u14:RemoveTool(p18);
    end));
end;
function u1.Destroy(p19) --[[ Line: 110 ]]
    for _, v20 in p19.Events do
        v20:Disconnect();
    end;
    p19.Events = {};
    p19.Tools = {};
    p19.Containers = {};
    p19.ToolsChangedEvent:Destroy();
end;
return u1;
