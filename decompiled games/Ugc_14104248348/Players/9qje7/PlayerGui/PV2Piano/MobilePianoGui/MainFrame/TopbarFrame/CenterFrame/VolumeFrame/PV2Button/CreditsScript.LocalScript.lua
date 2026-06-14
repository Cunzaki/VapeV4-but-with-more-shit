-- Decompiled from: Players.9qje7.PlayerGui.PV2Piano.MobilePianoGui.MainFrame.TopbarFrame.CenterFrame.VolumeFrame.PV2Button.CreditsScript
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
local l__ClipButton__3 = l__Parent__2:WaitForChild("ClipButton");
local u7 = false;
local function u11(p8) --[[ Line: 15 ]]
    -- upvalues: u7 (ref), l__Parent__2 (copy), l__ClipButton__3 (copy), u6 (copy)
    if p8 == nil then
        p8 = not u7;
    end;
    u7 = p8;
    local v9 = l__Parent__2;
    local v10;
    if u7 then
        v10 = Color3.fromRGB(61, 160, 255);
    else
        v10 = Color3.fromRGB(96, 96, 96);
    end;
    v9.TextColor3 = v10;
    PlayTween(l__ClipButton__3, u6, {
        Size = UDim2.fromOffset(200, u7 and 85 or 0)
    });
end;
l__Parent__2.Activated:Connect(function() --[[ Line: 20 ]]
    -- upvalues: u11 (copy)
    u11();
end);
l__ClipButton__3.Activated:Connect(function() --[[ Line: 23 ]]
    -- upvalues: u11 (copy)
    u11();
end);
u11(false);
