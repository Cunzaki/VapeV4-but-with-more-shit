-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.LoadoutPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__CEnum__3 = require(l__ModuleScripts__2.CEnum);
local l__ItemDef__4 = require(l__ModuleScripts__2.ItemDef);
local l__Packets__5 = require(l__ModuleScripts__2.Packets);
local l__SkinDefs__6 = require(l__ModuleScripts__2.SkinDefs);
local l__Trove__7 = require(l__ModuleScripts__2.Trove);
local l__UIAssets__8 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__9 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__10 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local u2 = { "gun", "melee" };
local u3 = {
    gun = true,
    melee = true
};
local function u6(p4) --[[ Line: 44 ]]
    for _, v5 in p4:GetChildren() do
        if not (v5:IsA("UIListLayout") or (v5:IsA("UIGridLayout") or v5:IsA("UIPadding"))) then
            v5:Destroy();
        end;
    end;
end;
local function u11(p7, p8) --[[ Line: 54 ]]
    if p7:IsA("TextLabel") then
        p7.Text = p8;
    elseif p7:IsA("TextButton") then
        p7.Text = p8;
    else
        local v9 = p7:FindFirstChildWhichIsA("TextLabel", true);
        if v9 then
            v9.Text = p8;
        else
            local v10 = p7:FindFirstChildWhichIsA("TextButton", true);
            if v10 then
                v10.Text = p8;
            end;
        end;
    end;
end;
function u1.new(p12, p13) --[[ Line: 112 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__10 (copy), l__UIAssets__8 (copy), l__Trove__7 (copy)
    local v14 = setmetatable({}, u1);
    v14.menu_session = l__InternalSymbols__10.owner("MenuSession", p13);
    v14.parent_os = p12;
    v14.page_origin = l__UIAssets__8.Menu.LoadoutPage;
    v14.main_page = v14.page_origin.LoadoutFrame:Clone();
    v14.item_profile_data = nil;
    v14.yen_inst = nil;
    v14.crimson_inst = nil;
    v14.item_shelf = {};
    v14.section_selects = {};
    v14.all_entries = {};
    v14.current_item_type = nil;
    v14.current_entry_selected = nil;
    v14.did_build_items = false;
    v14.trove = l__Trove__7.new();
    v14.viewing_trove = v14.trove:Extend();
    v14.trove:Add(v14.main_page);
    return v14;
end;
function u1.cleanUp(p15) --[[ Line: 140 ]]
    p15.trove:Clean();
end;
function u1.close(p16) --[[ Line: 144 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__11 = p16.main_page;
    l__main_page__11.Parent = p16.parent_os.RightContainer.MainOS;
    l__main_page__11.Interactable = false;
    task.delay(0.5, function() --[[ Line: 150 ]]
        -- upvalues: l__main_page__11 (copy)
        if l__main_page__11 and (l__main_page__11.Parent and not l__main_page__11.Interactable) then
            l__main_page__11.Visible = false;
        end;
    end;
    l__TweenService__1:Create(l__main_page__11, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__main_page__11, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1._getUi(p17) --[[ Line: 164 ]]
    if p17.ui then
        return p17.ui;
    end;
    local l__main_page__12 = p17.main_page;
    local v18 = l__main_page__12:FindFirstChild("DetailsContainer");
    if not v18 then
        v18 = l__main_page__12:FindFirstChild("DetailsContainer", true);
        assert(v18, "LoadoutPage UI is missing child: DetailsContainer");
    end;
    local v19 = v18:FindFirstChild("Main");
    if not v19 then
        v19 = v18:FindFirstChild("Main", true);
        assert(v19, "LoadoutPage UI is missing child: Main");
    end;
    local v20 = {};
    local v21 = l__main_page__12:FindFirstChild("ShelfContainer");
    if not v21 then
        v21 = l__main_page__12:FindFirstChild("ShelfContainer", true);
        assert(v21, "LoadoutPage UI is missing child: ShelfContainer");
    end;
    v20.shelf_container = v21;
    local v22 = l__main_page__12:FindFirstChild("SectionContainer");
    if not v22 then
        v22 = l__main_page__12:FindFirstChild("SectionContainer", true);
        assert(v22, "LoadoutPage UI is missing child: SectionContainer");
    end;
    v20.section_container = v22;
    v20.details_main = v19;
    local v23 = l__main_page__12:FindFirstChild("ExtrasContainer");
    if not v23 then
        v23 = l__main_page__12:FindFirstChild("ExtrasContainer", true);
        assert(v23, "LoadoutPage UI is missing child: ExtrasContainer");
    end;
    v20.extras_container = v23;
    local v24 = v19:FindFirstChild("OptionsFrame");
    if not v24 then
        v24 = v19:FindFirstChild("OptionsFrame", true);
        assert(v24, "LoadoutPage UI is missing child: OptionsFrame");
    end;
    v20.options_frame = v24;
    p17.ui = v20;
    return p17.ui;
end;
function u1._getProfile(p25, p26) --[[ Line: 184 ]]
    local v27 = p25.item_profile_data or p25.menu_session.item_profile_data;
    if v27 and v27.profiles then
        return v27.profiles[p26];
    else
        return nil;
    end;
end;
function u1._isOwned(p28, p29) --[[ Line: 193 ]]
    local v30 = p28:_getProfile(p29);
    return v30 and v30.owned == true and true or false;
end;
function u1._isTrainingUnlocked(p31, p32) --[[ Line: 198 ]]
    local v33 = p31:_getProfile(p32);
    return v33 and v33.training_unlocked == true and true or false;
end;
function u1._isEquipped(p34, p35) --[[ Line: 203 ]]
    local v36 = p34.item_profile_data or p34.menu_session.item_profile_data;
    if v36 and v36.equipped_loadout then
        return v36.equipped_loadout[p35.type] == p35.id;
    else
        return false;
    end;
end;
function u1._getSkinInventoryData(p37) --[[ Line: 212 ]]
    local v38 = p37.item_profile_data or p37.menu_session.item_profile_data;
    if v38 then
        local v39 = typeof(v38.skin_inventory) ~= "table" and {} or v38.skin_inventory;
        if typeof(v38.equipped_skins) == "table" then
            return v39, v38.equipped_skins;
        else
            return v39, {};
        end;
    else
        return {}, {};
    end;
end;
function u1._buildShowcaseSlots(p40, p41) --[[ Line: 223 ]]
    -- upvalues: l__SkinDefs__6 (copy)
    local v42 = {};
    if not p41 then
        return v42;
    end;
    local l__id__13 = p41.id;
    local v43 = l__SkinDefs__6.getDefs()[l__id__13];
    if not v43 then
        return v42;
    end;
    local v44 = p40:_isOwned(l__id__13);
    local v45, v46 = p40:_getSkinInventoryData();
    local v47 = v46[l__id__13];
    local v48 = {};
    local v49 = v45[l__id__13];
    if typeof(v49) == "table" then
        for v52, v51 in v49 do
            local v52;
            if typeof(v52) == "string" then
                v52 = tonumber(v52);
            end;
            if typeof(v52) ~= "number" and typeof(v51) == "table" then
                v52 = v51.skin_id;
            end;
            local v53;
            if typeof(v51) == "table" then
                local l__count__14 = v51.count;
                if typeof(l__count__14) == "number" then
                    local v54 = math.floor(l__count__14);
                    v53 = math.max(0, v54);
                else
                    v53 = 0;
                end;
            elseif typeof(v51) == "number" then
                local v55 = math.floor(v51);
                v53 = math.max(0, v55);
            else
                v53 = 0;
            end;
            if typeof(v52) == "number" and (v53 > 0 and l__SkinDefs__6.isValidForItem(l__id__13, v52)) then
                v48[v52] = (v48[v52] or 0) + v53;
            end;
        end;
    else
        for _, v56 in v45 do
            if typeof(v56) == "table" then
                local l__skin_id__15 = v56.skin_id;
                if v56.item_id == l__id__13 and (typeof(l__skin_id__15) == "number" and l__SkinDefs__6.isValidForItem(l__id__13, l__skin_id__15)) then
                    v48[l__skin_id__15] = (v48[l__skin_id__15] or 0) + 1;
                end;
            end;
        end;
    end;
    if typeof(v47) ~= "number" or (not l__SkinDefs__6.isValidForItem(l__id__13, v47) or v47 ~= l__SkinDefs__6.DEFAULT_SKIN_ID and (v48[v47] or 0) <= 0) then
        v47 = l__SkinDefs__6.DEFAULT_SKIN_ID;
    end;
    for v57, _ in v43 do
        local v58 = l__SkinDefs__6.getSkin(l__id__13, v57);
        if v58 then
            local v59 = v48[v57] or 0;
            if v58.hidden ~= true or (v44 and v57 == l__SkinDefs__6.DEFAULT_SKIN_ID or v59 > 0) then
                if v57 == l__SkinDefs__6.DEFAULT_SKIN_ID then
                    local v60 = {
                        show_amount = false,
                        def = v58,
                        unlocked = v44
                    };
                    local v61;
                    if v44 then
                        v61 = v47 == l__SkinDefs__6.DEFAULT_SKIN_ID;
                    else
                        v61 = v44;
                    end;
                    v60.equipped = v61;
                    table.insert(v42, v60);
                elseif v59 > 0 then
                    local v62 = {
                        show_amount = true,
                        def = v58,
                        unlocked = v44,
                        amount = v59
                    };
                    local v63;
                    if v44 then
                        v63 = v47 == v57;
                    else
                        v63 = v44;
                    end;
                    v62.equipped = v63;
                    table.insert(v42, v62);
                else
                    table.insert(v42, {
                        unlocked = false,
                        show_amount = false,
                        equipped = false,
                        def = v58
                    });
                end;
            end;
        end;
    end;
    return v42;
end;
function u1._getCurrencyValue(_, p64) --[[ Line: 318 ]]
    return not p64 and 0 or p64.Value;
end;
function u1.refreshItemState(p65, p66) --[[ Line: 326 ]]
    -- upvalues: l__UIAssets__8 (copy), l__Classes__9 (copy)
    local l__container__16 = p66.container;
    local l__def__17 = p66.def;
    local l__id__18 = p66.id;
    local v67 = p65:_isOwned(l__id__18);
    local v68 = p65:_isTrainingUnlocked(l__id__18);
    local v69;
    if v67 then
        v69 = p65:_isEquipped(p66);
    else
        v69 = v67;
    end;
    p66.owned = v67;
    local v70 = p65:_getCurrencyValue(p65.yen_inst);
    if v67 or l__def__17.purchasable then
        if v67 or v70 >= l__def__17.yen_price then
            l__container__16.Main.ItemImage.ImageTransparency = v67 and 0 or 0.4;
            l__container__16.Main.NameLabel.TextTransparency = 0;
            l__container__16.CantAffordLabel.Visible = false;
        else
            l__container__16.Main.ItemImage.ImageTransparency = 0.7;
            l__container__16.Main.NameLabel.TextTransparency = 0.7;
            l__container__16.CantAffordLabel.Visible = true;
        end;
    else
        l__container__16.Main.ItemImage.ImageTransparency = 0.7;
        l__container__16.Main.NameLabel.TextTransparency = 0.7;
        l__container__16.CantAffordLabel.Visible = false;
    end;
    local v71 = l__UIAssets__8.ItemSilhouettes:FindFirstChild(l__id__18);
    if v71 then
        l__container__16.Main.ItemImage.Image = v71.Image;
        l__container__16.Main.ItemImage.Size = UDim2.fromScale(1.1 * v71.Size.X.Scale, 1.1 * v71.Size.Y.Scale);
    end;
    l__container__16.Main.AliasLabel.Text = l__def__17.alias;
    l__container__16.Main.NameLabel.Text = l__def__17.name;
    if v69 then
        l__container__16.PriceLabel.Text = " ¥ | EQUIPPED";
        l__container__16.Back.UIGradient.Enabled = false;
        l__container__16.UIStroke.UIGradient.Enabled = false;
        local v72 = Color3.fromRGB(255, 217, 0);
        l__container__16.UIStroke.Color = v72;
        l__container__16.UIStroke.Transparency = 0;
        l__container__16.PriceLabel.TextColor3 = v72;
    elseif v67 then
        l__container__16.PriceLabel.Text = v68 and "TRAINING" or " ¥ | OWNED";
        l__container__16.Back.UIGradient.Enabled = false;
        l__container__16.UIStroke.UIGradient.Enabled = false;
    elseif l__def__17.purchasable then
        l__container__16.PriceLabel.Text = " " .. "¥" .. " | " .. l__Classes__9.Util:formatNumber(l__def__17.yen_price);
        l__container__16.Back.UIGradient.Enabled = true;
        l__container__16.UIStroke.UIGradient.Enabled = true;
    else
        l__container__16.PriceLabel.Text = "LOCKED";
        l__container__16.Back.UIGradient.Enabled = false;
        l__container__16.UIStroke.UIGradient.Enabled = false;
    end;
    if not v69 then
        local v73 = Color3.fromRGB(255, 255, 255);
        l__container__16.UIStroke.Color = v73;
        l__container__16.PriceLabel.TextColor3 = v73;
        l__container__16.UIStroke.Transparency = 0.8;
        l__container__16.Main.ItemImage.ImageColor3 = v73;
        l__container__16.Main.NameLabel.TextColor3 = v73;
        l__container__16.Main.AliasLabel.TextColor3 = v73;
    end;
end;
function u1.refreshAllItems(p74) --[[ Line: 402 ]]
    for _, v75 in p74.all_entries do
        p74:refreshItemState(v75);
    end;
    p74:selectEntry(p74.current_entry_selected);
end;
function u1.openSection(p76, p77, p78) --[[ Line: 410 ]]
    -- upvalues: l__Classes__9 (copy)
    local v79 = p76.current_item_type and p76.section_selects[p76.current_item_type];
    if v79 then
        v79.SelectedFrame.Visible = false;
    end;
    if p78 == true then
        l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("BACK1", true);
    end;
    p76.current_item_type = p77;
    local v80 = p76:_getUi();
    local v81 = p76.item_shelf[p77];
    local v82 = p76.section_selects[p77];
    if v82 then
        v82.SelectedFrame.Visible = true;
    end;
    for _, v83 in v80.shelf_container:GetChildren() do
        if v83:IsA("ScrollingFrame") then
            v83.Visible = false;
        end;
    end;
    if v81 then
        v81.list.Visible = true;
    end;
    p76:selectEntry();
end;
function u1.selectEntry(u84, p85, p86) --[[ Line: 445 ]]
    -- upvalues: l__Classes__9 (copy), l__TweenService__1 (copy), u11 (copy)
    if u84.current_entry_selected then
        u84.current_entry_selected.container.Spotlighted.Visible = false;
    end;
    u84.current_entry_selected = p85;
    u84.viewing_trove:Clean();
    local v87 = u84:_getUi();
    local l__details_main__19 = v87.details_main;
    local l__options_frame__20 = v87.options_frame;
    if p85 then
        if p86 == true then
            l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
        end;
        local l__container__21 = p85.container;
        local l__def__22 = p85.def;
        l__details_main__19.HeaderFrame.AliasLabel.Text = l__def__22.alias;
        l__details_main__19.HeaderFrame.NameLabel.Text = "■" .. l__def__22.name;
        l__details_main__19.TagsFrame.TagsLabel.Text = l__def__22.tags;
        l__details_main__19.AssessmentFrame.StatsFrame.DescFrame.Description.Text = l__def__22.description;
        l__container__21.Spotlighted.Visible = true;
        local function v92(p88, p89, p90) --[[ Line: 472 ]]
            -- upvalues: u84 (copy), l__TweenService__1 (ref), l__details_main__19 (copy)
            local v91 = u84.page_origin.StatEntry:Clone();
            v91.StatName.Text = "【" .. p89 .. "】";
            v91.StatValue.Text = p90;
            v91.Size = UDim2.fromScale(v91.Size.X.Scale, v91.Size.Y.Scale * 0.66);
            v91.Bar.Fill.Size = UDim2.fromScale(0, 1);
            l__TweenService__1:Create(v91.Bar.Fill, TweenInfo.new(0.75, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(p88, 1)
            }):Play();
            v91.Parent = l__details_main__19.AssessmentFrame.StatsFrame;
            u84.viewing_trove:Add(v91);
        end;
        for _, v93 in l__def__22.stat_entries do
            v92(v93.fill_alpha, v93.stat_name, v93.stat_value);
        end;
        l__options_frame__20.Visible = p85.owned or l__def__22.purchasable;
        v87.extras_container.FlavorDescLabel.Text = l__def__22.flavor_description;
        if p85.owned then
            l__options_frame__20.PurchaseFrame.Visible = false;
            l__options_frame__20.EquipFrame.Visible = true;
            l__options_frame__20.TryFrame.Visible = l__def__22.purchasable == true;
            if u84:_isEquipped(p85) then
                u11(l__options_frame__20.EquipFrame, "EQUIPPED");
                l__options_frame__20.EquipFrame.Back.BackgroundColor3 = Color3.fromRGB(0, 150, 0);
                l__options_frame__20.EquipFrame.Back.UIStroke.Color = Color3.fromRGB(0, 150, 0);
                l__container__21.Spotlighted.BackgroundColor3 = Color3.fromRGB(255, 217, 0);
                l__container__21.Spotlighted.UIStroke.Color = Color3.fromRGB(255, 217, 0);
            else
                u11(l__options_frame__20.EquipFrame, "EQUIP");
                l__options_frame__20.EquipFrame.Back.BackgroundColor3 = Color3.fromRGB(0, 255, 64);
                l__options_frame__20.EquipFrame.Back.UIStroke.Color = Color3.fromRGB(0, 255, 64);
            end;
        elseif l__def__22.purchasable then
            l__options_frame__20.PurchaseFrame.Visible = true;
            l__options_frame__20.EquipFrame.Visible = false;
            l__options_frame__20.TryFrame.Visible = true;
        else
            l__options_frame__20.PurchaseFrame.Visible = false;
            l__options_frame__20.EquipFrame.Visible = false;
            l__options_frame__20.TryFrame.Visible = false;
        end;
        if not u84:_isEquipped(p85) then
            l__container__21.Spotlighted.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            l__container__21.Spotlighted.UIStroke.Color = Color3.fromRGB(255, 255, 255);
        end;
    else
        l__details_main__19.HeaderFrame.AliasLabel.Text = "ADAPT OR DIE";
        l__details_main__19.HeaderFrame.NameLabel.Text = "■NONE";
        l__details_main__19.TagsFrame.TagsLabel.Text = "";
        l__details_main__19.AssessmentFrame.StatsFrame.DescFrame.Description.Text = "";
        l__options_frame__20.Visible = false;
        l__options_frame__20.TryFrame.Visible = false;
        v87.extras_container.FlavorDescLabel.Text = "";
    end;
end;
function u1.equipItem(p94, p95) --[[ Line: 533 ]]
    -- upvalues: u3 (copy), l__Classes__9 (copy), l__Packets__5 (copy)
    if p95 and p95.owned then
        if u3[p95.item_type] then
            local v96 = p94.item_profile_data or p94.menu_session.item_profile_data;
            if v96 and v96.equipped_loadout then
                l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
                l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("BULLET_GAINED", true);
                v96.equipped_loadout[p95.item_type] = p95.item_id;
                l__Packets__5._x547622139233bbdd:Fire({
                    [p95.item_type] = p95.item_id
                });
                p94:refreshAllItems();
            else
                warn("DATA FOR LOADOUT HAS NOT BEEN RECEIVED");
            end;
        else
            warn("LoadoutPage does not support equipping item type:", p95.item_type);
        end;
    end;
end;
function u1.tryPurchaseItem(u97, u98) --[[ Line: 560 ]]
    -- upvalues: l__ItemDef__4 (copy), l__Classes__9 (copy), l__Packets__5 (copy)
    local v99 = l__ItemDef__4.getDefs()[u98];
    if v99 then
        if v99.purchasable then
            local l__yen_price__23 = v99.yen_price;
            local v100 = u97:_getCurrencyValue(u97.yen_inst);
            local u101 = u97:_getCurrencyValue(u97.crimson_inst);
            local v102 = l__Classes__9.Util:yenToCrimson(l__yen_price__23);
            local u103 = math.ceil(v102);
            local u104 = l__yen_price__23 <= v100;
            local v105 = u103 - l__Classes__9.Util:yenToCrimson(v100);
            local v106 = math.max(0, v105);
            local u107 = math.ceil(v106);
            local v108 = not u104;
            if v108 then
                v108 = v100 > 0;
            end;
            local v109 = "*" .. u103 .. " Crimson";
            if v108 then
                v109 = "*<font color=\"#888888\"><s>" .. u103 .. "</s></font> " .. u107 .. " Crimson";
            end;
            local v110 = u104 and "This item will be added to your locker." or "You need <b>" .. "¥" .. l__Classes__9.Util:shortenNumber(l__yen_price__23 - v100) .. "</b> more. You can bridge that gap for <b>" .. u107 .. " Crimson</b> and buy it now. (Uses your remaining Yen)";
            l__Classes__9._xd00ac57201023755:_x4782af5368e4c758("Modal", {
                title_text = u104 and "Unlock " .. v99.name or "NOT ENOUGH YEN",
                body_text = v110,
                actions = {
                    {
                        action_size = 2,
                        action_text = u104 and "BUY WITH CRIMSON" or "BUY WITH CRIMSON & YEN",
                        action_subtext = v109,
                        action_bg_color = Color3.fromRGB(255, 0, 0),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 611 ]]
                            -- upvalues: u104 (copy), u103 (copy), u107 (copy), u101 (copy), u97 (copy), l__Packets__5 (ref), u98 (copy)
                            if u101 < (u104 and u103 or u107) then
                                u97.menu_session:openPage("shop_page", "Deals");
                            else
                                l__Packets__5._x5adbe1c2dab6c690:Fire({
                                    op = "buy",
                                    currency = u104 and "crimson" or "crimson_partial",
                                    item_id = u98
                                });
                            end;
                        end
                    },
                    {
                        action_size = 2,
                        action_text = "USE " .. "¥" .. l__Classes__9.Util:shortenNumber(l__yen_price__23),
                        action_bg_color = u104 and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45),
                        action_text_color = u104 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 130, 130),
                        action_callback = function() --[[ Name: action_callback, Line 630 ]]
                            -- upvalues: u104 (copy), l__Packets__5 (ref), u98 (copy)
                            if u104 then
                                l__Packets__5._x5adbe1c2dab6c690:Fire({
                                    op = "buy",
                                    currency = "yen",
                                    item_id = u98
                                });
                            end;
                        end
                    },
                    {
                        action_text = "CANCEL",
                        action_bg_color = Color3.fromRGB(60, 60, 60),
                        action_text_color = Color3.fromRGB(180, 180, 180),
                        action_callback = function() --[[ Name: action_callback, Line 644 ]] end
                    }
                }
            });
        else
            warn("ITEM IS NOT PURCHASABLE:", u98);
        end;
    else
        warn("NO ITEM DEF FOR PURCHASE:", u98);
    end;
end;
function u1.tryItemInTraining(_, u111) --[[ Line: 650 ]]
    -- upvalues: l__Classes__9 (copy), l__Packets__5 (copy), l__CEnum__3 (copy)
    if u111 and (u111.def and u111.def.purchasable == true) then
        l__Classes__9._xd00ac57201023755:_x4782af5368e4c758("Modal", {
            body_text = "This will teleport you to a different server.",
            title_text = "TELEPORT TO TRAINING WITH " .. u111.def.name .. "?",
            actions = {
                {
                    action_text = "CONFIRM",
                    action_bg_color = Color3.fromRGB(0, 120, 0),
                    action_text_color = Color3.fromRGB(255, 255, 255),
                    action_callback = function() --[[ Name: action_callback, Line 663 ]]
                        -- upvalues: l__Packets__5 (ref), l__CEnum__3 (ref), u111 (copy)
                        l__Packets__5._xf1a5e1b80bd07564:Fire({
                            gamemode = l__CEnum__3.Gamemodes.Training,
                            try_item_id = u111.id
                        });
                    end
                },
                {
                    action_text = "CANCEL",
                    action_bg_color = Color3.fromRGB(60, 60, 60),
                    action_text_color = Color3.fromRGB(180, 180, 180),
                    action_callback = function() --[[ Name: action_callback, Line 674 ]] end
                }
            }
        });
    end;
end;
function u1._buildItems(u112) --[[ Line: 680 ]]
    -- upvalues: u6 (copy), l__ItemDef__4 (copy), u3 (copy), u2 (copy)
    if u112.did_build_items then
    else
        u112.did_build_items = true;
        local v113 = u112:_getUi();
        u6(v113.shelf_container);
        u6(v113.section_container);
        for _, v114 in l__ItemDef__4.getDefs() do
            local l__item_type__24 = v114.item_type;
            if u3[l__item_type__24] then
                if not u112.item_shelf[l__item_type__24] then
                    local v115 = u112.page_origin.ShelfList:Clone();
                    v115.Visible = false;
                    v115.Parent = v113.shelf_container;
                    u112.item_shelf[l__item_type__24] = {
                        list = v115,
                        entries = {}
                    };
                end;
                local v116 = u112.page_origin.ItemContainer:Clone();
                local u117 = {
                    owned = false,
                    def = v114,
                    id = v114.item_id,
                    type = l__item_type__24,
                    container = v116,
                    _trove = u112.trove:Extend()
                };
                u117._trove:Connect(v116.Button.Activated, function() --[[ Line: 717 ]]
                    -- upvalues: u112 (copy), u117 (copy)
                    u112:selectEntry(u117, true);
                end;
                table.insert(u112.item_shelf[l__item_type__24].entries, u117);
                table.insert(u112.all_entries, u117);
                u112:refreshItemState(u117);
            end;
        end;
        for _, v118 in u112.item_shelf do
            table.sort(v118.entries, function(p119, p120) --[[ Line: 728 ]]
                -- upvalues: u112 (copy)
                local v121 = u112:_isOwned(p119.id);
                if v121 == u112:_isOwned(p120.id) then
                    return p119.def.yen_price < p120.def.yen_price;
                else
                    return v121;
                end;
            end;
            for _, v122 in v118.entries do
                v122.container.Parent = v118.list;
            end;
        end;
        for _, u123 in u2 do
            if u112.item_shelf[u123] then
                local v124 = u112.page_origin.SectionFrame:Clone();
                v124.TextLabel.Text = u123:upper() .. "S";
                v124.Parent = v113.section_container;
                u112.trove:Connect(v124.Button.Activated, function() --[[ Line: 752 ]]
                    -- upvalues: u112 (copy), u123 (copy)
                    u112:openSection(u123, true);
                end;
                u112.section_selects[u123] = v124;
            end;
        end;
        u112:openSection("gun", false);
    end;
end;
function u1.start(p125) --[[ Line: 761 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__25 = p125.main_page;
    l__main_page__25.Interactable = true;
    l__main_page__25.Visible = true;
    l__main_page__25.Parent = p125.parent_os;
    l__main_page__25.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__25, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__25.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__1:Create(l__main_page__25, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    p125.item_profile_data = p125.menu_session.item_profile_data;
    p125:refreshAllItems();
end;
function u1.Init(u126) --[[ Line: 782 ]]
    -- upvalues: l__Classes__9 (copy), l__InternalSymbols__10 (copy)
    u126.item_profile_data = u126.menu_session.item_profile_data;
    u126.yen_inst = l__Classes__9._x7430d6d194f43373:_x57c044514acd3a73("yen");
    u126.crimson_inst = l__Classes__9._x7430d6d194f43373:_x57c044514acd3a73("crimson");
    u126:_buildItems();
    u126.trove:Connect(u126.menu_session.onItemProfileUpdated, function(p127) --[[ Line: 789 ]]
        -- upvalues: u126 (copy), l__InternalSymbols__10 (ref)
        u126.item_profile_data = p127;
        u126:refreshAllItems();
        local l__owner__26 = l__InternalSymbols__10.owner;
        local v128 = "ShowcasePage";
        local l__pages__27 = u126.menu_session.pages;
        if l__pages__27 then
            l__pages__27 = u126.menu_session.pages.showcase_page;
        end;
        local v129 = l__owner__26(v128, l__pages__27);
        if u126.menu_session.current_page == "showcase_page" and (v129 and (v129.return_page == "loadout_page" and u126.current_entry_selected)) then
            v129:refreshSlots(u126:_buildShowcaseSlots(u126.current_entry_selected));
        end;
    end;
    if u126.yen_inst then
        u126.trove:Connect(u126.yen_inst.Changed, function() --[[ Line: 800 ]]
            -- upvalues: u126 (copy)
            u126:refreshAllItems();
        end;
    end;
    if u126.crimson_inst then
        u126.trove:Connect(u126.crimson_inst.Changed, function() --[[ Line: 806 ]]
            -- upvalues: u126 (copy)
            u126:refreshAllItems();
        end;
    end;
    local v130 = u126:_getUi();
    u126.trove:Connect(v130.options_frame.PurchaseFrame.Button.Activated, function() --[[ Line: 812 ]]
        -- upvalues: u126 (copy), l__Classes__9 (ref)
        if u126.current_entry_selected and (not u126.current_entry_selected.owned and u126.current_entry_selected.def.purchasable) then
            l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
            u126:tryPurchaseItem(u126.current_entry_selected.id);
        end;
    end;
    u126.trove:Connect(v130.options_frame.EquipFrame.Button.Activated, function() --[[ Line: 821 ]]
        -- upvalues: u126 (copy), l__Classes__9 (ref)
        if u126.current_entry_selected and u126.current_entry_selected.owned then
            if u126:_isEquipped(u126.current_entry_selected) then
            else
                l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
                u126:equipItem((u126:_getProfile(u126.current_entry_selected.id)));
            end;
        end;
    end;
    u126.trove:Connect(v130.options_frame.TryFrame.Button.Activated, function() --[[ Line: 835 ]]
        -- upvalues: u126 (copy), l__Classes__9 (ref)
        if u126.current_entry_selected and u126.current_entry_selected.def.purchasable == true then
            l__Classes__9._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
            u126:tryItemInTraining(u126.current_entry_selected);
        end;
    end;
    local v131 = u126.main_page:FindFirstChild("OutButton", true);
    if v131 then
        u126.trove:Connect(v131.Activated, function() --[[ Line: 846 ]]
            -- upvalues: u126 (copy)
            local l__pages__28 = u126.menu_session.pages;
            if l__pages__28 then
                l__pages__28 = u126.menu_session.pages.lobby_page;
            end;
            if l__pages__28 and l__pages__28.in_lobby then
                u126.menu_session:openPage("lobby_page");
            else
                u126.menu_session:openPage("empty_page");
            end;
        end;
    end;
    local v132 = u126.main_page:FindFirstChild("SkinsFrame", true);
    if v132 then
        if not v132:IsA("GuiButton") then
            v132 = v132:FindFirstChildWhichIsA("ImageButton", true) or v132:FindFirstChildWhichIsA("TextButton", true);
        end;
        if v132 then
            u126.trove:Connect(v132.Activated, function() --[[ Line: 860 ]]
                -- upvalues: u126 (copy)
                if u126.current_entry_selected then
                    local v133 = u126:_buildShowcaseSlots(u126.current_entry_selected);
                    u126.menu_session:openPage("showcase_page", v133, "loadout_page", {
                        page_title = "INVENTORY"
                    });
                end;
            end;
        else
            warn("LoadoutPage SkinsFrame is missing a GuiButton");
        end;
    else
        warn("LoadoutPage UI is missing SkinsFrame");
    end;
end;
return u1;
