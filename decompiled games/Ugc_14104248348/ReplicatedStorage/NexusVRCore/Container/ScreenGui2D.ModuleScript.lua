-- Decompiled from: ReplicatedStorage.NexusVRCore.Container.ScreenGui2D
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__NexusInstance__1 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local l__BaseScreenGui__2 = require(script.Parent:WaitForChild("BaseScreenGui"));
local v1 = {
    ClassName = "ScreenGui2D"
};
v1.__index = v1;
setmetatable(v1, l__BaseScreenGui__2);
function v1.__new(p2) --[[ Line: 20 ]]
    -- upvalues: l__BaseScreenGui__2 (copy)
    l__BaseScreenGui__2.__new(p2, Instance.new("ScreenGui"));
end;
function v1.IsA(p3, p4) --[[ Line: 28 ]]
    -- upvalues: l__BaseScreenGui__2 (copy)
    return l__BaseScreenGui__2.IsA(p3, p4) or p4 == "ScreenGui2D";
end;
return l__NexusInstance__1.ToInstance(v1);
