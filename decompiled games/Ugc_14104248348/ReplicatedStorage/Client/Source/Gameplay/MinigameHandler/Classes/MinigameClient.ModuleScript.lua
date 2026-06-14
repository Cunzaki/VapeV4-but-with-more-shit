-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Classes.MinigameClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
local l__LocalPlayer__5 = l__Players__4.LocalPlayer;
local l__Case__6 = require(l__ReplicatedStorage__1.Modules.Case);
local l__Maid__7 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__8 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Queue);
local l__Signal__9 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Utility__10 = require(l__ReplicatedStorage__1.Modules.Utility);
local l__microid__11 = require(l__ReplicatedStorage__1.Modules.microid);
local u1 = require(l__ReplicatedStorage__1.Modules.Mutex).new();
local u2 = l__Mince__8:Get("Effects");
local u3 = l__Mince__8:Get("Locomotion");
local u4 = l__Mince__8:Get("TriggerHandler");
local u5 = l__Mince__8:Get("AnalyticsTracker");
local u6 = l__Mince__8:Get("MinigameHandler");
local u7 = l__Mince__8:GetEvent("UnreliableMinigameServer");
local v8 = l__Mince__8:GetEvent("NewMinigameMain");
local u9 = v8:Extend("Join");
local u10 = v8:Extend("Leave");
local u11 = v8:Extend("Server");
v8:Extend("Completed");
function QuadBezier(p12, p13, p14, p15)
    return p13:Lerp(p14, p12):Lerp(p14:Lerp(p15, p12), p12);
end;
local v16 = {
    ExitCameraSpeedMult = 1.25,
    CameraStudsPerSecond = 48,
    MinimumCameraDistanceVariable = 22,
    MaximumCameraDistanceVariable = 40
};
v16.__index = v16;
local u17 = {
    __index = v16
};
local u18 = {};
function v16.new(p19, p20) --[[ Line: 64 ]]
    -- upvalues: u17 (copy)
    local v21 = setmetatable(p19 or {}, u17);
    v21:Init(p20);
    return v21;
end;
function v16.Init(u22, p23) --[[ Line: 70 ]]
    -- upvalues: l__microid__11 (copy), l__Signal__9 (copy), l__Case__6 (copy), l__Maid__7 (copy), u4 (copy), u5 (copy), u6 (copy), l__Utility__10 (copy), l__LocalPlayer__5 (copy), l__Players__4 (copy), u7 (copy), u11 (copy)
    local v24 = p23:IsA("Model");
    assert(v24, "Minigames must have a physical location, this is while it must be a model!");
    u22.ExistanceID = l__microid__11.gent();
    u22.Instance = p23;
    u22.QueueChanged = l__Signal__9.new();
    u22.AysncStart = l__Signal__9.new();
    u22.AsyncEnding = l__Signal__9.new();
    u22.AsyncEnter = l__Signal__9.new();
    u22.AsyncExit = l__Signal__9.new();
    u22.OpCase = l__Case__6.new();
    u22.CameraAnimatingCase = u22.OpCase:Extend();
    u22.Queue = {};
    u22.Slots = {};
    u22.Prompts = {};
    u22.Maid = l__Maid__7.new();
    u22.JoinMaid = l__Maid__7.new();
    u22.SpectateMaid = l__Maid__7.new();
    u22.BaseJump = nil;
    u22.LastQueue = {};
    u22.StateChanged = u22:SubState("ReplicatedState");
    u22.StateChangeIndexEvents = {};
    u22.Trigger = u4.PsudeoTrigger(u22.Instance:GetPivot(), Vector3.new(25, 25, 25), {
        Name = u22.ExistanceID
    });
    u22.Trigger.Entered:Connect(function() --[[ Line: 105 ]]
        -- upvalues: u22 (copy)
        u22.IsPhysicallyWithinSpectateRange = true;
        u22:StartSpectate();
    end);
    u22.Trigger.Exited:Connect(function() --[[ Line: 110 ]]
        -- upvalues: u22 (copy)
        u22.IsPhysicallyWithinSpectateRange = false;
        u22:EndSpectate();
    end);
    u22.Handler.MinigameEntered:Connect(function() --[[ Line: 116 ]]
        -- upvalues: u22 (copy)
        u22:EndSpectate();
    end);
    u22.AysncStart:Connect(function() --[[ Line: 120 ]]
        -- upvalues: u5 (ref), u22 (copy), u6 (ref)
        u5.MinigameEntered(u22.Name, true);
        u6.WithinMinigame = true;
    end);
    u22.AsyncExit:Connect(function() --[[ Line: 125 ]]
        -- upvalues: u5 (ref), u22 (copy), u6 (ref)
        u5.MinigameEntered(u22.Name, false);
        u6.WithinMinigame = false;
    end);
    u22.StateChanged:Connect(function(p25, p26) --[[ Line: 131 ]]
        -- upvalues: u22 (copy), l__Utility__10 (ref), l__LocalPlayer__5 (ref)
        if u22.StateChangeIndexEvents[p25] then
            u22.StateChangeIndexEvents[p25]:Fire(p26);
        end;
        if p25 == "Started" then
            if p26 then
                u22.LastQueue = l__Utility__10.Deepcopy(u22.Queue);
                if u22.Queue[l__LocalPlayer__5] then
                    u22:EndSpectate();
                    if u22.Start then
                        if u22.IsAsyncEnding then
                            warn("holding up startrintg");
                            u22.AsyncEnding:Wait();
                        end;
                        u22.IsAsyncStarting = true;
                        local v27, v28 = pcall(function() --[[ Line: 153 ]]
                            -- upvalues: u22 (ref)
                            return u22:Start();
                        end);
                        u22.IsAsyncStarting = false;
                        u22.AysncStart:Fire();
                        if not v27 then
                            warn("Important! Error! Minigame! when starting");
                            warn(v28);
                        end;
                    end;
                end;
            elseif u22.LastQueue[l__LocalPlayer__5] then
                u22.Maid:Sweep();
                if u22.End then
                    if u22.IsAsyncStarting then
                        warn("holding up ending");
                        u22.AysncStart:Wait();
                    end;
                    u22.IsAsyncEnding = true;
                    local v29, v30 = pcall(function() --[[ Line: 184 ]]
                        -- upvalues: u22 (ref)
                        return u22:End();
                    end);
                    u22.IsAsyncEnding = false;
                    u22.AsyncEnding:Fire();
                    if not v29 then
                        warn("Important! Error! Minigame! when exiting");
                        warn(v30);
                    end;
                end;
            end;
        end;
    end);
    u22:SubState("ReplicatedQueue"):Connect(function(p31, p32) --[[ Line: 202 ]]
        -- upvalues: l__Players__4 (ref), u22 (copy), l__LocalPlayer__5 (ref)
        local v33 = { tostring(p31):gsub("_", "-") };
        local v34 = tonumber(v33[1]);
        if v34 then
            local v35 = l__Players__4:GetPlayerByUserId(v34);
            local v36 = tonumber(p32);
            if p32 then
                if v36 then
                    u22.Queue[v35] = v36;
                    u22.Slots[v36] = v35;
                else
                    u22.Queue[v35] = p32;
                end;
            else
                local v37 = tonumber(u22.Queue[v35]);
                if v37 then
                    u22.Queue[v35] = nil;
                    u22.Slots[v37] = nil;
                else
                    u22.Queue[v35] = nil;
                end;
            end;
            if v35 == l__LocalPlayer__5 then
                if p32 then
                    u22.Handler.MinigameEntered:Fire(u22);
                    if u22.Enter then
                        if u22.IsAsyncExiting then
                            warn("holding up entering!");
                            u22.AsyncExit:Wait();
                        end;
                        u22.IsAsyncEnterting = true;
                        local _, _ = pcall(function() --[[ Line: 239 ]]
                            -- upvalues: u22 (ref)
                            return u22:Enter();
                        end);
                        u22.IsAsyncEnterting = false;
                        u22.AsyncEnter:Fire();
                    end;
                else
                    u22.Handler.MinigameExited:Fire(u22);
                    if u22.Exit then
                        if u22.IsAsyncEnterting then
                            warn("holding up exit!");
                            u22.AsyncEnter:Wait();
                        end;
                        u22.IsAsyncExiting = true;
                        u22:Exit();
                        u22.IsAsyncExiting = false;
                        u22.AsyncExit:Fire();
                    end;
                    u22.Handler.StopInspectText();
                    if u22.IsPhysicallyWithinSpectateRange and not u22.IsSpectating then
                        u22:StartSpectate();
                    end;
                end;
            end;
            u22.QueueChanged:Fire();
        end;
    end);
    u22.Server = setmetatable({}, {
        __index = function(p38, u39) --[[ Name: __index, Line 272 ]]
            -- upvalues: u7 (ref), u22 (copy), u11 (ref)
            rawset(p38, u39, function(_, ...) --[[ Line: 273 ]]
                -- upvalues: u39 (copy), u7 (ref), u22 (ref), u11 (ref)
                if u39:match("Unreliable") then
                    u39:gsub("Unreliable", "");
                    u7:Fire(u22.Instance, u39, ...);
                else
                    u11:Fire(u22.Instance, u39, ...);
                end;
            end);
            return rawget(p38, u39);
        end
    });
end;
function v16.StartSpectate(u40) --[[ Line: 287 ]]
    if u40:LocalPlayerIn() then
    else
        if u40.SpectateStart then
            local v41, v42 = pcall(function() --[[ Line: 291 ]]
                -- upvalues: u40 (copy)
                return u40:SpectateStart();
            end);
            if not v41 then
                warn("[Minigame]: Failure occured when entering spectate!");
                warn(v42);
            end;
        end;
        if u40.Handler.PlayerIsLocallyInMinigame then
        else
            u40.LocalPlayerWatching = true;
            u40.IsSpectating = true;
        end;
    end;
end;
function v16.EndSpectate(u43) --[[ Line: 307 ]]
    if u43.LocalPlayerWatching then
        if u43.SpectateEnd then
            local v44, v45 = pcall(function() --[[ Line: 311 ]]
                -- upvalues: u43 (copy)
                return u43:SpectateEnd();
            end);
            if not v44 then
                warn("[Minigame]: Failure occured when exitign Spectate!");
                warn(v45);
            end;
        end;
        u43.Handler.StopInspectText();
        u43.SpectateMaid:Sweep();
        u43.LocalPlayerWatching = false;
        u43.IsSpectating = false;
    end;
end;
function v16.TimedInspect(p46, p47, p48) --[[ Line: 329 ]]
    if p46:LocalPlayerIn() or p46.LocalPlayerWatching then
        p46.Handler.TimedInspectText(p47, p48);
    end;
end;
function v16.StartInspect(p49, p50) --[[ Line: 335 ]]
    if p49:LocalPlayerIn() or p49.LocalPlayerWatching then
        p49.Handler.StartInspectText(p50);
    end;
end;
function v16.StopInspect(p51) --[[ Line: 341 ]]
    if p51:LocalPlayerIn() or p51.LocalPlayerWatching then
        p51.Handler.StopInspectText();
    end;
end;
function v16.WatchStateChange(p52, p53, p54) --[[ Line: 348 ]]
    if p52.ReplicatedState[p53] then
        task.defer(p54, p52.ReplicatedState[p53]);
    end;
    return p52:GetStateChangedSignal(p53):Connect(p54);
end;
function v16.GetStateChangedSignal(p55, p56) --[[ Line: 356 ]]
    -- upvalues: l__Signal__9 (copy)
    local v57 = p55.StateChangeIndexEvents[p56];
    if not v57 then
        v57 = l__Signal__9.new();
        p55.StateChangeIndexEvents[p56] = v57;
    end;
    return v57;
end;
function v16.GetFirstOpponent(p58) --[[ Line: 368 ]]
    -- upvalues: l__LocalPlayer__5 (copy)
    for v59, _ in p58.Queue do
        if v59 ~= l__LocalPlayer__5 then
            return v59;
        end;
    end;
end;
function v16.GetSlot(p60, p61) --[[ Line: 376 ]]
    return p60.Queue[p61];
end;
function v16.GetLocalSlot(p62) --[[ Line: 380 ]]
    -- upvalues: l__LocalPlayer__5 (copy)
    return p62.Queue[l__LocalPlayer__5];
end;
function v16.LocalPlayerIn(p63) --[[ Line: 384 ]]
    -- upvalues: l__LocalPlayer__5 (copy)
    return p63.Queue[l__LocalPlayer__5] ~= nil;
end;
function v16.SubState(u64, u65) --[[ Line: 388 ]]
    -- upvalues: l__Signal__9 (copy)
    local u66 = l__Signal__9.new();
    local u67 = u64.Instance:WaitForChild(u65);
    u64[u65] = u67:GetAttributes();
    u67.AttributeChanged:Connect(function(p68) --[[ Line: 392 ]]
        -- upvalues: u64 (copy), u65 (copy), u67 (copy), u66 (copy)
        u64[u65][p68] = u67:GetAttribute(p68);
        u66:Fire(p68, u67:GetAttribute(p68));
    end);
    task.defer(function() --[[ Line: 398 ]]
        -- upvalues: u64 (copy), u65 (copy), u66 (copy)
        for v69, v70 in u64[u65] do
            u66:Fire(v69, v70);
        end;
    end);
    return u66;
end;
function v16.Leave(p71) --[[ Line: 408 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u10 (copy)
    if not p71.Queue[l__LocalPlayer__5] then
        warn("You can\'t leave something your not in !");
        return false;
    end;
    u10:Fire(p71.Instance);
    p71.JoinMaid:Sweep();
    for _, v72 in p71.Prompts do
        v72.Enabled = true;
    end;
    return true;
end;
function v16.Join(u73, p74) --[[ Line: 425 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u9 (copy)
    if u73.ValidateClientEntry then
        local v75, v76 = pcall(function() --[[ Line: 428 ]]
            -- upvalues: u73 (copy)
            return u73:ValidateClientEntry();
        end);
        if not v75 then
            warn("Blocking Join because ValidateClientEntry() failed!");
            warn(v76);
            return false;
        end;
        if not v76 then
            return false;
        end;
    end;
    local v77 = u73.Handler.HasPlayerSeenTutorial(u73);
    if u73.Queue[l__LocalPlayer__5] or not v77 then
        if not v77 then
            u73.Handler.Present(u73);
        end;
        warn("prevented form joining again locally!");
        return false;
    end;
    if u73.Handler.TutorialIsVisible() then
        return false;
    end;
    u9:Fire(u73.Instance, p74);
    for _, v78 in u73.Prompts do
        v78.Enabled = false;
    end;
    return true;
end;
function v16.UnhideLocalPlayer(_) --[[ Line: 470 ]]
    -- upvalues: u1 (copy), l__RunService__3 (copy), l__LocalPlayer__5 (copy)
    u1:within(function() --[[ Line: 471 ]]
        -- upvalues: l__RunService__3 (ref), l__LocalPlayer__5 (ref)
        l__RunService__3:UnbindFromRenderStep("CharacterTransparency");
        if l__LocalPlayer__5.Character then
            for _, v79 in l__LocalPlayer__5.Character:GetDescendants() do
                if v79:IsA("BasePart") then
                    v79.LocalTransparencyModifier = 0;
                elseif v79:IsA("Decal") then
                    v79.Transparency = 0;
                end;
            end;
        end;
        task.wait();
    end);
end;
function v16.HideLocalPlayer(_) --[[ Line: 487 ]]
    -- upvalues: u1 (copy), l__RunService__3 (copy), l__LocalPlayer__5 (copy)
    u1:within(function() --[[ Line: 489 ]]
        -- upvalues: l__RunService__3 (ref), l__LocalPlayer__5 (ref)
        l__RunService__3:UnbindFromRenderStep("CharacterTransparency");
        l__RunService__3:BindToRenderStep("CharacterTransparency", Enum.RenderPriority.Character.Value - 5, function() --[[ Line: 491 ]]
            -- upvalues: l__LocalPlayer__5 (ref)
            if l__LocalPlayer__5.Character then
                for _, v80 in l__LocalPlayer__5.Character:GetDescendants() do
                    if v80:IsA("BasePart") then
                        v80.LocalTransparencyModifier = 1;
                    elseif v80:IsA("Decal") then
                        v80.Transparency = 1;
                    end;
                end;
            end;
        end);
        task.wait();
    end);
end;
function v16.UnlockPlayerMovement(_) --[[ Line: 507 ]]
    -- upvalues: u3 (copy), l__Mince__8 (copy)
    u3.PopCaptures();
    local l__Humanoid__12 = l__Mince__8.Config.Humanoid;
    u3.SetEnabled(true);
    if l__Humanoid__12 then
        l__Humanoid__12.Sit = false;
        l__Humanoid__12:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
    end;
end;
function v16.SyncMovementToLeave(u81) --[[ Line: 517 ]]
    -- upvalues: u3 (copy)
    u3.SetEnabled(false);
    local v82 = u3.Capture(0.5, u81.Settings.IgnoreMovement):Connect(function() --[[ Line: 519 ]]
        -- upvalues: u3 (ref), u81 (copy)
        u3.SetEnabled(false);
        if not u81:Leave() then
            u3.SetEnabled(true);
        end;
    end);
    u81.JoinMaid:Mark(v82);
end;
function v16.SyncBoundryToLeave(u83, u84, p85) --[[ Line: 530 ]]
    -- upvalues: u18 (copy), u4 (copy), u3 (copy)
    print(u84, p85);
    local v86 = u18[u84];
    if not v86 then
        v86 = u4.TriggerFromPart(u84);
        u18[u84] = v86;
    end;
    local function u89(p87) --[[ Line: 541 ]]
        -- upvalues: u84 (copy)
        for _, v88 in u84:GetChildren() do
            if v88:IsA("Beam") then
                v88.Enabled = p87;
            end;
        end;
    end;
    u89(true);
    local v91 = v86.Exited:ConnectOnce(function() --[[ Line: 553 ]]
        -- upvalues: u83 (copy), u89 (copy), u3 (ref)
        local v90 = u83:Leave();
        u89(false);
        if not v90 then
            u3.SetEnabled(true);
        end;
    end);
    u83.JoinMaid:Mark(v91);
end;
function v16.WalkToPositionThenWait(_, p92, p93) --[[ Line: 565 ]]
    -- upvalues: l__Mince__8 (copy), u3 (copy), l__TweenService__2 (copy)
    if l__Mince__8.Config.Humanoid then
        if l__Mince__8.Config.HumanoidRootPart then
            local u94 = coroutine.running();
            local u95 = false;
            local l__Humanoid__13 = u3.Humanoid;
            local l__HumanoidRootPart__14 = l__Mince__8.Config.HumanoidRootPart;
            local u96 = p93.Rotation * CFrame.Angles(0, -1.5707963267948966, 0);
            u3.SetEnabled(false);
            u3.SetUpdating(false);
            l__Humanoid__13.WalkSpeed = 16;
            local function v97() --[[ Line: 578 ]]
                -- upvalues: u95 (ref), u94 (copy)
                if u95 then
                else
                    u95 = true;
                    task.spawn(u94);
                end;
            end;
            l__Humanoid__13.MoveToFinished:Once(v97);
            l__Humanoid__13:MoveTo(p92);
            task.delay(5, v97);
            coroutine.yield();
            task.spawn(function() --[[ Line: 590 ]]
                -- upvalues: l__HumanoidRootPart__14 (copy), u96 (ref), l__TweenService__2 (ref)
                local l__Rotation__15 = l__HumanoidRootPart__14.CFrame.Rotation;
                local v98 = 0;
                local v99 = 0.5;
                repeat
                    v98 = v98 + task.wait();
                    l__HumanoidRootPart__14.CFrame = CFrame.new(l__HumanoidRootPart__14.Position) * l__Rotation__15:Lerp(u96, l__TweenService__2:GetValue(v98 / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In));
                until v99 < v98;
            end);
            u3.SetEnabled(true);
            u3.SetUpdating(true);
            task.wait();
        end;
    end;
end;
function v16.AddProximityJoinSource(u100, u101, u102, u103) --[[ Line: 607 ]]
    -- upvalues: l__LocalPlayer__5 (copy)
    assert(u102, "Slot required for this joinsource.");
    local u104 = Instance.new("ProximityPrompt");
    u104:SetAttribute("Type", "Radial");
    u104:SetAttribute("Override", false);
    u104.ObjectText = "Play";
    u104.MaxActivationDistance = 5;
    u104.Style = Enum.ProximityPromptStyle.Custom;
    u104.RequiresLineOfSight = true;
    u104.Parent = u101;
    table.insert(u100.Prompts, u104);
    u104.Triggered:Connect(function() --[[ Line: 621 ]]
        -- upvalues: u100 (copy), l__LocalPlayer__5 (ref), u102 (copy), u101 (copy), u103 (copy)
        if u100.OpCase:GetValue() then
            if u100.Queue[l__LocalPlayer__5] then
            else
                if u100:Join(u102) then
                    u100:WalkToPositionThenWait(u101:IsA("Attachment") and u101.WorldPosition or u101.Position, u101:IsA("Attachment") and u101.WorldCFrame.Rotation or u101.CFrame.Rotation);
                    if u103 then
                        u100:SyncBoundryToLeave(u103);
                        return;
                    end;
                    u100:SyncMovementToLeave();
                end;
            end;
        end;
    end);
    u100.QueueChanged:Connect(function() --[[ Line: 637 ]]
        -- upvalues: u100 (copy), u104 (copy), u102 (copy)
        if not u100.Handler.PlayerIsLocallyInMinigame then
            u104.Enabled = u100.Slots[u102] == nil;
        end;
    end);
end;
function v16.AddSeatJoinSource(u105, u106, u107) --[[ Line: 646 ]]
    -- upvalues: l__Mince__8 (copy), l__LocalPlayer__5 (copy)
    local v108 = `Slot required for this joinsource. {u106:GetFullName()}`;
    assert(u107, v108);
    local l__Camera__16 = u106.Camera;
    local l__WorldCFrame__17 = l__Camera__16.WorldCFrame;
    local v109 = Instance.new("Part");
    v109.Name = u107;
    v109.Anchored = true;
    v109.Transparency = 1;
    v109.CanCollide = false;
    v109.Position = u106.Position + Vector3.new(0, 1.5, 0);
    v109.Size = Vector3.new(0.1, 0.1, 0.1);
    v109.Parent = u106.Parent;
    u106.Name = "Seat";
    u106.Transparency = 1;
    u106.Disabled = true;
    u106.Parent = v109;
    l__Camera__16.Parent = v109;
    l__Camera__16.WorldCFrame = l__WorldCFrame__17;
    v109:AddTag("Seat");
    local function v110() --[[ Line: 673 ]]
        -- upvalues: l__Mince__8 (ref), u106 (copy), u105 (copy), l__LocalPlayer__5 (ref), u107 (copy)
        local l__Humanoid__18 = l__Mince__8.Config.Humanoid;
        local l__Occupant__19 = u106.Occupant;
        if l__Occupant__19 and l__Occupant__19 == l__Humanoid__18 then
            if l__Humanoid__18.Health == 0 then
                return;
            end;
            if u105.Queue[l__LocalPlayer__5] then
                return;
            end;
            local _ = l__Occupant__19.Parent;
            if not u105.BaseJump then
                u105.BaseJump = l__Humanoid__18.JumpHeight;
            end;
            if u105:Join(u107) then
                l__Humanoid__18:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
                u105:SyncMovementToLeave();
                return;
            end;
            l__Humanoid__18.Sit = false;
        end;
    end;
    u106:GetPropertyChangedSignal("Occupant"):Connect(v110);
end;
function v16.CameraPan(p111, p112, p113) --[[ Line: 708 ]]
    -- upvalues: u2 (copy), l__TweenService__2 (copy)
    local l__CurrentCamera__20 = game.Workspace.CurrentCamera;
    local v114 = l__CurrentCamera__20:GetRenderCFrame();
    u2.SetCameraEffectsEnabled(false);
    p111.CameraAnimatingCase:Set(false);
    local v115 = 0;
    local v116 = p113 or 0.5;
    repeat
        v115 = v115 + task.wait();
        l__CurrentCamera__20.CFrame = v114:Lerp(p112, (l__TweenService__2:GetValue(math.clamp(v115 / v116, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out)));
    until v116 < v115;
    l__CurrentCamera__20.CFrame = p112;
    p111.CameraAnimatingCase:Set(true);
end;
function v16.DistanceRoundedCameraPan(p117, p118) --[[ Line: 729 ]]
    -- upvalues: u2 (copy), l__TweenService__2 (copy)
    local l__CurrentCamera__21 = game.Workspace.CurrentCamera;
    local v119 = l__CurrentCamera__21:GetRenderCFrame();
    u2.SetCameraEffectsEnabled(false);
    l__CurrentCamera__21.CameraType = Enum.CameraType.Scriptable;
    p117.LastStartingCFrame = v119;
    if l__CurrentCamera__21.CameraSubject:IsA("Humanoid") then
        local l__Parent__22 = l__CurrentCamera__21.CameraSubject.Parent;
        if l__Parent__22 then
            l__Parent__22 = l__Parent__22:FindFirstChild("HumanoidRootPart");
        end;
        if l__Parent__22 then
            p117.LastRelativeCFrame = CFrame.new(l__Parent__22.Position + l__CurrentCamera__21.CameraSubject.CameraOffset):ToObjectSpace(v119);
        end;
    end;
    local l__Position__23 = v119.Position;
    local l__Position__24 = p118.Position;
    local v120 = l__Position__23 * Vector3.new(1, 0, 1) + l__Position__24 * Vector3.new(0, 1, 0);
    local v121 = math.clamp((l__Position__23 - l__Position__24).Magnitude, p117.MinimumCameraDistanceVariable, p117.MaximumCameraDistanceVariable);
    local l__Rotation__25 = v119.Rotation;
    local l__Rotation__26 = p118.Rotation;
    p117.CameraAnimatingCase:Set(false);
    local v122 = 1 / p117.CameraStudsPerSecond * v121;
    local v123 = 0;
    repeat
        v123 = v123 + task.wait();
        local v124 = l__TweenService__2:GetValue(math.clamp(v123 / v122, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        l__CurrentCamera__21.CFrame = CFrame.new(QuadBezier(v124, l__Position__23, v120, l__Position__24)) * l__Rotation__25:Lerp(l__Rotation__26, v124);
    until v122 < v123;
    l__CurrentCamera__21.CFrame = p118;
    p117.CameraAnimatingCase:Set(true);
end;
function v16.DistanceLinearRevertCamera(p125) --[[ Line: 779 ]]
    -- upvalues: u2 (copy), l__Mince__8 (copy), l__TweenService__2 (copy)
    u2.SetCameraEffectsEnabled(true);
    if not p125.LastStartingCFrame then
        return;
    end;
    local l__CurrentCamera__27 = game.Workspace.CurrentCamera;
    local l__HumanoidRootPart__28 = l__Mince__8.Config.HumanoidRootPart;
    if not l__HumanoidRootPart__28 then
        l__CurrentCamera__27.CameraType = Enum.CameraType.Custom;
        return;
    end;
    local v126 = l__CurrentCamera__27:GetRenderCFrame();
    local l__LastStartingCFrame__29 = p125.LastStartingCFrame;
    local v127 = math.clamp((v126.Position - l__LastStartingCFrame__29.Position).Magnitude, p125.MinimumCameraDistanceVariable, p125.MaximumCameraDistanceVariable);
    p125.CameraAnimatingCase:Set(false);
    local v128 = 1 / p125.CameraStudsPerSecond * v127 * p125.ExitCameraSpeedMult;
    local v129 = 0;
    while true do
        v129 = v129 + task.wait();
        local v130 = l__TweenService__2:GetValue(math.clamp(v129 / v128, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        if p125.LastRelativeCFrame and l__HumanoidRootPart__28 then
            l__LastStartingCFrame__29 = CFrame.new(l__HumanoidRootPart__28.Position):ToWorldSpace(p125.LastRelativeCFrame);
        end;
        l__CurrentCamera__27.CFrame = v126:Lerp(l__LastStartingCFrame__29, v130);
        if v128 < v129 then
            p125.CameraAnimatingCase:Set(true);
            l__CurrentCamera__27.CameraType = Enum.CameraType.Custom;
            return;
        end;
    end;
end;
return v16;
