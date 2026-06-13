-- Decompiled from: ReplicatedStorage.Config.Shared.LoftShopItems
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Akari1A = {
        Price = 50,
        Placement = "Akari1A",
        Name = "Akari 1A",
        Description = "A smaller lantern-style lamp.",
        MemoryUsage = 2
    },
    AkariSnowman = {
        Price = 50,
        Placement = "AkariSnowman",
        Name = "Akari Snowman",
        Description = "A lantern-style lamp.",
        MemoryUsage = 2
    },
    ArcLamp = {
        Price = 50,
        Placement = "ArcLamp",
        Name = "Arc Lamp",
        Description = "A large curved standing lamp.",
        MemoryUsage = 2
    },
    BarcelonaChair = {
        Price = 50,
        Placement = "Barcelona Chair",
        Name = "Barcelona Chair",
        Description = "A 1-seater Barcelona chair.",
        MemoryUsage = 2
    },
    BlackSectional = {
        Price = 50,
        Placement = "BlackSectional",
        Name = "Black Sectional",
        Description = "A large 5-seater sectional.",
        MemoryUsage = 2
    },
    Couch = {
        Price = 50,
        Placement = "Couch",
        Name = "Couch",
        Description = "A 3-seater traditional couch with a pillow.",
        MemoryUsage = 2
    },
    CouchChair = {
        Price = 50,
        Placement = "CouchChair",
        Name = "Couch Chair",
        Description = "A 1-seater modern blue barrel chair.",
        MemoryUsage = 2
    },
    EamesChair = {
        Price = 50,
        Placement = "EamesChair",
        Name = "Eames Chair",
        Description = "A bespoke 1-seater lounge chair with a custom seat animation.",
        MemoryUsage = 2
    },
    EamesOttoman = {
        Price = 50,
        Placement = "EamesOttoman",
        Name = "Eames Ottoman",
        Description = "An ottoman to match the bespoke Eames lounge chair.",
        MemoryUsage = 2
    },
    GuzLamp = {
        Price = 50,
        Placement = "Guzlamp",
        Name = "Guz Lamp",
        Description = "Mary had a little lamp..",
        MemoryUsage = 2
    },
    MediaConsole = {
        Price = 50,
        Placement = "MediaConsole",
        Name = "Media Console",
        Description = "A decorative cabinet that could contribute greatly to your aesthetic.",
        MemoryUsage = 2
    },
    LongTable = {
        Price = 50,
        Placement = "LongTable",
        Name = "Long Table",
        Description = "A simple table. What more did you expect?",
        MemoryUsage = 2
    },
    ModernSectional = {
        Price = 50,
        Placement = "ModernSectional",
        Name = "Modern Sectional",
        Description = "A whopping 12-seater couch. You ever host big parties?",
        MemoryUsage = 2
    },
    NestingTable = {
        Price = 50,
        Placement = "NestingTable",
        Name = "Nesting Table",
        Description = "A small table for your house keys. If you had house keys.",
        MemoryUsage = 2
    },
    NoguchiTable = {
        Price = 50,
        Placement = "NoguchiTable",
        Name = "Noguchi Table",
        Description = "A rather unique glass table.",
        MemoryUsage = 2
    },
    TableSet = {
        Price = 50,
        Placement = "TableSet",
        Name = "Table Set",
        Description = "A round table. Why not host a round table here?",
        MemoryUsage = 2
    },
    TeddyCouch = {
        Price = 50,
        Placement = "TeddyCouch",
        Name = "Teddy Couch",
        Description = "A distinct green 2-seater couch.",
        MemoryUsage = 2
    },
    WallLamp = {
        Price = 50,
        Placement = "WallLamp",
        Name = "Wall Lamp",
        Description = "If you\'re not a fan of standing lamps..",
        MemoryUsage = 2,
        Attributes = {
            PlaceGroup = "ApartmentWall"
        }
    },
    WassilyTable = {
        Price = 50,
        Placement = "WassilyTable",
        Name = "Wassily Table",
        Description = "A matching table for the Wassily chair.",
        MemoryUsage = 2
    },
    Minibar = {
        Price = 6000,
        Placement = "Minibar",
        Name = "Minibar",
        Description = "A minibar for drinks and snacks.",
        MemoryUsage = 10,
        FreeGain = 1
    },
    SmallFramelessPainting = {
        Price = 100,
        Placement = "SmallFramelessPainting",
        Name = "Customizeable Frameless Painting ( Small )",
        Description = "A painting you can personalize with your own images.",
        MemoryUsage = 2,
        Attributes = {
            PlaceGroup = "ApartmentWall",
            PlacementEvent = "CustomPainting,AnchorLoft"
        },
        Offset = CFrame.Angles(0, 4.71238898038469, 0),
        Tags = { "CustomPainting" }
    },
    Painting = {
        Price = 100,
        Placement = "Painting",
        Name = "Customizeable Painting",
        Description = "A painting you can personalize with your own images.",
        MemoryUsage = 2,
        Attributes = {
            PlaceGroup = "ApartmentWall",
            PlacementEvent = "CustomPainting,AnchorLoft"
        },
        Offset = CFrame.Angles(0, 4.71238898038469, 0),
        Tags = { "CustomPainting" }
    },
    TwoPersonCouch = {
        Price = 50,
        Placement = "TwoPersonCouch",
        Name = "Two Person Couch",
        Description = "A couch for two people.",
        MemoryUsage = 2,
        Offset = CFrame.Angles(-0.17453292519943295, 3.141592653589793, 0)
    },
    Ottoman1 = {
        Price = 25,
        Placement = "Ottoman1",
        Name = "Ottoman",
        Description = "A cushioned footrest."
    },
    BobaStand = {
        NotPurchasable = true,
        MemoryUsage = 10,
        Price = 2,
        Placement = "BobaCounter",
        Name = "Boba Station",
        Description = "Your very own private Boba Stand!",
        Offset = CFrame.Angles(0, 3.141592653589793, 0),
        Tags = { "InteractBlocker" }
    },
    RojuFridge = {
        NotPurchasable = true,
        MemoryUsage = 3,
        Price = 2,
        Placement = "RojuFridge",
        Name = "Roju Fridge",
        Description = "A fridge full of roju.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0),
        Tags = { "InteractBlocker" }
    },
    Konpieto = {
        NotPurchasable = true,
        Price = 2,
        Placement = "Konpieto",
        Name = "Konpieto Bowl",
        Description = "A yummy bowl of Konpieto."
    },
    Nightstand = {
        Price = 25,
        Placement = "Nightstand",
        Name = "Nightstand",
        Description = "The nightest of stands."
    },
    AnchorBed = {
        Price = 100,
        Placement = "AnchorBed",
        Name = "Anchor Bed",
        Description = "The bed that your mom sits upright in.",
        MemoryUsage = 5,
        Offset = CFrame.Angles(0, 4.71238898038469, 0)
    },
    Cloche = {
        Price = 10,
        Placement = "Cloche",
        Name = "Cloche",
        Description = "A glass bell used to cover food or plants."
    },
    Plant1 = {
        Price = 20,
        Placement = "Plant1",
        Name = "Plant (Type #1)",
        Description = "Cool lil plant."
    },
    Plant2 = {
        Price = 20,
        Placement = "Plant2",
        Name = "Plant (Type #2)",
        Description = "Cool lil plant2."
    },
    Lamp = {
        Price = 20,
        Placement = "Lamp",
        Name = "Lamp",
        Description = "lamplamplamplamp"
    },
    StandingLamp = {
        Price = 50,
        Placement = "StandingLamp",
        Name = "Standing Lamp",
        Description = "Lamp but standing."
    },
    Trophy = {
        Price = 5,
        Placement = "Trophy",
        Name = "Trophy (Type #1)",
        Description = "You deserve this.. surely.."
    },
    TVStand = {
        Price = 30,
        Placement = "TVStand",
        Name = "TV Stand",
        Description = "TV not included."
    },
    Table = {
        Price = 20,
        Placement = "Table",
        Name = "Table (Type #1)",
        Description = "A regular table."
    },
    Chair = {
        Price = 20,
        Placement = "Chair",
        Name = "Char (Type #1)",
        Description = "Sit yo *** down!"
    },
    Rug1 = {
        Price = 10,
        Placement = "Rug1",
        Name = "Rug (Type #1)",
        Description = "Just a rug.",
        Offset = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
    },
    Rug2 = {
        Price = 10,
        Placement = "Rug2",
        Name = "Rug (Type #2)",
        Description = "Just a rug but 2.",
        Offset = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
    },
    Rug3 = {
        Price = 10,
        Placement = "Rug3",
        Name = "Rug (Type #3)",
        Description = "Just a rug but 3.",
        Offset = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
    },
    Bookcase = {
        Price = 35,
        Placement = "Bookcase",
        Name = "Tall Bookcase",
        Description = "A tall bookcase for storing books.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    CatBed = {
        Price = 20,
        Placement = "Catbed",
        Name = "Cat Bed (Type #1)",
        Description = "meow. lolz",
        Offset = CFrame.Angles(1.5707963267948966, 0, 0)
    },
    CounterTop = {
        Price = 30,
        Placement = "Countertop",
        Name = "Countertop (Type #1)",
        Description = "A countertop for placing things.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    Monstera = {
        Price = 25,
        Placement = "MonsteraPlant",
        Name = "Monstera Plant",
        Description = "Bryan\'s favorite plant.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    Regrigerator = {
        Price = 30,
        Placement = "Refrigerator",
        Name = "Refrigerator",
        Description = "Keeps things cold.",
        MemoryUsage = 2,
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    Sink = {
        Price = 35,
        Placement = "Sink",
        Name = "Sink",
        Description = "Wash your hands in it.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    Sofa = {
        Price = 20,
        Placement = "Sofa",
        Name = "Single Sofa",
        Description = "Sofa for one.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    Stove = {
        Price = 30,
        Placement = "Stove",
        Name = "Stove",
        Description = "If you hungry, COOK SOMETHING.",
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    Turntable = {
        Price = 50,
        Placement = "Turntable",
        Name = "Turntable",
        Description = "Play a jam.",
        MemoryUsage = 3,
        Offset = CFrame.Angles(6.283185307179586, 0, 0)
    },
    WassilyChair = {
        Price = 200,
        Placement = "WassilyChair",
        Name = "Wassily Chair",
        Description = "An intricate piece of furniture inspired by a bike frame.",
        MemoryUsage = 3,
        Offset = CFrame.Angles(0, -135, 0)
    },
    TV = {
        Price = 300,
        Placement = "TV",
        Name = "Television",
        Description = "Watch a movie with friends!",
        Attributes = {
            PlaceGroup = "ApartmentWall"
        },
        Offset = CFrame.Angles(0, -1.5707963267948966, 0)
    }
};
