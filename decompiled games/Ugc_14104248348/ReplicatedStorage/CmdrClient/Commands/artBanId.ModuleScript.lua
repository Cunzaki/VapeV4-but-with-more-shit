-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.artBanId
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "artBanId",
    Description = "Artban\'s player(s) for a duration of time.",
    Group = "BanPlayerNotes",
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
            Type = "number",
            Name = "PlayerID",
            Description = "The PlayerID of the player to ban."
        }
    }
};
