-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Giant Clam
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "giantClam",
    Name = "Giant Clam",
    Family = "Cardiidae",
    Diet = "Plankton",
    Size = "Up to 137 cm",
    Depths = "0-35m (0-115ft)",
    Aliases = { "Tridacna gigas" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels["Giant Clam"],
    Icon = {
        ImageID = "rbxassetid://12635897006",
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
        Idle = "rbxassetid://12493021531",
        Swim = "rbxassetid://000000000"
    },
    Facts = { "Weighing up to more than 200 kg, these massive mollusks are among the largest clams in the world. There are multiple members of the genus Tridacna, many growing to unusually large sizes, but this species is the largest one known.", "Adult giant clams are sessile, meaning they do not move around and stay firmly anchored to one place. However, young giant clams are planktonic, drifting around in the current until they find somewhere where they can settle and grow.", "Although they are able to feed on plankton by filtering it out of the water, plankton is definitely not the only source of energy available to giant clams. In a similar fashion to corals, they are known to have symbiotic algae living within their tissues, which carry out photosynthesis and allow the clams to grow to large sizes in areas where sunlight is readily available." }
};
