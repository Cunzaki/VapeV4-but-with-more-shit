-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
v2.Players.LocalPlayer:GetMouse();
local l__CurrentGamemode__1 = v2.Lighting:WaitForChild("CurrentGamemode");
local l__GamemodesContainer__2 = script.Parent:WaitForChild("GamemodesContainer");
local function u7(p3) --[[ Line: 10 ]]
    -- upvalues: l__GamemodesContainer__2 (copy)
    for _, v4 in pairs(l__GamemodesContainer__2:GetChildren()) do
        if v4 == p3 then
            v4.Visible = true;
            local v5 = v4:FindFirstChildOfClass("LocalScript");
            if v5 ~= nil then
                v5.Disabled = false;
            end;
        else
            v4.Visible = false;
            local v6 = v4:FindFirstChildOfClass("LocalScript");
            if v6 ~= nil then
                v6.Disabled = true;
            end;
        end;
    end;
end;
l__CurrentGamemode__1.Changed:connect(function() --[[ Line: 33 ]]
    -- upvalues: l__CurrentGamemode__1 (copy), l__GamemodesContainer__2 (copy), u7 (copy)
    u7((l__GamemodesContainer__2:FindFirstChild((l__CurrentGamemode__1.Value:upper()))));
end);
u7((l__GamemodesContainer__2:FindFirstChild((l__CurrentGamemode__1.Value:upper()))));