-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.KeypadDoor
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("TriggerHandler");
local u2 = l__Mince__3:GetEvent("InteractKeypadDoor");
local v3 = l__Mince__3.Component({
    Tag = "KeypadDoor",
    Tween = TweenInfo.new(0.5)
});
function v3.ReactToOpenState(p4) --[[ Line: 19 ]]
    if p4.Open and p4.Door.Position ~= p4.RisedPosition then
        p4.Door.Open:Play();
        p4.Tweens.Open:Play();
        p4.Tweens.Open.Completed:Wait();
        p4.Door.Open:Stop();
        p4.Door.Close:Play();
    else
        if not p4.Open and p4.Door.Position ~= p4.OGPosition then
            p4.Door.Open:Play();
            p4.Tweens.Close:Play();
            p4.Tweens.Close.Completed:Wait();
            p4.Door.Open:Stop();
            p4.Door.Close:Play();
        end;
    end;
end;
function v3.Construct(u5) --[[ Line: 35 ]]
    -- upvalues: l__TweenService__2 (copy), u1 (copy), u2 (copy)
    u5.Door = u5.Instance:WaitForChild("Door");
    u5.OGPosition = u5.Door.Position;
    u5.RisedPosition = u5.OGPosition + Vector3.new(0, 1, 0) * u5.Door.Size.Y;
    u5.Tweens = {
        Open = l__TweenService__2:Create(u5.Door, u5.Tween, {
            Position = u5.RisedPosition
        }),
        Close = l__TweenService__2:Create(u5.Door, u5.Tween, {
            Position = u5.OGPosition
        })
    };
    u5.ExitTrigger = u1.TriggerFromPart(u5.Instance.ExitTrigger);
    u5.ExitTrigger.Entered:Connect(function() --[[ Line: 51 ]]
        -- upvalues: u2 (ref), u5 (copy)
        u2:Fire(u5.Instance);
    end);
    u5:ReactToOpenState();
    u5.Instance:GetAttributeChangedSignal("Open"):Connect(function() --[[ Line: 56 ]]
        -- upvalues: u5 (copy)
        u5:ReactToOpenState();
    end);
end;
return v3;
