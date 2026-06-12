-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
for _, u2 in script.Parent:GetChildren() do
    if u2:IsA("TextLabel") then
        local u3 = l__TweenService__1:Create(u2, v1, {
            TextTransparency = 0.5
        });
        local u4 = l__TweenService__1:Create(u2, v1, {
            TextTransparency = 0
        });
        u2.MouseEnter:Connect(function() --[[ Line: 13 ]]
            -- upvalues: u4 (copy)
            u4:Play();
        end);
        u2.MouseLeave:Connect(function() --[[ Line: 14 ]]
            -- upvalues: u3 (copy)
            u3:Play();
        end);
        u2:GetPropertyChangedSignal("TextBounds"):Connect(function() --[[ Line: 15 ]]
            -- upvalues: u2 (copy)
            local v5 = u2;
            v5.Size = UDim2.fromOffset(v5.TextBounds.X, v5.Size.Y.Offset);
        end);
        u2.Size = UDim2.fromOffset(u2.TextBounds.X, u2.Size.Y.Offset);
    end;
end;