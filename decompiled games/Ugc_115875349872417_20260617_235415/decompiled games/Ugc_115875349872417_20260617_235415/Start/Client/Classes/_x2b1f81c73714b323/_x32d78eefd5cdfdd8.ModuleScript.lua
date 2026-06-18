-- Decompiled from: Start.Client.Classes._x2b1f81c73714b323._x32d78eefd5cdfdd8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

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
local v1 = tostring(game.GameId);
local v2 = 46;
local v3 = {};
for v4 = 1, #v1 do
    v2 = (v2 * 33 + string.byte(v1, v4)) % 65521;
end;
if v2 == 272 and not l__LocalPlayer__13 then
    l__Players__9:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__13 = l__Players__9.LocalPlayer;
end;
local l__CurrentCamera__14 = l__Workspace__12.CurrentCamera;
l__Workspace__12:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 35 ]]
    -- upvalues: l__Workspace__12 (copy), l__CurrentCamera__14 (ref)
    local l__CurrentCamera__15 = l__Workspace__12.CurrentCamera;
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and l__CurrentCamera__15 then
        l__CurrentCamera__14 = l__CurrentCamera__15;
    end;
end);
local _ = Enum.ContextActionPriority.Low.Value;
local l__Value__16 = Enum.ContextActionPriority.High.Value;
local _ = { Enum.KeyCode.LeftShift, Enum.KeyCode.P };
local u8 = Vector2.new(0.75, 1) * 8;
local u9 = {};
u9.__index = u9;
function u9._xafd29f1684593d0b(p10, p11) --[[ Line: 59 ]]
    -- upvalues: u9 (copy)
    local v12 = setmetatable({}, u9);
    v12._xd465f2d3b3cea9ed = p10;
    v12._xdec2202ec9e8cada = p11;
    v12._xd04896d5872673e3 = p11 * 0;
    return v12;
end;
function u9._x5b5e3c5467981d3b(p13, p14, p15) --[[ Line: 67 ]]
    -- upvalues: l__exp__3 (copy)
    local v16 = p13._xd465f2d3b3cea9ed * 2 * 3.141592653589793;
    local l___xdec2202ec9e8cada__17 = p13._xdec2202ec9e8cada;
    local l___xd04896d5872673e3__18 = p13._xd04896d5872673e3;
    local v17 = p15 - l___xdec2202ec9e8cada__17;
    local v18 = l__exp__3(-v16 * p14);
    local v19 = p15 + (l___xd04896d5872673e3__18 * p14 - v17 * (v16 * p14 + 1)) * v18;
    local v20 = (v16 * p14 * (v17 * v16 - l___xd04896d5872673e3__18) + l___xd04896d5872673e3__18) * v18;
    p13._xdec2202ec9e8cada = v19;
    p13._xd04896d5872673e3 = v20;
    return v19;
end;
function u9._x859de686e93af70a(p21, p22) --[[ Line: 84 ]]
    p21._xdec2202ec9e8cada = p22;
    p21._xd04896d5872673e3 = p22 * 0;
end;
local u23 = Vector3.new();
local u24 = Vector2.new();
local u25 = 0;
local u26 = u9._xafd29f1684593d0b(10, (Vector3.new()))._xafd29f1684593d0b(10, Vector2.new())._xafd29f1684593d0b(10, 0);
local u27 = {};
local function u29(p28) --[[ Line: 111 ]]
    -- upvalues: l__sign__5 (copy), l__abs__1 (copy), l__exp__3 (copy), l__clamp__2 (copy)
    return l__sign__5(p28) * l__clamp__2((l__exp__3(2 * ((l__abs__1(p28) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1);
end;
local u30 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
};
local u31 = {
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
local u32 = {
    MouseWheel = 0,
    Delta = Vector2.new()
};
local u33 = Vector2.new(1, 1) * 0.04908738521234052;
local u34 = Vector2.new(1, 1) * 0.39269908169872414;
local u35 = 1;
function u27._x66f830e162a9c68a(p36) --[[ Line: 162 ]]
    -- upvalues: u35 (ref), u31 (copy), l__clamp__2 (copy), u29 (ref), u30 (copy), l__UserInputService__11 (copy)
    u35 = l__clamp__2(u35 + p36 * (u31.Up - u31.Down) * 0.75, 0.01, 4);
    local v37 = u29(u30.Thumbstick1.X);
    local v38 = u29(u30.ButtonR2) - u29(u30.ButtonL2);
    local v39 = Vector3.new(v37, v38, u29(-u30.Thumbstick1.Y)) * Vector3.new(1, 1, 1);
    local v40 = Vector3.new(u31.D - u31.A + u31.K - u31.H, u31.E - u31.Q + u31.I - u31.Y, u31.S - u31.W + u31.J - u31.U) * Vector3.new(1, 1, 1);
    local v41 = l__UserInputService__11:IsKeyDown(Enum.KeyCode.LeftShift) or l__UserInputService__11:IsKeyDown(Enum.KeyCode.RightShift);
    return (v39 + v40) * (u35 * (v41 and 0.25 or 1));
end;
function u27._x8e9447c6163da153(_) --[[ Line: 182 ]]
    -- upvalues: u29 (ref), u30 (copy), u34 (copy), u32 (copy), u33 (copy)
    local v42 = Vector2.new(u29(u30.Thumbstick2.Y), u29(-u30.Thumbstick2.X)) * u34;
    local v43 = u32.Delta * u33;
    u32.Delta = Vector2.new();
    return v42 + v43;
end;
function u27._x9e0ff045ecc782bf(_) --[[ Line: 192 ]]
    -- upvalues: u30 (copy), u32 (copy)
    local v44 = (u30.ButtonX - u30.ButtonY) * 0.25;
    local v45 = u32.MouseWheel * 1;
    u32.MouseWheel = 0;
    return v44 + v45;
end;
local function u48(_, p46, p47) --[[ Line: 200 ]]
    -- upvalues: u31 (copy)
    u31[p47.KeyCode.Name] = p46 == Enum.UserInputState.Begin and 1 or 0;
    return Enum.ContextActionResult.Sink;
end;
local function u51(_, p49, p50) --[[ Line: 205 ]]
    -- upvalues: u30 (copy)
    u30[p50.KeyCode.Name] = p49 == Enum.UserInputState.Begin and 1 or 0;
    return Enum.ContextActionResult.Sink;
end;
local function u53(_, _, p52) --[[ Line: 210 ]]
    -- upvalues: u32 (copy)
    local l__Delta__19 = p52.Delta;
    u32.Delta = Vector2.new(-l__Delta__19.y, -l__Delta__19.x);
    return Enum.ContextActionResult.Sink;
end;
local function u55(_, _, p54) --[[ Line: 216 ]]
    -- upvalues: u30 (copy)
    u30[p54.KeyCode.Name] = p54.Position;
    return Enum.ContextActionResult.Sink;
end;
local function u57(_, _, p56) --[[ Line: 221 ]]
    -- upvalues: u30 (copy)
    u30[p56.KeyCode.Name] = p56.Position.z;
    return Enum.ContextActionResult.Sink;
end;
local function u59(_, _, p58) --[[ Line: 226 ]]
    -- upvalues: u32 (copy)
    u32[p58.UserInputType.Name] = -p58.Position.z;
    return Enum.ContextActionResult.Sink;
end;
function u27._x975a64d0fcb20332() --[[ Line: 237 ]]
    -- upvalues: l__ContextActionService__8 (copy), u48 (copy), l__Value__16 (copy), u53 (copy), u59 (copy), u51 (copy), u57 (copy), u55 (copy)
    l__ContextActionService__8:BindActionAtPriority("FreecamKeyboard", u48, false, l__Value__16, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down);
    l__ContextActionService__8:BindActionAtPriority("FreecamMousePan", u53, false, l__Value__16, Enum.UserInputType.MouseMovement);
    l__ContextActionService__8:BindActionAtPriority("FreecamMouseWheel", u59, false, l__Value__16, Enum.UserInputType.MouseWheel);
    l__ContextActionService__8:BindActionAtPriority("FreecamGamepadButton", u51, false, l__Value__16, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    l__ContextActionService__8:BindActionAtPriority("FreecamGamepadTrigger", u57, false, l__Value__16, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    l__ContextActionService__8:BindActionAtPriority("FreecamGamepadThumbstick", u55, false, l__Value__16, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
end;
function u27._xfa3c021deab76ac8() --[[ Line: 254 ]]
    -- upvalues: u35 (ref), u30 (copy), u31 (copy), u32 (copy), l__ContextActionService__8 (copy)
    u35 = 1;
    local v60 = u30;
    for v61, v62 in pairs(v60) do
        v60[v61] = v62 * 0;
    end;
    local v63 = u31;
    for v64, v65 in pairs(v63) do
        v63[v64] = v65 * 0;
    end;
    local v66 = u32;
    for v67, v68 in pairs(v66) do
        v66[v67] = v68 * 0;
    end;
    l__ContextActionService__8:UnbindAction("FreecamKeyboard");
    l__ContextActionService__8:UnbindAction("FreecamMousePan");
    l__ContextActionService__8:UnbindAction("FreecamMouseWheel");
    l__ContextActionService__8:UnbindAction("FreecamGamepadButton");
    l__ContextActionService__8:UnbindAction("FreecamGamepadTrigger");
    l__ContextActionService__8:UnbindAction("FreecamGamepadThumbstick");
end;
local function u82(p69) --[[ Line: 269 ]]
    -- upvalues: l__CurrentCamera__14 (ref), u25 (ref), l__tan__7 (copy), l__Workspace__12 (copy)
    local l__ViewportSize__20 = l__CurrentCamera__14.ViewportSize;
    local v70 = l__tan__7(u25 / 2) * 2;
    local v71 = l__ViewportSize__20.x / l__ViewportSize__20.y * v70;
    local l__rightVector__21 = p69.rightVector;
    local l__upVector__22 = p69.upVector;
    local l__lookVector__23 = p69.lookVector;
    local v72 = Vector3.new();
    local v73 = 512;
    for v74 = 0, 1, 0.5 do
        for v75 = 0, 1, 0.5 do
            local v76 = l__rightVector__21 * ((v74 - 0.5) * v71) - l__upVector__22 * ((v75 - 0.5) * v70) + l__lookVector__23;
            local v77 = p69.p + v76 * 0.1;
            local _, v78 = l__Workspace__12:FindPartOnRay(Ray.new(v77, v76.unit * v73));
            local l__magnitude__24 = (v78 - v77).magnitude;
            local v79 = tostring(game.GameId);
            local v80 = 46;
            for v81 = 1, #v79 do
                v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
            end;
            if v80 == 272 and l__magnitude__24 < v73 then
                v72 = v76.unit;
                v73 = l__magnitude__24;
            end;
        end;
    end;
    return l__lookVector__23:Dot(v72) * v73;
end;
local function u96(p83) --[[ Line: 299 ]]
    -- upvalues: u26 (copy), u27 (copy), u25 (ref), l__rad__4 (copy), l__tan__7 (copy), l__sqrt__6 (copy), l__clamp__2 (copy), u24 (ref), u8 (copy), u23 (ref), l__CurrentCamera__14 (ref), u82 (copy), l__LocalPlayer__13 (ref)
    local v84 = u26:_x5b5e3c5467981d3b(p83, u27._x66f830e162a9c68a(p83));
    local v85 = u26:_x5b5e3c5467981d3b(p83, u27._x8e9447c6163da153(p83));
    local v86 = u26:_x5b5e3c5467981d3b(p83, u27._x9e0ff045ecc782bf(p83));
    local v87 = l__sqrt__6(0.7002075382097097 / l__tan__7((l__rad__4(u25 / 2))));
    u25 = l__clamp__2(u25 + v86 * 300 * (p83 / v87), 1, 120);
    u24 = u24 + v85 * u8 * (p83 / v87);
    u24 = Vector2.new(l__clamp__2(u24.x, -1.5707963267948966, 1.5707963267948966), u24.y % 6.283185307179586);
    local v88 = CFrame.new(u23) * CFrame.fromOrientation(u24.x, u24.y, 0) * CFrame.new(v84 * Vector3.new(64, 64, 64) * p83);
    u23 = v88.p;
    l__CurrentCamera__14.CFrame = v88;
    l__CurrentCamera__14.Focus = v88 * CFrame.new(0, 0, -u82(v88));
    l__CurrentCamera__14.FieldOfView = u25;
    local l__Character__25 = l__LocalPlayer__13.Character;
    local v89 = tostring(game.GameId);
    local v90 = 46;
    for v91 = 1, #v89 do
        v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
    end;
    if v90 == 272 and l__Character__25 then
        for _, v92 in ipairs(l__Character__25:GetDescendants()) do
            local v93 = tostring(game.GameId);
            local v94 = 46;
            for v95 = 1, #v93 do
                v94 = (v94 * 33 + string.byte(v93, v95)) % 65521;
            end;
            if v94 == 272 and v92:IsA("BasePart") then
                v92.LocalTransparencyModifier = 0;
            end;
        end;
    end;
end;
local u97 = {};
local u98 = nil;
local u99 = nil;
local u100 = nil;
local u101 = nil;
local u102 = nil;
local u103 = nil;
local u104 = {};
local u105 = {
    Backpack = true,
    Chat = true,
    Health = true,
    PlayerList = true
};
local u106 = {
    BadgesNotificationsActive = true,
    PointsNotificationsActive = true
};
function u97._x558f1e30438e6a42() --[[ Line: 348 ]]
    -- upvalues: u103 (ref), l__CurrentCamera__14 (ref), u100 (ref), u102 (ref), u101 (ref), u99 (ref), l__UserInputService__11 (copy), u98 (ref)
    u103 = l__CurrentCamera__14.FieldOfView;
    l__CurrentCamera__14.FieldOfView = 70;
    u100 = l__CurrentCamera__14.CameraType;
    l__CurrentCamera__14.CameraType = Enum.CameraType.Custom;
    u102 = l__CurrentCamera__14.CFrame;
    u101 = l__CurrentCamera__14.Focus;
    u99 = l__UserInputService__11.MouseIconEnabled;
    l__UserInputService__11.MouseIconEnabled = true;
    u98 = l__UserInputService__11.MouseBehavior;
    l__UserInputService__11.MouseBehavior = Enum.MouseBehavior.Default;
end;
function u97._xa533b5b654f38043() --[[ Line: 385 ]]
    -- upvalues: u105 (copy), u106 (copy), u104 (copy), l__CurrentCamera__14 (ref), u103 (ref), u100 (ref), u102 (ref), u101 (ref), l__UserInputService__11 (copy), u99 (ref), u98 (ref)
    for _, _ in pairs(u105) do

    end;
    for _, _ in pairs(u106) do

    end;
    for _, v107 in pairs(u104) do
        local v108 = tostring(game.GameId);
        local v109 = 46;
        for v110 = 1, #v108 do
            v109 = (v109 * 33 + string.byte(v108, v110)) % 65521;
        end;
        if v109 == 272 and v107.Parent then
            v107.Enabled = true;
        end;
    end;
    l__CurrentCamera__14.FieldOfView = u103;
    u103 = nil;
    l__CurrentCamera__14.CameraType = u100;
    u100 = nil;
    l__CurrentCamera__14.CFrame = u102;
    u102 = nil;
    l__CurrentCamera__14.Focus = u101;
    u101 = nil;
    l__UserInputService__11.MouseIconEnabled = u99;
    u99 = nil;
    l__UserInputService__11.MouseBehavior = u98;
    u98 = nil;
end;
local function u111() --[[ Line: 416 ]]
    -- upvalues: l__CurrentCamera__14 (ref), u24 (ref), u23 (ref), u25 (ref), u26 (copy), u97 (copy), l__RunService__10 (copy), u96 (copy), u27 (copy)
    local l__CFrame__26 = l__CurrentCamera__14.CFrame;
    u24 = Vector2.new(l__CFrame__26:toEulerAnglesYXZ());
    u23 = l__CFrame__26.p;
    u25 = l__CurrentCamera__14.FieldOfView;
    u26:_x859de686e93af70a((Vector3.new()));
    u26:_x859de686e93af70a(Vector2.new());
    u26:_x859de686e93af70a(0);
    u97._x558f1e30438e6a42();
    l__RunService__10:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, u96);
    u27._x975a64d0fcb20332();
end;
local function u119() --[[ Line: 431 ]]
    -- upvalues: u27 (copy), l__RunService__10 (copy), u97 (copy), l__LocalPlayer__13 (ref)
    u27._xfa3c021deab76ac8();
    l__RunService__10:UnbindFromRenderStep("Freecam");
    u97._xa533b5b654f38043();
    local l__Character__27 = l__LocalPlayer__13.Character;
    local v112 = tostring(game.GameId);
    local v113 = 46;
    for v114 = 1, #v112 do
        v113 = (v113 * 33 + string.byte(v112, v114)) % 65521;
    end;
    if v113 == 272 and l__Character__27 then
        for _, v115 in ipairs(l__Character__27:GetDescendants()) do
            local v116 = tostring(game.GameId);
            local v117 = 46;
            for v118 = 1, #v116 do
                v117 = (v117 * 33 + string.byte(v116, v118)) % 65521;
            end;
            if v117 == 272 and v115:IsA("BasePart") then
                v115.LocalTransparencyModifier = 1;
            end;
        end;
    end;
end;
function v3._xcf2f0b4345ad245b(_) --[[ Line: 447 ]]
    -- upvalues: u111 (copy)
    u111();
end;
function v3._xe9a25472cecd1e5d(_) --[[ Line: 451 ]]
    -- upvalues: u119 (copy)
    u119();
end;
return v3;
