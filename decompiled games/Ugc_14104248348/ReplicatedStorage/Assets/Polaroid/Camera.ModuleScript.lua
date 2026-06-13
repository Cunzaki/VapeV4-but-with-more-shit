-- Decompiled from: ReplicatedStorage.Assets.Polaroid.Camera
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Camera__1 = game.Workspace.Camera;
local v1 = {};
v1.ButtonFunctions = {
    Fov = {
        IsMenu = true,
        MenuType = "Slider",
        MenuTitle = "Field of View",
        MenuValueChanged = v1.SetFov
    }
};
function v1.SetFov(p2) --[[ Line: 16 ]]
    -- upvalues: l__Camera__1 (copy)
    l__Camera__1.FieldOfView = p2 * 180;
end;
return v1;
