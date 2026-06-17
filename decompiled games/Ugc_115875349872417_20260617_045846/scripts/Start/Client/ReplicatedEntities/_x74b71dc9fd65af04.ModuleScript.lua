-- Decompiled from: Start.Client.ReplicatedEntities._x74b71dc9fd65af04
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
local l__CEnum__2 = require(l__ModuleScripts__1.CEnum);
local l___x2c14530c654eb276__3 = require(script.Parent._x2c14530c654eb276);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x2c14530c654eb276__3);
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x83ed94bfb82a8c9f(p2, p3) --[[ Line: 33 ]]
    -- upvalues: l___x2c14530c654eb276__3 (copy), u1 (copy)
    local v4 = l___x2c14530c654eb276__3._x83ed94bfb82a8c9f(p2);
    setmetatable(v4, u1);
    v4._x47c5564e0ebc7c70 = p3.is_exclusive;
    v4._x0b7325c049f4fdb4 = false;
    v4._x22924a5c5b7265a0 = p3.interaction_data;
    v4._x8cb7029b34876a56 = p3.gameplay_cue_data;
    return v4;
end;
function u1._x91f1a55d9b284c4f(p5) --[[ Line: 58 ]]
    warn("REAL stopInteract HAS NOT BEEN SET, EMPTY BASE METHOD WAS CALLED, ", p5._x2401f1dccc8d59b5);
end;
function u1._x35224e4a48526095(p6) --[[ Line: 62 ]]
    warn("REAL onInteract HAS NOT BEEN SET, EMPTY BASE METHOD WAS CALLED ", p6._x2401f1dccc8d59b5);
end;
function u1._xf03135bf52337eb1(p7) --[[ Line: 66 ]]
    -- upvalues: l__Classes__4 (copy)
    if p7._x8cb7029b34876a56 then
        return l__Classes__4._x6a15bbeeb97caae0:_xa26b35492ceca8db({
            cue_type = "message",
            text = p7._x8cb7029b34876a56.getText()
        });
    end;
end;
function u1._x83d349acda1b2624(p8) --[[ Line: 75 ]]
    -- upvalues: l__Classes__4 (copy)
    if p8._x8cb7029b34876a56 then
        local v9 = l__Classes__4._x001619ec42f5322c._xaf547586f5e40349[p8._x8cb7029b34876a56.identity];
        if v9 and v9.cue_cancellation then
            pcall(v9.cue_cancellation);
        end;
    end;
end;
function u1._xc7b7bda776917e24(u10) --[[ Line: 84 ]]
    -- upvalues: l__CEnum__2 (copy), l__Classes__4 (copy)
    if u10._x22924a5c5b7265a0.reference_part then
        if u10._x8cb7029b34876a56 then
            if u10._x22924a5c5b7265a0.type == l__CEnum__2.InteractTypes.proximityAuto then
                return false;
            elseif u10._x0b7325c049f4fdb4 then
                if u10._xc5ae78e6b69f5669 == "alive" then
                    local v11, v12 = pcall(function() --[[ Name: getInteractResult, Line 91 ]]
                        -- upvalues: u10 (copy), l__Classes__4 (ref)
                        if not u10._x0b7325c049f4fdb4 then
                            return false;
                        end;
                        local l__Position__5 = l__Classes__4._x1a4ce4062771e36e._xde8b8f659627fa3f.Position;
                        return (l__Position__5 - u10._x22924a5c5b7265a0.reference_part:GetClosestPointOnSurface(l__Position__5)).Magnitude <= u10._x22924a5c5b7265a0.radius;
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
function u1._x78f77529732387bb(u13) --[[ Line: 118 ]]
    -- upvalues: l__CEnum__2 (copy), l__Classes__4 (copy)
    if u13._x22924a5c5b7265a0.reference_part then
        if u13._x0b7325c049f4fdb4 then
            if u13._xc5ae78e6b69f5669 == "alive" then
                local v14, v15, v16 = pcall(function() --[[ Name: getInteractResult, Line 123 ]]
                    -- upvalues: u13 (copy), l__CEnum__2 (ref), l__Classes__4 (ref)
                    if not u13._x0b7325c049f4fdb4 then
                        return false;
                    end;
                    if u13._x22924a5c5b7265a0.type == l__CEnum__2.InteractTypes.proximityAuto then
                        local l__Position__6 = l__Classes__4._x1a4ce4062771e36e._xde8b8f659627fa3f.Position;
                        local l__Magnitude__7 = (l__Position__6 - u13._x22924a5c5b7265a0.reference_part:GetClosestPointOnSurface(l__Position__6)).Magnitude;
                        if l__Magnitude__7 <= u13._x22924a5c5b7265a0.radius then
                            return true, l__Magnitude__7;
                        end;
                    elseif u13._x22924a5c5b7265a0.type == l__CEnum__2.InteractTypes.proximityInput then
                        local l__Position__8 = l__Classes__4._x1a4ce4062771e36e._xde8b8f659627fa3f.Position;
                        local l__Magnitude__9 = (l__Position__8 - u13._x22924a5c5b7265a0.reference_part:GetClosestPointOnSurface(l__Position__8)).Magnitude;
                        if u13._x22924a5c5b7265a0.radius < l__Magnitude__9 then
                            return false;
                        elseif l__Classes__4._xf1ad98d2d70b7408:_x93fd21adac562b5e("INTERACT").Held then
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
function u1.cleanUp(u17) --[[ Line: 169 ]]
    u17._xc5ae78e6b69f5669 = "dead";
    pcall(function() --[[ Line: 171 ]]
        -- upvalues: u17 (copy)
        u17._x5e23eb3dedcea17d:Clean();
    end);
end;
function u1._x44bcd6af41218f92(p18) --[[ Line: 177 ]]
    -- upvalues: l__Classes__4 (copy)
    l__Classes__4._x001619ec42f5322c:_x9329d49f87bd9806(p18);
    p18._x0b7325c049f4fdb4 = true;
    p18._xc5ae78e6b69f5669 = "alive";
end;
return u1;
