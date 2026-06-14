-- Decompiled from: ReplicatedStorage.Client.Source.Movement.Bobbing
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__TweenService__3 = game:GetService("TweenService");
local l__RunService__4 = game:GetService("RunService");
local l__VRService__5 = game:GetService("VRService");
local l__LocalPlayer__6 = game:GetService("Players").LocalPlayer;
local l__PlayerModule__7 = l__LocalPlayer__6.PlayerScripts:WaitForChild("PlayerModule");
local l__ControlModule__8 = require(l__PlayerModule__7.ControlModule);
local l__Signal__9 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__10 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__10:Get("InterfaceHandler");
local u2 = l__Mince__10:Get("Intoxication");
l__Mince__10:Get("Locomotion");
local u3 = l__Mince__10:Get("Settings");
local u4 = {
    FOVMult = 1,
    SeedRate = 0.46875,
    TimeElapsed = 0.01,
    DropTimeElapsed = 3,
    FadeTimeElapsed = 0.01,
    IdleTimeElapsed = 0.01,
    AngularRot = math.random(1, 4) / 400,
    AngularRot2 = 0.000125,
    DropAngularRot = 0.0005,
    CrouchOffset = Vector3.new(0, -2, 0),
    CurrentOffset = Vector3.new(0, 0, 0),
    MinModifyValue = 0.001,
    MaxDeltaAdjustment = 3,
    DepthBySpeed = 1,
    MaxTurnStarBlur = 25,
    BlurAmount = 5,
    BlurAmountEvery = 10,
    LeanAmount = 0.005,
    LeanValue = 0,
    BobRate = 0.8,
    WalkAlpha = 1,
    LastRot = 0,
    LastDelta = 0,
    LastOffset = Vector3.new(0, 0, 0),
    IntoxElapsed = 0,
    FadeIn = 0.5,
    Curve = Vector2.new(0.2, 0.7),
    BaseSpeed = 17,
    IdleTime = 8,
    DropTime = 2,
    EasingStyle = Enum.EasingStyle.Sine,
    EasingStyle2 = Enum.EasingStyle.Sine,
    EasingDirection = Enum.EasingDirection.InOut,
    EasingDirection2 = Enum.EasingDirection.Out,
    BobStep = l__Signal__9.new(),
    Enabled = true
};
Vector3.new(-u4.Curve.X, 0, 0);
Vector3.new(0, u4.Curve.Y, 0);
Vector3.new(u4.Curve.X, 0, 0);
Vector3.new(-(u4.Curve.X / 2), u4.Curve.Y, 0);
Vector3.new(u4.Curve.X / 2, u4.Curve.Y);
function r(p5)
    if p5 > 1 then
        return p5 - 1;
    else
        return p5;
    end;
end;
function l(p6)
    if p6.Z == 0 then
        return p6.X;
    else
        return p6.Z;
    end;
end;
function g(p7)
    return p7 > 0.05 and 1 or 0;
end;
function h(p8)
    return p8 > 0 and 1 or (p8 == 0 and 0 or -1);
end;
function j(p9, p10)
    return math.min(1, p9 * (1 / p10));
end;
function angledistance(p11, p12)
    local v13 = math.abs(p12 - p11) % 360;
    if v13 > 180 then
        v13 = 360 - v13 or v13;
    end;
    return v13;
end;
function Inv2(p14)
    local v15 = math.abs(p14 - 0.5) - 0.5;
    return math.abs(v15) * 2;
end;
function InvA2(p16)
    if p16 <= 0.5 then
        return Inv2(p16), -1;
    else
        return Inv2(p16), 1;
    end;
end;
function InvD4(p17)
    if p17 <= 0.5 then
        local v18 = math.clamp(p17, 0, 0.5) * 2;
        return Inv2(v18);
    else
        local v19 = (math.clamp(p17, 0.5, 1) - 0.5) * 2;
        return -Inv2(v19);
    end;
end;
function InvA4(p20)
    if p20 <= 0.5 then
        local v21 = math.clamp(p20, 0, 0.5) * 2;
        return Inv2(v21), 1;
    else
        local v22 = (math.clamp(p20, 0.5, 1) - 0.5) * 2;
        return Inv2(v22), -1;
    end;
end;
function Inv(p23)
    return math.abs(p23 - 0.5) * 2;
end;
function Vet(p24)
    return (p24 - 0.5) * 2;
end;
function quadBezier(p25, p26, p27, p28)
    return p26:Lerp(p27, p25):Lerp(p27:Lerp(p28, p25), p25);
end;
function u4.GroundHit(p29) --[[ Line: 179 ]]
    -- upvalues: u4 (copy)
    u4.Mult = -1;
    if p29 > 65 then
        u4.DropTimeElapsed = 0;
        u4.DropTime = 0.2;
        u4.DropDepth = 1.5;
        u4.TiltEffect = true;
    elseif p29 > 25 then
        u4.DropTimeElapsed = 0;
        u4.DropTime = 0.2;
        u4.DropDepth = 0.5;
        u4.TiltEffect = true;
    end;
end;
function u4.GetBlur() --[[ Line: 203 ]]
    local v30 = game.Lighting:FindFirstChild("Blur");
    if not v30 then
        v30 = Instance.new("BlurEffect", game.Lighting);
        v30:SetAttribute("IgnoreEnvironment", true);
    end;
    return v30;
end;
function u4.SetEnabled(_) --[[ Line: 212 ]] end;
function u4.GetFOVMult() --[[ Line: 216 ]]
    -- upvalues: u4 (copy)
    return u4.FOVMult;
end;
function u4.SetFOVMult(p31) --[[ Line: 219 ]]
    -- upvalues: u2 (copy), u4 (copy)
    local l__CurrentCamera__11 = game.Workspace.CurrentCamera;
    if u2.GetLevel() == 0 then
        l__CurrentCamera__11.FieldOfView = 70 * p31;
    end;
    u4.FOVMult = p31;
end;
function u4.FadeFOVMult(p32, p33, p34) --[[ Line: 229 ]]
    -- upvalues: u4 (copy)
    local v35 = 0;
    repeat
        v35 = v35 + task.wait();
        u4.SetFOVMult(p32 + (p33 - p32) * (v35 / p34));
    until p34 < v35;
    u4.SetFOVMult(p33);
end;
function u4.NewCharacter(p36) --[[ Line: 243 ]]
    -- upvalues: u4 (copy), l__VRService__5 (copy)
    local l__Humanoid__12 = p36:WaitForChild("Humanoid");
    local l__HumanoidRootPart__13 = p36:WaitForChild("HumanoidRootPart");
    local l__BaseSpeed__14 = l__Humanoid__12:WaitForChild("BaseSpeed");
    l__BaseSpeed__14:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 248 ]]
        -- upvalues: u4 (ref), l__BaseSpeed__14 (copy)
        u4.BaseSpeed = l__BaseSpeed__14.Value;
    end);
    l__Humanoid__12.StateChanged:Connect(function(_, p37) --[[ Line: 252 ]]
        -- upvalues: l__HumanoidRootPart__13 (copy), u4 (ref)
        if p37 == Enum.HumanoidStateType.Landed then
            local v38 = math.abs(l__HumanoidRootPart__13.AssemblyLinearVelocity.Y);
            u4.GroundHit(v38);
        end;
    end);
    game.Workspace.CurrentCamera.FieldOfView = 70;
    u4.SetFOVMult(1);
    u4.SetEnabled(true);
    u4.Vignette.ImageTransparency = 1;
    u4.BaseSpeed = l__BaseSpeed__14.Value;
    u4.Humanoid = l__Humanoid__12;
    u4.HumanoidRootPart = l__HumanoidRootPart__13;
    u4.Vignette.ImageTransparency = 1;
    u4.DeepVignette.ImageTransparency = 1;
    game.SoundService.Master.Drunk.Enabled = false;
    game.SoundService.Master.Drunk2.Enabled = false;
    if l__VRService__5.VREnabled then
        game.Lighting.Drunk.Enabled = false;
    end;
end;
function u4.Update(p39) --[[ Line: 279 ]]
    -- upvalues: u4 (copy), u2 (copy), l__ControlModule__8 (copy), l__UserInputService__2 (copy), l__TweenService__3 (copy), u3 (copy), l__VRService__5 (copy), l__Mince__10 (copy)
    local l__CurrentCamera__15 = workspace.CurrentCamera;
    if l__CurrentCamera__15.CameraType == Enum.CameraType.Custom then
        if u4.Humanoid or u4.HumanoidRootPart then
            if u4.Enabled then
                local v40 = u2.GetLevel();
                local v41 = u4.GetBlur();
                v41.Size = 0;
                local v42 = math.min(p39 * 60, u4.MaxDeltaAdjustment);
                if u4.Humanoid.FloorMaterial ~= Enum.Material.Air then
                    local _ = u4.Humanoid.FloorMaterial == nil;
                end;
                local v43 = u4.BaseSpeed / 16;
                local v44 = v43 * u4.DepthBySpeed;
                local v45 = g(u4.HumanoidRootPart.AssemblyLinearVelocity.Magnitude);
                local v46 = l__ControlModule__8:GetMoveVector() * v45;
                local v47 = -1 * l(v46) * v43;
                local v48 = u4;
                v48.WalkAlpha = v48.WalkAlpha + v47 * p39 * u4.BobRate;
                local v49 = u4;
                v49.LeanValue = v49.LeanValue + v46.X * (u4.LeanAmount * v43) * v40;
                local v50 = u4;
                v50.IntoxElapsed = v50.IntoxElapsed + p39;
                if u4.LastCameraRotation then
                    local v51 = Vector3.new(l__CurrentCamera__15.CFrame:ToOrientation());
                    local v52 = angledistance(math.deg(u4.LastCameraRotation.Y), (math.deg(v51.Y)));
                    local v53 = math.rad(v52);
                    local v54 = math.clamp(v53, -50, 50) / 50;
                    local v55 = l__UserInputService__2:GetMouseDelta();
                    local v56 = h(v55.X);
                    local v57 = math.abs(v55.X) * v40;
                    if u4.MaxTurnStarBlur < v57 then
                        v41.Size = (v57 - u4.MaxTurnStarBlur) / u4.BlurAmountEvery * u4.BlurAmount;
                    else
                        v41.Size = v41.Size - v41.Size * (v42 * 0.1);
                        v41.Size = math.max(v41.Size, 0);
                    end;
                    local v58 = u4;
                    v58.LeanValue = v58.LeanValue + v54 * v56 * p39 * 100 * v40;
                end;
                if u4.LeanValue > u4.MinModifyValue or u4.LeanValue < -u4.MinModifyValue then
                    local v59 = u4;
                    v59.LeanValue = v59.LeanValue - u4.LeanValue * (v42 * 0.05);
                else
                    u4.LeanValue = 0;
                end;
                if u4.IdleTimeElapsed > u4.IdleTime then
                    u4.IdleTimeElapsed = 0;
                    u4.AngularRot = math.random(1, 4) / 400;
                end;
                local v60, v61 = InvA4(u4.IdleTimeElapsed / u4.IdleTime);
                local v62 = l__TweenService__3:GetValue(v60, u4.EasingStyle, u4.EasingDirection2) * v61;
                if not u3.GetValue("NoMotion") then
                    l__CurrentCamera__15.CFrame = l__CurrentCamera__15.CFrame * CFrame.Angles(0, 0, u4.LeanValue * -1 + u4.AngularRot * v62 * v44);
                end;
                if u4.DropTimeElapsed < u4.DropTime then
                    local v63 = u4;
                    v63.DropTimeElapsed = v63.DropTimeElapsed + p39;
                    local v64 = math.clamp(u4.DropTimeElapsed / u4.DropTime, 0, 1);
                    local v65 = Inv2(v64);
                    local v66 = l__TweenService__3:GetValue(math.abs(v65), u4.EasingStyle, Enum.EasingDirection.Out);
                    if not u3.GetValue("NoMotion") then
                        l__CurrentCamera__15.CFrame = l__CurrentCamera__15.CFrame * CFrame.new((Vector3.new(0, u4.Mult * (u4.DropDepth * v66), 0)));
                    end;
                    local v67, v68 = InvA4(v64);
                    local v69 = l__TweenService__3:GetValue(math.abs(v67), u4.EasingStyle, Enum.EasingDirection.Out) * v68;
                    local v70 = u4.DropAngularRot * v69;
                    if u4.TiltEffect and not u3.GetValue("NoMotion") then
                        l__CurrentCamera__15.CFrame = l__CurrentCamera__15.CFrame * CFrame.Angles(0, 0, (math.deg(v70)));
                    end;
                end;
                if v40 > 0 then
                    local v71 = 0.5 * v40;
                    local v72 = u4.IntoxElapsed * 0.25;
                    local v73 = math.noise(v72, 0);
                    local v74 = math.noise(0, v72);
                    local v75 = Vector3.new(v73, v74, math.noise(v72, v72)) * Vector3.new(1, 0.4, 1) * 0.0001 * v71;
                    local v76 = 0.2 * v40;
                    local v77 = 0.3 * v40;
                    local v78 = 0.2 * v40;
                    local _ = 0.1 * v40;
                    local v79 = math.sin(u4.IntoxElapsed) / 2;
                    local v80 = math.sin(u4.IntoxElapsed * 1.3) / 2;
                    local v81 = math.sin(u4.IntoxElapsed * 1.685) / 2;
                    local v82 = math.sin(u4.IntoxElapsed * 0.51) / 2;
                    local v83 = 1 - v79;
                    local _ = 1 - v80;
                    if not u3.GetValue("NoMotion") then
                        l__CurrentCamera__15.CFrame = l__CurrentCamera__15.CFrame * CFrame.Angles(math.deg(v75.X * 1), math.deg(v75.Y * 1), (math.deg(v75.Z * 1)));
                        l__CurrentCamera__15.CFrame = l__CurrentCamera__15.CFrame * CFrame.Angles(0, 0, (math.rad(v83 * 8 * v40 * 1)));
                        l__CurrentCamera__15.CFrame = l__CurrentCamera__15.CFrame * CFrame.new(0, 0, 0, 1 - v82 * v78 * 1, v79 * v76 * 1, 0, v80 * v77 * 1, 1, 0, 0, 0, 1);
                        l__CurrentCamera__15.FieldOfView = (70 + (v79 * 20 + 10) * v40) * u4.FOVMult;
                    end;
                    v41.Size = v41.Size + 8 * v40;
                    u4.Vignette.ImageTransparency = 1 - (0.8 * v40 + v79 * 0.2) * v40;
                    game.SoundService.Master.Drunk.DecayTime = 12 * v40;
                    game.SoundService.Master.Drunk.Enabled = true;
                    if u2:IsPassedOut() then
                        game.SoundService.Master.Drunk2.Enabled = true;
                        u4.DeepVignette.ImageTransparency = 1 - (0.8 * v40 + v81 * 0.2);
                        game.SoundService.Master.Drunk2.Octave = 1 - (math.sin(u4.IntoxElapsed) - 0.5) * 2 * 0.05;
                    else
                        game.SoundService.Master.Drunk2.Enabled = false;
                    end;
                    if l__VRService__5.VREnabled then
                        u4.Vignette.ImageTransparency = 1;
                        u4.DeepVignette.ImageTransparency = 1;
                        game.Lighting.Drunk.Enabled = true;
                        if u2:IsPassedOut() then
                            game.Lighting.Drunk.Brightness = -(0.8 * v40 * v79);
                            game.Lighting.Drunk.Contrast = 0.6 * v40 * v79;
                        else
                            game.Lighting.Drunk.Brightness = -(0.1 * v40 * v79);
                            game.Lighting.Drunk.Contrast = 0.1 * v40 * v79;
                        end;
                    end;
                    u4.WasLastIntoxicated = true;
                else
                    if u4.WasLastIntoxicated then
                        u4.WasLastIntoxicated = false;
                        l__CurrentCamera__15.FieldOfView = 70 * u4.FOVMult;
                    end;
                    u4.Vignette.ImageTransparency = 1;
                    u4.DeepVignette.ImageTransparency = 1;
                    game.SoundService.Master.Drunk.Enabled = false;
                    game.SoundService.Master.Drunk2.Enabled = false;
                    if l__VRService__5.VREnabled then
                        game.Lighting.Drunk.Enabled = false;
                    end;
                end;
                l__Mince__10.Config.Stats.BCamera[2] = `MoveTotal:{v47}, WalkAlpha:{u4.WalkAlpha}, FOV(X):{u4.FOVMult}`;
                u4.LastCameraRotation = Vector3.new(l__CurrentCamera__15.CFrame:ToOrientation());
                u4.BobStep:Fire(p39);
            end;
        end;
    end;
end;
function u4.Setup() --[[ Line: 469 ]]
    -- upvalues: u4 (copy), u1 (copy), l__LocalPlayer__6 (copy), l__Mince__10 (copy), l__RunService__4 (copy)
    u4.MainPriority = u1.GetScreenGui("MainPriority");
    u4.Vignette = u4.MainPriority.Vignette;
    u4.DeepVignette = u4.MainPriority.DeepVignette;
    if l__LocalPlayer__6.Character then
        u4.NewCharacter(l__LocalPlayer__6.Character);
    end;
    l__Mince__10.Config.Stats.BCamera = { 2, "IDLE" };
    l__LocalPlayer__6.CharacterAdded:Connect(u4.NewCharacter);
    l__RunService__4.RenderStepped:Connect(u4.Update);
end;
return u4;
