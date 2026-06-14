-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.kick
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "givec",
    Description = "Give currency to a player.",
    Group = "DefaultAdmin",
    Aliases = { "boot" },
    Args = {
        {
            Type = "player",
            Name = "player",
            Description = "The players to give to."
        }
    }
};
