-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.GlowingSwayingLantern
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
    Tag = "GlowingSwayingLantern"
});
function v1.Construct(p2) --[[ Line: 22 ]]
    -- upvalues: l__TweenService__3 (copy)
    task.wait(math.random(1, 4));
    l__TweenService__3:Create(p2.Instance["Sphere.001"], TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Color = Color3.fromHex("#75291f")
    }):Play();
end;
function v1.Removing(_) --[[ Line: 30 ]] end;
return v1;
