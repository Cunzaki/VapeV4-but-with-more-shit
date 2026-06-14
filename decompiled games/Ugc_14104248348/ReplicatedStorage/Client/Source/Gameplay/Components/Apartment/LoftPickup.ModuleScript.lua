-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Apartment.LoftPickup
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Backpack);
l__Mince__2:Get("LoftShop");
local u1 = l__Mince__2:Get("RemoveHammer");
local u2 = l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("InterfaceHandler");
local u3 = l__Mince__2:GetEvent("LoftShop"):Extend("CollectItem");
local v4 = l__Mince__2.Component({
    Tag = "LoftPickup"
});
function v4.Construct(u5) --[[ Line: 21 ]]
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    u5.HoverName = "Remove Loft Item";
    u5.HitCollider = u5.Instance:WaitForChild("Collider");
    u5.Target = u5.Instance;
    u5.MaxCharacterDistance = 100;
    function u5.OnHover() --[[ Line: 27 ]]
        -- upvalues: u1 (ref), u5 (copy)
        local v6 = u1.GetActiveTool();
        if not v6 then
            return "Unselect";
        end;
        u5.LastToolExistance = v6;
        return true;
    end;
    function u5.Interact(_, p7) --[[ Line: 38 ]]
        -- upvalues: u5 (copy), u3 (ref)
        if u5.LastToolExistance then
            u5.LastToolExistance.Animations.Action:Play();
        end;
        warn("remove loft item", u5.Instance);
        u3:Fire(u5.Instance);
        p7();
    end;
    u2.NewInteractionClass(u5);
end;
return v4;
