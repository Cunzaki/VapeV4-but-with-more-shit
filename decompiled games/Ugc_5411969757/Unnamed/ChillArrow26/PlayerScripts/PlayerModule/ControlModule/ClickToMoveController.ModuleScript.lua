-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.ControlModule.ClickToMoveController
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__PathfindingService__2 = game:GetService("PathfindingService");
local l__Players__3 = game:GetService("Players");
game:GetService("Debris");
local l__StarterGui__4 = game:GetService("StarterGui");
local l__Workspace__5 = game:GetService("Workspace");
local l__CollectionService__6 = game:GetService("CollectionService");
local l__GuiService__7 = game:GetService("GuiService");
local u1 = true;
local u2 = true;
local u3 = false;
local u4 = 1;
local u5 = 8;
local u6 = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
};
local l__LocalPlayer__8 = l__Players__3.LocalPlayer;
local l__ClickToMoveDisplay__9 = require(script.Parent:WaitForChild("ClickToMoveDisplay"));
local u7 = {};
local function u10(p8) --[[ Line: 46 ]]
    -- upvalues: u10 (copy)
    if p8 then
        local v9 = p8:FindFirstChildOfClass("Humanoid");
        if v9 then
            return p8, v9;
        else
            return u10(p8.Parent);
        end;
    end;
end;
u7.FindCharacterAncestor = u10;
local function u21(p11, p12, p13) --[[ Line: 58 ]]
    -- upvalues: l__Workspace__5 (copy), u10 (copy), u21 (copy)
    local v14 = p13 or {};
    local v15, v16, v17, v18 = l__Workspace__5:FindPartOnRayWithIgnoreList(p11, v14);
    if not v15 then
        return nil, nil;
    end;
    if p12 and v15.CanCollide == false then
        local v19;
        if v15 then
            v19 = v15:FindFirstChildOfClass("Humanoid");
            if not v19 then
                local v20;
                v20, v19 = u10(v15.Parent);
            end;
        else
            v19 = nil;
        end;
        if v19 == nil then
            table.insert(v14, v15);
            return u21(p11, p12, v14);
        end;
    end;
    return v15, v16, v17, v18;
end;
u7.Raycast = u21;
local u22 = {};
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local function u35(p27) --[[ Line: 107 ]]
    -- upvalues: u24 (ref), u25 (ref), u26 (ref), u23 (ref), l__LocalPlayer__8 (copy), l__CollectionService__6 (copy)
    if p27 == u24 then
    else
        if u25 then
            u25:Disconnect();
            u25 = nil;
        end;
        if u26 then
            u26:Disconnect();
            u26 = nil;
        end;
        u24 = p27;
        local v28 = {};
        local v29 = l__LocalPlayer__8;
        if v29 then
            v29 = l__LocalPlayer__8.Character;
        end;
        v28[1] = v29;
        u23 = v28;
        if u24 ~= nil then
            local v30 = l__CollectionService__6:GetTagged(u24);
            for _, v31 in ipairs(v30) do
                table.insert(u23, v31);
            end;
            u25 = l__CollectionService__6:GetInstanceAddedSignal(u24):Connect(function(p32) --[[ Line: 127 ]]
                -- upvalues: u23 (ref)
                table.insert(u23, p32);
            end);
            u26 = l__CollectionService__6:GetInstanceRemovedSignal(u24):Connect(function(p33) --[[ Line: 131 ]]
                -- upvalues: u23 (ref)
                for v34 = 1, #u23 do
                    if u23[v34] == p33 then
                        u23[v34] = u23[#u23];
                        table.remove(u23);
                        return;
                    end;
                end;
            end);
        end;
    end;
end;
local function u85(p36, p37, p38) --[[ Line: 154 ]]
    -- upvalues: u3 (ref), l__LocalPlayer__8 (copy), u22 (copy), u4 (ref), l__PathfindingService__2 (copy), u1 (ref), l__ClickToMoveDisplay__9 (copy), u5 (ref), l__Workspace__5 (copy), u23 (ref)
    local u39 = {};
    local v40;
    if p38 == nil then
        v40 = u3;
        p38 = true;
    else
        v40 = p38;
    end;
    u39.Cancelled = false;
    u39.Started = false;
    u39.Finished = Instance.new("BindableEvent");
    u39.PathFailed = Instance.new("BindableEvent");
    u39.PathComputing = false;
    u39.PathComputed = false;
    u39.OriginalTargetPoint = p36;
    u39.TargetPoint = p36;
    u39.TargetSurfaceNormal = p37;
    u39.DiedConn = nil;
    u39.SeatedConn = nil;
    u39.BlockedConn = nil;
    u39.TeleportedConn = nil;
    u39.CurrentPoint = 0;
    u39.HumanoidOffsetFromPath = Vector3.new(0, 0, 0);
    u39.CurrentWaypointPosition = nil;
    u39.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
    u39.CurrentWaypointPlaneDistance = 0;
    u39.CurrentWaypointNeedsJump = false;
    u39.CurrentHumanoidPosition = Vector3.new(0, 0, 0);
    u39.CurrentHumanoidVelocity = 0;
    u39.NextActionMoveDirection = Vector3.new(0, 0, 0);
    u39.NextActionJump = false;
    u39.Timeout = 0;
    local v41 = l__LocalPlayer__8;
    local v42;
    if v41 then
        v42 = v41.Character;
    else
        v42 = v41;
    end;
    local v43;
    if v42 then
        v43 = u22[v41];
        if not v43 or v43.Parent ~= v42 then
            u22[v41] = nil;
            v43 = v42:FindFirstChildOfClass("Humanoid");
            if v43 then
                u22[v41] = v43;
            end;
        end;
    else
        v43 = nil;
    end;
    u39.Humanoid = v43;
    u39.OriginPoint = nil;
    u39.AgentCanFollowPath = false;
    u39.DirectPath = false;
    u39.DirectPathRiseFirst = false;
    local l__Humanoid__10 = u39.Humanoid;
    if l__Humanoid__10 then
        l__Humanoid__10 = u39.Humanoid.RootPart;
    end;
    if l__Humanoid__10 then
        u39.OriginPoint = l__Humanoid__10.CFrame.p;
        local v44 = 2;
        local v45 = 5;
        local v46 = true;
        local l__SeatPart__11 = u39.Humanoid.SeatPart;
        if l__SeatPart__11 and l__SeatPart__11:IsA("VehicleSeat") then
            local v47 = l__SeatPart__11:FindFirstAncestorOfClass("Model");
            if v47 then
                local l__PrimaryPart__12 = v47.PrimaryPart;
                v47.PrimaryPart = l__SeatPart__11;
                if p38 then
                    local v48 = v47:GetExtentsSize();
                    v44 = u4 * 0.5 * math.sqrt(v48.X * v48.X + v48.Z * v48.Z);
                    v45 = u4 * v48.Y;
                    u39.AgentCanFollowPath = true;
                    u39.DirectPath = p38;
                    v46 = false;
                end;
                v47.PrimaryPart = l__PrimaryPart__12;
            end;
        else
            local v49 = l__LocalPlayer__8;
            if v49 then
                v49 = l__LocalPlayer__8.Character;
            end;
            local v50 = v49:GetExtentsSize();
            v44 = u4 * 0.5 * math.sqrt(v50.X * v50.X + v50.Z * v50.Z);
            v45 = u4 * v50.Y;
            v46 = u39.Humanoid.JumpPower > 0;
            u39.AgentCanFollowPath = true;
            u39.DirectPath = v40;
            u39.DirectPathRiseFirst = u39.Humanoid.Sit;
        end;
        u39.pathResult = l__PathfindingService__2:CreatePath({
            AgentRadius = v44,
            AgentHeight = v45,
            AgentCanJump = v46
        });
    end;
    function u39.Cleanup(_) --[[ Line: 254 ]]
        -- upvalues: u39 (copy)
        if u39.stopTraverseFunc then
            u39.stopTraverseFunc();
            u39.stopTraverseFunc = nil;
        end;
        if u39.MoveToConn then
            u39.MoveToConn:Disconnect();
            u39.MoveToConn = nil;
        end;
        if u39.BlockedConn then
            u39.BlockedConn:Disconnect();
            u39.BlockedConn = nil;
        end;
        if u39.DiedConn then
            u39.DiedConn:Disconnect();
            u39.DiedConn = nil;
        end;
        if u39.SeatedConn then
            u39.SeatedConn:Disconnect();
            u39.SeatedConn = nil;
        end;
        if u39.TeleportedConn then
            u39.TeleportedConn:Disconnect();
            u39.TeleportedConn = nil;
        end;
        u39.Started = false;
    end;
    function u39.Cancel(_) --[[ Line: 288 ]]
        -- upvalues: u39 (copy)
        u39.Cancelled = true;
        u39:Cleanup();
    end;
    function u39.IsActive(_) --[[ Line: 293 ]]
        -- upvalues: u39 (copy)
        local v51 = u39.AgentCanFollowPath and u39.Started;
        if v51 then
            v51 = not u39.Cancelled;
        end;
        return v51;
    end;
    function u39.OnPathInterrupted(_) --[[ Line: 297 ]]
        -- upvalues: u39 (copy)
        u39.Cancelled = true;
        u39:OnPointReached(false);
    end;
    function u39.ComputePath(_) --[[ Line: 303 ]]
        -- upvalues: u39 (copy)
        if u39.OriginPoint then
            if u39.PathComputed or u39.PathComputing then
                return;
            end;
            u39.PathComputing = true;
            if u39.AgentCanFollowPath then
                if u39.DirectPath then
                    u39.pointList = { PathWaypoint.new(u39.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(u39.TargetPoint, u39.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) };
                    u39.PathComputed = true;
                else
                    u39.pathResult:ComputeAsync(u39.OriginPoint, u39.TargetPoint);
                    u39.pointList = u39.pathResult:GetWaypoints();
                    u39.BlockedConn = u39.pathResult.Blocked:Connect(function(p52) --[[ Line: 317 ]]
                        -- upvalues: u39 (ref)
                        u39:OnPathBlocked(p52);
                    end);
                    u39.PathComputed = u39.pathResult.Status == Enum.PathStatus.Success;
                end;
            end;
            u39.PathComputing = false;
        end;
    end;
    function u39.IsValidPath(_) --[[ Line: 325 ]]
        -- upvalues: u39 (copy)
        u39:ComputePath();
        local l__PathComputed__13 = u39.PathComputed;
        if l__PathComputed__13 then
            l__PathComputed__13 = u39.AgentCanFollowPath;
        end;
        return l__PathComputed__13;
    end;
    u39.Recomputing = false;
    function u39.OnPathBlocked(_, p53) --[[ Line: 331 ]]
        -- upvalues: u39 (copy), u1 (ref), l__ClickToMoveDisplay__9 (ref)
        if u39.CurrentPoint <= p53 and not u39.Recomputing then
            u39.Recomputing = true;
            if u39.stopTraverseFunc then
                u39.stopTraverseFunc();
                u39.stopTraverseFunc = nil;
            end;
            u39.OriginPoint = u39.Humanoid.RootPart.CFrame.p;
            u39.pathResult:ComputeAsync(u39.OriginPoint, u39.TargetPoint);
            u39.pointList = u39.pathResult:GetWaypoints();
            if #u39.pointList > 0 then
                u39.HumanoidOffsetFromPath = u39.pointList[1].Position - u39.OriginPoint;
            end;
            u39.PathComputed = u39.pathResult.Status == Enum.PathStatus.Success;
            if u1 then
                local v54 = u39;
                local v55 = u39;
                local v56, v57 = l__ClickToMoveDisplay__9.CreatePathDisplay(u39.pointList);
                v54.stopTraverseFunc = v56;
                v55.setPointFunc = v57;
            end;
            if u39.PathComputed then
                u39.CurrentPoint = 1;
                u39:OnPointReached(true);
            else
                u39.PathFailed:Fire();
                u39:Cleanup();
            end;
            u39.Recomputing = false;
        end;
    end;
    function u39.OnRenderStepped(_, p58) --[[ Line: 367 ]]
        -- upvalues: u39 (copy), u5 (ref)
        if u39.Started and not u39.Cancelled then
            u39.Timeout = u39.Timeout + p58;
            if u5 < u39.Timeout then
                u39:OnPointReached(false);
                return;
            end;
            u39.CurrentHumanoidPosition = u39.Humanoid.RootPart.Position + u39.HumanoidOffsetFromPath;
            u39.CurrentHumanoidVelocity = u39.Humanoid.RootPart.Velocity;
            while u39.Started and u39:IsCurrentWaypointReached() do
                u39:OnPointReached(true);
            end;
            if u39.Started then
                u39.NextActionMoveDirection = u39.CurrentWaypointPosition - u39.CurrentHumanoidPosition;
                if u39.NextActionMoveDirection.Magnitude > 1e-6 then
                    u39.NextActionMoveDirection = u39.NextActionMoveDirection.Unit;
                else
                    u39.NextActionMoveDirection = Vector3.new(0, 0, 0);
                end;
                if u39.CurrentWaypointNeedsJump then
                    u39.NextActionJump = true;
                    u39.CurrentWaypointNeedsJump = false;
                    return;
                end;
                u39.NextActionJump = false;
            end;
        end;
    end;
    function u39.IsCurrentWaypointReached(_) --[[ Line: 405 ]]
        -- upvalues: u39 (copy)
        local v59;
        if u39.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            v59 = true;
        else
            local v60 = u39.CurrentWaypointPlaneNormal:Dot(u39.CurrentHumanoidPosition) - u39.CurrentWaypointPlaneDistance;
            local v61 = 0.0625 * -u39.CurrentWaypointPlaneNormal:Dot(u39.CurrentHumanoidVelocity);
            v59 = v60 < math.max(1, v61);
        end;
        if v59 then
            u39.CurrentWaypointPosition = nil;
            u39.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u39.CurrentWaypointPlaneDistance = 0;
        end;
        return v59;
    end;
    function u39.OnPointReached(_, p62) --[[ Line: 431 ]]
        -- upvalues: u39 (copy)
        if p62 and not u39.Cancelled then
            if u39.setPointFunc then
                u39.setPointFunc(u39.CurrentPoint);
            end;
            local v63 = u39.CurrentPoint + 1;
            if #u39.pointList < v63 then
                if u39.stopTraverseFunc then
                    u39.stopTraverseFunc();
                end;
                u39.Finished:Fire();
                u39:Cleanup();
            else
                local v64 = u39.pointList[u39.CurrentPoint];
                local v65 = u39.pointList[v63];
                local v66 = u39.Humanoid:GetState();
                if (v66 == Enum.HumanoidStateType.FallingDown or v66 == Enum.HumanoidStateType.Freefall) and true or v66 == Enum.HumanoidStateType.Jumping then
                    local v67 = v65.Action == Enum.PathWaypointAction.Jump;
                    if not v67 and u39.CurrentPoint > 1 then
                        local v68 = v64.Position - u39.pointList[u39.CurrentPoint - 1].Position;
                        local v69 = v65.Position - v64.Position;
                        v67 = Vector2.new(v68.x, v68.z).Unit:Dot(Vector2.new(v69.x, v69.z).Unit) < 0.996;
                    end;
                    if v67 then
                        u39.Humanoid.FreeFalling:Wait();
                        wait(0.1);
                    end;
                end;
                u39:MoveToNextWayPoint(v64, v65, v63);
            end;
        else
            u39.PathFailed:Fire();
            u39:Cleanup();
        end;
    end;
    function u39.MoveToNextWayPoint(_, p70, p71, p72) --[[ Line: 494 ]]
        -- upvalues: u39 (copy)
        u39.CurrentWaypointPlaneNormal = p70.Position - p71.Position;
        u39.CurrentWaypointPlaneNormal = Vector3.new(u39.CurrentWaypointPlaneNormal.X, 0, u39.CurrentWaypointPlaneNormal.Z);
        if u39.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
            u39.CurrentWaypointPlaneNormal = u39.CurrentWaypointPlaneNormal.Unit;
            u39.CurrentWaypointPlaneDistance = u39.CurrentWaypointPlaneNormal:Dot(p71.Position);
        else
            u39.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u39.CurrentWaypointPlaneDistance = 0;
        end;
        u39.CurrentWaypointNeedsJump = p71.Action == Enum.PathWaypointAction.Jump;
        u39.CurrentWaypointPosition = p71.Position;
        u39.CurrentPoint = p72;
        u39.Timeout = 0;
    end;
    function u39.Start(_, p73) --[[ Line: 522 ]]
        -- upvalues: u39 (copy), l__ClickToMoveDisplay__9 (ref), u1 (ref)
        if u39.AgentCanFollowPath then
            if u39.Started then
            else
                u39.Started = true;
                l__ClickToMoveDisplay__9.CancelFailureAnimation();
                if u1 and (p73 == nil or p73) then
                    local v74 = u39;
                    local v75 = u39;
                    local v76, v77 = l__ClickToMoveDisplay__9.CreatePathDisplay(u39.pointList, u39.OriginalTargetPoint);
                    v74.stopTraverseFunc = v76;
                    v75.setPointFunc = v77;
                end;
                if #u39.pointList > 0 then
                    u39.HumanoidOffsetFromPath = Vector3.new(0, u39.pointList[1].Position.Y - u39.OriginPoint.Y, 0);
                    u39.CurrentHumanoidPosition = u39.Humanoid.RootPart.Position + u39.HumanoidOffsetFromPath;
                    u39.CurrentHumanoidVelocity = u39.Humanoid.RootPart.Velocity;
                    u39.SeatedConn = u39.Humanoid.Seated:Connect(function(_, _) --[[ Line: 549 ]]
                        -- upvalues: u39 (ref)
                        u39:OnPathInterrupted();
                    end);
                    u39.DiedConn = u39.Humanoid.Died:Connect(function() --[[ Line: 550 ]]
                        -- upvalues: u39 (ref)
                        u39:OnPathInterrupted();
                    end);
                    u39.TeleportedConn = u39.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() --[[ Line: 551 ]]
                        -- upvalues: u39 (ref)
                        u39:OnPathInterrupted();
                    end);
                    u39.CurrentPoint = 1;
                    u39:OnPointReached(true);
                else
                    u39.PathFailed:Fire();
                    if u39.stopTraverseFunc then
                        u39.stopTraverseFunc();
                    end;
                end;
            end;
        else
            u39.PathFailed:Fire();
        end;
    end;
    local v78 = Ray.new(u39.TargetPoint + u39.TargetSurfaceNormal * 1.5, Vector3.new(0, -50, 0));
    local v79 = l__Workspace__5;
    local v80;
    if u23 then
        v80 = u23;
    else
        u23 = {};
        local v81 = u23;
        local v82 = l__LocalPlayer__8;
        if v82 then
            v82 = l__LocalPlayer__8.Character;
        end;
        table.insert(v81, v82);
        v80 = u23;
    end;
    local v83, v84 = v79:FindPartOnRayWithIgnoreList(v78, v80);
    if v83 then
        u39.TargetPoint = v84;
    end;
    u39:ComputePath();
    return u39;
end;
local function u88(p86) --[[ Line: 583 ]]
    if p86 ~= nil then
        for _, v87 in pairs(p86:GetChildren()) do
            if v87:IsA("Tool") then
                return v87;
            end;
        end;
    end;
end;
local u89 = nil;
local u90 = nil;
local u91 = nil;
local function u100(p92, u93, u94, u95, u96) --[[ Line: 616 ]]
    -- upvalues: u89 (ref), u90 (ref), u91 (ref), u88 (copy), u2 (ref), l__ClickToMoveDisplay__9 (copy)
    if u89 then
        if u89 then
            u89:Cancel();
            u89 = nil;
        end;
        if u90 then
            u90:Disconnect();
            u90 = nil;
        end;
        if u91 then
            u91:Disconnect();
            u91 = nil;
        end;
    end;
    u89 = p92;
    p92:Start(u96);
    u90 = p92.Finished.Event:Connect(function() --[[ Line: 623 ]]
        -- upvalues: u89 (ref), u90 (ref), u91 (ref), u94 (copy), u88 (ref), u95 (copy)
        if u89 then
            u89:Cancel();
            u89 = nil;
        end;
        if u90 then
            u90:Disconnect();
            u90 = nil;
        end;
        if u91 then
            u91:Disconnect();
            u91 = nil;
        end;
        local v97 = u94 and u88(u95);
        if v97 then
            v97:Activate();
        end;
    end);
    u91 = p92.PathFailed.Event:Connect(function() --[[ Line: 632 ]]
        -- upvalues: u89 (ref), u90 (ref), u91 (ref), u96 (copy), u2 (ref), l__ClickToMoveDisplay__9 (ref), u93 (copy)
        if u89 then
            u89:Cancel();
            u89 = nil;
        end;
        if u90 then
            u90:Disconnect();
            u90 = nil;
        end;
        if u91 then
            u91:Disconnect();
            u91 = nil;
        end;
        if u96 == nil or u96 then
            local v98 = u2;
            if v98 then
                local v99 = u89;
                if v99 then
                    v99 = u89:IsActive();
                end;
                v98 = not v99;
            end;
            if v98 then
                l__ClickToMoveDisplay__9.PlayFailureAnimation();
            end;
            l__ClickToMoveDisplay__9.DisplayFailureWaypoint(u93);
        end;
    end);
end;
function OnTap(p101, p102, p103)
    -- upvalues: l__Workspace__5 (copy), l__LocalPlayer__8 (copy), u22 (copy), u7 (copy), u23 (ref), l__StarterGui__4 (copy), l__Players__3 (copy), u89 (ref), u90 (ref), u91 (ref), u85 (copy), u100 (copy), u2 (ref), l__ClickToMoveDisplay__9 (copy), u88 (copy)
    local l__CurrentCamera__14 = l__Workspace__5.CurrentCamera;
    local l__Character__15 = l__LocalPlayer__8.Character;
    local v104 = l__LocalPlayer__8;
    local v105;
    if v104 then
        v105 = v104.Character;
    else
        v105 = v104;
    end;
    local v106;
    if v105 then
        v106 = u22[v104];
        if not v106 or v106.Parent ~= v105 then
            u22[v104] = nil;
            v106 = v105:FindFirstChildOfClass("Humanoid");
            if v106 then
                u22[v104] = v106;
            end;
        end;
    else
        v106 = nil;
    end;
    local v107;
    if v106 == nil then
        v107 = false;
    else
        v107 = v106.Health > 0;
    end;
    if v107 then
        if #p101 == 1 or p102 then
            if l__CurrentCamera__14 then
                local v108 = l__CurrentCamera__14:ScreenPointToRay(p101[1].x, p101[1].y);
                local v109 = Ray.new(v108.Origin, v108.Direction * 1000);
                local v110 = l__LocalPlayer__8;
                local v111;
                if v110 then
                    v111 = v110.Character;
                else
                    v111 = v110;
                end;
                if v111 then
                    local v112 = u22[v110];
                    if not v112 or v112.Parent ~= v111 then
                        u22[v110] = nil;
                        local v113 = v111:FindFirstChildOfClass("Humanoid");
                        if v113 then
                            u22[v110] = v113;
                        end;
                    end;
                end;
                local l__Raycast__16 = u7.Raycast;
                local v114 = true;
                local v115;
                if u23 then
                    v115 = u23;
                else
                    u23 = {};
                    local v116 = u23;
                    local v117 = l__LocalPlayer__8;
                    if v117 then
                        v117 = l__LocalPlayer__8.Character;
                    end;
                    table.insert(v116, v117);
                    v115 = u23;
                end;
                local v118, v119, v120 = l__Raycast__16(v109, v114, v115);
                local v121, v122 = u7.FindCharacterAncestor(v118);
                if p103 and (v122 and (l__StarterGui__4:GetCore("AvatarContextMenuEnabled") and l__Players__3:GetPlayerFromCharacter(v122.Parent))) then
                    if u89 then
                        u89:Cancel();
                        u89 = nil;
                    end;
                    if u90 then
                        u90:Disconnect();
                        u90 = nil;
                    end;
                    if u91 then
                        u91:Disconnect();
                        u91 = nil;
                    end;
                    return;
                end;
                if p102 then
                    v121 = nil;
                else
                    p102 = v119;
                end;
                if p102 and l__Character__15 then
                    if u89 then
                        u89:Cancel();
                        u89 = nil;
                    end;
                    if u90 then
                        u90:Disconnect();
                        u90 = nil;
                    end;
                    if u91 then
                        u91:Disconnect();
                        u91 = nil;
                    end;
                    local v123 = u85(p102, v120);
                    if v123:IsValidPath() then
                        u100(v123, p102, v121, l__Character__15);
                    else
                        v123:Cleanup();
                        if u89 and u89:IsActive() then
                            u89:Cancel();
                        end;
                        if u2 then
                            l__ClickToMoveDisplay__9.PlayFailureAnimation();
                        end;
                        l__ClickToMoveDisplay__9.DisplayFailureWaypoint(p102);
                    end;
                end;
            end;
        else
            local v124 = #p101 >= 2 and (l__CurrentCamera__14 and u88(l__Character__15));
            if v124 then
                v124:Activate();
            end;
        end;
    end;
end;
local l__Keyboard__17 = require(script.Parent:WaitForChild("Keyboard"));
local u125 = setmetatable({}, l__Keyboard__17);
u125.__index = u125;
function u125.new(p126) --[[ Line: 718 ]]
    -- upvalues: l__Keyboard__17 (copy), u125 (copy)
    local v127 = l__Keyboard__17.new(p126);
    local v128 = setmetatable(v127, u125);
    v128.fingerTouches = {};
    v128.numUnsunkTouches = 0;
    v128.mouse1Down = tick();
    v128.mouse1DownPos = Vector2.new();
    v128.mouse2DownTime = tick();
    v128.mouse2DownPos = Vector2.new();
    v128.mouse2UpTime = tick();
    v128.keyboardMoveVector = Vector3.new(0, 0, 0);
    v128.tapConn = nil;
    v128.inputBeganConn = nil;
    v128.inputChangedConn = nil;
    v128.inputEndedConn = nil;
    v128.humanoidDiedConn = nil;
    v128.characterChildAddedConn = nil;
    v128.onCharacterAddedConn = nil;
    v128.characterChildRemovedConn = nil;
    v128.renderSteppedConn = nil;
    v128.menuOpenedConnection = nil;
    v128.running = false;
    v128.wasdEnabled = false;
    return v128;
end;
function u125.DisconnectEvents(p129) --[[ Line: 750 ]]
    local l__tapConn__18 = p129.tapConn;
    if l__tapConn__18 then
        l__tapConn__18:Disconnect();
    end;
    local l__inputBeganConn__19 = p129.inputBeganConn;
    if l__inputBeganConn__19 then
        l__inputBeganConn__19:Disconnect();
    end;
    local l__inputChangedConn__20 = p129.inputChangedConn;
    if l__inputChangedConn__20 then
        l__inputChangedConn__20:Disconnect();
    end;
    local l__inputEndedConn__21 = p129.inputEndedConn;
    if l__inputEndedConn__21 then
        l__inputEndedConn__21:Disconnect();
    end;
    local l__humanoidDiedConn__22 = p129.humanoidDiedConn;
    if l__humanoidDiedConn__22 then
        l__humanoidDiedConn__22:Disconnect();
    end;
    local l__characterChildAddedConn__23 = p129.characterChildAddedConn;
    if l__characterChildAddedConn__23 then
        l__characterChildAddedConn__23:Disconnect();
    end;
    local l__onCharacterAddedConn__24 = p129.onCharacterAddedConn;
    if l__onCharacterAddedConn__24 then
        l__onCharacterAddedConn__24:Disconnect();
    end;
    local l__renderSteppedConn__25 = p129.renderSteppedConn;
    if l__renderSteppedConn__25 then
        l__renderSteppedConn__25:Disconnect();
    end;
    local l__characterChildRemovedConn__26 = p129.characterChildRemovedConn;
    if l__characterChildRemovedConn__26 then
        l__characterChildRemovedConn__26:Disconnect();
    end;
    local l__menuOpenedConnection__27 = p129.menuOpenedConnection;
    if l__menuOpenedConnection__27 then
        l__menuOpenedConnection__27:Disconnect();
    end;
end;
function u125.OnTouchBegan(p130, p131, p132) --[[ Line: 763 ]]
    if p130.fingerTouches[p131] == nil and not p132 then
        p130.numUnsunkTouches = p130.numUnsunkTouches + 1;
    end;
    p130.fingerTouches[p131] = p132;
end;
function u125.OnTouchChanged(p133, p134, p135) --[[ Line: 770 ]]
    if p133.fingerTouches[p134] == nil then
        p133.fingerTouches[p134] = p135;
        if not p135 then
            p133.numUnsunkTouches = p133.numUnsunkTouches + 1;
        end;
    end;
end;
function u125.OnTouchEnded(p136, p137, _) --[[ Line: 779 ]]
    if p136.fingerTouches[p137] ~= nil and p136.fingerTouches[p137] == false then
        p136.numUnsunkTouches = p136.numUnsunkTouches - 1;
    end;
    p136.fingerTouches[p137] = nil;
end;
function u125.OnCharacterAdded(u138, p139) --[[ Line: 787 ]]
    -- upvalues: l__UserInputService__1 (copy), u6 (copy), u89 (ref), u90 (ref), u91 (ref), l__ClickToMoveDisplay__9 (copy), l__GuiService__7 (copy)
    u138:DisconnectEvents();
    u138.inputBeganConn = l__UserInputService__1.InputBegan:Connect(function(p140, p141) --[[ Line: 790 ]]
        -- upvalues: u138 (copy), u6 (ref), u89 (ref), u90 (ref), u91 (ref), l__ClickToMoveDisplay__9 (ref)
        if p140.UserInputType == Enum.UserInputType.Touch then
            u138:OnTouchBegan(p140, p141);
        end;
        if u138.wasdEnabled and (p141 == false and (p140.UserInputType == Enum.UserInputType.Keyboard and u6[p140.KeyCode])) then
            if u89 then
                u89:Cancel();
                u89 = nil;
            end;
            if u90 then
                u90:Disconnect();
                u90 = nil;
            end;
            if u91 then
                u91:Disconnect();
                u91 = nil;
            end;
            l__ClickToMoveDisplay__9.CancelFailureAnimation();
        end;
        if p140.UserInputType == Enum.UserInputType.MouseButton1 then
            u138.mouse1DownTime = tick();
            u138.mouse1DownPos = p140.Position;
        end;
        if p140.UserInputType == Enum.UserInputType.MouseButton2 then
            u138.mouse2DownTime = tick();
            u138.mouse2DownPos = p140.Position;
        end;
    end);
    u138.inputChangedConn = l__UserInputService__1.InputChanged:Connect(function(p142, p143) --[[ Line: 811 ]]
        -- upvalues: u138 (copy)
        if p142.UserInputType == Enum.UserInputType.Touch then
            u138:OnTouchChanged(p142, p143);
        end;
    end);
    u138.inputEndedConn = l__UserInputService__1.InputEnded:Connect(function(p144, p145) --[[ Line: 817 ]]
        -- upvalues: u138 (copy), u89 (ref)
        if p144.UserInputType == Enum.UserInputType.Touch then
            u138:OnTouchEnded(p144, p145);
        end;
        if p144.UserInputType == Enum.UserInputType.MouseButton2 then
            u138.mouse2UpTime = tick();
            local l__Position__28 = p144.Position;
            if u138.mouse2UpTime - u138.mouse2DownTime < 0.25 and ((l__Position__28 - u138.mouse2DownPos).magnitude < 5 and (u89 or u138.keyboardMoveVector.Magnitude <= 0)) then
                OnTap({ l__Position__28 });
            end;
        end;
    end);
    u138.tapConn = l__UserInputService__1.TouchTap:Connect(function(p146, p147) --[[ Line: 834 ]]
        if not p147 then
            OnTap(p146, nil, true);
        end;
    end);
    u138.menuOpenedConnection = l__GuiService__7.MenuOpened:Connect(function() --[[ Line: 840 ]]
        -- upvalues: u89 (ref), u90 (ref), u91 (ref)
        if u89 then
            u89:Cancel();
            u89 = nil;
        end;
        if u90 then
            u90:Disconnect();
            u90 = nil;
        end;
        if u91 then
            u91:Disconnect();
            u91 = nil;
        end;
    end);
    local function u149(p148) --[[ Line: 844 ]]
        -- upvalues: l__UserInputService__1 (ref), u138 (copy)
        if l__UserInputService__1.TouchEnabled and p148:IsA("Tool") then
            p148.ManualActivationOnly = true;
        end;
        if p148:IsA("Humanoid") then
            local l__humanoidDiedConn__29 = u138.humanoidDiedConn;
            if l__humanoidDiedConn__29 then
                l__humanoidDiedConn__29:Disconnect();
            end;
            u138.humanoidDiedConn = p148.Died:Connect(function() --[[ Line: 852 ]] end);
        end;
    end;
    u138.characterChildAddedConn = p139.ChildAdded:Connect(function(p150) --[[ Line: 860 ]]
        -- upvalues: u149 (copy)
        u149(p150);
    end);
    u138.characterChildRemovedConn = p139.ChildRemoved:Connect(function(p151) --[[ Line: 863 ]]
        -- upvalues: l__UserInputService__1 (ref)
        if l__UserInputService__1.TouchEnabled and p151:IsA("Tool") then
            p151.ManualActivationOnly = false;
        end;
    end);
    for _, v152 in pairs(p139:GetChildren()) do
        u149(v152);
    end;
end;
function u125.Start(p153) --[[ Line: 875 ]]
    p153:Enable(true);
end;
function u125.Stop(p154) --[[ Line: 879 ]]
    p154:Enable(false);
end;
function u125.CleanupPath(_) --[[ Line: 883 ]]
    -- upvalues: u89 (ref), u90 (ref), u91 (ref)
    if u89 then
        u89:Cancel();
        u89 = nil;
    end;
    if u90 then
        u90:Disconnect();
        u90 = nil;
    end;
    if u91 then
        u91:Disconnect();
        u91 = nil;
    end;
end;
function u125.Enable(u155, p156, p157, p158) --[[ Line: 887 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u89 (ref), u90 (ref), u91 (ref), l__UserInputService__1 (copy)
    if p156 then
        if not u155.running then
            if l__LocalPlayer__8.Character then
                u155:OnCharacterAdded(l__LocalPlayer__8.Character);
            end;
            u155.onCharacterAddedConn = l__LocalPlayer__8.CharacterAdded:Connect(function(p159) --[[ Line: 893 ]]
                -- upvalues: u155 (copy)
                u155:OnCharacterAdded(p159);
            end);
            u155.running = true;
        end;
        u155.touchJumpController = p158;
        if u155.touchJumpController then
            u155.touchJumpController:Enable(u155.jumpEnabled);
        end;
    else
        if u155.running then
            u155:DisconnectEvents();
            if u89 then
                u89:Cancel();
                u89 = nil;
            end;
            if u90 then
                u90:Disconnect();
                u90 = nil;
            end;
            if u91 then
                u91:Disconnect();
                u91 = nil;
            end;
            if l__UserInputService__1.TouchEnabled then
                local l__Character__30 = l__LocalPlayer__8.Character;
                if l__Character__30 then
                    for _, v160 in pairs(l__Character__30:GetChildren()) do
                        if v160:IsA("Tool") then
                            v160.ManualActivationOnly = false;
                        end;
                    end;
                end;
            end;
            u155.running = false;
        end;
        if u155.touchJumpController and not u155.jumpEnabled then
            u155.touchJumpController:Enable(true);
        end;
        u155.touchJumpController = nil;
    end;
    if l__UserInputService__1.KeyboardEnabled and p156 ~= u155.enabled then
        u155.forwardValue = 0;
        u155.backwardValue = 0;
        u155.leftValue = 0;
        u155.rightValue = 0;
        u155.moveVector = Vector3.new(0, 0, 0);
        if p156 then
            u155:BindContextActions();
            u155:ConnectFocusEventListeners();
        else
            u155:UnbindContextActions();
            u155:DisconnectFocusEventListeners();
        end;
    end;
    u155.wasdEnabled = p156 and p157 and p157 or false;
    u155.enabled = p156;
end;
function u125.OnRenderStepped(p161, p162) --[[ Line: 948 ]]
    -- upvalues: u89 (ref)
    p161.isJumping = false;
    if u89 then
        u89:OnRenderStepped(p162);
        if u89 then
            p161.moveVector = u89.NextActionMoveDirection;
            p161.moveVectorIsCameraRelative = false;
            if u89.NextActionJump then
                p161.isJumping = true;
            end;
        else
            p161.moveVector = p161.keyboardMoveVector;
            p161.moveVectorIsCameraRelative = true;
        end;
    else
        p161.moveVector = p161.keyboardMoveVector;
        p161.moveVectorIsCameraRelative = true;
    end;
    if p161.jumpRequested then
        p161.isJumping = true;
    end;
end;
function u125.UpdateMovement(p163, p164) --[[ Line: 983 ]]
    if p164 == Enum.UserInputState.Cancel then
        p163.keyboardMoveVector = Vector3.new(0, 0, 0);
    else
        if p163.wasdEnabled then
            p163.keyboardMoveVector = Vector3.new(p163.leftValue + p163.rightValue, 0, p163.forwardValue + p163.backwardValue);
        end;
    end;
end;
function u125.UpdateJump(_) --[[ Line: 992 ]] end;
function u125.SetShowPath(_, p165) --[[ Line: 997 ]]
    -- upvalues: u1 (ref)
    u1 = p165;
end;
function u125.GetShowPath(_) --[[ Line: 1001 ]]
    -- upvalues: u1 (ref)
    return u1;
end;
function u125.SetWaypointTexture(_, p166) --[[ Line: 1005 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    l__ClickToMoveDisplay__9.SetWaypointTexture(p166);
end;
function u125.GetWaypointTexture(_) --[[ Line: 1009 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    return l__ClickToMoveDisplay__9.GetWaypointTexture();
end;
function u125.SetWaypointRadius(_, p167) --[[ Line: 1013 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    l__ClickToMoveDisplay__9.SetWaypointRadius(p167);
end;
function u125.GetWaypointRadius(_) --[[ Line: 1017 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    return l__ClickToMoveDisplay__9.GetWaypointRadius();
end;
function u125.SetEndWaypointTexture(_, p168) --[[ Line: 1021 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    l__ClickToMoveDisplay__9.SetEndWaypointTexture(p168);
end;
function u125.GetEndWaypointTexture(_) --[[ Line: 1025 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    return l__ClickToMoveDisplay__9.GetEndWaypointTexture();
end;
function u125.SetWaypointsAlwaysOnTop(_, p169) --[[ Line: 1029 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    l__ClickToMoveDisplay__9.SetWaypointsAlwaysOnTop(p169);
end;
function u125.GetWaypointsAlwaysOnTop(_) --[[ Line: 1033 ]]
    -- upvalues: l__ClickToMoveDisplay__9 (copy)
    return l__ClickToMoveDisplay__9.GetWaypointsAlwaysOnTop();
end;
function u125.SetFailureAnimationEnabled(_, p170) --[[ Line: 1037 ]]
    -- upvalues: u2 (ref)
    u2 = p170;
end;
function u125.GetFailureAnimationEnabled(_) --[[ Line: 1041 ]]
    -- upvalues: u2 (ref)
    return u2;
end;
function u125.SetIgnoredPartsTag(_, p171) --[[ Line: 1045 ]]
    -- upvalues: u35 (copy)
    u35(p171);
end;
function u125.GetIgnoredPartsTag(_) --[[ Line: 1049 ]]
    -- upvalues: u24 (ref)
    return u24;
end;
function u125.SetUseDirectPath(_, p172) --[[ Line: 1053 ]]
    -- upvalues: u3 (ref)
    u3 = p172;
end;
function u125.GetUseDirectPath(_) --[[ Line: 1057 ]]
    -- upvalues: u3 (ref)
    return u3;
end;
function u125.SetAgentSizeIncreaseFactor(_, p173) --[[ Line: 1061 ]]
    -- upvalues: u4 (ref)
    u4 = 1 + p173 / 100;
end;
function u125.GetAgentSizeIncreaseFactor(_) --[[ Line: 1065 ]]
    -- upvalues: u4 (ref)
    return (u4 - 1) * 100;
end;
function u125.SetUnreachableWaypointTimeout(_, p174) --[[ Line: 1069 ]]
    -- upvalues: u5 (ref)
    u5 = p174;
end;
function u125.GetUnreachableWaypointTimeout(_) --[[ Line: 1073 ]]
    -- upvalues: u5 (ref)
    return u5;
end;
function u125.SetUserJumpEnabled(p175, p176) --[[ Line: 1077 ]]
    p175.jumpEnabled = p176;
    if p175.touchJumpController then
        p175.touchJumpController:Enable(p176);
    end;
end;
function u125.GetUserJumpEnabled(p177) --[[ Line: 1084 ]]
    return p177.jumpEnabled;
end;
function u125.MoveTo(_, p178, p179, p180) --[[ Line: 1088 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u85 (copy), u100 (copy)
    local l__Character__31 = l__LocalPlayer__8.Character;
    if l__Character__31 == nil then
        return false;
    end;
    local v181 = u85(p178, Vector3.new(0, 1, 0), p180);
    if not (v181 and v181:IsValidPath()) then
        return false;
    end;
    u100(v181, p178, nil, l__Character__31, p179);
    return true;
end;
return u125;
