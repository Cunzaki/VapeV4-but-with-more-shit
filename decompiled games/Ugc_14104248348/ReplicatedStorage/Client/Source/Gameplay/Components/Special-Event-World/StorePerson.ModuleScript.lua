-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.StorePerson
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Queue__3 = require(l__ReplicatedStorage__1.Modules.Queue);
l__Mince__2:Get("BindManager");
l__Mince__2:Get("SoundHandler");
local u1 = l__Mince__2:Get("TriggerHandler");
l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("SelectInteractor");
local v2 = l__Mince__2.Component({
    Tag = "StorePerson"
});
function v2.Construct(u3) --[[ Line: 19 ]]
    -- upvalues: l__Queue__3 (copy), u1 (copy)
    u3.Humanoid = u3.Instance:WaitForChild("Humanoid");
    u3.Animations = {};
    l__Queue__3.new();
    u3.AnimationQueue = l__Queue__3.new();
    u3.AnimationQueue:RunPushedFunctions();
    for _, v4 in u3.Instance:WaitForChild("Animations"):GetChildren() do
        u3.Animations[v4.Name] = u3.Humanoid:LoadAnimation(v4);
    end;
    u3.Animations.ShopIdle:Play();
    local v5 = u1.GetTrigger(u3.TriggerName);
    v5.Leaved:Connect(function() --[[ Line: 36 ]]
        -- upvalues: u3 (copy)
        u3.AnimationQueue:Push(function() --[[ Line: 37 ]]
            -- upvalues: u3 (ref)
            u3.Animations.ShopDeactivate:Play();
            u3.Animations.ShopActivatedIdle:Stop();
            u3.Animations.ShopDeactivate.Stopped:Wait();
            u3.Animations.ShopIdle:Play();
        end);
    end);
    v5.Entered:Connect(function() --[[ Line: 45 ]]
        -- upvalues: u3 (copy)
        u3.AnimationQueue:Push(function() --[[ Line: 46 ]]
            -- upvalues: u3 (ref)
            u3.Animations.ShopActivate:Play();
            u3.Animations.ShopIdle:Stop();
            u3.Animations.ShopActivate.Stopped:Wait();
            u3.Animations.ShopActivatedIdle:Play();
        end);
    end);
end;
return v2;
