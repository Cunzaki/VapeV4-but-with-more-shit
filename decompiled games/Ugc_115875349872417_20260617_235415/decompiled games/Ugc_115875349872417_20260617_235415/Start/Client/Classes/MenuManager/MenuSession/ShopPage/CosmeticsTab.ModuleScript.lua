-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ShopPage.CosmeticsTab
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ModuleScripts__4 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__BannerUtil__5 = require(l__ModuleScripts__4.BannerUtil);
local l__DealsDef__6 = require(l__ModuleScripts__4.DealsDef);
local l__ItemDef__7 = require(l__ModuleScripts__4.ItemDef);
local l__Packets__8 = require(l__ModuleScripts__4.Packets);
local l__SkinDefs__9 = require(l__ModuleScripts__4.SkinDefs);
local l__TitleData__10 = require(l__ModuleScripts__4.TitleData);
local l__Trove__11 = require(l__ModuleScripts__4.Trove);
local l__UIAssets__12 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__13 = require(script.Parent.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__14 = require(script.Parent.Parent.Parent.Parent.Parent.InternalSymbols);
local u2 = {
    Exotic = {
        extra_scroll_duration = 3.5,
        hold_duration = 0
    },
    Exclusive = {
        extra_scroll_duration = 3.5,
        hold_duration = 0
    },
    Classified = {
        extra_scroll_duration = 4.5,
        hold_duration = 0
    }
};
local u3 = {
    invalid_request_id = "That extraction request was invalid.",
    invalid_banner_id = "That banner is unavailable.",
    invalid_currency = "That extraction currency was invalid.",
    unknown_banner = "That banner is no longer available.",
    banner_not_started = "That banner is not live yet.",
    banner_expired = "That banner has ended.",
    inactive_profile = "Your profile is still loading. Try again in a moment.",
    yen_not_supported = "This banner can only be extracted with Crimson.",
    insufficient_yen = "You do not have enough Yen for that extraction.",
    insufficient_crimson = "You do not have enough Crimson for that extraction.",
    insufficient_eligible_crimson = "Only earned Crimson can be used for this extraction in your region.",
    pull_in_flight = "An extraction is already in progress.",
    unsupported_grant_type = "That banner reward is not supported yet.",
    internal_error = "Banner extraction failed. Try again."
};
local function u6(p4, p5) --[[ Line: 123 ]]
    if p4:IsA("TextLabel") then
        p4.TextTransparency = p5;
    elseif p4:IsA("TextButton") then
        p4.TextTransparency = p5;
    elseif p4:IsA("ImageLabel") then
        p4.ImageTransparency = p5;
    elseif p4:IsA("ImageButton") then
        p4.ImageTransparency = p5;
    else
        if p4:IsA("GuiObject") then
            p4.BackgroundTransparency = p5;
        end;
    end;
end;
local function u10(p7, p8) --[[ Line: 146 ]]
    for _, v9 in ipairs(p7:GetChildren()) do
        if v9:GetAttribute(p8) == true then
            v9:Destroy();
        end;
    end;
end;
local function u13(p11) --[[ Line: 154 ]]
    if p11 <= 0 or p11 >= 1 then
        return 0;
    end;
    for v12 = 1, 12 do
        p11 = p11 * 10;
        if math.floor(p11) > 0 then
            return v12;
        end;
    end;
    return 12;
end;
local function u20(p14) --[[ Line: 170 ]]
    -- upvalues: u13 (copy)
    local v15 = 4;
    for _, v16 in ipairs(p14) do
        local v17 = math.max(0, v16) * 100;
        if v17 > 0 and v17 < 1 then
            local v18 = u13(v17) + 4;
            local v19 = math.min(12, v18);
            v15 = math.max(v15, v19);
        end;
    end;
    return v15;
end;
local function u37(p21) --[[ Line: 193 ]]
    -- upvalues: u20 (copy)
    local v22 = u20(p21);
    local v23 = 10 ^ v22;
    local v24 = math.floor(v23 * 100 + 0.5);
    local v25 = {};
    local v26 = 0;
    local v27 = (-1 / 0);
    local v28 = nil;
    for v29, v30 in ipairs(p21) do
        local v31 = math.max(0, v30);
        local v32 = math.floor(v31 * 100 * v23 + 0.5);
        v25[v29] = v32;
        v26 = v26 + v32;
        if v27 < v31 then
            v28 = v29;
            v27 = v31;
        end;
    end;
    if v28 and v26 ~= v24 then
        v25[v28] = math.max(0, v25[v28] + v24 - v26);
    end;
    local v33 = {};
    for v34, v35 in ipairs(v25) do
        local v36 = string.format("%." .. tostring(v22) .. "f", v35 / v23):gsub("0+$", ""):gsub("%.$", "");
        v33[v34] = (v36 == "" and "0" or v36) .. "%";
    end;
    return v33;
end;
local function u46(p38) --[[ Line: 228 ]]
    local v39 = math.floor(p38);
    local v40 = math.max(0, v39);
    local v41 = math.floor(v40 / 86400);
    local v42 = v40 - v41 * 86400;
    local v43 = math.floor(v42 / 3600);
    local v44 = v42 - v43 * 3600;
    local v45 = math.floor(v44 / 60);
    return string.format("%02d:%02d:%02d:%02d", v41, v43, v45, v44 - v45 * 60);
end;
local function u51(p47) --[[ Line: 258 ]]
    -- upvalues: l__TitleData__10 (copy)
    local v48 = l__TitleData__10[p47];
    if typeof(v48) == "table" then
        if typeof(v48.static_text) == "string" and v48.static_text ~= "" then
            return v48.static_text;
        end;
        if typeof(v48.getText) == "function" then
            local v49, v50 = pcall(v48.getText);
            if v49 and (typeof(v50) == "string" and v50 ~= "") then
                return v50;
            end;
        end;
    end;
    return tostring(p47);
end;
local function u58(p52, p53, p54) --[[ Line: 304 ]]
    -- upvalues: l__SkinDefs__9 (copy)
    if typeof(p54) == "string" then
        p54 = tonumber(p54);
    end;
    local v55;
    if typeof(p54) == "number" and (p54 == p54 and p54 % 1 == 0) then
        v55 = tostring(p54);
    else
        v55 = nil;
        p54 = nil;
    end;
    if typeof(p53) ~= "string" or (not v55 or (not p54 or (p54 == l__SkinDefs__9.DEFAULT_SKIN_ID or not l__SkinDefs__9.isValidForItem(p53, p54)))) then
        return nil;
    end;
    if typeof(p52.skin_inventory) ~= "table" then
        p52.skin_inventory = {};
    end;
    local v56 = p52.skin_inventory[p53];
    if typeof(v56) ~= "table" then
        v56 = {};
        p52.skin_inventory[p53] = v56;
    end;
    local v57 = v56[v55];
    if typeof(v57) ~= "table" then
        v57 = {
            count = 0
        };
        v56[v55] = v57;
    end;
    if typeof(v57.count) ~= "number" or v57.count < 0 then
        v57.count = 0;
    end;
    return v57;
end;
local function u61(p59) --[[ Line: 352 ]]
    -- upvalues: l__SkinDefs__9 (copy)
    local v60 = l__SkinDefs__9.RARITIES[p59];
    if v60 then
        v60 = v60.color;
    end;
    if typeof(v60) == "ColorSequence" then
        return v60;
    elseif typeof(v60) == "Color3" then
        return ColorSequence.new(v60);
    else
        return ColorSequence.new(Color3.fromRGB(255, 255, 255));
    end;
end;
function u1.new(p62, p63) --[[ Line: 364 ]]
    -- upvalues: u1 (copy), l__Trove__11 (copy), l__InternalSymbols__14 (copy), l__UIAssets__12 (copy)
    local v64 = setmetatable({}, u1);
    v64.trove = l__Trove__11.new();
    v64.section_trove = v64.trove:Extend();
    v64.banner_view_trove = v64.trove:Extend();
    v64.timer_trove = v64.trove:Extend();
    v64._menu_session = l__InternalSymbols__14.owner("MenuSession", p63);
    v64.main_page = p62;
    v64.page_origin = l__UIAssets__12.Menu.ShopPage.Cosmetics;
    v64.tab_asset = v64.page_origin.CosmeticsTab:Clone();
    v64.ui = nil;
    v64.yen_inst = nil;
    v64.crimson_inst = nil;
    v64.active_banners = {};
    v64.selected_banner_id = nil;
    v64.pull_in_flight = false;
    v64._gift_browser_open = false;
    v64._gift_requesting = false;
    v64._pending_gift_product_id = nil;
    v64._pending_gift_request_id = nil;
    v64._gift_block_state_by_product_id = {};
    v64._gift_route_tokens_by_product_id = {};
    v64.banner_sections = {};
    v64.extract_buttons = {};
    v64.robux_price_by_product_id = {};
    v64.robux_product_price_fetching = {};
    v64.robux_crimson_option_by_min_crimson = {};
    v64.robux_crimson_option_fetching = {};
    v64.purchase_option_refresh_queued = false;
    v64:start();
    v64:_bind();
    return v64;
end;
function u1.destroy(p65) --[[ Line: 404 ]]
    p65.trove:Clean();
end;
function u1._getUi(p66) --[[ Line: 408 ]]
    if p66.ui then
        return p66.ui;
    end;
    local l__tab_asset__15 = p66.tab_asset;
    local v67 = l__tab_asset__15:FindFirstChild("BannerContainer");
    if not v67 then
        v67 = l__tab_asset__15:FindFirstChild("BannerContainer", true);
        assert(v67, "CosmeticsTab UI is missing child: BannerContainer");
    end;
    local v68 = v67:FindFirstChild("Main");
    if not v68 then
        v68 = v67:FindFirstChild("Main", true);
        assert(v68, "CosmeticsTab UI is missing child: Main");
    end;
    local v69 = v68:FindFirstChild("InfoFrame");
    if not v69 then
        v69 = v68:FindFirstChild("InfoFrame", true);
        assert(v69, "CosmeticsTab UI is missing child: InfoFrame");
    end;
    local v70 = v67:FindFirstChild("ButtonList");
    if not v70 then
        v70 = v67:FindFirstChild("ButtonList", true);
        assert(v70, "CosmeticsTab UI is missing child: ButtonList");
    end;
    local v71 = l__tab_asset__15:FindFirstChild("BannerList");
    if not v71 then
        v71 = l__tab_asset__15:FindFirstChild("BannerList", true);
        assert(v71, "CosmeticsTab UI is missing child: BannerList");
    end;
    local v72 = {
        banner_list = v71,
        banner_container = v67,
        button_list = v70
    };
    local l__ImageHolder__16 = v67.ImageHolder;
    local v73 = l__ImageHolder__16:FindFirstChild("BannerImage");
    if not v73 then
        v73 = l__ImageHolder__16:FindFirstChild("BannerImage", true);
        assert(v73, "CosmeticsTab UI is missing child: BannerImage");
    end;
    v72.banner_image = v73;
    local l__ImageHolder__17 = v67.ImageHolder;
    local v74 = l__ImageHolder__17:FindFirstChild("BannerButton");
    if not v74 then
        v74 = l__ImageHolder__17:FindFirstChild("BannerButton", true);
        assert(v74, "CosmeticsTab UI is missing child: BannerButton");
    end;
    v72.banner_button = v74;
    local v75 = v68:FindFirstChild("BannerLabel");
    if not v75 then
        v75 = v68:FindFirstChild("BannerLabel", true);
        assert(v75, "CosmeticsTab UI is missing child: BannerLabel");
    end;
    v72.banner_label = v75;
    local v76 = v68:FindFirstChild("Banner2Label");
    if not v76 then
        v76 = v68:FindFirstChild("Banner2Label", true);
        assert(v76, "CosmeticsTab UI is missing child: Banner2Label");
    end;
    v72.banner2_label = v76;
    local v77 = v68:FindFirstChild("DescLabel");
    if not v77 then
        v77 = v68:FindFirstChild("DescLabel", true);
        assert(v77, "CosmeticsTab UI is missing child: DescLabel");
    end;
    v72.desc_label = v77;
    local v78 = v68:FindFirstChild("SubLabel");
    if not v78 then
        v78 = v68:FindFirstChild("SubLabel", true);
        assert(v78, "CosmeticsTab UI is missing child: SubLabel");
    end;
    v72.sub_label = v78;
    local v79 = v68:FindFirstChild("TimerLabel");
    if not v79 then
        v79 = v68:FindFirstChild("TimerLabel", true);
        assert(v79, "CosmeticsTab UI is missing child: TimerLabel");
    end;
    v72.timer_label = v79;
    v72.info_frame = v69;
    local v80 = v69:FindFirstChild("RarityList");
    if not v80 then
        v80 = v69:FindFirstChild("RarityList", true);
        assert(v80, "CosmeticsTab UI is missing child: RarityList");
    end;
    v72.rarity_list = v80;
    p66.ui = v72;
    return p66.ui;
end;
function u1._getExtractTemplate(p81) --[[ Line: 438 ]]
    local v82 = p81.page_origin:FindFirstChild("ExtractButton");
    assert(v82, "CosmeticsTab is missing ExtractButton template");
    return v82;
end;
function u1._getRobuxTemplate(p83) --[[ Line: 444 ]]
    local v84 = p83.page_origin:FindFirstChild("RobuxButton");
    assert(v84, "CosmeticsTab is missing RobuxButton template");
    return v84;
end;
function u1._getRarityLabelTemplate(p85) --[[ Line: 450 ]]
    local v86 = p85.page_origin:FindFirstChild("RarityLabel");
    assert(v86, "CosmeticsTab is missing RarityLabel template");
    return v86;
end;
function u1._refreshBannerData(p87) --[[ Line: 456 ]]
    -- upvalues: l__BannerUtil__5 (copy)
    local v88, v89 = l__BannerUtil__5.getActiveBanners(os.time());
    for _, v90 in ipairs(v89) do
        warn((`[CosmeticsTab] Invalid banner "{v90.banner_key}": {v90.error_code}`));
    end;
    p87.active_banners = v88;
    for _, v91 in ipairs(v88) do
        if l__BannerUtil__5.isDirectPurchaseBanner(v91) then
            p87:_getCachedProductRobuxPrice(v91.product_id);
            p87:_getCachedProductRobuxPrice(v91.gift_product_id);
        end;
    end;
    local l__selected_banner_id__18 = p87.selected_banner_id;
    if typeof(l__selected_banner_id__18) == "string" then
        for _, v92 in ipairs(v88) do
            if v92.id == l__selected_banner_id__18 then
                return;
            end;
        end;
    end;
    p87.selected_banner_id = v88[1] and v88[1].id or nil;
end;
function u1._getSelectedBanner(p93) --[[ Line: 484 ]]
    if typeof(p93.selected_banner_id) ~= "string" then
        return nil;
    end;
    for _, v94 in ipairs(p93.active_banners) do
        if v94.id == p93.selected_banner_id then
            return v94;
        end;
    end;
    return nil;
end;
function u1.getBannerById(p95, p96) --[[ Line: 498 ]]
    p95:_refreshBannerData();
    if typeof(p96) ~= "string" or p96 == "" then
        return nil;
    end;
    for _, v97 in ipairs(p95.active_banners) do
        if v97.id == p96 then
            return v97;
        end;
    end;
    return nil;
end;
function u1._setEmptyState(p98) --[[ Line: 514 ]]
    -- upvalues: u10 (copy)
    local v99 = p98:_getUi();
    local l__banner_image__19 = v99.banner_image;
    local l__button_list__20 = v99.button_list;
    u10(v99.banner_list, "GeneratedBannerSection");
    u10(l__button_list__20, "GeneratedExtractButton");
    u10(v99.rarity_list, "GeneratedBannerRarity");
    p98.banner_sections = {};
    p98.extract_buttons = {};
    v99.info_frame.Visible = false;
    v99.banner_label.Text = "NO ACTIVE BANNERS";
    v99.banner2_label.Text = "NO ACTIVE BANNERS";
    v99.desc_label.Text = "There are no active extraction banners right now.";
    v99.sub_label.Text = "BANNERS | CLICK FOR INFO <b>ⓘ</b>";
    v99.timer_label.Text = "ENDS IN | --:--:--:--";
    if l__banner_image__19:IsA("ImageButton") or l__banner_image__19:IsA("ImageLabel") then
        l__banner_image__19.Image = "";
    end;
    l__button_list__20.Visible = false;
    local l__sub_label__21 = v99.sub_label;
    if l__sub_label__21 then
        l__sub_label__21.Active = false;
        l__sub_label__21.AutoButtonColor = false;
        l__sub_label__21.Selectable = false;
        l__sub_label__21.Interactable = false;
    end;
    local l__banner_button__22 = v99.banner_button;
    if l__banner_button__22 then
        l__banner_button__22.Active = false;
        l__banner_button__22.AutoButtonColor = false;
        l__banner_button__22.Selectable = false;
        l__banner_button__22.Interactable = false;
    end;
end;
function u1._refreshRarityList(p100, p101) --[[ Line: 541 ]]
    -- upvalues: u10 (copy), l__BannerUtil__5 (copy), u37 (copy), u61 (copy)
    local l__rarity_list__23 = p100:_getUi().rarity_list;
    local v102 = p100:_getRarityLabelTemplate();
    v102.Visible = false;
    u10(l__rarity_list__23, "GeneratedBannerRarity");
    local v103 = {};
    for v104, v105 in ipairs(p101.probabilities) do
        v103[v104] = l__BannerUtil__5.getEffectiveRarityProbability(p101, v105.rarity);
    end;
    local v106 = u37(v103);
    for v107, v108 in ipairs(p101.probabilities) do
        local v109 = v102:Clone();
        v109:SetAttribute("GeneratedBannerRarity", true);
        v109.Visible = true;
        v109.LayoutOrder = l__BannerUtil__5.getRarityPriority(v108.rarity);
        if v109:IsA("TextLabel") then
            v109.Text = `({v108.rarity}): {v106[v107]}`;
        elseif v109:IsA("TextButton") then
            v109.Text = `({v108.rarity}): {v106[v107]}`;
        end;
        local v110 = v109:FindFirstChild("ColorGradient", true) or v109:FindFirstChildWhichIsA("UIGradient", true);
        if v110 and v110:IsA("UIGradient") then
            v110.Color = u61(v108.rarity);
        end;
        v109.Parent = l__rarity_list__23;
    end;
end;
function u1._updateTimerLoop(p111, u112) --[[ Line: 576 ]]
    -- upvalues: u46 (copy)
    p111.timer_trove:Clean();
    local u113 = p111:_getUi();
    local l__timer_label__24 = u113.timer_label;
    local v114 = u46;
    local v115 = u112.ends_at - os.time();
    l__timer_label__24.Text = "ENDS IN | " .. v114((math.max(0, v115)));
    p111.timer_trove:Add(task.spawn(function() --[[ Line: 582 ]]
        -- upvalues: u113 (copy), u46 (ref), u112 (copy)
        while true do
            local l__timer_label__25 = u113.timer_label;
            local v116 = u46;
            local v117 = u112.ends_at - os.time();
            l__timer_label__25.Text = "ENDS IN | " .. v116((math.max(0, v117)));
            task.wait(1);
        end;
    end));
end;
function u1._buildSectionList(u118) --[[ Line: 590 ]]
    -- upvalues: u10 (copy)
    local v119 = u118:_getUi();
    local v120 = u118.page_origin:FindFirstChild("BannerSection");
    assert(v120, "CosmeticsTab is missing BannerSection template");
    u10(v119.banner_list, "GeneratedBannerSection");
    u118.banner_sections = {};
    for v121, u122 in ipairs(u118.active_banners) do
        local v123 = v120:Clone();
        v123:SetAttribute("GeneratedBannerSection", true);
        v123.LayoutOrder = v121;
        local v124 = v123:FindFirstChildWhichIsA("TextLabel", true);
        if v124 then
            v124.Text = u122.display_name;
        end;
        local v125 = v123:FindFirstChild("Button");
        local v126;
        if v125 then
            v126 = v125:IsA("GuiButton");
        else
            v126 = v125;
        end;
        assert(v126, "CosmeticsTab BannerSection is missing GuiButton child: Button");
        u118.section_trove:Connect(v125.Activated, function() --[[ Line: 609 ]]
            -- upvalues: u118 (copy), u122 (copy)
            if u118.pull_in_flight then
            else
                u118:selectBanner(u122.id, true);
            end;
        end);
        v123.Parent = v119.banner_list;
        u118.banner_sections[u122.id] = v123;
    end;
end;
function u1._updateSectionVisuals(p127) --[[ Line: 622 ]]
    -- upvalues: u6 (copy)
    for v128, v129 in pairs(p127.banner_sections) do
        local v130 = v128 == p127.selected_banner_id and 0 or 0.5;
        u6(v129, v130);
        local v131 = v129:FindFirstChildWhichIsA("TextLabel", true);
        if v131 then
            v131.TextTransparency = v130;
        end;
    end;
end;
function u1._getCrimsonValue(p132) --[[ Line: 629 ]]
    local l__crimson_inst__26 = p132.crimson_inst;
    return not l__crimson_inst__26 and 0 or l__crimson_inst__26.Value;
end;
function u1._getYenValue(p133) --[[ Line: 633 ]]
    local l__yen_inst__27 = p133.yen_inst;
    return not l__yen_inst__27 and 0 or l__yen_inst__27.Value;
end;
function u1._queuePurchaseOptionsRefresh(u134) --[[ Line: 637 ]]
    -- upvalues: l__InternalSymbols__14 (copy)
    if u134.purchase_option_refresh_queued then
    else
        u134.purchase_option_refresh_queued = true;
        task.defer(function() --[[ Line: 643 ]]
            -- upvalues: u134 (copy), l__InternalSymbols__14 (ref)
            u134.purchase_option_refresh_queued = false;
            u134:_refreshBannerData();
            local v135 = u134:_getSelectedBanner();
            if v135 then
                u134:_buildExtractButtons(v135);
                u134:_updateInteractableState();
            end;
            local l__pages__28 = u134._menu_session.pages;
            local l__owner__29 = l__InternalSymbols__14.owner;
            local v136 = "ShowcasePage";
            if l__pages__28 then
                l__pages__28 = l__pages__28.showcase_page;
            end;
            local v137 = l__owner__29(v136, l__pages__28);
            if v137 and (v137._updateActions and (v137.main_page and v137.main_page.Visible == true)) then
                v137:_updateActions();
            end;
        end);
    end;
end;
function u1._getPaidRandomItemsRestricted(p138) --[[ Line: 661 ]]
    return p138._menu_session:getPaidRandomItemsRestricted();
end;
function u1._getProductRobuxPrice(p139, u140) --[[ Line: 665 ]]
    -- upvalues: l__MarketplaceService__2 (copy)
    if typeof(u140) == "number" then
        local v141 = p139.robux_price_by_product_id[u140];
        if v141 == nil then
            local v142, v143 = pcall(function() --[[ Line: 675 ]]
                -- upvalues: l__MarketplaceService__2 (ref), u140 (copy)
                return l__MarketplaceService__2:GetProductInfoAsync(u140, Enum.InfoType.Product);
            end);
            local v144;
            if v142 then
                v144 = v143.PriceInRobux or nil;
            else
                v144 = nil;
            end;
            if typeof(v144) == "number" then
                p139.robux_price_by_product_id[u140] = v144;
                return v144;
            end;
            warn("[CosmeticsTab] Failed to fetch Crimson product pricing:", u140, v143);
            p139.robux_price_by_product_id[u140] = false;
            return nil;
        elseif typeof(v141) == "number" then
            return v141;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._getCachedProductRobuxPrice(u145, u146) --[[ Line: 690 ]]
    if typeof(u146) == "number" then
        local v147 = u145.robux_price_by_product_id[u146];
        if v147 == nil then
            if u145.robux_product_price_fetching[u146] then
                return nil;
            end;
            u145.robux_product_price_fetching[u146] = true;
            task.spawn(function() --[[ Line: 705 ]]
                -- upvalues: u145 (copy), u146 (copy)
                u145:_getProductRobuxPrice(u146);
                u145.robux_product_price_fetching[u146] = nil;
                u145:_queuePurchaseOptionsRefresh();
            end);
            return nil;
        elseif typeof(v147) == "number" then
            return v147;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._getGiftInventoryCount(p148, p149) --[[ Line: 714 ]]
    if typeof(p149) ~= "number" then
        return 0;
    end;
    local l__item_profile_data__30 = p148._menu_session.item_profile_data;
    local v150 = (l__item_profile_data__30 and l__item_profile_data__30.dev_product_inventory_counts or {})[p149] or 0;
    return typeof(v150) ~= "number" and 0 or math.max(0, v150);
end;
function u1._hasOutboundGift(p151, p152) --[[ Line: 725 ]]
    if typeof(p152) ~= "number" then
        return false;
    end;
    local l__item_profile_data__31 = p151._menu_session.item_profile_data;
    local v153 = (l__item_profile_data__31 and l__item_profile_data__31.dev_product_outbound_counts or {})[p152] or 0;
    local v154;
    if typeof(v153) == "number" then
        v154 = v153 > 0;
    else
        v154 = false;
    end;
    return v154;
end;
function u1._giftProductHasMatchingPrice(p155, p156, p157) --[[ Line: 736 ]]
    local v158 = p155:_getCachedProductRobuxPrice(p156);
    local v159 = p155:_getCachedProductRobuxPrice(p157);
    local v160;
    if typeof(v158) == "number" and typeof(v159) == "number" then
        v160 = v158 == v159;
    else
        v160 = false;
    end;
    return v160;
end;
function u1._finishGiftRequest(p161) --[[ Line: 744 ]]
    p161._gift_requesting = false;
    p161._pending_gift_product_id = nil;
    p161._pending_gift_request_id = nil;
    p161:_queuePurchaseOptionsRefresh();
end;
function u1._setGiftBlockState(u162, u163, p164) --[[ Line: 751 ]]
    if typeof(u163) == "number" then
        if p164 == "route" and (u162._gift_block_state_by_product_id[u163] == "route" and u162._gift_route_tokens_by_product_id[u163] ~= nil) then
            u162:_queuePurchaseOptionsRefresh();
        else
            u162._gift_block_state_by_product_id[u163] = p164;
            if p164 == "route" then
                local u165 = {};
                u162._gift_route_tokens_by_product_id[u163] = u165;
                task.delay(301, function() --[[ Line: 768 ]]
                    -- upvalues: u162 (copy), u163 (copy), u165 (copy)
                    if u162._gift_route_tokens_by_product_id[u163] == u165 then
                        u162._gift_route_tokens_by_product_id[u163] = nil;
                        u162._gift_block_state_by_product_id[u163] = nil;
                        u162:_queuePurchaseOptionsRefresh();
                    end;
                end);
            else
                u162._gift_route_tokens_by_product_id[u163] = nil;
            end;
            u162:_queuePurchaseOptionsRefresh();
        end;
    end;
end;
function u1._openBannerGiftBrowser(u166, u167) --[[ Line: 781 ]]
    -- upvalues: l__Classes__13 (copy), l__HttpService__1 (copy), l__Packets__8 (copy)
    if u166._gift_browser_open or u166._gift_requesting then
    elseif typeof(u167) == "table" and typeof(u167.product_id) == "number" then
        local l___xb90403a8caac4128__32 = l__Classes__13._xb90403a8caac4128;
        if l___xb90403a8caac4128__32 and typeof(l___xb90403a8caac4128__32._x003a1e06c5ce82d3) == "function" then
            u166._gift_browser_open = true;
            u166:_queuePurchaseOptionsRefresh();
            local v170 = l___xb90403a8caac4128__32:_x003a1e06c5ce82d3("PlayerBrowser", {
                ignore_self = true,
                max_select = 1,
                header_text = "GIFT BANNER",
                selected_callback = function(p168) --[[ Name: selected_callback, Line 802 ]]
                    -- upvalues: l__HttpService__1 (ref), u166 (copy), u167 (copy), l__Packets__8 (ref)
                    if p168 then
                        p168 = p168[1];
                    end;
                    if typeof(p168) == "number" then
                        local u169 = l__HttpService__1:GenerateGUID(false);
                        u166._gift_requesting = true;
                        u166._pending_gift_product_id = u167.product_id;
                        u166._pending_gift_request_id = u169;
                        u166:_queuePurchaseOptionsRefresh();
                        l__Packets__8._xb107e17a2a93fbac:Fire({
                            op = "gift_dev_product",
                            product_id = u167.product_id,
                            recipient_user_id = p168,
                            request_id = u169
                        });
                        task.delay(30, function() --[[ Line: 820 ]]
                            -- upvalues: u166 (ref), u169 (copy)
                            if u166._pending_gift_request_id == u169 then
                                u166:_finishGiftRequest();
                            end;
                        end);
                    end;
                end
            });
            if v170 then
                local l__destroy__33 = v170.destroy;
                function v170.destroy(p171, ...) --[[ Line: 835 ]]
                    -- upvalues: u166 (copy), l__destroy__33 (copy)
                    u166._gift_browser_open = false;
                    u166:_queuePurchaseOptionsRefresh();
                    return l__destroy__33(p171, ...);
                end;
            else
                u166._gift_browser_open = false;
                u166:_queuePurchaseOptionsRefresh();
            end;
        end;
    end;
end;
function u1._findLowestRobuxCrimsonOption(p172, p173) --[[ Line: 842 ]]
    -- upvalues: l__DealsDef__6 (copy)
    local v174 = nil;
    for _, v175 in ipairs(l__DealsDef__6.CrimsonOptions) do
        if typeof(v175) == "table" and (typeof(v175.crimson_amount) == "number" and v175.crimson_amount >= p173) then
            local v176 = p172:_getProductRobuxPrice(v175.product_id);
            if v176 and (not v174 or (v176 < v174.robux_price or v176 == v174.robux_price and v175.crimson_amount < v174.crimson_amount)) then
                v174 = {
                    product_id = v175.product_id,
                    crimson_amount = v175.crimson_amount,
                    robux_price = v176
                };
            end;
        end;
    end;
    return v174;
end;
function u1._getCachedRobuxCrimsonOption(u177, p178) --[[ Line: 874 ]]
    -- upvalues: l__BannerUtil__5 (copy)
    if l__BannerUtil__5.isRandomBanner(p178) then
        if u177:_getPaidRandomItemsRestricted() == false then
            local u179;
            if typeof(p178.crimson_price) == "number" then
                local v180 = math.floor(p178.crimson_price);
                u179 = math.max(1, v180);
            else
                u179 = 0;
            end;
            if u179 <= 0 then
                return nil;
            else
                local v181 = u177.robux_crimson_option_by_min_crimson[u179];
                if v181 == nil then
                    if u177.robux_crimson_option_fetching[u179] then
                        return nil;
                    end;
                    u177.robux_crimson_option_fetching[u179] = true;
                    task.spawn(function() --[[ Line: 899 ]]
                        -- upvalues: u177 (copy), u179 (copy)
                        local v182 = u177:_findLowestRobuxCrimsonOption(u179);
                        u177.robux_crimson_option_by_min_crimson[u179] = v182 or false;
                        u177.robux_crimson_option_fetching[u179] = nil;
                        u177:_queuePurchaseOptionsRefresh();
                    end);
                    return nil;
                elseif typeof(v181) == "table" then
                    return v181;
                else
                    return nil;
                end;
            end;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._getPurchaseOptionsForBanner(p183, p184, p185) --[[ Line: 909 ]]
    -- upvalues: l__BannerUtil__5 (copy), l__Classes__13 (copy)
    local v186 = {};
    if not l__BannerUtil__5.isDirectPurchaseBanner(p184) then
        if not l__BannerUtil__5.isRandomBanner(p184) then
            return v186;
        end;
        if typeof(p184.crimson_price) == "number" and p184.crimson_price > 0 then
            local v187 = p183:_getCrimsonValue() >= p184.crimson_price;
            local v188 = p183:_getCachedRobuxCrimsonOption(p184);
            local v189 = {
                key = "extract:crimson",
                kind = "extract",
                currency = "crimson",
                show_crimson = true,
                layout_order = 1,
                banner_id = p184.id,
                price = p184.crimson_price,
                display_text = tostring(p184.crimson_price),
                locked = not v187,
                enabled = p183.pull_in_flight ~= true
            };
            table.insert(v186, v189);
            if not v187 and v188 then
                local v190 = {
                    kind = "robux",
                    layout_order = 2,
                    key = "robux:" .. tostring(v188.product_id),
                    banner_id = p184.id,
                    product_id = v188.product_id,
                    crimson_amount = v188.crimson_amount,
                    robux_price = v188.robux_price,
                    price_text = "" .. "<b>" .. tostring(v188.robux_price) .. "</b>",
                    crimson_amount_text = tostring(v188.crimson_amount),
                    enabled = p183.pull_in_flight ~= true
                };
                table.insert(v186, v190);
            end;
        end;
        if p185 == true and p184.yen_buyable == true then
            local v191 = {
                key = "extract:yen",
                kind = "extract",
                currency = "yen",
                show_crimson = false,
                layout_order = 3,
                banner_id = p184.id,
                price = p184.yen_price,
                display_text = "¥" .. l__Classes__13.Util:formatNumber(p184.yen_price),
                locked = p183:_getYenValue() < p184.yen_price
            };
            local v192;
            if p183.pull_in_flight == true then
                v192 = false;
            else
                v192 = p183:_getYenValue() >= p184.yen_price;
            end;
            v191.enabled = v192;
            table.insert(v186, v191);
        end;
        return v186;
    end;
    local l__product_id__34 = p184.product_id;
    local v193 = p183:_getCachedProductRobuxPrice(l__product_id__34);
    if typeof(l__product_id__34) == "number" and v193 then
        local v194 = {
            kind = "robux",
            extra_visible = true,
            direct_purchase = true,
            layout_order = 1,
            key = "robux:" .. tostring(l__product_id__34),
            banner_id = p184.id,
            product_id = l__product_id__34,
            robux_price = v193,
            price_text = "" .. "<b>" .. tostring(v193) .. "</b>"
        };
        local v195;
        if p184 then
            v195 = p184.items;
        else
            v195 = p184;
        end;
        local v196;
        if typeof(v195) == "table" and #v195 == 1 then
            local v197 = v195[1];
            v196 = typeof(v197) == "table" and v197.grant_type == "skin" and "PURCHASE SKIN" or (typeof(v197) == "table" and v197.grant_type == "title" and "PURCHASE TITLE" or "PURCHASE BUNDLE");
        else
            v196 = "PURCHASE BUNDLE";
        end;
        v194.crimson_amount_text = v196;
        v194.enabled = p183.pull_in_flight ~= true;
        table.insert(v186, v194);
    end;
    local l__gift_product_id__35 = p184.gift_product_id;
    if typeof(l__product_id__34) == "number" and typeof(l__gift_product_id__35) == "number" then
        local v198 = p183:_getGiftInventoryCount(l__gift_product_id__35);
        local v199 = p183:_giftProductHasMatchingPrice(l__product_id__34, l__gift_product_id__35);
        local v200 = p183:_getCachedProductRobuxPrice(l__gift_product_id__35);
        local v201 = p183:_hasOutboundGift(l__gift_product_id__35) or p183._gift_block_state_by_product_id[l__gift_product_id__35] ~= nil;
        local v202;
        if v198 > 0 then
            v202 = true;
        elseif v199 then
            v202 = not v201;
        else
            v202 = v199;
        end;
        if v198 > 0 or v199 then
            local v203 = {
                kind = "gift_robux",
                extra_visible = true,
                direct_purchase = true,
                layout_order = 2,
                key = "gift_robux:" .. tostring(l__gift_product_id__35),
                banner_id = p184.id,
                product_id = l__gift_product_id__35,
                source_product_id = l__product_id__34,
                robux_price = v200,
                price_text = v198 > 0 and "SEND" or "" .. "<b>" .. tostring(v200) .. "</b>"
            };
            local v204;
            if p184 then
                v204 = p184.items;
            else
                v204 = p184;
            end;
            local v205;
            if typeof(v204) == "table" and #v204 == 1 then
                local v206 = v204[1];
                v205 = typeof(v206) == "table" and v206.grant_type == "skin" and "PURCHASE SKIN" or (typeof(v206) == "table" and v206.grant_type == "title" and "PURCHASE TITLE" or "PURCHASE BUNDLE");
            else
                v205 = "PURCHASE BUNDLE";
            end;
            v203.crimson_amount_text = v205:gsub("^PURCHASE", "GIFT");
            if p183.pull_in_flight == true or p183._gift_browser_open == true then
                v202 = false;
            elseif p183._gift_requesting == true then
                v202 = false;
            end;
            v203.enabled = v202;
            table.insert(v186, v203);
        end;
    end;
    if typeof(p184.crimson_price) == "number" and p184.crimson_price > 0 then
        local v207 = p183:_getCrimsonValue() >= p184.crimson_price;
        local v208 = {
            key = "purchase:crimson",
            kind = "extract",
            currency = "crimson",
            show_crimson = true,
            layout_order = 3,
            banner_id = p184.id,
            price = p184.crimson_price,
            display_text = tostring(p184.crimson_price),
            locked = not v207,
            enabled = p183.pull_in_flight ~= true
        };
        table.insert(v186, v208);
    end;
    return v186;
end;
function u1.getBannerPurchaseOptions(p209, p210, p211) --[[ Line: 1032 ]]
    local v212 = p209:getBannerById(p210);
    return not v212 and {} or p209:_getPurchaseOptionsForBanner(v212, p211);
end;
function u1._buildSkinSlotFromEntry(_, p213, p214, p215) --[[ Line: 1041 ]]
    -- upvalues: l__SkinDefs__9 (copy), l__ItemDef__7 (copy)
    local l__item_id__36 = p213.item_id;
    local l__def__37 = p213.def;
    if not l__def__37 then
        if typeof(p213.item_id) == "string" then
            l__def__37 = l__SkinDefs__9.getSkin(p213.item_id, p213.id) or nil;
        else
            l__def__37 = nil;
        end;
    end;
    if typeof(l__def__37) == "table" and typeof(l__def__37.item_id) == "string" then
        l__item_id__36 = l__def__37.item_id;
    end;
    local v216;
    if typeof(l__item_id__36) == "string" then
        v216 = l__ItemDef__7.getDefs()[l__item_id__36] or nil;
    else
        v216 = nil;
    end;
    local v217 = typeof(l__def__37) == "table" and (tostring(l__def__37.creator or "") or "") or "";
    return {
        grant_type = "skin",
        unlocked = true,
        slot_id = p214,
        def = l__def__37,
        id = p213.id,
        item_id = p213.item_id,
        name = p213.name,
        rarity = p213.rarity,
        show_amount = typeof(p215) == "string",
        amount_text = p215,
        action_kind = typeof(l__def__37) == "table" and "apply_skin" or "none",
        detail_item_text = tostring(v216 and v216.name or (l__item_id__36 or "")),
        detail_name_text = tostring(p213.name or ""),
        detail_credit_text = v217 == "" and "BANNER GRANT" or "CREATED BY " .. v217,
        detail_rarity_text = tostring(p213.rarity or "")
    };
end;
function u1._buildTitleSlotFromEntry(_, p218, p219, p220, p221, p222) --[[ Line: 1070 ]]
    -- upvalues: l__Classes__13 (copy), u51 (copy)
    local v223 = (not p222 or (typeof(p221) ~= "number" or p221 <= 0)) and "TITLE REWARD" or "DUPLICATE REFUND | " .. "¥" .. l__Classes__13.Util:formatNumber(p221);
    local v224 = {
        grant_type = "title",
        unlocked = true,
        action_kind = "none",
        detail_item_text = "TITLE",
        slot_id = p219,
        id = p218.id,
        title_cenum = p218.id,
        name = p218.name or u51(p218.id),
        rarity = p218.rarity,
        show_amount = typeof(p220) == "string",
        amount_text = p220,
        duplicate_refund_yen = p221 or 0
    };
    local v225 = p218.name or u51(p218.id);
    v224.detail_name_text = tostring(v225);
    v224.detail_credit_text = v223;
    v224.detail_rarity_text = tostring(p218.rarity or "");
    return v224;
end;
function u1._buildBannerPreviewSlots(p226, p227) --[[ Line: 1095 ]]
    -- upvalues: l__BannerUtil__5 (copy), u37 (copy)
    local v228 = {};
    if l__BannerUtil__5.isDirectPurchaseBanner(p227) then
        for _, v229 in ipairs(p227.items) do
            local v230 = `banner-preview:{p227.id}:{v229.entry_index}`;
            if v229.grant_type == "skin" then
                table.insert(v228, p226:_buildSkinSlotFromEntry(v229, v230, nil));
            else
                table.insert(v228, p226:_buildTitleSlotFromEntry(v229, v230, nil));
            end;
        end;
        return v228;
    end;
    local v231 = {};
    for v232, v233 in ipairs(p227.pool) do
        v231[v232] = l__BannerUtil__5.getEffectiveEntryProbability(v233);
    end;
    local v234 = u37(v231);
    for v235, v236 in ipairs(p227.pool) do
        local v237 = v234[v235];
        local v238 = `banner-preview:{p227.id}:{v236.entry_index}`;
        if v236.grant_type == "skin" then
            table.insert(v228, p226:_buildSkinSlotFromEntry(v236, v238, v237));
        else
            table.insert(v228, p226:_buildTitleSlotFromEntry(v236, v238, v237));
        end;
    end;
    return v228;
end;
function u1._buildDirectPurchaseResultSlots(p239, p240) --[[ Line: 1131 ]]
    -- upvalues: l__SkinDefs__9 (copy), u51 (copy)
    local v241 = {};
    local v242;
    if p240 then
        v242 = p240.grants;
    else
        v242 = p240;
    end;
    if typeof(v242) ~= "table" then
        return v241;
    end;
    local v243 = tostring(p240.banner_id or "");
    for v244, v245 in ipairs(v242) do
        if typeof(v245) == "table" then
            local v246 = `direct-purchase:{v243}:{v244}:{v245.item_id or ""}:{v245.id or ""}`;
            if v245.grant_type == "skin" then
                local v247 = {
                    id = v245.id,
                    item_id = v245.item_id,
                    name = v245.name,
                    rarity = v245.rarity
                };
                local v248;
                if typeof(v245.item_id) == "string" then
                    v248 = l__SkinDefs__9.getSkin(v245.item_id, v245.id) or nil;
                else
                    v248 = nil;
                end;
                v247.def = v248;
                local v249 = p239:_buildSkinSlotFromEntry(v247, v246, "1x");
                table.insert(v241, v249);
            elseif v245.grant_type == "title" then
                local v250 = {
                    id = v245.id,
                    name = v245.name or u51(v245.id),
                    rarity = v245.rarity
                };
                table.insert(v241, p239:_buildTitleSlotFromEntry(v250, v246, "1x", nil, false));
            end;
        end;
    end;
    return v241;
end;
function u1._rollDummyRarity(_, p251, p252) --[[ Line: 1168 ]]
    -- upvalues: l__BannerUtil__5 (copy)
    local v253 = p252:NextNumber();
    local v254 = p251.pool[1] and (p251.pool[1].rarity or "Uncommon") or "Uncommon";
    local v255 = 0;
    for _, v256 in ipairs(p251.probabilities) do
        local v257 = l__BannerUtil__5.getEffectiveRarityProbability(p251, v256.rarity);
        if v257 > 0 then
            v255 = v255 + v257;
            if v253 < v255 then
                return v256.rarity;
            end;
            v254 = v256.rarity;
        end;
    end;
    return v254;
end;
function u1._buildRevealDummySlot(_, p258, p259, p260) --[[ Line: 1189 ]]
    return {
        grant_type = "dummy",
        unlocked = true,
        action_kind = "none",
        is_dummy = true,
        selectable = false,
        show_amount = false,
        centerlock_visible = true,
        hide_viewport = true,
        slot_id = `banner-reveal-dummy:{p258.id}:{p259}`,
        name = p260,
        rarity = p260
    };
end;
function u1._buildWinningRevealSlot(p261, p262, p263) --[[ Line: 1205 ]]
    -- upvalues: l__HttpService__1 (copy), l__SkinDefs__9 (copy), u51 (copy)
    local v264;
    if p262 then
        v264 = p262.grant;
    else
        v264 = p262;
    end;
    if typeof(v264) ~= "table" then
        return nil;
    end;
    local v265 = `banner-reveal-win:{p263.id}:{p262.request_id or l__HttpService__1:GenerateGUID(false)}`;
    if v264.grant_type ~= "skin" then
        if v264.grant_type ~= "title" then
            return nil;
        end;
        local v266 = p261:_buildTitleSlotFromEntry({
            id = v264.id,
            name = v264.name or u51(v264.id),
            rarity = v264.rarity
        }, v265, nil, p262.duplicate_refund_yen, v264.duplicate == true);
        v266.hide_viewport = true;
        v266.centerlock_visible = true;
        v266.selectable = false;
        return v266;
    end;
    local v267 = {
        id = v264.id,
        item_id = v264.item_id,
        name = v264.name,
        rarity = v264.rarity
    };
    local v268;
    if typeof(v264.item_id) == "string" then
        v268 = l__SkinDefs__9.getSkin(v264.item_id, v264.id) or nil;
    else
        v268 = nil;
    end;
    v267.def = v268;
    local v269 = p261:_buildSkinSlotFromEntry(v267, v265, nil);
    v269.hide_viewport_until_landed = true;
    v269.centerlock_visible = true;
    v269.selectable = false;
    return v269;
end;
function u1._buildRevealSlots(p270, p271, p272) --[[ Line: 1245 ]]
    -- upvalues: u2 (copy)
    local v273 = p270:_buildWinningRevealSlot(p272, p271);
    if not v273 then
        return nil;
    end;
    local l__rarity__38 = v273.rarity;
    local v274;
    if typeof(l__rarity__38) == "string" and l__rarity__38 ~= "" then
        v274 = u2[l__rarity__38];
    else
        v274 = nil;
    end;
    local v275 = math.floor((not v274 and 1 or (2.8 + v274.extra_scroll_duration) / 2.8) * 40 + 0.5);
    local v276 = math.max(40, v275);
    local v277 = math.floor(v276 * 0.75 + 0.5);
    local v278 = math.clamp(v277, 1, v276);
    local v279 = Random.new();
    local v280 = {};
    for v281 = 1, v276 do
        if v281 == v278 then
            table.insert(v280, v273);
        else
            local v282 = p270:_rollDummyRarity(p271, v279);
            table.insert(v280, p270:_buildRevealDummySlot(p271, v281, v282));
        end;
    end;
    if #v280 < v278 then
        table.insert(v280, v273);
    end;
    return v280;
end;
function u1.getRevealRerollOption(p283, p284, p285) --[[ Line: 1279 ]]
    -- upvalues: l__Classes__13 (copy)
    local v286 = p283:getBannerById(p284);
    if v286 and not p283.pull_in_flight then
        if p285 == "crimson" then
            return p283:_getCrimsonValue() >= v286.crimson_price and {
                show_crimson = true,
                banner = v286,
                banner_id = v286.id,
                currency = p285,
                price = v286.crimson_price,
                display_text = tostring(v286.crimson_price)
            } or nil;
        elseif p285 == "yen" then
            return v286.yen_buyable == true and p283:_getYenValue() >= v286.yen_price and {
                show_crimson = false,
                banner = v286,
                banner_id = v286.id,
                currency = p285,
                price = v286.yen_price,
                display_text = "¥" .. l__Classes__13.Util:formatNumber(v286.yen_price)
            } or nil;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._applyOptimisticBalances(p287, p288) --[[ Line: 1318 ]]
    if p288 then
        p288 = p288.balances;
    end;
    if typeof(p288) == "table" then
        if p287.yen_inst and typeof(p288.yen) == "number" then
            p287.yen_inst.Value = p288.yen;
        end;
        if p287.crimson_inst and typeof(p288.crimson) == "number" then
            p287.crimson_inst.Value = p288.crimson;
        end;
    end;
end;
function u1._applyOptimisticGrantPayload(p289, p290, p291) --[[ Line: 1333 ]]
    -- upvalues: u58 (copy), l__BannerUtil__5 (copy), l__TitleData__10 (copy)
    local l__item_profile_data__39 = p289._menu_session.item_profile_data;
    if typeof(l__item_profile_data__39) ~= "table" then
        l__item_profile_data__39 = {};
        p289._menu_session.item_profile_data = l__item_profile_data__39;
    end;
    if typeof(p291) == "table" then
        if p291.grant_type == "skin" then
            local v292 = u58(l__item_profile_data__39, p291.item_id, p291.id);
            if v292 then
                local v293;
                if typeof(p291.skin_count) == "number" then
                    local v294 = math.floor(p291.skin_count);
                    v293 = math.max(1, v294);
                else
                    v293 = nil;
                end;
                v292.count = v293 or v292.count + 1;
                v292.source = "banner:" .. p290;
                v292.metadata = l__BannerUtil__5.copyValue(p291.metadata or {});
            end;
        elseif p291.grant_type == "title" and p291.duplicate ~= true then
            local v295 = l__TitleData__10[p291.id];
            l__item_profile_data__39.owned_titles = l__item_profile_data__39.owned_titles or {};
            l__item_profile_data__39.owned_titles[tostring(p291.id)] = {
                seen = typeof(v295) == "table" and v295.autoseen == true,
                source = "banner:" .. p290,
                metadata = l__BannerUtil__5.copyValue(p291.metadata or {})
            };
        end;
    end;
end;
function u1._applyOptimisticGrant(p296, p297) --[[ Line: 1363 ]]
    local v298 = tostring(p297 and (p297.banner_id or "") or "");
    if p297 then
        p297 = p297.grant;
    end;
    p296:_applyOptimisticGrantPayload(v298, p297);
end;
function u1._applyOptimisticGrants(p299, p300) --[[ Line: 1367 ]]
    local v301 = tostring(p300 and (p300.banner_id or "") or "");
    if p300 then
        p300 = p300.grants;
    end;
    if typeof(p300) == "table" then
        for _, v302 in ipairs(p300) do
            p299:_applyOptimisticGrantPayload(v301, v302);
        end;
    end;
end;
function u1._notifyPullError(_, p303) --[[ Line: 1379 ]]
    -- upvalues: l__Classes__13 (copy), u3 (copy)
    if p303 == "insufficient_eligible_crimson" then
        l__Classes__13._xce372113b7898ad8:_xe128b65f7c0821aa({
            play_sound = true,
            main_text = u3[p303]
        });
    end;
end;
function u1._buildRevealStartParams(_, p304, p305, p306) --[[ Line: 1390 ]]
    -- upvalues: u2 (copy)
    if p306 then
        p306 = p306.grant;
    end;
    local v307;
    if typeof(p306) == "table" and typeof(p306.rarity) == "string" then
        v307 = p306.rarity;
    else
        v307 = nil;
    end;
    local v308;
    if typeof(v307) == "string" and v307 ~= "" then
        v308 = u2[v307];
    else
        v308 = nil;
    end;
    return {
        page_title = "EXTRACT",
        intro_type = "extract",
        mode = "banner_reveal",
        aggregate_slots = false,
        extracted_rarity = v307,
        reveal_scroll_bonus_duration = v308 and (v308.extra_scroll_duration or 0) or 0,
        reveal_hold_duration = v308 and v308.hold_duration or 0,
        banner_id = p304.id,
        source_currency = p305,
        return_page_args = { "Cosmetics" }
    };
end;
function u1._showRevealPage(p309, p310, p311, p312) --[[ Line: 1409 ]]
    -- upvalues: l__InternalSymbols__14 (copy)
    local v313 = l__InternalSymbols__14.owner("ShowcasePage", p310);
    if v313 and v313.start then
        v313:start(p311, "shop_page", p312);
    else
        p309._menu_session:openPage("showcase_page", p311, "shop_page", p312);
    end;
end;
function u1._handleFailedPullResponse(p314, p315) --[[ Line: 1419 ]]
    local v316;
    if typeof(p315) == "table" then
        v316 = p315.error_code;
    else
        v316 = nil;
    end;
    local _ = v316 == "insufficient_crimson";
    if (v316 == "unknown_banner" or v316 == "banner_expired") and true or v316 == "banner_not_started" then
        p314:_refreshView();
    end;
    p314:_notifyPullError(v316 or "internal_error");
end;
function u1._presentSuccessfulPull(p317, p318, p319, p320, p321) --[[ Line: 1433 ]]
    p317:_applyOptimisticBalances(p320);
    p317:_applyOptimisticGrant(p320);
    local v322 = p317:_buildRevealSlots(p318, p320);
    if v322 then
        p317:_showRevealPage(p321, v322, p317:_buildRevealStartParams(p318, p319, p320));
    else
        p317:_notifyPullError("internal_error");
    end;
end;
function u1._showDirectPurchaseResultPage(p323, p324, p325) --[[ Line: 1446 ]]
    -- upvalues: l__InternalSymbols__14 (copy)
    local v326 = l__InternalSymbols__14.owner("ShowcasePage", p325);
    local v327 = p323:_buildDirectPurchaseResultSlots(p324);
    if #v327 <= 0 then
    else
        local v328;
        if p324 then
            v328 = p324.banner_display_name;
        else
            v328 = p324;
        end;
        local v329 = {
            mode = "direct_purchase_result",
            aggregate_slots = false,
            page_title = (typeof(v328) ~= "string" or p324.banner_display_name == "") and "PURCHASE" or p324.banner_display_name,
            return_page_args = { "Cosmetics" }
        };
        if v326 and v326.start then
            v326:start(v327, "shop_page", v329);
        else
            p323._menu_session:openPage("showcase_page", v327, "shop_page", v329);
        end;
    end;
end;
function u1._presentSuccessfulDirectPurchase(p330, _, _, p331, p332) --[[ Line: 1471 ]]
    p330:_applyOptimisticBalances(p331);
    p330:_applyOptimisticGrants(p331);
    p330:_queuePurchaseOptionsRefresh();
    p330:_showDirectPurchaseResultPage(p331, p332);
end;
function u1._presentSuccessfulBannerPurchase(p333, p334, p335, p336, p337) --[[ Line: 1478 ]]
    -- upvalues: l__BannerUtil__5 (copy)
    if l__BannerUtil__5.isDirectPurchaseBanner(p334) then
        p333:_presentSuccessfulDirectPurchase(p334, p335, p336, p337);
    else
        p333:_presentSuccessfulPull(p334, p335, p336, p337);
    end;
end;
function u1._openBannerPreview(p338, p339) --[[ Line: 1487 ]]
    local v340 = p338:_buildBannerPreviewSlots(p339);
    p338._menu_session:openPage("showcase_page", v340, "shop_page", {
        page_title = "CONTENTS",
        mode = "banner_preview",
        aggregate_slots = false,
        banner_id = p339.id,
        return_page_args = { "Cosmetics" }
    });
end;
function u1.openBannerPreviewById(p341, p342) --[[ Line: 1498 ]]
    local v343 = p341:getBannerById(p342);
    if not v343 then
        return false;
    end;
    p341:_openBannerPreview(v343);
    return true;
end;
function u1._handlePullResponse(p344, p345, p346, p347) --[[ Line: 1508 ]]
    if typeof(p347) == "table" then
        if p347.ok == true then
            p344:_presentSuccessfulBannerPurchase(p345, p346, p347, nil);
        else
            p344:_handleFailedPullResponse(p347);
        end;
    else
        p344:_notifyPullError("internal_error");
    end;
end;
function u1._startShowcaseBannerPull(u348, p349, u350, u351) --[[ Line: 1522 ]]
    -- upvalues: l__InternalSymbols__14 (copy), l__Classes__13 (copy), l__HttpService__1 (copy), l__Packets__8 (copy)
    local u352 = l__InternalSymbols__14.owner("ShowcasePage", p349);
    local u353;
    if u352 then
        u353 = u352.open_id or nil;
    else
        u353 = nil;
    end;
    l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("EXTRACT_SOUND", true);
    u348.pull_in_flight = true;
    u348:_updateInteractableState();
    if u352 then
        u352:_setInteractionLocked(true);
        u352:_updateActions();
    end;
    local u354 = l__HttpService__1:GenerateGUID(false);
    task.spawn(function() --[[ Line: 1536 ]]
        -- upvalues: l__Packets__8 (ref), u354 (copy), u350 (copy), u351 (copy), u348 (copy), u352 (ref), u353 (copy)
        local v355, v356 = pcall(function() --[[ Line: 1537 ]]
            -- upvalues: l__Packets__8 (ref), u354 (ref), u350 (ref), u351 (ref)
            return l__Packets__8._x40d842b9563b38e9:Fire(u354, u350.id, u351);
        end);
        u348.pull_in_flight = false;
        u348:_updateInteractableState();
        if u352 and u352.open_id ~= u353 then
        elseif v355 then
            if typeof(v356) == "table" then
                if v356.ok == true then
                    u348:_presentSuccessfulBannerPurchase(u350, u351, v356, u352);
                else
                    if u352 then
                        u352:_setInteractionLocked(false);
                        u352:_updateActions();
                    end;
                    u348:_handleFailedPullResponse(v356);
                end;
            else
                if u352 then
                    u352:_setInteractionLocked(false);
                    u352:_updateActions();
                end;
                u348:_notifyPullError("internal_error");
            end;
        else
            if u352 then
                u352:_setInteractionLocked(false);
                u352:_updateActions();
            end;
            u348:_notifyPullError("internal_error");
        end;
    end);
    return true;
end;
function u1.startBannerPullFromShowcase(p357, p358, p359, p360) --[[ Line: 1581 ]]
    -- upvalues: l__InternalSymbols__14 (copy), l__Classes__13 (copy)
    local v361 = l__InternalSymbols__14.owner("ShowcasePage", p358);
    local v362 = p357:getBannerById(p359);
    if v362 and not p357.pull_in_flight then
        if p360 == "crimson" then
            if typeof(v362.crimson_price) ~= "number" then
                return false;
            end;
            if p357:_getCrimsonValue() < v362.crimson_price then
                l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("UI_CLICK", true);
                return false;
            end;
        end;
        if p360 == "yen" and (v362.yen_buyable ~= true or p357:_getYenValue() < v362.yen_price) then
            return false;
        else
            return p357:_startShowcaseBannerPull(v361, v362, p360);
        end;
    else
        if v361 and v361._updateActions then
            v361:_updateActions();
        end;
        return false;
    end;
end;
function u1.startRevealReroll(p363, p364, p365, p366) --[[ Line: 1612 ]]
    -- upvalues: l__InternalSymbols__14 (copy)
    local v367 = l__InternalSymbols__14.owner("ShowcasePage", p364);
    local v368 = p363:getRevealRerollOption(p365, p366);
    if v368 then
        return p363:_startShowcaseBannerPull(v367, v368.banner, v368.currency);
    end;
    if v367 and v367._updateActions then
        v367:_updateActions();
    end;
    return false;
end;
function u1.activateBannerPurchaseOption(p369, p370, p371) --[[ Line: 1625 ]]
    -- upvalues: l__Packets__8 (copy)
    if typeof(p371) == "table" then
        if p371.kind == "robux" then
            if typeof(p371.product_id) ~= "number" then
                return false;
            end;
            if typeof(p371.crimson_amount) == "number" and p369:_getPaidRandomItemsRestricted() ~= false then
                return false;
            end;
            l__Packets__8._xb107e17a2a93fbac:Fire(p371.product_id);
            return true;
        elseif p371.kind == "gift_robux" then
            p369:_openBannerGiftBrowser(p371);
            return true;
        elseif p371.kind == "extract" and (typeof(p371.banner_id) == "string" and typeof(p371.currency) == "string") then
            return p369:startBannerPullFromShowcase(p370, p371.banner_id, p371.currency);
        else
            return false;
        end;
    else
        return false;
    end;
end;
function u1._tryPullBanner(u372, u373) --[[ Line: 1655 ]]
    -- upvalues: l__Classes__13 (copy), l__HttpService__1 (copy), l__Packets__8 (copy)
    local u374 = u372:_getSelectedBanner();
    if u374 and not u372.pull_in_flight then
        if u373 == "crimson" then
            if typeof(u374.crimson_price) ~= "number" then
                return;
            end;
            if u372:_getCrimsonValue() < u374.crimson_price then
                l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("UI_CLICK", true);
                return;
            end;
        end;
        if u373 == "yen" then
            if u374.yen_buyable ~= true then
                return;
            end;
            if u372:_getYenValue() < u374.yen_price then
                return;
            end;
        end;
        l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("EXTRACT_SOUND", true);
        u372.pull_in_flight = true;
        u372:_updateInteractableState();
        local u375 = l__HttpService__1:GenerateGUID(false);
        task.spawn(function() --[[ Line: 1689 ]]
            -- upvalues: l__Packets__8 (ref), u375 (copy), u374 (copy), u373 (copy), u372 (copy)
            local v376, v377 = pcall(function() --[[ Line: 1690 ]]
                -- upvalues: l__Packets__8 (ref), u375 (ref), u374 (ref), u373 (ref)
                return l__Packets__8._x40d842b9563b38e9:Fire(u375, u374.id, u373);
            end);
            u372.pull_in_flight = false;
            u372:_updateInteractableState();
            if v376 then
                u372:_handlePullResponse(u374, u373, v377);
            else
                u372:_notifyPullError("internal_error");
            end;
        end);
    end;
end;
function u1._buildExtractButtons(u378, p379) --[[ Line: 1706 ]]
    -- upvalues: u10 (copy)
    local l__button_list__40 = u378:_getUi().button_list;
    local u380 = u378:_getExtractTemplate();
    local u381 = u378:_getRobuxTemplate();
    u378.banner_view_trove:Clean();
    u10(l__button_list__40, "GeneratedExtractButton");
    u378.extract_buttons = {};
    l__button_list__40.Visible = false;
    local v382 = u378:_getPurchaseOptionsForBanner(p379, true);
    local function v394(u383) --[[ Line: 1753 ]]
        -- upvalues: u381 (copy), u378 (copy), l__button_list__40 (copy)
        local v384 = u381:Clone();
        v384:SetAttribute("GeneratedExtractButton", true);
        v384.LayoutOrder = u383.layout_order;
        v384.Visible = true;
        if v384:IsA("GuiObject") then
            v384.Size = UDim2.fromScale(0.15, 1);
        end;
        local v385 = v384:FindFirstChild("PriceText");
        if not v385 then
            v385 = v384:FindFirstChild("PriceText", true);
            assert(v385, "CosmeticsTab UI is missing child: PriceText");
        end;
        local v386 = v384:FindFirstChild("Extra");
        if not v386 then
            v386 = v384:FindFirstChild("Extra", true);
            assert(v386, "CosmeticsTab UI is missing child: Extra");
        end;
        local v387 = v386:FindFirstChild("NumberFrame");
        if not v387 then
            v387 = v386:FindFirstChild("NumberFrame", true);
            assert(v387, "CosmeticsTab UI is missing child: NumberFrame");
        end;
        local v388 = v387:FindFirstChild("NumberText");
        if not v388 then
            v388 = v387:FindFirstChild("NumberText", true);
            assert(v388, "CosmeticsTab UI is missing child: NumberText");
        end;
        local v389;
        if v384:IsA("GuiButton") then
            v389 = v384;
        else
            v389 = v384:FindFirstChildWhichIsA("ImageButton", true) or v384:FindFirstChildWhichIsA("TextButton", true);
        end;
        local l__price_text__41 = u383.price_text;
        if v385 and v385:IsA("TextLabel") then
            v385.Text = l__price_text__41;
        elseif v385 and v385:IsA("TextButton") then
            v385.Text = l__price_text__41;
        end;
        local l__crimson_amount_text__42 = u383.crimson_amount_text;
        if v388 and v388:IsA("TextLabel") then
            v388.Text = l__crimson_amount_text__42;
        elseif v388 and v388:IsA("TextButton") then
            v388.Text = l__crimson_amount_text__42;
        end;
        if u383.direct_purchase == true then
            local v390 = v387:FindFirstChild("CrimsonImage");
            if not v390 then
                v390 = v387:FindFirstChild("CrimsonImage", true);
                assert(v390, "CosmeticsTab UI is missing child: CrimsonImage");
            end;
            local v391 = v387:FindFirstChild("Get");
            if not v391 then
                v391 = v387:FindFirstChild("Get", true);
                assert(v391, "CosmeticsTab UI is missing child: Get");
            end;
            v388.Size = UDim2.fromScale(1, 0.8);
            if v390 and v390:IsA("GuiObject") then
                v390.Visible = false;
            end;
            if v391 and v391:IsA("GuiObject") then
                v391.Visible = false;
            end;
        end;
        local v392 = u383.extra_visible ~= false;
        if v386 and v386:IsA("GuiObject") then
            v386.Visible = v392;
        end;
        local v393 = u383.enabled == true;
        if v389 then
            v389.Active = v393;
            v389.AutoButtonColor = v393;
            v389.Selectable = v393;
            v389.Interactable = v393;
        end;
        if v389 then
            u378.banner_view_trove:Connect(v389.Activated, function() --[[ Line: 1781 ]]
                -- upvalues: u378 (ref), u383 (copy)
                u378:activateBannerPurchaseOption(nil, u383);
            end);
        end;
        v384.Parent = l__button_list__40;
        u378.extract_buttons[u383.key] = {
            root = v384,
            button = v389,
            kind = u383.kind,
            product_id = u383.product_id
        };
    end;
    local function v405(u395) --[[ Line: 1717 ]]
        -- upvalues: u380 (copy), u378 (copy), l__button_list__40 (copy)
        local v396 = u380:Clone();
        v396:SetAttribute("GeneratedExtractButton", true);
        v396.LayoutOrder = u395.layout_order;
        v396.Visible = true;
        if v396:IsA("GuiObject") then
            v396.Size = UDim2.fromScale(0.15, 1);
        end;
        local v397 = v396:FindFirstChild("NumberFrame");
        if not v397 then
            v397 = v396:FindFirstChild("NumberFrame", true);
            assert(v397, "CosmeticsTab UI is missing child: NumberFrame");
        end;
        local v398 = v397:FindFirstChild("NumberText");
        if not v398 then
            v398 = v397:FindFirstChild("NumberText", true);
            assert(v398, "CosmeticsTab UI is missing child: NumberText");
        end;
        local v399 = v397:FindFirstChild("CrimsonImage");
        if not v399 then
            v399 = v397:FindFirstChild("CrimsonImage", true);
            assert(v399, "CosmeticsTab UI is missing child: CrimsonImage");
        end;
        local v400 = v396:FindFirstChild("LockedFrame");
        if not v400 then
            v400 = v396:FindFirstChild("LockedFrame", true);
            assert(v400, "CosmeticsTab UI is missing child: LockedFrame");
        end;
        local v401;
        if v396:IsA("GuiButton") then
            v401 = v396;
        else
            v401 = v396:FindFirstChildWhichIsA("ImageButton", true) or v396:FindFirstChildWhichIsA("TextButton", true);
        end;
        local l__display_text__43 = u395.display_text;
        if v398 and v398:IsA("TextLabel") then
            v398.Text = l__display_text__43;
        elseif v398 and v398:IsA("TextButton") then
            v398.Text = l__display_text__43;
        end;
        local v402 = u395.show_crimson == true;
        if v399 and v399:IsA("GuiObject") then
            v399.Visible = v402;
        end;
        local v403 = u395.locked == true;
        if v400 and v400:IsA("GuiObject") then
            v400.Visible = v403;
        end;
        local v404 = u395.enabled == true;
        if v401 then
            v401.Active = v404;
            v401.AutoButtonColor = v404;
            v401.Selectable = v404;
            v401.Interactable = v404;
        end;
        if v401 then
            u378.banner_view_trove:Connect(v401.Activated, function() --[[ Line: 1738 ]]
                -- upvalues: u378 (ref), u395 (copy)
                u378:_tryPullBanner(u395.currency);
            end);
        end;
        v396.Parent = l__button_list__40;
        u378.extract_buttons[u395.key] = {
            kind = "extract",
            root = v396,
            button = v401,
            currency = u395.currency,
            locked_frame = v400
        };
    end;
    for _, v406 in ipairs(v382) do
        l__button_list__40.Visible = true;
        if v406.kind == "extract" then
            v405(v406);
        elseif v406.kind == "robux" or v406.kind == "gift_robux" then
            v394(v406);
        end;
    end;
end;
function u1._updateInteractableState(p407) --[[ Line: 1806 ]]
    local v408 = p407:_getUi();
    local v409 = p407:_getSelectedBanner();
    local v410;
    if v409 == nil then
        v410 = false;
    else
        v410 = p407.pull_in_flight ~= true;
    end;
    local l__sub_label__44 = v408.sub_label;
    if l__sub_label__44 then
        l__sub_label__44.Active = v410;
        l__sub_label__44.AutoButtonColor = v410;
        l__sub_label__44.Selectable = v410;
        l__sub_label__44.Interactable = v410;
    end;
    local l__banner_button__45 = v408.banner_button;
    if l__banner_button__45 then
        l__banner_button__45.Active = v410;
        l__banner_button__45.AutoButtonColor = v410;
        l__banner_button__45.Selectable = v410;
        l__banner_button__45.Interactable = v410;
    end;
    for _, v411 in pairs(p407.extract_buttons) do
        if v411.kind == "extract" and (v411.currency == "yen" and v409) then
            local l__button__46 = v411.button;
            local v412;
            if v410 then
                v412 = p407:_getYenValue() >= v409.yen_price;
            else
                v412 = v410;
            end;
            if l__button__46 then
                l__button__46.Active = v412;
                l__button__46.AutoButtonColor = v412;
                l__button__46.Selectable = v412;
                l__button__46.Interactable = v412;
            end;
        elseif v411.kind == "extract" and (v411.currency == "crimson" and (v409 and typeof(v409.crimson_price) == "number")) then
            local l__button__47 = v411.button;
            if l__button__47 then
                l__button__47.Active = v410;
                l__button__47.AutoButtonColor = v410;
                l__button__47.Selectable = v410;
                l__button__47.Interactable = v410;
            end;
            local l__locked_frame__48 = v411.locked_frame;
            local v413 = p407:_getCrimsonValue() < v409.crimson_price;
            if l__locked_frame__48 and l__locked_frame__48:IsA("GuiObject") then
                l__locked_frame__48.Visible = v413;
            end;
        elseif v411.kind == "gift_robux" then
            local l__product_id__49 = v411.product_id;
            local v414 = p407:_getGiftInventoryCount(l__product_id__49) > 0;
            local v415 = (p407._gift_browser_open == true or p407._gift_requesting == true) and true or (p407:_hasOutboundGift(l__product_id__49) or p407._gift_block_state_by_product_id[l__product_id__49] ~= nil);
            local l__button__50 = v411.button;
            local v416;
            if v410 then
                v416 = v414 or not v415;
            else
                v416 = v410;
            end;
            if l__button__50 then
                l__button__50.Active = v416;
                l__button__50.AutoButtonColor = v416;
                l__button__50.Selectable = v416;
                l__button__50.Interactable = v416;
            end;
        else
            local l__button__51 = v411.button;
            if l__button__51 then
                l__button__51.Active = v410;
                l__button__51.AutoButtonColor = v410;
                l__button__51.Selectable = v410;
                l__button__51.Interactable = v410;
            end;
        end;
    end;
    for _, v417 in pairs(p407.banner_sections) do
        local v418 = v417:FindFirstChild("Button");
        local v419;
        if v418 then
            v419 = v418:IsA("GuiButton");
        else
            v419 = v418;
        end;
        assert(v419, "CosmeticsTab BannerSection is missing GuiButton child: Button");
        if v418 then
            v418.Active = v410;
            v418.AutoButtonColor = v410;
            v418.Selectable = v410;
            v418.Interactable = v410;
        end;
    end;
end;
function u1._applyBannerToView(p420, p421) --[[ Line: 1843 ]]
    local v422 = p420:_getUi();
    local v423 = p421.kind == "" and "BANNER" or p421.kind;
    v422.button_list.Visible = true;
    v422.info_frame.Visible = false;
    v422.banner_label.Text = p421.display_name;
    v422.banner2_label.Text = p421.display_name;
    v422.desc_label.Text = p421.description;
    v422.sub_label.Text = v423 .. " | CLICK FOR INFO <b>ⓘ</b>";
    if v422.banner_image:IsA("ImageButton") or v422.banner_image:IsA("ImageLabel") then
        v422.banner_image.Image = p421.banner_image;
    end;
    p420:_refreshRarityList(p421);
    p420:_buildExtractButtons(p421);
    p420:_updateTimerLoop(p421);
    p420:_updateSectionVisuals();
    p420:_updateInteractableState();
end;
function u1._refreshView(p424) --[[ Line: 1865 ]]
    p424.section_trove:Clean();
    p424.banner_view_trove:Clean();
    p424.timer_trove:Clean();
    p424:_refreshBannerData();
    if #p424.active_banners <= 0 then
        p424:_setEmptyState();
    else
        p424:_buildSectionList();
        local v425 = p424:_getSelectedBanner();
        if v425 then
            p424:_applyBannerToView(v425);
        else
            p424:_setEmptyState();
        end;
    end;
end;
function u1.selectBanner(p426, p427, p428) --[[ Line: 1887 ]]
    -- upvalues: l__Classes__13 (copy)
    if typeof(p427) == "string" and p427 ~= "" then
        if p426.selected_banner_id == p427 then
        else
            p426.selected_banner_id = p427;
            if p428 == true then
                l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("UI_CLICK", true);
            end;
            local v429 = p426:_getSelectedBanner();
            if v429 then
                p426:_applyBannerToView(v429);
            end;
        end;
    end;
end;
function u1.close(u430) --[[ Line: 1907 ]]
    -- upvalues: l__TweenService__3 (copy)
    l__TweenService__3:Create(u430.tab_asset, TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        GroupTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.2)
    }):Play();
    u430.tab_asset.Interactable = false;
    task.delay(0.2, function() --[[ Line: 1913 ]]
        -- upvalues: u430 (copy)
        if u430.tab_asset and (u430.tab_asset.Parent and u430.tab_asset.Interactable == false) then
            u430.tab_asset.Visible = false;
        end;
    end);
end;
function u1.open(p431) --[[ Line: 1920 ]]
    -- upvalues: l__TweenService__3 (copy)
    p431:_refreshView();
    p431.tab_asset.Position = UDim2.fromScale(0.5, -0.1);
    p431.tab_asset.GroupTransparency = 1;
    p431.tab_asset.Interactable = true;
    p431.tab_asset.Visible = true;
    l__TweenService__3:Create(p431.tab_asset, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.075)
    }):Play();
end;
function u1._bind(u432) --[[ Line: 1933 ]]
    -- upvalues: l__Classes__13 (copy), l__TweenService__3 (copy), l__Packets__8 (copy), l__MarketplaceService__2 (copy)
    local u433 = u432:_getUi();
    u432.yen_inst = l__Classes__13._x596eb619070480ba:_x99c2a19f9a3f5eff("yen");
    u432.crimson_inst = l__Classes__13._x596eb619070480ba:_x99c2a19f9a3f5eff("crimson");
    u432.trove:Connect(u433.sub_label.Activated, function() --[[ Line: 1939 ]]
        -- upvalues: u432 (copy), l__Classes__13 (ref)
        if u432.pull_in_flight or not u432:_getSelectedBanner() then
        else
            local v434 = u432:_getSelectedBanner();
            if u432.pull_in_flight or not v434 then
            else
                l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("UI_CLICK", true);
                u432:_openBannerPreview(v434);
            end;
        end;
    end);
    u432.trove:Connect(u433.banner_button.Activated, function() --[[ Line: 1953 ]]
        -- upvalues: u432 (copy), l__Classes__13 (ref)
        local v435 = u432:_getSelectedBanner();
        if u432.pull_in_flight or not v435 then
        else
            l__Classes__13._x02c5f8f89640473a:_xa2c2f0587694a915("UI_CLICK", true);
            u432:_openBannerPreview(v435);
        end;
    end);
    u432.trove:Connect(u433.banner_button.MouseEnter, function() --[[ Line: 1963 ]]
        -- upvalues: l__TweenService__3 (ref), u433 (copy)
        l__TweenService__3:Create(u433.banner_image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1.01, 1.01)
        }):Play();
    end);
    u432.trove:Connect(u433.banner_button.MouseLeave, function() --[[ Line: 1967 ]]
        -- upvalues: l__TweenService__3 (ref), u433 (copy)
        l__TweenService__3:Create(u433.banner_image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 1)
        }):Play();
    end);
    u432.trove:Connect(u432._menu_session.onItemProfileUpdated, function() --[[ Line: 1971 ]]
        -- upvalues: u432 (copy)
        if u432._menu_session.current_page == "shop_page" then
            u432:_queuePurchaseOptionsRefresh();
        end;
    end);
    u432.trove:Connect(l__Packets__8._x56d68a6b15750fcf.OnClientEvent, function(p436) --[[ Line: 1977 ]]
        -- upvalues: u432 (copy)
        if typeof(p436) == "table" then
            if p436.request_id == nil then
                if u432._pending_gift_product_id ~= nil and p436.product_id ~= u432._pending_gift_product_id then
                    return;
                end;
            elseif p436.request_id ~= u432._pending_gift_request_id then
                return;
            end;
            if p436.state == "prompting_purchase" or p436.state == "sending" then
                u432:_setGiftBlockState(p436.product_id, p436.state == "prompting_purchase" and "route" or "outbound");
            elseif p436.state == "purchase_settling" then
                u432:_setGiftBlockState(p436.product_id, "route");
            elseif p436.state == "delivery_pending" then
                u432:_setGiftBlockState(p436.product_id, "outbound");
            elseif p436.state == "rejected" or (p436.state == "recipient_busy" or (p436.state == "recipient_inbox_full" or (p436.state == "manual_remediation" or (p436.state == "delivered" or p436.state == "inventory_ready")))) then
                u432:_setGiftBlockState(p436.product_id, nil);
                u432:_finishGiftRequest();
            end;
            if p436.state == "purchase_settling" or p436.state == "delivery_pending" then
                u432:_finishGiftRequest();
            end;
        end;
    end);
    u432.trove:Connect(l__MarketplaceService__2.PromptProductPurchaseFinished, function(_, p437) --[[ Line: 2012 ]]
        -- upvalues: u432 (copy)
        if p437 == u432._pending_gift_product_id then
            u432:_finishGiftRequest();
        end;
    end);
    u432.trove:Connect(l__Packets__8._x27cb9fed7e43d530.OnClientEvent, function(p438) --[[ Line: 2018 ]]
        -- upvalues: u432 (copy)
        if typeof(p438) == "table" then
            u432:_presentSuccessfulDirectPurchase(nil, tostring(p438.currency or ""), p438, nil);
        end;
    end);
    u432.trove:Add(u432._menu_session:connectPolicyInfoUpdated(function() --[[ Line: 2026 ]]
        -- upvalues: u432 (copy)
        u432:_queuePurchaseOptionsRefresh();
    end));
    if u432.yen_inst then
        u432.trove:Connect(u432.yen_inst.Changed, function() --[[ Line: 2031 ]]
            -- upvalues: u432 (copy)
            if u432._menu_session.current_page == "shop_page" then
                u432:_refreshView();
            end;
        end);
    end;
    if u432.crimson_inst then
        u432.trove:Connect(u432.crimson_inst.Changed, function() --[[ Line: 2039 ]]
            -- upvalues: u432 (copy)
            u432:_queuePurchaseOptionsRefresh();
        end);
    end;
end;
function u1.start(p439) --[[ Line: 2045 ]]
    p439.tab_asset.Parent = p439.main_page.Main;
    p439:_getRarityLabelTemplate().Visible = false;
    p439:_getExtractTemplate().Visible = false;
    p439:_getRobuxTemplate().Visible = false;
end;
return u1;
