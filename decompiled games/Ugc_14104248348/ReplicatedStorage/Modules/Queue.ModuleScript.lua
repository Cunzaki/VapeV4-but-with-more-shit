-- Decompiled from: ReplicatedStorage.Modules.Queue
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        ShouldExhaust = false,
        QueueIsBusy = true,
        List = {}
    }, u1);
end;
function u1.Clear(p2) --[[ Line: 15 ]]
    p2.List = {};
end;
function u1.Push(p3, p4) --[[ Line: 19 ]]
    table.insert(p3.List, p4);
end;
function u1.Length(p5) --[[ Line: 23 ]]
    return #p5.List;
end;
function u1.WaitAndGetResume(p6) --[[ Line: 27 ]]
    local u7 = false;
    local u8 = coroutine.running();
    local u9 = false;
    p6:Push(function() --[[ Line: 31 ]]
        -- upvalues: u8 (copy), u9 (ref), u7 (ref)
        task.spawn(u8);
        u9 = true;
        repeat
            task.wait();
        until u7;
    end);
    if not u9 then
        coroutine.yield();
    end;
    return function() --[[ Line: 40 ]]
        -- upvalues: u7 (ref)
        u7 = true;
    end;
end;
function u1.PushAndWait(p10) --[[ Line: 45 ]]
    p10:RunPushedFunctions();
    local v11 = os.clock();
    local u12 = coroutine.running();
    local u13 = false;
    p10:Push(function() --[[ Line: 51 ]]
        -- upvalues: u12 (copy), u13 (ref)
        task.spawn(u12);
        u13 = true;
    end);
    if not u13 then
        coroutine.yield();
    end;
    return os.clock() - v11;
end;
function u1.Pop(p14) --[[ Line: 61 ]]
    if not p14:IsEmpty() then
        return table.remove(p14.List);
    end;
    warn("Cannot use .Pop() on a empty queue.");
end;
function u1.IsEmpty(p15) --[[ Line: 70 ]]
    return #p15.List == 0;
end;
function u1.Exhaust(u16, u17) --[[ Line: 74 ]]
    local v18 = type(u17) == "function";
    assert(v18, ".Exhaust(ExhaustFn : ()->(). Invalid paramaters.");
    if not u16.ShouldExhaust then
        u16.ShouldExhaust = true;
        u16.ExhaustThread = task.spawn(function() --[[ Line: 79 ]]
            -- upvalues: u16 (copy), u17 (copy)
            while true do
                while u16:IsEmpty() do
                    task.wait();
                end;
                pcall(u17, u16:Pop());
                task.wait(u16.Step or 0);
            end;
        end);
    end;
end;
function u1.RunPushedFunctions(u19) --[[ Line: 92 ]]
    u19:Exhaust(function(u20) --[[ Line: 93 ]]
        -- upvalues: u19 (copy)
        local v21 = typeof(u20) == "function";
        assert(v21, "You used .RunPushedFunctions() only .Push() functions.");
        local v22, _ = pcall(function() --[[ Line: 96 ]]
            -- upvalues: u20 (copy)
            return u20();
        end);
        if not v22 then
            u19:Push(u20);
        end;
    end);
end;
function u1.GetList(p23) --[[ Line: 106 ]]
    return p23.List;
end;
return u1;
