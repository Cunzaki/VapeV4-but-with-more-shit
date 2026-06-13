-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
return function() --[[ Line: 12 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    if l__ReplicatedStorage__1:FindFirstChild("NexusVRBackpack") then
    else
        script:WaitForChild("NexusVRBackpack").Parent = l__ReplicatedStorage__1;
    end;
end;
