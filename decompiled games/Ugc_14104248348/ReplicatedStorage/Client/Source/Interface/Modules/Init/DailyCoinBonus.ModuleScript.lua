-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.DailyCoinBonus
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__4 = require(l__ReplicatedStorage__1.Modules.Unify);
local u1 = l__Mince__3:Get("UserProfile");
local u2 = l__Mince__3:Get("InterfaceHandler");
local u3 = {
    Days = {}
};
function u3.OpenAndWait(_) --[[ Line: 15 ]]
    -- upvalues: u3 (copy)
    u3.Interface.Open();
    u3.Interface.Closed:Wait();
end;
function u3.Update(_) --[[ Line: 20 ]]
    -- upvalues: l__Mince__3 (copy), l__Unify__4 (copy), u3 (copy)
    if l__Mince__3.Config.LocalProfile.TimeSinceLastLogin then
        local v4 = l__Unify__4.GetStandardTimeFrom(l__Mince__3.Config.LocalProfile.TimeSinceLastLogin);
        local v5 = l__Unify__4.ParseTimeString(l__Mince__3.Config.CoinBalance.TimeBetweenLogins) - v4;
        local v6 = math.max(0, v5);
        u3.MainFrame.NextDayInLabel.Text = l__Unify__4.AbbreviatedTime(v6);
    end;
end;
function u3.UpdateDaysBasedOnMultiplier(_, p7) --[[ Line: 31 ]]
    -- upvalues: u3 (copy), l__Mince__3 (copy)
    for v8, v9 in u3.MultiplierItems do
        local v10 = v8 - 1 + p7;
        v9.Multiplier.TextLabel.Text = `Day {v10 + 1}`;
        v9.Multiplier.Multiplier.Text = `{1 + math.round(v10 * l__Mince__3.Config.CoinBalance.DailyLoginMultipler * 100) / 100}x`;
    end;
    u3.StatContainer.CoinsPerHour.Coins.CoinLabel.Text = math.round(l__Mince__3.Config.CoinBalance.CoinsPerSecond * 3600 * (1 + p7 * l__Mince__3.Config.CoinBalance.DailyLoginMultipler) * 100) / 100;
end;
function u3.SetupGui(_) --[[ Line: 45 ]]
    -- upvalues: u2 (copy), u3 (copy)
    u2.NewButton(u3.MainFrame.CloseButton).Activated:Connect(function() --[[ Line: 47 ]]
        -- upvalues: u3 (ref)
        u3.Interface.Close();
    end);
end;
function u3.Setup(_) --[[ Line: 52 ]]
    -- upvalues: u3 (copy), u2 (copy), u1 (copy), l__RunService__2 (copy)
    u3.Interface = u2.Get("DailyCoinBonus");
    u3.MainFrame = u3.Interface.TweenFrame;
    u3.Container = u3.MainFrame.DayContainer;
    u3.StatContainer = u3.MainFrame.StatsContainer;
    u3.MultiplierItems = {
        u3.Container.DayContainer,
        u3.Container.DayContainer2,
        u3.Container.DayContainer3,
        u3.Container.DayContainer4
    };
    u3:SetupGui();
    u1.Upon("DailyLoginTrack", function(p11) --[[ Line: 67 ]]
        -- upvalues: u3 (ref)
        u3:UpdateDaysBasedOnMultiplier(p11);
    end);
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 71 ]]
        -- upvalues: u3 (ref)
        u3:Update();
    end);
end;
return u3;
