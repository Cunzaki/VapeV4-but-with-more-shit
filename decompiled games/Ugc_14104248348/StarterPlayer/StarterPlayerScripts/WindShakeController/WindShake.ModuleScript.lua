-- Decompiled from: StarterPlayer.StarterPlayerScripts.WindShakeController.WindShake
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__RunService__2 = game:GetService("RunService");
local l__Settings__3 = require(script.Settings);
local l__VectorMap__4 = require(script.VectorMap);
local u1 = {
    WindDirection = Vector3.new(0.5, 0, 0.5),
    WindSpeed = 20,
    WindPower = 0.5
};
local u2 = Instance.new("BindableEvent");
local u3 = Instance.new("BindableEvent");
local u4 = Instance.new("BindableEvent");
local u5 = Instance.new("BindableEvent");
local u6 = Instance.new("BindableEvent");
return {
    RenderDistance = 150,
    MaxRefreshRate = 0.016666666666666666,
    Handled = 0,
    Active = 0,
    SharedSettings = l__Settings__3.new(script),
    ObjectMetadata = {},
    VectorMap = l__VectorMap__4.new(),
    _partList = table.create(500),
    _cframeList = table.create(500),
    ObjectShakeAdded = u2.Event,
    ObjectShakeRemoved = u3.Event,
    ObjectShakeUpdated = u4.Event,
    Paused = u5.Event,
    Resumed = u6.Event,
    Connect = function(u7, p8, p9) --[[ Name: Connect, Line 62 ]]
        local u10 = u7[p8];
        local v11 = typeof(u10) == "function";
        assert(v11, "Unknown function: " .. p8);
        return p9:Connect(function(...) --[[ Line: 66 ]]
            -- upvalues: u10 (copy), u7 (copy)
            return u10(u7, ...);
        end);
    end,
    AddObjectShake = function(p12, p13, p14) --[[ Name: AddObjectShake, Line 71 ]]
        -- upvalues: l__Settings__3 (copy), u2 (copy)
        if typeof(p13) == "Instance" then
            if p13:IsA("BasePart") or p13:IsA("Bone") then
                local l__ObjectMetadata__5 = p12.ObjectMetadata;
                if l__ObjectMetadata__5[p13] then
                else
                    p12.Handled = p12.Handled + 1;
                    local v15 = {};
                    local l__VectorMap__6 = p12.VectorMap;
                    local v16;
                    if p13:IsA("Bone") then
                        v16 = p13.WorldPosition;
                    else
                        v16 = p13.Position;
                    end;
                    v15.ChunkKey = l__VectorMap__6:AddObject(v16, p13);
                    v15.Settings = l__Settings__3.new(p13);
                    v15.Seed = math.random(5000) * 0.32;
                    local v17;
                    if p13:IsA("Bone") then
                        v17 = p13.WorldCFrame;
                    else
                        v17 = p13.CFrame;
                    end;
                    v15.Origin = v17;
                    v15.LastUpdate = os.clock();
                    l__ObjectMetadata__5[p13] = v15;
                    if p14 then
                        p12:UpdateObjectSettings(p13, p14);
                    end;
                    u2:Fire(p13);
                end;
            end;
        end;
    end,
    RemoveObjectShake = function(p18, p19) --[[ Name: RemoveObjectShake, Line 107 ]]
        -- upvalues: u3 (copy)
        if typeof(p19) == "Instance" then
            local l__ObjectMetadata__7 = p18.ObjectMetadata;
            local v20 = l__ObjectMetadata__7[p19];
            if v20 then
                p18.Handled = p18.Handled - 1;
                l__ObjectMetadata__7[p19] = nil;
                v20.Settings:Destroy();
                p18.VectorMap:RemoveObject(v20.ChunkKey, p19);
                if p19:IsA("BasePart") then
                    p19.CFrame = v20.Origin;
                elseif p19:IsA("Bone") then
                    p19.WorldCFrame = v20.Origin;
                end;
            end;
            u3:Fire(p19);
        end;
    end,
    Update = function(p21, p22) --[[ Name: Update, Line 131 ]]
        debug.profilebegin("WindShake");
        local u23 = 0;
        debug.profilebegin("Update");
        local u24 = os.clock();
        local u25 = p22 * 3;
        local u26 = math.min(1, p22 * 5);
        local u27 = 0;
        local l___partList__8 = p21._partList;
        local l___cframeList__9 = p21._cframeList;
        table.clear(l___partList__8);
        table.clear(l___cframeList__9);
        local l__ObjectMetadata__10 = p21.ObjectMetadata;
        local l__CurrentCamera__11 = workspace.CurrentCamera;
        local l__Position__12 = l__CurrentCamera__11.CFrame.Position;
        local l__RenderDistance__13 = p21.RenderDistance;
        local l__MaxRefreshRate__14 = p21.MaxRefreshRate;
        local l__SharedSettings__15 = p21.SharedSettings;
        local l__WindPower__16 = l__SharedSettings__15.WindPower;
        local l__WindSpeed__17 = l__SharedSettings__15.WindSpeed;
        local l__WindDirection__18 = l__SharedSettings__15.WindDirection;
        p21.VectorMap:ForEachObjectInView(l__CurrentCamera__11, l__RenderDistance__13, function(p28, p29) --[[ Line: 161 ]]
            -- upvalues: l__ObjectMetadata__10 (copy), l__Position__12 (copy), l__RenderDistance__13 (copy), u25 (copy), l__MaxRefreshRate__14 (copy), u24 (copy), u23 (ref), l__WindDirection__18 (copy), l__WindPower__16 (copy), l__WindSpeed__17 (copy), u26 (copy), u27 (ref), l___partList__8 (copy), l___cframeList__9 (copy)
            local v30 = l__ObjectMetadata__10[p29];
            local v31 = v30.LastUpdate or 0;
            local v32 = p28 == "Bone";
            local v33;
            if v32 then
                v33 = p29.WorldCFrame;
            else
                v33 = p29.CFrame;
            end;
            local v34 = (l__Position__12 - v33.Position).Magnitude / l__RenderDistance__13;
            local v35 = v34 * v34;
            local v36 = 1 / math.random(60, 120);
            if u25 * v35 + l__MaxRefreshRate__14 >= u24 - v31 + v36 then
            else
                v30.LastUpdate = u24;
                u23 = u23 + 1;
                local l__Settings__19 = v30.Settings;
                local v37 = l__Settings__19.WindDirection or l__WindDirection__18;
                if v37.Magnitude < 0.00001 then
                else
                    local v38 = (l__Settings__19.WindPower or l__WindPower__16) * 0.2;
                    if v38 < 0.00001 then
                    else
                        local v39 = u24 * ((l__Settings__19.WindSpeed or l__WindSpeed__17) * 0.08);
                        if v39 < 0.00001 then
                        else
                            local l__Seed__20 = v30.Seed;
                            local v40 = (math.noise(v39, 0, l__Seed__20) + 0.4) * v38;
                            local v41 = math.clamp(u26 + v35, 0.1, 0.5);
                            local v42 = v38 / 3;
                            local v43 = v30.Origin * (l__Settings__19.PivotOffset or CFrame.identity);
                            local v44 = v43:VectorToObjectSpace(v37);
                            if v32 then
                                p29.Transform = p29.Transform:Lerp(CFrame.fromAxisAngle(v44:Cross(Vector3.new(0, 1, 0)), -v40) * CFrame.Angles(math.noise(l__Seed__20, 0, v39) * v42, math.noise(l__Seed__20, v39, 0) * v42, math.noise(v39, l__Seed__20, 0) * v42) + v44 * v40 * v38, v41);
                            else
                                u27 = u27 + 1;
                                l___partList__8[u27] = p29;
                                l___cframeList__9[u27] = v33:Lerp(v43 * CFrame.fromAxisAngle(v44:Cross(Vector3.new(0, 1, 0)), -v40) * CFrame.Angles(math.noise(l__Seed__20, 0, v39) * v42, math.noise(l__Seed__20, v39, 0) * v42, math.noise(v39, l__Seed__20, 0) * v42) * (l__Settings__19.PivotOffsetInverse or CFrame.identity) + v37 * v40 * (v38 * 2), v41);
                            end;
                        end;
                    end;
                end;
            end;
        end);
        p21.Active = u23;
        debug.profileend();
        workspace:BulkMoveTo(l___partList__8, l___cframeList__9, Enum.BulkMoveMode.FireCFrameChanged);
        debug.profileend();
    end,
    Pause = function(p45) --[[ Name: Pause, Line 247 ]]
        -- upvalues: u5 (copy)
        if p45.UpdateConnection then
            p45.UpdateConnection:Disconnect();
            p45.UpdateConnection = nil;
        end;
        p45.Active = 0;
        p45.Running = false;
        u5:Fire();
    end,
    Resume = function(p46) --[[ Name: Resume, Line 259 ]]
        -- upvalues: l__RunService__2 (copy), u6 (copy)
        if p46.Running then
        else
            p46.Running = true;
            p46.UpdateConnection = p46:Connect("Update", l__RunService__2.Heartbeat);
            u6:Fire();
        end;
    end,
    Init = function(u47, p48) --[[ Name: Init, Line 272 ]]
        -- upvalues: u1 (copy), l__CollectionService__1 (copy)
        if u47.Initialized then
        else
            local v49 = script:GetAttribute("WindPower");
            local v50 = script:GetAttribute("WindSpeed");
            local v51 = script:GetAttribute("WindDirection");
            if typeof(v49) ~= "number" then
                script:SetAttribute("WindPower", u1.WindPower);
            end;
            if typeof(v50) ~= "number" then
                script:SetAttribute("WindSpeed", u1.WindSpeed);
            end;
            if typeof(v51) ~= "Vector3" then
                script:SetAttribute("WindDirection", u1.WindDirection);
            end;
            u47:Cleanup();
            u47.Initialized = true;
            u47.AddedConnection = u47:Connect("AddObjectShake", (l__CollectionService__1:GetInstanceAddedSignal("WindShake")));
            u47.RemovedConnection = u47:Connect("RemoveObjectShake", (l__CollectionService__1:GetInstanceRemovedSignal("WindShake")));
            for _, v52 in l__CollectionService__1:GetTagged("WindShake") do
                u47:AddObjectShake(v52);
            end;
            if p48 and p48.MatchWorkspaceWind then
                u47:MatchWorkspaceWind();
                u47.WorkspaceWindConnection = workspace:GetPropertyChangedSignal("GlobalWind"):Connect(function() --[[ Line: 312 ]]
                    -- upvalues: u47 (copy)
                    u47:MatchWorkspaceWind();
                end);
            end;
            u47:Resume();
        end;
    end,
    Cleanup = function(p53) --[[ Name: Cleanup, Line 321 ]]
        if p53.Initialized then
            p53:Pause();
            if p53.AddedConnection then
                p53.AddedConnection:Disconnect();
                p53.AddedConnection = nil;
            end;
            if p53.RemovedConnection then
                p53.RemovedConnection:Disconnect();
                p53.RemovedConnection = nil;
            end;
            if p53.WorkspaceWindConnection then
                p53.WorkspaceWindConnection:Disconnect();
                p53.WorkspaceWindConnection = nil;
            end;
            table.clear(p53.ObjectMetadata);
            p53.VectorMap:ClearAll();
            p53.Handled = 0;
            p53.Active = 0;
            p53.Initialized = false;
        end;
    end,
    UpdateObjectSettings = function(p54, p55, p56) --[[ Name: UpdateObjectSettings, Line 351 ]]
        -- upvalues: u4 (copy)
        if typeof(p55) == "Instance" then
            if typeof(p56) == "table" then
                if p54.ObjectMetadata[p55] or p55 == script then
                    for v57, v58 in p56 do
                        p55:SetAttribute(v57, v58);
                    end;
                    u4:Fire(p55);
                end;
            end;
        end;
    end,
    UpdateAllObjectSettings = function(p59, p60) --[[ Name: UpdateAllObjectSettings, Line 371 ]]
        -- upvalues: u4 (copy)
        if typeof(p60) == "table" then
            for v61, _ in p59.ObjectMetadata do
                for v62, v63 in p60 do
                    v61:SetAttribute(v62, v63);
                end;
                u4:Fire(v61);
            end;
        end;
    end,
    SetDefaultSettings = function(p64, p65) --[[ Name: SetDefaultSettings, Line 384 ]]
        p64:UpdateObjectSettings(script, p65);
    end,
    MatchWorkspaceWind = function(p66) --[[ Name: MatchWorkspaceWind, Line 388 ]]
        local l__GlobalWind__21 = workspace.GlobalWind;
        local l__Unit__22 = l__GlobalWind__21.Unit;
        local l__Magnitude__23 = l__GlobalWind__21.Magnitude;
        local v67, v68;
        if l__Magnitude__23 > 0 then
            v67 = l__Magnitude__23 <= 1 and 0.3 or math.log10(l__Magnitude__23) + 0.2;
            if l__Magnitude__23 < 100 then
                v68 = l__Magnitude__23 * 1.2 + 5;
            else
                v68 = 125;
            end;
        else
            v68 = 0;
            v67 = 0;
        end;
        p66:SetDefaultSettings({
            WindDirection = l__Unit__22,
            WindSpeed = v68,
            WindPower = v67
        });
    end
};
