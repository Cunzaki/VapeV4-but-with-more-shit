-- Decompiled from: ReplicatedStorage.Assets.SharedClasses.ItemRegistry
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {
    melee = {
        Nothing = true,
        Redliner = true
    },
    gun = {
        BaseGun = true,
        Castigate = true,
        Phoenix = true,
        Siege = true,
        Monarch = true
    },
    augment = {
        Grappler = true
    }
};
function u1.new() --[[ Line: 23 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1.getItemModule(_, p3, p4) --[[ Line: 29 ]]
    -- upvalues: u2 (copy)
    if u2[p3] then
        return u2[p3][p4];
    else
        return nil;
    end;
end;
function u1.getItemTypeFromID(_, p5) --[[ Line: 36 ]]
    -- upvalues: u2 (copy)
    for v6, v7 in pairs(u2) do
        for v8, _ in pairs(v7) do
            if v8 == p5 then
                return v6;
            end;
        end;
    end;
    return nil;
end;
function u1.Init(_) --[[ Line: 47 ]] end;
return u1;
