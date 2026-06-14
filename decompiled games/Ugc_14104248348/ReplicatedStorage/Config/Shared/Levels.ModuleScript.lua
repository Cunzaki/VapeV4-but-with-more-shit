-- Decompiled from: ReplicatedStorage.Config.Shared.Levels
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Tolerance = {
        Name = "Tolerance",
        Description = "Depending on your tolerance it will determine how intoxicated you become.",
        MaxLevel = 20,
        DecayPerHour = 0.5,
        Order = 1,
        Balance = { 0.07, 2 }
    },
    Bartending = {
        Name = "Drink Mastering",
        Description = "This level is gained by making drinks!",
        MaxLevel = 60,
        DecayPerHour = 0,
        Order = 2,
        ActionSpeed = {
            [0] = 1,
            [5] = 0.95,
            [7] = 0.8,
            [15] = 0.75,
            [20] = 0.5,
            [25] = 0.45,
            [30] = 0.41,
            [35] = 0.38,
            [40] = 0.34,
            [44] = 0.3,
            [50] = 0.2,
            [55] = 0.1,
            [60] = 0.05
        },
        Balance = { 0.07, 2 }
    },
    Minigames = {
        Name = "Mini-games",
        Description = "This level is gained by playing mini-games.",
        MaxLevel = 300,
        DecayPerHour = 0,
        Order = 3,
        Balance = { 0.07, 2 }
    }
};
