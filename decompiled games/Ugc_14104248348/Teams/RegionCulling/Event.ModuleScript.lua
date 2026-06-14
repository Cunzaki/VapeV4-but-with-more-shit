-- Decompiled from: Teams.RegionCulling.Event
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 16 ]]
    -- upvalues: u1 (copy)
    local v2 = {
        Event = Instance.new("BindableEvent")
    };
    return setmetatable(v2, u1);
end;
function u1.Connect(p3, p4) --[[ Line: 25 ]]
    return p3.Event.Event:Connect(p4);
end;
function u1.Wait(p5, ...) --[[ Line: 32 ]]
    return p5.Event.Event:Wait(...);
end;
function u1.Fire(p6, ...) --[[ Line: 39 ]]
    p6.Event:Fire(...);
end;
function u1.Destroy(p7) --[[ Line: 46 ]]
    p7.Event:Destroy();
end;
return u1;
