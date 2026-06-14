-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.UserGenerated.DrinkCreator
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__5 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__Utility__6 = require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = l__Mince__4:Get("AOp");
local u2 = l__Mince__4:Get("Notices");
local u3 = l__Mince__4:Get("NotifPrompt");
local u4 = l__Mince__4:Get("DrinkPrompt");
local u5 = l__Mince__4:Get("UserProfile");
local u6 = l__Mince__4:Get("DrinkHandler");
local u7 = l__Mince__4:Get("ConfirmPrompt");
local u8 = l__Mince__4:Get("InterfaceHandler");
local v9 = l__Mince__4:GetEvent("DrinkCreator");
local u10 = v9:Extend("VoteDrinkItem");
local u11 = v9:Extend("ModeratorTrashItem");
local u12 = l__Mince__4:GetEvent("GetLoadedRecipes");
local u13 = l__Mince__4:GetFunction("FilterText");
local u14 = l__Mince__4:GetFunction("NewCreation");
local u15 = l__Mince__4:GetFunction("RequestLoadedRecipes");
local u16 = l__Mince__4:GetState("DrinkCreatorState");
local u17 = {
    __IsAsyncSetup = true,
    CurrentTimeSelection = 1,
    TimeOptions = 9,
    PendingCreation = false,
    Verbose = false,
    TimeElapsed = 0,
    RequestRate = 10,
    CreateableModifiers = {},
    CreateableObjects = {},
    CurrentSelected = {},
    Selections = {},
    TimeOptionObject = {
        {
            Text = "20m",
            Price = 25
        },
        {
            Text = "1h",
            Price = 60
        },
        {
            Text = "3h",
            Price = 120
        },
        {
            Text = "8h",
            Price = 240
        },
        {
            Text = "1d",
            Price = 390
        },
        {
            Text = "2d",
            Price = 500
        },
        {
            Text = "4d",
            Price = 749
        },
        {
            Text = "7d",
            Price = 1600
        },
        {
            Text = "28d",
            Price = 3999
        }
    },
    CurrentLoadedRecipes = {}
};
function u17.CreateRecipe(u18) --[[ Line: 95 ]]
    -- upvalues: u6 (copy), l__Unify__5 (copy), l__Mince__4 (copy), l__ReplicatedStorage__1 (copy), u17 (copy), u8 (copy), l__LocalPlayer__3 (copy), u7 (copy), u11 (copy), u10 (copy)
    local u19 = {
        RawData = u18
    };
    function u19.UpdateData(_, p20) --[[ Line: 101 ]]
        -- upvalues: u19 (ref)
        if not p20 then
            return warn("NO RECIPE DATA!");
        end;
        u19.RawData = p20;
        u19:UpdateUI();
    end;
    function u19.UpdateUI(_) --[[ Line: 107 ]]
        -- upvalues: u19 (ref), u6 (ref)
        u19.UI.Info.DrinkName.Text = u19.RawData.Name;
        u19.UI.Info.Creator.Text = `by {u19.RawData.FormattedCreatorName}`;
        u19.UI.Extras.VoteLabel.Text = u19.RawData.Votes;
        local v21, v22, v23 = u19.RawData.Color:ToHSV();
        local v24 = Color3.fromHSV(v21, math.min(1, v22 + 0.1), (math.min(1, v23 + 0.1)));
        local v25 = u19.UI.View:FindFirstChildWhichIsA("ViewportFrame");
        if v25 then
            v25:Destroy();
        end;
        u6.CreateSmallDrinkColorViewport(v24).Parent = u19.UI.View;
        u19.UI.LayoutOrder = -u19.RawData.Votes;
        u19:UpdateTimer();
    end;
    function u19.UpdateTimer(_) --[[ Line: 128 ]]
        -- upvalues: l__Unify__5 (ref), u19 (ref)
        local v26 = l__Unify__5.GetServerTimeUntil(u19.RawData.ExpireOn);
        if v26 < 0 then
            u19.UI.Visible = false;
            u19.UI.Info.TimeLabel.Text = "EXPIRED!";
        else
            u19.UI.Info.TimeLabel.Text = l__Unify__5.ShortenedClockTime(v26);
        end;
    end;
    function u19.UpdateVoteStatus(_) --[[ Line: 138 ]]
        -- upvalues: l__Mince__4 (ref), u19 (ref)
        if l__Mince__4.Config.LocalProfile.DrinksVoted[u19.RawData.ID] then
            u19.UI.Extras.Vote.ImageTransparency = 0;
            u19.UI.Extras.Vote.Outline.Visible = false;
            u19.VoteButton.Tween = false;
        else
            u19.UI.Extras.Vote.ImageTransparency = 1;
            u19.UI.Extras.Vote.Outline.Visible = true;
            u19.VoteButton.Tween = true;
        end;
        u19.UI.Extras.Vote.Visible = true;
    end;
    function u19.InitUI(_) --[[ Line: 156 ]]
        -- upvalues: u19 (ref), l__ReplicatedStorage__1 (ref), u17 (ref), u6 (ref), l__Mince__4 (ref), u8 (ref), l__LocalPlayer__3 (ref), u7 (ref), u11 (ref), u10 (ref)
        u19.UI = l__ReplicatedStorage__1.Assets.Interface.PlayerRecipeItem:Clone();
        u19.UI.Parent = u17.Viewer.Scroll;
        u19.UI.Extras.Vote.Visible = false;
        local v27 = {};
        for v28, _ in pairs(u19.RawData.Modifiers) do
            table.insert(v27, v28);
        end;
        local v29 = u6.GetOrderForModifiers({ l__Mince__4.Config.Recipes.SmallGlass.Recipes, u6.Extras.SmallGlass }, {
            RawModifiers = v27
        });
        warn(v29);
        local v30 = v29 or v27;
        for v31, v32 in v30 do
            local v33 = l__Mince__4.Config.Modifiers[v32];
            local v34 = l__ReplicatedStorage__1.Assets.Interface.Square:Clone();
            u6.GetModifierViewport(v33).Parent = v34;
            v34.Parent = u19.UI.Modifiers;
            if v29 then
                v34.LayoutOrder = v31;
                v34.Direct.Visible = v31 ~= #v30;
            else
                v34.LayoutOrder = v33.Order or 0;
            end;
        end;
        u8.AutoSizeScrollingFrame(u19.UI.Modifiers, { "X" });
        u19.UI.Extras.Trash.Visible = l__Mince__4.Config.CommandPermissions:HasPermission(l__LocalPlayer__3, "ManagePlayerDrinks");
        u8.NewButton(u19.UI.Extras.Trash).Activated:Connect(function() --[[ Line: 194 ]]
            -- upvalues: u7 (ref), u11 (ref), u19 (ref)
            u7.Display("Are you sure you want to delete this persons item? You are required to contact server staff first unless emergency.", function() --[[ Line: 195 ]]
                -- upvalues: u11 (ref), u19 (ref)
                u11:Fire(u19.RawData.ID);
            end);
        end);
        u19.VoteButton = u8.NewButton(u19.UI.Extras.Vote);
        u19.VoteButton.Activated:Connect(function() --[[ Line: 201 ]]
            -- upvalues: u10 (ref), u19 (ref)
            u10:Fire(u19.RawData.ID);
        end);
        if l__Mince__4.Config.LocalProfile.DrinksVoted then
            u19:UpdateVoteStatus();
        end;
    end;
    function u19.Destroy(_) --[[ Line: 208 ]]
        -- upvalues: u19 (ref), u17 (ref), u18 (copy)
        task.defer(function() --[[ Line: 209 ]]
            -- upvalues: u19 (ref), u17 (ref), u18 (ref)
            u19.UI:Destroy();
            u17.CurrentLoadedRecipes[u18.ID] = nil;
            u19 = nil;
        end);
    end;
    u19:InitUI();
    u19:UpdateUI();
    u17.CurrentLoadedRecipes[u18.ID] = u19;
    return u19;
end;
function u17.UpdateNewRecipes(p35) --[[ Line: 224 ]]
    -- upvalues: u17 (copy), l__Utility__6 (copy)
    local v36 = {};
    local v37 = 0;
    for _, v38 in pairs(p35) do
        local v39 = u17.CurrentLoadedRecipes[v38.ID];
        if v39 == nil then
            if u17.Verbose then
                print((`Recipe: {v38.ID} was just created.`));
            end;
            u17.CreateRecipe(v38);
        elseif not l__Utility__6.TableEq(v38, v39.RawData or {}) then
            if u17.Verbose then
                print((`Recipe: {v38.ID} was just updated.`));
            end;
            v39:UpdateData(v38);
        end;
        v36[v38.ID] = true;
        v37 = v37 + 1;
    end;
    for v40, v41 in pairs(u17.CurrentLoadedRecipes) do
        if not v36[v40] then
            if u17.Verbose then
                print((`Recipe: {v40} was just removed.`));
            end;
            v41:Destroy();
        end;
    end;
end;
function u17.Validate(p42, p43) --[[ Line: 265 ]]
    -- upvalues: u17 (copy), u6 (copy), l__Utility__6 (copy)
    if #u17.CurrentSelected == 0 then
        return true;
    end;
    if u6.IsADirectMatch(u17.CurrentSelected, p43) then
        return u6.FindRecipeMatch(u17.CurrentSelected, p43);
    end;
    local v44 = l__Utility__6.Deepcopy(u17.CurrentSelected);
    table.insert(v44, p42.Name);
    return u6.IsADirectMatch(v44, p43) and true or false;
end;
function u17.UpdateCreateableObjects() --[[ Line: 286 ]]
    -- upvalues: u17 (copy), l__Mince__4 (copy)
    for _, v45 in u17.CreateableObjects do
        local v46 = u17.Validate(v45.Modifier, l__Mince__4.Config.Recipes.SmallGlass);
        v45.UI.Visible = v46;
    end;
end;
function u17.AddSelection(p47, p48) --[[ Line: 295 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u6 (copy), u17 (copy)
    local v49 = l__ReplicatedStorage__1.Assets.Interface.Square:Clone();
    u6.GetModifierViewport(p48).Parent = v49;
    v49.Parent = u17.Creator.Selected;
    v49.LayoutOrder = p48.Order or 0;
    table.insert(u17.Selections, v49);
    local v50 = l__ReplicatedStorage__1.Assets.Interface.Selected:Clone();
    v50.Parent = p47;
    table.insert(u17.Selections, v50);
end;
function u17.Refresh() --[[ Line: 310 ]]
    -- upvalues: u17 (copy)
    for _, v51 in u17.Selections do
        v51:Destroy();
    end;
    for _, v52 in u17.CreateableObjects do
        v52.IsSelected = false;
    end;
    u17.Selections = {};
    u17.CurrentSelected = {};
    u17.UpdateCreateableObjects();
    u17.Creator.CreateButton.Disabled.Visible = false;
    u17.BuyButton.Tween = not u17.Creator.CreateButton.Disabled.Visible;
end;
function u17.Reset() --[[ Line: 320 ]]
    -- upvalues: u17 (copy)
    u17.Creator.DrinkName.Text = "";
    u17.TimeSlider.SetPosition(0);
    u17.Refresh();
    u17.PendingCreation = false;
end;
function u17.Update(p53) --[[ Line: 328 ]]
    -- upvalues: u17 (copy), u15 (copy), u6 (copy)
    local v54 = u17;
    v54.TimeElapsed = v54.TimeElapsed + p53;
    if u17.Interface.IsActive then
        if u17.TimeElapsed > u17.RequestRate then
            u17.TimeElapsed = 0;
            u17.LoadedRecipes = u15:Invoke();
            u6.Extras.SmallGlass = u17.LoadedRecipes;
            u17.UpdateNewRecipes(u17.LoadedRecipes);
        end;
        for _, v55 in u17.CurrentLoadedRecipes do
            v55:UpdateTimer();
        end;
    end;
end;
function u17.SetupCreateableModifierOptions() --[[ Line: 347 ]]
    -- upvalues: l__Mince__4 (copy), u17 (copy), l__ReplicatedStorage__1 (copy), u6 (copy), u8 (copy)
    for _, v56 in l__Mince__4.Config.Modifiers do
        if v56.PlayerCreateable then
            table.insert(u17.CreateableModifiers, v56);
        end;
    end;
    for _, u57 in u17.CreateableModifiers do
        local u58 = {
            IsSelected = false,
            UI = l__ReplicatedStorage__1.Assets.Interface.ModContainer:Clone(),
            Modifier = u57
        };
        local v59 = u6.GetModifierViewport(u57);
        if v59 then
            v59.Parent = u58.UI.Button;
            u58.UI.LayoutOrder = u57.Order or 0;
            u58.UI.Button.ModName.Text = u57.HoverName;
            u58.UI.Parent = u17.Creator.ModifierGroup;
            u8.NewButton(u58.UI.Button).Activated:Connect(function() --[[ Line: 373 ]]
                -- upvalues: u17 (ref), u57 (copy), l__Mince__4 (ref), u58 (copy), u6 (ref)
                if u17.Validate(u57, l__Mince__4.Config.Recipes.SmallGlass) then
                    if not u58.IsSelected then
                        u58.IsSelected = true;
                        table.insert(u17.CurrentSelected, u57.Name);
                        u17.AddSelection(u58.UI.Button, u57);
                        u17.UpdateCreateableObjects();
                        u17.Creator.CreateButton.Disabled.Visible = u6.IsADirectMatch(u17.CurrentSelected, l__Mince__4.Config.Recipes.SmallGlass);
                        u17.BuyButton.Tween = not u17.Creator.CreateButton.Disabled.Visible;
                    end;
                end;
            end);
            table.insert(u17.CreateableObjects, u58);
        else
            warn((`Failed to get viewport for creatable modifier '{u57.Name}'.`));
        end;
    end;
    u8.NewButton(u17.Creator.Refresh).Activated:Connect(u17.Refresh);
    u17.UpdateCreateableObjects();
end;
function u17.SetupCreator() --[[ Line: 397 ]]
    -- upvalues: u17 (copy), u8 (copy), u16 (copy), u2 (copy), u1 (copy), u13 (copy), u3 (copy), u4 (copy), u6 (copy), u14 (copy)
    u17.TimeSlider = u8.NewSlider(u17.Creator.Slider);
    u17.TimeSlider.Step = 1 / (u17.TimeOptions - 1);
    u17.TimeSlider.Changed:Connect(function(p60) --[[ Line: 401 ]]
        -- upvalues: u17 (ref), u16 (ref)
        local v61 = p60 * (u17.TimeOptions - 1) + 1;
        local v62 = u17.TimeOptionObject[v61];
        u17.CurrentOptionObject = v62;
        u17.CurrentTimeSelection = v61;
        u17.Creator.TimeValue.Text = v62.Text;
        u17.Creator.CreateButton.Text = `{v62.Price}`;
        if u16.FREE_MODE then
            u17.Creator.CreateButton.Text = "FREE";
        end;
    end);
    u17.TimeSlider.SetPosition(0);
    u8.NewButton(u17.Viewer.CreateButton).Activated:Connect(function() --[[ Line: 417 ]]
        -- upvalues: u17 (ref)
        u17.Viewer.Visible = false;
        u17.Creator.Visible = true;
    end);
    u8.NewButton(u17.Creator.BackButton).Activated:Connect(function() --[[ Line: 422 ]]
        -- upvalues: u17 (ref)
        u17.Viewer.Visible = true;
        u17.Creator.Visible = false;
    end);
    u8.NewButton(u17.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 427 ]]
        -- upvalues: u17 (ref)
        u17.Interface.Close();
    end);
    u17.BuyButton = u8.NewButton(u17.Creator.CreateButton);
    u17.BuyButton.Activated:Connect(function() --[[ Line: 432 ]]
        -- upvalues: u17 (ref), u2 (ref), u1 (ref), u13 (ref), u3 (ref), u4 (ref), u6 (ref), u14 (ref)
        if u17.PendingCreation then
        else
            local l__Text__7 = u17.Creator.DrinkName.Text;
            if l__Text__7 and l__Text__7 ~= "" then
                local u63 = l__Text__7:sub(1, 16);
                local v64, v65 = u1.Do(function() --[[ Line: 443 ]]
                    -- upvalues: u13 (ref), u63 (ref)
                    return u13:Invoke(u63);
                end);
                if v64 then
                    if v65.Error then
                        u2.Error(v65.Error);
                    else
                        u17.PendingCreation = true;
                        local u66 = coroutine.running();
                        u3.Display("Inappropiate named drinks may be removed at any time.\n Your recipe needs proper combinations to be creatable.", function() --[[ Line: 460 ]]
                            -- upvalues: u66 (copy)
                            task.spawn(u66);
                        end);
                        coroutine.yield();
                        u4.Display({
                            Color = u6.CalculateDrinkColor(u17.CurrentSelected),
                            DrinkName = v65.Text,
                            Price = u17.CurrentOptionObject.Price,
                            Time = u17.CurrentOptionObject.Text
                        }, function() --[[ Line: 472 ]]
                            -- upvalues: u17 (ref), u1 (ref), u14 (ref), u63 (ref)
                            u17.Viewer.Visible = true;
                            u17.Creator.Visible = false;
                            u1.Do(function() --[[ Line: 476 ]]
                                -- upvalues: u14 (ref), u63 (ref), u17 (ref)
                                return u14:Invoke({
                                    Name = u63,
                                    TimeOption = u17.CurrentTimeSelection,
                                    Modifiers = u17.CurrentSelected
                                });
                            end);
                            u17.Reset();
                        end, u17.Reset);
                    end;
                else
                    u2.Error(v65);
                end;
            else
                u2.Error("Drink name is required!");
            end;
        end;
    end);
end;
function u17.Trigger() --[[ Line: 489 ]]
    -- upvalues: u17 (copy)
    u17.Interface.Trigger();
end;
function u17.Setup() --[[ Line: 493 ]]
    -- upvalues: u17 (copy), u8 (copy), u16 (copy), u12 (copy), u6 (copy), u5 (copy), l__RunService__2 (copy), u15 (copy)
    u17.Interface = u8.Get("DrinkCreator");
    u17.Creator = u17.Interface.TweenFrame.Creator;
    u17.Viewer = u17.Interface.TweenFrame.Viewer;
    if u16.ServerLoadFailed then
        u17.Viewer.Scroll.Visible = false;
        u17.Viewer.CreateButton.Visible = false;
        u17.Viewer.ServerErrorMessage.Visible = true;
        u8.NewButton(u17.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 503 ]]
            -- upvalues: u17 (ref)
            u17.Interface.Close();
        end);
    else
        u17.Interface.Opened:Connect(function() --[[ Line: 509 ]]
            -- upvalues: u17 (ref)
            u17.PendingCreation = false;
        end);
        u8.AutoSizeScrollingFrame(u17.Viewer.Scroll);
        u12.Event:Connect(function(p67) --[[ Line: 515 ]]
            -- upvalues: u17 (ref), u6 (ref)
            u17.LoadedRecipes = p67;
            u6.Extras.SmallGlass = u17.LoadedRecipes;
        end);
        u5.IndexUpdated("DrinksVoted"):Connect(function() --[[ Line: 520 ]]
            -- upvalues: u17 (ref)
            for _, v68 in pairs(u17.CurrentLoadedRecipes) do
                v68:UpdateVoteStatus();
            end;
        end);
        l__RunService__2.Heartbeat:Connect(u17.Update);
        u17.SetupCreateableModifierOptions();
        u17.SetupCreator();
        u17.LoadedRecipes = u15:Invoke();
        u6.Extras.SmallGlass = u17.LoadedRecipes;
        u17.UpdateNewRecipes(u17.LoadedRecipes);
    end;
end;
return u17;
