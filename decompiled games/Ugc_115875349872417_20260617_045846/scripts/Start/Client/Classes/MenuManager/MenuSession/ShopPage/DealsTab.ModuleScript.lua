-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ShopPage.DealsTab
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__HttpService__3 = game:GetService("HttpService");
local l__ModuleScripts__4 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Trove__5 = require(l__ModuleScripts__4.Trove);
local l__Packets__6 = require(l__ModuleScripts__4.Packets);
local l__DealsDef__7 = require(l__ModuleScripts__4.DealsDef);
local l__UIAssets__8 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__9 = require(script.Parent.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l___x7749231778538ccb__10 = require(script.Parent.Parent.Parent.Parent.Parent._x7749231778538ccb);
function u1.new(p2, p3) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Trove__5 (copy), l___x7749231778538ccb__10 (copy), l__UIAssets__8 (copy)
    local v4 = setmetatable({}, u1);
    v4.trove = l__Trove__5.new();
    v4.viewing_trove = v4.trove:Extend();
    v4._menu_session = l___x7749231778538ccb__10._xd644d9e3ba63f27f("MenuSession", p3);
    v4._gift_browser_open = false;
    v4._gift_requesting = false;
    v4._pending_gift_product_id = nil;
    v4._pending_gift_request_id = nil;
    v4._gift_prompt_started = false;
    v4._crimson_options_by_gift_product_id = {};
    v4._gift_purchase_available_by_product_id = {};
    v4._gift_block_state_by_product_id = {};
    v4._gift_route_tokens_by_product_id = {};
    v4.main_page = p2;
    v4.page_origin = l__UIAssets__8.Menu.ShopPage.Deals;
    v4.tab_asset = v4.page_origin.DealsTab:Clone();
    v4:start();
    return v4;
end;
function u1._finishGiftRequest(p5) --[[ Line: 57 ]]
    p5._gift_requesting = false;
    p5._pending_gift_product_id = nil;
    p5._pending_gift_request_id = nil;
    p5._gift_prompt_started = false;
end;
function u1._updateGiftInventoryLabels(p6) --[[ Line: 64 ]]
    local l__item_profile_data__11 = p6._menu_session.item_profile_data;
    local v7 = l__item_profile_data__11 and (l__item_profile_data__11.dev_product_inventory_counts or {}) or {};
    local v8 = l__item_profile_data__11 and l__item_profile_data__11.dev_product_outbound_counts or {};
    for v9, v10 in pairs(p6._crimson_options_by_gift_product_id) do
        local v11 = v10:FindFirstChild("InventoryLabel");
        local v12 = v7[v9] or 0;
        local v13 = (v8[v9] or 0) > 0;
        if v11 and v11:IsA("TextLabel") then
            v11.Visible = v12 > 0;
            v11.Text = tostring(v12) .. " Unused";
        end;
        local v14 = v10:FindFirstChild("GiftButton");
        local v15;
        if v14 and not v14:IsA("GuiButton") then
            v15 = v14:FindFirstChildWhichIsA("ImageButton", true) or v14:FindFirstChildWhichIsA("TextButton", true);
        else
            v15 = v14;
        end;
        local v16 = p6._gift_purchase_available_by_product_id[v9] == true;
        local v17 = v13 or p6._gift_block_state_by_product_id[v9] ~= nil;
        local v18 = v12 > 0 and true or v16;
        if v12 > 0 then
            v16 = true;
        elseif v16 then
            v16 = not v17;
        end;
        if v14 and v14:IsA("GuiObject") then
            v14.Visible = v18;
        end;
        if v15 then
            v15.Interactable = v16;
            v15.Active = v16;
        end;
    end;
end;
function u1._setGiftBlockState(u19, u20, p21) --[[ Line: 93 ]]
    if typeof(u20) == "number" then
        if p21 == "route" and (u19._gift_block_state_by_product_id[u20] == "route" and u19._gift_route_tokens_by_product_id[u20] ~= nil) then
            u19:_updateGiftInventoryLabels();
        else
            u19._gift_block_state_by_product_id[u20] = p21;
            if p21 == "route" then
                local u22 = {};
                u19._gift_route_tokens_by_product_id[u20] = u22;
                task.delay(301, function() --[[ Line: 110 ]]
                    -- upvalues: u19 (copy), u20 (copy), u22 (copy)
                    if u19._gift_route_tokens_by_product_id[u20] == u22 then
                        u19._gift_route_tokens_by_product_id[u20] = nil;
                        u19._gift_block_state_by_product_id[u20] = nil;
                        u19:_updateGiftInventoryLabels();
                    end;
                end);
            else
                u19._gift_route_tokens_by_product_id[u20] = nil;
            end;
            u19:_updateGiftInventoryLabels();
        end;
    end;
end;
function u1._openGiftBrowser(u23, u24) --[[ Line: 123 ]]
    -- upvalues: l__Classes__9 (copy), l__HttpService__3 (copy), l__Packets__6 (copy)
    if u23._gift_browser_open or u23._gift_requesting then
    else
        local l___xe4b708070c7cd741__12 = l__Classes__9._xe4b708070c7cd741;
        if l___xe4b708070c7cd741__12 and typeof(l___xe4b708070c7cd741__12._x85ec8b5d5b90212b) == "function" then
            u23._gift_browser_open = true;
            local v27 = l___xe4b708070c7cd741__12:_x85ec8b5d5b90212b("PlayerBrowser", {
                ignore_self = true,
                max_select = 1,
                header_text = "GIFT CRIMSON",
                selected_callback = function(p25) --[[ Name: selected_callback, Line 139 ]]
                    -- upvalues: l__HttpService__3 (ref), u23 (copy), u24 (copy), l__Packets__6 (ref)
                    if p25 then
                        p25 = p25[1];
                    end;
                    if typeof(p25) == "number" then
                        local u26 = l__HttpService__3:GenerateGUID(false);
                        u23._gift_requesting = true;
                        u23._pending_gift_product_id = u24.gift_product_id;
                        u23._pending_gift_request_id = u26;
                        u23._gift_prompt_started = false;
                        l__Packets__6._x5f5c9057d57f77dd:Fire({
                            op = "gift_dev_product",
                            product_id = u24.gift_product_id,
                            recipient_user_id = p25,
                            request_id = u26
                        });
                        task.delay(30, function() --[[ Line: 157 ]]
                            -- upvalues: u23 (ref), u26 (copy)
                            if u23._pending_gift_request_id == u26 then
                                u23:_finishGiftRequest();
                            end;
                        end);
                    end;
                end
            });
            if v27 then
                local l__destroy__13 = v27.destroy;
                function v27.destroy(p28, ...) --[[ Line: 171 ]]
                    -- upvalues: u23 (copy), l__destroy__13 (copy)
                    u23._gift_browser_open = false;
                    return l__destroy__13(p28, ...);
                end;
            else
                u23._gift_browser_open = false;
            end;
        end;
    end;
end;
function u1.destroy(p29) --[[ Line: 177 ]]
    p29.trove:Clean();
end;
function u1.close(u30) --[[ Line: 181 ]]
    -- upvalues: l__TweenService__1 (copy)
    l__TweenService__1:Create(u30.tab_asset, TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        GroupTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.2)
    }):Play();
    u30.tab_asset.Interactable = false;
    task.delay(0.2, function() --[[ Line: 184 ]]
        -- upvalues: u30 (copy)
        if u30.tab_asset and (u30.tab_asset.Parent and u30.tab_asset.Interactable == false) then
            u30.tab_asset.Visible = false;
        end;
    end);
end;
function u1.open(p31) --[[ Line: 191 ]]
    -- upvalues: l__TweenService__1 (copy)
    p31.tab_asset.Position = UDim2.fromScale(0.5, -0.1);
    p31.tab_asset.GroupTransparency = 1;
    p31.tab_asset.Interactable = true;
    p31.tab_asset.Visible = true;
    l__TweenService__1:Create(p31.tab_asset, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.075)
    }):Play();
end;
function u1._arePaidRandomItemsRestricted(p32) --[[ Line: 199 ]]
    return p32._menu_session:waitForPaidRandomItemsRestricted();
end;
function u1._setupCrimsonOptions(u33) --[[ Line: 203 ]]
    -- upvalues: l__DealsDef__7 (copy), l__MarketplaceService__2 (copy), l__Packets__6 (copy), l__TweenService__1 (copy)
    local _ = u33.page_origin;
    local l__tab_asset__14 = u33.tab_asset;
    local v34 = l__tab_asset__14:FindFirstChild("DealsList");
    if v34 then
        local v35 = v34:FindFirstChild("CrimsonContainer");
        if v35 and v35:IsA("GuiObject") then
            v35.Visible = false;
        end;
        local u36 = u33:_arePaidRandomItemsRestricted();
        if u36 then
        elseif v35 then
            local u37 = v35:FindFirstChild("TopShelf");
            local u38 = v35:FindFirstChild("BotShelf");
            if u37 and u38 then
                if v35 and v35:IsA("GuiObject") then
                    v35.Visible = true;
                end;
                for _, v39 in { u37, u38 } do
                    local v40 = v39:FindFirstChildWhichIsA("UIGridStyleLayout");
                    if v40 then
                        v40.SortOrder = Enum.SortOrder.LayoutOrder;
                    end;
                end;
                for u41, u42 in l__DealsDef__7.CrimsonOptions do
                    task.spawn(function() --[[ Line: 236 ]]
                        -- upvalues: u33 (copy), u41 (copy), u42 (copy), l__MarketplaceService__2 (ref), l__tab_asset__14 (copy), u36 (copy), u37 (copy), u38 (copy), l__Packets__6 (ref), l__TweenService__1 (ref)
                        local u43 = u33.page_origin.CrimsonOption:Clone();
                        u43.LayoutOrder = u41;
                        local l__Scale__15 = u43.MainImageLabel.Size.X.Scale;
                        u43.AmountLabel.Text = tostring(u42.crimson_amount);
                        local v44, v45, v46 = pcall(function() --[[ Line: 241 ]]
                            -- upvalues: l__MarketplaceService__2 (ref), u42 (ref)
                            return l__MarketplaceService__2:GetProductInfoAsync(u42.product_id, Enum.InfoType.Product), l__MarketplaceService__2:GetProductInfoAsync(u42.gift_product_id, Enum.InfoType.Product);
                        end);
                        if l__tab_asset__14 and (not l__tab_asset__14 or l__tab_asset__14:FindFirstChild("DealsList")) then
                            if not v44 then
                                warn("[DealsTab] Failed to fetch crimson product pricing:", u42.product_id, v45);
                            end;
                            local v47 = v44 and v45.PriceInRobux or nil;
                            if v44 and typeof(v47) ~= "number" then
                                warn("[DealsTab] Crimson self-purchase product has no usable price:", u42.product_id);
                            end;
                            local v48 = v44 and v46.PriceInRobux or nil;
                            local v49 = not u36;
                            if v49 then
                                v49 = typeof(v47) == "number";
                            end;
                            local v50;
                            if v49 then
                                if typeof(v48) == "number" then
                                    v50 = v47 == v48;
                                else
                                    v50 = false;
                                end;
                            else
                                v50 = v49;
                            end;
                            u33._gift_purchase_available_by_product_id[u42.gift_product_id] = v50;
                            local v51 = typeof(v47) ~= "number" and "--" or v47;
                            local u52 = l__Scale__15 * u42.icon_scale;
                            u43.RobuxLabel.Text = "<b>" .. v51 .. "</b>";
                            u43.UpDescriptionLabel.Text = u42.top_desc;
                            u43.DownDescriptionLabel.Text = u42.bot_desc;
                            u43.MainImageLabel.Size = UDim2.fromScale(u52, u52);
                            if u42.shelf == 1 then
                                u43.Parent = u37;
                            elseif u42.shelf == 2 then
                                u43.Parent = u38;
                            end;
                            if u42.gradient then
                                u43.Gradient.Visible = true;
                            end;
                            u33._crimson_options_by_gift_product_id[u42.gift_product_id] = u43;
                            local u53 = u43:FindFirstChild("InventoryLabel");
                            if u53 and u53:IsA("TextLabel") then
                                u53.Visible = false;
                                u53.Text = "0 Unused";
                            end;
                            if u42.popular then
                                u43.Spotlighted.Visible = true;
                            end;
                            if u43.Button:IsA("GuiButton") then
                                u43.Button.Interactable = v49;
                                u43.Button.Active = v49;
                            end;
                            local u54 = u43:FindFirstChild("GiftButton");
                            if v49 then
                                u33.trove:Connect(u43.Button.Activated, function() --[[ Line: 303 ]]
                                    -- upvalues: l__Packets__6 (ref), u42 (ref)
                                    l__Packets__6._x5f5c9057d57f77dd:Fire(u42.product_id);
                                end);
                                local u55 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
                                u33.trove:Connect(u43.Button.MouseEnter, function() --[[ Line: 309 ]]
                                    -- upvalues: l__TweenService__1 (ref), u43 (copy), u55 (copy), u52 (copy), u53 (copy), u54 (copy)
                                    l__TweenService__1:Create(u43.MainImageLabel, u55, {
                                        Size = UDim2.fromScale(u52 + 0.05, u52 + 0.05)
                                    }):Play();
                                    l__TweenService__1:Create(u53, u55, {
                                        TextTransparency = 0
                                    }):Play();
                                    l__TweenService__1:Create(u54, u55, {
                                        ImageTransparency = 0
                                    }):Play();
                                end);
                                u33.trove:Connect(u43.Button.MouseLeave, function() --[[ Line: 315 ]]
                                    -- upvalues: l__TweenService__1 (ref), u43 (copy), u55 (copy), u52 (copy), u54 (copy), u53 (copy)
                                    l__TweenService__1:Create(u43.MainImageLabel, u55, {
                                        Size = UDim2.fromScale(u52, u52)
                                    }):Play();
                                    l__TweenService__1:Create(u54, u55, {
                                        ImageTransparency = 0.9
                                    }):Play();
                                    l__TweenService__1:Create(u53, u55, {
                                        TextTransparency = 0.9
                                    }):Play();
                                end);
                            end;
                            if u54 then
                                u33.trove:Connect(u54.Activated, function() --[[ Line: 323 ]]
                                    -- upvalues: u33 (ref), u42 (ref)
                                    u33:_openGiftBrowser(u42);
                                end);
                            end;
                            if not (v50 or u36) then
                                warn("[DealsTab] New gift purchases disabled because displayed and gift prices differ:", u42.gift_product_id);
                            end;
                            u33:_updateGiftInventoryLabels();
                        end;
                    end);
                end;
                u33:_updateGiftInventoryLabels();
            end;
        end;
    end;
end;
function u1.start(u56) --[[ Line: 337 ]]
    -- upvalues: l__Packets__6 (copy), l__MarketplaceService__2 (copy)
    u56.trove:Connect(l__Packets__6._xc2915548d25f77de.OnClientEvent, function(p57) --[[ Line: 338 ]]
        -- upvalues: u56 (copy)
        if typeof(p57) == "table" then
            if p57.request_id == nil then
                if u56._pending_gift_product_id ~= nil and p57.product_id ~= u56._pending_gift_product_id then
                    return;
                end;
            elseif p57.request_id ~= u56._pending_gift_request_id then
                return;
            end;
            if p57.state == "prompting_purchase" or p57.state == "sending" then
                u56._gift_prompt_started = true;
                u56:_setGiftBlockState(p57.product_id, p57.state == "prompting_purchase" and "route" or "outbound");
            elseif p57.state == "purchase_settling" then
                u56:_setGiftBlockState(p57.product_id, "route");
            elseif p57.state == "delivery_pending" then
                u56:_setGiftBlockState(p57.product_id, "outbound");
            elseif p57.state == "rejected" or (p57.state == "recipient_busy" or (p57.state == "recipient_inbox_full" or (p57.state == "manual_remediation" or (p57.state == "delivered" or p57.state == "inventory_ready")))) then
                u56:_setGiftBlockState(p57.product_id, nil);
                u56:_finishGiftRequest();
            end;
            if p57.state == "purchase_settling" or p57.state == "delivery_pending" then
                u56:_finishGiftRequest();
            end;
        end;
    end);
    u56.trove:Connect(l__MarketplaceService__2.PromptProductPurchaseFinished, function(_, p58) --[[ Line: 374 ]]
        -- upvalues: u56 (copy)
        if p58 == u56._pending_gift_product_id then
            u56:_finishGiftRequest();
        end;
    end);
    u56.trove:Connect(u56._menu_session.onItemProfileUpdated, function() --[[ Line: 380 ]]
        -- upvalues: u56 (copy)
        u56:_updateGiftInventoryLabels();
    end);
    u56.tab_asset.Parent = u56.main_page.Main;
    task.spawn(function() --[[ Line: 385 ]]
        -- upvalues: u56 (copy)
        u56:_setupCrimsonOptions();
    end);
end;
return u1;
