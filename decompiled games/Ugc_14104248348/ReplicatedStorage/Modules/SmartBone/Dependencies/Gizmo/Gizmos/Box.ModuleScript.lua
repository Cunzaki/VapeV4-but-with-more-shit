-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Box
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
function u1.Draw(p8, p9, p10, u11) --[[ Line: 16 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        local l__Position__2 = p9.Position;
        local l__UpVector__3 = p9.UpVector;
        local l__RightVector__4 = p9.RightVector;
        local l__LookVector__5 = p9.LookVector;
        local v12 = p10 * 0.5;
        local v13 = l__UpVector__3 * v12.Y;
        local v14 = l__RightVector__4 * v12.X;
        local v15 = l__LookVector__5 * v12.Z;
        local function v23(p16, p17, p18) --[[ Line: 32 ]]
            -- upvalues: l__Position__2 (copy), l__Ceive__1 (copy), u11 (copy)
            local v19 = l__Position__2 + (p16 - p17 + p18);
            local v20 = l__Position__2 + (p16 + p17 + p18);
            local v21 = l__Position__2 + (p16 - p17 - p18);
            local v22 = l__Position__2 + (p16 + p17 - p18);
            l__Ceive__1.Ray:Draw(v19, v20);
            l__Ceive__1.Ray:Draw(v19, v21);
            l__Ceive__1.Ray:Draw(v20, v22);
            if u11 ~= false then
                l__Ceive__1.Ray:Draw(v20, v21);
            end;
            l__Ceive__1.Ray:Draw(v21, v22);
        end;
        local function v31(p24, p25, p26) --[[ Line: 49 ]]
            -- upvalues: l__Position__2 (copy), l__Ceive__1 (copy), u11 (copy)
            local v27 = l__Position__2 + (p24 - p25 + p26);
            local v28 = l__Position__2 + (p24 + p25 + p26);
            local v29 = l__Position__2 + (-p24 - p25 + p26);
            local v30 = l__Position__2 + (-p24 + p25 + p26);
            l__Ceive__1.Ray:Draw(v27, v28);
            l__Ceive__1.Ray:Draw(v27, v29);
            l__Ceive__1.Ray:Draw(v28, v30);
            if u11 ~= false then
                l__Ceive__1.Ray:Draw(v28, v29);
            end;
            l__Ceive__1.Ray:Draw(v29, v30);
        end;
        local function v39(p32, p33, p34) --[[ Line: 66 ]]
            -- upvalues: l__Position__2 (copy), l__Ceive__1 (copy), u11 (copy)
            local v35 = l__Position__2 + (p32 - p33 - p34);
            local v36 = l__Position__2 + (p32 - p33 + p34);
            local v37 = l__Position__2 + (-p32 - p33 - p34);
            local v38 = l__Position__2 + (-p32 - p33 + p34);
            l__Ceive__1.Ray:Draw(v35, v36);
            l__Ceive__1.Ray:Draw(v35, v37);
            l__Ceive__1.Ray:Draw(v36, v38);
            if u11 ~= false then
                l__Ceive__1.Ray:Draw(v36, v37);
            end;
            l__Ceive__1.Ray:Draw(v37, v38);
        end;
        v39(v13, v14, v15);
        v39(v13, -v14, v15);
        v23(v13, v14, v15);
        v23(-v13, v14, v15);
        v31(v13, v14, v15);
        v31(v13, v14, -v15);
    end;
end;
function u1.Create(p40, p41, p42, p43) --[[ Line: 93 ]]
    local v44 = {
        Enabled = true,
        Destroy = false,
        Transform = p41,
        Size = p42,
        DrawTriangles = p43,
        AlwaysOnTop = p40.Propertys.AlwaysOnTop,
        Transparency = p40.Propertys.Transparency,
        Color3 = p40.Propertys.Color3
    };
    p40.Retain(p40, v44);
    return v44;
end;
function u1.Update(p45, p46) --[[ Line: 110 ]]
    local l__Ceive__6 = p45.Ceive;
    l__Ceive__6.PushProperty("AlwaysOnTop", p46.AlwaysOnTop);
    l__Ceive__6.PushProperty("Transparency", p46.Transparency);
    l__Ceive__6.PushProperty("Color3", p46.Color3);
    p45:Draw(p46.Transform, p46.Size, p46.DrawTriangles);
end;
return u1;
