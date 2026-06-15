-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 9 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5() --[[ Line: 16 ]]
    -- upvalues: u4 (copy)
    while true do
        u4(coroutine.yield());
    end;
end;
local u6 = {};
u6.__index = u6;
function u6.new(p7, p8, p9) --[[ Line: 26 ]]
    -- upvalues: u6 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p7,
        _fn = p8,
        _isSync = p9 == true
    }, u6);
end;
function u6.Destroy(p10) --[[ Line: 50 ]]
    p10._connected = false;
    if p10._isSync then
        local l___signal__1 = p10._signal;
        if l___signal__1._syncHandlerListHead == p10 then
            l___signal__1._syncHandlerListHead = p10._next;
            return;
        end;
        local l___syncHandlerListHead__2 = l___signal__1._syncHandlerListHead;
        while l___syncHandlerListHead__2 and l___syncHandlerListHead__2._next ~= p10 do
            l___syncHandlerListHead__2 = l___syncHandlerListHead__2._next;
        end;
        if l___syncHandlerListHead__2 then
            l___syncHandlerListHead__2._next = p10._next;
        end;
    else
        local l___signal__3 = p10._signal;
        if l___signal__3._asyncHandlerListHead == p10 then
            l___signal__3._asyncHandlerListHead = p10._next;
            return;
        end;
        local l___asyncHandlerListHead__4 = l___signal__3._asyncHandlerListHead;
        while l___asyncHandlerListHead__4 and l___asyncHandlerListHead__4._next ~= p10 do
            l___asyncHandlerListHead__4 = l___asyncHandlerListHead__4._next;
        end;
        if l___asyncHandlerListHead__4 then
            l___asyncHandlerListHead__4._next = p10._next;
        end;
    end;
end;
function u6.Disconnect(p11) --[[ Line: 59 ]]
    p11._connected = false;
    if p11._isSync then
        local l___signal__5 = p11._signal;
        if l___signal__5._syncHandlerListHead == p11 then
            l___signal__5._syncHandlerListHead = p11._next;
            return;
        end;
        local l___syncHandlerListHead__6 = l___signal__5._syncHandlerListHead;
        while l___syncHandlerListHead__6 and l___syncHandlerListHead__6._next ~= p11 do
            l___syncHandlerListHead__6 = l___syncHandlerListHead__6._next;
        end;
        if l___syncHandlerListHead__6 then
            l___syncHandlerListHead__6._next = p11._next;
        end;
    else
        local l___signal__7 = p11._signal;
        if l___signal__7._asyncHandlerListHead == p11 then
            l___signal__7._asyncHandlerListHead = p11._next;
            return;
        end;
        local l___asyncHandlerListHead__8 = l___signal__7._asyncHandlerListHead;
        while l___asyncHandlerListHead__8 and l___asyncHandlerListHead__8._next ~= p11 do
            l___asyncHandlerListHead__8 = l___asyncHandlerListHead__8._next;
        end;
        if l___asyncHandlerListHead__8 then
            l___asyncHandlerListHead__8._next = p11._next;
        end;
    end;
end;
setmetatable(u6, {
    __index = function(_, p12) --[[ Name: __index, Line 69 ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p12))), 2);
    end,
    __newindex = function(_, p13, _) --[[ Name: __newindex, Line 72 ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p13))), 2);
    end
});
local u14 = {};
u14.__index = u14;
function u14.new() --[[ Line: 81 ]]
    -- upvalues: u14 (copy)
    local v15 = setmetatable({
        _syncHandlerListHead = false,
        _asyncHandlerListHead = false
    }, u14);
    v15.Event = v15;
    return v15;
end;
function u14.Connect(p16, p17) --[[ Line: 93 ]]
    -- upvalues: u6 (copy)
    local v18 = u6.new(p16, p17, false);
    if not p16._asyncHandlerListHead then
        p16._asyncHandlerListHead = v18;
        return v18;
    end;
    v18._next = p16._asyncHandlerListHead;
    p16._asyncHandlerListHead = v18;
    return v18;
end;
function u14.ConnectSync(p19, p20) --[[ Line: 105 ]]
    -- upvalues: u6 (copy)
    local v21 = u6.new(p19, p20, true);
    if not p19._syncHandlerListHead then
        p19._syncHandlerListHead = v21;
        return v21;
    end;
    v21._next = p19._syncHandlerListHead;
    p19._syncHandlerListHead = v21;
    return v21;
end;
function u14.DisconnectAll(p22) --[[ Line: 116 ]]
    p22._asyncHandlerListHead = false;
    p22._syncHandlerListHead = false;
end;
function u14.Destroy(p23) --[[ Line: 121 ]]
    p23._asyncHandlerListHead = false;
    p23._syncHandlerListHead = false;
end;
function u14.Fire(p24, ...) --[[ Line: 127 ]]
    -- upvalues: u1 (ref), u5 (copy)
    local l___syncHandlerListHead__9 = p24._syncHandlerListHead;
    while l___syncHandlerListHead__9 do
        if l___syncHandlerListHead__9._connected then
            local v25 = coroutine.create(l___syncHandlerListHead__9._fn);
            local v26, v27 = coroutine.resume(v25, ...);
            if v26 then
                if coroutine.status(v25) ~= "dead" then
                    warn(("Signal ConnectSync handler yielded; synchronous handlers must not yield (handler: %s)"):format((tostring(l___syncHandlerListHead__9._fn))));
                end;
            else
                warn(("Signal ConnectSync handler error (continuing): %s"):format((tostring(v27))));
            end;
        end;
        l___syncHandlerListHead__9 = l___syncHandlerListHead__9._next;
    end;
    local l___asyncHandlerListHead__10 = p24._asyncHandlerListHead;
    while l___asyncHandlerListHead__10 do
        if l___asyncHandlerListHead__10._connected then
            if not u1 then
                u1 = coroutine.create(u5);
                coroutine.resume(u1);
            end;
            task.spawn(u1, l___asyncHandlerListHead__10._fn, ...);
        end;
        l___asyncHandlerListHead__10 = l___asyncHandlerListHead__10._next;
    end;
end;
function u14.Wait(p28) --[[ Line: 163 ]]
    local u29 = coroutine.running();
    local u30 = nil;
    u30 = p28:Connect(function(...) --[[ Line: 166 ]]
        -- upvalues: u30 (ref), u29 (copy)
        u30:Disconnect();
        task.spawn(u29, ...);
    end);
    return coroutine.yield();
end;
function u14.Once(p31, u32) --[[ Line: 173 ]]
    local u33 = nil;
    u33 = p31:Connect(function(...) --[[ Line: 175 ]]
        -- upvalues: u33 (ref), u32 (copy)
        if u33._connected then
            u33:Disconnect();
        end;
        u32(...);
    end);
    return u33;
end;
setmetatable(u14, {
    __index = function(_, p34) --[[ Name: __index, Line 185 ]]
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p34))), 2);
    end,
    __newindex = function(_, p35, _) --[[ Name: __newindex, Line 188 ]]
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p35))), 2);
    end
});
return u14;