-- Decompiled from: ReplicatedStorage.Client.Source.Movement.Locomotion
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__VRService__1 = game:GetService("VRService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__RunService__4 = game:GetService("RunService");
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
local l__PlayerModule__6 = l__LocalPlayer__5.PlayerScripts:WaitForChild("PlayerModule");
local l__ControlModule__7 = require(l__PlayerModule__6.ControlModule);
local u1 = require(l__PlayerModule__6);
local l__Mince__8 = require(game.ReplicatedStorage.Modules.Mince);
local l__Signal__9 = require(l__ReplicatedStorage__3.Modules.Signal);
local u2 = l__Mince__8:Get("BindManager");
local u3 = l__Mince__8:Get("Intoxication");
local u4 = {
    VelocityMoveRate = 1,
    Velocity = 0,
    Friction = 0.5,
    AirResistance = 0.999,
    BreakForce = 0.95,
    BaseSpeed = 16,
    StrafeAccerlation = 1.1,
    TerimalVelocity = 60,
    Locked = false,
    IsUpdating = true,
    MovementEnabled = true,
    AlwaysClampVelocity = true,
    IsEnabled = true,
    IntoxElapsed = 0,
    IntoxApplyVelocityDecimal = 0.2,
    StumbleMultipler = 3,
    TargetWalkingSpeed = 16,
    StartingVelocityDecimal = 1,
    LastDirection = Vector3.new(0, 0, 0),
    UseCustomVelocity = false,
    CustomVelocityFrictionMultiplier = 2,
    CustomVelocityStrafeAccerlation = 1.01,
    MaterialFrictions = {}
};
function lerp(p5, p6, p7)
    return p5 * (1 - p7) + p6 * p7;
end;
function u4.SetWalkDecimal(p8, p9) --[[ Line: 57 ]]
    -- upvalues: u4 (copy)
    if p9 and p9 ~= 0 then
        local v10 = 0;
        repeat
            v10 = v10 + task.wait();
            local v11 = lerp(u4.BaseSpeed / u4.TargetWalkingSpeed, p8, v10 / p9);
            u4.BaseSpeed = u4.TargetWalkingSpeed * v11;
        until p9 < v10;
        u4.BaseSpeed = u4.TargetWalkingSpeed * p8;
    else
        u4.BaseSpeed = u4.TargetWalkingSpeed * p8;
    end;
end;
function u4.SetUpdating(p12) --[[ Line: 74 ]]
    -- upvalues: u4 (copy)
    u4.IsUpdating = p12;
end;
function u4.SetEnabled(p13) --[[ Line: 79 ]]
    -- upvalues: u4 (copy)
    if p13 then
        u4.Controls:Enable();
    else
        u4.Controls:Disable();
    end;
    u4.MovementEnabled = p13;
end;
function u4.PopCaptures() --[[ Line: 88 ]]
    -- upvalues: u4 (copy)
    pcall(function() --[[ Line: 89 ]]
        -- upvalues: u4 (ref)
        u4.Locked = false;
        u4.Humanoid.JumpHeight = game.StarterPlayer.CharacterJumpHeight;
    end);
end;
function u4.Capture(p14, p15) --[[ Line: 95 ]]
    -- upvalues: u4 (copy), l__Signal__9 (copy), l__UserInputService__2 (copy), u2 (copy)
    if not u4.Humanoid then
        warn("no humanoid!");
        local v16 = l__Signal__9.new();
        v16:FireDeferred();
        return v16;
    end;
    local u17 = false;
    local u18 = l__Signal__9.new();
    local u19 = {
        JumpRequest = l__UserInputService__2.JumpRequest:Once(function() --[[ Line: 105 ]]
            -- upvalues: u17 (ref), u4 (ref)
            if u17 then
                u4.Locked = false;
            end;
        end)
    };
    local l__Humanoid__10 = u4.Humanoid;
    u4.Humanoid.JumpHeight = 0;
    u4.CanUnlockWithMovements = not p15;
    u2.ForceMobileJumpButton(true);
    task.delay(p14 or 0, function() --[[ Line: 117 ]]
        -- upvalues: u17 (ref), u4 (ref)
        u17 = true;
        u4.Locked = true;
        u4.SetEnabled(true);
    end);
    task.spawn(function() --[[ Line: 123 ]]
        -- upvalues: u17 (ref), u4 (ref), l__Humanoid__10 (copy), u18 (copy)
        repeat
            task.wait();
        until u17 and not u4.Locked;
        if l__Humanoid__10 == u4.Humanoid then
            l__Humanoid__10.JumpHeight = game.StarterPlayer.CharacterJumpHeight;
        end;
        u18:Fire();
    end);
    u18:Connect(function() --[[ Line: 133 ]]
        -- upvalues: u2 (ref), u19 (copy), u18 (copy)
        task.wait();
        u2.ForceMobileJumpButton(false);
        for _, v20 in u19 do
            v20:Disconnect();
        end;
        u18:Destroy();
    end);
    return u18;
end;
function u4.Move(_, _, _) --[[ Line: 148 ]] end;
function u4.MoveCharacter(p21) --[[ Line: 151 ]]
    -- upvalues: u4 (copy)
    u4.HumanoidRootPart.AssemblyLinearVelocity = p21 + u4.HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(0, 1, 0);
end;
function u4.GetFrictionForMaterial(p22) --[[ Line: 156 ]]
    -- upvalues: u4 (copy)
    local v23 = u4.MaterialFrictions[p22];
    if not v23 then
        v23 = PhysicalProperties.new(p22).Friction;
        u4.MaterialFrictions[p22] = v23;
    end;
    return v23;
end;
function u4.SetXEnabled(p24) --[[ Line: 168 ]]
    -- upvalues: u4 (copy)
    u4.XEnabled = p24;
end;
function u4.IsMoving() --[[ Line: 172 ]]
    -- upvalues: l__ControlModule__7 (copy)
    return l__ControlModule__7:GetMoveVector().Magnitude > 0;
end;
function u4.GetMoveVector(_) --[[ Line: 179 ]]
    -- upvalues: l__ControlModule__7 (copy)
    return l__ControlModule__7:GetMoveVector();
end;
function u4.SetLocomotionEnabled(p25) --[[ Line: 183 ]]
    -- upvalues: u4 (copy)
    u4.IsEnabled = p25;
    if u4.Humanoid then
        u4.Humanoid:Move(Vector3.new(0, 0, 0), false);
    end;
end;
function u4.Update(p26) --[[ Line: 190 ]]
    -- upvalues: u4 (copy), l__ControlModule__7 (copy), l__VRService__1 (copy), u3 (copy), l__Mince__8 (copy)
    if u4.IsEnabled then
        if l__ControlModule__7:GetActiveController() then
            if u4.Humanoid then
                if u4.IsUpdating then
                    if l__VRService__1.VREnabled then
                        u4.Humanoid.WalkSpeed = u4.BaseSpeed;
                    else
                        local v27 = u4;
                        v27.IntoxElapsed = v27.IntoxElapsed + p26;
                        local v28 = u3.GetLevel();
                        local l__CurrentCamera__11 = workspace.CurrentCamera;
                        local v29 = u4.Humanoid:GetState() == Enum.HumanoidStateType.Climbing;
                        local v30;
                        if u4.Humanoid.FloorMaterial == Enum.Material.Air then
                            v30 = false;
                        else
                            v30 = u4.Humanoid.FloorMaterial ~= nil;
                        end;
                        local v31 = u4.GetFrictionForMaterial(u4.Humanoid.FloorMaterial);
                        local v32 = l__ControlModule__7:GetMoveVector();
                        local v33 = math.sin(u4.IntoxElapsed) / 2 * v28 * u4.IntoxApplyVelocityDecimal;
                        if v29 then
                            v31 = 1;
                            v30 = true;
                        end;
                        if u4.Locked then
                            u4.Humanoid.WalkSpeed = 0;
                            if v32.Magnitude > 0 and u4.CanUnlockWithMovements then
                                u4.Locked = false;
                            end;
                        else
                            if u4.UseCustomVelocity then
                                v32 = v32 / v32.Magnitude;
                                v31 = v31 * u4.CustomVelocityFrictionMultiplier;
                            end;
                            if not v30 then
                                v32 = v32 * Vector3.new(u4.StrafeAccerlation, 1, 1);
                            end;
                            local l__Magnitude__12 = v32.Magnitude;
                            if l__Magnitude__12 > 0 then
                                local v34 = math.min(u4.TargetWalkingSpeed, u4.BaseSpeed) * u4.StartingVelocityDecimal;
                                u4.Velocity = math.clamp(u4.Velocity, v34, u4.TerimalVelocity);
                                local v35 = u4;
                                v35.Velocity = v35.Velocity + u4.BaseSpeed * (p26 * u4.VelocityMoveRate);
                                local v36 = u4;
                                v36.Velocity = v36.Velocity * (1 - v33);
                            end;
                            if v30 and l__Magnitude__12 == 0 then
                                local v37 = u4;
                                v37.Velocity = v37.Velocity * math.clamp(1 - (v31 + 0.3), 0, 1);
                            end;
                            if not v30 then
                                local v38 = u4;
                                v38.Velocity = v38.Velocity * u4.AirResistance;
                            end;
                            if v30 or u4.AlwaysClampVelocity then
                                u4.Velocity = math.clamp(u4.Velocity, 0, u4.BaseSpeed);
                            end;
                            if u4.Velocity > 0 and u4.Velocity < 0.001 then
                                u4.Velocity = 0;
                            end;
                            if u4.MovementEnabled then
                                u4.Humanoid.WalkSpeed = u4.Velocity;
                            else
                                u4.Humanoid.WalkSpeed = 0;
                            end;
                            if u4.Velocity ~= 0 and u4.MovementEnabled then
                                local v39 = math.noise(u4.IntoxElapsed, 0);
                                local v40 = math.noise(0, u4.IntoxElapsed);
                                local v41 = Vector3.new(v39, v40, math.noise(u4.IntoxElapsed, u4.IntoxElapsed)) * v28 * u4.StumbleMultipler;
                                local v42, v43, v44 = (l__CurrentCamera__11.CFrame - l__CurrentCamera__11.CFrame.Position):ToOrientation();
                                local v45 = (CFrame.new(l__CurrentCamera__11.CFrame.Position) * CFrame.fromOrientation(v42 * (u4.XEnabled and 1 or 0), v43 + v41.Y, v44 + v41.Z)):VectorToWorldSpace(v32);
                                local v46 = v45 * 10;
                                if l__Magnitude__12 == 0 then
                                    local v47 = u4;
                                    v47.LastDirection = v47.LastDirection * u4.BreakForce;
                                    if u4.UseCustomVelocity then
                                        u4.MoveCharacter(u4.LastDirection);
                                        return;
                                    end;
                                    u4.Humanoid:Move(u4.LastDirection, false);
                                else
                                    if u4.UseCustomVelocity then
                                        u4.LastDirection = v45 * u4.Velocity;
                                        u4.MoveCharacter(u4.LastDirection);
                                        return;
                                    end;
                                    u4.LastDirection = v46;
                                    u4.Humanoid:Move(u4.LastDirection, false);
                                end;
                            end;
                            l__Mince__8.Config.Stats.Locomotion = { 1, (`Velocity:{u4.Velocity}.`) };
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u4.NewCharacter(p48) --[[ Line: 312 ]]
    -- upvalues: u4 (copy)
    local l__Humanoid__13 = p48:WaitForChild("Humanoid");
    local l__HumanoidRootPart__14 = p48:WaitForChild("HumanoidRootPart");
    Instance.new("Attachment").Parent = l__HumanoidRootPart__14;
    local u49 = Instance.new("NumberValue");
    u49.Name = "BaseSpeed";
    u49.Value = u4.BaseSpeed;
    u49.Parent = l__Humanoid__13;
    u49:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 324 ]]
        -- upvalues: u4 (ref), u49 (copy)
        u4.BaseSpeed = u49.Value;
    end);
    if u4.UseCustomVelocity then
        for _, v50 in p48:GetDescendants() do
            if v50:IsA("BasePart") then
                v50.Massless = true;
            end;
        end;
    end;
    l__Humanoid__13:GetAttributeChangedSignal("Jump"):Connect(function() --[[ Line: 338 ]]
        -- upvalues: l__Humanoid__13 (copy)
        local v51 = l__Humanoid__13:GetAttribute("Jump");
        l__Humanoid__13.JumpHeight = game.StarterPlayer.CharacterJumpHeight * v51;
    end);
    l__Humanoid__13:GetAttributeChangedSignal("Speed"):Connect(function() --[[ Line: 343 ]]
        -- upvalues: l__Humanoid__13 (copy), u4 (ref)
        local v52 = l__Humanoid__13:GetAttribute("Speed");
        u4.SetWalkDecimal(v52, 0.5);
    end);
    u4.Locked = false;
    u4.IsUpdating = true;
    u4.MovementEnabled = true;
    u4.CanUnlockWithMovements = true;
    u4.BaseSpeed = u4.TargetWalkingSpeed;
    u4.Humanoid = l__Humanoid__13;
    u4.HumanoidRootPart = l__HumanoidRootPart__14;
    u4.IsEnabled = true;
    u4.SetEnabled(true);
    u4.SetXEnabled(false);
    u4.PopCaptures();
end;
function u4.Setup() --[[ Line: 365 ]]
    -- upvalues: u1 (copy), u4 (copy), l__ControlModule__7 (copy), l__VRService__1 (copy), l__LocalPlayer__5 (copy), l__Mince__8 (copy), l__RunService__4 (copy)
    local v53 = u1:GetControls();
    u4.RobloxMoveFunction = l__ControlModule__7.moveFunction;
    if not l__VRService__1.VREnabled then
        l__ControlModule__7.moveFunction = u4.Move;
    end;
    u4.Controls = v53;
    if l__LocalPlayer__5.Character then
        u4.NewCharacter(l__LocalPlayer__5.Character);
    end;
    if u4.UseCustomVelocity then
        u4.StrafeAccerlation = u4.CustomVelocityStrafeAccerlation;
    end;
    l__Mince__8.Config.Stats.Locomotion = { 1, "IDLE" };
    l__LocalPlayer__5.CharacterAdded:Connect(u4.NewCharacter);
    l__RunService__4.RenderStepped:Connect(u4.Update);
end;
return u4;
