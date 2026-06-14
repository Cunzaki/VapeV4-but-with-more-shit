-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Mirror.Portal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Instance.new("ViewportFrame");
u1.Size = UDim2.new(1, 0, 1, 0);
u1.Position = UDim2.new(0.5, 0, 0.5, 0);
u1.AnchorPoint = Vector2.new(0.5, 0.5);
u1.BackgroundTransparency = 1;
u1.BackgroundColor3 = Color3.new(0, 0, 0);
Instance.new("WorldModel").Parent = u1;
local u2 = {};
u2.__index = u2;
function u2.new(p3) --[[ Line: 23 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v4 = setmetatable({}, u2);
    v4.SurfaceGUI = p3;
    v4.Camera = Instance.new("Camera", p3);
    v4.ViewportFrame = u1:Clone();
    v4.ViewportFrame.Ambient = game.Lighting.Ambient;
    v4.ViewportFrame.CurrentCamera = v4.Camera;
    v4.ViewportFrame.Parent = p3;
    return v4;
end;
function u2.UpdateLighting(p5) --[[ Line: 36 ]]
    p5.ViewportFrame.Ambient = game.Lighting.Ambient;
end;
function u2.GetSurfaceInfo(p6) --[[ Line: 42 ]]
    local l__Adornee__1 = p6.SurfaceGUI.Adornee;
    local l__CFrame__2 = l__Adornee__1.CFrame;
    local l__Size__3 = l__Adornee__1.Size;
    local v7 = -Vector3.FromNormalId(p6.SurfaceGUI.Face);
    local v8 = math.abs(v7.y) == 1 and (Vector3.new(v7.y, 0, 0) or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);
    local v9 = CFrame.fromAxisAngle(v8, 1.5707963267948966) * v7;
    local l__Unit__4 = v7:Cross(v9).Unit;
    return l__CFrame__2 * CFrame.fromMatrix(-v7 * l__Size__3 / 2, v9, l__Unit__4, v7), Vector2.new((l__Size__3 * v9).Magnitude, (l__Size__3 * l__Unit__4).Magnitude);
end;
function u2.RenderFrame(p10, p11, p12, p13) --[[ Line: 57 ]]
    local l__ViewportFrame__5 = p10.ViewportFrame;
    local l__SurfaceGUI__6 = p10.SurfaceGUI;
    local l__CurrentCamera__7 = game.Workspace.CurrentCamera;
    local l__Camera__8 = p10.Camera;
    local v14 = p11 or l__CurrentCamera__7.CFrame;
    if not (p12 and p13) then
        p12, p13 = p10:GetSurfaceInfo();
    end;
    local v15 = p12:PointToObjectSpace(v14.p);
    local v16 = v15.x / p13.x;
    local v17 = v15.y / p13.y;
    local v18 = p13.y / p13.x;
    local v19 = p13.x / p13.y;
    local v20 = math.abs(v16);
    local v21 = math.abs(v17);
    local v22 = math.max(v20, v21) * 2;
    local v23 = math.max(v18, v19, v22) + 1;
    local v24 = p13.y / 2;
    local v25 = (v14.p - p12.p):Dot(p12.LookVector);
    local v26 = math.atan2(v24, v25) * 2;
    local v27 = math.deg(v26);
    local v28 = math.clamp(v27, 1, 120);
    local v29 = math.rad(v28) / 2;
    local v30 = v25 / (v24 / math.tan(v29));
    local v31 = (v26 > 2.0943951023931953 and v30 and v30 or 1) / v23;
    local v32 = CFrame.new(0, 0, 0, v31, 0, 0, 0, v31, 0, 0, 0, 1);
    l__ViewportFrame__5.Position = UDim2.new(l__ViewportFrame__5.AnchorPoint.x - v16, 0, l__ViewportFrame__5.AnchorPoint.y - v17, 0);
    l__ViewportFrame__5.Size = UDim2.new(v23, 0, v23, 0);
    l__ViewportFrame__5.BackgroundColor3 = l__SurfaceGUI__6.Adornee.Color;
    local l__y__9 = l__CurrentCamera__7.ViewportSize.y;
    l__SurfaceGUI__6.CanvasSize = Vector2.new(l__y__9 * (p13.x / p13.y), l__y__9);
    l__Camera__8.FieldOfView = v28;
    l__Camera__8.CFrame = CFrame.new(v14.p) * (p12 - p12.p) * CFrame.Angles(0, 3.141592653589793, 0) * v32;
end;
return u2;
