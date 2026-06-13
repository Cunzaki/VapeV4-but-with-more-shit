-- Decompiled from: ReplicatedStorage.Modules.Mutex
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    __index = {}
};
function u1.__index.Count(p2) --[[ Line: 11 ]]
    return #p2.queue;
end;
function u1.__index.within(p3, u4) --[[ Line: 15 ]]
    p3:acquire();
    local v5, v6 = pcall(function() --[[ Line: 18 ]]
        -- upvalues: u4 (copy)
        u4();
    end);
    if not v5 then
        warn("Mutex error within");
        warn(v6);
    end;
    p3:release();
end;
function u1.__index.acquire(p7) --[[ Line: 30 ]]
    local v8 = coroutine.running();
    table.insert(p7.queue, v8);
    if #p7.queue ~= 1 then
        coroutine.yield();
    end;
end;
function u1.__index.release(p9) --[[ Line: 40 ]]
    table.remove(p9.queue, 1);
    if #p9.queue ~= 0 then
        coroutine.resume(p9.queue[1]);
    end;
end;
function u1.new() --[[ Line: 48 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        queue = {}
    }, u1);
end;
return u1;
