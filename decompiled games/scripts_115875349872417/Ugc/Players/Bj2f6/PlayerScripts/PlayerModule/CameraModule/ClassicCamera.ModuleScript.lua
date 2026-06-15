-- Decompiled with Potassium's decompiler.

Vector2.new(0, 0);
local u1 = 0;
local u2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0);
local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__2 = require(l__CommonUtils__1:WaitForChild("FlagUtil"));
local u3 = l__FlagUtil__2.getUserFlag("UserCameraInputDt");
local u4 = l__FlagUtil__2.getUserFlag("UserFixCameraFPError");
local l__Players__3 = game:GetService("Players");
local l__CameraInput__4 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUtils__5 = require(script.Parent:WaitForChild("CameraUtils"));
local l__BaseCamera__6 = require(script.Parent:WaitForChild("BaseCamera"));
local u5 = setmetatable({}, l__BaseCamera__6);
u5.__index = u5;
function u5.new() --[[ Line: 40 ]]
    -- upvalues: l__BaseCamera__6 (copy), u5 (copy), l__CameraUtils__5 (copy)
    local v6 = l__BaseCamera__6.new();
    local v7 = setmetatable(v6, u5);
    v7.isFollowCamera = false;
    v7.isCameraToggle = false;
    v7.lastUpdate = tick();
    v7.cameraToggleSpring = l__CameraUtils__5.Spring.new(5, 0);
    return v7;
end;
function u5.GetCameraToggleOffset(p8, p9) --[[ Line: 51 ]]
    -- upvalues: l__CameraInput__4 (copy), l__CameraUtils__5 (copy)
    if not p8.isCameraToggle then
        return Vector3.new();
    end;
    local l__currentSubjectDistance__7 = p8.currentSubjectDistance;
    if l__CameraInput__4.getTogglePan() then
        local l__cameraToggleSpring__8 = p8.cameraToggleSpring;
        local v10 = l__CameraUtils__5.map(l__currentSubjectDistance__7, 0.5, p8.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1);
        l__cameraToggleSpring__8.goal = math.clamp(v10, 0, 1);
    else
        p8.cameraToggleSpring.goal = 0;
    end;
    local v11 = l__CameraUtils__5.map(l__currentSubjectDistance__7, 0.5, 64, 0, 1);
    local v12 = math.clamp(v11, 0, 1) + 1;
    local v13 = p8.cameraToggleSpring:step(p9) * v12;
    return Vector3.new(0, v13, 0);
end;
function u5.SetCameraMovementMode(p14, p15) --[[ Line: 69 ]]
    -- upvalues: l__BaseCamera__6 (copy)
    l__BaseCamera__6.SetCameraMovementMode(p14, p15);
    p14.isFollowCamera = p15 == Enum.ComputerCameraMovementMode.Follow;
    p14.isCameraToggle = p15 == Enum.ComputerCameraMovementMode.CameraToggle;
end;
function u5.Update(p16, p17) --[[ Line: 76 ]]
    -- upvalues: u3 (copy), u2 (copy), l__Players__3 (copy), l__CameraInput__4 (copy), u1 (ref), l__CameraUtils__5 (copy), u4 (copy)
    local v18 = tick();
    local v19 = v18 - p16.lastUpdate;
    if u3 then
        v19 = p17;
    end;
    local l__CurrentCamera__9 = workspace.CurrentCamera;
    local l__CFrame__10 = l__CurrentCamera__9.CFrame;
    local l__Focus__11 = l__CurrentCamera__9.Focus;
    local v20;
    if p16.resetCameraAngle then
        local v21 = p16:GetHumanoidRootPart();
        if v21 then
            v20 = (v21.CFrame * u2).lookVector;
        else
            v20 = u2.lookVector;
        end;
        p16.resetCameraAngle = false;
    else
        v20 = nil;
    end;
    local l__LocalPlayer__12 = l__Players__3.LocalPlayer;
    local v22 = p16:GetHumanoid();
    local l__CameraSubject__13 = l__CurrentCamera__9.CameraSubject;
    local v23;
    if l__CameraSubject__13 then
        v23 = l__CameraSubject__13:IsA("VehicleSeat");
    else
        v23 = l__CameraSubject__13;
    end;
    local v24;
    if l__CameraSubject__13 then
        v24 = l__CameraSubject__13:IsA("SkateboardPlatform");
    else
        v24 = l__CameraSubject__13;
    end;
    local v25;
    if v22 then
        v25 = v22:GetState() == Enum.HumanoidStateType.Climbing;
    else
        v25 = v22;
    end;
    if p16.lastUpdate == nil or v19 > 1 then
        p16.lastCameraTransform = nil;
    end;
    local v26 = l__CameraInput__4.getRotation(v19);
    p16:StepZoom();
    local v27 = p16:GetCameraHeight();
    if v26 ~= Vector2.new() then
        u1 = 0;
        p16.lastUserPanCamera = tick();
    end;
    local v28 = v18 - p16.lastUserPanCamera < 2;
    local v29 = p16:GetSubjectPosition();
    if v29 and (l__LocalPlayer__12 and l__CurrentCamera__9) then
        local v30 = p16:GetCameraToSubjectDistance();
        local v31 = v30 < 0.5 and 0.5 or v30;
        if p16:GetIsMouseLocked() and not p16:IsInFirstPerson() then
            local v32 = p16:CalculateNewLookCFrameFromArg(v20, v26);
            local v33 = p16:GetMouseLockOffset();
            if v22 then
                v33 = v33 + v22.CameraOffset;
            end;
            local v34 = v33.X * v32.RightVector + v33.Y * v32.UpVector + v33.Z * v32.LookVector;
            if l__CameraUtils__5.IsFiniteVector3(v34) then
                v29 = v29 + v34;
            end;
        elseif v26 == Vector2.new() and p16.lastCameraTransform then
            local v35 = p16:IsInFirstPerson();
            if (v23 or (v24 or p16.isFollowCamera and v25)) and (p16.lastUpdate and (v22 and v22.Torso)) then
                if v35 then
                    if p16.lastSubjectCFrame and (v23 or v24) and l__CameraSubject__13:IsA("BasePart") then
                        local v36 = -l__CameraUtils__5.GetAngleBetweenXZVectors(p16.lastSubjectCFrame.lookVector, l__CameraSubject__13.CFrame.lookVector);
                        if l__CameraUtils__5.IsFinite(v36) then
                            v26 = v26 + Vector2.new(v36, 0);
                        end;
                        u1 = 0;
                    end;
                elseif not v28 then
                    local l__lookVector__14 = v22.Torso.CFrame.lookVector;
                    u1 = math.clamp(u1 + 3.839724354387525 * v19, 0, 4.363323129985824);
                    local v37 = math.clamp(u1 * v19, 0, 1);
                    local v38 = p16:IsInFirstPerson() and not (p16.isFollowCamera and p16.isClimbing) and 1 or v37;
                    local v39 = l__CameraUtils__5.GetAngleBetweenXZVectors(l__lookVector__14, p16:GetCameraLookVector());
                    if l__CameraUtils__5.IsFinite(v39) and math.abs(v39) > 0.0001 then
                        v26 = v26 + Vector2.new(v39 * v38, 0);
                    end;
                end;
            elseif p16.isFollowCamera and not (v35 or v28) then
                local v40 = l__CameraUtils__5.GetAngleBetweenXZVectors(-(p16.lastCameraTransform.p - v29), p16:GetCameraLookVector());
                if l__CameraUtils__5.IsFinite(v40) and (math.abs(v40) > 0.0001 and math.abs(v40) > 0.4 * v19) then
                    v26 = v26 + Vector2.new(v40, 0);
                end;
            end;
        end;
        local v41, v42;
        if p16.isFollowCamera then
            local v43 = p16:CalculateNewLookVectorFromArg(v20, v26);
            v41 = CFrame.new(v29);
            if u4 then
                v42 = CFrame.lookAlong(v41.p - v31 * v43, v43);
            else
                v42 = CFrame.new(v41.p - v31 * v43, v41.p) + Vector3.new(0, v27, 0);
            end;
        else
            v41 = CFrame.new(v29);
            local l__p__15 = v41.p;
            local v44 = p16:CalculateNewLookVectorFromArg(v20, v26);
            if u4 then
                v42 = CFrame.lookAlong(l__p__15 - v31 * v44, v44);
            else
                v42 = CFrame.new(l__p__15 - v31 * v44, l__p__15);
            end;
        end;
        local v45 = p16:GetCameraToggleOffset(v19);
        l__Focus__11 = v41 + v45;
        l__CFrame__10 = v42 + v45;
        p16.lastCameraTransform = l__CFrame__10;
        p16.lastCameraFocus = l__Focus__11;
        if (v23 or v24) and l__CameraSubject__13:IsA("BasePart") then
            p16.lastSubjectCFrame = l__CameraSubject__13.CFrame;
        else
            p16.lastSubjectCFrame = nil;
        end;
    end;
    p16.lastUpdate = v18;
    return l__CFrame__10, l__Focus__11;
end;
return u5;