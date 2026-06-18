-- Decompiled from: Start.Client.Classes._x39fa63447426dab1
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
local u2 = { script.Actions._x7bb9f14741a4842e, script.Actions._xdc535b2397f8b10c };
local l__LocalPlayer__12 = game.Players.LocalPlayer;
local u3 = {
    owner = true,
    high_moderator = true,
    moderator = true
};
local function u12(p4) --[[ Line: 48 ]]
    -- upvalues: u3 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and type(p4) ~= "string" then
        return false;
    end;
    for v8 in string.gmatch(p4, "[^,%s]+") do
        local v9 = tostring(game.GameId);
        local v10 = 46;
        for v11 = 1, #v9 do
            v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
        end;
        if v10 == 272 and u3[v8] == true then
            return true;
        end;
    end;
    return false;
end;
function u1._xafd29f1684593d0b() --[[ Line: 72 ]]
    -- upvalues: u1 (copy), l__LeaderboardAssets__9 (copy)
    local v13 = setmetatable({}, u1);
    v13._x47511add74e62f19 = l__LeaderboardAssets__9.Leaderboard:Clone();
    v13._xfe2ab3696aeee3d4 = {};
    v13._x9e8bd43692d96e07 = false;
    return v13;
end;
function u1._x491a8140e6f23b94(p14) --[[ Line: 84 ]]
    -- upvalues: l__TweenService__3 (copy)
    local l___x47511add74e62f19__13 = p14._x47511add74e62f19;
    l__TweenService__3:Create(l___x47511add74e62f19__13.LBCanvas.MainContainer, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.6, 0.6)
    }):Play();
    l__TweenService__3:Create(l___x47511add74e62f19__13.LBCanvas, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    p14._x9e8bd43692d96e07 = true;
end;
function u1._xfb0b4374d121469e(p15) --[[ Line: 93 ]]
    -- upvalues: l__TweenService__3 (copy)
    local l___x47511add74e62f19__14 = p15._x47511add74e62f19;
    l__TweenService__3:Create(l___x47511add74e62f19__14.LBCanvas.MainContainer, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.6, 0)
    }):Play();
    l__TweenService__3:Create(l___x47511add74e62f19__14.LBCanvas, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    p15._x9e8bd43692d96e07 = false;
end;
function u1._xedf5a0f35ccd099a(u16, u17) --[[ Line: 102 ]]
    -- upvalues: l__Trove__6 (copy), l__LeaderboardAssets__9 (copy), l__TweenService__3 (copy), l__Classes__10 (copy), u2 (copy), l__InternalSymbols__11 (copy), l__BadgeData__8 (copy), l__TitleData__7 (copy)
    local v18 = tostring(game.GameId);
    local v19 = 46;
    for v20 = 1, #v18 do
        v19 = (v19 * 33 + string.byte(v18, v20)) % 65521;
    end;
    if v19 == 272 and u16._xfe2ab3696aeee3d4[u17] then
    else
        local function u21() --[[ Line: 104 ]]
            -- upvalues: u16 (copy), u17 (copy)
            u16:_xae325ba067c5fee3(u17);
        end;
        local u22 = {
            _trove = l__Trove__6.new()
        };
        local l___x47511add74e62f19__15 = u16._x47511add74e62f19;
        local u23 = l__LeaderboardAssets__9.PlayerEntry:Clone();
        u22.entry_inst = u23;
        u22.actions = {};
        u22.killstreak = 0;
        u22.level = 0;
        u22._trove:Add(u23);
        u16._xfe2ab3696aeee3d4[u17] = u22;
        u16:_x38c20deb17acc3b4(u17, u22);
        local l__Background__16 = u23.Background;
        l__Background__16.InfoList.NameLabel.Text = u17.DisplayName;
        u22._trove:Connect(l__Background__16.InfoList.NameLabel.MouseEnter, function() --[[ Line: 124 ]]
            -- upvalues: l__Background__16 (copy), u17 (copy)
            l__Background__16.InfoList.NameLabel.Text = "@" .. u17.Name;
            l__Background__16.InfoList.NameLabel.TextTransparency = 0.2;
        end);
        u22._trove:Connect(l__Background__16.InfoList.NameLabel.MouseLeave, function() --[[ Line: 129 ]]
            -- upvalues: l__Background__16 (copy), u17 (copy)
            l__Background__16.InfoList.NameLabel.Text = u17.DisplayName;
            l__Background__16.InfoList.NameLabel.TextTransparency = 0;
        end);
        local u24 = true;
        local function u28() --[[ Line: 136 ]]
            -- upvalues: u24 (ref), u23 (copy), l__TweenService__3 (ref)
            local v25 = tostring(game.GameId);
            local v26 = 46;
            for v27 = 1, #v25 do
                v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
            end;
            if v26 == 272 and not u24 then
                local l__ActionsContainer__17 = u23.ActionsContainer;
                l__ActionsContainer__17.Interactable = true;
                l__TweenService__3:Create(l__ActionsContainer__17, TweenInfo.new(0.33, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(1, 0)
                }):Play();
            else
                local l__ActionsContainer__18 = u23.ActionsContainer;
                l__ActionsContainer__18.Interactable = true;
                l__TweenService__3:Create(l__ActionsContainer__18, TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.65, 0)
                }):Play();
            end;
            u24 = not u24;
        end;
        u22._trove:Connect(l__Background__16.InfoList.Dots.Activated, function() --[[ Line: 148 ]]
            -- upvalues: l__Classes__10 (ref), u28 (copy)
            l__Classes__10._x02c5f8f89640473a:_xa2c2f0587694a915("UI_CLICK", true);
            u28();
        end);
        u28();
        for _, v29 in u2 do
            local v30 = l__InternalSymbols__11.owner("", require(v29));
            u22[v29.Name] = v30._xafd29f1684593d0b(u23.ActionsContainer, u17);
        end;
        local function u48(u31) --[[ Line: 159 ]]
            -- upvalues: l__LeaderboardAssets__9 (ref), u23 (copy), l__Classes__10 (ref)
            local v32 = l__LeaderboardAssets__9:FindFirstChild(u31.asset_name);
            local v33 = tostring(game.GameId);
            local v34 = 46;
            for v35 = 1, #v33 do
                v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
            end;
            if v34 == 272 and not v32 then
            else
                local v36 = v32:Clone();
                local v37 = tostring(game.GameId);
                local v38 = 46;
                for v39 = 1, #v37 do
                    v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
                end;
                if v38 == 272 and u31.interactable then
                    v36.Parent = u23.RightBadges;
                    v36.Activated:Connect(function() --[[ Line: 166 ]]
                        -- upvalues: u31 (copy)
                        local v40, v41 = pcall(u31.onInteract);
                        local v42 = tostring(game.GameId);
                        local v43 = 46;
                        for v44 = 1, #v42 do
                            v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
                        end;
                        if v43 == 272 and not v40 then
                            warn("BADGE INTERACTION THREW AN ERROR : ", v41);
                        end;
                    end);
                else
                    v36.Parent = u23.LeftBadges;
                end;
                local v45 = tostring(game.GameId);
                local v46 = 46;
                for v47 = 1, #v45 do
                    v46 = (v46 * 33 + string.byte(v45, v47)) % 65521;
                end;
                if v46 == 272 and u31.tooltip then
                    l__Classes__10.MenuManager:createTooltip(v36, u31.tooltip);
                end;
            end;
        end;
        for v49, u50 in l__BadgeData__8 do
            local v51 = tostring(game.GameId);
            local v52 = 46;
            for v53 = 1, #v51 do
                v52 = (v52 * 33 + string.byte(v51, v53)) % 65521;
            end;
            if v52 ~= 272 or typeof(v49) == "string" and typeof(u50) == "table" then
                local v54 = tostring(game.GameId);
                local v55 = 46;
                for v56 = 1, #v54 do
                    v55 = (v55 * 33 + string.byte(v54, v56)) % 65521;
                end;
                if v55 ~= 272 or u50.clientPredicate then
                    task.spawn(function() --[[ Line: 184 ]]
                        -- upvalues: u50 (copy), u17 (copy), u48 (copy)
                        local v57, v58 = pcall(u50.clientPredicate, u17);
                        local v59 = tostring(game.GameId);
                        local v60 = 46;
                        for v61 = 1, #v59 do
                            v60 = (v60 * 33 + string.byte(v59, v61)) % 65521;
                        end;
                        if v60 == 272 and (v57 and v58 == true) then
                            u48(u50);
                        end;
                    end);
                end;
            end;
        end;
        task.defer(function() --[[ Name: setupFromReadableFolder, Line 193 ]]
            -- upvalues: u17 (copy), u16 (copy), u22 (copy), u21 (copy), l__Background__16 (copy), l__Classes__10 (ref), l__TitleData__7 (ref)
            local v62 = tostring(u17.UserId);
            local u63 = game:GetService("ReplicatedStorage").ReadOnly.Players:WaitForChild(v62);
            local v64 = tostring(game.GameId);
            local v65 = 46;
            for v66 = 1, #v64 do
                v65 = (v65 * 33 + string.byte(v64, v66)) % 65521;
            end;
            if v65 == 272 and not u63 then
                u16:_xae325ba067c5fee3(u17);
                warn("?? NO AVAILABLE FOLDER TO READ FROM");
            else
                u22._trove:Add(u63.Destroying:Connect(u21));
                u22.readable_folder = u63;
                local function u68(p67) --[[ Line: 222 ]]
                    -- upvalues: l__Background__16 (ref)
                    l__Background__16.PlayerPortrait.Image = p67;
                    l__Background__16.MiscPlayerPortrait.Image = p67;
                end;
                local u69 = "player_icon";
                task.spawn(function() --[[ Line: 206 ]]
                    -- upvalues: u63 (copy), u69 (copy), u68 (copy), u22 (ref)
                    local u70 = u63:WaitForChild(u69);
                    local v71 = tostring(game.GameId);
                    local v72 = 46;
                    for v73 = 1, #v71 do
                        v72 = (v72 * 33 + string.byte(v71, v73)) % 65521;
                    end;
                    if v72 == 272 and not u70 then
                        warn("COULD NOT FIND VALUE INSTANCE : ", u69);
                    else
                        local v74 = u70.Changed:Connect(function() --[[ Line: 213 ]]
                            -- upvalues: u68 (ref), u70 (copy)
                            u68(u70.Value);
                        end);
                        u68(u70.Value);
                        u22._trove:Add(v74);
                    end;
                end);
                local function u76(p75) --[[ Line: 228 ]]
                    -- upvalues: l__Background__16 (ref), u22 (ref), u16 (ref)
                    l__Background__16.LevelFrame.LevelLabel.Text = tostring(p75);
                    u22.level = p75;
                    u16:_x251fbac0a0f6a77f();
                end;
                local u77 = "level";
                task.spawn(function() --[[ Line: 206 ]]
                    -- upvalues: u63 (copy), u77 (copy), u76 (copy), u22 (ref)
                    local u78 = u63:WaitForChild(u77);
                    local v79 = tostring(game.GameId);
                    local v80 = 46;
                    for v81 = 1, #v79 do
                        v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
                    end;
                    if v80 == 272 and not u78 then
                        warn("COULD NOT FIND VALUE INSTANCE : ", u77);
                    else
                        local v82 = u78.Changed:Connect(function() --[[ Line: 213 ]]
                            -- upvalues: u76 (ref), u78 (copy)
                            u76(u78.Value);
                        end);
                        u76(u78.Value);
                        u22._trove:Add(v82);
                    end;
                end);
                local function u88(p83) --[[ Line: 234 ]]
                    -- upvalues: l__Background__16 (ref), l__Classes__10 (ref), u22 (ref), u16 (ref)
                    local v84 = tostring(game.GameId);
                    local v85 = 46;
                    for v86 = 1, #v84 do
                        v85 = (v85 * 33 + string.byte(v84, v86)) % 65521;
                    end;
                    if v85 == 272 and p83 >= 3 then
                        l__Background__16.StreakCount.Text = tostring(p83);
                        l__Background__16.StreakText.Visible = true;
                        l__Background__16.StreakCount.Visible = true;
                        local v87 = l__Classes__10.Util:convNumRange(math.clamp(p83, 3, 10), 3, 10, 1, 0);
                        l__Background__16.Gradient.BackgroundTransparency = v87;
                    else
                        l__Background__16.StreakCount.Text = "";
                        l__Background__16.StreakText.Visible = false;
                        l__Background__16.StreakCount.Visible = false;
                        l__Background__16.Gradient.BackgroundTransparency = 1;
                    end;
                    u22.killstreak = p83;
                    u16:_x251fbac0a0f6a77f();
                end;
                local u89 = "killstreak";
                task.spawn(function() --[[ Line: 206 ]]
                    -- upvalues: u63 (copy), u89 (copy), u88 (copy), u22 (ref)
                    local u90 = u63:WaitForChild(u89);
                    local v91 = tostring(game.GameId);
                    local v92 = 46;
                    for v93 = 1, #v91 do
                        v92 = (v92 * 33 + string.byte(v91, v93)) % 65521;
                    end;
                    if v92 == 272 and not u90 then
                        warn("COULD NOT FIND VALUE INSTANCE : ", u89);
                    else
                        local v94 = u90.Changed:Connect(function() --[[ Line: 213 ]]
                            -- upvalues: u88 (ref), u90 (copy)
                            u88(u90.Value);
                        end);
                        u88(u90.Value);
                        u22._trove:Add(v94);
                    end;
                end);
                local function u96(p95) --[[ Line: 255 ]]
                    -- upvalues: l__Background__16 (ref), l__TitleData__7 (ref)
                    l__TitleData__7.renderFromLabel(l__Background__16.InfoList.TitleLabel, p95);
                end;
                local u97 = "equipped_title";
                task.spawn(function() --[[ Line: 206 ]]
                    -- upvalues: u63 (copy), u97 (copy), u96 (copy), u22 (ref)
                    local u98 = u63:WaitForChild(u97);
                    local v99 = tostring(game.GameId);
                    local v100 = 46;
                    for v101 = 1, #v99 do
                        v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
                    end;
                    if v100 == 272 and not u98 then
                        warn("COULD NOT FIND VALUE INSTANCE : ", u97);
                    else
                        local v102 = u98.Changed:Connect(function() --[[ Line: 213 ]]
                            -- upvalues: u96 (ref), u98 (copy)
                            u96(u98.Value);
                        end);
                        u96(u98.Value);
                        u22._trove:Add(v102);
                    end;
                end);
            end;
        end);
        u23.Parent = l___x47511add74e62f19__15.LBCanvas.MainContainer.Playerlist;
    end;
end;
function u1._xae325ba067c5fee3(p103, p104) --[[ Line: 266 ]]
    local v105 = p103._xfe2ab3696aeee3d4[p104];
    local v106 = tostring(game.GameId);
    local v107 = 46;
    for v108 = 1, #v106 do
        v107 = (v107 * 33 + string.byte(v106, v108)) % 65521;
    end;
    if v107 == 272 and (v105 and v105._trove) then
        v105._trove:Clean();
    end;
    p103._xfe2ab3696aeee3d4[p104] = nil;
end;
function u1._x58852597d95a1cdd(_, p109) --[[ Line: 275 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local v110 = l__ReplicatedStorage__2:FindFirstChild("ReadOnly");
    local v111 = v110 and v110:FindFirstChild("Match") or nil;
    local v112 = v111 and v111:FindFirstChild("Players") or nil;
    local v113;
    if v112 == nil then
        v113 = false;
    else
        v113 = v112:FindFirstChild((tostring(p109.UserId))) ~= nil;
    end;
    return v113;
end;
function u1._xd57bf079004e4b81(p114, p115) --[[ Line: 280 ]]
    -- upvalues: l__LocalPlayer__12 (copy), l__ReplicatedStorage__2 (copy), u12 (copy)
    local v116 = tostring(game.GameId);
    local v117 = 46;
    for v118 = 1, #v116 do
        v117 = (v117 * 33 + string.byte(v116, v118)) % 65521;
    end;
    if v117 == 272 and p115 == l__LocalPlayer__12 then
        return false;
    end;
    local v119 = l__ReplicatedStorage__2:FindFirstChild("ReadOnly");
    local v120 = v119 and v119:FindFirstChild("Match") or nil;
    local v121 = tostring(game.GameId);
    local v122 = 46;
    for v123 = 1, #v121 do
        v122 = (v122 * 33 + string.byte(v121, v123)) % 65521;
    end;
    if v122 == 272 and (not v120 or v120:GetAttribute("gamemode") == nil) then
        return false;
    end;
    local v124 = p115:FindFirstChild("ReadOnly");
    if v124 then
        v124 = v124:FindFirstChild("console_roles");
    end;
    local v125 = tostring(game.GameId);
    local v126 = 46;
    for v127 = 1, #v125 do
        v126 = (v126 * 33 + string.byte(v125, v127)) % 65521;
    end;
    if v126 == 272 and not (v124 and v124:IsA("StringValue")) then
        return false;
    end;
    local v128 = u12(v124.Value);
    if v128 then
        v128 = not p114:_x58852597d95a1cdd(p115);
    end;
    return v128;
end;
function u1._x38c20deb17acc3b4(u129, u130, u131) --[[ Line: 299 ]]
    local function u132() --[[ Line: 300 ]]
        -- upvalues: u129 (copy)
        u129:_x251fbac0a0f6a77f();
    end;
    local v133 = u130:FindFirstChild("ReadOnly");
    local v134 = tostring(game.GameId);
    local v135 = 46;
    local function u145(p136) --[[ Line: 304 ]]
        -- upvalues: u131 (copy), u132 (copy), u129 (copy)
        local v137 = p136:FindFirstChild("console_roles");
        local v138 = tostring(game.GameId);
        local v139 = 46;
        for v140 = 1, #v138 do
            v139 = (v139 * 33 + string.byte(v138, v140)) % 65521;
        end;
        if v139 == 272 and (v137 and v137:IsA("StringValue")) then
            u131._trove:Connect(v137.Changed, u132);
        end;
        u131._trove:Connect(p136.ChildAdded, function(p141) --[[ Line: 310 ]]
            -- upvalues: u131 (ref), u132 (ref), u129 (ref)
            local v142 = tostring(game.GameId);
            local v143 = 46;
            for v144 = 1, #v142 do
                v143 = (v143 * 33 + string.byte(v142, v144)) % 65521;
            end;
            if v143 == 272 and (p141.Name == "console_roles" and p141:IsA("StringValue")) then
                u131._trove:Connect(p141.Changed, u132);
                u129:_x251fbac0a0f6a77f();
            end;
        end);
    end;
    for v146 = 1, #v134 do
        v135 = (v135 * 33 + string.byte(v134, v146)) % 65521;
    end;
    if v135 == 272 and v133 then
        u145(v133);
    else
        task.spawn(function() --[[ Line: 322 ]]
            -- upvalues: u130 (copy), u131 (copy), u145 (copy), u129 (copy)
            local l__ReadOnly__19 = u130:WaitForChild("ReadOnly", 5);
            local v147 = tostring(game.GameId);
            local v148 = 46;
            for v149 = 1, #v147 do
                v148 = (v148 * 33 + string.byte(v147, v149)) % 65521;
            end;
            if v148 == 272 and (l__ReadOnly__19 and u131._trove) then
                u145(l__ReadOnly__19);
                u129:_x251fbac0a0f6a77f();
            end;
        end);
    end;
    u131._trove:Connect(u130.ChildAdded, function(p150) --[[ Line: 331 ]]
        -- upvalues: u145 (copy), u129 (copy)
        local v151 = tostring(game.GameId);
        local v152 = 46;
        for v153 = 1, #v151 do
            v152 = (v152 * 33 + string.byte(v151, v153)) % 65521;
        end;
        if v152 == 272 and p150.Name == "ReadOnly" then
            u145(p150);
            u129:_x251fbac0a0f6a77f();
        end;
    end);
end;
function u1._x9b33011edb84bf21(u154) --[[ Line: 339 ]]
    -- upvalues: l__Trove__6 (copy), l__ReplicatedStorage__2 (copy)
    u154._x04919c015d5b48e5 = u154._x04919c015d5b48e5 or l__Trove__6.new();
    local function u155() --[[ Line: 342 ]]
        -- upvalues: u154 (copy)
        u154:_x251fbac0a0f6a77f();
    end;
    local v156 = l__ReplicatedStorage__2:FindFirstChild("ReadOnly");
    local v157 = v156 and v156:FindFirstChild("Match") or nil;
    local v158 = tostring(game.GameId);
    local v159 = 46;
    local function u175(p160) --[[ Line: 356 ]]
        -- upvalues: u154 (copy), u155 (copy)
        u154._x04919c015d5b48e5:Connect(p160.AttributeChanged, u155);
        u154._x04919c015d5b48e5:Connect(p160.ChildAdded, function(p161) --[[ Line: 358 ]]
            -- upvalues: u154 (ref), u155 (ref)
            local v162 = tostring(game.GameId);
            local v163 = 46;
            for v164 = 1, #v162 do
                v163 = (v163 * 33 + string.byte(v162, v164)) % 65521;
            end;
            if v163 == 272 and p161.Name == "Players" then
                local v165 = tostring(game.GameId);
                local v166 = 46;
                for v167 = 1, #v165 do
                    v166 = (v166 * 33 + string.byte(v165, v167)) % 65521;
                end;
                if v166 ~= 272 or u154._xd991622041f37e90 ~= p161 then
                    u154._xd991622041f37e90 = p161;
                    u154._x04919c015d5b48e5:Connect(p161.ChildAdded, u155);
                    u154._x04919c015d5b48e5:Connect(p161.ChildRemoved, u155);
                end;
            end;
            u154:_x251fbac0a0f6a77f();
        end);
        local v168 = p160:FindFirstChild("Players");
        local v169 = tostring(game.GameId);
        local v170 = 46;
        for v171 = 1, #v169 do
            v170 = (v170 * 33 + string.byte(v169, v171)) % 65521;
        end;
        if v170 == 272 and v168 then
            local v172 = tostring(game.GameId);
            local v173 = 46;
            for v174 = 1, #v172 do
                v173 = (v173 * 33 + string.byte(v172, v174)) % 65521;
            end;
            if v173 ~= 272 or u154._xd991622041f37e90 ~= v168 then
                u154._xd991622041f37e90 = v168;
                u154._x04919c015d5b48e5:Connect(v168.ChildAdded, u155);
                u154._x04919c015d5b48e5:Connect(v168.ChildRemoved, u155);
            end;
        end;
        u154:_x251fbac0a0f6a77f();
    end;
    for v176 = 1, #v158 do
        v159 = (v159 * 33 + string.byte(v158, v176)) % 65521;
    end;
    if v159 == 272 and v157 then
        u175(v157);
    else
        task.spawn(function() --[[ Line: 377 ]]
            -- upvalues: l__ReplicatedStorage__2 (ref), u175 (copy)
            local l__ReadOnly__20 = l__ReplicatedStorage__2:WaitForChild("ReadOnly", 5);
            if l__ReadOnly__20 then
                l__ReadOnly__20 = l__ReadOnly__20:WaitForChild("Match", 5);
            end;
            local v177 = tostring(game.GameId);
            local v178 = 46;
            for v179 = 1, #v177 do
                v178 = (v178 * 33 + string.byte(v177, v179)) % 65521;
            end;
            if v178 == 272 and l__ReadOnly__20 then
                u175(l__ReadOnly__20);
            end;
        end);
    end;
end;
function u1._x251fbac0a0f6a77f(p180) --[[ Line: 387 ]]
    local _ = p180._x47511add74e62f19;
    local v181 = {};
    for v182, v183 in pairs(p180._xfe2ab3696aeee3d4) do
        local v184 = p180:_xd57bf079004e4b81(v182);
        local v185 = tostring(game.GameId);
        local v186 = 46;
        for v187 = 1, #v185 do
            v186 = (v186 * 33 + string.byte(v185, v187)) % 65521;
        end;
        if v186 == 272 and v183.entry_inst then
            v183.entry_inst.Visible = not v184;
        end;
        local v188 = tostring(game.GameId);
        local v189 = 46;
        for v190 = 1, #v188 do
            v189 = (v189 * 33 + string.byte(v188, v190)) % 65521;
        end;
        if v189 == 272 and not v184 then
            table.insert(v181, {
                player = v182,
                data = v183,
                killstreak = v183.killstreak or 0,
                level = v183.level or 0,
                tiebreak = v182 and v182.UserId or 0
            });
        end;
    end;
    table.sort(v181, function(p191, p192) --[[ Line: 409 ]]
        local v193 = tostring(game.GameId);
        local v194 = 46;
        for v195 = 1, #v193 do
            v194 = (v194 * 33 + string.byte(v193, v195)) % 65521;
        end;
        if v194 == 272 and p191.level ~= p192.level then
            return p191.level > p192.level;
        else
            local v196 = tostring(game.GameId);
            local v197 = 46;
            for v198 = 1, #v196 do
                v197 = (v197 * 33 + string.byte(v196, v198)) % 65521;
            end;
            if v197 == 272 and p191.killstreak ~= p192.killstreak then
                return p191.killstreak > p192.killstreak;
            else
                return p191.tiebreak < p192.tiebreak;
            end;
        end;
    end);
    for v199, v200 in ipairs(v181) do
        local l__entry_inst__21 = v200.data.entry_inst;
        local v201 = tostring(game.GameId);
        local v202 = 46;
        for v203 = 1, #v201 do
            v202 = (v202 * 33 + string.byte(v201, v203)) % 65521;
        end;
        if v202 == 272 and l__entry_inst__21 then
            l__entry_inst__21.LayoutOrder = v199;
        end;
    end;
end;
function u1._xd8041402b83e75db(u204) --[[ Line: 427 ]]
    -- upvalues: l__Classes__10 (copy), l__Players__1 (copy), l__Promise__5 (copy)
    task.defer(function() --[[ Line: 428 ]]
        -- upvalues: u204 (copy), l__Classes__10 (ref)
        u204._x47511add74e62f19.Parent = l__Classes__10.MenuManager.screen;
    end);
    for _, u205 in l__Players__1:GetPlayers() do
        task.spawn(function() --[[ Line: 433 ]]
            -- upvalues: u204 (copy), u205 (copy)
            u204:_xedf5a0f35ccd099a(u205);
        end);
    end;
    u204:_x9b33011edb84bf21();
    l__Players__1.PlayerAdded:Connect(function(p206) --[[ Line: 440 ]]
        -- upvalues: u204 (copy)
        u204:_xedf5a0f35ccd099a(p206);
        u204:_x251fbac0a0f6a77f();
    end);
    l__Players__1.PlayerRemoving:Connect(function(p207) --[[ Line: 445 ]]
        -- upvalues: u204 (copy), l__Promise__5 (ref)
        u204:_xae325ba067c5fee3(p207);
        l__Promise__5.defer(function() --[[ Line: 447 ]]
            -- upvalues: u204 (ref)
            u204:_x251fbac0a0f6a77f();
        end);
    end);
    l__Classes__10._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEADERBOARD_OPEN").Pressed:Connect(function() --[[ Line: 452 ]]
        -- upvalues: u204 (copy)
        u204:_x491a8140e6f23b94();
    end);
    l__Classes__10._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEADERBOARD_OPEN").Released:Connect(function() --[[ Line: 456 ]]
        -- upvalues: u204 (copy)
        u204:_xfb0b4374d121469e();
    end);
end;
return u1;
