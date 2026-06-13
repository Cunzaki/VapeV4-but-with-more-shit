-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.NPC.MerchNPC
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
l__Mince__5:Get("DailyBuy");
local u2 = l__Mince__5:Get("IndicatorHandler");
local u3 = l__Mince__5:Get("OnTapMerch");
local v4 = l__Mince__5.Component({
    Tag = "MerchNPC"
});
function v4.PlayEmote(u5, p6) --[[ Line: 25 ]]
    local u7 = u5.Animations[p6];
    if u5.CurrentEmote then
        u5.CurrentEmote:Stop();
    end;
    if u5.EmoteThread then
        task.cancel(u5.EmoteThread);
    end;
    u5.CurrentEmote = u7;
    u5.Animations.Idle:Stop();
    u7:Play();
    u5.EmoteThread = task.delay(u7.Length, function() --[[ Line: 41 ]]
        -- upvalues: u7 (copy), u5 (copy)
        u7:Stop();
        u5.CurrentEmote = nil;
        u5.Animations.Idle:Play();
    end);
    return u7.Length;
end;
function v4.Construct(u8) --[[ Line: 50 ]]
    -- upvalues: u1 (copy), l__Maid__4 (copy), u2 (copy), u3 (copy)
    if u1.IsEligibleToPurchaseCommerceProduct then
        local l__Interact__6 = u8.Instance:WaitForChild("Interact");
        local l__Character__7 = u8.Instance:WaitForChild("Character");
        local l__Indicator__8 = u8.Instance:WaitForChild("Indicator");
        local l__Animations__9 = u8.Instance:WaitForChild("Animations");
        local v9 = Instance.new("ProximityPrompt");
        v9:SetAttribute("Type", "Radial");
        v9:SetAttribute("SizeMultipler", 2);
        v9.ObjectText = "Buy Merch";
        v9.MaxActivationDistance = 5;
        v9.Style = Enum.ProximityPromptStyle.Custom;
        v9.Parent = l__Interact__6;
        v9.RequiresLineOfSight = false;
        u8.Events = {};
        u8.Maid = l__Maid__4.new();
        u8.ProximityPrompt = v9;
        u8.Character = l__Character__7;
        u8.Indicator = u2.CreateIndicator(l__Indicator__8);
        u8.Indicator:SetEnabled(true);
        u8.Animations = {};
        for _, v10 in l__Animations__9:GetChildren() do
            u8.Animations[v10.Name] = u8.Character.Humanoid:LoadAnimation(v10);
        end;
        u8.Animations.Idle:Play();
        v9.Triggered:Connect(function() --[[ Line: 85 ]]
            -- upvalues: u8 (copy), u3 (ref)
            u8.Indicator:SetEnabled(false);
            u3.Interface.Open();
        end);
    else
        u8.Instance:Destroy();
    end;
end;
return v4;
