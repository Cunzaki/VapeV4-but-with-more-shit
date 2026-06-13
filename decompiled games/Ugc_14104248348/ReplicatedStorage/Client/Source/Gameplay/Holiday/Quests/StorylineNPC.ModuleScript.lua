-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.Quests.StorylineNPC
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
local l__Unify__5 = require(l__ReplicatedStorage__2.Modules.Unify);
local l__Bucket__6 = require(l__ReplicatedStorage__2.Modules.Bucket);
local u1 = l__Mince__4:Get("Voicelines");
l__Mince__4:Get("BuyLootbox");
local u2 = l__Mince__4:Get("UserProfile");
local u3 = l__Mince__4:Get("ConfirmPrompt");
local u4 = l__Mince__4:Get("QuestsHandler");
local u5 = l__Mince__4:Get("IndicatorHandler");
local v6 = l__Mince__4.Component({
    Tag = "StorylineNPC"
});
function v6.PendingAction(p7) --[[ Line: 28 ]]
    p7.Indicator:SetEnabled(true);
    p7.Animations.Wave:Play();
end;
function v6.ActionEnded(p8) --[[ Line: 33 ]]
    p8.Indicator:SetEnabled(false);
    p8.Animations.Wave:Stop();
end;
function v6.LoadQuestVoicelineBuckets(p9) --[[ Line: 38 ]]
    -- upvalues: l__Bucket__6 (copy)
    p9.VoicelineBuckets = {};
    if p9.PendingQuest then
        for v10, v11 in p9.PendingQuest.Voicelines do
            p9.VoicelineBuckets[v10] = l__Bucket__6.new(v11);
        end;
    end;
    for v12, v13 in p9.StorylineConfig.DefaultVoicelines or {} do
        p9.VoicelineBuckets[v12] = l__Bucket__6.new(v13);
    end;
end;
function v6.PlayLine(p14, p15, p16) --[[ Line: 52 ]]
    -- upvalues: u1 (copy)
    if p14.VoicelineBuckets then
        local v17 = p14.VoicelineBuckets[p15];
        if v17 then
            if p14.LastVoicelineSettings then
                p14.LastVoicelineSettings:Stop();
                task.wait();
            end;
            local v18 = u1.GetVoicelineSettings(v17:Next());
            v18:Play(p14.HumanoidRootPart);
            v18.Volume = 4;
            p14.LastVoicelineSettings = v18;
            if p16 then
                v18.Stopped:Wait();
            end;
        else
            warn((`There is no VoicelineBucket by the name of  '{p15}'!`));
        end;
    else
        warn("There is no current VoicelineBucket!!!!!");
    end;
end;
function v6.CheckForNextQuest(p19) --[[ Line: 79 ]]
    -- upvalues: u4 (copy)
    warn("Checking For Quest!");
    local v20 = u4.GetCurrentStorylineQuest(p19.Storyline);
    if v20 then
        p19:PendingAction();
        p19.Mode = "WaitingForQuestStart";
        p19.PendingQuest = v20;
        p19:LoadQuestVoicelineBuckets();
    else
        warn(v20, "--------->");
        p19:ActionEnded();
        p19.PendingQuest = nil;
        p19.Mode = "WaitingForQuestStart";
    end;
end;
function v6.WhenInteract(u21) --[[ Line: 97 ]]
    -- upvalues: l__Unify__5 (copy), u3 (copy), u4 (copy)
    if u21.ProximityPrompt.Enabled then
        if u21.Mode == "WaitingForQuestStart" then
            if u21.PendingQuest then
                if u21.IsCurrentStorylineReady then
                    u21:ActionEnded();
                    u21.ProximityPrompt.Enabled = false;
                    u21:PlayLine("IntroLines", true);
                    u3.Display("Would you like to start this quest?", function() --[[ Line: 121 ]]
                        -- upvalues: u21 (copy), u4 (ref)
                        u21:PlayLine("ResultYes", true);
                        u4.StartStoryline(u21.Storyline, u21);
                        u21.Mode = "QuestActive";
                        u21.ProximityPrompt.Enabled = true;
                    end, function() --[[ Line: 127 ]]
                        -- upvalues: u21 (copy)
                        u21:PlayLine("ResultNo", true);
                        u21.ProximityPrompt.Enabled = true;
                        u21:PendingAction();
                    end);
                else
                    warn("Storyline Is Not Ready");
                    u21.IsCurrentStorylineReady = l__Unify__5.GetServerTime() > u21.StoryLineNextUnlock;
                    u21.ProximityPrompt.Enabled = false;
                    u21:PlayLine("Busy", true);
                    u21.ProximityPrompt.Enabled = true;
                end;
            else
                warn("NO pending quest!");
                u21.ProximityPrompt.Enabled = false;
                u21:PlayLine("BusyDefault", true);
                u21.ProximityPrompt.Enabled = true;
            end;
        else
            if u21.Mode == "QuestActive" then
                u4.Interact();
            end;
        end;
    end;
end;
function v6.Construct(u22) --[[ Line: 137 ]]
    -- upvalues: u2 (copy), l__Maid__3 (copy), u5 (copy), l__Mince__4 (copy), l__Unify__5 (copy), u4 (copy)
    assert(u22.Storyline, "A storyline is required for a StorylineNPC!");
    local l__Interact__7 = u22.Instance:WaitForChild("Interact");
    local l__Character__8 = u22.Instance:WaitForChild("Character");
    local l__Indicator__9 = u22.Instance:WaitForChild("Indicator");
    local l__Animations__10 = u22.Instance:WaitForChild("Animations");
    local v23 = Instance.new("ProximityPrompt");
    v23:SetAttribute("Type", "Radial");
    v23:SetAttribute("SizeMultipler", 1);
    v23.ObjectText = "Talk";
    v23.MaxActivationDistance = 5;
    v23.Style = Enum.ProximityPromptStyle.Custom;
    v23.Parent = l__Interact__7;
    v23.RequiresLineOfSight = false;
    v23.Triggered:Connect(function() --[[ Line: 154 ]]
        -- upvalues: u22 (copy)
        u22:WhenInteract();
    end);
    u2:WaitUntilLoaded();
    u22.Maid = l__Maid__3.new();
    u22.ProximityPrompt = v23;
    u22.Character = l__Character__8;
    u22.HumanoidRootPart = l__Character__8:WaitForChild("HumanoidRootPart");
    u22.Indicator = u5.CreateIndicator(l__Indicator__9);
    u22.Indicator:SetEnabled(false);
    u22.StorylineConfig = l__Mince__4.Config.Quests[u22.Storyline];
    u22.Animations = {};
    for _, v24 in l__Animations__10:GetChildren() do
        if v24:IsA("Animation") then
            u22.Animations[v24.Name] = u22.Character.Humanoid:LoadAnimation(v24);
        end;
    end;
    u22.Animations.Idle:Play();
    u2.Upon("Quests", function(p25) --[[ Line: 180 ]]
        -- upvalues: u22 (copy), l__Unify__5 (ref)
        warn(p25, u22.Storyline);
        u22.StoryLineNextUnlock = p25.StorylineNextUnlocks[u22.Storyline];
        u22.IsCurrentStorylineReady = l__Unify__5.GetServerTime() > u22.StoryLineNextUnlock;
    end);
    u4.QuestCompleted:Connect(function(p26) --[[ Line: 186 ]]
        -- upvalues: u22 (copy)
        if p26 == u22.PendingQuest then
            u22:PlayLine("Complete");
        end;
    end);
    u4.QuestEnded:Connect(function() --[[ Line: 192 ]]
        -- upvalues: u22 (copy)
        if u22.Mode == "QuestActive" then
            u22:CheckForNextQuest();
        end;
    end);
    u22:LoadQuestVoicelineBuckets();
    u22:CheckForNextQuest();
end;
return v6;
