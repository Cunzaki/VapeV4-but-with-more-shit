-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.ClientMount
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__Workspace__4 = game:GetService("Workspace");
local l__Players__5 = game:GetService("Players");
local l__Debris__6 = game:GetService("Debris");
local l__LocalPlayer__7 = l__Players__5.LocalPlayer;
local l__PlayerModule__8 = l__LocalPlayer__7.PlayerScripts:WaitForChild("PlayerModule");
local l__ControlModule__9 = require(l__PlayerModule__8.ControlModule);
local l__Deepcopy__10 = require(l__ReplicatedStorage__2.Modules.Deepcopy);
local l__Maid__11 = require(l__ReplicatedStorage__2.Modules.Maid);
local l__Mince__12 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__12:Get("InterfaceHandler");
local u2 = l__Mince__12:Get("SelectInteractor");
local u3 = l__Mince__12:GetEvent("HorseStaffUnmount");
local u4 = {
    JumpForce = 88,
    WalkSpeed = 24,
    FloatPercentage = 0.8,
    RotatingSpeed = 4,
    ExtraJumps = 1,
    BreakingEnabled = true,
    BreakRate = 4,
    DecelerateRate = 4,
    VelocityIncreaseRate = 1,
    VelocityDecreaseRate = 2,
    StartWalkSpeedDecimal = 0.3333333333333333,
    ExtraSpeedFromJump = 5,
    TerminalVelocity = 120
};
local u5 = l__Mince__12.Component({
    Tag = "CustomMount",
    CreationParents = { l__Workspace__4 }
});
function u5.CalculateUnitAverage(_, p6) --[[ Line: 65 ]]
    local v7 = 0;
    local v8 = 0;
    for _, v9 in { "X", "Y", "Z" } do
        if p6[v9] ~= 0 then
            v7 = v7 + math.abs(p6[v9]);
            v8 = v8 + 1;
        end;
    end;
    return v8 == 0 and 0 or v7 / v8;
end;
function u5.PostAnimation(p10, p11) --[[ Line: 84 ]]
    -- upvalues: l__ControlModule__9 (copy)
    debug.profilebegin("ClientMount // PostAnimation");
    if p10.SpecialBones.Neck then
        local v12 = l__ControlModule__9:GetMoveVector();
        local v13 = p10.WasGrounded and CFrame.Angles(0, -v12.X * 3.141592653589793 * 0.3, 0) or CFrame.new();
        p10.NeckOffset = p10.NeckOffset:Lerp(v13, p11 * 10);
        p10.SpecialBones.Neck.CFrame = p10.NeckOffset;
    end;
    debug.profileend();
end;
function u5.UpdateMovement(p14, p15) --[[ Line: 99 ]]
    -- upvalues: l__ControlModule__9 (copy)
    if p14.Player then
        if p14.Instance.Parent == nil then
            p14:Removing();
        else
            debug.profilebegin("ClientMount // UpdateMovement");
            local l__CurrentCamera__13 = workspace.CurrentCamera;
            local v16 = l__ControlModule__9:GetMoveVector();
            local v17 = v16.Magnitude > 0;
            local v18 = p14.ControllerPartSensor.SensedPart ~= nil;
            local v19 = math.min(1, p14:CalculateUnitAverage(v16));
            local l__Value__14 = p14.Instance.Velocity.Value;
            local v20 = false;
            if v18 then
                p14.ControllerManager.ActiveController = p14.GroundController;
            else
                p14.ControllerManager.ActiveController = p14.AirController;
            end;
            if v17 and p14.MovementSettings.BreakingEnabled then
                local v21 = true;
                if v18 and (not p14.WasBreaking or l__Value__14 > 0) then
                    if not p14.WasBreaking and l__Value__14 <= p14.MovementSettings.WalkSpeed / 2 then
                        v21 = false;
                    end;
                else
                    v21 = false;
                end;
                if v21 then
                    local _, v22, v23 = (l__CurrentCamera__13.CFrame - l__CurrentCamera__13.CFrame.Position):ToOrientation();
                    local v24 = (CFrame.new(l__CurrentCamera__13.CFrame.Position) * CFrame.fromOrientation(0, v22, v23)):VectorToWorldSpace(v16);
                    if p14.CurrentHeading.LookVector:Dot(v24) < -0.93 then
                        v20 = true;
                        if not p14.WasBreaking and p14.Animations.Stop then
                            p14.Animations.Stop:Play();
                        end;
                    end;
                end;
            end;
            if v17 and not v20 then
                l__Value__14 = math.clamp(l__Value__14, p14.MovementSettings.StartWalkSpeedDecimal * p14.MovementSettings.WalkSpeed * v19, p14.MovementSettings.TerminalVelocity);
                if l__Value__14 < p14.MovementSettings.WalkSpeed then
                    l__Value__14 = l__Value__14 + p14.MovementSettings.WalkSpeed * (p15 * p14.MovementSettings.VelocityIncreaseRate * v19);
                end;
            end;
            if v18 and not v17 then
                l__Value__14 = math.max(0, l__Value__14 - p15 * p14.MovementSettings.VelocityDecreaseRate * p14.MovementSettings.WalkSpeed);
            end;
            if v18 and p14.MovementSettings.WalkSpeed < l__Value__14 then
                l__Value__14 = l__Value__14 - (l__Value__14 - p14.MovementSettings.WalkSpeed) * p15 * p14.MovementSettings.DecelerateRate;
            end;
            if v20 then
                l__Value__14 = math.max(0, l__Value__14 - p15 * p14.MovementSettings.BreakRate * p14.MovementSettings.WalkSpeed);
            end;
            p14.Instance.Velocity.Value = l__Value__14;
            p14.ControllerManager.BaseMoveSpeed = l__Value__14;
            p14.WasBreaking = v20;
            if l__Value__14 ~= 0 then
                local _, v25, v26 = (l__CurrentCamera__13.CFrame - l__CurrentCamera__13.CFrame.Position):ToOrientation();
                local v27 = (CFrame.new(l__CurrentCamera__13.CFrame.Position) * CFrame.fromOrientation(0, v25, v26)):VectorToWorldSpace(v16);
                local l__Rotation__15 = CFrame.new(Vector3.new(0, 0, 0), v27).Rotation;
                if v17 and not v20 then
                    p14.CurrentHeading = p14.CurrentHeading:Lerp(l__Rotation__15, p15 * p14.MovementSettings.RotatingSpeed * (v18 and 1 or 0.3));
                end;
                p14.ControllerManager.MovingDirection = p14.CurrentHeading.LookVector;
                p14.ControllerManager.FacingDirection = p14.CurrentHeading.LookVector;
                if not v18 then
                    local v28 = 0;
                    for _, v29 in p14.MountRoot:GetTouchingParts() do
                        if not p14.FullPartsLookup[v29] and (not v29:IsDescendantOf(p14.Instance) and v29.CanCollide) then
                            v28 = v28 + 1;
                        end;
                    end;
                    if v28 == 0 then
                        p14.MountRoot.AssemblyLinearVelocity = p14.ControllerManager.MovingDirection * l__Value__14 * Vector3.new(1, 0, 1) + p14.MountRoot.AssemblyLinearVelocity * Vector3.new(0, 1, 0);
                    end;
                end;
            end;
            p14.Animations.Run:AdjustSpeed(l__Value__14 / p14.MovementSettings.WalkSpeed * 1);
            if l__Value__14 > 3 and not p14.Animations.Run.IsPlaying then
                p14.Animations.Run:Play(0.5);
                p14.Replicate:FireServer("Run");
            elseif l__Value__14 <= 3 and p14.Animations.Run.IsPlaying then
                p14.Animations.Run:Stop(0.5);
                p14.Replicate:FireServer("Run", true);
            end;
            if p14.WasGrounded and not v18 then
                p14.Replicate:FireServer("Fall");
                p14.Animations.Fall:Play();
            elseif not p14.WasGrounded and v18 then
                p14.Animations.Fall:Stop();
                p14.Replicate:FireServer("Fall", true);
            end;
            if v18 then
                p14.JumpsOnGround = 0;
            end;
            p14.WasGrounded = v18;
            debug.profileend();
        end;
    end;
end;
function u5.SitHumanoid(u30, u31) --[[ Line: 251 ]]
    -- upvalues: u5 (copy), u2 (copy), l__UserInputService__1 (copy), l__RunService__3 (copy)
    local l__Animator__16 = u31:WaitForChild("Animator");
    u30.CurrentHeading = CFrame.new(Vector3.new(0, 0, 0), u30.ControllerManager.FacingDirection);
    u30.Player = {
        Humanoid = u31,
        Animations = {}
    };
    for _, v32 in u30.Instance.Animations.Player:GetChildren() do
        u30.Player.Animations[v32.Name] = l__Animator__16:LoadAnimation(v32);
    end;
    u30.Player.Animations.Idle:Play();
    local v33 = u30.MountRoot:GetConnectedParts();
    u30.FullPartsLookup = {};
    for _, v34 in v33 do
        u30.FullPartsLookup[v34] = true;
    end;
    u30.TimeBreaking = 0;
    u30.AssemblyMass = u30.MountRoot.AssemblyMass;
    local v35 = u30.AssemblyMass * -game.Workspace.Gravity * u30.MovementSettings.FloatPercentage;
    u30.LinearVelocity.VectorVelocity = v35 * Vector3.new(0, 1, 0);
    u30.LinearVelocity.MaxForce = v35;
    if not u31:GetAttribute("OGJumpPower") then
        u31:SetAttribute("OGJumpPower", u31.JumpPower);
    end;
    u31.JumpPower = 0;
    u31:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
    u5.Interface.Enabled = true;
    u2.StartInteractions();
    u30.LastHumanoid = u31;
    u30.SitMaid:Add(function() --[[ Line: 296 ]]
        -- upvalues: u30 (copy), u31 (copy), u5 (ref), u2 (ref)
        for _, v36 in u30.Player.Animations do
            v36:Stop(0);
        end;
        u31.JumpPower = u31:GetAttribute("OGJumpPower");
        u31:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
        u5.Interface.Enabled = false;
        u2.EndInteractions();
    end);
    u30.SitMaid:Add(l__UserInputService__1.JumpRequest:Connect(function() --[[ Line: 307 ]]
        -- upvalues: u30 (copy)
        if u30.WasGrounded then
            u30:Jump();
        else
            if u30.JumpsOnGround <= u30.MovementSettings.ExtraJumps - 1 then
                u30:Jump(true);
            end;
        end;
    end));
    u30.SitMaid:Add(l__RunService__3.RenderStepped:Connect(function(p37) --[[ Line: 314 ]]
        -- upvalues: u30 (copy)
        u30:PostAnimation(p37);
    end));
    u30.SitMaid:Add(l__RunService__3.Heartbeat:Connect(function(p38) --[[ Line: 317 ]]
        -- upvalues: u30 (copy)
        u30:UpdateMovement(p38);
    end));
end;
function u5.Jump(p39, p40) --[[ Line: 322 ]]
    p39.WasGrounded = false;
    p39.JumpsOnGround = p39.JumpsOnGround + 1;
    if p40 then
        (p39.Animations.JumpAlt or p39.Animations.Jump):Play(0);
        local l__MountRoot__17 = p39.MountRoot;
        l__MountRoot__17.AssemblyLinearVelocity = l__MountRoot__17.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
    else
        p39.Animations.Jump:Play(0);
        local l__Velocity__18 = p39.Instance.Velocity;
        l__Velocity__18.Value = l__Velocity__18.Value + p39.MovementSettings.ExtraSpeedFromJump;
    end;
    p39.Replicate:FireServer("Jump");
    p39.MountRoot:ApplyImpulse(p39.AssemblyMass * Vector3.new(0, p39.MovementSettings.JumpForce, 0));
end;
function u5.OccupantChanged(p41, p42) --[[ Line: 341 ]]
    if p42 then
        p41:SitHumanoid(p42);
    else
        p41.SitMaid:Clean();
    end;
end;
function u5.Construct(u43) --[[ Line: 350 ]]
    -- upvalues: l__LocalPlayer__7 (copy), l__Deepcopy__10 (copy), u4 (copy), l__Maid__11 (copy)
    if u43.OwnerId == l__LocalPlayer__7.UserId then
        u43.Body = u43.Instance:WaitForChild("Body");
        u43.BodyRoot = u43.Body.PrimaryPart or u43.Body:waitForChild("RootPart");
        u43.AnimationController = u43.Body:WaitForChild("AnimationController");
        u43.Animator = u43.AnimationController:WaitForChild("Animator");
        u43.Replicate = u43.Instance:WaitForChild("Replicate");
        u43.SettingsConfiguration = u43.Instance:WaitForChild("Settings");
        u43.MountRoot = u43.Instance:WaitForChild("MountRoot");
        u43.ControllerPartSensor = u43.MountRoot:WaitForChild("ControllerPartSensor");
        u43.ControllerManager = u43.MountRoot:WaitForChild("ControllerManager");
        u43.AirController = u43.ControllerManager:WaitForChild("AirController");
        u43.GroundController = u43.ControllerManager:WaitForChild("GroundController");
        u43.LinearVelocity = u43.Instance.MountRoot:WaitForChild("LinearVelocity");
        u43.AssemblyMass = u43.MountRoot.AssemblyMass;
        u43.SpecialBones = {};
        u43.MovementSettings = l__Deepcopy__10(u4);
        for v44, v45 in u43.SettingsConfiguration:GetAttributes() do
            u43.MovementSettings[v44] = v45;
        end;
        if u43.MovementSettings.SpeedMult then
            local l__MovementSettings__19 = u43.MovementSettings;
            l__MovementSettings__19.WalkSpeed = l__MovementSettings__19.WalkSpeed * u43.MovementSettings.SpeedMult;
            local l__MovementSettings__20 = u43.MovementSettings;
            l__MovementSettings__20.ExtraSpeedFromJump = l__MovementSettings__20.ExtraSpeedFromJump * u43.MovementSettings.SpeedMult;
        end;
        u43.JumpsOnGround = 0;
        u43.NeckOffset = CFrame.new();
        for _, v46 in u43.BodyRoot:GetDescendants() do
            if v46:IsA("Bone") and v46:HasTag("SpecialBone") then
                u43.SpecialBones[v46:GetAttribute("Name")] = v46;
            end;
        end;
        u43.Maid = l__Maid__11.new();
        u43.SitMaid = l__Maid__11.new();
        u43.Seat = u43.Instance:WaitForChild("Seat");
        u43.Maid:Add(u43.Seat:GetPropertyChangedSignal("Occupant"):Connect(function(_) --[[ Line: 400 ]]
            -- upvalues: u43 (copy)
            u43:OccupantChanged(u43.Seat.Occupant);
        end));
        u43.Maid:Add(u43.Instance.AncestryChanged:Connect(function() --[[ Line: 404 ]]
            -- upvalues: u43 (copy)
            print("hi!", u43.Instance.Parent);
            if u43.Instance.Parent == nil then
                u43:Removing();
            end;
        end));
        u43.Maid:Add(function() --[[ Line: 411 ]]
            -- upvalues: u43 (copy)
            u43.SitMaid:Clean();
        end);
        if u43.Seat.Occupant then
            u43:OccupantChanged(u43.Seat.Occupant);
        end;
        u43.AnimationFolder = u43.Instance.Animations.Mount;
        u43.Animations = {};
        for _, v47 in u43.AnimationFolder:GetChildren() do
            u43.Animations[v47.Name] = u43.Animator:LoadAnimation(v47);
        end;
    else
        warn("Blocked!");
    end;
end;
function u5.Removing(p48) --[[ Line: 428 ]]
    -- upvalues: l__LocalPlayer__7 (copy), l__ReplicatedStorage__2 (copy), l__Debris__6 (copy)
    if p48.OwnerId == l__LocalPlayer__7.UserId then
        print(p48.MovementSettings.DissapearParticles, p48.LastHumanoid);
        if p48.MovementSettings.DissapearParticles and p48.LastHumanoid then
            local v49 = Instance.new("Part");
            v49.CanQuery = false;
            v49.CanCollide = false;
            v49.CFrame = p48.LastHumanoid.RootPart.CFrame;
            v49.Size = p48.LastHumanoid.RootPart.Size;
            v49.Transparency = 1;
            v49.Anchored = true;
            v49.Parent = game.Workspace;
            local v50 = l__ReplicatedStorage__2.Assets.EffectParticles.Cartoon:Clone();
            v50.Enabled = false;
            v50.Parent = v49;
            v50:Emit(30);
            l__Debris__6:AddItem(v49, 4);
        end;
        p48.Maid:Clean();
        p48.SitMaid:Clean();
    end;
end;
function u5.Setup(_) --[[ Line: 456 ]]
    -- upvalues: u5 (copy), u1 (copy), u3 (copy)
    u5.Interface = u1.GetScreenGui("Unmount");
    u1.NewButton(u5.Interface.OkayButton).Activated:Connect(function() --[[ Line: 458 ]]
        -- upvalues: u3 (ref)
        u3:Fire();
    end);
end;
return u5;
