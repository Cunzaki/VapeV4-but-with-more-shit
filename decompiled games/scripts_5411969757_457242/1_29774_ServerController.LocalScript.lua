-- Decompiled with Potassium's decompiler.

local _ = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
}).Players.LocalPlayer;
script.Parent:WaitForChild("ScrollingFrame");
local _ = math.floor;