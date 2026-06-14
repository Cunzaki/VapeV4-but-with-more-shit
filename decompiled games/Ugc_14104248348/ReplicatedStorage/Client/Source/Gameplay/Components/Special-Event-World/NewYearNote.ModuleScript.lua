-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.NewYearNote
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
game:GetService("Debris");
local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
require(l__ReplicatedStorage__1.Modules:WaitForChild("Signal"));
l__Mince__4:Get("BindManager");
local u1 = l__Mince__4:Get("Notices");
l__Mince__4:Get("SoundHandler");
l__Mince__4:Get("InterfaceHandler");
l__Mince__4:Get("DrinkHandler");
local u2 = l__Mince__4:Get("SelectInteractor");
l__Mince__4:Get("OpeningHandler");
local u3 = l__Mince__4:GetFunction("InteractNewYearNote");
local v4 = l__Mince__4.Component({
    Tag = "NewYearNote"
});
function v4.Construct(p5) --[[ Line: 26 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u3 (copy), u1 (copy), u2 (copy)
    local l__Instance__5 = p5.Instance;
    u2.NewInteractionClass({
        MaxDistance = 5,
        HitCollider = l__Instance__5,
        Target = l__Instance__5,
        HoverName = "Place Note",
        Interact = function(_, p6) --[[ Name: Interact, Line 37 ]]
            -- upvalues: l__LocalPlayer__3 (ref), u3 (ref), l__Instance__5 (copy), u1 (ref)
            local v7, v8 = u3:Invoke(l__Instance__5, "PlaceNote", l__LocalPlayer__3.Backpack:FindFirstChild("Offering Tree Note") or l__LocalPlayer__3.Character:FindFirstChild("Offering Tree Note"));
            if not v7 then
                u1.Error(v8);
            end;
            p6();
        end
    });
end;
function v4.Setup() --[[ Line: 49 ]] end;
return v4;
