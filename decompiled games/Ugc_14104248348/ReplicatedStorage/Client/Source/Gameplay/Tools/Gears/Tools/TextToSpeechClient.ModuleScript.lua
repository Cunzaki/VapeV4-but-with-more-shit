-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.TextToSpeechClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TextChatService__1 = game:GetService("TextChatService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__Players__3 = game:GetService("Players");
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__4:Get("Notices");
local u2 = l__Mince__4:Get("Settings");
local u3 = l__Mince__4:Get("ToolHandler");
local u4 = l__Mince__4:Get("TTSInterface");
local u5 = l__Mince__4:Get("ChatHandler");
local u6 = l__Mince__4:Get("UserProfile");
local u7 = l__Mince__4:Get("ConfirmPrompt");
local u8 = l__Mince__4:GetEvent("ExpireIntent");
local u9 = l__Mince__4:GetFunction("TTSRequestSpeech");
local u10 = l__Mince__4:GetEvent("TTSRequestReplay");
local u11 = l__Mince__4:GetEvent("TTSPlayServerRequest");
local u20 = {
    InteractBind = 150,
    Tags = { "TTSTool" },
    Animations = {},
    LastRequestTick = workspace:GetServerTimeNow(),
    RequestReplay = function(p12) --[[ Name: RequestReplay, Line 30 ]]
        -- upvalues: u10 (copy), u4 (copy)
        if workspace:GetServerTimeNow() - p12.LastReplayRequestTick > 4 then
            p12.LastReplayRequestTick = workspace:GetServerTimeNow();
            p12.Animations.Press:Play();
            p12.Animations.Press.Stopped:Wait();
            u10:Fire();
            u4:StartReplayCountdown();
        end;
    end,
    RequestPlay = function(p13, p14, p15) --[[ Name: RequestPlay, Line 41 ]]
        -- upvalues: u9 (copy), u5 (copy), u4 (copy)
        if workspace:GetServerTimeNow() - p13.LastRequestTick > 15 then
            p13.LastRequestTick = workspace:GetServerTimeNow();
            p13.Animations.Press:Play();
            p13.Animations.Press.Stopped:Wait();
            local _ = p13.Tool;
            game.Workspace:GetServerTimeNow();
            if u9:Invoke(p14, p15) then
                u5:SendLocalMessage("TTS", p14);
                u4:StartCountdown();
            end;
        end;
    end,
    Equipped = function(p16) --[[ Name: Equipped, Line 60 ]]
        -- upvalues: l__Mince__4 (copy), u4 (copy)
        local l__Tool__5 = p16.Tool;
        p16.LastRequestTick = l__Tool__5:GetAttribute("LastRunTick") or workspace:GetServerTimeNow();
        p16.LastReplayRequestTick = l__Tool__5:GetAttribute("LastReplayTick") or workspace:GetServerTimeNow();
        p16.Animations = {};
        if l__Mince__4.Config.Humanoid then
            if l__Tool__5:FindFirstChild("Animations") then
                for _, v17 in l__Tool__5.Animations:GetChildren() do
                    local v18 = l__Mince__4.Config.Humanoid.Animator:LoadAnimation(v17);
                    if v18:GetAttribute("Speed") then
                        v18:AdjustSpeed(v18:GetAttribute("Speed"));
                    end;
                    p16.Animations[v17.Name] = v18;
                end;
                u4:OpenInterface();
            end;
        end;
    end,
    Unequipped = function(p19) --[[ Name: Unequipped, Line 82 ]]
        -- upvalues: u4 (copy)
        p19.Animations = {};
        u4:CloseInterface();
    end
};
function u20.CheckForSoundPopup() --[[ Line: 88 ]]
    -- upvalues: u20 (copy), u6 (copy), l__Mince__4 (copy), u8 (copy), u2 (copy), u7 (copy), u1 (copy)
    if not u20.HasBeenInRangeOnce and u6:IsLoaded() then
        u20.HasBeenInRangeOnce = true;
        if l__Mince__4.Config.LocalProfile.Intents.TTS_SOUND_DISABLED then
            u8:Fire("TTS_SOUND_DISABLED");
            if u2.GetValue("TTS") then
                u7.Display("Would you like to keep Text To Speech from other players?", function() --[[ Line: 95 ]]
                    -- upvalues: u1 (ref)
                    u1.CreateNotice("You can disable Text To Speech anytime in settings.");
                end, function() --[[ Line: 97 ]]
                    -- upvalues: u2 (ref), u1 (ref)
                    u2.ChangeSetting("TTS", false);
                    u1.CreateNotice("You can disable Text To Speech anytime in settings.");
                end);
            end;
        end;
    end;
end;
function u20.Setup() --[[ Line: 106 ]]
    -- upvalues: u3 (copy), u20 (copy), l__TextChatService__1 (copy), u2 (copy), l__Players__3 (copy), l__Mince__4 (copy), u11 (copy)
    u3.Component(u20);
    l__TextChatService__1.GameChannels:WaitForChild("TTS").MessageReceived:Connect(function(p21) --[[ Line: 109 ]]
        -- upvalues: u2 (ref), l__Players__3 (ref), l__Mince__4 (ref), u20 (ref)
        if u2.GetValue("TTS") then
            local v22 = l__Players__3:GetPlayerByUserId(p21.TextSource.UserId);
            if v22 then
                local v23 = v22.Character and v22.Character:FindFirstChild("HumanoidRootPart");
                if v23 then
                    v23 = v22.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("TTS_TextToSpeech");
                end;
                if v23 then
                    warn("AudioTextToSpeech:", v23);
                    if v23.Text == p21.Text then
                        v23:SetAttribute("ApprovedText", p21.Text);
                        local l__Text__6 = p21.Text;
                        local l__Parent__7 = v23.Parent;
                        if l__Parent__7.Parent:IsA("Model") and l__Parent__7.Parent:FindFirstChild("Humanoid") then
                            local _ = l__Parent__7.Parent;
                        end;
                        if l__Parent__7 and (l__Mince__4.HumanoidRootPart and (l__Parent__7.Position - l__Mince__4.HumanoidRootPart.Position).Magnitude < 150) then
                            v23.Text = l__Text__6 or v23.Text;
                            v23.TimePosition = 0;
                            v23:Play();
                            u20.CheckForSoundPopup();
                        end;
                    end;
                end;
            end;
        end;
    end);
    u11.Event:Connect(function(p24, p25) --[[ Line: 150 ]]
        -- upvalues: u2 (ref), l__Mince__4 (ref), u20 (ref), l__TextChatService__1 (ref)
        if u2.GetValue("TTS") then
            local l__Parent__8 = p24.Parent;
            local v26 = l__Parent__8.Parent:IsA("Model") and l__Parent__8.Parent:FindFirstChild("Humanoid");
            if v26 then
                v26 = l__Parent__8.Parent;
            end;
            local v27 = p25 or (p24.Text or p24:GetAttribute("ApprovedText"));
            local v28 = 0;
            while p24:GetAttribute("ApprovedText") ~= v27 or v28 < 0.5 do
                v28 = v28 + task.wait();
            end;
            if p24:GetAttribute("ApprovedText") == v27 then
                if l__Parent__8 and l__Mince__4.HumanoidRootPart then
                    if (l__Parent__8.Position - l__Mince__4.HumanoidRootPart.Position).Magnitude < 150 then
                        p24.Text = v27;
                        p24.TimePosition = 0;
                        p24:Play();
                        u20.CheckForSoundPopup();
                    end;
                    l__TextChatService__1:DisplayBubble(v26 or l__Parent__8, v27);
                end;
            else
                warn("This wasn\'t sent through the textchannel so it\'s being ignored!!");
            end;
        end;
    end);
end;
return u20;
