-- Decompiled with Potassium's decompiler.

local l__ScrollingFrame__1 = script.Parent:WaitForChild("ScrollContainer"):WaitForChild("ScrollingFrame");
local function v4() --[[ Line: 2 ]]
    -- upvalues: l__ScrollingFrame__1 (copy)
    local v1 = l__ScrollingFrame__1.AbsoluteCanvasSize.Y - l__ScrollingFrame__1.CanvasPosition.Y;
    local v2 = l__ScrollingFrame__1:GetChildren();
    local v3 = v2[#v2];
    if v3 ~= nil and v3:IsA("Frame") and v1 - v3.AbsoluteSize.Y - 2 == l__ScrollingFrame__1.AbsoluteWindowSize.Y == true then
        l__ScrollingFrame__1.CanvasPosition = Vector2.new(0, l__ScrollingFrame__1.AbsoluteCanvasSize.Y);
    end;
end;
l__ScrollingFrame__1:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v4);
v4();