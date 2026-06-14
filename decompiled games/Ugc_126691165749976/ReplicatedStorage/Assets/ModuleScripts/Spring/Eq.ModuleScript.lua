-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Spring.Eq
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local v1 = {};
function OverDamping(p2, p3, p4, p5, p6, p7)
    local v8 = p3 * p3 - p4 * 4 / p2;
    local v9 = p3 + math.sqrt(v8);
    local v10 = p3 - math.sqrt(v8);
    local u11 = v9 * -0.5;
    local u12 = v10 * -0.5;
    local u13 = (u12 * p5 - p6) / (u12 - u11);
    local u14 = (u11 * p5 - p6) / (u11 - u12);
    local u15 = p7 / p4;
    return {
        Offset = function(p16) --[[ Name: Offset, Line 47 ]]
            -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy), u15 (copy)
            return u13 * math.exp(u11 * p16) + u14 * math.exp(u12 * p16) + u15;
        end,
        Velocity = function(p17) --[[ Name: Velocity, Line 50 ]]
            -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy)
            return u13 * u11 * math.exp(u11 * p17) + u14 * u12 * math.exp(u12 * p17);
        end,
        Acceleration = function(p18) --[[ Name: Acceleration, Line 53 ]]
            -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy)
            return u13 * u11 * u11 * math.exp(u11 * p18) + u14 * u12 * u12 * math.exp(u12 * p18);
        end
    };
end;
function CriticalDamping(_, p19, p20, u21, p22, p23)
    local u24 = -p19 / 2;
    local u25 = p22 - u24 * u21;
    local u26 = p23 / p20;
    return {
        Offset = function(p27) --[[ Name: Offset, Line 66 ]]
            -- upvalues: u24 (copy), u21 (copy), u25 (copy), u26 (copy)
            return math.exp(u24 * p27) * (u21 + u25 * p27) + u26;
        end,
        Velocity = function(p28) --[[ Name: Velocity, Line 69 ]]
            -- upvalues: u24 (copy), u25 (copy), u21 (copy)
            return math.exp(u24 * p28) * (u25 * u24 * p28 + u21 * u24 + u25);
        end,
        Acceleration = function(p29) --[[ Name: Acceleration, Line 72 ]]
            -- upvalues: u24 (copy), u25 (copy), u21 (copy)
            return u24 * math.exp(u24 * p29) * (u25 * u24 * p29 + u21 * u24 + u25 * 2);
        end
    };
end;
function UnderDamping(p30, p31, p32, u33, p34, p35)
    local v36 = p31 * p31 - p32 * 4 / p30;
    local u37 = -p31 / 2;
    local u38 = math.sqrt(-v36);
    local u39 = (p34 - u37 * u33) / u38;
    local u40 = p35 / p32;
    return {
        Offset = function(p41) --[[ Name: Offset, Line 87 ]]
            -- upvalues: u37 (copy), u33 (copy), u38 (copy), u39 (copy), u40 (copy)
            return math.exp(u37 * p41) * (u33 * math.cos(u38 * p41) + u39 * math.sin(u38 * p41)) + u40;
        end,
        Velocity = function(p42) --[[ Name: Velocity, Line 90 ]]
            -- upvalues: u37 (copy), u33 (copy), u38 (copy), u39 (copy)
            return -math.exp(u37 * p42) * ((u33 * u38 - u39 * u37) * math.sin(u38 * p42) + (-u39 * u38 - u33 * u37) * math.cos(u38 * p42));
        end,
        Acceleration = function(p43) --[[ Name: Acceleration, Line 93 ]]
            -- upvalues: u37 (copy), u39 (copy), u38 (copy), u33 (copy)
            return -math.exp(u37 * p43) * ((u39 * u38 * u38 + u33 * 2 * u37 * u38 - u39 * u37 * u37) * math.sin(u38 * p43) + (u33 * u38 * u38 - u39 * 2 * u37 * u38 - u33 * u37 * u37) * math.cos(u38 * p43));
        end
    };
end;
function v1.F(p44) --[[ Line: 100 ]]
    local l__InitialOffset__1 = p44.InitialOffset;
    local l__InitialVelocity__2 = p44.InitialVelocity;
    local l__ExternalForce__3 = p44.ExternalForce;
    local l__Mass__4 = p44.Mass;
    local l__Damping__5 = p44.Damping;
    local l__Constant__6 = p44.Constant;
    local v45 = l__Damping__5 * l__Damping__5 - l__Constant__6 * 4 / l__Mass__4;
    if v45 > 0 then
        return OverDamping(l__Mass__4, l__Damping__5, l__Constant__6, l__InitialOffset__1, l__InitialVelocity__2, l__ExternalForce__3);
    elseif v45 == 0 then
        return CriticalDamping(l__Mass__4, l__Damping__5, l__Constant__6, l__InitialOffset__1, l__InitialVelocity__2, l__ExternalForce__3);
    else
        return UnderDamping(l__Mass__4, l__Damping__5, l__Constant__6, l__InitialOffset__1, l__InitialVelocity__2, l__ExternalForce__3);
    end;
end;
return v1;
