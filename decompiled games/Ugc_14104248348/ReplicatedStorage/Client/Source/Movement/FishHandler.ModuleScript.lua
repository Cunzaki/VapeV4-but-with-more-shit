-- Decompiled from: ReplicatedStorage.Client.Source.Movement.FishHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__Players__3 = game:GetService("Players");
local l__TweenService__4 = game:GetService("TweenService");
local l__RunService__5 = game:GetService("RunService");
local l__StarterGui__6 = game:GetService("StarterGui");
local l__Debris__7 = game:GetService("Debris");
local l__LocalPlayer__8 = l__Players__3.LocalPlayer;
local l__Mince__9 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__9:Get("Locomotion");
local u1 = l__Mince__9:Get("InterfaceHandler");
local u2 = l__Mince__9:Get("SelectInteractor");
local u3 = l__Mince__9:Get("BindManager");
local u4 = l__Mince__9:Get("KeyGuideHandler");
local u5 = l__Mince__9:GetEvent("SyncFishAnim");
local u6 = l__Mince__9:GetFunction("CreateFish");
local u7 = l__Mince__9:GetEvent("BecomeFish");
local u8 = l__Mince__9:GetEvent("RespawnNotFish");
local u9 = {
    __IsAsyncSetup = true,
    FISH_SPEED = 25,
    SPRINT_SPEED = 250,
    JUMP_POWER = 50,
    CurrentSpeed = 25,
    CurrentStamina = 1,
    Params = OverlapParams.new(),
    Animations = {}
};
l__Mince__9.Component({
    Tag = "FishPipe"
}).Construct = function(u10) --[[ Name: Construct, Line 47 ]]
    -- upvalues: u9 (copy), l__TweenService__4 (copy), u2 (copy)
    local v15 = {
        HoverName = "Enter Pipe",
        HitCollider = u10.Instance:WaitForChild("Pipe"),
        Target = u10.Instance,
        OnHover = function(_) --[[ Name: OnHover, Line 55 ]]
            -- upvalues: u9 (ref)
            return u9.SyncRigConnection and true or false;
        end,
        Interact = function(_, p11) --[[ Name: Interact, Line 61 ]]
            -- upvalues: u9 (ref), l__TweenService__4 (ref), u10 (copy)
            u9.SprintInterface.Frame.Visible = true;
            local v12 = l__TweenService__4:Create(u9.SprintInterface.Frame, TweenInfo.new(0.5), {
                BackgroundTransparency = 0
            });
            v12:Play();
            v12.Completed:Wait();
            local v13 = u10.Instance.TakeTo.Value:GetPivot();
            u9.FishRig:PivotTo(v13);
            u9.BodyPos.Position = v13.Position;
            task.wait(0.5);
            local v14 = l__TweenService__4:Create(u9.SprintInterface.Frame, TweenInfo.new(0.5), {
                BackgroundTransparency = 1
            });
            v14:Play();
            v14.Completed:Wait();
            u9.SprintInterface.Frame.Visible = false;
            p11();
        end
    };
    u2.NewInteractionClass(v15);
end;
function u9.CalculateSwim(p16) --[[ Line: 84 ]]
    -- upvalues: u9 (copy)
    local l__FishRig__10 = u9.FishRig;
    local _ = l__FishRig__10.PrimaryPart.CFrame;
    local v17 = workspace:GetPartsInPart(l__FishRig__10.Head, u9.Params);
    if v17 and (v17[1] and not u9.Swimming) then
        u9.StartSwimming(v17[1]);
    end;
    if u9.Sprinting and u9.CurrentStamina > 0 then
        local v18 = u9;
        v18.CurrentStamina = v18.CurrentStamina - p16 / 1.4;
        u9.SprintInterface.Bar.Progress.Size = UDim2.fromScale(u9.CurrentStamina, 1);
        local v19 = u9;
        local l__FISH_SPEED__11 = u9.FISH_SPEED;
        v19.CurrentSpeed = l__FISH_SPEED__11 + (u9.SPRINT_SPEED - l__FISH_SPEED__11) * u9.CurrentStamina;
        u9.SprintInterface.Bar.Visible = true;
        u9.Animations.Swim:AdjustSpeed(1 + 3 * u9.CurrentStamina);
    elseif not u9.Sprinting and u9.CurrentStamina < 1 then
        local v20 = u9;
        v20.CurrentStamina = v20.CurrentStamina + p16 / 2;
        u9.SprintInterface.Bar.Progress.Size = UDim2.fromScale(u9.CurrentStamina, 1);
    end;
    if u9.CurrentStamina >= 1 and u9.SprintInterface.Bar.Visible == true then
        u9.SprintInterface.Bar.Visible = false;
    end;
    if u9.Swimming then
        local l__BodyPos__12 = u9.BodyPos;
        local l__BodyGyro__13 = u9.BodyGyro;
        local v21 = u9.ControlModule:GetMoveVector();
        local v22 = game.Workspace.CurrentCamera.CFrame:VectorToWorldSpace(v21);
        l__BodyPos__12.Position = l__BodyPos__12.Position + v22 * u9.CurrentSpeed * p16 * (u9.LocalCharacter.Humanoid.WalkSpeed / 16);
        if v22.Magnitude ~= 0 then
            l__BodyGyro__13.CFrame = CFrame.lookAt(Vector3.new(), v22);
        end;
        if u9.LocalCharacter.Humanoid.WalkSpeed == 0 then
            if u9.Animations.Swim.IsPlaying then
                u9.Animations.Swim:Stop(0.5);
            end;
            if u9.Animations.Idle.IsPlaying == false then
                u9.Animations.Idle:Play(0.5);
            end;
        else
            if u9.Animations.Idle.IsPlaying then
                u9.Animations.Idle:Stop(0.5);
            end;
            if u9.Animations.Swim.IsPlaying == false then
                u9.Animations.Swim:Play(0.5);
            end;
        end;
        if l__BodyPos__12.Position.Y >= u9.BodyOfWater.Position.Y + u9.BodyOfWater.Size.Y / 2 then
            u9.StopSwimming(true);
            return;
        end;
        if l__BodyPos__12.Position.X >= u9.BodyOfWater.Position.X + u9.BodyOfWater.Size.X / 2 then
            u9.StopSwimming();
            return;
        end;
        if l__BodyPos__12.Position.X <= u9.BodyOfWater.Position.X + -u9.BodyOfWater.Size.X / 2 then
            u9.StopSwimming();
            return;
        end;
        if l__BodyPos__12.Position.Z >= u9.BodyOfWater.Position.Z + u9.BodyOfWater.Size.Z / 2 then
            u9.StopSwimming();
            return;
        end;
        if l__BodyPos__12.Position.Z <= u9.BodyOfWater.Position.Z + -u9.BodyOfWater.Size.Z / 2 then
            u9.StopSwimming();
        end;
    else
        if not u9.Animations.Flop.IsPlaying then
            u9.Animations.Flop:Play();
        end;
        local l__Humanoid__14 = l__FishRig__10.Humanoid;
        l__Humanoid__14.Health = l__Humanoid__14.Health - p16 * 3;
    end;
end;
function u9.StartSwimming(p23) --[[ Line: 158 ]]
    -- upvalues: u9 (copy), u3 (copy)
    local l__FishRig__15 = u9.FishRig;
    local v24 = Instance.new("BodyPosition");
    v24.MaxForce = Vector3.new(inf, inf, inf);
    v24.P = 1500;
    v24.D = 300;
    v24.Parent = l__FishRig__15.PrimaryPart;
    v24.Position = l__FishRig__15.PrimaryPart.Position;
    local v25 = Instance.new("BodyGyro");
    v25.MaxTorque = Vector3.new(inf, inf, inf);
    v25.P = 1500;
    v25.D = 150;
    v25.Parent = l__FishRig__15.PrimaryPart;
    u9.Swimming = true;
    u9.BodyOfWater = p23;
    u9.BodyGyro = v25;
    u9.BodyPos = v24;
    if u9.Animations.Flop.IsPlaying then
        u9.Animations.Flop:Stop();
    end;
    u9.SprintConn = u3.Get("Sprint").OnAction:Connect(function(p26) --[[ Line: 185 ]]
        -- upvalues: u9 (ref)
        if p26 == Enum.UserInputState.Begin then
            u9.Sprinting = true;
        else
            if p26 == Enum.UserInputState.End then
                u9.CurrentSpeed = u9.FISH_SPEED;
                u9.Animations.Swim:AdjustSpeed(1);
                u9.Sprinting = false;
            end;
        end;
    end);
    u3.SetMobileBindButtonsEnabled("Sprint", true);
end;
function u9.StopSwimming(p27) --[[ Line: 198 ]]
    -- upvalues: u9 (copy), l__Debris__7 (copy)
    local l__FishRig__16 = u9.FishRig;
    u9.Swimming = false;
    u9.BodyGyro:Destroy();
    u9.BodyPos:Destroy();
    if p27 then
        local v28 = Instance.new("BodyVelocity");
        v28.MaxForce = Vector3.new(inf, inf, inf);
        v28.P = 1500;
        v28.Velocity = l__FishRig__16.PrimaryPart.CFrame.UpVector * u9.JUMP_POWER;
        v28.Parent = l__FishRig__16.PrimaryPart;
        l__Debris__7:AddItem(v28, 0.1);
    end;
    for _, v29 in u9.Animations do
        v29:Stop();
    end;
end;
function u9.ReplaceCharacterWithFish() --[[ Line: 220 ]]
    -- upvalues: u6 (copy), u9 (copy), l__ReplicatedStorage__1 (copy), l__LocalPlayer__8 (copy), u4 (copy), l__RunService__5 (copy), l__StarterGui__6 (copy)
    local u30 = u6:Invoke();
    print(u30);
    u9.FishRig = u30;
    for _, v31 in l__ReplicatedStorage__1.Assets.FishAnims:GetChildren() do
        u9.Animations[v31.Name] = u30.Humanoid:LoadAnimation(v31);
    end;
    u9.LocalCharacter:PivotTo(u9.Room:GetPivot());
    l__LocalPlayer__8.Character.LowerTorso.Root.Enabled = false;
    l__LocalPlayer__8.Character.Humanoid.PlatformStand = true;
    u4.CreateGuides({
        {
            Bind = "Sprint",
            Name = "Sprint"
        }
    });
    u30.Humanoid.PlatformStand = true;
    l__LocalPlayer__8.Character.Humanoid.Died:Connect(u9.StopBeingFish);
    u30.Humanoid.Died:Connect(u9.StopBeingFish);
    task.wait();
    u9.LocalCharacter:PivotTo(u9.Room:GetPivot());
    l__LocalPlayer__8.Character.HumanoidRootPart.Anchored = true;
    u9.SyncRigConnection = l__RunService__5.Heartbeat:Connect(function(p32) --[[ Line: 247 ]]
        -- upvalues: u30 (copy), u9 (ref), l__StarterGui__6 (ref), l__LocalPlayer__8 (ref)
        u30.Humanoid:Move(u9.LocalCharacter.Humanoid.MoveDirection, false);
        u30.Humanoid.WalkSpeed = u9.LocalCharacter.Humanoid.WalkSpeed;
        u9.LocalCharacter.Humanoid.Health = u30.Humanoid.Health;
        l__StarterGui__6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        l__LocalPlayer__8.Character.HumanoidRootPart.CanCollide = false;
        l__LocalPlayer__8.Character.HumanoidRootPart:PivotTo(u30:GetPivot());
        game.Workspace.CurrentCamera.CameraSubject = u30.PrimaryPart;
        u9.CalculateSwim(p32);
    end);
end;
function u9.StopBeingFish() --[[ Line: 261 ]]
    -- upvalues: u9 (copy), u3 (copy), u4 (copy), u8 (copy), l__StarterGui__6 (copy)
    if u9.SyncRigConnection then
        u9.SyncRigConnection:Disconnect();
        u9.SyncRigConnection = nil;
        if u9.Swimming then
            pcall(u9.StopSwimming);
        end;
        u9.SprintConn:Disconnect();
        u3.SetMobileBindButtonsEnabled("Sprint", true);
        u4.Clear();
        task.wait(5);
        u8:Fire();
        l__StarterGui__6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
    end;
end;
function u9.NewCharacter(p33) --[[ Line: 282 ]]
    -- upvalues: u9 (copy)
    u9.LocalCharacter = p33;
end;
function u9.AnimateOtherFish(p34) --[[ Line: 286 ]]
    -- upvalues: u9 (copy), l__ReplicatedStorage__1 (copy)
    if u9.FishRig and p34 == u9.FishRig then
    else
        p34.Humanoid:LoadAnimation(l__ReplicatedStorage__1.Assets.FishAnims.Idle):Play();
    end;
end;
function u9.Setup() --[[ Line: 291 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u9 (copy), l__CollectionService__2 (copy), u1 (copy), u5 (copy), u7 (copy)
    if l__LocalPlayer__8.Character then
        u9.NewCharacter(l__LocalPlayer__8.Character);
    end;
    l__LocalPlayer__8.CharacterAdded:Connect(u9.NewCharacter);
    local v35 = l__CollectionService__2:GetTagged("CustomCharRoom")[1];
    u9.Room = v35;
    if not v35 then
        l__CollectionService__2:GetInstanceAddedSignal("CustomCharRoom"):Wait();
        u9.Room = l__CollectionService__2:GetTagged("CustomCharRoom")[1];
    end;
    u9.Params.FilterDescendantsInstances = l__CollectionService__2:GetTagged("SwimmableWater");
    u9.Params.FilterType = Enum.RaycastFilterType.Include;
    u9.ControlModule = require(l__LocalPlayer__8:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
    u9.SprintInterface = u1.GetScreenGui("FishSprintMeter");
    l__CollectionService__2:GetInstanceAddedSignal("SwimmableWater"):Connect(function(p36) --[[ Line: 314 ]]
        -- upvalues: u9 (ref)
        u9.Params:AddToFilter(p36);
    end);
    u5.Event:Connect(u9.AnimateOtherFish);
    u7.Event:Connect(function() --[[ Line: 320 ]]
        -- upvalues: u9 (ref)
        u9.ReplaceCharacterWithFish();
    end);
end;
return u9;
