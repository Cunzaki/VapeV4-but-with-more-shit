-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Spring
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__Eq__1 = require(script:WaitForChild("Eq"));
local l__sqrt__2 = math.sqrt;
local v1 = {};
local u2 = {};
function u2.__index(u3, p4) --[[ Line: 150 ]]
    -- upvalues: l__sqrt__2 (copy), u2 (copy)
    local v9 = {
        Offset = function() --[[ Line: 152 ]]
            -- upvalues: u3 (copy)
            local v5 = tick() - u3.StartTick;
            return u3.F.Offset(v5);
        end,
        Velocity = function() --[[ Line: 158 ]]
            -- upvalues: u3 (copy)
            local v6 = tick() - u3.StartTick;
            return u3.F.Velocity(v6);
        end,
        Acceleration = function() --[[ Line: 164 ]]
            -- upvalues: u3 (copy)
            local v7 = tick() - u3.StartTick;
            return u3.F.Acceleration(v7);
        end,
        Goal = function() --[[ Line: 170 ]]
            -- upvalues: u3 (copy)
            return u3.ExternalForce / u3.Constant;
        end,
        Frequency = function() --[[ Line: 175 ]]
            -- upvalues: u3 (copy), l__sqrt__2 (ref)
            local l__Damping__3 = u3.Damping;
            local v8 = l__Damping__3 * l__Damping__3 + 4 * u3.Constant / u3.Mass;
            if v8 > 0 then
                return l__sqrt__2(v8) / 6.283185307179586;
            else
                return l__sqrt__2(-v8) / 6.283185307179586;
            end;
        end,
        Amplitude = function() --[[ Line: 186 ]]
            -- upvalues: u3 (copy)
            local l__InitialOffset__4 = u3.InitialOffset;
            return math.sqrt(l__InitialOffset__4 * l__InitialOffset__4 + ((u3.InitialVelocity + 0.5 * u3.Damping * l__InitialOffset__4) / u3.Frequency) ^ 2);
        end
    };
    local v10 = rawget(u3, p4);
    if v10 == nil then
        local v11 = v9[p4];
        if v11 == nil then
            return u2[p4];
        else
            return v11();
        end;
    else
        return v10;
    end;
end;
function u2.__tostring(p12) --[[ Line: 206 ]]
    local v13 = tick() - p12.StartTick;
    local l__F__5 = p12.F;
    local l__AdvancedObjectStringEnabled__6 = p12.AdvancedObjectStringEnabled;
    local v14 = nil;
    if l__AdvancedObjectStringEnabled__6 == false then
        return string.format(".\n------------------------\nSPRING PROPERTIES BASIC:\n------------------------\n[DELTA PROPERTIES]:\n\t--> [OFFSET]: %.3f\n\t--> [VELOCITY]: %.3f\n\t--> [ACCELERATION]: %.3f\n", l__F__5.Offset(v13), l__F__5.Velocity(v13), l__F__5.Acceleration(v13));
    end;
    if l__AdvancedObjectStringEnabled__6 == true then
        v14 = string.format(".\n---------------------------\nSPRING PROPERTIES ADVANCED:\n---------------------------\n[BASE PROPERTIES]:\n\t--> MASS: %.3f\n\t--> DAMPING: %.3f\n\t--> STIFFNESS: %.3f\n\t--> FREQUENCY: %.3f\n\t--> AMPLITUDE: %.3f\n\t--> GOAL: %.3f\n\t--> INITIAL OFFSET: %.3f\n\t--> INITIAL VELOCITY: %.3f\n\t--> EXTERNAL FORCE: %.3f\n\t--> START TICK: %f\n[DELTA PROPERTIES]:\n\t--> [OFFSET]: %.3f\n\t--> [VELOCITY]: %.3f\n\t--> [ACCELERATION]: %.3f\n", p12.Mass, p12.Damping, p12.Constant, p12.Frequency, p12.Amplitude, p12.Goal, p12.InitialOffset, p12.InitialVelocity, p12.ExternalForce, p12.StartTick, l__F__5.Offset(v13), l__F__5.Velocity(v13), l__F__5.Acceleration(v13));
    end;
    return v14;
end;
function v1.new(p15, p16, p17, p18, p19, p20) --[[ Line: 245 ]]
    -- upvalues: u2 (copy)
    assert(p15 > 0, "Mass for spring system cannot be less than or equal to 0");
    assert(p17 > 0, "Spring constant for spring system cannot be less than or equal to 0");
    local v21 = p20 or 0;
    local v22 = {
        AdvancedObjectStringEnabled = false,
        StartTick = 0,
        Mass = p15,
        Damping = p16,
        Constant = p17,
        InitialOffset = (p18 or 0) - v21,
        InitialVelocity = p19 or 0,
        ExternalForce = v21 * p17
    };
    setmetatable(v22, u2);
    v22:Reset();
    return v22;
end;
function v1.fromFrequency(p23, p24, p25, p26, p27, p28) --[[ Line: 285 ]]
    -- upvalues: u2 (copy)
    assert(p23 > 0, "Mass for spring system cannot be less than or equal to 0");
    assert(p25 > 0, "Spring frequency for spring system cannot be less than or equal to 0");
    local v29 = p23 * 0.25 * (39.47841760435743 * p25 * p25 + p24 * p24);
    local v30 = p28 or 0;
    local v31 = {
        AdvancedObjectStringEnabled = false,
        StartTick = 0,
        Mass = p23,
        Damping = p24,
        Constant = v29,
        InitialOffset = (p26 or 0) - v30,
        InitialVelocity = p27 or 0,
        ExternalForce = v30 * v29
    };
    setmetatable(v31, u2);
    v31:Reset();
    return v31;
end;
function u2.Reset(p32) --[[ Line: 324 ]]
    -- upvalues: l__Eq__1 (copy)
    p32.F = l__Eq__1.F(p32);
    p32.StartTick = tick();
end;
function u2.SetExternalForce(p33, p34) --[[ Line: 334 ]]
    p33.ExternalForce = p34;
    p33.InitialOffset = p33.Offset - p34 / p33.Constant;
    p33.InitialVelocity = p33.Velocity;
    p33:Reset();
end;
function u2.SetGoal(p35, p36) --[[ Line: 347 ]]
    p35.ExternalForce = p36 * p35.Constant;
    p35.InitialOffset = p35.Offset - p36;
    p35.InitialVelocity = p35.Velocity;
    p35:Reset();
end;
function u2.SetFrequency(p37, p38) --[[ Line: 361 ]]
    p37.Constant = 0.25 * p37.Mass * (39.47841760435743 * p38 * p38 + p37.Damping * p37.Damping);
    p37.InitialOffset = p37.Offset;
    p37.InitialVelocity = p37.Velocity;
    p37:Reset();
end;
function u2.SnapToCriticalDamping(p39) --[[ Line: 375 ]]
    -- upvalues: l__sqrt__2 (copy)
    p39.Damping = l__sqrt__2(p39.Constant / p39.Mass) * 2;
    p39.InitialOffset = p39.Offset;
    p39.InitialVelocity = p39.Velocity;
    p39:Reset();
end;
function u2.SetOffset(p40, p41, p42) --[[ Line: 387 ]]
    p40.InitialOffset = p41 - p40.Goal;
    p40.InitialVelocity = p42 and 0 or p40.Velocity;
    p40:Reset();
end;
function u2.SetOffsetAndMaintainAmplitude(p43, p44) --[[ Line: 400 ]]
    -- upvalues: l__sqrt__2 (copy)
    if p43.Amplitude < p44 then
        error("Offset cannot be greater than amplitude");
    end;
    local l__Amplitude__7 = p43.Amplitude;
    local l__Damping__8 = p43.Damping;
    local l__Frequency__9 = p43.Frequency;
    local l__Velocity__10 = p43.Velocity;
    local v45 = l__Frequency__9 * l__sqrt__2(l__Amplitude__7 * l__Amplitude__7 - p44 * p44) - 0.5 * l__Damping__8 * p44;
    local v46 = -l__Frequency__9 * l__sqrt__2(l__Amplitude__7 * l__Amplitude__7 - p44 * p44) - 0.5 * l__Damping__8 * p44;
    p43.InitialOffset = p44;
    if math.sign(l__Velocity__10) == math.sign(v45) then
        v46 = v45 or v46;
    end;
    p43.InitialVelocity = v46;
    p43:Reset();
end;
function u2.SetOffsetAndAmplitude(p47, p48, p49) --[[ Line: 424 ]]
    -- upvalues: l__sqrt__2 (copy)
    if p49 < p48 then
        error("Offset cannot be greater than amplitude");
    end;
    local l__Damping__11 = p47.Damping;
    local l__Frequency__12 = p47.Frequency;
    local l__Velocity__13 = p47.Velocity;
    local v50 = l__Frequency__12 * l__sqrt__2(p49 * p49 - p48 * p48) - 0.5 * l__Damping__11 * p48;
    local v51 = -l__Frequency__12 * l__sqrt__2(p49 * p49 - p48 * p48) - 0.5 * l__Damping__11 * p48;
    p47.InitialOffset = p48;
    if math.sign(l__Velocity__13) == math.sign(v50) then
        v51 = v50 or v51;
    end;
    p47.InitialVelocity = v51;
    p47:Reset();
end;
function u2.AddOffset(p52, p53) --[[ Line: 445 ]]
    p52.InitialOffset = p52.Offset + p53;
    p52.InitialVelocity = p52.Velocity;
    p52:Reset();
end;
function u2.SetVelocity(p54, p55) --[[ Line: 456 ]]
    p54.InitialOffset = p54.Offset;
    p54.InitialVelocity = p55;
    p54:Reset();
end;
function u2.AddVelocity(p56, p57) --[[ Line: 467 ]]
    p56.InitialOffset = p56.Offset;
    p56.InitialVelocity = p56.Velocity + p57;
    p56:Reset();
end;
function u2.Print(p58) --[[ Line: 476 ]]
    local v59 = tostring(p58);
    print(v59);
end;
return v1;
