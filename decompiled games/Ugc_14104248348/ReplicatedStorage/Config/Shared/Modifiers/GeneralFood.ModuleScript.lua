-- Decompiled from: ReplicatedStorage.Config.Shared.Modifiers.GeneralFood
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    BBQSauce = {
        HoverName = "BBQ Sauce",
        Action = "Tossing with BBQ Sauce",
        ActionTime = 1,
        Animation = "GeneralInteraction"
    },
    BuffaloSauce = {
        HoverName = "Buffalo Sauce",
        Action = "Tossing with Buffalo Sauce",
        ActionTime = 1,
        Animation = "GeneralInteraction"
    },
    MustardHotDog = {
        Action = "Adding Mustard",
        HoverName = "Mustard",
        PartExtra = "Mustard",
        ActionTime = 0.2,
        Animation = "GeneralInteraction",
        Garnish = { "Hotdog" }
    },
    KetchupHotDog = {
        Action = "Adding Ketchup",
        HoverName = "Ketchup",
        PartExtra = "Ketchup",
        ActionTime = 0.2,
        Animation = "GeneralInteraction",
        Garnish = { "Hotdog" }
    },
    SlicedLettuce = {
        HoverName = "Sliced Lettuce",
        Action = "Adding Sliced Lettuce",
        PartExtra = "Lettuce",
        ActionTime = 0.5,
        Animation = "GeneralInteraction",
        Garnish = { "Burger" },
        RequiresModifiers = { "BurgerBun" }
    },
    SlicedTomato = {
        HoverName = "Sliced Tomato",
        Action = "Adding Sliced Tomato",
        PartExtra = "Tomato",
        ActionTime = 0.5,
        Animation = "GeneralInteraction",
        Garnish = { "Burger" },
        RequiresModifiers = { "BurgerBun" }
    },
    SlicedCheese = {
        HoverName = "Sliced Cheese",
        Action = "Adding Sliced Cheese",
        PartExtra = "Cheese",
        ActionTime = 0.5,
        Animation = "GeneralInteraction",
        Garnish = { "Burger" },
        RequiresModifiers = { "BurgerBun" }
    },
    Pico = {
        HoverName = "Pico",
        Action = "Adding Pico",
        PartExtra = "Pico",
        ActionTime = 0.5,
        Animation = "GeneralInteraction",
        Garnish = { "TacoMeat" },
        RequiresModifiers = { "HardTacoShell" }
    },
    ShreddedLettuce = {
        HoverName = "Shredded Lettuce",
        Action = "Adding Shredded Lettuce",
        PartExtra = "ShreddedLettuce",
        ActionTime = 0.5,
        Animation = "GeneralInteraction",
        Garnish = { "TacoMeat" },
        RequiresModifiers = { "HardTacoShell" }
    },
    HardTacoShell = {
        HoverName = "Hard Taco Shell",
        Action = "Adding Taco Shell",
        ActionTime = 0.5,
        Animation = "GeneralInteraction",
        PartExtras = { "HardShell", "TacoCookedMeat" }
    },
    Tortilla = {
        HoverName = "Tortilla",
        Action = "Adding Tortilla",
        PartExtra = "Tortilla",
        ActionTime = 0.5,
        Animation = "GeneralInteraction"
    },
    HotdogBun = {
        HoverName = "Hotdog Bun",
        Action = "Putting into Bun",
        PartExtra = "Bun",
        ActionTime = 2,
        Animation = "GeneralInteraction"
    },
    BurgerBun = {
        HoverName = "Burger Bun",
        Action = "Putting into Bun",
        PartExtra = "Bun",
        ActionTime = 2,
        Animation = "GeneralInteraction",
        PartExtras = { "TopBun", "BottomBun" }
    },
    FoodTray = {
        HoverName = "Food Tray",
        Action = "Putting into Tray",
        PartExtra = "FoodTray",
        ActionTime = 3,
        Animation = "GeneralInteraction"
    },
    FryCup = {
        Action = "Adding Fry Cup",
        HoverName = "Fry Cup",
        ActionTime = 3,
        PartExtra = "Handle",
        Color = Color3.new(1, 1, 1)
    }
};
