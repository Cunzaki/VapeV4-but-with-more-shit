-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.Trash
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__3.Modules.Mince);
local u1 = l__Mince__5:Get("Notices");
local u2 = l__Mince__5:Get("ConfirmPrompt");
local u3 = l__Mince__5:GetEvent("TrashDrink");
l__Mince__5:Get("SelectInteractor");
local v4 = l__Mince__5.Component({
    Tag = "Trash"
});
function v4.Construct(p5) --[[ Line: 22 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u1 (copy), l__CollectionService__2 (copy), l__UserInputService__1 (copy), u2 (copy), u3 (copy)
    local v6 = Instance.new("ProximityPrompt");
    v6:SetAttribute("Type", "Radial");
    v6.ObjectText = "Trash Item";
    v6.MaxActivationDistance = p5.Distance or 8;
    v6.Style = Enum.ProximityPromptStyle.Custom;
    v6.Parent = p5.Instance;
    v6.RequiresLineOfSight = false;
    v6.TriggerEnded:Connect(function() --[[ Line: 32 ]]
        -- upvalues: l__LocalPlayer__4 (ref), u1 (ref), l__CollectionService__2 (ref), l__UserInputService__1 (ref), u2 (ref), u3 (ref)
        local l__Character__6 = l__LocalPlayer__4.Character;
        if l__Character__6 then
            l__Character__6 = l__LocalPlayer__4.Character:FindFirstChildWhichIsA("Tool");
        end;
        if l__Character__6 then
            if l__CollectionService__2:HasTag(l__Character__6, "Drink") or l__CollectionService__2:HasTag(l__Character__6, "Special") then
                if l__UserInputService__1.TouchEnabled then
                    u2.Display("Are you sure you want to throw this away?", function() --[[ Line: 45 ]]
                        -- upvalues: u3 (ref)
                        u3:Fire();
                    end);
                else
                    u3:Fire();
                end;
            else
                u1.Error("This item cannot be used.");
            end;
        else
            u1.Error("You must have an item equipped to use this.");
        end;
    end);
    p5.ProximityPrompt = v6;
end;
function v4.Removing(p7) --[[ Line: 58 ]]
    p7.ProximityPrompt:Destroy();
end;
function v4.Setup() --[[ Line: 62 ]] end;
return v4;
