-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent;
local l__Parent__2 = script.Parent;
l__Parent__2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Name: Update, Line 4 ]]
    -- upvalues: l__Parent__2 (copy), l__Parent__1 (copy)
    l__Parent__1.Size = UDim2.new(1, 0, 0, l__Parent__2.AbsoluteContentSize.Y);
end);
l__Parent__1.Size = UDim2.new(1, 0, 0, l__Parent__2.AbsoluteContentSize.Y);