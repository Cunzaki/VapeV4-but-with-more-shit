-- Path: ReplicatedStorage.CharacterScripts.NametagController
-- Class: LocalScript
-- Source dump: place 16849012343 Fallen Survival Medium Server.rbxlx
-- SHA256: 7dbf96d0ce6ef5cc523fc6b7be6ae320f411eb5a67d4a848c60e1084a5af0790

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local Players_1 = game:GetService("Players");
local tbl_1 = {workspace:WaitForChild("Bases"), workspace:WaitForChild("Monuments")};
local v1 = os.clock();
local v2 = os.clock();
local v3 = {};
v1, v3, v2 = v1, v3, v2;
if (os.clock() - v1 >= 2) then
    v1 = os.clock();
    local v4 = nil;
    for key_1, value_1 in v3 do
        if (not (value_1) or not (value_1.Character) or not (value_1.Character:FindFirstChild("HumanoidRootPart"))) then
            v3[key_1] = nil;
            continue;
        end;
        v4 = RaycastParams.new();
        v4.FilterDescendantsInstances = tbl_1;
        v4.FilterType = Enum.RaycastFilterType.Include;
        v4.IgnoreWater = true;
        v4.RespectCanCollide = true;
        if (workspace:Raycast(value_1.Character.HumanoidRootPart.Position, Vector3.new(0, 3.0999999046325684, 0), v4) or not workspace:Raycast(value_1.Character.HumanoidRootPart.Position, Vector3.new(0, 3.0999999046325684, 0), v4)) then
            task.wait();
        end;
    end;
end;
if (os.clock() - v2 >= 8) then
    v2 = os.clock();
    local tbl_2 = {};
    for _, value_2 in Players_1:GetChildren() do
        table.insert(tbl_2, value_2);
        task.wait();
    end;
    v3 = tbl_2;
end;
task.wait(0.15);