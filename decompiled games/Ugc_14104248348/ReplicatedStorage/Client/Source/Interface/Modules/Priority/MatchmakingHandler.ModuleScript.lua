-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Priority.MatchmakingHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
local l__LocalPlayer__4 = l__Players__3.LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__6 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__Utility__7 = require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = l__Mince__5:Get("AOp");
local u2 = l__Mince__5:Get("Notices");
local u3 = l__Mince__5:Get("UserProfile");
local u4 = l__Mince__5:Get("ConfirmPrompt");
local u5 = l__Mince__5:Get("TriggerHandler");
local u6 = l__Mince__5:Get("InterfaceHandler");
l__Mince__5:Get("RobloxAPIHandler");
local v7 = l__Mince__5:GetEvent("Parties");
local u8 = v7:Extend("Submit");
local u9 = v7:Extend("Leave");
local u10 = v7:Extend("Join");
local u11 = v7:Extend("KickPlayer");
local u12 = v7:Extend("Subscribe");
local u13 = l__Mince__5:GetEvent("AskToReturn");
local u14 = l__Mince__5:GetEvent("SubmitBioInfo");
local u15 = l__Mince__5:GetEvent("GivePartyInfo");
local u16 = l__Mince__5:GetEvent("UpdateMatchPreferences");
local u17 = l__Mince__5:GetEvent("AskPlayerToStartExiting");
local u18 = l__Mince__5:GetEvent("ReplicateMatchmakingState");
local u19 = l__Mince__5:GetState("Matchmaking");
local u20 = l__Mince__5:GetFunction("UpdateMatchStatus");
local u21 = {
    ForceDisabled = false,
    PlayerInParty = false,
    PlayerDetectedInParty = false,
    IsCurrentlyMatching = false,
    TimeMatching = 0,
    __IsAsyncSetup = true,
    MatchmakingHandlerObjects = {},
    ProgressTween = TweenInfo.new(0.3),
    OpenTween = TweenInfo.new(0.3, Enum.EasingStyle.Back),
    ValidMatchAmounts = { 2, 3 },
    PrivacyButton = {
        Position = 1,
        Selected = "Public",
        Options = { "Public", "Friends" }
    },
    CurrentLoadedParties = {}
};
function u21.Update(p22) --[[ Line: 67 ]]
    -- upvalues: u21 (copy), l__Unify__6 (copy)
    if u21.IsCurrentlyMatching then
        local v23 = u21;
        v23.TimeMatching = v23.TimeMatching + p22;
    end;
    if u21.PlayerInParty then
        u21.EnabledButtons(u21.Party.LocalPlayerOwns);
    end;
    u21.Matching.MatchMaking.Time.Text = l__Unify__6.ShortenedClockTime(u21.TimeMatching);
end;
function u21.ReactToStateChange(p24) --[[ Line: 80 ]]
    -- upvalues: u21 (copy)
    u21.Matching.MatchMaking.Bottom.Text = `{p24} players recently matched.`;
end;
function u21.UpdateToMatchChange() --[[ Line: 84 ]]
    -- upvalues: u21 (copy), u6 (copy), u19 (copy)
    if u21.IsCurrentlyMatching then
        u6.ColorButton(u21.Matching.MatchMaking.MatchButton, Color3.new(0.839216, 0, 0));
        u21.Matching.MatchMaking.Status.Text = "Finding";
        u21.Matching.MatchMaking.MatchButton.Text = "Stop";
    else
        u6.ColorButton(u21.Matching.MatchMaking.MatchButton, Color3.new(0, 0.831373, 0));
        u21.Matching.MatchMaking.Status.Text = "Waiting";
        u21.Matching.MatchMaking.MatchButton.Text = "Start";
        u21.TimeMatching = 0;
    end;
    if u19.Disabled then
        if u21.IsCurrentlyMatching then
            u21.Matching.ReturnGame.Visible = false;
            u21.Matching.MatchMaking.Visible = true;
            u21.TimeMatching = 0;
            return;
        end;
        u21.Matching.ReturnGame.Visible = true;
        u21.Matching.MatchMaking.Visible = false;
        u21.TimeMatching = 0;
    end;
end;
function u21.ReturnToLobby() --[[ Line: 110 ]]
    -- upvalues: u21 (copy), u13 (copy)
    u21.Matching.ReturnGame.Visible = false;
    u13:Fire();
    u21.Matching.MatchMaking.MatchButton.Visible = false;
    u21.Matching.MatchMaking.PlaceName.Visible = false;
    u21.SetActualStatus("Returning");
end;
function u21.FindANewMatch() --[[ Line: 118 ]]
    -- upvalues: u21 (copy), u1 (copy), u20 (copy), u2 (copy)
    u21.Matching.MatchMaking.MatchButton.Visible = true;
    u21.Matching.MatchMaking.PlaceName.Visible = true;
    u21.Matching.ReturnGame.Visible = false;
    u21.Matching.MatchMaking.Visible = true;
    local v25, v26 = u1.Do(function() --[[ Line: 123 ]]
        -- upvalues: u20 (ref)
        return u20:Invoke(true);
    end);
    if v25 and v26 ~= nil then
        u21.IsCurrentlyMatching = v26;
        u21.UpdateToMatchChange();
    elseif v26 == nil then
    else
        u2.Error(v26);
    end;
end;
function u21.CreateParty(u27, u28) --[[ Line: 137 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Players__3 (copy), l__ReplicatedStorage__1 (copy), u21 (copy), u6 (copy), u9 (copy), u10 (copy), u11 (copy)
    local u31 = {
        Events = {},
        SavedProfilePictures = {},
        ProfileItems = {},
        RawData = u27,
        IsLocalPlayerAMember = function(p29) --[[ Name: IsLocalPlayerAMember, Line 145 ]]
            -- upvalues: l__LocalPlayer__4 (ref)
            for _, v30 in p29.RawData.Players do
                if v30 == l__LocalPlayer__4.UserId then
                    return true;
                end;
            end;
            return false;
        end
    };
    function u31.InitUI(p32) --[[ Line: 153 ]]
        -- upvalues: u31 (copy), u27 (copy), l__LocalPlayer__4 (ref), l__Players__3 (ref), l__ReplicatedStorage__1 (ref), u21 (ref), u6 (ref), u9 (ref), u10 (ref), u28 (copy)
        u31.LocalPlayerOwns = u27.OwnerID == l__LocalPlayer__4.UserId;
        u31.OwnerPlayer = l__Players__3:GetPlayerByUserId(u27.OwnerID);
        u31.UI = l__ReplicatedStorage__1.Assets.Interface.PartyItem:Clone();
        u31.UI.Parent = u21.Matching.Parties.Viewer.Scroll;
        u31.UI.Info.PartyName.Text = u27.Meta.PartyName;
        u6.NewButton(u31.UI.Info.Options.LeaveButton).Activated:Connect(function() --[[ Line: 162 ]]
            -- upvalues: u9 (ref)
            u9:Fire();
        end);
        u6.NewButton(u31.UI.Info.Options.JoinButton).Activated:Connect(function() --[[ Line: 167 ]]
            -- upvalues: u10 (ref), u27 (ref)
            u10:Fire(u27.ID);
        end);
        p32:UpdateData(p32.RawData, u28);
    end;
    function u31.UpdatePlayers(p33) --[[ Line: 174 ]]
        -- upvalues: u31 (copy), l__ReplicatedStorage__1 (ref), u6 (ref), u11 (ref), l__Players__3 (ref)
        for _, v34 in u31.ProfileItems do
            v34:Destroy();
        end;
        u31.ProfileItems = {};
        for v35, u36 in p33.RawData.Players do
            local u37 = l__ReplicatedStorage__1.Assets.Interface.ProfileItem:Clone();
            u37.Parent = u31.UI.Players;
            if u31.LocalPlayerOwns then
                u6.NewButton(u37).Activated:Connect(function() --[[ Line: 186 ]]
                    -- upvalues: u11 (ref), u36 (copy)
                    u11:Fire(u36);
                end);
            end;
            if u36 == p33.RawData.OwnerID then
                u37.LayoutOrder = -1;
                u37.UIStroke.Color = Color3.new(1, 0.709804, 0.0313725);
            else
                u37.LayoutOrder = v35;
            end;
            local function v38() --[[ Line: 198 ]]
                -- upvalues: l__Players__3 (ref), u36 (copy), u37 (copy)
                u37.Image = l__Players__3:GetUserThumbnailAsync(u36, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
            end;
            table.insert(u31.ProfileItems, u37);
            task.spawn(v38);
        end;
    end;
    function u31.UpdateData(p39, p40, p41) --[[ Line: 208 ]]
        -- upvalues: u31 (copy), l__LocalPlayer__4 (ref), l__Players__3 (ref)
        p39.RawData = p40;
        u31.LocalPlayerOwns = p40.OwnerID == l__LocalPlayer__4.UserId;
        u31.OwnerPlayer = l__Players__3:GetPlayerByUserId(p40.OwnerID);
        u31.UI.Info.Capacity.Text = `{#p40.Players}/{p40.Capacity}`;
        u31.UI.Info.Options.Locked.Visible = false;
        u31.UI.Info.Options.JoinButton.Visible = false;
        u31.UI.Info.Options.LeaveButton.Visible = false;
        u31.UI.Info.Options.Searching.Visible = p40.Meta.IsSearching;
        if p39:IsLocalPlayerAMember() then
            u31.UI.LayoutOrder = -1;
            u31.UI.Info.Options.LeaveButton.Visible = true;
        else
            if p40.Meta.Privacy == "Public" then
                u31.UI.Info.Options.JoinButton.Visible = true;
            elseif p40.Meta.Privacy == "Friends" and not u31.LocalPlayerOwns then
                if u31.OwnerPlayer and l__LocalPlayer__4:IsFriendsWith(u31.OwnerPlayer.UserId) then
                    u31.UI.Info.Options.JoinButton.Visible = true;
                else
                    u31.UI.Info.Options.Locked.Visible = true;
                end;
            else
                u31.UI.Info.Options.Locked.Visible = true;
            end;
            u31.UI.LayoutOrder = p41;
            u31.UI.Info.Options.LeaveButton.Visible = false;
        end;
        p39:UpdatePlayers();
    end;
    function u31.Destroy(_) --[[ Line: 246 ]]
        -- upvalues: u31 (copy), u21 (ref), u27 (copy)
        for _, v42 in u31.Events do
            v42:Disconnect();
        end;
        u31.UI:Destroy();
        u21.CurrentLoadedParties[u27.ID] = nil;
    end;
    u31:InitUI();
    u21.CurrentLoadedParties[u27.ID] = u31;
    return u31;
end;
function u21.UpdateNewRecipes(p43) --[[ Line: 259 ]]
    -- upvalues: u21 (copy), l__Utility__7 (copy)
    u21.PlayerDetectedInParty = false;
    local v44 = {};
    local v45 = 0;
    for v46, v47 in pairs(p43) do
        local v48 = u21.CurrentLoadedParties[v47.ID];
        if v48 == nil then
            v48 = u21.CreateParty(v47, v46);
        elseif not l__Utility__7.TableEq(v47, v48.RawData or {}) then
            v48:UpdateData(v47);
        end;
        if v48:IsLocalPlayerAMember() then
            u21.PlayerDetectedInParty = true;
            u21.Party = v48;
        end;
        v44[v47.ID] = true;
        v45 = v45 + 1;
    end;
    for v49, v50 in pairs(u21.CurrentLoadedParties) do
        if not v44[v49] then
            v50:Destroy();
        end;
    end;
    u21.PlayerInParty = u21.PlayerDetectedInParty;
    if u21.PlayerInParty then
        u21.EnabledButtons(u21.Party.LocalPlayerOwns);
        if not u21.Party.LocalPlayerOwns then
            u21.IsCurrentlyMatching = u21.Party.RawData.Meta.IsSearching;
            u21.UpdateToMatchChange();
        end;
    else
        u21.EnabledButtons(true);
    end;
end;
function u21.EnabledButtons(p51) --[[ Line: 305 ]]
    -- upvalues: u21 (copy)
    u21.Matching.MatchMaking.MatchButton.Visible = p51;
    u21.Matching.MatchMaking.PlaceName.Visible = p51;
end;
function u21.SetupPartyStuff() --[[ Line: 310 ]]
    -- upvalues: u21 (copy), u6 (copy), u2 (copy), u8 (copy)
    local l__Parties__8 = u21.Matching.Parties;
    local v52 = u6.NewButton(l__Parties__8.Creator.CreateButton);
    local v53 = u6.NewButton(l__Parties__8.Viewer.CreateButton);
    local v54 = u6.NewButton(l__Parties__8.Creator.BackButton);
    v53.Activated:Connect(function() --[[ Line: 316 ]]
        -- upvalues: u21 (ref), l__Parties__8 (copy)
        u21.Matching.Parties.Viewer.Visible = false;
        u21.Matching.Parties.Creator.Visible = true;
        l__Parties__8.Creator.PartyName.Text = "";
        u21.PrivacyButton.Position = 2;
        u21.PrivacyButton.Selected = u21.PrivacyButton.Options[u21.PrivacyButton.Position];
        l__Parties__8.Creator.PartyButton.Text = u21.PrivacyButton.Selected;
    end);
    v54.Activated:Connect(function() --[[ Line: 326 ]]
        -- upvalues: u21 (ref)
        u21.Matching.Parties.Viewer.Visible = true;
        u21.Matching.Parties.Creator.Visible = false;
    end);
    u6.NewButton(l__Parties__8.Creator.PartyButton).Activated:Connect(function() --[[ Line: 333 ]]
        -- upvalues: u21 (ref), l__Parties__8 (copy)
        local l__PrivacyButton__9 = u21.PrivacyButton;
        l__PrivacyButton__9.Position = l__PrivacyButton__9.Position + 1;
        if u21.PrivacyButton.Position > #u21.PrivacyButton.Options then
            u21.PrivacyButton.Position = 1;
        end;
        u21.PrivacyButton.Selected = u21.PrivacyButton.Options[u21.PrivacyButton.Position];
        l__Parties__8.Creator.PartyButton.Text = u21.PrivacyButton.Selected;
    end);
    l__Parties__8.Creator.PartyName:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 340 ]]
        -- upvalues: l__Parties__8 (copy)
        l__Parties__8.Creator.PartyName.Text = l__Parties__8.Creator.PartyName.Text:sub(1, 30);
    end);
    v52.Activated:Connect(function() --[[ Line: 344 ]]
        -- upvalues: l__Parties__8 (copy), u2 (ref), u21 (ref), u8 (ref)
        local l__Text__10 = l__Parties__8.Creator.PartyName.Text;
        if l__Text__10 and l__Text__10 ~= "" then
            u21.Matching.Parties.Viewer.Visible = true;
            u21.Matching.Parties.Creator.Visible = false;
            u8:Fire(l__Text__10, u21.PrivacyButton.Selected);
        else
            u2.Error("Party name cannot be empty!");
        end;
    end);
end;
function u21.SetupButtons() --[[ Line: 357 ]]
    -- upvalues: u6 (copy), u21 (copy), u1 (copy), u20 (copy), u2 (copy), u14 (copy), u16 (copy)
    local v55 = u6.NewButton(u21.Matching.ReturnGame.ReturnButton);
    local v56 = u6.NewButton(u21.Matching.ReturnGame.FindButton);
    v55.Activated:Connect(u21.ReturnToLobby);
    v56.Activated:Connect(u21.FindANewMatch);
    local l__Options__11 = u21.Matching.MatchMaking.Options;
    local v57 = u6.NewButton(u21.Matching.Profile.CloseButton);
    local v58 = u6.NewButton(u21.Matching.Parties.CloseButton);
    local v59 = u6.NewButton(l__Options__11.OpenProfile);
    local v60 = u6.NewButton(l__Options__11.OpenParties);
    local v61 = u6.NewButton(u21.Matching.MatchMaking.MatchButton);
    local v62 = u6.NewButton(u21.Matching.BioFrame.CloseButton);
    v58.Activated:Connect(function() --[[ Line: 376 ]]
        -- upvalues: u21 (ref)
        u21.Parties.Close();
    end);
    v57.Activated:Connect(function() --[[ Line: 380 ]]
        -- upvalues: u21 (ref)
        u21.Profile.Close();
    end);
    v60.Activated:Connect(function() --[[ Line: 384 ]]
        -- upvalues: u21 (ref)
        u21.Parties.Trigger();
    end);
    v59.Activated:Connect(function() --[[ Line: 388 ]]
        -- upvalues: u21 (ref)
        u21.Profile.Trigger();
    end);
    v62.Activated:Connect(function() --[[ Line: 392 ]]
        -- upvalues: u21 (ref)
        u21.Matching.BioFrame.Visible = false;
    end);
    v61.Activated:Connect(function() --[[ Line: 396 ]]
        -- upvalues: u1 (ref), u20 (ref), u2 (ref), u21 (ref)
        local v63, v64 = u1.Do(function() --[[ Line: 397 ]]
            -- upvalues: u20 (ref)
            return u20:Invoke();
        end);
        if v63 and v64 ~= nil then
            u21.IsCurrentlyMatching = v64;
            u21.UpdateToMatchChange();
        elseif v64 == nil then
        else
            u2.Error(v64);
        end;
    end);
    u21.UpdateToMatchChange();
    u21.Matching.Profile.TextBox.FocusLost:Connect(function() --[[ Line: 416 ]]
        -- upvalues: u21 (ref), u14 (ref)
        u14:Fire(u21.Matching.Profile.TextBox.Text);
    end);
    u6.ScaleTextPercentage(u21.Matching.Profile.TextBox);
    u6.ScaleTextPercentage(u21.Matching.BioFrame.BioText);
    for _, u65 in u21.ValidMatchAmounts do
        local v66 = u21.Matching.MatchMaking.PlayerFrame:WaitForChild(u65);
        if v66 then
            u6.NewButton(v66).Activated:Connect(function() --[[ Line: 430 ]]
                -- upvalues: u16 (ref), u65 (copy)
                u16:Fire(u65);
            end);
        end;
    end;
end;
function u21.SyncButtons(p67) --[[ Line: 436 ]]
    -- upvalues: u21 (copy)
    for v68, v69 in p67 do
        local v70 = u21.Matching.MatchMaking.PlayerFrame:WaitForChild(v68);
        if v70 then
            if v69 then
                v70.BackgroundColor3 = Color3.new(0.870588, 0.843137, 0.815686);
                v70.TextLabel.TextColor3 = Color3.new(0, 0, 0);
                v70.UIStroke.Color = Color3.new(1, 1, 1);
            else
                v70.BackgroundColor3 = Color3.new(0.121569, 0.117647, 0.113725);
                v70.TextLabel.TextColor3 = Color3.new(1, 1, 1);
                v70.UIStroke.Color = Color3.new(0, 0, 0);
            end;
        end;
    end;
end;
function u21.SetupUI() --[[ Line: 453 ]]
    -- upvalues: u19 (copy), u21 (copy)
    if u19.Disabled then
        u21.Matching.ReturnGame.Visible = true;
        u21.Matching.MatchMaking.Visible = false;
    end;
end;
function u21.SetActualStatus(p71) --[[ Line: 460 ]]
    -- upvalues: u21 (copy)
    u21.Matching.MatchMaking.Visible = true;
    u21.Matching.MatchMaking.Status.Text = p71;
end;
function u21.SetStatus(p72) --[[ Line: 465 ]]
    -- upvalues: u21 (copy)
    u21.Matching.Profile.TextBox.Text = p72;
end;
function u21.SetupMatchStuffs() --[[ Line: 469 ]]
    -- upvalues: u21 (copy), u17 (copy), u4 (copy)
    local l__ReturnToLobby__12 = u21.ReturnToLobby;
    local l__FindANewMatch__13 = u21.FindANewMatch;
    u17.Event:Connect(function() --[[ Line: 471 ]]
        -- upvalues: u21 (ref), u4 (ref), l__ReturnToLobby__12 (copy), l__FindANewMatch__13 (copy)
        u21.Matching.ReturnGame.Visible = false;
        u4.Display("Your match has left! Would you like to return to lobby or find another match?", l__ReturnToLobby__12, l__FindANewMatch__13, { "Return", "Find" });
    end);
    u21.Matching.MatchMaking.Options.Visible = false;
    u21.Matching.MatchMaking.PlayerFrame.Visible = false;
end;
function u21.Setup() --[[ Line: 481 ]]
    -- upvalues: u21 (copy), u6 (copy), u12 (copy), u19 (copy), u5 (copy), u20 (copy), u15 (copy), u3 (copy), u18 (copy), l__RunService__2 (copy)
    u21.Matching = u6.GetScreenGui("Matching");
    u21.Profile = u6.Get("Matching", "Profile");
    u21.Parties = u6.Get("Matching", "Parties");
    u21.Parties.Opened:Connect(function() --[[ Line: 486 ]]
        -- upvalues: u12 (ref)
        u12:Fire(true);
    end);
    u21.Parties.Closed:Connect(function() --[[ Line: 490 ]]
        -- upvalues: u12 (ref)
        u12:Fire(false);
    end);
    u21.SetupButtons();
    u21.SetupUI();
    u21.SetupPartyStuff();
    if u19.Disabled then
        u21.SetupMatchStuffs();
    end;
    u21.Trigger = u5.GetTrigger("MatchMaking");
    u21.Trigger.Entered:Connect(function() --[[ Line: 501 ]]
        -- upvalues: u19 (ref), u21 (ref), u12 (ref)
        if u19.Disabled or u21.ForceDisabled then
        else
            u12:Fire(true);
            u21.Matching.MatchMaking.Visible = true;
        end;
    end);
    u21.Trigger.Leaved:Connect(function() --[[ Line: 507 ]]
        -- upvalues: u19 (ref), u21 (ref), u12 (ref), u20 (ref)
        if u19.Disabled or u21.ForceDisabled then
        else
            u12:Fire(false);
            local v73 = u20:Invoke(false);
            if v73 ~= nil then
                u21.IsCurrentlyMatching = v73;
                u21.UpdateToMatchChange();
            end;
            u21.Matching.MatchMaking.Visible = false;
        end;
    end);
    u15.Event:Connect(u21.UpdateNewRecipes);
    u3.IndexUpdated("UserBio"):Connect(u21.SetStatus);
    u3.IndexUpdated("MatchPreferences"):Connect(u21.SyncButtons);
    u21.ReactToStateChange(u19.RecentlyMatched or 0);
    u19("IndexChanged", "RecentlyMatched"):Connect(function(p74) --[[ Line: 525 ]]
        -- upvalues: u21 (ref)
        u21.ReactToStateChange(p74);
    end);
    u18.Event:Connect(u21.SetActualStatus);
    l__RunService__2.Heartbeat:Connect(function(p75) --[[ Line: 531 ]]
        -- upvalues: u21 (ref)
        u21.Update(p75);
    end);
end;
return u21;
