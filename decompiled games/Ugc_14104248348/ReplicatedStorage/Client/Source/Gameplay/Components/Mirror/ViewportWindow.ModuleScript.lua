-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Mirror.ViewportWindow
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
local u2 = Instance.new("ViewportFrame");
u2.Size = UDim2.new(1, 0, 1, 0);
u2.Position = UDim2.new(0.5, 0, 0.5, 0);
u2.AnchorPoint = Vector2.new(0.5, 0.5);
u2.BackgroundTransparency = 1;
u2.BackgroundColor3 = Color3.new(0, 0, 0);
Instance.new("WorldModel").Parent = u2;
local u3 = {};
u3.__index = u3;
function u3.new(p4) --[[ Line: 28 ]]
    -- upvalues: u3 (copy), u2 (copy)
    local v5 = setmetatable({}, u3);
    v5.SurfaceGUI = p4;
    v5.Camera = Instance.new("Camera", p4);
    v5.ViewportFrame = u2:Clone();
    v5.ViewportFrame.CurrentCamera = v5.Camera;
    v5.ViewportFrame.Parent = p4;
    v5:UpdateLighting();
    return v5;
end;
function u3.fromPart(p6, p7, p8) --[[ Line: 41 ]]
    -- upvalues: u3 (copy)
    local v9 = Instance.new("SurfaceGui");
    v9.Face = p7;
    v9.CanvasSize = Vector2.new(1024, 1024);
    v9.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    v9.Adornee = p6;
    v9.ResetOnSpawn = false;
    v9.ClipsDescendants = true;
    v9.Parent = p8;
    return u3.new(v9);
end;
function u3.RefreshLighting(p10, p11) --[[ Line: 56 ]]
    p10.ViewportFrame.LightDirection = -game.Lighting:GetSunDirection();
    p10.ViewportFrame.Ambient = game.Lighting.Ambient;
    if p11 then
        p10.ViewportFrame.LightColor = Color3.new(0, 0, 0):Lerp(Color3.new(1, 1, 1), (game.Lighting.Brightness - game.Lighting.ExposureCompensation) / 3.5);
    end;
end;
function u3.UpdateLighting(p12) --[[ Line: 65 ]]
    p12.ViewportFrame.LightDirection = -game.Lighting:GetSunDirection();
    p12.ViewportFrame.LightColor = Color3.new(0, 0, 0);
    p12.ViewportFrame.Ambient = game.Lighting.Ambient;
end;
function u3.GetPart(p13) --[[ Line: 71 ]]
    return p13.SurfaceGUI.Adornee;
end;
function u3.GetSurfaceInfo(p14) --[[ Line: 75 ]]
    local l__Adornee__1 = p14.SurfaceGUI.Adornee;
    local l__CFrame__2 = l__Adornee__1.CFrame;
    local l__Size__3 = l__Adornee__1.Size;
    local v15 = -Vector3.FromNormalId(p14.SurfaceGUI.Face);
    local v16 = math.abs(v15.y) == 1 and (Vector3.new(v15.y, 0, 0) or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);
    local v17 = CFrame.fromAxisAngle(v16, 1.5707963267948966) * v15;
    local l__Unit__4 = v15:Cross(v17).Unit;
    return l__CFrame__2 * CFrame.fromMatrix(-v15 * l__Size__3 / 2, v17, l__Unit__4, v15), Vector3.new((l__Size__3 * v17).Magnitude, (l__Size__3 * l__Unit__4).Magnitude, (l__Size__3 * v15).Magnitude);
end;
function u3.RenderFrame(p18, p19, p20, p21) --[[ Line: 90 ]]
    -- upvalues: u1 (copy)
    debug.profilebegin("ViewportWindow :: Render");
    local l__CurrentCamera__5 = game.Workspace.CurrentCamera;
    local v22 = p19 or l__CurrentCamera__5:GetRenderCFrame();
    if not (p20 and p21) then
        p20, p21 = p18:GetSurfaceInfo();
    end;
    local v23 = p20 * Vector3.new(0, p21.y / 2, 0);
    local v24 = p20 * Vector3.new(0, -p21.y / 2, 0);
    local v25 = v22.LookVector:Cross(p20.UpVector);
    local v26 = v25:Dot(v25) > 0 and v25.Unit or v22.RightVector;
    local v27 = CFrame.fromMatrix(v22.p, v26, p20.UpVector, v26:Cross(p20.UpVector)):Inverse();
    local v28 = v27 * v24;
    local v29 = v27 * v23;
    local l__Unit__6 = (v28 * Vector3.new(0, 1, 1)).Unit;
    local l__Unit__7 = (v29 * Vector3.new(0, 1, 1)).Unit;
    local v30 = math.sign(l__Unit__6.y);
    local v31 = l__Unit__6:Dot(Vector3.new(0, 0, -1));
    local v32 = v30 * math.acos(v31);
    local v33 = math.sign(l__Unit__7.y);
    local v34 = l__Unit__7:Dot(Vector3.new(0, 0, -1));
    local v35 = v33 * math.acos(v34);
    local v36 = math.rad(l__CurrentCamera__5.FieldOfView) / 2;
    local v37 = math.tan(v36) * 2;
    local v38 = (math.tan(v35) - math.tan(v32)) / v37;
    local v39 = p20:VectorToObjectSpace(p20.p - v22.p);
    local v40 = v39 * Vector3.new(1, 0, 1);
    local v41 = v39 * Vector3.new(0, 1, 1);
    local v42 = v40.Unit:Dot(Vector3.new(0, 0, -1));
    local v43 = (p20:VectorToObjectSpace(v22.LookVector) * Vector3.new(1, 0, 1)).Unit:Dot(v40.Unit) / (Vector3.new(0, 0, -1)):Dot(v40.Unit);
    local v44 = math.sqrt(1 - v42 * v42) / v42;
    local v45 = p21.x / p21.y;
    local v46 = math.sign(v39.x * v39.z) * v44;
    local v47 = v41.y / v41.z * v45;
    local v48 = math.abs(v43 * v38 * v45);
    local v49 = { ((p20 - p20.p) * u1 * CFrame.new(0, 0, 0, 1, 0, 0, 0, v45, 0, v46, v47, v48)):GetComponents() };
    local v50 = {};
    for v51 = 1, #v49 do
        v50[v51] = math.abs(v49[v51]);
    end;
    local v52 = math.max(unpack(v50));
    local v53 = CFrame.new(v49[1], v49[2], v49[3], v49[4] / v52, v49[5] / v52, v49[6] / v52, v49[7] / v52, v49[8] / v52, v49[9] / v52, v49[10] / v52, v49[11] / v52, v49[12] / v52);
    p18.Camera.FieldOfView = l__CurrentCamera__5.FieldOfView;
    p18.Camera.CFrame = v53 + v22.p;
    debug.profileend();
end;
return u3;
