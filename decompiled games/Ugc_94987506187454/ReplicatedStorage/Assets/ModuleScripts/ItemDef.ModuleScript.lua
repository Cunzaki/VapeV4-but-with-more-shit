-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.ItemDef
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local function v8(p1) --[[ Line: 37 ]]
    assert(p1.item_id, "Missing item_id");
    assert(p1.name, "Missing name");
    local v2 = {
        name = p1.name,
        item_id = p1.item_id,
        description = p1.description or "",
        flavor_description = p1.flavor_description or "",
        alias = p1.alias or "",
        tags = p1.tags or "",
        item_type = p1.item_type or "",
        stat_entries = {},
        yen_price = p1.yen_price or 1000,
        purchasable = p1.purchasable or false
    };
    if p1.stat_entries then
        for v3, v4 in ipairs(p1.stat_entries) do
            local v5 = v4[1];
            local v6 = v4[2];
            local v7 = v4[3];
            assert(v5, "stat_entry missing name at index " .. v3);
            assert(v6 ~= nil, "stat_entry missing value at index " .. v3);
            table.insert(v2.stat_entries, {
                stat_name = v5,
                stat_value = v6,
                fill_alpha = v7 or 0
            });
        end;
    end;
    return v2;
end;
local u9 = {
    defs = {
        Castigate = v8({
            name = "CASTIGATE",
            alias = "Magnum Revolver",
            item_id = "Castigate",
            description = "A gift.",
            flavor_description = "THERE IS NO JURY\n NO TIME TO THINK\n MASS BURIALS\n I AM LAW",
            tags = "SCAN AIM, ONE-HANDED",
            item_type = "gun",
            yen_price = 1000,
            purchasable = true,
            stat_entries = {
                { "ease_of_use", "EASY", 0.8 },
                { "damage", 60, 0.6 },
                { "draw_time", "0.75s", 0.5 },
                { "bullet_cost", "100H", 0.5 }
            }
        }),
        Phoenix = v8({
            name = "PHOENIX",
            alias = "Handheld Howitzer",
            item_id = "Phoenix",
            description = "(Thou shalt) repent.",
            flavor_description = "RISE\n SKY OPENS ITS MOUTH\n DEFENSES CRUMBLE\n I AM ABSOLUTE",
            tags = "PROJECTILE, EXPLOSIVE",
            item_type = "gun",
            yen_price = 450000,
            purchasable = true,
            stat_entries = {
                { "ease_of_use", "MEDIUM", 0.5 },
                { "explosion_damage", 70, 0.7 },
                { "direct_damage", 150, 1 },
                { "draw_time", "0.8s", 0.5 },
                { "bullet_cost", "150H", 0.75 }
            }
        }),
        Siege = v8({
            name = "SIEGE",
            alias = "Double-Barreled Shotgun",
            item_id = "Siege",
            description = "The only thing they fear is you.",
            flavor_description = "TWO SHOTS EXIT\n SPACE IS SEIZED\n MOVE\n I AM POWER",
            tags = "SPREAD, TWO-SHOT",
            item_type = "gun",
            yen_price = 2000000,
            purchasable = true,
            stat_entries = {
                { "ease_of_use", "MEDIUM", 0.5 },
                { "damage", "80-30", 0.8 },
                { "shots_per_draw", 2, 0.75 },
                { "draw_time", "1.1s", 0.7 },
                { "bullet_cost", "140H", 0.7 }
            }
        }),
        Monarch = v8({
            name = "MONARCH",
            alias = "Anti-Materiel Sniper",
            item_id = "Monarch",
            description = "Just like old times.",
            flavor_description = "ONE EYE OPENED\n TO APPOINT DEATH\n KNEEL\n I AM KING",
            tags = "SCOPED, WALLBANG",
            item_type = "gun",
            yen_price = 8000000,
            purchasable = true,
            stat_entries = {
                { "ease_of_use", "EXPERT", 0.05 },
                { "damage", 140, 0.95 },
                { "draw_time", "1.85s", 1 },
                { "bullet_cost", "200H", 1 }
            }
        }),
        Redliner = v8({
            name = "REDLINER",
            alias = "High-Velocity Blade",
            item_id = "Redliner",
            description = "9 years ago, you were there.",
            flavor_description = "",
            tags = "CROUCHED WIDESLASH",
            item_type = "melee",
            yen_price = 1000,
            purchasable = false,
            stat_entries = {
                { "ease_of_use", "EASY", 0.8 },
                { "damage", 20, 0.4 },
                { "heat_on_hit", "40H", 0.4 },
                { "heat_on_parry", "80H", 0.8 }
            }
        })
    }
};
function u9.getDefs() --[[ Line: 170 ]]
    -- upvalues: u9 (copy)
    return u9.defs;
end;
function u9.translateStatEntry(_, p10, p11, p12) --[[ Line: 174 ]]
    return typeof(p10) == "table" and {
        stat_name = p10[1],
        stat_value = p10[2],
        fill_alpha = p10[3] or 0
    } or {
        stat_name = p10,
        stat_value = p11,
        fill_alpha = p12 or 0
    };
end;
return u9;
