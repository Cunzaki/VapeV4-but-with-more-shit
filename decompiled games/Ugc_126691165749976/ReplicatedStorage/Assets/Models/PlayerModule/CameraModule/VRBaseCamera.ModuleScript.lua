-- Decompiled from: ReplicatedStorage.Assets.Models.PlayerModule.CameraModule.VRBaseCamera
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local v1, v2 = pcall(function() --[[ Line: 17 ]]
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2");
end);
local u3 = v1 and v2;
local l__VRService__1 = game:GetService("VRService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Lighting__3 = game:GetService("Lighting");
local l__RunService__4 = game:GetService("RunService");
local l__UserGameSettings__5 = UserSettings():GetService("UserGameSettings");
local l__CameraInput__6 = require(script.Parent:WaitForChild("CameraInput"));
local l__ZoomController__7 = require(script.Parent:WaitForChild("ZoomController"));
local l__CommonUtils__8 = script.Parent.Parent:WaitForChild("CommonUtils");
local u4 = require(l__CommonUtils__8:WaitForChild("FlagUtil")).getUserFlag("UserCameraInputDt");
local l__BaseCamera__9 = require(script.Parent:WaitForChild("BaseCamera"));
local u5 = setmetatable({}, l__BaseCamera__9);
u5.__index = u5;
function u5.new() --[[ Line: 41 ]]
    -- upvalues: l__BaseCamera__9 (copy), u5 (copy)
    local v6 = l__BaseCamera__9.new();
    local v7 = setmetatable(v6, u5);
    v7.gamepadZoomLevels = { 0, 7 };
    v7.headScale = 1;
    v7:SetCameraToSubjectDistance(7);
    v7.VRFadeResetTimer = 0;
    v7.VREdgeBlurTimer = 0;
    v7.gamepadResetConnection = nil;
    v7.needsReset = true;
    v7.recentered = false;
    v7:Reset();
    return v7;
end;
function u5.Reset(p8) --[[ Line: 67 ]]
    p8.stepRotateTimeout = 0;
end;
function u5.GetModuleName(_) --[[ Line: 71 ]]
    return "VRBaseCamera";
end;
function u5.GamepadZoomPress(p9) --[[ Line: 75 ]]
    -- upvalues: l__BaseCamera__9 (copy)
    l__BaseCamera__9.GamepadZoomPress(p9);
    p9:GamepadReset();
    p9:ResetZoom();
end;
function u5.GamepadReset(p10) --[[ Line: 83 ]]
    p10.stepRotateTimeout = 0;
    p10.needsReset = true;
end;
function u5.ResetZoom(p11) --[[ Line: 88 ]]
    -- upvalues: l__ZoomController__7 (copy)
    l__ZoomController__7.SetZoomParameters(p11.currentSubjectDistance, 0);
    l__ZoomController__7.ReleaseSpring();
end;
function u5.OnEnabledChanged(u12) --[[ Line: 93 ]]
    -- upvalues: l__BaseCamera__9 (copy), l__CameraInput__6 (copy), l__VRService__1 (copy), u3 (ref), l__LocalPlayer__2 (copy), l__Lighting__3 (copy)
    l__BaseCamera__9.OnEnabledChanged(u12);
    if u12.enabled then
        u12.gamepadResetConnection = l__CameraInput__6.gamepadReset:Connect(function() --[[ Line: 97 ]]
            -- upvalues: u12 (copy)
            u12:GamepadReset();
        end);
        u12.thirdPersonOptionChanged = l__VRService__1:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function() --[[ Line: 102 ]]
            -- upvalues: u3 (ref), u12 (copy)
            if u3 then
                u12:Reset();
            else
                if not u12:IsInFirstPerson() then
                    u12:Reset();
                end;
            end;
        end);
        u12.vrRecentered = l__VRService__1.UserCFrameChanged:Connect(function(p13, _) --[[ Line: 113 ]]
            -- upvalues: u12 (copy)
            if p13 == Enum.UserCFrame.Floor then
                u12.recentered = true;
            end;
        end);
    else
        if u12.inFirstPerson then
            u12:GamepadZoomPress();
        end;
        if u12.thirdPersonOptionChanged then
            u12.thirdPersonOptionChanged:Disconnect();
            u12.thirdPersonOptionChanged = nil;
        end;
        if u12.vrRecentered then
            u12.vrRecentered:Disconnect();
            u12.vrRecentered = nil;
        end;
        if u12.cameraHeadScaleChangedConn then
            u12.cameraHeadScaleChangedConn:Disconnect();
            u12.cameraHeadScaleChangedConn = nil;
        end;
        if u12.gamepadResetConnection then
            u12.gamepadResetConnection:Disconnect();
            u12.gamepadResetConnection = nil;
        end;
        u12.VREdgeBlurTimer = 0;
        u12:UpdateEdgeBlur(l__LocalPlayer__2, 1);
        local v14 = l__Lighting__3:FindFirstChild("VRFade");
        if v14 then
            v14.Brightness = 0;
        end;
    end;
end;
function u5.OnCurrentCameraChanged(u15) --[[ Line: 155 ]]
    -- upvalues: l__BaseCamera__9 (copy)
    l__BaseCamera__9.OnCurrentCameraChanged(u15);
    if u15.cameraHeadScaleChangedConn then
        u15.cameraHeadScaleChangedConn:Disconnect();
        u15.cameraHeadScaleChangedConn = nil;
    end;
    local l__CurrentCamera__10 = workspace.CurrentCamera;
    if l__CurrentCamera__10 then
        u15.cameraHeadScaleChangedConn = l__CurrentCamera__10:GetPropertyChangedSignal("HeadScale"):Connect(function() --[[ Line: 167 ]]
            -- upvalues: u15 (copy)
            u15:OnHeadScaleChanged();
        end);
        u15:OnHeadScaleChanged();
    end;
end;
function u5.OnHeadScaleChanged(p16) --[[ Line: 172 ]]
    local l__HeadScale__11 = workspace.CurrentCamera.HeadScale;
    for v17, v18 in p16.gamepadZoomLevels do
        p16.gamepadZoomLevels[v17] = v18 * l__HeadScale__11 / p16.headScale;
    end;
    p16:SetCameraToSubjectDistance(p16:GetCameraToSubjectDistance() * l__HeadScale__11 / p16.headScale);
    p16.headScale = l__HeadScale__11;
end;
function u5.GetVRFocus(p19, p20, p21) --[[ Line: 188 ]]
    local v22 = p19.lastCameraFocus or p20;
    local l__x__12 = p19.cameraTranslationConstraints.x;
    local v23 = math.min(1, p19.cameraTranslationConstraints.y + p21);
    p19.cameraTranslationConstraints = Vector3.new(l__x__12, v23, p19.cameraTranslationConstraints.z);
    local v24 = p19:GetCameraHeight();
    local v25 = Vector3.new(0, v24, 0);
    return CFrame.new(Vector3.new(p20.x, v22.y, p20.z):Lerp(p20 + v25, p19.cameraTranslationConstraints.y));
end;
function u5.StartFadeFromBlack(p26) --[[ Line: 204 ]]
    -- upvalues: l__UserGameSettings__5 (copy), l__Lighting__3 (copy)
    if l__UserGameSettings__5.VignetteEnabled == false then
    else
        local v27 = l__Lighting__3:FindFirstChild("VRFade");
        if not v27 then
            v27 = Instance.new("ColorCorrectionEffect");
            v27.Name = "VRFade";
            v27.Parent = l__Lighting__3;
        end;
        v27.Brightness = -1;
        p26.VRFadeResetTimer = 0.1;
    end;
end;
function u5.UpdateFadeFromBlack(p28, p29) --[[ Line: 219 ]]
    -- upvalues: l__Lighting__3 (copy)
    local v30 = l__Lighting__3:FindFirstChild("VRFade");
    if p28.VRFadeResetTimer > 0 then
        p28.VRFadeResetTimer = math.max(p28.VRFadeResetTimer - p29, 0);
        local v31 = l__Lighting__3:FindFirstChild("VRFade");
        if v31 and v31.Brightness < 0 then
            v31.Brightness = math.min(v31.Brightness + p29 * 10, 0);
        end;
    elseif v30 then
        v30.Brightness = 0;
    end;
end;
function u5.StartVREdgeBlur(p32, p33) --[[ Line: 235 ]]
    -- upvalues: l__UserGameSettings__5 (copy), l__RunService__4 (copy), l__VRService__1 (copy)
    if l__UserGameSettings__5.VignetteEnabled == false then
    else
        local v34 = workspace.CurrentCamera:FindFirstChild("VRBlurPart");
        if not v34 then
            local u35 = Instance.new("Part");
            u35.Name = "VRBlurPart";
            u35.Parent = workspace.CurrentCamera;
            u35.CanTouch = false;
            u35.CanCollide = false;
            u35.CanQuery = false;
            u35.Anchored = true;
            u35.Size = Vector3.new(0.44, 0.47, 1);
            u35.Transparency = 1;
            u35.CastShadow = false;
            l__RunService__4.RenderStepped:Connect(function(_) --[[ Line: 255 ]]
                -- upvalues: l__VRService__1 (ref), u35 (ref)
                local v36 = l__VRService__1:GetUserCFrame(Enum.UserCFrame.Head);
                local v37 = workspace.CurrentCamera.CFrame * (CFrame.new(v36.p * workspace.CurrentCamera.HeadScale) * (v36 - v36.p));
                u35.CFrame = v37 * CFrame.Angles(0, 3.141592653589793, 0) + v37.LookVector * (1.05 * workspace.CurrentCamera.HeadScale);
                u35.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale;
            end);
            v34 = u35;
        end;
        local v38 = p33.PlayerGui:FindFirstChild("VRBlurScreen");
        local v39;
        if v38 then
            v39 = v38:FindFirstChild("VRBlur");
        else
            v39 = nil;
        end;
        if not v39 then
            local v40 = v38 or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"));
            v40.Name = "VRBlurScreen";
            v40.Parent = p33.PlayerGui;
            v40.Adornee = v34;
            v39 = Instance.new("ImageLabel");
            v39.Name = "VRBlur";
            v39.Parent = v40;
            v39.Image = "rbxasset://textures/ui/VR/edgeBlur.png";
            v39.AnchorPoint = Vector2.new(0.5, 0.5);
            v39.Position = UDim2.new(0.5, 0, 0.5, 0);
            v39.Size = UDim2.fromScale(workspace.CurrentCamera.ViewportSize.X * 2.3 / 512, workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512);
            v39.BackgroundTransparency = 1;
            v39.Active = true;
            v39.ScaleType = Enum.ScaleType.Stretch;
        end;
        v39.Visible = true;
        v39.ImageTransparency = 0;
        p32.VREdgeBlurTimer = 0.14;
    end;
end;
function u5.UpdateEdgeBlur(p41, p42, p43) --[[ Line: 304 ]]
    local v44 = p42.PlayerGui:FindFirstChild("VRBlurScreen");
    local v45;
    if v44 then
        v45 = v44:FindFirstChild("VRBlur");
    else
        v45 = nil;
    end;
    if v45 then
        if p41.VREdgeBlurTimer > 0 then
            p41.VREdgeBlurTimer = p41.VREdgeBlurTimer - p43;
            local v46 = p42.PlayerGui:FindFirstChild("VRBlurScreen");
            local v47 = v46 and v46:FindFirstChild("VRBlur");
            if v47 then
                v47.ImageTransparency = 1 - math.clamp(p41.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142;
            end;
        else
            v45.Visible = false;
        end;
    end;
end;
function u5.GetCameraHeight(p48) --[[ Line: 329 ]]
    return p48.inFirstPerson and 0 or 0.25881904510252074 * p48.currentSubjectDistance;
end;
function u5.GetSubjectCFrame(p49) --[[ Line: 336 ]]
    -- upvalues: l__BaseCamera__9 (copy)
    local v50 = l__BaseCamera__9.GetSubjectCFrame(p49);
    local l__CurrentCamera__13 = workspace.CurrentCamera;
    if l__CurrentCamera__13 then
        l__CurrentCamera__13 = l__CurrentCamera__13.CameraSubject;
    end;
    if not l__CurrentCamera__13 then
        return v50;
    end;
    if l__CurrentCamera__13:IsA("Humanoid") and (l__CurrentCamera__13:GetState() == Enum.HumanoidStateType.Dead and l__CurrentCamera__13 == p49.lastSubject) then
        v50 = p49.lastSubjectCFrame;
    end;
    if v50 then
        p49.lastSubjectCFrame = v50;
    end;
    return v50;
end;
function u5.GetSubjectPosition(p51) --[[ Line: 362 ]]
    -- upvalues: l__BaseCamera__9 (copy)
    local v52 = l__BaseCamera__9.GetSubjectPosition(p51);
    local l__CurrentCamera__14 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__14 then
        l__CurrentCamera__14 = l__CurrentCamera__14.CameraSubject;
    end;
    if not l__CurrentCamera__14 then
        return nil;
    end;
    if l__CurrentCamera__14:IsA("Humanoid") then
        if l__CurrentCamera__14:GetState() == Enum.HumanoidStateType.Dead and l__CurrentCamera__14 == p51.lastSubject then
            v52 = p51.lastSubjectPosition;
        end;
    elseif l__CurrentCamera__14:IsA("VehicleSeat") then
        v52 = l__CurrentCamera__14.CFrame.p + l__CurrentCamera__14.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0));
    end;
    p51.lastSubjectPosition = v52;
    return v52;
end;
function u5.getRotation(p53, p54) --[[ Line: 391 ]]
    -- upvalues: l__CameraInput__6 (copy), l__UserGameSettings__5 (copy), u4 (copy)
    local v55 = l__CameraInput__6.getRotation(p54);
    local v56 = 0;
    if l__UserGameSettings__5.VRSmoothRotationEnabled then
        if u4 then
            return v55.X;
        else
            return v55.X * 40 * p54;
        end;
    else
        if math.abs(v55.X) > 0.03 then
            if p53.stepRotateTimeout > 0 then
                p53.stepRotateTimeout = p53.stepRotateTimeout - p54;
            end;
            if p53.stepRotateTimeout <= 0 then
                local v57 = (v55.X < 0 and -1 or 1) * 0.5235987755982988;
                p53:StartFadeFromBlack();
                p53.stepRotateTimeout = 0.25;
                return v57;
            end;
        elseif math.abs(v55.X) < 0.02 then
            p53.stepRotateTimeout = 0;
        end;
        return v56;
    end;
end;
return u5;
