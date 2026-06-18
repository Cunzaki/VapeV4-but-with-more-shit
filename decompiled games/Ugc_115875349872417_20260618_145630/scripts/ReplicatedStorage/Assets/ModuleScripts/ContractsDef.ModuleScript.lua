-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.ContractsDef
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local function v5(p1) --[[ Line: 1 ]]
    local v2 = {
        notif_type = "GoalTracker",
        notif_appearance = "Reactive",
        layout_order = p1.layout_order or 1,
        id = p1.id,
        type = p1.type,
        title_text = p1.title_text,
        silent = p1.silent or false,
        goal_text = p1.goal_text,
        reward_text = p1.reward_text
    };
    for v3, v4 in p1 do
        v2[v3] = v4;
    end;
    return v2;
end;
local u6 = {
    flattened = {},
    daily = {
        DAILY_Login = v5({
            layout_order = 1,
            id = "DAILY_Login",
            type = "daily",
            title_text = "Log into the game!",
            silent = true,
            reward_table = {
                yen = 30000
            }
        }),
        DAILY_Clear = v5({
            layout_order = 3,
            id = "DAILY_Clear",
            type = "daily",
            title_text = "Complete all Daily Contracts!",
            silent = true,
            reward_table = {
                crimson = 100
            }
        }),
        DAILY_KillsBG = v5({
            layout_order = 2,
            id = "DAILY_KillsBG",
            type = "daily",
            title_text = "Get 25 Kills in Battlegrounds.",
            reward_table = {
                yen = 40000,
                crimson = 75
            }
        }),
        DAILY_KillstreakBG = v5({
            layout_order = 2,
            id = "DAILY_KillstreakBG",
            type = "daily",
            title_text = "Get a 5 Killstreak in Battlegrounds.",
            reward_table = {
                yen = 40000,
                crimson = 75
            }
        }),
        DAILY_PlayQueue = v5({
            layout_order = 2,
            id = "DAILY_PlayQueue",
            type = "daily",
            title_text = "Queue 6 Matches.",
            reward_table = {
                yen = 40000,
                crimson = 75
            }
        }),
        DAILY_WinQueue = v5({
            layout_order = 2,
            id = "DAILY_WinQueue",
            type = "daily",
            title_text = "Win 3 Matches.",
            reward_table = {
                yen = 40000,
                crimson = 75
            }
        })
    },
    weekly = {
        WEEKLY_Login = v5({
            layout_order = 1,
            id = "WEEKLY_Login",
            type = "weekly",
            title_text = "Log in on 4 days.",
            reward_table = {
                yen = 350000,
                crimson = 180
            }
        }),
        WEEKLY_Kills = v5({
            layout_order = 2,
            id = "WEEKLY_Kills",
            type = "weekly",
            title_text = "Get 200 kills. (Any Mode)",
            reward_table = {
                yen = 350000,
                crimson = 180
            }
        }),
        WEEKLY_Wins = v5({
            layout_order = 3,
            id = "WEEKLY_Wins",
            type = "weekly",
            title_text = "Win 20 matches.",
            reward_table = {
                yen = 350000,
                crimson = 180
            }
        })
    },
    achievement = {}
};
if game:GetService("RunService"):IsServer() then
    require(game:GetService("ServerStorage").Assets.Libraries.ContractSetup).setupServerData(u6);
end;
for v7, v8 in pairs(u6) do
    if type(v8) == "table" and (v7 ~= "getContractsByType" and v7 ~= "getAll") then
        for v9, v10 in pairs(v8) do
            u6.flattened[v9] = v10;
        end;
    end;
end;
function u6.getContractsByType(p11) --[[ Line: 157 ]]
    -- upvalues: u6 (copy)
    return u6[p11] or {};
end;
function u6.getAll() --[[ Line: 162 ]]
    -- upvalues: u6 (copy)
    return u6.flattened;
end;
return u6;
