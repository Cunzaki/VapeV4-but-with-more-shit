-- Decompiled from: .ChillArrow26.PlayerScripts.MessageReceiver
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local _ = game:GetService("Players").LocalPlayer;
local l__TextChatService__1 = game:GetService("TextChatService");
local l__ChatWindowConfiguration__2 = l__TextChatService__1:WaitForChild("ChatWindowConfiguration");
l__TextChatService__1:WaitForChild("TextChannels"):WaitForChild("RBXSystem");
game:GetService("StarterGui");
local l__game__3 = game:GetService("ReplicatedStorage"):WaitForChild("game");
l__game__3:WaitForChild("Events");
local l__Controllers__4 = l__game__3:WaitForChild("Controllers");
local l__ChatController__5 = require(l__Controllers__4:WaitForChild("ChatController"));
local l__ServerOwner__6 = game:GetService("ReplicatedStorage"):WaitForChild("ServerOwner");
l__TextChatService__1:WaitForChild("CustomChannelContainer", 60);
function l__TextChatService__1.OnChatWindowAdded(_) --[[ Line: 30 ]]
    -- upvalues: l__ChatController__5 (copy), l__ChatWindowConfiguration__2 (copy)
    if l__ChatController__5.IsCustomChatEnabled() == true then
        local v1 = l__ChatWindowConfiguration__2:DeriveNewMessageProperties();
        v1.Text = " ";
        v1.PrefixText = " ";
        v1.TextSize = 0;
        return v1;
    end;
end;
function l__TextChatService__1.OnIncomingMessage(u2) --[[ Line: 41 ]]
    -- upvalues: l__ChatController__5 (copy), l__ServerOwner__6 (copy)
    task.spawn(function() --[[ Line: 44 ]]
        -- upvalues: l__ChatController__5 (ref), u2 (copy)
        l__ChatController__5.ProccessMessage(u2);
    end);
    if u2.Metadata ~= "futuretops_system" then
        if u2.TextSource ~= nil then
            local v3 = tostring(u2.TextSource.UserId);
            local v4 = string.split(l__ServerOwner__6.Value, "(")[2];
            if v3 == ((v4 == nil or v4:len() < 1) and "" or v4:sub(1, v4:len() - 1)) then
                local v5 = Instance.new("TextChatMessageProperties");
                v5.Text = `<font color="#ffaa00">{u2.Text}</font>`;
                return v5;
            end;
        end;
        if u2.TextChannel ~= nil and (u2.TextChannel.Name:sub(1, 7) == "RBXTeam" and u2.TextSource ~= nil) then
            local v6 = game:GetService("Players"):GetPlayerByUserId(u2.TextSource.UserId);
            if v6 ~= nil then
                local v7 = Instance.new("TextChatMessageProperties");
                local l__Text__7 = u2.Text;
                v7.Text = `<font color="#{v6.TeamColor.Color:ToHex()}">{l__Text__7}</font>`;
                return v7;
            end;
        end;
        return nil;
    end;
    local v8 = Instance.new("TextChatMessageProperties");
    v8.Text = `<font color="#ffaa7f">{u2.Text}</font>`;
    v8.PrefixText = "<font color=\"#ffaa00\">[SYSTEM]:</font>";
    return v8;
end;
