-- Decompiled from: ReplicatedStorage.Assets.Shared.ReplicationRules
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__Shared__1 = script.Parent.Parent.Shared;
local l__Warn__2 = require(script.Parent.Warn);
require(l__Shared__1.Types);
local l__Holder__3 = require(l__Shared__1.Holder);
local u1 = {};
local function u5(p2) --[[ Line: 15 ]]
    -- upvalues: l__Holder__3 (copy)
    if typeof(p2) == "number" then
        return p2;
    end;
    if typeof(p2) == "table" then
        return p2.id;
    end;
    if typeof(p2) ~= "Instance" then
        return nil;
    end;
    if p2:IsA("Player") then
        local v3 = l__Holder__3.GetEntityFromPlayer(p2);
        return v3 and v3.id or nil;
    end;
    if not p2:IsA("Model") then
        return nil;
    end;
    local v4 = l__Holder__3.GetEntityFromModel(p2);
    return v4 and v4.id or nil;
end;
local function u11(p6) --[[ Line: 41 ]]
    local l__filterType__4 = p6.filterType;
    local u7 = {};
    for _, v8 in p6.filterPlayers or {} do
        u7[v8] = true;
    end;
    return l__filterType__4 == "exclude" and (next(u7) == nil and function() --[[ Line: 52 ]]
        return true;
    end or function(_, p9) --[[ Line: 57 ]]
        -- upvalues: u7 (copy)
        return u7[p9] ~= true;
    end) or (next(u7) == nil and function() --[[ Line: 62 ]]
        return false;
    end or function(_, p10) --[[ Line: 67 ]]
        -- upvalues: u7 (copy)
        return u7[p10] == true;
    end);
end;
return {
    SetReplicationRule = function(p12, p13) --[[ Name: SetReplicationRule, Line 73 ]]
        -- upvalues: u5 (copy), l__Warn__2 (copy), u1 (copy), u11 (copy)
        local v14 = u5(p12);
        if v14 then
            if p13 == nil then
                u1[v14] = nil;
            elseif typeof(p13) == "function" then
                u1[v14] = p13;
            else
                u1[v14] = u11(p13);
            end;
        else
            l__Warn__2.low("no id", p12);
        end;
    end,
    Allows = function(p15, p16) --[[ Name: Allows, Line 96 ]]
        -- upvalues: u1 (copy), l__Holder__3 (copy)
        local v17 = u1[p15.id];
        if not v17 then
            return true;
        end;
        local v18 = l__Holder__3.GetEntityFromPlayer(p16);
        return v17(p15, p16, v18 and v18.id or nil);
    end,
    Include = function(p19) --[[ Name: Include, Line 108 ]]
        -- upvalues: u11 (copy)
        return u11({
            filterType = "include",
            filterPlayers = p19
        });
    end,
    Exclude = function(p20) --[[ Name: Exclude, Line 112 ]]
        -- upvalues: u11 (copy)
        return u11({
            filterType = "exclude",
            filterPlayers = p20
        });
    end
};
