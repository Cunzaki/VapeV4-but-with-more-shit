-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.KickableSnowman
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Numerics);
l__Mince__2:Get("BindManager");
l__Mince__2:Get("SoundHandler");
l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("Locomotion");
l__Mince__2:Get("SelectInteractor");
local u1 = l__Mince__2:GetEvent("KickSnowman");
local u2 = l__Mince__2.Component({
    Tag = "KickableSnowman",
    Kicking = false
});
function u2.Construct(p3) --[[ Line: 20 ]]
    -- upvalues: l__Mince__2 (copy), u2 (copy), u1 (copy)
    local v4 = p3.Instance:FindFirstChildOfClass("ProximityPrompt") or Instance.new("ProximityPrompt");
    v4:SetAttribute("Type", "Radial");
    v4:SetAttribute("SizeMultipler", 1);
    v4.ObjectText = "Kick";
    v4.MaxActivationDistance = 8;
    v4.Style = Enum.ProximityPromptStyle.Custom;
    v4.Parent = p3.Instance;
    v4.RequiresLineOfSight = false;
    task.wait(1);
    v4.Triggered:Connect(function() --[[ Line: 32 ]]
        -- upvalues: l__Mince__2 (ref), u2 (ref), u1 (ref)
        if l__Mince__2.Config.Humanoid and not u2.Kicking then
            local v5 = l__Mince__2.Config.Humanoid:LoadAnimation(u2.Anim);
            v5.Looped = false;
            u2.Kicking = true;
            l__Mince__2.Config.HumanoidRootPart.Anchored = true;
            task.delay(v5.Length / 3, function() --[[ Line: 39 ]]
                -- upvalues: l__Mince__2 (ref), u2 (ref)
                l__Mince__2.Config.HumanoidRootPart.Anchored = false;
                u2.Kicking = false;
            end);
            v5:Play();
            v5:AdjustSpeed(3);
            task.wait(0.1);
            u1:Fire();
        end;
    end);
end;
function u2.Setup() --[[ Line: 51 ]]
    -- upvalues: u2 (copy), l__ReplicatedStorage__1 (copy)
    u2.Anim = l__ReplicatedStorage__1.Assets.Misc:WaitForChild("KickSnowman");
end;
return u2;
