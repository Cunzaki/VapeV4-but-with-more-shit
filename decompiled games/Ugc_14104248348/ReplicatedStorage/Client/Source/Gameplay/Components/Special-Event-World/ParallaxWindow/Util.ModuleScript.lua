-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.ParallaxWindow.Util
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
function u1.Lerp(p3, p4, p5) --[[ Line: 8 ]]
    return p3 * (1 - p5) + p4 * p5;
end;
function u1.ScreenToPhysicalSize(p6) --[[ Line: 12 ]]
    local l__ViewportSize__1 = p6.ViewportSize;
    local v7 = l__ViewportSize__1.X / l__ViewportSize__1.Y;
    local v8 = math.rad(p6.FieldOfView / 2);
    local v9 = math.tan(v8) * 2;
    return Vector3.new(v7 * v9, v9, 0);
end;
function u1.WorldToScreenPoint(p10, p11) --[[ Line: 23 ]]
    -- upvalues: u1 (copy)
    local v12 = p10.CFrame:ToObjectSpace(p11);
    local v13 = -(v12.Position / v12.Z) / u1.ScreenToPhysicalSize(p10);
    return Vector2.new(v13.X + 0.5, -v13.Y + 0.5) * p10.ViewportSize, v12;
end;
function u1.IsCircleVisible(p14, p15, p16) --[[ Line: 39 ]]
    local l__ViewportSize__2 = p16.ViewportSize;
    local v17 = p14 - Vector2.new(p15, p15);
    local v18 = p14 + Vector2.new(p15, p15);
    if v17.X > l__ViewportSize__2.X or v17.Y > l__ViewportSize__2.Y then
    else
        if v18.X >= 0 and v18.Y >= 0 then
            return true;
        end;
    end;
end;
function u1.WorldToScreenSize(p19, p20, p21) --[[ Line: 55 ]]
    -- upvalues: u1 (copy)
    local v22 = p21 / p19.CFrame:ToObjectSpace(CFrame.new(p20)).Z;
    return math.abs(v22) / u1.ScreenToPhysicalSize(p19).Magnitude * p19.ViewportSize.Magnitude;
end;
function u1.GetSurfaceInfo(p23) --[[ Line: 68 ]]
    local l__CFrame__3 = p23.CFrame;
    local l__Size__4 = p23.Size;
    local v24 = Vector3.FromNormalId(Enum.NormalId.Back);
    local v25 = math.abs(v24.y) == 1 and (Vector3.new(v24.y, 0, 0) or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);
    local v26 = CFrame.fromAxisAngle(v25, 1.5707963267948966) * v24;
    local l__Unit__5 = v24:Cross(v26).Unit;
    return l__CFrame__3 * CFrame.fromMatrix(-v24 * l__Size__4 / 2, v26, l__Unit__5, v24), Vector3.new((l__Size__4 * v26).Magnitude, (l__Size__4 * l__Unit__5).Magnitude, (l__Size__4 * v24).Magnitude);
end;
function u1.ComputeCamData(p27, p28, p29, p30) --[[ Line: 82 ]]
    -- upvalues: u2 (copy)
    local v31 = p28 * Vector3.new(0, p29.Y / 2, 0);
    local v32 = p28 * Vector3.new(0, -p29.Y / 2, 0);
    local v33 = p27.LookVector:Cross(p28.UpVector);
    local v34 = v33:Dot(v33) > 0 and v33.Unit or p27.RightVector;
    local v35 = CFrame.fromMatrix(p27.Position, v34, p28.UpVector, v34:Cross(p28.UpVector)):Inverse();
    local v36 = v35 * v32;
    local v37 = v35 * v31;
    local l__Unit__6 = (v36 * Vector3.new(0, 1, 1)).Unit;
    local l__Unit__7 = (v37 * Vector3.new(0, 1, 1)).Unit;
    local v38 = math.sign(l__Unit__6.y);
    local v39 = l__Unit__6:Dot(Vector3.new(0, 0, -1));
    local v40 = v38 * math.acos(v39);
    local v41 = math.sign(l__Unit__7.y);
    local v42 = l__Unit__7:Dot(Vector3.new(0, 0, -1));
    local v43 = v41 * math.acos(v42);
    local v44 = math.rad(p30.FieldOfView) / 2;
    local v45 = math.tan(v44) * 2;
    local v46 = (math.tan(v43) - math.tan(v40)) / v45;
    local v47 = p28:VectorToObjectSpace(p28.Position - p27.Position);
    local v48 = v47 * Vector3.new(1, 0, 1);
    local v49 = v47 * Vector3.new(0, 1, 1);
    local v50 = v48.Unit:Dot(Vector3.new(0, 0, -1));
    local v51 = (p28:VectorToObjectSpace(p27.LookVector) * Vector3.new(1, 0, 1)).Unit:Dot(v48.Unit) / (Vector3.new(0, 0, -1)):Dot(v48.Unit);
    local v52 = math.sqrt(1 - v50 * v50) / v50;
    local v53 = p29.X / p29.X;
    local v54 = math.sign(v47.x * v47.z) * v52;
    local v55 = v49.y / v49.z * v53;
    local v56 = math.abs(v51 * v46 * v53);
    local v57 = { ((p28 - p28.Position) * u2 * CFrame.new(0, 0, 0, 1, 0, 0, 0, v53, 0, v54, v55, v56)):GetComponents() };
    local v58 = {};
    for v59 = 1, #v57 do
        v58[v59] = math.abs(v57[v59]);
    end;
    local v60 = math.max(table.unpack(v58));
    local v61 = CFrame.new(v57[1], v57[2], v57[3], v57[4] / v60, v57[5] / v60, v57[6] / v60, v57[7] / v60, v57[8] / v60, v57[9] / v60, v57[10] / v60, v57[11] / v60, v57[12] / v60) + p27.Position;
    return {
        FieldOfView = p30.FieldOfView,
        CFrame = v61,
        Focus = v61 * CFrame.new(0, 0, p27:PointToObjectSpace(p28.Position).Z)
    };
end;
function u1.GetNames(p62) --[[ Line: 147 ]]
    local v63 = {};
    for _, v64 in pairs(p62:GetChildren()) do
        table.insert(v63, v64.Name);
    end;
    return table.unpack(v63);
end;
return u1;
