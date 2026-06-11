-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.CameraModule.OrbitalCamera
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v1, v2 = pcall(function() --[[ Line: 7 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor2");
end);
local u3 = v1 and v2;
local u4 = Vector2.new(0, 0);
local l__CameraUtils__1 = require(script.Parent:WaitForChild("CameraUtils"));
local l__CameraInput__2 = require(script.Parent:WaitForChild("CameraInput"));
local l__Players__3 = game:GetService("Players");
local l__VRService__4 = game:GetService("VRService");
local l__BaseCamera__5 = require(script.Parent:WaitForChild("BaseCamera"));
local u5 = setmetatable({}, l__BaseCamera__5);
u5.__index = u5;
function u5.new() --[[ Line: 53 ]]
    -- upvalues: l__BaseCamera__5 (copy), u5 (copy)
    local v6 = l__BaseCamera__5.new();
    local v7 = setmetatable(v6, u5);
    v7.lastUpdate = tick();
    v7.changedSignalConnections = {};
    v7.refAzimuthRad = nil;
    v7.curAzimuthRad = nil;
    v7.minAzimuthAbsoluteRad = nil;
    v7.maxAzimuthAbsoluteRad = nil;
    v7.useAzimuthLimits = nil;
    v7.curElevationRad = nil;
    v7.minElevationRad = nil;
    v7.maxElevationRad = nil;
    v7.curDistance = nil;
    v7.minDistance = nil;
    v7.maxDistance = nil;
    v7.r3ButtonDown = false;
    v7.l3ButtonDown = false;
    v7.gamepadDollySpeedMultiplier = 1;
    v7.lastUserPanCamera = tick();
    v7.externalProperties = {};
    v7.externalProperties.InitialDistance = 25;
    v7.externalProperties.MinDistance = 10;
    v7.externalProperties.MaxDistance = 100;
    v7.externalProperties.InitialElevation = 35;
    v7.externalProperties.MinElevation = 35;
    v7.externalProperties.MaxElevation = 35;
    v7.externalProperties.ReferenceAzimuth = -45;
    v7.externalProperties.CWAzimuthTravel = 90;
    v7.externalProperties.CCWAzimuthTravel = 90;
    v7.externalProperties.UseAzimuthLimits = false;
    v7:LoadNumberValueParameters();
    return v7;
end;
function u5.LoadOrCreateNumberValueParameter(u8, u9, p10, u11) --[[ Line: 95 ]]
    local v12 = script:FindFirstChild(u9);
    if v12 and v12:isA(p10) then
        u8.externalProperties[u9] = v12.Value;
    else
        if u8.externalProperties[u9] == nil then
            return;
        end;
        v12 = Instance.new(p10);
        v12.Name = u9;
        v12.Parent = script;
        v12.Value = u8.externalProperties[u9];
    end;
    if u11 then
        if u8.changedSignalConnections[u9] then
            u8.changedSignalConnections[u9]:Disconnect();
        end;
        u8.changedSignalConnections[u9] = v12.Changed:Connect(function(p13) --[[ Line: 115 ]]
            -- upvalues: u8 (copy), u9 (copy), u11 (copy)
            u8.externalProperties[u9] = p13;
            u11(u8);
        end);
    end;
end;
function u5.SetAndBoundsCheckAzimuthValues(p14) --[[ Line: 122 ]]
    local v15 = math.rad(p14.externalProperties.ReferenceAzimuth);
    local v16 = math.rad(p14.externalProperties.CWAzimuthTravel);
    p14.minAzimuthAbsoluteRad = v15 - math.abs(v16);
    local v17 = math.rad(p14.externalProperties.ReferenceAzimuth);
    local v18 = math.rad(p14.externalProperties.CCWAzimuthTravel);
    p14.maxAzimuthAbsoluteRad = v17 + math.abs(v18);
    p14.useAzimuthLimits = p14.externalProperties.UseAzimuthLimits;
    if p14.useAzimuthLimits then
        p14.curAzimuthRad = math.max(p14.curAzimuthRad, p14.minAzimuthAbsoluteRad);
        p14.curAzimuthRad = math.min(p14.curAzimuthRad, p14.maxAzimuthAbsoluteRad);
    end;
end;
function u5.SetAndBoundsCheckElevationValues(p19) --[[ Line: 132 ]]
    local v20 = math.max(p19.externalProperties.MinElevation, -80);
    local v21 = math.min(p19.externalProperties.MaxElevation, 80);
    local v22 = math.min(v20, v21);
    p19.minElevationRad = math.rad(v22);
    local v23 = math.max(v20, v21);
    p19.maxElevationRad = math.rad(v23);
    p19.curElevationRad = math.max(p19.curElevationRad, p19.minElevationRad);
    p19.curElevationRad = math.min(p19.curElevationRad, p19.maxElevationRad);
end;
function u5.SetAndBoundsCheckDistanceValues(p24) --[[ Line: 148 ]]
    p24.minDistance = p24.externalProperties.MinDistance;
    p24.maxDistance = p24.externalProperties.MaxDistance;
    p24.curDistance = math.max(p24.curDistance, p24.minDistance);
    p24.curDistance = math.min(p24.curDistance, p24.maxDistance);
end;
function u5.LoadNumberValueParameters(p25) --[[ Line: 156 ]]
    p25:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil);
    p25:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil);
    p25:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", p25.SetAndBoundsCheckAzimuthValue);
    p25:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p25.SetAndBoundsCheckAzimuthValues);
    p25:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p25.SetAndBoundsCheckAzimuthValues);
    p25:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p25.SetAndBoundsCheckElevationValues);
    p25:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p25.SetAndBoundsCheckElevationValues);
    p25:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p25.SetAndBoundsCheckDistanceValues);
    p25:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p25.SetAndBoundsCheckDistanceValues);
    p25:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p25.SetAndBoundsCheckAzimuthValues);
    p25.curAzimuthRad = math.rad(p25.externalProperties.ReferenceAzimuth);
    p25.curElevationRad = math.rad(p25.externalProperties.InitialElevation);
    p25.curDistance = p25.externalProperties.InitialDistance;
    p25:SetAndBoundsCheckAzimuthValues();
    p25:SetAndBoundsCheckElevationValues();
    p25:SetAndBoundsCheckDistanceValues();
end;
function u5.GetModuleName(_) --[[ Line: 181 ]]
    return "OrbitalCamera";
end;
function u5.SetInitialOrientation(p26, p27) --[[ Line: 185 ]]
    -- upvalues: l__CameraUtils__1 (copy)
    if p27 and p27.RootPart then
        local l__unit__6 = (p27.RootPart.CFrame.lookVector - Vector3.new(0, 0.23, 0)).unit;
        local v28 = l__CameraUtils__1.GetAngleBetweenXZVectors(l__unit__6, p26:GetCameraLookVector());
        local l__y__7 = p26:GetCameraLookVector().y;
        local v29 = math.asin(l__y__7) - math.asin(l__unit__6.y);
        local v30 = not l__CameraUtils__1.IsFinite(v28) and 0 or v28;
        local v31 = not l__CameraUtils__1.IsFinite(v29) and 0 or v29;
        p26.rotateInput = Vector2.new(v30, v31);
    else
        warn("OrbitalCamera could not set initial orientation due to missing humanoid");
    end;
end;
function u5.GetCameraToSubjectDistance(p32) --[[ Line: 203 ]]
    return p32.curDistance;
end;
function u5.SetCameraToSubjectDistance(p33, p34) --[[ Line: 207 ]]
    -- upvalues: l__Players__3 (copy)
    if l__Players__3.LocalPlayer then
        p33.currentSubjectDistance = math.clamp(p34, p33.minDistance, p33.maxDistance);
        p33.currentSubjectDistance = math.max(p33.currentSubjectDistance, p33.FIRST_PERSON_DISTANCE_THRESHOLD);
    end;
    p33.inFirstPerson = false;
    p33:UpdateMouseBehavior();
    return p33.currentSubjectDistance;
end;
function u5.CalculateNewLookVector(p35, p36, p37) --[[ Line: 220 ]]
    local v38 = p36 or p35:GetCameraLookVector();
    local v39 = math.asin(v38.y);
    local v40 = math.clamp(p37.y, v39 - 1.3962634015954636, v39 - -1.3962634015954636);
    local v41 = Vector2.new(p37.x, v40);
    local v42 = CFrame.new(Vector3.new(0, 0, 0), v38);
    return (CFrame.Angles(0, -v41.x, 0) * v42 * CFrame.Angles(-v41.y, 0, 0)).lookVector;
end;
function u5.GetGamepadPan(p43, _, p44, p45) --[[ Line: 231 ]]
    -- upvalues: u3 (ref), u4 (copy)
    assert(not u3);
    if p45.UserInputType ~= p43.activeGamepad or p45.KeyCode ~= Enum.KeyCode.Thumbstick2 then
        return Enum.ContextActionResult.Pass;
    end;
    if p43.r3ButtonDown or p43.l3ButtonDown then
        if p45.Position.Y > 0.2 then
            p43.gamepadDollySpeedMultiplier = 0.96;
        elseif p45.Position.Y < -0.2 then
            p43.gamepadDollySpeedMultiplier = 1.04;
        else
            p43.gamepadDollySpeedMultiplier = 1;
        end;
    else
        if p44 == Enum.UserInputState.Cancel then
            p43.gamepadPanningCamera = u4;
            return;
        end;
        if Vector2.new(p45.Position.X, -p45.Position.Y).magnitude > 0.2 then
            p43.gamepadPanningCamera = Vector2.new(p45.Position.X, -p45.Position.Y);
        else
            p43.gamepadPanningCamera = u4;
        end;
    end;
    return Enum.ContextActionResult.Sink;
end;
function u5.DoGamepadZoom(p46, _, p47, p48) --[[ Line: 263 ]]
    -- upvalues: u3 (ref)
    assert(not u3);
    if p48.UserInputType ~= p46.activeGamepad or p48.KeyCode ~= Enum.KeyCode.ButtonR3 and p48.KeyCode ~= Enum.KeyCode.ButtonL3 then
        return Enum.ContextActionResult.Pass;
    end;
    if p47 == Enum.UserInputState.Begin then
        p46.r3ButtonDown = p48.KeyCode == Enum.KeyCode.ButtonR3;
        p46.l3ButtonDown = p48.KeyCode == Enum.KeyCode.ButtonL3;
    elseif p47 == Enum.UserInputState.End then
        if p48.KeyCode == Enum.KeyCode.ButtonR3 then
            p46.r3ButtonDown = false;
        elseif p48.KeyCode == Enum.KeyCode.ButtonL3 then
            p46.l3ButtonDown = false;
        end;
        if not (p46.r3ButtonDown or p46.l3ButtonDown) then
            p46.gamepadDollySpeedMultiplier = 1;
        end;
    end;
    return Enum.ContextActionResult.Sink;
end;
function u5.BindGamepadInputActions(u49) --[[ Line: 286 ]]
    -- upvalues: u3 (ref)
    assert(not u3);
    u49:BindAction("OrbitalCamGamepadPan", function(p50, p51, p52) --[[ Line: 289 ]]
        -- upvalues: u49 (copy)
        return u49:GetGamepadPan(p50, p51, p52);
    end, false, Enum.KeyCode.Thumbstick2);
    u49:BindAction("OrbitalCamGamepadZoom", function(p53, p54, p55) --[[ Line: 291 ]]
        -- upvalues: u49 (copy)
        return u49:DoGamepadZoom(p53, p54, p55);
    end, false, Enum.KeyCode.ButtonR3, Enum.KeyCode.ButtonL3);
end;
function u5.Update(p56, _) --[[ Line: 296 ]]
    -- upvalues: u3 (ref), l__CameraInput__2 (copy), l__Players__3 (copy), u4 (copy), l__VRService__4 (copy)
    local v57 = tick();
    local v58 = v57 - p56.lastUpdate;
    local v59;
    if u3 then
        v59 = l__CameraInput__2.getRotation() ~= Vector2.new();
    else
        v59 = p56.userPanningTheCamera == true;
    end;
    local l__CurrentCamera__8 = workspace.CurrentCamera;
    local l__CFrame__9 = l__CurrentCamera__8.CFrame;
    local l__Focus__10 = l__CurrentCamera__8.Focus;
    local l__LocalPlayer__11 = l__Players__3.LocalPlayer;
    local v60;
    if l__CurrentCamera__8 then
        v60 = l__CurrentCamera__8.CameraSubject;
    else
        v60 = l__CurrentCamera__8;
    end;
    local v61;
    if v60 then
        v61 = v60:IsA("VehicleSeat");
    else
        v61 = v60;
    end;
    local v62;
    if v60 then
        v62 = v60:IsA("SkateboardPlatform");
    else
        v62 = v60;
    end;
    if p56.lastUpdate == nil or v58 > 1 then
        p56.lastCameraTransform = nil;
    end;
    if p56.lastUpdate and not u3 then
        local v63 = p56:UpdateGamepad();
        if p56:ShouldUseVRRotation() then
            p56.rotateInput = p56.rotateInput + p56:GetVRRotationInput();
        else
            local v64 = math.min(0.1, v58);
            if v63 ~= u4 then
                p56.rotateInput = p56.rotateInput + v63 * v64;
                v59 = true;
            end;
            local v65 = 0;
            if not (v61 or v62) then
                v65 = v65 + (p56.TurningLeft and -120 or 0) + (p56.TurningRight and 120 or 0);
            end;
            if v65 ~= 0 then
                p56.rotateInput = p56.rotateInput + Vector2.new(math.rad(v65 * v64), 0);
                v59 = true;
            end;
        end;
    end;
    if v59 then
        p56.lastUserPanCamera = tick();
    end;
    local v66 = p56:GetSubjectPosition();
    if v66 and (l__LocalPlayer__11 and l__CurrentCamera__8) then
        if p56.gamepadDollySpeedMultiplier ~= 1 then
            p56:SetCameraToSubjectDistance(p56.currentSubjectDistance * p56.gamepadDollySpeedMultiplier);
        end;
        local l__VREnabled__12 = l__VRService__4.VREnabled;
        l__Focus__10 = l__VREnabled__12 and p56:GetVRFocus(v66, v58) or CFrame.new(v66);
        local v67;
        if u3 then
            v67 = l__CameraInput__2.getRotation();
        else
            v67 = p56.rotateInput;
        end;
        local l__p__13 = l__Focus__10.p;
        if l__VREnabled__12 and not p56:IsInFirstPerson() then
            local v68 = p56:GetCameraHeight();
            local v69 = v66 - l__CurrentCamera__8.CFrame.p;
            local l__magnitude__14 = v69.magnitude;
            if p56.currentSubjectDistance < l__magnitude__14 or v67.x ~= 0 then
                local v70 = math.min(l__magnitude__14, p56.currentSubjectDistance);
                local v71 = p56:CalculateNewLookVector(v69.unit * Vector3.new(1, 0, 1), Vector2.new(v67.x, 0)) * v70;
                local v72 = l__p__13 - v71;
                local l__lookVector__15 = l__CurrentCamera__8.CFrame.lookVector;
                if v67.x == 0 then
                    v71 = l__lookVector__15;
                end;
                local v73 = Vector3.new(v72.x + v71.x, v72.y, v72.z + v71.z);
                if not u3 then
                    p56.rotateInput = u4;
                end;
                l__CFrame__9 = CFrame.new(v72, v73) + Vector3.new(0, v68, 0);
            end;
        else
            p56.curAzimuthRad = p56.curAzimuthRad - v67.x;
            if p56.useAzimuthLimits then
                p56.curAzimuthRad = math.clamp(p56.curAzimuthRad, p56.minAzimuthAbsoluteRad, p56.maxAzimuthAbsoluteRad);
            else
                p56.curAzimuthRad = p56.curAzimuthRad == 0 and 0 or (math.sign(p56.curAzimuthRad) * (math.abs(p56.curAzimuthRad) % 6.283185307179586) or 0);
            end;
            p56.curElevationRad = math.clamp(p56.curElevationRad + v67.y, p56.minElevationRad, p56.maxElevationRad);
            local v74 = v66 + p56.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p56.curElevationRad, p56.curAzimuthRad, 0) * Vector3.new(0, 0, 1));
            l__CFrame__9 = CFrame.new(v74, v66);
            if not u3 then
                p56.rotateInput = u4;
            end;
        end;
        p56.lastCameraTransform = l__CFrame__9;
        p56.lastCameraFocus = l__Focus__10;
        if (v61 or v62) and v60:IsA("BasePart") then
            p56.lastSubjectCFrame = v60.CFrame;
        else
            p56.lastSubjectCFrame = nil;
        end;
    end;
    p56.lastUpdate = v57;
    return l__CFrame__9, l__Focus__10;
end;
return u5;
