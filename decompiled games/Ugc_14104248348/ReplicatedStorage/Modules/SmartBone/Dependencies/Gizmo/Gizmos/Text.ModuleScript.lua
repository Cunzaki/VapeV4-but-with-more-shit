-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Text
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CurrentCamera__1 = workspace.CurrentCamera;
local u1 = {};
u1.__index = u1;
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 9 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Ceive = p2;
    v7.Propertys = p3;
    v7.Request = p4;
    v7.Release = p5;
    v7.Retain = p6;
    return v7;
end;
function u1.Draw(p8, p9, p10, p11) --[[ Line: 21 ]]
    -- upvalues: l__CurrentCamera__1 (copy)
    local l__Ceive__2 = p8.Ceive;
    if l__Ceive__2.Enabled then
        if p8.Propertys.AlwaysOnTop then
            local l__Magnitude__3 = (p9 - l__CurrentCamera__1.CFrame.Position).Magnitude;
            local v12 = l__Ceive__2.PopProperty("Color3");
            l__Ceive__2.PushProperty("Color3", Color3.new());
            l__Ceive__2.AOTWireframeHandle:AddText(p9 + -(Vector3.new(1, 1, 0)).Unit * (l__Magnitude__3 * 0.00175), p10, p11);
            l__Ceive__2.PushProperty("Color3", v12);
            l__Ceive__2.AOTWireframeHandle:AddText(p9, p10, p11);
        else
            local l__Magnitude__4 = (p9 - l__CurrentCamera__1.CFrame.Position).Magnitude;
            local v13 = l__Ceive__2.PopProperty("Color3");
            l__Ceive__2.PushProperty("Color3", Color3.new());
            l__Ceive__2.WireframeHandle:AddText(p9 + -(Vector3.new(1, 1, 0)).Unit * (l__Magnitude__4 * 0.00175), p10, p11);
            l__Ceive__2.PushProperty("Color3", v13);
            l__Ceive__2.WireframeHandle:AddText(p9, p10, p11);
        end;
        p8.Ceive.ScheduleCleaning();
    end;
end;
function u1.Create(p14, p15, p16, p17) --[[ Line: 60 ]]
    local v18 = {
        Enabled = true,
        Destroy = false,
        Origin = p15,
        Text = p16,
        Size = p17,
        AlwaysOnTop = p14.Propertys.AlwaysOnTop,
        Transparency = p14.Propertys.Transparency,
        Color3 = p14.Propertys.Color3
    };
    p14.Retain(p14, v18);
    return v18;
end;
function u1.Update(p19, p20) --[[ Line: 77 ]]
    local l__Ceive__5 = p19.Ceive;
    l__Ceive__5.PushProperty("AlwaysOnTop", p20.AlwaysOnTop);
    l__Ceive__5.PushProperty("Transparency", p20.Transparency);
    l__Ceive__5.PushProperty("Color3", p20.Color3);
    p19:Draw(p20.Origin, p20.Text, p20.Size);
end;
return u1;
