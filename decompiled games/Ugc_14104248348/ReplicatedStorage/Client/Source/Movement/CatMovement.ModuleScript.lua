-- Decompiled from: ReplicatedStorage.Client.Source.Movement.CatMovement
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("ContextActionService");
game:GetService("UserInputService");
game:GetService("RunService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__StarterGui__3 = game:GetService("StarterGui");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:GetEvent("PlayerCharacterChange");
local u2 = l__Mince__4:Get("Locomotion");
local u3 = l__Mince__4:Get("Notices");
local u4 = l__Mince__4:Get("KeyGuideHandler");
local u5 = l__Mince__4:Get("BindManager");
local u6 = {
    __IsAsyncSetup = true,
    HoldingJump = false,
    JumpThread = nil,
    CanSprintOrJump = true,
    WalkSpeed = 10,
    StartedHoldingJumpAt = DateTime.now().UnixTimestampMillis
};
function u6.NewCharacter(p7) --[[ Line: 29 ]]
    -- upvalues: u6 (copy)
    local l__HumanoidRootPart__5 = p7:WaitForChild("HumanoidRootPart");
    p7:WaitForChild("Head");
    u6.Character = p7;
    u6.HumanoidRootPart = l__HumanoidRootPart__5;
    u6.Anims = {};
    if p7:WaitForChild("Animations", 3) then
        for _, v8 in pairs(p7:WaitForChild("Animations"):GetChildren()) do
            u6.Anims[v8.Name] = p7.Humanoid:LoadAnimation(v8);
        end;
    end;
end;
function u6.JumpFunction(p9, _, p10) --[[ Line: 42 ]]
    -- upvalues: u6 (copy), u2 (copy)
    if u6.Active then
        if u6.Character.Humanoid.FloorMaterial == Enum.Material.Air and not u6.Character.Humanoid.Sit or not u6.CanSprintOrJump then
            u6.HoldingJump = false;
            u2.SetWalkDecimal(u6.WalkSpeed / 16, 0);
            u6.Character.Humanoid.JumpPower = 60;
        elseif p9 == Enum.UserInputState.Begin then
            u6.Anims.StandToJumpReady:Play();
            u6.HoldingJump = true;
            u6.StartedHoldingJumpAt = DateTime.now().UnixTimestampMillis;
            u6.JumpThread = task.delay(u6.Anims.StandToJumpReady.Length, function() --[[ Line: 57 ]]
                -- upvalues: u6 (ref)
                if u6.HoldingJump then
                    u6.JumpFunction(Enum.UserInputState.End, nil, true);
                end;
            end);
            u2.SetWalkDecimal(0, 0.4);
        else
            if u6.HoldingJump then
                u6.HoldingJump = false;
                u6.Anims.StandToJumpReady:Stop();
                if u6.JumpThread and not p10 then
                    task.cancel(u6.JumpThread);
                end;
                if DateTime.now().UnixTimestampMillis - u6.StartedHoldingJumpAt > 400 then
                    u6.Character.Humanoid.JumpPower = (DateTime.now().UnixTimestampMillis - u6.StartedHoldingJumpAt) / 800 * 85;
                    u6.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                    u6.HumanoidRootPart:ApplyImpulse(u6.HumanoidRootPart.CFrame.LookVector * ((DateTime.now().UnixTimestampMillis - u6.StartedHoldingJumpAt) / 800 * 500));
                end;
                u2.SetWalkDecimal(u6.WalkSpeed / 16, 0.4);
                task.wait(0.4);
                u6.Character.Humanoid.JumpPower = 60;
            end;
        end;
    end;
end;
function u6.SprintFunction(p11) --[[ Line: 83 ]]
    -- upvalues: u6 (copy), u2 (copy)
    if u6.Active then
        if p11 == Enum.UserInputState.Begin then
            u6.WalkSpeed = 24;
        else
            u6.WalkSpeed = 8;
        end;
        if u6.HoldingJump and u6.CanSprintOrJump then
        else
            u2.SetWalkDecimal(u6.WalkSpeed / 16, 0.4);
        end;
    end;
end;
function u6.Sitting(p12) --[[ Line: 96 ]]
    -- upvalues: u6 (copy)
    if not p12 then
        u6.Anims.SitClean:Stop();
        u6.Character:PivotTo(u6.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0));
    end;
    while u6.Character.Humanoid.Sit do
        task.wait(math.random(20, 50));
        if u6.Character.Humanoid.Sit then
            u6.Anims.SitClean:Play();
        end;
    end;
end;
function u6.Activate() --[[ Line: 110 ]]
    -- upvalues: u6 (copy), u5 (copy), u2 (copy), u4 (copy), l__StarterGui__3 (copy), u3 (copy)
    u6.Active = true;
    game.Players.LocalPlayer.CameraMinZoomDistance = 1;
    game:GetService("StarterPlayer").EnableMouseLockOption = false;
    u6.PounceConn = u5.Get("CatPounce").OnAction:Connect(u6.JumpFunction);
    u6.SprintConn = u5.Get("Sprint").OnAction:Connect(u6.SprintFunction);
    u5.SetMobileBindButtonsEnabled("Sprint", true);
    u2.SetWalkDecimal(u6.WalkSpeed / 16);
    game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
    game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    u6.Character.Destroying:Once(u6.Deactivate);
    game.Players.LocalPlayer.CharacterAdded:Once(u6.Deactivate);
    u6.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function() --[[ Line: 126 ]]
        -- upvalues: u6 (ref)
        u6.Sitting(u6.Character.Humanoid.Sit);
    end);
    u4.CreateGuides({
        {
            Bind = "CatPounce",
            Name = "Pounce"
        },
        {
            Bind = "Sprint",
            Name = "Sprint"
        }
    });
    u6.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    u6.HumanoidRootPart:ApplyImpulse(Vector3.new(0, 0, -200));
    while task.wait() and u6.Active do
        if u6.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            u6.LastAir = DateTime.now().UnixTimestampMillis;
        end;
        l__StarterGui__3:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        if u6.Character:FindFirstChildOfClass("Tool") then
            u6.Character.Humanoid:UnequipTools();
        end;
        if u6.Character.Humanoid:GetState() == Enum.HumanoidStateType.Swimming and u6.CanSprintOrJump then
            u3.CreateNotice("Cats hate water!");
            u6.CanSprintOrJump = false;
            u6.Character.Cat.Cat:Play();
            u6.Anims.Spook:Play();
            local v13 = Instance.new("AlignPosition", u6.HumanoidRootPart);
            v13.Mode = Enum.PositionAlignmentMode.OneAttachment;
            v13.Position = u6.LastSolidGroind.Position;
            v13.Attachment0 = u6.HumanoidRootPart.Attachment;
            task.wait(0.2);
            v13:Destroy();
            u6.CanSprintOrJump = true;
        end;
    end;
end;
function u6.Deactivate() --[[ Line: 165 ]]
    -- upvalues: u6 (copy), u2 (copy), u4 (copy), u5 (copy)
    u6.Active = false;
    game.Players.LocalPlayer.CameraMinZoomDistance = 0;
    game:GetService("StarterPlayer").EnableMouseLockOption = true;
    u2.SetWalkDecimal(1, 0.5);
    u4.Clear();
    u5.SetMobileBindButtonsEnabled("Sprint", false);
    u6.JumpConn:Disconnect();
    u6.PounceConn:Disconnect();
    task.delay(0.5, function() --[[ Line: 178 ]]
        -- upvalues: u2 (ref)
        u2.SetWalkDecimal(1, 0.5);
    end);
end;
function u6.Setup() --[[ Line: 183 ]]
    -- upvalues: u1 (copy), u6 (copy), l__LocalPlayer__2 (copy)
    u1.Event:Connect(function(p14) --[[ Line: 184 ]]
        -- upvalues: u6 (ref)
        task.wait(0.01);
        if p14 == "Cat" then
            u6.Activate();
        end;
    end);
    l__LocalPlayer__2.CharacterAdded:Connect(u6.NewCharacter);
    if l__LocalPlayer__2.Character then
        task.defer(function() --[[ Line: 193 ]]
            -- upvalues: u6 (ref), l__LocalPlayer__2 (ref)
            u6.NewCharacter(l__LocalPlayer__2.Character);
        end);
    end;
    u6.LastAir = DateTime.now().UnixTimestampMillis;
    while task.wait() do
        if u6.Character and u6.Character:FindFirstChild("Humanoid") then
            if u6.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                u6.LastAir = DateTime.now().UnixTimestampMillis;
            end;
            if u6.Character.Humanoid.FloorMaterial ~= Enum.Material.Air and (u6.Character.Humanoid.FloorMaterial ~= Enum.Material.Water and (DateTime.now().UnixTimestampMillis - u6.LastAir > 200 and u6.Character.HumanoidRootPart.Position.Y > -18)) then
                u6.LastSolidGroind = u6.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(0, 30, 5));
            end;
        end;
    end;
end;
return u6;
