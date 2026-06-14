-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.Collider
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__Dependencies__2 = script.Parent.Parent.Parent:WaitForChild("Dependencies");
local l__Colliders__3 = script.Parent:WaitForChild("Colliders");
local l__Box__4 = require(l__Colliders__3:WaitForChild("Box"));
local l__Capsule__5 = require(l__Colliders__3:WaitForChild("Capsule"));
local l__Cylinder__6 = require(l__Colliders__3:WaitForChild("Cylinder"));
local l__Sphere__7 = require(l__Colliders__3:WaitForChild("Sphere"));
local l__Config__8 = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Config"));
local l__SB_VERBOSE_LOG__9 = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG;
local l__Gizmo__10 = require(l__Dependencies__2:WaitForChild("Gizmo"));
if game:GetService("RunService"):IsStudio() or l__Config__8.ALLOW_LIVE_GAME_DEBUG or l__Config__8.ALLOW_LIVE_GAME_DEBUG then
    l__Gizmo__10.Init();
end;
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 76 ]]
    -- upvalues: l__HttpService__1 (copy), u1 (copy)
    local v2 = {
        Type = "Box",
        Scale = Vector3.new(0, 0, 0),
        Offset = Vector3.new(0, 0, 0),
        Rotation = Vector3.new(0, 0, 0),
        Radius = 0,
        PreviousScale = Vector3.new(0, 0, 0),
        PreviousOffset = Vector3.new(0, 0, 0),
        PreviousRotation = Vector3.new(0, 0, 0),
        PreviousObjectPosition = Vector3.new(0, 0, 0),
        PreviousObjectRotation = Vector3.new(0, 0, 0),
        m_Object = nil,
        InNarrowphase = false,
        Size = Vector3.new(0, 0, 0),
        Transform = CFrame.identity,
        GUID = l__HttpService__1:GenerateGUID(false)
    };
    return setmetatable(v2, u1);
end;
function u1.SetObject(p3, p4) --[[ Line: 105 ]]
    p3.m_Object = p4;
    p3:UpdateTransform();
end;
function u1.UpdateTransform(p5) --[[ Line: 112 ]]
    local l__m_Object__11 = p5.m_Object;
    local l__CFrame__12 = l__m_Object__11.CFrame;
    local l__Size__13 = l__m_Object__11.Size;
    local l__Scale__14 = p5.Scale;
    local l__Offset__15 = p5.Offset;
    local l__Rotation__16 = p5.Rotation;
    local v6 = l__Size__13 * l__Offset__15;
    local v7 = l__Size__13 * l__Scale__14;
    local v8 = CFrame.Angles(l__Rotation__16.X * 0.017453, l__Rotation__16.Y * 0.017453, l__Rotation__16.Z * 0.017453);
    p5.Transform = l__CFrame__12 * CFrame.new(v6) * v8;
    p5.Size = v7;
    local v9 = (math.max(v7.X, v7.Y, v7.Z) * 0.5) ^ 2 * 2;
    p5.Radius = math.sqrt(v9);
end;
function u1.GetClosestPoint(p10, p11, p12) --[[ Line: 137 ]]
    -- upvalues: l__Box__4 (copy), l__Capsule__5 (copy), l__Sphere__7 (copy), l__Cylinder__6 (copy)
    if p10.m_Object == nil then
    else
        p10.InNarrowphase = false;
        if (p11 - p10.Transform.Position).Magnitude - p12 <= p10.Radius then
            p10.InNarrowphase = true;
            local l__Type__17 = p10.Type;
            local v13, v14, v15;
            if l__Type__17 == "Box" then
                v13, v14, v15 = l__Box__4(p10.Transform, p10.Size, p11, p12);
            else
                v13 = nil;
                v14 = nil;
                v15 = nil;
            end;
            if l__Type__17 == "Capsule" then
                v13, v14, v15 = l__Capsule__5(p10.Transform, p10.Size, p11, p12);
            end;
            if l__Type__17 == "Sphere" then
                v13, v14, v15 = l__Sphere__7(p10.Transform, p10.Size, p11, p12);
            end;
            if l__Type__17 == "Cylinder" then
                v13, v14, v15 = l__Cylinder__6(p10.Transform, p10.Size, p11, p12);
            end;
            return v13, v14, v15;
        end;
    end;
end;
function u1.Step(p16) --[[ Line: 182 ]]
    p16:UpdateTransform();
end;
function u1.DrawDebug(p17, p18, p19, p20, p21, p22) --[[ Line: 194 ]]
    -- upvalues: l__Gizmo__10 (copy)
    local v23 = Color3.new(0.509803, 0.933333, 0.42745);
    local v24 = Color3.new(0.90196, 0.784313, 0.513725);
    local v25 = Color3.new(1, 0, 1);
    local v26 = Color3.new(0, 1, 1);
    local v27 = Color3.new(1, 0.3, 0.3);
    local l__Type__18 = p17.Type;
    local l__Transform__19 = p17.Transform;
    local l__Size__20 = p17.Size;
    if p18.m_Awake then
        v25 = v23;
    elseif not p21 then
        v25 = v23;
    end;
    if p17.InNarrowphase == false then
        if not p22 then
            v26 = v24;
        end;
    else
        v26 = v24;
    end;
    if p20 then
        l__Gizmo__10.SetStyle(v27, 0, false);
        l__Gizmo__10.Sphere:Draw(l__Transform__19, p17.Radius, 25, 360);
    end;
    if l__Type__18 == "Box" then
        l__Gizmo__10.SetStyle(v25, 0, false);
        l__Gizmo__10.Box:Draw(l__Transform__19, l__Size__20);
        if p19 then
            l__Gizmo__10.SetStyle(v26, 0.75, false);
            l__Gizmo__10.VolumeBox:Draw(l__Transform__19, l__Size__20);
            l__Gizmo__10.PushProperty("Transparency", 0);
        end;
    elseif l__Type__18 == "Capsule" then
        local v28 = (l__Size__20.Y < l__Size__20.Z and l__Size__20.Y or l__Size__20.Z) * 0.5;
        local l__X__21 = l__Size__20.X;
        local v29 = l__Transform__19 * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0);
        l__Gizmo__10.SetStyle(v25, 0, false);
        l__Gizmo__10.Capsule:Draw(v29, v28, l__X__21, 15);
        if p19 then
            local v30 = v29.Position + v29.UpVector * (l__X__21 * 0.5);
            local v31 = v29.Position - v29.UpVector * (l__X__21 * 0.5);
            l__Gizmo__10.SetStyle(v26, 0.75, false);
            l__Gizmo__10.VolumeCylinder:Draw(l__Transform__19, v28, l__X__21);
            l__Gizmo__10.VolumeSphere:Draw(CFrame.new(v30), v28);
            l__Gizmo__10.VolumeSphere:Draw(CFrame.new(v31), v28);
            l__Gizmo__10.PushProperty("Transparency", 0);
        end;
    elseif l__Type__18 == "Sphere" then
        local v32 = math.min(l__Size__20.X, l__Size__20.Y, l__Size__20.Z) * 0.5;
        l__Gizmo__10.SetStyle(v25, 0, false);
        l__Gizmo__10.Sphere:Draw(l__Transform__19, v32, 15, 360);
        if p19 then
            l__Gizmo__10.SetStyle(v26, 0.75, false);
            l__Gizmo__10.VolumeSphere:Draw(l__Transform__19, v32);
            l__Gizmo__10.PushProperty("Transparency", 0);
        end;
    elseif l__Type__18 == "Cylinder" then
        local v33 = (l__Size__20.Y < l__Size__20.Z and l__Size__20.Y or l__Size__20.Z) * 0.5;
        l__Gizmo__10.SetStyle(v25, 0, false);
        l__Gizmo__10.Cylinder:Draw(l__Transform__19 * CFrame.Angles(0, 0, 1.5707963267948966), v33, l__Size__20.X, 15);
        if p19 then
            l__Gizmo__10.SetStyle(v26, 0.75, false);
            l__Gizmo__10.VolumeCylinder:Draw(l__Transform__19 * CFrame.Angles(0, -1.5707963267948966, 0), v33, l__Size__20.X, 0, 360);
            l__Gizmo__10.PushProperty("Transparency", 0);
        end;
    end;
end;
function u1.Destroy(p34) --[[ Line: 286 ]]
    -- upvalues: l__SB_VERBOSE_LOG__9 (copy)
    l__SB_VERBOSE_LOG__9((`Collider destroying, object: {p34.m_Object}`));
    setmetatable(p34, nil);
end;
return u1;
