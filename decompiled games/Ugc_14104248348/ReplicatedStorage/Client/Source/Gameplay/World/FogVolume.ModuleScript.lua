-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.FogVolume
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local u1 = {
    __IsAsyncSetup = true,
    LastPlayerMapID = "000000",
    SpatialMap = require(l__ReplicatedStorage__1.Modules.SpatialHash).NewMap(50, true),
    CurrentLoaded = {},
    Volumes = {},
    VolumesByBasePart = {}
};
local u2 = 0;
function u1.Work() --[[ Line: 52 ]]
    -- upvalues: u2 (ref)
    u2 = u2 + 1;
    if u2 > 50 then
        u2 = 0;
        return task.wait();
    end;
end;
function u1.SetupFogVolume(u3) --[[ Line: 56 ]]
    -- upvalues: u1 (copy), l__ReplicatedStorage__1 (copy)
    local u4 = u3:GetAttributes();
    if u4.Version < 3 then
        warn("Outdated fog volume...");
    else
        u3.AttributeChanged:Connect(function(p5) --[[ Line: 62 ]]
            -- upvalues: u4 (copy), u3 (copy)
            u4[p5] = u3:GetAttribute(p5);
        end);
        if not u4.SyncedToPart then
            for _, v6 in u3:GetChildren() do
                v6:Destroy();
            end;
        end;
        u4.Enabled = false;
        local v7 = Instance.new("Part");
        v7.Anchored = true;
        v7.CanCollide = false;
        v7.CanTouch = false;
        v7.CanQuery = false;
        v7.Locked = true;
        v7.Size = Vector3.new(0, 0, 0);
        v7.Transparency = 1;
        u4.BasePart = v7;
        u4.BasePart.Parent = u3;
        u4.BasePart.Name = "__GridSync";
        u1.SpatialMap.Add(u4.BasePart);
        u4.Foxels = {};
        u4.Transparency = u4.Transparency or 0.99;
        u4.Color = u4.Color or Color3.new(1, 1, 1);
        local l__Orientation__4 = u4.Orientation;
        local _ = CFrame.new(u4.Position) * CFrame.Angles(math.deg(l__Orientation__4.X), math.deg(l__Orientation__4.Y), (math.deg(l__Orientation__4.Z)));
        function u4.GetCFrame() --[[ Line: 88 ]]
            -- upvalues: u4 (copy)
            local l__Orientation__5 = u4.Orientation;
            return CFrame.new(u4.Position) * CFrame.Angles(math.deg(l__Orientation__5.X), math.deg(l__Orientation__5.Y), (math.deg(l__Orientation__5.Z)));
        end;
        function u4.DestroyAllFoxels() --[[ Line: 94 ]]
            -- upvalues: u4 (copy), u1 (ref)
            for _, v8 in u4.Foxels do
                v8.Attachment:Destroy();
                u1.Work();
            end;
            u4.Foxels = {};
        end;
        function u4.DoAfterWork() --[[ Line: 103 ]]
            -- upvalues: u4 (copy), u1 (ref)
            warn("Activating bounce fog...");
            local v9 = 0;
            while v9 < 250 do
                task.wait();
                for _, v10 in u4.Foxels do
                    v9 = v9 + (u1.Work() or 0);
                    if (v10.StartUpon or 0) < v9 then
                        v10.Particle.Enabled = true;
                    end;
                end;
            end;
            warn("Completed.....");
        end;
        function u4.CreateFoxels() --[[ Line: 122 ]]
            -- upvalues: u4 (copy), u1 (ref), l__ReplicatedStorage__1 (ref)
            if u4.Enabled then
                if u4.WorkThread then
                    coroutine.close(u4.WorkThread);
                end;
                u4.WorkThread = coroutine.running();
                u4.DestroyAllFoxels();
                local u11 = NumberSequence.new((u4.ParticleSize or 0) * (u4.Overlap or 1.5));
                local u12 = NumberSequence.new(u4.Transparency);
                local u13 = ColorSequence.new(u4.Color);
                if u4.FadeOut then
                    u12 = NumberSequence.new({ NumberSequenceKeypoint.new(0, u4.Transparency), NumberSequenceKeypoint.new(0.9, u4.Transparency), NumberSequenceKeypoint.new(1, 1) });
                end;
                local function v15() --[[ Line: 143 ]]
                    -- upvalues: u4 (ref), u1 (ref)
                    for _, v14 in u4.Foxels do
                        if v14.Particle.TimeScale == 1 then
                            v14.Particle.TimeScale = 0;
                            u1.Work();
                        end;
                        if v14.Particle.TimeScale == 0.99 then
                            v14.Particle.TimeScale = math.random(5, 10) / 10;
                            u1.Work();
                        end;
                    end;
                end;
                local function v18(p16) --[[ Line: 155 ]]
                    -- upvalues: u4 (ref), l__ReplicatedStorage__1 (ref), u11 (copy), u13 (copy), u12 (ref)
                    local v17 = {
                        CFrame = p16,
                        Attachment = Instance.new("Attachment")
                    };
                    if u4.BounceParticles then
                        v17.Particle = l__ReplicatedStorage__1.Assets.Particles.BounceFog:Clone();
                        v17.Particle.Size = u11;
                        v17.Particle.Color = u13;
                        v17.Particle.Transparency = u12;
                        v17.Particle.TimeScale = 0.99;
                        v17.Particle.Parent = v17.Attachment;
                        v17.Particle:Clear();
                        v17.Particle.Enabled = false;
                        v17.StartUpon = math.random(0, 249) / 100;
                    else
                        v17.Particle = l__ReplicatedStorage__1.Assets.Particles.FogParticle:Clone();
                        v17.Particle.Size = u11;
                        v17.Particle.Color = u13;
                        v17.Particle.Transparency = u12;
                        v17.Particle.TimeScale = 1;
                        v17.Particle.Parent = v17.Attachment;
                        v17.Particle:Clear();
                        v17.Particle:Emit(1);
                    end;
                    v17.Attachment.Name = "Foxel";
                    v17.Attachment.CFrame = v17.CFrame;
                    if u4.AdjustParticleFix then
                        local l__Attachment__6 = v17.Attachment;
                        l__Attachment__6.Position = l__Attachment__6.Position - Vector3.new(1, 1, 1) * u4.ParticleSize;
                    end;
                    v17.Attachment.Parent = game.Workspace.Terrain;
                    table.insert(u4.Foxels, v17);
                end;
                local v19 = u4.GetCFrame();
                local l__Size__7 = u4.Size;
                local l__Position__8 = v19.Position;
                local v20 = l__Size__7.X / 2;
                local v21 = l__Size__7.Y / 2;
                local v22 = l__Size__7.Z / 2;
                local v23 = math.random(1, 10);
                for v24 = -v20, v20, u4.ParticleSize do
                    for v25 = -v21, v21, u4.ParticleSize do
                        for v26 = -v22, v22, u4.ParticleSize do
                            local v27 = math.noise(l__Position__8.Y + v25, l__Position__8.Z + v26, v23);
                            local v28 = math.noise(l__Position__8.X + v24, l__Position__8.Z + v26, v23);
                            local v29 = Vector3.new(v27, v28, math.noise(l__Position__8.X + v24, l__Position__8.Y + v25, v23));
                            v18(v19:ToWorldSpace((CFrame.new(Vector3.new(v24, v25, v26) + v29 * 2))));
                            u1.Work();
                        end;
                    end;
                end;
                task.wait();
                v15();
                if u4.BounceParticles then
                    u4.DoAfterWork();
                end;
            end;
        end;
        local function v31() --[[ Line: 222 ]]
            -- upvalues: u4 (copy)
            local v30 = u4.GetCFrame();
            local l__Size__9 = u4.Size;
            if u4.BasePart.CFrame ~= v30 then
                u4.BasePart.CFrame = v30;
            end;
            if u4.BasePart.Size ~= l__Size__9 then
                u4.Size = l__Size__9;
            end;
        end;
        task.defer(v31);
        for _, v32 in { "Position", "Orientation", "Size" } do
            u3:GetAttributeChangedSignal(v32):Connect(v31);
        end;
        u3.AttributeChanged:Connect(u4.CreateFoxels);
        u3.AncestryChanged:Connect(function(p33) --[[ Line: 241 ]]
            -- upvalues: u4 (copy)
            if p33.Parent == nil then
                u4.DestroyAllFoxels();
            end;
        end);
        u4.CreateFoxels();
        table.insert(u1.Volumes, u4);
        u1.VolumesByBasePart[u4.BasePart] = u4;
    end;
end;
function u1.NewCharacter(p34) --[[ Line: 253 ]]
    -- upvalues: u1 (copy)
    p34:WaitForChild("Humanoid");
    u1.HumanoidRootPart = p34:WaitForChild("HumanoidRootPart");
    u1.PlayerCharacter = p34;
end;
function u1.Update(_) --[[ Line: 263 ]]
    -- upvalues: u1 (copy)
    if u1.HumanoidRootPart and u1.HumanoidRootPart.Parent ~= nil then
        local l__Position__10 = u1.HumanoidRootPart.Position;
        local v35 = u1.SpatialMap.GetMapID(l__Position__10);
        if v35 ~= u1.LastPlayerMapID then
            local v36 = u1.SpatialMap.GetPartsInRadius(l__Position__10, 1);
            for _, v37 in ipairs(u1.CurrentLoaded) do
                if not v36[v37] then
                    local v38 = u1.VolumesByBasePart[v37];
                    v38.Enabled = false;
                    task.spawn(v38.DestroyAllFoxels);
                end;
            end;
            for _, v39 in ipairs(v36) do
                if not u1.CurrentLoaded[v39] then
                    local v40 = u1.VolumesByBasePart[v39];
                    v40.Enabled = true;
                    task.spawn(v40.CreateFoxels);
                end;
            end;
            u1.CurrentLoaded = v36;
            u1.LastPlayerMapID = v35;
        end;
    end;
end;
function u1.Setup() --[[ Line: 296 ]]
    -- upvalues: u1 (copy)
    task.spawn(u1.SetupAsync);
end;
function u1.SetupAsync() --[[ Line: 300 ]]
    -- upvalues: l__RunService__2 (copy), u1 (copy), l__LocalPlayer__3 (copy)
    if not game:IsLoaded() then
        game.Loaded:Wait();
    end;
    task.wait(3);
    l__RunService__2.Heartbeat:Connect(u1.Update);
    l__LocalPlayer__3.CharacterAdded:Connect(u1.NewCharacter);
    if l__LocalPlayer__3.Character then
        u1.NewCharacter(l__LocalPlayer__3.Character);
    end;
    local v41 = Instance.new("Folder", game.Workspace);
    v41.Name = "LocalFogVolume";
    v41.ChildAdded:Connect(function(p42) --[[ Line: 317 ]]
        -- upvalues: u1 (ref)
        if p42:IsA("Configuration") and p42.Name == "FogVolume" then
            u1.SetupFogVolume(p42);
        end;
    end);
    for _, v43 in v41:GetChildren() do
        if v43:IsA("Configuration") and v43.Name == "FogVolume" then
            u1.SetupFogVolume(v43);
        end;
    end;
end;
return u1;
