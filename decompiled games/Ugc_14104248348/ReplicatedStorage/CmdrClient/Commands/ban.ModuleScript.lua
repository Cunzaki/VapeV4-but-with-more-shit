-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.ban
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "ban",
    Description = "Bans player(s) for a duration of time.",
    Group = "GameBanPermission",
    Args = {
        {
            Type = "string",
            Name = "Reason",
            Description = "The reason for the ban."
        },
        {
            Type = "duration",
            Name = "Duration",
            Description = "The duration of the ban. (-1: Forever)"
        },
        {
            Type = "players",
            Name = "players",
            Description = "The player(s) to ban."
        }
    }
};
