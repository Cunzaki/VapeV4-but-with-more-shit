-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.LevelService
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local _ = game.Players.LocalPlayer;
local u2 = table.freeze({
    MAX_LEVEL = 1000,
    MIN_LEVEL = 1,
    QUADRATIC_TERM = 4,
    LINEAR_TERM = 200,
    CONSTANT_TERM = 400
});
function u1.getXPForLevelUp(p3) --[[ Line: 20 ]]
    -- upvalues: u2 (copy)
    return u2.MAX_LEVEL <= p3 and 0 or math.floor(u2.QUADRATIC_TERM * p3 ^ 2 + u2.LINEAR_TERM * p3 + u2.CONSTANT_TERM);
end;
function u1.getCumulativeXP(p4) --[[ Line: 35 ]]
    -- upvalues: u2 (copy), u1 (copy)
    if p4 <= u2.MIN_LEVEL then
        return 0;
    end;
    local v5 = math.min(p4, u2.MAX_LEVEL);
    local v6 = 0;
    for v7 = u2.MIN_LEVEL, v5 - 1 do
        v6 = v6 + u1.getXPForLevelUp(v7);
    end;
    return v6;
end;
function u1.getLevelFromXP(p8) --[[ Line: 52 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local l__MIN_LEVEL__1 = u2.MIN_LEVEL;
    while true do
        local v9 = u1.getXPForLevelUp(l__MIN_LEVEL__1);
        if v9 == 0 then
            break;
        end;
        if p8 < v9 then
            return l__MIN_LEVEL__1, p8, v9;
        end;
        p8 = p8 - v9;
        l__MIN_LEVEL__1 = l__MIN_LEVEL__1 + 1;
        if u2.MAX_LEVEL <= l__MIN_LEVEL__1 then
            return u2.MAX_LEVEL, 0, 0;
        end;
    end;
    return u2.MAX_LEVEL, 0, 0;
end;
function u1.getProgressPercent(p10) --[[ Line: 78 ]]
    -- upvalues: u1 (copy)
    local _, v11, v12 = u1.getLevelFromXP(p10);
    return v12 <= 0 and 1 or math.clamp(v11 / v12, 0, 1);
end;
function u1.ClampLevel(p13) --[[ Line: 89 ]]
    -- upvalues: u2 (copy)
    return math.clamp(p13, u2.MIN_LEVEL, u2.MAX_LEVEL);
end;
return u1;
