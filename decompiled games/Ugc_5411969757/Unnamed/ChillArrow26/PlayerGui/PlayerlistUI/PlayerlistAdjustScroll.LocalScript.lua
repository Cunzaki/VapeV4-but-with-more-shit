-- Decompiled from: .ChillArrow26.PlayerGui.PlayerlistUI.PlayerlistAdjustScroll
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__ScrollingFrame__1 = script.Parent:WaitForChild("PlayerlistContainer"):WaitForChild("ScrollingFrame");
local l__UIListLayout__2 = l__ScrollingFrame__1:WaitForChild("UIListLayout");
local function v2() --[[ Line: 4 ]]
    -- upvalues: l__UIListLayout__2 (copy), l__ScrollingFrame__1 (copy)
    local l__AbsoluteContentSize__3 = l__UIListLayout__2.AbsoluteContentSize;
    local v1 = l__AbsoluteContentSize__3.Y >= l__ScrollingFrame__1.AbsoluteSize.Y;
    l__ScrollingFrame__1.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__3.Y);
    l__ScrollingFrame__1.ScrollingEnabled = v1;
end;
l__UIListLayout__2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v2);
script.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(v2);
local l__AbsoluteContentSize__4 = l__UIListLayout__2.AbsoluteContentSize;
local v3 = l__AbsoluteContentSize__4.Y >= l__ScrollingFrame__1.AbsoluteSize.Y;
l__ScrollingFrame__1.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__4.Y);
l__ScrollingFrame__1.ScrollingEnabled = v3;
task.wait();
local l__AbsoluteContentSize__5 = l__UIListLayout__2.AbsoluteContentSize;
local v4 = l__AbsoluteContentSize__5.Y >= l__ScrollingFrame__1.AbsoluteSize.Y;
l__ScrollingFrame__1.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__5.Y);
l__ScrollingFrame__1.ScrollingEnabled = v4;
