-- Decompiled from: ReplicatedStorage.Config.Shared.HolidayConfigure
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    CHANGE_ME_TO_RESET_HOLIDAY_DATA = "EasterNza20265",
    USE_ALT_LOOTCONFIRM = false,
    DAILY_REWARDS_ENABLED = false,
    EVENT_KEYS_ENABLED = false,
    EVENT_CURRENCY_ENABLED = false,
    DAILY_REWARD_NAME = "Lunar New Years Login",
    EVENT_LOOBOX_WOULD_LIKE = "Would you like to open a capsule?",
    EVENT_OPENING_METHOD = "StartPresentOpening",
    EVENT_CURRENCY_NAME = "Tokens",
    EVENT_BOX_NAME = "Present",
    EVENT_CURRENCY_ICON = "rbxassetid://16238550928",
    EVENT_CURRENCY_COLORSEQUENCE = ColorSequence.new(Color3.new(0.988235, 0, 0.0156863)),
    ALT_CURRENCY = {
        EVENT_CURRENCY_NAME = "Gatcha Keys",
        EVENT_CURRENCY_ICON = "rbxassetid://112749037896669",
        EVENT_CURRENCY_COLORSEQUENCE = ColorSequence.new(Color3.new(1, 0.635294, 0))
    },
    VOICELINES = {
        GATCHA_GET = {
            "ANN24Gain1",
            "ANN24Gain2",
            "ANN24Gain3",
            "ANN24Gain4",
            "ANN24Gain5",
            "ANN24Gain6"
        }
    },
    SHOW_EVENT_LOOTBOX = false,
    BUY_LOOTBOX_TITLE = "LNW 2025 Rewind",
    BUYLOOTBOXID = "LNW2025Rewind",
    EVENT_CONVERT_ENABLED = false,
    EVENT_CONVERT = {
        { 500, 2000 },
        { 1000, 4000 },
        { 5000, 10000 }
    },
    EVENT_SPECIFIC_MODULES = false,
    EVENT_SEQUENCE = {
        ENABLED = false,
        START = 0
    },
    EVENT_MODULE = "BoatEvent"
};
