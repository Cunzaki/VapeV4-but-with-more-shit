-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.DailyCoinBonusReward
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Queue);
local l__Unify__3 = require(l__ReplicatedStorage__1.Modules.Unify);
l__Mince__2:Get("ItemFrame");
l__Mince__2:Get("UserProfile");
local u1 = l__Mince__2:Get("InterfaceHandler");
local _ = l__Mince__2.Config.CoinBalance.Objects;
local u2 = {
    DailyLoginTrack = 0,
    TimeSinceLastLogin = 0,
    CoinRewardBudgetExpended = 0,
    JoinedOn = 0,
    SessionLength = 0,
    __IsAsyncSetup = true,
    StatObjects = {}
};
function u2.Initt(_) --[[ Line: 26 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.NewButton(u2.MainFrame.CloseButton);
    u2.UI.Open();
    v3.Activated:Connect(function() --[[ Line: 30 ]]
        -- upvalues: u2 (ref)
        u2.UI.Close();
    end);
    u2.UI.Closed:Wait();
end;
function u2.Update(_) --[[ Line: 36 ]]
    -- upvalues: u2 (copy), l__Mince__2 (copy)
    local v4 = u2.Container:FindFirstChild("Multi");
    warn(u2.DailyLoginTrack);
    v4.Frame.CoinLabel.Text = "x" .. math.round(u2.DailyLoginTrack * l__Mince__2.Config.CoinBalance.DailyLoginMultipler * 100) / 100 + 1;
    local v5 = u2.Container:FindFirstChild("CoinsPerHour");
    local v6 = u2.CalculateReward(u2, u2.SessionLength);
    v5.Frame.CoinLabel.Text = math.round(v6 * 20 * 100) / 100;
end;
function u2.GetData(_, p7) --[[ Line: 50 ]]
    -- upvalues: u2 (copy)
    return u2.StatObjects[p7];
end;
function u2.UpdateTime(_) --[[ Line: 54 ]]
    -- upvalues: u2 (copy), l__Mince__2 (copy), l__Unify__3 (copy)
    if u2.TimeSinceLastLogin then
        local l__NextDayInLabel__4 = u2.MainFrame.NextDayInLabel;
        local _ = l__Mince__2.Config.CoinBalance.TimeBetweenLogins;
        local v8 = l__Unify__3.ParseTimeString(l__Mince__2.Config.CoinBalance.TimeBetweenLogins);
        if not u2.TimeSinceLastLogin then
            return;
        end;
        local v9 = v8 - l__Unify__3.GetStandardTimeFrom(u2.TimeSinceLastLogin);
        local v10 = math.max(0, v9);
        l__NextDayInLabel__4.Text = `Next Bonus in {l__Unify__3.AbbreviatedTime(v10)}!`;
    end;
end;
function u2.DeductCoinsFromSession(p11, p12) --[[ Line: 71 ]]
    -- upvalues: l__Mince__2 (copy)
    if p11.CoinRewardBudgetExpended >= l__Mince__2.Config.CoinBalance.MaxCoinsPerSession then
        return 0;
    end;
    local v13 = l__Mince__2.Config.CoinBalance.MaxCoinsPerSession - p11.CoinRewardBudgetExpended;
    local v14 = p11.CoinRewardBudgetExpended + p12;
    p11.CoinRewardBudgetExpended = p11.CoinRewardBudgetExpended + p12;
    local v15;
    if v13 <= 0 then
        v15 = 0;
    elseif l__Mince__2.Config.CoinBalance.MaxCoinsPerSession < v14 then
        v15 = math.max(p12, v13);
    else
        v15 = p12;
    end;
    return math.clamp(v15, 0, p12);
end;
function u2.CalculateLoginMultiplier(p16) --[[ Line: 91 ]]
    -- upvalues: l__Mince__2 (copy)
    local l__DailyLoginMultipler__5 = l__Mince__2.Config.CoinBalance.DailyLoginMultipler;
    local l__DailyLoginMultiplerMax__6 = l__Mince__2.Config.CoinBalance.DailyLoginMultiplerMax;
    if l__Mince__2.Config.CoinBalance.MaxDailyLogins <= p16.DailyLoginTrack then
        return l__DailyLoginMultiplerMax__6;
    else
        return p16.DailyLoginTrack * l__DailyLoginMultipler__5;
    end;
end;
function u2.CalculateReward(p17, p18) --[[ Line: 105 ]]
    -- upvalues: u2 (copy), l__Mince__2 (copy)
    local v19 = u2.DeductCoinsFromSession(p17, p18 * l__Mince__2.Config.CoinBalance.CoinsPerSecond);
    if v19 == 0 then
        return p18 * l__Mince__2.Config.CoinBalance.CoinsPerSecondWhenSessionEnded + p18 * l__Mince__2.Config.CoinBalance.CoinsPerSecondWhenSessionEnded * (u2.CalculateLoginMultiplier(p17) or 0);
    else
        return v19 <= 0 and 0 or v19 + v19 * (u2.CalculateLoginMultiplier(p17) or 0);
    end;
end;
function u2.Setup(_) --[[ Line: 120 ]] end;
return u2;
