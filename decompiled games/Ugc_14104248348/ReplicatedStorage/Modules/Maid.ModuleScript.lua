-- Decompiled from: ReplicatedStorage.Modules.Maid
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = newproxy();
local u2 = newproxy();
local u3 = table.freeze({
    "Destroy",
    "Disconnect",
    "destroy",
    "disconnect"
});
local function u8(p4, p5) --[[ Line: 123 ]]
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v6 = typeof(p4);
    if v6 == "function" then
        return u1;
    end;
    if v6 == "thread" then
        return u2;
    end;
    if p5 then
        return p5;
    end;
    if v6 == "Instance" then
        return "Destroy";
    end;
    if v6 == "RBXScriptConnection" then
        return "Disconnect";
    end;
    if v6 == "table" then
        for _, v7 in u3 do
            if typeof(p4[v7]) == "function" then
                return v7;
            end;
        end;
    end;
    error(`failed to get cleanup function for object {v6}: {p4}`, 3);
end;
local u9 = {};
u9.__index = u9;
function u9.new() --[[ Line: 178 ]]
    -- upvalues: u9 (copy)
    local v10 = setmetatable({}, u9);
    v10._objects = {};
    v10._cleaning = false;
    return v10;
end;
function u9.Add(p11, p12, p13) --[[ Line: 237 ]]
    -- upvalues: u8 (copy)
    if p11._cleaning then
        error("cannot call trove:Add() while cleaning", 2);
    end;
    local v14 = { p12, (u8(p12, p13)) };
    table.insert(p11._objects, v14);
    return p12;
end;
function u9.Clone(p15, p16) --[[ Line: 259 ]]
    if p15._cleaning then
        error("cannot call trove:Clone() while cleaning", 2);
    end;
    return p15:Add(p16:Clone());
end;
function u9.Construct(p17, p18, ...) --[[ Line: 302 ]]
    if p17._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;
    local v19 = nil;
    local v20 = type(p18);
    if v20 == "table" then
        v19 = p18.new(...);
    elseif v20 == "function" then
        v19 = p18(...);
    end;
    return p17:Add(v19);
end;
function u9.Connect(p21, p22, p23) --[[ Line: 335 ]]
    if p21._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;
    return p21:Add(p22:Connect(p23));
end;
function u9.BindToRenderStep(p24, u25, p26, p27) --[[ Line: 358 ]]
    -- upvalues: l__RunService__1 (copy)
    if p24._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2);
    end;
    l__RunService__1:BindToRenderStep(u25, p26, p27);
    p24:Add(function() --[[ Line: 365 ]]
        -- upvalues: l__RunService__1 (ref), u25 (copy)
        l__RunService__1:UnbindFromRenderStep(u25);
    end);
end;
function u9.AddPromise(u28, u29) --[[ Line: 395 ]]
    if u28._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2);
    end;
    if typeof(u29) ~= "table" or (typeof(u29.getStatus) ~= "function" or (typeof(u29.finally) ~= "function" or typeof(u29.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;
    if u29:getStatus() == "Started" then
        u29:finally(function() --[[ Line: 402 ]]
            -- upvalues: u28 (copy), u29 (copy)
            if u28._cleaning then
            else
                u28:_findAndRemoveFromObjects(u29, false);
            end;
        end);
        u28:Add(u29, "cancel");
    end;
    return u29;
end;
function u9.Remove(p30, p31) --[[ Line: 427 ]]
    if p30._cleaning then
        error("cannot call trove:Remove() while cleaning", 2);
    end;
    return p30:_findAndRemoveFromObjects(p31, true);
end;
function u9.Extend(_, p32) --[[ Line: 456 ]]
    -- upvalues: u9 (copy)
    if p32._cleaning then
        error("cannot call trove:Extend() while cleaning", 2);
    end;
    return p32:Construct(u9);
end;
function u9.Clean(p33) --[[ Line: 476 ]]
    if p33._cleaning then
    else
        p33._cleaning = true;
        for _, v34 in p33._objects do
            p33:_cleanupObject(v34[1], v34[2]);
        end;
        table.clear(p33._objects);
        p33._cleaning = false;
    end;
end;
function u9._findAndRemoveFromObjects(p35, p36, p37) --[[ Line: 491 ]]
    local l___objects__2 = p35._objects;
    for v38, v39 in ipairs(l___objects__2) do
        if v39[1] == p36 then
            local v40 = #l___objects__2;
            l___objects__2[v38] = l___objects__2[v40];
            l___objects__2[v40] = nil;
            if p37 then
                p35:_cleanupObject(v39[1], v39[2]);
            end;
            return true;
        end;
    end;
    return false;
end;
function u9._cleanupObject(_, p41, p42) --[[ Line: 511 ]]
    -- upvalues: u1 (copy), u2 (copy)
    if p42 == u1 then
        p41();
    elseif p42 == u2 then
        pcall(task.cancel, p41);
    else
        p41[p42](p41);
    end;
end;
function u9.AttachToInstance(u43, p44) --[[ Line: 551 ]]
    if u43._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p44:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2);
    end;
    return u43:Connect(p44.Destroying, function() --[[ Line: 558 ]]
        -- upvalues: u43 (copy)
        u43:Destroy();
    end);
end;
function u9.Destroy(p45) --[[ Line: 572 ]]
    p45:Clean();
end;
function u9.Sweep(p46) --[[ Line: 585 ]]
    p46:Clean();
end;
function u9.Mark(p47, ...) --[[ Line: 599 ]]
    p47:Add(...);
end;
return {
    new = u9.new
};
