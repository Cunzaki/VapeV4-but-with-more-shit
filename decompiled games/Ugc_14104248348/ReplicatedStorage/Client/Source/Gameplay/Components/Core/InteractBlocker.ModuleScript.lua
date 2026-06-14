-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Core.InteractBlocker
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("SelectInteractor");
local v2 = l__Mince__2.Component({
    Tag = "InteractBlocker"
});
function v2.Construct(p3) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    u1.AddBlocker(p3.Instance);
end;
function v2.Removing(p4) --[[ Line: 16 ]]
    -- upvalues: u1 (copy)
    u1.RemoveBlocker(p4.Instance);
end;
return v2;
