-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.VolumeSphere
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
function u1.Draw(p9, p10, p11) --[[ Line: 19 ]]
    -- upvalues: l__Terrain__1 (copy)
    local l__Ceive__2 = p9.Ceive;
    if l__Ceive__2.Enabled then
        local v12 = p9.Request("SphereHandleAdornment");
        v12.Color3 = p9.Propertys.Color3;
        v12.Transparency = p9.Propertys.Transparency;
        v12.CFrame = p10;
        v12.Radius = p11;
        v12.AlwaysOnTop = p9.Propertys.AlwaysOnTop;
        v12.ZIndex = 1;
        v12.Adornee = l__Terrain__1;
        v12.Parent = l__Terrain__1;
        l__Ceive__2.ActiveInstances = l__Ceive__2.ActiveInstances + 1;
        p9.Register(v12);
        p9.Ceive.ScheduleCleaning();
    end;
end;
function u1.Create(p13, p14, p15) --[[ Line: 43 ]]
    local v16 = {
        Enabled = true,
        Destroy = false,
        Transform = p14,
        Radius = p15,
        AlwaysOnTop = p13.Propertys.AlwaysOnTop,
        Transparency = p13.Propertys.Transparency,
        Color3 = p13.Propertys.Color3
    };
    p13.Retain(p13, v16);
    return v16;
end;
function u1.Update(p17, p18) --[[ Line: 59 ]]
    local l__Ceive__3 = p17.Ceive;
    l__Ceive__3.PushProperty("AlwaysOnTop", p18.AlwaysOnTop);
    l__Ceive__3.PushProperty("Transparency", p18.Transparency);
    l__Ceive__3.PushProperty("Color3", p18.Color3);
    p17:Draw(p18.Transform, p18.Radius);
end;
return u1;
