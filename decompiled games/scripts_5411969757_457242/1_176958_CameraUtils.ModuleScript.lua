-- Decompiled with Potassium's decompiler.

local u1 = {};
local v2, v3 = pcall(function() --[[ Line: 9 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local u4 = v2 and v3;
local u5 = {};
u5.__index = u5;
function u5.new(p6, p7) --[[ Line: 24 ]]
    -- upvalues: u5 (copy)
    return setmetatable({
        vel = 0,
        freq = p6,
        goal = p7,
        pos = p7
    }, u5);
end;
function u5.step(p8, p9) --[[ Line: 34 ]]
    local v10 = p8.freq * 2 * 3.141592653589793;
    local l__goal__1 = p8.goal;
    local l__pos__2 = p8.pos;
    local l__vel__3 = p8.vel;
    local v11 = l__pos__2 - l__goal__1;
    local v12 = math.exp(-v10 * p9);
    local v13 = (v11 * (1 + v10 * p9) + l__vel__3 * p9) * v12 + l__goal__1;
    local v14 = (l__vel__3 * (1 - v10 * p9) - v11 * (v10 * v10 * p9)) * v12;
    p8.pos = v13;
    p8.vel = v14;
    return v13;
end;
u1.Spring = u5;
function u1.map(p15, p16, p17, p18, p19) --[[ Line: 56 ]]
    return (p15 - p16) * (p19 - p18) / (p17 - p16) + p18;
end;
function u1.Round(p20, p21) --[[ Line: 61 ]]
    local v22 = 10 ^ p21;
    return math.floor(p20 * v22 + 0.5) / v22;
end;
function u1.IsFinite(p23) --[[ Line: 66 ]]
    local v24;
    if p23 == p23 and p23 ~= (1 / 0) then
        v24 = p23 ~= (-1 / 0);
    else
        v24 = false;
    end;
    return v24;
end;
function u1.IsFiniteVector3(p25) --[[ Line: 70 ]]
    -- upvalues: u1 (copy)
    local v26 = u1.IsFinite(p25.X) and u1.IsFinite(p25.Y);
    if v26 then
        v26 = u1.IsFinite(p25.Z);
    end;
    return v26;
end;
function u1.GetAngleBetweenXZVectors(p27, p28) --[[ Line: 75 ]]
    return math.atan2(p28.X * p27.Z - p28.Z * p27.X, p28.X * p27.X + p28.Z * p27.Z);
end;
function u1.RotateVectorByAngleAndRound(p29, p30, p31) --[[ Line: 79 ]]
    if p29.Magnitude <= 0 then
        return 0;
    end;
    local l__unit__4 = p29.unit;
    local v32 = math.atan2(l__unit__4.z, l__unit__4.x);
    local v33 = (math.atan2(l__unit__4.z, l__unit__4.x) + p30) / p31 + 0.5;
    return math.floor(v33) * p31 - v32;
end;
function u1.GamepadLinearToCurve(p34) --[[ Line: 110 ]]
    local l__new__5 = Vector2.new;
    local l__x__6 = p34.x;
    local v35 = l__x__6 < 0 and -1 or 1;
    local v36 = math.abs(l__x__6);
    local v37 = (math.abs(v36) * 2 - 1) * 1.1 - 0.1;
    local v38 = math.clamp(v37, -1, 1);
    local v39;
    if v38 >= 0 then
        v39 = 0.35 * v38 / (0.35 - v38 + 1);
    else
        v39 = -(0.8 * -v38 / (0.8 + v38 + 1));
    end;
    local v40 = math.clamp((v39 / 2 + 0.5) * v35, -1, 1);
    local l__y__7 = p34.y;
    local v41 = l__y__7 < 0 and -1 or 1;
    local v42 = math.abs(l__y__7);
    local v43 = (math.abs(v42) * 2 - 1) * 1.1 - 0.1;
    local v44 = math.clamp(v43, -1, 1);
    local v45;
    if v44 >= 0 then
        v45 = 0.35 * v44 / (0.35 - v44 + 1);
    else
        v45 = -(0.8 * -v44 / (0.8 + v44 + 1));
    end;
    return l__new__5(v40, (math.clamp((v45 / 2 + 0.5) * v41, -1, 1)));
end;
function u1.ConvertCameraModeEnumToStandard(p46) --[[ Line: 124 ]]
    -- upvalues: u4 (ref)
    if p46 == Enum.TouchCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Follow;
    elseif p46 == Enum.ComputerCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Classic;
    elseif p46 == Enum.TouchCameraMovementMode.Classic or (p46 == Enum.DevTouchCameraMovementMode.Classic or (p46 == Enum.DevComputerCameraMovementMode.Classic or p46 == Enum.ComputerCameraMovementMode.Classic)) then
        return Enum.ComputerCameraMovementMode.Classic;
    elseif p46 == Enum.TouchCameraMovementMode.Follow or (p46 == Enum.DevTouchCameraMovementMode.Follow or (p46 == Enum.DevComputerCameraMovementMode.Follow or p46 == Enum.ComputerCameraMovementMode.Follow)) then
        return Enum.ComputerCameraMovementMode.Follow;
    elseif p46 == Enum.TouchCameraMovementMode.Orbital or (p46 == Enum.DevTouchCameraMovementMode.Orbital or (p46 == Enum.DevComputerCameraMovementMode.Orbital or p46 == Enum.ComputerCameraMovementMode.Orbital)) then
        return Enum.ComputerCameraMovementMode.Orbital;
    elseif u4 and (p46 == Enum.ComputerCameraMovementMode.CameraToggle or p46 == Enum.DevComputerCameraMovementMode.CameraToggle) then
        return Enum.ComputerCameraMovementMode.CameraToggle;
    elseif p46 == Enum.DevTouchCameraMovementMode.UserChoice or p46 == Enum.DevComputerCameraMovementMode.UserChoice then
        return Enum.DevComputerCameraMovementMode.UserChoice;
    else
        return Enum.ComputerCameraMovementMode.Classic;
    end;
end;
return u1;