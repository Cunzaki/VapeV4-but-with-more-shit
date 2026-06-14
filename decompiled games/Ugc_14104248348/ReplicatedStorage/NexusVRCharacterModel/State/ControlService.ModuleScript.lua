-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.ControlService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent;
local l__BaseController__2 = require(l__Parent__1:WaitForChild("Character"):WaitForChild("Controller"):WaitForChild("BaseController"));
local l__TeleportController__3 = require(l__Parent__1:WaitForChild("Character"):WaitForChild("Controller"):WaitForChild("TeleportController"));
local l__SmoothLocomotionController__4 = require(l__Parent__1:WaitForChild("Character"):WaitForChild("Controller"):WaitForChild("SmoothLocomotionController"));
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new() --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l__BaseController__2 (copy), l__TeleportController__3 (copy), l__SmoothLocomotionController__4 (copy)
    local v3 = setmetatable({
        RegisteredControllers = {}
    }, u1);
    local v4 = l__BaseController__2.new();
    v4.ActionsToLock = {
        Enum.KeyCode.Thumbstick1,
        Enum.KeyCode.Thumbstick2,
        Enum.KeyCode.ButtonR3,
        Enum.KeyCode.ButtonA
    };
    v3:RegisterController("None", v4);
    v3:RegisterController("Teleport", (l__TeleportController__3.new()));
    v3:RegisterController("SmoothLocomotion", (l__SmoothLocomotionController__4.new()));
    return v3;
end;
function u1.GetInstance() --[[ Line: 50 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.RegisterController(p5, p6, p7) --[[ Line: 60 ]]
    p5.RegisteredControllers[p6] = p7;
end;
function u1.SetActiveController(p8, p9) --[[ Line: 67 ]]
    if p8.ActiveController == p9 then
    else
        p8.ActiveController = p9;
        if p8.CurrentController then
            p8.CurrentController:Disable();
        end;
        p8.CurrentController = p8.RegisteredControllers[p9];
        if p8.CurrentController then
            p8.CurrentController:Enable();
        else
            if p9 ~= nil then
                warn((`Nexus VR Character Model controller "{p9}" is not registered.`));
            end;
        end;
    end;
end;
function u1.UpdateCharacter(p10) --[[ Line: 89 ]]
    if p10.CurrentController then
        p10.CurrentController:UpdateCharacter();
    end;
end;
return u1;
