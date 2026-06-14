-- Decompiled from: ReplicatedStorage.Modules.SpringVector3
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2, p3, p4, p5) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    local v6 = setmetatable({}, u1);
    v6.target = p2 or Vector3.new();
    v6.position = p3 or v6.target;
    v6.velocity = Vector3.new();
    v6.stiffness = p4 or 10;
    v6.damping = p5 or 2;
    v6.connection = nil;
    return v6;
end;
function u1.SetTarget(p7, p8) --[[ Line: 16 ]]
    p7.target = p8;
end;
function u1.Push(p9, p10) --[[ Line: 20 ]]
    p9.velocity = p9.velocity + p10;
end;
function u1.Destroy(p11) --[[ Line: 24 ]]
    if p11.connection then
        p11.connection:Disconnect();
        p11.connection = nil;
    end;
end;
function u1.Update(p12, p13) --[[ Line: 31 ]]
    p12.velocity = p12.velocity + (-p12.stiffness * (p12.position - p12.target) + -p12.damping * p12.velocity) / 1 * p13;
    p12.position = p12.position + p12.velocity * p13;
    return p12.position;
end;
return u1;
