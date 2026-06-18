-- Decompiled from: Start.Client.Classes._xa582dff88acd1962
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
local u1 = {
    RepBaseEntity = script.Parent.Parent.ReplicatedEntities._xeaa4b98924eebc0a,
    RepDroneEntity = script.Parent.Parent.ReplicatedEntities._x8470faac4f69f581,
    RepInteractEntity = script.Parent.Parent.ReplicatedEntities._x001ddfb7a4bdeb77,
    RepLaunchpad = script.Parent.Parent.ReplicatedEntities._xc670a553526675a0,
    RepParryTrainButton = script.Parent.Parent.ReplicatedEntities._x6a5639a2dbe2aa80,
    RepSupportScreen = script.Parent.Parent.ReplicatedEntities._x96612d0046c5a456,
    RepZipline = script.Parent.Parent.ReplicatedEntities._x0254ce18485dd1ac
};
local u2 = {};
u2.__index = u2;
function u2._x90d4581ac99dd483() --[[ Line: 20 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._x1fa73e31ee077c4a = {};
    return v3;
end;
function u2._x069a4a34b4384226(p4, p5) --[[ Line: 28 ]]
    return p4._x1fa73e31ee077c4a[p5];
end;
function u2._x1e7ec68c15abf5de(p6, p7) --[[ Line: 32 ]]
    local v8 = p6:_x069a4a34b4384226(p7);
    if v8 and typeof(v8._xcdb67173674eea4d) == "function" then
        return v8:_xcdb67173674eea4d() or p7;
    else
        return p7;
    end;
end;
function u2._xe53615d96cf36a6b(u9) --[[ Line: 42 ]]
    -- upvalues: l__Packets__2 (copy), u1 (copy), l__InternalSymbols__3 (copy)
    l__Packets__2._xa512847493af8250.OnClientEvent:Connect(function(p10, p11) --[[ Line: 43 ]]
        -- upvalues: u9 (copy), u1 (ref), l__InternalSymbols__3 (ref)
        if u9._x1fa73e31ee077c4a[p10] then
            warn("ENTITY ATTEMPTED TO APPLY TO DUPLICATE IDENTIFIER : ", p10, p11.entity_type);
        else
            local l__entity_type__4 = p11.entity_type;
            local v12 = u1[l__entity_type__4];
            if v12 then
                local u13 = l__InternalSymbols__3.owner("", require(v12))._x90d4581ac99dd483(p10, p11.entity_args);
                u9._x1fa73e31ee077c4a[p10] = u13;
                task.defer(function() --[[ Line: 58 ]]
                    -- upvalues: u13 (copy)
                    u13:_xe53615d96cf36a6b();
                end);
            else
                warn("COULD NOT FIND ENTITY MODULE FOR ENTITY : ", l__entity_type__4);
            end;
        end;
    end);
    l__Packets__2._x525bd43c8a54795b.OnClientEvent:Connect(function(p14) --[[ Line: 66 ]]
        -- upvalues: u9 (copy), l__InternalSymbols__3 (ref)
        local v15 = u9._x1fa73e31ee077c4a[p14];
        if v15 then
            l__InternalSymbols__3.owner("", v15):cleanUp();
            u9._x1fa73e31ee077c4a[p14] = nil;
        end;
    end);
end;
return u2;
