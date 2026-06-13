-- Decompiled from: ReplicatedStorage.Config.Shared.Sounds
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__SoundService__1 = game.SoundService;
return {
    SoundGroups = {
        Master = l__SoundService__1.Master,
        SFX = l__SoundService__1.Master.SFX,
        Music = l__SoundService__1.Master.Music
    },
    Effects = {
        Quarry = {
            AmbientReverb = Enum.ReverbType.Quarry
        },
        Echo = {
            {
                Class = "ReverbSoundEffect",
                Properties = {
                    DecayTime = 0.1
                }
            }
        },
        Buffed = {
            {
                Class = "EqualizerSoundEffect",
                Properties = {
                    LowGain = 1,
                    MidGain = -80
                }
            },
            {
                Class = "ReverbSoundEffect",
                Properties = {
                    DecayTime = 0.1
                }
            }
        }
    },
    Sounds = {
        SFX = {
            Foot = {
                Collection = true,
                AlienEnemy = {
                    Shuffle = true,
                    "rbxassetid://12189090317",
                    "rbxassetid://12189090219",
                    "rbxassetid://12189090420"
                },
                Metal_Walkway = {
                    Step = {
                        Random = true,
                        "rbxassetid://11676766218",
                        "rbxassetid://11676766377",
                        "rbxassetid://11676766560",
                        "rbxassetid://11676766658",
                        "rbxassetid://11676766723",
                        "rbxassetid://11676766764",
                        "rbxassetid://11676766847",
                        "rbxassetid://11676766911"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11676765776",
                        "rbxassetid://11676765861",
                        "rbxassetid://11676765950",
                        "rbxassetid://11676766116",
                        "rbxassetid://11676766313",
                        "rbxassetid://11676766465",
                        "rbxassetid://11676766604"
                    },
                    Land = { "rbxassetid://11676766043" }
                },
                Grass = {
                    Step = {
                        Random = true,
                        "rbxassetid://11657539503",
                        "rbxassetid://11657539528",
                        "rbxassetid://11657539558",
                        "rbxassetid://11657539584",
                        "rbxassetid://11657539604",
                        "rbxassetid://11657539625",
                        "rbxassetid://11657539670"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11657546386",
                        "rbxassetid://11657546436",
                        "rbxassetid://11657546476",
                        "rbxassetid://11657546524",
                        "rbxassetid://11657546562",
                        "rbxassetid://11657546604",
                        "rbxassetid://11657546647"
                    },
                    Land = {
                        Random = true,
                        "rbxassetid://11657550957",
                        "rbxassetid://11657551046",
                        "rbxassetid://11657551112"
                    }
                },
                Gravel = {
                    Step = {
                        Random = true,
                        "rbxassetid://11657417038",
                        "rbxassetid://11657416980",
                        "rbxassetid://11657417071",
                        "rbxassetid://11657417107",
                        "rbxassetid://11657416895",
                        "rbxassetid://11657416837",
                        "rbxassetid://11657417185"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11657477393",
                        "rbxassetid://11657477324",
                        "rbxassetid://11657477068",
                        "rbxassetid://11657477256",
                        "rbxassetid://11657477208",
                        "rbxassetid://11657477164",
                        "rbxassetid://11657477117"
                    },
                    Land = {
                        Random = true,
                        "rbxassetid://11657481170",
                        "rbxassetid://11657481122"
                    }
                },
                Metal = {
                    Step = {
                        Random = true,
                        "rbxassetid://11657341221",
                        "rbxassetid://11657341087",
                        "rbxassetid://11657341149",
                        "rbxassetid://11657341184",
                        "rbxassetid://11657341244",
                        "rbxassetid://11657341037",
                        "rbxassetid://11657340989"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11657346910",
                        "rbxassetid://11657347187",
                        "rbxassetid://11657346747",
                        "rbxassetid://11657346835",
                        "rbxassetid://11657346684",
                        "rbxassetid://11657346622",
                        "rbxassetid://11657347036"
                    },
                    Land = {
                        Random = true,
                        "rbxassetid://11657352898",
                        "rbxassetid://11657352856",
                        "rbxassetid://11657352796"
                    }
                },
                Carpet = {
                    Step = {
                        Random = true,
                        "rbxassetid://11657130785",
                        "rbxassetid://11657130561",
                        "rbxassetid://11657130851",
                        "rbxassetid://11657130746",
                        "rbxassetid://11657130818",
                        "rbxassetid://11657130610",
                        "rbxassetid://11657130708",
                        "rbxassetid://11657130657"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11657136276",
                        "rbxassetid://11657136238",
                        "rbxassetid://11657136153",
                        "rbxassetid://11657136110",
                        "rbxassetid://11657136062",
                        "rbxassetid://11657136015",
                        "rbxassetid://11657136199",
                        "rbxassetid://11657135902"
                    },
                    Land = {
                        Random = true,
                        "rbxassetid://11657152569",
                        "rbxassetid://11657149114"
                    }
                },
                Concrete = {
                    Step = {
                        Random = true,
                        "rbxassetid://11656890181",
                        "rbxassetid://11656890255",
                        "rbxassetid://11656890096",
                        "rbxassetid://11656889995",
                        "rbxassetid://11656889793",
                        "rbxassetid://11656890294",
                        "rbxassetid://11656889703"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11656889703",
                        "rbxassetid://11656915785",
                        "rbxassetid://11656915731",
                        "rbxassetid://11656915453",
                        "rbxassetid://11656915543",
                        "rbxassetid://11656915590",
                        "rbxassetid://11656915368",
                        "rbxassetid://11656915624"
                    },
                    Land = {
                        Random = true,
                        "rbxassetid://11656945964",
                        "rbxassetid://11656945901",
                        "rbxassetid://11656945846"
                    }
                },
                Wood = {
                    Step = {
                        Random = true,
                        "rbxassetid://14649881064",
                        "rbxassetid://14649880990",
                        "rbxassetid://14649880903",
                        "rbxassetid://14649880831",
                        "rbxassetid://14649880709",
                        "rbxassetid://14649880529",
                        "rbxassetid://14649880443",
                        "rbxassetid://14649880319",
                        "rbxassetid://14649880222",
                        "rbxassetid://14649880103"
                    },
                    Run = {
                        Random = true,
                        "rbxassetid://11648301930",
                        "rbxassetid://11648705378",
                        "rbxassetid://11648845590",
                        "rbxassetid://11648845658",
                        "rbxassetid://11648845689",
                        "rbxassetid://11648845545",
                        "rbxassetid://11648845624"
                    },
                    Land = {
                        Random = true,
                        "rbxassetid://11648864282",
                        "rbxassetid://11648864317"
                    }
                }
            },
            Player = {
                Collection = true,
                Breathing = {
                    Volume = 1,
                    "rbxassetid://12099636863"
                },
                Heartbeat = {
                    Volume = 50,
                    "rbxassetid://12101659511"
                }
            },
            Teleport = {
                Collection = true,
                In = {
                    Volume = 1,
                    "rbxassetid://17086222581"
                },
                Out = {
                    Volume = 2,
                    "rbxassetid://17086211702"
                }
            },
            Scare = {
                Collection = true,
                Reverb1 = {
                    Volume = 3,
                    "rbxassetid://17532006272"
                },
                Soft = {
                    Volume = 50,
                    "rbxassetid://12110299262"
                },
                Light = {
                    Volume = 50,
                    "rbxassetid://17802501925"
                },
                Hard = {
                    Volume = 50,
                    "rbxassetid://17802381681"
                }
            },
            ReloadingGeneric = { "rbxassetid://90793143215602" },
            TicTacToe = {
                Collection = true,
                Place = { "rbxassetid://9120858570", "rbxassetid://9120937669", "rbxassetid://9120858807" },
                Win = {
                    Volume = 3,
                    "rbxassetid://18586426391"
                },
                Lose = {
                    Volume = 3,
                    "rbxassetid://18586426612"
                },
                Error = { "rbxassetid://550209561" },
                Hover = { "rbxassetid://10066931761" }
            },
            OAnQuan = {
                Collection = true,
                Slide = {
                    Volume = 2,
                    Random = true,
                    "rbxassetid://99169907018804",
                    "rbxassetid://108476956037089",
                    "rbxassetid://89758784659474",
                    "rbxassetid://111286098396816",
                    "rbxassetid://96904078418227",
                    "rbxassetid://126669967755688",
                    "rbxassetid://83878393348850"
                },
                Drop = {
                    Volume = 2,
                    Random = true,
                    "rbxassetid://116878809774270",
                    "rbxassetid://94031587918103",
                    "rbxassetid://111555660415862",
                    "rbxassetid://70572983477174"
                },
                BulkMove = {
                    Volume = 2,
                    Random = true,
                    "rbxassetid://86542028085904",
                    "rbxassetid://92397196936989",
                    "rbxassetid://121643958724743"
                },
                Select = {
                    Volume = 2,
                    "rbxassetid://110555029238905"
                },
                Correct = {
                    Volume = 2,
                    "rbxassetid://119273887558975"
                },
                Incorrect = {
                    Volume = 2,
                    "rbxassetid://84413688491684"
                }
            },
            Pool = {
                Collection = true,
                Cue = { "rbxassetid://130402602445400" },
                Pocket = { "rbxassetid://105085261376800" },
                DampenedCollision = { "rbxassetid://128721003122180" },
                Collision = { "rbxassetid://110707231436013", "rbxassetid://130384005107105" },
                TurnChange = { "rbxassetid://99963606052693" }
            },
            Checkers = {
                Collection = true,
                Move = { "rbxassetid://18188823179" },
                Select = { "rbxassetid://18188825299" }
            },
            Battleship = {
                Collection = true,
                Miss = {
                    "rbxassetid://18374403148",
                    Volume = 1
                },
                Hit = {
                    "rbxassetid://18374486271",
                    Volume = 1
                },
                DistantHit = {
                    "rbxassetid://18258109044",
                    Volume = 1
                },
                Sink = {
                    "rbxassetid://18419816807",
                    Volume = 1.6
                }
            },
            Rythm = {
                Collection = true,
                Select = {
                    "rbxassetid://17821917689",
                    Volume = 1.5
                },
                Submit1 = {
                    "rbxassetid://17821905016",
                    Volume = 1.5
                },
                Submit2 = {
                    "rbxassetid://17821904661",
                    Volume = 1.5
                },
                Countdown = {
                    "rbxassetid://17821989919",
                    Volume = 1.5
                }
            },
            Donate = {
                Collection = true,
                Low = {
                    Volume = 3,
                    "rbxassetid://13456330712"
                },
                Mid = {
                    Volume = 3,
                    "rbxassetid://13541430492"
                },
                High = {
                    Volume = 5,
                    "rbxassetid://13541425299"
                },
                Global = { "rbxassetid://13539671925" }
            },
            block_interact = { "rbxassetid://3779045779" },
            grill_explode = { "rbxassetid://16719323124" },
            active_grill = { "rbxassetid://16719323312" },
            portal_enter = {
                "rbxassetid://87934690745348",
                Volume = 1.5
            },
            freezer_loop = { "rbxassetid://9059920026" },
            fizz_loop = { "rbxassetid://8927189475" },
            beep_loop = { "rbxassetid://9113084761" },
            insanity_loop = { "rbxassetid://16837190191" },
            heaven_loop = { "rbxassetid://16836428031" },
            unstable_loop = { "rbxassetid://16836428031" },
            react_success = { "rbxassetid://16836277613" },
            react_failure = { "rbxassetid://16836277375" },
            collect_coin = { "rbxassetid://18926282792" },
            error_confetti = { "rbxassetid://550209561" },
            shootdart = {
                "rbxassetid://110035442222068",
                Volume = 2
            },
            frostbite_die = { "rbxassetid://15559869832" },
            frostbite_loop = { "rbxassetid://15559627783" },
            spirit_loop = {
                "rbxassetid://9119468895",
                Volume = 0.8
            },
            soul_loop = {
                "rbxassetid://14257891684",
                Volume = 1
            },
            portal_open = {
                "rbxassetid://876800936",
                Volume = 12
            },
            flutter_loop = {
                "rbxassetid://9114504259",
                Volume = 6
            },
            portal_loop = {
                "rbxassetid://2162238374",
                Volume = 5
            },
            water_sound = {
                "rbxassetid://16901294156",
                Volume = 3
            },
            water_portal_loop = {
                "rbxassetid://9120557412",
                Volume = 3
            },
            blip = {
                "rbxassetid://14392084520",
                Volume = 10
            },
            snowhit = { "rbxassetid://9113721238" },
            uibuttonhover = { "rbxassetid://10066936758" },
            uiclickdown = { "rbxassetid://876939830" },
            uiclickup = { "rbxassetid://6895079853" },
            important = {
                "rbxassetid://7383525713",
                Volume = 10
            },
            search_trash = { "rbxassetid://17737204821" },
            balloonpop = {
                "rbxassetid://19113263649",
                Volume = 2
            },
            error = { "rbxassetid://95806568566568" },
            notifsound = { "rbxassetid://421058925" },
            club_log_in = { "rbxassetid://16158968585" },
            club_log_out = { "rbxassetid://16158970739" },
            page_turn = {
                "rbxassetid://9118836218",
                "rbxassetid://9118835420",
                "rbxassetid://9118835637",
                "rbxassetid://9118836375",
                Volume = 2
            },
            WitchSecret = {
                Collection = true,
                LightFlickering = {
                    "rbxassetid://166047422",
                    Volume = 10
                },
                WitchLaughing = { "rbxassetid://17800680577" },
                LightOn = { "rbxassetid://4398922591" }
            },
            start_grill = {
                "rbxassetid://6383276435",
                Volume = 2
            },
            Halloween = {
                Collection = true,
                DoorOpen = { "rbxassetid://6058561902" },
                DoorClose = { "rbxassetid://7038967181" }
            },
            Interact = {
                Collection = true,
                PourLoop = { "rbxassetid://14619425980" },
                Cork = { "rbxassetid://14619426084" }
            },
            cake_smash = { "rbxassetid://18928747611" },
            NoteHit = { "rbxassetid://8537782950" },
            NoteHit1 = { "rbxassetid://7714439701" },
            Duplicate = { "rbxassetid://2390695935" },
            TakeHit = { "rbxassetid://8595976174" },
            Swing = { "rbxassetid://6200114507" },
            Reward = { "rbxassetid://16248892614" },
            Reward_4th = { "rbxassetid://18102926134" },
            Reward_Ann = {
                "rbxassetid://18704939377",
                Volume = 2
            },
            Reward_Hallo = {
                "rbxassetid://121818320482055",
                Volume = 2
            },
            Reward1 = {
                "rbxassetid://135989379582225",
                Volume = 2
            },
            Reward2 = {
                "rbxassetid://124936280652938",
                Volume = 2
            },
            Reward3 = {
                "rbxassetid://99109952235770",
                Volume = 2
            },
            Reward4 = {
                "rbxassetid://103036021096481",
                Volume = 2
            },
            Launchloop = { "rbxassetid://18102760679" },
            Drumroll = { "rbxassetid://16248881993" },
            OpenAnn = {
                "rbxassetid://18730075954",
                Volume = 3
            },
            GainMoney = { "rbxassetid://307631257" },
            Impact = {
                "rbxassetid://14152221446",
                Volume = 3
            },
            Impact1 = {
                "rbxassetid://116754339756898",
                Volume = 2
            },
            Impact2 = {
                "rbxassetid://112235474977634",
                Volume = 2
            },
            Impact3 = {
                "rbxassetid://83278225163123",
                Volume = 2
            },
            PumpkinSmash = {
                "rbxassetid://79752831608669",
                Volume = 1
            },
            CutsceneSound = {
                "rbxassetid://136424526390589",
                Volume = 3
            },
            PassLoop = { "rbxassetid://14160516624" },
            DroneLoop = { "rbxassetid://14152136438" },
            PlaceSound = { "rbxassetid://9119927635" },
            PlasticPlaceSound = { "rbxassetid://18494353290" },
            GenericPlaceSound = { "rbxassetid://17737172473" },
            MetalTrayPlaceSound = { "rbxassetid://17737172740" },
            MetalPlaceSound = { "rbxassetid://17737172895" },
            CutePlace = { "rbxassetid://132960621113149" },
            ApartmentKnock = { "rbxassetid://17750152063" },
            Purchase = { "rbxassetid://18310424832" },
            ShakingSound = { "" },
            DrownWater = { "rbxassetid://18400296645" },
            DoorHalloIdent = { "rbxassetid://129863596833220" },
            HalloIdent = { "rbxassetid://121634539210566" },
            ChristmasIdent = { "rbxassetid://114495000562969" },
            LNYIdent = { "rbxassetid://106976303593296" },
            OpeningEpic = {
                "rbxassetid://116682529504154",
                Volume = 2,
                Pos = 0.1999999
            },
            OpeningCommon = {
                "rbxassetid://130755511868988",
                Volume = 2
            },
            OpeningRare = {
                "rbxassetid://89066951224166",
                Volume = 2,
                Pos = 0.1999999
            },
            OpeningLegend = {
                "rbxassetid://134453274456603",
                Volume = 2,
                Pos = 0.1999999
            },
            OpeningLoop = { "rbxassetid://114021281179839" },
            PourSound = {
                "rbxassetid://9117865991",
                Volume = 1
            },
            IceSound = {
                "rbxassetid://9125611419",
                Volume = 0.5
            },
            PageTurn = { "rbxassetid://14111527109" },
            InteractProcess = {
                "rbxassetid://14115141066",
                Volume = 10
            },
            Test_Step = { "rbxassetid://11648301930" },
            Door = {
                Collection = true,
                Metal = {
                    Open = { "rbxassetid://833871080" },
                    Shut = {
                        Volume = 10,
                        "rbxassetid://11689555345"
                    }
                }
            }
        },
        Music = {}
    },
    Tracks = {
        SFX = {
            Freezer_Ambience = {
                Stack = "Ambience",
                "rbxassetid://9059920026"
            },
            Aquarium_Ambience = {
                Stack = "Ambience",
                "rbxassetid://83938810594130"
            },
            Kitchen_Ambience = {
                Stack = "Ambience",
                "rbxassetid://70431112158559"
            },
            Outdoor_Ambience = {
                Stack = "Ambience",
                "rbxassetid://8935604268",
                Volume = 0.6
            },
            Beach_Ambience = {
                Stack = "Ambience",
                "rbxassetid://8935604268"
            },
            Indoor_Ambience = {
                Stack = "Ambience",
                "rbxassetid://9112777914"
            },
            Stage_Ambience = {
                Stack = "Ambience",
                "rbxassetid://9112795571"
            },
            Street_Ambience = {
                Stack = "Ambience",
                "rbxassetid://9112819974"
            },
            Creepy_Sewer_Ambience = {
                Stack = "Ambience",
                "rbxassetid://17569540396"
            },
            Demon_Ambience = {
                Stack = "Ambience",
                "rbxassetid://17802779909"
            },
            Front_Street_Ambience = {
                Volume = 1.2,
                Stack = "Ambience",
                "rbxassetid://9112758242"
            },
            Windy_Forest_Ambience = {
                Volume = 0.5,
                Stack = "Ambience",
                "rbxassetid://17724680260"
            },
            Spooky_Nights_Ambience = {
                Volume = 1,
                Stack = "Ambience",
                "rbxassetid://138744933990988"
            },
            Eerie_Inside = {
                Volume = 1.5,
                Stack = "Ambience",
                "rbxassetid://9112775175"
            }
        },
        Music = {
            No_Music = {
                Stack = "Music",
                ""
            },
            Void = {
                Stack = "Music",
                "rbxassetid://9114228774",
                Volume = 10,
                Random = true
            },
            America_Music = {
                Stack = "Music",
                "rbxassetid://1842306389"
            },
            America_Machine_Music = {
                Stack = "Music",
                "rbxassetid://1846108665"
            },
            AngelicRoom = {
                Stack = "Music",
                "rbxassetid://1846115737"
            },
            Aquarium_Music = {
                Stack = "Music",
                "rbxassetid://126599245416722",
                "rbxassetid://9046485852",
                "rbxassetid://1848349730",
                "rbxassetid://1848344513",
                "rbxassetid://1839253648",
                "rbxassetid://1844643643",
                "rbxassetid://1847688899",
                "rbxassetid://1846427613",
                "rbxassetid://1836590238",
                "rbxassetid://88667473397587",
                "rbxassetid://1839251997",
                "rbxassetid://88297902923363",
                "rbxassetid://1840020965",
                "rbxassetid://10984652943",
                "rbxassetid://1836603892",
                "rbxassetid://1845896038",
                Random = true
            },
            Ann_Music = { "rbxassetid://1837383968" },
            Clanky_Cafe_Ambience = {
                Stack = "Music",
                "rbxassetid://9112861913"
            },
            Lunar_New_Year = {
                Stack = "Music",
                "rbxassetid://16293380451",
                Volume = 0.35
            },
            Lunar_New_Year_2 = {
                Stack = "Music",
                "rbxassetid://16321895590"
            },
            Lunar_New_Year_3 = {
                Stack = "Music",
                "rbxassetid://112791421711483"
            },
            Cafe_Music = {
                Stack = "Music",
                "rbxassetid://9044702111",
                "rbxassetid://1836403222",
                "rbxassetid://1836423465",
                "rbxassetid://1839541943",
                "rbxassetid://1837652711",
                "rbxassetid://1842243708",
                "rbxassetid://1835768381",
                Random = true
            },
            Store_Music = {
                Stack = "Music",
                "rbxassetid://16837277211",
                Volume = 0.5
            },
            Match_Music = {
                Stack = "Music",
                "rbxassetid://1846929720"
            },
            Whim_Music = {
                Stack = "Music",
                "rbxassetid://14667008887",
                Random = true
            },
            Rooftop_Music = {
                Stack = "Music",
                "rbxassetid://1840384241",
                "rbxassetid://1846271583",
                Random = true
            },
            Bathroom_Music = {
                Stack = "Music",
                "rbxassetid://1842000022",
                "rbxassetid://1837070127",
                "rbxassetid://1839131582",
                Random = true
            },
            Lobby_Music = {
                Stack = "Music",
                "rbxassetid://1841998846",
                "rbxassetid://1841999462",
                Random = true
            },
            Dues_Music = {
                Stack = "Music",
                "rbxassetid://1840361538"
            },
            WhimCo_Music = {
                Stack = "Music",
                "rbxassetid://9045766377",
                "rbxassetid://1848056295",
                Random = true
            },
            Bryans_Music = {
                Stack = "Music",
                "rbxassetid://1841999462",
                "rbxassetid://1848354536",
                "rbxassetid://1840434123",
                "rbxassetid://1841984324",
                "rbxassetid://1836759260",
                "rbxassetid://1836393197",
                Random = true
            },
            Indoor_Music = {
                Stack = "Music",
                "rbxassetid://9039953638",
                "rbxassetid://6990352365",
                "rbxassetid://1845746752",
                "rbxassetid://1843640051",
                "rbxassetid://1841979451",
                "rbxassetid://1845341094",
                "rbxassetid://1846575559",
                "rbxassetid://1839198161",
                "rbxassetid://9040290078",
                "rbxassetid://1836684482",
                "rbxassetid://1842179755",
                "rbxassetid://1840434123",
                "rbxassetid://1841997885",
                "rbxassetid://1838857104",
                "rbxassetid://1841984324",
                "rbxassetid://1836378522",
                "rbxassetid://1835491978",
                "rbxassetid://1846722852",
                "rbxassetid://1846722574",
                "rbxassetid://1845767380",
                "rbxassetid://1843640056",
                "rbxassetid://1839007892",
                "rbxassetid://1842211582",
                "rbxassetid://1840746125",
                "rbxassetid://1839541748",
                Random = true
            },
            Outdoor_Music_Christmas = {
                Stack = "Music",
                "rbxassetid://108255996635120"
            },
            Indoor_Music_Christmas = {
                Stack = "Music",
                "rbxassetid://91673475640975",
                "rbxassetid://121662801676103",
                "rbxassetid://106820224183262",
                "rbxassetid://115237123239887",
                "rbxassetid://137628069777484",
                "rbxassetid://102138072789917",
                "rbxassetid://123858070737357",
                "rbxassetid://107655669269214",
                "rbxassetid://120395454157490",
                "rbxassetid://91673475640975",
                "rbxassetid://99092467579041",
                "rbxassetid://85182372203080",
                "rbxassetid://115487194142549",
                "rbxassetid://107655669269214",
                "rbxassetid://132529651124570",
                "rbxassetid://90054995336798",
                "rbxassetid://116604074063477",
                "rbxassetid://108075879445608",
                "rbxassetid://1847752855",
                "rbxassetid://9041991915",
                "rbxassetid://1836827964",
                "rbxassetid://1846560199",
                "rbxassetid://1837788612",
                "rbxassetid://9047112820",
                "rbxassetid://1837788847",
                Random = true
            },
            New_Years = {
                Stack = "Music",
                "rbxassetid://1839161311"
            },
            Tiki_Music = {
                Stack = "Music",
                "rbxassetid://1840457830",
                "rbxassetid://1845662428",
                "rbxassetid://1839198616",
                "rbxassetid://9047134387",
                "rbxassetid://1839199294",
                "rbxassetid://1838888581",
                "rbxassetid://14307599280",
                "rbxassetid://9047434837",
                "rbxassetid://1838888607",
                "rbxassetid://1835509611",
                "rbxassetid://1841922709",
                "rbxassetid://1839555210",
                "rbxassetid://1839638511",
                "rbxassetid://1835539094",
                "rbxassetid://1835539094",
                "rbxassetid://9044518495",
                Random = true
            },
            Audio_Tour_Back_Music = {
                Stack = "Music",
                Volume = 1.5,
                "rbxassetid://18194094697"
            },
            Super_Happy_Fun_Music = {
                Stack = "Music",
                "rbxassetid://6920070423",
                Random = true
            },
            Halloween_Music = {
                Stack = "Music",
                "rbxassetid://104900117855024",
                Random = true
            },
            BarGrill_Music = {
                Stack = "Music",
                "rbxassetid://9038890737",
                "rbxassetid://9046663211",
                "rbxassetid://1840459757",
                "rbxassetid://1837050615",
                "rbxassetid://1836054144",
                "rbxassetid://1840593674",
                "rbxassetid://1842143512",
                "rbxassetid://1836071364",
                Random = true
            },
            Secret_Music = {
                Stack = "Music",
                "rbxassetid://9044565954",
                "rbxassetid://9047105533",
                "rbxassetid://9047104919",
                "rbxassetid://9046864934",
                "rbxassetid://9047104752",
                "rbxassetid://9039767669",
                "rbxassetid://9046863864",
                "rbxassetid://9047106758",
                "rbxassetid://9039771403",
                "rbxassetid://9039771838",
                "rbxassetid://9039767821",
                "rbxassetid://9039767824",
                Random = true
            },
            Mystic_Cave_Music = {
                Stack = "Music",
                "rbxassetid://1844634116",
                "rbxassetid://1837209250",
                "rbxassetid://1847703955",
                Volume = 2,
                Random = true
            },
            Inty_Minigame = {
                Stack = "Music",
                "rbxassetid://101143908539323"
            },
            Boss_Music = {
                Stack = "Music",
                "rbxassetid://136148598245888",
                Volume = 2.5
            },
            Boss_Music_Phase_2 = {
                Stack = "Music",
                "rbxassetid://123118520414966",
                Volume = 2.5
            }
        }
    }
};
