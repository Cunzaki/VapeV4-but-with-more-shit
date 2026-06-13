-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.DailyBuyBoard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__PolicyService__2 = game:GetService("PolicyService");
local l__Players__3 = game:GetService("Players");
game:GetService("MarketplaceService");
l__PolicyService__2:GetPolicyInfoForPlayerAsync(l__Players__3.LocalPlayer);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__RarityUtil__5 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
require(l__ReplicatedStorage__1.Modules.LootboxUtil);
local u1 = l__Mince__4:Get("Inventory");
l__Mince__4:Get("ItemFrame");
local v2 = l__Mince__4.Component({
    Tag = "DailyBoard"
});
function GetAssetIdFromRbxString(p3)
    local v4 = string.match(p3, "rbxassetid://(%d+)") or "";
    return tonumber(v4);
end;
function v2.CreateItems(p5) --[[ Line: 27 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy), l__RarityUtil__5 (copy)
    for v6, v7 in ipairs(p5.Config) do
        local l__Reward__6 = v7.Reward;
        local v8 = l__ReplicatedStorage__1.Assets.Interface.ChanceItem:Clone();
        v8.Parent = p5.Container;
        v8.Button.Chance.Text = `Day {v6}`;
        if l__Reward__6.Type == "InventoryItem" then
            local v9 = u1.Items[l__Reward__6.Value];
            local v10 = l__RarityUtil__5.GetRarity(v9.Rarity);
            local v11 = v10.GetColors();
            local v12 = GetAssetIdFromRbxString(v9.Category.Icon);
            v8.Button.Icon.Image = `rbxthumb://type=Asset&id={v12}&w=150&h=150`;
            v8.Button.Render.Image = v9.Render;
            v8.Button.UIGradient.Color = v11.Graident;
            v8.Button.UIStroke.UIGradient.Color = v11.Graident;
            if v9.Extra then
                local v13 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v9.Extra);
                if v13 then
                    v13:Clone().Parent = v8.Button;
                else
                    warn((`Could not find the extra for '{v9.Extra}'`));
                end;
            end;
            if v10.Data.Extra then
                local v14 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v10.Data.Extra);
                if v14 then
                    v14:Clone().Parent = v8.Button;
                else
                    warn((`Could not find the extra for '{v10.Data.Extra}'`));
                end;
            end;
        elseif l__Reward__6.Type == "UGC" then
            v8.Button.Icon:Destroy();
            v8.Button.Render.Image = `rbxthumb://type=Asset&id={l__Reward__6.Value}&w=420&h=420`;
            v8.Button.BackgroundTransparency = 1;
            v8.Button.UIStroke.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.164706, 0.164706, 0.164706));
        end;
    end;
end;
function v2.Construct(p15) --[[ Line: 74 ]]
    -- upvalues: l__Mince__4 (copy)
    local v16 = typeof(p15.Name) == "string";
    assert(v16, "Self name must exist and be an a string! ");
    p15.Config = l__Mince__4.Config.DailyBuy;
    local l__Config__7 = p15.Config;
    local v17 = `Failed to load the lootbox by the name of '{p15.Name}'!`;
    assert(l__Config__7, v17);
    p15.Container = p15.Instance.Container;
    p15:CreateItems();
end;
return v2;
