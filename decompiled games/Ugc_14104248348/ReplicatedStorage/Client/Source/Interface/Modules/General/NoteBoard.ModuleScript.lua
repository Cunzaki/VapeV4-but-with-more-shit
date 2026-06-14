-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.NoteBoard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Queue__3 = require(l__ReplicatedStorage__1.Modules.Queue);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__5 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__Dropdown__6 = require(l__ReplicatedStorage__1.Modules.Dropdown);
local u1 = l__Queue__3.new();
u1.Step = 0.05;
u1:RunPushedFunctions();
local u2 = l__Mince__4:Get("AOp");
local u3 = l__Mince__4:Get("Notices");
l__Mince__4:Get("Filtertext");
local u4 = l__Mince__4:Get("UserProfile");
local u5 = l__Mince__4:Get("ConfirmPrompt");
local u6 = l__Mince__4:Get("InterfaceHandler");
local u7 = l__Mince__4:GetState("NotesManager");
local u8 = l__Mince__4:GetFunction("GetNotes");
local u9 = l__Mince__4:GetFunction("VoteNote");
local u10 = l__Mince__4:GetFunction("CreateNote");
local u11 = l__Mince__4:GetFunction("DeleteNote");
local u12 = l__Mince__4:GetFunction("BanPlayerFromNote");
local u13 = {
    __IsAsyncSetup = true,
    SortOptions = {
        "Newest",
        "Oldest",
        "HighestVoted",
        "LowestVoted"
    },
    NoteItems = {},
    PlayerDataCachce = {}
};
function u13.TravelLastPage() --[[ Line: 45 ]]
    -- upvalues: u13 (copy), u3 (copy)
    if u13.SearchOptions then
        if u13.SearchOptions.ProcessingPageTraversal then
            warn("processingtraverasla");
        elseif u13.SearchOptions.CurrentPage <= 1 then
            u13.SearchOptions.CurrentPage = 1;
        elseif u13.SearchOptions.NoteData[u13.SearchOptions.CurrentPage - 1] then
            u13.SearchOptions.ProcessingPageTraversal = true;
            local l__SearchOptions__7 = u13.SearchOptions;
            l__SearchOptions__7.CurrentPage = l__SearchOptions__7.CurrentPage - 1;
            u13.SearchOptions.CurrentNoteData = u13.SearchOptions.NoteData[u13.SearchOptions.CurrentPage];
            u13.LoadPage();
        else
            u3.Error("Fatal! PageData missing from memory");
        end;
    else
        u3.Error("You must start a search in-order to travel to the next page");
    end;
end;
function u13.TravelNextPage(p14) --[[ Line: 72 ]]
    -- upvalues: u13 (copy), u3 (copy), u8 (copy), u2 (copy)
    if u13.SearchOptions then
        if u13.SearchOptions.ProcessingPageTraversal then
        elseif u13.SearchOptions.CurrentPage + 1 > u13.SearchOptions.MaxPage then
            u13.SearchOptions.CurrentPage = u13.SearchOptions.MaxPage;
        elseif u13.SearchOptions.NoteData[u13.SearchOptions.CurrentPage + 1] then
            u13.SearchOptions.ProcessingPageTraversal = true;
            local l__SearchOptions__8 = u13.SearchOptions;
            l__SearchOptions__8.CurrentPage = l__SearchOptions__8.CurrentPage + 1;
            u13.SearchOptions.CurrentNoteData = u13.SearchOptions.NoteData[u13.SearchOptions.CurrentPage];
            u13.LoadPage();
        else
            u13.SearchOptions.ProcessingPageTraversal = true;
            local v15, v16;
            if p14 then
                v15, v16 = pcall(function() --[[ Line: 100 ]]
                    -- upvalues: u8 (ref), u13 (ref)
                    return u8:Invoke(u13.SortDropdown.SelectedText, u13.SearchOptions.NextCursor);
                end);
            else
                v15, v16 = u2.Do(function() --[[ Line: 104 ]]
                    -- upvalues: u8 (ref), u13 (ref)
                    return u8:Invoke(u13.SortDropdown.SelectedText, u13.SearchOptions.NextCursor);
                end);
            end;
            if v15 and v16 ~= nil then
                if v16.NextPageCursor or #v16.Notes > 0 then
                    local l__SearchOptions__9 = u13.SearchOptions;
                    l__SearchOptions__9.CurrentPage = l__SearchOptions__9.CurrentPage + 1;
                    u13.SearchOptions.NextCursor = v16.NextPageCursor;
                    u13.SearchOptions.NoteData[u13.SearchOptions.CurrentPage] = v16.Notes;
                    u13.SearchOptions.CurrentNoteData = u13.SearchOptions.NoteData[u13.SearchOptions.CurrentPage];
                    u13.LoadPage();
                end;
                if not v16.NextPageCursor then
                    u13.SearchOptions.MaxPage = u13.SearchOptions.CurrentPage;
                    u13.SearchOptions.ProcessingPageTraversal = false;
                end;
                u13.UpdatePageBar();
            elseif v16 == nil then
            else
                if p14 then
                    u3.Error(v16);
                end;
                u13.SearchOptions.ProcessingPageTraversal = false;
            end;
        end;
    else
        u3.Error("You must start a search in-order to travel to the next page");
    end;
end;
function u13.StartNewSearch(u17) --[[ Line: 133 ]]
    -- upvalues: u13 (copy)
    if u13.Processing then
    else
        u13.Processing = true;
        u13.SearchOptions = {
            CurrentPage = 0,
            MaxPage = (1 / 0),
            NoteData = {}
        };
        local _, _ = pcall(function() --[[ Line: 143 ]]
            -- upvalues: u13 (ref), u17 (copy)
            return u13.TravelNextPage(u17);
        end);
        u13.Processing = false;
    end;
end;
function u13.UpdatePageBar() --[[ Line: 150 ]]
    -- upvalues: u13 (copy)
    local l__PageBar__10 = u13.Viewer.PageBar;
    l__PageBar__10.LeftArrowButton.Visible = u13.SearchOptions.CurrentPage ~= 1;
    l__PageBar__10.RightArrowButton.Visible = u13.SearchOptions.CurrentPage ~= u13.SearchOptions.MaxPage;
    l__PageBar__10.ShowingAmount.Text = `Page {u13.SearchOptions.CurrentPage}`;
end;
function u13.UpdateNoteItemVoteStatus(p18) --[[ Line: 158 ]]
    -- upvalues: l__Mince__4 (copy)
    p18.UI.Extras.VoteDown.Visible = false;
    p18.UI.Extras.VoteUp.Visible = false;
    if l__Mince__4.Config.LocalProfile and l__Mince__4.Config.LocalProfile.NotesVoted then
        local v19 = l__Mince__4.Config.LocalProfile.NotesVoted[p18.Raw._id];
        p18.UI.Extras.VoteDown.Visible = not v19;
        p18.UI.Extras.VoteUp.Visible = not v19;
    end;
end;
function u13.LoadPage() --[[ Line: 168 ]]
    -- upvalues: u13 (copy), u1 (copy), l__Mince__4 (copy), l__LocalPlayer__2 (copy), l__ReplicatedStorage__1 (copy), u6 (copy), u2 (copy), u9 (copy), u5 (copy), u11 (copy)
    for _, v20 in u13.NoteItems do
        v20.UI:Destroy();
        for _, v21 in v20.Events do
            v21:Disconnect();
        end;
    end;
    u13.NoteItems = {};
    if u13.SearchOptions and u13.SearchOptions.CurrentNoteData then
        u1:Clear();
        for _, u22 in u13.SearchOptions.CurrentNoteData do
            local u23 = {
                Raw = u22,
                Events = {}
            };
            local v24 = l__Mince__4.Config.CommandPermissions:HasPermission(l__LocalPlayer__2, "ManagePlayerDrinks");
            u23.UI = l__ReplicatedStorage__1.Assets.Interface.PlayerNoteItemRedux:Clone();
            u23.UI.Parent = u13.Viewer.StaticPage;
            u23.UI.Info.Note.ImageColor3 = Color3.fromHex(u22.ColorHex or "ffffff");
            u23.UI.Info.Note.MainBody.Text = u22.Message;
            u23.UI.Extras.VoteLabel.Text = u22.Score;
            u6.NewButton(u23.UI.Extras.VoteDown).Activated:Connect(function() --[[ Line: 202 ]]
                -- upvalues: u2 (ref), u9 (ref), u22 (copy), u23 (copy)
                local v25, v26 = u2.Do(function() --[[ Line: 203 ]]
                    -- upvalues: u9 (ref), u22 (ref)
                    return u9:Invoke("Down", u22._id);
                end);
                if v25 and v26 then
                    local l__VoteLabel__11 = u23.UI.Extras.VoteLabel;
                    l__VoteLabel__11.Text = l__VoteLabel__11.Text - 1;
                end;
            end);
            u6.NewButton(u23.UI.Extras.VoteUp).Activated:Connect(function() --[[ Line: 208 ]]
                -- upvalues: u2 (ref), u9 (ref), u22 (copy), u23 (copy)
                local v27, v28 = u2.Do(function() --[[ Line: 209 ]]
                    -- upvalues: u9 (ref), u22 (ref)
                    return u9:Invoke("Up", u22._id);
                end);
                if v27 and v28 then
                    local l__VoteLabel__12 = u23.UI.Extras.VoteLabel;
                    l__VoteLabel__12.Text = l__VoteLabel__12.Text + 1;
                end;
            end);
            u6.NewButton(u23.UI.Extras.Trash).Activated:Connect(function() --[[ Line: 214 ]]
                -- upvalues: u5 (ref), u2 (ref), u11 (ref), u22 (copy)
                u5.Display("Are you sure you want to delete this? You are allowed to delete any if inappropiate.", function() --[[ Line: 215 ]]
                    -- upvalues: u2 (ref), u11 (ref), u22 (ref)
                    u2.Do(function() --[[ Line: 216 ]]
                        -- upvalues: u11 (ref), u22 (ref)
                        return u11:Invoke(u22._id);
                    end);
                end);
            end);
            u6.NewButton(u23.UI.Extras.Ban).Activated:Connect(function() --[[ Line: 221 ]]
                -- upvalues: u5 (ref), u13 (ref), u22 (copy)
                u5.Display("Are you sure you want to ban this player? You can ban people but check with senior first!.", function() --[[ Line: 222 ]]
                    -- upvalues: u13 (ref), u22 (ref)
                    u13.StartBanningOfPlayer(u22.PlayerInfo.ID);
                end);
            end);
            u23.UI.Extras.Ban.Visible = v24;
            u23.UI.Extras.Trash.Visible = v24;
            u23.UI.Info.Thumbnail.Visible = v24;
            u23.UI.Info.HideText.Visible = v24;
            u23.UI.Info.PlayerName.Visible = v24;
            u23.UI.Info.PlayerName.Text = u22.PlayerInfo.Name;
            if v24 then
                task.defer(function() --[[ Line: 235 ]]
                    -- upvalues: u13 (ref), u22 (copy), u23 (copy)
                    local v29 = u13.PlayerDataCachce[u22.PlayerInfo.ID] or game.Players:GetUserThumbnailAsync(u22.PlayerInfo.ID, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size60x60);
                    u13.PlayerDataCachce[u22.PlayerInfo.ID] = v29;
                    u23.UI.Info.Thumbnail.Image = v29;
                end);
            end;
            u13.UpdateNoteItemVoteStatus(u23);
            table.insert(u13.NoteItems, u23);
        end;
        u13.Viewer.Scroll.CanvasPosition = Vector2.new(0, 0);
        u13.SearchOptions.ProcessingPageTraversal = false;
        u13.UpdatePageBar();
    else
        warn("FAILED TO LOAD PAGE DATA!");
        u13.SearchOptions.ProcessingPageTraversal = false;
    end;
end;
function u13.SetupCodes() --[[ Line: 253 ]] end;
function u13.StartBanningOfPlayer(p30) --[[ Line: 257 ]]
    -- upvalues: u13 (copy)
    u13.Viewer.BanWindow.Visible = true;
    u13.Viewer.BanWindow.SecondTime.Text = "";
    u13.BanningPlayer = p30;
end;
function u13.RespondToOnlineStatus(p31) --[[ Line: 264 ]]
    -- upvalues: u13 (copy)
    u13.Interface.TweenFrame.ServerErrorMessage.Visible = not p31;
    if p31 then
        u13.StartNewSearch(true);
    end;
end;
function u13.SetupNotes() --[[ Line: 271 ]]
    -- upvalues: u13 (copy), l__Dropdown__6 (copy), u6 (copy), u12 (copy), l__Unify__5 (copy), u3 (copy), u2 (copy), u10 (copy)
    u13.SortDropdown = l__Dropdown__6.SetupDropbox(u13.Viewer.DropdownBox, u13.SortOptions);
    function u13.SortDropdown.Switched() --[[ Line: 274 ]]
        -- upvalues: u13 (ref)
        u13.StartNewSearch();
    end;
    local l__PageBar__13 = u13.Viewer.PageBar;
    u6.NewButton(l__PageBar__13.LeftArrowButton).Activated:Connect(function() --[[ Line: 280 ]]
        -- upvalues: u13 (ref)
        u13.TravelLastPage();
    end);
    u6.NewButton(l__PageBar__13.RightArrowButton).Activated:Connect(function() --[[ Line: 284 ]]
        -- upvalues: u13 (ref)
        u13.TravelNextPage();
    end);
    u6.NewButton(u13.Viewer.BanWindow.CloseButton).Activated:Connect(function() --[[ Line: 288 ]]
        -- upvalues: u13 (ref)
        u13.Viewer.BanWindow.Visible = false;
    end);
    u6.NewButton(u13.Viewer.BanWindow.Ban).Activated:Connect(function() --[[ Line: 292 ]]
        -- upvalues: u13 (ref), u12 (ref), l__Unify__5 (ref)
        u13.Viewer.BanWindow.Visible = false;
        u12:Invoke(u13.BanningPlayer, l__Unify__5.ParseTimeString(u13.Viewer.BanWindow.SecondTime.Text));
    end);
    u6.NewButton(u13.Creator.CreateButton).Activated:Connect(function() --[[ Line: 297 ]]
        -- upvalues: u13 (ref), u3 (ref), u2 (ref), u10 (ref)
        local l__Text__14 = u13.Creator.Note.MainBody.Text;
        u13.Creator.Note.MainBody.Text = "";
        if l__Text__14 and l__Text__14 ~= "" then
            local v32, v33 = u2.Do(function() --[[ Line: 306 ]]
                -- upvalues: u10 (ref), l__Text__14 (copy), u13 (ref)
                return u10:Invoke(l__Text__14, u13.Creator.Note.ImageColor3);
            end);
            if v32 then
                if v33 and v33 == "Success" then
                    u13.Viewer.Visible = true;
                    u13.Creator.Visible = false;
                end;
            else
                u3.Error(v33);
            end;
        else
            u3.Error("You cannot make an empty note!");
        end;
    end);
    u6.NewButton(u13.Viewer.CreateButton).Activated:Connect(function() --[[ Line: 320 ]]
        -- upvalues: u13 (ref)
        u13.Viewer.Visible = false;
        u13.Creator.Visible = true;
        u13.Creator.Note.ImageColor3 = Color3.new(1, 1, 1);
        u13.Creator.Note.MainBody.Text = "";
    end);
    u6.NewButton(u13.Creator.BackButton).Activated:Connect(function() --[[ Line: 328 ]]
        -- upvalues: u13 (ref)
        u13.Viewer.Visible = true;
        u13.Creator.Visible = false;
    end);
    u6.NewButton(u13.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 333 ]]
        -- upvalues: u13 (ref)
        u13.Interface.Close();
    end);
    u6.NewButton(u13.Interface.TweenFrame.RefreshButton).Activated:Connect(function() --[[ Line: 337 ]]
        -- upvalues: u13 (ref)
        u13.StartNewSearch();
    end);
    for _, u34 in u13.Creator.Selector:GetChildren() do
        if u34:IsA("GuiButton") then
            u6.NewButton(u34).Activated:Connect(function() --[[ Line: 343 ]]
                -- upvalues: u13 (ref), u34 (copy)
                u13.Creator.Note.ImageColor3 = u34.BackgroundColor3;
            end);
        end;
    end;
end;
function u13.Trigger() --[[ Line: 350 ]]
    -- upvalues: u13 (copy)
    u13.Interface.Trigger();
end;
function u13.Setup() --[[ Line: 352 ]]
    -- upvalues: u13 (copy), u6 (copy), u4 (copy), u7 (copy)
    u13.Interface = u6.Get("Note");
    u13.Trigger = u13.Interface.Trigger;
    u13.Creator = u13.Interface.TweenFrame.Creator;
    u13.Viewer = u13.Interface.TweenFrame.Viewer;
    u13.SetupNotes();
    u4.IndexUpdated("NotesVoted"):Connect(function() --[[ Line: 361 ]]
        -- upvalues: u13 (ref)
        for _, v35 in pairs(u13.NoteItems) do
            u13.UpdateNoteItemVoteStatus(v35);
        end;
    end);
    u13.RespondToOnlineStatus(u7.IsCurrentlyOnline);
    u7("IndexChanged", "IsCurrentlyOnline"):Connect(u13.RespondToOnlineStatus);
    u13.StartNewSearch(true);
end;
return u13;
