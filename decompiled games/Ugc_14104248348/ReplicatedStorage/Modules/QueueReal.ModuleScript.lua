-- Decompiled from: ReplicatedStorage.Modules.QueueReal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Signal__1 = require(script:WaitForChild("Signal"));
local u1 = {
    Cache = {}
};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 7 ]]
    -- upvalues: l__Signal__1 (copy), u1 (copy)
    local v4 = typeof(p2) ~= nil;
    assert(v4, "Argument #1 of Queue.New cannot be nil.");
    local v5 = p3 == nil and true or type(p3) == "boolean";
    assert(v5, "Argument #2 of Queue.New must be a boolean or nil.");
    local v6 = p2 or newproxy();
    local v7 = {
        Paused = false,
        IsRunning = false,
        Object = v6,
        Queue = {},
        MassRun = p3 or false,
        Completed = l__Signal__1.new()
    };
    local v8 = setmetatable(v7, u1);
    u1.Cache[v6] = v8;
    return v8;
end;
function u1.Fetch(p9) --[[ Line: 28 ]]
    -- upvalues: u1 (copy)
    local v10 = typeof(p9) ~= nil;
    assert(v10, "Argument #1 of Queue.New cannot be nil.");
    return u1.Cache[p9];
end;
function u1.Add(p11, p12, p13, p14) --[[ Line: 34 ]]
    -- upvalues: l__Signal__1 (copy)
    local v15 = type(p12) == "function";
    assert(v15, "Argument #1 must be a function.");
    local v16 = p13 == nil and true or typeof(p13) == "boolean";
    assert(v16, "Argument #2 must be a boolean or nil");
    local v17 = p14 == nil and true or typeof(p14) == "boolean";
    assert(v17, "Argument #3 must be a boolean or nil");
    local u18 = false;
    local v19, v20;
    if p13 then
        local u21 = coroutine.running();
        v19 = l__Signal__1.new();
        v19:Connect(function() --[[ Line: 43 ]]
            -- upvalues: u18 (ref), u21 (ref)
            u18 = true;
            if coroutine.status(u21) == "suspended" then
                coroutine.resume(u21);
            end;
        end);
        v20 = u21;
    else
        v19 = nil;
        v20 = nil;
    end;
    table.insert(p11.Queue, {
        func = p12,
        completeSignal = v19
    });
    if p11.IsRunning == false and p14 == true then
        p11:Run();
    end;
    if p13 and not u18 then
        coroutine.yield(v20);
    end;
end;
function u1.AddAndRun(p22, p23, p24) --[[ Line: 66 ]]
    p22:Add(p23, p24, true);
end;
function u1.Run(u25, p26) --[[ Line: 70 ]]
    if u25.IsRunning == true then
    else
        u25.IsRunning = true;
        local function u30() --[[ Line: 74 ]]
            -- upvalues: u25 (copy)
            while #u25.Queue > 0 do
                if u25.Paused then
                    wait();
                else
                    local v27 = table.remove(u25.Queue, 1);
                    local v28, v29 = pcall(v27.func);
                    if not v28 then
                        warn("Error processing function in queue:", v29);
                    end;
                    if v27.completeSignal then
                        v27.completeSignal:Fire();
                    end;
                end;
            end;
            u25.IsRunning = false;
            u25.Completed:Fire();
        end;
        if p26 then
            u30();
        else
            if not p26 then
                coroutine.resume(coroutine.create(function() --[[ Line: 96 ]]
                    -- upvalues: u30 (copy)
                    u30();
                end));
            end;
        end;
    end;
end;
function u1.Clear(p31, p32) --[[ Line: 102 ]]
    local v33 = p32 == nil and true or type(p32) == "boolean";
    assert(v33, "Argument #1 of Queue.Clear must be a boolean or nil.");
    if p32 then
        for _, u34 in pairs(p31.Queue) do
            coroutine.resume(coroutine.create(function() --[[ Line: 107 ]]
                -- upvalues: u34 (copy)
                local v35, v36 = pcall(u34.func);
                if not v35 then
                    warn("Error processing function in queue:", v36);
                end;
                u34.completeSignal:Fire();
            end));
        end;
    end;
    p31.Queue = {};
end;
function u1.Pause(p37) --[[ Line: 120 ]]
    p37.Paused = true;
end;
function u1.Resume(p38) --[[ Line: 124 ]]
    p38.Paused = false;
    if not p38.IsRunning then
        p38:Run();
    end;
end;
return u1;
