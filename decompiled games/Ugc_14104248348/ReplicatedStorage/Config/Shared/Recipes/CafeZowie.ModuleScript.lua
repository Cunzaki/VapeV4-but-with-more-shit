-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.CafeZowie
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Tools__1 = game:GetService("ReplicatedStorage").Assets.Tools;
return {
    Plate = {
        MaxItem = 1,
        ServerToolIndex = "Plate",
        Name = "Plate",
        CannotBeUsed = true
    },
    TurkeyLeg = {
        MaxItem = 1,
        ServerToolIndex = "TurkeyLeg",
        Name = "Turkey Leg",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    LemonCakeMacaroon = {
        MaxItem = 1,
        ServerToolIndex = "LemonCakeMacaroon",
        Name = "Lemon Cake Macaron",
        DrinkCount = 3,
        DestroyWhenUsed = true
    },
    StrawberryMacaroon = {
        MaxItem = 1,
        ServerToolIndex = "StrawberryMacaroon",
        Name = "Strawberry Macaron",
        DrinkCount = 3,
        DestroyWhenUsed = true
    },
    ChocolateMacaroon = {
        MaxItem = 1,
        ServerToolIndex = "ChocolateMacaroon",
        Name = "Chocolate Macaron",
        DrinkCount = 3,
        DestroyWhenUsed = true
    },
    StrawberryCheescake = {
        MaxItem = 1,
        ServerToolIndex = "StrawberryCheescake",
        Name = "Strawberry Cheescake",
        DrinkCount = 6,
        DestroyWhenUsed = true
    },
    ChocolateCheescake = {
        MaxItem = 1,
        ServerToolIndex = "ChocolateCheescake",
        Name = "Chocolate Cheescake",
        DrinkCount = 6,
        DestroyWhenUsed = true
    },
    HeartCookies = {
        MaxItem = 1,
        ServerToolIndex = "HeartCookies",
        Name = "Heart Cookie",
        DrinkCount = 3,
        DestroyWhenUsed = true
    },
    ChocolateCakePop = {
        MaxItem = 1,
        ServerToolIndex = "ChocolateCakePop",
        Name = "Chocolate Cake Pop",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    CaramelCakePop = {
        MaxItem = 1,
        ServerToolIndex = "CaramelCakePop",
        Name = "Caramel Cake Pop",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    CookieCrumbCakePop = {
        MaxItem = 1,
        ServerToolIndex = "CookieCrumbCakePop",
        Name = "Caramel Crumb Cake Pop",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    FunfettiCupcake = {
        MaxItem = 1,
        ServerToolIndex = "FunfettiCupcake",
        Name = "Funfetti Cupcake",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    ChocolateCupcake = {
        MaxItem = 1,
        ServerToolIndex = "ChocolateCupcake",
        Name = "Chocolate Cupcake",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    StrawberryCupcake = {
        MaxItem = 1,
        ServerToolIndex = "StrawberryCupcake",
        Name = "Strawberry Cupcake",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    TresLeches = {
        MaxItem = 1,
        ServerToolIndex = "TresLeches",
        Name = "Tres Leches",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    CandyCaneCookie = {
        MaxItem = 1,
        ServerToolIndex = "CandyCaneCookie",
        Name = "Candy Cane Cookie",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    GingerbreadCookie = {
        MaxItem = 1,
        ServerToolIndex = "GingerbreadCookie",
        Name = "Gingerbread Cookie",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    ChristmasTreeCookie = {
        MaxItem = 1,
        ServerToolIndex = "ChristmasTreeCookie",
        Name = "Christmas Tree Cookie",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    KelsmasCookie = {
        MaxItem = 1,
        ServerToolIndex = "KelsmasCookie",
        Name = "Kelsmas Cookie",
        DrinkCount = 4,
        DestroyWhenUsed = true
    },
    Bagel = {
        MaxItem = 1,
        ServerToolIndex = "Bagel",
        Name = "Bagel",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    Croissant = {
        MaxItem = 1,
        ServerToolIndex = "Croissant",
        Name = "Croissant",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    BannanzaBread = {
        MaxItem = 1,
        ServerToolIndex = "BannanzaBread",
        Name = "Bannanza Bread",
        DrinkCount = 8,
        DestroyWhenUsed = true
    },
    CoffeeCup = {
        MaxItem = 4,
        Name = "Coffee Cup",
        RecipeName = "CoffeeCup",
        DrinkCount = 4,
        Tool = l__Tools__1.CoffeeCup,
        Recipes = {
            {
                Name = "Espresso",
                Modifiers = { "CoffeeMaker" }
            },
            {
                Name = "Latte",
                Modifiers = { "CoffeeMaker", "Milk" }
            },
            {
                Name = "Mocha",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "ChocolateSyrup" }
            },
            {
                Name = "Caramel Mocha",
                Transparency = 0,
                Modifiers = {
                    "CoffeeMaker",
                    "Milk",
                    "ChocolateSyrup",
                    "CaramelSyrup"
                }
            },
            {
                Name = "Peppermint Latte",
                Modifiers = { "CoffeeMaker", "Milk", "PeppermintSyrup" }
            },
            {
                Name = "Peppermint Mocha",
                Modifiers = {
                    "CoffeeMaker",
                    "Milk",
                    "PeppermintSyrup",
                    "ChocolateSyrup"
                }
            },
            {
                Name = "Vanilla Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "VanillaSyrup" }
            },
            {
                Name = "Caramel Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "CaramelSyrup" }
            },
            {
                Name = "Pumpkin Spice Latte",
                Modifiers = { "CoffeeMaker", "Milk", "PumpkinSpiceCreamer" }
            },
            {
                Name = "Coffee",
                Modifiers = { "DripCoffee" }
            },
            {
                Name = "Coffee /w Milk",
                Modifiers = { "DripCoffee", "Milk" }
            },
            {
                Name = "Pumpkin Spice Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk", "PumpkinSpiceCreamer" }
            },
            {
                Name = "Caramel Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk", "CaramelSyrup" }
            },
            {
                Name = "Vanilla Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk", "VanillaSyrup" }
            },
            {
                Name = "Vanilla Cream Delight",
                Transparency = 0,
                Modifiers = {
                    "DripCoffee",
                    "Milk",
                    "VanillaSyrup",
                    "VanillaCreamer"
                }
            }
        }
    },
    IceCoffeeCup = {
        MaxItem = 4,
        Name = "Ice Coffee Cup",
        RecipeName = "IceCoffeeCup",
        DrinkCount = 8,
        Tool = l__Tools__1["Ice Coffee Cup"],
        Apply = function(p1, p2, p3) --[[ Name: Apply, Line 289 ]]
            if p3 then
                p1.Drink.Transparency = 0;
            else
                p1.Drink.Transparency = 1;
            end;
            if p2 then
                p1.Drink.Color = p2;
            end;
        end,
        Recipes = {
            {
                Name = "Milk",
                Transparency = 0,
                Modifiers = { "Milk" }
            },
            {
                Name = "Chocolate Milk",
                Transparency = 0,
                Modifiers = { "ChocolateSyrup", "Milk" }
            },
            {
                Name = "Iced Americano",
                Transparency = 0,
                Modifiers = { "CoffeeMaker" }
            },
            {
                Name = "Iced Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk" }
            },
            {
                Name = "Iced Peppermint Latte",
                Modifiers = { "CoffeeMaker", "Milk", "PeppermintSyrup" }
            },
            {
                Name = "Iced Mocha",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "ChocolateSyrup" }
            },
            {
                Name = "Iced Peppermint Mocha",
                Modifiers = {
                    "CoffeeMaker",
                    "Milk",
                    "PeppermintSyrup",
                    "ChocolateSyrup"
                }
            },
            {
                Name = "Iced Caramel Mocha",
                Transparency = 0,
                Modifiers = {
                    "CoffeeMaker",
                    "Milk",
                    "ChocolateSyrup",
                    "CaramelSyrup"
                }
            },
            {
                Name = "Iced Pumpkin Spice Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "PumpkinSpiceCreamer" }
            },
            {
                Name = "Iced Vanilla Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "VanillaSyrup" }
            },
            {
                Name = "Iced Caramel Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk", "CaramelSyrup" }
            },
            {
                Name = "Iced Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee" }
            },
            {
                Name = "Iced Coffee /w Milk",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk" }
            },
            {
                Name = "Iced Pumpkin Spice Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk", "PumpkinSpiceCreamer" }
            },
            {
                Name = "Iced Caramel Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk", "CaramelSyrup" }
            },
            {
                Name = "Iced Vanilla Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk", "VanillaSyrup" }
            },
            {
                Name = "Iced Vanilla Cream Delight",
                Transparency = 0,
                Modifiers = {
                    "DripCoffee",
                    "Milk",
                    "VanillaSyrup",
                    "VanillaCreamer"
                }
            }
        }
    },
    GlassCoffeeMug = {
        MaxItem = 4,
        Name = "Glass Coffee Mug",
        RecipeName = "GlassCoffeeMug",
        DrinkCount = 8,
        Tool = l__Tools__1["Glass Coffee Mug"],
        Apply = function(p4, p5, p6) --[[ Name: Apply, Line 398 ]]
            if p6 then
                p4.Drink.Transparency = 0;
                p4.Foam.Transparency = 0;
            else
                p4.Drink.Transparency = 1;
                p4.Foam.Transparency = 1;
            end;
            if p5 then
                p4.Drink.Color = p5;
            end;
        end,
        Recipes = {
            {
                Name = "Espresso",
                Transparency = 0,
                Modifiers = { "CoffeeMaker" }
            },
            {
                Name = "Latte",
                Transparency = 0,
                Modifiers = { "CoffeeMaker", "Milk" }
            },
            {
                Name = "Irish Coffee",
                Transparency = 0,
                ALC = 0.2,
                Modifiers = { "CoffeeMaker", "Irish" }
            },
            {
                Name = "Irish Latte",
                Transparency = 0,
                ALC = 0.2,
                Modifiers = { "CoffeeMaker", "Irish", "Milk" }
            },
            {
                Name = "Coffee",
                Transparency = 0,
                Modifiers = { "DripCoffee" }
            },
            {
                Name = "Coffee /w Milk",
                Transparency = 0,
                Modifiers = { "DripCoffee", "Milk" }
            },
            {
                Name = "Irish Coffee",
                Transparency = 0,
                ALC = 0.2,
                Modifiers = { "DripCoffee", "Irish" }
            },
            {
                Name = "Irish Latte",
                Transparency = 0,
                ALC = 0.2,
                Modifiers = { "DripCoffee", "Irish", "Milk" }
            }
        }
    }
};
