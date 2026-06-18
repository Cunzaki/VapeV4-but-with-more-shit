-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ShopPage.DealsTab
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
local l__InternalSymbols__10 = require(script.Parent.Parent.Parent.Parent.Parent.InternalSymbols);
function u1.new(p2, p3) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Trove__5 (copy), l__InternalSymbols__10 (copy), l__UIAssets__8 (copy)
    local v4 = setmetatable({}, u1);
    v4.trove = l__Trove__5.new();
    v4.viewing_trove = v4.trove:Extend();
    v4._menu_session = l__InternalSymbols__10.owner("MenuSession", p3);
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
        local l___xd00ac57201023755__12 = l__Classes__9._xd00ac57201023755;
        if l___xd00ac57201023755__12 and typeof(l___xd00ac57201023755__12._x4782af5368e4c758) == "function" then
            u23._gift_browser_open = true;
            local v27 = l___xd00ac57201023755__12:_x4782af5368e4c758("PlayerBrowser", {
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
                        l__Packets__6._x4a9e94f14df7f3b8:Fire({
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
        if u36 and v35 then
            for _, v37 in v35:GetChildren() do
                v37.Visible = v37.Name == "WarningLabel";
            end;
        elseif v35 then
            local u38 = v35:FindFirstChild("TopShelf");
            local u39 = v35:FindFirstChild("BotShelf");
            if u38 and u39 then
                if v35 and v35:IsA("GuiObject") then
                    v35.Visible = true;
                end;
                for _, v40 in { u38, u39 } do
                    local v41 = v40:FindFirstChildWhichIsA("UIGridStyleLayout");
                    if v41 then
                        v41.SortOrder = Enum.SortOrder.LayoutOrder;
                    end;
                end;
                for u42, u43 in l__DealsDef__7.CrimsonOptions do
                    task.spawn(function() --[[ Line: 239 ]]
                        -- upvalues: u33 (copy), u42 (copy), u43 (copy), l__MarketplaceService__2 (ref), l__tab_asset__14 (copy), u36 (copy), u38 (copy), u39 (copy), l__Packets__6 (ref), l__TweenService__1 (ref)
                        local u44 = u33.page_origin.CrimsonOption:Clone();
                        u44.LayoutOrder = u42;
                        local l__Scale__15 = u44.MainImageLabel.Size.X.Scale;
                        u44.AmountLabel.Text = tostring(u43.crimson_amount);
                        local v45, v46, v47 = pcall(function() --[[ Line: 244 ]]
                            -- upvalues: l__MarketplaceService__2 (ref), u43 (ref)
                            return l__MarketplaceService__2:GetProductInfoAsync(u43.product_id, Enum.InfoType.Product), l__MarketplaceService__2:GetProductInfoAsync(u43.gift_product_id, Enum.InfoType.Product);
                        end);
                        if l__tab_asset__14 and (not l__tab_asset__14 or l__tab_asset__14:FindFirstChild("DealsList")) then
                            if not v45 then
                                warn("[DealsTab] Failed to fetch crimson product pricing:", u43.product_id, v46);
                            end;
                            local v48 = v45 and v46.PriceInRobux or nil;
                            if v45 and typeof(v48) ~= "number" then
                                warn("[DealsTab] Crimson self-purchase product has no usable price:", u43.product_id);
                            end;
                            local v49 = v45 and v47.PriceInRobux or nil;
                            local v50 = not u36;
                            if v50 then
                                v50 = typeof(v48) == "number";
                            end;
                            local v51;
                            if v50 then
                                if typeof(v49) == "number" then
                                    v51 = v48 == v49;
                                else
                                    v51 = false;
                                end;
                            else
                                v51 = v50;
                            end;
                            u33._gift_purchase_available_by_product_id[u43.gift_product_id] = v51;
                            local v52 = typeof(v48) ~= "number" and "--" or v48;
                            local u53 = l__Scale__15 * u43.icon_scale;
                            u44.RobuxLabel.Text = "<b>" .. v52 .. "</b>";
                            u44.UpDescriptionLabel.Text = u43.top_desc;
                            u44.DownDescriptionLabel.Text = u43.bot_desc;
                            u44.MainImageLabel.Size = UDim2.fromScale(u53, u53);
                            if u43.shelf == 1 then
                                u44.Parent = u38;
                            elseif u43.shelf == 2 then
                                u44.Parent = u39;
                            end;
                            if u43.gradient then
                                u44.Gradient.Visible = true;
                            end;
                            u33._crimson_options_by_gift_product_id[u43.gift_product_id] = u44;
                            local u54 = u44:FindFirstChild("InventoryLabel");
                            if u54 and u54:IsA("TextLabel") then
                                u54.Visible = false;
                                u54.Text = "0 Unused";
                            end;
                            if u43.popular then
                                u44.Spotlighted.Visible = true;
                            end;
                            if u44.Button:IsA("GuiButton") then
                                u44.Button.Interactable = v50;
                                u44.Button.Active = v50;
                            end;
                            local u55 = u44:FindFirstChild("GiftButton");
                            if v50 then
                                u33.trove:Connect(u44.Button.Activated, function() --[[ Line: 306 ]]
                                    -- upvalues: l__Packets__6 (ref), u43 (ref)
                                    l__Packets__6._x4a9e94f14df7f3b8:Fire(u43.product_id);
                                end);
                                local u56 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
                                u33.trove:Connect(u44.Button.MouseEnter, function() --[[ Line: 312 ]]
                                    -- upvalues: l__TweenService__1 (ref), u44 (copy), u56 (copy), u53 (copy), u54 (copy), u55 (copy)
                                    l__TweenService__1:Create(u44.MainImageLabel, u56, {
                                        Size = UDim2.fromScale(u53 + 0.05, u53 + 0.05)
                                    }):Play();
                                    l__TweenService__1:Create(u54, u56, {
                                        TextTransparency = 0
                                    }):Play();
                                    l__TweenService__1:Create(u55, u56, {
                                        ImageTransparency = 0
                                    }):Play();
                                end);
                                u33.trove:Connect(u44.Button.MouseLeave, function() --[[ Line: 318 ]]
                                    -- upvalues: l__TweenService__1 (ref), u44 (copy), u56 (copy), u53 (copy), u55 (copy), u54 (copy)
                                    l__TweenService__1:Create(u44.MainImageLabel, u56, {
                                        Size = UDim2.fromScale(u53, u53)
                                    }):Play();
                                    l__TweenService__1:Create(u55, u56, {
                                        ImageTransparency = 0.9
                                    }):Play();
                                    l__TweenService__1:Create(u54, u56, {
                                        TextTransparency = 0.9
                                    }):Play();
                                end);
                            end;
                            if u55 then
                                u33.trove:Connect(u55.Activated, function() --[[ Line: 326 ]]
                                    -- upvalues: u33 (ref), u43 (ref)
                                    u33:_openGiftBrowser(u43);
                                end);
                            end;
                            if not (v51 or u36) then
                                warn("[DealsTab] New gift purchases disabled because displayed and gift prices differ:", u43.gift_product_id);
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
function u1.start(u57) --[[ Line: 340 ]]
    -- upvalues: l__Packets__6 (copy), l__MarketplaceService__2 (copy)
    u57.trove:Connect(l__Packets__6._xfaa2c2e4ef7509b5.OnClientEvent, function(p58) --[[ Line: 341 ]]
        -- upvalues: u57 (copy)
        if typeof(p58) == "table" then
            if p58.request_id == nil then
                if u57._pending_gift_product_id ~= nil and p58.product_id ~= u57._pending_gift_product_id then
                    return;
                end;
            elseif p58.request_id ~= u57._pending_gift_request_id then
                return;
            end;
            if p58.state == "prompting_purchase" or p58.state == "sending" then
                u57._gift_prompt_started = true;
                u57:_setGiftBlockState(p58.product_id, p58.state == "prompting_purchase" and "route" or "outbound");
            elseif p58.state == "purchase_settling" then
                u57:_setGiftBlockState(p58.product_id, "route");
            elseif p58.state == "delivery_pending" then
                u57:_setGiftBlockState(p58.product_id, "outbound");
            elseif p58.state == "rejected" or (p58.state == "recipient_busy" or (p58.state == "recipient_inbox_full" or (p58.state == "manual_remediation" or (p58.state == "delivered" or p58.state == "inventory_ready")))) then
                u57:_setGiftBlockState(p58.product_id, nil);
                u57:_finishGiftRequest();
            end;
            if p58.state == "purchase_settling" or p58.state == "delivery_pending" then
                u57:_finishGiftRequest();
            end;
        end;
    end);
    u57.trove:Connect(l__MarketplaceService__2.PromptProductPurchaseFinished, function(_, p59) --[[ Line: 377 ]]
        -- upvalues: u57 (copy)
        if p59 == u57._pending_gift_product_id then
            u57:_finishGiftRequest();
        end;
    end);
    u57.trove:Connect(u57._menu_session.onItemProfileUpdated, function() --[[ Line: 383 ]]
        -- upvalues: u57 (copy)
        u57:_updateGiftInventoryLabels();
    end);
    u57.tab_asset.Parent = u57.main_page.Main;
    task.spawn(function() --[[ Line: 388 ]]
        -- upvalues: u57 (copy)
        u57:_setupCrimsonOptions();
    end);
end;
return u1;
