-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-instance@4.1.2.nexus-instance.Event.TypedEvent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__RunService__2 = game:GetService("RunService");
local l__TypedEventConnection__3 = require(script.Parent:WaitForChild("TypedEventConnection"));
local u1 = {
    LastArguments = {},
    QueuedClearArguments = {}
};
u1.__index = u1;
function u1.new() --[[ Line: 25 ]]
    -- upvalues: u1 (copy)
    local v2 = {
        CurrentWaits = 0,
        BindableEvent = Instance.new("BindableEvent"),
        Connections = {}
    };
    return setmetatable(v2, u1);
end;
function u1.Connect(u3, p4) --[[ Line: 41 ]]
    -- upvalues: l__TypedEventConnection__3 (copy)
    local u5 = l__TypedEventConnection__3.new(u3, p4);
    local v7 = u3.BindableEvent.Event:Connect(function(p6) --[[ Line: 46 ]]
        -- upvalues: u5 (copy), u3 (copy)
        u5:Fire(table.unpack(u3.LastArguments[p6]));
    end);
    u3.Connections[u5] = v7;
    return u5;
end;
function u1.Once(p8, u9) --[[ Line: 64 ]]
    local u10 = nil;
    u10 = p8:Connect(function(...) --[[ Line: 66 ]]
        -- upvalues: u10 (ref), u9 (copy)
        if u10 then
            u10:Disconnect();
        end;
        u9(...);
    end);
end;
function u1.Wait(p11) --[[ Line: 77 ]]
    p11.CurrentWaits = p11.CurrentWaits + 1;
    local v12 = p11.BindableEvent.Event:Wait();
    p11.CurrentWaits = p11.CurrentWaits - 1;
    return table.unpack(p11.LastArguments[v12]);
end;
function u1.Fire(p13, ...) --[[ Line: 90 ]]
    -- upvalues: l__HttpService__1 (copy), u1 (copy)
    if next(p13.Connections) == nil and p13.CurrentWaits <= 0 then
    else
        local u14 = l__HttpService__1:GenerateGUID();
        local v15 = table.pack(...);
        p13.LastArguments[u14] = v15;
        task.defer(function() --[[ Line: 101 ]]
            -- upvalues: u1 (ref), u14 (copy)
            u1.QueuedClearArguments[u14] = true;
        end);
        p13.BindableEvent:Fire(u14);
    end;
end;
function u1.Disconnected(p16, p17) --[[ Line: 112 ]]
    if p16.Connections[p17] then
        p16.Connections[p17]:Disconnect();
        p16.Connections[p17] = nil;
    end;
end;
function u1.Destroy(p18) --[[ Line: 121 ]]
    local l__Connections__4 = p18.Connections;
    p18.Connections = {};
    p18.CurrentWaits = 0;
    for v19, _ in l__Connections__4 do
        v19:Disconnect();
    end;
    p18.BindableEvent:Destroy();
end;
l__RunService__2.Heartbeat:Connect(function() --[[ Line: 134 ]]
    -- upvalues: u1 (copy)
    local l__QueuedClearArguments__5 = u1.QueuedClearArguments;
    u1.QueuedClearArguments = {};
    for v20, _ in l__QueuedClearArguments__5 do
        u1.LastArguments[v20] = nil;
    end;
end);
return u1;
