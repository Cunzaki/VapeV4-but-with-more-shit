-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Humpback Whale
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "humpbackWhale",
    Name = "Humpback Whale",
    Family = "Balaenopteridae",
    Diet = "Fish and krill",
    Size = "Up to 1800 cm (59.1 ft)",
    Depths = "0-616 m (0-2021 ft)",
    Aliases = { "Megaptera novaeangliae" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels["Humpback Whale"],
    Icon = {
        ImageID = "rbxassetid://12635896817",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "Worldwide, from tropical to polar regions"
        }
    },
    Animations = {
        Idle = "rbxassetid://000000000",
        Swim = "rbxassetid://000000000"
    },
    Facts = { "These enormous marine mammals are known for their complex vocalisations, also called songs. Male humpback whales use these songs in the breeding season, likely to attract mates.", "Each humpback whale has unique markings on their flukes. This, coupled with the whales\' diving behaviour that often clearly displays the fluke, aids scientists in identifying individual whales. Individual humpbacks often are given descriptive names for identification purposes. ", "These whales are well documented using bubbles to corral a school of fish into a small area for feeding. This behaviour is called bubble netting, and is documented in a select few populations of humpbacks." }
};
