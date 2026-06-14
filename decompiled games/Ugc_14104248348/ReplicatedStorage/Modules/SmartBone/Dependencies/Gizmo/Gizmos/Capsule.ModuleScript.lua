-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Capsule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 6 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Ceive = p2;
    v7.Propertys = p3;
    v7.Request = p4;
    v7.Release = p5;
    v7.Retain = p6;
    return v7;
end;
function u1.Draw(p8, p9, p10, p11, p12) --[[ Line: 18 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        local v13 = p9.Position + p9.UpVector * (p11 * 0.5);
        local v14 = p9.Position - p9.UpVector * (p11 * 0.5);
        local v15 = CFrame.lookAt(v13, v13 + p9.UpVector);
        local v16 = CFrame.lookAt(v14, v14 - p9.UpVector);
        local v17 = nil;
        local v18 = nil;
        local v19 = nil;
        local v20 = nil;
        for v21 = 0, 360, math.floor(360 / p12) do
            local v22 = math.rad(v21);
            local v23 = math.sin(v22) * p10;
            local v24 = math.rad(v21);
            local v25 = math.cos(v24) * p10;
            local v26 = p9.LookVector * v25 + p9.RightVector * v23;
            local v27 = v15.Position + v26;
            local v28 = v16.Position + v26;
            l__Ceive__1.Ray:Draw(v27, v28);
            l__Ceive__1.Circle:Draw(CFrame.new(v15.Position) * p9.Rotation * CFrame.Angles(0, math.rad(v21), 0), p10, p12 * 0.5, 90, false);
            l__Ceive__1.Circle:Draw(CFrame.new(v16.Position) * p9.Rotation * CFrame.Angles(3.141592653589793, math.rad(v21), 0), p10, p12 * 0.5, 90, false);
            if v17 then
                l__Ceive__1.Ray:Draw(v17, v27);
                l__Ceive__1.Ray:Draw(v18, v28);
                v18 = v28;
                v17 = v27;
            else
                v20 = v28;
                v19 = v27;
                v18 = v20;
                v17 = v19;
                local v29 = v20;
                v20 = v18;
                v29 = v19;
                v19 = v17;
                v29 = v18;
                v18 = v20;
                v29 = v17;
            end;
        end;
        l__Ceive__1.Ray:Draw(v17, v19);
        l__Ceive__1.Ray:Draw(v18, v20);
    end;
end;
function u1.Create(p30, p31, p32, p33, p34) --[[ Line: 88 ]]
    local v35 = {
        Enabled = true,
        Destroy = false,
        Transform = p31,
        Radius = p32,
        Length = p33,
        Subdivisions = p34,
        AlwaysOnTop = p30.Propertys.AlwaysOnTop,
        Transparency = p30.Propertys.Transparency,
        Color3 = p30.Propertys.Color3
    };
    p30.Retain(p30, v35);
    return v35;
end;
function u1.Update(p36, p37) --[[ Line: 106 ]]
    local l__Ceive__2 = p36.Ceive;
    l__Ceive__2.PushProperty("AlwaysOnTop", p37.AlwaysOnTop);
    l__Ceive__2.PushProperty("Transparency", p37.Transparency);
    l__Ceive__2.PushProperty("Color3", p37.Color3);
    p36:Draw(p37.Transform, p37.Radius, p37.Length, p37.Subdivisions);
end;
return u1;
