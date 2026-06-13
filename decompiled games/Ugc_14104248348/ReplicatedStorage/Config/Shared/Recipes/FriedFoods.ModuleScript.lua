-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.FriedFoods
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local _ = game:GetService("ReplicatedStorage").Assets.Tools;
local v1 = game:GetService("RunService"):IsServer();
if v1 then
    v1 = game:GetService("ServerStorage"):WaitForChild("ServerTools");
end;
local l__Index__1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Index"));
return {
    Fries = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Fries",
        DrinkID = "RawFries",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Fries"),
        Recipes = {
            {
                Name = "Loose Fries",
                Modifiers = { "Fried" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Fries",
                Modifiers = { "Fried", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Taquito = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Taquito",
        DrinkID = "RawTaquito",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Taquito"),
        Recipes = {
            {
                Name = "Taquito",
                Modifiers = { "Fried" },
                Attributes = {
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Calamari = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Calamari",
        DrinkID = "RawCalamari",
        DrinkCount = 4,
        Tool = l__Index__1(v1, "Kitchen", "Calamari"),
        Recipes = {
            {
                Name = "Loose Calamari",
                Modifiers = { "Fried" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Calamari",
                Modifiers = { "Fried", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    BatteredFish = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Battered Fish",
        DrinkID = "RawBatteredFish",
        DrinkCount = 4,
        Tool = l__Index__1(v1, "Kitchen", "BatteredFish"),
        Recipes = {
            {
                Name = "Loose Battered Fish",
                Modifiers = { "Fried" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Battered Fish",
                Modifiers = { "Fried", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    OnionRings = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Onion Rings",
        DrinkID = "RawOnionRings",
        DrinkCount = 4,
        Tool = l__Index__1(v1, "Kitchen", "OnionRings"),
        Recipes = {
            {
                Name = "Loose Onion Rings",
                Modifiers = { "Fried" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Onion Rings",
                Modifiers = { "Fried", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    MozSticks = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Mozzerella Sticks",
        DrinkID = "RawMozSticks",
        DrinkCount = 4,
        Tool = l__Index__1(v1, "Kitchen", "MozSticks"),
        Recipes = {
            {
                Name = "Loose Mozzerella Sticks",
                Modifiers = { "Fried" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Mozzerella Sticks",
                Modifiers = { "Fried", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Wings = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Wings",
        DrinkID = "RawWings",
        DrinkCount = 4,
        Tool = l__Index__1(v1, "Kitchen", "Wings"),
        Recipes = {
            {
                Name = "Loose Wings",
                Modifiers = { "Fried" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Wings",
                Modifiers = { "Fried", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Buffalo Wings",
                Modifiers = { "Fried", "FoodTray", "BuffaloSauce" },
                Attributes = {
                    TextureMatch = "rbxassetid://16999197169"
                }
            },
            {
                Name = "BBQ Wings",
                Modifiers = { "Fried", "FoodTray", "BBQSauce" },
                Attributes = {
                    TextureMatch = "rbxassetid://16999207428"
                }
            }
        }
    }
};
