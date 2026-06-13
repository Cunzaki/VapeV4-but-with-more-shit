-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Camera.CommonCamera
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__VRService__2 = game:GetService("VRService");
local u1 = require(script.Parent.Parent.Parent:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local u2 = {};
u2.__index = u2;
function u2.new() --[[ Line: 20 ]]
    -- upvalues: u2 (copy)
    return setmetatable({}, u2);
end;
function u2.Enable(_) --[[ Line: 27 ]] end;
function u2.Disable(_) --[[ Line: 34 ]] end;
function u2.UpdateCamera(_, _) --[[ Line: 41 ]] end;
function u2.SetCFrame(_, p3) --[[ Line: 48 ]]
    -- upvalues: l__Workspace__1 (copy), u1 (copy), l__VRService__2 (copy)
    local l__CurrentCamera__3 = l__Workspace__1.CurrentCamera;
    if u1:GetSetting("Camera.DisableHeadLocked") ~= false then
        l__CurrentCamera__3.HeadLocked = false;
    end;
    if l__CurrentCamera__3.HeadLocked then
        local v4 = l__VRService__2:GetUserCFrame(Enum.UserCFrame.Head);
        p3 = p3 * (CFrame.new(v4.Position * (l__Workspace__1.CurrentCamera.HeadScale - 1)) * v4):Inverse();
        l__CurrentCamera__3.VRTiltAndRollEnabled = true;
    end;
    l__CurrentCamera__3.CameraType = Enum.CameraType.Scriptable;
    l__CurrentCamera__3.CFrame = p3;
    l__CurrentCamera__3.Focus = p3;
end;
return u2;
