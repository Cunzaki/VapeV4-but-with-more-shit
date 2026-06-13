-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Tools.TTSInterface
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Dropdown__4 = require(l__ReplicatedStorage__1.Modules.Dropdown);
require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local l__LocalPlayer__5 = l__Players__2.LocalPlayer;
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:Get("TextToSpeechClient");
local u3 = {
    SelectedVoice = 1,
    MainUI = nil,
    MainButton = nil,
    VoiceOptions = {
        "British male",
        "British female",
        "US male #1",
        "US female #1",
        "US male #1",
        "US female #1",
        "Australian male",
        "Australian female",
        "Retro #1",
        "Retro #2",
        "Host voice"
    },
    CountdownEnd = tick()
};
function u3.OpenInterface(_) --[[ Line: 34 ]]
    -- upvalues: u3 (copy)
    u3.Interface.Open();
end;
function u3.CloseInterface(_) --[[ Line: 38 ]]
    -- upvalues: u3 (copy)
    u3.Interface.Close();
end;
function u3.StartReplayCountdown(_) --[[ Line: 42 ]]
    -- upvalues: u3 (copy)
    u3.PlayLast.Tween = false;
    u3.PlayLast.SetState("Disabled");
    u3.MainUI.PlayLast.TextLabel.Visible = false;
    u3.MainUI.PlayLast.ActualText.Visible = false;
    for v4 = 1, 4 do
        u3.MainUI.PlayLast.Text = `Replay ({4 - v4}s)`;
        task.wait(1);
    end;
    u3.PlayLast.Tween = true;
    u3.PlayLast.SetState("Default");
    u3.MainUI.PlayLast.Text = "";
    u3.MainUI.PlayLast.TextLabel.Visible = true;
    u3.MainUI.PlayLast.ActualText.Visible = true;
end;
function u3.StartCountdown(_) --[[ Line: 63 ]]
    -- upvalues: u3 (copy)
    u3.MainButton.Tween = false;
    u3.MainButton.SetState("Disabled");
    for v5 = 1, 15 do
        u3.MainUI.OkayButton.Text = `Cooldown ({15 - v5}s)`;
        task.wait(1);
    end;
    u3.MainButton.SetState("Default");
    u3.MainUI.OkayButton.Text = "Speak";
    u3.MainButton.Tween = true;
end;
function u3.SetupCharacter(p6) --[[ Line: 81 ]]
    -- upvalues: u3 (copy)
    u3.MainUI.PlayLast.Visible = false;
    local l__HumanoidRootPart__6 = p6:WaitForChild("HumanoidRootPart");
    local u7 = l__HumanoidRootPart__6:FindFirstChild("TTS_TextToSpeech");
    if u7 then
        u3.MainUI.PlayLast.Visible = true;
        u3.MainUI.PlayLast.ActualText.Text = u7.Text or "";
        u7:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 90 ]]
            -- upvalues: u3 (ref), u7 (ref)
            u3.MainUI.PlayLast.ActualText.Text = u7.Text or "";
        end);
    else
        local u8 = nil;
        u8 = l__HumanoidRootPart__6.ChildAdded:Connect(function(p9) --[[ Line: 102 ]]
            -- upvalues: u8 (ref), u3 (ref), u7 (ref)
            if p9.Name == "TTS_TextToSpeech" then
                u8:Disconnect();
                u3.MainUI.PlayLast.Visible = true;
                u7 = p9;
                u3.MainUI.PlayLast.ActualText.Text = u7.Text or "";
                u7:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 90 ]]
                    -- upvalues: u3 (ref), u7 (ref)
                    u3.MainUI.PlayLast.ActualText.Text = u7.Text or "";
                end);
            end;
        end);
    end;
end;
function u3.Setup(_) --[[ Line: 113 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy), l__Dropdown__4 (copy), l__LocalPlayer__5 (copy)
    u3.Interface = u1.Get("TTSUI");
    u3.MainUI = u3.Interface.TweenFrame;
    u3.PlayLast = u1.NewButton(u3.MainUI.PlayLast);
    u3.PlayLast.Activated:Connect(function() --[[ Line: 120 ]]
        -- upvalues: u2 (ref)
        u2.GetActiveTool():RequestReplay();
    end);
    u3.MainButton = u1.NewButton(u3.MainUI.OkayButton);
    u3.MainButton.Activated:Connect(function() --[[ Line: 126 ]]
        -- upvalues: u3 (ref), u2 (ref)
        local l__Text__7 = u3.MainUI.TextBox.Text;
        u2.GetActiveTool():RequestPlay(l__Text__7, u3.SelectedVoice);
    end);
    u3.VoiceDropdown = l__Dropdown__4.SetupDropbox(u3.MainUI.Options.DropdownBox, u3.VoiceOptions);
    function u3.VoiceDropdown.Switched() --[[ Line: 133 ]]
        -- upvalues: u3 (ref)
        u3.SelectedVoice = u3.VoiceDropdown.Selected;
    end;
    l__LocalPlayer__5.CharacterAdded:Connect(u3.SetupCharacter);
    if l__LocalPlayer__5.Character then
        task.defer(u3.SetupCharacter, l__LocalPlayer__5.Character);
    end;
end;
return u3;
