-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction.Interactors.Kbbq_Drawer
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
    DirectionCancel = Vector3.new(0, 0, 1),
    HitSpeed = 20,
    Angle = 90,
    Tween = TweenInfo.new(0.5, Enum.EasingStyle.Linear),
    Tween2 = TweenInfo.new(0.5, Enum.EasingStyle.Linear),
    FastTween = TweenInfo.new(0.2, Enum.EasingStyle.Linear),
    DoorTweens = {
        TweenInfo.new(0.5, Enum.EasingStyle.Linear),
        TweenInfo.new(0.5, Enum.EasingStyle.Linear),
        TweenInfo.new(0.5, Enum.EasingStyle.Linear),
        TweenInfo.new(0.2, Enum.EasingStyle.Linear)
    }
};
function u2.CloseDoor(p3, _) --[[ Line: 30 ]]
    -- upvalues: l__ModelTweenOG__3 (copy), u2 (copy)
    l__ModelTweenOG__3.new(p3.Item, u2.Tween, p3.ClosedDoorPivot).Play();
    p3.DoorState = "Closed";
end;
function u2.OpenDoor(p4, _) --[[ Line: 38 ]]
    -- upvalues: u2 (copy), l__ModelTweenOG__3 (copy)
    local _ = p4.Config.Direction;
    if p4.DoorState == "Closed" then
        local v5 = u2.DoorTweens[p4.Config.Speed or 1];
        local _ = p4.ClosedDoorPivot;
        local v6 = p4.ClosedDoorPivot:ToWorldSpace(CFrame.new(0, -1.308, 0));
        l__ModelTweenOG__3.new(p4.Item, v5, v6).Play();
    end;
end;
function u2.ConfigChanged(p7, p8) --[[ Line: 53 ]]
    if p8 == "DoorOpen" then
        if p7.Config.DoorOpen then
            p7:OpenDoor(p7.Config.Direction);
            return;
        end;
        p7:CloseDoor(p7.Config.Direction);
    end;
end;
function u2.Created(p9) --[[ Line: 63 ]]
    -- upvalues: u1 (copy), u2 (copy)
    p9.HitCollider = p9.Item:WaitForChild("Target");
    p9.Target = p9.Item;
    p9.HoverName = p9.Config.Name or "Config.Name";
    function p9.Interact(p10, p11) --[[ Line: 68 ]]
        p10.Request("DrawerOpen");
        p11();
    end;
    u1.NewInteractionClass(p9);
    p9.Angle = u2.Angle;
    p9.Config.DoorCanOpen = true;
    p9.ClosedDoorPivot = p9.Item:GetPivot();
    p9.DoorState = "Closed";
    p9.OpenDoor = u2.OpenDoor;
    p9.CloseDoor = u2.CloseDoor;
end;
return u2;
