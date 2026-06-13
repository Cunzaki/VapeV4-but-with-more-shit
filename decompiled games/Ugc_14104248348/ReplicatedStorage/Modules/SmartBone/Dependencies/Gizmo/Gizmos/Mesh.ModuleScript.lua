-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Mesh
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 8 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Ceive = p2;
    v7.Propertys = p3;
    v7.Request = p4;
    v7.Release = p5;
    v7.Retain = p6;
    return v7;
end;
function u1.Draw(p8, p9, p10, p11, p12) --[[ Line: 20 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        local v13 = (-1 / 0);
        local v14 = (-1 / 0);
        local v15 = (-1 / 0);
        local v16 = (1 / 0);
        local v17 = (1 / 0);
        local v18 = (1 / 0);
        for _, v19 in p11 do
            v13 = math.max(v13, v19.x);
            v14 = math.max(v14, v19.y);
            v15 = math.max(v15, v19.z);
            v16 = math.min(v16, v19.x);
            v17 = math.min(v17, v19.y);
            v18 = math.min(v18, v19.z);
        end;
        for v20, v21 in p11 do
            p11[v20] = p9 * CFrame.new(Vector3.new((v21.x - v16) / (v13 - v16) * 1 + -0.5, (v21.y - v17) / (v14 - v17) * 1 + -0.5, (v21.z - v18) / (v15 - v18) * 1 + -0.5) * p10);
        end;
        for _, v22 in p12 do
            if #v22 == 3 then
                local v23 = p11[v22[1].v];
                local v24 = p11[v22[2].v];
                local v25 = p11[v22[3].v];
                l__Ceive__1.Ray:Draw(v23.Position, v24.Position);
                l__Ceive__1.Ray:Draw(v24.Position, v25.Position);
                l__Ceive__1.Ray:Draw(v25.Position, v23.Position);
            else
                local v26 = p11[v22[1].v];
                local v27 = p11[v22[2].v];
                local v28 = p11[v22[3].v];
                local v29 = p11[v22[4].v];
                l__Ceive__1.Ray:Draw(v26.Position, v27.Position);
                l__Ceive__1.Ray:Draw(v26.Position, v29.Position);
                l__Ceive__1.Ray:Draw(v29.Position, v27.Position);
                l__Ceive__1.Ray:Draw(v28.Position, v29.Position);
                l__Ceive__1.Ray:Draw(v27.Position, v28.Position);
            end;
        end;
    end;
end;
function u1.Create(p30, p31, p32, p33, p34) --[[ Line: 79 ]]
    local v35 = {
        Enabled = true,
        Destroy = false,
        Transform = p31,
        Size = p32,
        Vertices = p33,
        Faces = p34,
        AlwaysOnTop = p30.Propertys.AlwaysOnTop,
        Transparency = p30.Propertys.Transparency,
        Color3 = p30.Propertys.Color3
    };
    p30.Retain(p30, v35);
    return v35;
end;
function u1.Update(p36, p37) --[[ Line: 97 ]]
    local l__Ceive__2 = p36.Ceive;
    l__Ceive__2.PushProperty("AlwaysOnTop", p37.AlwaysOnTop);
    l__Ceive__2.PushProperty("Transparency", p37.Transparency);
    l__Ceive__2.PushProperty("Color3", p37.Color3);
    p36:Draw(p37.Transform, p37.Size, p37.Vertices, p37.Faces);
end;
return u1;
