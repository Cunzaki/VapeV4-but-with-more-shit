-- Decompiled from: Start.Client.Classes._xb880259db2a1f0f1
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ModuleScripts__4 = l__ReplicatedStorage__2.Assets.ModuleScripts;
require(l__ModuleScripts__4.Packets);
require(l__ModuleScripts__4.Signal);
local l__Promise__5 = require(l__ModuleScripts__4.Promise);
local l__Trove__6 = require(l__ModuleScripts__4.Trove);
require(l__ModuleScripts__4.Spring);
local l__TitleData__7 = require(l__ModuleScripts__4.TitleData);
local l__BadgeData__8 = require(l__ModuleScripts__4.BadgeData);
require(l__ModuleScripts__4.CEnum);
local l__LeaderboardAssets__9 = l__ReplicatedStorage__2.Assets.UIAssets.LeaderboardAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__10 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__11 = require(script.Parent.Parent.InternalSymbols);
local u2 = { script.Actions._x263338f66c96e908, script.Actions._xa92dbda95db22038 };
local l__LocalPlayer__12 = game.Players.LocalPlayer;
local u3 = {
    owner = true,
    high_moderator = true,
    moderator = true
};
function u1._x90d4581ac99dd483() --[[ Line: 63 ]]
    -- upvalues: u1 (copy), l__LeaderboardAssets__9 (copy)
    local v4 = setmetatable({}, u1);
    v4._xd8a30eeeb35d3541 = l__LeaderboardAssets__9.Leaderboard:Clone();
    v4._x378546cc717e0e2f = {};
    v4._x74c655fada9e6996 = false;
    return v4;
end;
function u1._x4ebc4b16f644b5b1(p5) --[[ Line: 75 ]]
    -- upvalues: l__TweenService__3 (copy)
    local l___xd8a30eeeb35d3541__13 = p5._xd8a30eeeb35d3541;
    l__TweenService__3:Create(l___xd8a30eeeb35d3541__13.LBCanvas.MainContainer, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.6, 0.6)
    }):Play();
    l__TweenService__3:Create(l___xd8a30eeeb35d3541__13.LBCanvas, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    p5._x74c655fada9e6996 = true;
end;
function u1._xaf2fb310d3ce1c61(p6) --[[ Line: 84 ]]
    -- upvalues: l__TweenService__3 (copy)
    local l___xd8a30eeeb35d3541__14 = p6._xd8a30eeeb35d3541;
    l__TweenService__3:Create(l___xd8a30eeeb35d3541__14.LBCanvas.MainContainer, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.6, 0)
    }):Play();
    l__TweenService__3:Create(l___xd8a30eeeb35d3541__14.LBCanvas, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    p6._x74c655fada9e6996 = false;
end;
function u1._x71d1242b971acecb(u7, u8) --[[ Line: 93 ]]
    -- upvalues: l__Trove__6 (copy), l__LeaderboardAssets__9 (copy), l__TweenService__3 (copy), l__Classes__10 (copy), u2 (copy), l__InternalSymbols__11 (copy), l__BadgeData__8 (copy), l__TitleData__7 (copy)
    if u7._x378546cc717e0e2f[u8] then
    else
        local function u9() --[[ Line: 95 ]]
            -- upvalues: u7 (copy), u8 (copy)
            u7:_xc2a16c67eb893df5(u8);
        end;
        local u10 = {
            _trove = l__Trove__6.new()
        };
        local l___xd8a30eeeb35d3541__15 = u7._xd8a30eeeb35d3541;
        local u11 = l__LeaderboardAssets__9.PlayerEntry:Clone();
        u10.entry_inst = u11;
        u10.actions = {};
        u10.killstreak = 0;
        u10.level = 0;
        u10._trove:Add(u11);
        u7._x378546cc717e0e2f[u8] = u10;
        u7:_xfe2f6c112ae64b81(u8, u10);
        local l__Background__16 = u11.Background;
        l__Background__16.InfoList.NameLabel.Text = u8.DisplayName;
        u10._trove:Connect(l__Background__16.InfoList.NameLabel.MouseEnter, function() --[[ Line: 115 ]]
            -- upvalues: l__Background__16 (copy), u8 (copy)
            l__Background__16.InfoList.NameLabel.Text = "@" .. u8.Name;
            l__Background__16.InfoList.NameLabel.TextTransparency = 0.2;
        end);
        u10._trove:Connect(l__Background__16.InfoList.NameLabel.MouseLeave, function() --[[ Line: 120 ]]
            -- upvalues: l__Background__16 (copy), u8 (copy)
            l__Background__16.InfoList.NameLabel.Text = u8.DisplayName;
            l__Background__16.InfoList.NameLabel.TextTransparency = 0;
        end);
        local u12 = true;
        local function u13() --[[ Line: 127 ]]
            -- upvalues: u12 (ref), u11 (copy), l__TweenService__3 (ref)
            if u12 then
                local l__ActionsContainer__17 = u11.ActionsContainer;
                l__ActionsContainer__17.Interactable = true;
                l__TweenService__3:Create(l__ActionsContainer__17, TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.65, 0)
                }):Play();
            else
                local l__ActionsContainer__18 = u11.ActionsContainer;
                l__ActionsContainer__18.Interactable = true;
                l__TweenService__3:Create(l__ActionsContainer__18, TweenInfo.new(0.33, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(1, 0)
                }):Play();
            end;
            u12 = not u12;
        end;
        u10._trove:Connect(l__Background__16.InfoList.Dots.Activated, function() --[[ Line: 139 ]]
            -- upvalues: l__Classes__10 (ref), u13 (copy)
            l__Classes__10._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
            u13();
        end);
        u13();
        for _, v14 in u2 do
            local v15 = l__InternalSymbols__11.owner("", require(v14));
            u10[v14.Name] = v15._x90d4581ac99dd483(u11.ActionsContainer, u8);
        end;
        local function u21(u16) --[[ Line: 150 ]]
            -- upvalues: l__LeaderboardAssets__9 (ref), u11 (copy), l__Classes__10 (ref)
            local v17 = l__LeaderboardAssets__9:FindFirstChild(u16.asset_name);
            if v17 then
                local v18 = v17:Clone();
                if u16.interactable then
                    v18.Parent = u11.RightBadges;
                    v18.Activated:Connect(function() --[[ Line: 157 ]]
                        -- upvalues: u16 (copy)
                        local v19, v20 = pcall(u16.onInteract);
                        if not v19 then
                            warn("BADGE INTERACTION THREW AN ERROR : ", v20);
                        end;
                    end);
                else
                    v18.Parent = u11.LeftBadges;
                end;
                if u16.tooltip then
                    l__Classes__10.MenuManager:createTooltip(v18, u16.tooltip);
                end;
            end;
        end;
        for v22, u23 in l__BadgeData__8 do
            if typeof(v22) == "string" and (typeof(u23) == "table" and u23.clientPredicate) then
                task.spawn(function() --[[ Line: 175 ]]
                    -- upvalues: u23 (copy), u8 (copy), u21 (copy)
                    local v24, v25 = pcall(u23.clientPredicate, u8);
                    if v24 and v25 == true then
                        u21(u23);
                    end;
                end);
            end;
        end;
        task.defer(function() --[[ Name: setupFromReadableFolder, Line 184 ]]
            -- upvalues: u8 (copy), u7 (copy), u10 (copy), u9 (copy), l__Background__16 (copy), l__Classes__10 (ref), l__TitleData__7 (ref)
            local v26 = tostring(u8.UserId);
            local u27 = game:GetService("ReplicatedStorage").ReadOnly.Players:WaitForChild(v26);
            if u27 then
                u10._trove:Add(u27.Destroying:Connect(u9));
                u10.readable_folder = u27;
                local function u29(p28) --[[ Line: 213 ]]
                    -- upvalues: l__Background__16 (ref)
                    l__Background__16.PlayerPortrait.Image = p28;
                    l__Background__16.MiscPlayerPortrait.Image = p28;
                end;
                local u30 = "player_icon";
                task.spawn(function() --[[ Line: 197 ]]
                    -- upvalues: u27 (copy), u30 (copy), u29 (copy), u10 (ref)
                    local u31 = u27:WaitForChild(u30);
                    if u31 then
                        local v32 = u31.Changed:Connect(function() --[[ Line: 204 ]]
                            -- upvalues: u29 (ref), u31 (copy)
                            u29(u31.Value);
                        end);
                        u29(u31.Value);
                        u10._trove:Add(v32);
                    else
                        warn("COULD NOT FIND VALUE INSTANCE : ", u30);
                    end;
                end);
                local function u34(p33) --[[ Line: 219 ]]
                    -- upvalues: l__Background__16 (ref), u10 (ref), u7 (ref)
                    l__Background__16.LevelFrame.LevelLabel.Text = tostring(p33);
                    u10.level = p33;
                    u7:_x3666f96f6ec62fcf();
                end;
                local u35 = "level";
                task.spawn(function() --[[ Line: 197 ]]
                    -- upvalues: u27 (copy), u35 (copy), u34 (copy), u10 (ref)
                    local u36 = u27:WaitForChild(u35);
                    if u36 then
                        local v37 = u36.Changed:Connect(function() --[[ Line: 204 ]]
                            -- upvalues: u34 (ref), u36 (copy)
                            u34(u36.Value);
                        end);
                        u34(u36.Value);
                        u10._trove:Add(v37);
                    else
                        warn("COULD NOT FIND VALUE INSTANCE : ", u35);
                    end;
                end);
                local function u40(p38) --[[ Line: 225 ]]
                    -- upvalues: l__Background__16 (ref), l__Classes__10 (ref), u10 (ref), u7 (ref)
                    if p38 >= 3 then
                        l__Background__16.StreakCount.Text = tostring(p38);
                        l__Background__16.StreakText.Visible = true;
                        l__Background__16.StreakCount.Visible = true;
                        local v39 = l__Classes__10.Util:convNumRange(math.clamp(p38, 3, 10), 3, 10, 1, 0);
                        l__Background__16.Gradient.BackgroundTransparency = v39;
                    else
                        l__Background__16.StreakCount.Text = "";
                        l__Background__16.StreakText.Visible = false;
                        l__Background__16.StreakCount.Visible = false;
                        l__Background__16.Gradient.BackgroundTransparency = 1;
                    end;
                    u10.killstreak = p38;
                    u7:_x3666f96f6ec62fcf();
                end;
                local u41 = "killstreak";
                task.spawn(function() --[[ Line: 197 ]]
                    -- upvalues: u27 (copy), u41 (copy), u40 (copy), u10 (ref)
                    local u42 = u27:WaitForChild(u41);
                    if u42 then
                        local v43 = u42.Changed:Connect(function() --[[ Line: 204 ]]
                            -- upvalues: u40 (ref), u42 (copy)
                            u40(u42.Value);
                        end);
                        u40(u42.Value);
                        u10._trove:Add(v43);
                    else
                        warn("COULD NOT FIND VALUE INSTANCE : ", u41);
                    end;
                end);
                local function u45(p44) --[[ Line: 246 ]]
                    -- upvalues: l__Background__16 (ref), l__TitleData__7 (ref)
                    l__TitleData__7.renderFromLabel(l__Background__16.InfoList.TitleLabel, p44);
                end;
                local u46 = "equipped_title";
                task.spawn(function() --[[ Line: 197 ]]
                    -- upvalues: u27 (copy), u46 (copy), u45 (copy), u10 (ref)
                    local u47 = u27:WaitForChild(u46);
                    if u47 then
                        local v48 = u47.Changed:Connect(function() --[[ Line: 204 ]]
                            -- upvalues: u45 (ref), u47 (copy)
                            u45(u47.Value);
                        end);
                        u45(u47.Value);
                        u10._trove:Add(v48);
                    else
                        warn("COULD NOT FIND VALUE INSTANCE : ", u46);
                    end;
                end);
            else
                u7:_xc2a16c67eb893df5(u8);
                warn("?? NO AVAILABLE FOLDER TO READ FROM");
            end;
        end);
        u11.Parent = l___xd8a30eeeb35d3541__15.LBCanvas.MainContainer.Playerlist;
    end;
end;
function u1._xc2a16c67eb893df5(p49, p50) --[[ Line: 257 ]]
    local v51 = p49._x378546cc717e0e2f[p50];
    if v51 and v51._trove then
        v51._trove:Clean();
    end;
    p49._x378546cc717e0e2f[p50] = nil;
end;
function u1._x816b36e22c7a6c67(_, p52) --[[ Line: 266 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local v53 = l__ReplicatedStorage__2:FindFirstChild("ReadOnly");
    local v54 = v53 and v53:FindFirstChild("Match") or nil;
    local v55 = v54 and v54:FindFirstChild("Players") or nil;
    local v56;
    if v55 == nil then
        v56 = false;
    else
        v56 = v55:FindFirstChild((tostring(p52.UserId))) ~= nil;
    end;
    return v56;
end;
function u1._x4d7551893be10ad6(p57, p58) --[[ Line: 271 ]]
    -- upvalues: l__LocalPlayer__12 (copy), l__ReplicatedStorage__2 (copy), u3 (copy)
    if p58 == l__LocalPlayer__12 then
        return false;
    end;
    local v59 = l__ReplicatedStorage__2:FindFirstChild("ReadOnly");
    local v60 = v59 and v59:FindFirstChild("Match") or nil;
    if not v60 or v60:GetAttribute("gamemode") == nil then
        return false;
    end;
    local v61 = p58:FindFirstChild("ReadOnly");
    if v61 then
        v61 = v61:FindFirstChild("console_roles");
    end;
    if not (v61 and v61:IsA("StringValue")) then
        return false;
    end;
    local l__Value__19 = v61.Value;
    local v62;
    if type(l__Value__19) == "string" then
        for v63 in string.gmatch(l__Value__19, "[^,%s]+") do
            if u3[v63] == true then
                v62 = true;
                if v62 then
                    v62 = not p57:_x816b36e22c7a6c67(p58);
                end;
                return v62;
            end;
        end;
        v62 = false;
        if v62 then
            v62 = not p57:_x816b36e22c7a6c67(p58);
        end;
        return v62;
    else
        v62 = false;
        if v62 then
            v62 = not p57:_x816b36e22c7a6c67(p58);
        end;
        return v62;
    end;
end;
function u1._xfe2f6c112ae64b81(u64, u65, u66) --[[ Line: 290 ]]
    local function u67() --[[ Line: 291 ]]
        -- upvalues: u64 (copy)
        u64:_x3666f96f6ec62fcf();
    end;
    local function u71(p68) --[[ Line: 295 ]]
        -- upvalues: u66 (copy), u67 (copy), u64 (copy)
        local v69 = p68:FindFirstChild("console_roles");
        if v69 and v69:IsA("StringValue") then
            u66._trove:Connect(v69.Changed, u67);
        end;
        u66._trove:Connect(p68.ChildAdded, function(p70) --[[ Line: 301 ]]
            -- upvalues: u66 (ref), u67 (ref), u64 (ref)
            if p70.Name == "console_roles" and p70:IsA("StringValue") then
                u66._trove:Connect(p70.Changed, u67);
                u64:_x3666f96f6ec62fcf();
            end;
        end);
    end;
    local v72 = u65:FindFirstChild("ReadOnly");
    if v72 then
        u71(v72);
    else
        task.spawn(function() --[[ Line: 313 ]]
            -- upvalues: u65 (copy), u66 (copy), u71 (copy), u64 (copy)
            local l__ReadOnly__20 = u65:WaitForChild("ReadOnly", 5);
            if l__ReadOnly__20 and u66._trove then
                u71(l__ReadOnly__20);
                u64:_x3666f96f6ec62fcf();
            end;
        end);
    end;
    u66._trove:Connect(u65.ChildAdded, function(p73) --[[ Line: 322 ]]
        -- upvalues: u71 (copy), u64 (copy)
        if p73.Name == "ReadOnly" then
            u71(p73);
            u64:_x3666f96f6ec62fcf();
        end;
    end);
end;
function u1._x03e2a1cf136f0235(u74) --[[ Line: 330 ]]
    -- upvalues: l__Trove__6 (copy), l__ReplicatedStorage__2 (copy)
    u74._x501a778d37b1809d = u74._x501a778d37b1809d or l__Trove__6.new();
    local function u75() --[[ Line: 333 ]]
        -- upvalues: u74 (copy)
        u74:_x3666f96f6ec62fcf();
    end;
    local function u79(p76) --[[ Line: 347 ]]
        -- upvalues: u74 (copy), u75 (copy)
        u74._x501a778d37b1809d:Connect(p76.AttributeChanged, u75);
        u74._x501a778d37b1809d:Connect(p76.ChildAdded, function(p77) --[[ Line: 349 ]]
            -- upvalues: u74 (ref), u75 (ref)
            if p77.Name == "Players" and u74._xfc80f5830ad94bb8 ~= p77 then
                u74._xfc80f5830ad94bb8 = p77;
                u74._x501a778d37b1809d:Connect(p77.ChildAdded, u75);
                u74._x501a778d37b1809d:Connect(p77.ChildRemoved, u75);
            end;
            u74:_x3666f96f6ec62fcf();
        end);
        local v78 = p76:FindFirstChild("Players");
        if v78 and u74._xfc80f5830ad94bb8 ~= v78 then
            u74._xfc80f5830ad94bb8 = v78;
            u74._x501a778d37b1809d:Connect(v78.ChildAdded, u75);
            u74._x501a778d37b1809d:Connect(v78.ChildRemoved, u75);
        end;
        u74:_x3666f96f6ec62fcf();
    end;
    local v80 = l__ReplicatedStorage__2:FindFirstChild("ReadOnly");
    local v81 = v80 and v80:FindFirstChild("Match") or nil;
    if v81 then
        u79(v81);
    else
        task.spawn(function() --[[ Line: 368 ]]
            -- upvalues: l__ReplicatedStorage__2 (ref), u79 (copy)
            local l__ReadOnly__21 = l__ReplicatedStorage__2:WaitForChild("ReadOnly", 5);
            if l__ReadOnly__21 then
                l__ReadOnly__21 = l__ReadOnly__21:WaitForChild("Match", 5);
            end;
            if l__ReadOnly__21 then
                u79(l__ReadOnly__21);
            end;
        end);
    end;
end;
function u1._x3666f96f6ec62fcf(p82) --[[ Line: 378 ]]
    local _ = p82._xd8a30eeeb35d3541;
    local v83 = {};
    for v84, v85 in pairs(p82._x378546cc717e0e2f) do
        local v86 = p82:_x4d7551893be10ad6(v84);
        if v85.entry_inst then
            v85.entry_inst.Visible = not v86;
        end;
        if not v86 then
            table.insert(v83, {
                player = v84,
                data = v85,
                killstreak = v85.killstreak or 0,
                level = v85.level or 0,
                tiebreak = v84 and v84.UserId or 0
            });
        end;
    end;
    table.sort(v83, function(p87, p88) --[[ Line: 400 ]]
        if p87.level == p88.level then
            if p87.killstreak == p88.killstreak then
                return p87.tiebreak < p88.tiebreak;
            else
                return p87.killstreak > p88.killstreak;
            end;
        else
            return p87.level > p88.level;
        end;
    end);
    for v89, v90 in ipairs(v83) do
        local l__entry_inst__22 = v90.data.entry_inst;
        if l__entry_inst__22 then
            l__entry_inst__22.LayoutOrder = v89;
        end;
    end;
end;
function u1._xe53615d96cf36a6b(u91) --[[ Line: 418 ]]
    -- upvalues: l__Classes__10 (copy), l__Players__1 (copy), l__Promise__5 (copy)
    task.defer(function() --[[ Line: 419 ]]
        -- upvalues: u91 (copy), l__Classes__10 (ref)
        u91._xd8a30eeeb35d3541.Parent = l__Classes__10.MenuManager.screen;
    end);
    for _, u92 in l__Players__1:GetPlayers() do
        task.spawn(function() --[[ Line: 424 ]]
            -- upvalues: u91 (copy), u92 (copy)
            u91:_x71d1242b971acecb(u92);
        end);
    end;
    u91:_x03e2a1cf136f0235();
    l__Players__1.PlayerAdded:Connect(function(p93) --[[ Line: 431 ]]
        -- upvalues: u91 (copy)
        u91:_x71d1242b971acecb(p93);
        u91:_x3666f96f6ec62fcf();
    end);
    l__Players__1.PlayerRemoving:Connect(function(p94) --[[ Line: 436 ]]
        -- upvalues: u91 (copy), l__Promise__5 (ref)
        u91:_xc2a16c67eb893df5(p94);
        l__Promise__5.defer(function() --[[ Line: 438 ]]
            -- upvalues: u91 (ref)
            u91:_x3666f96f6ec62fcf();
        end);
    end);
    l__Classes__10._x3e046bec2684f59c:_xc9966245cd0a44a8("LEADERBOARD_OPEN").Pressed:Connect(function() --[[ Line: 443 ]]
        -- upvalues: u91 (copy)
        u91:_x4ebc4b16f644b5b1();
    end);
    l__Classes__10._x3e046bec2684f59c:_xc9966245cd0a44a8("LEADERBOARD_OPEN").Released:Connect(function() --[[ Line: 447 ]]
        -- upvalues: u91 (copy)
        u91:_xaf2fb310d3ce1c61();
    end);
end;
return u1;
