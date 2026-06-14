-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.MiscOldEvents
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    AutumnMug = {
        MaxItem = 4,
        Name = "Autumn Mug",
        DrinkCount = 6,
        Tool = game:GetService("ReplicatedStorage").Assets.Tools.AutumnMug,
        Apply = function(p1, p2, p3) --[[ Name: Apply, Line 9 ]]
            if p3 then
                p1.Bottom.Emitter.Enabled = true;
                p1.Drink.Transparency = 0.4;
            else
                p1.Bottom.Emitter.Enabled = false;
                p1.DrinkFull.Transparency = 1;
            end;
            if p2 then
                p1.Drink.Color = p2;
            end;
        end,
        Recipes = {
            {
                Name = "Apple Cider",
                ALC = 0,
                Modifiers = { "AppleCider" }
            },
            {
                Name = "Witches Brew",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "WitchesBrew" }
            },
            {
                Name = "Vampire Punch",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "VampPunch" }
            }
        }
    },
    Sparkler = {
        MaxItem = 1,
        ServerToolIndex = "Sparkler",
        Name = "Sparkler",
        CannotBeUsed = true
    },
    GoldenCupcake = {
        MaxItem = 1,
        ServerToolIndex = "GoldenCupcake",
        Name = "Golden Cupcake",
        DrinkCount = 8,
        DestroyWhenUsed = true
    }
};
