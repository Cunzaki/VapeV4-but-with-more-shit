-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.DailyBuy
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Maid__3 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__5 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__Signal__6 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Bucket__7 = require(l__ReplicatedStorage__1.Modules.Bucket);
local l__RarityUtil__8 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
require(l__ReplicatedStorage__1.Modules.LootboxUtil);
local u1 = l__Mince__4:Get("Voicelines");
l__Mince__4:Get("ItemFrame");
local u2 = l__Mince__4:Get("UserProfile");
local u3 = l__Mince__4:Get("InterfaceHandler");
local v4 = l__Mince__4:GetEvent("DailyBuy");
local u5 = v4:Extend("Purchase");
local u6 = v4:Extend("ServerCheckDaily");
local u7 = l__Mince__4:Get("Inventory");
local u8 = l__Mince__4:Get("ItemFrame");
local u9 = {
    IfReportedThisTimeAround = false,
    NextDayPending = false,
    Maid = l__Maid__3.new(),
    NextDayPendingChanged = l__Signal__6.new(),
    Voicelines = l__Bucket__7.new({
        "CHRS24Daily1",
        "CHRS24Daily2",
        "CHRS24Daily3",
        "CHRS24Daily4",
        "CHRS24Daily5",
        "CHRS24Daily6"
    })
};
function GetAssetIdFromRbxString(p10)
    local v11 = string.match(p10, "rbxassetid://(%d+)") or "";
    return tonumber(v11);
end;
function u9.CreateItems() --[[ Line: 40 ]]
    -- upvalues: u9 (copy), l__ReplicatedStorage__1 (copy), u7 (copy), l__RarityUtil__8 (copy)
    for v12, v13 in ipairs(u9.Config) do
        local l__Reward__9 = v13.Reward;
        local v14 = l__ReplicatedStorage__1.Assets.Interface.ChanceItem:Clone();
        v14.Parent = u9.ItemList;
        v14.UIAspectRatioConstraint:Destroy();
        v14.Button.Chance.Text = `Day {v12}`;
        if l__Reward__9.Type == "InventoryItem" then
            local v15 = u7.Items[l__Reward__9.Value];
            local v16 = l__RarityUtil__8.GetRarity(v15.Rarity);
            local v17 = v16.GetColors();
            local v18 = GetAssetIdFromRbxString(v15.Category.Icon);
            v14.Button.Icon.Image = `rbxthumb://type=Asset&id={v18}&w=150&h=150`;
            v14.Button.Render.Image = v15.Render;
            v14.Button.UIGradient.Color = v17.Graident;
            v14.Button.UIStroke.UIGradient.Color = v17.Graident;
            if v15.Extra then
                local v19 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v15.Extra);
                if v19 then
                    v19:Clone().Parent = v14.Button;
                else
                    warn((`Could not find the extra for '{v15.Extra}'`));
                end;
            end;
            if v16.Data.Extra then
                local v20 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(v16.Data.Extra);
                if v20 then
                    v20:Clone().Parent = v14.Button;
                else
                    warn((`Could not find the extra for '{v16.Data.Extra}'`));
                end;
            end;
        elseif l__Reward__9.Type == "UGC" then
            v14.Button.Icon:Destroy();
            v14.Button.Render.Image = `rbxthumb://type=Asset&id={l__Reward__9.Value}&w=420&h=420`;
            v14.Button.BackgroundTransparency = 1;
            v14.Button.UIStroke.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.164706, 0.164706, 0.164706));
        end;
    end;
end;
function u9.Update(_) --[[ Line: 88 ]]
    -- upvalues: l__Mince__4 (copy), l__Unify__5 (copy), u9 (copy), u6 (copy)
    local l__LocalProfile__10 = l__Mince__4.Config.LocalProfile;
    if l__LocalProfile__10.DailyBuy.NextDayTime then
        local v21 = l__Unify__5.GetServerTimeUntil(l__LocalProfile__10.DailyBuy.NextDayTime);
        if v21 < 0 and not u9.IfReportedThisTimeAround then
            u9.IfReportedThisTimeAround = true;
            u6:Fire();
            return;
        end;
        u9.Container.NextDay.WaitTime.Visible = true;
        u9.Container.NextDay.WaitTime.TimeLabel.Text = l__Unify__5.AbbreviatedTime(v21);
    end;
end;
function u9.GetNextDay() --[[ Line: 103 ]]
    -- upvalues: l__Mince__4 (copy)
    local v22 = l__Mince__4.Config.LocalProfile.DailyBuy.CurrentIndex + 1;
    return l__Mince__4.Config.DailyBuy[not l__Mince__4.Config.DailyBuy[v22] and 1 or v22];
end;
function u9.UpdatePage() --[[ Line: 116 ]]
    -- upvalues: l__Mince__4 (copy), u9 (copy), u8 (copy)
    local l__LocalProfile__11 = l__Mince__4.Config.LocalProfile;
    if l__LocalProfile__11.DailyBuy then
        u9.Maid:Clean();
        local v23 = l__Mince__4.Config.DailyBuy[l__Mince__4.Config.LocalProfile.DailyBuy.CurrentIndex];
        local v24 = u9.GetNextDay();
        u9.Maid:Add(u8.GenerateFromItemTable(v23.Reward, u9.Container.ThisDay));
        u9.Maid:Add(u8.GenerateFromItemTable(v24.Reward, u9.Container.NextDay));
        u9.IfReportedThisTimeAround = false;
        u9.Container.ThisDay.CreateButton.CoinLabel.Text = v23.Price;
        u9.Container.ThisDay.CreateButton.Visible = not l__LocalProfile__11.DailyBuy.LastWasPurchased;
        u9.Container.ThisDay.Bought.Visible = l__LocalProfile__11.DailyBuy.LastWasPurchased;
        if not l__LocalProfile__11.DailyBuy.NextDayTime then
            u9.NextDayPending = true;
            u9.NextDayPendingChanged:Fire();
            u9.Container.NextDay.WaitTime.Visible = true;
            u9.Container.NextDay.WaitTime.TimeLabel.Text = "Buy To Start";
        end;
    end;
end;
function u9.SetupUI() --[[ Line: 146 ]]
    -- upvalues: u3 (copy), u9 (copy), u5 (copy), l__RunService__2 (copy), u1 (copy)
    local v25 = u3.NewButton(u9.Container.ThisDay.CreateButton);
    u3.NewButton(u9.Interface.TweenFrame.CloseButton).Activated:Connect(u9.Interface.Close);
    v25.Activated:Connect(function() --[[ Line: 151 ]]
        -- upvalues: u5 (ref), u9 (ref)
        u5:Fire();
        u9.ShouldPlayLine = true;
    end);
    u9.Interface.Opened:Connect(function() --[[ Line: 156 ]]
        -- upvalues: u9 (ref), l__RunService__2 (ref)
        if u9.UpdateConnection then
            u9.UpdateConnection:Disconnect();
        end;
        u9.UpdateConnection = l__RunService__2.Heartbeat:Connect(u9.Update);
    end);
    u9.Interface.Closed:Connect(function() --[[ Line: 160 ]]
        -- upvalues: u9 (ref), u1 (ref)
        if u9.ShouldPlayLine then
            u1.PlayLine(u9.Voicelines:Next());
            u9.ShouldPlayLine = false;
        end;
        if u9.UpdateConnection then
            u9.UpdateConnection:Disconnect();
        end;
    end);
end;
function u9.Setup() --[[ Line: 169 ]]
    -- upvalues: u9 (copy), u3 (copy), l__Mince__4 (copy), u2 (copy)
    u9.Interface = u3.Get("DailyBuy");
    u9.Container = u9.Interface.TweenFrame.Container;
    u9.Config = l__Mince__4.Config.DailyBuy;
    u9.ItemList = u9.Interface.TweenFrame.ItemList;
    u9.CreateItems();
    u9.SetupUI();
    u2.Upon("DailyBuy", u9.UpdatePage);
end;
return u9;
