-- Decompiled with Potassium's decompiler.

local v1, v2 = pcall(function() --[[ Line: 7 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor2");
end);
local u3 = v1 and v2;
local u4 = Vector2.new(0, 0);
local l__CameraUtils__1 = require(script.Parent:WaitForChild("CameraUtils"));
local l__CameraInput__2 = require(script.Parent:WaitForChild("CameraInput"));
local l__Players__3 = game:GetService("Players");
local l__BaseCamera__4 = require(script.Parent:WaitForChild("BaseCamera"));
local u5 = setmetatable({}, l__BaseCamera__4);
u5.__index = u5;
function u5.new() --[[ Line: 26 ]]
    -- upvalues: l__BaseCamera__4 (copy), u5 (copy)
    local v6 = l__BaseCamera__4.new();
    local v7 = setmetatable(v6, u5);
    v7.cameraType = Enum.CameraType.Fixed;
    v7.lastUpdate = tick();
    v7.lastDistanceToSubject = nil;
    return v7;
end;
function u5.GetModuleName(_) --[[ Line: 36 ]]
    return "LegacyCamera";
end;
function u5.SetCameraToSubjectDistance(p8, p9) --[[ Line: 41 ]]
    -- upvalues: l__BaseCamera__4 (copy)
    return l__BaseCamera__4.SetCameraToSubjectDistance(p8, p9);
end;
function u5.Update(p10, _) --[[ Line: 45 ]]
    -- upvalues: l__Players__3 (copy), u3 (ref), l__CameraInput__2 (copy), u4 (copy), l__CameraUtils__1 (copy)
    if p10.cameraType then
        local v11 = tick();
        local v12 = v11 - p10.lastUpdate;
        local l__CurrentCamera__5 = workspace.CurrentCamera;
        local l__CFrame__6 = l__CurrentCamera__5.CFrame;
        local l__Focus__7 = l__CurrentCamera__5.Focus;
        local l__LocalPlayer__8 = l__Players__3.LocalPlayer;
        if p10.lastUpdate == nil or v12 > 1 then
            p10.lastDistanceToSubject = nil;
        end;
        local v13 = p10:GetSubjectPosition();
        if p10.cameraType == Enum.CameraType.Fixed then
            if p10.lastUpdate and not u3 then
                local v14 = math.min(0.1, v11 - p10.lastUpdate);
                local v15 = p10:UpdateGamepad();
                p10.rotateInput = p10.rotateInput + v15 * v14;
            end;
            if v13 and (l__LocalPlayer__8 and l__CurrentCamera__5) then
                local v16 = p10:GetCameraToSubjectDistance();
                local v17;
                if u3 then
                    v17 = p10:CalculateNewLookVectorFromArg(nil, l__CameraInput__2.getRotation());
                else
                    v17 = p10:CalculateNewLookVector();
                    p10.rotateInput = u4;
                end;
                l__Focus__7 = l__CurrentCamera__5.Focus;
                l__CFrame__6 = CFrame.new(l__CurrentCamera__5.CFrame.p, l__CurrentCamera__5.CFrame.p + v16 * v17);
            end;
        elseif p10.cameraType == Enum.CameraType.Attach then
            if v13 and l__CurrentCamera__5 then
                local v18 = p10:GetCameraToSubjectDistance();
                local v19 = p10:GetHumanoid();
                if p10.lastUpdate and (v19 and (v19.RootPart and not u3)) then
                    local v20 = math.min(0.1, v11 - p10.lastUpdate);
                    local v21 = p10:UpdateGamepad();
                    p10.rotateInput = p10.rotateInput + v21 * v20;
                    local v22 = l__CameraUtils__1.GetAngleBetweenXZVectors(v19.RootPart.CFrame.lookVector, p10:GetCameraLookVector());
                    if l__CameraUtils__1.IsFinite(v22) then
                        p10.rotateInput = Vector2.new(v22, p10.rotateInput.Y);
                    end;
                end;
                local v23;
                if u3 then
                    v23 = p10:CalculateNewLookVectorFromArg(nil, l__CameraInput__2.getRotation() * Vector2.new(0, 1));
                else
                    v23 = p10:CalculateNewLookVector();
                    p10.rotateInput = u4;
                end;
                l__Focus__7 = CFrame.new(v13);
                l__CFrame__6 = CFrame.new(v13 - v18 * v23, v13);
            end;
        else
            if p10.cameraType ~= Enum.CameraType.Watch then
                return l__CurrentCamera__5.CFrame, l__CurrentCamera__5.Focus;
            end;
            if v13 and (l__LocalPlayer__8 and l__CurrentCamera__5) then
                local v24 = p10:GetHumanoid();
                local v25;
                if v24 and v24.RootPart then
                    local v26 = v13 - l__CurrentCamera__5.CFrame.p;
                    v25 = v26.unit;
                    if p10.lastDistanceToSubject and p10.lastDistanceToSubject == p10:GetCameraToSubjectDistance() then
                        p10:SetCameraToSubjectDistance(v26.magnitude);
                    end;
                else
                    v25 = nil;
                end;
                local v27 = p10:GetCameraToSubjectDistance();
                local v28;
                if u3 then
                    v28 = p10:CalculateNewLookVectorFromArg(v25, l__CameraInput__2.getRotation());
                else
                    v28 = p10:CalculateNewLookVector(v25);
                    p10.rotateInput = u4;
                end;
                l__Focus__7 = CFrame.new(v13);
                l__CFrame__6 = CFrame.new(v13 - v27 * v28, v13);
                p10.lastDistanceToSubject = v27;
            end;
        end;
        p10.lastUpdate = v11;
        return l__CFrame__6, l__Focus__7;
    end;
end;
return u5;