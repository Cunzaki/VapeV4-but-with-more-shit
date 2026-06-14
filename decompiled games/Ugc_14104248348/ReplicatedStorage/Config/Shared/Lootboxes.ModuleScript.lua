-- Decompiled from: ReplicatedStorage.Config.Shared.Lootboxes
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    AquariumPt1 = {
        Name = "Aquarium Lootbox!",
        AllowClientRequestPurchase = true,
        AllowUnrestrictedPriceType = false,
        PolicyServiceCompliant = true,
        Items = {
            { "Gear.AnchovyPlushie", 55 },
            { "Gear.GirabaldiPlush", 30 },
            { "Gear.SeaLemonPlushie", 20 },
            { "Gear.SeaBunnyPlush", 10 },
            { "Gear.SharkPlush", 8 },
            { "CosmeticFightTool.OctoSword", 6 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 250
        }
    },
    LNW2026 = {
        Name = "Lunear New Year Event Lootbox",
        AllowClientRequestPurchase = false,
        AllowUnrestrictedPriceType = true,
        PolicyServiceCompliant = true,
        Items = {
            { "Gear.BluePaperFan", 55 },
            { "Gear.RedPaperFan", 55 },
            { "ConsumeGear.CheongsachorongBalloon", 55 },
            { "ConsumeGear.HorseLanternBalloon", 55 },
            { "ConsumeGear.BlueFirecracker", 40 },
            { "ConsumeGear.PinkFirecracker", 40 },
            { "ConsumeGear.RedFirecracker", 40 },
            { "CosmeticGlass.LNY26FloatingLantern", 30 },
            { "Gear.PolarBear", 20 },
            { "Gear.StarCat", 20 },
            { "Gear.HorsePlush", 30 },
            { "Gear.PandaPlush", 30 },
            { "Gear.TigerPlush", 30 },
            { "Gear.RoyalHorseFan", 20 },
            { "Gear.LanternTipJar", 20 },
            { "Gear.DragonStreamer", 7 },
            { "Gear.DragonCannon", 6 },
            { "Emote.FanDance", 5 },
            { "CosmeticFightTool.TangPa", 4 },
            { "CosmeticFightTool.FutaoSwords", 0.1 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 250
        },
        UnrestrictedCost = {
            Currency = "GatchaKeys",
            Amount = 1
        }
    },
    LNW2025Rewind = {
        Name = "LNW2025 Rewind",
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = true,
        Items = {
            { "CosmeticGlass.LNY25Manley", 75 },
            { "CosmeticFancyGlass.LNY25Lantern", 60 },
            { "CosmeticSmallGlass.LNY25Lantern", 60 },
            { "CosmeticGlass.LNY25Ceramic", 30 },
            { "CosmeticShotGlass.LNY25Ceramic", 30 },
            { "CosmeticSmallGlass.LNY25Ceramic", 30 },
            { "Gear.SnakeStaff", 25 },
            { "CosmeticGlass.LNWGoldFoil", 20 },
            { "CosmeticShotGlass.LNWGoldFoil", 20 },
            { "CosmeticSmallGlass.LNWGoldFoil", 20 },
            { "CosmeticFancyGlass.Goblet", 15 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 2500
        }
    },
    Christmas2025 = {
        Name = "Christmas Event Lootbox!",
        AllowClientRequestPurchase = false,
        AllowUnrestrictedPriceType = true,
        PolicyServiceCompliant = true,
        Items = {
            { "Gear.SantaTipSack", 300 },
            { "CosmeticSmallGlass.SnowmanHeadGlass", 300 },
            { "Gear.ElfPlushie", 300 },
            { "CosmeticFancyGlass.GiftWrapped", 100 },
            { "Gear.MistleToeBear", 100 },
            { "Gear.NarwhalPlush", 100 },
            { "Gear.BellKittyBlack", 85 },
            { "Gear.BellKittyWhite", 85 },
            { "Gear.SkellingtonPlushie", 85 },
            { "Gear.CandyCaneBunny", 85 },
            { "CosmeticStoutGlass.StumpMug", 85 },
            { "CosmeticSmallGlass.HolidayCola", 50 },
            { "Gear.SantasGiftSack", 50 },
            { "CosmeticStoutGlass.ChimneyMug", 50 },
            { "Gear.Snowglobe", 50 },
            { "Gear.FriendSnowglobe", 30 },
            { "CosmeticFightTool.PermaFrostAxe", 10 },
            { "Gear.RedRyder", 5 },
            { "Gear.ChristmasMusket", 3 },
            { "Gear.SnowLauncher", 2 },
            { "Gear.DecoySnowman", 1 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 250
        },
        UnrestrictedCost = {
            Currency = "GatchaKeys",
            Amount = 1
        },
        PityCosts = {
            Rare = {
                Uncommon = 5
            },
            Epic = {
                Rare = 5
            },
            Legendary = {
                Epic = 5
            }
        }
    },
    Halloween2025 = {
        Name = "Halloween Event Lootbox!",
        AllowClientRequestPurchase = false,
        AllowUnrestrictedPriceType = true,
        PolicyServiceCompliant = true,
        Items = {
            { "ConsumeGear.BooBalloon", 800 },
            { "ConsumeGear.MonsterMashPotion", 800 },
            { "Gear.ZombieCatPlushie", 600 },
            { "Gear.SpookingtonFan", 600 },
            { "Gear.MummyPlushie", 600 },
            { "Gear.VampireDuckPlush", 600 },
            { "Gear.GhostPlush", 600 },
            { "Gear.HeadlessHorselessHorsemanPlushie", 600 },
            { "CosmeticFancyGlass.UraniumFancy", 600 },
            { "CosmeticGlass.UraniumTall", 600 },
            { "CosmeticSmallGlass.BloodyBeaker", 600 },
            { "Gear.EepyBat", 600 },
            { "Gear.ZelganPlush", 300 },
            { "CosmeticShotGlass.ThumbShot", 300 },
            { "CosmeticStoutGlass.FreakMug", 300 },
            { "CosmeticSmallGlass.PoisonApple", 300 },
            { "CosmeticShotGlass.CoffinShot", 300 },
            { "CosmeticGlass.JackOcup", 300 },
            { "CosmeticGlass.TombStone", 300 },
            { "CosmeticSmallGlass.ClownCup", 300 },
            { "CosmeticFancyGlass.CrowGraveFancy", 300 },
            { "CosmeticShotGlass.CandyCornShot", 300 },
            { "CosmeticSmallGlass.Geoff", 300 },
            { "Gear.SkeletonPlush", 300 },
            { "CosmeticFancyGlass.TheWatcher", 200 },
            { "CosmeticStoutGlass.GothicMug", 200 },
            { "CosmeticVineGlass.PurpleGoblet", 200 },
            { "Gear.VoodooDoll", 150 },
            { "CosmeticFightTool.PumpkinMace", 100 },
            { "CosmeticFightTool.SlasherKnife", 100 },
            { "CosmeticFightTool.Mace", 100 },
            { "CosmeticFancyGlass.SpiderGlass", 100 },
            { "CosmeticSmallGlass.ZombieGlass", 100 },
            { "CosmeticStoutGlass.SpiderMug", 80 },
            { "CosmeticSmallGlass.JackOKitty", 40 },
            { "Gear.HalloweenMusket", 40 },
            { "CosmeticSmallGlass.CauldronGlass", 20 },
            { "Gear.WitchesBroom", 20 },
            { "CosmeticFightTool.Chainsaw", 18 },
            { "Gear.GhostKittyStaff", 8 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 250
        },
        UnrestrictedCost = {
            Currency = "Holiday",
            Amount = 250
        },
        PityCosts = {
            Rare = {
                Uncommon = 5
            },
            Epic = {
                Rare = 5
            },
            Legendary = {
                Epic = 5
            }
        }
    },
    ["2ndAnniversary"] = {
        Name = "2nd Anniversary Event Lootbox!",
        AllowClientRequestPurchase = false,
        AllowUnrestrictedPriceType = true,
        PolicyServiceCompliant = true,
        Items = {
            { "CosmeticFightTool.AnniverserySword", 95 },
            { "Gear.GoldenHoverboard", 110 },
            { "Gear.FettiLauncher", 240 },
            { "CosmeticSmallGlass.Annv24AstronautGlass", 1300 },
            { "CosmeticFightTool.AnniverseryGloves", 1500 },
            { "CosmeticFightTool.AnniverseryBat", 1500 },
            { "Gear.MasqueradeCat", 2000 },
            { "Gear.MasqueradeFeather", 2000 },
            { "Gear.MasqueradeBronze", 2000 },
            { "Gear.GoldenButtersPlushie", 3000 },
            { "Emote.Slap", 3900 },
            { "Emote.StreamerDance", 3900 },
            { "CosmeticStoutGlass.BarrelMug", 4000 },
            { "CosmeticStoutGlass.TwoYearMug", 4000 },
            { "CosmeticSmallGlass.GoldDrop", 4000 },
            { "CosmeticSmallGlass.ANNV25BucketCup", 4000 },
            { "CosmeticShotGlass.LeaningShotPiza", 4000 },
            { "CosmeticShotGlass.CupcakeShot", 4000 },
            { "CosmeticFancyGlass.RoyalFancy", 4000 },
            { "CosmeticVineGlass.RoyalVine", 4000 },
            { "Gear.ANN2InnerpolyPlushie", 6000 },
            { "Gear.RiftRaftPlush", 6000 },
            { "Gear.BannanzaPlush", 6000 },
            { "Gear.BryanPlush", 6000 },
            { "Gear.ZowiePlush", 6000 },
            { "Gear.SharkingPlush", 6000 },
            { "Gear.IntyPlush", 6000 },
            { "Gear.MattPlush", 6000 },
            { "Gear.WhimPlush", 6000 },
            { "Gear.2HeptPlush", 6000 },
            { "Gear.MrFox", 7000 },
            { "Gear.MonsterraPlushie", 7000 },
            { "Gear.BottlePlushie", 7000 },
            { "Gear.FerretPlush", 7000 },
            { "CosmeticGlass.2ndAnnGlass", 8500 },
            { "CosmeticSmallGlass.GoldDazzle", 8500 },
            { "CosmeticShotGlass.GoldSpin", 8500 },
            { "CosmeticStoutGlass.HornMug", 8500 },
            { "ConsumeGear.AnniversaryBalloon", 9000 },
            { "ConsumeGear.ConfettiPopper", 9000 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 250
        },
        UnrestrictedCost = {
            Currency = "Holiday",
            Amount = 250
        }
    },
    JulyFourth2024Rewind = {
        Name = "July Fourth 2024 Rewind",
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = true,
        Items = {
            { "Gear.USAFlag", 150 },
            { "Gear.USAPaperFan", 90 },
            { "Gear.BurgerPlushie", 60 },
            { "Gear.HotdogPlushie", 60 },
            { "Gear.EaglePlushie", 40 },
            { "Gear.PatrioticPlushie", 20 },
            { "Emote.Salute", 20 },
            { "CosmeticSmallGlass.BaldEagle", 20 },
            { "CosmeticFancyGlass.Torch", 20 },
            { "CosmeticSmallGlass.AmericaCup", 20 },
            { "Gear.Musket", 10 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 500
        }
    },
    LNW2024Rewind = {
        Name = "LNW2024 Rewind",
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = true,
        Items = {
            { "Gear.RedSilkFan", 75 },
            { "Gear.CalicoBunny", 60 },
            { "Gear.PolarBear", 60 },
            { "Gear.ButtersPlush", 60 },
            { "CosmeticGlass.LNY25Ceramic", 30 },
            { "CosmeticShotGlass.LNY25Ceramic", 30 },
            { "CosmeticSmallGlass.LNY25Ceramic", 30 },
            { "CosmeticGlass.LNWGoldFoil", 20 },
            { "CosmeticShotGlass.LNWGoldFoil", 20 },
            { "CosmeticSmallGlass.LNWGoldFoil", 20 },
            { "CosmeticFancyGlass.Goblet", 15 }
        },
        Cost = {
            Currency = "Coins",
            Amount = 2000
        }
    },
    LNW2024 = {
        Name = "Lunear New Year Event Lootbox",
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = false,
        Items = {
            { "Gear.BluePaperFan", 55 },
            { "Gear.RedSilkFan", 55 },
            { "Gear.RedPaperFan", 55 },
            { "Gear.CalicoBunny", 20 },
            { "Gear.PolarBear", 20 },
            { "Gear.StarCat", 20 },
            { "Gear.ButtersPlush", 20 },
            { "Gear.CoatiPlush", 20 },
            { "Emote.FanDance", 20 }
        },
        Cost = {
            Currency = "Holiday",
            Amount = 100
        }
    },
    JulyFourth2024 = {
        Name = "July 4th 2024 Event Lootbox!",
        MinimumNumerialChance = 25,
        GuaranteedRollPercentageChancePity = 0.5,
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = false,
        Items = {
            { "Gear.USAFlag", 150 },
            { "Gear.USAPaperFan", 90 },
            { "Gear.BurgerPlushie", 60 },
            { "Gear.HotdogPlushie", 60 },
            { "Gear.EaglePlushie", 40 },
            { "Gear.PatrioticPlushie", 20 },
            { "Emote.Salute", 15 },
            { "Gear.Musket", 1 }
        },
        Cost = {
            Currency = "Holiday",
            Amount = 100
        }
    },
    ["1stAnniversary"] = {
        Name = "1st Anniversary Event Lootbox!",
        MinimumNumerialChance = 25,
        GuaranteedRollPercentageChancePity = 1,
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = false,
        DuplicateRefundPercentage = 0.5,
        Items = {
            { "Gear.GoldenHoverboard", 10 },
            { "Gear.FettiLauncher", 40 },
            { "CosmeticSmallGlass.Annv24AstronautGlass", 550 },
            { "Gear.MasqueradeCat", 2000 },
            { "Gear.MasqueradeFeather", 2000 },
            { "Gear.MasqueradeBronze", 2000 },
            { "Gear.GoldenButtersPlushie", 3000 },
            { "Emote.Slap", 4000 },
            { "Emote.StreamerDance", 5500 },
            { "Gear.MrFox", 7000 },
            { "Gear.MonsterraPlushie", 7000 },
            { "Gear.BottlePlushie", 7000 },
            { "Gear.FerretPlush", 7000 },
            { "CosmeticSmallGlass.GoldDazzle", 8500 },
            { "CosmeticShotGlass.GoldSpin", 8500 },
            { "CosmeticStoutGlass.HornMug", 8500 },
            { "ConsumeGear.ConfettiPopper", 9000 }
        },
        Cost = {
            Currency = "Holiday",
            Amount = 2000
        }
    },
    Halloween2024 = {
        Name = "Halloween Event Lootbox!",
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = true,
        DuplicateRefundPercentage = 0.5,
        Items = {
            { "ConsumeGear.BooBalloon", 90 },
            { "ConsumeGear.MonsterMashPotion", 90 },
            { "Gear.ZombieCatPlushie", 75 },
            { "Gear.MummyPlushie", 75 },
            { "Gear.GhostPlush", 60 },
            { "Gear.HeadlessHorselessHorsemanPlushie", 60 },
            { "Gear.VoodooDoll", 40 },
            { "CosmeticFancyGlass.SpiderGlass", 40 },
            { "CosmeticSmallGlass.ZombieGlass", 40 },
            { "Gear.HalloweenMusket", 20 },
            { "CosmeticSmallGlass.CauldronGlass", 10 }
        },
        Cost = {
            Currency = "Holiday",
            Amount = 2000
        }
    },
    Christmas2024 = {
        Name = "Christmas Event Lootbox!",
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = true,
        DuplicateRefundPercentage = 0.5,
        Items = {
            { "Gear.ElfPlushie", 100 },
            { "CosmeticStoutGlass.StumpMug", 100 },
            { "Gear.BellKittyBlack", 85 },
            { "Gear.BellKittyWhite", 85 },
            { "Gear.CandyCaneBunny", 85 },
            { "Gear.MistleToeBear", 50 },
            { "Gear.Snowglobe", 49 },
            { "Gear.FriendSnowglobe", 30 },
            { "Gear.RedRyder", 10 },
            { "Gear.DecoySnowman", 1 }
        },
        Cost = {
            Currency = "Holiday",
            Amount = 2000
        }
    },
    LNW2025 = {
        Name = "Lunear New Year Event Lootbox",
        DuplicateRefundPercentage = 0.5,
        AllowClientRequestPurchase = false,
        PolicyServiceCompliant = true,
        Items = {
            { "Gear.RoyalSakuraFan", 500 },
            { "Gear.RoyalSnakeFan", 500 },
            { "Gear.RoyalBlueFan", 500 },
            { "Gear.RedPandaPlush", 300 },
            { "Gear.SnakePlush", 300 },
            { "Gear.GoldfishPlush", 300 },
            { "Gear.DragonPlush", 300 },
            { "Gear.InnerpolyPlushie", 150 },
            { "Gear.LightstickWhite", 150 },
            { "Gear.LightstickRed", 150 },
            { "CosmeticShotGlass.ViperShot", 50 },
            { "CosmeticFancyGlass.ViperWrap", 50 }
        },
        Cost = {
            Currency = "Holiday",
            Amount = 500
        }
    }
};
