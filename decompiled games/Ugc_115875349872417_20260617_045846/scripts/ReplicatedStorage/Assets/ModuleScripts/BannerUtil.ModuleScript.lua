-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.BannerUtil
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__BannerDef__2 = require(script.Parent.BannerDef);
local l__CEnum__3 = require(script.Parent.CEnum);
local l__SkinDefs__4 = require(script.Parent.SkinDefs);
local l__TitleData__5 = require(script.Parent.TitleData);
local u1 = {};
local u2 = l__RunService__1:IsStudio();
local function u7(p3) --[[ Line: 13 ]]
    -- upvalues: u7 (copy)
    if typeof(p3) ~= "table" then
        return p3;
    end;
    local v4 = {};
    for v5, v6 in pairs(p3) do
        v4[u7(v5)] = u7(v6);
    end;
    return v4;
end;
local function u27(p8, p9, p10) --[[ Line: 29 ]]
    -- upvalues: u27 (copy)
    local v11 = typeof(p8);
    if v11 == "string" or v11 == "boolean" then
        return p8, nil;
    elseif v11 == "number" then
        local v12;
        if p8 == p8 and p8 ~= (1 / 0) then
            v12 = p8 ~= (-1 / 0);
        else
            v12 = false;
        end;
        if v12 then
            return p8, nil;
        else
            return nil, "invalid_metadata_number";
        end;
    else
        if v11 ~= "table" then
            return nil, "invalid_metadata_value_type";
        end;
        if p10 > 8 then
            return nil, "metadata_too_deep";
        end;
        if p9[p8] == true then
            return nil, "cyclic_metadata";
        end;
        p9[p8] = true;
        local v13 = 0;
        local v14 = false;
        local v15 = 0;
        local v16 = false;
        for v17 in pairs(p8) do
            local v18 = typeof(v17);
            if v18 == "number" and (v17 >= 1 and v17 % 1 == 0) then
                v15 = math.max(v15, v17);
                v14 = true;
            else
                if v18 ~= "string" then
                    p9[p8] = nil;
                    return nil, "invalid_metadata_key_type";
                end;
                v16 = true;
            end;
            v13 = v13 + 1;
            if v14 and v16 then
                p9[p8] = nil;
                return nil, "mixed_metadata_keys";
            end;
        end;
        local v19 = {};
        if v14 then
            if v15 ~= v13 then
                p9[p8] = nil;
                return nil, "sparse_metadata_array";
            end;
            for v20 = 1, v15 do
                local v21, v22 = u27(p8[v20], p9, p10 + 1);
                if v22 then
                    p9[p8] = nil;
                    return nil, v22;
                end;
                v19[v20] = v21;
            end;
        else
            for v23, v24 in pairs(p8) do
                local v25, v26 = u27(v24, p9, p10 + 1);
                if v26 then
                    p9[p8] = nil;
                    return nil, v26;
                end;
                v19[v23] = v25;
            end;
        end;
        p9[p8] = nil;
        return v19, nil;
    end;
end;
local function u32(p28) --[[ Line: 122 ]]
    -- upvalues: l__TitleData__5 (copy), l__CEnum__3 (copy)
    local v29 = l__TitleData__5[p28];
    if typeof(v29) == "table" then
        if typeof(v29.static_text) == "string" and v29.static_text ~= "" then
            return v29.static_text;
        end;
        if typeof(v29.getText) == "function" then
            local v30, v31 = pcall(v29.getText);
            if v30 and (typeof(v31) == "string" and v31 ~= "") then
                return v31;
            end;
        end;
    end;
    return l__CEnum__3.reverse(l__CEnum__3.Titles, p28) or tostring(p28);
end;
local function u38(p33, p34) --[[ Line: 140 ]]
    if typeof(p33) ~= "table" or typeof(p34) ~= "table" then
        return false;
    end;
    for v35, v36 in pairs(p34) do
        if p33[v35] ~= v36 then
            return false;
        end;
    end;
    for v37 in pairs(p33) do
        if p34[v37] == nil then
            return false;
        end;
    end;
    return true;
end;
local function u50(p39) --[[ Line: 186 ]]
    -- upvalues: l__SkinDefs__4 (copy)
    local v40 = {};
    local v41 = 0;
    for v42, v43 in pairs(p39) do
        if typeof(v42) ~= "string" or (typeof(v43) ~= "number" or v43 <= 0) then
            return nil, "invalid_rarity_probability";
        end;
        if l__SkinDefs__4.RARITIES[v42] == nil then
            return nil, "unknown_rarity";
        end;
        table.insert(v40, {
            rarity = v42,
            weight = v43
        });
        v41 = v41 + 1;
    end;
    if v41 <= 0 then
        return nil, "empty_probabilities";
    end;
    table.sort(v40, function(p44, p45) --[[ Line: 209 ]]
        -- upvalues: l__SkinDefs__4 (ref)
        local v46 = l__SkinDefs__4.RARITIES[p44.rarity];
        local v47 = (typeof(v46) ~= "table" or typeof(v46.priority) ~= "number") and (1 / 0) or v46.priority;
        local v48 = l__SkinDefs__4.RARITIES[p45.rarity];
        local v49 = (typeof(v48) ~= "table" or typeof(v48.priority) ~= "number") and (1 / 0) or v48.priority;
        if v47 == v49 then
            return p44.rarity < p45.rarity;
        else
            return v47 < v49;
        end;
    end);
    return v40, nil;
end;
local function u61(p51) --[[ Line: 222 ]]
    local v52 = 0;
    for _, v53 in ipairs(p51.probabilities) do
        local v54 = p51.pool_by_rarity[v53.rarity];
        if typeof(v54) == "table" and #v54 > 0 then
            v52 = v52 + v53.weight;
        end;
    end;
    p51.rollable_rarity_weight = v52;
    p51.effective_rarity_probabilities = {};
    if v52 <= 0 then
    else
        for _, v55 in ipairs(p51.probabilities) do
            local v56 = p51.pool_by_rarity[v55.rarity];
            if typeof(v56) == "table" and #v56 > 0 then
                local v57 = v55.weight / v52;
                p51.effective_rarity_probabilities[v55.rarity] = v57;
                local v58 = 0;
                for _, v59 in ipairs(v56) do
                    v58 = v58 + v59.weight;
                end;
                if v58 > 0 then
                    for _, v60 in ipairs(v56) do
                        v60.effective_probability = v57 * (v60.weight / v58);
                    end;
                end;
            end;
        end;
    end;
end;
function u1.copyValue(p62) --[[ Line: 263 ]]
    -- upvalues: u7 (copy)
    return u7(p62);
end;
function u1.getRarityPriority(p63) --[[ Line: 267 ]]
    -- upvalues: l__SkinDefs__4 (copy)
    local v64 = l__SkinDefs__4.RARITIES[p63];
    return (typeof(v64) ~= "table" or typeof(v64.priority) ~= "number") and (1 / 0) or v64.priority;
end;
function u1.isTestBannerProbabilities(p65) --[[ Line: 271 ]]
    -- upvalues: u38 (copy), l__BannerDef__2 (copy)
    return u38(p65, l__BannerDef__2.DEFAULT_PROBABILITIES.test_banner);
end;
function u1.isClassifiedRiggedProbabilities(p66) --[[ Line: 275 ]]
    -- upvalues: l__BannerDef__2 (copy)
    return p66 == l__BannerDef__2.DEFAULT_PROBABILITIES.classified_rigged;
end;
function u1.isRandomBanner(p67) --[[ Line: 279 ]]
    local v68;
    if typeof(p67) == "table" then
        v68 = p67.banner_type == "random";
    else
        v68 = false;
    end;
    return v68;
end;
function u1.isDirectPurchaseBanner(p69) --[[ Line: 283 ]]
    local v70;
    if typeof(p69) == "table" then
        v70 = p69.banner_type == "direct_purchase";
    else
        v70 = false;
    end;
    return v70;
end;
local function u80(p71, p72, p73) --[[ Line: 287 ]]
    -- upvalues: u27 (copy), l__SkinDefs__4 (copy), l__TitleData__5 (copy), u32 (copy)
    if typeof(p71) == "table" then
        local l__grant_type__6 = p71.grant_type;
        local l__id__7 = p71.id;
        local l__weight__8 = p71.weight;
        if l__grant_type__6 == "skin" or l__grant_type__6 == "title" then
            if typeof(l__id__7) == "number" then
                if p73 and (typeof(l__weight__8) ~= "number" or l__weight__8 <= 0) then
                    return nil, "invalid_grant_entry";
                else
                    local v74 = {
                        entry_index = p72,
                        grant_type = l__grant_type__6,
                        id = l__id__7,
                        weight = (typeof(l__weight__8) ~= "number" or l__weight__8 <= 0) and 1 or l__weight__8,
                        metadata = {}
                    };
                    local v75, v76 = u27(p71.metadata or {}, {}, 1);
                    if v76 then
                        return nil, v76;
                    else
                        v74.metadata = v75;
                        if l__grant_type__6 == "skin" then
                            local v77 = l__SkinDefs__4.getDefinitionsBySkinId(l__id__7);
                            if #v77 ~= 1 then
                                return nil, "ambiguous_skin_grant";
                            end;
                            local v78 = v77[1];
                            v74.item_id = v78.item_id;
                            v74.name = v78.def.name;
                            v74.rarity = v78.def.rarity;
                            v74.def = v78.def;
                        else
                            local v79 = l__TitleData__5[l__id__7];
                            if typeof(v79) ~= "table" then
                                return nil, "invalid_title_grant";
                            end;
                            if typeof(p71.rarity) ~= "string" or p71.rarity == "" then
                                return nil, "missing_title_rarity";
                            end;
                            if l__SkinDefs__4.RARITIES[p71.rarity] == nil then
                                return nil, "invalid_title_rarity";
                            end;
                            v74.name = u32(l__id__7);
                            v74.rarity = p71.rarity;
                            v74.title_data = v79;
                        end;
                        if typeof(v74.rarity) == "string" and v74.rarity ~= "" then
                            return v74;
                        else
                            return nil, "missing_grant_rarity";
                        end;
                    end;
                end;
            else
                return nil, "invalid_grant_entry";
            end;
        else
            return nil, "invalid_grant_entry";
        end;
    else
        return nil, "invalid_pool_entry";
    end;
end;
function u1.normalizeBanner(p81, p82) --[[ Line: 356 ]]
    -- upvalues: u1 (copy), u80 (copy), u2 (copy), u50 (copy), u61 (copy)
    if typeof(p82) ~= "table" then
        return nil, "invalid_banner_definition";
    end;
    if u1.isTestBannerProbabilities(p82.probabilities) then
        return nil, "test_banner_probabilities";
    end;
    if typeof(p82.id) ~= "string" or p82.id == "" then
        return nil, "missing_banner_id";
    end;
    if p82.id ~= p81 then
        return nil, "banner_id_mismatch";
    end;
    local v83 = typeof(p82.banner_type) ~= "string" and "random" or p82.banner_type;
    if v83 ~= "random" and v83 ~= "direct_purchase" then
        return nil, "unsupported_banner_type";
    end;
    if typeof(p82.starts_at) ~= "number" or typeof(p82.ends_at) ~= "number" then
        return nil, "invalid_banner_window";
    end;
    if p82.ends_at < p82.starts_at then
        return nil, "invalid_banner_window";
    end;
    local v84 = {
        rollable_rarity_weight = 0,
        id = p82.id,
        banner_type = v83,
        display_name = typeof(p82.display_name) == "string" and p82.display_name or p82.id,
        banner_image = typeof(p82.banner_image) == "string" and (p82.banner_image or "") or "",
        kind = typeof(p82.kind) == "string" and (p82.kind or "") or "",
        description = typeof(p82.description) == "string" and (p82.description or "") or "",
        priority = typeof(p82.priority) == "number" and (p82.priority or 0) or 0,
        starts_at = p82.starts_at,
        ends_at = p82.ends_at
    };
    local v85;
    if typeof(p82.crimson_price) == "number" then
        v85 = p82.crimson_price;
    else
        v85 = nil;
    end;
    v84.crimson_price = v85;
    local v86;
    if typeof(p82.yen_price) == "number" then
        v86 = p82.yen_price;
    else
        v86 = nil;
    end;
    v84.yen_price = v86;
    v84.yen_buyable = p82.yen_buyable == true;
    local v87;
    if typeof(p82.product_id) == "number" then
        v87 = p82.product_id;
    else
        v87 = nil;
    end;
    v84.product_id = v87;
    local v88;
    if typeof(p82.gift_product_id) == "number" then
        v88 = p82.gift_product_id;
    else
        v88 = nil;
    end;
    v84.gift_product_id = v88;
    v84.probabilities = {};
    v84.roll_probabilities = {};
    v84.pool = {};
    v84.items = {};
    v84.pool_by_rarity = {};
    v84.duplicate_title_refunds = {};
    v84.effective_rarity_probabilities = {};
    if v83 == "direct_purchase" then
        if typeof(p82.product_id) ~= "number" or (p82.product_id <= 0 or p82.product_id % 1 ~= 0) then
            return nil, "invalid_product_id";
        end;
        if p82.gift_product_id ~= nil then
            if typeof(p82.gift_product_id) ~= "number" or (p82.gift_product_id <= 0 or p82.gift_product_id % 1 ~= 0) then
                return nil, "invalid_gift_product_id";
            end;
            if p82.gift_product_id == p82.product_id then
                return nil, "duplicate_gift_product_id";
            end;
        end;
        if p82.crimson_price ~= nil and (typeof(p82.crimson_price) ~= "number" or p82.crimson_price <= 0) then
            return nil, "invalid_crimson_price";
        end;
        if typeof(p82.items) ~= "table" then
            return nil, "invalid_banner_items";
        end;
        for _, v89 in ipairs(p82.items) do
            local v90, v91 = u80(v89, #v84.items + 1, false);
            if not v90 then
                return nil, v91;
            end;
            table.insert(v84.items, v90);
        end;
        if #v84.items <= 0 then
            return nil, "empty_items";
        end;
        table.sort(v84.items, function(p92, p93) --[[ Line: 450 ]]
            return `{p92.rarity}:{p92.grant_type}:{p92.item_id or ""}:{p92.id}:{p92.name or ""}:{p92.entry_index or 0}` < `{p93.rarity}:{p93.grant_type}:{p93.item_id or ""}:{p93.id}:{p93.name or ""}:{p93.entry_index or 0}`;
        end);
        return v84;
    end;
    if typeof(p82.crimson_price) ~= "number" or p82.crimson_price <= 0 then
        return nil, "invalid_crimson_price";
    end;
    if typeof(p82.yen_price) ~= "number" or p82.yen_price <= 0 then
        return nil, "invalid_yen_price";
    end;
    if typeof(p82.yen_buyable) ~= "boolean" then
        return nil, "invalid_yen_buyable_flag";
    end;
    if typeof(p82.pool) ~= "table" then
        return nil, "invalid_banner_roll_data";
    end;
    if typeof(p82.duplicate_title_refunds) ~= "table" then
        return nil, "missing_duplicate_title_refunds";
    end;
    local v94 = {};
    for v95, v96 in pairs(p82.duplicate_title_refunds) do
        if typeof(v95) == "string" and (typeof(v96) == "number" and v96 >= 0) then
            v84.duplicate_title_refunds[v95] = v96;
        end;
    end;
    local l__probabilities__9 = p82.probabilities;
    local v97, v98;
    if typeof(l__probabilities__9) == "table" then
        local v99;
        if typeof(l__probabilities__9) == "table" then
            v99 = typeof(l__probabilities__9.display_probabilities) == "table" and true or typeof(l__probabilities__9.roll_probabilities) == "table";
        else
            v99 = false;
        end;
        if v99 then
            if l__probabilities__9.studio_only == true and not u2 then
                v97 = "studio_only_probabilities";
                v98 = nil;
                l__probabilities__9 = nil;
            elseif typeof(l__probabilities__9.display_probabilities) == "table" and typeof(l__probabilities__9.roll_probabilities) == "table" then
                v98 = l__probabilities__9.display_probabilities;
                l__probabilities__9 = l__probabilities__9.roll_probabilities;
                v97 = nil;
            else
                v97 = "invalid_probability_preset";
                v98 = nil;
                l__probabilities__9 = nil;
            end;
        else
            v98 = l__probabilities__9;
            v97 = nil;
        end;
    else
        v97 = "invalid_banner_roll_data";
        v98 = nil;
        l__probabilities__9 = nil;
    end;
    if v97 then
        return nil, v97;
    end;
    local v100, v101 = u50(v98);
    if not v100 then
        return nil, v101;
    end;
    v84.probabilities = v100;
    local v102, v103 = u50(l__probabilities__9);
    if not v102 then
        return nil, v103;
    end;
    v84.roll_probabilities = v102;
    for _, v104 in ipairs(p82.pool) do
        local v105, v106 = u80(v104, #v84.pool + 1, true);
        if not v105 then
            return nil, v106;
        end;
        if v105.grant_type == "title" then
            v94[v105.rarity] = true;
        end;
        v84.pool_by_rarity[v105.rarity] = v84.pool_by_rarity[v105.rarity] or {};
        table.insert(v84.pool_by_rarity[v105.rarity], v105);
        table.insert(v84.pool, v105);
    end;
    if #v84.pool <= 0 then
        return nil, "empty_pool";
    end;
    for v107 in pairs(v94) do
        if typeof(v84.duplicate_title_refunds[v107]) ~= "number" then
            return nil, "missing_title_refund";
        end;
    end;
    for _, v108 in ipairs(v84.probabilities) do
        local v109 = v84.pool_by_rarity[v108.rarity];
        if typeof(v109) == "table" and #v109 > 0 then
            table.sort(v109, function(p110, p111) --[[ Line: 529 ]]
                return `{p110.rarity}:{p110.grant_type}:{p110.item_id or ""}:{p110.id}:{p110.name or ""}:{p110.entry_index or 0}` < `{p111.rarity}:{p111.grant_type}:{p111.item_id or ""}:{p111.id}:{p111.name or ""}:{p111.entry_index or 0}`;
            end);
        end;
    end;
    local v112 = 0;
    for _, v113 in ipairs(v84.roll_probabilities) do
        local v114 = v84.pool_by_rarity[v113.rarity];
        if typeof(v114) == "table" and #v114 > 0 then
            v112 = v112 + 1;
        end;
    end;
    if v112 <= 0 then
        return nil, "no_rollable_pool_entries";
    end;
    table.sort(v84.pool, function(p115, p116) --[[ Line: 547 ]]
        return `{p115.rarity}:{p115.grant_type}:{p115.item_id or ""}:{p115.id}:{p115.name or ""}:{p115.entry_index or 0}` < `{p116.rarity}:{p116.grant_type}:{p116.item_id or ""}:{p116.id}:{p116.name or ""}:{p116.entry_index or 0}`;
    end);
    u61(v84);
    return v84;
end;
function u1.collectNormalizedBanners(p117) --[[ Line: 556 ]]
    -- upvalues: l__BannerDef__2 (copy), u1 (copy)
    if typeof(p117) ~= "table" then
        p117 = l__BannerDef__2.defs;
    end;
    local v118 = {};
    local v119 = {};
    for v120, v121 in pairs(p117) do
        local v122, v123 = u1.normalizeBanner(v120, v121);
        if v122 then
            v118[v120] = v122;
        else
            table.insert(v119, {
                banner_key = v120,
                error_code = v123
            });
        end;
    end;
    return v118, v119;
end;
function u1.isBannerActive(p124, p125) --[[ Line: 576 ]]
    if typeof(p124) ~= "table" then
        return false;
    end;
    if typeof(p125) ~= "number" then
        p125 = os.time();
    end;
    local v126;
    if p124.starts_at <= p125 then
        v126 = p125 < p124.ends_at;
    else
        v126 = false;
    end;
    return v126;
end;
function u1.getActiveBanners(p127, p128) --[[ Line: 585 ]]
    -- upvalues: u1 (copy)
    local v129, v130 = u1.collectNormalizedBanners(p128);
    local v131 = {};
    if typeof(p127) ~= "number" then
        p127 = os.time();
    end;
    for _, v132 in pairs(v129) do
        if u1.isBannerActive(v132, p127) then
            table.insert(v131, v132);
        end;
    end;
    table.sort(v131, function(p133, p134) --[[ Line: 596 ]]
        if p133.priority == p134.priority then
            if p133.ends_at == p134.ends_at then
                return p133.id < p134.id;
            else
                return p133.ends_at < p134.ends_at;
            end;
        else
            return p133.priority > p134.priority;
        end;
    end);
    return v131, v130, v129;
end;
function u1.getEffectiveRarityProbability(p135, p136) --[[ Line: 611 ]]
    if typeof(p135) ~= "table" then
        return 0;
    end;
    local l__effective_rarity_probabilities__10 = p135.effective_rarity_probabilities;
    if typeof(l__effective_rarity_probabilities__10) ~= "table" then
        return 0;
    end;
    local v137 = l__effective_rarity_probabilities__10[p136];
    return typeof(v137) ~= "number" and 0 or v137;
end;
function u1.getEffectiveEntryProbability(p138) --[[ Line: 625 ]]
    if typeof(p138) ~= "table" then
        return 0;
    end;
    local l__effective_probability__11 = p138.effective_probability;
    return typeof(l__effective_probability__11) ~= "number" and 0 or l__effective_probability__11;
end;
return u1;
