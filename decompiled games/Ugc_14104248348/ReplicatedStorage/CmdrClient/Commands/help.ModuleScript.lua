-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.help
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Group = "Help",
    Args = {
        {
            Type = "command",
            Name = "Command",
            Description = "The command to view information on",
            Optional = true
        }
    },
    ClientRun = function(p1, p2) --[[ Name: ClientRun, Line 14 ]]
        if p2 then
            local v3 = p1.Cmdr.Registry:GetCommand(p2);
            p1:Reply(("Command: %s"):format(v3.Name), Color3.fromRGB(230, 126, 34));
            if v3.Aliases and #v3.Aliases > 0 then
                p1:Reply(("Aliases: %s"):format(table.concat(v3.Aliases, ", ")), Color3.fromRGB(230, 230, 230));
            end;
            p1:Reply(v3.Description, Color3.fromRGB(230, 230, 230));
            for v4, v5 in ipairs(v3.Args) do
                p1:Reply(("#%d %s%s: %s - %s"):format(v4, v5.Name, v5.Optional == true and "?" or "", v5.Type, v5.Description));
            end;
        else
            local v6 = p1.Cmdr.Registry:GetCommands();
            for _, v7 in pairs(v6) do
                p1:Reply(("%s - %s"):format(v7.Name, v7.Description));
            end;
        end;
        return "";
    end
};
