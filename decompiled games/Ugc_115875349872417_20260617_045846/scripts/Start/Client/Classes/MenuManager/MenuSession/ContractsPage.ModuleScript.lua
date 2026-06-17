-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ContractsPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Trove__4 = require(l__ModuleScripts__3.Trove);
local l__ContractsDef__5 = require(l__ModuleScripts__3.ContractsDef);
local l__UIAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__7 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l___x7749231778538ccb__8 = require(script.Parent.Parent.Parent.Parent._x7749231778538ccb);
local u2 = {
    daily = 0,
    weekly = 1000,
    achievement = 2000
};
local u3 = utf8.char(165);
local function u10(p4) --[[ Line: 41 ]]
    -- upvalues: u3 (copy)
    if p4.reward_text then
        return p4.reward_text;
    end;
    local v5 = {};
    for v6, v7 in pairs(p4.reward_table or {}) do
        if v6 == "yen" then
            local v8 = "<b>" .. u3 .. tostring(v7) .. "</b>";
            table.insert(v5, v8);
        elseif v6 ~= "crimson" then
            local v9 = "<b>" .. tostring(v7) .. " " .. tostring(v6) .. "</b>";
            table.insert(v5, v9);
        end;
    end;
    return table.concat(v5, ", ");
end;
local function u16(p11, p12) --[[ Line: 68 ]]
    -- upvalues: u10 (copy)
    local l__reward_table__9 = p12.reward_table;
    local v13;
    if type(l__reward_table__9) == "table" then
        v13 = l__reward_table__9.crimson;
    else
        v13 = nil;
    end;
    local v14 = v13 ~= nil;
    p11.CrimsonImage.Visible = v14;
    p11.CrimsonTextLabel.Visible = v14;
    if v14 then
        p11.CrimsonTextLabel.RichText = true;
        p11.CrimsonTextLabel.Text = "<b>" .. tostring(v13) .. "</b>";
    else
        p11.CrimsonTextLabel.Text = "";
    end;
    local v15 = u10(p12);
    if v14 and v15 ~= "" then
        v15 = ", " .. v15;
    end;
    p11.TextLabel.Text = v15;
end;
local function u23(p17) --[[ Line: 89 ]]
    local v18 = math.floor(p17);
    local v19 = math.max(0, v18);
    if v19 >= 86400 then
        local v20 = math.ceil(v19 / 86400);
        return "REFRESHES IN " .. tostring(v20) .. " DAYS";
    end;
    local v21 = math.floor(v19 / 3600);
    local v22 = math.floor(v19 % 3600 / 60);
    return string.format("REFRESHES IN %02d:%02d:%02d", v21, v22, v19 % 60);
end;
function u1.new(p24, p25) --[[ Line: 104 ]]
    -- upvalues: u1 (copy), l___x7749231778538ccb__8 (copy), l__Trove__4 (copy), l__UIAssets__6 (copy)
    local v26 = setmetatable({}, u1);
    v26.menu_session = l___x7749231778538ccb__8._xd644d9e3ba63f27f("MenuSession", p25);
    v26.parent_os = p24;
    v26.trove = l__Trove__4.new();
    v26.page_origin = l__UIAssets__6.Menu.ContractsPage;
    v26.main_page = v26.page_origin.ContractsFrame:Clone();
    v26.trove:Add(v26.main_page);
    v26.entries_trove = v26.trove:Extend();
    v26.id_to_ui = {};
    v26.id_to_data = {};
    return v26;
end;
function u1.cleanUp(p27) --[[ Line: 124 ]]
    p27.trove:Destroy();
end;
function u1.close(p28) --[[ Line: 128 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__main_page__10 = p28.main_page;
    l__main_page__10.Parent = p28.parent_os.RightContainer.MainOS;
    l__main_page__10.Interactable = false;
    l__TweenService__2:Create(l__main_page__10, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__2:Create(l__main_page__10, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1.start(p29) --[[ Line: 137 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__main_page__11 = p29.main_page;
    l__main_page__11.Interactable = true;
    l__main_page__11.Parent = p29.parent_os.RightContainer.MainOS;
    l__main_page__11.GroupTransparency = 1;
    l__main_page__11.Visible = true;
    l__TweenService__2:Create(l__main_page__11, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__11.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__2:Create(l__main_page__11, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
end;
function u1._getEntriesContainer(p30) --[[ Line: 151 ]]
    return p30.main_page.Borders.ScrollingFrame;
end;
function u1._clearRenderedEntries(p31) --[[ Line: 155 ]]
    local v32 = p31:_getEntriesContainer();
    local l__Name__12 = p31.page_origin.ContractEntry.Name;
    for _, v33 in ipairs(v32:GetChildren()) do
        if v33.Name == l__Name__12 then
            v33:Destroy();
        end;
    end;
end;
function u1._updateContractUI(p34, p35, p36) --[[ Line: 166 ]]
    -- upvalues: l__ContractsDef__5 (copy), u16 (copy), u2 (copy)
    local l__main_page__13 = p34.main_page;
    local l__state__14 = p36.state;
    local v37 = p36.last_update or {};
    local v38 = l__ContractsDef__5.getAll()[p36.def_key];
    if v38 then
        p35.Visible = true;
        p35.ClaimedFrame.Visible = false;
        p35.ClaimReady.Visible = false;
        p35.Bot.CompleteImage.Visible = false;
        p35.Bot.CompleteImage.Outward.Visible = true;
        if l__state__14 == "claimed" then
            p35.ClaimedFrame.Visible = true;
            p35.Bot.CompleteImage.Visible = true;
            p35.Bot.CompleteImage.Outward.Visible = false;
        elseif l__state__14 == "completable" then
            p35.ClaimReady.Visible = true;
        elseif l__state__14 ~= "active" then
            p35.Visible = false;
            return;
        end;
        p35.Top.TitleLabel.Text = v38.title_text or "";
        p35.Top.TrackerLabel.Text = v37.progress_text or "";
        p35.Top.GoalLabel.Text = v38.goal_text or "";
        p35.Top.Progress.Fill.Size = UDim2.fromScale(v37.progress_fill or 0, 1);
        u16(p35.Bot.RewardFrame, v38);
        p35.LayoutOrder = (u2[p36.type] or 10000) + (v38 and v38.layout_order or 0);
        p35.Parent = l__main_page__13.Borders.ScrollingFrame;
    else
        p35.Visible = false;
    end;
end;
function u1._removeContractEntry(p39, p40) --[[ Line: 205 ]]
    local v41 = p39.id_to_ui[p40];
    if v41 then
        v41:Destroy();
    end;
    p39.id_to_ui[p40] = nil;
    p39.id_to_data[p40] = nil;
end;
function u1._wireEntry(u42, u43, p44) --[[ Line: 215 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__2 (copy)
    u42.entries_trove:Connect(p44.Button.Activated, function() --[[ Line: 216 ]]
        -- upvalues: u42 (copy), u43 (copy), l__Classes__7 (ref), l__TweenService__2 (ref)
        local v45 = u42.id_to_data[u43];
        if v45 then
            if v45.claimable then
                l__Classes__7._x6e9edd41a4bfa127:_x042a62efa5274aac(u43);
                local v46 = u42.id_to_ui[u43];
                if v46 then
                    v46.ClaimAnimation.Visible = true;
                    l__TweenService__2:Create(v46.ClaimAnimation.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Thickness = 0
                    }):Play();
                    l__TweenService__2:Create(v46.ClaimAnimation.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(1.5, 0)
                    }):Play();
                    l__Classes__7._x6dbba03a0636f7d8:_x282746dbf42c87cb("GOAL_COMPLETE", true);
                    v46.ClaimReady.Visible = false;
                    v46.ClaimedFrame.Visible = true;
                end;
            end;
        end;
    end);
end;
function u1._upsertContractEntry(p47, p48, p49) --[[ Line: 238 ]]
    p47.id_to_data[p48] = p49;
    local v50 = p47.id_to_ui[p48];
    if not v50 then
        v50 = p47.page_origin.ContractEntry:Clone();
        p47.id_to_ui[p48] = v50;
        p47:_wireEntry(p48, v50);
    end;
    p47:_updateContractUI(v50, p49);
end;
function u1.refreshEntries(p51, p52) --[[ Line: 251 ]]
    p51.entries_trove:Clean();
    local v53 = {};
    for v54 in pairs(p51.id_to_ui) do
        table.insert(v53, v54);
    end;
    for _, v55 in ipairs(v53) do
        p51:_removeContractEntry(v55);
    end;
    p51:_clearRenderedEntries();
    for v56, v57 in pairs(p52) do
        p51:_upsertContractEntry(v56, v57);
    end;
    p51:refreshAlert();
    p51:_updateRefreshTimers();
end;
function u1.countUnclaimed(p58) --[[ Line: 273 ]]
    local v59 = 0;
    for _, v60 in pairs(p58.id_to_data) do
        if v60.state == "completable" then
            v59 = v59 + 1;
        end;
    end;
    return v59;
end;
function u1.refreshAlert(p61) --[[ Line: 283 ]]
    if p61:countUnclaimed() > 0 then
        p61.menu_session:setNotifyVisible("contracts_page", true);
    else
        p61.menu_session:setNotifyVisible("contracts_page", false);
    end;
end;
function u1._getCycleEndUnix(p62, p63) --[[ Line: 291 ]]
    local v64 = nil;
    for _, v65 in pairs(p62.id_to_data) do
        if v65.type == p63 and (type(v65.cycle_ends_at) == "number" and (v64 == nil or v65.cycle_ends_at < v64)) then
            v64 = v65.cycle_ends_at;
        end;
    end;
    return v64;
end;
function u1._updateRefreshTimers(p66) --[[ Line: 305 ]]
    -- upvalues: u23 (copy)
    local l__ScrollingFrame__15 = p66.main_page.Borders.ScrollingFrame;
    local l__TimerLabel__16 = l__ScrollingFrame__15.DailyTopbar.TimerLabel;
    local l__TimerLabel__17 = l__ScrollingFrame__15.WeeklyTopbar.TimerLabel;
    local l__UnixTimestamp__18 = DateTime.now().UnixTimestamp;
    local v67 = p66:_getCycleEndUnix("daily");
    local v68 = p66:_getCycleEndUnix("weekly");
    if v67 then
        l__TimerLabel__16.Text = u23(v67 - l__UnixTimestamp__18);
    else
        l__TimerLabel__16.Text = "REFRESHES IN 00:00:00";
    end;
    if v68 then
        l__TimerLabel__17.Text = u23(v68 - l__UnixTimestamp__18);
    else
        l__TimerLabel__17.Text = "REFRESHES IN 00:00:00";
    end;
end;
function u1.Init(u69) --[[ Line: 328 ]]
    -- upvalues: l__Classes__7 (copy), l__RunService__1 (copy)
    local v70 = l__Classes__7._x6e9edd41a4bfa127:_x84b7ea74a9cdaa56();
    local v71 = 0;
    for _ in pairs(v70) do
        v71 = v71 + 1;
    end;
    if v71 == 0 then
        l__Classes__7._x6e9edd41a4bfa127._xbeadb63fa96718e1:Once(function(p72) --[[ Line: 332 ]]
            -- upvalues: u69 (copy)
            u69:refreshEntries(p72);
        end);
    else
        u69:refreshEntries(l__Classes__7._x6e9edd41a4bfa127:_x84b7ea74a9cdaa56());
    end;
    u69.trove:Connect(l__Classes__7._x6e9edd41a4bfa127._xbeadb63fa96718e1, function(p73) --[[ Line: 337 ]]
        -- upvalues: u69 (copy)
        u69:refreshEntries(p73);
    end);
    u69.trove:Connect(l__Classes__7._x6e9edd41a4bfa127._xd1a4e36891739b9e, function(p74, p75) --[[ Line: 341 ]]
        -- upvalues: u69 (copy)
        u69:_upsertContractEntry(p74, p75);
        u69:refreshAlert();
        u69:_updateRefreshTimers();
    end);
    u69.trove:Connect(l__Classes__7._x6e9edd41a4bfa127._x101c44920212f79c, function(p76) --[[ Line: 347 ]]
        -- upvalues: u69 (copy)
        u69:_removeContractEntry(p76);
        u69:refreshAlert();
        u69:_updateRefreshTimers();
    end);
    u69:_updateRefreshTimers();
    u69.trove:Connect(l__RunService__1.Heartbeat, function() --[[ Line: 355 ]]
        -- upvalues: u69 (copy)
        u69:_updateRefreshTimers();
    end);
end;
return u1;
