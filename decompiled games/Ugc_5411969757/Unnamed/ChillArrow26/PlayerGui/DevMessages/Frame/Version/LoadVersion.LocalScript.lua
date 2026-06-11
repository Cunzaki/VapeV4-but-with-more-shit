-- Decompiled from: .ChillArrow26.PlayerGui.DevMessages.Frame.Version.LoadVersion
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__GameVersion__1 = game:GetService("ReplicatedStorage"):WaitForChild("game"):WaitForChild("GameVersion");
if l__GameVersion__1.Value == "" then
    l__GameVersion__1.Changed:Wait();
end;
script.Parent.Text = l__GameVersion__1.Value;
