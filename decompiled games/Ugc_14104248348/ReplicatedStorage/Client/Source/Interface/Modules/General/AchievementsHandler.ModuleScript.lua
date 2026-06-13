-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.AchievementsHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Utility__3 = require(l__ReplicatedStorage__2.Modules.Utility);
local l__Queue__4 = require(l__ReplicatedStorage__2.Modules.Queue);
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__5:Get("ItemFrame");
local u2 = l__Mince__5:Get("UserProfile");
local u3 = l__Mince__5:Get("Topbar");
local u4 = l__Mince__5:Get("TriggerHandler");
local u5 = l__Mince__5:Get("InterfaceHandler");
local v6 = l__Mince__5:GetEvent("Achievement");
local u7 = v6:Extend("Claim");
local u8 = v6:Extend("ClaimKey");
function ModifyColor(p9, p10)
    local v11, v12, v13 = p9:ToHSV();
    return Color3.fromHSV(v11 * (p10.H or 1), v12 * (p10.S or 1), v13 * (p10.V or 1));
end;
local u14 = {
    __IsAsyncSetup = true,
    Items = {},
    PullTween = TweenInfo.new(0.6, Enum.EasingStyle.Back),
    FillTween = TweenInfo.new(0.5),
    NotifyPoints = { 0.5, 1 }
};
function u14.DoPulldownFor(p15) --[[ Line: 38 ]]
    -- upvalues: u14 (copy), l__Mince__5 (copy), l__ReplicatedStorage__2 (copy), l__TweenService__1 (copy)
    local v16 = nil;
    local v17 = nil;
    local l__Type__6 = p15.Requirements.Type;
    local v18 = 0;
    if l__Type__6 == "Statistic" then
        v17 = 0;
        local v19 = 0;
        for v20, v21 in p15.Requirements.Data do
            v17 = v17 + v21;
            v19 = v19 + u14.GetRecord(v20);
        end;
        v16 = math.min(v19, v17);
        v18 = math.clamp(v19 / v17, 0.05, 1);
    elseif l__Type__6 == "InsecureClientTrigger" then
        local v22;
        if l__Mince__5.Config.LocalProfile.AchievementKeys then
            v22 = l__Mince__5.Config.LocalProfile.AchievementKeys[p15.Requirements.Key] or false;
        else
            v22 = false;
        end;
        local v23 = v22 and 1 or 0;
        v16 = math.min(v23, 1);
        v18 = math.clamp(v23 / 1, 0.05, 1);
        v17 = 1;
    end;
    local v24 = l__ReplicatedStorage__2.Assets.Interface.Achievement.Pulldown:Clone();
    v24.ProgressBar.Fill.Size = UDim2.fromScale(p15.PreviousProgress, 1);
    v24.ProgressBar.CompleteLabel.Text = `{v16} / {v17}`;
    v24.ProgressBar.Fill.BackgroundColor3 = p15.DarkColor;
    v24.Descriptor.Text = p15.Description;
    v24.TitleLabel.Text = p15.Name;
    v24.BackgroundColor3 = p15.Group.Color;
    local l__Position__7 = v24.Position;
    local v25 = l__Position__7 - UDim2.fromScale(0, v24.Position.Y.Scale + 0.5);
    v24.Position = v25;
    v24.Parent = u14.MainPriority;
    l__TweenService__1:Create(v24.ProgressBar.Fill, u14.FillTween, {
        Size = UDim2.fromScale(v18, 1)
    }):Play();
    local v26 = l__TweenService__1:Create(v24, u14.PullTween, {
        Position = l__Position__7
    });
    v26:Play();
    v26.Completed:Wait();
    task.wait(5);
    local v27 = l__TweenService__1:Create(v24, u14.PullTween, {
        Position = v25
    });
    v27:Play();
    v27.Completed:Wait();
end;
function u14.SetupItems() --[[ Line: 96 ]]
    -- upvalues: u14 (copy), l__Mince__5 (copy), l__ReplicatedStorage__2 (copy), u1 (copy), u5 (copy), u7 (copy)
    for _, v28 in u14.Achievements.TweenFrame.Scroll:GetChildren() do
        if v28:IsA("ImageLabel") then
            v28:Destroy();
        end;
    end;
    for v29, u30 in l__Mince__5.Config.Achievement.Items do
        u30.IsClaimable = false;
        u30.Claimed = false;
        u30.Updated = false;
        u30.Connected = true;
        u30.Notifed = {};
        local v31 = l__Mince__5.Config.Achievement.Groups[u30.Group];
        local u32 = l__ReplicatedStorage__2.Assets.Interface.Achievement.AchievementItem:Clone();
        u30.Gui = u32;
        u30.Group = v31;
        u30.Order = v29;
        u30.GroupOrder = v31.Order;
        u30.DarkColor = ModifyColor(v31.Color, {
            V = 0.8
        });
        u32.ProgressBar.Fill.BackgroundColor3 = ModifyColor(v31.Color, {
            V = 0.8
        });
        u32.Completed.Visible = false;
        u32.Descriptor.Text = u30.Description;
        u32.TitleLabel.Text = u30.Name;
        u32.Info.BackgroundColor3 = v31.Color;
        for _, v33 in u30.Rewards do
            local v34 = l__ReplicatedStorage__2.Assets.Interface.Achievement.ItemFrame:Clone();
            u1.GenerateFromItemTable(v33, u14.Achievements.TweenFrame).Gui.Parent = v34;
            v34.Parent = u32.Items;
        end;
        u5.NewButton(u32.Claim).Activated:Connect(function() --[[ Line: 142 ]]
            -- upvalues: u7 (ref), u30 (copy)
            u7:Fire(u30.ID);
        end);
        function u30.Update(p35) --[[ Line: 146 ]]
            -- upvalues: u30 (copy), u14 (ref), u32 (copy), l__Mince__5 (ref)
            local l__Type__8 = u30.Requirements.Type;
            local v36 = 0;
            if l__Type__8 == "Statistic" then
                local v37 = 0;
                local v38 = 0;
                for v39, v40 in u30.Requirements.Data do
                    v37 = v37 + v40;
                    v38 = v38 + u14.GetRecord(v39);
                end;
                local v41 = math.min(v38, v37);
                v36 = math.clamp(v41 / v37, 0.05, 1);
                u30.IsClaimable = v41 == v37;
                u32.ProgressBar.CompleteLabel.Text = `{v41} / {v37}`;
                u32.ProgressBar.Fill.Size = UDim2.fromScale(v36, 1);
            elseif l__Type__8 == "InsecureClientTrigger" then
                local v42 = (l__Mince__5.Config.LocalProfile.AchievementKeys and l__Mince__5.Config.LocalProfile.AchievementKeys[u30.Requirements.Key] or false) and 1 or 0;
                v36 = math.clamp(v42 / 1, 0.05, 1);
                u30.IsClaimable = v42 == 1;
                u32.ProgressBar.CompleteLabel.Text = `{v42} / {1}`;
                u32.ProgressBar.Fill.Size = UDim2.fromScale(v36, 1);
            end;
            if u30.IsClaimable then
                if u30.Claimed then
                    u32.Claim.Visible = false;
                    u32.NotReady.Visible = true;
                    u32.NotReady.Text = "Claimed";
                    u32.Completed.Visible = true;
                else
                    u32.Claim.Visible = true;
                    u32.NotReady.Visible = false;
                end;
            else
                u32.Claim.Visible = false;
                u32.NotReady.Visible = true;
            end;
            if u30.Updated then
                local v43 = nil;
                for _, v44 in u14.NotifyPoints do
                    if not u30.Notifed[v44] and v44 <= v36 then
                        u30.Notifed[v44] = true;
                        v43 = true;
                    end;
                end;
                if v43 then
                    u14.Queue:Push(function() --[[ Line: 199 ]]
                        -- upvalues: u14 (ref), u30 (ref)
                        u14.DoPulldownFor(u30);
                    end);
                end;
            else
                for _, v45 in u14.NotifyPoints do
                    if v45 <= v36 then
                        u30.Notifed[v45] = true;
                    end;
                end;
            end;
            if u30.Claimed then
                u32.LayoutOrder = 1000000 + u30.GroupOrder * 1000 + u30.Order;
            else
                u32.LayoutOrder = -math.round(v36 * 10000);
            end;
            if p35 then
                task.delay(1, function() --[[ Line: 218 ]]
                    -- upvalues: u30 (ref)
                    u30.Updated = true;
                end);
            end;
            u30.PreviousProgress = v36;
        end;
        task.defer(u30.Update);
        u32.Parent = u14.Achievements.TweenFrame.Scroll;
        u14.Items[u30.ID] = u30;
    end;
end;
function u14.GetRecord(p46) --[[ Line: 233 ]]
    -- upvalues: l__Mince__5 (copy)
    return l__Mince__5.Config.LocalProfile.Statistics and (l__Mince__5.Config.LocalProfile.Statistics[p46] or 0) or 0;
end;
function u14.UpdateProgress(_) --[[ Line: 241 ]]
    -- upvalues: l__Mince__5 (copy), u3 (copy)
    local v47 = 0;
    for _, v48 in l__Mince__5.Config.Achievement.Items do
        if v48.Connected then
            task.spawn(v48.Update, true);
            if v48.IsClaimable and not v48.Claimed then
                v47 = v47 + 1;
            end;
        end;
    end;
    u3.AcheivementsButton:clearNotices();
    for _ = 1, v47 do
        u3.AcheivementsButton:notify();
    end;
end;
function u14.UpdateClaimed(p49) --[[ Line: 259 ]]
    -- upvalues: l__Utility__3 (copy), l__Mince__5 (copy)
    local v50 = l__Utility__3.CreateFuzzyFinder(p49);
    for _, v51 in l__Mince__5.Config.Achievement.Items do
        v51.Claimed = v50[v51.ID];
        task.spawn(v51.Update, false);
    end;
end;
function u14.SetupGui() --[[ Line: 268 ]]
    -- upvalues: u5 (copy), u14 (copy), u2 (copy)
    u5.NewButton(u14.Achievements.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 271 ]]
        -- upvalues: u14 (ref)
        u14.Achievements.Close();
    end);
    u14.Achievements.Opened:Connect(function() --[[ Line: 274 ]]
        -- upvalues: u2 (ref)
        u2.RequestUpdate("Statistics");
    end);
end;
function u14.Setup() --[[ Line: 279 ]]
    -- upvalues: u14 (copy), l__Queue__4 (copy), u5 (copy), u2 (copy), u4 (copy), u8 (copy)
    u14.Queue = l__Queue__4.new();
    u14.Queue:RunPushedFunctions();
    u14.Achievements = u5.Get("Achievements");
    u14.MainPriority = u5.GetScreenGui("MainPriority");
    u14.SetupGui();
    u14.SetupItems();
    u14.Trigger = u14.Achievements.Trigger;
    u2.IndexUpdated("AchievementClaimed"):Connect(u14.UpdateClaimed);
    u2.IndexUpdated("AchievementKeys"):Connect(u14.UpdateProgress);
    u2.IndexUpdated("Statistics"):Connect(u14.UpdateProgress);
    u4.GetTrigger("AchievementTrigger").Entered:Connect(function(p52) --[[ Line: 295 ]]
        -- upvalues: u8 (ref)
        u8:Fire(p52:GetAttribute("Key"));
    end);
end;
return u14;
