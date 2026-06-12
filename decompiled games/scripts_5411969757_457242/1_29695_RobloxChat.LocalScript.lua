-- Decompiled with Potassium's decompiler.

local l__Remotes__1 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes");
game:GetService("Chat");
local l__RobloxChat__2 = l__Remotes__1:WaitForChild("RobloxChat");
local u1 = {
    ["0"] = function() --[[ Line: 9 ]]
        game:GetService("Chat"):SetBubbleChatSettings({
            Transparency = 0.1,
            BackgroundColor3 = Color3.fromRGB(250, 250, 250),
            TextColor3 = Color3.fromRGB(57, 59, 61)
        });
    end,
    ["1"] = function() --[[ Line: 16 ]]
        game:GetService("Chat"):SetBubbleChatSettings({
            Transparency = 0.35,
            BackgroundColor3 = Color3.new(0, 0, 0),
            TextColor3 = Color3.new(1, 1, 1)
        });
    end
};
l__RobloxChat__2.OnClientEvent:connect(function(p2) --[[ Line: 25 ]]
    -- upvalues: u1 (copy)
    local v3 = u1[tostring(p2)];
    if v3 ~= nil then
        pcall(v3);
    end;
end);
l__RobloxChat__2:FireServer();