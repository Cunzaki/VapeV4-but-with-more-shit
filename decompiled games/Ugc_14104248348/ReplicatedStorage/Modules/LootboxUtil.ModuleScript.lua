-- Decompiled from: ReplicatedStorage.Modules.LootboxUtil
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Lootboxes__2 = require(l__ReplicatedStorage__1.Config.Shared.Lootboxes);
local l__LootPlanTyped__3 = require(l__ReplicatedStorage__1.Modules.LootPlanTyped);
local l__Inventory__4 = require(l__ReplicatedStorage__1.Config.Shared.Inventory);
local u1 = {
    Lootboxes = l__Lootboxes__2
};
function u1.GetLootbox(p2) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    return u1.Lootboxes[p2];
end;
function u1.Init() --[[ Line: 16 ]]
    -- upvalues: l__Lootboxes__2 (copy), l__LootPlanTyped__3 (copy), l__Inventory__4 (copy)
    for v3, u4 in l__Lootboxes__2 do
        local v5 = l__LootPlanTyped__3.newSingle(os.clock());
        u4.Plan = v5;
        u4.ID = v3;
        u4.Random = Random.new();
        u4.DisplayName = u4.Name or (v3 or "Lootbox.Name");
        local v6 = 0;
        for _, v7 in u4.Items do
            v6 = v6 + v7[2];
        end;
        function u4.GetIndexFromNameID(p8) --[[ Line: 29 ]]
            -- upvalues: u4 (copy)
            for v9, v10 in u4.Items do
                if v10[1] == p8 then
                    return v9;
                end;
            end;
        end;
        u4.RarityPlans = {};
        u4.Chances = {};
        for _, v11 in u4.Items do
            local v12 = {
                NumerialChance = math.ceil(1 / (v11[2] / v6)),
                Chance = v11[2] / v6,
                IVID = v11[1]
            };
            local v13 = string.split(v11[1], ".");
            local v14 = l__Inventory__4[v13[1]][v13[2]];
            v5:AddLoot(v12, v11[2]);
            if v14 and v14.Rarity then
                if not u4.RarityPlans[v14.Rarity] then
                    u4.RarityPlans[v14.Rarity] = l__LootPlanTyped__3.newSingle(os.clock());
                end;
                u4.RarityPlans[v14.Rarity]:AddLoot(v12, v11[2]);
            end;
            table.insert(u4.Chances, v12);
        end;
        table.sort(u4.Chances, function(p15, p16) --[[ Line: 64 ]]
            return p15.Chance > p16.Chance;
        end);
        function u4.RollForItem(p17, p18) --[[ Line: 69 ]]
            -- upvalues: u4 (copy)
            if p18 then
                return u4.RarityPlans[p18]:GetRandomLoot(p17 or 1);
            else
                return u4.Plan:GetRandomLoot(p17 or 1);
            end;
        end;
    end;
end;
u1.Init();
return u1;
