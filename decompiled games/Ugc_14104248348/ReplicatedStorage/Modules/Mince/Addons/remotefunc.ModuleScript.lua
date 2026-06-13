-- Decompiled from: ReplicatedStorage.Modules.Mince.Addons.remotefunc
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
function u3.GetFunction(_, p4) --[[ Line: 17 ]]
    -- upvalues: l__RefMutate__3 (copy), u2 (copy), u3 (copy)
    local v5 = l__RefMutate__3.Convert(p4);
    if u2[v5] then
        return u2[v5];
    end;
    u2[v5] = u3.newFunction(v5);
    return u2[v5];
end;
function u3.newFunction(p6, ...) --[[ Line: 28 ]]
    -- upvalues: u3 (copy)
    local v7 = setmetatable({}, u3);
    v7:__Create(p6, ...);
    return v7;
end;
function u3.__Create(u8, p9) --[[ Line: 34 ]]
    -- upvalues: l__Signal__2 (copy), u1 (copy)
    u8.Function = l__Signal__2.new();
    u8.Middleware = {};
    u8.RegisterIndex = p9;
    u8.RemoteFunction = Instance.new("RemoteFunction", u1);
    u8.RemoteFunction.Name = p9;
    function u8.RemoteFunction.OnServerInvoke(...) --[[ Line: 42 ]]
        -- upvalues: u8 (copy)
        return u8:UponInvoke(...);
    end;
end;
function u3.UponInvoke(p10, ...) --[[ Line: 47 ]]
    for _, v11 in ipairs(p10.Middleware) do
        local v12, v13 = v11(...);
        if v12 ~= nil and not v12 then
            warn((`Middleware failed while running on function! \n{v13}`));
            return;
        end;
    end;
    return p10.OnInvoke(...);
end;
function u3.Invoke(p14, p15, ...) --[[ Line: 60 ]]
    local v16;
    if typeof(p15) == "Instance" then
        v16 = p15:IsA("Player");
    else
        v16 = false;
    end;
    if not v16 then
        error("ServerRemote:Invoke([1]) : Expected Player got " .. typeof(p15));
    end;
    return p14.RemoteFunction:InvokeClient(p15, ...);
end;
function u3.OnInvoke(_) --[[ Line: 72 ]]
    warn("Default function invocation recieved");
    return nil;
end;
function u3.Add(p17, p18) --[[ Line: 78 ]]
    if type(p18) ~= "function" then
        error("ServerRemote:Add([1]) : Expected Middleware function got " .. typeof(p18));
    end;
    table.insert(p17.Middleware, p18);
end;
local u19 = {};
u19.__index = u19;
function u19.GetFunction(_, p20) --[[ Line: 90 ]]
    -- upvalues: l__RefMutate__3 (copy), u2 (copy), u19 (copy)
    local v21 = l__RefMutate__3.Convert(p20);
    if u2[v21] then
        return u2[v21];
    end;
    u2[v21] = u19.newFunction(v21);
    return u2[v21];
end;
function u19.newFunction(p22, ...) --[[ Line: 101 ]]
    -- upvalues: u19 (copy)
    local v23 = setmetatable({}, u19);
    v23:__Create(p22, ...);
    return v23;
end;
function u19.__Create(u24, p25) --[[ Line: 107 ]]
    -- upvalues: l__Signal__2 (copy), u1 (copy)
    u24.Function = l__Signal__2.new();
    u24.Middleware = {};
    u24.RegisterIndex = p25;
    u24.RemoteFunction = u1:FindFirstChild(p25);
    if not u24.RemoteFunction then
        error((`There's no server functionm by the name of "{p25}".`));
    end;
    function u24.RemoteFunction.OnClientInvoke(...) --[[ Line: 117 ]]
        -- upvalues: u24 (copy)
        return u24:UponInvoke(...);
    end;
end;
function u19.UponInvoke(p26, ...) --[[ Line: 122 ]]
    for v27, v28 in ipairs(p26.Middleware) do
        local v29, v30 = v28(...);
        if v29 ~= nil and not v29 then
            warn((`Middleware[{v27}]'{p26.RegisterIndex}': Rejection {v30}!`));
            return;
        end;
    end;
    return p26.OnInvoke(...);
end;
function u19.Invoke(p31, ...) --[[ Line: 135 ]]
    return p31.RemoteFunction:InvokeServer(...);
end;
function u19.OnInvoke(_) --[[ Line: 139 ]]
    warn("Default function invocation recieved. Are you sure you didn\'t mean to call Invoke()?");
end;
function u19.Add(p32, p33) --[[ Line: 143 ]]
    if type(p33) ~= "function" then
        error("ServerRemote:Add([1]) : Expected Middleware function got " .. typeof(p33));
    end;
    table.insert(p32.Middleware, p33);
end;
return {
    Client = {
        GetFunction = u19.GetFunction
    },
    Server = {
        GetFunction = u3.GetFunction
    }
};
