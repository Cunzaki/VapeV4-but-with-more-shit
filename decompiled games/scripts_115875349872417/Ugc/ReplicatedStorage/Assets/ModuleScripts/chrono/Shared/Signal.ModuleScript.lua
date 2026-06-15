-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 52 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5() --[[ Line: 63 ]]
    -- upvalues: u4 (copy)
    while true do
        u4(coroutine.yield());
    end;
end;
local u6 = {};
u6.__index = u6;
function u6.new(p7, p8, p9) --[[ Line: 78 ]]
    -- upvalues: u6 (copy)
    return setmetatable({
        _type_ = "Connection",
        Connected = true,
        _next = false,
        _signal = p7,
        _fn = p8,
        _defer = p9 or false,
        _binCleanup = u6.Disconnect
    }, u6);
end;
function u6.Disconnect(p10) --[[ Line: 90 ]]
    p10.Connected = false;
    if p10._signal._handlerListHead == p10 then
        p10._signal._handlerListHead = p10._next;
    else
        local l___handlerListHead__1 = p10._signal._handlerListHead;
        while l___handlerListHead__1 and l___handlerListHead__1._next ~= p10 do
            l___handlerListHead__1 = l___handlerListHead__1._next;
        end;
        if l___handlerListHead__1 then
            l___handlerListHead__1._next = p10._next;
        end;
    end;
end;
setmetatable(u6, {
    __index = function(_, p11) --[[ Name: __index, Line 112 ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end,
    __newindex = function(_, p12, _) --[[ Name: __newindex, Line 115 ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p12))), 2);
    end
});
local u13 = {};
u13.__index = u13;
function u13.new() --[[ Line: 123 ]]
    -- upvalues: u13 (copy)
    return setmetatable({
        _type_ = "Event",
        _handlerListHead = false
    }, u13);
end;
function u13.Connect(p14, p15, p16) --[[ Line: 130 ]]
    -- upvalues: u6 (copy)
    local v17 = u6.new(p14, p15, p16);
    if not p14._handlerListHead then
        p14._handlerListHead = v17;
        return v17;
    end;
    v17._next = p14._handlerListHead;
    p14._handlerListHead = v17;
    return v17;
end;
function u13.Wait(p18, p19) --[[ Line: 143 ]]
    local u20 = coroutine.running();
    local u21 = nil;
    u21 = p18:Connect(function(...) --[[ Line: 146 ]]
        -- upvalues: u21 (ref), u20 (copy)
        u21:Disconnect();
        task.spawn(u20, ...);
    end, p19);
    return coroutine.yield();
end;
function u13.Once(p22, u23, p24) --[[ Line: 155 ]]
    local u25 = nil;
    u25 = p22:Connect(function(...) --[[ Line: 157 ]]
        -- upvalues: u25 (ref), u23 (copy)
        if u25.Connected then
            u25:Disconnect();
        end;
        u23(...);
    end, p24);
    return u25;
end;
local u26 = {};
u26.__index = u26;
function u26.new() --[[ Line: 170 ]]
    -- upvalues: u13 (copy), u26 (copy)
    local v27 = {
        _type_ = "Signal",
        Event = u13.new(),
        _binCleanup = u26.DisconnectAll
    };
    return setmetatable(v27, u26);
end;
function u26.DisconnectAll(p28) --[[ Line: 180 ]]
    p28.Event._handlerListHead = false;
end;
function u26.Fire(p29, ...) --[[ Line: 188 ]]
    -- upvalues: u1 (ref), u5 (copy)
    local l___handlerListHead__2 = p29.Event._handlerListHead;
    debug.profilebegin("Signal.Fire");
    while l___handlerListHead__2 do
        if l___handlerListHead__2.Connected then
            if l___handlerListHead__2._defer then
                task.defer(l___handlerListHead__2._fn, ...);
            else
                if not u1 then
                    u1 = coroutine.create(u5);
                    coroutine.resume(u1);
                end;
                task.spawn(u1, l___handlerListHead__2._fn, ...);
            end;
        end;
        l___handlerListHead__2 = l___handlerListHead__2._next;
    end;
    debug.profileend();
end;
setmetatable(u26, {
    __index = function(_, p30) --[[ Name: __index, Line 211 ]]
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p30))), 2);
    end,
    __newindex = function(_, p31, _) --[[ Name: __newindex, Line 214 ]]
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p31))), 2);
    end
});
return u26;