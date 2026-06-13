-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
game:GetService("Debris");
local l__LocalPlayer__5 = l__Players__4.LocalPlayer;
local l__Maid__6 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Effect__8 = require(l__ReplicatedStorage__1.Modules.Effect);
require(l__ReplicatedStorage__1.Modules.Signal);
local l__InstanceCache__9 = require(l__ReplicatedStorage__1.Modules.InstanceCache);
local l__ModelTween__10 = require(script.ModelTween);
local l__EnemyContents__11 = require(script.EnemyContents);
local u1 = l__Mince__7:Get("SoundArea");
l__Mince__7:Get("Voicelines");
local u2 = l__Mince__7:Get("Indicators");
local u3 = l__Mince__7:Get("SoundHandler");
local u4 = l__Mince__7:Get("InterfaceHandler");
local u5 = l__Mince__7:Get("SelectInteractor");
local u6 = {
    _ = "ReplicatePosition",
    G = "ReactToStateChange",
    I = "Indicator",
    E = "DecodeImpacts"
};
function Average(_, p7)
    local v8 = 1;
    local v9 = 0;
    for v10 = 1, #p7 do
        v8 = v8 + 1;
        v9 = v9 + p7[v10];
    end;
    return v9 / v8;
end;
local u11 = {
    AnimationBufferTime = 0.1,
    ModeSwitchTime = 0.35,
    Percision = 10,
    CurrentScale = 0,
    MoveMode = "Walk",
    CharacterType = "Humanoid",
    RunAnimationSpeed = 22,
    LastPositionRecorded = 0,
    LastPosition = Vector3.new(1, 1, 1),
    PositionReplicated = false,
    RecordEvery = 0.05,
    States = {},
    ImpactEffects = {},
    TargetCFrame = CFrame.new(0, 0, 0),
    HitCFrame = CFrame.new(0, 0, 0),
    DropTween = TweenInfo.new(0.5, Enum.EasingStyle.Back),
    DamageOutlineTween = TweenInfo.new(0.25, Enum.EasingStyle.Exponential),
    EnemyTween = TweenInfo.new(0.35, Enum.EasingStyle.Cubic),
    HealthTween = TweenInfo.new(0.3, Enum.EasingStyle.Quad),
    DamageTween = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2),
    TextFillTween = TweenInfo.new(3, Enum.EasingStyle.Linear),
    LastModeSwitch = tick(),
    LastRecorded = tick()
};
u11.__index = u11;
function u11.Setup() --[[ Line: 77 ]]
    -- upvalues: u11 (copy), u4 (copy), l__EnemyContents__11 (copy), l__InstanceCache__9 (copy), l__ReplicatedStorage__1 (copy)
    u11.Interface = u4.GetScreenGui("Boss");
    u11.MainPriority = u4.GetScreenGui("MainPriority");
    l__EnemyContents__11.IndicatorCachce = l__InstanceCache__9.new(20, l__ReplicatedStorage__1.Assets.Models.ImpactIndicator);
end;
function u11.new(u12) --[[ Line: 85 ]]
    -- upvalues: u11 (copy)
    local u13 = u12:GetAttributes();
    u12.AttributeChanged:Connect(function(p14) --[[ Line: 87 ]]
        -- upvalues: u13 (copy), u12 (copy)
        u13[p14] = u12:GetAttribute(p14);
    end);
    local v15 = setmetatable(u13, u11);
    v15:Init(u12);
    return v15;
end;
function u11.States.Hit(p16) --[[ Line: 99 ]]
    -- upvalues: u11 (copy)
    p16.Animations.Hit:Play(u11.AnimationBufferTime);
    p16.Sounds.Attack.PlaybackSpeed = (0.9 + math.random() * 0.2) / p16.Scale;
    p16.Sounds.Attack:Play();
end;
function u11.States.Damaged(u17, p18, p19) --[[ Line: 105 ]]
    -- upvalues: l__TweenService__2 (copy), u11 (copy)
    if u17.Sounds.Hit then
        u17.Sounds.Hit:Play();
    elseif u17.Sounds.Hit1 then
        u17.Sounds[`Hit{math.random(1, 4)}`]:Play();
    end;
    u17:PlayTrack("Flinch", 2);
    if p18 then
        local l__Rotation__12 = CFrame.new(u17.ThisRoot.Position * Vector3.new(1, 0, 1), p18 * Vector3.new(1, 0, 1)).Rotation;
        u17.ThisRoot:PivotTo(CFrame.new(u17.HitCFrame.Position) * l__Rotation__12);
    end;
    if p19 then
        u17:DoEffect(p19);
    end;
    if u17.LastTweenComplete then
        u17.Highlight.Enabled = false;
        u17.LastTweenComplete:Disconnect();
    end;
    u17.Highlight.Enabled = true;
    u17.Highlight.FillTransparency = 0;
    u17.Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    local v20 = l__TweenService__2:Create(u17.Highlight, u11.DamageOutlineTween, {
        FillTransparency = 1
    });
    u17.LastTweenComplete = v20.Completed:Connect(function() --[[ Line: 137 ]]
        -- upvalues: u17 (copy)
        u17.Highlight.Enabled = false;
    end);
    v20:Play();
end;
function u11.States.DoBossSpawning(p21) --[[ Line: 144 ]]
    if p21.ShowBossUI then
        p21:DoOpeningAnimation();
    end;
end;
function u11.States.SetManualMode(p22, p23) --[[ Line: 150 ]]
    p22:SetManualMode(p23);
end;
function u11.States.PlayAnimation(p24, p25) --[[ Line: 154 ]]
    p24.Animations[p25]:Play();
end;
function u11.States.Special(p26) --[[ Line: 158 ]]
    p26.Sounds.Special:Play();
    p26.Animations.Cast:Play();
end;
function u11.States.StompAttack(p27) --[[ Line: 163 ]]
    p27.Sounds[`Attack{math.random(1, 2)}`]:Play();
    p27.Animations.Stomp:Play();
end;
function u11.States.SetMoveMode(p28, p29, p30) --[[ Line: 168 ]]
    if p28.MoveMode == p29 then
    else
        p28.MoveMode = p29;
        if p30 then
        else
            p28.LastModeSwitch = tick();
        end;
    end;
end;
function u11.States.PlayTrack(_, ...) --[[ Line: 177 ]]
    -- upvalues: u3 (copy)
    u3.PlayTrack(..., true);
end;
function u11.States.Dead(p31) --[[ Line: 181 ]]
    p31:UponDeath();
end;
function u11.UnpackCFrame(p32, p33, p34, p35) --[[ Line: 189 ]]
    local l__Percision__13 = p32.Percision;
    return CFrame.new(Vector3.new(p33.X / l__Percision__13, p33.Y / l__Percision__13, p34.X / l__Percision__13) + p35) * CFrame.Angles(0, math.rad(p34.Y / l__Percision__13), 0);
end;
function u11.ScaleCharacter(p36, p37) --[[ Line: 194 ]]
    if p37 == p36.CurrentScale then
    else
        local v38 = {};
        for _, v39 in p36.Character:GetChildren() do
            if v39:IsA("BasePart") then
                v38[v39] = v39.Color;
            end;
        end;
        local l__Humanoid__14 = p36.Humanoid;
        if l__Humanoid__14 then
            local v40 = p36.Animator:GetAppliedDescription():Clone();
            v40.DepthScale = v40.DepthScale * p37;
            v40.WidthScale = v40.WidthScale * p37;
            v40.HeightScale = v40.HeightScale * p37;
            v40.HeadScale = v40.HeadScale * p37;
            v40.BodyTypeScale = 0;
            l__Humanoid__14:ApplyDescription(v40);
            for v41, v42 in v38 do
                v41.Color = v42;
            end;
            for _, v43 in p36.Welds do
                for v44, v45 in v43 do
                    local l__Part0__15 = v45.Part0;
                    local l__Part1__16 = v45.Part1;
                    v44.Size = v44.Size * p37;
                    local v46 = v44:FindFirstChildOfClass("SpecialMesh");
                    if v46 then
                        v46.Scale = v46.Scale * p37;
                    end;
                    v45.C0 = CFrame.new(v45.C0.p * p37) * v45.C0.Rotation;
                    v45.Part0 = l__Part0__15;
                    v45.Part1 = l__Part1__16;
                    v45.Parent = v44;
                end;
            end;
            local l__HealthbarGui__17 = p36.HealthbarGui;
            if l__HealthbarGui__17 then
                l__HealthbarGui__17.StudsOffsetWorldSpace = l__HealthbarGui__17.StudsOffsetWorldSpace * p37;
                l__HealthbarGui__17.MaxDistance = l__HealthbarGui__17.MaxDistance * p37;
                l__HealthbarGui__17.Size = UDim2.fromScale(l__HealthbarGui__17.Size.X.Scale * p37, l__HealthbarGui__17.Size.Y.Scale * p37);
            end;
            p36:UpdateSize(p37);
        end;
    end;
end;
function u11.GetFeetPosition(p47) --[[ Line: 258 ]]
    local v48, v49 = p47.Character:GetBoundingBox();
    return (v48 * CFrame.new(0, -v49.Y / 2, 0)).Position;
end;
function u11.GetBodyCenterPosition(p50) --[[ Line: 265 ]]
    local v51, _ = p50.Character:GetBoundingBox();
    return v51.Position;
end;
function u11.GetBodyTopPosition(p52) --[[ Line: 270 ]]
    local v53, v54 = p52.Character:GetBoundingBox();
    return (v53 * CFrame.new(0, v54.Y / 2, 0)).Position;
end;
function u11.UpdateSize(p55, p56) --[[ Line: 277 ]]
    local v57, v58 = p55.Character:GetBoundingBox();
    p55.Height = p55.ThisRoot.Position.Y - (v57.Y - v58.Y / 2);
    p55.Height = p55.Height + (p55.HeightOffset or 0);
    if p56 then
        p55.CurrentScale = p56;
    end;
end;
function u11.CreateExtents(p59) --[[ Line: 286 ]]
    p59.ExtrasFolder = Instance.new("Folder");
    p59.ExtrasFolder.Name = "Extras";
    p59.ExtrasFolder.Parent = p59.Instance;
    p59.ProjectileFolder = Instance.new("Folder");
    p59.ProjectileFolder.Name = "Projectiles";
    p59.ProjectileFolder.Parent = p59.Instance;
    p59.Replication = p59.Instance:WaitForChild("Replication");
end;
function u11.AttachCharacter(p60, p61) --[[ Line: 298 ]]
    p60.Character = p61;
    p60.Character.Parent = p60.Instance;
    p60.AnimationFolder = p60.Character:WaitForChild("Animations");
    p60.SoundFolder = p60.Character:WaitForChild("Sounds");
    p60.Humanoid = p60.Character:FindFirstChild("Humanoid");
    if p60.Humanoid then
        p60.Humanoid.NameDisplayDistance = 0;
        p60.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    else
        p60.AnimationController = p61:WaitForChild("AnimationController");
    end;
    if p60.AnimationController then
        p60.Animator = p60.AnimationController:WaitForChild("Animator");
    elseif p60.Humanoid then
        p60.Animator = p60.Humanoid:WaitForChild("Animator");
    else
        error("Could not find an animator!");
    end;
    p60.HumanoidRootPart = p60.Character:FindFirstChild("HumanoidRootPart");
    if p60.HumanoidRootPart then
        p60.ThisRoot = p60.HumanoidRootPart;
    else
        p60.ThisRoot = p60.Character:WaitForChild("RootPart");
    end;
    p60.ThisRoot.Anchored = true;
    p60:UpdateSize();
    p60:CreateModelAttachments();
    task.wait();
    p60:MountCharacterStuff();
    p60:ScaleCharacter(p60.Scale);
end;
function u11.UpdateHealthBar(p62) --[[ Line: 341 ]]
    -- upvalues: l__TweenService__2 (copy), u11 (copy)
    local l__Healthbar__18 = p62.Healthbar;
    local v63 = math.clamp(p62.Health / p62.MaxHealth, 0, 1);
    l__TweenService__2:Create(l__Healthbar__18.Container.Bar.Fill, u11.HealthTween, {
        Size = UDim2.new(v63, 0, 1, 0)
    }):Play();
    l__TweenService__2:Create(l__Healthbar__18.Container.Bar.Overlap, u11.DamageTween, {
        Size = UDim2.new(v63, 0, 1, 0)
    }):Play();
    l__Healthbar__18.Container.Bar.Health.Text = `{p62.Health} / {p62.MaxHealth}`;
    if u11.Interface.Container and p62.ShowBossUI then
        l__TweenService__2:Create(u11.Interface.Container.Bar.Fill, u11.HealthTween, {
            Size = UDim2.new(v63, 0, 1, 0)
        }):Play();
        l__TweenService__2:Create(u11.Interface.Container.Bar.Overlap, u11.DamageTween, {
            Size = UDim2.new(v63, 0, 1, 0)
        }):Play();
        u11.Interface.Container.Bar.Health.Text = `{p62.Health} / {p62.MaxHealth}`;
    end;
end;
function u11.CreateModelAttachments(p64) --[[ Line: 368 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u3 (copy)
    p64.Highlight = Instance.new("Highlight", p64.Character);
    p64.Highlight.OutlineTransparency = 1;
    p64.Highlight.FillTransparency = 1;
    p64.Highlight.Enabled = false;
    p64.Healthbar = l__ReplicatedStorage__1.Assets.Models.EnemyHealthbar:Clone();
    p64.Healthbar.Parent = p64.ThisRoot;
    p64.Healthbar.Container.EnemyText.Text = `Lvl.{p64.Level or -1} {p64.Name or "Enemy.Name"}`;
    p64.Healthbar.Enabled = not p64.HideHealthbar;
    if p64.SoundFolder then
        for _, v65 in p64.SoundFolder:GetChildren() do
            local v66 = v65:Clone();
            v66.SoundGroup = u3.GetSoundGroup("SFX");
            v66.Parent = p64.ThisRoot;
            p64.Sounds[v65.Name] = v66;
        end;
    end;
    if p64.Sounds.Gobble then
        p64.Sounds.Gobble:Play();
    end;
end;
function u11.Indicator(p67, p68, p69) --[[ Line: 394 ]]
    -- upvalues: u2 (copy)
    u2.NewIndicator(p67:GetBodyTopPosition(), p69, p68 or "<ERROR>");
end;
function u11.UpdateCharacter(p70, _) --[[ Line: 398 ]]
    if p70.DontAutoMove then
        print("noautomove");
    else
        local v71 = (tick() - p70.LastPositionRecorded) * 60;
        local v72 = (p70.LastPosition - p70.ThisRoot.Position).Magnitude * v71;
        local v73 = v72 * 60;
        if Average(v73, p70.LastStudsMemory) > (p70.MoveMode == "Run" and 1.5 or 1) then
            if p70.AutoMoveMode then
                p70:PlayTrack(p70.AutoMoveMode);
            elseif p70.MoveMode == "Walk" and p70:ModeSwitchCheck() then
                p70:StopTrack("Run");
                p70:PlayTrack("Walk");
                p70:ModeCheck("Walk");
            elseif p70.MoveMode == "Run" and p70:ModeSwitchCheck() then
                p70:StopTrack("Walk");
                p70:PlayTrack("Run");
                p70:ModeCheck("Run");
            end;
        else
            p70:StopTrack("Walk");
            p70:StopTrack("Run");
            p70:ModeCheck("Stand");
        end;
        p70.Animations.Walk:AdjustSpeed(v72 * 5);
        if tick() - p70.LastRecorded > p70.RecordEvery then
            p70.LastRecorded = tick();
            for v74 = 1, #p70.LastStudsMemory - 1 do
                p70.LastStudsMemory[v74 + 1] = p70.LastStudsMemory[v74];
            end;
            p70.LastStudsMemory[1] = v73;
        end;
        p70.LastPositionRecorded = tick();
        p70.LastPosition = p70.ThisRoot.Position;
    end;
end;
function u11.StopTrack(p75, p76) --[[ Line: 450 ]]
    -- upvalues: u11 (copy)
    local v77 = p75.Animations[p76];
    if v77 and v77.IsPlaying then
        v77:Stop(u11.AnimationBufferTime);
    end;
end;
function u11.PlayTrack(p78, p79, p80) --[[ Line: 460 ]]
    -- upvalues: u11 (copy)
    local v81 = p78.Animations[p79];
    if v81 and not v81.IsPlaying then
        v81:Play(u11.AnimationBufferTime);
        if p80 then
            v81:AdjustSpeed(p80);
        end;
    end;
end;
function u11.SetManualMode(p82, p83) --[[ Line: 475 ]]
    if p83 == p82.AutoMoveMode then
    else
        p82:StopTrack("Walk");
        p82:StopTrack("Run");
        p82:PlayTrack(p83);
        p82.AutoMoveMode = p83;
    end;
end;
function u11.ModeCheck(p84, p85) --[[ Line: 485 ]]
    if p85 ~= p84.LastMode then
        p84.LastModeSwitch = tick();
    end;
    p84.LastMode = p85;
end;
function u11.ModeSwitchCheck(p86) --[[ Line: 493 ]]
    -- upvalues: u11 (copy)
    return tick() - p86.LastModeSwitch > u11.ModeSwitchTime;
end;
function u11.MountCharacterStuff(p87) --[[ Line: 503 ]]
    for _, v88 in p87.Character:GetDescendants() do
        if v88:IsA("BasePart") then
            v88.CollisionGroup = "Enemies";
        end;
    end;
    for _, v89 in p87.Character:GetChildren() do
        if v89:IsA("BasePart") then
            v89.CanCollide = false;
            p87.Welds[v89] = {};
            for _, v90 in v89:GetDescendants() do
                if v90:IsA("BasePart") then
                    local v91 = Instance.new("Weld");
                    v91.Part0 = v90;
                    v91.Part1 = v89;
                    v91.C0 = v90.CFrame:ToObjectSpace(v89.CFrame);
                    v91.Parent = v90;
                    v90.Anchored = false;
                    p87.Welds[v89][v90] = v91;
                end;
            end;
        end;
    end;
    for _, v92 in p87.AnimationFolder:GetChildren() do
        p87.Animations[v92.Name] = p87.Animator:LoadAnimation(v92);
    end;
    p87.Animations.Idle:Play();
end;
function u11.ReplicatePosition(p93, p94, p95) --[[ Line: 542 ]]
    -- upvalues: l__Effect__8 (copy), l__ReplicatedStorage__1 (copy), l__ModelTween__10 (copy), u11 (copy)
    if p93.DoesNotReplicate then
    else
        local v96 = p93:UnpackCFrame(p94, p95, p93.Height * Vector3.new(0, 1, 0));
        p93.LastCFrame = p93.TargetCFrame;
        p93.TargetCFrame = v96;
        p93.HitCFrame = v96;
        if p93.CharacterType == "Humanoid" then
            if not p93.PositionReplicated then
                p93.PositionReplicated = true;
                p93.ThisRoot:PivotTo(v96);
                l__Effect__8.new(l__ReplicatedStorage__1.Assets.Particles.Effects.Poof, v96.Position, Vector3.new(1, 1, 1)):PlayThenDestroy(10);
                return;
            end;
            l__ModelTween__10.new(p93.ThisRoot, u11.EnemyTween, v96):Play();
        end;
    end;
end;
function u11.GetImpactEffect(_, p97) --[[ Line: 571 ]]
    -- upvalues: u11 (copy)
    local v98 = u11.ImpactEffects[p97];
    if v98 then
        return v98;
    else
        local v99 = script.Impacts:FindFirstChild(p97);
        if v99 then
            u11.ImpactEffects[p97] = require(v99);
            return u11.ImpactEffects[p97];
        else
            u11.ImpactEffects[p97] = false;
            return false;
        end;
    end;
end;
function u11.DecodeImpacts(u100, p101) --[[ Line: 588 ]]
    -- upvalues: l__EnemyContents__11 (copy), u11 (copy), l__LocalPlayer__5 (copy), l__RunService__3 (copy)
    local v102 = string.packsize("I1bI1i2i2i2I2I1n");
    local v103 = {
        [1] = true,
        [0] = false
    };
    for v104 = 1, #p101, v102 do
        local v105 = p101:sub(v104, v104 + v102);
        local v106, v107, v108, v109, v110, v111, v112, v113, v114 = string.unpack("I1bI1i2i2i2I2I1n", v105);
        local v115 = v103[v107];
        local v116 = l__EnemyContents__11.EffectNames[v108];
        local v117 = Vector3.new(v109 / 10, v110 / 10, v111 / 10);
        local u118 = u11:GetImpactEffect(v116);
        if u118 then
            local u119 = {
                BufferRadius = 0,
                Position = v117,
                CreatedOn = game.Workspace:GetServerTimeNow(),
                Name = v116,
                IsTelegraphed = v115,
                Timestamp = v114,
                Radius = v106,
                Damage = v112,
                ImpactEffector = Vector3.new(1, v113 / 10, 1),
                Events = {}
            };
            local v120 = v114 - game.Workspace:GetServerTimeNow();
            u119.TimeUntilImpact = math.max(0, v120);
            if u118.Init then
                local _, _ = pcall(function() --[[ Line: 620 ]]
                    -- upvalues: u118 (copy), u100 (copy), u119 (ref)
                    return u118.Init(u100, u119);
                end);
            end;
            u119.Duration = u119.Timestamp - u119.CreatedOn;
            function u119.Destroy() --[[ Line: 627 ]]
                -- upvalues: u119 (ref)
                for _, v121 in u119.Events do
                    v121:Disconnect();
                end;
                u119 = nil;
            end;
            function u119.DoSpawning() --[[ Line: 634 ]]
                -- upvalues: u119 (ref), l__LocalPlayer__5 (ref), u100 (copy), u118 (copy)
                if u119 and not u119.Completed then
                    u119.Completed = true;
                    local l__Character__19 = l__LocalPlayer__5.Character;
                    if l__Character__19 then
                        l__Character__19 = l__LocalPlayer__5.Character:FindFirstChild("HumanoidRootPart");
                    end;
                    if l__Character__19 and (l__Character__19.Position * u119.ImpactEffector - (u119.HitPosition or u119.Position) * u119.ImpactEffector).Magnitude < u119.Radius - u119.BufferRadius then
                        u100.ClientEnemyReportedDamage:Fire(u119.Damage);
                    end;
                    local v122, v123 = pcall(function() --[[ Line: 651 ]]
                        -- upvalues: u118 (ref), u100 (ref), u119 (ref)
                        return u118.Spawn(u100, u119);
                    end);
                    if not v122 then
                        warn(v123);
                    end;
                    task.wait(2);
                    u119.Destroy();
                end;
            end;
            if u119.IsTelegraphed then
                local v124 = l__EnemyContents__11.IndicatorCachce:Get(u100.ExtrasFolder);
                v124.Position = u119.Position + Vector3.new(0, 1, 0) * v124.Size * 0.5;
                v124.Mesh.Scale = Vector3.new(0.102, 0.5, 0.102) * (v106 / v124.Size.X) * 2;
                u119.Indicator = v124;
            end;
            task.defer(function() --[[ Line: 673 ]]
                -- upvalues: u118 (copy), u119 (ref), u100 (copy), l__RunService__3 (ref), l__EnemyContents__11 (ref)
                local u125 = u118.ProOffset or 0;
                local u126 = game.Workspace:GetServerTimeNow() + u125;
                local v127 = u119.Timestamp - game.Workspace:GetServerTimeNow();
                local u128 = 0;
                local u129 = v127 - u125;
                local u130 = coroutine.running();
                local v135, v136 = pcall(function() --[[ Line: 681 ]]
                    -- upvalues: u125 (copy), u118 (ref), u100 (ref), u119 (ref), l__RunService__3 (ref), u126 (copy), u129 (ref), u130 (copy), u128 (ref)
                    if u125 ~= 0 then
                        task.wait(u125);
                    end;
                    if u118.Progress then
                        pcall(u118.Progress, u100, u119, 0);
                    end;
                    local u131 = nil;
                    u131 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 690 ]]
                        -- upvalues: u126 (ref), u129 (ref), u118 (ref), u100 (ref), u119 (ref), u130 (ref), u131 (ref), u128 (ref)
                        local v132 = u126 - game.Workspace:GetServerTimeNow();
                        local v133 = math.abs(v132) / u129;
                        local v134 = math.clamp(v133, 0, 1);
                        if u118.Progress then
                            u118.Progress(u100, u119, v134);
                        end;
                        if v134 >= 1 then
                            task.defer(u130);
                            u131:Disconnect();
                        else
                            u128 = task.wait();
                        end;
                    end);
                end);
                if v135 then
                    coroutine.yield();
                else
                    warn(v136);
                end;
                if u119.Indicator then
                    u119.Indicator.Position = Vector3.new(-0, -100, -0);
                    l__EnemyContents__11.IndicatorCachce:Free(u119.Indicator);
                end;
                if u118.Spawn then
                    u119.DoSpawning();
                end;
            end);
        else
            warn((`There is no ImpactEffect for '{v116}'.`));
        end;
    end;
end;
function u11.ReactToStateChange(p137, p138, ...) --[[ Line: 730 ]]
    local v139 = p137.States[p138];
    if v139 then
        v139(p137, ...);
        p137.LastState = p138;
    else
        warn(`There is no state function to handle '{p138}. -->:`, ...);
    end;
end;
function u11.UponDeath(u140) --[[ Line: 742 ]]
    -- upvalues: u11 (copy), l__Effect__8 (copy), l__ReplicatedStorage__1 (copy), u3 (copy), u1 (copy)
    u140.IsDying = true;
    if not u140.IsActive then
        u140:Sleep(false);
    end;
    for _, v141 in u140.Animator:GetPlayingAnimationTracks() do
        v141:Stop();
    end;
    u140.Healthbar.Enabled = false;
    u11.Interface.Container.Bar.GroupTransparency = 1;
    u11.Interface.Container.EnemyText.Text = "";
    u11.Interface.Container.EnemyText.MaxVisibleGraphemes = 0;
    if u140.Sounds.Hit then
        u140.Sounds.Hit:Play();
    elseif u140.Sounds.Hit1 then
        u140.Sounds[`Hit{math.random(1, 4)}`]:Play();
    end;
    u140.Sounds.Death:Play();
    u140:Disconnect();
    u140.Animations.Death:Play();
    u140.Animations.Death.Stopped:Once(function() --[[ Line: 778 ]]
        -- upvalues: u140 (copy)
        u140.Animations.Death:Play();
        u140.Animations.Death:AdjustSpeed(0);
        u140.Animations.Death.TimePosition = u140.Animations.Death.Length - 0.01;
    end);
    u140.Animations.Death.Stopped:Wait();
    task.wait(3);
    l__Effect__8.new(l__ReplicatedStorage__1.Assets.Particles.Effects.Poof, u140:GetBodyCenterPosition(), Vector3.new(1, 1, 1)):PlayThenDestroy(10);
    u140:Destroy();
    u3.StopAllTracks();
    u1.RestartTracks();
end;
function u11.Destroy(p142) --[[ Line: 797 ]]
    if p142.Destroyed then
    else
        p142:Disconnect();
        p142.Destroyed = true;
        p142.Character:Destroy();
        if p142.Instance.Parent ~= nil then
            p142.Instance:Destroy();
        end;
        p142.Destroying:Fire();
    end;
end;
function u11.Disconnect(p143) --[[ Line: 808 ]]
    p143.Maid:Clean();
end;
function u11.Sleep(p144, p145) --[[ Line: 812 ]]
    if p144.IsDying then
    elseif p144.Instance.Parent == nil then
    elseif p144.Character.Parent == nil then
    else
        if p145 then
            p144.Character.Parent = game.ReplicatedStorage;
        else
            p144.Character.Parent = p144.Instance;
        end;
        p144.IsActive = not p145;
    end;
end;
function u11.DoOpeningAnimation(u146) --[[ Line: 826 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u3 (copy), u11 (copy), u4 (copy), u5 (copy), l__RunService__3 (copy), l__TweenService__2 (copy)
    local l__CurrentCamera__20 = game.Workspace.CurrentCamera;
    local u147 = l__ReplicatedStorage__1.Assets.Misc.HalloCutscene:Clone();
    u147.Parent = game.Workspace;
    local v148 = u147:FindFirstChildWhichIsA("Animator", true):LoadAnimation(u147.Animation);
    l__CurrentCamera__20.CameraType = Enum.CameraType.Scriptable;
    u3.StopAllTracks();
    u11.MainPriority.Enabled = false;
    u4.Push(true);
    u5.StartInteractions();
    v148:Play();
    u146.Animations.Intro:Play();
    v148:Stop();
    v148:Play();
    u3.PlaySound("CutsceneSound");
    local v149 = l__RunService__3.RenderStepped:Connect(function() --[[ Line: 847 ]]
        -- upvalues: l__CurrentCamera__20 (copy), u147 (copy), u146 (copy)
        l__CurrentCamera__20.CFrame = u147.camera.CFrame;
        u147:PivotTo(u146.Character:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0));
    end);
    u3.StopAllTracks();
    v148.Ended:Wait();
    u3.PlayTrack("Boss_Music", true);
    l__CurrentCamera__20.CameraType = Enum.CameraType.Custom;
    u147:Destroy();
    v149:Disconnect();
    u5.EndInteractions();
    u4.Pop();
    u11.MainPriority.Enabled = true;
    u11.Interface.Container.EnemyText.Text = `{u146.Name or "Enemy.Name"}`;
    u11.Interface.Container.EnemyText.MaxVisibleGraphemes = 0;
    l__TweenService__2:Create(u11.Interface.Container.EnemyText, u11.TextFillTween, {
        MaxVisibleGraphemes = #u11.Interface.Container.EnemyText.Text
    }):Play();
    task.wait(3);
    l__TweenService__2:Create(u11.Interface.Container.Bar, u11.TextFillTween, {
        GroupTransparency = 0
    }):Play();
end;
function u11.Init(u150, p151) --[[ Line: 878 ]]
    -- upvalues: l__Maid__6 (copy), l__Mince__7 (copy), l__ReplicatedStorage__1 (copy), u6 (copy), l__RunService__3 (copy)
    if p151 then
        u150.Maid = l__Maid__6.new();
        u150.Animations = {};
        u150.Sounds = {};
        u150.Welds = {};
        u150.LastStudsMemory = {
            0,
            0,
            0,
            0,
            0
        };
        u150.Destroying = l__Mince__7.Signal.new();
        u150.ClientEnemyReportedDamage = l__Mince__7.Signal.new();
        u150.IsAValidEnemy = true;
        u150.IsActive = true;
        u150.Instance = p151;
        u150:CreateExtents();
        task.wait();
        assert(u150.ModelName, "a model is needed inorder to load this character!");
        local l__ModelName__21 = u150.ModelName;
        if l__ModelName__21 then
            l__ModelName__21 = l__ReplicatedStorage__1.Assets.Enemies:FindFirstChild(u150.ModelName);
        end;
        u150:AttachCharacter(l__ModelName__21:Clone());
        task.wait();
        if u150.Character then
            local l__Character__22 = u150.Character;
            if l__Character__22 then
                l__Character__22 = u150.Character:GetPivot();
            end;
            u150.OrginPivot = l__Character__22;
        end;
        u150:UpdateHealthBar();
        u150.Maid:Add(u150.Instance:GetAttributeChangedSignal("Health"):Connect(function() --[[ Line: 913 ]]
            -- upvalues: u150 (copy)
            if u150.IsActive then
                u150:UpdateHealthBar();
            end;
        end));
        u150.Maid:Add(u150.Replication.OnClientEvent:Connect(function(p152, ...) --[[ Line: 918 ]]
            -- upvalues: u150 (copy), u6 (ref)
            if u150.IsActive then
                local v153 = u6[p152];
                if u150[v153] then
                    u150[v153](u150, ...);
                else
                    warn("dropped->", p152, ...);
                end;
            end;
        end));
        u150.Maid:Add(u150.Instance.Destroying:Connect(function() --[[ Line: 924 ]]
            -- upvalues: u150 (copy)
            if u150.IsActive then
                u150:Destroy();
            end;
        end));
        if u150.CharacterType == "Humanoid" then
            u150.Maid:Add(l__RunService__3.Heartbeat:Connect(function(p154) --[[ Line: 930 ]]
                -- upvalues: u150 (copy)
                u150:UpdateCharacter(p154);
            end));
        end;
    else
        u150.IsAValidEnemy = false;
    end;
end;
return u11;
