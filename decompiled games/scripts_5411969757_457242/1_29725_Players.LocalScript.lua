-- Decompiled with Potassium's decompiler.

game:GetService("HttpService");
local l__Players__1 = game:GetService("Players");
game:GetService("Lighting");
game:GetService("ReplicatedStorage");
local _ = l__Players__1.LocalPlayer;
local _ = script.Parent;
script.Parent:GetPropertyChangedSignal("TextBounds"):connect(function() --[[ Line: 16 ]]
    local l__TextBounds__2 = script.Parent.TextBounds;
    script.Parent:WaitForChild("Fondo").Size = UDim2.new(0, l__TextBounds__2.X + 12, 0, l__TextBounds__2.Y + 6);
end);
l__Players__1.ChildRemoved:connect(function() --[[ Line: 21 ]]
    -- upvalues: l__Players__1 (copy)
    local v1 = l__Players__1:GetChildren();
    script.Parent.Text = "Players: " .. #v1 .. "/" .. l__Players__1.MaxPlayers;
end);
l__Players__1.ChildAdded:connect(function() --[[ Line: 25 ]]
    -- upvalues: l__Players__1 (copy)
    local v2 = l__Players__1:GetChildren();
    script.Parent.Text = "Players: " .. #v2 .. "/" .. l__Players__1.MaxPlayers;
end);
local v3 = l__Players__1:GetChildren();
script.Parent.Text = "Players: " .. #v3 .. "/" .. l__Players__1.MaxPlayers;