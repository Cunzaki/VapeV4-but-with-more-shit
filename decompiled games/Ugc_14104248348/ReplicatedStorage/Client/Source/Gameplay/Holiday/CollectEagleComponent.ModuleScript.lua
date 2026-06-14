-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.CollectEagleComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__3:Get("InterfaceHandler");
l__Mince__3:Get("LanternDecorator");
l__Mince__3:Get("Notices");
local v1 = l__Mince__3.Component({
    Tag = "CollectEagle"
});
function v1.Construct(p2) --[[ Line: 16 ]]
    -- upvalues: l__TweenService__2 (copy)
    l__TweenService__2:Create(p2.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Orientation = p2.Instance.Orientation + Vector3.new(0, 360, 0)
    }):Play();
end;
return v1;
