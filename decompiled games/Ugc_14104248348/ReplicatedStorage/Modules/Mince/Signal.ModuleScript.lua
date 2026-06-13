-- Decompiled from: ReplicatedStorage.Modules.Mince.Signal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {
    __index = v1
};
function v1.new() --[[ Line: 5 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3.Connections = {};
    return v3;
end;
function v1.Wait(p4) --[[ Line: 12 ]]
    local u5 = coroutine.running();
    p4:Once(function() --[[ Line: 14 ]]
        -- upvalues: u5 (copy)
        task.defer(u5);
    end);
    coroutine.yield();
end;
function v1.Once(p6, u7) --[[ Line: 20 ]]
    local u8 = nil;
    u8 = p6:Connect(function() --[[ Line: 22 ]]
        -- upvalues: u7 (copy), u8 (ref)
        u7();
        u8:Disconnect();
    end);
end;
function v1.DisconnectAll(p9) --[[ Line: 28 ]]
    for _, v10 in p9.Connections do
        v10:Disconnect();
    end;
end;
function v1.Connect(u11, p12) --[[ Line: 34 ]]
    local u13 = {
        {},
        Connected = true
    };
    function u13.Disconnect() --[[ Line: 37 ]]
        -- upvalues: u11 (copy), u13 (copy)
        u11.Connections[u13[1]] = nil;
        u13.Connected = false;
    end;
    u11.Connections[u13[1]] = p12;
    return u13;
end;
function v1.Fire(p14, ...) --[[ Line: 47 ]]
    for _, v15 in pairs(p14.Connections) do
        task.defer(v15, ...);
    end;
end;
function v1.FireImmediate(p16, ...) --[[ Line: 53 ]]
    for _, v17 in pairs(p16.Connections) do
        task.spawn(v17, ...);
    end;
end;
return v1;
