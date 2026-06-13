-- Decompiled from: ReplicatedStorage.Config.Shared.Modifiers.MiscOldEvents
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    AppleCider = {
        Action = "Adding Apple Cider ",
        HoverName = "Apple Cider",
        Handset = "AppleCider",
        Animation = "Pour",
        PourEvents = true,
        ActionTime = 3,
        Sounds = {
            PourLoop = "Interact.PourLoop",
            PourInit = "Interact.Cork"
        },
        Color = Color3.new(0.415686, 0.180392, 0.0235294)
    },
    EggNog = {
        Action = "Adding Egg Nog",
        HoverName = "Egg Nog",
        Handset = "EggNog",
        Animation = "NonAlcPour",
        PourEvents = true,
        PlayerCreateable = false,
        Rotation = 90,
        ActionTime = 3,
        Color = Color3.new(1, 0.933333, 0.690196)
    }
};
