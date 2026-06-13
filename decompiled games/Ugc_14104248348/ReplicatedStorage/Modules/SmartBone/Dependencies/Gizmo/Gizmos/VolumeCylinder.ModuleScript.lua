-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.VolumeCylinder
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Terrain__1 = workspace.Terrain;
local u1 = {};
u1.__index = u1;
function u1.Init(p2, p3, p4, p5, p6, p7) --[[ Line: 6 ]]
    -- upvalues: u1 (copy)
    local v8 = setmetatable({}, u1);
    v8.Ceive = p2;
    v8.Propertys = p3;
    v8.Request = p4;
    v8.Release = p5;
    v8.Retain = p6;
    v8.Register = p7;
    return v8;
end;
function u1.Draw(p9, p10, p11, p12, p13, p14) --[[ Line: 19 ]]
    -- upvalues: l__Terrain__1 (copy)
    local l__Ceive__2 = p9.Ceive;
    if l__Ceive__2.Enabled then
        local v15 = p9.Request("CylinderHandleAdornment");
        v15.Color3 = p9.Propertys.Color3;
        v15.Transparency = p9.Propertys.Transparency;
        v15.CFrame = p10;
        v15.Height = p12;
        v15.Radius = p11;
        v15.InnerRadius = p13 or 0;
        v15.Angle = p14 or 360;
        v15.AlwaysOnTop = p9.Propertys.AlwaysOnTop;
        v15.ZIndex = 1;
        v15.Adornee = l__Terrain__1;
        v15.Parent = l__Terrain__1;
        l__Ceive__2.ActiveInstances = l__Ceive__2.ActiveInstances + 1;
        p9.Register(v15);
        p9.Ceive.ScheduleCleaning();
    end;
end;
function u1.Create(p16, p17, p18, p19, p20, p21) --[[ Line: 46 ]]
    local v22 = {
        Enabled = true,
        Destroy = false,
        Transform = p17,
        Radius = p18,
        Length = p19,
        InnerRadius = p20 or 0,
        Angle = p21 or 360,
        AlwaysOnTop = p16.Propertys.AlwaysOnTop,
        Transparency = p16.Propertys.Transparency,
        Color3 = p16.Propertys.Color3
    };
    p16.Retain(p16, v22);
    return v22;
end;
function u1.Update(p23, p24) --[[ Line: 65 ]]
    local l__Ceive__3 = p23.Ceive;
    l__Ceive__3.PushProperty("AlwaysOnTop", p24.AlwaysOnTop);
    l__Ceive__3.PushProperty("Transparency", p24.Transparency);
    l__Ceive__3.PushProperty("Color3", p24.Color3);
    p23:Draw(p24.Transform, p24.Radius, p24.Length, p24.InnerRadius, p24.Angle);
end;
return u1;
