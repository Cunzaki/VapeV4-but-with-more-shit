-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Command
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__CEnum__2 = require(l__ModuleScripts__1.CEnum);
local l__TitleData__3 = require(l__ModuleScripts__1.TitleData);
local v9 = {
    command_name = "GiveTitle",
    args = {
        {
            name = "title_name",
            arg_type = "string",
            required = true,
            autocomplete = (function() --[[ Name: getTitleNames, Line 38 ]]
                -- upvalues: l__CEnum__2 (copy), l__TitleData__3 (copy)
                local v1 = {};
                for v2, v3 in l__CEnum__2.Titles do
                    if typeof(v2) == "string" and typeof(v3) == "number" then
                        local v4 = l__TitleData__3[v3];
                        if typeof(v4) ~= "table" or v4.hidden ~= true then
                            table.insert(v1, {
                                name = v2,
                                value = v3
                            });
                        end;
                    end;
                end;
                table.sort(v1, function(p5, p6) --[[ Line: 51 ]]
                    return p5.value < p6.value;
                end);
                local v7 = {};
                for _, v8 in v1 do
                    table.insert(v7, v8.name);
                end;
                return v7;
            end)()
        },
        {
            name = "target",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "admin" }
};
local v10 = {};
local v11 = {
    command_name = "GiveCrimson",
    args = {
        {
            name = "amount",
            arg_type = "number",
            required = true
        },
        {
            name = "player_to_give",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "admin" }
};
local function v19() --[[ Line: 15 ]]
    -- upvalues: l__CEnum__2 (copy)
    local v12 = {};
    for v13, v14 in l__CEnum__2.Skins do
        if typeof(v13) == "string" and typeof(v14) == "number" then
            table.insert(v12, {
                name = v13,
                value = v14
            });
        end;
    end;
    table.sort(v12, function(p15, p16) --[[ Line: 26 ]]
        return p15.value < p16.value;
    end);
    local v17 = {};
    for _, v18 in v12 do
        table.insert(v17, v18.name);
    end;
    return v17;
end;
local v20 = {
    command_name = "SilenceReports",
    args = {
        {
            name = "target_id",
            arg_type = "number",
            required = true
        },
        {
            name = "true_or_false",
            arg_type = "boolean",
            required = true
        }
    },
    permissions = { "moderator", "high_moderator" }
};
local v21 = {
    command_name = "JoinPlayer",
    args = {
        {
            name = "user_id",
            arg_type = "number",
            required = false
        }
    },
    permissions = { "moderator", "high_moderator" }
};
local v22 = {
    command_name = "LoadMap"
};
local v23 = {};
local v24 = {
    command_name = "Ban",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        },
        {
            name = "duration_days",
            arg_type = "number",
            required = false,
            autocomplete = {
                1,
                7,
                31,
                365,
                -1
            }
        },
        {
            name = "reason",
            arg_type = "string",
            required = false
        }
    },
    permissions = { "high_moderator" }
};
local v25 = {
    command_name = "GiveYen",
    args = {
        {
            name = "amount",
            arg_type = "number",
            required = true
        },
        {
            name = "player_to_give",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "high_moderator" }
};
local v26 = {
    command_name = "ResetOwnedItems",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "high_moderator" }
};
local v27 = {
    command_name = "SetLevel",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        },
        {
            name = "level",
            arg_type = "number",
            required = true
        }
    },
    permissions = { "high_moderator" }
};
local v28 = {
    command_name = "ResetData",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "high_moderator" }
};
local v29 = {
    command_name = "JoinServer",
    args = {
        {
            name = "server_id",
            arg_type = "string",
            required = false
        }
    },
    permissions = { "moderator", "high_moderator" }
};
local v30 = {
    command_name = "RefreshContracts",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "high_moderator" }
};
local v31 = {
    name = "map_name",
    arg_type = "string",
    required = true
};
local v32 = {};
local v33 = {
    command_name = "SetWinstreak",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        },
        {
            name = "winstreak",
            arg_type = "number",
            required = true
        }
    },
    permissions = { "high_moderator" }
};
for v34, _ in l__CEnum__2.Maps do
    table.insert(v10, v34);
end;
v31.autocomplete = v10;
v32[1] = v31;
v22.args = v32;
v22.permissions = { "high_moderator", "private_server" };
v23[1], v23[2], v23[3], v23[4], v23[5], v23[6], v23[7], v23[8], v23[9], v23[10], v23[11], v23[12], v23[13], v23[14], v23[15], v23[16] = v24, v25, v33, v27, v20, v28, v29, v21, v30, v26, v11, v9, v22, {
    command_name = "ToggleFreecam",
    args = {},
    permissions = { "moderator", "high_moderator" }
}, {
    command_name = "SpectateFirstPerson",
    args = {
        {
            name = "target",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "moderator", "high_moderator" }
}, {
    command_name = "GetItem",
    args = {
        {
            name = "item_id",
            arg_type = "string",
            required = true
        }
    },
    permissions = { "high_moderator" }
};
v23[17], v23[18], v23[19], v23[20], v23[21], v23[22], v23[23], v23[24], v23[25], v23[26], v23[27] = {
    command_name = "GiveSkin",
    args = {
        {
            name = "skin_id",
            arg_type = "string",
            required = true,
            autocomplete = v19()
        },
        {
            name = "target",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "admin" }
}, {
    command_name = "EquipSkin",
    args = {
        {
            name = "item_id",
            arg_type = "string",
            required = true
        },
        {
            name = "skin_name",
            arg_type = "string",
            required = true,
            autocomplete = v19()
        }
    },
    permissions = { "high_moderator" }
}, {
    command_name = "Kill",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "moderator", "high_moderator", "private_server" }
}, {
    command_name = "Heal",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "moderator", "high_moderator", "private_server" }
}, {
    command_name = "Tp",
    args = {
        {
            name = "player_to_tp",
            arg_type = "player",
            required = true
        },
        {
            name = "player",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "moderator", "high_moderator", "private_server" }
}, {
    command_name = "Unban",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "high_moderator" }
}, {
    command_name = "reverseModeratorActions",
    args = {
        {
            name = "user_id",
            arg_type = "number",
            required = true
        },
        {
            name = "up_until_unix",
            arg_type = "number",
            required = true
        }
    },
    permissions = {}
}, {
    command_name = "Kick",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        },
        {
            name = "server_blacklist",
            arg_type = "boolean",
            required = false
        }
    },
    permissions = { "moderator", "high_moderator", "private_server" }
}, {
    command_name = "InfBullets",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        },
        {
            name = "has_inf_bullets",
            arg_type = "boolean",
            required = true
        }
    },
    permissions = { "high_moderator", "private_server" }
}, {
    command_name = "SpawnEntity",
    args = {
        {
            name = "entity_name",
            arg_type = "string",
            required = true,
            autocomplete = { "MediumDummy", "AttackingDummyEntity", "ClashingDummy" }
        }
    },
    permissions = { "high_moderator", "private_server" }
}, {
    command_name = "GivePerms",
    args = {
        {
            name = "player",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "private_server_owner" }
};
if game:GetService("RunService"):IsServer() then
    require(game:GetService("ServerStorage").Assets.Libraries.CommandSetup).setupServerData(v23);
end;
table.freeze(v23);
return v23;
