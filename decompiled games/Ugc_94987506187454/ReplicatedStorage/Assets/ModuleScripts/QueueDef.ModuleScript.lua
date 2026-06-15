-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.QueueDef
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__CEnum__2 = require(l__ModuleScripts__1.CEnum);
local l__LevelService__3 = require(l__ModuleScripts__1.LevelService);
local l__ModesDef__4 = require(l__ModuleScripts__1.ModesDef);
local u1 = table.freeze({
    "display_name",
    "description",
    "required_slot_size",
    "slots_per_match",
    "thumbnail"
});
local function v8(p2) --[[ Line: 124 ]]
    -- upvalues: l__ModesDef__4 (copy), u1 (copy)
    local v3 = l__ModesDef__4.getDef(p2.mode_id);
    local v4 = {
        mode_def = v3
    };
    for v5, v6 in p2 do
        v4[v5] = v6;
    end;
    for _, v7 in u1 do
        if v4[v7] == nil then
            v4[v7] = v3[v7];
        end;
    end;
    return table.freeze(v4);
end;
local v9 = {};
local u19 = {
    level = {
        aggregation = "average",
        getter = function(p10, p11) --[[ Name: getter, Line 46 ]]
            -- upvalues: l__LevelService__3 (copy)
            local _, v12 = p11.ProfileManager:getProfileValue(p10, "total_xp"):await();
            return l__LevelService__3.getLevelFromXP(v12);
        end,
        comparator = function(p13, p14, p15) --[[ Name: comparator, Line 50 ]]
            local v16 = math.abs(p13 - p14);
            local v17 = math.min(5 + p15 * 20, 100);
            local v18 = p13 < 30 ~= (p14 < 30) and 15 or v17;
            return v18 <= v16 and 0 or (1 - v16 / v18) * 0.5 + 0.5;
        end
    },
    never = {
        aggregation = "average",
        getter = function(_, _) --[[ Name: getter, Line 76 ]]
            return 1;
        end,
        comparator = function(_, _, _) --[[ Name: comparator, Line 79 ]]
            return 0;
        end
    },
    always = {
        aggregation = "average",
        getter = function(_, _) --[[ Name: getter, Line 85 ]]
            return 1;
        end,
        comparator = function(_, _, _) --[[ Name: comparator, Line 88 ]]
            return 1;
        end
    }
};
for v20, v21 in table.freeze({
    [l__CEnum__2.Queues.Duels1v1] = {
        heartbeat_interval = 8,
        pair_quality_threshold = 0.5,
        queue_id = l__CEnum__2.Queues.Duels1v1,
        mode_id = l__CEnum__2.Gamemodes.Stocks1v1,
        variables = { "level" }
    },
    [l__CEnum__2.Queues.Wingman2v2] = {
        heartbeat_interval = 4,
        pair_quality_threshold = 0.5,
        queue_id = l__CEnum__2.Queues.Wingman2v2,
        mode_id = l__CEnum__2.Gamemodes.Stocks2v2,
        variables = { "level" }
    }
}) do
    v9[v20] = v8(v21);
end;
local u22 = table.freeze(v9);
local v29 = {
    getDef = function(p23) --[[ Name: getDef, Line 156 ]]
        -- upvalues: u22 (copy), l__CEnum__2 (copy)
        local v24;
        if type(p23) == "number" then
            v24 = u22[p23];
        else
            v24 = l__CEnum__2.Queues[p23];
            if v24 then
                v24 = u22[v24];
            end;
        end;
        local l__format__5 = string.format;
        local v25 = tostring(p23);
        assert(v24, l__format__5("[QueueDef] Unknown queue_variant: %q", v25));
        return v24;
    end,
    getVariable = function(p26) --[[ Name: getVariable, Line 170 ]]
        -- upvalues: u19 (copy)
        local v27 = u19[p26];
        local l__format__6 = string.format;
        local v28 = tostring(p26);
        assert(v27, l__format__6("[QueueDef] Unknown variable key: %q", v28));
        return v27;
    end,
    getAllDefs = function() --[[ Name: getAllDefs, Line 176 ]]
        -- upvalues: u22 (copy)
        return u22;
    end,
    MAXIMUM_SLOT_SIZE = 0
};
for _, v30 in u22 do
    if v30.required_slot_size > v29.MAXIMUM_SLOT_SIZE then
        v29.MAXIMUM_SLOT_SIZE = v30.required_slot_size;
    end;
end;
return v29;
