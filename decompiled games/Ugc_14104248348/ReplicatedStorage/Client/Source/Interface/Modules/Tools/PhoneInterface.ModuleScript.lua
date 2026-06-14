-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Tools.PhoneInterface
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__TweenService__3 = game:GetService("TweenService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local l__LocalPlayer__5 = l__Players__2.LocalPlayer;
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = l__Mince__4:Get("WorkingPhone");
local l__Phone__6 = l__ReplicatedStorage__1:WaitForChild("Assets"):WaitForChild("Interface"):WaitForChild("Phone");
local u3 = {
    MainUI = nil,
    MainButton = nil,
    ScreenBox = nil,
    HomeScreen = nil,
    TextsAppBox = nil,
    TimeLabel = nil,
    ActiveConvo = nil,
    SendConnection = nil,
    HomeButton = nil,
    AppTweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad),
    ScannedTypes = { "Frame", "ScrollingFrame", "ImageLabel" },
    BubbleSpacing = UDim.new(0, 4),
    OpenApps = {},
    Messages = {},
    PhoneColorSet = Color3.fromRGB(255, 255, 255)
};
local function u8(p4) --[[ Line: 54 ]]
    local v5 = DateTime.fromUnixTimestamp(p4):ToLocalTime();
    local v6 = v5.Hour >= 12 and "PM" or "AM";
    local v7 = v5.Hour % 12;
    return string.format("%d:%02d %s", v7 == 0 and 12 or v7, v5.Minute, v6);
end;
function u3.SetColor(_, p9) --[[ Line: 103 ]]
    -- upvalues: u3 (copy)
    if u3.PhoneColorSet ~= p9 then
        u3.PhoneColorSet = p9;
        u3.MainUI.PhoneBox.UIStroke.Color = p9;
        u3.MainUI.PhoneBox.HomeButtonColor.BackgroundColor3 = p9;
        u3.HomeScreen.Background.ImageColor3 = p9;
    end;
end;
function u3.OpenInterface(_, p10) --[[ Line: 115 ]]
    -- upvalues: u3 (copy)
    u3:SetColor(p10);
    u3.Interface.Open();
end;
function u3.CloseInterface(_) --[[ Line: 121 ]]
    -- upvalues: u3 (copy)
    u3.Interface.Close();
end;
local function u18(p11, p12, p13) --[[ Line: 126 ]]
    -- upvalues: u3 (copy)
    for _, v14 in pairs(p11:GetDescendants()) do
        local v15 = false;
        for _, v16 in pairs(u3.ScannedTypes) do
            if v14:IsA(v16) then
                v15 = true;
                break;
            end;
        end;
        if v15 then
            local v17;
            if p13 and p12 or not p12 then
                v17 = p12;
            else
                v17 = v14:GetAttribute("OpenOnInit") == true;
            end;
            v14.Visible = v17;
        end;
    end;
end;
function u3.DoAnimationOpenApp(_, p19) --[[ Line: 142 ]]
    -- upvalues: u3 (copy), l__TweenService__3 (copy), u18 (copy)
    local v20 = u3.ScreenBox:FindFirstChild(p19);
    if v20 then
        v20.Size = UDim2.new(0, 0, 0, 0);
        local v21 = l__TweenService__3:Create(v20, u3.AppTweenInfo, {
            Size = UDim2.new(1, 0, 1, 0)
        });
        u18(v20, false, true);
        if u3.HomeButton then
            u3.HomeButton.Active = false;
        end;
        v21:Play();
        v21.Completed:Wait();
        if u3.HomeButton then
            u3.HomeButton.Active = true;
        end;
        u18(v20, true, false);
    else
        warn("Can\'t find app: " .. tostring(p19));
    end;
end;
function u3.DoAnimationCloseApp(_, p22) --[[ Line: 160 ]]
    -- upvalues: u3 (copy), l__TweenService__3 (copy), u18 (copy)
    local v23 = u3.ScreenBox:FindFirstChild(p22);
    if v23 then
        local v24 = l__TweenService__3:Create(v23, u3.AppTweenInfo, {
            Size = UDim2.new(0, 0, 0, 0)
        });
        u18(v23, false, false);
        if u3.HomeButton then
            u3.HomeButton.Active = false;
        end;
        v24:Play();
        v24.Completed:Wait();
        if u3.HomeButton then
            u3.HomeButton.Active = true;
        end;
        u18(v23, false, true);
    else
        warn("Can\'t find app: " .. tostring(p22));
    end;
end;
function u3.AppendMessageToLog(_, p25, p26) --[[ Line: 177 ]]
    -- upvalues: u3 (copy), l__Phone__6 (copy), l__TweenService__3 (copy)
    local l__MessageLog__7 = u3.ScreenBox.ActiveConversation.MessageLog;
    local l__TextingTemp__8 = l__Phone__6.TextingTemp;
    local v27 = (p25 and l__TextingTemp__8.ToTemplate or l__TextingTemp__8.FromTemplate):Clone();
    u3:ScaleTextTemplate(v27);
    v27.Label.Text = p26;
    v27.Parent = l__MessageLog__7;
    v27.AutomaticSize = Enum.AutomaticSize.Y;
    local v28 = math.clamp(v27.AbsoluteSize.Y / 80, 0, 1);
    v27.Label.UICorner.CornerRadius = UDim.new(0, 15 - v28 * 7.5);
    task.defer(function() --[[ Line: 84 ]]
        -- upvalues: l__TweenService__3 (ref), l__MessageLog__7 (copy)
        task.wait(0.1);
        local v29 = l__TweenService__3:Create(l__MessageLog__7, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            CanvasPosition = Vector2.new(0, l__MessageLog__7.AbsoluteCanvasSize.Y)
        });
        v29:Play();
        v29.Completed:Wait();
    end);
end;
function u3.SetupMessageLogWithPlayer(_, u30) --[[ Line: 192 ]]
    -- upvalues: u3 (copy), l__Phone__6 (copy), l__Players__2 (copy), l__LocalPlayer__5 (copy), l__TweenService__3 (copy), u1 (copy), u2 (copy)
    local l__ActiveConversation__9 = u3.ScreenBox.ActiveConversation;
    local l__MessageLog__10 = l__ActiveConversation__9.MessageLog;
    local l__TextingTemp__11 = l__Phone__6.TextingTemp;
    l__ActiveConversation__9.UserIcon.Title.Text = u30.DisplayName;
    local l__PlayerIcon__12 = l__ActiveConversation__9.UserIcon.PlayerIcon;
    local l__UserId__13 = u30.UserId;
    local v31, v32 = pcall(function() --[[ Line: 72 ]]
        -- upvalues: l__Players__2 (ref), l__UserId__13 (copy)
        return l__Players__2:GetUserThumbnailAsync(l__UserId__13, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
    end);
    if v31 then
        l__PlayerIcon__12.Image = v32;
    end;
    local v33 = l__MessageLog__10:FindFirstChildWhichIsA("UIListLayout");
    if v33 then
        v33.Padding = u3.BubbleSpacing;
    end;
    for _, v34 in pairs(l__MessageLog__10:GetChildren()) do
        if not (v34:IsA("UIGridStyleLayout") or v34:IsA("UIPadding")) then
            v34:Destroy();
        end;
    end;
    u3.ActiveConvo = u30.Name;
    local l__Name__14 = u30.Name;
    if not u3.Messages[l__Name__14] then
        u3.Messages[l__Name__14] = {};
    end;
    for _, v35 in ipairs(u3.Messages[l__Name__14]) do
        local v36 = (v35.From == l__LocalPlayer__5.Name and l__TextingTemp__11.ToTemplate or l__TextingTemp__11.FromTemplate):Clone();
        u3:ScaleTextTemplate(v36);
        v36.Label.Text = v35.Text;
        v36.Parent = l__MessageLog__10;
        v36.AutomaticSize = Enum.AutomaticSize.Y;
        local v37 = math.clamp(v36.AbsoluteSize.Y / 80, 0, 1);
        v36.Label.UICorner.CornerRadius = UDim.new(0, 15 - v37 * 7.5);
    end;
    task.delay(0.1, function() --[[ Line: 225 ]]
        -- upvalues: l__MessageLog__10 (copy), l__TweenService__3 (ref)
        local u38 = l__MessageLog__10;
        task.defer(function() --[[ Line: 84 ]]
            -- upvalues: l__TweenService__3 (ref), u38 (copy)
            task.wait(0.1);
            local v39 = l__TweenService__3:Create(u38, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                CanvasPosition = Vector2.new(0, u38.AbsoluteCanvasSize.Y)
            });
            v39:Play();
            v39.Completed:Wait();
        end);
    end);
    if u3.SendConnection then
        u3.SendConnection:Disconnect();
        u3.SendConnection = nil;
    end;
    local l__SendMessageBox__15 = l__ActiveConversation__9.Texting.DesiredText.SendMessageBox;
    u3.SendConnection = u1.NewButton(l__ActiveConversation__9.Texting.Send).Activated:Connect(function() --[[ Line: 237 ]]
        -- upvalues: l__SendMessageBox__15 (copy), u2 (ref), u30 (copy)
        local l__Text__16 = l__SendMessageBox__15.Text;
        if l__Text__16 and l__Text__16 ~= "" then
            l__SendMessageBox__15.Text = "";
            u2:SendMessage(u30.Name, l__Text__16);
        end;
    end);
end;
function u3.RefreshPlayerEntry(_, p40) --[[ Line: 248 ]]
    -- upvalues: u3 (copy), u8 (copy)
    local v41 = u3.TextsAppBox.Options:FindFirstChild(p40);
    if v41 then
        if not u3.Messages[p40] then
            u3.Messages[p40] = {};
        end;
        local v42 = u3.Messages[p40];
        if #v42 > 0 then
            local v43 = v42[#v42];
            v41.Info.Body.Text = v43.Text;
            v41.Info.LastTime.Text = u8(v43.Time);
        end;
    end;
end;
function u3.SetupPlayerChoices(_) --[[ Line: 262 ]]
    -- upvalues: u3 (copy), l__Phone__6 (copy), l__Players__2 (copy), u8 (copy), u1 (copy)
    local l__Options__17 = u3.TextsAppBox.Options;
    local l__PlayerChoicesTemp__18 = l__Phone__6.PlayerChoicesTemp;
    for _, v44 in pairs(l__Options__17:GetChildren()) do
        if not (v44:IsA("UIGridStyleLayout") or v44:IsA("UIPadding")) then
            v44:Destroy();
        end;
    end;
    local function u54() --[[ Line: 273 ]]
        -- upvalues: l__Options__17 (copy)
        local v45 = {};
        for _, v46 in pairs(l__Options__17:GetChildren()) do
            if not (v46:IsA("UIGridStyleLayout") or v46:IsA("UIPadding")) then
                table.insert(v45, v46);
            end;
        end;
        table.sort(v45, function(p47, p48) --[[ Line: 280 ]]
            return p47.LayoutOrder < p48.LayoutOrder;
        end);
        for v49, v50 in ipairs(v45) do
            local v51 = (v49 - 1) % 2 == 0;
            local v52 = v50:GetAttribute("BrightColor");
            local v53 = v50:GetAttribute("DarkColor");
            v50.BackgroundColor3 = v51 and v52 and v52 or v53;
            local l__Fade__19 = v50.Info.Body.Fade;
            if v51 then
                v53 = v52 or v53;
            end;
            l__Fade__19.BackgroundColor3 = v53;
        end;
    end;
    local u55 = 0;
    local function v62(u56) --[[ Line: 294 ]]
        -- upvalues: l__Players__2 (ref), l__PlayerChoicesTemp__18 (copy), u55 (ref), u3 (ref), u8 (ref), u1 (ref), l__Options__17 (copy), u54 (copy)
        if u56 == l__Players__2.LocalPlayer then
        else
            local v57 = l__PlayerChoicesTemp__18.Template:Clone();
            v57.LayoutOrder = u55;
            v57.Info.Title.Text = u56.DisplayName;
            v57.Name = u56.Name;
            local l__Name__20 = u56.Name;
            if not u3.Messages[l__Name__20] then
                u3.Messages[l__Name__20] = {};
            end;
            local v58 = u3.Messages[l__Name__20];
            if #v58 > 0 then
                local v59 = v58[#v58];
                v57.Info.Body.Text = v59.Text;
                v57.Info.LastTime.Text = u8(v59.Time);
            else
                v57.Info.Body.Text = "";
                v57.Info.LastTime.Text = "";
            end;
            local l__PlayerIcon__21 = v57.Info.PlayerIcon;
            local l__UserId__22 = u56.UserId;
            local v60, v61 = pcall(function() --[[ Line: 72 ]]
                -- upvalues: l__Players__2 (ref), l__UserId__22 (copy)
                return l__Players__2:GetUserThumbnailAsync(l__UserId__22, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
            end);
            if v60 then
                l__PlayerIcon__21.Image = v61;
            end;
            u1.NewButton(v57).Activated:Connect(function() --[[ Line: 315 ]]
                -- upvalues: u3 (ref), u56 (copy)
                u3:SetupMessageLogWithPlayer(u56);
                u3:DoAnimationOpenApp("ActiveConversation");
                table.insert(u3.OpenApps, "ActiveConversation");
                u3.TextsAppBox.Options.Visible = false;
            end);
            v57.Parent = l__Options__17;
            u55 = u55 + 1;
            u54();
        end;
    end;
    for _, v63 in pairs(l__Players__2:GetPlayers()) do
        v62(v63);
    end;
    l__Players__2.PlayerAdded:Connect(v62);
    l__Players__2.PlayerRemoving:Connect(function(p64) --[[ Line: 334 ]]
        -- upvalues: l__Options__17 (copy), u54 (copy)
        local v65 = l__Options__17:FindFirstChild(p64.Name);
        if v65 then
            v65:Destroy();
            u54();
        end;
    end);
end;
function u3.OnMessageDelivered(_, _, p66) --[[ Line: 343 ]]
    -- upvalues: u3 (copy), l__LocalPlayer__5 (copy)
    u3:OnMessageReceived(l__LocalPlayer__5.Name, p66);
end;
function u3.OnMessageReceived(_, p67, p68) --[[ Line: 347 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u3 (copy), l__Phone__6 (copy)
    local v69 = p67 == l__LocalPlayer__5.Name;
    local v70;
    if v69 then
        v70 = u3.ActiveConvo or p67;
    else
        v70 = p67;
    end;
    if v70 then
        if not u3.Messages[v70] then
            u3.Messages[v70] = {};
        end;
        local v71 = u3.Messages[v70];
        local v72 = {
            From = p67,
            Text = p68,
            Time = os.time()
        };
        table.insert(v71, v72);
        if u3.ActiveConvo == v70 then
            u3:AppendMessageToLog(v69, p68);
            if v69 then
                l__Phone__6.Sounds.Send:Play();
            else
                l__Phone__6.Sounds.Recieve:Play();
            end;
        elseif not v69 and l__LocalPlayer__5:IsFriendsWithAsync(game.Players[p67].UserId) then
            l__Phone__6.Sounds.Notification:Play();
        end;
        u3:RefreshPlayerEntry(v70);
    end;
end;
function u3.ScaleTextTemplate(_, p73) --[[ Line: 373 ]]
    local l__Label__23 = p73:WaitForChild("Label");
    local l__UICorner__24 = l__Label__23:WaitForChild("UICorner");
    local l__UIPadding__25 = l__Label__23:WaitForChild("UIPadding");
    local function v74() --[[ Line: 378 ]]
        -- upvalues: l__Label__23 (copy), l__UICorner__24 (copy), l__UIPadding__25 (copy)
        l__Label__23.TextSize = l__Label__23.AbsoluteSize.X * 0.13513513513513514;
        l__UICorner__24.CornerRadius = UDim.new(0, l__Label__23.AbsoluteSize.X * 0.021621621621621623);
        l__UIPadding__25.PaddingTop = UDim.new(0, l__Label__23.AbsoluteSize.X * 0.021621621621621623);
        l__UIPadding__25.PaddingBottom = UDim.new(0, l__Label__23.AbsoluteSize.X * 0.021621621621621623);
    end;
    l__Label__23:GetPropertyChangedSignal("AbsoluteSize"):Connect(v74);
    v74();
end;
function u3.Setup(_) --[[ Line: 393 ]]
    -- upvalues: u3 (copy), u1 (copy), u8 (copy)
    u3.Interface = u1.Get("PhoneUI");
    u3.Interface.Positions.Below = u1.PlaceBeyond(u3.Interface.TweenFrame);
    u3.Interface.CreateTweens();
    u3.MainUI = u3.Interface.TweenFrame;
    u3.ScreenBox = u3.MainUI.PhoneBox.Screen;
    u3.HomeScreen = u3.ScreenBox.Home;
    u3.TextsAppBox = u3.ScreenBox.TextsApp;
    u3.TimeLabel = u3.ScreenBox.TopBar.Time;
    (function(u75) --[[ Name: SetupButton, Line 408 ]]
        -- upvalues: u1 (ref), u3 (ref)
        u1.NewButton(u75, {
            Mult = 0.03333333333333333
        }).Activated:Connect(function() --[[ Line: 410 ]]
            -- upvalues: u75 (copy), u3 (ref)
            local v76 = u75:GetAttribute("AppName");
            if v76 then
                u3:DoAnimationOpenApp(v76);
                for _, v77 in pairs(u3.HomeScreen.Apps:GetChildren()) do
                    if v77:IsA("ImageButton") then
                        v77.Visible = false;
                    end;
                end;
                table.insert(u3.OpenApps, v76);
            else
                warn("No AppName attribute for app!");
            end;
        end);
    end)(u3.HomeScreen.Apps.Messages);
    local v78 = u1.NewButton(u3.ScreenBox.Parent.HomeButton);
    u3.HomeButton = u3.ScreenBox.Parent.HomeButton;
    v78.Activated:Connect(function() --[[ Line: 432 ]]
        -- upvalues: u3 (ref)
        if u3.ActiveConvo then
            u3.TextsAppBox.Options.Visible = true;
            u3:DoAnimationCloseApp("ActiveConversation");
            u3.ActiveConvo = nil;
            for v79, v80 in ipairs(u3.OpenApps) do
                if v80 == "ActiveConversation" then
                    table.remove(u3.OpenApps, v79);
                    return;
                end;
            end;
            return;
        end;
        local v81 = false;
        for v82, v83 in ipairs(u3.OpenApps) do
            if v83 == "TextsApp" then
                table.remove(u3.OpenApps, v82);
                v81 = true;
                break;
            end;
        end;
        if v81 then
            for _, v84 in pairs(u3.HomeScreen.Apps:GetChildren()) do
                if v84:IsA("ImageButton") then
                    v84.Visible = true;
                end;
            end;
            u3:DoAnimationCloseApp("TextsApp");
        end;
    end);
    if u3.TimeLabel then
        u3.TimeLabel.Text = u8(os.time());
    end;
    task.spawn(function() --[[ Line: 469 ]]
        -- upvalues: u3 (ref), u8 (ref)
        while true do
            repeat
                task.wait(60 - DateTime.now():ToLocalTime().Second);
            until u3.TimeLabel;
            u3.TimeLabel.Text = u8(os.time());
        end;
    end);
    u3:SetupPlayerChoices();
end;
return u3;
