-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.InvRelated.OpeningHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
game:GetService("StarterGui");
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__6 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Spring__7 = require(l__ReplicatedStorage__1.Modules.Spring);
local l__Spring2D__8 = require(l__ReplicatedStorage__1.Modules.Spring2D);
local l__Simulate__9 = require(l__ReplicatedStorage__1.Modules.Simulate);
local l__RarityUtil__10 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
local u1 = l__Mince__5:Get("Bobbing");
l__Mince__5:Get("Voicelines");
local u2 = l__Mince__5:Get("BindManager");
local u3 = l__Mince__5:Get("SoundHandler");
local u4 = l__Mince__5:Get("SelectInteractor");
local u5 = l__Mince__5:Get("InterfaceHandler");
local u6 = l__Mince__5:Get("Inventory");
local u7 = l__Mince__5:Get("ConfettiController");
local u8 = l__Mince__5:GetEvent("ResolvePending");
local u9 = l__Mince__5:GetEvent("DoClientOpening");
local u10 = {
    Maid = l__Maid__4.new(),
    NextClose = l__Signal__6.new(),
    States = {},
    Tweens = {
        GenericTween = TweenInfo.new(0.3),
        BlurTween = TweenInfo.new(1.3, Enum.EasingStyle.Quint),
        TextOpenTween = TweenInfo.new(0.1, Enum.EasingStyle.Quint),
        Collapse = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
        ChestDropTween = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
        ContainerIn = TweenInfo.new(2.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        ContainerDropout = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        AuraSpin = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1),
        SpeedSlow = TweenInfo.new(0.3)
    }
};
function u10.DismissCapsuleOpening(u11) --[[ Line: 49 ]]
    -- upvalues: u4 (copy), u5 (copy), u10 (copy), u8 (copy), l__TweenService__2 (copy)
    u4.EndInteractions();
    u5.Pop();
    u10.MainPriority.Enabled = true;
    u10.NextClose:Fire();
    u8:Fire("Lootbox");
    if u11.Extras then
        for _, v12 in u11.Extras do
            v12:Destroy();
        end;
    end;
    u10.Maid:Clean();
    u10.Interface.FullViewport.Visible = false;
    u11.ThisEgg.Duplicate.Visible = false;
    u10.Interface.ClickDetector.Visible = false;
    u10.States.CapsuleOpeningActive = false;
    u10.Interface.Dismiss.Visible = false;
    u11.ThisEgg.ItemName.Visible = false;
    l__TweenService__2:Create(u11.Blur, u10.Tweens.BlurTween, {
        Size = 0
    }):Play();
    u11.CenterSpring:SetTarget(Vector2.new(0.5, 1.5));
    l__TweenService__2:Create(u11.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__2:Create(u11.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 1
    }):Play();
    task.delay(1, u5.Pop);
    task.delay(4, function() --[[ Line: 77 ]]
        -- upvalues: u11 (copy)
        u11.ThisEgg:Destroy();
        for _, v13 in u11.Events do
            v13:Disconnect();
        end;
    end);
end;
function u10.DoItemGain(p14) --[[ Line: 85 ]]
    -- upvalues: u6 (copy), u10 (copy), l__ReplicatedStorage__1 (copy), l__RarityUtil__10 (copy), l__Signal__6 (copy), u5 (copy), u4 (copy), l__Spring2D__8 (copy), l__Spring__7 (copy), l__RunService__3 (copy), l__TweenService__2 (copy), u3 (copy)
    local v15 = p14 or {
        IVID = u6.GetRandomIVID()
    };
    local u16 = u6.Items[v15.IVID];
    if not u16 then
        error((`Cannot load any config for the IVID of '{v15.IVID}'!`));
    end;
    if u10.States.CapsuleOpeningActive then
        error("Opening already active!");
    end;
    u10.States.CapsuleOpeningActive = true;
    local u17 = {
        ThisEgg = l__ReplicatedStorage__1.Assets.Interface.EggItem:Clone(),
        Events = {},
        ExitTweens = {},
        Rarity = l__RarityUtil__10.GetRarity(u16.Rarity),
        Cleanup = l__Signal__6.new(),
        IsDuplicate = u6.MoreThanLast1IVID(v15.IVID),
        Blur = Instance.new("BlurEffect", game.Lighting)
    };
    u10.MainPriority.Enabled = false;
    u5.Push(true);
    u4.StartInteractions();
    u17.Blur.Size = 0;
    u17.ThisEgg.Position = UDim2.fromScale(0.5, 1.5);
    u17.ThisEgg.Parent = u10.Interface;
    u17.ThisEgg.Item.Image = u16.Render;
    Random.new(os.clock());
    local v18 = u17.Rarity.GetColors();
    u17.ThisEgg.AuraR.Gradient.Color = v18.Graident;
    u17.ThisEgg.AuraL.Gradient.Color = v18.Graident;
    TweenInfo.new(1.2, Enum.EasingStyle.Linear);
    local _ = Vector2.new(math.random() * 2 - 1, 1) * Vector2.new(0.8, -2);
    u17.RotSpring = l__Spring2D__8.new(0.5, 2, 0);
    u17.RotSpring:setGoal(0);
    u17.CenterSpring = l__Spring__7.new(0.02, 0.2, 3, Vector2.one * 0.5);
    u17.CenterSpring.Position = Vector2.new(0.5, 1.5);
    u17.CenterSpring:SetTarget(Vector2.new(0.5, 0.5));
    u17.Events.Update = l__RunService__3.Heartbeat:Connect(function(p19) --[[ Line: 135 ]]
        -- upvalues: u17 (copy)
        u17.RotSpring:step(p19);
        u17.CenterSpring:Update(p19);
        local l__Position__11 = u17.CenterSpring.Position;
        u17.ThisEgg.Position = UDim2.fromScale(l__Position__11.X, l__Position__11.Y);
        u17.ThisEgg.Rotation = u17.RotSpring.p;
    end);
    u17.ThisEgg.Container.Visible = false;
    u17.ThisEgg.Item.Visible = true;
    l__TweenService__2:Create(u17.Blur, u10.Tweens.BlurTween, {
        Size = 24
    }):Play();
    l__TweenService__2:Create(u17.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u17.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u17.ThisEgg.AuraR, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u17.ThisEgg.AuraL, u10.Tweens.AuraSpin, {
        Rotation = 0
    }):Play();
    l__TweenService__2:Create(u17.ThisEgg.AuraR.Gradient, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u17.ThisEgg.AuraL.Gradient, u10.Tweens.AuraSpin, {
        Rotation = -360
    }):Play();
    u3.PlaySound("Reward");
    task.delay(1, function() --[[ Line: 173 ]]
        -- upvalues: u16 (copy), u17 (copy), u3 (ref)
        if u16.Category.DontAllowDuplicates then
            if u17.IsDuplicate then
                u3.PlaySound("Duplicate");
                u17.ThisEgg.Duplicate.Visible = true;
            end;
        end;
    end);
    local l__Size__12 = u17.ThisEgg.Item.Size;
    u17.ThisEgg.Item.Size = UDim2.fromScale(l__Size__12.X.Scale * 0.6, l__Size__12.Y.Scale * 0.6);
    local v20 = l__TweenService__2:Create(u17.ThisEgg.Item, u10.Tweens.ChestDropTween, {
        Size = l__Size__12
    });
    v20:Play();
    v20.Completed:Wait();
    local l__Size__13 = u17.ThisEgg.ItemName.Size;
    u17.ThisEgg.ItemName.Text = u16.Name;
    u17.ThisEgg.ItemName.Visible = false;
    u17.ThisEgg.ItemName.Size = UDim2.fromScale(l__Size__13.X.Scale, 0);
    task.wait(0.5);
    u17.ThisEgg.ItemName.Visible = true;
    local v21 = l__TweenService__2:Create(u17.ThisEgg.ItemName, u10.Tweens.TextOpenTween, {
        Size = l__Size__13
    });
    v21:Play();
    v21.Completed:Wait();
    u10.Interface.Dismiss.Visible = true;
    u10.Interface.ClickDetector.Visible = true;
    u17.Events.ClickDetector = u10.Interface.ClickDetector.MouseButton1Down:Once(function() --[[ Line: 204 ]]
        -- upvalues: u10 (ref), u17 (copy)
        u10.DismissCapsuleOpening(u17);
    end);
end;
function u10.StartHalloOpening(p22) --[[ Line: 212 ]]
    -- upvalues: u6 (copy), u10 (copy), l__ReplicatedStorage__1 (copy), l__RarityUtil__10 (copy), l__Signal__6 (copy), l__TweenService__2 (copy), u5 (copy), u4 (copy), l__RunService__3 (copy), u1 (copy), u3 (copy), l__Spring2D__8 (copy), l__Spring__7 (copy)
    local v23 = p22 or {
        IVID = u6.GetRandomIVID()
    };
    local u24 = u6.Items[v23.IVID];
    if not u24 then
        error((`Cannot load any config for the IVID of '{v23.IVID}'!`));
    end;
    if u10.States.CapsuleOpeningActive then
        error("Opening already active!");
    end;
    u10.States.CapsuleOpeningActive = true;
    u10.Interface.FullViewport.Visible = true;
    local u25 = {
        Lootbox = l__ReplicatedStorage__1.Assets.Extras.Lootbox2:Clone(),
        ThisEgg = l__ReplicatedStorage__1.Assets.Interface.EggItem:Clone(),
        Extras = {},
        Events = {},
        ExitTweens = {},
        Rarity = l__RarityUtil__10.GetRarity(u24.Rarity),
        Cleanup = l__Signal__6.new(),
        IsDuplicate = u6.MoreThanLast1IVID(v23.IVID),
        Blur = Instance.new("BlurEffect", game.Lighting),
        Bloom = Instance.new("BloomEffect", game.Lighting),
        ColorCorrection = Instance.new("ColorCorrectionEffect", game.Lighting)
    };
    u10.Interface.FullViewport.ImageTransparency = 0;
    u25.Lootbox.Parent = u10.Interface.FullViewport.WorldModel;
    u25.ViewportCamera = Instance.new("Camera");
    u25.ViewportCamera.FieldOfView = 100;
    u10.Maid:Add(u25.Blur);
    u10.Maid:Add(u25.Lootbox);
    u10.Maid:Add(u25.ViewportCamera);
    u10.Interface.FullViewport.CurrentCamera = u25.ViewportCamera;
    local l__Position__14 = u25.Lootbox.PrimaryPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 2, -6))).Position;
    u25.ViewportCamera.CFrame = CFrame.new(l__Position__14, u25.Lootbox.PrimaryPart.Position) + Vector3.new(0, 1, 0);
    u25.Animations = {};
    for _, v26 in u25.Lootbox.Animations:GetChildren() do
        u25.Animations[v26.Name] = u25.Lootbox.AnimationController.Animator:LoadAnimation(v26);
    end;
    u25.Blur:SetAttribute("IgnoreEnvironment", true);
    u25.Bloom:SetAttribute("IgnoreEnvironment", true);
    u25.ColorCorrection:SetAttribute("IgnoreEnvironment", true);
    l__TweenService__2:Create(u25.Blur, u10.Tweens.BlurTween, {
        Size = 24
    }):Play();
    u10.MainPriority.Enabled = false;
    u5.Push(true);
    u4.StartInteractions();
    u25.Blur.Size = 0;
    u25.ThisEgg.Position = UDim2.fromScale(0.5, 1.5);
    u25.ThisEgg.Parent = u10.Interface;
    u25.ThisEgg.Item.Image = u24.Render;
    local v27 = math.clamp(u25.Rarity.Order - 1, 1, 4);
    local l__CurrentCamera__15 = game.Workspace.CurrentCamera;
    local u28 = nil;
    local function v39() --[[ Line: 295 ]]
        -- upvalues: u28 (ref), l__RunService__3 (ref), u25 (copy), u1 (ref), l__CurrentCamera__15 (copy)
        local u29 = 0;
        u28 = l__RunService__3.RenderStepped:Connect(function(p30) --[[ Line: 297 ]]
            -- upvalues: u29 (ref), u25 (ref), u1 (ref), l__CurrentCamera__15 (ref)
            u29 = u29 + p30 * 1.5;
            local v31 = u29 * 3.5;
            local v32 = math.noise(v31, 0);
            local v33 = math.noise(0, v31);
            local v34 = Vector3.new(v32, v33, math.noise(v31, v31)) * 0.1 * u29;
            local v35 = v34 * 10;
            local v36 = v34 * 0.002;
            local v37 = CFrame.new(v35) * CFrame.Angles(math.deg(v36.X), math.deg(v36.Y), (math.deg(v36.Z)));
            u25.ColorCorrection.Brightness = u29 * 0.25;
            u1.SetFOVMult(1 - u29 * 0.05);
            local v38 = l__CurrentCamera__15;
            v38.CFrame = v38.CFrame * v37;
        end);
    end;
    local u40 = 0;
    local u41 = u3.PlaySound("OpeningLoop");
    u41.PlaybackSpeed = 0;
    u41.Volume = 0;
    u41.Looped = true;
    local v43 = l__RunService__3.Heartbeat:Connect(function(p42) --[[ Line: 326 ]]
        -- upvalues: u40 (ref), u41 (copy), u25 (copy)
        u40 = u40 + p42;
        u41.PlaybackSpeed = u40 * 0.1 + 0.1;
        u41.Volume = u40 * 0.5 + 1;
        u25.ColorCorrection.Saturation = p42 * 1.2;
        u25.ColorCorrection.Contrast = p42 * 0.6;
    end);
    local v44, v45 = table.unpack(({
        { "OpeningCommon", "Common" },
        { "OpeningRare", "Rare" },
        { "OpeningEpic", "Epic" },
        { "OpeningLegend", "Legend" }
    })[v27]);
    u3.PlaySound(v44);
    u25.Animations[v45]:Play();
    u25.Animations[v45]:GetMarkerReachedSignal("Start"):Once(v39);
    u25.Animations[v45]:GetMarkerReachedSignal("Pause"):Wait();
    v43:Disconnect();
    l__TweenService__2:Create(u41, TweenInfo.new(0.1), {
        PlaybackSpeed = 0,
        Volume = 0
    }):Play();
    if u28 then
        task.delay(0.1, function() --[[ Line: 353 ]]
            -- upvalues: u28 (ref), u1 (ref)
            u28:Disconnect();
            u1.SetFOVMult(1);
        end);
    end;
    u25.Bloom:Destroy();
    u25.ColorCorrection:Destroy();
    l__TweenService__2:Create(u10.Interface.FullViewport, u10.Tweens.GenericTween, {
        ImageTransparency = 1
    }):Play();
    Random.new(os.clock());
    local v46 = u25.Rarity.GetColors();
    u25.ThisEgg.AuraR.Gradient.Color = v46.Graident;
    u25.ThisEgg.AuraL.Gradient.Color = v46.Graident;
    TweenInfo.new(1.2, Enum.EasingStyle.Linear);
    local _ = Vector2.new(math.random() * 2 - 1, 1) * Vector2.new(0.8, -2);
    u25.RotSpring = l__Spring2D__8.new(0.5, 2, 0);
    u25.RotSpring:setGoal(0);
    u25.CenterSpring = l__Spring__7.new(0.2, 0.5, 3, Vector2.one * 0.5);
    u25.CenterSpring.Position = Vector2.new(0.5, 0.5);
    u25.CenterSpring:Push(Vector2.new(0, -0.2));
    u25.CenterSpring:SetTarget(Vector2.new(0.5, 0.5));
    u25.Events.Update = l__RunService__3.Heartbeat:Connect(function(p47) --[[ Line: 380 ]]
        -- upvalues: u25 (copy)
        u25.RotSpring:step(p47);
        u25.CenterSpring:Update(p47);
        local l__Position__16 = u25.CenterSpring.Position;
        u25.ThisEgg.Position = UDim2.fromScale(l__Position__16.X, l__Position__16.Y);
        u25.ThisEgg.Rotation = u25.RotSpring.p;
    end);
    u25.ThisEgg.Container.Visible = false;
    u25.ThisEgg.Item.Visible = true;
    l__TweenService__2:Create(u25.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u25.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u25.ThisEgg.AuraR, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u25.ThisEgg.AuraL, u10.Tweens.AuraSpin, {
        Rotation = 0
    }):Play();
    l__TweenService__2:Create(u25.ThisEgg.AuraR.Gradient, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u25.ThisEgg.AuraL.Gradient, u10.Tweens.AuraSpin, {
        Rotation = -360
    }):Play();
    u3.PlaySound((`Reward{v27}`));
    u10.ConfettiHost.UpdateColors(u25.Rarity.RarityColorArray());
    u10.ConfettiHost.StartConfetti(0.5);
    task.delay(1, function() --[[ Line: 419 ]]
        -- upvalues: u24 (copy), u25 (copy), u3 (ref)
        if u24.Category.DontAllowDuplicates then
            if u25.IsDuplicate then
                u3.PlaySound("Duplicate");
                u25.ThisEgg.Duplicate.Visible = true;
            end;
        end;
    end);
    local l__Size__17 = u25.ThisEgg.Item.Size;
    u25.ThisEgg.Item.Size = UDim2.fromScale(l__Size__17.X.Scale * 0.6, l__Size__17.Y.Scale * 0.6);
    local v48 = l__TweenService__2:Create(u25.ThisEgg.Item, u10.Tweens.ChestDropTween, {
        Size = l__Size__17
    });
    v48:Play();
    v48.Completed:Wait();
    local l__Size__18 = u25.ThisEgg.ItemName.Size;
    u25.ThisEgg.ItemName.Text = u24.Name;
    u25.ThisEgg.ItemName.Visible = false;
    u25.ThisEgg.ItemName.Size = UDim2.fromScale(l__Size__18.X.Scale, 0);
    task.wait(0.5);
    u25.ThisEgg.ItemName.Visible = true;
    local v49 = l__TweenService__2:Create(u25.ThisEgg.ItemName, u10.Tweens.TextOpenTween, {
        Size = l__Size__18
    });
    v49:Play();
    v49.Completed:Wait();
    u10.Interface.Dismiss.Visible = true;
    u10.Interface.ClickDetector.Visible = true;
    u25.Events.ClickDetector = u10.Interface.ClickDetector.MouseButton1Down:Once(function() --[[ Line: 450 ]]
        -- upvalues: u10 (ref), u25 (copy)
        u10.DismissCapsuleOpening(u25);
    end);
end;
function u10.StartPresentOpening(p50) --[[ Line: 455 ]]
    -- upvalues: u6 (copy), u10 (copy), u3 (copy), l__ReplicatedStorage__1 (copy), l__RarityUtil__10 (copy), l__Signal__6 (copy), l__TweenService__2 (copy), u5 (copy), u4 (copy), l__RunService__3 (copy), u1 (copy), l__Spring2D__8 (copy), l__Spring__7 (copy)
    local v51 = p50 or {
        IVID = u6.GetRandomIVID()
    };
    local u52 = u6.Items[v51.IVID];
    if not u52 then
        error((`Cannot load any config for the IVID of '{v51.IVID}'!`));
    end;
    if u10.States.CapsuleOpeningActive then
        error("Opening already active!");
    end;
    u10.States.CapsuleOpeningActive = true;
    u10.Interface.FullViewport.Visible = true;
    u3.PlaySound("OpenAnn");
    local u53 = {
        Lootbox = l__ReplicatedStorage__1.Assets.Extras.Lootbox1:Clone(),
        ThisEgg = l__ReplicatedStorage__1.Assets.Interface.EggItem:Clone(),
        Extras = {},
        Events = {},
        ExitTweens = {},
        Rarity = l__RarityUtil__10.GetRarity(u52.Rarity),
        Cleanup = l__Signal__6.new(),
        IsDuplicate = u6.MoreThanLast1IVID(v51.IVID),
        Blur = Instance.new("BlurEffect", game.Lighting),
        Bloom = Instance.new("BloomEffect", game.Lighting),
        ColorCorrection = Instance.new("ColorCorrectionEffect", game.Lighting)
    };
    u10.Interface.FullViewport.ImageTransparency = 0;
    u53.Lootbox.Parent = u10.Interface.FullViewport.WorldModel;
    u53.ViewportCamera = Instance.new("Camera");
    u53.ViewportCamera.FieldOfView = 100;
    u10.Maid:Add(u53.Lootbox);
    u10.Maid:Add(u53.ViewportCamera);
    u10.Interface.FullViewport.CurrentCamera = u53.ViewportCamera;
    local l__Position__19 = u53.Lootbox.PrimaryPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 2, 6))).Position;
    u53.ViewportCamera.CFrame = CFrame.new(l__Position__19, u53.Lootbox.PrimaryPart.Position) + Vector3.new(0, 1, 0);
    u53.Animations = {};
    for _, v54 in u53.Lootbox.Animations:GetChildren() do
        u53.Animations[v54.Name] = u53.Lootbox.AnimationController.Animator:LoadAnimation(v54);
    end;
    u53.Animations.Open:Play();
    u53.Blur:SetAttribute("IgnoreEnvironment", true);
    u53.Bloom:SetAttribute("IgnoreEnvironment", true);
    u53.ColorCorrection:SetAttribute("IgnoreEnvironment", true);
    l__TweenService__2:Create(u53.Blur, u10.Tweens.BlurTween, {
        Size = 24
    }):Play();
    u10.MainPriority.Enabled = false;
    u5.Push(true);
    u4.StartInteractions();
    u53.Blur.Size = 0;
    u53.ThisEgg.Position = UDim2.fromScale(0.5, 1.5);
    u53.ThisEgg.Parent = u10.Interface;
    u53.ThisEgg.Item.Image = u52.Render;
    local l__CurrentCamera__20 = game.Workspace.CurrentCamera;
    local u55 = nil;
    u53.Animations.Open:GetMarkerReachedSignal("Start"):Once(function() --[[ Line: 527 ]]
        -- upvalues: u55 (ref), l__RunService__3 (ref), u53 (copy), u1 (ref), l__CurrentCamera__20 (copy)
        local u56 = 0;
        u55 = l__RunService__3.RenderStepped:Connect(function(p57) --[[ Line: 529 ]]
            -- upvalues: u56 (ref), u53 (ref), u1 (ref), l__CurrentCamera__20 (ref)
            u56 = u56 + p57 * 1.5;
            local v58 = u56 * 3.5;
            local v59 = math.noise(v58, 0);
            local v60 = math.noise(0, v58);
            local v61 = Vector3.new(v59, v60, math.noise(v58, v58)) * 0.1 * u56;
            local v62 = v61 * 10;
            local v63 = v61 * 0.002;
            local v64 = CFrame.new(v62) * CFrame.Angles(math.deg(v63.X), math.deg(v63.Y), (math.deg(v63.Z)));
            u53.ColorCorrection.Brightness = u56 * 0.25;
            u1.SetFOVMult(1 - u56 * 0.05);
            local v65 = l__CurrentCamera__20;
            v65.CFrame = v65.CFrame * v64;
        end);
    end);
    u53.Animations.Open:GetMarkerReachedSignal("Pause"):Wait();
    u53.Bloom:Destroy();
    u53.ColorCorrection:Destroy();
    if u55 then
        task.delay(0.1, function() --[[ Line: 558 ]]
            -- upvalues: u55 (ref), u1 (ref)
            u55:Disconnect();
            u1.SetFOVMult(1);
        end);
    end;
    l__TweenService__2:Create(u10.Interface.FullViewport, u10.Tweens.GenericTween, {
        ImageTransparency = 1
    }):Play();
    Random.new(os.clock());
    local v66 = u53.Rarity.GetColors();
    u53.ThisEgg.AuraR.Gradient.Color = v66.Graident;
    u53.ThisEgg.AuraL.Gradient.Color = v66.Graident;
    TweenInfo.new(1.2, Enum.EasingStyle.Linear);
    local _ = Vector2.new(math.random() * 2 - 1, 1) * Vector2.new(0.8, -2);
    u53.RotSpring = l__Spring2D__8.new(0.5, 2, 0);
    u53.RotSpring:setGoal(0);
    u53.CenterSpring = l__Spring__7.new(0.2, 0.5, 3, Vector2.one * 0.5);
    u53.CenterSpring.Position = Vector2.new(0.5, 0.5);
    u53.CenterSpring:Push(Vector2.new(0, -0.2));
    u53.CenterSpring:SetTarget(Vector2.new(0.5, 0.5));
    u53.Events.Update = l__RunService__3.Heartbeat:Connect(function(p67) --[[ Line: 581 ]]
        -- upvalues: u53 (copy)
        u53.RotSpring:step(p67);
        u53.CenterSpring:Update(p67);
        local l__Position__21 = u53.CenterSpring.Position;
        u53.ThisEgg.Position = UDim2.fromScale(l__Position__21.X, l__Position__21.Y);
        u53.ThisEgg.Rotation = u53.RotSpring.p;
    end);
    u53.ThisEgg.Container.Visible = false;
    u53.ThisEgg.Item.Visible = true;
    l__TweenService__2:Create(u53.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u53.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u53.ThisEgg.AuraR, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u53.ThisEgg.AuraL, u10.Tweens.AuraSpin, {
        Rotation = 0
    }):Play();
    l__TweenService__2:Create(u53.ThisEgg.AuraR.Gradient, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u53.ThisEgg.AuraL.Gradient, u10.Tweens.AuraSpin, {
        Rotation = -360
    }):Play();
    u3.PlaySound("Reward_Ann");
    u10.ConfettiHost.UpdateColors(u53.Rarity.RarityColorArray());
    u10.ConfettiHost.StartConfetti(0.5);
    task.delay(1, function() --[[ Line: 620 ]]
        -- upvalues: u52 (copy), u53 (copy), u3 (ref)
        if u52.Category.DontAllowDuplicates then
            if u53.IsDuplicate then
                u3.PlaySound("Duplicate");
                u53.ThisEgg.Duplicate.Visible = true;
            end;
        end;
    end);
    local l__Size__22 = u53.ThisEgg.Item.Size;
    u53.ThisEgg.Item.Size = UDim2.fromScale(l__Size__22.X.Scale * 0.6, l__Size__22.Y.Scale * 0.6);
    local v68 = l__TweenService__2:Create(u53.ThisEgg.Item, u10.Tweens.ChestDropTween, {
        Size = l__Size__22
    });
    v68:Play();
    v68.Completed:Wait();
    local l__Size__23 = u53.ThisEgg.ItemName.Size;
    u53.ThisEgg.ItemName.Text = u52.Name;
    u53.ThisEgg.ItemName.Visible = false;
    u53.ThisEgg.ItemName.Size = UDim2.fromScale(l__Size__23.X.Scale, 0);
    task.wait(0.5);
    u53.ThisEgg.ItemName.Visible = true;
    local v69 = l__TweenService__2:Create(u53.ThisEgg.ItemName, u10.Tweens.TextOpenTween, {
        Size = l__Size__23
    });
    v69:Play();
    v69.Completed:Wait();
    u10.Interface.Dismiss.Visible = true;
    u10.Interface.ClickDetector.Visible = true;
    u53.Events.ClickDetector = u10.Interface.ClickDetector.MouseButton1Down:Once(function() --[[ Line: 651 ]]
        -- upvalues: u10 (ref), u53 (copy)
        u10.DismissCapsuleOpening(u53);
    end);
end;
function u10.StartChristmasPresentOpening(p70) --[[ Line: 656 ]]
    -- upvalues: u6 (copy), u10 (copy), u3 (copy), l__ReplicatedStorage__1 (copy), l__RarityUtil__10 (copy), l__Signal__6 (copy), l__TweenService__2 (copy), u5 (copy), u4 (copy), l__RunService__3 (copy), u1 (copy), l__Spring2D__8 (copy), l__Spring__7 (copy)
    local v71 = p70 or {
        IVID = u6.GetRandomIVID()
    };
    local u72 = u6.Items[v71.IVID];
    if not u72 then
        error((`Cannot load any config for the IVID of '{v71.IVID}'!`));
    end;
    if u10.States.CapsuleOpeningActive then
        error("Opening already active!");
    end;
    u10.States.CapsuleOpeningActive = true;
    u10.Interface.FullViewport.Visible = true;
    u3.PlaySound("OpenAnn");
    local u73 = {
        Lootbox = l__ReplicatedStorage__1.Assets.Extras.Lootbox3:Clone(),
        ThisEgg = l__ReplicatedStorage__1.Assets.Interface.EggItem:Clone(),
        Extras = {},
        Events = {},
        ExitTweens = {},
        Rarity = l__RarityUtil__10.GetRarity(u72.Rarity),
        Cleanup = l__Signal__6.new(),
        IsDuplicate = u6.MoreThanLast1IVID(v71.IVID),
        Blur = Instance.new("BlurEffect", game.Lighting),
        Bloom = Instance.new("BloomEffect", game.Lighting),
        ColorCorrection = Instance.new("ColorCorrectionEffect", game.Lighting)
    };
    u10.Interface.FullViewport.ImageTransparency = 0;
    u73.Lootbox.Parent = u10.Interface.FullViewport.WorldModel;
    u73.ViewportCamera = Instance.new("Camera");
    u73.ViewportCamera.FieldOfView = 100;
    u10.Maid:Add(u73.Lootbox);
    u10.Maid:Add(u73.ViewportCamera);
    u10.Interface.FullViewport.CurrentCamera = u73.ViewportCamera;
    local l__Position__24 = u73.Lootbox.PrimaryPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 2, 6))).Position;
    u73.ViewportCamera.CFrame = CFrame.new(l__Position__24, u73.Lootbox.PrimaryPart.Position) + Vector3.new(0, 1, 0);
    u73.Animations = {};
    for _, v74 in u73.Lootbox.Animations:GetChildren() do
        u73.Animations[v74.Name] = u73.Lootbox.AnimationController.Animator:LoadAnimation(v74);
    end;
    u73.Animations.Open:Play();
    u73.Blur:SetAttribute("IgnoreEnvironment", true);
    u73.Bloom:SetAttribute("IgnoreEnvironment", true);
    u73.ColorCorrection:SetAttribute("IgnoreEnvironment", true);
    l__TweenService__2:Create(u73.Blur, u10.Tweens.BlurTween, {
        Size = 24
    }):Play();
    u10.MainPriority.Enabled = false;
    u5.Push(true);
    u4.StartInteractions();
    u73.Blur.Size = 0;
    u73.ThisEgg.Position = UDim2.fromScale(0.5, 1.5);
    u73.ThisEgg.Parent = u10.Interface;
    u73.ThisEgg.Item.Image = u72.Render;
    local l__CurrentCamera__25 = game.Workspace.CurrentCamera;
    local u75 = nil;
    u73.Animations.Open:GetMarkerReachedSignal("Start"):Once(function() --[[ Line: 728 ]]
        -- upvalues: u75 (ref), l__RunService__3 (ref), u73 (copy), u1 (ref), l__CurrentCamera__25 (copy)
        local u76 = 0;
        u75 = l__RunService__3.RenderStepped:Connect(function(p77) --[[ Line: 730 ]]
            -- upvalues: u76 (ref), u73 (ref), u1 (ref), l__CurrentCamera__25 (ref)
            u76 = u76 + p77 * 1.5;
            local v78 = u76 * 3.5;
            local v79 = math.noise(v78, 0);
            local v80 = math.noise(0, v78);
            local v81 = Vector3.new(v79, v80, math.noise(v78, v78)) * 0.1 * u76;
            local v82 = v81 * 10;
            local v83 = v81 * 0.002;
            local v84 = CFrame.new(v82) * CFrame.Angles(math.deg(v83.X), math.deg(v83.Y), (math.deg(v83.Z)));
            u73.ColorCorrection.Brightness = u76 * 0.25;
            u1.SetFOVMult(1 - u76 * 0.05);
            local v85 = l__CurrentCamera__25;
            v85.CFrame = v85.CFrame * v84;
        end);
    end);
    u73.Animations.Open:GetMarkerReachedSignal("Pause"):Wait();
    u73.Bloom:Destroy();
    u73.ColorCorrection:Destroy();
    if u75 then
        task.delay(0.1, function() --[[ Line: 759 ]]
            -- upvalues: u75 (ref), u1 (ref)
            u75:Disconnect();
            u1.SetFOVMult(1);
        end);
    end;
    l__TweenService__2:Create(u10.Interface.FullViewport, u10.Tweens.GenericTween, {
        ImageTransparency = 1
    }):Play();
    Random.new(os.clock());
    local v86 = u73.Rarity.GetColors();
    u73.ThisEgg.AuraR.Gradient.Color = v86.Graident;
    u73.ThisEgg.AuraL.Gradient.Color = v86.Graident;
    TweenInfo.new(1.2, Enum.EasingStyle.Linear);
    local _ = Vector2.new(math.random() * 2 - 1, 1) * Vector2.new(0.8, -2);
    u73.RotSpring = l__Spring2D__8.new(0.5, 2, 0);
    u73.RotSpring:setGoal(0);
    u73.CenterSpring = l__Spring__7.new(0.2, 0.5, 3, Vector2.one * 0.5);
    u73.CenterSpring.Position = Vector2.new(0.5, 0.5);
    u73.CenterSpring:Push(Vector2.new(0, -0.2));
    u73.CenterSpring:SetTarget(Vector2.new(0.5, 0.5));
    u73.Events.Update = l__RunService__3.Heartbeat:Connect(function(p87) --[[ Line: 782 ]]
        -- upvalues: u73 (copy)
        u73.RotSpring:step(p87);
        u73.CenterSpring:Update(p87);
        local l__Position__26 = u73.CenterSpring.Position;
        u73.ThisEgg.Position = UDim2.fromScale(l__Position__26.X, l__Position__26.Y);
        u73.ThisEgg.Rotation = u73.RotSpring.p;
    end);
    u73.ThisEgg.Container.Visible = false;
    u73.ThisEgg.Item.Visible = true;
    l__TweenService__2:Create(u73.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u73.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u73.ThisEgg.AuraR, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u73.ThisEgg.AuraL, u10.Tweens.AuraSpin, {
        Rotation = 0
    }):Play();
    l__TweenService__2:Create(u73.ThisEgg.AuraR.Gradient, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u73.ThisEgg.AuraL.Gradient, u10.Tweens.AuraSpin, {
        Rotation = -360
    }):Play();
    u3.PlaySound("Reward_Ann");
    u10.ConfettiHost.UpdateColors(u73.Rarity.RarityColorArray());
    u10.ConfettiHost.StartConfetti(0.5);
    task.delay(1, function() --[[ Line: 821 ]]
        -- upvalues: u72 (copy), u73 (copy), u3 (ref)
        if u72.Category.DontAllowDuplicates then
            if u73.IsDuplicate then
                u3.PlaySound("Duplicate");
                u73.ThisEgg.Duplicate.Visible = true;
            end;
        end;
    end);
    local l__Size__27 = u73.ThisEgg.Item.Size;
    u73.ThisEgg.Item.Size = UDim2.fromScale(l__Size__27.X.Scale * 0.6, l__Size__27.Y.Scale * 0.6);
    local v88 = l__TweenService__2:Create(u73.ThisEgg.Item, u10.Tweens.ChestDropTween, {
        Size = l__Size__27
    });
    v88:Play();
    v88.Completed:Wait();
    local l__Size__28 = u73.ThisEgg.ItemName.Size;
    u73.ThisEgg.ItemName.Text = u72.Name;
    u73.ThisEgg.ItemName.Visible = false;
    u73.ThisEgg.ItemName.Size = UDim2.fromScale(l__Size__28.X.Scale, 0);
    task.wait(0.5);
    u73.ThisEgg.ItemName.Visible = true;
    local v89 = l__TweenService__2:Create(u73.ThisEgg.ItemName, u10.Tweens.TextOpenTween, {
        Size = l__Size__28
    });
    v89:Play();
    v89.Completed:Wait();
    u10.Interface.Dismiss.Visible = true;
    u10.Interface.ClickDetector.Visible = true;
    u73.Events.ClickDetector = u10.Interface.ClickDetector.MouseButton1Down:Once(function() --[[ Line: 852 ]]
        -- upvalues: u10 (ref), u73 (copy)
        u10.DismissCapsuleOpening(u73);
    end);
end;
function u10.StartFireworkOpening(p90) --[[ Line: 857 ]]
    -- upvalues: u6 (copy), u10 (copy), l__ReplicatedStorage__1 (copy), l__RarityUtil__10 (copy), l__Signal__6 (copy), l__TweenService__2 (copy), u5 (copy), u4 (copy), u3 (copy), l__RunService__3 (copy), l__Spring2D__8 (copy), l__Spring__7 (copy)
    local v91 = p90 or {
        IVID = u6.GetRandomIVID()
    };
    local u92 = u6.Items[v91.IVID];
    if not u92 then
        error((`Cannot load any config for the IVID of '{v91.IVID}'!`));
    end;
    if u10.States.CapsuleOpeningActive then
        error("Opening already active!");
    end;
    u10.States.CapsuleOpeningActive = true;
    local u93 = {
        ThisEgg = l__ReplicatedStorage__1.Assets.Interface.EggItem:Clone(),
        Extras = {},
        Events = {},
        ExitTweens = {},
        Rarity = l__RarityUtil__10.GetRarity(u92.Rarity),
        Cleanup = l__Signal__6.new(),
        IsDuplicate = u6.MoreThanLast1IVID(v91.IVID),
        Blur = Instance.new("BlurEffect", game.Lighting),
        Bloom = Instance.new("BloomEffect", game.Lighting),
        ColorCorrection = Instance.new("ColorCorrectionEffect", game.Lighting)
    };
    u93.Blur:SetAttribute("IgnoreEnvironment", true);
    u93.Bloom:SetAttribute("IgnoreEnvironment", true);
    u93.ColorCorrection:SetAttribute("IgnoreEnvironment", true);
    l__TweenService__2:Create(u93.Blur, u10.Tweens.BlurTween, {
        Size = 24
    }):Play();
    u10.MainPriority.Enabled = false;
    u5.Push(true);
    u4.StartInteractions();
    u93.Blur.Size = 0;
    u93.ThisEgg.Position = UDim2.fromScale(0.5, 1.5);
    u93.ThisEgg.Parent = u10.Interface;
    u93.ThisEgg.Item.Image = u92.Render;
    local u94 = u3.PlaySound("Launchloop");
    local v95 = u3.PlaySound("Drumroll");
    u94.Volume = 4;
    local l__Firework__29 = u93.ThisEgg.Firework;
    l__Firework__29.Visible = true;
    l__Firework__29.Position = UDim2.fromScale(0.5, 1);
    l__Firework__29.Parent = u10.Interface;
    l__Firework__29.Effect.Emitter:SetAttribute("Enabled", true);
    table.insert(u93.Extras, l__Firework__29);
    local u96 = math.random() * 10000;
    local u97 = 0;
    u93.Events.ExplodeAnimation = l__RunService__3.Heartbeat:Connect(function(p98) --[[ Line: 916 ]]
        -- upvalues: u97 (ref), l__TweenService__2 (ref), u96 (copy), l__Firework__29 (copy), u94 (copy), u93 (copy)
        if u97 > 2 then
        else
            u97 = u97 + p98;
            local v99 = u97 / 2;
            local v100 = 1 - v99;
            local v101 = l__TweenService__2:GetValue(v99, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
            local v102 = Vector2.new(math.noise(0, u96 + u97 * 10), math.noise(u96 + u97 * 10, 0)) * 0.1 * v99;
            l__Firework__29.Position = UDim2.fromScale(0.5 + v102.X * v100, 1 - (0.55 * v101 + v102.Y * v100 * 0.8));
            u94.PlaybackSpeed = 1 + v101;
            u93.Bloom.Size = v101 * 10;
            u93.ColorCorrection.Contrast = v101 * 0.5;
            u93.ColorCorrection.Saturation = v101 * 0.5;
        end;
    end);
    task.wait(2);
    l__Firework__29.AnchorPoint = Vector2.new(0.5, 0.5);
    l__Firework__29.Position = UDim2.fromScale(0.5, 0.5);
    l__Firework__29.Size = UDim2.fromScale(0.2, 0.2);
    l__Firework__29.ZIndex = -100000;
    l__Firework__29.Firework.Visible = false;
    l__Firework__29.Effect.Emitter:SetAttribute("Enabled", false);
    u93.Bloom:Destroy();
    u93.ColorCorrection:Destroy();
    Random.new(os.clock());
    local v103 = u93.Rarity.GetColors();
    u93.ThisEgg.AuraR.Gradient.Color = v103.Graident;
    u93.ThisEgg.AuraL.Gradient.Color = v103.Graident;
    l__Firework__29.Explode:SetAttribute("Color", v103.Graident);
    l__Firework__29.Spread:SetAttribute("Color", v103.Graident);
    l__Firework__29.Explode:SetAttribute("Enabled", true);
    l__Firework__29.Spread:SetAttribute("Enabled", true);
    task.delay(0.3, function() --[[ Line: 964 ]]
        -- upvalues: l__Firework__29 (copy)
        l__Firework__29.Spread:SetAttribute("Enabled", false);
        l__Firework__29.Explode:SetAttribute("Enabled", false);
    end);
    TweenInfo.new(1.2, Enum.EasingStyle.Linear);
    local _ = Vector2.new(math.random() * 2 - 1, 1) * Vector2.new(0.8, -2);
    u93.RotSpring = l__Spring2D__8.new(0.5, 2, 0);
    u93.RotSpring:setGoal(0);
    u93.CenterSpring = l__Spring__7.new(0.02, 0.2, 3, Vector2.one * 0.5);
    u93.CenterSpring.Position = Vector2.new(0.5, 0.7);
    u93.CenterSpring:SetTarget(Vector2.new(0.5, 0.5));
    u93.Events.Update = l__RunService__3.Heartbeat:Connect(function(p104) --[[ Line: 977 ]]
        -- upvalues: u93 (copy)
        u93.RotSpring:step(p104);
        u93.CenterSpring:Update(p104);
        local l__Position__30 = u93.CenterSpring.Position;
        u93.ThisEgg.Position = UDim2.fromScale(l__Position__30.X, l__Position__30.Y);
        u93.ThisEgg.Rotation = u93.RotSpring.p;
    end);
    u93.ThisEgg.Container.Visible = false;
    u93.ThisEgg.Item.Visible = true;
    l__TweenService__2:Create(u94, u10.Tweens.GenericTween, {
        PlaybackSpeed = 0
    }):Play();
    l__TweenService__2:Create(v95, u10.Tweens.GenericTween, {
        PlaybackSpeed = 0
    }):Play();
    l__TweenService__2:Create(u93.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u93.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u93.ThisEgg.AuraR, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u93.ThisEgg.AuraL, u10.Tweens.AuraSpin, {
        Rotation = 0
    }):Play();
    l__TweenService__2:Create(u93.ThisEgg.AuraR.Gradient, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u93.ThisEgg.AuraL.Gradient, u10.Tweens.AuraSpin, {
        Rotation = -360
    }):Play();
    u3.PlaySound("Reward_4th");
    task.delay(1, function() --[[ Line: 1022 ]]
        -- upvalues: u92 (copy), u93 (copy), u3 (ref)
        if u92.Category.DontAllowDuplicates then
            if u93.IsDuplicate then
                u3.PlaySound("Duplicate");
                u93.ThisEgg.Duplicate.Visible = true;
            end;
        end;
    end);
    local l__Size__31 = u93.ThisEgg.Item.Size;
    u93.ThisEgg.Item.Size = UDim2.fromScale(l__Size__31.X.Scale * 0.6, l__Size__31.Y.Scale * 0.6);
    local v105 = l__TweenService__2:Create(u93.ThisEgg.Item, u10.Tweens.ChestDropTween, {
        Size = l__Size__31
    });
    v105:Play();
    v105.Completed:Wait();
    local l__Size__32 = u93.ThisEgg.ItemName.Size;
    u93.ThisEgg.ItemName.Text = u92.Name;
    u93.ThisEgg.ItemName.Visible = false;
    u93.ThisEgg.ItemName.Size = UDim2.fromScale(l__Size__32.X.Scale, 0);
    task.wait(0.5);
    u93.ThisEgg.ItemName.Visible = true;
    local v106 = l__TweenService__2:Create(u93.ThisEgg.ItemName, u10.Tweens.TextOpenTween, {
        Size = l__Size__32
    });
    v106:Play();
    v106.Completed:Wait();
    u10.Interface.Dismiss.Visible = true;
    u10.Interface.ClickDetector.Visible = true;
    u93.Events.ClickDetector = u10.Interface.ClickDetector.MouseButton1Down:Once(function() --[[ Line: 1053 ]]
        -- upvalues: u10 (ref), u93 (copy)
        u10.DismissCapsuleOpening(u93);
    end);
end;
function u10.StartCapsuleOpening(p107) --[[ Line: 1058 ]]
    -- upvalues: u6 (copy), u10 (copy), l__ReplicatedStorage__1 (copy), l__RarityUtil__10 (copy), l__Signal__6 (copy), u5 (copy), u4 (copy), u3 (copy), l__TweenService__2 (copy), l__Spring2D__8 (copy), l__Spring__7 (copy), l__RunService__3 (copy), l__Simulate__9 (copy)
    local v108 = p107 or {
        IVID = u6.GetRandomIVID()
    };
    v108.Colors = { Color3.new(0.2, 0.2, 1), Color3.new(0.9, 1, 1) };
    local u109 = u6.Items[v108.IVID];
    if not u109 then
        error((`Cannot load any config for the IVID of '{v108.IVID}'!`));
    end;
    if u10.States.CapsuleOpeningActive then
        error("Opening already active!");
    end;
    u10.States.CapsuleOpeningActive = true;
    local u110 = {
        ThisEgg = l__ReplicatedStorage__1.Assets.Interface.EggItem:Clone(),
        Events = {},
        ExitTweens = {},
        Rarity = l__RarityUtil__10.GetRarity(u109.Rarity),
        Cleanup = l__Signal__6.new(),
        IsDuplicate = u6.MoreThanLast1IVID(v108.IVID),
        Blur = Instance.new("BlurEffect", game.Lighting)
    };
    u110.Blur:SetAttribute("IgnoreEnvironment", true);
    u10.MainPriority.Enabled = false;
    u5.Push(true);
    u4.StartInteractions();
    u110.Blur.Size = 0;
    u110.ThisEgg.Container.TopHalf.ImageColor3 = v108.Colors[1];
    u110.ThisEgg.Container.BottomHalf.ImageColor3 = v108.Colors[2];
    u110.ThisEgg.Position = UDim2.fromScale(0.5, 1.5);
    u110.ThisEgg.Parent = u10.Interface;
    u110.ThisEgg.Item.Image = u109.Render;
    local v111 = u3.PlaySound("Drumroll");
    l__TweenService__2:Create(u110.Blur, u10.Tweens.BlurTween, {
        Size = 24
    }):Play();
    u110.RotSpring = l__Spring2D__8.new(0.5, 2, 0);
    u110.RotSpring:setGoal(0);
    u110.CenterSpring = l__Spring__7.new(0.02, 0.2, 3, Vector2.one * 0.5);
    u110.CenterSpring.Position = Vector2.new(0.5, 1.5);
    u110.CenterSpring:SetTarget(Vector2.new(0.5, 0.5));
    u110.Events.Update = l__RunService__3.Heartbeat:Connect(function(p112) --[[ Line: 1107 ]]
        -- upvalues: u110 (copy)
        u110.RotSpring:step(p112);
        u110.CenterSpring:Update(p112);
        local l__Position__33 = u110.CenterSpring.Position;
        u110.ThisEgg.Position = UDim2.fromScale(l__Position__33.X, l__Position__33.Y);
        u110.ThisEgg.Rotation = u110.RotSpring.p;
    end);
    task.wait(1.5);
    local v113 = Random.new(os.clock());
    for _ = 1, 3 do
        local l__Unit__34 = v113:NextUnitVector().Unit;
        u110.CenterSpring:Push(Vector2.new(l__Unit__34.X * 0.05, l__Unit__34.Y * 0.05));
        u110.RotSpring:push(l__Unit__34.Z * 1000);
        u3.PlaySound("Swing");
        task.wait(0.7);
    end;
    local v114 = u110.Rarity.GetColors();
    u110.ThisEgg.AuraR.Gradient.Color = v114.Graident;
    u110.ThisEgg.AuraL.Gradient.Color = v114.Graident;
    local v115 = TweenInfo.new(1.2, Enum.EasingStyle.Linear);
    local v116 = Vector2.new(math.random() * 2 - 1, 1) * Vector2.new(0.8, -2);
    l__Simulate__9.new(u110.ThisEgg.Container.TopHalf, v116, -0.1);
    l__Simulate__9.new(u110.ThisEgg.Container.BottomHalf, Vector2.new(1), -0.1);
    l__TweenService__2:Create(u110.ThisEgg.Container.TopHalf, v115, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.Container.BottomHalf, v115, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.Container, u10.Tweens.Collapse, {
        Size = UDim2.fromScale(u110.ThisEgg.Container.Size.X.Scale * 0.8, u110.ThisEgg.Container.Size.Y.Scale * 0.8)
    }):Play();
    l__TweenService__2:Create(v111, u10.Tweens.GenericTween, {
        PlaybackSpeed = 0
    }):Play();
    u110.ThisEgg.Item.Visible = true;
    l__TweenService__2:Create(u110.ThisEgg.AuraR, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.AuraL, u10.Tweens.GenericTween, {
        ImageTransparency = 0.7
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.AuraR, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.AuraL, u10.Tweens.AuraSpin, {
        Rotation = 0
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.AuraR.Gradient, u10.Tweens.AuraSpin, {
        Rotation = 360
    }):Play();
    l__TweenService__2:Create(u110.ThisEgg.AuraL.Gradient, u10.Tweens.AuraSpin, {
        Rotation = -360
    }):Play();
    u3.PlaySound("Reward");
    task.delay(1, function() --[[ Line: 1191 ]]
        -- upvalues: u109 (copy), u110 (copy), u3 (ref)
        if u109.Category.DontAllowDuplicates then
            if u110.IsDuplicate then
                u3.PlaySound("Duplicate");
                u110.ThisEgg.Duplicate.Visible = true;
            end;
        end;
    end);
    local l__Size__35 = u110.ThisEgg.Item.Size;
    u110.ThisEgg.Item.Size = UDim2.fromScale(l__Size__35.X.Scale * 0.6, l__Size__35.Y.Scale * 0.6);
    local v117 = l__TweenService__2:Create(u110.ThisEgg.Item, u10.Tweens.ChestDropTween, {
        Size = l__Size__35
    });
    v117:Play();
    v117.Completed:Wait();
    local l__Size__36 = u110.ThisEgg.ItemName.Size;
    u110.ThisEgg.ItemName.Text = u109.Name;
    u110.ThisEgg.ItemName.Visible = true;
    u110.ThisEgg.ItemName.Size = UDim2.fromScale(l__Size__36.X.Scale, 0);
    local v118 = l__TweenService__2:Create(u110.ThisEgg.ItemName, u10.Tweens.TextOpenTween, {
        Size = l__Size__36
    });
    v118:Play();
    v118.Completed:Wait();
    u10.Interface.Dismiss.Visible = true;
    u10.Interface.ClickDetector.Visible = true;
    u110.Events.ClickDetector = u10.Interface.ClickDetector.MouseButton1Down:Once(function() --[[ Line: 1217 ]]
        -- upvalues: u10 (ref), u110 (copy)
        u10.DismissCapsuleOpening(u110);
    end);
end;
function u10.SetupText() --[[ Line: 1222 ]]
    -- upvalues: u10 (copy), u2 (copy)
    u2.ModeChanged:Connect(function(p119) --[[ Line: 1223 ]]
        -- upvalues: u10 (ref)
        if p119 == "Computer" then
            u10.Interface.Dismiss.Text = "~ Click anywhere to dismiss ~";
        elseif p119 == "Mobile" then
            u10.Interface.Dismiss.Text = "~ Tap anywhere to dismiss ~";
        else
            u10.Interface.Dismiss.Text = "~ Sorry i dont think console people can get out ~";
        end;
    end);
    local l__CurrentMode__37 = u2.CurrentMode;
    if l__CurrentMode__37 == "Computer" then
        u10.Interface.Dismiss.Text = "~ Click anywhere to dismiss ~";
    elseif l__CurrentMode__37 == "Mobile" then
        u10.Interface.Dismiss.Text = "~ Tap anywhere to dismiss ~";
    else
        u10.Interface.Dismiss.Text = "~ Sorry i dont think console people can get out ~";
    end;
end;
function u10.Setup() --[[ Line: 1236 ]]
    -- upvalues: u10 (copy), u5 (copy), u7 (copy), u9 (copy)
    u10.MainPriority = u5.GetScreenGui("MainPriority");
    u10.Interface = u5.GetScreenGui("OpeningUI");
    u10.SetupText();
    u10.ConfettiHost = u7.CreateHost(25, u10.Interface.ConfettiMain);
    u9.Event:Connect(function(p120, ...) --[[ Line: 1243 ]]
        -- upvalues: u10 (ref)
        u10[p120](...);
    end);
    u5.NewButton(u10.Interface.Spawn).Activated:Connect(function() --[[ Line: 1247 ]]
        -- upvalues: u10 (ref)
        u10.StartHalloOpening();
    end);
    local v121 = u5.NewSlider(u10.Interface.Slider);
    v121.Step = 0.25;
    u10.Rarity = 1;
    v121.Changed:Connect(function(p122) --[[ Line: 1254 ]]
        -- upvalues: u10 (ref)
        u10.Rarity = p122 * 4 + 1;
    end);
    local v123 = u5.NewSlider(u10.Interface.Slider2);
    u10.TimePosition = 0;
    v123.Changed:Connect(function(p124) --[[ Line: 1261 ]]
        -- upvalues: u10 (ref)
        u10.TimePosition = p124 - 0.5;
        u10.Interface.Info.Text = p124 - 0.5;
    end);
end;
return u10;
