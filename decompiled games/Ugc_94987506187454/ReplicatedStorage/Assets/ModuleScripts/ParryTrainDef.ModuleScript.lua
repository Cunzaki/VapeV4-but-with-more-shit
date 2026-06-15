-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.ParryTrainDef
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local l__ItemDef__1 = require(script.Parent.ItemDef);
local u1 = {
    DIFFICULTY_CONFIGS = {
        STANDARD = {
            difficulty_order = 1,
            default = true,
            start_shot_delay = 1,
            end_shot_delay = 0.6,
            delay_reduction_per_shot = 0.05,
            spawn_angle = 125
        },
        HARD = {
            difficulty_order = 2,
            start_shot_delay = 0.6,
            end_shot_delay = 0.4,
            delay_reduction_per_shot = 0.05,
            spawn_angle = 360,
            move_after_shot = 10,
            move_angle = 180
        },
        FLATLINE = {
            difficulty_order = 3,
            start_shot_delay = 0.3,
            end_shot_delay = -0,
            delay_reduction_per_shot = 0.05,
            spawn_angle = 360,
            move_angle = 180,
            upgraded_move_after_shot = 7,
            upgraded_move_angle = 360
        }
    }
};
local function u2() --[[ Line: 37 ]]
    -- upvalues: l__ItemDef__1 (copy)
    return typeof(l__ItemDef__1.getDefs) ~= "function" and (l__ItemDef__1.defs or {}) or l__ItemDef__1.getDefs();
end;
local function u15(p3, p4) --[[ Line: 58 ]]
    -- upvalues: u1 (copy)
    local v5 = u1.DIFFICULTY_CONFIGS[p3] or {};
    local v6 = u1.DIFFICULTY_CONFIGS[p4] or {};
    local v7;
    if typeof(v5) == "table" then
        v7 = v5.difficulty_order or v5.order;
        if typeof(v7) ~= "number" then
            v7 = nil;
        end;
    else
        v7 = nil;
    end;
    local v8;
    if typeof(v6) == "table" then
        v8 = v6.difficulty_order or v6.order;
        if typeof(v8) ~= "number" then
            v8 = nil;
        end;
    else
        v8 = nil;
    end;
    if v7 and (v8 and v7 ~= v8) then
        return v7 < v8;
    elseif v7 then
        return true;
    elseif v8 then
        return false;
    else
        local v9 = v5.start_shot_delay or 0;
        local v10 = v6.start_shot_delay or 0;
        if v9 == v10 then
            local v11 = v5.end_shot_delay or v9;
            local v12 = v6.end_shot_delay or v10;
            if v11 == v12 then
                local v13 = v5.spawn_angle or 360;
                local v14 = v6.spawn_angle or 360;
                if v13 == v14 then
                    return p3 < p4;
                else
                    return v13 < v14;
                end;
            else
                return v12 < v11;
            end;
        else
            return v10 < v9;
        end;
    end;
end;
function u1.getDifficulties() --[[ Line: 93 ]]
    -- upvalues: u1 (copy), u15 (copy)
    local v16 = {};
    for v17, v18 in pairs(u1.DIFFICULTY_CONFIGS) do
        if typeof(v17) == "string" and typeof(v18) == "table" then
            table.insert(v16, v17);
        end;
    end;
    table.sort(v16, u15);
    return v16;
end;
function u1.getDefaultDifficulty() --[[ Line: 106 ]]
    -- upvalues: u1 (copy)
    for v19, v20 in pairs(u1.DIFFICULTY_CONFIGS) do
        if typeof(v19) == "string" and (typeof(v20) == "table" and v20.default == true) then
            return v19;
        end;
    end;
    return u1.getDifficulties()[1];
end;
function u1.getDifficultyDisplayName(p21) --[[ Line: 116 ]]
    -- upvalues: u1 (copy)
    if typeof(p21) == "string" then
        local v22 = u1.DIFFICULTY_CONFIGS[p21];
        if typeof(v22) == "table" and typeof(v22.display_name) == "string" then
            return v22.display_name;
        else
            return p21;
        end;
    else
        return "";
    end;
end;
u1.DIFFICULTIES = u1.getDifficulties();
u1.DEFAULT_DIFFICULTY = u1.getDefaultDifficulty();
function u1.getEligibleGuns() --[[ Line: 132 ]]
    -- upvalues: u2 (copy)
    local v23 = {};
    for v24, v25 in pairs(u2()) do
        if v25.item_type == "gun" and v25.purchasable == true then
            table.insert(v23, {
                item_id = v25.item_id or v24,
                name = v25.name or v24
            });
        end;
    end;
    table.sort(v23, function(p26, p27) --[[ Line: 144 ]]
        return p26.name < p27.name;
    end);
    return v23;
end;
function u1.isValidDifficulty(p28) --[[ Line: 151 ]]
    -- upvalues: u1 (copy)
    if typeof(p28) == "string" then
        return typeof(u1.DIFFICULTY_CONFIGS[p28]) == "table";
    else
        return false;
    end;
end;
function u1.getDifficultyConfig(p29) --[[ Line: 159 ]]
    -- upvalues: u1 (copy)
    if not u1.isValidDifficulty(p29) then
        p29 = u1.getDefaultDifficulty();
    end;
    return u1.DIFFICULTY_CONFIGS[p29] or {};
end;
function u1.getDefaultConfig() --[[ Line: 167 ]]
    -- upvalues: u1 (copy)
    local v30 = u1.getDefaultDifficulty();
    for _, v31 in ipairs(u1.getEligibleGuns()) do
        if v31.item_id == "Castigate" then
            return {
                difficulty = v30,
                gun_ids = { "Castigate" }
            };
        end;
    end;
    return {
        difficulty = v30,
        gun_ids = {}
    };
end;
local function u36(p32) --[[ Line: 195 ]]
    local v33 = {};
    if typeof(p32) ~= "table" then
        return v33;
    end;
    for v34, v35 in pairs(p32) do
        if typeof(v34) == "number" and typeof(v35) == "string" then
            v33[v35] = true;
        elseif typeof(v34) == "string" and v35 == true then
            v33[v34] = true;
        end;
    end;
    return v33;
end;
function u1.sanitizeConfig(p37) --[[ Line: 213 ]]
    -- upvalues: u1 (copy), u36 (copy)
    local v38 = u1.getDefaultConfig();
    if typeof(p37) ~= "table" then
        return v38;
    end;
    local l__difficulty__2 = p37.difficulty;
    if not u1.isValidDifficulty(l__difficulty__2) then
        l__difficulty__2 = v38.difficulty;
    end;
    local v39 = p37.gun_ids or (p37.guns or p37.selected_guns);
    local v40 = (p37.gun_ids ~= nil or p37.guns ~= nil) and true or p37.selected_guns ~= nil;
    local v41 = u1.getEligibleGuns();
    local v42 = {};
    for _, v43 in ipairs(u1.getEligibleGuns()) do
        v42[v43.item_id] = true;
    end;
    local v44 = u36(v39);
    local v45 = {};
    if v40 then
        for _, v46 in ipairs(v41) do
            if v42[v46.item_id] and v44[v46.item_id] then
                table.insert(v45, v46.item_id);
            end;
        end;
    else
        v45 = v38.gun_ids;
    end;
    return {
        difficulty = l__difficulty__2,
        gun_ids = v45
    };
end;
return u1;
