-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.clear
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
return {
    Name = "clear",
    Description = "Clear all lines above the entry line of the Cmdr window.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {},
    ClientRun = function() --[[ Name: ClientRun, Line 9 ]]
        -- upvalues: l__Players__1 (copy)
        local l__Cmdr__2 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr");
        local l__Frame__3 = l__Cmdr__2:WaitForChild("Frame");
        if l__Cmdr__2 and l__Frame__3 then
            for _, v1 in pairs(l__Frame__3:GetChildren()) do
                if v1.Name == "Line" and v1:IsA("TextLabel") then
                    v1:Destroy();
                end;
            end;
        end;
        return "";
    end
};
