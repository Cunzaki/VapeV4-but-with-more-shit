-- Decompiled with Potassium's decompiler.

local u1 = Vector2.new(0, 0);
local u2 = 0;
local u3 = CFrame.fromOrientation(-0.2617993877991494, 0, 0);
local v4, v5 = pcall(function() --[[ Line: 21 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local u6 = v4 and v5;
local v7, v8 = pcall(function() --[[ Line: 28 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor2");
end);
local u9 = v7 and v8;
local l__Players__1 = game:GetService("Players");
local l__VRService__2 = game:GetService("VRService");
local l__CameraInput__3 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUtils__4 = require(script.Parent:WaitForChild("CameraUtils"));
local l__BaseCamera__5 = require(script.Parent:WaitForChild("BaseCamera"));
local u10 = setmetatable({}, l__BaseCamera__5);
u10.__index = u10;
function u10.new() --[[ Line: 46 ]]
    -- upvalues: l__BaseCamera__5 (copy), u10 (copy), l__CameraUtils__4 (copy)
    local v11 = l__BaseCamera__5.new();
    local v12 = setmetatable(v11, u10);
    v12.isFollowCamera = false;
    v12.isCameraToggle = false;
    v12.lastUpdate = tick();
    v12.cameraToggleSpring = l__CameraUtils__4.Spring.new(5, 0);
    return v12;
end;
function u10.GetCameraToggleOffset(p13, p14) --[[ Line: 57 ]]
    -- upvalues: u6 (ref), l__CameraInput__3 (copy), l__CameraUtils__4 (copy)
    assert(u6);
    if not p13.isCameraToggle then
        return Vector3.new();
    end;
    local l__currentSubjectDistance__6 = p13.currentSubjectDistance;
    if l__CameraInput__3.getTogglePan() then
        local l__cameraToggleSpring__7 = p13.cameraToggleSpring;
        local v15 = l__CameraUtils__4.map(l__currentSubjectDistance__6, 0.5, p13.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1);
        l__cameraToggleSpring__7.goal = math.clamp(v15, 0, 1);
    else
        p13.cameraToggleSpring.goal = 0;
    end;
    local v16 = l__CameraUtils__4.map(l__currentSubjectDistance__6, 0.5, 64, 0, 1);
    local v17 = math.clamp(v16, 0, 1) + 1;
    local v18 = p13.cameraToggleSpring:step(p14) * v17;
    return Vector3.new(0, v18, 0);
end;
function u10.SetCameraMovementMode(p19, p20) --[[ Line: 77 ]]
    -- upvalues: l__BaseCamera__5 (copy)
    l__BaseCamera__5.SetCameraMovementMode(p19, p20);
    p19.isFollowCamera = p20 == Enum.ComputerCameraMovementMode.Follow;
    p19.isCameraToggle = p20 == Enum.ComputerCameraMovementMode.CameraToggle;
end;
function u10.Update(p21) --[[ Line: 84 ]]
    -- upvalues: u3 (copy), l__Players__1 (copy), u9 (ref), l__CameraInput__3 (copy), u1 (copy), u2 (ref), l__CameraUtils__4 (copy), l__VRService__2 (copy), u6 (ref)
    local v22 = tick();
    local v23 = v22 - p21.lastUpdate;
    local l__CurrentCamera__8 = workspace.CurrentCamera;
    local l__CFrame__9 = l__CurrentCamera__8.CFrame;
    local l__Focus__10 = l__CurrentCamera__8.Focus;
    local v24;
    if p21.resetCameraAngle then
        local v25 = p21:GetHumanoidRootPart();
        if v25 then
            v24 = (v25.CFrame * u3).lookVector;
        else
            v24 = u3.lookVector;
        end;
        p21.resetCameraAngle = false;
    else
        v24 = nil;
    end;
    local l__LocalPlayer__11 = l__Players__1.LocalPlayer;
    local v26 = p21:GetHumanoid();
    local l__CameraSubject__12 = l__CurrentCamera__8.CameraSubject;
    local v27;
    if l__CameraSubject__12 then
        v27 = l__CameraSubject__12:IsA("VehicleSeat");
    else
        v27 = l__CameraSubject__12;
    end;
    local v28;
    if l__CameraSubject__12 then
        v28 = l__CameraSubject__12:IsA("SkateboardPlatform");
    else
        v28 = l__CameraSubject__12;
    end;
    local v29;
    if v26 then
        v29 = v26:GetState() == Enum.HumanoidStateType.Climbing;
    else
        v29 = v26;
    end;
    if p21.lastUpdate == nil or v23 > 1 then
        p21.lastCameraTransform = nil;
    end;
    local v30;
    if u9 then
        v30 = l__CameraInput__3.getRotation();
    else
        v30 = p21.rotateInput;
    end;
    if u9 then
        local l__currentSubjectDistance__13 = p21.currentSubjectDistance;
        local v31 = l__CameraInput__3.getZoomDelta();
        if math.abs(v31) > 0 then
            local v32;
            if p21.inFirstPerson and v31 < 0 then
                v32 = 0.5;
            elseif v31 > 0 then
                v32 = l__currentSubjectDistance__13 + v31 * (1 + l__currentSubjectDistance__13 * 0.5);
            else
                v32 = (l__currentSubjectDistance__13 + v31) / (1 - v31 * 0.5);
            end;
            p21:SetCameraToSubjectDistance(v32);
        end;
    end;
    if p21.lastUpdate and not u9 then
        local v33 = p21:UpdateGamepad();
        if p21:ShouldUseVRRotation() then
            p21.rotateInput = p21.rotateInput + p21:GetVRRotationInput();
        else
            local v34 = math.min(0.1, v23);
            if v33 ~= u1 then
                p21.rotateInput = p21.rotateInput + v33 * v34;
            end;
            local v35 = 0;
            if not (v27 or v28) then
                v35 = v35 + (p21.turningLeft and -120 or 0) + (p21.turningRight and 120 or 0);
            end;
            if v35 ~= 0 then
                p21.rotateInput = p21.rotateInput + Vector2.new(math.rad(v35 * v34), 0);
            end;
        end;
    end;
    local v36 = p21:GetCameraHeight();
    if u9 then
        if l__CameraInput__3.getRotation() ~= Vector2.new() then
            u2 = 0;
            p21.lastUserPanCamera = tick();
        end;
    elseif p21.userPanningTheCamera then
        u2 = 0;
        p21.lastUserPanCamera = tick();
    end;
    local v37 = v22 - p21.lastUserPanCamera < 2;
    local v38 = p21:GetSubjectPosition();
    if v38 and (l__LocalPlayer__11 and l__CurrentCamera__8) then
        local v39 = p21:GetCameraToSubjectDistance();
        local v40 = v39 < 0.5 and 0.5 or v39;
        if p21:GetIsMouseLocked() and not p21:IsInFirstPerson() then
            local v41;
            if u9 then
                v41 = p21:CalculateNewLookCFrameFromArg(v24, v30);
            else
                v41 = p21:CalculateNewLookCFrame(v24);
            end;
            local v42 = p21:GetMouseLockOffset();
            local v43 = v42.X * v41.rightVector + v42.Y * v41.upVector + v42.Z * v41.lookVector;
            if l__CameraUtils__4.IsFiniteVector3(v43) then
                v38 = v38 + v43;
            end;
        else
            local v44;
            if u9 then
                v44 = l__CameraInput__3.getRotation() ~= Vector2.new();
            else
                v44 = p21.userPanningTheCamera == true;
            end;
            if not v44 and p21.lastCameraTransform then
                local v45 = p21:IsInFirstPerson();
                if (v27 or (v28 or p21.isFollowCamera and v29)) and (p21.lastUpdate and (v26 and v26.Torso)) then
                    if v45 then
                        if p21.lastSubjectCFrame and (v27 or v28) and l__CameraSubject__12:IsA("BasePart") then
                            local v46 = -l__CameraUtils__4.GetAngleBetweenXZVectors(p21.lastSubjectCFrame.lookVector, l__CameraSubject__12.CFrame.lookVector);
                            if l__CameraUtils__4.IsFinite(v46) then
                                if u9 then
                                    v30 = v30 + Vector2.new(v46, 0);
                                else
                                    p21.rotateInput = p21.rotateInput + Vector2.new(v46, 0);
                                end;
                            end;
                            u2 = 0;
                        end;
                    elseif not v37 then
                        local l__lookVector__14 = v26.Torso.CFrame.lookVector;
                        if v28 and not u9 then
                            l__lookVector__14 = l__CameraSubject__12.CFrame.lookVector;
                        end;
                        u2 = math.clamp(u2 + 3.839724354387525 * v23, 0, 4.363323129985824);
                        local v47 = math.clamp(u2 * v23, 0, 1);
                        local v48 = p21:IsInFirstPerson() and not (p21.isFollowCamera and p21.isClimbing) and 1 or v47;
                        local v49 = l__CameraUtils__4.GetAngleBetweenXZVectors(l__lookVector__14, p21:GetCameraLookVector());
                        if l__CameraUtils__4.IsFinite(v49) and math.abs(v49) > 0.0001 then
                            if u9 then
                                v30 = v30 + Vector2.new(v49 * v48, 0);
                            else
                                p21.rotateInput = p21.rotateInput + Vector2.new(v49 * v48, 0);
                            end;
                        end;
                    end;
                elseif p21.isFollowCamera and not (v45 or (v37 or l__VRService__2.VREnabled)) then
                    local v50 = l__CameraUtils__4.GetAngleBetweenXZVectors(-(p21.lastCameraTransform.p - v38), p21:GetCameraLookVector());
                    if l__CameraUtils__4.IsFinite(v50) and (math.abs(v50) > 0.0001 and math.abs(v50) > 0.4 * v23) then
                        v30 = v30 + Vector2.new(v50, 0);
                    end;
                end;
            end;
        end;
        if p21.isFollowCamera then
            local v51;
            if u9 then
                v51 = p21:CalculateNewLookVectorFromArg(v24, v30);
            else
                v51 = p21:CalculateNewLookVector(v24);
                p21.rotateInput = u1;
            end;
            if l__VRService__2.VREnabled then
                l__Focus__10 = p21:GetVRFocus(v38, v23);
            else
                l__Focus__10 = CFrame.new(v38);
            end;
            l__CFrame__9 = CFrame.new(l__Focus__10.p - v40 * v51, l__Focus__10.p) + Vector3.new(0, v36, 0);
        else
            local l__VREnabled__15 = l__VRService__2.VREnabled;
            if l__VREnabled__15 then
                l__Focus__10 = p21:GetVRFocus(v38, v23);
            else
                l__Focus__10 = CFrame.new(v38);
            end;
            local l__p__16 = l__Focus__10.p;
            if l__VREnabled__15 and not p21:IsInFirstPerson() then
                local l__magnitude__17 = (v38 - l__CurrentCamera__8.CFrame.p).magnitude;
                local v52;
                if u9 then
                    v52 = v30;
                else
                    v52 = p21.rotateInput;
                end;
                if v40 < l__magnitude__17 or v52.x ~= 0 then
                    local v53 = math.min(l__magnitude__17, v40);
                    local v54;
                    if u9 then
                        v54 = p21:CalculateNewLookFromArg(nil, v30) * v53;
                    else
                        v54 = p21:CalculateNewLookVector() * v53;
                    end;
                    local v55 = l__p__16 - v54;
                    local l__lookVector__18 = l__CurrentCamera__8.CFrame.lookVector;
                    if v52.x == 0 then
                        v54 = l__lookVector__18;
                    end;
                    local v56 = Vector3.new(v55.x + v54.x, v55.y, v55.z + v54.z);
                    if not u9 then
                        p21.rotateInput = u1;
                    end;
                    l__CFrame__9 = CFrame.new(v55, v56) + Vector3.new(0, v36, 0);
                end;
            else
                local v57;
                if u9 then
                    v57 = p21:CalculateNewLookVectorFromArg(v24, v30);
                else
                    v57 = p21:CalculateNewLookVector(v24);
                    p21.rotateInput = u1;
                end;
                l__CFrame__9 = CFrame.new(l__p__16 - v40 * v57, l__p__16);
            end;
        end;
        if u6 then
            local v58 = p21:GetCameraToggleOffset(v23);
            l__Focus__10 = l__Focus__10 + v58;
            l__CFrame__9 = l__CFrame__9 + v58;
        end;
        p21.lastCameraTransform = l__CFrame__9;
        p21.lastCameraFocus = l__Focus__10;
        if (v27 or v28) and l__CameraSubject__12:IsA("BasePart") then
            p21.lastSubjectCFrame = l__CameraSubject__12.CFrame;
        else
            p21.lastSubjectCFrame = nil;
        end;
    end;
    p21.lastUpdate = v22;
    return l__CFrame__9, l__Focus__10;
end;
function u10.EnterFirstPerson(p59) --[[ Line: 361 ]]
    p59.inFirstPerson = true;
    p59:UpdateMouseBehavior();
end;
function u10.LeaveFirstPerson(p60) --[[ Line: 366 ]]
    p60.inFirstPerson = false;
    p60:UpdateMouseBehavior();
end;
return u10;