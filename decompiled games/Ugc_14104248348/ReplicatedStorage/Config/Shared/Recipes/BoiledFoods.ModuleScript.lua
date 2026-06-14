-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.BoiledFoods
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
    Lobster = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Raw Lobster",
        DrinkID = "RawLobster",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Lobster"),
        Recipes = {
            {
                Name = "Loose Lobster",
                Modifiers = { "Boiled" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Overcooked Lobster",
                Modifiers = { "Boiled", "Overcooked" }
            },
            {
                Name = "Overcooked Lobster",
                Modifiers = { "Boiled", "Overcooked", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Lobster",
                Modifiers = { "Boiled", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    },
    Crawfish = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        Name = "Raw Crawfish",
        DrinkID = "RawCrawfish",
        DrinkCount = 3,
        Tool = l__Index__1(v1, "Kitchen", "Crawfish"),
        Recipes = {
            {
                Name = "Loose Crawfish",
                Modifiers = { "Boiled" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "KitchenTable"
                }
            },
            {
                Name = "Overcooked Crawfish",
                Modifiers = { "Boiled", "Overcooked" }
            },
            {
                Name = "Overcooked Crawfish",
                Modifiers = { "Boiled", "Overcooked", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            },
            {
                Name = "Crawfish",
                Modifiers = { "Boiled", "FoodTray" },
                Attributes = {
                    DontAllowPlace = false,
                    PlaceGroup = "ClearAttributeValue"
                }
            }
        }
    }
};
