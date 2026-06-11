-- Decompiled from: .ChillArrow26.PlayerGui.FTHUD.Topbar.Frame.TopbarMessages.Topbar.Topbar
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

game:GetService("HttpService");
local l__Players__1 = game:GetService("Players");
game:GetService("Lighting");
local l__ServernameValue__2 = game:GetService("ReplicatedStorage"):WaitForChild("ServernameValue", 300);
local _ = l__Players__1.LocalPlayer;
local l__Parent__3 = script.Parent;
repeat
    wait();
until l__Parent__3 ~= nil;
l__Parent__3:GetPropertyChangedSignal("TextBounds"):connect(function() --[[ Line: 17 ]]
    -- upvalues: l__Parent__3 (copy)
    local l__TextBounds__4 = l__Parent__3.TextBounds;
    l__Parent__3:WaitForChild("Fondo").Size = UDim2.new(0, l__TextBounds__4.X + 14, 0, l__TextBounds__4.Y + 8);
end);
l__ServernameValue__2:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 22 ]]
    -- upvalues: l__Parent__3 (copy), l__ServernameValue__2 (copy)
    l__Parent__3.Text = l__ServernameValue__2.Value;
end);
l__Parent__3.Text = l__ServernameValue__2.Value;
