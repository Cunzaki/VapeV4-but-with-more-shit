-- Decompiled from: ReplicatedStorage.Assets.Polaroid.Character
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local u1 = {
    Animations = {}
};
u1.__index = u1;
function u1.New(p2) --[[ Line: 11 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Character = p2;
    v3.Humanoid = p2:WaitForChild("Humanoid");
    v3.Animator = v3.Humanoid:WaitForChild("Animator");
    v3.HumanoidRootPart = p2:WaitForChild("HumanoidRootPart");
    v3.ArmIK = Instance.new("IKControl");
    v3:SetupIK();
    return v3;
end;
function u1.SetupIK(p4) --[[ Line: 27 ]]
    local l__ArmIK__1 = p4.ArmIK;
    l__ArmIK__1.Parent = p4.Humanoid;
    l__ArmIK__1.Type = Enum.IKControlType.Position;
    l__ArmIK__1.ChainRoot = p4.Character:WaitForChild("RightUpperArm");
    l__ArmIK__1.EndEffector = p4.Character:WaitForChild("RightHand");
    l__ArmIK__1.Weight = 0.1;
    l__ArmIK__1.Enabled = false;
end;
function u1.SetIKEnabled(p5, p6) --[[ Line: 39 ]]
    p5.ArmIK.Enabled = p6;
end;
function u1.SetIK(p7, p8, p9) --[[ Line: 43 ]]
    p7.ArmIK.Target = p8;
    p7.ArmIK.Weight = p9 or 1;
end;
function u1.SetCharacterPose(p10, p11) --[[ Line: 48 ]]
    if not p10.Animations[p11] then
        local v12 = Instance.new("Animation");
        v12.AnimationId = p11;
        p10.Animations[p11] = v12;
    end;
    if p10.EmoteAnimation then
        p10.EmoteAnimation:Stop();
    end;
end;
return u1;
