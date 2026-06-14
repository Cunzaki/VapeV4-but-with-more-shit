-- Decompiled from: ReplicatedStorage.Modules.LootPlanTyped
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;
function u1.new(p3) --[[ Line: 42 ]]
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.Randomizer = Random.new(p3 or tick() % 1 * 10000000000);
    v4.Loot = {};
    v4.LootList = {};
    v4.LootCount = 0;
    v4.TotalChance = 0;
    return v4;
end;
function u1.AddLoot(p5, p6, p7) --[[ Line: 52 ]]
    p5.Loot[p6] = {
        name = p6,
        chance = p7
    };
    p5.LootCount = p5.LootCount + 1;
    p5.TotalChance = p5.TotalChance + p7;
    p5:_updateLootList();
    return p5;
end;
function u1.AddLootFromTable(p8, p9) --[[ Line: 64 ]]
    for v10, v11 in p9 do
        p8:AddLoot(v10, v11);
    end;
    return p8;
end;
function u1.GetLootChance(p12, p13) --[[ Line: 71 ]]
    local v14 = p12.Loot[p13];
    if v14 then
        return v14.chance;
    end;
    error("Loot with name \'" .. tostring(p13) .. "\' does not exist");
end;
function u1.GetTrueLootChance(p15, p16) --[[ Line: 80 ]]
    local v17 = p15.Loot[p16];
    if v17 then
        return v17.chance / p15.TotalChance * 100;
    end;
    error("Loot with name \'" .. tostring(p16) .. "\' does not exist");
end;
function u1.RemoveLoot(p18, p19) --[[ Line: 89 ]]
    local v20 = p18.Loot[p19];
    if v20 then
        p18.TotalChance = p18.TotalChance - v20.chance;
        p18.LootCount = p18.LootCount - 1;
        p18.Loot[p19] = nil;
        p18:_updateLootList();
    end;
end;
function u1.ChangeLootChance(p21, p22, p23) --[[ Line: 99 ]]
    local v24 = p21.Loot[p22];
    if v24 then
        p21.TotalChance = p21.TotalChance + (p23 - v24.chance);
        v24.chance = p23;
        p21:_updateLootList();
        return v24;
    end;
    error("Loot with name \'" .. tostring(p22) .. "\' does not exist");
end;
function u1.GetRandomLoot(p25, p26) --[[ Line: 111 ]]
    local v27 = p26 or 1;
    local v28 = nil;
    if v27 >= 1 then
        local v29 = p25.Randomizer:NextNumber();
        local v30 = 0;
        for _, v31 in p25.LootList do
            local v32 = v31.chance * v27;
            if v29 < (v32 + v30) / p25.TotalChance then
                return v31.name;
            end;
            v30 = v30 + v32;
        end;
        return v28;
    end;
    local v33 = 1 / v27;
    local v34 = p25.Randomizer:NextNumber();
    local v35 = 0;
    for v36 = p25.LootCount, 1, -1 do
        local v37 = p25.LootList[v36];
        local v38 = v37.chance * v33;
        if v34 < (v38 + v35) / p25.TotalChance then
            return v37.name;
        end;
        v35 = v35 + v38;
    end;
    return v28;
end;
function u1._updateLootList(p39) --[[ Line: 142 ]]
    local v40 = {};
    for _, v41 in p39.Loot do
        table.insert(v40, v41);
    end;
    table.sort(v40, function(p42, p43) --[[ Line: 149 ]]
        return p42.chance < p43.chance;
    end);
    p39.LootList = v40;
    return p39;
end;
function u2.new(p44) --[[ Line: 160 ]]
    -- upvalues: u2 (copy)
    local v45 = setmetatable({}, u2);
    v45.Randomizer = Random.new(p44 or tick() % 1 * 10000000000);
    v45.Loot = {};
    return v45;
end;
function u2.AddLoot(p46, p47, p48) --[[ Line: 167 ]]
    local v49 = {
        name = p47,
        chance = p48
    };
    p46.Loot[p47] = v49;
    return v49;
end;
function u2.AddLootFromTable(p50, p51) --[[ Line: 176 ]]
    for v52, v53 in p51 do
        p50:AddLoot(v52, v53);
    end;
end;
function u2.GetLootChance(p54, p55) --[[ Line: 182 ]]
    local v56 = p54.Loot[p55];
    if v56 then
        return v56.chance;
    end;
    error("Loot with name \'" .. tostring(p55) .. "\' does not exist");
end;
function u2.RemoveLoot(p57, p58) --[[ Line: 191 ]]
    p57.Loot[p58] = nil;
end;
function u2.ChangeLootChance(p59, p60, p61) --[[ Line: 195 ]]
    local v62 = p59.Loot[p60];
    if v62 then
        v62.chance = p61;
    else
        error("Loot with name \'" .. tostring(p60) .. "\' does not exist");
    end;
end;
function u2.GetRandomLoot(p63, p64, p65) --[[ Line: 204 ]]
    local v66 = {};
    for _ = 1, p65 or 1 do
        for v67, v68 in p63.Loot do
            if p63.Randomizer:NextNumber() < v68.chance / 100 * (p64 or 1) then
                v66[v67] = v66[v67] and (v66[v67] + 1 or 1) or 1;
            end;
        end;
    end;
    return v66;
end;
return {
    newSingle = u1.new,
    newMulti = u2.new
};
