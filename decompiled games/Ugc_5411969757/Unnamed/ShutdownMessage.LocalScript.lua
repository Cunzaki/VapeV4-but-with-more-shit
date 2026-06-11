-- Decompiled from: .ShutdownMessage
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__LogService__2 = game:GetService("LogService");
local l__TeleportService__3 = game:GetService("TeleportService");
local l__Custom__4 = script:WaitForChild("Custom");
l__LogService__2.MessageOut:connect(function(p1, p2) --[[ Line: 7 ]]
    -- upvalues: l__Custom__4 (copy), l__LocalPlayer__1 (copy), l__TeleportService__3 (copy)
    if p2 == Enum.MessageType.MessageError and p1:lower():sub(1, 21) == "server kick message: " then
        local v3 = p1:sub(22);
        l__Custom__4.Parent = l__LocalPlayer__1:WaitForChild("PlayerGui");
        l__Custom__4:WaitForChild("TEXTO").Text = tostring(v3);
        game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen();
        task.wait(5);
        l__TeleportService__3:Teleport(5169051062, l__LocalPlayer__1, {
            Reason = "Kicked",
            Message = v3
        });
    end;
end);
