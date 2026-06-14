-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.removeAllItemId
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "removeAllItemId",
    Description = "Remove all Items from a player(s) by their userid.",
    Group = "GameOwner",
    Args = {
        {
            Type = "number",
            Name = "PlayerID",
            Description = "The PlayerID of the player to ban."
        },
        {
            Type = "itemname",
            Name = "Item",
            Description = "The name of the item you would like to give!."
        }
    }
};
