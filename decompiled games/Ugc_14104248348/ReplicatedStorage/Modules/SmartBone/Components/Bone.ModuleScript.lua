-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Bone
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Dependencies__1 = script.Parent.Parent:WaitForChild("Dependencies");
local l__Config__2 = require(l__Dependencies__1:WaitForChild("Config"));
local l__Gizmo__3 = require(l__Dependencies__1:WaitForChild("Gizmo"));
local l__Utilities__4 = require(l__Dependencies__1:WaitForChild("Utilities"));
if game:GetService("RunService"):IsStudio() or l__Config__2.ALLOW_LIVE_GAME_DEBUG then
    l__Gizmo__3.Init();
end;
local l__Constraints__5 = script.Parent:WaitForChild("Constraints");
local l__AxisConstraint__6 = require(l__Constraints__5:WaitForChild("AxisConstraint"));
local l__CollisionConstraint__7 = require(l__Constraints__5:WaitForChild("CollisionConstraint"));
local l__DistanceConstraint__8 = require(l__Constraints__5:WaitForChild("DistanceConstraint"));
local l__FrictionConstraint__9 = require(l__Constraints__5:WaitForChild("FrictionConstraint"));
local l__RopeConstraint__10 = require(l__Constraints__5:WaitForChild("RopeConstraint"));
local l__RotationConstraint__11 = require(l__Constraints__5:WaitForChild("RotationConstraint"));
local l__SpringConstraint__12 = require(l__Constraints__5:WaitForChild("SpringConstraint"));
local _ = l__Utilities__4.SB_ASSERT_CB;
local u1 = {};
local function u6(p2) --[[ Line: 97 ]]
    -- upvalues: u1 (copy), u6 (copy)
    local v3 = u1[p2];
    if v3 and v3.Frame == shared.FrameCounter then
        return v3.CFrame;
    end;
    local l__Parent__13 = p2.Parent;
    local v4;
    if l__Parent__13:IsA("Bone") then
        v4 = u6(l__Parent__13);
    else
        v4 = l__Parent__13.CFrame;
    end;
    local v5 = v4 * p2.TransformedCFrame;
    u1[p2] = {
        Frame = shared.FrameCounter,
        CFrame = v5
    };
    return v5;
end;
local function u10(p7, p8) --[[ Line: 124 ]]
    -- upvalues: u6 (copy), u10 (copy)
    p8.SolvedAnimatedCFrame = true;
    local l__ParentIndex__14 = p8.ParentIndex;
    local l__Bone__15 = p8.Bone;
    if l__ParentIndex__14 < 1 then
        return u6(l__Bone__15);
    end;
    local v9 = p7.Bones[l__ParentIndex__14];
    if not v9.SolvedAnimatedCFrame then
        v9.AnimatedWorldCFrame = u10(p7, v9);
    end;
    return v9.AnimatedWorldCFrame * l__Bone__15.TransformedCFrame;
end;
local function u51(p11, u12, p13) --[[ Line: 165 ]]
    local l__Settings__16 = u12.Settings;
    local l__WindType__17 = l__Settings__16.WindType;
    if l__WindType__17 ~= "Sine" and (l__WindType__17 ~= "Noise" and l__WindType__17 ~= "Hybrid") then
        return Vector3.new(0, 0, 0);
    end;
    local v14 = u12.WindOffset + (os.clock() - p11.HeirarchyLength * 0.2 + (p11.TransformOffset.Position - u12.Root.WorldPosition).Magnitude * 0.2) * l__Settings__16.WindInfluence;
    local l__WindSpeed__18 = l__Settings__16.WindSpeed;
    local l__WindStrength__19 = l__Settings__16.WindStrength;
    if l__WindSpeed__18 == Vector3.new(0, 0, 0) or l__WindStrength__19 == 0 then
        return Vector3.new(0, 0, 0);
    end;
    local l__WindDirection__20 = l__Settings__16.WindDirection;
    local v15 = p13.Magnitude == 0 and Vector3.new(0, 0, 0) or p13.Unit;
    local v16 = v15:Dot(l__WindDirection__20);
    local v17 = 1 - math.abs(v16);
    if l__WindSpeed__18 > 0 then
        if v15:Dot(l__WindDirection__20) > 0 then
            v17 = v17 * math.abs(1 - p13.Magnitude / l__WindSpeed__18);
        else
            v17 = v17 * (1 + p13.Magnitude / l__WindSpeed__18);
        end;
    end;
    local v18 = l__WindSpeed__18 * v17;
    local v19 = p13.Magnitude < 100 and p13.Magnitude or 100;
    local v20 = v19 == 0 and 0 or 2 ^ (v19 * 10 - 10);
    local u21 = v14 * math.max(v20, 1);
    local u22;
    if v18 < 1 then
        u22 = v18 * v20;
    else
        local v23 = v20 / 2;
        u22 = v18 * (v23 > 1 and v23 and v23 or 1);
    end;
    local v24 = nil;
    local function v36() --[[ Line: 248 ]]
        -- upvalues: l__WindStrength__19 (copy), u22 (ref), u21 (ref), l__WindDirection__20 (copy)
        local v25 = l__WindStrength__19 ^ 0.8;
        local v26 = u22 * 2;
        local v27 = math.sin(u21 * v25);
        local v28 = math.cos(u21 / 10 * v25);
        local v29 = math.sin(u21 * 2 * v25);
        local v30 = math.cos(u21 * 3 * v25);
        local v31 = (v27 + v28 + v29 + v30) / 4;
        local v32 = v31 * 0.5 + 0.5;
        local v33 = v31 * v26;
        local v34 = v32 * v26;
        local v35 = l__WindDirection__20;
        if v33 < v34 then
            v33 = v34 or v33;
        end;
        return v35 * v33;
    end;
    local function v50(p37, p38) --[[ Line: 266 ]]
        -- upvalues: l__WindStrength__19 (copy), u22 (ref), u12 (copy), l__WindDirection__20 (copy)
        local v39 = p37 or 0;
        local v40 = l__WindStrength__19 ^ 0.8;
        local v41 = u22 * 2;
        local l__WindOffset__21 = u12.WindOffset;
        local v42 = math.noise(v40, 0, l__WindOffset__21);
        local v43 = math.clamp(v42, -1, 1);
        if p38 then
            v43 = v43 ^ 2;
        end;
        local v44 = v43 * (v41 + v39);
        local v45 = math.noise(0, v40, l__WindOffset__21);
        local v46 = math.clamp(v45, -1, 1);
        if p38 then
            v46 = v46 ^ 2;
        end;
        local v47 = v46 * (v41 + v39);
        local v48 = math.noise(l__WindOffset__21, 0, v40);
        local v49 = math.clamp(v48, -1, 1);
        if p38 then
            v49 = v49 ^ 2;
        end;
        return l__WindDirection__20 * Vector3.new(v44, v47, v49 * (v41 + v39));
    end;
    if l__Settings__16.WindType == "Sine" then
        v24 = v36() * (math.sin(u21 * 1) * 0.3 + 0.7);
    elseif l__Settings__16.WindType == "Noise" then
        v24 = v50(0, true) * (math.sin(u21 * 1) * 0.3 + 0.7);
    elseif l__Settings__16.WindType == "Hybrid" then
        v24 = (v36() * (math.sin(u21 * 1) * 0.3 + 0.7) + v50(0.5, true) * (math.sin(u21 * 1) * 0.3 + 0.7)) * 0.5;
    end;
    return v24 / (p11.FreeLength < 0.01 and 0.01 or p11.FreeLength) * (l__Settings__16.WindInfluence * (l__WindStrength__19 * 0.01) * (math.clamp(p11.HeirarchyLength, 1, 10) * 0.1)) * p11.Weight;
end;
local u52 = {};
u52.__index = u52;
function u52.new(u53, p54, p55) --[[ Line: 442 ]]
    -- upvalues: u52 (copy), l__Utilities__4 (copy)
    local v56 = u53.Parent:IsA("Bone") and u53.Parent.TransformedWorldCFrame or p55.CFrame;
    local v57 = {
        Bone = u53,
        FreeLength = -1,
        Weight = 0.7,
        ParentIndex = -1,
        HeirarchyLength = 0,
        Transform = u53.TransformedWorldCFrame:ToObjectSpace(v56):Inverse(),
        LocalTransform = u53.TransformedCFrame:ToObjectSpace(p54.TransformedCFrame):Inverse(),
        RootPart = p55,
        RootBone = p54,
        Radius = 0,
        Friction = 0,
        RotationLimit = 0,
        Force = nil,
        Gravity = nil,
        SolvedAnimatedCFrame = false,
        HasChild = false,
        AnimatedWorldCFrame = u53.TransformedWorldCFrame,
        StartingCFrame = u53.TransformedCFrame,
        TransformOffset = CFrame.identity,
        LocalTransformOffset = CFrame.identity,
        RestPosition = Vector3.new(0, 0, 0),
        CalculatedWorldCFrame = u53.TransformedWorldCFrame,
        Position = u53.TransformedWorldCFrame.Position,
        LastPosition = u53.TransformedWorldCFrame.Position,
        WeldPosition = Vector3.new(0, 0, 0),
        WeldCFrame = CFrame.identity,
        ActiveWeld = false,
        RigidWeld = false,
        Anchored = false,
        AxisLocked = { false, false, false },
        XAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        YAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        ZAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        IsSkippingUpdates = false,
        CollisionHits = {},
        CollisionsData = {}
    };
    local u58 = setmetatable(v57, u52);
    u58.AttributeConnection = u53.AttributeChanged:Connect(function(_) --[[ Line: 495 ]]
        -- upvalues: l__Utilities__4 (ref), u53 (copy), u58 (copy)
        for v59, v62 in l__Utilities__4.GatherBoneSettings(u53) do
            local v61 = u58;
            if v62 == "¬" or not v62 then
                local v62 = nil;
            end;
            v61[v59] = v62;
        end;
    end);
    return u58;
end;
function u52.ClipVelocity(p63, p64, p65) --[[ Line: 512 ]]
    p63.LastPosition = p63.LastPosition * (Vector3.new(1, 1, 1) - p65) + p64 * p65;
end;
function u52.PreUpdate(p66, p67) --[[ Line: 518 ]]
    -- upvalues: u6 (copy), u10 (copy)
    local v68 = p67.Bones[1];
    local v69 = p67.Bones[p66.ParentIndex];
    p66.SolvedAnimatedCFrame = true;
    local l__ParentIndex__22 = p66.ParentIndex;
    local l__Bone__23 = p66.Bone;
    local v70;
    if l__ParentIndex__22 < 1 then
        v70 = u6(l__Bone__23);
    else
        local v71 = p67.Bones[l__ParentIndex__22];
        if not v71.SolvedAnimatedCFrame then
            v71.AnimatedWorldCFrame = u10(p67, v71);
        end;
        v70 = v71.AnimatedWorldCFrame * l__Bone__23.TransformedCFrame;
    end;
    p66.AnimatedWorldCFrame = v70;
    local v72 = p66.Bone:FindFirstChild("SmartWeld");
    p66.ActiveWeld = false;
    if v72 and v72:IsA("ObjectValue") then
        local l__Value__24 = v72.Value;
        p66.RigidWeld = v72:GetAttribute("Rigid") == true;
        if l__Value__24 then
            if l__Value__24:IsA("Attachment") then
                p66.WeldPosition = l__Value__24.WorldPosition;
                p66.WeldCFrame = l__Value__24.WorldCFrame;
                p66.ActiveWeld = true;
            elseif l__Value__24:IsA("BasePart") then
                p66.WeldPosition = l__Value__24.Position;
                p66.WeldCFrame = l__Value__24.CFrame;
                p66.ActiveWeld = true;
            end;
        end;
    end;
    if p66.ParentIndex < 1 then
        p66.Anchored = true;
    end;
    if p66.Bone == p66.RootBone then
        local v73;
        if p66.Bone.Parent:IsA("Bone") then
            v73 = u6(p66.Bone.Parent);
        else
            v73 = p66.RootPart.CFrame;
        end;
        p66.TransformOffset = v73 * p66.Transform;
    else
        p66.TransformOffset = v69.AnimatedWorldCFrame * p66.Transform;
    end;
    p66.LocalTransformOffset = v68.Bone.CFrame * p66.LocalTransform;
end;
function u52.StepPhysics(p74, p75, p76, p77) --[[ Line: 577 ]]
    -- upvalues: u51 (copy)
    if p74.Anchored then
        p74.LastPosition = p74.AnimatedWorldCFrame.Position;
        p74.Position = p74.AnimatedWorldCFrame.Position;
    else
        if p74.Force or p74.Gravity then
            p76 = ((p74.Gravity or p75.Settings.Gravity) + (p74.Force or p75.Settings.Force)) * p77;
        end;
        local l__Settings__25 = p75.Settings;
        local v78 = p74.Position - p74.LastPosition;
        local v79 = p75.ObjectAcceleration * l__Settings__25.Inertia;
        local v80 = u51(p74, p75, v78);
        p74.LastPosition = p74.Position;
        p74.Position = p74.Position + (v78 * (1 - l__Settings__25.Damping) + p76 + v79 + v80);
    end;
end;
function u52.Constrain(p81, p82, p83, p84) --[[ Line: 613 ]]
    -- upvalues: l__FrictionConstraint__9 (copy), l__CollisionConstraint__7 (copy), l__SpringConstraint__12 (copy), l__DistanceConstraint__8 (copy), l__RopeConstraint__10 (copy), l__AxisConstraint__6 (copy), l__RotationConstraint__11 (copy)
    if p81.Anchored then
    else
        local l__Position__26 = p81.Position;
        local l__CFrame__27 = p81.RootPart.CFrame;
        local v85 = l__FrictionConstraint__9(p81, l__Position__26, p81.LastPosition);
        if #p83 ~= 0 then
            v85 = l__CollisionConstraint__7(p81, v85, p83);
        end;
        local v86;
        if p82.Settings.Constraint == "Spring" then
            v86 = l__SpringConstraint__12(p81, v85, nil, p82, p84);
        elseif p82.Settings.Constraint == "Distance" then
            v86 = l__DistanceConstraint__8(p81, v85, p82);
        elseif p82.Settings.Constraint == "Rope" then
            v86 = l__RopeConstraint__10(p81, v85, p82);
        else
            v86 = p81.AnimatedWorldCFrame.Position;
        end;
        local v87 = l__RotationConstraint__11(p81, l__AxisConstraint__6(p81, v86, p81.LastPosition, l__CFrame__27), p82);
        if p81.ActiveWeld then
            if p81.RigidWeld then
                v87 = p81.WeldPosition;
            else
                v87 = l__SpringConstraint__12(p81, v87, p81.WeldPosition, p82, p84);
            end;
        end;
        p81.Friction = 0;
        for _, v88 in p81.CollisionHits do
            local l__CurrentPhysicalProperties__28 = p81.RootPart.CurrentPhysicalProperties;
            local l__CurrentPhysicalProperties__29 = v88.CurrentPhysicalProperties;
            local l__Friction__30 = l__CurrentPhysicalProperties__28.Friction;
            local l__FrictionWeight__31 = l__CurrentPhysicalProperties__28.FrictionWeight;
            local l__Friction__32 = l__CurrentPhysicalProperties__29.Friction;
            local l__FrictionWeight__33 = l__CurrentPhysicalProperties__29.FrictionWeight;
            local v89 = (l__Friction__30 * l__FrictionWeight__31 + l__Friction__32 * l__FrictionWeight__33) / (l__FrictionWeight__31 + l__FrictionWeight__33);
            if v89 < p81.Friction then
                v89 = p81.Friction or v89;
            end;
            p81.Friction = v89;
        end;
        p81.Position = v87;
    end;
end;
function u52.SkipUpdate(p90) --[[ Line: 668 ]]
    -- upvalues: l__Config__2 (copy)
    if p90.IsSkippingUpdates == false and l__Config__2.RESET_TRANSFORM_ON_SKIP then
        p90.CalculatedWorldCFrame = p90.AnimatedWorldCFrame;
        p90.IsSkippingUpdates = true;
    end;
    p90.LastPosition = p90.AnimatedWorldCFrame.Position + (p90.LastPosition - p90.Position);
    p90.Position = p90.AnimatedWorldCFrame.Position;
end;
function u52.SolveTransform(p91, p92, p93) --[[ Line: 683 ]]
    -- upvalues: l__Utilities__4 (copy)
    if p91.ParentIndex < 1 then
    else
        p91.IsSkippingUpdates = false;
        local v94 = p92.Bones[p91.ParentIndex];
        if v94 and v94.Bone then
            local l__TransformOffset__34 = v94.TransformOffset;
            local v95 = l__Utilities__4.GetRotationBetween(l__TransformOffset__34.UpVector, p91.Position - v94.Position).Rotation * l__TransformOffset__34.Rotation;
            math.min(1 - 0.00001 ^ p93, 1);
            if v94.ActiveWeld and v94.RigidWeld then
                v94.CalculatedWorldCFrame = v94.WeldCFrame;
                return;
            end;
            v94.CalculatedWorldCFrame = CFrame.new(v94.Position) * v95;
        end;
    end;
end;
function u52.ApplyTransform(p96, p97) --[[ Line: 722 ]]
    p96.SolvedAnimatedCFrame = false;
    if p96.ParentIndex < 1 then
    else
        local v98 = p97.Bones[p96.ParentIndex];
        local l__Bone__35 = v98.Bone;
        if v98 and l__Bone__35 then
            if v98.Anchored and p97.Settings.AnchorsRotate == false then
                l__Bone__35.WorldCFrame = v98.TransformOffset;
                return;
            end;
            l__Bone__35.WorldCFrame = v98.CalculatedWorldCFrame;
        end;
    end;
end;
function u52.DrawDebug(p99, p100, p101, p102, p103, p104, p105) --[[ Line: 763 ]]
    -- upvalues: l__Gizmo__3 (copy)
    local v106 = Color3.fromRGB(255, 0, 0);
    local v107 = Color3.fromRGB(255, 94, 0);
    local v108 = Color3.fromRGB(234, 1, 255);
    local v109 = Color3.fromRGB(0, 255, 255);
    local v110 = Color3.fromRGB(255, 0, 0);
    local v111 = Color3.fromRGB(0, 255, 0);
    local v112 = Color3.fromRGB(0, 0, 255);
    local v113 = Color3.fromRGB(0, 183, 255);
    local v114 = Color3.fromRGB(255, 0, 0);
    local v115 = Color3.fromRGB(0, 255, 0);
    local v116 = Color3.fromRGB(0, 0, 255);
    local v117 = Color3.fromRGB(28, 41, 224);
    local v118 = Color3.fromRGB(255, 27, 27);
    local v119 = 1;
    local l__AnimatedWorldCFrame__36 = p99.AnimatedWorldCFrame;
    local l__Position__37 = l__AnimatedWorldCFrame__36.Position;
    local v120 = CFrame.new(p99.Position);
    local v121 = CFrame.new(p99.LastPosition);
    if p103 then
        l__Gizmo__3.PushProperty("AlwaysOnTop", false);
        l__Gizmo__3.PushProperty("Color3", v106);
        l__Gizmo__3.Sphere:Draw(v120, p99.Radius, 10, 360);
        l__Gizmo__3.PushProperty("Color3", v107);
        l__Gizmo__3.Sphere:Draw(v121, p99.Radius, 10, 360);
        l__Gizmo__3.PushProperty("Color3", v108);
        l__Gizmo__3.Ray:Draw(p99.Position, p99.LastPosition);
    end;
    if p104 and not p99.Anchored then
        local v122 = p99.AxisLocked[1];
        local v123 = p99.AxisLocked[2];
        local v124 = p99.AxisLocked[3];
        local l__RootPart__38 = p99.RootPart;
        local v125 = l__RootPart__38.CFrame:PointToObjectSpace(l__Position__37);
        local l__RightVector__39 = l__RootPart__38.CFrame.RightVector;
        local l__UpVector__40 = l__RootPart__38.CFrame.UpVector;
        local l__LookVector__41 = l__RootPart__38.CFrame.LookVector;
        if not v122 then
            l__Gizmo__3.PushProperty("Color3", v114);
            l__Gizmo__3.Arrow:Draw(l__Position__37 - l__RightVector__39 * 2, l__Position__37 + l__RightVector__39 * 2, 0.05, 0.15, 9);
            local v126 = p99.XAxisLimits.Min - v125.X;
            local v127 = p99.XAxisLimits.Max - v125.X;
            l__Gizmo__3.Plane:Draw(l__Position__37 + l__RightVector__39 * v126, l__RightVector__39, Vector3.new(5, 5, 0));
            l__Gizmo__3.Plane:Draw(l__Position__37 + l__RightVector__39 * v127, l__RightVector__39, Vector3.new(5, 5, 0));
        end;
        if not v123 then
            l__Gizmo__3.PushProperty("Color3", v115);
            l__Gizmo__3.Arrow:Draw(l__Position__37 - l__UpVector__40 * 2, l__Position__37 + l__UpVector__40 * 2, 0.05, 0.15, 9);
            local v128 = p99.YAxisLimits.Min - v125.Y;
            local v129 = p99.YAxisLimits.Max - v125.Y;
            l__Gizmo__3.Plane:Draw(l__Position__37 + l__UpVector__40 * v128, l__UpVector__40, Vector3.new(5, 5, 0));
            l__Gizmo__3.Plane:Draw(l__Position__37 + l__UpVector__40 * v129, l__UpVector__40, Vector3.new(5, 5, 0));
        end;
        if not v124 then
            l__Gizmo__3.PushProperty("Color3", v116);
            l__Gizmo__3.Arrow:Draw(l__Position__37 - l__LookVector__41 * 2, l__Position__37 + l__LookVector__41 * 2, 0.05, 0.15, 9);
            local v130 = p99.ZAxisLimits.Min - v125.Z;
            local v131 = p99.ZAxisLimits.Max - v125.Z;
            l__Gizmo__3.Plane:Draw(l__Position__37 - l__LookVector__41 * v130, l__LookVector__41, Vector3.new(5, 5, 0));
            l__Gizmo__3.Plane:Draw(l__Position__37 - l__LookVector__41 * v131, l__LookVector__41, Vector3.new(5, 5, 0));
        end;
    end;
    if p102 then
        l__Gizmo__3.PushProperty("Color3", v109);
        l__Gizmo__3.Sphere:Draw(l__AnimatedWorldCFrame__36, 0.08, 5, 360);
        l__Gizmo__3.PushProperty("Color3", v110);
        l__Gizmo__3.VolumeArrow:Draw(l__Position__37, l__Position__37 + l__AnimatedWorldCFrame__36.LookVector * 0.25, 0.005, 0.015, 0.05, true);
        l__Gizmo__3.PushProperty("Color3", v111);
        l__Gizmo__3.VolumeArrow:Draw(l__Position__37, l__Position__37 + l__AnimatedWorldCFrame__36.UpVector * 0.25, 0.005, 0.015, 0.05, true);
        l__Gizmo__3.PushProperty("Color3", v112);
        l__Gizmo__3.VolumeArrow:Draw(l__Position__37, l__Position__37 + l__AnimatedWorldCFrame__36.RightVector * 0.25, 0.005, 0.015, 0.05, true);
    end;
    if p101 and not p99.Anchored then
        for _, v132 in p99.CollisionsData do
            l__Gizmo__3.PushProperty("Color3", v117);
            l__Gizmo__3.Sphere:Draw(CFrame.new(v132.ClosestPoint), 0.08, 5, 360);
            l__Gizmo__3.PushProperty("Color3", v118);
            l__Gizmo__3.Arrow:Draw(v132.ClosestPoint, v132.ClosestPoint + v132.Normal * 0.5, 0.05, 0.15, 9);
        end;
    end;
    if p105 and (p99.RotationLimit < 180 and (p99.RotationLimit > 0 and (p99.ParentIndex > 0 and p99.HasChild))) then
        local v133 = 1;
        local v134;
        if p99.RotationLimit < 89.5 then
            local v135 = math.rad(p99.RotationLimit);
            v134 = v119 * math.tan(v135);
        elseif p99.RotationLimit > 90 then
            local v136 = math.rad(180 - p99.RotationLimit);
            v134 = v119 * math.tan(v136);
            v133 = -1;
        else
            v134 = 5;
            v119 = 0;
        end;
        local v137 = math.min(v134, 5);
        local v138 = v137 == 5 and 0 or v119;
        local v139 = (p99.Position - p100.Bones[p99.ParentIndex].Position).Unit * v133;
        local v140 = CFrame.lookAt(l__Position__37 + v139 * (v138 * 0.5), l__Position__37 + -v139 * 500, l__AnimatedWorldCFrame__36.LookVector);
        l__Gizmo__3.PushProperty("Color3", v113);
        l__Gizmo__3.Cone:Draw(v140, v137, v138, 8 + v137 * 2);
    end;
end;
function u52.DrawOverlay(p141, p142) --[[ Line: 954 ]]
    -- upvalues: l__Config__2 (copy)
    p142.Text((`Bone: {p141.Bone.Name}`));
    if l__Config__2.DEBUG_OVERLAY_BONE_INFO or l__Config__2.DEBUG_OVERLAY_BONE_NUMERICS then
        p142.Text((`Free Length: {p141.FreeLength}`));
        p142.Text((`Weight: {p141.Weight}`));
        p142.Text((`Parent Index: {p141.ParentIndex}`));
        p142.Text((`Heirarchy Length: {p141.HeirarchyLength}`));
        p142.Text((`Radius: {p141.Radius}`));
        p142.Text((`Friction: {p141.Friction}`));
        p142.Text((`Rotation Limit: {p141.RotationLimit}`));
    end;
    if l__Config__2.DEBUG_OVERLAY_BONE_INFO or l__Config__2.DEBUG_OVERLAY_BONE_CONSTRAIN then
        p142.Text((`Anchored: {p141.Anchored}`));
        p142.Text((`Axis Locked: {p141.AxisLocked[1]}, {p141.AxisLocked[2]}, {p141.AxisLocked[3]}`));
        p142.Text((`X Axis Limit: {p141.XAxisLimits}`));
        p142.Text((`Y Axis Limit: {p141.YAxisLimits}`));
        p142.Text((`Z Axis Limit: {p141.ZAxisLimits}`));
    end;
    if l__Config__2.DEBUG_OVERLAY_BONE_INFO or l__Config__2.DEBUG_OVERLAY_BONE_WELD then
        p142.Text((`Active Weld: {p141.ActiveWeld}`));
        p142.Text((`Rigid Weld: {p141.RigidWeld}`));
        p142.Text((`Weld Position: {string.format("%.3f, %.3f, %.3f", p141.WeldPosition.X, p141.WeldPosition.Y, p141.WeldPosition.Z)}`));
    end;
    if l__Config__2.DEBUG_OVERLAY_BONE_INFO or l__Config__2.DEBUG_OVERLAY_BONE_FORCES then
        local v143 = p141.Force and (string.format("%.3f, %.3f, %.3f", p141.Force.X, p141.Force.Y, p141.Force.Z) or "-, -, -") or "-, -, -";
        local v144 = p141.Gravity and string.format("%.3f, %.3f, %.3f", p141.Gravity.X, p141.Gravity.Y, p141.Gravity.Z) or "-, -, -";
        p142.Text((`Force: {v143}`));
        p142.Text((`Gravity: {v144}`));
    end;
end;
function u52.Destroy(p145) --[[ Line: 990 ]]
    -- upvalues: l__Config__2 (copy)
    if l__Config__2.RESET_BONE_ON_DESTROY then
        task.synchronize();
        p145.Bone.CFrame = p145.StartingCFrame;
    end;
    p145.AttributeConnection:Disconnect();
    setmetatable(p145, nil);
end;
return u52;
