-- Decompiled from: StarterPlayer.StarterPlayerScripts.ClientActor.ClientAnticheat
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LogService__2 = game:GetService("LogService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__3:WaitUntilSetup("Server");
local v1 = l__Mince__3:GetEvent("ClientAntiCheatReporting");
local v2 = nil;
while task.wait(2) do
    if v2 then
        if v2 < #l__LogService__2:GetLogHistory() then
            local v3 = l__LogService__2:GetLogHistory()[v2 + 1];
            if v3.messageType == Enum.MessageType.MessageInfo then
                v1:Fire(v3);
            end;
            v2 = v2 + 1;
        end;
    else
        v2 = #l__LogService__2:GetLogHistory();
    end;
end;
