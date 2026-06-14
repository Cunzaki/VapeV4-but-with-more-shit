-- Decompiled from: ReplicatedFirst.Runtime.LightRunner
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    Modules = {}
};
function u1.Get(_, p2) --[[ Line: 9 ]]
    -- upvalues: u1 (copy)
    return u1.Modules[p2];
end;
function u1.Load(_, p3) --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    local u4 = false;
    u1:IterateRules(p3, function(u5) --[[ Line: 15 ]]
        -- upvalues: u1 (ref), u4 (ref)
        local v6 = task.spawn(function() --[[ Line: 16 ]]
            -- upvalues: u1 (ref), u5 (copy)
            u1.Modules[u5.Name] = require(u5);
        end);
        if coroutine.status(v6) ~= "dead" then
            u4 = true;
            warn("[LightRunner]: ==================================================================");
            warn((`[LightRunner]: Please resolve yeilding in LightRunner Module {u5.Name}!`));
            warn("[LightRunner]: No yeilding! Please use WhenLoaded() or get events when existance!");
            warn("[LightRunner]: This should ensure it can be done in a single frame!");
            warn("[LightRunner]: ==================================================================");
        end;
    end);
    if u4 then
        task.wait();
    end;
    for _, v7 in u1.Modules do
        if v7.WhenLoaded then
            v7:WhenLoaded();
        end;
    end;
end;
function u1.IterateRules(_, p8, p9) --[[ Line: 39 ]]
    for _, v10 in p8:GetDescendants() do
        if v10:IsA("ModuleScript") and not (v10.Parent:IsA("ModuleScript") or v10.Parent:IsA("Configuration")) then
            p9(v10);
        end;
    end;
end;
return u1;
