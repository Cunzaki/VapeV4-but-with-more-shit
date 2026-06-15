-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {
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
local u3 = {
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
local l__VRService__4 = game:GetService("VRService");
local l__UserGameSettings__5 = UserSettings():GetService("UserGameSettings");
local l__CommonUtils__6 = script.Parent:WaitForChild("CommonUtils");
local l__ConnectionUtil__7 = require(l__CommonUtils__6:WaitForChild("ConnectionUtil"));
local l__FlagUtil__8 = require(l__CommonUtils__6:WaitForChild("FlagUtil"));
local l__CameraUtils__9 = require(script:WaitForChild("CameraUtils"));
local l__CameraInput__10 = require(script:WaitForChild("CameraInput"));
local l__ClassicCamera__11 = require(script:WaitForChild("ClassicCamera"));
local l__OrbitalCamera__12 = require(script:WaitForChild("OrbitalCamera"));
local l__LegacyCamera__13 = require(script:WaitForChild("LegacyCamera"));
local l__VehicleCamera__14 = require(script:WaitForChild("VehicleCamera"));
local l__Invisicam__15 = require(script:WaitForChild("Invisicam"));
local l__Poppercam__16 = require(script:WaitForChild("Poppercam"));
local l__TransparencyController__17 = require(script:WaitForChild("TransparencyController"));
local l__MouseLockController__18 = require(script:WaitForChild("MouseLockController"));
local u4 = {};
local u5 = {};
if not l__Players__1.LocalPlayer then
    return {};
end;
assert(l__Players__1.LocalPlayer, "Strict typing check");
local l__PlayerScripts__19 = l__Players__1.LocalPlayer:WaitForChild("PlayerScripts");
l__PlayerScripts__19:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
l__PlayerScripts__19:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
l__PlayerScripts__19:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
l__PlayerScripts__19:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
l__PlayerScripts__19:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
l__PlayerScripts__19:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
l__PlayerScripts__19:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
local u6 = l__FlagUtil__8.getUserFlag("UserPlayerConnectionMemoryLeak");
local u7 = l__FlagUtil__8.getUserFlag("UserPSFixCameraControllerReset");
local u8 = l__FlagUtil__8.getUserFlag("UserCheckTouchControlMode");
function u1.new() --[[ Line: 142 ]]
    -- upvalues: l__TransparencyController__17 (copy), u6 (copy), l__ConnectionUtil__7 (copy), u1 (copy), l__Players__1 (copy), l__MouseLockController__18 (copy), l__RunService__2 (copy), u2 (copy), u3 (copy), l__UserGameSettings__5 (copy), l__UserInputService__3 (copy)
    local v9 = {
        activeTransparencyController = l__TransparencyController__17.new()
    };
    local v10;
    if u6 then
        v10 = l__ConnectionUtil__7.new();
    else
        v10 = nil;
    end;
    v9.connectionUtil = v10;
    local u11 = setmetatable(v9, u1);
    u11.activeCameraController = nil;
    u11.activeOcclusionModule = nil;
    u11.activeMouseLockController = nil;
    u11.currentComputerCameraMovementMode = nil;
    u11.cameraSubjectChangedConn = nil;
    u11.cameraTypeChangedConn = nil;
    for _, v12 in pairs(l__Players__1:GetPlayers()) do
        u11:OnPlayerAdded(v12);
    end;
    l__Players__1.PlayerAdded:Connect(function(p13) --[[ Line: 165 ]]
        -- upvalues: u11 (copy)
        u11:OnPlayerAdded(p13);
    end);
    if u6 then
        l__Players__1.PlayerRemoving:Connect(function(p14) --[[ Line: 170 ]]
            -- upvalues: u11 (copy)
            u11:OnPlayerRemoving(p14);
        end);
    end;
    u11.activeTransparencyController:Enable(true);
    u11.activeMouseLockController = l__MouseLockController__18.new();
    assert(u11.activeMouseLockController, "Strict typing check");
    local v15 = u11.activeMouseLockController:GetBindableToggleEvent();
    if v15 then
        v15:Connect(function() --[[ Line: 182 ]]
            -- upvalues: u11 (copy)
            u11:OnMouseLockToggled();
        end);
    end;
    u11:ActivateCameraController();
    u11:ActivateOcclusionModule(l__Players__1.LocalPlayer.DevCameraOcclusionMode);
    u11:OnCurrentCameraChanged();
    l__RunService__2:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p16) --[[ Line: 190 ]]
        -- upvalues: u11 (copy)
        u11:Update(p16);
    end);
    for _, u17 in pairs(u2) do
        l__Players__1.LocalPlayer:GetPropertyChangedSignal(u17):Connect(function() --[[ Line: 194 ]]
            -- upvalues: u11 (copy), u17 (copy)
            u11:OnLocalPlayerCameraPropertyChanged(u17);
        end);
    end;
    for _, u18 in pairs(u3) do
        l__UserGameSettings__5:GetPropertyChangedSignal(u18):Connect(function() --[[ Line: 200 ]]
            -- upvalues: u11 (copy), u18 (copy)
            u11:OnUserGameSettingsPropertyChanged(u18);
        end);
    end;
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 204 ]]
        -- upvalues: u11 (copy)
        u11:OnCurrentCameraChanged();
    end);
    l__UserInputService__3:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 207 ]]
        -- upvalues: u11 (copy)
        u11:OnPreferredInputChanged();
    end);
    return u11;
end;
function u1.GetCameraMovementModeFromSettings(_) --[[ Line: 214 ]]
    -- upvalues: l__Players__1 (copy), l__CameraUtils__9 (copy), l__UserInputService__3 (copy), l__UserGameSettings__5 (copy)
    if l__Players__1.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return l__CameraUtils__9.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    else
        local v19, v20;
        if l__UserInputService__3.PreferredInput == Enum.PreferredInput.Touch then
            v19 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__Players__1.LocalPlayer.DevTouchCameraMode);
            v20 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__UserGameSettings__5.TouchCameraMovementMode);
        else
            v19 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__Players__1.LocalPlayer.DevComputerCameraMode);
            v20 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__UserGameSettings__5.ComputerCameraMovementMode);
        end;
        if v19 == Enum.DevComputerCameraMovementMode.UserChoice then
            return v20;
        else
            return v19;
        end;
    end;
end;
function u1.ActivateOcclusionModule(p21, p22) --[[ Line: 239 ]]
    -- upvalues: l__Poppercam__16 (copy), l__Invisicam__15 (copy), u5 (copy), l__Players__1 (copy)
    local v23;
    if p22 == Enum.DevCameraOcclusionMode.Zoom then
        v23 = l__Poppercam__16;
    else
        if p22 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");
            return;
        end;
        v23 = l__Invisicam__15;
    end;
    p21.occlusionMode = p22;
    if p21.activeOcclusionModule and p21.activeOcclusionModule:GetOcclusionMode() == p22 then
        if not p21.activeOcclusionModule:GetEnabled() then
            p21.activeOcclusionModule:Enable(true);
        end;
    else
        local l__activeOcclusionModule__20 = p21.activeOcclusionModule;
        p21.activeOcclusionModule = u5[v23];
        if not p21.activeOcclusionModule then
            p21.activeOcclusionModule = v23.new();
            if p21.activeOcclusionModule then
                u5[v23] = p21.activeOcclusionModule;
            end;
        end;
        if p21.activeOcclusionModule then
            if p21.activeOcclusionModule:GetOcclusionMode() ~= p22 then
                warn("CameraScript ActivateOcclusionModule mismatch: ", p21.activeOcclusionModule:GetOcclusionMode(), "~=", p22);
            end;
            if l__activeOcclusionModule__20 then
                if l__activeOcclusionModule__20 == p21.activeOcclusionModule then
                    warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
                else
                    l__activeOcclusionModule__20:Enable(false);
                end;
            end;
            if p22 == Enum.DevCameraOcclusionMode.Invisicam then
                if l__Players__1.LocalPlayer.Character then
                    p21.activeOcclusionModule:CharacterAdded(l__Players__1.LocalPlayer.Character, l__Players__1.LocalPlayer);
                end;
            else
                for _, v24 in pairs(l__Players__1:GetPlayers()) do
                    if v24 and v24.Character then
                        p21.activeOcclusionModule:CharacterAdded(v24.Character, v24);
                    end;
                end;
                p21.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
            end;
            p21.activeOcclusionModule:Enable(true);
        end;
    end;
end;
function u1.ShouldUseVehicleCamera(p25) --[[ Line: 318 ]]
    local l__CurrentCamera__21 = workspace.CurrentCamera;
    if not l__CurrentCamera__21 then
        return false;
    end;
    local l__CameraType__22 = l__CurrentCamera__21.CameraType;
    local l__CameraSubject__23 = l__CurrentCamera__21.CameraSubject;
    local v26 = l__CameraType__22 == Enum.CameraType.Custom and true or l__CameraType__22 == Enum.CameraType.Follow;
    local v27 = l__CameraSubject__23 and l__CameraSubject__23:IsA("VehicleSeat") or false;
    local v28 = p25.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;
    if v27 then
        if not v26 then
            v28 = v26;
        end;
    else
        v28 = v27;
    end;
    return v28;
end;
function u1.ActivateCameraController(p29) --[[ Line: 334 ]]
    -- upvalues: l__LegacyCamera__13 (copy), l__VRService__4 (copy), l__ClassicCamera__11 (copy), l__OrbitalCamera__12 (copy), l__VehicleCamera__14 (copy), u4 (copy), u7 (copy)
    local l__CameraType__24 = workspace.CurrentCamera.CameraType;
    local v30 = p29:GetCameraMovementModeFromSettings();
    local v31 = nil;
    if l__CameraType__24 == Enum.CameraType.Scriptable then
        if p29.activeCameraController then
            p29.activeCameraController:Enable(false);
            p29.activeCameraController = nil;
        end;
    else
        if l__CameraType__24 == Enum.CameraType.Custom then
            v30 = p29:GetCameraMovementModeFromSettings();
        elseif l__CameraType__24 == Enum.CameraType.Track then
            v30 = Enum.ComputerCameraMovementMode.Classic;
        elseif l__CameraType__24 == Enum.CameraType.Follow then
            v30 = Enum.ComputerCameraMovementMode.Follow;
        elseif l__CameraType__24 == Enum.CameraType.Orbital then
            v30 = Enum.ComputerCameraMovementMode.Orbital;
        elseif l__CameraType__24 == Enum.CameraType.Attach or (l__CameraType__24 == Enum.CameraType.Watch or l__CameraType__24 == Enum.CameraType.Fixed) then
            v31 = l__LegacyCamera__13;
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", l__CameraType__24);
        end;
        if not (v31 or l__VRService__4.VREnabled) then
            if v30 == Enum.ComputerCameraMovementMode.Classic or (v30 == Enum.ComputerCameraMovementMode.Follow or (v30 == Enum.ComputerCameraMovementMode.Default or v30 == Enum.ComputerCameraMovementMode.CameraToggle)) then
                v31 = l__ClassicCamera__11;
            else
                if v30 ~= Enum.ComputerCameraMovementMode.Orbital then
                    warn("ActivateCameraController did not select a module.");
                    return;
                end;
                v31 = l__OrbitalCamera__12;
            end;
        end;
        if p29:ShouldUseVehicleCamera() and not l__VRService__4.VREnabled then
            v31 = l__VehicleCamera__14;
        end;
        local v32;
        if u4[v31] then
            v32 = u4[v31];
            if u7 then
                if v32.Reset and p29.activeCameraController ~= v32 then
                    v32:Reset();
                end;
            elseif v32.Reset then
                v32:Reset();
            end;
        else
            v32 = v31.new();
            u4[v31] = v32;
        end;
        if p29.activeCameraController then
            if p29.activeCameraController == v32 then
                if not p29.activeCameraController:GetEnabled() then
                    p29.activeCameraController:Enable(true);
                end;
            else
                p29.activeCameraController:Enable(false);
                p29.activeCameraController = v32;
                p29.activeCameraController:Enable(true);
            end;
        elseif v32 ~= nil then
            p29.activeCameraController = v32;
            assert(p29.activeCameraController, "Strict typing check");
            p29.activeCameraController:Enable(true);
        end;
        if p29.activeCameraController then
            p29.activeCameraController:SetCameraMovementMode(v30);
            p29.activeCameraController:SetCameraType(l__CameraType__24);
        end;
    end;
end;
function u1.OnCameraSubjectChanged(p33) --[[ Line: 438 ]]
    local l__CurrentCamera__25 = workspace.CurrentCamera;
    local v34;
    if l__CurrentCamera__25 then
        v34 = l__CurrentCamera__25.CameraSubject;
    else
        v34 = nil;
    end;
    if p33.activeTransparencyController then
        p33.activeTransparencyController:SetSubject(v34);
    end;
    if p33.activeOcclusionModule then
        p33.activeOcclusionModule:OnCameraSubjectChanged(v34);
    end;
    p33:ActivateCameraController();
end;
function u1.OnCameraTypeChanged(p35, p36) --[[ Line: 453 ]]
    -- upvalues: l__UserInputService__3 (copy), l__CameraUtils__9 (copy)
    if p36 == Enum.CameraType.Scriptable and l__UserInputService__3.MouseBehavior == Enum.MouseBehavior.LockCenter then
        l__CameraUtils__9.restoreMouseBehavior();
    end;
    p35:ActivateCameraController();
end;
function u1.OnCurrentCameraChanged(u37) --[[ Line: 465 ]]
    local l__CurrentCamera__26 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__26 then
        if u37.cameraSubjectChangedConn then
            u37.cameraSubjectChangedConn:Disconnect();
        end;
        if u37.cameraTypeChangedConn then
            u37.cameraTypeChangedConn:Disconnect();
        end;
        u37.cameraSubjectChangedConn = l__CurrentCamera__26:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 477 ]]
            -- upvalues: u37 (copy)
            u37:OnCameraSubjectChanged();
        end);
        u37.cameraTypeChangedConn = l__CurrentCamera__26:GetPropertyChangedSignal("CameraType"):Connect(function() --[[ Line: 481 ]]
            -- upvalues: u37 (copy), l__CurrentCamera__26 (copy)
            u37:OnCameraTypeChanged(l__CurrentCamera__26.CameraType);
        end);
        u37:OnCameraSubjectChanged();
        u37:OnCameraTypeChanged(l__CurrentCamera__26.CameraType);
    end;
end;
function u1.OnLocalPlayerCameraPropertyChanged(p38, p39) --[[ Line: 489 ]]
    -- upvalues: l__Players__1 (copy)
    if p39 == "CameraMode" then
        if l__Players__1.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if l__Players__1.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                p38:ActivateCameraController();
                return;
            else
                warn("Unhandled value for property player.CameraMode: ", l__Players__1.LocalPlayer.CameraMode);
                return;
            end;
        end;
        if not p38.activeCameraController or p38.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p38:ActivateCameraController();
        end;
        if p38.activeCameraController then
            p38.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p39 == "DevComputerCameraMode" or p39 == "DevTouchCameraMode" then
            p38:ActivateCameraController();
            return;
        end;
        if p39 == "DevCameraOcclusionMode" then
            p38:ActivateOcclusionModule(l__Players__1.LocalPlayer.DevCameraOcclusionMode);
            return;
        end;
        if p39 == "CameraMinZoomDistance" or p39 == "CameraMaxZoomDistance" then
            if p38.activeCameraController then
                p38.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p39 == "DevTouchMovementMode" then
                return;
            end;
            if p39 == "DevComputerMovementMode" then
                return;
            end;
            local _ = p39 == "DevEnableMouseLock";
        end;
    end;
end;
function u1.OnUserGameSettingsPropertyChanged(p40, p41) --[[ Line: 531 ]]
    -- upvalues: u8 (copy)
    if p41 == "ComputerCameraMovementMode" or u8 and p41 == "TouchCameraMovementMode" then
        p40:ActivateCameraController();
    end;
end;
function u1.OnPreferredInputChanged(p42) --[[ Line: 537 ]]
    p42:ActivateCameraController();
end;
function u1.Update(p43, p44) --[[ Line: 547 ]]
    -- upvalues: l__CameraInput__10 (copy)
    if p43.activeCameraController then
        p43.activeCameraController:UpdateMouseBehavior();
        local v45, v46 = p43.activeCameraController:Update(p44);
        if p43.activeOcclusionModule then
            v45, v46 = p43.activeOcclusionModule:Update(p44, v45, v46);
        end;
        local l__CurrentCamera__27 = game.Workspace.CurrentCamera;
        l__CurrentCamera__27.CFrame = v45;
        l__CurrentCamera__27.Focus = v46;
        if p43.activeTransparencyController then
            p43.activeTransparencyController:Update(p44);
        end;
        if l__CameraInput__10.getInputEnabled() then
            l__CameraInput__10.resetInputForFrameEnd();
        end;
    end;
end;
function u1.OnCharacterAdded(p47, p48, p49) --[[ Line: 573 ]]
    if p47.activeOcclusionModule then
        p47.activeOcclusionModule:CharacterAdded(p48, p49);
    end;
end;
function u1.OnCharacterRemoving(p50, p51, p52) --[[ Line: 579 ]]
    if p50.activeOcclusionModule then
        p50.activeOcclusionModule:CharacterRemoving(p51, p52);
    end;
end;
function u1.OnPlayerAdded(u53, u54) --[[ Line: 585 ]]
    -- upvalues: u6 (copy)
    if u6 then
        if u53.connectionUtil then
            u53.connectionUtil:trackConnection(`{u54.UserId}CharacterAdded`, u54.CharacterAdded:Connect(function(p55) --[[ Line: 589 ]]
                -- upvalues: u53 (copy), u54 (copy)
                u53:OnCharacterAdded(p55, u54);
            end));
            u53.connectionUtil:trackConnection(`{u54.UserId}CharacterRemoving`, u54.CharacterRemoving:Connect(function(p56) --[[ Line: 592 ]]
                -- upvalues: u53 (copy), u54 (copy)
                u53:OnCharacterRemoving(p56, u54);
            end));
        end;
    else
        u54.CharacterAdded:Connect(function(p57) --[[ Line: 597 ]]
            -- upvalues: u53 (copy), u54 (copy)
            u53:OnCharacterAdded(p57, u54);
        end);
        u54.CharacterRemoving:Connect(function(p58) --[[ Line: 600 ]]
            -- upvalues: u53 (copy), u54 (copy)
            u53:OnCharacterRemoving(p58, u54);
        end);
    end;
end;
function u1.OnPlayerRemoving(p59, p60) --[[ Line: 606 ]]
    if p59.connectionUtil then
        p59.connectionUtil:disconnect((`{p60.UserId}CharacterAdded`));
        p59.connectionUtil:disconnect((`{p60.UserId}CharacterRemoving`));
    end;
end;
function u1.OnMouseLockToggled(p61) --[[ Line: 614 ]]
    if p61.activeMouseLockController then
        local v62 = p61.activeMouseLockController:GetIsMouseLocked();
        local v63 = p61.activeMouseLockController:GetMouseLockOffset();
        if p61.activeCameraController then
            p61.activeCameraController:SetIsMouseLocked(v62);
            p61.activeCameraController:SetMouseLockOffset(v63);
        end;
    end;
end;
u1.new();
return {};