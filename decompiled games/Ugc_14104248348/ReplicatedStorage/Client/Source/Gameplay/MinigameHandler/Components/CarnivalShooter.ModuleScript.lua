-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.CarnivalShooter
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("RunService");
local l__StarterGui__4 = game:GetService("StarterGui");
local l__Mince__5 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__ModelTweenOG__6 = require(game.ReplicatedStorage.Modules.ModelTweenOG);
l__Mince__5:Get("BindManager");
local u1 = l__Mince__5:Get("SoundHandler");
local u2 = l__Mince__5:Get("InterfaceHandler");
l__Mince__5:Get("SelectInteractor");
local u3 = l__Mince__5:Get("Indicators");
local u4 = l__Mince__5:Get("DartGun");
local u5 = l__Mince__5:Get("IntyComponent");
local u6 = l__Mince__5:Get("NotifPrompt");
local u7 = l__Mince__5:Get("OpeningHandler");
l__Mince__5:Get("CoinController");
local u8 = {
    Playing = false,
    ShouldSim = false,
    Client = {},
    TargetPositions = {},
    TargetAnimations = {},
    Targets = {},
    Prizes = {}
};
function QuadraticBezier(p9, p10, p11, p12)
    return (1 - p9) ^ 2 * p10 + 2 * (1 - p9) * p9 * p11 + p9 ^ 2 * p12;
end;
function u8.Client.TimedInspect(p13, ...) --[[ Line: 42 ]]
    p13:TimedInspect(...);
end;
function u8.NewRound(u14) --[[ Line: 46 ]]
    -- upvalues: l__TweenService__2 (copy), l__ModelTweenOG__6 (copy)
    u14.TargetNum = 0;
    u14.Interface.Round.TextLabel.Text = `Round {u14.ReplicatedState.Round}`;
    local v15 = l__TweenService__2:Create(u14.Interface.Round.TextLabel, TweenInfo.new(0.5), {
        Position = UDim2.new()
    });
    v15:Play();
    v15.Completed:Once(function() --[[ Line: 53 ]]
        -- upvalues: l__TweenService__2 (ref), u14 (copy)
        task.wait(1);
        l__TweenService__2:Create(u14.Interface.Round.TextLabel, TweenInfo.new(0.5), {
            Position = UDim2.fromScale(0, -0.358)
        }):Play();
    end);
    for _, u16 in u14.Targets do
        u16.Target:RemoveTag("DartGunTarget");
        l__ModelTweenOG__6.new(u16, TweenInfo.new(0.5, Enum.EasingStyle.Quart), u16:GetPivot() - Vector3.new(0, 10, 0)).Play();
        table.remove(u14.Targets, table.find(u14.Targets, u16));
        task.delay(0.5, function() --[[ Line: 67 ]]
            -- upvalues: u16 (copy)
            u16:Destroy();
        end);
    end;
end;
function u8.TargetMissed(u17, p18, p19) --[[ Line: 73 ]]
    -- upvalues: u5 (ref)
    local v20 = false;
    for _, v21 in u17.Prizes do
        if p18:IsDescendantOf(v21) then
            v20 = v21;
        end;
    end;
    if p18:IsDescendantOf(u5.Instance) and not u17.IsDoingEmote then
        u17.IsDoingEmote = true;
        if u17.ResetThread then
            task.cancel(u17.ResetThread);
        end;
        task.defer(function() --[[ Line: 88 ]]
            -- upvalues: u5 (ref)
            u5:PlayVoiceline("HitInty", true);
        end);
        u17.ResetThread = task.delay(0.5, function() --[[ Line: 92 ]]
            -- upvalues: u17 (copy)
            u17.IsDoingEmote = false;
            u17.ResetThread = task.delay(1, function() --[[ Line: 95 ]]
                -- upvalues: u17 (ref)
                if not u17.IsDoingEmote then
                    u17.Server:SetVoiceline("HitIntyAfterLine");
                end;
            end);
        end);
        u17.Server:MissTarget();
        u5:PlayEmote("Hit");
    elseif u17.ReplicatedState.CanBuyPrize and v20 then
        u17.Server:BuyPrize(v20);
    elseif math.random(1, 4) == 1 then
        u17.Server:SetVoiceline("Miss");
        u17.Server:MissTarget();
    end;
    u17.Server:ReplicateDart({
        Target = false,
        HitPart = p18,
        CFrame = p19
    });
end;
function u8.DoSmallTarget(p22) --[[ Line: 119 ]]
    -- upvalues: l__ModelTweenOG__6 (copy)
    local l__SmallTarget__7 = p22.Instance.Targets:WaitForChild("SmallTarget");
    l__SmallTarget__7:PivotTo(p22.SmallTargetPosition * CFrame.new(0, 10, 0));
    l__SmallTarget__7:SetAttribute("Number", "Small");
    local v23 = l__ModelTweenOG__6.new(l__SmallTarget__7, TweenInfo.new(0.5, Enum.EasingStyle.Quart), p22.SmallTargetPosition);
    l__SmallTarget__7.AnimationController.Animator:LoadAnimation(l__SmallTarget__7.Animations.Idle):Play();
    v23.Play();
    task.wait(0.5);
    local v24 = l__ModelTweenOG__6.new(l__SmallTarget__7, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), p22.SmallTargetPosition * CFrame.new(0, 0, -8.98));
    v24.Play();
    p22.SmallTargetTween = v24;
end;
function u8.CleanSmallTarget(p25) --[[ Line: 141 ]]
    -- upvalues: l__ModelTweenOG__6 (copy)
    local l__SmallTarget__8 = p25.Instance.Targets:WaitForChild("SmallTarget");
    if p25.SmallTargetTween then
        p25.SmallTargetTween.Stop();
        p25.SmallTargetTween = nil;
    end;
    local v26 = l__ModelTweenOG__6.new(l__SmallTarget__8, TweenInfo.new(0.5, Enum.EasingStyle.Quart), l__SmallTarget__8:GetPivot() * CFrame.new(0, 10, 0));
    local l__Animator__9 = l__SmallTarget__8.AnimationController.Animator;
    v26.Play();
    task.wait(0.5);
    for _, v27 in l__Animator__9:GetPlayingAnimationTracks() do
        v27:Stop();
    end;
end;
function u8.TargetShot(u28, p29, p30, p31) --[[ Line: 162 ]]
    local l__Parent__10 = p29.Parent;
    u28.LastPosition = p30;
    if u28.Playing then
        u28.Server:HitTarget(l__Parent__10:GetAttribute("Number"));
        if math.random(1, 6) == 1 then
            task.defer(function() --[[ Line: 171 ]]
                -- upvalues: u28 (copy)
                u28.Server:SetVoiceline("Hit");
            end);
        end;
        u28.Server:ReplicateDart({
            HitPart = p29,
            CFrame = p31,
            Target = l__Parent__10:GetAttribute("Number")
        });
    end;
    if l__Parent__10:GetAttribute("Number") == "Small" then
    else
        p29:RemoveTag("DartGunTarget");
        table.remove(u28.Targets, table.find(u28.Targets, l__Parent__10));
        u28.TargetAnimations[l__Parent__10]:AdjustSpeed(0);
        local l__Position__11 = l__Parent__10:GetPivot().Position;
        local v32 = l__Parent__10:GetPivot().Position + Vector3.new(0, 1, 3);
        local v33 = l__Parent__10:GetPivot().Position + Vector3.new(0, -10, 4);
        local v34 = CFrame.fromOrientation(0, 1.5707963267948966, 3.3161255787892263);
        local v35 = CFrame.fromOrientation(0, 1.5707963267948966, -2.0943951023931953);
        local v36 = 0;
        repeat
            local v37 = QuadraticBezier(v36 / 0.6, l__Position__11, v32, v33);
            local v38 = v34:Lerp(v35, v36 / 0.6);
            l__Parent__10:PivotTo(CFrame.new(v37) * v38);
            v36 = v36 + task.wait();
        until v36 >= 0.6;
        u28.TargetAnimations[l__Parent__10] = nil;
        l__Parent__10:Destroy();
    end;
end;
function u8.SpawnTarget(p39, p40) --[[ Line: 213 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), l__ModelTweenOG__6 (copy)
    local v41 = l__ReplicatedStorage__3.Assets.Spawnables.BatTarget:Clone();
    v41.RootPart.Position = p39.TargetPositions[`Position{p40}`].Position - Vector3.new(0, 10, 0);
    v41.Parent = game.Workspace;
    v41:SetAttribute("Number", p40);
    local v42 = l__ModelTweenOG__6.new(v41, TweenInfo.new(0.5, Enum.EasingStyle.Quart), p39.TargetPositions[`Position{p40}`]);
    local l__Animator__12 = v41.AnimationController.Animator;
    local v43 = l__Animator__12:LoadAnimation(v41.Animations.Idle);
    local v44 = l__Animator__12:LoadAnimation(v41.Animations.Flying);
    p39.TargetAnimations[v41] = v43;
    table.insert(p39.Targets, v41);
    v44:Play();
    v42:Play();
    v42.Play();
    task.wait(0.5);
    v44:Stop(1);
    v43:Play(1);
end;
function u8.ValidateClientEntry(_) --[[ Line: 240 ]]
    -- upvalues: l__Mince__5 (copy), u6 (copy)
    if l__Mince__5.Config.LocalProfile.Holiday >= 100 then
        return true;
    end;
    u6.Display("You don\'t have enough to use this!");
    return false;
end;
function u8.Construct(p45) --[[ Line: 249 ]]
    -- upvalues: l__Mince__5 (copy), u2 (copy)
    for _, v46 in p45.Instance.Players:GetChildren() do
        p45:AddProximityJoinSource(v46:WaitForChild("Position"), (tonumber(v46.Name)));
    end;
    local l__ProximityPrompt__13 = p45.Instance.Players["1"]:FindFirstChild("Position").ProximityPrompt;
    l__ProximityPrompt__13:SetAttribute("SizeMultiplier", 2);
    l__ProximityPrompt__13.ObjectText = `Play (500 {l__Mince__5.Config.Strings.EVENT_CURRENCY_NAME})`;
    p45.Interface = u2.GetScreenGui("MainPriorityInset"):WaitForChild("DartGunScore");
    for v47 = 1, 4 do
        local v48 = p45.Instance.Targets[v47];
        p45.TargetPositions[`Position{v47}`] = v48:GetPivot();
        v48:Destroy();
    end;
    p45.SmallTargetPosition = p45.Instance.Targets.SmallTarget:GetPivot();
    p45.Instance.Targets.SmallTarget:PivotTo(p45.SmallTargetPosition * CFrame.new(0, 10, 0));
    p45.Instance:WaitForChild("Nescius").Humanoid.Animator:LoadAnimation(p45.Instance.Nescius.Humanoid.Animator.Animation):Play();
    for v49, v50 in p45.Instance.Prizes:GetChildren() do
        p45.Prizes[v49] = v50;
    end;
end;
function u8.SpectateStart(_) --[[ Line: 278 ]] end;
function u8.Enter(_) --[[ Line: 346 ]]
    -- upvalues: l__Mince__5 (copy), u6 (copy), l__StarterGui__4 (copy)
    if l__Mince__5.Config.LocalProfile.Holiday < 100 then
        u6.Display("You don\'t have enough to use this!");
    else
        l__StarterGui__4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    end;
end;
function u8.Start(u51) --[[ Line: 354 ]]
    -- upvalues: u1 (copy), u5 (ref), l__LocalPlayer__1 (copy), l__TweenService__2 (copy), l__Mince__5 (copy), u7 (copy), u3 (copy), u4 (copy)
    u51.Playing = true;
    u51.ShouldSim = true;
    u51.TargetNum = 0;
    u1.PlayTrack("Inty_Minigame");
    task.defer(function() --[[ Line: 361 ]]
        -- upvalues: u51 (copy), u5 (ref)
        u51.Server:SetVoiceline("StartGame");
        u5:PlayVoiceline("StartGame");
    end);
    u51.Interface.Visible = true;
    u51.Interface.Score.Text = "0";
    u51.LastScore = 0;
    l__LocalPlayer__1.CameraMaxZoomDistance = 0;
    l__LocalPlayer__1.CameraMinZoomDistance = 0;
    for _, v52 in u51.Instance.PlayerBlockers:GetChildren() do
        v52.CanCollide = true;
        if v52:FindFirstChild("Decal") then
            l__TweenService__2:Create(v52.Decal, TweenInfo.new(1), {
                Transparency = 0
            }):Play();
        end;
    end;
    task.delay(2, function() --[[ Line: 381 ]]
        -- upvalues: u51 (copy)
        if u51.Playing then
            u51:NewRound();
            u51:DoSmallTarget();
        end;
    end);
    u51:GetStateChangedSignal("CanBuyPrize"):Connect(function() --[[ Line: 387 ]]
        -- upvalues: u51 (copy)
        u51:CleanSmallTarget();
    end);
    local v54 = u51:GetStateChangedSignal("PrizeEarned"):Connect(function() --[[ Line: 391 ]]
        -- upvalues: u51 (copy), l__Mince__5 (ref), u7 (ref)
        local l__PrizeEarned__14 = u51.ReplicatedState.PrizeEarned;
        local v53 = l__Mince__5.Config.Inventory[string.split(l__PrizeEarned__14, ".")[1]][string.split(l__PrizeEarned__14, ".")[2]];
        u7.DoItemGain({
            ItemName = v53.Name,
            IVID = v53.IVID,
            Colors = { Color3.new(0.0980392, 0.0666667, 0.0117647), Color3.new(0.113725, 0.0509804, 0) }
        });
    end);
    local v55 = u51:GetStateChangedSignal("LineCat"):Connect(function() --[[ Line: 403 ]]
        -- upvalues: u5 (ref), u51 (copy)
        u5:PlayVoiceline(u51.ReplicatedState.LineCat);
    end);
    local v56 = u51:GetStateChangedSignal("Round"):Connect(function() --[[ Line: 407 ]]
        -- upvalues: u51 (copy)
        u51:NewRound();
    end);
    local v64 = u51:GetStateChangedSignal("Targets"):Connect(function() --[[ Line: 411 ]]
        -- upvalues: u51 (copy)
        local l__Targets__15 = u51.ReplicatedState.Targets;
        if u51.TargetNum < l__Targets__15 then
            u51.TargetNum = l__Targets__15;
            local v57 = {};
            for v58 = 1, l__Targets__15 do
                table.insert(v57, v58);
            end;
            for v59 = l__Targets__15, 2, -1 do
                local v60 = math.random(v59);
                local v61 = v57[v60];
                local v62 = v57[v59];
                v57[v59] = v61;
                v57[v60] = v62;
            end;
            for v63 = 1, l__Targets__15 do
                if not u51.ShouldSim then
                    return;
                end;
                u51:SpawnTarget(v57[v63]);
            end;
        end;
    end);
    local v65 = u51:GetStateChangedSignal("Score"):Connect(function() --[[ Line: 435 ]]
        -- upvalues: u51 (copy), u3 (ref)
        u51.Interface.Score.Text = math.round(u51.ReplicatedState.Score);
        if u51.ReplicatedState.Score - u51.LastScore < 0 then
            u51.LastScore = u51.ReplicatedState.Score;
        else
            u3.UseNotifer(u51.LastPosition, Color3.new(0.670588, 0.105882, 0.827451), (math.round(u51.ReplicatedState.Score - u51.LastScore)));
            u51.LastScore = u51.ReplicatedState.Score;
        end;
    end);
    local v66 = u4.TargetShot:Connect(function(...) --[[ Line: 448 ]]
        -- upvalues: u51 (copy)
        u51:TargetShot(...);
    end);
    local v67 = u4.TargetMissed:Connect(function(...) --[[ Line: 452 ]]
        -- upvalues: u51 (copy)
        u51:TargetMissed(...);
    end);
    u51.Maid:Mark(v56);
    u51.Maid:Mark(v64);
    u51.Maid:Mark(v65);
    u51.Maid:Mark(v54);
    u51.Maid:Mark(v66);
    u51.Maid:Mark(v55);
    u51.Maid:Mark(v67);
end;
function u8.Exit(p68) --[[ Line: 465 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__1 (copy), l__StarterGui__4 (copy), l__TweenService__2 (copy)
    p68.Playing = false;
    p68.ShouldSim = false;
    p68:CleanSmallTarget();
    u1.StopTrack("Inty_Minigame");
    p68:NewRound();
    p68.Interface.Visible = false;
    l__LocalPlayer__1.CameraMaxZoomDistance = 60;
    l__LocalPlayer__1.CameraMinZoomDistance = 0.5;
    l__StarterGui__4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
    for _, v69 in p68.Instance.PlayerBlockers:GetChildren() do
        v69.CanCollide = false;
        if v69:FindFirstChild("Decal") then
            l__TweenService__2:Create(v69.Decal, TweenInfo.new(1.5), {
                Transparency = 1
            }):Play();
        end;
    end;
    p68:UnlockPlayerMovement();
end;
function u8.SetupAsync() --[[ Line: 492 ]]
    -- upvalues: u5 (ref)
    repeat
        task.wait();
    until u5:GetAll()[1];
    u5 = u5:GetAll()[1];
end;
function u8.Setup() --[[ Line: 497 ]]
    -- upvalues: u8 (copy)
    task.spawn(u8.SetupAsync);
end;
return u8;
