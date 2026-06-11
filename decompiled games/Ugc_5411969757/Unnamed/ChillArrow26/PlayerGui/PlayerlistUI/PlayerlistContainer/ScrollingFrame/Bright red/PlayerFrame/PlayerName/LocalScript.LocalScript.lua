-- Decompiled from: .ChillArrow26.PlayerGui.PlayerlistUI.PlayerlistContainer.ScrollingFrame.Bright red.PlayerFrame.PlayerName.LocalScript
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__FriendIcon__2 = script.Parent.Parent:WaitForChild("FriendIcon");
local u1 = {};
local function u3() --[[ Line: 7 ]]
    -- upvalues: u1 (ref)
    for _, v2 in pairs(u1) do
        v2:Disconnect();
    end;
    u1 = {};
end;
l__FriendIcon__2:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Name: UpdatePosition, Line 14 ]]
    -- upvalues: l__FriendIcon__2 (copy)
    local l__Visible__3 = l__FriendIcon__2.Visible;
    local l__Parent__4 = script.Parent;
    local v4;
    if l__Visible__3 == true then
        v4 = UDim2.new(0, 30, 0, 0);
    else
        v4 = UDim2.new(0, 5, 0, 0);
    end;
    l__Parent__4.Position = v4;
end);
script.Parent.Focused:Connect(function() --[[ Line: 20 ]]
    -- upvalues: u1 (ref), l__UserInputService__1 (copy)
    table.insert(u1, l__UserInputService__1.InputBegan:Connect(function(p5, _) --[[ Line: 22 ]]
        if p5.UserInputType == Enum.UserInputType.Keyboard and p5.KeyCode ~= Enum.KeyCode.LeftControl then
            script.Parent:ReleaseFocus();
        end;
    end));
end);
script.Parent.FocusLost:Connect(function() --[[ Line: 29 ]]
    -- upvalues: u3 (copy)
    u3();
end);
local l__Visible__5 = l__FriendIcon__2.Visible;
local l__Parent__6 = script.Parent;
local v6;
if l__Visible__5 == true then
    v6 = UDim2.new(0, 30, 0, 0);
else
    v6 = UDim2.new(0, 5, 0, 0);
end;
l__Parent__6.Position = v6;
