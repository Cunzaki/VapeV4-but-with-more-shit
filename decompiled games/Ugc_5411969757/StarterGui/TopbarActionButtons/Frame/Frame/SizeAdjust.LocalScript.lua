-- Decompiled from: StarterGui.TopbarActionButtons.Frame.Frame.SizeAdjust
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__UIListLayout__1 = script.Parent:WaitForChild("UIListLayout");
l__UIListLayout__1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Name: Update, Line 3 ]]
    -- upvalues: l__UIListLayout__1 (copy)
    script.Parent.Parent.Size = UDim2.fromOffset(220, l__UIListLayout__1.AbsoluteContentSize.Y);
end);
script.Parent.Parent.Size = UDim2.fromOffset(220, l__UIListLayout__1.AbsoluteContentSize.Y);
