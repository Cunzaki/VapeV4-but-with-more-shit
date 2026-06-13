-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Folder.ClientEnterBox
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("TriggerHandler");
local u2 = l__Mince__2:GetEvent("CheckEnterBox");
local v3 = l__Mince__2.Component({
    Tag = "ClientEnterBox"
});
function v3.Construct(p4) --[[ Line: 13 ]]
    -- upvalues: u1 (copy), u2 (copy)
    p4.Trigger = u1.TriggerFromPart(p4.Instance);
    p4.Trigger.Entered:Connect(function() --[[ Line: 15 ]]
        -- upvalues: u2 (ref)
        task.defer(function() --[[ Line: 16 ]]
            -- upvalues: u2 (ref)
            u2:Fire();
        end);
    end);
    p4.Trigger.Exited:Connect(function() --[[ Line: 20 ]]
        -- upvalues: u2 (ref)
        u2:Fire();
    end);
end;
return v3;
