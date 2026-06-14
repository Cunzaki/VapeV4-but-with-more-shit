-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Controller.BaseController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad);
local u2 = {
    [Enum.UserCFrame.LeftHand] = Enum.KeyCode.Thumbstick1,
    [Enum.UserCFrame.RightHand] = Enum.KeyCode.Thumbstick2
};
local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__HttpService__3 = game:GetService("HttpService");
local l__ContextActionService__4 = game:GetService("ContextActionService");
local l__TweenService__5 = game:GetService("TweenService");
local l__VRService__6 = game:GetService("VRService");
local l__Parent__7 = script.Parent.Parent.Parent;
local l__Api__8 = require(l__Parent__7).Api;
require(l__Parent__7:WaitForChild("Character"));
local u3 = require(l__Parent__7:WaitForChild("State"):WaitForChild("CameraService")).GetInstance();
local u4 = require(l__Parent__7:WaitForChild("State"):WaitForChild("CharacterService")).GetInstance();
local u5 = require(l__Parent__7:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local u6 = require(l__Parent__7:WaitForChild("State"):WaitForChild("VRInputService")).GetInstance();
local u7 = {};
u7.__index = u7;
function u7.new() --[[ Line: 55 ]]
    -- upvalues: u7 (copy)
    return setmetatable({
        Active = false,
        ActionsToLock = { Enum.KeyCode.ButtonR3 }
    }, u7);
end;
function u7.UpdateCharacterReference(p8) --[[ Line: 65 ]]
    -- upvalues: u4 (copy), l__Players__2 (copy)
    local l__Character__9 = p8.Character;
    p8.Character = u4:GetCharacter(l__Players__2.LocalPlayer);
    if p8.Character then
        return l__Character__9 ~= p8.Character;
    else
        return false;
    end;
end;
function u7.Enable(u9) --[[ Line: 77 ]]
    -- upvalues: l__HttpService__3 (copy), l__ContextActionService__4 (copy), u6 (copy)
    if not u9.Connections then
        u9.Connections = {};
    end;
    u9.Active = true;
    if not u9.ActionsToUnbind then
        u9.ActionsToUnbind = {};
    end;
    for _, v10 in u9.ActionsToLock do
        local v11 = l__HttpService__3:GenerateGUID();
        l__ContextActionService__4:BindActionAtPriority(v11, function() --[[ Line: 85 ]]
            -- upvalues: u9 (copy)
            return u9.Active and Enum.ContextActionResult.Sink or Enum.ContextActionResult.Pass;
        end, false, Enum.ContextActionPriority.High.Value, v10);
        table.insert(u9.ActionsToUnbind, v11);
    end;
    u9:UpdateCharacterReference();
    if u9.Character then
        local l__Connections__10 = u9.Connections;
        local v12 = u6.EyeLevelSet:Connect(function() --[[ Line: 99 ]]
            -- upvalues: u9 (copy)
            local l__LastHeadCFrame__11 = u9.LastHeadCFrame;
            if l__LastHeadCFrame__11 and l__LastHeadCFrame__11.Y > 0 then
                u9.LastHeadCFrame = CFrame.new(0, -l__LastHeadCFrame__11.Y, 0) * l__LastHeadCFrame__11;
            end;
        end);
        table.insert(l__Connections__10, v12);
        local v13 = u9.Character.Humanoid:GetPropertyChangedSignal("SeatPart");
        table.insert(l__Connections__10, v13:Connect(function() --[[ Line: 107 ]]
            -- upvalues: u9 (copy), u6 (ref)
            if u9.Character:GetHumanoidSeatPart() then
                u9:PlayBlur();
                u6:Recenter();
            end;
        end));
        u9.Character.Humanoid.AutoRotate = false;
    end;
end;
function u7.Disable(p14) --[[ Line: 122 ]]
    -- upvalues: l__ContextActionService__4 (copy)
    p14.Active = false;
    p14.Character = nil;
    p14.LastHeadCFrame = nil;
    p14.LastRotationUpdateTick = nil;
    if p14.Connections then
        for _, v15 in p14.Connections do
            v15:Disconnect();
        end;
    end;
    if p14.ActionsToUnbind then
        for _, v16 in p14.ActionsToUnbind do
            l__ContextActionService__4:UnbindAction(v16);
        end;
    end;
    p14.Connections = nil;
end;
function u7.ScaleInput(p17, p18) --[[ Line: 144 ]]
    if p17.Character and p18 then
        return CFrame.new(p18.Position * (p17.Character:GetHumanoidScale("BodyHeightScale") - 1)) * p18;
    else
        return p18;
    end;
end;
function u7.GetJoystickState(_, p19) --[[ Line: 159 ]]
    -- upvalues: u6 (copy)
    local v20 = u6:GetThumbstickPosition(p19.Thumbstick);
    local v21 = (v20.X ^ 2 + v20.Y ^ 2) ^ 0.5;
    local v22 = math.atan2(v20.X, v20.Y);
    local v23 = v22 >= -2.356194490192345 and v22 <= -0.7853981633974483 and "Left" or (v22 >= -0.7853981633974483 and v22 <= 0.7853981633974483 and "Forward" or (v22 >= 0.7853981633974483 and v22 <= 2.356194490192345 and "Right" or nil));
    local v24 = v21 >= 0.6 and "Extended" or (v21 <= 0.4 and "Released" or "InBetween");
    local v25 = nil;
    if v24 ~= "Released" then
        if v24 == "Extended" then
            if p19.RadiusState == nil or p19.RadiusState == "Released" then
                local v26 = p19.RadiusState ~= "Extended" and "Extended" or v25;
                p19.RadiusState = "Extended";
                p19.DirectionState = v23;
                return v23, v24, v26;
            end;
            if p19.DirectionState ~= v23 then
                v25 = p19.RadiusState ~= "Cancelled" and "Cancel" or v25;
                p19.RadiusState = "Cancelled";
                p19.DirectionState = nil;
            end;
        end;
        return v23, v24, v25;
    end;
    local v27 = p19.RadiusState == "Extended" and "Released" or v25;
    p19.RadiusState = "Released";
    p19.DirectionState = nil;
    return v23, v24, v27;
end;
function u7.PlayBlur(_) --[[ Line: 211 ]]
    -- upvalues: u5 (copy), l__TweenService__5 (copy), u1 (copy)
    local v28 = u5:GetSetting("Movement.SnapTeleportBlur");
    if v28 == nil and true or v28 then
        local u29 = Instance.new("BlurEffect");
        u29.Parent = workspace.CurrentCamera;
        u29.Size = 56;
        local v30 = l__TweenService__5:Create(u29, u1, {
            Size = 0
        });
        v30:Play();
        v30.Completed:Connect(function() --[[ Line: 226 ]]
            -- upvalues: u29 (copy)
            u29:Destroy();
        end);
    end;
end;
function u7.UpdateCharacter(p31) --[[ Line: 234 ]]
    -- upvalues: u6 (copy), l__Workspace__1 (copy), u3 (copy)
    local v32 = p31:UpdateCharacterReference();
    if p31.Character then
        if v32 then
            p31:Enable();
        end;
        local v33 = u6:GetVRInputs();
        local v34 = p31:ScaleInput(v33[Enum.UserCFrame.Head]);
        local v35 = p31:ScaleInput(v33[Enum.UserCFrame.LeftHand]);
        local v36 = p31:ScaleInput(v33[Enum.UserCFrame.RightHand]);
        local v37 = v34:Inverse() * v35;
        local v38 = v34:Inverse() * v36;
        if p31.Character:GetHumanoidSeatPart() then
            p31.Character:UpdateFromInputsSeated(v34, v34 * v37, v34 * v38);
        elseif p31.LastHeadCFrame then
            local v39 = p31.Character.Parts.HumanoidRootPart.CFrame * p31.Character.Attachments.HumanoidRootPart.RootRigAttachment.CFrame * CFrame.new(0, -p31.Character.Motors.Root.Transform.Position.Y, 0) * p31.Character.Motors.Root.Transform * p31.Character.Attachments.LowerTorso.RootRigAttachment.CFrame:Inverse() * p31.Character.Attachments.LowerTorso.WaistRigAttachment.CFrame * p31.Character.Motors.Waist.Transform * p31.Character.Attachments.UpperTorso.WaistRigAttachment.CFrame:Inverse() * p31.Character.Attachments.UpperTorso.NeckRigAttachment.CFrame * p31.Character.Motors.Neck.Transform * p31.Character.Attachments.Head.NeckRigAttachment.CFrame:Inverse();
            local v40 = p31.Character.Head:GetEyesOffset();
            local v41 = v39 * v40;
            local v42 = p31.LastHeadCFrame:Inverse() * v34;
            if v34.UpVector.Y < 0 then
                v42 = CFrame.Angles(0, 3.141592653589793, 0) * v42;
            end;
            local v43 = (CFrame.new(v34.Position) * CFrame.Angles(0, math.atan2(-v34.LookVector.X, -v34.LookVector.Z), 0)):Inverse() * v34;
            local l__LastHeadCFrame__12 = p31.LastHeadCFrame;
            local v44 = math.atan2(-l__LastHeadCFrame__12.LookVector.X, -l__LastHeadCFrame__12.LookVector.Z);
            local v45 = math.atan2(-v34.LookVector.X, -v34.LookVector.Z);
            local v46 = CFrame.new(0, (CFrame.new(0, v40.Y, 0) * (v34 * v40:Inverse())).Y, 0);
            local v47 = math.atan2(-v41.LookVector.X, -v41.LookVector.Z);
            local v48 = CFrame.Angles(0, v47 + (v45 - v44), 0);
            local l__Position__13 = (v46 * CFrame.new((v48 * CFrame.new(v42.X, 0, v42.Z)).Position) * v41).Position;
            local v49 = CFrame.new(l__Position__13) * v48 * v43;
            p31.Character:UpdateFromInputs(v49, v49 * v37, v49 * v38);
        end;
        if p31.Character.Parts.HumanoidRootPart:IsDescendantOf(l__Workspace__1) and p31.Character.Humanoid.Health > 0 then
            u3:UpdateCamera(p31.Character.Parts.HumanoidRootPart.CFrame * p31.Character.Attachments.HumanoidRootPart.RootRigAttachment.CFrame * p31.Character.Motors.Root.Transform * p31.Character.Attachments.LowerTorso.RootRigAttachment.CFrame:Inverse() * p31.Character.Attachments.LowerTorso.WaistRigAttachment.CFrame * p31.Character.Motors.Waist.Transform * p31.Character.Attachments.UpperTorso.WaistRigAttachment.CFrame:Inverse() * p31.Character.Attachments.UpperTorso.NeckRigAttachment.CFrame * p31.Character.Motors.Neck.Transform * p31.Character.Attachments.Head.NeckRigAttachment.CFrame:Inverse() * p31.Character.Head:GetEyesOffset());
            p31.LastHeadCFrame = v34;
        else
            if not l__Workspace__1.CurrentCamera.HeadLocked then
                local v50 = l__Workspace__1.CurrentCamera:GetRenderCFrame();
                local v51 = p31.LastHeadCFrame or CFrame.new();
                local v52 = p31:ScaleInput(u6:GetVRInputs()[Enum.UserCFrame.Head]);
                u3:UpdateCamera(v50 * v51:Inverse() * v52);
                p31.LastHeadCFrame = v52;
            end;
        end;
    end;
end;
function u7.UpdateRotating(p53, p54, p55, p56) --[[ Line: 312 ]]
    -- upvalues: l__VRService__6 (copy), l__Api__8 (copy), u6 (copy), u2 (copy)
    if l__VRService__6.AvatarGestures then
        p53.LastRotationUpdateTick = nil;
    elseif p53.Character and not p53.Character.Humanoid.Sit then
        if p55 == "Left" or p55 == "Right" then
            if l__Api__8.Controller and not l__Api__8.Controller:IsControllerInputEnabled(p54) then
            else
                local l__HumanoidRootPart__14 = p53.Character.Parts.HumanoidRootPart;
                if UserSettings():GetService("UserGameSettings").VRSmoothRotationEnabled then
                    local v57 = u6:GetThumbstickPosition(u2[p54]);
                    if math.abs(v57.X) >= 0.2 then
                        local v58 = p53.LastRotationUpdateTick or tick();
                        local v59 = tick();
                        local v60 = v59 - v58;
                        l__HumanoidRootPart__14.CFrame = CFrame.new(l__HumanoidRootPart__14.Position) * CFrame.Angles(0, -v57.X * 6.283185307179586 * v60, 0) * (CFrame.new(-l__HumanoidRootPart__14.Position) * l__HumanoidRootPart__14.CFrame);
                        p53.LastRotationUpdateTick = v59;
                    else
                        p53.LastRotationUpdateTick = nil;
                    end;
                else
                    if p56 == "Extended" then
                        if p55 == "Left" then
                            p53:PlayBlur();
                            l__HumanoidRootPart__14.CFrame = CFrame.new(l__HumanoidRootPart__14.Position) * CFrame.Angles(0, 0.5235987755982988, 0) * (CFrame.new(-l__HumanoidRootPart__14.Position) * l__HumanoidRootPart__14.CFrame);
                            return;
                        end;
                        if p55 == "Right" then
                            p53:PlayBlur();
                            l__HumanoidRootPart__14.CFrame = CFrame.new(l__HumanoidRootPart__14.Position) * CFrame.Angles(0, -0.5235987755982988, 0) * (CFrame.new(-l__HumanoidRootPart__14.Position) * l__HumanoidRootPart__14.CFrame);
                        end;
                    end;
                end;
            end;
        else
            p53.LastRotationUpdateTick = nil;
        end;
    else
        p53.LastRotationUpdateTick = nil;
    end;
end;
return u7;
