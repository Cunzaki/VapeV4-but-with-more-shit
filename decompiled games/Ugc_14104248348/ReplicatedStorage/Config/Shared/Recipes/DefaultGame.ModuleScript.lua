-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.DefaultGame
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Tools__1 = game:GetService("ReplicatedStorage").Assets.Tools;
return {
    Potion = {
        Name = "Used Potion"
    },
    GenericDestroyingRecipe = {
        DestroyWhenUsed = true
    },
    Shaker = {
        MaxItem = 1,
        Name = "Shaker",
        CannotBeUsed = true,
        Tool = l__Tools__1.Shaker
    },
    Platter = {
        MaxItem = 1,
        Name = "Platter",
        CannotBeUsed = true,
        Tool = l__Tools__1.Platter
    },
    Vial = {
        MaxItem = 3,
        Name = "Vial",
        Tool = l__Tools__1.Vial
    },
    DiepolderCPA = {
        MaxItem = 1,
        ServerToolIndex = "Diepolder CPA",
        Name = "Diepolder CPA",
        DrinkCount = 8
    },
    DiepolderBrew = {
        MaxItem = 1,
        ServerToolIndex = "Diepolder Brew",
        Name = "Diepolder Brew",
        DrinkCount = 8
    },
    ShotgunBrew = {
        MaxItem = 1,
        Name = "Shotgun Brew",
        DestroyWhenUsed = true,
        DrinkCount = 1,
        Tool = l__Tools__1["Shotgun Brew"]
    },
    ShotgunCPA = {
        MaxItem = 1,
        Name = "Shotgun CPA",
        DestroyWhenUsed = true,
        DrinkCount = 1,
        Tool = l__Tools__1["Shotgun CPA"]
    },
    VineGlass = {
        MaxItem = 2,
        Skinnable = true,
        Name = "Vine Glass",
        DrinkCount = 7,
        Transparency = 0.5,
        Tool = l__Tools__1.VineGlass,
        Recipes = {
            {
                Name = "Red Vine",
                ID = "RedVine",
                ALC = 0.18,
                Transparency = 0,
                Modifiers = { "RedVine" }
            },
            {
                Name = "Sangria",
                ALC = 0.18,
                Transparency = 0,
                Modifiers = { "RedVine", "SweetAndSour" }
            },
            {
                Name = "White Vine",
                ID = "WhiteVine",
                ALC = 0.18,
                Modifiers = { "WhiteVine" }
            },
            {
                Name = "Sherry, Baby",
                ALC = 0.18,
                Modifiers = { "WhiteVine", "TonicWater" }
            }
        }
    },
    OchokoCup = {
        MaxItem = 2,
        Name = "Ochoko Cup",
        DrinkCount = 10,
        Tool = l__Tools__1.OchokoCup,
        Recipes = {
            {
                Name = "Blossom",
                ALC = 0.3,
                Modifiers = { "Blossom" }
            }
        }
    },
    FancyGlass = {
        MaxItem = 2,
        Skinnable = true,
        Name = "Fancy Glass",
        DrinkCount = 4,
        Tool = l__Tools__1.FancyGlass,
        Recipes = {
            {
                Name = "Drink Mix",
                ID = "FancyDrinkMix",
                ALC = 0,
                Modifiers = { "DrinkMix" }
            },
            {
                Name = "Blended Drink Base",
                ALC = 0,
                Modifiers = { "DrinkMix", "Blended" }
            },
            {
                Name = "Sparkling",
                ALC = 0.2,
                Modifiers = { "Sparkling" }
            },
            {
                Name = "Shooting Star",
                ALC = 0.2,
                Modifiers = { "Sparkling", "Shine" }
            },
            {
                Name = "French 75",
                ALC = 0.55,
                Modifiers = { "Sparkling", "Gin" }
            },
            {
                Name = "Mimosa",
                ALC = 0.2,
                Modifiers = { "Sparkling", "OrangeJuice" }
            },
            {
                Name = "Frozen Tonic",
                ALC = 0,
                Modifiers = { "DrinkMix", "TonicWater" }
            },
            {
                Name = "Blended Zest",
                ALC = 0,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Zest" }
            },
            {
                Name = "Blended Cola",
                ALC = 0,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Cola" }
            },
            {
                Name = "Blended Spirit",
                ALC = 0.2,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Spirit" }
            },
            {
                Name = "Blended Mash",
                ALC = 0.2,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Mash" }
            },
            {
                Name = "Blended Irish",
                ALC = 0.2,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Irish" }
            },
            {
                Name = "Blended Gin",
                ALC = 0.2,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Gin" }
            },
            {
                Name = "Blended Tete",
                ALC = 0.2,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Tete" }
            },
            {
                Name = "Blended Shine",
                ALC = 1,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Shine" }
            },
            {
                Name = "Blended Davy",
                ALC = 0.23,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "Davy" }
            },
            {
                Name = "Blended Pink Spirit",
                ALC = 0.15,
                Cold = true,
                Modifiers = { "DrinkMix", "Blended", "PinkSpirit" }
            },
            {
                Name = "Mocktail",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Zest",
                    "SweetAndSour"
                }
            },
            {
                Name = "The Mayflower",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Davy"
                }
            },
            {
                Name = "The Socialite",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Davy",
                    "Cola"
                }
            },
            {
                Name = "Cosmopolitan",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "SweetAndSour",
                    "CranberryJuice"
                }
            },
            {
                Name = "Sunshine",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "SweetAndSour"
                }
            },
            {
                Name = "Moonlight",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "BlueCuracao"
                }
            },
            {
                Name = "Sunset",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "Grenadine"
                }
            },
            {
                Name = "Blood Moon",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "CranberryJuice"
                }
            },
            {
                Name = "Eclipse",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "TonicWater"
                }
            },
            {
                Name = "Singularity",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "Cola"
                }
            },
            {
                Name = "Nebula",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "Zest"
                }
            },
            {
                Name = "Pulsar",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "PinkFlamingo"
                }
            },
            {
                Name = "Solar Flare",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "OrangeJuice"
                }
            },
            {
                Name = "Sol",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "MangoPuree"
                }
            },
            {
                Name = "Saturn",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "PineapplePuree"
                }
            },
            {
                Name = "Luna",
                ALC = 1,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Shine",
                    "CoconutSyrup"
                }
            },
            {
                Name = "London Shower",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Gin",
                    "BlueCuracao"
                }
            },
            {
                Name = "Gin Sour",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Gin",
                    "SweetAndSour"
                }
            },
            {
                Name = "Negroni",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Gin",
                    "Grenadine"
                }
            },
            {
                Name = "Martini",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Gin",
                    "WhiteVine"
                }
            },
            {
                Name = "Mango Tango",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Gin",
                    "MangoPuree"
                }
            },
            {
                Name = "Bitter Sunrise",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Gin",
                    "PineapplePuree"
                }
            },
            {
                Name = "Frozen Gin & Tonic",
                ALC = 0.3,
                Modifiers = { "DrinkMix", "Gin", "TonicWater" }
            },
            {
                Name = "Permafrost",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "BlueCuracao"
                }
            },
            {
                Name = "The Suburban",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "SweetAndSour"
                }
            },
            {
                Name = "Redlush",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Grenadine"
                }
            },
            {
                Name = "Red Ghost",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "CranberryJuice"
                }
            },
            {
                Name = "Orange Twist",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "OrangeJuice"
                }
            },
            {
                Name = "The Sandy",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "CoconutSyrup"
                }
            },
            {
                Name = "Typhoon",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "MangoPuree"
                }
            },
            {
                Name = "Spirit Cocktail",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Zest"
                }
            },
            {
                Name = "Tsunami",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Zest",
                    "BlueCuracao"
                }
            },
            {
                Name = "Red Tide",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Zest",
                    "Grenadine"
                }
            },
            {
                Name = "Delight",
                ALC = 0.7,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Spirit",
                    "Zest",
                    "SweetAndSour"
                }
            },
            {
                Name = "Eggnog Martini",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "EggNog"
                }
            },
            {
                Name = "Pina Bebida",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "SweetAndSour"
                }
            },
            {
                Name = "Sea of Tears",
                ALC = 0.33,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "BlueCuracao"
                }
            },
            {
                Name = "Carribean Punch",
                ALC = 0.25,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Grenadine"
                }
            },
            {
                Name = "Sparrow",
                ALC = 0.25,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "CranberryJuice"
                }
            },
            {
                Name = "Manila",
                ALC = 0.25,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "MangoPuree"
                }
            },
            {
                Name = "Sunrays",
                ALC = 0.25,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "PineapplePuree"
                }
            },
            {
                Name = "Polynesian",
                ALC = 0.25,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "CoconutSyrup"
                }
            },
            {
                Name = "Pina Colada",
                ALC = 0.25,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "PineapplePuree",
                    "CoconutSyrup"
                }
            },
            {
                Name = "Davy\'s Zest",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Zest"
                }
            },
            {
                Name = "Relaxer",
                ALC = 0.3,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Zest",
                    "Grenadine"
                }
            },
            {
                Name = "The Gentoo",
                ALC = 0.3,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Zest",
                    "BlueCuracao"
                }
            },
            {
                Name = "Margaritaville",
                ALC = 0.3,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Zest",
                    "SweetAndSour"
                }
            },
            {
                Name = "5\'o clock",
                ALC = 0.3,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Zest",
                    "CoconutSyrup"
                }
            },
            {
                Name = "Pink Pit",
                ALC = 0.2,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "PinkSpirit",
                    "SweetAndSour"
                }
            },
            {
                Name = "Barbie",
                ALC = 0.33,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "PinkSpirit",
                    "BlueCuracao"
                }
            },
            {
                Name = "P1NK",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "PinkSpirit",
                    "Grenadine"
                }
            },
            {
                Name = "Pink Clouds",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "PinkSpirit",
                    "CranberryJuice"
                }
            },
            {
                Name = "Desperado",
                ALC = 0.3,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Tete",
                    "SweetAndSour"
                }
            },
            {
                Name = "One of these Nights",
                ALC = 0.33,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Tete",
                    "BlueCuracao"
                }
            },
            {
                Name = "Hotel California",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Tete",
                    "Grenadine"
                }
            },
            {
                Name = "Matador",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Tete",
                    "CranberryJuice"
                }
            },
            {
                Name = "Tete Sunrise",
                ALC = 0.35,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Tete",
                    "BlueCuracao",
                    "OrangeJuice"
                }
            },
            {
                Name = "Mai Tai",
                ALC = 0.23,
                Cold = true,
                Modifiers = {
                    "DrinkMix",
                    "Blended",
                    "Davy",
                    "Grenadine",
                    "OrangeJuice"
                }
            },
            {
                Name = "Cup of Disappointment",
                ALC = 0.2,
                Modifiers = { "Disappointment" }
            },
            {
                Name = "Bad Advice",
                ALC = 0.2,
                Modifiers = { "BadAdvice" }
            },
            {
                Name = "Young Life Crisis",
                ALC = 0.5,
                Modifiers = { "Disappointment", "BadAdvice" }
            }
        }
    },
    Coconut = {
        MaxItem = 2,
        Name = "Coconut",
        DrinkCount = 4,
        Copies = "FancyGlass",
        Tool = l__Tools__1.Coconut,
        Recipes = {}
    },
    Mug = {
        MaxItem = 4,
        Skinnable = true,
        Name = "Mug",
        DrinkCount = 6,
        Tool = l__Tools__1.Mug,
        Recipes = {
            {
                Name = "Stout",
                ALC = 0.15,
                Transparency = 0.3,
                Modifiers = { "Stout" }
            },
            {
                Name = "Amber Nectar",
                ALC = 0.12,
                Transparency = 0.3,
                Modifiers = { "AmberNectar" }
            },
            {
                Name = "Citrus Brew",
                ALC = 0.17,
                Transparency = 0.3,
                Modifiers = { "CitrusBrew" }
            },
            {
                Name = "Wheat Brew",
                ALC = 0.12,
                Transparency = 0.3,
                Modifiers = { "WheatBrew" }
            },
            {
                Name = "Butter Brew",
                ALC = 0.14,
                Transparency = 0.3,
                Modifiers = { "ButterBrew" }
            },
            {
                Name = "Brainrot Brew",
                ALC = 0.14,
                Transparency = 0.3,
                Modifiers = { "ButterBrew", "Shine" }
            }
        }
    },
    Glass = {
        MaxItem = 1,
        Skinnable = true,
        Name = "Glass",
        DrinkID = "EmptyGlass",
        DrinkCount = 8,
        Copies = "SmallGlass",
        Tool = l__Tools__1.Glass,
        Recipes = {},
        CopyFunction = function(p1) --[[ Name: CopyFunction, Line 679 ]]
            return p1.Special ~= nil;
        end
    },
    ShotGlass = {
        MaxItem = 2,
        Skinnable = true,
        Name = "Shot Glass",
        DrinkCount = 1,
        Recipes = {
            {
                Name = "Spirit Shot",
                ALC = 0.45,
                Modifiers = { "Spirit" }
            },
            {
                Name = "Modyne Shot",
                ALC = 0.35,
                Modifiers = { "Modyne" }
            },
            {
                Name = "Tete Shot",
                ALC = 0.35,
                Modifiers = { "Tete" }
            },
            {
                Name = "Blue Tete Shot",
                ALC = 0.35,
                Frost = 0.5,
                Modifiers = { "BlueTete" }
            },
            {
                Name = "Mash Shot",
                ALC = 0.45,
                Modifiers = { "Mash" }
            },
            {
                Name = "Irish Shot",
                ALC = 0.45,
                Modifiers = { "Irish" }
            },
            {
                Name = "Shine Shot",
                ALC = 1.25,
                Modifiers = { "Shine" }
            },
            {
                Name = "Blossom Shot",
                ALC = 0.5,
                Modifiers = { "Blossom" }
            },
            {
                Name = "Gin Shot",
                ALC = 0.5,
                Modifiers = { "Gin" }
            }
        }
    },
    SmallGlass = {
        MaxItem = 4,
        Skinnable = true,
        Transparency = 0.5,
        Name = "Small Glass",
        DrinkCount = 4,
        Tool = l__Tools__1.SmallGlass,
        Material = Enum.Material.SmoothPlastic,
        Recipes = {
            {
                Name = "Milk",
                ALC = -0.2,
                Transparency = 0,
                Modifiers = { "Milk" }
            },
            {
                Name = "Pilk",
                ALC = -0.2,
                Transparency = 0,
                Modifiers = { "Cola", "Milk" }
            },
            {
                Name = "Angel\'s Drink",
                ALC = -0.6,
                Transparency = 0,
                Modifiers = { "Milk", "ChampionDrink" }
            },
            {
                Name = "Angel\'s Shot",
                ALC = -2,
                Transparency = 0,
                Modifiers = { "Milk", "ChampionDrink", "MustardHotDog" }
            },
            {
                Name = "Blue Milk",
                ALC = -0.2,
                Transparency = 0,
                Modifiers = { "Milk", "BlueCuracao" }
            },
            {
                Name = "Bloomer",
                ALC = -0.2,
                Modifiers = { "CranberryJuice", "OrangeJuice" }
            },
            {
                Name = "Fruit Fiesta",
                ALC = 0.2,
                Modifiers = { "CranberryJuice", "OrangeJuice", "Spirit" }
            },
            {
                Name = "Pink Flamingo",
                ALC = -0.2,
                Transparency = 0.8,
                Modifiers = { "PinkFlamingo" }
            },
            {
                Name = "Flamingo Milk",
                ALC = -0.2,
                Modifiers = { "PinkFlamingo", "Milk" }
            },
            {
                Name = "Spiked Flamingo Milk",
                ALC = 0.3,
                Modifiers = { "PinkFlamingo", "Milk", "Spirit" }
            },
            {
                Name = "Champion\'s Drink",
                ALC = 0.3,
                Modifiers = { "ChampionDrink" }
            },
            {
                Name = "Angry Irish",
                ALC = 0.3,
                Modifiers = { "ChampionDrink", "Irish" }
            },
            {
                Name = "Pink Moon",
                ALC = 0.3,
                Modifiers = { "PinkFlamingo", "BlueCuracao" }
            },
            {
                Name = "Flamingo Zest",
                ALC = -0.2,
                Modifiers = { "PinkFlamingo", "Zest" }
            },
            {
                Name = "Flamingo Zest Berry",
                ALC = -0.2,
                Modifiers = { "PinkFlamingo", "Zest", "CranberryJuice" }
            },
            {
                Name = "Flamingo Berry",
                ALC = -0.2,
                Modifiers = { "PinkFlamingo", "CranberryJuice" }
            },
            {
                Name = "Flamingo Fizz",
                ALC = 0.1,
                Modifiers = { "PinkFlamingo", "Sparkling" }
            },
            {
                Name = "Hard Flamingo Fizz",
                ALC = 0.4,
                Modifiers = { "PinkFlamingo", "Sparkling", "Spirit" }
            },
            {
                Name = "Spirit Flim Flam",
                ALC = 0.2,
                Modifiers = { "PinkFlamingo", "Spirit" }
            },
            {
                Name = "Sherly Flim",
                ALC = 0.2,
                Modifiers = { "PinkFlamingo", "Spirit", "Grenadine" }
            },
            {
                Name = "Flamingo Gin",
                ALC = 0.35,
                Modifiers = { "PinkFlamingo", "Gin" }
            },
            {
                Name = "Flamingo Martini",
                ALC = 0.35,
                Modifiers = { "PinkFlamingo", "Gin", "Zest" }
            },
            {
                Name = "Pink Cosmopolitan",
                ALC = 0.3,
                Modifiers = { "PinkFlamingo", "Spirit", "CranberryJuice" }
            },
            {
                Name = "Blossom Bomb",
                ALC = 0.3,
                Modifiers = { "PinkFlamingo", "Blossom" }
            },
            {
                Name = "Chocolate Milk",
                ALC = -0.2,
                Transparency = 0,
                Modifiers = { "Milk", "ChocolateSyrup" }
            },
            {
                Name = "Cranberry Juice",
                Modifiers = { "CranberryJuice" }
            },
            {
                Name = "Shirley Temple",
                Modifiers = { "Cola", "Grenadine" }
            },
            {
                Name = "Dirty Shirley",
                ALC = 0.2,
                Modifiers = { "Zest", "Grenadine", "Spirit" }
            },
            {
                Name = "Espresso",
                Transparency = 0,
                Modifiers = { "CoffeeMaker" }
            },
            {
                Name = "Spirit Cran\'",
                ALC = 0.2,
                Modifiers = { "Spirit", "CranberryJuice" }
            },
            {
                Name = "Eggnog",
                ALC = 0,
                Modifiers = { "EggNog" }
            },
            {
                Name = "Pirate\'s Holiday",
                ALC = 0.3,
                Modifiers = { "Davy", "EggNog" }
            },
            {
                Name = "Spiked Eggnog",
                ALC = 0.35,
                Modifiers = { "Mash", "EggNog" }
            },
            {
                Name = "Rompope",
                ALC = 0.35,
                Modifiers = { "Davy", "EggNog", "Milk" }
            },
            {
                Name = "Eierlikoer Egg",
                ALC = 0.4,
                Modifiers = { "Spirit", "EggNog" }
            },
            {
                Name = "Dark Russian",
                ALC = 0.8,
                Modifiers = { "Shine", "CoffeeMaker" }
            },
            {
                Name = "Stitch",
                ALC = 0.8,
                Modifiers = { "Shine", "BlueCuracao" }
            },
            {
                Name = "Sour Shine",
                ALC = 0.7,
                Modifiers = { "Shine", "SweetAndSour" }
            },
            {
                Name = "Light Russian",
                ALC = 0.8,
                Modifiers = { "Shine", "CoffeeMaker", "Milk" }
            },
            {
                Name = "Davy Cran\'",
                ALC = 0.2,
                Modifiers = { "Davy", "CranberryJuice" }
            },
            {
                Name = "Agave Juice",
                Modifiers = { "AgaveJuice" }
            },
            {
                Name = "Cola",
                Transparency = 0,
                Modifiers = { "Cola" }
            },
            {
                Name = "Tonic Water",
                Transparency = 0.9,
                Modifiers = { "TonicWater" }
            },
            {
                Name = "Zest",
                Transparency = 0,
                Modifiers = { "Zest" }
            },
            {
                Name = "Witches Brew",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "WitchesBrew" }
            },
            {
                Name = "Orange Juice",
                Transparency = 0,
                Modifiers = { "OrangeJuice" }
            },
            {
                Name = "Hurricane",
                Transparency = 0,
                Modifiers = { "OrangeJuice", "Zest" }
            },
            {
                Name = "Tete",
                ALC = 0.2,
                Modifiers = { "Tete" }
            },
            {
                Name = "Blue Tete",
                ALC = 0.2,
                Frost = 0.2,
                Modifiers = { "BlueTete" }
            },
            {
                Name = "Frosty Splash",
                ALC = 0.2,
                Frost = 0.3,
                Modifiers = { "Spirit", "BlueCuracao", "BlueTete" }
            },
            {
                Name = "Pot of Gold",
                ALC = 0.2,
                Modifiers = { "Tete", "Mash" }
            },
            {
                Name = "Spirit",
                ALC = 0.2,
                Modifiers = { "Spirit" }
            },
            {
                Name = "Gin",
                Transparency = 0.8,
                ALC = 0.35,
                Modifiers = { "Gin" }
            },
            {
                Name = "Gin & Tonic",
                ALC = 0.3,
                Modifiers = { "Gin", "TonicWater" }
            },
            {
                Name = "Spirit Tonic",
                ALC = 0.3,
                Modifiers = { "Spirit", "TonicWater" }
            },
            {
                Name = "Mash Tonic",
                ALC = 0.2,
                Modifiers = { "Mash", "TonicWater" }
            },
            {
                Name = "Royal-Tea",
                ALC = 0.3,
                Modifiers = { "Gin", "TonicWater", "SweetAndSour" }
            },
            {
                Name = "Tete Tonic",
                ALC = 0.2,
                Modifiers = { "Tete", "TonicWater" }
            },
            {
                Name = "Davy Tonic",
                ALC = 0.2,
                Modifiers = { "Tete", "TonicWater" }
            },
            {
                Name = "Royal Paloma",
                ALC = 0.2,
                Modifiers = { "Tete", "TonicWater", "OrangeJuice" }
            },
            {
                Name = "Gin Sling",
                ALC = 0.2,
                Modifiers = { "Gin", "Zest" }
            },
            {
                Name = "Tropic Thunder",
                ALC = 0.2,
                Modifiers = { "Gin", "MangoPuree" }
            },
            {
                Name = "Golden Pine",
                ALC = 0.2,
                Modifiers = { "Gin", "PineapplePuree" }
            },
            {
                Name = "Cranberry Gin Fizz",
                ALC = 0.3,
                Modifiers = { "Gin", "CranberryJuice" }
            },
            {
                Name = "Spiced Gin",
                ALC = 0.6,
                Modifiers = { "Gin", "Davy" }
            },
            {
                Name = "Friday Night",
                ALC = 0.6,
                Modifiers = { "Gin", "Davy", "SweetAndSour" }
            },
            {
                Name = "Pink Gin Iced Tea",
                ALC = 0.56,
                Modifiers = { "Gin", "Davy", "Grenadine" }
            },
            {
                Name = "Gin Martini",
                ALC = 0.36,
                Modifiers = { "Gin", "WhiteVine" }
            },
            {
                Name = "Gin Martini",
                ALC = 0.4,
                Modifiers = { "Gin", "WhiteVine", "OrangeJuice" }
            },
            {
                Name = "Modyne",
                ALC = 0.3,
                Modifiers = { "Modyne" }
            },
            {
                Name = "Mash",
                ALC = 0.2,
                Modifiers = { "Mash" }
            },
            {
                Name = "The Dubliner",
                ALC = 0.23,
                Modifiers = { "Irish", "Mash" }
            },
            {
                Name = "Ireland Beast",
                ALC = 0.23,
                Modifiers = { "Irish", "Mash", "WheatBrew" }
            },
            {
                Name = "Irish",
                ALC = 0.23,
                Modifiers = { "Irish" }
            },
            {
                Name = "Pink Spirit",
                ALC = 0.15,
                Modifiers = { "PinkSpirit" }
            },
            {
                Name = "Davy",
                ALC = 0.2,
                Modifiers = { "Davy" }
            },
            {
                Name = "Blossom",
                ALC = 0.3,
                Modifiers = { "Blossom" }
            },
            {
                Name = "Shine",
                ALC = 1,
                Modifiers = { "Shine" }
            },
            {
                Name = "Cold Strike",
                ALC = 0.2,
                Modifiers = { "Tete", "BlueCuracao" }
            },
            {
                Name = "Blue Lagoon",
                ALC = 0.1,
                RequiresShaker = true,
                Modifiers = { "Spirit", "BlueCuracao" }
            },
            {
                Name = "Golden Hour",
                ALC = 0.1,
                RequiresShaker = true,
                Modifiers = { "Spirit", "MangoPuree" }
            },
            {
                Name = "Parrot Puncher",
                ALC = 0.1,
                RequiresShaker = true,
                Modifiers = { "Spirit", "PineapplePuree" }
            },
            {
                Name = "Summer Cove",
                ALC = 0.1,
                RequiresShaker = true,
                Modifiers = { "Spirit", "PineapplePuree", "BlueCuracao" }
            },
            {
                Name = "Sweet Pearl",
                ALC = 0.1,
                Modifiers = { "Spirit", "CoconutSyrup" }
            },
            {
                Name = "Riptide",
                ALC = 0.1,
                Modifiers = { "Spirit", "BlueCuracao", "TonicWater" }
            },
            {
                Name = "Frutiger Aero",
                ALC = 0.1,
                Modifiers = {
                    "Spirit",
                    "BlueCuracao",
                    "Zest",
                    "TonicWater"
                }
            },
            {
                Name = "Yellow Sky",
                ALC = 0.1,
                RequiresShaker = true,
                Modifiers = { "Spirit", "SweetAndSour" }
            },
            {
                Name = "Founder",
                ALC = 0.1,
                Modifiers = { "Spirit", "SweetAndSour", "Zest" }
            },
            {
                Name = "Purple Dream",
                ALC = 0.15,
                RequiresShaker = true,
                Modifiers = { "PinkSpirit", "BlueCuracao" }
            },
            {
                Name = "The Blue Strike",
                ALC = 0.2,
                RequiresShaker = true,
                Modifiers = { "Davy", "BlueCuracao" }
            },
            {
                Name = "Seven Seas",
                ALC = 0.2,
                Modifiers = { "Davy", "BlueCuracao", "TonicWater" }
            },
            {
                Name = "Peg Leg",
                ALC = 0.2,
                RequiresShaker = true,
                Modifiers = { "Davy", "CoconutSyrup" }
            },
            {
                Name = "Paloma Punch",
                ALC = 0.2,
                RequiresShaker = true,
                Modifiers = { "Davy", "MangoPuree" }
            },
            {
                Name = "Palm Pete",
                ALC = 0.2,
                RequiresShaker = true,
                Modifiers = { "Davy", "PineapplePuree" }
            },
            {
                Name = "Pina Colada",
                ALC = 0.2,
                RequiresShaker = true,
                Modifiers = { "Davy", "PineapplePuree", "CoconutSyrup" }
            },
            {
                Name = "Spirit and Mash",
                ALC = 0.4,
                Modifiers = { "Spirit", "Mash" }
            },
            {
                Name = "Shark Attack",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "PinkSpirit", "Grenadine" }
            },
            {
                Name = "Sandcastle Slide",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "PinkSpirit", "MangoPuree" }
            },
            {
                Name = "Blush Mirage",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "PinkSpirit", "PineapplePuree" }
            },
            {
                Name = "Pearl Lay",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "PinkSpirit", "MangoPuree", "PineapplePuree" }
            },
            {
                Name = "Rising Sun",
                ALC = 0.35,
                RequiresShaker = true,
                Modifiers = { "Blossom", "Grenadine" }
            },
            {
                Name = "Cherry Blossom",
                ALC = 0.33,
                RequiresShaker = true,
                Modifiers = { "Blossom", "Grenadine", "Milk" }
            },
            {
                Name = "Bloody Mary",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "Mash", "Grenadine" }
            },
            {
                Name = "Six Seven",
                ALC = 0.2,
                Modifiers = { "PinkSpirit", "Davy" }
            },
            {
                Name = "Dreamsicle",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "Irish", "OrangeJuice" }
            },
            {
                Name = "Caesar",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "Spirit", "Grenadine" }
            },
            {
                Name = "Tokyo Sweet",
                ALC = 0.3,
                RequiresShaker = true,
                Modifiers = { "Blossom", "OrangeJuice" }
            },
            {
                Name = "Okinawa Rose",
                ALC = 0.3,
                RequiresShaker = true,
                Modifiers = { "Blossom", "OrangeJuice", "MangoPuree" }
            },
            {
                Name = "Kyoto Sour",
                ALC = 0.4,
                RequiresShaker = true,
                Modifiers = { "Blossom", "SweetAndSour" }
            },
            {
                Name = "The Light Plank",
                ALC = 0.6,
                Modifiers = { "Spirit", "Mash", "Davy" }
            },
            {
                Name = "The Plank",
                ALC = 1.2,
                Modifiers = { "Shine", "Spirit" }
            },
            {
                Name = "The Death Sentence",
                ALC = 2,
                Modifiers = { "Shine", "Spirit", "Irish" }
            },
            {
                Name = "A Step Further",
                ALC = 2.3,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "Blossom"
                }
            },
            {
                Name = "The Bite of 87",
                ALC = 20,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "Blossom",
                    "Davy"
                }
            },
            {
                Name = "Hidden Bliss",
                ALC = 0.24,
                Modifiers = { "PinkSpirit", "Zest" }
            },
            {
                Name = "Snake Venom",
                ALC = 2.2,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "Davy"
                }
            },
            {
                Name = "Night Fury",
                ALC = 2,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "CoffeeMaker"
                }
            },
            {
                Name = "Light Fury",
                ALC = 2,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "CoconutSyrup"
                }
            },
            {
                Name = "Moonbeam",
                ALC = 1.2,
                Modifiers = { "Shine", "Spirit", "BlueCuracao" }
            },
            {
                Name = "Ms Magic",
                ALC = 0.2,
                Modifiers = { "Spirit", "Zest" }
            },
            {
                Name = "Blue Magic",
                ALC = 0.23,
                Modifiers = { "Spirit", "Zest", "BlueCuracao" }
            },
            {
                Name = "Zesty",
                ALC = 0.45,
                Modifiers = { "Tete", "Zest" }
            },
            {
                Name = "Mango Mogger",
                ALC = 0.45,
                Modifiers = { "Tete", "MangoPuree" }
            },
            {
                Name = "Surf\'s Up",
                ALC = 0.45,
                Modifiers = { "Tete", "PineapplePuree" }
            },
            {
                Name = "Coco Tides",
                ALC = 0.45,
                Modifiers = { "Tete", "CoconutSyrup" }
            },
            {
                Name = "Zesty Blue",
                ALC = 0.45,
                Modifiers = { "Tete", "Zest", "BlueCuracao" }
            },
            {
                Name = "Zesty Red",
                ALC = 0.45,
                Modifiers = { "Tete", "Zest", "Grenadine" }
            },
            {
                Name = "Rifted Special",
                ALC = 0.4,
                Modifiers = { "Tete", "Zest", "OrangeJuice" }
            },
            {
                Name = "Blue Magic",
                ALC = 0.4,
                Modifiers = { "Spirit", "Zest", "BlueCuracao" }
            },
            {
                Name = "Ocean Tide",
                ALC = 0.45,
                Modifiers = { "Mash", "MangoPuree" }
            },
            {
                Name = "Dorian Rush",
                ALC = 0.45,
                Modifiers = { "Mash", "Zest" }
            },
            {
                Name = "Triple Bass",
                ALC = 0.75,
                Modifiers = { "Mash", "Zest", "Davy" }
            },
            {
                Name = "Whale Tone",
                ALC = 0,
                3,
                Modifiers = { "Spirit", "Zest", "CranberryJuice" }
            },
            {
                Name = "Bullesco",
                Special = "Bubble",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "WaterElement" }
            },
            {
                Name = "Engorgio",
                Special = "Size",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "MagicElement" }
            },
            {
                Name = "Pure Fire",
                Special = "Fire",
                ID = "Fire",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "FireElement" }
            },
            {
                Name = "Blessed Flame",
                Special = "Soul",
                ID = "BlessedFlame",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "FireElement", "ZelgansOffering" }
            },
            {
                Name = "Cursed Flame",
                Special = "Decouple",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "FireElement", "ZelgansOffering", "UnstableReactor" }
            },
            {
                Name = "Protego Diabolica",
                Special = "ProtegoDiabolica",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "FireElement", "ZelgansOffering", "StableReactor" }
            },
            {
                Name = "Momentum",
                Special = "Speed",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "EnergyElement" }
            },
            {
                Name = "Ascension",
                Special = "Jump",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "EnergyElement", "MagicElement" }
            },
            {
                Name = "Seraphic",
                ID = "Seraphic",
                Special = "Bloop",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = { "EnergyElement", "MagicElement", "FireElement" }
            },
            {
                Name = "Unstable Magic Base",
                Special = "Decouple",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "EnergyElement",
                    "MagicElement",
                    "FireElement",
                    "UnstableReactor"
                }
            },
            {
                Name = "Stable Magic Base",
                Special = "Bloop",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "EnergyElement",
                    "MagicElement",
                    "FireElement",
                    "StableReactor"
                }
            },
            {
                Name = "the power of D E U S",
                Special = "HeavenBlaster",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "EnergyElement",
                    "MagicElement",
                    "FireElement",
                    "StableReactor",
                    "Deus"
                }
            },
            {
                Name = "Kraken\'s Revenge",
                Special = "WaterPortal",
                Transparency = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "EnergyElement",
                    "MagicElement",
                    "FireElement",
                    "StableReactor",
                    "WaterElement"
                }
            },
            {
                Name = "Demon\'s blood",
                Special = "Blood",
                Transparency = 0,
                ALC = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "FireElement"
                }
            },
            {
                Name = "Aurize",
                Special = "Soul",
                Transparency = 0,
                ALC = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "FireElement",
                    "MagicElement"
                }
            },
            {
                Name = "Zelgan\'s Final Step",
                Special = "Soul",
                Transparency = 0,
                ALC = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "FireElement",
                    "MagicElement",
                    "EnergyElement"
                }
            },
            {
                Name = "Zelgan\'s Summoning",
                Special = "Gate",
                Transparency = 0,
                ALC = 0,
                Material = Enum.Material.Neon,
                Modifiers = {
                    "Shine",
                    "Spirit",
                    "Irish",
                    "FireElement",
                    "MagicElement",
                    "EnergyElement",
                    "ZelgansOffering"
                }
            },
            {
                Name = "Driver",
                ALC = 0.2,
                RequiresShaker = true,
                Modifiers = { "Spirit", "OrangeJuice" }
            },
            {
                Name = "Bloxy Heaven",
                ALC = 0.2,
                Modifiers = { "Spirit", "Cola" }
            },
            {
                Name = "Mash Sour",
                ALC = 0.23,
                Modifiers = { "Mash", "OrangeJuice" }
            },
            {
                Name = "Mash Cola",
                ALC = 0.2,
                Modifiers = { "Mash", "Cola" }
            },
            {
                Name = "Florida Sweet",
                ALC = 0.2,
                Modifiers = { "Davy", "OrangeJuice" }
            },
            {
                Name = "The Buccaneer",
                ALC = 0.2,
                Modifiers = { "Davy", "Cola" }
            },
            {
                Name = "The Irish",
                ALC = 0.3,
                Modifiers = { "Irish", "Cola" }
            },
            {
                Name = "Water",
                ALC = -0.1,
                Modifiers = { "Water" }
            }
        }
    }
};
