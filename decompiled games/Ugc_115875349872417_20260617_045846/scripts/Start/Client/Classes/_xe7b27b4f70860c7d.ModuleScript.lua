-- Decompiled from: Start.Client.Classes._xe7b27b4f70860c7d
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l___x7749231778538ccb__3 = require(script.Parent.Parent._x7749231778538ccb);
local u1 = {
    RepBaseEntity = script.Parent.Parent.ReplicatedEntities._x2c14530c654eb276,
    RepDroneEntity = script.Parent.Parent.ReplicatedEntities._x2af6f27c70136bb8,
    RepInteractEntity = script.Parent.Parent.ReplicatedEntities._x74b71dc9fd65af04,
    RepLaunchpad = script.Parent.Parent.ReplicatedEntities._xad983143164c7284,
    RepParryTrainButton = script.Parent.Parent.ReplicatedEntities._xc13f7d7d8c93fd5a,
    RepSupportScreen = script.Parent.Parent.ReplicatedEntities._x8dd0e7d1e540ffce,
    RepZipline = script.Parent.Parent.ReplicatedEntities._x5b76a97e85bcdfef
};
local u2 = {};
u2.__index = u2;
function u2._x83ed94bfb82a8c9f() --[[ Line: 29 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._xb998c2c7286dc760 = {};
    return v3;
end;
function u2._x98d7ce7be5780fa9(p4, p5) --[[ Line: 37 ]]
    return p4._xb998c2c7286dc760[p5];
end;
function u2._x32e5162398b03925(p6, p7) --[[ Line: 41 ]]
    local v8 = p6:_x98d7ce7be5780fa9(p7);
    if v8 and typeof(v8._x4dd582f5f8bf2227) == "function" then
        return v8:_x4dd582f5f8bf2227() or p7;
    else
        return p7;
    end;
end;
function u2._x44bcd6af41218f92(u9) --[[ Line: 51 ]]
    -- upvalues: l__Packets__2 (copy), u1 (copy), l___x7749231778538ccb__3 (copy)
    l__Packets__2._xd072640b833c43f6.OnClientEvent:Connect(function(p10, p11) --[[ Line: 52 ]]
        -- upvalues: u9 (copy), u1 (ref), l___x7749231778538ccb__3 (ref)
        if u9._xb998c2c7286dc760[p10] then
            warn("ENTITY ATTEMPTED TO APPLY TO DUPLICATE IDENTIFIER : ", p10, p11.entity_type);
        else
            local l__entity_type__4 = p11.entity_type;
            local v12 = u1[l__entity_type__4];
            if v12 then
                local u13 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", require(v12))._x83ed94bfb82a8c9f(p10, p11.entity_args);
                u9._xb998c2c7286dc760[p10] = u13;
                task.defer(function() --[[ Line: 67 ]]
                    -- upvalues: u13 (copy)
                    u13:_x44bcd6af41218f92();
                end);
            else
                warn("COULD NOT FIND ENTITY MODULE FOR ENTITY : ", l__entity_type__4);
            end;
        end;
    end);
    l__Packets__2._x489d4e2c9b1db08e.OnClientEvent:Connect(function(p14) --[[ Line: 75 ]]
        -- upvalues: u9 (copy), l___x7749231778538ccb__3 (ref)
        local v15 = u9._xb998c2c7286dc760[p14];
        if v15 then
            l___x7749231778538ccb__3._xd644d9e3ba63f27f("", v15):cleanUp();
            u9._xb998c2c7286dc760[p14] = nil;
        end;
    end);
end;
return u2;
