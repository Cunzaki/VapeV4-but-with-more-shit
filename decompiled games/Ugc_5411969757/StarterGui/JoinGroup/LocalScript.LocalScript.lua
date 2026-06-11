-- Decompiled from: StarterGui.JoinGroup.LocalScript
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Debris__2 = game:GetService("Debris");
local l__Parent__3 = script.Parent;
local l__Frame__4 = l__Parent__3:WaitForChild("Frame"):WaitForChild("Frame");
local l__Join__5 = l__Frame__4:WaitForChild("Join");
local l__Dismiss__6 = l__Frame__4:WaitForChild("Dismiss");
if l__LocalPlayer__1:IsInGroupAsync(5295712) == false then
    l__Parent__3.Enabled = true;
    l__Dismiss__6.MouseButton1Click:Connect(function() --[[ Line: 15 ]]
        script.Parent:Destroy();
    end);
    l__Join__5.MouseButton1Click:Connect(function() --[[ Line: 18 ]]
        pcall(function() --[[ Line: 19 ]]
            game:GetService("GroupService"):PromptJoinAsync(5295712);
        end);
    end);
    l__Debris__2:AddItem(l__Parent__3, 30);
else
    l__Parent__3:Destroy();
end;
