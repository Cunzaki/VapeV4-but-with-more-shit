-- Decompiled from: ReplicatedStorage.Client.Class.RbxUtil.Signal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 35 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5(...) --[[ Line: 46 ]]
    -- upvalues: u4 (copy)
    u4(...);
    while true do
        u4(coroutine.yield());
    end;
end;
local u6 = {};
u6.__index = u6;
function u6.new(p7, p8) --[[ Line: 74 ]]
    -- upvalues: u6 (copy)
    return setmetatable({
        Connected = true,
        _next = false,
        _signal = p7,
        _fn = p8
    }, u6);
end;
function u6.Disconnect(p9) --[[ Line: 84 ]]
    if p9.Connected then
        p9.Connected = false;
        if p9._signal._handlerListHead == p9 then
            p9._signal._handlerListHead = p9._next;
        else
            local l___handlerListHead__1 = p9._signal._handlerListHead;
            while l___handlerListHead__1 and l___handlerListHead__1._next ~= p9 do
                l___handlerListHead__1 = l___handlerListHead__1._next;
            end;
            if l___handlerListHead__1 then
                l___handlerListHead__1._next = p9._next;
            end;
        end;
    end;
end;
u6.Destroy = u6.Disconnect;
setmetatable(u6, {
    __index = function(_, p10) --[[ Name: __index, Line 109 ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p10))), 2);
    end,
    __newindex = function(_, p11, _) --[[ Name: __newindex, Line 112 ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end
});
local u12 = {};
u12.__index = u12;
function u12.new() --[[ Line: 149 ]]
    -- upvalues: u12 (copy)
    return setmetatable({
        _handlerListHead = false,
        _proxyHandler = nil
    }, u12);
end;
function u12.Wrap(p13) --[[ Line: 171 ]]
    -- upvalues: u12 (copy)
    local v14 = typeof(p13) == "RBXScriptSignal";
    local v15 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p13);
    assert(v14, v15);
    local u16 = u12.new();
    u16._proxyHandler = p13:Connect(function(...) --[[ Line: 174 ]]
        -- upvalues: u16 (copy)
        u16:Fire(...);
    end);
    return u16;
end;
function u12.Is(p17) --[[ Line: 187 ]]
    -- upvalues: u12 (copy)
    local v18;
    if type(p17) == "table" then
        v18 = getmetatable(p17) == u12;
    else
        v18 = false;
    end;
    return v18;
end;
function u12.Connect(p19, p20) --[[ Line: 205 ]]
    -- upvalues: u6 (copy)
    local v21 = u6.new(p19, p20);
    if not p19._handlerListHead then
        p19._handlerListHead = v21;
        return v21;
    end;
    v21._next = p19._handlerListHead;
    p19._handlerListHead = v21;
    return v21;
end;
function u12.ConnectOnce(p22, u23) --[[ Line: 232 ]]
    local u24 = nil;
    local u25 = false;
    u24 = p22:Connect(function(...) --[[ Line: 235 ]]
        -- upvalues: u25 (ref), u24 (ref), u23 (copy)
        if u25 then
        else
            u25 = true;
            u24:Disconnect();
            u23(...);
        end;
    end);
    return u24;
end;
function u12.GetConnections(p26) --[[ Line: 245 ]]
    local l___handlerListHead__2 = p26._handlerListHead;
    local v27 = {};
    while l___handlerListHead__2 do
        table.insert(v27, l___handlerListHead__2);
        l___handlerListHead__2 = l___handlerListHead__2._next;
    end;
    return v27;
end;
function u12.DisconnectAll(p28) --[[ Line: 264 ]]
    local l___handlerListHead__3 = p28._handlerListHead;
    while l___handlerListHead__3 do
        l___handlerListHead__3.Connected = false;
        l___handlerListHead__3 = l___handlerListHead__3._next;
    end;
    p28._handlerListHead = false;
end;
function u12.Fire(p29, ...) --[[ Line: 289 ]]
    -- upvalues: u1 (ref), u5 (copy)
    local l___handlerListHead__4 = p29._handlerListHead;
    while l___handlerListHead__4 do
        if l___handlerListHead__4.Connected then
            if not u1 then
                u1 = coroutine.create(u5);
            end;
            task.spawn(u1, l___handlerListHead__4._fn, ...);
        end;
        l___handlerListHead__4 = l___handlerListHead__4._next;
    end;
end;
function u12.FireDeferred(p30, ...) --[[ Line: 311 ]]
    local l___handlerListHead__5 = p30._handlerListHead;
    while l___handlerListHead__5 do
        task.defer(l___handlerListHead__5._fn, ...);
        l___handlerListHead__5 = l___handlerListHead__5._next;
    end;
end;
function u12.Wait(p31) --[[ Line: 335 ]]
    local u32 = coroutine.running();
    local u33 = nil;
    local u34 = false;
    u33 = p31:Connect(function(...) --[[ Line: 339 ]]
        -- upvalues: u34 (ref), u33 (ref), u32 (copy)
        if u34 then
        else
            u34 = true;
            u33:Disconnect();
            task.spawn(u32, ...);
        end;
    end);
    return coroutine.yield();
end;
function u12.Destroy(p35) --[[ Line: 361 ]]
    p35:DisconnectAll();
    local v36 = rawget(p35, "_proxyHandler");
    if v36 then
        v36:Disconnect();
    end;
end;
setmetatable(u12, {
    __newindex = function(_, p37, _) --[[ Name: __newindex, Line 372 ]]
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p37))), 2);
    end
});
return u12;
