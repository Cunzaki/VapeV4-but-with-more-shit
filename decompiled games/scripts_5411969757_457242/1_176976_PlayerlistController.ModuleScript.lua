-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local u1 = l__LocalPlayer__1:GetMouse();
l__LocalPlayer__1:WaitForChild("Estadisticas");
local l__status_ls__2 = script:WaitForChild("status_ls");
local u2 = {};
local l__Storage__3 = script:WaitForChild("Storage");
game:GetService("ReplicatedStorage"):WaitForChild("TeamLeaderstats");
local l__PlayerFrame__4 = l__Storage__3:WaitForChild("PlayerFrame");
local l__TeamFrame__5 = l__Storage__3:WaitForChild("TeamFrame");
local l__SeparationComponent__6 = l__Storage__3:WaitForChild("SeparationComponent");
local l__PlayerStatLabel__7 = l__Storage__3:WaitForChild("PlayerStatLabel");
l__Storage__3:WaitForChild("TeamStatLabel");
local l__TeamContainer__8 = l__Storage__3:WaitForChild("TeamContainer");
local l__ServerOwner__9 = game:GetService("ReplicatedStorage"):WaitForChild("ServerOwner");
game:GetService("GuiService");
local l__RunService__10 = game:GetService("RunService");
game:WaitForChild("ReplicatedStorage"):WaitForChild("PlayerProfile");
local u3 = {
    isAdmin = function() --[[ Name: isAdmin, Line 26 ]]
        return true;
    end
};
local l__DiscordBoosters__11 = require(game:GetService("ReplicatedStorage"):WaitForChild("DiscordBoosters"));
local u4 = Instance.new("BoolValue");
u4.Value = true;
function u2.GetLeaderstatAvailableObject() --[[ Line: 39 ]]
    -- upvalues: l__status_ls__2 (copy)
    return l__status_ls__2;
end;
function u2.SetPlayerlistVisibility(p5) --[[ Line: 43 ]]
    -- upvalues: u4 (copy)
    u4.Value = p5;
end;
function u2.GetPlayerlistVisibility() --[[ Line: 47 ]]
    -- upvalues: u4 (copy)
    return u4.Value;
end;
function u2.GetVisibilityObject() --[[ Line: 51 ]]
    -- upvalues: u4 (copy)
    return u4;
end;
function u2.TogglePlayerlistVisibility() --[[ Line: 55 ]]
    -- upvalues: u4 (copy)
    u4.Value = not u4.Value;
end;
function u2.GetLayoutOrderFromStatname(p6) --[[ Line: 59 ]]
    return p6:lower() == "kills" and 0 or (p6:lower() == "deaths" and 10 or (p6:lower() == "damage" and 20 or (p6:lower() == "heal" and 30 or 40)));
end;
function u2.GetAvailableStats() --[[ Line: 73 ]]
    -- upvalues: l__status_ls__2 (copy), u3 (copy)
    local v7 = {};
    for _, v8 in ipairs(l__status_ls__2:GetChildren()) do
        local v9 = v8:GetAttribute("Enabled") or true;
        local v10 = v8:GetAttribute("Enabled") or false;
        if v9 == true and v10 == false then
            table.insert(v7, v8.Name);
        elseif v9 == true and u3.isAdmin() == true then
            table.insert(v7, v8.Name);
        end;
    end;
    return v7;
end;
function u2.CreatePlayerFrame(u11, u12, u13) --[[ Line: 87 ]]
    -- upvalues: l__PlayerFrame__4 (copy), u2 (copy), l__LocalPlayer__1 (copy), l__SeparationComponent__6 (copy), l__PlayerStatLabel__7 (copy), u1 (copy), l__RunService__10 (copy), l__ServerOwner__9 (copy), l__DiscordBoosters__11 (copy)
    local u14 = l__PlayerFrame__4:Clone();
    local l__PlayerName__12 = u14:WaitForChild("PlayerName");
    local l__FriendIcon__13 = u14:WaitForChild("FriendIcon");
    local l__Icons__14 = u14:WaitForChild("Icons");
    local l__StatsFrame__15 = u14:WaitForChild("StatsFrame");
    local u15 = u2.GetAvailableStats();
    local u16 = {};
    local l__leaderstats__16 = u11:WaitForChild("leaderstats");
    local l__FPSReplicate__17 = u11:WaitForChild("FPSReplicate");
    local l__PingReplicate__18 = u11:WaitForChild("PingReplicate");
    l__PlayerName__12.Text = u11.Name;
    if u11 == l__LocalPlayer__1 then
        l__PlayerName__12.TextColor3 = Color3.fromRGB(255, 233, 166);
    end;
    local function v23() --[[ Line: 108 ]]
        -- upvalues: u15 (copy), u2 (ref), l__leaderstats__16 (copy), l__SeparationComponent__6 (ref), l__StatsFrame__15 (copy), l__PlayerStatLabel__7 (ref), u11 (copy), l__LocalPlayer__1 (ref), u14 (copy), u16 (copy)
        for _, v17 in ipairs(u15) do
            local v18 = u2.GetLayoutOrderFromStatname(v17);
            local u19 = l__leaderstats__16:FindFirstChild(v17);
            local v20 = l__SeparationComponent__6:Clone();
            v20.LayoutOrder = v18 * 10 - 1;
            v20.Parent = l__StatsFrame__15;
            local u21 = l__PlayerStatLabel__7:Clone();
            u21.Parent = l__StatsFrame__15;
            u21.LayoutOrder = v18 * 10;
            u21.Text = "-";
            if u11 == l__LocalPlayer__1 then
                u21.TextColor3 = Color3.fromRGB(255, 233, 166);
            end;
            if u19 ~= nil and u19.Name == "Rank" then
                u21.LayoutOrder = 999999;
                v20.LayoutOrder = u21.LayoutOrder - 1;
                u21.Size = UDim2.new(0, 90, 1, 0);
            end;
            local function v22() --[[ Line: 131 ]]
                -- upvalues: u19 (copy), u14 (ref), u21 (copy)
                if u19 ~= nil then
                    if u19.Name:lower() == "kills" and typeof(u19.Value) == "number" then
                        u14.LayoutOrder = -u19.Value;
                    end;
                    u21.Text = tostring(u19.Value);
                end;
            end;
            if u19 ~= nil then
                if u19.Name:lower() == "kills" and typeof(u19.Value) == "number" then
                    u14.LayoutOrder = -u19.Value;
                end;
                u21.Text = tostring(u19.Value);
            end;
            table.insert(u16, u19 == nil and function() --[[ Line: 152 ]] end or v22);
        end;
    end;
    local l__MainButton__19 = u14:WaitForChild("MainButton");
    local u24 = false;
    local function u25() --[[ Line: 159 ]]
        -- upvalues: u24 (ref), u12 (copy), u13 (copy), u1 (ref), l__FPSReplicate__17 (copy), l__PingReplicate__18 (copy), l__RunService__10 (ref)
        while u24 == true and (u12.Visible == true and u13.Visible == true) do
            local l__X__20 = u1.X;
            local l__Y__21 = u1.Y;
            u12.Visible = true;
            u12.FPS.Text = l__FPSReplicate__17.Value;
            u12.PING.Text = l__PingReplicate__18.Value;
            u12.Position = UDim2.fromOffset(l__X__20 - 10, l__Y__21 + 3);
            l__RunService__10.RenderStepped:Wait();
        end;
        u12.Visible = false;
    end;
    l__MainButton__19.MouseButton1Click:Connect(function() --[[ Line: 171 ]]
        -- upvalues: l__LocalPlayer__1 (ref), u11 (copy)
        local v26 = l__LocalPlayer__1:FindFirstChild("SeeProfileEvent", true);
        if v26 ~= nil then
            v26:Fire(u11);
        end;
    end);
    l__MainButton__19.MouseEnter:Connect(function(_, _) --[[ Line: 181 ]]
        -- upvalues: u24 (ref), u12 (copy), u25 (copy)
        u24 = true;
        u12.Visible = true;
        u25();
    end);
    l__MainButton__19.MouseLeave:Connect(function(_, _) --[[ Line: 186 ]]
        -- upvalues: u24 (ref), u12 (copy)
        u24 = false;
        u12.Visible = false;
    end);
    local v27 = string.split(l__ServerOwner__9.Value, "(")[2];
    if v27 ~= nil and v27:len() >= 1 then
        local v28 = v27:sub(1, v27:len() - 1) == tostring(u11.UserId);
        l__Icons__14:WaitForChild("ServerOwner").Visible = v28;
        l__Icons__14:WaitForChild("Booster").Visible = l__DiscordBoosters__11[tostring(u11.UserId)] ~= nil;
    end;
    task.spawn(function() --[[ Line: 199 ]]
        -- upvalues: l__LocalPlayer__1 (ref), u11 (copy), l__FriendIcon__13 (copy)
        if l__LocalPlayer__1 == u11 then
        else
            local v29, v30 = pcall(function() --[[ Line: 201 ]]
                -- upvalues: l__LocalPlayer__1 (ref), u11 (ref)
                return l__LocalPlayer__1:IsFriendsWithAsync(u11.UserId);
            end);
            local v31 = l__FriendIcon__13;
            if v29 ~= true then
                v30 = false;
            end;
            v31.Visible = v30;
        end;
    end);
    local function v33() --[[ Line: 208 ]]
        -- upvalues: u16 (copy)
        for _, v32 in ipairs(u16) do
            v32();
        end;
    end;
    for _, v34 in l__leaderstats__16:GetChildren() do
        v34:GetPropertyChangedSignal("Value"):Connect(v33);
    end;
    v23();
    return u14;
end;
function u2.CreateTeamFrame(u35, p36) --[[ Line: 221 ]]
    -- upvalues: l__TeamContainer__8 (copy), l__TeamFrame__5 (copy), u2 (copy), l__SeparationComponent__6 (copy), l__PlayerStatLabel__7 (copy)
    local u37 = l__TeamContainer__8:Clone();
    local u38 = l__TeamFrame__5:Clone();
    local l__TeamName__22 = u38:WaitForChild("TeamName");
    local l__StatsFrame__23 = u38:WaitForChild("StatsFrame");
    local u39 = u2.GetAvailableStats();
    local u40 = {};
    local function v49() --[[ Line: 231 ]]
        -- upvalues: u39 (copy), u2 (ref), l__SeparationComponent__6 (ref), l__StatsFrame__23 (copy), l__PlayerStatLabel__7 (ref), u35 (copy), u40 (copy)
        for _, u41 in ipairs(u39) do
            local v42 = u2.GetLayoutOrderFromStatname(u41);
            local v43 = l__SeparationComponent__6:Clone();
            v43.LayoutOrder = v42 * 10 - 1;
            v43.Parent = l__StatsFrame__23;
            local u44 = l__PlayerStatLabel__7:Clone();
            u44.Parent = l__StatsFrame__23;
            u44.LayoutOrder = v42 * 10;
            u44.Text = "-";
            if u41 == "Rank" then
                u44.LayoutOrder = 999999;
                v43.LayoutOrder = u44.LayoutOrder - 1;
                u44.Size = UDim2.new(0, 90, 1, 0);
            end;
            local function v47() --[[ Line: 246 ]]
                -- upvalues: u41 (copy), u44 (copy), u35 (ref)
                if u41 == "Rank" then
                    u44.Text = "-";
                else
                    local v45 = u44;
                    local v46 = u35:GetAttribute(u41) or 0;
                    v45.Text = tostring(v46);
                end;
            end;
            if u41 == "Rank" then
                u44.Text = "-";
            else
                local v48 = u35:GetAttribute(u41) or 0;
                u44.Text = tostring(v48);
            end;
            table.insert(u40, v47);
        end;
    end;
    local function v51() --[[ Line: 259 ]]
        -- upvalues: u35 (copy), u37 (copy), l__TeamName__22 (copy), u38 (copy)
        local v50 = u35:GetAttribute("PlayersIn");
        u37.Name = u35.TeamColor.Name;
        l__TeamName__22.Text = `[{v50 or #u35:GetPlayers()}] {u35.Name}`;
        u38.BackgroundColor3 = u35.TeamColor.Color;
    end;
    u35:GetAttributeChangedSignal("PlayersIn"):Connect(v51);
    u35:GetPropertyChangedSignal("Name"):Connect(v51);
    u35:GetPropertyChangedSignal("TeamColor"):Connect(v51);
    u35:GetAttributeChangedSignal("TeamStatChanged"):Connect(function() --[[ Name: UpdateStatsDisplay, Line 266 ]]
        -- upvalues: u40 (copy)
        for _, v52 in ipairs(u40) do
            v52();
        end;
    end);
    v49();
    local v53 = u35:GetAttribute("PlayersIn");
    u37.Name = u35.TeamColor.Name;
    l__TeamName__22.Text = `[{v53 or #u35:GetPlayers()}] {u35.Name}`;
    u38.BackgroundColor3 = u35.TeamColor.Color;
    for _, v54 in ipairs(u40) do
        v54();
    end;
    u37.LayoutOrder = u35:GetAttribute("Priority") or p36;
    u38.Parent = u37;
    u38.LayoutOrder = -1000000000;
    return u37, u38;
end;
return u2;