-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine.Machines.Pan
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
l__Mince__2:Get("Notices");
l__Mince__2:GetEvent("UseMachine");
return {
    Tween = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
    Created = function(_) --[[ Name: Created, Line 19 ]] end,
    Destroying = function(_) --[[ Name: Destroying, Line 67 ]] end
};
