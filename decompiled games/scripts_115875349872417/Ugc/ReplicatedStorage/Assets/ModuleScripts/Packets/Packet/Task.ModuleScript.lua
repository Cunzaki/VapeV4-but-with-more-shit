-- Decompiled with Potassium's decompiler.

return {
    Type = "Task",
    Spawn = function(_, p1, ...) --[[ Name: Spawn, Line 18 ]]
        return task.spawn(p1, ...);
    end,
    Defer = function(_, p2, ...) --[[ Name: Defer, Line 22 ]]
        return task.defer(p2, ...);
    end,
    Delay = function(_, p3, p4, ...) --[[ Name: Delay, Line 26 ]]
        return task.delay(p3, p4, ...);
    end
};