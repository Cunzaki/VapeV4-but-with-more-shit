-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.None.Settings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Timeout = 3,
    Cooldown = 3,
    EnterType = "Intermission",
    IntermissionTime = 15,
    Welcome = {
        Video = "rbxassetid://88112938255635",
        Description = "Welcome to None! \n\nMatch the color or number to discard your hand. <b>CLICK</b> a card to play it! \n\nBe the first to clear your hand to win!",
        Difficulty = 3
    },
    Deck = {},
    Colors = {
        ["0"] = Color3.new(0.2, 0.2, 0.2),
        ["1"] = Color3.fromRGB(76, 165, 227),
        ["2"] = Color3.fromRGB(92, 173, 87),
        ["3"] = Color3.fromRGB(212, 57, 51),
        ["4"] = Color3.fromRGB(239, 176, 85)
    },
    Cards = {
        {
            Id = "1",
            Image = "rbxassetid://127970347267192",
            Colorless = false
        },
        {
            Id = "2",
            Image = "rbxassetid://85276435236427",
            Colorless = false
        },
        {
            Id = "3",
            Image = "rbxassetid://112428278034072",
            Colorless = false
        },
        {
            Id = "4",
            Image = "rbxassetid://83248152208895",
            Colorless = false
        },
        {
            Id = "5",
            Image = "rbxassetid://119961723378670",
            Colorless = false
        },
        {
            Id = "6",
            Image = "rbxassetid://100748423294937",
            Colorless = false
        },
        {
            Id = "7",
            Image = "rbxassetid://136149347649912",
            Colorless = false
        },
        {
            Id = "9",
            Image = "rbxassetid://133770777622048",
            Colorless = false
        },
        {
            Id = "2P",
            Image = "rbxassetid://84069058973004",
            Colorless = false
        },
        {
            Id = "R",
            Image = "rbxassetid://99764144558520",
            Colorless = false
        },
        {
            Id = "B",
            Image = "rbxassetid://108977129219969",
            Colorless = false
        },
        {
            Id = "4P",
            Image = "rbxassetid://136199789584072",
            Colorless = true
        },
        {
            Id = "C",
            Image = "rbxassetid://138589075315894",
            Colorless = true
        }
    },
    Players = {
        Min = 2,
        Max = 4
    }
};
