-- Decompiled from: ReplicatedStorage.CmdrClient.Commands.createEvent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Name = "createEvent",
    Description = "Creates an event server! This is global and should not be abused.",
    Group = "CreateEventServer",
    Args = {
        {
            Type = "string",
            Name = "Server Name",
            Description = "Name of the server, for now this cannot be changed after creation;"
        }
    }
};
