-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Apartment.Laptop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("LoftShop");
local u2 = l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("InterfaceHandler");
local v3 = l__Mince__2.Component({
    Tag = "Laptop"
});
function v3.Construct(p4) --[[ Line: 16 ]]
    -- upvalues: u1 (copy), u2 (copy)
    p4.HoverName = "Loft Shop";
    p4.HitCollider = p4.Instance:WaitForChild("Collider");
    p4.Target = p4.Instance;
    function p4.Interact(_, p5) --[[ Line: 21 ]]
        -- upvalues: u1 (ref)
        u1.Interface.Switch();
        if u1.Interface.IsActive then
            u1.Interface.Closed:Wait();
        end;
        p5();
    end;
    u2.NewInteractionClass(p4);
end;
return v3;
