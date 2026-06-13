-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Core.PlaceSurface
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("PlacementHandler");
local v2 = l__Mince__2.Component({
    Tag = "PlaceSurface"
});
function v2.Removing(p3) --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    u1.RemovePlaceSurface(p3.Instance);
end;
function v2.Construct(p4) --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    u1.AddPlaceSurface(p4.Instance);
end;
return v2;
