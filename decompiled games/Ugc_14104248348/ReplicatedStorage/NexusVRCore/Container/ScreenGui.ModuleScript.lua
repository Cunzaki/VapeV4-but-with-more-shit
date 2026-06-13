-- Decompiled from: ReplicatedStorage.NexusVRCore.Container.ScreenGui
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
require(script.Parent:WaitForChild("BaseScreenGui"));
local l__ScreenGui3D__2 = require(script.Parent:WaitForChild("ScreenGui3D"));
local l__ScreenGui2D__3 = require(script.Parent:WaitForChild("ScreenGui2D"));
if l__UserInputService__1.VREnabled then
    return l__ScreenGui3D__2;
else
    return l__ScreenGui2D__3;
end;
