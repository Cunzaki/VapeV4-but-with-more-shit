-- Decompiled from: ReplicatedStorage.Config.Shared.Machines
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    WaterTap1 = {
        HoverName = "Water Tap",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Water",
        AllowedUses = { "EmptyGlass" }
    },
    Blender = {
        HoverName = "Blender",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Blended",
        AllowedUses = { "FancyDrinkMix" }
    },
    Reactor = {
        HoverName = "Reactor",
        ControlledByScript = true,
        MaxUses = 2,
        Modifier = "Reactor",
        AllowedUses = { "Seraphic", "Fire", "BlessedFlame" }
    },
    CookiePan = {
        HoverName = "Cookie Pan",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Nothing",
        AllowedUses = { "Dough" }
    },
    Pan = {
        HoverName = "Pan",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Nothing",
        AllowedUses = {
            "Dough",
            "Sauce",
            "Cheese",
            "Pepperoni"
        }
    },
    BeerTap = {
        HoverName = "Beer Tap",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Nothing"
    },
    Oven = {
        HoverName = "Oven",
        Disabled = true,
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Baked",
        AllowedUses = { "Pizza", "CookiePan" }
    },
    SeafoodPot = {
        HoverName = "Seafood Pot",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Boiled",
        AllowedUses = { "RawLobster", "RawCrawfish" }
    },
    Fryer = {
        HoverName = "Fryer",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Fried",
        AllowedUses = {
            "RawFries",
            "RawOnionRings",
            "RawMozSticks",
            "RawWings",
            "RawBatteredFish",
            "RawCalamari",
            "RawTaquito"
        }
    },
    Grill = {
        HoverName = "Grill",
        Disabled = true,
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Grilled",
        AllowedUses = {
            "RawHotdog",
            "RawBurger",
            "RawTacoMeat",
            "RawRibs"
        }
    },
    KBBQGrill = {
        HoverName = "Grill",
        Disabled = true,
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Cooked",
        AllowedUses = { "RawBeefBulgogi", "RawPorkbelly" }
    },
    HotPot = {
        HoverName = "Hot Pot",
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Boiled",
        AllowedUses = { "RawBeefBulgogi", "RawPorkbelly" }
    },
    Plate = {
        HoverName = "Plate",
        Disabled = true,
        ControlledByScript = true,
        ShouldNotRegisterInteractionClass = true,
        Modifier = "Plated",
        AllowedUses = {}
    }
};
