-- Decompiled with Potassium's decompiler.

script.Parent:GetPropertyChangedSignal("TextBounds"):connect(function() --[[ Line: 6 ]]
    script.Parent.Size = UDim2.new(0, script.Parent.TextBounds.X, 1, 0);
end);
script.Parent.Size = UDim2.new(0, script.Parent.TextBounds.X, 1, 0);