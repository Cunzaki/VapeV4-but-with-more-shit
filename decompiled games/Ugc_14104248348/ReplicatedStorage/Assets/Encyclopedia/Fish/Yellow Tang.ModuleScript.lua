-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Yellow Tang
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "yellowTang",
    Name = "Yellow Tang",
    Family = "Acanthuridae",
    Diet = "Algae",
    Size = "Up to 20 cm",
    Depths = "2-46m (6-148ft)  ",
    DoNotSave = true,
    Aliases = { "Zebrasoma flavescens" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels["Yellow Tang"],
    Icon = {
        ImageID = "rbxassetid://12492000453",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "Tropical Pacific coral reefs"
        }
    },
    Animations = {
        Idle = "rbxassetid://000000000",
        Swim = "rbxassetid://14341173437"
    },
    Facts = { "These brightly coloured reef-dwelling fish are extremely popular and commonly seen in the aquarium trade. Although Hawaii was and still is a major exporter of this species for the trade, captive-bred yellow tangs are becoming more popular as time goes on.", "The yellow tang shares the genus Zebrasoma with multiple other species of surgeonfish, although it is one of the smallest members of that genus. Some of the yellow tang’s relatives can grow to around twice its size!", "The name of the genus that the yellow tang belongs to, Zebrasoma, means “body like a zebra” and references the vertical stripes that some of the yellow tang’s relatives display. Yellow tangs also have stripes, although they are most prominent on juvenile specimens and fade as the fish gets older." }
};
