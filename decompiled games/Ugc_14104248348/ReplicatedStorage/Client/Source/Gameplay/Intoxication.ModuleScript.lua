-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Intoxication
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StarterPlayer__2 = game:GetService("StarterPlayer");
local l__RunService__3 = game:GetService("RunService");
local l__Debris__4 = game:GetService("Debris");
local l__Players__5 = game:GetService("Players");
local l__CollectionService__6 = game:GetService("CollectionService");
local l__LocalPlayer__7 = l__Players__5.LocalPlayer;
local l__Mince__8 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local l__Particles__9 = l__ReplicatedStorage__1.Assets.Particles;
local u2 = l__Mince__8:Get("Effects");
local u3 = l__Mince__8:Get("Locomotion");
local u4 = l__Mince__8:Get("UserProfile");
local u5 = l__Mince__8:Get("SoundHandler");
local u6 = l__Mince__8:Get("InterfaceHandler");
local u7 = l__Mince__8:Get("Settings");
local u8 = l__Mince__8:GetEvent("RequestRagdoll");
local u9 = l__Mince__8:GetEvent("RequestReset");
local u10 = l__Mince__8:GetEvent("IntoxicationReport");
local u11 = l__Mince__8:GetEvent("Vomit"):Extend("Create");
function lerp(p12, p13, p14)
    return p12 * (1 - p14) + p13 * p14;
end;
local u15 = {
    IntoxLevel = -0.3,
    FloorIntox = -0.3,
    PassoutLevel = 1.8,
    FatalLevel = 2.3,
    WakeupLevel = 1.72,
    SoberRate = 0.005,
    Unconscious = false,
    ApplyTimePerAlc = 6,
    TimeElapsed = 0,
    ReportRate = 0.2,
    Tolerance = 1,
    Vomit = {
        Chance = 0.08,
        Clock = 0,
        Vomitted = true,
        Threshold = {
            Min = 2,
            Max = 3
        }
    },
    Animations = {}
};
function u15.OnPlayerVomit(p16, p17) --[[ Line: 63 ]]
    -- upvalues: u7 (copy), l__LocalPlayer__7 (copy), l__Particles__9 (copy), u3 (copy), l__CollectionService__6 (copy), l__Players__5 (copy), u15 (copy), u11 (copy), l__RunService__3 (copy), l__Debris__4 (copy)
    if u7.GetValue("NoVom") then
        p17:Stop();
        return;
    end;
    local l__Character__10 = p16.Character;
    local u18 = p16 == l__LocalPlayer__7;
    local u19 = false;
    local v20 = false;
    if not l__Character__10 then
        return;
    end;
    local l__Head__11 = l__Character__10.Head;
    local l__HumanoidRootPart__12 = l__Character__10.HumanoidRootPart;
    local u21 = l__Particles__9.Vomit:Clone();
    u21.Parent = l__Character__10;
    local l__Puddle__13 = u21.Puddle;
    local u22 = Instance.new("Sound");
    u22.SoundId = "rbxassetid://18514488472";
    u22.Parent = l__Head__11;
    local v23 = Instance.new("Weld");
    v23.Part0 = l__Head__11;
    v23.Part1 = u21;
    v23.C0 = CFrame.new(l__Head__11.FaceFrontAttachment.Position) * CFrame.new(0, -0.2, 0) * CFrame.Angles(1.5707963267948966, 3.141592653589793, -1.5707963267948966);
    v23.Parent = u21;
    if u18 then
        u3.SetEnabled(false);
    end;
    local u24 = nil;
    u24 = p17:GetMarkerReachedSignal("Vomit"):Connect(function(p25) --[[ Line: 100 ]]
        -- upvalues: u21 (copy), u18 (copy), u3 (ref), u19 (ref), u24 (ref)
        if p25 == "Start" then
            for _, v26 in u21:GetDescendants() do
                if v26:IsA("ParticleEmitter") or v26:IsA("Beam") then
                    v26.Enabled = true;
                end;
            end;
        else
            if p25 == "End" then
                if u18 then
                    u3.SetEnabled(true);
                end;
                for _, v27 in u21:GetDescendants() do
                    if v27:IsA("ParticleEmitter") or v27:IsA("Beam") then
                        v27.Enabled = false;
                    end;
                end;
                u19 = true;
                u24:Disconnect();
            end;
        end;
    end);
    local v28 = l__CollectionService__6:GetTagged("IgnoreOnRay");
    for _, v29 in l__Players__5:GetPlayers() do
        table.insert(v28, v29.Character);
    end;
    local v30 = RaycastParams.new();
    v30.FilterDescendantsInstances = v28;
    v30.FilterType = Enum.RaycastFilterType.Exclude;
    task.delay(0.05, function() --[[ Line: 137 ]]
        -- upvalues: u22 (copy)
        u22:Play();
    end);
    while true do
        local v31 = workspace:Raycast((l__HumanoidRootPart__12.CFrame * CFrame.new(0, 0, -3)).Position, Vector3.new(0, -10, 0), v30);
        if v31 then
            l__Puddle__13.WorldPosition = v31.Position;
            l__Puddle__13.WorldOrientation = Vector3.new(0, -90, 180);
            if not v20 and (u18 and os.clock() - u15.Vomit.Clock > 1.5) then
                u11:Fire(v31.Position);
                v20 = true;
            end;
        end;
        l__RunService__3.RenderStepped:Wait();
        if u19 then
            l__Debris__4:AddItem(u21, 5);
            l__Debris__4:AddItem(u22, 6);
            return;
        end;
    end;
end;
function u15.Consume(p32) --[[ Line: 166 ]]
    -- upvalues: u15 (copy), u7 (copy)
    local v33 = math.abs(p32) * u15.ApplyTimePerAlc;
    local v34 = p32 * lerp(1.6, u15.Tolerance, u7.GetValue("UserTolerance") or 1);
    local l__Humanoid__14 = u15.Humanoid;
    local v35 = 0;
    local v36 = 0;
    while true do
        local v37 = task.wait();
        v35 = v35 + v37;
        local v38 = v37 / v33;
        if v35 < v33 then
            local v39 = u15;
            v39.IntoxLevel = v39.IntoxLevel + v38 * v34;
            v36 = v36 + v38 * v34;
        end;
        if u15.Humanoid ~= l__Humanoid__14 then
            return;
        end;
        if u15.Humanoid == nil then
            return;
        end;
        if v33 < v35 then
            if u15.Humanoid == l__Humanoid__14 then
                if u15.Humanoid == nil then
                    return;
                else
                    local v40 = v34 - v36;
                    if v40 > 0 then
                        local v41 = u15;
                        v41.IntoxLevel = v41.IntoxLevel + v40;
                    end;
                    return;
                end;
            else
                return;
            end;
        end;
    end;
end;
function u15.GetLevel() --[[ Line: 196 ]]
    -- upvalues: u15 (copy)
    return math.max(0, u15.IntoxLevel) / u15.PassoutLevel;
end;
function u15.IsPassedOut() --[[ Line: 200 ]]
    -- upvalues: u15 (copy)
    return u15.Unconscious;
end;
function u15.SetTolerance(p42) --[[ Line: 204 ]]
    -- upvalues: u15 (copy)
    u15.Tolerance = p42;
end;
function u15.GetSoberRate() --[[ Line: 208 ]]
    -- upvalues: u15 (copy)
    if u15.Unconscious then
        return u15.SoberRate * 2;
    else
        return u15.SoberRate;
    end;
end;
function u15.Update(p43) --[[ Line: 216 ]]
    -- upvalues: u15 (copy), u9 (copy), u3 (copy), u2 (copy), u5 (copy), u8 (copy), l__LocalPlayer__7 (copy), l__StarterPlayer__2 (copy), u10 (copy), u7 (copy), l__Mince__8 (copy)
    local v44 = u15;
    v44.IntoxLevel = v44.IntoxLevel - p43 * u15.GetSoberRate();
    u15.IntoxLevel = math.clamp(u15.IntoxLevel, u15.FloorIntox, u15.FatalLevel);
    local v45 = u15.GetLevel();
    u15.DroneLoop.Volume = v45;
    u15.DroneLoop.PlaybackSpeed = v45;
    if u15.IntoxLevel > u15.PassoutLevel then
        local v46 = math.abs(u15.PassoutLevel - u15.IntoxLevel);
        u15.PassLoop.PlaybackSpeed = v46 * 5;
        u15.PassLoop.Volume = v46 * 2;
    else
        u15.PassLoop.Volume = 0;
    end;
    if u15.IntoxLevel == u15.FatalLevel then
        u9:Fire();
    end;
    if u15.IntoxLevel >= u15.PassoutLevel and not u15.Unconscious then
        u15.Unconscious = true;
        u3.SetEnabled(false);
        u15.Humanoid.JumpPower = 0;
        u2.BrightEffect(1, 2);
        u5.PlaySound("Impact");
        u8:Fire(true);
    end;
    if u15.IntoxLevel < u15.WakeupLevel and (u15.Unconscious and not l__LocalPlayer__7:GetAttribute("PickedUp")) then
        u15.Unconscious = false;
        u15.IntoxLevel = 0;
        u3.SetEnabled(true);
        if u15.Humanoid.UseJumpPower then
            u15.Humanoid.JumpPower = 60;
        else
            u15.Humanoid.JumpPower = l__StarterPlayer__2.CharacterJumpHeight;
        end;
        u15.Humanoid.WalkSpeed = 0;
        u8:Fire(false);
        if os.clock() - u15.Vomit.Clock >= 0 and math.random() <= u15.Vomit.Chance then
            local v47 = math.random(u15.Vomit.Threshold.Min, u15.Vomit.Threshold.Max);
            u15.Vomit.Clock = os.clock() + v47;
            u15.Vomit.Vomitted = false;
        end;
    end;
    local v48 = math.clamp(u15.IntoxLevel / u15.FatalLevel, 0, 1);
    local v49 = u15;
    v49.TimeElapsed = v49.TimeElapsed + p43;
    if u15.TimeElapsed > u15.ReportRate then
        u15.TimeElapsed = 0;
        if u15.LastReplicatedDecimal ~= v48 then
            u15.LastReplicatedDecimal = v48;
            u10:Fire(v48);
        end;
    end;
    if not u15.Vomit.Vomitted and (not u7.GetValue("NoVom") and os.clock() - u15.Vomit.Clock > 0) then
        u15.Vomit.Vomitted = true;
        u3.SetEnabled(false);
        u15.Animations.Vomit:Play();
    end;
    u15.MainPriority.Intoxication.UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0, 1),
        NumberSequenceKeypoint.new(math.clamp(v48, 0.01, 0.98), 0, 1),
        NumberSequenceKeypoint.new(math.clamp(v48 + 0.01, 0.02, 0.99), 1, 1),
        NumberSequenceKeypoint.new(1, 1, 1)
    });
    u15.MainPriority.Intoxication.Cursor.Position = UDim2.fromScale(v48, 0);
    l__Mince__8.Config.Stats.Intox[2] = `Intoxication: {u15.IntoxLevel}, Level: {u15.GetLevel()}, Tolerance:{u15.Tolerance}`;
end;
function u15.NewCharacter(p50) --[[ Line: 316 ]]
    -- upvalues: u15 (copy), u3 (copy), u10 (copy)
    local l__Humanoid__15 = p50:WaitForChild("Humanoid");
    local l__Animator__16 = l__Humanoid__15:WaitForChild("Animator");
    u15.IntoxLevel = u15.FloorIntox;
    u3.MovementEnabled = true;
    u15.Humanoid = l__Humanoid__15;
    u10:Fire(0);
    u15.Animations = {
        Vomit = l__Animator__16:LoadAnimation(script.Animations.Vomit)
    };
    u15.Vomit.Vomitted = true;
    u15.Vomit.Clock = 0;
    l__Humanoid__15.Died:Connect(function() --[[ Line: 331 ]]
        -- upvalues: u15 (ref)
        u15.Humanoid = nil;
    end);
end;
function u15.OnOtherCharactersAdded(p51, _) --[[ Line: 336 ]]
    -- upvalues: l__Players__5 (copy), u15 (copy), u1 (copy)
    local u52 = l__Players__5:GetPlayerFromCharacter(p51);
    local l__Animator__17 = p51:WaitForChild("Humanoid"):WaitForChild("Animator");
    local u53 = string.match(u15.Animations.Vomit.Animation.AnimationId, "%d+");
    u1:AddCharacterConnection(u52, l__Animator__17.AnimationPlayed:Connect(function(p54) --[[ Line: 343 ]]
        -- upvalues: u53 (copy), u15 (ref), u52 (copy)
        if string.match(p54.Animation.AnimationId, "%d+") == u53 then
            u15.OnPlayerVomit(u52, p54);
        end;
    end));
end;
function u15.PlayerAdded(p55) --[[ Line: 355 ]]
    -- upvalues: u1 (copy), u15 (copy)
    u1:AddPlayerConnection(p55, p55.CharacterAdded:Connect(u15.OnOtherCharactersAdded));
    if p55.Character then
        u15.OnOtherCharactersAdded(p55.Character);
    end;
end;
function u15.Setup() --[[ Line: 363 ]]
    -- upvalues: u5 (copy), u4 (copy), u15 (copy), u6 (copy), l__LocalPlayer__7 (copy), l__RunService__3 (copy), l__Mince__8 (copy), l__Players__5 (copy)
    u5.WaitUntilSoundLoaded();
    u4.IndexUpdated("Tolerance"):Connect(function(p56) --[[ Line: 366 ]]
        -- upvalues: u15 (ref)
        u15.SetTolerance(p56);
    end);
    u15.MainPriority = u6.GetScreenGui("MainPriority");
    u15.PassLoop = u5.PlaySound("PassLoop");
    u15.PassLoop.Looped = true;
    u15.PassLoop:Play();
    u15.PassLoop.Volume = 0;
    u15.DroneLoop = u5.PlaySound("DroneLoop");
    u15.DroneLoop.Looped = true;
    u15.DroneLoop:Play();
    u15.DroneLoop.Volume = 0;
    if l__LocalPlayer__7.Character then
        u15.NewCharacter(l__LocalPlayer__7.Character);
    end;
    l__LocalPlayer__7.CharacterAdded:Connect(u15.NewCharacter);
    l__RunService__3.Heartbeat:Connect(u15.Update);
    l__Mince__8.Config.Stats.Intox = { 9, "IDLE" };
    for _, v57 in l__Players__5:GetPlayers() do
        u15.PlayerAdded(v57);
    end;
    l__Players__5.PlayerAdded:Connect(u15.PlayerAdded);
end;
return u15;
