-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.ChanceBoard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = game:GetService("PolicyService"):GetPolicyInfoForPlayerAsync(game:GetService("Players").LocalPlayer);
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__RarityUtil__3 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
local l__LootboxUtil__4 = require(l__ReplicatedStorage__1.Modules.LootboxUtil);
local u2 = l__Mince__2:Get("Inventory");
local v3 = l__Mince__2.Component({
    Tag = "ChanceBoard"
});
function GetAssetIdFromRbxString(p4)
    local v5 = string.match(p4, "rbxassetid://(%d+)") or "";
    return tonumber(v5);
end;
function v3.CreateItems(p6) --[[ Line: 26 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u2 (copy), l__RarityUtil__3 (copy)
    for _, u7 in p6.Config.Chances do
        local v8 = l__ReplicatedStorage__1.Assets.Interface.ChanceItem:Clone();
        v8.Parent = p6.Container;
        local u9 = l__ReplicatedStorage__1.Assets.Interface.ItemOverlays.Aquired:Clone();
        u9.Visible = false;
        u9.Parent = v8.Button;
        local v10 = u2.Items[u7.IVID];
        local v11 = `There is no item '{u7.IVID}'`;
        assert(v10, v11);
        local v12 = l__RarityUtil__3.GetRarity(v10.Rarity);
        local v13 = v12.GetColors();
        local v14 = GetAssetIdFromRbxString(v10.Category.Icon);
        v8.LayoutOrder = -math.floor(u7.Chance * 1000);
        v8.Button.Icon.Image = `rbxthumb://type=Asset&id={v14}&w=150&h=150`;
        v8.Button.Render.Image = v10.Render;
        v8.Button.UIGradient.Color = v13.Graident;
        v8.Button.UIStroke.UIGradient.Color = v13.Graident;
        local l__Chance__5 = v8.Button.Chance;
        local l__format__6 = string.format;
        local v15 = -math.log10(u7.Chance);
        local v16 = math.ceil(v15);
        l__Chance__5.Text = l__format__6(`%.{math.max(0, v16)}f%%`, 100 * u7.Chance);
        if v10.Extra then
            local v17 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v10.Extra);
            if v17 then
                v17:Clone().Parent = v8.Button;
            else
                warn((`Could not find the extra for '{v10.Extra}'`));
            end;
        end;
        if v12.Data.Extra then
            local v18 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v12.Data.Extra);
            if v18 then
                v18:Clone().Parent = v8.Button;
            else
                warn((`Could not find the extra for '{v12.Data.Extra}'`));
            end;
        end;
        u2.WhenUpdated(function() --[[ Line: 69 ]]
            -- upvalues: u9 (copy), u2 (ref), u7 (copy)
            u9.Visible = u2.MoreThan1IVID(u7.IVID);
        end);
    end;
end;
function v3.Construct(p19) --[[ Line: 75 ]]
    -- upvalues: l__LootboxUtil__4 (copy), u1 (copy)
    local v20 = typeof(p19.Name) == "string";
    assert(v20, "Self name must exist and be an a string! ");
    p19.Config = l__LootboxUtil__4.GetLootbox(p19.Name);
    local l__Config__7 = p19.Config;
    local v21 = `Failed to load the lootbox by the name of '{p19.Name}'!`;
    assert(l__Config__7, v21);
    p19.Container = p19.Instance.Container;
    if u1.ArePaidRandomItemsRestricted and not p19.BypassWarnings then
        p19.Instance.RegionWarning.Visible = true;
    else
        p19:CreateItems();
    end;
end;
return v3;
