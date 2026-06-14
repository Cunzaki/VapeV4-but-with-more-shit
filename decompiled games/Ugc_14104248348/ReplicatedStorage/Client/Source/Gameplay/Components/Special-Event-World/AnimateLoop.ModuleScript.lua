-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.AnimateLoop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("TriggerHandler");
local v2 = l__Mince__2.Component({
    Tag = "AnimateLoop",
    CreationParents = { workspace }
});
function v2.Construct(u3) --[[ Line: 14 ]]
    -- upvalues: u1 (copy)
    local l__Animations__3 = u3.Instance:WaitForChild("Animations");
    local l__Animator__4 = u3.Instance:WaitForChild("AnimationController"):WaitForChild("Animator");
    u3.Animations = {};
    for _, v4 in l__Animations__3:GetChildren() do
        u3.Animations[v4.Name] = l__Animator__4:LoadAnimation(v4);
    end;
    if u3.Animations.Loop then
        if u3.TiedToStoreTrigger then
            u3.Trigger = u1.GetTrigger("Store");
            u3.Trigger.Entered:Connect(function() --[[ Line: 33 ]]
                -- upvalues: u3 (copy)
                u3.Animations.Loop:Play();
            end);
            u3.Trigger.Leaved:Connect(function() --[[ Line: 37 ]]
                -- upvalues: u3 (copy)
                u3.Animations.Loop:Stop();
            end);
        else
            u3.Animations.Loop:Play();
        end;
    else
        warn("Could not find loop animation!");
        warn(u3.Instance:GetFullName());
    end;
end;
return v2;
