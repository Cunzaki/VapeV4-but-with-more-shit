-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Line
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
function u1.Draw(p8, p9, p10) --[[ Line: 16 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        l__Ceive__1.Ray:Draw(p9.Position + p9.LookVector * (-p10 * 0.5), p9.Position + p9.LookVector * (p10 * 0.5));
    end;
end;
function u1.Create(p11, p12, p13) --[[ Line: 29 ]]
    local v14 = {
        Enabled = true,
        Destroy = false,
        Transform = p12,
        Length = p13,
        AlwaysOnTop = p11.Propertys.AlwaysOnTop,
        Transparency = p11.Propertys.Transparency,
        Color3 = p11.Propertys.Color3
    };
    p11.Retain(p11, v14);
    return v14;
end;
function u1.Update(p15, p16) --[[ Line: 45 ]]
    local l__Ceive__2 = p15.Ceive;
    l__Ceive__2.PushProperty("AlwaysOnTop", p16.AlwaysOnTop);
    l__Ceive__2.PushProperty("Transparency", p16.Transparency);
    l__Ceive__2.PushProperty("Color3", p16.Color3);
    p15:Draw(p16.Transform, p16.Length);
end;
return u1;
