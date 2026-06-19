-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__PackageControls__2 = l__obtain__1("GameControl").PackageControls;
local v1 = l__obtain__1("Class")();
function v1.GetPV(p2) --[[ Line: 10 ]]
    local l__Phys__3 = p2.SmoothingSimulation.Phys;
    return l__Phys__3.Position, l__Phys__3.Velocity;
end;
function v1.GetPVScaled(p3) --[[ Line: 14 ]]
    local l__Phys__4 = p3.SmoothingSimulation.Phys;
    return l__Phys__4.Position, l__Phys__4.Velocity * p3.SmoothingSimulation.Timer:GetGlobalScale();
end;
function v1.GetGravity(p4) --[[ Line: 18 ]]
    return p4.SmoothingSimulation.Phys.EffectiveGravity;
end;
function v1.GetAngles(p5) --[[ Line: 21 ]]
    return p5.SmoothingSimulation.Camera.Angles;
end;
function v1.GetCFrame(p6) --[[ Line: 24 ]]
    local l__Phys__5 = p6.SmoothingSimulation.Phys;
    return p6.SmoothingSimulation.Camera:GetCFrame() + l__Phys__5.Position;
end;
function v1.GetInput(p7) --[[ Line: 28 ]]
    -- upvalues: l__PackageControls__2 (copy)
    return l__PackageControls__2(p7.Simulation.GameMechanics.GameControls);
end;
function v1.GetOutput(p8) --[[ Line: 32 ]]
    local l__Simulation__6 = p8.Simulation;
    local l__Phys__7 = l__Simulation__6.Phys;
    return l__Phys__7.Time, l__Phys__7.GameMechanics:MakeTickInfo(), l__Simulation__6.Camera.Angles, l__Phys__7.Position, l__Phys__7.Velocity, l__Phys__7.Acceleration;
end;
function v1.GetControlState(p9, p10) --[[ Line: 42 ]]
    return p9.SmoothingSimulation.GameMechanics.GameControls[p10];
end;
function v1.GetMousePos(p11, p12) --[[ Line: 47 ]]
    return p11.Simulation.GameMechanics:GetMousePos(p12);
end;
function v1.Constructor(p13, p14, p15) --[[ Line: 51 ]]
    p13.Type = "Realtime";
    p13.Timer = p15.Timer;
    p13.Simulation = p14;
    p13.SmoothingSimulation = p15;
end;
return v1;
