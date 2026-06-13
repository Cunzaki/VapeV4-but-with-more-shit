-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.FlashingWaterLight
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__TweenService__3 = game:GetService("TweenService");
local _ = l__Players__2.LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__4:Get("ShootableGun");
l__Mince__4:Get("DrinkHandler");
l__Mince__4:Get("Notices");
local v1 = l__Mince__4.Component({
    Tag = "FlashingWaterLight"
});
function v1.Construct(p2) --[[ Line: 22 ]]
    -- upvalues: l__TweenService__3 (copy)
    l__TweenService__3:Create(p2.Instance, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Color = Color3.fromHex("#ff5943")
    }):Play();
end;
function v1.Removing(_) --[[ Line: 28 ]] end;
return v1;
