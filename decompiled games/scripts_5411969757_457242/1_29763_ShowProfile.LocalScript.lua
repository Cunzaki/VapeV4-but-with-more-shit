-- Decompiled with Potassium's decompiler.

local _ = game:GetService("Players").LocalPlayer;
local l__Profile__1 = script:WaitForChild("Profile");
local l__Container__2 = script.Parent:WaitForChild("Container");
local l__PlayerProfile__3 = game:WaitForChild("ReplicatedStorage"):WaitForChild("PlayerProfile");
local function u10(p1) --[[ Line: 30 ]]
    -- upvalues: l__Container__2 (copy), l__Profile__1 (copy), l__PlayerProfile__3 (copy)
    l__Container__2:ClearAllChildren();
    local v2 = l__Profile__1:Clone();
    local v3 = game:GetService("HttpService"):GenerateGUID(false);
    local l__Container__4 = v2:WaitForChild("Container");
    local l__Loading__5 = l__Container__4:WaitForChild("Loading");
    local l__Close__6 = l__Container__4:WaitForChild("Close");
    local l__PlayerData__7 = l__Container__4:WaitForChild("Stats"):WaitForChild("Top"):WaitForChild("PlayerData");
    local l__Group__8 = l__Container__4:WaitForChild("Stats"):WaitForChild("Top"):WaitForChild("Group");
    local l__Bottom__9 = l__Container__4:WaitForChild("Stats"):WaitForChild("Stats"):WaitForChild("Bottom");
    local l__ProfileVisits__10 = l__Container__4:WaitForChild("Stats"):WaitForChild("Stats"):WaitForChild("Top"):WaitForChild("ProfileVisits");
    local l__PrimaryGroupName__11 = p1:WaitForChild("PrimaryGroupName");
    local l__PrimaryGroupRank__12 = p1:WaitForChild("PrimaryGroupRank");
    local l__PrimaryGroupImage__13 = p1:WaitForChild("PrimaryGroupImage");
    v2.Parent = l__Container__2;
    v2.Name = v3;
    l__Close__6.MouseButton1Click:Connect(function() --[[ Line: 50 ]]
        -- upvalues: l__Container__2 (ref)
        l__Container__2:ClearAllChildren();
    end);
    v2:TweenPosition(UDim2.fromScale(0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.1, true);
    l__Loading__5:WaitForChild("LoadingScript").Enabled = true;
    local l__Name__14 = p1.Name;
    local l__DisplayName__15 = p1.DisplayName;
    local v4 = l__PlayerProfile__3:InvokeServer(p1);
    if v4 ~= nil and (v2 ~= nil and l__Container__2:FindFirstChild(v3) ~= nil) then
        l__Loading__5:Destroy();
        local l__DisplayName__16 = l__PlayerData__7:WaitForChild("DisplayName");
        if l__DisplayName__15 == "" then
            l__DisplayName__15 = l__Name__14;
        end;
        l__DisplayName__16.Text = l__DisplayName__15;
        l__PlayerData__7:WaitForChild("Username").Text = `@{l__Name__14}`;
        l__PlayerData__7:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("ImageLabel").Image = `rbxthumb://type=AvatarHeadShot&id={p1.UserId}&w=420&h=420`;
        local v5 = l__PrimaryGroupName__11.Value ~= "-";
        l__Group__8:WaitForChild("NO").Visible = not v5;
        l__Group__8:WaitForChild("Frame").Visible = v5;
        if v5 == true then
            l__Group__8:WaitForChild("Frame"):WaitForChild("ImageLabel").Image = l__PrimaryGroupImage__13.Value;
            l__Group__8:WaitForChild("Frame"):WaitForChild("TextHolder"):WaitForChild("RankName").Text = l__PrimaryGroupRank__12.Value;
            l__Group__8:WaitForChild("Frame"):WaitForChild("TextHolder"):WaitForChild("GroupName").Text = l__PrimaryGroupName__11.Value;
        end;
        l__ProfileVisits__10:WaitForChild("Quantity").Text = v4.pfvisits;
        local l__kills__17 = v4.stats.kills;
        local l__deaths__18 = v4.stats.deaths;
        l__Bottom__9:WaitForChild("KILLS"):WaitForChild("Container"):WaitForChild("Value").Text = tostring(l__kills__17);
        l__Bottom__9:WaitForChild("DEATHS"):WaitForChild("Container"):WaitForChild("Value").Text = tostring(l__deaths__18);
        l__Bottom__9:WaitForChild("DAMAGE"):WaitForChild("Container"):WaitForChild("Value").Text = tostring(v4.stats.damage);
        l__Bottom__9:WaitForChild("HEALING"):WaitForChild("Container"):WaitForChild("Value").Text = tostring(v4.stats.heals);
        local l__Value__19 = l__Bottom__9:WaitForChild("KDR"):WaitForChild("Container"):WaitForChild("Value");
        local v6 = l__deaths__18 == 0 and l__kills__17 and l__kills__17 or l__kills__17 / l__deaths__18;
        if v6 == v6 then
            if v6 ~= (1 / 0) then
                l__kills__17 = v6;
            end;
        end;
        l__Value__19.Text = string.format("%.2f", l__kills__17);
        local l__Value__20 = l__Bottom__9:WaitForChild("TIMEPLAYED"):WaitForChild("Container"):WaitForChild("Value");
        local l__playtime__21 = v4.stats.playtime;
        local v7 = math.floor(l__playtime__21 / 3600);
        local v8 = math.floor(l__playtime__21 % 3600 / 60);
        local v9;
        if v7 > 0 then
            v9 = string.format("%02dh %02dm", v7, v8);
        else
            v9 = string.format("%02dm", v8);
        end;
        l__Value__20.Text = v9;
    end;
end;
script.Parent:WaitForChild("SeeProfileEvent").Event:Connect(function(p11) --[[ Line: 90 ]]
    -- upvalues: u10 (copy)
    u10(p11);
end);