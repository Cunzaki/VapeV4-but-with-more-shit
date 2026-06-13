-- Decompiled from: ReplicatedStorage.Modules.Spring
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
function u1.new(p2, p3, p4, p5) --[[ Line: 5 ]]
    -- upvalues: u1 (copy)
    local v6 = {
        Mass = p2 or 1,
        Damping = p3 or 0.8,
        Stiffness = p4 or 0.2,
        Position = Vector2.new(),
        Velocity = Vector2.new(),
        Target = p5 or Vector2.new()
    };
    setmetatable(v6, {
        __index = u1
    });
    return v6;
end;
function u1.Push(p7, p8) --[[ Line: 20 ]]
    p7.Velocity = p7.Velocity + p8 / p7.Mass;
end;
function u1.SetTarget(p9, p10) --[[ Line: 26 ]]
    p9.Target = p10;
end;
function u1.Update(p11, p12) --[[ Line: 31 ]]
    local v13 = p12 or 1;
    p11.Velocity = p11.Velocity + ((p11.Target - p11.Position) * p11.Stiffness + -p11.Velocity * p11.Damping) / p11.Mass * v13;
    p11.Position = p11.Position + p11.Velocity * v13;
    p11.Velocity = p11.Velocity * 0.99 ^ v13;
end;
return u1;
