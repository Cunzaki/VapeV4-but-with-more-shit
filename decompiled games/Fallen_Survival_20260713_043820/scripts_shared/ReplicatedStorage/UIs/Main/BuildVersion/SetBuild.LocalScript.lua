-- Path: ReplicatedStorage.UIs.Main.BuildVersion.SetBuild
-- Class: LocalScript
-- Source dump: place 16849012343 Fallen Survival Medium Server.rbxlx
-- SHA256: 4328611f88db167a8bcbb0323128f55818e5c912d1e1eb32fea88cce940b826b

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local ServerBuild_upv_1 = game:GetService("ReplicatedStorage"):WaitForChild("Values"):WaitForChild("ServerBuild");
local Parent_upv_1 = script.Parent;
Parent_upv_1.Text = ("Fallen Build %*"):format(ServerBuild_upv_1.Value);
ServerBuild_upv_1:GetPropertyChangedSignal("Value"):Connect(
    function()
        --[[
          line: 19
          upvalues:
            Parent_upv_1 (copy, index: 1)
            ServerBuild_upv_1 (copy, index: 2)
        ]]
        Parent_upv_1.Text = ("Fallen Build %*"):format(ServerBuild_upv_1.Value);
    end
);