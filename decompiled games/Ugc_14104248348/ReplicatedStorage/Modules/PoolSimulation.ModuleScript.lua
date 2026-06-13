-- Decompiled from: ReplicatedStorage.Modules.PoolSimulation
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Debris__1 = game:GetService("Debris");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Signal__3 = require(l__ReplicatedStorage__2.Modules.Signal);
local u1 = {};
u1.__index = u1;
local u2 = {
    { 1 },
    { 9, 6 },
    { 2, 8, 14 },
    {
        10,
        7,
        15,
        5
    },
    {
        3,
        11,
        12,
        4,
        13
    }
};
function u1.new(p3) --[[ Line: 25 ]]
    -- upvalues: l__Signal__3 (copy), u1 (copy), u2 (copy)
    assert(p3.Container, "You must provide a simulation Container!");
    assert(p3.Models, "You must provide a path of the ball models");
    assert(p3.Parent, "You must provide a parent for the billard balls");
    local v4 = {
        PocketRadius = nil,
        AccumulatedTime = 0,
        Simulation = true,
        CueBall = nil,
        Restitution = p3.Restitution or 1,
        Container = p3.Container,
        Friction = p3.Friction or 0.995,
        Radius = p3.Radius or 0.1,
        Models = p3.Models,
        Pockets = {},
        Framerate = p3.Framerate or 60,
        RelativePosition = p3.Container.Position - Vector3.new(p3.Container.Size.X / 2, 0, p3.Container.Size.Z / 2),
        Balls = {},
        Parent = p3.Parent,
        OnCueBallHit = l__Signal__3.new(),
        OnBallPocket = l__Signal__3.new(),
        OnBallCollision = l__Signal__3.new(),
        __InstanceToData = {}
    };
    local v5 = setmetatable(v4, u1);
    if p3.ConstructBalls then
        local v6 = v5.Container.Size.X / 2;
        local v7 = v5.Container.Size.Z * 0.8;
        v5.CueBall = v5:CreateBall(0, Vector2.new(v5.Container.Size.X / 2, v5.Container.Size.Z * 0.2));
        v5.__InstanceToData[v5.CueBall.Instance] = v5.CueBall;
        for v8 = 1, #u2 do
            for v9 = 1, #u2[v8] do
                local v10 = Vector2.new(v6 + (v9 - v8 / 2) * v5.Radius * 2, v7 + (v8 - 1) * v5.Radius * 2 * 0.8660254037844387);
                local v11 = v5:CreateBall(u2[v8][v9], v10);
                v5.__InstanceToData[v11.Instance] = v11;
            end;
        end;
    end;
    if p3.Pockets then
        for _, v12 in p3.Pockets do
            if not v5.PocketRadius then
                v5.PocketRadius = v12.Size.Y / 2;
            end;
            local v13 = v12.Position - v5.RelativePosition;
            print(Vector2.new(v13.X, v13.Z));
            v5.Pockets[v12] = Vector2.new(v13.X, v13.Z);
        end;
    end;
    return v5;
end;
function u1.CreateBall(p14, p15, p16) --[[ Line: 95 ]]
    local v17 = p14.Models:FindFirstChild(p15):Clone();
    v17.Anchored = true;
    v17.Size = Vector3.new(p14.Radius * 2, p14.Radius * 2, p14.Radius * 2);
    v17.Position = p14.RelativePosition + (p16 and (Vector3.new(p16.X, p14.Radius, p16.Y) or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0));
    v17.Parent = p14.Parent;
    local v18 = {
        Simulate = true,
        Pocketed = false,
        Bounced = false,
        Stationary = true,
        Instance = v17,
        Position = p16 or Vector2.zero,
        Velocity = Vector2.zero
    };
    if p15 == "0" then
        p14.CueBall = v18;
    end;
    table.insert(p14.Balls, v18);
    return v18;
end;
function u1.DeleteBall(p19, p20, p21) --[[ Line: 124 ]]
    -- upvalues: l__Debris__1 (copy)
    local v22 = nil;
    for v23, v24 in p19.Balls do
        if v24.Instance == p20 then
            v22 = v23;
        end;
    end;
    if v22 then
        l__Debris__1:AddItem(p19.Balls[v22].Instance, p21 or 0);
        p19.__InstanceToData[p20] = nil;
        table.remove(p19.Balls, v22);
    end;
end;
function u1.GetBallObject(p25, p26) --[[ Line: 142 ]]
    return p25.__InstanceToData[p26];
end;
function u1.Simulate(p27, p28, p29) --[[ Line: 146 ]]
    if p28.Simulate then
        local l__Velocity__4 = p28.Velocity;
        p28.Position = p28.Position + Vector2.new(l__Velocity__4.X * p29, l__Velocity__4.Y * p29);
        p28.Instance.Position = p27.RelativePosition + Vector3.new(p28.Position.X, p27.Radius, p28.Position.Y);
        if l__Velocity__4.Magnitude > 0 then
            local v30 = l__Velocity__4.Magnitude * p29 / p27.Radius;
            local v31 = Vector3.new(-l__Velocity__4.Y, 0, l__Velocity__4.X);
            local v32 = v31.Magnitude <= 0 and Vector3.new(0, 0, 0) or v31.Unit;
            local l__Instance__5 = p28.Instance;
            l__Instance__5.CFrame = l__Instance__5.CFrame * CFrame.fromAxisAngle(v32, v30);
        end;
        if l__Velocity__4.Magnitude < 0.2 then
            l__Velocity__4 = Vector2.zero;
            p28.Stationary = true;
        else
            p28.Stationary = false;
        end;
        p28.Velocity = l__Velocity__4 * p27.Friction;
    end;
end;
function u1.HandleBallCollision(p33, p34, p35) --[[ Line: 178 ]]
    local v36 = p34.Position - p35.Position;
    local v37 = p34.Velocity - p35.Velocity;
    local l__Magnitude__6 = v36.Magnitude;
    if l__Magnitude__6 == 0 or p33.Radius * 2 < l__Magnitude__6 then
    else
        if p34.Instance.Name == "0" or p35.Instance.Name == "0" then
            p33.OnCueBallHit:Fire(p34, p35);
        end;
        local v38 = v36 / l__Magnitude__6;
        if v37:Dot(v38) >= 0 then
        else
            local v39 = (p33.Radius * 2 - l__Magnitude__6) / 2;
            p34.Position = p34.Position + Vector2.new(v38.X * v39, v38.Y * v39);
            p35.Position = p35.Position - Vector2.new(v38.X * v39, v38.Y * v39);
            local v40 = p34.Velocity:Dot(v38);
            local v41 = p35.Velocity:Dot(v38);
            local v42 = (v40 + v41 - (v40 - v41) * p33.Restitution) / 2;
            local v43 = (v40 + v41 - (v41 - v40) * p33.Restitution) / 2;
            p34.Velocity = p34.Velocity + v38 * (v42 - v40);
            p35.Velocity = p35.Velocity + v38 * (v43 - v41);
            p33.OnBallCollision:Fire("Ball", p34, p35);
        end;
    end;
end;
function u1.HandleWallCollision(p44, p45) --[[ Line: 210 ]]
    local l__Velocity__7 = p45.Velocity;
    local l__Position__8 = p45.Position;
    local v46 = {
        X = {
            Min = p44.Radius,
            Max = p44.Container.Size.X - p44.Radius
        },
        Y = {
            Min = p44.Radius,
            Max = p44.Container.Size.Z - p44.Radius
        }
    };
    for v47, v48 in p44.Pockets do
        if (v48 - l__Position__8).Magnitude < p44.PocketRadius and not p45.Pocketed then
            p44.OnBallPocket:Fire(v47, p45);
            p45.Pocketed = true;
        end;
    end;
    for v49, v50 in v46 do
        local v51 = l__Position__8[v49];
        local _ = l__Velocity__7[v49];
        if v51 < v50.Min then
            l__Position__8 = l__Position__8 + Vector2.new(v49 == "X" and (v50.Min - v51 or 0) or 0, v49 == "Y" and (v50.Min - v51 or 0) or 0);
            l__Velocity__7 = l__Velocity__7 * Vector2.new(v49 == "X" and -1 or 1, v49 == "Y" and -1 or 1) * p44.Restitution;
            p44.OnBallCollision:Fire("Wall", p45);
            p45.Bounced = true;
        elseif v50.Max < v51 then
            l__Position__8 = l__Position__8 + Vector2.new(v49 == "X" and (v50.Max - v51 or 0) or 0, v49 == "Y" and (v50.Max - v51 or 0) or 0);
            l__Velocity__7 = l__Velocity__7 * Vector2.new(v49 == "X" and -1 or 1, v49 == "Y" and -1 or 1) * p44.Restitution;
            p44.OnBallCollision:Fire("Wall", p45);
            p45.Bounced = true;
        end;
    end;
    p45.Position = l__Position__8;
    p45.Velocity = l__Velocity__7;
end;
function u1.Destroy(p52) --[[ Line: 259 ]]
    for v53 = #p52.Balls, 1, -1 do
        p52:DeleteBall(p52.Balls[v53].Instance);
    end;
    p52.OnBallPocket:Destroy();
    p52.OnBallCollision:Destroy();
    p52.OnCueBallHit:Destroy();
    p52.__InstanceToData = nil;
    setmetatable(p52, nil);
end;
function u1.Update(p54, p55) --[[ Line: 271 ]]
    local v56 = 1 / p54.Framerate;
    p54.AccumulatedTime = p54.AccumulatedTime + p55;
    while v56 <= p54.AccumulatedTime do
        for v57 = 1, #p54.Balls do
            local v58 = p54.Balls[v57];
            p54:Simulate(v58, 0.016666666666666666);
            if p54.Simulation then
                for v59 = v57 + 1, #p54.Balls do
                    p54:HandleBallCollision(v58, p54.Balls[v59]);
                end;
                p54:HandleWallCollision(v58);
            end;
        end;
        p54.AccumulatedTime = p54.AccumulatedTime - v56;
    end;
end;
return u1;
