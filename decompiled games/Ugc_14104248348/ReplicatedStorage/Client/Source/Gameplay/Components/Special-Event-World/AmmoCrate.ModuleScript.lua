-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.AmmoCrate
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ShootableGun");
local u2 = l__Mince__2:Get("DrinkHandler");
l__Mince__2:Get("Notices");
local v3 = l__Mince__2.Component({
    Tag = "AmmoCrate"
});
function v3.Construct(p4) --[[ Line: 18 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local u5 = Instance.new("ProximityPrompt");
    u5:SetAttribute("Type", "Radial");
    u5.ObjectText = "Restock Ammo";
    u5.MaxActivationDistance = 10;
    u5.Style = Enum.ProximityPromptStyle.Custom;
    u5.Parent = p4.Instance.PrimaryPart;
    u5.RequiresLineOfSight = false;
    u5.TriggerEnded:Connect(function() --[[ Line: 28 ]]
        -- upvalues: u5 (copy), u2 (ref), u1 (ref)
        u5.Enabled = false;
        u2.DoProcessingText("Reloading....", 4, "ReloadingGeneric");
        u1.RestockAmmo();
        u5.Enabled = true;
    end);
    p4.ProximityPrompt = u5;
end;
function v3.Removing(p6) --[[ Line: 39 ]]
    p6.ProximityPrompt:Destroy();
end;
function v3.Setup() --[[ Line: 43 ]] end;
return v3;
