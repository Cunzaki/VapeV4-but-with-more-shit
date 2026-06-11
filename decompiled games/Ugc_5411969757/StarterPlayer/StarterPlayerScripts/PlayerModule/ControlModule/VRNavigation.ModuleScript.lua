-- Decompiled from: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.VRNavigation
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__VRService__1 = game:GetService("VRService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__RunService__3 = game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
local l__PathfindingService__5 = game:GetService("PathfindingService");
local l__ContextActionService__6 = game:GetService("ContextActionService");
local l__StarterGui__7 = game:GetService("StarterGui");
local u1 = nil;
local l__LocalPlayer__8 = l__Players__4.LocalPlayer;
local u2 = Instance.new("BindableEvent");
u2.Name = "MovementUpdate";
u2.Parent = script;
coroutine.wrap(function() --[[ Line: 42 ]]
    -- upvalues: u1 (ref)
    local l__PathDisplay__9 = script.Parent:WaitForChild("PathDisplay");
    if l__PathDisplay__9 then
        u1 = require(l__PathDisplay__9);
    end;
end)();
local l__BaseCharacterController__10 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u3 = setmetatable({}, l__BaseCharacterController__10);
u3.__index = u3;
function u3.new(p4) --[[ Line: 55 ]]
    -- upvalues: l__BaseCharacterController__10 (copy), u3 (copy)
    local v5 = l__BaseCharacterController__10.new();
    local v6 = setmetatable(v5, u3);
    v6.CONTROL_ACTION_PRIORITY = p4;
    v6.navigationRequestedConn = nil;
    v6.heartbeatConn = nil;
    v6.currentDestination = nil;
    v6.currentPath = nil;
    v6.currentPoints = nil;
    v6.currentPointIdx = 0;
    v6.expectedTimeToNextPoint = 0;
    v6.timeReachedLastPoint = tick();
    v6.moving = false;
    v6.isJumpBound = false;
    v6.moveLatch = false;
    v6.userCFrameEnabledConn = nil;
    return v6;
end;
function u3.SetLaserPointerMode(_, u7) --[[ Line: 80 ]]
    -- upvalues: l__StarterGui__7 (copy)
    pcall(function() --[[ Line: 81 ]]
        -- upvalues: l__StarterGui__7 (ref), u7 (copy)
        l__StarterGui__7:SetCore("VRLaserPointerMode", u7);
    end);
end;
function u3.GetLocalHumanoid(_) --[[ Line: 86 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local l__Character__11 = l__LocalPlayer__8.Character;
    if l__Character__11 then
        for _, v8 in pairs(l__Character__11:GetChildren()) do
            if v8:IsA("Humanoid") then
                return v8;
            end;
        end;
        return nil;
    end;
end;
function u3.HasBothHandControllers(_) --[[ Line: 100 ]]
    -- upvalues: l__VRService__1 (copy)
    local v9 = l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand);
    if v9 then
        v9 = l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
    end;
    return v9;
end;
function u3.HasAnyHandControllers(_) --[[ Line: 104 ]]
    -- upvalues: l__VRService__1 (copy)
    return l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
end;
function u3.IsMobileVR(_) --[[ Line: 108 ]]
    -- upvalues: l__UserInputService__2 (copy)
    return l__UserInputService__2.TouchEnabled;
end;
function u3.HasGamepad(_) --[[ Line: 112 ]]
    -- upvalues: l__UserInputService__2 (copy)
    return l__UserInputService__2.GamepadEnabled;
end;
function u3.ShouldUseNavigationLaser(p10) --[[ Line: 116 ]]
    if p10:IsMobileVR() then
        return true;
    elseif p10:HasBothHandControllers() then
        return false;
    else
        return p10:HasAnyHandControllers() and true or not p10:HasGamepad();
    end;
end;
function u3.StartFollowingPath(p11, p12) --[[ Line: 138 ]]
    -- upvalues: u2 (copy)
    currentPath = p12;
    currentPoints = currentPath:GetPointCoordinates();
    currentPointIdx = 1;
    moving = true;
    timeReachedLastPoint = tick();
    local v13 = p11:GetLocalHumanoid();
    if v13 and (v13.Torso and #currentPoints >= 1) then
        expectedTimeToNextPoint = (currentPoints[1] - v13.Torso.Position).magnitude / v13.WalkSpeed;
    end;
    u2:Fire("targetPoint", p11.currentDestination);
end;
function u3.GoToPoint(p14, p15) --[[ Line: 155 ]]
    -- upvalues: u2 (copy)
    currentPath = true;
    currentPoints = { p15 };
    currentPointIdx = 1;
    moving = true;
    local v16 = p14:GetLocalHumanoid();
    local v17 = (v16.Torso.Position - p15).magnitude / v16.WalkSpeed;
    timeReachedLastPoint = tick();
    expectedTimeToNextPoint = v17;
    u2:Fire("targetPoint", p15);
end;
function u3.StopFollowingPath(p18) --[[ Line: 171 ]]
    currentPath = nil;
    currentPoints = nil;
    currentPointIdx = 0;
    moving = false;
    p18.moveVector = Vector3.new(0, 0, 0);
end;
function u3.TryComputePath(_, p19, p20) --[[ Line: 179 ]]
    -- upvalues: l__PathfindingService__5 (copy)
    local v21 = nil;
    local v22 = 0;
    while not v21 and v22 < 5 do
        v21 = l__PathfindingService__5:ComputeSmoothPathAsync(p19, p20, 200);
        v22 = v22 + 1;
        if v21.Status == Enum.PathStatus.ClosestNoPath or v21.Status == Enum.PathStatus.ClosestOutOfRange then
            return nil;
        end;
        if v21 and v21.Status == Enum.PathStatus.FailStartNotEmpty then
            p19 = p19 + (p20 - p19).unit;
            v21 = nil;
        end;
        if v21 and v21.Status == Enum.PathStatus.FailFinishNotEmpty then
            p20 = p20 + Vector3.new(0, 1, 0);
            v21 = nil;
        end;
    end;
    return v21;
end;
function u3.OnNavigationRequest(p23, p24, _) --[[ Line: 206 ]]
    -- upvalues: u1 (ref)
    local l__p__12 = p24.p;
    local l__currentDestination__13 = p23.currentDestination;
    local l__x__14 = l__p__12.x;
    local v25;
    if l__x__14 == l__x__14 and l__x__14 ~= (1 / 0) then
        v25 = l__x__14 ~= (-1 / 0);
    else
        v25 = false;
    end;
    if v25 then
        local l__y__15 = l__p__12.y;
        if l__y__15 == l__y__15 and l__y__15 ~= (1 / 0) then
            v25 = l__y__15 ~= (-1 / 0);
        else
            v25 = false;
        end;
        if v25 then
            local l__z__16 = l__p__12.z;
            if l__z__16 == l__z__16 and l__z__16 ~= (1 / 0) then
                v25 = l__z__16 ~= (-1 / 0);
            else
                v25 = false;
            end;
        end;
    end;
    if v25 then
        p23.currentDestination = l__p__12;
        local v26 = p23:GetLocalHumanoid();
        if v26 and v26.Torso then
            local l__Position__17 = v26.Torso.Position;
            if (p23.currentDestination - l__Position__17).magnitude < 12 then
                p23:GoToPoint(p23.currentDestination);
            else
                if l__currentDestination__13 and (p23.currentDestination - l__currentDestination__13).magnitude <= 4 then
                    if moving then
                        p23.currentPoints[#currentPoints] = p23.currentDestination;
                        return;
                    end;
                    p23:GoToPoint(p23.currentDestination);
                else
                    local v27 = p23:TryComputePath(l__Position__17, p23.currentDestination);
                    if v27 then
                        p23:StartFollowingPath(v27);
                        if u1 then
                            u1.setCurrentPoints(p23.currentPoints);
                            u1.renderPath();
                        end;
                    else
                        p23:StopFollowingPath();
                        if u1 then
                            u1.clearRenderedPath();
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u3.OnJumpAction(p28, _, p29, _) --[[ Line: 252 ]]
    if p29 == Enum.UserInputState.Begin then
        p28.isJumping = true;
    end;
    return Enum.ContextActionResult.Sink;
end;
function u3.BindJumpAction(u30, p31) --[[ Line: 258 ]]
    -- upvalues: l__ContextActionService__6 (copy)
    if p31 then
        if not u30.isJumpBound then
            u30.isJumpBound = true;
            l__ContextActionService__6:BindActionAtPriority("VRJumpAction", function() --[[ Line: 262 ]]
                -- upvalues: u30 (copy)
                return u30:OnJumpAction();
            end, false, u30.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
        end;
    elseif u30.isJumpBound then
        u30.isJumpBound = false;
        l__ContextActionService__6:UnbindAction("VRJumpAction");
    end;
end;
function u3.ControlCharacterGamepad(p32, _, p33, p34) --[[ Line: 273 ]]
    -- upvalues: u1 (ref), u2 (copy)
    if p34.KeyCode == Enum.KeyCode.Thumbstick1 then
        if p33 ~= Enum.UserInputState.Cancel then
            if p33 == Enum.UserInputState.End then
                p32.moveVector = Vector3.new(0, 0, 0);
                if p32:ShouldUseNavigationLaser() then
                    p32:BindJumpAction(false);
                    p32:SetLaserPointerMode("Navigation");
                end;
                if p32.moveLatch then
                    p32.moveLatch = false;
                    u2:Fire("offtrack");
                end;
            else
                p32:StopFollowingPath();
                if u1 then
                    u1.clearRenderedPath();
                end;
                if p32:ShouldUseNavigationLaser() then
                    p32:BindJumpAction(true);
                    p32:SetLaserPointerMode("Hidden");
                end;
                if p34.Position.magnitude > 0.22 then
                    p32.moveVector = Vector3.new(p34.Position.X, 0, -p34.Position.Y);
                    if p32.moveVector.magnitude > 0 then
                        p32.moveVector = p32.moveVector.unit * math.min(1, p34.Position.magnitude);
                    end;
                    p32.moveLatch = true;
                end;
            end;
            return Enum.ContextActionResult.Sink;
        end;
        p32.moveVector = Vector3.new(0, 0, 0);
    end;
end;
function u3.OnHeartbeat(p35, p36) --[[ Line: 316 ]]
    -- upvalues: u1 (ref), u2 (copy)
    local l__moveVector__18 = p35.moveVector;
    local v37 = p35:GetLocalHumanoid();
    if v37 and v37.Torso then
        if p35.moving and p35.currentPoints then
            local l__Position__19 = v37.Torso.Position;
            local v38 = (currentPoints[1] - l__Position__19) * Vector3.new(1, 0, 1);
            local l__magnitude__20 = v38.magnitude;
            local v39 = v38 / l__magnitude__20;
            if l__magnitude__20 < 1 then
                local v40 = currentPoints[1];
                local v41 = 0;
                for v42, v43 in pairs(currentPoints) do
                    if v42 ~= 1 then
                        v41 = v41 + (v43 - v40).magnitude / v37.WalkSpeed;
                        v40 = v43;
                    end;
                end;
                table.remove(currentPoints, 1);
                currentPointIdx = currentPointIdx + 1;
                if #currentPoints == 0 then
                    p35:StopFollowingPath();
                    if u1 then
                        u1.clearRenderedPath();
                    end;
                    return;
                end;
                if u1 then
                    u1.setCurrentPoints(currentPoints);
                    u1.renderPath();
                end;
                expectedTimeToNextPoint = (currentPoints[1] - l__Position__19).magnitude / v37.WalkSpeed;
                timeReachedLastPoint = tick();
            else
                local v44 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
                local v45 = Ray.new(l__Position__19 - Vector3.new(0, 1, 0), v39 * 3);
                local v46, v47, _ = workspace:FindPartOnRayWithIgnoreList(v45, v44);
                if v46 then
                    local v48 = Ray.new(v47 + v39 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0));
                    local _, v49, _ = workspace:FindPartOnRayWithIgnoreList(v48, v44);
                    local v50 = v49.Y - l__Position__19.Y;
                    if v50 < 6 and v50 > -2 then
                        v37.Jump = true;
                    end;
                end;
                if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                    p35:StopFollowingPath();
                    if u1 then
                        u1.clearRenderedPath();
                    end;
                    u2:Fire("offtrack");
                end;
                l__moveVector__18 = p35.moveVector:Lerp(v39, p36 * 10);
            end;
        end;
        local l__x__21 = l__moveVector__18.x;
        local v51;
        if l__x__21 == l__x__21 and l__x__21 ~= (1 / 0) then
            v51 = l__x__21 ~= (-1 / 0);
        else
            v51 = false;
        end;
        if v51 then
            local l__y__22 = l__moveVector__18.y;
            if l__y__22 == l__y__22 and l__y__22 ~= (1 / 0) then
                v51 = l__y__22 ~= (-1 / 0);
            else
                v51 = false;
            end;
            if v51 then
                local l__z__23 = l__moveVector__18.z;
                if l__z__23 == l__z__23 and l__z__23 ~= (1 / 0) then
                    v51 = l__z__23 ~= (-1 / 0);
                else
                    v51 = false;
                end;
            end;
        end;
        if v51 then
            p35.moveVector = l__moveVector__18;
        end;
    end;
end;
function u3.OnUserCFrameEnabled(p52) --[[ Line: 400 ]]
    if p52:ShouldUseNavigationLaser() then
        p52:BindJumpAction(false);
        p52:SetLaserPointerMode("Navigation");
    else
        p52:BindJumpAction(true);
        p52:SetLaserPointerMode("Hidden");
    end;
end;
function u3.Enable(u53, p54) --[[ Line: 410 ]]
    -- upvalues: l__VRService__1 (copy), l__RunService__3 (copy), l__ContextActionService__6 (copy)
    u53.moveVector = Vector3.new(0, 0, 0);
    u53.isJumping = false;
    if p54 then
        u53.navigationRequestedConn = l__VRService__1.NavigationRequested:Connect(function(p55, p56) --[[ Line: 416 ]]
            -- upvalues: u53 (copy)
            u53:OnNavigationRequest(p55, p56);
        end);
        u53.heartbeatConn = l__RunService__3.Heartbeat:Connect(function(p57) --[[ Line: 417 ]]
            -- upvalues: u53 (copy)
            u53:OnHeartbeat(p57);
        end);
        l__ContextActionService__6:BindAction("MoveThumbstick", function(p58, p59, p60) --[[ Line: 419 ]]
            -- upvalues: u53 (copy)
            return u53:ControlCharacterGamepad(p58, p59, p60);
        end, false, u53.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);
        l__ContextActionService__6:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u53.userCFrameEnabledConn = l__VRService__1.UserCFrameEnabled:Connect(function() --[[ Line: 423 ]]
            -- upvalues: u53 (copy)
            u53:OnUserCFrameEnabled();
        end);
        u53:OnUserCFrameEnabled();
        l__VRService__1:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick);
        l__VRService__1:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY);
        u53.enabled = true;
    else
        u53:StopFollowingPath();
        l__ContextActionService__6:UnbindAction("MoveThumbstick");
        l__ContextActionService__6:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u53:BindJumpAction(false);
        u53:SetLaserPointerMode("Disabled");
        if u53.navigationRequestedConn then
            u53.navigationRequestedConn:Disconnect();
            u53.navigationRequestedConn = nil;
        end;
        if u53.heartbeatConn then
            u53.heartbeatConn:Disconnect();
            u53.heartbeatConn = nil;
        end;
        if u53.userCFrameEnabledConn then
            u53.userCFrameEnabledConn:Disconnect();
            u53.userCFrameEnabledConn = nil;
        end;
        u53.enabled = false;
    end;
end;
return u3;
