-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Green Sea Turtle
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "greenseaTurtle",
    Name = "Green Sea Turtle",
    Family = "Cheloniidae",
    Diet = "Seagrass",
    Size = "Up to 150 cm",
    Depths = "0-200m (0-656ft)",
    Aliases = { "Chelonia mydas" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels["Green Sea Turtle"],
    Icon = {
        ImageID = "rbxassetid://12675281386",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "Warm seas worldwide"
        }
    },
    Animations = {
        Idle = "rbxassetid://000000000",
        Swim = "rbxassetid://14632286411"
    },
    Facts = { "Despite their name, green sea turtles show a variety of colours on the top of their shell, or carapace, including brown, olive, or even black. The “green” part of the name comes from the colour of the skin under the shell of the animal, which develops as the animal ages.", "Green sea turtles go through a diet shift as they grow, with juveniles being omnivores, feeding on easy to access planktonic marine life, such as jellyfish. When they become adults, they are the most herbivorous of the sea turtles, feeding on algae and seagrass.", "Like several species of reptiles, the outcome of whether sea turtle eggs hatch male or female depends on incubation temperature. Those that are incubated below 27.7 C (81.8 F) will be male, and those that incubate above 31 C (88.8 F) will be female. A temperature in this range will produce a balanced amount of each." }
};
