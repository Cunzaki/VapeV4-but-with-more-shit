-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Apartment.ApartmentEntrance
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("SelectInteractor");
local u2 = l__Mince__3:Get("InterfaceHandler");
local u3 = l__Mince__3.Component({
    Tag = "ApartmentEntrance",
    Tween1 = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
});
function u3.DoTween(p4, p5) --[[ Line: 16 ]]
    for _, v6 in p4.Tweens[p5] do
        v6:Play();
    end;
end;
function u3.Construct(p7) --[[ Line: 24 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy), u1 (copy)
    local l__Background__4 = p7.Instance:WaitForChild("Background");
    local l__RightDoor__5 = p7.Instance:WaitForChild("RightDoor");
    local l__LeftDoor__6 = p7.Instance:WaitForChild("LeftDoor");
    local v8 = l__RightDoor__5:GetPivot();
    local v9 = l__LeftDoor__6:GetPivot();
    p7.HoverName = "Enter Lofts!";
    p7.HitCollider = l__Background__4;
    p7.Target = p7.Instance;
    p7.Tweens = {};
    p7.Tweens.Open = { l__TweenService__2:Create(l__RightDoor__5, p7.Tween1, {
            Position = v8:ToWorldSpace(CFrame.new(0, 0, -2.11)).Position
        }), l__TweenService__2:Create(l__LeftDoor__6, p7.Tween1, {
            Position = v9:ToWorldSpace(CFrame.new(0, 0, 2.11)).Position
        }) };
    p7.Tweens.Close = { l__TweenService__2:Create(l__RightDoor__5, p7.Tween1, {
            Position = v8.Position
        }), l__TweenService__2:Create(l__LeftDoor__6, p7.Tween1, {
            Position = v9.Position
        }) };
    function p7.Interact(p10, p11) --[[ Line: 57 ]]
        -- upvalues: u3 (ref)
        u3.DoTween(p10, "Open");
        u3.Interface.Switch();
        if u3.Interface.IsActive then
            u3.Interface.Closed:Wait();
        end;
        u3.DoTween(p10, "Close");
        p11();
    end;
    u1.NewInteractionClass(p7);
end;
function u3.Setup() --[[ Line: 73 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u3.Interface = u2.Get("AnchorLofts");
end;
return u3;
