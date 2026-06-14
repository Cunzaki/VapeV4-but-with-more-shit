-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.RemoveHammer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("Locomotion");
local u1 = l__Mince__2:Get("ToolHandler");
local u6 = {
    Tags = { "RemoveHammer" },
    Equipped = function(p2) --[[ Name: Equipped, Line 17 ]]
        -- upvalues: l__Mince__2 (copy)
        if l__Mince__2.Config.Humanoid then
            p2.Animations = {};
            p2.AnimationFolder = p2.Tool:FindFirstChild("Animations");
            for _, v3 in p2.AnimationFolder:GetChildren() do
                p2.Animations[v3.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v3);
            end;
            p2.Animations.Idle:Play();
            p2.Animations.Action:AdjustSpeed(3);
        end;
    end,
    Unequipped = function(p4) --[[ Name: Unequipped, Line 29 ]]
        for _, v5 in p4.Animations do
            v5:Stop();
        end;
    end
};
function u6.Setup() --[[ Line: 35 ]]
    -- upvalues: u1 (copy), u6 (copy)
    u1.Component(u6);
end;
return u6;
