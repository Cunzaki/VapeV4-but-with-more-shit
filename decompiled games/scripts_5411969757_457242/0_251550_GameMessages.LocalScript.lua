-- Decompiled with Potassium's decompiler.

local _ = game:GetService("Players").LocalPlayer;
local l__TextChatService__1 = game:GetService("TextChatService");
local l__RBXSystem__2 = l__TextChatService__1:WaitForChild("TextChannels"):WaitForChild("RBXSystem");
game:GetService("StarterGui");
local l__Chat__3 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage", 300):WaitForChild("Remotes"):WaitForChild("Chat");
local u1 = Color3.new(1, 1, 0.4980392156862745);
game:GetService("ReplicatedStorage"):WaitForChild("ServerOwner");
require(game:GetService("ReplicatedStorage"):WaitForChild("DiscordBoosters"));
require(game:GetService("ReplicatedStorage"):WaitForChild("ChatTags"));
Color3.fromRGB(193, 157, 255);
function l__TextChatService__1.OnBubbleAdded(p2, _) --[[ Line: 74 ]]
    local v3 = Instance.new("BubbleChatMessageProperties");
    v3.Text = `<font color="#393b3d">{p2.Text}</font>`;
    return v3;
end;
l__Chat__3.OnClientEvent:connect(function(p4, p5, p6) --[[ Line: 81 ]]
    -- upvalues: u1 (copy), l__RBXSystem__2 (copy)
    if typeof(p5) == "string" then
        local _ = p6 == nil;
        l__RBXSystem__2:DisplaySystemMessage(p5, p4);
    end;
end);
wait(1);
l__RBXSystem__2:DisplaySystemMessage("[DEV MESSAGE]: Want to join our Discord community? discord.gg/M8Wsbuv", "ft_sys");