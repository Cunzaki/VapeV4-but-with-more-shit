-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.ShackDoorSecret
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Players");
game:GetService("CollectionService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:GetEvent("ShackDoorEvent");
local u2 = l__Mince__3:Get("SelectInteractor");
l__Mince__3:Get("SoundHandler");
local v3 = {};
local u4 = l__Mince__3.Component({
    Tag = "ShackDoorSecret",
    TweenDoor1 = TweenInfo.new(2, Enum.EasingStyle.Quint),
    ButtonTween = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true)
});
function u4.ToggleRoomOpen(p5, p6) --[[ Line: 27 ]]
    if p6 then
        p5.Tweens.Open:Play();
        p5.Instance.Door.DoorOpen:Play();
    else
        if not p6 then
            p5.Tweens.Close:Play();
            p5.Instance.Door.DoorClose:Play();
        end;
    end;
end;
function u4.Construct(p7) --[[ Line: 37 ]]
    -- upvalues: l__TweenService__2 (copy), u1 (copy), u2 (copy)
    local v8 = p7.Instance.Buttons:GetChildren();
    local l__Door__4 = p7.Instance.Door;
    p7.Tweens = {
        Open = l__TweenService__2:Create(l__Door__4, p7.TweenDoor1, {
            Position = p7.Instance.Pos2.Position
        }),
        Close = l__TweenService__2:Create(l__Door__4, p7.TweenDoor1, {
            Position = p7.Instance.Pos1.Position
        })
    };
    for _, u9 in v8 do
        local v10 = {
            HoverName = "Push Button",
            Name = "Push Button",
            Model = u9,
            Target = u9,
            HitCollider = u9.PrimaryPart
        };
        local u11 = l__TweenService__2:Create(u9.PrimaryPart, p7.ButtonTween, {
            CFrame = u9.PrimaryPart.CFrame * CFrame.new((Vector3.new(0, -u9.PrimaryPart.Size.Y / 2, 0)))
        });
        function v10.Interact(_, p12) --[[ Line: 59 ]]
            -- upvalues: u9 (copy), u11 (copy), u1 (ref)
            u9.PrimaryPart.Press:Play();
            u11:Play();
            u1:Fire();
            p12();
        end;
        u2.NewInteractionClass(v10);
    end;
end;
function v3.Setup() --[[ Line: 71 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Event:Connect(function(...) --[[ Line: 72 ]]
        -- upvalues: u4 (ref)
        u4:GetAll()[1]:ToggleRoomOpen(...);
    end);
end;
return v3;
