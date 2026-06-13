-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.Components.ClientEnemy
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local l__Maid__2 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__LTCS__3 = require(l__ReplicatedStorage__1.Modules.LTCS);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__5 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__ModelTween__6 = require(script.ModelTween);
local u1 = l__Mince__4:Get("Indicators");
local u2 = l__Mince__4.Component({
    Tag = "EnemyController",
    CreationParents = { game.Workspace },
    Routines = {},
    Tweens = {
        Interp = TweenInfo.new(0.35, Enum.EasingStyle.Cubic)
    },
    DirectorStates = {
        I = "ReplicateIndicator",
        _ = "ReplicatePosition",
        R = "ReplicateRoutine",
        A = "ReplicateAnimationState"
    }
});
function u2.UnpackCFrame(_, p3, p4, p5) --[[ Line: 31 ]]
    return CFrame.new(Vector3.new(p3.X / 10, p3.Y / 10, p4.X / 10) + p5) * CFrame.Angles(0, math.rad(p4.Y / 10), 0);
end;
function u2.ReplicateAnimationState(p6, p7) --[[ Line: 36 ]]
    -- upvalues: l__LTCS__3 (copy)
    for v8, v9 in p7 do
        local u10 = l__LTCS__3.Decode(v9);
        local u11 = ({ "Play", "Stop", "Pause" })[u10[1]];
        local v12 = p6.AnimationLookup[tostring(v8)];
        local u13 = p6.Animations[v12];
        local v14, v15 = pcall(function() --[[ Line: 49 ]]
            -- upvalues: u13 (copy), u11 (copy), u10 (copy)
            return u13[u11](u13, select(2, table.unpack(u10)));
        end);
        if not v14 then
            warn("Serialization failure!!");
            warn(u11, u13);
            warn(v15);
        end;
    end;
end;
function u2.ReplicateIndicator(p16, p17, p18) --[[ Line: 62 ]]
    -- upvalues: u1 (copy)
    u1.NewIndicator(p16:GetBodyTopPosition(), p18, p17 or "<ERROR>");
end;
function u2.ReplicateRoutine(p19, p20, ...) --[[ Line: 66 ]]
    -- upvalues: u2 (copy)
    if p19.DoesNotReplicate then
    else
        local v21 = u2.Routines[p20];
        if v21 then
            if v21.Called then
                v21.Called(p19, ...);
            end;
        else
            warn((`Attemmpted to call a Routine '{p20}' but it does not exist!`));
        end;
    end;
end;
function u2.ReplicatePosition(p22, p23, p24) --[[ Line: 80 ]]
    -- upvalues: l__ModelTween__6 (copy)
    if p22.DoesNotReplicate then
    else
        local v25 = p22:UnpackCFrame(p23, p24, p22.Height * Vector3.new(0, 1, 0));
        p22.LastCFrame = p22.TargetCFrame;
        p22.TargetCFrame = v25;
        p22.HitCFrame = v25;
        l__ModelTween__6.new(p22.ThisRoot, p22.Tweens.Interp, v25):Play();
    end;
end;
function u2.AnimationStateChanged(p26, p27, p28) --[[ Line: 94 ]]
    -- upvalues: l__LTCS__3 (copy)
    local v29 = l__LTCS__3.Decode(p28);
    local v30 = p26.Animations[p27];
    v30[v29[1]](v30, select(2, table.unpack(v29)));
end;
function u2.AnimationIndexAdded(p31, p32, p33) --[[ Line: 100 ]]
    p31.AnimationLookup[tostring(p33)] = p32;
    p31.AnimationLookup[p32] = p33;
end;
function u2.ChangesFrom(p34, u35, u36) --[[ Line: 106 ]]
    for v37, v38 in u35:GetAttributes() do
        u36(v37, v38);
    end;
    p34.Maid:Add(u35.AttributeChanged:Connect(function(p39) --[[ Line: 111 ]]
        -- upvalues: u36 (copy), u35 (copy)
        u36(p39, u35:GetAttribute(p39));
    end));
end;
function u2.Construct(u40) --[[ Line: 117 ]]
    -- upvalues: l__Maid__2 (copy), l__Signal__5 (copy), l__ReplicatedStorage__1 (copy)
    u40.Maid = l__Maid__2.new();
    u40.Destroying = l__Signal__5.new();
    u40.TargetChanged = l__Signal__5.new();
    u40.Animations = {};
    u40.Sounds = {};
    u40.Welds = {};
    u40.HeightOffset = -0.9;
    u40.AnimationLookup = {};
    u40.AnimationState = u40.Instance:WaitForChild("AnimationState");
    u40.AnimationIndex = u40.Instance:WaitForChild("AnimationIndex");
    u40:CreateExtents();
    assert(u40.Model, "a model is needed inorder to load this character!");
    local l__Model__7 = u40.Model;
    if l__Model__7 then
        l__Model__7 = l__ReplicatedStorage__1.Assets.Enemies:FindFirstChild(u40.Model);
    end;
    u40:AttachCharacter(l__Model__7:Clone());
    u40:ChangesFrom(u40.AnimationIndex, function(p41, p42) --[[ Line: 139 ]]
        -- upvalues: u40 (copy)
        u40:AnimationIndexAdded(p41, p42);
    end);
    u40:ChangesFrom(u40.AnimationState, function(p43, p44) --[[ Line: 143 ]]
        -- upvalues: u40 (copy)
        u40:AnimationStateChanged(p43, p44);
    end);
    u40.Maid:Add(u40.Replication.OnClientEvent:Connect(function(p45, ...) --[[ Line: 147 ]]
        -- upvalues: u40 (copy)
        if u40.IsActive then
            local v46 = u40.DirectorStates[p45];
            if u40[v46] then
                u40[v46](u40, ...);
            else
                warn("dropped->", p45, ...);
            end;
        end;
    end));
    u40.Maid:Add(u40.Instance.Destroying:Connect(function() --[[ Line: 153 ]]
        -- upvalues: u40 (copy)
        if u40.IsActive then
            u40.IsDestroying = true;
            u40:Destroy();
        end;
    end));
    if u40.StartingRoutine then
        u40:ReplicateRoutine(u40.StartingRoutine);
    end;
    u40.IsActive = true;
    u40.ThisRoot.CFrame = CFrame.new(u40.SpawnPosition + u40.Height * Vector3.new(0, 1, 0));
end;
function u2.AttachCharacter(p47, p48) --[[ Line: 168 ]]
    p47.Character = p48;
    p47.Character.Parent = p47.Instance;
    p47.AnimationFolder = p47.Character:WaitForChild("Animations");
    p47.SoundFolder = p47.Character:WaitForChild("Sounds");
    p47.Humanoid = p47.Character:FindFirstChild("Humanoid");
    if p47.Humanoid then
        p47.Humanoid.NameDisplayDistance = 0;
        p47.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    else
        p47.AnimationController = p48:WaitForChild("AnimationController");
    end;
    if p47.AnimationController then
        p47.Animator = p47.AnimationController:WaitForChild("Animator");
    elseif p47.Humanoid then
        p47.Animator = p47.Humanoid:WaitForChild("Animator");
    else
        error("Could not find an animator!");
    end;
    if p47.Character:GetAttribute("HasHead") then
        p47.Head = p47.Character:WaitForChild("Head");
    else
        p47.Head = p47.Character:FindFirstChild("Head");
    end;
    p47.HumanoidRootPart = p47.Character:FindFirstChild("HumanoidRootPart");
    if p47.HumanoidRootPart then
        p47.ThisRoot = p47.HumanoidRootPart;
    elseif p47.Character:FindFirstChild("CustomRoot") then
        p47.ThisRoot = p47.Character:FindFirstChild("CustomRoot").Value;
    else
        p47.ThisRoot = p47.Character:WaitForChild("RootPart");
    end;
    for _, v49 in p47.ThisRoot:GetDescendants() do
        if v49:IsA("Attachment") and v49:HasTag("Special") then
            p47.SpecialParts[v49.Name] = v49;
        end;
    end;
    if p47.Humanoid then
        p47.CenterPart = p47.Character:WaitForChild("LowerTorso");
    elseif p47.CustomCenterType == "FirstBone" then
        p47.CenterPart = p47.Character:FindFirstChildWhichIsA("Bone", true);
    elseif p47.CustomCenterType == "FirstBoneRoot" then
        p47.CenterPart = p47.ThisRoot:GetAttribute("RootBone") and p47.ThisRoot:FindFirstChild(p47.ThisRoot:GetAttribute("RootBone")) or p47.ThisRoot:FindFirstChildWhichIsA("Bone");
    end;
    p47.ThisRoot.Anchored = true;
    p47:UpdateSize();
    p47:CreateModelAttachments();
    task.wait();
    p47:LoadCharacterDetails();
    p47:ScaleCharacter(p47.Scale);
end;
function u2.Destroy(p50) --[[ Line: 235 ]]
    if p50.Destroyed then
    else
        p50:Disconnect();
        p50.Destroyed = true;
        p50.Character:Destroy();
        if p50.Instance.Parent ~= nil and not p50.IsDestroying then
            p50.Instance:Destroy();
        end;
        p50.Destroying:Fire();
    end;
end;
function u2.Disconnect(p51) --[[ Line: 246 ]]
    p51.Maid:Clean();
end;
function u2.CreateModelAttachments(p52) --[[ Line: 250 ]]
    if p52.SoundFolder then
        for _, v53 in p52.SoundFolder:GetChildren() do
            if v53:IsA("Sound") then
                local v54 = v53:Clone();
                v54.SoundGroup = game.SoundService.Master.SFX;
                v54.Parent = p52.ThisRoot;
                p52.Sounds[v53.Name] = v54;
            elseif v53:IsA("Folder") then
                local v55 = Instance.new("Attachment", p52.ThisRoot);
                for _, v56 in v53:GetChildren() do
                    local v57 = v56:Clone();
                    v57.SoundGroup = game.SoundService.Master.SFX;
                    v57.Parent = v55;
                end;
                p52.Sounds[v53.Name] = v55;
            end;
        end;
    end;
end;
function u2.LoadCharacterDetails(p58) --[[ Line: 278 ]]
    for _, v59 in p58.Character:GetDescendants() do
        if v59:IsA("BasePart") then
            v59.CollisionGroup = "Enemies";
        end;
    end;
    for _, v60 in p58.Character:GetChildren() do
        if v60:IsA("BasePart") then
            v60.CanCollide = false;
            p58.Welds[v60] = {};
            for _, v61 in v60:GetDescendants() do
                if v61:IsA("BasePart") then
                    local v62 = Instance.new("Weld");
                    v62.Part0 = v61;
                    v62.Part1 = v60;
                    v62.C0 = v61.CFrame:ToObjectSpace(v60.CFrame);
                    v62.Parent = v61;
                    v61.Anchored = false;
                    p58.Welds[v60][v61] = v62;
                end;
            end;
        end;
    end;
    for _, v63 in p58.AnimationFolder:GetChildren() do
        p58.Animations[v63.Name] = p58.Animator:LoadAnimation(v63);
    end;
    if p58.Animations.Idle then
        p58.Animations.Idle:Play();
    end;
end;
function u2.ScaleCharacter(p64, p65) --[[ Line: 318 ]]
    if p65 == p64.CurrentScale then
    else
        p64.Character:ScaleTo(p64.Character:GetScale() * p65);
        p64:UpdateSize(p65);
    end;
end;
function u2.UpdateSize(p66, p67) --[[ Line: 327 ]]
    local v68, v69 = p66.Character:GetBoundingBox();
    p66.Height = p66.ThisRoot.Position.Y - (v68.Y - v69.Y / 2);
    p66.Height = p66.Height + (p66.HeightOffset or 0);
    if p67 then
        p66.CurrentScale = p67;
    end;
end;
function u2.GetBodyCenterPosition(p70) --[[ Line: 337 ]]
    local v71, _ = p70.Character:GetBoundingBox();
    return v71.Position;
end;
function u2.GetBodyTopPosition(p72) --[[ Line: 342 ]]
    local v73, v74 = p72.Character:GetBoundingBox();
    return (v73 * CFrame.new(0, v74.Y / 2, 0)).Position;
end;
function u2.CreateExtents(p75) --[[ Line: 349 ]]
    p75.ExtrasFolder = Instance.new("Folder");
    p75.ExtrasFolder.Name = "Extras";
    p75.ExtrasFolder.Parent = p75.Instance;
    p75.Replication = p75.Instance:WaitForChild("Replication");
end;
function u2.Removing(p76) --[[ Line: 358 ]]
    p76.Maid:Clean();
end;
function u2.Setup(_) --[[ Line: 362 ]]
    -- upvalues: u2 (copy)
    for _, v77 in script.Routines:GetDescendants() do
        if v77:IsA("ModuleScript") then
            u2.Routines[v77.Name] = require(v77);
        end;
    end;
end;
return u2;
