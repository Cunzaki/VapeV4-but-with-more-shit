-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Util.ItemFrame
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__Maid__4 = require(l__ReplicatedStorage__2.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Module3D__6 = require(l__ReplicatedStorage__2.Modules.Module3D);
local l__Numerics__7 = require(l__ReplicatedStorage__2.Modules.Numerics);
local l__RarityUtil__8 = require(l__ReplicatedStorage__2.Modules.RarityUtil);
local l__ItemFrame__9 = l__ReplicatedStorage__2.Assets.Interface.ItemFrame;
local u1 = l__Mince__5:Get("LoftShop");
local u2 = l__Mince__5:Get("Inventory");
local u3 = {
    ValidTypes = {
        "Coins",
        "Holiday",
        "GatchaKeys",
        "InventoryItem",
        "UGC",
        "ShopItem"
    },
    DetailOffset = Vector2.new(5, -35)
};
function GetAssetIdFromRbxString(p4)
    local v5 = string.match(p4, "rbxassetid://(%d+)") or "";
    return tonumber(v5);
end;
function u3.GenerateFromItemTable(p6, p7) --[[ Line: 26 ]]
    -- upvalues: u3 (copy), l__Maid__4 (copy), l__ItemFrame__9 (copy), l__Numerics__7 (copy), u2 (copy), l__RarityUtil__8 (copy), l__ReplicatedStorage__2 (copy), l__MarketplaceService__1 (copy), u1 (copy), l__Module3D__6 (copy), l__RunService__3 (copy)
    p6.Value = p6.Value or p6.Amount;
    local v8 = typeof(p6) == "table";
    assert(v8, "GenerateFromItemTable([1]) must be a table.");
    assert(p6.Value or p6.Amount, "ItemTable.Value required.");
    assert(p6.Type, "ItemTable.Type required.");
    local v9 = u3.ValidTypes[p6.Type];
    local v10 = `'{p6.Type}' is not a valid type.`;
    assert(v9, v10);
    local u11 = {
        Maid = l__Maid__4.new(),
        Gui = l__ItemFrame__9:WaitForChild(p6.Type):Clone()
    };
    if p6.Type == "Coins" or (p6.Type == "Holiday" or p6.Type == "GatchaKeys") then
        u11.Gui.AmountLabel.Text = l__Numerics__7.TruncateNumber(p6.Value);
    elseif p6.Type == "InventoryItem" then
        local v12 = u2.Items[p6.Value];
        local v13 = l__RarityUtil__8.GetRarity(v12.Rarity).GetColors();
        if v12.RenderText then
            u11.Gui.Render.Visible = false;
            u11.Gui.RenderText.Visible = true;
            u11.Gui.RenderText.Text = v12.RenderText;
        elseif v12.Render then
            local v14 = GetAssetIdFromRbxString(v12.Render);
            u11.Gui.Render.Image = `rbxthumb://type=Asset&id={v14}&w=150&h=150`;
        end;
        u11.Gui.Icon.Image = v12.Category.Icon;
        u11.Gui.ItemName.Text = v12.Name;
        u11.Gui.UIGradient.Color = v13.Graident;
        u11.Gui.UIStroke.UIGradient.Color = v13.Graident;
        local v15 = v12.Extra and l__ReplicatedStorage__2.Assets.Interface.Extra:FindFirstChild(v12.Extra);
        if v15 then
            v15:Clone().Parent = u11.Gui;
        end;
    elseif p6.Type == "UGC" then
        local v16 = l__MarketplaceService__1:GetProductInfo(p6.Value, Enum.InfoType.Asset);
        u11.Gui.Render.Image = `rbxthumb://type=Asset&id={p6.Value}&w=420&h=420`;
        u11.Gui.ItemName.Text = v16.Name;
    elseif p6.Type == "ShopItem" then
        local u17 = u1.ItemByName[p6.Name];
        u11.Placement = u17.PlacementModel:Clone();
        u11.Model3D = l__Module3D__6:Attach3D(u11.Gui, u11.Placement);
        u11.Model3D:SetDepthMultiplier(1.2);
        u11.Model3D.CurrentCamera.FieldOfView = 5;
        u11.Model3D.Visible = true;
        u11.Model3D:SetCFrame(u17.Item.Offset);
        u11.Maid:Add(u11.Gui.MouseEnter:Connect(function() --[[ Line: 96 ]]
            -- upvalues: u11 (copy), u17 (copy), l__RunService__3 (ref)
            if u11.__SpinEvent then
                u11.__SpinEvent:Disconnect();
            end;
            u11.Model3D:SetCFrame(u17.Item.Offset);
            u11.TimeElapsed = 0;
            u11.__SpinEvent = l__RunService__3.RenderStepped:Connect(function(p18) --[[ Line: 99 ]]
                -- upvalues: u11 (ref), u17 (ref)
                local v19 = u11;
                v19.TimeElapsed = v19.TimeElapsed + p18;
                u11.Model3D:SetCFrame(CFrame.Angles(0, u11.TimeElapsed % 6.283185307179586, 0) * u17.Item.Offset);
            end);
        end));
        u11.Maid:Add(u11.Gui.MouseLeave:Connect(function() --[[ Line: 89 ]]
            -- upvalues: u11 (copy), u17 (copy)
            if u11.__SpinEvent then
                u11.__SpinEvent:Disconnect();
            end;
            u11.Model3D:SetCFrame(u17.Item.Offset);
        end));
    end;
    u11.Maid:Add(u11.Gui);
    function u11.Destroy() --[[ Line: 112 ]]
        -- upvalues: u11 (copy)
        u11.Maid:Clean();
    end;
    if p7 then
        u11.Gui.Parent = p7;
    end;
    return u11;
end;
function u3.Init() --[[ Line: 123 ]]
    -- upvalues: u3 (copy)
    for _, v20 in u3.ValidTypes do
        u3.ValidTypes[v20] = true;
    end;
end;
u3.Init();
return u3;
