-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Frame__2 = script.Parent:WaitForChild("ScrollFalso"):WaitForChild("Frame");
local l__ScrollingFrame__3 = script.Parent:WaitForChild("ScrollingFrame");
local l__UIListLayout__4 = l__Frame__2:WaitForChild("UIListLayout");
local l__RunService__5 = game:GetService("RunService");
local l__min__6 = math.min;
local l__abs__7 = math.abs;
local l__new__8 = UDim2.new;
local v1 = tick();
l__UIListLayout__4:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() --[[ Line: 16 ]]
    -- upvalues: l__UIListLayout__4 (copy), l__ScrollingFrame__3 (copy), l__new__8 (copy)
    l__ScrollingFrame__3.CanvasSize = l__new__8(0, 0, 0, l__UIListLayout__4.AbsoluteContentSize.Y + 10);
end);
l__ScrollingFrame__3.CanvasSize = l__new__8(0, 0, 0, l__UIListLayout__4.AbsoluteContentSize.Y + 10);
if l__LocalPlayer__1:FindFirstChild("NoSmoothScrolling") == nil then
    while l__RunService__5.RenderStepped:wait() do
        local v2 = tick() - v1;
        v1 = tick();
        local v3 = l__min__6(v2 * 10, 1);
        local _ = l__ScrollingFrame__3.CanvasPosition.Y;
        local v4 = l__abs__7(l__Frame__2.Position.Y.Offset);
        local v5 = l__abs__7(l__ScrollingFrame__3.CanvasPosition.Y);
        local v6 = l__min__6(v3, 1);
        l__Frame__2.Position = l__new__8(0.5, 0, 0.5, -(v4 + (v5 - v4) * v6));
    end;
else
    l__ScrollingFrame__3:GetPropertyChangedSignal("CanvasPosition"):connect(function() --[[ Line: 36 ]]
        -- upvalues: l__ScrollingFrame__3 (copy), l__Frame__2 (copy), l__new__8 (copy)
        l__Frame__2.Position = l__new__8(0.5, 0, 0.5, -l__ScrollingFrame__3.CanvasPosition.Y);
    end);
end;