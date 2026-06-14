-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.SnowmanDecoy
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
game:GetService("Debris");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("ToolHandler");
local u2 = l__Mince__3:GetEvent("SyncState");
l__Players__2.LocalPlayer:GetMouse();
local u3 = {
    Tags = { "SnowmanDecoy" },
    Animations = {}
};
function u3.Setup() --[[ Line: 20 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.Component(u3);
end;
function u3.Equipped(_) --[[ Line: 24 ]]
    -- upvalues: u2 (copy)
    u2:Fire("SnowmanDecoy", true);
end;
function u3.Unequipped(_) --[[ Line: 28 ]]
    -- upvalues: u2 (copy)
    u2:Fire("SnowmanDecoy", false);
end;
return u3;
