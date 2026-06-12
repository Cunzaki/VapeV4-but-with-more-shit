-- Decompiled with Potassium's decompiler.

local l__Frame__1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Chat"):WaitForChild("Frame");
local l__Parent__2 = script.Parent;
l__Parent__2.Text = "Press [Z] to Toggle Chat";
l__Frame__1:GetPropertyChangedSignal("Visible"):connect(function() --[[ Line: 14 ]]
    -- upvalues: l__Parent__2 (copy), l__Frame__1 (copy)
    l__Parent__2.Visible = not l__Frame__1.Visible;
end);
l__Parent__2.Visible = not l__Frame__1.Visible;
l__Frame__1.Position = UDim2.new(0, 5, 0, 2);