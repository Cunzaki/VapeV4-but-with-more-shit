-- Decompiled from: ReplicatedStorage.NexusVRCore.Packages.NexusInstance.Event.TypedEventConnection
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 23 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        Connected = true,
        ParentEvent = p2,
        ConnectionFunction = p3
    }, u1);
end;
function u1.Fire(p4, ...) --[[ Line: 34 ]]
    if p4.Connected then
        p4.ConnectionFunction(...);
    end;
end;
function u1.Disconnect(p5) --[[ Line: 42 ]]
    if p5.Connected then
        p5.Connected = false;
        p5.ParentEvent:Disconnected(p5);
    end;
end;
function u1.Destroy(p6) --[[ Line: 54 ]]
    p6:Disconnect();
end;
return u1;
