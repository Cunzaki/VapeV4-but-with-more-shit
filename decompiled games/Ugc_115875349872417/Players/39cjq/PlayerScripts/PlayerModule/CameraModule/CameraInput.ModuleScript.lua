-- Decompiled from: Players.39cjq.PlayerScripts.PlayerModule.CameraModule.CameraInput
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__Players__3 = game:GetService("Players");
local l__RunService__4 = game:GetService("RunService");
local l__UserGameSettings__5 = UserSettings():GetService("UserGameSettings");
local l__VRService__6 = game:GetService("VRService");
local l__GuiService__7 = game:GetService("GuiService");
local l__CommonUtils__8 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__9 = require(l__CommonUtils__8:WaitForChild("FlagUtil"));
local u1 = l__FlagUtil__9.getUserFlag("UserCameraInputDt");
local u2 = l__FlagUtil__9.getUserFlag("UserPSSinkUnknownTouchEvents");
local v3 = l__FlagUtil__9.getUserFlag("UserPSTextboxResetCameraInput");
local l__LocalPlayer__10 = l__Players__3.LocalPlayer;
local l__Value__11 = Enum.ContextActionPriority.Medium.Value;
local u4 = Vector2.new(1, 0.77) * 0.06981317007977318;
local u5 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u6 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u7 = Vector2.new(1, 0.66) * 0.017453292519943295;
if u1 then
    u4 = u4 * 60;
end;
local u8 = Instance.new("BindableEvent");
local u9 = Instance.new("BindableEvent");
local l__Event__12 = u8.Event;
local l__Event__13 = u9.Event;
l__UserInputService__2.InputBegan:Connect(function(p10, p11) --[[ Line: 49 ]]
    -- upvalues: u8 (copy)
    if not p11 and p10.UserInputType == Enum.UserInputType.MouseButton2 then
        u8:Fire();
    end;
end);
l__UserInputService__2.InputEnded:Connect(function(p12, _) --[[ Line: 55 ]]
    -- upvalues: u9 (copy)
    if p12.UserInputType == Enum.UserInputType.MouseButton2 then
        u9:Fire();
    end;
end);
local function u16(p13) --[[ Line: 66 ]]
    local v14 = (math.abs(p13) - 0.1) / 0.9 * 2;
    local v15 = (math.exp(v14) - 1) / 6.38905609893065;
    return math.sign(p13) * math.clamp(v15, 0, 1);
end;
local function u20(p17) --[[ Line: 80 ]]
    local l__CurrentCamera__14 = workspace.CurrentCamera;
    if not l__CurrentCamera__14 then
        return p17;
    end;
    local v18 = l__CurrentCamera__14.CFrame:ToEulerAnglesYXZ();
    if p17.Y * v18 >= 0 then
        return p17;
    end;
    local v19 = (1 - (math.abs(v18) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;
    return Vector2.new(1, v19) * p17;
end;
local function u26(p21) --[[ Line: 106 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local v22 = l__LocalPlayer__10:FindFirstChildOfClass("PlayerGui");
    if v22 then
        v22 = v22:FindFirstChild("TouchGui");
    end;
    local v23;
    if v22 then
        v23 = v22:FindFirstChild("TouchControlFrame");
    else
        v23 = v22;
    end;
    if v23 then
        v23 = v23:FindFirstChild("DynamicThumbstickFrame");
    end;
    if not v23 then
        return false;
    end;
    if not v22.Enabled then
        return false;
    end;
    local l__AbsolutePosition__15 = v23.AbsolutePosition;
    local v24 = l__AbsolutePosition__15 + v23.AbsoluteSize;
    local v25;
    if p21.X >= l__AbsolutePosition__15.X and (p21.Y >= l__AbsolutePosition__15.Y and p21.X <= v24.X) then
        v25 = p21.Y <= v24.Y;
    else
        v25 = false;
    end;
    return v25;
end;
local u27 = 0.016666666666666666;
l__RunService__4.Stepped:Connect(function(_, p28) --[[ Line: 131 ]]
    -- upvalues: u27 (ref)
    u27 = p28;
end);
local v29 = {};
local u30 = {};
local u31 = 0;
local u32 = {
    Thumbstick2 = Vector2.new()
};
local u33 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u34 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u35 = {
    Pinch = 0,
    Move = Vector2.new()
};
local u36 = Instance.new("BindableEvent");
v29.gamepadZoomPress = u36.Event;
local u37 = l__VRService__6.VREnabled and Instance.new("BindableEvent") or nil;
if l__VRService__6.VREnabled then
    v29.gamepadReset = u37.Event;
end;
function v29.getRotationActivated() --[[ Line: 182 ]]
    -- upvalues: u31 (ref), u32 (copy)
    return u31 > 0 and true or u32.Thumbstick2.Magnitude > 0;
end;
function v29.getRotation(p38, p39) --[[ Line: 186 ]]
    -- upvalues: l__UserGameSettings__5 (copy), u1 (copy), u33 (copy), u27 (ref), u32 (copy), u34 (copy), u20 (copy), u35 (copy), u4 (ref), u5 (copy), u6 (copy), u7 (copy)
    local v40 = Vector2.new(1, l__UserGameSettings__5:GetCameraYInvertValue());
    local v41;
    if u1 then
        v41 = Vector2.new(u33.Right - u33.Left, 0) * p38;
    else
        v41 = Vector2.new(u33.Right - u33.Left, 0) * u27;
    end;
    local v42 = u32.Thumbstick2 * l__UserGameSettings__5.GamepadCameraSensitivity;
    if u1 then
        v42 = v42 * p38;
    end;
    local l__Movement__16 = u34.Movement;
    local l__Pan__17 = u34.Pan;
    local v43 = u20(u35.Move);
    if p39 then
        v41 = Vector2.new();
    end;
    return (v41 * 2.0943951023931953 + v42 * u4 + l__Movement__16 * u5 + l__Pan__17 * u6 + v43 * u7) * v40;
end;
function v29.getZoomDelta() --[[ Line: 220 ]]
    -- upvalues: u33 (copy), u34 (copy), u35 (copy)
    return (u33.O - u33.I) * 0.1 + (-u34.Wheel + u34.Pinch) * 1 + -u35.Pinch * 0.04;
end;
local function u45(_, _, p44) --[[ Line: 228 ]]
    -- upvalues: u32 (copy), u16 (ref)
    local l__Position__18 = p44.Position;
    u32[p44.KeyCode.Name] = Vector2.new(u16(l__Position__18.X), -u16(l__Position__18.Y));
    return Enum.ContextActionResult.Pass;
end;
local function u48(_, p46, p47) --[[ Line: 244 ]]
    -- upvalues: u33 (copy)
    u33[p47.KeyCode.Name] = p46 == Enum.UserInputState.Begin and 1 or 0;
end;
local function u50(_, p49, _) --[[ Line: 248 ]]
    -- upvalues: u36 (copy)
    if p49 == Enum.UserInputState.Begin then
        u36:Fire();
    end;
end;
local function u52(_, p51, _) --[[ Line: 254 ]]
    -- upvalues: u37 (copy)
    if p51 == Enum.UserInputState.Begin then
        u37:Fire();
    end;
end;
local function u56() --[[ Line: 260 ]]
    -- upvalues: u32 (copy), u33 (copy), u34 (copy), u35 (copy), u31 (ref)
    for _, v53 in pairs({
        u32,
        u33,
        u34,
        u35
    }) do
        for v54, v55 in pairs(v53) do
            if type(v55) == "boolean" then
                v53[v54] = false;
            else
                v53[v54] = v53[v54] * 0;
            end;
        end;
    end;
    u31 = 0;
end;
local u57 = {};
local u58 = nil;
local u59 = nil;
local function u62(p60, p61) --[[ Line: 286 ]]
    -- upvalues: u58 (ref), u26 (copy), u31 (ref), u57 (ref)
    assert(p60.UserInputType == Enum.UserInputType.Touch);
    assert(p60.UserInputState == Enum.UserInputState.Begin);
    if u58 == nil and (u26(p60.Position) and not p61) then
        u58 = p60;
    else
        if not p61 then
            u31 = math.max(0, u31 + 1);
        end;
        u57[p60] = p61;
    end;
end;
local function u64(p63, _) --[[ Line: 306 ]]
    -- upvalues: u58 (ref), u57 (ref), u59 (ref), u31 (ref)
    assert(p63.UserInputType == Enum.UserInputType.Touch);
    assert(p63.UserInputState == Enum.UserInputState.End);
    if p63 == u58 then
        u58 = nil;
    end;
    if u57[p63] == false then
        u59 = nil;
        u31 = math.max(0, u31 - 1);
    end;
    u57[p63] = nil;
end;
local function u72(p65, p66) --[[ Line: 325 ]]
    -- upvalues: u58 (ref), u57 (ref), u2 (copy), u35 (copy), u59 (ref)
    assert(p65.UserInputType == Enum.UserInputType.Touch);
    assert(p65.UserInputState == Enum.UserInputState.Change);
    if p65 == u58 then
    else
        if u57[p65] == nil then
            if u2 then
                u57[p65] = true;
            else
                u57[p65] = p66;
            end;
        end;
        local v67 = {};
        for v68, v69 in pairs(u57) do
            if not v69 then
                table.insert(v67, v68);
            end;
        end;
        if #v67 == 1 and u57[p65] == false then
            local l__Delta__19 = p65.Delta;
            local v70 = u35;
            v70.Move = v70.Move + Vector2.new(l__Delta__19.X, l__Delta__19.Y);
        end;
        if #v67 == 2 then
            local l__Magnitude__20 = (v67[1].Position - v67[2].Position).Magnitude;
            if u59 then
                local v71 = u35;
                v71.Pinch = v71.Pinch + (l__Magnitude__20 - u59);
            end;
            u59 = l__Magnitude__20;
        else
            u59 = nil;
        end;
    end;
end;
local function u73() --[[ Line: 373 ]]
    -- upvalues: u57 (ref), u58 (ref), u59 (ref), u31 (ref)
    u57 = {};
    u58 = nil;
    u59 = nil;
    u31 = 0;
end;
local function u78(p74, p75, p76, p77) --[[ Line: 381 ]]
    -- upvalues: u34 (copy)
    if not p77 then
        u34.Wheel = p74;
        u34.Pan = p75;
        u34.Pinch = -p76;
    end;
end;
local function u81(p79, p80) --[[ Line: 389 ]]
    -- upvalues: u62 (ref), u31 (ref)
    if p79.UserInputType == Enum.UserInputType.Touch then
        u62(p79, p80);
    else
        if p79.UserInputType == Enum.UserInputType.MouseButton2 and not p80 then
            u31 = math.max(0, u31 + 1);
        end;
    end;
end;
local function u84(p82, p83) --[[ Line: 398 ]]
    -- upvalues: u72 (ref), u34 (copy)
    if p82.UserInputType == Enum.UserInputType.Touch then
        u72(p82, p83);
    else
        if p82.UserInputType == Enum.UserInputType.MouseMovement then
            local l__Delta__21 = p82.Delta;
            u34.Movement = Vector2.new(l__Delta__21.X, l__Delta__21.Y);
        end;
    end;
end;
local function u87(p85, p86) --[[ Line: 407 ]]
    -- upvalues: u64 (ref), u31 (ref)
    if p85.UserInputType == Enum.UserInputType.Touch then
        u64(p85, p86);
    else
        if p85.UserInputType == Enum.UserInputType.MouseButton2 then
            u31 = math.max(0, u31 - 1);
        end;
    end;
end;
local u88 = false;
function v29.setInputEnabled(p89) --[[ Line: 418 ]]
    -- upvalues: u88 (ref), u56 (copy), u73 (ref), l__ContextActionService__1 (copy), u45 (copy), l__Value__11 (copy), u48 (copy), l__VRService__6 (copy), u52 (copy), u50 (copy), u30 (ref), l__UserInputService__2 (copy), u81 (copy), u84 (copy), u87 (copy), u78 (copy), l__GuiService__7 (copy)
    if u88 == p89 then
    else
        u88 = p89;
        u56();
        u73();
        if u88 then
            l__ContextActionService__1:BindActionAtPriority("RbxCameraThumbstick", u45, false, l__Value__11, Enum.KeyCode.Thumbstick2);
            l__ContextActionService__1:BindActionAtPriority("RbxCameraKeypress", u48, false, l__Value__11, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);
            if l__VRService__6.VREnabled then
                l__ContextActionService__1:BindAction("RbxCameraGamepadReset", u52, false, Enum.KeyCode.ButtonL3);
            end;
            l__ContextActionService__1:BindAction("RbxCameraGamepadZoom", u50, false, Enum.KeyCode.ButtonR3);
            table.insert(u30, l__UserInputService__2.InputBegan:Connect(u81));
            table.insert(u30, l__UserInputService__2.InputChanged:Connect(u84));
            table.insert(u30, l__UserInputService__2.InputEnded:Connect(u87));
            table.insert(u30, l__UserInputService__2.PointerAction:Connect(u78));
            table.insert(u30, l__GuiService__7.MenuOpened:connect(u73));
        else
            l__ContextActionService__1:UnbindAction("RbxCameraThumbstick");
            l__ContextActionService__1:UnbindAction("RbxCameraMouseMove");
            l__ContextActionService__1:UnbindAction("RbxCameraMouseWheel");
            l__ContextActionService__1:UnbindAction("RbxCameraKeypress");
            l__ContextActionService__1:UnbindAction("RbxCameraGamepadZoom");
            if l__VRService__6.VREnabled then
                l__ContextActionService__1:UnbindAction("RbxCameraGamepadReset");
            end;
            for _, v90 in pairs(u30) do
                v90:Disconnect();
            end;
            u30 = {};
        end;
    end;
end;
function v29.getInputEnabled() --[[ Line: 487 ]]
    -- upvalues: u88 (ref)
    return u88;
end;
function v29.resetInputForFrameEnd() --[[ Line: 491 ]]
    -- upvalues: u34 (copy), u35 (copy)
    u34.Movement = Vector2.new();
    u35.Move = Vector2.new();
    u35.Pinch = 0;
    u34.Wheel = 0;
    u34.Pan = Vector2.new();
    u34.Pinch = 0;
end;
l__UserInputService__2.WindowFocused:Connect(u56);
l__UserInputService__2.WindowFocusReleased:Connect(u56);
if v3 then
    l__UserInputService__2.TextBoxFocusReleased:Connect(u56);
end;
local u91 = false;
local u92 = false;
local u93 = 0;
function v29.getHoldPan() --[[ Line: 515 ]]
    -- upvalues: u91 (ref)
    return u91;
end;
function v29.getTogglePan() --[[ Line: 519 ]]
    -- upvalues: u92 (ref)
    return u92;
end;
function v29.getPanning() --[[ Line: 523 ]]
    -- upvalues: u92 (ref), u91 (ref)
    return u92 or u91;
end;
function v29.setTogglePan(p94) --[[ Line: 527 ]]
    -- upvalues: u92 (ref)
    u92 = p94;
end;
local u95 = false;
local u96 = nil;
local u97 = nil;
function v29.enableCameraToggleInput() --[[ Line: 535 ]]
    -- upvalues: u95 (ref), u91 (ref), u92 (ref), u96 (ref), u97 (ref), l__Event__12 (ref), u93 (ref), l__Event__13 (ref), l__UserInputService__2 (copy)
    if u95 then
    else
        u95 = true;
        u91 = false;
        u92 = false;
        if u96 then
            u96:Disconnect();
        end;
        if u97 then
            u97:Disconnect();
        end;
        u96 = l__Event__12:Connect(function() --[[ Line: 552 ]]
            -- upvalues: u91 (ref), u93 (ref)
            u91 = true;
            u93 = tick();
        end);
        u97 = l__Event__13:Connect(function() --[[ Line: 557 ]]
            -- upvalues: u91 (ref), u93 (ref), u92 (ref), l__UserInputService__2 (ref)
            u91 = false;
            if tick() - u93 < 0.3 and (u92 or l__UserInputService__2:GetMouseDelta().Magnitude < 2) then
                u92 = not u92;
            end;
        end);
    end;
end;
function v29.disableCameraToggleInput() --[[ Line: 565 ]]
    -- upvalues: u95 (ref), u96 (ref), u97 (ref)
    if u95 then
        u95 = false;
        if u96 then
            u96:Disconnect();
            u96 = nil;
        end;
        if u97 then
            u97:Disconnect();
            u97 = nil;
        end;
    end;
end;
return v29;
