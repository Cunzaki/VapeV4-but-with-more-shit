-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.CameraModule.CameraInput
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v1, v2 = pcall(function() --[[ Line: 2 ]]
    return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor2");
end);
local u3 = v1 and v2;
local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__Players__3 = game:GetService("Players");
local l__UserGameSettings__4 = UserSettings():GetService("UserGameSettings");
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local l__Value__6 = Enum.ContextActionPriority.Default.Value;
local u4 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u5 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u6 = Vector2.new(1, 0.66) * 0.017453292519943295;
local u7 = Vector2.new(1, 0.77) * 0.06981317007977318;
local u8 = Instance.new("BindableEvent");
local u9 = Instance.new("BindableEvent");
local l__Event__7 = u8.Event;
local l__Event__8 = u9.Event;
l__UserInputService__2.InputBegan:Connect(function(p10, p11) --[[ Line: 38 ]]
    -- upvalues: u8 (copy)
    if not p11 and p10.UserInputType == Enum.UserInputType.MouseButton2 then
        u8:Fire();
    end;
end);
l__UserInputService__2.InputEnded:Connect(function(p12, _) --[[ Line: 44 ]]
    -- upvalues: u9 (copy)
    if p12.UserInputType == Enum.UserInputType.MouseButton2 then
        u9:Fire();
    end;
end);
local function u16(p13) --[[ Line: 55 ]]
    local v14 = (math.abs(p13) - 0.1) / 0.9 * 2;
    local v15 = (math.exp(v14) - 1) / 6.38905609893065;
    return math.sign(p13) * math.clamp(v15, 0, 1);
end;
local function u20(p17) --[[ Line: 69 ]]
    local l__CurrentCamera__9 = workspace.CurrentCamera;
    if not l__CurrentCamera__9 then
        return p17;
    end;
    local v18 = l__CurrentCamera__9.CFrame:ToEulerAnglesYXZ();
    if p17.Y * v18 >= 0 then
        return p17;
    end;
    local v19 = (1 - (math.abs(v18) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;
    return Vector2.new(1, v19) * p17;
end;
local function u26(p21) --[[ Line: 95 ]]
    -- upvalues: l__LocalPlayer__5 (copy)
    local v22 = l__LocalPlayer__5:FindFirstChildOfClass("PlayerGui");
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
    local l__AbsolutePosition__10 = v23.AbsolutePosition;
    local v24 = l__AbsolutePosition__10 + v23.AbsoluteSize;
    local v25;
    if p21.X >= l__AbsolutePosition__10.X and (p21.Y >= l__AbsolutePosition__10.Y and p21.X <= v24.X) then
        v25 = p21.Y <= v24.Y;
    else
        v25 = false;
    end;
    return v25;
end;
local v27 = {};
local u28 = {};
local u29 = {
    Thumbstick2 = Vector2.new()
};
local u30 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u31 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u32 = {
    Pinch = 0,
    Move = Vector2.new()
};
local u33 = Instance.new("BindableEvent");
v27.gamepadZoomPress = u33.Event;
function v27.getPanning() --[[ Line: 148 ]]
    -- upvalues: l__UserInputService__2 (copy)
    for _, v34 in pairs(l__UserInputService__2:GetMouseButtonsPressed()) do
        if v34.UserInputType == Enum.UserInputType.MouseButton2 then
            return true;
        end;
    end;
    return false;
end;
function v27.getRotation() --[[ Line: 157 ]]
    -- upvalues: u30 (copy), u29 (copy), u31 (copy), u20 (copy), u32 (copy), u7 (copy), u4 (copy), u5 (copy), u6 (copy)
    local v35 = Vector2.new(u30.Right - u30.Left, 0);
    local l__Thumbstick2__11 = u29.Thumbstick2;
    local l__Movement__12 = u31.Movement;
    local l__Pan__13 = u31.Pan;
    local v36 = u20(u32.Move);
    return v35 * 0.03490658503988659 + l__Thumbstick2__11 * u7 + l__Movement__12 * u4 + l__Pan__13 * u5 + v36 * u6;
end;
function v27.getZoomDelta() --[[ Line: 174 ]]
    -- upvalues: u30 (copy), u31 (copy), u32 (copy)
    return (u30.O - u30.I) * 0.1 + (-u31.Wheel + u31.Pinch) * 1 + -u32.Pinch * 0.04;
end;
local function u38(_, _, p37) --[[ Line: 182 ]]
    -- upvalues: u29 (copy), u16 (ref)
    local l__Position__14 = p37.Position;
    u29[p37.KeyCode.Name] = Vector2.new(u16(l__Position__14.X), -u16(l__Position__14.Y));
end;
local function u40(_, _, p39) --[[ Line: 187 ]]
    -- upvalues: u31 (copy)
    local l__Delta__15 = p39.Delta;
    u31.Movement = Vector2.new(l__Delta__15.X, l__Delta__15.Y);
    return Enum.ContextActionResult.Pass;
end;
local function u43(_, p41, p42) --[[ Line: 198 ]]
    -- upvalues: u30 (copy)
    u30[p42.KeyCode.Name] = p41 == Enum.UserInputState.Begin and 1 or 0;
end;
local function u45(_, p44, _) --[[ Line: 202 ]]
    -- upvalues: u33 (copy)
    if p44 == Enum.UserInputState.Begin then
        u33:Fire();
    end;
end;
local function u49() --[[ Line: 208 ]]
    -- upvalues: u29 (copy), u30 (copy), u31 (copy), u32 (copy)
    for _, v46 in pairs({
        u29,
        u30,
        u31,
        u32
    }) do
        for v47, v48 in pairs(v46) do
            if type(v48) == "boolean" then
                v46[v47] = false;
            else
                v46[v47] = v46[v47] * 0;
            end;
        end;
    end;
end;
local u50 = {};
local u51 = nil;
local u52 = nil;
local function u55(p53, p54) --[[ Line: 232 ]]
    -- upvalues: u51 (ref), u26 (copy), u50 (copy)
    assert(p53.UserInputType == Enum.UserInputType.Touch);
    assert(p53.UserInputState == Enum.UserInputState.Begin);
    if u51 == nil and (u26(p53.Position) and not p54) then
        u51 = p53;
    else
        u50[p53] = p54;
    end;
end;
local function u57(p56, _) --[[ Line: 248 ]]
    -- upvalues: u51 (ref), u50 (copy), u52 (ref)
    assert(p56.UserInputType == Enum.UserInputType.Touch);
    assert(p56.UserInputState == Enum.UserInputState.End);
    if p56 == u51 then
        u51 = nil;
    end;
    if u50[p56] == false then
        u52 = nil;
    end;
    u50[p56] = nil;
end;
local function u63(p58, p59) --[[ Line: 266 ]]
    -- upvalues: u51 (ref), u50 (copy), u32 (copy), u52 (ref)
    assert(p58.UserInputType == Enum.UserInputType.Touch);
    assert(p58.UserInputState == Enum.UserInputState.Change);
    if p58 == u51 then
    else
        if u50[p58] == nil then
            u50[p58] = p59;
        end;
        local v60 = {};
        for v61, v62 in pairs(u50) do
            if not v62 then
                table.insert(v60, v61);
            end;
        end;
        if #v60 == 1 and u50[p58] == false then
            local l__Delta__16 = p58.Delta;
            u32.Move = Vector2.new(l__Delta__16.X, l__Delta__16.Y);
        end;
        if #v60 == 2 then
            local l__Magnitude__17 = (v60[1].Position - v60[2].Position).Magnitude;
            if u52 then
                u32.Pinch = l__Magnitude__17 - u52;
            end;
            u52 = l__Magnitude__17;
        else
            u52 = nil;
        end;
    end;
end;
local function u69(p64, p65, p66, p67) --[[ Line: 311 ]]
    -- upvalues: l__UserGameSettings__4 (copy), u31 (copy)
    if not p67 then
        local v68 = Vector2.new(1, l__UserGameSettings__4:GetCameraYInvertValue());
        u31.Wheel = p64;
        u31.Pan = p65 * v68;
        u31.Pinch = -p66;
    end;
end;
local function u72(p70, p71) --[[ Line: 321 ]]
    -- upvalues: u55 (ref)
    if p70.UserInputType == Enum.UserInputType.Touch then
        u55(p70, p71);
    end;
end;
local function u75(p73, p74) --[[ Line: 327 ]]
    -- upvalues: u63 (ref)
    if p73.UserInputType == Enum.UserInputType.Touch then
        u63(p73, p74);
    end;
end;
local function u78(p76, p77) --[[ Line: 333 ]]
    -- upvalues: u57 (ref)
    if p76.UserInputType == Enum.UserInputType.Touch then
        u57(p76, p77);
    end;
end;
local u79 = false;
function v27.setInputEnabled(p80) --[[ Line: 341 ]]
    -- upvalues: u3 (ref), u79 (ref), u49 (copy), l__ContextActionService__1 (copy), u38 (copy), l__Value__6 (copy), u40 (copy), u43 (copy), u45 (copy), u28 (ref), l__UserInputService__2 (copy), u72 (copy), u75 (copy), u78 (copy), u69 (copy)
    assert(u3);
    if u79 == p80 then
    else
        u79 = p80;
        if u79 then
            u49();
            l__ContextActionService__1:BindActionAtPriority("RbxCameraThumbstick", u38, false, l__Value__6, Enum.KeyCode.Thumbstick2);
            l__ContextActionService__1:BindActionAtPriority("RbxCameraMouseMove", u40, false, l__Value__6, Enum.UserInputType.MouseMovement);
            l__ContextActionService__1:BindActionAtPriority("RbxCameraKeypress", u43, false, l__Value__6, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);
            l__ContextActionService__1:BindAction("RbxCameraGamepadZoom", u45, false, Enum.KeyCode.ButtonR3);
            table.insert(u28, l__UserInputService__2.InputBegan:Connect(u72));
            table.insert(u28, l__UserInputService__2.InputChanged:Connect(u75));
            table.insert(u28, l__UserInputService__2.InputEnded:Connect(u78));
            table.insert(u28, l__UserInputService__2.PointerAction:Connect(u69));
        else
            l__ContextActionService__1:UnbindAction("RbxCameraThumbstick");
            l__ContextActionService__1:UnbindAction("RbxCameraMouseMove");
            l__ContextActionService__1:UnbindAction("RbxCameraMouseWheel");
            l__ContextActionService__1:UnbindAction("RbxCameraKeypress");
            u49();
            for _, v81 in pairs(u28) do
                v81:Disconnect();
            end;
            u28 = {};
        end;
    end;
end;
function v27.getInputEnabled() --[[ Line: 406 ]]
    -- upvalues: u79 (ref)
    return u79;
end;
function v27.resetInputForFrameEnd() --[[ Line: 410 ]]
    -- upvalues: u31 (copy), u32 (copy)
    u31.Movement = Vector2.new();
    u32.Move = Vector2.new();
    u32.Pinch = 0;
    u31.Wheel = 0;
    u31.Pan = Vector2.new();
    u31.Pinch = 0;
end;
l__UserInputService__2.WindowFocused:Connect(u49);
l__UserInputService__2.WindowFocusReleased:Connect(u49);
local u82 = false;
local u83 = false;
local u84 = 0;
function v27.getHoldPan() --[[ Line: 431 ]]
    -- upvalues: u82 (ref)
    return u82;
end;
function v27.getTogglePan() --[[ Line: 435 ]]
    -- upvalues: u83 (ref)
    return u83;
end;
function v27.getPanning() --[[ Line: 439 ]]
    -- upvalues: u83 (ref), u82 (ref)
    return u83 or u82;
end;
function v27.setTogglePan(p85) --[[ Line: 443 ]]
    -- upvalues: u83 (ref)
    u83 = p85;
end;
local u86 = false;
local u87 = nil;
local u88 = nil;
function v27.enableCameraToggleInput() --[[ Line: 451 ]]
    -- upvalues: u86 (ref), u82 (ref), u83 (ref), u87 (ref), u88 (ref), l__Event__7 (ref), u84 (ref), l__Event__8 (ref), l__UserInputService__2 (copy)
    if u86 then
    else
        u86 = true;
        u82 = false;
        u83 = false;
        if u87 then
            u87:Disconnect();
        end;
        if u88 then
            u88:Disconnect();
        end;
        u87 = l__Event__7:Connect(function() --[[ Line: 468 ]]
            -- upvalues: u82 (ref), u84 (ref)
            u82 = true;
            u84 = tick();
        end);
        u88 = l__Event__8:Connect(function() --[[ Line: 473 ]]
            -- upvalues: u82 (ref), u84 (ref), u83 (ref), l__UserInputService__2 (ref)
            u82 = false;
            if tick() - u84 < 0.3 and (u83 or l__UserInputService__2:GetMouseDelta().Magnitude < 2) then
                u83 = not u83;
            end;
        end);
    end;
end;
function v27.disableCameraToggleInput() --[[ Line: 481 ]]
    -- upvalues: u86 (ref), u87 (ref), u88 (ref)
    if u86 then
        u86 = false;
        if u87 then
            u87:Disconnect();
            u87 = nil;
        end;
        if u88 then
            u88:Disconnect();
            u88 = nil;
        end;
    end;
end;
return v27;
