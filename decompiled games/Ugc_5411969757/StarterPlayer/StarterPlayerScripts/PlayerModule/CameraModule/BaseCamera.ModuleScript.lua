-- Decompiled from: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.BaseCamera
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Value__1 = Enum.ContextActionPriority.Default.Value;
local u1 = Vector2.new(0.2617993877991494, 0);
local u2 = Vector2.new(0.7853981633974483, 0);
local u3 = Vector2.new(0, 0);
local u4 = Vector2.new(0.029688050576423545, 0.010602875205865551);
local u5 = Vector2.new(0.006283185307179587, 0.00471238898038469);
local l__abs__2 = math.abs;
local _ = math.sign;
local v6, v7 = pcall(function() --[[ Line: 58 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local u8 = v6 and v7;
local v9, v10 = pcall(function() --[[ Line: 65 ]]
    return UserSettings():IsUserFeatureEnabled("UserFixZoomInZoomOutDiscrepancy");
end);
local u11 = v9 and v10;
local v12, v13 = pcall(function() --[[ Line: 72 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor2");
end);
local u14 = v12 and v13;
local l__CameraUtils__3 = require(script.Parent:WaitForChild("CameraUtils"));
local l__ZoomController__4 = require(script.Parent:WaitForChild("ZoomController"));
local l__CameraToggleStateController__5 = require(script.Parent:WaitForChild("CameraToggleStateController"));
local l__CameraInput__6 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUI__7 = require(script.Parent:WaitForChild("CameraUI"));
local l__Players__8 = game:GetService("Players");
local l__UserInputService__9 = game:GetService("UserInputService");
local l__StarterGui__10 = game:GetService("StarterGui");
local l__GuiService__11 = game:GetService("GuiService");
local l__ContextActionService__12 = game:GetService("ContextActionService");
local l__VRService__13 = game:GetService("VRService");
local l__UserGameSettings__14 = UserSettings():GetService("UserGameSettings");
local l__LocalPlayer__15 = l__Players__8.LocalPlayer;
local u15 = {};
u15.__index = u15;
function u15.new() --[[ Line: 99 ]]
    -- upvalues: u15 (copy), u3 (copy), l__LocalPlayer__15 (copy), l__UserGameSettings__14 (copy)
    local u16 = setmetatable({}, u15);
    u16.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    u16.cameraType = nil;
    u16.cameraMovementMode = nil;
    u16.lastCameraTransform = nil;
    u16.rotateInput = u3;
    u16.userPanningCamera = false;
    u16.lastUserPanCamera = tick();
    u16.humanoidRootPart = nil;
    u16.humanoidCache = {};
    u16.lastSubject = nil;
    u16.lastSubjectPosition = Vector3.new(0, 5, 0);
    u16.defaultSubjectDistance = math.clamp(12.5, l__LocalPlayer__15.CameraMinZoomDistance, l__LocalPlayer__15.CameraMaxZoomDistance);
    u16.currentSubjectDistance = math.clamp(12.5, l__LocalPlayer__15.CameraMinZoomDistance, l__LocalPlayer__15.CameraMaxZoomDistance);
    u16.inFirstPerson = false;
    u16.inMouseLockedMode = false;
    u16.portraitMode = false;
    u16.isSmallTouchScreen = false;
    u16.resetCameraAngle = true;
    u16.enabled = false;
    u16.inputBeganConn = nil;
    u16.inputChangedConn = nil;
    u16.inputEndedConn = nil;
    u16.startPos = nil;
    u16.lastPos = nil;
    u16.panBeginLook = nil;
    u16.panEnabled = true;
    u16.keyPanEnabled = true;
    u16.distanceChangeEnabled = true;
    u16.PlayerGui = nil;
    u16.cameraChangedConn = nil;
    u16.viewportSizeChangedConn = nil;
    u16.boundContextActions = {};
    u16.shouldUseVRRotation = false;
    u16.VRRotationIntensityAvailable = false;
    u16.lastVRRotationIntensityCheckTime = 0;
    u16.lastVRRotationTime = 0;
    u16.vrRotateKeyCooldown = {};
    u16.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    u16.humanoidJumpOrigin = nil;
    u16.trackingHumanoid = nil;
    u16.cameraFrozen = false;
    u16.subjectStateChangedConn = nil;
    u16.gamepadZoomPressConnection = nil;
    u16.activeGamepad = nil;
    u16.gamepadPanningCamera = false;
    u16.lastThumbstickRotate = nil;
    u16.numOfSeconds = 0.7;
    u16.currentSpeed = 0;
    u16.maxSpeed = 6;
    u16.vrMaxSpeed = 4;
    u16.lastThumbstickPos = Vector2.new(0, 0);
    u16.ySensitivity = 0.65;
    u16.lastVelocity = nil;
    u16.gamepadConnectedConn = nil;
    u16.gamepadDisconnectedConn = nil;
    u16.currentZoomSpeed = 1;
    u16.L3ButtonDown = false;
    u16.dpadLeftDown = false;
    u16.dpadRightDown = false;
    u16.isDynamicThumbstickEnabled = false;
    u16.fingerTouches = {};
    u16.dynamicTouchInput = nil;
    u16.numUnsunkTouches = 0;
    u16.inputStartPositions = {};
    u16.inputStartTimes = {};
    u16.startingDiff = nil;
    u16.pinchBeginZoom = nil;
    u16.userPanningTheCamera = false;
    u16.touchActivateConn = nil;
    u16.mouseLockOffset = Vector3.new(0, 0, 0);
    if l__LocalPlayer__15.Character then
        u16:OnCharacterAdded(l__LocalPlayer__15.Character);
    end;
    l__LocalPlayer__15.CharacterAdded:Connect(function(p17) --[[ Line: 215 ]]
        -- upvalues: u16 (copy)
        u16:OnCharacterAdded(p17);
    end);
    if u16.cameraChangedConn then
        u16.cameraChangedConn:Disconnect();
    end;
    u16.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 220 ]]
        -- upvalues: u16 (copy)
        u16:OnCurrentCameraChanged();
    end);
    u16:OnCurrentCameraChanged();
    if u16.playerCameraModeChangeConn then
        u16.playerCameraModeChangeConn:Disconnect();
    end;
    u16.playerCameraModeChangeConn = l__LocalPlayer__15:GetPropertyChangedSignal("CameraMode"):Connect(function() --[[ Line: 226 ]]
        -- upvalues: u16 (copy)
        u16:OnPlayerCameraPropertyChange();
    end);
    if u16.minDistanceChangeConn then
        u16.minDistanceChangeConn:Disconnect();
    end;
    u16.minDistanceChangeConn = l__LocalPlayer__15:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() --[[ Line: 231 ]]
        -- upvalues: u16 (copy)
        u16:OnPlayerCameraPropertyChange();
    end);
    if u16.maxDistanceChangeConn then
        u16.maxDistanceChangeConn:Disconnect();
    end;
    u16.maxDistanceChangeConn = l__LocalPlayer__15:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() --[[ Line: 236 ]]
        -- upvalues: u16 (copy)
        u16:OnPlayerCameraPropertyChange();
    end);
    if u16.playerDevTouchMoveModeChangeConn then
        u16.playerDevTouchMoveModeChangeConn:Disconnect();
    end;
    u16.playerDevTouchMoveModeChangeConn = l__LocalPlayer__15:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() --[[ Line: 241 ]]
        -- upvalues: u16 (copy)
        u16:OnDevTouchMovementModeChanged();
    end);
    u16:OnDevTouchMovementModeChanged();
    if u16.gameSettingsTouchMoveMoveChangeConn then
        u16.gameSettingsTouchMoveMoveChangeConn:Disconnect();
    end;
    u16.gameSettingsTouchMoveMoveChangeConn = l__UserGameSettings__14:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() --[[ Line: 247 ]]
        -- upvalues: u16 (copy)
        u16:OnGameSettingsTouchMovementModeChanged();
    end);
    u16:OnGameSettingsTouchMovementModeChanged();
    l__UserGameSettings__14:SetCameraYInvertVisible();
    l__UserGameSettings__14:SetGamepadCameraSensitivityVisible();
    u16.hasGameLoaded = game:IsLoaded();
    if not u16.hasGameLoaded then
        u16.gameLoadedConn = game.Loaded:Connect(function() --[[ Line: 257 ]]
            -- upvalues: u16 (copy)
            u16.hasGameLoaded = true;
            u16.gameLoadedConn:Disconnect();
            u16.gameLoadedConn = nil;
        end);
    end;
    u16:OnPlayerCameraPropertyChange();
    return u16;
end;
function u15.GetModuleName(_) --[[ Line: 269 ]]
    return "BaseCamera";
end;
function u15.OnCharacterAdded(u18, p19) --[[ Line: 273 ]]
    -- upvalues: l__UserInputService__9 (copy), l__LocalPlayer__15 (copy)
    u18.resetCameraAngle = u18.resetCameraAngle or u18:GetEnabled();
    u18.humanoidRootPart = nil;
    if l__UserInputService__9.TouchEnabled then
        u18.PlayerGui = l__LocalPlayer__15:WaitForChild("PlayerGui");
        for _, v20 in ipairs(p19:GetChildren()) do
            if v20:IsA("Tool") then
                u18.isAToolEquipped = true;
            end;
        end;
        p19.ChildAdded:Connect(function(p21) --[[ Line: 283 ]]
            -- upvalues: u18 (copy)
            if p21:IsA("Tool") then
                u18.isAToolEquipped = true;
            end;
        end);
        p19.ChildRemoved:Connect(function(p22) --[[ Line: 288 ]]
            -- upvalues: u18 (copy)
            if p22:IsA("Tool") then
                u18.isAToolEquipped = false;
            end;
        end);
    end;
end;
function u15.GetHumanoidRootPart(p23) --[[ Line: 296 ]]
    -- upvalues: l__LocalPlayer__15 (copy)
    local v24 = (not p23.humanoidRootPart and l__LocalPlayer__15.Character and true or false) and l__LocalPlayer__15.Character:FindFirstChildOfClass("Humanoid");
    if v24 then
        p23.humanoidRootPart = v24.RootPart;
    end;
    return p23.humanoidRootPart;
end;
function u15.GetBodyPartToFollow(_, p25, _) --[[ Line: 308 ]]
    if p25:GetState() == Enum.HumanoidStateType.Dead then
        local l__Parent__16 = p25.Parent;
        if l__Parent__16 and l__Parent__16:IsA("Model") then
            return l__Parent__16:FindFirstChild("Head") or p25.RootPart;
        end;
    end;
    return p25.RootPart;
end;
function u15.GetSubjectPosition(p26) --[[ Line: 320 ]]
    -- upvalues: l__VRService__13 (copy)
    local l__lastSubjectPosition__17 = p26.lastSubjectPosition;
    local l__CurrentCamera__18 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__18 then
        l__CurrentCamera__18 = l__CurrentCamera__18.CameraSubject;
    end;
    if l__CurrentCamera__18 then
        if l__CurrentCamera__18:IsA("Humanoid") then
            local v27 = l__CurrentCamera__18:GetState() == Enum.HumanoidStateType.Dead;
            if l__VRService__13.VREnabled and (v27 and l__CurrentCamera__18 == p26.lastSubject) then
                l__lastSubjectPosition__17 = p26.lastSubjectPosition;
            else
                local l__RootPart__19 = l__CurrentCamera__18.RootPart;
                if v27 and (l__CurrentCamera__18.Parent and l__CurrentCamera__18.Parent:IsA("Model")) then
                    l__RootPart__19 = l__CurrentCamera__18.Parent:FindFirstChild("Head") or l__RootPart__19;
                end;
                if l__RootPart__19 and l__RootPart__19:IsA("BasePart") then
                    local v28;
                    if l__CurrentCamera__18.RigType == Enum.HumanoidRigType.R15 then
                        if l__CurrentCamera__18.AutomaticScalingEnabled then
                            v28 = Vector3.new(0, 1.5, 0);
                            if l__RootPart__19 == l__CurrentCamera__18.RootPart then
                                v28 = v28 + Vector3.new(0, l__CurrentCamera__18.RootPart.Size.Y / 2 - 1, 0);
                            end;
                        else
                            v28 = Vector3.new(0, 2, 0);
                        end;
                    else
                        v28 = Vector3.new(0, 1.5, 0);
                    end;
                    l__lastSubjectPosition__17 = l__RootPart__19.CFrame.p + l__RootPart__19.CFrame:vectorToWorldSpace((v27 and Vector3.new(0, 0, 0) or v28) + l__CurrentCamera__18.CameraOffset);
                end;
            end;
        elseif l__CurrentCamera__18:IsA("VehicleSeat") then
            l__lastSubjectPosition__17 = l__CurrentCamera__18.CFrame.p + l__CurrentCamera__18.CFrame:vectorToWorldSpace(l__VRService__13.VREnabled and Vector3.new(0, 4, 0) or Vector3.new(0, 5, 0));
        elseif l__CurrentCamera__18:IsA("SkateboardPlatform") then
            l__lastSubjectPosition__17 = l__CurrentCamera__18.CFrame.p + Vector3.new(0, 5, 0);
        elseif l__CurrentCamera__18:IsA("BasePart") then
            l__lastSubjectPosition__17 = l__CurrentCamera__18.CFrame.p;
        elseif l__CurrentCamera__18:IsA("Model") then
            if l__CurrentCamera__18.PrimaryPart then
                l__lastSubjectPosition__17 = l__CurrentCamera__18:GetPrimaryPartCFrame().p;
            else
                l__lastSubjectPosition__17 = l__CurrentCamera__18:GetModelCFrame().p;
            end;
        end;
        p26.lastSubject = l__CurrentCamera__18;
        p26.lastSubjectPosition = l__lastSubjectPosition__17;
        return l__lastSubjectPosition__17;
    end;
end;
function u15.UpdateDefaultSubjectDistance(p29) --[[ Line: 397 ]]
    -- upvalues: l__LocalPlayer__15 (copy)
    if p29.portraitMode then
        p29.defaultSubjectDistance = math.clamp(25, l__LocalPlayer__15.CameraMinZoomDistance, l__LocalPlayer__15.CameraMaxZoomDistance);
    else
        p29.defaultSubjectDistance = math.clamp(12.5, l__LocalPlayer__15.CameraMinZoomDistance, l__LocalPlayer__15.CameraMaxZoomDistance);
    end;
end;
function u15.OnViewportSizeChanged(p30) --[[ Line: 405 ]]
    -- upvalues: l__UserInputService__9 (copy)
    local l__ViewportSize__20 = game.Workspace.CurrentCamera.ViewportSize;
    p30.portraitMode = l__ViewportSize__20.X < l__ViewportSize__20.Y;
    local l__TouchEnabled__21 = l__UserInputService__9.TouchEnabled;
    if l__TouchEnabled__21 then
        l__TouchEnabled__21 = l__ViewportSize__20.Y < 500 and true or l__ViewportSize__20.X < 700;
    end;
    p30.isSmallTouchScreen = l__TouchEnabled__21;
    p30:UpdateDefaultSubjectDistance();
end;
function u15.OnCurrentCameraChanged(u31) --[[ Line: 415 ]]
    -- upvalues: l__UserInputService__9 (copy)
    if l__UserInputService__9.TouchEnabled then
        if u31.viewportSizeChangedConn then
            u31.viewportSizeChangedConn:Disconnect();
            u31.viewportSizeChangedConn = nil;
        end;
        local l__CurrentCamera__22 = game.Workspace.CurrentCamera;
        if l__CurrentCamera__22 then
            u31:OnViewportSizeChanged();
            u31.viewportSizeChangedConn = l__CurrentCamera__22:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 426 ]]
                -- upvalues: u31 (copy)
                u31:OnViewportSizeChanged();
            end);
        end;
    end;
    if u31.cameraSubjectChangedConn then
        u31.cameraSubjectChangedConn:Disconnect();
        u31.cameraSubjectChangedConn = nil;
    end;
    local l__CurrentCamera__23 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__23 then
        u31.cameraSubjectChangedConn = l__CurrentCamera__23:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 440 ]]
            -- upvalues: u31 (copy)
            u31:OnNewCameraSubject();
        end);
        u31:OnNewCameraSubject();
    end;
end;
function u15.OnDynamicThumbstickEnabled(p32) --[[ Line: 447 ]]
    -- upvalues: l__UserInputService__9 (copy)
    if l__UserInputService__9.TouchEnabled then
        p32.isDynamicThumbstickEnabled = true;
    end;
end;
function u15.OnDynamicThumbstickDisabled(p33) --[[ Line: 453 ]]
    p33.isDynamicThumbstickEnabled = false;
end;
function u15.OnGameSettingsTouchMovementModeChanged(p34) --[[ Line: 457 ]]
    -- upvalues: l__LocalPlayer__15 (copy), l__UserGameSettings__14 (copy)
    if l__LocalPlayer__15.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        if l__UserGameSettings__14.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or l__UserGameSettings__14.TouchMovementMode == Enum.TouchMovementMode.Default then
            p34:OnDynamicThumbstickEnabled();
            return;
        end;
        p34:OnDynamicThumbstickDisabled();
    end;
end;
function u15.OnDevTouchMovementModeChanged(p35) --[[ Line: 468 ]]
    -- upvalues: l__LocalPlayer__15 (copy)
    if l__LocalPlayer__15.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
        p35:OnDynamicThumbstickEnabled();
    else
        p35:OnGameSettingsTouchMovementModeChanged();
    end;
end;
function u15.OnPlayerCameraPropertyChange(p36) --[[ Line: 476 ]]
    p36:SetCameraToSubjectDistance(p36.currentSubjectDistance);
end;
function u15.GetCameraHeight(p37) --[[ Line: 481 ]]
    -- upvalues: l__VRService__13 (copy)
    return (not l__VRService__13.VREnabled or p37.inFirstPerson) and 0 or 0.25881904510252074 * p37.currentSubjectDistance;
end;
function u15.InputTranslationToCameraAngleChange(_, p38, p39) --[[ Line: 488 ]]
    return p38 * p39;
end;
function u15.GamepadZoomPress(p40) --[[ Line: 492 ]]
    local v41 = p40:GetCameraToSubjectDistance();
    if v41 > 15 then
        p40:SetCameraToSubjectDistance(10);
    elseif v41 > 5 then
        p40:SetCameraToSubjectDistance(0);
    else
        p40:SetCameraToSubjectDistance(20);
    end;
end;
function u15.Enable(u42, p43) --[[ Line: 504 ]]
    -- upvalues: u14 (ref), l__CameraInput__6 (copy), l__LocalPlayer__15 (copy)
    if u42.enabled ~= p43 then
        u42.enabled = p43;
        if u42.enabled then
            if u14 then
                l__CameraInput__6.setInputEnabled(true);
                u42.gamepadZoomPressConnection = l__CameraInput__6.gamepadZoomPress:Connect(function() --[[ Line: 511 ]]
                    -- upvalues: u42 (copy)
                    u42:GamepadZoomPress();
                end);
            else
                u42:ConnectInputEvents();
                u42:BindContextActions();
            end;
            if l__LocalPlayer__15.CameraMode == Enum.CameraMode.LockFirstPerson then
                u42.currentSubjectDistance = 0.5;
                if not u42.inFirstPerson then
                    u42:EnterFirstPerson();
                end;
            end;
        else
            if u14 then
                l__CameraInput__6.setInputEnabled(false);
                if u42.gamepadZoomPressConnection then
                    u42.gamepadZoomPressConnection:Disconnect();
                    u42.gamepadZoomPressConnection = nil;
                end;
            else
                u42:DisconnectInputEvents();
                u42:UnbindContextActions();
            end;
            u42:Cleanup();
        end;
    end;
end;
function u15.GetEnabled(p44) --[[ Line: 543 ]]
    return p44.enabled;
end;
function u15.OnInputBegan(p45, p46, p47) --[[ Line: 548 ]]
    if p46.UserInputType == Enum.UserInputType.Touch then
        p45:OnTouchBegan(p46, p47);
    elseif p46.UserInputType == Enum.UserInputType.MouseButton2 then
        p45:OnMouse2Down(p46, p47);
    else
        if p46.UserInputType == Enum.UserInputType.MouseButton3 then
            p45:OnMouse3Down(p46, p47);
        end;
    end;
end;
function u15.OnInputChanged(p48, p49, p50) --[[ Line: 559 ]]
    if p49.UserInputType == Enum.UserInputType.Touch then
        p48:OnTouchChanged(p49, p50);
    else
        if p49.UserInputType == Enum.UserInputType.MouseMovement then
            p48:OnMouseMoved(p49, p50);
        end;
    end;
end;
function u15.OnInputEnded(p51, p52, p53) --[[ Line: 568 ]]
    if p52.UserInputType == Enum.UserInputType.Touch then
        p51:OnTouchEnded(p52, p53);
    elseif p52.UserInputType == Enum.UserInputType.MouseButton2 then
        p51:OnMouse2Up(p52, p53);
    else
        if p52.UserInputType == Enum.UserInputType.MouseButton3 then
            p51:OnMouse3Up(p52, p53);
        end;
    end;
end;
function u15.OnPointerAction(p54, p55, p56, p57, p58) --[[ Line: 579 ]]
    -- upvalues: u14 (ref), l__UserGameSettings__14 (copy), u5 (copy), l__abs__2 (copy), u11 (ref)
    assert(not u14);
    if p58 then
    else
        if p56.Magnitude > 0 then
            local v59 = Vector2.new(1, l__UserGameSettings__14:GetCameraYInvertValue());
            local v60 = p54:InputTranslationToCameraAngleChange(20 * p56, u5) * v59;
            p54.rotateInput = p54.rotateInput + v60;
        end;
        local l__currentSubjectDistance__24 = p54.currentSubjectDistance;
        local v61 = -(p55 + p57);
        if l__abs__2(v61) > 0 then
            local v62;
            if p54.inFirstPerson and v61 > 0 then
                v62 = 1;
            elseif u11 then
                if v61 > 0 then
                    v62 = l__currentSubjectDistance__24 + v61 * (1 + l__currentSubjectDistance__24 * 0.5);
                else
                    v62 = (l__currentSubjectDistance__24 + v61) / (1 - v61 * 0.5);
                end;
            else
                v62 = l__currentSubjectDistance__24 + v61 * (1 + l__currentSubjectDistance__24 * 0.5);
            end;
            p54:SetCameraToSubjectDistance(v62);
        end;
    end;
end;
function u15.ConnectInputEvents(u63) --[[ Line: 615 ]]
    -- upvalues: u14 (ref), l__UserInputService__9 (copy), l__GuiService__11 (copy), u8 (ref)
    assert(not u14);
    u63.pointerActionConn = l__UserInputService__9.PointerAction:Connect(function(p64, p65, p66, p67) --[[ Line: 618 ]]
        -- upvalues: u63 (copy)
        u63:OnPointerAction(p64, p65, p66, p67);
    end);
    u63.inputBeganConn = l__UserInputService__9.InputBegan:Connect(function(p68, p69) --[[ Line: 622 ]]
        -- upvalues: u63 (copy)
        u63:OnInputBegan(p68, p69);
    end);
    u63.inputChangedConn = l__UserInputService__9.InputChanged:Connect(function(p70, p71) --[[ Line: 626 ]]
        -- upvalues: u63 (copy)
        u63:OnInputChanged(p70, p71);
    end);
    u63.inputEndedConn = l__UserInputService__9.InputEnded:Connect(function(p72, p73) --[[ Line: 630 ]]
        -- upvalues: u63 (copy)
        u63:OnInputEnded(p72, p73);
    end);
    u63.menuOpenedConn = l__GuiService__11.MenuOpened:connect(function() --[[ Line: 634 ]]
        -- upvalues: u63 (copy)
        u63:ResetInputStates();
    end);
    u63.gamepadConnectedConn = l__UserInputService__9.GamepadDisconnected:connect(function(p74) --[[ Line: 638 ]]
        -- upvalues: u63 (copy)
        if u63.activeGamepad == p74 then
            u63.activeGamepad = nil;
            u63:AssignActivateGamepad();
        end;
    end);
    u63.gamepadDisconnectedConn = l__UserInputService__9.GamepadConnected:connect(function(_) --[[ Line: 644 ]]
        -- upvalues: u63 (copy)
        if u63.activeGamepad == nil then
            u63:AssignActivateGamepad();
        end;
    end);
    u63:AssignActivateGamepad();
    if not u8 then
        u63:UpdateMouseBehavior();
    end;
end;
function u15.BindContextActions(p75) --[[ Line: 657 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    p75:BindGamepadInputActions();
    p75:BindKeyboardInputActions();
end;
function u15.AssignActivateGamepad(p76) --[[ Line: 665 ]]
    -- upvalues: u14 (ref), l__UserInputService__9 (copy)
    assert(not u14);
    local v77 = l__UserInputService__9:GetConnectedGamepads();
    if #v77 > 0 then
        for v78 = 1, #v77 do
            if p76.activeGamepad == nil then
                p76.activeGamepad = v77[v78];
            elseif v77[v78].Value < p76.activeGamepad.Value then
                p76.activeGamepad = v77[v78];
            end;
        end;
    end;
    if p76.activeGamepad == nil then
        p76.activeGamepad = Enum.UserInputType.Gamepad1;
    end;
end;
function u15.DisconnectInputEvents(p79) --[[ Line: 685 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    if p79.inputBeganConn then
        p79.inputBeganConn:Disconnect();
        p79.inputBeganConn = nil;
    end;
    if p79.inputChangedConn then
        p79.inputChangedConn:Disconnect();
        p79.inputChangedConn = nil;
    end;
    if p79.inputEndedConn then
        p79.inputEndedConn:Disconnect();
        p79.inputEndedConn = nil;
    end;
end;
function u15.UnbindContextActions(p80) --[[ Line: 703 ]]
    -- upvalues: u14 (ref), l__ContextActionService__12 (copy)
    assert(not u14);
    for v81 = 1, #p80.boundContextActions do
        l__ContextActionService__12:UnbindAction(p80.boundContextActions[v81]);
    end;
    p80.boundContextActions = {};
end;
function u15.Cleanup(p82) --[[ Line: 712 ]]
    -- upvalues: u3 (copy), l__UserInputService__9 (copy)
    if p82.pointerActionConn then
        p82.pointerActionConn:Disconnect();
        p82.pointerActionConn = nil;
    end;
    if p82.menuOpenedConn then
        p82.menuOpenedConn:Disconnect();
        p82.menuOpenedConn = nil;
    end;
    if p82.mouseLockToggleConn then
        p82.mouseLockToggleConn:Disconnect();
        p82.mouseLockToggleConn = nil;
    end;
    if p82.gamepadConnectedConn then
        p82.gamepadConnectedConn:Disconnect();
        p82.gamepadConnectedConn = nil;
    end;
    if p82.gamepadDisconnectedConn then
        p82.gamepadDisconnectedConn:Disconnect();
        p82.gamepadDisconnectedConn = nil;
    end;
    if p82.subjectStateChangedConn then
        p82.subjectStateChangedConn:Disconnect();
        p82.subjectStateChangedConn = nil;
    end;
    if p82.viewportSizeChangedConn then
        p82.viewportSizeChangedConn:Disconnect();
        p82.viewportSizeChangedConn = nil;
    end;
    if p82.touchActivateConn then
        p82.touchActivateConn:Disconnect();
        p82.touchActivateConn = nil;
    end;
    p82.turningLeft = false;
    p82.turningRight = false;
    p82.lastCameraTransform = nil;
    p82.lastSubjectCFrame = nil;
    p82.userPanningTheCamera = false;
    p82.rotateInput = Vector2.new();
    if p82.gamepadPanningCamera then
        p82.gamepadPanningCamera = u3;
    end;
    p82.startPos = nil;
    p82.lastPos = nil;
    p82.panBeginLook = nil;
    p82.isRightMouseDown = false;
    p82.isMiddleMouseDown = false;
    p82.fingerTouches = {};
    p82.dynamicTouchInput = nil;
    p82.numUnsunkTouches = 0;
    p82.startingDiff = nil;
    p82.pinchBeginZoom = nil;
    if l__UserInputService__9.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        l__UserInputService__9.MouseBehavior = Enum.MouseBehavior.Default;
    end;
end;
function u15.ResetInputStates(p83) --[[ Line: 778 ]]
    -- upvalues: u14 (ref), l__UserInputService__9 (copy)
    assert(not u14);
    p83.isRightMouseDown = false;
    p83.isMiddleMouseDown = false;
    p83:OnMousePanButtonReleased();
    if l__UserInputService__9.TouchEnabled then
        for v84 in pairs(p83.fingerTouches) do
            p83.fingerTouches[v84] = nil;
        end;
        p83.dynamicTouchInput = nil;
        p83.panBeginLook = nil;
        p83.startPos = nil;
        p83.lastPos = nil;
        p83.userPanningTheCamera = false;
        p83.startingDiff = nil;
        p83.pinchBeginZoom = nil;
        p83.numUnsunkTouches = 0;
    end;
end;
function u15.GetGamepadPan(p85, _, p86, p87) --[[ Line: 804 ]]
    -- upvalues: u14 (ref), u3 (copy)
    assert(not u14);
    if p87.UserInputType ~= p85.activeGamepad or p87.KeyCode ~= Enum.KeyCode.Thumbstick2 then
        return Enum.ContextActionResult.Pass;
    end;
    if p86 ~= Enum.UserInputState.Cancel then
        if Vector2.new(p87.Position.X, -p87.Position.Y).magnitude > 0.2 then
            p85.gamepadPanningCamera = Vector2.new(p87.Position.X, -p87.Position.Y);
        else
            p85.gamepadPanningCamera = u3;
        end;
        return Enum.ContextActionResult.Sink;
    end;
    p85.gamepadPanningCamera = u3;
end;
function u15.DoKeyboardPanTurn(p88, _, p89, p90) --[[ Line: 836 ]]
    -- upvalues: u14 (ref), l__VRService__13 (copy)
    assert(not u14);
    if p88.hasGameLoaded or not l__VRService__13.VREnabled then
        if p89 == Enum.UserInputState.Cancel then
            p88.turningLeft = false;
            p88.turningRight = false;
            return Enum.ContextActionResult.Sink;
        else
            if p88.panBeginLook ~= nil or not p88.keyPanEnabled then
                return Enum.ContextActionResult.Pass;
            end;
            if p90.KeyCode == Enum.KeyCode.Left then
                p88.turningLeft = p89 == Enum.UserInputState.Begin;
            elseif p90.KeyCode == Enum.KeyCode.Right then
                p88.turningRight = p89 == Enum.UserInputState.Begin;
            end;
            return Enum.ContextActionResult.Sink;
        end;
    else
        return Enum.ContextActionResult.Pass;
    end;
end;
function u15.DoGamepadZoom(p91, _, p92, p93) --[[ Line: 861 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    if p93.UserInputType ~= p91.activeGamepad then
        return Enum.ContextActionResult.Pass;
    end;
    if p93.KeyCode == Enum.KeyCode.ButtonR3 then
        if p92 == Enum.UserInputState.Begin and p91.distanceChangeEnabled then
            local v94 = p91:GetCameraToSubjectDistance();
            if v94 > 15 then
                p91:SetCameraToSubjectDistance(10);
            elseif v94 > 5 then
                p91:SetCameraToSubjectDistance(0);
            else
                p91:SetCameraToSubjectDistance(20);
            end;
        end;
    elseif p93.KeyCode == Enum.KeyCode.DPadLeft then
        p91.dpadLeftDown = p92 == Enum.UserInputState.Begin;
    elseif p93.KeyCode == Enum.KeyCode.DPadRight then
        p91.dpadRightDown = p92 == Enum.UserInputState.Begin;
    end;
    if p91.dpadLeftDown then
        p91.currentZoomSpeed = 1.04;
    elseif p91.dpadRightDown then
        p91.currentZoomSpeed = 0.96;
    else
        p91.currentZoomSpeed = 1;
    end;
    return Enum.ContextActionResult.Sink;
end;
function u15.DoKeyboardZoom(p95, _, p96, p97) --[[ Line: 906 ]]
    -- upvalues: u14 (ref), l__VRService__13 (copy), l__LocalPlayer__15 (copy)
    assert(not u14);
    if not p95.hasGameLoaded and l__VRService__13.VREnabled then
        return Enum.ContextActionResult.Pass;
    end;
    if p96 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;
    if not p95.distanceChangeEnabled or l__LocalPlayer__15.CameraMode == Enum.CameraMode.LockFirstPerson then
        return Enum.ContextActionResult.Pass;
    end;
    if p97.KeyCode == Enum.KeyCode.I then
        p95:SetCameraToSubjectDistance(p95.currentSubjectDistance - 5);
    elseif p97.KeyCode == Enum.KeyCode.O then
        p95:SetCameraToSubjectDistance(p95.currentSubjectDistance + 5);
    end;
    return Enum.ContextActionResult.Sink;
end;
function u15.BindAction(p98, p99, p100, p101, ...) --[[ Line: 929 ]]
    -- upvalues: u14 (ref), l__ContextActionService__12 (copy), l__Value__1 (copy)
    assert(not u14);
    table.insert(p98.boundContextActions, p99);
    l__ContextActionService__12:BindActionAtPriority(p99, p100, p101, l__Value__1, ...);
end;
function u15.BindGamepadInputActions(u102) --[[ Line: 938 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    u102:BindAction("BaseCameraGamepadPan", function(p103, p104, p105) --[[ Line: 941 ]]
        -- upvalues: u102 (copy)
        return u102:GetGamepadPan(p103, p104, p105);
    end, false, Enum.KeyCode.Thumbstick2);
    u102:BindAction("BaseCameraGamepadZoom", function(p106, p107, p108) --[[ Line: 943 ]]
        -- upvalues: u102 (copy)
        return u102:DoGamepadZoom(p106, p107, p108);
    end, false, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight, Enum.KeyCode.ButtonR3);
end;
function u15.BindKeyboardInputActions(u109) --[[ Line: 948 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    u109:BindAction("BaseCameraKeyboardPanArrowKeys", function(p110, p111, p112) --[[ Line: 951 ]]
        -- upvalues: u109 (copy)
        return u109:DoKeyboardPanTurn(p110, p111, p112);
    end, false, Enum.KeyCode.Left, Enum.KeyCode.Right);
    u109:BindAction("BaseCameraKeyboardZoom", function(p113, p114, p115) --[[ Line: 953 ]]
        -- upvalues: u109 (copy)
        return u109:DoKeyboardZoom(p113, p114, p115);
    end, false, Enum.KeyCode.I, Enum.KeyCode.O);
end;
local function u119(p116) --[[ Line: 958 ]]
    -- upvalues: u14 (ref), l__LocalPlayer__15 (copy)
    assert(not u14);
    local v117 = l__LocalPlayer__15:FindFirstChildOfClass("PlayerGui");
    if v117 then
        v117 = v117:FindFirstChild("TouchGui");
    end;
    if v117 then
        v117 = v117:FindFirstChild("TouchControlFrame");
    end;
    if v117 then
        v117 = v117:FindFirstChild("DynamicThumbstickFrame");
    end;
    if not v117 then
        return false;
    end;
    local l__AbsolutePosition__25 = v117.AbsolutePosition;
    local v118 = l__AbsolutePosition__25 + v117.AbsoluteSize;
    return p116.Position.X >= l__AbsolutePosition__25.X and (p116.Position.Y >= l__AbsolutePosition__25.Y and (p116.Position.X <= v118.X and p116.Position.Y <= v118.Y));
end;
function u15.AdjustTouchSensitivity(_, p120, p121) --[[ Line: 982 ]]
    local l__CurrentCamera__26 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__26 then
        l__CurrentCamera__26 = game.Workspace.CurrentCamera.CFrame;
    end;
    if not l__CurrentCamera__26 then
        return p121;
    end;
    local v122 = l__CurrentCamera__26:ToEulerAnglesYXZ();
    local v123 = 2.1;
    if v122 > 0.5235987755982988 and p120.Y < 0 then
        v123 = 2.1 - (1 - (1 - (v122 - 0.5235987755982988) / 0.8726646259971648) ^ 3) * 1.6;
    elseif v122 < -0.2617993877991494 and p120.Y > 0 then
        v123 = 2.1 - (1 - (1 - (v122 - -0.2617993877991494) / -1.1344640137963142) ^ 3) * 1.6;
    end;
    return Vector2.new(p121.X, p121.Y * v123);
end;
function u15.OnTouchBegan(p124, p125, p126) --[[ Line: 1009 ]]
    -- upvalues: u14 (ref), u119 (copy)
    assert(not u14);
    local l__isDynamicThumbstickEnabled__27 = p124.isDynamicThumbstickEnabled;
    if l__isDynamicThumbstickEnabled__27 then
        l__isDynamicThumbstickEnabled__27 = not p126;
    end;
    if l__isDynamicThumbstickEnabled__27 then
        if p124.dynamicTouchInput == nil and u119(p125) then
            p124.dynamicTouchInput = p125;
            return;
        end;
        p124.fingerTouches[p125] = p126;
        p124.inputStartPositions[p125] = p125.Position;
        p124.inputStartTimes[p125] = tick();
        p124.numUnsunkTouches = p124.numUnsunkTouches + 1;
    end;
end;
function u15.OnTouchChanged(p127, p128, p129) --[[ Line: 1028 ]]
    -- upvalues: u14 (ref), l__UserGameSettings__14 (copy), u4 (copy)
    assert(not u14);
    if p127.fingerTouches[p128] == nil then
        if p127.isDynamicThumbstickEnabled then
            return;
        end;
        p127.fingerTouches[p128] = p129;
        if not p129 then
            p127.numUnsunkTouches = p127.numUnsunkTouches + 1;
        end;
    end;
    if p127.numUnsunkTouches == 1 then
        if p127.fingerTouches[p128] == false then
            p127.panBeginLook = p127.panBeginLook or p127:GetCameraLookVector();
            p127.startPos = p127.startPos or p128.Position;
            p127.lastPos = p127.lastPos or p127.startPos;
            p127.userPanningTheCamera = true;
            local v130 = p128.Position - p127.lastPos;
            local v131 = Vector2.new(v130.X, v130.Y * l__UserGameSettings__14:GetCameraYInvertValue());
            if p127.panEnabled then
                local v132 = u4;
                p127:AdjustTouchSensitivity(v131, u4);
                local v133 = p127:InputTranslationToCameraAngleChange(v131, v132);
                p127.rotateInput = p127.rotateInput + v133;
            end;
            p127.lastPos = p128.Position;
        end;
    else
        p127.panBeginLook = nil;
        p127.startPos = nil;
        p127.lastPos = nil;
        p127.userPanningTheCamera = false;
    end;
    if p127.numUnsunkTouches == 2 then
        local v134 = {};
        for v135, v136 in pairs(p127.fingerTouches) do
            if not v136 then
                table.insert(v134, v135);
            end;
        end;
        if #v134 == 2 then
            local l__magnitude__28 = (v134[1].Position - v134[2].Position).magnitude;
            if not (p127.startingDiff and p127.pinchBeginZoom) then
                p127.startingDiff = l__magnitude__28;
                p127.pinchBeginZoom = p127:GetCameraToSubjectDistance();
                return;
            end;
            local v137 = l__magnitude__28 / math.max(0.01, p127.startingDiff);
            local v138 = math.clamp(v137, 0.1, 10);
            if p127.distanceChangeEnabled then
                p127:SetCameraToSubjectDistance(p127.pinchBeginZoom / v138);
            end;
        end;
    else
        p127.startingDiff = nil;
        p127.pinchBeginZoom = nil;
    end;
end;
function u15.OnTouchEnded(p139, p140, _) --[[ Line: 1092 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    if p140 == p139.dynamicTouchInput then
        p139.dynamicTouchInput = nil;
    else
        if p139.fingerTouches[p140] == false then
            if p139.numUnsunkTouches == 1 then
                p139.panBeginLook = nil;
                p139.startPos = nil;
                p139.lastPos = nil;
                p139.userPanningTheCamera = false;
            elseif p139.numUnsunkTouches == 2 then
                p139.startingDiff = nil;
                p139.pinchBeginZoom = nil;
            end;
        end;
        if p139.fingerTouches[p140] ~= nil and p139.fingerTouches[p140] == false then
            p139.numUnsunkTouches = p139.numUnsunkTouches - 1;
        end;
        p139.fingerTouches[p140] = nil;
        p139.inputStartPositions[p140] = nil;
        p139.inputStartTimes[p140] = nil;
    end;
end;
function u15.OnMouse2Down(p141, p142, p143) --[[ Line: 1121 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    if p143 then
    else
        p141.isRightMouseDown = true;
        p141:OnMousePanButtonPressed(p142, p143);
    end;
end;
function u15.OnMouse2Up(p144, p145, p146) --[[ Line: 1131 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    p144.isRightMouseDown = false;
    p144:OnMousePanButtonReleased(p145, p146);
end;
function u15.OnMouse3Down(p147, p148, p149) --[[ Line: 1139 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    if p149 then
    else
        p147.isMiddleMouseDown = true;
        p147:OnMousePanButtonPressed(p148, p149);
    end;
end;
function u15.OnMouse3Up(p150, p151, p152) --[[ Line: 1149 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    p150.isMiddleMouseDown = false;
    p150:OnMousePanButtonReleased(p151, p152);
end;
function u15.OnMouseMoved(p153, p154, _) --[[ Line: 1157 ]]
    -- upvalues: u14 (ref), l__VRService__13 (copy), l__UserGameSettings__14 (copy), u8 (ref), l__CameraInput__6 (copy), u5 (copy)
    assert(not u14);
    if p153.hasGameLoaded or not l__VRService__13.VREnabled then
        local l__Delta__29 = p154.Delta;
        local v155 = Vector2.new(l__Delta__29.X, l__Delta__29.Y * l__UserGameSettings__14:GetCameraYInvertValue());
        local v156 = u8;
        if v156 then
            v156 = l__CameraInput__6.getPanning();
        end;
        local v157 = p153.startPos and p153.lastPos;
        if v157 then
            v157 = p153.panBeginLook;
        end;
        if p153.panEnabled and (v157 or p153.inFirstPerson or (p153.inMouseLockedMode or v156)) then
            local v158 = p153:InputTranslationToCameraAngleChange(v155, u5);
            p153.rotateInput = p153.rotateInput + v158;
        end;
        if p153.startPos and (p153.lastPos and p153.panBeginLook) then
            p153.lastPos = p153.lastPos + p154.Delta;
        end;
    end;
end;
function u15.OnMousePanButtonPressed(p159, p160, p161) --[[ Line: 1182 ]]
    -- upvalues: u14 (ref), u8 (ref)
    assert(not u14);
    if p161 then
    else
        if not u8 then
            p159:UpdateMouseBehavior();
        end;
        p159.panBeginLook = p159.panBeginLook or p159:GetCameraLookVector();
        p159.startPos = p159.startPos or p160.Position;
        p159.lastPos = p159.lastPos or p159.startPos;
        p159.userPanningTheCamera = true;
    end;
end;
function u15.OnMousePanButtonReleased(p162, _, _) --[[ Line: 1196 ]]
    -- upvalues: u14 (ref), u8 (ref)
    assert(not u14);
    if not u8 then
        p162:UpdateMouseBehavior();
    end;
    if not (p162.isRightMouseDown or p162.isMiddleMouseDown) then
        p162.panBeginLook = nil;
        p162.startPos = nil;
        p162.lastPos = nil;
        p162.userPanningTheCamera = false;
    end;
end;
function u15.UpdateMouseBehavior(p163) --[[ Line: 1210 ]]
    -- upvalues: u8 (ref), l__CameraUI__7 (copy), l__CameraInput__6 (copy), l__CameraToggleStateController__5 (copy), l__UserGameSettings__14 (copy), l__UserInputService__9 (copy)
    if u8 and p163.isCameraToggle then
        l__CameraUI__7.setCameraModeToastEnabled(true);
        l__CameraInput__6.enableCameraToggleInput();
        l__CameraToggleStateController__5(p163.inFirstPerson);
    else
        if u8 then
            l__CameraUI__7.setCameraModeToastEnabled(false);
            l__CameraInput__6.disableCameraToggleInput();
        end;
        if p163.inFirstPerson or p163.inMouseLockedMode then
            l__UserGameSettings__14.RotationType = Enum.RotationType.CameraRelative;
            l__UserInputService__9.MouseBehavior = Enum.MouseBehavior.LockCenter;
        else
            l__UserGameSettings__14.RotationType = Enum.RotationType.MovementRelative;
            if p163.isRightMouseDown or p163.isMiddleMouseDown then
                l__UserInputService__9.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
            else
                l__UserInputService__9.MouseBehavior = Enum.MouseBehavior.Default;
            end;
        end;
    end;
end;
function u15.UpdateForDistancePropertyChange(p164) --[[ Line: 1235 ]]
    p164:SetCameraToSubjectDistance(p164.currentSubjectDistance);
end;
function u15.SetCameraToSubjectDistance(p165, p166) --[[ Line: 1241 ]]
    -- upvalues: l__LocalPlayer__15 (copy), l__ZoomController__4 (copy)
    local l__currentSubjectDistance__30 = p165.currentSubjectDistance;
    if l__LocalPlayer__15.CameraMode == Enum.CameraMode.LockFirstPerson then
        p165.currentSubjectDistance = 0.5;
        if not p165.inFirstPerson then
            p165:EnterFirstPerson();
        end;
    else
        local v167 = math.clamp(p166, l__LocalPlayer__15.CameraMinZoomDistance, l__LocalPlayer__15.CameraMaxZoomDistance);
        if v167 < 1 then
            p165.currentSubjectDistance = 0.5;
            if not p165.inFirstPerson then
                p165:EnterFirstPerson();
            end;
        else
            p165.currentSubjectDistance = v167;
            if p165.inFirstPerson then
                p165:LeaveFirstPerson();
            end;
        end;
    end;
    l__ZoomController__4.SetZoomParameters(p165.currentSubjectDistance, (math.sign(p166 - l__currentSubjectDistance__30)));
    return p165.currentSubjectDistance;
end;
function u15.SetCameraType(p168, p169) --[[ Line: 1275 ]]
    p168.cameraType = p169;
end;
function u15.GetCameraType(p170) --[[ Line: 1280 ]]
    return p170.cameraType;
end;
function u15.SetCameraMovementMode(p171, p172) --[[ Line: 1285 ]]
    p171.cameraMovementMode = p172;
end;
function u15.GetCameraMovementMode(p173) --[[ Line: 1289 ]]
    return p173.cameraMovementMode;
end;
function u15.SetIsMouseLocked(p174, p175) --[[ Line: 1293 ]]
    -- upvalues: u8 (ref)
    p174.inMouseLockedMode = p175;
    if not u8 then
        p174:UpdateMouseBehavior();
    end;
end;
function u15.GetIsMouseLocked(p176) --[[ Line: 1300 ]]
    return p176.inMouseLockedMode;
end;
function u15.SetMouseLockOffset(p177, p178) --[[ Line: 1304 ]]
    p177.mouseLockOffset = p178;
end;
function u15.GetMouseLockOffset(p179) --[[ Line: 1308 ]]
    return p179.mouseLockOffset;
end;
function u15.InFirstPerson(p180) --[[ Line: 1312 ]]
    return p180.inFirstPerson;
end;
function u15.EnterFirstPerson(_) --[[ Line: 1316 ]] end;
function u15.LeaveFirstPerson(_) --[[ Line: 1320 ]] end;
function u15.GetCameraToSubjectDistance(p181) --[[ Line: 1325 ]]
    return p181.currentSubjectDistance;
end;
function u15.GetMeasuredDistanceToFocus(_) --[[ Line: 1332 ]]
    local l__CurrentCamera__31 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__31 then
        return (l__CurrentCamera__31.CoordinateFrame.p - l__CurrentCamera__31.Focus.p).magnitude;
    else
        return nil;
    end;
end;
function u15.GetCameraLookVector(_) --[[ Line: 1340 ]]
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.lookVector or Vector3.new(0, 0, 1);
end;
function u15.CalculateNewLookCFrameFromArg(p182, p183, p184) --[[ Line: 1344 ]]
    local v185 = p183 or p182:GetCameraLookVector();
    local v186 = math.asin(v185.y);
    local v187 = math.clamp(p184.y, v186 + -1.3962634015954636, v186 + 1.3962634015954636);
    local v188 = Vector2.new(p184.x, v187);
    local v189 = CFrame.new(Vector3.new(0, 0, 0), v185);
    return CFrame.Angles(0, -v188.x, 0) * v189 * CFrame.Angles(-v188.y, 0, 0);
end;
function u15.CalculateNewLookVectorFromArg(p190, p191, p192) --[[ Line: 1354 ]]
    return p190:CalculateNewLookCFrameFromArg(p191, p192).lookVector;
end;
function u15.CalculateNewLookVectorVRFromArg(p193, p194) --[[ Line: 1359 ]]
    local l__unit__32 = ((p193:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local v195 = Vector2.new(p194.x, 0);
    local v196 = CFrame.new(Vector3.new(0, 0, 0), l__unit__32);
    return ((CFrame.Angles(0, -v195.x, 0) * v196 * CFrame.Angles(-v195.y, 0, 0)).lookVector * Vector3.new(1, 0, 1)).unit;
end;
function u15.CalculateNewLookCFrame(p197, p198) --[[ Line: 1372 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    local v199 = p198 or p197:GetCameraLookVector();
    local v200 = math.asin(v199.y);
    local v201 = math.clamp(p197.rotateInput.y, v200 + -1.3962634015954636, v200 + 1.3962634015954636);
    local v202 = Vector2.new(p197.rotateInput.x, v201);
    local v203 = CFrame.new(Vector3.new(0, 0, 0), v199);
    return CFrame.Angles(0, -v202.x, 0) * v203 * CFrame.Angles(-v202.y, 0, 0);
end;
function u15.CalculateNewLookVector(p204, p205) --[[ Line: 1385 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    return p204:CalculateNewLookCFrame(p205).lookVector;
end;
function u15.CalculateNewLookVectorVR(p206) --[[ Line: 1393 ]]
    -- upvalues: u14 (ref)
    assert(not u14);
    local l__unit__33 = ((p206:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local v207 = Vector2.new(p206.rotateInput.x, 0);
    local v208 = CFrame.new(Vector3.new(0, 0, 0), l__unit__33);
    return ((CFrame.Angles(0, -v207.x, 0) * v208 * CFrame.Angles(-v207.y, 0, 0)).lookVector * Vector3.new(1, 0, 1)).unit;
end;
function u15.GetHumanoid(p209) --[[ Line: 1405 ]]
    -- upvalues: l__LocalPlayer__15 (copy)
    local v210 = l__LocalPlayer__15;
    if v210 then
        v210 = l__LocalPlayer__15.Character;
    end;
    if not v210 then
        return nil;
    end;
    local v211 = p209.humanoidCache[l__LocalPlayer__15];
    if v211 and v211.Parent == v210 then
        return v211;
    end;
    p209.humanoidCache[l__LocalPlayer__15] = nil;
    local v212 = v210:FindFirstChildOfClass("Humanoid");
    if v212 then
        p209.humanoidCache[l__LocalPlayer__15] = v212;
    end;
    return v212;
end;
function u15.GetHumanoidPartToFollow(_, p213, p214) --[[ Line: 1423 ]]
    if p214 == Enum.HumanoidStateType.Dead then
        local l__Parent__34 = p213.Parent;
        if l__Parent__34 then
            return l__Parent__34:FindFirstChild("Head") or p213.Torso;
        else
            return p213.Torso;
        end;
    else
        return p213.Torso;
    end;
end;
function u15.UpdateGamepad(p215) --[[ Line: 1436 ]]
    -- upvalues: l__VRService__13 (copy), l__CameraUtils__3 (copy), u3 (copy), l__UserGameSettings__14 (copy)
    local l__gamepadPanningCamera__35 = p215.gamepadPanningCamera;
    if not l__gamepadPanningCamera__35 or not p215.hasGameLoaded and l__VRService__13.VREnabled then
        return u3;
    end;
    local v216 = l__CameraUtils__3.GamepadLinearToCurve(l__gamepadPanningCamera__35);
    local v217 = tick();
    if v216.X == 0 and v216.Y == 0 then
        if v216 == u3 then
            p215.userPanningTheCamera = false;
            p215.gamepadPanningCamera = false;
            p215.lastThumbstickRotate = nil;
            if p215.lastThumbstickPos == u3 then
                p215.currentSpeed = 0;
            end;
        end;
    else
        p215.userPanningTheCamera = true;
    end;
    local v218;
    if p215.lastThumbstickRotate then
        if l__VRService__13.VREnabled then
            p215.currentSpeed = p215.vrMaxSpeed;
        else
            local v219 = (v217 - p215.lastThumbstickRotate) * 10;
            p215.currentSpeed = p215.currentSpeed + p215.maxSpeed * (v219 * v219 / p215.numOfSeconds);
            if p215.currentSpeed > p215.maxSpeed then
                p215.currentSpeed = p215.maxSpeed;
            end;
            if p215.lastVelocity then
                local l__magnitude__36 = ((v216 - p215.lastThumbstickPos) / (v217 - p215.lastThumbstickRotate) - p215.lastVelocity).magnitude;
                if l__magnitude__36 > 12 then
                    p215.currentSpeed = p215.currentSpeed * (20 / l__magnitude__36);
                    if p215.currentSpeed > p215.maxSpeed then
                        p215.currentSpeed = p215.maxSpeed;
                    end;
                end;
            end;
        end;
        v218 = l__UserGameSettings__14.GamepadCameraSensitivity * p215.currentSpeed;
        p215.lastVelocity = (v216 - p215.lastThumbstickPos) / (v217 - p215.lastThumbstickRotate);
    else
        v218 = 0;
    end;
    p215.lastThumbstickPos = v216;
    p215.lastThumbstickRotate = v217;
    return Vector2.new(v216.X * v218, v216.Y * v218 * p215.ySensitivity * l__UserGameSettings__14:GetCameraYInvertValue());
end;
function u15.ApplyVRTransform(p220) --[[ Line: 1489 ]]
    -- upvalues: l__VRService__13 (copy)
    if l__VRService__13.VREnabled then
        local l__humanoidRootPart__37 = p220.humanoidRootPart;
        if l__humanoidRootPart__37 then
            l__humanoidRootPart__37 = p220.humanoidRootPart:FindFirstChild("RootJoint");
        end;
        if l__humanoidRootPart__37 then
            local l__CameraSubject__38 = game.Workspace.CurrentCamera.CameraSubject;
            if l__CameraSubject__38 then
                l__CameraSubject__38 = l__CameraSubject__38:IsA("VehicleSeat");
            end;
            if p220.inFirstPerson and not l__CameraSubject__38 then
                local v221 = l__VRService__13:GetUserCFrame(Enum.UserCFrame.Head);
                l__humanoidRootPart__37.C0 = CFrame.new((v221 - v221.p):vectorToObjectSpace(v221.p)) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0);
            else
                l__humanoidRootPart__37.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0);
            end;
        end;
    end;
end;
function u15.IsInFirstPerson(p222) --[[ Line: 1512 ]]
    return p222.inFirstPerson;
end;
function u15.ShouldUseVRRotation(p223) --[[ Line: 1516 ]]
    -- upvalues: l__VRService__13 (copy), l__StarterGui__10 (copy)
    if not l__VRService__13.VREnabled then
        return false;
    end;
    if not p223.VRRotationIntensityAvailable and tick() - p223.lastVRRotationIntensityCheckTime < 1 then
        return false;
    end;
    local v224, v225 = pcall(function() --[[ Line: 1525 ]]
        -- upvalues: l__StarterGui__10 (ref)
        return l__StarterGui__10:GetCore("VRRotationIntensity");
    end);
    local v226;
    if v224 then
        v226 = v225 ~= nil;
    else
        v226 = v224;
    end;
    p223.VRRotationIntensityAvailable = v226;
    p223.lastVRRotationIntensityCheckTime = tick();
    if v224 then
        if v225 == nil then
            v224 = false;
        else
            v224 = v225 ~= "Smooth";
        end;
    end;
    p223.shouldUseVRRotation = v224;
    return p223.shouldUseVRRotation;
end;
function u15.GetVRRotationInput(p227) --[[ Line: 1534 ]]
    -- upvalues: u3 (copy), l__StarterGui__10 (copy)
    local v228 = u3;
    local v229, v230 = pcall(function() --[[ Line: 1536 ]]
        -- upvalues: l__StarterGui__10 (ref)
        return l__StarterGui__10:GetCore("VRRotationIntensity");
    end);
    if v229 then
        local v231 = p227.GamepadPanningCamera or u3;
        local v232 = tick() - p227.lastVRRotationTime >= p227:GetRepeatDelayValue(v230);
        if math.abs(v231.x) >= p227:GetActivateValue() then
            if v232 or not p227.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] then
                local v233 = v231.x < 0 and -1 or 1;
                v228 = v228 + p227:GetRotateAmountValue(v230) * v233;
                p227.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] = true;
            end;
        elseif math.abs(v231.x) < p227:GetActivateValue() - 0.1 then
            p227.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] = nil;
        end;
        if p227.turningLeft then
            if v232 or not p227.vrRotateKeyCooldown[Enum.KeyCode.Left] then
                v228 = v228 - p227:GetRotateAmountValue(v230);
                p227.vrRotateKeyCooldown[Enum.KeyCode.Left] = true;
            end;
        else
            p227.vrRotateKeyCooldown[Enum.KeyCode.Left] = nil;
        end;
        if p227.turningRight then
            if v232 or not p227.vrRotateKeyCooldown[Enum.KeyCode.Right] then
                v228 = v228 + p227:GetRotateAmountValue(v230);
                p227.vrRotateKeyCooldown[Enum.KeyCode.Right] = true;
            end;
        else
            p227.vrRotateKeyCooldown[Enum.KeyCode.Right] = nil;
        end;
        if v228 ~= u3 then
            p227.lastVRRotationTime = tick();
        end;
        return v228;
    end;
end;
function u15.CancelCameraFreeze(p234, p235) --[[ Line: 1581 ]]
    if not p235 then
        p234.cameraTranslationConstraints = Vector3.new(p234.cameraTranslationConstraints.x, 1, p234.cameraTranslationConstraints.z);
    end;
    if p234.cameraFrozen then
        p234.trackingHumanoid = nil;
        p234.cameraFrozen = false;
    end;
end;
function u15.StartCameraFreeze(p236, p237, p238) --[[ Line: 1591 ]]
    if not p236.cameraFrozen then
        p236.humanoidJumpOrigin = p237;
        p236.trackingHumanoid = p238;
        p236.cameraTranslationConstraints = Vector3.new(p236.cameraTranslationConstraints.x, 0, p236.cameraTranslationConstraints.z);
        p236.cameraFrozen = true;
    end;
end;
function u15.OnNewCameraSubject(u239) --[[ Line: 1600 ]]
    -- upvalues: l__VRService__13 (copy)
    if u239.subjectStateChangedConn then
        u239.subjectStateChangedConn:Disconnect();
        u239.subjectStateChangedConn = nil;
    end;
    local l__CurrentCamera__39 = workspace.CurrentCamera;
    if l__CurrentCamera__39 then
        l__CurrentCamera__39 = workspace.CurrentCamera.CameraSubject;
    end;
    if u239.trackingHumanoid ~= l__CurrentCamera__39 then
        u239:CancelCameraFreeze();
    end;
    if l__CurrentCamera__39 and l__CurrentCamera__39:IsA("Humanoid") then
        u239.subjectStateChangedConn = l__CurrentCamera__39.StateChanged:Connect(function(_, p240) --[[ Line: 1611 ]]
            -- upvalues: l__VRService__13 (ref), u239 (copy), l__CurrentCamera__39 (copy)
            if l__VRService__13.VREnabled and (p240 == Enum.HumanoidStateType.Jumping and not u239.inFirstPerson) then
                u239:StartCameraFreeze(u239:GetSubjectPosition(), l__CurrentCamera__39);
            else
                if p240 ~= Enum.HumanoidStateType.Jumping and p240 ~= Enum.HumanoidStateType.Freefall then
                    u239:CancelCameraFreeze(true);
                end;
            end;
        end);
    end;
end;
function u15.GetVRFocus(p241, p242, p243) --[[ Line: 1621 ]]
    local v244 = p241.LastCameraFocus or p242;
    if not p241.cameraFrozen then
        local l__x__40 = p241.cameraTranslationConstraints.x;
        local v245 = math.min(1, p241.cameraTranslationConstraints.y + 0.42 * p243);
        p241.cameraTranslationConstraints = Vector3.new(l__x__40, v245, p241.cameraTranslationConstraints.z);
    end;
    local v246;
    if p241.cameraFrozen and (p241.humanoidJumpOrigin and p241.humanoidJumpOrigin.y > v244.y) then
        local l__new__41 = CFrame.new;
        local l__x__42 = p242.x;
        local v247 = math.min(p241.humanoidJumpOrigin.y, v244.y + 5 * p243);
        v246 = l__new__41((Vector3.new(l__x__42, v247, p242.z)));
    else
        v246 = CFrame.new(Vector3.new(p242.x, v244.y, p242.z):lerp(p242, p241.cameraTranslationConstraints.y));
    end;
    if p241.cameraFrozen then
        if p241.inFirstPerson then
            p241:CancelCameraFreeze();
        end;
        if p241.humanoidJumpOrigin and p242.y < p241.humanoidJumpOrigin.y - 0.5 then
            p241:CancelCameraFreeze();
        end;
    end;
    return v246;
end;
function u15.GetRotateAmountValue(_, p248) --[[ Line: 1649 ]]
    -- upvalues: l__StarterGui__10 (copy), u1 (copy), u2 (copy), u3 (copy)
    local v249 = p248 or l__StarterGui__10:GetCore("VRRotationIntensity");
    if v249 then
        if v249 == "Low" then
            return u1;
        end;
        if v249 == "High" then
            return u2;
        end;
    end;
    return u3;
end;
function u15.GetRepeatDelayValue(_, p250) --[[ Line: 1661 ]]
    -- upvalues: l__StarterGui__10 (copy)
    local v251 = p250 or l__StarterGui__10:GetCore("VRRotationIntensity");
    if v251 then
        if v251 == "Low" then
            return 0.1;
        end;
        if v251 == "High" then
            return 0.4;
        end;
    end;
    return 0;
end;
function u15.Update(_, _) --[[ Line: 1673 ]]
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;
return u15;
