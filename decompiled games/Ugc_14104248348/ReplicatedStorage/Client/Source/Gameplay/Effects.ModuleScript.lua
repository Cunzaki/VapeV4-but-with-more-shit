-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Effects
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Players__3 = game:GetService("Players");
local l__Debris__4 = game:GetService("Debris");
local l__RunService__5 = game:GetService("RunService");
local l__LocalPlayer__6 = l__Players__3.LocalPlayer;
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Effect__8 = require(l__ReplicatedStorage__1.Modules.Effect);
local l__ParticleSource__9 = require(l__ReplicatedStorage__1.Modules.ParticleSource);
local l__OldParticleSource__10 = require(script.OldParticleSource);
local u1 = l__Mince__7:Get("Locomotion");
local u2 = l__Mince__7:Get("SoundHandler");
local u3 = l__Mince__7:Get("ScreenEffects");
local u4 = l__Mince__7:Get("InterfaceHandler");
local u5 = l__Mince__7:Get("Settings");
local u6 = l__Mince__7:GetEvent("SpawnGroup");
local u7 = l__Mince__7:GetEvent("SpawnEffect");
local u8 = l__Mince__7:GetEvent("RequestReset");
local u9 = l__Mince__7:GetEvent("PlayerEffects");
local u10 = {
    FireworkPosition = 1,
    DisableCameraEffects = true,
    Tweens = {
        HighlightTween = TweenInfo.new(0.3),
        FadeTween = TweenInfo.new(0.3),
        FadeTween2 = TweenInfo.new(2)
    },
    Fireworks = {}
};
function u10.CameraEffectDisabled() --[[ Line: 38 ]]
    -- upvalues: u10 (copy)
    return u10.DisableCameraEffects;
end;
function u10.SetCameraEffectsEnabled(p11) --[[ Line: 42 ]]
    -- upvalues: u10 (copy)
    u10.DisableCameraEffects = not p11;
end;
function u10.PlayBlackout(p12) --[[ Line: 46 ]]
    -- upvalues: l__TweenService__2 (copy), u10 (copy)
    l__TweenService__2:Create(u10.Blackout, u10.Tweens.FadeTween, {
        GroupTransparency = 0
    }):Play();
    task.wait(p12);
    l__TweenService__2:Create(u10.Blackout, u10.Tweens.FadeTween, {
        GroupTransparency = 1
    }):Play();
end;
function u10.ImageEffect() --[[ Line: 58 ]]
    -- upvalues: u10 (copy), l__TweenService__2 (copy)
    u10.JumpScare.ImageTransparency = 0;
    u10.JumpScare.UIScale.Scale = 1;
    l__TweenService__2:Create(u10.JumpScare, u10.Tweens.FadeTween2, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__2:Create(u10.JumpScare.UIScale, u10.Tweens.FadeTween2, {
        Scale = 0.1
    }):Play();
end;
function u10.ScarySpider() --[[ Line: 69 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__ReplicatedStorage__1 (copy), u10 (copy), l__TweenService__2 (copy), u2 (copy), l__RunService__5 (copy)
    local l__JumpscareVignette__11 = l__LocalPlayer__6.PlayerGui.MainPriority:WaitForChild("JumpscareVignette");
    local u13 = l__ReplicatedStorage__1.Assets.Extras.SpiderJumpscare:Clone();
    u13.Parent = workspace;
    local v14 = u13.AnimationController.Animator:LoadAnimation(u13.JumpscareAnim);
    repeat
        task.wait();
    until v14.Length > 0 and u13.CameraPart.Jumpscare.IsLoaded;
    v14:Play();
    task.delay(0.1, function() --[[ Line: 80 ]]
        -- upvalues: u10 (ref), l__TweenService__2 (ref), l__JumpscareVignette__11 (copy), u13 (copy), u2 (ref)
        task.defer(function() --[[ Line: 81 ]]
            -- upvalues: u10 (ref)
            u10.SharpCameraEffect({
                FieldOfView = 90
            }, 2, 0.5);
        end);
        l__TweenService__2:Create(l__JumpscareVignette__11, TweenInfo.new(0.1), {
            ImageTransparency = 0.3
        }):Play();
        u13.CameraPart.Jumpscare:Play();
        u2.PlaySound("Scare.Light");
        u2.PlaySound("Scare.Hard");
        task.wait(0.1);
        l__TweenService__2:Create(l__JumpscareVignette__11, TweenInfo.new(3), {
            ImageTransparency = 1
        }):Play();
    end);
    local v15 = l__RunService__5.RenderStepped:Connect(function(_) --[[ Line: 96 ]]
        -- upvalues: u13 (copy)
        u13.CameraPart.CFrame = workspace.CurrentCamera.CFrame;
    end);
    task.wait(v14.Length);
    v15:Disconnect();
    u13:Destroy();
end;
function u10.PopConfetti(p16) --[[ Line: 105 ]]
    -- upvalues: u5 (copy), l__Debris__4 (copy)
    local v17 = p16.Handle:Clone();
    v17.Anchored = true;
    v17.Transparency = 1;
    v17.Parent = workspace;
    for _, v18 in v17:GetChildren() do
        if v18:IsA("Weld") then
            v18:Destroy();
        end;
    end;
    local v19 = v17.Attachment:GetChildren();
    if p16:FindFirstChild("Cap") then
        p16.Cap.CanCollide = true;
        p16.Handle.CapWeld:Destroy();
    end;
    for _, v20 in p16.Handle:GetChildren() do
        if v20:IsA("Sound") then
            v20:Play();
        end;
    end;
    for _, v21 in v19 do
        v21:Emit(u5.GetValue("NoFlash") and 5 or (v21:GetAttribute("EmitCount") or 40));
    end;
    l__Debris__4:AddItem(v17, 15);
end;
function u10.FocusEffect(u22, p23) --[[ Line: 136 ]]
    -- upvalues: u10 (copy)
    if u10.CameraEffectDisabled() then
    else
        local u24 = 0;
        local u25 = p23 or 0.8;
        task.spawn(function() --[[ Line: 141 ]]
            -- upvalues: u24 (ref), u22 (copy), u25 (copy)
            repeat
                local l__CurrentCamera__12 = game.Workspace.CurrentCamera;
                local v26 = task.wait();
                u24 = u24 + v26;
                l__CurrentCamera__12.CFrame = l__CurrentCamera__12.CFrame:Lerp(CFrame.new(l__CurrentCamera__12.CFrame.Position, u22.Position), v26 * 20);
            until u25 < u24;
        end);
    end;
end;
function u10.SharpCameraEffect(p27, p28, p29) --[[ Line: 152 ]]
    -- upvalues: u10 (copy), l__TweenService__2 (copy)
    if u10.CameraEffectDisabled() then
    else
        local l__CurrentCamera__13 = game.Workspace.CurrentCamera;
        local v30 = {};
        for v31, _ in p27 do
            v30[v31] = l__CurrentCamera__13[v31];
        end;
        local v32 = TweenInfo.new(p29 or 0.05, Enum.EasingStyle.Exponential);
        local v33 = TweenInfo.new(p28 or 12, Enum.EasingStyle.Quart);
        local v34 = l__TweenService__2:Create(l__CurrentCamera__13, v32, p27);
        v34:Play();
        v34.Completed:Wait();
        l__TweenService__2:Create(l__CurrentCamera__13, v33, v30):Play();
    end;
end;
function u10.CorrectionSharpEffect(p35, p36, p37, p38) --[[ Line: 173 ]]
    -- upvalues: l__TweenService__2 (copy)
    local u39 = Instance.new("ColorCorrectionEffect", game.Lighting);
    u39:SetAttribute("IgnoreEnvironment", true);
    local v40 = {};
    for v41, _ in p35 do
        v40[v41] = u39[v41];
    end;
    local v42 = TweenInfo.new(p37 or 0.05, Enum.EasingStyle.Exponential);
    local v43 = TweenInfo.new(p36 or 15, Enum.EasingStyle.Quart);
    local v44 = l__TweenService__2:Create(u39, v42, p35);
    v44:Play();
    v44.Completed:Wait();
    if p38 then
        p38();
    end;
    local v45 = l__TweenService__2:Create(u39, v43, v40);
    v45:Play();
    v45.Completed:Connect(function() --[[ Line: 193 ]]
        -- upvalues: u39 (copy)
        u39:Destroy();
    end);
end;
function u10.ColorEffect(p46, p47) --[[ Line: 200 ]]
    -- upvalues: l__TweenService__2 (copy)
    local v48 = Color3.new(1, 1, 1);
    local u49 = Instance.new("ColorCorrectionEffect", game.Lighting);
    u49:SetAttribute("IgnoreEnvironment", true);
    local v50 = TweenInfo.new(p47 or 0.5, Enum.EasingStyle.Quint);
    u49.TintColor = p46;
    local u51 = l__TweenService__2:Create(u49, v50, {
        TintColor = v48
    });
    u51:Play();
    u51.Completed:Connect(function() --[[ Line: 215 ]]
        -- upvalues: u51 (copy), u49 (copy)
        u51:Destroy();
        u49:Destroy();
    end);
end;
function u10.BrightEffect(p52, p53) --[[ Line: 221 ]]
    -- upvalues: l__TweenService__2 (copy)
    local v54 = Color3.new(1, 1, 1);
    local u55 = Instance.new("ColorCorrectionEffect", game.Lighting);
    u55:SetAttribute("IgnoreEnvironment", true);
    local v56 = TweenInfo.new(p53 or 3, Enum.EasingStyle.Quint);
    u55.TintColor = v54;
    u55.Brightness = p52;
    local u57 = l__TweenService__2:Create(u55, v56, {
        Brightness = 0
    });
    u57:Play();
    u57.Completed:Connect(function() --[[ Line: 238 ]]
        -- upvalues: u57 (copy), u55 (copy)
        u57:Destroy();
        u55:Destroy();
    end);
end;
function u10.GetRawAttachment(p58) --[[ Line: 244 ]]
    local v59 = p58:FindFirstChild("__Attachment");
    if v59 then
        return v59;
    end;
    local v60 = Instance.new("Attachment", p58);
    v60.Name = "__Attachment";
    return v60;
end;
function u10.PlaySound(...) --[[ Line: 254 ]]
    -- upvalues: u2 (copy)
    u2.PlaySound(...);
end;
function u10.SpawnEffectset(u61, p62) --[[ Line: 258 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u5 (copy), l__Effect__8 (copy), u3 (copy), l__LocalPlayer__6 (copy), u8 (copy), u1 (copy)
    local l__Character__14 = u61.Character;
    if l__Character__14 then
        local v63 = l__Character__14:FindFirstChild("Humanoid");
        if v63 then
            v63 = v63:FindFirstChild("Animator");
        end;
        local u64 = l__Character__14:FindFirstChild("HumanoidRootPart");
        l__Character__14:FindFirstChild("LeftHand");
        l__Character__14:FindFirstChild("RightHand");
        local v65, v66 = l__Character__14:GetBoundingBox();
        local v67 = v65.Position - Vector3.new(0, v66.Y * 0.5, 0);
        local _ = u64.Position - v67;
        local u68 = l__ReplicatedStorage__1.Assets.Particles.Effectset:FindFirstChild(p62);
        if u68 then
            local v69 = {};
            local v70 = u68:FindFirstChild("Animations");
            if v70 then
                for _, v71 in v70:GetChildren() do
                    local v72 = v63:LoadAnimation(v71);
                    v72:AdjustSpeed(v71:GetAttribute("Speed") or 1);
                    v69[v72] = {
                        StartDelay = v71:GetAttribute("StartDelay") or 0
                    };
                end;
            end;
            local v73 = {};
            for _, v74 in u68.Floor:GetChildren() do
                if not (v74:GetAttribute("DisableNoFlash") and u5.GetValue("NoFlash")) then
                    local v75 = v74:Clone();
                    v75:PivotTo(CFrame.new(v67 + v75.Size * Vector3.new(0, 1, 0)) * u64.CFrame.Rotation);
                    v75.Parent = game.Workspace;
                    table.insert(v73, l__Effect__8.new(v75, v67));
                end;
            end;
            for _, v76 in u68.CharacterEffects:GetChildren() do
                local v77 = l__Character__14:FindFirstChild(v76.Name);
                if v77 then
                    local v78 = v76:Clone();
                    if v76:GetAttribute("UseLimbPos") then
                        table.insert(v73, l__Effect__8.new(v78, v77.Position));
                    else
                        table.insert(v73, l__Effect__8.new(v78, v77));
                    end;
                end;
            end;
            local u79 = u68:FindFirstChild("ScreenEffect");
            if u79 then
                task.delay(u79:GetAttribute("StartDelay") or 0, function() --[[ Line: 314 ]]
                    -- upvalues: u3 (ref), u79 (copy), u64 (copy)
                    u3.PlayAt("", u79:GetAttribute("Distance") or 40, u64.Position, u79);
                end);
            end;
            if u68:GetAttribute("KillAfter") then
                task.delay(u68:GetAttribute("KillAfter") or 0, function() --[[ Line: 320 ]]
                    -- upvalues: u61 (copy), l__LocalPlayer__6 (ref), u8 (ref), u68 (copy)
                    if u61 == l__LocalPlayer__6 then
                        u8:Fire(u68:GetAttribute("HardDeath"));
                    end;
                end);
            end;
            if u68:GetAttribute("MovementDisable") and u61 == l__LocalPlayer__6 then
                u1.SetEnabled(false);
                task.delay(u68:GetAttribute("MovementDisable"), function() --[[ Line: 329 ]]
                    -- upvalues: u1 (ref)
                    u1.SetEnabled(true);
                end);
            end;
            for u80, v81 in v69 do
                task.delay(v81.StartDelay, function() --[[ Line: 335 ]]
                    -- upvalues: u80 (copy)
                    u80:Play();
                end);
            end;
            for _, v82 in v73 do
                v82:PlayThenDestroy();
            end;
        end;
    end;
end;
function l__Effect__8.SpawnNewEffect(p83, p84) --[[ Line: 345 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__Effect__8 (copy)
    local v85 = l__ReplicatedStorage__1.Assets.Particles.Effects:FindFirstChild(p83);
    if v85 then
        l__Effect__8.new(v85, p84):PlayThenDestroy();
    else
        error("Effect NOW!" .. p83);
    end;
end;
function u10.SpawnEffect(p86, p87, ...) --[[ Line: 356 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__ParticleSource__9 (copy)
    local v88 = l__ReplicatedStorage__1.Assets.Particles.Groups:FindFirstChild(p86);
    if v88 then
        l__ParticleSource__9.CreateGroup(v88, p87, ...);
    else
        error("Effect NOW!" .. p86);
    end;
end;
function u10.Init() --[[ Line: 366 ]] end;
function u10.Emit(p89) --[[ Line: 370 ]]
    -- upvalues: l__OldParticleSource__10 (copy)
    l__OldParticleSource__10.Emit(p89, nil, true);
end;
function u10.SpawnFirecrackers(p90) --[[ Line: 374 ]]
    -- upvalues: u5 (copy)
    local v91 = p90:GetChildren();
    local u92 = 0;
    for _, u93 in pairs(v91) do
        if u92 >= 4 then
            repeat
                task.wait(0.1);
            until u92 < 2;
        end;
        u92 = u92 + 1;
        u93.Firecrackers:Play();
        for _, v94 in pairs(u93:GetChildren()) do
            if v94:IsA("ParticleEmitter") and not u5.GetValue("NoFlash") then
                v94.Enabled = true;
            end;
        end;
        task.defer(function() --[[ Line: 389 ]]
            -- upvalues: u93 (copy), u92 (ref)
            u93.Firecrackers.Ended:Wait();
            for _, v95 in pairs(u93:GetChildren()) do
                if v95:IsA("ParticleEmitter") then
                    v95.Enabled = false;
                end;
            end;
            u92 = u92 - 1;
        end);
    end;
end;
function u10.SpawnPsudeoFirework1(p96) --[[ Line: 401 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__Effect__8 (copy)
    local v97 = l__ReplicatedStorage__1.Assets.Extras.Firework1:Clone();
    v97.Parent = game.Workspace;
    v97.Position = p96;
    local v98 = math.random(100, 150);
    local v99 = math.random(-10, 10);
    local v100 = Vector3.new(v99, 0, math.random(-10, 10));
    local v101 = p96 + v98 * Vector3.new(0, 1, 0) + v100;
    local v102 = (p96 - v101).Magnitude * 0.01;
    local v103 = 0;
    repeat
        v103 = v103 + task.wait();
        v97.Position = p96:Lerp(v101, v103 / v102);
    until v102 < v103;
    l__Effect__8.new(v97.Explosion, v97.Position):PlayThenDestroy();
    v97:Destroy();
end;
function u10.SpawnFirework(p104) --[[ Line: 431 ]]
    -- upvalues: u10 (copy), l__ParticleSource__9 (copy), u5 (copy)
    local v105 = p104.Parent:GetAttributes();
    p104.Fire:Play();
    local v106 = math.random(v105.Height.Min, v105.Height.Max);
    local v107 = math.random(-v105.Spread, v105.Spread);
    local v108 = Vector3.new(v107, 0, math.random(-v105.Spread, v105.Spread));
    local v109 = p104.Position - Vector3.new(0, 2, 0);
    local v110 = v109 + v106 * Vector3.new(0, 1, 0) + v108;
    local v111 = u10;
    v111.FireworkPosition = v111.FireworkPosition + 1;
    if u10.FireworkPosition > #u10.Fireworks then
        u10.FireworkPosition = 1;
    end;
    local v112 = u10.Fireworks[u10.FireworkPosition];
    for _, v113 in v112:GetDescendants() do
        if v113:IsA("Trail") then
            v113.Enabled = false;
        end;
    end;
    v112.Projectile.Base.Trail.Enabled = false;
    v112.Projectile.Position = v109;
    v112.Explosion.Position = v109;
    task.wait(0.1);
    v112.Projectile.Base.Trail.Enabled = true;
    for _, v114 in v112:GetDescendants() do
        if v114:IsA("ParticleEmitter") or (v114:IsA("Trail") or v114:IsA("Beam")) then
            v114.Color = ColorSequence.new(v105.Color);
            if v114:IsA("Trail") then
                v114.Enabled = true;
            end;
        elseif v114:IsA("Light") then
            v114.Color = v105.Color;
        end;
    end;
    v112:ScaleTo(4.786 * v105.Scale);
    v112.Projectile.Screaming:Play();
    local v115 = (v109 - v110).Magnitude * 0.01;
    local v116 = 0;
    repeat
        v116 = v116 + task.wait();
        v112:PivotTo(CFrame.new(v109:Lerp(v110, v116 / v115)));
    until v115 < v116;
    for _, v117 in v112:GetDescendants() do
        if v117:IsA("Trail") then
            v117.Enabled = false;
        end;
    end;
    v112.Projectile.Position = Vector3.new(0, 0, 0);
    v112.Projectile.Screaming:Stop();
    v112.Explosion.Explosion:Play();
    l__ParticleSource__9.Emit(v112.Explosion, u5.GetValue("NoFlash") and 1 or 14);
    task.wait(10);
    v112.Projectile.Base.Trail.Enabled = false;
    v112:PivotTo(CFrame.new(Vector3.new(0, 0, 0)));
end;
function u10.SoulAura(p118) --[[ Line: 502 ]]
    -- upvalues: u2 (copy)
    local l__Character__15 = p118.Character;
    if l__Character__15 then
        local v119 = p118.Character:FindFirstChild("Humanoid");
        local v120 = p118.Character:FindFirstChild("HumanoidRootPart");
        if v120 and v119 then
            for _, v121 in ipairs({
                "Head",
                "LeftLowerArm",
                "RightLowerArm",
                "RightUpperLeg",
                "LeftUpperLeg"
            }) do
                local v122 = l__Character__15:FindFirstChild(v121);
                if v122 then
                    for _, v123 in game.ReplicatedStorage.Assets.Particles.Aura1:GetChildren() do
                        v123:Clone().Parent = v122;
                    end;
                end;
            end;
            local v124 = u2.GetSound("spirit_loop");
            v124.Looped = true;
            v124.Parent = v120;
            v124:Play();
        end;
    end;
end;
function u10.Invis(p125) --[[ Line: 529 ]]
    -- upvalues: l__Debris__4 (copy)
    if p125.Character then
        local v126 = p125.Character:FindFirstChild("Humanoid");
        local v127 = p125.Character:FindFirstChild("HumanoidRootPart");
        if v127 and v126 then
            local v128 = game.ReplicatedStorage.Assets.Particles.OnTapInvisible:Clone();
            v128.Parent = workspace;
            v128.CFrame = v127.CFrame;
            local v129 = Instance.new("WeldConstraint", v128);
            v129.Part1 = v128;
            v129.Part0 = v127;
            v129.Enabled = true;
            for _, u130 in v128:GetChildren() do
                if u130:IsA("ParticleEmitter") then
                    task.defer(function() --[[ Line: 547 ]]
                        -- upvalues: u130 (copy)
                        task.wait(u130:GetAttribute("EmitDelay") or 0);
                        u130:Emit(u130:GetAttribute("EmitCount"));
                    end);
                end;
            end;
            l__Debris__4:AddItem(v128, 5);
        end;
    end;
end;
function u10.CloneStaff(p131) --[[ Line: 557 ]]
    -- upvalues: l__Debris__4 (copy)
    local v132 = game.ReplicatedStorage.Assets.Particles.StaffSummonLand:Clone();
    v132.Parent = workspace;
    v132.Anchored = true;
    v132.CanCollide = false;
    v132.CFrame = p131;
    for _, u133 in v132:GetDescendants() do
        if u133:IsA("Sound") then
            u133:Play();
        end;
        if u133:IsA("ParticleEmitter") then
            task.defer(function() --[[ Line: 570 ]]
                -- upvalues: u133 (copy)
                task.wait(u133:GetAttribute("EmitDelay") or 0);
                u133:Emit(u133:GetAttribute("EmitCount"));
            end);
        end;
    end;
    l__Debris__4:AddItem(v132, 5);
end;
function u10.RefreshStaff(p134) --[[ Line: 579 ]]
    -- upvalues: l__Debris__4 (copy)
    local v135 = game.ReplicatedStorage.Assets.Particles.OnTapAvatarChange:Clone();
    v135.Parent = workspace;
    v135.Anchored = true;
    v135.CanCollide = false;
    v135.CFrame = p134;
    for _, u136 in v135:GetDescendants() do
        if u136:IsA("Sound") then
            u136:Play();
        end;
        if u136:IsA("ParticleEmitter") then
            task.defer(function() --[[ Line: 592 ]]
                -- upvalues: u136 (copy)
                task.wait(u136:GetAttribute("EmitDelay") or 0);
                u136:Emit(u136:GetAttribute("EmitCount"));
            end);
        end;
    end;
    l__Debris__4:AddItem(v135, 5);
end;
function u10.YarnCat(p137) --[[ Line: 601 ]]
    -- upvalues: l__Debris__4 (copy)
    local l__Character__16 = p137.Character;
    if l__Character__16 then
        local v138 = p137.Character:FindFirstChild("Humanoid");
        local v139 = p137.Character:FindFirstChild("HumanoidRootPart");
        if v139 and v138 then
            local v140 = game.ReplicatedStorage.Assets.Particles.OnTapCat:Clone();
            v140.Parent = workspace;
            v140.Anchored = true;
            local v141 = v140:FindFirstChild("Needle");
            local v142 = Instance.new("Animation");
            v142.AnimationId = "rbxassetid://16844886400";
            local v143 = v141.AnimationController.Animator:LoadAnimation(v142);
            if l__Character__16.Humanoid.Sit and p137 == game.Players.LocalPlayer then
                l__Character__16.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            end;
            task.wait(0.5);
            v140.CFrame = CFrame.new(v139.Position) * v140.CFrame.Rotation;
            v141:PivotTo(CFrame.new(v139.Position) * v141.PrimaryPart.CFrame.Rotation);
            for _, u144 in v140:GetChildren() do
                if u144:IsA("ParticleEmitter") then
                    task.delay(u144:GetAttribute("EmitDelay") or 0, function() --[[ Line: 626 ]]
                        -- upvalues: u144 (copy)
                        u144:Emit(u144:GetAttribute("EmitCount"));
                    end);
                end;
            end;
            task.wait(1);
            for _, v145 in pairs(v141:GetChildren()) do
                if v145:IsA("BasePart") and v145.Name ~= "RootPart" then
                    v145.Transparency = 0;
                end;
            end;
            for _, v146 in pairs(l__Character__16:GetDescendants()) do
                if v146:IsA("BasePart") then
                    v146.LocalTransparencyModifier = 1;
                end;
            end;
            v143:Play();
            task.wait(v143.Length);
            for _, v147 in pairs(v141:GetChildren()) do
                if v147:IsA("BasePart") and v147.Name ~= "RootPart" then
                    v147.LocalTransparencyModifier = 1;
                end;
            end;
            l__Debris__4:AddItem(v140, 5);
        end;
    end;
end;
function u10.Fish(p148) --[[ Line: 657 ]]
    -- upvalues: l__Debris__4 (copy)
    local l__Character__17 = p148.Character;
    if l__Character__17 then
        local v149 = p148.Character:FindFirstChild("Humanoid");
        local v150 = p148.Character:FindFirstChild("HumanoidRootPart");
        if v150 and v149 then
            local v151 = game.ReplicatedStorage.Assets.Particles.FishEffect:Clone();
            v151.Parent = workspace;
            v151.Anchored = true;
            if l__Character__17.Humanoid.Sit and p148 == game.Players.LocalPlayer then
                l__Character__17.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            end;
            task.wait(0.5);
            v151.CFrame = CFrame.new(v150.Position) * v151.CFrame.Rotation;
            for _, u152 in v151:GetDescendants() do
                if u152:IsA("ParticleEmitter") and u152:GetAttribute("ExplosionEffect") then
                    task.delay(u152:GetAttribute("EmitDelay") or 0, function() --[[ Line: 676 ]]
                        -- upvalues: u152 (copy)
                        u152:Emit(u152:GetAttribute("EmitCount"));
                    end);
                else
                    l__Debris__4:AddItem(u152, 2);
                end;
            end;
            task.wait(1);
            l__Debris__4:AddItem(v151, 5);
        end;
    end;
end;
function u10.ApplyAura(p153, p154) --[[ Line: 690 ]]
    -- upvalues: l__Debris__4 (copy), u2 (copy)
    local l__Character__18 = p153.Character;
    if l__Character__18 then
        local v155 = game.ReplicatedStorage.Assets.Particles.Auras:FindFirstChild(p154);
        if v155 then
            local v156 = p153.Character:FindFirstChild("Humanoid");
            local v157 = p153.Character:FindFirstChild("HumanoidRootPart");
            if v157 and v156 then
                for _, v158 in ipairs({
                    "Head",
                    "LeftLowerArm",
                    "RightLowerArm",
                    "RightLowerLeg",
                    "LeftLowerLeg"
                }) do
                    local v159 = l__Character__18:FindFirstChild(v158);
                    local v160 = v155:FindFirstChild(v158);
                    if v159 then
                        for _, v161 in v155.Aura:GetChildren() do
                            local v162 = v161:Clone();
                            v162.Parent = v159;
                            l__Debris__4:AddItem(v162, 60);
                        end;
                        if v160 then
                            warn("something here!");
                            for _, v163 in v160:GetChildren() do
                                local v164 = v163:Clone();
                                v164.Parent = v159;
                                l__Debris__4:AddItem(v164, 60);
                            end;
                        end;
                    end;
                end;
                local v165 = v155:GetAttribute("Loop");
                if not v165 then
                    return;
                end;
                local v166 = u2.GetSound(v165);
                v166.Looped = true;
                v166.Parent = v157;
                v166.RollOffMinDistance = 5;
                v166.RollOffMaxDistance = 30;
                v166.RollOffMode = Enum.RollOffMode.LinearSquare;
                v166:Play();
                l__Debris__4:AddItem(v166, 60);
            end;
        else
            warn((`no auragroup {p154}`));
        end;
    end;
end;
function u10.Spark(p167) --[[ Line: 747 ]]
    -- upvalues: u5 (copy), l__ReplicatedStorage__1 (copy), l__Debris__4 (copy), l__TweenService__2 (copy), u10 (copy)
    local l__Character__19 = p167.Character;
    if l__Character__19 then
        if u5.GetValue("NoFlash") then
        else
            local v168 = p167.Character:FindFirstChild("Humanoid");
            local v169 = p167.Character:FindFirstChild("HumanoidRootPart");
            if v169 and v168 then
                local u170 = Instance.new("Highlight", l__Character__19);
                u170.OutlineTransparency = 1;
                u170.FillColor = Color3.new(1, 0.917647, 0);
                u170.FillTransparency = 0;
                for _, v171 in l__ReplicatedStorage__1.Assets.Particles.Sparkle:GetChildren() do
                    local v172 = v171:Clone();
                    v172.Parent = v169;
                    l__Debris__4:AddItem(v172, 0.5);
                end;
                u170.Parent = l__Character__19;
                local v173 = l__TweenService__2:Create(u170, u10.Tweens.HighlightTween, {
                    FillTransparency = 1
                });
                v173.Completed:Connect(function() --[[ Line: 772 ]]
                    -- upvalues: u170 (copy)
                    u170:Destroy();
                end);
                v173:Play();
            end;
        end;
    end;
end;
function u10.WaterPortal(p174) --[[ Line: 780 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u2 (copy), l__ParticleSource__9 (copy), u3 (copy), l__TweenService__2 (copy), l__LocalPlayer__6 (copy), u8 (copy)
    warn("WaterPortal!", p174);
    local l__Character__20 = p174.Character;
    if l__Character__20 then
        local v175 = p174.Character:FindFirstChild("Humanoid");
        local v176 = p174.Character:FindFirstChild("HumanoidRootPart");
        if v176 and v175 then
            local v177, v178 = l__Character__20:GetBoundingBox();
            local v179 = v177.Position - Vector3.new(0, v178.Y * 0.5, 0) + Vector3.new(0, 1, 0);
            local v180 = v176.Position - v179;
            local v181 = p174.Character:FindFirstChild("HumanoidRootPart");
            v181.Anchored = true;
            local v182 = v181:Clone();
            v182.Parent = game.Workspace;
            local v183 = l__ReplicatedStorage__1.Assets.Particles.Water.WaterExplosion:Clone();
            local u184 = l__ReplicatedStorage__1.Assets.Extras.Tentacle:Clone();
            local v185 = l__ReplicatedStorage__1.Assets.Particles.Water.WaterPortal:Clone();
            v185.Parent = game.Workspace;
            v183.Parent = game.Workspace;
            v183:PivotTo(CFrame.new(v179));
            local l__Animator__21 = u184.AnimationController.Animator;
            local l__Humanoid__22 = u184:WaitForChild("Rig"):WaitForChild("Humanoid");
            local v186 = u2.PlaySound("water_sound", nil, {
                RETURN = true
            });
            v186:Play();
            v186.RollOffMaxDistance = 120;
            v186.RollOffMinDistance = 5;
            v186.Parent = v185.Base;
            task.wait();
            l__ParticleSource__9.Emit(v183);
            u3.PlayAt("PortalOpen2", 20, v182.Position);
            local _, v187 = v185:GetBoundingBox();
            local v188 = 2;
            local v189 = 0;
            repeat
                v189 = v189 + task.wait();
                local v190 = l__TweenService__2:GetValue(v189 / 2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
                local v191 = v181.Position - v180;
                v185:ScaleTo(v190 * 0.5);
                v185:PivotTo(CFrame.new(v191 - v187 * Vector3.new(0, 0.5, 0)) * v177.Rotation);
                v185.Base.Light.Range = 15 * v190;
                v185.Base.Light.Brightness = 10 * v190;
            until v188 < v189;
            u184.Parent = game.Workspace;
            if p174 == l__LocalPlayer__6 then
                game.Workspace.CurrentCamera.CameraSubject = v182;
            end;
            u184:PivotTo(CFrame.new(v179));
            l__Humanoid__22:ApplyDescription(v175:GetAppliedDescription());
            local u192 = l__Animator__21:LoadAnimation(u184.Animation);
            u192:GetMarkerReachedSignal("Under"):Connect(function() --[[ Line: 856 ]]
                -- upvalues: u192 (copy), u184 (copy)
                u192:AdjustSpeed(0);
                task.wait(0.5);
                u184:Destroy();
            end);
            u192:Play();
            task.wait(0.5);
            l__Character__20:PivotTo(l__Character__20:GetPivot() - Vector3.new(0, 10, 0));
            task.wait(4.5);
            local v193 = 0;
            local v194 = 1.3;
            repeat
                v193 = v193 + task.wait();
                local v195 = l__TweenService__2:GetValue(1 - math.clamp(v193 / 1.3, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out);
                v185:ScaleTo(v195 * 0.5 + 0.001);
                v185.Base.Light.Range = 15 * v195;
                v185.Base.Light.Brightness = 10 * v195;
            until v194 < v193;
            v185:Destroy();
            v183:Destroy();
            if p174 == l__LocalPlayer__6 then
                u8:Fire(true);
            end;
        end;
    end;
end;
function u10.PlaySoundAt(...) --[[ Line: 889 ]]
    -- upvalues: u2 (copy)
    u2.PlaySoundAt(...);
end;
function u10.OpenGate(p196) --[[ Line: 893 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u10 (copy), u2 (copy), u3 (copy), l__LocalPlayer__6 (copy), l__TweenService__2 (copy), u8 (copy)
    local l__Character__23 = p196.Character;
    if l__Character__23 then
        local v197 = p196.Character:FindFirstChild("LeftHand");
        local v198 = p196.Character:FindFirstChild("RightHand");
        local v199 = p196.Character:FindFirstChild("Humanoid");
        local v200;
        if v199 then
            v200 = v199:FindFirstChild("Animator");
        else
            v200 = v199;
        end;
        local v201 = p196.Character:FindFirstChild("HumanoidRootPart");
        if v201 and (v197 and v198) then
            local v202, v203 = l__Character__23:GetBoundingBox();
            local v204 = v202.Position - Vector3.new(0, v203.Y * 0.5, 0);
            local v205 = v201.Position - v204 + Vector3.new(0, 0.1, 0);
            local v206 = l__ReplicatedStorage__1.Assets.Particles.Gate:Clone();
            v206.Parent = game.Workspace;
            local u207 = (v200 or v199):LoadAnimation(v206.PullAnimation);
            local l__Base__24 = v206:WaitForChild("Base");
            local l__Left__25 = l__Base__24:WaitForChild("Left");
            local l__Right__26 = l__Base__24:WaitForChild("Right");
            local l__Beam__27 = l__Left__25:WaitForChild("Beam");
            local l__Beam__28 = l__Right__26:WaitForChild("Beam");
            local v208 = u10.GetRawAttachment(v197);
            local v209 = u10.GetRawAttachment(v198);
            l__Beam__27.Attachment1 = v208;
            l__Beam__28.Attachment1 = v209;
            local _, v210 = v206:GetBoundingBox();
            local v211 = u2.PlaySound("portal_loop", nil, {
                RETURN = true
            });
            v211.Looped = true;
            v211:Play();
            v211.RollOffMaxDistance = 120;
            v211.RollOffMinDistance = 5;
            v211.Parent = l__Base__24;
            v206:ScaleTo(0.01);
            v199.JumpPower = 0;
            local v212 = 3;
            local v213 = 0;
            repeat
                v213 = v213 + task.wait();
                local v214 = v213 / 3;
                local v215 = v201.Position - v205;
                v206:ScaleTo(v214);
                v206:PivotTo(CFrame.new(v215 - v210 * Vector3.new(0, 0.5, 0)) * v202.Rotation);
                v211.Volume = v214 * 10;
                l__Base__24.Light.Range = v214 * 15;
                l__Base__24.Light.Brightness = v214 * 10;
            until v212 < v213;
            u2.PlaySoundAt("portal_open", l__Base__24, { 5, 120 });
            u3.PlayAt("PortalOpen", 15, v201.Position);
            if p196 == l__LocalPlayer__6 then
                u207:GetMarkerReachedSignal("Under"):Connect(function() --[[ Line: 966 ]]
                    -- upvalues: u207 (copy)
                    u207:AdjustSpeed(0);
                end);
                u207:Play(0.3);
            end;
            v211.Volume = 10;
            l__Base__24.Light.Range = 15;
            l__Base__24.Light.Brightness = 10;
            local v216 = u2.PlaySound("soul_loop", nil, {
                RETURN = true
            });
            v216.Looped = true;
            v216.Parent = l__Base__24;
            v216:Play();
            v216.RollOffMaxDistance = 120;
            v216.RollOffMinDistance = 5;
            local v217 = u2.PlaySound("flutter_loop", nil, {
                RETURN = true
            });
            v217.Looped = true;
            v217.Parent = l__Base__24;
            v217:Play();
            v217.RollOffMaxDistance = 120;
            v217.RollOffMinDistance = 5;
            v206:ScaleTo(1);
            v201.Anchored = true;
            task.wait(4.7);
            local l__Volume__29 = v216.Volume;
            local l__Volume__30 = v217.Volume;
            local v218 = 1.3;
            local v219 = 0;
            repeat
                v219 = v219 + task.wait();
                local v220 = l__TweenService__2:GetValue(1 - math.clamp(v219 / 1.3, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out);
                v206:ScaleTo(v220 + 0.001);
                v211.Volume = 10 * v220;
                l__Base__24.Light.Range = 15 * v220;
                l__Base__24.Light.Brightness = 10 * v220;
                v216.Volume = l__Volume__29 * v220;
                v217.Volume = l__Volume__30 * v220;
            until v218 < v219;
            v216:Stop();
            v216.Looped = false;
            v217:Stop();
            v217.Looped = false;
            v211:Stop();
            v211.Looped = false;
            v206:Destroy();
            if p196 == l__LocalPlayer__6 then
                u8:Fire(true);
            end;
        end;
    end;
end;
function u10.__init(_) --[[ Line: 1032 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u10 (copy)
    if l__LocalPlayer__6.Character then
        u10.DisableCameraEffects = false;
    else
        l__LocalPlayer__6.CharacterAdded:Once(function() --[[ Line: 1037 ]]
            -- upvalues: u10 (ref)
            u10.DisableCameraEffects = false;
        end);
    end;
end;
function u10.Setup() --[[ Line: 1043 ]]
    -- upvalues: u10 (copy), u4 (copy), u6 (copy), u7 (copy), l__Effect__8 (copy), u9 (copy), u3 (copy), l__ReplicatedStorage__1 (copy), l__Mince__7 (copy), l__TweenService__2 (copy)
    u10:__init();
    u10.JumpScare = u4.GetScreenGui("MainPriority").JumpScare;
    u10.Blackout = u4.GetScreenGui("MainPriority").Blackout;
    u10.Blackout.Visible = true;
    u6.Event:Connect(u10.SpawnEffect);
    u7.Event:Connect(l__Effect__8.SpawnNewEffect);
    u9.Event:Connect(function(p221, ...) --[[ Line: 1052 ]]
        -- upvalues: u10 (ref)
        local v222 = u10[p221];
        if v222 then
            v222(...);
        end;
    end);
    u10.Play = u3.Play;
    local v223 = Instance.new("Folder", game.Workspace);
    v223.Name = "LocalFireworks";
    for _ = 1, 10 do
        local v224 = l__ReplicatedStorage__1.Assets.LNYFirework:Clone();
        v224.Parent = v223;
        v224.Projectile.Base.Trail.Enabled = false;
        v224.Projectile.Position = Vector3.new(0, 0, 0);
        v224.Explosion.Position = Vector3.new(0, 0, 0);
        table.insert(u10.Fireworks, v224);
    end;
    l__Mince__7:GetEvent("Tween"):Extend("Minigame").Event:Connect(function(p225, p226, ...) --[[ Line: 1075 ]]
        -- upvalues: l__TweenService__2 (ref)
        l__TweenService__2:Create(p225, TweenInfo.new(...), p226):Play();
    end);
end;
return u10;
