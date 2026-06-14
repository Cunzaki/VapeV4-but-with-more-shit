-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Controller.SmoothLocomotionController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__BaseController__1 = require(script.Parent:WaitForChild("BaseController"));
local u1 = {};
u1.__index = u1;
setmetatable(u1, l__BaseController__1);
function u1.new() --[[ Line: 18 ]]
    -- upvalues: l__BaseController__1 (copy), u1 (copy)
    local v2 = l__BaseController__1.new();
    return setmetatable(v2, u1);
end;
function u1.Enable(p3) --[[ Line: 25 ]]
    -- upvalues: l__BaseController__1 (copy)
    l__BaseController__1.Enable(p3);
    p3.JoystickState = {
        Thumbstick = Enum.KeyCode.Thumbstick2
    };
end;
function u1.Disable(p4) --[[ Line: 33 ]]
    -- upvalues: l__BaseController__1 (copy)
    l__BaseController__1.Disable(p4);
    p4.JoystickState = nil;
end;
function u1.UpdateCharacter(p5) --[[ Line: 41 ]]
    -- upvalues: l__BaseController__1 (copy)
    l__BaseController__1.UpdateCharacter(p5);
    if p5.Character then
        local v6, _, v7 = p5:GetJoystickState(p5.JoystickState);
        p5:UpdateRotating(Enum.UserCFrame.RightHand, v6, v7);
    end;
end;
return u1;
