-- Decompiled from: ReplicatedStorage.Modules.Mince.Addons.remote
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent;
local u1 = script;
local l__Signal__2 = require(l__Parent__1.Signal);
local l__RefMutate__3 = require(l__Parent__1.RefMutate);
local u2 = {};
local u3 = {};
u3.__index = u3;
function u3.GetEvent(_, p4, ...) --[[ Line: 17 ]]
    -- upvalues: l__RefMutate__3 (copy), u2 (copy), u3 (copy)
    local v5 = l__RefMutate__3.Convert(p4);
    if u2[v5] then
        return u2[v5];
    end;
    u2[v5] = u3.newEvent(v5, ...);
    return u2[v5];
end;
function u3.newEvent(p6, ...) --[[ Line: 28 ]]
    -- upvalues: u3 (copy)
    local v7 = setmetatable({}, u3);
    v7:__Create(p6, ...);
    return v7;
end;
function u3.__Create(u8, p9, p10) --[[ Line: 34 ]]
    -- upvalues: l__Signal__2 (copy), u1 (copy)
    u8.Event = l__Signal__2.new();
    u8.Extenders = {};
    u8.DoesExtend = false;
    u8.RegisterIndex = p9;
    u8.RemoteEvent = Instance.new(p10 and "UnreliableRemoteEvent" or "RemoteEvent", u1);
    u8.RemoteEvent.Name = p9;
    u8.RemoteEvent.OnServerEvent:Connect(function(...) --[[ Line: 43 ]]
        -- upvalues: u8 (copy)
        u8:UponRemoteEvent(...);
    end);
end;
function u3.UponRemoteEvent(p11, ...) --[[ Line: 48 ]]
    if p11.DoesExtend then
        local v12, v13 = ...;
        local v14 = p11.Extenders[v13];
        if v14 then
            v14.Event:Fire(v12, select(3, ...));
            return;
        end;
        warn((`Dropped server extender '{v13}' ({p11.RegisterIndex}) did you forget to extend this? Player has been kicked as a security measure.`));
        v12:Kick("Recieved communication to unconnected event extension. Please re-join or report to developer.");
    end;
    p11.Event:Fire(...);
end;
function u3.Fire(p15, p16, ...) --[[ Line: 64 ]]
    local v17;
    if typeof(p16) == "Instance" then
        v17 = p16:IsA("Player");
    else
        v17 = false;
    end;
    assert(v17, ":Fire([1]) must be a player!");
    p15.RemoteEvent:FireClient(p16, ...);
end;
function u3.FireAll(p18, ...) --[[ Line: 69 ]]
    p18.RemoteEvent:FireAllClients(...);
end;
function u3.Extend(u19, u20) --[[ Line: 73 ]]
    -- upvalues: l__Signal__2 (copy)
    if u19.Extenders[u20] then
        return u19.Extenders[u20];
    end;
    u19.DoesExtend = true;
    u19.RemoteEvent:SetAttribute("Extends", true);
    local v23 = {
        Event = l__Signal__2.new(),
        Fire = function(_, p21, ...) --[[ Name: Fire, Line 88 ]]
            -- upvalues: u19 (copy), u20 (copy)
            local v22;
            if typeof(p21) == "Instance" then
                v22 = p21:IsA("Player");
            else
                v22 = false;
            end;
            assert(v22, ":Fire([1]) must be a player!");
            u19.RemoteEvent:FireClient(p21, u20, ...);
        end,
        FireAll = function(_, ...) --[[ Name: FireAll, Line 93 ]]
            -- upvalues: u19 (copy), u20 (copy)
            u19.RemoteEvent:FireAllClients(u20, ...);
        end
    };
    u19.Extenders[u20] = v23;
    return v23;
end;
local u24 = {};
u24.__index = u24;
function u24.GetEvent(_, p25) --[[ Line: 106 ]]
    -- upvalues: l__RefMutate__3 (copy), u2 (copy), u24 (copy)
    local v26 = l__RefMutate__3.Convert(p25);
    if u2[v26] then
        return u2[v26];
    end;
    u2[v26] = u24.newEvent(v26);
    return u2[v26];
end;
function u24.newEvent(p27, ...) --[[ Line: 117 ]]
    -- upvalues: u24 (copy)
    local v28 = setmetatable({}, u24);
    v28:__Create(p27, ...);
    return v28;
end;
function u24.__Create(u29, p30, _) --[[ Line: 123 ]]
    -- upvalues: l__Signal__2 (copy), u1 (copy)
    u29.Event = l__Signal__2.new();
    u29.Extenders = {};
    u29.RegisterIndex = p30;
    u29.RemoteEvent = u1:FindFirstChild(p30);
    if not u29.RemoteEvent then
        error((`There's no server remote by the name of "{p30}".`));
    end;
    u29.DoesExtend = u29.RemoteEvent:GetAttribute("Extends");
    u29.RemoteEvent:GetAttributeChangedSignal("Extends"):Connect(function() --[[ Line: 134 ]]
        -- upvalues: u29 (copy)
        u29.DoesExtend = u29.RemoteEvent:GetAttribute("Extends");
    end);
    u29.RemoteEvent.OnClientEvent:Connect(function(...) --[[ Line: 138 ]]
        -- upvalues: u29 (copy)
        u29:UponRemoteEvent(...);
    end);
end;
function u24.UponRemoteEvent(p31, ...) --[[ Line: 143 ]]
    if p31.DoesExtend then
        local v32 = ...;
        local v33 = p31.Extenders[v32];
        if v33 then
            v33.Event:Fire(select(2, ...));
            return;
        end;
        warn((`Dropped extender '{v32}' ({p31.RegisterIndex}) did you forget to extend this? `));
    end;
    p31.Event:Fire(...);
end;
function u24.Fire(p34, ...) --[[ Line: 158 ]]
    if p34.DoesExtend then
        error("You cannot fire an extended remote.");
    end;
    p34.RemoteEvent:FireServer(...);
end;
function u24.Extend(u35, u36) --[[ Line: 167 ]]
    -- upvalues: l__Signal__2 (copy)
    if not u35.DoesExtend then
        error("You cannot extend a remote that is not extended on the server!");
    end;
    if u35.Extenders[u36] then
        return u35.Extenders[u36];
    end;
    local v37 = {
        Event = l__Signal__2.new(),
        Fire = function(_, ...) --[[ Name: Fire, Line 182 ]]
            -- upvalues: u35 (copy), u36 (copy)
            u35.RemoteEvent:FireServer(u36, ...);
        end
    };
    u35.Extenders[u36] = v37;
    return v37;
end;
return {
    Client = {
        GetEvent = u24.GetEvent
    },
    Server = {
        GetEvent = u3.GetEvent
    }
};
