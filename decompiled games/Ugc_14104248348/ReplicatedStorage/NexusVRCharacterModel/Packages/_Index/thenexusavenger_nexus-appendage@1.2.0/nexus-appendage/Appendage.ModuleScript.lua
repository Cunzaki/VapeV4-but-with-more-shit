-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-appendage@1.2.0.nexus-appendage.Appendage
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Limb__1 = require(script.Parent:WaitForChild("Limb"));
local l__JointOffset__2 = require(script.Parent:WaitForChild("JointOffset"));
local u1 = {
    Presets = {
        LeftArm = {
            "UpperTorso",
            "LeftUpperArm",
            "LeftLowerArm",
            "LeftHand",
            "LeftShoulder",
            "LeftShoulderRigAttachment",
            "LeftElbowRigAttachment",
            "LeftWristRigAttachment",
            "LeftGripAttachment"
        },
        RightArm = {
            "UpperTorso",
            "RightUpperArm",
            "RightLowerArm",
            "RightHand",
            "RightShoulder",
            "RightShoulderRigAttachment",
            "RightElbowRigAttachment",
            "RightWristRigAttachment",
            "RightGripAttachment"
        },
        LeftLeg = {
            "LowerTorso",
            "LeftUpperLeg",
            "LeftLowerLeg",
            "LeftFoot",
            "LeftHip",
            "LeftHipRigAttachment",
            "LeftKneeRigAttachment",
            "LeftAnkleRigAttachment",
            "LeftFootAttachment"
        },
        RightLeg = {
            "LowerTorso",
            "RightUpperLeg",
            "RightLowerLeg",
            "RightFoot",
            "RightHip",
            "RightHipRigAttachment",
            "RightKneeRigAttachment",
            "RightAnkleRigAttachment",
            "RightFootAttachment"
        }
    },
    ConstraintPresets = {
        LeftArm = {
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "UpperTorso",
                    Attachment = "LeftShoulderRigAttachment",
                    Offset = CFrame.Angles(0, 3.141592653589793, 0)
                },
                Attachment1 = {
                    Part = "LeftUpperArm",
                    Attachment = "LeftShoulderRigAttachment",
                    Offset = CFrame.Angles(0, 3.141592653589793, -1.5707963267948966)
                },
                Properties = {
                    Name = "LeftShoulderBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 110,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = -85,
                    TwistUpperAngle = 85
                }
            },
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "LeftUpperArm",
                    Attachment = "LeftElbowRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "LeftLowerArm",
                    Attachment = "LeftElbowRigAttachment",
                    Offset = CFrame.identity
                },
                Properties = {
                    Name = "LeftElbowBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 20,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = 5,
                    TwistUpperAngle = 120
                }
            }
        },
        RightArm = {
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "UpperTorso",
                    Attachment = "RightShoulderRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "RightUpperArm",
                    Attachment = "RightShoulderRigAttachment",
                    Offset = CFrame.Angles(0, 0, -1.5707963267948966)
                },
                Properties = {
                    Name = "RightShoulderBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 110,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = -85,
                    TwistUpperAngle = 85
                }
            },
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "RightUpperArm",
                    Attachment = "RightElbowRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "RightLowerArm",
                    Attachment = "RightElbowRigAttachment",
                    Offset = CFrame.identity
                },
                Properties = {
                    Name = "RightElbowBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 20,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = 5,
                    TwistUpperAngle = 120
                }
            }
        },
        LeftLeg = {
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "LowerTorso",
                    Attachment = "LeftHipRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "LeftUpperLeg",
                    Attachment = "LeftHipRigAttachment",
                    Offset = CFrame.identity
                },
                Properties = {
                    Name = "LeftHipBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 40,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = -5,
                    TwistUpperAngle = 80
                }
            },
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "LeftUpperLeg",
                    Attachment = "LeftKneeRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "LeftLowerLeg",
                    Attachment = "LeftKneeRigAttachment",
                    Offset = CFrame.identity
                },
                Properties = {
                    Name = "LeftKneeBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 5,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = -120,
                    TwistUpperAngle = 5
                }
            }
        },
        RightLeg = {
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "LowerTorso",
                    Attachment = "RightHipRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "RightUpperLeg",
                    Attachment = "RightHipRigAttachment",
                    Offset = CFrame.identity
                },
                Properties = {
                    Name = "RightHipBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 40,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = -5,
                    TwistUpperAngle = 80
                }
            },
            {
                Type = "BallSocketConstraint",
                Attachment0 = {
                    Part = "RightUpperLeg",
                    Attachment = "RightKneeRigAttachment",
                    Offset = CFrame.identity
                },
                Attachment1 = {
                    Part = "RightLowerLeg",
                    Attachment = "RightKneeRigAttachment",
                    Offset = CFrame.identity
                },
                Properties = {
                    Name = "RightKneeBallSocket",
                    LimitsEnabled = true,
                    UpperAngle = 5,
                    TwistLimitsEnabled = true,
                    TwistLowerAngle = -120,
                    TwistUpperAngle = 5
                }
            }
        }
    }
};
u1.__index = u1;
setmetatable(u1, l__Limb__1);
function u1.new(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13) --[[ Line: 256 ]]
    -- upvalues: l__Limb__1 (copy), u1 (copy), l__JointOffset__2 (copy)
    local v14 = l__Limb__1.new();
    local v15 = setmetatable(v14, u1);
    v15.RootPart = p3;
    v15.UpperLimb = p4;
    v15.LowerLimb = p5;
    v15.LimbEnd = p6;
    v15.StartJointOffset = l__JointOffset__2.new(p4:WaitForChild(p7), p3, p8);
    v15.StartAttachment = p8;
    v15.LimbJointAttachment = p9;
    v15.LimbEndAttachment = p10;
    v15.LimbHoldAttachment = p11;
    v15.AllowDisconnection = p12 or false;
    v15.Constraints = {};
    if (p11 == "LeftFootAttachment" or p11 == "RightFootAttachment") and not p6:FindFirstChild(p11) then
        local v16 = Instance.new("Attachment");
        v16.Name = p11;
        v16.CFrame = CFrame.new(0, -p6.Size.Y / 2, 0);
        v16.Parent = p6;
        local v17 = Instance.new("Vector3Value");
        v17.Name = "OriginalPosition";
        v17.Value = v16.Position;
        v17.Parent = v16;
    end;
    if not p2:FindFirstChildOfClass("Animator") then
        Instance.new("Animator").Parent = p2;
    end;
    local v18 = Instance.new("Attachment");
    v18.Name = `{p4.Name}_{p5.Name}_Attachment`;
    v18.Parent = p3;
    v15.IKControlAttachment = v18;
    local v19 = Instance.new("IKControl");
    v19.Name = `{p4.Name}_{p5.Name}_IKControl`;
    v19.ChainRoot = p4;
    v19.EndEffector = p6;
    v19.Offset = v15:GetAttachmentCFrame(p6, p11):Inverse();
    v19.SmoothTime = p13 or 0;
    v19.Target = v18;
    v19.Parent = p2;
    v15.IKControl = v19;
    v15:MoveTo(v15:GetAttachmentCFrame(p4, p8):Inverse() * v15:GetAttachmentCFrame(p4, p9) * v15:GetAttachmentCFrame(p5, p9):Inverse() * v15:GetAttachmentCFrame(p5, p10) * v15:GetAttachmentCFrame(p6, p10):Inverse() * v15:GetAttachmentCFrame(p6, p11));
    return v15;
end;
function u1.FromPreset(p20, p21, p22, p23) --[[ Line: 312 ]]
    -- upvalues: u1 (copy)
    local v24 = u1.Presets[p20];
    local v25 = u1.new(p21:WaitForChild("Humanoid"), p21:WaitForChild(v24[1]), p21:WaitForChild(v24[2]), p21:WaitForChild(v24[3]), p21:WaitForChild(v24[4]), v24[5], v24[6], v24[7], v24[8], v24[9], p22, p23);
    v25:AddConstraints(p20, p21);
    return v25;
end;
function u1.AddConstraints(p26, p27, p28) --[[ Line: 322 ]]
    -- upvalues: u1 (copy)
    for _, v29 in u1.ConstraintPresets[p27] do
        local v30 = p28:WaitForChild(v29.Attachment0.Part);
        local v31 = p28:WaitForChild(v29.Attachment1.Part);
        if not v31:FindFirstChildOfClass(v29.Type) then
            local v32 = v30:WaitForChild(v29.Attachment0.Attachment);
            local v33;
            if v29.Attachment0.Offset == CFrame.identity then
                v33 = v32;
            else
                v33 = v32:Clone();
                v33.Name = "NexusAppendageConstraintOffset";
                v33.CFrame = v29.Attachment0.Offset;
                v33.Parent = v32;
                table.insert(p26.Constraints, v33);
            end;
            local v34 = v31:WaitForChild(v29.Attachment1.Attachment);
            local v35;
            if v29.Attachment1.Offset == CFrame.identity then
                v35 = v34;
            else
                v35 = v34:Clone();
                v35.Name = "NexusAppendageConstraintOffset";
                v35.CFrame = v29.Attachment1.Offset;
                v35.Parent = v34;
                table.insert(p26.Constraints, v35);
            end;
            local v36 = Instance.new(v29.Type);
            for v37, v38 in v29.Properties do
                v36[v37] = v38;
            end;
            v36.Attachment0 = v33;
            v36.Attachment1 = v35;
            v36.Parent = v31;
            table.insert(p26.Constraints, v36);
        end;
    end;
end;
function u1.Enable(p39) --[[ Line: 365 ]]
    p39.IKControl.Weight = 1;
end;
function u1.Disable(p40) --[[ Line: 372 ]]
    p40.IKControl.Weight = 0;
end;
function u1.SetTargetAttachment(p41, p42) --[[ Line: 380 ]]
    p41.IKControl.Target = p42 or p41.IKControlAttachment;
end;
function u1.SetSmoothTime(p43, p44) --[[ Line: 387 ]]
    p43.IKControl.SmoothTime = p44;
end;
function u1.MoveTo(p45, p46, p47) --[[ Line: 395 ]]
    p45.StartJointOffset:SetProperty(p45.IKControlAttachment, "CFrame", p45.StartJointOffset.AttachmentCFrame * p46, p47);
    if p45.AllowDisconnection then
        local v48 = p46 * p45:GetAttachmentCFrame(p45.LimbEnd, p45.LimbHoldAttachment):Inverse() * p45:GetAttachmentCFrame(p45.LimbEnd, p45.LimbEndAttachment);
        local l__Magnitude__3 = (p45:GetAttachmentCFrame(p45.UpperLimb, p45.StartAttachment):Inverse() * p45:GetAttachmentCFrame(p45.UpperLimb, p45.LimbJointAttachment) * p45:GetAttachmentCFrame(p45.LowerLimb, p45.LimbJointAttachment):Inverse() * p45:GetAttachmentCFrame(p45.LowerLimb, p45.LimbEndAttachment)).Position.Magnitude;
        local l__Magnitude__4 = v48.Position.Magnitude;
        if l__Magnitude__3 < l__Magnitude__4 then
            p45.StartJointOffset:SetOffset(CFrame.new(CFrame.new(Vector3.new(0, 0, 0), v48.Position).LookVector * (l__Magnitude__4 - l__Magnitude__3)), p47);
        else
            p45.StartJointOffset:SetOffset(CFrame.identity, p47);
        end;
    end;
end;
function u1.MoveToWorld(p49, p50, _) --[[ Line: 415 ]]
    p49:MoveTo((p49.RootPart.CFrame * p49.StartJointOffset.AttachmentCFrame):Inverse() * p50);
end;
function u1.Destroy(p51) --[[ Line: 423 ]]
    p51.StartJointOffset:Destroy();
    p51.IKControlAttachment:Destroy();
    p51.IKControl:Destroy();
    for _, v52 in p51.Constraints do
        v52:Destroy();
    end;
end;
return u1;
