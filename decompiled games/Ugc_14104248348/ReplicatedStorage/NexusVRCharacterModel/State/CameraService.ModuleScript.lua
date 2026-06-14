-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.CameraService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent;
local l__CommonCamera__2 = require(l__Parent__1:WaitForChild("Character"):WaitForChild("Camera"):WaitForChild("CommonCamera"));
local l__DefaultCamera__3 = require(l__Parent__1:WaitForChild("Character"):WaitForChild("Camera"):WaitForChild("DefaultCamera"));
local l__ThirdPersonTrackCamera__4 = require(l__Parent__1:WaitForChild("Character"):WaitForChild("Camera"):WaitForChild("ThirdPersonTrackCamera"));
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new() --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l__DefaultCamera__3 (copy), l__ThirdPersonTrackCamera__4 (copy), l__CommonCamera__2 (copy)
    local v3 = setmetatable({
        RegisteredCameras = {}
    }, u1);
    v3:RegisterCamera("Default", (l__DefaultCamera__3.new()));
    v3:RegisterCamera("ThirdPersonTrack", (l__ThirdPersonTrackCamera__4.new()));
    v3:RegisterCamera("Disabled", (l__CommonCamera__2.new()));
    return v3;
end;
function u1.GetInstance() --[[ Line: 48 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.RegisterCamera(p4, p5, p6) --[[ Line: 58 ]]
    p4.RegisteredCameras[p5] = p6;
end;
function u1.SetActiveCamera(p7, p8) --[[ Line: 65 ]]
    if p7.ActiveCamera == p8 then
    else
        p7.ActiveCamera = p8;
        if p7.CurrentCamera then
            p7.CurrentCamera:Disable();
        end;
        p7.CurrentCamera = p7.RegisteredCameras[p8];
        if p7.CurrentCamera then
            p7.CurrentCamera:Enable();
        else
            if p8 ~= nil then
                warn((`Nexus VR Character Model camera "{p8}" is not registered.`));
            end;
        end;
    end;
end;
function u1.UpdateCamera(p9, p10) --[[ Line: 87 ]]
    if p9.CurrentCamera then
        p9.CurrentCamera:UpdateCamera(p10);
    end;
end;
return u1;
