-- Decompiled from: ReplicatedStorage.Config.Shared.Quests
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    None = {
        Enabled = false
    },
    LNY25EventSetup = {
        Enabled = true,
        DefaultVoicelines = {
            BusyDefault = {
                "LNY25EvSBusy1",
                "LNY25EvSBusy2",
                "LNY25EvSBusy3",
                "LNY25EvSBusy4"
            }
        },
        {
            SubQuest = "FindBoxes",
            DelayUntilNext = 100,
            Voicelines = {
                IntroLines = { "LNY25EvSIntro1" },
                ResultYes = { "LNY25EvSResultYes" },
                ResultNo = { "LNY25EvSResultNo" },
                Busy = {
                    "LNY25EvSBusy1",
                    "LNY25EvSBusy2",
                    "LNY25EvSBusy3",
                    "LNY25EvSBusy4"
                },
                Complete = { "LNY25EvSComplete" }
            },
            Rewards = {
                {
                    Type = "Holiday",
                    Value = 2000
                }
            }
        }
    }
};
