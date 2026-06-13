-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.FishController.FishBehavior
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__CollectionService__1 = game:GetService("CollectionService");
local u7 = (function() --[[ Name: DrawDirections, Line 27 ]]
    local v2 = {};
    for v3 = 1, 8 do
        local v4 = 10.166407384630519 * v3;
        local v5 = math.cos(v4);
        local v6 = math.sin(v4);
        v2[v3] = Vector3.new(v5, v6, 0);
    end;
    return v2;
end)();
local function u13(p8) --[[ Line: 39 ]]
    for v9 = #p8, 2, -1 do
        local v10 = math.random(v9);
        local v11 = p8[v10];
        local v12 = p8[v9];
        p8[v9] = v11;
        p8[v10] = v12;
    end;
end;
local u54 = {
    __index = {
        _SteerTowards = function(p14, p15, p16) --[[ Name: _SteerTowards, Line 48 ]]
            local v17 = p16.Unit * p14.MAX_SPEED - p15._Velocity;
            if v17.Magnitude > p14.MAX_STEER_FORCE then
                local l__MAX_STEER_FORCE__2 = p14.MAX_STEER_FORCE;
                local l__Magnitude__3 = v17.Magnitude;
                if l__MAX_STEER_FORCE__2 < l__Magnitude__3 then
                    return v17.Unit * l__MAX_STEER_FORCE__2;
                end;
                if l__Magnitude__3 < 0 then
                    return v17.Unit * 0;
                end;
            end;
            return v17;
        end,
        AddBoid = function(p18, p19) --[[ Name: AddBoid, Line 56 ]]
            p18._Boids[p19._Instance] = p19;
        end,
        RemoveBoid = function(p20, p21) --[[ Name: RemoveBoid, Line 60 ]]
            p20._Boids[p21._Instance] = nil;
        end,
        GetBoids = function(p22) --[[ Name: GetBoids, Line 64 ]]
            local v23 = p22._Boids or {};
            local v24 = 0;
            for _, v25 in p22._Boids do
                v24 = v24 + 1;
                v23[v24] = v25;
            end;
            return v23;
        end,
        Update = function(p26, p27) --[[ Name: Update, Line 74 ]]
            -- upvalues: u13 (copy), u7 (copy), l__CollectionService__1 (copy)
            local l__TargetPosition__4 = p26.TargetPosition;
            u13(u7);
            for v28, v29 in p26._Boids do
                local v30 = 0;
                local v31 = Vector3.new(0, 0, 0);
                local v32 = Vector3.new(0, 0, 0);
                local v33 = Vector3.new(0, 0, 0);
                local v34 = workspace:Raycast(v29._Position, v29._Instance.PrimaryPart.CFrame.LookVector * p26.RAY_LENGTH, v29._Params);
                if v34 and (v34.Instance and not l__CollectionService__1:HasTag(v34.Instance.Parent, "LocalFish")) then
                    local v35 = nil;
                    for v36 = 1, #u7 do
                        local v37 = v29._Instance.PrimaryPart.CFrame:VectorToWorldSpace(u7[v36]);
                        if not workspace:Raycast(v29._Position, v37 * p26.RAY_LENGTH, v29._Params) then
                            v35 = v37;
                            break;
                        end;
                    end;
                    if v35 then
                        local v38 = p26:_SteerTowards(v29, v35) * p26.AVOIDANCE_WEIGHT;
                        local l__X__5 = v38.X;
                        local v39 = l__X__5 ~= l__X__5;
                        if not v39 then
                            local l__Y__6 = v38.Y;
                            v39 = l__Y__6 ~= l__Y__6;
                            if not v39 then
                                local l__Z__7 = v38.Z;
                                v39 = l__Z__7 ~= l__Z__7;
                            end;
                        end;
                        if not v39 then
                            v29._Acceleration = v29._Acceleration + v38;
                        end;
                    end;
                end;
                for v40, v41 in p26._Boids do
                    if v28 ~= v40 then
                        local v42 = v41._Position - v29._Position;
                        local l__Magnitude__8 = v42.Magnitude;
                        if p26.NEIGHBOR_DIST >= l__Magnitude__8 then
                            if l__Magnitude__8 <= p26.CROWDING_DIST then
                                v33 = v33 - v42 / l__Magnitude__8;
                            end;
                            v31 = v31 + v41._Position;
                            v32 = v32 + v41._Velocity;
                            v30 = v30 + 1;
                        end;
                    end;
                end;
                if v30 > 0 then
                    local v43 = v31 / v30;
                    local v44 = v32 / v30;
                    local v45 = v43 - v29._Position;
                    local v46 = p26:_SteerTowards(v29, v44) * p26.ALIGN_WEIGHT;
                    local v47 = p26:_SteerTowards(v29, v45) * p26.COHESION_WEIGHT;
                    local v48 = p26:_SteerTowards(v29, v33) * p26.SEPARATE_WEIGHT;
                    local l__X__9 = v46.X;
                    local v49 = l__X__9 ~= l__X__9;
                    if not v49 then
                        local l__Y__10 = v46.Y;
                        v49 = l__Y__10 ~= l__Y__10;
                        if not v49 then
                            local l__Z__11 = v46.Z;
                            v49 = l__Z__11 ~= l__Z__11;
                        end;
                    end;
                    if not v49 then
                        v29._Acceleration = v29._Acceleration + v46;
                    end;
                    local l__X__12 = v47.X;
                    local v50 = l__X__12 ~= l__X__12;
                    if not v50 then
                        local l__Y__13 = v47.Y;
                        v50 = l__Y__13 ~= l__Y__13;
                        if not v50 then
                            local l__Z__14 = v47.Z;
                            v50 = l__Z__14 ~= l__Z__14;
                        end;
                    end;
                    if not v50 then
                        v29._Acceleration = v29._Acceleration + v47;
                    end;
                    local l__X__15 = v48.X;
                    local v51 = l__X__15 ~= l__X__15;
                    if not v51 then
                        local l__Y__16 = v48.Y;
                        v51 = l__Y__16 ~= l__Y__16;
                        if not v51 then
                            local l__Z__17 = v48.Z;
                            v51 = l__Z__17 ~= l__Z__17;
                        end;
                    end;
                    if not v51 and v33.Magnitude > 0.01 then
                        v29._Acceleration = v29._Acceleration + v48;
                    end;
                end;
                if l__TargetPosition__4 then
                    local v52 = p26:_SteerTowards(v29, (l__TargetPosition__4 - v29._Position).Unit) / (v30 + 1) * p26.TARGET_WEIGHT;
                    local l__X__18 = v52.X;
                    local v53 = l__X__18 ~= l__X__18;
                    if not v53 then
                        local l__Y__19 = v52.Y;
                        v53 = l__Y__19 ~= l__Y__19;
                        if not v53 then
                            local l__Z__20 = v52.Z;
                            v53 = l__Z__20 ~= l__Z__20;
                        end;
                    end;
                    if not v53 then
                        v29._Acceleration = v29._Acceleration + v52;
                    end;
                end;
                v29._Velocity = v29._Velocity + v29._Acceleration * p27;
                local l___Velocity__21 = v29._Velocity;
                local l__MIN_SPEED__22 = p26.MIN_SPEED;
                local l__MAX_SPEED__23 = p26.MAX_SPEED;
                local l__Magnitude__24 = l___Velocity__21.Magnitude;
                if l__MAX_SPEED__23 < l__Magnitude__24 then
                    l___Velocity__21 = l___Velocity__21.Unit * l__MAX_SPEED__23;
                elseif l__Magnitude__24 < l__MIN_SPEED__22 then
                    l___Velocity__21 = l___Velocity__21.Unit * l__MIN_SPEED__22;
                end;
                v29._Velocity = l___Velocity__21;
                v29._Position = v29._Position + v29._Velocity * p27;
                task.synchronize();
                v29._Instance.PrimaryPart.CFrame = CFrame.lookAt(v29._Position, v29._Position + v29._Velocity);
            end;
        end
    }
};
function v1.new(p55) --[[ Line: 154 ]]
    -- upvalues: u54 (copy)
    assert(p55, "Fish is nil");
    assert(p55.Data, "Fish.Data is nil");
    return setmetatable({
        _Boids = {},
        Component = p55,
        TargetPosition = p55.Node.Position,
        ALIGN_WEIGHT = p55.Data.AlignWeight,
        COHESION_WEIGHT = p55.Data.CohesionWeight,
        TARGET_WEIGHT = p55.Data.TargetWeight,
        SEPARATE_WEIGHT = p55.Data.SeparateWeight,
        AVOIDANCE_WEIGHT = p55.Data.AvoidanceWeight,
        MAX_SPEED = p55.Data.MaxSpeed,
        MIN_SPEED = p55.Data.MinSpeed,
        RAY_LENGTH = p55.Data.RayLength,
        NEIGHBOR_DIST = p55.Data.NeighborDist,
        CROWDING_DIST = p55.Data.CrowdingDist,
        MAX_STEER_FORCE = p55.Data.MaxSteerForce
    }, u54);
end;
function v1.CreateBoid(p56) --[[ Line: 178 ]]
    -- upvalues: l__CollectionService__1 (copy)
    local v57 = {
        _Instance = p56,
        _Position = p56.PrimaryPart.Position
    };
    local v58 = math.random(-1, 1);
    local v59 = math.random(-1, 1);
    v57._Velocity = Vector3.new(v58, v59, math.random(-1, 1));
    v57._Acceleration = Vector3.new();
    v57._Params = RaycastParams.new();
    local v60 = l__CollectionService__1:GetTagged("Kelp");
    local v61 = l__CollectionService__1:GetTagged("LocalFish");
    local v62 = l__CollectionService__1:GetTagged("Node");
    v57._Params.FilterType = Enum.RaycastFilterType.Exclude;
    v57._Params.FilterDescendantsInstances = {
        v57._Instance,
        unpack(v60),
        unpack(v61),
        unpack(v62)
    };
    return v57;
end;
return v1;
