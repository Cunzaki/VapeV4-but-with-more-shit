-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Aqaurium.AudioTourButton
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("SoundArea");
local u2 = l__Mince__3:Get("Voicelines");
local u3 = l__Mince__3:Get("SoundHandler");
local u4 = l__Mince__3:Get("TriggerHandler");
local u5 = l__Mince__3:Get("SelectInteractor");
local u6 = l__Mince__3.Component({
    Tag = "AudioTourButton",
    ButtonTween = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true)
});
function u6.Start(p7) --[[ Line: 18 ]]
    -- upvalues: u3 (copy)
    if p7.AudioTourPlaying then
    else
        p7.AudioTourPlaying = true;
        p7.InteractionClass.HoverName = "End Audio Tour";
        u3.StopAllTracks();
        u3.PlayTrack("Audio_Tour_Back_Music");
        p7.Voiceline:Play();
    end;
end;
function u6.End(p8) --[[ Line: 30 ]]
    -- upvalues: u3 (copy), u1 (copy)
    if p8.AudioTourPlaying then
        p8.AudioTourPlaying = false;
        p8.InteractionClass.HoverName = "Begin Audio Tour";
        u3.StopTrack("Audio_Tour_Back_Music");
        u1.RestartTracks();
        p8.Voiceline:Stop();
    end;
end;
function u6.Construct(u9) --[[ Line: 41 ]]
    -- upvalues: l__TweenService__2 (copy), u6 (copy), u2 (copy), u4 (copy), u5 (copy)
    u9.LastClick = os.clock();
    u9.PressButtonTween = l__TweenService__2:Create(u9.Instance.PrimaryPart, u6.ButtonTween, {
        Position = u9.Instance.PrimaryPart.Position - 0.065 * u9.Instance.PrimaryPart.CFrame.UpVector
    });
    u9.Voiceline = u2.GetVoicelineSettings("AudioTour2");
    u9.Voiceline.Sound.Ended:Connect(function() --[[ Line: 48 ]]
        -- upvalues: u9 (copy)
        warn("sound stopped! ");
        if u9.AudioTourPlaying then
            u9:End();
        end;
    end);
    u9.Trigger = u4.GetTrigger("Aquarium");
    u9.Trigger.Leaved:Connect(function() --[[ Line: 55 ]]
        -- upvalues: u9 (copy)
        if u9.AudioTourPlaying then
            u9:End();
        end;
    end);
    local v11 = {
        HoverName = "Begin Audio Tour",
        Model = u9.Instance,
        Target = u9.Instance,
        HitCollider = u9.Instance.PrimaryPart,
        Interact = function(_, p10) --[[ Name: Interact, Line 67 ]]
            -- upvalues: u9 (copy)
            u9.LastClick = os.clock();
            u9.PressButtonTween:Play();
            u9.Instance.PrimaryPart.Press:Play();
            if u9.AudioTourPlaying then
                p10();
                u9:End();
            else
                p10();
                u9:Start();
            end;
        end,
        OnHover = function() --[[ Line: 83 ]]
            -- upvalues: u9 (copy)
            return os.clock() - u9.LastClick > 1.5;
        end
    };
    u5.NewInteractionClass(v11);
    u9.InteractionClass = v11;
end;
return u6;
