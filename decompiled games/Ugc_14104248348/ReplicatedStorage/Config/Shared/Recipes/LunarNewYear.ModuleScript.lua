-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.LunarNewYear
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Tools__1 = game:GetService("ReplicatedStorage").Assets.Tools;
local v1 = game:GetService("RunService"):IsServer();
if v1 then
    v1 = game:GetService("ServerStorage"):WaitForChild("ServerTools");
end;
local l__Index__2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Index"));
return {
    NewYearNote = {
        MaxItem = 1,
        Name = "Offering Tree Note",
        CannotBeUsed = true,
        Tool = l__Tools__1.NewYearNote
    },
    SnakePlate = {
        MaxItem = 2,
        ServerToolIndex = "LNYSnakePlate",
        Name = "Plate",
        CannotBeUsed = true
    },
    Onigiri = {
        MaxItem = 2,
        ServerToolIndex = "Onigiri",
        Name = "Onigiri",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    MiniBento = {
        MaxItem = 1,
        ServerToolIndex = "MiniBento",
        Name = "Mini Bento",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    RobloxiSweat = {
        MaxItem = 2,
        ServerToolIndex = "RobloxiSweat",
        Name = "Robloxi Sweat Bottle",
        DrinkCount = 5,
        IgnoreInitialDrinkState = true
    },
    GreenTea = {
        MaxItem = 2,
        ServerToolIndex = "GreenTea",
        Name = "Green Tea Bottle",
        DrinkCount = 5,
        IgnoreInitialDrinkState = true
    },
    StrawberrySando = {
        MaxItem = 1,
        ServerToolIndex = "StrawberrySando",
        Name = "Strawberry Sando",
        DrinkCount = 5,
        DestroyWhenUsed = true
    },
    KiwiSando = {
        MaxItem = 1,
        ServerToolIndex = "KiwiSando",
        Name = "Kiwi Sando",
        DrinkCount = 5,
        DestroyWhenUsed = true
    },
    MangoSando = {
        MaxItem = 1,
        ServerToolIndex = "MangoSando",
        Name = "Mango Sando",
        DrinkCount = 5,
        DestroyWhenUsed = true
    },
    TangerineSando = {
        MaxItem = 1,
        ServerToolIndex = "TangerineSando",
        Name = "Tangerine Sando",
        DrinkCount = 5,
        DestroyWhenUsed = true
    },
    EggSando = {
        MaxItem = 1,
        ServerToolIndex = "EggSando",
        Name = "Egg Sando",
        DrinkCount = 5,
        DestroyWhenUsed = true
    },
    Hashbrown = {
        MaxItem = 1,
        ServerToolIndex = "Hashbrown",
        Name = "Tapichiki",
        DrinkCount = 3,
        DestroyWhenUsed = true
    },
    PeachRoju = {
        MaxItem = 1,
        ServerToolIndex = "PeachRoju",
        Name = "Peach Roju",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    StrawberryRoju = {
        MaxItem = 1,
        ServerToolIndex = "StrawberryRoju",
        Name = "Strawberry Roju",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    FreshRoju = {
        MaxItem = 1,
        ServerToolIndex = "FreshRoju",
        Name = "Fresh Roju",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    CarrotRoju = {
        MaxItem = 1,
        ServerToolIndex = "CarrotRoju",
        Name = "Carrot Roju",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    ChocolateBunnyPudding = {
        MaxItem = 2,
        ServerToolIndex = "ChocolateBunnyPudding",
        Name = "Chocolate Bunny Pudding",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    StrawberryBunnyPudding = {
        MaxItem = 2,
        ServerToolIndex = "StrawberryBunnyPudding",
        Name = "Strawberry Bunny Pudding",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    BunnyPudding = {
        MaxItem = 2,
        ServerToolIndex = "BunnyPudding",
        Name = "Bunny Pudding",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    Konpeito = {
        MaxItem = 2,
        ServerToolIndex = "Konpeito",
        Name = "Konpeito",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    FruitTanghulu = {
        MaxItem = 2,
        ServerToolIndex = "FruitTanghulu",
        Name = "Fruit Tanghulu",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    BlueberryTanghulu = {
        MaxItem = 2,
        ServerToolIndex = "BlueberryTanghulu",
        Name = "Blueberry Tanghulu",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    StrawberryTanghulu = {
        MaxItem = 2,
        ServerToolIndex = "StrawberryTanghulu",
        Name = "Strawberry Tanghulu",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    GrapeTanghulu = {
        MaxItem = 2,
        ServerToolIndex = "GrapeTanghulu",
        Name = "Grape Tanghulu",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    OrangeTanghulu = {
        MaxItem = 2,
        ServerToolIndex = "OrangeTanghulu",
        Name = "Orange Tanghulu",
        DrinkCount = 2,
        DestroyWhenUsed = true
    },
    BeefBulgogi = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Raw Beef Bulgogi",
        DrinkID = "RawBeefBulgogi",
        DrinkCount = 0,
        Tool = l__Index__2(v1, "Kitchen", "BeefBulgogi"),
        Recipes = {
            {
                Name = "Beef Bulgogi",
                Modifiers = { "Cooked" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Boiled Beef Bulgogi",
                Modifiers = { "Boiled" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Overcooked Beef Bulgogi",
                Modifiers = { "Boiled", "Overcooked" }
            },
            {
                Name = "Well Done Beef Bulgogi",
                Modifiers = { "Cooked", "WellDone" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Porkbelly = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Raw Porkbelly",
        DrinkID = "RawPorkbelly",
        DrinkCount = 0,
        Tool = l__Index__2(v1, "Kitchen", "Porkbelly"),
        Recipes = {
            {
                Name = "Porkbelly",
                Modifiers = { "Cooked" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Boiled Porkbelly",
                Modifiers = { "Boiled" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Overcooked Porkbelly",
                Modifiers = { "Boiled", "Overcooked" }
            },
            {
                Name = "Well Done Porkbelly",
                Modifiers = { "Cooked", "WellDone" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Ramen = {
        MaxItem = 2,
        ServerToolIndex = "Ramen",
        Name = "Noodles",
        DrinkCount = 5,
        DestroyWhenUsed = true,
        Recipes = {
            {
                Name = "Chicken Noodle Soup",
                Modifiers = { "ChickenBroth" }
            },
            {
                Name = "Veggie Noodles",
                Modifiers = { "VeggieBroth" }
            },
            {
                Name = "Beef Noodles",
                Modifiers = { "BeefBroth" }
            }
        }
    },
    Bento = {
        MaxItem = 2,
        ServerToolIndex = "Bento",
        Name = "Bento",
        DrinkCount = 8
    },
    Boba = {
        MaxItem = 4,
        ServerToolIndex = "Boba",
        Transparency = 0.25,
        Name = "Boba",
        DrinkCount = 4,
        Material = Enum.Material.SmoothPlastic,
        Recipes = {
            {
                Name = "Tea",
                ALC = -0.2,
                Transparency = 0.5,
                Modifiers = { "BobaTea" }
            },
            {
                Name = "Milk",
                ALC = -0.2,
                Transparency = 0.5,
                Modifiers = { "Milk" }
            }
        }
    }
};
