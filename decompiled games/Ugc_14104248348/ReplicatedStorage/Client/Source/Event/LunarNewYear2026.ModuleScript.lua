-- Decompiled from: ReplicatedStorage.Client.Source.Event.LunarNewYear2026
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("BadgeService");
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
game:GetService("Debris");
local l__TweenService__4 = game:GetService("TweenService");
game:GetService("MarketplaceService");
game:GetService("CollectionService");
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.SevenSegment);
local l__Bucket__6 = require(l__ReplicatedStorage__1.Modules.Bucket);
local u1 = l__Mince__5:Get("Voicelines");
l__Mince__5:Get("SoundHandler");
local u2 = l__Mince__5:Get("CutsceneHandler");
local u3 = l__Mince__5:Get("SelectInteractor");
local u4 = l__Mince__5:Get("InterfaceHandler");
local u5 = l__Mince__5:Get("SoundHandler");
l__Mince__5:Get("SoundArea");
local u6 = l__Mince__5:GetEvent("DoSpeakLNY");
local u7 = l__Mince__5:GetEvent("LNY26");
local u8 = l__Mince__5:GetEvent("ContinueShow");
local u9 = l__Mince__5:GetEvent("DoCrowdCheer");
local u10 = {
    Countdowns = l__Bucket__6.new({
        "LNY26Countdown1",
        "LNY26Countdown2",
        "LNY26Countdown3",
        "LNY26Countdown4"
    }),
    Timeline = {
        { "Phase1", 1800 },
        { "Phase2", 600 },
        { "Phase3", 120 },
        { "CountdownSong", 31 },
        { "Te2st", 0 }
    },
    When = {}
};
function u10.When.Phase(_, p11) --[[ Line: 43 ]]
    -- upvalues: u10 (copy)
    u10.SwitchCameraVFXTo(u10.LNYFolder.LunarNewYearStages[p11].CameraVFX);
end;
function u10.CountdownSong(_, _) --[[ Line: 47 ]]
    -- upvalues: u5 (copy)
    task.delay(0.8, function() --[[ Line: 48 ]]
        -- upvalues: u5 (ref)
        u5.StopAllTracks();
        script.Last30SecondsCountdown:Play();
    end);
end;
function u10.TestRepeated(_, _) --[[ Line: 54 ]] end;
function u10.Test(_) --[[ Line: 58 ]] end;
function u10.Te2st(_) --[[ Line: 62 ]]
    -- upvalues: u5 (copy), u1 (copy), u3 (copy), l__Players__2 (copy), l__TweenService__4 (copy), u10 (copy), u2 (copy)
    script.Last30SecondsCountdown:Stop();
    u5.StopAllTracks();
    script.FakeShowSong:Play();
    task.wait(8);
    u5.StopAllTracks();
    u1.PlayLine("LNY26WheresHorse");
    u3.StartInteractions();
    if l__Players__2.LocalPlayer.Character then
        l__Players__2.LocalPlayer.Character.Humanoid:UnequipTools();
    end;
    task.wait(1);
    u5.StopAllTracks();
    l__TweenService__4:Create(script.FakeShowSong, TweenInfo.new(0.8), {
        PlaybackSpeed = 0
    }):Play();
    task.wait(0.8);
    u5.StopAllTracks();
    script.FakeShowSong:Stop();
    task.wait(39);
    u10.Cutscene = u2:LoadCutscene("LNY2026Cutscene");
    u10.GaugueUI.Enabled = true;
end;
function u10.ContinueShow() --[[ Line: 91 ]]
    -- upvalues: u10 (copy), u5 (copy), u7 (copy), l__ReplicatedStorage__1 (copy), u3 (copy)
    u10.GaugueUI.Enabled = false;
    script.HorseArriving:Play();
    u5.StopAllTracks();
    pcall(function() --[[ Line: 95 ]]
        -- upvalues: u10 (ref)
        u10.Cutscene:Play();
    end);
    task.wait(29);
    u7:Fire();
    l__ReplicatedStorage__1.Assets.HorseRig.Parent = workspace;
    task.wait(1);
    u3.EndInteractions();
    u5.StopAllTracks();
    script.RealShowSong:Play();
    task.wait(34);
    u5.StopAllTracks();
    script.LanternShow:Play();
end;
function u10.DoCheer(p12) --[[ Line: 118 ]]
    -- upvalues: u1 (copy), u10 (copy)
    local v13 = u1.GetVoicelineSettings(u10.Countdowns:Next());
    v13:Play();
    v13.Sound.Ended:Wait();
    u10.GaugueUI.Text.Text = p12;
    for _ = 1, 5 do
        task.wait(0.5);
        u10.GaugueUI.Text.Visible = false;
        task.wait(0.1);
        u10.GaugueUI.Text.Visible = true;
    end;
    task.wait(0.5);
    u10.GaugueUI.Text.Text = "";
end;
function u10.Update() --[[ Line: 139 ]]
    -- upvalues: u10 (copy)
    if u10.CurrentVFXToUpdate then
        u10.CurrentVFXToUpdate.CFrame = workspace.CurrentCamera.CFrame;
    end;
end;
function u10.SwitchCameraVFXTo(p14) --[[ Line: 144 ]]
    -- upvalues: u10 (copy), l__RunService__3 (copy)
    if u10.CurrentVFXToUpdate then
        for _, v15 in u10.CurrentVFXToUpdate do
            v15.Enabled = false;
        end;
    end;
    u10.CurrentVFXToUpdate = p14;
    if not u10.Connection then
        u10.Connection = l__RunService__3.Heartbeat:Connect(u10.Update);
    end;
end;
function u10.Setup() --[[ Line: 158 ]]
    -- upvalues: l__Mince__5 (copy), u10 (copy), u4 (copy), u8 (copy), u9 (copy), u6 (copy), u1 (copy), u7 (copy)
    if l__Mince__5.Config.HolidayConfigure.EVENT_SPECIFIC_MODULES then
        u10.LNYFolder = workspace:WaitForChild("LNY");
        u10.GaugueUI = u4.GetScreenGui("LNY2026");
        u8.Event:Connect(u10.ContinueShow);
        u9.Event:Connect(u10.DoCheer);
        u6.Event:Connect(function(p16) --[[ Line: 165 ]]
            -- upvalues: u1 (ref)
            u1.PlayLine("LNY26" .. p16);
        end);
        u7.Event:Connect(function() --[[ Line: 169 ]]
            workspace.HorseRig:Destroy();
        end);
    end;
end;
return u10;
