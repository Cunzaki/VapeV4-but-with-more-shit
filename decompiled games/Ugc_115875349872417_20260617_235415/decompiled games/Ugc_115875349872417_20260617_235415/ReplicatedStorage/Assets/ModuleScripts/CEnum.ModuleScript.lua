-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.CEnum
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local u1 = {
    Titles = {
        Prospect = 1,
        Freelancer = 2,
        Professional = 3,
        Elite = 4,
        Menace = 5,
        Eminence = 6,
        FLATLINER = 7,
        Rookie = 8,
        Breakliner = 9,
        TripleDreamer = 10,
        Phightliner = 11,
        Primordial = 12,
        Contributor = 13,
        Owner = 14,
        Tester = 15,
        ContentCreator = 16,
        Samovar = 17,
        Necromancer = 18,
        Thunder = 19,
        Infamous = 20
    },
    Skins = {
        Default = 1,
        Jetstream = 2,
        TestClassified = 3,
        TestUncommon = 4,
        TestRare = 5,
        TestExotic = 6,
        Darkness = 7,
        UniverseDestroyer = 8,
        Glass = 9,
        TypeCC = 10,
        Tester = 11,
        Inheritor = 12,
        AwpVanilla = 13,
        PHX_HeavyDuty = 14,
        SIE_Afterburn = 15,
        MON_WinterTroop = 16,
        PHX_Zealot = 17,
        CAS_Goldrose = 18,
        Morningstar = 19
    },
    Marks = {
        DontShowTutorial = 1,
        TutorialCompleted = 2,
        TutorialRewarded = 3
    },
    TriggerContexts = {
        onKill = 1,
        onMenuOpen = 2,
        onLevelUp = 3,
        onLoaded = 4
    },
    InputImageIds = {
        [Enum.KeyCode.Z] = "rbxassetid://100309983461491",
        [Enum.KeyCode.Y] = "rbxassetid://91167850332089",
        [Enum.KeyCode.X] = "rbxassetid://117974683046479",
        [Enum.KeyCode.W] = "rbxassetid://94469000982589",
        [Enum.KeyCode.V] = "rbxassetid://71841489901733",
        [Enum.KeyCode.Up] = "rbxassetid://73837995148164",
        [Enum.KeyCode.U] = "rbxassetid://85324341498561",
        [Enum.KeyCode.Tilde] = "rbxassetid://98588600948290",
        [Enum.KeyCode.Tab] = "rbxassetid://98080675123455",
        [Enum.KeyCode.T] = "rbxassetid://115986711194219",
        [Enum.KeyCode.Space] = "rbxassetid://111498508421680",
        [Enum.KeyCode.Slash] = "rbxassetid://106313421419407",
        [Enum.KeyCode.LeftShift] = "rbxassetid://79334652442400",
        [Enum.KeyCode.RightShift] = "rbxassetid://138704293117599",
        [Enum.KeyCode.Semicolon] = "rbxassetid://115571540021261",
        [Enum.KeyCode.S] = "rbxassetid://97757349161062",
        [Enum.KeyCode.Right] = "rbxassetid://128234800101973",
        [Enum.KeyCode.R] = "rbxassetid://90116032374830",
        [Enum.KeyCode.Quote] = "rbxassetid://75405080464571",
        [Enum.KeyCode.QuotedDouble] = "rbxassetid://75405080464571",
        [Enum.KeyCode.Backquote] = "rbxassetid://98588600948290",
        [Enum.KeyCode.Question] = "rbxassetid://103590145056557",
        [Enum.KeyCode.Q] = "rbxassetid://139450533033360",
        [Enum.KeyCode.Print] = "rbxassetid://119113392490629",
        [Enum.KeyCode.KeypadPlus] = "rbxassetid://93635603457460",
        [Enum.KeyCode.Plus] = "rbxassetid://88926422923351",
        [Enum.KeyCode.PageUp] = "rbxassetid://84549691858626",
        [Enum.KeyCode.PageDown] = "rbxassetid://121568264576850",
        [Enum.KeyCode.P] = "rbxassetid://98258607764259",
        [Enum.KeyCode.O] = "rbxassetid://87287247244611",
        [Enum.KeyCode.NumLock] = "rbxassetid://114955534180913",
        [Enum.KeyCode.N] = "rbxassetid://74439226501236",
        [Enum.UserInputType.MouseMovement] = "rbxassetid://86825077823555",
        [Enum.UserInputType.MouseWheel] = "rbxassetid://128434787170410",
        [Enum.UserInputType.MouseButton2] = "rbxassetid://113880087457361",
        [Enum.UserInputType.MouseButton3] = "rbxassetid://82328464182938",
        [Enum.UserInputType.MouseButton1] = "rbxassetid://138086626429916",
        [Enum.KeyCode.Minus] = "rbxassetid://94893110866483",
        [Enum.KeyCode.M] = "rbxassetid://78110270180122",
        [Enum.KeyCode.Left] = "rbxassetid://101200901084544",
        [Enum.KeyCode.L] = "rbxassetid://129098652092151",
        [Enum.KeyCode.Comma] = "rbxassetid://139426750273974",
        [Enum.KeyCode.Period] = "rbxassetid://76508809020750",
        [Enum.KeyCode.K] = "rbxassetid://95948318021126",
        [Enum.KeyCode.J] = "rbxassetid://72080488138432",
        [Enum.KeyCode.Insert] = "rbxassetid://101509744586500",
        [Enum.KeyCode.I] = "rbxassetid://101875033984479",
        [Enum.KeyCode.Home] = "rbxassetid://70744967067959",
        [Enum.KeyCode.H] = "rbxassetid://104514880185345",
        [Enum.KeyCode.G] = "rbxassetid://133347784394181",
        [Enum.KeyCode.F12] = "rbxassetid://121814047433269",
        [Enum.KeyCode.F11] = "rbxassetid://139832943261091",
        [Enum.KeyCode.F10] = "rbxassetid://103114763211606",
        [Enum.KeyCode.F9] = "rbxassetid://76025381252901",
        [Enum.KeyCode.F8] = "rbxassetid://124130776489602",
        [Enum.KeyCode.F7] = "rbxassetid://86968635757175",
        [Enum.KeyCode.F6] = "rbxassetid://138813239031580",
        [Enum.KeyCode.F5] = "rbxassetid://83694654983698",
        [Enum.KeyCode.F4] = "rbxassetid://106883058650275",
        [Enum.KeyCode.F3] = "rbxassetid://74129489537896",
        [Enum.KeyCode.F2] = "rbxassetid://133035723171313",
        [Enum.KeyCode.F1] = "rbxassetid://78064340006547",
        [Enum.KeyCode.F] = "rbxassetid://133123643281009",
        [Enum.KeyCode.Escape] = "rbxassetid://93123540720686",
        [Enum.KeyCode.Return] = "rbxassetid://139303822072580",
        [Enum.KeyCode.End] = "rbxassetid://88431783651195",
        [Enum.KeyCode.E] = "rbxassetid://134052654789298",
        [Enum.KeyCode.Down] = "rbxassetid://121658555817725",
        [Enum.KeyCode.Delete] = "rbxassetid://93057915703011",
        [Enum.KeyCode.D] = "rbxassetid://134008739705922",
        [Enum.KeyCode.LeftControl] = "rbxassetid://117735271814278",
        [Enum.KeyCode.RightControl] = "rbxassetid://117735271814278",
        [Enum.KeyCode.CapsLock] = "rbxassetid://101942346716011",
        [Enum.KeyCode.C] = "rbxassetid://107446861430768",
        [Enum.KeyCode.RightBracket] = "rbxassetid://132617939369259",
        [Enum.KeyCode.LeftBracket] = "rbxassetid://71505370549378",
        [Enum.KeyCode.Backspace] = "rbxassetid://89531719088924",
        [Enum.KeyCode.B] = "rbxassetid://103962036108621",
        [Enum.KeyCode.Asterisk] = "rbxassetid://128964649924822",
        [Enum.KeyCode.LeftAlt] = "rbxassetid://93029840572229",
        [Enum.KeyCode.RightAlt] = "rbxassetid://93029840572229",
        [Enum.KeyCode.A] = "rbxassetid://96345724854899",
        [Enum.KeyCode.Nine] = "rbxassetid://137682176276662",
        [Enum.KeyCode.Eight] = "rbxassetid://80237181682033",
        [Enum.KeyCode.Seven] = "rbxassetid://101055125639712",
        [Enum.KeyCode.Six] = "rbxassetid://118707429331851",
        [Enum.KeyCode.Five] = "rbxassetid://127269122703285",
        [Enum.KeyCode.Four] = "rbxassetid://114227780047720",
        [Enum.KeyCode.Three] = "rbxassetid://93141846008872",
        [Enum.KeyCode.Two] = "rbxassetid://98289677420396",
        [Enum.KeyCode.One] = "rbxassetid://98642728893480",
        [Enum.KeyCode.Zero] = "rbxassetid://111123555106903"
    },
    InteractTypes = {
        proximityInput = 1,
        proximityAuto = 2
    }
};
local v2 = {
    FFA_PLACE = 124701379012361,
    MATCH_PLACE = 99081150385957,
    MAIN_PLACE = 95708762824131
};
u1.PlaceIds = (game.GameId == 7265339759 or not v2) and {
    FFA_PLACE = 115875349872417,
    MATCH_PLACE = 126691165749976,
    MAIN_PLACE = 94987506187454
} or v2;
u1.ProductIds = {
    SUPPORT_10 = 3525890762,
    SUPPORT_100 = 3525891061,
    SUPPORT_250 = 3525931196,
    SUPPORT_500 = 3525891656,
    SUPPORT_1000 = 3525892244,
    SUPPORT_5000 = 3525892625,
    SUPPORT_10000 = 3525893105,
    SUPPORT_30000 = 3525893445,
    CRIMSON_MICRO = 3603087604,
    CRIMSON_SMALL = 3603087640,
    CRIMSON_MEDIUM = 3603087834,
    CRIMSON_LARGE = 3603087921,
    CRIMSON_MEGA = 3603087999,
    CRIMSON_ULTRA = 3603088033,
    GIFT_CRIMSON_MICRO = 3603088068,
    GIFT_CRIMSON_SMALL = 3603088141,
    GIFT_CRIMSON_MEDIUM = 3603088207,
    GIFT_CRIMSON_LARGE = 3603088241,
    GIFT_CRIMSON_MEGA = 3603088306,
    GIFT_CRIMSON_ULTRA = 3603088360
};
local v3 = {
    {
        name = "SUPPORT_10",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_10,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_100",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_100,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_250",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_250,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_500",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_500,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_1000",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_1000,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_5000",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_5000,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_10000",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_10000,
        fulfillment_data = {}
    },
    {
        name = "SUPPORT_30000",
        fulfillment_kind = "support",
        transferable = false,
        product_id = u1.ProductIds.SUPPORT_30000,
        fulfillment_data = {}
    },
    {
        name = "CRIMSON_MICRO",
        fulfillment_kind = "crimson",
        transferable = false,
        product_id = u1.ProductIds.CRIMSON_MICRO,
        fulfillment_data = {
            amount = 180
        }
    },
    {
        name = "CRIMSON_SMALL",
        fulfillment_kind = "crimson",
        transferable = false,
        product_id = u1.ProductIds.CRIMSON_SMALL,
        fulfillment_data = {
            amount = 390
        }
    },
    {
        name = "CRIMSON_MEDIUM",
        fulfillment_kind = "crimson",
        transferable = false,
        product_id = u1.ProductIds.CRIMSON_MEDIUM,
        fulfillment_data = {
            amount = 1000
        }
    },
    {
        name = "CRIMSON_LARGE",
        fulfillment_kind = "crimson",
        transferable = false,
        product_id = u1.ProductIds.CRIMSON_LARGE,
        fulfillment_data = {
            amount = 3150
        }
    },
    {
        name = "CRIMSON_MEGA",
        fulfillment_kind = "crimson",
        transferable = false,
        product_id = u1.ProductIds.CRIMSON_MEGA,
        fulfillment_data = {
            amount = 9000
        }
    },
    {
        name = "CRIMSON_ULTRA",
        fulfillment_kind = "crimson",
        transferable = false,
        product_id = u1.ProductIds.CRIMSON_ULTRA,
        fulfillment_data = {
            amount = 27000
        }
    },
    {
        name = "GIFT_CRIMSON_MICRO",
        fulfillment_kind = "crimson",
        transferable = true,
        product_id = u1.ProductIds.GIFT_CRIMSON_MICRO,
        fulfillment_data = {
            amount = 180
        }
    },
    {
        name = "GIFT_CRIMSON_SMALL",
        fulfillment_kind = "crimson",
        transferable = true,
        product_id = u1.ProductIds.GIFT_CRIMSON_SMALL,
        fulfillment_data = {
            amount = 390
        }
    },
    {
        name = "GIFT_CRIMSON_MEDIUM",
        fulfillment_kind = "crimson",
        transferable = true,
        product_id = u1.ProductIds.GIFT_CRIMSON_MEDIUM,
        fulfillment_data = {
            amount = 1000
        }
    },
    {
        name = "GIFT_CRIMSON_LARGE",
        fulfillment_kind = "crimson",
        transferable = true,
        product_id = u1.ProductIds.GIFT_CRIMSON_LARGE,
        fulfillment_data = {
            amount = 3150
        }
    },
    {
        name = "GIFT_CRIMSON_MEGA",
        fulfillment_kind = "crimson",
        transferable = true,
        product_id = u1.ProductIds.GIFT_CRIMSON_MEGA,
        fulfillment_data = {
            amount = 9000
        }
    },
    {
        name = "GIFT_CRIMSON_ULTRA",
        fulfillment_kind = "crimson",
        transferable = true,
        product_id = u1.ProductIds.GIFT_CRIMSON_ULTRA,
        fulfillment_data = {
            amount = 27000
        }
    }
};
u1.DevProductEntitlements = {};
for _, v4 in v3 do
    if u1.DevProductEntitlements[v4.product_id] then
        error((`Duplicate ProductId in receipt entitlement registry: {v4.name} ({v4.product_id})`));
    end;
    u1.DevProductEntitlements[v4.product_id] = {
        name = v4.name,
        fulfillment_kind = v4.fulfillment_kind,
        fulfillment_data = v4.fulfillment_data,
        transferable = v4.transferable
    };
end;
u1.MessageTypes = {
    MatchLeave = 1,
    JoinedModSlot = 2,
    DevProductTransfer = 3,
    DevProductTransferRejected = 4
};
u1.Maps = {
    Glitch = 1,
    Arc = 2,
    Greenscreen = 3,
    Tutorial = 4,
    Metro = 5,
    Station = 6,
    Highrise = 7,
    Kabuki = 10,
    TrainingV1 = 11
};
u1.Queues = {
    Duels1v1 = 1,
    Wingman2v2 = 2
};
u1.Gamemodes = {
    Stocks1v1 = 1,
    Stocks2v2 = 2,
    Tutorial = 3,
    Training = 4
};
u1.PingData = {
    Good = {
        threshold = 90,
        color = Color3.fromRGB(0, 255, 0)
    },
    Normal = {
        threshold = 150,
        color = Color3.fromRGB(255, 255, 0)
    },
    Bad = {
        threshold = 210,
        color = Color3.fromRGB(255, 0, 0)
    }
};
local u5 = {
    {
        key = "Good",
        data = u1.PingData.Good
    },
    {
        key = "Normal",
        data = u1.PingData.Normal
    },
    {
        key = "Bad",
        data = u1.PingData.Bad
    }
};
local u6 = {};
for _, v7 in pairs(u1) do
    local v8 = {};
    u6[v7] = v8;
    for v9, v10 in pairs(v7) do
        if typeof(v9) == "string" then
            v8[v10] = v9;
        end;
    end;
end;
function u1.GetPingData(p11) --[[ Line: 321 ]]
    -- upvalues: u5 (copy), u1 (copy)
    for _, v12 in u5 do
        if p11 <= v12.data.threshold then
            return v12.key, v12.data;
        end;
    end;
    return "Bad", u1.PingData.Bad;
end;
function u1.reverse(p13, p14) --[[ Line: 333 ]]
    -- upvalues: u6 (copy)
    local v15 = u6[p13];
    if not v15 then
        error("Provided table is not a valid enum table");
    end;
    return v15[p14];
end;
return u1;
