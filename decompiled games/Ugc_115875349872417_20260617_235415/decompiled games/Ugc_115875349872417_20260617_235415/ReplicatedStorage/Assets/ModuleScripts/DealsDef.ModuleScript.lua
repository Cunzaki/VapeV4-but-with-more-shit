-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.DealsDef
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Images__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Images);
local l__CEnum__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.CEnum);
local function v5(p1) --[[ Line: 3 ]]
    -- upvalues: l__Images__1 (copy)
    if not p1.product_id then
        error("NO product_id");
    end;
    if not p1.gift_product_id then
        error("NO gift_product_id");
    end;
    local v2 = {
        product_id = nil,
        gift_product_id = nil,
        crimson_amount = 0,
        shelf = 1,
        icon_scale = 1,
        gradient = false,
        popular = false,
        top_desc = "",
        bot_desc = "",
        icon = l__Images__1.Crimson
    };
    for v3, v4 in p1 do
        v2[v3] = v4;
    end;
    return v2;
end;
local u6 = {
    CrimsonOptions = {
        v5({
            crimson_amount = 180,
            shelf = 1,
            icon_scale = 0.7,
            top_desc = "180 Crimson",
            bot_desc = "",
            product_id = l__CEnum__2.ProductIds.CRIMSON_MICRO,
            gift_product_id = l__CEnum__2.ProductIds.GIFT_CRIMSON_MICRO
        }),
        v5({
            crimson_amount = 390,
            shelf = 1,
            icon_scale = 0.8,
            top_desc = "360 Crimson",
            bot_desc = "+30 Bonus Crimson",
            product_id = l__CEnum__2.ProductIds.CRIMSON_SMALL,
            gift_product_id = l__CEnum__2.ProductIds.GIFT_CRIMSON_SMALL
        }),
        v5({
            crimson_amount = 1000,
            shelf = 1,
            icon_scale = 0.9,
            top_desc = "900 Crimson",
            bot_desc = "+100 Bonus Crimson",
            product_id = l__CEnum__2.ProductIds.CRIMSON_MEDIUM,
            gift_product_id = l__CEnum__2.ProductIds.GIFT_CRIMSON_MEDIUM
        }),
        v5({
            crimson_amount = 3150,
            shelf = 2,
            icon_scale = 1,
            top_desc = "2700 Crimson",
            bot_desc = "+450 Bonus Crimson",
            product_id = l__CEnum__2.ProductIds.CRIMSON_LARGE,
            gift_product_id = l__CEnum__2.ProductIds.GIFT_CRIMSON_LARGE
        }),
        v5({
            crimson_amount = 9000,
            shelf = 2,
            icon_scale = 1.1,
            top_desc = "7200 Crimson",
            bot_desc = "+1800 Bonus Crimson.",
            product_id = l__CEnum__2.ProductIds.CRIMSON_MEGA,
            gift_product_id = l__CEnum__2.ProductIds.GIFT_CRIMSON_MEGA
        }),
        (v5({
            crimson_amount = 27000,
            shelf = 2,
            icon_scale = 1.2,
            gradient = true,
            top_desc = "20250 Crimson",
            bot_desc = "+6750 Bonus Crimson. Best value.",
            product_id = l__CEnum__2.ProductIds.CRIMSON_ULTRA,
            gift_product_id = l__CEnum__2.ProductIds.GIFT_CRIMSON_ULTRA
        }))
    }
};
function u6.getDefs(p7) --[[ Line: 102 ]]
    -- upvalues: u6 (copy)
    return u6[p7];
end;
return u6;
