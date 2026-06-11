-- Decompiled from: StarterPlayer.StarterPlayerScripts..HideChat
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local l__UserInputService__1 = v2.UserInputService;
local l__StarterGui__2 = v2.StarterGui;
local l__LocalPlayer__3 = v2.Players.LocalPlayer;
l__LocalPlayer__3:GetMouse();
local l__ChatToggleKey__4 = l__LocalPlayer__3:WaitForChild("ChatToggleKey");
l__UserInputService__1.InputBegan:connect(function(p3, p4) --[[ Line: 10 ]]
    -- upvalues: l__ChatToggleKey__4 (copy), l__UserInputService__1 (copy), l__StarterGui__2 (copy)
    if p3.UserInputType == Enum.UserInputType.Keyboard and p4 == false then
        local l__KeyCode__5 = p3.KeyCode;
        if l__KeyCode__5 ~= nil and (l__KeyCode__5.Name ~= nil and (l__KeyCode__5.Name == l__ChatToggleKey__4.Value and l__UserInputService__1:GetFocusedTextBox() == nil)) then
            l__StarterGui__2:SetCore("ChatActive", not l__StarterGui__2:GetCore("ChatActive"));
        end;
    end;
end);
