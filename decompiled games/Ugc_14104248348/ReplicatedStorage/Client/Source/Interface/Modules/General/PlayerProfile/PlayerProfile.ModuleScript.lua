-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PlayerProfile.PlayerProfile
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("StarterGui");
local l__Players__3 = game:GetService("Players");
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__6 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__Signal__7 = require(l__ReplicatedStorage__1.Modules.Signal);
require(l__ReplicatedStorage__1.Modules.Module3D);
require(l__ReplicatedStorage__1.Modules.Numerics);
local l__timeago__8 = require(l__ReplicatedStorage__1.Modules.timeago);
local l__Mutex__9 = require(l__ReplicatedStorage__1.Modules.Mutex);
require(l__ReplicatedStorage__1.Modules.RarityUtil);
l__Mince__5:Get("ItemFrame");
l__Mince__5:Get("NotifPrompt");
local u1 = l__Mince__5:Get("Settings");
local u2 = l__Mince__5:Get("UserProfile");
local u3 = l__Mince__5:Get("ConfirmPrompt");
local u4 = l__Mince__5:Get("InterfaceHandler");
local u5 = l__Mince__5:Get("Notices");
local u6 = l__Mince__5:GetFunction("RequestPlayerProfile");
local v7 = l__Mince__5:GetEvent("GameProfileActions");
local u8 = v7:Extend("DeleteComment");
local u9 = v7:Extend("ReportComment");
local u10 = v7:Extend("AddComment");
local u11 = v7:Extend("LikeProfile");
local u12 = v7:Extend("UpdateSettings");
v7:Extend("ReportPlayerIsBlocked");
local u13 = v7:Extend("Reflect");
local l__LocalPlayer__10 = l__Players__3.LocalPlayer;
local u14 = {
    [true] = "Enabled",
    [false] = "Disabled"
};
local u15 = {
    "Likes",
    "Rank",
    "Time",
    "Robux",
    "Username",
    "LikeLabel",
    "CommentLabel",
    "NoCommentNotice",
    "Label",
    "SettingName",
    "LikeImage",
    "Settings",
    "CloseButton",
    "PfpImageBorder",
    "Comment",
    "Date"
};
local u16 = {
    "Amatic SC",
    "Arimo",
    "Balthazar",
    "Bangers",
    "Builder Sans",
    "Comic Neue Angular",
    "Creepster",
    "Denk One",
    "Fondamento",
    "Fredoka One",
    "Grenze Gotisch",
    "Guru",
    "Highway Gothic",
    "Inconsolata",
    "Indie Flower",
    "Josefin Sans",
    "Luckiest Guy",
    "Merriweather",
    "Michroma",
    "Montserrat",
    "Nunito",
    "Press Start 2P",
    "Zekton"
};
function SetCharacterLimit(u17, u18)
    u17:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 89 ]]
        -- upvalues: u17 (copy), u18 (copy)
        if u18 < string.len(u17.Text) then
            u17.Text = string.sub(u17.Text, 1, u18);
        end;
    end);
end;
local v19 = Color3.fromRGB(35, 35, 35);
local u20 = {
    ColorPicking = false,
    Coloring = nil,
    PagesByPlayer = {},
    LocalSettings = {},
    SwitchPageMutex = l__Mutex__9.new(),
    SettingsReady = l__Signal__7.new(),
    CurrentColor = v19,
    ColorHSV = { v19:ToHSV() },
    OnColorChange = l__Signal__7.new(),
    JoinedOn = l__Unify__6.GetServerTime(),
    SecondsToUnlockProfile = l__Mince__5.Config.Place.IsMainGame and 7200 or 60
};
local u21 = {};
u21.__index = u21;
function u21.new(p22) --[[ Line: 116 ]]
    -- upvalues: l__Mutex__9 (copy), u21 (copy)
    local v23 = {
        Callbacks = {},
        Data = p22,
        ActionMutex = l__Mutex__9.new()
    };
    return setmetatable(v23, u21);
end;
function u21.Resolve(p24, p25) --[[ Line: 126 ]]
    if typeof(p25) == "function" then
        local v26 = p24.Data or {};
        p25 = p25(v26) or v26;
    end;
    p24.Data = p25;
    for _, v27 in p24.Callbacks do
        task.defer(v27, p25);
    end;
end;
function u21.ReflectResolved(p28, p29) --[[ Line: 139 ]]
    table.insert(p28.Callbacks, p29);
    if p28.Data then
        task.defer(p29, p28.Data);
    end;
end;
function u21.Reflect(p30, p31) --[[ Line: 148 ]]
    table.insert(p30.Callbacks, p31);
    task.defer(p31, p30.Data);
end;
local u32 = {
    __index = u20
};
function u32.new(p33, p34) --[[ Line: 157 ]]
    -- upvalues: u32 (copy), l__Maid__4 (copy), u21 (copy), l__Mince__5 (copy)
    local u35 = setmetatable({}, {
        __index = u32
    });
    u35.Maid = l__Maid__4.new();
    u35.Player = p33;
    u35.IsLocal = p34;
    u35.LoadedComments = {};
    u35.PlayerRole = u21.new();
    u35.ProfileComments = u21.new({
        Comments = {}
    });
    u35.ProfileMeta = u21.new({
        Settings = {}
    });
    u35:NewGui();
    u35.PlayerRole:Resolve(function(p36) --[[ Line: 176 ]]
        -- upvalues: u35 (copy), l__Mince__5 (ref)
        local v37 = u35.Player:GetRoleInGroupAsync(game.CreatorId);
        local v38 = l__Mince__5.Config.Inventory.Emoji[v37];
        local v39 = not v38 and "" or `[{v38.Emoji}]`;
        p36.RoleInGroup = v37;
        p36.Prefix = v39;
        return p36;
    end);
    return u35;
end;
function u32.NewGui(p40) --[[ Line: 194 ]]
    -- upvalues: u20 (copy)
    p40.GUI = u20.Page:Clone();
    p40.Contents = p40.GUI.Contents;
    p40.Title = p40.GUI.Title;
    p40.GUI.Parent = u20.Interface.TweenFrame;
    p40.GUI.Visible = false;
    p40:SyncInterfaceStuff();
end;
function u32.FoldGui(p41) --[[ Line: 203 ]]
    p41.GUI:Destroy();
    p41.GUI = nil;
end;
function u32.Destroy(p42) --[[ Line: 208 ]]
    if p42.Destroyed then
    else
        p42.Destroyed = true;
        p42:FoldGui();
        p42.Maid:Cleanup();
    end;
end;
function u32.PartialReflect(p43, u44) --[[ Line: 219 ]]
    local u45 = nil;
    p43.ProfileMeta:Resolve(function(p46) --[[ Line: 221 ]]
        -- upvalues: u44 (copy), u45 (ref)
        for v47, v48 in u44 do
            p46[v47] = v48;
        end;
        if p46.Comments then
            u45 = p46.Comments;
        end;
        return p46;
    end);
    if u45 then
        p43.ProfileComments:Resolve({
            Comments = u45
        });
    end;
end;
function u32.Reflect(u49, u50) --[[ Line: 240 ]]
    -- upvalues: u6 (copy)
    u49.ProfileMeta:Resolve(function(p51) --[[ Line: 241 ]]
        -- upvalues: u50 (copy), u6 (ref), u49 (copy)
        p51[u50] = u6:Invoke(u49.Player, u50)[u50];
        return p51;
    end);
end;
function u32.SyncInterfaceStuff(u52) --[[ Line: 247 ]]
    -- upvalues: u20 (copy), l__LocalPlayer__10 (copy), l__ReplicatedStorage__1 (copy), l__timeago__8 (copy), u4 (copy), l__Unify__6 (copy), l__Mince__5 (copy), u11 (copy), u10 (copy)
    if u52.GUI then
        local u53 = {
            Color = nil,
            Family = nil
        };
        local function u58(p54) --[[ Line: 257 ]]
            -- upvalues: u53 (copy), u20 (ref), u52 (copy)
            if p54 then
                local v55, v56, v57 = unpack((p54.Settings.FontColor or "255,255,255"):split(","));
                u53.Color = Color3.fromRGB(v55, v56, v57);
                u53.Family = p54.Settings.FontFamily or "Montserrat";
            end;
            repeat
                task.wait(0.1);
            until u53.Color and u53.Family;
            u20:SetFontColor(u53.Color, u52.Contents.Parent.Parent);
            u20:SetFontFamily(u53.Family);
        end;
        task.defer(function() --[[ Line: 274 ]]
            -- upvalues: u52 (copy), l__LocalPlayer__10 (ref)
            u52.Title.Username.Text = u52.Player.DisplayName;
            u52.Title.ImageLabel.Image = `rbxthumb://type=AvatarHeadShot&id={u52.Player.UserId}&w=60&h=60`;
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Profile.Image = `rbxthumb://type=AvatarHeadShot&id={l__LocalPlayer__10.UserId}&w=60&h=60`;
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Username.Username.Text = l__LocalPlayer__10.Name;
        end);
        u52.PlayerRole:Reflect(function(p59) --[[ Line: 282 ]]
            -- upvalues: u52 (copy)
            if p59 then
                u52.Title.RankContainer.Rank.Text = `{p59.Prefix}{p59.RoleInGroup}`;
            else
                u52.Title.RankContainer.Rank.Text = "Loading...";
            end;
        end);
        u52.ProfileComments:Reflect(function(p60) --[[ Line: 291 ]]
            -- upvalues: u52 (copy), l__ReplicatedStorage__1 (ref), l__timeago__8 (ref), u4 (ref), u58 (copy), u20 (ref)
            u52.Contents.Right.CommentScrollContainer.NoCommentNotice.Visible = #p60.Comments < 1;
            warn("ProfileCOmments->", p60);
            local v61 = {};
            for v62, v63 in p60.Comments do
                local l__ID__11 = v63.ID;
                if l__ID__11 then
                    v61[l__ID__11] = true;
                    if u52.LoadedComments[l__ID__11] then
                        u52.LoadedComments[l__ID__11].Interface.LayoutOrder = -v62;
                    else
                        local u64 = {
                            CommentData = v63,
                            ID = l__ID__11
                        };
                        local v65 = game.Workspace:GetServerTimeNow() - v63.Timestamp;
                        u64.Interface = l__ReplicatedStorage__1.Assets.Interface.Profile.CommentContainer:Clone();
                        u64.Interface.LayoutOrder = -v62;
                        u64.Interface.Profile.Image = `rbxthumb://type=AvatarHeadShot&id={v63.CommentorID}&w=60&h=60`;
                        u64.Interface.Username.Username.Text = v63.CommentorName;
                        u64.Interface.Comment.CommentLabel.Text = v63.Content;
                        u64.Interface.Username.Date.Text = l__timeago__8.format(v65);
                        u64.Interface.Parent = u52.Contents.Right.CommentScrollContainer;
                        u4.NewButton(u64.Interface.Options).Activated:Connect(function() --[[ Line: 329 ]]
                            -- upvalues: u52 (ref), u64 (copy)
                            u52:OptionsFor(u64);
                        end);
                        u52.LoadedComments[l__ID__11] = u64;
                    end;
                else
                    warn((`This comment is no longer valid '{l__ID__11}'!`));
                end;
            end;
            for _, v66 in u52.LoadedComments do
                if not v61[v66.ID] then
                    v66.Interface:Destroy();
                    u52.LoadedComments[v66.ID] = nil;
                end;
            end;
            u58();
            u20.LoadingFrame.Visible = false;
            u20.LoadingTween:Pause();
        end);
        local u67 = true;
        u52.ProfileMeta:Reflect(function(p68) --[[ Line: 350 ]]
            -- upvalues: u52 (copy), u58 (copy), l__Unify__6 (ref), u67 (ref), u20 (ref), l__Mince__5 (ref)
            u52.Title.RankContainer.Likes.Text = p68.Likes or "...";
            u52.Contents.Left.StatusContainer.Time.Text = (p68.Settings.Bio == "" or not p68.Settings.Bio) and "No Bio." or `"{p68.Settings.Bio}"`;
            local v69, v70, v71 = unpack((p68.Settings.BackgroundColor or "35,35,35"):split(","));
            local v72 = Color3.fromRGB(v69, v70, v71);
            u52.Contents.Parent.Parent.BackgroundColor3 = v72;
            u58(p68);
            u52.Contents.Left.StatusContainer.Visible = p68.Settings.UGCUnlocked;
            u52.Contents.Left.StatsDisplay.TimePlayed.Time.Text = l__Unify__6.AbbreviatedTime(p68.TimePlayed or 0);
            u52.Contents.Left.StatsDisplay.DonatedDisplay.Robux.Text = `{p68.Donated or 0} Robux`;
            u52.Contents.Left.StatsDisplay.RecievedDisplay.Robux.Text = `{p68.Recieved or 0} Robux`;
            u52.Title.RankContainer.Rank.Visible = p68.Settings.ShowRank;
            u52.Title.RankContainer.LikeImage.Visible = p68.Settings.ShowLikes;
            u52.Title.RankContainer.Likes.Visible = p68.Settings.ShowLikes;
            u52.Contents.Left.StatsDisplay.TimePlayed.Visible = p68.Settings.ShowTime;
            u52.Contents.Left.StatsDisplay.DonatedDisplay.Visible = p68.Settings.ShowDonated;
            u52.Contents.Left.StatsDisplay.RecievedDisplay.Visible = p68.Settings.ShowRecieved;
            u52.Contents.Right.CommentScrollContainer.Visible = p68.Settings.ShowComments;
            local l__LikeContainer__12 = u52.Contents.Right.LikeContainer;
            local v73 = not u52.IsLocal;
            if v73 then
                v73 = not p68.CachedLiked;
            end;
            l__LikeContainer__12.Visible = v73;
            if u67 then
                local v74 = l__Unify__6.GetStandardTimeFrom(u20.JoinedOn);
                math.floor(l__Mince__5.Config.LocalProfile.TotalPlayTime + v74);
                local l__CommentButton__13 = u52.Contents.Right.CommentScrollContainer.CommentButton;
                local v75 = not u52.IsLocal;
                if v75 then
                    v75 = u20:ShouldLocalUGCBeUnlocked();
                end;
                l__CommentButton__13.Visible = v75;
                u52.Contents.Right.CommentScrollContainer.CommentComposer.Visible = false;
                u52.Contents.Right.CommentScrollContainer.CommentComposer.Comment.TextBox.Text = "";
            end;
            u67 = false;
            if u52.SizeGui then
                task.defer(u52.SizeGui);
            end;
        end);
        local v76 = u4.NewButton(u52.Contents.Right.LikeContainer.Purchase);
        local v77 = u4.NewButton(u52.Contents.Right.CommentScrollContainer.CommentButton.Purchaser);
        local v78 = u4.NewButton(u52.Contents.Right.CommentScrollContainer.CommentComposer.Exit);
        local v79 = u4.NewButton(u52.Contents.Right.CommentScrollContainer.CommentComposer.Send);
        v76.Activated:Connect(function() --[[ Line: 407 ]]
            -- upvalues: u52 (copy), u11 (ref)
            u52.Contents.Right.LikeContainer.Visible = false;
            u11:Fire(u52.Player);
        end);
        v77.Activated:Connect(function() --[[ Line: 413 ]]
            -- upvalues: u52 (copy)
            u52.Contents.Right.CommentScrollContainer.CommentButton.Visible = false;
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Visible = true;
        end);
        v78.Activated:Connect(function() --[[ Line: 418 ]]
            -- upvalues: u52 (copy)
            u52.Contents.Right.CommentScrollContainer.CommentButton.Visible = true;
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Visible = false;
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Comment.TextBox.Text = "";
        end);
        v79.Activated:Connect(function() --[[ Line: 424 ]]
            -- upvalues: u52 (copy), u10 (ref)
            u52.Contents.Right.CommentScrollContainer.CommentButton.Visible = true;
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Visible = false;
            u10:Fire(u52.Player, u52.Contents.Right.CommentScrollContainer.CommentComposer.Comment.TextBox.Text);
            u52.Contents.Right.CommentScrollContainer.CommentComposer.Comment.TextBox.Text = "";
        end);
        u52.Maid:Add(v76);
        u52.Maid:Add(v77);
        u52.Maid:Add(v78);
        u52.Maid:Add(v79);
        local v80 = u4.ScaleTextPercentageTextScaled(u52.Contents.Left.StatusContainer.Time, 0.1);
        local v81, v82 = u4.AutoSizeScrollingFrame(u52.Contents.Right.CommentScrollContainer, { "Y" });
        for _, v83 in v82 do
            u52.Maid:Add(v83);
        end;
        u52.Maid:Add(v80);
        u52.SizeGui = v81;
    end;
end;
function u32.OptionsFor(p84, p85) --[[ Line: 451 ]]
    -- upvalues: u20 (copy), l__LocalPlayer__10 (copy), l__Mince__5 (copy)
    local l__OptionsPanel__14 = u20.Interface.TweenFrame.Parent.OptionsPanel;
    local v86 = p85.CommentData.CommentorID == l__LocalPlayer__10.UserId;
    local v87 = l__Mince__5.Config.CommandPermissions:HasPermission(l__LocalPlayer__10, "BanPlayerNotes");
    l__OptionsPanel__14.List.Delete.Visible = p84.IsLocal or (v86 or v87);
    if u20.ActiveOptionsPageOpen == p85.Interface then
        l__OptionsPanel__14.Visible = false;
        u20.SelectedComment = nil;
        u20.ActiveOptionsPageOpen = nil;
    else
        p84.SelectedComment = p85;
        u20.ActiveOptionsPageOpen = p85.Interface;
        local v88 = p85.Interface.Options.AbsolutePosition + p85.Interface.Options.AbsoluteSize;
        l__OptionsPanel__14.Position = UDim2.fromOffset(v88.X, v88.Y);
        l__OptionsPanel__14.Visible = true;
    end;
end;
function u32.FetchNewestPageData(u89) --[[ Line: 477 ]]
    -- upvalues: u6 (copy)
    task.defer(function() --[[ Line: 478 ]]
        -- upvalues: u89 (copy), u6 (ref)
        u89.ProfileMeta:Resolve(u6:Invoke(u89.Player));
    end);
    task.defer(function() --[[ Line: 481 ]]
        -- upvalues: u89 (copy), u6 (ref)
        u89.ProfileComments:Resolve(u6:Invoke(u89.Player, "Comments"));
    end);
end;
function u32.SetVisible(p90, p91) --[[ Line: 486 ]]
    if p90.GUI then
        p90.GUI.Visible = p91;
    else
        warn((`Attempt to setVisible on profile that isn't create yet {p90.Player.Name}`));
    end;
end;
function u20.SetFontColor(_, p92, p93) --[[ Line: 494 ]]
    -- upvalues: u20 (copy), u15 (copy)
    for _, v94 in (p93 or u20.Interface.TweenFrame):GetDescendants() do
        if table.find(u15, v94.Name) then
            if v94:IsA("TextLabel") or v94:IsA("TextButton") then
                v94.TextColor3 = p92;
            elseif v94:IsA("ImageLabel") or v94:IsA("ImageButton") then
                v94.ImageColor3 = p92;
            elseif v94:IsA("UIStroke") then
                v94.Color = p92;
            end;
        end;
    end;
end;
function u20.SetFontFamily(_, p95, p96) --[[ Line: 512 ]]
    -- upvalues: u20 (copy), u15 (copy)
    local v97 = p95:gsub(" ", "");
    local v98 = Font.fromName(v97);
    if v98.Family == Enum.Font.Unknown then
        v98 = Font.fromName("Montserrat");
    end;
    for _, v99 in (p96 or u20.Interface.TweenFrame):GetDescendants() do
        if table.find(u15, v99.Name) and (v99:IsA("TextLabel") or v99:IsA("TextButton")) then
            if v99.FontFace.Bold then
                v98.Bold = true;
            else
                v98.Bold = false;
            end;
            v99.FontFace = v98;
        end;
    end;
end;
function u20.ShouldLocalUGCBeUnlocked(_) --[[ Line: 540 ]]
    -- upvalues: u2 (copy), l__Unify__6 (copy), u20 (copy), l__Mince__5 (copy)
    u2:WaitUntilLoaded();
    local v100 = l__Unify__6.GetStandardTimeFrom(u20.JoinedOn);
    return math.floor(l__Mince__5.Config.LocalProfile.TotalPlayTime + v100) > u20.SecondsToUnlockProfile;
end;
function u20.PreviewPage(_, u101) --[[ Line: 548 ]]
    -- upvalues: l__Players__3 (copy), u20 (copy), l__LocalPlayer__10 (copy), u32 (copy)
    if not u101:IsDescendantOf(l__Players__3) then
        error("Player has left and cannot be previewed!");
    end;
    if not u20.SettingsIsReady then
        u20.SettingsReady:Wait();
    end;
    u20.SwitchPageMutex:within(function() --[[ Line: 557 ]]
        -- upvalues: u101 (copy), l__LocalPlayer__10 (ref), u20 (ref), u32 (ref)
        local v102 = u101 == l__LocalPlayer__10;
        local v103 = u20.PagesByPlayer[u101];
        if not v103 then
            u20.LoadingFrame.Visible = true;
            u20.LoadingTween:Play();
            v103 = u32.new(u101, v102);
            u20.PagesByPlayer[u101] = v103;
        end;
        v103:FetchNewestPageData();
        u20.CurrentProfilePage = v103;
        for v104, v105 in u20.PagesByPlayer do
            v105:SetVisible(v104 == u101);
        end;
        if u20.LastPage then
            local _ = u20.FoldLastGUI;
        end;
        u20.LastPage = v103;
        u20.Options.Settings.Visible = v102;
        u20.Interface.Open();
        u20.LoadingTween:Pause();
    end);
end;
function u20.OpenFor(p106) --[[ Line: 592 ]]
    -- upvalues: u20 (copy)
    u20:PreviewPage(p106);
end;
function u20.SetupSetingsInterface() --[[ Line: 598 ]]
    -- upvalues: u6 (copy), l__LocalPlayer__10 (copy), u20 (copy)
    u20.LocalSettings = u6:Invoke(l__LocalPlayer__10, "Settings").Settings;
    for _, v107 in u20.Settings.Contents.ScrollFrame.CommentScrollContainer:GetChildren() do
        local v108 = v107:GetAttribute("SettingType");
        if v108 and v107:GetAttribute("SettingName") then
            if v108 == "Toggle" then
                u20.SetupToggleSetting(v107);
            elseif v108 == "Input" then
                u20.SetupInputSetting(v107);
            elseif v108 == "ColorPicker" then
                u20.SetupColorInputSetting(v107);
            elseif v108 == "DropDown" then
                u20.SetupDropDownSetting(v107);
            end;
        end;
    end;
    u20.SettingsIsReady = true;
    u20.SettingsReady:Fire();
end;
function u20.SetupColorInputSetting(p109) --[[ Line: 625 ]]
    -- upvalues: u20 (copy), u4 (copy)
    local u110 = p109:GetAttribute("SettingName");
    local u111 = u20.LocalSettings[u110];
    if u111 == nil then
    else
        local v112, v113, v114 = unpack(u111:split(","));
        print(v112, v113, v114);
        local v115 = Color3.fromRGB(v112, v113, v114);
        if u110 == "BackgroundColor" then
            u20.Interface.TweenFrame.BackgroundColor3 = v115;
        elseif u110 == "FontColor" then
            u20:SetFontColor(v115);
        end;
        u4.NewButton(p109.Button).Activated:Connect(function() --[[ Line: 642 ]]
            -- upvalues: u20 (ref), u110 (copy), u111 (copy)
            if u20.ColorPicking then
            else
                u20.ColorPicking = true;
                u20.ColorPickerPanel.Visible = true;
                u20.Coloring = u110;
                local v116, v117 = u20.OnColorChange:Wait();
                if v116 and v117 then
                    local v118 = `{v117.R * 255},{v117.G * 255},{v117.B * 255}`;
                    print(v118);
                    u20.LocalSettings[u110] = v118;
                    if u20.Coloring == "BackgroundColor" then
                        u20.Interface.TweenFrame.BackgroundColor3 = v117;
                    elseif u20.Coloring == "FontColor" then
                        u20:SetFontColor(v117);
                    end;
                    print("got color!");
                else
                    local _ = u20.LocalSettings[u110];
                    local v119, v120, v121 = unpack(u111:split(","));
                    local v122 = Color3.fromRGB(v119, v120, v121);
                    if u20.Coloring == "BackgroundColor" then
                        u20.Interface.TweenFrame.BackgroundColor3 = v122;
                    elseif u20.Coloring == "FontColor" then
                        u20:SetFontColor(v122);
                    end;
                end;
                u20.ColorPickerPanel.Visible = false;
                u20.ColorPicking = false;
            end;
        end);
    end;
end;
function u20.SetupDropDownSetting(u123) --[[ Line: 688 ]]
    -- upvalues: u20 (copy), u16 (copy), u4 (copy)
    local u124 = u123:GetAttribute("SettingName");
    local v125 = u20.LocalSettings[u124];
    if v125 == nil then
    else
        u123.Button.Text = v125;
        u20:SetFontFamily(v125);
        local l__DropdownList__15 = u123.DropdownList;
        local l__ButtonTemplate__16 = l__DropdownList__15.Grid.ButtonTemplate;
        for _, u126 in u16 do
            local v127 = u126:gsub(" ", "");
            local v128 = l__ButtonTemplate__16:Clone();
            v128.Text = u126;
            v128.FontFace = Font.fromName(v127);
            v128.Parent = l__DropdownList__15;
            u4.NewButton(v128).Activated:Connect(function() --[[ Line: 706 ]]
                -- upvalues: u20 (ref), u124 (copy), u126 (copy), u123 (copy), l__DropdownList__15 (copy)
                u20.LocalSettings[u124] = u126;
                u123.Button.Text = u126;
                u20:SetFontFamily(u126);
                l__DropdownList__15.Visible = false;
            end);
        end;
        u4.NewButton(u123.Button).Activated:Connect(function() --[[ Line: 714 ]]
            -- upvalues: l__DropdownList__15 (copy)
            l__DropdownList__15.Visible = true;
        end);
    end;
end;
function u20.SetupToggleSetting(u129) --[[ Line: 719 ]]
    -- upvalues: u20 (copy), u14 (copy), u4 (copy)
    local u130 = u129:GetAttribute("SettingName");
    local v131 = u20.LocalSettings[u130];
    if v131 == nil then
    else
        u129.Button.Text = u14[v131];
        u4.NewButton(u129.Button).Activated:Connect(function() --[[ Line: 725 ]]
            -- upvalues: u20 (ref), u130 (copy), u129 (copy), u14 (ref)
            u20.LocalSettings[u130] = not u20.LocalSettings[u130];
            u129.Button.Text = u14[u20.LocalSettings[u130]];
        end);
    end;
end;
function u20.SyncToColor(p132) --[[ Line: 731 ]]
    -- upvalues: u20 (copy)
    u20.CurrentColor = p132;
    u20.ColorHSV = { p132:ToHSV() };
    if u20.Coloring == "BackgroundColor" then
        u20.Interface.TweenFrame.BackgroundColor3 = p132;
    else
        if u20.Coloring == "FontColor" then
            u20:SetFontColor(p132);
        end;
    end;
end;
function u20.SetupInputSetting(u133) --[[ Line: 747 ]]
    -- upvalues: u20 (copy)
    local u134 = u133:GetAttribute("SettingName");
    local l__Visible__17 = u133.Visible;
    if l__Visible__17 then
        l__Visible__17 = u20:ShouldLocalUGCBeUnlocked();
    end;
    u133.Visible = l__Visible__17;
    local v135 = u20.LocalSettings[u134];
    if v135 == nil then
    else
        u133.TextBox.Text = v135;
        local l__Visible__18 = u133.Visible;
        if l__Visible__18 then
            l__Visible__18 = u20:ShouldLocalUGCBeUnlocked();
        end;
        u133.Visible = l__Visible__18;
        u133.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 757 ]]
            -- upvalues: u20 (ref), u134 (copy), u133 (copy)
            u20.LocalSettings[u134] = u133.TextBox.Text;
        end);
        SetCharacterLimit(u133.TextBox, 150);
    end;
end;
function u20.ConstructNewColor(p136) --[[ Line: 764 ]]
    -- upvalues: u20 (copy)
    for v137, v138 in pairs(p136) do
        u20.ColorHSV[v137] = v138;
    end;
    local v139 = Color3.fromHSV(table.unpack(u20.ColorHSV));
    u20.SyncToColor(v139);
end;
function u20.SetupColorPickers(_) --[[ Line: 776 ]]
    -- upvalues: u20 (copy), u4 (copy)
    local l__ColorPicker__19 = u20.Interface.TweenFrame.ColorPicker;
    local v140 = u4.NewSlider(l__ColorPicker__19.ColorPicker.Value, "Y");
    v140.Changed:Connect(function(p141) --[[ Line: 780 ]]
        -- upvalues: u20 (ref)
        u20.ConstructNewColor({
            [3] = 1 - p141
        });
    end);
    local v142 = u4.NewSlidepad(l__ColorPicker__19.ColorPicker.Color);
    v142.Changed:Connect(function(p143) --[[ Line: 787 ]]
        -- upvalues: u20 (ref)
        u20.ConstructNewColor({ p143.X, 1 - p143.Y });
    end);
    u20.Slider = v140;
    u20.Slidepad = v142;
end;
function u20.SetupButtons(_) --[[ Line: 798 ]]
    -- upvalues: u4 (copy), u20 (copy), u5 (copy), l__LocalPlayer__10 (copy), u12 (copy), u3 (copy), u9 (copy), u8 (copy)
    local v144 = u4.NewButton(u20.Options.CloseButton);
    local v145 = u4.NewButton(u20.Options.Settings);
    local v146 = u4.NewButton(u20.Settings.Options.Settings);
    local l__OptionsPanel__20 = u20.Interface.TweenFrame.Parent.OptionsPanel;
    local v147 = u4.NewButton(l__OptionsPanel__20.List.Report);
    local v148 = u4.NewButton(l__OptionsPanel__20.List.Delete);
    local l__ColorPicker__21 = u20.Interface.TweenFrame.ColorPicker;
    u20.ColorPickerPanel = l__ColorPicker__21;
    u4.NewButton(l__ColorPicker__21.Options.CloseButton).Activated:Connect(function() --[[ Line: 812 ]]
        -- upvalues: l__ColorPicker__21 (copy), u20 (ref)
        l__ColorPicker__21.Visible = false;
        u20.OnColorChange:Fire(false);
    end);
    u4.NewButton(l__ColorPicker__21.Options.HexButton).Activated:Connect(function() --[[ Line: 818 ]]
        -- upvalues: l__ColorPicker__21 (copy)
        l__ColorPicker__21.HexInput.Visible = not l__ColorPicker__21.HexInput.Visible;
        l__ColorPicker__21.ColorPicker.Visible = not l__ColorPicker__21.HexInput.Visible;
    end);
    u4.NewButton(l__ColorPicker__21.HexInput.CloseButton).Activated:Connect(function() --[[ Line: 824 ]]
        -- upvalues: l__ColorPicker__21 (copy)
        l__ColorPicker__21.HexInput.Visible = false;
        l__ColorPicker__21.ColorPicker.Visible = true;
    end);
    u4.NewButton(l__ColorPicker__21.HexInput.Import).Activated:Connect(function() --[[ Line: 830 ]]
        -- upvalues: l__ColorPicker__21 (copy), u5 (ref)
        local l__Text__22 = l__ColorPicker__21.HexInput.Code.Text;
        local v149, v150 = pcall(function() --[[ Line: 832 ]]
            -- upvalues: l__Text__22 (copy)
            return Color3.fromHex(l__Text__22);
        end);
        l__ColorPicker__21.HexInput.Visible = false;
        if v149 then
            l__ColorPicker__21.HexInput.Code.Text = "";
            l__ColorPicker__21:SyncToColor(v150);
        else
            u5.Error("Invalid Hex Code!");
        end;
    end);
    u4.NewButton(l__ColorPicker__21.Options.BuyButton).Activated:Connect(function() --[[ Line: 851 ]]
        -- upvalues: u20 (ref)
        u20.OnColorChange:Fire(true, u20.CurrentColor);
    end);
    v145.Activated:Connect(function() --[[ Line: 855 ]]
        -- upvalues: u20 (ref)
        u20.Options.Visible = false;
        u20.Settings.Visible = true;
        for _, v151 in u20.PagesByPlayer do
            v151:SetVisible(false);
        end;
    end);
    v146.Activated:Connect(function() --[[ Line: 865 ]]
        -- upvalues: u20 (ref), l__LocalPlayer__10 (ref), u12 (ref)
        u20.Options.Visible = true;
        u20.ColorPickerPanel.Visible = false;
        u20.Settings.Visible = false;
        u20.ColorPicking = false;
        u20.OnColorChange:Fire(false);
        for v152, v153 in u20.PagesByPlayer do
            v153:SetVisible(l__LocalPlayer__10 == v152);
        end;
        u12:Fire(u20.LocalSettings);
    end);
    v147.Activated:Connect(function() --[[ Line: 882 ]]
        -- upvalues: u3 (ref), l__OptionsPanel__20 (copy), u9 (ref), u20 (ref)
        warn("reprot->?");
        u3.Display("Report this comment? False reports are bannable.", function() --[[ Line: 884 ]]
            -- upvalues: l__OptionsPanel__20 (ref), u9 (ref), u20 (ref)
            l__OptionsPanel__20.Visible = false;
            u9:Fire(u20.CurrentProfilePage.Player, u20.CurrentProfilePage.SelectedComment.ID);
        end);
    end);
    v148.Activated:Connect(function() --[[ Line: 890 ]]
        -- upvalues: u3 (ref), l__OptionsPanel__20 (copy), u8 (ref), u20 (ref)
        warn("Dlete->?");
        u3.Display("Delete this comment?", function() --[[ Line: 892 ]]
            -- upvalues: l__OptionsPanel__20 (ref), u8 (ref), u20 (ref)
            l__OptionsPanel__20.Visible = false;
            u8:Fire(u20.CurrentProfilePage.Player, u20.CurrentProfilePage.SelectedComment.ID);
        end);
    end);
    u20:SetupColorPickers();
    v144.Activated:Connect(u20.Interface.Close);
end;
function u20.Setup(_) --[[ Line: 903 ]]
    -- upvalues: u20 (copy), u4 (copy), l__TweenService__2 (copy), u13 (copy), u1 (copy), l__LocalPlayer__10 (copy), l__Players__3 (copy)
    u20.Interface = u4.Get("PlayerProfileUI");
    u20.Options = u20.Interface.TweenFrame.Options;
    u20.Settings = u20.Interface.TweenFrame.Settings;
    u20.Page = u20.Interface.TweenFrame.Page:Clone();
    u20.LoadingFrame = u20.Interface.TweenFrame.Loading;
    u20.LoadingTween = l__TweenService__2:Create(u20.LoadingFrame.Image, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
        Rotation = 360
    });
    u20.Interface.TweenFrame.Page:Destroy();
    task.spawn(u20.SetupButtons);
    task.spawn(u20.SetupSetingsInterface);
    u20.Interface.Closed:Connect(function() --[[ Line: 920 ]]
        -- upvalues: u20 (ref)
        u20.Interface.TweenFrame.Parent.OptionsPanel.Visible = false;
    end);
    u13.Event:Connect(function(p154, p155) --[[ Line: 924 ]]
        -- upvalues: u20 (ref)
        local v156 = u20.PagesByPlayer[p154];
        if v156 then
            v156:PartialReflect(p155);
        end;
    end);
    u1.SettingChanged("LocalProfile"):Connect(function(p157) --[[ Line: 931 ]]
        -- upvalues: u20 (ref), l__LocalPlayer__10 (ref), u1 (ref)
        if p157 then
            u20:PreviewPage(l__LocalPlayer__10);
            u1.ChangeSetting("LocalProfile", false);
        end;
    end);
    l__Players__3.PlayerRemoving:Connect(function(p158) --[[ Line: 938 ]]
        -- upvalues: u20 (ref)
        local v159 = u20.PagesByPlayer[p158];
        if v159 then
            v159:Destroy();
            u20.PagesByPlayer[p158] = nil;
        end;
    end);
end;
return u20;
