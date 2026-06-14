-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.EventShop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Maid__2 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Unify);
require(l__ReplicatedStorage__1.Modules.Signal);
local l__Bucket__4 = require(l__ReplicatedStorage__1.Modules.Bucket);
local l__RarityUtil__5 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
require(l__ReplicatedStorage__1.Modules.Module3D);
local l__Numerics__6 = require(l__ReplicatedStorage__1.Modules.Numerics);
require(l__ReplicatedStorage__1.Modules.LootboxUtil);
local l__Signal__7 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__3:Get("Voicelines");
l__Mince__3:Get("ItemFrame");
l__Mince__3:Get("UserProfile");
local u2 = l__Mince__3:Get("InterfaceHandler");
local u3 = l__Mince__3:Get("CoinController");
local u4 = l__Mince__3:Get("NotifPrompt");
local u5 = l__Mince__3:Get("ConfirmPrompt");
l__Mince__3:Get("OpeningHandler");
local u6 = l__Mince__3:Get("Inventory");
local u7 = l__Mince__3:Get("ItemFrame");
local u8 = l__Mince__3:GetEvent("InvShop"):Extend("PurchaseItem");
local u9 = false;
local u10 = {
    Maid = l__Maid__2.new(),
    Items = {},
    ItemByName = {},
    Lookup = {},
    Voicelines = l__Bucket__4.new({
        "THANKS25Buy1",
        "THANKS25Buy2",
        "THANKS25Buy3",
        "THANKS25Buy4"
    }),
    Translations = {
        Holiday = l__Mince__3.Config.HolidayConfigure.EVENT_CURRENCY_NAME
    }
};
local u11 = {};
u11.__index = u11;
function u11.new(...) --[[ Line: 51 ]]
    -- upvalues: u11 (copy)
    local v12 = setmetatable({}, u11);
    v12:Init(...);
    return v12;
end;
function u11.Init(p13, u14, u15, p16) --[[ Line: 57 ]]
    -- upvalues: l__Maid__2 (copy), u6 (copy), l__RarityUtil__5 (copy), l__ReplicatedStorage__1 (copy), l__Numerics__6 (copy), u2 (copy), u9 (ref), u4 (copy), u5 (copy), u10 (copy), u8 (copy), u1 (copy), u7 (copy)
    p13.Maid = l__Maid__2.new();
    p13.Class = u6.Items[u14.Item];
    if p13.Class then
        p13.Rarity = l__RarityUtil__5.GetRarity(p13.Class.Rarity);
        p13.Interface = l__ReplicatedStorage__1.Assets.Interface.EventShopItem:Clone();
        p13.Interface.LayoutOrder = -p13:GetCheapSortOrder();
        p13.Interface.Parent = p16;
        p13.Interface.BuyButton.CoinLabel.Text = l__Numerics__6.WithCommas(u14.Cost.Amount);
        p13.Maid:Add(u2.NewButton(p13.Interface.BuyButton).Activated:Connect(function() --[[ Line: 73 ]]
            -- upvalues: u6 (ref), u14 (copy), u9 (ref), u4 (ref), u5 (ref), l__Numerics__6 (ref), u10 (ref), u8 (ref), u15 (copy), u1 (ref)
            local v17 = u6.Items[u14.Item];
            if v17.Category.DestroyUponEquip then
                local u18 = coroutine.running();
                u9 = true;
                u4.Display("This item is a consumable (deletes after equip). If you die the item is not recoverable. It may have multiple uses once equipped.", function() --[[ Line: 78 ]]
                    -- upvalues: u18 (copy)
                    task.spawn(u18);
                end);
                coroutine.yield();
                u9 = false;
            end;
            u9 = true;
            u5.Display(`Would you like to buy '{v17.Name}' for {l__Numerics__6.WithCommas(u14.Cost.Amount)} {u10.Translations[u14.Cost.Currency] or (u14.Cost.Currency or "Coins")}`, function() --[[ Line: 86 ]]
                -- upvalues: u8 (ref), u15 (ref), u1 (ref), u10 (ref), u9 (ref)
                u8:Fire("EventItems", u15);
                u1.PlayLine(u10.Voicelines:Next());
                u9 = false;
            end, function() --[[ Line: 90 ]]
                -- upvalues: u9 (ref)
                u9 = false;
            end);
        end));
        p13.ItemFrame = u7.GenerateFromItemTable({
            Type = "InventoryItem",
            Value = u14.Item
        }, p13.Interface.Container);
        if u14.NewAlert then
            l__ReplicatedStorage__1.Assets.Interface.ItemOverlays.NewItemAlert:Clone().Parent = p13.ItemFrame.Gui;
            p13.Interface.LayoutOrder = -p13:GetCheapSortOrder();
        end;
        p13.Maid:Add(p13.Interface);
        p13.Maid:Add(p13.ItemFrame);
    else
        warn((`Failed to create EventShopItem because '{u14.Item}' does not exist!`));
    end;
end;
function u11.GetCheapSortOrder(p19) --[[ Line: 106 ]]
    return p19.Rarity.Order * 100 + p19.Class.Category.Order;
end;
function u11.Destroy(p20) --[[ Line: 110 ]]
    p20.Maid:Clean();
end;
function u10.SetupEventShop() --[[ Line: 114 ]]
    -- upvalues: l__Mince__3 (copy), u10 (copy), u11 (copy)
    for v21, v22 in l__Mince__3.Config.InvShopItems.EventItems do
        u10.Maid:Add(u11.new(v22, v21, u10.Interface.TweenFrame.Scroll));
    end;
end;
function u10.SetupUI() --[[ Line: 120 ]]
    -- upvalues: u2 (copy), u10 (copy), u3 (copy), l__Signal__7 (copy), u9 (ref)
    u2.NewButton(u10.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 123 ]]
        -- upvalues: u3 (ref), u10 (ref)
        u3.SetForceEnabled(false);
        u10.Interface.Close();
    end);
    u10.Closed = l__Signal__7.new();
    u10.Interface.Opened:Connect(function() --[[ Line: 130 ]]
        -- upvalues: u10 (ref), u3 (ref)
        if u10.UpdateConnection then
            u10.UpdateConnection:Disconnect();
        end;
        u3.SetForceEnabled(true);
    end);
    u10.Interface.Closed:Connect(function() --[[ Line: 136 ]]
        -- upvalues: u10 (ref), u9 (ref)
        if u10.ShouldPlayLine then
            u10.ShouldPlayLine = false;
        end;
        if u10.UpdateConnection then
            u10.UpdateConnection:Disconnect();
        end;
        if not u9 then
            u10.Closed:Fire();
        end;
    end);
end;
function u10.Setup() --[[ Line: 148 ]]
    -- upvalues: u10 (copy), u2 (copy), l__Mince__3 (copy)
    u10.Interface = u2.Get("EventShop");
    u10.Container = u10.Interface.TweenFrame.Scroll;
    u10.Config = l__Mince__3.Config.InvShopItems.EventItems;
    u10.ItemList = u10.Interface.TweenFrame.Scroll;
    for _, v23 in l__Mince__3.Config.InvShopItems.EventItems do
        u10.Lookup[v23.Item] = v23;
    end;
    u10.SetupUI();
    u10.SetupEventShop();
end;
return u10;
