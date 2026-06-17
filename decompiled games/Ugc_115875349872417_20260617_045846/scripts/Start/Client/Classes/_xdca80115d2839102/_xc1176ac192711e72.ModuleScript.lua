-- Decompiled from: Start.Client.Classes._xdca80115d2839102._xc1176ac192711e72
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__abs__1 = math.abs;
local l__clamp__2 = math.clamp;
local l__exp__3 = math.exp;
local l__rad__4 = math.rad;
local l__sign__5 = math.sign;
local l__sqrt__6 = math.sqrt;
local l__tan__7 = math.tan;
local l__ContextActionService__8 = game:GetService("ContextActionService");
local l__Players__9 = game:GetService("Players");
local l__RunService__10 = game:GetService("RunService");
game:GetService("StarterGui");
local l__UserInputService__11 = game:GetService("UserInputService");
local l__Workspace__12 = game:GetService("Workspace");
local l__LocalPlayer__13 = l__Players__9.LocalPlayer;
if not l__LocalPlayer__13 then
    l__Players__9:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__13 = l__Players__9.LocalPlayer;
end;
local l__CurrentCamera__14 = l__Workspace__12.CurrentCamera;
l__Workspace__12:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 35 ]]
    -- upvalues: l__Workspace__12 (copy), l__CurrentCamera__14 (ref)
    local l__CurrentCamera__15 = l__Workspace__12.CurrentCamera;
    if l__CurrentCamera__15 then
        l__CurrentCamera__14 = l__CurrentCamera__15;
    end;
end);
local _ = Enum.ContextActionPriority.Low.Value;
local l__Value__16 = Enum.ContextActionPriority.High.Value;
local _ = { Enum.KeyCode.LeftShift, Enum.KeyCode.P };
local u2 = Vector2.new(0.75, 1) * 8;
local u3 = {};
u3.__index = u3;
function u3._x83ed94bfb82a8c9f(p4, p5) --[[ Line: 59 ]]
    -- upvalues: u3 (copy)
    local v6 = setmetatable({}, u3);
    v6._x2dfc6b3fbef12c09 = p4;
    v6._xe46642854b136b24 = p5;
    v6._x3cf669bac9c6c03d = p5 * 0;
    return v6;
end;
function u3._xac3c890ef626f193(p7, p8, p9) --[[ Line: 67 ]]
    -- upvalues: l__exp__3 (copy)
    local v10 = p7._x2dfc6b3fbef12c09 * 2 * 3.141592653589793;
    local l___xe46642854b136b24__17 = p7._xe46642854b136b24;
    local l___x3cf669bac9c6c03d__18 = p7._x3cf669bac9c6c03d;
    local v11 = p9 - l___xe46642854b136b24__17;
    local v12 = l__exp__3(-v10 * p8);
    local v13 = p9 + (l___x3cf669bac9c6c03d__18 * p8 - v11 * (v10 * p8 + 1)) * v12;
    local v14 = (v10 * p8 * (v11 * v10 - l___x3cf669bac9c6c03d__18) + l___x3cf669bac9c6c03d__18) * v12;
    p7._xe46642854b136b24 = v13;
    p7._x3cf669bac9c6c03d = v14;
    return v13;
end;
function u3._x1dc1b25c543b6a37(p15, p16) --[[ Line: 84 ]]
    p15._xe46642854b136b24 = p16;
    p15._x3cf669bac9c6c03d = p16 * 0;
end;
local u17 = Vector3.new();
local u18 = Vector2.new();
local u19 = 0;
local u20 = u3._x83ed94bfb82a8c9f(10, (Vector3.new()))._x83ed94bfb82a8c9f(10, Vector2.new())._x83ed94bfb82a8c9f(10, 0);
local u21 = {};
local function u23(p22) --[[ Line: 111 ]]
    -- upvalues: l__sign__5 (copy), l__abs__1 (copy), l__exp__3 (copy), l__clamp__2 (copy)
    return l__sign__5(p22) * l__clamp__2((l__exp__3(2 * ((l__abs__1(p22) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1);
end;
local u24 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
};
local u25 = {
    W = 0,
    A = 0,
    S = 0,
    D = 0,
    E = 0,
    Q = 0,
    U = 0,
    H = 0,
    J = 0,
    K = 0,
    I = 0,
    Y = 0,
    Up = 0,
    Down = 0,
    LeftShift = 0,
    RightShift = 0
};
local u26 = {
    MouseWheel = 0,
    Delta = Vector2.new()
};
local u27 = Vector2.new(1, 1) * 0.04908738521234052;
local u28 = Vector2.new(1, 1) * 0.39269908169872414;
local u29 = 1;
function u21._x6a8223b540b613d9(p30) --[[ Line: 162 ]]
    -- upvalues: u29 (ref), u25 (copy), l__clamp__2 (copy), u23 (ref), u24 (copy), l__UserInputService__11 (copy)
    u29 = l__clamp__2(u29 + p30 * (u25.Up - u25.Down) * 0.75, 0.01, 4);
    local v31 = u23(u24.Thumbstick1.X);
    local v32 = u23(u24.ButtonR2) - u23(u24.ButtonL2);
    local v33 = Vector3.new(v31, v32, u23(-u24.Thumbstick1.Y)) * Vector3.new(1, 1, 1);
    local v34 = Vector3.new(u25.D - u25.A + u25.K - u25.H, u25.E - u25.Q + u25.I - u25.Y, u25.S - u25.W + u25.J - u25.U) * Vector3.new(1, 1, 1);
    local v35 = l__UserInputService__11:IsKeyDown(Enum.KeyCode.LeftShift) or l__UserInputService__11:IsKeyDown(Enum.KeyCode.RightShift);
    return (v33 + v34) * (u29 * (v35 and 0.25 or 1));
end;
function u21._x748b9822795fa56d(_) --[[ Line: 182 ]]
    -- upvalues: u23 (ref), u24 (copy), u28 (copy), u26 (copy), u27 (copy)
    local v36 = Vector2.new(u23(u24.Thumbstick2.Y), u23(-u24.Thumbstick2.X)) * u28;
    local v37 = u26.Delta * u27;
    u26.Delta = Vector2.new();
    return v36 + v37;
end;
function u21._x272cca2f7e73cee3(_) --[[ Line: 192 ]]
    -- upvalues: u24 (copy), u26 (copy)
    local v38 = (u24.ButtonX - u24.ButtonY) * 0.25;
    local v39 = u26.MouseWheel * 1;
    u26.MouseWheel = 0;
    return v38 + v39;
end;
local function u42(_, p40, p41) --[[ Line: 200 ]]
    -- upvalues: u25 (copy)
    u25[p41.KeyCode.Name] = p40 == Enum.UserInputState.Begin and 1 or 0;
    return Enum.ContextActionResult.Sink;
end;
local function u45(_, p43, p44) --[[ Line: 205 ]]
    -- upvalues: u24 (copy)
    u24[p44.KeyCode.Name] = p43 == Enum.UserInputState.Begin and 1 or 0;
    return Enum.ContextActionResult.Sink;
end;
local function u47(_, _, p46) --[[ Line: 210 ]]
    -- upvalues: u26 (copy)
    local l__Delta__19 = p46.Delta;
    u26.Delta = Vector2.new(-l__Delta__19.y, -l__Delta__19.x);
    return Enum.ContextActionResult.Sink;
end;
local function u49(_, _, p48) --[[ Line: 216 ]]
    -- upvalues: u24 (copy)
    u24[p48.KeyCode.Name] = p48.Position;
    return Enum.ContextActionResult.Sink;
end;
local function u51(_, _, p50) --[[ Line: 221 ]]
    -- upvalues: u24 (copy)
    u24[p50.KeyCode.Name] = p50.Position.z;
    return Enum.ContextActionResult.Sink;
end;
local function u53(_, _, p52) --[[ Line: 226 ]]
    -- upvalues: u26 (copy)
    u26[p52.UserInputType.Name] = -p52.Position.z;
    return Enum.ContextActionResult.Sink;
end;
function u21._x663f470b3e0e3b74() --[[ Line: 237 ]]
    -- upvalues: l__ContextActionService__8 (copy), u42 (copy), l__Value__16 (copy), u47 (copy), u53 (copy), u45 (copy), u51 (copy), u49 (copy)
    l__ContextActionService__8:BindActionAtPriority("FreecamKeyboard", u42, false, l__Value__16, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down);
    l__ContextActionService__8:BindActionAtPriority("FreecamMousePan", u47, false, l__Value__16, Enum.UserInputType.MouseMovement);
    l__ContextActionService__8:BindActionAtPriority("FreecamMouseWheel", u53, false, l__Value__16, Enum.UserInputType.MouseWheel);
    l__ContextActionService__8:BindActionAtPriority("FreecamGamepadButton", u45, false, l__Value__16, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    l__ContextActionService__8:BindActionAtPriority("FreecamGamepadTrigger", u51, false, l__Value__16, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    l__ContextActionService__8:BindActionAtPriority("FreecamGamepadThumbstick", u49, false, l__Value__16, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
end;
function u21._x808944397f27d216() --[[ Line: 254 ]]
    -- upvalues: u29 (ref), u24 (copy), u25 (copy), u26 (copy), l__ContextActionService__8 (copy)
    u29 = 1;
    local v54 = u24;
    for v55, v56 in pairs(v54) do
        v54[v55] = v56 * 0;
    end;
    local v57 = u25;
    for v58, v59 in pairs(v57) do
        v57[v58] = v59 * 0;
    end;
    local v60 = u26;
    for v61, v62 in pairs(v60) do
        v60[v61] = v62 * 0;
    end;
    l__ContextActionService__8:UnbindAction("FreecamKeyboard");
    l__ContextActionService__8:UnbindAction("FreecamMousePan");
    l__ContextActionService__8:UnbindAction("FreecamMouseWheel");
    l__ContextActionService__8:UnbindAction("FreecamGamepadButton");
    l__ContextActionService__8:UnbindAction("FreecamGamepadTrigger");
    l__ContextActionService__8:UnbindAction("FreecamGamepadThumbstick");
end;
local function u73(p63) --[[ Line: 269 ]]
    -- upvalues: l__CurrentCamera__14 (ref), u19 (ref), l__tan__7 (copy), l__Workspace__12 (copy)
    local l__ViewportSize__20 = l__CurrentCamera__14.ViewportSize;
    local v64 = l__tan__7(u19 / 2) * 2;
    local v65 = l__ViewportSize__20.x / l__ViewportSize__20.y * v64;
    local l__rightVector__21 = p63.rightVector;
    local l__upVector__22 = p63.upVector;
    local l__lookVector__23 = p63.lookVector;
    local v66 = Vector3.new();
    local v67 = 512;
    for v68 = 0, 1, 0.5 do
        for v69 = 0, 1, 0.5 do
            local v70 = l__rightVector__21 * ((v68 - 0.5) * v65) - l__upVector__22 * ((v69 - 0.5) * v64) + l__lookVector__23;
            local v71 = p63.p + v70 * 0.1;
            local _, v72 = l__Workspace__12:FindPartOnRay(Ray.new(v71, v70.unit * v67));
            local l__magnitude__24 = (v72 - v71).magnitude;
            if l__magnitude__24 < v67 then
                v66 = v70.unit;
                v67 = l__magnitude__24;
            end;
        end;
    end;
    return l__lookVector__23:Dot(v66) * v67;
end;
local function u81(p74) --[[ Line: 299 ]]
    -- upvalues: u20 (copy), u21 (copy), u19 (ref), l__rad__4 (copy), l__tan__7 (copy), l__sqrt__6 (copy), l__clamp__2 (copy), u18 (ref), u2 (copy), u17 (ref), l__CurrentCamera__14 (ref), u73 (copy), l__LocalPlayer__13 (ref)
    local v75 = u20:_xac3c890ef626f193(p74, u21._x6a8223b540b613d9(p74));
    local v76 = u20:_xac3c890ef626f193(p74, u21._x748b9822795fa56d(p74));
    local v77 = u20:_xac3c890ef626f193(p74, u21._x272cca2f7e73cee3(p74));
    local v78 = l__sqrt__6(0.7002075382097097 / l__tan__7((l__rad__4(u19 / 2))));
    u19 = l__clamp__2(u19 + v77 * 300 * (p74 / v78), 1, 120);
    u18 = u18 + v76 * u2 * (p74 / v78);
    u18 = Vector2.new(l__clamp__2(u18.x, -1.5707963267948966, 1.5707963267948966), u18.y % 6.283185307179586);
    local v79 = CFrame.new(u17) * CFrame.fromOrientation(u18.x, u18.y, 0) * CFrame.new(v75 * Vector3.new(64, 64, 64) * p74);
    u17 = v79.p;
    l__CurrentCamera__14.CFrame = v79;
    l__CurrentCamera__14.Focus = v79 * CFrame.new(0, 0, -u73(v79));
    l__CurrentCamera__14.FieldOfView = u19;
    local l__Character__25 = l__LocalPlayer__13.Character;
    if l__Character__25 then
        for _, v80 in ipairs(l__Character__25:GetDescendants()) do
            if v80:IsA("BasePart") then
                v80.LocalTransparencyModifier = 0;
            end;
        end;
    end;
end;
local u82 = {};
local u83 = nil;
local u84 = nil;
local u85 = nil;
local u86 = nil;
local u87 = nil;
local u88 = nil;
local u89 = {};
local u90 = {
    Backpack = true,
    Chat = true,
    Health = true,
    PlayerList = true
};
local u91 = {
    BadgesNotificationsActive = true,
    PointsNotificationsActive = true
};
function u82._xdefe364cfa7ff6b4() --[[ Line: 348 ]]
    -- upvalues: u88 (ref), l__CurrentCamera__14 (ref), u85 (ref), u87 (ref), u86 (ref), u84 (ref), l__UserInputService__11 (copy), u83 (ref)
    u88 = l__CurrentCamera__14.FieldOfView;
    l__CurrentCamera__14.FieldOfView = 70;
    u85 = l__CurrentCamera__14.CameraType;
    l__CurrentCamera__14.CameraType = Enum.CameraType.Custom;
    u87 = l__CurrentCamera__14.CFrame;
    u86 = l__CurrentCamera__14.Focus;
    u84 = l__UserInputService__11.MouseIconEnabled;
    l__UserInputService__11.MouseIconEnabled = true;
    u83 = l__UserInputService__11.MouseBehavior;
    l__UserInputService__11.MouseBehavior = Enum.MouseBehavior.Default;
end;
function u82._xdf411d68f6abce6a() --[[ Line: 385 ]]
    -- upvalues: u90 (copy), u91 (copy), u89 (copy), l__CurrentCamera__14 (ref), u88 (ref), u85 (ref), u87 (ref), u86 (ref), l__UserInputService__11 (copy), u84 (ref), u83 (ref)
    for _, _ in pairs(u90) do

    end;
    for _, _ in pairs(u91) do

    end;
    for _, v92 in pairs(u89) do
        if v92.Parent then
            v92.Enabled = true;
        end;
    end;
    l__CurrentCamera__14.FieldOfView = u88;
    u88 = nil;
    l__CurrentCamera__14.CameraType = u85;
    u85 = nil;
    l__CurrentCamera__14.CFrame = u87;
    u87 = nil;
    l__CurrentCamera__14.Focus = u86;
    u86 = nil;
    l__UserInputService__11.MouseIconEnabled = u84;
    u84 = nil;
    l__UserInputService__11.MouseBehavior = u83;
    u83 = nil;
end;
local function u93() --[[ Line: 416 ]]
    -- upvalues: l__CurrentCamera__14 (ref), u18 (ref), u17 (ref), u19 (ref), u20 (copy), u82 (copy), l__RunService__10 (copy), u81 (copy), u21 (copy)
    local l__CFrame__26 = l__CurrentCamera__14.CFrame;
    u18 = Vector2.new(l__CFrame__26:toEulerAnglesYXZ());
    u17 = l__CFrame__26.p;
    u19 = l__CurrentCamera__14.FieldOfView;
    u20:_x1dc1b25c543b6a37((Vector3.new()));
    u20:_x1dc1b25c543b6a37(Vector2.new());
    u20:_x1dc1b25c543b6a37(0);
    u82._xdefe364cfa7ff6b4();
    l__RunService__10:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, u81);
    u21._x663f470b3e0e3b74();
end;
local function u95() --[[ Line: 431 ]]
    -- upvalues: u21 (copy), l__RunService__10 (copy), u82 (copy), l__LocalPlayer__13 (ref)
    u21._x808944397f27d216();
    l__RunService__10:UnbindFromRenderStep("Freecam");
    u82._xdf411d68f6abce6a();
    local l__Character__27 = l__LocalPlayer__13.Character;
    if l__Character__27 then
        for _, v94 in ipairs(l__Character__27:GetDescendants()) do
            if v94:IsA("BasePart") then
                v94.LocalTransparencyModifier = 1;
            end;
        end;
    end;
end;
function v1._xb21d31a7208a6ebb(_) --[[ Line: 447 ]]
    -- upvalues: u93 (copy)
    u93();
end;
function v1._xa00c0e9c56965c55(_) --[[ Line: 451 ]]
    -- upvalues: u95 (copy)
    u95();
end;
return v1;
