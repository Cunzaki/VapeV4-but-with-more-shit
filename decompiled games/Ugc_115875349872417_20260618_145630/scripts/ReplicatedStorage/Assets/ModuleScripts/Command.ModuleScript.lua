-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Command
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
                end;
                local v7 = {};
                for _, v8 in v1 do
                    table.insert(v7, v8.name);
                end;
                return v7;
            end()
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
local function v18() --[[ Line: 15 ]]
    -- upvalues: l__CEnum__2 (copy)
    local v11 = {};
    for v12, v13 in l__CEnum__2.Skins do
        if typeof(v12) == "string" and typeof(v13) == "number" then
            table.insert(v11, {
                name = v12,
                value = v13
            });
        end;
    end;
    table.sort(v11, function(p14, p15) --[[ Line: 26 ]]
        return p14.value < p15.value;
    end;
    local v16 = {};
    for _, v17 in v11 do
        table.insert(v16, v17.name);
    end;
    return v16;
end;
local v19 = {
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
    permissions = { "admin", "high_moderator" }
};
local v20 = {};
local v21 = {
    command_name = "LoadMap"
};
local v22 = {};
local v23 = {
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
    permissions = { "admin" }
};
local v24 = {
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
    permissions = { "admin", "high_moderator" }
};
local v25 = {
    command_name = "ResetOwnedItems",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "admin", "high_moderator" }
};
local v26 = {
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
local v27 = {
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
    permissions = { "admin", "moderator", "high_moderator" }
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
    permissions = { "admin", "high_moderator" }
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
    permissions = { "admin", "moderator", "high_moderator" }
};
local v30 = {
    command_name = "JoinPlayer",
    args = {
        {
            name = "user_id",
            arg_type = "number",
            required = false
        }
    },
    permissions = { "admin", "moderator", "high_moderator" }
};
local v31 = {
    command_name = "RefreshContracts",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = false
        }
    },
    permissions = { "admin", "high_moderator" }
};
local v32 = {
    name = "map_name",
    arg_type = "string",
    required = true
};
local v33 = {
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
    permissions = { "admin" }
};
for v34, _ in l__CEnum__2.Maps do
    table.insert(v10, v34);
end;
v32.autocomplete = v10;
v20[1] = v32;
v21.args = v20;
v21.permissions = { "admin", "high_moderator", "private_server" };
v22[1], v22[2], v22[3], v22[4], v22[5], v22[6], v22[7], v22[8], v22[9], v22[10], v22[11], v22[12], v22[13], v22[14], v22[15], v22[16] = v23, v33, v24, v19, v27, v28, v29, v30, v31, v25, v26, v9, v21, {
    command_name = "ToggleFreecam",
    args = {},
    permissions = { "admin", "moderator", "high_moderator" }
}, {
    command_name = "SpectateFirstPerson",
    args = {
        {
            name = "target",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "admin", "moderator", "high_moderator" }
}, {
    command_name = "GetItem",
    args = {
        {
            name = "item_id",
            arg_type = "string",
            required = true
        }
    },
    permissions = { "admin", "high_moderator" }
};
v22[17], v22[18], v22[19], v22[20], v22[21], v22[22], v22[23], v22[24], v22[25], v22[26], v22[27], v22[28], v22[29] = {
    command_name = "GiveSkin",
    args = {
        {
            name = "skin_id",
            arg_type = "string",
            required = true,
            autocomplete = v18()
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
            autocomplete = v18()
        }
    },
    permissions = { "admin" }
}, {
    command_name = "Kill",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        }
    },
    permissions = {
        "admin",
        "moderator",
        "high_moderator",
        "private_server"
    }
}, {
    command_name = "Heal",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        }
    },
    permissions = {
        "admin",
        "moderator",
        "high_moderator",
        "private_server"
    }
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
    permissions = {
        "admin",
        "moderator",
        "high_moderator",
        "private_server"
    }
}, {
    command_name = "Unban",
    args = {
        {
            name = "player_id",
            arg_type = "player",
            required = true
        }
    },
    permissions = { "admin" }
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
    permissions = { "admin" }
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
    permissions = {
        "admin",
        "moderator",
        "high_moderator",
        "private_server"
    }
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
    permissions = { "admin", "high_moderator", "private_server" }
}, {
    command_name = "DisableHitreg",
    args = {
        {
            name = "target_player",
            arg_type = "player",
            required = true
        },
        {
            name = "disabled",
            arg_type = "boolean",
            required = false
        }
    },
    permissions = {
        "admin",
        "moderator",
        "high_moderator",
        "private_server"
    }
}, {
    command_name = "PermaHunted",
    args = {
        {
            name = "target",
            arg_type = "player",
            required = true
        },
        {
            name = "enabled",
            arg_type = "boolean",
            required = false
        }
    },
    permissions = {
        "admin",
        "moderator",
        "high_moderator",
        "private_server"
    }
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
    permissions = { "admin", "high_moderator", "private_server" }
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
    require(game:GetService("ServerStorage").Assets.Libraries.CommandSetup).setupServerData(v22);
end;
table.freeze(v22);
return v22;
