-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.CollectPickup
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local l__Backpack__2 = require(l__ReplicatedStorage__1.Modules.Backpack);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__4 = require(l__ReplicatedStorage__1.Modules.Signal);
local v1 = l__Mince__3.Component({
    Tag = "CollectPickup",
    CreationParents = { game.Workspace }
});
function v1.Construct(u2) --[[ Line: 17 ]]
    -- upvalues: l__Backpack__2 (copy), l__Signal__4 (copy)
    local l__Tool__5 = u2.Instance:WaitForChild("Tool");
    local u3 = u2.Instance:FindFirstChildWhichIsA("BasePart", true);
    local u4 = Instance.new("ProximityPrompt");
    u4:SetAttribute("Type", "Radial");
    u4.ObjectText = u2.ObjectText or "Pickup Box";
    u4.Style = Enum.ProximityPromptStyle.Custom;
    u4.Parent = u3;
    u4.Triggered:Connect(function() --[[ Line: 26 ]]
        -- upvalues: u3 (copy), u2 (copy), u4 (copy), l__Tool__5 (copy), l__Backpack__2 (ref)
        if u3.Anchored then
            u3.Anchored = false;
            u2.PickedUp:Fire();
            u4.Enabled = false;
            l__Tool__5.Parent = l__Backpack__2.BackpackInstance;
            l__Backpack__2.EquipRawTool(l__Tool__5);
        end;
    end);
    u2.Tool = l__Tool__5;
    u2.PickedUp = l__Signal__4.new();
end;
return v1;
