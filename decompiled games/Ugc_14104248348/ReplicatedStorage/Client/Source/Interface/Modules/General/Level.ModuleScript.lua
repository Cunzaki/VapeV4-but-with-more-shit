-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.Level
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Numerics__4 = require(l__ReplicatedStorage__1.Modules.Numerics);
local l__Leveler__5 = require(l__ReplicatedStorage__1.Modules.Leveler);
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__7 = require(l__ReplicatedStorage__1.Modules.Unify);
local u1 = l__Mince__6:Get("InterfaceHandler");
local u2 = l__Mince__6:Get("UserProfile");
local u3 = {
    OtherStates = { "LevelFrame", "StatFrame" },
    LevelObjects = {},
    StatObjects = {},
    StatsUpdate = {},
    StatsConfig = {
        { "Time Played", "TimePlayed" },
        { "Robux Donated", "RobuxDonated" },
        { "Robux Received", "RobuxReceived" },
        { "Drinks Drank", "DrinksDrank" },
        { "Minigames Won", "MinigamesWon" },
        { "Total Gained Coins", "TotalGainedCoins" },
        { "Total Opened Lootboxes", "TotalOpenedLootboxes" }
    },
    JoinedOn = l__Unify__7.GetServerTime(),
    ProgressTween = TweenInfo.new(0.3)
};
function u3.StatsUpdate.RobuxDonated(_, p4) --[[ Line: 36 ]]
    -- upvalues: l__Numerics__4 (copy), l__Mince__6 (copy)
    p4.UI.StatValue.Text = l__Numerics__4.TruncateNumber((l__Mince__6.Config.LocalProfile.RobuxDonated or 0) + (l__Mince__6.Config.LocalProfile.Statistics.RobuxDonated or 0), 1);
end;
function u3.StatsUpdate.RobuxReceived(_, p5) --[[ Line: 42 ]]
    -- upvalues: l__Numerics__4 (copy), l__Mince__6 (copy)
    p5.UI.StatValue.Text = l__Numerics__4.TruncateNumber(l__Mince__6.Config.LocalProfile.Statistics.RobuxReceived or 0, 1);
end;
function u3.StatsUpdate.TotalOpenedLootboxes(_, p6) --[[ Line: 47 ]]
    -- upvalues: l__Numerics__4 (copy), l__Mince__6 (copy)
    p6.UI.StatValue.Text = l__Numerics__4.WithCommas(l__Mince__6.Config.LocalProfile.Statistics.Total_Opened_Lootboxes or 0);
end;
function u3.StatsUpdate.TotalGainedCoins(_, p7) --[[ Line: 51 ]]
    -- upvalues: l__Numerics__4 (copy), l__Mince__6 (copy)
    p7.UI.StatValue.Text = l__Numerics__4.TruncateNumber(l__Mince__6.Config.LocalProfile.Statistics.Total_Gained_Coins or 0, 1);
end;
function u3.StatsUpdate.MinigamesWon(_, p8) --[[ Line: 55 ]]
    -- upvalues: l__Numerics__4 (copy), l__Mince__6 (copy)
    p8.UI.StatValue.Text = l__Numerics__4.WithCommas(l__Mince__6.Config.LocalProfile.Statistics.MinigamesWon or 0);
end;
function u3.StatsUpdate.DrinksDrank(_, p9) --[[ Line: 59 ]]
    -- upvalues: l__Numerics__4 (copy), l__Mince__6 (copy)
    p9.UI.StatValue.Text = l__Numerics__4.WithCommas(l__Mince__6.Config.LocalProfile.Statistics.DrinksDrank or 0);
end;
function u3.StatsUpdate.TimePlayed(_, p10) --[[ Line: 63 ]]
    -- upvalues: l__Unify__7 (copy), u3 (copy), l__Mince__6 (copy)
    local v11 = l__Unify__7.GetStandardTimeFrom(u3.JoinedOn);
    local v12 = math.floor(l__Mince__6.Config.LocalProfile.TotalPlayTime + v11);
    p10.UI.StatValue.Text = l__Unify__7.AbbreviatedTime(v12);
end;
function u3.SwitchToScreen(p13) --[[ Line: 70 ]]
    -- upvalues: u3 (copy)
    for _, v14 in u3.OtherStates do
        u3.UI.TweenFrame.Scroll[v14].Visible = v14 == p13;
    end;
end;
function u3.GetLevel(p15) --[[ Line: 77 ]]
    -- upvalues: u3 (copy)
    return u3.LevelObjects[p15];
end;
function u3.UpdateLevels(p16) --[[ Line: 81 ]]
    -- upvalues: u3 (copy)
    for v17, v23 in p16 do
        local v19 = u3.LevelObjects[v17];
        if v19 then
            local v20 = v19.Leveler.ConvertXPToLevel(v23);
            v19.Leveler.ConvertLeveltoXP(v20 + 1);
            local v21 = v19.Leveler.ConvertLeveltoXP(v20);
            local _ = v19.Leveler.ConvertXPtoLevelFloat(v23) % 1;
            if v20 > 1 then
                local v22 = v19.Leveler.ConvertLeveltoXP(v20 - 1);
                local v23 = v23 - v22;
                v21 = v21 - v22;
            end;
            v19.ThisXP = v23;
            v19.CurrentLevel = v20;
            v19.UI.Visible = true;
            v19:Update(v23, v21, v20);
        end;
    end;
end;
function u3.SetupUI() --[[ Line: 112 ]]
    -- upvalues: u3 (copy), u1 (copy), l__RunService__3 (copy), l__ReplicatedStorage__1 (copy), l__Mince__6 (copy), l__Leveler__5 (copy), l__TweenService__2 (copy)
    local l__TweenFrame__8 = u3.UI.TweenFrame;
    local v24 = u1.NewButton(l__TweenFrame__8.CloseButton);
    local v25 = u1.NewButton(l__TweenFrame__8.Options.Stats);
    local v26 = u1.NewButton(l__TweenFrame__8.Options.Levels);
    v25.Activated:Connect(function() --[[ Line: 121 ]]
        -- upvalues: u3 (ref)
        u3.SwitchToScreen("StatFrame");
    end, {
        Multiplier = 0.0025
    });
    v26.Activated:Connect(function() --[[ Line: 124 ]]
        -- upvalues: u3 (ref)
        u3.SwitchToScreen("LevelFrame");
    end, {
        Multiplier = 0.0025
    });
    v24.Activated:Connect(u3.UI.Trigger);
    local u27 = nil;
    u3.UI.Closed:Connect(function() --[[ Line: 131 ]]
        -- upvalues: u27 (ref)
        if u27 then
            u27:Disconnect();
        end;
    end);
    u3.UI.Opened:Connect(function() --[[ Line: 135 ]]
        -- upvalues: u27 (ref), l__RunService__3 (ref), u3 (ref)
        if u27 then
            u27:Disconnect();
        end;
        u27 = l__RunService__3.Heartbeat:Connect(function(p28) --[[ Line: 137 ]]
            -- upvalues: u3 (ref)
            for v29, v30 in u3.StatsUpdate do
                if u3.StatsConfig[v29] then
                    v30(p28, u3.StatsConfig[v29]);
                end;
            end;
        end);
    end);
    for _, v31 in ipairs(u3.StatsConfig) do
        local v32, v33 = table.unpack(v31);
        v31.UI = l__ReplicatedStorage__1.Assets.Interface.StatItem:Clone();
        v31.UI.StatName.Text = v32;
        v31.UI.Parent = l__TweenFrame__8.Scroll.StatFrame;
        u3.StatsConfig[v33] = v31;
    end;
    for v34, u35 in l__Mince__6.Config.Levels do
        u35.Leveler = l__Leveler__5.new(u35.Balance);
        u35.UI = l__ReplicatedStorage__1.Assets.Interface.LevelItem:Clone();
        u35.UI.Descriptor.Text = u35.Description;
        u35.UI.LevelTitle.Text = u35.Name;
        u35.UI.LayoutOrder = u35.Order or 0;
        u35.UI.ProgressBar.CompleteLabel.Text = "Loading...";
        u35.UI.ProgressBar.Fill.Size = UDim2.fromScale(0.5, 1);
        function u35.Update(_, p36, p37, p38) --[[ Line: 171 ]]
            -- upvalues: u35 (copy), u3 (ref), l__TweenService__2 (ref)
            local v39 = p36 / p37;
            if u35.MaxLevel <= p38 then
                u35.UI.LevelText.Text = `Lvl. {p38}(MAX)`;
                u35.UI.ProgressBar.CompleteLabel.Text = "MAXIMUM";
                u35.UI.ProgressBar.Fill.Size = UDim2.fromScale(1, 1);
            else
                u35.UI.LevelText.Text = `Lvl. {p38}`;
                u35.UI.ProgressBar.CompleteLabel.Text = `{math.floor(p36)} / {p37}`;
                local v40 = math.clamp(v39, 0.05, 1);
                if u3.UI.IsActive then
                    l__TweenService__2:Create(u35.UI.ProgressBar.Fill, u3.ProgressTween, {
                        Size = UDim2.fromScale(v40, 1)
                    }):Play();
                else
                    u35.UI.ProgressBar.Fill.Size = UDim2.fromScale(v40, 1);
                end;
            end;
        end;
        u35.UI.Visible = false;
        u35.UI.Parent = l__TweenFrame__8.Scroll.LevelFrame;
        u3.LevelObjects[v34] = u35;
    end;
end;
function u3.Trigger() --[[ Line: 205 ]]
    -- upvalues: u3 (copy)
    u3.UI.Trigger();
end;
function u3.Setup() --[[ Line: 209 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    u3.UI = u1.Get("Levels");
    u3.SetupUI();
    u2.IndexUpdated("Levels"):Connect(u3.UpdateLevels);
end;
return u3;
