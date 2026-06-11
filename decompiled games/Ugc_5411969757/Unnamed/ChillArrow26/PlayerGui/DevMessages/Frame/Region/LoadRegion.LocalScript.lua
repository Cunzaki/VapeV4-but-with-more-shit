-- Decompiled from: .ChillArrow26.PlayerGui.DevMessages.Frame.Region.LoadRegion
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__GameRegion__1 = game:GetService("ReplicatedStorage"):WaitForChild("game"):WaitForChild("GameRegion");
if l__GameRegion__1.Value == "" then
    l__GameRegion__1.Changed:Wait();
end;
script.Parent.Text = l__GameRegion__1.Value;
