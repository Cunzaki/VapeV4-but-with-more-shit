-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.NPC.LootboxReminderNPC
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
game:GetService("StarterGui");
game:GetService("TweenService");
local l__PolicyService__2 = game:GetService("PolicyService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local u1 = l__PolicyService__2:GetPolicyInfoForPlayerAsync(l__Players__1.LocalPlayer);
local l__Maid__4 = require(l__ReplicatedStorage__3.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__Bucket__6 = require(l__ReplicatedStorage__3.Modules.Bucket);
local u2 = l__Mince__5:Get("BuyLootbox");
l__Mince__5:Get("Target");
local u3 = l__Mince__5:Get("Voicelines");
local u4 = l__Mince__5:Get("IndicatorHandler");
local u5 = l__Mince__5.Component({
    Tag = "LootboxReminderNPC",
    OpenLines = l__Bucket__6.new({ "LBNPCGet1", "LBNPCGet2" })
});
function u5.Construct(u6) --[[ Line: 33 ]]
    -- upvalues: l__Maid__4 (copy), u4 (copy), u2 (copy), u1 (copy), u3 (copy), u5 (copy)
    local l__Interact__7 = u6.Instance:WaitForChild("Interact");
    local l__Character__8 = u6.Instance:WaitForChild("Character");
    local l__Indicator__9 = u6.Instance:WaitForChild("Indicator");
    local l__Animations__10 = u6.Instance:WaitForChild("Animations");
    local v7 = Instance.new("ProximityPrompt");
    v7:SetAttribute("Type", "Radial");
    v7:SetAttribute("SizeMultipler", 2);
    v7.ObjectText = "Talk";
    v7.MaxActivationDistance = 5;
    v7.Style = Enum.ProximityPromptStyle.Custom;
    v7.Parent = l__Interact__7;
    v7.RequiresLineOfSight = false;
    u6.Events = {};
    u6.Maid = l__Maid__4.new();
    u6.ProximityPrompt = v7;
    u6.Character = l__Character__8;
    u6.HumanoidRootPart = l__Character__8:WaitForChild("HumanoidRootPart");
    u6.Indicator = u4.CreateIndicator(l__Indicator__9);
    u6.Indicator:SetEnabled(false);
    u6.Animations = {};
    for _, v8 in l__Animations__10:GetChildren() do
        if v8:IsA("Animation") then
            u6.Animations[v8.Name] = u6.Character.Humanoid:LoadAnimation(v8);
        end;
    end;
    u6.Animations.Idle:Play();
    v7.Triggered:Connect(function() --[[ Line: 67 ]]
        -- upvalues: u2 (ref), u1 (ref), u3 (ref), u5 (ref), u6 (copy)
        if u2.Interface.IsActive then
        else
            if u1.ArePaidRandomItemsRestricted then
                u3.PlayLine("LBNPCEUBlockage");
            else
                u3.PlayLine(u5.OpenLines:Next());
            end;
            u6.Indicator:SetEnabled(false);
            u6.Animations.Wave:Stop();
            u2.Interface:Open();
        end;
    end);
    u6.Indicator:SetEnabled(true);
    u6.Animations.Wave:Play();
end;
return u5;
