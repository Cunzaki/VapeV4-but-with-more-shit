-- Decompiled from: Start.Client.Classes._x7b50da9f175b537e
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

if not LPH_OBFUSCATED then
    function LPH_JIT_MAX(p1)
        return p1;
    end;
end;
local l__RunService__1 = game:GetService("RunService");
local u2 = {};
u2.__index = u2;
local l__Classes__2 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
function u2._x90d4581ac99dd483() --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._x84896c4f9d81e8d0 = {};
    v3._x8908b3ae4abbd6c6 = {};
    v3._x2db3d76bd44ee723 = {};
    v3._x85dec45cd6eafa81 = {};
    return v3;
end;
function u2._x03003fa12c8fdf9d(p4, p5) --[[ Line: 31 ]]
    local v6 = table.find(p4._x8908b3ae4abbd6c6, p5);
    if v6 then
        table.remove(p4._x8908b3ae4abbd6c6, v6);
    end;
    p4._x84896c4f9d81e8d0[p5] = nil;
end;
function u2._x5d7b5a6e465d0a0a(p7, p8) --[[ Line: 39 ]]
    -- upvalues: l__InternalSymbols__3 (copy)
    local v9 = l__InternalSymbols__3.owner("", p8);
    if v9._x28b7fb1e5e9a9ddb then
        table.insert(p7._x8908b3ae4abbd6c6, v9);
    else
        warn("ENTITY IS NOT A VALID INTERACTIVE ENTITY, MISSING INTERACTION DATA : ", v9._xe6b273660fc7b65e);
    end;
end;
function u2._xe53615d96cf36a6b(u10) --[[ Line: 49 ]]
    -- upvalues: l__RunService__1 (copy), l__Classes__2 (copy), l__InternalSymbols__3 (copy)
    l__RunService__1.Heartbeat:Connect(LPH_JIT_MAX(function() --[[ Line: 50 ]]
        -- upvalues: u10 (copy), l__Classes__2 (ref), l__InternalSymbols__3 (ref)
        local l___x84896c4f9d81e8d0__4 = u10._x84896c4f9d81e8d0;
        local l___x2db3d76bd44ee723__5 = u10._x2db3d76bd44ee723;
        local l___x85dec45cd6eafa81__6 = u10._x85dec45cd6eafa81;
        local v11 = l__Classes__2.Util:getDictionarySize(l___x84896c4f9d81e8d0__4) > 0;
        local v12 = (1 / 0);
        local v13 = nil;
        for _, v14 in u10._x8908b3ae4abbd6c6 do
            local v15 = l__InternalSymbols__3.owner("", v14);
            if not (v15._x7d8d5dc4e5b5d7b8 and v11) then
                local v16, v17 = v15:_x4a69b63617ce897d();
                local l___xb594719f7633469f__7 = v15._xb594719f7633469f;
                if v16 == true then
                    if v17 < v12 then
                        v13 = v15;
                        v12 = v17;
                    end;
                elseif l___xb594719f7633469f__7 then
                    local l__identity__8 = l___xb594719f7633469f__7.identity;
                    if not l___x2db3d76bd44ee723__5[l__identity__8] and (not l___x85dec45cd6eafa81__6[l__identity__8] and v15:_x114231b8ad41ee5f()) then
                        l___x2db3d76bd44ee723__5[l__identity__8] = {
                            entity = v15,
                            cue_cancellation = v15:_x6a92d32341180f36()
                        };
                    end;
                end;
            end;
        end;
        for v18, v19 in l___x2db3d76bd44ee723__5 do
            local v20 = l__InternalSymbols__3.owner("", v19.entity);
            if not v20:_x114231b8ad41ee5f() then
                v20:_xdd7a2ded0e42f152();
                l___x2db3d76bd44ee723__5[v18] = nil;
            end;
        end;
        if v13 then
            l__InternalSymbols__3.owner("", v13):_x41a643b20ca024fa();
        end;
    end));
    l__Classes__2._x7430d6d194f43373:_x685b03ceb3f7e330("onDeath"):Connect(function() --[[ Line: 104 ]]
        -- upvalues: u10 (copy), l__InternalSymbols__3 (ref)
        for _, v21 in u10._x84896c4f9d81e8d0 do
            local v22 = l__InternalSymbols__3.owner("", v21);
            pcall(v22._x6ffb8b18ef4549c8, v22);
        end;
        u10._x84896c4f9d81e8d0 = {};
    end);
end;
return u2;
