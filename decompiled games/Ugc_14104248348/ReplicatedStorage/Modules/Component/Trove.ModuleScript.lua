-- Decompiled from: ReplicatedStorage.Modules.Component.Trove
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = newproxy();
local u2 = newproxy();
local l__RunService__1 = game:GetService("RunService");
local function u6(p3, p4) --[[ Line: 10 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v5 = typeof(p3);
    if v5 == "function" then
        return u1;
    end;
    if v5 == "thread" then
        return u2;
    end;
    if p4 then
        return p4;
    end;
    if v5 == "Instance" then
        return "Destroy";
    end;
    if v5 == "RBXScriptConnection" then
        return "Disconnect";
    end;
    if v5 == "table" then
        if typeof(p3.Destroy) == "function" then
            return "Destroy";
        end;
        if typeof(p3.Disconnect) == "function" then
            return "Disconnect";
        end;
    end;
    error("Failed to get cleanup function for object " .. v5 .. ": " .. tostring(p3), 3);
end;
local u7 = {};
u7.__index = u7;
function u7.new() --[[ Line: 57 ]]
    -- upvalues: u7 (copy)
    local v8 = setmetatable({}, u7);
    v8._objects = {};
    return v8;
end;
function u7.Extend(p9) --[[ Line: 82 ]]
    -- upvalues: u7 (copy)
    return p9:Construct(u7);
end;
function u7.Clone(p10, p11) --[[ Line: 90 ]]
    return p10:Add(p11:Clone());
end;
function u7.Construct(p12, p13, ...) --[[ Line: 127 ]]
    local v14 = nil;
    local v15 = type(p13);
    if v15 == "table" then
        v14 = p13.new(...);
    elseif v15 == "function" then
        v14 = p13(...);
    end;
    return p12:Add(v14);
end;
function u7.Connect(p16, p17, p18) --[[ Line: 153 ]]
    return p16:Add(p17:Connect(p18));
end;
function u7.BindToRenderStep(p19, u20, p21, p22) --[[ Line: 170 ]]
    -- upvalues: l__RunService__1 (copy)
    l__RunService__1:BindToRenderStep(u20, p21, p22);
    p19:Add(function() --[[ Line: 172 ]]
        -- upvalues: l__RunService__1 (ref), u20 (copy)
        l__RunService__1:UnbindFromRenderStep(u20);
    end);
end;
function u7.AddPromise(u23, u24) --[[ Line: 200 ]]
    if type(u24) ~= "table" or (type(u24.getStatus) ~= "function" or (type(u24.finally) ~= "function" or type(u24.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;
    if u24:getStatus() == "Started" then
        u24:finally(function() --[[ Line: 203 ]]
            -- upvalues: u23 (copy), u24 (copy)
            return u23:_findAndRemoveFromObjects(u24, false);
        end);
        u23:Add(u24, "cancel");
    end;
    return u24;
end;
function u7.Add(p25, p26, p27) --[[ Line: 259 ]]
    -- upvalues: u6 (copy)
    local v28 = { p26, (u6(p26, p27)) };
    table.insert(p25._objects, v28);
    return p26;
end;
function u7.Remove(p29, p30) --[[ Line: 275 ]]
    return p29:_findAndRemoveFromObjects(p30, true);
end;
function u7.Clean(p31) --[[ Line: 284 ]]
    for _, v32 in ipairs(p31._objects) do
        p31:_cleanupObject(v32[1], v32[2]);
    end;
    table.clear(p31._objects);
end;
function u7._findAndRemoveFromObjects(p33, p34, p35) --[[ Line: 291 ]]
    local l___objects__2 = p33._objects;
    for v36, v37 in ipairs(l___objects__2) do
        if v37[1] == p34 then
            local v38 = #l___objects__2;
            l___objects__2[v36] = l___objects__2[v38];
            l___objects__2[v38] = nil;
            if p35 then
                p33:_cleanupObject(v37[1], v37[2]);
            end;
            return true;
        end;
    end;
    return false;
end;
function u7._cleanupObject(_, p39, p40) --[[ Line: 307 ]]
    -- upvalues: u1 (copy), u2 (copy)
    if p40 == u1 then
        p39();
    elseif p40 == u2 then
        coroutine.close(p39);
    else
        p39[p40](p39);
    end;
end;
function u7.AttachToInstance(u41, p42) --[[ Line: 330 ]]
    local v43 = p42:IsDescendantOf(game);
    assert(v43, "Instance is not a descendant of the game hierarchy");
    return u41:Connect(p42.Destroying, function() --[[ Line: 332 ]]
        -- upvalues: u41 (copy)
        u41:Destroy();
    end);
end;
function u7.Destroy(p44) --[[ Line: 340 ]]
    p44:Clean();
end;
return u7;
