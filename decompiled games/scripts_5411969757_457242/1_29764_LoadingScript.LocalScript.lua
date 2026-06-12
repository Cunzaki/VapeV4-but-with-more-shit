-- Decompiled with Potassium's decompiler.

local l__UIGradient__1 = script.Parent:WaitForChild("Loading"):WaitForChild("Frame"):WaitForChild("UIStroke"):WaitForChild("UIGradient");
local v1 = os.clock();
while true do
    local v2 = os.clock();
    l__UIGradient__1.Rotation = l__UIGradient__1.Rotation + (v2 - v1) * 100;
    task.wait();
    v1 = v2;
end;