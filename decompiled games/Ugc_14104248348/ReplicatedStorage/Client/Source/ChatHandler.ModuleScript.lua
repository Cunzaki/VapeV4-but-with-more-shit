-- Decompiled from: ReplicatedStorage.Client.Source.ChatHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("MessagingService");
local l__TextChatService__2 = game:GetService("TextChatService");
local l__Players__3 = game:GetService("Players");
local l__TextChannels__4 = l__TextChatService__2:WaitForChild("TextChannels");
local l__GameChannels__5 = l__TextChatService__2:WaitForChild("GameChannels");
local l__Utility__6 = require(l__ReplicatedStorage__1.Modules.Utility);
local l__Signal__7 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__8 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local v2 = l__Mince__8:GetEvent("ClientChat");
local u3 = v2:Extend("SendMessage");
local u4 = v2:Extend("ExecuteMethod");
local u5 = {
    DefaultChannels = { "RBXGeneral", "RBXSystem" },
    CustomChannels = {
        "GameSystem",
        "GameGlobal",
        "GameLocal",
        "TTS"
    },
    IncomingTextMessageFunctions = {},
    SpeakerSettings = {},
    Channels = {},
    ChannelFormats = l__Mince__8.Config.ChatFormatting.ChannelFormats,
    LocalChannelPrefixSpeaker = l__Mince__8.Config.ChatFormatting.LocalChannelPrefixSpeaker,
    ServerMessage = l__Signal__7.new()
};
function u5.OnIncomingMessage(_, p6) --[[ Line: 36 ]]
    -- upvalues: u5 (copy), l__Players__3 (copy)
    for _, v7 in u5.IncomingTextMessageFunctions do
        local v8, v9 = v7(p6);
        if v9 then
            return v8;
        end;
    end;
    local v10 = Instance.new("TextChatMessageProperties");
    if p6.TextSource then
        local v11 = l__Players__3:GetPlayerByUserId(p6.TextSource.UserId);
        local v12 = u5.SpeakerSettings[v11];
        if v12 then
            v10.PrefixText = `{u5:BuildFullPrefix(v12)} {p6.PrefixText}`;
        end;
    end;
    local v13 = u5.ChannelFormats[p6.TextChannel.Name];
    if v13 then
        v10.Text = v13:format(p6.Text);
    end;
    local v14 = u5.LocalChannelPrefixSpeaker[p6.TextChannel.Name];
    local v15 = v14 and p6.TextSource and l__Players__3:GetPlayerByUserId(p6.TextSource.UserId);
    if v15 then
        v10.PrefixText = v14:format(v15.Name);
    end;
    return v10;
end;
function u5.ConfirmChannelName(_, p16) --[[ Line: 72 ]]
    if typeof(p16) == "Instance" and p16:IsA("TextChannel") then
        return p16.Name;
    end;
    if typeof(p16) == "string" then
        return p16;
    end;
end;
function u5.GetChannel(_, p17) --[[ Line: 80 ]]
    -- upvalues: u5 (copy)
    local v18 = u5:ConfirmChannelName(p17);
    return u5.Channels[v18], v18;
end;
function u5.SendLocalMessage(_, p19, ...) --[[ Line: 86 ]]
    -- upvalues: u5 (copy)
    local v20, v21 = u5:GetChannel(p19);
    if v20 then
        v20:SendAsync(...);
    else
        warn((`Server told us to SendMessage on '{v21}' but we can't find it. The Channel may still exist! ensure it's loaded`));
    end;
end;
function u5.SendMessage(_, p22, p23) --[[ Line: 96 ]]
    -- upvalues: l__Utility__6 (copy), u5 (copy)
    assert(l__Utility__6.AssertTypes(p23, "string"));
    local v24, v25 = u5:GetChannel(p22);
    if v24 then
        v24:SendAsync(p23);
    else
        warn((`Server told us to SendMessage on '{v25}' but we can't find it. The Channel may still exist! ensure it's loaded`));
    end;
end;
function u5.ExecuteMethod(_, p26, p27, ...) --[[ Line: 107 ]]
    -- upvalues: l__Utility__6 (copy), u5 (copy)
    assert(l__Utility__6.AssertTypes(p27, "String"));
    local v28, v29 = u5:GetChannel(p26);
    if v28 then
        v28[p27](v28, ...);
    else
        warn((`Server told us to ExecuteMethod on '{v29}' but we can't find it.`));
    end;
end;
function u5.LoadAllChannels(_) --[[ Line: 119 ]]
    -- upvalues: u5 (copy), l__TextChannels__4 (copy), l__GameChannels__5 (copy)
    for _, v30 in u5.DefaultChannels do
        local v31 = l__TextChannels__4:WaitForChild(v30);
        u5.Channels[v30] = v31;
    end;
    for _, v32 in u5.CustomChannels do
        local v33 = l__GameChannels__5:WaitForChild(v32);
        u5.Channels[v32] = v33;
    end;
end;
function u5.BuildFullPrefix(_, p34) --[[ Line: 133 ]]
    -- upvalues: l__Mince__8 (copy)
    local v35 = "";
    local v36 = false;
    for _, v37 in p34.Tags do
        if l__Mince__8.Config.ChatFormatting.TagIndexes[v37] then
            v35 = v35 .. l__Mince__8.Config.ChatFormatting.TagIndexes[v37];
            v36 = true;
        end;
    end;
    if not v36 and p34.EmojiTag then
        v35 = v35 .. l__Mince__8.Config.ChatFormatting.TextFormats.Emoji:format(p34.EmojiTag);
    end;
    return v35;
end;
function u5.PlayerAdded(_, u38) --[[ Line: 150 ]]
    -- upvalues: u5 (copy), u1 (copy)
    local u39 = {
        Tags = {}
    };
    u5.SpeakerSettings[u38] = u39;
    local function v40() --[[ Line: 156 ]]
        -- upvalues: u38 (copy), u39 (copy)
        u39.Tags = string.split(u38:GetAttribute("EquippedTags") or "", ":");
        u39.EmojiTag = u38:GetAttribute("PlayerEmojiTag");
    end;
    task.defer(v40);
    u1:AddPlayerConnection(u38, u38:GetAttributeChangedSignal("EquippedTags"):Connect(v40));
    u1:AddPlayerConnection(u38, u38:GetAttributeChangedSignal("PlayerEmojiTag"):Connect(v40));
end;
function u5.PlayerRemoving(_, p41) --[[ Line: 167 ]]
    -- upvalues: u5 (copy)
    u5.SpeakerSettings[p41] = nil;
end;
function u5.AddIncomingTextMessageFunction(_, p42) --[[ Line: 171 ]]
    -- upvalues: u5 (copy)
    table.insert(u5.IncomingTextMessageFunctions, p42);
end;
function u5.Setup(_) --[[ Line: 175 ]]
    -- upvalues: l__Players__3 (copy), u5 (copy), u3 (copy), u4 (copy), l__TextChatService__2 (copy)
    for _, u43 in l__Players__3:GetPlayers() do
        task.defer(function() --[[ Line: 177 ]]
            -- upvalues: u5 (ref), u43 (copy)
            u5:PlayerAdded(u43);
        end);
    end;
    l__Players__3.PlayerRemoving:Connect(function(p44) --[[ Line: 182 ]]
        -- upvalues: u5 (ref)
        u5:PlayerRemoving(p44);
    end);
    l__Players__3.PlayerAdded:Connect(function(p45) --[[ Line: 185 ]]
        -- upvalues: u5 (ref)
        u5:PlayerAdded(p45);
    end);
    u3.Event:Connect(function(...) --[[ Line: 188 ]]
        -- upvalues: u5 (ref)
        u5:SendMessage(...);
    end);
    u4.Event:Connect(function(...) --[[ Line: 191 ]]
        -- upvalues: u5 (ref)
        u5:ExecuteMethod(...);
    end);
    function l__TextChatService__2.OnIncomingMessage(...) --[[ Line: 195 ]]
        -- upvalues: u5 (ref)
        return u5:OnIncomingMessage(...);
    end;
end;
u5:LoadAllChannels();
return u5;
