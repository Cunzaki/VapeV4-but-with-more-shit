-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Cone
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
        local v13 = p9 * CFrame.Angles(-1.5707963267948966, 0, 0);
        local v14 = v13.Position + v13.UpVector * (p11 * 0.5);
        local v15 = v13.Position + -v13.UpVector * (p11 * 0.5);
        local v16 = CFrame.lookAt(v14, v14 + v13.UpVector);
        local v17 = CFrame.lookAt(v15, v15 - v13.UpVector);
        local v18 = nil;
        local v19 = nil;
        for v20 = 0, 360, math.floor(360 / p12) do
            local v21 = math.rad(v20);
            local v22 = math.sin(v21) * p10;
            local v23 = math.rad(v20);
            local v24 = math.cos(v23) * p10;
            local v25 = v17.Position + (v13.LookVector * v24 + v13.RightVector * v22);
            if v18 then
                l__Ceive__1.Ray:Draw(v25, v16.Position);
                l__Ceive__1.Ray:Draw(v18, v25);
                v18 = v25;
            else
                l__Ceive__1.Ray:Draw(v25, v16.Position);
                v19 = v25;
                v18 = v19;
                local v26 = v19;
                v19 = v18;
                v26 = v18;
            end;
        end;
        l__Ceive__1.Ray:Draw(v18, v19);
    end;
end;
function u1.Create(p27, p28, p29, p30, p31) --[[ Line: 63 ]]
    local v32 = {
        Enabled = true,
        Destroy = false,
        Transform = p28,
        Radius = p29,
        Length = p30,
        Subdivisions = p31,
        AlwaysOnTop = p27.Propertys.AlwaysOnTop,
        Transparency = p27.Propertys.Transparency,
        Color3 = p27.Propertys.Color3
    };
    p27.Retain(p27, v32);
    return v32;
end;
function u1.Update(p33, p34) --[[ Line: 81 ]]
    local l__Ceive__2 = p33.Ceive;
    l__Ceive__2.PushProperty("AlwaysOnTop", p34.AlwaysOnTop);
    l__Ceive__2.PushProperty("Transparency", p34.Transparency);
    l__Ceive__2.PushProperty("Color3", p34.Color3);
    p33:Draw(p34.Transform, p34.Radius, p34.Length, p34.Subdivisions);
end;
return u1;
