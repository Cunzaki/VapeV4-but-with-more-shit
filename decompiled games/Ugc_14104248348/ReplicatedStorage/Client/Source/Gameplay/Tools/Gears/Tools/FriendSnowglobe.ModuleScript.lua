-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.FriendSnowglobe
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Debris");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.SpringVector3);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:GetEvent("ChangeFriendSnowglobe");
local u3 = {
    Tags = { "FriendSnowglobe" },
    Animations = {}
};
function u3.Setup() --[[ Line: 18 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.Component(u3);
end;
function u3.Equipped(_) --[[ Line: 22 ]]
    -- upvalues: u2 (copy)
    u2:Fire();
end;
return u3;
