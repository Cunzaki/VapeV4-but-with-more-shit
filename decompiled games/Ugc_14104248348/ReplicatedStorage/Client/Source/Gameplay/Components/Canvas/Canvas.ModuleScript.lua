-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Canvas.Canvas
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("PaintScreen");
local u2 = l__Mince__2:Get("SelectInteractor");
local v3 = l__Mince__2.Component({
    Tag = "Canvas"
});
function v3.Construct(u4) --[[ Line: 15 ]]
    -- upvalues: u1 (copy), u2 (copy)
    u4.HoverName = "Open Canvas";
    u4.Target = u4.Instance;
    u4.HitCollider = u4.Instance:WaitForChild("Collider");
    function u4.Interact(_, p5) --[[ Line: 20 ]]
        -- upvalues: u1 (ref)
        p5();
        u1.Trigger();
    end;
    u2.NewInteractionClass(u4);
    u4.SurfaceGui = u4.Instance:WaitForChild("SurfaceGui");
    u1:ThisDrawingAnFuture(function(p6) --[[ Line: 29 ]]
        -- upvalues: u4 (copy)
        u4.SurfaceGui.Content.ImageContent = p6;
    end);
end;
function v3.Removing(p7) --[[ Line: 34 ]]
    -- upvalues: u2 (copy)
    u2.CollapseClass(p7);
end;
return v3;
