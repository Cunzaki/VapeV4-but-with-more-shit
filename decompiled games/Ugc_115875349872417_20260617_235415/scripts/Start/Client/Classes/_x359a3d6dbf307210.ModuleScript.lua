-- Decompiled from: Start.Client.Classes._x359a3d6dbf307210
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ItemData__1 = script.Parent.Parent.ItemData;
local u1 = {};
u1.__index = u1;
local u2 = {
    melee = {
        Nothing = l__ItemData__1.Melee._x6047afa8f51ed482,
        Redliner = l__ItemData__1.Melee._xa7109feafc3a83d4
    },
    gun = {
        BaseGun = l__ItemData__1.Gun._xfa1dcdd390325501,
        Castigate = l__ItemData__1.Gun._x76c771649af384a3,
        Phoenix = l__ItemData__1.Gun._x6c5816f182533260,
        Siege = l__ItemData__1.Gun._x3ec03036f3c8b046,
        Monarch = l__ItemData__1.Gun._xba1cc840d551c354
    },
    augment = {
        Grappler = l__ItemData__1.Augment._xab5ce7a5f02afdd3
    }
};
function u1._xafd29f1684593d0b() --[[ Line: 34 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._x182f443a74ab6743(_, p3, p4) --[[ Line: 40 ]]
    -- upvalues: u2 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and u2[p3] then
        return u2[p3][p4];
    else
        return nil;
    end;
end;
function u1._x7f0a485cf0cab349(_, p8) --[[ Line: 47 ]]
    -- upvalues: u2 (copy)
    for v9, v10 in pairs(u2) do
        for v11, _ in pairs(v10) do
            local v12 = tostring(game.GameId);
            local v13 = 46;
            for v14 = 1, #v12 do
                v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
            end;
            if v13 == 272 and v11 == p8 then
                return v9;
            end;
        end;
    end;
    return nil;
end;
function u1._xd8041402b83e75db(_) --[[ Line: 58 ]] end;
return u1;
