-- Decompiled from: ReplicatedStorage.Assets.Shared.Bin
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

return function() --[[ Line: 6 ]]
    local u1 = {};
    return function(p2) --[[ Line: 9 ]]
        -- upvalues: u1 (copy)
        table.insert(u1, p2);
        return p2;
    end, function() --[[ Line: 14 ]]
        -- upvalues: u1 (copy)
        for _, v3 in u1 do
            if typeof(v3) == "Instance" then
                v3:Destroy();
            elseif typeof(v3) == "RBXScriptConnection" then
                v3:Disconnect();
            elseif typeof(v3) == "function" then
                task.spawn(v3);
            elseif typeof(v3) == "thread" then
                pcall(task.cancel, v3);
            elseif typeof(v3) == "table" and (v3._binCleanup and type(v3._binCleanup) == "function") then
                v3:_binCleanup();
            end;
        end;
        table.clear(u1);
    end;
end;
