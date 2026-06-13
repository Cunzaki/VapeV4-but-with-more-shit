-- Decompiled from: ReplicatedStorage.Modules.Index
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, ...) --[[ Line: 1 ]]
    if p1 then
        local v2 = typeof(p1) == "Instance";
        assert(v2, "FirstInstance must be type Instance");
        for _, v3 in { ... } do
            p1 = p1:WaitForChild(v3);
        end;
        return p1;
    end;
end;
