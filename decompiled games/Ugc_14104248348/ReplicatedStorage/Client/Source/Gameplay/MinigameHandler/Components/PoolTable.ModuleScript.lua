-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.PoolTable
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__LocalPlayer__2 = l__Players__1.LocalPlayer;
local l__CurrentCamera__3 = workspace.CurrentCamera;
l__LocalPlayer__2:GetMouse();
game:GetService("Debris");
local l__HttpService__4 = game:GetService("HttpService");
local l__TweenService__5 = game:GetService("TweenService");
local l__ReplicatedStorage__6 = game:GetService("ReplicatedStorage");
local l__UserInputService__7 = game:GetService("UserInputService");
local l__Pool__8 = l__ReplicatedStorage__6.Assets.Minigame.Pool;
local l__RunService__9 = game:GetService("RunService");
local l__Mince__10 = require(l__ReplicatedStorage__6.Modules.Mince);
local u1 = l__Mince__10:Get("BindManager");
local u2 = l__Mince__10:Get("InterfaceHandler");
local l__PoolSimulation__11 = require(l__ReplicatedStorage__6.Modules.PoolSimulation);
local u3 = TweenInfo.new(1, Enum.EasingStyle.Cubic);
local u4 = l__Mince__10:Get("SoundHandler");
local u5 = l__Mince__10:Get("SelectInteractor");
local v6 = {
    Simulator = nil,
    UpdateOpponent = true,
    CanPlay = false,
    Client = {}
};
local l__HeadShot__12 = Enum.ThumbnailType.HeadShot;
local l__Size150x150__13 = Enum.ThumbnailSize.Size150x150;
Color3.fromRGB(85, 255, 0);
Color3.fromRGB(255, 0, 0);
TweenInfo.new(0.1);
local function u14(p7, p8) --[[ Line: 46 ]]
    local l__CFrame__14 = p7.CFrame;
    local l__Size__15 = p7.Size;
    local v9 = l__CFrame__14:PointToObjectSpace(p8);
    local v10 = l__Size__15 / 2;
    local v11 = math.clamp(v9.X, -v10.X, v10.X);
    local v12 = math.clamp(v9.Y, -v10.Y, v10.Y);
    local v13 = math.clamp(v9.Z, -v10.Z, v10.Z);
    return (p8 - l__CFrame__14:PointToWorldSpace((Vector3.new(v11, v12, v13)))).Magnitude;
end;
function v6.CreateIKControlAndMapTo(u15, p16, p17) --[[ Line: 66 ]]
    -- upvalues: l__LocalPlayer__2 (copy)
    local l__Character__16 = l__LocalPlayer__2.Character;
    local l__HumanoidRootPart__17 = l__Character__16.HumanoidRootPart;
    local v18 = l__Character__16:WaitForChild((`{p16}UpperArm`));
    local v19 = l__Character__16:WaitForChild((`{p16}Hand`));
    local v20 = Instance.new("IKControl");
    v20.Type = Enum.IKControlType.Position;
    v20.ChainRoot = v18;
    v20.EndEffector = v19;
    v20.Enabled = false;
    v20.Target = p17;
    v20.Parent = v18;
    if p16 == "Right" then
        local u21 = Instance.new("Attachment");
        u21.Parent = l__HumanoidRootPart__17;
        task.spawn(function() --[[ Line: 86 ]]
            -- upvalues: u21 (copy), u15 (copy)
            task.wait(1);
            u21.WorldCFrame = u15.Cue.Pole.WorldCFrame;
        end);
        v20.Pole = u21;
        u15.Maid:Mark(u21);
    end;
    u15.Maid:Mark(v20);
    return v20;
end;
function v6.GetDistanceFromCue(p22, p23) --[[ Line: 98 ]]
    local l__Position__18 = (p22.Cue.CFrame * CFrame.new(0, 0, p22.Cue.Size.Z / 2)).Position;
    return (p23.Instance.Position - l__Position__18).Magnitude;
end;
function v6.ApplyImplusAtAngle(p24, p25, p26, p27) --[[ Line: 106 ]]
    local v28 = false;
    local u29 = nil;
    local l__LookVector__19 = CFrame.Angles(0, p25, 0).LookVector;
    local v30 = l__LookVector__19 * 10 * (p26 / 100);
    local v31 = {};
    p24.AllStationary = false;
    p24.CueBall.Velocity = Vector2.new(v30.X, v30.Z);
    p24.Server:ApplyImpluse(p24.CueBall.Velocity);
    local v34 = p24.Simulator.OnCueBallHit:ConnectOnce(function(p32, p33) --[[ Line: 119 ]]
        -- upvalues: u29 (ref)
        u29 = p32.Instance.Name == "0" and p33 and p33 or p32;
    end);
    local v35;
    if p27 then
        local v36 = Instance.new("Part");
        v36.Size = Vector3.new(0.05, 0, p26 / 50);
        v36.Anchored = true;
        v36.CanCollide = false;
        v36.CFrame = CFrame.lookAt(p24.CueBall.Instance.Position, p24.CueBall.Instance.Position + l__LookVector__19);
        v36.BrickColor = BrickColor.Red();
        v36.Parent = workspace;
        v35 = u29;
    else
        v35 = u29;
    end;
    while true do
        task.wait(0.1);
        local v37 = 0;
        local v38 = false;
        for _, v39 in p24.Simulator.Balls do
            if v39.Stationary then
                v31[v39.Instance.Name] = v39.Position;
            else
                v38 = true;
            end;
            if v39.Bounced then
                v37 = v37 + 1;
            end;
        end;
        v28 = not v38 and true or v28;
        if v28 then
            p24.AllStationary = true;
            p24.Server:Sync(v31, {
                Final = true,
                FirstHit = v35 and v35.Instance.Name or nil,
                Bounces = v37
            });
            v34:Destroy();
            return;
        end;
    end;
end;
function v6.Update(p40, _) --[[ Line: 164 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u14 (copy)
    if p40.Simulator then
        local l__Character__20 = l__LocalPlayer__2.Character;
        local l__Humanoid__21 = l__Character__20.Humanoid;
        local l__HumanoidRootPart__22 = l__Character__20.HumanoidRootPart;
        local l__Position__23 = p40.CueBall.Instance.Position;
        local v41 = p40.CanPlay and p40.AllStationary or p40.MouseHeldDown;
        local v42 = u14(p40.Simulator.Container, l__HumanoidRootPart__22.CFrame.Position);
        local v43, v44;
        if p40.TouchMode then
            local l__Container__24 = p40.MobileControls.Container;
            local l__Cue__25 = l__Container__24.Cue;
            local l__CueFramePosition__26 = p40.CueFramePosition;
            local l__CueFrameY__27 = p40.CueFrameY;
            p40.CueFrameY = l__CueFrameY__27 + ((p40.CueFrameHeld and l__CueFramePosition__26 and l__CueFramePosition__26 or 0) - l__CueFrameY__27) * 0.1;
            l__Cue__25.Position = UDim2.new(0.5, 0, 0.5, p40.CueFrameY);
            v43 = l__Container__24.UIStroke;
            v44 = l__Container__24.ToFar;
        else
            local l__Power__28 = p40.MobileControls.Power;
            local l__Bar__29 = l__Power__28.Bar;
            local v45 = p40.MouseHeldDown and (-p40.CueOffset or 0) or 0;
            local v46 = math.max(v45, 0.08);
            local l__CueFrameY__30 = p40.CueFrameY;
            p40.CueFrameY = l__CueFrameY__30 + (v46 - l__CueFrameY__30) * 0.1;
            l__Bar__29.Size = UDim2.fromScale(p40.CueFrameY, 1);
            local l__Transparency__31 = l__Bar__29.Transparency;
            l__Bar__29.Transparency = l__Transparency__31 + ((v45 < 0.08 and 1 or 0) - l__Transparency__31) * 0.1;
            v43 = l__Power__28.UIStroke;
            v44 = l__Power__28.ToFar;
        end;
        v43.Color = v43.Color:Lerp(v42 > 5 and Color3.new(1, 0, 0) or Color3.new(1, 1, 1), 0.1);
        local l__TextTransparency__32 = v44.TextTransparency;
        v44.TextTransparency = l__TextTransparency__32 + ((v42 > 5 and 0 or 1) - l__TextTransparency__32) * 0.1;
        if v41 then
            local l__UpperTorso__33 = l__Character__20.UpperTorso;
            local l__CFrame__34 = l__HumanoidRootPart__22.CFrame;
            local v47 = l__UpperTorso__33.CFrame * CFrame.new(0.5, 0, -1);
            local l__Unit__35 = (v47.Position - l__Position__23).Unit;
            l__Unit__35:Dot(Vector3.new(0, 0, 1));
            l__Unit__35:Cross(Vector3.new(0, 0, 1));
            local v48 = math.atan2(l__Unit__35.X, l__Unit__35.Z);
            l__HumanoidRootPart__22.CFrame = CFrame.lookAt(l__CFrame__34.Position, (Vector3.new(l__Position__23.X, l__CFrame__34.Position.Y, l__Position__23.Z))) * CFrame.Angles(0, -0.8726646259971648, 0);
            p40.Cue.CFrame = CFrame.lookAt(v47.Position, l__Position__23) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, p40.CueOffset);
            p40.Angle = v48;
        end;
        p40.Trajectory.Position = l__Position__23 - Vector3.new(0, p40.Simulator.Radius * 0.8, 0);
        local l__Trajectory__36 = p40.Trajectory;
        local v49 = math.deg(p40.Angle);
        l__Trajectory__36.Orientation = Vector3.new(0, v49, 0);
        local l__Trajectory__37 = p40.Trajectory;
        local v50;
        if p40.AllStationary and p40.CanPlay then
            v50 = p40.Instance or nil;
        else
            v50 = nil;
        end;
        l__Trajectory__37.Parent = v50;
        l__Humanoid__21.AutoRotate = not v41;
        p40.ServerCue.LocalTransparencyModifier = v41 and 1 or 0;
        p40.Cue.Transparency = v41 and 0 or 1;
        p40.RightArmIK.Enabled = v41;
        p40.LeftArmIK.Enabled = v41;
    end;
end;
function v6.Construct(p51) --[[ Line: 232 ]]
    -- upvalues: u2 (copy)
    for _, v52 in p51.Instance.Players:GetChildren() do
        if v52:IsA("Seat") then
            p51:AddSeatJoinSource(v52, (tonumber(v52.Name)));
        else
            p51:AddProximityJoinSource(v52:WaitForChild("Position"), tonumber(v52.Name), p51.Instance.Barrier);
        end;
    end;
    p51.Angle = 0;
    p51.CueOffset = 0;
    p51.MousePoint = Vector3.new(0, 0, 0);
    p51.MouseDelta = Vector3.new(0, 0, 0);
    p51.ScoresUI = p51.Instance:FindFirstChild("Information", true);
    p51.MobileControls = u2.GetScreenGui("Pool");
    p51.RaycastWhitelist = RaycastParams.new();
    p51.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
end;
function v6.UpdatePlayerImage(p53, p54) --[[ Line: 262 ]]
    -- upvalues: l__Players__1 (copy), l__HeadShot__12 (copy), l__Size150x150__13 (copy)
    if p53.Slots[p54] then
        local v55 = l__Players__1:GetUserThumbnailAsync(p53.Slots[p54].UserId, l__HeadShot__12, l__Size150x150__13);
        local v56 = p53.ScoresUI.Container["Player" .. p54];
        v56.PlayerIcon.Image = v55;
        v56.Details.NameLabel.Text = p53.Slots[p54].DisplayName;
    end;
end;
function v6.UpdatePlayerScore(p57, p58, p59) --[[ Line: 276 ]]
    -- upvalues: l__Pool__8 (copy)
    local l__Score__38 = p57.ScoresUI.Container["Player" .. p58].Details.Score;
    local l__Template__39 = l__Score__38.Layout.Template;
    if #l__Score__38:GetChildren() < 3 then
        for v60 = 1, 8 do
            local v61 = l__Template__39:Clone();
            v61.Name = v60;
            local v62;
            if p58 == 2 then
                v62 = 9 - v60 or v60;
            else
                v62 = v60;
            end;
            v61.LayoutOrder = v62;
            v61.Parent = l__Score__38;
            if v60 == 8 then
                v61.UIStroke.Color = Color3.fromRGB(255, 255, 0);
            end;
        end;
    end;
    for v63 = 1, 8 do
        local v64 = p59[v63];
        local v65 = l__Score__38[v63];
        if v64 then
            local v66 = l__Pool__8.Balls[v64];
            v65.Background.BackgroundColor3 = v66.Color;
            v65.Background.Visible = true;
            v65.Striped.Visible = v66:GetAttribute("Striped") and true or false;
        else
            v65.Background.Visible = false;
            v65.Striped.Visible = false;
        end;
    end;
end;
function v6.Watch(u67, p68, u69) --[[ Line: 312 ]]
    -- upvalues: l__PoolSimulation__11 (copy), l__Pool__8 (copy), l__TweenService__5 (copy), u3 (copy), u4 (copy), l__HttpService__4 (copy), l__RunService__9 (copy)
    local u70 = l__PoolSimulation__11.new({
        Restituion = 0.5,
        Radius = 0.1355,
        Container = u67.Instance.Hitbox,
        Pockets = u67.Instance.Collectors:GetChildren(),
        ConstructBalls = not u69,
        Models = l__Pool__8.Balls,
        Parent = u67.Instance.Balls
    });
    local u71 = u67.Instance:FindFirstChild("ServerBalls");
    u70.OnBallPocket:Connect(function(p72, u73) --[[ Line: 325 ]]
        -- upvalues: u67 (copy), u70 (copy), l__TweenService__5 (ref), u3 (ref), u69 (copy), u4 (ref)
        if u73.Instance.Name == "0" then
            u73.Pocketed = false;
            if u67.CanPlay then
                u73.Position = Vector2.new(u70.Container.Size.X / 2, u70.Container.Size.z / 2);
                u73.Velocity = Vector2.zero;
                u67.Server:Sync({
                    [u73.Instance.Name] = u73.Position
                });
            end;
        else
            u73.Simulate = false;
            local v74 = l__TweenService__5:Create(u73.Instance, u3, {
                Transparency = 1,
                Position = p72.Position + Vector3.new(0, -u70.Radius * 2, 0)
            });
            v74.Completed:Connect(function() --[[ Line: 344 ]]
                -- upvalues: u69 (ref), u70 (ref), u73 (copy)
                if not u69 then
                    u70:DeleteBall(u73.Instance);
                end;
            end);
            u4.PlaySound("Pool.Pocket");
            u67.Server:Pocket(u73.Instance.Name);
            v74:Play();
        end;
    end);
    u70.OnBallCollision:Connect(function(p75) --[[ Line: 356 ]]
        -- upvalues: u4 (ref)
        if p75 == "Ball" then
            u4.PlaySound("Pool.Collision").Volume = math.random(0.3, 1);
        else
            if p75 == "Wall" then
                u4.PlaySound("Pool.DampenedCollision").Volume = math.random(0.3, 0.5);
            end;
        end;
    end);
    local v77 = u67:GetStateChangedSignal("Velocity"):Connect(function(p76) --[[ Line: 366 ]]
        -- upvalues: u67 (copy), u4 (ref)
        if u67.CanPlay then
        else
            u4.PlaySound("Pool.Cue");
            u67.CueBall.Velocity = p76;
        end;
    end);
    local v80 = u67:WatchStateChange("Scores", function(p78) --[[ Line: 377 ]]
        -- upvalues: l__HttpService__4 (ref), u67 (copy)
        local v79 = l__HttpService__4:JSONDecode(p78);
        u67:UpdatePlayerScore(1, v79[1]);
        u67:UpdatePlayerScore(2, v79[2]);
    end);
    if u71 then
        u71.ChildRemoved:Connect(function() --[[ Line: 384 ]]
            -- upvalues: u71 (copy), u70 (copy)
            local v81 = {};
            for _, v82 in u71:GetChildren() do
                v81[v82.Name] = true;
            end;
            for _, v83 in u70.Balls do
                if not v81[v83.Instance.Name] then
                    u70:DeleteBall(v83.Instance);
                    return;
                end;
            end;
        end);
        for _, u84 in u71:GetChildren() do
            local l__Name__40 = u84.Name;
            u84.CanQuery = false;
            u84.CanTouch = false;
            u84.CanCollide = false;
            u84.Transparency = 1;
            if u69 then
                local v85 = u84.Position - u70.RelativePosition;
                u70:CreateBall(l__Name__40, u84:GetAttribute("RelativePosition") or Vector2.new(v85.X, v85.Z));
                u84:GetAttributeChangedSignal("RelativePosition"):Connect(function() --[[ Line: 412 ]]
                    -- upvalues: u84 (copy), u70 (copy), l__Name__40 (copy), l__TweenService__5 (ref), u3 (ref)
                    local v86 = u84:GetAttribute("RelativePosition");
                    for _, v87 in u70.Balls do
                        if v87.Instance.Name == l__Name__40 then
                            local v88 = l__TweenService__5:Create(u84.Instance, u3, {
                                Transparency = 0
                            });
                            v87.Pocketed = false;
                            v87.Simulate = true;
                            v87.Position = v86;
                            v88:Play();
                            return;
                        end;
                    end;
                end);
            end;
        end;
        if u69 then
            for _, v89 in u70.Balls do
                local v90 = u71:FindFirstChild(v89.Instance.Name);
                if v90 then
                    local v91 = v90:GetAttribute("RelativePosition");
                    if v91 then
                        v89.Position = v91;
                    else
                        print("Could not find relative position when syncing!");
                    end;
                else
                    u70:DeleteBall(v89.Instance);
                end;
            end;
        end;
    end;
    if not u69 then
        u67:CreateDraggableBall(u70.CueBall);
    end;
    p68:Mark(l__RunService__9.RenderStepped:Connect(function(...) --[[ Line: 460 ]]
        -- upvalues: u70 (copy)
        u70:Update(...);
    end));
    u67.CueBall = u70.CueBall;
    u67.Simulator = u70;
    p68:Mark(v77);
    p68:Mark(u70);
    p68:Mark(v80);
end;
function v6.CreateDraggableBall(u92, u93) --[[ Line: 477 ]]
    -- upvalues: l__Pool__8 (copy)
    local u94 = nil;
    local u95 = true;
    local u96 = l__Pool__8.DragIndicator:Clone();
    u96.Adornee = u93.Instance;
    u96.Parent = u93.Instance;
    local u97 = Instance.new("DragDetector");
    u97.Enabled = false;
    u97.RunLocally = true;
    u97.DragStyle = Enum.DragDetectorDragStyle.TranslatePlane;
    u97.ResponseStyle = Enum.DragDetectorResponseStyle.Geometric;
    u97.Parent = u93.Instance;
    u97.DragStart:Connect(function() --[[ Line: 491 ]]
        -- upvalues: u92 (copy), u94 (ref), u93 (copy)
        u92.IsDragging = true;
        u92.MouseHeldDown = false;
        u92.Simulator.Simulation = false;
        u94 = u93.Position;
    end);
    u97.DragContinue:Connect(function() --[[ Line: 498 ]]
        -- upvalues: u95 (ref), u92 (copy), u93 (copy)
        u95 = true;
        for _, v98 in u92.Simulator.Balls do
            local l__Magnitude__41 = (u93.Position - v98.Position).Magnitude;
            if l__Magnitude__41 ~= 0 and l__Magnitude__41 < u92.Simulator.Radius * 2 then
                u95 = false;
                break;
            end;
        end;
        local l__Size__42 = u92.Simulator.Container.Size;
        local l__Radius__43 = u92.Simulator.Radius;
        local l__Radius__44 = u92.Simulator.Radius;
        local v99 = l__Size__42.X - l__Radius__43;
        local l__Radius__45 = u92.Simulator.Radius;
        local v100 = l__Size__42.Z - l__Radius__43;
        local v101 = math.clamp(u93.Instance.Position.X - u92.Simulator.RelativePosition.X, l__Radius__44, v99);
        local v102 = math.clamp(u93.Instance.Position.Z - u92.Simulator.RelativePosition.Z, l__Radius__45, v100);
        local v103 = Vector2.new(v101, v102);
        u93.Instance.Position = u92.Simulator.RelativePosition + Vector3.new(v103.X, l__Radius__43, v103.Y);
        u93.Position = v103;
        u93.Instance.Transparency = u95 and 0 or 0.5;
        u92.MouseHeldDown = false;
    end);
    u97.DragEnd:Connect(function() --[[ Line: 528 ]]
        -- upvalues: u95 (ref), u93 (copy), u94 (ref), u92 (copy)
        if u95 then
            u93.Instance:SetAttribute("IsDraggable", false);
        else
            u93.Position = u94;
        end;
        u93.Instance.Transparency = 0;
        u92.Simulator.Simulation = true;
        task.defer(function() --[[ Line: 537 ]]
            -- upvalues: u92 (ref)
            u92.IsDragging = false;
        end);
        u92.Server:Sync({
            [u93.Instance.Name] = u93.Position
        });
    end);
    u93.Instance:SetAttribute("IsDraggable", false);
    local v105 = u93.Instance:GetAttributeChangedSignal("IsDraggable"):Connect(function() --[[ Line: 545 ]]
        -- upvalues: u93 (copy), u96 (copy), u97 (copy)
        local v104 = u93.Instance:GetAttribute("IsDraggable");
        u96.Enabled = v104;
        u97.Enabled = v104;
    end);
    u92.Maid:Mark(v105);
    u92.Maid:Mark(u96);
    u92.Maid:Mark(u97);
end;
function v6.Hook(u106) --[[ Line: 556 ]]
    -- upvalues: l__LocalPlayer__2 (copy), l__Pool__8 (copy), l__UserInputService__7 (copy), l__CurrentCamera__3 (copy), u14 (copy), u4 (copy), l__RunService__9 (copy)
    local l__Character__46 = l__LocalPlayer__2.Character;
    local l__Humanoid__47 = l__Character__46.Humanoid;
    local l__ServerCue__48 = l__Character__46.ServerCue;
    local v107 = l__Pool__8.Cue:Clone();
    v107.Anchored = true;
    v107.CanCollide = false;
    v107.Parent = l__Character__46;
    u106.MobileControls.Container.MouseButton1Down:Connect(function() --[[ Line: 566 ]]
        -- upvalues: u106 (copy)
        if u106.AllStationary and u106.CanPlay then
            u106.CueFrameHeld = true;
        end;
    end);
    local v109 = l__UserInputService__7.InputBegan:Connect(function(p108, _) --[[ Line: 576 ]]
        -- upvalues: u106 (copy), l__Humanoid__47 (copy)
        if u106.AllStationary and u106.CanPlay then
            if p108.UserInputType == Enum.UserInputType.MouseButton1 or p108.UserInputType == Enum.UserInputType.Touch then
                u106.MouseHeldDown = true;
                u106.MouseHeldPoint = p108.Position;
            else
                if p108.KeyCode == Enum.KeyCode.LeftControl then
                    l__Humanoid__47:SetAttribute("Speed", 0.2);
                end;
            end;
        end;
    end);
    local v112 = l__UserInputService__7.InputChanged:Connect(function(p110, _) --[[ Line: 589 ]]
        -- upvalues: u106 (copy), l__CurrentCamera__3 (ref)
        if p110.UserInputType == Enum.UserInputType.MouseMovement or p110.UserInputType == Enum.UserInputType.Touch then
            u106.MouseDelta = p110.Position - u106.MousePoint;
            u106.MousePoint = p110.Position;
            if u106.AllStationary and u106.MouseHeldDown then
                if not u106.TouchMode then
                    local l__Y__49 = (u106.MouseHeldPoint - u106.MousePoint).Y;
                    if -u106.Cue.CFrame.LookVector:Dot(l__CurrentCamera__3.CFrame.LookVector) < 0 then
                        l__Y__49 = -l__Y__49;
                    end;
                    u106.CueOffset = math.clamp(l__Y__49 / 350, -1, 1);
                    return;
                end;
                local v111 = math.clamp(p110.Position.Y - u106.MouseHeldPoint.Y, -100, 100);
                u106.CueOffset = -math.clamp(v111 / 100, -1, 1);
                u106.CueFramePosition = v111;
            end;
        end;
    end);
    local v114 = l__UserInputService__7.InputEnded:Connect(function(p113, _) --[[ Line: 628 ]]
        -- upvalues: u106 (copy), l__LocalPlayer__2 (ref), u14 (ref), u4 (ref), l__Humanoid__47 (copy)
        if p113.UserInputType == Enum.UserInputType.MouseButton1 or p113.UserInputType == Enum.UserInputType.Touch then
            u106.CueFrameHeld = false;
            u106.MouseHeldDown = false;
            if u14(u106.Simulator.Container, l__LocalPlayer__2.Character.HumanoidRootPart.CFrame.Position) < 5 and (u106.CueOffset < 0 and (u106.CanPlay and u106.AllStationary)) then
                u106.AllStationary = false;
                u106.CueBall.Instance:SetAttribute("IsDraggable", false);
                u4.PlaySound("Pool.Cue");
                u106:ApplyImplusAtAngle(u106.Angle, u106.CueOffset * -100);
            end;
            u106.CueOffset = 0;
        else
            if p113.KeyCode == Enum.KeyCode.RightControl then
                l__Humanoid__47:SetAttribute("Speed", 0.6);
            end;
        end;
    end);
    u106.CueFrameY = 0;
    u106.CueFrameHeld = false;
    u106.AllStationary = true;
    u106.MouseHeldDown = false;
    u106.MousePoint = Vector3.new(0, 0, 0);
    u106.MouseDelta = Vector3.new(0, 0, 0);
    u106.MouseHeldPoint = Vector3.new(0, 0, 0);
    u106.Maid:Mark(v109);
    u106.Maid:Mark(v107);
    u106.Maid:Mark(v112);
    u106.Maid:Mark(v114);
    u106.Maid:Mark(l__RunService__9.RenderStepped:Connect(function(...) --[[ Line: 662 ]]
        -- upvalues: u106 (copy)
        u106:Update(...);
    end));
    u106.Cue = v107;
    u106.ServerCue = l__ServerCue__48;
    u106.RightArmIK = u106:CreateIKControlAndMapTo("Right", v107.Right);
    u106.LeftArmIK = u106:CreateIKControlAndMapTo("Left", v107.Left);
end;
function v6.SpectateStart(u115) --[[ Line: 671 ]]
    local v116 = u115:WatchStateChange("CurrentState", function() --[[ Line: 676 ]]
        -- upvalues: u115 (copy)
        if u115.ReplicatedState.CurrentState == "Started" then
            u115.ScoresUI.Enabled = true;
            u115:UpdatePlayerImage(1);
            u115:UpdatePlayerImage(2);
            u115:Watch(u115.SpectateMaid, true);
        else
            u115.ScoresUI.Enabled = false;
            print("The game has not started");
        end;
    end);
    u115.SpectateMaid:Mark(v116);
end;
function v6.SpectateEnd(p117) --[[ Line: 694 ]]
    local v118 = p117.Instance:FindFirstChild("ServerBalls");
    if v118 then
        for _, v119 in v118:GetChildren() do
            v119.Transparency = 0;
        end;
    end;
end;
function v6.Client.OnSync(p120, p121, p122) --[[ Line: 704 ]]
    for v123, v124 in p121 do
        local v125 = p120.Instance.Balls:FindFirstChild(v123);
        if v125 then
            local v126 = p120.Simulator:GetBallObject(v125);
            v126.Position = v124;
            v126.Velocity = Vector2.zero;
        else
            p120.Simulator:CreateBall(v123, v124);
        end;
    end;
    if p122 then
        for _, v127 in p120.Simulator.Balls do
            if not p121[v127.Instance.Name] then
                p120.Simulator:DeleteBall(v127.Instance);
            end;
        end;
    end;
end;
function v6.Client.AllowDrag(p128) --[[ Line: 728 ]]
    p128.CueBall.Instance:SetAttribute("IsDraggable", true);
end;
function v6.Enter(u129) --[[ Line: 732 ]]
    -- upvalues: u5 (copy), l__LocalPlayer__2 (copy), l__Pool__8 (copy), l__Mince__10 (copy)
    u129:StartInspect("Waiting for players..");
    u5.StartInteractions();
    local l__Character__50 = l__LocalPlayer__2.Character;
    local l__Animator__51 = l__Character__50.Humanoid.Animator;
    u129.Animations = {
        Win = l__Animator__51:LoadAnimation(script.Victory),
        Lose = l__Animator__51:LoadAnimation(script.Defeat),
        Idle = l__Animator__51:LoadAnimation(l__Pool__8.Idle)
    };
    local v131 = l__Character__50.ChildAdded:Connect(function(p130) --[[ Line: 746 ]]
        -- upvalues: u129 (copy)
        if p130.Name == "ServerCue" then
            u129:Hook();
        end;
    end);
    if l__Mince__10.Config.Humanoid then
        l__Mince__10.Config.Humanoid:UnequipTools();
    end;
    u129.Maid:Mark(v131);
end;
function v6.Start(u132) --[[ Line: 761 ]]
    -- upvalues: u5 (copy), l__LocalPlayer__2 (copy), u1 (copy), l__Pool__8 (copy), u4 (copy)
    u132:StopInspect();
    u5.StartInteractions();
    l__LocalPlayer__2.Character.Humanoid:SetAttribute("Speed", 0.6);
    local v133 = u1.GetMode();
    local u134 = u132:GetLocalSlot();
    local u135 = true;
    if not u134 then
        error("Could not retrieve your slot!");
    end;
    u132.MobileControls.Enabled = true;
    if v133 == "VR" or v133 == "Mobile" then
        u132.MobileControls.Container.Visible = true;
        u132.MobileControls.Power.Visible = false;
        u132.TouchMode = true;
    else
        u132.MobileControls.Container.Visible = false;
        u132.MobileControls.Power.Visible = true;
        u132.TouchMode = false;
    end;
    u132:Watch(u132.Maid, false);
    u132.Trajectory = l__Pool__8.Trajectory:Clone();
    u132.Trajectory.Parent = u132.Instance;
    u132.Maid:Mark(u132.Trajectory);
    local v137 = u132:WatchStateChange("Turn", function() --[[ Line: 796 ]]
        -- upvalues: u132 (copy), u134 (copy), u4 (ref), u135 (ref)
        local l__Turn__52 = u132.ReplicatedState.Turn;
        local v136 = u132.Slots[l__Turn__52];
        if v136 then
            u132.Turn = l__Turn__52;
            u132.CanPlay = u132.Turn == u134;
            if u132.CanPlay then
                u132.Animations.Idle:Play();
            else
                u132.Animations.Idle:Stop();
                u132.CueBall.Instance:SetAttribute("IsDraggable", false);
            end;
            u4.PlaySound("Pool.TurnChange");
            u132:TimedInspect(`It's {v136.Name}'s turn!`, 3);
            u135 = false;
        end;
    end);
    for v138 = 1, 2 do
        u132:UpdatePlayerImage(v138);
        u132:UpdatePlayerScore(v138, {});
    end;
    u132.ScoresUI.Enabled = true;
    u132.Maid:Mark(v137);
end;
function v6.Complete(u139, p140, p141) --[[ Line: 826 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u4 (copy)
    warn("Completion!", p140, p141);
    u139.UpdateOpponent = false;
    u139.CanPlay = false;
    if p141 == "Draw" then
        u139:TimedInspect("It\'s a tie!", 3);
    elseif p141:IsA("Player") then
        u139:TimedInspect(`The winner of this game is {p141.Name}!`, 3);
    end;
    local _ = l__LocalPlayer__2.Character.Humanoid.Animator;
    if p141 == l__LocalPlayer__2 then
        u4.PlaySound("TicTacToe.Win");
        u139.Animations.Win:Play();
    else
        u4.PlaySound("TicTacToe.Lose");
        u139.Animations.Lose:Play();
    end;
    task.wait(1);
    local v142 = u139:GetFirstOpponent();
    if v142 then
        local l__Character__53 = v142.Character;
        if l__Character__53 then
            l__Character__53 = v142.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__53 then
            local u143 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__53.Position);
            task.spawn(function() --[[ Line: 862 ]]
                -- upvalues: u139 (copy), u143 (copy)
                u139:CameraPan(u143);
            end);
        end;
    end;
end;
function v6.Exit(p144) --[[ Line: 871 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u5 (copy)
    local l__Humanoid__54 = l__LocalPlayer__2.Character.Humanoid;
    l__Humanoid__54:SetAttribute("Speed", 1);
    l__Humanoid__54.AutoRotate = true;
    u5.EndInteractions();
    p144:DistanceLinearRevertCamera();
    p144:UnlockPlayerMovement();
    p144.Animations.Idle:Stop();
    p144.ScoresUI.Enabled = false;
    p144.MobileControls.Enabled = false;
end;
return v6;
