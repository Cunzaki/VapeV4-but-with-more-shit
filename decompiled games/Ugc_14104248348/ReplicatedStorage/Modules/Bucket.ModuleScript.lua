-- Decompiled from: ReplicatedStorage.Modules.Bucket
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.pool = {};
    v3.items = p2;
    v3.maxStackAttempts = 10;
    v3:Replenish();
    return v3;
end;
function u1.Replenish(p4) --[[ Line: 13 ]]
    local v5 = {};
    for v6, v7 in ipairs(p4.items) do
        v5[v6] = v7;
    end;
    p4.pool = v5;
end;
function u1.GetRandom(_, p8, p9, p10) --[[ Line: 22 ]]
    if p10 then
        if p8 == p9 then
            return p8;
        elseif p9 - p8 == 1 then
            if p8 == p10 then
                p8 = p9 or p8;
            end;
            return p8;
        else
            local v11 = math.random(p8, p9);
            if v11 == p10 then
                return v11 == p9 and p9 - 1 or v11 + 1;
            else
                return v11;
            end;
        end;
    else
        return math.random(p8, p9);
    end;
end;
function u1.Next(p12, p13) --[[ Line: 40 ]]
    return p12:__Next(p13);
end;
function u1.__IsBoolPcalled(_, u14, ...) --[[ Line: 44 ]]
    local u15 = { ... };
    return pcall(function() --[[ Line: 46 ]]
        -- upvalues: u14 (copy), u15 (copy)
        return u14(table.unpack(u15));
    end);
end;
function u1.__Next(p16, p17, p18) --[[ Line: 52 ]]
    -- upvalues: u1 (copy)
    if #p16.pool == 0 then
        p16:Replenish();
    end;
    local v19 = u1:GetRandom(1, #p16.pool, p16.lastPoolIndex);
    local v20 = p16.pool[v19];
    p16.lastPoolIndex = v19;
    if not p17 or (p18 or 0) > p16.maxStackAttempts then
        table.remove(p16.pool, v19);
        return v20;
    end;
    if not p16:__IsBoolPcalled(p17, v20) and #p16.pool ~= 1 then
        return p16:__Next(p17, (p18 or 0) + 1);
    end;
    table.remove(p16.pool, v19);
    return v20;
end;
return u1;
