-- Decompiled with Potassium's decompiler.

local l__ScrollingFrame__1 = script.Parent:WaitForChild("ScrollContainer"):WaitForChild("ScrollingFrame");
local l__UIListLayout__2 = l__ScrollingFrame__1:WaitForChild("UIListLayout");
l__UIListLayout__2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 38 ]]
    -- upvalues: l__ScrollingFrame__1 (copy), l__UIListLayout__2 (copy)
    l__ScrollingFrame__1.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__2.AbsoluteContentSize.Y);
    if l__ScrollingFrame__1.AbsoluteCanvasSize.Y - (l__ScrollingFrame__1.CanvasPosition.Y + l__ScrollingFrame__1.AbsoluteSize.Y) <= 20 then
        task.defer(function() --[[ Line: 22 ]]
            -- upvalues: l__ScrollingFrame__1 (ref)
            local v1 = math.max(0, l__ScrollingFrame__1.AbsoluteCanvasSize.Y - l__ScrollingFrame__1.AbsoluteSize.Y);
            l__ScrollingFrame__1.CanvasPosition = Vector2.new(0, v1);
        end);
    end;
end);
task.defer(function() --[[ Line: 22 ]]
    -- upvalues: l__ScrollingFrame__1 (copy)
    local v2 = math.max(0, l__ScrollingFrame__1.AbsoluteCanvasSize.Y - l__ScrollingFrame__1.AbsoluteSize.Y);
    l__ScrollingFrame__1.CanvasPosition = Vector2.new(0, v2);
end);