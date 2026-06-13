-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.ZowieSecret
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
local u1 = l__Mince__3:GetEvent("ZowieEvent");
local u2 = l__Mince__3:Get("SelectInteractor");
l__Mince__3:Get("SoundHandler");
local l__ModelTweenOG__4 = require(game.ReplicatedStorage.Modules.ModelTweenOG);
local v3 = {
    OrderBuffer = {}
};
local u4 = false;
local u5 = l__Mince__3.Component({
    Tag = "ZowieAppartmentSecret",
    TweenDoor1 = TweenInfo.new(0.4, Enum.EasingStyle.Quint),
    TweenDoor2 = TweenInfo.new(1, Enum.EasingStyle.Bounce),
    TweenLadder = TweenInfo.new(2, Enum.EasingStyle.Linear),
    ButtonTween = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true)
});
function u5.ToggleRoomOpen(p6, p7) --[[ Line: 33 ]]
    -- upvalues: u4 (ref)
    p6.Instance.Door.Door.CanCollide = not p7;
    if p7 and not u4 then
        u4 = true;
        p6.ModelTweens.Door.Open.Play();
        task.wait(0.3);
        p6.ModelTweens.Ladder.Down.Play();
        p6.Instance.Ladder.Truss.Sound:Play();
        task.wait(2);
        p6.Instance.Ladder.Truss.Sound:Stop();
    else
        if not p7 then
            p6.ModelTweens.Ladder.Up.Play();
            p6.Instance.Ladder.Truss.Sound:Play();
            task.wait(2);
            p6.ModelTweens.Door.Close.Play();
            p6.Instance.Ladder.Truss.Sound:Stop();
            u4 = false;
        end;
    end;
end;
function u5.Construct(p8) --[[ Line: 57 ]]
    -- upvalues: l__ModelTweenOG__4 (copy), l__TweenService__2 (copy), u1 (copy), u4 (ref), u2 (copy)
    local v9 = p8.Instance.Buttons:GetChildren();
    local l__Ladder__5 = p8.Instance.Ladder;
    local l__Door__6 = p8.Instance.Door;
    p8.ModelTweens = {
        Door = {
            Close = l__ModelTweenOG__4.new(l__Door__6, p8.TweenDoor2, l__Door__6:GetPivot(), true),
            Open = l__ModelTweenOG__4.new(l__Door__6, p8.TweenDoor1, l__Door__6:GetPivot() * CFrame.fromOrientation(1.7453292519943295, 0, 0), true)
        },
        Ladder = {
            Up = l__ModelTweenOG__4.new(l__Ladder__5, p8.TweenLadder, l__Ladder__5:GetPivot(), true),
            Down = l__ModelTweenOG__4.new(l__Ladder__5, p8.TweenLadder, l__Ladder__5:GetPivot() * CFrame.new(0, -23.169, 0), true)
        }
    };
    for _, u10 in v9 do
        local v11 = {
            HoverName = "Push Button",
            Name = "Push Button",
            Model = u10,
            Target = u10,
            HitCollider = u10.PrimaryPart
        };
        local u12 = l__TweenService__2:Create(u10.PrimaryPart, p8.ButtonTween, {
            CFrame = u10.PrimaryPart.CFrame * CFrame.new((Vector3.new(0, -u10.PrimaryPart.Size.Y / 2, 0)))
        });
        function v11.Interact(_, p13) --[[ Line: 86 ]]
            -- upvalues: u10 (copy), u12 (copy), u1 (ref), u4 (ref)
            u10.PrimaryPart.Press:Play();
            u12:Play();
            u1:Fire();
            if u4 then
                return p13();
            end;
            p13();
        end;
        u2.NewInteractionClass(v11);
    end;
end;
function v3.Setup() --[[ Line: 98 ]]
    -- upvalues: u1 (copy), u5 (copy)
    u1.Event:Connect(function(...) --[[ Line: 99 ]]
        -- upvalues: u5 (ref)
        u5:GetAll()[1]:ToggleRoomOpen(...);
    end);
end;
return v3;
