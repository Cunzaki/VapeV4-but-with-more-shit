-- Decompiled from: .FTPStorage.UI.Skys.ScrollObjects
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__ScrollingFrame__1 = script.Parent:WaitForChild("ScrollingFrame");
local _ = table.insert;
local _ = math.ceil;
local l__new__2 = UDim2.new;
local l__UIGridLayout__3 = l__ScrollingFrame__1:WaitForChild("UIGridLayout");
local function u2() --[[ Line: 11 ]]
    -- upvalues: l__ScrollingFrame__1 (copy), l__UIGridLayout__3 (copy), l__new__2 (copy)
    local v1 = (l__ScrollingFrame__1.AbsoluteSize.X - 10) * 0.85 / l__UIGridLayout__3.FillDirectionMaxCells;
    l__UIGridLayout__3.CellSize = l__new__2(0, v1, 0, v1);
    l__UIGridLayout__3:ApplyLayout();
    l__ScrollingFrame__1.CanvasSize = l__new__2(0, 0, 0, l__UIGridLayout__3.AbsoluteContentSize.Y + 5);
end;
l__ScrollingFrame__1:GetPropertyChangedSignal("AbsoluteSize"):connect(function() --[[ Line: 24 ]]
    -- upvalues: u2 (copy)
    u2();
end);
u2();
