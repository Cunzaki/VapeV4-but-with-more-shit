-- Decompiled from: ReplicatedStorage.Modules.RagdollModuleClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Ragdoll = function(p1, _) --[[ Name: Ragdoll, Line 2 ]]
        if p1:GetAttribute("Ragdolled") then
        else
            p1:SetAttribute("Ragdolled", true);
            for _, v2 in pairs(p1:GetDescendants()) do
                if v2:IsA("Motor6D") then
                    local v3 = Instance.new("Attachment");
                    v3.Name = "RagdollAttach";
                    local v4 = Instance.new("Attachment");
                    v4.Name = "RagdollAttach";
                    v3.CFrame = v2.C0;
                    v4.CFrame = v2.C1;
                    v3.Parent = v2.Part0;
                    v4.Parent = v2.Part1;
                    local v5 = Instance.new("BallSocketConstraint");
                    v5.Attachment0 = v3;
                    v5.Attachment1 = v4;
                    v5.LimitsEnabled = true;
                    v5.TwistLimitsEnabled = true;
                    v5.MaxFrictionTorque = 30;
                    v5.Restitution = 0.5;
                    v5.Radius = 0.25;
                    if v2.Name ~= "Right Shoulder" then
                        local _ = v2.Name == "Left Shoulder";
                    end;
                    v5.Parent = v2.Parent;
                    v2.Enabled = false;
                end;
            end;
            local v6 = p1:FindFirstChild("Humanoid");
            if v6 then
                v6:UnequipTools();
                v6:SetAttribute("DefHipHeight", v6.HipHeight);
                v6.HipHeight = 0.1;
                v6:ChangeState(Enum.HumanoidStateType.Ragdoll);
                v6:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
            end;
        end;
    end,
    UnRagdoll = function(p7) --[[ Name: UnRagdoll, Line 47 ]]
        if p7:GetAttribute("Ragdolled") then
            p7:SetAttribute("Ragdolled", nil);
            for _, v8 in pairs(p7:GetDescendants()) do
                if v8.Name == "RagdollAttach" or v8:IsA("BallSocketConstraint") then
                    v8:Destroy();
                elseif v8:IsA("Motor6D") then
                    v8.Enabled = true;
                end;
            end;
            local v9 = p7:FindFirstChild("Humanoid");
            if v9 then
                v9.HipHeight = v9:GetAttribute("DefHipHeight");
                v9:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
            end;
        end;
    end
};
