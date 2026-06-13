-- Decompiled from: ReplicatedStorage.Modules.QueueReal.Signal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 3 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local u5 = {};
u5.__index = u5;
function u5.new(p6, p7) --[[ Line: 15 ]]
    -- upvalues: u5 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p6,
        _fn = p7
    }, u5);
end;
function u5.Disconnect(p8) --[[ Line: 24 ]]
    assert(p8._connected, "Connection already disconnected.");
    p8._connected = false;
    if p8._signal._handlerListHead == p8 then
        p8._signal._handlerListHead = p8._next;
    else
        local l___handlerListHead__1 = p8._signal._handlerListHead;
        while l___handlerListHead__1 and l___handlerListHead__1._next ~= p8 do
            l___handlerListHead__1 = l___handlerListHead__1._next;
        end;
        if l___handlerListHead__1 then
            l___handlerListHead__1._next = p8._next;
        end;
    end;
end;
local u9 = {};
u9.__index = u9;
function u9.new() --[[ Line: 46 ]]
    -- upvalues: u9 (copy)
    return setmetatable({
        _handlerListHead = false
    }, u9);
end;
function u9.Connect(p10, p11) --[[ Line: 50 ]]
    -- upvalues: u5 (copy)
    local v12 = u5.new(p10, p11);
    v12._next = p10._handlerListHead and p10._handlerListHead or v12._next;
    p10._handlerListHead = v12;
    return v12;
end;
function u9.Fire(p13, ...) --[[ Line: 57 ]]
    -- upvalues: u1 (ref), u4 (copy)
    local l___handlerListHead__2 = p13._handlerListHead;
    while l___handlerListHead__2 do
        if l___handlerListHead__2._connected then
            if not u1 then
                u1 = coroutine.create(function(...) --[[ Line: 62 ]]
                    -- upvalues: u4 (ref)
                    u4(...);
                    while true do
                        u4(coroutine.yield());
                    end;
                end);
            end;
            task.spawn(u1, l___handlerListHead__2._fn, ...);
        end;
        l___handlerListHead__2 = l___handlerListHead__2._next;
    end;
end;
function u9.Wait(p14) --[[ Line: 75 ]]
    local u15 = coroutine.running();
    local u16 = nil;
    u16 = p14:Connect(function(...) --[[ Line: 78 ]]
        -- upvalues: u16 (ref), u15 (copy)
        u16:Disconnect();
        task.spawn(u15, ...);
    end);
    return coroutine.yield();
end;
return u9;
