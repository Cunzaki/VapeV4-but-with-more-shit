-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__TweenService__2 = game:GetService("TweenService");
local l__VRService__3 = game:GetService("VRService");
local l__Parent__4 = script.Parent;
local l__Head__5 = require(l__Parent__4:WaitForChild("Character"):WaitForChild("Head"));
local l__Torso__6 = require(l__Parent__4:WaitForChild("Character"):WaitForChild("Torso"));
local l__Appendage__7 = require(l__Parent__4:WaitForChild("Character"):WaitForChild("Appendage"));
local l__FootPlanter__8 = require(l__Parent__4:WaitForChild("Character"):WaitForChild("FootPlanter"));
local u1 = require(l__Parent__4:WaitForChild("State"):WaitForChild("EnigmaService")).GetInstance();
local u2 = require(l__Parent__4:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local u3 = require(l__Parent__4:WaitForChild("State"):WaitForChild("VRInputService")).GetInstance();
local l__NexusAppendage__9 = require(l__Parent__4:WaitForChild("Packages"):WaitForChild("NexusAppendage"));
local l__UpdateInputs__10 = l__Parent__4:WaitForChild("UpdateInputs");
local l__Appendage__11 = l__NexusAppendage__9.Appendage;
local u4 = {};
u4.__index = u4;
function u4.new(p5) --[[ Line: 58 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy), u4 (copy), l__VRService__3 (copy), u3 (copy), l__UpdateInputs__10 (copy)
    local v6 = {
        CharacterModel = p5,
        TweenComponents = p5 ~= l__Players__1.LocalPlayer.Character,
        UseIKControl = u2:GetSetting("Extra.TEMPORARY_UseIKControl")
    };
    local u7 = setmetatable(v6, u4);
    local v8 = false;
    local v9;
    if l__Players__1.LocalPlayer and l__Players__1.LocalPlayer.Character == p5 then
        v9 = u2:GetSetting("Appearance.LocalAllowArmDisconnection") == false and true or v8;
    else
        v9 = u2:GetSetting("Appearance.NonLocalAllowArmDisconnection") == false and true or v8;
    end;
    u7.Humanoid = p5:WaitForChild("Humanoid");
    u7.CurrentWalkspeed = 0;
    u7.Humanoid.Running:Connect(function(p10) --[[ Line: 83 ]]
        -- upvalues: l__VRService__3 (ref), u3 (ref), u7 (copy)
        u7.CurrentWalkspeed = l__VRService__3.AvatarGestures and u3:GetThumbstickPosition(Enum.KeyCode.Thumbstick1).Magnitude < 0.2 and 0 or p10;
    end);
    u7.PreventArmDisconnection = v9;
    u7:SetUpVRParts();
    u7.AppearanceChangedConnection = nil;
    u7:SetUpAppearanceChanged();
    u7.CurrentMotor6DTransforms = {};
    u7.LastMotor6DTransforms = {};
    u7.LastRefreshTime = tick();
    if l__Players__1.LocalPlayer and l__Players__1.LocalPlayer.Character == p5 then
        task.spawn(function() --[[ Line: 104 ]]
            -- upvalues: u7 (copy), l__VRService__3 (ref), l__UpdateInputs__10 (ref)
            while u7.Humanoid.Health > 0 do
                local l__ReplicationCFrames__12 = u7.ReplicationCFrames;
                local l__ReplicationTrackerData__13 = u7.ReplicationTrackerData;
                if l__ReplicationCFrames__12 and (u7.LastReplicationCFrames ~= l__ReplicationCFrames__12 and u7.LastReplicationTrackerData ~= l__ReplicationTrackerData__13) then
                    u7.LastReplicationCFrames = l__ReplicationCFrames__12;
                    u7.LastReplicationTrackerData = l__ReplicationTrackerData__13;
                    local v11 = {
                        UpdateTime = tick(),
                        CurrentWalkspeed = u7.CurrentWalkspeed
                    };
                    local v12;
                    if l__ReplicationTrackerData__13 then
                        v12 = l__ReplicationTrackerData__13.LeftFoot;
                    else
                        v12 = l__ReplicationTrackerData__13;
                    end;
                    v11.LeftFootCFrame = v12;
                    if l__ReplicationTrackerData__13 then
                        l__ReplicationTrackerData__13 = l__ReplicationTrackerData__13.RightFoot;
                    end;
                    v11.RightFootCFrame = l__ReplicationTrackerData__13;
                    if not l__VRService__3.AvatarGestures then
                        v11.HeadCFrame = l__ReplicationCFrames__12.HeadCFrame;
                        v11.LeftHandCFrame = l__ReplicationCFrames__12.LeftHandCFrame;
                        v11.RightHandCFrame = l__ReplicationCFrames__12.RightHandCFrame;
                    end;
                    l__UpdateInputs__10:FireServer(v11);
                end;
                task.wait(0.03333333333333333);
            end;
        end);
    end;
    return u7;
end;
function u4.SetUpVRParts(p13) --[[ Line: 139 ]]
    -- upvalues: l__Head__5 (copy), l__Torso__6 (copy), l__Appendage__11 (copy), l__Appendage__7 (copy), l__FootPlanter__8 (copy)
    local l__CharacterModel__14 = p13.CharacterModel;
    local l__PreventArmDisconnection__15 = p13.PreventArmDisconnection;
    p13.Parts = {
        Head = l__CharacterModel__14:WaitForChild("Head"),
        UpperTorso = l__CharacterModel__14:WaitForChild("UpperTorso"),
        LowerTorso = l__CharacterModel__14:WaitForChild("LowerTorso"),
        HumanoidRootPart = l__CharacterModel__14:WaitForChild("HumanoidRootPart"),
        RightUpperArm = l__CharacterModel__14:WaitForChild("RightUpperArm"),
        RightLowerArm = l__CharacterModel__14:WaitForChild("RightLowerArm"),
        RightHand = l__CharacterModel__14:WaitForChild("RightHand"),
        LeftUpperArm = l__CharacterModel__14:WaitForChild("LeftUpperArm"),
        LeftLowerArm = l__CharacterModel__14:WaitForChild("LeftLowerArm"),
        LeftHand = l__CharacterModel__14:WaitForChild("LeftHand"),
        RightUpperLeg = l__CharacterModel__14:WaitForChild("RightUpperLeg"),
        RightLowerLeg = l__CharacterModel__14:WaitForChild("RightLowerLeg"),
        RightFoot = l__CharacterModel__14:WaitForChild("RightFoot"),
        LeftUpperLeg = l__CharacterModel__14:WaitForChild("LeftUpperLeg"),
        LeftLowerLeg = l__CharacterModel__14:WaitForChild("LeftLowerLeg"),
        LeftFoot = l__CharacterModel__14:WaitForChild("LeftFoot")
    };
    p13.Motors = {
        Neck = p13.Parts.Head:WaitForChild("Neck"),
        Waist = p13.Parts.UpperTorso:WaitForChild("Waist"),
        Root = p13.Parts.LowerTorso:WaitForChild("Root"),
        RightShoulder = p13.Parts.RightUpperArm:WaitForChild("RightShoulder"),
        RightElbow = p13.Parts.RightLowerArm:WaitForChild("RightElbow"),
        RightWrist = p13.Parts.RightHand:WaitForChild("RightWrist"),
        LeftShoulder = p13.Parts.LeftUpperArm:WaitForChild("LeftShoulder"),
        LeftElbow = p13.Parts.LeftLowerArm:WaitForChild("LeftElbow"),
        LeftWrist = p13.Parts.LeftHand:WaitForChild("LeftWrist"),
        RightHip = p13.Parts.RightUpperLeg:WaitForChild("RightHip"),
        RightKnee = p13.Parts.RightLowerLeg:WaitForChild("RightKnee"),
        RightAnkle = p13.Parts.RightFoot:WaitForChild("RightAnkle"),
        LeftHip = p13.Parts.LeftUpperLeg:WaitForChild("LeftHip"),
        LeftKnee = p13.Parts.LeftLowerLeg:WaitForChild("LeftKnee"),
        LeftAnkle = p13.Parts.LeftFoot:WaitForChild("LeftAnkle")
    };
    p13.Attachments = {
        Head = {
            NeckRigAttachment = p13.Parts.Head:WaitForChild("NeckRigAttachment")
        },
        UpperTorso = {
            NeckRigAttachment = p13.Parts.UpperTorso:WaitForChild("NeckRigAttachment"),
            LeftShoulderRigAttachment = p13.Parts.UpperTorso:WaitForChild("LeftShoulderRigAttachment"),
            RightShoulderRigAttachment = p13.Parts.UpperTorso:WaitForChild("RightShoulderRigAttachment"),
            WaistRigAttachment = p13.Parts.UpperTorso:WaitForChild("WaistRigAttachment")
        },
        LowerTorso = {
            WaistRigAttachment = p13.Parts.LowerTorso:WaitForChild("WaistRigAttachment"),
            LeftHipRigAttachment = p13.Parts.LowerTorso:WaitForChild("LeftHipRigAttachment"),
            RightHipRigAttachment = p13.Parts.LowerTorso:WaitForChild("RightHipRigAttachment"),
            RootRigAttachment = p13.Parts.LowerTorso:WaitForChild("RootRigAttachment")
        },
        HumanoidRootPart = {
            RootRigAttachment = p13.Parts.HumanoidRootPart:WaitForChild("RootRigAttachment")
        },
        RightUpperArm = {
            RightShoulderRigAttachment = p13.Parts.RightUpperArm:WaitForChild("RightShoulderRigAttachment"),
            RightElbowRigAttachment = p13.Parts.RightUpperArm:WaitForChild("RightElbowRigAttachment")
        },
        RightLowerArm = {
            RightElbowRigAttachment = p13.Parts.RightLowerArm:WaitForChild("RightElbowRigAttachment"),
            RightWristRigAttachment = p13.Parts.RightLowerArm:WaitForChild("RightWristRigAttachment")
        },
        RightHand = {
            RightWristRigAttachment = p13.Parts.RightHand:WaitForChild("RightWristRigAttachment")
        },
        LeftUpperArm = {
            LeftShoulderRigAttachment = p13.Parts.LeftUpperArm:WaitForChild("LeftShoulderRigAttachment"),
            LeftElbowRigAttachment = p13.Parts.LeftUpperArm:WaitForChild("LeftElbowRigAttachment")
        },
        LeftLowerArm = {
            LeftElbowRigAttachment = p13.Parts.LeftLowerArm:WaitForChild("LeftElbowRigAttachment"),
            LeftWristRigAttachment = p13.Parts.LeftLowerArm:WaitForChild("LeftWristRigAttachment")
        },
        LeftHand = {
            LeftWristRigAttachment = p13.Parts.LeftHand:WaitForChild("LeftWristRigAttachment")
        },
        RightUpperLeg = {
            RightHipRigAttachment = p13.Parts.RightUpperLeg:WaitForChild("RightHipRigAttachment"),
            RightKneeRigAttachment = p13.Parts.RightUpperLeg:WaitForChild("RightKneeRigAttachment")
        },
        RightLowerLeg = {
            RightKneeRigAttachment = p13.Parts.RightLowerLeg:WaitForChild("RightKneeRigAttachment"),
            RightAnkleRigAttachment = p13.Parts.RightLowerLeg:WaitForChild("RightAnkleRigAttachment")
        },
        RightFoot = {
            RightAnkleRigAttachment = p13.Parts.RightFoot:WaitForChild("RightAnkleRigAttachment"),
            RightFootAttachment = p13.Parts.RightFoot:FindFirstChild("RightFootAttachment")
        },
        LeftUpperLeg = {
            LeftHipRigAttachment = p13.Parts.LeftUpperLeg:WaitForChild("LeftHipRigAttachment"),
            LeftKneeRigAttachment = p13.Parts.LeftUpperLeg:WaitForChild("LeftKneeRigAttachment")
        },
        LeftLowerLeg = {
            LeftKneeRigAttachment = p13.Parts.LeftLowerLeg:WaitForChild("LeftKneeRigAttachment"),
            LeftAnkleRigAttachment = p13.Parts.LeftLowerLeg:WaitForChild("LeftAnkleRigAttachment")
        },
        LeftFoot = {
            LeftAnkleRigAttachment = p13.Parts.LeftFoot:WaitForChild("LeftAnkleRigAttachment"),
            LeftFootAttachment = p13.Parts.LeftFoot:FindFirstChild("LeftFootAttachment")
        }
    };
    if not p13.Motors.Neck:IsA("Motor6D") then
        p13.UseIKControl = true;
    end;
    if not p13.Attachments.RightFoot.RightFootAttachment then
        local v14 = Instance.new("Attachment");
        v14.Position = Vector3.new(0, -p13.Parts.RightFoot.Size.Y / 2, 0);
        v14.Name = "RightFootAttachment";
        local v15 = Instance.new("Vector3Value");
        v15.Name = "OriginalPosition";
        v15.Value = v14.Position;
        v15.Parent = v14;
        v14.Parent = p13.Parts.RightFoot;
        p13.Attachments.RightFoot.RightFootAttachment = v14;
    end;
    if not p13.Attachments.LeftFoot.LeftFootAttachment then
        local v16 = Instance.new("Attachment");
        v16.Position = Vector3.new(0, -p13.Parts.LeftFoot.Size.Y / 2, 0);
        v16.Name = "LeftFootAttachment";
        local v17 = Instance.new("Vector3Value");
        v17.Name = "OriginalPosition";
        v17.Value = v16.Position;
        v17.Parent = v16;
        v16.Parent = p13.Parts.LeftFoot;
        p13.Attachments.LeftFoot.LeftFootAttachment = v16;
    end;
    p13.Head = l__Head__5.new(p13.Parts.Head);
    p13.Torso = l__Torso__6.new(p13.Parts.LowerTorso, p13.Parts.UpperTorso);
    if p13.UseIKControl then
        p13.LeftArm = l__Appendage__11.FromPreset("LeftArm", l__CharacterModel__14, not l__PreventArmDisconnection__15, p13.TweenComponents and 0.1 or 0);
        p13.RightArm = l__Appendage__11.FromPreset("RightArm", l__CharacterModel__14, not l__PreventArmDisconnection__15, p13.TweenComponents and 0.1 or 0);
        p13.LeftLeg = l__Appendage__11.FromPreset("LeftLeg", l__CharacterModel__14, false, p13.TweenComponents and 0.1 or 0);
        p13.RightLeg = l__Appendage__11.FromPreset("RightLeg", l__CharacterModel__14, false, p13.TweenComponents and 0.1 or 0);
    else
        local v18 = l__Appendage__7.new(l__CharacterModel__14:WaitForChild("LeftUpperArm"), l__CharacterModel__14:WaitForChild("LeftLowerArm"), l__CharacterModel__14:WaitForChild("LeftHand"), "LeftShoulderRigAttachment", "LeftElbowRigAttachment", "LeftWristRigAttachment", "LeftGripAttachment", l__PreventArmDisconnection__15);
        local v19 = l__Appendage__7.new(l__CharacterModel__14:WaitForChild("RightUpperArm"), l__CharacterModel__14:WaitForChild("RightLowerArm"), l__CharacterModel__14:WaitForChild("RightHand"), "RightShoulderRigAttachment", "RightElbowRigAttachment", "RightWristRigAttachment", "RightGripAttachment", l__PreventArmDisconnection__15);
        local v20 = l__Appendage__7.new(l__CharacterModel__14:WaitForChild("LeftUpperLeg"), l__CharacterModel__14:WaitForChild("LeftLowerLeg"), l__CharacterModel__14:WaitForChild("LeftFoot"), "LeftHipRigAttachment", "LeftKneeRigAttachment", "LeftAnkleRigAttachment", "LeftFootAttachment", true);
        v20.InvertBendDirection = true;
        local v21 = l__Appendage__7.new(l__CharacterModel__14:WaitForChild("RightUpperLeg"), l__CharacterModel__14:WaitForChild("RightLowerLeg"), l__CharacterModel__14:WaitForChild("RightFoot"), "RightHipRigAttachment", "RightKneeRigAttachment", "RightAnkleRigAttachment", "RightFootAttachment", true);
        v21.InvertBendDirection = true;
        p13.LeftArm = v18;
        p13.RightArm = v19;
        p13.LeftLeg = v20;
        p13.RightLeg = v21;
    end;
    p13.FootPlanter = l__FootPlanter__8:CreateSolver(l__CharacterModel__14:WaitForChild("LowerTorso"), p13.Humanoid:FindFirstChild("BodyHeightScale"));
end;
function u4.SetUpAppearanceChanged(u22) --[[ Line: 303 ]]
    local l__Humanoid__16 = u22.CharacterModel:WaitForChild("Humanoid");
    if u22.AppearanceChangedConnection then
        u22.AppearanceChangedConnection:Disconnect();
        u22.AppearanceChangedConnection = nil;
    end;
    u22.AppearanceChangedConnection = l__Humanoid__16.ChildAdded:Connect(function(p23) --[[ Line: 313 ]]
        -- upvalues: u22 (copy)
        if p23:IsA("HumanoidDescription") then
            u22:SetUpVRParts();
        end;
    end);
end;
function u4.GetHumanoidScale(p24, p25) --[[ Line: 326 ]]
    local v26 = p24.Humanoid:FindFirstChild(p25);
    return not v26 and (p25 == "BodyTypeScale" and 0 or 1) or v26.Value;
end;
function u4.GetHumanoidSeatPart(p27) --[[ Line: 340 ]]
    if not p27.Humanoid.Sit then
        return nil;
    end;
    if p27.Humanoid.SeatPart then
        return p27.Humanoid.SeatPart;
    end;
    for _, v28 in p27.Parts.HumanoidRootPart:GetConnectedParts() do
        if v28:IsA("Seat") or v28:IsA("VehicleSeat") then
            return v28;
        end;
    end;
    return nil;
end;
function u4.SetCFrameProperty(p29, p30, p31, p32) --[[ Line: 366 ]]
    -- upvalues: l__TweenService__2 (copy)
    if p29.TweenComponents and p31 ~= "Transform" then
        l__TweenService__2:Create(p30, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            [p31] = p32
        }):Play();
    else
        p30[p31] = p32;
    end;
    if p31 == "Transform" then
        p29.CurrentMotor6DTransforms[p30] = p32;
    end;
end;
function u4.SetTransform(p33, p34, p35, p36, p37, p38, p39) --[[ Line: 386 ]]
    p33:SetCFrameProperty(p33.Motors[p34], "Transform", (p38 * p33.Attachments[p36][p35].CFrame):Inverse() * (p39 * p33.Attachments[p37][p35].CFrame));
end;
function u4.RefreshCharacter(p40) --[[ Line: 394 ]]
    if p40.TweenComponents then
        local v41 = (tick() - p40.LastRefreshTime) / 0.03333333333333333;
        local v42 = math.min(v41, 1);
        for v43, v44 in p40.CurrentMotor6DTransforms do
            local v45 = p40.LastMotor6DTransforms[v43];
            if v45 then
                v43.Transform = v45:Lerp(v44, v42);
            else
                v43.Transform = v44;
            end;
        end;
    else
        for v46, v47 in p40.CurrentMotor6DTransforms do
            v46.Transform = v47;
        end;
    end;
end;
function u4.UpdateFromInputs(p48, p49, p50, p51, p52, p53) --[[ Line: 416 ]]
    -- upvalues: l__Players__1 (copy), u1 (copy), l__VRService__3 (copy)
    if p48.Humanoid.Health <= 0 then
    elseif p48:GetHumanoidSeatPart() then
        p48:UpdateFromInputsSeated(p49, p50, p51);
    else
        for v54, _ in p48.CurrentMotor6DTransforms do
            p48.LastMotor6DTransforms[v54] = v54.Transform;
        end;
        p48.LastRefreshTime = tick();
        local v55 = p49 or p48.Parts.Head.CFrame * p48.Head:GetEyesOffset();
        local v56 = p48.Head:GetHeadCFrame(v55);
        local v57 = p48.Head:GetNeckCFrame(v55);
        local v58, v59 = p48.Torso:GetTorsoCFrames(v57);
        local v60 = p48.Torso:GetAppendageJointCFrames(v58, v59);
        local l__LocalPlayer__17 = l__Players__1.LocalPlayer;
        if l__LocalPlayer__17 then
            l__LocalPlayer__17 = l__Players__1.LocalPlayer.Character == p48.CharacterModel;
        end;
        local v61, v62 = p48.FootPlanter:GetFeetCFrames();
        local v63 = false;
        local v64 = false;
        local v65;
        if p53 and p53.LeftFoot then
            v65 = p53.LeftFoot;
            v63 = true;
        else
            v65 = v61 * CFrame.Angles(0, 3.141592653589793, 0);
        end;
        local v66;
        if p53 and p53.RightFoot then
            v66 = p53.RightFoot;
            v64 = true;
        else
            v66 = v62 * CFrame.Angles(0, 3.141592653589793, 0);
        end;
        if l__LocalPlayer__17 then
            local v67 = u1:GetCFrames(p48);
            if v67.LeftFoot then
                v65 = v67.LeftFoot;
                v63 = true;
            end;
            if v67.RightFoot then
                v66 = v67.RightFoot;
                v64 = true;
            end;
            p48.ReplicationTrackerData = {
                LeftFoot = v67.LeftFoot,
                RightFoot = v67.RightFoot
            };
        end;
        local l__AvatarGestures__18 = l__VRService__3.AvatarGestures;
        local v68 = (p52 or p48.CurrentWalkspeed) > 0.1;
        local v69 = v58 * p48.Attachments.LowerTorso.RootRigAttachment.CFrame * p48.Attachments.HumanoidRootPart.RootRigAttachment.CFrame:Inverse();
        local v70 = p48.Parts.HumanoidRootPart.CFrame.Y - v69.Y;
        local v71 = CFrame.new(v69.Position) * CFrame.Angles(0, math.atan2(v69.LookVector.X, v69.LookVector.Z) + 3.141592653589793, 0);
        if not l__AvatarGestures__18 then
            p48:SetCFrameProperty(p48.Parts.HumanoidRootPart, "CFrame", CFrame.new(0, v70, 0) * v71);
            p48:SetCFrameProperty(p48.Motors.Root, "Transform", CFrame.new(0, -v70, 0) * (v71 * p48.Attachments.HumanoidRootPart.RootRigAttachment.CFrame):Inverse() * v58 * p48.Attachments.LowerTorso.RootRigAttachment.CFrame);
            p48:SetTransform("Neck", "NeckRigAttachment", "UpperTorso", "Head", v59, v56);
            p48:SetTransform("Waist", "WaistRigAttachment", "LowerTorso", "UpperTorso", v58, v59);
        end;
        if p48.UseIKControl then
            if not l__AvatarGestures__18 and (p50 and p51) then
                p48.LeftArm:MoveToWorld(p50);
                p48.RightArm:MoveToWorld(p51);
            end;
            if v68 or l__AvatarGestures__18 and not v63 then
                p48.LeftLeg:Disable();
            else
                p48.LeftLeg:MoveToWorld(v65);
                p48.LeftLeg:Enable();
            end;
            if v68 or l__AvatarGestures__18 and not v64 then
                p48.RightLeg:Disable();
            else
                p48.RightLeg:MoveToWorld(v66);
                p48.RightLeg:Enable();
            end;
        else
            if not l__AvatarGestures__18 then
                local v72, v73, v74 = p48.LeftArm:GetAppendageCFrames(v60.LeftShoulder, p50);
                local v75, v76, v77 = p48.RightArm:GetAppendageCFrames(v60.RightShoulder, p51);
                p48:SetTransform("RightShoulder", "RightShoulderRigAttachment", "UpperTorso", "RightUpperArm", v59, v75);
                p48:SetTransform("RightElbow", "RightElbowRigAttachment", "RightUpperArm", "RightLowerArm", v75, v76);
                p48:SetTransform("RightWrist", "RightWristRigAttachment", "RightLowerArm", "RightHand", v76, v77);
                p48:SetTransform("LeftShoulder", "LeftShoulderRigAttachment", "UpperTorso", "LeftUpperArm", v59, v72);
                p48:SetTransform("LeftElbow", "LeftElbowRigAttachment", "LeftUpperArm", "LeftLowerArm", v72, v73);
                p48:SetTransform("LeftWrist", "LeftWristRigAttachment", "LeftLowerArm", "LeftHand", v73, v74);
            end;
            if v68 or l__AvatarGestures__18 and not v63 then
                p48.CurrentMotor6DTransforms[p48.Motors.LeftHip] = nil;
                p48.CurrentMotor6DTransforms[p48.Motors.LeftKnee] = nil;
                p48.CurrentMotor6DTransforms[p48.Motors.LeftAnkle] = nil;
            else
                local v78, v79, v80 = p48.LeftLeg:GetAppendageCFrames(v60.LeftHip, v65);
                p48:SetTransform("LeftHip", "LeftHipRigAttachment", "LowerTorso", "LeftUpperLeg", v58, v78);
                p48:SetTransform("LeftKnee", "LeftKneeRigAttachment", "LeftUpperLeg", "LeftLowerLeg", v78, v79);
                p48:SetTransform("LeftAnkle", "LeftAnkleRigAttachment", "LeftLowerLeg", "LeftFoot", v79, v80);
            end;
            if v68 or l__AvatarGestures__18 and not v64 then
                p48.CurrentMotor6DTransforms[p48.Motors.RightHip] = nil;
                p48.CurrentMotor6DTransforms[p48.Motors.RightKnee] = nil;
                p48.CurrentMotor6DTransforms[p48.Motors.RightAnkle] = nil;
            else
                local v81, v82, v83 = p48.RightLeg:GetAppendageCFrames(v60.RightHip, v66);
                p48:SetTransform("RightHip", "RightHipRigAttachment", "LowerTorso", "RightUpperLeg", v58, v81);
                p48:SetTransform("RightKnee", "RightKneeRigAttachment", "RightUpperLeg", "RightLowerLeg", v81, v82);
                p48:SetTransform("RightAnkle", "RightAnkleRigAttachment", "RightLowerLeg", "RightFoot", v82, v83);
            end;
        end;
        if l__LocalPlayer__17 then
            p48.ReplicationCFrames = {
                HeadCFrame = p49,
                LeftHandCFrame = p50,
                RightHandCFrame = p51
            };
        end;
    end;
end;
function u4.UpdateFromInputsSeated(p84, p85, p86, p87) --[[ Line: 557 ]]
    -- upvalues: l__VRService__3 (copy), l__Players__1 (copy)
    if p84.Humanoid.Health <= 0 then
    elseif l__VRService__3.AvatarGestures or not (p85 and (p86 and p87)) then
    else
        local v88 = p84.Head:GetHeadCFrame(p85);
        local v89 = p84.Head:GetNeckCFrame(p85, 0);
        local v90, v91 = p84.Torso:GetTorsoCFrames(v89);
        local v92 = p84.Torso:GetAppendageJointCFrames(v90, v91);
        local v93 = p84.Head:GetEyesOffset();
        local v94 = CFrame.new(0, (CFrame.new(0, v93.Y, 0) * (p85 * v93:Inverse())).Y, 0);
        p84:SetCFrameProperty(p84.Motors.Root, "Transform", v94 * CFrame.new(0, -v90.Y, 0) * v90);
        p84:SetTransform("Neck", "NeckRigAttachment", "UpperTorso", "Head", v91, v88);
        p84:SetTransform("Waist", "WaistRigAttachment", "LowerTorso", "UpperTorso", v90, v91);
        if p84.UseIKControl then
            local v95 = p84.Parts.Head.CFrame * v93;
            p84.LeftArm:MoveToWorld(v95 * p85:Inverse() * p86);
            p84.RightArm:MoveToWorld(v95 * p85:Inverse() * p87);
            p84.LeftLeg:Disable();
            p84.RightLeg:Disable();
        else
            local v96, v97, v98 = p84.LeftArm:GetAppendageCFrames(v92.LeftShoulder, p86);
            local v99, v100, v101 = p84.RightArm:GetAppendageCFrames(v92.RightShoulder, p87);
            p84:SetTransform("RightShoulder", "RightShoulderRigAttachment", "UpperTorso", "RightUpperArm", v91, v99);
            p84:SetTransform("RightElbow", "RightElbowRigAttachment", "RightUpperArm", "RightLowerArm", v99, v100);
            p84:SetTransform("RightWrist", "RightWristRigAttachment", "RightLowerArm", "RightHand", v100, v101);
            p84:SetTransform("LeftShoulder", "LeftShoulderRigAttachment", "UpperTorso", "LeftUpperArm", v91, v96);
            p84:SetTransform("LeftElbow", "LeftElbowRigAttachment", "LeftUpperArm", "LeftLowerArm", v96, v97);
            p84:SetTransform("LeftWrist", "LeftWristRigAttachment", "LeftLowerArm", "LeftHand", v97, v98);
        end;
        p84.CurrentMotor6DTransforms[p84.Motors.RightHip] = nil;
        p84.CurrentMotor6DTransforms[p84.Motors.LeftHip] = nil;
        p84.CurrentMotor6DTransforms[p84.Motors.RightKnee] = nil;
        p84.CurrentMotor6DTransforms[p84.Motors.LeftKnee] = nil;
        p84.CurrentMotor6DTransforms[p84.Motors.RightAnkle] = nil;
        p84.CurrentMotor6DTransforms[p84.Motors.LeftAnkle] = nil;
        if l__Players__1.LocalPlayer and l__Players__1.LocalPlayer.Character == p84.CharacterModel then
            p84.ReplicationCFrames = {
                HeadCFrame = p85,
                LeftHandCFrame = p86,
                RightHandCFrame = p87
            };
        end;
    end;
end;
return u4;
