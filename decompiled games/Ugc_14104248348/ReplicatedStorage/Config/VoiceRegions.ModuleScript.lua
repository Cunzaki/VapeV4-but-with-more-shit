-- Decompiled from: ReplicatedStorage.Config.VoiceRegions
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    SkyscrapersFront = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(1522, 294, 206),
                CFrame = CFrame.new(346.000061, 53.5, 269, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "StreetCenter",
            "StreetLeft",
            "StreetRight",
            "Entrance"
        }
    },
    SkyscrapersSides = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(520, 294, 666),
                CFrame = CFrame.new(847, 53.5, -166.999969, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(341, 294, 440),
                CFrame = CFrame.new(-234.500015, 53.5, -53.9999847, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "StreetCenter",
            "StreetLeft",
            "StreetRight",
            "Entrance"
        }
    },
    StreetCenter = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(86, 42, 125),
                CFrame = CFrame.new(387, 25.4999962, 103.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetLeft",
            "StreetRight",
            "Entrance",
            "Stage",
            "MainBar",
            "GamesArea",
            "OutdoorLounge2",
            "ApartmentUpper"
        }
    },
    MatchRooftop = {
        Bounds = {
            {
                Size = Vector3.new(542.97, 384.27902, 634.752),
                CFrame = CFrame.new(607, -41.5005035, -1494.91406, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {}
    },
    ApartmentUpper = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(104.49, 43.071, 100.133995),
                CFrame = CFrame.new(474.700012, 64.2764969, 137.415985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetLeft",
            "StreetRight",
            "Entrance"
        }
    },
    StreetLeft = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(69, 37.955997, 128),
                CFrame = CFrame.new(464.5, 23.4779968, 102, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(90, 37.905, 162),
                CFrame = CFrame.new(544, 23.4524956, 85, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetCenter",
            "StreetRight",
            "Entrance",
            "MainBar",
            "ApartmentUpper"
        }
    },
    StreetRight = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(184, 42, 164),
                CFrame = CFrame.new(252, 25.4999962, 84, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(19, 42, 39),
                CFrame = CFrame.new(353.5, 25.4999962, 21.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(54, 42, 27),
                CFrame = CFrame.new(302, 25.4999962, -11.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "StreetCenter",
            "StreetLeft",
            "SkyscrapersFront",
            "SkyscrapersSides",
            "Entrance",
            "Stage",
            "MainBar",
            "ApartmentUpper"
        }
    },
    Entrance = {
        AlwaysVisible = true,
        Bounds = {
            {
                Size = Vector3.new(54, 32, 71),
                CFrame = CFrame.new(389, 20.4999962, 5.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetCenter",
            "StreetLeft",
            "StreetRight",
            "Stage",
            "StatueArea",
            "MainBar",
            "GamesArea",
            "Bathroom",
            "OutdoorLounge2",
            "FoodTrucks"
        }
    },
    Stage = {
        Bounds = {
            {
                Size = Vector3.new(71, 32, 66),
                CFrame = CFrame.new(452.5, 20.4999962, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "Entrance",
            "StatueArea",
            "MainBar",
            "GamesArea",
            "Bathroom",
            "OutdoorLounge2",
            "FoodTrucks"
        }
    },
    StatueArea = {
        Bounds = {
            {
                Size = Vector3.new(61, 32, 72),
                CFrame = CFrame.new(518.5, 20.4999962, -39.0000038, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "Entrance",
            "Stage",
            "MainBar",
            "GamesArea",
            "OutdoorLounge2"
        }
    },
    MainBar = {
        Bounds = {
            {
                Size = Vector3.new(126, 32, 81),
                CFrame = CFrame.new(425, 20.4999962, -70.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "StreetCenter",
            "Entrance",
            "Stage",
            "StatueArea",
            "GamesArea",
            "Bathroom",
            "VIPBar",
            "OutdoorLounge2",
            "FoodTrucks",
            "FoodTruckFoliage"
        }
    },
    GamesArea = {
        Bounds = {
            {
                Size = Vector3.new(89, 32, 39),
                CFrame = CFrame.new(408.5, 20.4999962, -130.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "StreetCenter",
            "Entrance",
            "Stage",
            "Bathroom",
            "Aquarium",
            "MainBar",
            "VIPBar",
            "VIPPool",
            "OutdoorLounge1",
            "OutdoorLounge2"
        }
    },
    Bathroom = {
        Bounds = {
            {
                Size = Vector3.new(54, 32, 71),
                CFrame = CFrame.new(392, 20.4999962, -183.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "Entrance",
            "Stage",
            "MainBar",
            "GamesArea",
            "VIPBar"
        }
    },
    Aquarium = {
        Bounds = {
            {
                Size = Vector3.new(137.006, 30, 99.30101),
                CFrame = CFrame.new(487.502991, 19.4999981, -290.071503, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(139.778, 65.799995, 156.944),
                CFrame = CFrame.new(438.110992, 25.1269951, -273.471985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(71.48599, 30, 195.94301),
                CFrame = CFrame.new(454.742981, 19.4999981, -241.750488, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(121.48599, 47, 108.94301),
                CFrame = CFrame.new(439.742981, 28, -285.250488, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "MainBar",
            "GamesArea",
            "Bathroom",
            "VIPBar"
        }
    },
    VIPBar = {
        Bounds = {
            {
                Size = Vector3.new(111.99999, 32, 37),
                CFrame = CFrame.new(509, 20.4999962, -129.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(76.99999, 32, 18),
                CFrame = CFrame.new(526.5, 20.4999962, -102, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersSides",
            "MainBar",
            "GamesArea",
            "OutdoorLounge1",
            "OutdoorLounge2",
            "Bathroom",
            "Aquarium",
            "VIPPool"
        }
    },
    VIPPool = {
        Bounds = {
            {
                Size = Vector3.new(56.999992, 32, 53),
                CFrame = CFrame.new(536.5, 20.4999962, -174.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersSides",
            "MainBar",
            "GamesArea",
            "VIPBar"
        }
    },
    OutdoorLounge1 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(38, 32, 104),
                CFrame = CFrame.new(343, 20.4999962, -50, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "StreetCenter",
            "StreetRight",
            "MainBar",
            "GamesArea",
            "OutdoorLounge1",
            "OutdoorLounge2",
            "FoodTrucks",
            "FoodTruckFoliage"
        }
    },
    OutdoorLounge2 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(38, 32, 51),
                CFrame = CFrame.new(343, 20.4999962, -127.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "StreetCenter",
            "StreetRight",
            "Entrance",
            "Stage",
            "StatueArea",
            "MainBar",
            "GamesArea",
            "OutdoorLounge1",
            "CampFoliage",
            "FoodTrucks"
        }
    },
    FoodTrucks = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(128, 41, 112),
                CFrame = CFrame.new(298, 24.9999962, -209, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "MainBar",
            "OutdoorLounge1",
            "OutdoorLounge2",
            "FoodTruckFoliage",
            "FightArea",
            "CampFoliage",
            "TikiBar"
        }
    },
    FoodTruckFoliage = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(130, 86, 105),
                CFrame = CFrame.new(299, 31.4999962, -317.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "OutdoorLounge1",
            "OutdoorLounge2",
            "FoodTrucks",
            "FightArea",
            "CampFoliage",
            "TikiBar"
        }
    },
    FightArea = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(40, 41, 126),
                CFrame = CFrame.new(254, 24.9999962, -90, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetRight",
            "OutdoorLounge2",
            "FoodTrucks",
            "FoodTruckFoliage",
            "CampFoliage",
            "TikiBar"
        }
    },
    CampFoliage = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(298, 96, 351),
                CFrame = CFrame.new(85, 36.5, -174.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetRight",
            "OutdoorLounge2",
            "FoodTrucks",
            "FoodTruckFoliage",
            "FightArea",
            "TikiBar"
        }
    },
    TikiBar = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(75, 39, 78),
                CFrame = CFrame.new(155.5, 8, -389, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "SkyscrapersFront",
            "SkyscrapersSides",
            "StreetRight",
            "FoodTrucks",
            "FoodTruckFoliage",
            "FightArea",
            "CampFoliage",
            "TikiBar"
        }
    }
};
