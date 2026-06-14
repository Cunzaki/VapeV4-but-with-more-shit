-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Icecream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local _ = game:GetService("ReplicatedStorage").Assets.Tools;
return {
    IceCreamCone = {
        MaxItem = 4,
        ServerToolIndex = "IceCreamCone",
        Name = "Ice Cream Cone",
        DrinkCount = 6,
        Recipes = {
            {
                Name = "Empty",
                Modifiers = { "ThrowawayModifierRef" }
            }
        }
    }
};
