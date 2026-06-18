-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.ModesDef
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__CEnum__2 = require(l__ModuleScripts__1.CEnum);
local u1 = table.freeze({
    [l__CEnum__2.Gamemodes.Stocks1v1] = {
        display_name = "1V1 DUELS",
        description = "You versus another. 5 lives to prove it.",
        required_slot_size = 1,
        slots_per_match = 2,
        thumbnail = "rbxassetid://79933507017375",
        usable_in_customs = true,
        progression_enabled = true,
        mode_id = l__CEnum__2.Gamemodes.Stocks1v1,
        active_map_pool = { l__CEnum__2.Maps.Highrise, l__CEnum__2.Maps.Kabuki, l__CEnum__2.Maps.Arc },
        eligible_maps = { l__CEnum__2.Maps.Highrise, l__CEnum__2.Maps.Kabuki, l__CEnum__2.Maps.Arc }
    },
    [l__CEnum__2.Gamemodes.Stocks2v2] = {
        display_name = "2V2 WINGMAN",
        description = "You and an ally fight two others. 4 lives.",
        required_slot_size = 2,
        slots_per_match = 2,
        thumbnail = "rbxassetid://134627995784353",
        usable_in_customs = true,
        progression_enabled = true,
        mode_id = l__CEnum__2.Gamemodes.Stocks2v2,
        active_map_pool = { l__CEnum__2.Maps.Metro },
        eligible_maps = { l__CEnum__2.Maps.Metro }
    },
    [l__CEnum__2.Gamemodes.Tutorial] = {
        display_name = "TUTORIAL",
        description = "Learn the game.",
        required_slot_size = 1,
        slots_per_match = 1,
        thumbnail = "rbxassetid://128990954175604",
        usable_in_customs = false,
        progression_enabled = false,
        direct_joinable = true,
        progression_source = "tutorial",
        mode_id = l__CEnum__2.Gamemodes.Tutorial,
        active_map_pool = { l__CEnum__2.Maps.Tutorial },
        eligible_maps = { l__CEnum__2.Maps.Tutorial },
        default_map = l__CEnum__2.Maps.Tutorial
    },
    [l__CEnum__2.Gamemodes.Training] = {
        display_name = "TRAINING",
        description = "No pressure. Just practice.",
        required_slot_size = 1,
        slots_per_match = 1,
        thumbnail = "rbxassetid://101174142056139",
        usable_in_customs = false,
        progression_enabled = false,
        direct_joinable = true,
        progression_source = "training",
        mode_id = l__CEnum__2.Gamemodes.Training,
        active_map_pool = { l__CEnum__2.Maps.TrainingV1 },
        eligible_maps = { l__CEnum__2.Maps.TrainingV1 },
        default_map = l__CEnum__2.Maps.TrainingV1
    }
});
local u4 = {
    RANDOM_MAP = "Random",
    tryGetDef = function(p2) --[[ Name: tryGetDef, Line 77 ]]
        -- upvalues: u1 (copy), l__CEnum__2 (copy)
        local v3 = nil;
        if type(p2) == "number" then
            return u1[p2];
        end;
        if type(p2) == "string" then
            v3 = l__CEnum__2.Gamemodes[p2];
            if v3 then
                v3 = u1[v3];
            end;
        end;
        return v3;
    end
};
function u4.getDef(p5) --[[ Line: 90 ]]
    -- upvalues: u4 (copy)
    local v6 = u4.tryGetDef(p5);
    local l__format__3 = string.format;
    local v7 = tostring(p5);
    assert(v6, l__format__3("[ModeDef] Unknown mode_variant: %q", v7));
    return v6;
end;
function u4.isProgressionEnabled(p8) --[[ Line: 96 ]]
    -- upvalues: u4 (copy)
    local v9 = u4.tryGetDef(p8);
    local v10;
    if v9 == nil then
        v10 = false;
    else
        v10 = v9.progression_enabled == true;
    end;
    return v10;
end;
function u4.isDirectJoinable(p11) --[[ Line: 101 ]]
    -- upvalues: u4 (copy)
    local v12 = u4.tryGetDef(p11);
    local v13;
    if v12 == nil then
        v13 = false;
    else
        v13 = v12.direct_joinable == true;
    end;
    return v13;
end;
function u4.getAllDefs() --[[ Line: 107 ]]
    -- upvalues: u1 (copy)
    return u1;
end;
function u4.getCustomDefs() --[[ Line: 111 ]]
    -- upvalues: u1 (copy)
    local v14 = {};
    for _, v15 in u1 do
        if v15.usable_in_customs then
            table.insert(v14, v15);
        end;
    end;
    table.sort(v14, function(p16, p17) --[[ Line: 120 ]]
        return p16.mode_id < p17.mode_id;
    end);
    return v14;
end;
function u4.isEligibleCustomMap(p18, p19) --[[ Line: 127 ]]
    -- upvalues: u4 (copy)
    local v20 = u4.getDef(p18);
    return p19 == u4.RANDOM_MAP and true or table.find(v20.eligible_maps, p19) ~= nil;
end;
u4.MAXIMUM_SLOT_SIZE = 0;
for _, v21 in u1 do
    if v21.required_slot_size > u4.MAXIMUM_SLOT_SIZE then
        u4.MAXIMUM_SLOT_SIZE = v21.required_slot_size;
    end;
end;
return u4;
