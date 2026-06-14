-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Tools.Firecracker
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:GetEvent("Firecracker");
local u3 = {
    Tags = { "Firecracker" },
    Animations = {},
    Activate = function(_, _) --[[ Name: Activate, Line 15 ]]
        -- upvalues: u2 (copy)
        u2:Fire();
        return "Sink";
    end
};
function u3.Setup() --[[ Line: 20 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.Component(u3);
end;
return u3;
