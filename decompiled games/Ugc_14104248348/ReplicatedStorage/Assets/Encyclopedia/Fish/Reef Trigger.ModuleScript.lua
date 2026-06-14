-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Reef Trigger
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "reefTrigger",
    Name = "Reef Triggerfish",
    Family = "Balistidae",
    Diet = "Shrimp",
    Size = "Up to 30 cm",
    Depths = "10-20m (33-65ft)",
    DoNotSave = true,
    Aliases = { "Rhinecanthus rectangulus" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels.ReefTrigger,
    Icon = {
        ImageID = "rbxassetid://12520191895",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "Tropical Indo-Pacific"
        }
    },
    Animations = {
        Idle = "rbxassetid://000000000",
        Swim = "rbxassetid://12493086622"
    },
    Facts = { "Reef triggerfish usually inhabit rocky parts of reefs, where they can be seen actively swimming around in search of food. These fish are very iconic - so iconic, in fact, that the species has become the state fish of Hawaii.", "These fish are voracious and opportunistic feeders, eating crustaceans, mollusks, worms, sponges, echinoderms, algae, other fish, detritus, and eggs, among other things. Instead of thin, blade-like teeth used for piercing, reef triggerfish have sturdy, blocky teeth used for crushing the shells of many of their invertebrate prey items.", "The fact that reef triggerfish are almost always seen alone is no coincidence - these fish are fiercely territorial towards their own kind, as well as other fish that happen to get too close, especially during nesting season. As such, the powerful jaws of a triggerfish should never be underestimated." }
};
