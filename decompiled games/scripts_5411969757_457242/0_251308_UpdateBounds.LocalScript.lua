-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Parent__2 = script.Parent.Parent.Parent.Parent;
local function v1() --[[ Line: 4 ]]
    -- upvalues: l__Parent__1 (copy), l__Parent__2 (copy)
    if l__Parent__1.TextBounds.X >= l__Parent__2.AbsoluteSize.X then
        l__Parent__1.TextXAlignment = Enum.TextXAlignment.Right;
    else
        l__Parent__1.TextXAlignment = Enum.TextXAlignment.Left;
    end;
end;
l__Parent__1.Focused:Connect(function() --[[ Line: 22 ]]
    script.Parent.Parent.Parent.Shadow.ImageColor3 = Color3.fromRGB(255, 255, 255);
end);
l__Parent__1.FocusLost:Connect(function() --[[ Line: 26 ]]
    script.Parent.Parent.Parent.Shadow.ImageColor3 = Color3.new(0, 0, 0);
end);
l__Parent__1:GetPropertyChangedSignal("TextBounds"):Connect(v1);
l__Parent__1:GetPropertyChangedSignal("AbsoluteSize"):Connect(v1);
if l__Parent__1.TextBounds.X >= l__Parent__2.AbsoluteSize.X then
    l__Parent__1.TextXAlignment = Enum.TextXAlignment.Right;
else
    l__Parent__1.TextXAlignment = Enum.TextXAlignment.Left;
end;