-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction.Interactors.Manhole
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__3 = require(game.ReplicatedStorage.Modules.ModelTweenOG);
l__Mince__2:Get("SoundHandler");
local u1 = l__Mince__2:Get("SelectInteractor");
local u2 = {
    MoveTween = TweenInfo.new(1, Enum.EasingStyle.Quad)
};
function u2.CloseDoor(p3) --[[ Line: 18 ]]
    -- upvalues: l__ModelTweenOG__3 (copy), u2 (copy)
    l__ModelTweenOG__3.new(p3.Cover, u2.MoveTween, p3.ClosedDoorPivot).Play();
end;
function u2.OpenDoor(p4) --[[ Line: 23 ]]
    -- upvalues: l__ModelTweenOG__3 (copy), u2 (copy)
    l__ModelTweenOG__3.new(p4.Cover, u2.MoveTween, p4.ClosedDoorPivot:ToWorldSpace(CFrame.new(6, 0.4, 0))).Play();
end;
function u2.ConfigChanged(p5, p6) --[[ Line: 30 ]]
    if p6 == "DoorOpen" then
        if p5.Config.DoorOpen then
            p5:OpenDoor(p5.Config.Direction);
            return;
        end;
        p5:CloseDoor(p5.Config.Direction);
    end;
end;
function u2.Created(p7) --[[ Line: 40 ]]
    -- upvalues: u1 (copy), u2 (copy)
    p7.Cover = p7.Item:WaitForChild("Cover");
    p7.HitCollider = p7.Cover:WaitForChild("Collider");
    p7.Target = p7.Cover;
    p7.HoverName = "Manhole";
    function p7.Interact(p8, p9) --[[ Line: 48 ]]
        p8.Request("ToggleDoor");
        p9();
    end;
    u1.NewInteractionClass(p7);
    p7.ClosedDoorPivot = p7.Cover:GetPivot();
    p7.OpenDoor = u2.OpenDoor;
    p7.CloseDoor = u2.CloseDoor;
end;
return u2;
