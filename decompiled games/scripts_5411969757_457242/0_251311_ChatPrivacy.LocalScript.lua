-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Parent__2 = script.Parent;
local l__Parent__3 = l__Parent__2.Parent;
local l__TextBox__4 = l__Parent__2:WaitForChild("TextBox");
l__LocalPlayer__1.ChildAdded:Connect(function() --[[ Line: 16 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Parent__3 (copy), l__TextBox__4 (copy)
    local v1 = l__LocalPlayer__1:FindFirstChild("CanUseChat") ~= nil;
    l__Parent__3.Visible = v1;
    l__TextBox__4.Visible = v1;
    if v1 == false then
        l__TextBox__4:ReleaseFocus(false);
    end;
end);
l__LocalPlayer__1.ChildRemoved:Connect(function() --[[ Line: 17 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Parent__3 (copy), l__TextBox__4 (copy)
    local v2 = l__LocalPlayer__1:FindFirstChild("CanUseChat") ~= nil;
    l__Parent__3.Visible = v2;
    l__TextBox__4.Visible = v2;
    if v2 == false then
        l__TextBox__4:ReleaseFocus(false);
    end;
end);
local v3 = l__LocalPlayer__1:FindFirstChild("CanUseChat") ~= nil;
l__Parent__3.Visible = v3;
l__TextBox__4.Visible = v3;
if v3 == false then
    l__TextBox__4:ReleaseFocus(false);
end;