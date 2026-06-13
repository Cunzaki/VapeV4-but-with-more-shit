-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.PickupTrickOrTreatPotion
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__2:GetEvent("PickupDrink");
l__Mince__2:Get("SoundHandler");
local u2 = l__Mince__2:Get("DrinkHandler");
local u3 = l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("PlacementHandler");
local v4 = l__Mince__2.Component({
    Tag = "PickupTrickOrTreatPotion",
    Bounce = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
});
function v4.Removing(p5) --[[ Line: 21 ]]
    -- upvalues: u3 (copy)
    u3.CollapseClass(p5);
end;
function v4.Construct(p6) --[[ Line: 25 ]]
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    p6.Instance.Name = "Familiarizer";
    p6.HitCollider = p6.Instance:FindFirstChild("Collider") or p6.Instance:WaitForChild("Handle");
    p6.HoverName = p6.Instance.Name;
    p6.Target = p6.Instance;
    for _, v7 in p6.Instance:GetChildren() do
        if v7:IsA("BasePart") and v7 ~= p6.HitCollider then
            v7.CanQuery = false;
        end;
    end;
    function p6.OnHover(p8) --[[ Line: 40 ]]
        -- upvalues: u2 (ref)
        local v9 = u2.GetEquippedTool();
        return (v9 and p8.Instance:GetAttribute("UnblockPlacements") or v9 and v9:GetAttribute("PreventPickupsWhileEquipped")) and "Unselect" or true;
    end;
    function p6.Interact(p10, p11) --[[ Line: 49 ]]
        -- upvalues: u1 (ref)
        u1:Fire(p10.Instance);
        p11();
    end;
    u3.NewInteractionClass(p6);
end;
return v4;
