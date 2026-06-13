-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.DailyReward
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("MarketplaceService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Queue__4 = require(l__ReplicatedStorage__1.Modules.Queue);
local l__Unify__5 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__Numerics__6 = require(l__ReplicatedStorage__1.Modules.Numerics);
require(l__ReplicatedStorage__1.Modules.LoadingPoint);
local v1 = l__Queue__4.new();
v1.Step = 0;
v1:RunPushedFunctions();
local u2 = l__Mince__3:Get("ItemFrame");
local u3 = l__Mince__3:Get("UserProfile");
local u4 = l__Mince__3:Get("InterfaceHandler");
local u5 = l__Mince__3:GetEvent("Daily"):Extend("ClaimReward");
local u6 = {
    DaysInWeek = 5,
    DayItems = {},
    Claimed = {},
    BounceTween = TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
    Timestamp = l__Unify__5.GetServerTime()
};
local function u12(p7, p8, p9) --[[ Line: 35 ]]
    -- upvalues: l__TweenService__2 (copy), u6 (copy)
    local v10 = p8:GetAttribute("OGSize") or p8.Size;
    if v10 then
        p8:SetAttribute("OGSize", v10);
    end;
    p8.Size = v10;
    p8.Visible = true;
    if p7 then
    else
        local v11 = p9 or 1.3;
        p8.Size = UDim2.fromScale(v10.X.Scale * v11, v10.Y.Scale * v11);
        l__TweenService__2:Create(p8, u6.BounceTween, {
            Size = v10
        }):Play();
    end;
end;
local u13 = {};
u13.__index = u13;
function u13.new(p14) --[[ Line: 52 ]]
    -- upvalues: u13 (copy)
    local v15 = p14 or {};
    local v16 = typeof(v15) == "table";
    assert(v16, "Constructor .new() requires table for prototype.");
    local v17 = setmetatable(v15, u13);
    v17:Init();
    return v17;
end;
function u13.Init(u18) --[[ Line: 60 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u6 (copy), u4 (copy), u5 (copy)
    u18.UIItem = l__ReplicatedStorage__1.Assets.Interface.DayItem:Clone();
    u18.UIItem.Parent = u6.Rewards.TweenFrame.DayContainer;
    u4.NewButton(u18.UIItem.Preview.Claim).Activated:Connect(function() --[[ Line: 65 ]]
        -- upvalues: u5 (ref), u18 (copy)
        u5:Fire(u18.Day);
    end);
end;
function u13.SetDay(p19, p20) --[[ Line: 70 ]]
    p19.Day = p20;
    p19.UIItem.DayLabel.Text = `Day {p20}`;
end;
function u13.Update(p21) --[[ Line: 76 ]]
    if p21.IsAnimating then
    else
        if not p21.IsEmpty then
            p21.UIItem.DayLabel.FontFace.Weight = Enum.FontWeight.Bold;
        end;
        if p21.IsUnlocked then
            if p21.IsClaimed then
                p21.UIItem.Preview.Claim.Visible = false;
            else
                p21.UIItem.Preview.Claim.Visible = true;
            end;
            if p21.IsClaimed or p21.IsEmpty then
                local l__Selected__7 = p21.UIItem.Preview.Selected;
                local v22 = l__Selected__7:GetAttribute("OGSize") or l__Selected__7.Size;
                if v22 then
                    l__Selected__7:SetAttribute("OGSize", v22);
                end;
                l__Selected__7.Size = v22;
                l__Selected__7.Visible = true;
            end;
        end;
    end;
end;
function u13.DoAnimation(u23) --[[ Line: 96 ]]
    -- upvalues: u12 (copy), l__Numerics__6 (copy)
    u23.IsAnimating = true;
    u23:Clear();
    u23.IsVisible = true;
    u23.UIItem.DayLabel.Visible = true;
    if u23.DayConfig.Type == "UGCLimited" then
        u12(false, u23.UIItem.Preview.Render);
        task.delay(0.6, function() --[[ Line: 106 ]]
            -- upvalues: u23 (copy)
            u23.IsAnimating = false;
        end);
    elseif u23.DayConfig.Type == "Holiday" or u23.DayConfig.Type == "GatchaKeys" then
        u23.ThisExtra.Gui.Visible = true;
        u23.ThisExtra.Gui.AmountLabel.Text = l__Numerics__6.WithCommas(u23.DayConfig.Amount);
        u12(false, u23.ThisExtra.Gui);
        task.delay(0.6, function() --[[ Line: 111 ]]
            -- upvalues: u23 (copy)
            u23.IsAnimating = false;
        end);
    else
        u23.IsAnimating = false;
    end;
    if not u23.IsEmpty then
        u23.UIItem.DayLabel.FontFace.Weight = Enum.FontWeight.Bold;
    end;
    if u23.IsUnlocked then
        if not u23.IsClaimed then
            u23.UIItem.Preview.Claim.Visible = true;
        end;
        if u23.IsEmpty then
            u23.IsAnimating = true;
            u12(false, u23.UIItem.Preview.Selected);
            task.delay(0.6, function() --[[ Line: 130 ]]
                -- upvalues: u23 (copy)
                u23.IsAnimating = false;
            end);
            return;
        end;
        if u23.IsClaimed then
            u23.IsAnimating = true;
            u12(false, u23.UIItem.Preview.Selected);
            task.delay(0.6, function() --[[ Line: 134 ]]
                -- upvalues: u23 (copy)
                u23.IsAnimating = false;
            end);
        end;
    end;
end;
function u13.SetData(p24, p25, p26, p27) --[[ Line: 141 ]]
    -- upvalues: u2 (copy)
    p24.DayConfig = p25;
    p24.IsClaimed = p26;
    p24.IsUnlocked = p27;
    p24.IsEmpty = next(p25) == nil;
    if not p24.UISetup then
        p24.UISetup = true;
        if p24.DayConfig.Type == "UGCLimited" then
            p24.UIItem.Preview.Render.Image = `https://www.roblox.com/asset-thumbnail/image?assetId={p24.DayConfig.ID}&width=420&height=420&format=png`;
            return;
        end;
        if p24.DayConfig.Type == "Holiday" or p24.DayConfig.Type == "GatchaKeys" then
            if p24.ThisExtra then
                p24.ThisExtra:Destroy();
                p24.ThisExtra = nil;
            end;
            p24.ThisExtra = u2.GenerateFromItemTable(p24.DayConfig, p24.UIItem.Preview);
            p24.ThisExtra.Gui.Visible = false;
        end;
    end;
end;
function u13.Clear(p28) --[[ Line: 161 ]]
    if p28.ThisExtra then
        p28.ThisExtra.Visible = false;
    end;
    p28.UIItem.Preview.Selected.Visible = false;
    p28.UIItem.DayLabel.FontFace.Weight = Enum.FontWeight.Regular;
    p28.UIItem.Preview.Claim.Visible = false;
    p28.UIItem.DayLabel.Visible = false;
    p28.UIItem.Preview.Render.Visible = false;
    p28.IsVisible = false;
end;
function u6.UpdateTimer() --[[ Line: 176 ]]
    -- upvalues: u6 (copy), l__Mince__3 (copy), l__Unify__5 (copy)
    if u6.Timestamp then
        local v29 = l__Mince__3.Config.DailyRewards.DayInSeconds - l__Unify__5.GetStandardTimeFrom(u6.Timestamp);
        local v30 = math.max(0, v29);
        u6.Rewards.TweenFrame.TimeLabel.Text = `Next day in {l__Unify__5.AbbreviatedTime(v30)}!`;
    end;
end;
function u6.ShowDaily() --[[ Line: 183 ]]
    -- upvalues: u6 (copy)
    if u6.DontOpenShouldBeDisabled then
    else
        while not u6.HasUpdated do
            task.wait();
        end;
        if u6.IsDisabled then
        else
            for _, v31 in u6.DayItems do
                v31:Clear();
            end;
            u6.Rewards.Open();
            u6.IsAnimating = true;
            local v32 = #u6.DayItems;
            local v33 = v32 * 0.5;
            for _, v34 in u6.DayItems do
                v34:DoAnimation(false);
                task.wait(v33 / v32);
            end;
            u6.IsAnimating = false;
            if u6.Rewards.IsActive then
                u6.Rewards.Closed:Wait();
            end;
        end;
    end;
end;
function u6.Update(p35) --[[ Line: 209 ]]
    -- upvalues: u6 (copy), l__Mince__3 (copy)
    local v36 = math.floor((p35.CurrentDay - 1) / u6.DaysInWeek) * u6.DaysInWeek;
    local v37 = {};
    for _, v38 in p35.Claimed do
        v37[tonumber(v38)] = true;
    end;
    local v39 = 1;
    for v40 = v36 + 1, v36 + u6.DaysInWeek do
        local v41 = u6.DayItems[v39];
        v41:SetDay(v40);
        v41:SetData(l__Mince__3.Config.DailyRewards.DayData[v40], v37[v40], v40 <= p35.CurrentDay);
        v39 = v39 + 1;
    end;
    if p35.IsCurrentlyDisabled then
        local v42 = 1;
        local v43 = true;
        for _ = v36 + 1, v36 + u6.DaysInWeek do
            local v44 = u6.DayItems[v42];
            if not (v44.IsEmpty or v44.Claimed) then
                v43 = false;
            end;
            v42 = v42 + 1;
        end;
        u6.DontOpenShouldBeDisabled = v43;
    end;
    u6.IsDisabled = p35.IsCurrentlyDisabled;
    u6.Claimed = v37;
    u6.Timestamp = p35.LastJoined;
    for _, v45 in u6.DayItems do
        if v45.IsVisible then
            v45:Update();
        end;
    end;
    u6.HasUpdated = true;
end;
function u6.LoadingFinished() --[[ Line: 264 ]]
    -- upvalues: u6 (copy)
    task.wait(1);
    u6.Rewards.Open();
end;
function u6.LoadDayItems() --[[ Line: 269 ]]
    -- upvalues: u6 (copy), u13 (copy)
    for v46 = 1, u6.DaysInWeek do
        local v47 = u13.new();
        v47:SetDay(v46);
        table.insert(u6.DayItems, v47);
    end;
end;
function u6.SetupUI() --[[ Line: 277 ]]
    -- upvalues: u4 (copy), u6 (copy)
    u4.NewButton(u6.Rewards.TweenFrame.CloseButton).Activated:Connect(u6.Rewards.Close);
    u6.LoadDayItems();
end;
function u6.SetupAsync() --[[ Line: 285 ]]
    -- upvalues: u6 (copy), u4 (copy), u3 (copy)
    u6.Rewards = u4.Get("DailyRewards");
    u6.Rewards.Close();
    u6.SetupUI();
    u3.IndexUpdated("DailyRewards"):Connect(u6.Update);
    task.spawn(function() --[[ Line: 291 ]]
        -- upvalues: u6 (ref)
        while true do
            task.wait(1);
            u6.UpdateTimer();
        end;
    end);
end;
function u6.Setup() --[[ Line: 294 ]]
    -- upvalues: u6 (copy)
    task.spawn(u6.SetupAsync);
end;
return u6;
