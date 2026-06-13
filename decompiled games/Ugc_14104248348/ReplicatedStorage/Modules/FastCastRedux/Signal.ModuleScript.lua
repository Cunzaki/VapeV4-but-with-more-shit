-- Decompiled from: ReplicatedStorage.Modules.FastCastRedux.Signal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.TypeDefinitions);
local l__TestService__1 = game:GetService("TestService");
local l__Table__2 = require(script.Parent.Table);
local u1 = {};
u1.__index = u1;
u1.__type = "Signal";
local u2 = {};
u2.__index = u2;
u2.__type = "SignalConnection";
function u1.new(p3) --[[ Line: 44 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        Name = p3,
        Connections = {},
        YieldingThreads = {}
    }, u1);
end;
local function u10(u4, u5, p6) --[[ Line: 62 ]]
    -- upvalues: l__TestService__1 (copy)
    local v7 = coroutine.create(function() --[[ Line: 63 ]]
        -- upvalues: u4 (copy), u5 (copy)
        u4(unpack(u5));
    end);
    local v8, v9 = coroutine.resume(v7);
    if not v8 then
        l__TestService__1:Error(string.format("Exception thrown in your %s event handler: %s", p6, v9));
        l__TestService__1:Checkpoint(debug.traceback(v7));
    end;
end;
function u1.Connect(p11, p12) --[[ Line: 75 ]]
    -- upvalues: u1 (copy), u2 (copy), l__Table__2 (copy)
    local v13 = getmetatable(p11) == u1;
    assert(v13, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Connect", "Signal.new()"));
    local v14 = setmetatable({
        Index = -1,
        Signal = p11,
        Delegate = p12
    }, u2);
    v14.Index = #p11.Connections + 1;
    l__Table__2.insert(p11.Connections, v14.Index, v14);
    return v14;
end;
function u1.Fire(p15, ...) --[[ Line: 83 ]]
    -- upvalues: u1 (copy), l__Table__2 (copy), u10 (copy)
    local v16 = getmetatable(p15) == u1;
    assert(v16, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Fire", "Signal.new()"));
    local v17 = l__Table__2.pack(...);
    local l__Connections__3 = p15.Connections;
    local l__YieldingThreads__4 = p15.YieldingThreads;
    for v18 = 1, #l__Connections__3 do
        local v19 = l__Connections__3[v18];
        if v19.Delegate ~= nil then
            u10(v19.Delegate, v17, v19.Signal.Name);
        end;
    end;
    for v20 = 1, #l__YieldingThreads__4 do
        local v21 = l__YieldingThreads__4[v20];
        if v21 ~= nil then
            coroutine.resume(v21, ...);
        end;
    end;
end;
function u1.FireSync(p22, ...) --[[ Line: 103 ]]
    -- upvalues: u1 (copy), l__Table__2 (copy)
    local v23 = getmetatable(p22) == u1;
    assert(v23, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("FireSync", "Signal.new()"));
    local v24 = l__Table__2.pack(...);
    local l__Connections__5 = p22.Connections;
    local l__YieldingThreads__6 = p22.YieldingThreads;
    for v25 = 1, #l__Connections__5 do
        local v26 = l__Connections__5[v25];
        if v26.Delegate ~= nil then
            v26.Delegate(unpack(v24));
        end;
    end;
    for v27 = 1, #l__YieldingThreads__6 do
        local v28 = l__YieldingThreads__6[v27];
        if v28 ~= nil then
            coroutine.resume(v28, ...);
        end;
    end;
end;
function u1.Wait(p29) --[[ Line: 123 ]]
    -- upvalues: u1 (copy), l__Table__2 (copy)
    local v30 = getmetatable(p29) == u1;
    assert(v30, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Wait", "Signal.new()"));
    local v31 = coroutine.running();
    l__Table__2.insert(p29.YieldingThreads, v31);
    local v32 = { coroutine.yield() };
    l__Table__2.removeObject(p29.YieldingThreads, v31);
    return unpack(v32);
end;
function u1.Dispose(p33) --[[ Line: 133 ]]
    -- upvalues: u1 (copy)
    local v34 = getmetatable(p33) == u1;
    assert(v34, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "Signal.new()"));
    local l__Connections__7 = p33.Connections;
    for v35 = 1, #l__Connections__7 do
        l__Connections__7[v35]:Disconnect();
    end;
    p33.Connections = {};
    setmetatable(p33, nil);
end;
function u2.Disconnect(p36) --[[ Line: 143 ]]
    -- upvalues: u2 (copy), l__Table__2 (copy)
    local v37 = getmetatable(p36) == u2;
    assert(v37, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Disconnect", "private function NewConnection()"));
    l__Table__2.remove(p36.Signal.Connections, p36.Index);
    p36.SignalStatic = nil;
    p36.Delegate = nil;
    p36.YieldingThreads = {};
    p36.Index = -1;
    setmetatable(p36, nil);
end;
return u1;
