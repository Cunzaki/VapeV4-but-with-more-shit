-- Decompiled from: ReplicatedStorage.Modules.RagdollModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Ragdoll = function(u1, _, p2) --[[ Name: Ragdoll, Line 2 ]]
        if u1:GetAttribute("Ragdolled") then
        else
            u1:SetAttribute("Ragdolled", true);
            for _, v3 in pairs(u1:GetDescendants()) do
                if v3:IsA("Motor6D") then
                    local v4 = Instance.new("Attachment");
                    v4.Name = "RagdollAttach";
                    local v5 = Instance.new("Attachment");
                    v5.Name = "RagdollAttach";
                    v4.CFrame = v3.C0;
                    v5.CFrame = v3.C1;
                    v4.Parent = v3.Part0;
                    v5.Parent = v3.Part1;
                    local v6 = Instance.new("BallSocketConstraint");
                    v6.Attachment0 = v4;
                    v6.Attachment1 = v5;
                    v6.LimitsEnabled = true;
                    v6.TwistLimitsEnabled = true;
                    v6.MaxFrictionTorque = 30;
                    v6.Restitution = 0.5;
                    v6.Radius = 0.25;
                    if v3.Name ~= "Right Shoulder" then
                        local _ = v3.Name == "Left Shoulder";
                    end;
                    v6.Parent = v3.Parent;
                    v3.Enabled = false;
                end;
            end;
            local v7 = u1:FindFirstChild("Humanoid");
            if v7 and not p2 then
                v7:UnequipTools();
                v7:SetAttribute("DefHipHeight", v7.HipHeight);
                v7.HipHeight = 0.1;
                v7:ChangeState(Enum.HumanoidStateType.Ragdoll);
                v7:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
            end;
            if p2 then
                u1:SetAttribute("ForceRespawning", true);
            end;
            pcall(function() --[[ Line: 50 ]]
                -- upvalues: u1 (copy)
                u1.HumanoidRootPart:SetNetworkOwner(nil);
            end);
        end;
    end,
    UnRagdoll = function(u8) --[[ Name: UnRagdoll, Line 57 ]]
        if u8:GetAttribute("Ragdolled") then
            u8:SetAttribute("Ragdolled", nil);
            for _, v9 in pairs(u8:GetDescendants()) do
                if v9.Name == "RagdollAttach" or v9:IsA("BallSocketConstraint") then
                    v9:Destroy();
                elseif v9:IsA("Motor6D") then
                    v9.Enabled = true;
                end;
            end;
            local v10 = u8:FindFirstChild("Humanoid");
            if v10 then
                v10.HipHeight = v10:GetAttribute("DefHipHeight");
                v10:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
            end;
            pcall(function() --[[ Line: 75 ]]
                -- upvalues: u8 (copy)
                u8.HumanoidRootPart:SetNetworkOwner(game.Players:GetPlayerFromCharacter(u8));
            end);
        end;
    end
};
