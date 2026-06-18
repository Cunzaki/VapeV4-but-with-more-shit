-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.QueueDef
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
local function v8(p2) --[[ Line: 141 ]]
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
local u22 = {
    level = {
        aggregation = "max",
        getter = function(p10, p11) --[[ Name: getter, Line 58 ]]
            -- upvalues: l__LevelService__3 (copy)
            local _, v12 = p11.ProfileManager:getProfileValue(p10, "total_xp"):await();
            return l__LevelService__3.getLevelFromXP(v12);
        end,
        comparator = function(p13, p14, p15) --[[ Name: comparator, Line 62 ]]
            local v16 = math.abs(p13 - p14);
            local v17 = math.min(5 + p15 * 20, 100);
            if p13 < 30 or p14 < 30 then
                v17 = math.min(v17, 15);
            end;
            return v17 < v16 and 0 or (1 - v16 / v17) * 0.5 + 0.5;
        end,
        raw_comparator = function(p18, p19) --[[ Name: raw_comparator, Line 77 ]]
            for _, v20 in p18 do
                for _, v21 in p19 do
                    if (v20 < 30 or v21 < 30) and math.abs(v20 - v21) > 15 then
                        return false;
                    end;
                end;
            end;
            return true;
        end
    },
    never = {
        aggregation = "average",
        getter = function(_, _) --[[ Name: getter, Line 93 ]]
            return 1;
        end,
        comparator = function(_, _, _) --[[ Name: comparator, Line 96 ]]
            return 0;
        end
    },
    always = {
        aggregation = "average",
        getter = function(_, _) --[[ Name: getter, Line 102 ]]
            return 1;
        end,
        comparator = function(_, _, _) --[[ Name: comparator, Line 105 ]]
            return 1;
        end
    }
};
for v23, v24 in table.freeze({
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
    v9[v23] = v8(v24);
end;
local u25 = table.freeze(v9);
local v32 = {
    getDef = function(p26) --[[ Name: getDef, Line 173 ]]
        -- upvalues: u25 (copy), l__CEnum__2 (copy)
        local v27;
        if type(p26) == "number" then
            v27 = u25[p26];
        else
            v27 = l__CEnum__2.Queues[p26];
            if v27 then
                v27 = u25[v27];
            end;
        end;
        local l__format__5 = string.format;
        local v28 = tostring(p26);
        assert(v27, l__format__5("[QueueDef] Unknown queue_variant: %q", v28));
        return v27;
    end,
    getVariable = function(p29) --[[ Name: getVariable, Line 187 ]]
        -- upvalues: u22 (copy)
        local v30 = u22[p29];
        local l__format__6 = string.format;
        local v31 = tostring(p29);
        assert(v30, l__format__6("[QueueDef] Unknown variable key: %q", v31));
        return v30;
    end,
    getAllDefs = function() --[[ Name: getAllDefs, Line 193 ]]
        -- upvalues: u25 (copy)
        return u25;
    end,
    MAXIMUM_SLOT_SIZE = 0
};
for _, v33 in u25 do
    if v33.required_slot_size > v32.MAXIMUM_SLOT_SIZE then
        v32.MAXIMUM_SLOT_SIZE = v33.required_slot_size;
    end;
end;
return v32;
