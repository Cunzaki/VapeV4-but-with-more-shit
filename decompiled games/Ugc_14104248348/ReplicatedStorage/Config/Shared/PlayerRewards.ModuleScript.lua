-- Decompiled from: ReplicatedStorage.Config.Shared.PlayerRewards
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    {
        ID = "GoldPin",
        Name = "Golden Pin!",
        ProductID = 14475651981,
        Description = "The best of best pins! (Play for 30 Hours).",
        Method = "TimePlayed",
        TimeRequired = 108000
    },
    {
        ID = "FlowerCap",
        Name = "Flower Cap.",
        ProductID = 14648176099,
        Description = "Flower power! (Reach drink mastering level 5)",
        Method = "LevelCheck",
        LevelRequirement = { "Bartending", 5 }
    },
    {
        ID = "GoldenBeanie",
        Name = "Golden Diepolder Beanie",
        ProductID = 14878506541,
        Description = "Hat but gold. (Reach minigames level 10)",
        Method = "LevelCheck",
        LevelRequirement = { "Minigames", 10 }
    },
    {
        ID = "KuraoKami",
        Name = "Kuraokami Sword",
        Description = "Im sorry yall, pity next time? 😓😓😓 (Open 500 2nd Anniversary Lootboxes)",
        Method = "StatCheck",
        GivesItem = true,
        IVID = "CosmeticFightTool.Kuraokami",
        StatRequirement = { "Total_Opened_2ndAnniversary", 500 }
    },
    {
        ID = "FreeItem1",
        Name = "Free item! 1",
        Description = "A free item for all the delays in these updates recently guys </3. (1 drinks dranks)",
        Method = "StatCheck",
        GivesItem = true,
        IVID = "CosmeticSmallGlass.ValentinesCup",
        StatRequirement = { "DrinksDrank", 1 }
    },
    {
        ID = "FreeItem2",
        Name = "Free item! 2",
        Description = "A free item for all the delays in these updates recently guys </3. (1 drinks drank)",
        Method = "StatCheck",
        GivesItem = true,
        IVID = "CosmeticFancyGlass.FloatingIsland",
        StatRequirement = { "DrinksDrank", 1 }
    }
};
