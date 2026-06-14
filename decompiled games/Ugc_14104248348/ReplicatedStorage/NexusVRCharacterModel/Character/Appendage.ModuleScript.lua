-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Appendage
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Limb__1 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusAppendage")).Limb;
local u1 = {};
u1.__index = u1;
setmetatable(u1, l__Limb__1);
function u1.new(p2, p3, p4, p5, p6, p7, p8, p9) --[[ Line: 28 ]]
    -- upvalues: l__Limb__1 (copy), u1 (copy)
    local v10 = l__Limb__1.new();
    local v11 = setmetatable(v10, u1);
    v11.UpperLimb = p2;
    v11.LowerLimb = p3;
    v11.LimbEnd = p4;
    v11.StartAttachment = p5;
    v11.LimbJointAttachment = p6;
    v11.LimbEndAttachment = p7;
    v11.LimbHoldAttachment = p8;
    v11.InvertBendDirection = false;
    v11.PreventDisconnection = p9 or false;
    return setmetatable(v11, u1);
end;
function u1.SolveJoint(p12, p13, p14, p15, p16) --[[ Line: 46 ]]
    local v17 = p13:PointToObjectSpace(p14);
    local l__Unit__2 = v17.Unit;
    local l__Magnitude__3 = v17.Magnitude;
    local v18 = (Vector3.new(0, 0, -1)):Cross(l__Unit__2);
    local v19 = v18 == Vector3.new(0, 0, 0) and (v17.Z < 0 and Vector3.new(0, 0, 0.001) or Vector3.new(0, 0, -0.001)) or v18;
    local v20 = math.acos(-l__Unit__2.Z);
    local v21 = p13 * CFrame.fromAxisAngle(v19, v20);
    if l__Magnitude__3 < math.max(p16, p15) - math.min(p16, p15) then
        if p12.PreventDisconnection then
            return v21, -1.5707963267948966, 3.141592653589793;
        else
            return v21 * CFrame.new(0, 0, math.max(p16, p15) - math.min(p16, p15) - l__Magnitude__3), -1.5707963267948966, 3.141592653589793;
        end;
    elseif p15 + p16 < l__Magnitude__3 then
        if p12.PreventDisconnection then
            return v21, 1.5707963267948966, 0;
        else
            return v21 * CFrame.new(0, 0, p15 + p16 - l__Magnitude__3), 1.5707963267948966, 0;
        end;
    else
        local v22 = -math.acos((-(p16 * p16) + p15 * p15 + l__Magnitude__3 * l__Magnitude__3) / (p15 * 2 * l__Magnitude__3));
        local v23 = math.acos((p16 * p16 - p15 * p15 + l__Magnitude__3 * l__Magnitude__3) / (p16 * 2 * l__Magnitude__3));
        if p12.InvertBendDirection then
            v22 = -v22;
            v23 = -v23;
        end;
        return v21, v22 + 1.5707963267948966, v23 - v22;
    end;
end;
function u1.RotationTo(_, p24, p25) --[[ Line: 93 ]]
    local l__Position__4 = (p24:Inverse() * p25).Position;
    return CFrame.Angles(math.atan2(l__Position__4.Z, l__Position__4.Y), 0, -math.atan2(l__Position__4.X, l__Position__4.Y));
end;
function u1.GetAppendageCFrames(p26, p27, p28) --[[ Line: 103 ]]
    local v29 = p26:GetAttachmentCFrame(p26.LimbEnd, p26.LimbHoldAttachment);
    local v30 = p26:GetAttachmentCFrame(p26.LimbEnd, p26.LimbEndAttachment);
    local v31 = p26:GetAttachmentCFrame(p26.UpperLimb, p26.StartAttachment);
    local v32 = p26:GetAttachmentCFrame(p26.UpperLimb, p26.LimbJointAttachment);
    local v33 = p26:GetAttachmentCFrame(p26.LowerLimb, p26.LimbJointAttachment);
    local v34 = p26:GetAttachmentCFrame(p26.LowerLimb, p26.LimbEndAttachment);
    local l__Magnitude__5 = (v31.Position - v32.Position).Magnitude;
    local l__Magnitude__6 = (v33.Position - v34.Position).Magnitude;
    local v35 = p28 * v29:Inverse() * v30;
    local v36, v37, v38 = p26:SolveJoint(p27, v35.Position, l__Magnitude__5, l__Magnitude__6);
    local v39 = v36 * CFrame.Angles(v37, 0, 0) * CFrame.new(0, -l__Magnitude__5, 0);
    local v40 = v39 * CFrame.Angles(v38, 0, 0);
    local v41 = v39 * p26:RotationTo(v32, v31):Inverse() * v32:Inverse();
    local v42 = v40 * p26:RotationTo(v34, v33):Inverse() * v33:Inverse();
    return v41, v42, CFrame.new((v42 * v34).Position) * (CFrame.new(-v35.Position) * v35) * v30:Inverse();
end;
return u1;
