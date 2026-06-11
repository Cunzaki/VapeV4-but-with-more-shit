-- Decompiled from: StarterGui.TopbarActionButtons.VisibilityControl
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Toggle__1 = script.Parent:WaitForChild("Toggle");
local v1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
local u2 = game:GetService("TweenService"):Create(script.Parent.Frame.Frame, v1, {
    Transparency = 0.08,
    Size = UDim2.fromScale(1, 1)
});
local u3 = game:GetService("TweenService"):Create(script.Parent.Frame.Frame, v1, {
    Transparency = 1,
    Size = UDim2.fromScale(1, 0)
});
l__Toggle__1.Event:Connect(function(p4) --[[ Line: 15 ]]
    -- upvalues: u2 (copy), u3 (copy)
    if p4 == true or p4 == false then
        script.Parent.Frame.Visible = p4;
    else
        script.Parent.Frame.Visible = not script.Parent.Frame.Visible;
    end;
    if script.Parent.Frame.Visible == true then
        u2:Play();
    else
        u3:Play();
    end;
end);
