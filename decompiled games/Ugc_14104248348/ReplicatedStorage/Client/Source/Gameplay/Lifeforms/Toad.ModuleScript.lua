-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.Toad
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local v1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "Toad"
});
function v1.Construct(p2) --[[ Line: 11 ]]
    p2.Instance.Humanoid.Animator:LoadAnimation(p2.Instance.Humanoid.Animation):Play();
end;
return v1;
