-- Decompiled from: Players.9qje7.PlayerGui.PV2Piano.MobilePianoGui.MainFrame.TopbarFrame.CenterFrame.LCDFrame.ContextButton.LocalScript
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Arrow__2 = l__Parent__1:WaitForChild("Arrow");
local v1 = script:FindFirstAncestor("MobilePianoGui");
local u2 = false;
local l__TweenService__3 = game:GetService("TweenService");
local u3 = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
v1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 9 ]]
    -- upvalues: l__Parent__1 (copy), l__TweenService__3 (copy), u3 (copy), l__Arrow__2 (copy), u2 (ref)
    l__Parent__1.Visible = true;
    task.wait(5);
    l__TweenService__3:Create(l__Parent__1, u3, {
        BackgroundTransparency = 1,
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    l__TweenService__3:Create(l__Arrow__2, u3, {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    task.wait(2.5);
    if u2 then
    else
        u2 = true;
        l__Parent__1:Destroy();
    end;
end);
l__Parent__1.Activated:Connect(function() --[[ Line: 19 ]]
    -- upvalues: u2 (ref), l__Parent__1 (copy)
    u2 = true;
    l__Parent__1:Destroy();
end);
