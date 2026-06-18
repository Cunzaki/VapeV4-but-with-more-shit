-- Decompiled from: Start.Client.ReplicatedEntities._x001ddfb7a4bdeb77
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
local l__CEnum__2 = require(l__ModuleScripts__1.CEnum);
local l___xeaa4b98924eebc0a__3 = require(script.Parent._xeaa4b98924eebc0a);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___xeaa4b98924eebc0a__3);
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x90d4581ac99dd483(p2, p3) --[[ Line: 24 ]]
    -- upvalues: l___xeaa4b98924eebc0a__3 (copy), u1 (copy)
    local v4 = l___xeaa4b98924eebc0a__3._x90d4581ac99dd483(p2);
    setmetatable(v4, u1);
    v4._x7d8d5dc4e5b5d7b8 = p3.is_exclusive;
    v4._x215be72d3f881056 = false;
    v4._x28b7fb1e5e9a9ddb = p3.interaction_data;
    v4._xb594719f7633469f = p3.gameplay_cue_data;
    return v4;
end;
function u1._x6ffb8b18ef4549c8(p5) --[[ Line: 49 ]]
    warn("REAL stopInteract HAS NOT BEEN SET, EMPTY BASE METHOD WAS CALLED, ", p5._xe6b273660fc7b65e);
end;
function u1._x41a643b20ca024fa(p6) --[[ Line: 53 ]]
    warn("REAL onInteract HAS NOT BEEN SET, EMPTY BASE METHOD WAS CALLED ", p6._xe6b273660fc7b65e);
end;
function u1._x6a92d32341180f36(p7) --[[ Line: 57 ]]
    -- upvalues: l__Classes__4 (copy)
    if p7._xb594719f7633469f then
        return l__Classes__4._xafc4950d7b094088:_xaf76eb01fb5dda1c({
            cue_type = "message",
            text = p7._xb594719f7633469f.getText()
        });
    end;
end;
function u1._xdd7a2ded0e42f152(p8) --[[ Line: 66 ]]
    -- upvalues: l__Classes__4 (copy)
    if p8._xb594719f7633469f then
        local v9 = l__Classes__4._x7b50da9f175b537e._x2db3d76bd44ee723[p8._xb594719f7633469f.identity];
        if v9 and v9.cue_cancellation then
            pcall(v9.cue_cancellation);
        end;
    end;
end;
function u1._x114231b8ad41ee5f(u10) --[[ Line: 75 ]]
    -- upvalues: l__CEnum__2 (copy), l__Classes__4 (copy)
    if u10._x28b7fb1e5e9a9ddb.reference_part then
        if u10._xb594719f7633469f then
            if u10._x28b7fb1e5e9a9ddb.type == l__CEnum__2.InteractTypes.proximityAuto then
                return false;
            elseif u10._x215be72d3f881056 then
                if u10._x9dfab354fc7fd1f6 == "alive" then
                    local v11, v12 = pcall(function() --[[ Name: getInteractResult, Line 82 ]]
                        -- upvalues: u10 (copy), l__Classes__4 (ref)
                        if not u10._x215be72d3f881056 then
                            return false;
                        end;
                        local l__Position__5 = l__Classes__4._x7058397dabccd000._x1cdffaf9f62b92e9.Position;
                        return (l__Position__5 - u10._x28b7fb1e5e9a9ddb.reference_part:GetClosestPointOnSurface(l__Position__5)).Magnitude <= u10._x28b7fb1e5e9a9ddb.radius;
                    end);
                    if v11 then
                        return v12;
                    else
                        return false;
                    end;
                else
                    return false;
                end;
            else
                return false;
            end;
        else
            return false;
        end;
    else
        return false;
    end;
end;
function u1._x4a69b63617ce897d(u13) --[[ Line: 109 ]]
    -- upvalues: l__CEnum__2 (copy), l__Classes__4 (copy)
    if u13._x28b7fb1e5e9a9ddb.reference_part then
        if u13._x215be72d3f881056 then
            if u13._x9dfab354fc7fd1f6 == "alive" then
                local v14, v15, v16 = pcall(function() --[[ Name: getInteractResult, Line 114 ]]
                    -- upvalues: u13 (copy), l__CEnum__2 (ref), l__Classes__4 (ref)
                    if not u13._x215be72d3f881056 then
                        return false;
                    end;
                    if u13._x28b7fb1e5e9a9ddb.type == l__CEnum__2.InteractTypes.proximityAuto then
                        local l__Position__6 = l__Classes__4._x7058397dabccd000._x1cdffaf9f62b92e9.Position;
                        local l__Magnitude__7 = (l__Position__6 - u13._x28b7fb1e5e9a9ddb.reference_part:GetClosestPointOnSurface(l__Position__6)).Magnitude;
                        if l__Magnitude__7 <= u13._x28b7fb1e5e9a9ddb.radius then
                            return true, l__Magnitude__7;
                        end;
                    elseif u13._x28b7fb1e5e9a9ddb.type == l__CEnum__2.InteractTypes.proximityInput then
                        local l__Position__8 = l__Classes__4._x7058397dabccd000._x1cdffaf9f62b92e9.Position;
                        local l__Magnitude__9 = (l__Position__8 - u13._x28b7fb1e5e9a9ddb.reference_part:GetClosestPointOnSurface(l__Position__8)).Magnitude;
                        if u13._x28b7fb1e5e9a9ddb.radius < l__Magnitude__9 then
                            return false;
                        elseif l__Classes__4._x3e046bec2684f59c:_xc9966245cd0a44a8("INTERACT").Held then
                            return true, l__Magnitude__9;
                        else
                            return false, l__Magnitude__9;
                        end;
                    end;
                    return false;
                end);
                if v14 then
                    return v15, v16;
                else
                    return false;
                end;
            else
                return false;
            end;
        else
            return false;
        end;
    else
        return false;
    end;
end;
function u1.cleanUp(u17) --[[ Line: 160 ]]
    u17._x9dfab354fc7fd1f6 = "dead";
    pcall(function() --[[ Line: 162 ]]
        -- upvalues: u17 (copy)
        u17._x56e388840ebb3dc6:Clean();
    end);
end;
function u1._xe53615d96cf36a6b(p18) --[[ Line: 168 ]]
    -- upvalues: l__Classes__4 (copy)
    l__Classes__4._x7b50da9f175b537e:_x5d7b5a6e465d0a0a(p18);
    p18._x215be72d3f881056 = true;
    p18._x9dfab354fc7fd1f6 = "alive";
end;
return u1;
