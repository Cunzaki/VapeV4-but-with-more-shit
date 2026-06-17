-- Decompiled from: ReplicatedStorage.Assets.Models.PlayerModule.CameraModule.BaseCamera
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("UserInputService");
local l__VRService__2 = game:GetService("VRService");
local l__UserGameSettings__3 = UserSettings():GetService("UserGameSettings");
local l__CommonUtils__4 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__ConnectionUtil__5 = require(l__CommonUtils__4:WaitForChild("ConnectionUtil"));
require(l__CommonUtils__4:WaitForChild("FlagUtil"));
local l__CameraUtils__6 = require(script.Parent:WaitForChild("CameraUtils"));
local l__ZoomController__7 = require(script.Parent:WaitForChild("ZoomController"));
local l__CameraToggleStateController__8 = require(script.Parent:WaitForChild("CameraToggleStateController"));
local l__CameraInput__9 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUI__10 = require(script.Parent:WaitForChild("CameraUI"));
local l__LocalPlayer__11 = l__Players__1.LocalPlayer;
local v1, v2 = pcall(function() --[[ Line: 24 ]]
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom");
end);
local u3 = v1 and v2;
Vector2.new(0, 0);
local u4 = {};
u4.__index = u4;
function u4.new() --[[ Line: 78 ]]
    -- upvalues: u4 (copy), l__ConnectionUtil__5 (copy), l__LocalPlayer__11 (copy), l__UserGameSettings__3 (copy)
    local v5 = setmetatable({}, u4);
    v5._connections = l__ConnectionUtil__5.new();
    v5.gamepadZoomLevels = { 0, 10, 20 };
    v5.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    v5.cameraType = nil;
    v5.cameraMovementMode = nil;
    v5.lastCameraTransform = nil;
    v5.lastUserPanCamera = tick();
    v5.humanoidRootPart = nil;
    v5.humanoidCache = {};
    v5.lastSubject = nil;
    v5.lastSubjectPosition = Vector3.new(0, 5, 0);
    v5.lastSubjectCFrame = CFrame.new(v5.lastSubjectPosition);
    v5.currentSubjectDistance = math.clamp(12.5, l__LocalPlayer__11.CameraMinZoomDistance, l__LocalPlayer__11.CameraMaxZoomDistance);
    v5.inFirstPerson = false;
    v5.inMouseLockedMode = false;
    v5.resetCameraAngle = true;
    v5.enabled = false;
    v5.cameraChangedConn = nil;
    v5.shouldUseVRRotation = false;
    v5.VRRotationIntensityAvailable = false;
    v5.lastVRRotationIntensityCheckTime = 0;
    v5.lastVRRotationTime = 0;
    v5.vrRotateKeyCooldown = {};
    v5.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    v5.humanoidJumpOrigin = nil;
    v5.trackingHumanoid = nil;
    v5.cameraFrozen = false;
    v5.subjectStateChangedConn = nil;
    v5.gamepadZoomPressConnection = nil;
    v5.mouseLockOffset = Vector3.new(0, 0, 0);
    l__UserGameSettings__3:SetCameraYInvertVisible();
    l__UserGameSettings__3:SetGamepadCameraSensitivityVisible();
    return v5;
end;
function u4.GetModuleName(_) --[[ Line: 138 ]]
    return "BaseCamera";
end;
function u4._setUpConfigurations(u6) --[[ Line: 142 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    u6._connections:trackConnection("CHARACTER_ADDED", l__LocalPlayer__11.CharacterAdded:Connect(function(p7) --[[ Line: 143 ]]
        -- upvalues: u6 (copy)
        u6:OnCharacterAdded(p7);
    end));
    u6.humanoidRootPart = nil;
    u6._connections:trackConnection("CAMERA_MODE_CHANGED", l__LocalPlayer__11:GetPropertyChangedSignal("CameraMode"):Connect(function() --[[ Line: 148 ]]
        -- upvalues: u6 (copy)
        u6:OnPlayerCameraPropertyChange();
    end));
    u6._connections:trackConnection("CAMERA_MIN_DISTANCE_CHANGED", l__LocalPlayer__11:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() --[[ Line: 151 ]]
        -- upvalues: u6 (copy)
        u6:OnPlayerCameraPropertyChange();
    end));
    u6._connections:trackConnection("CAMERA_MAX_DISTANCE_CHANGED", l__LocalPlayer__11:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() --[[ Line: 154 ]]
        -- upvalues: u6 (copy)
        u6:OnPlayerCameraPropertyChange();
    end));
    u6:OnPlayerCameraPropertyChange();
end;
function u4.OnCharacterAdded(p8, _) --[[ Line: 160 ]]
    p8.resetCameraAngle = p8.resetCameraAngle or p8:GetEnabled();
    p8.humanoidRootPart = nil;
end;
function u4.GetHumanoidRootPart(p9) --[[ Line: 167 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local v10 = (not p9.humanoidRootPart and l__LocalPlayer__11.Character and true or false) and l__LocalPlayer__11.Character:FindFirstChildOfClass("Humanoid");
    if v10 then
        p9.humanoidRootPart = v10.RootPart;
    end;
    return p9.humanoidRootPart;
end;
function u4.GetBodyPartToFollow(_, p11, _) --[[ Line: 179 ]]
    if p11:GetState() == Enum.HumanoidStateType.Dead then
        local l__Parent__12 = p11.Parent;
        if l__Parent__12 and l__Parent__12:IsA("Model") then
            return l__Parent__12:FindFirstChild("Head") or p11.RootPart;
        end;
    end;
    return p11.RootPart;
end;
function u4.GetSubjectCFrame(p12) --[[ Line: 191 ]]
    local l__lastSubjectCFrame__13 = p12.lastSubjectCFrame;
    local l__CurrentCamera__14 = workspace.CurrentCamera;
    if l__CurrentCamera__14 then
        l__CurrentCamera__14 = l__CurrentCamera__14.CameraSubject;
    end;
    if not l__CurrentCamera__14 then
        return l__lastSubjectCFrame__13;
    end;
    if l__CurrentCamera__14:IsA("Humanoid") then
        local v13 = l__CurrentCamera__14:GetState() == Enum.HumanoidStateType.Dead;
        local l__CameraOffset__15 = l__CurrentCamera__14.CameraOffset;
        if p12:GetIsMouseLocked() then
            l__CameraOffset__15 = Vector3.new();
        end;
        local l__RootPart__16 = l__CurrentCamera__14.RootPart;
        if v13 and (l__CurrentCamera__14.Parent and l__CurrentCamera__14.Parent:IsA("Model")) then
            l__RootPart__16 = l__CurrentCamera__14.Parent:FindFirstChild("Head") or l__RootPart__16;
        end;
        if l__RootPart__16 and l__RootPart__16:IsA("BasePart") then
            local v14;
            if l__CurrentCamera__14.RigType == Enum.HumanoidRigType.R15 then
                if l__CurrentCamera__14.AutomaticScalingEnabled then
                    v14 = Vector3.new(0, 1.5, 0);
                    local l__RootPart__17 = l__CurrentCamera__14.RootPart;
                    if l__RootPart__16 == l__RootPart__17 then
                        v14 = v14 + Vector3.new(0, (l__RootPart__17.Size.Y - 2) / 2, 0);
                    end;
                else
                    v14 = Vector3.new(0, 2, 0);
                end;
            else
                v14 = Vector3.new(0, 1.5, 0);
            end;
            l__lastSubjectCFrame__13 = l__RootPart__16.CFrame * CFrame.new((v13 and Vector3.new(0, 0, 0) or v14) + l__CameraOffset__15);
        end;
    elseif l__CurrentCamera__14:IsA("BasePart") then
        l__lastSubjectCFrame__13 = l__CurrentCamera__14.CFrame;
    elseif l__CurrentCamera__14:IsA("Model") then
        if l__CurrentCamera__14.PrimaryPart then
            l__lastSubjectCFrame__13 = l__CurrentCamera__14:GetPrimaryPartCFrame();
        else
            l__lastSubjectCFrame__13 = CFrame.new();
        end;
    end;
    if l__lastSubjectCFrame__13 then
        p12.lastSubjectCFrame = l__lastSubjectCFrame__13;
    end;
    return l__lastSubjectCFrame__13;
end;
function u4.GetSubjectVelocity(_) --[[ Line: 265 ]]
    local l__CurrentCamera__18 = workspace.CurrentCamera;
    if l__CurrentCamera__18 then
        l__CurrentCamera__18 = l__CurrentCamera__18.CameraSubject;
    end;
    if not l__CurrentCamera__18 then
        return Vector3.new(0, 0, 0);
    end;
    if l__CurrentCamera__18:IsA("BasePart") then
        return l__CurrentCamera__18.Velocity;
    end;
    if l__CurrentCamera__18:IsA("Humanoid") then
        local l__RootPart__19 = l__CurrentCamera__18.RootPart;
        if l__RootPart__19 then
            return l__RootPart__19.Velocity;
        end;
    else
        local v15 = l__CurrentCamera__18:IsA("Model") and l__CurrentCamera__18.PrimaryPart;
        if v15 then
            return v15.Velocity;
        end;
    end;
    return Vector3.new(0, 0, 0);
end;
function u4.GetSubjectRotVelocity(_) --[[ Line: 294 ]]
    local l__CurrentCamera__20 = workspace.CurrentCamera;
    if l__CurrentCamera__20 then
        l__CurrentCamera__20 = l__CurrentCamera__20.CameraSubject;
    end;
    if not l__CurrentCamera__20 then
        return Vector3.new(0, 0, 0);
    end;
    if l__CurrentCamera__20:IsA("BasePart") then
        return l__CurrentCamera__20.RotVelocity;
    end;
    if l__CurrentCamera__20:IsA("Humanoid") then
        local l__RootPart__21 = l__CurrentCamera__20.RootPart;
        if l__RootPart__21 then
            return l__RootPart__21.RotVelocity;
        end;
    else
        local v16 = l__CurrentCamera__20:IsA("Model") and l__CurrentCamera__20.PrimaryPart;
        if v16 then
            return v16.RotVelocity;
        end;
    end;
    return Vector3.new(0, 0, 0);
end;
function u4.StepZoom(p17) --[[ Line: 323 ]]
    -- upvalues: l__CameraInput__9 (copy), l__ZoomController__7 (copy)
    local l__currentSubjectDistance__22 = p17.currentSubjectDistance;
    local v18 = l__CameraInput__9.getZoomDelta();
    if math.abs(v18) > 0 then
        local v19;
        if v18 > 0 then
            v19 = math.max(l__currentSubjectDistance__22 + v18 * (l__currentSubjectDistance__22 * 0.5 + 1), p17.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v19 = math.max((l__currentSubjectDistance__22 + v18) / (1 - v18 * 0.5), 0.5);
        end;
        p17:SetCameraToSubjectDistance(v19 < p17.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v19);
    end;
    return l__ZoomController__7.GetZoomRadius();
end;
function u4.GetSubjectPosition(p20) --[[ Line: 348 ]]
    local l__lastSubjectPosition__23 = p20.lastSubjectPosition;
    local l__CurrentCamera__24 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__24 then
        l__CurrentCamera__24 = l__CurrentCamera__24.CameraSubject;
    end;
    if not l__CurrentCamera__24 then
        return nil;
    end;
    if l__CurrentCamera__24:IsA("Humanoid") then
        local v21 = l__CurrentCamera__24:GetState() == Enum.HumanoidStateType.Dead;
        local l__CameraOffset__25 = l__CurrentCamera__24.CameraOffset;
        if p20:GetIsMouseLocked() then
            l__CameraOffset__25 = Vector3.new();
        end;
        local l__RootPart__26 = l__CurrentCamera__24.RootPart;
        if v21 and (l__CurrentCamera__24.Parent and l__CurrentCamera__24.Parent:IsA("Model")) then
            l__RootPart__26 = l__CurrentCamera__24.Parent:FindFirstChild("Head") or l__RootPart__26;
        end;
        if l__RootPart__26 and l__RootPart__26:IsA("BasePart") then
            local v22;
            if l__CurrentCamera__24.RigType == Enum.HumanoidRigType.R15 then
                if l__CurrentCamera__24.AutomaticScalingEnabled then
                    v22 = Vector3.new(0, 1.5, 0);
                    if l__RootPart__26 == l__CurrentCamera__24.RootPart then
                        v22 = v22 + Vector3.new(0, l__CurrentCamera__24.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v22 = Vector3.new(0, 2, 0);
                end;
            else
                v22 = Vector3.new(0, 1.5, 0);
            end;
            l__lastSubjectPosition__23 = l__RootPart__26.CFrame.p + l__RootPart__26.CFrame:vectorToWorldSpace((v21 and Vector3.new(0, 0, 0) or v22) + l__CameraOffset__25);
        end;
    elseif l__CurrentCamera__24:IsA("VehicleSeat") then
        l__lastSubjectPosition__23 = l__CurrentCamera__24.CFrame.p + l__CurrentCamera__24.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0));
    elseif l__CurrentCamera__24:IsA("SkateboardPlatform") then
        l__lastSubjectPosition__23 = l__CurrentCamera__24.CFrame.p + Vector3.new(0, 5, 0);
    elseif l__CurrentCamera__24:IsA("BasePart") then
        l__lastSubjectPosition__23 = l__CurrentCamera__24.CFrame.p;
    elseif l__CurrentCamera__24:IsA("Model") then
        if l__CurrentCamera__24.PrimaryPart then
            l__lastSubjectPosition__23 = l__CurrentCamera__24:GetPrimaryPartCFrame().p;
        else
            l__lastSubjectPosition__23 = l__CurrentCamera__24:GetModelCFrame().p;
        end;
    end;
    p20.lastSubject = l__CurrentCamera__24;
    p20.lastSubjectPosition = l__lastSubjectPosition__23;
    return l__lastSubjectPosition__23;
end;
function u4.OnCurrentCameraChanged(u23) --[[ Line: 426 ]]
    if u23.cameraSubjectChangedConn then
        u23.cameraSubjectChangedConn:Disconnect();
        u23.cameraSubjectChangedConn = nil;
    end;
    local l__CurrentCamera__27 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__27 then
        u23.cameraSubjectChangedConn = l__CurrentCamera__27:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 435 ]]
            -- upvalues: u23 (copy)
            u23:OnNewCameraSubject();
        end);
        u23:OnNewCameraSubject();
    end;
end;
function u4.OnPlayerCameraPropertyChange(p24) --[[ Line: 442 ]]
    p24:SetCameraToSubjectDistance(p24.currentSubjectDistance);
end;
function u4.InputTranslationToCameraAngleChange(_, p25, p26) --[[ Line: 447 ]]
    return p25 * p26;
end;
function u4.GamepadZoomPress(p27) --[[ Line: 453 ]]
    -- upvalues: l__LocalPlayer__11 (copy), u3 (ref)
    local v28 = p27:GetCameraToSubjectDistance();
    local l__CameraMaxZoomDistance__28 = l__LocalPlayer__11.CameraMaxZoomDistance;
    for v29 = #p27.gamepadZoomLevels, 1, -1 do
        local v30 = p27.gamepadZoomLevels[v29];
        if l__CameraMaxZoomDistance__28 >= v30 then
            if v30 < l__LocalPlayer__11.CameraMinZoomDistance then
                v30 = l__LocalPlayer__11.CameraMinZoomDistance;
                if u3 and l__CameraMaxZoomDistance__28 == v30 then
                    break;
                end;
            end;
            if not u3 and l__CameraMaxZoomDistance__28 == v30 then
                break;
            end;
            if v30 + (l__CameraMaxZoomDistance__28 - v30) / 2 < v28 then
                p27:SetCameraToSubjectDistance(v30);
                return;
            end;
            l__CameraMaxZoomDistance__28 = v30;
        end;
    end;
    p27:SetCameraToSubjectDistance(p27.gamepadZoomLevels[#p27.gamepadZoomLevels]);
end;
function u4.Enable(p31, p32) --[[ Line: 498 ]]
    if p31.enabled ~= p32 then
        p31.enabled = p32;
        p31:OnEnabledChanged();
    end;
end;
function u4.OnEnabledChanged(u33) --[[ Line: 506 ]]
    -- upvalues: l__CameraInput__9 (copy), l__LocalPlayer__11 (copy)
    if u33.enabled then
        u33:_setUpConfigurations();
        l__CameraInput__9.setInputEnabled(true);
        u33.gamepadZoomPressConnection = l__CameraInput__9.gamepadZoomPress:Connect(function() --[[ Line: 512 ]]
            -- upvalues: u33 (copy)
            u33:GamepadZoomPress();
        end);
        if l__LocalPlayer__11.CameraMode == Enum.CameraMode.LockFirstPerson then
            u33.currentSubjectDistance = 0.5;
            if not u33.inFirstPerson then
                u33:EnterFirstPerson();
            end;
        end;
        if u33.cameraChangedConn then
            u33.cameraChangedConn:Disconnect();
            u33.cameraChangedConn = nil;
        end;
        u33.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 524 ]]
            -- upvalues: u33 (copy)
            u33:OnCurrentCameraChanged();
        end);
        u33:OnCurrentCameraChanged();
    else
        u33._connections:disconnectAll();
        l__CameraInput__9.setInputEnabled(false);
        if u33.gamepadZoomPressConnection then
            u33.gamepadZoomPressConnection:Disconnect();
            u33.gamepadZoomPressConnection = nil;
        end;
        u33:Cleanup();
    end;
end;
function u4.GetEnabled(p34) --[[ Line: 542 ]]
    return p34.enabled;
end;
function u4.Cleanup(p35) --[[ Line: 546 ]]
    -- upvalues: l__CameraUtils__6 (copy)
    if p35.subjectStateChangedConn then
        p35.subjectStateChangedConn:Disconnect();
        p35.subjectStateChangedConn = nil;
    end;
    if p35.cameraChangedConn then
        p35.cameraChangedConn:Disconnect();
        p35.cameraChangedConn = nil;
    end;
    p35.lastCameraTransform = nil;
    p35.lastSubjectCFrame = nil;
    l__CameraUtils__6.restoreMouseBehavior();
end;
function u4.UpdateMouseBehavior(p36) --[[ Line: 563 ]]
    -- upvalues: l__UserGameSettings__3 (copy), l__CameraUI__10 (copy), l__CameraInput__9 (copy), l__CameraToggleStateController__8 (copy), l__CameraUtils__6 (copy)
    if p36.isCameraToggle and l__UserGameSettings__3.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        l__CameraUI__10.setCameraModeToastEnabled(true);
        l__CameraInput__9.enableCameraToggleInput();
        l__CameraToggleStateController__8(p36.inFirstPerson);
    else
        l__CameraUI__10.setCameraModeToastEnabled(false);
        l__CameraInput__9.disableCameraToggleInput();
        if p36.inFirstPerson or p36.inMouseLockedMode then
            l__CameraUtils__6.setRotationTypeOverride(Enum.RotationType.CameraRelative);
            l__CameraUtils__6.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);
        else
            l__CameraUtils__6.restoreRotationType();
            if l__CameraInput__9.getRotationActivated() then
                l__CameraUtils__6.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);
            else
                l__CameraUtils__6.restoreMouseBehavior();
            end;
        end;
    end;
end;
function u4.UpdateForDistancePropertyChange(p37) --[[ Line: 591 ]]
    p37:SetCameraToSubjectDistance(p37.currentSubjectDistance);
end;
function u4.SetCameraToSubjectDistance(p38, p39) --[[ Line: 597 ]]
    -- upvalues: l__LocalPlayer__11 (copy), l__ZoomController__7 (copy)
    local l__currentSubjectDistance__29 = p38.currentSubjectDistance;
    if l__LocalPlayer__11.CameraMode == Enum.CameraMode.LockFirstPerson then
        p38.currentSubjectDistance = 0.5;
        if not p38.inFirstPerson then
            p38:EnterFirstPerson();
        end;
    else
        local v40 = math.clamp(p39, l__LocalPlayer__11.CameraMinZoomDistance, l__LocalPlayer__11.CameraMaxZoomDistance);
        if v40 < 1 then
            p38.currentSubjectDistance = 0.5;
            if not p38.inFirstPerson then
                p38:EnterFirstPerson();
            end;
        else
            p38.currentSubjectDistance = v40;
            if p38.inFirstPerson then
                p38:LeaveFirstPerson();
            end;
        end;
    end;
    l__ZoomController__7.SetZoomParameters(p38.currentSubjectDistance, (math.sign(p39 - l__currentSubjectDistance__29)));
    return p38.currentSubjectDistance;
end;
function u4.SetCameraType(p41, p42) --[[ Line: 631 ]]
    p41.cameraType = p42;
end;
function u4.GetCameraType(p43) --[[ Line: 636 ]]
    return p43.cameraType;
end;
function u4.SetCameraMovementMode(p44, p45) --[[ Line: 641 ]]
    p44.cameraMovementMode = p45;
end;
function u4.GetCameraMovementMode(p46) --[[ Line: 645 ]]
    return p46.cameraMovementMode;
end;
function u4.SetIsMouseLocked(p47, p48) --[[ Line: 649 ]]
    p47.inMouseLockedMode = p48;
end;
function u4.GetIsMouseLocked(p49) --[[ Line: 653 ]]
    return p49.inMouseLockedMode;
end;
function u4.SetMouseLockOffset(p50, p51) --[[ Line: 657 ]]
    p50.mouseLockOffset = p51;
end;
function u4.GetMouseLockOffset(p52) --[[ Line: 661 ]]
    return p52.mouseLockOffset;
end;
function u4.InFirstPerson(p53) --[[ Line: 665 ]]
    return p53.inFirstPerson;
end;
function u4.EnterFirstPerson(p54) --[[ Line: 669 ]]
    p54.inFirstPerson = true;
    p54:UpdateMouseBehavior();
end;
function u4.LeaveFirstPerson(p55) --[[ Line: 674 ]]
    p55.inFirstPerson = false;
    p55:UpdateMouseBehavior();
end;
function u4.GetCameraToSubjectDistance(p56) --[[ Line: 680 ]]
    return p56.currentSubjectDistance;
end;
function u4.GetMeasuredDistanceToFocus(_) --[[ Line: 687 ]]
    local l__CurrentCamera__30 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__30 then
        return (l__CurrentCamera__30.CoordinateFrame.p - l__CurrentCamera__30.Focus.p).magnitude;
    else
        return nil;
    end;
end;
function u4.GetCameraLookVector(_) --[[ Line: 695 ]]
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;
function u4.CalculateNewLookCFrameFromArg(p57, p58, p59) --[[ Line: 699 ]]
    local v60 = p58 or p57:GetCameraLookVector();
    local v61 = math.asin(v60.Y) - p59.Y;
    local v62 = v61 > 1.5692255304681018 and 1.5692255304681018 or (v61 < -1.5692255304681018 and -1.5692255304681018 or v61);
    local v63 = math.atan2(-v60.X, -v60.Z) - p59.X;
    return CFrame.Angles(0, v63, 0) * CFrame.Angles(v62, 0, 0);
end;
function u4.CalculateNewLookVectorFromArg(p64, p65, p66) --[[ Line: 716 ]]
    return p64:CalculateNewLookCFrameFromArg(p65, p66).LookVector;
end;
function u4.CalculateNewLookVectorVRFromArg(p67, p68) --[[ Line: 721 ]]
    local l__unit__31 = ((p67:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local v69 = Vector2.new(p68.X, 0);
    local v70 = CFrame.new(Vector3.new(0, 0, 0), l__unit__31);
    return ((CFrame.Angles(0, -v69.X, 0) * v70 * CFrame.Angles(-v69.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;
function u4.GetHumanoid(p71) --[[ Line: 731 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local v72 = l__LocalPlayer__11;
    if v72 then
        v72 = l__LocalPlayer__11.Character;
    end;
    if not v72 then
        return nil;
    end;
    local v73 = p71.humanoidCache[l__LocalPlayer__11];
    if v73 and v73.Parent == v72 then
        return v73;
    end;
    p71.humanoidCache[l__LocalPlayer__11] = nil;
    local v74 = v72:FindFirstChildOfClass("Humanoid");
    if v74 then
        p71.humanoidCache[l__LocalPlayer__11] = v74;
    end;
    return v74;
end;
function u4.GetHumanoidPartToFollow(_, p75, p76) --[[ Line: 749 ]]
    if p76 == Enum.HumanoidStateType.Dead then
        local l__Parent__32 = p75.Parent;
        if l__Parent__32 then
            return l__Parent__32:FindFirstChild("Head") or p75.Torso;
        else
            return p75.Torso;
        end;
    else
        return p75.Torso;
    end;
end;
function u4.OnNewCameraSubject(p77) --[[ Line: 763 ]]
    if p77.subjectStateChangedConn then
        p77.subjectStateChangedConn:Disconnect();
        p77.subjectStateChangedConn = nil;
    end;
end;
function u4.IsInFirstPerson(p78) --[[ Line: 770 ]]
    return p78.inFirstPerson;
end;
function u4.Update(_, _) --[[ Line: 774 ]]
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;
function u4.GetCameraHeight(p79) --[[ Line: 778 ]]
    -- upvalues: l__VRService__2 (copy)
    return (not l__VRService__2.VREnabled or p79.inFirstPerson) and 0 or 0.25881904510252074 * p79.currentSubjectDistance;
end;
return u4;
