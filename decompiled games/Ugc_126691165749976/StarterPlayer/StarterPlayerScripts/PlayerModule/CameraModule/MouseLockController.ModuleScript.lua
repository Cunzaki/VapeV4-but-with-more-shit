-- Decompiled from: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.MouseLockController
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
require(l__CommonUtils__1:WaitForChild("FlagUtil"));
local l__Value__2 = Enum.ContextActionPriority.Medium.Value;
local l__Players__3 = game:GetService("Players");
local l__ContextActionService__4 = game:GetService("ContextActionService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__GameSettings__6 = UserSettings().GameSettings;
local l__CameraUtils__7 = require(script.Parent:WaitForChild("CameraUtils"));
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 32 ]]
    -- upvalues: u1 (copy), l__GameSettings__6 (copy), l__Players__3 (copy), l__UserInputService__5 (copy)
    local u2 = setmetatable({}, u1);
    u2.isMouseLocked = false;
    u2.savedMouseCursor = nil;
    u2.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift };
    u2.mouseLockToggledEvent = Instance.new("BindableEvent");
    local v3 = script:FindFirstChild("BoundKeys");
    if not (v3 and v3:IsA("StringValue")) then
        if v3 then
            v3:Destroy();
        end;
        v3 = Instance.new("StringValue");
        assert(v3, "");
        v3.Name = "BoundKeys";
        v3.Value = "LeftShift,RightShift";
        v3.Parent = script;
    end;
    if v3 then
        v3.Changed:Connect(function(p4) --[[ Line: 57 ]]
            -- upvalues: u2 (copy)
            u2:OnBoundKeysObjectChanged(p4);
        end);
        u2:OnBoundKeysObjectChanged(v3.Value);
    end;
    l__GameSettings__6.Changed:Connect(function(p5) --[[ Line: 64 ]]
        -- upvalues: u2 (copy)
        if p5 == "ControlMode" or p5 == "ComputerMovementMode" then
            u2:UpdateMouseLockAvailability();
        end;
    end);
    l__Players__3.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() --[[ Line: 71 ]]
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    l__Players__3.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 76 ]]
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    l__UserInputService__5:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 80 ]]
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    u2:UpdateMouseLockAvailability();
    return u2;
end;
function u1.GetIsMouseLocked(p6) --[[ Line: 89 ]]
    return p6.isMouseLocked;
end;
function u1.GetBindableToggleEvent(p7) --[[ Line: 93 ]]
    return p7.mouseLockToggledEvent.Event;
end;
function u1.GetMouseLockOffset(_) --[[ Line: 97 ]]
    return Vector3.new(1.75, 0, 0);
end;
function u1.UpdateMouseLockAvailability(p8) --[[ Line: 101 ]]
    -- upvalues: l__Players__3 (copy), l__GameSettings__6 (copy), l__UserInputService__5 (copy)
    local l__DevEnableMouseLock__8 = l__Players__3.LocalPlayer.DevEnableMouseLock;
    local v9 = l__Players__3.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable;
    local v10 = l__UserInputService__5.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and (l__DevEnableMouseLock__8 and (l__GameSettings__6.ControlMode == Enum.ControlMode.MouseLockSwitch and l__GameSettings__6.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove));
    if v10 then
        v10 = not v9;
    end;
    if v10 ~= p8.enabled then
        p8:EnableMouseLock(v10);
    end;
end;
function u1.OnBoundKeysObjectChanged(p11, p12) --[[ Line: 114 ]]
    p11.boundKeys = {};
    for v13 in string.gmatch(p12, "[^%s,]+") do
        for _, v14 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v13 == v14.Name then
                p11.boundKeys[#p11.boundKeys + 1] = v14;
                break;
            end;
        end;
    end;
    p11:UnbindContextActions();
    p11:BindContextActions();
end;
function u1.OnMouseLockToggled(p15) --[[ Line: 129 ]]
    -- upvalues: l__CameraUtils__7 (copy)
    p15.isMouseLocked = not p15.isMouseLocked;
    if p15.isMouseLocked then
        local v16 = script:FindFirstChild("CursorImage");
        if v16 and (v16:IsA("StringValue") and v16.Value) then
            l__CameraUtils__7.setMouseIconOverride(v16.Value);
        else
            if v16 then
                v16:Destroy();
            end;
            local v17 = Instance.new("StringValue");
            assert(v17, "");
            v17.Name = "CursorImage";
            v17.Value = "rbxasset://textures/MouseLockedCursor.png";
            v17.Parent = script;
            l__CameraUtils__7.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png");
        end;
    else
        l__CameraUtils__7.restoreMouseIcon();
    end;
    p15.mouseLockToggledEvent:Fire();
end;
function u1.DoMouseLockSwitch(p18, _, p19, _) --[[ Line: 154 ]]
    if p19 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;
    p18:OnMouseLockToggled();
    return Enum.ContextActionResult.Sink;
end;
function u1.BindContextActions(u20) --[[ Line: 162 ]]
    -- upvalues: l__ContextActionService__4 (copy), l__Value__2 (copy)
    l__ContextActionService__4:BindActionAtPriority("MouseLockSwitchAction", function(p21, p22, p23) --[[ Line: 163 ]]
        -- upvalues: u20 (copy)
        return u20:DoMouseLockSwitch(p21, p22, p23);
    end, false, l__Value__2, unpack(u20.boundKeys));
end;
function u1.UnbindContextActions(_) --[[ Line: 168 ]]
    -- upvalues: l__ContextActionService__4 (copy)
    l__ContextActionService__4:UnbindAction("MouseLockSwitchAction");
end;
function u1.IsMouseLocked(p24) --[[ Line: 172 ]]
    local l__enabled__9 = p24.enabled;
    if l__enabled__9 then
        l__enabled__9 = p24.isMouseLocked;
    end;
    return l__enabled__9;
end;
function u1.EnableMouseLock(p25, p26) --[[ Line: 176 ]]
    -- upvalues: l__CameraUtils__7 (copy)
    if p26 ~= p25.enabled then
        p25.enabled = p26;
        if p25.enabled then
            p25:BindContextActions();
            return;
        end;
        l__CameraUtils__7.restoreMouseIcon();
        p25:UnbindContextActions();
        if p25.isMouseLocked then
            p25.mouseLockToggledEvent:Fire();
        end;
        p25.isMouseLocked = false;
    end;
end;
return u1;
