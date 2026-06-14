-- Decompiled from: ReplicatedStorage.Config.Regions
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    MainBarEntrance = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(56.239838, 27.991493, 57.96545),
                CFrame = CFrame.new(390.75174, 17.7023964, 7.19766045, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound1",
            "FrontBound2",
            "FrontBound3",
            "OutBound2",
            "CafeZowie",
            "NTStore",
            "AnchorLoft",
            "Stage",
            "RecordRoom",
            "Kitchen",
            "MainBarCore",
            "MainBarCourt"
        }
    },
    MainBarSecret = {
        Bounds = {
            {
                Size = Vector3.new(34.027943, 20.675879, 25.885939),
                CFrame = CFrame.new(435.04892, 18.263176, -127.289688, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "MainBarCore",
            "Alley",
            "FrontBound2",
            "NTStore",
            "Bathroom",
            "Patio",
            "AnchorLoft",
            "Stage",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium",
            "Kitchen"
        }
    },
    MainBarCore = {
        Bounds = {
            {
                Size = Vector3.new(55.502075, 29.595022, 115.251564),
                CFrame = CFrame.new(390.277588, 16.8808517, -79.404686, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "MainBarSecret",
            "Alley",
            "FrontBound2",
            "NTStore",
            "Bathroom",
            "Patio",
            "AnchorLoft",
            "Stage",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium",
            "Kitchen"
        }
    },
    MainBarCourt = {
        Bounds = {
            {
                Size = Vector3.new(117.82502, 29.447191, 23.949158),
                CFrame = CFrame.new(476.409241, 16.8069324, -32.85149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(20.224466, 2.9664764, 23.949158),
                CFrame = CFrame.new(525.209534, 31.0596924, -32.85149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(24.715048, 29.447191, 12.400908),
                CFrame = CFrame.new(496.77594, 16.8069324, -50.3366623, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        VoiceConnectedTo = { "Kitchen" },
        ConnectedTo = {
            "FrontBound2",
            "Bathroom",
            "Backstage",
            "ForestTrees",
            "AnchorLoft",
            "Stage",
            "VipRoom",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCore",
            "Aquarium"
        }
    },
    Aquarium = {
        Bounds = {
            {
                Size = Vector3.new(79.32958, 22.11239, 67.05854),
                CFrame = CFrame.new(495.850525, 16.3604774, -90.4123993, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(25.606901, 22.243635, 17.715195),
                CFrame = CFrame.new(521.980835, 16.2948532, -54.1763649, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(28.265434, 22.243635, 17.715195),
                CFrame = CFrame.new(470.296295, 16.2948532, -54.1763649, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound2",
            "OutBound2",
            "OutBound1",
            "NTStore",
            "Bathroom",
            "Backstage",
            "AnchorLoft",
            "Stage",
            "VipRoom",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium"
        }
    },
    RecordRoom = {
        Bounds = {
            {
                Size = Vector3.new(35.55081, 28.911312, 34.78369),
                CFrame = CFrame.new(436.943817, 16.5389938, -62.1725159, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound2",
            "OutBound2",
            "OutBound1",
            "NTStore",
            "Bathroom",
            "Backstage",
            "AnchorLoft",
            "Stage",
            "VipRoom",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium"
        }
    },
    VipRoom = {
        Bounds = {
            {
                Size = Vector3.new(116.14861, 22.024189, 83.45904),
                CFrame = CFrame.new(478.065308, 43.6991463, -61.9731674, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(29.142982, 22.024189, 6.0759053),
                CFrame = CFrame.new(521.568115, 43.6991463, -106.524277, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "Stage",
            "MainBarEntrance",
            "MainBarCourt",
            "Backstage",
            "ForestTrees",
            "OutBound2"
        }
    },
    Stage = {
        Bounds = {
            {
                Size = Vector3.new(73.16117, 51.13463, 56.443466),
                CFrame = CFrame.new(456.160431, 27.6506519, 7.12273788, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound2",
            "OutBound2",
            "OutBound1",
            "NTStore",
            "Bathroom",
            "Backstage",
            "AnchorLoft",
            "Stage",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium",
            "VipRoom"
        }
    },
    Bathroom = {
        Bounds = {
            {
                Size = Vector3.new(57.092735, 28.495771, 28.881882),
                CFrame = CFrame.new(391.371613, 16.3312244, -151.492294, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "MainBarSecret",
            "FrontBound2",
            "SecretBathroom",
            "OutBound2",
            "Bathroom",
            "RecordRoom",
            "Aquarium",
            "MainBarEntrance",
            "MainBarCore",
            "MainBarCourt",
            "Patio"
        }
    },
    SecretBathroom = {
        Bounds = {
            {
                Size = Vector3.new(43.49458, 22.923975, 56.641838),
                CFrame = CFrame.new(444.747437, 15.531353, -206.477509, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(11.704306, 32.820282, 35.435646),
                CFrame = CFrame.new(445.351227, 3.66089058, -163.462982, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(16.155024, 17.314863, 51.096874),
                CFrame = CFrame.new(443.762939, -4.58639717, -127.925758, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(17.8055, 37.314865, 11.096874),
                CFrame = CFrame.new(426.937683, 5.41360092, -107.925758, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "MainBarSecret",
            "FrontBound2",
            "Bathroom",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCore",
            "MainBarCourt",
            "Patio"
        }
    },
    Backstage = {
        Bounds = {
            {
                Size = Vector3.new(18.297375, 25.333334, 56.071594),
                CFrame = CFrame.new(502.483215, 14.7500048, 6.85713768, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound1",
            "OutBound1",
            "Bathroom",
            "Stage",
            "VipRoom",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium"
        }
    },
    Kitchen = {
        Bounds = {
            {
                Size = Vector3.new(32.787514, 25.333334, 62.993954),
                CFrame = CFrame.new(346.174805, 14.7500048, -35.724411, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound2",
            "FrontBound3",
            "Alley",
            "OutBound2",
            "OutBound1",
            "AnchorLoft",
            "Stage",
            "RecordRoom",
            "MainBarEntrance",
            "MainBarCourt",
            "Aquarium"
        }
    },
    CafeZowie = {
        Bounds = {
            {
                Size = Vector3.new(47.278233, 35.262157, 53.972237),
                CFrame = CFrame.new(412.008331, 22.7587929, 119.402687, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {}
    },
    NTStore = {
        Bounds = {
            {
                Size = Vector3.new(38.88847, 19.733793, 50.383026),
                CFrame = CFrame.new(367.420074, 14.9946127, 120.387421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound2",
            "OutBound1",
            "FrontBound1",
            "FrontBound3",
            "MainBarEntrance",
            "Alley",
            "AnchorLoft",
            "CafeZowie",
            "Trivia"
        }
    },
    AnchorLoft = {
        Bounds = {
            {
                Size = Vector3.new(48.131145, 19.733793, 41.06933),
                CFrame = CFrame.new(319.332611, 15.8848753, 115.1483, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound2",
            "OutBound1",
            "FrontBound1",
            "FrontBound3",
            "MainBarEntrance",
            "Alley",
            "NTStore",
            "CafeZowie",
            "Trivia"
        }
    },
    Trivia = {
        Bounds = {
            {
                Size = Vector3.new(37.86208, 19.733793, 35.99148),
                CFrame = CFrame.new(273.778778, 14.9946127, 108.384323, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound2",
            "OutBound1",
            "FrontBound1",
            "FrontBound3",
            "MainBarEntrance",
            "Alley",
            "NTStore",
            "CafeZowie",
            "Trivia"
        }
    },
    WhimAndCo = {
        Bounds = {
            {
                Size = Vector3.new(53.31954, 19.733793, 42.44607),
                CFrame = CFrame.new(283.273651, 14.9946127, 13.5889921, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound2",
            "OutBound1",
            "FrontBound2",
            "FrontBound1",
            "Sewer",
            "WhimAndCo",
            "MainBarEntrance",
            "Alley",
            "AnchorLoft",
            "NTStore",
            "CafeZowie",
            "Trivia"
        }
    },
    WitchArea = {
        Bounds = {
            {
                Size = Vector3.new(71.70374, 51.545418, 103.46646),
                CFrame = CFrame.new(129.92807, 9.89143372, -45.0604172, -0.348721683, 0, 0.937226295, 0, 1, 0, -0.937226295, 0, -0.348721683)
            }
        },
        ConnectedTo = {
            "OutsideCourt2",
            "ForestCourt",
            "WitchArea",
            "Bunker"
        }
    },
    WaterZone = {
        Bounds = {
            {
                Size = Vector3.new(93.86147, 52.418354, 68.13521),
                CFrame = CFrame.new(69.8505936, 19.2319756, -119.955353, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(43.413643, 24.581623, 31.664799),
                CFrame = CFrame.new(45.4347649, 33.150341, -78.6587219, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(43.413643, 24.581623, 31.664799),
                CFrame = CFrame.new(45.4347649, 41.8182983, -112.823456, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "ForestTrees",
            "OutsideCourt",
            "OutsideBeach",
            "OutsideCourt2",
            "ForestCourt",
            "WaterZone",
            "WitchArea"
        }
    },
    Sewer = {
        Bounds = {
            {
                Size = Vector3.new(109.1349, 49.012703, 220.48256),
                CFrame = CFrame.new(326.201111, -26.7815132, -44.1910439, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound2",
            "FrontBound3",
            "Alley",
            "AnchorLoft",
            "NTStore",
            "MainBarEntrance"
        }
    },
    Bunker = {
        Bounds = {
            {
                Size = Vector3.new(50.948067, 26.328835, 74.2113),
                CFrame = CFrame.new(238.185593, -6.16475773, -25.9836845, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(16.467482, 34.59, 93.71701),
                CFrame = CFrame.new(239.862839, 3.93252277, -60.5494118, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            }
        },
        ConnectedTo = {
            "ForestTrees",
            "OutsideCourt",
            "OutsideCourt2",
            "ForestCourt",
            "WaterZone",
            "WitchArea"
        }
    },
    OutBound1 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(1203.173, 726.2433, 2048),
                CFrame = CFrame.new(1660.40283, 270.786438, -140.864807, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = { "OutBound2" }
    },
    OutBound2 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(1970.2844, 726.2433, 835.8346),
                CFrame = CFrame.new(85.5151367, 270.786438, 579.04718, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(269.38025, 57.28034, 59.687115),
                CFrame = CFrame.new(625.053467, 33.5230179, 124.332825, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(1097.6459, 395.52188, 59.687115),
                CFrame = CFrame.new(-295.414856, 202.643799, 120.315819, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(129.17358, 97.50524, 63.69988),
                CFrame = CFrame.new(34.9595795, 53.6354713, 63.060833, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = { "OutBound1", "SecretOutBound" }
    },
    SecretOutBound = {
        Bounds = {
            {
                Size = Vector3.new(416.46948, 395.52188, 208.5837),
                CFrame = CFrame.new(-339.247559, 89.4256821, -12.3567429, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = { "OutBound2" }
    },
    AnchorOutBound = {
        AlwaysVisible = true,
        Bounds = {
            {
                Size = Vector3.new(2048, 726.2433, 325.59772),
                CFrame = CFrame.new(124.37294, 270.786438, 1320.69165, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = { "OutBound2" }
    },
    FrontBound1 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(193.36465, 29.985964, 59.687115),
                CFrame = CFrame.new(587.045654, 19.8758316, 66.0999146, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound1",
            "OutBound2",
            "FrontBound1",
            "FrontBound3",
            "MainBarEntrance",
            "Alley",
            "NTStore",
            "WhimAndCo",
            "Trivia",
            "AnchorLoft",
            "CafeZowie"
        }
    },
    FrontBound2 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(198.21088, 30.73749, 55.81065),
                CFrame = CFrame.new(392.435394, 19.8758316, 64.1616821, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(47.441174, 37.84871, 39.56358),
                CFrame = CFrame.new(337.270447, 16.3202209, 16.7450008, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound1",
            "OutBound2",
            "FrontBound1",
            "FrontBound3",
            "MainBarEntrance",
            "Alley",
            "NTStore",
            "WhimAndCo",
            "Trivia",
            "AnchorLoft",
            "CafeZowie"
        }
    },
    FrontBound3 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(195.43831, 29.985964, 54.44609),
                CFrame = CFrame.new(195.610779, 19.8758316, 62.5186882, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(155.85263, 54.888622, 54.434456),
                CFrame = CFrame.new(177.472687, 32.3271599, 18.6567783, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound1",
            "OutBound2",
            "FrontBound1",
            "FrontBound2",
            "MainBarEntrance",
            "NTStore",
            "Alley",
            "WhimAndCo",
            "Trivia",
            "AnchorLoft"
        }
    },
    ForestTrees = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(74.21495, 88.64997, 53.80085),
                CFrame = CFrame.new(135.17897, 93.3277435, -57.6025848, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(139.82233, 157.74261, 257.06866),
                CFrame = CFrame.new(40.1241875, 58.7811546, -425.65033, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(131.62718, 69.65273, 345.94568),
                CFrame = CFrame.new(36.0266151, 102.82637, -124.479836, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(28.606691, 94.10517, 30.560974),
                CFrame = CFrame.new(111.270966, 90.6001434, -206.039398, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(34.64719, 91.66436, 241.3764),
                CFrame = CFrame.new(118.068108, -10.6300983, -436.543152, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(46.72734, 99.53348, 29.837114),
                CFrame = CFrame.new(194.49588, 87.8857727, -39.3549957, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            }
        },
        ConnectedTo = {
            "MainBarCore",
            "OutsideCourt",
            "OutsideBeach",
            "OutsideCourt2",
            "ForestCourt",
            "WaterZone",
            "WitchArea",
            "Patio"
        }
    },
    ForestCourt = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(114.07314, 65.3301, 63.333496),
                CFrame = CFrame.new(172.953369, 38.9518051, -135.279633, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(39.517063, 65.3301, 82.70455),
                CFrame = CFrame.new(209.719788, 38.9518051, -62.4213181, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(43.98155, 65.3301, 10.452679),
                CFrame = CFrame.new(245.598846, 38.9518051, -110.592873, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(73.84326, 65.3301, 51.33322),
                CFrame = CFrame.new(265.190552, 38.9518051, -140.577072, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            }
        },
        ConnectedTo = {
            "Bunker",
            "ForestTrees",
            "OutsideCourt",
            "OutsideBeach",
            "OutsideCourt2",
            "ForestCourt",
            "OutBound2",
            "WaterZone",
            "WitchArea"
        }
    },
    Patio = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(33.07853, 30.431015, 96.78144),
                CFrame = CFrame.new(346.419647, 18.7751198, -117.638367, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "ForestTrees",
            "MainBarCore",
            "MainBarEntrance",
            "Bathroom",
            "MainBarCourt",
            "OutsideCourt",
            "OutsideBeach",
            "OutBound2",
            "OutsideCourt2",
            "ForestCourt"
        }
    },
    OutsideBeach = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(367.89893, 52.67508, 292.0022),
                CFrame = CFrame.new(310.64798, -1.47602844, -499.730377, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound1",
            "OutBound2",
            "ForestTrees",
            "OutsideCourt",
            "OutsideBeach",
            "OutsideCourt2",
            "ForestCourt",
            "Patio"
        }
    },
    OutsideCourt = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(137.56169, 109.02171, 187.6248),
                CFrame = CFrame.new(328.952515, 32.562603, -259.858154, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(89.158005, 47.117958, 119.80829),
                CFrame = CFrame.new(441.811005, 1.61071682, -293.829193, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(13.210532, 47.117958, 42.892357),
                CFrame = CFrame.new(403.819885, 1.61071682, -225.890335, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            },
            {
                Size = Vector3.new(128.15758, 47.117958, 92.38913),
                CFrame = CFrame.new(550.228882, 1.61071682, -305.506378, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            }
        },
        ConnectedTo = {
            "OutBound1",
            "OutBound2",
            "ForestTrees",
            "MainBarCore",
            "OutsideCourt",
            "OutsideBeach",
            "OutsideCourt2",
            "ForestCourt",
            "Patio"
        }
    },
    OutsideCourt2 = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(139.29323, 123.842094, 187.6775),
                CFrame = CFrame.new(190.848373, 39.9727783, -259.903198, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "OutBound1",
            "ForestTrees",
            "OutsideCourt",
            "OutsideBeach",
            "OutsideCourt2",
            "ForestCourt",
            "OutBound2",
            "Patio"
        }
    },
    Alley = {
        VisibleWhenOutside = true,
        Bounds = {
            {
                Size = Vector3.new(25.609999, 33.38356, 52.4568),
                CFrame = CFrame.new(317.046936, 18.7751198, -34.6718979, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Size = Vector3.new(16.534056, 33.38356, 6.099182),
                CFrame = CFrame.new(321.5849, 18.7751198, -5.50199127, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound3",
            "WhimAndCo",
            "OutBound2",
            "OutBound1",
            "Kitchen",
            "DeusRoom"
        }
    },
    DeusRoom = {
        Bounds = {
            {
                Size = Vector3.new(25.103096, 20.188946, 24.335255),
                CFrame = CFrame.new(290.132874, 15.62533, -25.4898338, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {
            "FrontBound3",
            "WhimAndCo",
            "OutBound2",
            "OutBound1",
            "Kitchen"
        }
    },
    BossArena = {
        AlwaysVisible = true,
        Bounds = {
            {
                Size = Vector3.new(392.63437, 157.81543, 435.05414),
                CFrame = CFrame.new(-2308.82275, -110.468109, -2232.40845, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        },
        ConnectedTo = {}
    }
};
