-- Decompiled from: ReplicatedStorage.Client.Source.SyncHoliday
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("InterfaceHandler");
local v2 = l__Mince__2.Component({
    Tag = "HolidayIcon"
});
local v3 = l__Mince__2.Component({
    Tag = "HolidayGradient"
});
local v4 = {};
function v2.Construct(p5) --[[ Line: 22 ]]
    -- upvalues: l__Mince__2 (copy)
    p5.Instance.Image = l__Mince__2.Config.HolidayConfigure.EVENT_CURRENCY_ICON;
end;
function v3.Construct(p6) --[[ Line: 26 ]]
    -- upvalues: l__Mince__2 (copy)
    p6.Instance.Color = l__Mince__2.Config.HolidayConfigure.EVENT_CURRENCY_COLORSEQUENCE;
end;
function v4.Setup(_) --[[ Line: 30 ]]
    -- upvalues: l__Mince__2 (copy), l__ReplicatedStorage__1 (copy), u1 (copy)
    local l__HolidayConfigure__3 = l__Mince__2.Config.HolidayConfigure;
    l__ReplicatedStorage__1.Assets.Interface.ItemFrame.Holiday.ImageLabel.Image = l__HolidayConfigure__3.EVENT_CURRENCY_ICON;
    l__ReplicatedStorage__1.Assets.Interface.ItemFrame.Holiday.AmountLabel.UIGradient.Color = l__HolidayConfigure__3.EVENT_CURRENCY_COLORSEQUENCE;
    l__ReplicatedStorage__1.Assets.Misc.Drop.BillboardGui.ImageLabel.Image = l__HolidayConfigure__3.EVENT_CURRENCY_ICON;
    local v7 = u1.GetScreenGui("MainPriority");
    v7.Holiday.Container.ImageLabel.Image = l__HolidayConfigure__3.EVENT_CURRENCY_ICON;
    v7.Holiday.Container.CoinLabel.UIGradient.Color = l__HolidayConfigure__3.EVENT_CURRENCY_COLORSEQUENCE;
    v7.Holiday.Add.UIGradient.Color = l__HolidayConfigure__3.EVENT_CURRENCY_COLORSEQUENCE;
    v7.Holiday.Visible = l__HolidayConfigure__3.EVENT_CURRENCY_ENABLED;
    local l__HolidayConfigure__4 = l__Mince__2.Config.HolidayConfigure;
    if l__HolidayConfigure__4.USE_ALT_LOOTCONFIRM then
        l__HolidayConfigure__4 = l__HolidayConfigure__4.ALT_CURRENCY;
    end;
    local v8 = u1.GetScreenGui("LootConfirm");
    v8.Main.Options.BuyOption1.ImageLabel.Image = l__HolidayConfigure__4.EVENT_CURRENCY_ICON;
    v8.Main.Options.BuyOption1.CoinLabel.UIGradient.Color = l__HolidayConfigure__4.EVENT_CURRENCY_COLORSEQUENCE;
    local l__HolidayConfigure__5 = l__Mince__2.Config.HolidayConfigure;
    u1.GetScreenGui("DailyRewards").Main.Title.TextLabel.Text = l__HolidayConfigure__5.DAILY_REWARD_NAME;
    local v9 = u1.GetScreenGui("Shop");
    v9.Main.Container.EventTitle.Visible = l__HolidayConfigure__5.EVENT_CONVERT_ENABLED;
    v9.Main.Container.EventSection.Visible = l__HolidayConfigure__5.EVENT_CONVERT_ENABLED;
end;
return v4;
