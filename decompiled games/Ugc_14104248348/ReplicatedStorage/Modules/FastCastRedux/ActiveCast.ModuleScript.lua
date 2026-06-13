-- Decompiled from: ReplicatedStorage.Modules.FastCastRedux.ActiveCast
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.TypeDefinitions);
local l__TypeMarshaller__1 = require(script.Parent.TypeMarshaller);
local u1 = {};
u1.__index = u1;
u1.__type = "ActiveCast";
local l__RunService__2 = game:GetService("RunService");
local l__Table__3 = require(script.Parent.Table);
local u2 = nil;
function DbgVisualizeSegment(p3, p4)
    -- upvalues: u2 (ref)
    if u2.VisualizeCasts ~= true then
        return nil;
    end;
    local v5 = Instance.new("ConeHandleAdornment");
    v5.Adornee = workspace.Terrain;
    v5.CFrame = p3;
    v5.Height = p4;
    v5.Color3 = Color3.new();
    v5.Radius = 0.25;
    v5.Transparency = 0.5;
    local v6 = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects");
    if v6 == nil then
        v6 = Instance.new("Folder");
        v6.Name = "FastCastVisualizationObjects";
        v6.Archivable = false;
        v6.Parent = workspace.Terrain;
    end;
    v5.Parent = v6;
    return v5;
end;
function DbgVisualizeHit(p7, p8)
    -- upvalues: u2 (ref)
    if u2.VisualizeCasts ~= true then
        return nil;
    end;
    local v9 = Instance.new("SphereHandleAdornment");
    v9.Adornee = workspace.Terrain;
    v9.CFrame = p7;
    v9.Radius = 0.4;
    v9.Transparency = 0.25;
    v9.Color3 = p8 == false and Color3.new(0.2, 1, 0.5) or Color3.new(1, 0.2, 0.2);
    local v10 = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects");
    if v10 == nil then
        v10 = Instance.new("Folder");
        v10.Name = "FastCastVisualizationObjects";
        v10.Archivable = false;
        v10.Parent = workspace.Terrain;
    end;
    v9.Parent = v10;
    return v9;
end;
local function u17(p11, p12) --[[ Line: 130 ]]
    assert(p11.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v13 = p11.StateInfo.Trajectories[p12];
    local v14 = v13.EndTime - v13.StartTime;
    local l__Origin__4 = v13.Origin;
    local l__InitialVelocity__5 = v13.InitialVelocity;
    local l__Acceleration__6 = v13.Acceleration;
    local v15 = {};
    local v16 = Vector3.new(l__Acceleration__6.X * v14 ^ 2 / 2, l__Acceleration__6.Y * v14 ^ 2 / 2, l__Acceleration__6.Z * v14 ^ 2 / 2);
    v15[1], v15[2] = l__Origin__4 + l__InitialVelocity__5 * v14 + v16, l__InitialVelocity__5 + l__Acceleration__6 * v14;
    return v15;
end;
local function u51(p18, p19, p20) --[[ Line: 173 ]]
    -- upvalues: u2 (ref), l__Table__3 (copy)
    assert(p18.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    if u2.DebugLogging == true then
        print("Casting for frame.");
    end;
    local v21 = p18.StateInfo.Trajectories[#p18.StateInfo.Trajectories];
    local l__Origin__7 = v21.Origin;
    local v22 = p18.StateInfo.TotalRuntime - v21.StartTime;
    local l__InitialVelocity__8 = v21.InitialVelocity;
    local l__Acceleration__9 = v21.Acceleration;
    local v23 = Vector3.new(l__Acceleration__9.X * v22 ^ 2 / 2, l__Acceleration__9.Y * v22 ^ 2 / 2, l__Acceleration__9.Z * v22 ^ 2 / 2);
    local v24 = l__Origin__7 + l__InitialVelocity__8 * v22 + v23;
    local _ = l__InitialVelocity__8 + l__Acceleration__9 * v22;
    local v25 = p18.StateInfo.TotalRuntime - v21.StartTime;
    local l__StateInfo__10 = p18.StateInfo;
    l__StateInfo__10.TotalRuntime = l__StateInfo__10.TotalRuntime + p19;
    local v26 = p18.StateInfo.TotalRuntime - v21.StartTime;
    local v27 = Vector3.new(l__Acceleration__9.X * v26 ^ 2 / 2, l__Acceleration__9.Y * v26 ^ 2 / 2, l__Acceleration__9.Z * v26 ^ 2 / 2);
    local v28 = l__Origin__7 + l__InitialVelocity__8 * v26 + v27;
    local v29 = l__InitialVelocity__8 + l__Acceleration__9 * v26;
    local v30 = (v28 - v24).Unit * v29.Magnitude * p19;
    local l__WorldRoot__11 = p18.RayInfo.WorldRoot;
    local v31 = l__WorldRoot__11:Raycast(v24, v30, p18.RayInfo.Parameters);
    local l__Air__12 = Enum.Material.Air;
    Vector3.new();
    local v32, v33;
    if v31 == nil then
        v32 = v28;
        v33 = nil;
    else
        v32 = v31.Position;
        v33 = v31.Instance;
        l__Air__12 = v31.Material;
        local _ = v31.Normal;
    end;
    local l__Magnitude__13 = (v32 - v24).Magnitude;
    p18.Caster.LengthChanged:Fire(p18, v24, v30.Unit, l__Magnitude__13, v29, p18.RayInfo.CosmeticBulletObject);
    local l__StateInfo__14 = p18.StateInfo;
    l__StateInfo__14.DistanceCovered = l__StateInfo__14.DistanceCovered + l__Magnitude__13;
    local v34;
    if p19 > 0 then
        v34 = DbgVisualizeSegment(CFrame.new(v24, v24 + v30), l__Magnitude__13);
    else
        v34 = nil;
    end;
    if v33 and v33 ~= p18.RayInfo.CosmeticBulletObject then
        tick();
        if u2.DebugLogging == true then
            print("Hit something, testing now.");
        end;
        if p18.RayInfo.CanPierceCallback ~= nil then
            if p20 == false and p18.StateInfo.IsActivelySimulatingPierce then
                p18:Terminate();
                error("ERROR: The latest call to CanPierceCallback took too long to complete! This cast is going to suffer desyncs which WILL cause unexpected behavior and errors. Please fix your performance problems, or remove statements that yield (e.g. wait() calls)");
            end;
            p18.StateInfo.IsActivelySimulatingPierce = true;
        end;
        if p18.RayInfo.CanPierceCallback == nil or p18.RayInfo.CanPierceCallback ~= nil and p18.RayInfo.CanPierceCallback(p18, v31, v29, p18.RayInfo.CosmeticBulletObject) == false then
            if u2.DebugLogging == true then
                print("Piercing function is nil or it returned FALSE to not pierce this hit.");
            end;
            p18.StateInfo.IsActivelySimulatingPierce = false;
            if p18.StateInfo.HighFidelityBehavior == 2 and (v21.Acceleration ~= Vector3.new() and p18.StateInfo.HighFidelitySegmentSize ~= 0) then
                p18.StateInfo.CancelHighResCast = false;
                if p18.StateInfo.IsActivelyResimulating then
                    p18:Terminate();
                    error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.");
                end;
                p18.StateInfo.IsActivelyResimulating = true;
                if u2.DebugLogging == true then
                    print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...");
                end;
                local v35 = math.floor(l__Magnitude__13 / p18.StateInfo.HighFidelitySegmentSize);
                local _ = l__Magnitude__13 / v35;
                local v36 = p19 / v35;
                for v37 = 1, v35 do
                    if p18.StateInfo.CancelHighResCast then
                        p18.StateInfo.CancelHighResCast = false;
                        break;
                    end;
                    local v38 = v25 + v36 * v37;
                    local v39 = Vector3.new(l__Acceleration__9.X * v38 ^ 2 / 2, l__Acceleration__9.Y * v38 ^ 2 / 2, l__Acceleration__9.Z * v38 ^ 2 / 2);
                    local v40 = l__Origin__7 + l__InitialVelocity__8 * v38 + v39;
                    local v41 = l__InitialVelocity__8 + l__Acceleration__9 * (v25 + v36 * v37);
                    local v42 = l__WorldRoot__11:Raycast(v40, v41 * p19, p18.RayInfo.Parameters);
                    local l__Magnitude__15 = (v40 - (v40 + v41)).Magnitude;
                    if v42 == nil then
                        local v43 = DbgVisualizeSegment(CFrame.new(v40, v40 + v41), l__Magnitude__15);
                        if v43 ~= nil then
                            v43.Color3 = Color3.new(0.286275, 0.329412, 0.247059);
                        end;
                    else
                        local l__Magnitude__16 = (v40 - v42.Position).Magnitude;
                        local v44 = DbgVisualizeSegment(CFrame.new(v40, v40 + v41), l__Magnitude__16);
                        if v44 ~= nil then
                            v44.Color3 = Color3.new(0.286275, 0.329412, 0.247059);
                        end;
                        if p18.RayInfo.CanPierceCallback == nil or p18.RayInfo.CanPierceCallback ~= nil and p18.RayInfo.CanPierceCallback(p18, v42, v41, p18.RayInfo.CosmeticBulletObject) == false then
                            p18.StateInfo.IsActivelyResimulating = false;
                            p18.Caster.RayHit:Fire(p18, v42, v41, p18.RayInfo.CosmeticBulletObject);
                            p18:Terminate();
                            local v45 = DbgVisualizeHit(CFrame.new(v32), false);
                            if v45 ~= nil then
                                v45.Color3 = Color3.new(0.0588235, 0.87451, 1);
                            end;
                            return;
                        end;
                        p18.Caster.RayPierced:Fire(p18, v42, v41, p18.RayInfo.CosmeticBulletObject);
                        local v46 = DbgVisualizeHit(CFrame.new(v32), true);
                        if v46 ~= nil then
                            v46.Color3 = Color3.new(1, 0.113725, 0.588235);
                        end;
                        if v44 ~= nil then
                            v44.Color3 = Color3.new(0.305882, 0.243137, 0.329412);
                        end;
                    end;
                end;
                p18.StateInfo.IsActivelyResimulating = false;
            else
                if p18.StateInfo.HighFidelityBehavior == 1 or p18.StateInfo.HighFidelityBehavior == 3 then
                    if u2.DebugLogging == true then
                        print("Hit was successful. Terminating.");
                    end;
                    p18.Caster.RayHit:Fire(p18, v31, v29, p18.RayInfo.CosmeticBulletObject);
                    p18:Terminate();
                    DbgVisualizeHit(CFrame.new(v32), false);
                    return;
                end;
                p18:Terminate();
                error("Invalid value " .. p18.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.");
            end;
        else
            if u2.DebugLogging == true then
                print("Piercing function returned TRUE to pierce this part.");
            end;
            if v34 ~= nil then
                v34.Color3 = Color3.new(0.4, 0.05, 0.05);
            end;
            DbgVisualizeHit(CFrame.new(v32), true);
            local l__Parameters__17 = p18.RayInfo.Parameters;
            local l__FilterDescendantsInstances__18 = l__Parameters__17.FilterDescendantsInstances;
            local v47 = {};
            local v48 = false;
            local v49 = 0;
            while true do
                if v31.Instance:IsA("Terrain") and l__Air__12 == Enum.Material.Water then
                    p18:Terminate();
                    error("Do not add Water as a piercable material. If you need to pierce water, set cast.RayInfo.Parameters.IgnoreWater = true instead", 0);
                end;
                if l__Parameters__17.FilterType == Enum.RaycastFilterType.Blacklist then
                    local l__FilterDescendantsInstances__19 = l__Parameters__17.FilterDescendantsInstances;
                    l__Table__3.insert(l__FilterDescendantsInstances__19, v31.Instance);
                    l__Table__3.insert(v47, v31.Instance);
                    l__Parameters__17.FilterDescendantsInstances = l__FilterDescendantsInstances__19;
                else
                    local l__FilterDescendantsInstances__20 = l__Parameters__17.FilterDescendantsInstances;
                    l__Table__3.removeObject(l__FilterDescendantsInstances__20, v31.Instance);
                    l__Table__3.insert(v47, v31.Instance);
                    l__Parameters__17.FilterDescendantsInstances = l__FilterDescendantsInstances__20;
                end;
                p18.Caster.RayPierced:Fire(p18, v31, v29, p18.RayInfo.CosmeticBulletObject);
                v31 = l__WorldRoot__11:Raycast(v24, v30, l__Parameters__17);
                if v31 == nil then
                    break;
                end;
                if v49 >= 100 then
                    warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)");
                    break;
                end;
                v49 = v49 + 1;
                if p18.RayInfo.CanPierceCallback(p18, v31, v29, p18.RayInfo.CosmeticBulletObject) == false then
                    v48 = true;
                    break;
                end;
            end;
            p18.RayInfo.Parameters.FilterDescendantsInstances = l__FilterDescendantsInstances__18;
            p18.StateInfo.IsActivelySimulatingPierce = false;
            if v48 then
                local v50 = "Broke because the ray hit something solid (" .. tostring(v31.Instance) .. ") while testing for a pierce. Terminating the cast.";
                if u2.DebugLogging == true then
                    print(v50);
                end;
                p18.Caster.RayHit:Fire(p18, v31, v29, p18.RayInfo.CosmeticBulletObject);
                p18:Terminate();
                DbgVisualizeHit(CFrame.new(v31.Position), false);
                return;
            end;
        end;
    end;
    if p18.StateInfo.DistanceCovered >= p18.RayInfo.MaxDistance then
        p18:Terminate();
        DbgVisualizeHit(CFrame.new(v28), false);
    end;
end;
function u1.new(p52, p53, p54, p55, p56) --[[ Line: 422 ]]
    -- upvalues: l__TypeMarshaller__1 (copy), l__Table__3 (copy), l__RunService__2 (copy), u1 (copy), u2 (ref), u51 (copy)
    if l__TypeMarshaller__1(p55) == "number" then
        p55 = p54.Unit * p55;
    end;
    if p56.HighFidelitySegmentSize <= 0 then
        error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0);
    end;
    local u57 = {
        Caster = p52,
        StateInfo = {
            UpdateConnection = nil,
            Paused = false,
            TotalRuntime = 0,
            DistanceCovered = 0,
            IsActivelySimulatingPierce = false,
            IsActivelyResimulating = false,
            CancelHighResCast = false,
            HighFidelitySegmentSize = p56.HighFidelitySegmentSize,
            HighFidelityBehavior = p56.HighFidelityBehavior,
            Trajectories = {
                {
                    StartTime = 0,
                    EndTime = -1,
                    Origin = p53,
                    InitialVelocity = p55,
                    Acceleration = p56.Acceleration
                }
            }
        },
        RayInfo = {
            Parameters = p56.RaycastParams,
            WorldRoot = workspace,
            MaxDistance = p56.MaxDistance or 1000,
            CosmeticBulletObject = p56.CosmeticBulletTemplate,
            CanPierceCallback = p56.CanPierceFunction
        },
        UserData = {}
    };
    if u57.StateInfo.HighFidelityBehavior == 2 then
        u57.StateInfo.HighFidelityBehavior = 3;
    end;
    if u57.RayInfo.Parameters == nil then
        u57.RayInfo.Parameters = RaycastParams.new();
    else
        local l__RayInfo__21 = u57.RayInfo;
        local l__Parameters__22 = u57.RayInfo.Parameters;
        local v58 = RaycastParams.new();
        v58.CollisionGroup = l__Parameters__22.CollisionGroup;
        v58.FilterType = l__Parameters__22.FilterType;
        v58.FilterDescendantsInstances = l__Parameters__22.FilterDescendantsInstances;
        v58.IgnoreWater = l__Parameters__22.IgnoreWater;
        l__RayInfo__21.Parameters = v58;
    end;
    local v59 = false;
    if p56.CosmeticBulletProvider == nil then
        if u57.RayInfo.CosmeticBulletObject ~= nil then
            u57.RayInfo.CosmeticBulletObject = u57.RayInfo.CosmeticBulletObject:Clone();
            u57.RayInfo.CosmeticBulletObject:PivotTo(CFrame.new(p53, p53 + p54));
            u57.RayInfo.CosmeticBulletObject.Parent = p56.CosmeticBulletContainer;
        end;
    elseif l__TypeMarshaller__1(p56.CosmeticBulletProvider) == "PartCache" then
        if u57.RayInfo.CosmeticBulletObject ~= nil then
            warn("Do not define FastCastBehavior.CosmeticBulletTemplate and FastCastBehavior.CosmeticBulletProvider at the same time! The provider will be used, and CosmeticBulletTemplate will be set to nil.");
            u57.RayInfo.CosmeticBulletObject = nil;
            p56.CosmeticBulletTemplate = nil;
        end;
        u57.RayInfo.CosmeticBulletObject = p56.CosmeticBulletProvider:GetPart();
        u57.RayInfo.CosmeticBulletObject:PivotTo(CFrame.new(p53, p53 + p54));
        v59 = true;
    else
        warn("FastCastBehavior.CosmeticBulletProvider was not an instance of the PartCache module (an external/separate model)! Are you inputting an instance created via PartCache.new? If so, are you on the latest version of PartCache? Setting FastCastBehavior.CosmeticBulletProvider to nil.");
        p56.CosmeticBulletProvider = nil;
    end;
    local v60;
    if v59 then
        v60 = p56.CosmeticBulletProvider.CurrentCacheParent;
    else
        v60 = p56.CosmeticBulletContainer;
    end;
    if p56.AutoIgnoreContainer == true and v60 ~= nil then
        local l__FilterDescendantsInstances__23 = u57.RayInfo.Parameters.FilterDescendantsInstances;
        if l__Table__3.find(l__FilterDescendantsInstances__23, v60) == nil then
            l__Table__3.insert(l__FilterDescendantsInstances__23, v60);
            u57.RayInfo.Parameters.FilterDescendantsInstances = l__FilterDescendantsInstances__23;
        end;
    end;
    local v61;
    if l__RunService__2:IsClient() then
        v61 = l__RunService__2.RenderStepped;
    else
        v61 = l__RunService__2.Heartbeat;
    end;
    setmetatable(u57, u1);
    u57.StateInfo.UpdateConnection = v61:Connect(function(p62) --[[ Line: 535 ]]
        -- upvalues: u57 (copy), u2 (ref), u51 (ref)
        if u57.StateInfo.Paused then
            return;
        end;
        if u2.DebugLogging == true then
            print("Casting for frame.");
        end;
        local v63 = u57.StateInfo.Trajectories[#u57.StateInfo.Trajectories];
        if u57.StateInfo.HighFidelityBehavior == 3 and (v63.Acceleration ~= Vector3.new() and u57.StateInfo.HighFidelitySegmentSize > 0) then
            local v64 = tick();
            if u57.StateInfo.IsActivelyResimulating then
                u57:Terminate();
                error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.");
            end;
            u57.StateInfo.IsActivelyResimulating = true;
            local l__Origin__24 = v63.Origin;
            local v65 = u57.StateInfo.TotalRuntime - v63.StartTime;
            local l__InitialVelocity__25 = v63.InitialVelocity;
            local l__Acceleration__26 = v63.Acceleration;
            local v66 = Vector3.new(l__Acceleration__26.X * v65 ^ 2 / 2, l__Acceleration__26.Y * v65 ^ 2 / 2, l__Acceleration__26.Z * v65 ^ 2 / 2);
            local v67 = l__Origin__24 + l__InitialVelocity__25 * v65 + v66;
            local _ = l__InitialVelocity__25 + l__Acceleration__26 * v65;
            local _ = u57.StateInfo.TotalRuntime - v63.StartTime;
            local l__StateInfo__27 = u57.StateInfo;
            l__StateInfo__27.TotalRuntime = l__StateInfo__27.TotalRuntime + p62;
            local v68 = u57.StateInfo.TotalRuntime - v63.StartTime;
            local v69 = Vector3.new(l__Acceleration__26.X * v68 ^ 2 / 2, l__Acceleration__26.Y * v68 ^ 2 / 2, l__Acceleration__26.Z * v68 ^ 2 / 2);
            local v70 = l__Origin__24 + l__InitialVelocity__25 * v68 + v69;
            local v71 = u57.RayInfo.WorldRoot:Raycast(v67, (v70 - v67).Unit * (l__InitialVelocity__25 + l__Acceleration__26 * v68).Magnitude * p62, u57.RayInfo.Parameters);
            if v71 ~= nil then
                v70 = v71.Position;
            end;
            local l__Magnitude__28 = (v70 - v67).Magnitude;
            local l__StateInfo__29 = u57.StateInfo;
            l__StateInfo__29.TotalRuntime = l__StateInfo__29.TotalRuntime - p62;
            local v72 = math.floor(l__Magnitude__28 / u57.StateInfo.HighFidelitySegmentSize);
            local v73 = v72 == 0 and 1 or v72;
            local v74 = p62 / v73;
            for v75 = 1, v73 do
                if getmetatable(u57) == nil then
                    return;
                end;
                if u57.StateInfo.CancelHighResCast then
                    u57.StateInfo.CancelHighResCast = false;
                    break;
                end;
                local v76 = "[" .. v75 .. "] Subcast of time increment " .. v74;
                if u2.DebugLogging == true then
                    print(v76);
                end;
                u51(u57, v74, true);
            end;
            if getmetatable(u57) == nil then
                return;
            end;
            u57.StateInfo.IsActivelyResimulating = false;
            if tick() - v64 > 0.08 then
                warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.");
            end;
        else
            u51(u57, p62, false);
        end;
    end);
    return u57;
end;
function u1.SetStaticFastCastReference(p77) --[[ Line: 619 ]]
    -- upvalues: u2 (ref)
    u2 = p77;
end;
local function u86(p78, p79, p80, p81) --[[ Line: 625 ]]
    -- upvalues: u17 (copy), l__Table__3 (copy)
    local l__Trajectories__30 = p78.StateInfo.Trajectories;
    local v82 = l__Trajectories__30[#l__Trajectories__30];
    if v82.StartTime == p78.StateInfo.TotalRuntime then
        if p79 == nil then
            p79 = v82.InitialVelocity;
        end;
        if p80 == nil then
            p80 = v82.Acceleration;
        end;
        if p81 == nil then
            p81 = v82.Origin;
        end;
        v82.Origin = p81;
        v82.InitialVelocity = p79;
        v82.Acceleration = p80;
    else
        v82.EndTime = p78.StateInfo.TotalRuntime;
        assert(p78.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
        local v83 = u17(p78, #p78.StateInfo.Trajectories);
        local v84, v85 = unpack(v83);
        if p79 == nil then
            p79 = v85;
        end;
        if p80 == nil then
            p80 = v82.Acceleration;
        end;
        if p81 ~= nil then
            v84 = p81;
        end;
        l__Table__3.insert(p78.StateInfo.Trajectories, {
            EndTime = -1,
            StartTime = p78.StateInfo.TotalRuntime,
            Origin = v84,
            InitialVelocity = p79,
            Acceleration = p80
        });
        p78.StateInfo.CancelHighResCast = true;
    end;
end;
function u1.SetVelocity(p87, p88) --[[ Line: 671 ]]
    -- upvalues: u1 (copy), u86 (copy)
    local v89 = getmetatable(p87) == u1;
    assert(v89, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetVelocity", "ActiveCast.new(...)"));
    assert(p87.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    u86(p87, p88, nil, nil);
end;
function u1.SetAcceleration(p90, p91) --[[ Line: 677 ]]
    -- upvalues: u1 (copy), u86 (copy)
    local v92 = getmetatable(p90) == u1;
    assert(v92, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetAcceleration", "ActiveCast.new(...)"));
    assert(p90.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    u86(p90, nil, p91, nil);
end;
function u1.SetPosition(p93, p94) --[[ Line: 683 ]]
    -- upvalues: u1 (copy), u86 (copy)
    local v95 = getmetatable(p93) == u1;
    assert(v95, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetPosition", "ActiveCast.new(...)"));
    assert(p93.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    u86(p93, nil, nil, p94);
end;
function u1.GetVelocity(p96) --[[ Line: 689 ]]
    -- upvalues: u1 (copy)
    local v97 = getmetatable(p96) == u1;
    assert(v97, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetVelocity", "ActiveCast.new(...)"));
    assert(p96.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v98 = p96.StateInfo.Trajectories[#p96.StateInfo.Trajectories];
    return v98.InitialVelocity + v98.Acceleration * (p96.StateInfo.TotalRuntime - v98.StartTime);
end;
function u1.GetAcceleration(p99) --[[ Line: 696 ]]
    -- upvalues: u1 (copy)
    local v100 = getmetatable(p99) == u1;
    assert(v100, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetAcceleration", "ActiveCast.new(...)"));
    assert(p99.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    return p99.StateInfo.Trajectories[#p99.StateInfo.Trajectories].Acceleration;
end;
function u1.GetPosition(p101) --[[ Line: 703 ]]
    -- upvalues: u1 (copy)
    local v102 = getmetatable(p101) == u1;
    assert(v102, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPosition", "ActiveCast.new(...)"));
    assert(p101.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v103 = p101.StateInfo.Trajectories[#p101.StateInfo.Trajectories];
    local v104 = p101.StateInfo.TotalRuntime - v103.StartTime;
    local l__Origin__31 = v103.Origin;
    local l__InitialVelocity__32 = v103.InitialVelocity;
    local l__Acceleration__33 = v103.Acceleration;
    local v105 = Vector3.new(l__Acceleration__33.X * v104 ^ 2 / 2, l__Acceleration__33.Y * v104 ^ 2 / 2, l__Acceleration__33.Z * v104 ^ 2 / 2);
    return l__Origin__31 + l__InitialVelocity__32 * v104 + v105;
end;
function u1.AddVelocity(p106, p107) --[[ Line: 712 ]]
    -- upvalues: u1 (copy)
    local v108 = getmetatable(p106) == u1;
    assert(v108, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddVelocity", "ActiveCast.new(...)"));
    assert(p106.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p106:SetVelocity(p106:GetVelocity() + p107);
end;
function u1.AddAcceleration(p109, p110) --[[ Line: 718 ]]
    -- upvalues: u1 (copy)
    local v111 = getmetatable(p109) == u1;
    assert(v111, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddAcceleration", "ActiveCast.new(...)"));
    assert(p109.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p109:SetAcceleration(p109:GetAcceleration() + p110);
end;
function u1.AddPosition(p112, p113) --[[ Line: 724 ]]
    -- upvalues: u1 (copy)
    local v114 = getmetatable(p112) == u1;
    assert(v114, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddPosition", "ActiveCast.new(...)"));
    assert(p112.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p112:SetPosition(p112:GetPosition() + p113);
end;
function u1.Pause(p115) --[[ Line: 732 ]]
    -- upvalues: u1 (copy)
    local v116 = getmetatable(p115) == u1;
    assert(v116, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Pause", "ActiveCast.new(...)"));
    assert(p115.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p115.StateInfo.Paused = true;
end;
function u1.Resume(p117) --[[ Line: 738 ]]
    -- upvalues: u1 (copy)
    local v118 = getmetatable(p117) == u1;
    assert(v118, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Resume", "ActiveCast.new(...)"));
    assert(p117.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p117.StateInfo.Paused = false;
end;
function u1.Terminate(p119) --[[ Line: 744 ]]
    -- upvalues: u1 (copy)
    local v120 = getmetatable(p119) == u1;
    assert(v120, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Terminate", "ActiveCast.new(...)"));
    assert(p119.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local l__Trajectories__34 = p119.StateInfo.Trajectories;
    l__Trajectories__34[#l__Trajectories__34].EndTime = p119.StateInfo.TotalRuntime;
    p119.StateInfo.UpdateConnection:Disconnect();
    p119.Caster.CastTerminating:FireSync(p119);
    p119.StateInfo.UpdateConnection = nil;
    p119.Caster = nil;
    p119.StateInfo = nil;
    p119.RayInfo = nil;
    p119.UserData = nil;
    setmetatable(p119, nil);
end;
return u1;
