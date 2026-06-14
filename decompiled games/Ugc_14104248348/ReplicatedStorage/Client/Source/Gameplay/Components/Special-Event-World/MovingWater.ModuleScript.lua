-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.MovingWater
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local v1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "MovingWater"
});
function v1.Construct(u2) --[[ Line: 11 ]]
    task.spawn(function() --[[ Line: 12 ]]
        -- upvalues: u2 (copy)
        while true do
            for v3 = 1, 25 do
                if u2.Instance:IsA("Decal") then
                    u2.Instance.Texture = string.format("rbxasset://textures/water/normal_%02d.dds", v3);
                end;
                wait(0.07);
            end;
        end;
    end);
end;
return v1;
