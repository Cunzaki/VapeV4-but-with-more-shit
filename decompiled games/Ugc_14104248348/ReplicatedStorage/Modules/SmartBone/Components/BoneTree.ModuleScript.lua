-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.BoneTree
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Random.new(1029410295159813);
local l__Lighting__1 = game:GetService("Lighting");
local l__Dependencies__2 = script.Parent.Parent:WaitForChild("Dependencies");
require(script.Parent:WaitForChild("Bone"));
local l__Config__3 = require(l__Dependencies__2:WaitForChild("Config"));
local l__DefaultObjectSettings__4 = require(l__Dependencies__2:WaitForChild("DefaultObjectSettings"));
local l__Gizmo__5 = require(l__Dependencies__2:WaitForChild("Gizmo"));
local l__Utilities__6 = require(l__Dependencies__2:WaitForChild("Utilities"));
if game:GetService("RunService"):IsStudio() or l__Config__3.ALLOW_LIVE_GAME_DEBUG then
    l__Gizmo__5.Init();
end;
local l__SB_VERBOSE_LOG__7 = l__Utilities__6.SB_VERBOSE_LOG;
local u2 = {};
u2.__index = u2;
function u2.new(p3, u4) --[[ Line: 170 ]]
    -- upvalues: u1 (copy), u2 (copy), l__DefaultObjectSettings__4 (copy)
    local v5 = {
        UpdateRate = 0,
        InView = true,
        AccumulatedDelta = 0,
        Destroyed = false,
        IsSkippingUpdates = false,
        InWorkspace = false,
        Force = Vector3.new(0, 0, 0),
        ObjectMove = Vector3.new(0, 0, 0),
        ObjectVelocity = Vector3.new(0, 0, 0),
        ObjectAcceleration = Vector3.new(0, 0, 0),
        WindOffset = u1:NextNumber(0, 1000000),
        Root = p3:IsA("Bone") and p3 and p3 or nil,
        RootPart = u4,
        RootPartSize = u4.Size,
        Bones = {},
        Settings = {},
        BoundingBoxCFrame = u4.CFrame,
        BoundingBoxSize = u4.Size,
        ObjectPreviousPosition = u4.Position
    };
    local u6 = setmetatable(v5, u2);
    u6.InWorkspace = u4:IsDescendantOf(workspace);
    u6.DestroyConnection = u4.AncestryChanged:ConnectParallel(function() --[[ Line: 198 ]]
        -- upvalues: u4 (copy), u6 (copy)
        if not u4:IsDescendantOf(game) then
            u6.Destroyed = true;
        end;
        u6.InWorkspace = u4:IsDescendantOf(workspace);
    end);
    u6.AttributeConnection = u4.AttributeChanged:ConnectParallel(function(p7) --[[ Line: 206 ]]
        -- upvalues: u6 (copy), u4 (copy), l__DefaultObjectSettings__4 (ref)
        u6.Settings[p7] = u4:GetAttribute(p7) or l__DefaultObjectSettings__4[p7];
    end);
    return u6;
end;
function u2.UpdateBoundingBox(p8) --[[ Line: 217 ]]
    if p8.InView then
        local v9 = Vector3.new(inf, inf, inf);
        local v10 = Vector3.new(-inf, -inf, -inf);
        for _, v11 in p8.Bones do
            local v12 = v11.Position + (v11.Position - v11.LastPosition);
            v9 = v9:Min(v12);
            v10 = v10:Max(v12);
        end;
        p8.BoundingBoxCFrame = CFrame.new((v9 + v10) * 0.5);
        p8.BoundingBoxSize = p8.RootPartSize:Max(v10 - v9);
    else
        p8.BoundingBoxCFrame = p8.RootPart.CFrame;
        p8.BoundingBoxSize = p8.RootPart.Size;
    end;
end;
function u2.UpdateThrottling(p13, p14) --[[ Line: 254 ]]
    local l__Settings__8 = p13.Settings;
    local l__Magnitude__9 = (p14 - workspace.CurrentCamera.CFrame.Position).Magnitude;
    if l__Settings__8.ActivationDistance < l__Magnitude__9 then
        p13.UpdateRate = 0;
    else
        local l__ThrottleDistance__10 = l__Settings__8.ThrottleDistance;
        local v15 = (l__Magnitude__9 - l__ThrottleDistance__10) / (l__Settings__8.ActivationDistance - l__ThrottleDistance__10) * 1 + 0;
        p13.UpdateRate = l__Settings__8.UpdateRate * (1 - ((v15 < 1 and v15 and v15 or 1) > 0 and (v15 < 1 and v15 and v15 or 1) or 0));
    end;
end;
function u2.PreUpdate(p16, _) --[[ Line: 275 ]]
    local l__Position__11 = p16.RootPart.CFrame.Position;
    local l__ObjectVelocity__12 = p16.ObjectVelocity;
    p16.ObjectMove = l__Position__11 - p16.ObjectPreviousPosition;
    p16.ObjectVelocity = p16.ObjectMove;
    p16.ObjectAcceleration = l__ObjectVelocity__12 - p16.ObjectVelocity;
    p16.ObjectPreviousPosition = l__Position__11;
    p16.RootPartSize = p16.RootPart.Size;
    p16:UpdateThrottling(l__Position__11);
    p16:UpdateBoundingBox();
    for _, v17 in p16.Bones do
        v17:PreUpdate(p16);
    end;
end;
function u2.StepPhysics(p18, p19) --[[ Line: 300 ]]
    -- upvalues: l__Lighting__1 (copy), l__DefaultObjectSettings__4 (copy)
    local l__Settings__13 = p18.Settings;
    local v20 = (l__Settings__13.Gravity + l__Settings__13.Force) * p19;
    if l__Settings__13.MatchWorkspaceWind == true then
        local l__GlobalWind__14 = workspace.GlobalWind;
        l__Settings__13.WindDirection = l__GlobalWind__14.Magnitude == 0 and Vector3.new(0, 0, 0) or l__GlobalWind__14.Unit;
        l__Settings__13.WindSpeed = l__GlobalWind__14.Magnitude;
    else
        local v21 = l__Lighting__1:GetAttribute("WindDirection") or l__DefaultObjectSettings__4.WindDirection;
        local v22 = l__Lighting__1:GetAttribute("WindSpeed") or l__DefaultObjectSettings__4.WindSpeed;
        l__Settings__13.WindDirection = v21.Magnitude == 0 and Vector3.new(0, 0, 0) or v21.Unit;
        l__Settings__13.WindSpeed = v22;
    end;
    l__Settings__13.WindStrength = l__Lighting__1:GetAttribute("WindStrength") or l__DefaultObjectSettings__4.WindStrength;
    for _, v23 in p18.Bones do
        v23:StepPhysics(p18, v20, p19);
    end;
end;
function u2.Constrain(p24, p25, p26) --[[ Line: 330 ]]
    for _, v27 in p24.Bones do
        v27:Constrain(p24, p25, p26);
    end;
end;
function u2.SkipUpdate(p28) --[[ Line: 340 ]]
    for _, v29 in p28.Bones do
        v29:SkipUpdate();
    end;
    p28.IsSkippingUpdates = true;
end;
function u2.SolveTransform(p30, p31) --[[ Line: 352 ]]
    for _, v32 in p30.Bones do
        v32:SolveTransform(p30, p31);
    end;
    p30.IsSkippingUpdates = false;
end;
function u2.ApplyTransform(p33) --[[ Line: 364 ]]
    for _, v34 in p33.Bones do
        v34:ApplyTransform(p33);
    end;
end;
function u2.DrawDebug(p35, p36, p37, p38, p39, p40, p41, p42, p43) --[[ Line: 382 ]]
    -- upvalues: l__Gizmo__5 (copy)
    local v44 = Color3.fromRGB(248, 168, 20);
    local v45 = Color3.fromRGB(76, 208, 223);
    local v46 = Color3.fromRGB(255, 89, 89);
    local v47 = Color3.new(1, 0, 0);
    local v48 = Color3.new(0, 1, 0);
    local v49 = Color3.new(0, 0, 1);
    if p43 then
        local v50 = p35.RootPart.Position + Vector3.new(0, p35.RootPart.Size.Y * 0.5 + 1, 0);
        l__Gizmo__5.SetStyle(v47, 0, true);
        l__Gizmo__5.Arrow:Draw(v50, v50 + p35.ObjectMove, 0.025, 0.1, 6);
        l__Gizmo__5.SetStyle(v48, 0, true);
        l__Gizmo__5.Arrow:Draw(v50, v50 + p35.ObjectVelocity, 0.025, 0.1, 6);
        l__Gizmo__5.SetStyle(v49, 0, true);
        l__Gizmo__5.Arrow:Draw(v50, v50 + p35.ObjectAcceleration, 0.025, 0.1, 6);
    end;
    l__Gizmo__5.PushProperty("AlwaysOnTop", false);
    if p41 then
        l__Gizmo__5.PushProperty("Color3", v45);
        l__Gizmo__5.Box:Draw(p35.BoundingBoxCFrame, p35.BoundingBoxSize, true);
    end;
    if p40 then
        l__Gizmo__5.PushProperty("Color3", v45);
        l__Gizmo__5.Box:Draw(p35.RootPart.CFrame, p35.RootPart.Size, true);
        l__Gizmo__5.SetStyle(v46, 0.75, false);
        l__Gizmo__5.VolumeBox:Draw(p35.RootPart.CFrame, p35.RootPart.Size);
        l__Gizmo__5.PushProperty("Transparency", 0);
    end;
    for v51, v52 in p35.Bones do
        local l__Position__15 = v52.Bone.TransformedWorldCFrame.Position;
        local v53 = p35.Bones[v52.ParentIndex];
        v52:DrawDebug(p35, p36, p37, p38, p39, p42);
        if p37 and v51 ~= 1 then
            l__Gizmo__5.PushProperty("Color3", v44);
            l__Gizmo__5.Ray:Draw(v53.Bone.TransformedWorldCFrame.Position, l__Position__15);
        end;
    end;
end;
function u2.DrawOverlay(p54, p55) --[[ Line: 447 ]]
    -- upvalues: l__Config__3 (copy)
    if l__Config__3.DEBUG_OVERLAY_TREE_INFO or l__Config__3.DEBUG_OVERLAY_TREE_OBJECTS then
        p55.Text((`Root Part: {p54.RootPart.Name}`));
        p55.Text((`Root Bone: {p54.Root.Name}`));
        p55.Text((`Root Part Size: {string.format("%.3f, %.3f, %.3f", p54.RootPart.Size.X, p54.RootPart.Size.Y, p54.RootPart.Size.Z)}`));
    end;
    if l__Config__3.DEBUG_OVERLAY_TREE_INFO or l__Config__3.DEBUG_OVERLAY_TREE_NUMERICS then
        p55.Text((`Update Rate: {string.format("%.3f", p54.UpdateRate)}`));
        p55.Text((`In View: {p54.InView}`));
        p55.Text((`Accumulated Delta: {string.format("%.3f", p54.AccumulatedDelta)}`));
        p55.Text((`Force: {string.format("%.3f, %.3f, %.3f", p54.Force.X, p54.Force.Y, p54.Force.Z)}`));
    end;
    local v56 = Color3.new(0.486275, 0.431373, 1);
    local v57 = Color3.new(1, 1, 1);
    if l__Config__3.DEBUG_OVERLAY_BONE then
        for v58, v59 in p54.Bones do
            if l__Config__3.DEBUG_OVERLAY_MAX_BONES > 0 and l__Config__3.DEBUG_OVERLAY_BONE_OFFSET + l__Config__3.DEBUG_OVERLAY_MAX_BONES <= v58 then
                break;
            end;
            if v58 >= l__Config__3.DEBUG_OVERLAY_BONE_OFFSET then
                p55.Begin(`Bone {v58}`, v56, v57);
                v59:DrawOverlay(p55);
                p55.End();
            end;
        end;
    end;
end;
function u2.Destroy(p60) --[[ Line: 483 ]]
    -- upvalues: l__SB_VERBOSE_LOG__7 (copy)
    l__SB_VERBOSE_LOG__7("Destroy BoneTree");
    task.synchronize();
    p60.DestroyConnection:Disconnect();
    p60.AttributeConnection:Disconnect();
    for _, v61 in p60.Bones do
        v61:Destroy();
    end;
    setmetatable(p60, nil);
    task.desynchronize();
end;
return u2;
