-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.IncorrectNewTools.ShootableGun
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ContextActionService__3 = game:GetService("ContextActionService");
local l__TweenService__4 = game:GetService("TweenService");
local l__RunService__5 = game:GetService("RunService");
local l__Players__6 = game:GetService("Players");
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__7:Get("Locomotion");
local u1 = l__Mince__7:Get("ToolHandler");
l__Mince__7:Get("SoundHandler");
local u2 = l__Mince__7:Get("Notices");
local u3 = l__Mince__7:GetEvent("ShootGun");
local u4 = l__Mince__7:GetEvent("Reload");
local l__LocalPlayer__8 = l__Players__6.LocalPlayer;
local u5 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u6 = {
    Pistol = 50,
    Rifle = 80
};
local u7 = {
    InteractBind = 500,
    CharacterHumanoid = nil,
    CharacterRootPart = nil,
    IsAiming = false,
    TriggerDown = false,
    OriginalFieldOfView = nil,
    OriginalMinZoom = nil,
    OriginalMaxZoom = nil,
    CurrentFOVTween = nil,
    CurrentOffsetTween = nil,
    Tags = { "ShootableGun" }
};
function u7.RestockAmmo() --[[ Line: 57 ]]
    -- upvalues: u6 (copy), u7 (copy)
    u6.Pistol = 50;
    u6.Rifle = 80;
    if u7.CurrentGun then
        u7.CurrentGun:UpdateAmmoDisplay();
    end;
end;
function u7.UpdateAmmoDisplay(p8) --[[ Line: 65 ]]
    -- upvalues: u7 (copy), u6 (copy)
    if u7.ReticleGui then
        local v9 = u7.ReticleGui:FindFirstChild("AmmoLabel") or u7.ReticleGui:FindFirstChild("TextLabel");
        if v9 then
            local v10 = u6[p8.Tool:GetAttribute("AmmoType") or "Rifle"] or 0;
            v9.Text = string.format("%d / %d", p8.CurrentAmmo, v10);
        end;
    end;
end;
function u7.RenderStepShiftLock(p11) --[[ Line: 77 ]]
    -- upvalues: l__UserInputService__2 (copy)
    if p11.CharacterHumanoid and p11.CharacterRootPart then
        l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCenter;
        local l__CFrame__9 = workspace.CurrentCamera.CFrame;
        local _, v12, _ = l__CFrame__9.Rotation:ToEulerAnglesYXZ();
        p11.CharacterRootPart.CFrame = CFrame.new(p11.CharacterRootPart.Position) * CFrame.Angles(0, v12, 0);
        if p11.CharacterWaist and p11.OriginalWaistC0 then
            local v13 = math.asin(l__CFrame__9.LookVector.Y);
            local v14 = math.clamp(v13, -0.5235987755982988, 0.5235987755982988);
            local v15 = p11.OriginalWaistC0 * CFrame.Angles(v14, 0, 0);
            p11.CharacterWaist.C0 = p11.CharacterWaist.C0:Lerp(v15, 0.15);
        end;
    end;
end;
function u7.Reload(p16) --[[ Line: 98 ]]
    -- upvalues: u6 (copy), u7 (copy), u2 (copy), u4 (copy)
    if p16.IsReloading then
    elseif p16.CurrentAmmo >= p16.ClipSize then
    else
        local v17 = p16.Tool:GetAttribute("AmmoType") or "Rifle";
        local v18 = u6[v17] or 0;
        if v18 <= 0 then
            u7.ReticleGui.NoAmmoClick:Play();
            u2.Error("You need to find ammo!");
        else
            p16.IsReloading = true;
            p16.Active = true;
            local l__Reload__10 = p16.Animations.Reload;
            u4:Fire();
            if l__Reload__10 then
                l__Reload__10:Play();
                task.wait(l__Reload__10.Length);
            else
                task.wait(1);
            end;
            local v19 = math.min(p16.ClipSize - p16.CurrentAmmo, v18);
            u6[v17] = v18 - v19;
            p16.CurrentAmmo = p16.CurrentAmmo + v19;
            p16.Tool:SetAttribute("CurrentAmmo", p16.CurrentAmmo);
            p16:UpdateAmmoDisplay();
            p16.IsReloading = false;
            p16.Active = false;
        end;
    end;
end;
function u7.Activate(u20) --[[ Line: 140 ]]
    -- upvalues: l__UserInputService__2 (copy), u3 (copy)
    if not (u20.Active or u20.IsReloading) then
        if u20.CurrentAmmo <= 0 then
            u20:Reload();
            return "Sink";
        end;
        u20.Active = true;
        local u21 = u20.Tool:GetAttribute("Automatic") == true;
        task.spawn(function() --[[ Line: 151 ]]
            -- upvalues: u20 (copy), l__UserInputService__2 (ref), u3 (ref), u21 (copy)
            while true do
                if u20.CurrentAmmo <= 0 then
                    u20:Reload();
                    break;
                end;
                local v22 = u20;
                v22.CurrentAmmo = v22.CurrentAmmo - 1;
                u20.Tool:SetAttribute("CurrentAmmo", u20.CurrentAmmo);
                u20:UpdateAmmoDisplay();
                local v23 = u20.Animations[u20:GetNextActionName()];
                local u24 = nil;
                local u25 = nil;
                u24 = v23:GetMarkerReachedSignal("Shoot"):Connect(function() --[[ Line: 167 ]]
                    -- upvalues: l__UserInputService__2 (ref), u3 (ref), u24 (ref)
                    local l__CurrentCamera__11 = workspace.CurrentCamera;
                    if l__CurrentCamera__11 then
                        local v26 = l__UserInputService__2:GetMouseLocation();
                        local v27 = l__CurrentCamera__11:ViewportPointToRay(v26.X, v26.Y);
                        u3:Fire(v27.Origin, v27.Direction);
                        if u24 then
                            u24:Disconnect();
                            u24 = nil;
                        end;
                    end;
                end);
                u25 = v23.Stopped:Connect(function() --[[ Line: 182 ]]
                    -- upvalues: u24 (ref), u25 (ref)
                    if u24 then
                        u24:Disconnect();
                        u24 = nil;
                    end;
                    if u25 then
                        u25:Disconnect();
                        u25 = nil;
                    end;
                end);
                u20.EquipMaid:Add(u24);
                u20.EquipMaid:Add(u25);
                v23:Play();
                local l__Length__12 = v23.Length;
                task.wait(l__Length__12 <= 0 and 0.1 or l__Length__12);
                if u24 then
                    u24:Disconnect();
                end;
                if u25 then
                    u25:Disconnect();
                end;
                if not (u21 and (u20.TriggerDown and u20.Active)) then
                    break;
                end;
            end;
            u20.Active = false;
        end);
        return "Sink";
    end;
end;
function u7.GetNextActionName(p28) --[[ Line: 218 ]]
    p28.CursorPosition = p28.CursorPosition + 1;
    if p28.CursorPosition == 1 then
        return "Action";
    end;
    if p28.Animations[`Action{p28.CursorPosition}`] then
        return `Action{p28.CursorPosition}`;
    end;
    p28.CursorPosition = 1;
    return "Action";
end;
function u7.UpdateCameraState(p29, p30, p31) --[[ Line: 233 ]]
    -- upvalues: l__TweenService__4 (copy), u5 (copy)
    if workspace.CurrentCamera then
        if p29.CurrentFOVTween then
            p29.CurrentFOVTween:Cancel();
        end;
        p29.CurrentFOVTween = l__TweenService__4:Create(workspace.CurrentCamera, u5, {
            FieldOfView = p30
        });
        p29.CurrentFOVTween:Play();
    end;
    if p29.CharacterHumanoid then
        if p29.CurrentOffsetTween then
            p29.CurrentOffsetTween:Cancel();
        end;
        p29.CurrentOffsetTween = l__TweenService__4:Create(p29.CharacterHumanoid, u5, {
            CameraOffset = p31
        });
        p29.CurrentOffsetTween:Play();
    end;
end;
function u7.StartAiming(p32) --[[ Line: 257 ]]
    if p32.IsAiming then
    else
        p32.IsAiming = true;
        p32:UpdateCameraState(50, Vector3.new(2.5, 0, 0));
        if p32.Animations.Idle then
            p32.Animations.Idle:Stop(0.2);
        end;
        if p32.Animations.Aim then
            p32.Animations.Aim:Play(0.2);
        end;
    end;
end;
function u7.StopAiming(p33) --[[ Line: 267 ]]
    if p33.IsAiming then
        p33.IsAiming = false;
        p33:UpdateCameraState(p33.OriginalFieldOfView or 70, Vector3.new(1.75, 0, 0));
        if p33.Animations.Aim then
            p33.Animations.Aim:Stop(0.2);
        end;
        if p33.Animations.Idle then
            p33.Animations.Idle:Play(0.2);
        end;
    end;
end;
function u7.HandleInput(p34, p35, p36, _) --[[ Line: 277 ]]
    if p35 == "MinceGun_Shoot" then
        if p36 == Enum.UserInputState.Begin then
            p34.TriggerDown = true;
            p34:Activate();
            return;
        end;
        if p36 == Enum.UserInputState.End then
            p34.TriggerDown = false;
        end;
    elseif p35 == "MinceGun_Aim" then
        if p36 == Enum.UserInputState.Begin then
            p34:StartAiming();
            return;
        end;
        if p36 == Enum.UserInputState.End then
            p34:StopAiming();
        end;
    elseif p35 == "MinceGun_Reload" and p36 == Enum.UserInputState.Begin then
        p34:Reload();
    end;
end;
function u7.Equipped(u37) --[[ Line: 298 ]]
    -- upvalues: l__Mince__7 (copy), u7 (copy), l__UserInputService__2 (copy), l__LocalPlayer__8 (copy), l__RunService__5 (copy), l__ContextActionService__3 (copy)
    if l__Mince__7.Config.Humanoid then
        u7.CurrentGun = u37;
        u37.CursorPosition = 0;
        u37.Animations = {};
        u37.TriggerDown = false;
        u37.AnimationFolder = u37.Tool:FindFirstChild("Animations");
        u37.ClipSize = u37.Tool:GetAttribute("ClipSize") or 30;
        u7.ReticleGui.Enabled = true;
        l__UserInputService__2.MouseIconEnabled = false;
        u37.CurrentAmmo = u37.Tool:GetAttribute("CurrentAmmo") or u37.ClipSize;
        u37.Tool:SetAttribute("CurrentAmmo", u37.CurrentAmmo);
        u37:UpdateAmmoDisplay();
        for _, v38 in u37.AnimationFolder:GetChildren() do
            u37.Animations[v38.Name] = l__Mince__7.Config.Humanoid:LoadAnimation(v38);
        end;
        if u37.Animations.Idle then
            u37.Animations.Idle:Play();
        end;
        if l__LocalPlayer__8 and workspace.CurrentCamera then
            u37.OriginalFieldOfView = workspace.CurrentCamera.FieldOfView;
            u37.OriginalMinZoom = l__LocalPlayer__8.CameraMinZoomDistance;
            u37.OriginalMaxZoom = l__LocalPlayer__8.CameraMaxZoomDistance;
            l__LocalPlayer__8.CameraMinZoomDistance = 8;
            l__LocalPlayer__8.CameraMaxZoomDistance = 8;
        end;
        u37.CharacterHumanoid = l__Mince__7.Config.Humanoid;
        if u37.CharacterHumanoid then
            local l__Parent__13 = u37.CharacterHumanoid.Parent;
            local v39;
            if l__Parent__13 then
                v39 = l__Parent__13:FindFirstChild("HumanoidRootPart");
            else
                v39 = l__Parent__13;
            end;
            u37.CharacterRootPart = v39;
            if l__Parent__13 then
                l__Parent__13 = l__Parent__13:FindFirstChild("UpperTorso");
            end;
            if l__Parent__13 then
                u37.CharacterWaist = l__Parent__13:FindFirstChild("Waist");
                if u37.CharacterWaist then
                    u37.OriginalWaistC0 = u37.CharacterWaist.C0;
                end;
            end;
            if u37.CharacterRootPart then
                u37.CharacterHumanoid.CameraOffset = Vector3.new(1.75, 0, 0);
                u37.CharacterHumanoid.AutoRotate = false;
                l__RunService__5:BindToRenderStep("ShiftLock", Enum.RenderPriority.Character.Value, function() --[[ Line: 348 ]]
                    -- upvalues: u37 (copy)
                    u37:RenderStepShiftLock();
                end);
            end;
        end;
        local function v40(...) --[[ Line: 354 ]]
            -- upvalues: u37 (copy)
            u37:HandleInput(...);
        end;
        l__ContextActionService__3:BindAction("MinceGun_Shoot", v40, true, Enum.UserInputType.MouseButton1);
        l__ContextActionService__3:SetTitle("MinceGun_Shoot", "Shoot");
        l__ContextActionService__3:BindAction("MinceGun_Aim", v40, true, Enum.UserInputType.MouseButton2);
        l__ContextActionService__3:SetTitle("MinceGun_Aim", "Aim");
        l__ContextActionService__3:BindAction("MinceGun_Reload", v40, true, Enum.KeyCode.R);
        l__ContextActionService__3:SetTitle("MinceGun_Reload", "Reload");
    end;
end;
function u7.Unequipped(p41) --[[ Line: 366 ]]
    -- upvalues: l__RunService__5 (copy), l__UserInputService__2 (copy), u7 (copy), l__ContextActionService__3 (copy), l__LocalPlayer__8 (copy)
    l__RunService__5:UnbindFromRenderStep("ShiftLock");
    l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
    u7.ReticleGui.Enabled = false;
    l__UserInputService__2.MouseIconEnabled = true;
    l__ContextActionService__3:UnbindAction("MinceGun_Shoot");
    l__ContextActionService__3:UnbindAction("MinceGun_Aim");
    l__ContextActionService__3:UnbindAction("MinceGun_Reload");
    p41.IsAiming = false;
    p41.TriggerDown = false;
    if p41.CurrentFOVTween then
        p41.CurrentFOVTween:Cancel();
    end;
    if p41.CurrentOffsetTween then
        p41.CurrentOffsetTween:Cancel();
    end;
    if l__LocalPlayer__8 then
        if p41.OriginalMinZoom then
            l__LocalPlayer__8.CameraMinZoomDistance = p41.OriginalMinZoom;
            p41.OriginalMinZoom = nil;
        end;
        if p41.OriginalMaxZoom then
            l__LocalPlayer__8.CameraMaxZoomDistance = p41.OriginalMaxZoom;
            p41.OriginalMaxZoom = nil;
        end;
    end;
    if workspace.CurrentCamera and p41.OriginalFieldOfView then
        workspace.CurrentCamera.FieldOfView = p41.OriginalFieldOfView;
        p41.OriginalFieldOfView = nil;
    end;
    if p41.CharacterHumanoid then
        p41.CharacterHumanoid.CameraOffset = Vector3.new(0, 0, 0);
        p41.CharacterHumanoid.AutoRotate = true;
    end;
    if p41.CharacterWaist and p41.OriginalWaistC0 then
        p41.CharacterWaist.C0 = p41.OriginalWaistC0;
    end;
    p41.CharacterHumanoid = nil;
    p41.CharacterRootPart = nil;
    p41.CharacterWaist = nil;
    p41.OriginalWaistC0 = nil;
    for _, v42 in p41.Animations do
        v42:Stop();
    end;
end;
function u7.ShowHitmarker() --[[ Line: 417 ]]
    -- upvalues: u7 (copy)
    task.delay(0.1, function() --[[ Line: 418 ]]
        -- upvalues: u7 (ref)
        u7.ReticleGui.HitSound:Play();
    end);
    if u7.HitmarkerScaleTween.PlaybackState == Enum.PlaybackState.Playing then
        u7.HitmarkerScaleTween:Cancel();
    end;
    if u7.HitmarkerTransparencyTween.PlaybackState == Enum.PlaybackState.Playing then
        u7.HitmarkerTransparencyTween:Cancel();
    end;
    u7.ReticleGui.Hitmarker.GroupTransparency = 0;
    u7.ReticleGui.Hitmarker.UIScale.Scale = 2;
    u7.HitmarkerScaleTween:Play();
    u7.HitmarkerTransparencyTween:Play();
end;
function u7.ShowBulletTrail(p43) --[[ Line: 436 ]]
    p43.End.Stage1.Enabled = true;
    task.wait();
    p43.End.Stage2.Enabled = true;
    p43.End.Stage1.Enabled = false;
    task.wait();
    p43.End.Stage2.Enabled = false;
end;
function u7.Setup() --[[ Line: 445 ]]
    -- upvalues: l__Players__6 (copy), u7 (copy), l__TweenService__4 (copy), u3 (copy), u1 (copy)
    local l__ReticleGui__14 = l__Players__6.LocalPlayer.PlayerGui:WaitForChild("ReticleGui");
    local v44 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local v45 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    u7.ReticleGui = l__ReticleGui__14;
    u7.HitmarkerScaleTween = l__TweenService__4:Create(l__ReticleGui__14.Hitmarker.UIScale, v44, {
        Scale = 1
    });
    u7.HitmarkerTransparencyTween = l__TweenService__4:Create(l__ReticleGui__14.Hitmarker, v45, {
        GroupTransparency = 1
    });
    u7.RestockAmmo();
    l__Players__6.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 457 ]]
        -- upvalues: u7 (ref)
        u7.RestockAmmo();
    end);
    u3.Event:Connect(function(p46, ...) --[[ Line: 461 ]]
        -- upvalues: u7 (ref)
        if p46 and p46 == "BulletTrail" then
            u7.ShowBulletTrail(...);
        else
            u7.ShowHitmarker();
        end;
    end);
    u1.Component(u7);
end;
return u7;
