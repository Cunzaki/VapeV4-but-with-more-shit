-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.version
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "version",
    Description = "Shows the current version of Cmdr",
    Group = "DefaultDebug",
    Args = {},
    Run = function() --[[ Name: Run, Line 9 ]]
        return ("Cmdr Version %s"):format("v1.8.4");
    end
};
