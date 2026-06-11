-- Decompiled from: .game.Controllers.ChatController
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__TextChatService__1 = game:GetService("TextChatService");
local l__game__2 = game:GetService("ReplicatedStorage"):WaitForChild("game");
local u2 = Instance.new("BindableEvent");
local u3 = Instance.new("BoolValue");
local u4 = Instance.new("BindableEvent");
local l__CustomChat__3 = script:WaitForChild("CustomChat");
local l__ChatWindowConfiguration__4 = l__TextChatService__1:WaitForChild("ChatWindowConfiguration");
local l__ChatInputBarConfiguration__5 = l__TextChatService__1:WaitForChild("ChatInputBarConfiguration");
local function v6() --[[ Line: 16 ]]
    -- upvalues: l__game__2 (copy), u3 (copy), l__ChatWindowConfiguration__4 (copy), l__ChatInputBarConfiguration__5 (copy)
    local v5 = l__game__2:FindFirstChild("IS_CUSTOMCHAT_ENABLED") ~= nil;
    u3.Value = v5;
    l__ChatWindowConfiguration__4.Enabled = not v5;
    l__ChatInputBarConfiguration__5.Enabled = not v5;
end;
v1.OnMessageReceivedEvent = u4.Event;
function v1.ProccessMessage(p7) --[[ Line: 24 ]]
    -- upvalues: u4 (copy)
    u4:Fire(p7);
end;
v1.OnMessageProcessedEvent = u2.Event;
function v1.SendMessage(p8) --[[ Line: 27 ]]
    -- upvalues: u2 (copy)
    u2:Fire(p8);
end;
function v1.IsCustomChatEnabled() --[[ Line: 29 ]]
    -- upvalues: u3 (copy)
    return u3.Value;
end;
v1.OnCustomChatToggleEvent = u3:GetPropertyChangedSignal("Value");
function v1.GetBaseChat() --[[ Line: 31 ]]
    -- upvalues: l__CustomChat__3 (copy)
    return l__CustomChat__3:Clone();
end;
l__game__2.ChildAdded:Connect(v6);
l__game__2.ChildRemoved:Connect(v6);
local v9 = l__game__2:FindFirstChild("IS_CUSTOMCHAT_ENABLED") ~= nil;
u3.Value = v9;
l__ChatWindowConfiguration__4.Enabled = not v9;
l__ChatInputBarConfiguration__5.Enabled = not v9;
return v1;
