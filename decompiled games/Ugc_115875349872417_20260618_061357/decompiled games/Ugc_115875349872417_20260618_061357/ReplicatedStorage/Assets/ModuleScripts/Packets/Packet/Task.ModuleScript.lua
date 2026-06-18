-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Packets.Packet.Task
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
