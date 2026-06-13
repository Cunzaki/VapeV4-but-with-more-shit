-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Torso
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent;
local l__NexusAppendage__2 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusAppendage"));
local u1 = require(l__Parent__1:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local l__Limb__3 = l__NexusAppendage__2.Limb;
local u2 = {};
u2.__index = u2;
setmetatable(u2, l__Limb__3);
function u2.new(p3, p4) --[[ Line: 24 ]]
    -- upvalues: l__Limb__3 (copy), u2 (copy)
    local v5 = l__Limb__3.new();
    local v6 = setmetatable(v5, u2);
    v6.LowerTorso = p3;
    v6.UpperTorso = p4;
    return v6;
end;
function u2.GetTorsoCFrames(p7, p8) --[[ Line: 35 ]]
    -- upvalues: u1 (copy)
    local v9 = p8 * p7:GetAttachmentCFrame(p7.UpperTorso, "NeckRigAttachment"):Inverse();
    local v10 = u1:GetSetting("Appearance.MaxTorsoBend") or 0.17453292519943295;
    local v11 = math.asin(p8.LookVector.Y);
    local v12 = math.sign(v11);
    local v13 = math.abs(v11);
    local v14 = v12 * math.min(v13, v10);
    return v9 * p7:GetAttachmentCFrame(p7.UpperTorso, "WaistRigAttachment") * CFrame.Angles(-v14, 0, 0) * p7:GetAttachmentCFrame(p7.LowerTorso, "WaistRigAttachment"):Inverse(), v9;
end;
function u2.GetAppendageJointCFrames(p15, p16, p17) --[[ Line: 53 ]]
    return {
        RightShoulder = p17 * p15:GetAttachmentCFrame(p15.UpperTorso, "RightShoulderRigAttachment"),
        LeftShoulder = p17 * p15:GetAttachmentCFrame(p15.UpperTorso, "LeftShoulderRigAttachment"),
        LeftHip = p16 * p15:GetAttachmentCFrame(p15.LowerTorso, "LeftHipRigAttachment"),
        RightHip = p16 * p15:GetAttachmentCFrame(p15.LowerTorso, "RightHipRigAttachment")
    };
end;
return u2;
