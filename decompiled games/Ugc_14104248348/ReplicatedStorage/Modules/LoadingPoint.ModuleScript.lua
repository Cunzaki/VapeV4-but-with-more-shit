-- Decompiled from: ReplicatedStorage.Modules.LoadingPoint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Instance.new("BindableEvent");
local u2 = Instance.new("BindableEvent");
local u3 = {
    ServerIsLoaded = false,
    IsLoaded = false,
    ServerLoaded = u2.Event,
    Loaded = u1.Event
};
function u3.ServerLoadSignal() --[[ Line: 10 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u3.ServerIsLoaded = true;
    u2:Fire();
end;
function u3.WaitUntilServerLoaded() --[[ Line: 15 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if not u3.ServerIsLoaded then
        u2.Event:Wait();
    end;
end;
function u3.WaitUntilLoaded() --[[ Line: 21 ]]
    -- upvalues: u3 (copy)
    while not u3.IsLoaded do
        task.wait();
    end;
end;
function u3.LoadSignal() --[[ Line: 25 ]]
    -- upvalues: u3 (copy), u1 (copy)
    u3.IsLoaded = true;
    u1:Fire();
end;
function u3.UponLoad(p4) --[[ Line: 29 ]]
    -- upvalues: u3 (copy), u1 (copy)
    if not u3.IsLoaded then
        u1.Event:Wait();
    end;
    task.wait();
    p4();
end;
return u3;
