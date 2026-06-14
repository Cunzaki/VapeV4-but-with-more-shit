-- Decompiled from: ReplicatedFirst.Runtime.Source.LoadingManager.Task
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u3 = {
    Descriptor = "Task.Descriptor",
    Worker = function(p1, p2) --[[ Name: Worker, Line 3 ]]
        p1(1);
        p2();
    end
};
u3.__index = u3;
function u3.New(p4) --[[ Line: 10 ]]
    -- upvalues: u3 (copy)
    return setmetatable(p4 or {}, u3);
end;
return u3;
