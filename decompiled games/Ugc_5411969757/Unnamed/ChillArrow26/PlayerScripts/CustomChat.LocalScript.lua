-- Decompiled from: .ChillArrow26.PlayerScripts.CustomChat
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__PlayerGui__1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
game:GetService("StarterGui");
game:GetService("RunService");
local l__TextChatService__2 = game:GetService("TextChatService");
local l__game__3 = game:GetService("ReplicatedStorage"):WaitForChild("game");
local l__Controllers__4 = l__game__3:WaitForChild("Controllers");
local l__BubbleEvent__5 = l__game__3:WaitForChild("Events"):WaitForChild("BubbleEvent");
local l__BubbleChatConfiguration__6 = l__TextChatService__2:WaitForChild("BubbleChatConfiguration", 60);
local l__ChatController__7 = require(l__Controllers__4:WaitForChild("ChatController"));
local u1 = {};
l__BubbleEvent__5.OnClientEvent:Connect(function(p2, p3, p4) --[[ Line: 36 ]]
    -- upvalues: l__BubbleChatConfiguration__6 (copy), l__TextChatService__2 (copy)
    if p3 == nil then
    elseif l__BubbleChatConfiguration__6.Enabled == false then
    else
        local l__Character__8 = p3.Character;
        if l__Character__8 == nil then
        else
            local v5 = l__Character__8:FindFirstChild("HumanoidRootPart");
            if v5 == nil then
            else
                if p2 == "BUBBLE_CHAT" then
                    l__TextChatService__2:DisplayBubble(v5, p4);
                end;
            end;
        end;
    end;
end);
l__ChatController__7.OnCustomChatToggleEvent:Connect(function() --[[ Line: 51 ]]
    -- upvalues: l__ChatController__7 (copy), u1 (copy), l__PlayerGui__1 (copy)
    local v6 = l__ChatController__7.IsCustomChatEnabled();
    for _, v7 in u1 do
        v7:Destroy();
    end;
    if v6 == true then
        local v8 = l__ChatController__7.GetBaseChat();
        local v9 = v8:FindFirstChildOfClass("LocalScript");
        if v9 ~= nil then
            v9.Enabled = true;
        end;
        v8.Parent = l__PlayerGui__1;
        table.insert(u1, v8);
    end;
end);
local v10 = l__ChatController__7.IsCustomChatEnabled();
for _, v11 in u1 do
    v11:Destroy();
end;
if v10 == true then
    local v12 = l__ChatController__7.GetBaseChat();
    local v13 = v12:FindFirstChildOfClass("LocalScript");
    if v13 ~= nil then
        v13.Enabled = true;
    end;
    v12.Parent = l__PlayerGui__1;
    table.insert(u1, v12);
end;
