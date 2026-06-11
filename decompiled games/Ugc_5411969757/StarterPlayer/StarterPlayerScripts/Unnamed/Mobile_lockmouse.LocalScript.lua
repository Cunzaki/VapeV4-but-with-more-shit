-- Decompiled from: StarterPlayer.StarterPlayerScripts..Mobile_lockmouse
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
repeat
    wait();
until l__LocalPlayer__1 ~= nil and l__LocalPlayer__1:FindFirstChild("PlayerGui");
local v1 = l__LocalPlayer__1:FindFirstChild("PlayerGui");
tick();
if game:GetService("UserInputService").TouchEnabled == true then
    for _, v2 in pairs(script:GetChildren()) do
        v2.Parent = v1;
        local v3 = v2:FindFirstChildOfClass("LocalScript");
        if v3 ~= nil then
            v3.Disabled = false;
        end;
    end;
end;
