-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.__template
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "short_name_for_fish",
    Name = "TEMPLATE",
    Family = "FAMIY_NAME",
    Diet = "DIET_NAME",
    Size = "SIZE_HERE",
    Depths = "DEPTH_HERE",
    Aliases = { "SCIENTFIC_NAME_HERE" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels.FISH_NAME_IN_FISH_MODELS,
    Icon = {
        ImageID = "rbxassetid://00000000000",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "LOCATION_NAME"
        }
    },
    Animations = {
        Idle = "rbxassetid://000000000",
        Swim = "rbxassetid://000000000"
    },
    Facts = { "FACT_ONE_HERE", "FACT_TWO_HERE", "FACT_THREE_HERE" }
};
