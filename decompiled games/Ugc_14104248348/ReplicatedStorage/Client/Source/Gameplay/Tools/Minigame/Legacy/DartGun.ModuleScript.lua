-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Minigame.Legacy.DartGun
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__Players__5 = game:GetService("Players");
local l__Debris__6 = game:GetService("Debris");
local l__TweenService__7 = game:GetService("TweenService");
local l__Mince__8 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__SpringModule__9 = require(l__ReplicatedStorage__3.Modules.SpringModule);
local l__FastCastRedux__10 = require(l__ReplicatedStorage__3.Modules.FastCastRedux);
local l__Signal__11 = require(l__ReplicatedStorage__3.Modules.Signal);
local u1 = l__Mince__8:Get("ToolHandler");
local u2 = l__Mince__8:Get("SoundHandler");
l__Players__5.LocalPlayer:GetMouse();
Vector3.new(0, -workspace.Gravity / 2, 0);
l__FastCastRedux__10.VisualizeCasts = false;
local u3 = {
    Tags = { "DartGun" },
    Animations = {},
    CONST = l__Mince__8.Config.DartGun,
    BobbleSpring = l__SpringModule__9.new(),
    SwayingSpring = l__SpringModule__9.new(),
    TargetShot = l__Signal__11.new(),
    TargetMissed = l__Signal__11.new()
};
function u3.Equipped(p4) --[[ Line: 58 ]]
    -- upvalues: u3 (copy), l__ReplicatedStorage__3 (copy), l__RunService__1 (copy)
    u3.ToggleGui(true);
    for _, v5 in p4.Tool:GetChildren() do
        if v5:IsA("BasePart") then
            v5.Transparency = 1;
        end;
    end;
    u3.ViewModel = l__ReplicatedStorage__3.Assets.Misc.DartGunViewmodel:Clone();
    u3.ViewModel.Parent = game.Workspace;
    for _, v6 in u3.ViewModel.Animations:GetChildren() do
        u3.Animations[v6.Name] = u3.ViewModel.AnimationController.Animator:LoadAnimation(v6);
    end;
    u3.Animations.Idle:Play();
    u3.UpdateConnection = l__RunService__1.RenderStepped:Connect(u3.Update);
end;
function u3.Unequipped(_) --[[ Line: 77 ]]
    -- upvalues: u3 (copy)
    u3.ToggleGui(false);
    u3.ViewModel:Destroy();
    u3.ViewModel = nil;
    u3.UpdateConnection:Disconnect();
end;
function u3.Activate(_) --[[ Line: 85 ]]
    -- upvalues: u3 (copy)
    u3.ShootDart();
end;
function u3.ShootDart() --[[ Line: 89 ]]
    -- upvalues: u2 (copy), u3 (copy)
    u2.PlaySound("shootdart");
    u3.Animations.Shoot:Play();
    local v7 = workspace.CurrentCamera:ScreenPointToRay(u3.ReticleGui.Reticle.Hit.AbsolutePosition.X, u3.ReticleGui.Reticle.Hit.AbsolutePosition.Y);
    local v8 = workspace:Raycast(v7.Origin, v7.Direction * 100, u3.CastParams);
    if v8 then
        local _ = u3.ViewModel.Handle.ShootPoint.WorldPosition;
        u3.SimulateDart(workspace.CurrentCamera.CFrame.Position, v8.Position);
    end;
end;
function u3.SimulateDart(p9, p10) --[[ Line: 112 ]]
    -- upvalues: u3 (copy)
    local l__Unit__12 = (p10 - p9).Unit;
    local l__LookVector__13 = CFrame.new(Vector3.new(), l__Unit__12).LookVector;
    u3.Caster:Fire(p9, l__LookVector__13, l__LookVector__13 * 400, u3.CastBehavior);
end;
function u3.DartHit(p11, p12, _, _) --[[ Line: 124 ]]
    -- upvalues: u3 (copy), l__Debris__6 (copy)
    local l__Instance__14 = p12.Instance;
    local l__Position__15 = p12.Position;
    local _ = p12.Normal;
    if l__Instance__14 == nil then
    else
        p11.RayInfo.CosmeticBulletObject.Anchored = false;
        local v13 = Instance.new("WeldConstraint", p11.RayInfo.CosmeticBulletObject);
        v13.Part0 = l__Instance__14;
        v13.Part1 = p11.RayInfo.CosmeticBulletObject;
        v13.Enabled = true;
        if l__Instance__14:HasTag("DartGunTarget") then
            u3.ShowHitmarker();
            u3.TargetShot:Fire(l__Instance__14, l__Position__15, p11.RayInfo.CosmeticBulletObject.CFrame);
            local v14 = Instance.new("Sound");
            v14.SoundId = "rbxassetid://6732342375";
            v14.RollOffMaxDistance = 100;
            v14.Parent = l__Instance__14;
            v14:Play();
            l__Debris__6:AddItem(v14, 2);
        else
            u3.TargetMissed:Fire(l__Instance__14, p11.RayInfo.CosmeticBulletObject.CFrame);
        end;
    end;
end;
function u3.DartTerminate(p15) --[[ Line: 158 ]]
    -- upvalues: l__Debris__6 (copy)
    local l__CosmeticBulletObject__16 = p15.RayInfo.CosmeticBulletObject;
    if l__CosmeticBulletObject__16 == nil then
    else
        l__Debris__6:AddItem(l__CosmeticBulletObject__16, 5);
    end;
end;
function u3.UpdateDart(p16, p17, p18, p19, _, p20) --[[ Line: 165 ]]
    if p20 == nil then
    else
        local v21 = p20.Size.X / 2;
        p20.CFrame = CFrame.new(p17, p17 + p18) * CFrame.new(0, 0, -(p19 - v21)) * CFrame.Angles(0, -1.5707963267948966, 0) * (p16.StateInfo.TotalRuntime < 0.01 and CFrame.new(Vector3.new(1.2816772, -0.39396667, -2.9963074)) or CFrame.new());
    end;
end;
function u3.Update(p22) --[[ Line: 174 ]]
    -- upvalues: u3 (copy), l__UserInputService__2 (copy), l__Players__5 (copy)
    if u3.ViewModel then
        u3.ViewModel.RootPart.CFrame = game.Workspace.CurrentCamera.CFrame;
        local v23 = tick() * 10 * 1.3;
        local v24 = math.sin(v23) * 0.5;
        local v25 = tick() * 5 * 1.3;
        local v26 = math.sin(v25) * 0.5;
        local v27 = tick() * 5 * 1.3;
        local v28 = math.sin(v27) * 0.5;
        local v29 = Vector3.new(v24, v26, v28);
        local v30 = l__UserInputService__2:GetMouseDelta();
        local v31 = l__Players__5.LocalPlayer.Character or l__Players__5.LocalPlayer.CharacterAdded:Wait();
        if v31:FindFirstChild("HumanoidRootPart") then
            u3.BobbleSpring:shove(v29 / 10 * v31.HumanoidRootPart.Velocity.Magnitude / 10);
            u3.SwayingSpring:shove((Vector3.new(-v30.X / 500, v30.Y / 200, 0)));
            local v32 = u3.BobbleSpring:update(p22);
            local v33 = u3.SwayingSpring:update(p22);
            u3.ViewModel.RootPart.CFrame = u3.ViewModel.RootPart.CFrame:ToWorldSpace(CFrame.new(v32.Y, v32.X, 0)) * CFrame.new(v33.X, v33.Y, 0);
        end;
    end;
end;
function u3.ToggleGui(p34) --[[ Line: 195 ]]
    -- upvalues: u3 (copy), l__UserInputService__2 (copy)
    u3.ReticleGui.Enabled = p34;
    l__UserInputService__2.MouseIconEnabled = not p34;
end;
function u3.ShowHitmarker() --[[ Line: 200 ]]
    -- upvalues: u3 (copy)
    task.delay(0.1, function() --[[ Line: 201 ]]
        -- upvalues: u3 (ref)
        u3.ReticleGui.HitSound:Play();
    end);
    if u3.HitmarkerScaleTween.PlaybackState == Enum.PlaybackState.Playing then
        u3.HitmarkerScaleTween:Cancel();
    end;
    if u3.HitmarkerTransparencyTween.PlaybackState == Enum.PlaybackState.Playing then
        u3.HitmarkerTransparencyTween:Cancel();
    end;
    u3.ReticleGui.Hitmarker.GroupTransparency = 0;
    u3.ReticleGui.Hitmarker.UIScale.Scale = 2;
    u3.HitmarkerScaleTween:Play();
    u3.HitmarkerTransparencyTween:Play();
end;
function u3.SetupUI() --[[ Line: 219 ]]
    -- upvalues: l__Players__5 (copy), u3 (copy), l__TweenService__7 (copy)
    local l__ReticleGui__17 = l__Players__5.LocalPlayer.PlayerGui:WaitForChild("ReticleGui");
    local v35 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local v36 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    u3.ReticleGui = l__ReticleGui__17;
    u3.HitmarkerScaleTween = l__TweenService__7:Create(l__ReticleGui__17.Hitmarker.UIScale, v35, {
        Scale = 1
    });
    u3.HitmarkerTransparencyTween = l__TweenService__7:Create(l__ReticleGui__17.Hitmarker, v36, {
        GroupTransparency = 1
    });
end;
function u3.SetupCast() --[[ Line: 231 ]]
    -- upvalues: l__FastCastRedux__10 (copy), l__CollectionService__4 (copy), u3 (copy), l__Players__5 (copy), l__ReplicatedStorage__3 (copy)
    local v37 = workspace:FindFirstChild("CosmeticBulletsFolder") or Instance.new("Folder", workspace);
    v37.Name = "CosmeticBulletsFolder";
    local v38 = l__FastCastRedux__10.new();
    local v39 = l__CollectionService__4:GetTagged("IgnoreOnRay");
    local u40 = RaycastParams.new();
    u40.FilterType = Enum.RaycastFilterType.Exclude;
    u40.FilterDescendantsInstances = v39;
    l__CollectionService__4:GetInstanceAddedSignal("IgnoreOnRay"):Connect(function(p41) --[[ Line: 242 ]]
        -- upvalues: u40 (copy)
        u40:AddToFilter(p41);
    end);
    u3.CastParams = u40;
    u40:AddToFilter(l__Players__5.LocalPlayer.Character or l__Players__5.LocalPlayer.CharacterAdded:Wait());
    local v42 = l__FastCastRedux__10.newBehavior();
    v42.RaycastParams = u40;
    v42.MaxDistance = 900;
    v42.HighFidelityBehavior = l__FastCastRedux__10.HighFidelityBehavior.Default;
    v42.CosmeticBulletTemplate = l__ReplicatedStorage__3:WaitForChild("Assets"):WaitForChild("Spawnables"):WaitForChild("ToyDart"):WaitForChild("Base");
    v42.CosmeticBulletContainer = v37;
    v42.Acceleration = Vector3.new(0, -workspace.Gravity, 0);
    v42.AutoIgnoreContainer = false;
    u3.CastBehavior = v42;
    u3.Caster = v38;
    v38.RayHit:Connect(u3.DartHit);
    v38.LengthChanged:Connect(u3.UpdateDart);
    v38.CastTerminating:Connect(u3.DartTerminate);
    l__Players__5.LocalPlayer.CharacterAdded:Connect(function(...) --[[ Line: 268 ]]
        -- upvalues: u40 (copy)
        u40:AddToFilter(...);
    end);
end;
function u3.Setup() --[[ Line: 273 ]]
    -- upvalues: u3 (copy), u1 (copy)
    u3.SetupCast();
    u3.SetupUI();
    u1.Component(u3);
end;
return u3;
