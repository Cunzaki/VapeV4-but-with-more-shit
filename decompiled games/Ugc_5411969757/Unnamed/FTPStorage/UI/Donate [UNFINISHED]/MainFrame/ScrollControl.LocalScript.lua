-- Decompiled from: .FTPStorage.UI.Donate [UNFINISHED].MainFrame.ScrollControl
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local _ = game.Players.LocalPlayer;
local l__ScrollFalso__1 = script.Parent:WaitForChild("ScrollFalso");
local l__ScrollingFrame__2 = script.Parent:WaitForChild("ScrollingFrame");
local l__UIListLayout__3 = l__ScrollFalso__1:WaitForChild("Frame"):WaitForChild("UIListLayout");
l__ScrollingFrame__2:GetPropertyChangedSignal("CanvasPosition"):connect(function() --[[ Line: 17 ]]
    -- upvalues: l__ScrollFalso__1 (copy), l__ScrollingFrame__2 (copy)
    l__ScrollFalso__1:WaitForChild("Frame").Position = UDim2.new(0.5, 0, 0.5, -l__ScrollingFrame__2.CanvasPosition.Y);
end);
l__UIListLayout__3:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() --[[ Line: 22 ]]
    -- upvalues: l__ScrollingFrame__2 (copy), l__UIListLayout__3 (copy)
    local _ = l__ScrollingFrame__2.CanvasPosition.Y / l__ScrollingFrame__2.AbsoluteWindowSize.Y;
    l__ScrollingFrame__2.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__3.AbsoluteContentSize.Y);
end);
local _ = l__ScrollingFrame__2.CanvasPosition.Y / l__ScrollingFrame__2.AbsoluteWindowSize.Y;
l__ScrollingFrame__2.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__3.AbsoluteContentSize.Y);
