-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Trove
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = newproxy();
local u2 = newproxy();
local u3 = table.freeze({
    "Destroy",
    "Disconnect",
    "destroy",
    "disconnect",
    "DisconnectAll"
});
local function u11(p4, p5) --[[ Line: 125 ]]
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
        for _, v7 in ipairs(u3) do
            local v8 = rawget(p4, v7);
            if typeof(v8) == "function" then
                return v7;
            end;
            local v9 = getmetatable(p4);
            if v9 then
                local v10 = rawget(v9, v7);
                if typeof(v10) == "function" then
                    return v7;
                end;
            end;
        end;
    end;
    error(`failed to get cleanup function for object {v6}: {p4}`, 3);
end;
local u12 = {};
u12.__index = u12;
function u12.new() --[[ Line: 191 ]]
    -- upvalues: u12 (copy)
    local v13 = setmetatable({}, u12);
    v13._objects = {};
    v13._cleaning = false;
    return v13;
end;
function u12.Add(p14, p15, p16) --[[ Line: 250 ]]
    -- upvalues: u11 (copy)
    if p14._cleaning then
        error("cannot call trove:Add() while cleaning", 2);
    end;
    local v17 = { p15, (u11(p15, p16)) };
    table.insert(p14._objects, v17);
    return p15;
end;
function u12.Clone(p18, p19) --[[ Line: 272 ]]
    if p18._cleaning then
        error("cannot call trove:Clone() while cleaning", 2);
    end;
    return p18:Add(p19:Clone());
end;
function u12.Construct(p20, p21, ...) --[[ Line: 315 ]]
    if p20._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;
    local v22 = nil;
    local v23 = type(p21);
    if v23 == "table" then
        v22 = p21.new(...);
    elseif v23 == "function" then
        v22 = p21(...);
    end;
    return p20:Add(v22);
end;
function u12.Connect(p24, p25, p26) --[[ Line: 348 ]]
    if p24._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;
    return p24:Add(p25:Connect(p26));
end;
function u12.BindToRenderStep(p27, u28, p29, p30) --[[ Line: 371 ]]
    -- upvalues: l__RunService__1 (copy)
    if p27._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2);
    end;
    l__RunService__1:BindToRenderStep(u28, p29, p30);
    p27:Add(function() --[[ Line: 378 ]]
        -- upvalues: l__RunService__1 (ref), u28 (copy)
        l__RunService__1:UnbindFromRenderStep(u28);
    end;
end;
function u12.AddPromise(u31, u32) --[[ Line: 408 ]]
    if u31._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2);
    end;
    if typeof(u32) ~= "table" or (typeof(u32.getStatus) ~= "function" or (typeof(u32.finally) ~= "function" or typeof(u32.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;
    if u32:getStatus() == "Started" then
        u32:finally(function() --[[ Line: 415 ]]
            -- upvalues: u31 (copy), u32 (copy)
            if u31._cleaning then
            else
                u31:_findAndRemoveFromObjects(u32, false);
            end;
        end;
        u31:Add(u32, "cancel");
    end;
    return u32;
end;
function u12.Remove(p33, p34) --[[ Line: 440 ]]
    if p33._cleaning then
        error("cannot call trove:Remove() while cleaning", 2);
    end;
    return p33:_findAndRemoveFromObjects(p34, true);
end;
function u12.Extend(p35) --[[ Line: 469 ]]
    -- upvalues: u12 (copy)
    if p35._cleaning then
        error("cannot call trove:Extend() while cleaning", 2);
    end;
    return p35:Construct(u12);
end;
function u12.Clean(p36) --[[ Line: 489 ]]
    if p36._cleaning then
    else
        p36._cleaning = true;
        for _, v37 in p36._objects do
            p36:_cleanupObject(v37[1], v37[2]);
        end;
        table.clear(p36._objects);
        p36._cleaning = false;
    end;
end;
function u12.WrapClean(u38) --[[ Line: 531 ]]
    return function() --[[ Line: 532 ]]
        -- upvalues: u38 (copy)
        u38:Clean();
    end;
end;
function u12._findAndRemoveFromObjects(p39, p40, p41) --[[ Line: 537 ]]
    local l___objects__2 = p39._objects;
    for v42, v43 in l___objects__2 do
        if v43[1] == p40 then
            local v44 = #l___objects__2;
            l___objects__2[v42] = l___objects__2[v44];
            l___objects__2[v44] = nil;
            if p41 then
                p39:_cleanupObject(v43[1], v43[2]);
            end;
            return true;
        end;
    end;
    return false;
end;
function u12._cleanupObject(_, p45, p46) --[[ Line: 557 ]]
    -- upvalues: u1 (copy), u2 (copy)
    if p46 == u1 then
        task.spawn(p45);
    elseif p46 == u2 then
        pcall(task.cancel, p45);
    else
        p45[p46](p45);
    end;
end;
function u12.AttachToInstance(u47, p48) --[[ Line: 597 ]]
    if u47._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p48:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2);
    end;
    return u47:Connect(p48.Destroying, function() --[[ Line: 604 ]]
        -- upvalues: u47 (copy)
        u47:Destroy();
    end;
end;
function u12.Destroy(p49) --[[ Line: 618 ]]
    p49:Clean();
end;
return {
    new = u12.new
};
