-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.ActivityReward
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Numerics__3 = require(l__ReplicatedStorage__1.Modules.Numerics);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = {};
function u2.DipIn() --[[ Line: 19 ]]
    -- upvalues: u2 (copy), l__Numerics__3 (copy), l__Mince__2 (copy)
    u2.Interface.TweenFrame.ItemFrame.Coins.CoinLabel.Text = l__Numerics__3.WithCommas((math.round(l__Mince__2.Config.LocalProfile.CoinsUpdateGainedTotal)));
    u2.Trigger();
    u2.Interface.Closed:Wait();
end;
function u2.Setup() --[[ Line: 25 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2.Interface = u1.Get("ActivityReward");
    u2.Trigger = u2.Interface.Trigger;
    u1.NewButton(u2.Interface.TweenFrame.DismissButton).Activated:Connect(function() --[[ Line: 29 ]]
        -- upvalues: u2 (ref)
        u2.Interface.Close();
    end);
end;
return u2;
