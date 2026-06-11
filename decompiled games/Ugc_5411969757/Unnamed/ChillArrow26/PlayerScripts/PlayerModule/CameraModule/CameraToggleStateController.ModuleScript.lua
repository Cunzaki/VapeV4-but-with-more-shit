-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.CameraModule.CameraToggleStateController
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__UserGameSettings__3 = UserSettings():GetService("UserGameSettings");
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
if not l__LocalPlayer__4 then
    l__Players__1:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__4 = l__Players__1.LocalPlayer;
end;
local u1 = l__LocalPlayer__4:GetMouse();
local l__CameraInput__5 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUI__6 = require(script.Parent:WaitForChild("CameraUI"));
local u2 = false;
local u3 = tick();
local u4 = false;
local u5 = false;
local u6 = false;
l__CameraUI__6.setCameraModeToastEnabled(false);
return function(p7) --[[ Line: 27 ]]
    -- upvalues: l__CameraInput__5 (copy), u2 (ref), u4 (ref), u3 (ref), l__CameraUI__6 (copy), u6 (ref), u5 (ref), u1 (copy), l__UserInputService__2 (copy), l__UserGameSettings__3 (copy)
    local v8 = l__CameraInput__5.getTogglePan();
    if p7 and v8 ~= u2 then
        u4 = true;
    end;
    if u2 ~= v8 or tick() - u3 > 3 then
        local v9;
        if v8 then
            v9 = tick() - u3 < 3;
        else
            v9 = v8;
        end;
        l__CameraUI__6.setCameraModeToastOpen(v9);
        if v8 then
            u4 = false;
        end;
        u3 = tick();
        u2 = v8;
    end;
    if p7 ~= u6 then
        if p7 then
            u5 = l__CameraInput__5.getTogglePan();
            l__CameraInput__5.setTogglePan(true);
        elseif not u4 then
            l__CameraInput__5.setTogglePan(u5);
        end;
    end;
    if p7 then
        if l__CameraInput__5.getTogglePan() then
            u1.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png";
            l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCenter;
            l__UserGameSettings__3.RotationType = Enum.RotationType.CameraRelative;
        else
            u1.Icon = "";
            l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
            l__UserGameSettings__3.RotationType = Enum.RotationType.CameraRelative;
        end;
    elseif l__CameraInput__5.getTogglePan() then
        u1.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png";
        l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCenter;
        l__UserGameSettings__3.RotationType = Enum.RotationType.MovementRelative;
    elseif l__CameraInput__5.getHoldPan() then
        u1.Icon = "";
        l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
        l__UserGameSettings__3.RotationType = Enum.RotationType.MovementRelative;
    else
        u1.Icon = "";
        l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
        l__UserGameSettings__3.RotationType = Enum.RotationType.MovementRelative;
    end;
    u6 = p7;
end;
