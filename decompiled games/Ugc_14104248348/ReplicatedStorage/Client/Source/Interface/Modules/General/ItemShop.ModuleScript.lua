-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.ItemShop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Maid__3 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__5 = require(l__ReplicatedStorage__1.Modules.Unify);
require(l__ReplicatedStorage__1.Modules.Module3D);
local l__Numerics__6 = require(l__ReplicatedStorage__1.Modules.Numerics);
local l__RarityUtil__7 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
l__Mince__4:Get("UserProfile");
local u1 = l__Mince__4:Get("ItemFrame");
local u2 = l__Mince__4:Get("NotifPrompt");
local u3 = l__Mince__4:Get("UserProfile");
local u4 = l__Mince__4:Get("ConfirmPrompt");
local u5 = l__Mince__4:Get("OpeningHandler");
local u6 = l__Mince__4:Get("Inventory");
local u7 = l__Mince__4:Get("CoinController");
local u8 = l__Mince__4:Get("InterfaceHandler");
local u9 = l__Mince__4:Get("Topbar");
local u10 = l__Mince__4:Get("Inventory");
l__Mince__4:GetEvent("LoftShop"):Extend("BuyItem");
local v11 = l__Mince__4:GetEvent("InvShop");
local u12 = v11:Extend("DoGainItem");
local u13 = v11:Extend("PurchaseItem");
local u14 = v11:Extend("UpdateSeen");
local u15 = {
    Items = {},
    ItemByName = {},
    NewItems = {},
    Maid = l__Maid__3.new()
};
local u16 = {};
u16.__index = u16;
function u16.new(...) --[[ Line: 43 ]]
    -- upvalues: u16 (copy)
    local v17 = setmetatable({}, u16);
    v17:Init(...);
    return v17;
end;
function u16.Init(_, _, _) --[[ Line: 49 ]] end;
local u18 = {};
u18.__index = u18;
function u18.new(...) --[[ Line: 56 ]]
    -- upvalues: u18 (copy)
    local v19 = setmetatable({}, u18);
    v19:Init(...);
    return v19;
end;
function u18.Init(p20, u21, u22, u23) --[[ Line: 62 ]]
    -- upvalues: l__Maid__3 (copy), u6 (copy), l__RarityUtil__7 (copy), l__ReplicatedStorage__1 (copy), l__Numerics__6 (copy), u8 (copy), u2 (copy), u4 (copy), u13 (copy), u1 (copy), u15 (copy)
    p20.Maid = l__Maid__3.new();
    p20.Class = u6.Items[u21.Item];
    if p20.Class then
        p20.Item = u21.Item;
        p20.Rarity = l__RarityUtil__7.GetRarity(p20.Class.Rarity);
        p20.Interface = l__ReplicatedStorage__1.Assets.Interface.InvShopItem:Clone();
        p20.Interface.LayoutOrder = p20:GetCheapSortOrder();
        p20.Interface.Parent = u23;
        p20.Interface.BuyButton.CoinLabel.Text = l__Numerics__6.WithCommas(u21.Cost.Amount);
        if u21.Cost.Amount == 0 then
            p20.Interface.BuyButton.CoinLabel.Text = "Free";
        end;
        p20.BuyButton = u8.NewButton(p20.Interface.BuyButton);
        p20.Maid:Add(p20.BuyButton.Activated:Connect(function() --[[ Line: 84 ]]
            -- upvalues: u6 (ref), u21 (copy), u2 (ref), u4 (ref), l__Numerics__6 (ref), u13 (ref), u23 (copy), u22 (copy)
            local v24 = u6.Items[u21.Item];
            if v24.Category.DestroyUponEquip then
                local u25 = coroutine.running();
                u2.Display("This item is a consumable (deletes after equip). If you die the item is not recoverable. It may have multiple uses once equipped.", function() --[[ Line: 88 ]]
                    -- upvalues: u25 (copy)
                    task.spawn(u25);
                end);
                coroutine.yield();
            end;
            u4.Display(`Would you like to buy '{v24.Name}' for {l__Numerics__6.WithCommas(u21.Cost.Amount)} {u21.Cost.Currency or "Coins"}`, function() --[[ Line: 95 ]]
                -- upvalues: u13 (ref), u23 (ref), u22 (ref)
                u13:Fire(u23.Name, u22);
            end);
        end));
        p20.ItemFrame = u1.GenerateFromItemTable({
            Type = "InventoryItem",
            Value = u21.Item
        }, p20.Interface.Container);
        if u21.NewAlert then
            l__ReplicatedStorage__1.Assets.Interface.ItemOverlays.NewItemAlert:Clone().Parent = p20.ItemFrame.Gui;
            p20.Interface.LayoutOrder = -p20:GetCheapSortOrder();
            table.insert(u15.NewItems, u21.Item);
            if u21.Cost.Amount == 0 then
                u15.OneNewItemIsFree = true;
            end;
        end;
        p20.Maid:Add(p20.Interface);
        p20.Maid:Add(p20.ItemFrame);
        p20:CheckIfBought();
    else
        warn((`Failed to create ItemShopItem because '{u21.Item}' does not exist!`));
    end;
end;
function u18.GetCheapSortOrder(p26) --[[ Line: 124 ]]
    local v27 = p26.Rarity.Order * 100 + p26.Class.Category.Order;
    if p26.Bought then
        v27 = v27 * 100000;
    end;
    return v27;
end;
function u18.Destroy(p28) --[[ Line: 133 ]]
    p28.Maid:Clean();
end;
function u18.CheckIfBought(p29) --[[ Line: 137 ]]
    -- upvalues: u6 (copy)
    if p29.Bought then
    else
        local l__DontAllowDuplicates__8 = p29.Class.Category.DontAllowDuplicates;
        if u6.MoreThan1IVID(p29.Item) and l__DontAllowDuplicates__8 then
            p29.Interface.BuyButton.ImageLabel.Visible = false;
            p29.Interface.BuyButton.CoinLabel.Text = "Bought";
            p29.Interface.BuyButton.CoinLabel.TextColor3 = Color3.new(1, 1, 1);
            p29.BuyButton.SetState("Disabled");
            p29.Bought = true;
            p29.Interface.LayoutOrder = p29:GetCheapSortOrder();
        end;
    end;
end;
function u15.Update(_) --[[ Line: 153 ]]
    -- upvalues: u15 (copy), l__Unify__5 (copy)
    if u15.LastData then
        local v30 = l__Unify__5.GetServerTimeUntil(u15.LastData.ResetNextOn);
        u15.Interface.TweenFrame.Container.OffersTitle.TimerLabel.Text = `<b>{l__Unify__5.AbbreviatedTime((math.max(0, v30)))}</b> until refresh.`;
        if not u15.LastData.HasCheckedForThisData and v30 < -1 then
            u15.LastData.HasCheckedForThisData = true;
        end;
    end;
end;
function u15.SetupShop() --[[ Line: 165 ]]
    -- upvalues: l__Mince__4 (copy), u15 (copy), u18 (copy)
    for v31, v32 in l__Mince__4.Config.InvShopItems.Featured do
        table.insert(u15.Items, u18.new(v32, v31, u15.Interface.TweenFrame.Container.Featured));
    end;
end;
function u15.SetupGui() --[[ Line: 171 ]]
    -- upvalues: u8 (copy), u15 (copy)
    u8.NewButton(u15.Interface.TweenFrame.CloseButton).Activated:Connect(u15.Interface.Close);
end;
function u15.Trigger() --[[ Line: 177 ]]
    -- upvalues: u15 (copy)
    u15.Interface.Trigger();
end;
function u15.Setup() --[[ Line: 181 ]]
    -- upvalues: u15 (copy), u8 (copy), u14 (copy), u7 (copy), u10 (copy), u3 (copy), u9 (copy), l__RunService__2 (copy), u12 (copy), u5 (copy)
    u15.Items = {};
    u15.Interface = u8.Get("ItemShop");
    u15.Interface.Opened:ConnectOnce(function() --[[ Line: 185 ]]
        -- upvalues: u14 (ref), u15 (ref)
        u14:Fire(u15.NewItems);
    end);
    u15.Interface.Opened:Connect(function() --[[ Line: 188 ]]
        -- upvalues: u7 (ref), u15 (ref)
        u7.SetForceEnabled(true);
        for _, v33 in u15.Items do
            v33:CheckIfBought();
        end;
    end);
    u15.Interface.Closed:Connect(function() --[[ Line: 195 ]]
        -- upvalues: u7 (ref)
        u7.SetForceEnabled(false);
    end);
    u10.InvNewItemAdded:Connect(function() --[[ Line: 198 ]]
        -- upvalues: u15 (ref)
        task.wait(1);
        if u15.IsActive then
            for _, v34 in u15.Items do
                v34:CheckIfBought();
            end;
        end;
    end);
    u15.SetupGui();
    u15.SetupShop();
    u3.Upon("ShopSeen", function(p35) --[[ Line: 210 ]]
        -- upvalues: u15 (ref), u9 (ref)
        local v36 = 0;
        for _, v37 in u15.NewItems do
            if not p35[v37] then
                v36 = v36 + 1;
            end;
        end;
        u9.ItemShopButton:clearNotices();
        for _ = 1, v36 do
            u9.ItemShopButton:notify();
        end;
    end);
    l__RunService__2.Heartbeat:Connect(u15.Update);
    u12.Event:Connect(function(p38) --[[ Line: 225 ]]
        -- upvalues: u5 (ref)
        u5.DoItemGain({
            IVID = p38
        });
    end);
end;
return u15;
