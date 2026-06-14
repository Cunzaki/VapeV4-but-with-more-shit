-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.LeeComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
game:GetService("StarterGui");
game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Debris__4 = game:GetService("Debris");
local _ = l__Players__1.LocalPlayer;
local l__Maid__5 = require(l__ReplicatedStorage__3.Modules.Maid);
local l__Mince__6 = require(l__ReplicatedStorage__3.Modules.Mince);
local u1 = l__Mince__6:Get("Voicelines");
l__Mince__6:Get("NotifPrompt");
l__Mince__6:Get("ConfirmPrompt");
local u2 = l__Mince__6:Get("Notices");
l__Mince__6:Get("OpeningHandler");
local u3 = l__Mince__6:Get("IndicatorHandler");
l__Mince__6:Get("SelectInteractor");
local u4 = l__Mince__6:Get("ObjectiveHandler");
local u5 = Random.new(os.clock());
local u6 = l__Mince__6:GetEvent("FinishEventQuest");
local u7 = l__Mince__6:GetEvent("ExpireIntent");
local u8 = l__Mince__6.Component({
    Tag = "LeeNpc",
    Determination = "Cooldown",
    AnnVoicelines = {
        FirstInteract = { "ANN24FirstInteract" },
        FirstClaim = { "ANN24FirstCapture" },
        ClaimCoins = {
            "ANN24Open1",
            "ANN24Open2",
            "ANN24Open3",
            "ANN24Open4"
        },
        Cooldown = { "ANN24Cooldown1", "ANN24Cooldown2", "ANN24Cooldown3" },
        Restock = { "ANN24Restock1", "ANN24Restock2", "ANN24Restock3" }
    },
    LineBuckets = {},
    CurrentBoxes = {}
});
function u8.HandleBox(u9, u10) --[[ Line: 46 ]]
    -- upvalues: l__Debris__4 (copy)
    u10.Box.ProximityPrompt.Triggered:Once(function() --[[ Line: 47 ]]
        -- upvalues: u10 (copy), u9 (copy), l__Debris__4 (ref)
        for _, v11 in u10:GetChildren() do
            if v11:IsA("BasePart") then
                v11.Transparency = 1;
            end;
        end;
        for _, v12 in u10.Box.Attachment:GetChildren() do
            v12:Emit(v12:GetAttribute("EmitCount"));
        end;
        u10.Box.ProximityPrompt.Enabled = false;
        u10.Box.Open:Play();
        table.remove(u9.CurrentBoxes, table.find(u9.CurrentBoxes, u10));
        l__Debris__4:AddItem(u10, 5);
        u9.Objective:Next();
        if #u9.CurrentBoxes < 1 then
            u9.Determination = "Claim";
            u9.Indicator:SetEnabled(true);
        end;
    end);
end;
function u8.PlaceBoxes(p13) --[[ Line: 74 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), u5 (copy), u4 (copy)
    if p13.Determination == "Restock" then
        if #p13.CurrentBoxes > 0 then
        else
            local v14 = l__ReplicatedStorage__3.Assets.PresentSpawns:GetChildren();
            u5:Shuffle(v14);
            p13.Objective = u4.StartObjectives({
                {
                    Type = "Count",
                    Format = "Collect 3 boxes (%s/%s)",
                    Goal = 3
                }
            }).Tasks[1];
            for _ = 1, 3 do
                local v15 = u5:NextInteger(1, #v14);
                local v16 = v14[v15]:GetPivot();
                local v17 = l__ReplicatedStorage__3.Assets.Spawnables.ClaimableBox:Clone();
                v17.Parent = game.Workspace;
                v17:PivotTo(v16);
                p13:HandleBox(v17);
                table.insert(p13.CurrentBoxes, v17);
                table.remove(v14, v15);
            end;
        end;
    end;
end;
function u8.PlayVoiceline(_, p18) --[[ Line: 106 ]]
    -- upvalues: u8 (copy), u5 (copy), u1 (copy)
    local v19 = u8.AnnVoicelines[p18];
    local v20 = u8.LineBuckets[p18];
    if not v20 or #v20 < 1 then
        u8.LineBuckets[p18] = table.clone(v19);
        u5:Shuffle(u8.LineBuckets[p18]);
        v20 = u8.LineBuckets[p18];
    end;
    local v21 = u5:NextInteger(1, #v20);
    local v22 = u1.GetVoicelineSettings(v20[v21]);
    v22:Play();
    table.remove(u8.LineBuckets[p18], v21);
    repeat
        task.wait();
    until v22.Sound.TimeLength ~= 0;
    task.wait(v22.Sound.TimeLength);
end;
function u8.PlayEmote(u23, p24) --[[ Line: 129 ]]
    local u25 = u23.Animations[p24];
    if u23.CurrentEmote then
        u23.CurrentEmote:Stop();
    end;
    if u23.EmoteThread then
        task.cancel(u23.EmoteThread);
    end;
    u23.CurrentEmote = u25;
    u23.Animations.Idle:Stop();
    u25:Play();
    u23.EmoteThread = task.delay(u25.Length, function() --[[ Line: 145 ]]
        -- upvalues: u25 (copy), u23 (copy)
        u25:Stop();
        u23.CurrentEmote = nil;
        u23.Animations.Idle:Play();
    end);
    return u25.Length;
end;
function u8.DoIdleEmote(p26) --[[ Line: 154 ]]
    -- upvalues: l__Mince__6 (copy)
    if p26.ProximityPrompt.Enabled then
        if p26.Determination == "Claim" or (p26.Determination == "Restock" or l__Mince__6.Config.LocalProfile.Intents.ANNI_INTERACT) then
            task.wait(p26:PlayEmote("JumpWave"));
        else
            if p26.Determination == "Searching" then
                task.wait(p26:PlayEmote("Bored"));
            end;
        end;
    end;
end;
function u8.Interact(p27) --[[ Line: 164 ]]
    -- upvalues: u2 (copy), l__Mince__6 (copy), u7 (copy), u6 (copy)
    if p27.InMachine then
    else
        local l__Determination__7 = p27.Determination;
        p27.ProximityPrompt.Enabled = false;
        if l__Determination__7 == "Cooldown" then
            task.defer(p27.PlayEmote, p27, "Cooldown");
            p27:PlayVoiceline("Cooldown");
        elseif l__Determination__7 == "Searching" then
            u2.CreateNotice("Go find the 3 presents Lee has scattered in the woods!");
        elseif l__Determination__7 == "Restock" then
            local v28, v29;
            if l__Mince__6.Config.LocalProfile.Intents.ANNI_INTERACT2 then
                u7:Fire("ANNI_INTERACT2");
                v28 = "Hello";
                v29 = "FirstInteract";
            else
                v28 = "Agree";
                v29 = "Restock";
            end;
            p27.Indicator:SetEnabled(false);
            task.defer(p27.PlayEmote, p27, v28);
            p27:PlayVoiceline(v29);
            p27:PlaceBoxes();
            p27.Determination = "Searching";
        elseif l__Determination__7 == "Claim" then
            local v30;
            if l__Mince__6.Config.LocalProfile.Intents.ANNI_CLAIM2 then
                u7:Fire("ANNI_CLAIM2");
                v30 = "FirstClaim";
            else
                v30 = "ClaimCoins";
            end;
            p27.Indicator:SetEnabled(false);
            u6:Fire();
            task.defer(p27.PlayEmote, p27, "Applaud");
            p27:PlayVoiceline(v30);
            p27.Determination = "Cooldown";
            p27.Instance.Indicator.Timer.Enabled = true;
        end;
        p27.ProximityPrompt.Enabled = true;
    end;
end;
function u8.Construct(u31) --[[ Line: 219 ]]
    -- upvalues: l__Maid__5 (copy), u3 (copy), l__Mince__6 (copy), l__RunService__2 (copy)
    local l__Interact__8 = u31.Instance:WaitForChild("Interact");
    local l__Character__9 = u31.Instance:WaitForChild("Character");
    local l__Indicator__10 = u31.Instance:WaitForChild("Indicator");
    local l__Animations__11 = u31.Instance:WaitForChild("Animations");
    local v32 = Instance.new("ProximityPrompt");
    v32:SetAttribute("Type", "Radial");
    v32:SetAttribute("SizeMultipler", 2);
    v32.ObjectText = "Talk";
    v32.MaxActivationDistance = 5;
    v32.Style = Enum.ProximityPromptStyle.Custom;
    v32.Parent = l__Interact__8;
    v32.RequiresLineOfSight = false;
    u31.Events = {};
    u31.Maid = l__Maid__5.new();
    u31.ProximityPrompt = v32;
    u31.Character = l__Character__9;
    u31.Indicator = u3.CreateIndicator(l__Indicator__10);
    u31.Indicator:SetEnabled(false);
    repeat
        task.wait();
    until l__Mince__6.Config.LocalProfile.Intents;
    if l__Mince__6.Config.LocalProfile.Intents.ANNI_INTERACT then
        u31.Indicator:SetEnabled(true);
    end;
    u31.Animations = {};
    for _, v33 in l__Animations__11:GetChildren() do
        u31.Animations[v33.Name] = u31.Character.Humanoid:LoadAnimation(v33);
    end;
    u31.Animations.Idle:Play();
    v32.Triggered:Connect(function() --[[ Line: 255 ]]
        -- upvalues: u31 (copy)
        u31:Interact();
    end);
    print(l__Mince__6.Config.LocalProfile.Records.AnniversaryQuest);
    if l__Mince__6.Config.LocalProfile.Records.AnniversaryQuest and l__Mince__6.Config.LocalProfile.Records.AnniversaryQuest > workspace:GetServerTimeNow() then
        u31.Determination = "Cooldown";
        l__Indicator__10.Timer.Enabled = true;
    else
        l__Indicator__10.Timer.Enabled = false;
        u31.Indicator:SetEnabled(true);
        u31.Determination = "Restock";
    end;
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 270 ]]
        -- upvalues: u31 (copy)
        u31:UpdateTimer();
    end);
    task.defer(function() --[[ Line: 274 ]]
        -- upvalues: u31 (copy)
        while task.wait(math.random(5, 13)) do
            u31:DoIdleEmote();
        end;
    end);
end;
function u8.UpdateTimer(p34) --[[ Line: 281 ]]
    -- upvalues: l__Mince__6 (copy)
    local v35 = (l__Mince__6.Config.LocalProfile.Records.AnniversaryQuest or 0) - workspace:GetServerTimeNow();
    local v36 = math.max(0, v35);
    local v37 = math.floor(v36 / 3600);
    local v38 = v36 % 3600;
    local v39 = math.floor(v38 / 60);
    local v40 = math.floor(v38 % 60);
    p34.Instance.Indicator.Timer.TextLabel.Text = string.format("%02d:%02d:%02d", v37, v39, v40);
    if v36 == 0 and p34.Determination == "Cooldown" then
        p34.Instance.Indicator.Timer.Enabled = false;
        p34.Indicator:SetEnabled(true);
        p34.Determination = "Restock";
    end;
end;
return u8;
