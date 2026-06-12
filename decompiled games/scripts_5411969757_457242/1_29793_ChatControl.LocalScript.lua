-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__StarterGui__2 = game:GetService("StarterGui");
local l__UserInputService__3 = game:GetService("UserInputService");
game:GetService("TweenService");
local l__Players__4 = game:GetService("Players");
local l__RunService__5 = game:GetService("RunService");
local l__TextService__6 = game:GetService("TextService");
game:GetService("Debris");
local l__TextChatService__7 = game:GetService("TextChatService");
local l__HttpService__8 = game:GetService("HttpService");
local l__CustomChannelContainer__9 = l__TextChatService__7:WaitForChild("CustomChannelContainer");
local l__DefaultFolder__10 = l__CustomChannelContainer__9:WaitForChild("DefaultFolder");
local l__TeamsFolder__11 = l__CustomChannelContainer__9:WaitForChild("TeamsFolder");
local l__WhisperFolder__12 = l__CustomChannelContainer__9:WaitForChild("WhisperFolder");
local l__Global__13 = l__DefaultFolder__10:WaitForChild("Global");
local l__Admins__14 = l__DefaultFolder__10:WaitForChild("Admins");
local l__Parent__15 = script.Parent;
local l__Container__16 = l__Parent__15:WaitForChild("Container");
local l__ScrollingFrame__17 = l__Container__16:WaitForChild("ScrollContainer"):WaitForChild("ScrollingFrame");
local l__UIListLayout__18 = l__ScrollingFrame__17:WaitForChild("UIListLayout");
local l__TextBox__19 = l__Container__16:WaitForChild("Frame"):WaitForChild("Container"):WaitForChild("TextBox");
local l__game__20 = game:GetService("ReplicatedStorage"):WaitForChild("game");
local l__Controllers__21 = l__game__20:WaitForChild("Controllers");
local l__Events__22 = l__game__20:WaitForChild("Events");
l__game__20:WaitForChild("Misc");
local l__ChatController__23 = require(l__Controllers__21:WaitForChild("ChatController"));
local l__DiscordBoosters__24 = require(game:GetService("ReplicatedStorage"):WaitForChild("DiscordBoosters"));
local l__ChatFunction__25 = l__Events__22:WaitForChild("ChatFunction");
local l__ChatTags__26 = require(game:GetService("ReplicatedStorage"):WaitForChild("ChatTags"));
script:WaitForChild("ChatMessageSample");
local l__Whisper__27 = l__TextBox__19.Parent:WaitForChild("Whisper");
local l__TeamChat__28 = l__TextBox__19.Parent:WaitForChild("TeamChat");
local l__Admin__29 = l__TextBox__19.Parent:WaitForChild("Admin");
local l__Sounds__30 = script:WaitForChild("Sounds");
local u1 = "GLOBAL_MESSAGE";
local u2 = nil;
local u3 = 0;
TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
local u4 = false;
local u5 = Color3.fromRGB(255, 170, 0);
local u6 = Color3.fromRGB(0, 170, 255);
local u7 = Color3.fromRGB(255, 255, 127);
local u8 = Color3.fromRGB(255, 151, 246);
local u9 = Color3.fromRGB(222, 35, 29);
local u10 = Color3.fromRGB(193, 157, 255);
local function u17(p11) --[[ Line: 99 ]]
    -- upvalues: l__Container__16 (copy), l__TextService__6 (copy)
    local l__Message__31 = p11:WaitForChild("Message");
    local v12 = p11:FindFirstChild("PrefixValue");
    local v13 = p11:FindFirstChild("SufixValue");
    if v12 == nil then
    elseif v13 == nil then
    else
        local v14 = Font.new("rbxassetid://11702779517", l__Message__31.FontFace.Weight);
        local v15 = Instance.new("GetTextBoundsParams");
        v15.Name = "BoundsParams";
        v15.Text = v12.Value .. v13.Value;
        v15.Font = v14;
        v15.Size = 15;
        v15.RichText = true;
        v15.Width = l__Container__16.AbsoluteSize.X - 16;
        local v16 = l__TextService__6:GetTextBoundsAsync(v15);
        l__Message__31.FontFace = v14;
        l__Message__31.Size = UDim2.fromOffset(v16.X + 4, v16.Y);
        l__Message__31.Text = v15.Text;
        p11.Size = UDim2.fromOffset(v16.X + 12, v16.Y);
        v15:Destroy();
    end;
end;
local function u29(p18, p19, p20, p21, p22) --[[ Line: 123 ]]
    -- upvalues: u8 (copy), l__Container__16 (copy), l__TextService__6 (copy)
    local l__Message__32 = p18:WaitForChild("Message");
    if p22 == "WHISPER" then
        p20 = `<i>{p20}</i>`;
        local v23 = u8;
        if v23 ~= nil then
            p20 = `<font color="#{v23:ToHex()}">{p20}</font>`;
        end;
    else
        local _ = p22 == "DEFAULT";
    end;
    local v24 = Font.new("rbxassetid://11702779517", p21);
    l__Message__32.FontFace = v24;
    l__Message__32.TextSize = 15;
    local v25 = Instance.new("StringValue", p18);
    v25.Name = "PrefixValue";
    v25.Value = p19;
    local v26 = Instance.new("StringValue", p18);
    v26.Name = "SufixValue";
    v26.Value = p20;
    local v27 = Instance.new("GetTextBoundsParams");
    v27.Name = "BoundsParams";
    v27.Text = p19 .. p20;
    v27.Font = v24;
    v27.Size = 15;
    v27.RichText = true;
    v27.Width = l__Container__16.AbsoluteSize.X - 16;
    local v28 = l__TextService__6:GetTextBoundsAsync(v27);
    l__Message__32.FontFace = v24;
    l__Message__32.Size = UDim2.fromOffset(v28.X + 4, v28.Y);
    l__Message__32.Text = v27.Text;
    p18.Size = UDim2.fromOffset(v28.X + 12, v28.Y);
    v27:Destroy();
end;
local function u35(p30, p31) --[[ Line: 191 ]]
    -- upvalues: l__Players__4 (copy), l__LocalPlayer__1 (copy)
    local v32 = {};
    if p30 == "" or p30 == " " then
        return v32;
    end;
    for _, v33 in l__Players__4:GetPlayers() do
        if p31 ~= false or v33 ~= l__LocalPlayer__1 then
            local v34 = string.lower(v33.Name);
            if string.sub(v34, 1, p30:len()) == string.lower(p30) then
                table.insert(v32, v33);
            end;
        end;
    end;
    return v32;
end;
local function u37() --[[ Line: 204 ]]
    -- upvalues: l__TeamsFolder__11 (copy), l__LocalPlayer__1 (copy)
    for _, v36 in l__TeamsFolder__11:GetChildren() do
        if v36:IsA("TextChannel") and v36:FindFirstChild(l__LocalPlayer__1.Name) ~= nil then
            return v36;
        end;
    end;
    return nil;
end;
l__ScrollingFrame__17.ChildAdded:Connect(function(p38) --[[ Line: 228 ]]
    if p38:IsA("Frame") and p38:FindFirstChild("Message") == nil then
    end;
end);
l__Container__16:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 238 ]]
    -- upvalues: l__ScrollingFrame__17 (copy), u17 (copy)
    for _, v39 in l__ScrollingFrame__17:GetChildren() do
        if v39:IsA("Frame") and v39:FindFirstChild("Message") ~= nil then
            u17(v39);
        end;
    end;
end);
l__UserInputService__3.InputBegan:Connect(function(p40, p41) --[[ Line: 246 ]]
    -- upvalues: l__Parent__15 (copy), l__UserInputService__3 (copy), l__TextBox__19 (copy), l__RunService__5 (copy), l__StarterGui__2 (copy), u4 (ref), l__Whisper__27 (copy), l__TeamChat__28 (copy), l__Admin__29 (copy), u1 (ref), u2 (ref)
    if p40.UserInputType == Enum.UserInputType.Keyboard then
        if l__Parent__15.Enabled == false then
        elseif p40.KeyCode == Enum.KeyCode.Slash and (l__UserInputService__3:GetFocusedTextBox() == nil and (p41 == false and l__TextBox__19.Visible == true)) then
            l__RunService__5.Stepped:Wait();
            l__StarterGui__2:SetCore("ChatActive", true);
            l__TextBox__19:CaptureFocus();
        else
            if p40.KeyCode == Enum.KeyCode.Backspace and l__UserInputService__3:GetFocusedTextBox() == l__TextBox__19 then
                if l__TextBox__19.Text == "" and u4 == true then
                    u4 = false;
                    l__Whisper__27.Visible = false;
                    l__TeamChat__28.Visible = false;
                    l__Admin__29.Visible = false;
                    u1 = "GLOBAL_MESSAGE";
                    u2 = nil;
                    return;
                end;
                u4 = true;
            end;
        end;
    end;
end);
l__Container__16:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 273 ]]
    -- upvalues: l__Container__16 (copy), l__TextBox__19 (copy)
    if l__Container__16.Visible == false then
        l__TextBox__19:ReleaseFocus();
    end;
end);
l__TextBox__19.FocusLost:Connect(function(p42) --[[ Line: 279 ]]
    -- upvalues: l__TextBox__19 (copy), u4 (ref), u3 (ref), l__ScrollingFrame__17 (copy), u1 (ref), l__Global__13 (copy), l__HttpService__8 (copy), u37 (copy), u2 (ref), l__ChatFunction__25 (copy), l__Admins__14 (copy), l__LocalPlayer__1 (copy)
    if p42 == true then
        local v43 = true;
        local l__Text__33 = l__TextBox__19.Text;
        l__TextBox__19.Text = "";
        u4 = false;
        if l__Text__33:lower() == "/clear" then
            v43 = false;
            u3 = 0;
            for _, v44 in l__ScrollingFrame__17:GetChildren() do
                if v44:IsA("Frame") then
                    v44:Destroy();
                end;
            end;
        end;
        if l__Text__33 ~= "" and v43 == true then
            local v45 = tostring(l__Text__33):sub(1, 128);
            if u1 == "GLOBAL_MESSAGE" then
                local v46 = l__Global__13;
                l__HttpService__8:GenerateGUID(false);
                v46:SendAsync(v45);
                return;
            end;
            if u1 == "TEAM_MESSAGE" then
                local v47 = u37();
                if v47 ~= nil then
                    l__HttpService__8:GenerateGUID(false);
                    v47:SendAsync(v45);
                end;
            elseif u1 == "WHISPER_MESSAGE" and u2 ~= nil then
                local v48, v49 = l__ChatFunction__25:InvokeServer("MANAGE_WHISPER", u2);
                if v48 == true and v49 ~= nil then
                    l__HttpService__8:GenerateGUID(false);
                    v49:SendAsync(v45);
                end;
            elseif u1 == "ADMIN_MESSAGE" and l__Admins__14:FindFirstChild(l__LocalPlayer__1.Name) ~= nil then
                local v50 = l__Admins__14;
                l__HttpService__8:GenerateGUID(false);
                v50:SendAsync(v45);
            end;
        end;
    end;
end);
l__TextBox__19:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 322 ]]
    -- upvalues: l__TextBox__19 (copy), u4 (ref), l__UserInputService__3 (copy), u35 (copy), l__RunService__5 (copy), u1 (ref), u2 (ref), l__Whisper__27 (copy), u8 (copy), l__TeamChat__28 (copy), l__Admin__29 (copy)
    local l__Text__34 = l__TextBox__19.Text;
    if l__Text__34 ~= "" then
        u4 = false;
    end;
    if l__UserInputService__3:GetFocusedTextBox() == l__TextBox__19 then
        local v51 = string.split(l__Text__34, " ");
        if string.lower(v51[1]) == "/w" or string.lower(v51[1]) == "/whisper" then
            local v52 = v51[2];
            if v52 == nil then
                return;
            else
                local v53 = u35(v52, l__RunService__5:IsStudio());
                local v54 = v53[1];
                if v54 == nil then
                    return;
                elseif #v53 > 1 then
                    return;
                else
                    u1 = "WHISPER_MESSAGE";
                    u2 = v54;
                    l__TextBox__19.Text = table.concat(v51, " ", 3);
                    l__Whisper__27.Visible = true;
                    l__Whisper__27.TextColor3 = u8;
                    l__TeamChat__28.Visible = false;
                    l__Admin__29.Visible = false;
                    l__Whisper__27.Text = `[Whisper to {v54.Name}] `;
                    return;
                end;
            end;
        end;
        if string.lower(v51[1]) == "/t" or string.lower(v51[1]) == "/team" then
            u1 = "TEAM_MESSAGE";
            u2 = nil;
            l__TeamChat__28.Visible = true;
            l__Whisper__27.Visible = false;
            l__Admin__29.Visible = false;
            l__TextBox__19.Text = table.concat(v51, " ", 2);
            return;
        end;
        if string.lower(v51[1]) == "/adm" or string.lower(v51[1]) == "/admin" then
            u1 = "ADMIN_MESSAGE";
            u2 = nil;
            l__TeamChat__28.Visible = false;
            l__Whisper__27.Visible = false;
            l__Admin__29.Visible = true;
            l__TextBox__19.Text = table.concat(v51, " ", 2);
            return;
        end;
        if string.lower(v51[1]) == "/all" or string.lower(v51[1]) == "/global" then
            u1 = "GLOBAL_MESSAGE";
            u2 = nil;
            l__TeamChat__28.Visible = false;
            l__Whisper__27.Visible = false;
            l__Admin__29.Visible = false;
            l__TextBox__19.Text = table.concat(v51, " ", 2);
        end;
    end;
end);
local function u62(p55, p56) --[[ Line: 403 ]]
    -- upvalues: l__ScrollingFrame__17 (copy), u3 (ref), u7 (copy), u6 (copy), u29 (copy), l__Sounds__30 (copy), l__StarterGui__2 (copy)
    local v57 = script.ChatMessageSample:Clone();
    v57.LayoutOrder = DateTime.now().UnixTimestampMillis;
    v57.Parent = l__ScrollingFrame__17;
    u3 = u3 + 1;
    local v58 = "";
    local v59 = `{p56}`;
    local v60;
    if p55 == 1 then
        v60 = u7;
    elseif p55 == 2 then
        v60 = u6;
    else
        v60 = Color3.fromRGB(210, 210, 210);
    end;
    if v60 ~= nil then
        v59 = `<font color="#{v60:ToHex()}">{v59}</font>`;
    end;
    u29(v57, "" .. v58, v59, Enum.FontWeight.SemiBold, "SYSTEM");
    local v61 = l__Sounds__30:FindFirstChild("IncomingMessage");
    if v61 == nil then
    elseif l__StarterGui__2:GetCore("ChatActive") == true then
    else
        v61:Play();
    end;
end;
l__ChatController__23.OnMessageReceivedEvent:Connect(function(p63) --[[ Line: 432 ]]
    -- upvalues: l__CustomChannelContainer__9 (copy), u62 (copy), l__Players__4 (copy), l__ScrollingFrame__17 (copy), u3 (ref), l__DefaultFolder__10 (copy), l__Global__13 (copy), l__ChatTags__26 (copy), l__Admins__14 (copy), u5 (copy), l__TeamsFolder__11 (copy), l__WhisperFolder__12 (copy), l__LocalPlayer__1 (copy), u8 (copy), l__Sounds__30 (copy), l__StarterGui__2 (copy), u9 (copy), l__DiscordBoosters__24 (copy), u10 (copy), u29 (copy)
    local l__TextChannel__35 = p63.TextChannel;
    local l__TextSource__36 = p63.TextSource;
    if l__TextChannel__35 == nil then
        return;
    end;
    if l__CustomChannelContainer__9:IsAncestorOf(l__TextChannel__35) == false and l__TextSource__36 ~= nil then
        return;
    end;
    if l__TextSource__36 == nil then
        local l__Metadata__37 = p63.Metadata;
        u62(l__Metadata__37 == "ft_sys" and 1 or (l__Metadata__37 == "ban_sys" and 2 or 0), p63.Text);
        return;
    end;
    local l__UserId__38 = l__TextSource__36.UserId;
    local v64 = l__Players__4:GetPlayerByUserId(l__UserId__38);
    if v64 == nil then
        return;
    end;
    local l__Text__39 = p63.Text;
    local v65 = "";
    local v66 = false;
    local v67 = l__ScrollingFrame__17:FindFirstChild(p63.MessageId) or script.ChatMessageSample:Clone();
    v67.LayoutOrder = p63.Timestamp.UnixTimestampMillis;
    v67.Name = p63.MessageId;
    if p63.Status == Enum.TextChatMessageStatus.Sending then
        v67:SetAttribute("DefaultMessage", l__Text__39);
    end;
    local v68 = v67:GetAttribute("DefaultMessage");
    if v68 ~= nil and v68:len() > l__Text__39:len() then
        l__Text__39 = v68;
    end;
    u3 = u3 + 1;
    if l__DefaultFolder__10:IsAncestorOf(l__TextChannel__35) then
        if l__TextChannel__35 == l__Global__13 then
            local v69 = l__ChatTags__26[tostring(v64.UserId)];
            if v69 ~= nil and l__TextChannel__35 == l__Global__13 then
                local v70 = `{v69.Name} `;
                local l__Color__40 = v69.Color;
                if l__Color__40 ~= nil then
                    v70 = `<font color="#{l__Color__40:ToHex()}">{v70}</font>`;
                end;
                v65 = v65 .. `<b>{v70}</b>`;
            end;
            local v71 = `{v64.Name}: `;
            local l__Color__41 = v64.TeamColor.Color;
            if l__Color__41 ~= nil then
                v71 = `<font color="#{l__Color__41:ToHex()}">{v71}</font>`;
            end;
            v65 = v65 .. `<b>{v71}</b>`;
        elseif l__TextChannel__35 == l__Admins__14 then
            local v72 = `[{v64.Name} to Admins]: `;
            local v73 = u5;
            if v73 ~= nil then
                v72 = `<font color="#{v73:ToHex()}">{v72}</font>`;
            end;
            v65 = `<b>{v65 .. `<i>{v72}</i>`}</b>`;
        end;
    elseif l__TeamsFolder__11:IsAncestorOf(l__TextChannel__35) then
        local l__Color__42 = v64.TeamColor.Color;
        local v74 = v65 .. `<b>{`<i>{l__Color__42 == nil and "[TEAM CHAT] " or `<font color="#{l__Color__42:ToHex()}">[TEAM CHAT] </font>`}</i>`}</b>`;
        local v75 = `{v64.Name}: `;
        local l__Color__43 = v64.TeamColor.Color;
        if l__Color__43 ~= nil then
            v75 = `<font color="#{l__Color__43:ToHex()}">{v75}</font>`;
        end;
        v65 = v74 .. `<b>{v75}</b>`;
    elseif l__WhisperFolder__12:IsAncestorOf(l__TextChannel__35) then
        local v76 = v64 == l__LocalPlayer__1;
        local v77 = nil;
        for _, v78 in l__TextChannel__35:GetChildren() do
            if v78:IsA("TextSource") and v78 ~= p63.TextSource then
                v77 = v78;
                break;
            end;
        end;
        if v77 == nil then
            return;
        end;
        v66 = true;
        local v79 = "[Whisper %*]: ";
        local v80;
        if v76 == true then
            v80 = `to {v77.Name}`;
        else
            v80 = `from {l__TextSource__36.Name}`;
        end;
        local v81 = v79:format(v80);
        local v82 = u8;
        if v82 ~= nil then
            v81 = `<font color="#{v82:ToHex()}">{v81}</font>`;
        end;
        v65 = `<b>{v65 .. `<i>{v81}</i>`}</b>`;
    end;
    if v64 ~= l__LocalPlayer__1 then
        if v66 == false then
            local v83 = l__Sounds__30:FindFirstChild("IncomingMessage");
            if v83 ~= nil and l__StarterGui__2:GetCore("ChatActive") ~= true then
                v83:Play();
            end;
        elseif v66 == true then
            local v84 = l__Sounds__30:FindFirstChild("IncomingWhisper");
            if v84 ~= nil and l__StarterGui__2:GetCore("ChatActive") ~= true then
                v84:Play();
            end;
        end;
    end;
    local v85;
    if p63.Status == Enum.TextChatMessageStatus.Success or p63.Status == Enum.TextChatMessageStatus.Sending then
        v85 = "";
    else
        local v86 = u9;
        v85 = `<i>{v86 == nil and "[ERROR SENDING] " or `<font color="#{v86:ToHex()}">[ERROR SENDING] </font>`}</i>`;
    end;
    local v87 = "" .. v85 .. v65;
    local v88 = l__Text__39:gsub("<[^>]->", "");
    if l__DiscordBoosters__24[tostring(l__UserId__38)] ~= nil then
        local v89 = u10;
        if v89 ~= nil then
            v88 = `<font color="#{v89:ToHex()}">{v88}</font>`;
        end;
    end;
    local v90 = u29;
    local v91;
    if v66 == false then
        v91 = Enum.FontWeight.Medium;
    else
        v91 = Enum.FontWeight.Medium;
    end;
    v90(v67, v87, v88, v91, v66 == true and "WHISPER" or "DEFAULT");
    v67.Parent = l__ScrollingFrame__17;
end);
local u92 = true;
l__UIListLayout__18:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 574 ]]
    -- upvalues: l__UIListLayout__18 (copy), l__ScrollingFrame__17 (copy), u92 (ref)
    local l__AbsoluteContentSize__44 = l__UIListLayout__18.AbsoluteContentSize;
    l__ScrollingFrame__17.CanvasSize = UDim2.new(0, 0, 0, l__AbsoluteContentSize__44.Y);
    if u92 then
        l__ScrollingFrame__17.CanvasPosition = Vector2.new(0, l__AbsoluteContentSize__44.Y - l__ScrollingFrame__17.AbsoluteWindowSize.Y);
    end;
end);
l__ScrollingFrame__17:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 583 ]]
    -- upvalues: u92 (ref), l__ScrollingFrame__17 (copy)
    local l__Offset__45 = l__ScrollingFrame__17.CanvasSize.Y.Offset;
    local l__Y__46 = l__ScrollingFrame__17.AbsoluteWindowSize.Y;
    u92 = l__Offset__45 < l__Y__46 and true or l__Offset__45 - l__ScrollingFrame__17.CanvasPosition.Y <= l__Y__46 + 5;
end);
l__Whisper__27.MouseButton1Click:Connect(function() --[[ Line: 587 ]]
    -- upvalues: l__Whisper__27 (copy), l__TeamChat__28 (copy), l__Admin__29 (copy), u1 (ref), u2 (ref)
    l__Whisper__27.Visible = false;
    l__TeamChat__28.Visible = false;
    l__Admin__29.Visible = false;
    u1 = "GLOBAL_MESSAGE";
    u2 = nil;
end);
l__TeamChat__28.MouseButton1Click:Connect(function() --[[ Line: 588 ]]
    -- upvalues: l__Whisper__27 (copy), l__TeamChat__28 (copy), l__Admin__29 (copy), u1 (ref), u2 (ref)
    l__Whisper__27.Visible = false;
    l__TeamChat__28.Visible = false;
    l__Admin__29.Visible = false;
    u1 = "GLOBAL_MESSAGE";
    u2 = nil;
end);
l__Admin__29.MouseButton1Click:Connect(function() --[[ Line: 589 ]]
    -- upvalues: l__Whisper__27 (copy), l__TeamChat__28 (copy), l__Admin__29 (copy), u1 (ref), u2 (ref)
    l__Whisper__27.Visible = false;
    l__TeamChat__28.Visible = false;
    l__Admin__29.Visible = false;
    u1 = "GLOBAL_MESSAGE";
    u2 = nil;
end);
l__LocalPlayer__1:GetPropertyChangedSignal("TeamColor"):Connect(function() --[[ Line: 594 ]]
    -- upvalues: l__TeamChat__28 (copy), l__LocalPlayer__1 (copy)
    l__TeamChat__28.TextColor3 = l__LocalPlayer__1.TeamColor.Color;
end);
l__TeamChat__28.TextColor3 = l__LocalPlayer__1.TeamColor.Color;
for _, v93 in Enum.FontWeight:GetEnumItems() do
    local v94 = Font.new("rbxassetid://11702779517", v93);
    local v95 = Instance.new("GetTextBoundsParams");
    v95.Name = "BoundsParams";
    v95.Text = "Test, <i>Test</i>, <b>Test</b>, <u>Test</u>";
    v95.Font = v94;
    v95.Size = 15;
    v95.RichText = true;
    v95.Width = l__Container__16.AbsoluteSize.X - 16;
    l__TextService__6:GetTextBoundsAsync(v95);
end;
while l__RunService__5.Stepped:Wait() do
    l__Container__16.Visible = l__StarterGui__2:GetCore("ChatActive");
end;