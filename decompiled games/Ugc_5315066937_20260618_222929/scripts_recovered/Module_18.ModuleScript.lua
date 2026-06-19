-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tonumber;
local l__match__1 = string.match;
local v2 = _G.obtain("CustomEnums");
local l__MODE_MAIN__2 = v2.MODE_MAIN;
local l__MODE_BONUS__3 = v2.MODE_BONUS;
local u3 = {
    MapStart = l__MODE_MAIN__2,
    BonusStart = l__MODE_BONUS__3
};
local u4 = {
    MapFinish = l__MODE_MAIN__2,
    BonusFinish = l__MODE_BONUS__3
};
local u5 = {
    MapAnticheat = l__MODE_MAIN__2,
    BonusAnticheat = l__MODE_BONUS__3
};
return {
    ZoneDefCategoryZone = function(p6) --[[ Name: ZoneDefCategoryZone, Line 9 ]]
        local v7 = {};
        for v8, v9 in next, p6 do
            local v10 = {};
            for v11, v12 in next, v9 do
                v10[v12] = v11;
            end;
            v7[v8] = v10;
        end;
        return v7;
    end,
    ZoneDefObjectStart = function(p13) --[[ Name: ZoneDefObjectStart, Line 25 ]]
        -- upvalues: u3 (copy), l__match__1 (copy), u1 (copy)
        local l__Name__4 = p13.Name;
        return u3[l__Name__4] or (u1(l__match__1(l__Name__4, "^Map(%d+)Start$")) or u1(l__match__1(l__Name__4, "^MapStart(%d+)$")) or (u1(l__match__1(l__Name__4, "^Bonus(%d+)Start$")) or u1(l__match__1(l__Name__4, "^BonusStart(%d+)$"))));
    end,
    ZoneDefObjectFinish = function(p14) --[[ Name: ZoneDefObjectFinish, Line 34 ]]
        -- upvalues: u4 (copy), l__match__1 (copy), u1 (copy)
        local l__Name__5 = p14.Name;
        return u4[l__Name__5] or (u1(l__match__1(l__Name__5, "^Map(%d+)Finish$")) or u1(l__match__1(l__Name__5, "^MapFinish(%d+)$")) or (u1(l__match__1(l__Name__5, "^Bonus(%d+)Finish$")) or u1(l__match__1(l__Name__5, "^BonusFinish(%d+)$"))));
    end,
    ZoneDefObjectAnticheat = function(p15) --[[ Name: ZoneDefObjectAnticheat, Line 43 ]]
        -- upvalues: u5 (copy), l__match__1 (copy), u1 (copy)
        local l__Name__6 = p15.Name;
        return u5[l__Name__6] or (u1(l__match__1(l__Name__6, "^Map(%d+)Anticheat$")) or u1(l__match__1(l__Name__6, "^MapAnticheat(%d+)$")) or (u1(l__match__1(l__Name__6, "^Bonus(%d+)Anticheat$")) or u1(l__match__1(l__Name__6, "^BonusAnticheat(%d+)$"))));
    end
};
