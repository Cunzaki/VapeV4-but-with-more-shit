-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local v2, v3 = pcall(function() --[[ Line: 19 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local u4 = v2 and v3;
local _, _ = pcall(function() --[[ Line: 26 ]]
    return UserSettings():IsUserFeatureEnabled("UserRemoveTheCameraApi");
end);
local v5, v6 = pcall(function() --[[ Line: 33 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor2");
end);
local u7 = v5 and v6;
local u8 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
};
local u9 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__UserGameSettings__4 = UserSettings():GetService("UserGameSettings");
local l__CameraUtils__5 = require(script:WaitForChild("CameraUtils"));
local l__CameraInput__6 = require(script:WaitForChild("CameraInput"));
local l__ClassicCamera__7 = require(script:WaitForChild("ClassicCamera"));
local l__OrbitalCamera__8 = require(script:WaitForChild("OrbitalCamera"));
local l__LegacyCamera__9 = require(script:WaitForChild("LegacyCamera"));
local l__Invisicam__10 = require(script:WaitForChild("Invisicam"));
local l__Poppercam__11 = require(script:WaitForChild("Poppercam"));
local l__TransparencyController__12 = require(script:WaitForChild("TransparencyController"));
local l__MouseLockController__13 = require(script:WaitForChild("MouseLockController"));
local u10 = {};
local u11 = {};
local l__PlayerScripts__14 = l__Players__1.LocalPlayer:WaitForChild("PlayerScripts");
l__PlayerScripts__14:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
l__PlayerScripts__14:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
l__PlayerScripts__14:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
l__PlayerScripts__14:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
l__PlayerScripts__14:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
l__PlayerScripts__14:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
if u4 then
    l__PlayerScripts__14:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
end;
function u1.new() --[[ Line: 112 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy), l__TransparencyController__12 (copy), l__MouseLockController__13 (copy), l__RunService__2 (copy), u8 (copy), u9 (copy), l__UserGameSettings__4 (copy), l__UserInputService__3 (copy)
    local u12 = setmetatable({}, u1);
    u12.activeCameraController = nil;
    u12.activeOcclusionModule = nil;
    u12.activeTransparencyController = nil;
    u12.activeMouseLockController = nil;
    u12.currentComputerCameraMovementMode = nil;
    u12.cameraSubjectChangedConn = nil;
    u12.cameraTypeChangedConn = nil;
    for _, v13 in pairs(l__Players__1:GetPlayers()) do
        u12:OnPlayerAdded(v13);
    end;
    l__Players__1.PlayerAdded:Connect(function(p14) --[[ Line: 133 ]]
        -- upvalues: u12 (copy)
        u12:OnPlayerAdded(p14);
    end);
    u12.activeTransparencyController = l__TransparencyController__12.new();
    u12.activeTransparencyController:Enable(true);
    u12.activeMouseLockController = l__MouseLockController__13.new();
    local v15 = u12.activeMouseLockController:GetBindableToggleEvent();
    if v15 then
        v15:Connect(function() --[[ Line: 144 ]]
            -- upvalues: u12 (copy)
            u12:OnMouseLockToggled();
        end);
    end;
    u12:ActivateCameraController(u12:GetCameraControlChoice());
    u12:ActivateOcclusionModule(l__Players__1.LocalPlayer.DevCameraOcclusionMode);
    u12:OnCurrentCameraChanged();
    l__RunService__2:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p16) --[[ Line: 153 ]]
        -- upvalues: u12 (copy)
        u12:Update(p16);
    end);
    for _, u17 in pairs(u8) do
        l__Players__1.LocalPlayer:GetPropertyChangedSignal(u17):Connect(function() --[[ Line: 157 ]]
            -- upvalues: u12 (copy), u17 (copy)
            u12:OnLocalPlayerCameraPropertyChanged(u17);
        end);
    end;
    for _, u18 in pairs(u9) do
        l__UserGameSettings__4:GetPropertyChangedSignal(u18):Connect(function() --[[ Line: 163 ]]
            -- upvalues: u12 (copy), u18 (copy)
            u12:OnUserGameSettingsPropertyChanged(u18);
        end);
    end;
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 167 ]]
        -- upvalues: u12 (copy)
        u12:OnCurrentCameraChanged();
    end);
    u12.lastInputType = l__UserInputService__3:GetLastInputType();
    l__UserInputService__3.LastInputTypeChanged:Connect(function(p19) --[[ Line: 172 ]]
        -- upvalues: u12 (copy)
        u12.lastInputType = p19;
    end);
    return u12;
end;
function u1.GetCameraMovementModeFromSettings(_) --[[ Line: 179 ]]
    -- upvalues: l__Players__1 (copy), l__CameraUtils__5 (copy), l__UserInputService__3 (copy), l__UserGameSettings__4 (copy)
    if l__Players__1.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return l__CameraUtils__5.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    else
        local v20, v21;
        if l__UserInputService__3.TouchEnabled then
            v20 = l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__Players__1.LocalPlayer.DevTouchCameraMode);
            v21 = l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__UserGameSettings__4.TouchCameraMovementMode);
        else
            v20 = l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__Players__1.LocalPlayer.DevComputerCameraMode);
            v21 = l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__UserGameSettings__4.ComputerCameraMovementMode);
        end;
        if v20 == Enum.DevComputerCameraMovementMode.UserChoice then
            return v21;
        else
            return v20;
        end;
    end;
end;
function u1.ActivateOcclusionModule(p22, p23) --[[ Line: 204 ]]
    -- upvalues: l__Poppercam__11 (copy), l__Invisicam__10 (copy), u11 (copy), l__Players__1 (copy)
    local v24;
    if p23 == Enum.DevCameraOcclusionMode.Zoom then
        v24 = l__Poppercam__11;
    else
        if p23 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");
            return;
        end;
        v24 = l__Invisicam__10;
    end;
    if p22.activeOcclusionModule and p22.activeOcclusionModule:GetOcclusionMode() == p23 then
        if not p22.activeOcclusionModule:GetEnabled() then
            p22.activeOcclusionModule:Enable(true);
        end;
    else
        local l__activeOcclusionModule__15 = p22.activeOcclusionModule;
        p22.activeOcclusionModule = u11[v24];
        if not p22.activeOcclusionModule then
            p22.activeOcclusionModule = v24.new();
            if p22.activeOcclusionModule then
                u11[v24] = p22.activeOcclusionModule;
            end;
        end;
        if p22.activeOcclusionModule then
            if p22.activeOcclusionModule:GetOcclusionMode() ~= p23 then
                warn("CameraScript ActivateOcclusionModule mismatch: ", p22.activeOcclusionModule:GetOcclusionMode(), "~=", p23);
            end;
            if l__activeOcclusionModule__15 then
                if l__activeOcclusionModule__15 == p22.activeOcclusionModule then
                    warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
                else
                    l__activeOcclusionModule__15:Enable(false);
                end;
            end;
            if p23 == Enum.DevCameraOcclusionMode.Invisicam then
                if l__Players__1.LocalPlayer.Character then
                    p22.activeOcclusionModule:CharacterAdded(l__Players__1.LocalPlayer.Character, l__Players__1.LocalPlayer);
                end;
            else
                for _, v25 in pairs(l__Players__1:GetPlayers()) do
                    if v25 and v25.Character then
                        p22.activeOcclusionModule:CharacterAdded(v25.Character, v25);
                    end;
                end;
                p22.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
            end;
            p22.activeOcclusionModule:Enable(true);
        end;
    end;
end;
function u1.ActivateCameraController(p26, p27, p28) --[[ Line: 283 ]]
    -- upvalues: l__LegacyCamera__9 (copy), u4 (ref), l__ClassicCamera__7 (copy), l__OrbitalCamera__8 (copy), u10 (copy)
    local v29 = nil;
    if p28 ~= nil then
        if p28 == Enum.CameraType.Scriptable then
            if p26.activeCameraController then
                p26.activeCameraController:Enable(false);
                p26.activeCameraController = nil;
                return;
            end;
        elseif p28 == Enum.CameraType.Custom then
            p27 = p26:GetCameraMovementModeFromSettings();
        elseif p28 == Enum.CameraType.Track then
            p27 = Enum.ComputerCameraMovementMode.Classic;
        elseif p28 == Enum.CameraType.Follow then
            p27 = Enum.ComputerCameraMovementMode.Follow;
        elseif p28 == Enum.CameraType.Orbital then
            p27 = Enum.ComputerCameraMovementMode.Orbital;
        elseif p28 == Enum.CameraType.Attach or (p28 == Enum.CameraType.Watch or p28 == Enum.CameraType.Fixed) then
            v29 = l__LegacyCamera__9;
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", p28);
        end;
    end;
    if not v29 then
        if p27 == Enum.ComputerCameraMovementMode.Classic or (p27 == Enum.ComputerCameraMovementMode.Follow or (p27 == Enum.ComputerCameraMovementMode.Default or u4 and p27 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v29 = l__ClassicCamera__7;
        else
            if p27 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.");
                return;
            end;
            v29 = l__OrbitalCamera__8;
        end;
    end;
    local v30;
    if u10[v29] then
        v30 = u10[v29];
    else
        v30 = v29.new();
        u10[v29] = v30;
    end;
    if p26.activeCameraController then
        if p26.activeCameraController == v30 then
            if not p26.activeCameraController:GetEnabled() then
                p26.activeCameraController:Enable(true);
            end;
        else
            p26.activeCameraController:Enable(false);
            p26.activeCameraController = v30;
            p26.activeCameraController:Enable(true);
        end;
    elseif v30 ~= nil then
        p26.activeCameraController = v30;
        p26.activeCameraController:Enable(true);
    end;
    if p26.activeCameraController then
        if p27 ~= nil then
            p26.activeCameraController:SetCameraMovementMode(p27);
            return;
        end;
        if p28 ~= nil then
            p26.activeCameraController:SetCameraType(p28);
        end;
    end;
end;
function u1.OnCameraSubjectChanged(p31) --[[ Line: 373 ]]
    if p31.activeTransparencyController then
        p31.activeTransparencyController:SetSubject(game.Workspace.CurrentCamera.CameraSubject);
    end;
    if p31.activeOcclusionModule then
        p31.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
    end;
end;
function u1.OnCameraTypeChanged(p32, p33) --[[ Line: 383 ]]
    -- upvalues: l__UserInputService__3 (copy)
    if p33 == Enum.CameraType.Scriptable and l__UserInputService__3.MouseBehavior == Enum.MouseBehavior.LockCenter then
        l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.Default;
    end;
    p32:ActivateCameraController(nil, p33);
end;
function u1.OnCurrentCameraChanged(u34) --[[ Line: 395 ]]
    local l__CurrentCamera__16 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__16 then
        if u34.cameraSubjectChangedConn then
            u34.cameraSubjectChangedConn:Disconnect();
        end;
        if u34.cameraTypeChangedConn then
            u34.cameraTypeChangedConn:Disconnect();
        end;
        u34.cameraSubjectChangedConn = l__CurrentCamera__16:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 407 ]]
            -- upvalues: u34 (copy), l__CurrentCamera__16 (copy)
            u34:OnCameraSubjectChanged(l__CurrentCamera__16.CameraSubject);
        end);
        u34.cameraTypeChangedConn = l__CurrentCamera__16:GetPropertyChangedSignal("CameraType"):Connect(function() --[[ Line: 411 ]]
            -- upvalues: u34 (copy), l__CurrentCamera__16 (copy)
            u34:OnCameraTypeChanged(l__CurrentCamera__16.CameraType);
        end);
        u34:OnCameraSubjectChanged(l__CurrentCamera__16.CameraSubject);
        u34:OnCameraTypeChanged(l__CurrentCamera__16.CameraType);
    end;
end;
function u1.OnLocalPlayerCameraPropertyChanged(p35, p36) --[[ Line: 419 ]]
    -- upvalues: l__Players__1 (copy), l__CameraUtils__5 (copy)
    if p36 == "CameraMode" then
        if l__Players__1.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if l__Players__1.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                local v37 = p35:GetCameraMovementModeFromSettings();
                p35:ActivateCameraController(l__CameraUtils__5.ConvertCameraModeEnumToStandard(v37));
                return;
            else
                warn("Unhandled value for property player.CameraMode: ", l__Players__1.LocalPlayer.CameraMode);
                return;
            end;
        end;
        if not p35.activeCameraController or p35.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p35:ActivateCameraController(l__CameraUtils__5.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic));
        end;
        if p35.activeCameraController then
            p35.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p36 == "DevComputerCameraMode" or p36 == "DevTouchCameraMode" then
            local v38 = p35:GetCameraMovementModeFromSettings();
            p35:ActivateCameraController(l__CameraUtils__5.ConvertCameraModeEnumToStandard(v38));
            return;
        end;
        if p36 == "DevCameraOcclusionMode" then
            p35:ActivateOcclusionModule(l__Players__1.LocalPlayer.DevCameraOcclusionMode);
            return;
        end;
        if p36 == "CameraMinZoomDistance" or p36 == "CameraMaxZoomDistance" then
            if p35.activeCameraController then
                p35.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p36 == "DevTouchMovementMode" then
                return;
            end;
            if p36 == "DevComputerMovementMode" then
                return;
            end;
            local _ = p36 == "DevEnableMouseLock";
        end;
    end;
end;
function u1.OnUserGameSettingsPropertyChanged(p39, p40) --[[ Line: 463 ]]
    -- upvalues: l__CameraUtils__5 (copy)
    if p40 == "ComputerCameraMovementMode" then
        local v41 = p39:GetCameraMovementModeFromSettings();
        p39:ActivateCameraController(l__CameraUtils__5.ConvertCameraModeEnumToStandard(v41));
    end;
end;
function u1.Update(p42, p43) --[[ Line: 476 ]]
    -- upvalues: u4 (ref), u7 (ref), l__CameraInput__6 (copy)
    if p42.activeCameraController then
        if u4 then
            p42.activeCameraController:UpdateMouseBehavior();
        end;
        local v44, v45 = p42.activeCameraController:Update(p43);
        p42.activeCameraController:ApplyVRTransform();
        if p42.activeOcclusionModule then
            v44, v45 = p42.activeOcclusionModule:Update(p43, v44, v45);
        end;
        game.Workspace.CurrentCamera.CFrame = v44;
        game.Workspace.CurrentCamera.Focus = v45;
        if p42.activeTransparencyController then
            p42.activeTransparencyController:Update();
        end;
        if u7 and l__CameraInput__6.getInputEnabled() then
            l__CameraInput__6.resetInputForFrameEnd();
        end;
    end;
end;
function u1.GetCameraControlChoice(p46) --[[ Line: 505 ]]
    -- upvalues: l__Players__1 (copy), l__UserInputService__3 (copy), l__CameraUtils__5 (copy), l__UserGameSettings__4 (copy)
    local l__LocalPlayer__17 = l__Players__1.LocalPlayer;
    if l__LocalPlayer__17 then
        if p46.lastInputType == Enum.UserInputType.Touch or l__UserInputService__3.TouchEnabled then
            if l__LocalPlayer__17.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
                return l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__UserGameSettings__4.TouchCameraMovementMode);
            else
                return l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__LocalPlayer__17.DevTouchCameraMode);
            end;
        else
            if l__LocalPlayer__17.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
                return l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__LocalPlayer__17.DevComputerCameraMode);
            end;
            local v47 = l__CameraUtils__5.ConvertCameraModeEnumToStandard(l__UserGameSettings__4.ComputerCameraMovementMode);
            return l__CameraUtils__5.ConvertCameraModeEnumToStandard(v47);
        end;
    end;
end;
function u1.OnCharacterAdded(p48, p49, p50) --[[ Line: 528 ]]
    if p48.activeOcclusionModule then
        p48.activeOcclusionModule:CharacterAdded(p49, p50);
    end;
end;
function u1.OnCharacterRemoving(p51, p52, p53) --[[ Line: 534 ]]
    if p51.activeOcclusionModule then
        p51.activeOcclusionModule:CharacterRemoving(p52, p53);
    end;
end;
function u1.OnPlayerAdded(u54, u55) --[[ Line: 540 ]]
    u55.CharacterAdded:Connect(function(p56) --[[ Line: 541 ]]
        -- upvalues: u54 (copy), u55 (copy)
        u54:OnCharacterAdded(p56, u55);
    end);
    u55.CharacterRemoving:Connect(function(p57) --[[ Line: 544 ]]
        -- upvalues: u54 (copy), u55 (copy)
        u54:OnCharacterRemoving(p57, u55);
    end);
end;
function u1.OnMouseLockToggled(p58) --[[ Line: 549 ]]
    if p58.activeMouseLockController then
        local v59 = p58.activeMouseLockController:GetIsMouseLocked();
        local v60 = p58.activeMouseLockController:GetMouseLockOffset();
        if p58.activeCameraController then
            p58.activeCameraController:SetIsMouseLocked(v59);
            p58.activeCameraController:SetMouseLockOffset(v60);
        end;
    end;
end;
return u1.new();