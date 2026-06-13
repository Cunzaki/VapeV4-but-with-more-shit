-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Delicate Round Herring
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "roundHerring",
    Name = "Delicate Round Herring",
    Family = "Spratelloididae",
    Diet = "Plankton",
    Size = "Up to 7 cm (2.8 in)",
    Depths = "0-50 m (0-164 ft)",
    Aliases = { "Spratelloides delicatulus" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels["Delicate Round Herring"],
    Icon = {
        ImageID = "rbxassetid://12635898184",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "Indo-Pacific"
        }
    },
    Animations = {
        Idle = "rbxassetid://000000000",
        Swim = "rbxassetid://12635962828"
    },
    Facts = { "These small fish are often seen forming large schools in coastal waters near reefs, islands, and lagoons. They are generally found in clear water, seemingly avoiding areas that are excessively murky.", "Delicate round herrings feed near the water’s surface, eating plankton from near the top of the water column. As such, they are not found near the seafloor in deeper regions, although they may be seen near the seafloor if the water that they are in is especially shallow.", "The delicate round herring is an important prey item for many larger predatory creatures within its range. As such, it is frequently used as bait by humans fishing for tuna, and it is also sometimes sold as food." }
};
