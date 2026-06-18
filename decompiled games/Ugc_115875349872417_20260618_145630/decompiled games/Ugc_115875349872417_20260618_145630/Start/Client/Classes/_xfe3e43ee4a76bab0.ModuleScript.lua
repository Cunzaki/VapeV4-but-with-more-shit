-- Decompiled from: Start.Client.Classes._xfe3e43ee4a76bab0
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__ItemData__1 = script.Parent.Parent.ItemData;
local u1 = {};
u1.__index = u1;
local u2 = {
    melee = {
        Nothing = l__ItemData__1.Melee._x0f44a2f8bcb622d2,
        Redliner = l__ItemData__1.Melee._xaa9f8acded4f50b4
    },
    gun = {
        BaseGun = l__ItemData__1.Gun._xd5deee1778c08157,
        Castigate = l__ItemData__1.Gun._xbf83c08db8f70eee,
        Phoenix = l__ItemData__1.Gun._xccb718cf7cce9fe2,
        Siege = l__ItemData__1.Gun._x99eaf9091e0ef826,
        Monarch = l__ItemData__1.Gun._x1993fc527250dfd8
    },
    augment = {
        Grappler = l__ItemData__1.Augment._x693e91af424e6c41
    }
};
function u1._x90d4581ac99dd483() --[[ Line: 25 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._xb533be8f3bc27052(_, p3, p4) --[[ Line: 31 ]]
    -- upvalues: u2 (copy)
    if u2[p3] then
        return u2[p3][p4];
    else
        return nil;
    end;
end;
function u1._xc6aa91db85cc914a(_, p5) --[[ Line: 38 ]]
    -- upvalues: u2 (copy)
    for v6, v7 in pairs(u2) do
        for v8, _ in pairs(v7) do
            if v8 == p5 then
                return v6;
            end;
        end;
    end;
    return nil;
end;
function u1._xe53615d96cf36a6b(_) --[[ Line: 49 ]] end;
return u1;
