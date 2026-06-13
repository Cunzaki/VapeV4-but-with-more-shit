-- Decompiled from: ReplicatedStorage.Modules.Mince.Remote
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Signal__1 = require(script.Parent.Signal);
require(script.Parent.Identity);
require(script.Parent.RefMutate);
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 9 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:__Create();
    return v2;
end;
function u1.__Create(p3) --[[ Line: 15 ]]
    -- upvalues: l__Signal__1 (copy)
    p3.Event = l__Signal__1.new();
    p3.Extenders = {};
    p3.DoesExtend = false;
end;
return u1;
