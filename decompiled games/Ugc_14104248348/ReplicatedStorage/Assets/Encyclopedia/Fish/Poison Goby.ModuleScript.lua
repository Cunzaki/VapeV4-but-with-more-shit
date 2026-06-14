-- Decompiled from: ReplicatedStorage.Assets.Encyclopedia.Fish.Poison Goby
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    _id = "poisonGoby",
    Name = "Poison Goby",
    Family = "Gobiidae",
    Diet = "Plankton",
    Size = "Up to 6 cm",
    Depths = "0-20m (0-65ft)",
    Aliases = { "Gobiodon citrinus" },
    Model = game:GetService("ReplicatedStorage").Assets.FishModels.PoisonGoby,
    Icon = {
        ImageID = "rbxassetid://12491999081",
        Scale = UDim2.fromScale(0.13, 0.1),
        Position = UDim2.fromScale(0, 0)
    },
    Locations = {
        {
            PlaceID = 12242092833,
            LocationName = "Indo-Pacific reefs"
        }
    },
    Animations = {
        Idle = "rbxassetid://12458444629",
        Swim = "rbxassetid://000000000"
    },
    Facts = { "Also known as the lemon goby, the poison goby’s two most common names in the English language refer to its yellow colouration and its ability to produce toxic mucus. This trait likely serves as a defence mechanism, making the fish a generally undesirable target for predators.", "Poison gobies are typically seen hiding among the branches of reef-building corals, making them a commensal species. Branching corals are an important habitat for not just these fish but also others such as hawkfish and juvenile dascyllus, although this species is unusual in that it is rarely seen anywhere else.", "While different from many gobies which dwell in burrows on the seafloor, the poison goby’s preferred habitat is not that unusual when it comes to its close relatives. Many other species in the genus Gobiodon (and other similar genera), which are often collectively referred to as “coral gobies” or “clown gobies”, behave similarly, although the poison goby is unusual in that it is larger than many of them." }
};
