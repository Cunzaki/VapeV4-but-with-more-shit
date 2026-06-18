-- Decompiled from: Start.Client.Classes._x02980fc0087c2697
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
local u1 = {
    RepBaseEntity = script.Parent.Parent.ReplicatedEntities._xc3d339874a04a532,
    RepDroneEntity = script.Parent.Parent.ReplicatedEntities._x22f554375d22973c,
    RepInteractEntity = script.Parent.Parent.ReplicatedEntities._x4e568d71221deea5,
    RepLaunchpad = script.Parent.Parent.ReplicatedEntities._x1a3d4d68c345551f,
    RepParryTrainButton = script.Parent.Parent.ReplicatedEntities._x71f68b225d2cec2a,
    RepSupportScreen = script.Parent.Parent.ReplicatedEntities._x062c72d741d69cfc,
    RepZipline = script.Parent.Parent.ReplicatedEntities._x933b1f461cd8c438
};
local u2 = {};
u2.__index = u2;
function u2._xafd29f1684593d0b() --[[ Line: 29 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._x38e62b789111a6ed = {};
    return v3;
end;
function u2._x5cd490ab68d32b11(p4, p5) --[[ Line: 37 ]]
    return p4._x38e62b789111a6ed[p5];
end;
function u2._x0f70e9454390dc59(p6, p7) --[[ Line: 41 ]]
    local v8 = p6:_x5cd490ab68d32b11(p7);
    local v9 = tostring(game.GameId);
    local v10 = 46;
    for v11 = 1, #v9 do
        v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
    end;
    if v10 == 272 and (v8 and typeof(v8._x036ad977685e1d86) == "function") then
        return v8:_x036ad977685e1d86() or p7;
    else
        return p7;
    end;
end;
function u2._xd8041402b83e75db(u12) --[[ Line: 51 ]]
    -- upvalues: l__Packets__2 (copy), u1 (copy), l__InternalSymbols__3 (copy)
    l__Packets__2._x3d559977708a04d1.OnClientEvent:Connect(function(p13, p14) --[[ Line: 52 ]]
        -- upvalues: u12 (copy), u1 (ref), l__InternalSymbols__3 (ref)
        local v15 = tostring(game.GameId);
        local v16 = 46;
        for v17 = 1, #v15 do
            v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
        end;
        if v16 == 272 and u12._x38e62b789111a6ed[p13] then
            warn("ENTITY ATTEMPTED TO APPLY TO DUPLICATE IDENTIFIER : ", p13, p14.entity_type);
        else
            local l__entity_type__4 = p14.entity_type;
            local v18 = u1[l__entity_type__4];
            local v19 = tostring(game.GameId);
            local v20 = 46;
            for v21 = 1, #v19 do
                v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
            end;
            if v20 == 272 and v18 then
                local u22 = l__InternalSymbols__3.owner("", require(v18))._xafd29f1684593d0b(p13, p14.entity_args);
                u12._x38e62b789111a6ed[p13] = u22;
                task.defer(function() --[[ Line: 67 ]]
                    -- upvalues: u22 (copy)
                    u22:_xd8041402b83e75db();
                end);
            else
                warn("COULD NOT FIND ENTITY MODULE FOR ENTITY : ", l__entity_type__4);
            end;
        end;
    end);
    l__Packets__2._xe3bfd4393906a1b6.OnClientEvent:Connect(function(p23) --[[ Line: 75 ]]
        -- upvalues: u12 (copy), l__InternalSymbols__3 (ref)
        local v24 = u12._x38e62b789111a6ed[p23];
        local v25 = tostring(game.GameId);
        local v26 = 46;
        for v27 = 1, #v25 do
            v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
        end;
        if v26 == 272 and not v24 then
        else
            l__InternalSymbols__3.owner("", v24):cleanUp();
            u12._x38e62b789111a6ed[p23] = nil;
        end;
    end);
end;
return u2;
