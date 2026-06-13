-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.echo
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "echo",
    Description = "Echoes your text back to you.",
    Group = "DefaultUtil",
    Aliases = { "=" },
    Args = {
        {
            Type = "string",
            Name = "Text",
            Description = "The text."
        }
    },
    Run = function(_, p1) --[[ Name: Run, Line 14 ]]
        return p1;
    end
};
