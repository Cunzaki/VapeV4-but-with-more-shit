-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Plane
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
function u1.Draw(p8, u9, p10, p11) --[[ Line: 16 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        local v12 = p11 * Vector3.new(1, 1, 0);
        local v13 = CFrame.lookAt(u9, u9 + p10);
        local l__UpVector__2 = v13.UpVector;
        local l__RightVector__3 = v13.RightVector;
        local l__LookVector__4 = v13.LookVector;
        local v14 = v12 * 0.5;
        (function(p15, p16, p17) --[[ Name: CalculateZFace, Line 35 ]]
            -- upvalues: u9 (copy), l__Ceive__1 (copy)
            local v18 = u9 + (p15 - p16 + p17);
            local v19 = u9 + (p15 + p16 + p17);
            local v20 = u9 + (-p15 - p16 + p17);
            local v21 = u9 + (-p15 + p16 + p17);
            l__Ceive__1.Ray:Draw(v18, v19);
            l__Ceive__1.Ray:Draw(v18, v20);
            l__Ceive__1.Ray:Draw(v19, v21);
            l__Ceive__1.Ray:Draw(v19, v20);
            l__Ceive__1.Ray:Draw(v20, v21);
        end)(l__UpVector__2 * v14.Y, l__RightVector__3 * v14.X, l__LookVector__4 * v14.Z);
    end;
end;
function u1.Create(p22, p23, p24, p25) --[[ Line: 53 ]]
    local v26 = {
        Enabled = true,
        Destroy = false,
        Position = p23,
        Normal = p24,
        Size = p25,
        AlwaysOnTop = p22.Propertys.AlwaysOnTop,
        Transparency = p22.Propertys.Transparency,
        Color3 = p22.Propertys.Color3
    };
    p22.Retain(p22, v26);
    return v26;
end;
function u1.Update(p27, p28) --[[ Line: 70 ]]
    local l__Ceive__5 = p27.Ceive;
    l__Ceive__5.PushProperty("AlwaysOnTop", p28.AlwaysOnTop);
    l__Ceive__5.PushProperty("Transparency", p28.Transparency);
    l__Ceive__5.PushProperty("Color3", p28.Color3);
    p27:Draw(p28.Position, p28.Normal, p28.Size);
end;
return u1;
