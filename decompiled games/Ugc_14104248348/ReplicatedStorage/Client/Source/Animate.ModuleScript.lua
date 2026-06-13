-- Decompiled from: ReplicatedStorage.Client.Source.Animate
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Deepcopy__3 = require(l__ReplicatedStorage__1.Modules.Deepcopy);
require(l__ReplicatedStorage__1.Modules.Mince):Get("");
local u1 = {
    DefaultWeight = 10,
    Enabled = false,
    RetrieveAnimationsFromHumanoidDescription = true,
    KeyFrameConnection = nil,
    WalkSpeed = 16,
    WalkBaseSpeed = 16,
    SprintSpeed = 26,
    WalkSpeedDecimal = 0.06666666666666667,
    RunSpeedDecimal = 0.034482758620689655,
    ClimbSpeedDecimal = 0.2,
    CurrentAnimationSpeed = 1,
    AnimationList = {
        Idle = {
            {
                Asset = "http://www.roblox.com/asset/?id=507766388",
                Weight = 9
            }
        },
        Walk = {
            {
                Asset = "http://www.roblox.com/asset/?id=913402848",
                Weight = 10
            }
        },
        Run = {
            {
                Asset = "rbxassetid://11482387778",
                Weight = 10
            }
        },
        Jump = {
            {
                Asset = "http://www.roblox.com/asset/?id=507765000",
                Weight = 10
            }
        },
        Fall = {
            {
                Asset = "http://www.roblox.com/asset/?id=507767968",
                Weight = 10
            }
        },
        Climb = {
            {
                Asset = "http://www.roblox.com/asset/?id=507765644",
                Weight = 10
            }
        }
    },
    OverwriteAnimations = {
        Idle = "IdleAnimation",
        Walk = "WalkAnimation",
        Jump = "JumpAnimation",
        Fall = "FallAnimation",
        Climb = "ClimbAnimation"
    },
    DefaultWeightOveride = {
        Idle = 9
    },
    AnimationInstances = {},
    DefaultTimers = {
        JumpTime = 0.3
    }
};
function u1.NewCharacter(p2) --[[ Line: 55 ]]
    -- upvalues: u1 (copy), l__Deepcopy__3 (copy)
    u1.Timers = l__Deepcopy__3(u1.DefaultTimers);
    local l__Humanoid__4 = p2:WaitForChild("Humanoid");
    local l__BaseSpeed__5 = l__Humanoid__4:WaitForChild("BaseSpeed");
    l__BaseSpeed__5:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 61 ]]
        -- upvalues: u1 (ref), l__BaseSpeed__5 (copy)
        u1.BaseSpeed = l__BaseSpeed__5.Value;
    end);
    u1.BaseSpeed = l__BaseSpeed__5.Value;
    u1.Character = p2;
    u1.Humanoid = l__Humanoid__4;
    l__Humanoid__4.Running:Connect(u1.OnRunning);
    l__Humanoid__4.Jumping:Connect(u1.OnJumping);
    l__Humanoid__4.FreeFalling:connect(u1.OnFreeFall);
    l__Humanoid__4.Climbing:connect(u1.OnClimbing);
    l__Humanoid__4.Swimming:connect(u1.OnSwimming);
    l__Humanoid__4.GettingUp:connect(function() --[[ Line: 74 ]]
        -- upvalues: u1 (ref)
        u1.SetPose("GettingUp");
    end);
    l__Humanoid__4.FallingDown:connect(function() --[[ Line: 77 ]]
        -- upvalues: u1 (ref)
        u1.SetPose("FallingDown");
    end);
    l__Humanoid__4.Seated:connect(function() --[[ Line: 80 ]]
        -- upvalues: u1 (ref)
        u1.SetPose("Seated");
    end);
    l__Humanoid__4.PlatformStanding:connect(function() --[[ Line: 83 ]]
        -- upvalues: u1 (ref)
        u1.SetPose("PlatformStanding");
    end);
    u1.UpdateThread = task.spawn(function() --[[ Line: 87 ]]
        -- upvalues: u1 (ref)
        while true do
            local v3 = task.wait(0.1);
            u1.UponUpdate(v3);
        end;
    end);
    u1.SetupTracks();
    u1.SetPose("Idle");
end;
function u1.ResetTimer(p4) --[[ Line: 99 ]]
    -- upvalues: u1 (copy)
    u1.Timers[p4] = u1.DefaultTimers[p4];
end;
function u1.OnRunning(p5) --[[ Line: 103 ]]
    -- upvalues: u1 (copy)
    local v6 = u1.Humanoid.MoveDirection == Vector3.new(0, 0, 0) and u1.WalkSpeed or 0.01;
    u1.WalkSpeed = u1.Humanoid.WalkSpeed;
    if v6 < p5 then
        if u1.WalkBaseSpeed + 2 < p5 then
            u1.SetPose("Running");
        else
            u1.SetPose("Walking");
        end;
        u1.UpdateWalkSpeed();
    else
        u1.SetPose("Standing");
    end;
end;
function u1.OnSwimming(p7) --[[ Line: 123 ]]
    -- upvalues: u1 (copy)
    if p7 > 0 then
        u1.SetPose("Walking");
    else
        u1.SetPose("Standing");
    end;
end;
function u1.OnClimbing(p8) --[[ Line: 131 ]]
    -- upvalues: u1 (copy)
    u1.PlayAnimation("Climb", 0.1);
    u1.UpdateAnimationSpeed(p8 * u1.ClimbSpeedDecimal);
    u1.SetPose("Climbing");
end;
function u1.OnJumping() --[[ Line: 137 ]]
    -- upvalues: u1 (copy)
    u1.SetPose("Jumping");
    u1.ResetTimer("JumpTime");
end;
function u1.OnFreeFall() --[[ Line: 142 ]]
    -- upvalues: u1 (copy)
    if u1.Timers.JumpTime <= 0 then
        u1.PlayAnimation("Fall", 0.3);
    end;
    u1.SetPose("FreeFall");
end;
function u1.SetupTracks() --[[ Line: 149 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__2 (copy)
    if u1.RetrieveAnimationsFromHumanoidDescription then
        repeat
            task.wait();
        until l__LocalPlayer__2:HasAppearanceLoaded();
        local v9 = u1.Humanoid:GetAppliedDescription();
        for v10, v11 in u1.OverwriteAnimations do
            local v12 = u1.DefaultWeight or u1.DefaultWeightOveride[v10];
            local v13 = v9[v11];
            if v12 and (v13 and v13 ~= 0) then
                warn("Rewriting->", v10, v13);
                u1.AnimationList[v10] = {
                    {
                        Weight = v12,
                        Asset = v13
                    }
                };
            end;
        end;
    end;
    u1.AnimationInstances = {};
    for v14, v15 in u1.AnimationList do
        u1.AnimationInstances[v14] = {};
        for v16, v17 in v15 do
            local v18 = Instance.new("Animation");
            v18.AnimationId = v17.Asset;
            u1.AnimationInstances[v14][v16] = {
                Name = v14,
                Animation = v18,
                BaseWeight = v17.Weight
            };
        end;
    end;
end;
function u1.KeyFrameReached(p19) --[[ Line: 182 ]]
    -- upvalues: u1 (copy)
    if p19 == "End" then
        u1.PlayAnimation(u1.CurrentAnimationTable.Name, 0);
        u1.UpdateAnimationSpeed(u1.CurrentAnimationSpeed);
    end;
end;
function u1.SwitchAnimation(p20, p21) --[[ Line: 190 ]]
    -- upvalues: u1 (copy)
    if p20 == u1.CurrentAnimationTable then
    else
        if u1.CurrentTrack ~= nil then
            u1.CurrentTrack:Stop(p21);
            u1.CurrentTrack:Destroy();
        end;
        u1.CurrentAnimationSpeed = 1;
        u1.CurrentAnimationTable = p20;
        u1.CurrentTrack = u1.Humanoid:LoadAnimation(p20.Animation);
        u1.CurrentTrack.Priority = Enum.AnimationPriority.Core;
        u1.CurrentTrack:Play(p21);
        if u1.KeyFrameConnection then
            u1.KeyFrameConnection:Disconnect();
        end;
        u1.KeyFrameConnection = u1.CurrentTrack.KeyframeReached:Connect(u1.KeyFrameReached);
    end;
end;
function u1.StopAllAnimations() --[[ Line: 213 ]]
    -- upvalues: u1 (copy)
    if u1.CurrentTrack ~= nil then
        u1.CurrentTrack:Stop();
        u1.CurrentTrack:Destroy();
        u1.CurrentTrack = nil;
    end;
    if u1.KeyFrameConnection then
        u1.KeyFrameConnection:Disconnect();
    end;
    u1.CurrentAnimationTable = nil;
end;
function u1.PlayAnimation(p22, p23) --[[ Line: 226 ]]
    -- upvalues: u1 (copy)
    local v24 = u1.AnimationInstances[p22];
    if v24 then
        local v25 = v24[math.random(1, #v24)];
        u1.SwitchAnimation(v25, p23);
    else
        warn(("No animation by the name of \'%s\'"):format(p22));
    end;
end;
function u1.UpdateWalkSpeed() --[[ Line: 240 ]]
    -- upvalues: u1 (copy)
    if u1.Pose == "Walking" and u1.CurrentAnimationTable then
        local v26 = u1.WalkSpeed * u1.WalkSpeedDecimal;
        local _ = u1.CurrentTrack;
        u1.UpdateAnimationSpeed(v26);
    end;
    if u1.Pose == "Running" and u1.CurrentAnimationTable then
        local v27 = u1.WalkSpeed * u1.RunSpeedDecimal;
        local _ = u1.CurrentTrack;
        u1.UpdateAnimationSpeed(v27);
    end;
end;
function u1.UpdateAnimationSpeed(p28) --[[ Line: 255 ]]
    -- upvalues: u1 (copy)
    local l__CurrentTrack__6 = u1.CurrentTrack;
    u1.CurrentAnimationSpeed = p28;
    l__CurrentTrack__6:AdjustSpeed(p28);
end;
function u1.UponUpdate(p29) --[[ Line: 263 ]]
    -- upvalues: u1 (copy)
    for v30, _ in u1.Timers do
        local l__Timers__7 = u1.Timers;
        l__Timers__7[v30] = l__Timers__7[v30] - p29;
    end;
    local l__Pose__8 = u1.Pose;
    if l__Pose__8 == "Running" or l__Pose__8 == "Walking" then
        u1.UpdateWalkSpeed();
    end;
    if l__Pose__8 == "FreeFall" and u1.Timers.JumpTime <= 0 then
        u1.PlayAnimation("Fall", 0.3);
    end;
    if l__Pose__8 == "Dead" or (l__Pose__8 == "GettingUp" or (l__Pose__8 == "FallingDown" or (l__Pose__8 == "Seated" or l__Pose__8 == "PlatformStanding"))) then
        u1.StopAllAnimations();
    end;
end;
function u1.UponSwitch(...) --[[ Line: 279 ]]
    -- upvalues: u1 (copy)
    local l__Pose__9 = u1.Pose;
    if l__Pose__9 == "Standing" then
        u1.PlayAnimation("Idle", 0.2);
    end;
    if l__Pose__9 == "Walking" then
        u1.PlayAnimation("Walk", 0.2);
        u1.UpdateWalkSpeed();
    end;
    if l__Pose__9 == "Running" then
        u1.PlayAnimation("Run", 0.2);
        u1.UpdateWalkSpeed();
    end;
    if l__Pose__9 == "Jumping" then
        u1.PlayAnimation("Jump", 0.1);
    end;
end;
function u1.SetPose(p31, ...) --[[ Line: 302 ]]
    -- upvalues: u1 (copy)
    u1.Pose = p31;
    if u1.Pose ~= u1.LastPose then
        u1.UponSwitch(...);
    end;
    u1.LastPose = u1.Pose;
end;
function u1.Setup() --[[ Line: 310 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__2 (copy)
    if u1.Enabled then
        if l__LocalPlayer__2.Character then
            u1.NewCharacter(l__LocalPlayer__2.Character);
        end;
        l__LocalPlayer__2.CharacterAdded:Connect(u1.NewCharacter);
    end;
end;
return u1;
