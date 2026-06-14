-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.alias
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "alias",
    Description = "Creates a new, single command out of a command and given arguments.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "string",
            Name = "Alias name",
            Description = "The key or input type you\'d like to bind the command to."
        },
        {
            Type = "string",
            Name = "Command string",
            Description = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc."
        }
    },
    ClientRun = function(p1, p2, p3) --[[ Name: ClientRun, Line 19 ]]
        p1.Cmdr.Registry:RegisterCommandObject(p1.Cmdr.Util.MakeAliasCommand(p2, p3), true);
        return ("Created alias %q"):format(p2);
    end
};
