-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.position
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "position",
    Description = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
    Group = "DefaultDebug",
    Aliases = { "pos" },
    Args = {
        {
            Type = "player",
            Name = "Player",
            Description = "The player to report the position of. Omit for your own position.",
            Default = game:GetService("Players").LocalPlayer
        }
    },
    ClientRun = function(_, p1) --[[ Name: ClientRun, Line 17 ]]
        local l__Character__1 = p1.Character;
        return not (l__Character__1 and l__Character__1:FindFirstChild("HumanoidRootPart")) and "" or tostring(l__Character__1.HumanoidRootPart.Position):gsub("%s", "");
    end
};
