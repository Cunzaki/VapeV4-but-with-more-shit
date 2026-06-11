-- Decompiled from: .ChillArrow26.PlayerScripts..Burbujas
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local v1;
repeat
    wait();
    v1 = l__Parent__1:FindFirstChild("BubbleChat");
until v1 ~= nil;
warn("Default Roblox bubble chat has been removed");
v1:Destroy();
local l__BubbleChat__2 = script:WaitForChild("BubbleChat");
l__BubbleChat__2.Parent = l__Parent__1;
l__BubbleChat__2.Disabled = false;
