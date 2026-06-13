-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Circle
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Ceive = p2;
    v7.Propertys = p3;
    v7.Request = p4;
    v7.Release = p5;
    v7.Retain = p6;
    return v7;
end;
function u1.Draw(p8, p9, p10, p11, p12, p13) --[[ Line: 16 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        local v14 = nil;
        local v15 = 0;
        local v16 = nil;
        for v17 = 0, p12, math.floor(p12 / p11) do
            local v18 = math.rad(v17);
            local v19 = math.sin(v18) * p10;
            local v20 = math.rad(v17);
            local v21 = math.cos(v20) * p10;
            local v22 = p9.Position + (p9.UpVector * v21 + p9.RightVector * v19);
            if v14 == nil then
                v16 = v22;
                v15 = v17;
                v14 = v16;
                local v23 = v16;
                v16 = v14;
                v23 = v14;
            else
                l__Ceive__1.Ray:Draw(v14, v22);
                v15 = v17;
                v14 = v22;
            end;
        end;
        if v15 ~= p12 then
            local v24 = math.rad(p12);
            local v25 = math.sin(v24) * p10;
            local v26 = math.rad(p12);
            local v27 = math.cos(v26) * p10;
            l__Ceive__1.Ray:Draw(v14, p9.Position + (p9.UpVector * v27 + p9.RightVector * v25));
        end;
        if p13 ~= false then
            l__Ceive__1.Ray:Draw(v14, v16);
        end;
        return v14;
    end;
end;
function u1.Create(p28, p29, p30, p31, p32, p33) --[[ Line: 64 ]]
    local v34 = {
        Enabled = true,
        Destroy = false,
        Transform = p29,
        Radius = p30,
        Subdivisions = p31,
        Angle = p32,
        ConnectToStart = p33,
        AlwaysOnTop = p28.Propertys.AlwaysOnTop,
        Transparency = p28.Propertys.Transparency,
        Color3 = p28.Propertys.Color3
    };
    p28.Retain(p28, v34);
    return v34;
end;
function u1.Update(p35, p36) --[[ Line: 83 ]]
    local l__Ceive__2 = p35.Ceive;
    l__Ceive__2.PushProperty("AlwaysOnTop", p36.AlwaysOnTop);
    l__Ceive__2.PushProperty("Transparency", p36.Transparency);
    l__Ceive__2.PushProperty("Color3", p36.Color3);
    p35:Draw(p36.Transform, p36.Radius, p36.Subdivisions, p36.Angle, p36.ConnectToStart);
end;
return u1;
