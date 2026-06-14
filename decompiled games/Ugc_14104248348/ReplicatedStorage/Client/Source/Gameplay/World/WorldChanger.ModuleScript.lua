-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.WorldChanger
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__SpatialHash__5 = require(l__ReplicatedStorage__1.Modules.SpatialHash);
local u1 = l__Mince__4:Get("Settings");
l__Mince__4:Get("ConfigHandler");
local u2 = 320;
local u3 = 500;
local u4 = math.max(u2, u3);
local u5 = math.ceil(u4 / 15);
local u8 = {
    CastShadowOnParts = false,
    WorldLightUpdateRate = 0.1,
    Pos = 0,
    MaxWork = 150,
    TimeElapsed = 0,
    CullingLightsDisabled = false,
    __IsAsyncSetup = true,
    EnabledShadowsLight = {},
    WorldMeshesCastShadows = {},
    WorldGenericWhitelisted = {},
    DynamicLightFolder = game.Workspace:WaitForChild("DynamicLighting"),
    Catagories = { "High", "Low" },
    LightMeshMap = l__SpatialHash__5.NewMap(15, false),
    WorldLighting = {
        TotalLights = 0,
        Lookup = {},
        CurrentLoaded = {},
        LoadedLights = {
            High = 0,
            Low = 0,
            Array = {}
        }
    },
    UpdateRange = function(p6, p7) --[[ Name: UpdateRange, Line 57 ]]
        -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref)
        u2 = p6;
        u3 = p7;
        u4 = math.max(u2, u3);
        u5 = math.ceil(u4 / 15);
    end
};
function u8.Update(p9) --[[ Line: 64 ]]
    -- upvalues: u8 (copy)
    local v10 = u8;
    v10.TimeElapsed = v10.TimeElapsed + p9;
    if u8.TimeElapsed > u8.WorldLightUpdateRate then
        u8.TimeElapsed = 0;
        u8.UpdateWorldLights();
    end;
end;
function u8.UpdateWorldLights() --[[ Line: 74 ]]
    -- upvalues: u8 (copy), u5 (ref), l__Mince__4 (copy)
    if u8.HumanoidRootPart then
        local l__Position__6 = u8.HumanoidRootPart.Position;
        local v11 = u8.LightMeshMap.GetMapPosition(l__Position__6);
        if u8.WorldLighting.LastMapPosition ~= v11 then
            local v12 = u8.LightMeshMap.GetPartsInRadius(l__Position__6, u5, false);
            for _, v13 in ipairs(u8.WorldLighting.CurrentLoaded) do
                if not v12[v13] then
                    u8.DeloadLight(v13);
                end;
            end;
            for _, v14 in ipairs(v12) do
                local _ = u8.WorldLighting.CurrentLoaded[v14];
            end;
            for _, v15 in ipairs(v12) do
                u8.UpdateLightStatus(l__Position__6, v15);
            end;
            u8.WorldLighting.CurrentLoaded = v12;
            u8.WorldLighting.LastMapPosition = v11;
        end;
    end;
    local v16 = math.floor((u8.WorldLighting.LoadedLights.High + u8.WorldLighting.LoadedLights.Low) / u8.WorldLighting.TotalLights * 100);
    l__Mince__4.Config.Stats.WorldChanger[2] = `Loaded Lights:{u8.WorldLighting.LoadedLights.High + u8.WorldLighting.LoadedLights.Low}/{u8.WorldLighting.TotalLights} | High: {u8.WorldLighting.LoadedLights.High} | Low: {u8.WorldLighting.LoadedLights.Low} | Use: {v16}%`;
end;
function u8.UpdateLightStatus(p17, p18) --[[ Line: 110 ]]
    -- upvalues: u8 (copy), u2 (ref)
    local v19 = u8.WorldLighting.Lookup[p18];
    if v19 then
        if u2 < (p17 * Vector3.new(1, 0, 1) - p18.Position * Vector3.new(1, 0, 1)).Magnitude then
            if not v19.Enabled and v19.Type == "Low" then
                for _, v20 in v19.Lights do
                    v20.Enabled = true;
                end;
                v19.Enabled = true;
                local l__LoadedLights__7 = u8.WorldLighting.LoadedLights;
                local l__Type__8 = v19.Type;
                l__LoadedLights__7[l__Type__8] = l__LoadedLights__7[l__Type__8] + 1;
            end;
            if v19.Enabled and v19.Type == "High" then
                for _, v21 in v19.Lights do
                    v21.Enabled = false;
                end;
                v19.Enabled = false;
                local l__LoadedLights__9 = u8.WorldLighting.LoadedLights;
                local l__Type__10 = v19.Type;
                l__LoadedLights__9[l__Type__10] = l__LoadedLights__9[l__Type__10] - 1;
            end;
        else
            if not v19.Enabled and v19.Type == "High" then
                for _, v22 in v19.Lights do
                    v22.Enabled = true;
                end;
                v19.Enabled = true;
                local l__LoadedLights__11 = u8.WorldLighting.LoadedLights;
                local l__Type__12 = v19.Type;
                l__LoadedLights__11[l__Type__12] = l__LoadedLights__11[l__Type__12] + 1;
            end;
            if v19.Enabled and v19.Type == "Low" then
                for _, v23 in v19.Lights do
                    v23.Enabled = false;
                end;
                v19.Enabled = false;
                local l__LoadedLights__13 = u8.WorldLighting.LoadedLights;
                local l__Type__14 = v19.Type;
                l__LoadedLights__13[l__Type__14] = l__LoadedLights__13[l__Type__14] - 1;
            end;
        end;
    else
        u8.LoadGeneric(p18);
    end;
end;
function u8.DeloadLight(p24) --[[ Line: 159 ]]
    -- upvalues: u8 (copy)
    local v25 = u8.WorldLighting.Lookup[p24];
    if v25 then
        if v25.Enabled then
            v25.Enabled = false;
            local l__LoadedLights__15 = u8.WorldLighting.LoadedLights;
            local l__Type__16 = v25.Type;
            l__LoadedLights__15[l__Type__16] = l__LoadedLights__15[l__Type__16] - 1;
            for _, v26 in v25.Lights do
                v26.Enabled = false;
            end;
        end;
    else
        u8.DeloadGeneric(p24);
    end;
end;
function u8.LoadGeneric(p27) --[[ Line: 176 ]]
    -- upvalues: u8 (copy)
    local l__LoadedLights__17 = u8.WorldLighting.LoadedLights;
    l__LoadedLights__17.High = l__LoadedLights__17.High + 1;
    if p27.ClassName == "GBeam" then
        p27.Beam.Enabled = true;
    else
        if p27:IsA("BasePart") then
            for _, v28 in p27:GetChildren() do
                if v28:IsA("ParticleEmitter") then
                    v28.Enabled = true;
                end;
            end;
        end;
    end;
end;
function u8.DeloadGeneric(p29) --[[ Line: 191 ]]
    -- upvalues: u8 (copy)
    local l__LoadedLights__18 = u8.WorldLighting.LoadedLights;
    l__LoadedLights__18.High = l__LoadedLights__18.High - 1;
    if p29.ClassName == "GBeam" then
        p29.Beam.Enabled = false;
    else
        if p29:IsA("BasePart") then
            for _, v30 in p29:GetChildren() do
                if v30:IsA("ParticleEmitter") then
                    v30.Enabled = false;
                end;
            end;
        end;
    end;
end;
function u8.SetupLight(p31, p32) --[[ Line: 205 ]]
    -- upvalues: u8 (copy)
    if u8.CullingLightsDisabled then
    else
        if p32:FindFirstChildWhichIsA("Light") then
            local u33 = {};
            for _, v34 in p32:GetChildren() do
                if v34:IsA("Light") and not v34:IsA("SpotLight") then
                    v34.Enabled = false;
                    table.insert(u33, v34);
                end;
            end;
            p32.ChildAdded:Connect(function(p35) --[[ Line: 218 ]]
                -- upvalues: u33 (copy)
                if p35:IsA("Light") and not p35:IsA("SpotLight") then
                    p35.Enabled = false;
                    table.insert(u33, p35);
                end;
            end);
            u8.WorldLighting.Lookup[p32] = {
                Enabled = false,
                Lights = u33,
                Type = p31
            };
            local l__WorldLighting__19 = u8.WorldLighting;
            l__WorldLighting__19.TotalLights = l__WorldLighting__19.TotalLights + 1;
        end;
    end;
end;
function u8.RespondToWorldQuality(p36) --[[ Line: 236 ]]
    -- upvalues: u8 (copy)
    if p36 == 1 then
        game.Lighting.GlobalShadows = true;
        u8.UpdateRange(130, 200);
        u8.SetCastShadows(true);
        u8.ShadowsEnabled(true);
    elseif p36 == 2 or p36 == 3 then
        game.Lighting.GlobalShadows = false;
        u8.UpdateRange(95, 175);
        u8.SetCastShadows(false);
        u8.ShadowsEnabled(false);
    end;
    u8.WorldLighting.LastMapPosition = nil;
end;
function u8.ShadowsEnabled(p37) --[[ Line: 254 ]]
    -- upvalues: u8 (copy)
    for _, v38 in u8.EnabledShadowsLight do
        v38.Shadows = p37;
    end;
end;
function u8.SetCastShadows(p39) --[[ Line: 261 ]]
    -- upvalues: u8 (copy)
    u8.CastShadowOnParts = p39;
    for _, v40 in u8.WorldMeshesCastShadows do
        v40.CastShadow = p39;
    end;
end;
function u8.Work() --[[ Line: 268 ]]
    -- upvalues: u8 (copy)
    local v41 = u8;
    v41.Pos = v41.Pos + 1;
    if u8.Pos > u8.MaxWork then
        u8.Pos = 0;
        task.wait();
    end;
end;
function u8.Scrape() --[[ Line: 276 ]]
    -- upvalues: u8 (copy)
    local function u43(p42) --[[ Line: 277 ]]
        -- upvalues: u8 (ref)
        if p42:IsA("BasePart") then
            local _ = p42.Material == Enum.Material.Glass;
        end;
        if p42:IsA("Light") then
            if p42.Shadows then
                table.insert(u8.EnabledShadowsLight, p42);
            end;
            u8.AttemptRegisterNewLightPart("High", p42.Parent);
        end;
        if p42:IsA("Beam") and p42.Attachment0 then
            local _ = {
                Orientation = Vector3.new(0, 0, 0),
                Size = Vector3.new(1, 1, 1),
                ClassName = "GBeam",
                CFrame = p42.Attachment0.WorldCFrame,
                Position = p42.Attachment0.WorldCFrame.Position,
                Beam = p42
            };
        end;
        if p42:IsA("ParticleEmitter") and not p42:FindFirstAncestorWhichIsA("BasePart") then
            warn("Attempt to register particle emitter but no ancestor");
        else
            if p42:IsA("BasePart") and p42.CastShadow then
                p42.CastShadow = u8.CastShadowOnParts;
                table.insert(u8.WorldMeshesCastShadows, p42);
            end;
            u8.Work();
        end;
    end;
    task.spawn(function() --[[ Line: 329 ]]
        -- upvalues: u43 (copy)
        for _, v44 in game.Workspace:GetDescendants() do
            u43(v44);
        end;
    end);
    local u46 = game.Workspace.DescendantAdded:Connect(function(p45) --[[ Line: 338 ]]
        -- upvalues: u43 (copy)
        u43(p45);
    end);
    task.delay(180, function() --[[ Line: 343 ]]
        -- upvalues: u46 (copy)
        u46:Disconnect();
    end);
end;
function u8.RegisterNewGeneric(p47) --[[ Line: 349 ]]
    -- upvalues: u8 (copy)
    if u8.WorldGenericWhitelisted[p47] then
    else
        local l__WorldLighting__20 = u8.WorldLighting;
        l__WorldLighting__20.TotalLights = l__WorldLighting__20.TotalLights + 1;
        u8.WorldGenericWhitelisted[p47] = true;
        u8.LightMeshMap.Add(p47);
        if p47.ClassName == "GBeam" then
            p47.Beam.Enabled = false;
        else
            if p47:IsA("BasePart") then
                for _, v48 in p47:GetChildren() do
                    if v48:IsA("ParticleEmitter") then
                        v48.Enabled = false;
                    end;
                end;
            end;
        end;
    end;
end;
function u8.AttemptRegisterNewLightPart(p49, p50) --[[ Line: 371 ]]
    -- upvalues: u8 (copy)
    if p50:IsA("BasePart") then
        if p50:GetAttribute("IgnoreWorldLightControl") then
        elseif p50:IsA("BasePart") then
            if u8.RegisteredLighting[p50] then
            else
                u8.RegisteredLighting[p50] = true;
                u8.LightMeshMap.Add(p50);
                u8.SetupLight(p49, p50);
                table.insert(u8.WorldLighting[p49], p50);
            end;
        end;
    end;
end;
function u8.LightingScrape() --[[ Line: 392 ]]
    -- upvalues: u8 (copy)
    u8.RegisteredLighting = {};
    for _, u51 in u8.Catagories do
        local v52 = u8.DynamicLightFolder:WaitForChild(u51);
        if v52 then
            u8.WorldLighting[u51] = {};
            local function v54(p53) --[[ Line: 401 ]]
                -- upvalues: u8 (ref), u51 (copy)
                u8.AttemptRegisterNewLightPart(u51, p53);
            end;
            for _, v55 in v52:GetChildren() do
                u8.AttemptRegisterNewLightPart(u51, v55);
            end;
            v52.ChildAdded:Connect(v54);
        end;
    end;
    u8.LightingScrapeCompleted = true;
end;
function u8.Setup() --[[ Line: 417 ]]
    -- upvalues: u8 (copy), u1 (copy)
    u8.DoSetup();
    repeat
        task.wait();
    until u8.LightingScrapeCompleted;
    u8.Scrape();
    u1.SettingChanged("GraphicMode"):Connect(function(p56) --[[ Line: 422 ]]
        -- upvalues: u8 (ref)
        u8.RespondToWorldQuality(p56);
    end);
    task.delay(30, function() --[[ Line: 426 ]]
        -- upvalues: u1 (ref), u8 (ref)
        local v57 = u1.GetValue("GraphicMode");
        u8.RespondToWorldQuality(v57);
    end);
    local v58 = u1.GetValue("GraphicMode");
    u8.RespondToWorldQuality(v58);
end;
function u8.DoSetup() --[[ Line: 435 ]]
    -- upvalues: u8 (copy), l__RunService__2 (copy), l__Mince__4 (copy), l__LocalPlayer__3 (copy)
    if not u8.CullingLightsDisabled then
        l__RunService__2.Heartbeat:Connect(u8.Update);
    end;
    local function v60(p59) --[[ Line: 445 ]]
        -- upvalues: u8 (ref)
        local l__Humanoid__21 = p59:WaitForChild("Humanoid");
        u8.HumanoidRootPart = p59:WaitForChild("HumanoidRootPart");
        l__Humanoid__21.Died:Connect(function() --[[ Line: 450 ]]
            -- upvalues: u8 (ref)
            u8.HumanoidRootPart = nil;
        end);
    end;
    l__Mince__4.Config.Stats.WorldChanger = { 4, "IDLE" };
    l__LocalPlayer__3.CharacterAdded:Connect(v60);
    if l__LocalPlayer__3.Character then
        task.spawn(v60, l__LocalPlayer__3.Character);
    end;
    u8.LightingScrape();
end;
return u8;
