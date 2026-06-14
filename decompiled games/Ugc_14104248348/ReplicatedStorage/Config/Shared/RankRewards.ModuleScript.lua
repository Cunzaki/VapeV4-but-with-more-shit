-- Decompiled from: ReplicatedStorage.Config.Shared.RankRewards
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Noted = {
        Single = {
            {
                ID = "Single_Noted_1",
                Type = "Coins",
                Value = 500
            },
            {
                ID = "SINGLE_Noted_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Noted"
            }
        },
        Timed = {
            {
                ID = "TIMED_NOTED1_1",
                Type = "Coins",
                Value = 250,
                TimeOut = 604800
            }
        }
    },
    Influencer = {
        Single = {
            {
                ID = "Single_INFL_1",
                Type = "Coins",
                Value = 1500
            },
            {
                ID = "SINGLE_Influencer_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Influencer"
            }
        },
        Timed = {
            {
                ID = "TIMED_INFL1_1",
                Type = "Coins",
                Value = 1000,
                TimeOut = 604800
            }
        }
    },
    ["QA Tester"] = {
        Single = {
            {
                ID = "Single_QA_1",
                Type = "Coins",
                Value = 3000
            },
            {
                ID = "SINGLE_QA Tester_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.QA Tester"
            }
        },
        Timed = {
            {
                ID = "TIMED_QA1_1",
                Type = "Coins",
                Value = 2000,
                TimeOut = 604800
            }
        }
    },
    Contributor = {
        Single = {
            {
                ID = "Single_Contributor1_1",
                Type = "Coins",
                Value = 3000
            },
            {
                ID = "SINGLE_Contributor_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Contributor"
            }
        },
        Timed = {
            {
                ID = "TIMED_Contributor1_1",
                Type = "Coins",
                Value = 1000,
                TimeOut = 604800
            }
        }
    },
    ["Event Team"] = {
        Single = {
            {
                ID = "Single_EventTeam1_1",
                Type = "Coins",
                Value = 3000
            },
            {
                ID = "SINGLE_EventTeam_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Event Team"
            }
        },
        Timed = {
            {
                ID = "TIMED_EventTeam1_1",
                Type = "Coins",
                Value = 300,
                TimeOut = 604800
            }
        }
    },
    ["Event Host"] = {
        Single = {
            {
                ID = "Single_EventHost1_1",
                Type = "Coins",
                Value = 3000
            },
            {
                ID = "SINGLE_EventHost_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Event Host"
            }
        },
        Timed = {
            {
                ID = "TIMED_EventHost1_1",
                Type = "Coins",
                Value = 1000,
                TimeOut = 604800
            }
        }
    },
    Security = {
        Single = {
            {
                ID = "Single_SECURITY1_1",
                Type = "Coins",
                Value = 3000
            },
            {
                ID = "SINGLE_Security_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Security"
            }
        },
        Timed = {
            {
                ID = "TIMED_SECURITY1_1",
                Type = "Coins",
                Value = 1000,
                TimeOut = 604800
            }
        }
    },
    Moderator = {
        Single = {
            {
                ID = "Single_Moderator1_1",
                Type = "Coins",
                Value = 3000
            },
            {
                ID = "SINGLE_Moderator_ROLE_1",
                Type = "InventoryItem",
                Value = "Emoji.Moderator"
            }
        },
        Timed = {
            {
                ID = "TIMED_Moderator1_1",
                Type = "Coins",
                Value = 1000,
                TimeOut = 604800
            }
        }
    },
    ["QA Coordinator"] = {
        Copies = "QA Tester"
    },
    ["Senior Security"] = {
        Copies = "Security"
    },
    Manager = {
        Copies = "Security"
    },
    Whimsical = {
        Copies = "Influencer"
    },
    FouledAnchors = {
        Copies = "Influencer"
    },
    Owner = {
        Copies = "Influencer"
    }
};
