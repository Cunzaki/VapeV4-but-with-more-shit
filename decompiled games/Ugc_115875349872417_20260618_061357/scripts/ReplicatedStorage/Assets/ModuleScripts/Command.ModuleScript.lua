-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Command
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
local v12 = {
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
local v13 = {
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
local v14 = {
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
local v15 = {
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
local v16 = {};
local v17 = {
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
local v18 = {
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
local function v26() --[[ Line: 15 ]]
    -- upvalues: l__CEnum__2 (copy)
    local v19 = {};
    for v20, v21 in l__CEnum__2.Skins do
        if typeof(v20) == "string" and typeof(v21) == "number" then
            table.insert(v19, {
                name = v20,
                value = v21
            });
        end;
    end;
    table.sort(v19, function(p22, p23) --[[ Line: 26 ]]
        return p22.value < p23.value;
    end);
    local v24 = {};
    for _, v25 in v19 do
        table.insert(v24, v25.name);
    end;
    return v24;
end;
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
    permissions = { "admin", "high_moderator" }
};
local v28 = {
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
local v29 = {
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
local v30 = {
    name = "map_name",
    arg_type = "string",
    required = true
};
local v31 = {
    command_name = "LoadMap"
};
local v32 = {};
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
v30.autocomplete = v10;
v16[1] = v30;
v31.args = v16;
v31.permissions = { "admin", "high_moderator", "private_server" };
v32[1], v32[2], v32[3], v32[4], v32[5], v32[6], v32[7], v32[8], v32[9], v32[10], v32[11], v32[12], v32[13], v32[14], v32[15], v32[16] = v17, v33, v11, v27, v13, v14, v15, v28, v29, v12, v18, v9, v31, {
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
v32[17], v32[18], v32[19], v32[20], v32[21], v32[22], v32[23], v32[24], v32[25], v32[26], v32[27], v32[28], v32[29] = {
    command_name = "GiveSkin",
    args = {
        {
            name = "skin_id",
            arg_type = "string",
            required = true,
            autocomplete = v26()
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
            autocomplete = v26()
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
    require(game:GetService("ServerStorage").Assets.Libraries.CommandSetup).setupServerData(v32);
end;
table.freeze(v32);
return v32;
