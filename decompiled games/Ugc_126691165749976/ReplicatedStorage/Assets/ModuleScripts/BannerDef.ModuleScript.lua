-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.BannerDef
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__CEnum__1 = require(script.Parent.CEnum);
local v1 = {};
local v2 = {
    Uncommon = 0.649,
    Rare = 0.29,
    Elite = 0.05,
    Exotic = 0.01,
    Classified = 0.001
};
local v3 = {
    skin_banner = v2,
    test_banner = {
        Uncommon = 0.001,
        Rare = 0.001,
        Elite = 0.001,
        Exotic = 0.49700000000000005,
        Classified = 0.5
    },
    classified_rigged = {
        studio_only = true,
        display_probabilities = v2,
        roll_probabilities = {
            Classified = 1
        }
    }
};
v1.DEFAULT_PROBABILITIES = v3;
local v4 = {
    Uncommon = 25000,
    Rare = 75000,
    Elite = 200000,
    Classified = 750000
};
v1.defs = {
    precede_2026 = {
        id = "precede_2026",
        banner_type = "random",
        display_name = "PRECEDE ALL",
        banner_image = "rbxassetid://117245150532363",
        kind = "LIMITED TIME SKIN SERIES",
        description = "",
        priority = 5,
        starts_at = 0,
        ends_at = 1783717200,
        crimson_price = 150,
        yen_price = 10000000,
        yen_buyable = false,
        duplicate_title_refunds = v4,
        probabilities = v3.skin_banner,
        pool = {
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.MON_WinterTroop
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.CAS_Goldrose
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.PHX_HeavyDuty
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.PHX_Zealot
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.SIE_Afterburn
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.Glass
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.Jetstream
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.AwpVanilla
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.UniverseDestroyer
            },
            {
                grant_type = "skin",
                weight = 1,
                id = l__CEnum__1.Skins.Inheritor
            }
        }
    },
    darkness_2026 = {
        id = "darkness_2026",
        banner_type = "direct_purchase",
        product_id = 3604072434,
        gift_product_id = 3604076018,
        display_name = "NIHILITY",
        banner_image = "rbxassetid://130955405474808",
        kind = "DIRECT PURCHASE SKIN",
        description = "",
        priority = 4,
        starts_at = 0,
        ends_at = 1783717200,
        duplicate_title_refunds = v4,
        items = {
            {
                grant_type = "skin",
                id = l__CEnum__1.Skins.Darkness
            }
        }
    }
};
return v1;
