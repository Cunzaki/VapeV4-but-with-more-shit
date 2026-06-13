-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.LootboxRelated.BuyLootbox
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = game:GetService("PolicyService"):GetPolicyInfoForPlayerAsync(game:GetService("Players").LocalPlayer);
local l__Maid__2 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Numerics__4 = require(l__ReplicatedStorage__1.Modules.Numerics);
local l__RarityUtil__5 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
local l__LootboxUtil__6 = require(l__ReplicatedStorage__1.Modules.LootboxUtil);
local u2 = l__Mince__3:Get("ConfirmPrompt");
local u3 = l__Mince__3:Get("OpeningHandler");
local u4 = l__Mince__3:Get("InterfaceHandler");
local u5 = l__Mince__3:Get("Inventory");
local u6 = l__Mince__3:GetFunction("LootboxRequest");
local u7 = {
    Maid = l__Maid__2.new()
};
function u7.SetupFor(u8) --[[ Line: 28 ]]
    -- upvalues: u1 (copy), u7 (copy), l__LootboxUtil__6 (copy), u5 (copy), l__RarityUtil__5 (copy), l__ReplicatedStorage__1 (copy), l__Numerics__4 (copy), u4 (copy), u2 (copy), u6 (copy), u3 (copy)
    if u1.ArePaidRandomItemsRestricted then
        u7.Interface.TweenFrame.Container.Visible = false;
        u7.Interface.TweenFrame.Purchase.Visible = false;
        u7.Interface.TweenFrame.RegionWarning.Visible = true;
    else
        local u9 = l__LootboxUtil__6.GetLootbox(u8);
        local v10 = `Failed to load the lootbox by the name of '{u8}'!`;
        assert(u9, v10);
        local function v18(p11, p12) --[[ Line: 41 ]]
            -- upvalues: u5 (ref), l__RarityUtil__5 (ref), l__ReplicatedStorage__1 (ref)
            local v13 = u5.Items[p12.IVID];
            local v14 = l__RarityUtil__5.GetRarity(v13.Rarity).GetColors();
            p11.Button.Icon.Image = v13.Category.Icon;
            p11.Button.Render.Image = v13.Render;
            p11.Button.UIGradient.Color = v14.Graident;
            p11.Button.UIStroke.UIGradient.Color = v14.Graident;
            local l__Chance__7 = p11.Button.Chance;
            local l__format__8 = string.format;
            local v15 = -math.log10(p12.Chance);
            local v16 = math.ceil(v15);
            l__Chance__7.Text = l__format__8(`%.{math.max(0, v16)}f%%`, 100 * p12.Chance);
            if v13.Extra then
                local v17 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v13.Extra);
                if v17 then
                    v17:Clone().Parent = p11.Button;
                    return;
                end;
                warn((`Could not find the extra for '{v13.Extra}'`));
            end;
        end;
        for _, v19 in u9.Chances do
            local v20 = l__ReplicatedStorage__1.Assets.Interface.ChanceItem:Clone();
            v20.Size = UDim2.new(0.235, 0, 0.494, 0);
            v20.Parent = u7.Interface.TweenFrame.Container;
            u7.Maid:Add(v20);
            v18(v20, v19);
        end;
        u7.Interface.TweenFrame.Purchase.CoinLabel.Text = l__Numerics__4.WithCommas(u9.Cost.Amount);
        u7.Maid:Add(u4.NewButton(u7.Interface.TweenFrame.Purchase).Activated:Connect(function() --[[ Line: 77 ]]
            -- upvalues: u2 (ref), u9 (copy), u6 (ref), u8 (copy), u3 (ref), l__LootboxUtil__6 (ref)
            u2.Display(`Are you sure you want to purcahse this for {u9.Cost.Amount} {u9.Cost.Currency}?`, function() --[[ Line: 78 ]]
                -- upvalues: u6 (ref), u8 (ref), u3 (ref), l__LootboxUtil__6 (ref)
                local v21, v22 = pcall(function() --[[ Line: 79 ]]
                    -- upvalues: u6 (ref), u8 (ref)
                    return u6:Invoke(u8);
                end);
                if v21 and v22 then
                    u3[l__LootboxUtil__6.FN or "StartCapsuleOpening"]({
                        IVID = v22
                    });
                end;
            end);
        end));
    end;
end;
function u7.SetupGUI() --[[ Line: 92 ]]
    -- upvalues: u4 (copy), u7 (copy)
    u4.NewButton(u7.Interface.TweenFrame.CloseButton).Activated:Connect(u7.Interface.Close);
end;
function u7.Setup() --[[ Line: 98 ]]
    -- upvalues: u7 (copy), u4 (copy), l__Mince__3 (copy)
    u7.Interface = u4.Get("BuyLootbox");
    u7.Interface.TweenFrame.TopTitle.TextLabel.Text = l__Mince__3.Config.HolidayConfigure.BUY_LOOTBOX_TITLE;
    u7.SetupFor(l__Mince__3.Config.HolidayConfigure.BUYLOOTBOXID);
    u7.SetupGUI();
end;
return u7;
