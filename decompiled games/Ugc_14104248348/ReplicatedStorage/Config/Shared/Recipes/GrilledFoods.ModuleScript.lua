-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.GrilledFoods
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
    Hotdog = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Hot Dog",
        DrinkID = "RawHotdog",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Hotdog"),
        Recipes = {
            {
                Name = "Cooked Hot Dog",
                Modifiers = { "Grilled" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Hot Dog",
                Modifiers = { "Grilled", "HotdogBun" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Ribs = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Ribs",
        DrinkID = "RawRibs",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Ribs"),
        Recipes = {
            {
                Name = "Cooked Ribs",
                Modifiers = { "Grilled" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "BBQ Ribs",
                Modifiers = { "Grilled", "BBQSauce" }
            }
        }
    },
    Burger = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Burger",
        DrinkID = "RawBurger",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Burger"),
        Recipes = {
            {
                Name = "Cooked Burger",
                Modifiers = { "Grilled" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Burger",
                Modifiers = { "Grilled", "BurgerBun" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    TacoMeat = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Uncooked Taco Meat",
        DrinkID = "RawTacoMeat",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "TacoMeat"),
        Recipes = {
            {
                Name = "Cooked Taco Meat",
                Modifiers = { "Grilled" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Taco",
                Modifiers = { "Grilled", "HardTacoShell" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    }
};
