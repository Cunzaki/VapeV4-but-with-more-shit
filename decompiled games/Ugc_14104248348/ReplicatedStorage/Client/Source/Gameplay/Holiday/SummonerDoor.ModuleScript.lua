-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.SummonerDoor
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Debris__3 = game:GetService("Debris");
local l__TweenService__4 = game:GetService("TweenService");
local l__Players__5 = game:GetService("Players");
local l__Mince__6 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Bucket__7 = require(l__ReplicatedStorage__2.Modules.Bucket);
l__Mince__6:Get("InterfaceHandler");
local u1 = l__Mince__6:Get("Voicelines");
l__Mince__6:Get("Notices");
local u2 = l__Mince__6:Get("Locomotion");
local u3 = l__Mince__6:Get("Settings");
local u4 = l__Mince__6:Get("SoundHandler");
local u5 = l__Mince__6:GetEvent("ThrowPumpkinAtPoint");
local u6 = l__Mince__6:GetEvent("NotifyPumpkin");
local u7 = l__Mince__6:GetEvent("EnterPumpkinDoor");
local u8 = l__Mince__6.Component({
    Tag = "SummonerDoor",
    Voicelines = {
        Cooldown = l__Bucket__7.new({ "HWN24DoorCooldown1", "HWN24DoorCooldown2" }),
        Open = l__Bucket__7.new({ "HWN24DoorOpen" }),
        OpenReminder = l__Bucket__7.new({ "HWN24DoorOpenReminder" }),
        Close = l__Bucket__7.new({ "HWN24DoorClose" }),
        CloseReminder = l__Bucket__7.new({ "HWN24DoorCloseUrgent" })
    },
    PlaySounds = {
        Open = "DoorHalloIdent"
    }
});
local u9 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u10 = TweenInfo.new(3.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local l__LocalPlayer__8 = l__Players__5.LocalPlayer;
function u8.Enter(u11) --[[ Line: 67 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__TweenService__4 (copy), u9 (copy), u2 (copy), u1 (copy), u4 (copy), l__RunService__1 (copy), u3 (copy), u7 (copy), u10 (copy)
    if l__LocalPlayer__8.Character and (not u11.AnimationActive and l__LocalPlayer__8.Character:FindFirstChild("Humanoid")) then
        u11.AnimationActive = true;
        local l__Humanoid__9 = l__LocalPlayer__8.Character.Humanoid;
        local l__CurrentCamera__10 = workspace.CurrentCamera;
        local v12 = CFrame.lookAt(u11.Instance.ProgressBar.CameraPoint.WorldPosition, u11.Instance.ProgressBar.Position);
        local l__WorldPosition__11 = u11.Instance.ProgressBar.WalkPoint.WorldPosition;
        l__CurrentCamera__10.CameraType = Enum.CameraType.Scriptable;
        l__TweenService__4:Create(l__CurrentCamera__10, u9, {
            FieldOfView = 40,
            CFrame = v12
        }):Play();
        u2.SetEnabled(false);
        u2.SetUpdating(false);
        l__Humanoid__9.WalkSpeed = 16;
        task.wait(0.5);
        l__Humanoid__9:MoveTo(l__WorldPosition__11);
        task.wait(0.3);
        task.delay(1, function() --[[ Line: 91 ]]
            -- upvalues: u1 (ref)
            u1.PlayLine("HWN24EvilLaugh");
        end);
        u4.PlaySound("portal_enter");
        local u13 = {};
        local u14 = false;
        local u15 = 0;
        local u16 = 0;
        local u17 = nil;
        u17 = l__RunService__1.RenderStepped:Connect(function(p18) --[[ Line: 103 ]]
            -- upvalues: u16 (ref), l__LocalPlayer__8 (ref), u14 (ref), u15 (ref), l__CurrentCamera__10 (copy), u3 (ref), u13 (copy), u11 (copy), u7 (ref), u17 (ref)
            local v19 = u16 / 4;
            local v20 = 1;
            local v21 = 0.5 - v19;
            if v19 <= 0.5 then
                if v21 < 0.2 then
                    v20 = v21 / 0.2;
                end;
                if v21 < 0.1 then
                    l__LocalPlayer__8.PlayerGui.MainPriority.BlackoutFull.BackgroundTransparency = v21 / 0.1;
                end;
            end;
            if u14 and u15 <= 1 then
                u15 = u15 + p18;
            else
                u16 = u16 + p18;
                local v22 = u16 / 4;
                local v23 = 0.5 - math.abs(v22 - 0.5);
                local v24 = math.min(v23, 0.5);
                local v25 = math.max(0, v24) * math.sin(v22 * (30 or 7));
                if u14 then
                    local l__BlackoutFull__12 = l__LocalPlayer__8.PlayerGui.MainPriority.BlackoutFull;
                    local v26 = v22 - 0.05;
                    local v27 = 0.5 - math.abs(v26 - 0.5);
                    local v28 = math.min(v27, 0.5);
                    l__BlackoutFull__12.BackgroundTransparency = 1 - math.max(0, v28) * math.sin(v26 * (30.5 or 7));
                end;
                local v29 = l__CurrentCamera__10.CFrame * CFrame.new(0, 0, 0, v20, 0, 0, v25 * 0.2, 1, 0, 0, 0, 1);
                if not u3.GetValue("NoMotion") then
                    l__CurrentCamera__10.CFrame = v29;
                end;
                if v21 < 0 and not u13.Counted2 then
                    u13.Counted2 = true;
                    u14 = true;
                    u11.AnimationActive = false;
                    l__LocalPlayer__8.PlayerGui.MainPriority.BlackoutFull.BackgroundTransparency = 0;
                    u7:Fire();
                    u17:Disconnect();
                end;
            end;
        end);
        task.wait(5);
        l__CurrentCamera__10.CameraType = Enum.CameraType.Custom;
        l__TweenService__4:Create(l__CurrentCamera__10, u10, {
            FieldOfView = 70
        }):Play();
        l__TweenService__4:Create(l__LocalPlayer__8.PlayerGui.MainPriority.BlackoutFull, u10, {
            BackgroundTransparency = 1
        }):Play();
        u2.SetEnabled(true);
        u2.SetUpdating(true);
    end;
end;
function u8.Notify(p30, p31) --[[ Line: 165 ]]
    -- upvalues: u8 (copy), u4 (copy), u1 (copy)
    if p30.PlayingLine then
    else
        warn("Notify->", p31);
        local v32 = u8.PlaySounds[p31];
        if v32 then
            u4.PlaySound(v32);
        end;
        local v33 = p30.Voicelines[p31]:Next();
        p30.PlayingLine = true;
        local v34 = u1.GetVoicelineSettings(v33);
        v34:Play();
        repeat
            task.wait();
        until v34.Sound.TimeLength ~= 0;
        task.wait(v34.Sound.TimeLength);
        p30.PlayingLine = false;
    end;
end;
function u8.TakePumpkin(p35, p36, p37) --[[ Line: 187 ]]
    -- upvalues: l__TweenService__4 (copy), l__Debris__3 (copy)
    local v38 = p36:Clone();
    v38.Parent = workspace;
    v38.Material = Enum.Material.ForceField;
    v38.Color = Color3.new(1, 0.172549, 0.172549);
    v38.Anchored = false;
    v38.Transparency = 1;
    local v39 = Instance.new("Weld");
    v39.Parent = v38;
    v39.Part0 = p36;
    v39.Part1 = v38;
    p36.Loop:Play();
    l__TweenService__4:Create(v38, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = -10
    }):Play();
    l__TweenService__4:Create(p36, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play();
    local l__Position__13 = p36.Position;
    local v40 = p37 + Vector3.new(3, 0, 0);
    local l__Magnitude__14 = (l__Position__13 - v40).Magnitude;
    local v41 = l__Position__13:Lerp(v40, 0.5) + Vector3.new(15, 0, 0);
    local v42 = l__Magnitude__14 * 0.1;
    local v43 = 0;
    repeat
        local v44 = l__TweenService__4:GetValue(v43 / v42, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local v45 = math.max(0, v44 - 0.05);
        local v46 = l__Position__13:Lerp(v41, v45):Lerp(v41:Lerp(v40, v45), v45);
        local v47 = l__Position__13:Lerp(v41, v44):Lerp(v41:Lerp(v40, v44), v44);
        local l__Unit__15 = (v46 - v47).Unit;
        p36.CFrame = CFrame.new(v47) * CFrame.new(Vector3.new(0, 0, 0), l__Unit__15).Rotation * CFrame.Angles(1.5707963267948966, 0, 0);
        v43 = v43 + task.wait();
    until v42 < v43;
    local v48 = p35.Instance.ProgressBar.PumpkinAddedAttachment:Clone();
    v48.Parent = p35.Instance.ProgressBar;
    v48.WorldPosition = p36.Position;
    for _, v49 in v48:GetChildren() do
        v49:Emit(v49:GetAttribute("EmitCount"));
    end;
    p35.Instance.ProgressBar.PortalImpact:Play();
    v38:Destroy();
    p36:Destroy();
    l__Debris__3:AddItem(v48, 5);
end;
function u8.AdjustEffects(p50) --[[ Line: 250 ]]
    -- upvalues: l__TweenService__4 (copy), u9 (copy)
    local v51 = p50.Instance:GetAttribute("Progress") or 0;
    local l__Instance__16 = p50.Instance;
    local l__PortalEffects__17 = l__Instance__16.PortalEffects;
    local v52 = math.clamp(v51, 0.1, 1);
    local v53 = 1 - v52;
    local v54 = l__TweenService__4:Create(l__PortalEffects__17.VortexMesh, u9, {
        Transparency = v53
    });
    local v55 = l__TweenService__4:Create(l__PortalEffects__17.Backdrop, u9, {
        Transparency = v53
    });
    local v56 = l__TweenService__4:Create(l__Instance__16.Portal.TweenedValue, u9, {
        Value = v53
    });
    local v57 = l__TweenService__4:Create(l__Instance__16.ProgressBar.SurfaceGui.ImageLabel.UIGradient, u9, {
        Offset = Vector2.new(0, 1 - v51)
    });
    local v58 = l__TweenService__4:Create(l__Instance__16.Portal.PortalLoop, u9, {
        Volume = v52 * 3
    });
    v54:Play();
    v55:Play();
    v56:Play();
    v57:Play();
    v58:Play();
    l__Instance__16.Portal.VortexEffect.Enabled = v51 > 0.75;
    if v51 >= 1 then
        for _, v59 in p50.Instance.ProgressBar.OpenEffects:GetChildren() do
            v59:Emit(v59:GetAttribute("EmitCount"));
        end;
    end;
end;
function u8.Construct(u60) --[[ Line: 279 ]]
    -- upvalues: u6 (copy), u7 (copy), u5 (copy)
    u60.Instance.Portal.TweenedValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 280 ]]
        -- upvalues: u60 (copy)
        u60.Instance.PortalEffects.ImQAura.Lines.Transparency = NumberSequence.new(u60.Instance.Portal.TweenedValue.Value);
        u60.Instance.PortalEffects.ImQAura.Stars.Transparency = NumberSequence.new(u60.Instance.Portal.TweenedValue.Value);
        u60.Instance.Portal.Dust.Transparency = NumberSequence.new(u60.Instance.Portal.TweenedValue.Value);
    end);
    u60:AdjustEffects();
    u60.Instance:GetAttributeChangedSignal("Progress"):Connect(function() --[[ Line: 288 ]]
        -- upvalues: u60 (copy)
        u60:AdjustEffects();
    end);
    u6.Event:Connect(function(...) --[[ Line: 292 ]]
        -- upvalues: u60 (copy)
        u60:Notify(...);
    end);
    u7.Event:Connect(function(...) --[[ Line: 296 ]]
        -- upvalues: u60 (copy)
        u60:Enter(...);
    end);
    u5.Event:Connect(function(...) --[[ Line: 300 ]]
        -- upvalues: u60 (copy)
        u60:TakePumpkin(...);
    end);
end;
return u8;
