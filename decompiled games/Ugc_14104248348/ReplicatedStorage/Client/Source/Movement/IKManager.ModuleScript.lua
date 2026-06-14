-- Decompiled from: ReplicatedStorage.Client.Source.Movement.IKManager
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("CollectionService");
game:GetService("UserInputService");
local u1 = require(l__ReplicatedStorage__1.Modules.Mince):Get("Locomotion");
local u2 = {
    IKConstraints = {
        RightArm = Instance.new("IKControl")
    }
};
function u2.Setup() --[[ Line: 17 ]]
    -- upvalues: u2 (copy)
    u2.SetupIK(game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait());
    game.Players.LocalPlayer.CharacterAdded:Connect(u2.SetupIK);
end;
function u2.LockPlayer() --[[ Line: 22 ]]
    -- upvalues: u1 (copy)
    u1.SetEnabled(false);
end;
function u2.UnlockPlayer() --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    u1.SetEnabled(true);
end;
function u2.SetupIK(p3) --[[ Line: 30 ]]
    -- upvalues: u2 (copy)
    local l__RightArm__2 = u2.IKConstraints.RightArm;
    p3:WaitForChild("Humanoid");
    l__RightArm__2.Parent = p3.Humanoid;
    l__RightArm__2.Type = Enum.IKControlType.Position;
    local v4 = Instance.new("Attachment", p3.HumanoidRootPart);
    v4.WorldCFrame = CFrame.new(Vector3.new(3, 0.8, 0)):ToWorldSpace(p3.HumanoidRootPart.CFrame);
    l__RightArm__2.Pole = v4;
    l__RightArm__2.ChainRoot = p3:WaitForChild("RightUpperArm");
    l__RightArm__2.EndEffector = p3:WaitForChild("RightHand");
    l__RightArm__2.Weight = 0;
    l__RightArm__2.Enabled = false;
end;
function u2.DisableIK() --[[ Line: 47 ]]
    -- upvalues: u2 (copy)
    u2.IKConstraints.RightArm.Enabled = false;
end;
function u2.SetIKTween(p5, p6) --[[ Line: 51 ]]
    -- upvalues: u2 (copy)
    u2.IKConstraints.RightArm.Enabled = true;
    u2.IKConstraints.RightArm.Target = p5;
    game:GetService("TweenService"):Create(u2.IKConstraints.RightArm, TweenInfo.new(0.2), {
        Weight = p6
    }):Play();
    task.wait(0.2);
    if p6 == 0 then
        u2.IKConstraints.RightArm.Enabled = false;
    end;
end;
return u2;
