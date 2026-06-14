-- Decompiled from: ReplicatedFirst.Runtime.Source.LoadingManager
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local l__LightRunner__1 = _G.LightRunner;
local u2 = {
    CurrentProgress = 0,
    TaskChanged = l__LightRunner__1.Signal.new(),
    ProgressChanged = l__LightRunner__1.Signal.new(),
    Loaded = l__LightRunner__1.Signal.new()
};
local u3 = {};
u3.__index = u3;
function u3.new(p4, p5) --[[ Line: 15 ]]
    -- upvalues: l__LightRunner__1 (copy), u3 (copy)
    local v6 = {
        ProgressDecimal = 0,
        Task = p4[p5],
        Position = p5,
        StepArray = p4,
        DidFinish = l__LightRunner__1.Signal.new()
    };
    return setmetatable(v6, u3);
end;
function u3.Execute(u7) --[[ Line: 28 ]]
    -- upvalues: u2 (copy)
    task.spawn(function() --[[ Line: 29 ]]
        -- upvalues: u7 (copy), u2 (ref)
        local v8, v9 = pcall(function() --[[ Line: 30 ]]
            -- upvalues: u7 (ref), u2 (ref)
            u7.Task.Worker(function(...) --[[ Line: 31 ]]
                -- upvalues: u7 (ref)
                u7:Progress(...);
            end, function(...) --[[ Line: 33 ]]
                -- upvalues: u7 (ref)
                u7:Finish();
            end, u2, u7.Task);
        end);
        if not v8 then
            u7:Finish();
            warn((`Finishing the task {u7.Task.Descriptor}! Because it errored LOL`));
            error(v9);
        end;
    end);
end;
function u3.Finish(p10) --[[ Line: 48 ]]
    p10.Finished = true;
    p10.DidFinish:Fire();
end;
function u3.WaitUntilCompleted(p11) --[[ Line: 53 ]]
    if not p11.Finished then
        p11.DidFinish:Wait();
    end;
end;
function u3.Focus(p12) --[[ Line: 59 ]]
    -- upvalues: u2 (copy)
    u2:SetProgress(p12.Position / (#p12.StepArray + 1));
    u2.CurrentTask = p12.Task;
    u2.TaskChanged:Fire(p12.Task);
end;
function u3.Progress(p13, p14) --[[ Line: 66 ]]
    -- upvalues: u2 (copy)
    if u2.CurrentTask == p13.Task then
        if p13.ProgressDecimal < p14 and p13.ProgressDecimal <= 1 then
            p13.ProgressDecimal = p14;
        end;
        u2:SetProgress((p13.Position + p13.ProgressDecimal) / (#p13.StepArray + 1));
    end;
end;
function u2.SetProgress(_, p15) --[[ Line: 78 ]]
    -- upvalues: u2 (copy)
    local v16 = math.min(1, p15);
    math.max(v16, 0);
    if u2.CurrentProgress ~= p15 then
        u2.CurrentProgress = p15;
        u2.ProgressChanged:Fire(p15);
    end;
end;
function u2.ExecuteSteps(_, p17) --[[ Line: 89 ]]
    -- upvalues: u3 (copy), u2 (copy)
    local v18 = {};
    for v19, _ in p17 do
        local v20 = u3.new(p17, v19);
        v18[v19] = v20;
        if v20.Task.StartEarly then
            v20:Execute();
        end;
    end;
    for _, v21 in v18 do
        v21:Focus();
        if not v21.Task.StartEarly then
            v21:Execute();
        end;
        v21:WaitUntilCompleted();
    end;
    u2:SetProgress(1);
    u2.Loaded:Fire();
    u2.IsLoaded = true;
end;
function u2.HideAll(_) --[[ Line: 114 ]]
    -- upvalues: u1 (ref)
    u1:Get("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
end;
function u2.ShowAll(_) --[[ Line: 118 ]]
    -- upvalues: u1 (ref)
    u1:Get("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
end;
function u2.Start(_) --[[ Line: 122 ]]
    -- upvalues: u2 (copy)
    u2:HideAll();
    u2:ExecuteSteps(require(script.LoadingTasks));
    u2:ShowAll();
end;
function u2.WhenLoaded(_) --[[ Line: 128 ]]
    -- upvalues: u1 (ref), l__LightRunner__1 (copy)
    u1 = l__LightRunner__1:Get("Runner");
end;
return u2;
