-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction.Interactors.Swing_Door
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
    Tween = TweenInfo.new(1, Enum.EasingStyle.Bounce),
    Tween2 = TweenInfo.new(1, Enum.EasingStyle.Linear),
    FastTween = TweenInfo.new(0.2, Enum.EasingStyle.Bounce),
    DoorTweens = {
        TweenInfo.new(1, Enum.EasingStyle.Bounce),
        TweenInfo.new(0.8, Enum.EasingStyle.Bounce),
        TweenInfo.new(0.5, Enum.EasingStyle.Bounce),
        TweenInfo.new(0.2, Enum.EasingStyle.Bounce)
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
        if p4.Config.Type == "X" then
            local v5 = u2.DoorTweens[p4.Config.Speed or 1];
            local v6, v7, v8 = p4.ClosedDoorPivot:ToOrientation();
            local v9 = (math.deg(v6) + p4.Angle * p4.Config.AngleMult) % 360;
            local v10 = CFrame.new(p4.ClosedDoorPivot.Position) * CFrame.fromOrientation(math.rad(v9), v7, v8);
            l__ModelTweenOG__3.new(p4.Item, v5, v10).Play();
        elseif p4.Config.Type == "Z" then
            local v11 = u2.DoorTweens[p4.Config.Speed or 1];
            local v12, v13, v14 = p4.ClosedDoorPivot:ToOrientation();
            local v15 = (math.deg(v14) + p4.Angle * p4.Config.AngleMult) % 360;
            local v16 = CFrame.new(p4.ClosedDoorPivot.Position) * CFrame.fromOrientation(v12, v13, (math.rad(v15)));
            l__ModelTweenOG__3.new(p4.Item, v11, v16).Play();
        else
            local v17 = u2.DoorTweens[p4.Config.Speed or 1];
            local v18, v19, v20 = p4.ClosedDoorPivot:ToOrientation();
            local v21 = (math.deg(v19) + p4.Angle * p4.Config.AngleMult) % 360;
            local v22 = CFrame.new(p4.ClosedDoorPivot.Position) * CFrame.fromOrientation(v18, math.rad(v21), v20);
            l__ModelTweenOG__3.new(p4.Item, v17, v22).Play();
        end;
    end;
end;
function u2.ConfigChanged(p23, p24) --[[ Line: 75 ]]
    if p24 == "DoorOpen" then
        if p23.Config.DoorOpen then
            p23:OpenDoor(p23.Config.Direction);
            return;
        end;
        p23:CloseDoor(p23.Config.Direction);
    end;
end;
function u2.Created(p25) --[[ Line: 85 ]]
    -- upvalues: u1 (copy), u2 (copy)
    p25.HitCollider = p25.Item:WaitForChild("Target");
    p25.Target = p25.Item;
    p25.HoverName = p25.Config.Name or "Config.Name";
    function p25.Interact(p26, p27) --[[ Line: 90 ]]
        p26.Request("ToggleDoor");
        p27();
    end;
    u1.NewInteractionClass(p25);
    p25.Angle = u2.Angle;
    p25.Config.DoorCanOpen = true;
    p25.ClosedDoorPivot = p25.Item:GetPivot();
    p25.DoorState = "Closed";
    p25.OpenDoor = u2.OpenDoor;
    p25.CloseDoor = u2.CloseDoor;
end;
return u2;
