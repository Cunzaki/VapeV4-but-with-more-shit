-- Decompiled with Potassium's decompiler.

local l__Frame__1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 999):WaitForChild("Chat", 999):WaitForChild("Frame");
local l__ChatChannelParentFrame__2 = l__Frame__1:WaitForChild("ChatChannelParentFrame");
local l__BoxFrame__3 = l__Frame__1:WaitForChild("ChatBarParentFrame"):WaitForChild("Frame"):WaitForChild("BoxFrame");
local l__UICorner__4 = script:WaitForChild("UICorner");
if l__ChatChannelParentFrame__2 ~= nil then
    l__UICorner__4:clone().Parent = l__ChatChannelParentFrame__2;
end;
local l__Parent__5 = l__BoxFrame__3.Parent;
if l__Parent__5 ~= nil then
    l__UICorner__4:clone().Parent = l__Parent__5;
end;
if l__BoxFrame__3 == nil then
else
    l__UICorner__4:clone().Parent = l__BoxFrame__3;
end;