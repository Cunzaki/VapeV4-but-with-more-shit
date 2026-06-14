-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.WorkingPhone
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TextChatService__1 = game:GetService("TextChatService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Players__3 = game:GetService("Players");
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__4:Get("Notices");
local u2 = l__Mince__4:Get("ToolHandler");
local u3 = l__Mince__4:Get("ChatHandler");
local u4 = l__Mince__4:Get("PhoneInterface");
local u5 = l__Mince__4:GetFunction("PhoneSendMessage");
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local u6 = {
    InteractBind = 150,
    Tags = { "WorkingPhone" },
    LastSendTick = workspace:GetServerTimeNow()
};
function u6.SendMessage(_, p7, u8) --[[ Line: 22 ]]
    -- upvalues: u6 (copy), u1 (copy), u5 (copy), l__TextChatService__1 (copy), l__LocalPlayer__5 (copy)
    if workspace:GetServerTimeNow() - u6.LastSendTick < 2 then
        u1.CreateNotice("You\'re sending messages too quickly!");
    else
        u6.LastSendTick = workspace:GetServerTimeNow();
        local v9 = u5:Invoke(u8, p7);
        if v9 then
            local u10 = l__TextChatService__1:WaitForChild(v9, 5);
            if u10 then
                local function v12() --[[ Line: 41 ]]
                    -- upvalues: u10 (copy), l__LocalPlayer__5 (ref)
                    for _, v11 in pairs(u10:GetChildren()) do
                        if v11:IsA("TextSource") and v11.UserId == l__LocalPlayer__5.UserId then
                            return v11;
                        end;
                    end;
                    return nil;
                end;
                local v13 = v12();
                if not v13 then
                    local v14 = tick() + 5;
                    while not v13 and tick() < v14 do
                        task.wait(0.2);
                        v13 = v12();
                    end;
                end;
                local v15, v16 = pcall(function() --[[ Line: 61 ]]
                    -- upvalues: u10 (copy), u8 (copy)
                    u10:SendAsync(u8);
                end);
                if v15 then
                else
                    warn("SendAsync failed: " .. tostring(v16));
                end;
            end;
        end;
    end;
end;
function u6.Equipped(p17) --[[ Line: 71 ]]
    -- upvalues: u6 (copy), u4 (copy)
    local l__Tool__6 = p17.Tool;
    u6.LastSendTick = l__Tool__6:GetAttribute("LastTextTick");
    u4:OpenInterface(l__Tool__6:GetAttribute("PhoneColor"));
end;
function u6.Unequipped(_) --[[ Line: 79 ]]
    -- upvalues: u4 (copy)
    u4:CloseInterface();
end;
function u6.Setup() --[[ Line: 83 ]]
    -- upvalues: u2 (copy), u6 (copy), l__Players__3 (copy), l__LocalPlayer__5 (copy), u4 (copy), l__TextChatService__1 (copy), u3 (copy)
    u2.Component(u6);
    local function u24(p18) --[[ Line: 86 ]]
        -- upvalues: l__Players__3 (ref), l__LocalPlayer__5 (ref), u4 (ref)
        if string.find(p18.TextChannel.Name, "Phone_") then
            if p18.TextSource then
                local v19 = l__Players__3:GetPlayerByUserId(p18.TextSource.UserId);
                if v19 then
                    if v19 == l__LocalPlayer__5 then
                        local v20 = string.split(p18.TextChannel.Name, "_");
                        local v21 = tonumber(v20[2]);
                        local v22 = tonumber(v20[3]);
                        if v21 == l__LocalPlayer__5.UserId then
                            v21 = v22 or v21;
                        end;
                        local v23 = l__Players__3:GetPlayerByUserId(v21);
                        if v23 then
                            u4:OnMessageDelivered(v23.Name, p18.Text);
                        end;
                    else
                        u4:OnMessageReceived(v19.Name, p18.Text);
                    end;
                end;
            end;
        end;
    end;
    function l__TextChatService__1.OnBubbleAdded(p25, _) --[[ Line: 112 ]]
        if p25.TextChannel and string.find(p25.TextChannel.Name, "Phone_") then
            local v26 = Instance.new("BubbleChatMessageProperties");
            v26.BackgroundTransparency = 1;
            v26.TextSize = 0;
            v26.TailVisible = false;
            return v26;
        end;
    end;
    u3:AddIncomingTextMessageFunction(function(p27) --[[ Line: 122 ]]
        -- upvalues: u24 (copy)
        if p27.Status == Enum.TextChatMessageStatus.Success then
            u24(p27);
            if p27.TextChannel and string.find(p27.TextChannel.Name, "Phone_") then
                p27.Text = "";
            end;
        else
            if p27.TextChannel and string.find(p27.TextChannel.Name, "Phone_") then
                p27.Text = "";
            end;
        end;
    end);
end;
return u6;
