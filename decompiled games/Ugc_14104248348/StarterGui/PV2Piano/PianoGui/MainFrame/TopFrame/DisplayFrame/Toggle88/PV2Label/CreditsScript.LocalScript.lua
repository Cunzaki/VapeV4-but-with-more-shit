-- Decompiled from: StarterGui.PV2Piano.PianoGui.MainFrame.TopFrame.DisplayFrame.Toggle88.PV2Label.CreditsScript
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
function PlayTween(p1, p2, p3, p4)
    -- upvalues: l__TweenService__1 (copy)
    local v5 = l__TweenService__1:Create(p1, p2, p3);
    v5:Play();
    if p4 then
        v5.Completed:Wait();
    end;
end;
local u6 = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local l__Parent__2 = script.Parent;
local l__ClipFrame__3 = l__Parent__2:WaitForChild("ClipFrame");
l__Parent__2.MouseEnter:Connect(function() --[[ Line: 14 ]]
    -- upvalues: l__Parent__2 (copy), l__ClipFrame__3 (copy), u6 (copy)
    l__Parent__2.TextColor3 = Color3.fromRGB(61, 160, 255);
    PlayTween(l__ClipFrame__3, u6, {
        Size = UDim2.fromOffset(200, 60)
    });
end);
l__Parent__2.MouseLeave:Connect(function() --[[ Line: 18 ]]
    -- upvalues: l__Parent__2 (copy), l__ClipFrame__3 (copy), u6 (copy)
    l__Parent__2.TextColor3 = Color3.fromRGB(96, 96, 96);
    PlayTween(l__ClipFrame__3, u6, {
        Size = UDim2.fromOffset(200, 0)
    });
end);
l__ClipFrame__3.Size = UDim2.fromOffset(200, 0);
