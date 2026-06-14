-- Decompiled from: ReplicatedStorage.Modules.Mince.Addons.weavecomptabilitystate
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MinceRef__1 = _G.MinceRef;
local l__Parent__2 = script.Parent.Parent;
local _ = script;
require(l__Parent__2.Signal);
game:GetService("CollectionService");
local u1 = nil;
local u2 = {};
function GetState(p3, p4)
    -- upvalues: u2 (copy), u1 (ref), l__MinceRef__1 (copy)
    local v5 = u2[p3];
    if v5 and not p4 then
        return v5;
    end;
    if u1 == "Server" then
        local v6 = newproxy(true);
        local u7 = {};
        local u8 = nil;
        if typeof(p3) == "string" then
            u8 = Instance.new("Configuration", script);
            u8.Name = p3;
        elseif typeof(p3) == "Instance" then
            u8 = p3;
        else
            error("Failed to GetState");
        end;
        local v9 = getmetatable(v6);
        function v9.__index(_, p10) --[[ Line: 39 ]]
            -- upvalues: u7 (copy)
            return u7[p10];
        end;
        function v9.__newindex(_, p11, p12) --[[ Line: 42 ]]
            -- upvalues: u8 (ref), u7 (copy)
            u8:SetAttribute(p11, p12);
            u7[p11] = p12;
        end;
        u2[p3] = v6;
        return v6;
    end;
    local u13 = nil;
    if typeof(p3) == "string" then
        u13 = script:WaitForChild(p3);
    elseif typeof(p3) == "Instance" then
        u13 = p3;
    else
        error("Failed to GetState");
    end;
    local u14 = u13:GetAttributes();
    local u15 = {
        _ = {},
        Listeners = {}
    };
    function u15._.Get() --[[ Line: 66 ]]
        -- upvalues: u13 (ref)
        return u13;
    end;
    function u15._.Upon(p16, p17) --[[ Line: 70 ]]
        -- upvalues: u14 (copy), u15 (copy)
        if u14[p16] then
            p17(u14[p16]);
        end;
        return u15._.IndexChanged(p16):Connect(p17);
    end;
    function u15._.Changed() --[[ Line: 78 ]]
        -- upvalues: u13 (ref)
        return u13.AttributeChanged;
    end;
    function u15._.IndexChanged(p18) --[[ Line: 82 ]]
        -- upvalues: u15 (copy), l__MinceRef__1 (ref)
        local v19 = u15.Listeners[p18];
        if not v19 then
            v19 = l__MinceRef__1.Signal.new();
            u15.Listeners[p18] = v19;
        end;
        return v19;
    end;
    u13.AttributeChanged:Connect(function(p20) --[[ Line: 92 ]]
        -- upvalues: u13 (ref), u14 (copy), u15 (copy)
        local v21 = u13:GetAttribute(p20);
        u14[p20] = v21;
        local v22 = u15.Listeners[p20];
        if v22 then
            v22:Fire(v21);
        end;
    end);
    local v23 = newproxy(true);
    local v24 = getmetatable(v23);
    function v24.__index(_, p25) --[[ Line: 104 ]]
        -- upvalues: u14 (copy)
        return u14[p25];
    end;
    function v24.__call(_, p26, ...) --[[ Line: 108 ]]
        -- upvalues: u15 (copy)
        local v27 = u15._[p26];
        if v27 then
            return v27(...);
        end;
    end;
    return v23;
end;
local v29 = {
    GetState = function(_, p28) --[[ Name: GetState, Line 120 ]]
        return GetState(p28);
    end
};
return {
    Server = v29,
    Client = v29,
    Identity = function(p30) --[[ Name: Identity, Line 128 ]]
        -- upvalues: u1 (ref)
        u1 = p30;
    end
};
