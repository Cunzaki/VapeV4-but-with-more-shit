-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.Components.Seagull
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__microid__6 = require(l__ReplicatedStorage__1.Modules.microid);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__5:Get("TriggerHandler");
local u2 = l__Mince__5:GetEvent("SeagullInteract");
function RandomPosition(p3, p4)
    local v5 = p3 * 0.5;
    local v6 = math.random(-v5.X, v5.X);
    local v7 = math.random(-v5.Z, v5.Z);
    return p4:PointToWorldSpace((Vector3.new(v6, 0, v7)));
end;
local v8 = l__Mince__5.Component({
    Tag = "Seagull",
    Takeoff = {
        TakeoffTime = 3,
        LandTime = 0.2,
        LandMultiplier = 0.5
    },
    SpeedRange = { 60, 80 },
    SkyRange = { 150, 200 },
    WideRange = { 100, 180 }
});
function v8.Update(u9, p10) --[[ Line: 43 ]]
    -- upvalues: l__TweenService__2 (copy), l__Mince__5 (copy)
    debug.profilebegin("bird-start");
    if u9.PathExisting then
        u9.TimeElapsed = u9.TimeElapsed + p10;
        local v11 = 1;
        if u9.ExitOnceReachedGround and u9.TimeElapsed < u9.Takeoff.TakeoffTime then
            v11 = l__TweenService__2:GetValue(u9.TimeElapsed / u9.Takeoff.TakeoffTime, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        elseif not u9.ExitOnceReachedGround and u9.PathTime > u9.PathDuration - u9.Takeoff.LandTime then
            v11 = u9.Takeoff.LandMultiplier;
        end;
        u9.PathTime = u9.PathTime + p10 * v11;
        local v12 = u9.PathTime / u9.PathDuration;
        local v13 = u9.PathStarting:Lerp(u9.PathEnding, v12);
        if v12 > 1 then
            u9.PathExisting = false;
            u9.AllowWanderOn = os.clock() + math.random(5, 20);
            u9.Animations.Fly:AdjustSpeed(v11 * 2 + v12 * 0.2 * (u9.AlphaSpeed or 1));
            if u9.ExitOnceReachedGround then
                u9.LastExitPosition = u9.Instance:GetPivot().Position;
                u9.Instance:PivotTo(CFrame.new());
            else
                u9.Animations.Fly:Stop();
            end;
            if u9.CompleteFn then
                u9.CompleteFn();
            end;
        else
            local l__Rotation__7 = u9.Instance:GetPivot().Rotation;
            u9.Instance:PivotTo(CFrame.new(v13) * l__Rotation__7:Lerp(u9.TargetRotation, (math.clamp(p10 * 2, 0, 1))));
        end;
    elseif not u9.Sky and (u9.BoundIndex and os.clock() > u9.AllowWanderOn) then
        local v14 = l__Mince__5.Config.SeagullBounds[u9.BoundIndex];
        local l__Position__8 = u9.Instance:GetPivot().Position;
        local v15 = RandomPosition(v14.Size, v14.CFrame);
        local u16 = l__Position__8:Lerp(v15, (math.clamp(10 / (l__Position__8 - v15).Magnitude, 0, 1)));
        u9.AlphaSpeed = 0;
        u9.FlyingTarget = u16 + Vector3.new(0, 1, 0) * u9.RootPart.Size.Y * 0.5;
        u9:UpdatePath(10, nil, function() --[[ Line: 106 ]]
            -- upvalues: u9 (copy), u16 (copy)
            u9.SpawnPivot = CFrame.new(u16 + Vector3.new(0, 1, 0) * u9.RootPart.Size.Y * 0.5);
            u9.TriggerPart.Position = u16;
        end);
    end;
    debug.profileend();
end;
function v8.UpdateFlyStatus(p17) --[[ Line: 115 ]]
    local v18 = Random.new(p17.Seed or os.clock());
    local l__SkyRange__9 = p17.SkyRange;
    local v19 = v18:NextNumber();
    local v20, v21 = table.unpack(l__SkyRange__9);
    local v22 = v20 + (v21 - v20) * v19;
    local l__WideRange__10 = p17.WideRange;
    local v23 = v18:NextNumber();
    local v24, v25 = table.unpack(l__WideRange__10);
    local v26 = v24 + (v25 - v24) * v23;
    local l__SpeedRange__11 = p17.SpeedRange;
    local v27 = v18:NextNumber();
    local v28, v29 = table.unpack(l__SpeedRange__11);
    p17.Speed = 1 / (v28 + (v29 - v28) * v27);
    local v30 = v18:NextUnitVector();
    if p17.Sky then
        local v31 = p17.SpawnPivot.Position + v30 * Vector3.new(1, 0, 1) * v26 + v22 * Vector3.new(0, 1, 0);
        p17.Animations.Fly:Play();
        p17.RootPart.Scare:Play();
        p17.RootPart.Scare.PlaybackSpeed = 0.9 + 0.2 * math.random();
        p17.AlphaSpeed = 1;
        p17.ExitOnceReachedGround = true;
        p17.FlyingTarget = v31;
        p17:UpdatePath();
    else
        if p17.LastExitPosition then
            p17.Instance:PivotTo(CFrame.new(p17.LastExitPosition));
        end;
        p17.RootPart.Scare:Play();
        p17.AlphaSpeed = 0;
        p17.ExitOnceReachedGround = false;
        p17.FlyingTarget = p17.SpawnPivot.Position;
        p17:UpdatePath(2, 0);
    end;
end;
function v8.UpdatePath(p32, p33, p34, p35) --[[ Line: 149 ]]
    local l__Position__12 = p32.Instance:GetPivot().Position;
    local l__Magnitude__13 = (l__Position__12 - p32.FlyingTarget).Magnitude;
    p32.PathStarting = l__Position__12;
    p32.PathEnding = p32.FlyingTarget;
    local v36, v37, v38 = CFrame.new(p32.PathStarting, p32.PathEnding).Rotation:ToOrientation();
    p32.TargetRotation = CFrame.fromOrientation(v36 * (p34 or 0.4), v37, v38);
    p32.PathExisting = true;
    p32.PathTime = 0;
    p32.TimeElapsed = 0;
    p32.PathDuration = l__Magnitude__13 * p32.Speed * (p33 or 1);
    p32.CompleteFn = p35;
end;
function v8.Construct(u39) --[[ Line: 166 ]]
    -- upvalues: l__Maid__4 (copy), u1 (copy), l__microid__6 (copy), u2 (copy), l__RunService__3 (copy)
    u39.RootPart = u39.Instance:WaitForChild("RootPart");
    u39.SpawnPivot = u39.Instance:GetPivot();
    u39.OriginalPivot = u39.SpawnPivot;
    u39.Maid = l__Maid__4.new();
    u39.Animations = {};
    local l__AnimationController__14 = u39.Instance:WaitForChild("AnimationController");
    for _, v40 in u39.Instance:WaitForChild("Animations"):GetChildren() do
        u39.Animations[v40.Name] = l__AnimationController__14:LoadAnimation(v40);
    end;
    u39.Animations.Idle:Play();
    local v41, v42 = u1.PsudeoTrigger(u39.SpawnPivot, Vector3.new(1, 1, 1) * math.random(40, 60), {
        Name = l__microid__6.gent(24)
    });
    u39.Trigger = v41;
    u39.TriggerPart = v42;
    u39.Trigger.Entered:Connect(function() --[[ Line: 194 ]]
        -- upvalues: u39 (copy), u2 (ref)
        if u39.Sky then
        else
            u2:Fire(u39.Instance, "Scare");
        end;
    end);
    if u39.NextSpawnPosition then
        local l__NextSpawnPosition__15 = u39.NextSpawnPosition;
        u39.SpawnPivot = CFrame.new(l__NextSpawnPosition__15 + Vector3.new(0, 1, 0) * u39.RootPart.Size.Y * 0.5);
        u39.TriggerPart.Position = l__NextSpawnPosition__15;
    end;
    u39.Instance:GetAttributeChangedSignal("NextSpawnPosition"):Connect(function() --[[ Line: 208 ]]
        -- upvalues: u39 (copy)
        local l__NextSpawnPosition__16 = u39.NextSpawnPosition;
        u39.SpawnPivot = CFrame.new(l__NextSpawnPosition__16 + Vector3.new(0, 1, 0) * u39.RootPart.Size.Y * 0.5);
        u39.TriggerPart.Position = l__NextSpawnPosition__16;
    end);
    u39.Instance:GetAttributeChangedSignal("Sky"):Connect(function() --[[ Line: 212 ]]
        -- upvalues: u39 (copy)
        u39:UpdateFlyStatus();
    end);
    l__RunService__3.Heartbeat:Connect(function(p43) --[[ Line: 217 ]]
        -- upvalues: u39 (copy)
        u39:Update(p43);
    end);
    task.defer(function() --[[ Line: 221 ]]
        -- upvalues: u39 (copy)
        u39:UpdateFlyStatus();
    end);
end;
return v8;
