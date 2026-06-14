-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.Koi
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local v1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "Koi"
});
function lerp(p2, p3, p4)
    return p2 + (p3 - p2) * p4;
end;
function v1.Construct(p5) --[[ Line: 14 ]]
    local v6 = p5.Instance:GetChildren();
    for v7, v8 in pairs(v6) do
        local v9 = Instance.new("Animation");
        v9.AnimationId = "rbxassetid://15897523682";
        local v10 = v8.AnimationController:LoadAnimation(v9);
        v10.Looped = true;
        v10:Play();
        task.wait();
        v10.TimePosition = lerp(0, v10.Length, (v7 - 1) / 3);
    end;
end;
return v1;
