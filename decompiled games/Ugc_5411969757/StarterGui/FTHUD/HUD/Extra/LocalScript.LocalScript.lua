-- Decompiled from: StarterGui.FTHUD.HUD.Extra.LocalScript
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local _ = v2.Players.LocalPlayer;
local l__CurrentDate__1 = v2.ReplicatedStorage:WaitForChild("FTPStorage"):WaitForChild("CurrentDate");
v2.ContextActionService.LocalToolEquipped:connect(function(p3) --[[ Line: 9 ]]
    if p3.Name == "Building Tools" then
        script.Parent.Visible = false;
    else
        script.Parent.Visible = true;
    end;
end);
v2.ContextActionService.LocalToolUnequipped:connect(function(_) --[[ Line: 17 ]]
    script.Parent.Visible = true;
end);
repeat
    wait(0.25);
until l__CurrentDate__1.Value ~= "[LOADING SERVER REGION]";
script.Parent.Text = l__CurrentDate__1.Value;
