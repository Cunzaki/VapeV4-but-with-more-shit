-- Decompiled with Potassium's decompiler.

local l__ScrollingFrame__1 = script.Parent:WaitForChild("ScrollContainer"):WaitForChild("ScrollingFrame");
local l__UIListLayout__2 = l__ScrollingFrame__1:WaitForChild("UIListLayout");
local l__Parent__3 = script.Parent;
local function v2() --[[ Line: 6 ]]
    -- upvalues: l__UIListLayout__2 (copy), l__Parent__3 (copy), l__ScrollingFrame__1 (copy)
    local l__Y__4 = l__UIListLayout__2.AbsoluteContentSize.Y;
    math.min(l__Parent__3.AbsoluteSize.Y, l__Y__4);
    l__ScrollingFrame__1.CanvasSize = UDim2.fromOffset(0, l__Y__4);
    local v1 = l__Parent__3.AbsoluteSize.Y <= l__UIListLayout__2.AbsoluteContentSize.Y;
    l__ScrollingFrame__1.Active = false;
    l__ScrollingFrame__1.ScrollingEnabled = v1;
end;
l__Parent__3:GetPropertyChangedSignal("AbsoluteSize"):Connect(v2);
l__ScrollingFrame__1:GetPropertyChangedSignal("AbsoluteSize"):Connect(v2);
l__UIListLayout__2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v2);
local l__Y__5 = l__UIListLayout__2.AbsoluteContentSize.Y;
math.min(l__Parent__3.AbsoluteSize.Y, l__Y__5);
l__ScrollingFrame__1.CanvasSize = UDim2.fromOffset(0, l__Y__5);
local v3 = l__Parent__3.AbsoluteSize.Y <= l__UIListLayout__2.AbsoluteContentSize.Y;
l__ScrollingFrame__1.Active = false;
l__ScrollingFrame__1.ScrollingEnabled = v3;