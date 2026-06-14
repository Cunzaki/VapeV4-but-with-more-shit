-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
for _, u2 in script:GetChildren() do
    local v3, v4 = pcall(function() --[[ Line: 4 ]]
        -- upvalues: u2 (copy)
        return require(u2);
    end);
    if v3 then
        if v4._id then
            v1[v4._id] = v4;
        else
            warn((`Failure to load '{u2.Name}'! Because it was missing an required index _id.`));
        end;
    else
        warn((`Failure to load '{u2.Name}'!`));
    end;
end;
return v1;
