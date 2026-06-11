-- Decompiled from: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.MouseLockController
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Value__1 = Enum.ContextActionPriority.Default.Value;
local l__Players__2 = game:GetService("Players");
local l__ContextActionService__3 = game:GetService("ContextActionService");
local l__GameSettings__4 = UserSettings().GameSettings;
local u1 = l__Players__2.LocalPlayer:GetMouse();
local u2 = {};
u2.__index = u2;
function u2.new() --[[ Line: 23 ]]
    -- upvalues: u2 (copy), l__GameSettings__4 (copy), l__Players__2 (copy)
    local u3 = setmetatable({}, u2);
    u3.isMouseLocked = false;
    u3.savedMouseCursor = nil;
    u3.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift };
    u3.mouseLockToggledEvent = Instance.new("BindableEvent");
    local v4 = script:FindFirstChild("BoundKeys");
    if not (v4 and v4:IsA("StringValue")) then
        if v4 then
            v4:Destroy();
        end;
        v4 = Instance.new("StringValue");
        v4.Name = "BoundKeys";
        v4.Value = "LeftShift,RightShift";
        v4.Parent = script;
    end;
    if v4 then
        v4.Changed:Connect(function(p5) --[[ Line: 46 ]]
            -- upvalues: u3 (copy)
            u3:OnBoundKeysObjectChanged(p5);
        end);
        u3:OnBoundKeysObjectChanged(v4.Value);
    end;
    l__GameSettings__4.Changed:Connect(function(p6) --[[ Line: 53 ]]
        -- upvalues: u3 (copy)
        if p6 == "ControlMode" or p6 == "ComputerMovementMode" then
            u3:UpdateMouseLockAvailability();
        end;
    end);
    l__Players__2.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() --[[ Line: 60 ]]
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    l__Players__2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 65 ]]
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    u3:UpdateMouseLockAvailability();
    if game:GetService("UserInputService").TouchEnabled == true then
        script:WaitForChild("CursorImage").Value = "";
    end;
    return u3;
end;
function u2.GetIsMouseLocked(p7) --[[ Line: 77 ]]
    return p7.isMouseLocked;
end;
function u2.GetBindableToggleEvent(p8) --[[ Line: 81 ]]
    return p8.mouseLockToggledEvent.Event;
end;
function u2.GetMouseLockOffset(_) --[[ Line: 85 ]]
    local v9 = script:FindFirstChild("CameraOffset");
    if v9 and v9:IsA("Vector3Value") then
        return v9.Value;
    end;
    if v9 then
        v9:Destroy();
    end;
    local v10 = Instance.new("Vector3Value");
    v10.Name = "CameraOffset";
    v10.Value = Vector3.new(1.75, 0, 0);
    v10.Parent = script;
    return not (v10 and v10.Value) and Vector3.new(1.75, 0, 0) or v10.Value;
end;
function u2.UpdateMouseLockAvailability(p11) --[[ Line: 107 ]]
    -- upvalues: l__Players__2 (copy), l__GameSettings__4 (copy)
    local l__DevEnableMouseLock__5 = l__Players__2.LocalPlayer.DevEnableMouseLock;
    local v12 = l__Players__2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable;
    local v13 = l__DevEnableMouseLock__5 and (l__GameSettings__4.ControlMode == Enum.ControlMode.MouseLockSwitch and l__GameSettings__4.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove);
    if v13 then
        v13 = not v12;
    end;
    if v13 ~= p11.enabled then
        p11:EnableMouseLock(v13);
    end;
end;
function u2.OnBoundKeysObjectChanged(p14, p15) --[[ Line: 119 ]]
    p14.boundKeys = {};
    for v16 in string.gmatch(p15, "[^%s,]+") do
        for _, v17 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v16 == v17.Name then
                p14.boundKeys[#p14.boundKeys + 1] = v17;
                break;
            end;
        end;
    end;
    p14:UnbindContextActions();
    p14:BindContextActions();
end;
function u2.OnMouseLockToggled(p18) --[[ Line: 134 ]]
    -- upvalues: u1 (copy)
    p18.isMouseLocked = not p18.isMouseLocked;
    if p18.isMouseLocked then
        local v19 = script:FindFirstChild("CursorImage");
        if v19 and (v19:IsA("StringValue") and v19.Value) then
            p18.savedMouseCursor = u1.Icon;
            u1.Icon = v19.Value;
        else
            if v19 then
                v19:Destroy();
            end;
            local v20 = Instance.new("StringValue");
            v20.Name = "CursorImage";
            v20.Value = "rbxasset://textures/MouseLockedCursor.png";
            v20.Parent = script;
            p18.savedMouseCursor = u1.Icon;
            u1.Icon = "rbxasset://textures/MouseLockedCursor.png";
        end;
    elseif p18.savedMouseCursor then
        u1.Icon = p18.savedMouseCursor;
        p18.savedMouseCursor = nil;
    end;
    p18.mouseLockToggledEvent:Fire();
end;
function u2.DoMouseLockSwitch(p21, _, p22, _) --[[ Line: 163 ]]
    if p22 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;
    p21:OnMouseLockToggled();
    return Enum.ContextActionResult.Sink;
end;
function u2.BindContextActions(u23) --[[ Line: 171 ]]
    -- upvalues: l__ContextActionService__3 (copy), l__Value__1 (copy)
    l__ContextActionService__3:BindActionAtPriority("MouseLockSwitchAction", function(p24, p25, p26) --[[ Line: 172 ]]
        -- upvalues: u23 (copy)
        return u23:DoMouseLockSwitch(p24, p25, p26);
    end, false, l__Value__1, unpack(u23.boundKeys));
end;
function u2.UnbindContextActions(_) --[[ Line: 177 ]]
    -- upvalues: l__ContextActionService__3 (copy)
    l__ContextActionService__3:UnbindAction("MouseLockSwitchAction");
end;
function u2.IsMouseLocked(p27) --[[ Line: 181 ]]
    local l__enabled__6 = p27.enabled;
    if l__enabled__6 then
        l__enabled__6 = p27.isMouseLocked;
    end;
    return l__enabled__6;
end;
function u2.EnableMouseLock(p28, p29) --[[ Line: 185 ]]
    -- upvalues: u1 (copy)
    if p29 ~= p28.enabled then
        p28.enabled = p29;
        if p28.enabled then
            p28:BindContextActions();
            return;
        end;
        if u1.Icon ~= "" then
            u1.Icon = "";
        end;
        p28:UnbindContextActions();
        if p28.isMouseLocked then
            p28.mouseLockToggledEvent:Fire();
        end;
        p28.isMouseLocked = false;
    end;
end;
return u2;
