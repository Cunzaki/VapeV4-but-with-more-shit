-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.IcicleStormClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__RunService__3 = game:GetService("RunService");
game:GetService("SoundService");
local l__Players__4 = game:GetService("Players");
local l__TweenService__5 = game:GetService("TweenService");
local l__Debris__6 = game:GetService("Debris");
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__7:Get("RegionHandler");
local u2 = l__Mince__7:GetEvent("IcicleStormEvent");
local u3 = l__Mince__7:GetEvent("SpawnIcicleStormIcicle");
l__Mince__7:GetEvent("RequestRagdoll");
local u4 = l__Mince__7:GetEvent("SpawnIcicleStormSnowball");
local u5 = {
    IcicleRadius = 12,
    SnowballRadius = 15,
    CastParams = RaycastParams.new()
};
function u5.CheckRadiusHit(p6, p7) --[[ Line: 23 ]]
    -- upvalues: l__Mince__7 (copy), u5 (copy)
    if l__Mince__7.Config.Character then
        local v8 = l__Mince__7.Config.Character:FindFirstChild("HumanoidRootPart");
        if v8 then
            if (v8.Position - p6).Magnitude <= p7 then
                u5.ProjectileTouched(v8);
            end;
        end;
    end;
end;
function u5.SpawnIcicle(p9) --[[ Line: 36 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u5 (copy), l__TweenService__5 (copy), l__Debris__6 (copy)
    local v10 = l__ReplicatedStorage__1.Assets.Spawnables.GiantIcicle:Clone();
    v10.Position = p9;
    v10.Parent = workspace;
    local v11 = workspace:Raycast(p9, p9 + Vector3.new(-0, -9000, -0), u5.CastParams);
    local v12, v13;
    if v11 and v11.Position then
        v12 = v11.Position;
        v13 = math.sqrt(2 * (p9 - v11.Position).Magnitude / (workspace.Gravity * 2));
        l__TweenService__5:Create(v10, TweenInfo.new(v13, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = v11.Position
        }):Play();
    else
        v12 = p9;
        v13 = 0;
    end;
    local v14 = v10.Touched:Connect(u5.ProjectileTouched);
    task.wait(v13);
    u5.CheckRadiusHit(v12, u5.IcicleRadius);
    v10.Anchored = true;
    v10.CanCollide = true;
    v14:Disconnect();
    local v15 = u5.Effects.Elstart:Clone();
    v15.Anchored = true;
    v15.Parent = workspace;
    v15.Position = v10.Position;
    for _, v16 in v15:GetDescendants() do
        if v16:IsA("ParticleEmitter") then
            v16:Emit(1);
        end;
    end;
    local v17 = v15.Sounds:GetChildren();
    v17[math.random(1, #v17)]:Play();
    task.wait(2);
    v15:Destroy();
    l__TweenService__5:Create(v10, TweenInfo.new(1), {
        Transparency = 1
    }):Play();
    l__Debris__6:AddItem(v10, 1);
end;
function u5.SpawnSnowball(p18) --[[ Line: 98 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__TweenService__5 (copy), u5 (copy), l__Debris__6 (copy)
    local v19 = l__ReplicatedStorage__1.Assets.Spawnables.GiantSnowBall:Clone();
    local v20 = p18:Clone();
    local l__Size__8 = v20.InnerRing.Size;
    v20.InnerRing.Size = Vector3.new(0.001, 0.001, 0.001);
    v20.Parent = workspace;
    v19.Parent = workspace;
    v19.Position = v20.InnerRing.Position + Vector3.new(0, 500, 0);
    local v21 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    l__TweenService__5:Create(v20.InnerRing, v21, {
        Size = l__Size__8
    }):Play();
    l__TweenService__5:Create(v19, v21, {
        Position = v20.InnerRing.Position
    }):Play();
    v19.Touched:Connect(u5.ProjectileTouched);
    task.wait(1);
    u5.CheckRadiusHit(v20.InnerRing.Position, u5.SnowballRadius);
    local v22 = u5.Effects.Elstart:Clone();
    v22.Anchored = true;
    v22.Parent = workspace;
    v22.Position = v20.InnerRing.Position;
    for _, v23 in v22:GetDescendants() do
        if v23:IsA("ParticleEmitter") then
            v23:Emit();
        end;
    end;
    local v24 = v22.Sounds:GetChildren();
    v24[math.random(1, #v24)]:Play();
    v19:Destroy();
    v20:Destroy();
    l__Debris__6:AddItem(v22, 1);
end;
function u5.ProjectileTouched(p25) --[[ Line: 143 ]]
    -- upvalues: l__Mince__7 (copy), u5 (copy)
    if l__Mince__7.Config.Character and p25:IsDescendantOf(l__Mince__7.Config.Character) then
        if u5.Delay then
        else
            local v26 = l__Mince__7.Config.Character:FindFirstChild("HumanoidRootPart");
            if v26 then
                local v27 = math.random() - 0.1;
                local v28 = math.random() - 0.1;
                v26:ApplyImpulse(Vector3.new(v27, 1, v28).Unit * 65 * v26.AssemblyMass);
                l__Mince__7.Config.Humanoid:TakeDamage(10);
                u5.Delay = task.delay(1, function() --[[ Line: 160 ]]
                    -- upvalues: u5 (ref)
                    u5.Delay = nil;
                end);
            end;
        end;
    end;
end;
function u5.Update() --[[ Line: 166 ]]
    -- upvalues: u5 (copy)
    if u5.IsOutside then
        u5.WeatherPart.Position = workspace.CurrentCamera.CFrame.Position;
    end;
end;
function u5.ToggleStorm(p29) --[[ Line: 171 ]]
    -- upvalues: u5 (copy), l__RunService__3 (copy), l__ReplicatedStorage__1 (copy)
    if u5.Connection then
        u5.Connection:Disconnect();
        u5.Connection = nil;
    end;
    if p29 then
        u5.Sound:Play();
        u5.Connection = l__RunService__3.RenderStepped:Connect(u5.Update);
        u5.WeatherPart.Parent = workspace;
    else
        u5.Sound:Stop();
        u5.WeatherPart.Parent = l__ReplicatedStorage__1;
    end;
end;
function u5.ChangeWeatherParticles(p30) --[[ Line: 187 ]]
    -- upvalues: u5 (copy)
    for _, v31 in u5.WeatherPart:GetDescendants() do
        if v31:IsA("ParticleEmitter") then
            v31.Enabled = p30 or u5.IsOutside;
        end;
    end;
end;
function u5.RegionsChanged() --[[ Line: 195 ]]
    -- upvalues: u1 (copy), l__Players__4 (copy), u5 (copy)
    if #u1.GetPlayerRegions(l__Players__4.LocalPlayer) <= 0 then
        u5.IsOutside = true;
        u5.ChangeWeatherParticles();
        u5.Sound.Muffle.Enabled = false;
    else
        u5.IsOutside = false;
        u5.ChangeWeatherParticles();
        u5.Sound.Muffle.Enabled = true;
    end;
end;
function u5.Setup() --[[ Line: 209 ]]
    -- upvalues: u5 (copy), l__CollectionService__2 (copy), l__ReplicatedStorage__1 (copy), u1 (copy), l__Players__4 (copy), u2 (copy), u3 (copy), u4 (copy)
    u5.CastParams.FilterType = Enum.RaycastFilterType.Include;
    u5.CastParams.FilterDescendantsInstances = { workspace.Terrain };
    u5.CastParams:AddToFilter(l__CollectionService__2:GetTagged("DetectAsPartOfTerrain"));
    u5.Sound = script:WaitForChild("SnowStorm");
    u5.Effects = l__ReplicatedStorage__1.Assets:WaitForChild("Particles"):WaitForChild("IceStormEffects");
    u5.WeatherPart = u5.Effects.Part;
    u1.GetPlayerRegionsChangedSignal(l__Players__4.LocalPlayer):Connect(u5.RegionsChanged);
    u2.Event:Connect(u5.ToggleStorm);
    u3.Event:Connect(u5.SpawnIcicle);
    u4.Event:Connect(u5.SpawnSnowball);
    u5.RegionsChanged();
end;
return u5;
