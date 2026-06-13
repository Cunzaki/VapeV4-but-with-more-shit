-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Food
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
    Dough = {
        MaxItem = 1,
        DrinkID = "Dough",
        Name = "Dough",
        DrinkCount = 0,
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "Dough")
    },
    Sauce = {
        MaxItem = 1,
        DrinkID = "Sauce",
        Name = "Sauce",
        DrinkCount = 0,
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "Sauce")
    },
    Cheese = {
        MaxItem = 1,
        DrinkID = "Cheese",
        Name = "Cheese",
        DrinkCount = 0,
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "Cheese")
    },
    Pepperoni = {
        MaxItem = 1,
        DrinkID = "Pepperoni",
        Name = "Pepperoni",
        DrinkCount = 0,
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "Pepperoni")
    },
    Slice = {
        MaxItem = 8,
        DrinkCount = 3,
        DestroyWhenUsed = true,
        DrinkID = "Slice",
        Name = "Pizza Slice",
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "Slice")
    },
    PizzaCutter = {
        MaxItem = 1,
        DrinkID = "PizzaCutter",
        Name = "Pizza Cutter",
        ActionTime = 0.2,
        Action = "Grabbing Pizza Cutter",
        Animation = "GeneralInteraction",
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "PizzaCutter")
    },
    Pizza = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        DrinkCount = 8,
        DrinkID = "Pizza",
        Name = "Empty Pan",
        PlaceSound = "MetalTrayPlaceSound",
        Tool = l__Index__1(v1, "Kitchen", "Pizza", "Pizza"),
        Recipes = {
            {
                Name = "Empty Pizza",
                DrinkID = "Pizza",
                Modifiers = { "Dough" }
            }
        }
    },
    TreeCutter = {
        MaxItem = 1,
        DrinkID = "CookieCutter",
        Name = "Tree Cutter",
        ActionTime = 0.2,
        Action = "Grabbing Tree Cutter",
        Animation = "GeneralInteraction",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "TreeCutter")
    },
    PresentCutter = {
        MaxItem = 1,
        DrinkID = "CookieCutter",
        Name = "Present Cutter",
        ActionTime = 0.2,
        Action = "Grabbing Present Cutter",
        Animation = "GeneralInteraction",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "PresentCutter")
    },
    SnowflakeCutter = {
        MaxItem = 1,
        DrinkID = "CookieCutter",
        Name = "Snowflake Cutter",
        ActionTime = 0.2,
        Action = "Grabbing Snowflake Cutter",
        Animation = "GeneralInteraction",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "SnowflakeCutter")
    },
    CustomizableCookieTree = {
        MaxItem = 8,
        DrinkCount = 3,
        DestroyWhenUsed = true,
        DrinkID = "CustomizableCookie",
        Name = "Tree Cookie",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "TreeCookie")
    },
    CustomizableCookieSnowflake = {
        MaxItem = 8,
        DrinkCount = 3,
        DestroyWhenUsed = true,
        DrinkID = "CustomizableCookie",
        Name = "Snowflake Cookie",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "StarCookie")
    },
    CustomizableCookiePresent = {
        MaxItem = 8,
        DrinkCount = 3,
        DestroyWhenUsed = true,
        DrinkID = "CustomizableCookie",
        Name = "Present Cookie",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "PresentCookie")
    },
    CookiePan = {
        MaxItem = 3,
        DestroyWhenUsed = true,
        DrinkCount = 8,
        DrinkID = "CookiePan",
        Name = "Empty Cookie Pan",
        PlaceSound = "MetalTrayPlaceSound",
        Tool = l__Index__1(v1, "Kitchen", "Cookie", "CookiePan"),
        Recipes = {
            {
                Name = "Raw Cookie",
                DrinkID = "CookiePan",
                Modifiers = { "Dough" }
            }
        }
    }
};
