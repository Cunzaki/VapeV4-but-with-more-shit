-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.NPC.DailybuyComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
game:GetService("StarterGui");
game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local _ = l__Players__1.LocalPlayer;
local l__Maid__3 = require(l__ReplicatedStorage__2.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__4:Get("DailyBuy");
local u2 = l__Mince__4:Get("IndicatorHandler");
local v3 = l__Mince__4.Component({
    Tag = "DailybuyNpc"
});
function v3.PlayEmote(u4, p5) --[[ Line: 22 ]]
    local u6 = u4.Animations[p5];
    if u4.CurrentEmote then
        u4.CurrentEmote:Stop();
    end;
    if u4.EmoteThread then
        task.cancel(u4.EmoteThread);
    end;
    u4.CurrentEmote = u6;
    u4.Animations.Idle:Stop();
    u6:Play();
    u4.EmoteThread = task.delay(u6.Length, function() --[[ Line: 38 ]]
        -- upvalues: u6 (copy), u4 (copy)
        u6:Stop();
        u4.CurrentEmote = nil;
        u4.Animations.Idle:Play();
    end);
    return u6.Length;
end;
function v3.Construct(u7) --[[ Line: 47 ]]
    -- upvalues: l__Maid__3 (copy), u2 (copy), u1 (copy)
    local l__Interact__5 = u7.Instance:WaitForChild("Interact");
    local l__Character__6 = u7.Instance:WaitForChild("Character");
    local l__Indicator__7 = u7.Instance:WaitForChild("Indicator");
    local l__Animations__8 = u7.Instance:WaitForChild("Animations");
    local v8 = Instance.new("ProximityPrompt");
    v8:SetAttribute("Type", "Radial");
    v8:SetAttribute("SizeMultipler", 2);
    v8.ObjectText = "Talk";
    v8.MaxActivationDistance = 5;
    v8.Style = Enum.ProximityPromptStyle.Custom;
    v8.Parent = l__Interact__5;
    v8.RequiresLineOfSight = false;
    u7.Events = {};
    u7.Maid = l__Maid__3.new();
    u7.ProximityPrompt = v8;
    u7.Character = l__Character__6;
    u7.Indicator = u2.CreateIndicator(l__Indicator__7);
    u7.Indicator:SetEnabled(false);
    u7.Animations = {};
    for _, v9 in l__Animations__8:GetChildren() do
        u7.Animations[v9.Name] = u7.Character.Humanoid:LoadAnimation(v9);
    end;
    u7.Animations.Idle:Play();
    v8.Triggered:Connect(function() --[[ Line: 77 ]]
        -- upvalues: u7 (copy), u1 (ref)
        u7.Indicator:SetEnabled(false);
        u1.Interface.Open();
    end);
    u1.NextDayPendingChanged:Connect(function() --[[ Line: 82 ]]
        -- upvalues: u7 (copy)
        u7.Indicator:SetEnabled(true);
        u7:PlayEmote("JumpWave");
    end);
    if u1.NextDayPending then
        u7.Indicator:SetEnabled(true);
        u7:PlayEmote("JumpWave");
    end;
end;
return v3;
