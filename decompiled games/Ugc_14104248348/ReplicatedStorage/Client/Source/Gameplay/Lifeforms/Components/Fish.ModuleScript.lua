-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.Components.Fish
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local v1 = l__Mince__2.Component({
    Tag = "Fish"
});
local u2 = l__Mince__2:Get("TriggerHandler");
function v1.Construct(u3) --[[ Line: 8 ]]
    -- upvalues: u2 (copy)
    local v4 = script.Handler:Clone();
    local v5 = Instance.new("Actor");
    v5.Parent = u3.Instance;
    v4.Parent = v5;
    v4.Enabled = true;
    u3.Trigger = u2.GetTrigger("Aquarium");
    u3.Trigger.Entered:Connect(function() --[[ Line: 17 ]]
        -- upvalues: u3 (copy)
        u3.Instance:SetAttribute("Active", true);
    end);
    u3.Trigger.Exited:Connect(function() --[[ Line: 21 ]]
        -- upvalues: u3 (copy)
        u3.Instance:SetAttribute("Active", false);
    end);
    u3.Instance:SetAttribute("Active", false);
end;
return v1;
