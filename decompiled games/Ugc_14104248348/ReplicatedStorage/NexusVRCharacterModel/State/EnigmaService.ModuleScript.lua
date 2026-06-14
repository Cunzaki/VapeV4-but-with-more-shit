-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.EnigmaService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__VRService__5 = game:GetService("VRService");
local l__Parent__6 = script.Parent.Parent;
local l__Enigma__7 = require(l__Parent__6:WaitForChild("Packages"):WaitForChild("Enigma"));
local l__Head__8 = require(l__Parent__6:WaitForChild("Character"):WaitForChild("Head"));
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new() --[[ Line: 36 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        Offsets = {}
    }, u1);
end;
function u1.GetInstance() --[[ Line: 45 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.GetCFrames(p3, p4) --[[ Line: 55 ]]
    -- upvalues: l__Enigma__7 (copy), l__UserInputService__4 (copy)
    if not l__Enigma__7.Enabled then
        return {};
    end;
    local v5 = p4.Parts.Head.CFrame * p4.Head:GetEyesOffset() * l__UserInputService__4:GetUserCFrame(Enum.UserCFrame.Head):Inverse();
    local v6 = l__Enigma__7:GetUserCFrame("LeftFoot");
    local v7 = l__Enigma__7:GetUserCFrame("RightFoot");
    local v8 = {};
    if v6 and p3.Offsets.LeftFoot then
        v8.LeftFoot = v5 * v6 * p3.Offsets.LeftFoot;
    end;
    if v7 and p3.Offsets.RightFoot then
        v8.RightFoot = v5 * v7 * p3.Offsets.RightFoot;
    end;
    return v8;
end;
function u1.Calibrate(p9, p10) --[[ Line: 75 ]]
    -- upvalues: l__Enigma__7 (copy), l__Workspace__1 (copy), l__UserInputService__4 (copy), l__Head__8 (copy)
    if l__Enigma__7.Enabled then
        local v11 = l__Enigma__7:GetUserCFrame("LeftFoot");
        local v12 = l__Enigma__7:GetUserCFrame("RightFoot");
        if v11 or v12 then
            local l__Attachments__9 = p10.Attachments;
            local v13 = l__Workspace__1.CurrentCamera:GetRenderCFrame();
            local v14 = v13 * l__UserInputService__4:GetUserCFrame(Enum.UserCFrame.Head):Inverse();
            local v15 = v14 * l__UserInputService__4:GetUserCFrame(Enum.UserCFrame.Floor);
            local v16 = l__Head__8.new(p10.Parts.Head);
            local v17 = v16:GetNeckCFrame((v16:GetHeadCFrame(v13))) * l__Attachments__9.UpperTorso.NeckRigAttachment.CFrame:Inverse() * l__Attachments__9.UpperTorso.WaistRigAttachment.CFrame * l__Attachments__9.LowerTorso.WaistRigAttachment.CFrame:Inverse();
            if v11 then
                local v18 = v14 * v11;
                local v19 = v17 * l__Attachments__9.LowerTorso.LeftHipRigAttachment.CFrame * l__Attachments__9.LeftUpperLeg.LeftHipRigAttachment.CFrame:Inverse() * l__Attachments__9.LeftUpperLeg.LeftKneeRigAttachment.CFrame * l__Attachments__9.LeftLowerLeg.LeftKneeRigAttachment.CFrame:Inverse() * l__Attachments__9.LeftLowerLeg.LeftAnkleRigAttachment.CFrame * l__Attachments__9.LeftFoot.LeftAnkleRigAttachment.CFrame:Inverse();
                local v20 = CFrame.new(0, v15.Y - (v19 * l__Attachments__9.LeftFoot.LeftFootAttachment.CFrame).Y, 0) * v19;
                p9.Offsets.LeftFoot = v18:Inverse() * v20;
            end;
            if v12 then
                local v21 = v14 * v12;
                local v22 = v17 * l__Attachments__9.LowerTorso.RightHipRigAttachment.CFrame * l__Attachments__9.RightUpperLeg.RightHipRigAttachment.CFrame:Inverse() * l__Attachments__9.RightUpperLeg.RightKneeRigAttachment.CFrame * l__Attachments__9.RightLowerLeg.RightKneeRigAttachment.CFrame:Inverse() * l__Attachments__9.RightLowerLeg.RightAnkleRigAttachment.CFrame * l__Attachments__9.RightFoot.RightAnkleRigAttachment.CFrame:Inverse();
                local v23 = CFrame.new(0, v15.Y - (v22 * l__Attachments__9.RightFoot.RightFootAttachment.CFrame).Y, 0) * v22;
                p9.Offsets.RightFoot = v21:Inverse() * v23;
            end;
        end;
    end;
end;
function u1.Enable(_) --[[ Line: 113 ]]
    -- upvalues: l__Enigma__7 (copy), l__UserInputService__4 (copy), l__RunService__3 (copy), l__Players__2 (copy), l__Workspace__1 (copy), l__VRService__5 (copy)
    l__Enigma__7:Enable();
    local u24 = Vector3.new(0, 0, 0);
    local u25 = false;
    l__UserInputService__4.InputBegan:Connect(function(p26) --[[ Line: 121 ]]
        -- upvalues: u25 (ref)
        if p26.KeyCode == Enum.KeyCode.ButtonA then
            u25 = true;
        end;
    end);
    l__UserInputService__4.InputChanged:Connect(function(p27) --[[ Line: 126 ]]
        -- upvalues: u24 (ref)
        if p27.KeyCode == Enum.KeyCode.Thumbstick1 then
            if p27.Position.Magnitude > 0.2 then
                u24 = p27.Position;
                return;
            end;
            u24 = Vector3.new(0, 0, 0);
        end;
    end);
    l__UserInputService__4.InputEnded:Connect(function(p28) --[[ Line: 135 ]]
        -- upvalues: u24 (ref), u25 (ref)
        if p28.KeyCode == Enum.KeyCode.Thumbstick1 then
            u24 = Vector3.new(0, 0, 0);
        else
            if p28.KeyCode == Enum.KeyCode.ButtonA then
                u25 = false;
            end;
        end;
    end);
    l__RunService__3:BindToRenderStep("EnigmaCustomMovement", Enum.RenderPriority.Input.Value + 1, function() --[[ Line: 143 ]]
        -- upvalues: l__Enigma__7 (ref), l__Players__2 (ref), l__Workspace__1 (ref), u24 (ref), l__VRService__5 (ref), u25 (ref)
        if l__Enigma__7:IsActive() then
            local l__Character__10 = l__Players__2.LocalPlayer.Character;
            if l__Character__10 then
                local v29 = l__Character__10:FindFirstChildOfClass("Humanoid");
                if v29 and v29.Health > 0 then
                    local v30 = l__Workspace__1.CurrentCamera:GetRenderCFrame();
                    local l__Position__11 = (CFrame.new(-v30.Position) * v30 * CFrame.new(u24.X, 0, -u24.Y)).Position;
                    if l__Position__11.Magnitude > 0.01 or not l__VRService__5.AvatarGestures then
                        l__Players__2.LocalPlayer:Move(l__Position__11, false);
                    end;
                    if u25 then
                        v29.Jump = true;
                    end;
                end;
            end;
        end;
    end);
end;
return u1;
