-- Decompiled with Potassium's decompiler.

local l__PlayerScripts__1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts", 300);
local u1 = require(l__PlayerScripts__1:WaitForChild("PlayerModule")):GetCameras();
local l__MouseLock__2 = script.Parent:WaitForChild("MouseLock");
script.Parent:WaitForChild("ToggleLockMouse").MouseButton1Click:connect(function() --[[ Line: 9 ]]
    -- upvalues: u1 (copy), l__MouseLock__2 (copy)
    u1.activeMouseLockController:OnMouseLockToggled();
    l__MouseLock__2.Visible = u1.activeMouseLockController:GetIsMouseLocked();
end);