-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.VolumeCone
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
function u1.Draw(p9, p10, p11, p12) --[[ Line: 19 ]]
    -- upvalues: l__Terrain__1 (copy)
    local l__Ceive__2 = p9.Ceive;
    if l__Ceive__2.Enabled then
        local v13 = p9.Request("ConeHandleAdornment");
        v13.Color3 = p9.Propertys.Color3;
        v13.Transparency = p9.Propertys.Transparency;
        v13.CFrame = p10;
        v13.AlwaysOnTop = p9.Propertys.AlwaysOnTop;
        v13.ZIndex = 1;
        v13.Height = p12;
        v13.Radius = p11;
        v13.Adornee = l__Terrain__1;
        v13.Parent = l__Terrain__1;
        l__Ceive__2.ActiveInstances = l__Ceive__2.ActiveInstances + 1;
        p9.Register(v13);
        p9.Ceive.ScheduleCleaning();
    end;
end;
function u1.Create(p14, p15, p16, p17) --[[ Line: 44 ]]
    local v18 = {
        Enabled = true,
        Destroy = false,
        Transform = p15,
        Radius = p16,
        Length = p17,
        AlwaysOnTop = p14.Propertys.AlwaysOnTop,
        Transparency = p14.Propertys.Transparency,
        Color3 = p14.Propertys.Color3
    };
    p14.Retain(p14, v18);
    return v18;
end;
function u1.Update(p19, p20) --[[ Line: 61 ]]
    local l__Ceive__3 = p19.Ceive;
    l__Ceive__3.PushProperty("AlwaysOnTop", p20.AlwaysOnTop);
    l__Ceive__3.PushProperty("Transparency", p20.Transparency);
    l__Ceive__3.PushProperty("Color3", p20.Color3);
    p19:Draw(p20.Transform, p20.Radius, p20.Length);
end;
return u1;
