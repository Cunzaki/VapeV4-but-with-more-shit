-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.NoteBoardItem
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("NoteBoard");
local u2 = l__Mince__2:Get("SelectInteractor");
local v3 = l__Mince__2.Component({
    Tag = "NoteBoard"
});
function v3.Construct(p4) --[[ Line: 13 ]]
    -- upvalues: u1 (copy), u2 (copy)
    p4.HoverName = "Global Note Board";
    p4.HitCollider = p4.Instance:WaitForChild("Collider");
    p4.Target = p4.Instance;
    function p4.Interact(_, p5) --[[ Line: 18 ]]
        -- upvalues: u1 (ref)
        p5();
        u1.Trigger();
    end;
    u2.NewInteractionClass(p4);
end;
return v3;
