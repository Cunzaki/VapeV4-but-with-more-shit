-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.ControlModule
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__Workspace__4 = game:GetService("Workspace");
local l__UserGameSettings__5 = UserSettings():GetService("UserGameSettings");
local l__Keyboard__6 = require(script:WaitForChild("Keyboard"));
local l__Gamepad__7 = require(script:WaitForChild("Gamepad"));
local l__DynamicThumbstick__8 = require(script:WaitForChild("DynamicThumbstick"));
local v2, v3 = pcall(function() --[[ Line: 29 ]]
    return UserSettings():IsUserFeatureEnabled("UserMakeThumbstickDynamic");
end);
local u4 = v2 and v3 and l__DynamicThumbstick__8 and l__DynamicThumbstick__8 or require(script:WaitForChild("TouchThumbstick"));
local l__ClickToMoveController__9 = require(script:WaitForChild("ClickToMoveController"));
local l__TouchJump__10 = require(script:WaitForChild("TouchJump"));
local l__VehicleController__11 = require(script:WaitForChild("VehicleController"));
local l__Value__12 = Enum.ContextActionPriority.Default.Value;
local u5 = {
    [Enum.TouchMovementMode.DPad] = l__DynamicThumbstick__8,
    [Enum.DevTouchMovementMode.DPad] = l__DynamicThumbstick__8,
    [Enum.TouchMovementMode.Thumbpad] = l__DynamicThumbstick__8,
    [Enum.DevTouchMovementMode.Thumbpad] = l__DynamicThumbstick__8,
    [Enum.TouchMovementMode.Thumbstick] = u4,
    [Enum.DevTouchMovementMode.Thumbstick] = u4,
    [Enum.TouchMovementMode.DynamicThumbstick] = l__DynamicThumbstick__8,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = l__DynamicThumbstick__8,
    [Enum.TouchMovementMode.ClickToMove] = l__ClickToMoveController__9,
    [Enum.DevTouchMovementMode.ClickToMove] = l__ClickToMoveController__9,
    [Enum.TouchMovementMode.Default] = l__DynamicThumbstick__8,
    [Enum.ComputerMovementMode.Default] = l__Keyboard__6,
    [Enum.ComputerMovementMode.KeyboardMouse] = l__Keyboard__6,
    [Enum.DevComputerMovementMode.KeyboardMouse] = l__Keyboard__6,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = l__ClickToMoveController__9,
    [Enum.DevComputerMovementMode.ClickToMove] = l__ClickToMoveController__9
};
local u6 = {
    [Enum.UserInputType.Keyboard] = l__Keyboard__6,
    [Enum.UserInputType.MouseButton1] = l__Keyboard__6,
    [Enum.UserInputType.MouseButton2] = l__Keyboard__6,
    [Enum.UserInputType.MouseButton3] = l__Keyboard__6,
    [Enum.UserInputType.MouseWheel] = l__Keyboard__6,
    [Enum.UserInputType.MouseMovement] = l__Keyboard__6,
    [Enum.UserInputType.Gamepad1] = l__Gamepad__7,
    [Enum.UserInputType.Gamepad2] = l__Gamepad__7,
    [Enum.UserInputType.Gamepad3] = l__Gamepad__7,
    [Enum.UserInputType.Gamepad4] = l__Gamepad__7
};
local u7 = nil;
function u1.new() --[[ Line: 86 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy), l__VehicleController__11 (copy), l__Value__12 (copy), l__RunService__2 (copy), l__UserInputService__3 (copy), l__UserGameSettings__5 (copy)
    local u8 = setmetatable({}, u1);
    u8.controllers = {};
    u8.activeControlModule = nil;
    u8.activeController = nil;
    u8.touchJumpController = nil;
    u8.moveFunction = l__Players__1.LocalPlayer.Move;
    u8.humanoid = nil;
    u8.lastInputType = Enum.UserInputType.None;
    u8.humanoidSeatedConn = nil;
    u8.vehicleController = nil;
    u8.touchControlFrame = nil;
    u8.vehicleController = l__VehicleController__11.new(l__Value__12);
    l__Players__1.LocalPlayer.CharacterAdded:Connect(function(p9) --[[ Line: 108 ]]
        -- upvalues: u8 (copy)
        u8:OnCharacterAdded(p9);
    end);
    l__Players__1.LocalPlayer.CharacterRemoving:Connect(function(p10) --[[ Line: 109 ]]
        -- upvalues: u8 (copy)
        u8:OnCharacterRemoving(p10);
    end);
    if l__Players__1.LocalPlayer.Character then
        u8:OnCharacterAdded(l__Players__1.LocalPlayer.Character);
    end;
    l__RunService__2:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p11) --[[ Line: 114 ]]
        -- upvalues: u8 (copy)
        u8:OnRenderStepped(p11);
    end);
    l__UserInputService__3.LastInputTypeChanged:Connect(function(p12) --[[ Line: 118 ]]
        -- upvalues: u8 (copy)
        u8:OnLastInputTypeChanged(p12);
    end);
    l__UserGameSettings__5:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() --[[ Line: 123 ]]
        -- upvalues: u8 (copy)
        u8:OnTouchMovementModeChange();
    end);
    l__Players__1.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() --[[ Line: 126 ]]
        -- upvalues: u8 (copy)
        u8:OnTouchMovementModeChange();
    end);
    l__UserGameSettings__5:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() --[[ Line: 130 ]]
        -- upvalues: u8 (copy)
        u8:OnComputerMovementModeChange();
    end);
    l__Players__1.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 133 ]]
        -- upvalues: u8 (copy)
        u8:OnComputerMovementModeChange();
    end);
    u8.playerGui = nil;
    u8.touchGui = nil;
    u8.playerGuiAddedConn = nil;
    if not l__UserInputService__3.TouchEnabled then
        u8:OnLastInputTypeChanged(l__UserInputService__3:GetLastInputType());
        return u8;
    end;
    u8.playerGui = l__Players__1.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    if not u8.playerGui then
        u8.playerGuiAddedConn = l__Players__1.LocalPlayer.ChildAdded:Connect(function(p13) --[[ Line: 148 ]]
            -- upvalues: u8 (copy), l__UserInputService__3 (ref)
            if p13:IsA("PlayerGui") then
                u8.playerGui = p13;
                u8:CreateTouchGuiContainer();
                u8.playerGuiAddedConn:Disconnect();
                u8.playerGuiAddedConn = nil;
                u8:OnLastInputTypeChanged(l__UserInputService__3:GetLastInputType());
            end;
        end);
        return u8;
    end;
    u8:CreateTouchGuiContainer();
    u8:OnLastInputTypeChanged(l__UserInputService__3:GetLastInputType());
    return u8;
end;
function u1.GetMoveVector(p14) --[[ Line: 168 ]]
    return not p14.activeController and Vector3.new(0, 0, 0) or p14.activeController:GetMoveVector();
end;
function u1.GetActiveController(p15) --[[ Line: 175 ]]
    return p15.activeController;
end;
function u1.EnableActiveControlModule(p16) --[[ Line: 179 ]]
    -- upvalues: l__ClickToMoveController__9 (copy), l__Players__1 (copy)
    if p16.activeControlModule == l__ClickToMoveController__9 then
        p16.activeController:Enable(true, l__Players__1.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p16.touchJumpController);
    elseif p16.touchControlFrame then
        p16.activeController:Enable(true, p16.touchControlFrame);
    else
        p16.activeController:Enable(true);
    end;
end;
function u1.Enable(p17, p18) --[[ Line: 195 ]]
    if p17.activeController then
        if p18 == nil and true or p18 then
            p17:EnableActiveControlModule();
        else
            p17:Disable();
        end;
    end;
end;
function u1.Disable(p19) --[[ Line: 211 ]]
    -- upvalues: l__Players__1 (copy)
    if p19.activeController then
        p19.activeController:Enable(false);
        if p19.moveFunction then
            p19.moveFunction(l__Players__1.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;
    end;
end;
function u1.SelectComputerMovementModule(_) --[[ Line: 223 ]]
    -- upvalues: l__UserInputService__3 (copy), l__Players__1 (copy), u6 (copy), u7 (ref), l__UserGameSettings__5 (copy), l__Keyboard__6 (copy), l__ClickToMoveController__9 (copy), u5 (copy)
    if l__UserInputService__3.KeyboardEnabled or l__UserInputService__3.GamepadEnabled then
        local l__DevComputerMovementMode__13 = l__Players__1.LocalPlayer.DevComputerMovementMode;
        local v20;
        if l__DevComputerMovementMode__13 == Enum.DevComputerMovementMode.UserChoice then
            v20 = u6[u7];
            if l__UserGameSettings__5.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v20 == l__Keyboard__6 then
                v20 = l__ClickToMoveController__9;
            end;
        else
            v20 = u5[l__DevComputerMovementMode__13];
            if not v20 and l__DevComputerMovementMode__13 ~= Enum.DevComputerMovementMode.Scriptable then
                warn("No character control module is associated with DevComputerMovementMode ", l__DevComputerMovementMode__13);
            end;
        end;
        if v20 then
            return v20, true;
        elseif l__DevComputerMovementMode__13 == Enum.DevComputerMovementMode.Scriptable then
            return nil, true;
        else
            return nil, false;
        end;
    else
        return nil, false;
    end;
end;
function u1.SelectTouchModule(_) --[[ Line: 261 ]]
    -- upvalues: l__UserInputService__3 (copy), l__Players__1 (copy), u5 (copy), l__UserGameSettings__5 (copy)
    if not l__UserInputService__3.TouchEnabled then
        return nil, false;
    end;
    local l__DevTouchMovementMode__14 = l__Players__1.LocalPlayer.DevTouchMovementMode;
    local v21;
    if l__DevTouchMovementMode__14 == Enum.DevTouchMovementMode.UserChoice then
        v21 = u5[l__UserGameSettings__5.TouchMovementMode];
    else
        if l__DevTouchMovementMode__14 == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;
        v21 = u5[l__DevTouchMovementMode__14];
    end;
    return v21, true;
end;
local function u30(p22, p23) --[[ Line: 277 ]]
    -- upvalues: l__Workspace__4 (copy)
    local l__CurrentCamera__15 = l__Workspace__4.CurrentCamera;
    if not l__CurrentCamera__15 then
        return p23;
    end;
    if p22:GetState() == Enum.HumanoidStateType.Swimming then
        return l__CurrentCamera__15.CFrame:VectorToWorldSpace(p23);
    end;
    local _, _, _, v28, v25, v26, _, _, v27, _, _, v28 = l__CurrentCamera__15.CFrame:GetComponents();
    if v27 >= 1 or v27 <= -1 then
        v26 = -v25 * math.sign(v27);
    end;
    local v29 = math.sqrt(v28 * v28 + v26 * v26);
    return Vector3.new((v28 * p23.x + v26 * p23.z) / v29, 0, (v28 * p23.z - v26 * p23.x) / v29);
end;
function u1.OnRenderStepped(p31, p32) --[[ Line: 307 ]]
    -- upvalues: l__Gamepad__7 (copy), u30 (copy), l__Players__1 (copy)
    if p31.activeController and (p31.activeController.enabled and p31.humanoid) then
        p31.activeController:OnRenderStepped(p32);
        local v33 = p31.activeController:GetMoveVector();
        local v34 = p31.activeController:IsMoveVectorCameraRelative();
        local v35 = p31:GetClickToMoveController();
        if p31.activeController ~= v35 then
            if v33.magnitude > 0 then
                v35:CleanupPath();
            else
                v35:OnRenderStepped(p32);
                v33 = v35:GetMoveVector();
                v34 = v35:IsMoveVectorCameraRelative();
            end;
        end;
        if p31.vehicleController then
            local v36;
            v33, v36 = p31.vehicleController:Update(v33, v34, p31.activeControlModule == l__Gamepad__7);
        end;
        if v34 then
            v33 = u30(p31.humanoid, v33);
        end;
        p31.moveFunction(l__Players__1.LocalPlayer, v33, false);
        local l__humanoid__16 = p31.humanoid;
        local v37 = not p31.activeController:GetIsJumping() and p31.touchJumpController;
        if v37 then
            v37 = p31.touchJumpController:GetIsJumping();
        end;
        l__humanoid__16.Jump = v37;
    end;
end;
function u1.OnHumanoidSeated(p38, p39, p40) --[[ Line: 350 ]]
    -- upvalues: l__Value__12 (copy)
    if p39 then
        if p40 and p40:IsA("VehicleSeat") then
            if not p38.vehicleController then
                p38.vehicleController = p38.vehicleController.new(l__Value__12);
            end;
            p38.vehicleController:Enable(true, p40);
        end;
    elseif p38.vehicleController then
        p38.vehicleController:Enable(false, p40);
    end;
end;
function u1.OnCharacterAdded(u41, p42) --[[ Line: 365 ]]
    u41.humanoid = p42:FindFirstChildOfClass("Humanoid");
    while not u41.humanoid do
        p42.ChildAdded:wait();
        u41.humanoid = p42:FindFirstChildOfClass("Humanoid");
    end;
    if u41.touchGui then
        u41.touchGui.Enabled = true;
    end;
    if u41.humanoidSeatedConn then
        u41.humanoidSeatedConn:Disconnect();
        u41.humanoidSeatedConn = nil;
    end;
    u41.humanoidSeatedConn = u41.humanoid.Seated:Connect(function(p43, p44) --[[ Line: 380 ]]
        -- upvalues: u41 (copy)
        u41:OnHumanoidSeated(p43, p44);
    end);
end;
function u1.OnCharacterRemoving(p45, _) --[[ Line: 385 ]]
    p45.humanoid = nil;
    if p45.touchGui then
        p45.touchGui.Enabled = false;
    end;
end;
function u1.SwitchToController(p46, p47) --[[ Line: 397 ]]
    -- upvalues: l__Value__12 (copy), l__ClickToMoveController__9 (copy), u4 (copy), l__DynamicThumbstick__8 (copy), l__TouchJump__10 (copy)
    if p47 then
        if not p46.controllers[p47] then
            p46.controllers[p47] = p47.new(l__Value__12);
        end;
        if p46.activeController ~= p46.controllers[p47] then
            if p46.activeController then
                p46.activeController:Enable(false);
            end;
            p46.activeController = p46.controllers[p47];
            p46.activeControlModule = p47;
            if p46.touchControlFrame and (p46.activeControlModule == l__ClickToMoveController__9 or (p46.activeControlModule == u4 or p46.activeControlModule == l__DynamicThumbstick__8)) then
                if not p46.controllers[l__TouchJump__10] then
                    p46.controllers[l__TouchJump__10] = l__TouchJump__10.new();
                end;
                p46.touchJumpController = p46.controllers[l__TouchJump__10];
                p46.touchJumpController:Enable(true, p46.touchControlFrame);
            elseif p46.touchJumpController then
                p46.touchJumpController:Enable(false);
            end;
            p46:EnableActiveControlModule();
        end;
    else
        if p46.activeController then
            p46.activeController:Enable(false);
        end;
        p46.activeController = nil;
        p46.activeControlModule = nil;
    end;
end;
function u1.OnLastInputTypeChanged(p48, p49) --[[ Line: 435 ]]
    -- upvalues: u7 (ref), u6 (copy)
    if u7 == p49 then
        warn("LastInputType Change listener called with current type.");
    end;
    u7 = p49;
    if u7 == Enum.UserInputType.Touch then
        local v50, v51 = p48:SelectTouchModule();
        if v51 then
            while not p48.touchControlFrame do
                wait();
            end;
            p48:SwitchToController(v50);
        end;
    else
        local v52 = u6[u7] ~= nil and p48:SelectComputerMovementModule();
        if v52 then
            p48:SwitchToController(v52);
        end;
    end;
end;
function u1.OnComputerMovementModeChange(p53) --[[ Line: 460 ]]
    local v54, v55 = p53:SelectComputerMovementModule();
    if v55 then
        p53:SwitchToController(v54);
    end;
end;
function u1.OnTouchMovementModeChange(p56) --[[ Line: 467 ]]
    local v57, v58 = p56:SelectTouchModule();
    if v58 then
        while not p56.touchControlFrame do
            wait();
        end;
        p56:SwitchToController(v57);
    end;
end;
function u1.CreateTouchGuiContainer(p59) --[[ Line: 477 ]]
    if p59.touchGui then
        p59.touchGui:Destroy();
    end;
    p59.touchGui = Instance.new("ScreenGui");
    p59.touchGui.Name = "TouchGui";
    p59.touchGui.ResetOnSpawn = false;
    p59.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    p59.touchGui.Enabled = p59.humanoid ~= nil;
    p59.touchControlFrame = Instance.new("Frame");
    p59.touchControlFrame.Name = "TouchControlFrame";
    p59.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
    p59.touchControlFrame.BackgroundTransparency = 1;
    p59.touchControlFrame.Parent = p59.touchGui;
    p59.touchGui.Parent = p59.playerGui;
end;
function u1.GetClickToMoveController(p60) --[[ Line: 496 ]]
    -- upvalues: l__ClickToMoveController__9 (copy), l__Value__12 (copy)
    if not p60.controllers[l__ClickToMoveController__9] then
        p60.controllers[l__ClickToMoveController__9] = l__ClickToMoveController__9.new(l__Value__12);
    end;
    return p60.controllers[l__ClickToMoveController__9];
end;
return u1.new();
