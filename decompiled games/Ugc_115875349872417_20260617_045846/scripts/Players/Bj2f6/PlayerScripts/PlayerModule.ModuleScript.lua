-- Decompiled from: Players.Bj2f6.PlayerScripts.PlayerModule
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.cameras = require(script:WaitForChild("CameraModule"));
    return v2;
end;
function u1.GetCameras(p3) --[[ Line: 18 ]]
    return p3.cameras;
end;
function u1.GetControls(p4) --[[ Line: 22 ]]
    return p4.controls;
end;
function u1.GetClickToMoveController(p5) --[[ Line: 26 ]]
    return p5.controls:GetClickToMoveController();
end;
return u1.new();
